Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB78F45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 17:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBG5g-0006p4-Kz; Fri, 10 Apr 2026 13:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wBG5a-0006nZ-RO
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 13:56:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wBG5X-0001aU-SL
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 13:56:18 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63AHVYOH707613
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 17:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=jCVq6vhL1FM
 NRU1Z8bQ3f+kHHA+t9pwM2JO0iG0it9o=; b=kEmOu4kzO1217IX5q8+j2AS3SxS
 enTLkGI0tT5Pw6hjK6SD1Tr8Q7oNB0MwFfCZqyKqO7lYGbLRjNaKZBoaVcuvuxkv
 91GKPDHDy383nTZW+Z+eswHPCkrTGzrh1kSG5Z/vbVTqFlYpPa2nATz6t2sY4Y/Z
 zidXpy6T7dfVJ8Teb1IfjjGkjwuuzfCubpYwdHJzyO4/WAhsFa+fDCmZ4tWN2UGz
 VaH8K3k+0U8yzRqwEmgZnZeOEjHp2qIJj9e5cN7gVQZGRGUDZo3+ov+1XNVvAoVJ
 c0hCZ6W6G/wvJCDu5KlRo9b7raJ1QddVI6xqQMltaoVzMQOd0ZCt8avPOMg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deudj2dh6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 17:56:14 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2bdf6fe90a9so3286854eec.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 10:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775843773; x=1776448573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jCVq6vhL1FMNRU1Z8bQ3f+kHHA+t9pwM2JO0iG0it9o=;
 b=dP5MGRgKhKMO9eV6JQ9mDjKwLSlfrUHlJ1dCtMabcuOmUMTpqtSGyqllEh6EBv6tfe
 ctgpINekokQSVAIVe0bWSeExxQWcoKK3bC/g6nfuKjFphRpYV5svsJyMskLd+1RCxm5T
 tkUomKtdy8wMHgQG76c3E6fWIad3pugkoVH6sObgWwUimtWVXFwIiNLSaCNRKe9iCUTP
 0u7Q1p0rpJyVvg0LO58CU2QktsuWrIA1AORSTL1pROH8NYTDhI+Y0mPBbVqW18n6pi+Y
 RRi0iBkWaEL2HAkKXk3pWxXUSJiH4VCxN9KYKS5kysWCb+qs9hr/PnOz+yJwHmHdOaU0
 kiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775843773; x=1776448573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jCVq6vhL1FMNRU1Z8bQ3f+kHHA+t9pwM2JO0iG0it9o=;
 b=NKJS1Ni5H0UI4cNqjE+LjDrLb7O6eG7uuE6k0aFpzeXIHUOphmLokkpkoPlRKdd84v
 nHD6WGQ8ekjjjMNWnSz6po5DcxGnuXlvdqczZFGvmONWMj7VQSa5rruMK/NdR5bgYSuQ
 BAuMOFQlCwuXgFxAyxuYwBGGy2kgA3y4bSD0KB6+sPKPt5EZymB/bzLd7zUSKWyU/3Qz
 a/yJCVKEExtzOMJGizs5alJL8KGzknNi+smTAc8Sj9zXU/3VQxE4r3xlqmMdprfIgco7
 i1KrZzrhJO/RNYGBvMqq0CGiN84GcmOBtr5CokRopMqQIdRZqHLRiftQ5PbVEew2WV6O
 VPPw==
X-Gm-Message-State: AOJu0Yxv5779AVg94DoQsI6pupeiXNIxOhwMQ7y7GawA9s8I9XfLH1Vf
 8+6eAuCdZVXGokCkDI43u+4vrhUzYM3VmgONQN1hodOmrtkVzjjoTS9jEOiXTHAtMw5p6D6Wp11
 14rMMNDa/giQSgbKxdbCDCVPV/W2qJLMSG0mSq1Pq8825ZZulqCGuU6JAddaZDxfNAkNx
X-Gm-Gg: AeBDietZJKByYLrsv8vaeSlX6Y2Fdv+AOKGESWn5Z9oZC5iaUc5WK/VWaoB89MIrGhZ
 KyGzWL3Uzlzor8LE6LqqFgJED5+WtvgF5mkuv/tIzXzwRqVQIyGf3NiueSk8dQo9FuqT0RE1kTg
 1WVko5m8Ciq6IdCbXW/JvbPnsp9d00zwqdWdPQisis1bmLEDmn/jwdTZldGWFUd0mqTBIvA7VbM
 jV3AhLQE8pksKdIwSmJq2vq4hEBi7GOx42BaKP7qWOC3wnC+HOcdLR9/Kog7d/AtzwDBbG+AA7y
 t0T6e+bt049zxds78ftXA7kQBfJ1JhcrRcS58Y/ANrg8aJaJdznva88Y75d4PWG7XWviktk9Shs
 G3hEFYDBOxKvJevjI2DmUKww4pNYwNQ91ez9D68zKNlCAHy1uqrWI4SyG6vn4GpBaOuguq0vcR6
 vcmgDVqGaS
X-Received: by 2002:a05:7022:618e:b0:12a:67b7:53f8 with SMTP id
 a92af1059eb24-12c34e55131mr2316120c88.8.1775843773249; 
 Fri, 10 Apr 2026 10:56:13 -0700 (PDT)
X-Received: by 2002:a05:7022:618e:b0:12a:67b7:53f8 with SMTP id
 a92af1059eb24-12c34e55131mr2316098c88.8.1775843772477; 
 Fri, 10 Apr 2026 10:56:12 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c3459f7ffsm4256271c88.3.2026.04.10.10.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 10:56:12 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v4 06/16] target/hexagon: add v68 HVX IEEE float arithmetic
 insns
Date: Fri, 10 Apr 2026 10:55:54 -0700
Message-Id: <8c9ded658c14364204f075ca233da22a9d3a5d69.1775843299.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775843299.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775843299.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: UWS7DK0PrQ_h-lU6ufQcxUFCx9bmKnDW
X-Proofpoint-GUID: UWS7DK0PrQ_h-lU6ufQcxUFCx9bmKnDW
X-Authority-Analysis: v=2.4 cv=cKfQdFeN c=1 sm=1 tr=0 ts=69d939be cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=4NIkZbyvPJlZ22FWuuMA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDE2OCBTYWx0ZWRfX0nPsAIYJ+8ne
 makrvwWEwMm9Ljv9fWfCTh3P9GEOhtBHG7lQdXqbtIcVMxGbcRMswUNRrXFuU6wxSkA3c6rAqEJ
 3zf2B4Wj9lAYxBG6Kj8+9ampApiAUQ5nSef2KZ5UwQpTLdpPyjkJer/0r5yBoIXb4CCvBhvt6Kq
 i1kExtXEx5zpScUMXl/oSEOrlLc7gZqiNGCekERDPFQENfScaRaisde8jXvzuuxKZ5N1dMTlcg9
 zYxQW1f6qfzhrprpKRHF072ShYGQF2/8hYMg0xQFbNQoAije2FP8rbfE/dtnsuyjHl58yN7hw9x
 4BNUudO+ZLDVGjZPMKjlH6j7C47az8kHfFjBGob9Q8B2WaQFVtEFR8yXsjODoFCo+Wl4bQIQCpa
 0Uw1WImld+ib9AGizEhoIgMmhXPdr4aNuW6kDaZe86JS4aeizC2YXqUNVDF4fYq0SDSMCB9zy93
 Mtf4bpETGCVVHBFBcpw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100168
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
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
index e82a3da1e4..9819201b50 100755
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


