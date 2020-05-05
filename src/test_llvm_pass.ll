; ModuleID = 'test_llvm_pass.c'
source_filename = "test_llvm_pass.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @__tsx_mpk_unsafe__lib() #0 !dbg !9 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  call void @llvm.dbg.declare(metadata i32* %1, metadata !12, metadata !DIExpression()), !dbg !18
  store i32 1, i32* %1, align 4, !dbg !18
  call void @llvm.dbg.declare(metadata i32* %2, metadata !19, metadata !DIExpression()), !dbg !20
  store i32 0, i32* %2, align 4, !dbg !20
  call void @llvm.dbg.declare(metadata i32* %3, metadata !21, metadata !DIExpression()), !dbg !22
  store i32 0, i32* %3, align 4, !dbg !22
  %4 = call i32 @pkey_set(i32 2, i32 2) #3, !dbg !23
  %5 = call i32 @pkey_free(i32 2) #3, !dbg !24
  %6 = call i32 @pkey_mprotect(i8* null, i64 4096, i32 3, i32 -1) #3, !dbg !25
  %7 = call i32 @pkey_mprotect(i8* null, i64 4096, i32 3, i32 2) #3, !dbg !26
  %8 = load i32, i32* %1, align 4, !dbg !27
  %9 = load i32, i32* %2, align 4, !dbg !28
  %10 = load i32, i32* %3, align 4, !dbg !29
  call void asm sideeffect ".byte 0x0f,0x01,0xef", "{ax},{cx},{dx},~{dirflag},~{fpsr},~{flags}"(i32 %8, i32 %9, i32 %10) #3, !dbg !30, !srcloc !31
  %11 = load i32, i32* %1, align 4, !dbg !32
  %12 = load i32, i32* %2, align 4, !dbg !33
  %13 = load i32, i32* %3, align 4, !dbg !34
  call void asm sideeffect ".byte 0x0f,0x01,0xef\0A\09", "{ax},{cx},{dx},~{dirflag},~{fpsr},~{flags}"(i32 %11, i32 %12, i32 %13) #3, !dbg !35, !srcloc !36
  call void asm sideeffect "WRPKRU", "~{dirflag},~{fpsr},~{flags}"() #3, !dbg !37, !srcloc !38
  call void asm sideeffect "wrpkru", "~{dirflag},~{fpsr},~{flags}"() #3, !dbg !39, !srcloc !40
  ret void, !dbg !41
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare dso_local i32 @pkey_set(i32, i32) #2

; Function Attrs: nounwind
declare dso_local i32 @pkey_free(i32) #2

; Function Attrs: nounwind
declare dso_local i32 @pkey_mprotect(i8*, i64, i32, i32) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !42 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  call void @llvm.dbg.declare(metadata i32* %2, metadata !46, metadata !DIExpression()), !dbg !47
  store i32 1, i32* %2, align 4, !dbg !47
  call void @llvm.dbg.declare(metadata i32* %3, metadata !48, metadata !DIExpression()), !dbg !49
  store i32 0, i32* %3, align 4, !dbg !49
  call void @llvm.dbg.declare(metadata i32* %4, metadata !50, metadata !DIExpression()), !dbg !51
  store i32 0, i32* %4, align 4, !dbg !51
  %5 = call i32 @pkey_set(i32 2, i32 2) #3, !dbg !52
  %6 = call i32 @pkey_free(i32 2) #3, !dbg !53
  %7 = call i32 @pkey_mprotect(i8* null, i64 4096, i32 3, i32 -1) #3, !dbg !54
  %8 = call i32 @pkey_mprotect(i8* null, i64 4096, i32 3, i32 2) #3, !dbg !55
  %9 = load i32, i32* %2, align 4, !dbg !56
  %10 = load i32, i32* %3, align 4, !dbg !57
  %11 = load i32, i32* %4, align 4, !dbg !58
  call void asm sideeffect ".byte 0x0f,0x01,0xef", "{ax},{cx},{dx},~{dirflag},~{fpsr},~{flags}"(i32 %9, i32 %10, i32 %11) #3, !dbg !59, !srcloc !60
  %12 = load i32, i32* %2, align 4, !dbg !61
  %13 = load i32, i32* %3, align 4, !dbg !62
  %14 = load i32, i32* %4, align 4, !dbg !63
  call void asm sideeffect ".byte 0x0f,0x01,0xef\0A\09", "{ax},{cx},{dx},~{dirflag},~{fpsr},~{flags}"(i32 %12, i32 %13, i32 %14) #3, !dbg !64, !srcloc !65
  call void asm sideeffect "WRPKRU", "~{dirflag},~{fpsr},~{flags}"() #3, !dbg !66, !srcloc !67
  call void asm sideeffect "wrpkru", "~{dirflag},~{fpsr},~{flags}"() #3, !dbg !68, !srcloc !69
  ret i32 0, !dbg !70
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 9.0.0 (https://github.com/llvm/llvm-project.git 0399d5a9682b3cef71c653373e38890c63c4c365)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, nameTableKind: None)
!1 = !DIFile(filename: "test_llvm_pass.c", directory: "/home/chakshutandon/tsx-mpk/src")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 9.0.0 (https://github.com/llvm/llvm-project.git 0399d5a9682b3cef71c653373e38890c63c4c365)"}
!9 = distinct !DISubprogram(name: "__tsx_mpk_unsafe__lib", scope: !1, file: !1, line: 8, type: !10, scopeLine: 8, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{null}
!12 = !DILocalVariable(name: "pkru", scope: !9, file: !1, line: 9, type: !13)
!13 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !14, line: 26, baseType: !15)
!14 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-uintn.h", directory: "")
!15 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !16, line: 41, baseType: !17)
!16 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types.h", directory: "")
!17 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!18 = !DILocation(line: 9, column: 14, scope: !9)
!19 = !DILocalVariable(name: "ecx", scope: !9, file: !1, line: 9, type: !13)
!20 = !DILocation(line: 9, column: 24, scope: !9)
!21 = !DILocalVariable(name: "edx", scope: !9, file: !1, line: 9, type: !13)
!22 = !DILocation(line: 9, column: 33, scope: !9)
!23 = !DILocation(line: 12, column: 5, scope: !9)
!24 = !DILocation(line: 14, column: 5, scope: !9)
!25 = !DILocation(line: 16, column: 5, scope: !9)
!26 = !DILocation(line: 18, column: 5, scope: !9)
!27 = !DILocation(line: 20, column: 46, scope: !9)
!28 = !DILocation(line: 20, column: 56, scope: !9)
!29 = !DILocation(line: 20, column: 65, scope: !9)
!30 = !DILocation(line: 20, column: 5, scope: !9)
!31 = !{i32 432}
!32 = !DILocation(line: 22, column: 50, scope: !9)
!33 = !DILocation(line: 22, column: 60, scope: !9)
!34 = !DILocation(line: 22, column: 69, scope: !9)
!35 = !DILocation(line: 22, column: 5, scope: !9)
!36 = !{i32 516, i32 539}
!37 = !DILocation(line: 24, column: 5, scope: !9)
!38 = !{i32 604}
!39 = !DILocation(line: 26, column: 5, scope: !9)
!40 = !{i32 645}
!41 = !DILocation(line: 27, column: 1, scope: !9)
!42 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 29, type: !43, scopeLine: 29, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!43 = !DISubroutineType(types: !44)
!44 = !{!45}
!45 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!46 = !DILocalVariable(name: "pkru", scope: !42, file: !1, line: 30, type: !13)
!47 = !DILocation(line: 30, column: 14, scope: !42)
!48 = !DILocalVariable(name: "ecx", scope: !42, file: !1, line: 30, type: !13)
!49 = !DILocation(line: 30, column: 24, scope: !42)
!50 = !DILocalVariable(name: "edx", scope: !42, file: !1, line: 30, type: !13)
!51 = !DILocation(line: 30, column: 33, scope: !42)
!52 = !DILocation(line: 33, column: 5, scope: !42)
!53 = !DILocation(line: 35, column: 5, scope: !42)
!54 = !DILocation(line: 37, column: 5, scope: !42)
!55 = !DILocation(line: 39, column: 5, scope: !42)
!56 = !DILocation(line: 41, column: 46, scope: !42)
!57 = !DILocation(line: 41, column: 56, scope: !42)
!58 = !DILocation(line: 41, column: 65, scope: !42)
!59 = !DILocation(line: 41, column: 5, scope: !42)
!60 = !{i32 976}
!61 = !DILocation(line: 43, column: 50, scope: !42)
!62 = !DILocation(line: 43, column: 60, scope: !42)
!63 = !DILocation(line: 43, column: 69, scope: !42)
!64 = !DILocation(line: 43, column: 5, scope: !42)
!65 = !{i32 1062, i32 1085}
!66 = !DILocation(line: 45, column: 5, scope: !42)
!67 = !{i32 1152}
!68 = !DILocation(line: 47, column: 5, scope: !42)
!69 = !{i32 1195}
!70 = !DILocation(line: 49, column: 5, scope: !42)
