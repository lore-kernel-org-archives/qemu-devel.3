Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7438F8A15F
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 11:41:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDL4N-0005Ci-AC; Thu, 16 Apr 2026 07:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wDL47-000572-Ry
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:39:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wDL45-0003BG-Eh
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:39:23 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G8WVPb3089108
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:39:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ZzpX2dtmew8
 OnfEXBDiB07/5iswcyFDy+0j5bknVIDY=; b=R7EabLm5Pjn7zH+jVLIZBkPvpAG
 yHjmUGlPVHssQGRSP826skmQ3tZrHhqkqfM9C+HABBEpZHTQhenfhjmwAKgD7QGb
 pIE5XRFRCHZfBgMM6Qhujr2GilUqgv3SbHs9afU2M2tHBa2qtg0a7nMHllcSi6zT
 Dgn4K65HiogMLbrI+7ChP2puQf56e7fkdqg3e9Ho0dQL51Is3gugqnhlHBod02vC
 10EVPykjdPV9opOJV7EZued256ncSZkQKSmrU2s3bUuLoJyC0tzrZ4enyBKx8jOL
 Q9BMvNBvUzdufepFnAarmQSxi2WlDDyW1qX3gHTzM/7hN2k8xRIDbDgRifA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djp6a9xs1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:39:19 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2bda35eab74so506848eec.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 04:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776339559; x=1776944359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZzpX2dtmew8OnfEXBDiB07/5iswcyFDy+0j5bknVIDY=;
 b=H30AOP/wyvjYx3ly6jjkAeFnbdAVYdOTw9BnYfGnUa1zcGRHOQN7I3A3f5/Ic4c5IK
 gIhOyGyjNBpnWD5sQwg4G8BEuPo2UMeRHkBT9qmudKmamfc+5hVJLDI+WFnwigiG3Z6t
 qIcGUkNlJhvxqVi19lY2g8HC6awtSZJ227I+Qd9nIieq8+yaURy9JV2hpvuf2krWPSbq
 uoXFuApNMh+jk7xMzPDJ6d6AAg2asQMU01Rxyxkl+6JJjnXKyexOb3SWuQErzb/9Rcaq
 UESY7p/5jcVGVM3w/Zav1chPR4gCHgjdywMd+Ms8gGVoEUrXl6EXq/bT9y8+/J0CTGNM
 QBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776339559; x=1776944359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZzpX2dtmew8OnfEXBDiB07/5iswcyFDy+0j5bknVIDY=;
 b=KbxQrX3Fx74Va2NAMAhB0NcPAIHNU/VZs7kjdMxXKrdJktquMA9UbnF6XfUgP1TMjI
 wojmwErHMjRk0EBY5g3qLaPHYsRReTvUr++GerTHFm8lBxBrGbKPCTiS8xozuPxaJYOJ
 2woWYdke7YAlU977CJuthAjZMjJ9Pk/3p+TZcjwyhfF8SIZSvB/R1DXM5lDmi5Knn6vi
 fOGsJIkdqi8LEe9UOEar4pssPcTlsspyLUzlcLe5eIwmENrp5VbEtROXujKUc0uzhlY5
 F4tGKgBUlHWKPEFoNZSQn2+Jz/p+4T4FQpRdw4usVz+0pK+rPkcMNH0YBWndDnzuVmNl
 QYfw==
X-Gm-Message-State: AOJu0YwQVAIyf7Uyydg7fQDugxXD+QcMUpJwnHd3EUharVSlCXkbq/1S
 NjMFZIaIZBy4CQtyoaPDqhdTOzb2WY7RDjCrVqiDL07sQC9Nd6GF20YLQAitTpo8xxia2S3eP0m
 rpfCcJQiLjQ4SyeDpv3tThBLHo0INgRQsYpbjVbSpCsPkLxxDsJBB2o0TwN7psSaOdqNw
X-Gm-Gg: AeBDievalvieGooyKhP2OUiw8J5ltuIQEpiSa6yGeaJnBy/wEASPiPTkHHeSi9+mdb+
 ySoAH0bhtv2onqUXq+n749vZUuUMRSHtlbdEtYGQt1oAe8gMvSHpyiGids6ZXwcM+FQrHjxU+0v
 pJOVfiYie9jSCrTawiXrBd4mjwlAgnGHQUPSRJPVak0aPlD41Oml3bzVKLCJCxTygV83hMfaqJ2
 IkjE6oekWbQV4O6cIft2MVKMpKPd1vX6nOIdcVMajCYkQ0q88KvSp+cUX8Iv92IhuBq/jQkbwVu
 tFxRoRLDkiMe6A5EgMQqbtYWfQnadt5wNoJAmUM+yLdEm7gw4xTNeYmFVXFM3aZUNRjzrktSSQP
 Ap1aQpdTrLt6+88pL/L7Q7M4ueuo7a64ygR+UWuyv2jrcbxGgsja/lQZqKsn+2yXfv3Zup9eO3z
 LY56fT33CkQ2kXDZ6Ofjk=
X-Received: by 2002:a05:7300:ed03:b0:2d9:1c9d:fc22 with SMTP id
 5a478bee46e88-2df7f947fbemr1621883eec.21.1776339558817; 
 Thu, 16 Apr 2026 04:39:18 -0700 (PDT)
X-Received: by 2002:a05:7300:ed03:b0:2d9:1c9d:fc22 with SMTP id
 5a478bee46e88-2df7f947fbemr1621853eec.21.1776339558169; 
 Thu, 16 Apr 2026 04:39:18 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c10a65asm6845391eec.6.2026.04.16.04.39.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 04:39:17 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v5 09/16] target/hexagon: add v68 HVX IEEE float conversion
 insns
Date: Thu, 16 Apr 2026 04:38:58 -0700
Message-Id: <beca620d2e5e0bc15886bf967ab3961a49eca5f7.1776339451.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1776339451.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1776339451.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ds2pkqBWbCMsgA898ef876-G8Dgckijo
X-Authority-Analysis: v=2.4 cv=NuvhtcdJ c=1 sm=1 tr=0 ts=69e0ca67 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=2JvGeOnW2cDEA-NDw-QA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: ds2pkqBWbCMsgA898ef876-G8Dgckijo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDExMCBTYWx0ZWRfX9tLysj9ZgPaw
 Lh0p3SVkzMA7KlLzheD29Z0PU0ENeqQrGxo5aaIBArxAjjKCqPCR0dEfBcxLNbjlxDPX/QL+LJu
 L1ULNW6bI192GqneKMTeGFnztglEt7xPUgKzlxPIIJdCV4BPtjN57a/VchsE8wW2T3bLqj8e/xP
 cEuuoXn7Qeh/qON7gU44HQPrhov/9XdhIFd3tYlsztSeaNfBtgnc9yYXrZNulwGwkxuPVI+etoY
 urB06wQXNrY0wPxPNeXlhdxRzjRYqvdsK7WbxwZ59lYMj2r1Mj5A/9vjlVBa808PNBSNl9zCojg
 rQymVIf2/OY0QGMzOK1Ytf+1U0dE1GeJiYr7wD+zJ5hG5s7k98U8Y4qFS2BiFtWqry63jqNOj7w
 GkcgzW2PdvOgGLbSVWXIbcQISTQjCUwrWxwJqFT1VAEkGFCygDkBWf7RtxvXgNgJeFnDvwUgUif
 hhNcorf/IoRj+HbtJBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
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

Add HVX IEEE floating-point conversion instructions:
- vconv_hf_h, vconv_h_hf, vconv_sf_w, vconv_w_sf: vconv operations
- vcvt_hf_sf, vcvt_sf_hf: float <-> half float conversions
- vcvt_hf_b, vcvt_hf_h, vcvt_hf_ub, vcvt_hf_uh: int to half float
- vcvt_b_hf, vcvt_h_hf, vcvt_ub_hf, vcvt_uh_hf: half float to int

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/mmvec/hvx_ieee_fp.h           |  4 +
 target/hexagon/mmvec/hvx_ieee_fp.c           | 18 ++++
 target/hexagon/imported/mmvec/encode_ext.def | 18 ++++
 target/hexagon/imported/mmvec/ext.idef       | 97 ++++++++++++++++++++
 4 files changed, 137 insertions(+)

diff --git a/target/hexagon/mmvec/hvx_ieee_fp.h b/target/hexagon/mmvec/hvx_ieee_fp.h
index dff2fab14c..bdc21e08f0 100644
--- a/target/hexagon/mmvec/hvx_ieee_fp.h
+++ b/target/hexagon/mmvec/hvx_ieee_fp.h
@@ -10,6 +10,7 @@
 #include "fpu/softfloat.h"
 
 #define f16_to_f32(A) float16_to_float32((A), true, &env->hvx_fp_status)
+#define f32_to_f16(A) float32_to_float16((A), true, &env->hvx_fp_status)
 
 float32 fp_mult_sf_hf(float16 a1, float16 a2, float_status *fp_status);
 float32 fp_vdmpy(float16 a1, float16 a2, float16 a3, float16 a4,
@@ -21,4 +22,7 @@ float32 qf_min_sf(float32 a1, float32 a2, float_status *fp_status);
 float16 qf_max_hf(float16 a1, float16 a2, float_status *fp_status);
 float16 qf_min_hf(float16 a1, float16 a2, float_status *fp_status);
 
+int32_t conv_w_sf(float32 a, float_status *fp_status);
+int16_t conv_h_hf(float16 a, float_status *fp_status);
+
 #endif
diff --git a/target/hexagon/mmvec/hvx_ieee_fp.c b/target/hexagon/mmvec/hvx_ieee_fp.c
index 2ae79a485a..697f35b5ed 100644
--- a/target/hexagon/mmvec/hvx_ieee_fp.c
+++ b/target/hexagon/mmvec/hvx_ieee_fp.c
@@ -69,3 +69,21 @@ float16 qf_min_hf(float16 a1, float16 a2, float_status *fp_status)
     }
     return float16_min(a1, a2, fp_status);
 }
+
+int32_t conv_w_sf(float32 a, float_status *fp_status)
+{
+    /* float32_to_int32 converts any NaN to MAX, hexagon looks at the sign. */
+    if (float32_is_any_nan(a)) {
+        return float32_is_neg(a) ? INT32_MIN : INT32_MAX;
+    }
+    return float32_to_int32_round_to_zero(a, fp_status);
+}
+
+int16_t conv_h_hf(float16 a, float_status *fp_status)
+{
+    /* float16_to_int16 converts any NaN to MAX, hexagon looks at the sign. */
+    if (float16_is_any_nan(a)) {
+        return float16_is_neg(a) ? INT16_MIN : INT16_MAX;
+    }
+    return float16_to_int16_round_to_zero(a, fp_status);
+}
diff --git a/target/hexagon/imported/mmvec/encode_ext.def b/target/hexagon/imported/mmvec/encode_ext.def
index 72daf8724c..c1ed1b6c23 100644
--- a/target/hexagon/imported/mmvec/encode_ext.def
+++ b/target/hexagon/imported/mmvec/encode_ext.def
@@ -840,4 +840,22 @@ DEF_ENC(V6_vfneg_sf,"00011110--0-0110PP1uuuuu011ddddd")
 DEF_ENC(V6_vabs_hf,"00011110--0-0110PP1uuuuu100ddddd")
 DEF_ENC(V6_vabs_sf,"00011110--0-0110PP1uuuuu101ddddd")
 
+/* IEEE FP vcvt instructions */
+DEF_ENC(V6_vcvt_sf_hf,"00011110--0-0100PP1uuuuu100ddddd")
+DEF_ENC(V6_vcvt_hf_sf,"00011111011vvvvvPP1uuuuu001ddddd")
+DEF_ENC(V6_vcvt_hf_ub,"00011110--0-0100PP1uuuuu001ddddd")
+DEF_ENC(V6_vcvt_hf_b,"00011110--0-0100PP1uuuuu010ddddd")
+DEF_ENC(V6_vcvt_hf_uh,"00011110--0-0100PP1uuuuu101ddddd")
+DEF_ENC(V6_vcvt_hf_h,"00011110--0-0100PP1uuuuu111ddddd")
+DEF_ENC(V6_vcvt_uh_hf,"00011110--0--101PP1uuuuu000ddddd")
+DEF_ENC(V6_vcvt_h_hf,"00011110--0-0110PP1uuuuu000ddddd")
+DEF_ENC(V6_vcvt_ub_hf,"00011111110vvvvvPP1uuuuu101ddddd")
+DEF_ENC(V6_vcvt_b_hf,"00011111110vvvvvPP1uuuuu110ddddd")
+
+/* IEEE FP vconv instructions */
+DEF_ENC(V6_vconv_sf_w,"00011110--0--101PP1uuuuu011ddddd")
+DEF_ENC(V6_vconv_w_sf,"00011110--0--101PP1uuuuu001ddddd")
+DEF_ENC(V6_vconv_hf_h,"00011110--0--101PP1uuuuu100ddddd")
+DEF_ENC(V6_vconv_h_hf,"00011110--0--101PP1uuuuu010ddddd")
+
 #endif /* NO MMVEC */
diff --git a/target/hexagon/imported/mmvec/ext.idef b/target/hexagon/imported/mmvec/ext.idef
index 1b16ed0628..788ce1d2ae 100644
--- a/target/hexagon/imported/mmvec/ext.idef
+++ b/target/hexagon/imported/mmvec/ext.idef
@@ -63,6 +63,9 @@ ITERATOR_INSN_ANY_SLOT_DOUBLE_VEC(WIDTH,TAG,SYNTAX2,DESCR,CODE)
 EXTINSN(V6_##TAG, SYNTAX, ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VS),  \
 DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
 
+#define ITERATOR_INSN_SHIFT_SLOT_FLT(WIDTH,TAG,SYNTAX,DESCR,CODE) \
+EXTINSN(V6_##TAG, SYNTAX, ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VS,A_HVX_FLT),  \
+DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
 
 #define ITERATOR_INSN_SHIFT3_SLOT(WIDTH,TAG,SYNTAX,DESCR,CODE) \
 EXTINSN(V6_##TAG, SYNTAX, ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VS,A_CVI_VS_3SRC,A_NOTE_SHIFT_RESOURCE,A_NOTE_NOVP,A_NOTE_VA_UNARY),  \
@@ -3046,6 +3049,100 @@ ITERATOR_INSN_IEEE_FP_16_32_LATE(16, vabs_hf,  "Vd32.hf=vabs(Vu32.hf)", \
 ITERATOR_INSN_IEEE_FP_16_32_LATE(32, vabs_sf,  "Vd32.sf=vabs(Vu32.sf)", \
     "Vector IEEE abs: sf", VdV.sf[i] = float32_abs(VuV.sf[i]))
 
+/* Two pipes: P2 & P3, two outputs, 16-bit */
+#define ITERATOR_INSN_IEEE_FP_DOUBLE_16(WIDTH,TAG,SYNTAX,DESCR,CODE) \
+EXTINSN(V6_##TAG, SYNTAX, \
+ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX_DV,A_HVX_IEEE_FP_OUT_16), \
+DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
+
+/* Two pipes: P2 & P3, two outputs, 32-bit output */
+#define ITERATOR_INSN_IEEE_FP_DOUBLE_32(WIDTH,TAG,SYNTAX,DESCR,CODE) \
+EXTINSN(V6_##TAG, SYNTAX, \
+    ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX_DV,A_HVX_IEEE_FP_OUT_32), \
+    DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
+
+/* Single pipe, 16-bit output */
+#define ITERATOR_INSN_IEEE_FP_16(WIDTH,TAG,SYNTAX,DESCR,CODE) \
+EXTINSN(V6_##TAG, SYNTAX, \
+    ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX,A_HVX_IEEE_FP_OUT_16), \
+    DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
+
+/* single pipe, output can feed 16- or 32-bit accumulate */
+#define ITERATOR_INSN_IEEE_FP_16_32(WIDTH,TAG,SYNTAX,DESCR,CODE) \
+EXTINSN(V6_##TAG, SYNTAX, \
+    ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX,A_HVX_IEEE_FP_OUT_16,A_HVX_IEEE_FP_OUT_32), \
+    DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
+
+/******************************************************************************
+ * IEEE FP convert instructions
+ ******************************************************************************/
+
+ITERATOR_INSN_IEEE_FP_DOUBLE_16(32,  vcvt_hf_ub, "Vdd32.hf=vcvt(Vu32.ub)",
+    "Vector IEEE cvt from int: ub widen to hf",
+    VddV.v[0].hf[2*i]   = uint64_to_float16_scalbn(VuV.ub[4*i], float_round_nearest_even, 0);
+    VddV.v[0].hf[2*i+1] = uint64_to_float16_scalbn(VuV.ub[4*i+1], float_round_nearest_even, 0);
+    VddV.v[1].hf[2*i]   = uint64_to_float16_scalbn(VuV.ub[4*i+2], float_round_nearest_even, 0);
+    VddV.v[1].hf[2*i+1] = uint64_to_float16_scalbn(VuV.ub[4*i+3], float_round_nearest_even, 0))
+
+ITERATOR_INSN_IEEE_FP_DOUBLE_16(32,  vcvt_hf_b,  "Vdd32.hf=vcvt(Vu32.b)",
+    "Vector IEEE cvt from int: b widen to hf",
+    VddV.v[0].hf[2*i]   = int64_to_float16_scalbn(VuV.b[4*i], float_round_nearest_even, 0);
+    VddV.v[0].hf[2*i+1] = int64_to_float16_scalbn(VuV.b[4*i+1], float_round_nearest_even, 0);
+    VddV.v[1].hf[2*i]   = int64_to_float16_scalbn(VuV.b[4*i+2], float_round_nearest_even, 0);
+    VddV.v[1].hf[2*i+1] = int64_to_float16_scalbn(VuV.b[4*i+3], float_round_nearest_even, 0))
+
+ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vcvt_sf_hf, "Vdd32.sf=vcvt(Vu32.hf)",
+    "Vector IEEE cvt: hf widen to sf",
+    VddV.v[0].sf[i] = f16_to_f32(VuV.hf[2*i]);
+    VddV.v[1].sf[i] = f16_to_f32(VuV.hf[2*i+1]))
+
+ITERATOR_INSN_IEEE_FP_16(16,    vcvt_hf_uh, "Vd32.hf=vcvt(Vu32.uh)",
+    "Vector IEEE cvt from int: uh to hf",
+    VdV.hf[i] = uint64_to_float16_scalbn(VuV.uh[i], float_round_nearest_even, 0))
+ITERATOR_INSN_IEEE_FP_16(16,    vcvt_hf_h,  "Vd32.hf=vcvt(Vu32.h)",
+    "Vector IEEE cvt from int: h to hf",
+    VdV.hf[i] = int64_to_float16_scalbn(VuV.h[i], float_round_nearest_even, 0))
+ITERATOR_INSN_IEEE_FP_16_32(16, vcvt_uh_hf, "Vd32.uh=vcvt(Vu32.hf)",
+    "Vector IEEE cvt to int: hf to uh",
+    VdV.uh[i] = float16_to_uint16_scalbn(VuV.hf[i], float_round_nearest_even, 0, &env->hvx_fp_status))
+ITERATOR_INSN_IEEE_FP_16_32(16, vcvt_h_hf,  "Vd32.h=vcvt(Vu32.hf)",
+    "Vector IEEE cvt to int: hf to h",
+    VdV.h[i]  = float16_to_int16_scalbn(VuV.hf[i], float_round_nearest_even, 0, &env->hvx_fp_status))
+
+ITERATOR_INSN_IEEE_FP_16(32, vcvt_hf_sf, "Vd32.hf=vcvt(Vu32.sf,Vv32.sf)",
+    "Vector IEEE cvt: sf to hf",
+    VdV.hf[2*i]   = f32_to_f16(VuV.sf[i]);
+    VdV.hf[2*i+1] = f32_to_f16(VvV.sf[i]))
+
+ITERATOR_INSN_IEEE_FP_16_32(32, vcvt_ub_hf, "Vd32.ub=vcvt(Vu32.hf,Vv32.hf)", "Vector cvt to int: hf narrow to ub",
+    VdV.ub[4*i]   = float16_to_uint8_scalbn(VuV.hf[2*i], float_round_nearest_even, 0, &env->hvx_fp_status);
+    VdV.ub[4*i+1] = float16_to_uint8_scalbn(VuV.hf[2*i+1], float_round_nearest_even, 0, &env->hvx_fp_status);
+    VdV.ub[4*i+2] = float16_to_uint8_scalbn(VvV.hf[2*i], float_round_nearest_even, 0, &env->hvx_fp_status);
+    VdV.ub[4*i+3] = float16_to_uint8_scalbn(VvV.hf[2*i+1], float_round_nearest_even, 0, &env->hvx_fp_status))
+
+ITERATOR_INSN_IEEE_FP_16_32(32, vcvt_b_hf,  "Vd32.b=vcvt(Vu32.hf,Vv32.hf)",
+    "Vector cvt to int: hf narrow to b",
+    VdV.b[4*i]   = float16_to_int8_scalbn(VuV.hf[2*i], float_round_nearest_even, 0, &env->hvx_fp_status);
+    VdV.b[4*i+1] = float16_to_int8_scalbn(VuV.hf[2*i+1], float_round_nearest_even, 0, &env->hvx_fp_status);
+    VdV.b[4*i+2] = float16_to_int8_scalbn(VvV.hf[2*i], float_round_nearest_even, 0, &env->hvx_fp_status);
+    VdV.b[4*i+3] = float16_to_int8_scalbn(VvV.hf[2*i+1], float_round_nearest_even, 0, &env->hvx_fp_status))
+
+ITERATOR_INSN_SHIFT_SLOT_FLT(32, vconv_w_sf,"Vd32.w=Vu32.sf",
+    "Vector conversion of sf32 format to int w",
+    VdV.w[i] = conv_w_sf(VuV.sf[i], &env->hvx_fp_status))
+
+ITERATOR_INSN_SHIFT_SLOT_FLT(16, vconv_h_hf,"Vd32.h=Vu32.hf",
+    "Vector conversion of hf16 format to int hw",
+    VdV.h[i] = conv_h_hf(VuV.hf[i], &env->hvx_fp_status))
+
+ITERATOR_INSN_SHIFT_SLOT_FLT(32, vconv_sf_w,"Vd32.sf=Vu32.w",
+    "Vector conversion of int w format to sf32",
+    VdV.sf[i] = int32_to_float32(VuV.w[i], &env->hvx_fp_status))
+
+ITERATOR_INSN_SHIFT_SLOT_FLT(16, vconv_hf_h,"Vd32.hf=Vu32.h",
+    "Vector conversion of int hw format to hf16",
+    VdV.hf[i] = float16_val(int16_to_float16(VuV.h[i], &env->hvx_fp_status)))
+
 /******************************************************************************
  DEBUG Vector/Register Printing
  ******************************************************************************/
-- 
2.37.2


