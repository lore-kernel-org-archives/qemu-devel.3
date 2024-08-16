Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028DCC52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 01:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1selRN-0001Mn-79; Thu, 15 Aug 2024 21:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1selRI-00013Z-Gu
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 21:07:36 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1selRE-0002Lt-V8
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 21:07:35 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70eae5896bcso1331895b3a.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 18:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723770451; x=1724375251;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YqB19504yuGdFpD88It922X852UhjxF374vDqd+HBq0=;
 b=VCKTTPxRx4I01JTdGgtV+FWOMhKrVxNhOd4GJx6wz4aijhOH6tj8Z5Vk9l5IHKQNM6
 CkKAzLqKiD36j97gUwqCwJJcfc//ciCyRCddYkxRl2NEcAHWQJf6SpYdonc87cJ5TjDA
 G5/q5Z/aisQn1yQJIXpB9WC8TirSZtmURp1iE5TwLithnqgD+P7A/kp3m8OarOdffeRy
 KMVBlRpnRKZ3SR8q4J9wnVPTIfYHEYo/k72hQUYwrFXYCoUTVbJMLEsxXuZ4DJ1fdHgv
 YSbaCJmQnZ+TtXUHytRg24cczdWvGDDlCU+q3oenCCKoUF4SGTjzH0SOW5GbYcUri96a
 HeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723770451; x=1724375251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YqB19504yuGdFpD88It922X852UhjxF374vDqd+HBq0=;
 b=MOFSyzVHXyDgwzY+D5Ic3xgXC9qYmsiimF9VyKPHbqqCBVkcYQXQCoCYoE6hnBTRiA
 hXzg6Ve1HSUsseEXBwiCtJE5u/UiLQmGI8pgDxGe7oGSkMimyoib6IojRLgaH6b2pssR
 6I96PQHieb/FKvt2Y53KLBRF/RoUmJWZnVF9s8BG08NfK1U5Jn4S09Lk6t7wF0w7XYv2
 PVzQr/tmcic3DyUk0926PC+FDNiYSxr02ore0BDfi+7VtPON2FZG0DLiWCpb5bvz18hd
 gIIi5lqrx/5n/hqXVbLeU1TWDnNAdhDRvaVwQNG/0cZ+w7MFE1VzyTXgKpok1HJcJjJM
 tiRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9wSbcPj6y2SAgfqWHiWVQAkbFawCtRsr01D0qwd8NGlGUkyBXRUSEx0zsGoOH8EpAjR23KFj/2bfJhEmCTzF+Av1hZD0=
X-Gm-Message-State: AOJu0Yz6bF59R1FU9oZZglCOKSwj+66LN0DLzmrHYnngPohuBYykYJAK
 8qS0rdHl+WcgCpFfmFhWxFNmoo07WZ7JIvq5MUy6v04wAaUMg9xBb0wTZTpOGoh091Xx2Isz+CH
 j
X-Google-Smtp-Source: AGHT+IGsKVArrHgnXQWXyaoN7J3KhvJ+T2nC6B+thCTVqAOKx3LGYIdqcbmAip9xtkvgEivBu8zRug==
X-Received: by 2002:a05:6a00:1705:b0:710:4d3a:2d92 with SMTP id
 d2e1a72fcca58-713c4dff750mr1628428b3a.4.1723770451364; 
 Thu, 15 Aug 2024 18:07:31 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127ae120cdsm1604806b3a.77.2024.08.15.18.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 18:07:31 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, richard.henderson@linaro.org,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, pbonzini@redhat.com, jim.shu@sifive.com,
 andy.chiu@sifive.com, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v4 11/16] target/riscv: mmu changes for zicfiss shadow stack
 protection
Date: Thu, 15 Aug 2024 18:07:05 -0700
Message-ID: <20240816010711.3055425-12-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240816010711.3055425-1-debug@rivosinc.com>
References: <20240816010711.3055425-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 target/riscv/cpu_helper.c | 52 +++++++++++++++++++++++++++++++++++++--
 target/riscv/internals.h  |  3 +++
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index d3115da28d..4d282fd9ed 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -817,6 +817,18 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
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
@@ -894,6 +906,8 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     hwaddr ppn;
     int napot_bits = 0;
     target_ulong napot_mask;
+    bool is_sstack_insn = ((mmu_idx & MMU_IDX_SS_WRITE) == MMU_IDX_SS_WRITE);
+    bool sstack_page = false;
 
     /*
      * Check if we should use the background registers for the two
@@ -1104,13 +1118,34 @@ restart:
 
     /* Check for reserved combinations of RWX flags. */
     switch (pte & (PTE_R | PTE_W | PTE_X)) {
-    case PTE_W:
     case PTE_W | PTE_X:
         return TRANSLATE_FAIL;
+    case PTE_W:
+        /* if bcfi enabled, PTE_W is not reserved and shadow stack page */
+        if (cpu_get_bcfien(env) && first_stage) {
+            sstack_page =  true;
+            break;
+        }
+        return TRANSLATE_FAIL;
+    }
+
+    /* Illegal combo of instruction type and page attribute */
+    if (!legal_sstack_access(access_type, is_sstack_insn,
+                            sstack_page)) {
+        /* shadow stack instruction and RO page then it's a page fault */
+        if (is_sstack_insn && ((pte & (PTE_R | PTE_W | PTE_X)) == PTE_R)) {
+                return TRANSLATE_FAIL;
+        }
+        /* In all other cases it's an access fault, so raise PMP_FAIL */
+        return TRANSLATE_PMP_FAIL;
     }
 
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
@@ -1348,9 +1383,17 @@ void riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
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
@@ -1406,6 +1449,11 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     qemu_log_mask(CPU_LOG_MMU, "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
                   __func__, address, access_type, mmu_idx);
 
+    /* If shadow stack instruction initiated this access, treat it as store */
+    if (mmu_idx & MMU_IDX_SS_WRITE) {
+        access_type = MMU_DATA_STORE;
+    }
+
     pmu_tlb_fill_incr_ctr(cpu, access_type);
     if (two_stage_lookup) {
         /* Two stage lookup */
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
-- 
2.44.0


