Feature: Checkout

  Background: User login into Sauce Demo
    Given I am in sauce demo web page
    And I set the user name text box with "standard_user"
    And I set the password text box with "secret_sauce"
    When I click on the login button
    Then The home page should be displayed

  Scenario: Checkout sin productos
    Given el usuario hace click en el carrito
    And hace click en el botón de checkout
    And ingresa los datos de envio válidos "John" "Doe" "12345"
    And hace click en el botón de continuar

 Scenario Outline: Checkout en blanco
    Given el usuario añade un producto al carrito
    When el usuario hace click en el carrito
    And hace click en el botón de checkout
    And ingresa los datos de envio válidos "<FirstName>" "<LastName>" "<PostalCode>"
    And hace click en el botón de continuar
    Then debería ver un mensaje de error por datos en blanco "<Error>"
    Examples:
      | FirstName | LastName | PostalCode | Error                          |
      |           | Doe      | 12345      | Error: First Name is required  |
      | John      |          | 12345      | Error: Last Name is required   |
      | John      | Doe      |            | Error: Postal Code is required |

  Scenario: Checkout con datos válidos
    Given el usuario añade un producto al carrito
    When el usuario hace click en el carrito
    And hace click en el botón de checkout
    And ingresa los datos de envio válidos "John" "Doe" "12345"
    And hace click en el botón de continuar
    And hace click en el botón de finish
    Then debería ver la página de confirmación de compra


  Scenario: Carrito permanece
    Given el usuario añade un producto al carrito
    And hace click en el botón de menú
    And hace un logout
    And I set the user name text box with "standard_user"
    And I set the password text box with "secret_sauce"
    When I click on the login button
    Then El carrito permanece

  Scenario: Eliminar Producto
    Given el usuario añade un producto al carrito
    Then el item está en el carrito
    And quita un elemento del carrito
    Then el item no está en el carrito
