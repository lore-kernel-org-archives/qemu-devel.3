Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E94C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 17:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYUZM-0005sf-7G; Mon, 29 Jul 2024 13:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sYUZF-0005Sj-QD
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:53:57 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sYUZD-0000MI-Fn
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:53:53 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-25e397c51b2so2436334fac.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 10:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722275629; x=1722880429;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TEfM6wszBxNOPAb1bi7YlYVEQlyhfpgNlHnmktCCwL8=;
 b=yz6WupQkwDlFD8EWKlRuPqiXWkG6VkRWtbJOsfqcblGlNbalWreMHSF60+G/cq7IGU
 QCuWikFJTgWkkM98sgA6WXlCROAoNUXC6sFhgs0XolSlwNrsWlQw0I9aCLj+j6qBJ2BQ
 0jZ2VAieAGp00bBw5kc068KN6kb+9ULeFwwda5cD3e1Niy2Ym8fSiu8Igd8JoyuHQPWW
 hPG9Yzj8pOn88FBNuOIEuGNPNjB0isBIIOW4uZ4Fney4oYu9JHDhrkW86UCUdHy+DKmZ
 dCa1XHhj/W+a6XRN0yZrhxdwHcy67JHfpVf0SQ9ZpRL/nmxJl0kQq+qBLeDTvzxAQJul
 Sggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722275629; x=1722880429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TEfM6wszBxNOPAb1bi7YlYVEQlyhfpgNlHnmktCCwL8=;
 b=K5HtTP+Mn5x4CrA8Iahhh6MopWWEJQ/Y1PYBUCGOUNN0QIhXaZ1EJkUUrJ4S7qCw9R
 q1vA354lmOW+6MvWBbCS5sR6I/5DspbcPIuuqup7ovvTAGVPH4eEc53gkbGZ/+AQxnXW
 XIwMEf7bEV4W6FLyzxUsptw7l8hOsXxZNa9q2xDwrF7ZW1mC4fqGDWBj6suMnXJqPm8U
 DcA0UxclJZJC24pgdX1NsiUkoIka0JEqk5u2Ajfuoo2/ezTw99x5rCSgUlNLYfoP+5NL
 2cLeCwadBrKCzNeU65lVD/URI4dj0eypcORkOcAYi1BBQQiTisAnpg39kxVv5e1klZGN
 nLMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWv4dhTofuAXVxsygdAFKl/jhbHQ+Lr+eYwKYZQ1e1qvMOOUb7Flyp2XXeCYCrv87DNQxpM6Y7Q41ooC4hoNBwYqFTJmbc=
X-Gm-Message-State: AOJu0Ywtsatt4jPQkw9w55kGbhaIZj6B29WFrEx4hKY47inyiAllruHs
 e3uiLwd/exzHzAsc/vi6EFHHUF9jHe973qdqCD8jWEvd8UZsqbY59TUnw7uX9Lw=
X-Google-Smtp-Source: AGHT+IEK66sr2CO2D8t3mFv/s9pI0FtrJLP8drLOKOAsSvwBW4+O9nQJqnhfa0y2KL3wRG4TQ6TJMQ==
X-Received: by 2002:a05:6870:71c7:b0:260:f50e:923e with SMTP id
 586e51a60fabf-267d4f1dfa7mr8623685fac.37.1722275629471; 
 Mon, 29 Jul 2024 10:53:49 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a9f7c71b15sm6303141a12.18.2024.07.29.10.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 10:53:48 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, jim.shu@sifive.com,
 andy.chiu@sifive.com, jesse.huang@sifive.com, kito.cheng@sifive.com
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v2 15/24] target/riscv: mmu changes for zicfiss shadow stack
 protection
Date: Mon, 29 Jul 2024 10:53:17 -0700
Message-ID: <20240729175327.73705-16-debug@rivosinc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240729175327.73705-1-debug@rivosinc.com>
References: <20240729175327.73705-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=debug@rivosinc.com; helo=mail-oa1-x34.google.com
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
index ce68f5af72..7942587a56 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -819,6 +819,18 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
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
@@ -896,6 +908,8 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     hwaddr ppn;
     int napot_bits = 0;
     target_ulong napot_mask;
+    bool is_sstack_insn = ((mmu_idx & MMU_IDX_SS_ACCESS) == MMU_IDX_SS_ACCESS);
+    bool sstack_page = false;
 
     /*
      * Check if we should use the background registers for the two
@@ -1104,15 +1118,45 @@ restart:
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
@@ -1350,9 +1394,17 @@ void riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
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
@@ -1408,6 +1460,11 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
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


