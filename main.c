#include <stdio.h>
#include <math.h>
double inputRead(FILE *f)
{
    double tmp;
    fscanf(f, "%lf", &tmp);
    return tmp;
}
int accuracy(double tmp, double e)
{
    double pi = 3.141592;
    double upperbound = pi + pi * e / 100;
    double lowerbound = pi - pi * e / 100;
    if ((tmp > lowerbound) && (tmp < upperbound))
    {
        return 1;
    }
    else
        return 0;
}
int outputAns(double res, char *outf)
{
    FILE *out;
    if ((out = fopen(outf, "w")) == NULL)
    {
        printf("Error opening file");
        return 0;
    }
    fprintf(out, "%lf", res);
    fclose(out);
}
int main(int argc, char *argv[]) {
    FILE *in;
    if ((in = fopen(argv[1], "r")) == NULL) {
        printf("Error opening file");
        return 0;
    }
    double eps = inputRead(in);
    fclose(in);
    double res = 2;
    double an = sqrt(2);
    while (!(accuracy(res, eps) == 1)) {
        res = res * 2 / an;
        an = sqrt(2 + an);
    }
    outputAns(res, argv[2]);
    return 0;
}