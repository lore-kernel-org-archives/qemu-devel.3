Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE57810F9973
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYGo-0004Vn-SB; Wed, 08 Apr 2026 15:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wAYFW-0003Io-KF
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:07:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wAVu5-0006pD-Lx
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 12:37:23 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638EKI8x575843
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 16:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=nEO8O8LtTfe
 UWyUqF9mWHYGzxkUsvQem17/x0W1FDNM=; b=I1Naz9yrvKkjeX6xwfA6TLXJbf/
 8Tg38HgrskGeWnG/94mPB/Ihni1384DkfkKKKq1kcfd46t+YFzgZFDC6KanBOb9Q
 MMrVUBrPKHv+DKrho82HYcATqQiin9O3pNXqfW8XGIXWtRSz7KFc6PYn8Bz1Gwhm
 G2UB+E1iifH65OrjC/MJZfFHwvXLLty1a3quBrFMBYAuQ7YQCGvRzln8HztDqoI1
 I9FZ+tNHJLw7fLCEPk/U59Dsuu/SeeMW8TPjMk8tAjsow5pJKpkbIlo8K3LNpnME
 /wireeBywr2oHQ/4U98tTTCdz6YT6CqRaIeC8ERSVxUfv0c0IwcvOmwlZHg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddrph8hqg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 16:37:20 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c7422397574so140267a12.0
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 09:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775666239; x=1776271039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nEO8O8LtTfeUWyUqF9mWHYGzxkUsvQem17/x0W1FDNM=;
 b=LvgLCXf984ACbSQBkAVRw23tDQZP0V2LDueQjNjut7/yrWvgzaugkXgGI/SL+a9GiT
 fxogS9/ICYGnIabUROv4qOJQqz/FCs+BcAAA8d4u/0GTH9rs4j42mW67dKqOddGpDmWo
 Q/+3vVyREDqf4VMG2JCOPGFbVGyPS16ayXG8KRkNTEiA5bUa9LaLFvX2EFxuI1a40aVX
 rw7w/G69yCcVqTjmxyAy0wszThxnJIsaEs2gAeY/mgwTvw1eh0R8SaRPg5ICzBXUMPkt
 UcTJ7b0eQnLCbKQsNoL2l3eL7Eu/Ww6SRmyLEfkH7FC9RTIo/IDREvKPoUQgSPJlOjAt
 FVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775666239; x=1776271039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nEO8O8LtTfeUWyUqF9mWHYGzxkUsvQem17/x0W1FDNM=;
 b=BT2NzZHFPLj/PUN3iIIB/eZJGRO2g/Uiwf4k/deWsW2gk+LajGhzETZ3CvP7A30eMZ
 SuT3hh5tkR8tkUeWH8NnPbMF+S1PsrlvQzVl9EomnlWMsptI6frniQXibVzp39XIzVIu
 BpzgMnrppGNaxZZd8E7qdfSrb5wmy5wMz5KtbCmc5zeKdSsLKBoMe/vAmHwviZuVVSjp
 A4WY/17wYnFMA/UgHMZR5nbP2Zrw+RA7n59xylKfmPN1rqhgekt0guNQEByqgxdcU/tB
 ffTi0BVdUziw2Pl2rBNTXUEfCsKseCzgvQa0c0WeauetNKSLYo/7HZqt1ctakmZV1sxi
 c52w==
X-Gm-Message-State: AOJu0Yz8la0PO74FlxSjvSZM9ZQDHNPagHA5Xu3MuyzrMG5HnI2AwSDo
 8DTj4q4GahXo0L/UoVurTnTn535zbASPY04/MEl10Am/XhpOWaMp4CvBtWC2L7r1G4gNJWsgPfb
 RNtWC9rlHowJdRS+isy73Ec4vHwjOmEuBf2zl4zgTHY+RgHo13atJpjGxcv/v+raEb1WC
X-Gm-Gg: AeBDietw2c1PH7MIBLjFykuWojb4n0/ij9NFmIQQxYQ3jLuL8Qd9bXWyBj/Y/RQDyP5
 3IiuX7P/7ki+rIurQJimKvxkoHwP49Ekvk+/UQEfIzB3alm7KZjqTD1rnM+WfUAe927yh67VXMW
 gFhOGOrhJPbzp0aceOBUgUUFJA95AulCRkVCZXMhwM4aVYCDClBw5HKqsDreX4AhLZkBL8WV4hF
 yQQOeXLKoh92niUjeLh76bVp119FTL1hW0WmVa67hab2FBLF28IRcQ6mNWhyZrF6sqBBHe0jJQx
 8kb8kx350Ka1PY5tblfgQ2rISIl5blpx6HxWEODz6518g2zyzX8BGt9AwnQst9827nUb655h456
 3v++GJBw3nZIVyb7VZBhpimc2KxS52sW/pAQ7XUZT2NEw0k6kV2sm6sY4gmlwA0MtbgZ9Ez2itt
 fqelMbV0QV
X-Received: by 2002:a05:7022:2520:b0:12a:6ab7:3f71 with SMTP id
 a92af1059eb24-12c28bd4e16mr71220c88.7.1775666239035; 
 Wed, 08 Apr 2026 09:37:19 -0700 (PDT)
X-Received: by 2002:a05:7022:2520:b0:12a:6ab7:3f71 with SMTP id
 a92af1059eb24-12c28bd4e16mr71198c88.7.1775666238299; 
 Wed, 08 Apr 2026 09:37:18 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c1ff43d04sm4082006c88.4.2026.04.08.09.37.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:37:17 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v3 09/16] target/hexagon: add v68 HVX IEEE float conversion
 insns
Date: Wed,  8 Apr 2026 09:37:00 -0700
Message-Id: <99bac24648fdd5c5903e057eb4c9208d851070a4.1775665981.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Rq4QgTynvK0m9l8IsgUw9P-SxKeqz6BY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE1NCBTYWx0ZWRfXwj8lSpgjWXM/
 Xu8BaIjntjUm4vvdkGymDEk/tSBLk5reKIYkNSya4D+/pb7A+VyIBBpEdLjszNPc5Jx6VbTuIIt
 vS+Yi8fHjzQWAmt4scynH1vHFqK1Q++bwzbv/x4xJLOnKKKQdLKx760bGkcttW1rGGLoUT1oW1Q
 6WA2FN+EMmxLOVtKu7WybBPH/h6RYHC1luJMltqZgVDHBps93bOR3wXn8qPPyZ0PwsjQMta/OYf
 jXt3H330u5jax69wAP+MgXLgVTURZNHp235O3YTmY8l7yA/B2zBjFfmQONpLdB/MDtcwy7SR4op
 wMqIPOJL538z5qdtaaIiT02POOBLaASD+K2JR9eHAiQVYNyUsFhJPHG2AxOLQMyWPiL+tlAj6FO
 BAzaLELX45asEpNAziXRH+RBVc4/07ju/uXwHuAxgPLEocoE/hgKMCoG/B1Ap2rytV2QHnQrECm
 na5P6qbE1AYviFkyfzw==
X-Authority-Analysis: v=2.4 cv=PMA/P/qC c=1 sm=1 tr=0 ts=69d68440 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=2JvGeOnW2cDEA-NDw-QA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: Rq4QgTynvK0m9l8IsgUw9P-SxKeqz6BY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080154
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

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/mmvec/hvx_ieee_fp.h           |  4 +
 target/hexagon/mmvec/hvx_ieee_fp.c           | 18 ++++
 target/hexagon/imported/mmvec/encode_ext.def | 18 ++++
 target/hexagon/imported/mmvec/ext.idef       | 97 ++++++++++++++++++++
 4 files changed, 137 insertions(+)

diff --git a/target/hexagon/mmvec/hvx_ieee_fp.h b/target/hexagon/mmvec/hvx_ieee_fp.h
index ed8e4f2da9..d55837b756 100644
--- a/target/hexagon/mmvec/hvx_ieee_fp.h
+++ b/target/hexagon/mmvec/hvx_ieee_fp.h
@@ -10,6 +10,7 @@
 #include "fpu/softfloat.h"
 
 #define f16_to_f32(A) float16_to_float32((A), true, &env->hvx_fp_status)
+#define f32_to_f16(A) float32_to_float16((A), true, &env->hvx_fp_status)
 
 float32 fp_mult_sf_hf(float16 a1, float16 a2, float_status *fp_status);
 float32 fp_vdmpy(float16 a1, float16 a2, float16 a3, float16 a4,
@@ -21,4 +22,7 @@ uint32_t qf_min_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
 uint16_t qf_max_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
 uint16_t qf_min_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
 
+int32_t conv_w_sf(float32 a, float_status *fp_status);
+int16_t conv_h_hf(float16 a, float_status *fp_status);
+
 #endif
diff --git a/target/hexagon/mmvec/hvx_ieee_fp.c b/target/hexagon/mmvec/hvx_ieee_fp.c
index 868c0c5b18..0d9ff8bd5f 100644
--- a/target/hexagon/mmvec/hvx_ieee_fp.c
+++ b/target/hexagon/mmvec/hvx_ieee_fp.c
@@ -68,3 +68,21 @@ float16 qf_min_hf(float16 a1, float16 a2, float_status *fp_status)
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
index 5312661684..3306169060 100644
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
     "Vector IEEE abs: sf", VdV.hf[i] = float32_abs(VuV.hf[i]))
 
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


