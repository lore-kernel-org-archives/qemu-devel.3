Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC57CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWNc-0001nF-HX; Thu, 15 Oct 2026 21:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWMj-0000rx-Lv
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:04:11 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWMh-0004Lj-Sm
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:04:09 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2e49fbf92aaso35213355ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112646; x=1792717446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2cE1KumKanom6mt8123RfgEvZ1VMzW2u2Z5xS7COiMw=;
 b=mk0bWWqZhCspq8F6NYNARNAj8aGODURb7OBTT4aD+GjglAjr83t74+7Yp19sjBV0EW
 Ra35PLv0kxdsG66QKR2IgXFh7cCydIYlj2QcFOg0s7nXHkv7BPXjVfEB4qOlscCRMg6V
 MBkow2SqZDGE5usDdUAxdiRQzHxhBi+VLweIu73AGmGnanz6SFo+xJg423m9HkIKygNj
 uze2/H0NdCMeGTmCmNW7IBnSjZ/YBWhZ3NlAjzZV8eTtikwdASNYcDvydz1dKAllnmNo
 ELTnbt6MuReDqg/ylhyK8CpP6Jl01kmTy+aou3AcxL/uMxsH7bVExoa/6O//NZfRq5vW
 S9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112646; x=1792717446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2cE1KumKanom6mt8123RfgEvZ1VMzW2u2Z5xS7COiMw=;
 b=O30GLaB1fxiwPPpmRVQzzCBy6vFfDjukb87B+CkaVUahZmdOyfAfE2xOe+1aKes9fX
 cNZrgNl9SbjEMPWQd9J0he72YoVakQL92OLvM2rcWdnMl3qlCyGUalJ/DwlkM0LoF08Y
 XOojKxbQW8kjji4IxWNW+9UqasbnOuwyNgus+YvepcMkD1mgTFT5sD1ADGm7Fo8aNfxx
 K0e/bHFMKv1jmPTVPDOCzEbXhVlYSSMCyQmTqaFw9By4CDpG6DsVvF5K3PgseUtQJ8v6
 r5M6tQNUc88fywZz6EQVyWdLmyJoMxh4SWtOtQuKF1HGGQoYuDs5taCpp5V2W68HfwQx
 +ugg==
X-Gm-Message-State: AFq9FYJkGRmm0Enat1ZzhGs7rUm6yhJwo2dP/CvzrW9zID/6SS+Derf4
 pcTZrX27I2dWPBPIMHLYPwKUMzKxFh956UOZeSZamC+PAd2oy8jY415634yJ9g==
X-Gm-Gg: AYBFou3GOzQUzZSBPrAxnZ27r3eivUJeM5tpBg+cJ4OhgkDvE0RCrSZniIx5HnAGlrJ
 2xlXCW2/m5c/kYllgy/BUbrPUVmKNBL1AzXEHXu6zp/7Y68a0hmrszz3rwXO+a0zdYtd/tf6pav
 ph6wau/Iv7aIZI4RSxp592uTM1DQvO9H5ghqPVrXZcbrBmckLvAU8NCNeIv9NrER7Pp/5S+G9EN
 8iUF/aoV0gWivGmPd3SsARFB731eJr1B4LCCgLd9xjDCFadp+0e5Td/9le1OCq9ZwWvFXMQk92q
 0W0qApvn0MGqaxTr8RuTbHSyeTG7L+/hjaCclunx1O61IxcJQjQva/dt+74/h4w4GCa3LdnzJ6c
 D4g7tHoQKf82riEeBuh2jcTkWyMbTJBAfOpqQq3WjmqrzS9p6a+h745dGIk9pep3M65CJMueuzG
 CEQ34AXkljngjqGM1VHkWapG0GtIyhKffVS4Lm+3kHNY/f0BFJIt/LVk66dSDhueiB0Mx2sktIT
 DCWbZdYAw95/KcO
X-Received: by 2002:a17:902:f608:b0:2e9:60fb:5e38 with SMTP id
 d9443c01a7336-2e960fb6507mr32127425ad.33.1792112646308; 
 Thu, 15 Oct 2026 18:04:06 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:04:05 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 28/50] tests/tcg/riscv64: add sdext "not on Debug mode"
 sigill tests
Date: Fri, 16 Oct 2026 11:02:15 +1000
Message-ID: <20261016010237.1102834-29-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Adding proper TCG automated tests to sdext CSRs requires enabling
gdbstub support for riscv64, which we don't have, since the nature of
the CSRs added is that they run in a higher privilege than M mode.

DCSR has bits to allow for context switching from other modes to Debug
mode, but those bits must be set via an external entity (e.g. gdb)
beforehand.

What we can do for now is a "negative" TCG test to ensure that we'll
throw illegal insn traps when trying to write sdext CSRs in machine
mode.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260928195902.2045235-8-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/tcg/riscv64/system/meson.build  |  8 +++
 tests/tcg/riscv64/test-sdext-sigill.S | 83 +++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-sdext-sigill.S

diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index a632674832..a7478b4219 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -62,6 +62,14 @@ tests += {
   }
 }
 
+tests += {
+  'test-sdext-sigill.S': {
+    'exe_name': 'test-sdext-sigill',
+    'cflags': cflags + ['-march=rv64gcv'],
+    'qemu_args': ['-cpu', 'rv64,sdtrig=true,sdext=true', qemu_args],
+  }
+}
+
 if 'qemu-system-riscv64' in emulators
   tcg_tests += {
     'riscv64-softmmu': {
diff --git a/tests/tcg/riscv64/test-sdext-sigill.S b/tests/tcg/riscv64/test-sdext-sigill.S
new file mode 100644
index 0000000000..80a6c06465
--- /dev/null
+++ b/tests/tcg/riscv64/test-sdext-sigill.S
@@ -0,0 +1,83 @@
+/*
+ * RISC-V sdext extension "SIGILL" test: check if sdext CSRs
+ * and 'dret' will throw SIGILLs outside of Debug Mode.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+.equ CSR_DCSR,      0x7b0
+.equ CSR_DPC,       0x7b1
+.equ CSR_DSCRATCH0, 0x7b2
+
+	.option norvc
+	.text
+
+	.global _start
+
+_start:
+	la t0, trap_handler
+	csrw mtvec, t0
+
+	dret
+	j _fail
+
+	li t0, 1
+	csrw CSR_DPC, t0
+	j _fail
+
+	li t0, 1
+	csrw CSR_DSCRATCH0, t0
+	j _fail
+
+	li t0, 1
+	csrw CSR_DCSR, t0
+	j _fail
+
+	li a0, 0
+	j _exit
+
+_fail:
+	li a0, 1
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
+
+	.balign	4
+trap_handler:
+	csrr	t4, mcause
+	la	t5, trap_mcause
+	sd	t4, 0(t5)
+	csrr	t4, mtval
+	la	t5, trap_mtval
+	sd	t4, 0(t5)
+	csrr	t4, mepc
+
+	/*
+	 * Skip 2 insns (8 increment in mepc) to skip both the
+	 * insn that caused the trap and the "j  _fail" insn
+	 * that follows it.
+	 */
+	addi	t4, t4, 8
+	csrw	mepc, t4
+	mret
+
+	.data
+	.balign	8
+semiargs:
+	.space	16
+trap_mcause:
+	.space	8
+trap_mtval:
+	.space	8
-- 
2.55.0


