Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C078810F996A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXqC-0002P4-JM; Wed, 08 Apr 2026 14:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wAXq5-0001xa-3Y
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:41:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wAVu4-0006ow-4C
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 12:37:21 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638B8clB1314539
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 16:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=nkTOqU3p++3
 FTV67E006ISdH7bkUa1lMdBoloXYrJgo=; b=BibofhdzQ1M6yug20Qg1uEx3C84
 VridvlkpoNYvXMUDbLL3g08nBfvs3vGZY1zoNTpF3B+7p5WV7eVDAN/QeFahK6vo
 wzr7rCrIKuBcyZYfI5sajSQlRtGCdp95cB8BT+oap8Aiz/+uiv3EjQF0W/lhh8kV
 BcTFsKEF1NJnA8BUHgP/WOpbdS9T7kA7n3VIiwtOGo0XVK9/kCAY0FuQivUPXSUn
 rzD134SPmgCZnj1l15DGVCRfIRtwb03gU4L1ecyZqioetmsUCqaSU5/yxo8rdyl9
 BZvhUUoxVC+htslS5N9juDT4GEEqBE+O6fK3uh9+P8Osdr9jJR9f3wvC3wQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd8d6m406-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 16:37:18 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c7422397574so140250a12.0
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 09:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775666237; x=1776271037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nkTOqU3p++3FTV67E006ISdH7bkUa1lMdBoloXYrJgo=;
 b=T/sS6rciYDFIEaB/Ctx8eoRLUAe95d5qHIbFbVkUyr8EmgpE4jR2erxygjfIvgfZtJ
 2KgbA0pYI8fE+NmvtAc1QribvDvEMPM7GDOU3UU5H6qveOHCZJhVZX9uWOvxPNsIRQIn
 vhIwVAWhV2nHlY+KZ8C3a+DmsDZm06nrGSsk9lV91NB9FPp/JvbuviUZ2bVSDExG8iD7
 yvBM/HOL80m2uh7zRTgl557roOCqAxOjWMsRhaHCgfiOQQ2E+ldBNLK+HfoQXmM68d2Y
 ak/g4rWl+15i5SBuFq8YkXDTtS5kKYOVudGQzenoJMQ1M7Mjwr/b4ghBC1Japs1lYXLC
 0Rdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775666237; x=1776271037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nkTOqU3p++3FTV67E006ISdH7bkUa1lMdBoloXYrJgo=;
 b=Hu8VuDPUd+YPMMqIP8+/6lbxfjZF2bnV2Nfna2opEA/X9uzhGRirhloBk3S/Zp1fmX
 arOrHa3dE3os3PrMf8gzaO8OEXvtM9oByM+jR+DlwOXHaAc8d/ywCdd2ELBJrm45F3l9
 p9pdr1crp+EaMThnX3tOK7hohNxUAC6bDM1X02oGt7EEo93hgUN6OpFLT9/NXRDWFT+Z
 ch+VBl7OBPuQaVdHx+ZVBL+/Xjrir+PiF8CwW9lj5S6LNXkryHv3d6pC9mZ7gNDfrVoz
 4c22VGaSWAtuhDacBgK6qHESEXgkK5GGewc2ZRyPzPnyATMqVq50TKvIyOSyqeh1xkKn
 FjWw==
X-Gm-Message-State: AOJu0YzZT3zX89GynheNd7wFh97YWVqXVocdbjaqCoW5aLcXAVlyqpxP
 k75nKFnmTb/slUays+lhINFU72uaP0A05eg8JGPo64jiO770ZJ1Y6Cx7CvaD8rwcel4hkJ2zx0U
 GEU96+4hpdACl6DP6tQ9I5u1Dpjx77e3lKyWoJz3VPlgrOQHRDdYvvb1SkT9/+yA/J2eB
X-Gm-Gg: AeBDievmET5NEbgJyu+jgEPJlzYpCGBsKinLdiF5OsfKboHG/fEJwRC8h8XHUZhHn1U
 dT6ATAURnTd/737Tkwj5w8ZMaePXc2pVrHSSAFe7ul7qgQmaCrhhvDg/ZaKiSb0XOIf0aGlu6ze
 y8lkXmdtCR/LSWdvcDfsDPpVnORKOqdL/+t5Nq51v8FizIEZ5wve2Ap7QIP+d2bKdwUyLRb/3SN
 0qPbqNMww8Gg2r1lI6kN/5rNQc/xxwpM2UxvqjKr/+Va9B3PXZBnwY5J6SzSdBco4ebzD0kLqOD
 4l/We90qguMKeHUtNYBCUZxWnWVjoObLzLNyI7dSwh9F5/BZyloRr4Dvc84q7zRgPom3W5tn9sJ
 beyFBnKbizqYchVUSdVxqUQyOtodBhQH7gYJCvDZ+RD7eSP2TbP6jczuVMqnO3Q3/EB498KaX61
 6Kp+GfK065
X-Received: by 2002:a05:7022:f96:b0:119:e569:f609 with SMTP id
 a92af1059eb24-12c28bd4cfbmr79073c88.2.1775666236627; 
 Wed, 08 Apr 2026 09:37:16 -0700 (PDT)
X-Received: by 2002:a05:7022:f96:b0:119:e569:f609 with SMTP id
 a92af1059eb24-12c28bd4cfbmr79055c88.2.1775666235879; 
 Wed, 08 Apr 2026 09:37:15 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c1ff43d04sm4082006c88.4.2026.04.08.09.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:37:15 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v3 07/16] target/hexagon: add v68 HVX IEEE float min/max insns
Date: Wed,  8 Apr 2026 09:36:58 -0700
Message-Id: <01040724683b0329a732666a2b839afade5d72e1.1775665981.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: P7vjWjcw8JsGLd1sHrniAJNlKVY42HRm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE1NCBTYWx0ZWRfX5LfbLbO9fHgp
 asJHGARC3IGBaL9OncCGgbl2bZnaJWmV/5x9pI5TxfRAzrVuS4VBOF3WRLMv15IzNcDCb30d6Wf
 SWQExDG4DLH2A+gWeWtCwIvLlKbhkoZWxf2RP5ODobPytayrlyxU7/ijrO4DPBtzRX4gXyrtFn8
 K/DVKBsQaP25PMwT3fj25thG6SUpiKxhC22NM0ncO9G47lbQTwMab0CQsvbg2OAZasW6FatY7rc
 nI0JYvssPAI5q49O6Y7+rxbH63N8DDQrMw6NCo3MP6Ig4l2Bqiote0Su3q4C8mEw6uD9U95kKDr
 1Gf0uSJJeg1amxyQovpewnq62InXmwbXOMelXNw/f5WFl2wKHCrTgojdnd8O7dYccP9W0mItYXL
 GShS0PBekSqOytd/kbtjjdBzVnQpj57gvRKnOclzw7UlYAwQQKomfChuAoSWxPrt93bm0bSH0Xr
 Echr0ugs+dWaiXt5Rvg==
X-Authority-Analysis: v=2.4 cv=GN041ONK c=1 sm=1 tr=0 ts=69d6843e cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=jrXzG3Pa4KLJnUkuMhcA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: P7vjWjcw8JsGLd1sHrniAJNlKVY42HRm
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

Add HVX IEEE floating-point min/max instructions:
- vfmin_hf, vfmin_sf: IEEE floating-point minimum
- vfmax_hf, vfmax_sf: IEEE floating-point maximum
- vmax_hf, vmax_sf: qfloat IEEE maximum
- vmin_hf, vmin_sf: qfloat IEEE minimum

The Hexagon qfloat variants are similar to the IEEE-754 ones, but they
handle NaN slightly differently. See comment on hvx_ieee_fp.h

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/mmvec/hvx_ieee_fp.h           |  6 +++
 target/hexagon/attribs_def.h.inc             |  2 +
 target/hexagon/mmvec/hvx_ieee_fp.c           | 49 ++++++++++++++++++++
 target/hexagon/hex_common.py                 |  1 +
 target/hexagon/imported/mmvec/encode_ext.def | 10 ++++
 target/hexagon/imported/mmvec/ext.idef       | 36 +++++++++++++-
 6 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/mmvec/hvx_ieee_fp.h b/target/hexagon/mmvec/hvx_ieee_fp.h
index 75008deb3b..ed8e4f2da9 100644
--- a/target/hexagon/mmvec/hvx_ieee_fp.h
+++ b/target/hexagon/mmvec/hvx_ieee_fp.h
@@ -15,4 +15,10 @@ float32 fp_mult_sf_hf(float16 a1, float16 a2, float_status *fp_status);
 float32 fp_vdmpy(float16 a1, float16 a2, float16 a3, float16 a4,
                  float_status *fp_status);
 
+/* Qfloat min/max treat +NaN as greater than +INF and -NaN as smaller than -INF */
+uint32_t qf_max_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
+uint32_t qf_min_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
+uint16_t qf_max_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
+uint16_t qf_min_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
+
 #endif
diff --git a/target/hexagon/attribs_def.h.inc b/target/hexagon/attribs_def.h.inc
index d3c4bf6301..2d0fc7e9c0 100644
--- a/target/hexagon/attribs_def.h.inc
+++ b/target/hexagon/attribs_def.h.inc
@@ -81,6 +81,7 @@ DEF_ATTRIB(CVI_SCATTER, "CVI Scatter operation", "", "")
 DEF_ATTRIB(CVI_SCATTER_RELEASE, "CVI Store Release for scatter", "", "")
 DEF_ATTRIB(CVI_TMP_DST, "CVI instruction that doesn't write a register", "", "")
 DEF_ATTRIB(CVI_SLOT23, "Can execute in slot 2 or slot 3 (HVX)", "", "")
+DEF_ATTRIB(CVI_VA_2SRC, "Execs on multimedia vector engine; requires two srcs", "", "")
 
 DEF_ATTRIB(VTCM_ALLBANK_ACCESS, "Allocates in all VTCM schedulers.", "", "")
 
@@ -179,6 +180,7 @@ DEF_ATTRIB(HVX_IEEE_FP_ACC, "HVX IEEE FP accumulate instruction", "", "")
 DEF_ATTRIB(HVX_IEEE_FP_OUT_16, "HVX IEEE FP 16-bit output", "", "")
 DEF_ATTRIB(HVX_IEEE_FP_OUT_32, "HVX IEEE FP 32-bit output", "", "")
 DEF_ATTRIB(CVI_VX_NO_TMP_LD, "HVX multiply without tmp load", "", "")
+DEF_ATTRIB(HVX_FLT, "This a floating point HVX instruction.", "", "")
 
 /* Keep this as the last attribute: */
 DEF_ATTRIB(ZZ_LASTATTRIB, "Last attribute in the file", "", "")
diff --git a/target/hexagon/mmvec/hvx_ieee_fp.c b/target/hexagon/mmvec/hvx_ieee_fp.c
index 3367226998..868c0c5b18 100644
--- a/target/hexagon/mmvec/hvx_ieee_fp.c
+++ b/target/hexagon/mmvec/hvx_ieee_fp.c
@@ -19,3 +19,52 @@ float32 fp_vdmpy(float16 a1, float16 a2, float16 a3, float16 a4,
     return float32_add(fp_mult_sf_hf(a1, a3, fp_status),
                        fp_mult_sf_hf(a2, a4, fp_status), fp_status);
 }
+
+#define float32_is_pos_nan(X) (float32_is_any_nan(X) && !float32_is_neg(X))
+#define float32_is_neg_nan(X) (float32_is_any_nan(X) && float32_is_neg(X))
+#define float16_is_pos_nan(X) (float16_is_any_nan(X) && !float16_is_neg(X))
+#define float16_is_neg_nan(X) (float16_is_any_nan(X) && float16_is_neg(X))
+
+float32 qf_max_sf(float32 a1, float32 a2, float_status *fp_status)
+{
+    if (float32_is_pos_nan(a1) || float32_is_neg_nan(a2)) {
+        return a1;
+    }
+    if (float32_is_pos_nan(a2) || float32_is_neg_nan(a1)) {
+        return a2;
+    }
+    return float32_max(a1, a2, fp_status);
+}
+
+float32 qf_min_sf(float32 a1, float32 a2, float_status *fp_status)
+{
+    if (float32_is_pos_nan(a1) || float32_is_neg_nan(a2)) {
+        return a2;
+    }
+    if (float32_is_pos_nan(a2) || float32_is_neg_nan(a1)) {
+        return a1;
+    }
+    return float32_min(a1, a2, fp_status);
+}
+
+float16 qf_max_hf(float16 a1, float16 a2, float_status *fp_status)
+{
+    if (float16_is_pos_nan(a1) || float16_is_neg_nan(a2)) {
+        return a1;
+    }
+    if (float16_is_pos_nan(a2) || float16_is_neg_nan(a1)) {
+        return a2;
+    }
+    return float16_max(a1, a2, fp_status);
+}
+
+float16 qf_min_hf(float16 a1, float16 a2, float_status *fp_status)
+{
+    if (float16_is_pos_nan(a1) || float16_is_neg_nan(a2)) {
+        return a2;
+    }
+    if (float16_is_pos_nan(a2) || float16_is_neg_nan(a1)) {
+        return a1;
+    }
+    return float16_min(a1, a2, fp_status);
+}
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index 9e8bcfdcf0..c81dd5b836 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -216,6 +216,7 @@ def need_env(tag):
             "A_CVI_GATHER" in attribdict[tag] or
             "A_CVI_SCATTER" in attribdict[tag] or
             "A_HVX_IEEE_FP" in attribdict[tag] or
+            "A_HVX_FLT" in attribdict[tag] or
             "A_IMPLICIT_WRITES_USR" in attribdict[tag])
 
 
diff --git a/target/hexagon/imported/mmvec/encode_ext.def b/target/hexagon/imported/mmvec/encode_ext.def
index 4ce87d09fd..d7f50db778 100644
--- a/target/hexagon/imported/mmvec/encode_ext.def
+++ b/target/hexagon/imported/mmvec/encode_ext.def
@@ -823,4 +823,14 @@ DEF_ENC(V6_vsub_sf_hf,"00011111100vvvvvPP1uuuuu101ddddd")
 DEF_ENC(V6_vadd_hf_hf,"00011111101vvvvvPP1uuuuu111ddddd")
 DEF_ENC(V6_vsub_hf_hf,"00011111011vvvvvPP1uuuuu000ddddd")
 
+/* IEEE FP min/max instructions */
+DEF_ENC(V6_vfmin_hf,"00011100011vvvvvPP1uuuuu000ddddd")
+DEF_ENC(V6_vfmin_sf,"00011100011vvvvvPP1uuuuu001ddddd")
+DEF_ENC(V6_vfmax_hf,"00011100011vvvvvPP1uuuuu010ddddd")
+DEF_ENC(V6_vfmax_sf,"00011100011vvvvvPP1uuuuu011ddddd")
+DEF_ENC(V6_vmax_sf,"00011111110vvvvvPP1uuuuu001ddddd")
+DEF_ENC(V6_vmin_sf,"00011111110vvvvvPP1uuuuu010ddddd")
+DEF_ENC(V6_vmax_hf,"00011111110vvvvvPP1uuuuu011ddddd")
+DEF_ENC(V6_vmin_hf,"00011111110vvvvvPP1uuuuu100ddddd")
+
 #endif /* NO MMVEC */
diff --git a/target/hexagon/imported/mmvec/ext.idef b/target/hexagon/imported/mmvec/ext.idef
index 14df8e4790..0e9cace203 100644
--- a/target/hexagon/imported/mmvec/ext.idef
+++ b/target/hexagon/imported/mmvec/ext.idef
@@ -43,7 +43,9 @@
 EXTINSN(V6_##TAG, SYNTAX, ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA),  \
 DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
 
-
+#define ITERATOR_INSN_ANY_SLOT_2SRC(WIDTH,TAG,SYNTAX,DESCR,CODE) \
+EXTINSN(V6_##TAG, SYNTAX, ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT),  \
+DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
 
 #define ITERATOR_INSN2_ANY_SLOT(WIDTH,TAG,SYNTAX,SYNTAX2,DESCR,CODE) \
 ITERATOR_INSN_ANY_SLOT(WIDTH,TAG,SYNTAX2,DESCR,CODE)
@@ -3000,6 +3002,38 @@ ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vsub_sf_hf,
     VddV.v[1].sf[i] = float32_sub(f16_to_f32(VuV.hf[2*i+1]),
                                   f16_to_f32(VvV.hf[2*i+1]), &env->hvx_fp_status))
 
+#define ITERATOR_INSN_IEEE_FP_16_32_LATE(WIDTH,TAG,SYNTAX,DESCR,CODE) \
+EXTINSN(V6_##TAG, SYNTAX, \
+        ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX,A_HVX_IEEE_FP_OUT_16,A_HVX_IEEE_FP_OUT_32), \
+        DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
+
+/* IEEE FP min/max instructions */
+ITERATOR_INSN_IEEE_FP_16_32_LATE(16, vfmin_hf, "Vd32.hf=vfmin(Vu32.hf,Vv32.hf)", \
+    "Vector IEEE min: hf",  VdV.hf[i] = float16_min(VuV.hf[i], VvV.hf[i], \
+	&env->hvx_fp_status))
+ITERATOR_INSN_IEEE_FP_16_32_LATE(32, vfmin_sf, "Vd32.sf=vfmin(Vu32.sf,Vv32.sf)", \
+    "Vector IEEE min: sf",  VdV.sf[i] = float32_min(VuV.sf[i], VvV.sf[i], \
+	&env->hvx_fp_status))
+ITERATOR_INSN_IEEE_FP_16_32_LATE(16, vfmax_hf,  "Vd32.hf=vfmax(Vu32.hf,Vv32.hf)", \
+    "Vector IEEE max: hf", VdV.hf[i] = float16_max(VuV.hf[i], VvV.hf[i], \
+	&env->hvx_fp_status))
+ITERATOR_INSN_IEEE_FP_16_32_LATE(32, vfmax_sf,  "Vd32.sf=vfmax(Vu32.sf,Vv32.sf)", \
+    "Vector IEEE max: sf", VdV.sf[i] = float32_max(VuV.sf[i], VvV.sf[i], \
+	&env->hvx_fp_status))
+
+ITERATOR_INSN_ANY_SLOT_2SRC(32,vmax_sf,"Vd32.sf=vmax(Vu32.sf,Vv32.sf)", \
+    "Vector max of sf input", VdV.sf[i] = qf_max_sf(VuV.sf[i], VvV.sf[i], \
+	&env->hvx_fp_status))
+ITERATOR_INSN_ANY_SLOT_2SRC(32,vmin_sf,"Vd32.sf=vmin(Vu32.sf,Vv32.sf)", \
+    "Vector min of sf input", VdV.sf[i] = qf_min_sf(VuV.sf[i], VvV.sf[i], \
+	&env->hvx_fp_status))
+ITERATOR_INSN_ANY_SLOT_2SRC(16,vmax_hf,"Vd32.hf=vmax(Vu32.hf,Vv32.hf)", \
+    "Vector max of hf input", VdV.hf[i] = qf_max_hf(VuV.hf[i], VvV.hf[i], \
+	&env->hvx_fp_status))
+ITERATOR_INSN_ANY_SLOT_2SRC(16,vmin_hf,"Vd32.hf=vmin(Vu32.hf,Vv32.hf)", \
+    "Vector min of hf input", VdV.hf[i] = qf_min_hf(VuV.hf[i], VvV.hf[i], \
+	&env->hvx_fp_status))
+
 /******************************************************************************
  DEBUG Vector/Register Printing
  ******************************************************************************/
-- 
2.37.2


