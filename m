Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C86F9C47DDB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 04:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTx13-0005D8-Fw; Sat, 27 Jan 2024 23:43:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0y-0005Ah-Cq
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:43:28 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0v-0004OO-Gl
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:43:27 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d51ba18e1bso17846945ad.0
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 20:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706417004; x=1707021804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fDrlqZJJ0WFNjsqbAt49Vqu9oOvOnIDnuEZmci/Hrlo=;
 b=G3thYD7Hi0FxzXc24i5PY6XCFBTwwssQngC59XDGDBDBoEVmM9DhxFVOlwgPRZGhiP
 VQ35llQ3vprFPLI+3y6wMREzePkL5YlZRYrLTx8pWo5L4jvLSqVhuw0dRNz7hNqQYkDX
 9BawaxutgHSVqLS2Q/OwxPGQfW+EX1lOvTp1tAmhzpsYfsVFvcYGv8gDoARPBu3a0SZL
 KtZWJE12610xN4HE9X7taDJWuQF4yUtmlv3cvHoq6hfuAtdEc2d86kQcuptbp93UV6tG
 yr+6qJ+wahGT/rDmLsVgW0jXVVf1YsAGyCJ9s2WuyUKEy3tDuTkF9RNq/bko7ncCmjum
 Gtkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706417004; x=1707021804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fDrlqZJJ0WFNjsqbAt49Vqu9oOvOnIDnuEZmci/Hrlo=;
 b=Vjt7CGLPJNKETmhnAuHQROUQgqJ5xUWvDquKxD0P4x/z2c2g6U7+A0gpbT8h71+9qZ
 CtLbJxqp9BZUks/ci+FvfVqCh5c2D6E2t+/bjLAw2Url5yjtZQA+LiHtmtzPKVC5W4vm
 0JWQvSXbmmXdE28lXoHwfBS6IW2Crh+yd+tSfgp/w4OrK+PUWCQQcbSvwmXnlk+va3e/
 n2qo2QnymJkvGenwrp/Xoq/1AA4WfH+pHAbJSLhSnENzK3kPeKg/BfUC07F408btS8Gr
 y7/wMe5fw/VeXZ4ewph3r4ZQ3tD0V+M0GAA7/4OFLmgiYvi0RYlneJ5XRUC+djpRlQlK
 eR/Q==
X-Gm-Message-State: AOJu0Ywm78qi1986TPTVMupVYzRJxKgdNyW1cGAHFF72VtwDkpnDKgPG
 uIH8JZu/mgiFrzzzq2yqqBpsHiURcUscFqXPg+BT5IqlH5FTQNkSFHqQ0mQRLgUHt6PcQcNzaFW
 J3oQXcg==
X-Google-Smtp-Source: AGHT+IHLORWmHjOGBfVxW2ppm2CRKT4gXuHf6Zzm/QGW1hmYU8Ci1BeVSt5LgdYNFh56Rntddnp8RA==
X-Received: by 2002:a17:903:41c8:b0:1d8:d3e8:c31c with SMTP id
 u8-20020a17090341c800b001d8d3e8c31cmr246672ple.105.1706417003986; 
 Sat, 27 Jan 2024 20:43:23 -0800 (PST)
Received: from stoup..
 (ppp121-45-131-89.bri-pow-que-bras31.tpg.internode.on.net. [121.45.131.89])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a17090aaf9800b002906e09e1d1sm5631873pjq.18.2024.01.27.20.43.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 20:43:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 26/33] include/qemu: Add TCGCPUOps typedef to typedefs.h
Date: Sun, 28 Jan 2024 14:42:06 +1000
Message-Id: <20240128044213.316480-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128044213.316480-1-richard.henderson@linaro.org>
References: <20240128044213.316480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

QEMU coding style recommends using structure typedefs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h      | 5 +----
 include/qemu/typedefs.h    | 1 +
 bsd-user/signal.c          | 4 ++--
 linux-user/signal.c        | 4 ++--
 target/alpha/cpu.c         | 2 +-
 target/arm/cpu.c           | 2 +-
 target/arm/tcg/cpu32.c     | 2 +-
 target/avr/cpu.c           | 2 +-
 target/cris/cpu.c          | 4 ++--
 target/hexagon/cpu.c       | 2 +-
 target/hppa/cpu.c          | 2 +-
 target/i386/tcg/tcg-cpu.c  | 2 +-
 target/loongarch/cpu.c     | 2 +-
 target/m68k/cpu.c          | 2 +-
 target/microblaze/cpu.c    | 2 +-
 target/mips/cpu.c          | 2 +-
 target/nios2/cpu.c         | 2 +-
 target/openrisc/cpu.c      | 2 +-
 target/ppc/cpu_init.c      | 2 +-
 target/riscv/tcg/tcg-cpu.c | 2 +-
 target/rx/cpu.c            | 2 +-
 target/s390x/cpu.c         | 2 +-
 target/sh4/cpu.c           | 2 +-
 target/sparc/cpu.c         | 2 +-
 target/tricore/cpu.c       | 2 +-
 target/xtensa/cpu.c        | 2 +-
 26 files changed, 29 insertions(+), 31 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index db58f12233..2c284d6397 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -90,9 +90,6 @@ typedef enum MMUAccessType {
 
 typedef struct CPUWatchpoint CPUWatchpoint;
 
-/* see tcg-cpu-ops.h */
-struct TCGCPUOps;
-
 /* see accel-cpu.h */
 struct AccelCPUClass;
 
@@ -177,7 +174,7 @@ struct CPUClass {
     const struct SysemuCPUOps *sysemu_ops;
 
     /* when TCG is not available, this pointer is NULL */
-    const struct TCGCPUOps *tcg_ops;
+    const TCGCPUOps *tcg_ops;
 
     /*
      * if not NULL, this is called in order for the CPUClass to initialize
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 5abdbc3874..d7c703b4ae 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -131,6 +131,7 @@ typedef struct Range Range;
 typedef struct ReservedRegion ReservedRegion;
 typedef struct SHPCDevice SHPCDevice;
 typedef struct SSIBus SSIBus;
+typedef struct TCGCPUOps TCGCPUOps;
 typedef struct TCGHelperInfo TCGHelperInfo;
 typedef struct TranslationBlock TranslationBlock;
 typedef struct VirtIODevice VirtIODevice;
diff --git a/bsd-user/signal.c b/bsd-user/signal.c
index ca31470772..f4352e4530 100644
--- a/bsd-user/signal.c
+++ b/bsd-user/signal.c
@@ -1022,7 +1022,7 @@ void process_pending_signals(CPUArchState *env)
 void cpu_loop_exit_sigsegv(CPUState *cpu, target_ulong addr,
                            MMUAccessType access_type, bool maperr, uintptr_t ra)
 {
-    const struct TCGCPUOps *tcg_ops = CPU_GET_CLASS(cpu)->tcg_ops;
+    const TCGCPUOps *tcg_ops = CPU_GET_CLASS(cpu)->tcg_ops;
 
     if (tcg_ops->record_sigsegv) {
         tcg_ops->record_sigsegv(cpu, addr, access_type, maperr, ra);
@@ -1038,7 +1038,7 @@ void cpu_loop_exit_sigsegv(CPUState *cpu, target_ulong addr,
 void cpu_loop_exit_sigbus(CPUState *cpu, target_ulong addr,
                           MMUAccessType access_type, uintptr_t ra)
 {
-    const struct TCGCPUOps *tcg_ops = CPU_GET_CLASS(cpu)->tcg_ops;
+    const TCGCPUOps *tcg_ops = CPU_GET_CLASS(cpu)->tcg_ops;
 
     if (tcg_ops->record_sigbus) {
         tcg_ops->record_sigbus(cpu, addr, access_type, ra);
diff --git a/linux-user/signal.c b/linux-user/signal.c
index c9527adfa3..d3e62ab030 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -671,7 +671,7 @@ void force_sigsegv(int oldsig)
 void cpu_loop_exit_sigsegv(CPUState *cpu, target_ulong addr,
                            MMUAccessType access_type, bool maperr, uintptr_t ra)
 {
-    const struct TCGCPUOps *tcg_ops = CPU_GET_CLASS(cpu)->tcg_ops;
+    const TCGCPUOps *tcg_ops = CPU_GET_CLASS(cpu)->tcg_ops;
 
     if (tcg_ops->record_sigsegv) {
         tcg_ops->record_sigsegv(cpu, addr, access_type, maperr, ra);
@@ -687,7 +687,7 @@ void cpu_loop_exit_sigsegv(CPUState *cpu, target_ulong addr,
 void cpu_loop_exit_sigbus(CPUState *cpu, target_ulong addr,
                           MMUAccessType access_type, uintptr_t ra)
 {
-    const struct TCGCPUOps *tcg_ops = CPU_GET_CLASS(cpu)->tcg_ops;
+    const TCGCPUOps *tcg_ops = CPU_GET_CLASS(cpu)->tcg_ops;
 
     if (tcg_ops->record_sigbus) {
         tcg_ops->record_sigbus(cpu, addr, access_type, ra);
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index ce20a56270..80760be0f3 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -222,7 +222,7 @@ static const struct SysemuCPUOps alpha_sysemu_ops = {
 
 #include "hw/core/tcg-cpu-ops.h"
 
-static const struct TCGCPUOps alpha_tcg_ops = {
+static const TCGCPUOps alpha_tcg_ops = {
     .initialize = alpha_translate_init,
     .restore_state_to_opc = alpha_restore_state_to_opc,
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 0ee9a879f0..e050928598 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2456,7 +2456,7 @@ static const struct SysemuCPUOps arm_sysemu_ops = {
 #endif
 
 #ifdef CONFIG_TCG
-static const struct TCGCPUOps arm_tcg_ops = {
+static const TCGCPUOps arm_tcg_ops = {
     .initialize = arm_translate_init,
     .synchronize_from_tb = arm_cpu_synchronize_from_tb,
     .debug_excp_handler = arm_debug_excp_handler,
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index d9e0e2a4dd..1125305115 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -1018,7 +1018,7 @@ static void pxa270c5_initfn(Object *obj)
     cpu->reset_sctlr = 0x00000078;
 }
 
-static const struct TCGCPUOps arm_v7m_tcg_ops = {
+static const TCGCPUOps arm_v7m_tcg_ops = {
     .initialize = arm_translate_init,
     .synchronize_from_tb = arm_cpu_synchronize_from_tb,
     .debug_excp_handler = arm_debug_excp_handler,
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 76dbe56284..41ff121d20 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -233,7 +233,7 @@ static const struct SysemuCPUOps avr_sysemu_ops = {
 
 #include "hw/core/tcg-cpu-ops.h"
 
-static const struct TCGCPUOps avr_tcg_ops = {
+static const TCGCPUOps avr_tcg_ops = {
     .initialize = avr_cpu_tcg_init,
     .synchronize_from_tb = avr_cpu_synchronize_from_tb,
     .restore_state_to_opc = avr_restore_state_to_opc,
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index 6512ef8ee2..93f26542d8 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -192,7 +192,7 @@ static const struct SysemuCPUOps cris_sysemu_ops = {
 
 #include "hw/core/tcg-cpu-ops.h"
 
-static const struct TCGCPUOps crisv10_tcg_ops = {
+static const TCGCPUOps crisv10_tcg_ops = {
     .initialize = cris_initialize_crisv10_tcg,
     .restore_state_to_opc = cris_restore_state_to_opc,
 
@@ -203,7 +203,7 @@ static const struct TCGCPUOps crisv10_tcg_ops = {
 #endif /* !CONFIG_USER_ONLY */
 };
 
-static const struct TCGCPUOps crisv32_tcg_ops = {
+static const TCGCPUOps crisv32_tcg_ops = {
     .initialize = cris_initialize_tcg,
     .restore_state_to_opc = cris_restore_state_to_opc,
 
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index b2bbb21b59..49f05eae99 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -358,7 +358,7 @@ static void hexagon_cpu_init(Object *obj)
 
 #include "hw/core/tcg-cpu-ops.h"
 
-static const struct TCGCPUOps hexagon_tcg_ops = {
+static const TCGCPUOps hexagon_tcg_ops = {
     .initialize = hexagon_translate_init,
     .synchronize_from_tb = hexagon_cpu_synchronize_from_tb,
     .restore_state_to_opc = hexagon_restore_state_to_opc,
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 2cc8e43b33..2d98082306 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -225,7 +225,7 @@ static const struct SysemuCPUOps hppa_sysemu_ops = {
 
 #include "hw/core/tcg-cpu-ops.h"
 
-static const struct TCGCPUOps hppa_tcg_ops = {
+static const TCGCPUOps hppa_tcg_ops = {
     .initialize = hppa_translate_init,
     .synchronize_from_tb = hppa_cpu_synchronize_from_tb,
     .restore_state_to_opc = hppa_restore_state_to_opc,
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index e1405b7be9..8e148e9bc4 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -106,7 +106,7 @@ static bool x86_debug_check_breakpoint(CPUState *cs)
 
 #include "hw/core/tcg-cpu-ops.h"
 
-static const struct TCGCPUOps x86_tcg_ops = {
+static const TCGCPUOps x86_tcg_ops = {
     .initialize = tcg_x86_init,
     .synchronize_from_tb = x86_cpu_synchronize_from_tb,
     .restore_state_to_opc = x86_restore_state_to_opc,
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index ea4281e177..d9ddab5b9a 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -758,7 +758,7 @@ void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 #ifdef CONFIG_TCG
 #include "hw/core/tcg-cpu-ops.h"
 
-static struct TCGCPUOps loongarch_tcg_ops = {
+static TCGCPUOps loongarch_tcg_ops = {
     .initialize = loongarch_translate_init,
     .synchronize_from_tb = loongarch_cpu_synchronize_from_tb,
     .restore_state_to_opc = loongarch_restore_state_to_opc,
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index f9dc447897..288140c986 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -546,7 +546,7 @@ static const struct SysemuCPUOps m68k_sysemu_ops = {
 
 #include "hw/core/tcg-cpu-ops.h"
 
-static const struct TCGCPUOps m68k_tcg_ops = {
+static const TCGCPUOps m68k_tcg_ops = {
     .initialize = m68k_tcg_init,
     .restore_state_to_opc = m68k_restore_state_to_opc,
 
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 4c270e941f..171937564d 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -410,7 +410,7 @@ static const struct SysemuCPUOps mb_sysemu_ops = {
 
 #include "hw/core/tcg-cpu-ops.h"
 
-static const struct TCGCPUOps mb_tcg_ops = {
+static const TCGCPUOps mb_tcg_ops = {
     .initialize = mb_tcg_init,
     .synchronize_from_tb = mb_cpu_synchronize_from_tb,
     .restore_state_to_opc = mb_restore_state_to_opc,
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 4c3e1ec2d9..dfe82f93ef 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -563,7 +563,7 @@ static const struct SysemuCPUOps mips_sysemu_ops = {
  * NB: cannot be const, as some elements are changed for specific
  * mips hardware (see hw/mips/jazz.c).
  */
-static const struct TCGCPUOps mips_tcg_ops = {
+static const TCGCPUOps mips_tcg_ops = {
     .initialize = mips_tcg_init,
     .synchronize_from_tb = mips_cpu_synchronize_from_tb,
     .restore_state_to_opc = mips_restore_state_to_opc,
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index 3e42889ce6..bff35f835a 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -372,7 +372,7 @@ static const struct SysemuCPUOps nios2_sysemu_ops = {
 
 #include "hw/core/tcg-cpu-ops.h"
 
-static const struct TCGCPUOps nios2_tcg_ops = {
+static const TCGCPUOps nios2_tcg_ops = {
     .initialize = nios2_tcg_init,
     .restore_state_to_opc = nios2_restore_state_to_opc,
 
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index fda0dc9470..bc54e7ccd0 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -235,7 +235,7 @@ static const struct SysemuCPUOps openrisc_sysemu_ops = {
 
 #include "hw/core/tcg-cpu-ops.h"
 
-static const struct TCGCPUOps openrisc_tcg_ops = {
+static const TCGCPUOps openrisc_tcg_ops = {
     .initialize = openrisc_translate_init,
     .synchronize_from_tb = openrisc_cpu_synchronize_from_tb,
     .restore_state_to_opc = openrisc_restore_state_to_opc,
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 344196a8ce..23eb5522b6 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7332,7 +7332,7 @@ static const struct SysemuCPUOps ppc_sysemu_ops = {
 #ifdef CONFIG_TCG
 #include "hw/core/tcg-cpu-ops.h"
 
-static const struct TCGCPUOps ppc_tcg_ops = {
+static const TCGCPUOps ppc_tcg_ops = {
   .initialize = ppc_translate_init,
   .restore_state_to_opc = ppc_restore_state_to_opc,
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 994ca1cdf9..b7da92783b 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -129,7 +129,7 @@ static void riscv_restore_state_to_opc(CPUState *cs,
     env->bins = data[1];
 }
 
-static const struct TCGCPUOps riscv_tcg_ops = {
+static const TCGCPUOps riscv_tcg_ops = {
     .initialize = riscv_translate_init,
     .synchronize_from_tb = riscv_cpu_synchronize_from_tb,
     .restore_state_to_opc = riscv_restore_state_to_opc,
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index de1cc7a5e6..cfc97d06e7 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -192,7 +192,7 @@ static const struct SysemuCPUOps rx_sysemu_ops = {
 
 #include "hw/core/tcg-cpu-ops.h"
 
-static const struct TCGCPUOps rx_tcg_ops = {
+static const TCGCPUOps rx_tcg_ops = {
     .initialize = rx_translate_init,
     .synchronize_from_tb = rx_cpu_synchronize_from_tb,
     .restore_state_to_opc = rx_restore_state_to_opc,
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index db1590472e..b783e1e2e6 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -372,7 +372,7 @@ static void s390_cpu_reset_full(DeviceState *dev)
 #ifdef CONFIG_TCG
 #include "hw/core/tcg-cpu-ops.h"
 
-static const struct TCGCPUOps s390_tcg_ops = {
+static const TCGCPUOps s390_tcg_ops = {
     .initialize = s390x_translate_init,
     .restore_state_to_opc = s390x_restore_state_to_opc,
 
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index eb7eb6f30a..89a42e0e22 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -265,7 +265,7 @@ static const struct SysemuCPUOps sh4_sysemu_ops = {
 
 #include "hw/core/tcg-cpu-ops.h"
 
-static const struct TCGCPUOps superh_tcg_ops = {
+static const TCGCPUOps superh_tcg_ops = {
     .initialize = sh4_translate_init,
     .synchronize_from_tb = superh_cpu_synchronize_from_tb,
     .restore_state_to_opc = superh_restore_state_to_opc,
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 99d57cc209..8385c8a2b0 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -935,7 +935,7 @@ static const struct SysemuCPUOps sparc_sysemu_ops = {
 #ifdef CONFIG_TCG
 #include "hw/core/tcg-cpu-ops.h"
 
-static const struct TCGCPUOps sparc_tcg_ops = {
+static const TCGCPUOps sparc_tcg_ops = {
     .initialize = sparc_tcg_init,
     .synchronize_from_tb = sparc_cpu_synchronize_from_tb,
     .restore_state_to_opc = sparc_restore_state_to_opc,
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index dff88184c9..2f07fdbfab 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -190,7 +190,7 @@ static const struct SysemuCPUOps tricore_sysemu_ops = {
 
 #include "hw/core/tcg-cpu-ops.h"
 
-static const struct TCGCPUOps tricore_tcg_ops = {
+static const TCGCPUOps tricore_tcg_ops = {
     .initialize = tricore_tcg_init,
     .synchronize_from_tb = tricore_cpu_synchronize_from_tb,
     .restore_state_to_opc = tricore_restore_state_to_opc,
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index dfe0ff5c98..0da5409742 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -294,7 +294,7 @@ static const struct SysemuCPUOps xtensa_sysemu_ops = {
 
 #include "hw/core/tcg-cpu-ops.h"
 
-static const struct TCGCPUOps xtensa_tcg_ops = {
+static const TCGCPUOps xtensa_tcg_ops = {
     .initialize = xtensa_translate_init,
     .debug_excp_handler = xtensa_breakpoint_handler,
     .restore_state_to_opc = xtensa_restore_state_to_opc,
-- 
2.34.1


