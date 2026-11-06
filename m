Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268B1606A31B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 03:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qDXAg2Yj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPAk3-0007IS-Gl; Thu, 05 Nov 2026 22:35:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1xPAjk-0007Gs-2L
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 22:35:38 -0500
Received: from mail-pj2-x0b.google.com ([2607:f8b0:4864:39::b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1xPAjg-0002Sn-RG
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 22:35:30 -0500
Received: by mail-pj2-x0b.google.com with SMTP id
 98e67ed59e1d1-3ada6c66964so56840a91.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 19:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793936126; x=1794540926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YIS+E3+btsO7UDQMTWL1Mt9cbImZr5tSnx37CZOyCmA=;
 b=qDXAg2YjAuUEElAo7Sxs4qTAsBULh2bD1WSneMM1h9rraCB3HTA9nPdSMAis3Gc8TT
 DRbf/aSnWfPnz2lEXtL2nwV1hFbwTUkWJGeYGF2n1B3ETW6RIC5TgVTES23PcUIgDGOg
 7vo0hlakHVJ0fMzbNANOMqOlFfuTqYQ1Q83DUUDDTbo28iaft0PgUvpoAnOVKTFnI8Al
 STty6YEKCYM0zQPGr4V28XwcTHq12W9ujEwqEBA9rqBgVP8J0XlOhTGklc2YrcGPmuB+
 QQPa/gmezJvmK0s6X3kEaL3DdssX0sx2VmBiJKk6MBVMtRHr+kbNQBdOK5At4rCTC+PF
 tZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793936126; x=1794540926;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YIS+E3+btsO7UDQMTWL1Mt9cbImZr5tSnx37CZOyCmA=;
 b=KWnY2N27NH6luNzi5T2wgU2hLfJmC6TBQm2EnE50G02iQU/rw9Db/GhUmK6occsQL3
 FKADmmGIZ4qiygBEp2FJ0t8bL63U6yqMus0rtQrVCYBjMvq+KOEKuwftV9CjpHth6w6c
 30Btn8WCoiDL4Tv98112rzZ9aaxoQLcFVM/o2Sb0jHSwApKDEHSIXonxIrxlHci0kAbk
 Wc5HFKi3jhWrVisIlgEhWTBobZE1fVJm85A5yRG1uNH2jZer68WSJYJj0r2zYm9qbX74
 qA6SdQ4YhoT69qMGCU4bdwA+udEMg4lLJexhitk08jWGqc2Jgr3wr23EqlMYuyErWCm1
 4ImQ==
X-Gm-Message-State: APuU4Z9FkTwdhMwD+PKu/anZ7pZboJZyxiR//02HZJxEzFYN/pRRXbFA
 BQadyT0TPlV0VX5+LzF8X6ljh5ktybmz2BspIRHSqZySjNoyz0OHJyZrRYsmvJrCwHwSFl7W
X-Gm-Gg: AYBFou0owWnF7mEDQSZ4w7XgGVuECWyaST39f/eTF3zrfhKH3SxebIEOfQ357Scz7Vs
 7YHPAjm0IMO2JiBmHvwokYNiBo1xiGVUYw7sLmhuA6+4q7D0zOEZV4yR5/Tk2EaOOGQq1yVNfB1
 W5o2IdrjvOBQVnUehS4Bb/IdtJLm3NXZ+Tli0cHrQFC/gxC2yZv5y6ayysWBbVagJFhgxjpFweq
 B1aqkA26td3kySbwgOoNTiYIyOcdEn0iVkfQHGq+AiAAnjeX2psePNTtn4PGjHjWnYfzKmcgqMI
 81aVilyLjN3IMLnLtJA/2cbUotqoxDOXTTie7+/ZbTm45tyaaR7Jh5QhxnqPiIZIeSYiKSs+vAC
 Jdf3dqnzs6EyRkb/E/yE0HtuBdNMI0vzP5hLdZP4eSi11zZlfNqsZJWOBKYWJkThxB6mGq25hjm
 3W4eD1VBDQLr6+EMLKUOUgjyaLPogcEc25OY+vpTZh5PRit0cdyFFTpuQuBL2rDZnR3M4d0QwjR
 XJg2Mf0CVSmzgQNwWO+PfiAKqxnOftUIZViir+1niN58AUFi6/RAt/3nJUjeI0lVRmd1Y5/G8l7
 Jvezat8Vdd+SM8/kFWmnvntFdNPOFZNJrkNIyLCHgaUeRgKorehf8b4J
X-Received: by 2002:a17:90b:1802:b0:3ac:80dc:f407 with SMTP id
 98e67ed59e1d1-3b0db71871fmr1157519a91.60.1793936125863; 
 Thu, 05 Nov 2026 19:35:25 -0800 (PST)
Received: from Dell-WorkStation.localdomain ([152.175.67.81])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b32b6507sm6552930a91.16.2026.11.05.19.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 19:35:25 -0800 (PST)
From: Zephyr Li <fritchleybohrer@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Zephyr Li <fritchleybohrer@gmail.com>
Subject: [PATCH v2] target/riscv: report WRS.NTO opcode in tval on illegal
 instruction
Date: Fri,  6 Nov 2026 11:34:57 +0800
Message-ID: <20261106033457.79020-1-fritchleybohrer@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::b;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-pj2-x0b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

helper_wrs_nto() may raise an illegal or virtual-instruction exception.
However, trans_wrs_nto() does not save the decoded opcode before calling
the helper. As a result, exception unwinding leaves env->bins stale and
trap handling reports an incorrect value in tval.

Call decode_save_opc() before the helper so the faulting instruction
encoding is restored for trap handling.

Add a TCG test that delegates the mstatus.TW-triggered illegal-instruction
exception to S-mode and checks scause, sepc and stval.

Fixes: b62e0ce76098 ("target/riscv: Raise exceptions on wrs.nto")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4080
Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
---
Changes in v2:
- Rebase onto current master.
- Register the test in tests/tcg/riscv64/system/meson.build instead
  of the removed Makefile.softmmu-target.

 .../riscv/tcg/insn_trans/trans_rvzawrs.c.inc  |  2 +
 tests/tcg/riscv64/system/meson.build          |  1 +
 tests/tcg/riscv64/test-zawrs-stval.S          | 87 +++++++++++++++++++
 3 files changed, 90 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-zawrs-stval.S

diff --git a/target/riscv/tcg/insn_trans/trans_rvzawrs.c.inc b/target/riscv/tcg/insn_trans/trans_rvzawrs.c.inc
index 0eef033838..ecebec0eef 100644
--- a/target/riscv/tcg/insn_trans/trans_rvzawrs.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvzawrs.c.inc
@@ -54,6 +54,8 @@ static bool trans_wrs_nto(DisasContext *ctx, arg_wrs_nto *a)
      * exception, as handled by the wrs.nto helper.
      */
 #ifndef CONFIG_USER_ONLY
+    /* Save the opcode in case the helper raises an exception. */
+    decode_save_opc(ctx, 0);
     gen_helper_wrs_nto(tcg_env);
 #endif
 
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index 3c8b018d9e..d1cbd1b97d 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -21,6 +21,7 @@ tests += {
   'interruptedmemory.S': setup + {'plugin_test': {'plugin': 'discons'}},
   'issue1060.S': setup,
   'test-mepc-masking.S': setup,
+  'test-zawrs-stval.S': setup + {'qemu_args': ['-cpu', 'max', qemu_args]},
   'test-crc32.S': setup + {'qemu_args': ['-cpu', 'rv64,xlrbr=true', qemu_args]},
   'test-minstret-ecall.S': setup + {'qemu_args': ['-icount', 'shift=1', qemu_args]},
   'test-minstret-wfi.S': setup + {'qemu_args': ['-icount', 'shift=1', qemu_args]},
diff --git a/tests/tcg/riscv64/test-zawrs-stval.S b/tests/tcg/riscv64/test-zawrs-stval.S
new file mode 100644
index 0000000000..42a9901fa6
--- /dev/null
+++ b/tests/tcg/riscv64/test-zawrs-stval.S
@@ -0,0 +1,87 @@
+/*
+ * Test that WRS.NTO writes the instruction encoding to stval when
+ * mstatus.TW causes an illegal-instruction exception in S-mode.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+	.option	norvc
+
+	.text
+	.global	_start
+_start:
+	/* Unexpected traps to M-mode fail the test. */
+	lla	t0, machine_trap
+	csrw	mtvec, t0
+
+	/* Delegate illegal-instruction exceptions to S-mode. */
+	li	t0, 1 << 2
+	csrs	medeleg, t0
+
+	lla	t0, supervisor_trap
+	csrw	stvec, t0
+
+	/* Give S-mode read, write and execute access to all memory. */
+	li	t0, -1
+	csrw	pmpaddr0, t0
+	li	t0, 0xf
+	csrw	pmpcfg0, t0
+
+	/* Set mstatus.TW and select S-mode for mret. */
+	li	t0, 3 << 11
+	csrc	mstatus, t0
+	li	t0, (1 << 21) | (1 << 11)
+	csrs	mstatus, t0
+
+	lla	t0, supervisor_start
+	csrw	mepc, t0
+	mret
+
+supervisor_start:
+	/* WRS.NTO must trap because mstatus.TW is set. */
+	li	a0, 1
+wrs_nto:
+	.word	0x00d00073
+	j	_exit
+
+machine_trap:
+	li	a0, 2
+	j	_exit
+
+supervisor_trap:
+	li	a0, 3
+
+	csrr	t0, scause
+	li	t1, 2
+	bne	t0, t1, _exit
+
+	csrr	t0, sepc
+	lla	t1, wrs_nto
+	bne	t0, t1, _exit
+
+	csrr	t1, stval
+	lwu	t2, 0(t0)
+	bne	t1, t2, _exit
+	li	t2, 0x00d00073
+	bne	t1, t2, _exit
+
+	li	a0, 0
+
+_exit:
+	lla	a1, semiargs
+	li	t0, 0x20026	/* ADP_Stopped_ApplicationExit */
+	sd	t0, 0(a1)
+	sd	a0, 8(a1)
+	li	a0, 0x20	/* TARGET_SYS_EXIT_EXTENDED */
+
+	/* Semihosting call sequence. */
+	.balign	16
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+	j	.
+
+	.data
+	.balign	16
+semiargs:
+	.space	16
-- 
2.43.0


