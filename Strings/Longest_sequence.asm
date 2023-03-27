.model small
.stack 100h

.data

str db 100 dup ?
msg1 db 'Input string: $' 
msg2 db 'Long sequence: $'
max dw 0
max_i dw 0

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
        mov str[si],'$'
        mov si,0
        mov cx,0
        
        
    level:        
        mov dl,str[si]
        inc si
        mov bl,str[si]
                                                
        cmp bl,'$'
        je final_check
        
        cmp bl,dl
        jge count
        jl reset
        
        count:
            inc cx
            jmp level
        
        reset:
            cmp max,cx
            jg inner1
            jle inner2
            
            inner1:
                mov cx,0
                jmp level
            
            inner2:
                mov max,cx
                mov dx,si
                sub dx,cx
                sub dx,1
                mov max_i,dx
                mov cx,0
                jmp level
                
    final_check:
        cmp max,cx
        jl update
        jge print
        
        update:
            mov max,cx
            mov dx,si
            sub dx,cx
            sub dx,1
            mov max_i,dx 
    
    print:   
        call new_line
        mov ah,9
        lea dx,msg2
        int 21h
        
        mov si,max_i
        
        mov cx,max
              
        loop1:
            cmp cx,0
            jl exit
            
            mov ah,2
            mov dl,str[si]
            int 21h
            
            inc si
            dec cx
            
            jmp loop1
            
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