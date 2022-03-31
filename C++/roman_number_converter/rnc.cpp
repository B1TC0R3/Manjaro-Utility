#include <iostream>
#include <string>
#include <map>

int roman_to_int(std::string roman_number) {
	int result = 0;

	//Alle einzelnen roemischen Elemente ihrer entsprechenden Zahl zuweisen
	std::map<char, int> translation;
	translation['I'] = 1;
	translation['V'] = 5;
	translation['X'] = 10;
	translation['L'] = 50;
	translation['C'] = 100;
	translation['D'] = 500;
	translation['M'] = 1000;
	
	//Die roemische Zahl von vorne nach hintern durchlaufen
	//Die letzet Zahl wird am Ende hinzugefügt.
	//Es wird eine Stelle abgezogen, damit es bei den Abfragen 
	//nicht zu Fehlern kommt.
	for (int i = 0; i < roman_number.length() - 1; i++) {
		//Wenn die momentane Stelle groeßer ist als die naechste, 
		//kann man die Stelle einfach zu der konvertierten Zahl 
		//addieren.  
		if(translation[roman_number[i]] >= translation[roman_number[i+1]]) {
			result += translation[roman_number[i]];

		//Für Fälle wie "IX" muss "I" von "X" abgezogen werden.
		//              "9"       "1"     "10"
		//Hier wird z.B. "I" einfach von der gesamten Zahl subtrahiert, 
		//mit dem gleichen Ergebnis.
		}else {
			result -= translation[roman_number[i]];

		}
	}

	//Hinzufuegen der letzten Zahl
	result += translation[roman_number[roman_number.length()-1]];

	//Ergebnis zurückgeben
	return result;
}

int main() {
	//Zahl vom Benutzer einlesen
	std::cout << "Roemische Nummer eingeben: " << std::endl;
	std::string input;
	std::cin >> input;

	//Roemische Zahl umrechnen
	int result = roman_to_int(input);
	std::cout << "Ergebnis: " << result << std::endl;

	return 0;
}
