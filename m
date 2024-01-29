Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDF5C47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 16:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUUoC-0004pJ-IZ; Mon, 29 Jan 2024 11:48:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUn1-00008Y-7s
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:47:25 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUmv-00049n-Jx
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:47:18 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33aef64f702so610708f8f.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 08:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706546830; x=1707151630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a1GRxsPkPoYM/j9b9XVxD2Uv8+2XdiDkavqzy6v+eQw=;
 b=l75F1M+UT8AQEVnvVC4OdWYUUxlfQSjhiPTLLWUlCj/hf59P9NLHvqRqOICNZxVsJ5
 u86T79mnws12QcuZBZ4NAocUBU0+mi4lHS5pMgTuT2JE47AKTdlSA+3rIMEvNinBXgV4
 hcHaF6mVHyxyyN4YufOy56QTY2t+t0ODliKeSRzQrrTP9Ubh2EO2NRwV5R7wGFMR5gG/
 ClrNBisR8uAqiyE9tNkIrtAh96/NOVuQ2nN+kWVCpZviJfpE1LNoZQxhAV8C9NP+iQdS
 TS/VEW62ATcr3IAg9U/9W5SIIIhzBOkJUh6u0TAi4n6GiYI6As803GZDbQtMuuP4WCgG
 Te7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706546830; x=1707151630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a1GRxsPkPoYM/j9b9XVxD2Uv8+2XdiDkavqzy6v+eQw=;
 b=omTWiZXY9c+MEW1KmqH5J5MpexZ56W/X9jAWrULOz4dUvzUedZQVhXaymEwq2RVTuZ
 LT+T7+JDLY9a0olsZRBUhecOQIq+CMtfEamk6lYMl0Tbr/0up2VTEt9kRM2ZBPVcmN+H
 cKeWWKFdU68WOMhyvw+F7j4u63iS1SVJzw5+nZULrz1ZgioLIk6yZf4Hy5JawRa/UEiV
 qLg5mSgEF0Qz1/VTSYdbJUpXvqF2pY+nyBLmQoBqEgKr/0PxvFKMRqbAt9qvXZM9bGmj
 MZbn3s57HkwxHQRuHI3jzMt7MOqgyKEILMifyAt0XQY5o/udwy7AarQoR+tVDvo27LaB
 elIw==
X-Gm-Message-State: AOJu0YwowICjMQAplYkpsZbi+nOlFukcwUyZ77dUqkfArvwf2H7RZLP5
 Z53NP77edJEmmZjQYoa2EyWPj9s4Qc7ZTIr0O5+GQ4FTXY12NprirSirsu+LPA9GDzTvKboHRKH
 f
X-Google-Smtp-Source: AGHT+IEpEpjILUE8/G6pqPee5gIH5YxC8wNTBQ4S47nuLxugvg/Jof6ItSCTwlZoBEcJKZyXSOwA2g==
X-Received: by 2002:adf:f5c7:0:b0:33a:f505:c0f3 with SMTP id
 k7-20020adff5c7000000b0033af505c0f3mr1122952wrp.2.1706546830355; 
 Mon, 29 Jan 2024 08:47:10 -0800 (PST)
Received: from m1x-phil.lan ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 k14-20020adff28e000000b003392172fd60sm8453319wro.51.2024.01.29.08.47.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jan 2024 08:47:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH v3 18/29] target/mips: Prefer fast cpu_env() over slower CPU
 QOM cast macro
Date: Mon, 29 Jan 2024 17:45:00 +0100
Message-ID: <20240129164514.73104-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240129164514.73104-1-philmd@linaro.org>
References: <20240129164514.73104-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Mechanical patch produced running the command documented
in scripts/coccinelle/cpu_env.cocci_template header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/cpu.c                       | 15 ++++----------
 target/mips/gdbstub.c                   |  6 ++----
 target/mips/kvm.c                       | 27 +++++++++----------------
 target/mips/sysemu/physaddr.c           |  3 +--
 target/mips/tcg/exception.c             |  3 +--
 target/mips/tcg/op_helper.c             |  8 +++-----
 target/mips/tcg/sysemu/special_helper.c |  3 +--
 target/mips/tcg/sysemu/tlb_helper.c     |  6 ++----
 target/mips/tcg/translate.c             |  3 +--
 9 files changed, 24 insertions(+), 50 deletions(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 6ced52f985..1bea76e40a 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -80,8 +80,7 @@ static void fpu_dump_state(CPUMIPSState *env, FILE *f, int flags)
 
 static void mips_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
     int i;
 
     qemu_fprintf(f, "pc=0x" TARGET_FMT_lx " HI=0x" TARGET_FMT_lx
@@ -123,9 +122,7 @@ void cpu_set_exception_base(int vp_index, target_ulong address)
 
 static void mips_cpu_set_pc(CPUState *cs, vaddr value)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-
-    mips_env_set_pc(&cpu->env, value);
+    mips_env_set_pc(cpu_env(cs), value);
 }
 
 static vaddr mips_cpu_get_pc(CPUState *cs)
@@ -137,8 +134,7 @@ static vaddr mips_cpu_get_pc(CPUState *cs)
 
 static bool mips_cpu_has_work(CPUState *cs)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
     bool has_work = false;
 
     /*
@@ -428,10 +424,7 @@ static void mips_cpu_reset_hold(Object *obj)
 
 static void mips_cpu_disas_set_info(CPUState *s, disassemble_info *info)
 {
-    MIPSCPU *cpu = MIPS_CPU(s);
-    CPUMIPSState *env = &cpu->env;
-
-    if (!(env->insn_flags & ISA_NANOMIPS32)) {
+    if (!(cpu_env(s)->insn_flags & ISA_NANOMIPS32)) {
 #if TARGET_BIG_ENDIAN
         info->print_insn = print_insn_big_mips;
 #else
diff --git a/target/mips/gdbstub.c b/target/mips/gdbstub.c
index 62d7b72407..169d47416a 100644
--- a/target/mips/gdbstub.c
+++ b/target/mips/gdbstub.c
@@ -25,8 +25,7 @@
 
 int mips_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
 
     if (n < 32) {
         return gdb_get_regl(mem_buf, env->active_tc.gpr[n]);
@@ -78,8 +77,7 @@ int mips_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
 int mips_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
     target_ulong tmp;
 
     tmp = ldtul_p(mem_buf);
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index 15d0cf9adb..6c52e59f55 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -63,8 +63,7 @@ int kvm_arch_irqchip_create(KVMState *s)
 
 int kvm_arch_init_vcpu(CPUState *cs)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
     int ret = 0;
 
     qemu_add_vm_change_state_handler(kvm_mips_update_state, cs);
@@ -460,8 +459,7 @@ static inline int kvm_mips_change_one_reg(CPUState *cs, uint64_t reg_id,
  */
 static int kvm_mips_save_count(CPUState *cs)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
     uint64_t count_ctl;
     int err, ret = 0;
 
@@ -502,8 +500,7 @@ static int kvm_mips_save_count(CPUState *cs)
  */
 static int kvm_mips_restore_count(CPUState *cs)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
     uint64_t count_ctl;
     int err_dc, err, ret = 0;
 
@@ -590,8 +587,7 @@ static void kvm_mips_update_state(void *opaque, bool running, RunState state)
 
 static int kvm_mips_put_fpu_registers(CPUState *cs, int level)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
     int err, ret = 0;
     unsigned int i;
 
@@ -670,8 +666,7 @@ static int kvm_mips_put_fpu_registers(CPUState *cs, int level)
 
 static int kvm_mips_get_fpu_registers(CPUState *cs)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
     int err, ret = 0;
     unsigned int i;
 
@@ -751,8 +746,7 @@ static int kvm_mips_get_fpu_registers(CPUState *cs)
 
 static int kvm_mips_put_cp0_registers(CPUState *cs, int level)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
     int err, ret = 0;
 
     (void)level;
@@ -974,8 +968,7 @@ static int kvm_mips_put_cp0_registers(CPUState *cs, int level)
 
 static int kvm_mips_get_cp0_registers(CPUState *cs)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
     int err, ret = 0;
 
     err = kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_INDEX, &env->CP0_Index);
@@ -1181,8 +1174,7 @@ static int kvm_mips_get_cp0_registers(CPUState *cs)
 
 int kvm_arch_put_registers(CPUState *cs, int level)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
     struct kvm_regs regs;
     int ret;
     int i;
@@ -1217,8 +1209,7 @@ int kvm_arch_put_registers(CPUState *cs, int level)
 
 int kvm_arch_get_registers(CPUState *cs)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
     int ret = 0;
     struct kvm_regs regs;
     int i;
diff --git a/target/mips/sysemu/physaddr.c b/target/mips/sysemu/physaddr.c
index 05990aa5bb..56380dfe6c 100644
--- a/target/mips/sysemu/physaddr.c
+++ b/target/mips/sysemu/physaddr.c
@@ -230,8 +230,7 @@ int get_physical_address(CPUMIPSState *env, hwaddr *physical,
 
 hwaddr mips_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
     hwaddr phys_addr;
     int prot;
 
diff --git a/target/mips/tcg/exception.c b/target/mips/tcg/exception.c
index da49a93912..13275d1ded 100644
--- a/target/mips/tcg/exception.c
+++ b/target/mips/tcg/exception.c
@@ -79,8 +79,7 @@ void helper_wait(CPUMIPSState *env)
 
 void mips_cpu_synchronize_from_tb(CPUState *cs, const TranslationBlock *tb)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
 
     tcg_debug_assert(!(cs->tcg_cflags & CF_PCREL));
     env->active_tc.PC = tb->pc;
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index 98935b5e64..65403f1a87 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -279,8 +279,7 @@ void mips_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                   MMUAccessType access_type,
                                   int mmu_idx, uintptr_t retaddr)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
     int error_code = 0;
     int excp;
 
@@ -306,9 +305,8 @@ void mips_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                     int mmu_idx, MemTxAttrs attrs,
                                     MemTxResult response, uintptr_t retaddr)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    MIPSCPUClass *mcc = MIPS_CPU_GET_CLASS(cpu);
-    CPUMIPSState *env = &cpu->env;
+    MIPSCPUClass *mcc = MIPS_CPU_GET_CLASS(cs);
+    CPUMIPSState *env = cpu_env(cs);
 
     if (access_type == MMU_INST_FETCH) {
         do_raise_exception(env, EXCP_IBE, retaddr);
diff --git a/target/mips/tcg/sysemu/special_helper.c b/target/mips/tcg/sysemu/special_helper.c
index 93276f789d..7934f2ea41 100644
--- a/target/mips/tcg/sysemu/special_helper.c
+++ b/target/mips/tcg/sysemu/special_helper.c
@@ -90,8 +90,7 @@ static void debug_post_eret(CPUMIPSState *env)
 
 bool mips_io_recompile_replay_branch(CPUState *cs, const TranslationBlock *tb)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
 
     if ((env->hflags & MIPS_HFLAG_BMASK) != 0
         && !(cs->tcg_cflags & CF_PCREL) && env->active_tc.PC != tb->pc) {
diff --git a/target/mips/tcg/sysemu/tlb_helper.c b/target/mips/tcg/sysemu/tlb_helper.c
index 4ede904800..6c48c4fa80 100644
--- a/target/mips/tcg/sysemu/tlb_helper.c
+++ b/target/mips/tcg/sysemu/tlb_helper.c
@@ -910,8 +910,7 @@ bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                        MMUAccessType access_type, int mmu_idx,
                        bool probe, uintptr_t retaddr)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
     hwaddr physical;
     int prot;
     int ret = TLBRET_BADADDR;
@@ -1346,8 +1345,7 @@ void mips_cpu_do_interrupt(CPUState *cs)
 bool mips_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     if (interrupt_request & CPU_INTERRUPT_HARD) {
-        MIPSCPU *cpu = MIPS_CPU(cs);
-        CPUMIPSState *env = &cpu->env;
+        CPUMIPSState *env = cpu_env(cs);
 
         if (cpu_mips_hw_interrupts_enabled(env) &&
             cpu_mips_hw_interrupts_pending(env)) {
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 13e43fa3b6..e74b98de1c 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -15628,8 +15628,7 @@ void mips_restore_state_to_opc(CPUState *cs,
                                const TranslationBlock *tb,
                                const uint64_t *data)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
 
     env->active_tc.PC = data[0];
     env->hflags &= ~MIPS_HFLAG_BMASK;
-- 
2.41.0


