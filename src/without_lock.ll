; ModuleID = 'without_lock.c'
source_filename = "without_lock.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.__tsx_mpk__shared_memory_struct = type { i8*, i64, i32, %union.pthread_mutex_t }
%union.pthread_mutex_t = type { %struct.__pthread_mutex_s }
%struct.__pthread_mutex_s = type { i32, i32, i32, i32, i32, i16, i16, %struct.__pthread_internal_list }
%struct.__pthread_internal_list = type { %struct.__pthread_internal_list*, %struct.__pthread_internal_list* }

@.str = private unnamed_addr constant [29 x i8] c"Writing to shared memory...\0A\00", align 1
@.str.1 = private unnamed_addr constant [30 x i8] c"Value of shared memory: 0x%x\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.__tsx_mpk__shared_memory_struct*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i64, align 8
  %5 = alloca i32*, align 8
  store i32 0, i32* %1, align 4
  %6 = call %struct.__tsx_mpk__shared_memory_struct* @__tsx_mpk_unsafe__init_shared_memory_struct(i64 4096)
  store %struct.__tsx_mpk__shared_memory_struct* %6, %struct.__tsx_mpk__shared_memory_struct** %2, align 8
  %7 = load %struct.__tsx_mpk__shared_memory_struct*, %struct.__tsx_mpk__shared_memory_struct** %2, align 8
  call void @__tsx_mpk__set_shared_memory_struct(%struct.__tsx_mpk__shared_memory_struct* %7)
  store i32 -559038737, i32* %3, align 4
  store i64 4, i64* %4, align 8
  %8 = load %struct.__tsx_mpk__shared_memory_struct*, %struct.__tsx_mpk__shared_memory_struct** %2, align 8
  %9 = getelementptr inbounds %struct.__tsx_mpk__shared_memory_struct, %struct.__tsx_mpk__shared_memory_struct* %8, i32 0, i32 2
  %10 = load i32, i32* %9, align 8
  %11 = call i32 @pkey_set(i32 %10, i32 0) #4
  %12 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str, i64 0, i64 0))
  %13 = load %struct.__tsx_mpk__shared_memory_struct*, %struct.__tsx_mpk__shared_memory_struct** %2, align 8
  %14 = getelementptr inbounds %struct.__tsx_mpk__shared_memory_struct, %struct.__tsx_mpk__shared_memory_struct* %13, i32 0, i32 0
  %15 = load i8*, i8** %14, align 8
  %16 = bitcast i32* %3 to i8*
  %17 = load i64, i64* %4, align 8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %15, i8* align 4 %16, i64 %17, i1 false)
  %18 = load %struct.__tsx_mpk__shared_memory_struct*, %struct.__tsx_mpk__shared_memory_struct** %2, align 8
  %19 = getelementptr inbounds %struct.__tsx_mpk__shared_memory_struct, %struct.__tsx_mpk__shared_memory_struct* %18, i32 0, i32 0
  %20 = load i8*, i8** %19, align 8
  %21 = load i64, i64* %4, align 8
  %22 = call i8* @__tsx_mpk__read(i8* %20, i64 %21)
  %23 = bitcast i8* %22 to i32*
  store i32* %23, i32** %5, align 8
  %24 = load i32*, i32** %5, align 8
  %25 = load i32, i32* %24, align 4
  %26 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.1, i64 0, i64 0), i32 %25)
  ret i32 0
}

declare dso_local %struct.__tsx_mpk__shared_memory_struct* @__tsx_mpk_unsafe__init_shared_memory_struct(i64) #1

declare dso_local void @__tsx_mpk__set_shared_memory_struct(%struct.__tsx_mpk__shared_memory_struct*) #1

; Function Attrs: nounwind
declare dso_local i32 @pkey_set(i32, i32) #2

declare dso_local i32 @printf(i8*, ...) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1 immarg) #3

declare dso_local i8* @__tsx_mpk__read(i8*, i64) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 9.0.0 (https://github.com/llvm/llvm-project.git 0399d5a9682b3cef71c653373e38890c63c4c365)"}
