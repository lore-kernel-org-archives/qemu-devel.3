Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F798606A332
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SnrePa3U;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gEjPBlDy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU1Sp-0008Aq-FU; Thu, 19 Nov 2026 07:42:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xU1Sc-00088M-99
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 07:41:54 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xU1Sa-0005VC-1R
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 07:41:53 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJBjx7j3319820
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 12:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=TXBFO85Uf6M
 CIXGPNVCTOsUuDlzdh6663Yns1R2b9kM=; b=SnrePa3UihnN3ZC5AsfxdWy+9Lq
 6Za4FTW4oPm/Ns9sZkAgDy45l76shifCpGv9FqHixQkZZB8/jP1U57mxTGVnmh65
 XL9ZkBBL/XrXsrImQVTAIrJ4Am6q8wKBspYHVDxTPQ20i+xfDh7dvtsV6lFuVpC1
 6gJcLhJGdBG7bxfxGx1FOUMfvTDzUD+TrU1CIx1QrquRfr9dVAUerkg70nHmseed
 JqarWEZII4kiGSC8iUq7EgDtFN7CVImEZod2A4qZSuAYOadcAF43dmOBbN7S0/H5
 5mdXcapQX4xbD/Pm4nHn+Rn6aFjSmWR93B0B/WcEYQYfu/Ew8ILKdvhhiHA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1xx18ktd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 12:41:50 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91256a7b7b3so30291306d6.2
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 04:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795092110; x=1795696910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TXBFO85Uf6MCIXGPNVCTOsUuDlzdh6663Yns1R2b9kM=;
 b=gEjPBlDy5c+mZUj6ylsp0aem2XfjHydwbDq+yRyfK6OmdYEadReNd5DbOmpfkYah4r
 89foh0UgayTfIoalQLqr8NMncvgs//ngmfsvOaFcrLuD0J4o2g/goPD3JR7mlcBirDm3
 4zktvZuenxlK+1e21LTXOad/tOu7PtgfwywHgn+5GkqTxoB+NGXTAOB0NvqTQukq4oAV
 zjicaK/EGJ2m5O9ablxiRR5YV+VZZ3jcQnSlOlVhBDJP7qpxhEMu6XeSzsmrL+Bw8URg
 AppdLVIv+HS94fjRrHiqqNrCsintWUVblmbpthPytO8HwdwLLya+w/YioLeEaavpGndT
 VXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795092110; x=1795696910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TXBFO85Uf6MCIXGPNVCTOsUuDlzdh6663Yns1R2b9kM=;
 b=DO7YccvRKwxImi/JmxPm+0ulsFBWHRUBcYdECmpaC5MeW+zSMV5epV2PYyKG+uXRez
 UBFLYNpR1R7B03//hyn07oFjl2vf8P8TxFAqhIjTWDAQ0H1yUCVC7gUlj36Gc62u+AlL
 ntSwsvOSY5syR/XnYblK+6i1z2s6Hwc5xfw15vSgSwoGej4h47TSzgWbL0oYdZddrkYU
 UWBpHff0AJKbsrBgAIOi6tSHsG3qNGL2ydxfCid2LRA6YqJbTUBYpw5wuHIJkZ49YsM3
 WK3zpsFDg++K0fGR4A4twPp3ZpInioQypmLzT2lE5cbzqj1z1YSSfba7LeUIy3yVxI2U
 /LTA==
X-Gm-Message-State: APuU4Z9YeyfQXfn0RXorFrMmZ72QAl9bDZ1OsydITgCMm0hCKN2RIqzC
 vD5sP2G1RHYJVGmwdUtJoAkb9UrGTZDZlbG4gMahF3DD12NweL5Ej5NenCH6fRhBj6qqTJncesH
 c3smmtqPjzzG0TdK3pvK1ecPR0ax49PZehB/C6hMNEbtqR8JbDi7ZKSstoLAzXDfv8w==
X-Gm-Gg: AZFdTZe5BBVJsBK1olz5viyB2DobzaYoLOq7P6BAZKl8X5UGCVJzNCyjCPZGmKstbVx
 uoK75y4LNKkuEtmze9cWwxr6wII9eJjwbjQYsMbx2LWnkE0VRUdYs83pByTJGeDI1dmtIkBkjzA
 7zh41VjAmMo9iQ8ZjPO8Tzch4wMD/4/Wm9QnJhWGH4k/tp0zEfaBe9kdnIpa+vG9rm6RnowRzGr
 SRhKADdQDKXBAyaaQ63QCtMbBftSEJ3VvMZ5A2u+ffu6ckHJzqqR5Sg11RJ6aG7JYUZoAOqQ+mg
 ZwlTIyv4PaoLzl1rNDT0ogQq5KqWnmBw/F8gPm+aoOVSHpmCdZS/YzvL5Mv09Vg5fXA+UXlXacw
 n2kh5sbwarghLvKPj/Za1mNOaEZfWB1kXBiAuJIqp0IHVMrtnUeh1UbCMjtLpds7V8dvg5zEOVr
 iehrm3t0KdxvTV
X-Received: by 2002:a05:6214:cce:b0:921:2b7f:cde1 with SMTP id
 6a1803df08f44-9212b7fdc00mr21290206d6.9.1795092109727; 
 Thu, 19 Nov 2026 04:41:49 -0800 (PST)
X-Received: by 2002:a05:6214:cce:b0:921:2b7f:cde1 with SMTP id
 6a1803df08f44-9212b7fdc00mr21289826d6.9.1795092109114; 
 Thu, 19 Nov 2026 04:41:49 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([187.106.240.201])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92114d42d39sm49183276d6.21.2026.11.19.04.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 04:41:48 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2 1/1] target/riscv: do not write SXL < UXL [GL4821]
Date: Thu, 19 Nov 2026 09:41:41 -0300
Message-ID: <20261119124141.1279663-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119124141.1279663-1-daniel.barboza@oss.qualcomm.com>
References: <20261119124141.1279663-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PcBqFShd c=1 sm=1 tr=0 ts=6afeee8e cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=7SJRNfuEitxYTu7vBacxyQ==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=l64ddKhEkLFiuVWVZmUA:9 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: aMygeHqQQLJuUucCLiIi8nUANWV87M7-
X-Proofpoint-GUID: aMygeHqQQLJuUucCLiIi8nUANWV87M7-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA1MCBTYWx0ZWRfXwiTj+8e9bLic
 iqu6jwKd/RLBQCuVh5ErQXG6YSJTTV9agWykic+uL4Q/b6bmnuMYNCc0ZiZbDhlBjaXBRZ4qyaU
 K7czrEnMpwMfp5z6rbjmM0lfpt/Snl1OxOPoaqoZpKozrXnFXP4P236jWOs7gSrg7D+QhoPgAzp
 fZShrUwNwqjq/4EIWg89vm3x/MURBkvmFlQkoR75CmhjC7TG8xckbb2P6M8lFUo3MtpYthyjUVp
 ht6+el3HCPw+08XLB5KvD4XBTTNfvVQtzNdrZN2aYLUXQx6HOkwcZOlZkMfnb9NP43ljDFg/fh4
 /9ltdUN98DF1LeIJDQWXAkW16nT9Dpl/yym3t7yesuqwxPC+U2L5yFQT5RDN3+pHev7mGltwW8e
 +J1BqSUBeKGFMeT0awm/FxxgCUC2DBY9p/T6dk0sMZ88UGeSOnnkE9w0+qqgZGckLj7W9DXNosr
 zCvJ5tilUFHOgDU0ISQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA1MCBTYWx0ZWRfX4EmTdHvK+fVS
 b4ScBSqOdTTTF0tNAe2rQ1rJNS6A+vV225p7rnfJ4gKnWf06CS5p8KSNg+gGf/eK0/LNtcZBPCT
 74vI2U1LLTxI3XhPln84dSNK8GEjbbc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190050
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
---
 target/riscv/tcg/csr.c               | 39 ++++++++++++------
 tests/tcg/riscv64/system/meson.build |  7 ++++
 tests/tcg/riscv64/test-uxl-sxl.S     | 59 ++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+), 13 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-uxl-sxl.S

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 24eda54bac..06f4f59d57 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -2049,15 +2049,25 @@ static target_ulong legalize_mpp(CPURISCVState *env, target_ulong old_mpp,
     return val;
 }
 
-static uint64_t riscv_write_uxl(CPURISCVState *env, uint64_t val,
-                                uint64_t field)
+static uint64_t riscv_update_xl_field(CPURISCVState *env, uint64_t val,
+                                      uint64_t field, uint32_t min_field_val)
 {
-    RISCVMXL xl = riscv_cpu_mxl(env);
-    uint64_t uxl = get_field(val, field);
+    RISCVMXL mxl = riscv_cpu_mxl(env);
+    uint64_t xl = get_field(val, field);
+    bool field_updated = false;
+
+    if (xl < min_field_val) {
+        xl = min_field_val;
+        field_updated = true;
+    }
 
-    if (xl != MXL_RV128 && uxl == MXL_RV128) {
-        uxl = xl;
-        val = set_field(val, field, uxl);
+    if (mxl != MXL_RV128 && xl == MXL_RV128) {
+        xl = mxl;
+        field_updated = true;
+    }
+
+    if (field_updated) {
+        val = set_field(val, field, xl);
     }
 
     return val;
@@ -2118,14 +2128,17 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
         if (riscv_has_ext(env, RVH)) {
             mask |= MSTATUS_MPV | MSTATUS_GVA;
         }
-        if (riscv_has_ext(env, RVS) && (val & MSTATUS64_SXL) != 0) {
-            mask |= MSTATUS64_SXL;
-            val = riscv_write_uxl(env, val, MSTATUS64_SXL);
-        }
 
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
 
@@ -5474,7 +5487,7 @@ static RISCVException write_vsstatus(CPURISCVState *env, int csrno,
     if ((val & VSSTATUS64_UXL) == 0) {
         mask &= ~VSSTATUS64_UXL;
     } else {
-        val = riscv_write_uxl(env, val, VSSTATUS64_UXL);
+        val = riscv_update_xl_field(env, val, VSSTATUS64_UXL, 0);
     }
     if ((env->henvcfg & HENVCFG_DTE)) {
         if ((val & SSTATUS_SDT) != 0) {
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index 9edab1fd7a..8775d55b7a 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -88,6 +88,13 @@ tests += {
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


