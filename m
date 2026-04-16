Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66469F8A15F
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 11:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDL4M-00059B-12; Thu, 16 Apr 2026 07:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wDL46-00056o-3l
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:39:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wDL43-0003Aj-SB
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:39:21 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63GAY4eq1245269
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mKOxYRftlw4
 atMQY4G9h8sTwL51kYBv6lJOgxUyKXww=; b=X5S1EigY7lm+vg1NHzykTOeMYQy
 nInVwDb9Rtfsn09uMCwKEZCpeO/l1Vs+AS1AGVV6Acse362ooJrcrB+KnRTXQTu3
 zvTi4zFsuS9tF7dzmkgrU4nYBsCfiFprH5553BSd9QDZ6iBzKxQtWb0L1rNM5XDy
 pljCMXIjqOU3h142j+J7vew8jDDkrnRgdNAudoONnGRJVJ95aNKQmol2FHct08Rk
 Hs9gNLKC4d2MFUjmGWqkIU0A5C3V57nymQZymzqkJjY3Zv8f4yZ+z5ClfZ0idSiI
 CuQUEGPuO0b1SBG6ojJYrRBHK/cRDLLmmIgb3a/ibOqgjz+ivlxm2xTYBjQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djx4k863w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:39:17 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2bdd327d970so391548eec.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 04:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776339556; x=1776944356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mKOxYRftlw4atMQY4G9h8sTwL51kYBv6lJOgxUyKXww=;
 b=TubuXfu/hu7T2vlxupj1az4sgO33LqJ72MBDpN6PJ5KP9L1ahUemja5iywXwiCOzut
 hXlcLrweWonn0HUxYNG6pBWse00SzFKRc53jHS4mdjRy2PuR3U1IX3OBKWECt9qZaKRC
 RICgkG3DdftWOArARBysiocMXbfCsNos6xJGXaYsI06W7BgtVDbvBll9yJjOlqdO6lQM
 opYGFodz0VIeZAtq8mVoWNHCoO0X0aVKHQ47/Gx+uUSifixIz02qU4yuAeeu+QXhSXeo
 mbjhGKbI03qOuyeZ96jgv1xLuDZB/79O3fIC88d0WxJfGb603TNKeyAk+wYv4JGZOBup
 QzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776339556; x=1776944356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mKOxYRftlw4atMQY4G9h8sTwL51kYBv6lJOgxUyKXww=;
 b=ebZVhoIMEW8kGh1BIk2gzkjKG5Tby3tGco3TGdfV/z4CCntdyXhznMrGJcQm1qUNTg
 TLJkcmMMH56AVQHl56XTbKlwEnlFLjtuExxvgaR13zme4tz13NLeg2dLVyFMhGEH7SHt
 msKCKQbVLZV38PmFH4W+uhJuBl8ZBvWwxSMQg8fXE1iTcfEx5wW2UMiRwIjekHQ0hzvF
 Vj9xG3nL5v1G+YfZ+vhJtWScI2GI402TGMWSNDXQUmtSFpG34vMoaFKn+2AwLp5nx8lg
 WzwDJzhbI3fBlTM/KFQPsDFS5b4lowArIxDLxKpPTFRrLV//mMi9MVdYmQTkrnFu7XWL
 6BcA==
X-Gm-Message-State: AOJu0Yw3pm+dq/NL5KKIkhyOuYnhZ2FDfaS7ZXgxc1dDGiP2wuDEXcRV
 UA8DNNzMN/YXkIWyoFArZ19Cie6zYzN0GHP/Emyo8FG3RwP3VlnNsd4lUJNuLx3r6eiYDQBFgmM
 Y0ejv3YTRiULo2E2Rd9hsBRzAOfK5OMn1HJKaV6R/BlLZJgRR0aZvjI1jRcm+kujufNCL
X-Gm-Gg: AeBDiesxCcC4ysmSQPg+MDf2/ua3eloW1gSDD72eZD7btExQ60FJZs+we0BBV2XRvY5
 kPxQ1vFatu5rTjaUWZaJ2Gh6DkebyAuf46v4+KBP0kUhPqxx7bpRhRtVBtSDpW7wP3FBderJkNj
 jtnOcibDs+KtTtJphmWxQgwechdAPc+Lg+Taf2SaCdaavxhDv1+rSC6SgMkTAFia84wd3NNOu/i
 bwbRA5jc/z9AWDiLpgY76SE+63kJuy6WCHLS/Z2XV/DPLqL2xwcPZVHQ9jaxzj4eg1DbcYUR0fW
 u49rK3tLwQ9Y7Nghz1wCJ0QrqqjEJVxNdLiGFAAmguFpx+J0pKABsGqGEuyTPisBjgO40qqwLHE
 aJ/YQMYVPkVQCu3YyWhxiNb751ZaNvCfKl9oxznEuXA/5kpBIz9GAJ30ur2mNcB/KX7AP1ttKTK
 7yXn+vkogerqgRgrxOUsc=
X-Received: by 2002:a05:7300:2d15:b0:2d8:b2e1:20da with SMTP id
 5a478bee46e88-2e21ada9946mr529936eec.2.1776339555277; 
 Thu, 16 Apr 2026 04:39:15 -0700 (PDT)
X-Received: by 2002:a05:7300:2d15:b0:2d8:b2e1:20da with SMTP id
 5a478bee46e88-2e21ada9946mr529916eec.2.1776339554673; 
 Thu, 16 Apr 2026 04:39:14 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c10a65asm6845391eec.6.2026.04.16.04.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 04:39:14 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v5 07/16] target/hexagon: add v68 HVX IEEE float min/max insns
Date: Thu, 16 Apr 2026 04:38:56 -0700
Message-Id: <8e274a7a10a5aae23eb1250db0b4f4250c81f3ef.1776339451.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1776339451.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1776339451.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8_cMysrQjUqyawERF-nTdw4oLMveHO1k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDExMCBTYWx0ZWRfX8dmjNcC0u+Js
 3PQUBpDqMxAbY73XHQj27DXXhcnPNZHidLUnGymEHFgOfmMpVpZVa6oFfgkksk/8MwMWR8sMksh
 Caj8fBM0AD4Q/auLCdi+in8Sz8GybheCUXgSQMgVlYf0qL/GWm9EBhBcs5jPOtRbQVtu9u2CQ8M
 neSCaxsp43UV/1ZDN4s/tyTLNkV0QnZWgGBP5f8MDzixBu3BmYEuvrW6zZ++nYozmi+Zi33KmdT
 AwjzoCOXmVjVJXFY73xXJXq/pFp2ziyyCTmL7MZF7h1YW3n3W3WgSn80rxxxifVWzdZ3sL+f4Lm
 O2gOtn1DGWzIxWgFfX7Atu9BoH1v5pVHu650f56y+u2M4DYr05CuNYIWyJFFgQ55J4CK+h1ZjNs
 tmiesYiE/yCZESTcyfjGdjGajbj7vDPWP0Ir2T2zSPGzYnllP4S5DT8QgWSoIdOMjfD7t3lTecP
 CAhl1puzW+X0Ao2oCWw==
X-Authority-Analysis: v=2.4 cv=H47rBeYi c=1 sm=1 tr=0 ts=69e0ca65 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=KsDfajj0LuzFEeFCdIYA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: 8_cMysrQjUqyawERF-nTdw4oLMveHO1k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604160110
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

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/mmvec/hvx_ieee_fp.h           |  6 +++
 target/hexagon/attribs_def.h.inc             |  2 +
 target/hexagon/mmvec/hvx_ieee_fp.c           | 50 ++++++++++++++++++++
 target/hexagon/hex_common.py                 |  1 +
 target/hexagon/imported/mmvec/encode_ext.def | 10 ++++
 target/hexagon/imported/mmvec/ext.idef       | 36 +++++++++++++-
 6 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/mmvec/hvx_ieee_fp.h b/target/hexagon/mmvec/hvx_ieee_fp.h
index 75008deb3b..dff2fab14c 100644
--- a/target/hexagon/mmvec/hvx_ieee_fp.h
+++ b/target/hexagon/mmvec/hvx_ieee_fp.h
@@ -15,4 +15,10 @@ float32 fp_mult_sf_hf(float16 a1, float16 a2, float_status *fp_status);
 float32 fp_vdmpy(float16 a1, float16 a2, float16 a3, float16 a4,
                  float_status *fp_status);
 
+/* Qfloat min/max treat +NaN as greater than +INF and -NaN as smaller than -INF */
+float32 qf_max_sf(float32 a1, float32 a2, float_status *fp_status);
+float32 qf_min_sf(float32 a1, float32 a2, float_status *fp_status);
+float16 qf_max_hf(float16 a1, float16 a2, float_status *fp_status);
+float16 qf_min_hf(float16 a1, float16 a2, float_status *fp_status);
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
index 3367226998..2ae79a485a 100644
--- a/target/hexagon/mmvec/hvx_ieee_fp.c
+++ b/target/hexagon/mmvec/hvx_ieee_fp.c
@@ -19,3 +19,53 @@ float32 fp_vdmpy(float16 a1, float16 a2, float16 a3, float16 a4,
     return float32_add(fp_mult_sf_hf(a1, a3, fp_status),
                        fp_mult_sf_hf(a2, a4, fp_status), fp_status);
 }
+
+#define float32_is_pos_nan(X) (float32_is_any_nan(X) && !float32_is_neg(X))
+#define float32_is_neg_nan(X) (float32_is_any_nan(X) && float32_is_neg(X))
+#define float16_is_pos_nan(X) (float16_is_any_nan(X) && !float16_is_neg(X))
+#define float16_is_neg_nan(X) (float16_is_any_nan(X) && float16_is_neg(X))
+
+/* Qfloat min/max treat +NaN as greater than +INF and -NaN as smaller than -INF */
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
index 9819201b50..168112c66f 100755
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


