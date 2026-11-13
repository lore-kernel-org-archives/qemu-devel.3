Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D958606A32D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 12:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V+3mzV+M;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eqUzdz29
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRqq5-0005Qs-7k; Fri, 13 Nov 2026 07:57:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xRqq0-0005Is-8U
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 07:57:05 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xRqpx-0006ik-VU
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 07:57:03 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADCJPV51226928
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 12:56:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=SSnDICEbflw2SxgJZXbnIkjAcON31gj6Fxx
 ArQWSG9k=; b=V+3mzV+MQVs7EZlKTvvMdyBA5DASqbSfh093NBMgX622FcMQ3iz
 IywfqxSqwohXVGXIyYxETs054Ae74a/XiiQ/BGeuHB76DFs3UO2DcMsSLGuPhezg
 KRGYHtEALmwnl1Slnv06C4hX/DtX08ILuUNhAcFJhDylJ244JtRpn4tWAUXy3B2C
 WBWEcBMr2siTGe9W5BI98ILg+PhH42mcQpwCq4SCRHMwgo9984EQajJ4J4TDC3KJ
 nhJrv9n5E2n+h1c1PnDuDopF2H33USut28Es1I6wyX5smVR5q4waQDYi10vh7EZe
 J7lbeeriS56hCPScmbRX+k8YJBRvUmRqu5w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hx1bp8cp7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 12:56:55 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9495f019e88so9973085a.0
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 04:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794574614; x=1795179414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SSnDICEbflw2SxgJZXbnIkjAcON31gj6FxxArQWSG9k=;
 b=eqUzdz29/VfbUxJmT3pf6dBoFIhQ/M6ZbAXcUgmTuaa5h/I3RyVJ3GqTJkccinIgHT
 PGJrIYNqmFnOpyZMoQGp5EyrIqE/yrV8z+eHBvfIaQlsVVwgkLrWCI3FRD0IGyokt1TU
 /dPjqXhDcWSTmFxWKnhGoDOrpJPwu0cQqewwRswKprdj8dUW06ekLtDqUTb1tY+odI33
 h3NrYUfSCJdMgNMYzHgvgQz4g1HL+L5Mb2z0NbWKzBFoN+pdYDHFcWzp3fyHi64V+vR0
 71zl8aYQFU5NR/q1kxohi0OgA/3ceVlsKyDNLMxxwjgMI+UWERPOtvFQ4T/qH2TgqSZ1
 Y/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794574614; x=1795179414;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SSnDICEbflw2SxgJZXbnIkjAcON31gj6FxxArQWSG9k=;
 b=0sldMw4igwAWODpdZ7sfPed/1vlHYgvvxwU3Hm6sae1mCl9ChHEvpmkQ7asnnGp9g1
 pFqm5xtepdeoTBImZoyDJh0VWUQC2w3gQIvuUIlEyTSiRGgVwEl8oEJjYwBQpVTZt3jf
 UNm2Ri1RVB7Wf6qmWDettCH5peC0wP8D24eldcLzjnXt/pajyym1U90KOjv25Qgp8dgK
 C3aYlKIxL57sIx9I0R9/c9hSBvoJc6P7Qsz/zGdjE4m2J3MFJy6psMU97cBaQNCsT6P+
 zjlkUC31s1Jp5KmrnAu39sjmvOU2ylSJ7ijU/K2HF/RVd4HXZgyrtdET6O3qU24B9jak
 oHGw==
X-Gm-Message-State: APuU4Z9Hum7ELQXbp+/+eS3NW7XrN4TVVOFlXw1dKzaXQubtEDGtVoXT
 MJWgUDCqsvb1YhcDlyfxWtTUy8v3aODYaMTAsbe5ckHvZqXbDp/B3AERocFhuvpvlJomy2NVqVk
 vXytXWUo5NjykwMXcxpc1cHrL1xg1dfAQRyvvDs4ytuUIIrdGGqOg4l3HNUP8jrt76A==
X-Gm-Gg: AYBFou0wMKDgqvCf9OPqVdIk2NUQf42ZDBqXbwYq+m8WBs5PEoaIV2/R6VwwhxzWytH
 Df4juL4hd9FMX4rdJnnxo09PBntB8RHCG1yOWdEch+3MWIToNOYzJ7cjCmu1ZIgPLjGix1joweT
 6/K6UiueSKeyr6fCgkm3rBuwIbATY3kw6yKRGV96jzse/+k5MVTXDKe6pOPjQWyW08PNm1lHKWI
 WZjNSKfVsDt1yiBfZNVYftCA9euLT3XxmhiJkaONkl0E61A15Ak+XgRM/6aRzRslkDuREnuLryE
 iM3auqjeQSJMpQ5hUmQ6gW4el1cHR7Roq+0X7woUFLlofw3hRkCRUbdRkmxdQniaE1XICXIwXdr
 HSWUpCQy5ImD+Kg5rLlXkyqgVmkXLKXv9HNvi1KJIdY8DYSpYImUOPgQQJjltKULH+msYWsF4re
 DnhBFsOuzDNdcNL7stW3TZ5Z2B8pvEV1w+Qyl9/sZO9v51
X-Received: by 2002:a05:620a:801c:b0:93e:e2a4:b0fe with SMTP id
 af79cd13be357-9494bc7f596mr378992985a.66.1794574614360; 
 Fri, 13 Nov 2026 04:56:54 -0800 (PST)
X-Received: by 2002:a05:620a:801c:b0:93e:e2a4:b0fe with SMTP id
 af79cd13be357-9494bc7f596mr378990485a.66.1794574613819; 
 Fri, 13 Nov 2026 04:56:53 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com (189-68-253-226.dsl.telesp.net.br.
 [189.68.253.226]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9495a5ef5c4sm50364785a.6.2026.11.13.04.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 04:56:53 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH] target/riscv: clear hgatp bits from write mask [GL4591]
Date: Fri, 13 Nov 2026 09:56:49 -0300
Message-ID: <20261113125649.53580-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=W9ytxhWk c=1 sm=1 tr=0 ts=6af70917 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xcxBfRYLw5hNHjR815/AfA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=3sS3A2hXxFRu-t1DIr4A:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: 94xcHmlsHvprKqi2P2AcATznbt8NGMxo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA1MSBTYWx0ZWRfX/5aIsf1EhdEx
 VqPEv77g80TXKMDYvMRtt/WJ2bQuwYBqcGO0vxsUeQRwksKwrjlHwqvKQmEjD5BgBHKc3Dgw4UD
 0sWm901Hfd4uTxuzKZqhRS/ZJYb/j40=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA1MSBTYWx0ZWRfX8aMQIbcoqhlx
 4lDTe5t0aPHCFCVaTKbRB8dGOObNO6Ju1cH7uKhWW7O9/eTOtHvmCbuAufq8b8cV9Im71xpiRUZ
 EzJkbzr9xp0H287gGEErq/Y7xjKp9eH82cFF2tMZJg8O8fFMvQGLyQEz2okvJdqyLDs/runQOos
 N1rXyXnBNgS91rM6gQviG+Q0eB1uiu/JAWAfrWhY6Tm6IQ3xGd3Z2pjGjJRm/3iapPL12sAHyy5
 ThQxRVSk4DthSN5uF/qm6cQYTwxSwLet+ZyMr8KqJ0EY7Bhg03/k5endbBMkzMBnoh0ntBPDwT2
 XIYGeLnpQOMiYdeqSYoJLk405vtQPz2ImxuFSTd4UMkRz2pcSIAdC3HzSl3im0p+Orvb6naPcbm
 5Ccnp4sQNXNKjWJF0Shbf+++1BP8udkvk46HlOYiJkmwIt9xaAuUuTtnUcEBbSflVWfEpn+fV/o
 RIzUsNF0LHE9E20+1VA==
X-Proofpoint-ORIG-GUID: 94xcHmlsHvprKqi2P2AcATznbt8NGMxo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130051
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We're allowing writes on bits that the ISA demands to be zeroed.

In theory we could let PPN[1:0] be writable for Bare modes.  In the
'hgatp' section the spec says:

"An implementation that supports only the defined paged virtual-memory
schemes and/or Bare may make PPN[1:0] read-only zero."

This is our case since we only support sv32, sv39, sv48 and sv57 and
Bare, thus let's make our lives easier and zero these bits all the time.

Fixes: 1349f9695208 ("target/riscv: UPDATE xATP write CSR")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4591
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu_bits.h              |  9 ++++
 target/riscv/tcg/csr.c               |  8 ++++
 tests/tcg/riscv64/system/meson.build |  7 ++++
 tests/tcg/riscv64/test-hgatp-rw.S    | 61 ++++++++++++++++++++++++++++
 4 files changed, 85 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-hgatp-rw.S

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 3579789a1f..dcd3f239fe 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -744,6 +744,15 @@ typedef enum {
 #define SATP64_ASID         0x0FFFF00000000000ULL
 #define SATP64_PPN          0x00000FFFFFFFFFFFULL
 
+/*
+ * Priv spec, hgatp section: "An implementation that supports only the
+ * defined paged virtual-memory schemes and/or Bare may make PPN[1:0]
+ * read-only zero.".  This is our case so we're choosing to clear
+ * PPN[1:0] all the time.
+ */
+#define HGATP32_ZERO        (MAKE_64BIT_MASK(29, 2) | 0b11)
+#define HGATP64_ZERO        (MAKE_64BIT_MASK(58, 2) | 0b11)
+
 /* RNMI mnstatus CSR mask */
 #define MNSTATUS_NMIE       0x00000008
 #define MNSTATUS_MNPV       0x00000080
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index af444e3e6f..7d05a50586 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -5275,6 +5275,14 @@ static RISCVException write_hgatp(CPURISCVState *env, int csrno,
                                   target_ulong val, uintptr_t ra)
 {
     env->hgatp = legalize_xatp(env, env->hgatp, val);
+
+    /* Clear HGATP zero fields.  */
+    if (riscv_cpu_mxl(env) == MXL_RV32) {
+        env->hgatp &= ~HGATP32_ZERO;
+    } else {
+        env->hgatp &= ~HGATP64_ZERO;
+    }
+
     return RISCV_EXCP_NONE;
 }
 
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index 3c8b018d9e..23f05d0ec1 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -89,6 +89,13 @@ tests += {
   }
 }
 
+tests += {
+  'test-hgatp-rw.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'max', qemu_args],
+  }
+}
+
 if 'qemu-system-riscv64' in emulators
   tcg_tests += {
     'riscv64-softmmu': {
diff --git a/tests/tcg/riscv64/test-hgatp-rw.S b/tests/tcg/riscv64/test-hgatp-rw.S
new file mode 100644
index 0000000000..4bda3c38f5
--- /dev/null
+++ b/tests/tcg/riscv64/test-hgatp-rw.S
@@ -0,0 +1,61 @@
+/*
+ * Test for writable hgatp bits.  See Gitlab 4591 for reference.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+.option norvc
+	.text
+	.global _start
+
+_start:
+	lla	t0, trap
+	csrw	mtvec, t0
+
+	/*
+	 * Write in HGATP the same value written in Gitlab 4591
+	 * testcase (0x8c00000000000003).
+	 */
+	li	t0, 0x8c
+	slli	t0, t0, 56
+	addi	t0, t0, 3
+	csrw	hgatp, t0
+
+	/* hgatp expected is 0x8000000000000000. */
+	li	t0, 0x8
+	slli	t0, t0, 60
+	csrr	t1, hgatp
+
+	bne	t0, t1, _fail
+	li	a0, 0
+	j	_exit
+
+_fail:
+	li	a0, 1
+	j	_exit
+
+trap:
+	# Any trap is a fail code 1
+	li	a0, 1
+
+# Exit code in a0
+_exit:
+	lla	a1, semiargs
+	li	t0, 0x20026	# ADP_Stopped_ApplicationExit
+	sd	t0, 0(a1)
+	sd	a0, 8(a1)
+	li	a0, 0x20	# TARGET_SYS_EXIT_EXTENDED
+
+	# Semihosting call sequence
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
+
-- 
2.43.0


