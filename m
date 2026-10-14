Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D43CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpqI-0004v6-BZ; Tue, 13 Oct 2026 23:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpq6-0004qX-UX
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:39:40 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpq4-0001Lm-Mn
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:39:38 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so1867425a91.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949175; x=1792553975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5bWcx/UGf2i1mCwxyd6PsqVmcj0rzyTv/2h3MvckpzQ=;
 b=rJtdxL3eIM4RQM7sVlz9qpLKcJoQCqMtqKFPt+szTgv8PiXXoVf7Amfw1cl0O3ZJ2x
 0ysFXmfFk21perjQDnkEgg3uCETLs1zzJuoCXwCMw0yJbuYTPwCTCbcB4OsqtWaoW66y
 aVz9YwD/LbCl7slwP2X7/p09Sm1heLQjc0rUl/lfrQcpveqfLKjPmq6jMemhZYBskWN6
 PjrNovyFBm0UlYTzejZrKaJkHZapNJUAcfZatYROPzkbum9euW8W0TSsjIXo4qHgq2Tq
 l7Bw89SZYv4GrptN41Q1IfVWqvUy9yb+Vblc/01eu8LPfeUfU2Mu9gHEz9+wyDDdTWku
 /Ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949175; x=1792553975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5bWcx/UGf2i1mCwxyd6PsqVmcj0rzyTv/2h3MvckpzQ=;
 b=0yHJ9awS3gR8LNvOWwjpozQnxQst+f/HR/BsOg7MNZpagJ02L3aJxPp1k00Qih+e7G
 p1VbLdJJ+azns4NpCQXxtgcMtMhGQi/y0ODbU48r3xajnj5xYV1KLk2jjc/ezCPHMxjw
 3vc2PDkRI0xKi/DqrT0YzlUeIqaAlHqO8eJZ1UZ1wUDsNzakzpXM62a+GMQFPo6YOVHB
 hJFN59lTVyrNjhVuoBr3krCwvWEVw0z5golnJjp7M0Cv1M27mmLhYfhxlrQvOPzbsyzV
 kyYs5KWt3ENE0w/+vXEyBAlJqC5YB84XfopjCwC4TGLe/MnLQwrc1go2SwjVZ1rj1HxY
 7uBg==
X-Gm-Message-State: AFq9FYJ7E+iS9xQd36lyjQS3iqoNY0AdRCDmQmLYqLrQjVWIfRO29u6f
 P9GIAD6vV0/5s5V3NEw97jA8JJijryfSqzf4dIDkRnijVABe7tFZ+qX16c2r7A==
X-Gm-Gg: AYBFou1yMvGlp3aVjvAsOLpWr6TfBJplXAUaCfLzhVSqfuGDHch9NH8bD5v3l9R4aRB
 NgTt7BilVz2yhfX9Td/U54q0g0HnElH2Am7bPX6dTYyu7HbanXrH6MeT5DXAotxeAjxL0VzSvXh
 +SPcYstBi34dDVIfd/ox3HUNJ2drP+EsT49F7z8Sx/gv6rVd/hrRHMhoMs7O2UxtoC+xyhJtSS4
 2mJHhmhroilm5tQuIs2m9BFNzbZPxu7NWxFJW7QfKFJxsZe7CIg8LbJJt4sR7DF04Q862PAC9ZP
 WpNytOuantpwCW+SAri4FH/MFek2tkSahk7fi0rPYgmUHPuWXNIOpNSmuon/U6hV6Xk+fS0gz93
 PeN5Z3rtZFjRyd7P6OCo9EpN+ZJOZFbGanmod4kUZs0h5RLRWY7DulO5gRvp1hc6WMA36X1leen
 72iPCBOwZQ1SToIal8CbFGgYCGluIdFPK5dwiZGEnnjCd7uMFgWLKoGm6ELxOIy0MRds6XE5c+J
 /RMgd+KD1PwAB/o
X-Received: by 2002:a17:90a:d2ce:b0:39d:e54c:8658 with SMTP id
 98e67ed59e1d1-3ab3a364f7emr11790899a91.5.1791949175249; 
 Tue, 13 Oct 2026 20:39:35 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:39:34 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Zephyr Li <fritchleybohrer@gmail.com>, qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 04/52] target/riscv: stop translating after WFI
Date: Wed, 14 Oct 2026 13:38:19 +1000
Message-ID: <20261014033907.3332383-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1036.google.com
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


