defmodule Palette.Components.Editor do
  use Phoenix.Component

  alias Palette.Components.Input

  attr(:value, :string, required: true)
  attr(:mode, :atom, default: :html, values: [:html])

  @spec editor(map) :: Phoenix.LiveView.Rendered.t()
  def editor(assigns) do
    ~H"""
    <div id="editor" class="editor-parent" phx-update="ignore" phx-hook="editor" data-mode={@mode}>
      <div id="ace-editor" class="editor"><%= @value %></div>
    </div>
    <Input.hidden_input name="editor-content" value={@value} />
    """
  end
end
