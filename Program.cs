using System.Collections;
using System;
using System.Globalization;


namespace Devops_student_task
{
    internal class Program
    {
        static void Main(string[] args)
        {
            ArrayList save_file = new ArrayList(); // Will save the file sorted

            /* Two files that contains the lists 
             * Output file that contain the sorted list.
             */ 
            string file_1 = "https://dev.azure.com/ilaigamzu13/Devops_student_task/_git/DevOps_task3?path=/project_2/file_1.txt&version=GBmaster";
            string file_2 = "https://dev.azure.com/ilaigamzu13/Devops_student_task/_git/DevOps_task3?path=/project_2/file_2.txt&version=GBmaster";
            string output_file = "https://dev.azure.com/ilaigamzu13/Devops_student_task/_git/DevOps_task3?path=/project_2/file_sol.txt&version=GBmaster";
            string string_file_1 = file_option(file_1);
            string string_file_2 = file_option(file_2);
            // Split the contents into words based on whitespace
            string[] str_file_1 = string_file_1.Split(new[] { ' ', '\t', '\n', '\r' }, StringSplitOptions.RemoveEmptyEntries);
            add_to_array_list(save_file, str_file_1);
            string[] str_file_2 = string_file_2.Split(new[] { ' ', '\t', '\n', '\r' }, StringSplitOptions.RemoveEmptyEntries);
            //Console.WriteLine("string 2 is "+ string_file_2);
            add_to_array_list(save_file, str_file_2);
            //print_array_list(save_file);
            //Console.WriteLine("Number of elements : " + save_file.Count);
            save_file.Sort();
            //Console.WriteLine("After sorting:");
            //print_array_list(save_file);
            insert_arrraylist_to_file(save_file, output_file);
            print_file(output_file);

        }
        
        /*
         * This method will add a string to ArrayList
         * Input: ArrayList and array in type string
         * Output: Will add to ArrayList the words from files
         */
        public static void add_to_array_list(ArrayList save_file, string [] str_file_1)
        {
            foreach (string word in str_file_1)
            {
                save_file.Add(word);
            } 
        }

        /*
         *Method that print ArrayList
         */
        public static void print_array_list(ArrayList save_file)
        {
            Console.WriteLine("ArrayList: save_file");
            foreach (var value in save_file)
            {
                Console.WriteLine(value);
            }
        }
        
        /*
         * Method that check if file is exists and return the text in file by string
         * Input: path of file
         * Output: if the file is exists, then return string that contain all text from file
         *         else- print error and exit.
         * Note: the method ReadAllText open the file, read and close the file.
         */
        public static string file_option(string path)
        {
            if (!File.Exists(path)) {
                Console.WriteLine("Error: File does not exist at the specified path.");
                Environment.Exit(1);
            }
            // Read all the content of file_1 in a string type.
            
            string from_file = File.ReadAllText(path);
            return from_file;
        }

        /*
         * Method that copy the content of arrayList on output file.
         * Input: ArrayList save_file, path of output.
         *  Output: if the file is exists, then content of arraylist copy to output_file.
         *          else- print error and exit.
         */
        public static void insert_arrraylist_to_file(ArrayList save_file, string path)
        {
            if (!File.Exists(path)) {
                Console.WriteLine("Error: File does not exist at the specified path.");
                Environment.Exit(1);
            }
            string[] stringArray = (string[])save_file.ToArray(typeof(string));
            File.WriteAllLines(path, stringArray);
        }
        
        /*
         * Method that print the output file
         * Input: path of file
         * Output: print the content of file
         */
        public static void print_file(string path)
        {
            string from_output_file = file_option(path);
            Console.WriteLine("File content is :\n"+from_output_file );
            
        }

    }
}