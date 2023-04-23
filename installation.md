# Installation steps

Follow the next steps in order to have your site up and running

`mix.ex`

```elixir
defp deps() do
[
  {:palette, "~> 0.1.0"}
]

defp aliases do
[
  # add
  "assets.build": ["tailwind default", "esbuild default", "cmd npm install --prefix assets"],
]
```

```sh
mix deps.install
```

`.gitignore`

```
/assets/node_modules
```

`config.exs`

add `--external:/js/* --external:/css/*` to esbuild args

```elixir
config :esbuild,
  version: "0.17.11",
  default: [
    args: ~w(js/app.js
    --bundle
    --target=es2017
    --outdir=../priv/static/assets
    --external:/fonts/*
    --external:/images/*
    --external:/js/*
    --external:/css/*),
```

`lib/xxxxxx_web.ex`

- Add the container class (styles to add to the `<%= @inner_content %>` div)
- And the `use Palette` to html_helper

```elixir

  def live_view do
    quote do
      use Phoenix.LiveView,
        layout: {XxxxxxWeb.Layouts, :app},
        container: {:main, class: "main-content w-full px-[var(--margin-x)] pb-8"}

      unquote(html_helpers())
    end
  end


  defp html_helpers do
    quote do
      # ... other stuffs
      use Palette
      unquote(verified_routes())
    end
  end
```

`lib/xxxxxx_web/components/core_components.ex`

(We need to fix this but for now, remove)

- table
- button
- modal

`root.html.heex`

```html
<.html>
  <.head />
  <.body>
    <.preloader />
    <.page_wrapper>
      <%= @inner_content %>
    </.page_wrapper>
  </.body>
</.html>

```

In your page you can assign the `section` to show in the menus

`<.sidebar_panel :if={@section == :home} title="Home">`

```elixir

  alias Palette.Components.Breadcrumb.Step

  @impl true
  def mount(_params, session, socket) do
    {:ok, socket |> assign(:section, :home) |> assign_breadcrumb_steps()}
  end
```


Lastly copy some files (merge if you already have some)

```sh
.
├── assets
│   ├── css
│   │   └── app.css
│   ├── js
│   │   └── app.js
│   ├── package-lock.json
│   ├── package.json
│   ├── postcss.config.js
│   └── tailwind.config.js
├── lib
│   └── xxxxxx_web
│       └── components
│           └── layouts
│               └── live.html.heex
└── priv
    └── static
        ├── fonts
        │   └── fontawesome
        │       ├── fa-brands-400.ttf
        │       ├── fa-brands-400.woff2
        │       ├── fa-regular-400.ttf
        │       ├── fa-regular-400.woff2
        │       ├── fa-solid-900.ttf
        │       ├── fa-solid-900.woff2
        │       ├── fa-v4compatibility.ttf
        │       └── fa-v4compatibility.woff2
        └── images
            ├── default-project-avatar.png
            ├── default-user-avatar.jpg
            ├── logo-mid.png
            ├── logo.png
            └── logo.svg
```