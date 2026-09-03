Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F016C61DD6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 01:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1wNv-0002Bi-2p; Wed, 02 Sep 2026 21:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1x1wNt-0002BL-3E
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 21:36:57 -0400
Received: from mail-pj2-x05.google.com ([2607:f8b0:4864:39::5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1x1wNr-0001hU-7I
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 21:36:56 -0400
Received: by mail-pj2-x05.google.com with SMTP id
 d9443c01a7336-2d942de6574so10299625ad.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 18:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788399413; x=1789004213; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y+Er1ySClcSQZ5eIZigpbczfs6irJAot5XGj3pf/ZPY=;
 b=a27111/Cle3TOE5GhT8YMrLQGP0FOBF/WRKvNpSBvmAKpXl7RnDMMDNQ6vESBL8UeQ
 3zT0CfQSC7MXahPnWAkNmMRBP5MQds+y8pDaU6fH24jpbsgX1x31eK+GUhqEt2kTUDtr
 J9kJw+6fmN7+7I7UXygdD7BaG52rFqGpmlqhPFiF37oZvVGSlBxW8ZaDq+P6LZIsdDo7
 rSP7Xqtw3S86Y/B4TtvWedFjle+CDOFkh/L4C2C7C2YFWDZdzmBJ47nUIbGyG2DFgOu0
 D9A+jC+tho52YBD2GU2c6fpdktiHr5k0IejKxCnv7pGYx4d9DLUU4/WALmyg7bGqtWau
 frQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788399413; x=1789004213;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y+Er1ySClcSQZ5eIZigpbczfs6irJAot5XGj3pf/ZPY=;
 b=X18sWwCJB8mnuxnfHc7kC1dSHyXDbT4UsQQMUazvHZbvZTRKeZ8Ldl0McnbH7NIODd
 Ay+0JxAcjbMYnKz3bnL8RS+U/MBM4J8qQyMXS0424EOw02Gjs+LxgCakq57lbRgF4Y4G
 K52eYj0w8jy8wU8kFNKO5BR8IJPZ9Gsna519xuYdO6YXwCbBzxZ3IC9EPTalLbq6nswS
 2n5XVVdIB57AKN7e442GtL/HgyFPKEE3OeoCW40zfFXrT0uEz8eQz3wOaIAfVFGzL1U+
 U9orYMlmMf6IOLgd/TBc/OtbAbkAhQXQH8UuHeNolSgIc+0NXdPphZff7IjzrXvxcj6y
 hAEQ==
X-Gm-Message-State: AFuF++mWpEcaZAW9reyQzqb9zH9cO2DJIt3L7xyphJYpZh/2/k4pjxSr
 6Rz1I4brlb+IFFDekf69z4ufZB7L8e4/D4/Qjc2GNQbXuwVOdCoubKRMeScqys4L
X-Gm-Gg: AYBFou35UOiTyC8E7rJMT+R8+l3UEJtjClybDkLtIOymUWpha3OvWs1zZGyUmuJPfh/
 Hz6+tAUyimmEBa4FHwY8QfJ+JIkeovEnOJ7coagkSUC2CLs6f3Cv+VSzsmCzSvp8Q/GQJPV8E/l
 KEONXTWKLuTWGZRTDLfuu0gzVpxV7Nu8Vu5vNWEqV9U9dLR1eSfKmUHYe0TDUSjix45mwPil1f1
 +0t8s7eq6jQiSJs3YfzV0R/VCEQrUWqP9Gar7+N1hsyKLzy8X/hPOMMwmam/0HeOprVnrfOjwQ1
 30ax12PRoJQVrJFg5+XZVI/WsyiVEO/DU+Ayog2kHHxWrqGH1gAgwh7Ks59iAj9q+dJ2IYcF4on
 te6RdfubokVf2W1hsvFJZi6xjToQoMiVs9+STAqYLl0xabjNq33jfdiBpPjJgAv0lkvUMtFW/It
 dgjRbJk8d50XjRqyPVLuMdFV+ty93KEkprALAxEYP0SqrkChLpjYGO/Gnb9/WmIKJLyiT5L91ro
 xlEgs0Hs2WkGxds
X-Received: by 2002:a17:902:da87:b0:2d6:d3f9:d394 with SMTP id
 d9443c01a7336-2daec43fd64mr117603075ad.0.1788399412927; 
 Wed, 02 Sep 2026 18:36:52 -0700 (PDT)
Received: from Dell-WorkStation.localdomain ([149.118.62.92])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dafe9268d6sm2136705ad.31.2026.09.02.18.36.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 18:36:52 -0700 (PDT)
From: Zephyr Li <fritchleybohrer@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Zephyr Li <fritchleybohrer@gmail.com>
Subject: [PATCH v2] target/riscv: save ELP in MPELP for NMIE=0 exceptions
Date: Thu,  3 Sep 2026 09:36:26 +0800
Message-ID: <20260903013627.1105-1-fritchleybohrer@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::5;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-pj2-x05.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Fixes: 0266fd8b56a4 ("target/riscv: Add Zicfilp support for Smrnmi")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4223
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
---
Changes in v2:
- Quote the relevant Smrnmi specification text in the commit message.

---
 target/riscv/tcg/cpu_helper.c             |  18 +---
 tests/tcg/riscv64/Makefile.softmmu-target |   8 ++
 tests/tcg/riscv64/test-zicfilp-smrnmi.S   | 117 ++++++++++++++++++++++
 3 files changed, 127 insertions(+), 16 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-zicfilp-smrnmi.S

diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 07d9222652..a0d79b33a5 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -2264,23 +2264,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
 
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
index 6a219c306c..8522c3fe6f 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -45,6 +45,14 @@ comma:= ,
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
2.43.0

