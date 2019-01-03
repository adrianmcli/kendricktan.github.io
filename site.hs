--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.List             (isInfixOf)
import           Data.Monoid           (mappend)
import           Hakyll
import           System.FilePath.Posix (replaceDirectory, splitFileName,
                                        takeBaseName, takeDirectory, (</>))


--------------------------------------------------------------------------------

--------------------------------------------------------------------------------

-- The functions in this section were borrowed from the Main.hs file of
-- https://github.com/mdgriffith/mechanical-elephant.

-- replace a foo/bar.md by foo/bar/index.html
-- this way the url looks like: foo/bar in most browsers
niceRoute :: Routes
niceRoute = customRoute createIndexRoute
  where
    createIndexRoute ident =
        takeDirectory (toFilePath ident) </> takeBaseName (toFilePath ident) </> "index.html"

baseRoute :: Routes
baseRoute = customRoute base
  where
    base ident = replaceDirectory (toFilePath ident) ""


niceBaseRoute :: Routes
niceBaseRoute = customRoute base
    where
      base ident = takeBaseName (toFilePath ident) </> "index.html"

-- replace url of the form foo/bar/index.html by foo/bar
removeIndexHtml :: Item String -> Compiler (Item String)
removeIndexHtml item = return $ fmap (withUrls removeIndexStr) item
  where
    removeIndexStr :: String -> String
    removeIndexStr url = case splitFileName url of
        (dir, "index.html") | isLocal dir -> dir
        _                   -> url
    isLocal :: [Char] -> Bool
    isLocal uri = not (isInfixOf "://" uri)


static :: Pattern -> Rules ()
static f = match f $ do
    route   idRoute
    compile copyFileCompiler

directory :: (Pattern -> Rules a) -> String -> Rules a
directory act f = act $ fromGlob $ f ++ "/**"

--------------------------------------------------------------------------------

main :: IO ()
main = hakyll $ do
    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "files/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "assets/**" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match "iframe/*.html" $ do
        route $ niceRoute
        compile copyFileCompiler
    
    match (fromList ["about.md", "talks.md", "projects.md"]) $ do
        route $ niceBaseRoute
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" siteCtx
            >>= relativizeUrls
            >>= removeIndexHtml

    match "posts/*.md" $ do
        route $ niceRoute
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/post.html"    siteCtx
            >>= saveSnapshot "content"
            >>= loadAndApplyTemplate "templates/default.html" siteCtx
            >>= relativizeUrls
            >>= removeIndexHtml

    match "templates/*" $ compile templateCompiler

    match "index.md" $ do
        route $ setExtension "html"
        compile $ do
            pandocCompiler
                >>= loadAndApplyTemplate "templates/default.html" siteCtx
                >>= relativizeUrls
    
    create ["posts/index.html"] $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*.md"
            let postsCtx = constField "title" "Posts" `mappend`
                    listField "posts" siteCtx (return posts) `mappend` siteCtx 

            makeItem ""
                >>= loadAndApplyTemplate "templates/post-list.html" postsCtx
                >>= saveSnapshot "content"
                >>= loadAndApplyTemplate "templates/default.html" postsCtx
                >>= relativizeUrls
                >>= removeIndexHtml

--------------------------------------------------------------------------------
siteCtx :: Context String
siteCtx =
    dateField "date" "%Y-%m-%d" `mappend`
    constField "google_analytics_tracking_id" "UA-71060764-2" `mappend`
    constField "disqus_sitename" "kendricktangithubio" `mappend`
    constField "sitewide_title" "Kendrick Tan" `mappend`
    constField "site_name" "kndrck.co" `mappend`
    constField "github_username" "kendricktan" `mappend`
    constField "linkedin_username" "tankendrick" `mappend`
    constField "twitter_handle" "kendricktrh" `mappend`
    constField "email" "me [at] kndrck.co" `mappend`
    defaultContext
