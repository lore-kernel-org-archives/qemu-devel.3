Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0088606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 13:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dfhVauE/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FIgYJ0Au
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWCvs-0002WW-9V; Wed, 25 Nov 2026 08:21:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xWCvk-0002Tm-As
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 08:21:00 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xWCvi-0000fL-Er
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 08:21:00 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AP9mOU12356539
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 13:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4tEQQ7eidww
 jDePy8Iaa7jhpKNmAip5LpHkQJSjkIjg=; b=dfhVauE/H4PshhQF+puX0DpQaie
 DlekQlcD53mSQIHdqEyv1aw3cyQxhyB2LGjgeGCDiRr1n38DkmyxbUgGW+Qc8EGc
 CQ+A2r6H6ethuRSfTR2WPxkMirFrfBaUW6rctCngTN8mbijngzq/I9OQFOCPh6vI
 dGyhCYXhMr2mC4GCFBKHJuwe3bBsTTKLOHfZ0R9ls/CWKWSNBQ2Z0Sxicb3cpkbR
 tyW8TFkTVqkEw1l9xua6fw8xtdEZxAeamImJaJHMt/pi/8GRVS+AZIgUphvcQ0Pp
 XjYxY9NRC3qkk/scxZtGJ+JKZFuIjAZspyB7U7TQnU+gxQA5TnclUEaTvmA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5nu6aq0e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 13:20:57 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-92125693bc6so111845246d6.1
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 05:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795612856; x=1796217656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4tEQQ7eidwwjDePy8Iaa7jhpKNmAip5LpHkQJSjkIjg=;
 b=FIgYJ0AuWNDVMMw6K8yNDn+kneVHBDQKJ7gePU5Gdi+KPdDcPqJQTBXa900gqkiXkb
 rD9IsA+rPJCHi7yRJToPFrxQ5fCgx+YkGwGKSjw9gYmYkXbSDw5L836/rRaz6y4huM3N
 WxYzZ7+kWYj/J86KC3jBGdBZXVtOvWhts99mNMdqlFjPHYdsdQ7353WYWWuLFwDb/f6X
 oaiInit9XUhdycUZ5XutP9V/G3uL0IKbQ7Ua6JnbSebbcJ5qQnJpVZYoaqsH59SgfA39
 1REZr2AiE5RiMt8fLzbjtwq0UskKtMfOHbvVAnV4pmu1V04PaYXFydsDhqEkvDHyQKuJ
 KaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795612856; x=1796217656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4tEQQ7eidwwjDePy8Iaa7jhpKNmAip5LpHkQJSjkIjg=;
 b=tPFdr2MOIEsECKvapfL6yvDzq31QjDTs3AE/yG7nr5K7+/lkyGRw1hWV27wmkGX3Lv
 xTCGVzV0YVYSChlPe3FIrZZ8XgoF2RQRvjUNkz1peG+S2bLgueKaPqpOzCwsc3PFGPBt
 PkW76SKk9AgVcNn9WUVWTvj1QrwvtfMBzmUb7c4+ezY7GYw7wPllnhip75NPISb7vuXF
 n2XKd9CFV4QgF4fPR5LiAaf8ZN5Ch/2CEa4flbWCYmfgvs8TZwr26+tab17KfOrn5y0m
 sw45euDDRxNSdlzlxQZfcLpXGbZ7haPdzSTpSRuoIj9ogpWKNNUCEflmOVhQXNMsBuZe
 3T+A==
X-Gm-Message-State: APuU4Z8fb1YDh/CR4Y6oeQWBXb43ygRMCtaqQR0/TSRQhGPR0JEHDMg/
 EV0egCafnhibE0iWqpaapAArPBDOoEL4ONYaLSCeAvBUDrky95y6CCAeyRtVvyt8F1Ob8gIKWdA
 UXJvaaHDt5ClWZLlEBcqJe/anQBaWvXuHQGbjY6xxzOQyF3Q+gErrGklH4S/Jup0w/Q==
X-Gm-Gg: AZFdTZeJdUperhYMXHdZwkrTlBmlcbdmCsXOJISybhBvqL051kugwjT0ru7D+yTdSie
 r+zimAtmA0JWVG+BfxSFbJn7AJ76cnMLcUZ4soYM/wczwP24dS9Al15PlEs/8xRFO8f08odbKWD
 /hUQHVe0d8BUbGU6ma8hoFgp89HvfYLfpa6NmtSdtria/oZsKz9NMPe6YU9rTGjQ6rhrSXT91wv
 M5B5DB3Rhte5Oagkx285ghaDP9HxbcucqgVr/Wr3Bn5UHiqC6+R06ofNTjisEX71p7UjuFeH7rg
 m+HGHQSvnhwdSBpK6IRM+DNip1QPwRTcpCSkK8Pa+cgHnYZsw1NqtYfN7F5j5F6CMvA1ysERyFV
 V66jMYXEQi7R5DnYKjq/FQpMzqWj1qBT53s7MGeaaq+h0IUNTFEpOTwtB94b4rFdTMr7D4w9fz5
 nvUgnBSnAvpQ==
X-Received: by 2002:a05:6214:dac:b0:91f:2374:9b65 with SMTP id
 6a1803df08f44-9212e0e4c4emr333250796d6.21.1795612855885; 
 Wed, 25 Nov 2026 05:20:55 -0800 (PST)
X-Received: by 2002:a05:6214:dac:b0:91f:2374:9b65 with SMTP id
 6a1803df08f44-9212e0e4c4emr333250216d6.21.1795612855222; 
 Wed, 25 Nov 2026 05:20:55 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm160836946d6.34.2026.11.25.05.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 05:20:54 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 05/15] target/riscv: clear hgatp bits from write mask
Date: Wed, 25 Nov 2026 10:20:04 -0300
Message-ID: <20261125132015.229955-6-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125132015.229955-1-daniel.barboza@oss.qualcomm.com>
References: <20261125132015.229955-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pUgkaoP_ZSeg6Q37LrrDSSLghOEB5YSC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA1MiBTYWx0ZWRfX7v2dYymj7dAt
 gPNUSg9ikNlRf07JMAEa5VgRf+Kio/HdXCp0sp6YqinwKrauOVO10NV64C4DAU/feTWNVuxmLE2
 f4V0kHu6Jf0nLl1zuQSpqT9iQTMX++Y=
X-Proofpoint-GUID: pUgkaoP_ZSeg6Q37LrrDSSLghOEB5YSC
X-Authority-Analysis: v=2.4 cv=Vra2kO2n c=1 sm=1 tr=0 ts=6b06e0b9 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=3sS3A2hXxFRu-t1DIr4A:9 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA1MiBTYWx0ZWRfX0wEshKJMhacE
 s3bk1uiK4IugaBTWqOQnnUN7VNNFLpjFdmWXpkEKcjC0YjO+Lgd6YkKFrJ+4lncoxmkK9MG+5GQ
 likbPl4maU3TOjDkvx9KrXdzOngF0YptVUFssfx4JZLe3hd7kZ76sabBOrn8Tv5FmznuK+iLoqu
 ABwo7/3p5zFYZWm26P2x9SEbVBEBtcGN5fqkmG39wJpKVPhbWndkvXkmvQ9g/6kbrT4LlL0j3Il
 y1IOtpAKhufZvS0OM581+fJ3+r0WkoWnSjr7VnCf+GtxYu+35Y3xfIBYYDGjTejD1A6w2jv4+mZ
 SKX+AM6ESFv1zYiYHQooEjQ946SXAEAThwbiWXmFOGTwInqRzr27+fb0jTwgNTzaasu/BVezX+P
 nsSjh0bqQEC98ipBX+ygKKPiVhlxMYFT63Uc/PwPdctX0EZf8IUgAOrLbXAMFKIDVEIFey0uay3
 NhjcCf2qd8j6Z8r3kvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250052
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
 tests/tcg/riscv64/system/meson.build |  5 +++
 tests/tcg/riscv64/test-hgatp-rw.S    | 61 ++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+)
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
index e132690389..6989393bac 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -5355,6 +5355,14 @@ static RISCVException write_hgatp(CPURISCVState *env, int csrno,
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
index e176587d1d..9684628014 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -136,6 +136,11 @@ tests += {
     'cflags': cflags,
     'qemu_args': ['-cpu', 'max', qemu_args],
   },
+
+  'test-hgatp-rw.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'max', qemu_args],
+  },
 }
 
 if 'qemu-system-riscv64' in emulators
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


