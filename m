Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B498C5DF98
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 19:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxr58-0004A0-L6; Sat, 22 Aug 2026 15:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wxr57-00048o-2J
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 15:08:41 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wxr54-0005m7-Dr
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 15:08:40 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-81f36179d72so35163097b3.2
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 12:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787425717; x=1788030517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QCeGKvgZvzLRmULF1kf11XJuTp71B39WYQckVmi9p4Y=;
 b=gXE4DdpqNKaPdRhdglhKQ14xJdEbxl39iy5hWDPaTVwVCTI//ED0IxW87rXbxWQ7/z
 DSSO+eR+GyjDOrAdOz70cc69dgdHeeIkEjpThGh8gYndn+6WvXhsm/HbGvx/je1DQQSa
 KW0sA5NaAka4uvafKuVZt7aM5tWqURqjikBRbCInjwE+/iWrKrB4mF3t/hZEwVEJAriM
 kVPL6r/8mFkLif5IpTKOtnGfBeTZqGl/3depLqLhk3lIDlC14jn9mgCnIRh+gFoMfZYE
 Uk19SD4X4lYBHRate4L6qg9NmJgV8oFEXpyHf9YGtsiu3djLgUXI5X1LuUXgCuoDMNer
 h8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787425717; x=1788030517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QCeGKvgZvzLRmULF1kf11XJuTp71B39WYQckVmi9p4Y=;
 b=HEblkvOoyCiuA2xJn3CB/ODD2fvLf0NWzccMamr/1FUayH+/AMRLqe38K2niKliFsW
 +LKmuqItP9qIXUERNbmNCwtthLeWEQs9WGY/C3BHucdrxzw10JWo4mVRNnxQvzg20Ztc
 VfZaOCKIrrgMR6Zn77O7ZK967OB+VwoZ5qd67GU7u5l6k6iTpdkr4lXiOZn1O6Ju/g7K
 kjcAWQmt+ID43TL7neNVn2K3x/sz/zbRHbXD9yRd0CybLZ/pAJeQ3ZCohZp2J2qaQcFT
 FyekLZL9lLDrhekThVR0n+t3E/rP7LlQPFhHbX1N2jxVa2TNv2zCov17Ijqqc1obo+Sc
 hvlQ==
X-Gm-Message-State: AFuF++nK2l9BrMhUvmzCxIakNq/frfATXxq1yW7WqaBCxLSdfkhz/lt3
 kybholWX7bW1rEcsZCQcqaK07XWvH56fveYlO7S2sFy64iQYxyLw/7K80/LCd+swsCg=
X-Gm-Gg: AR+sD13oC8mtfL46jaDI0DBbkimjn+HDENRFHCYrArha7e7xnW4P+1Aav5P4r5Td7bL
 bTiTENbcUhs9tU1HmWP8P0OqbDtgiRVw3sYn0kBBb5in3WIOj0AGG6nVWTIyV8IlPfhf0ax0woR
 Iv5gcqaRKFmRJuVanOIjeq6AP5Bujbf+VVW2AVk07qB0wJnmm6cEEo22xsmYNJ9SANszDF5fG2R
 pyg+HwkYY2gSPxxkVtr2GJrda9+r7Pr0SU8fYN/dZNs/L7GHSPknlKDwX+pZT6DpzTQi7SW1XN/
 qhs9v/FV5MGXWjzx4HfWN+jaDhPSbJx5NYlCM9WvfdyaD4WHvn1YcWLhpibrm/SFr8U4MEfAsnX
 zQEfpF2prm22jf9hv+J2yI3krcUK5CrbGz65eNCWipO4J9tcc9rJqSKqdlA8LkSN8RAQd2bTihr
 jPH0+S1kCoYAKZW4lTe2qjQUMifM2h8mMUVKoRv/5n8A+qz7dBRoTSdGbIorArHY7uHKPbDgWy3
 yQy/xD4QRFtNH5JdADrbhkpPSXAHI5ygVql9cyP
X-Received: by 2002:a05:690c:dc4:b0:80e:38c5:bc17 with SMTP id
 00721157ae682-84c9366089emr25466277b3.7.1787425717172; 
 Sat, 22 Aug 2026 12:08:37 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-84ca5187583sm13931197b3.4.2026.08.22.12.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 12:08:35 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@oss.qualcomm.com,
 alex.bennee@linaro.org, zhao1.liu@intel.com,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH v3 5/7] RFC: accel/tcg: allow cross-page goto_tb chaining in
 user-only builds
Date: Sat, 22 Aug 2026 15:08:16 -0400
Message-ID: <20260822190818.1829249-6-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260822190818.1829249-1-mattst88@gmail.com>
References: <20260822190818.1829249-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x112e.google.com
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

translator_use_goto_tb() refuses to chain unless the destination is on the
same page as the start of the TB. For guests whose text is much larger than
a page this is expensive: an emulated alpha gcc compiling a 255k line
translation unit takes the indirect dispatch path for 8.4 billion of its
34.2 billion TB exits, and a large share of those are ordinary direct
branches that simply crossed an 8 KiB page boundary.

The restriction was made unconditional by d3a2a1d803 ("accel/tcg:
Introduce translator_use_goto_tb"), whose rationale was:

    Various targets avoid the page crossing test for CONFIG_USER_ONLY,
    but that is wrong: mmap and mprotect can change page permissions.

That is true, but in user-only builds the invalidation path already covers
it. There are no page tables: every mmap, mprotect and munmap reaches
page_set_flags(), which calls tb_invalidate_phys_range() whenever the flags
actually change, and tb_phys_invalidate() calls tb_jmp_unlink() to reset
incoming jumps. A chained cross-page jump is therefore broken whenever the
destination page's permissions change. This is not true in system mode,
where TBs are keyed by physical address and a page table change invalidates
nothing, so the restriction is kept there.

The rule protects one more thing, which the original rationale does not
mention: it guarantees that execution cannot enter a page without a TB
lookup, and so without check_for_breakpoints(). That is what makes a
breakpoint set after a block was translated take effect, since insertion
deliberately invalidates nothing. A link established before the breakpoint
was set would jump straight over it.

So the chaining is only enabled for a run that can never acquire a
breakpoint. In user-only mode every breakpoint comes from gdb -- BP_CPU is
g_assert_not_reached() there, and the guest cannot ask for one -- and gdb
has to be requested with -g before the first block is translated, even
though with suspend=n it may connect later. gdb_may_set_breakpoints()
reports whether it was, and is fixed for the lifetime of the process.

Add tests/tcg/alpha/test-xpage-chain.c to cover both hazards directly. It
places a direct branch near the end of one page targeting the next page,
runs it 200000 times so the chain is established, then checks that
mprotect(PROT_NONE) makes the next call fault, and that remapping the page
with different code runs the new code rather than a stale translation.

The test detects the hazard it is meant to detect: with the
tb_invalidate_phys_range() call in page_set_flags() commented out, it fails
both phases, executing page B after PROT_NONE and returning the stale
result.

Run with -b, the same binary stops once the chain is established and lets
tests/tcg/alpha/gdbstub/xpage-bp.py set a breakpoint on the far side of it,
which the next call has to stop on. With gdb_may_set_breakpoints() forced to
false so that the chaining stays on under gdb, that breakpoint is missed and
the test fails, which is what makes it a test of the gate rather than of
gdb.

Measured with qemu-alpha running an emulated alpha gcc 16.2.0 compiling the
SQLite 3.45.1 amalgamation on an x86-64 host, LTO build, on top of the
preceding patches:

    before: 916,415,123,244 instructions
    after:  891,254,240,071 instructions   -2.75%

    before: 85.59s wall clock
    after:  81.45s wall clock              -4.84%

Note that this is worth more in time than in instructions, the reverse of
the preceding patch: a chained jump replaces a cache probe whose loads can
miss, so the instructions it removes are more expensive than average.

Measured before the inline jump cache probe, when a missed chain cost a
helper call rather than an inline probe, the same change was worth -7.9%.

RFC because this reverses a deliberate decision and the reasoning above
wants review from someone who knows the invalidation paths better than I
do.

v3: Only take the shortcut when no gdbstub was requested. The same-page
    rule also forces a lookup, and so a breakpoint check, on entry to every
    page; without that, a chain established before a breakpoint was set runs
    past it. Reported by Richard Henderson.

v3: Change translator_use_goto_tb() rather than translator_is_same_page().
    i386, riscv and s390x call translator_is_same_page() for something else
    -- enforcing that only a single-insn TB may cross a page -- and v2
    changed their TB boundaries in user-only mode as a side effect. alpha
    does not call it, so the numbers above are unaffected.

v3: Add the gdbstub half of the test.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 accel/tcg/translator.c              |  33 ++++++-
 gdbstub/user.c                      |  14 +++
 include/gdbstub/user.h              |  11 +++
 tests/tcg/alpha/Makefile.target     |  17 +++-
 tests/tcg/alpha/gdbstub/xpage-bp.py |  34 +++++++
 tests/tcg/alpha/test-xpage-chain.c  | 144 ++++++++++++++++++++++++++++
 6 files changed, 251 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/alpha/gdbstub/xpage-bp.py
 create mode 100644 tests/tcg/alpha/test-xpage-chain.c

diff --git ./accel/tcg/translator.c ./accel/tcg/translator.c
index 6c8fcd7a20..8879cd626f 100644
--- ./accel/tcg/translator.c
+++ ./accel/tcg/translator.c
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
diff --git ./gdbstub/user.c ./gdbstub/user.c
index 9e6f9a6f37..d810f0f38c 100644
--- ./gdbstub/user.c
+++ ./gdbstub/user.c
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
diff --git ./include/gdbstub/user.h ./include/gdbstub/user.h
index 654986d483..c091cd9758 100644
--- ./include/gdbstub/user.h
+++ ./include/gdbstub/user.h
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
diff --git ./tests/tcg/alpha/Makefile.target ./tests/tcg/alpha/Makefile.target
index 36d8ed1eae..1a3f541bec 100644
--- ./tests/tcg/alpha/Makefile.target
+++ ./tests/tcg/alpha/Makefile.target
@@ -5,7 +5,7 @@
 ALPHA_SRC=$(SRC_PATH)/tests/tcg/alpha
 VPATH+=$(ALPHA_SRC)
 
-ALPHA_TESTS=hello-alpha test-cond test-cmov test-ovf test-cvttq
+ALPHA_TESTS=hello-alpha test-cond test-cmov test-ovf test-cvttq test-xpage-chain
 TESTS+=$(ALPHA_TESTS)
 
 test-cmov: EXTRA_CFLAGS=-DTEST_CMOV
@@ -16,3 +16,18 @@ test-cmov: test-cond.c
 test-plugin-mem-access: CFLAGS+=-mbwx
 
 run-test-cmov: test-cmov
+
+ifneq ($(GDB),)
+GDB_SCRIPT=$(SRC_PATH)/tests/guest-debug/run-test.py
+
+# The chaining this exercises is only enabled when no gdbstub was requested,
+# so what is under test here is that requesting one turns it back off.
+run-gdbstub-xpage-bp: test-xpage-chain
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(GDB) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin "$< -b" --test $(ALPHA_SRC)/gdbstub/xpage-bp.py, \
+	breakpoint behind an established cross-page chain)
+
+EXTRA_RUNS += run-gdbstub-xpage-bp
+endif
diff --git ./tests/tcg/alpha/gdbstub/xpage-bp.py ./tests/tcg/alpha/gdbstub/xpage-bp.py
new file mode 100644
index 0000000000..f0ec14cdec
--- /dev/null
+++ ./tests/tcg/alpha/gdbstub/xpage-bp.py
@@ -0,0 +1,34 @@
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
diff --git ./tests/tcg/alpha/test-xpage-chain.c ./tests/tcg/alpha/test-xpage-chain.c
new file mode 100644
index 0000000000..23b916ffe1
--- /dev/null
+++ ./tests/tcg/alpha/test-xpage-chain.c
@@ -0,0 +1,144 @@
+/*
+ * Cross-page TB chaining hazard test.
+ *
+ * Phase 1: a direct branch (br) near the end of page A targets page B.
+ *          Run it enough times that QEMU chains TB_A -> TB_B.
+ * Phase 2: mprotect page B away. Re-running must fault.
+ * Phase 3: remap page B with different code. Re-running must execute the
+ *          NEW code, not a stale chained translation of the old code.
+ *
+ * With -b, phases 2 and 3 are replaced by a stop at break_here(), where the
+ * gdbstub test sets a breakpoint on page B -- after the chain exists -- and
+ * checks that re-running the chain still stops on it.  See
+ * tests/tcg/alpha/gdbstub/xpage-bp.py.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <setjmp.h>
+#include <signal.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+#define PS 8192
+
+static sigjmp_buf jb;
+/*
+ * Written by the SIGSEGV handler and read by main(), so it must not be
+ * cached in a register across the faulting call.
+ */
+static volatile sig_atomic_t caught;
+
+/* Where the branch lands, for the gdbstub test to set a breakpoint on. */
+unsigned int *page_b_entry;
+
+/* Somewhere for the gdbstub test to stop once the chain is established. */
+void __attribute__((noinline)) break_here(void)
+{
+    asm volatile ("");
+}
+
+static void segv(int sig)
+{
+    caught = 1;
+    siglongjmp(jb, 1);
+}
+
+/* lda $0, imm($31)  -> v0 = imm */
+static unsigned int lda_v0(int imm)
+{
+    return 0x201F0000u | (unsigned short)imm;
+}
+
+int main(int argc, char **argv)
+{
+    bool bp_mode = argc > 1 && strcmp(argv[1], "-b") == 0;
+    struct sigaction sa;
+    int rc = 0;
+    unsigned char *m = mmap(NULL, 2 * PS, PROT_READ | PROT_WRITE | PROT_EXEC,
+                            MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    if (m == MAP_FAILED) {
+        perror("mmap");
+        return 2;
+    }
+
+    unsigned char *pa = m, *pb = m + PS;
+    unsigned int *entry = (unsigned int *)(pa + PS - 64);
+    unsigned int *tgt = (unsigned int *)(pb + 16);
+
+    page_b_entry = tgt;
+
+    entry[0] = lda_v0(1);
+    long disp = ((long)tgt - ((long)&entry[1] + 4)) / 4;
+    entry[1] = 0xC3E00000u | (unsigned int)(disp & 0x1FFFFF);  /* br $31,tgt */
+    tgt[0] = 0x6BFA8001u;                                      /* ret        */
+    __builtin___clear_cache((char *)m, (char *)m + 2 * PS);
+
+    long (*fn)(void) = (long (*)(void))entry;
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
+    if (mprotect(pb, PS, PROT_NONE) != 0) {
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
+    /* Phase 3: remap with different code, expect the new code to run. */
+    if (mprotect(pb, PS, PROT_READ | PROT_WRITE | PROT_EXEC) != 0) {
+        perror("mprotect back");
+        return 2;
+    }
+    tgt[0] = lda_v0(2);
+    tgt[1] = 0x6BFA8001u;
+    __builtin___clear_cache((char *)pb, (char *)pb + PS);
+
+    long r = fn();
+    if (r != 2) {
+        printf("FAIL: phase 3 returned %ld, expected 2 (stale chain)\n", r);
+        rc = 1;
+    } else {
+        printf("phase 3 ok (new code ran)\n");
+    }
+    return rc;
+}
-- 
2.54.0


