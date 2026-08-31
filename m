Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E700CC624CE
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x12id-000460-HB; Mon, 31 Aug 2026 10:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x12ib-00042G-HP
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 10:10:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x12iZ-0006h7-M2
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 10:10:37 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VBA7gM3517859
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 14:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7F+h/izz5m8
 Ql6K/eu+v2vbYtEL3lKlYqdFbJP7M/1o=; b=i5u9qQQt68e2TMvjzg4hLgbTOta
 rS+vMnNUW2Z5aNIUssHm3VylbpHev0WuMkQw9eaugLFSHdGT6rMvtSvSKzhJiewv
 bjA7wOEKYKpCOs82gnT88HfExI1bvH9QTUnr6enLl9h5SGwfoCzOWyWLJkZUVpga
 Mth6oyt/W1wbmftvPJI4sYRKP339o0wgvMJ3ixG61VkdAqIRo2QppzC/M0ftqiRy
 nNnvBXK/EXif204zRcYOym56e7W4kHOQhU61KNbtU5Y5xgFmffUwdugiCBJnxQu6
 T/xXmiAjBh7TZDM3WQn1vW2Ey1KnVrHmtCWtqQ8LEy3tOcooTLKJqDc13hg==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6h919ts-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 14:10:34 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-6b1a3f01d2aso2106782eaf.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 07:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788185434; x=1788790234; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7F+h/izz5m8Ql6K/eu+v2vbYtEL3lKlYqdFbJP7M/1o=;
 b=UJ8q8afqH/h+bLnZvypGewmPqSfcwVIFt78PvHy9MpDjxPIfgM2ewD3CYv5rw2GECx
 iNN99DyveOc1UI9d5ogfpaEs1L07D/XWtsGanQQuPIApx3J49E9WUQYr3x6bl0mPttc+
 7YCXZnChuPPCeUQgce1mMdJI/PJ+lkytzWnUIL5DpVLy86D2hXDcdGt8nw5aYBo0iAhv
 K9A94jSvkp+rwUm/98mpXJKzZL86KqH108aQkbfBtsmLM+spQdiN8lEHbz1C2hO1R4L4
 bAOcEmqORGkH7g1VQdw8Rqi6aan5zQnehRiKDDsmybAIhYgqibSvbzApC/fRZ8bgDdPQ
 ehJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788185434; x=1788790234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7F+h/izz5m8Ql6K/eu+v2vbYtEL3lKlYqdFbJP7M/1o=;
 b=EcbVufZuPDNvBIk86KHGO4cy1Enb8FFIQMbwC182jrTV+vDEQecFTWfHXSyLxuNoKG
 CclgQmGfkU+0ZyMvGAWLojvsaynX64oXc8uX4Y4nE544t+NRzzS3H8bo/qBtZsYyydry
 rVkuK13nz55zsdAhyKu0WhIjuJSubzZ1QTRd7bd22/VZtJi3bbpWkT98I4UfLgHg56ji
 mAEeDiWYglmL2dQ805D9rYS2r+waxhrviIxlBOztCPzlnyHHn5ez5ahJzQbhMfyD+OFA
 JMuMXaVDugtF758alHepfg6FnYu1nKxMRZSi40IuYkULAIYbh2WR4Ozqe/J1Ck5qnK02
 ob5w==
X-Gm-Message-State: AFuF++mlGF5MEPMNv+7vGM0CJZCMVliDBI28x8LFaKj3su9G8xZtGxW3
 9As24oqHGHNikahW9sjocg93NjPYv9N3ri8qcJy60Oplgx+26AYytU2xBob1PoHLaVaecVXAoKW
 zJGnMir0B5Z9Sr8WpCe8GfME23BZ1tobI4plmX27q674ts8jCFxZUWutSYN/78cdsSQ==
X-Gm-Gg: AR+sD11/54jPBdyfl7eP7QSuzg4j8w1Rqe/jU+rZUmsUcVPvlCybDUQWD/Oe7ZXdoTm
 Doyukht71+vBTUa+yn0WkS1l0QXF7Mck4rdj6DB6yPJzR5HgipT664jwu4/zCzkIcCq7cvDgl7M
 8HCtRMSbKIfPegDpTi3AX84JsHVXt7eqRCSB9gOoe1ZFVLbCOtLQkNmiWeQAyxOrIPbercbIodi
 X1T2aNan/UfAdi6GreOMKuoOToyQrUXGsxMEPu8sBgFNTUO/ZdTLbo7KcrVo1byAxWSSZ9dzFmK
 +I1Jer4d0bjMso2pJKPnOnTq8RQowUaCrcz5Bl2FvQluX5yd/66KqlqEWH9dUwDAx45Z17Norvk
 HnjgU8VSvkFFaCfVpNKD4mU++BGuOtIxC39j2Jg==
X-Received: by 2002:a05:6820:a558:b0:6aa:e573:9ce0 with SMTP id
 006d021491bc7-6b1c65fc8cbmr20715921eaf.16.1788185433676; 
 Mon, 31 Aug 2026 07:10:33 -0700 (PDT)
X-Received: by 2002:a05:6820:a558:b0:6aa:e573:9ce0 with SMTP id
 006d021491bc7-6b1c65fc8cbmr20715861eaf.16.1788185433185; 
 Mon, 31 Aug 2026 07:10:33 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([152.250.131.13])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-468a3535e25sm9886129fac.5.2026.08.31.07.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 07:10:32 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v7 7/7] tests/tcg/riscv64: add sdext "not on Debug mode"
 sigill tests
Date: Mon, 31 Aug 2026 11:10:06 -0300
Message-ID: <20260831141007.353854-8-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831141007.353854-1-daniel.barboza@oss.qualcomm.com>
References: <20260831141007.353854-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=W6UIkxWk c=1 sm=1 tr=0 ts=6a958b5a cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=CXdxNCAnTuDr1kYd6DjE4g==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=FibE5N0eoUlo320SlN0A:9 a=rBiNkAWo9uy_4UTK5NWh:22
X-Proofpoint-ORIG-GUID: qk01jly503QRZpVJ1dPsrx_NnWZ8lxqm
X-Proofpoint-GUID: qk01jly503QRZpVJ1dPsrx_NnWZ8lxqm
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyMiBTYWx0ZWRfXzLN+GmgepPGD
 jHal2wv0i44yYmFjy8SXkiHQAqvh3UJKmxfVlm4gaFUocNgwK4E8UQ6eRUa8G2nPy/JqsaTEXgt
 FjXmNDJNhdWxuq1RI/A9E+03VZmoOAk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyMiBTYWx0ZWRfXxD6Hqs+KdrN5
 BRzSn07XA96ne5bQ75KJBlKd6VOqayAgTs9gkHdzSAJ6x6vn1NMqwMq9dIjmq+fyH9ZboI4STN1
 0JmkOA1EnXRXhqq3kIWwxGkwwyag3n0OuiKDxQfCMXa48u9Q2S+a2N/mmXhXHfbl0UBCSrDHxqt
 qgedWuLcd5lFP+jQJeoFBpKl5YKIqMzSPnt8ErPdQTcAEZbH3wsZZw6JwJevk6VxFdz4Nph9QHg
 mVaTKgGG1+kfrbhAfkjEcnb8XA500XpHE3YywIFT+voWmL8dBVfydxSHI399C/owgUbSwJcuONP
 CdjS+64ADu17pAS2y2okfVKcI9jzcMiw4Id6pr/vtuordU+Ant+yiVPjbuEFspRjM/XH6KJu7MK
 MmBebD2pe1JKHehVCluaKupWKwQ91FBb9q3QglXBSH3x5xgFO0+I/pQtWqC08Y2qfKXqwtuXmLC
 7Potms1IVV+htp85LTA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310122
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
index 6a219c306c..acfa7981ec 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -71,5 +71,10 @@ EXTRA_RUNS += run-test-misa-w
 run-test-misa-w: test-misa-w
 	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)x-misa-w=true$(comma)c=true$(comma)v=true $(QEMU_OPTS)$<)
 
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


