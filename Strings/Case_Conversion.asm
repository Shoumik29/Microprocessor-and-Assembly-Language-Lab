; lower case to upper case string converter

.model small
.stack 100h

.data

str db 100 dup ?
msg1 db "Enter the input string: $"
msg2 db "After Changing Cases: $"

.code 

main proc
    
    mov ax,@data
    mov ds,ax
    
    mov ah,9
    lea dx,msg1  ;lea->load effective address
    int 21h
    
    
    mov si,0
    mov di,0
    
    
    input:
        
        mov ah,1
        int 21h
        
        cmp al,13   ;13 carriage return
        je end_input
        
        cmp al,'z'
        jg no_change
        
        cmp al,'A'
        jl no_change
        
        cmp al,'Z'
        jg between
        
        jmp change 
                  
                  
    between:
        
        cmp al,'a'
        jl no_change    
           
           
    change:
        
        xor al,32  ;Case Conversion
        
    
    no_change:
        
        mov str[si],al
        inc si
        
        jmp input
            
            
    end_input:
    
        call new_line
        
        mov ah,9
        lea dx,msg2
        int 21h  
        
    
    output:
    
        mov dl,str[di]
        cmp di,si
        je end_output
        
        mov ah,2
        int 21h
        inc di
        
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


end main