#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>

int main(){
  pid_t pid;
  char *argv[3];
  argv[0]="dir/hola";
  argv[1]="Desde el hijo";
  argv[2]=NULL;

  if ((pid=fork())==-1)
    printf("Error al crear el proceso hijo \n");
  if (pid==0) {
    printf("soy el hijo ejecutando: %s\n",argv[0] );
    execv(argv[0],argv);
  }else{
    wait(0);
    printf("Soy el padre\n");
    exit(0);
  }

}
