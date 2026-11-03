Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAD8606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=theorem-dev.20260707.gappssmtp.com header.i=@theorem-dev.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gNSzJNRX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO8yN-00036V-8i; Tue, 03 Nov 2026 02:30:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tewaro@theorem.dev>)
 id 1xO8yL-00034r-4P
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 02:30:21 -0500
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tewaro@theorem.dev>)
 id 1xO8yI-00069K-F8
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 02:30:20 -0500
Received: by mail-dy1-x1335.google.com with SMTP id
 5a478bee46e88-35c76e9614aso5346901eec.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 23:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=theorem-dev.20260707.gappssmtp.com; s=20260707; t=1793691017; x=1794295817;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tdxloZwBKDAgrM5BDk8OY8vLGqrFHrCnnVzbdNEEzCQ=;
 b=gNSzJNRX+rMFG2nsc2kVQPUehvEp8BYWV0BeZzQ54nmqM6vIiOGsBmKuTwjz3nmkAm
 SV3Fza8Mm8nswzLROSknwVDu406V7toJRTL/cqgjPh+SnisUy3+CJRWbgopiuc6Jpcoj
 9LmbiV6J32suUqf5jT4Uhdjub+abGrwoHHk5sBdu3LvPXL0k27uDAemrm/7sGr/bHsFi
 LU36jSG/PWjBDi8b7GcO5UJ8nC9W9Zm9VF88k/GzxqpZsCJDXXv8Q5QhAOiKWya4Px0M
 h4I+L4AnsXE/Db66my1/oIOGuXtTjTk2/YFRqWMO3FtKIFcKdgnLApzrH9U8dsPL9KAo
 13EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793691017; x=1794295817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tdxloZwBKDAgrM5BDk8OY8vLGqrFHrCnnVzbdNEEzCQ=;
 b=KLb27lZz4nZ2QhNhzHosJW8i0fOOjLPryPCQELIwuqZg8opaUyml4GdKNEICzwbH2G
 iUIjtaEVKjwUEUeC3sonBs1fmLlEntNTH4jOqMgWliDw91Vo3UHMApzacMU1p8jISpRG
 fIAuaMhNcTOyxRiSjSifAGmHLj0SBjRACtQ0/KPGrk1SvIaK+lJZ4ULRhKrsM6yrv6Zb
 gOFxD9b60JvUZpqsn6P0HsPMCRQt7ZGt/G+lNK3M9MN1+3A795ntcnEnG6mWni/aE7YT
 uZzwi9HsRzgOmiw4cS/UQj7IJ+X6VJUmawWFembu+KWLR2Ljzza2ZEXI+6pEh3S5HPE5
 8j9w==
X-Gm-Message-State: APuU4Z/fL9oO8AfiZpNUnbsMPkSpa4nlDnH5KYlw9KWkitEgbSX9CSvm
 OrcO9bBqdUQIEp++M5pbTNu1+VpGNMHihTXCJAx8GbqAuHv4pi8rx62PjGiz/sneWLWaZa1LQ+Z
 sR1WA2X2iPA==
X-Gm-Gg: AYBFou33uLUhnSbahno+XGJSq9j2ES7wNjh2JK3TAWQi26wzkEYxY2+evvIyA3q73lQ
 3+b3m7eExwUoz3DMm2jugKyyzd9UMRF1YICjSjNQl3eTeaq3m2LUQIfDv4eDJjzBWEyry4pSWZY
 mK1a3jlHP6zGu+FvJGYmOX3eYyVJ/ZsXW32/Gb+QkCsZr8VwJy0V+SlOiBfopSyItIBZKWEeFVo
 FiSHuPV0hC1rV0ofZkIcMIkC8u72N3ciX2rt5ngFU4of2vkle2uDuHCwLsUIFxTCXBtBCGVBIri
 S6MGqAO4H2sz3tgXEOm+lcjxcjssjP9r+A26wErFv6WhH5gGOplURdTJVKdNYspoDeVUiSPRdFw
 gS+D0pd6yklVxz4jHcVot2MpQu+1Gw4iV/l/ck4xZzmJ6hLRNo7N/d/voJTN4SFCXq9JkxY70Lt
 Hg+1/+3cpm1t9Y73xujrxBjsbQYYLloBWELmPUf1oYfKQcKn1zn5JxpoNnIbbndo49JG6QRCs22
 sKjpVgNZkJY2kgt/a/4IyUCCz+4tEI7EMFlJkUFUzfGLWuYd2C6RHM1BUSPtXReCmpqYha4puqS
 UwhDmeDmOtvsavYD+AeD8zxElc/13FRbUxo33aFCg0d+XcS1dNIWbD1oFrz//ztPgAqFIQo=
X-Received: by 2002:a05:7301:4545:b0:36c:9ac2:475b with SMTP id
 5a478bee46e88-36c9ac25267mr244778eec.0.1793691016380; 
 Mon, 02 Nov 2026 23:30:16 -0800 (PST)
Received: from tewaros-MacBook-Pro.local
 ([2601:647:6300:1230:9da3:3d82:7292:c937])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42935b4asm59114352eec.16.2026.11.02.23.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 23:30:15 -0800 (PST)
From: tewaro <tewaro@theorem.dev>
To: qemu-devel@nongnu.org
Cc: disclosures@theorem.dev, tewaro <tewaro@tewaro.org>, imaginos32@gmail.com,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH 2/2] tests/tcg/riscv64: test faults on implicit VS-stage
 page-table accesses
Date: Mon,  2 Nov 2026 23:29:53 -0800
Message-ID: <32390ac8968372d34e299974d20db5fe25bbe2f1.1793677944.git.tewaro@theorem.dev>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1793677944.git.tewaro@theorem.dev>
References: <20260705140508.17692-1-imaginos32@gmail.com>
 <cover.1793677944.git.tewaro@theorem.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1335;
 envelope-from=tewaro@theorem.dev; helo=mail-dy1-x1335.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When a guest accesses memory, the hardware walks the guest's page tables.
The guest reads the entries and, with Svadu, writes the A/D bits. The
G-stage checks these reads and writes like any other guest access. If it
refuses one, the guest-page fault reports:

- cause: the type of the guest's original access
- mtval2/htval: the guest-physical address of the entry, >> 2
- mtinst/htinst: 0x3000 if the walk was reading, 0x3020 if writing

test-gstage-tinst checks 19 cases:

  case          access  from  G-stage refuses  reports
  ------------  ------  ----  ---------------  -----------------
  load          ld      VS    A write          load GPF, 0x3020
  fetch         jr      VS    A write          fetch GPF, 0x3020
  store         sd      VS    D write          store GPF, 0x3020
  store-ad      sd      VS    A/D write        store GPF, 0x3020
  amo           amoadd  VS    D write          store GPF, 0x3020
  load-4k       ld      VS    A write          load GPF, 0x3020
  load-1g       ld      VS    A write          load GPF, 0x3020
  load-vu       ld      VU    A write          load GPF, 0x3020
  hlv           hlv.d   HS    A write          load GPF, 0x3020
  hsv           hsv.d   HS    D write          store GPF, 0x3020
  load-hs       ld      VS    A write          load GPF, 0x3020
  store-hs      sd      VS    D write          store GPF, 0x3020
  hlv-noread    hlv.d   HS    root PTE read    load GPF, 0x3000
  hsv-noread    hsv.d   HS    root PTE read    store GPF, 0x3000
  fetch-noread  fetch   VS    root PTE read    fetch GPF, 0x3000
  noadue-h      ld      VS    -                load PF
  noadue-m      ld      VS    -                load PF
  noadue-store  sd      VS    -                store PF
  control       sd      VS    the store        store GPF

- Leaves are 2 MiB, except in load-4k and load-1g.
- Faults trap to M-mode, except in load-hs and store-hs.
- The noadue cases turn ADUE off, so nothing is written and the fault
  is an ordinary page fault.
- In control the guest itself stores into its read-only tables. That
  is not a walk, so tinst must be neither 0x3000 nor 0x3020.

Booting, the page tables and entering the guest are in hyp-guest.h and
hyp-guest.S, for reuse by other hypervisor tests. The trap handlers,
which make the checks, are in the test.

Each case is its own test, built with the -D flags listed in
meson.build, and exits with 0 or the number of the first check that
failed. Happy to test in a different way if that is desired.

Signed-off-by: tewaro <tewaro@theorem.dev>
---
 tests/tcg/riscv64/hyp-guest.S         | 110 +++++++++++++++++++++
 tests/tcg/riscv64/hyp-guest.h         |  71 ++++++++++++++
 tests/tcg/riscv64/system/meson.build  |  77 +++++++++++++++
 tests/tcg/riscv64/test-gstage-tinst.S | 135 ++++++++++++++++++++++++++
 4 files changed, 393 insertions(+)
 create mode 100644 tests/tcg/riscv64/hyp-guest.S
 create mode 100644 tests/tcg/riscv64/hyp-guest.h
 create mode 100644 tests/tcg/riscv64/test-gstage-tinst.S

diff --git a/tests/tcg/riscv64/hyp-guest.S b/tests/tcg/riscv64/hyp-guest.S
new file mode 100644
index 0000000000..31dc37810c
--- /dev/null
+++ b/tests/tcg/riscv64/hyp-guest.S
@@ -0,0 +1,110 @@
+/*
+ * Routines for the riscv64 hypervisor-extension system tests targeting
+ * page-table translations between the host and guest.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "hyp-guest.h"
+
+#define FLUSH fence rw, rw; sfence.vma; hfence.vvma; hfence.gvma; fence.i
+
+        .option norvc
+        .text
+        .global _start, set_tables_perm, run_guest, exit
+_start:
+        lla     sp, stack_top
+        lla     t0, trap
+        csrw    mtvec, t0
+        lla     t0, hs_trap
+        csrw    stvec, t0
+        li      t0, -1                  /* no PMP restrictions */
+        csrw    pmpaddr0, t0
+        li      t0, 0x1f
+        csrw    pmpcfg0, t0
+        li      t0, ADUE                /* hardware A/D updating */
+        csrw    menvcfg, t0
+        csrw    henvcfg, t0
+        li      t0, 0x100               /* hstatus.SPVP: hlv/hsv act as VS */
+        csrs    hstatus, t0
+
+        /* G-stage: regions 0-24, 1:1, all accessible */
+        li      t0, G_ROOT + 2 * 8
+        li      t1, table(G_L1)
+        sd      t1, 0(t0)
+        li      t0, G_L1
+        li      t1, leaf(REGION(0), G_RW)
+        li      t2, 0x200000 >> 2
+        li      t3, 25
+1:      sd      t1, 0(t0)
+        add     t1, t1, t2
+        addi    t0, t0, 8
+        addi    t3, t3, -1
+        bnez    t3, 1b
+
+        /* guest: the code, the code again for VU, the 4 KiB table */
+        li      t0, VS_ROOT + 2 * 8
+        li      t1, table(VS_L1)
+        sd      t1, 0(t0)
+        li      t0, VS_L1
+        li      t1, leaf(REGION(0), G_RW & ~PTE_U)
+        sd      t1, 0(t0)
+        li      t1, leaf(REGION(0), G_RO & ~PTE_W)
+        sd      t1, 24 * 8(t0)
+        li      t1, table(VS_L0)
+        sd      t1, 8 * 8(t0)
+
+        li      t0, (8 << 60) | (G_ROOT >> 12)
+        csrw    hgatp, t0
+        li      t0, (8 << 60) | (VS_ROOT >> 12)
+        csrw    vsatp, t0
+        FLUSH
+
+        call    test
+        li      a0, 1                   /* test returned: no trap */
+
+/* exit through semihosting with status a0 */
+exit:
+        lla     a1, semiargs
+        li      t0, 0x20026             /* ADP_Stopped_ApplicationExit */
+        sd      t0, 0(a1)
+        sd      a0, 8(a1)
+        li      a0, 0x20                /* SYS_EXIT_EXTENDED */
+        .balign 16
+        slli    zero, zero, 0x1f
+        ebreak
+        srai    zero, zero, 0x7
+1:      j       1b
+
+set_tables_perm:
+        li      t0, leaf(REGION(2), 0)
+        or      t1, a0, t0
+        li      t0, G_L1 + 2 * 8
+        sd      t1, 0(t0)
+        FLUSH
+        ret
+
+/* mret into the mode: mstatus.MPV = 1 for a guest, MPP = S or U */
+run_guest:
+        li      t0, (3 << 11) | (1 << 39)
+        csrc    mstatus, t0
+        li      t0, HS
+        beq     a2, t0, 2f
+        li      t0, 1 << 39             /* MPV: a guest mode */
+        csrs    mstatus, t0
+        li      t0, VU
+        bne     a2, t0, 2f
+        li      t0, REGION(24) - REGION(0)      /* VU: the user copy */
+        add     a1, a1, t0
+        j       3f
+2:      li      t0, 1 << 11             /* MPP = S */
+        csrs    mstatus, t0
+3:      csrw    mepc, a1
+        mret
+
+        .data
+        .balign 8
+semiargs:       .dword 0, 0
+        .bss
+        .balign 16
+        .space  4096
+stack_top:
diff --git a/tests/tcg/riscv64/hyp-guest.h b/tests/tcg/riscv64/hyp-guest.h
new file mode 100644
index 0000000000..20ecef70a5
--- /dev/null
+++ b/tests/tcg/riscv64/hyp-guest.h
@@ -0,0 +1,71 @@
+/*
+ * Shared definitions for the riscv64 hypervisor-extension system tests,
+ * whose routines are in hyp-guest.S. hyp-guest.S:
+ *
+ * 1. Boots the machine in M-mode, sets up the stack and tells the CPU
+ *    which trap handlers to use.
+ * 2. Builds the guest's page tables and the G-stage (host) page tables.
+ * 3. Calls `test`, which starts the test.
+ *
+ * The test file provides:
+ * - test: where the test starts, called by _start after setup
+ * - trap: the M-mode trap handler
+ * - hs_trap: the HS-mode trap handler
+ *
+ * Helpers a test can call:
+ * - set_tables_perm(a0): set what the G-stage lets the guest do to its
+ *   own page tables. a0 is G_RW, G_RO or G_NOREAD.
+ * - run_guest(a0, a1, a2): run the code at address a1 in mode a2 (VS, VU
+ *   or HS), with a0 passed on to it in a0. It does not return: the
+ *   code's trap goes to the test's handler.
+ * - exit(a0): end the test with status a0, 0 for a pass, otherwise the
+ *   number of the check that failed.
+ *
+ * Memory is split into 2 MiB regions; region n starts at
+ * REGION(n) = 0x80000000 + n * 2 MiB. Both stages map each region to
+ * itself.
+ *
+ *   0     code and the G-stage page tables
+ *   1     data and the stack
+ *   2     the guest's page tables
+ *   3-23  free for the test
+ *   24    region 0's code again, user-accessible, for VU-mode
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define PTE_V 0x01
+#define PTE_R 0x02
+#define PTE_W 0x04
+#define PTE_X 0x08
+#define PTE_U 0x10
+#define PTE_A 0x40
+#define PTE_D 0x80
+#define leaf(pa, flags) (((pa) >> 2) | PTE_V | (flags))
+#define table(pa) (((pa) >> 2) | PTE_V)
+
+#define REGION(n) (0x80000000 + (n) * 0x200000)
+#define G_ROOT  0x80104000
+#define G_L1    0x80108000
+#define VS_ROOT 0x80400000
+#define VS_L1   0x80401000
+#define VS_L0   0x80402000      /* 4 KiB table for region 8 */
+
+/* G-stage permission of the guest's tables */
+#define G_RW    (PTE_R | PTE_W | PTE_X | PTE_U | PTE_A | PTE_D)
+#define G_RO    (G_RW & ~PTE_W)
+#define G_NOREAD (G_RO & ~PTE_R)
+
+/* run_guest modes */
+#define VU 0
+#define HS 1
+#define VS 2
+
+#define LOAD_PF 13
+#define STORE_PF 15
+#define FETCH_GPF 20
+#define LOAD_GPF 21
+#define STORE_GPF 23
+#define TINST_READ 0x3000       /* walk was reading a page-table entry */
+#define TINST_WRITE 0x3020      /* walk was writing A/D */
+#define ADUE (1 << 61)
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index 3c8b018d9e..05ed8b4c8f 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -53,6 +53,83 @@ tests += {
   }
 }
 
+hyp_guest = files('../hyp-guest.S')[0]
+
+# test-gstage-tinst.S: one build per case; the flags are documented there
+gstage_tinst = {
+  # the guest's tables are read-only, so the walk's A/D write is refused
+  'load':      ['-DMODE=VS', '-DACCESS=ld t0, 0(a0)', '-DREG=3',
+                '-DFLAGS=PTE_R', '-DCAUSE=LOAD_GPF'],
+  'fetch':     ['-DMODE=VS', '-DACCESS=jr a0', '-DREG=4',
+                '-DFLAGS=(PTE_R|PTE_X)', '-DCAUSE=FETCH_GPF'],
+  'store':     ['-DMODE=VS', '-DACCESS=sd zero, 0(a0)', '-DREG=5',
+                '-DFLAGS=(PTE_R|PTE_W|PTE_A)',
+                '-DCAUSE=STORE_GPF'],
+  'store-ad':  ['-DMODE=VS', '-DACCESS=sd zero, 0(a0)', '-DREG=6',
+                '-DFLAGS=(PTE_R|PTE_W)',
+                '-DCAUSE=STORE_GPF'],
+  'amo':       ['-DMODE=VS', '-DACCESS=amoadd.d t0, zero, (a0)', '-DREG=7',
+                '-DFLAGS=(PTE_R|PTE_W|PTE_A)',
+                '-DCAUSE=STORE_GPF'],
+  'load-4k':   ['-DMODE=VS', '-DACCESS=ld t0, 0(a0)', '-DREG=8',
+                '-DPTE_ADDR=VS_L0', '-DFLAGS=PTE_R',
+                '-DCAUSE=LOAD_GPF'],
+  'load-1g':   ['-DMODE=VS', '-DACCESS=ld t0, 0(a0)',
+                '-DADDR=(0xC0000000+9*0x200000)', '-DPTE_ADDR=(VS_ROOT+3*8)',
+                '-DPTE_PA=REGION(0)', '-DFLAGS=PTE_R',
+                '-DCAUSE=LOAD_GPF'],
+  'load-vu':   ['-DMODE=VU', '-DACCESS=ld t0, 0(a0)', '-DREG=10',
+                '-DFLAGS=(PTE_R|PTE_U)', '-DCAUSE=LOAD_GPF'],
+  'hlv':       ['-DMODE=HS', '-DACCESS=hlv.d t0, (a0)', '-DREG=11',
+                '-DFLAGS=PTE_R', '-DCAUSE=LOAD_GPF'],
+  'hsv':       ['-DMODE=HS', '-DACCESS=hsv.d zero, (a0)', '-DREG=12',
+                '-DFLAGS=(PTE_R|PTE_W|PTE_A)',
+                '-DCAUSE=STORE_GPF'],
+  'load-hs':   ['-DMODE=VS', '-DACCESS=ld t0, 0(a0)', '-DREG=13',
+                '-DFLAGS=PTE_R', '-DCAUSE=LOAD_GPF',
+                '-DTO_HS'],
+  'store-hs':  ['-DMODE=VS', '-DACCESS=sd zero, 0(a0)', '-DREG=14',
+                '-DFLAGS=(PTE_R|PTE_W|PTE_A)',
+                '-DCAUSE=STORE_GPF', '-DTO_HS'],
+  # the tables are unreadable, so the walk fails reading root entry 2
+  'hsv-noread': ['-DMODE=HS', '-DACCESS=hsv.d zero, (a0)', '-DREG=15',
+                 '-DFLAGS=(PTE_R|PTE_W|PTE_A)', '-DPERM=G_NOREAD',
+                 '-DENTRY=(VS_ROOT+2*8)', '-DCAUSE=STORE_GPF',
+                 '-DTINST=TINST_READ'],
+  'hlv-noread': ['-DMODE=HS', '-DACCESS=hlv.d t0, (a0)', '-DREG=16',
+                 '-DFLAGS=(PTE_R|PTE_A)', '-DPERM=G_NOREAD',
+                 '-DENTRY=(VS_ROOT+2*8)', '-DCAUSE=LOAD_GPF',
+                 '-DTINST=TINST_READ'],
+  'fetch-noread': ['-DMODE=VS', '-DREG=17', '-DADDR=probe',
+                   '-DFLAGS=(PTE_R|PTE_X|PTE_A)', '-DPERM=G_NOREAD',
+                   '-DENTRY=(VS_ROOT+2*8)', '-DCAUSE=FETCH_GPF',
+                   '-DTINST=TINST_READ'],
+  # A/D updating off: an ordinary page fault, nothing written
+  'noadue-h':  ['-DMODE=VS', '-DACCESS=ld t0, 0(a0)', '-DREG=21',
+                '-DFLAGS=PTE_R', '-DHENVCFG=0', '-DCAUSE=LOAD_PF',
+                '-DENTRY=0', '-DTINST_NOT_WALK'],
+  'noadue-m':  ['-DMODE=VS', '-DACCESS=ld t0, 0(a0)', '-DREG=22',
+                '-DFLAGS=PTE_R', '-DMENVCFG=0', '-DCAUSE=LOAD_PF',
+                '-DENTRY=0', '-DTINST_NOT_WALK'],
+  'noadue-store': ['-DMODE=VS', '-DACCESS=sd zero, 0(a0)', '-DREG=23',
+                   '-DFLAGS=(PTE_R|PTE_W|PTE_A)', '-DHENVCFG=0',
+                   '-DCAUSE=STORE_PF', '-DENTRY=0', '-DTINST_NOT_WALK'],
+  # control: the guest itself stores into its read-only tables
+  'control':   ['-DMODE=VS', '-DACCESS=sd zero, 0(a0)', '-DREG=2',
+                '-DFLAGS=(PTE_R|PTE_W|PTE_A|PTE_D)', '-DADDR=(VS_ROOT+0x800)',
+                '-DENTRY=(VS_ROOT+0x800)', '-DCAUSE=STORE_GPF',
+                '-DTINST_NOT_WALK'],
+}
+foreach name, flags : gstage_tinst
+  tests += {
+    'test-gstage-tinst.S': {
+      'exe_name': 'test-gstage-tinst-' + name,
+      'cflags': cflags + ['-march=rv64gch', hyp_guest] + flags,
+      'qemu_args': ['-cpu', 'rv64,h=true,svadu=true', qemu_args],
+    }
+  }
+endforeach
+
 tests += {
   'test-vle32ff.S': {
     'cflags': cflags + ['-march=rv64gcv'],
diff --git a/tests/tcg/riscv64/test-gstage-tinst.S b/tests/tcg/riscv64/test-gstage-tinst.S
new file mode 100644
index 0000000000..8c9c7b831f
--- /dev/null
+++ b/tests/tcg/riscv64/test-gstage-tinst.S
@@ -0,0 +1,135 @@
+/*
+ * Test what a fault reports when the G-stage refuses the guest's
+ * page-table walk: its read of a page-table entry, or its write of the
+ * A/D bits.
+ *
+ * Each build is one case, set by -D flags in meson.build:
+ * - MODE: VS, VU or HS (HS runs hlv/hsv on the guest's behalf)
+ * - ACCESS: the instruction run on ADDR
+ * - REG: the region accessed; ADDR defaults to its start
+ * - FLAGS: the guest's page-table entry for ADDR
+ * - PERM: the G-stage permission of the guest's tables (default G_RO)
+ * - TO_HS: take the fault in HS-mode instead of M-mode
+ * - MENVCFG, HENVCFG: turn ADUE off
+ * - PTE_ADDR, PTE_PA: where the entry is and where it points, for the
+ *   4 KiB and 1 GiB cases
+ * - CAUSE, ENTRY, TINST, TINST_NOT_WALK: what the fault must report
+ *
+ * The trap handler checks, and the exit status is the first that fails:
+ *   1  cause  CAUSE
+ *   2  tval   ADDR
+ *   3  tval2  ENTRY >> 2, the entry the walk failed on (default: the
+ *             guest's entry for ADDR)
+ *   4  tinst  TINST: 0x3020 if the walk was writing A/D (default),
+ *             0x3000 if reading; with TINST_NOT_WALK, neither
+ *   5  the entry is unchanged, so the refused A/D write did not happen
+ *
+ * `trap` checks a fault taken in M-mode. `hs_trap` checks one taken in
+ * HS-mode, using scause, stval, htval and htinst.
+ *
+ * Privileged ISA v1.12: 8.5.1, 8.6.3 Table 8.12.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "hyp-guest.h"
+
+/* exit with status n unless reg == want */
+#define CHECK(n, reg, want) li t6, want; li a0, n; bne reg, t6, exit
+
+#ifdef REG
+#ifndef ADDR
+#define ADDR REGION(REG)
+#endif
+#ifndef PTE_ADDR
+#define PTE_ADDR (VS_L1 + (REG) * 8)
+#endif
+#ifndef PTE_PA
+#define PTE_PA REGION(REG)
+#endif
+#endif
+#ifndef ENTRY
+#define ENTRY PTE_ADDR
+#endif
+#ifndef PERM
+#define PERM G_RO
+#endif
+#ifndef TINST
+#define TINST TINST_WRITE
+#endif
+
+        .option norvc
+        .text
+        .global test, trap, hs_trap
+test:
+#ifdef MENVCFG
+        li      t0, MENVCFG             /* A/D updating off */
+        csrw    menvcfg, t0
+#endif
+#ifdef HENVCFG
+        li      t0, HENVCFG
+        csrw    henvcfg, t0
+#endif
+#ifdef TO_HS
+        li      t0, 1 << CAUSE
+        csrw    medeleg, t0
+#endif
+        li      t0, PTE_ADDR            /* the guest's entry for ADDR */
+        li      t1, leaf(PTE_PA, FLAGS)
+        sd      t1, 0(t0)
+#if REG >= 3
+        li      t0, REGION(REG)         /* an ecall for a jump to land on */
+        li      t1, 0x00000073
+        sw      t1, 0(t0)
+#endif
+        li      a0, PERM
+        call    set_tables_perm
+
+        ld      a0, addr
+        lla     a1, probe
+        li      a2, MODE
+        call    run_guest
+
+probe:
+#ifdef ACCESS
+        ACCESS
+#endif
+        ecall
+
+/* the fault, as reported by CSRs cause, tval, tval2 and tinst */
+.macro check_fault cause, tval, tval2, tinst
+        csrr    t5, \cause
+        CHECK(1, t5, CAUSE)
+        csrr    t5, \tval
+        ld      t6, addr
+        li      a0, 2
+        bne     t5, t6, exit
+        csrr    t5, \tval2
+        CHECK(3, t5, (ENTRY) >> 2)
+        csrr    t5, \tinst
+#ifdef TINST_NOT_WALK
+        li      a0, 4
+        li      t6, TINST_READ
+        beq     t5, t6, exit
+        li      t6, TINST_WRITE
+        beq     t5, t6, exit
+#else
+        CHECK(4, t5, TINST)
+#endif
+        li      t0, PTE_ADDR
+        ld      t5, 0(t0)
+        CHECK(5, t5, leaf(PTE_PA, FLAGS))
+        li      a0, 0
+        j       exit
+.endm
+
+        .balign 4
+trap:
+        check_fault mcause, mtval, mtval2, mtinst
+
+        .balign 4
+hs_trap:
+        check_fault scause, stval, htval, htinst
+
+        .data
+        .balign 8
+addr:   .dword ADDR
-- 
2.54.0 (Apple Git-157)


