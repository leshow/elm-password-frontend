# elm-password-frontend

Contains:
* Dev server with live reloading, HMR
* Support for CSS/SCSS (with Autoprefixer), image assets
* Bootstrap 3.3+ (Sass version)
* Bundling and minification for deployment


### Install:
```
yarn install
elm package install -y
```

### Serve locally:
```
yarn start
```
* Access app at `http://localhost:8080/`
* Get coding! The entry point file is `src/elm/Main.elm`
* Browser will refresh automatically on any file changes..


### Build & bundle for prod:
```
yarn run build
```

* Files are saved into the `/dist` folder
* To check it, open `dist/index.html`
