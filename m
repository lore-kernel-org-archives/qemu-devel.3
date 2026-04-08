Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D00610F996B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXsS-0008Cb-J5; Wed, 08 Apr 2026 14:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wAXsQ-0007ta-2W
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:43:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wAVu2-0006ob-H0
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 12:37:20 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638GC20U1072630
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 16:37:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=nfRX01pCsgZ
 ofrBRBBBLPS9sR+Q0K/b8Bi7xmrVe3Is=; b=QDLKKoJO8pOOI19EzfPZFuQEBw3
 DRRQm9IAEkPktZ2iPe3pFDlis/sIziiZ3lx/kpbFD1zUhTAdfLt7/JCquvURn2xh
 QD6s1/i9x6cD07nXsqzqOu6Mbw8X5/IlDUikZIlqrwS+uAFhz53hxHsEHlo5YpZ9
 cIL4PVDrpv+7xN//tMY9j7zmRLytSDU0oDF61/dqS349Avec50gtzsYmU3SY56yd
 kBrOJ2byXTrjLZayPjjCPvTtvNL41OZJ3Fw/moVZ/Lz3mQa7MBTtMf9m5pZnZK3I
 L3Fz7pAFQROuUweewkv9pmUnnTLK/EBaCnfKNa4QcKPPlgl4QofsP80cFIQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddtb382bk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 16:37:17 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c76b6db8bb2so36147a12.3
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 09:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775666236; x=1776271036; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nfRX01pCsgZofrBRBBBLPS9sR+Q0K/b8Bi7xmrVe3Is=;
 b=G1i/4dbw9vR/9Uv0EDbhEEeq8ZQXbjzSG1sxHu+dVzUWnTFofy3QehkpkFhRA8MkDa
 9A480ZhRvR278jZ4GlImimZj+c9kIFWq6+icmfEIODMbBVwY8v3alswJX6BsoOikbrH3
 v4vwfBFIHepwVvuxpN7n/zmYXpCxIiVO5eCuYZvr494e+/+pxJaWg0OZHc+RjV+2YSj8
 J4yooJU7GzJF9ucBbsNpUkof/m2OHHK+RoDul4plybvIP/tugLBfC1zXVWGoL4efQFHG
 11kUzleUjXCOoaeyhB/M1idbpBVTy2t5ko9eET4xojBJpPD7o94L0P/Kdc20ucT+l5ad
 tQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775666236; x=1776271036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nfRX01pCsgZofrBRBBBLPS9sR+Q0K/b8Bi7xmrVe3Is=;
 b=UfsAF82KOfjJEKIezngvZW6MP1tYAKT/WM2fiD433tIeKlUFWeaI+3RfHp+YDHWOea
 jMFrgqR+GhuFaWLKDRkzdvA/J6cs0CSDUet2Ve20c/jJXekGMWb3OVcYFMMrcDPk8yp/
 Rml6SN7V8dtgCd1WmtvnLLP8Bs2Jrx2yOj0FKcIx9B0nblLrCHP/AGCDkzmfG2VjnjBu
 PgRvMEUPb/8MELKuM8IeDFs2PIhB9toUg+LH3I2ecNBKx1Ev9rZEYCIHB80tjKBU5PVf
 NKpZQZur4L1lCgnz/O40ehILniFOeo1fvmgDvIzVOWJ0MVIvzBtkLGXLaU5j/N+uptye
 ZzKg==
X-Gm-Message-State: AOJu0YxLyfA2fQETdJF/2kTHmlyixc8UWcboqBseLCPA6pQ2ncyV6lKu
 DgeD+/VeQSziTXda9D0J/nyC2+5tJn2vbzz6ftUZptjXG+YDfIzP3fQKGio5LAfvPHlfP5g14aS
 zwHVrx2E+NWIZFBH1JSynG0w/YLsaajBBIMfpToGlGUP9G25BZThV8cTCfmKsxE6r491H
X-Gm-Gg: AeBDietxxz+mAfQo8wiTg8chGfVWibeLk8OBGyFp4sGA4uyq+FW9JMsTMmr5X6mnmS/
 O1m5VFgUYj9dQ5pNLjaD/BZBJHgPNTJo7psRHs3UMtFgEnAWqzGmHz7WfMzseRD3v6MfCQCB/5I
 EkKuPEFIzCGxVsOG4DHQMeOWUgt9d9RRdf2hzms4avXgdMfEeMA5Tp2u7PSBEmipSUhYFuymO60
 fmjtLF14QAY6GwZ+RcSvTO9GbELX8MvHuNRtJrl/gAgJEmzGoksDP/M48hp/JWbXfUz5zDpRZvG
 N1nJ5cMuV2TfJNmjv0NpP3i3GFKlBlfYhaVw29CLa0duZVTrLNVPMwIVYKBu539iwoVi3eJNmff
 eM+42xKhbWH0et62gar9rM9oVKLx8nSedXhT0VlVynTyWvZKXhkzgYaXk/6lcJsEY9Q6k3a4bAC
 dJi2FfZSGl
X-Received: by 2002:a05:7022:10d:b0:12a:7181:2f1c with SMTP id
 a92af1059eb24-12bfb7452bcmr11882512c88.17.1775666235726; 
 Wed, 08 Apr 2026 09:37:15 -0700 (PDT)
X-Received: by 2002:a05:7022:10d:b0:12a:7181:2f1c with SMTP id
 a92af1059eb24-12bfb7452bcmr11882482c88.17.1775666235044; 
 Wed, 08 Apr 2026 09:37:15 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c1ff43d04sm4082006c88.4.2026.04.08.09.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:37:14 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v3 06/16] target/hexagon: add v68 HVX IEEE float arithmetic
 insns
Date: Wed,  8 Apr 2026 09:36:57 -0700
Message-Id: <42b4b2d1c61637d9fd951f05371fad452d9af77e.1775665981.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE1NCBTYWx0ZWRfXw/I+t6CGDT8U
 iOJOXBJKDa9zQLVyelGOqHuSMQnilbwUz2kXpCYlc/fGj+DA85nxmIUwO2JGARpU+gceRlnz9Ck
 a7TKBY2HDkrrYokB5WSYDWXWi0eT1Zgh9Ay2wrNS3XapSbxtW5fVRLeTD9K9ajbmQ4CWF599lf/
 RVtDa8L4wxeFzZtAwk9dN3fLvoISZGs7sDkUTZS4tuyggQzX48GSko/o4dWhreiPAKyfj2bUPaW
 HxRxy8yn/RQDjQI1CcjGdYW23TJBTajtmCKJ5NjOZl27WTj8moc/UjDKlF8/8k3FGjwGexvGndU
 vbKWuf5au4UpV7dr6W9yXmmHb/iWrNa+m/PxW52CIV95jyJFfBPm7YTS0NXpkOGs/xWbuncM+il
 hVDTsxFqrJLG8xa0ipyL6jRrb4hHGHmk3cp3NlY5ejPVnTrxaoXV1OCLQUNXV3jl9jjeKqDHblB
 kshbHUhtDSdc9WhG5cg==
X-Authority-Analysis: v=2.4 cv=eKIjSnp1 c=1 sm=1 tr=0 ts=69d6843d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=4NIkZbyvPJlZ22FWuuMA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: HLGYYXeIKSfPL1foGRcZUoaI8dwNHoWE
X-Proofpoint-ORIG-GUID: HLGYYXeIKSfPL1foGRcZUoaI8dwNHoWE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080154
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add HVX IEEE floating-point arithmetic instructions:
- vmpy_sf_sf, vmpy_sf_hf, vmpy_hf_hf: multiply operations
- vdmpy_sf_hf: dot-product multiply
- vmpy_sf_hf_acc, vmpy_hf_hf_acc, vdmpy_sf_hf_acc: multiply-accumulate
- vadd_sf_sf, vsub_sf_sf, vadd_sf_hf, vsub_sf_hf: add/sub with sf output
- vadd_hf_hf, vsub_hf_hf: add/sub with hf output

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/cpu.h                         |   1 +
 target/hexagon/mmvec/hvx_ieee_fp.h           |  18 ++++
 target/hexagon/mmvec/macros.h                |   1 +
 target/hexagon/mmvec/mmvec.h                 |   2 +
 target/hexagon/attribs_def.h.inc             |   4 +
 target/hexagon/arch.c                        |   8 ++
 target/hexagon/cpu.c                         |   3 +
 target/hexagon/mmvec/hvx_ieee_fp.c           |  21 ++++
 target/hexagon/hex_common.py                 |   1 +
 target/hexagon/imported/mmvec/encode_ext.def |  18 ++++
 target/hexagon/imported/mmvec/ext.idef       | 101 +++++++++++++++++++
 target/hexagon/meson.build                   |   1 +
 12 files changed, 179 insertions(+)
 create mode 100644 target/hexagon/mmvec/hvx_ieee_fp.h
 create mode 100644 target/hexagon/mmvec/hvx_ieee_fp.c

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index d28beaa92f..5a008d1949 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -87,6 +87,7 @@ typedef struct CPUArchState {
     MemLog mem_log_stores[STORES_MAX];
 
     float_status fp_status;
+    float_status hvx_fp_status;
 
     target_ulong llsc_addr;
     target_ulong llsc_val;
diff --git a/target/hexagon/mmvec/hvx_ieee_fp.h b/target/hexagon/mmvec/hvx_ieee_fp.h
new file mode 100644
index 0000000000..75008deb3b
--- /dev/null
+++ b/target/hexagon/mmvec/hvx_ieee_fp.h
@@ -0,0 +1,18 @@
+/*
+ *  Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HEXAGON_HVX_IEEE_H
+#define HEXAGON_HVX_IEEE_H
+
+#include "fpu/softfloat.h"
+
+#define f16_to_f32(A) float16_to_float32((A), true, &env->hvx_fp_status)
+
+float32 fp_mult_sf_hf(float16 a1, float16 a2, float_status *fp_status);
+float32 fp_vdmpy(float16 a1, float16 a2, float16 a3, float16 a4,
+                 float_status *fp_status);
+
+#endif
diff --git a/target/hexagon/mmvec/macros.h b/target/hexagon/mmvec/macros.h
index c7840fbf2e..ac709d8993 100644
--- a/target/hexagon/mmvec/macros.h
+++ b/target/hexagon/mmvec/macros.h
@@ -23,6 +23,7 @@
 #include "mmvec/system_ext_mmvec.h"
 #include "accel/tcg/getpc.h"
 #include "accel/tcg/probe.h"
+#include "mmvec/hvx_ieee_fp.h"
 
 #ifndef QEMU_GENERATE
 #define VdV      (*(MMVector *restrict)(VdV_void))
diff --git a/target/hexagon/mmvec/mmvec.h b/target/hexagon/mmvec/mmvec.h
index 52d470709c..31909303b5 100644
--- a/target/hexagon/mmvec/mmvec.h
+++ b/target/hexagon/mmvec/mmvec.h
@@ -38,6 +38,8 @@ typedef union {
     int16_t   h[MAX_VEC_SIZE_BYTES / 2];
     uint8_t  ub[MAX_VEC_SIZE_BYTES / 1];
     int8_t    b[MAX_VEC_SIZE_BYTES / 1];
+    float32  sf[MAX_VEC_SIZE_BYTES / 4];
+    float16  hf[MAX_VEC_SIZE_BYTES / 2];
 } MMVector;
 
 typedef union {
diff --git a/target/hexagon/attribs_def.h.inc b/target/hexagon/attribs_def.h.inc
index c85cd5d17c..d3c4bf6301 100644
--- a/target/hexagon/attribs_def.h.inc
+++ b/target/hexagon/attribs_def.h.inc
@@ -175,6 +175,10 @@ DEF_ATTRIB(RESTRICT_LATEPRED, "Predicate can not be used as a .new.", "", "")
 
 /* HVX IEEE FP extension attributes */
 DEF_ATTRIB(HVX_IEEE_FP, "HVX IEEE FP extension instruction", "", "")
+DEF_ATTRIB(HVX_IEEE_FP_ACC, "HVX IEEE FP accumulate instruction", "", "")
+DEF_ATTRIB(HVX_IEEE_FP_OUT_16, "HVX IEEE FP 16-bit output", "", "")
+DEF_ATTRIB(HVX_IEEE_FP_OUT_32, "HVX IEEE FP 32-bit output", "", "")
+DEF_ATTRIB(CVI_VX_NO_TMP_LD, "HVX multiply without tmp load", "", "")
 
 /* Keep this as the last attribute: */
 DEF_ATTRIB(ZZ_LASTATTRIB, "Last attribute in the file", "", "")
diff --git a/target/hexagon/arch.c b/target/hexagon/arch.c
index e17e714a6a..358aa71e03 100644
--- a/target/hexagon/arch.c
+++ b/target/hexagon/arch.c
@@ -199,6 +199,10 @@ void arch_fpop_start(CPUHexagonState *env)
     set_float_rounding_mode(
         softfloat_roundingmodes[fREAD_REG_FIELD(USR, USR_FPRND)],
         &env->fp_status);
+    /*
+     * No need to check env->hvx_fp_status, these instructions don't
+     * raise exceptions nor interact with usr fields.
+     */
 }
 
 #ifdef CONFIG_USER_ONLY
@@ -232,6 +236,10 @@ void arch_fpop_end(CPUHexagonState *env, bool pkt_need_commit)
         SOFTFLOAT_TEST_FLAG(float_flag_overflow, FPOVFF, FPOVFE);
         SOFTFLOAT_TEST_FLAG(float_flag_underflow, FPUNFF, FPUNFE);
     }
+    /*
+     * No need to check env->hvx_fp_status, these instructions don't
+     * raise exceptions nor interact with usr fields.
+     */
 }
 
 int arch_sf_recip_common(float32 *Rs, float32 *Rt, float32 *Rd, int *adjust,
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index d7f4df5f96..d6ca51f175 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -300,6 +300,9 @@ static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
     set_float_detect_tininess(float_tininess_before_rounding, &env->fp_status);
     /* Default NaN value: sign bit set, all frac bits set */
     set_float_default_nan_pattern(0b11111111, &env->fp_status);
+
+    set_default_nan_mode(1, &env->hvx_fp_status);
+    set_float_default_nan_pattern(0b01111111, &env->hvx_fp_status);
 }
 
 static void hexagon_cpu_disas_set_info(const CPUState *cs,
diff --git a/target/hexagon/mmvec/hvx_ieee_fp.c b/target/hexagon/mmvec/hvx_ieee_fp.c
new file mode 100644
index 0000000000..3367226998
--- /dev/null
+++ b/target/hexagon/mmvec/hvx_ieee_fp.c
@@ -0,0 +1,21 @@
+/*
+ *  Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hvx_ieee_fp.h"
+
+float32 fp_mult_sf_hf(float16 a1, float16 a2, float_status *fp_status)
+{
+    return float32_mul(float16_to_float32(a1, true, fp_status),
+                       float16_to_float32(a2, true, fp_status), fp_status);
+}
+
+float32 fp_vdmpy(float16 a1, float16 a2, float16 a3, float16 a4,
+                 float_status *fp_status)
+{
+    return float32_add(fp_mult_sf_hf(a1, a3, fp_status),
+                       fp_mult_sf_hf(a2, a4, fp_status), fp_status);
+}
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index 32a61505ce..9e8bcfdcf0 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -215,6 +215,7 @@ def need_env(tag):
             "A_LOAD" in attribdict[tag] or
             "A_CVI_GATHER" in attribdict[tag] or
             "A_CVI_SCATTER" in attribdict[tag] or
+            "A_HVX_IEEE_FP" in attribdict[tag] or
             "A_IMPLICIT_WRITES_USR" in attribdict[tag])
 
 
diff --git a/target/hexagon/imported/mmvec/encode_ext.def b/target/hexagon/imported/mmvec/encode_ext.def
index 6d70086b5f..4ce87d09fd 100644
--- a/target/hexagon/imported/mmvec/encode_ext.def
+++ b/target/hexagon/imported/mmvec/encode_ext.def
@@ -804,5 +804,23 @@ DEF_ENC(V6_vmpyewuh,    ICLASS_CJ" 1 111 111 vvvvv PP 0 uuuuu 101 ddddd")
 DEF_ENC(V6_vmpyowh,        ICLASS_CJ" 1 111 111 vvvvv PP 0 uuuuu 111 ddddd")
 DEF_ENC(V6_vmpyuhvs,"00011111110vvvvvPP1uuuuu111ddddd")
 
+/* IEEE FP multiply instructions */
+DEF_ENC(V6_vmpy_sf_sf,"00011111100vvvvvPP1uuuuu001ddddd")
+DEF_ENC(V6_vmpy_sf_hf,"00011111100vvvvvPP1uuuuu010ddddd")
+DEF_ENC(V6_vmpy_hf_hf,"00011111100vvvvvPP1uuuuu011ddddd")
+DEF_ENC(V6_vdmpy_sf_hf,"00011111101vvvvvPP1uuuuu110ddddd")
+
+/* IEEE FP multiply-accumulate instructions */
+DEF_ENC(V6_vmpy_sf_hf_acc,"00011100010vvvvvPP1uuuuu001xxxxx")
+DEF_ENC(V6_vmpy_hf_hf_acc,"00011100010vvvvvPP1uuuuu010xxxxx")
+DEF_ENC(V6_vdmpy_sf_hf_acc,"00011100010vvvvvPP1uuuuu011xxxxx")
+
+/* IEEE FP add/sub instructions */
+DEF_ENC(V6_vadd_sf_sf,"00011111100vvvvvPP1uuuuu110ddddd")
+DEF_ENC(V6_vsub_sf_sf,"00011111100vvvvvPP1uuuuu111ddddd")
+DEF_ENC(V6_vadd_sf_hf,"00011111100vvvvvPP1uuuuu100ddddd")
+DEF_ENC(V6_vsub_sf_hf,"00011111100vvvvvPP1uuuuu101ddddd")
+DEF_ENC(V6_vadd_hf_hf,"00011111101vvvvvPP1uuuuu111ddddd")
+DEF_ENC(V6_vsub_hf_hf,"00011111011vvvvvPP1uuuuu000ddddd")
 
 #endif /* NO MMVEC */
diff --git a/target/hexagon/imported/mmvec/ext.idef b/target/hexagon/imported/mmvec/ext.idef
index 03d31f6181..14df8e4790 100644
--- a/target/hexagon/imported/mmvec/ext.idef
+++ b/target/hexagon/imported/mmvec/ext.idef
@@ -2895,9 +2895,110 @@ EXTINSN(V6_vprefixqw,"Vd32.w=prefixsum(Qv4)",   ATTRIBS(A_EXTENSION,A_CVI,A_CVI_
     }
     } )
 
+/* KVX - IEEE FP Instructions */
 
+/* Single pipe, 32-bit output */
+#define ITERATOR_INSN_IEEE_FP_32(WIDTH,TAG,SYNTAX,DESCR,CODE) \
+EXTINSN(V6_##TAG, SYNTAX, \
+ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX,A_HVX_IEEE_FP_OUT_32), \
+DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
 
+/* Single pipe, 16-bit output */
+#define ITERATOR_INSN_IEEE_FP_16(WIDTH,TAG,SYNTAX,DESCR,CODE) \
+EXTINSN(V6_##TAG, SYNTAX, \
+ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX,A_HVX_IEEE_FP_OUT_16), \
+DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
 
+/* Two pipes: P2 & P3, single output: P2, 32-bit output */
+#define ITERATOR_INSN_IEEE_FP_DOUBLE_SINGLE_32(WIDTH,TAG,SYNTAX,DESCR,CODE) \
+EXTINSN(V6_##TAG, SYNTAX, \
+ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX_DV,A_HVX_IEEE_FP_OUT_32), \
+DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
+
+/* Two pipes: P2 & P3, two outputs, 32-bit output */
+#define ITERATOR_INSN_IEEE_FP_DOUBLE_32(WIDTH,TAG,SYNTAX,DESCR,CODE) \
+EXTINSN(V6_##TAG, SYNTAX, \
+ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX_DV,A_HVX_IEEE_FP_OUT_32), \
+DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
+
+/*
+ * single pipe, accumulate instruction, produces 16-bit output, requires 16-bit
+ * accumulate input
+ */
+#define ITERATOR_INSN_IEEE_FP_ACC_16(WIDTH,TAG,SYNTAX,DESCR,CODE) \
+EXTINSN(V6_##TAG, SYNTAX, \
+ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX,A_HVX_IEEE_FP_ACC,A_HVX_IEEE_FP_OUT_16,A_CVI_VX_NO_TMP_LD), \
+DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
+
+/*
+ * single pipe, accumulate instruction, produces 32-bit output, requires 32-bit
+ * accumulate input
+ */
+#define ITERATOR_INSN_IEEE_FP_ACC_32(WIDTH,TAG,SYNTAX,DESCR,CODE) \
+EXTINSN(V6_##TAG, SYNTAX, \
+ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX,A_HVX_IEEE_FP_ACC,A_HVX_IEEE_FP_OUT_32,A_CVI_VX_NO_TMP_LD), \
+DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
+
+/* IEEE FP multiply instructions */
+ITERATOR_INSN_IEEE_FP_DOUBLE_SINGLE_32(32, vmpy_sf_sf,
+    "Vd32.sf=vmpy(Vu32.sf,Vv32.sf)", "Vector IEEE mul: sf",
+    VdV.sf[i] = float32_mul(VuV.sf[i], VvV.sf[i], &env->hvx_fp_status))
+ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vmpy_sf_hf,
+    "Vdd32.sf=vmpy(Vu32.hf,Vv32.hf)", "Vector IEEE mul: hf widen to sf",
+    VddV.v[0].sf[i] = fp_mult_sf_hf(VuV.hf[2*i], VvV.hf[2*i], &env->hvx_fp_status);
+    VddV.v[1].sf[i] = fp_mult_sf_hf(VuV.hf[2*i+1], VvV.hf[2*i+1], &env->hvx_fp_status))
+ITERATOR_INSN_IEEE_FP_16(16, vmpy_hf_hf,     "Vd32.hf=vmpy(Vu32.hf,Vv32.hf)",
+    "Vector IEEE mul: hf",
+    VdV.hf[i] = float16_mul(VuV.hf[i], VvV.hf[i], &env->hvx_fp_status))
+ITERATOR_INSN_IEEE_FP_32(32, vdmpy_sf_hf,     "Vd32.sf=vdmpy(Vu32.hf,Vv32.hf)",
+    "Vector IEEE mul reduction: hf widen to sf",
+    VdV.sf[i] = fp_vdmpy(VuV.hf[2*i+1], VuV.hf[2*i], VvV.hf[2*i+1],
+        VvV.hf[2*i], &env->hvx_fp_status))
+
+/* IEEE FP multiply-accumulate instructions */
+ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vmpy_sf_hf_acc,
+    "Vxx32.sf+=vmpy(Vu32.hf,Vv32.hf)", "Vector IEEE fma: hf widen to sf",
+    VxxV.v[0].sf[i] = float32_muladd(f16_to_f32(VuV.hf[2*i]),
+                                     f16_to_f32(VvV.hf[2*i]),
+                                     VxxV.v[0].sf[i], 0, &env->hvx_fp_status);
+    VxxV.v[1].sf[i] = float32_muladd(f16_to_f32(VuV.hf[2*i+1]),
+                                     f16_to_f32(VvV.hf[2*i+1]),
+                                     VxxV.v[1].sf[i], 0, &env->hvx_fp_status))
+ITERATOR_INSN_IEEE_FP_ACC_16(16, vmpy_hf_hf_acc,
+    "Vx32.hf+=vmpy(Vu32.hf,Vv32.hf)", "Vector IEEE fma: hf",
+    VxV.hf[i] = float16_muladd(VuV.hf[i], VvV.hf[i], VxV.hf[i], 0, &env->hvx_fp_status))
+ITERATOR_INSN_IEEE_FP_ACC_32(32, vdmpy_sf_hf_acc,
+    "Vx32.sf+=vdmpy(Vu32.hf,Vv32.hf)", "Vector IEEE fma reduce: hf widen to sf",
+    VxV.sf[i] = float32_add(fp_vdmpy(VuV.hf[2*i+1], VuV.hf[2*i],
+                                     VvV.hf[2*i+1], VvV.hf[2*i],
+                                     &env->hvx_fp_status),
+                            VxV.sf[i], &env->hvx_fp_status))
+
+/* IEEE FP add/sub instructions */
+ITERATOR_INSN_IEEE_FP_32(32, vadd_sf_sf, "Vd32.sf=vadd(Vu32.sf,Vv32.sf)",
+    "Vector IEEE add: sf",
+    VdV.sf[i] = float32_add(VuV.sf[i], VvV.sf[i], &env->hvx_fp_status))
+ITERATOR_INSN_IEEE_FP_32(32, vsub_sf_sf, "Vd32.sf=vsub(Vu32.sf,Vv32.sf)",
+    "Vector IEEE sub: sf",
+    VdV.sf[i] = float32_sub(VuV.sf[i], VvV.sf[i], &env->hvx_fp_status))
+ITERATOR_INSN_IEEE_FP_16(16, vadd_hf_hf, "Vd32.hf=vadd(Vu32.hf,Vv32.hf)",
+    "Vector IEEE add: hf",
+    VdV.hf[i] = float16_add(VuV.hf[i], VvV.hf[i], &env->hvx_fp_status))
+ITERATOR_INSN_IEEE_FP_16(16, vsub_hf_hf, "Vd32.hf=vsub(Vu32.hf,Vv32.hf)",
+    "Vector IEEE sub: hf",
+    VdV.hf[i] = float16_sub(VuV.hf[i], VvV.hf[i], &env->hvx_fp_status))
+ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vadd_sf_hf,
+    "Vdd32.sf=vadd(Vu32.hf,Vv32.hf)",  "Vector IEEE add: hf widen to sf",
+    VddV.v[0].sf[i] = float32_add(f16_to_f32(VuV.hf[2*i]),
+                                  f16_to_f32(VvV.hf[2*i]), &env->hvx_fp_status);
+    VddV.v[1].sf[i] = float32_add(f16_to_f32(VuV.hf[2*i+1]),
+                                  f16_to_f32(VvV.hf[2*i+1]), &env->hvx_fp_status))
+ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vsub_sf_hf,
+    "Vdd32.sf=vsub(Vu32.hf,Vv32.hf)",  "Vector IEEE sub: hf widen to sf",
+    VddV.v[0].sf[i] = float32_sub(f16_to_f32(VuV.hf[2*i]),
+                                  f16_to_f32(VvV.hf[2*i]), &env->hvx_fp_status);
+    VddV.v[1].sf[i] = float32_sub(f16_to_f32(VuV.hf[2*i+1]),
+                                  f16_to_f32(VvV.hf[2*i+1]), &env->hvx_fp_status))
 
 /******************************************************************************
  DEBUG Vector/Register Printing
diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
index d169cf71b2..9195014821 100644
--- a/target/hexagon/meson.build
+++ b/target/hexagon/meson.build
@@ -250,6 +250,7 @@ hexagon_ss.add(files(
     'fma_emu.c',
     'mmvec/decode_ext_mmvec.c',
     'mmvec/system_ext_mmvec.c',
+    'mmvec/hvx_ieee_fp.c',
 ))
 
 #
-- 
2.37.2


