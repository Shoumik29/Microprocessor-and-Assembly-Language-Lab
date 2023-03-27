;string reversal

.model small
.stack 100h

.data
     
str db 100 dup ?
msg1 db "Input String: $"
msg2 db "Reversed String: $"     
     
.code

main proc
    
    mov ax,@data
    mov ds,ax
    
    mov ah,9
    lea dx,msg1
    int 21h
    
    mov si,0
    
    input:
        
        mov ah,1
        int 21h
        cmp al,13
        je end_input
        
        mov str[si],al
        inc si
        
        jmp input
        
    
    end_input:
        
        call new_line
        
        mov ah,9
        lea dx,msg2
        int 21h
        
        dec si
    
    
    output:
        
        cmp si,0
        jl end_output
        
        mov ah,2
        mov dl,str[si]
        int 21h
        
        dec si
        
        jmp output
        
    
    end_output:
        
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