Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE8C606A327
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 13:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WSBy9Xq5;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZepmLPBQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWCwS-0002xC-B3; Wed, 25 Nov 2026 08:21:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xWCw6-0002ch-2j
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 08:21:24 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xWCw3-0000hA-He
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 08:21:21 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AP9nkdI1505230
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 13:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=AXicM3Mh6jJ
 AQVtaO5GwbmYkrNPeKd0dBrezBkpOjlE=; b=WSBy9Xq5UdAqAd56FDVW6vfWYFf
 gIOaytwT+dsW16BCrlw9mRnj7QdLvSXdwaCXEry2OUkACFk/SvQ23Em2N35K1Adr
 SjX6dSg61QaKSJDRCIr0cajhY4gKh2zib+idRy2ew/CAgKjjU0C0GHAWJLOJXfLs
 IlMZqai4hYpQhQNIFbcp9JKC5YtrLViNR8d84MPTUTbh5oGq0RFE8Fyi1FFsaOXK
 /FZpqMdMpHBOMJ5cI756gaB41ZuSliEkKKzCpMdhuUHSIZJmHlj/S2LqBQCrxOai
 53uSzV3EisicN7mwpoBj2Y8rT7cX8yBrZCqNg84v4Vh5TL+Q8zQBbPdI+ug==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5qa2ac92-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 13:21:08 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5eacd2f2229so4910774e0c.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 05:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795612867; x=1796217667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AXicM3Mh6jJAQVtaO5GwbmYkrNPeKd0dBrezBkpOjlE=;
 b=ZepmLPBQY7x7srkkqFWj6Ty4aQvHPGKWhhwwbi5utUANEPM8+nC0k7nGsg/EInZ3Q2
 5vz9aIi7vikXjQ7xnbmtG0y6HJfged6W6bXMD6OgK/lGkJOCYxQcdEsreX+thwCJEXVv
 T5V5kPB85fSXMgOOVVYmn2PLm0ABICMddID+NyARuWv1vWQIK8n9Qfu1Wz0PyziqammU
 dVpOT422Gy1Rr3PsR0NBZRt4Any1w2frbEEbWJZfAibXePsSXRZ3Q5TTYKYv3TMcSafK
 2v+SV2Gxk/66Y2gIOCEjENIdUmXWln/xaEDF9G3cw+8O/5yRJefbGaba+PdXMzcx6BAI
 y3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795612867; x=1796217667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AXicM3Mh6jJAQVtaO5GwbmYkrNPeKd0dBrezBkpOjlE=;
 b=JO9G9FinJv+3yTMPD1O1qHO1EfTWOnSQF9GfLiPIkiNQvv/3hrpuGiKdm2CEbVtn0H
 p7+oAin1QgvkRIwzpZJ6vlzYUjwhT7EqIvWpGjtSzk9HSAMDxmZA8bRoy+3I0abW7rQ6
 n/A16dPw3Iymt9No6+XeW0fCjITRFvvh6czDdo8uWoK8FP8p6WG1gT+H6ajwU0SG7kTo
 FamzUQg17p2VVIlF8iAtB+xMVA8aU9zslATF0yj325+BtCaANeSrCrdXGp+hRbsOWto0
 ciZBkKQGE5HcEZ4NUZJfBSOlI7OXM4GfDuOKRhLx+jibTJnEXTx7gcqGAp8pTDIpWErp
 OM8w==
X-Gm-Message-State: APuU4Z+RRYgdX2ixrUdhsM890jOI0iEvfaeuyAm21hbc9mpkEzTfpJGM
 hH/jZmQeu9tg+YgHe0ufrqCtg3vWwrhzXED4lahP+7m0RMfL4UjtJlZdAc5ftjVM32ZWag+Y8Ub
 2JtpqY5byZbFX0dlB++aNrGHISUBId9R2lk8aQ0taWK4MerQyEs+0pCVpCPdAAVbwcw==
X-Gm-Gg: AZFdTZdtPST8JSuP3gNle84aUrDCASESFMoyV5GCPhurKtzAgzHC5K6c+p+7RBCyOsC
 jRD3puSO/MqRes5otM7MfEhLDmvUW1Gcyd0vde9Xi3G5hkoxbqq4UBfe/DyFtd2zVErrExnoMzM
 uq0gY2AJOFbmzCAxLHJOQ4CWsOpxCf02A58zB9DDmLLZYyJPc2hKyPFaBqDnP5jfMgYuBownKh5
 YlesRudGBelO+FH8fZHrlZ1ve91uhZRpLAAD4jh5QREEo1JXJL7dsg82FMKs8wAAHCXd147aIb4
 rUD1yna2Q9xTRPUvBKGRcSIQIyZURZ29M2fLQd491m6q721nGQxRsoOfABEdMTPYN2JnKQR2MZg
 HzrXQe1+yV2w9U/CCJBQzOfldpTvctv0xR9udYQAcOx3sGYvTnuXICKAO2fmNrVj4UL0pm/uVnE
 +QGDvBHmpCaQ==
X-Received: by 2002:a05:6122:1d0c:b0:5ea:b991:d489 with SMTP id
 71dfb90a1353d-5ee8aed6f75mr10496236e0c.13.1795612867382; 
 Wed, 25 Nov 2026 05:21:07 -0800 (PST)
X-Received: by 2002:a05:6122:1d0c:b0:5ea:b991:d489 with SMTP id
 71dfb90a1353d-5ee8aed6f75mr10496183e0c.13.1795612866761; 
 Wed, 25 Nov 2026 05:21:06 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm160836946d6.34.2026.11.25.05.21.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 05:21:05 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 09/15] target/riscv: sanitize mnstatus.MNPP field
Date: Wed, 25 Nov 2026 10:20:08 -0300
Message-ID: <20261125132015.229955-10-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125132015.229955-1-daniel.barboza@oss.qualcomm.com>
References: <20261125132015.229955-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: QfcnKrtlLTYcPxs0gi8GxfFPeWacvwb3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA1MyBTYWx0ZWRfX9ht+WY9dSNw/
 nfl/JyS3UyVWeSAJK+nnJtmdxwurSl16ay7Kafog0irc6L+XmXnWPX04AVxhb5miMncLr0osEyS
 kunQbC7DDxzPhvvAO+Tj7Cz1X/BY/ws=
X-Proofpoint-GUID: QfcnKrtlLTYcPxs0gi8GxfFPeWacvwb3
X-Authority-Analysis: v=2.4 cv=CKu/zhrD c=1 sm=1 tr=0 ts=6b06e0c4 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=UnszTeD0MEx6vb_Bg3UA:9 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA1MyBTYWx0ZWRfXx0wfP0k+3REV
 jfN+E2Fc9EcUv/MGVDVg3yoG8u01qNrXx+p6jFewaxe5Ot/+bG3UIxlzzesseskmueUPAFfAs4P
 sNx7vAP15fOVua5T329PKcGwEfk1fNOV64TlcCJxQp7Iy5gx6rqk39i0aoLRXqqaYJopFbVK0aX
 xQeLXJ0mN/AJfJZyCZTgfoBJsq5uTpyRyfFjZSMPu+zsMCGoVgfaBe8bCb/xL4law2KTO/jGlVc
 vp5BpXGBzb1sGAG160M217rbQ0rZFamybI3gWqygzF98z9QTeu4VUFmJ2fBdLkKhkh5Z9XdVwqo
 yIspQCc+3ibskPhe4xb2I/Qg5z86oNQQ7R/nD9m2IuTpsedciAXRUE5IUYb4y2kZt39vobNTJf5
 rD1iYwEVQcKyyfhlSjhui09iq9LPeRRQphDnAJBfI0jxEIZRr0giu2XK5BFAx6gt8UvOi17iDBn
 yhf6r6L72CRUPq/EFGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250053
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

We need to handle mnstatus.MNPP the same way we already do with
mstatus.MPP - do not allow the reserved value 10b to be written.

Fixes: 5db557f82bff ("target/riscv: Add Smrnmi CSRs")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4826
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/csr.c                        | 11 +++
 tests/tcg/riscv64/system/meson.build          |  5 ++
 tests/tcg/riscv64/test-mstatus-mnstatus-mpp.S | 75 +++++++++++++++++++
 3 files changed, 91 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-mstatus-mnstatus-mpp.S

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 83eb44a590..ab278a97bc 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -2024,6 +2024,10 @@ static target_ulong legalize_xatp(CPURISCVState *env, target_ulong old_xatp,
     return old_xatp;
 }
 
+/*
+ * This function is also used to legalize mnstatus.MNPP since both
+ * fields are located in 0x1800 and uses the same encoding.
+ */
 static target_ulong legalize_mpp(CPURISCVState *env, target_ulong old_mpp,
                                  target_ulong val)
 {
@@ -5891,6 +5895,13 @@ static RISCVException write_mnstatus(CPURISCVState *env, int csrno,
 {
     target_ulong mask = (MNSTATUS_NMIE | MNSTATUS_MNPP);
 
+    /*
+     * MNPP uses the same encoding as mstatus.MPP, ergo we need to
+     * 'legalize' it the same way.  Since they map to the same bit
+     * field (0x1800) we'll just the same helper.
+     */
+    val = legalize_mpp(env, get_field(env->mnstatus, MNSTATUS_MNPP), val);
+
     if (riscv_has_ext(env, RVH)) {
         /* Flush tlb on mnstatus fields that affect VM. */
         if ((val ^ env->mnstatus) & MNSTATUS_MNPV) {
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index be9d892a95..9cd62c27e9 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -156,6 +156,11 @@ tests += {
     'cflags': cflags,
     'qemu_args': ['-cpu', 'max', qemu_args],
   },
+
+  'test-mstatus-mnstatus-mpp.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'max,smpmpmt=false,smdbltrp=true,ssdbltrp=true,smrnmi=true', qemu_args],
+  },
 }
 
 if 'qemu-system-riscv64' in emulators
diff --git a/tests/tcg/riscv64/test-mstatus-mnstatus-mpp.S b/tests/tcg/riscv64/test-mstatus-mnstatus-mpp.S
new file mode 100644
index 0000000000..b3a734ccf3
--- /dev/null
+++ b/tests/tcg/riscv64/test-mstatus-mnstatus-mpp.S
@@ -0,0 +1,75 @@
+/*
+ * Test if mstatus.MPP and mnstatus.MNPP will write reserved values.
+ * See Gitlab 4826 for more info.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define CSR_MNSTATUS 0x744
+
+.option norvc
+	.text
+	.global _start
+
+_start:
+	lla	t0, trap
+	csrw	mtvec, t0
+
+	/* Set mstatus.MPP [12:11] and mnstatus.MNPP to 11b  */
+	li	t0, 0b11
+	slli	t0, t0, 11
+	csrs	mstatus, t0
+	csrs	CSR_MNSTATUS, t0
+
+	/* Set mstatus.MPP to reserved value 10b by clearing bit 11. */
+	li	t1, 1
+	slli	t1, t1, 11
+	csrs	mstatus, t1
+
+	/* mstatus.MPP must be equal to 11b (ignoring the last write).  */
+	csrr	s0, mstatus
+	srli	s0, s0, 11
+	li	t2, 3
+	and	s0, s0, t2
+	bne	s0, t2, _fail
+
+	/* Set mnstatus.MNPP to reserved value 10b by clearing bit 11. */
+	csrs	CSR_MNSTATUS, t1
+
+	/* mnstatus.MNPP must be equal to 11b (ignoring the last write).  */
+	csrr	s0, CSR_MNSTATUS
+	srli	s0, s0, 11
+	and	s0, s0, t2
+	bne	s0, t2, _fail
+
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
+.balign	16
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


