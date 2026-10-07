Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2DECA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENsM-000445-Nc; Wed, 07 Oct 2026 05:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xENAS-0004lF-Tp; Wed, 07 Oct 2026 04:38:29 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xENAQ-0006Yq-TA; Wed, 07 Oct 2026 04:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=jLUIeU9uX+0lUOJbZ9oWkmdr2/6VJEqBa8Wqz+SxgwQ=; b=nQTePQVd6oCFBaE
 ZqETFLuA7PD9HOuH6b/RqIKIWMopuUYl5bHtFuMupoUkd7JD+1sU/6XbsSk9YrW74+7qrKXMA/hr0
 kABpSPOmYk9mqqWPzlBoGogs4BKIzr9pxTdqIV7LHkKkpSeU6JtEaVswB2xVXG9gGCOCTM3F1kLNA
 Gk=;
Date: Wed, 07 Oct 2026 10:43:24 +0200
Subject: [PATCH v2 18/18] target/riscv: Compile monitor.c once
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-rv-dedup-v2-18-8a2f0f296a7f@rev.ng>
References: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
In-Reply-To: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, luoyonggang@gmail.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791362620; l=8274;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=aAqG1svz51OZqrFbo2HcINXRUsf6jgQgyLv056SwqnE=;
 b=2n0DKuDdpL/eZsK2OEV7qUN3M0tFPg8aoimF/I8Ud6a48ZsyC7VFyTf6SiYxOb9x8IBWHv5jj
 LIuKNJpuhx0DiNVCbVF2Lq/6Y+lyuvRzG22eSe32gt9zTHSW5Etp0Fa
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
appropriate.  Formatting of printed HMP fields is moved to runtime by
relying on printf specifiers.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/monitor.c   | 88 ++++++++++++++++++++++++++----------------------
 target/riscv/meson.build |  2 +-
 2 files changed, 48 insertions(+), 42 deletions(-)

diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index fc61638702..5d2decf893 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -21,48 +21,50 @@
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
-#define PTE_HEADER_FIELDS       "vaddr            paddr            "\
-                                "size             attr\n"
-#define PTE_HEADER_DELIMITER    "---------------- ---------------- "\
-                                "---------------- -------\n"
-#else
-#define PTE_HEADER_FIELDS       "vaddr    paddr            size     attr\n"
-#define PTE_HEADER_DELIMITER    "-------- ---------------- -------- -------\n"
-#endif
+#define PTE_HEADER_DELIMITER "----------------"
 
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
 
-static void print_pte_header(MonitorHMP *hmp)
+static void print_pte_header(MonitorHMP *hmp, unsigned print_width)
 {
-    monitor_hmp_printf(hmp, PTE_HEADER_FIELDS);
-    monitor_hmp_printf(hmp, PTE_HEADER_DELIMITER);
+    g_assert(print_width <= 16);
+    monitor_hmp_printf(hmp, "%-*s %-*s %-*s %s\n",
+                       print_width, "vaddr",
+                       16,          "paddr",
+                       print_width, "size",
+                                    "attr");
+    monitor_hmp_printf(hmp, "%.*s %.*s %.*s %.*s\n",
+                       print_width, PTE_HEADER_DELIMITER,
+                       16,          PTE_HEADER_DELIMITER,
+                       print_width, PTE_HEADER_DELIMITER,
+                       7,           PTE_HEADER_DELIMITER);
 }
 
-static void print_pte(MonitorHMP *hmp, int va_bits, target_ulong vaddr,
-                      hwaddr paddr, target_ulong size, int attr)
+static void print_pte(MonitorHMP *hmp, unsigned print_width,
+                      int va_bits, vaddr vaddr,
+                      hwaddr paddr, uint64_t size, int attr)
 {
+    g_assert(print_width <= 16);
     /* sanity check on vaddr */
     if (vaddr >= (1UL << va_bits)) {
         return;
@@ -72,10 +74,11 @@ static void print_pte(MonitorHMP *hmp, int va_bits, target_ulong vaddr,
         return;
     }
 
-    monitor_hmp_printf(hmp, TARGET_FMT_lx " " HWADDR_FMT_plx " " TARGET_FMT_lx
+    monitor_hmp_printf(hmp, "%0*" VADDR_PRIx " " HWADDR_FMT_plx " %0*" PRIx64
                        " %c%c%c%c%c%c%c\n",
-                       addr_canonical(va_bits, vaddr),
-                       paddr, size,
+                       print_width, addr_canonical(va_bits, vaddr),
+                       paddr,
+                       print_width, size,
                        attr & PTE_R ? 'r' : '-',
                        attr & PTE_W ? 'w' : '-',
                        attr & PTE_X ? 'x' : '-',
@@ -85,18 +88,18 @@ static void print_pte(MonitorHMP *hmp, int va_bits, target_ulong vaddr,
                        attr & PTE_D ? 'd' : '-');
 }
 
-static void walk_pte(MonitorHMP *hmp, AddressSpace *as,
-                     hwaddr base, target_ulong start,
+static void walk_pte(MonitorHMP *hmp, int print_width,
+                     AddressSpace *as, hwaddr base, uint64_t start,
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
@@ -129,7 +132,7 @@ static void walk_pte(MonitorHMP *hmp, AddressSpace *as,
                 if ((*last_attr != attr) ||
                     (*last_paddr + *last_size != paddr) ||
                     (last_start + *last_size != start)) {
-                    print_pte(hmp, va_bits, *vbase, *pbase,
+                    print_pte(hmp, print_width, va_bits, *vbase, *pbase,
                               *last_paddr + *last_size - *pbase, *last_attr);
 
                     *vbase = start;
@@ -142,8 +145,8 @@ static void walk_pte(MonitorHMP *hmp, AddressSpace *as,
                 *last_size = pgsize;
             } else {
                 /* pointer to the next level of the page table */
-                walk_pte(hmp, as, paddr, start, level - 1, ptidxbits, ptesize,
-                         va_bits, vbase, pbase, last_paddr,
+                walk_pte(hmp, print_width, as, paddr, start, level - 1,
+                         ptidxbits, ptesize, va_bits, vbase, pbase, last_paddr,
                          last_size, last_attr);
             }
         }
@@ -156,15 +159,17 @@ static void walk_pte(MonitorHMP *hmp, AddressSpace *as,
 static void mem_info_svxx(MonitorHMP *hmp, CPUArchState *env)
 {
     AddressSpace *as = env_cpu(env)->as;
+    bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;
+    int print_width = (rv32) ? 8 : 16;
     int levels, ptidxbits, ptesize, vm, va_bits;
     hwaddr base;
-    target_ulong vbase;
+    vaddr vbase;
     hwaddr pbase;
     hwaddr last_paddr;
-    target_ulong last_size;
+    uint64_t last_size;
     int last_attr;
 
-    if (riscv_cpu_mxl(env) == MXL_RV32) {
+    if (rv32) {
         base = (hwaddr)get_field(env->satp, SATP32_PPN) << PGSHIFT;
         vm = get_field(env->satp, SATP32_MODE);
     } else {
@@ -201,7 +206,7 @@ static void mem_info_svxx(MonitorHMP *hmp, CPUArchState *env)
     va_bits = PGSHIFT + levels * ptidxbits;
 
     /* print header */
-    print_pte_header(hmp);
+    print_pte_header(hmp, print_width);
 
     vbase = -1;
     pbase = -1;
@@ -210,11 +215,12 @@ static void mem_info_svxx(MonitorHMP *hmp, CPUArchState *env)
     last_attr = 0;
 
     /* walk page tables, starting from address 0 */
-    walk_pte(hmp, as, base, 0, levels - 1, ptidxbits, ptesize, va_bits,
+    walk_pte(hmp, print_width,
+             as, base, 0, levels - 1, ptidxbits, ptesize, va_bits,
              &vbase, &pbase, &last_paddr, &last_size, &last_attr);
 
     /* don't forget the last one */
-    print_pte(hmp, va_bits, vbase, pbase,
+    print_pte(hmp, print_width, va_bits, vbase, pbase,
               last_paddr + last_size - pbase, last_attr);
 }
 
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


