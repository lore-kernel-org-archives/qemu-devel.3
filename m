Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1935C982E8
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 22:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7KGY-0001pb-BC; Thu, 17 Sep 2026 18:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7KGP-0001oh-AC
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 18:07:29 -0400
Received: from mail-pz2-x1d.google.com ([2607:f8b0:4864:3b::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7KGM-0006HB-3F
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 18:07:29 -0400
Received: by mail-pz2-x1d.google.com with SMTP id
 41be03b00d2f7-cc1cebad4aeso15799a12.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 15:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789682844; x=1790287644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9mNCAIqDOepKwDLnim2xcE5EzzCaL66TpsgNkeIyCS4=;
 b=dnh9RUktTUytuGItI9fNcOkzuvDn5C3AHrDB5+MdH4h42JDgXzjTOdTLLZxESl6WkY
 aQizdANAi0Y/y3G8ThTsFGlZHFSl681dlScuuh5kT/xNqbr5ymkjNyXyr6ka/cr2YUj5
 p0RFdj1/veetYK90ZPdNtRAJxkzYDuSHesLZNsdyrkaJ8HVHcfsVTn100jl19HAiJ+Hh
 ppcc1j/BqZxIs8WfyMuTYChFxttiRN0ZyxyG8PUhc4vdtPIgY9MzXOs+BfhbRpF7Nhze
 ERGuGm9CDwQ5mn92r5gHchXVER4d6V35kjd9ufOK/+Lt6MpWQKLu4IT07XLXqr8VJI9r
 nPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789682844; x=1790287644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9mNCAIqDOepKwDLnim2xcE5EzzCaL66TpsgNkeIyCS4=;
 b=LbjIcnSrEsZFD9WdFxW2+TpOc4+yXAnLCyujOW+rG30VFaF2L0/6/45FlaOIv4HQnu
 n9W1GOmUBXm4S1dOKOlLgS3CVKcWFH/iRvQ9weBXTFXx5Hy8Fm2pgDp4ei9Of762OMxe
 9nquV9EtfmR7H6WTTgx9FQgJlifh16BIHqyy1LJYpKOTqyqR/GjWSN2W0rAKDG77lP67
 LVP3ISOKA/my0k0v2TlGoaiu6f3F0gwiq3o8vX8Ehtg+p9bVsRRq63QkAf/nEOqnzoyk
 jVFDpnJsysmyNJ5gh927S9dSn1CV204AGvAgXDQiOIRpBmQPSY4gEZ5zs1GSfLNEq1Hc
 oMKw==
X-Gm-Message-State: AFuF++kTcxqu7BWnVlW/oYBO5Pz49bOS20cOzu7lIVrezhS74NoiBhxa
 IL2DPvWYArmIx8m0dyAf2iYuw+gKxYAiwN5Coh8cozoQMr1jKIM5kFi0plGh2SysEvJKtFBGoNq
 e+ZKCwgM=
X-Gm-Gg: AYBFou0AKtmYQSjqnc0IdnFh1rvR+aWawWxvHZtFif6n7lHOXVvlpLbrGuyy8iHwv9V
 DCllkDuAXUrj0ka3i6UbjLgRwS2MXVC/ithQG4VWgStMrsstJpuf6vs4p8yl8xD/6WdBaUYEUTW
 Uvu/83SNM1pwjr1USEYUD7EnHgr1vpapPyS5lXzsrtCT9k3Kp3t7oHVbL8VSAKx0ovTnqOoQRNx
 tQMNV8DDuOfIIIB4JdBgkxO4ktCtdjV+rf98N/YM0YfXc6R+OlJfKMzDXiGoSte6Nh3nmPoFkXv
 /D/mqfPaCl650nr49hWp6ynMeRVC2kXHGj6BGcy7a5EskEx6oaExnbqWMCz3EZAa5OLAIBuKlbJ
 S0K2oQZkfES0483PKMmYJCDCP2KPQ9U/dHFUt8FIepF+WRXmQrHF+v6mu0VVeCwFee9EHSTY8g5
 GkyL65Ci3gsQ7YzY8HcWoyonHXHZv1PoX7317Nxqezl22sAFO9Uisv8oYmGmQfL5csUmDiKkv1h
 jXI/D+/
X-Received: by 2002:a05:6a20:6a0b:b0:3dd:85a8:4c64 with SMTP id
 adf61e73a8af0-3dd8c5dbaa5mr597625637.43.1789682844311; 
 Thu, 17 Sep 2026 15:07:24 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:5a4b:653b:1dce:569f])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d3a31asm14558131c88.9.2026.09.17.15.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 15:07:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 2/2] accel/tcg: Allow cross-page goto_tb chaining in
 user-only builds
Date: Thu, 17 Sep 2026 12:07:18 -1000
Message-ID: <20260917220718.60899-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917220718.60899-1-richard.henderson@linaro.org>
References: <20260917220718.60899-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::1d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x1d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Matt Turner <mattst88@gmail.com>

translator_use_goto_tb() refuses to chain unless the destination is on the
same page as the start of the TB.  For guests whose text is much larger than
a page this is expensive: an emulated alpha gcc compiling a 255k line
translation unit takes the indirect dispatch path for 8.4 billion of its
34.2 billion TB exits, and a large share of those are ordinary direct
branches that simply crossed an 8 KiB page boundary.

The restriction was made unconditional by d3a2a1d803 ("accel/tcg:
Introduce translator_use_goto_tb"), whose rationale was:

    Various targets avoid the page crossing test for CONFIG_USER_ONLY,
    but that is wrong: mmap and mprotect can change page permissions.

That is true, but in user-only builds the invalidation path already covers
it.  There are no page tables: every mmap, mprotect and munmap reaches
page_set_flags(), which calls tb_invalidate_phys_range() whenever the flags
actually change, and tb_phys_invalidate() calls tb_jmp_unlink() to reset
incoming jumps.  A chained cross-page jump is therefore broken whenever the
destination page's permissions change. This is not true in system mode,
where TBs are keyed by physical address and a page table change invalidates
nothing, so the restriction is kept there.

The rule protects one more thing, which the original rationale does not
mention: it guarantees that execution cannot enter a page without a TB
lookup, and so without check_for_breakpoints().  That is what makes a
breakpoint set after a block was translated take effect, since insertion
deliberately invalidates nothing. A link established before the breakpoint
was set would jump straight over it.

So the chaining is only enabled for a run that can never acquire a
breakpoint. In user-only mode every breakpoint comes from gdb -- BP_CPU is
g_assert_not_reached() there, and the guest cannot ask for one -- and gdb
has to be requested with -g before the first block is translated, even
though with suspend=n it may connect later. gdb_may_set_breakpoints()
reports whether it was, and is fixed for the lifetime of the process.

Add tests/tcg/multiarch/test-xpage-chain.c to cover both hazards directly.
It writes the last instruction of one page and the first of the next, so
that the fall-through between them is a cross-page goto_tb, runs it 200000
times so the chain is established, then checks that mprotect(PROT_NONE)
makes the next call fault, and that different code written into the page
once it is mapped back runs rather than a stale translation.

The two instructions -- set the return value register, and return -- are
all the architecture specific code there is; thirteen architectures supply
them and the rest skip.

The test detects the hazard it is meant to detect: with the
tb_invalidate_phys_range() call in page_set_flags() commented out,
it fails both phases, executing page B after PROT_NONE and returning
the stale result.

Run with -b, the same binary stops once the chain is established and
lets tests/tcg/multiarch/gdbstub/xpage-bp.py set a breakpoint on the
far side of it, which the next call has to stop on.
With gdb_may_set_breakpoints() forced to false so that the chaining
stays on under gdb, that breakpoint is missed and the test fails,
which is what makes it a test of the gate rather than of gdb.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
[rth: Update for meson test infrastructure]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260901034808.3524945-8-mattst88@gmail.com>
---
 include/gdbstub/user.h                  |  11 +
 accel/tcg/translator.c                  |  33 ++-
 gdbstub/user.c                          |  14 +
 tests/tcg/multiarch/test-xpage-chain.c  | 336 ++++++++++++++++++++++++
 tests/tcg/multiarch/gdbstub/xpage-bp.py |  37 +++
 tests/tcg/multiarch/meson.build         |   6 +
 6 files changed, 436 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/multiarch/test-xpage-chain.c
 create mode 100644 tests/tcg/multiarch/gdbstub/xpage-bp.py

diff --git a/include/gdbstub/user.h b/include/gdbstub/user.h
index 654986d483b..c091cd97586 100644
--- a/include/gdbstub/user.h
+++ b/include/gdbstub/user.h
@@ -11,6 +11,17 @@
 
 #define MAX_SIGINFO_LENGTH 128
 
+/**
+ * gdb_may_set_breakpoints() - whether a breakpoint can ever be inserted
+ *
+ * In user-only mode every breakpoint comes from gdb, and gdb is only ever
+ * reachable if -g was given at startup, before the guest ran a single
+ * instruction.  A run that has no gdbstub can therefore never acquire a
+ * breakpoint, which lets translation take shortcuts that a breakpoint
+ * would invalidate.  Stays true once true, even if gdb detaches.
+ */
+bool gdb_may_set_breakpoints(void);
+
 /**
  * gdb_handlesig() - yield control to gdb
  * @cpu: CPU
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index e9943006947..7d1caf56553 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -15,6 +15,9 @@
 #include "accel/tcg/cpu-mmu-index.h"
 #include "exec/target_page.h"
 #include "exec/translator.h"
+#ifdef CONFIG_USER_ONLY
+#include "gdbstub/user.h"
+#endif
 #include "exec/plugin-gen.h"
 #include "tcg/tcg-op-common.h"
 #include "internal-common.h"
@@ -110,6 +113,34 @@ bool translator_is_same_page(const DisasContextBase *db, vaddr addr)
     return ((addr ^ db->pc_first) & TARGET_PAGE_MASK) == 0;
 }
 
+/*
+ * Whether a direct jump may be chained to a destination outside the page
+ * the TB started in.
+ *
+ * In user-only mode there are no page tables.  Every mmap, mprotect and
+ * munmap goes through page_set_flags(), which calls tb_invalidate_phys_range()
+ * whenever the flags actually change, and tb_phys_invalidate() unlinks
+ * incoming jumps.  A cross-page link is therefore broken whenever the
+ * destination page's permissions change.
+ *
+ * What the same-page rule also provides is that execution cannot enter a page
+ * without a TB lookup, and so without check_for_breakpoints(), which is what
+ * makes a breakpoint set after a block was translated take effect.  Nothing
+ * invalidates on breakpoint insertion, so a link established beforehand would
+ * jump straight over it.  In user-only mode breakpoints only ever come from
+ * gdb -- BP_CPU is g_assert_not_reached() there and the guest has no way to
+ * ask for one -- and gdb has to be requested with -g before the first block
+ * is translated, so a run that has no gdbstub can never acquire a breakpoint.
+ */
+static bool use_cross_page_goto_tb(void)
+{
+#ifdef CONFIG_USER_ONLY
+    return !gdb_may_set_breakpoints();
+#else
+    return false;
+#endif
+}
+
 bool translator_use_goto_tb(DisasContextBase *db, vaddr dest)
 {
     /* Suppress goto_tb if requested. */
@@ -118,7 +149,7 @@ bool translator_use_goto_tb(DisasContextBase *db, vaddr dest)
     }
 
     /* Check for the dest on the same page as the start of the TB.  */
-    return translator_is_same_page(db, dest);
+    return use_cross_page_goto_tb() || translator_is_same_page(db, dest);
 }
 
 void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 9e6f9a6f376..d810f0f38c3 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -470,6 +470,18 @@ static void *gdbserver_accept_thread(void *arg)
 
 #define USAGE "\nUsage: -g {port|path}[,suspend={y|n}]"
 
+/*
+ * Set before the guest runs and never cleared, so that code translated at
+ * any point can rely on it: with suspend=n gdb may connect long after
+ * startup, and once connected it can insert a breakpoint at any time.
+ */
+static bool gdbserver_requested;
+
+bool gdb_may_set_breakpoints(void)
+{
+    return gdbserver_requested;
+}
+
 bool gdbserver_start(const char *args, Error **errp)
 {
     g_auto(GStrv) argv = g_strsplit(args, ",", 0);
@@ -513,6 +525,8 @@ bool gdbserver_start(const char *args, Error **errp)
         return false;
     }
 
+    gdbserver_requested = true;
+
     if (suspend) {
         if (gdbserver_accept(port, gdb_fd, port_or_path)) {
             gdb_handlesig(first_cpu, 0, NULL, NULL, 0);
diff --git a/tests/tcg/multiarch/test-xpage-chain.c b/tests/tcg/multiarch/test-xpage-chain.c
new file mode 100644
index 00000000000..a4e34149e72
--- /dev/null
+++ b/tests/tcg/multiarch/test-xpage-chain.c
@@ -0,0 +1,336 @@
+/*
+ * Cross-page TB chaining hazard test.
+ *
+ * Two adjacent pages of hand-written code.  The last instruction of page A
+ * sets the return value and falls through into page B, which returns; a TB
+ * always ends at a page boundary, so page A reaches page B through a
+ * cross-page goto_tb.
+ *
+ * Phase 1: run it enough times that QEMU chains TB_A -> TB_B.
+ * Phase 2: mprotect page B away. Re-running must fault.
+ * Phase 3: map it back and write different code into it. Re-running must
+ *          execute the NEW code, not a stale chained translation.
+ *
+ * With -b, phases 2 and 3 are replaced by a stop at break_here(), where the
+ * gdbstub test sets a breakpoint on page B -- after the chain exists -- and
+ * checks that re-running the chain still stops on it.  See
+ * tests/tcg/multiarch/gdbstub/xpage-bp.py.
+ *
+ * The code the two pages hold is architecture specific, so each
+ * architecture supplies two emitters:
+ *
+ *   emit_set_ret(p, val) - set the integer return value register to val
+ *   emit_ret(p)          - return to the caller
+ *
+ * both writing at @p and returning the number of bytes written.  Neither
+ * may contain a branch: the fall-through from page A into page B is the
+ * whole point, and a delay slot must not straddle the boundary.  An
+ * architecture that supplies neither skips the test.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <setjmp.h>
+#include <signal.h>
+#include <stdint.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+static inline size_t put32(void *p, uint32_t insn)
+{
+    memcpy(p, &insn, sizeof(insn));
+    return sizeof(insn);
+}
+
+static inline size_t put16(void *p, uint16_t insn)
+{
+    memcpy(p, &insn, sizeof(insn));
+    return sizeof(insn);
+}
+
+#if defined(__aarch64__)
+#define HAVE_EMITTERS
+/* movz w0, #val */
+static size_t emit_set_ret(void *p, int val)
+{
+    return put32(p, 0x52800000u | ((uint32_t)val << 5));
+}
+static size_t emit_ret(void *p)
+{
+    return put32(p, 0xd65f03c0u);                       /* ret */
+}
+#elif defined(__alpha__)
+#define HAVE_EMITTERS
+/* lda $0, val($31) */
+static size_t emit_set_ret(void *p, int val)
+{
+    return put32(p, 0x201f0000u | (uint16_t)val);
+}
+static size_t emit_ret(void *p)
+{
+    return put32(p, 0x6bfa8001u);                       /* ret */
+}
+#elif defined(__arm__)
+#define HAVE_EMITTERS
+/* mov r0, #val */
+static size_t emit_set_ret(void *p, int val)
+{
+    return put32(p, 0xe3a00000u | (uint8_t)val);
+}
+static size_t emit_ret(void *p)
+{
+    return put32(p, 0xe12fff1eu);                       /* bx lr */
+}
+#elif defined(__hppa__)
+#define HAVE_EMITTERS
+/* ldi val, %ret0 */
+static size_t emit_set_ret(void *p, int val)
+{
+    return put32(p, 0x341c0000u | ((uint32_t)val << 1));
+}
+static size_t emit_ret(void *p)
+{
+    size_t n = put32(p, 0xe840c000u);                   /* bv %r0(%rp) */
+    return n + put32((char *)p + n, 0x08000240u);       /* nop (delay slot) */
+}
+#elif defined(__i386__) || defined(__x86_64__)
+#define HAVE_EMITTERS
+/* mov $val, %eax */
+static size_t emit_set_ret(void *p, int val)
+{
+    uint32_t imm = val;
+    *(unsigned char *)p = 0xb8;
+    return 1 + put32((char *)p + 1, imm);
+}
+static size_t emit_ret(void *p)
+{
+    *(unsigned char *)p = 0xc3;                         /* ret */
+    return 1;
+}
+#elif defined(__loongarch64)
+#define HAVE_EMITTERS
+/* ori $a0, $zero, val */
+static size_t emit_set_ret(void *p, int val)
+{
+    return put32(p, 0x03800004u | ((uint32_t)val << 10));
+}
+static size_t emit_ret(void *p)
+{
+    return put32(p, 0x4c000020u);                       /* jr $ra */
+}
+#elif defined(__m68k__)
+#define HAVE_EMITTERS
+/* moveq #val, %d0 */
+static size_t emit_set_ret(void *p, int val)
+{
+    return put16(p, 0x7000u | (uint8_t)val);
+}
+static size_t emit_ret(void *p)
+{
+    return put16(p, 0x4e75u);                           /* rts */
+}
+#elif defined(__mips__)
+#define HAVE_EMITTERS
+/* li $v0, val */
+static size_t emit_set_ret(void *p, int val)
+{
+    return put32(p, 0x24020000u | (uint16_t)val);
+}
+static size_t emit_ret(void *p)
+{
+    size_t n = put32(p, 0x03e00008u);                   /* jr $ra */
+    return n + put32((char *)p + n, 0x00000000u);       /* nop (delay slot) */
+}
+/*
+ * ELFv1 function pointers are descriptors rather than code addresses, so
+ * there is nothing to call the raw code through.
+ */
+#elif defined(__powerpc__) && \
+      (!defined(__powerpc64__) || (defined(_CALL_ELF) && _CALL_ELF == 2))
+#define HAVE_EMITTERS
+/* li r3, val */
+static size_t emit_set_ret(void *p, int val)
+{
+    return put32(p, 0x38600000u | (uint16_t)val);
+}
+static size_t emit_ret(void *p)
+{
+    return put32(p, 0x4e800020u);                       /* blr */
+}
+#elif defined(__riscv)
+#define HAVE_EMITTERS
+/* addi a0, zero, val -- the 4 byte form, never c.li */
+static size_t emit_set_ret(void *p, int val)
+{
+    return put32(p, 0x00000513u | ((uint32_t)val << 20));
+}
+static size_t emit_ret(void *p)
+{
+    return put32(p, 0x00008067u);                       /* jalr zero, 0(ra) */
+}
+#elif defined(__s390x__)
+#define HAVE_EMITTERS
+/* lghi %r2, val */
+static size_t emit_set_ret(void *p, int val)
+{
+    size_t n = put16(p, 0xa729u);
+    return n + put16((char *)p + n, (uint16_t)val);
+}
+static size_t emit_ret(void *p)
+{
+    return put16(p, 0x07feu);                           /* br %r14 */
+}
+#elif defined(__sh__)
+#define HAVE_EMITTERS
+/* mov #val, r0 */
+static size_t emit_set_ret(void *p, int val)
+{
+    return put16(p, 0xe000u | (uint8_t)val);
+}
+static size_t emit_ret(void *p)
+{
+    size_t n = put16(p, 0x000bu);                       /* rts */
+    return n + put16((char *)p + n, 0x0009u);           /* nop (delay slot) */
+}
+#elif defined(__sparc__)
+#define HAVE_EMITTERS
+/* mov val, %o0 */
+static size_t emit_set_ret(void *p, int val)
+{
+    return put32(p, 0x90102000u | (uint32_t)(val & 0x1fff));
+}
+static size_t emit_ret(void *p)
+{
+    size_t n = put32(p, 0x81c3e008u);                   /* retl */
+    return n + put32((char *)p + n, 0x01000000u);       /* nop (delay slot) */
+}
+#endif
+
+/* Where the fall-through lands, for the gdbstub test to breakpoint on. */
+void *page_b_entry;
+
+/* Somewhere for the gdbstub test to stop once the chain is established. */
+void __attribute__((noinline)) break_here(void)
+{
+    asm volatile ("");
+}
+
+#ifdef HAVE_EMITTERS
+static sigjmp_buf jb;
+/*
+ * Written by the SIGSEGV handler and read by main(), so it must not be
+ * cached in a register across the faulting call.
+ */
+static volatile sig_atomic_t caught;
+
+static void segv(int sig)
+{
+    caught = 1;
+    siglongjmp(jb, 1);
+}
+#endif
+
+int main(int argc, char **argv)
+{
+    bool bp_mode = argc > 1 && strcmp(argv[1], "-b") == 0;
+#ifndef HAVE_EMITTERS
+    printf("SKIP: no code emitters for this architecture\n");
+    if (bp_mode) {
+        break_here();
+    }
+    return 0;
+#else
+    unsigned char tmp[16];
+    struct sigaction sa;
+    long (*fn)(void);
+    size_t setlen, n;
+    long ps = sysconf(_SC_PAGESIZE);
+    int rc = 0;
+    unsigned char *m = mmap(NULL, 2 * ps, PROT_READ | PROT_WRITE | PROT_EXEC,
+                            MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    if (m == MAP_FAILED) {
+        perror("mmap");
+        return 2;
+    }
+
+    unsigned char *pb = m + ps;
+
+    /*
+     * Page A ends with the store to the return value register, so that the
+     * next instruction executed is the first one on page B.
+     */
+    setlen = emit_set_ret(tmp, 1);
+    memcpy(pb - setlen, tmp, setlen);
+    emit_ret(pb);
+    __builtin___clear_cache((char *)m, (char *)m + 2 * ps);
+
+    page_b_entry = pb;
+    fn = (long (*)(void))(pb - setlen);
+
+    for (int i = 0; i < 200000; i++) {
+        if (fn() != 1) {
+            printf("FAIL: phase 1 wrong result\n");
+            return 1;
+        }
+    }
+    printf("phase 1 ok (chained)\n");
+
+    if (bp_mode) {
+        /*
+         * The chain from page A to page B now exists.  gdb puts a breakpoint
+         * on page_b_entry here; the call below has to stop on it rather than
+         * jump over it.
+         */
+        break_here();
+        if (fn() != 1) {
+            printf("FAIL: bp phase wrong result\n");
+            return 1;
+        }
+        printf("bp phase ok\n");
+        return 0;
+    }
+
+    memset(&sa, 0, sizeof(sa));
+    sa.sa_handler = segv;
+    sigemptyset(&sa.sa_mask);
+    if (sigaction(SIGSEGV, &sa, NULL) != 0) {
+        perror("sigaction");
+        return 2;
+    }
+    if (mprotect(pb, ps, PROT_NONE) != 0) {
+        perror("mprotect");
+        return 2;
+    }
+    if (sigsetjmp(jb, 1) == 0) {
+        fn();
+        printf("FAIL: phase 2 executed page B after mprotect(PROT_NONE)\n");
+        rc = 1;
+    } else if (!caught) {
+        printf("FAIL: phase 2 longjmp without entering the handler\n");
+        rc = 1;
+    } else {
+        printf("phase 2 ok (faulted)\n");
+    }
+
+    /* Phase 3: map back, overwrite, expect the new code to run. */
+    if (mprotect(pb, ps, PROT_READ | PROT_WRITE | PROT_EXEC) != 0) {
+        perror("mprotect back");
+        return 2;
+    }
+    n = emit_set_ret(pb, 2);
+    emit_ret(pb + n);
+    __builtin___clear_cache((char *)pb, (char *)pb + ps);
+
+    long r = fn();
+    if (r != 2) {
+        printf("FAIL: phase 3 returned %ld, expected 2 (stale chain)\n", r);
+        rc = 1;
+    } else {
+        printf("phase 3 ok (new code ran)\n");
+    }
+    return rc;
+#endif
+}
diff --git a/tests/tcg/multiarch/gdbstub/xpage-bp.py b/tests/tcg/multiarch/gdbstub/xpage-bp.py
new file mode 100644
index 00000000000..f40024f16de
--- /dev/null
+++ b/tests/tcg/multiarch/gdbstub/xpage-bp.py
@@ -0,0 +1,37 @@
+"""Test that a breakpoint set after a cross-page chain is established is hit.
+
+translator_use_goto_tb() lets a direct branch chain to another page in
+user-only builds, which is only safe because a run with no gdbstub can never
+acquire a breakpoint.  This runs with one, so the chaining must be off and
+the breakpoint must still be reached.
+
+This runs as a sourced script (via -x, via run-test.py).
+
+SPDX-License-Identifier: GPL-2.0-or-later
+"""
+from test_gdbstub import main, report
+
+
+def run_test():
+    """Run through the tests one by one"""
+    gdb.Breakpoint("break_here")
+    gdb.execute("continue")
+
+    # The chain exists by now; put a breakpoint on the far side of it.
+    target = int(gdb.parse_and_eval("(unsigned long)page_b_entry"))
+    if target == 0:
+        report(True, "no code emitters for this architecture, skipped")
+        return
+    gdb.execute("break *{}".format(target))
+    gdb.execute("continue")
+
+    pc = int(gdb.parse_and_eval("(unsigned long)$pc"))
+    report(pc == target, "stopped at {:#x}, expected {:#x}".format(pc, target))
+
+    gdb.execute("delete")
+    gdb.execute("continue")
+    exitcode = int(gdb.parse_and_eval("$_exitcode"))
+    report(exitcode == 0, "{} == 0".format(exitcode))
+
+
+main(run_test)
diff --git a/tests/tcg/multiarch/meson.build b/tests/tcg/multiarch/meson.build
index 508fdb585b7..6e68d75fb20 100644
--- a/tests/tcg/multiarch/meson.build
+++ b/tests/tcg/multiarch/meson.build
@@ -118,6 +118,12 @@ tests += {
     'gdb_test': ['--test', files('gdbstub/follow-fork-mode-parent.py')],
   },
 }
+tests += {
+  multiarch/'test-xpage-chain.c': {
+    'test_name': 'xpage-chain',
+    'gdb_test': ['--test', files('gdbstub/xpage-bp.py'), '--pargs=-b'],
+  },
+}
 
 # Specific plugin tests
 # Test plugin memory access instrumentation
-- 
2.53.0


