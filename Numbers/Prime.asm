.model small
.stack 100h

.data

msg1 db "Enter a number between(0-9): $"
msg2 db "Prime$"
msg3 db "Not Prime$"

n db ?
d db ?

.code

main proc
    
    mov ax,@data
    mov ds,ax
    
    mov ah,9
    lea dx,msg1
    int 21h
    
    mov ah,1
    int 21h
    sub al,48
    
    cmp al,0
    je print_not_prime
    
    cmp al,1
    je print_not_prime 
    
    mov d,2
    mov n,al
    
    check_prime: 
        mov bl,d
        cmp n,bl
        je end_check
        
        mov al,n
        mov ah,0
        div d
        
        cmp ah,0
        je print_not_prime:
        
        inc d
        jmp check_prime
              
              
    end_check:
    
        
    print_prime:
        call new_line
        mov ah,9
        lea dx,msg2
        int 21h
            
        jmp exit
        
    print_not_prime:
        call new_line
        mov ah,9
        lea dx,msg3
        int 21h
        
    exit:
        mov ah,4ch
        int 21h
        
main endp

new_line proc
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h
    
    ret
new_line endp
    
     