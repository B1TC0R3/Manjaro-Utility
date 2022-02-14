#!/usr/lib/python3

import os
from utility import check_args,\
                    dict_line_length,\
                    list_line_length


def required_length(title: str, data: dict, options: dict):
    final_len = len(title)
    data_len = dict_line_length(data)
    options_len = list_line_length(list(options.keys()))

    if final_len < data_len:
        final_len = data_len
    if final_len < options_len:
        final_len = options_len

    return final_len


class TuiEngine:
    color = {"green": "\033[92m",
             "none": "\033[0m"}

    selected_index = 0
    options_list = list

    title = ""
    data = dict
    options = dict

    line_length = 0

    def execute_selected_item(self):
        if not self.selected_index >= len(self.options_list):
            self.options_list[self.selected_index]()

    def selection_up(self):
        if not self.selected_index == 0:
            self.selected_index -= 1
            self.render(self.title,
                        self.data,
                        self.options)

    def selection_down(self):
        if not self.selected_index == len(self.options_list)-1:
            self.selected_index += 1
            self.render(self.title,
                        self.data,
                        self.options)

    def render(self, title: str, data: dict, options: dict):
        check_args(title, data, options)

        self.title = title
        self.data = data
        self.options = options

        self.line_length = required_length(title, data, options)
        connector = f"#-{'-'*self.line_length}-#"
        title_render = f"| {title}{(self.line_length-len(title))*' '} |"
        data_render = self._render_data()
        options_render = self._render_options()
        self.options_list = list(options.values())

        self._display(title_render,
                      data_render,
                      options_render,
                      connector)

    def _render_data(self) -> str:
        data_render = ""
        for key, entry in self.data.items():
            line = f"{key}: {entry}"
            data_render += f"| {line}{(self.line_length - len(line)) * ' '} |\n"

        return data_render

    def _render_options(self) -> str:
        options_render = ""
        for index, entry in enumerate(self.options.keys()):
            if index == self.selected_index:
                options_render += f"->{self.color['green']}{entry}{self.color['none']}" \
                                  f"{(self.line_length-len(entry))*' '} |\n"
            else:
                options_render += f"| {entry}{(self.line_length-len(entry))*' '} |\n"

        return options_render

    def _display(self, title: str, data: str, options: str, connector: str):
        os.system("clear")

        print(f"{connector}\n"
              f"{title}"
              f"{connector}\n"
              f"{data}"
              f"{connector}\n"
              f"{options}"
              f"{connector}")


if __name__ == "__main__":
    print("Running tests for tui_engine.py\n"
          "If you want to start the full application, please use 'python snack_machine.py'")
    engine = TuiEngine()

    def function_one():
        print("function one executed!")

    def function_two():
        print("function two executed!")

    def function_three():
        print("function three executed!")

    engine.render("Test Run", {"Information": "Test Run", "Length Test": "This line is incrediby long because "
                                                                         "i want too see how my application deals "
                                                                         "with it, lets go and test it out :D",
                               "Symbol Test": "@ſ€¶ŧ←↓→øþſðđŋħł»«¢„“”µ·…–′¹²³¼½¬{[]}\\"},
                  {"Execute Function 1": function_one,
                   "Execute Function 2": function_two,
                   "Execute Function 3": function_three})

    print("Executing options\n"
          "Testing multiple selection scenarios\n"
          "Execution might seem out of order")
    engine.execute_selected_item()
    engine.selection_up()
    engine.selection_down()
    engine.execute_selected_item()
    engine.selection_down()
    engine.execute_selected_item()
    engine.selection_down()
    engine.execute_selected_item()
    engine.selection_up()
    engine.execute_selected_item()

