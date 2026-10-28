Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407A1606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=theorem-dev.20260707.gappssmtp.com header.i=@theorem-dev.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tksf7pNm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM9qb-0001d1-1h; Wed, 28 Oct 2026 16:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tewaro@theorem.dev>)
 id 1xM9qI-0001Yx-QM
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:02:02 -0400
Received: from mail-dl1-x122c.google.com ([2607:f8b0:4864:20::122c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tewaro@theorem.dev>)
 id 1xM9qG-0000qP-BF
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:01:50 -0400
Received: by mail-dl1-x122c.google.com with SMTP id
 a92af1059eb24-18cdcfc05ffso1991060c88.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=theorem-dev.20260707.gappssmtp.com; s=20260707; t=1793217705; x=1793822505;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XFu5zti7tL4VDp3C7aZKO6im+z/DBesDhXTe4RzRUoo=;
 b=tksf7pNmyvb4zdiPDmup44I9tE5kHKRTW6L4qdpF26YnQQ3LcoR870vWfV8O4BFqL/
 aRM7q6YfJwhI2D9XFVTPGs02bFzkrTcEZmIflY0RJVdh5Qbcg706W/ntfIz1J3ni05yF
 oryMM+7ln+jbFWsQpPUHWQrA7VIoTZ9au0IMKmU83Zi3U7OgEbOsc5o1GR1dbdL0Y0C2
 +pAe9TP9TdvQKMu9eDvxmeT2R0OpjA6vWnnp6C3fbqAokfUa21pSCQPbcRvid/K2FhF/
 xvy5EuMllbq/MTp7Qd8LDIJ+r1PXhM0Jll9YM1Dcm4EVS8T/4+wQ1WnwOzAW96JmWPp9
 Xj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793217705; x=1793822505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XFu5zti7tL4VDp3C7aZKO6im+z/DBesDhXTe4RzRUoo=;
 b=ft0CwD2vAnOF76xNlbrAqu71dcFml70/FiYVTJAFZ5/kUsREsvoK2gFb38VuyDuPjE
 Dnj9RWsLa0YyVX84h8WoptcL0qDQiypM4HjD2iODSW9PKpjcVNxdGFYOa1guyehqkCc5
 ix5jGeJ/YovBNKvMDP74YOyEicxGbe/2+lXvgMBXqilL/fL9XiqabCO9IdzYRF4kVEyB
 ooIrp4yFmDX5k1T18iwWbw2hApujqY6HQ/26Yw7LgAPJh8D9USBixXlHhF6AEE/FmMg4
 4BBl8w5dQmpp7sQ8uIDTt6jbud64B0k6w13PHNWwanRYWhMjFR5rVRdXFBrrqureT9ag
 2LfA==
X-Gm-Message-State: AFq9FYKcLrYnAMrjkTdb2jBt+K30FP+Mt3qUXtnBax8JPOME7ndpFBk5
 LRJ4743TMXVuf1Q5kauM0h/QJbG8/CrD7Wo4J84y1/h/BleZ50FbxgnfyXxnlynNeD+eCZrNL2+
 qUz1x
X-Gm-Gg: AYBFou3HMk2j+YU139OIQg13kQygDB+Rm7eBi3X53f5mLnqdu00YyN8N6QI1SwPLAKm
 TkmeuGfdCSMinfVEMvlr50MQQto3yHIcCuQsZrk27VKr33muqnN9tQs9x0JJom5/fhJrpkkOvvj
 iVWm9w8QaIZEIkugsSnBh2Cn3/bAqudI62+13fN1/FTb5NY5dU5gI9fFXsNUiPrwi6QeFjtP364
 XXh73/B3+xRriYRw1Ndt8bFVJrU5nxhUQ06+H42xrczdbkpTXiUg1fnIf8IiLqpbRKF169KtmFL
 s04uSq/2EfOUHgA4VMJW7Qmy/ONDy1Vng1e1T27tDKtlad8PvyuTfmUlkTPjgFS5PsxlmJOmZoo
 6YFUmC1FMZBxhEhU4emY/jxoWOaBr28+KNjCYOwFww4SnuFtreZBVnZCOBcyaUPaF3FdYLJkviT
 Qfo7px9TkJqHRgkVQ6s1Rh6zBVbo8s5d+c2umb6oUldkbStL78d8CfNtGP6f4TsaegRCWsSKzxu
 Q7o7TTRevCU/RdA9J8UbJ74txXfN8jlVxJnornfk9QUkhpSBK8JPN3SFCCmm7s7hSkWEWZ2XXFv
 8amNo0pj4Ud2sD58WK3RlMInbYkXoORdTD/hTRr+1rMiqRjX7pH87iZDLwUXvg==
X-Received: by 2002:a05:7022:618:b0:19f:527d:96da with SMTP id
 a92af1059eb24-1a6cdd3e006mr5991045c88.33.1793217704961; 
 Wed, 28 Oct 2026 13:01:44 -0700 (PDT)
Received: from tewaros-mbp.localdomain ([209.249.241.138])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75f7fb28csm9913160c88.18.2026.10.28.13.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 13:01:44 -0700 (PDT)
From: tewaro <tewaro@theorem.dev>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 disclosures@theorem.dev, tewaro@tewaro.org, tewaro <tewaro@theorem.dev>
Subject: [PATCH v2 2/2] tests/tcg/riscv64: add test for mret to S-mode with no
 PMP entry
Date: Wed, 28 Oct 2026 13:01:23 -0700
Message-ID: <e6710bc2fb2759f2272ba037a6019374293f7aa9.1793217528.git.tewaro@theorem.dev>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1793217528.git.tewaro@theorem.dev>
References: <cover.1793217528.git.tewaro@theorem.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122c;
 envelope-from=tewaro@theorem.dev; helo=mail-dl1-x122c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Regression test for the previous commit. With PMP implemented and no
entry configured, the test executes mret to S-mode and checks in the
M-mode trap handler that the fault is an instruction access fault
taken from S-mode on the mret target, with mcause 1, mepc and mtval
equal to the target and MPP equal to S. It exits with 0 on success or
the number of the failed check.

Signed-off-by: tewaro <tewaro@theorem.dev>
---
v2: rebased onto current master; the meson.build entry moved to sit
between the tests added since v1. No other change.

 tests/tcg/riscv64/system/meson.build |   1 +
 tests/tcg/riscv64/test-mret-nopmp.S  | 100 +++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-mret-nopmp.S

diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index 3c8b018d9e..f7410c6a65 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -25,6 +25,7 @@ tests += {
   'test-minstret-ecall.S': setup + {'qemu_args': ['-icount', 'shift=1', qemu_args]},
   'test-minstret-wfi.S': setup + {'qemu_args': ['-icount', 'shift=1', qemu_args]},
   'test-misa-w.S': setup + {'qemu_args': ['-cpu', 'rv64,x-misa-w=true,c=true,v=true', qemu_args]},
+  'test-mret-nopmp.S': setup + {'qemu_args': ['-cpu', 'rv64,pmp=true', qemu_args]},
   'test-zvabd.S': setup + {'qemu_args': ['-cpu', 'rv64,v=true,vlen=256,x-zvabd=true', qemu_args]},
   'test-vsepc-masking.S': setup + {
     'test_name': 'test-vsepc-masking-c',
diff --git a/tests/tcg/riscv64/test-mret-nopmp.S b/tests/tcg/riscv64/test-mret-nopmp.S
new file mode 100644
index 0000000000..df20f35bc8
--- /dev/null
+++ b/tests/tcg/riscv64/test-mret-nopmp.S
@@ -0,0 +1,100 @@
+/*
+ * Test mret to S-mode when PMP is implemented but no PMP entry is
+ * configured.
+ *
+ * The mret must succeed and the first S-mode fetch must fail [1][2].
+ * The trap is therefore taken from S-mode, with mcause 1, mepc and
+ * mtval equal to the mret target [3][4] and mstatus.MPP equal to S
+ * [5].
+ *
+ * Exit code is 0 on success, otherwise the number of the failed check.
+ *
+ * [1] Privileged ISA v1.12, 3.7.1 "Physical Memory Protection CSRs",
+ *     Priority and Matching Logic
+ * [2] Privileged ISA v1.12, 3.3.2 "Trap-Return Instructions"
+ * [3] Privileged ISA v1.12, 3.1.14 "Machine Exception Program Counter"
+ * [4] Privileged ISA v1.12, 3.1.16 "Machine Trap Value Register"
+ * [5] Privileged ISA v1.12, 3.1.6.1 "Privilege and Global
+ *     Interrupt-Enable Stack in mstatus register"
+ *
+ * Privileged ISA v1.12 (ratified, 2021-12-03):
+ * https://github.com/riscv/riscv-isa-manual/releases/tag/Priv-v1.12
+ * Current source, same wording:
+ * https://github.com/riscv/riscv-isa-manual/blob/4877e41a/src/priv/machine.adoc
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+	.option	norvc
+
+	.text
+	.global _start
+_start:
+	/* Set up machine trap vector, handle everything in M-mode */
+	lla	t0, machine_trap_handler
+	csrw	mtvec, t0
+	csrw	medeleg, zero
+
+	/* mstatus.MPP = S */
+	li	t0, 0x1800
+	csrc	mstatus, t0
+	li	t0, 0x0800
+	csrs	mstatus, t0
+
+	/* Return to S-mode at `target` with no PMP entry configured */
+	lla	t0, target
+	csrw	mepc, t0
+	mret
+
+target:
+	/* Should be unreachable with no PMP */
+	li	a0, 5
+	j	_exit
+
+machine_trap_handler:
+	/* 1: mcause is instruction access fault */
+	li	a0, 1
+	csrr	t0, mcause
+	li	t1, 1
+	bne	t0, t1, _exit
+
+	/* 2: mepc == target, not mret in _start */
+	li	a0, 2
+	csrr	t0, mepc
+	lla	t1, target
+	bne	t0, t1, _exit
+
+	/* 3: mtval == target because aligned instructions */
+	li	a0, 3
+	csrr	t0, mtval
+	bne	t0, t1, _exit
+
+	/* 4: trap from S-mode */
+	li	a0, 4
+	csrr	t0, mstatus
+	srli	t0, t0, 11
+	andi	t0, t0, 3
+	li	t1, 1
+	bne	t0, t1, _exit
+
+	li	a0, 0
+	j	_exit
+
+/* Exit with semihosting */
+_exit:
+	lla	a1, semiargs
+	li	t0, 0x20026	/* ADP_Stopped_ApplicationExit */
+	sd	t0, 0(a1)
+	sd	a0, 8(a1)
+	li	a0, 0x20	/* TARGET_SYS_EXIT_EXTENDED */
+
+	/* Semihosting call sequence */
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+	j	.
+
+	.data
+	.balign	8
+semiargs:
+	.space	16
-- 
2.54.0 (Apple Git-157)


