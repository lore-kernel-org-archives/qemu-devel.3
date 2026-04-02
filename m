Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3ABD39410
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 10:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Fb0-0004oa-VE; Thu, 02 Apr 2026 06:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w8Fan-0004kd-ED
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:48:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w8Fag-0007ot-L2
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:48:01 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6328Rt8V352289
 for <qemu-devel@nongnu.org>; Thu, 2 Apr 2026 10:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=qQ0CPCSb3EJ
 vawUvosj5tPUWguLWpst70une3py6NVA=; b=hFqHR50jxkuaO9/wBXGDwJ3D1cO
 IcPs1FEAMF2nducc7hqZUBmz/MuHK3ObNgg0ZiMhtZQtI1TUr7iEz9vTUqRlgcOk
 5T2UNQI6V8v3R9Rq8cQJ8w4VGqeInHKPUZrBs54KdethXCni4V4r8TIq3Erb2kh9
 FoACH7bWHPDcbScVewOXpSod4U8sDGJ1GRRvQJyzDIv8E0Z7CLWTZnbZenJUIkp3
 GlzHPIxUbBcUc+nyJNm1s3VUivMu8P+jGl7IQDW9A/Q1sSyiAHwHUZ7cVtXoi7H/
 sI+g3QE1AT2SuHfdBiz80FYcGxC/e/WA7qsl6sWppvKSz+4eOEx8ZAzWtXA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9myh8h17-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 10:47:47 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2c72849f648so3525459eec.0
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 03:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775126866; x=1775731666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qQ0CPCSb3EJvawUvosj5tPUWguLWpst70une3py6NVA=;
 b=Phk/nYBzRo4GP6d0ecMGRrxWHTAKa5qvlAu3Eb3hAt5f+bgKnUiW0cQ1a+4cEXxqHD
 IPCmaX6LPNSpx4ngc1Z66EwCiB/BTdQ7ZHAYk04lZD+D7zM8tuIcFCWAIKtwsiNwW9sU
 8kejMJJz9XLhqlEaxEQ8C+XoGEawsgwfnZX/twMbPl7/qNpVTYVXqtlxeJeKS9V6PUX0
 TRpx3VWEjl66De5rQKEo0UdPMcfg4R/rM53hAWWG1Q2GRbvZOnFZ21AJfpQvuC9Jcjjy
 sh/SyPBnKTHSAEeVCoo6pSwn+4vezJv96SCwGqlSsKfLZbIwVonwfLCwvx+qk2RkJxBg
 2bTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775126866; x=1775731666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qQ0CPCSb3EJvawUvosj5tPUWguLWpst70une3py6NVA=;
 b=r18Bo0F2+W+qa0CFNrmNkzUi5FbxjPRQnD4s7y3xgzhFGTj1n9PYHXZhxylZfKvQoY
 jurIYJfBgnmaqQqDXX2KaioUbKgmFj70bgAvj7g+tf+a3/Rm36BUmVw+kziLgWDWZpzL
 ND6XxN4LQLWERVkvLOwXteHOfr8YOB25exwXc43LE3ZSydqNPV3UzDuEGQcEj9uGW6FO
 yCV7pqkbwsPi3IC0qiJCr/VR1rxPsbM5aOpeKH2qHLHqSaDb7ZmK84PQ22cvIx5vuEXl
 scoBblpIMSbuwXe+8xXcK5FspmPFPBAAQqj7go2CvuiJntrLXaN3X7nemGMSBHG5ouiY
 1djw==
X-Gm-Message-State: AOJu0Yz9VC7ymYZwZOrIpRB1SZmFvRGt23mC4tOOsir3vZB4OyFZOlVp
 jfIc3jwbmubLfHBVaYckDXcm3c+X9paVQeRx2gW2SOFwPWc4DZBN3BRQwSO14C+98fSkpJPmlwN
 SQrxvUaX7B6DvZPPlvIGQJHZMP/DB+nEJLx7bsNE5FnAZdJx3teQahjudcJxYx87HGz/a
X-Gm-Gg: ATEYQzxg3r5VxoG1S+RqGJehC5EnSbGxHuCd5IrKrFqW2oNz7X52IpkZVtYFxiTmcUy
 RAsUbu7u/MSjf9rVb5QRNYPPh7wGvu5Pdt++xEAFcdWK3ojnox2REAYGJpOZEd/P2nmvNAopMMy
 U6BHy/3qB7bormalEp3yKnEBzKBN4gz0rxKboT0izHdCc5N3jiFYyxFwd1H5IUT7maN/2mz5Ubi
 it1yj4gvrd/YQM0VyeqZUDGmIsnQrH+ZjMSpQ3G/plcQ133st/7DuRZG+3skm6VFopRqua+Z1xU
 swVu9l8sl8xZW0oHYqTEURH5rHsXK/rQUFKGAHM9ew53q5ryVEExmo8Gcd2pi2Q8pG+uTS7VI8L
 2Btlkrjrh+eX3I6LWcmXWxiJ02rW3Hk1xuABWMc1s/iBVrL2iBKPxc8eicriS40qNkRWZjrMbHB
 2mLgcB+UTe
X-Received: by 2002:a05:7300:fb8e:b0:2c7:11f2:d072 with SMTP id
 5a478bee46e88-2c9323b8c8cmr4502835eec.16.1775126866167; 
 Thu, 02 Apr 2026 03:47:46 -0700 (PDT)
X-Received: by 2002:a05:7300:fb8e:b0:2c7:11f2:d072 with SMTP id
 5a478bee46e88-2c9323b8c8cmr4502809eec.16.1775126865584; 
 Thu, 02 Apr 2026 03:47:45 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca7d00f5easm2004783eec.29.2026.04.02.03.47.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 03:47:45 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v2 10/16] target/hexagon: add v68 HVX IEEE float compare insns
Date: Thu,  2 Apr 2026 03:47:27 -0700
Message-Id: <02cf6a499f7363330a7e600f75b70ed0c6ebb7ca.1775122853.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hUzUK1J7_uxmL1xTuVAQrFvPhlara4MW
X-Proofpoint-ORIG-GUID: hUzUK1J7_uxmL1xTuVAQrFvPhlara4MW
X-Authority-Analysis: v=2.4 cv=JII2csKb c=1 sm=1 tr=0 ts=69ce4953 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=9xUHUbetx40kEkOjbCQA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA5NyBTYWx0ZWRfX9s+an11PevIs
 cWBM0E5LAs74WyRLKF3asoiJodsehyJ1TBytQkAAei6kr5Yu1fxvGDjTrqxGSCraEXonXpmM0xN
 R3tdiIlfCvDapbNyyPHRLdL1TQn1ZqFNKcQVUiQjCtFCMz9iT5+mdO3WfljNyoMw3DWVpwx+ShY
 0LwlTtoVeEWCNIPnt8lXrhk6HtdtBHwLO9/Y5c1PR+BMReF/2Ovkm+IOkpYwh5Fd1905PuY50ql
 nRAA9mNE1tWSgfSZjwQiwzbRx2mG9Sgfu0PZFvYGjH2vyvaq2MDlJSs4pdQNUmek3wGKNAzWB+1
 /O+0xBNvHCOOjtj1KvzVsWkj3e1Nwy9w7plmlJJRDfVTr9OJUIv5ThJ8kIhVio/mw3TtOH5oKiD
 nTqHdLKj3eVQiKYp1hZ/dfofiCQcTaBETyXpfim9KEb8IsO/Gez2GKM2QIcvyJVhONEd7OTBNo5
 BH99aKIMysF4WSg8Ksw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

Add HVX IEEE floating-point compare instructions:
- V6_vgthf, V6_vgtsf: greater-than compare
- V6_vgthf_and, V6_vgtsf_and: greater-than with predicate-and
- V6_vgthf_or, V6_vgtsf_or: greater-than with predicate-or
- V6_vgthf_xor, V6_vgtsf_xor: greater-than with predicate-xor

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/mmvec/hvx_ieee_fp.h           |  4 ++
 target/hexagon/mmvec/macros.h                |  3 +
 target/hexagon/attribs_def.h.inc             |  2 +
 target/hexagon/mmvec/hvx_ieee_fp.c           | 52 +++++++++++++++++
 target/hexagon/hex_common.py                 |  1 +
 target/hexagon/imported/mmvec/encode_ext.def | 10 ++++
 target/hexagon/imported/mmvec/ext.idef       | 61 ++++++++++++++++++++
 7 files changed, 133 insertions(+)

diff --git a/target/hexagon/mmvec/hvx_ieee_fp.h b/target/hexagon/mmvec/hvx_ieee_fp.h
index e73f8161b1..b68d6db23e 100644
--- a/target/hexagon/mmvec/hvx_ieee_fp.h
+++ b/target/hexagon/mmvec/hvx_ieee_fp.h
@@ -56,6 +56,10 @@ uint32_t qf_min_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
 uint16_t qf_max_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
 uint16_t qf_min_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
 
+/* IEEE - FP compare instructions */
+uint32_t cmpgt_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
+uint16_t cmpgt_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
+
 /*
  * IEEE - FP Convert instructions
  */
diff --git a/target/hexagon/mmvec/macros.h b/target/hexagon/mmvec/macros.h
index ac709d8993..318d44efb7 100644
--- a/target/hexagon/mmvec/macros.h
+++ b/target/hexagon/mmvec/macros.h
@@ -356,4 +356,7 @@
                extract32(VAL, POS * 8, 8); \
     } while (0);
 
+#define fCMPGT_SF(A, B) cmpgt_sf(A, B, &env->hvx_fp_status)
+#define fCMPGT_HF(A, B) cmpgt_hf(A, B, &env->hvx_fp_status)
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
index d39a883ab7..131d8e5595 100644
--- a/target/hexagon/mmvec/hvx_ieee_fp.c
+++ b/target/hexagon/mmvec/hvx_ieee_fp.c
@@ -217,3 +217,55 @@ int16_t conv_h_hf(uint16_t a, float_status *fp_status)
     }
     return float16_to_int16_round_to_zero(f1, fp_status);
 }
+
+/*
+ * Returns true if f1 > f2, where at least one of the elements is guaranteed
+ * to be NaN.
+ * Up to v73, Hexagon HVX IEEE FP follows this order:
+ * QNaN > SNaN > +Inf > numbers > -Inf > SNaN_neg > QNaN_neg
+ */
+static bool float32_nan_compare(float32 f1, float32 f2, float_status *fp_status)
+{
+    /* opposite signs case */
+    if (float32_is_neg(f1) != float32_is_neg(f2)) {
+        return !float32_is_neg(f1);
+    }
+
+    /* same sign case */
+    bool result = (float32_is_any_nan(f1) && !float32_is_any_nan(f2)) ||
+        (float32_is_quiet_nan(f1, fp_status) && !float32_is_quiet_nan(f2, fp_status));
+    return float32_is_neg(f1) ? !result : result;
+}
+
+static bool float16_nan_compare(float16 f1, float16 f2, float_status *fp_status)
+{
+    /* opposite signs case */
+    if (float16_is_neg(f1) != float16_is_neg(f2)) {
+        return !float16_is_neg(f1);
+    }
+
+    /* same sign case */
+    bool result = (float16_is_any_nan(f1) && !float16_is_any_nan(f2)) ||
+        (float16_is_quiet_nan(f1, fp_status) && !float16_is_quiet_nan(f2, fp_status));
+    return float16_is_neg(f1) ? !result : result;
+}
+
+uint32_t cmpgt_sf(uint32_t a1, uint32_t a2, float_status *fp_status)
+{
+    float32 f1 = make_float32(a1);
+    float32 f2 = make_float32(a2);
+    if (float32_is_any_nan(f1) || float32_is_any_nan(f2)) {
+        return float32_nan_compare(f1, f2, fp_status);
+    }
+    return float32_compare(a1, a2, fp_status) == float_relation_greater;
+}
+
+uint16_t cmpgt_hf(uint16_t a1, uint16_t a2, float_status *fp_status)
+{
+    float16 f1 = make_float16(a1);
+    float16 f2 = make_float16(a2);
+    if (float16_is_any_nan(f1) || float16_is_any_nan(f2)) {
+        return float16_nan_compare(f1, f2, fp_status);
+    }
+    return float16_compare(a1, a2, fp_status) == float_relation_greater;
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
index c1ed1b6c23..3572e4de4c 100644
--- a/target/hexagon/imported/mmvec/encode_ext.def
+++ b/target/hexagon/imported/mmvec/encode_ext.def
@@ -858,4 +858,14 @@ DEF_ENC(V6_vconv_w_sf,"00011110--0--101PP1uuuuu001ddddd")
 DEF_ENC(V6_vconv_hf_h,"00011110--0--101PP1uuuuu100ddddd")
 DEF_ENC(V6_vconv_h_hf,"00011110--0--101PP1uuuuu010ddddd")
 
+/* IEEE FP compare instructions */
+DEF_ENC(V6_vgtsf,"00011100100vvvvvPP1uuuuu011100dd")
+DEF_ENC(V6_vgthf,"00011100100vvvvvPP1uuuuu011101dd")
+DEF_ENC(V6_vgtsf_and,"00011100100vvvvvPP1uuuuu110010xx")
+DEF_ENC(V6_vgthf_and,"00011100100vvvvvPP1uuuuu110011xx")
+DEF_ENC(V6_vgtsf_or,"00011100100vvvvvPP1uuuuu001100xx")
+DEF_ENC(V6_vgthf_or,"00011100100vvvvvPP1uuuuu001101xx")
+DEF_ENC(V6_vgtsf_xor,"00011100100vvvvvPP1uuuuu111010xx")
+DEF_ENC(V6_vgthf_xor,"00011100100vvvvvPP1uuuuu111011xx")
+
 #endif /* NO MMVEC */
diff --git a/target/hexagon/imported/mmvec/ext.idef b/target/hexagon/imported/mmvec/ext.idef
index 6d5bab0894..6f01a9d48f 100644
--- a/target/hexagon/imported/mmvec/ext.idef
+++ b/target/hexagon/imported/mmvec/ext.idef
@@ -3135,6 +3135,67 @@ ITERATOR_INSN_SHIFT_SLOT_FLT(16, vconv_hf_h,"Vd32.hf=Vu32.h",
     "Vector conversion of int hw format to hf16",
     VdV.hf[i] = conv_hf_h(VuV.h[i], &env->hvx_fp_status))
 
+/******************************************************************************
+ * IEEE FP compare instructions
+ ******************************************************************************/
+
+#define VCMPGT_SF(DEST, ASRC, ASRCOP, CMP, N, SRC, MASK, WIDTH) \
+{ \
+    for (fHIDE(int) i = 0; i < fVBYTES(); i += WIDTH) { \
+        fHIDE(int) VAL = fCMPGT_SF(VuV.SRC[i/WIDTH],VvV.SRC[i/WIDTH]) ? MASK : 0; \
+        fSETQBITS(DEST,WIDTH,MASK,i,ASRC ASRCOP VAL); \
+    } \
+}
+
+#define VCMPGT_HF(DEST, ASRC, ASRCOP, CMP, N, SRC, MASK, WIDTH) \
+{ \
+    for (fHIDE(int) i = 0; i < fVBYTES(); i += WIDTH) { \
+        fHIDE(int) VAL = fCMPGT_HF(VuV.SRC[i/WIDTH],VvV.SRC[i/WIDTH]) ? MASK : 0; \
+        fSETQBITS(DEST,WIDTH,MASK,i,ASRC ASRCOP VAL); \
+    } \
+}
+
+/* Vector SF compare */
+#define MMVEC_CMPGT_SF(TYPE,TYPE2,DESCR,N,MASK,WIDTH,SRC) \
+    EXTINSN(V6_vgt##TYPE##_and, "Qx4&=vcmp.gt(Vu32." TYPE2 ",Vv32." TYPE2 ")", \
+        ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT), \
+        DESCR" greater than with predicate-and", \
+        VCMPGT_SF(QxV, fGETQBITS(QxV,WIDTH,MASK,i), &, ">", N, SRC, MASK, WIDTH)) \
+    EXTINSN(V6_vgt##TYPE##_xor, "Qx4^=vcmp.gt(Vu32." TYPE2 ",Vv32." TYPE2 ")", \
+        ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT), \
+        DESCR" greater than with predicate-xor", \
+        VCMPGT_SF(QxV, fGETQBITS(QxV,WIDTH,MASK,i), ^, ">", N, SRC, MASK, WIDTH)) \
+    EXTINSN(V6_vgt##TYPE##_or, "Qx4|=vcmp.gt(Vu32." TYPE2 ",Vv32." TYPE2 ")", \
+        ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT), \
+        DESCR" greater than with predicate-or", \
+        VCMPGT_SF(QxV, fGETQBITS(QxV,WIDTH,MASK,i), |, ">", N, SRC, MASK, WIDTH)) \
+    EXTINSN(V6_vgt##TYPE, "Qd4=vcmp.gt(Vu32." TYPE2 ",Vv32." TYPE2 ")", \
+        ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT), \
+        DESCR" greater than", \
+        VCMPGT_SF(QdV, , , ">", N, SRC, MASK, WIDTH))
+
+/* Vector HF compare */
+#define MMVEC_CMPGT_HF(TYPE,TYPE2,DESCR,N,MASK,WIDTH,SRC) \
+    EXTINSN(V6_vgt##TYPE##_and, "Qx4&=vcmp.gt(Vu32." TYPE2 ",Vv32." TYPE2 ")", \
+        ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT), \
+        DESCR" greater than with predicate-and", \
+        VCMPGT_HF(QxV, fGETQBITS(QxV,WIDTH,MASK,i), &, ">", N, SRC, MASK, WIDTH)) \
+    EXTINSN(V6_vgt##TYPE##_xor, "Qx4^=vcmp.gt(Vu32." TYPE2 ",Vv32." TYPE2 ")", \
+        ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT), \
+        DESCR" greater than with predicate-xor", \
+        VCMPGT_HF(QxV, fGETQBITS(QxV,WIDTH,MASK,i), ^, ">", N, SRC, MASK, WIDTH)) \
+    EXTINSN(V6_vgt##TYPE##_or, "Qx4|=vcmp.gt(Vu32." TYPE2 ",Vv32." TYPE2 ")", \
+        ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT), \
+        DESCR" greater than with predicate-or", \
+        VCMPGT_HF(QxV, fGETQBITS(QxV,WIDTH,MASK,i), |, ">", N, SRC, MASK, WIDTH)) \
+    EXTINSN(V6_vgt##TYPE, "Qd4=vcmp.gt(Vu32." TYPE2 ",Vv32." TYPE2 ")", \
+        ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT), \
+        DESCR" greater than", \
+        VCMPGT_HF(QdV, , , ">", N, SRC, MASK, WIDTH))
+
+MMVEC_CMPGT_SF(sf,"sf","Vector sf Compare ", fVELEM(32), 0xF, 4, sf)
+MMVEC_CMPGT_HF(hf,"hf","Vector hf Compare ", fVELEM(16), 0x3, 2, hf)
+
 /******************************************************************************
  DEBUG Vector/Register Printing
  ******************************************************************************/
-- 
2.37.2


