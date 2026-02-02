Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50223E7FDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 22:26:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn2MJ-0000CK-N6; Mon, 02 Feb 2026 17:25:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn2M2-0008Lt-BP
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:25:11 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn2Ly-0005uu-AR
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:25:10 -0500
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-48039fdc8aeso29741595e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 14:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770071104; x=1770675904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YstNmJa5PdlSLUf0W3RoDVAQE5Uz8f3BXKVj4i914pk=;
 b=nmiRCOv4qh/yfjn0Vf/bJwZhqPAFvvjFGmIIzLK2svsX9CrU9qsh1DDm/anvmqYoDQ
 7u7JEl2F6skVQ0mCzkYhAgzH4xbCxTncoLx9U1cYfS9O6pepjU2uLqw4KsoK2fD2SZ/z
 dnniQid9E0ZXuEQWCwv33VL6io/swRcJKxL/bdhU7Uvghnr6JnE3W01Di1mIkcAO15U4
 V0FiWhFUmREgELQr9aLxfy0bjcmEBDSlNcRU8su+JFwa6Wout1ngzLbeHTofyUZYfKQT
 YUbtSfIgNQN2qws4OeTCX6eGRwplgSaZg5BURuHrmCYF8zGCi9RnfuwVBd4QpbDKfund
 5VLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770071104; x=1770675904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YstNmJa5PdlSLUf0W3RoDVAQE5Uz8f3BXKVj4i914pk=;
 b=hSjWEEIYJMtE5RpH45bofFzdxSw597Jg9n7JCBRQnFvw0Qk6LF5iAHSJmNGxl/b93v
 3x9neRzXJOlj6vzxPMtJO8OQ+er7G7GN7NwnpCpQAXTf/OsmA1wunNHuaGcuUoo447i7
 julGH8saJBOKg+iGA26pf9+O9aweHCU8EjQu6Vioc87+H3lfcsfJtKkcUh4ZFnJsBUTm
 0MEEu+kkn9TAadW6TKoTsYa4RiW+dNFFjXZBENwTNeRWLsr9iauuZXUmz4kPycnLMrok
 VXB0CIyzK8kWwTOcZSgbjckhS8usX1YjdKQsyKwCVnYUnZzycfkuEJRSN3q8r0F8ndyO
 2fKA==
X-Gm-Message-State: AOJu0Yz3I2ZimWroRE0zqVH44uG5HFL0LfTP4VuW4dEROxhDmMO3W+mE
 pusovKx4CzSPASvG0MpmRCEtjI+rVkKOh3HMvP4vUbE8tGlH0phGaMxobLq7w/5dubLQrW+02Td
 fsSBdAEZZHQ==
X-Gm-Gg: AZuq6aIw7ghZmmVpUcYBHMVEjkQBCO4xLLlGdYNJUGNSI2Xg5kiI15KHiW2JkYgWZzi
 K5HuADQrT7kmj5iEkcE6BK2QC2JE/OADavnpX7GgnfRUMsOLhH6ISjpnjGHPNwvcGbe/xwIcosE
 A9/JCb0a7gxIszMRrrOHCHluxvr2gpuNteJxh52Op4Jv9JEzIdVDCuRpp/CIX54nWJWsK4etLMl
 KdOYkAhGhIQBnvSzB5PHhONum4JSBf6T/8XFtm6oZ35Pr/8XbBMdVKIahdwMfWtni4i44bZWjfU
 kVbzDsaM5vgqWEtNxxU+Hm6FX8/9V4WlmHnrCKaRazwuwGacs+Z8SoDiXDQB6ZN/GAPNiNbvMiy
 hBz/R/tx923aikn7JPpjSppWHeLjsM5JKh8LdXzKKL263Cxx/2O0O20MfR+DOgBVTUVEXyEOfVJ
 SPmnEVdyslY0sPa8IBtmatNUf8qTDsB0KzFZlMhYbCw5btMM+bB0jW2hki0zJY
X-Received: by 2002:a05:600c:818f:b0:47b:deb9:f8a with SMTP id
 5b1f17b1804b1-482db491bfbmr174421525e9.30.1770071104047; 
 Mon, 02 Feb 2026 14:25:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1322dc7sm47209527f8f.37.2026.02.02.14.25.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 14:25:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, Thomas Huth <thuth@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 7/7] disas: Have disas_set_info() take a const CPUState
Date: Mon,  2 Feb 2026 23:24:12 +0100
Message-ID: <20260202222412.24923-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202222412.24923-1-philmd@linaro.org>
References: <20260202222412.24923-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 61da2ea4331..b2d33aac262 100644
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
index 58816c51a74..d67db2e0064 100644
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
 
     if ((env->hflags >> MSR_LE) & 1) {
         info->endian = BFD_ENDIAN_LITTLE;
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


