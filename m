Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3D2606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 13:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PKGemJVD;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hbhZtLXa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWCvz-0002Yx-J4; Wed, 25 Nov 2026 08:21:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xWCvq-0002VO-8i
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 08:21:06 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xWCvo-0000gB-A4
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 08:21:06 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AP9mLi14131181
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 13:21:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=vHvl4S5xpgA
 7ivhlpcDeL5NeEgeXUQIMVm+QGE9pITI=; b=PKGemJVDPw6GETIcrh/l+yf34ih
 i8GqHLvJE1ROJarDGNZh/gnEvuB3bhMFff77jDEdK9szYraqN9S3ploJxma5n4uX
 VglDQQdpYK7Yoyf/sIE+27rkv+CitysyRf6gLa02hhCaPfHHhhsojEv3Pyn1jshS
 mR+qbjsujOxNilv+Am2HtVihXaGMOurF51jYzs654tCHcQT07NBKHuXUAN8nWQ6w
 scuR6Ki2huQUBxrtLKu8ZYt5lE/PtJU1Syd3WVeLdSFQDcjEA4CcaeUxzXFuajd3
 7U3sOiuhP4iiZhNUm1oOKiffYWxzQXcHR1VurvwnOfSCbnz9/F93+17rMCA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vuhs0xn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 13:21:02 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-990ca9607c3so2662712241.1
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 05:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795612862; x=1796217662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vHvl4S5xpgA7ivhlpcDeL5NeEgeXUQIMVm+QGE9pITI=;
 b=hbhZtLXaATnbLvPVFJEdwDYMvcqr6Io1sr+/nB0r1SLt7tFjwd1yVcA1DNSRh3t23i
 I/RbH1ANSdTG7sb1tV6xeJrChG5+j8EO8PxAKLbya0rZMacUrquHZTi+yx7RkmF6v8Qv
 W3tHrfjMfGWXvSetuTofAZpO7LBzC/9usNqmEwsb5u+rJdje+FKq8E/lCy2y/giwKFF8
 lEXMHxV5vJJhk/HSz1YRkIpJjAcz/8YDNnZZ7ktpTBv1IIsv/7EFFNnHPh15PEtrlS0d
 nuIpH2xwBT1FseXesDTAWLRDiBYi+4u8qnAwB75ezaOFogb7qRPrN5LFVwgOKPfYkIoj
 9aFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795612862; x=1796217662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vHvl4S5xpgA7ivhlpcDeL5NeEgeXUQIMVm+QGE9pITI=;
 b=tuDvQoaUrtonBaX1GjrVjko97Ji069btCrRZ6FCziiMEPkYq3qxRnwRWMADQp4fzmH
 BQZOVxuDs2nmACX1RtM9XhubSdQVoClhR7d33+0C5J7RaC9Nm8yQWIXVr5xFydI2znYw
 9041HFAt8CCCsmtxAbOqVgvt3hY4tZh5YvTZuBDyhSPnah5pbRE47eMx4tKw6T1CBWXO
 fF8FlHRs3oaFQ/uER0fEoR9/4Hl0HVSCJMcjTqGR5s+Lou2u+Y7VmtSYP5piSwb8Jo7/
 x0j8ktif/3sOuUuW7mypT2GloilBtfEhR/q8nB1QQTI7DbkeSA3hs8DjcYt6O7V4yEOc
 GgmQ==
X-Gm-Message-State: APuU4Z8smEDet3kOVIdhRuhHd4IEqMWqbeNVFHwr+/qJ64jsrPOFHSkL
 HLo6ScIt/6XaeSdVVdY9goaHq8/V6UXvMaTa/U/ZPfFgKbsK+41Jx/HUyOFcqFP+JlRCR3cs8VD
 uc52/LypFm9eByP7o7PSKxmr19KGPpUuiYDf79GnImn4r+trPz9ZeZts1F6MYJfuk/Q==
X-Gm-Gg: AZFdTZfAHGeePSpMGlF9leLCfauu3diFvIE2qiujqF0OR9d83npplVKiNmjvPWgOp5q
 fH9gRnhi/5FRPVSD45mRLswUF9EGaTJp3kxYU5rbmgXhtx6W8g9HtW8yRBe9kzgZSk5eB+Su/zv
 Dfw66/zfqQqX7nwAnVhoRbnZNHTF63SPKvfx5LtSw6/EaMi7spLp3CR7uVnkDp9rL5sIACmWb9j
 0ng4RhvtQAWRp5g48f8INQRFmnSgqFZu8VqAK/b7TYSsc5ZkmD8L+Hn3QCIjQ+iC6C7O/tgnG9S
 6LAeC7NLH71XQX7VOIT3T9kI73btTFMVj6Ee+vcr/e/NbxyCl0vmfFEo9yE3vCkHlghiVq3cZKo
 uW+AxtwJ/6Btw3H4uqKqR/6ca+NfeO4uLdnPXHLTQBt18pmvcDvjTFFoFvFke/iIWk1eudo8O2F
 /+LHNZyYLgQA==
X-Received: by 2002:a05:6214:458b:b0:91e:a540:e60f with SMTP id
 6a1803df08f44-92134a981b6mr321033456d6.21.1795612849306; 
 Wed, 25 Nov 2026 05:20:49 -0800 (PST)
X-Received: by 2002:a05:6214:458b:b0:91e:a540:e60f with SMTP id
 6a1803df08f44-92134a981b6mr321028996d6.21.1795612842948; 
 Wed, 25 Nov 2026 05:20:42 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm160836946d6.34.2026.11.25.05.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 05:20:41 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 01/15] target/riscv: do not write SXL < UXL
Date: Wed, 25 Nov 2026 10:20:00 -0300
Message-ID: <20261125132015.229955-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125132015.229955-1-daniel.barboza@oss.qualcomm.com>
References: <20261125132015.229955-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FPmOVOos c=1 sm=1 tr=0 ts=6b06e0be cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=a7LDkB8lNaJXYUdKcV4A:9
 a=TD8TdBvy0hsOASGTdmB-:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-GUID: xHuztne0_d5h-9opUNs4uk2UU91PTW1E
X-Proofpoint-ORIG-GUID: xHuztne0_d5h-9opUNs4uk2UU91PTW1E
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA1MyBTYWx0ZWRfX7TlGwhYl7WMq
 sapbP2fNzrVLVojqLvJ9aUKTLqXyqsV6SvlUmaDpkutHRNRs5EuKK3njss/+fbX5yZjfdDIlFGK
 nYptDXK+EHVGcIEj71PkeSaZ4DeoN+U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA1MyBTYWx0ZWRfX49CxnaDPWmMn
 o2nHWIT/XH2bjyAvROOX3V7WDkVgRdzzyjNsn6+1crpOql5BtaPeqBEbFGvnd9ZaiLriISMrGVi
 +2N9eXTDA9FNQgkEPRw2Ow7umlsXScAQaqQR6vsjMW/I98Lo2Eo5KFDuYN3hxUgXUBli0jn1LLV
 PVBNkfDVP4c4uFtcokUzsMQl+E4xmd94jmNWkPekpTfOqBg3hp7eNt/oIrtqwY7nNGxAgkrjCLF
 rfnzqz3Y9/4ktTjOKc9D1QGTg1AgQmDUjkpKAQ2EPUMMFUPU5byFUs5RiSggmljagVG798DHjHP
 6d3M4qq+XdnBwL5QNnmWe0pVUK8U7O80dhSUbJV+4DRUWuEk7WxnG5OEvwg2IvI7Hk3ZE214vQB
 DyX+B0EHf9xeEz+aSs2gb9VB1Dd+ID1E5r8CNCvJeidr7GXa7rTXF6twjYD7ueSY8ZqgPP+Pwzx
 AJ8CaXstUYHVOB1+DMg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015 spamscore=0
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

RISC-V priv spec says: "If S-mode is implemented, the set of legal
values that the uxl field may assume excludes those that would cause
UXLEN to be greater than SXLEN.".  At this moment there's no relation
between SXL and UXL writes, i.e.  we're happy to accept SXL < UXL.

We'll start by renaming riscv_write_uxl() to riscv_update_xl_field(),
making it closer to what the function actually does.  Then, in the same
function:

- 'xl' is renamed to 'mlx' since it stores riscv_cpu_mxl();
- 'uxl' is renamed to 'xl', indicating that the function is dealing with
   multiple XL files (SXL, UXL, VSSTATUS.UXL ...);
- add a new 'min_field_val' field.

With this improved helper what's left is to change SXL/UXL update order
in write_mstatus() and, when updating SXL, we'll use the written UXL
value as a minimal value for SXL.

This means that if we're in a SXL < UXL case, e.g. SXL = 1 and UXL = 2,
we'll write SXL = 2/UXL = 2.  Another possibility would be to decrement
UXL and write SXL = 1/UXL = 1, but the bug report in [1] mentions that
bumping SXL is the default behavior of other emulators.  For the sake of
compatibility we're doing the same.

[1] https://gitlab.com/qemu-project/qemu/-/work_items/4821

Fixes: ebef6685a1a2 ("target/riscv: use SXL instead of MXL for read_sstatus")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4821
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/csr.c               | 47 +++++++++++++++-------
 tests/tcg/riscv64/system/meson.build |  7 ++++
 tests/tcg/riscv64/test-uxl-sxl.S     | 59 ++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+), 14 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-uxl-sxl.S

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 2a37fb735f..0e2ef8530b 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -2049,15 +2049,32 @@ static target_ulong legalize_mpp(CPURISCVState *env, target_ulong old_mpp,
     return val;
 }
 
-static uint64_t riscv_write_uxl(CPURISCVState *env, uint64_t val,
-                                uint64_t field)
+/*
+ * The intended use of this function w.r.t 'min_field_val' based on
+ * our current design of always making SXL >= UXL:
+ *
+ * - set min_field_val = 0 when updating UXL fields;
+ * - set min_field_val = existing_UXL_val when updating SXL fields.
+ */
+static uint64_t riscv_update_xl_field(CPURISCVState *env, uint64_t val,
+                                      uint64_t field, uint32_t min_field_val)
 {
-    RISCVMXL xl = riscv_cpu_mxl(env);
-    uint64_t uxl = get_field(val, field);
+    RISCVMXL mxl = riscv_cpu_mxl(env);
+    uint64_t xl = get_field(val, field);
+    bool field_updated = false;
 
-    if (xl != MXL_RV128 && uxl == MXL_RV128) {
-        uxl = xl;
-        val = set_field(val, field, uxl);
+    if (xl < min_field_val) {
+        xl = min_field_val;
+        field_updated = true;
+    }
+
+    if (mxl != MXL_RV128 && xl == MXL_RV128) {
+        xl = mxl;
+        field_updated = true;
+    }
+
+    if (field_updated) {
+        val = set_field(val, field, xl);
     }
 
     return val;
@@ -2118,14 +2135,16 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
             mask |= MSTATUS_MPV | MSTATUS_GVA;
         }
 
-        if (riscv_has_ext(env, RVS) && (val & MSTATUS64_SXL) != 0) {
-            mask |= MSTATUS64_SXL;
-            val = riscv_write_uxl(env, val, MSTATUS64_SXL);
-        }
-
         if (riscv_has_ext(env, RVU) && (val & MSTATUS64_UXL) != 0) {
             mask |= MSTATUS64_UXL;
-            val = riscv_write_uxl(env, val, MSTATUS64_UXL);
+            val = riscv_update_xl_field(env, val, MSTATUS64_UXL, 0);
+        }
+
+        if (riscv_has_ext(env, RVS) && (val & MSTATUS64_SXL) != 0) {
+            uint32_t min_val = get_field(val, MSTATUS64_UXL);
+
+            mask |= MSTATUS64_SXL;
+            val = riscv_update_xl_field(env, val, MSTATUS64_SXL, min_val);
         }
     }
 
@@ -5509,7 +5528,7 @@ static RISCVException write_vsstatus(CPURISCVState *env, int csrno,
     if ((val & VSSTATUS64_UXL) == 0) {
         mask &= ~VSSTATUS64_UXL;
     } else {
-        val = riscv_write_uxl(env, val, VSSTATUS64_UXL);
+        val = riscv_update_xl_field(env, val, VSSTATUS64_UXL, 0);
     }
     if ((env->henvcfg & HENVCFG_DTE)) {
         if ((val & SSTATUS_SDT) != 0) {
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index cdd2e99d22..c9435bf2b3 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -116,6 +116,13 @@ tests += {
   }
 }
 
+tests += {
+  'test-uxl-sxl.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'max', qemu_args],
+  },
+}
+
 if 'qemu-system-riscv64' in emulators
   tcg_tests += {
     'riscv64-softmmu': {
diff --git a/tests/tcg/riscv64/test-uxl-sxl.S b/tests/tcg/riscv64/test-uxl-sxl.S
new file mode 100644
index 0000000000..54dc0832b3
--- /dev/null
+++ b/tests/tcg/riscv64/test-uxl-sxl.S
@@ -0,0 +1,59 @@
+/*
+ * Test that UXL will never be read as greater than SXL.
+ *
+ * Based on Gitlab 4821 testcase, which is derived from riscv-arch-test.
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
+	csrr	s0, mstatus
+	li	t0, 0xf
+	slli	t0, t0, 32
+	not	t0, t0
+	and	t1, s0, t0
+	li	t2, 0x6                // SXL = 01, UXL = 10
+	slli	t2, t2, 32
+	or	t1, t1, t2
+	csrw	mstatus, t1
+	csrr	s1, mstatus
+	csrw	mstatus, s0            // restore
+
+	srli	t1, s1, 34
+	andi	t1, t1, 3              // SXL
+	srli	t2, s1, 32
+	andi	t2, t2, 3              // UXL
+	sltu	a0, t1, t2             // fail if SXL < UXL
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
-- 
2.43.0


