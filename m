Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A465410F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYVw-0005Rl-QM; Wed, 08 Apr 2026 15:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wAY5t-0006v6-TB
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:57:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wAVu8-0006po-0S
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 12:37:25 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638B5CA21314466
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 16:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Ceyrp3bDWeS
 2CmxzLTgZ2UxaZhVIRbI80CTNO5AByP8=; b=WaWdudGHtvBJw+pbrs4Hi/H4vDY
 WBUUNZrq6R+Fb7w5RnC2fJMQARAQCMW+LwXS62rx8y5QytXGfuZhVRYYuJ84X5cF
 bVtuhM+QOk4qojhEcILwvIlJWX8A9FVjdJZot6b1lWEchFHdcjWsYcDFgcQe7j1X
 ipjYBJGZAcel8Ao33wOrNZ1+DpINkSfOJAbd8Dh8ZmQPKqRkacmQbslkn4ZiT5qC
 MPTU8HKJQYtaiUH+44UaxzoTP9X/MALiBqjG7VvSpXUIxQXC3DAtHm4UPmNLcN+0
 cyddv96FipU8V3DebG+O0srdRFybgX94jK0o3AGozeknrR0fBhadqxBBf0w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd8d6m40e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 16:37:22 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c70ea91bfe1so36482a12.1
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 09:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775666242; x=1776271042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ceyrp3bDWeS2CmxzLTgZ2UxaZhVIRbI80CTNO5AByP8=;
 b=Uq+EaSRHPafozQv5GJ/s/ankSPC02W49CDK4c8/9iXbZv3PBbJi2OGsr4zCey9O0o+
 NWxF5+A9vuRrMO50A/e2jFOwNzhic9+Zm9rUDL9RxswqQ+XrvX2kzyw25ycf5es1HfCH
 p5rU0/QRrwmOSdMnv7dZPwhFXbQFLlG+JARR1xTmrzwa/2HiG+U78OtA6TN5FekS8UvM
 p01orc7DlR/sOJYswrhhPASWF6yDaijN9WCT0+13zze+FpcZKGm1Qaiz/nPRzNEZndQJ
 Bi+qKKv/tN/cHVcRA4W2Ls/F39WtwidNK0iguwTrBMIHmllI/nDdye/TSTjKwiQYGGFR
 s1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775666242; x=1776271042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ceyrp3bDWeS2CmxzLTgZ2UxaZhVIRbI80CTNO5AByP8=;
 b=iJd5KF6mbBUucGghsz9T4MoJLW1Ue+zBfWitpR5TY36+iUMPawyZ+56bi1/NvgJcj1
 7v0F7sbd+BulNnlzXeZ6pHvMz3s4rWI+/33nxcxrh3jdtsiulBYlMkLiK6Q+HCpTXlRs
 UdDCw4dUIz6WDqCop63ljUFRGAQJqr2+M+EJwc0O1ZJkWwu03O+AGdJ43fTU3JKKvGKy
 okVPxvgnYBMj1J0wDJIN17rr214fwVIAnePqVi1EFGSE+Uo2xLO7UZy+HOw+ZAIUoF8I
 QYL5Ryz8+lmR2ANDZAOlG1/a6svN3VfBpIBaz1wGpPuStl8z7TluN1Oh17Bi5V9wnfvf
 mnXA==
X-Gm-Message-State: AOJu0YzOh/FJabxho6NObXJcAC59ojNp87gsbAbF4Bn8AxuvMuh4oZR9
 T+AwTcEdnvSBNKHIj7CzopI2EC2MYLckO8zmJ7S5fiA1H0GyY+NDieHShMyHEg5r6Ivz7Sp384M
 X5RVKLt8XyTE4yOdzcbs1wWab4yziQaRcLV2+z2GsHI88geS/uQzDJfOLt8CTRXN+e5Pp
X-Gm-Gg: AeBDiesm+XkiLbiC4TfRQwg5/0sLyvyxyddEvvjqH1T9/ljZuUH9TX/nEHb787M160/
 ivxW/H92scy0mH6wTMfj8jo6UAPE83/VToYT5hoykmNIwRpwksUAWAcKn3yzsLnI0iW9vaDLlyA
 pfh4bQRVsSc7bRGIXT7rFgoUDIANKn1ZDajQEymWf7umg7EM8Vk5OYrd4I/DPUMAUuvyULAHPFT
 9dMqXyXgBcxHZf03PTle6gSKCvps5UfMt3HYu81wmXPxPRHgw2p9wwE6DxoS4k9/0SHGWcbtw/p
 DWEKbXkOZVEVsxgZ2U/+ieJBV8KuP3pWXUcuRgMOemu0ELKAIAeN1zLsjfCwnomiL0pe7SRIwjU
 iENBk3A16fyAYFUfIj6lxSbOHPXk+844dexzTqduGLNstcBn12SEZO4oSdGAMQmL1MlQ0GQdTOt
 imlPc0ZXxg
X-Received: by 2002:a05:7022:b98:b0:128:df80:1852 with SMTP id
 a92af1059eb24-12bfb6fe54fmr10695337c88.9.1775666241528; 
 Wed, 08 Apr 2026 09:37:21 -0700 (PDT)
X-Received: by 2002:a05:7022:b98:b0:128:df80:1852 with SMTP id
 a92af1059eb24-12bfb6fe54fmr10695315c88.9.1775666240715; 
 Wed, 08 Apr 2026 09:37:20 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c1ff43d04sm4082006c88.4.2026.04.08.09.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:37:20 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v3 11/16] target/hexagon: add v73 HVX IEEE bfloat16 insns
Date: Wed,  8 Apr 2026 09:37:02 -0700
Message-Id: <f84d180547f96f809684e858861086dc6dab9ed8.1775665981.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: mjIjDg18J1Y1UMIY_XHCPrhzi6MWLS7B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE1NCBTYWx0ZWRfX3rfCehR3JT8m
 XPK/4LL9GX2I9bmLWHvCx6Fd230BiSpW7KEKjiWmOPwLRsqktgnzyvcOP8qDfqwiNmxgA9J6ukz
 YG+K8BF9i7x8XtKVwF4cwlm7+mzw1f7KzVxC471cC60NHu5qe5qGALZs0FEosUzKaqULvbqP9Rz
 KFT72LVQhcskkNwOl5DdvxK+iQ8uy0vFBlFjL4YldJE5n4XbKkATwUl4B/jo5+zdasPxcz2lWQJ
 ZhVkLLau9DPdr0oRpkzBuVcokW6Tx8xLMUNb6L2//tX8MybLNunEOV6msG1YGy4vLiKbfRIupgL
 yGSXoXDD2BgV3kr/0mZXZzW7WXPqmAz3fevJdVGunqkDBAiwU8vkMYvQkGEfS0CYKldwGZN3nHx
 dhiGoxmKGaUzwINekhhflst09NEoKVXkkvm1xAD+mAIBcV47GAl+u5ioh15E6zr8CykBJkAyaTp
 +gCnJBk2nIknd0SAcGg==
X-Authority-Analysis: v=2.4 cv=GN041ONK c=1 sm=1 tr=0 ts=69d68442 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=onv092Jz13JiHwvUDIoA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: mjIjDg18J1Y1UMIY_XHCPrhzi6MWLS7B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080154
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

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/mmvec/hvx_ieee_fp.h           | 37 ++++++++++++
 target/hexagon/mmvec/macros.h                |  4 ++
 target/hexagon/mmvec/mmvec.h                 |  1 +
 target/hexagon/imported/mmvec/encode_ext.def | 15 +++++
 target/hexagon/imported/mmvec/ext.idef       | 62 ++++++++++++++++++++
 5 files changed, 119 insertions(+)

diff --git a/target/hexagon/mmvec/hvx_ieee_fp.h b/target/hexagon/mmvec/hvx_ieee_fp.h
index ad854b905d..21883c0fad 100644
--- a/target/hexagon/mmvec/hvx_ieee_fp.h
+++ b/target/hexagon/mmvec/hvx_ieee_fp.h
@@ -9,8 +9,11 @@
 
 #include "fpu/softfloat.h"
 
+#define FP32_DEF_NAN 0x7FFFFFFF
+
 #define f16_to_f32(A) float16_to_float32((A), true, &env->hvx_fp_status)
 #define f32_to_f16(A) float32_to_float16((A), true, &env->hvx_fp_status)
+#define bf_to_sf(A) bfloat16_to_float32(A, &env->hvx_fp_status)
 
 float32 fp_mult_sf_hf(float16 a1, float16 a2, float_status *fp_status);
 float32 fp_vdmpy(float16 a1, float16 a2, float16 a3, float16 a4,
@@ -29,4 +32,38 @@ int16_t conv_h_hf(float16 a, float_status *fp_status);
 uint32_t cmpgt_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
 uint16_t cmpgt_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
 
+/* IEEE BFloat instructions */
+
+#define fp_mult_sf_bf(A, B) \
+    float32_mul(bf_to_sf(A), bf_to_sf(B), &env->hvx_fp_status)
+
+#define fp_add_sf_bf(A, B) \
+    float32_add(bf_to_sf(A), bf_to_sf(B), &env->hvx_fp_status)
+
+#define fp_sub_sf_bf(A, B) \
+    float32_sub(bf_to_sf(A), bf_to_sf(B), &env->hvx_fp_status)
+
+#define fp_mult_sf_bf_acc(f1, f2, f3) \
+    float32_muladd(bf_to_sf(f1), bf_to_sf(f2), f3, 0, &env->hvx_fp_status)
+
+static inline uint16_t sf_to_bf(int32_t A, float_status *fp_status)
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
+    sf_to_bf(float32_min(bf_to_sf(A), bf_to_sf(B), &env->hvx_fp_status), \
+             &env->hvx_fp_status);
+
+#define fp_max_bf(A, B) \
+    sf_to_bf(float32_max(bf_to_sf(A), bf_to_sf(B), &env->hvx_fp_status), \
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
index b10c5f3240..a762d7ca0d 100644
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
+    VdV.bf[2*i]   = sf_to_bf(VuV.sf[i], &env->hvx_fp_status);
+    VdV.bf[2*i+1] = sf_to_bf(VvV.sf[i], &env->hvx_fp_status); fBFLOAT())
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


