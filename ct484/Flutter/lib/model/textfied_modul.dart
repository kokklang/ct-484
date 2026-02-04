import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ETextField extends StatefulWidget {
  final String label;
  final String validatorText;
  final FormFieldSetter<String> onSaved;

  const ETextField({
    super.key,
    required this.label,
    required this.validatorText,
    required this.onSaved,
  });

  @override
  State<ETextField> get createState => _ETextFieldState();
}

class _ETextFieldState extends State<ETextField> {
  final TextEditingController controller = TextEditingController();
  bool isExpanded = false;
  bool isLong = false;

  static const int minLines = 1;
  static const int maxLines = 7;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextFormField(
            scrollPadding: EdgeInsets.all(16),
            controller: controller,
            minLines: minLines,
            maxLines: isExpanded ? null : maxLines,
            validator: RequiredValidator(
              errorText: widget.validatorText,
            ),
            onSaved: widget.onSaved,
            decoration: InputDecoration(
              labelText: widget.label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (text) {
              final longNow = _isTextLong(text);
              if (longNow != isLong) {
                setState(() => isLong = longNow);
              }
            },
          ),

          if (isLong)
            TextButton(
              onPressed: () {
                setState(() => isExpanded = !isExpanded);
              },
              child: Text(isExpanded ? 'ซ่อนข้อความ' : 'ดูเพิ่มเติม'),
            ),
        ]);
  }

  bool _isTextLong(String text) {
    if (text.length <= 150) return false;
    return text.split('\n').length > maxLines;
  }
}




  /// ==================
  /// ตั้งค่า วิดเจด กรอกข้อความ
  /// ==================



// Widget _buildTextField({


//   bool autofocus = false,
//   int minLines = 1,  
//   int maxLines = 10,  
// }) {
//   return Padding(
//     padding: const EdgeInsets.only(bottom: 16),
//     child: TextFormField(
//       autofocus: autofocus,
//       minLines: minLines,
//       maxLines: maxLines,
//       keyboardType: TextInputType.multiline,
//       validator: RequiredValidator(errorText: validatorText),
//       onSaved: onSaved,
//       decoration: InputDecoration(
//         labelText: label,
//         alignLabelWithHint: true,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//     ),
//   );
// }
// }