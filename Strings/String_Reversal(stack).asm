.model small
.stack 100h

.data

msg1 db 'Give input: $'
msg2 db 'Reversed output: $'

.code

main proc
    
    mov ax,@data
    mov ds,ax
    
    
    mov ah,9
    lea dx,msg1
    int 21h
    
    
    mov ax,'$'
    push ax
    
    
    input:
        mov ah,1
        int 21h
        
        cmp al,13
        je end_input
        
        push ax        
        jmp input
    
    
    
    end_input:
        call new_line          
           
        mov ah,9
        lea dx,msg2
        int 21h
    
    
    print:
        pop dx
        
        cmp dx,'$'
        je exit
        
        mov ah,2
        int 21h
        
        jmp print
    
    
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