Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493B4C79F8C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 08:44:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4DtP-0008IJ-VW; Wed, 09 Sep 2026 04:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x4DtO-0008Hq-JH
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 04:42:54 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x4DtM-0003K3-QX
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 04:42:54 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2d944747d41so61006025ad.0
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 01:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1788943371; x=1789548171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3/JSEN4yZJQug9AgbAgWw+4fekDHImfUc2lZDl80p84=;
 b=DQ9dL677NoWmHBzHOeiHaD0vc2xMax+B0qvdsoPJGTlZNKGAQUrigGhB7TpverFhl8
 5ykiqrpHrfyT0X/b3CyYL/D6DxeWkfKtfINEeVBTG7y+zs2lrlQKiR5pwJIo1PnRGkY2
 xdrCWJdDxd09vwEBjcpoLSFvNF4J2Iogu4S4l+p0wDobKySY4cfnTQWtUNYT3TToa0UJ
 35TM0AOfCHFTHE4Mbx5uoDC97ewwXxEquU8bKAIszgpmzUBH21OuQMKAN0Y2QV/Ehy/I
 y4HJiR+unPNghYajoIpib4RMWAM2HM3e/agIkiGF8mvX4H8lmw0nGkvWsLKemDtaGBeY
 ltXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788943371; x=1789548171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3/JSEN4yZJQug9AgbAgWw+4fekDHImfUc2lZDl80p84=;
 b=I9yIZJF3obYcAT02ERvQQADq4dKle4wfxuBmV0C7Tt8cAnCFUlU5M6GDefKfxgU+q5
 Lvu4zEVPoB/4Zzqa5v/SpcUJcW6KxYnn8QqW70ghyuKrxvT2X399UXGJ4NlgnzidNT+u
 VryWV8rklmp/sYIgcQvf5WfzqeP9uBzozWWygA0SWK2bq3HgeeEttuqIbYV4ta/hXdSn
 HLq5AulX/Ncr54qzkr10Fif8oJP5cDrJWn5i3TzL9YwnbC5O9YofGc5zaj7vHaexb0PW
 27ToAOea86zJuq6dqhkCHy1hMZfGJaqgHYsRfLVUFidAOZW+qmTlb8WvmvoDePHnP7uu
 2Fmw==
X-Gm-Message-State: AFuF++k0dHTynhcAFrG3+Jj9xWyiG15FBbhfVAAzbH2a8TvSbpDBXsNG
 Jk4jHepmf9sADx7x5w5IBQp4CvuJzRfKz/52cam/zVVqNTe7pbBeRnGxSK9mE0E9GwgVD4GsPWw
 dccFFYZn8NYgS3Ro10ADrv2wSbMSkvWu0nxrK6pVoKR1wW5I45Iy/grsa2xNEF6i8WOgm4+pidz
 Hv6brsFFM3CTDltwNJeG1BNUMXOgNQUcn1zi4276PpFA==
X-Gm-Gg: AYBFou2+TciKwCA3ixMcSS0cfaj0TRvbqoJJaGIYuLO7TffMG1AItfoflLcn8YdqFRt
 iNy6s0fEztuR6GTM9ezG1CA1hkm6INgjnZM5zp7amcneuX8uVOk1osb+6S6G5hvcQWyKiay17S9
 lriXFKzrl8N53sa3VGjbkmd7H8pK00S0xOUa37sQRgtOl9veDGajUiVO4NweaV8iV9r0GvgD8eH
 iap48YRdedoI+J7aID2IrY/GOPaNOtA3YEJJA99HS/VauJEHghsmSl1Wx34Gba5Ea+/snJl5oYv
 dimcxPXmRkrX2VF/SEfG4YAx+GkwzIVV4f88n6GTiqjVf1VzHqcNm2fQVM5BdDs7LbIW2CeoBP5
 zCW00GRFcl4dqADioW0EqtbDnENIlkUF0wpr+jCZP7FUegDsFcrlln1U5KGcI8Up5EZBxvRawWG
 fTGmm1V+COUiJ8egnpGAAzDFGoHo8rBRpJGbmXwC0A+HH2d2Z3WXvcCpqg3nPrPjQ4EBXiVkNcI
 shtJx2l6oOLIz+IY8AiwaTdKm7bNKYFlpiynxCI3i2xdKKdDfTNNxgFkcrINSESiafvb3ZVMex8
 CBR/i4Wk
X-Received: by 2002:a17:902:930a:b0:2d6:e074:9cad with SMTP id
 d9443c01a7336-2db1236f4femr349937195ad.6.1788943371077; 
 Wed, 09 Sep 2026 01:42:51 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db56c2a1f1sm38328225ad.78.2026.09.09.01.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 01:42:50 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, richard.henderson@linaro.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH 5/6] tests/tcg/riscv64: Add vector fault-only-first page probe
 test
Date: Wed,  9 Sep 2026 16:41:52 +0800
Message-ID: <20260909084154.223529-6-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909084154.223529-1-max.chou@sifive.com>
References: <20260909084154.223529-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add a bare-metal test for vector fault-only-first loads whose
first-element probe crosses a page boundary. The test covers a body
access that crosses the boundary after the first element, and a first
element that itself straddles the boundary, checking that both cases
report a full vl and vstart of 0 rather than faulting on a mapped page.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 tests/tcg/riscv64/Makefile.softmmu-target |  9 ++-
 tests/tcg/riscv64/test-rvv-ldst-ff-page.S | 83 +++++++++++++++++++++++
 2 files changed, 90 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-rvv-ldst-ff-page.S

diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index 9e0e0490753..93c4e58e0c2 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -86,14 +86,16 @@ run-test-vle32ff: test-vle32ff
 test-vle32ff: CFLAGS += -march=rv64gcv
 
 RVV_LDST_MARCH = -march=rv64gcv
-RVV_LDST_TESTS = test-rvv-ldst-ff-pmp test-rvv-ldst-us-pmp
+RVV_LDST_TESTS = test-rvv-ldst-ff-pmp test-rvv-ldst-us-pmp \
+	test-rvv-ldst-ff-page
 CLEANFILES += $(RVV_LDST_TESTS)
 
 $(RVV_LDST_TESTS): %: %.S rvv-ldst.inc $(LINK_SCRIPT)
 	$(CC) $(CFLAGS) $(RVV_LDST_MARCH) $< -Wa,--noexecstack -c -o $@.o
 	$(LD) $(LDFLAGS) $@.o -o $@
 
-EXTRA_RUNS += run-test-rvv-ldst-ff-pmp run-test-rvv-ldst-us-pmp
+EXTRA_RUNS += run-test-rvv-ldst-ff-pmp run-test-rvv-ldst-us-pmp \
+	run-test-rvv-ldst-ff-page
 
 run-test-rvv-ldst-ff-pmp: test-rvv-ldst-ff-pmp
 	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)v=true$(comma)vlen=128$(comma)elen=64$(comma)vext_spec=v1.0$(comma)rvv_ta_all_1s=true$(comma)rvv_ma_all_1s=true $(QEMU_OPTS)$<)
@@ -101,5 +103,8 @@ run-test-rvv-ldst-ff-pmp: test-rvv-ldst-ff-pmp
 run-test-rvv-ldst-us-pmp: test-rvv-ldst-us-pmp
 	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)v=true$(comma)vlen=128$(comma)elen=64$(comma)vext_spec=v1.0$(comma)rvv_ta_all_1s=true$(comma)rvv_ma_all_1s=true $(QEMU_OPTS)$<)
 
+run-test-rvv-ldst-ff-page: test-rvv-ldst-ff-page
+	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)v=true$(comma)vlen=128$(comma)elen=64$(comma)vext_spec=v1.0 $(QEMU_OPTS)$<)
+
 # We don't currently support the multiarch system tests
 undefine MULTIARCH_TESTS
diff --git a/tests/tcg/riscv64/test-rvv-ldst-ff-page.S b/tests/tcg/riscv64/test-rvv-ldst-ff-page.S
new file mode 100644
index 00000000000..63b1e0ac8a8
--- /dev/null
+++ b/tests/tcg/riscv64/test-rvv-ldst-ff-page.S
@@ -0,0 +1,83 @@
+/*
+ * RISC-V vector fault-only-first probe page-crossing tests
+ *
+ * A first-element probe validates the mapping only for the bytes that
+ * the first (fault-only) element itself touches, then lets the
+ * remaining elements of the vector body fault normally.  An
+ * implementation that instead probes the whole multi-element access
+ * range as one host operation aborts as soon as that range crosses a
+ * page boundary, even though every page involved is in fact mapped.
+ *
+ * Case 1 crosses the page boundary only in the vector body, after the
+ * first element.  Case 2 crosses it inside the first element itself,
+ * so the first-element probe must span both pages it touches.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+    #include "rvv-ldst.inc"
+
+    .text
+    .global _start
+_start:
+    RVV_ENABLE
+    lla             t0, trap_handler
+    csrw            mtvec, t0
+
+    /*
+     * Case 1: the body crosses the page boundary; the first element does not.
+     */
+    CASE    1
+    li              t0, 3
+    vsetvli         t1, t0, e8, m1, tu, mu
+    lla             a0, cross_segment
+    vlseg2e8ff.v    v2, (a0)
+    csrr            t0, vl
+    ASSERT_EQ       t0, 3
+    csrr            t0, vstart
+    ASSERT_EQ       t0, 0
+    lla             a0, output
+    vsseg2e8.v      v2, (a0)
+    lbu             t0, 5(a0)
+    ASSERT_EQ       t0, 0x66
+
+    /*
+     * Case 2: the first segment element itself straddles the page boundary.
+     */
+    CASE    2
+    li              t0, 3
+    vsetvli         t1, t0, e8, m1, tu, mu
+    lla             a0, straddle_segment
+    vlseg2e8ff.v    v2, (a0)
+    csrr            t0, vl
+    ASSERT_EQ       t0, 3
+    csrr            t0, vstart
+    ASSERT_EQ       t0, 0
+    lla             a0, output
+    vsseg2e8.v      v2, (a0)
+    lbu             t0, 5(a0)
+    ASSERT_EQ       t0, 0xf6
+    li              a0, 0
+exit:
+    SEMI_EXIT
+    FAIL
+
+    /*
+     * No trap is expected: a spurious fault from the page-crossing probe
+     * is the very thing under test.  Report the case number rather than
+     * vectoring to the reset value of mtvec and hanging until the
+     * harness timeout.
+     */
+    .balign 4
+trap_handler:
+    j               fail
+
+    .data
+    .balign 16
+semiargs: .space 16
+    .balign 4096
+    .space 4094
+cross_segment: .byte 0x11, 0x22, 0x33, 0x44, 0x55, 0x66
+output: .space 6
+    .balign 4096
+    .space 4095
+straddle_segment: .byte 0xa1, 0xb2, 0xc3, 0xd4, 0xe5, 0xf6
-- 
2.43.0


