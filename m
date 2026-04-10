Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9597F45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 17:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBG5r-0006rj-R0; Fri, 10 Apr 2026 13:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wBG5b-0006ns-Cn
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 13:56:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wBG5Z-0001cy-3a
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 13:56:18 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63AH4W8k709104
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 17:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mKOxYRftlw4
 atMQY4G9h8sTwL51kYBv6lJOgxUyKXww=; b=jCbtGEKjrw2hgvGNbd++3AiC29F
 RLeuzpsib36kqgipE1vJTxcoI6Oor4ykj/MAdcXIq/8gANbjG8wxtivUMb32AOla
 lNPchDURAX2AYpgo8vjHtHZ4VHsntBazgXQaE3Ui/31uu3ZFb3M691/SF75mdg9t
 XCaaa+Kar3JSkBjWeq5hnbi1JUsU8S7gS1hrMJ755fxzGuSlrCwbAheZEM7CQy6w
 A9DMzcC/LpBKT4Z2n0ZwD9G3weFAEYkmaYioeD0jBpDHNCQ73xyVR1skteoRMQ3j
 jllry4w9uRs6IFLy3GMisHn2/60m2fHFMek3EE8RtEzopMcPcPoUL8FCxsQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deudj2dh8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 17:56:15 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1279caef718so13580260c88.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 10:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775843774; x=1776448574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mKOxYRftlw4atMQY4G9h8sTwL51kYBv6lJOgxUyKXww=;
 b=kobFjn2E7VcMJUo1u0S/1d9NGKf9ItpEyrMnzUH3EiK9QDn/SE9viweRKwKJdAPf/r
 f09pdg6L8MsLNp1vWKDtbZH2MoVXPV6zOiQSsROnlFd6ltcX3SinDP2I180zUIp7UyG8
 9tJgXfSU+ZumdOiI14qwrPpTIPn60XAOqC2zcU2PXyNNBiqX9EodRbX1PjwIEFnMlV3u
 Z6UU+AcGhsqwsBlCnDuyWg+p9WTnYeERkSPeseRLwENkLKF2F2IB1uzB34GrTmte4w2z
 lErMHVx1303Xh7mSchLyH65RAlBpk6qNONxeS3fAQBZ8jkCGZfM8ZVVHqq+O9yMROadG
 KH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775843774; x=1776448574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mKOxYRftlw4atMQY4G9h8sTwL51kYBv6lJOgxUyKXww=;
 b=tDnj4eeI95aUIqJ3TTlAGn4W42BwS/BetbIiXJaGiRRdjnRBp+1RSw0InDmtW+liYU
 +X7y3+ESB71cfYrqWbnN2WyAeMAQIIXjj/xC3r9GO+XFIRSYY0RA6xAGJnolAsaKopOh
 yUb676otypT2oLg8rRYI+OLwAiZCTTAjmBVXbum7oO519OO7euIczDSvcSqU5BMmITZy
 Xv7rP8cEYkwYS4/M6jPph3Ev2/8e2wcCkmNVkDdlSk+TzIS5v2FdP2ejRzItPT+9azc7
 myvkeexSh0Ykw40nMxxy/PWz0c4ezC38dqJs9qvtvTzLvmGfAIPHyEi84FFI3yxz40CV
 oaPA==
X-Gm-Message-State: AOJu0YzSE2Rq+4xXaqg6ZvYTZNlOqGDMay4R/SV/wK8Hf1+LELUxAZgd
 6Ss5XiukyvZT/kjAWsDNhRA663WouUoYuXV4UfY8qP7AnydQnrpWqsDpj2clLdz4iZFRYAlx0/A
 ybZ9RvzY33/vpyI/0D53bbpmAIoyTdsauRgZhtDN208FYCEu1hmXPO0k8AIum/gD2WmR0
X-Gm-Gg: AeBDieu8/pQgtoyEvbFThJjasUxJkvPenNG1vccsUaNe4I04LHifs2RidJvUryoKx80
 rhSTPnQwqHPB4uwWKAc5CiT1leK1RYrLNM/Aa3kpRBJK/8cRgDvEvnRwvrOR0+wh+2DrpkCKcZL
 nVmcS3O3WuI6Y8c2oMhJYkuaSoQnky2JDB8x3eotSOfD5M681K7HlVgG7WWXNFq33/jaegs6Bb7
 OhzqfwMw9zY7RTZv/7xwqvEhP9hETdUdrP4GkpDELNlbNoUnYUsgejpbx4YAWfR3usmvUxypRDs
 RG9hi5XLhPREp9O9e0qhxeYBeCCtMW/Gejwd1PL2t0F5VOnuNOsgf6U8Bgq8odlsZEozCkriXns
 XWSy5Sf2UOqzFWQ1+0nXF9Sbv16klJnxuoCiD07Ww7xFELEt16qbMRl2Cn5BMfegQmOxZbHOXS/
 CWd0BBZjHI
X-Received: by 2002:a05:7022:6baa:b0:12a:6a64:81d9 with SMTP id
 a92af1059eb24-12c34e89e77mr2498209c88.13.1775843774037; 
 Fri, 10 Apr 2026 10:56:14 -0700 (PDT)
X-Received: by 2002:a05:7022:6baa:b0:12a:6a64:81d9 with SMTP id
 a92af1059eb24-12c34e89e77mr2498181c88.13.1775843773384; 
 Fri, 10 Apr 2026 10:56:13 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c3459f7ffsm4256271c88.3.2026.04.10.10.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 10:56:13 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v4 07/16] target/hexagon: add v68 HVX IEEE float min/max insns
Date: Fri, 10 Apr 2026 10:55:55 -0700
Message-Id: <a89b231b2cb4ccbb40a5c1650426139a8c8c43fe.1775843299.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775843299.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775843299.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2En0Uwr33HrFuzHEcEkQf4Q71wkZjrTS
X-Proofpoint-GUID: 2En0Uwr33HrFuzHEcEkQf4Q71wkZjrTS
X-Authority-Analysis: v=2.4 cv=cKfQdFeN c=1 sm=1 tr=0 ts=69d939bf cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=KsDfajj0LuzFEeFCdIYA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDE2OCBTYWx0ZWRfX56HVEtS11qsm
 ofKupSAjV2VN24Y/sSem21sfRLo3dtoitezBzbwP0VNhIYKkswbt4FKOoa6e6Pb6AyFbSqHKyv6
 tim70imryPNLMxkeHGK9Hc1mk8ZL4n/w60Quk45uzq2Ltz8+pllGcdHDuk5+3eeBcdkayxqzwpz
 Jhb4RT0ErhXtDvm8OwGHjHdAg23h7cvGh+57kPQNGdV14fE8HgXprCqySgmki5nVkzkXF2z08gG
 NQ9iR6OabDhcdDFLpKlUunDRCTNAtYOrP//2QpuTQkiJEDy424Fg2rX0Johfbqc3NJCvYdYZtwv
 lfzYwiQXlxgZ4H+6APytSA+IO9Ep0AU8WX+uqY5YiwOEZc15FG+c2xjhYVuPq40F0qkCAxSqVav
 +RpeYmLOJHGA0XxJj7nCZ/lB9slPruZVV7tyiN7SQJsvc2/aVzLTqcuvGxG0oZGR0jqzXCEgybU
 AafEAUNIgxl9Bbwtc4w==
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


