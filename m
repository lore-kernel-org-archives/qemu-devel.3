Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B98CF042B
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 00:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syKCd-0004VH-RU; Tue, 08 Oct 2024 20:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syKCa-0004TA-VE
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 20:05:17 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syKCY-0002wY-R6
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 20:05:16 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20b0b2528d8so70929345ad.2
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 17:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728432313; x=1729037113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AsNmQx87g0SWMKNuiqJxyPNh2jiF8Ss0MC8Fky2xo4U=;
 b=XEHwPY2IXI97sKGlSMw7Jt466C4Gy7yQYmitt5P5zPhSDAyV/lsLKMyQAaqkGFtq8l
 Htna6jR0qs1sMkVBL9KvwQxdZh69ubTxNoD1Cjnd6O2bofFk1wm8gDtCX4Dlyjvhw14u
 xVo5uPM2HEkxQncLmu6S0VudkA5HXvQwIofPsATSA79tD0z5Uih5qiwumaICTSzP3WKn
 Zpa3DsRMQLk2g9dVYFmmXoIteOkWgTTCbmBXShDF/omqTkMYhycpSWxQMcmT1kPQ1y8q
 MdqOhAF7JFjZGV9NSvQs9tr3d4L4zEzB6uWGFqKXPZAMwyBeQQ4jRzNFkJMSTyVOxfhB
 t91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728432313; x=1729037113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AsNmQx87g0SWMKNuiqJxyPNh2jiF8Ss0MC8Fky2xo4U=;
 b=mD8e0kGIcH9s6t91qpLQDDlIKWV5JeJT5ewPbzTm73bM5qG0f1Ym82JzmoQXHmOMSF
 pDLyf531GaW7O5IALN4D2GVZtfnqSP5nQKWDSxfnK+3xpb4OPugdC2TSmgLQHd7RboFW
 gkm7B7R9/n4aU4aC18ZFPDYRN/6gEvNDhoC9/CKmpuU2DxACuJcFSwRtcAU48/v8kRFM
 Lpv3Gc9K0f4lLunwY96r8u2e5nlv8fxnAL/P4zQFDDQErixFJXzc91h+UIVOoWP1zdYG
 6CN52Epv+cC07U35FeXjuG1Uly7YEj7jyoZbKi0osRUCyWbBZzv+U0x0Lu6B87mfmU7X
 AROw==
X-Gm-Message-State: AOJu0YwswONt2LJjeNhh3hl6ET6Xk2TFIx3vTBOzC7thDwPndi5gGjDi
 lffv/w82pIL7bQ3ytCqh5KjU6oBwvW4VTy13lZHHdrum2NDUM4GjD4Bgwb9sb4pLFHILMAUEHFL
 1
X-Google-Smtp-Source: AGHT+IFwettQe3bNvU+s7lxTJSvr2zVnYgznFgHUWVsZdUYFjaAq3kofjLpeFOF7iswFe+1y64JOcA==
X-Received: by 2002:a17:903:228a:b0:20c:5a64:9bc6 with SMTP id
 d9443c01a7336-20c6378e9c4mr11368345ad.50.1728432313486; 
 Tue, 08 Oct 2024 17:05:13 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138cecf2sm60705105ad.104.2024.10.08.17.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 17:05:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Subject: [PATCH v3 19/20] target/arm: Implement TCGCPUOps.tlb_fill_align
Date: Tue,  8 Oct 2024 17:04:52 -0700
Message-ID: <20241009000453.315652-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009000453.315652-1-richard.henderson@linaro.org>
References: <20241009000453.315652-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Fill in the tlb_fill_align hook.  Handle alignment not due to
memory type, since that's no longer handled by generic code.
Pass memop to get_phys_addr.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h      |  6 ++---
 target/arm/cpu.c            |  2 +-
 target/arm/tcg/cpu-v7m.c    |  2 +-
 target/arm/tcg/tlb_helper.c | 49 ++++++++++++++-----------------------
 4 files changed, 24 insertions(+), 35 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index a6088d551c..299a96a81a 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -816,9 +816,9 @@ void arm_cpu_record_sigsegv(CPUState *cpu, vaddr addr,
 void arm_cpu_record_sigbus(CPUState *cpu, vaddr addr,
                            MMUAccessType access_type, uintptr_t ra);
 #else
-bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                      MMUAccessType access_type, int mmu_idx,
-                      bool probe, uintptr_t retaddr);
+bool arm_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr addr,
+                            MMUAccessType access_type, int mmu_idx,
+                            MemOp memop, int size, bool probe, uintptr_t ra);
 #endif
 
 static inline int arm_to_core_mmu_idx(ARMMMUIdx mmu_idx)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 19191c2391..1320fd8c8f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2663,7 +2663,7 @@ static const TCGCPUOps arm_tcg_ops = {
     .record_sigsegv = arm_cpu_record_sigsegv,
     .record_sigbus = arm_cpu_record_sigbus,
 #else
-    .tlb_fill = arm_cpu_tlb_fill,
+    .tlb_fill_align = arm_cpu_tlb_fill_align,
     .cpu_exec_interrupt = arm_cpu_exec_interrupt,
     .cpu_exec_halt = arm_cpu_exec_halt,
     .do_interrupt = arm_cpu_do_interrupt,
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 5496f14dc1..58e54578d6 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -242,7 +242,7 @@ static const TCGCPUOps arm_v7m_tcg_ops = {
     .record_sigsegv = arm_cpu_record_sigsegv,
     .record_sigbus = arm_cpu_record_sigbus,
 #else
-    .tlb_fill = arm_cpu_tlb_fill,
+    .tlb_fill_align = arm_cpu_tlb_fill_align,
     .cpu_exec_interrupt = arm_v7m_cpu_exec_interrupt,
     .cpu_exec_halt = arm_cpu_exec_halt,
     .do_interrupt = arm_v7m_cpu_do_interrupt,
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 1d8b7bcaa2..8841f039bc 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -318,14 +318,13 @@ void arm_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
     arm_deliver_fault(cpu, addr, access_type, mmu_idx, &fi);
 }
 
-bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                      MMUAccessType access_type, int mmu_idx,
-                      bool probe, uintptr_t retaddr)
+bool arm_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr address,
+                            MMUAccessType access_type, int mmu_idx,
+                            MemOp memop, int size, bool probe, uintptr_t ra)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     GetPhysAddrResult res = {};
     ARMMMUFaultInfo local_fi, *fi;
-    int ret;
 
     /*
      * Allow S1_ptw_translate to see any fault generated here.
@@ -339,37 +338,27 @@ bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     }
 
     /*
-     * Walk the page table and (if the mapping exists) add the page
-     * to the TLB.  On success, return true.  Otherwise, if probing,
-     * return false.  Otherwise populate fsr with ARM DFSR/IFSR fault
-     * register format, and signal the fault.
+     * Per R_XCHFJ, alignment fault not due to memory type has
+     * highest precedence.  Otherwise, walk the page table and
+     * and collect the page description.
      */
-    ret = get_phys_addr(&cpu->env, address, access_type, 0,
-                        core_to_arm_mmu_idx(&cpu->env, mmu_idx),
-                        &res, fi);
-    if (likely(!ret)) {
-        /*
-         * Map a single [sub]page. Regions smaller than our declared
-         * target page size are handled specially, so for those we
-         * pass in the exact addresses.
-         */
-        if (res.f.lg_page_size >= TARGET_PAGE_BITS) {
-            res.f.phys_addr &= TARGET_PAGE_MASK;
-            address &= TARGET_PAGE_MASK;
-        }
-
+    if (address & ((1 << memop_alignment_bits(memop)) - 1)) {
+        fi->type = ARMFault_Alignment;
+    } else if (!get_phys_addr(&cpu->env, address, access_type, memop,
+                              core_to_arm_mmu_idx(&cpu->env, mmu_idx),
+                              &res, fi)) {
         res.f.extra.arm.pte_attrs = res.cacheattrs.attrs;
         res.f.extra.arm.shareability = res.cacheattrs.shareability;
-
-        tlb_set_page_full(cs, mmu_idx, address, &res.f);
+        *out = res.f;
         return true;
-    } else if (probe) {
-        return false;
-    } else {
-        /* now we have a real cpu fault */
-        cpu_restore_state(cs, retaddr);
-        arm_deliver_fault(cpu, address, access_type, mmu_idx, fi);
     }
+    if (probe) {
+        return false;
+    }
+
+    /* Now we have a real cpu fault. */
+    cpu_restore_state(cs, ra);
+    arm_deliver_fault(cpu, address, access_type, mmu_idx, fi);
 }
 #else
 void arm_cpu_record_sigsegv(CPUState *cs, vaddr addr,
-- 
2.43.0


