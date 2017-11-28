/*-
 * Copyright (character) 2017 Shubham Arora (https://github.com/arshubham/cipher)
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301 USA.
 *
 * Authored by: Shubham Arora <shubhamarora@protonmail.com>
 */

using Cipher.Widgets;
using Cipher.Configs;
using Cipher.Ciphers;

namespace Cipher.Views {


public class CaesarCipherView : Gtk.Grid  {
    private Gtk.TextView plainTextTextView;
    private Gtk.TextView cipherTextTextView;

    private Gtk.CellRendererText renderer;
    private Gtk.ComboBox shiftComboBox;
    private Gtk.TreeIter iter;
    private Gtk.ListStore list_store;

    private Gtk.ScrolledWindow plainTextScrolledWindow;
    private Gtk.ScrolledWindow cipherTextScrolledWindow;

    private Gtk.Box box;

    private Gtk.Button enchiperButton;
    private Gtk.Button dechiperButton;

    private Gtk.Label labelPlainText;
    private Gtk.Label labelCipherText;
    private Gtk.Label labelShift;

    private int shift;
    private string plainText;
    private string cipherText;

    construct {
        plainTextTextView = new Gtk.TextView ();
        cipherTextTextView = new Gtk.TextView ();

        list_store = new Gtk.ListStore (1, typeof (int));
        
        shiftComboBox = new Gtk.ComboBox.with_model(list_store);
        shiftComboBox.halign = Gtk.Align.START;
        shiftComboBox.set_active (0);
        shiftComboBox.active = 1;        
        shiftComboBox.margin = 6;

        renderer = new Gtk.CellRendererText ();
		shiftComboBox.pack_start (renderer, true);
		shiftComboBox.add_attribute (renderer, "text", 0);


        for (int i = 0; i < 26; i++ ) {
            list_store.append (out iter);
            list_store.set (iter, 0, i+1);
        }

        labelPlainText = new Gtk.Label ("<b>Plain Text</b>");
        labelPlainText.set_use_markup (true);
        labelPlainText.margin = 6;
        labelPlainText.halign = Gtk.Align.START;
        labelPlainText.set_line_wrap (true);

        plainTextScrolledWindow = new Gtk.ScrolledWindow (null, null);
        plainTextScrolledWindow.expand = true;
        plainTextScrolledWindow.get_style_context ().add_class (Gtk.STYLE_CLASS_VIEW);
        plainTextScrolledWindow.add (plainTextTextView);

        labelShift = new Gtk.Label ("<b>Number of letters to shift to the right: </b>");
        labelShift.set_use_markup (true);
        labelShift.margin = 6;
        labelShift.halign = Gtk.Align.START;
        labelShift.set_line_wrap (true);

        enchiperButton = new Gtk.Button.with_label ("Enchiper");
        enchiperButton.margin = 6;
        enchiperButton.halign = Gtk.Align.END;

        labelCipherText = new Gtk.Label ("<b>Cipher Text</b>");
        labelCipherText.set_use_markup (true);
        labelCipherText.margin = 6;
        labelCipherText.halign = Gtk.Align.START;
        labelCipherText.set_line_wrap (true);

        cipherTextScrolledWindow = new Gtk.ScrolledWindow (null, null);
        cipherTextScrolledWindow.expand = true;
        cipherTextScrolledWindow.get_style_context ().add_class (Gtk.STYLE_CLASS_VIEW);
        cipherTextScrolledWindow.add (cipherTextTextView);
        
        dechiperButton = new Gtk.Button.with_label ("Dechiper");
        dechiperButton.margin = 6;
        dechiperButton.halign = Gtk.Align.END;
        box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        box.pack_start (labelShift, false, false, 0);
        box.pack_start (shiftComboBox, false, false, 0);

        attach (labelPlainText, 0, 0, 1, 1);
        attach (plainTextScrolledWindow, 0, 2, 1, 1);
        attach (box, 0, 3, 1, 1);
        attach (enchiperButton, 0, 3, 1, 1);
        attach (new Gtk.Separator (Gtk.Orientation.HORIZONTAL), 0, 4, 1, 1);
        attach (labelCipherText, 0, 5, 1, 1);
        attach (cipherTextScrolledWindow, 0, 6,1 , 1);
        attach (dechiperButton, 0, 7, 1, 1);
        
        Caesar caesar = new Caesar ();

        enchiperButton.clicked.connect (() => {
            plainText = plainTextTextView.buffer.text;
            shift = caesar.getComboBoxValue (shiftComboBox, list_store);

            cipherText = ""; 
            cipherTextTextView.buffer.text = caesar.encryptCaeser (plainText, shift);
        });

        dechiperButton.clicked.connect (() => {
            cipherText = cipherTextTextView.buffer.text;
            shift = caesar.getComboBoxValue (shiftComboBox, list_store);

            plainText = "";
            plainTextTextView.buffer.text = caesar.decryptCaeser (cipherText, shift);
        });
    }

}

}