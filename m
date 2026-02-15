Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AF2E63F19
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 22:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrkEN-0005YE-0d; Sun, 15 Feb 2026 17:04:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vrkEK-0005XQ-Ig
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 17:04:41 -0500
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vrkEH-000533-9m
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 17:04:39 -0500
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-40ede943bf0so1430011fac.2
 for <qemu-devel@nongnu.org>; Sun, 15 Feb 2026 14:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771193076; x=1771797876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m+qNKUAlpp9a6yuJ0J/t49+0Pl4hNg0jUhpv5P0Iy6I=;
 b=HrGpeYROhpRnnNoA+2f7E4RBew+Mtm+GlJyLAM8YcQ2fVnGwKwkTqvv9lWFbKZx8Er
 +DyUPWzvPnd6Jm0TwMv8AzUVITeixXqtkm3scvh8KAzhKawuULQkdNScWe35GGtFRVGS
 W+YoHTLbbvAzlw11zmJvLDKalQVPzpr7SvnAKvI70jwjxZRPiy2VRs8OWyEpYlsMu3ae
 GVDprAZvN+PyZyeTxe7aYTPzwjEV0s7MuUx9yfXMwxnQqKoaFsaABX14JZyXCR4pmdaz
 0BY0Ih4/3wdfCPz5dhEOCxHUVXdyxCjbjstN+6zuqtZNCkO0fTOmzYXqHVMaWfE7Oln4
 APQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771193076; x=1771797876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m+qNKUAlpp9a6yuJ0J/t49+0Pl4hNg0jUhpv5P0Iy6I=;
 b=ts/OpLkOBx9QvoHTuZsiypCKALQ3ffwM5u15eUH5ueA7OhH+WmxvrH5z4MSJVQN9St
 OZp7y98Ag+ubwpTigWCOK48VBhZaPoa2J/hvjFmZbW9tRd8SMJOLRNU4+OgU3AZcVurN
 paxTy6gIexMsj1xJgEwY9GLA3yuBqjM0rdH8DAl7/vAZJHu845iPBp3dt6/Wnemk4ul2
 JQT4xrcnLe+9oITMm7NmYZcvfZcw75N8DMx6MpB1Xl9YF1twwj33Eum9pCmkFQyzCTJL
 5Ii+Lre0Xgp9VoigV2x8+3V/WJilOLycf4zV3MQQmnsml6KVDrbR7JH/5YLof3F/5T5r
 0XsQ==
X-Gm-Message-State: AOJu0YyI9hjxXiTa3Rs8/8v60KVEX8b2c9FQijcLnc3+tGCGIZ8TOH26
 ccmJR+UR7SXIHgCoR07239FJWYvQEkII150B0nQxNyG9eaDTdvfCQHPx3oYUqg==
X-Gm-Gg: AZuq6aL1JMqIGoiPMbT9C+eGW/YyVzUn10VX7bgwrTOKagFqUaK4JOnVMlYM2+o1d/f
 ddwywwiC1mpCht8qAlYAzd5w7Lqyy1FL40ffO4n0Llj06RcU6bFMCPuCE1qbYgijRv48mhBpTNK
 ezQ8yHVws9kwdUfq/djyR+K2KrZSJ+5F9+ucadwpdHaAXtPL2oDvG2EBC/66flTYBOTsS6BoJ/H
 mciPI+QwUw1Epz5jTn9zuvOmnuCfqZyjit1w6eecEzj926566/jO6UU8N1yRx/LhuGTN0ip8oKy
 gftBvI9PO6Me0bhKwGwz/UvP9ma6FCEN8UzkiEVbbFJZviefLOiAkWSq32ycNq9Ytoa6rlhZHzz
 TEIpl8WgIQPyBc+S6ybV6KXcphs7EW7kYg74WYgb8ojHznwoVglpwZ4yDRbuHbw7CYSfBGQZf2K
 QZpU28eM6p09AvdwUJTSf53XrlQiTegwoHJ24/t5xOcSslhTr7eMioYZUQQInUtZ4qqdxD0P2Bw
 3wIIaZiR5hWy4TS
X-Received: by 2002:a05:6870:d99:b0:3ff:4ab4:774c with SMTP id
 586e51a60fabf-40f0d94f5cfmr4034428fac.43.1771193075266; 
 Sun, 15 Feb 2026 14:04:35 -0800 (PST)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40eaf101db0sm13556664fac.12.2026.02.15.14.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 14:04:34 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH v2 7/8] tests/tcg/hexagon: Add test for revision-gated
 instruction decoding
Date: Sun, 15 Feb 2026 15:04:21 -0700
Message-ID: <20260215220422.212249-8-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260215220422.212249-1-ltaylorsimpson@gmail.com>
References: <20260215220422.212249-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oa1-x2e.google.com
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


