Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21B1CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQi4-0003el-IY; Tue, 16 Jun 2026 06:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQi2-0003JD-5Y
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:07:54 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQhz-0003YC-Vv
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:07:53 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-36ba285e98bso4337249a91.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604471; x=1782209271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NZCHWP87J1KCGD/lBAcv42oDW/fhm0BWCAY/URuwlgY=;
 b=mhEuV067Amlq2Op/1hmoqYvuCNw9aUm6vZiZ8dMKtu15KkDSJMg3EZDKZmEb9lwHC3
 QQSN46vkWYFfRrRnCMl2pytxP154RV9SLOUwINFyXPY4JSOAfOT7EBdRqaCdFvd8HR88
 ovde2UA5SJ0/Ez3Jlx1XgJ4UW1u36TIwB/gVygVlTnKx0e6loC8l9nmKLH7XsAGdti0d
 9QCm4XO0ajv8NavyDyTJMygObujzBT5vutLaWSapFwL+qE1f/UepUj8Wp/ClOGSczYPq
 VFeemnV8Kj0lgu2QCi62lsAWJHLe8NRhnVMB0SBP+UhMSTR1a9Buhm2TY3J4wlw6jWNz
 xksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604471; x=1782209271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NZCHWP87J1KCGD/lBAcv42oDW/fhm0BWCAY/URuwlgY=;
 b=ftGb8OWgxfULxICNCqnNxkpDMx+6FNF+/LRk1OZaTmVAovNqIvoOv0gj9HKNxfFwFH
 lBCQAczf+L7/XJAN0VM4DyrInoXWZzsvDmOZhbFIVORP2nUnfIxi5RRvl7/GctNZps3S
 gdatgBaAtpCoL0Uh4zDXCwwG6KEtldKXi6brpnKD7mRGnuQWqQNHYqU/790aKWNkjFrB
 IR/GgDVwzbG71KSJ6qXv+q5fkXsKCITkZm+VhaB2PxrF61Bg+7LUzbihZQ+QlF6mkuue
 Sl2z5iCDY5docwKLNIZPdBJmRxlJJEJc333CMj1SHhXVutJ+K4aq5dQjbNfOqkzVffNe
 ZnUQ==
X-Gm-Message-State: AOJu0Yz/dP0NjRld7k2+rIyWTiO+OXS838kMPgCUSH/5jrtPJ+7NqPCB
 vcEybzYRiO4MMwBPeIbshO75g/oySfK9Yo8rN5JDcWoigYSTltlPIPihJrZ2bKb8
X-Gm-Gg: Acq92OFleOAMjh14BClrWRZZ6b0yUOBH2N+hH9IRT01ICEfVVb+lKxIpE8DsST87Qm/
 eEPfAPyITF9612E5lon5vWrCfgaGYY2XKGqm4aj1GlcSxUmhvpBzkT3By+Z58fgUBg4kUPIVgdW
 5CEMqt+Mxu7XX+8DvyDYRxjWpusxvWSSyjCzY+Y6e50byAU0rOPqWPRA3CmXETLDH6dnXcnucjF
 Hf99CWNXD8CZLHudoA7hGz3k+y4s6IfsPju8nBkW7ligJgXhh2Wc7m0USyud1b2VnXsxhrDmsO9
 34sDjyvfzGvnQMpMG1QvHPz+7mPaaWkeGWRGcee2iFZzppuMFVD8ux2ZJWxbJUvenhLx+o5epJP
 DgJafqEqiN5YLEMe72P4pBO9Y5OiV1TeFG5lZuIK5Fh5CmP66PHGWuVxHxk4rTDZx7M7TeAEOOs
 hVCnVGXCClWJQQlgvU00alCXhch7djUZx/fyEJ0xKJ
X-Received: by 2002:a05:6a20:2443:b0:3b4:b276:a789 with SMTP id
 adf61e73a8af0-3b7841ab01dmr20768275637.36.1781604470534; 
 Tue, 16 Jun 2026 03:07:50 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:07:50 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PULL 39/83] target/riscv/cpu_helper.c: add PMA access fault
Date: Tue, 16 Jun 2026 20:04:42 +1000
Message-ID: <20260616100527.1939565-40-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102f.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

We're not doing anything special w.r.t PMA (Physical Memory Access)
related faults, handling them like regular faults that will eventually
turn to be regular page faults.

Turns out we can't do that.  Priv spec section "Virtual Address
Translation Process" mentions:

"If a store to the PTE at address a+va.vpn[i]×PTESIZE would violate a
PMA or PMP check, raise an access-fault exception corresponding to the
original access type."

This means that we should handle PMA violations with access faults, like
we're already doing with PMP.  One clear code path where we should throw
a PMA failure, exposed by [1], is the error return from
address_space_ld* call.

There's a separated issue with the error code being returned by them (it
always return DECODE_ERROR even with 'rejected' reads) that we're going
to work around it by assuming that we did a good job with the PTE
address sanitization beforehand, and interpret that the error here is
related to PMA.  This is of course not ideal but fixing this QEMU API is
out of scope for this work.

All this said, we'll set the new pmp_pma_violation flag when we have
either a PMP or a PMA fault, and everything else shall fall into place.

[1] https://gitlab.com/qemu-project/qemu/-/work_items/3502

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3502
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Message-ID: <20260522172502.320529-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  3 ++-
 target/riscv/cpu_helper.c | 34 +++++++++++++++++++++++++---------
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 68e1ec37b4..1805aa8dfd 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -137,7 +137,8 @@ enum {
     TRANSLATE_SUCCESS,
     TRANSLATE_FAIL,
     TRANSLATE_PMP_FAIL,
-    TRANSLATE_G_STAGE_FAIL
+    TRANSLATE_G_STAGE_FAIL,
+    TRANSLATE_PMA_FAIL,
 };
 
 /* Extension context status */
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index be36dca8f1..dc78fc1192 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1424,7 +1424,22 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
         }
 
         if (res != MEMTX_OK) {
-            return TRANSLATE_FAIL;
+            /*
+             * The result of address_space_* APIs above does not take into
+             * consideration reject reads, putting all errors in the same
+             * cathegory (DECODE_ERROR), although there's a clear
+             * distinction between a rejected read versus other errors
+             * (see memory_region_dispatch_read() ->
+             * memory_region_access_valid()).  This is something that
+             * we might have to deal with core QEMU logic some other
+             * day.
+             *
+             * For this particular error path, given that we made checks
+             * w.r.t legal PTE address before calling those APIs, we'll
+             * assume that anything != MEMTX_OK means a rejected read,
+             * i.e. a PMA error.
+             */
+            return TRANSLATE_PMA_FAIL;
         }
 
         if (riscv_cpu_sxl(env) == MXL_RV32) {
@@ -1704,7 +1719,8 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
 }
 
 static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
-                                MMUAccessType access_type, bool pmp_violation,
+                                MMUAccessType access_type,
+                                bool pmp_pma_violation,
                                 bool first_stage, bool two_stage,
                                 bool two_stage_indirect)
 {
@@ -1712,7 +1728,7 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
 
     switch (access_type) {
     case MMU_INST_FETCH:
-        if (pmp_violation) {
+        if (pmp_pma_violation) {
             cs->exception_index = RISCV_EXCP_INST_ACCESS_FAULT;
         } else if (env->virt_enabled && !first_stage) {
             cs->exception_index = RISCV_EXCP_INST_GUEST_PAGE_FAULT;
@@ -1721,7 +1737,7 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
         }
         break;
     case MMU_DATA_LOAD:
-        if (pmp_violation) {
+        if (pmp_pma_violation) {
             cs->exception_index = RISCV_EXCP_LOAD_ACCESS_FAULT;
         } else if (two_stage && !first_stage) {
             cs->exception_index = RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT;
@@ -1730,7 +1746,7 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
         }
         break;
     case MMU_DATA_STORE:
-        if (pmp_violation) {
+        if (pmp_pma_violation) {
             cs->exception_index = RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
         } else if (two_stage && !first_stage) {
             cs->exception_index = RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT;
@@ -1856,7 +1872,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     vaddr im_address;
     hwaddr pa = 0;
     int prot, prot2, prot_pmp;
-    bool pmp_violation = false;
+    bool pmp_pma_violation = false;
     bool first_stage_error = true;
     bool two_stage_lookup = mmuidx_2stage(mmu_idx);
     bool two_stage_indirect_error = false;
@@ -1956,8 +1972,8 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         }
     }
 
-    if (ret == TRANSLATE_PMP_FAIL) {
-        pmp_violation = true;
+    if (ret == TRANSLATE_PMP_FAIL || ret == TRANSLATE_PMA_FAIL) {
+        pmp_pma_violation = true;
     }
 
     if (ret == TRANSLATE_SUCCESS) {
@@ -1984,7 +2000,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         cpu_check_watchpoint(cs, address, size, MEMTXATTRS_UNSPECIFIED,
                              wp_access, retaddr);
 
-        raise_mmu_exception(env, address, access_type, pmp_violation,
+        raise_mmu_exception(env, address, access_type, pmp_pma_violation,
                             first_stage_error, two_stage_lookup,
                             two_stage_indirect_error);
         cpu_loop_exit_restore(cs, retaddr);
-- 
2.54.0


