import 'package:flutter/material.dart';
import 'package:form_profissional/model/usuario.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FormUsuario extends StatefulWidget {
  @override
  _FormUsuarioState createState() => _FormUsuarioState();
}

class _FormUsuarioState extends State<FormUsuario> {
  final _formKey = GlobalKey<FormState>();

  Usuario _usuario = Usuario();

  onSubmit() {
    if(_formKey.currentState.validate()) {
      print('Tudo Ok');
    } else {
      print('O formulário contém erros');
    }
  }

  String requerido(String valor) {
    if (valor == "") return "Este campo é requerido";
    return null;
  }

  String confirmacaoSenha(String valor) {
    if (valor == _usuario.senha) return null;
    return "A confirmação não é idêntica à senha";
  }

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _statusSel;

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();

    items.add(new DropdownMenuItem(
      value: 'xamarin',
      child: Text('XAMARIM FORMS')));

    items.add(new DropdownMenuItem(
      value: 'flutter',
      child: Text('FLUTTER')));

    items.add(new DropdownMenuItem(
      value: 'react',
      child: Text('REACT NATIVE')));

    return items;
  }

  void changedDropDownItem(String selectedItem) {
    setState(() {
      _statusSel = selectedItem;
    });
  }

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _statusSel = _dropDownMenuItems[0].value;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const _corIcones = Colors.black;
    const Icon _iconeCampoObrigatorio = Icon(Icons.star, color: Colors.red);

    var mascaraTelefone = MaskTextInputFormatter(
      mask: '(##) #####-####',
      filter: {'#': RegExp(r'[0-9]')}
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Formulários Profissionais"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            tooltip: "Salvar", 
            onPressed: onSubmit,
          ),
        ]
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget> [
            ListTile(
              leading: const Icon(
                Icons.person,
                color: _corIcones, 
              ),
              trailing: _iconeCampoObrigatorio,
              title: TextFormField(
                onChanged: (valor) => _usuario.nome = valor,
                validator: requerido,
                decoration: InputDecoration(hintText: "Nome"),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.phone,
                color: _corIcones, 
              ),
              trailing: _iconeCampoObrigatorio,
              title: TextFormField(
                onChanged: (valor) => _usuario.telefone = valor,
                inputFormatters: [mascaraTelefone],
                validator: requerido,
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(hintText: "Telefone"),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.mail,
                color: _corIcones, 
              ),
              trailing: _iconeCampoObrigatorio,
              title: TextFormField(
                onChanged: (valor) => _usuario.email = valor,
                keyboardType: TextInputType.emailAddress,
                validator: requerido,
                decoration: InputDecoration(hintText: "E-mail"),
              ),
            ),            
            ListTile(
              leading: const Icon(
                Icons.security,
                color: _corIcones, 
              ),
              trailing: _iconeCampoObrigatorio,
              title: TextFormField(
                onChanged: (valor) => _usuario.senha = valor,
                obscureText: true,
                validator: requerido,
                decoration: InputDecoration(hintText: "Senha"),
              ),
            ),               
            ListTile(
              leading: const Icon(
                Icons.copyright,
                color: _corIcones, 
              ),
              title: TextFormField(
                obscureText: true,
                validator: confirmacaoSenha,
                decoration: InputDecoration(hintText: "Confirme a Senha"),
              ),
            ),        
            ListTile(
              leading: const Icon(
                Icons.list,
                color: _corIcones, 
              ),
              title: DropdownButton(
                style: TextStyle (
                  color: Colors.blue, fontWeight: FontWeight.bold,
                ),
                value: _statusSel,
                items: _dropDownMenuItems,
                onChanged: changedDropDownItem,
              ),
            ),                
            ListTile(
              leading: const Icon(
                Icons.copyright,
                color: _corIcones, 
              ),
              title: Text(
                '$_statusSel',
              ),
            ),  
          ],
        ),
      ),
    );
  }
}