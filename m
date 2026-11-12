Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAFB606A8A1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SmV89pxo;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d+Gyux/O
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUjM-0007Gh-Oa; Thu, 12 Nov 2026 08:20:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xRUiG-0006JZ-Br
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:19:37 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xRUiC-00075V-S3
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:19:36 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC90v4N2514210
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 13:19:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=2Ms9ESbUqNo
 8NGsWncKyuPiesUhUUjZqf7vmVf/c3Hs=; b=SmV89pxoHkv6v6jiWu1AZ+zI/Qq
 397LQD0FFwYe3uK19iwxgKyWZwPvLBCQY4HeBdd+kg2T6fnhJkoyRfpzTi/yI8UM
 iXCeeiR6YxPsRT+GF21tz2lxnHjIAfJQXniooj5JQijy9MpV7TMxDBFTep4APsO3
 ZIbQPkqk/WfFzPdPaYSCulKdeEeh2GYpM+CriMacUZYkJkZe+EeFFKyIBv95FbXj
 rrAZ0LiegDYNLmYqqC+2A+DFz/xBiBjprgpeHWGt1V4NwJwMfMWQHqbsufeUvRNn
 d5IRwIPXZkRSJDShlaRpZ+N4nETHvSq2dw6Pm12Ph2g/DDYYgVu/xsYMxbQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvwm1uq7h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 13:19:31 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91eb7d1472cso81874246d6.0
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 05:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794489570; x=1795094370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2Ms9ESbUqNo8NGsWncKyuPiesUhUUjZqf7vmVf/c3Hs=;
 b=d+Gyux/O+I2mtXnApebfNlqOXHqfN7kD+x433xImIoyQKzSfxzVv/uKrPq2tPXTUZU
 ikjLAxiHNFUZbV3n9amZgW99KZUkidB4HBUevuVL6uPYyKIlJb831LcxPzJT2vU4PbAi
 M/IAsQFR23Wz3UXUz9e/Sv46/c9RGQ39aNPJBIGxOakaZ5t6KUqTRegVvgEZrhfppT1C
 HwxNKYLPinHJVRhHDwfa69kNc8ZytYZqG8a3RgoPl10+uUpZB4cV+mNPGNC578thmwd7
 nmuCjQh5oV6Zi6jZwYpNcg0BF75FvTBZCtZQyImzzD0D21SMm0JjM/UjwniS4M6pIdp4
 14sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794489570; x=1795094370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2Ms9ESbUqNo8NGsWncKyuPiesUhUUjZqf7vmVf/c3Hs=;
 b=P+H2cC/WGqhhaxW0H4ITaRA7TeDcd/5Bfawu52qJZHdHZyrEvK2x7lUZHy8BeN4IRG
 YYpaomUp/X5x0ndXXpmSosNvj1oHQc1KCN4OorwY/KH4g1cvbNep/MSXIUGBM802uXyS
 2KwUGg11uyQ38LeqMoGEThcz2zStJQiEN9ua9HBwN5a11f/bSwQXib3dcTiwocg5YWFq
 ZYs7mLNjSJyNTD/fKkzhVpBbFsHqcoldM4QOK/xpcWpKn7TUAMoobwCU6SzrSpNfCl3S
 RlR6lh46SkmhSoxynkj4SLrgaVQlV45MXWRMHNyJaQC4voNRQ8XsOkDAXDsEJKXsME9J
 SROA==
X-Gm-Message-State: APuU4Z+h7vfXaoPU/l3pDnvSrO4NST1rZ5pp+mbmZgBJpMARRIDVCUvx
 8n/eslTjJf+vqC7omeBpZ8S4iqDTBNkJLyR1PJJShHGziOWCjsHU+9+BTWZbq9yFtK5kiALiRNj
 Wn98+In4Pkgo3G56NNPI1v4Fuqvfb1f9dw9pL8hkD3uPlaJv7cLBMfy01eUQnqO1Uzg==
X-Gm-Gg: AYBFou1K9CapBREIh5cgPQQ7Y33gvVCnzbzPJu7Q0ceKYtPBAzhc1Tn8C3/nf7MK72e
 S2LGH+/1iQV4jVmh36pre5A4BgoUopDKURlpAFK1Cm94dBnU4HHZIKFs6m5ugpl7/lEfpgOYe22
 N83Kaghqzmv39QscXgWosgrvL+vovD+DYJUe70eh8EihC2dTaxLiRqsm7M1XD3WMtJrFlZH125c
 47PFqyR4Slr7V3LJy6KSPhGhzBplWDGo0Jpx4waC4wiuL58dOPTP2k5tfK8WS22FfZBYtafo6cG
 C1gXsuagzkpTlzU0tAAwAtw8KXV9JR2SR7RfS7r789WQ5i+C/bKGVvTJTomQAmCfAswR1QR+DMP
 nPkz+2G2kJeuBcMOfozVI7RcLWfTAAz5dzbWPoOL2rqFoVhvrnk27KVzki9CBt6LnDa0d0/XlKt
 yJUGwbXk2oYubJXmvNtFgUHW5+zS80AfLSrnCO73E+gMCi
X-Received: by 2002:ad4:5dca:0:b0:91e:8c55:dffe with SMTP id
 6a1803df08f44-91f04145d48mr92080756d6.26.1794489569947; 
 Thu, 12 Nov 2026 05:19:29 -0800 (PST)
X-Received: by 2002:ad4:5dca:0:b0:91e:8c55:dffe with SMTP id
 6a1803df08f44-91f04145d48mr92080376d6.26.1794489569489; 
 Thu, 12 Nov 2026 05:19:29 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com (189-68-253-226.dsl.telesp.net.br.
 [189.68.253.226]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91f02efe5ddsm46350186d6.19.2026.11.12.05.19.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 05:19:28 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2 1/1] target/riscv/tcg/csr: filter bits when r/w HVIP(H)
 [GL3133]
Date: Thu, 12 Nov 2026 10:19:20 -0300
Message-ID: <20261112131920.485933-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112131920.485933-1-daniel.barboza@oss.qualcomm.com>
References: <20261112131920.485933-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KsnYSmWN c=1 sm=1 tr=0 ts=6af5bce3 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xcxBfRYLw5hNHjR815/AfA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=CAa-Uoc_l-2XtQuzupkA:9 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: ZpWkuCQHvd1VVkA5b-8QwANCh3txQCRY
X-Proofpoint-ORIG-GUID: ZpWkuCQHvd1VVkA5b-8QwANCh3txQCRY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1MiBTYWx0ZWRfX4vr9y3NtukUJ
 EQ3qda2Qo2VSG5AmVYy64VRTCjz9kcyIrcB705foew13sMtGIsbpoHBZd6Vz99LxXE1xCai1M8m
 ttwGenjGY16C0XBp4StLuPBXro/fG/bbCqFoFdy6X5zgs8kRNklcxyqSxRGiNNhziVkkHPeUgOm
 oi3qnNrmMgvF374uh+xM57XQpjDy3o5yVZ2vZ8a3E1k9ZL6nQsYaSuIhdL7z229kmO6cHyxwnJ2
 rGYNOhcRRsW3kfnlK75ECa4ODN8dEWzoCydCzSIDTKE3xJES/RJCYXIsGPPvEujUxt5IXySZQIJ
 itFVmx9tSQ0aRgyzaF9kYc9MkfdCLYoGPi4ewUG6CSJGBUwW+NOq68cmFbRTJ9QTHg3xXZi6Y6Y
 sA8rWUZYDRPH3x4drkqHIAzL/MZLTh3TA53j1KbtP5Pzn52jXWkW45Y58iKAbmmXZ0yQmDMDoHf
 m9qvk86yN7ux/qMRo3Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1MiBTYWx0ZWRfXzXjITKTORMQs
 slq8Yei802MVWorniu7TZPOtf6C9xoPL/z9e+Yy1lCu/3rt9krIssYiLRUyt9LvqONRCkp3zI0D
 MQ5R+i2XgzOD2/+9BF2+oCTI6B61EpA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120052
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
	autolearn=unavailable autolearn_force=no version=4.0.1
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

As a side rant: I am less than pleased with how rmw_hvip64() is turning
out.  It's doing way too much with way too many CSRs (hvip, vsip, sip
...) and a bitmask salad to go along with it.  Every time an issue
appears we have to patch up a specific piece of it, usually related to
one of its CSRs, and hope we're not breaking anything else.  The
alternative is a full refactor of all the CSRs callbacks involved to
decouple the logic, which isn't the greatest time either. We should
definitely avoid this kind of design in the future.

Fixes: 40336d5b1d4c ("target/riscv: Add HS-mode virtual interrupt and IRQ filtering support.")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3133
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/csr.c               |  8 ++++++
 tests/tcg/riscv64/system/meson.build |  8 ++++++
 tests/tcg/riscv64/test-hvip-read.S   | 41 ++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-hvip-read.S

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index af444e3e6f..9b67f2d764 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -5078,6 +5078,14 @@ static RISCVException rmw_hvip64(CPURISCVState *env, int csrno,
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
index 3c8b018d9e..7eca59222c 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -89,6 +89,14 @@ tests += {
   }
 }
 
+tests += {
+  'test-hvip-read.S': {
+    'cflags': cflags + ['-march=rv64gcv'],
+    'qemu_args': ['-cpu', 'max,smpmpmt=false,pmu-mask=0xfffffff8,smdbltrp=true,ssdbltrp=true', qemu_args],
+  }
+}
+
+
 if 'qemu-system-riscv64' in emulators
   tcg_tests += {
     'riscv64-softmmu': {
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


