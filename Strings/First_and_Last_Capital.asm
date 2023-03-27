.model small
.stack 100h

.data

str db 100 dup ?
msg1 db "input string: $"
msg2 db "first capital letter: $"
msg3 db "last capital letter: $"
msg4 db "no capitals $"
first db ' '
last db ' '
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
        
        jmp input
            
    
    end_input:    
        mov str[si],'$'
        mov bl,'A'
        mov cx,0
        mov si,0
        
        
    update: 
        cmp str[si],'$'
        je reset
            
        cmp bl,str[si]
        jne lv1 
        
        cmp flag,0
        je first_update
            
        mov last,bl
            
        lv1:
            inc si
            jmp update
        
        reset:
            cmp cx,26
            je print
            
            inc bl
            inc cx
            mov si,0
            
            jmp update                  
   
            
     print:
        cmp first,' '
        je empty
        
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
        call new_line
        mov ah,9
        lea dx,msg4
        int 21h 
        
        jmp exit
        
                       
     first_update:
        mov first,bl
        mov bl,'A'
        mov cx,0
        mov si,0
        mov flag,1
        
        jmp update
        
    
main endp


new_line proc
    
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h
    
    ret
    
new_line endp