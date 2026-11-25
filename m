Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C20606A327
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gK+lGdMW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A3Wbb5bC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW9Sc-00030Y-Ss; Wed, 25 Nov 2026 04:38:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xW9SW-0002yj-VN
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 04:38:37 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xW9SS-0005KB-0e
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 04:38:36 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AP9DoXn3682043
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 09:38:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zXTZCrjipYT
 fySZk8W0Hqsax1IO6IE4ttIUiJZaMlrU=; b=gK+lGdMWYutAAac242bDjcbnu6V
 xfl8g9hjWX8H7AmwRzHVSlho6jc9yzH4tf5L2Sp9NK59BK1qT9+Q7OUooDhjLBwt
 PtltiKFxr5Xy2gmN4Zfoa6sJs0IGLUoJQN8hDat0ppZhFzpggHwPgnkBId/vxaU9
 sXr92Gllj9NHodHoqmFRZJjlIzcnmOPews1hYUewF6XQto8cPu+P5sVKr+J1s+JN
 ehXX8EhOA18OLWt9TkAeNMzOLQAcGqwC91c/g9h4gHCuVkA30DYNpGPHFgo9W2e0
 8FS7EIfxSHVz/nYVm5C7fWQJPiDpgfuFvqjJwqCugK/yPr+uALc+MwcWTJw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vv2r4pj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 09:38:30 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-94961ed97d6so966210185a.1
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 01:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795599510; x=1796204310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zXTZCrjipYTfySZk8W0Hqsax1IO6IE4ttIUiJZaMlrU=;
 b=A3Wbb5bCGJK05i7MqBBqLyzJr8yTmhorbiGPDSo15zclPuDsBSsNzw1YtnHFgpvaga
 P26UBUykLm9fwOnEpUsFokqMNL/GX5TRmV8/mLCnsuT4IgaJiGqq0PbEJK0qQPHelBMY
 n3G8ZGMNecK4o1Of+lgR1dS/WWUh78iiEBl+a3dFs8GEtpmPmzN3eHYh+7eSGKg6OMtV
 CqRfwc+GpsuFLuBLei8OJT4xNo+CE8rt7CpW+Hpj7loVquExVlguRh/tEE+j1EASp+p0
 HPBDAfhgIDZMOueAE/1huG2Lj24H52klnY7efHqkiHPNnWWXsU6klI3DFzJxncPpi8W8
 eFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795599510; x=1796204310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zXTZCrjipYTfySZk8W0Hqsax1IO6IE4ttIUiJZaMlrU=;
 b=njzopN4+NZZAftaVgM/7CQwzlGjKVI4N6CTApV4AMCDieXmFWiMDtreBm+dMBsWsKQ
 OKUuHO4YpfpwtZJFOOQEJV07x99HVHsUu5AL2utZS+2TJA+MStlqKczdxKWo9oRYxxdF
 9UbCWdh7EPG+H7+heCqDo4GCNXEXkn3xIH0sDWiVLOOzU1+JiedoDL9sjMm6mNgOIC0P
 nNKQffa8VPl1UpBEWC374Er5zba8IA3jvdix0FBBU2dKIqaTr47pnJ0Bwr11qTPlMtL1
 RpSp3acVThWpOeVsiqkfnyTj3D1XUDeY2JPUMQrdW6kCOJSS6y2NqSXhonor0IBMziNE
 qbgA==
X-Gm-Message-State: APuU4Z+oLMcKkdY5U44llv2MgP3JjVEDwEvJcbBjlzFyzOtDogWAdj9V
 j4GOv3EHxIZxdHwvPZkWP49sarMFM4hBBTUhE3CqXTKCiXXdOQnK6BR+bwYakfOjGP5DNs7t3tF
 klZf+nkcmJvXfpAiAegw57WCiTaDK5kj4hCmwNgoeRvakeL+kSF3tMAmmX3yUN6qYtg==
X-Gm-Gg: AZFdTZc/zJBanRahRFKHtFiLELdgx6DGhk1M4kguH7k44FzG4Ji68DkIDT/Oi1XhmL2
 vdpFlHkf8/q0Kp0jQ3N1lbKZVpB9Y6KUs+6V3WoK19ppVa4XMahnRUhwZTU5f1zAabFFdSCFyoG
 lU3hOT5nvwUJ32fP+IR8jYmBywwx+v4imbqsieqW1AQ6/CfHL5otIvHny+epTDKwI/CXwlI0Wf+
 ggsmCYOoCiyKEIu43EoUU9bgjOzNj1DUS68gAkV68ooMwJ72fJY09Era7N5+7kVhjSzJE/PMGSs
 6HNr4JNl6VMo1CDZQJaT1ii2JW+vKQkm9MnDsJqOWNigeJAAqITfwx5dGh+fyejXlS8+g1FbIy+
 Dt+h00t774TZFigaLZAQE4DLQ8erSd/UgLUJG4Lsrk4ykdz4b+87jRJe1jv3Gb0OolP8uxfMB9q
 7crtUt+tFiCg==
X-Received: by 2002:a05:620a:1a09:b0:93f:22af:ccdc with SMTP id
 af79cd13be357-949b340223bmr3060456985a.4.1795599510186; 
 Wed, 25 Nov 2026 01:38:30 -0800 (PST)
X-Received: by 2002:a05:620a:1a09:b0:93f:22af:ccdc with SMTP id
 af79cd13be357-949b340223bmr3060455085a.4.1795599509626; 
 Wed, 25 Nov 2026 01:38:29 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb3f2de5sm1257212585a.29.2026.11.25.01.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 01:38:28 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v3 1/1] target/riscv: do not write SXL < UXL
Date: Wed, 25 Nov 2026 06:38:22 -0300
Message-ID: <20261125093822.228611-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125093822.228611-1-daniel.barboza@oss.qualcomm.com>
References: <20261125093822.228611-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAzOCBTYWx0ZWRfX92ME/qicUCU6
 ajXAhkSIgVVyT9anm4L1kQl+Nut8FD/6hPd8TVgQ3T/kP3JOAztxwaK9b5yRmuZuUDWOFd07+LB
 G0k3GO290QQWGwy5JMDvEcPPKx8YAzQ=
X-Proofpoint-GUID: rtMTmmwfFQwtSofzCuS2-mNV1vb4yWlb
X-Proofpoint-ORIG-GUID: rtMTmmwfFQwtSofzCuS2-mNV1vb4yWlb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAzOCBTYWx0ZWRfX4fcamWC5AchO
 swXlvHrErmnUzcGm2iEpfxLOMG9Af+D+P8fnx9phCPH62Mjhc6qSYSpyD18S5PRGlDZSooQp8LF
 sHt+yM6ldt+0MbYpI1Lcuz5NAYB5BR42y3r4UBLuhq/M1kIASZSU3RKClSj1muePYywO2mEmrJK
 B0LOT9N3brKR0d3YYBLHNEuLgpeQGGObpk2+K4bnhvkcPGwYVgtXhZXJ242FZyfyofv4HeFMmHD
 GWxHuB3dp7LfVFQ48it6FUvCOuPnHTKIQOO7De4t2M1XW1cb2LebyOgNvTTfkwFhhJhZJoMRMou
 svpwaUhgxk+YWAlBp1l6UwA6YTyq/EEskNlpoHEZnY3FPc6rlEhw3aywDaDWpAqhgo+UyXhAc1U
 Y8ryWQraKXL8jQdfEs/heqI327MxLbrVN1lKUH0wLEHNM1kfPRf7itvDn8BSYWehhQJATebD3RY
 F1JX3opk1BYOE7K4ukQ==
X-Authority-Analysis: v=2.4 cv=A/z5rKWG c=1 sm=1 tr=0 ts=6b06ac96 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=a7LDkB8lNaJXYUdKcV4A:9
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250038
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
	autolearn=unavailable autolearn_force=no version=4.0.1
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
index cdd2e99d22..8938fc6caa 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -116,6 +116,13 @@ tests += {
   }
 }
 
+tests += {
+  'test-uxl-sxl.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'max', qemu_args],
+  }
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


