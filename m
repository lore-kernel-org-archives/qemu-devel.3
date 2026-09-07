Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2CCC79FA0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3XoR-0002tD-Pb; Mon, 07 Sep 2026 07:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3XoF-0002jl-Bh
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:46:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3XoD-0003Ge-Mi
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:46:47 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687AnMLr3777326
 for <qemu-devel@nongnu.org>; Mon, 7 Sep 2026 11:46:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=1LQc3MHagbs
 qNP6Gfy/bvJe0yknu38X5VO+oSaaO4w8=; b=Pvl8E5oD9/g4FGMGdre9JP9oP51
 bvaOokE2xRslFkZxkbdHvbikuQb6HOMVli4/eora0VO656azj5eywm5yiSZVTGDn
 O7xZsPx0NAEcQ229Vb+u+4wODEYhQttVJkZIhBOiSeAnS1C268pHexoEGX8d4sHD
 FydK/jvw+jMPox9l6arYfm+HJReS93qVuvUcZCRrmMi8O1PnPT75AQSZ7cgfj0Gd
 C4oY6bZQAmqDmNuRjrbVD5hFIySl0hs6wrVB++tBGt7Ib4yPEoe5dxZsMdaDAmGy
 SMNvg6hodWv0o2JiAlpa1UTGEje8E0LpuZQTi/SpBLrm4sgNz5zf6fvhE+Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghsfygwnq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 11:46:43 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-936e393061dso462227985a.2
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 04:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788781603; x=1789386403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1LQc3MHagbsqNP6Gfy/bvJe0yknu38X5VO+oSaaO4w8=;
 b=A8aNQVk67dyoHgc0b8Ez7cFH8kmnnlmXCCbYH4TWbOz+mhgMPxBlz5TE7wYPss8yqC
 +tMCObS6F/rsl/ZbRwpiVxs3nhUJgjwB4hRjYviB9C8GwEJkGfUnYODpO4w958nNATLP
 244FBylN1iyjZRuCJliN8OgyIOe/hd84TQpiBmD/mf7BXNcpE91YTAKlefxOoqYsjnO9
 /nkWy/781FdSEiRUdGW9n2+8VDcz9oElT/k6Y2xVAwNa4o0vZHqqz7Njgz5WRSWSGWL7
 7fNNNN6UkET8s4xADBfndbQtB+8Ljgv8j6blXAQ5FXBqVxwKPjgs8KQoJM5R1laNItaE
 FsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788781603; x=1789386403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1LQc3MHagbsqNP6Gfy/bvJe0yknu38X5VO+oSaaO4w8=;
 b=EmKxNnFyew6SiRKB/v0mmbMrdoaIMAGmS2w5iP8g57LrteFOWoo1Z5Uz4r6+28Zd+g
 U0ONBsSrlGQJclhhOUdH1YscO4OHvaLtqDbQ15uJhZzQaqpI80oiCLPYTtrSVldr/G3E
 2V6WrIjRcDMAZxdA+cVGhUbQE4iM9ZL2QHjhdyPpGLIW6U+iYvPJIQn5bM6yvYwBfHEF
 Tt2Mv/cdDhyhJ+CWeHpxrRZfjXU/epc8u9FJsCssZi+33ebDH+TfSGNzXYr2pyJzkOFi
 nBzt02a0B6/BD3+G1th0Rm3Gpy3NplnD4s+JEkluGCCGek3iurT1wWmOQxchRwsCiWqs
 M/PA==
X-Gm-Message-State: AFuF++ldjJQi7zIfeIe4DDs9FK6AQLwW509tH6oKrtdXMWI9gvl59LbL
 rhN7Iod54XbvVgXwRFfDMadXavRBVq65LjGWhcqr6nk7DXbJEN5lai7CqN20pISiux9c6Q3r4ry
 9ojGgnNMZAgBRz8Z4mi0rdEmjH/C13kJBqf1XRZu6uLQh9mkQ60Xorm2T41CrVSyxug==
X-Gm-Gg: AYBFou3swpe82lQSqXXFJf9HjSNlKDBv6nDZSmJDfy6/u2rtNphJsyyQ3rCcy0+1oQH
 wt0Qtn7p5LKFCmsuOKNkIIIxwqGhR3uiiqRUANiZvRvbBv2E89oR/iVXpbkalbCCuLx4IlNcnOe
 a9JyPcyQMWjKnggqSpKOPNqt3wCG0hBOX/VVd8d9nctagUjZIg3Lv3dCpiOajDpRiJvn0RzqOCm
 ZYhTVcHTCPoJD6jsEB4q1qxwrMaDRzraCjSewKGQUaCjFo+5hp/VY4RKMzAH4kjEVHhRZxoNNfX
 KCdQ7RyMyNbFvAzLcU7CPayUzIC0kntfp5SsbQ2tHcTJBtdHCUfsxchPwXC7yLHF/fcpcP28GHw
 XoPgJ87bpneihO+CYfhmyOrH7s/2SW+mcRJpL
X-Received: by 2002:a05:620a:5229:b0:936:afa0:3661 with SMTP id
 af79cd13be357-939804a386cmr1758001985a.36.1788781602942; 
 Mon, 07 Sep 2026 04:46:42 -0700 (PDT)
X-Received: by 2002:a05:620a:5229:b0:936:afa0:3661 with SMTP id
 af79cd13be357-939804a386cmr1757996185a.36.1788781602375; 
 Mon, 07 Sep 2026 04:46:42 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91040679e13sm89834876d6.26.2026.09.07.04.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 04:46:41 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v8 7/7] tests/tcg/riscv64: add sdext "not on Debug mode"
 sigill tests
Date: Mon,  7 Sep 2026 08:46:14 -0300
Message-ID: <20260907114615.1609913-8-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907114615.1609913-1-daniel.barboza@oss.qualcomm.com>
References: <20260907114615.1609913-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: whEr0IrSxe4eI1Zeuz7u2n6qlaW7V4qf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEzMCBTYWx0ZWRfX8tZsmii/eGOk
 ZLNPVOhGEIt3OYuLv4+rCqD6Ok+aVr+HC+byITZBdljkKwOBLMPNJV7lKQxsCmksYYmlitSer+z
 RYZNx/iSD5jRz4A+XhFSm+e4wrEtuvAITsp5ofdNQuivGwdGRzMQxvGvOO6jT0romxOum01yvyy
 agngBo3Xpr3XjIvA+zGRUEt1tnqb84FMlkMrxDiyYqoKlJc/nHjmtDc49j9p/G9IlkU1rjUzd2r
 E/jjJ0R2MgC+JIIBD4DVFclRyHPyxVIzxrwTsl9Re5+WIq2HGG3pNKnbODQWCCUpgSbcJYB9txS
 Qzv/F/5/L5oVe24DOy5NQWqO4yMIvGPPtTma/tZRCjBJG9NGQxKxru7O3lguUMhkKnDJz5ra9sk
 8N2pqPTWe3fJWoH5UJmH5OrrrkqpfogPSDBi9zX+5QLX00rVnx424I4E9bvxxHM9iFkBBZpW9TH
 4lSIRMEsgL4Jb1O9img==
X-Proofpoint-GUID: whEr0IrSxe4eI1Zeuz7u2n6qlaW7V4qf
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEzMCBTYWx0ZWRfX+FRDKqmdsnBS
 Y/cJCUH+IOKYGA2kBM9ST1b1u8xEzxbpVrZNA0qBXutvDSP6CG2nB5ktuzZpkg46BZvDp8TUXtp
 Yq9Y/1M3ANqKB1EbHP87p21pTATQ0TY=
X-Authority-Analysis: v=2.4 cv=AduB2XXG c=1 sm=1 tr=0 ts=6a9ea423 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=FibE5N0eoUlo320SlN0A:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070130
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
---
 tests/tcg/riscv64/Makefile.softmmu-target |  5 ++
 tests/tcg/riscv64/test-sdext-sigill.S     | 83 +++++++++++++++++++++++
 2 files changed, 88 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-sdext-sigill.S

diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index f2c75abd57..0a36376f85 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -85,5 +85,10 @@ run-test-vle32ff: test-vle32ff
 	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)v=true $(QEMU_OPTS)$<)
 test-vle32ff: CFLAGS += -march=rv64gcv
 
+EXTRA_RUNS += run-test-sdext-sigill
+SDEXT_CPU = rv64$(comma)sdtrig=true$(comma)sdext=true
+run-test-sdext-sigill: test-sdext-sigill
+	$(call run-test, $<, $(QEMU) -cpu $(SDEXT_CPU) $(QEMU_OPTS)$<)
+
 # We don't currently support the multiarch system tests
 undefine MULTIARCH_TESTS
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
2.43.0


