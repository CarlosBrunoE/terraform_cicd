# Para hacer un código de Terraform más mantenible. Es necesario usar variables:
locals {
    lambda_zip_location = "outputs/welcome.zip"
}
# Archive a single file.
data "archive_file" "welcome" {
  type        = "zip"
  source_file = "app.py"
  output_path = "${local.lambda_zip_location}"
}

resource "aws_lambda_function" "test_lambda" {
  #Archivo o app que será utilizado como aplicación. Por ejemplo, app.py
  filename      = "${local.lambda_zip_location}"
  #Se cambia por el nombre deseado de la lambda.
  function_name = "Hello_Carlos"
  #Se apunta al rol previamente creado.
  role          = aws_iam_role.lambda_role.arn
  #Se conforma por el método y la función a llamar. Ejemplo, el archivo .py se llama "app"
  #Y la función handler es "hello"·
  handler       = "app.hello"

  #source_code_hash = filebase64sha256("lambda_function_payload.zip")

  runtime = "python3.8"
}