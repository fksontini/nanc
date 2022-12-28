import 'package:fields/fields.dart';
import 'package:icons/icons.dart';
import 'package:model/model.dart';

final Model developer = Model(
  name: 'Developer',
  icon: IconPack.personLineDuotone,
  fields: [
    [
      IdField(),
      StringField(name: 'Name', maxLines: 1, isRequired: true),
      StringField(name: 'Second Name', maxLines: 1, isRequired: true),
    ],
    [
      EnumField(
        name: 'Position',
        values: const [
          EnumValue(title: 'APP DEVELOPER', value: 'appDeveloper'),
          EnumValue(title: 'UI/UX DESIGNER', value: 'designer'),
          EnumValue(title: 'WEB DEVELOPER', value: 'webDeveloper'),
          EnumValue(title: 'MANAGER', value: 'manager'),
          EnumValue(title: 'OWNER', value: 'owner'),
          EnumValue(title: 'QA ENGINEER', value: 'qa'),
          EnumValue(title: 'OTHER', value: 'other'),
        ],
      ),
      StringField(name: 'Image', maxLines: 1, isRequired: true),
    ],
    [
      StringField(name: 'Description', maxLines: 2, isRequired: true),
    ],
    [
      StringField(name: 'Facebook', maxLines: 1),
      StringField(name: 'Instagram', maxLines: 1),
    ],
    [
      StringField(name: 'Twitter', maxLines: 1),
      StringField(name: 'YouTube', maxLines: 1),
    ],
  ],
);
