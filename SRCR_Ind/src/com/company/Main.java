package com.company;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;

public class Main {
    public static void main(String[] args) {
        try {
            FileReader fr = new FileReader("pts_recolha.csv");

            try (BufferedReader br = new BufferedReader(fr)) {
                ArrayList<String> linhas = new ArrayList<>();
                String[] parte1;
                String[] parte2;
                String linha;
                FileWriter fw = new FileWriter("circuitos.pl");

                while ((linha = br.readLine()) != null) {
                    linhas.add(linha);
                }
                fr.close();
                fw.write(":- dynamic adjacente/2.\n");
                fw.write(":- dynamic localrecolha/11.\n");
                for (int i = 1; i < linhas.size() - 1; i++) {
                    parte1 = linhas.get(i).split(";");
                    parte2 = linhas.get(i + 1).split(";");
                    if (parte1[4].equals(parte2[4])) {
                        fw.write("adjacente(");
                        fw.write("localrecolha(" + parte1[0] + "," + parte1[1] + "," + parte1[2] + ",'" + parte1[3] + "'," + parte1[4] + ",'" + parte1[5] + "','" + parte1[6] + "','" + parte1[7] + "'," + parte1[8] + "," + parte1[9] + "," + parte1[10] + "),");
                        fw.write("localrecolha(" + parte2[0] + "," + parte2[1] + "," + parte2[2] + ",'" + parte2[3] + "'," + parte2[4] + ",'" + parte2[5] + "','" + parte2[6] + "','" + parte2[7] + "'," + parte2[8] + "," + parte2[9] + "," + parte2[10] + ")");
                        fw.write(").\n");
                        fw.write("adjacente(");
                        fw.write("localrecolha(" + parte2[0] + "," + parte2[1] + "," + parte2[2] + ",'" + parte2[3] + "'," + parte2[4] + ",'" + parte2[5] + "','" + parte2[6] + "','" + parte2[7] + "'," + parte2[8] + "," + parte2[9] + "," + parte2[10] + "),");
                        fw.write("localrecolha(" + parte1[0] + "," + parte1[1] + "," + parte1[2] + ",'" + parte1[3] + "'," + parte1[4] + ",'" + parte1[5] + "','" + parte1[6] + "','" + parte1[7] + "'," + parte1[8] + "," + parte1[9] + "," + parte1[10] + ")");
                        fw.write(").\n");
                    }
                }

                for (int i = 1; i < linhas.size() - 1; i++) {
                    parte1 = linhas.get(i).split(";");
                    fw.write("localrecolha(" + parte1[0] + "," + parte1[1] + "," + parte1[2] + ",'" + parte1[3] + "'," + parte1[4] + ",'" + parte1[5] + "','" + parte1[6] + "','" + parte1[7] + "'," + parte1[8] + "," + parte1[9] + "," + parte1[10] + ").\n");
                }
                parte2 = linhas.get(linhas.size() - 1).split(";");
                fw.write("localrecolha(" + parte2[0] + "," + parte2[1] + "," + parte2[2] + ",'" + parte2[3] + "'," + parte2[4] + ",'" + parte2[5] + "','" + parte2[6] + "','" + parte2[7] + "'," + parte2[8] + "," + parte2[9] + "," + parte2[10] + ").\n");
                fw.close();
            }
        } catch (IOException e) {
            System.out.println("Erro a ler/escrever no ficheiro");
        }
    }

}