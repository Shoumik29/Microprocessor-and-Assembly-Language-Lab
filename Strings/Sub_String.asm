.model small
.stack 100h

.data

msg1 db "Input string: $"
msg2 db "Input pattern: $"
msg3 db "Found$"
msg4 db "Not found$"

str db 100 dup ('$')
ptr db 100 dup ('$')
flag db 0

.code

main proc
    
    mov ax,@data
    mov ds,ax
    
    mov ah,9
    lea dx,msg1
    int 21h
    
    mov si,0
    mov di,0
    
    input_str:
        mov ah,1
        int 21h
        
        cmp al,13
        je middle
        
        mov str[si],al
        inc si
        
        jmp input_str
    
    middle:
        call new_line        
        mov ah,9
        lea dx,msg2
        int 21h
        
    input_ptr:
        mov ah,1
        int 21h
        
        cmp al,13
        je end_input
        
        mov ptr[di],al
        inc di
        
        jmp input_ptr
    
    end_input:
        mov str[si],'$'
        mov ptr[di],'$'

        call new_line 
        mov si,0
        mov di,0
        mov cx,0
           
    level:
        cmp ptr[di],'$'
        je found
        
        cmp str[si],'$'
        je print
        
        mov bl,str[si]
        mov bh,ptr[di]
    
        inc si
        inc di
        
        cmp bl,bh
        je count
        jne reset
        
        count:
            inc cx
            jmp level
        
        reset:
            mov di,0
            sub si,cx
            mov cx,0
            jmp level
 
    print:
        call new_line
        
        cmp flag,1
        je inner1
        jne inner2
        
        inner1:
            mov ah,9
            lea dx,msg3
            int 21h
            jmp exit
        
        inner2:
            mov ah,9
            lea dx,msg4
            int 21h
            jmp exit
            
    exit:
        mov ah,4ch
        int 21h
    
    found:
        mov flag,1
        jmp print
    
main endp

new_line proc
    
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h
    
    ret
    
new_line endp