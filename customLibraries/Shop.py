from robot.api.deco import library, keyword
from robot.libraries.BuiltIn import BuiltIn

@library
class Shop:
    @property
    def selLib(self):
        return BuiltIn().get_library_instance("SeleniumLibrary")

    @keyword
    def helloworld(self):
        print("Hello World")

    @keyword
    def add_items_to_cart_and_checkout(self, productsList):
        i = 1
        productsTitles = self.selLib.get_webelements("css:.card-title")
        for productTitle in productsTitles:
            if productTitle.text in productsList:
                self.selLib.click_button("xpath:(//*[@class='card-footer'])["+str(i)+"]/button")
            i += 1
        self.selLib.click_element("xpath://a[@class='nav-link btn btn-primary' and contains(text(), 'Checkout')]")
        self.selLib.element_text_should_be("xpath://h3[normalize-space()='Total']","Total")