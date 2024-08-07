Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2C8C49EA1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 00:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbUEF-00082R-Po; Tue, 06 Aug 2024 20:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbUD2-0002wL-FL
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 20:07:21 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbUCx-0001Cm-BO
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 20:07:19 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1fd640a6454so10374105ad.3
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 17:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722989233; x=1723594033;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fs75Z2Q/DQpJnICf6loT2R4eZwomAJ3I/UGPpjX3wUQ=;
 b=tPTYgWg2vQWdDuuU96z/+iwf64Yx5amrNZGgSLubYM3/vkDANZgLmv1LUXmcj6U5Q4
 +6gHHYiQWiRrYXkCDERUEOqnVrwgDIWjzsUl4Evyl5k4MfHaOi6GL3sfGCClUqKRDeNE
 Qyp4GaKwJ3rzu9Kxte0qoGLlGAkUEfZxcEtIzBCbimFKQBIpeyPLsJVR1iAJw2oz0Ej0
 ccspNAjcxxWxB1gnsZIw5tRdss7yT+0vYHIoK3McJP+1PQ+obgS/7W2cNqpgNvvHuLao
 UlS2LS9NCxwNQVIOTJPJN/Fe+kgJ09n+mk+MSvWV1JxVl8tkmJNsQ5XkP0VGOJYUVP14
 W8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722989233; x=1723594033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fs75Z2Q/DQpJnICf6loT2R4eZwomAJ3I/UGPpjX3wUQ=;
 b=hKSoxCz0gaPNQAaS9qlWK5gS5/OLzRkZDt5sMKR+y99+3NbikBQ/f3pSF9E8cVSpP7
 iVDC6WfQc3xCsecszIBlslvzp2jAoqjmptUoUmSqzzC8Kn7wkwws+0BfYkyI3G0pnxuW
 YJ1hMk8RFNtlETXvw9FesRkCBgTdr/1S47K8Z10MjPtrTI6Y2xtYYAhD1zWFprqXbInk
 jRkrwioc9geSD2pIWI4xjFqmqKg+IKyAg2nz7/ERujFHC3siYa550kXb0W4P2OXUtv7x
 5O2TqVp/MSR0IrbXwUOJOp6YeHa95lnCsrwc2S0fqgBS+bYamZgW5Nos6aKiG1sYZhgn
 PoRw==
X-Gm-Message-State: AOJu0YwL1m9lNfJVjNQNg8LJLnQN42kYT6FZjNSzD+EGHY2I9QZ11buX
 spOzx1hKPu4uZk8BB3j9uwsLDT5uX/caP/1YSQ2nLCuSI67wwNBb0n8ZFPYopIwwZWwMdsOI4vb
 c
X-Google-Smtp-Source: AGHT+IFYpZxBZF/jvC6ngqKFpKb331laK+RPGrSSb/4mzanekJAFlHmCqs50MybWyoOOqb6S4tSCfw==
X-Received: by 2002:a17:902:f687:b0:1fb:3474:9500 with SMTP id
 d9443c01a7336-1ff57327173mr192799605ad.27.1722989233321; 
 Tue, 06 Aug 2024 17:07:13 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f59cc2sm93381845ad.92.2024.08.06.17.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 17:07:13 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v3 14/20] target/riscv: mmu changes for zicfiss shadow stack
 protection
Date: Tue,  6 Aug 2024 17:06:45 -0700
Message-ID: <20240807000652.1417776-15-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240807000652.1417776-1-debug@rivosinc.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

zicfiss protects shadow stack using new page table encodings PTE.W=0,
PTE.R=0 and PTE.X=0. This encoding is reserved if zicfiss is not
implemented or if shadow stack are not enabled.
Loads on shadow stack memory are allowed while stores to shadow stack
memory leads to access faults. Shadow stack accesses to RO memory
leads to store page fault.

To implement special nature of shadow stack memory where only selected
stores (shadow stack stores from sspush) have to be allowed while rest
of regular stores disallowed, new MMU TLB index is created for shadow
stack.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 target/riscv/cpu_helper.c | 61 +++++++++++++++++++++++++++++++++++++--
 target/riscv/internals.h  |  3 ++
 2 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index fb6c0d4e1f..5d5da8dce1 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -820,6 +820,18 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
     env->load_res = -1;
 }
 
+static bool legal_sstack_access(int access_type, bool sstack_inst,
+                                bool sstack_attribute)
+{
+    /*
+     * Read/write/execution permissions are checked as usual. Shadow
+     * stack enforcement is just that (1) instruction type must match
+     * the attribute unless (2) a non-SS load to an SS region.
+     */
+    return (sstack_inst == sstack_attribute) ||
+        ((access_type == MMU_DATA_LOAD) && sstack_attribute);
+}
+
 /*
  * get_physical_address_pmp - check PMP permission for this physical address
  *
@@ -897,6 +909,8 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     hwaddr ppn;
     int napot_bits = 0;
     target_ulong napot_mask;
+    bool is_sstack_insn = ((mmu_idx & MMU_IDX_SS_ACCESS) == MMU_IDX_SS_ACCESS);
+    bool sstack_page = false;
 
     /*
      * Check if we should use the background registers for the two
@@ -1105,15 +1119,45 @@ restart:
         return TRANSLATE_FAIL;
     }
 
+    /*
+     * When backward CFI is enabled, the R=0, W=1, X=0 reserved encoding
+     * is used to mark Shadow Stack (SS) pages. If back CFI enabled, allow
+     * normal loads on SS pages, regular stores raise store access fault
+     * and avoid hitting the reserved-encoding case. Only shadow stack
+     * stores are allowed on SS pages. Shadow stack loads and stores on
+     * regular memory (non-SS) raise load and store/AMO access fault.
+     * Second stage translations don't participate in Shadow Stack.
+     */
+    sstack_page = (cpu_get_bcfien(env) && first_stage &&
+                  ((pte & (PTE_R | PTE_W | PTE_X)) == PTE_W));
+
     /* Check for reserved combinations of RWX flags. */
     switch (pte & (PTE_R | PTE_W | PTE_X)) {
-    case PTE_W:
     case PTE_W | PTE_X:
+    case PTE_W:
+        if (sstack_page) { /* if shadow stack page, PTE_W is not reserved */
+            break;
+        }
         return TRANSLATE_FAIL;
     }
 
+    /* Illegal combo of instruction type and page attribute */
+    if (!legal_sstack_access(access_type, is_sstack_insn,
+                            sstack_page)) {
+        /* shadow stack instruction and RO page then it's a page fault */
+        if (is_sstack_insn && ((pte & (PTE_R | PTE_W | PTE_X)) == PTE_R)) {
+                return TRANSLATE_FAIL;
+        }
+        /* In all other cases it's an access fault, so raise PMP_FAIL */
+        return TRANSLATE_PMP_FAIL;
+    }
+
     int prot = 0;
-    if (pte & PTE_R) {
+    /*
+     * If PTE has read bit in it or it's shadow stack page,
+     * then reads allowed
+     */
+    if ((pte & PTE_R) || sstack_page) {
         prot |= PAGE_READ;
     }
     if (pte & PTE_W) {
@@ -1351,9 +1395,17 @@ void riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
         break;
     case MMU_DATA_LOAD:
         cs->exception_index = RISCV_EXCP_LOAD_ADDR_MIS;
+        /* shadow stack mis aligned accesses are access faults */
+        if (mmu_idx & MMU_IDX_SS_ACCESS) {
+            cs->exception_index = RISCV_EXCP_LOAD_ACCESS_FAULT;
+        }
         break;
     case MMU_DATA_STORE:
         cs->exception_index = RISCV_EXCP_STORE_AMO_ADDR_MIS;
+        /* shadow stack mis aligned accesses are access faults */
+        if (mmu_idx & MMU_IDX_SS_ACCESS) {
+            cs->exception_index = RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
+        }
         break;
     default:
         g_assert_not_reached();
@@ -1409,6 +1461,11 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     qemu_log_mask(CPU_LOG_MMU, "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
                   __func__, address, access_type, mmu_idx);
 
+    /* If shadow stack instruction initiated this access, treat it as store */
+    if (mmu_idx & MMU_IDX_SS_ACCESS) {
+        access_type = MMU_DATA_STORE;
+    }
+
     pmu_tlb_fill_incr_ctr(cpu, access_type);
     if (two_stage_lookup) {
         /* Two stage lookup */
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 0ac17bc5ad..dad0657c80 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -30,12 +30,15 @@
  *  - U+2STAGE          0b100
  *  - S+2STAGE          0b101
  *  - S+SUM+2STAGE      0b110
+ *  - Shadow stack+U   0b1000
+ *  - Shadow stack+S   0b1001
  */
 #define MMUIdx_U            0
 #define MMUIdx_S            1
 #define MMUIdx_S_SUM        2
 #define MMUIdx_M            3
 #define MMU_2STAGE_BIT      (1 << 2)
+#define MMU_IDX_SS_ACCESS   (1 << 3)
 
 static inline int mmuidx_priv(int mmu_idx)
 {
-- 
2.44.0


