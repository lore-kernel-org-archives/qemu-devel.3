Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC20C48286
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 16:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUUmt-0008F3-7q; Mon, 29 Jan 2024 11:47:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUla-00060i-4U
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:45:55 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUlW-0003gM-32
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:45:49 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-337d05b8942so2707174f8f.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 08:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706546744; x=1707151544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C8JvjcuG17Z5H/fwKhCgUCDDHXtWs59z4HKxSgYIQak=;
 b=oTcODn7UfeAyv9Q4EQ/rhVwGz+zwGF9e9jvBsQ4Hqj8Qxs0ToIcMmGCzVsWiaZly0m
 0ORPBFKWo7r1VUfkVibk17oy7odmgEcXRSQTfAyUBD+RLCTZwvNmLZJ3rV7z6Ksw7c/l
 f8FtnMGRIh9MgGnTacYsK7raGITCy3mAD55WzN2dLU/rqU9b4OpVq3lOzYO6gzEwilWe
 0o7vPr9f9+ZP3lHitIDIF11bvS7fZ1xGVFBCIqMIHJ2h/pe+9CJSsRtA3RSHReB+P2C7
 UYN2JptJjUONut/+5i1ssBEM+QCnY0uchKZ3tW7oWw+cZx0jtfucoC+YfFxUJaZmWMgm
 K99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706546744; x=1707151544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C8JvjcuG17Z5H/fwKhCgUCDDHXtWs59z4HKxSgYIQak=;
 b=gOz3/W8CCp7xyQ+3D6F5wYJuSe4fW79KS9Opxvd9Qzc3dKcgZnYYhbl2vT/uL21fEi
 RIcZLPjJgmOSA7HrhI2QbOIR9XTJ1s3hBepjs6k3DXnTqUzQfObTa8FrlBLFe8zQ5cBz
 fvTgYJ5yOR6oWxZ26+hR0Iv5txDKdvldI60FWBEYY5KAFZe23Gypfh1e/utvOLzrk8Ha
 LbsDbJreVsXgYl/6EuJEUBtEUlR5u2SjM8YuS5IKZDRN2Pqx3zFdVWKMNJng+QcNApVe
 Vri6qTyUFikZ2WgRgLTQRPOb3K37J/T4lauC5ho6gxaXvcUUVm+rXdfx9isjW/yRXiwE
 fDXw==
X-Gm-Message-State: AOJu0YwK9AkbGN9C3kqIE3y8MVqq6wypmqoWgbU0ZIA5vdsnxoNX7lri
 S2IjgJOPQGgJ8KLCN3GW9yvxVslGleMiXxH1vdj2aNXxoIHjU84+uL3bGg9lMXcpp38FgFELBu9
 Y
X-Google-Smtp-Source: AGHT+IGsRS3mCrSQqdH7/CVh0bHEjVxZxEE4GjqLYzUtvxEToac4oiSaOtdxXr4oh5vfsiDP3ObnIg==
X-Received: by 2002:adf:ca8d:0:b0:339:2c1a:5d79 with SMTP id
 r13-20020adfca8d000000b003392c1a5d79mr4032395wrh.6.1706546744013; 
 Mon, 29 Jan 2024 08:45:44 -0800 (PST)
Received: from m1x-phil.lan ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a5d59c8000000b0033af2a91b47sm2057984wry.70.2024.01.29.08.45.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jan 2024 08:45:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Reinoud Zandijk <reinoud@netbsd.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Song Gao <gaosong@loongson.cn>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v3 04/29] bulk: Call in place single use cpu_env()
Date: Mon, 29 Jan 2024 17:44:46 +0100
Message-ID: <20240129164514.73104-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240129164514.73104-1-philmd@linaro.org>
References: <20240129164514.73104-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Avoid CPUArchState local variable when cpu_env() is used once.

Mechanical patch using the following Coccinelle spatch script:

 @@
 type CPUArchState;
 identifier env;
 expression cs;
 @@
  {
 -    CPUArchState *env = cpu_env(cs);
      ... when != env
 -     env
 +     cpu_env(cs)
      ... when != env
  }

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c             |  3 +--
 linux-user/i386/cpu_loop.c       |  4 ++--
 target/hppa/mem_helper.c         |  3 +--
 target/hppa/translate.c          |  3 +--
 target/i386/nvmm/nvmm-all.c      |  6 ++----
 target/i386/whpx/whpx-all.c      | 18 ++++++------------
 target/loongarch/tcg/translate.c |  3 +--
 target/rx/translate.c            |  3 +--
 target/sh4/op_helper.c           |  4 +---
 9 files changed, 16 insertions(+), 31 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 67eda9865e..86206484f8 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -445,7 +445,6 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
 static inline TranslationBlock * QEMU_DISABLE_CFI
 cpu_tb_exec(CPUState *cpu, TranslationBlock *itb, int *tb_exit)
 {
-    CPUArchState *env = cpu_env(cpu);
     uintptr_t ret;
     TranslationBlock *last_tb;
     const void *tb_ptr = itb->tc.ptr;
@@ -455,7 +454,7 @@ cpu_tb_exec(CPUState *cpu, TranslationBlock *itb, int *tb_exit)
     }
 
     qemu_thread_jit_execute();
-    ret = tcg_qemu_tb_exec(env, tb_ptr);
+    ret = tcg_qemu_tb_exec(cpu_env(cpu), tb_ptr);
     cpu->neg.can_do_io = true;
     qemu_plugin_disable_mem_helpers(cpu);
     /*
diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index 42ecb4bf0a..92beb6830c 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -323,8 +323,8 @@ void cpu_loop(CPUX86State *env)
 
 static void target_cpu_free(void *obj)
 {
-    CPUArchState *env = cpu_env(obj);
-    target_munmap(env->gdt.base, sizeof(uint64_t) * TARGET_GDT_ENTRIES);
+    target_munmap(cpu_env(obj)->gdt.base,
+                  sizeof(uint64_t) * TARGET_GDT_ENTRIES);
     g_free(obj);
 }
 
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 4fcc612754..bb85962d50 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -518,7 +518,6 @@ void HELPER(iitlbt_pa20)(CPUHPPAState *env, target_ulong r1, target_ulong r2)
 /* Purge (Insn/Data) TLB. */
 static void ptlb_work(CPUState *cpu, run_on_cpu_data data)
 {
-    CPUHPPAState *env = cpu_env(cpu);
     vaddr start = data.target_ptr;
     vaddr end;
 
@@ -532,7 +531,7 @@ static void ptlb_work(CPUState *cpu, run_on_cpu_data data)
     end = (vaddr)TARGET_PAGE_SIZE << (2 * end);
     end = start + end - 1;
 
-    hppa_flush_tlb_range(env, start, end);
+    hppa_flush_tlb_range(cpu_env(cpu), start, end);
 }
 
 /* This is local to the current cpu. */
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 3ef39b1bd7..5735335254 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3805,8 +3805,7 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
 
 #ifndef CONFIG_USER_ONLY
     if (ctx->tb_flags & PSW_C) {
-        CPUHPPAState *env = cpu_env(ctx->cs);
-        int type = hppa_artype_for_page(env, ctx->base.pc_next);
+        int type = hppa_artype_for_page(cpu_env(ctx->cs), ctx->base.pc_next);
         /* If we could not find a TLB entry, then we need to generate an
            ITLB miss exception so the kernel will provide it.
            The resulting TLB fill operation will invalidate this TB and
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index cfdca91123..49a3a3b916 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -340,7 +340,6 @@ nvmm_get_registers(CPUState *cpu)
 static bool
 nvmm_can_take_int(CPUState *cpu)
 {
-    CPUX86State *env = cpu_env(cpu);
     AccelCPUState *qcpu = cpu->accel;
     struct nvmm_vcpu *vcpu = &qcpu->vcpu;
     struct nvmm_machine *mach = get_nvmm_mach();
@@ -349,7 +348,7 @@ nvmm_can_take_int(CPUState *cpu)
         return false;
     }
 
-    if (qcpu->int_shadow || !(env->eflags & IF_MASK)) {
+    if (qcpu->int_shadow || !(cpu_env(cpu)->eflags & IF_MASK)) {
         struct nvmm_x64_state *state = vcpu->state;
 
         /* Exit on interrupt window. */
@@ -645,13 +644,12 @@ static int
 nvmm_handle_halted(struct nvmm_machine *mach, CPUState *cpu,
     struct nvmm_vcpu_exit *exit)
 {
-    CPUX86State *env = cpu_env(cpu);
     int ret = 0;
 
     bql_lock();
 
     if (!((cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
-          (env->eflags & IF_MASK)) &&
+          (cpu_env(cpu)->eflags & IF_MASK)) &&
         !(cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
         cpu->exception_index = EXCP_HLT;
         cpu->halted = true;
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index a7262654ac..31eec7048c 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -300,7 +300,6 @@ static SegmentCache whpx_seg_h2q(const WHV_X64_SEGMENT_REGISTER *hs)
 /* X64 Extended Control Registers */
 static void whpx_set_xcrs(CPUState *cpu)
 {
-    CPUX86State *env = cpu_env(cpu);
     HRESULT hr;
     struct whpx_state *whpx = &whpx_global;
     WHV_REGISTER_VALUE xcr0;
@@ -311,7 +310,7 @@ static void whpx_set_xcrs(CPUState *cpu)
     }
 
     /* Only xcr0 is supported by the hypervisor currently */
-    xcr0.Reg64 = env->xcr0;
+    xcr0.Reg64 = cpu_env(cpu)->xcr0;
     hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
         whpx->partition, cpu->cpu_index, &xcr0_name, 1, &xcr0);
     if (FAILED(hr)) {
@@ -321,7 +320,6 @@ static void whpx_set_xcrs(CPUState *cpu)
 
 static int whpx_set_tsc(CPUState *cpu)
 {
-    CPUX86State *env = cpu_env(cpu);
     WHV_REGISTER_NAME tsc_reg = WHvX64RegisterTsc;
     WHV_REGISTER_VALUE tsc_val;
     HRESULT hr;
@@ -345,7 +343,7 @@ static int whpx_set_tsc(CPUState *cpu)
         }
     }
 
-    tsc_val.Reg64 = env->tsc;
+    tsc_val.Reg64 = cpu_env(cpu)->tsc;
     hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
         whpx->partition, cpu->cpu_index, &tsc_reg, 1, &tsc_val);
     if (FAILED(hr)) {
@@ -556,7 +554,6 @@ static void whpx_set_registers(CPUState *cpu, int level)
 
 static int whpx_get_tsc(CPUState *cpu)
 {
-    CPUX86State *env = cpu_env(cpu);
     WHV_REGISTER_NAME tsc_reg = WHvX64RegisterTsc;
     WHV_REGISTER_VALUE tsc_val;
     HRESULT hr;
@@ -569,14 +566,13 @@ static int whpx_get_tsc(CPUState *cpu)
         return -1;
     }
 
-    env->tsc = tsc_val.Reg64;
+    cpu_env(cpu)->tsc = tsc_val.Reg64;
     return 0;
 }
 
 /* X64 Extended Control Registers */
 static void whpx_get_xcrs(CPUState *cpu)
 {
-    CPUX86State *env = cpu_env(cpu);
     HRESULT hr;
     struct whpx_state *whpx = &whpx_global;
     WHV_REGISTER_VALUE xcr0;
@@ -594,7 +590,7 @@ static void whpx_get_xcrs(CPUState *cpu)
         return;
     }
 
-    env->xcr0 = xcr0.Reg64;
+    cpu_env(cpu)->xcr0 = xcr0.Reg64;
 }
 
 static void whpx_get_registers(CPUState *cpu)
@@ -1400,8 +1396,7 @@ static vaddr whpx_vcpu_get_pc(CPUState *cpu, bool exit_context_valid)
 {
     if (cpu->vcpu_dirty) {
         /* The CPU registers have been modified by other parts of QEMU. */
-        CPUArchState *env = cpu_env(cpu);
-        return env->eip;
+        return cpu_env(cpu)->eip;
     } else if (exit_context_valid) {
         /*
          * The CPU registers have not been modified by neither other parts
@@ -1439,12 +1434,11 @@ static vaddr whpx_vcpu_get_pc(CPUState *cpu, bool exit_context_valid)
 
 static int whpx_handle_halt(CPUState *cpu)
 {
-    CPUX86State *env = cpu_env(cpu);
     int ret = 0;
 
     bql_lock();
     if (!((cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
-          (env->eflags & IF_MASK)) &&
+          (cpu_env(cpu)->eflags & IF_MASK)) &&
         !(cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
         cpu->exception_index = EXCP_HLT;
         cpu->halted = true;
diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
index 21f4db6fbd..7bb8cecab3 100644
--- a/target/loongarch/tcg/translate.c
+++ b/target/loongarch/tcg/translate.c
@@ -282,10 +282,9 @@ static uint64_t make_address_pc(DisasContext *ctx, uint64_t addr)
 
 static void loongarch_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 {
-    CPULoongArchState *env = cpu_env(cs);
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-    ctx->opcode = translator_ldl(env, &ctx->base, ctx->base.pc_next);
+    ctx->opcode = translator_ldl(cpu_env(cs), &ctx->base, ctx->base.pc_next);
 
     if (!decode(ctx, ctx->opcode)) {
         qemu_log_mask(LOG_UNIMP, "Error: unknown opcode. "
diff --git a/target/rx/translate.c b/target/rx/translate.c
index c6ce717a95..1829a0b1cd 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -2195,9 +2195,8 @@ static bool trans_WAIT(DisasContext *ctx, arg_WAIT *a)
 
 static void rx_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
-    CPURXState *env = cpu_env(cs);
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
-    ctx->env = env;
+    ctx->env = cpu_env(cs);
     ctx->tb_flags = ctx->base.tb->flags;
 }
 
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 54d390fe1f..4559d0d376 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -29,9 +29,7 @@ void superh_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                     MMUAccessType access_type,
                                     int mmu_idx, uintptr_t retaddr)
 {
-    CPUSH4State *env = cpu_env(cs);
-
-    env->tea = addr;
+    cpu_env(cs)->tea = addr;
     switch (access_type) {
     case MMU_INST_FETCH:
     case MMU_DATA_LOAD:
-- 
2.41.0


