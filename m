Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6806BF45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 17:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBG65-0006uS-SI; Fri, 10 Apr 2026 13:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wBG5y-0006u0-66
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 13:56:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wBG5v-0001ft-UW
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 13:56:41 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63AB13LJ438888
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 17:56:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=GGG/Zp81i+Z
 5zJgP834y0mXGrz5J69B+j8Rbi2MoPwg=; b=CQE/Nzt0hwSgJ7FulVAuYlcz7I1
 P3tKthbLd+hYwzWe6gX/X86hgtEW9XD5XIH1Wb8Zv4aNcHeVWmLqwfEI5h2rgFON
 AKcGyJpnjXsyIEsy9wUk66094VthEfgjHseAFzeNb4t/90SXVi/wke4CR2zaJI1D
 aJTAWhKUlBTNuES+PlYMlnbezSUxhK+pPVjjc/Nxyjtt4MFEVnOTDoyobopz6Yv6
 Dp6pK8/I4Hs/8x/hKJBf+aiDmu/Ff9pIQKX9Vhbjbc53nEPBoR0z46JdF9Xc6eVE
 9ZpNrlzxfed7soj3sljWK2q+92ycNNsEN3+Jj2DWIwuJvCzCtotrzTro0SA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deyy9s9uq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 17:56:20 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1275c6fc58aso2785951c88.0
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 10:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775843780; x=1776448580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GGG/Zp81i+Z5zJgP834y0mXGrz5J69B+j8Rbi2MoPwg=;
 b=OqZljLh0cLrWyD3EPtPgZAm8n0/KTltmxy0Qr7zFcph2TPET+doxA9+CRNMfzgcYQ6
 E9Wyz20cpSZh73XFeUO6DBPVmMuuS1hNW1FZvGMVliz/LrPC8U77rOPpNQ2xrfYRyd2s
 A6HarKTgZS02k7NKqKlWbPEpJxevzipEHdU887/xD11GiafAtNWrPQuJQhYbstT/FtPw
 J5yYZzcbuXcRDHQrQWn0ENI8rc13/o8djTbzLMxsxk0tUgQRgxKAQE+NuYxkRgoPdm7R
 T0lQEoyeiaVe1Ye0mtUO0ZoK2+HB3s/SBzDlSeuPMj4eS+guVp8p18RBaxDrgP7MCn/E
 KaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775843780; x=1776448580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GGG/Zp81i+Z5zJgP834y0mXGrz5J69B+j8Rbi2MoPwg=;
 b=CuFI1aMeGHditRVq/AL5m3AXRtytbR+vZYg+SGxv74hKlU7wyZLyGXRGwMsHFhg/TU
 KWgDe6fkLlVgIritRjmdRZoxCqLfsxhXDEPuju88jjCcHw3+2yBaS7H/XH7OZsncPfcF
 gnjw4O8aAIhQy8AX4OVlzpJSEYEhY1fwnADSlJpuYhzkP3eqNgw2Uz5/AID2wNWqKV1I
 RjxVr2o57crU5ONJqCMh0H665wUIS9Bf8B563f8EUF4poMgXiOJXAbMt2BxByq2lH8p8
 tgYzsGBv28I0FBHhideFakQT8l2+092fRNe105mVZktVkPed+7COdG8C2WmAsbAD1/ZF
 xjaw==
X-Gm-Message-State: AOJu0YyHcNfGVYO3yItpx4g0ovQXU8BgIIhvG8hVzrAhhwElL6ap+EKo
 dz2W4grm5BgH7VtZyU4Pd7Wl93wbGIZlur9NWzF4flrdOdO1OVlRTbdpwFScXqCEEqH12NmnB/C
 6apqT+mWaVx/hlMOgSes2c0VJIlq4tpKNFAgcjRVJFlHCXxVKuzQ8ECtAPJzo3371ZvHb
X-Gm-Gg: AeBDiesqB4LjvsBdYXsRZ31TXZF2RP3R+vaD8a8c5TLG9VVKSM7Lsi2KYfPy2oergSD
 Gsdk7naS8quU+scxcgDaD9OtDwMKUO1I/OCUNd4YZzHRyGxCDmxTgwBbVzSPkWHqoKgw/rqxFSs
 VXBNx55yb4+yL4kcvdL3PALDJe0Iw009YMy25Lfn/uu0wSPjQxd4BF+597ed22XYNVzks0qIG1D
 +NxiRVoS2yc1xTYTa8aLaALXq/tZKN5e2S64gAfW1kffnBkUSNxiL0hye9pZZdIW5zqK1n6DPth
 CtabD4sIyyPC1LiLMGb4cw2MPZ61HvD72pvyoSsCliLiBjLphmLh7Rl0Se8cjf/6mq+7WX2V+wq
 /LqkGyvmxRSINTqWzzJlnXwsAm/r8mFWp+xWqGB6rJD/eretVp+r0TwC7dDagT+7P87uIkGZM18
 izhzllvs1K
X-Received: by 2002:a05:7022:439f:b0:128:d715:b717 with SMTP id
 a92af1059eb24-12c34e92e3emr2185479c88.13.1775843779479; 
 Fri, 10 Apr 2026 10:56:19 -0700 (PDT)
X-Received: by 2002:a05:7022:439f:b0:128:d715:b717 with SMTP id
 a92af1059eb24-12c34e92e3emr2185454c88.13.1775843778626; 
 Fri, 10 Apr 2026 10:56:18 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c3459f7ffsm4256271c88.3.2026.04.10.10.56.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 10:56:18 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v4 11/16] target/hexagon: add v73 HVX IEEE bfloat16 insns
Date: Fri, 10 Apr 2026 10:55:59 -0700
Message-Id: <d408ee2b2c7004e7241aa2beaa136c2f28c73985.1775843299.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775843299.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775843299.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDE2OCBTYWx0ZWRfXxTsHZSRagRO+
 Mhl/gbGyCMovlesPRH6TUF0+WVjvdmqGYWFqp/8Mj1bUXGr4RO+CFIReuguUKWowc6Ox0Yt8msI
 MDtMxpliMqy+tA4+960L8mmrQTPIOfyBvQ9JBSk28QJsAHeFGl+MRUrU6pJP3mnHvEGEL0oMaHe
 XYmw/pHqgrFlWXNq/8CW99F4CJFiqkn6M+BFLbffCAc5uAags4ApAR3BcFpz+YOmWTMYuag6b8V
 JkkMInP3QEU9ft2ydQSgjzP17qAlhalFAR4aHDzHxywBABzFDeMOnwKZ7wwFzQkW0DcY76MHLQd
 LRtiPHCHFu/rjRPww6NaIlCEDwFbsk8RsUs3/bJOHcpHCrAhPZMwP3EjbXuMmczWEZkR7UEOAuZ
 UgwJS71fiZbV/d6IbwXC8Tl5eAf5bqCOfwJueoK5tItDkMPdeOcIsY5Ut5OpBPwhY9Ja4ssJ+tI
 QB4t5G0lYrY9XorSf/g==
X-Proofpoint-GUID: hE7iTOAI3E5uZBil41gGnUxFC5A0DbeW
X-Authority-Analysis: v=2.4 cv=d6fFDxjE c=1 sm=1 tr=0 ts=69d939c4 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=Gs5wSyFCHfQ05zcHo-UA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: hE7iTOAI3E5uZBil41gGnUxFC5A0DbeW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 priorityscore=1501
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
index a7043d598c..44135a8eea 100644
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
+    "Vector IEEE max: bf", VdV.bf[i] = fp_min_bf(VuV.bf[i], VvV.bf[i]);
+    fBFLOAT())
 
 /******************************************************************************
  DEBUG Vector/Register Printing
-- 
2.37.2


