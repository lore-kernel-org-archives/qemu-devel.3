Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A18C606A323
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UoMMeTmy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWGkE-00085v-Pu; Wed, 25 Nov 2026 12:25:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <314abh@gmail.com>) id 1xWGk3-0007dy-I4
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 12:25:12 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <314abh@gmail.com>) id 1xWGk1-0006w9-28
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 12:25:11 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-cdb628232d2so3359141a12.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 09:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795627507; x=1796232307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8G5G2dBni0JKdh9xrbA4JuHoBL0653720v9pk/wxrJQ=;
 b=UoMMeTmyszgfd8EXSeupq0LLvfo4ZcaLPLe62WF6mZ17MlWCk1l3/zc0kJhMpfJttW
 cNPY1tPWnw8Thyfryn+d1KOba9Y5p17De+Aw2qjztlgQjuko9k8Sk2ZR37ihjOqio8a2
 6vc+IwL/BkJsH28IxBith+AcFDUAhTxQXYzSqBR693+HMCqqkImewwNh4BFH3iuFK5KQ
 nF8KiF/dCZA8fEX9J3T9Ng/CgzJcUVOzlMYXogtNEGvZCpjPmNZbwN3FCQIi+irYIcc2
 Hlwyi4TEW+pVKx9D6t0FtdGOQU5Lg5vNm4ZWzL5wdByHasQkiaU8WEIremQeoggRQwnT
 1CQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795627507; x=1796232307;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8G5G2dBni0JKdh9xrbA4JuHoBL0653720v9pk/wxrJQ=;
 b=2GOZ997DLziQNDkRn/s/HzhLyEYUh9s0t2slXWY8gDhdWdb2BjSXMRFMbrwrfQ851D
 sqUOpwPSrN4bIxwxb+oYm1s4F8cCuiGhHGfS6ItoRFdK8EWMoelc3OecUL3Aw+NsP+dU
 a8M8WvBqr/8KO2IXgUaOo0ZaiZosySdcFc/mGz6vILyqQn2I20/x/IdCYITbBUoCnMoW
 osfxMdKVJi4SztAkP/oz6LsdwsXb2PX8uetq9gms4UHcvmZ1SjKSWiVM7eefdEO2c4Or
 KzMe8LjNonz5GByGTFCkc0WjwsdApzeaLJq7NlcSCoNRlqxSKtoFOc72AguIvu0uojEg
 4nUA==
X-Gm-Message-State: APuU4Z8tevdRo6/sfoGF84hx2RdARm7/xVyBq/1IzDPMV6qa9bL3kSeN
 6rWhxpF4ZBIUdafF1SlePO4l50kt/i+PjNzWTiGftbndT9UzdWVVUb75
X-Gm-Gg: AZFdTZeyNshFaDSCoz8i/ISmedse6tnh+o7qF9gcnmpbS8TzSQgGh0gXwdYJ/u2Sxtd
 JnxHQVN3aNfKG/OHIoL+ZVYyhsu45QPb9ZmmA4e7fDAKap40gF9fTIeIRyZN2fpavXF/99lR0vP
 ZxEncPU/rQym7tHz8SQD2RZB0lQSfUxQXGLotFJ1bFQGeGQkdWflaJvSIg4J6Et3lRYxpnTv4co
 x7EGIXuBBoVHhbguNwJTnGE7Hf9B39uvsxwfkWMAWcl6pcTYtypzg6QNtvjUZNzHWV+T70R+sOO
 Hsrg3AqYHgIAecVY3P3B0ag2JWWiVZwXO6gEFWiyJb0uVjXqdzABUHbR5cEmD2nalt6Np3zFwsK
 gG+fGpI/0mdkvSb3rooYTuv3f4pYhEXXthRNUbL1ggug4NVGgvupBqS4kifiJtIFOaao+pH17sa
 q/ZexjvX3Sc3QCpUOa3C4awo/+iQK6u3O3GP/H/cDoKe0up1Tudyv5N5hMfCjZA/FdHlU5vifCj
 ho1gweHhNmBTbNyAqq1JHP8vthgJUZEXyrPnM2qFFfCrYZG9NDq9gTpnBoovPvs1J4ZkC8Bo68l
 Lc88PIe7RQOXQDvMCdKWvrbY/WSnhLIQ7kjhrizM
X-Received: by 2002:a17:90b:4483:b0:3b0:9deb:d991 with SMTP id
 98e67ed59e1d1-3b41c92cbb8mr17760607a91.35.1795627506799; 
 Wed, 25 Nov 2026 09:25:06 -0800 (PST)
Received: from localhost.localdomain ([117.250.161.222])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b405d96bd3sm31618305a91.12.2026.11.25.09.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 09:25:06 -0800 (PST)
From: abh <314abh@gmail.com>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Abhigyan Kumar <314abh@gmail.com>
Subject: [PATCH v2] target/riscv: make Zicfiss CBO checks independent of TLB
 state
Date: Wed, 25 Nov 2026 22:54:49 +0530
Message-ID: <20261125172449.76621-1-314abh@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=314abh@gmail.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_STARTS_WITH_NUMS,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Abhigyan Kumar <314abh@gmail.com>

The Zicfiss extension requires CBO.CLEAN/FLUSH/INVAL on a shadow stack
page to raise a store/AMO access fault. Citing section 15.1.2.3 ("Shadow
Stack Memory Protection") of the RISC-V spec:

    "Memory mapped as an SS page cannot be written to by instructions
    other than SSAMOSWAP.W/D, SSPUSH, and C.SSPUSH. Attempts will raise
    a store/AMO access-fault exception. Access to a SS page using
    cache-block operation (CBO.*) instructions is not permitted. Such
    accesses will raise a store/AMO access-fault exception. Implicit
    accesses, including instruction fetches to an SS page, are not
    permitted. Such accesses will raise an access-fault exception
    appropriate to the access type. However, the shadow stack is
    readable by all instructions that only load from memory."

Currently, CBO.* instructions quietly return when operated on a shadow
stack page. check_zicomb_access probes pages for read with non-fault
set. Then, get_physical_address reports a shadow stack page as
unreadable when called from a probing tlb_fill. But it only works when
probe reaches tlb_fill. After a usual load, probe hits TLB and reports
the page as readable. Hence, causing CBOs to quietly return.

This commit introduces CPUTLBEntryFull.extra.riscv.sstack as
a marker for shadow stack pages inside TLB entries. When riscv.sstack is
set, check_zicbom_access falls through it to probe_write.

With this commit, the now-redundant special case in get_physical_address
for probe is removed. is_probe in a call to get_physical_address is
replaced with is_sstack_page. As a side effect non-fault probes of
shadow stack pages no longer see them as unreadable, matching what a
usual load does.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4789
Fixes: 669b4867495c ("target/riscv: mmu changes for zicfiss shadow stack protection")
Signed-off-by: Abhigyan Kumar <314abh@gmail.com>
---
v2:
- Rebase on alistair/riscv-to-apply.next (4ac269ea5c).
- Declare fault_addr only for CONFIG_USER_ONLY, fixing the
  -Werror=unused-variable failure in softmmu builds.
---
 include/hw/core/cpu.h         |  5 ++++
 target/riscv/tcg/cpu_helper.c | 49 +++++++++++++++++++++++++----------
 target/riscv/tcg/op_helper.c  | 19 +++++++++++++-
 3 files changed, 59 insertions(+), 14 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 5b7c330047..71666a5497 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -277,6 +277,11 @@ struct CPUTLBEntryFull {
             uint8_t shareability;
             bool guarded;
         } arm;
+
+        struct {
+            /* Zicfiss shadow stack page. */
+            bool sstack;
+        } riscv;
     } extra;
 };
 
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 33d6b41ceb..e13e2ec2a3 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -1096,7 +1096,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
                                 hwaddr *fault_pte_addr,
                                 int access_type, int mmu_idx,
                                 bool first_stage, bool two_stage,
-                                bool is_debug, bool is_probe)
+                                bool is_debug, bool *is_sstack_page)
 {
     /*
      * NOTE: the env->pc value visible here will not be
@@ -1254,7 +1254,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
             int vbase_ret = get_physical_address(env, &vbase, &vbase_prot,
                                                  base, NULL, MMU_DATA_LOAD,
                                                  MMUIdx_U, false, true,
-                                                 is_debug, false);
+                                                 is_debug, NULL);
 
             if (vbase_ret != TRANSLATE_SUCCESS) {
                 if (fault_pte_addr) {
@@ -1411,6 +1411,9 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
         return TRANSLATE_FAIL;
     }
 
+    /* If gets stale after a goto restart. */
+    sstack_page = false;
+
     target_ulong rwx = pte & (PTE_R | PTE_W | PTE_X);
     /* Check for reserved combinations of RWX flags. */
     switch (rwx) {
@@ -1421,10 +1424,10 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
         if (cpu_get_bcfien(env) && first_stage) {
             sstack_page = true;
             /*
-             * if ss index, read and write allowed. else if not a probe
-             * then only read allowed
+             * If ss index, read and write allowed, else allow only reads.
+             * Page flagged in TLB for CBOs to be able to tell them apart.
              */
-            rwx = is_sstack_idx ? (PTE_R | PTE_W) : (is_probe ? 0 :  PTE_R);
+            rwx = is_sstack_idx ? (PTE_R | PTE_W) : PTE_R;
             break;
         }
         return TRANSLATE_FAIL;
@@ -1539,7 +1542,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
             int gpa_ret = get_physical_address(env, &gpa_paddr, &gpa_prot,
                                                pte_gpa, NULL, MMU_DATA_STORE,
                                                MMUIdx_U, false, true,
-                                               is_debug, false);
+                                               is_debug, NULL);
             if (gpa_ret != TRANSLATE_SUCCESS) {
                 if (fault_pte_addr) {
                     *fault_pte_addr = pte_gpa >> 2;
@@ -1612,6 +1615,10 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     }
     *ret_prot = prot;
 
+    if (is_sstack_page) {
+        *is_sstack_page = sstack_page;
+    }
+
     return TRANSLATE_SUCCESS;
 }
 
@@ -1669,13 +1676,13 @@ bool riscv_cpu_translate_for_debug(CPUState *cs, vaddr addr,
     int mmu_idx = riscv_env_mmu_index(&cpu->env, false);
 
     if (get_physical_address(env, &phys_addr, &prot, addr, NULL, 0, mmu_idx,
-                             true, env->virt_enabled, true, false)) {
+                             true, env->virt_enabled, true, NULL)) {
         return false;
     }
 
     if (env->virt_enabled) {
         if (get_physical_address(env, &phys_addr, &prot, phys_addr, NULL,
-                                 0, MMUIdx_U, false, true, true, false)) {
+                                 0, MMUIdx_U, false, true, true, NULL)) {
             return false;
         }
     }
@@ -1779,6 +1786,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     bool first_stage_error = true;
     bool two_stage_lookup = mmuidx_2stage(mmu_idx);
     bool two_stage_indirect_error = false;
+    bool sstack_page = false;
     int ret = TRANSLATE_FAIL;
     privilege_mode_t mode = mmuidx_priv(mmu_idx);
     /* default TLB page size */
@@ -1794,7 +1802,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         /* Two stage lookup */
         ret = get_physical_address(env, &pa, &prot, address,
                                    &env->guest_phys_fault_addr, access_type,
-                                   mmu_idx, true, true, false, probe);
+                                   mmu_idx, true, true, false, &sstack_page);
         /*
          * A G-stage exception may be triggered during two state lookup.
          * And the env->guest_phys_fault_addr has already been set in
@@ -1816,7 +1824,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
             ret = get_physical_address(env, &pa, &prot2, im_address, NULL,
                                        access_type, MMUIdx_U, false, true,
-                                       false, probe);
+                                       false, NULL);
 
             qemu_log_mask(CPU_LOG_MMU,
                           "%s 2nd-stage address=%" VADDR_PRIx
@@ -1854,7 +1862,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         /* Single stage lookup */
         ret = get_physical_address(env, &pa, &prot, address, NULL,
                                    access_type, mmu_idx, true, false, false,
-                                   probe);
+                                   &sstack_page);
 
         qemu_log_mask(CPU_LOG_MMU,
                       "%s address=%" VADDR_PRIx " ret %d physical "
@@ -1880,8 +1888,23 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     }
 
     if (ret == TRANSLATE_SUCCESS) {
-        tlb_set_page(cs, address & ~(tlb_size - 1), pa & ~(tlb_size - 1),
-                     prot, mmu_idx, tlb_size);
+        /*
+         * tlb_set_page(cs, address & ~(tlb_size - 1), pa & ~(tlb_size - 1),
+         *           prot, mmu_idx, tlb_size);
+         */
+        CPUTLBEntryFull full = {
+            .phys_addr = pa & ~(tlb_size - 1),
+            .attrs = MEMTXATTRS_UNSPECIFIED,
+            .prot = prot,
+            .lg_page_size = ctz64(tlb_size),
+            /*
+             * Allows CBO.* to differentiate between a shadow-ss from a usual,
+             * readable one.
+             */
+            .extra.riscv.sstack = sstack_page,
+        };
+
+        tlb_set_page_full(cs, mmu_idx, address & ~(tlb_size - 1), &full);
         return true;
     } else if (probe) {
         return false;
diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index 52aa545eec..b9ca737fb7 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -224,6 +224,9 @@ void HELPER(cbo_zero)(CPURISCVState *env, target_ulong address)
  * section 2.5.2 of the CMO specification) for Zicbom, raising
  * either store page-fault (non-virtualized) or store guest-page
  * fault (virtualized).
+ *
+ * Zicfiss: CBOs on a shadow stack page always raise a store/AMO access fault
+ * even though loads are allowed.
  */
 static void check_zicbom_access(CPURISCVState *env,
                                 target_ulong address,
@@ -231,8 +234,12 @@ static void check_zicbom_access(CPURISCVState *env,
 {
     uint16_t cbomlen = riscv_cpu_cfg(env)->cbom_blocksize;
     int mmu_idx = riscv_env_mmu_index(env, false);
-    uint64_t fault_addr = address;
     void *phost;
+#ifdef CONFIG_USER_ONLY
+    uint64_t fault_addr = address;
+#else
+    CPUTLBEntryFull *full;
+#endif
     int ret;
 
     /* Mask off low-bits to align-down to the cache-block. */
@@ -250,6 +257,7 @@ static void check_zicbom_access(CPURISCVState *env,
      * addresses, whether a cache-block management instruction is
      * permitted to access the cache block is UNSPECIFIED."
      */
+#ifdef CONFIG_USER_ONLY
     ret = probe_access_flags(env, address, cbomlen, MMU_DATA_LOAD,
                              mmu_idx, true, &phost, ra);
     if (ret & TLB_MMIO) {
@@ -259,6 +267,15 @@ static void check_zicbom_access(CPURISCVState *env,
         /* Success: readable */
         return;
     }
+#else
+    ret = probe_access_full(env, address, cbomlen, MMU_DATA_LOAD,
+            mmu_idx, true, &phost, &full, ra);
+    /* A shadow stack page is readable but faults after fall through. */
+    if (ret != TLB_INVALID_MASK && !full->extra.riscv.sstack) {
+        /* Success: readable */
+        return;
+    }
+#endif
 
     /*
      * Since not readable, must be writable. On failure, store
-- 
2.56.1


