Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948A1E87842
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnI0k-00025k-UR; Tue, 03 Feb 2026 10:08:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnI0i-00024D-Hp
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:08:12 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnI0g-0002g9-CX
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:08:12 -0500
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-48069a48629so59568835e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770131288; x=1770736088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Bdm0aHGmNQ9zZ+AvlsmblG6PXHwSDdk0ED8Izh6zOxU=;
 b=P4ZNoPV2+Tcqq2YAMELgubZh6CaN2+Ti5BWcqootkB3BnZy02T3Orb19E6ulUGpGyd
 Jv6aQoYO4McROvXP2FNAy9Jp2Q2Kdb2ho4G8/ve48oPl8JG+z0SIJxt1wH/G++Ueen9p
 e873sEYbunH0U/Ftz/XNNGlwDy2HyE5+NE4FPBK4iMojV1oImDOlDNqwpnTfFR7zD+P6
 PARRFUJRVluFnrZchw2m79gd2Co+VJXaB9/fXTUUKlkvYldjOPFaBfJpD0WMM4PMsgsz
 dd6jyNFlc/sIgfUg32SaPWSJXaQAzmDj0YRApmzrYD7iwabtghq9Op5ZGEH9bxlD5F5r
 9JYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770131288; x=1770736088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Bdm0aHGmNQ9zZ+AvlsmblG6PXHwSDdk0ED8Izh6zOxU=;
 b=DaG5F2ak7CE6bHgmgVFZiyeOcYw/9swtwiFrAZltrGdSuGPD/faAw16oCJuEJW7qJP
 DTDhZMaUJfS8u/Qu9ZavKpbGCC8SKfwDM6smk1lvE2MKeCoWAmQAFxoKbg8Bq9vw0eK/
 1eoU+aXCU3jVOWnSXDkMOLPZUKltyjH55S6FJ/p6poY/U29Zp31we2I8MCMCqFBhRRsM
 SCv58bQed7jv0NhkMaFfX7IEVtH6orGodbncc/i91ScBl71TJORxbCwLQWKAb1UcAl3G
 n+w3cEuVkuQwxF/kkQuDdS5wy2xsGVyQ7m7QoNP//Vpsrq4qV5cqpyb399SP9sQxw+KX
 nc+w==
X-Gm-Message-State: AOJu0Yx/1bvg9wMYfC54333LtTrnpazi4cSNUay6vDusGnJwTHsBru0L
 9lkU3gquwbhSrMZzKlY+WyLui1X2dIvaDn9JizrkxY5mKOxBwjqgNZYxOVVYOHfbsRRs19a1e14
 84WU56u9GJQ==
X-Gm-Gg: AZuq6aJqhd2GpQQfvlkiN3qowcODkcQULq4drmsSHbaNIaWZVp3+AsK8SYJwpnRiTZw
 0xiCU+3ef8ldwPZpvXZJapzGG9fQRACxvOp3rJaB6MVEVGtpWTlLFwQTVi9cXhIABUGGLYNTCZr
 Qu4/DCks9h8bbCy6jt5xc8QD6u/A2YkraHgM2+/tVkaAcsRdLWyEUBeM/LB3fOIeb+3LUxuclo7
 w0f7FS3xU4ozbqwuHWW9LTb07gGpIYoeSNPzPtvqN6OlF31Lsy/2xEqRjFuTOlxhhz81Bo84EDN
 AvReltYJBmr0KkGk6r3ygzZeKdbU6+T/kWkLhqY5xziycZVOli9KXQtaPLGdpdsxWTHF9Ss0B6C
 zv6P+hMhfFwuJARIsrtroPF93AyMnmFY89oPSWRm93QVeFuCTnBG0evJ00QFXOK1KFYsH+GTmkq
 4ihmWn0k9wC9V3SMKs0eTKGyBpJMY3Yma+TgpmNU8pMLeE0Y/lHvPR9S4yd7Uu
X-Received: by 2002:a05:600c:810c:b0:47e:e414:b915 with SMTP id
 5b1f17b1804b1-482db44d338mr191892875e9.2.1770131287576; 
 Tue, 03 Feb 2026 07:08:07 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e13235f5sm49413868f8f.29.2026.02.03.07.08.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 07:08:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/30] disas: Have disas_set_info() take a const CPUState
Date: Tue,  3 Feb 2026 16:04:35 +0100
Message-ID: <20260203150436.71907-31-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203150436.71907-1-philmd@linaro.org>
References: <20260203150436.71907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x342.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The CPUClass::disas_set_info() handler is meant to initialize
the %disassemble_info structure; it shoudn't alter the CPU state.
Enforce the CPUState can not be modified by having the handler
take a const pointer.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260202222412.24923-8-philmd@linaro.org>
---
 include/hw/core/cpu.h   | 2 +-
 target/alpha/cpu.c      | 3 ++-
 target/arm/cpu.c        | 6 +++---
 target/avr/cpu.c        | 2 +-
 target/hexagon/cpu.c    | 3 ++-
 target/hppa/cpu.c       | 2 +-
 target/i386/cpu.c       | 6 +++---
 target/loongarch/cpu.c  | 3 ++-
 target/m68k/cpu.c       | 2 +-
 target/microblaze/cpu.c | 2 +-
 target/mips/cpu.c       | 7 +++++--
 target/openrisc/cpu.c   | 2 +-
 target/ppc/cpu_init.c   | 5 +++--
 target/riscv/cpu.c      | 7 ++++---
 target/rx/cpu.c         | 2 +-
 target/s390x/cpu.c      | 2 +-
 target/sh4/cpu.c        | 3 ++-
 target/sparc/cpu.c      | 3 ++-
 target/xtensa/cpu.c     | 3 ++-
 19 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 98678704a64..ef20cb356a6 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -175,7 +175,7 @@ struct CPUClass {
     const char * (*gdb_arch_name)(CPUState *cpu);
     const char * (*gdb_get_core_xml_file)(CPUState *cpu);
 
-    void (*disas_set_info)(CPUState *cpu, disassemble_info *info);
+    void (*disas_set_info)(const CPUState *cpu, disassemble_info *info);
 
     const char *deprecation_note;
     struct AccelCPUClass *accel_cpu;
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 932cddac055..1780db7d1e2 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -98,7 +98,8 @@ static int alpha_cpu_mmu_index(CPUState *cs, bool ifetch)
     return alpha_env_mmu_index(cpu_env(cs));
 }
 
-static void alpha_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
+static void alpha_cpu_disas_set_info(const CPUState *cpu,
+                                     disassemble_info *info)
 {
     info->endian = BFD_ENDIAN_LITTLE;
     info->mach = bfd_mach_alpha_ev6;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 586202071d0..c535b292d99 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -789,10 +789,10 @@ static void arm_wfxt_timer_cb(void *opaque)
 }
 #endif
 
-static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
+static void arm_disas_set_info(const CPUState *cpu, disassemble_info *info)
 {
-    ARMCPU *ac = ARM_CPU(cpu);
-    CPUARMState *env = &ac->env;
+    const ARMCPU *ac = ARM_CPU(cpu);
+    const CPUARMState *env = &ac->env;
     bool sctlr_b = arm_sctlr_b(env);
 
     if (is_a64(env)) {
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 52237da3ce9..8579a7283b1 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -116,7 +116,7 @@ static void avr_cpu_reset_hold(Object *obj, ResetType type)
     memset(env->r, 0, sizeof(env->r));
 }
 
-static void avr_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
+static void avr_cpu_disas_set_info(const CPUState *cpu, disassemble_info *info)
 {
     info->endian = BFD_ENDIAN_LITTLE;
     info->mach = bfd_arch_avr;
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 8ac4f49aa3b..58a22ee41f2 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -301,7 +301,8 @@ static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
     set_float_default_nan_pattern(0b11111111, &env->fp_status);
 }
 
-static void hexagon_cpu_disas_set_info(CPUState *s, disassemble_info *info)
+static void hexagon_cpu_disas_set_info(const CPUState *cs,
+                                       disassemble_info *info)
 {
     info->print_insn = print_insn_hexagon;
     info->endian = BFD_ENDIAN_LITTLE;
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 0ca79ee5e23..714f3bbdaf7 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -150,7 +150,7 @@ static int hppa_cpu_mmu_index(CPUState *cs, bool ifetch)
     return env->psw & PSW_W ? MMU_ABS_W_IDX : MMU_ABS_IDX;
 }
 
-static void hppa_cpu_disas_set_info(CPUState *cs, disassemble_info *info)
+static void hppa_cpu_disas_set_info(const CPUState *cs, disassemble_info *info)
 {
     info->mach = bfd_mach_hppa20;
     info->endian = BFD_ENDIAN_BIG;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 45f0b80deb0..0a7b884528e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10359,10 +10359,10 @@ static bool x86_cpu_has_work(CPUState *cs)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-static void x86_disas_set_info(CPUState *cs, disassemble_info *info)
+static void x86_disas_set_info(const CPUState *cs, disassemble_info *info)
 {
-    X86CPU *cpu = X86_CPU(cs);
-    CPUX86State *env = &cpu->env;
+    const X86CPU *cpu = X86_CPU(cs);
+    const CPUX86State *env = &cpu->env;
 
     info->endian = BFD_ENDIAN_LITTLE;
     info->mach = (env->hflags & HF_CS64_MASK ? bfd_mach_x86_64
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index b6539485266..4fa629cb144 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -506,7 +506,8 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
     cs->exception_index = -1;
 }
 
-static void loongarch_cpu_disas_set_info(CPUState *s, disassemble_info *info)
+static void loongarch_cpu_disas_set_info(const CPUState *cs,
+                                         disassemble_info *info)
 {
     info->endian = BFD_ENDIAN_LITTLE;
     info->print_insn = print_insn_loongarch;
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index b55e604b11d..c721a23b966 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -176,7 +176,7 @@ static void m68k_cpu_reset_hold(Object *obj, ResetType type)
     env->pc = 0;
 }
 
-static void m68k_cpu_disas_set_info(CPUState *s, disassemble_info *info)
+static void m68k_cpu_disas_set_info(const CPUState *cs, disassemble_info *info)
 {
     info->print_insn = print_insn_m68k;
     info->endian = BFD_ENDIAN_BIG;
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 53649ec6567..ae41a1a3287 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -233,7 +233,7 @@ static void mb_cpu_reset_hold(Object *obj, ResetType type)
 #endif
 }
 
-static void mb_disas_set_info(CPUState *cpu, disassemble_info *info)
+static void mb_disas_set_info(const CPUState *cpu, disassemble_info *info)
 {
     info->mach = bfd_arch_microblaze;
     info->print_insn = print_insn_microblaze;
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index f74a9d5f615..e424d115018 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -422,9 +422,12 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
 #endif
 }
 
-static void mips_cpu_disas_set_info(CPUState *s, disassemble_info *info)
+static void mips_cpu_disas_set_info(const CPUState *cs, disassemble_info *info)
 {
-    if (!(cpu_env(s)->insn_flags & ISA_NANOMIPS32)) {
+    const MIPSCPU *cpu = MIPS_CPU(cs);
+    const CPUMIPSState *env = &cpu->env;
+
+    if (!(env->insn_flags & ISA_NANOMIPS32)) {
         info->endian = TARGET_BIG_ENDIAN ? BFD_ENDIAN_BIG
                                          : BFD_ENDIAN_LITTLE;
         info->print_insn = TARGET_BIG_ENDIAN ? print_insn_big_mips
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 9bbfe22ed3a..c64542a59a2 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -94,7 +94,7 @@ static int openrisc_cpu_mmu_index(CPUState *cs, bool ifetch)
     return MMU_NOMMU_IDX;  /* mmu is disabled */
 }
 
-static void openrisc_disas_set_info(CPUState *cpu, disassemble_info *info)
+static void openrisc_disas_set_info(const CPUState *cpu, disassemble_info *info)
 {
     info->endian = BFD_ENDIAN_BIG;
     info->print_insn = print_insn_or1k;
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index c5cec7c2ed9..c36fd118a99 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7452,9 +7452,10 @@ static bool ppc_pvr_match_default(PowerPCCPUClass *pcc, uint32_t pvr, bool best)
     return pcc->pvr == pvr;
 }
 
-static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
+static void ppc_disas_set_info(const CPUState *cs, disassemble_info *info)
 {
-    CPUPPCState *env = cpu_env(cs);
+    const PowerPCCPU *cpu = POWERPC_CPU(cs);
+    const CPUPPCState *env = &cpu->env;
 
     info->endian = ppc_env_is_little_endian(env) ? BFD_ENDIAN_LITTLE
                                                  : BFD_ENDIAN_BIG;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e95eea02493..e56470a3748 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -795,10 +795,11 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
 #endif
 }
 
-static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
+static void riscv_cpu_disas_set_info(const CPUState *s, disassemble_info *info)
 {
-    RISCVCPU *cpu = RISCV_CPU(s);
-    CPURISCVState *env = &cpu->env;
+    const RISCVCPU *cpu = RISCV_CPU(s);
+    const CPURISCVState *env = &cpu->env;
+
     info->target_info = &cpu->cfg;
 
     /*
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 0437edca1ba..b5284199e6d 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -178,7 +178,7 @@ static void rx_cpu_set_irq(void *opaque, int no, int request)
     }
 }
 
-static void rx_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
+static void rx_cpu_disas_set_info(const CPUState *cpu, disassemble_info *info)
 {
     info->endian = BFD_ENDIAN_LITTLE;
     info->mach = bfd_mach_rx;
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index cd472d38be7..c074e12ba2d 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -222,7 +222,7 @@ static void s390_cpu_reset_hold(Object *obj, ResetType type)
     }
 }
 
-static void s390_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
+static void s390_cpu_disas_set_info(const CPUState *cpu, disassemble_info *info)
 {
     info->mach = bfd_mach_s390_64;
     info->cap_arch = CS_ARCH_SYSZ;
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 1dd21ad9ed6..e2bde457618 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -164,7 +164,8 @@ static void superh_cpu_reset_hold(Object *obj, ResetType type)
     set_float_ftz_detection(float_ftz_before_rounding, &env->fp_status);
 }
 
-static void superh_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
+static void superh_cpu_disas_set_info(const CPUState *cpu,
+                                      disassemble_info *info)
 {
     info->endian = TARGET_BIG_ENDIAN ? BFD_ENDIAN_BIG
                                      : BFD_ENDIAN_LITTLE;
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index bfc6fb9d00d..3991681d1d1 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -103,7 +103,8 @@ static bool sparc_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-static void cpu_sparc_disas_set_info(CPUState *cpu, disassemble_info *info)
+static void cpu_sparc_disas_set_info(const CPUState *cpu,
+                                     disassemble_info *info)
 {
     info->print_insn = print_insn_sparc;
     info->endian = BFD_ENDIAN_BIG;
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index ecc5e093a40..86ec899a67c 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -226,7 +226,8 @@ static ObjectClass *xtensa_cpu_class_by_name(const char *cpu_model)
     return oc;
 }
 
-static void xtensa_cpu_disas_set_info(CPUState *cs, disassemble_info *info)
+static void xtensa_cpu_disas_set_info(const CPUState *cs,
+                                      disassemble_info *info)
 {
     XtensaCPU *cpu = XTENSA_CPU(cs);
 
-- 
2.52.0


