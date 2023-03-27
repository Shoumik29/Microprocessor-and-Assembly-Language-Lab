.model small
.stack 100h

.data

msg1 db "Input string: $"
msg2 db "Vowel count: $"
msg3 db "Consonant count: $"
msg4 db "Space count: $"
msg5 db "Number count: $"
msg6 db "Special count: $"

str db 100 dup ('$')

number_cnt db 0
vowel_cnt db 0
consonant_cnt db 0
space_cnt db 0
special_cnt db 0

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
        
    count:
        cmp str[si],'$'
        je print
        
        cmp str[si],'a'
        je vowel
        
        cmp str[si],'e'
        je vowel
        
        cmp str[si],'i'
        
        cmp str[si],'o'
        je vowel
        
        cmp str[si],'u'
        je vowel
        
        
        cmp str[si],'a'
        jge consonant_check
           
           
        cmp str[si],'0'
        jge number_check 
        
        
        cmp str[si],' '
        je space_check
        
        inc special_cnt
        inc si
        
        jmp count
     
     
     print:
        call new_line
        
        mov ah,9
        lea dx,msg2
        int 21h
        mov ah,2
        mov dl,vowel_cnt
        add dl,48
        int 21h
        call new_line
        
        mov ah,9
        lea dx,msg3
        int 21h
        mov ah,2
        mov dl,consonant_cnt
        add dl,48
        int 21h
        call new_line
        
        mov ah,9
        lea dx,msg4
        int 21h
        mov ah,2
        mov dl,space_cnt
        add dl,48
        int 21h
        call new_line
        
        mov ah,9
        lea dx,msg5
        int 21h
        mov ah,2
        mov dl,number_cnt
        add dl,48
        int 21h
        call new_line
        
        mov ah,9
        lea dx,msg6
        int 21h
        mov ah,2
        mov dl,special_cnt
        add dl,48
        int 21h
        call new_line
        
     
     exit:
        mov ah,4ch
        int 21h
        
        
     vowel:
        inc vowel_cnt
        inc si
        jmp count
     
     consonant_check:
        cmp str[si],'z'
        jle c_cnt
        
        inc si
        inc special_cnt
        jmp count
        
        c_cnt:
            inc consonant_cnt
            inc si
            jmp count
     
     number_check:
        cmp str[si],'9'
        jle n_cnt
        
        inc si
        inc special_cnt
        jmp count
        
        n_cnt:
            inc number_cnt
            inc si
            jmp count
     
     space_check:
        inc space_cnt
        inc si
        jmp count   
        
    
main endp

new_line proc
    
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h
    
    ret
    
new_line endp