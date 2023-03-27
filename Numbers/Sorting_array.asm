.model small
.stack 100h

.data

msg1 db "Enter the array elements(0-9) : $"
msg2 db "Sorted ascending: $"
msg3 db "Sorted descending: $"

arr db 100 dup ('$')
n dw ?

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
        
        sub al,48
        mov arr[si],al
        inc si
        
        jmp input
        
   end_input:
        dec si
        mov n,si
        
   mov cx,n
   
   outter:
        mov si,0
        mov di,1
        
        inner:
            mov bl,arr[si]
            cmp bl,arr[di]
            jl skip
            
            xchg bl,arr[di]
            mov arr[si],bl
            
            skip:
                cmp di,n
                je end_inner
                inc di
                inc si
                jmp inner
            
            end_inner:
                loop outter
        
        
    print: 
        call new_line
        mov ah,9
        lea dx,msg2
        int 21h
        
        mov si,0
        mov cx,n
        inc cx
        
        mov ah,2
        
        ascend:
            mov dl,arr[si]
            add dl,48
            int 21h
            inc si
            
            loop ascend
        
        call new_line
        mov ah,9
        lea dx,msg3
        int 21h
        
        mov si,n
        mov cx,n
        inc cx
        
        mov ah,2
        
        descend:
            mov dl,arr[si]
            add dl,48
            int 21h           
            dec si
            
            loop descend
        
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