Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7DDC3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Nr-0001b9-CC; Thu, 25 Jul 2024 20:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8NH-0006UN-Sx; Thu, 25 Jul 2024 19:59:57 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8NF-0002Cn-VW; Thu, 25 Jul 2024 19:59:55 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-6e7b121be30so325363a12.1; 
 Thu, 25 Jul 2024 16:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951992; x=1722556792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kdx46LXlt6R4HiSadrw/hm+JsxDGiiDJsqDHhTQdFCY=;
 b=X5d2i23SyEFhl9ZXhwma0ke5XD0f/xSzBMjO6AcwzQnJLdu13BCTUv/zEgCpLjv3PU
 jsZ2EU2PsHQdXsybgGsOZkn+LXZUOmbAecSVroWxvEPiTzpI8XM+Z1r3OUH5BujTXCoF
 jC21sxXJxO5yOcGECB3CQ2GTSuAUPDfALBVY8QMJvxRWyvG5hA1fcSEKB3Mby0rAFB0v
 ArxJXxTielgk4BGw1LNGON+OxobOumJjVL7+FXkwNueEGLAjHztssO6ovZR/vmU8UuqF
 b6roZdjjJlwY6B61DmKZeAyXuPq5c3RfG2bTFyApybdrsKkt1982WJHFKnL+BYUckNMN
 uQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951992; x=1722556792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kdx46LXlt6R4HiSadrw/hm+JsxDGiiDJsqDHhTQdFCY=;
 b=JsvOSqff+LWqiKBYSF4zlMt0or4t7ULYKwW0mmA0Icp0oMhg90rArVAG8otwdLfdL5
 6N0tV9RdaYupp6looG+Bno3/9RHP+hhjQ5dBl6qT1AE/wudrcQVg8yJT5xzprQuQv5fi
 /kNWBjuZM6wk0LqefxRXg3gsNu8kS2SfflGGkGtt+kev8pz4jgaIGnju6FIXF1bnJ5SY
 aAdZKoCtwegZzeTBe9P5vljawMssB3Bg3tclmq4lufa5oerTLV/24jY7GQgw9hqYhT5J
 fq/JcXY1AUA3LcSx5ye2FR0dd/+VLwcfBxEehZrcBzy5AkpSgPjm5rRo8X2+shoFzql6
 A5fA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyOuGxtSfDsEjT2MknmCa2cha68zr29mtze54gerHNkIFn5mrJL5W7mVL1Ow5btLxmt2P0ZlwUFsf7r5ADa37MgrAO
X-Gm-Message-State: AOJu0YyhxBll5oceMYI5nUPMuSAKq61MrDTuOA6RbB+IaQqfhRmcSrZt
 oWhxaCRNMr2wLwrjzgRBihqXTuEMIb2kRQCAHLv1Ch+SeEk37AZcquI0rg==
X-Google-Smtp-Source: AGHT+IFxHBdGd09iDEesm38EyYwkeazRgjAvcOmQIrnLVDnTeghA4oUnKDGuqRwI6Wfffy9XkB+XJw==
X-Received: by 2002:a05:6a20:c70b:b0:1c4:64d3:cda1 with SMTP id
 adf61e73a8af0-1c472b24430mr4799447637.40.1721951991862; 
 Thu, 25 Jul 2024 16:59:51 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.59.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:59:50 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 95/96] target/ppc/mmu-radix64: Remove externally unused parts
 from header
Date: Fri, 26 Jul 2024 09:54:08 +1000
Message-ID: <20240725235410.451624-96-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Move the parts not needed outside of mmu-radix64.c from the header to
the C file to leave only parts in the header that need to be exported.
Also drop unneded include of this header.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu-book3s-v3.c |  1 -
 target/ppc/mmu-radix64.c   | 49 +++++++++++++++++++++++++++++++++++
 target/ppc/mmu-radix64.h   | 53 +-------------------------------------
 3 files changed, 50 insertions(+), 53 deletions(-)

diff --git a/target/ppc/mmu-book3s-v3.c b/target/ppc/mmu-book3s-v3.c
index c8f69b3df9..a812cb5113 100644
--- a/target/ppc/mmu-book3s-v3.c
+++ b/target/ppc/mmu-book3s-v3.c
@@ -21,7 +21,6 @@
 #include "cpu.h"
 #include "mmu-hash64.h"
 #include "mmu-book3s-v3.h"
-#include "mmu-radix64.h"
 
 bool ppc64_v3_get_pate(PowerPCCPU *cpu, target_ulong lpid, ppc_v3_pate_t *entry)
 {
diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 5a02e4963b..cf9619e847 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -29,6 +29,37 @@
 #include "mmu-radix64.h"
 #include "mmu-book3s-v3.h"
 
+/* Radix Partition Table Entry Fields */
+#define PATE1_R_PRTB           0x0FFFFFFFFFFFF000
+#define PATE1_R_PRTS           0x000000000000001F
+
+/* Radix Process Table Entry Fields */
+#define PRTBE_R_GET_RTS(rts) \
+    ((((rts >> 58) & 0x18) | ((rts >> 5) & 0x7)) + 31)
+#define PRTBE_R_RPDB            0x0FFFFFFFFFFFFF00
+#define PRTBE_R_RPDS            0x000000000000001F
+
+/* Radix Page Directory/Table Entry Fields */
+#define R_PTE_VALID             0x8000000000000000
+#define R_PTE_LEAF              0x4000000000000000
+#define R_PTE_SW0               0x2000000000000000
+#define R_PTE_RPN               0x01FFFFFFFFFFF000
+#define R_PTE_SW1               0x0000000000000E00
+#define R_GET_SW(sw)            (((sw >> 58) & 0x8) | ((sw >> 9) & 0x7))
+#define R_PTE_R                 0x0000000000000100
+#define R_PTE_C                 0x0000000000000080
+#define R_PTE_ATT               0x0000000000000030
+#define R_PTE_ATT_NORMAL        0x0000000000000000
+#define R_PTE_ATT_SAO           0x0000000000000010
+#define R_PTE_ATT_NI_IO         0x0000000000000020
+#define R_PTE_ATT_TOLERANT_IO   0x0000000000000030
+#define R_PTE_EAA_PRIV          0x0000000000000008
+#define R_PTE_EAA_R             0x0000000000000004
+#define R_PTE_EAA_RW            0x0000000000000002
+#define R_PTE_EAA_X             0x0000000000000001
+#define R_PDE_NLB               PRTBE_R_RPDB
+#define R_PDE_NLS               PRTBE_R_RPDS
+
 static bool ppc_radix64_get_fully_qualified_addr(const CPUPPCState *env,
                                                  vaddr eaddr,
                                                  uint64_t *lpid, uint64_t *pid)
@@ -180,6 +211,24 @@ static void ppc_radix64_raise_hsi(PowerPCCPU *cpu, MMUAccessType access_type,
     }
 }
 
+static int ppc_radix64_get_prot_eaa(uint64_t pte)
+{
+    return (pte & R_PTE_EAA_R ? PAGE_READ : 0) |
+           (pte & R_PTE_EAA_RW ? PAGE_READ | PAGE_WRITE : 0) |
+           (pte & R_PTE_EAA_X ? PAGE_EXEC : 0);
+}
+
+static int ppc_radix64_get_prot_amr(const PowerPCCPU *cpu)
+{
+    const CPUPPCState *env = &cpu->env;
+    int amr = env->spr[SPR_AMR] >> 62; /* We only care about key0 AMR63:62 */
+    int iamr = env->spr[SPR_IAMR] >> 62; /* We only care about key0 IAMR63:62 */
+
+    return (amr & 0x2 ? 0 : PAGE_WRITE) | /* Access denied if bit is set */
+           (amr & 0x1 ? 0 : PAGE_READ) |
+           (iamr & 0x1 ? 0 : PAGE_EXEC);
+}
+
 static bool ppc_radix64_check_prot(PowerPCCPU *cpu, MMUAccessType access_type,
                                    uint64_t pte, int *fault_cause, int *prot,
                                    int mmu_idx, bool partition_scoped)
diff --git a/target/ppc/mmu-radix64.h b/target/ppc/mmu-radix64.h
index c5c04a1527..6620b3d648 100644
--- a/target/ppc/mmu-radix64.h
+++ b/target/ppc/mmu-radix64.h
@@ -3,7 +3,7 @@
 
 #ifndef CONFIG_USER_ONLY
 
-#include "exec/page-protection.h"
+#ifdef TARGET_PPC64
 
 /* Radix Quadrants */
 #define R_EADDR_MASK            0x3FFFFFFFFFFFFFFF
@@ -14,61 +14,10 @@
 #define R_EADDR_QUADRANT2       0x8000000000000000
 #define R_EADDR_QUADRANT3       0xC000000000000000
 
-/* Radix Partition Table Entry Fields */
-#define PATE1_R_PRTB           0x0FFFFFFFFFFFF000
-#define PATE1_R_PRTS           0x000000000000001F
-
-/* Radix Process Table Entry Fields */
-#define PRTBE_R_GET_RTS(rts) \
-    ((((rts >> 58) & 0x18) | ((rts >> 5) & 0x7)) + 31)
-#define PRTBE_R_RPDB            0x0FFFFFFFFFFFFF00
-#define PRTBE_R_RPDS            0x000000000000001F
-
-/* Radix Page Directory/Table Entry Fields */
-#define R_PTE_VALID             0x8000000000000000
-#define R_PTE_LEAF              0x4000000000000000
-#define R_PTE_SW0               0x2000000000000000
-#define R_PTE_RPN               0x01FFFFFFFFFFF000
-#define R_PTE_SW1               0x0000000000000E00
-#define R_GET_SW(sw)            (((sw >> 58) & 0x8) | ((sw >> 9) & 0x7))
-#define R_PTE_R                 0x0000000000000100
-#define R_PTE_C                 0x0000000000000080
-#define R_PTE_ATT               0x0000000000000030
-#define R_PTE_ATT_NORMAL        0x0000000000000000
-#define R_PTE_ATT_SAO           0x0000000000000010
-#define R_PTE_ATT_NI_IO         0x0000000000000020
-#define R_PTE_ATT_TOLERANT_IO   0x0000000000000030
-#define R_PTE_EAA_PRIV          0x0000000000000008
-#define R_PTE_EAA_R             0x0000000000000004
-#define R_PTE_EAA_RW            0x0000000000000002
-#define R_PTE_EAA_X             0x0000000000000001
-#define R_PDE_NLB               PRTBE_R_RPDB
-#define R_PDE_NLS               PRTBE_R_RPDS
-
-#ifdef TARGET_PPC64
-
 bool ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
                        hwaddr *raddr, int *psizep, int *protp, int mmu_idx,
                        bool guest_visible);
 
-static inline int ppc_radix64_get_prot_eaa(uint64_t pte)
-{
-    return (pte & R_PTE_EAA_R ? PAGE_READ : 0) |
-           (pte & R_PTE_EAA_RW ? PAGE_READ | PAGE_WRITE : 0) |
-           (pte & R_PTE_EAA_X ? PAGE_EXEC : 0);
-}
-
-static inline int ppc_radix64_get_prot_amr(const PowerPCCPU *cpu)
-{
-    const CPUPPCState *env = &cpu->env;
-    int amr = env->spr[SPR_AMR] >> 62; /* We only care about key0 AMR63:62 */
-    int iamr = env->spr[SPR_IAMR] >> 62; /* We only care about key0 IAMR63:62 */
-
-    return (amr & 0x2 ? 0 : PAGE_WRITE) | /* Access denied if bit is set */
-           (amr & 0x1 ? 0 : PAGE_READ) |
-           (iamr & 0x1 ? 0 : PAGE_EXEC);
-}
-
 #endif /* TARGET_PPC64 */
 
 #endif /* CONFIG_USER_ONLY */
-- 
2.45.2


