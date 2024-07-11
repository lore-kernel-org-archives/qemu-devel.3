Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A32EC3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 13:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRthe-0003Rn-F7; Thu, 11 Jul 2024 09:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRthD-0001Sb-5C
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:51 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRth7-00063q-8O
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:49 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4267345e746so5918595e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 06:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720703912; x=1721308712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mJJtvp5Y6I/6U2k54uJrUAVLkxGe0GJIV6EjU6SGiVU=;
 b=Vcp4z2QXHTeE1pbcL7O1vCaR1jb970dbo6vN0M1EjSNgC2eiggW6NkkKrArSk0kSv/
 LrglQhKNhwzrSW7jKrFmIjGZ6FKoG/7dhYbIFx+L129+1Wf9p/gJx4m1pCt/wMbudNzj
 Y/lrgRC/brpAF3pF00GQxnGYxOWZgsixmF0e8OnYFQHO8OFj83pJ4J15pPIzxSATIuGI
 k1Ya+ps5zCgjkgQQIgOlG81Kf0q7MGtnplKsFuG3GAFe/bkt1wesbw3rzkMHYuYHGfJm
 l5yWIOwJdPqKh9UPS8JhYwehpxrnH8s9Y5SroPdpa43DN4TDmAJG7riUueJ7mhaLBXwM
 FYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720703912; x=1721308712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mJJtvp5Y6I/6U2k54uJrUAVLkxGe0GJIV6EjU6SGiVU=;
 b=KMqgYKFxkDoG4TGxFZLoFwNGDbL/x968mefqMg/ZVxVk9xrHKGK3/QjxCOWcGFZtJ/
 sY0leF2szMdDsgPdG5tWmI1y0jxWOYN8vFWVPcGR/wBvfsivvYulN+6QA9JhDXRSS521
 QR1B5QJ9Lf2dQgIujtEMC48kxeMOHQlHfuuXeKOHdfgUfHZm8Z65+OiLpknJInIYvLXi
 vtogSV3JfzxvnxdnhvTf3W1c3Y9VtChxFyEXua2mUgoFR8KxMLZoCWCm9RSAJXUi8gnF
 WPlYkHh//NQUO+EKAk6GSJ/IPlRMM1OR9kSm8PnM/0oBcsLFF0uvs8/MHjfsKNLrBgcB
 xMQg==
X-Gm-Message-State: AOJu0Ywj2ISM5Rt/1LRvtBsLQoxznh/M/dQ44MwuXHywPgLgHEzIT6oA
 ibUD/0agZQF758a6yU+ZM4NUqT7GJiJ4kDVeHg1w8KBgeLoPHlfHRS8ES9P7yrB8Oh9q+qgdA0J
 yhTc=
X-Google-Smtp-Source: AGHT+IGjVhcip1e0wCDm8R6tkniYlPkYUTWLPy7JFzV8IKgEq0p0nzdxQrGckvmatNuwRGXF3aBOIA==
X-Received: by 2002:a05:600c:4927:b0:426:97e2:345d with SMTP id
 5b1f17b1804b1-42697e238c0mr45254005e9.40.1720703911786; 
 Thu, 11 Jul 2024 06:18:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f736939sm119412025e9.37.2024.07.11.06.18.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 06:18:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/24] target: Set TCGCPUOps::cpu_exec_halt to target's
 has_work implementation
Date: Thu, 11 Jul 2024 14:18:12 +0100
Message-Id: <20240711131822.3909903-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711131822.3909903-1-peter.maydell@linaro.org>
References: <20240711131822.3909903-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Currently the TCGCPUOps::cpu_exec_halt method is optional, and if it
is not set then the default is to call the CPUClass::has_work
method (which has an identical function signature).

We would like to make the cpu_exec_halt method mandatory so we can
remove the runtime check and fallback handling.  In preparation for
that, make all the targets which don't need special handling in their
cpu_exec_halt set it to their cpu_has_work implementation instead of
leaving it unset.  (This is every target except for arm and i386.)

In the riscv case this requires us to make the function not
be local to the source file it's defined in.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/internals.h   | 3 +++
 target/alpha/cpu.c         | 1 +
 target/avr/cpu.c           | 1 +
 target/cris/cpu.c          | 2 ++
 target/hppa/cpu.c          | 1 +
 target/loongarch/cpu.c     | 1 +
 target/m68k/cpu.c          | 1 +
 target/microblaze/cpu.c    | 1 +
 target/mips/cpu.c          | 1 +
 target/openrisc/cpu.c      | 1 +
 target/ppc/cpu_init.c      | 2 ++
 target/riscv/cpu.c         | 2 +-
 target/riscv/tcg/tcg-cpu.c | 2 ++
 target/rx/cpu.c            | 1 +
 target/s390x/cpu.c         | 1 +
 target/sh4/cpu.c           | 1 +
 target/sparc/cpu.c         | 1 +
 target/tricore/cpu.c       | 1 +
 target/xtensa/cpu.c        | 1 +
 19 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 8239ae83ccc..0ac17bc5adb 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -136,4 +136,7 @@ static inline float16 check_nanbox_h(CPURISCVState *env, uint64_t f)
     }
 }
 
+/* Our implementation of CPUClass::has_work */
+bool riscv_cpu_has_work(CPUState *cs);
+
 #endif
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 0e2fbcb397f..9db1dffc03e 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -219,6 +219,7 @@ static const TCGCPUOps alpha_tcg_ops = {
 #else
     .tlb_fill = alpha_cpu_tlb_fill,
     .cpu_exec_interrupt = alpha_cpu_exec_interrupt,
+    .cpu_exec_halt = alpha_cpu_has_work,
     .do_interrupt = alpha_cpu_do_interrupt,
     .do_transaction_failed = alpha_cpu_do_transaction_failed,
     .do_unaligned_access = alpha_cpu_do_unaligned_access,
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index f53e1192b15..3132842d565 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -210,6 +210,7 @@ static const TCGCPUOps avr_tcg_ops = {
     .synchronize_from_tb = avr_cpu_synchronize_from_tb,
     .restore_state_to_opc = avr_restore_state_to_opc,
     .cpu_exec_interrupt = avr_cpu_exec_interrupt,
+    .cpu_exec_halt = avr_cpu_has_work,
     .tlb_fill = avr_cpu_tlb_fill,
     .do_interrupt = avr_cpu_do_interrupt,
 };
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index 535ec39c730..ff31ca7fbc1 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -186,6 +186,7 @@ static const TCGCPUOps crisv10_tcg_ops = {
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = cris_cpu_tlb_fill,
     .cpu_exec_interrupt = cris_cpu_exec_interrupt,
+    .cpu_exec_halt = cris_cpu_has_work,
     .do_interrupt = crisv10_cpu_do_interrupt,
 #endif /* !CONFIG_USER_ONLY */
 };
@@ -197,6 +198,7 @@ static const TCGCPUOps crisv32_tcg_ops = {
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = cris_cpu_tlb_fill,
     .cpu_exec_interrupt = cris_cpu_exec_interrupt,
+    .cpu_exec_halt = cris_cpu_has_work,
     .do_interrupt = cris_cpu_do_interrupt,
 #endif /* !CONFIG_USER_ONLY */
 };
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index f0507874ce6..7cf2e2f266d 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -228,6 +228,7 @@ static const TCGCPUOps hppa_tcg_ops = {
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = hppa_cpu_tlb_fill,
     .cpu_exec_interrupt = hppa_cpu_exec_interrupt,
+    .cpu_exec_halt = hppa_cpu_has_work,
     .do_interrupt = hppa_cpu_do_interrupt,
     .do_unaligned_access = hppa_cpu_do_unaligned_access,
     .do_transaction_failed = hppa_cpu_do_transaction_failed,
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 270f711f11a..69f9ad7711e 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -736,6 +736,7 @@ static const TCGCPUOps loongarch_tcg_ops = {
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = loongarch_cpu_tlb_fill,
     .cpu_exec_interrupt = loongarch_cpu_exec_interrupt,
+    .cpu_exec_halt = loongarch_cpu_has_work,
     .do_interrupt = loongarch_cpu_do_interrupt,
     .do_transaction_failed = loongarch_cpu_do_transaction_failed,
 #endif
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index efd6bbded86..1d49f4cb238 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -536,6 +536,7 @@ static const TCGCPUOps m68k_tcg_ops = {
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = m68k_cpu_tlb_fill,
     .cpu_exec_interrupt = m68k_cpu_exec_interrupt,
+    .cpu_exec_halt = m68k_cpu_has_work,
     .do_interrupt = m68k_cpu_do_interrupt,
     .do_transaction_failed = m68k_cpu_transaction_failed,
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 41ad47d04cb..135947ee800 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -413,6 +413,7 @@ static const TCGCPUOps mb_tcg_ops = {
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = mb_cpu_tlb_fill,
     .cpu_exec_interrupt = mb_cpu_exec_interrupt,
+    .cpu_exec_halt = mb_cpu_has_work,
     .do_interrupt = mb_cpu_do_interrupt,
     .do_transaction_failed = mb_cpu_transaction_failed,
     .do_unaligned_access = mb_cpu_do_unaligned_access,
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index bbe01d07dd8..89655b1900f 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -555,6 +555,7 @@ static const TCGCPUOps mips_tcg_ops = {
 #if !defined(CONFIG_USER_ONLY)
     .tlb_fill = mips_cpu_tlb_fill,
     .cpu_exec_interrupt = mips_cpu_exec_interrupt,
+    .cpu_exec_halt = mips_cpu_has_work,
     .do_interrupt = mips_cpu_do_interrupt,
     .do_transaction_failed = mips_cpu_do_transaction_failed,
     .do_unaligned_access = mips_cpu_do_unaligned_access,
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index fdaaa09fc87..6ec54ad7a6c 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -233,6 +233,7 @@ static const TCGCPUOps openrisc_tcg_ops = {
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = openrisc_cpu_tlb_fill,
     .cpu_exec_interrupt = openrisc_cpu_exec_interrupt,
+    .cpu_exec_halt = openrisc_cpu_has_work,
     .do_interrupt = openrisc_cpu_do_interrupt,
 #endif /* !CONFIG_USER_ONLY */
 };
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 01e358a4a5a..cdada7987d8 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -1,3 +1,4 @@
+
 /*
  *  PowerPC CPU initialization for qemu.
  *
@@ -7481,6 +7482,7 @@ static const TCGCPUOps ppc_tcg_ops = {
 #else
   .tlb_fill = ppc_cpu_tlb_fill,
   .cpu_exec_interrupt = ppc_cpu_exec_interrupt,
+  .cpu_exec_halt = ppc_cpu_has_work,
   .do_interrupt = ppc_cpu_do_interrupt,
   .cpu_exec_enter = ppc_cpu_exec_enter,
   .cpu_exec_exit = ppc_cpu_exec_exit,
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a2640cf2594..c53b0d5b406 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -903,7 +903,7 @@ static vaddr riscv_cpu_get_pc(CPUState *cs)
     return env->pc;
 }
 
-static bool riscv_cpu_has_work(CPUState *cs)
+bool riscv_cpu_has_work(CPUState *cs)
 {
 #ifndef CONFIG_USER_ONLY
     RISCVCPU *cpu = RISCV_CPU(cs);
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index ae256868243..ecf366d6c75 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -21,6 +21,7 @@
 #include "exec/exec-all.h"
 #include "tcg-cpu.h"
 #include "cpu.h"
+#include "internals.h"
 #include "pmu.h"
 #include "time_helper.h"
 #include "qapi/error.h"
@@ -138,6 +139,7 @@ static const TCGCPUOps riscv_tcg_ops = {
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = riscv_cpu_tlb_fill,
     .cpu_exec_interrupt = riscv_cpu_exec_interrupt,
+    .cpu_exec_halt = riscv_cpu_has_work,
     .do_interrupt = riscv_cpu_do_interrupt,
     .do_transaction_failed = riscv_cpu_do_transaction_failed,
     .do_unaligned_access = riscv_cpu_do_unaligned_access,
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 8a584f0a111..36d2a6f1890 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -192,6 +192,7 @@ static const TCGCPUOps rx_tcg_ops = {
 
 #ifndef CONFIG_USER_ONLY
     .cpu_exec_interrupt = rx_cpu_exec_interrupt,
+    .cpu_exec_halt = rx_cpu_has_work,
     .do_interrupt = rx_cpu_do_interrupt,
 #endif /* !CONFIG_USER_ONLY */
 };
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 2bbeaca36e4..0fbfcd35d83 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -370,6 +370,7 @@ static const TCGCPUOps s390_tcg_ops = {
 #else
     .tlb_fill = s390_cpu_tlb_fill,
     .cpu_exec_interrupt = s390_cpu_exec_interrupt,
+    .cpu_exec_halt = s390_cpu_has_work,
     .do_interrupt = s390_cpu_do_interrupt,
     .debug_excp_handler = s390x_cpu_debug_excp_handler,
     .do_unaligned_access = s390x_cpu_do_unaligned_access,
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 618aa7154ed..8f07261dcfd 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -254,6 +254,7 @@ static const TCGCPUOps superh_tcg_ops = {
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = superh_cpu_tlb_fill,
     .cpu_exec_interrupt = superh_cpu_exec_interrupt,
+    .cpu_exec_halt = superh_cpu_has_work,
     .do_interrupt = superh_cpu_do_interrupt,
     .do_unaligned_access = superh_cpu_do_unaligned_access,
     .io_recompile_replay_branch = superh_io_recompile_replay_branch,
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 9bacfb68cb2..54cb269e0af 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -926,6 +926,7 @@ static const TCGCPUOps sparc_tcg_ops = {
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = sparc_cpu_tlb_fill,
     .cpu_exec_interrupt = sparc_cpu_exec_interrupt,
+    .cpu_exec_halt = sparc_cpu_has_work,
     .do_interrupt = sparc_cpu_do_interrupt,
     .do_transaction_failed = sparc_cpu_do_transaction_failed,
     .do_unaligned_access = sparc_cpu_do_unaligned_access,
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index bdefb845116..4d9c0368f2b 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -169,6 +169,7 @@ static const TCGCPUOps tricore_tcg_ops = {
     .synchronize_from_tb = tricore_cpu_synchronize_from_tb,
     .restore_state_to_opc = tricore_restore_state_to_opc,
     .tlb_fill = tricore_cpu_tlb_fill,
+    .cpu_exec_halt = tricore_cpu_has_work,
 };
 
 static void tricore_cpu_class_init(ObjectClass *c, void *data)
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index de907cfeb1b..a08c7a0b1f2 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -234,6 +234,7 @@ static const TCGCPUOps xtensa_tcg_ops = {
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = xtensa_cpu_tlb_fill,
     .cpu_exec_interrupt = xtensa_cpu_exec_interrupt,
+    .cpu_exec_halt = xtensa_cpu_has_work,
     .do_interrupt = xtensa_cpu_do_interrupt,
     .do_transaction_failed = xtensa_cpu_do_transaction_failed,
     .do_unaligned_access = xtensa_cpu_do_unaligned_access,
-- 
2.34.1


