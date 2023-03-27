.model small
.stack 100h

.data

msg1 db "Enter a number between(1-3): $"
msg2 db "Series summation: $"

n db ?
d db 2

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
    
    mov n,al
    inc n
    mul n
    div d    
    mov n,al 
      
    call new_line
    mov ah,9
    lea dx,msg2
    int 21h
    
    mov ah,2
    mov dl,n
    add dl,48
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
    