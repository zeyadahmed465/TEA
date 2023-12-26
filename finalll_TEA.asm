org 100h ;offset in memory 
.data 
    delta    DW 02ach
    sum      DW  0        
    v0       DW  0
    v1       DW  0   
    k0       DW  3fh    
    k1       DW  1dh
    k2       DW  0f1h
    k3       DW  0fch     
           
    message_0 DB 'Press "e" for Encryption or "d" for Decryption or "c" for Encryption&Decryption "x" for exit: $'
    message_1 DB 0Dh,0Ah,'Enter a Text (4 chars) to Encrypt: $'     
    message_2 DB 0Dh,0Ah,'Wait for Encrypting... $'    
    message_3 DB 0Dh,0Ah,'Encrypted text is: $'    
    message_4 DB 0Dh,0Ah,'Wait for Decrypting... $' 
    message_5 DB 0Dh,0Ah,'decrypted text is: $'                             


.code
             
main proc          
      
 jmp choose_operation
                        
 encryptAndDecryptOperation:           
    mov ah,09h                 ;print message_1  
    mov dx,offset message_1    ;print              
    int 21h                    ;interrupt kernal
    
    mov ah,01h                 ;reads v0
    int 21h                    ;interrupt kernal
    mov bh,al                  ;assign al to bh  
    int 21h                    ;interrupt dos
    mov bl,al                  ;assign al to bh 
    mov v0,bx                  ;assign ax to v0
    
    mov ah,01h                 ;reads v1
    int 21h                    ;interrupt kernal
    mov bh,al                  ;assign al to bh  
    int 21h                    ;interrupt kernal
    mov bl,al                  ;assign al to bh 
    mov v1,bx                  ;assign ax to v1 
      

    mov ah, 09h                ;print the string
    mov dx, offset message_2   ;assign load effective address
    int 21h                    ;interrupt dos

    call encrypt               ;calling function ercrypt

    mov ah, 09h                ;print the string
    mov dx, offset message_3   ;assign load effective address
    int 21h                    ;interrupt dos

    mov ah, 02h                ;reads input v0
    mov bx, v0                 ;assign v0 to bx
    mov dl, bh                 ;take first byte
    int 21h                    ;interrupt dos
    mov dl, bl                 ;take second byte
    int 21h                    ;interrupt dos

    mov bx, v1                 ;assign v1 to bx
    mov dl, bh                 ;assign dl to bh
    int 21h                    ;interrupt dos
    mov dl, bl                 ;assign bl to dl
    int 21h                    ;interrupt dos

    mov dl, 0Ah                ;assign line feed (enter)
    mov ah, 02h                ;prints dl 
    int 21h                    ;interrupt dos

    mov ah, 09h                ;print the string
    mov dx, offset message_4   ;assign load effective address
    int 21h                    ;interrupt dos

    call decrypt               ;calling function ercrypt

    mov ah, 09h                ;print the string
    mov dx, offset message_5   ;assign load effective address
    int 21h                    ;interrupt dos

    mov ah, 02h                ;reads input v0
    mov bx, v0                 ;assign v0 to bx
    mov dl, bh                 ;take first byte
    int 21h                    ;interrupt dos
    mov dl, bl                 ;take second byte
    int 21h                    ;interrupt dos

    mov bx, v1                 ;assign v1 to bx
    mov dl, bh                 ;read first byte
    int 21h                    ;interrupt dos
    mov dl, bl                 ;read second byte
    int 21h                    ;interrupt dos

    mov dl, 0Ah                ;assign line feed (enter)
    mov ah, 02h                ;prints dl 
    int 21h                    ;interrupt dos

    jmp choose_operation       ;jumps to choose_operation again                
                        
 choose_operation:
    
    mov ah, 09h                  ;prints message_0
    lea dx, message_0
    int 21h                      ;interrupt dos
    mov ah, 01h                  ;reads the choise
    int 21h                      ;interrupt dos
    cmp al, 'e'                  ;compare value in al with e
    je encryptOperation          ;jump if it equal
    cmp al, 'd'                  ;compare value in al with e
    je DecryptOperation          ;jump if it equal
    cmp al, 'c'                  ;compare value in al with e
    je encryptAndDecryptOperation;jump if it equal
    cmp al, 'x'                  ;compare value in al with e
    je endProgram                ;jump to end if it equal
    jmp choose_operation         ;repeat operation again
    
    
         
 encryptOperation:
         
    mov ah,09h                 ;print message_1  
    mov dx,offset message_1    ;print              
    int 21h                    ;interrupt kernal   
    
    mov ah,01h                 ;reads v0
    int 21h                    ;interrupt kernal
    mov bh,al                  ;assign al to bh  
    int 21h                    ;interrupt kernal
    mov bl,al                  ;assign al to bh 
    mov v0,bx                  ;assign ax to v0
    
    mov ah,01h                 ;reads v1
    int 21h                    ;interrupt kernal
    mov bh,al                  ;assign al to bh  
    int 21h                    ;interrupt kernal
    mov bl,al                  ;assign al to bh 
    mov v1,bx                  ;assign ax to v1 
      
      
    ; "Wait for Encrypting..."
    mov ah, 09h
    mov dx, offset message_2
    int 21h    
    
    call encrypt
     
    mov ah, 09h
    mov dx, offset message_3
    int 21h       
     
    mov ah, 02h ;print output  
    ;print v0       
    mov bx, v0  ;assign v0 to ax
    mov dl, bh  ;assign bh to dl           
    int 21h     ;interrupt kernel
    mov dl, bl  ;assign bl to d1
    int 21h      
    
    ; print v1
    mov bx, v1
    mov dl, bh             
    int 21h
    mov dl, bl
    int 21h    
    
    jmp endProgram
    
  ;-----------------------------------------------------------------------------
  
    DecryptOperation:    
    
    mov ah,09h                 ;print message_1  
    mov dx,offset message_1    ;print              
    int 21h                    ;interrupt kernal   
    
    mov ah,01h                 ;reads v0
    int 21h                    ;interrupt kernal
    mov bh,al                  ;assign al to bh  
    int 21h                    ;interrupt kernal
    mov bl,al                  ;assign al to bh 
    mov v0,bx                  ;assign ax to v0
    
    mov ah,01h                 ;reads v1
    int 21h                    ;interrupt kernal
    mov bh,al                  ;assign al to bh  
    int 21h                    ;interrupt kernal
    mov bl,al                  ;assign al to bh 
    mov v1,bx                  ;assign ax to v1 
      
      
    ; "Wait for Encrypting..."
    mov ah, 09h
    mov dx, offset message_4
    int 21h    
    
    call decrypt
     
    mov ah, 09h
    mov dx, offset message_5
    int 21h       
     
    mov ah, 02h ;print output  
    ;print v0       
    mov bx, v0  ;assign v0 to ax
    mov dl, bh  ;assign bh to dl           
    int 21h     ;interrupt kernel
    mov dl, bl  ;assign bl to d1
    int 21h      
    
    ; print v1
    mov bx, v1
    mov dl, bh             
    int 21h
    mov dl, bl
    int 21h  
          
          
          
;-------------------------------------------------------------------------------------
   endProgram:
    ; stop the program
    mov ah, 4ch
    int 21h
    
    endp
        
      
encrypt proc
   mov cx,8
   
 enc_loop:  
      ;sum=sum+delta 
      mov ax, delta  ;assign delta value in ax  
      mov bx, sum    ;assign sum   value in bx
      add ax,bx      ;ax=ax+bx
      mov sum,ax     ;assign ax value in sum    
      ; v0 += ((v1<<4) + k0) ^ (v1 + sum) ^ ((v1>>5) + k1)    
      mov ax, v1     ;assign upper value  in register ax   
      mov bx, k0     ;assign k0 to register dx
      shl ax,4       ;shift left v1 by 4
      add ax,bx      ;ax=ax+bx ((v1 << 4) + k0)       
      ; dx ^= (v1 + sum) 
      mov dx,ax      ;dx for xoring 
      mov ax, v1     ;assign upper value  in register ax 
      mov bx,sum     ;assign bx value in sum
      add ax,bx      ;ax=ax+bx    (v1 + sum)
      xor dx,ax      ;dx=dx^ax
      ; dx ^= ((v1>>5) + k1)
      mov ax, v1     ;assign upper value  in register ax  
      shr ax, 5      ;shift  right v1 by 5    
      mov bx, k1     ;assign k0 to register dx
      add ax,bx      ;ax=ax+bx
      xor dx,ax      ;dx=dx^ax  
             
      mov ax,v0      ;assign v0 to ax   
      add ax,dx      ;ax=ax+dx v0=v0+xoring    
      mov v0,ax      ;assign value of ax register to v0
      
                          
     ;v1 += ((v0 << 4) + k2) ^ (v0 + sum) ^ ((v0 >> 5) + k3);   
      mov ax, v0     ;assign upper value  in register ax   
      mov bx, k2     ;assign k2 to register dx
      shl ax,4       ;shift left v0 by 4
      add ax,bx      ;ax=ax+bx ((v0 << 4) + k2)       
      ; dx ^= (v0 + sum) 
      mov dx,ax      ;dx for xoring 
      mov ax, v0     ;assign upper value  in register ax 
      mov bx,sum     ;assign bx value in sum
      add ax,bx      ;ax=ax+bx    (v0 + sum)
      xor dx,ax      ;dx=dx^ax
       ; dx ^= ((v0>>5) + k3)
      mov ax, v0     ;assign upper value  in register ax  
      shr ax, 5      ;shift  right v1 by 5    
      mov bx, k3     ;assign k3 to register dx
      add ax,bx      ;ax=ax+bx
      xor dx,ax      ;dx=dx^ax  
       ; v1 += dx       
      mov ax,v1      ;assign v1 to ax   
      add ax,dx      ;ax=ax+dx v1=v1+xoring    
      mov v1,ax      ;assign value of ax register to v1
             
             
  loop enc_loop          
ret
jmp endProgram       

encrypt endp  
   decrypt proc   
    
        mov cx, 8      ; counter for "loop" instruction
            
dec_Loop:      
        ; v1 -= ((v0<<4) + k2) ^ (v0 + sum) ^ ((v0>>5) + k3)
        ; dx = ((v0<<4) + k2)
        mov ax, v0
        shl ax, 4
        mov bx, k2
        add ax, bx
        mov dx, ax
        ; dx ^= (v0 + sum)
        mov ax, v0
        mov bx, sum
        add ax, bx
        xor dx, ax
        ; dx ^= ((v0>>5) + k3)
        mov ax, v0
        shr ax, 5
        mov bx, k3
        add ax, bx
        xor dx, ax
        ; v1 -= dx
        mov ax, v1
        sub ax, dx
        mov v1, ax
        
        ; v0 -= ((v1<<4) + k0) ^ (v1 + sum) ^ ((v1>>5) + k1)    
        ; dx = ((v1<<4) + k0)
        mov ax, v1
        shl ax, 4
        mov bx, k0
        add ax, bx
        mov dx, ax
        ; dx ^= (v1 + sum)
        mov ax, v1
        mov bx, sum
        add ax, bx
        xor dx, ax
        ; dx ^= ((v1>>5) + k1)
        mov ax, v1
        shr ax, 5
        mov bx, k1
        add ax, bx
        xor dx, ax
        ; v0 -= dx
        mov ax, v0
        sub ax, dx
        mov v0, ax 
        
        ; sum -= delta  
        mov bx, delta
        mov ax, sum
        sub ax, bx
        mov sum, ax 
        
loop dec_Loop          ; "loop" uses "cx" as its counter     
        
ret
decrypt endp
end         
jmp endProgram
;#include <stdio.h>
;
;unsigned short sum = 0;
;unsigned short delta = 0x02AC;
;unsigned short v0, v1;
;unsigned short k0 = 0x12A;
;unsigned short k1 = 0;
;unsigned short k2 = 0;
;unsigned short k3 = 0;
;
;void encrypt() {
;    unsigned short i;
;    for (i = 0; i < 32; ++i) {
;        sum += delta;
;
;        v0 += ((v1 << 4) + k0) ^ (v1 + sum) ^ ((v1 >> 5) + k1);
;        
;    }
;}
;
;void decrypt() {
;    unsigned short i;
;    for (i = 0; i < 32; ++i) {
;        v1 -= ((v0 << 4) + k2) ^ (v0 + sum) ^ ((v0 >> 5) + k3);
;        v0 -= ((v1 << 4) + k0) ^ (v1 + sum) ^ ((v1 >> 5) + k1);
;
;        sum -= delta;
;    }
;}
;
;int main() {
;    char choice;
;    do {
;        printf("Choose operation (1 for encrypt, 2 for encrypt then decrypt, 3 to exit): ");
;        scanf(" %c", &choice);
;
;        if (choice == '1' || choice == '2') {
;            printf("Enter lower 8 bits of text: ");
;            scanf("%hx", &v0);
;            printf("Enter upper 8 bits of text: ");
;            scanf("%hx", &v1);
;
;            if (choice == '2') {
;                printf("Encrypting...\n");
;                encrypt();
;
;                printf("Encrypted text: %hx %hx\n", v0, v1);
;
;                printf("Decrypting...\n");
;                decrypt();
;
;                printf("Decrypted text again: %hx %hx\n", v0, v1);
;            } else {
;                printf("Encrypting...\n");
;                encrypt();
;                printf("Encrypted text: %hx %hx\n", v0, v1);
;            }
;        }
;
;    } while (choice != '3');
;
;    return 0;
;}
;#include <stdio.h>
;
;unsigned short sum = 0;
;unsigned short delta = 0x02AC;
;unsigned short v0, v1;
;unsigned short k0 = 0x12A;
;unsigned short k1 = 0;
;unsigned short k2 = 0;
;unsigned short k3 = 0;
;
;void encrypt() {
;    unsigned short i;
;    for (i = 0; i < 32; ++i) {
;        sum += delta;
;
;        v0 += ((v1 << 4) + k0) ^ (v1 + sum) ^ ((v1 >> 5) + k1);
;        v1 += ((v0 << 4) + k2) ^ (v0 + sum) ^ ((v0 >> 5) + k3);
;    }
;}
;
;void decrypt() {
;    unsigned short i;
;    for (i = 0; i < 32; ++i) {
;        v1 -= ((v0 << 4) + k2) ^ (v0 + sum) ^ ((v0 >> 5) + k3);
;        v0 -= ((v1 << 4) + k0) ^ (v1 + sum) ^ ((v1 >> 5) + k1);
;
;        sum -= delta;
;    }
;}
;
;int main() {
;    char choice;
;    do {
;        printf("Choose operation (1 for encrypt, 2 for encrypt then decrypt, 3 to exit): ");
;        scanf(" %c", &choice);
;
;        if (choice == '1' || choice == '2') {
;            printf("Enter lower 8 bits of text: ");
;            scanf("%hx", &v0);
;            printf("Enter upper 8 bits of text: ");
;            scanf("%hx", &v1);
;
;            if (choice == '2') {
;                printf("Encrypting...\n");
;                encrypt();
;
;                printf("Encrypted text: %hx %hx\n", v0, v1);
;
;                printf("Decrypting...\n");
;                decrypt();
;
;                printf("Decrypted text again: %hx %hx\n", v0, v1);
;            } else {
;                printf("Encrypting...\n");
;                encrypt();
;                printf("Encrypted text: %hx %hx\n", v0, v1);
;            }
;        }
;
;    } while (choice != '3');
;
;    return 0;
;}