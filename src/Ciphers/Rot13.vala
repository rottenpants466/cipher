/*-
 * Copyright (c) 2017-2019 Shubham Arora (https://github.com/arshubham/cipher)
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

namespace Cipher.Ciphers {

    public class Rot13 {

        static string hash = "NOPQRSTUVWXYZABCDEFGHIJKLM      nopqrstuvwxyzabcdefghijklm";

        public string encrypt (string plain_text) {
            string cipher_text = "";
            unichar character;
            unichar c;

            for (int i = 0; plain_text.get_next_char (ref i, out character); ) {
                if (character > 96 && character < 123 || character > 64 && character < 91) {
                     c = character - 'A';
                     c = hash.get_char ((int) c);
                } else {
                     c = character;
                }
                cipher_text = cipher_text.concat (c.to_string ());
            }
            return cipher_text;
        }

        public string decrypt (string cipher_text) {
            string plain_text = "";
            unichar character;
            unichar c;

            for (int i = 0; cipher_text.get_next_char (ref i, out character); ) {
                if (character > 96 && character < 123 || character > 64 && character < 91) {
                    c = character - 'A';
                    c = hash.get_char ((int) c);
                } else {
                    c = character;
                }
                plain_text = plain_text.concat (c.to_string ());
            }

            return plain_text;
        }
    }
}
