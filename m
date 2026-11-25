Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44184606A326
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 13:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=e3WeL0OG;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d1CpLlSA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWCwi-0003He-Te; Wed, 25 Nov 2026 08:22:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xWCw9-0002e4-9R
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 08:21:26 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xWCw6-0000hT-B7
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 08:21:25 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AP9nl9R1505274
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 13:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=pM55NgWylpr
 Yyzqaga+eBZrqcAOm5EF3HQc27luHc2w=; b=e3WeL0OG3vE/ON+mKcbfGptMwsy
 ow3jSs7K7GC0pYMcvWlq3RO8G06g3gZ44Mu7iY1eGPRfrlV+DE5rGnIZ9jYRub6m
 DgSinlkiGFP9MLx35v0o48+YuIgLeT5lmKIcffTfXKwZmRSsgCt/Ypr8t0019YlM
 a4n2qjxYsQdI1IGoZBk5f5HAcaljLjHVaEPvErnxaBiMDsqOKUblvk3211ypjsaF
 WSvqQJNiD1aikqYkQzoQU3bkkZuu7U9ZVfCOUWHEUpGEAJ9rkw216u8+B5BaWniL
 DfzAczvWuvJe7uwhs8cIzBARu4h6uUAOHV8BZx3LNY6zU1Y5SzgchvpwL+A==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5qa2ac9d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 13:21:11 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-998a2b06e4eso1006906241.3
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 05:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795612870; x=1796217670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pM55NgWylprYyzqaga+eBZrqcAOm5EF3HQc27luHc2w=;
 b=d1CpLlSAhNFmbHCzec8EYFrwq8mqVLYF9nBxaDCpZSROVKAq/MlWnfhbCTgMqXxnEq
 RmwJFfC1exozXFeLRZYVwycM5KfQ81Ca/Z3EeE5MDNTpXU6G0An+BC4vs3SJhDuABdXg
 tx3yZPaZD6fHmr+2KcjidzaAo2czZoMLil8wbWpyy7iXo2nzcuOMynGKRhHfU7bvgeo+
 rhNQquVm9X9hQWK+/ZLRNtPIR7KvC9ScC1Tep+6nYuvnm+RYNfVF8dsICm/jlwMDg++C
 wu/DnYFe+xol+8ci3+PpB5aWFNhFlsD2OB3ZRq5/+sheIfp/GueG42Uis7dyLW0DGX7H
 Y3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795612870; x=1796217670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pM55NgWylprYyzqaga+eBZrqcAOm5EF3HQc27luHc2w=;
 b=mWqbLUuXq6/KKbD6OK6oj8m5WZKVwlVADjn4xPHbaqQxs5nbuBcRJ3QjzqdfXlNnb3
 nYTpOx+rGKr/Tjshkyj2Smqj+CjKDP/r30wNZRsj6cbIFTrXYSYMchuXdlNyYP0cA2ld
 UySd/C4jXhnI8d5HbBcdjpfOk31SpDLm9Gqk0apNwY40h3Qj2Iko0bSeR9/oAQ/orFAc
 JM9rIXmedr57Ls20D5TkxalAVdI/Ta6/f+pnHzjJEirNne4wp4+MxlC3tFiH21F9aPaa
 kvV/zxcUYpMZ2eDdrCaaftA61Voo2Qt7uVOz+3XJ0xTzm9p1vyR3oPgErTVjJavILSEy
 0vKQ==
X-Gm-Message-State: APuU4Z98xeE+IqxKcb51bXEdVQpW58JF0P6iOFrRnPWMSrY6InH6MMbg
 JyGm7plypUD9EDaP+v0J5qXRM39gB7Z6I2c3vrApRF3rUoqtpqOx0EakVbEKYYLE1AqLGyNBMPi
 JhnYvEH7UehzD3Guwe+HQ7OVxd1z1XlaPb6XanPmaTF9dsLIESbAKYkRNYXxXOv7d+Q==
X-Gm-Gg: AZFdTZcu5vfcJcz3FPvlIvWRKqQ0OuJp33Fsl/7YtQyp56HJ6bNRKGWv/HRqSbAnCVe
 J257UBbuV64hdxt4hi/pk1ORd4lHU0JtOpgMlE1Lu0Sui5MwTv+oFfXnKu8MoWLhg4SBzmEnVqm
 5MnzdCGjlmntSL1mNJ6U2j30ivW8xFmqVvh3i00gonMo4Pm3cEUUUj+qZv43sgc8UMcY8IXUnjz
 5BOCDJ2twjfk951oF1aCj/RVq2wZDf9lJ8SS1Q2XaU70rc2VQwRxpU43/fndMyrWHDxsEjree5Y
 EQhmbAqNw2wyiNFl/0x/Pa0mQM0H13v0F6Aft+Jb8dF/2cWE8tZ3fbDAZ5iDE/8TYo0uK7PUI8C
 AIQnCgDb0vok0VceYcq97SuXcbxNhu/ikXabFIPiifYYOR3y08F+5Qa/nuLxTqR7Fl/cb3FOrH9
 XYfqKdAD7EXw==
X-Received: by 2002:a05:6102:688c:b0:7cc:2cef:b341 with SMTP id
 ada2fe7eead31-7d72b35f75emr7797061137.4.1795612870317; 
 Wed, 25 Nov 2026 05:21:10 -0800 (PST)
X-Received: by 2002:a05:6102:688c:b0:7cc:2cef:b341 with SMTP id
 ada2fe7eead31-7d72b35f75emr7796971137.4.1795612869628; 
 Wed, 25 Nov 2026 05:21:09 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm160836946d6.34.2026.11.25.05.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 05:21:08 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 10/15] target/riscv: do not write RVG in misa CSR
Date: Wed, 25 Nov 2026 10:20:09 -0300
Message-ID: <20261125132015.229955-11-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125132015.229955-1-daniel.barboza@oss.qualcomm.com>
References: <20261125132015.229955-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: IjJ4n1VLjK8eQW6sTe8ARg45MF50zbsG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA1MyBTYWx0ZWRfXwXoSAwdnwp7D
 AX0DEjxgYM/eooNEAcJGZKscHsynph5a90YFliopzWqr2X+2b+v77zGLQfSW7VPUO+/bqS1bY6W
 C+i5xJBVXC9Nl9E7dBUBTlDRBp4N2uY=
X-Proofpoint-GUID: IjJ4n1VLjK8eQW6sTe8ARg45MF50zbsG
X-Authority-Analysis: v=2.4 cv=CKu/zhrD c=1 sm=1 tr=0 ts=6b06e0c7 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=D34z8tFnLgwhCRIc9k4A:9
 a=1WsBpfsz9X-RYQiigVTh:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA1MyBTYWx0ZWRfX/Vz1obE0FGAr
 YpfDIeubTxaL6+p/GtCLzyEsTsmIWMmb7II9s9656xvdh7fhQYT7sA/HZRLWRtKHoHipxQayaCx
 0khyTaaiibUV5EzzDIzFIs6GUQuET7VS5Ki5Z3K79GssOQL6XNmJfC/WFDRylGEEBGBAcEn3Heh
 NEUdLAeTHRW9twjo3i6f4zuZRockGFsbCBVjtn1Tjz2NV07u0eOPJ2QjhR8O1V9W059tV6qtto7
 n5pXsSgXwjn1OC/BCpFOF71HcbUq3HRdxuusGnjyAf30rtpKq8jM+s87GHGWHa2P/5VHgJYX56r
 +nB9XYd2T/nTDWunupmeKXgW7Y+1O9sjPvpusvIicG72lnMhG94/t/A/WsqNYMiXsETtUU6FNZm
 OZd/k400vm69FtjC76ZrnDFG8bCoprM35le2ALsjVS+cd9BRBhXCk0AhfjKqLjLFoXBDVwu5NY5
 0rIy/EUzAuicC/mGP0w==
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

It seems like we can't write RVG into misa.  The bit has been marked as
"Reserved" for priv specs 1.11+, i.e. it does not represent the
extension pack "IMAFD_Zicsr_Zifencei".  The official explanation, at
least from what I could find, is that setting RVG is redundant with
reading riscv,isa and/or other extension discovery mechanisms.

To make matters more interesting, 'g' is still supposed to be present in
riscv,isa.  Toolchains will keep using 'g' in their 'march' normally
too.  So aside from sparing one bit in the MISA every other use of RVG
is still valid.

We have a good chunk of code that uses RVG as a synonym for that
extension pack and, for now, I don't see a reason to refactor it.  We
will cross that bridge when/if RVG acquires another official use.

For now, if we're running priv spec 1.11+, filter the bit out of misa.

Fixes: 4f13abcb2bcb ("target/riscv: add RVG and remove cpu->cfg.ext_g")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4811
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/csr.c               | 17 ++++++++++
 tests/tcg/riscv64/system/meson.build |  5 +++
 tests/tcg/riscv64/test-misa-G.S      | 51 ++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-misa-G.S

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index ab278a97bc..929ee0a279 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -2239,6 +2239,15 @@ static RISCVException read_misa(CPURISCVState *env, int csrno,
     }
 
     *val = misa | env->misa_ext;
+
+     /*
+      * RVG is reserved for priv > 1.10 but we're setting the
+      * bit internally as a shortcut for IMAFD_Zicsr_Zifencei.
+      */
+    if (env->priv_ver > PRIV_VERSION_1_10_0) {
+        *val &= ~RVG;
+    }
+
     return RISCV_EXCP_NONE;
 }
 
@@ -2267,6 +2276,14 @@ static RISCVException write_misa(CPURISCVState *env, int csrno,
         return RISCV_EXCP_NONE;
     }
 
+     /*
+      * RVG is reserved for priv > 1.10 but we're setting the
+      * bit internally as a shortcut for IMAFD_Zicsr_Zifencei.
+      */
+    if (env->priv_ver > PRIV_VERSION_1_10_0) {
+        val &= ~RVG;
+    }
+
     /* Mask extensions that are not supported by this hart */
     val &= env->misa_ext_mask;
 
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index 9cd62c27e9..d91e28a4d2 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -161,6 +161,11 @@ tests += {
     'cflags': cflags,
     'qemu_args': ['-cpu', 'max,smpmpmt=false,smdbltrp=true,ssdbltrp=true,smrnmi=true', qemu_args],
   },
+
+  'test-misa-G.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'max', qemu_args],
+  },
 }
 
 if 'qemu-system-riscv64' in emulators
diff --git a/tests/tcg/riscv64/test-misa-G.S b/tests/tcg/riscv64/test-misa-G.S
new file mode 100644
index 0000000000..45a9ca720b
--- /dev/null
+++ b/tests/tcg/riscv64/test-misa-G.S
@@ -0,0 +1,51 @@
+/*
+ * Test if RVG is being set in misa.  See Gitlab 4811 for more info.
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
+	csrr	t0, misa
+	li	t1, 1
+	slli	t1, t1, 6
+	and	t1, t1, t0
+	bnez	t1, _fail
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


