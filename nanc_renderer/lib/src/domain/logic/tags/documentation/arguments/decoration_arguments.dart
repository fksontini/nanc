import '../../tag_description.dart';
import '../documentation_types.dart';
import 'scalar_arguments.dart';

TagArgument colorArgument({required String name}) => TagArgument(
      name,
      {
        '#D5FFFFFF',
        'DA9745',
        'red',
        'armadillo',
      },
      '''
Color value can be a hex or human-readable representation of the color in the next possible forms:
* #FFAADD - HEX value with the "#" prefix
* FFAADD - HEX value without "#" prefix
* #A5FFAADD - 8-byte HEX value with the opacity starting numbers "A5" and "#" prefix
* A5FFAADD - 8-byte HEX value with the opacity starting numbers "A5" and without "#" prefix
* red
* blue
* etc.

Full list of human-readable color names can be found [here](https://github.com/alphamikle/nanc/blob/master/tools/lib/src/tools/named_colors.dart).
''',
    );

TagArgument blendModeArgument({required String name}) => TagArgument(name, DocumentationTypes.blendModeValues);
// TagArgument strokeAlignArg([String name = 'strokeAlign']) => TagArgument(name, DocumentationTypes.strokeAlignValues);
TagArgument blurStyleArgument({required String name}) => TagArgument(name, DocumentationTypes.blurStyleValues);
TagArgument tileModeArgument({required String name}) => TagArgument(name, DocumentationTypes.tileModeValues);
TagArgument materialTypeArgument({required String name}) => TagArgument(name, DocumentationTypes.materialTypeValues);
TagArgument elevationArgument([String name = 'elevation']) => doubleArgument(name: name);
