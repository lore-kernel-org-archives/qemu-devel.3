Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133B7C25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 23:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBN4m-0004Py-C4; Sun, 26 May 2024 19:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN4k-0004Nt-J7; Sun, 26 May 2024 19:14:50 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN4h-0003iR-Cu; Sun, 26 May 2024 19:14:50 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AC7B44E64EC;
 Mon, 27 May 2024 01:13:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id PUPOatP-xNB6; Mon, 27 May 2024 01:13:07 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C06844E62C1; Mon, 27 May 2024 01:13:07 +0200 (CEST)
Message-Id: <3eccbbc40175cbf8e592fb62c0544202052c571c.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1716763435.git.balaton@eik.bme.hu>
References: <cover.1716763435.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 31/43] target/ppc/mmu-radix64: Remove externally unused parts
 from header
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 27 May 2024 01:13:07 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Move the parts not needed outside of mmu-radix64.c from the header to
the C file to leave only parts in the header that need to be exported.
Also drop unneded include of this header.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
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
2.30.9


