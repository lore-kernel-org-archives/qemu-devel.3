Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05F0E9A03B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 21:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsSX9-0002jB-KF; Tue, 17 Feb 2026 16:23:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vsSX8-0002ih-4e
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:23:02 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vsSX6-0002K8-Df
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:23:01 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-463901a0accso1266830b6e.2
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 13:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771363379; x=1771968179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m+qNKUAlpp9a6yuJ0J/t49+0Pl4hNg0jUhpv5P0Iy6I=;
 b=Awm91LYKHwTZhAiJP5+znS5JSUctvP9FMEUk+tt4CElkP7298RErM4bW8500HmjO3Q
 jvjQdJCM+SspdarGHHnlvIu/Z2PGcD2kSYaO50zHyVOUfZmVm5e19eLsKoKyMmPEwh9S
 B+kPzYGt2U9eCxzu7LyaiXMzhS9CEsRlFjxjvQAYukZj8CrzNqiXpG9Z4y01reUCO1g0
 6vFaLsskEsPXoEGDi+RhXGA75ULFG7rE+gCbMK/p5tQ/RmDzYueHcnUX9g1yqxwRuv4Y
 xkcLKkSiS5TDLd9tJDO4ysSWeuYHPJxvZ+Id5+ehexmsIqbfy//87Xgus0AH4hzot3Ii
 g23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771363379; x=1771968179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m+qNKUAlpp9a6yuJ0J/t49+0Pl4hNg0jUhpv5P0Iy6I=;
 b=c3NPDqc6/tCt/VbmNy8Ybt8sTqfBtnLFN8IXYLIVxgtxoz786G66esB2cFX0yALcIP
 i9MPhu1Wf/MqM0epnMrOZNw231iZRRrEkhCDBsorE7B+7U1e9bfk/jMl3jW8q8p9bmCD
 GUtzXhDBCoW9Kk1rA4my2Wk6NZ/3DJseqN8JGN3iRCP7qUcz/47+4MqxBjuB1ZzP3pjH
 SiA1AL+VapPyGUAFGXmJJKToZ9oEuG4cxdu1iqA0IUSOw01IxLCOhygDpAJY0FRP+ES+
 +hdgmcxYd6+XtBtU+DLaEQ5cETnSHVYasz61B6SoDuw92AflaXhCy2E+PuZkfPf5V/0B
 kQkA==
X-Gm-Message-State: AOJu0YyqHqwxZdnc4hjE3Uo1J8teAQ20a7pR5kqcw3PC2H+/FdlEmdlI
 9t7iSfLwPr/mKh/kSoHiHwyGppoInf+l3Ueaey5qZE/C5o1vIBOJx/ais97hdw==
X-Gm-Gg: AZuq6aKLNpow9NvHV6sg42Xqw4AhfT+NCZ58Rg3VRyzYZqJ/i9rhkEIsNIgKBp8IZXn
 06j9+ES7gD+qTorPYXhcDjBP0qzKshPdNhabdNMyDOvOjl1D/JQw0gzuIeDk+x1G2q7rFfYF7JB
 9Fwtvl2nMhiwj7cJ4x/w8aI9uRs+GjgcuL6ULH6ssbhNvzUbsSQUZPzijYvS0o7CvVUfyCeeJRX
 5omIc5gKB+3opJpKcIl4TOkuQfWqvU81MPFqIQFyiWqCKzZ6oMykDpXSbsCiN8pa1on0rtYoWr4
 pIs2N5W0kI2J8zI2kSXPFGwXawK+uUl1Zyp+GI/Sth7LkRL6+unEHl68LEIRfY3uQgE2O9dEv3Q
 UZUjMS+f6in+hLsRTX2g4mFPYUpG0g6ABL2RyX5gHSgnfCADEvVHe3ICUvikAEtAhv7gXYjA3jw
 VW/tgCFGvML0oeYuAxg47NNy20rhwOl5edypnKrymYRFKtzGht3z8MJulhmiL58ziZpvf3hl0rj
 vUWJ+fjcVc0h1DIjzYNm6JIkcc=
X-Received: by 2002:a05:6808:1793:b0:45e:fbe0:1bf3 with SMTP id
 5614622812f47-463b409b4a3mr4845137b6e.52.1771363378953; 
 Tue, 17 Feb 2026 13:22:58 -0800 (PST)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4636ae8f86fsm12899319b6e.3.2026.02.17.13.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 13:22:58 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH v3 7/8] tests/tcg/hexagon: Add test for revision-gated
 instruction decoding
Date: Tue, 17 Feb 2026 14:22:44 -0700
Message-ID: <20260217212245.95321-8-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260217212245.95321-1-ltaylorsimpson@gmail.com>
References: <20260217212245.95321-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi1-x229.google.com
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

From: Brian Cain <brian.cain@oss.qualcomm.com>

Add check_rev_gating, a linux-user test that verifies the decoder
rejects instructions from a newer CPU revision than the one selected
by the ELF binary's e_flags.

Co-authored-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Co-authored-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 tests/tcg/hexagon/check_rev_gating.c | 141 +++++++++++++++++++++++++++
 tests/tcg/hexagon/Makefile.target    |   6 ++
 2 files changed, 147 insertions(+)
 create mode 100644 tests/tcg/hexagon/check_rev_gating.c

diff --git a/tests/tcg/hexagon/check_rev_gating.c b/tests/tcg/hexagon/check_rev_gating.c
new file mode 100644
index 0000000000..26b66f5455
--- /dev/null
+++ b/tests/tcg/hexagon/check_rev_gating.c
@@ -0,0 +1,141 @@
+/*
+ * Test that instructions from a newer revision than the running CPU
+ * are rejected with SIGILL.
+ *
+ * Compiled with -mv66 so that e_flags selects CPU v66. The test embeds
+ * a v68 instruction (L2_loadw_aq: "r0 = memw_aq(r0)") via .word
+ * encoding. The revision-gated decoder must reject it, and linux-user
+ * must deliver SIGILL.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <assert.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+static void *resume_pc;
+static int signals_handled;
+static int expected_signals;
+
+static void handle_sigill(int sig, siginfo_t *info, void *puc)
+{
+    ucontext_t *uc = (ucontext_t *)puc;
+
+    if (sig != SIGILL) {
+        _exit(EXIT_FAILURE);
+    }
+
+    uc->uc_mcontext.r0 = SIGILL;
+    uc->uc_mcontext.pc = (unsigned long)resume_pc;
+    signals_handled++;
+}
+
+/*
+ * Try to execute an instruction introduced after v66
+ * On a v66 CPU this must raise SIGILL.
+ *
+ * Since we are building for v66, the assembler will reject
+ * the instructions, so introduce them with .word.
+ */
+#define TRY_FUNC(NAME, WORD) \
+static int try_##NAME(void) \
+{ \
+    int sig; \
+    expected_signals++; \
+    asm volatile( \
+        "r0 = #0\n" \
+        "r1 = ##1f\n" \
+        "memw(%1) = r1\n" \
+        WORD \
+        "1:\n" \
+        "%0 = r0\n" \
+        : "=r"(sig) \
+        : "r"(&resume_pc) \
+        : "r0", "r1", "memory"); \
+    return sig; \
+}
+
+TRY_FUNC(v68_loadw_aq,
+         ".word 0x9200c800    /* { r0 = memw_aq(r0) } */\n")
+TRY_FUNC(v68_loadd_aq,
+         ".word 0x9201d800    /* r1:0 = memd_aq(r1) */\n")
+TRY_FUNC(v68_release_at,
+         ".word 0xa0e0c00c    /* release(r0):at */\n")
+TRY_FUNC(v68_release_st,
+         ".word 0xa0e0c02c    /* release(r0):st */\n")
+TRY_FUNC(v68_storew_rl_at,
+         ".word 0xa0a0c108    /* memw_rl(r0):at = r1 */\n")
+TRY_FUNC(v68_stored_rl_at,
+         ".word 0xa0e2c008    /* memd_rl(r2):at = r1:0 */\n")
+TRY_FUNC(v68_storew_rl_st,
+         ".word 0xa0a0c128    /* memw_rl(r0):st = r1 */\n")
+TRY_FUNC(v68_stored_rl_st,
+         ".word 0xa0e2c028    /* memd_rl(r2):st = r1:0 */\n")
+
+TRY_FUNC(v68hvx_v6mpy,
+         ".word 0x1f42e424    /* v5:4.w = v6mpy(v5:4.ub, v3:2.b, #1):v */\n")
+
+TRY_FUNC(v69hvx_vasrvuhubrndsat,
+         ".word 0x1d06c465    /* v5.ub = vasr(v5:4.uh, v6.ub):rnd:sat */\n")
+TRY_FUNC(v69hvx_vasrvuhubsat,
+         ".word 0x1d06c445    /* v5.ub = vasr(v5:4.uh, v6.ub):sat */\n")
+TRY_FUNC(v69hvx_vasrvwuhrndsat,
+         ".word 0x1d06c425    /* v5.uh = vasr(v5:4.w, v6.uh):rnd:sat */\n")
+TRY_FUNC(v69hvx_vasrvwuhsat,
+         ".word 0x1d06c405    /* v5.uh = vasr(v5:4.w, v6.uh):sat */\n")
+TRY_FUNC(v69hvx_vassign_tmp,
+         ".word 0x1e014dcc    /* { v12.tmp = v13 */\n"
+         ".word 0x1c43cc04    /*    v4.w = vadd(v12.w, v3.w) } */\n")
+TRY_FUNC(v69hvx_vcombine_tmp,
+         ".word 0x1eae4fec    /* { v13:12.tmp = vcombine(v15, v14) */\n"
+         ".word 0x1c434c04    /*   v4.w = vadd(v12.w, v3.w) */\n"
+         ".word 0x1e03edf0    /*   v16 = v13 } */\n")
+TRY_FUNC(v69hvx_vmpyuhvs,
+         ".word 0x1fc5e4e4    /* v4.uh = vmpy(V4.uh, v5.uh):>>16 */\n")
+
+TRY_FUNC(v73_callrh,
+         ".word 0x50c5c000    /* callrh r5 */\n")
+TRY_FUNC(v73_jumprh,
+         ".word 0x52c0c000    /* jumprh r0 */\n")
+
+int main(void)
+{
+    struct sigaction act;
+
+    memset(&act, 0, sizeof(act));
+    act.sa_sigaction = handle_sigill;
+    act.sa_flags = SA_SIGINFO;
+    assert(sigaction(SIGILL, &act, NULL) == 0);
+
+    assert(try_v68_loadw_aq() == SIGILL);
+    assert(try_v68_loadd_aq() == SIGILL);
+    assert(try_v68_release_at() == SIGILL);
+    assert(try_v68_release_st() == SIGILL);
+    assert(try_v68_storew_rl_at() == SIGILL);
+    assert(try_v68_stored_rl_at() == SIGILL);
+    assert(try_v68_storew_rl_st() == SIGILL);
+    assert(try_v68_stored_rl_st() == SIGILL);
+
+    assert(try_v68hvx_v6mpy() == SIGILL);
+
+    assert(try_v69hvx_vasrvuhubrndsat() == SIGILL);
+    assert(try_v69hvx_vasrvuhubsat() == SIGILL);
+    assert(try_v69hvx_vasrvwuhrndsat() == SIGILL);
+    assert(try_v69hvx_vasrvwuhsat() == SIGILL);
+    assert(try_v69hvx_vassign_tmp() == SIGILL);
+    assert(try_v69hvx_vcombine_tmp() == SIGILL);
+    assert(try_v69hvx_vmpyuhvs() == SIGILL);
+
+    assert(try_v73_callrh() == SIGILL);
+    assert(try_v73_jumprh() == SIGILL);
+
+    assert(signals_handled == expected_signals);
+
+    puts("PASS");
+    return EXIT_SUCCESS;
+}
diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
index f86f02bb31..0050370806 100644
--- a/tests/tcg/hexagon/Makefile.target
+++ b/tests/tcg/hexagon/Makefile.target
@@ -81,6 +81,7 @@ HEX_TESTS += test_vminh
 HEX_TESTS += test_vpmpyh
 HEX_TESTS += test_vspliceb
 
+HEX_TESTS += check_rev_gating
 HEX_TESTS += v68_scalar
 HEX_TESTS += v68_hvx
 HEX_TESTS += v69_hvx
@@ -106,6 +107,11 @@ read_write_overlap: read_write_overlap.c hex_test.h
 reg_mut: reg_mut.c hex_test.h
 unaligned_pc: unaligned_pc.c
 
+# Compile for v66 so that the ELF selects a v66 CPU; the test then
+# exercises revision gating by executing a v68 .word instruction.
+check_rev_gating: check_rev_gating.c
+	$(CC) $(CFLAGS) -mv66 -O2 $< -o $@ $(LDFLAGS)
+
 # This test has to be compiled for the -mv67t target
 usr: usr.c hex_test.h
 	$(CC) $(CFLAGS) -mv67t -O2 -Wno-inline-asm -Wno-expansion-to-defined $< -o $@ $(LDFLAGS)
-- 
2.43.0


