Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3FF606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 19:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pg/D9OAf;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RE1sQjEZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVZpX-0005mS-LP; Mon, 23 Nov 2026 14:35:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVZpW-0005iz-CC
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 14:35:58 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVZpT-00078A-Jx
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 14:35:57 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANGGn941861277
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 19:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=KtqUjFtWrSZ
 y7K7Y8LNBI6cbCxUBBpYSQViEGae15fI=; b=pg/D9OAf8NwNB/2m+9BQ1uNrgGV
 qLIV7vJDk8MLu3XJ9iCzp5sD42BrI+lxuMB2h5fNmBD/BDivVNk3cZwSV+nmR8iq
 cI1XRoJc4VTucymTpIqjE96WrSaf/iYSxOVf1sLK/uDI4cmiTh9VJ7cL8w53qvq9
 nMog/s1jBMSsFtiZZapCCNPUh5IilZj/BC22R5rLJr4CVbeIjY+IEQqwBcrqlrDi
 bXO5z43pkquNWv19LOAL5GeHPaqSUgpn545kRuRJbFouEqcxulV3ax4PWp1zaK9V
 l4JdUf3BGEH7LLqsr3ibt1622G7PF77rlajL7ICPIvNk89qTeBdnHT5lGMg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g9a33h2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 19:35:54 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-544019b1831so77071911cf.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 11:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795462553; x=1796067353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KtqUjFtWrSZy7K7Y8LNBI6cbCxUBBpYSQViEGae15fI=;
 b=RE1sQjEZoLHMhcIWV66QLni3H8S/nbl7aIphMao7ozHxQ0ExKjdkta7G7H9cLgOi2Y
 pbJN03CVkkG/XW7hZ8foF7d4UFkjB2P5kgkMjOt979DTmCL5W/GZxCvVnTyq7RPJImtH
 SHWxdD4hTPt2m4V9x9T+U/obWJN4rUamzQuPX816wXQKBCzRF7ee0RNHLT9DX1aqt3/k
 qvSgxWGrTX+hxGT29t0aFnwWOaXulY9YD1BzGbiCDKKd7TD6NcYkV4BOiNXf9b+ilSkr
 Hip+jqFlUYNCjNubI71jYuSYzgdJpTrojCtc6T/T89NKXTZwNleyfHaBClEdPWRZTV91
 UapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795462553; x=1796067353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KtqUjFtWrSZy7K7Y8LNBI6cbCxUBBpYSQViEGae15fI=;
 b=EcsA9mJ9UxeA1KgC9imnSkRSE8VKg88fgxQodiS+yHl5Hnc7SO8iBVDBTn3FrRhFfF
 7Asp26owBrtQpm6FD+sqmJgO5UXrXNBdsxpvq+CbFasabilE6wYWnJJnPxUXHWOt9lU4
 xPf8yeQ4Xa1A1/6RBeHCkFMn1QUoaUsNRrXdTL2LeSK9/3XVRMJv7C1tQ5Eq8fvicjLx
 s2n8+XZ3sjtPl94fJ6L+vbYTUt1gCGNn/zJAkWADo0MVAWnBDR8MS/kJdtEEbeX6amrw
 knJn922GK9rJ45iM0sHggVBIkf99HXkzNzBFZMWTnALoPGy6vRxDSqfYqkpCWqH+r6Xq
 agUg==
X-Gm-Message-State: APuU4Z85Dd56c5fxDiOoO/vZ9DgaM4gcPxRY1C4bsYBekv8bJy1ETj6V
 fHQNE0P67o90Eluti4+m2XdvUKdY1Vsu+kx7VDeRG2ymrYUYp4A1sG0wOunTHb09d0gnuhYpLfo
 Iw/8q50+fdV6cuakx0s8d6LIEtgkTMLV8j1IDlrkLYuQt2QUIpmmNBNbCVDKXbkVqTQ==
X-Gm-Gg: AZFdTZdfVVsg8lNDOSHvpF63/zdyp+2n1sqw9zCQ+EHsIVP++xZkcT/2UeG7z9tYpqm
 YuGEhQD3puqLT6L+F6JguPcfmm1GWkd+Eb1XdlHSewfPqC+c01DFuHvJJsd5KCZ7iSfp7eWQGsm
 6vGlzD+QtjXlSEflEeeVmBCJAt0D/WUfOF2ltxfAPA1rK+nkHqCeYe+5WLJMQm5TiaOnWXF9L4A
 WC/Ikfbyc2N1u2LfH8NKa1ykIVZd3sZtB1tQoj/BczPgvG/pl6NmzGDLupEexMV06arxOJ2eCaX
 /jVvR8BKrcsD0dR9m/y63kI8KjAWVqEMHjLUrLaWI4Om/TsFKkOZIpU9/wvZBEYI1zYFckY/wgc
 Gt/dZZvJ23KjoSCMnWIqpa9D5LP0ofi6EgtsvT2HxT4asWBlDiezHVOq8ysRJts5yJGLFcJ6n5t
 9LKdQs0ktmpQ==
X-Received: by 2002:a05:622a:514e:b0:54b:5cc6:6034 with SMTP id
 d75a77b69052e-55d76b44e2dmr223727001cf.72.1795462552952; 
 Mon, 23 Nov 2026 11:35:52 -0800 (PST)
X-Received: by 2002:a05:622a:514e:b0:54b:5cc6:6034 with SMTP id
 d75a77b69052e-55d76b44e2dmr223726551cf.72.1795462552388; 
 Mon, 23 Nov 2026 11:35:52 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55da2408ba0sm24439651cf.20.2026.11.23.11.35.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 11:35:51 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2 1/1] target/riscv: do not write RVG in misa CSR [GL4811]
Date: Mon, 23 Nov 2026 16:35:44 -0300
Message-ID: <20261123193545.15632-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261123193545.15632-1-daniel.barboza@oss.qualcomm.com>
References: <20261123193545.15632-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfX/wFD5xm52xGz
 bZokdJLeVDQprWdI33Ohlol95RRI2EssY3GPM2QfInOcR+8fOsJTsrtwEQ93VqcQfsWy8Jazcoj
 fXt8/jFWPTPC47a+pLR5f2Q1nqCr7fE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfX61jr2ULTBmZr
 AN2LOMAxj5pXGUwbdKIj2zLAJHO3pNHnuxw56FNc+QMWiIRy1xG3D+SrkkY2ZKNLkhXpN8+f8iU
 9wF9Q7KTAz0FU5JF/DYs3DcDbFdAqP92ZBkWptIuHhK46RLMm241rOWmmuTWS0/sdJ/vIATikZv
 tHZuMuh81CY08j8EXPPFgZSuBB+qqSu3Vs+6VMNwaC9AwizXfBogS95ci7Nlf9rNHDz5Ysy9yxD
 kHVGujNZAcZz2xrPLDcgTHPgoheErsbvr8/M7Ox2RHy9UUsrmMZFpqS6ZCBuh8vj4BTGzzLiNmD
 6FY/WOvNk5E+pDjFJhZkdhHxsFdJJkqBfZbn6lhobNJW00PzB0HTfSUxdkTDiSFMc9NQDnHGfdr
 EiB/20grBZkqLUtK4rG3nBrQWldmfPIH0LZo63zcDnxrMqvqc1BWTm7EAV0DVyLkP7oXnI8ErCq
 rtdkPeaau1O5vOZYvhQ==
X-Proofpoint-ORIG-GUID: DcYbwJDQG8WIbFF-EriiIF9KNpibjvu1
X-Authority-Analysis: v=2.4 cv=cYJHPXDM c=1 sm=1 tr=0 ts=6b04959a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=D34z8tFnLgwhCRIc9k4A:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: DcYbwJDQG8WIbFF-EriiIF9KNpibjvu1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230078
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
The "Fixes" commit refers to the very first usage of RVG being written
in MISA.

Fixes: 4f13abcb2bcb ("target/riscv: add RVG and remove cpu->cfg.ext_g")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4811
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/csr.c               | 17 ++++++++++
 tests/tcg/riscv64/system/meson.build |  7 ++++
 tests/tcg/riscv64/test-misa-G.S      | 51 ++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-misa-G.S

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 2a37fb735f..ee8d102ce5 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -2215,6 +2215,15 @@ static RISCVException read_misa(CPURISCVState *env, int csrno,
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
 
@@ -2243,6 +2252,14 @@ static RISCVException write_misa(CPURISCVState *env, int csrno,
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
index cdd2e99d22..58970a0f01 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -116,6 +116,13 @@ tests += {
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


