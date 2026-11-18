Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CA6606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 10:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZNfc69o4;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bgp2WnZK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTd19-0008WG-5y; Wed, 18 Nov 2026 05:35:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xTd0w-0008UO-4S
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 05:35:42 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xTd0u-0006fw-BD
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 05:35:41 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AI9k7Ce3578206
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 10:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=HljkKO5qj07
 JmhG2LrUTXWKFRD0Qjxk6x1fLNtly9OE=; b=ZNfc69o4CxYwPA9c/AquSWTq8Ux
 q2E3YoLHBXZtevi7SYciIHDBXIjrBdFK2WU8dL6T5BXCfy/wD5ONp5vxQRlKubOS
 aolIZedj03pDTkOfLtaQYV0htNunVmcJw1a/W83kDcyaTrNwffjoezGKzApO1sMb
 1Dx80QQIEoCBq5o3wSrRDo4IpVSXHjjcknf+AOK6HBUusX9ctOKyHZGQrEc+lxk7
 vfkN8PcjSAtP9kNvQLzp1BztoMEp9d3VC0UMW04cyh1drlh94vrbq4L5UJgG+s85
 khAg5gimIpMHP/kY9zDKHyR5vtyJxQmQkJxls8AIHt/poXuEBXk2FSo8Aqg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv72n0r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 10:35:38 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5363b06bcb2so15965861cf.2
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 02:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794998138; x=1795602938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HljkKO5qj07JmhG2LrUTXWKFRD0Qjxk6x1fLNtly9OE=;
 b=bgp2WnZKS4grXqxSMtEltIwLM+7zVMkvc/xO90qBufwLWvCGf37oInJJcJxyg6Y+c6
 EAC4L9y+xUluSTeQpZ2JJgIzDtwzGPrVQ+r+ijG/V6sE8sibmRXyZMWaJ0akGF8BsA7l
 mw2oiuAO4YpOCjd+1yUhFJJS1bP2JW782Veztspgc69On2OFTxjxPZRm/JCXj3wXQOSZ
 Ms4ymkOHABxbUjWOqJLyyVCuakdcMUNKoGRCDBX7RGlDmE4CAijXVkJysZMgNW2oRU1Z
 0aWDJ6bZjESGWKpjboAeCv+jtpZ74GmFyy6knXja8WaPaQcxtmA7Tl5KOUv/F8BEQV9S
 XuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794998138; x=1795602938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HljkKO5qj07JmhG2LrUTXWKFRD0Qjxk6x1fLNtly9OE=;
 b=kbzkYWNHGOZDFFAqUb/ezwq/SJ5Icim0P5ijP5nVD5o2BsJC5iAIWU/9ESkapMFT21
 2p5L3xt/srMSN3r3RA5QPVZpcGMvT3c5q1imAo+fGiM6SHmTbGJUMyjsw/HxNCLo2xTy
 2lqGhyiiObGfOYK33FSJs7OiA97grftSRyvtnRKY9o1fp1fDgDxjF5l8ngMsrt0VI9/I
 lYVh3mtfKk351vXrmKb3q3OT1/cMKlzPjJupq3du0kos/WXy5BzEjxLgbH77K5BsXBFK
 O6cO5+1mMYWO71ayYqBEoOPYWIWV13vWpl6PJ7dBd+UgAzYuKrE8bSTRMPLnsR06HbCK
 sJsg==
X-Gm-Message-State: APuU4Z/9lNvbhzLomAqsB9d6g//Vaw5/C53r+biGlgE60cpOi28r/iX1
 QAdbzyWddE8ANmLVtylMnSk6u95GPTKW9XDaRIMz50ajS7lfiVTN2aRwnN0hnPhubfLFxv3vqX+
 C7BFD4VfRXXrWeRoA+yrCOywOeQDp3kmw47a7Iiuj9X1OH5c8iNypj6VOPgpMK9PehQ==
X-Gm-Gg: AYBFou1OIkDQFHV4E+z4nhwUHAsHkBkCeXicYabtl7U/GT00vzYb51s8DpBjGUMueLj
 xTDI2z36E2i0gsZXrC9B/3V4CR0dLmUGlhRcdY0MkjGQud9plYIeyvkULAxCai3cKScq7wzVDnb
 X9rZrIEjFmINm4lHgfqsrh09jWyZD3lnNVl7UFOBAcR4oADyC8QWyzboVGIMwO0ipDJlKvLmsAK
 Y98+UuogbIxFrhA3EbC+440dWmoWZZT8QXAP+dDPrpdy/sjWEuttNvlTxAxUjxcBZHnRR6jugr2
 GVo/N0OjP9qq5UKlZl/L7EtukVLAz52II3KAS6rFWxyEFkKlipIezM1pTeTnOPMrwj4AapawJne
 k4Fnlnzfi7puLvhTeTM43PXZjIdKpyUhD/FMdVeSne1SkByfzZv/OsHamA9DvzVoy9di7sjI/cB
 fF8W324scrWs4=
X-Received: by 2002:a05:622a:14cf:b0:55a:df3b:38d4 with SMTP id
 d75a77b69052e-55d5a72f272mr32581481cf.75.1794998137687; 
 Wed, 18 Nov 2026 02:35:37 -0800 (PST)
X-Received: by 2002:a05:622a:14cf:b0:55a:df3b:38d4 with SMTP id
 d75a77b69052e-55d5a72f272mr32581241cf.75.1794998137188; 
 Wed, 18 Nov 2026 02:35:37 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.227.223])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d59102ed1sm18927991cf.28.2026.11.18.02.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 02:35:34 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 2/2] target/riscv: clear mstatus.MIE if mstatush.MDT is set
 [GL4827]
Date: Wed, 18 Nov 2026 07:35:25 -0300
Message-ID: <20261118103525.1192249-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118103525.1192249-1-daniel.barboza@oss.qualcomm.com>
References: <20261118103525.1192249-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: I08LtJpnFJZ-GU8XNJO9cxXmiefjzDED
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA0MiBTYWx0ZWRfX63r1db0SpRMQ
 +yp6EuaLv7RND6chLBRNbK+Thxk8MidQfnWI7OrZ3WjTCwjq2iPmPgOcVZph5gAEf2aRAkzZ8Py
 KaFbpyn7SpMkrO0s1Mm1dMF15zIheBn+o2svk463ykXggEDUdugUWlNTwgHfhYCXpUWqe6aWYkB
 6vk/r7Hv8BrfiYdyKMw+H9cS2JIT0JCpN0EMteMvWRU7j+YFAe1qVUkXsO1wx8+gkA5A8b5bjFm
 hC0MUPGUU577mNg9l4gYQe9vrSACAJIveHYHVIRCu5KqbCKG2LWNEl+Q1L4qRhyD2mYecrfw1p2
 ggdULn7R2A/7RE92CSXguiAoige4qJtZtXoTPUUcfCfaM3/yxfS7Fb3vLc9My0wecVn3sXFQ/0c
 LQueT1WtfGibYTmD3T7xwY3AeL/96Q1XgAvtYSF6/+4b+qb1jyGsPMIP+h9MVpb7o9KmpliGjxs
 hzhWAf/+zv0L8iF8U2g==
X-Proofpoint-ORIG-GUID: I08LtJpnFJZ-GU8XNJO9cxXmiefjzDED
X-Authority-Analysis: v=2.4 cv=H8xOUOYi c=1 sm=1 tr=0 ts=6afd7f7a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=WERq1Tg1Nl5IKGfG0e6imA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=iTC3F798xIRISN9uQnUA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA0MiBTYWx0ZWRfX9FW47hzKQQjt
 RNf3viAQDgcqePyYOZtmkTc92smgFVu5EJutnAM5ryfcCNeo49+YLCDE//AB8LjRFydFRbMuUn9
 kRXg/fH7KE2AMGPgy79QKOcoSQU4BqA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0
 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180042
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

This is the same logic used by rv64 with the difference that, for rv32,
MDT is located in mstatush and MIE is still on mstatus:

- write_mstatush(): clear mstatus.MIE if mstatush.MDT is going to be
  set;
- write_mstatus(): for rv32, if mstatush.MDT is already set, clear
  mstatus.MIE from 'val'.

The logic for rv64 is unchanged.

Fixes: d2e92f1c6d44 ("target/riscv: Add Smdbltrp CSRs handling")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4827
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/csr.c                    | 22 ++++++++-
 tests/tcg/riscv32/system/meson.build      |  7 +++
 tests/tcg/riscv32/test-mstatush-mdt-mie.S | 55 +++++++++++++++++++++++
 3 files changed, 82 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/riscv32/test-mstatush-mdt-mie.S

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index ab436244cf..249c581fa7 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -2069,6 +2069,7 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
     uint64_t mstatus = env->mstatus;
     uint64_t mask = 0;
     RISCVMXL xl = riscv_cpu_mxl(env);
+    bool is_rv32 = xl == MXL_RV32;
 
     /*
      * MPP field have been made WARL since priv version 1.11. However,
@@ -2102,7 +2103,19 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
 
     if (riscv_cpu_cfg(env)->ext_smdbltrp) {
         mask |= MSTATUS_MDT;
-        if ((val & MSTATUS_MDT) != 0) {
+
+        /*
+         * For RV64, we'll have both MDT and MIE in the same
+         * register so the MDT state that matters is the one being
+         * written in 'val'.
+         *
+         * For RV32 MDT is located in mstatush, thus we'll have to
+         * check env->mstatus to see its current state.
+         *
+         * For both cases, if MDT = 1, MIE must be zero.
+         */
+        if ((!is_rv32 && (val & MSTATUS_MDT))
+            || (is_rv32 && (env->mstatus & MSTATUS_MDT))) {
             val &= ~MSTATUS_MIE;
         }
     }
@@ -2167,7 +2180,12 @@ static RISCVException write_mstatush(CPURISCVState *env, int csrno,
     if (riscv_cpu_cfg(env)->ext_smdbltrp) {
         mask |= MSTATUS_MDT;
         if ((valh & MSTATUS_MDT) != 0) {
-            mask |= MSTATUS_MIE;
+            /*
+             * Priv spec: When the MDT bit is set to 1 by an explicit
+             * CSR write, the MIE (Machine Interrupt Enable) bit is
+             * cleared to 0.
+             */
+            env->mstatus &= ~MSTATUS_MIE;
         }
     }
     env->mstatus = (env->mstatus & ~mask) | (valh & mask);
diff --git a/tests/tcg/riscv32/system/meson.build b/tests/tcg/riscv32/system/meson.build
index c70cc12517..94058d8b2e 100644
--- a/tests/tcg/riscv32/system/meson.build
+++ b/tests/tcg/riscv32/system/meson.build
@@ -29,6 +29,13 @@ tests += {
   },
 }
 
+tests += {
+  'test-mstatush-mdt-mie.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'max,smdbltrp=on', qemu_args],
+  },
+}
+
 if 'qemu-system-riscv32' in emulators
   tcg_tests += {
     'riscv32-softmmu': {
diff --git a/tests/tcg/riscv32/test-mstatush-mdt-mie.S b/tests/tcg/riscv32/test-mstatush-mdt-mie.S
new file mode 100644
index 0000000000..8763bc8768
--- /dev/null
+++ b/tests/tcg/riscv32/test-mstatush-mdt-mie.S
@@ -0,0 +1,55 @@
+/*
+ * Verify that when mstatush.MDT = 1 MIE is read only zero (Gitlab 4827).
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define MSTATUS_MIE 0x8
+#define MSTATUSH_MDT 0x400
+
+.option norvc
+	.text
+	.global _start
+
+_start:
+	lla	t0, trap
+	csrw	mtvec, t0
+
+	/* Write mstatush.MDT.  */
+	csrr	s0, mstatush
+	li	t0, MSTATUSH_MDT
+	or	t1, s0, t0
+	csrw	mstatush, t1
+
+	/* Check if mstatush.MDT is indeed written.  */
+	csrr	s0, mstatush
+	and	t1, s0, t0
+	bne	t0, t1, _fail
+
+	/* Read mstatus, set MIE, write it back.  */
+	csrr	t1, mstatus
+	ori     t1, t1, MSTATUS_MIE
+	csrw	mstatus, t1
+
+	/* Make sure that MIE is not set.  */
+	csrr	t1, mstatus
+	andi	t1, t1, MSTATUS_MIE
+	bnez	t1, _fail
+
+	j	_pass
+
+trap:
+	j	_fail
+
+_pass:
+	li	t0, 0x100000
+	li	t1, 0x5555	/* FINISHER_PASS */
+	sw	t1, 0(t0)
+	j	.
+
+_fail:
+	li	t0, 0x100000
+	li	t1, 0x13333	/* status = FINISHER_FAIL, code = 1 */
+	sw	t1, 0(t0)
+	j	.
-- 
2.43.0


