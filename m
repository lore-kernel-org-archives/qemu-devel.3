Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7B6CD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYgm-0001Cq-05; Wed, 20 May 2026 00:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgk-0001CJ-3r
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:46 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgh-0003pu-3b
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:45 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7dcd689829eso3753414a34.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251861; x=1779856661; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NTvhzxAw58s58HpOXs2lKSLjurt2GSK0pRdaQ/F7z/g=;
 b=Se1Ehd2HQvu2FeUoMkDwRSgfkQkcTFZ8GfrrO4OhHcTGirO7IY8xgnTEdk0hvGm3S1
 B0cMKExeM9p9fvYeVqXOEm1F7RjL3jtGg5OqZ1teg2KxQlC2TgMsRTzw130PsIrwkOXV
 IW9F/XNi0kXkoKIcVPGUwKcG8g5HiNti5KKpBh0lVauWNujo5QUV7fKcxEZBHqlWfNmt
 y2ALvjhvmf1oOCLO8vNP3Cog6OgN8I1TsPMES/eE1bWLp/CVfOVJCbcJB8tBVnR+Gm0G
 BYONqOvhoKaaVhYlFXUmb1x75YOxAHDos3QGT8KeCwYzw560pb9UQVi8X5AQUZCZO5z3
 zNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251861; x=1779856661;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NTvhzxAw58s58HpOXs2lKSLjurt2GSK0pRdaQ/F7z/g=;
 b=mcJ+DacigP1qxtQQAy1XQ4cARmUOQyZxA/fNW2zQbmnA9u7ugTJ2fAwBmPrgY7OqQI
 9IVy9ysDZkew9UiPI5Pf/JV3aBrpy5/zBMHSq7Q8BN46d2pjkXHH+J8kJCL2Zo/o8/Ti
 wiABwY2zWNy0a0Zf7p//VtW5v1PmY9UFQTKi2MD8U2c14Jxw8ULV9NJiGOtoMPayTGdr
 caM+0dneQrbFyfF6NHGfw7Nq5XTUkcwA5pBNKEGmRWqSTQhZ3oIlacCocWapAVKQWyBg
 UdvckfkAs4rHC3/FcRJHox9quJGzO30GQCgzzxZ6M0Xsudqvli71QEA4B29ScjAOXZWr
 awfQ==
X-Gm-Message-State: AOJu0YzFeNNEQNwOxVIEPww35avIBop6uw62X+jxPfUPtArMtrH3IdMW
 bRVbCcFsNqOdbLSs7PXfIxKRnJ2DZdyAPSpnVjHnSgkYcqs5AM74F+vj
X-Gm-Gg: Acq92OGl2ever1p+4oKPpkWLtcqs+m6CnxRfo32k9Us3xo3MBRUfvnCkknN3LQjL1/r
 CVfIdqi6nxhLkfiacBmH0tcAl1nMQPPpTU99WWMMF5qeP2SCCOqSuosicV/6sQ1rO46z1B5JdCd
 gbRRnoHbTL7+srNfNEFGuvpVkYBZ4nbgqjSK6eZXXf6PrxhP3HFxR2LPAwDXXZsv1LtVpOP7UPY
 veyTqPVTqlw3dIFzI+HjxaNme55rBPRPzqHMz2H17r2amReyRpd3t2kqr835iEti/Ggimo9np/Y
 fzlHpk4d8qUb5uOd63cTmURw5VALfFRjVyu29a4bLTJUmVowLGuNZb6H4roOBygpCjV6qRaDn8o
 pXx4RAmtcepEmRbr2KIfOB0CZwkJoZx/QPOy8JJQXS+9GQ8GgGqNPZ1IDyVLk6YT9C+RipxrbcR
 49GP2yyBHcDFXedVxNx7qO6QGLFEcfBwZoDtt4rwga03yVJSOXcGDcHKQ5GHBQ+vmuYAkjWGE6a
 S8E9KyPDd3yc/zYoL2hOA+chPmbLDrdxaChq82ipkCwOHcH+fwXoO7YUm2aGy7JkFsS15b2atMj
 vTM=
X-Received: by 2002:a05:6830:6101:b0:7d7:d504:cc6d with SMTP id
 46e09a7af769-7e4f2bb6546mr17810698a34.21.1779251860777; 
 Tue, 19 May 2026 21:37:40 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:37:40 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 22:37:16 -0600
Subject: [PATCH v10 22/45] tests/tcg/mips: add Octeon instruction smoke
 test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-22-306f9edfe15b@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x333.google.com
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

Add a mips64/mips64el linux-user TCG smoke test for representative
Octeon integer, comparison, population count, and multiplier instruction
paths. Include hardware-backed regression coverage for VMM0 MPL1 zeroing
and MTP0 P1 zeroing.

Run the test with -cpu Octeon68XX and share the source between the
mips64 and mips64el target directories.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split the smoke test out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v5 -> v6:
  - Add VMM0/MPL1 and MTP0/P1 reset checks for the CN71XX-defined
    reset-state behavior.
---
 tests/tcg/mips/user/isa/octeon/octeon-insns.c | 204 ++++++++++++++++++++++++++
 tests/tcg/mips64/Makefile.target              |  20 +++
 tests/tcg/mips64el/Makefile.target            |   8 +
 3 files changed, 232 insertions(+)

diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
new file mode 100644
index 0000000000..9153e37e9e
--- /dev/null
+++ b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
@@ -0,0 +1,204 @@
+/*
+ * Test Octeon-specific user-mode instructions.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <assert.h>
+#include <stdint.h>
+
+static uint64_t octeon_baddu(uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x71095028\n\t" /* baddu $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_dmul(uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x71095003\n\t" /* dmul $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_dpop(uint64_t rs)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        ".word 0x7100502d\n\t" /* dpop $10, $8 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs)
+        : "$8", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_seq(uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x7109502a\n\t" /* seq $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_sne(uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x7109502b\n\t" /* sne $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_vmulu(uint64_t mpl0, uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[mpl0]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x71090008\n\t" /* mtm0 $8, $9 */
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x7109500f\n\t" /* vmulu $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [mpl0] "r" (mpl0), [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_vmm0(uint64_t mpl0, uint64_t p0,
+                            uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[mpl0]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x71090008\n\t" /* mtm0 $8, $9 */
+        "move $8, %[p0]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x71090009\n\t" /* mtp0 $8, $9 */
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x71095010\n\t" /* vmm0 $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [mpl0] "r" (mpl0), [p0] "r" (p0),
+          [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_vmm0_zeroes_mpl1(void)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[mpl0]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x71090008\n\t" /* mtm0 $8, $9 */
+        "move $8, %[mpl1]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x7109000c\n\t" /* mtm1 $8, $9 */
+        "move $8, %[vmm0_rs]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x71095010\n\t" /* vmm0 $10, $8, $9 */
+        "move $8, %[vmulu_rs]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x7109500f\n\t" /* vmulu $10, $8, $9 */
+        "move $8, $0\n\t"
+        "move $9, $0\n\t"
+        ".word 0x7109500f\n\t" /* vmulu $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [mpl0] "r" (1ULL), [mpl1] "r" (1ULL),
+          [vmm0_rs] "r" (2ULL), [vmulu_rs] "r" (1ULL)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_mtp0_zeroes_p1(void)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[mpl0]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x71090008\n\t" /* mtm0 $8, $9 */
+        "move $8, %[p1]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x7109000a\n\t" /* mtp1 $8, $9 */
+        "move $8, $0\n\t"
+        "move $9, $0\n\t"
+        ".word 0x71090009\n\t" /* mtp0 $8, $9 */
+        "move $8, $0\n\t"
+        "move $9, $0\n\t"
+        ".word 0x7109500f\n\t" /* vmulu $10, $8, $9 */
+        "move $8, $0\n\t"
+        "move $9, $0\n\t"
+        ".word 0x7109500f\n\t" /* vmulu $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [mpl0] "r" (0ULL), [p1] "r" (1ULL)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+int main(void)
+{
+    assert(octeon_baddu(0x123, 0x0f0) == 0x13);
+    assert(octeon_dmul(0x12345678, 0x10) == 0x123456780);
+    assert(octeon_dpop(0xf0f0f0f0f0f0f0f0ULL) == 32);
+    assert(octeon_seq(0xabc, 0xabc) == 1);
+    assert(octeon_seq(0xabc, 0xdef) == 0);
+    assert(octeon_sne(0xabc, 0xabc) == 0);
+    assert(octeon_sne(0xabc, 0xdef) == 1);
+    assert(octeon_vmulu(5, 7, 11) == 46);
+    assert(octeon_vmm0(5, 13, 7, 11) == 59);
+    assert(octeon_vmm0_zeroes_mpl1() == 0);
+    assert(octeon_mtp0_zeroes_p1() == 0);
+
+    return 0;
+}
diff --git a/tests/tcg/mips64/Makefile.target b/tests/tcg/mips64/Makefile.target
new file mode 100644
index 0000000000..042855844a
--- /dev/null
+++ b/tests/tcg/mips64/Makefile.target
@@ -0,0 +1,20 @@
+# -*- Mode: makefile -*-
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# MIPS64 - included from tests/tcg/Makefile.target
+#
+
+MIPS64_SRC=$(SRC_PATH)/tests/tcg/mips64
+MIPS_OCTEON_SRC=$(SRC_PATH)/tests/tcg/mips/user/isa/octeon
+
+# Set search path for all sources
+VPATH 		+= $(MIPS64_SRC) $(MIPS_OCTEON_SRC)
+
+MIPS64_TESTS=octeon-insns
+
+TESTS += $(MIPS64_TESTS)
+
+$(MIPS64_TESTS): CFLAGS+=-mabi=64
+
+run-octeon-insns: QEMU_OPTS+=-cpu Octeon68XX
diff --git a/tests/tcg/mips64el/Makefile.target b/tests/tcg/mips64el/Makefile.target
new file mode 100644
index 0000000000..dbc5f8dc5f
--- /dev/null
+++ b/tests/tcg/mips64el/Makefile.target
@@ -0,0 +1,8 @@
+# -*- Mode: makefile -*-
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# MIPS64 little-endian - included from tests/tcg/Makefile.target
+#
+
+include $(SRC_PATH)/tests/tcg/mips64/Makefile.target

-- 
2.54.0


