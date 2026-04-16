Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DD0F8A163
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 11:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDL4S-0005Fv-IG; Thu, 16 Apr 2026 07:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wDL4J-00058e-80
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:39:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wDL4G-0003Bh-Uj
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:39:35 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G7ks1C3734203
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Bg1UFBpl/g/
 grPN4mrUk1QpMFLxFYUiGmyxRz34H1ss=; b=XNHuF1/by/s7ilw0e67H5g5AcVy
 QiZlO5FO7hW8Pu08Diworf0HZ0bHXuUsqbafseNPzFAPFl1BE0hq7Ht5jAQSyDBc
 0DhRU94X9M3lfU9yIleFnyYEWaWFWwuNnqx5t7+p57TLPQZD7HBxeCnzQrw6oNdK
 S8Kj4jyiV4yemU0VJ6PKAwYA3j6ap/3mcj/oo2FRZ3kt+fiEZRrhHbdn40wtjs4A
 ANiKX0SGyMX9fVblBNYiWLWcCfxRMxeJEs2Ukg+kfsG+G3gTy37tULSijANqUo1s
 ZvLzUY/iqj60lVYnVcA7oehi0nDcztcX4WUYbx1W6DpCqVrvEsi01ZeJCtg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djcqwktx6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:39:21 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2bdf6fe90a9so11502678eec.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 04:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776339561; x=1776944361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bg1UFBpl/g/grPN4mrUk1QpMFLxFYUiGmyxRz34H1ss=;
 b=ZqJsvypT7ZQCVwNOaWSPBobCJAsfT7C49CZqmFwsn1M1h0iVHQDizYmwlIAFqOfLGl
 SA7rpilFdjaJnzMHSvV2PXwjYNJVSeRX35I0xP4L90FFNuezyZcCr1SmA/Zz7ocGqYS9
 SEUVMp6eTnW6MLTYWrDLrnJxzFFE4qyg+svN6rGSGYo9H7UEZMqdPrDZM1bKK9RO63Xj
 +lhuuS3F+hzr3BmK+zDd99Cp66sMXoxv7vG8SvhySY1RPa/Wwym6b7gnICmgg28Ztr8o
 ztFpS4fdaCtVeppAN1EZ/OJ/EgsF9/u+RR468T9O57zkXBuqSKRVs6mjjC37vLOf5ofM
 UCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776339561; x=1776944361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bg1UFBpl/g/grPN4mrUk1QpMFLxFYUiGmyxRz34H1ss=;
 b=qLY2Qqt9m+TZr5ZYCs3zNCj1Qy00xoAvmQRHxjipQ6ysg/YdnVnv51+H/2XjgQpFJg
 SR6ZSFzyPSgaAsoI39JefeSio5qbXO3Uzio5rtIRhoC4pTOj8fHO8xWhnGzP02raE/op
 5x1KzKPBjQrby6KFiVfNd4kUxJ+gWQqS8/OS4jZXLV7wc+eE3rfsEU8trKfLfcRvDkjX
 MR6sOTJpusBQqnNSUj6X5kXfJnD38wx5lp8QolCgCfyvyO05Yi4jd+qf7DQG5i2rApez
 FVxECR0tQMna+xhVYbEP/HjimRZhBKovJtOHxHTCP768daYGpY+smtRSQAob0OpD5+bb
 fylw==
X-Gm-Message-State: AOJu0YwqE9ucEcWCxZWsjiizPrWLeKL61jIL3DQVG7/bHLcqx/s15say
 wktRYRSzEA3VNWfy6jPnHte7vn1NKS/RQgHIG49PsYNo6DrZc8PgJJiGDnA85TeHfGphm9cnZcE
 LEI2NC8cQcOgJg+hheIIj93TgItDQDIKYxZYDlzoSYv5ljVPyfFzU397Mg2Ze4f+7egI2
X-Gm-Gg: AeBDievHMMDlq79eWkVd6/t5GkTGZPM4fOhhtj/w94/IArQiEWzwMmbu85E/qyOW5Du
 x0epzUa1SDWFyOHb6r6CVSVHAVw9yLArbVrpN9ajPR4aXUIFy/73+cAlL0CZk1e6puKeoUKZhmq
 slTb+pB4zjCHM6Fp0NDS33IASdvwRDS3h+XNPT8Gp6xvcPR6NddnSvi2xuvr97EH5S+2x3LGwMo
 CyBTOuJw0r0dTbCX+lfCpvB/IY4t+5Pxk9haizH1CgzTGnxquinjbcFqFYXzAAjft0hpPQ490Cr
 YGnjxE9hlmHCSghECZeY32OQO7vNVttX0St/Iz3JbmEW/yN61dZNwx/Gb0sCdKb9dToIHccX2iJ
 aMDqFr2acuCM48pGKddAplFRNe+fiexM9Fd6fkcGMbEJFdJLM55Yt8XteUBUiIJYvFNCcB93soJ
 E69m2bu8rafVCdvjjneEM=
X-Received: by 2002:a05:7300:7313:b0:2d8:b2e1:20cf with SMTP id
 5a478bee46e88-2d8b2e122fbmr9977190eec.10.1776339560578; 
 Thu, 16 Apr 2026 04:39:20 -0700 (PDT)
X-Received: by 2002:a05:7300:7313:b0:2d8:b2e1:20cf with SMTP id
 5a478bee46e88-2d8b2e122fbmr9977162eec.10.1776339559953; 
 Thu, 16 Apr 2026 04:39:19 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c10a65asm6845391eec.6.2026.04.16.04.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 04:39:19 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v5 11/16] target/hexagon: add v73 HVX IEEE bfloat16 insns
Date: Thu, 16 Apr 2026 04:39:00 -0700
Message-Id: <1a253373567781e0e141c34b41eaffad4789a493.1776339451.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1776339451.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1776339451.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rh4KWNM-Sralvu7FqobG5CB5uerhOsk3
X-Proofpoint-GUID: rh4KWNM-Sralvu7FqobG5CB5uerhOsk3
X-Authority-Analysis: v=2.4 cv=XOIAjwhE c=1 sm=1 tr=0 ts=69e0ca69 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=Gs5wSyFCHfQ05zcHo-UA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDExMCBTYWx0ZWRfX4kkIWMS8YgfS
 cy9BGFlNlOWE6QYolFwpRACeVMRrakf3gWZxFZ6hIC8Iexb7V9XkV97vCv6bllkRmpJY01iKDck
 6/CDgDXm2hKaaBhTqmUEk2R9wE/a4/y+35nK+QOd7kAC8BFRz7XmyNkEzW5PoOzbCcr3Ab5+6Wg
 Nvzu1+al6c7FpG7iXoIbaayjkR0MKGQ1dxmv4ZIIFCWNmbEVrdz3aJsp/G1k9O9bstPzpdUAddC
 yPzh2ohKfdzGauJnqTZmiuIIQidSzm4PujgS1mGaIpIo11kIjeN9NjTGs+5a4bQB8uv8I+UDm8B
 W/RvQpq5EdLT9mzyUmzo9fiM6Ji+470M9H2AczvAmJS+zP7nnGqVYJghTGSBMJnj6ysqRR4cvL6
 rw/Frv+O79633/xXZjZPGSwbnhY6aI9jjvcJByKhi7IUQwxLpfKzQKDeol+Cq70ZDkd1TnHKQ4f
 hPJa81b0g4P0ye0Z02w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160110
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

Add HVX IEEE bfloat16 (bf16) instructions:

Arithmetic operations:
- V6_vadd_sf_bf, V6_vsub_sf_bf: add/sub bf16 widening to sf output
- V6_vmpy_sf_bf: multiply bf16 widening to sf output
- V6_vmpy_sf_bf_acc: multiply-accumulate bf16 widening to sf output

Min/Max operations:
- V6_vmin_bf, V6_vmax_bf: bf16 min/max

Comparison operations:
- V6_vgtbf: greater-than compare
- V6_vgtbf_and, V6_vgtbf_or, V6_vgtbf_xor: predicate variants

Conversion operations:
- V6_vcvt_bf_sf: convert sf to bf16

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/mmvec/hvx_ieee_fp.h           | 37 ++++++++++++
 target/hexagon/mmvec/macros.h                |  4 ++
 target/hexagon/mmvec/mmvec.h                 |  1 +
 target/hexagon/imported/mmvec/encode_ext.def | 15 +++++
 target/hexagon/imported/mmvec/ext.idef       | 62 ++++++++++++++++++++
 5 files changed, 119 insertions(+)

diff --git a/target/hexagon/mmvec/hvx_ieee_fp.h b/target/hexagon/mmvec/hvx_ieee_fp.h
index 01728121eb..b7e379b089 100644
--- a/target/hexagon/mmvec/hvx_ieee_fp.h
+++ b/target/hexagon/mmvec/hvx_ieee_fp.h
@@ -9,8 +9,11 @@
 
 #include "fpu/softfloat.h"
 
+#define FP32_DEF_NAN 0x7FFFFFFF
+
 #define f16_to_f32(A) float16_to_float32((A), true, &env->hvx_fp_status)
 #define f32_to_f16(A) float32_to_float16((A), true, &env->hvx_fp_status)
+#define bf16_to_f32(A) bfloat16_to_float32(A, &env->hvx_fp_status)
 
 float32 fp_mult_sf_hf(float16 a1, float16 a2, float_status *fp_status);
 float32 fp_vdmpy(float16 a1, float16 a2, float16 a3, float16 a4,
@@ -29,4 +32,38 @@ int16_t conv_h_hf(float16 a, float_status *fp_status);
 uint32_t cmpgt_sf(float32 a1, float32 a2, float_status *fp_status);
 uint16_t cmpgt_hf(float16 a1, float16 a2, float_status *fp_status);
 
+/* IEEE BFloat instructions */
+
+#define fp_mult_sf_bf(A, B) \
+    float32_mul(bf16_to_f32(A), bf16_to_f32(B), &env->hvx_fp_status)
+
+#define fp_add_sf_bf(A, B) \
+    float32_add(bf16_to_f32(A), bf16_to_f32(B), &env->hvx_fp_status)
+
+#define fp_sub_sf_bf(A, B) \
+    float32_sub(bf16_to_f32(A), bf16_to_f32(B), &env->hvx_fp_status)
+
+#define fp_mult_sf_bf_acc(f1, f2, f3) \
+    float32_muladd(bf16_to_f32(f1), bf16_to_f32(f2), f3, 0, &env->hvx_fp_status)
+
+static inline bfloat16 f32_to_bf16(float32 A, float_status *fp_status)
+{
+    uint32_t rslt = A;
+    if ((rslt & 0x1FFFF) == 0x08000) {
+        /* do not round up if exactly .5 and even already */
+    } else if ((rslt & 0x8000) == 0x8000) {
+        rslt += 0x8000; /* rounding to nearest number */
+    }
+    rslt = float32_is_any_nan(A) ? FP32_DEF_NAN : rslt;
+    return float32_to_bfloat16(rslt, fp_status);
+}
+
+#define fp_min_bf(A, B) \
+    f32_to_bf16(float32_min(bf16_to_f32(A), bf16_to_f32(B), &env->hvx_fp_status), \
+             &env->hvx_fp_status);
+
+#define fp_max_bf(A, B) \
+    f32_to_bf16(float32_max(bf16_to_f32(A), bf16_to_f32(B), &env->hvx_fp_status), \
+             &env->hvx_fp_status);
+
 #endif
diff --git a/target/hexagon/mmvec/macros.h b/target/hexagon/mmvec/macros.h
index 318d44efb7..4945a61194 100644
--- a/target/hexagon/mmvec/macros.h
+++ b/target/hexagon/mmvec/macros.h
@@ -25,6 +25,9 @@
 #include "accel/tcg/probe.h"
 #include "mmvec/hvx_ieee_fp.h"
 
+#define fBFLOAT()
+#define fCVI_VX_NO_TMP_LD()
+
 #ifndef QEMU_GENERATE
 #define VdV      (*(MMVector *restrict)(VdV_void))
 #define VsV      (*(MMVector *restrict)(VsV_void))
@@ -358,5 +361,6 @@
 
 #define fCMPGT_SF(A, B) cmpgt_sf(A, B, &env->hvx_fp_status)
 #define fCMPGT_HF(A, B) cmpgt_hf(A, B, &env->hvx_fp_status)
+#define fCMPGT_BF(A, B) fCMPGT_SF((uint32_t)(A) << 16, (uint32_t)(B) << 16)
 
 #endif
diff --git a/target/hexagon/mmvec/mmvec.h b/target/hexagon/mmvec/mmvec.h
index 31909303b5..ab991471b1 100644
--- a/target/hexagon/mmvec/mmvec.h
+++ b/target/hexagon/mmvec/mmvec.h
@@ -40,6 +40,7 @@ typedef union {
     int8_t    b[MAX_VEC_SIZE_BYTES / 1];
     float32  sf[MAX_VEC_SIZE_BYTES / 4];
     float16  hf[MAX_VEC_SIZE_BYTES / 2];
+    bfloat16 bf[MAX_VEC_SIZE_BYTES / 2];
 } MMVector;
 
 typedef union {
diff --git a/target/hexagon/imported/mmvec/encode_ext.def b/target/hexagon/imported/mmvec/encode_ext.def
index 3572e4de4c..16f043b77d 100644
--- a/target/hexagon/imported/mmvec/encode_ext.def
+++ b/target/hexagon/imported/mmvec/encode_ext.def
@@ -868,4 +868,19 @@ DEF_ENC(V6_vgthf_or,"00011100100vvvvvPP1uuuuu001101xx")
 DEF_ENC(V6_vgtsf_xor,"00011100100vvvvvPP1uuuuu111010xx")
 DEF_ENC(V6_vgthf_xor,"00011100100vvvvvPP1uuuuu111011xx")
 
+/* BFLOAT instructions */
+DEF_ENC(V6_vmpy_sf_bf,"00011101010vvvvvPP1uuuuu100ddddd")
+DEF_ENC(V6_vmpy_sf_bf_acc,"00011101000vvvvvPP1uuuuu000xxxxx")
+DEF_ENC(V6_vadd_sf_bf,"00011101010vvvvvPP1uuuuu110ddddd")
+DEF_ENC(V6_vsub_sf_bf,"00011101010vvvvvPP1uuuuu101ddddd")
+DEF_ENC(V6_vmax_bf,"00011101010vvvvvPP1uuuuu111ddddd")
+DEF_ENC(V6_vmin_bf,"00011101010vvvvvPP1uuuuu000ddddd")
+DEF_ENC(V6_vcvt_bf_sf,"00011101010vvvvvPP1uuuuu011ddddd")
+
+/* BFLOAT compare instructions */
+DEF_ENC(V6_vgtbf,"00011100100vvvvvPP1uuuuu011110dd")
+DEF_ENC(V6_vgtbf_and,"00011100100vvvvvPP1uuuuu110100xx")
+DEF_ENC(V6_vgtbf_or,"00011100100vvvvvPP1uuuuu001110xx")
+DEF_ENC(V6_vgtbf_xor,"00011100100vvvvvPP1uuuuu111100xx")
+
 #endif /* NO MMVEC */
diff --git a/target/hexagon/imported/mmvec/ext.idef b/target/hexagon/imported/mmvec/ext.idef
index a7043d598c..857aa6133f 100644
--- a/target/hexagon/imported/mmvec/ext.idef
+++ b/target/hexagon/imported/mmvec/ext.idef
@@ -3163,6 +3163,15 @@ ITERATOR_INSN_SHIFT_SLOT_FLT(16, vconv_hf_h,"Vd32.hf=Vu32.h",
     } \
 }
 
+#define VCMPGT_BF(DEST, ASRC, ASRCOP, CMP, N, SRC, MASK, WIDTH) \
+{ \
+    fBFLOAT(); \
+    for (fHIDE(int) i = 0; i < fVBYTES(); i += WIDTH) { \
+        fHIDE(int) VAL = fCMPGT_BF(VuV.SRC[i/WIDTH],VvV.SRC[i/WIDTH]) ? MASK : 0; \
+        fSETQBITS(DEST,WIDTH,MASK,i,ASRC ASRCOP VAL); \
+    } \
+}
+
 /* Vector SF compare */
 #define MMVEC_CMPGT_SF(TYPE,TYPE2,DESCR,N,MASK,WIDTH,SRC) \
     EXTINSN(V6_vgt##TYPE##_and, "Qx4&=vcmp.gt(Vu32." TYPE2 ",Vv32." TYPE2 ")", \
@@ -3201,8 +3210,61 @@ ITERATOR_INSN_SHIFT_SLOT_FLT(16, vconv_hf_h,"Vd32.hf=Vu32.h",
         DESCR" greater than", \
         VCMPGT_HF(QdV, , , ">", N, SRC, MASK, WIDTH))
 
+/* Vector BF compare */
+#define MMVEC_CMPGT_BF(TYPE,TYPE2,DESCR,N,MASK,WIDTH,SRC) \
+    EXTINSN(V6_vgt##TYPE##_and, "Qx4&=vcmp.gt(Vu32." TYPE2 ",Vv32." TYPE2 ")",\
+        ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT), \
+        DESCR" greater than with predicate-and", \
+        VCMPGT_BF(QxV, fGETQBITS(QxV,WIDTH,MASK,i), &, ">", N, SRC, MASK, WIDTH)) \
+    EXTINSN(V6_vgt##TYPE##_xor, "Qx4^=vcmp.gt(Vu32." TYPE2 ",Vv32." TYPE2 ")", \
+        ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT), \
+        DESCR" greater than with predicate-xor", \
+        VCMPGT_BF(QxV, fGETQBITS(QxV,WIDTH,MASK,i), ^, ">", N, SRC, MASK, WIDTH)) \
+    EXTINSN(V6_vgt##TYPE##_or, "Qx4|=vcmp.gt(Vu32." TYPE2 ",Vv32." TYPE2 ")", \
+        ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT), \
+        DESCR" greater than with predicate-or", \
+        VCMPGT_BF(QxV, fGETQBITS(QxV,WIDTH,MASK,i), |, ">", N, SRC, MASK, WIDTH)) \
+    EXTINSN(V6_vgt##TYPE, "Qd4=vcmp.gt(Vu32." TYPE2 ",Vv32." TYPE2 ")", \
+        ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT), \
+        DESCR" greater than", \
+        VCMPGT_BF(QdV, , , ">", N, SRC, MASK, WIDTH))
+
 MMVEC_CMPGT_SF(sf,"sf","Vector sf Compare ", fVELEM(32), 0xF, 4, sf)
 MMVEC_CMPGT_HF(hf,"hf","Vector hf Compare ", fVELEM(16), 0x3, 2, hf)
+MMVEC_CMPGT_BF(bf,"bf","Vector bf Compare ", fVELEM(16), 0x3, 2, bf)
+
+/******************************************************************************
+ BFloat arithmetic and max/min instructions
+ ******************************************************************************/
+
+ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vadd_sf_bf,
+    "Vdd32.sf=vadd(Vu32.bf,Vv32.bf)",  "Vector IEEE add: bf widen to sf",
+    VddV.v[0].sf[i] = fp_add_sf_bf(VuV.bf[2*i], VvV.bf[2*i]);
+    VddV.v[1].sf[i] = fp_add_sf_bf(VuV.bf[2*i+1], VvV.bf[2*i+1]); fBFLOAT())
+ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vsub_sf_bf,
+    "Vdd32.sf=vsub(Vu32.bf,Vv32.bf)",  "Vector IEEE sub: bf widen to sf",
+    VddV.v[0].sf[i] = fp_sub_sf_bf(VuV.bf[2*i], VvV.bf[2*i]);
+    VddV.v[1].sf[i] = fp_sub_sf_bf(VuV.bf[2*i+1], VvV.bf[2*i+1]); fBFLOAT())
+ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vmpy_sf_bf,
+    "Vdd32.sf=vmpy(Vu32.bf,Vv32.bf)",  "Vector IEEE mul: hf widen to sf",
+    VddV.v[0].sf[i] = fp_mult_sf_bf(VuV.bf[2*i], VvV.bf[2*i]);
+    VddV.v[1].sf[i] = fp_mult_sf_bf(VuV.bf[2*i+1], VvV.bf[2*i+1]); fBFLOAT())
+ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vmpy_sf_bf_acc,
+    "Vxx32.sf+=vmpy(Vu32.bf,Vv32.bf)", "Vector IEEE fma: hf widen to sf",
+    VxxV.v[0].sf[i] = fp_mult_sf_bf_acc(VuV.bf[2*i], VvV.bf[2*i], VxxV.v[0].sf[i]);
+    VxxV.v[1].sf[i] = fp_mult_sf_bf_acc(VuV.bf[2*i+1], VvV.bf[2*i+1], VxxV.v[1].sf[i]);
+    fCVI_VX_NO_TMP_LD(); fBFLOAT())
+ITERATOR_INSN_IEEE_FP_16(32, vcvt_bf_sf,
+    "Vd32.bf=vcvt(Vu32.sf,Vv32.sf)",   "Vector IEEE cvt: sf to bf",
+    VdV.bf[2*i]   = f32_to_bf16(VuV.sf[i], &env->hvx_fp_status);
+    VdV.bf[2*i+1] = f32_to_bf16(VvV.sf[i], &env->hvx_fp_status); fBFLOAT())
+
+ITERATOR_INSN_IEEE_FP_16_32_LATE(16, vmax_bf, "Vd32.bf=vmax(Vu32.bf,Vv32.bf)",
+    "Vector IEEE max: bf", VdV.bf[i] = fp_max_bf(VuV.bf[i], VvV.bf[i]);
+    fBFLOAT())
+ITERATOR_INSN_IEEE_FP_16_32_LATE(16, vmin_bf, "Vd32.bf=vmin(Vu32.bf,Vv32.bf)",
+    "Vector IEEE min: bf", VdV.bf[i] = fp_min_bf(VuV.bf[i], VvV.bf[i]);
+    fBFLOAT())
 
 /******************************************************************************
  DEBUG Vector/Register Printing
-- 
2.37.2


