Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D3DCFB42C
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 20:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxB2a-0006JR-KO; Sat, 05 Oct 2024 16:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxB2Z-0006IH-00
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 16:06:11 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxB2W-0001jb-PU
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 16:06:10 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-207115e3056so29304835ad.2
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 13:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728158767; x=1728763567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1f/qgYd1hp1mLwoixEUX+NfB0hBePURRnKwRiQEkN3A=;
 b=fN18sDZkGTmoEXDgTTlMx1LNjCkUt3820nP0sM/GKb3n0GXv871ph63t/I0Y4Sin+M
 GwpwhRtyYeUPuw5/JdzKJ6iU+nTLZjP1IMHRGZTfhpOXjuwQFEM2UgB63BQAU/JBXXKV
 qyWqlCq2sNXSjsgT2qVlsBJjWOGL8K4rnZ/ArnbbPUHoD6oLaBfhhDtkwJQr9M7MTrKa
 8ZKPxuAIYhcrp46Q0oA/Ov3RdqRQY5Z6lX6Ku1PiYv52JxR4MndmRto9dUc8RYlV6ona
 EJ5YMOpgEFw/64c6cH7IgPYsSbqPIYeT4kqYFH1aavq1fdIjjX8mLLWcp5xe/3QDiXcH
 HItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728158767; x=1728763567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1f/qgYd1hp1mLwoixEUX+NfB0hBePURRnKwRiQEkN3A=;
 b=tWNzAUJQFFvCO0CdG1AO1buUv3hU1QSiAdrL9JgklhxnfAVtAdTaMg/xhZZY3CSk6H
 F5yhylQp/ZF5e+V3m4UkybXzSMvpAFAxKrQ1/7LEpuaGPz0+TDV7I/4k7Sdf9+UnqErU
 almqGV9J9vBMiGf9Rm+w19y/O2ZJOGdXwnPZPthT/0jHY08QwzIbkchcxyRGle4Gr2hw
 c98hyAGf2Z+w//Yfw3p/KP64MRC0GN9Y4+w5APcRPEm+eZ5GW06uqHlYYmZ9cbTIwuP5
 ZKzsyEGZAWMazHtTfT2t5QILlTj/m8qebSEM48mdUux+75D2NZ2bLNssgoGAkQ1EUPQz
 4MkQ==
X-Gm-Message-State: AOJu0Yz+f73MU9hyHZk9UDawpZ6hFQdTxK4v5lLyM09VAhLqADUFKj8p
 FVX8+S9XL98y5yxYI5Y5MzRePMhwq+yzLUPrXPH409Zw6ZxI2UhvIVPcOrEg/a26xseCUMU68mY
 P
X-Google-Smtp-Source: AGHT+IFzmszmyv7EFaMoyI1QCdaJl5nSZJZ1pqGh26krRNpf2aOXvO2XCeE4nHbEYZOTpe8UJGf/ng==
X-Received: by 2002:a17:902:ecc8:b0:20b:7784:27a2 with SMTP id
 d9443c01a7336-20bfe07c8aemr114472495ad.27.1728158767224; 
 Sat, 05 Oct 2024 13:06:07 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c13931055sm16493405ad.139.2024.10.05.13.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 13:06:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Subject: [PATCH v2 06/21] hw/core/tcg-cpu-ops: Introduce tlb_fill_align hook
Date: Sat,  5 Oct 2024 13:05:45 -0700
Message-ID: <20241005200600.493604-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005200600.493604-1-richard.henderson@linaro.org>
References: <20241005200600.493604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Add the hook to struct TCGCPUOps.  Add a default implementation
that recognizes alignment faults before page faults.  Populate
all TCGCPUOps structures with the default implementation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/tcg-cpu-ops.h | 25 +++++++++++++++++++++++++
 accel/tcg/cputlb.c            | 19 +++++++++++++++++++
 target/alpha/cpu.c            |  1 +
 target/arm/cpu.c              |  1 +
 target/arm/tcg/cpu-v7m.c      |  1 +
 target/avr/cpu.c              |  1 +
 target/hppa/cpu.c             |  1 +
 target/i386/tcg/tcg-cpu.c     |  1 +
 target/loongarch/cpu.c        |  1 +
 target/m68k/cpu.c             |  1 +
 target/microblaze/cpu.c       |  1 +
 target/mips/cpu.c             |  1 +
 target/openrisc/cpu.c         |  1 +
 target/ppc/cpu_init.c         |  1 +
 target/riscv/tcg/tcg-cpu.c    |  1 +
 target/rx/cpu.c               |  1 +
 target/s390x/cpu.c            |  1 +
 target/sh4/cpu.c              |  1 +
 target/sparc/cpu.c            |  1 +
 target/tricore/cpu.c          |  1 +
 target/xtensa/cpu.c           |  1 +
 21 files changed, 63 insertions(+)

diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index 34318cf0e6..49420bc93d 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -13,6 +13,7 @@
 #include "exec/breakpoint.h"
 #include "exec/hwaddr.h"
 #include "exec/memattrs.h"
+#include "exec/memop.h"
 #include "exec/mmu-access-type.h"
 #include "exec/vaddr.h"
 
@@ -131,6 +132,21 @@ struct TCGCPUOps {
      * same function signature.
      */
     bool (*cpu_exec_halt)(CPUState *cpu);
+
+    /**
+     * @tlb_fill_align: Handle a softmmu tlb miss, and alignment fault
+     *
+     * If the access is valid, call tlb_set_page and return true;
+     * if the access is invalid and probe is true, return false;
+     * otherwise raise an exception and do not return.
+     *
+     * The alignment check is deferred to this hook, so that the
+     * target can choose to recognize either before or after the
+     * permission check.
+     */
+    bool (*tlb_fill_align)(CPUState *cpu, vaddr address, MemOp mop, int size,
+                           MMUAccessType access_type, int mmu_idx,
+                           bool probe, uintptr_t retaddr);
     /**
      * @tlb_fill: Handle a softmmu tlb miss
      *
@@ -234,6 +250,15 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
  */
 int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len);
 
+/*
+ * tlb_fill_align_first:
+ *
+ * Prioritize alignment faults over page faults.
+ */
+bool tlb_fill_align_first(CPUState *cpu, vaddr address, MemOp mop, int size,
+                          MMUAccessType access_type, int mmu_idx,
+                          bool probe, uintptr_t retaddr);
+
 #endif
 
 #endif /* TCG_CPU_OPS_H */
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index f5fca5a118..4bc34c8a37 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1565,6 +1565,25 @@ bool tlb_plugin_lookup(CPUState *cpu, vaddr addr, int mmu_idx,
 }
 #endif
 
+
+/*
+ * Generic implementation of tlb_fill_align which recognizes
+ * alignment faults before page faults.
+ */
+bool tlb_fill_align_first(CPUState *cpu, vaddr addr, MemOp mop, int size,
+                          MMUAccessType access_type, int mmu_idx,
+                          bool probe, uintptr_t retaddr)
+{
+    unsigned a_bits = memop_alignment_bits(mop);
+
+    if (unlikely(addr & ((1 << a_bits) - 1))) {
+        cpu_unaligned_access(cpu, addr, access_type, mmu_idx, retaddr);
+    }
+
+    return cpu->cc->tcg_ops->tlb_fill(cpu, addr, size, access_type,
+                                      mmu_idx, probe, retaddr);
+}
+
 /*
  * Probe for a load/store operation.
  * Return the host address and into @flags.
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 9db1dffc03..2eb5afd34a 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -217,6 +217,7 @@ static const TCGCPUOps alpha_tcg_ops = {
     .record_sigsegv = alpha_cpu_record_sigsegv,
     .record_sigbus = alpha_cpu_record_sigbus,
 #else
+    .tlb_fill_align = tlb_fill_align_first,
     .tlb_fill = alpha_cpu_tlb_fill,
     .cpu_exec_interrupt = alpha_cpu_exec_interrupt,
     .cpu_exec_halt = alpha_cpu_has_work,
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 19191c2391..08731ed4e0 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2663,6 +2663,7 @@ static const TCGCPUOps arm_tcg_ops = {
     .record_sigsegv = arm_cpu_record_sigsegv,
     .record_sigbus = arm_cpu_record_sigbus,
 #else
+    .tlb_fill_align = tlb_fill_align_first,
     .tlb_fill = arm_cpu_tlb_fill,
     .cpu_exec_interrupt = arm_cpu_exec_interrupt,
     .cpu_exec_halt = arm_cpu_exec_halt,
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 5496f14dc1..8874fe0e11 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -242,6 +242,7 @@ static const TCGCPUOps arm_v7m_tcg_ops = {
     .record_sigsegv = arm_cpu_record_sigsegv,
     .record_sigbus = arm_cpu_record_sigbus,
 #else
+    .tlb_fill_align = tlb_fill_align_first,
     .tlb_fill = arm_cpu_tlb_fill,
     .cpu_exec_interrupt = arm_v7m_cpu_exec_interrupt,
     .cpu_exec_halt = arm_cpu_exec_halt,
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 3132842d56..6ac4434f1d 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -211,6 +211,7 @@ static const TCGCPUOps avr_tcg_ops = {
     .restore_state_to_opc = avr_restore_state_to_opc,
     .cpu_exec_interrupt = avr_cpu_exec_interrupt,
     .cpu_exec_halt = avr_cpu_has_work,
+    .tlb_fill_align = tlb_fill_align_first,
     .tlb_fill = avr_cpu_tlb_fill,
     .do_interrupt = avr_cpu_do_interrupt,
 };
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 7cf2e2f266..3b6c325e09 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -226,6 +226,7 @@ static const TCGCPUOps hppa_tcg_ops = {
     .restore_state_to_opc = hppa_restore_state_to_opc,
 
 #ifndef CONFIG_USER_ONLY
+    .tlb_fill_align = tlb_fill_align_first,
     .tlb_fill = hppa_cpu_tlb_fill,
     .cpu_exec_interrupt = hppa_cpu_exec_interrupt,
     .cpu_exec_halt = hppa_cpu_has_work,
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index cca19cd40e..83cfb86346 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -117,6 +117,7 @@ static const TCGCPUOps x86_tcg_ops = {
     .record_sigsegv = x86_cpu_record_sigsegv,
     .record_sigbus = x86_cpu_record_sigbus,
 #else
+    .tlb_fill_align = tlb_fill_align_first,
     .tlb_fill = x86_cpu_tlb_fill,
     .do_interrupt = x86_cpu_do_interrupt,
     .cpu_exec_halt = x86_cpu_exec_halt,
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 7212fb5f8f..ae8856d988 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -755,6 +755,7 @@ static const TCGCPUOps loongarch_tcg_ops = {
     .restore_state_to_opc = loongarch_restore_state_to_opc,
 
 #ifndef CONFIG_USER_ONLY
+    .tlb_fill_align = tlb_fill_align_first,
     .tlb_fill = loongarch_cpu_tlb_fill,
     .cpu_exec_interrupt = loongarch_cpu_exec_interrupt,
     .cpu_exec_halt = loongarch_cpu_has_work,
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 1d49f4cb23..295ebd941b 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -534,6 +534,7 @@ static const TCGCPUOps m68k_tcg_ops = {
     .restore_state_to_opc = m68k_restore_state_to_opc,
 
 #ifndef CONFIG_USER_ONLY
+    .tlb_fill_align = tlb_fill_align_first,
     .tlb_fill = m68k_cpu_tlb_fill,
     .cpu_exec_interrupt = m68k_cpu_exec_interrupt,
     .cpu_exec_halt = m68k_cpu_has_work,
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 135947ee80..6e63600631 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -411,6 +411,7 @@ static const TCGCPUOps mb_tcg_ops = {
     .restore_state_to_opc = mb_restore_state_to_opc,
 
 #ifndef CONFIG_USER_ONLY
+    .tlb_fill_align = tlb_fill_align_first,
     .tlb_fill = mb_cpu_tlb_fill,
     .cpu_exec_interrupt = mb_cpu_exec_interrupt,
     .cpu_exec_halt = mb_cpu_has_work,
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 89655b1900..5a36b22256 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -553,6 +553,7 @@ static const TCGCPUOps mips_tcg_ops = {
     .restore_state_to_opc = mips_restore_state_to_opc,
 
 #if !defined(CONFIG_USER_ONLY)
+    .tlb_fill_align = tlb_fill_align_first,
     .tlb_fill = mips_cpu_tlb_fill,
     .cpu_exec_interrupt = mips_cpu_exec_interrupt,
     .cpu_exec_halt = mips_cpu_has_work,
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 6ec54ad7a6..9223228758 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -231,6 +231,7 @@ static const TCGCPUOps openrisc_tcg_ops = {
     .restore_state_to_opc = openrisc_restore_state_to_opc,
 
 #ifndef CONFIG_USER_ONLY
+    .tlb_fill_align = tlb_fill_align_first,
     .tlb_fill = openrisc_cpu_tlb_fill,
     .cpu_exec_interrupt = openrisc_cpu_exec_interrupt,
     .cpu_exec_halt = openrisc_cpu_has_work,
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 23881d09e9..42a38ec155 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7482,6 +7482,7 @@ static const TCGCPUOps ppc_tcg_ops = {
 #ifdef CONFIG_USER_ONLY
   .record_sigsegv = ppc_cpu_record_sigsegv,
 #else
+  .tlb_fill_align = tlb_fill_align_first,
   .tlb_fill = ppc_cpu_tlb_fill,
   .cpu_exec_interrupt = ppc_cpu_exec_interrupt,
   .cpu_exec_halt = ppc_cpu_has_work,
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index dea8ab7a43..42c4ea13af 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -137,6 +137,7 @@ static const TCGCPUOps riscv_tcg_ops = {
     .restore_state_to_opc = riscv_restore_state_to_opc,
 
 #ifndef CONFIG_USER_ONLY
+    .tlb_fill_align = tlb_fill_align_first,
     .tlb_fill = riscv_cpu_tlb_fill,
     .cpu_exec_interrupt = riscv_cpu_exec_interrupt,
     .cpu_exec_halt = riscv_cpu_has_work,
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 36d2a6f189..27fc372ca4 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -188,6 +188,7 @@ static const TCGCPUOps rx_tcg_ops = {
     .initialize = rx_translate_init,
     .synchronize_from_tb = rx_cpu_synchronize_from_tb,
     .restore_state_to_opc = rx_restore_state_to_opc,
+    .tlb_fill_align = tlb_fill_align_first,
     .tlb_fill = rx_cpu_tlb_fill,
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 4e41a3dff5..8120ddeb5b 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -363,6 +363,7 @@ static const TCGCPUOps s390_tcg_ops = {
     .record_sigsegv = s390_cpu_record_sigsegv,
     .record_sigbus = s390_cpu_record_sigbus,
 #else
+    .tlb_fill_align = tlb_fill_align_first,
     .tlb_fill = s390_cpu_tlb_fill,
     .cpu_exec_interrupt = s390_cpu_exec_interrupt,
     .cpu_exec_halt = s390_cpu_has_work,
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 8f07261dcf..b03f6dfad8 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -252,6 +252,7 @@ static const TCGCPUOps superh_tcg_ops = {
     .restore_state_to_opc = superh_restore_state_to_opc,
 
 #ifndef CONFIG_USER_ONLY
+    .tlb_fill_align = tlb_fill_align_first,
     .tlb_fill = superh_cpu_tlb_fill,
     .cpu_exec_interrupt = superh_cpu_exec_interrupt,
     .cpu_exec_halt = superh_cpu_has_work,
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 54cb269e0a..da1bfad5f0 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -924,6 +924,7 @@ static const TCGCPUOps sparc_tcg_ops = {
     .restore_state_to_opc = sparc_restore_state_to_opc,
 
 #ifndef CONFIG_USER_ONLY
+    .tlb_fill_align = tlb_fill_align_first,
     .tlb_fill = sparc_cpu_tlb_fill,
     .cpu_exec_interrupt = sparc_cpu_exec_interrupt,
     .cpu_exec_halt = sparc_cpu_has_work,
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 1a26171590..9d8f8f13d2 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -173,6 +173,7 @@ static const TCGCPUOps tricore_tcg_ops = {
     .initialize = tricore_tcg_init,
     .synchronize_from_tb = tricore_cpu_synchronize_from_tb,
     .restore_state_to_opc = tricore_restore_state_to_opc,
+    .tlb_fill_align = tlb_fill_align_first,
     .tlb_fill = tricore_cpu_tlb_fill,
     .cpu_exec_interrupt = tricore_cpu_exec_interrupt,
     .cpu_exec_halt = tricore_cpu_has_work,
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index a08c7a0b1f..b0f84403f0 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -232,6 +232,7 @@ static const TCGCPUOps xtensa_tcg_ops = {
     .restore_state_to_opc = xtensa_restore_state_to_opc,
 
 #ifndef CONFIG_USER_ONLY
+    .tlb_fill_align = tlb_fill_align_first,
     .tlb_fill = xtensa_cpu_tlb_fill,
     .cpu_exec_interrupt = xtensa_cpu_exec_interrupt,
     .cpu_exec_halt = xtensa_cpu_has_work,
-- 
2.43.0


