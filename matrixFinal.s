.data
   n_patrat:.space 4
   numar_vector:.space 4
   ea:.space 4
   ece:.space 4
   contor_final:.space 4
   c:.space 4
   n:.space 4
   nr_leg:.space 4
   leg:.space 4
   v:.space 400
   vleg:.space 400
   vfinal:.space 40000
   formatScanf:.asciz "%d"
   formatPrintf:.asciz "%d "
   newLine:.asciz "\n"

.text

.global main

main:

   push $c
   push $formatScanf
   call scanf
   pop %ebx
   pop %ebx

   cmpl $1, c
   je cerinta1
   cmpl $2, c
   je cerinta2
   cmpl $3, c
   je cerinta3
   jmp et_exit

cerinta1:

   push $n
   push $formatScanf
   call scanf
   pop %ebx
   pop %ebx

   movl $0, %ecx
   movl %ecx, ece
   
   movl n, %eax
   mull %eax
   movl %eax, n_patrat
   
   movl $0, %eax

for_v:

   movl ece, %ecx
   cmp n, %ecx
   je for_vleg_pregatire

   push $nr_leg
   push $formatScanf
   call scanf
   pop %ebx
   pop %ebx

   lea v, %edi

   movl ece, %ecx
   movl nr_leg, %eax

   movl %eax, (%edi, %ecx, 4)

   incl %ecx
   mov %ecx, ece
   jmp for_v

for_vleg_pregatire:

   movl $0, %ecx
   movl %ecx, ece
   movl $0, %eax
   movl %eax, contor_final

for_vleg:

   movl ece, %ecx
   lea vleg, %esi
   lea v, %edi

   movl (%edi, %ecx, 4), %edx
   movl %edx, numar_vector
   cmp n, %ecx
   je afisare
   movl $0, %eax
   incl %ecx
   movl %ecx, ece

  for_leg_zero:

     cmp n, %eax
     je for_leg_unu_premise
     movl $0, (%esi, %eax, 4)
     inc %eax
     jmp for_leg_zero

    for_leg_unu_premise:

       movl $0, %eax
       movl %eax, ea

    for_leg_unu:
       movl ea, %eax
       cmp %edx, %eax
       je for_vfinal_premise

       push $leg
       push $formatScanf
       call scanf
       pop %ebx
       pop %ebx

       movl ece, %ecx
       lea v, %edi
       lea vleg, %esi
       movl ea, %eax
       incl %eax
       movl %eax, ea

       movl leg, %edx
       movl $1, (%esi, %edx, 4)
       
       movl numar_vector, %edx

       jmp for_leg_unu

            for_vfinal_premise:

               lea vfinal, %edi
               movl $0, %eax
               movl $0, %ecx

            for_vfinal:

               cmp n, %ecx
               je for_vleg
                  
               movl contor_final, %eax
               movl (%esi, %ecx, 4), %edx
               movl %edx, (%edi, %eax, 4)

               inc %ecx
               inc %eax
               movl %eax, contor_final

               jmp for_vfinal

afisare:

   mov $0, %ecx
   mov %ecx, ece
  
   movl $0, %eax
   movl %eax, ea
   jmp afisare2
   
afisare2:
   mov ea, %eax
   mov ece, %ecx
   lea vfinal, %edi
   
   cmp n, %eax
   je endl
   
   movl (%edi, %ecx, 4), %edx
   
   cmp n_patrat, %ecx
   je et_exit

   push %edx
   push $formatPrintf
   call printf
   pop %ebx
   pop %ebx

   mov ea, %eax
   inc %eax
   mov %eax, ea

   mov ece, %ecx
   inc %ecx
   mov %ecx, ece

   jmp afisare2

endl:
   
   push $newLine
   call printf
   pop %ebx
   movl $0, %eax
   movl %eax, ea
   jmp afisare2

cerinta2:

cerinta3:

et_exit:
   mov $0, %eax
   mov $1, %ebx
   int $0x80