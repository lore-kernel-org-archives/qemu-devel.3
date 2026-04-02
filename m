Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAB9D39411
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 10:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Fad-0004im-Pf; Thu, 02 Apr 2026 06:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w8FaX-0004fu-7q
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:47:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w8FaT-0007ng-GM
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:47:48 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6326lgFv4009757
 for <qemu-devel@nongnu.org>; Thu, 2 Apr 2026 10:47:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Lt5ZKcS9m82
 7h6lrANzVyp3BPHqMMY0lTAXwtdIH6DQ=; b=F6zoFUQT3FhbXCi/cF6XidoqRIK
 47JhkddEgFhzD4u6xAnGWl7UDpgI0TJgHoJl3LpLBUXMubGzdJ9UqqsGNhQuuFVq
 13qHs042GXgUFsg2g3SEjKGFJi7bVWpbvAmhyxOu0xNOQRTKQRp2DyiMPMzXzebg
 VnUVVO9CpclUaJuDtLd5JaLLEpbgLwzmoew8xMSJRXjxzkoXJpDfP7vrkmDKmi8N
 jxnt4zk6UBqKOT+WprpAYVGCBWWJ8Qnwbf5BryyvrO5oLMsSo8pPb9X4gfYpmYUp
 7f7iNTnpGRXJ6IvDJf6wz/YHJt9T2wozK4LBUU88x3pPa0aGzPdgtgOjSyg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d97e03jxr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 10:47:43 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2c7130f88e3so5925574eec.0
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 03:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775126862; x=1775731662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lt5ZKcS9m827h6lrANzVyp3BPHqMMY0lTAXwtdIH6DQ=;
 b=bMyEqWD2rfJi0FYVuWOhvBRDCUYsFwkkTTC0dubEBfW6G1jmhT2kAvOM/1PPBA2mii
 ErwpDz8k2mf1R0Kw5ksKsShLIHn63sCUpzYJj2gemRvc8JCR+1lE5sMG5PliyQnnLhWV
 uQ82rhzIOpIXyvMnY/AEuL7AipSqSZBvNCoRcgBzZRHKxFMAzGz4OCV+Xdg1IAnlmTvE
 n+FaNjwi58NjTF7e3jpVDc23UHuJdFUVgR4CyvZKmlwgyAqS4dnJOkOOv7TNKiHTEpaN
 pXauVk6Dbzs4nZhOjiMwMOasYD1HNhvFplHejx450VGZ3jSp//aK/zFgiw2NZTLXlj23
 AKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775126862; x=1775731662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lt5ZKcS9m827h6lrANzVyp3BPHqMMY0lTAXwtdIH6DQ=;
 b=JMrGQKbv0TLDfZLimiKUS+0hiUOrpeZgxZFUfYzi0/gn5zrldKf4x3NF0m8QXFfADy
 BVJ8JBXAUQfL7xpnJfq9u+ANyMtpHkamj6cyerg5zIo3A64HmBRG9k619m79F+lOZsj1
 h1Bo/TIerjFU8AFJN7F/t9Z8ICgOxHYsJb0PN+AJWx+y5TUHX+YM6tGI/EI1nmDxNnbs
 Xc+/+q63uHFZpbey6fsZ9vxW45oKps8eUtdwG60TIaGA0xmnExCO/OFqZHlOrRisVkuj
 ON0yzPfyIyFkQ6My9jBrxtuQSWPs6Y+8liC4jj9i1Ez8LRQYdbbZtPAJ0jBJ50wPgdaF
 R9wQ==
X-Gm-Message-State: AOJu0YwFsQ3ESY0wRb7mqF7DghYx0WybnwrEoqVNKE3xXCzaavKcIBfK
 2Cqg+vB9JyK71dzoTVeCnzs9+MI56Z20lKsz4vczkPhafoTLWA3y/b63TY45j7lUGes+LbD6Jks
 OMHlx3TQANnhYN7SwTdkm3t6Du4x2yLeXQuuUb7TJBLd0DWh+UFftSjwJpou1p+1NXOh9
X-Gm-Gg: AeBDiesL55B1YCazz53YgFVl4/GNC+plj+iAH871Oz0OW/IGf5UGuihcksT3e9DOeYu
 49gurQAHZf1Xl+NnPI2de4O+SwmHGPtwO15ATL1lQmg9f2qfVKxFsi/yTSADznw6V35ZPxP+9SC
 WORsmIYyNxZbLACtKqUc3cYozvi3aE26USsUmfQ2Y8WqstyH3Z0yTB0uLAjm5G+MRdy866hYehR
 eTI9tzx/RO7zYfWDHX0Tq9gB/mh09NdDu6MgOFdtlU8FLmB8e8yCnsbnxo+9TKqUWj6wXA6brA1
 ekjM39WrU97nOtgJiUNKMIypfRLuLyrjwOUTkqw53fBjpjxGGjfnhjSnIY4dz/B6iZH4y0Jcpdb
 WDpAWRWqcWT6mlXdnhTfhadbf8oU8AL0QkIjcFFLmohjeZuw026Bs7S4y8BRrcLhalKpU+eCHLi
 6A9jYoVake
X-Received: by 2002:a05:7300:1491:b0:2c5:50fe:c771 with SMTP id
 5a478bee46e88-2c932cbef0fmr3774123eec.29.1775126861979; 
 Thu, 02 Apr 2026 03:47:41 -0700 (PDT)
X-Received: by 2002:a05:7300:1491:b0:2c5:50fe:c771 with SMTP id
 5a478bee46e88-2c932cbef0fmr3774104eec.29.1775126861403; 
 Thu, 02 Apr 2026 03:47:41 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca7d00f5easm2004783eec.29.2026.04.02.03.47.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 03:47:40 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v2 06/16] target/hexagon: add v68 HVX IEEE float arithmetic
 insns
Date: Thu,  2 Apr 2026 03:47:23 -0700
Message-Id: <453a9e248b8c2af50cf89912121605db07792dd5.1775122853.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fdGgCkQF c=1 sm=1 tr=0 ts=69ce494f cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=qE3Jc76nSGxyAz5NJn0A:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: iChYAtFk6qsN0enajCyfPfDp9uvRUJ_h
X-Proofpoint-GUID: iChYAtFk6qsN0enajCyfPfDp9uvRUJ_h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA5NyBTYWx0ZWRfX+AU/e88KFGvQ
 suuBzkkj/ObxxxJjxkVTPeL9yKQdK0o30gcrvbjeeURs6u+ULj3IvSYzoSeWSKNqxyJJPCTsc4M
 ZC+B79QLRIzMhnJah7LallXuR4K5ZEeCf+TkGKKSMM9HgdrVpSSAyjSXJnZW5ZMtUvXUCiKyp39
 clFWOt86Y7y/eklgDR7r3uRuy2J0T1RVwJKWBkVWFCTzEC8O0iwI4TbEYk8JaaWlUggZNaE0gk/
 C/lIX+DiO5AHjO0R6QJcRpL7kE2k4VO0L5O18nC5cKjxtnM5/52JVPGNu1RTK7t8Sb7Fs0/5Okw
 D22SOrAXgC76syucGYdyH9dvD5DRVcJoylEQ0Sh76WpVbl18uwOiPiuN1PrNlIk3LbFyeea16ej
 44dJuN4nCY57UnMsx+IpeePOL04f0JZHrv03GYc1zPQXngPzjWl80L8zKSytv7/juddttSMyqrR
 jCnqMqEE9hNPxPku1jg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020097
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 target/hexagon/cpu.h                         |  1 +
 target/hexagon/mmvec/hvx_ieee_fp.h           | 47 ++++++++++
 target/hexagon/mmvec/macros.h                |  1 +
 target/hexagon/mmvec/mmvec.h                 |  2 +
 target/hexagon/attribs_def.h.inc             |  4 +
 target/hexagon/arch.c                        |  8 ++
 target/hexagon/cpu.c                         |  3 +
 target/hexagon/mmvec/hvx_ieee_fp.c           | 69 +++++++++++++++
 target/hexagon/hex_common.py                 |  1 +
 target/hexagon/imported/mmvec/encode_ext.def | 18 ++++
 target/hexagon/imported/mmvec/ext.idef       | 93 ++++++++++++++++++++
 target/hexagon/meson.build                   |  1 +
 12 files changed, 248 insertions(+)
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
index 0000000000..5577179abd
--- /dev/null
+++ b/target/hexagon/mmvec/hvx_ieee_fp.h
@@ -0,0 +1,47 @@
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
+/* Hexagon canonical NaN */
+#define FP32_DEF_NAN      0x7FFFFFFF
+#define FP16_DEF_NAN      0x7FFF
+
+/*
+ * IEEE - FP ADD/SUB/MPY instructions
+ */
+uint32_t fp_mult_sf_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
+uint32_t fp_add_sf_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
+uint32_t fp_sub_sf_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
+
+uint16_t fp_mult_hf_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
+uint16_t fp_add_hf_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
+uint16_t fp_sub_hf_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
+
+uint32_t fp_mult_sf_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
+uint32_t fp_add_sf_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
+uint32_t fp_sub_sf_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
+
+/*
+ * IEEE - FP Accumulate instructions
+ */
+uint16_t fp_mult_hf_hf_acc(uint16_t a1, uint16_t a2, uint16_t acc,
+                           float_status *fp_status);
+uint32_t fp_mult_sf_hf_acc(uint16_t a1, uint16_t a2, uint32_t acc,
+                           float_status *fp_status);
+
+/*
+ * IEEE - FP Reduce instructions
+ */
+uint32_t fp_vdmpy(uint16_t a1, uint16_t a2, uint16_t a3, uint16_t a4,
+                  float_status *fp_status);
+uint32_t fp_vdmpy_acc(uint32_t acc, uint16_t a1, uint16_t a2, uint16_t a3,
+                      uint16_t a4, float_status *fp_status);
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
index 52d470709c..eaedfe0d6d 100644
--- a/target/hexagon/mmvec/mmvec.h
+++ b/target/hexagon/mmvec/mmvec.h
@@ -38,6 +38,8 @@ typedef union {
     int16_t   h[MAX_VEC_SIZE_BYTES / 2];
     uint8_t  ub[MAX_VEC_SIZE_BYTES / 1];
     int8_t    b[MAX_VEC_SIZE_BYTES / 1];
+    int32_t  sf[MAX_VEC_SIZE_BYTES / 4];   /* single float (32-bit) */
+    int16_t  hf[MAX_VEC_SIZE_BYTES / 2];   /* half float (16-bit) */
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
index 0000000000..ceb32ce43b
--- /dev/null
+++ b/target/hexagon/mmvec/hvx_ieee_fp.c
@@ -0,0 +1,69 @@
+/*
+ *  Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hvx_ieee_fp.h"
+
+#define DEF_FP_INSN_2(name, rt, a1t, a2t, op) \
+    uint##rt##_t fp_##name(uint##a1t##_t a1, uint##a2t##_t a2, \
+                           float_status *fp_status) { \
+        float##a1t f1 = make_float##a1t(a1); \
+        float##a2t f2 = make_float##a2t(a2); \
+        return (op); \
+    }
+
+#define DEF_FP_INSN_3(name, rt, a1t, a2t, a3t, op) \
+    uint##rt##_t fp_##name(uint##a1t##_t a1, uint##a2t##_t a2, \
+                           uint##a3t##_t a3, float_status *fp_status) { \
+        float##a1t f1 = make_float##a1t(a1); \
+        float##a2t f2 = make_float##a2t(a2); \
+        float##a3t f3 = make_float##a3t(a3); \
+        return (op); \
+    }
+
+DEF_FP_INSN_2(mult_sf_sf, 32, 32, 32, float32_mul(f1, f2, fp_status))
+DEF_FP_INSN_2(add_sf_sf, 32, 32, 32, float32_add(f1, f2, fp_status))
+DEF_FP_INSN_2(sub_sf_sf, 32, 32, 32, float32_sub(f1, f2, fp_status))
+
+DEF_FP_INSN_2(mult_hf_hf, 16, 16, 16, float16_mul(f1, f2, fp_status))
+DEF_FP_INSN_2(add_hf_hf, 16, 16, 16, float16_add(f1, f2, fp_status))
+DEF_FP_INSN_2(sub_hf_hf, 16, 16, 16, float16_sub(f1, f2, fp_status))
+
+DEF_FP_INSN_2(mult_sf_hf, 32, 16, 16,
+              float32_mul(float16_to_float32(f1, true, fp_status),
+                          float16_to_float32(f2, true, fp_status),
+                          fp_status))
+DEF_FP_INSN_2(add_sf_hf, 32, 16, 16,
+              float32_add(float16_to_float32(f1, true, fp_status),
+                          float16_to_float32(f2, true, fp_status),
+                          fp_status))
+DEF_FP_INSN_2(sub_sf_hf, 32, 16, 16,
+              float32_sub(float16_to_float32(f1, true, fp_status),
+                          float16_to_float32(f2, true, fp_status),
+                          fp_status))
+
+DEF_FP_INSN_3(mult_hf_hf_acc, 16, 16, 16, 16,
+              float16_muladd(f1, f2, f3, 0, fp_status))
+DEF_FP_INSN_3(mult_sf_hf_acc, 32, 16, 16, 32,
+              float32_muladd(float16_to_float32(f1, true, fp_status),
+                             float16_to_float32(f2, true, fp_status),
+                             f3, 0, fp_status))
+
+uint32_t fp_vdmpy(uint16_t a1, uint16_t a2, uint16_t a3, uint16_t a4,
+                 float_status *fp_status)
+{
+    float32 prod1 = fp_mult_sf_hf(a1, a3, fp_status);
+    float32 prod2 = fp_mult_sf_hf(a2, a4, fp_status);
+    return fp_add_sf_sf(float32_val(prod1), float32_val(prod2), fp_status);
+}
+
+uint32_t fp_vdmpy_acc(uint32_t acc, uint16_t a1, uint16_t a2,
+                      uint16_t a3, uint16_t a4,
+                      float_status *fp_status)
+{
+    float32 red = fp_vdmpy(a1, a2, a3, a4, fp_status);
+    return fp_add_sf_sf(float32_val(red), acc, fp_status);
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
index 03d31f6181..e800cda317 100644
--- a/target/hexagon/imported/mmvec/ext.idef
+++ b/target/hexagon/imported/mmvec/ext.idef
@@ -2895,9 +2895,102 @@ EXTINSN(V6_vprefixqw,"Vd32.w=prefixsum(Qv4)",   ATTRIBS(A_EXTENSION,A_CVI,A_CVI_
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
+    VdV.sf[i] = fp_mult_sf_sf(VuV.sf[i], VvV.sf[i], &env->hvx_fp_status))
+ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vmpy_sf_hf,
+    "Vdd32.sf=vmpy(Vu32.hf,Vv32.hf)", "Vector IEEE mul: hf widen to sf",
+    VddV.v[0].sf[i] = fp_mult_sf_hf(VuV.hf[2*i], VvV.hf[2*i], &env->hvx_fp_status);
+    VddV.v[1].sf[i] = fp_mult_sf_hf(VuV.hf[2*i+1], VvV.hf[2*i+1], &env->hvx_fp_status))
+ITERATOR_INSN_IEEE_FP_16(16, vmpy_hf_hf,     "Vd32.hf=vmpy(Vu32.hf,Vv32.hf)",
+    "Vector IEEE mul: hf",
+    VdV.hf[i] = fp_mult_hf_hf(VuV.hf[i], VvV.hf[i], &env->hvx_fp_status))
+ITERATOR_INSN_IEEE_FP_32(32, vdmpy_sf_hf,     "Vd32.sf=vdmpy(Vu32.hf,Vv32.hf)",
+    "Vector IEEE mul reduction: hf widen to sf",
+    VdV.sf[i] = fp_vdmpy(VuV.hf[2*i+1], VuV.hf[2*i], VvV.hf[2*i+1],
+        VvV.hf[2*i], &env->hvx_fp_status))
+
+/* IEEE FP multiply-accumulate instructions */
+ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vmpy_sf_hf_acc,
+    "Vxx32.sf+=vmpy(Vu32.hf,Vv32.hf)", "Vector IEEE fma: hf widen to sf",
+    VxxV.v[0].sf[i] = fp_mult_sf_hf_acc(VuV.hf[2*i], VvV.hf[2*i],
+        VxxV.v[0].sf[i], &env->hvx_fp_status);
+    VxxV.v[1].sf[i] = fp_mult_sf_hf_acc(VuV.hf[2*i+1], VvV.hf[2*i+1],
+        VxxV.v[1].sf[i], &env->hvx_fp_status))
+ITERATOR_INSN_IEEE_FP_ACC_16(16, vmpy_hf_hf_acc,
+    "Vx32.hf+=vmpy(Vu32.hf,Vv32.hf)", "Vector IEEE fma: hf",
+    VxV.hf[i] = fp_mult_hf_hf_acc(VuV.hf[i], VvV.hf[i], VxV.hf[i], &env->hvx_fp_status))
+ITERATOR_INSN_IEEE_FP_ACC_32(32, vdmpy_sf_hf_acc,
+    "Vx32.sf+=vdmpy(Vu32.hf,Vv32.hf)", "Vector IEEE fma reduce: hf widen to sf",
+    VxV.sf[i] = fp_vdmpy_acc(VxV.sf[i], VuV.hf[2*i+1], VuV.hf[2*i], VvV.hf[2*i+1],
+        VvV.hf[2*i], &env->hvx_fp_status))
+
+/* IEEE FP add/sub instructions */
+ITERATOR_INSN_IEEE_FP_32(32, vadd_sf_sf, "Vd32.sf=vadd(Vu32.sf,Vv32.sf)",
+    "Vector IEEE add: sf",
+    VdV.sf[i] = fp_add_sf_sf(VuV.sf[i], VvV.sf[i], &env->hvx_fp_status))
+ITERATOR_INSN_IEEE_FP_32(32, vsub_sf_sf, "Vd32.sf=vsub(Vu32.sf,Vv32.sf)",
+    "Vector IEEE sub: sf",
+    VdV.sf[i] = fp_sub_sf_sf(VuV.sf[i], VvV.sf[i], &env->hvx_fp_status))
+ITERATOR_INSN_IEEE_FP_16(16, vadd_hf_hf, "Vd32.hf=vadd(Vu32.hf,Vv32.hf)",
+    "Vector IEEE add: hf",
+    VdV.hf[i] = fp_add_hf_hf(VuV.hf[i], VvV.hf[i], &env->hvx_fp_status))
+ITERATOR_INSN_IEEE_FP_16(16, vsub_hf_hf, "Vd32.hf=vsub(Vu32.hf,Vv32.hf)",
+    "Vector IEEE sub: hf",
+    VdV.hf[i] = fp_sub_hf_hf(VuV.hf[i], VvV.hf[i], &env->hvx_fp_status))
+ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vadd_sf_hf,
+    "Vdd32.sf=vadd(Vu32.hf,Vv32.hf)",  "Vector IEEE add: hf widen to sf",
+    VddV.v[0].sf[i] = fp_add_sf_hf(VuV.hf[2*i], VvV.hf[2*i], &env->hvx_fp_status);
+    VddV.v[1].sf[i] = fp_add_sf_hf(VuV.hf[2*i+1], VvV.hf[2*i+1], &env->hvx_fp_status))
+ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vsub_sf_hf,
+    "Vdd32.sf=vsub(Vu32.hf,Vv32.hf)",  "Vector IEEE sub: hf widen to sf",
+    VddV.v[0].sf[i] = fp_sub_sf_hf(VuV.hf[2*i], VvV.hf[2*i], &env->hvx_fp_status);
+    VddV.v[1].sf[i] = fp_sub_sf_hf(VuV.hf[2*i+1], VvV.hf[2*i+1], &env->hvx_fp_status))
 
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


