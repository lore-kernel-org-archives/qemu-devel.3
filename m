Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62161606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 22:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GWtnE5ym;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Zis9iCD1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4k9-0007EF-PD; Mon, 16 Nov 2026 17:00:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xT4k8-0007Dg-4d
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:00:04 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xT4k5-0004ZT-Im
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:00:03 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJemDu2727626
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=OITfEEFOMOPjG7km3DWnOgun6SfnFHYqU8f
 aQoA07hg=; b=GWtnE5ympprTzmv+eUqVOrnK6CXVbJ1SX+amXGHYgixt1JktRWx
 aXhrL/Jo7UZXCRMrffS+gDqCJuy5hNpeMuJ2SE9+8UFTvywnZzJai5Zap6pwff5c
 nElNw+v1BdkS0kuWKq8lqDwqDP7gcc0wkspz7XCw0A1qUz2gekeBBkeq2nn481nK
 qJ4/wNKjgRQ4n+SAQIb1lg3EJR6wv/AfNMla0oiqPkulyw60G9N9yCvjkCdbCO1Z
 3TD97TK0fEZKGKXI97krSDNpWmuaYASL76HoG8lh3m8XIHvW2+52KABYCgt8tcQ0
 tJ3dIevFrIqIbqnJgUQUpiiDGnKBWNXLlSw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j07regkq3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:59:59 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-544019b1831so33890451cf.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794866398; x=1795471198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OITfEEFOMOPjG7km3DWnOgun6SfnFHYqU8faQoA07hg=;
 b=Zis9iCD1Iv7WWCN3cCi3f5pS9Lx45LaJo8yBdG8iXNo2cIt4IruDfj4pt+CrRSoA+U
 ew+sRxdKsgCwbDIKL9WFdeRhlldtzboUvlteHzDuLJtGruTy7MIgCKxEPij69Z5Ld6Jp
 GhRU7fejdwliN6Tgo5a29LRlnr+RiAuAnZQCYQebu9Fg9Q+zO8oWK5ZwYOTdexuQGsw6
 oTbPVxJA9Pw4+7qZs6XpKrNo6Fz0K8EdocILMSE44lFD063yb2JBLnCAaxem5kQ9Z1v1
 0bblTPPAbVAsTU5qml8uNFhS4PAgRLawg5AWiJJE3JTNLBeen8tuoDjsosvtCIz4H2Xp
 0+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794866398; x=1795471198;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OITfEEFOMOPjG7km3DWnOgun6SfnFHYqU8faQoA07hg=;
 b=Y9rt9bdl9T10OUyj9WkZMnAS2U+KJjWAE6unueD+6HZy+vfsQs4QMPw9sqZCZq1FhJ
 2TrNHKF/gOEK49CkPCdm4MuMI69OM13n06E0bqJGQ0Uxur2DQmAiL9sm2g/E++PUNbX5
 orXFtTqpVWW3bue4Mr6BrAwegax2gTyrPfCkvrBTOjYwMAQMiI3K3xoCrQJJp22V8cwf
 X3xykV6ocn4r8lFBeL8FoLB23ylWQYLbC5ZnH60n8R3kKCaz5H70nKatU0QTb1tweWa9
 snDeF7EgLvZ1k+ttFCPQMYSJ4ewB1ppvxYR1xQtWiIOLNFXFhqE7MGl9fZGfLgsm8WRp
 c+Ew==
X-Gm-Message-State: APuU4Z/1MmX8HwEteRD3U11gND76b7i69ETJBhUsw9DU+Dtbsj5FUEqD
 1Y/4H4DhbaYxamFuktqk1Uq9HmFAgw4OlN69PTnZFr7bvty+QMHovwh0DlBT1U0LGYBCMTJy+rY
 lFnIEOLx14NXgOJ7JhTkIML40AjmF16Wm2iM86vvGDMg6Jm+S4WKvoy0wuUo4OpbZrg==
X-Gm-Gg: AYBFou1S1AlFAxYsFp/ZYnMarpblfcNQyIzVxDSpQaYERN5QzBwCqZnl8MBwlTn23u2
 tnXGJ+9bRRm6ecZXyExn7BZs42NDSuCHjRpDZqitrqm3vA/5eTWyWt9BDzI8CrR31GHwkqzgKV2
 ciMc8KFBBQ+lkknzpmoXsqAbt64t82wiCd81BCdCGeaCHf68he3XjJpZUIkca2u5WkOvMc64dgf
 2OzbCFEoPH1qoYD7b1bzc7+r0R1rQCN7cpPsv7PELGpaFxl8sOmYJGP1Gsq3yNtmVUf2IV4d3aL
 5IQT/nrKsJWzKZigi1F2E8XtjnUQVuGt4JjBzDISFqOBF0zcgw1S5wNNbEBdHc9+v2N3yt95Ubb
 UAPUfQEvaeqaYv7TfhJ30YPqj/rPYEcTmB+z2Nccn6yZSqaKGsKOaXgQcvd/GVSRYE9FUEH/VbF
 KPwsXnaGFnd3Y=
X-Received: by 2002:a05:622a:1a8d:b0:535:856c:1241 with SMTP id
 d75a77b69052e-55ac857cfb0mr193835781cf.56.1794866398032; 
 Mon, 16 Nov 2026 13:59:58 -0800 (PST)
X-Received: by 2002:a05:622a:1a8d:b0:535:856c:1241 with SMTP id
 d75a77b69052e-55ac857cfb0mr193835551cf.56.1794866397585; 
 Mon, 16 Nov 2026 13:59:57 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.227.223])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d2cdcb6b2sm51443981cf.20.2026.11.16.13.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 13:59:57 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH] target/riscv: do not write RVG in misa CSR [GL4811]
Date: Mon, 16 Nov 2026 18:59:53 -0300
Message-ID: <20261116215953.871862-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NyBTYWx0ZWRfXyZwG/OyvINM5
 6Qd71KxTprGrizp1TKaBn5xzsuHM9uYg/4i3+/lNZgKqoYKh7lTCo+L+S01BtQDIkv8LUVPEEAy
 xmrt/VsZexBBlRyOcgxctVRX3cbcJo0=
X-Proofpoint-ORIG-GUID: MixDSx2Sanfx2Q3UQDb_Jx_zZWqZq1ng
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NyBTYWx0ZWRfX6TXNMEJw6rhI
 Pk+oy/TB8bntopt8VapbWFsZFeXfJREaQDXr3NXtRmXMNathYHG/dAt8dv8p2MaJIdMmZaFN97f
 Z4YMGeTH+5escArTbXBAj1piZyp2vtTe4KOL1KoRksmvWBUsxfWJ8zMUBPKK+tyRgw+nbI31Y2M
 Cyk3J8KmUaw8otTfVj4gQ1lMpeGNso1jDxXSsQ1mISB4mBY1R/NENpD0CH9zp7FgWMsxammNciy
 8RkgrwU54IM0sS/Js0EKk/5ahftLKcDDOPy0KaUNr8isf0ZRJcHHO+Q8eZYAS60NMGi9S1Kn/bw
 w2Wj4e6dAMoVKQ1rMLmlIRnKDDhYt3AdzTnmwm0yk1IPKgPOLTWHICvcyrvUAxUWlTj34JiLIlW
 CXUOejlxTqhN4JuACIac4dmHooq9AkKDiIAgq7frHV3NzV0M9Ef6cM7sKKBjDv9Zs5U8BE8jVH6
 +Xlh2LnjVoa/x+DcxZw==
X-Proofpoint-GUID: MixDSx2Sanfx2Q3UQDb_Jx_zZWqZq1ng
X-Authority-Analysis: v=2.4 cv=R9uWitRX c=1 sm=1 tr=0 ts=6afb7cdf cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=WERq1Tg1Nl5IKGfG0e6imA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=8KXoJSeSmCOV7nyX5AcA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160087
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
	autolearn=unavailable autolearn_force=no version=4.0.1
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
Update the bit description in misa_ext_info_arr too for clarity.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4811
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c                   |  7 +++-
 target/riscv/tcg/csr.c               | 17 ++++++++++
 tests/tcg/riscv64/system/meson.build |  7 ++++
 tests/tcg/riscv64/test-misa-G.S      | 51 ++++++++++++++++++++++++++++
 4 files changed, 81 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/riscv64/test-misa-G.S

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 15c27f4ce4..3b32d79609 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1620,7 +1620,12 @@ static const MISAExtInfo misa_ext_info_arr[] = {
     MISA_EXT_INFO(RVU, "u", "User-level instructions"),
     MISA_EXT_INFO(RVH, "h", "Hypervisor"),
     MISA_EXT_INFO(RVV, "v", "Vector operations"),
-    MISA_EXT_INFO(RVG, "g", "General purpose (IMAFD_Zicsr_Zifencei)"),
+    /*
+     * As of priv versions 1.11+ the spec marks RVG as Reserved.
+     * Internally we'll keep using it as a shortcut for
+     * IMAFD_Zicsr_Zifencei.
+     */
+    MISA_EXT_INFO(RVG, "g", "Reserved"),
     MISA_EXT_INFO(RVB, "b", "Bit manipulation (Zba_Zbb_Zbs)")
 };
 
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index af444e3e6f..5f8f0dc8a8 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -2200,6 +2200,15 @@ static RISCVException read_misa(CPURISCVState *env, int csrno,
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
 
@@ -2228,6 +2237,14 @@ static RISCVException write_misa(CPURISCVState *env, int csrno,
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
index 3c8b018d9e..8e7c29a7fa 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -89,6 +89,13 @@ tests += {
   }
 }
 
+tests += {
+  'test-misa-G.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'max', qemu_args],
+  }
+}
+
 if 'qemu-system-riscv64' in emulators
   tcg_tests += {
     'riscv64-softmmu': {
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


