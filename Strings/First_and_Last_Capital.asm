.model small
.stack 100h

.data

str db 100 dup ?
msg1 db "input string: $"
msg2 db "first capital letter: $"
msg3 db "last capital letter: $"
msg4 db "no capitals $"
first db 'Z'
last db 'A'
flag db 0

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
        
        cmp al,first
        jl first_update
        
        cmp al,last
        jg last_update
        
        jmp input
            
    
    end_input:    
        mov str[si],'$'
        
    
    empty_check:
        cmp flag,0
        je empty
                     
            
     print:
        
        call new_line
        mov ah,9
        lea dx,msg2
        int 21h
        
        mov ah,2
        mov dl,first
        int 21h
        
        call new_line
        mov ah,9
        lea dx,msg3
        int 21h
        
        mov ah,2
        mov dl,last
        int 21h
              
              
     exit:
        mov ah,4ch
        int 21h
            
             
     empty:
        mov first,' '
        mov last,' '
        jmp print
        
                   
     first_update:
        mov first,al
        mov flag,1
        jmp input
     
     last_update:
        cmp al,'Z'
        jg input
        mov last,al
        mov flag,1
        jmp input
        
    
main endp


new_line proc
    
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h
    
    ret
    
new_line endp