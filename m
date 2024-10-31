Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B00E68952
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 03:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MGy-0001FM-RV; Wed, 30 Oct 2024 23:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MGw-0001Eh-Ts
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:54:58 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MGv-00040k-1t
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:54:58 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20caccadbeeso5505125ad.2
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 20:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730346895; x=1730951695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GpcV18LFhPpLrbVmzOnNKVSF1I8q0nbupwd2EWRyK1w=;
 b=jX5bPst+pOHQXMtOs+Di0etEMGYZY5zw1tDTQtGYg/3tAFQ143HJndix2Vj/xDIR2i
 sN4G+I3fgtXsntDcTlUiRkSSyrY/IJswl1W+HDYZ6x1dxAk6rVPUx8XPaqDS4PJzWVm/
 V2x9eeLIufm7eycHFZcIusmla8kbAXuw6diTpEVIGwWUfkunSSk2JOuPMe5ZI3Oa2Wc4
 bsMt20+tT0BUYdbGOMj+xPfxlj9vLDit0uDnEwNzlKLUoJnHT/1il5DKfBDmSvDWqZ+c
 OO/HoyIaXeO/CGMb8X9+6uGH9DuQ+g57MjTYQu/5oSGunL8veotRaZH1P6Q/inN9OKTy
 emAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730346895; x=1730951695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GpcV18LFhPpLrbVmzOnNKVSF1I8q0nbupwd2EWRyK1w=;
 b=a/SkAfehP6MFdICrDGUbSKtxPyAyXo7ZdOnAyilZB/NZZ7ywwOC5E5nc/zsQ5S2IOq
 /3Kg0FUXimENHu3ojaumHbfaR5LD8Ccf9VuVi2sqlBDnEw0NpPtfsWE+cCjAYxGfB+44
 GWmjha7a6Lw286AAk54nr9I3DdeH7AWGoB2ygbtLiVxEeP7S/SQXBJvD8KqyApKTxjQj
 0aFTifbs5Jq7YGRgNc1aAQLQRiXcsirWwgiA3OW7WdJY0QTX2vT3iisEjCue47Kk696y
 jrdWcFOtvafCE4QLkBndLNijmQJJxASQw6+z1wZOrAhkVVtTpCxgrawbGAGG8cGmNT75
 Yl1A==
X-Gm-Message-State: AOJu0YyUp9oPy7UmAgMHo+VgmRKXRn4zX7wB4PBZSkDH+WhhwkbhCT31
 iNY3NIM+8WyFGMrsY9mYPk/xmB19xXNLj2AMLH7/ETTfD/9aPwPNJ9101n6V
X-Google-Smtp-Source: AGHT+IFapOBTOAkg5rD9uXso5bOfpdsIWPNjX1TdaX4EAkW/lgmfJ3AwaJXe1IfIvwuC5Hu/8TQWpw==
X-Received: by 2002:a17:902:e801:b0:20b:9547:9b36 with SMTP id
 d9443c01a7336-21103c786f3mr17649935ad.46.1730346895465; 
 Wed, 30 Oct 2024 20:54:55 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21105707064sm3022795ad.70.2024.10.30.20.54.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 20:54:55 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 28/50] target/riscv: mmu changes for zicfiss shadow stack
 protection
Date: Thu, 31 Oct 2024 13:52:56 +1000
Message-ID: <20241031035319.731906-29-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031035319.731906-1-alistair.francis@wdc.com>
References: <20241031035319.731906-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Deepak Gupta <debug@rivosinc.com>

zicfiss protects shadow stack using new page table encodings PTE.W=1,
PTE.R=0 and PTE.X=0. This encoding is reserved if zicfiss is not
implemented or if shadow stack are not enabled.
Loads on shadow stack memory are allowed while stores to shadow stack
memory leads to access faults. Shadow stack accesses to RO memory
leads to store page fault.

To implement special nature of shadow stack memory where only selected
stores (shadow stack stores from sspush) have to be allowed while rest
of regular stores disallowed, new MMU TLB index is created for shadow
stack.

Furthermore, `check_zicbom_access` (`cbo.clean/flush/inval`) may probe
shadow stack memory and must always raise store/AMO access fault because
it has store semantics. For non-shadow stack memory even though
`cbo.clean/flush/inval` have store semantics, it will not fault if read
is allowed (probably to follow `clflush` on x86). Although if read is not
allowed, eventually `probe_write` will do store page (or access) fault (if
permissions don't allow it). cbo operations on shadow stack memory must
always raise store access fault. Thus extending `get_physical_address` to
recieve `probe` parameter as well.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241008225010.1861630-14-debug@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/internals.h  |  3 ++
 target/riscv/cpu_helper.c | 64 ++++++++++++++++++++++++++++++---------
 2 files changed, 53 insertions(+), 14 deletions(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 0ac17bc5ad..ddbdee885b 100644
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
+#define MMU_IDX_SS_WRITE    (1 << 3)
 
 static inline int mmuidx_priv(int mmu_idx)
 {
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 8a30031872..42177a5bd4 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -884,7 +884,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
                                 target_ulong *fault_pte_addr,
                                 int access_type, int mmu_idx,
                                 bool first_stage, bool two_stage,
-                                bool is_debug)
+                                bool is_debug, bool is_probe)
 {
     /*
      * NOTE: the env->pc value visible here will not be
@@ -898,6 +898,8 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     hwaddr ppn;
     int napot_bits = 0;
     target_ulong napot_mask;
+    bool is_sstack_idx = ((mmu_idx & MMU_IDX_SS_WRITE) == MMU_IDX_SS_WRITE);
+    bool sstack_page = false;
 
     /*
      * Check if we should use the background registers for the two
@@ -1030,7 +1032,7 @@ restart:
             int vbase_ret = get_physical_address(env, &vbase, &vbase_prot,
                                                  base, NULL, MMU_DATA_LOAD,
                                                  MMUIdx_U, false, true,
-                                                 is_debug);
+                                                 is_debug, false);
 
             if (vbase_ret != TRANSLATE_SUCCESS) {
                 if (fault_pte_addr) {
@@ -1108,21 +1110,43 @@ restart:
         return TRANSLATE_FAIL;
     }
 
+    target_ulong rwx = pte & (PTE_R | PTE_W | PTE_X);
     /* Check for reserved combinations of RWX flags. */
-    switch (pte & (PTE_R | PTE_W | PTE_X)) {
-    case PTE_W:
+    switch (rwx) {
     case PTE_W | PTE_X:
         return TRANSLATE_FAIL;
+    case PTE_W:
+        /* if bcfi enabled, PTE_W is not reserved and shadow stack page */
+        if (cpu_get_bcfien(env) && first_stage) {
+            sstack_page = true;
+            /*
+             * if ss index, read and write allowed. else if not a probe
+             * then only read allowed
+             */
+            rwx = is_sstack_idx ? (PTE_R | PTE_W) : (is_probe ? 0 :  PTE_R);
+            break;
+        }
+        return TRANSLATE_FAIL;
+    case PTE_R:
+        /*
+         * no matter what's the `access_type`, shadow stack access to readonly
+         * memory are always store page faults. During unwind, loads will be
+         * promoted as store fault.
+         */
+        if (is_sstack_idx) {
+            return TRANSLATE_FAIL;
+        }
+        break;
     }
 
     int prot = 0;
-    if (pte & PTE_R) {
+    if (rwx & PTE_R) {
         prot |= PAGE_READ;
     }
-    if (pte & PTE_W) {
+    if (rwx & PTE_W) {
         prot |= PAGE_WRITE;
     }
-    if (pte & PTE_X) {
+    if (rwx & PTE_X) {
         bool mxr = false;
 
         /*
@@ -1166,8 +1190,11 @@ restart:
     }
 
     if (!((prot >> access_type) & 1)) {
-        /* Access check failed */
-        return TRANSLATE_FAIL;
+        /*
+         * Access check failed, access check failures for shadow stack are
+         * access faults.
+         */
+        return sstack_page ? TRANSLATE_PMP_FAIL : TRANSLATE_FAIL;
     }
 
     target_ulong updated_pte = pte;
@@ -1310,13 +1337,13 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     int mmu_idx = riscv_env_mmu_index(&cpu->env, false);
 
     if (get_physical_address(env, &phys_addr, &prot, addr, NULL, 0, mmu_idx,
-                             true, env->virt_enabled, true)) {
+                             true, env->virt_enabled, true, false)) {
         return -1;
     }
 
     if (env->virt_enabled) {
         if (get_physical_address(env, &phys_addr, &prot, phys_addr, NULL,
-                                 0, MMUIdx_U, false, true, true)) {
+                                 0, MMUIdx_U, false, true, true, false)) {
             return -1;
         }
     }
@@ -1359,9 +1386,17 @@ void riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
         break;
     case MMU_DATA_LOAD:
         cs->exception_index = RISCV_EXCP_LOAD_ADDR_MIS;
+        /* shadow stack mis aligned accesses are access faults */
+        if (mmu_idx & MMU_IDX_SS_WRITE) {
+            cs->exception_index = RISCV_EXCP_LOAD_ACCESS_FAULT;
+        }
         break;
     case MMU_DATA_STORE:
         cs->exception_index = RISCV_EXCP_STORE_AMO_ADDR_MIS;
+        /* shadow stack mis aligned accesses are access faults */
+        if (mmu_idx & MMU_IDX_SS_WRITE) {
+            cs->exception_index = RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
+        }
         break;
     default:
         g_assert_not_reached();
@@ -1422,7 +1457,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         /* Two stage lookup */
         ret = get_physical_address(env, &pa, &prot, address,
                                    &env->guest_phys_fault_addr, access_type,
-                                   mmu_idx, true, true, false);
+                                   mmu_idx, true, true, false, probe);
 
         /*
          * A G-stage exception may be triggered during two state lookup.
@@ -1445,7 +1480,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
             ret = get_physical_address(env, &pa, &prot2, im_address, NULL,
                                        access_type, MMUIdx_U, false, true,
-                                       false);
+                                       false, probe);
 
             qemu_log_mask(CPU_LOG_MMU,
                           "%s 2nd-stage address=%" VADDR_PRIx
@@ -1482,7 +1517,8 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     } else {
         /* Single stage lookup */
         ret = get_physical_address(env, &pa, &prot, address, NULL,
-                                   access_type, mmu_idx, true, false, false);
+                                   access_type, mmu_idx, true, false, false,
+                                   probe);
 
         qemu_log_mask(CPU_LOG_MMU,
                       "%s address=%" VADDR_PRIx " ret %d physical "
-- 
2.47.0


