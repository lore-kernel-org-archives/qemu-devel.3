Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F33C79FAD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 08:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4DtL-0008Gf-7V; Wed, 09 Sep 2026 04:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x4DtJ-0008G9-RX
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 04:42:49 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x4DtG-0003J8-QN
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 04:42:49 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2d8fd3b729dso47233105ad.1
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 01:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1788943365; x=1789548165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wN+jBrsk9ZXuLNa7PYx1X0UEa+sJ9PCm+XtlYprhtYg=;
 b=Rla+VW0Qm4zObi+7P9QDTBWEAD/ONjFXS0Vx3hxTMPZdWzWQUxHfwkMKdw+7FY7Yym
 OR6+Mi/ndAcj+vIOOohmLtx1QmIiLZTE2nhdvOx21w0HiicAL6ltsPxrli7Zl/afcWu6
 OucGmNC5kaFETP2Joiz4kdU1WyWZidUFnCba5gBqUD5GZg2vxbChZrNQgnQU6ybvbjDV
 WVKYrGztOP0bbVqAetDB6lNBM8wjjuJzvXzD/0ThlOgwb/RhNhax2Ymyc/I4DX6Ep4jP
 ICNGXAN/g5Tr3up1vXW30U2+PGab8liOpH5hzKTyUmQjseumhueyWIYZ0iRQCa9sKisi
 VdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788943365; x=1789548165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wN+jBrsk9ZXuLNa7PYx1X0UEa+sJ9PCm+XtlYprhtYg=;
 b=JVh+xBhKHCkkvoJtEmzUiOVGs3d4BK6lqMXqTi/Eo+Juwj9Wm0Z0wBgoEgU+G+c/2y
 GHEdCHnVzaxdUYMXP8AAQXUgtzPxzobNofx0/f4K7shewinHbExY9KQHO32UOJiCSI25
 RKRRvK2Yt99N5Ci3FFERd65CE0lfV/2hs+kVW3TC/AAYh28ck/SZ63BIl/RgijHXS8PV
 YpXRQ6JI9YkSGTE4a1SRfm1VzobCQps84pRjUxqoVac1dfjKps37mWXsND/+0czAjzJs
 skQAyvC6NZeO1fR1MfYjNqCLQeiM9ZCl+v8Go1ZaZAVntGaXQrewnoD2b2Ug6koJaeFc
 x9mA==
X-Gm-Message-State: AFuF++lFEs3moISqdwWjR39KovA+CcFg2KlNCae2Rry1nE/QUNFwFcVg
 i0TI/QVvnK8eQQTAyVtP0qyK+wmIoG0crd01g6Qiq8RBKKtJ5gwbcqTSiC3uzaEsPKc39K6K6gZ
 EVXFjSdbR3UYHhsXB3v/2inGN0jLCDH3V2HkiYNtZexbmwvwnd0VVUf9P0E2F/+F8gXpofbVz2I
 MGYOwk3pLkVGK8Es3Kv6yuSMeJaLYnQIIk45KcL0gPFA==
X-Gm-Gg: AYBFou0QD15ubVRSF/kH6UYyslqcHClIN/XuidWHoQ1QVEEDmka8p+xrAe4cqiojU61
 0gbGBHgU4Dh5W15FY8by5gxmW0sJi+v1sSRZL0hexFRvciNFFXpleThUokefbMiGAFN1k7iBmAV
 t5u3DcFDQo9a/NG9TGZ6a0spVQ0l9QtQJ/eGa+ogOE0Q1EBy2td0Q2Au6dPlVH8ZxiE1PknCEYP
 eCLGM0ET7OlSePHPgJVIqzDtm2mcS+0Fn/GQgvn7HzQ0JYmTVr/UHFVeqo0Q+ZSZjZxtGcsxg1w
 raImyIqv6hpTowurUcXFf8h4/d3qJ+cHHSNqzDTRS3UGA3DFUg3+A6EHxLR4TBh7tFMcUTNIYfS
 69iXsnG10owP44yy+ysXHo+vn289CbbtRds60F6HCqsX2Ahi6YWRTbeFN/7MIdW13v4Tqvw3REL
 JqZQMWwyBH1brXynrpFNR3IH22KjpsJH0dVNluTtuCZQVpBLlURqaajYLl0HxwMXfOnOEY2viIO
 nWPNYt9tI9Qui0YKybUFBm/RPzecmduu3vGjFX0ywN/TFdEfUaAm7nI+B27D/PLGcVcDb9WEZFh
 9SoKIOUU
X-Received: by 2002:a17:902:c94f:b0:2d6:df31:5bd0 with SMTP id
 d9443c01a7336-2db125c3322mr492527375ad.10.1788943365199; 
 Wed, 09 Sep 2026 01:42:45 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db56c2a1f1sm38328225ad.78.2026.09.09.01.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 01:42:44 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, richard.henderson@linaro.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH 3/6] tests/tcg/riscv64: Add vector masked fault-only-first PMP
 test
Date: Wed,  9 Sep 2026 16:41:50 +0800
Message-ID: <20260909084154.223529-4-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909084154.223529-1-max.chou@sifive.com>
References: <20260909084154.223529-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x632.google.com
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

Add a bare-metal test for masked vector fault-only-first loads across
locked NA4 PMP regions inside one page. The test covers masked-off
elements, a faulting active element 0, and later active faults that
shorten vl.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 tests/tcg/riscv64/Makefile.softmmu-target |  13 ++
 tests/tcg/riscv64/rvv-ldst.inc            |  91 ++++++++
 tests/tcg/riscv64/test-rvv-ldst-ff-pmp.S  | 259 ++++++++++++++++++++++
 3 files changed, 363 insertions(+)
 create mode 100644 tests/tcg/riscv64/rvv-ldst.inc
 create mode 100644 tests/tcg/riscv64/test-rvv-ldst-ff-pmp.S

diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index f2c75abd57a..0fdf242f735 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -85,5 +85,18 @@ run-test-vle32ff: test-vle32ff
 	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)v=true $(QEMU_OPTS)$<)
 test-vle32ff: CFLAGS += -march=rv64gcv
 
+RVV_LDST_MARCH = -march=rv64gcv
+RVV_LDST_TESTS = test-rvv-ldst-ff-pmp
+CLEANFILES += $(RVV_LDST_TESTS)
+
+$(RVV_LDST_TESTS): %: %.S rvv-ldst.inc $(LINK_SCRIPT)
+	$(CC) $(CFLAGS) $(RVV_LDST_MARCH) $< -Wa,--noexecstack -c -o $@.o
+	$(LD) $(LDFLAGS) $@.o -o $@
+
+EXTRA_RUNS += run-test-rvv-ldst-ff-pmp
+
+run-test-rvv-ldst-ff-pmp: test-rvv-ldst-ff-pmp
+	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)v=true$(comma)vlen=128$(comma)elen=64$(comma)vext_spec=v1.0$(comma)rvv_ta_all_1s=true$(comma)rvv_ma_all_1s=true $(QEMU_OPTS)$<)
+
 # We don't currently support the multiarch system tests
 undefine MULTIARCH_TESTS
diff --git a/tests/tcg/riscv64/rvv-ldst.inc b/tests/tcg/riscv64/rvv-ldst.inc
new file mode 100644
index 00000000000..061f330abef
--- /dev/null
+++ b/tests/tcg/riscv64/rvv-ldst.inc
@@ -0,0 +1,91 @@
+/*
+ * Common support for bare-metal RVV load/store regressions
+ *
+ * Register contract: these macros use t0, t1, t5 and t6 as scratch and
+ * keep the current case number in s11.  ASSERT_EQ and CHECK_VELEM hold
+ * their expected value in t6 across a branch, so a trap handler that can
+ * run in between must leave t6 alone; use t5 and s5 for that instead.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+    .option    norelax
+    .option    norvc
+
+    .macro          RVV_ENABLE
+    li              t0, 0x6600
+    csrs            mstatus, t0
+    csrw            vcsr, zero
+    .endm
+
+    .macro          ASSERT_EQ actual, expected
+    li              t6, \expected
+    bne             \actual, t6, fail
+    .endm
+
+    .macro          CASE number
+    li              s11, \number
+    .endm
+
+    .macro          SEMI_EXIT
+    lla             a1, semiargs
+    li              t0, 0x20026
+    sd              t0, 0(a1)
+    sd              a0, 8(a1)
+    li              a0, 0x20
+    .balign         16
+    slli            zero, zero, 0x1f
+    ebreak
+    srai            zero, zero, 0x7
+    j    .
+    .endm
+
+    .macro          FAIL
+fail:
+    mv              a0, s11
+    bnez            a0, 1f
+    li              a0, 1
+1:
+    j               exit
+    .endm
+
+    /* Pre-fill selected registers with a sentinel neither data nor 1s. */
+    .macro          PREFILL vd=, vl=4, sew=e32, value=0x05050505
+    vsetivli        zero, \vl, \sew, m1, ta, ma
+    li              t0, \value
+    .ifb            \vd
+    vmv.v.x         v2, t0
+    vmv.v.x         v3, t0
+    .else
+    vmv.v.x         \vd, t0
+    .endif
+    .endm
+
+    /* Set the low mask bits of v0 to \val. */
+    .macro          SET_MASK val
+    vsetivli        zero, 1, e8, m1, ta, ma
+    li              t0, \val
+    vmv.s.x         v0, t0
+    .endm
+
+    /* Assert element \idx of \vsrc (e32) equals \expected. */
+    .macro          CHECK_VELEM vsrc, idx, expected
+    vsetivli        zero, 4, e32, m1, ta, ma
+    vslidedown.vi   v8, \vsrc, \idx
+    vmv.x.s         t0, v8
+    li              t6, \expected
+    bne             t0, t6, fail
+    .endm
+
+    /* Assert that no trap has been taken since the last check. */
+    .macro          CHECK_NO_TRAP
+    bne             s2, s4, fail
+    .endm
+
+    /* Assert that exactly one expected trap has been taken. */
+    .macro          CHECK_TRAP
+    addi            s4, s4, 1
+    bne             s2, s4, fail
+    li              s0, 0
+    li              s1, 0
+    .endm
diff --git a/tests/tcg/riscv64/test-rvv-ldst-ff-pmp.S b/tests/tcg/riscv64/test-rvv-ldst-ff-pmp.S
new file mode 100644
index 00000000000..80b48965625
--- /dev/null
+++ b/tests/tcg/riscv64/test-rvv-ldst-ff-pmp.S
@@ -0,0 +1,259 @@
+/*
+ * RISC-V vector masked fault-only-first with PMP tests
+ *
+ * PMP permissions may change at NA4 (4-byte) granularity inside one
+ * target page, matching one e32 element exactly. A masked-off body
+ * element performs no memory access, so a read-denied PMP region under
+ * a masked-off element must not fault.
+ *
+ * Runs with rvv_ta_all_1s=true and rvv_ma_all_1s=true so that with a
+ * "ta, ma" vtype every masked-off and tail element must read back as
+ * all-1s, distinct from the 0x05050505 sentinel and the loaded data.
+ *
+ * PMP layout (locked entries, lowest number wins; everything outside
+ * the test page is unmatched and so fully accessible from M-mode):
+ *   pmp0: NA4   buf_a+4,   L, ---   deny element 1 of buf_a
+ *   pmp1: NA4   buf_b+0,   L, ---   deny element 0 of buf_b
+ *   pmp2: NA4   buf_c+8,   L, ---   deny element 2 of buf_c
+ *   pmp3: NAPOT test page, L, R     lower-priority page allow
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+    #include "rvv-ldst.inc"
+
+    .text
+    .global _start
+_start:
+    RVV_ENABLE
+    lla     t0, trap_handler
+    csrw    mtvec, t0
+
+    /*
+     * Trap handler protocol:
+     *   s0: expected mcause (0: no trap expected)
+     *   s1: expected mtval (-1 accepts any value)
+     *   s2: traps taken
+     *   s3: vstart seen at last trap
+     *   s4: traps expected
+     *   s5: mtval seen at last trap
+     */
+    li      s0, 0
+    li      s1, 0
+    li      s2, 0
+    li      s3, -1
+    li      s4, 0
+
+    /* Program the locked PMP entries; single locking cfg write last. */
+    lla     t0, buf_a + 4
+    srli    t0, t0, 2
+    csrw    pmpaddr0, t0
+    lla     t0, buf_b
+    srli    t0, t0, 2
+    csrw    pmpaddr1, t0
+    lla     t0, buf_c + 8
+    srli    t0, t0, 2
+    csrw    pmpaddr2, t0
+    lla     t0, pmp_page
+    srli    t0, t0, 2
+    ori     t0, t0, 0x1ff
+    csrw    pmpaddr3, t0
+    li      t0, 0x99909090
+    csrw    pmpcfg0, t0
+
+    /*
+     * Case 1: sanity: the NA4 deny is in effect for a scalar load.
+     */
+    CASE    1
+    li              s0, 5
+    li              s1, -1
+    lla             t1, buf_a
+    lw              t0, 4(t1)
+    CHECK_TRAP
+
+    /*
+     * Case 2: denied bytes lie only under masked-off element 1: no trap.
+     * QEMU retains vl at 3 for this successful access.
+     */
+    CASE    2
+    PREFILL
+    SET_MASK        0b101
+    vsetivli        zero, 3, e32, m1, ta, ma
+    lla             a0, buf_a
+    vle32ff.v       v2, (a0), v0.t
+    CHECK_NO_TRAP
+    csrr            t0, vl
+    ASSERT_EQ       t0, 3
+    csrr            t0, vstart
+    bnez            t0, fail
+    CHECK_VELEM     v2, 0, 0x00aa0000
+    CHECK_VELEM     v2, 1, -1
+    CHECK_VELEM     v2, 2, 0x00aa0002
+    CHECK_VELEM     v2, 3, -1
+
+    /*
+     * Case 3: active element 0 denied: trap, vstart 0.
+     */
+    CASE    3
+    PREFILL
+    li              s0, 5
+    li              s1, -1
+    vsetivli        zero, 3, e32, m1, ta, ma
+    lla             a0, buf_b
+    vle32ff.v       v2, (a0)
+    CHECK_TRAP
+    bnez            s3, fail
+
+    /*
+     * Case 4: masked-off element 0 over denied bytes: no trap.
+     * retains vl at 3 and loads elements 1 and 2.
+     */
+    CASE    4
+    PREFILL
+    SET_MASK        0b110
+    vsetivli        zero, 3, e32, m1, ta, ma
+    lla             a0, buf_b
+    vle32ff.v       v2, (a0), v0.t
+    CHECK_NO_TRAP
+    csrr            t0, vl
+    ASSERT_EQ       t0, 3
+    CHECK_VELEM     v2, 0, -1
+    CHECK_VELEM     v2, 1, 0x00bb0001
+    CHECK_VELEM     v2, 2, 0x00bb0002
+    CHECK_VELEM     v2, 3, -1
+
+    /*
+     * Case 5: active element 2 denied, unmasked: no trap, vl 2.
+     */
+    CASE    5
+    PREFILL
+    vsetivli        zero, 3, e32, m1, ta, ma
+    lla             a0, buf_c
+    vle32ff.v       v2, (a0)
+    CHECK_NO_TRAP
+    csrr            t0, vl
+    ASSERT_EQ       t0, 2
+    CHECK_VELEM     v2, 0, 0x00cc0000
+    CHECK_VELEM     v2, 1, 0x00cc0001
+    CHECK_VELEM     v2, 2, -1
+    CHECK_VELEM     v2, 3, -1
+
+    /*
+     * Case 6: masked-off element 0, active element 2 denied: vl 2.
+     */
+    CASE    6
+    PREFILL
+    SET_MASK        0b110
+    vsetivli        zero, 3, e32, m1, ta, ma
+    lla             a0, buf_c
+    vle32ff.v       v2, (a0), v0.t
+    CHECK_NO_TRAP
+    csrr            t0, vl
+    ASSERT_EQ       t0, 2
+    CHECK_VELEM     v2, 0, -1
+    CHECK_VELEM     v2, 1, 0x00cc0001
+    CHECK_VELEM     v2, 2, -1
+    CHECK_VELEM     v2, 3, -1
+
+    /*
+     * Case 7: nf=2 segments, masked-off segment 0 covers the denied bytes at
+     * buf_b: no trap. retains vl at 3 and loads segments 1 and 2.
+     */
+    CASE    7
+    PREFILL
+    SET_MASK        0b110
+    vsetivli        zero, 3, e32, m1, ta, ma
+    lla             a0, buf_b
+    vlseg2e32ff.v   v2, (a0), v0.t
+    CHECK_NO_TRAP
+    csrr            t0, vl
+    ASSERT_EQ       t0, 3
+    CHECK_VELEM     v2, 0, -1
+    CHECK_VELEM     v3, 0, -1
+    CHECK_VELEM     v2, 1, 0x00bb0002
+    CHECK_VELEM     v3, 1, 0x00bb0003
+    CHECK_VELEM     v2, 2, 0x00bb0004
+    CHECK_VELEM     v3, 2, 0x00bb0005
+    CHECK_VELEM     v2, 3, -1
+    CHECK_VELEM     v3, 3, -1
+
+    /*
+     * Case 8: nf=2 segments, unmasked, field 0 of segment 1 denied
+     * at buf_c+8: no trap, vl truncates to 1, segment 0 loaded.
+     */
+    CASE    8
+    PREFILL
+    vsetivli        zero, 3, e32, m1, ta, ma
+    lla             a0, buf_c
+    vlseg2e32ff.v   v2, (a0)
+    CHECK_NO_TRAP
+    csrr            t0, vl
+    ASSERT_EQ       t0, 1
+    CHECK_VELEM     v2, 0, 0x00cc0000
+    CHECK_VELEM     v3, 0, 0x00cc0001
+    CHECK_VELEM     v2, 1, -1
+    CHECK_VELEM     v3, 1, -1
+    CHECK_VELEM     v2, 2, -1
+    CHECK_VELEM     v3, 2, -1
+    CHECK_VELEM     v2, 3, -1
+    CHECK_VELEM     v3, 3, -1
+
+    /*
+     * Case 9: the denied masked-off element is the last element of the
+     * accessed range, so a range probe cannot miss it as an interior
+     * region: no trap. retains vl at 2.
+     */
+    CASE    9
+    PREFILL
+    SET_MASK        0b01
+    vsetivli        zero, 2, e32, m1, ta, ma
+    lla             a0, buf_a
+    vle32ff.v       v2, (a0), v0.t
+    CHECK_NO_TRAP
+    csrr            t0, vl
+    ASSERT_EQ       t0, 2
+    CHECK_VELEM     v2, 0, 0x00aa0000
+    CHECK_VELEM     v2, 1, -1
+    CHECK_VELEM     v2, 2, -1
+    CHECK_VELEM     v2, 3, -1
+
+    li    a0, 0
+exit:
+    SEMI_EXIT
+    FAIL
+
+    .balign    4
+trap_handler:
+    csrr   t5, mcause
+    bne    t5, s0, fail
+    csrr   s5, mtval
+    li     t5, -1
+    beq    s1, t5, 1f
+    bne    s5, s1, fail
+1:
+    csrr    s3, vstart
+    addi    s2, s2, 1
+    csrw    vstart, zero
+    csrr    t5, mepc
+    addi    t5, t5, 4
+    csrw    mepc, t5
+    mret
+
+    .data
+    .balign    16
+semiargs: .space 16
+
+    /* One dedicated page; the locked NAPOT entry grants R only. */
+    .balign    4096
+pmp_page:
+buf_a:
+    .word    0x00aa0000, 0x00aa0001, 0x00aa0002, 0x00aa0003
+    .word    0x00aa0004, 0x00aa0005
+    .skip    40
+buf_b:
+    .word    0x00bb0000, 0x00bb0001, 0x00bb0002, 0x00bb0003
+    .word    0x00bb0004, 0x00bb0005
+    .skip    40
+buf_c:
+    .word    0x00cc0000, 0x00cc0001, 0x00cc0002, 0x00cc0003
+    .word    0x00cc0004, 0x00cc0005
+    .skip    3944
-- 
2.43.0


