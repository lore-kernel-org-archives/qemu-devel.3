Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61797606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lkmCqpJY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLafw-0001rF-TD; Tue, 27 Oct 2026 02:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLafp-0001qI-Ut
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:28:43 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLafn-000897-2c
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:28:41 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3ace1f3897cso1968338a91.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793082518; x=1793687318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=prs2BorVBGycmIxubtkbkaBrRtY0UMbvC84/KLTs3Ow=;
 b=lkmCqpJYxWPoXYjgI91sIQtob+Smfxs71pf28huJGFrlX645R7RwexeNt0ErSf6vqx
 XpaXr6ndmWGQGmz1+PxQ+9lD9Xc2jtIhIN8gWiP1lWL5nyw1FqZsyWj2QP8dGIQjDt/x
 vX8L6Fp+hIt6bFmLHMSshJOZTIMa5JLjUzD87n4gaeFPVzPadyPqmhD/fWNhRJDJniTT
 Adnb8dkhXxi8xYWJ6W76HBzH8Lr23lBp3Q1Ig1VENXq8eZdf1V+BSRgf90JBzmoNAYpP
 BLvSBsZXT5g/+iE8VsfaQo/8jjA8lq21DDA2cNAqkTBhBvKn2Z37isDgUQdky8u6ONen
 yYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793082518; x=1793687318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=prs2BorVBGycmIxubtkbkaBrRtY0UMbvC84/KLTs3Ow=;
 b=QjHOxyaiRiprYeDdpO3mUbv9HrZghAXVuPNZL9bdV/NoriHaXTO08DbVWXj2Ws9EMh
 AXcgLQP6ZBUFHTtmWfvoYlbCXwSMoDxEMopS+txmqzpg4b/3/e4pLL6I7WlXBODkDYnP
 eDdvA0mvt0kmiIYOKcHjnNzqiO1tPV/8r7skIOBYS9cd9MTDV3euva3ZA7cN5sIW1Pyc
 vBRPaDOg+CYDuQv77Y65jiIKJoow1qykwWJjungAfFWT8c3dHPJo8XEfx0E98fXCpjuj
 N/a7l7mcQAbcr9FiYzCGTtDkpzXyWLx5GMZ/UsDlLRpTZGn+AGiNEuE7KbsbnehDYSfV
 0jGw==
X-Gm-Message-State: AFq9FYJtioUo5JLh0mwAzfs8wwPnQQaTvlqo43mFKXrnXqGOhgUWEmY4
 2gmwqhklYQkOEZ3lhHe9TzLl3kJDOr846g1GGIyBGcJ7vA+PGYIOTnNZeSo4rw==
X-Gm-Gg: AYBFou0igamdsfB51eqbmgRiCwV10Udh7UPMF/YtUEZccJmfiTRVX2TxdnurbQIhjMZ
 W0b0MfKKaXV7oa1AJbMfuNljPdlk6es6fgfryld+fAKVekdVx6PiEGOu2Mq6Sw8YguqHRi3F3Qy
 v2Ftidu3nFf8dFQH8gcsflhFGN4+T9z10rDl+yb16Xgvmj4vIh+PfEZM+zbYzOFomAlSp+pnjn8
 QDguw3nYlanDh2gT5jWNJxKG6yrbHT1MFx6e1gFZ8v6JF6Ak+B3t0FCIaqikeolBtbfghimhHUO
 AEVS7shvXaLnIPaWPt+t0aiIxsf646lCecMLKv2Pn33knGoSye7hdkXDn2JfDiRiBgO99N+Hah5
 ip+CVZTipS1budbXKahzK7AaviOkyPRrrLrXz7tyfozfQQmQsgNB3GqySz4M2gC/YNC96cwFRO5
 J5vzz+aB9JySJ80mO2dSvDqdT/PWczIPjVxnHPd6BHF8NOwVZEtG5ZpwZ4TjbXwGsLJc+OWEqS5
 cfitlZivdTKCy8xfnAqunsRd/6FZ+hhpaFjt5EEqrsBTDi/dv6BsXd1VfJ2WWGWHsDgU4lnmg==
X-Received: by 2002:a17:90b:528a:b0:3a7:da33:ff2d with SMTP id
 98e67ed59e1d1-3adead62207mr6896031a91.48.1793082517405; 
 Mon, 26 Oct 2026 23:28:37 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae401bf352sm2358541a91.0.2026.10.26.23.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:28:36 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Mingliang Liu <liumingliang.dev@bytedance.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 03/29] tests/tcg/riscv64: Add Zvabd extension tests
Date: Tue, 27 Oct 2026 16:27:42 +1000
Message-ID: <20261027062808.1995205-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027062808.1995205-1-alistair.francis@wdc.com>
References: <20261027062808.1995205-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102f.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mingliang Liu <liumingliang.dev@bytedance.com>

Add a RV64 TCG test covering the masked and unmasked vector-vector
and vector-scalar forms of vabd, vabdu, vwabda, and vwabdau.

Assemblers do not yet support the version 0.9 instruction mnemonics,
so the instruction encodings are hardcoded for the time being.

GNU binutils 2.47 supports the incompatible version 0.7 instruction
encodings. Therefore, this test must not be built with that version,
even after it is converted to use instruction mnemonics.

Co-Author: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Mingliang Liu <liumingliang.dev@bytedance.com>
Tested-by: Chao Liu <chao.liu@processmission.com>
Message-ID: <20261015134337.3354723-4-liumingliang.dev@bytedance.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/tcg/riscv64/system/meson.build |   1 +
 tests/tcg/riscv64/test-zvabd.S       | 659 +++++++++++++++++++++++++++
 2 files changed, 660 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-zvabd.S

diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index 728526dc7a30..99ba9913ac4d 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -25,6 +25,7 @@ tests += {
   'test-minstret-ecall.S': setup + {'qemu_args': ['-icount', 'shift=1', qemu_args]},
   'test-minstret-wfi.S': setup + {'qemu_args': ['-icount', 'shift=1', qemu_args]},
   'test-misa-w.S': setup + {'qemu_args': ['-cpu', 'rv64,x-misa-w=true,c=true,v=true', qemu_args]},
+  'test-zvabd.S': setup + {'qemu_args': ['-cpu', 'rv64,v=true,vlen=256,x-zvabd=true', qemu_args]},
 }
 
 tests += {
diff --git a/tests/tcg/riscv64/test-zvabd.S b/tests/tcg/riscv64/test-zvabd.S
new file mode 100644
index 000000000000..4f91acea0cde
--- /dev/null
+++ b/tests/tcg/riscv64/test-zvabd.S
@@ -0,0 +1,659 @@
+/*
+ * Test the Zvabd vector absolute-difference instructions and the vabs.v
+ * pseudoinstruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+	.option arch, +v
+	.option norvc
+
+	.text
+
+	.global _start
+_start:
+	/* Enable the vector unit (mstatus.VS = Initial). */
+	li	t0, 1 << 9
+	csrs	mstatus, t0
+
+	/* Route synchronous traps to trap_handler (mtvec direct mode). */
+	la	t0, trap_handler
+	csrw	mtvec, t0
+
+	/* Run each test function. */
+	call	test_vabs_v
+	bnez	a0, _exit
+	call	test_vabs_v_mask
+	bnez	a0, _exit
+
+	call	test_vabd_vv
+	bnez	a0, _exit
+	call	test_vabd_vv_mask
+	bnez	a0, _exit
+
+	call	test_vabd_vx
+	bnez	a0, _exit
+	call	test_vabd_vx_mask
+	bnez	a0, _exit
+
+	call	test_vabdu_vv
+	bnez	a0, _exit
+	call	test_vabdu_vv_mask
+	bnez	a0, _exit
+
+	call	test_vabdu_vx
+	bnez	a0, _exit
+	call	test_vabdu_vx_mask
+	bnez	a0, _exit
+
+	call	test_vwabda_vv
+	bnez	a0, _exit
+	call	test_vwabda_vv_mask
+	bnez	a0, _exit
+
+	call	test_vwabda_vx
+	bnez	a0, _exit
+	call	test_vwabda_vx_mask
+	bnez	a0, _exit
+
+	call	test_vwabdau_vv
+	bnez	a0, _exit
+	call	test_vwabdau_vv_mask
+	bnez	a0, _exit
+
+	call	test_vwabdau_vx
+	bnez	a0, _exit
+	call	test_vwabdau_vx_mask
+	bnez	a0, _exit
+
+	j	_exit
+
+test_vabs_v:
+	vsetivli zero, 2, e8, m1, ta, ma
+
+	/* Load .arr_neg array in v1 */
+	la     t0,.arr_neg
+	vle8.v v1,0(t0)
+
+	/* vabs.v v2, v1 (vabd.vx v2, v1, x0) raw opcode */
+	.insn r 0x57, 0x6, 0x2b, x2, x0, x1
+
+	/* Load .arr_pos in v3 */
+	la      t1,.arr_pos
+	vle8.v  v3,0(t1)
+
+	/* Compare v2 and v3 into v0 */
+	vmsne.vv  v0,v2,v3
+	vcpop.m a0,v0
+	snez    a0,a0
+
+	ret
+
+test_vabs_v_mask:
+	vsetivli zero, 2, e8, m1, ta, mu
+
+	/* Load .arr_neg array in v1 */
+	la      t0, .arr_neg
+	vle8.v  v1, 0(t0)
+
+	/* Zero v2 using .arr_zero */
+	la     t0,.arr_zero
+	vle8.v v2,0(t0)
+
+	/* Load .v0_mask array in v0 */
+	la     t1,.v0_mask
+	vle8.v v0,0(t1)
+
+	/* vabs.v v2, v1, v0.t raw opcode */
+	.insn r 0x57, 0x6, 0x2a, x2, x0, x1
+
+	/* Load .arr_masked in v3 */
+	la      t0,.arr_masked
+	vle8.v  v3,0(t0)
+
+	/* Compare v2 and v3 into v0 */
+	vmsne.vv  v0,v2,v3
+	vcpop.m a0,v0
+	snez    a0,a0
+
+	ret
+
+test_vabd_vv:
+	/*
+	 * Test signed vector-vector absolute difference:
+	 * abs({-5, -7} - {5, 7}) = {10, 14}.
+	 */
+	vsetivli zero, 2, e8, m1, ta, mu
+
+	/* Load the two signed source vectors into v1 and v3. */
+	la      t0, .arr_neg
+	vle8.v  v1, 0(t0)
+	la      t0, .arr_pos
+	vle8.v  v3, 0(t0)
+
+	/* Execute vabd.vv v2, v1, v3. */
+	.insn r 0x57, 0x2, 0x2b, x2, x3, x1
+
+	/* Load the expected result into v3. */
+	la      t0, .expect_vabd_vv
+	vle8.v  v3, 0(t0)
+
+	/* Compare v2 and v3 into v0 */
+	vmsne.vv  v0, v2, v3
+	vcpop.m a0, v0
+	snez    a0, a0
+
+	ret
+
+test_vabd_vv_mask:
+	/*
+	 * Test masked vabd.vv.  Element 0 remains 9 and element 1 becomes
+	 * abs(-7 - 7) = 14.
+	 */
+	vsetivli zero, 2, e8, m1, ta, mu
+
+	/* Load the two signed source vectors into v1 and v3. */
+	la      t0, .arr_neg
+	vle8.v  v1, 0(t0)
+	la      t0, .arr_pos
+	vle8.v  v3, 0(t0)
+
+	/* Load original value into v2 */
+	la      t0, .arr_init
+	vle8.v  v2, 0(t0)
+
+	/* Load mask value into v0 */
+	la      t0, .v0_mask
+	vle8.v  v0, 0(t0)
+
+	.insn r 0x57, 0x2, 0x2a, x2, x3, x1
+
+	/* Load the expected result into v3. */
+	la      t0, .expect_vabd_vv_masked
+	vle8.v  v3, 0(t0)
+
+	vmsne.vv  v0, v2, v3
+	vcpop.m a0, v0
+	snez    a0, a0
+	ret
+
+test_vabd_vx:
+	/*
+	 * Test signed vector-scalar absolute difference:
+	 * abs({-5, -7} - 3) = {8, 10}.
+	 */
+	vsetivli zero, 2, e8, m1, ta, mu
+	la      t0, .arr_neg
+	vle8.v  v1, 0(t0)
+	li      a2, 3
+
+	/* Execute vabd.vx v2, v1, a2. */
+	.insn r 0x57, 0x6, 0x2b, x2, x12, x1
+
+	/* Load the expected result into v3. */
+	la      t0, .expect_vabd_vx
+	vle8.v  v3, 0(t0)
+
+	vmsne.vv  v0, v2, v3
+	vcpop.m a0, v0
+	snez    a0, a0
+	ret
+
+test_vabd_vx_mask:
+	/*
+	 * Test masked vabd.vx.  Element 0 remains 9 and element 1 becomes
+	 * abs(-7 - 3) = 10.
+	 */
+	vsetivli zero, 2, e8, m1, ta, mu
+
+	la      t0, .arr_neg
+	vle8.v  v1, 0(t0)
+	li      a2, 3
+
+	la      t0, .arr_init
+	vle8.v  v2, 0(t0)
+
+	la      t0, .v0_mask
+	vle8.v  v0, 0(t0)
+
+	.insn r 0x57, 0x6, 0x2a, x2, x12, x1
+
+	la      t0, .expect_vabd_vx_masked
+	vle8.v  v3, 0(t0)
+
+	vmsne.vv  v0, v2, v3
+	vcpop.m a0, v0
+	snez    a0, a0
+	ret
+
+test_vabdu_vv:
+	/*
+	 * Test unsigned vector-vector absolute difference:
+	 * abs({0, 255} - {255, 0}) = {255, 255}.
+	 */
+	vsetivli zero, 2, e8, m1, ta, mu
+
+	/* Load the two unsigned source vectors into v1 and v3. */
+	la      t0, .arr_unsigned_lhs
+	vle8.v  v1, 0(t0)
+	la      t0, .arr_unsigned_rhs
+	vle8.v  v3, 0(t0)
+
+	/* Execute vabdu.vv v2, v1, v3. */
+	.insn r 0x57, 0x2, 0x2d, x2, x3, x1
+
+	/* Load the expected result into v3. */
+	la      t0, .expect_vabdu_vv
+	vle8.v  v3, 0(t0)
+
+	vmsne.vv  v0, v2, v3
+	vcpop.m a0, v0
+	snez    a0, a0
+	ret
+
+test_vabdu_vv_mask:
+	/*
+	 * Test masked vabdu.vv.  Element 0 remains 9 and element 1 becomes
+	 * abs(255 - 0) = 255.
+	 */
+	vsetivli zero, 2, e8, m1, ta, mu
+
+	la      t0, .arr_unsigned_lhs
+	vle8.v  v1, 0(t0)
+	la      t0, .arr_unsigned_rhs
+	vle8.v  v3, 0(t0)
+
+	la      t0, .arr_init
+	vle8.v  v2, 0(t0)
+
+	la      t0, .v0_mask
+	vle8.v  v0, 0(t0)
+
+	.insn r 0x57, 0x2, 0x2c, x2, x3, x1
+
+	la      t0, .expect_vabdu_vv_masked
+	vle8.v  v3, 0(t0)
+
+	vmsne.vv  v0, v2, v3
+	vcpop.m a0, v0
+	snez    a0, a0
+	ret
+
+test_vabdu_vx:
+	/*
+	 * Test unsigned vector-scalar absolute difference:
+	 * abs({0, 255} - 128) = {128, 127}.
+	 */
+	vsetivli zero, 2, e8, m1, ta, mu
+
+	la      t0, .arr_unsigned_lhs
+	vle8.v  v1, 0(t0)
+	li      a2, 128
+
+	/* Execute vabdu.vx v2, v1, a2. */
+	.insn r 0x57, 0x6, 0x2d, x2, x12, x1
+
+	la      t0, .expect_vabdu_vx
+	vle8.v  v3, 0(t0)
+
+	vmsne.vv  v0, v2, v3
+	vcpop.m a0, v0
+	snez    a0, a0
+	ret
+
+test_vabdu_vx_mask:
+	/*
+	 * Test masked vabdu.vx.  Element 0 remains 9 and element 1 becomes
+	 * abs(255 - 128) = 127.
+	 */
+	vsetivli zero, 2, e8, m1, ta, mu
+
+	la      t0, .arr_unsigned_lhs
+	vle8.v  v1, 0(t0)
+	li      a2, 128
+
+	la      t0, .arr_init
+	vle8.v  v2, 0(t0)
+
+	la      t0, .v0_mask
+	vle8.v  v0, 0(t0)
+
+	.insn r 0x57, 0x6, 0x2c, x2, x12, x1
+
+	la      t0, .expect_vabdu_vx_masked
+	vle8.v  v3, 0(t0)
+
+	vmsne.vv  v0, v2, v3
+	vcpop.m a0, v0
+	snez    a0, a0
+	ret
+
+test_vwabda_vv:
+	/*
+	 * Test signed widening vector-vector absolute difference and
+	 * accumulation. Start with v4 = {1000, -1000}, and the expected
+	 * widened result is {1000, -1000} + abs({-5, -7} - {5, 7}) =
+	 * {1010, -986}.
+	 */
+	/* Load the 16-bit accumulator before selecting 8-bit operands. */
+	vsetivli zero, 2, e16, m2, ta, mu
+	la      t0, .arr_signed_acc
+	vle16.v v4, 0(t0)
+
+	vsetivli zero, 2, e8, m1, ta, mu
+	la      t0, .arr_neg
+	vle8.v  v1, 0(t0)
+	la      t0, .arr_pos
+	vle8.v  v2, 0(t0)
+
+	/* Execute vwabda.vv v4, v1, v2. */
+	.insn r 0x57, 0x0, 0x7b, x4, x2, x1
+
+	/* Select the widened EEW and compare v4 with the expected result. */
+	vsetivli zero, 2, e16, m2, ta, mu
+	la      t0, .expect_vwabda_vv
+	vle16.v v6, 0(t0)
+
+	vmsne.vv  v0, v4, v6
+	vcpop.m a0, v0
+	snez    a0, a0
+	ret
+
+test_vwabda_vv_mask:
+	/*
+	 * Test masked vwabda.vv.
+	 * Start with v4 = {1000, -1000}, v0 = {0, 1}, and the expected widened
+	 * result is {1000, -1000} + abs({-5, -7} - {5, 7}) = {1000, -986}.
+	 */
+	vsetivli zero, 2, e16, m2, ta, mu
+	la      t0, .arr_signed_acc
+	vle16.v v4, 0(t0)
+
+	vsetivli zero, 2, e8, m1, ta, mu
+	la      t0, .arr_neg
+	vle8.v  v1, 0(t0)
+	la      t0, .arr_pos
+	vle8.v  v2, 0(t0)
+
+	la      t0, .v0_mask
+	vle8.v  v0, 0(t0)
+
+	.insn r 0x57, 0x0, 0x7a, x4, x2, x1
+
+	vsetivli zero, 2, e16, m2, ta, mu
+	la      t0, .expect_vwabda_vv_masked
+
+	vle16.v v6, 0(t0)
+	vmsne.vv  v0, v4, v6
+	vcpop.m a0, v0
+	snez    a0, a0
+	ret
+
+test_vwabda_vx:
+	/*
+	 * Test signed widening vector-scalar absolute difference and
+	 * accumulation. With scalar 3, v4 becomes {1000 + 8, -1000 + 10}.
+	 */
+	/* Load the 16-bit accumulator before selecting 8-bit operands. */
+	vsetivli zero, 2, e16, m2, ta, mu
+	la      t0, .arr_signed_acc
+	vle16.v v4, 0(t0)
+
+	vsetivli zero, 2, e8, m1, ta, mu
+	la      t0, .arr_neg
+	vle8.v  v1, 0(t0)
+	li      a2, 3
+
+	/* Execute vwabda.vx v4, v1, a2. */
+	.insn r 0x57, 0x4, 0x7b, x4, x12, x1
+
+	/* Select the widened EEW and compare v4 with the expected result. */
+	vsetivli zero, 2, e16, m2, ta, mu
+	la      t0, .expect_vwabda_vx
+	vle16.v v6, 0(t0)
+
+	vmsne.vv  v0, v4, v6
+	vcpop.m a0, v0
+	snez    a0, a0
+	ret
+
+test_vwabda_vx_mask:
+	/*
+	 * Test masked vwabda.vx.  Element 0 remains 1000 while element 1
+	 * accumulates 10 and becomes -990.
+	 */
+	vsetivli zero, 2, e16, m2, ta, mu
+
+	la      t0, .arr_signed_acc
+	vle16.v v4, 0(t0)
+
+	vsetivli zero, 2, e8, m1, ta, mu
+	la      t0, .arr_neg
+	vle8.v  v1, 0(t0)
+	li      a2, 3
+
+	la      t0, .v0_mask
+	vle8.v  v0, 0(t0)
+
+	.insn r 0x57, 0x4, 0x7a, x4, x12, x1
+
+	vsetivli zero, 2, e16, m2, ta, mu
+	la      t0, .expect_vwabda_vx_masked
+	vle16.v v6, 0(t0)
+
+	vmsne.vv  v0, v4, v6
+	vcpop.m a0, v0
+	snez    a0, a0
+	ret
+
+test_vwabdau_vv:
+	/*
+	 * Test unsigned widening vector-vector absolute difference and
+	 * accumulation. Start with v4 = {1000, 2000}, adding {255, 255}
+	 * produces {1255, 2255}.
+	 */
+	/* Load the unsigned 16-bit accumulator and 8-bit source vectors. */
+	vsetivli zero, 2, e16, m2, ta, mu
+
+	la      t0, .arr_unsigned_acc
+	vle16.v v4, 0(t0)
+	vsetivli zero, 2, e8, m1, ta, mu
+
+	la      t0, .arr_unsigned_lhs
+	vle8.v  v1, 0(t0)
+	la      t0, .arr_unsigned_rhs
+	vle8.v  v2, 0(t0)
+
+	/* Execute vwabdau.vv v4, v1, v2. */
+	.insn r 0x57, 0x0, 0x7d, x4, x2, x1
+
+	/* Select the widened EEW and compare v4 with the expected result. */
+	vsetivli zero, 2, e16, m2, ta, mu
+	la      t0, .expect_vwabdau_vv
+	vle16.v v6, 0(t0)
+
+	vmsne.vv  v0, v4, v6
+	vcpop.m a0, v0
+	snez    a0, a0
+	ret
+
+test_vwabdau_vv_mask:
+	/*
+	 * Test masked vwabdau.vv.  Element 0 remains 1000 while element 1
+	 * accumulates 255 and becomes 2255.
+	 */
+	vsetivli zero, 2, e16, m2, ta, mu
+
+	la      t0, .arr_unsigned_acc
+	vle16.v v4, 0(t0)
+
+	vsetivli zero, 2, e8, m1, ta, mu
+	la      t0, .arr_unsigned_lhs
+	vle8.v  v1, 0(t0)
+	la      t0, .arr_unsigned_rhs
+	vle8.v  v2, 0(t0)
+
+	la      t0, .v0_mask
+	vle8.v  v0, 0(t0)
+
+	.insn r 0x57, 0x0, 0x7c, x4, x2, x1
+
+	vsetivli zero, 2, e16, m2, ta, mu
+	la      t0, .expect_vwabdau_vv_masked
+	vle16.v v6, 0(t0)
+
+	vmsne.vv  v0, v4, v6
+	vcpop.m a0, v0
+	snez    a0, a0
+	ret
+
+test_vwabdau_vx:
+	/*
+	 * Test unsigned widening vector-scalar absolute difference and
+	 * accumulation. With scalar 128, v4 becomes {1000 + 128, 2000 + 127}.
+	 */
+	/* Load the unsigned 16-bit accumulator and 8-bit source vector. */
+	vsetivli zero, 2, e16, m2, ta, mu
+
+	la      t0, .arr_unsigned_acc
+	vle16.v v4, 0(t0)
+
+	vsetivli zero, 2, e8, m1, ta, mu
+	la      t0, .arr_unsigned_lhs
+	vle8.v  v1, 0(t0)
+	li      a2, 128
+
+	/* Execute vwabdau.vx v4, v1, a2. */
+	.insn r 0x57, 0x4, 0x7d, x4, x12, x1
+
+	/* Select the widened EEW and compare v4 with the expected result. */
+	vsetivli zero, 2, e16, m2, ta, mu
+	la      t0, .expect_vwabdau_vx
+	vle16.v v6, 0(t0)
+
+	vmsne.vv  v0, v4, v6
+	vcpop.m a0, v0
+	snez    a0, a0
+	ret
+
+test_vwabdau_vx_mask:
+	/*
+	 * Test masked vwabdau.vx.  Element 0 remains 1000 while element 1
+	 * accumulates 127 and becomes 2127.
+	 */
+	vsetivli zero, 2, e16, m2, ta, mu
+
+	la      t0, .arr_unsigned_acc
+	vle16.v v4, 0(t0)
+
+	vsetivli zero, 2, e8, m1, ta, mu
+	la      t0, .arr_unsigned_lhs
+	vle8.v  v1, 0(t0)
+	li      a2, 128
+
+	la      t0, .v0_mask
+	vle8.v  v0, 0(t0)
+
+	.insn r 0x57, 0x4, 0x7c, x4, x12, x1
+
+	vsetivli zero, 2, e16, m2, ta, mu
+	la      t0, .expect_vwabdau_vx_masked
+	vle16.v v6, 0(t0)
+
+	vmsne.vv  v0, v4, v6
+	vcpop.m a0, v0
+	snez    a0, a0
+	ret
+
+
+/* Exit through the semihosting SYS_EXIT_EXTENDED call with a0 as the code. */
+_exit:
+	la	a1, semiargs
+	li	t0, 0x20026	/* ADP_Stopped_ApplicationExit */
+	sd	t0, 0(a1)
+	sd	a0, 8(a1)
+	li	a0, 0x20	/* TARGET_SYS_EXIT_EXTENDED */
+	.balign	16
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+	j	.
+
+	.balign	4
+trap_handler:
+	csrr	t4, mcause
+	la	t5, trap_mcause
+	sd	t4, 0(t5)
+	csrr	t4, mtval
+	la	t5, trap_mtval
+	sd	t4, 0(t5)
+	li	a0, 1
+	j	_exit
+
+	.data
+	.balign	8
+semiargs:
+	.space	16
+trap_mcause:
+	.space	8
+trap_mtval:
+	.space	8
+.arr_neg:
+	.byte -5, -7
+.arr_pos:
+	.byte 5, 7
+.arr_zero:
+	.byte 0, 0
+.arr_init:
+	.byte 9, 9
+.v0_mask:
+	.byte 0b10
+.arr_masked:
+	.byte 0, 7
+
+/* Unsigned input vectors used by vabdu and vwabdau. */
+.arr_unsigned_lhs:
+	.byte 0, 255
+.arr_unsigned_rhs:
+	.byte 255, 0
+	.balign 2
+
+/* Nonzero accumulators verify the add part of widening operations. */
+.arr_signed_acc:
+	.half 1000, -1000
+.arr_unsigned_acc:
+	.half 1000, 2000
+
+/* Expected results for the unmasked and masked forms. */
+.expect_vabd_vv:
+	.byte 10, 14
+.expect_vabd_vv_masked:
+	.byte 9, 14
+.expect_vabd_vx:
+	.byte 8, 10
+.expect_vabd_vx_masked:
+	.byte 9, 10
+.expect_vabdu_vv:
+	.byte 255, 255
+.expect_vabdu_vv_masked:
+	.byte 9, 255
+.expect_vabdu_vx:
+	.byte 128, 127
+.expect_vabdu_vx_masked:
+	.byte 9, 127
+.expect_vwabda_vv:
+	.half 1010, -986
+.expect_vwabda_vv_masked:
+	.half 1000, -986
+.expect_vwabda_vx:
+	.half 1008, -990
+.expect_vwabda_vx_masked:
+	.half 1000, -990
+.expect_vwabdau_vv:
+	.half 1255, 2255
+.expect_vwabdau_vv_masked:
+	.half 1000, 2255
+.expect_vwabdau_vx:
+	.half 1128, 2127
+.expect_vwabdau_vx_masked:
+	.half 1000, 2127
-- 
2.55.0


