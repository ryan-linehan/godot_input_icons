# godot_input_icons

A godot plugin for displaying keyboard and controller icons

## Completed

- InputIconTextureRect for displaying user registered actions as images
  - Supports keyboard modifiers for any combination of keys that can be registered in the input map
  - Integration with input_helper  [TODO: link input_helper ] for remapping
  
## In Progress

- Add 'device index' support + configuration warning if project setting to enable input_helper integration is not checked (OR only add it to the property list when the integration is enabled ++)

- When a plugin project setting input changes reload the icon rect / update texture if we can
- When the path for the default maps changes reload the icon rect / update text(or require editor restart?)
- plugin project settings 'category' and property descriptions
- Input remapper demo project + UI example (requires input_helper_adapter enablement)
- Complete TODOs or move into planned / future
- Update all code so that it is statically typed
- Rename plugin to match input_helper's naming convention

## Planned

- C# nuget package wrapper (if needed)
- Add the rest of the keys + add them to default maps
- Add the rest of joypad inputs + add them to default maps
- Add different icons for the different controller types
- Add more controller types

## Future

- TextureButton support for input icons (Is this useful?)
- Input combo texture rect (allows for chaining multiple actions into a single texture rect)
- InputLabel for displaying user registered actions as labels
- Translations module for keyboard icons for different languages
- Add texture button support?
- A input map viewer of the current setup of input icons over a controller
    / a keyboard with only the mapped keys put in place
- Options to use a font based system instead of images (an adapter for: )
- Add touch icon support (what does this look like exactly just a static image?)
- Screen reader support (can we do this in game and in editor?)
- Add SVG icon for plugin (maybe?)
