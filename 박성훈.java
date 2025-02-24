package java_pjt;

import java.util.Random;

public class 박성훈 {
	public static void main(String[] args) {
		int[][] array =new int [3][4];
		Random random =new Random();
		int total=0;
				
		for (int i = 0; i < array.length; i++) {
			for (int j = 0; j < array.length; j++) {
				array[i][j]=random.nextInt(10);
				total+= array[i][j];
				System.out.println(array[i][j]+"\t");
			}
			System.out.println();
		}
		System.out.println("합은"+total);
				
	}
}
