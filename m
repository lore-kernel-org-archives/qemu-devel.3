Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2529CC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:40:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpqT-00056U-8P; Tue, 13 Oct 2026 23:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpqQ-00052O-EA
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:40:00 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpqO-0001Oj-Ds
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:39:58 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-ca766c1c9ccso1236368a12.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949195; x=1792553995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YqIF/59e+QonDfHIGLvlQpYNE6/FNUOPbJAnQ8BC5ek=;
 b=AZjW6jKo3TnRJ5zHfzrRA0Oee3V+P0qAiM2rsArYVjHc1UAlv6UmEftJfj2433OO+P
 KFUbXdIcBl9h075uCcX7Ehbvd0//N2KbvqcPce7Gb0vA4c0w3qwunKoHPr/GlnZLZMh4
 pd5PsQzNWrwfqwq2AzE/59nuMCQ7LrlQnSZOkfvctKvS22wy6UjJUKY8RXzuhiGI0XcJ
 W1gWxTRRz1rScGkJG96bcrHk0ICjIjz3rJdUzJB6qrilRP1l6gWmLhUerXtfzyy9L7ii
 tljQHKwK7aInwb6r3j0nfcrvwv1yRm5uvuZpVrgS6gvnCRcRLJ9VoyIioq3FW5tpKc+9
 RdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949195; x=1792553995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YqIF/59e+QonDfHIGLvlQpYNE6/FNUOPbJAnQ8BC5ek=;
 b=g09Rx/IpJE3f1yS1NN+oqcA0uVMmnvJNCKDxNalMgyuZnq0j4a7liDI6JhSsKVKCuJ
 IDkO4WN44+WdzzF5hBn6LztBL8js5DPk4eRtpn2AJZY8Fc6bYUjG1D8ZCxSNyyUSXmIn
 XAiqcVNI7OQ8ftaZfHTMQF4O3wG2J5cgHnUqoZukQWuX9iJvZ8kGQkfz1OxJb7KmLGiE
 BXOWJEgRnm2xY059nP5f2WWZiXzyt5U4v1Jzy8ZP2qvLA4N7QTUE8GThgYlprV4szaPV
 GtYdQBhgWxrKdmAipJjJJNsbAodjhJINJyXmJWaEVaJL78C9idRUYPEYTLF354p/DkoE
 PPkw==
X-Gm-Message-State: AFq9FYLuVUJXgM8U2Uyk6E7ol7yAh1+sU0d2oIYk+8a96c5ff6r6Ay9P
 K81nNx1+vbKmOctDOHxO37IrYVVCWshGzOQgPofY4b+NtrRLVJrM/vFKYaUNLQ==
X-Gm-Gg: AYBFou2nPEmrQzL7WVCCH1vMdJ6y5tNBJrq/6/h9xTBGOmoRwaNk4w9uKjMBxOrkmTF
 mLIqn+nscNJ6IegnaDT3LHNiuQl9uuWDGkI2HJla4t1qFweWKXGnKexbnoC0JEDaO97I+CPSzHs
 NHGdEsNF+PslcboJqYpsk2xMD04C4QsZpxHs8bkHGDiufoNpseSC4ZS1HHQw9rGAo2TEpKfAOL7
 8He+GuQ/tvnr4rBzJ0y4/664ZQa4DRqwevt4oR9uX9hglBZhZWV6UAZClKSacuoeEgz2U7ryCCG
 M+Je+hXpozzawNocbgEvI1rWhlkFSQTdy2Eo8aRYRHIaVghOwifEHc3l2cS/esupJTUgqkVy+5q
 MM6HjvyJyCBOEZCO6uCFHBJgwr51hzmbSPnaZTuRGGPRzEdjbNBjLADVo9iHWEdtMHamP6geRd1
 zQTfRntjNq2LXBucVKpclK3cQ60/TF02dwrRHzCdQytPNp01syh7DXr7TdcbXYDiGtsQ7HuHs4I
 hRm9mUaVGiZ0FfS
X-Received: by 2002:a17:90b:3a48:b0:3a7:8350:3f7e with SMTP id
 98e67ed59e1d1-3ab3ae76c0bmr10486546a91.44.1791949194556; 
 Tue, 13 Oct 2026 20:39:54 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:39:53 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Zephyr Li <fritchleybohrer@gmail.com>, qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 10/52] target/riscv: save ELP in MPELP for NMIE=0 exceptions
Date: Wed, 14 Oct 2026 13:38:25 +1000
Message-ID: <20261014033907.3332383-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x530.google.com
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

The Smrnmi specification, section 8.5, "RNMI Operation", states:

  If the hart encounters an exception while executing in M-mode with the
  mnstatus.NMIE bit clear, the exception is an RNMI exception. Trap state
  is still saved in the regular M-mode CSRs and the handler returns with
  MRET.

riscv_cpu_do_interrupt() instead saves ELP in mnstatus.MNPELP on this
path. MRET restores ELP from mstatus.MPELP, so the expected landing-pad
state is lost.

Always save ELP in mstatus.MPELP for M-mode exceptions. Keep MNPELP for
the actual RNMI interrupt path, which returns with MNRET.

Add a TCG test that checks ELP preservation across an NMIE=0 M-mode
exception and MRET.

Cc: qemu-stable@nongnu.org
Fixes: 0266fd8b56a4 ("target/riscv: Add Zicfilp support for Smrnmi")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4223
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
Message-ID: <20260903013627.1105-1-fritchleybohrer@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/cpu_helper.c             |  18 +---
 tests/tcg/riscv64/Makefile.softmmu-target |   8 ++
 tests/tcg/riscv64/test-zicfilp-smrnmi.S   | 117 ++++++++++++++++++++++
 3 files changed, 127 insertions(+), 16 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-zicfilp-smrnmi.S

diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 6115f65adb..e78acf37dc 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -2292,23 +2292,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
 
         src = env->sepc;
     } else {
-        /*
-         * If the hart encounters an exception while executing in M-mode
-         * with the mnstatus.NMIE bit clear, the exception is an RNMI exception.
-         */
-        nnmi_excep = cpu->cfg.ext_smrnmi &&
-                     !get_field(env->mnstatus, MNSTATUS_NMIE) &&
-                     !async;
-
-        /* handle the trap in M-mode */
-        /* save elp status */
+        /* Save ELP for MRET. */
         if (cpu_get_fcfien(env)) {
-            if (nnmi_excep) {
-                env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPELP,
-                                          env->elp);
-            } else {
-                env->mstatus = set_field(env->mstatus, MSTATUS_MPELP, env->elp);
-            }
+            env->mstatus = set_field(env->mstatus, MSTATUS_MPELP, env->elp);
         }
 
         if (riscv_has_ext(env, RVH)) {
diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index 1e44410418..9cf049e1cf 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -49,6 +49,14 @@ comma:= ,
 run-test-crc32: test-crc32
 	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)xlrbr=true $(QEMU_OPTS)$<)
 
+EXTRA_RUNS += run-test-zicfilp-smrnmi
+run-test-zicfilp-smrnmi: test-zicfilp-smrnmi
+	$(call run-test, $<, \
+	  $(QEMU) \
+	  -cpu rv64$(comma)zicsr=true$(comma)zicfilp=true$(comma)smrnmi=true \
+	  -global rv64-riscv-cpu.rnmi-exception-vector=0x80000100 \
+	  $(QEMU_OPTS)$<)
+
 # Zicclsm: misaligned load/store support. Assemble one source twice: the
 # default build expects every misaligned access to succeed (zicclsm=true),
 # the -DZICCLSM_DISABLED build expects every one to trap (zicclsm=false).
diff --git a/tests/tcg/riscv64/test-zicfilp-smrnmi.S b/tests/tcg/riscv64/test-zicfilp-smrnmi.S
new file mode 100644
index 0000000000..b5965bf705
--- /dev/null
+++ b/tests/tcg/riscv64/test-zicfilp-smrnmi.S
@@ -0,0 +1,117 @@
+/*
+ * Test that an M-mode exception taken with mnstatus.NMIE clear saves ELP in
+ * mstatus.MPELP, so that it is restored by MRET.  MNPELP is reserved for the
+ * actual RNMI path, which returns with MNRET.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+	.option	norvc
+
+	.equ	CSR_MNSTATUS, 0x744
+	.equ	CSR_MSECCFG, 0x747
+	.equ	MNSTATUS_NMIE, 1 << 3
+	.equ	MNSTATUS_MNPELP, 1 << 9
+	.equ	MSECCFG_MLPE, 1 << 10
+	.equ	MSTATUS_MPELP, 1 << 41
+	.equ	EXCP_INST_ACCESS_FAULT, 1
+	.equ	EXCP_SW_CHECK, 18
+	.equ	SW_CHECK_FCFI_TVAL, 2
+
+	.text
+	.global	_start
+_start:
+	/* Verify that NMIE is clear before exercising the exception path. */
+	csrr	t0, CSR_MNSTATUS
+	andi	t0, t0, MNSTATUS_NMIE
+	bnez	t0, fail_nmie
+
+	/* Enable landing-pad checks in M-mode, then start a new TB. */
+	li	t0, MSECCFG_MLPE
+	csrs	CSR_MSECCFG, t0
+	j	tracked_jump
+
+tracked_jump:
+	/* Make a Zicfilp-tracked indirect jump to an address that faults. */
+	li	t1, 0
+	jalr	zero, 0(t1)
+
+	/*
+	 * The instruction access fault should have redirected to the handler.
+	 */
+	li	a0, 1
+	j	_exit
+
+fail_nmie:
+	li	a0, 6
+	j	_exit
+
+	/* Must match rnmi-exception-vector in Makefile.softmmu-target. */
+	.org	0x100
+rnmi_exception:
+	csrr	t0, mcause
+	li	t1, EXCP_INST_ACCESS_FAULT
+	beq	t0, t1, handle_fetch_fault
+	li	t1, EXCP_SW_CHECK
+	beq	t0, t1, handle_sw_check
+
+	li	a0, 4
+	j	_exit
+
+handle_fetch_fault:
+	/* This is an M-mode exception and will return with MRET. */
+	csrr	t0, mstatus
+	li	t1, MSTATUS_MPELP
+	and	t0, t0, t1
+	beqz	t0, fail_mpelp
+
+	csrr	t0, CSR_MNSTATUS
+	andi	t0, t0, MNSTATUS_MNPELP
+	bnez	t0, fail_mnpelp
+
+	lla	t0, resume_non_lpad
+	csrw	mepc, t0
+	mret
+
+resume_non_lpad:
+	/* MRET must restore ELP, so this instruction must not retire. */
+	li	a0, 1
+	j	_exit
+
+handle_sw_check:
+	csrr	t0, mtval
+	li	t1, SW_CHECK_FCFI_TVAL
+	bne	t0, t1, fail_tval
+
+	li	a0, 0
+	j	_exit
+
+fail_mpelp:
+	li	a0, 2
+	j	_exit
+
+fail_mnpelp:
+	li	a0, 3
+	j	_exit
+
+fail_tval:
+	li	a0, 5
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
2.55.0


