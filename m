Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F01C5DF86
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:43:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNqN-0002vd-KK; Tue, 18 Aug 2026 13:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wwNqE-0002ub-T0
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:43:15 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wwNq7-0007yk-TH
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:43:09 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-66807ba2f0fso312532d50.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787074986; x=1787679786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FD6Ur+eg4ui02rsiunbrWHJ0I/7Mgp+cJLNtmLWUAGs=;
 b=IXoy0YGTYsi45pJ++J46BeM0RcKT4fgIdG66obP86Umkl9TomV80qQaehuTp4EJS4C
 N5nZwmXhh4a46JcS+F4XjoFT0rG5j7dsm4qe5b+NILM/2P99FQMckBHuYme12pOeFRyz
 j7ymJ/ay4I4LN3fCwMYIpymniS+PpM+vKwCpxhB45sTL7Rj23V4sI13njej5CLkVkG6t
 ftHJmD5C/abKDhysAWGowXwbBY4zsd415UszTp4cqi41a3xmfBHbdcioe2JTNb3nLoaE
 gLb2fjwenO5XBb4erMQYDkTeCQclFIyHrqdl6cDUwWY9ohrIf1hQBq5p2YNvcBiiWKxf
 W5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787074986; x=1787679786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FD6Ur+eg4ui02rsiunbrWHJ0I/7Mgp+cJLNtmLWUAGs=;
 b=mCK1f38CQNVEyvmpGiPynIYdUjAIclzft9lxAClb8E+B+nzSJKT6p7uV+8GS5fOIN4
 +Ke6EZBJzmh1yAzMeJlac3mm+mKrcFeQy/n/WTmId/mCs7gPzPJ26B9vBb7X3gI68Zpx
 MUZjSS1TcpMLXBjyNKeDkph064Bkp7Z6niZxFMzut+8Jjym2nz3jt2s5fZu5YZNxwxik
 Qulzz7vjifjl3A15nPkpuwxZhXFVa/tzKT1lmQVb/nuw8o3GUzhuBTXbpAopqmo0bUw+
 QcU8RbI0nBgf//oPDXgZ0t9a3/Gg6qupxJub9NyegQ4t5XR/eGIZl3oJpqEQUd2khIGC
 AqAA==
X-Gm-Message-State: AOJu0YwCYwTEtpwfP9JEkTvBPFUErJShJ7+7jAqxK9cUmB2WfewwkuZR
 X2v3x8eSis2fLac78xdNw1cN/qaynJUuBsWrYkgHNNXnenYLS9SDD4+cQwK07w==
X-Gm-Gg: AR+sD10QA5xYfviv+xGQMOaH6O64YczuOE3f/2AKw3Pexy7iVBKVb3FF+nnt0henvgE
 9jJRKXbeXaOwOXxfE64doC+RCSodVhRND+dX1n/pZEgdxHhVFNmXsrcCGYieXK+wbSWlPfkE9LW
 JwqG1YRGNxVJVU7Xky9IIDCxZaWlxhEEHzIO+ftRvCmBHM63zC1H7pgJ/5TBXFPPCWTfc+/b2qD
 pV86EafJ3WZmXaVwX6+gk9YLZyuzQqhOfKzFFbCKgJ5Dwz2aN59YvOMD3RHWXHrL08sC6aE6X2t
 cwihjWVpCQr/Hwvk+27wLrqP2S8ajV5l9c2F/Iyt0Y9nV5vZoffkTg4BiZIxJkMXHI3yFMLDjbZ
 L0IiaUL3kAu/Y0YmKv7Aepq+TxJId75F/rAudEio36CjcH+0yq8t/JOeud8+QYSSOh0gwVE6sVg
 WShgfUO3JicMabTXvXNWv/3iD4j4YdYEYGi6ileoqfRw7916PEPROGzdW58WY9
X-Received: by 2002:a05:690e:1441:b0:66b:2fe9:cd2 with SMTP id
 956f58d0204a3-66c72d2a100mr12487608d50.41.1787074986470; 
 Tue, 18 Aug 2026 10:43:06 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66cb47c8cc5sm2682003d50.18.2026.08.18.10.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:43:05 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@mailo.com,
 zhao1.liu@intel.com, laurent@vivier.eu, deller@gmx.de,
 pierrick.bouvier@oss.qualcomm.com, Matt Turner <mattst88@gmail.com>
Subject: [PATCH 5/8] RFC: accel/tcg: allow cross-page goto_tb chaining in
 user-only builds
Date: Tue, 18 Aug 2026 13:42:44 -0400
Message-ID: <20260818174247.649526-6-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260818174247.649526-1-mattst88@gmail.com>
References: <20260818174247.649526-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=mattst88@gmail.com; helo=mail-yx1-xb12d.google.com
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

Add tests/tcg/alpha/test-xpage-chain.c to cover the hazard directly. It
places a direct branch near the end of one page targeting the next page,
runs it 200000 times so the chain is established, then checks that
mprotect(PROT_NONE) makes the next call fault, and that remapping the page
with different code runs the new code rather than a stale translation.

The test detects the hazard it is meant to detect: with the
tb_invalidate_phys_range() call in page_set_flags() commented out, it fails
both phases, executing page B after PROT_NONE and returning the stale
result.

Measured with qemu-alpha running an emulated alpha gcc 16.2.0 compiling the
SQLite 3.45.1 amalgamation on an x86-64 host, LTO build, on top of the
preceding patches:

    before: 890,713,633,237 instructions
    after:  869,178,598,378 instructions   -2.42%

    before: 84.44s wall clock
    after:  80.49s wall clock              -4.68%

Note that this is worth more in time than in instructions, the reverse of
the preceding patch: a chained jump replaces a cache probe whose loads can
miss, so the instructions it removes are more expensive than average.

Measured before the inline jump cache probe, when a missed chain cost a
helper call rather than an inline probe, the same change was worth -7.9%.

RFC because this reverses a deliberate decision and the reasoning above
wants review from someone who knows the invalidation paths better than I
do.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 accel/tcg/translator.c             |  12 +++-
 tests/tcg/alpha/Makefile.target    |   2 +-
 tests/tcg/alpha/test-xpage-chain.c | 111 +++++++++++++++++++++++++++++
 3 files changed, 123 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/alpha/test-xpage-chain.c

diff --git ./accel/tcg/translator.c ./accel/tcg/translator.c
index 85bb21e911..3eab9f570d 100644
--- ./accel/tcg/translator.c
+++ ./accel/tcg/translator.c
@@ -108,6 +108,17 @@ static void gen_tb_end(const TranslationBlock *tb, uint32_t cflags,
 
 bool translator_is_same_page(const DisasContextBase *db, vaddr addr)
 {
+    /*
+     * In user-only mode there are no page tables.  Every mmap, mprotect and
+     * munmap goes through page_set_flags(), which calls
+     * tb_invalidate_phys_range() whenever the flags actually change, and
+     * tb_phys_invalidate() unlinks incoming jumps.  A cross-page link is
+     * therefore broken whenever the destination page's permissions change,
+     * so the same-page restriction is not needed.
+     */
+    if (IS_ENABLED(CONFIG_USER_ONLY)) {
+        return true;
+    }
     return ((addr ^ db->pc_first) & TARGET_PAGE_MASK) == 0;
 }
 
@@ -118,7 +129,6 @@ bool translator_use_goto_tb(DisasContextBase *db, vaddr dest)
         return false;
     }
 
-    /* Check for the dest on the same page as the start of the TB.  */
     return translator_is_same_page(db, dest);
 }
 
diff --git ./tests/tcg/alpha/Makefile.target ./tests/tcg/alpha/Makefile.target
index 36d8ed1eae..eee986bab6 100644
--- ./tests/tcg/alpha/Makefile.target
+++ ./tests/tcg/alpha/Makefile.target
@@ -5,7 +5,7 @@
 ALPHA_SRC=$(SRC_PATH)/tests/tcg/alpha
 VPATH+=$(ALPHA_SRC)
 
-ALPHA_TESTS=hello-alpha test-cond test-cmov test-ovf test-cvttq
+ALPHA_TESTS=hello-alpha test-cond test-cmov test-ovf test-cvttq test-xpage-chain
 TESTS+=$(ALPHA_TESTS)
 
 test-cmov: EXTRA_CFLAGS=-DTEST_CMOV
diff --git ./tests/tcg/alpha/test-xpage-chain.c ./tests/tcg/alpha/test-xpage-chain.c
new file mode 100644
index 0000000000..7916d544af
--- /dev/null
+++ ./tests/tcg/alpha/test-xpage-chain.c
@@ -0,0 +1,111 @@
+/*
+ * Cross-page TB chaining hazard test.
+ *
+ * Phase 1: a direct branch (br) near the end of page A targets page B.
+ *          Run it enough times that QEMU chains TB_A -> TB_B.
+ * Phase 2: mprotect page B away. Re-running must fault.
+ * Phase 3: remap page B with different code. Re-running must execute the
+ *          NEW code, not a stale chained translation of the old code.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
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
+int main(void)
+{
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


