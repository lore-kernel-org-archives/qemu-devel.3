Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289ECC61DE4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 03:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1FUn-0000g4-Mp; Mon, 31 Aug 2026 23:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x1FUc-0000cx-Ki
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 23:49:04 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x1FUZ-0004MB-2e
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 23:49:02 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-8200b55dc47so40814327b3.3
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 20:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788234538; x=1788839338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GTyVp0vlfc04HWA2atZi7IJalMnDmcZPoaeKa+M3cjU=;
 b=JqnoARXK3tCv/uKcoHuX/492ZqF7WpaNOjDEYR55U/BeDri1hW8HmXUQFTTbuHSv8X
 qpL3pdCOG96+EYgVZpzu0LBK6x9tIl/psPGorbLfEv8U9qMmhcLpzwfEZ+uU44Fa4D4g
 bt5xPgUSTYjSf4yALhOx9xohdRKlZXWBC7D8wE779Yeq2ThPqXYX2EEAcwI5R7SCcRPs
 w6ZU8IHqiTkgk2Q0OD5OHW3Mj0MTi/cbYf+VzpfIbKTN7GRiRW1sKzCwdyaZYz6BJoOA
 GB7o5IN6ucqiGndr2f9A8v3Nl+gmlc6Cq9r3SM2kmuTsYX8ZIyd2VRlV5quSKvLhA6DB
 IATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788234538; x=1788839338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GTyVp0vlfc04HWA2atZi7IJalMnDmcZPoaeKa+M3cjU=;
 b=DL1HFeuQNmX2lQ6EalVrb0g8rJFuY+MByccYZ0Ul56wQbE/MVgR78y4MuU/smFPBAZ
 Yay5pPA4kypkb04KmQ3D0LczvXY6OTFaSh+B6wDWhK4o3HQLMy/JJOoXmOf7OYIyqwFi
 mdClz6LbxDJn2TdQq6HTRSqz8XShm6+KlOsin1AkI2iGULiB7KdiuwvvyRnOJzzzf0g+
 Z1exHsQ1DteuvasNfbVfVBg3B/DaNVYhqWpJYihv5sL82iTWYC62ppnxLiNT9PiSIUTj
 XzqIOtFsRE4jIbkaXNJ7PZJ+KxkjS18LyRf75YOYpkMpV9ImwGVJ+8V//At82HtDqwIJ
 hOag==
X-Gm-Message-State: AFuF++mHaLUNWwn5CSwMA98Y5+W4eIFHtAnANYd9mwrqUn+5w3YoOY2f
 kuQiDdnwk6TWCVFFT6kIqEd5MTdZXwdYz66JWKdCKr6tk3YwLDP4xdpjpa0J0g==
X-Gm-Gg: AYBFou0lSItuo6HKPgB1ZQpnuOq7hW84uvuV344hg/zAKBxYB8nnL+kVIQ3b78vVyNL
 cGG5Q0ZUa3z3mQY0FnMhAzmrMsexmjeAVpz/arFfBbaG4A6p00BfMlRU0E+MZSVMbgpNKXDO9rF
 SrkSWNlH8KjfjlmYQFw7JfeD6N7ooG2mEe9fOPd1M2m6dnwGENWiLJFADiGBFNbFoAgkgfYWH2D
 XKI2J8Jkq+3gTDO0lQBNVj3RNYeywD/UUzh/K9DQgU6ONxxiLkPBllPBvptAiLfr9rvJP9rfTNB
 sscyIHWonPfrpJefJVAlwFQV6HvqODzjZx/Fp8kvtccz+xvW3J/omSIt3vmVqKJRSryxFPRjWGE
 cDPmu9jw3IBkqNlPwiGrhbDtdkjBFwLd6KkTVz6bF9SMlOJf8QBv/e1FRuH01WjTMRRTujhfB44
 xQEZx2YGAe7cOSSbGYDQtbWoZoelbi+lbdJtlE0M6e52B/2VtciV5PPWyKT0L8wA6DyUDuixFwQ
 0y+qTYuR0UpTzuim5OLKW7eHBhqsdYPtB4mpaWa
X-Received: by 2002:a05:690c:660b:b0:856:b8a6:5e79 with SMTP id
 00721157ae682-85d6ec1c18amr108548797b3.23.1788234537695; 
 Mon, 31 Aug 2026 20:48:57 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-85e5ed1dc88sm66934857b3.19.2026.08.31.20.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 20:48:56 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@oss.qualcomm.com,
 alex.bennee@linaro.org, zhao1.liu@intel.com,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH v5 7/9] RFC: accel/tcg: allow cross-page goto_tb chaining in
 user-only builds
Date: Mon, 31 Aug 2026 23:48:06 -0400
Message-ID: <20260901034808.3524945-8-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260901034808.3524945-1-mattst88@gmail.com>
References: <20260827050241.3713332-1-mattst88@gmail.com>
 <20260901034808.3524945-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x1134.google.com
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
tb_invalidate_phys_range() call in page_set_flags() commented out, it fails
both phases, executing page B after PROT_NONE and returning the stale
result.

Run with -b, the same binary stops once the chain is established and lets
tests/tcg/multiarch/gdbstub/xpage-bp.py set a breakpoint on the far side of it,
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

v4: Move the test to tests/tcg/multiarch so that every *-user target runs
    it, rather than only alpha. Requested by Alex Bennee. The direct branch
    is gone with it: a fall-through off the end of a page is a cross-page
    goto_tb just the same, and needs no per-architecture branch encoding or
    displacement arithmetic, only "set the return value" and "return".
    Built and run under qemu-user on aarch64, alpha, arm, hppa,
    loongarch64, m68k, mips, ppc, ppc64le, riscv64, s390x, sh4, sparc64
    and x86_64; ppc64 ELFv1 skips, because a function pointer there is a
    descriptor rather than a code address.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 accel/tcg/translator.c                  |  33 ++-
 gdbstub/user.c                          |  14 +
 include/gdbstub/user.h                  |  11 +
 tests/tcg/multiarch/Makefile.target     |  12 +-
 tests/tcg/multiarch/gdbstub/xpage-bp.py |  37 +++
 tests/tcg/multiarch/test-xpage-chain.c  | 336 ++++++++++++++++++++++++
 6 files changed, 441 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/multiarch/gdbstub/xpage-bp.py
 create mode 100644 tests/tcg/multiarch/test-xpage-chain.c

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
diff --git ./tests/tcg/multiarch/Makefile.target ./tests/tcg/multiarch/Makefile.target
index ab4bf9c5d5..f8a91fed2c 100644
--- ./tests/tcg/multiarch/Makefile.target
+++ ./tests/tcg/multiarch/Makefile.target
@@ -143,6 +143,15 @@ run-gdbstub-follow-fork-mode-parent: follow-fork-mode
 		--bin $< --test $(MULTIARCH_SRC)/gdbstub/follow-fork-mode-parent.py, \
 	following parents on fork)
 
+# The chaining this exercises is only enabled when no gdbstub was requested,
+# so what is under test here is that requesting one turns it back off.
+run-gdbstub-xpage-bp: test-xpage-chain
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(GDB) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin "$< -b" --test $(MULTIARCH_SRC)/gdbstub/xpage-bp.py, \
+	breakpoint behind an established cross-page chain)
+
 run-gdbstub-late-attach: late-attach
 	$(call run-test, $@, env LATE_ATTACH_PY=1 $(GDB_SCRIPT) \
 		--gdb $(GDB) \
@@ -159,7 +168,8 @@ EXTRA_RUNS += run-gdbstub-sha1 run-gdbstub-qxfer-auxv-read \
 	      run-gdbstub-registers run-gdbstub-prot-none \
 	      run-gdbstub-catch-syscalls run-gdbstub-follow-fork-mode-child \
 	      run-gdbstub-follow-fork-mode-parent \
-	      run-gdbstub-qxfer-siginfo-read run-gdbstub-late-attach
+	      run-gdbstub-qxfer-siginfo-read run-gdbstub-late-attach \
+	      run-gdbstub-xpage-bp
 
 # ARM Compatible Semi Hosting Tests
 #
diff --git ./tests/tcg/multiarch/gdbstub/xpage-bp.py ./tests/tcg/multiarch/gdbstub/xpage-bp.py
new file mode 100644
index 0000000000..f40024f16d
--- /dev/null
+++ ./tests/tcg/multiarch/gdbstub/xpage-bp.py
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
diff --git ./tests/tcg/multiarch/test-xpage-chain.c ./tests/tcg/multiarch/test-xpage-chain.c
new file mode 100644
index 0000000000..a4e34149e7
--- /dev/null
+++ ./tests/tcg/multiarch/test-xpage-chain.c
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
-- 
2.54.0


