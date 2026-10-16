Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDDECCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWMo-00017P-Ji; Thu, 15 Oct 2026 21:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWLd-0000HS-NC
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:03:02 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWLb-0004DO-SW
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:03:01 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-ccc6b11a19aso2711200a12.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112578; x=1792717378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5bWcx/UGf2i1mCwxyd6PsqVmcj0rzyTv/2h3MvckpzQ=;
 b=TJ+8hcvqLCWLFLSAkHSw/Qa5KBjpkT0UXJ9lJftTciCc/rWyCyw9lD5TOoO6g9ol+k
 YBShpeqyz33xRpJhvV9vMvMgJ5lhB5pqrcMjRJXeWDkva/+cAWd2SSWzx/RTZSvey5Tq
 YDIr2csUOuRBruWWqBe7XrrNBnzveOG9Drp1xdeRc198whv0gITNz37iC/xXrTLrthh3
 I5w4GjiCylt4gzvarvtB0+5M5F+02H3I8F2YDHt3ZqdjeUJTvGnm16YlwEzLGt7L8jLJ
 5OCJTdFB21+gdesHjMmINKfcWwn1p1M25fHjwq1IsrhoRXiAeCTkGzM1uJ7SJxka0bAQ
 OEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112578; x=1792717378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5bWcx/UGf2i1mCwxyd6PsqVmcj0rzyTv/2h3MvckpzQ=;
 b=1Gvb05zJ87l+kyEz7T9gkBTjEnVwYd5KdSXe3PR5UQTEErkqSAakFT0j1G4UJ9tWpq
 ebygYXWKuCqkfuBrQBwznoQRRQBPqxIajDh3AcJh3GR01d4edrmhiDx/XgqpLIrEc14i
 F4D7mPxsYTxrLFRP0/E629j93cjNJ82V9dJK/nFGVMR6fj/r/dMJkyOTLl03ihZOf2Fi
 v2gZCRCs13ZtqI83N2Sc5T2mx/zpOU34O009hfRzygb+IM0BigmaJjiSRPFxiNNjCPbQ
 Dh8Ugl6wvLqkuOjk7ah1Www6IaATxfaq2/CTrfRIOuE3QZH1fpWTXFL5HqUPwC2Q6b/V
 XxDg==
X-Gm-Message-State: AFq9FYKRjB07TlPQfC0aJSwy0NCz/RU3lcMYXWDIiV0wOlayscuifBnL
 VXTi6vejwOhQO8rpHEBax0++ZAjuIpMuvW6sqOPFSZIW8NvGppmxRE5FegJv9g==
X-Gm-Gg: AYBFou3IZ4XrY9KRUA2vF1yU+fmOi9gdup6Nk3gLJQExKFhAAAieAfMSM6Jogi7h1UY
 Gz0o4aVvSBkPzTVkfZMuUKNKnuurHL2MGEsL2EwwZz+cIRUEhDRCmH18qz8BhmH3R6bkNtVJd08
 VG+gIcWab8/vrou5NIFSeJ266U7fpCeozHPCKAQ1T3qVeS30oPMEObJ82BtG4vmYWt09JFhUDtC
 YG8D+4CB3Xkk8oDimiJhp0IgqccqP2bI30VW9bakfcesi17Zob1bC67+uTkAbQorsbUf8WQB3H0
 ViN5HykQ2cuEH/1TM7HrS1Pl/nZWj6igmxzTUvGoMf3TMoqYLwIwkoWJ7rYqZSzkFbEOVGrqvVP
 Hsg5IrjsYHVMrGnH09PsYhRRBdcwUjNfIgD8qcnpWVLh/cUfx/4IpykpeS59LAGbjriMCWQbDZM
 HNNP961YlpMDVA7DagxZAycsk1+GIB8pzCTQBnP+nL1gfvVJPJaDwNreUk5kQvRm6RO99YyolS9
 86DAFMM03B50Ic5LA==
X-Received: by 2002:a17:902:ce91:b0:2df:90d4:7758 with SMTP id
 d9443c01a7336-2e8428a1f32mr171801625ad.23.1792112578204; 
 Thu, 15 Oct 2026 18:02:58 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.02.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:02:57 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Zephyr Li <fritchleybohrer@gmail.com>, qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 04/50] target/riscv: stop translating after WFI
Date: Fri, 16 Oct 2026 11:01:51 +1000
Message-ID: <20261016010237.1102834-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Zephyr Li <fritchleybohrer@gmail.com>

helper_wfi() never returns to translated code: it either raises an
exception or exits the CPU loop after marking the CPU as halted. However,
trans_wfi() leaves the translation state as DISAS_NEXT, so instructions
following WFI can be included in the same TB.

With icount enabled, this makes the following instruction part of the TB's
instruction count when WFI exits, causing minstret to be incremented once
too many. Set DISAS_NORETURN after emitting the helper.

Add a TCG test for both reported cases: WFI waking for a locally enabled
pending interrupt with mstatus.MIE clear, and WFI taking a timer interrupt.

Cc: qemu-stable@nongnu.org
Fixes: 55c2a12cbcd3 ("RISC-V TCG Code Generation")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4230
Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260910025324.54990-1-fritchleybohrer@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 .../tcg/insn_trans/trans_privileged.c.inc     |   1 +
 tests/tcg/riscv64/system/meson.build          |   1 +
 tests/tcg/riscv64/test-minstret-wfi.S         | 100 ++++++++++++++++++
 3 files changed, 102 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-minstret-wfi.S

diff --git a/target/riscv/tcg/insn_trans/trans_privileged.c.inc b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
index a8eaccef67..ebbbb01179 100644
--- a/target/riscv/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
@@ -145,6 +145,7 @@ static bool trans_wfi(DisasContext *ctx, arg_wfi *a)
     decode_save_opc(ctx, 0);
     gen_update_pc(ctx, ctx->cur_insn_len);
     gen_helper_wfi(tcg_env);
+    ctx->base.is_jmp = DISAS_NORETURN;
     return true;
 #else
     return false;
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index c2d7d09887..a632674832 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -23,6 +23,7 @@ tests += {
   'test-mepc-masking.S': setup,
   'test-crc32.S': setup + {'qemu_args': ['-cpu', 'rv64,xlrbr=true', qemu_args]},
   'test-minstret-ecall.S': setup + {'qemu_args': ['-icount', 'shift=1', qemu_args]},
+  'test-minstret-wfi.S': setup + {'qemu_args': ['-icount', 'shift=1', qemu_args]},
   'test-misa-w.S': setup + {'qemu_args': ['-cpu', 'rv64,x-misa-w=true,c=true,v=true', qemu_args]},
 }
 
diff --git a/tests/tcg/riscv64/test-minstret-wfi.S b/tests/tcg/riscv64/test-minstret-wfi.S
new file mode 100644
index 0000000000..0fd0158d5b
--- /dev/null
+++ b/tests/tcg/riscv64/test-minstret-wfi.S
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+	.option	norvc
+
+	.text
+	.global	_start
+_start:
+	lla	t0, trap
+	csrw	mtvec, t0
+	li	s3, 0
+
+	/*
+	 * A pending, locally enabled interrupt wakes WFI even with MIE
+	 * clear.
+	 */
+	li	t0, 0x8		/* MIE_MSIE */
+	csrw	mie, t0
+	csrci	mstatus, 0x8	/* MSTATUS_MIE */
+	li	t0, 0x2000000	/* MSIP0 */
+	li	t1, 1
+	sw	t1, 0(t0)
+
+	/*
+	 * The first CSR read and WFI retire before the second read obtains s1,
+	 * so the expected difference is two.
+	 */
+	csrr	s0, minstret
+	wfi
+	csrr	s1, minstret
+	sub	s1, s1, s0
+	li	t1, 2
+	beq	s1, t1, 1f
+	ori	s3, s3, 1
+1:
+
+	/* Clear the software interrupt before testing the trap path. */
+	sw	zero, 0(t0)
+	csrw	mie, zero
+
+	/* Schedule a timer interrupt far enough ahead to reach WFI first. */
+	li	t0, 0x200bff8	/* MTIME */
+	ld	t1, 0(t0)
+	addi	t1, t1, 100
+	li	t0, 0x2004000	/* MTIMECMP0 */
+	sd	t1, 0(t0)
+	li	t0, 0x80		/* MIE_MTIE */
+	csrw	mie, t0
+	csrsi	mstatus, 0x8	/* MSTATUS_MIE */
+
+	/*
+	 * The first CSR read and WFI retire before the trap handler obtains s1,
+	 * so the expected difference is again two.
+	 */
+	li	s2, 1
+	csrr	s0, minstret
+	wfi
+	beqz	s2, 1f
+	ori	s3, s3, 2
+1:
+	bnez	s3, fail
+	li	a0, 0
+	j	_exit
+
+fail:
+	mv	a0, s3
+
+_exit:
+	lla	a1, semiargs
+	li	t0, 0x20026	/* ADP_Stopped_ApplicationExit */
+	sd	t0, 0(a1)
+	sd	a0, 8(a1)
+	li	a0, 0x20	/* TARGET_SYS_EXIT_EXTENDED */
+
+	/* Semihosting call sequence */
+	.balign	16
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+	j	.
+
+	.balign	4
+trap:
+	/* Read minstret before retiring an instruction in the handler. */
+	csrr	s1, minstret
+	sub	s1, s1, s0
+	addi	s1, s1, -2
+	snez	s2, s1
+
+	/* Disable the timer interrupt before returning past WFI. */
+	li	t0, 0x2004000	/* MTIMECMP0 */
+	li	t1, -1
+	sd	t1, 0(t0)
+	li	t0, 0x80		/* MIE_MTIE */
+	csrc	mie, t0
+	mret
+
+	.data
+	.balign	16
+semiargs:
+	.space	16
-- 
2.55.0


