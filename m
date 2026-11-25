Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD62606A327
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 13:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iwVUm9xR;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AxkvKQ7e
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWCvo-0002US-8v; Wed, 25 Nov 2026 08:21:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xWCvg-0002Sy-UW
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 08:20:58 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xWCvd-0000e7-KQ
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 08:20:56 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AP9mTBC2356729
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 13:20:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6505ZE7yV1y
 aZ7Tz7xueT/9+yrJHVlZ1qKiE85sneOE=; b=iwVUm9xRJ0L3X23G/Qr6W4mpw/Y
 5q/RxMC6Nt3j74tGUJ37SQVsaKYR4WbBRUqmII8q/lspESY0ZszinEUuS+ch2MQC
 pR8xVAivDV28YTn+LPzyWZRCFTeB+3jub5gYK0mZvCzVbVelsmUuEo+5qiWLt0jl
 R85aZbo2Clx2WgZzGRopAwCWLSCdoR1vo2on0pl0mJWX3fhmcKaZnz0diPe1Rkyi
 LGA5by5NtGoi4CWBPqf4SpjfiMzABz1v+JTiP6Pvwbp4WNMkdNcEsUM9q/buoHBq
 duosP65DGIsNRS7l5SDfILu5n8/zoxdyECteeYnbsIhKnWKZtxBexxXzIrQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5nu6aq05-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 13:20:52 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-94975041698so1442727585a.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 05:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795612851; x=1796217651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6505ZE7yV1yaZ7Tz7xueT/9+yrJHVlZ1qKiE85sneOE=;
 b=AxkvKQ7elcyaVli6OUKF13N3i3TCgo3y3rk5dLx30WcIMGRghCPdvd5vLl3jjAcOQW
 3AMIinUYW41pG429qZX47CiCgHwOnHEu11dT4s7SQOR6aAh55DfFBnvE7eZzF99VaSXj
 XNcDhh/eeJFgyeGfrUJ52erzmUT/0N1rjMvLr4a8WdBSgo9cI9eHTSa3SHmMMtz3E//L
 iwwGtmjLsKg9A6qzl7dj7kw2EAwFZUI71/yY/riAlOPYmsUUU9luGwjIfrY6Ei2gqALo
 HZpQ2v10LD9RH1WiX2dLbNKsRZOlGWaxTaQ6dNF9xGNBSxAOTX6fa/vCZxfDopQ+mG1j
 gb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795612851; x=1796217651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6505ZE7yV1yaZ7Tz7xueT/9+yrJHVlZ1qKiE85sneOE=;
 b=TmssHnaY0YDk6PdzsMWkUgodQbqBM/1hwqatE0eyIoXi4RtCzKr2Sup90moG84Oxme
 bQI+/GIgrCHnerM3zAAheajzmHOqBX/VslhoIxgRua7RHUfTcfuKFAsKHKdVdonnVsUX
 ekAemAipKhjwYgIDp3ti55CNdbAdlGdHcuwi819KEcR15qJB8q9IoJzmUG3aYizOZA3F
 SXy3Z4Dfz/cYntSy+hU9JtqdNYxhKq8g91GVKpKtEZiSABXXa0VaneFUeL7ufWhXvrTx
 nBvmA6Qzi/rFGiX3ZQH3IdA+qMUwY4ozPSW72+iW3uTC+jg3V0AAsxv5Zgrez2xU1UdO
 Odsw==
X-Gm-Message-State: APuU4Z/BkG9IwLNtzYmJyx0ZoSK7Q+/N00n1mu5+qobZxTcen4nbBny8
 i8KIJpPk39Tv9e2JEoD4U/TE6rE6iVxTR2D8xVebpGtcFc+KiufIERMYQfbdqn3SBzqUhPGktYg
 ltRiY0aVJtnDxCsYENCRiuEGFNrL46BKUoR2RUKo/IEY/GzhtHLWOE2aBM+NiTLXhUQ==
X-Gm-Gg: AZFdTZeqGjUcsYxiBzxzArAUQWg5J9glDEJ8BAYWF82TK6GhP/+Ifo5KYolp7TsSdmL
 mGF3JwrUTxq26PFYu294h2jKvq6AELcjE8ZeP0tCTH+URyeAxMR4z8dMnwfTWwBEwPX648HzTPV
 iFHns/NukTSskHQdx9qzWwqCwSJUAXUKxlm6ouwq2ZBGDVafsuxq8IwlV8LaIsO9IKw5lyIjE9w
 xQSWErSQ6RKQxiRVlEiZfJ+f4oOFW28rDAf+yeg7+71VmsRDMM+phfAiGQH4Aq1uLFTIQIE6gSU
 UQHGJ0A3hqBh8BXoZRqHz63J8gCCaEFMxQCNik75sm8m9vXmMDxd4OqEjtL1edKzHWO4w1EpxwR
 PwSrHNpT+GdYmGwwbPXJN9DazYOEudC5JKqR5kwp+CJtVzaD7Pd/L7kUMvZDnyWWwdQKnfIK4Ud
 jm+LEtCCvA6g==
X-Received: by 2002:a05:622a:e3d9:20b0:55d:8484:6506 with SMTP id
 d75a77b69052e-55d8484669emr189581361cf.27.1795612850970; 
 Wed, 25 Nov 2026 05:20:50 -0800 (PST)
X-Received: by 2002:a05:622a:e3d9:20b0:55d:8484:6506 with SMTP id
 d75a77b69052e-55d8484669emr189580881cf.27.1795612850303; 
 Wed, 25 Nov 2026 05:20:50 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm160836946d6.34.2026.11.25.05.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 05:20:49 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 03/15] target/riscv/tcg/csr: filter bits when r/w HVIP(H)
Date: Wed, 25 Nov 2026 10:20:02 -0300
Message-ID: <20261125132015.229955-4-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125132015.229955-1-daniel.barboza@oss.qualcomm.com>
References: <20261125132015.229955-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: bYATfII2I8brbPDo2svufXvCGCXRARtX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA1MiBTYWx0ZWRfX29Fw7ahx+rTx
 /ON4hOyB8mo8dlvtIUyoOXctQkl+nLqI2aEVlJWEhl790dLmFXY8mfPwLC+yZM19zOonhEb8kJ/
 /EKqc/kW1/3c+9WiqK1aCGv1Wc02EEk=
X-Proofpoint-GUID: bYATfII2I8brbPDo2svufXvCGCXRARtX
X-Authority-Analysis: v=2.4 cv=Vra2kO2n c=1 sm=1 tr=0 ts=6b06e0b4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=FibE5N0eoUlo320SlN0A:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA1MiBTYWx0ZWRfX07V9lGgMKE2L
 85lZqjR3gE8sLpC17TbShPXxec0Rdrl3zWRWG54e3Eevhz9upwneYTTDBtO1quqOarCjfPE/syZ
 VujmdT62GSYD1tuthkqrocSLoTlfO4HSimStDUlBvvlZza8JaRjslkHYX1gYn4ATW1RLiOdlPRv
 30nTtdyFJ7B6MUJn62nM2grNOkOaCcWDayifKS0AWGQzNLTNNV4DftjxxBf0X/roIzXpyKlmA25
 XzfFBhTz3QljPogo+vnKHA79G5GkU0KjzORCjuPvlhvdNWP6gQbx8k9GXO5lNCUWC0SsGC6RwXl
 5SL8hL22xwx6s7jeN2/rtZr/Y3NS98Bdzp4SiZ+WOFwZBTDVDRGQxssiyfsy+Q8zpRVPiYNsF35
 54vcwjNqmq/eapmrChbKZSHU/R3DtXcfkwoxvVfdmlm3y1k2i8WAk5F8X9vzyRgw/wK+wNXA39Q
 Voe9Cup1/dJI1Xa964g==
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

rmw_hvip64() is not filtering out the bits from mip/sip, hosted in the
'alias_mask' variable, when dealing with HVIP.  The bug is rather
straightforward.  Given:

uint64_t alias_mask = (env->hideleg | ~env->hvien) | VS_MODE_INTERRUPTS;

when env->hvien is 0, alias_mask will be a full 1s mask.  This mask is
then used to retrieve the mip bits (via rmw_mip64) and then later when
filtering ret_mip.  The end result is that HVIP ends up providing read
access to bits it can't write.  The spec says:

"Bits of hvip that are not writable are read-only zeros."

So we're in a direct and trivial spec violation.

Fixes: 40336d5b1d4c ("target/riscv: Add HS-mode virtual interrupt and IRQ filtering support.")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3133
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/csr.c               |  8 ++++++
 tests/tcg/riscv64/system/meson.build |  5 ++++
 tests/tcg/riscv64/test-hvip-read.S   | 41 ++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-hvip-read.S

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 0e2ef8530b..c94ce88594 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -5139,6 +5139,14 @@ static RISCVException rmw_hvip64(CPURISCVState *env, int csrno,
     uint64_t wr_mask_hvip;
     uint64_t wr_mask_mip;
 
+    /*
+     * alias_mask, aka the bits that comes from sip/mip, should be capped
+     * to just VS_MODE_INTERRUPTS when reading/writing HVIP.
+     */
+    if (csrno == CSR_HVIP || csrno == CSR_HVIPH) {
+        alias_mask = VS_MODE_INTERRUPTS;
+    }
+
     /*
      * Both alias and non-alias mask remain same for vsip except:
      *  1- For VS* bits if they are zero in hideleg.
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index 6c3de32965..9754c2a55a 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -126,6 +126,11 @@ tests += {
     'cflags': cflags + ['-march=rv64gc'],
     'qemu_args': ['-cpu', 'max', qemu_args],
   },
+
+  'test-hvip-read.S': {
+    'cflags': cflags + ['-march=rv64gcv'],
+    'qemu_args': ['-cpu', 'max,smpmpmt=false,pmu-mask=0xfffffff8,smdbltrp=true,ssdbltrp=true', qemu_args],
+  },
 }
 
 if 'qemu-system-riscv64' in emulators
diff --git a/tests/tcg/riscv64/test-hvip-read.S b/tests/tcg/riscv64/test-hvip-read.S
new file mode 100644
index 0000000000..20a1492924
--- /dev/null
+++ b/tests/tcg/riscv64/test-hvip-read.S
@@ -0,0 +1,41 @@
+/*
+ * Test if a HVIP read is returning 0 for all bits it can't
+ * write.  Based on Gitlab 3133 testcase.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+	.option norvc
+	.text
+
+	.global _start
+
+_start:
+	li    t0, 2
+	csrs  mip, t0
+	csrr  t1, hvip
+	bnez  t1, _fail
+
+	li    a0, 0
+	j     _exit
+
+_fail:
+	li    a0, 1
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
+	.data
+	.balign	8
+semiargs:
+	.space	16
-- 
2.43.0


