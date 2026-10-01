Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D46CA5FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 15:56:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCJ8B-0005qb-Ok; Thu, 01 Oct 2026 11:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xCJ7J-0004mY-AB; Thu, 01 Oct 2026 11:54:46 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xCJ7H-0005bV-0l; Thu, 01 Oct 2026 11:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=iG0fQF51w5ZWZRWimGboqXPu9U3cxcuBpucNtLD9zcc=; b=xDlE78UQnNt2/0m
 RqkJIDa0tvhn7LZv+zjy2IaSDfMrbyKU3siFPk7NRAQ1xL+EUFfdtzyA14UqfgwKBF7myaAjYCXFz
 U3rKUrAE9ImGUmvrZoZnyt/rKFfbO7HeUpGCgC+ZkMJUibhhHHH4lcl4QygI3XRQgNPnlP1ynPOFB
 e8=;
Date: Thu, 01 Oct 2026 17:59:41 +0200
Subject: [PATCH 18/18] target/riscv: Compile monitor.c once
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-rv-dedup-v1-18-ea69b07afd31@rev.ng>
References: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
In-Reply-To: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790870392; l=4812;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=dIE/q6sNlwcAnKeJGD9CkZ7k/7Mps5NP2Vp2sm0wBGg=;
 b=Gc8/Ssxdwj4FCLaQ+3avP28e7dQ65eUo7j8aubI+cLWzljlGBtQHKg3FFcq+QSZnl/rVsAXz3
 3jFubumcPXiBEVsuPJDTNh9LZd7TO3TtcX4xHm/AiSNVHiupYsHRXPy
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Replaces uses of target_ulong with vaddr/hwaddr/uint64_t where
appropriate.

Note: This commit will print all addresses as 64-bit values, even for a
32-bit target. If breaking this interface is not an option we can
instead opt for more runtime branching, as done by Joel Stanley
in commit 409c7d8682a.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/monitor.c   | 42 ++++++++++++++++++------------------------
 target/riscv/meson.build |  2 +-
 2 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index fc61638702..24c5244c36 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -21,35 +21,29 @@
 #include "qemu/osdep.h"
 #include "qemu/ctype.h"
 #include "qemu/qemu-print.h"
-#include "exec/target_long.h"
-#include "cpu.h"
+#include "target/riscv/cpu.h"
+#include "target/riscv/cpu_bits.h"
 #include "target/riscv/tcg/csr.h"
-#include "cpu_bits.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
 #include "system/memory.h"
 #include "internals.h"
 
-#ifdef TARGET_RISCV64
 #define PTE_HEADER_FIELDS       "vaddr            paddr            "\
                                 "size             attr\n"
 #define PTE_HEADER_DELIMITER    "---------------- ---------------- "\
                                 "---------------- -------\n"
-#else
-#define PTE_HEADER_FIELDS       "vaddr    paddr            size     attr\n"
-#define PTE_HEADER_DELIMITER    "-------- ---------------- -------- -------\n"
-#endif
 
 #ifdef CONFIG_HMP
 
 /* Perform linear address sign extension */
-static target_ulong addr_canonical(int va_bits, target_ulong addr)
+static vaddr addr_canonical(int va_bits, vaddr addr)
 {
-#ifdef TARGET_RISCV64
-    if (addr & (1UL << (va_bits - 1))) {
-        addr |= (hwaddr)-(1L << va_bits);
+    if (target_riscv64()) {
+        if (addr & (1UL << (va_bits - 1))) {
+            addr |= (hwaddr)-(1L << va_bits);
+        }
     }
-#endif
 
     return addr;
 }
@@ -60,8 +54,8 @@ static void print_pte_header(MonitorHMP *hmp)
     monitor_hmp_printf(hmp, PTE_HEADER_DELIMITER);
 }
 
-static void print_pte(MonitorHMP *hmp, int va_bits, target_ulong vaddr,
-                      hwaddr paddr, target_ulong size, int attr)
+static void print_pte(MonitorHMP *hmp, int va_bits, vaddr vaddr,
+                      hwaddr paddr, uint64_t size, int attr)
 {
     /* sanity check on vaddr */
     if (vaddr >= (1UL << va_bits)) {
@@ -72,7 +66,7 @@ static void print_pte(MonitorHMP *hmp, int va_bits, target_ulong vaddr,
         return;
     }
 
-    monitor_hmp_printf(hmp, TARGET_FMT_lx " " HWADDR_FMT_plx " " TARGET_FMT_lx
+    monitor_hmp_printf(hmp, "%016" VADDR_PRIx " " HWADDR_FMT_plx " %016" PRIx64
                        " %c%c%c%c%c%c%c\n",
                        addr_canonical(va_bits, vaddr),
                        paddr, size,
@@ -86,17 +80,17 @@ static void print_pte(MonitorHMP *hmp, int va_bits, target_ulong vaddr,
 }
 
 static void walk_pte(MonitorHMP *hmp, AddressSpace *as,
-                     hwaddr base, target_ulong start,
+                     hwaddr base, uint64_t start,
                      int level, int ptidxbits, int ptesize, int va_bits,
-                     target_ulong *vbase, hwaddr *pbase, hwaddr *last_paddr,
-                     target_ulong *last_size, int *last_attr)
+                     vaddr *vbase, hwaddr *pbase, hwaddr *last_paddr,
+                     uint64_t *last_size, int *last_attr)
 {
     const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     hwaddr pte_addr;
     hwaddr paddr;
-    target_ulong last_start = -1;
-    target_ulong pgsize;
-    target_ulong pte;
+    uint64_t last_start = -1;
+    uint64_t pgsize;
+    uint64_t pte;
     int ptshift;
     int attr;
     int idx;
@@ -158,10 +152,10 @@ static void mem_info_svxx(MonitorHMP *hmp, CPUArchState *env)
     AddressSpace *as = env_cpu(env)->as;
     int levels, ptidxbits, ptesize, vm, va_bits;
     hwaddr base;
-    target_ulong vbase;
+    vaddr vbase;
     hwaddr pbase;
     hwaddr last_paddr;
-    target_ulong last_size;
+    uint64_t last_size;
     int last_attr;
 
     if (riscv_cpu_mxl(env) == MXL_RV32) {
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index d20eaa2269..a28466515e 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -22,7 +22,6 @@ riscv_stubs_ss = ss.source_set()
 
 riscv_system_ss = ss.source_set()
 riscv_system_ss.add(files(
-  'monitor.c',
 ))
 
 riscv_user_ss = ss.source_set()
@@ -36,6 +35,7 @@ riscv_common_system_ss.add(files(
   'arch_dump.c',
   'cpu.c',
   'machine.c',
+  'monitor.c',
   'riscv-qmp-cmds.c',
   'time_helper.c',
 ))

-- 
2.52.0


