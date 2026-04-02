Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0A7D3940D
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 10:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8FaY-0004gJ-KG; Thu, 02 Apr 2026 06:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w8FaW-0004fS-IM
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:47:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w8FaT-0007nk-Ha
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:47:48 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6328S2bv353259
 for <qemu-devel@nongnu.org>; Thu, 2 Apr 2026 10:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4RSdHo2GcTr
 7UdboRqLK3BJKg4ylymHGVOjaziBCMkg=; b=YzS88NfqdfzCwqAmjP8H4iLPJd2
 vNw4Y1Dn0+0bHtUf8rxs66IcLp0gEyncH0lNIXDtvA2o+oyl8o/AjPuTzZVhSHMQ
 Ehw5dsqNJySleQKQaAertLycGJszUjobLL2VO0JxATTUzvJuWf7MDe3pnJXu4LJE
 QZ12j8enGQy45tfbbWQV/ggsy2rA+aYjqEznnFu6xUKmPbP0vL94GDiJbFDphWmz
 CRSZhjDoDjk9c7KYXLlXZoUCBycBRx4dno/hOFmI83F7Pi7xDvNXgsYK28/7p6oI
 I1NUKRyLhqRPnmV5WIWrl6+wqvYTQHYU5CntM3Ck3lRc/W6XNJ315NI02jw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9myh8h10-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 10:47:43 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2c72849f648so3525318eec.0
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 03:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775126863; x=1775731663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4RSdHo2GcTr7UdboRqLK3BJKg4ylymHGVOjaziBCMkg=;
 b=RA3f7HzvrcpVchvZFMfeI6ILjw5x81un9xtnbiI2uVRTCsx011ysNx/Fd8+G2RzkDW
 5Come45U11oMzi9uU55syhy6QPA+NHqeUmXc6RrmMWXJe62WrJuOrWeUdPAkv8oDRVQy
 J1/ePmGCfzsLfQxOcjtbXqWJxvb348su+RPHHUR6u9pjGjdabFEWBbD5uj7IUOfgYNL9
 QOWWd3TmVmaU0oqktdQP1ZjfXmiZM1BNjacgL9vqq0ongJvAqSUdDFtd6EVXTPlCgERb
 pxm7GJJppMx4Eat8U6UzbfjKhbYD865RBPQ78ovH9boPK7xvyglFFXFBPqIw8FA6qnfc
 Foxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775126863; x=1775731663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4RSdHo2GcTr7UdboRqLK3BJKg4ylymHGVOjaziBCMkg=;
 b=K/0sgUdW8m7vs/C/zjV+lYVtT2MLuIR5yv1rhV04RNlA3jsPBBx12VKPU8NxuWUfhU
 f0gK9UTePQLdY7TiWz1yvLQWQCsrTclvCU4/g0VRYkAlAOL+1MS01Nvn4RxnXzw7gzgw
 fSm5OvOi++vueRVn10dGAWH/g3PhumcryKzkbla1do/3y7+S+FPERyi9VEGTaYscwmie
 rbCJB707Xzio6zqiXHeYseh68GP8RfB44wdJQii98MtNa7qe8xcUlbncsgODgitbPYyq
 1zv7gW7VvZGh4lG5AK8suX1Cow1Oi/RAYFJON6ZvypFQo8dCK13EzH4gJuNMXBUmAO0M
 OVVA==
X-Gm-Message-State: AOJu0YzeuUgr66dxAb5Gmci8kewCZy1gy1ZRrAR8uEbxxHeVi8dN5Boj
 TWcfOeRPCKzirKjTvVke78eAeK8cAMd3+jQ3QQ/c8A0wf+54z+PSLYFV0Hxy7azXideuJvN3TDP
 iaHqRzQ0l37eZHvAyZq8MfbyFlZfiVHqHsDT0v1d5w6gNzZn1+n/9kuFXQQ2lUsoly7ND
X-Gm-Gg: ATEYQzxOn/+iixV4DFBSv2WrCufv5V5dZriYn2LCi2YRJPE1bxwc3rbXu8/AzibrULx
 i+pv+yqRrqEJ5adRcmLo/EWYpe/8uOMbJIFjfaexVT4XUGkftTZM0We/Ca/FR0X4H6g7ivK4A6p
 zoVVQpJoci/khZS8wFZDwL4ih/ilKFL1XFFCynbK0P7IBEbYb7YQhKBbvAF6b18+ii+rqn2QLX5
 uyyWFfemcPg1wG2WplFK/h4eIc6rl+4QSFzH7nDlaKf33GtwLwwW2JHCW7dPXNc2RssrIs93v72
 Um3cEXqJ2fBrJe5Ow1RS/m/wlRUNUfiE/znxJpLbqHp5v/vc/Cbd8TW6nFqLKAeC7mzkg2Janhn
 BV0COWlELqUzJsS0KIRuD0m5IUqRB/Y31pJj1HTZY21tJeFLLLw+PPWcVD3RH6uJ4SQGWuQdqWI
 tuyEjbz8e0
X-Received: by 2002:a05:7300:2391:b0:2b8:64ad:ad4d with SMTP id
 5a478bee46e88-2c9328ac7e6mr3804962eec.26.1775126863106; 
 Thu, 02 Apr 2026 03:47:43 -0700 (PDT)
X-Received: by 2002:a05:7300:2391:b0:2b8:64ad:ad4d with SMTP id
 5a478bee46e88-2c9328ac7e6mr3804940eec.26.1775126862426; 
 Thu, 02 Apr 2026 03:47:42 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca7d00f5easm2004783eec.29.2026.04.02.03.47.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 03:47:41 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v2 07/16] target/hexagon: add v68 HVX IEEE float min/max insns
Date: Thu,  2 Apr 2026 03:47:24 -0700
Message-Id: <d8a52cb351422b6adf0252f181bd737f31b2372d.1775122853.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: eXXoUpgHSdauE89wE7-Zb36mzRZnAyT1
X-Proofpoint-ORIG-GUID: eXXoUpgHSdauE89wE7-Zb36mzRZnAyT1
X-Authority-Analysis: v=2.4 cv=JII2csKb c=1 sm=1 tr=0 ts=69ce494f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=vhM5H77lNnm7tnBND-cA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA5NyBTYWx0ZWRfXzDzNoHJSyJ4k
 ln2HBErWohJpBCJWPkYFg8yH1Nygv2AzNObszJUhCXNoq3YXZ5K8TkHch3QJ5EEFRG69CBDKQl3
 HTbKdMFP9eZT4Fufqze8WRN+TGP+EZNCz1lab4rW2RmGEDxcZdmCaHhpuaMVP5GVFQN4BOKGx/8
 vn+lvIVfmWZxuuvmfuGBLVSzPJyZ9iwzKE/m1iNMkU2vhwy7RahlTG2M7zh1jOZT5IY71Bl/0ev
 KSVtkv9FqPFoZR73Krs3+lnC9VFn8S0x3bypeEuiy68klaYuILDBpeX2+d6GGN1Mj0qgtMMwGjs
 iVxI2yeTOErs4gcQZ8BlHllVn8oyCxBbvqER0u7pF6g5YLxCeVm2vLfAI4cP8yi56HjoAYulWUu
 YkyOkOyaHWewoJVI9mIv5eZ2+oLlo/BBHke/bBFKQ4x05DvC6YX+/9NQeevK9e3gzYXsLEzedRN
 3yx7z6hFfRsH1tNj9/g==
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

Add HVX IEEE floating-point min/max instructions:
- vfmin_hf, vfmin_sf: IEEE floating-point minimum
- vfmax_hf, vfmax_sf: IEEE floating-point maximum
- vmax_hf, vmax_sf: qfloat IEEE maximum
- vmin_hf, vmin_sf: qfloat IEEE minimum

The Hexagon qfloat variants are similar to the IEEE-754 ones, but they
handle NaN slightly differently. See comment on hvx_ieee_fp.h

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/mmvec/hvx_ieee_fp.h           | 12 ++++
 target/hexagon/mmvec/hvx_ieee_fp.c           | 62 ++++++++++++++++++++
 target/hexagon/imported/mmvec/encode_ext.def | 10 ++++
 target/hexagon/imported/mmvec/ext.idef       | 36 +++++++++++-
 4 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/mmvec/hvx_ieee_fp.h b/target/hexagon/mmvec/hvx_ieee_fp.h
index 5577179abd..f4801e3be9 100644
--- a/target/hexagon/mmvec/hvx_ieee_fp.h
+++ b/target/hexagon/mmvec/hvx_ieee_fp.h
@@ -44,4 +44,16 @@ uint32_t fp_vdmpy(uint16_t a1, uint16_t a2, uint16_t a3, uint16_t a4,
 uint32_t fp_vdmpy_acc(uint32_t acc, uint16_t a1, uint16_t a2, uint16_t a3,
                       uint16_t a4, float_status *fp_status);
 
+/* IEEE - FP min/max instructions */
+uint32_t fp_min_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
+uint32_t fp_max_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
+uint16_t fp_min_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
+uint16_t fp_max_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
+
+/* Qfloat min/max treat +NaN as greater than +INF and -NaN as smaller than -INF */
+uint32_t qf_max_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
+uint32_t qf_min_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
+uint16_t qf_max_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
+uint16_t qf_min_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
+
 #endif
diff --git a/target/hexagon/mmvec/hvx_ieee_fp.c b/target/hexagon/mmvec/hvx_ieee_fp.c
index ceb32ce43b..086e8dd29e 100644
--- a/target/hexagon/mmvec/hvx_ieee_fp.c
+++ b/target/hexagon/mmvec/hvx_ieee_fp.c
@@ -67,3 +67,65 @@ uint32_t fp_vdmpy_acc(uint32_t acc, uint16_t a1, uint16_t a2,
     float32 red = fp_vdmpy(a1, a2, a3, a4, fp_status);
     return fp_add_sf_sf(float32_val(red), acc, fp_status);
 }
+
+DEF_FP_INSN_2(min_sf, 32, 32, 32, float32_min(f1, f2, fp_status))
+DEF_FP_INSN_2(max_sf, 32, 32, 32, float32_max(f1, f2, fp_status))
+DEF_FP_INSN_2(min_hf, 16, 16, 16, float16_min(f1, f2, fp_status))
+DEF_FP_INSN_2(max_hf, 16, 16, 16, float16_max(f1, f2, fp_status))
+
+#define float32_is_pos_nan(X) (float32_is_any_nan(X) && !float32_is_neg(X))
+#define float32_is_neg_nan(X) (float32_is_any_nan(X) && float32_is_neg(X))
+#define float16_is_pos_nan(X) (float16_is_any_nan(X) && !float16_is_neg(X))
+#define float16_is_neg_nan(X) (float16_is_any_nan(X) && float16_is_neg(X))
+
+uint32_t qf_max_sf(uint32_t a1, uint32_t a2, float_status *fp_status)
+{
+    float32 f1 = make_float32(a1);
+    float32 f2 = make_float32(a2);
+    if (float32_is_pos_nan(f1) || float32_is_neg_nan(f2)) {
+        return a1;
+    }
+    if (float32_is_pos_nan(f2) || float32_is_neg_nan(f1)) {
+        return a2;
+    }
+    return fp_max_sf(a1, a2, fp_status);
+}
+
+uint32_t qf_min_sf(uint32_t a1, uint32_t a2, float_status *fp_status)
+{
+    float32 f1 = make_float32(a1);
+    float32 f2 = make_float32(a2);
+    if (float32_is_pos_nan(f1) || float32_is_neg_nan(f2)) {
+        return a2;
+    }
+    if (float32_is_pos_nan(f2) || float32_is_neg_nan(f1)) {
+        return a1;
+    }
+    return fp_min_sf(a1, a2, fp_status);
+}
+
+uint16_t qf_max_hf(uint16_t a1, uint16_t a2, float_status *fp_status)
+{
+    float16 f1 = make_float16(a1);
+    float16 f2 = make_float16(a2);
+    if (float16_is_pos_nan(f1) || float16_is_neg_nan(f2)) {
+        return a1;
+    }
+    if (float16_is_pos_nan(f2) || float16_is_neg_nan(f1)) {
+        return a2;
+    }
+    return fp_max_hf(a1, a2, fp_status);
+}
+
+uint16_t qf_min_hf(uint16_t a1, uint16_t a2, float_status *fp_status)
+{
+    float16 f1 = make_float16(a1);
+    float16 f2 = make_float16(a2);
+    if (float16_is_pos_nan(f1) || float16_is_neg_nan(f2)) {
+        return a2;
+    }
+    if (float16_is_pos_nan(f2) || float16_is_neg_nan(f1)) {
+        return a1;
+    }
+    return fp_min_hf(a1, a2, fp_status);
+}
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
index e800cda317..19135853d4 100644
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
@@ -2992,6 +2994,38 @@ ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vsub_sf_hf,
     VddV.v[0].sf[i] = fp_sub_sf_hf(VuV.hf[2*i], VvV.hf[2*i], &env->hvx_fp_status);
     VddV.v[1].sf[i] = fp_sub_sf_hf(VuV.hf[2*i+1], VvV.hf[2*i+1], &env->hvx_fp_status))
 
+#define ITERATOR_INSN_IEEE_FP_16_32_LATE(WIDTH,TAG,SYNTAX,DESCR,CODE) \
+EXTINSN(V6_##TAG, SYNTAX, \
+        ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX,A_HVX_IEEE_FP_OUT_16,A_HVX_IEEE_FP_OUT_32), \
+        DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
+
+/* IEEE FP min/max instructions */
+ITERATOR_INSN_IEEE_FP_16_32_LATE(16, vfmin_hf, "Vd32.hf=vfmin(Vu32.hf,Vv32.hf)", \
+    "Vector IEEE min: hf",  VdV.hf[i] = fp_min_hf(VuV.hf[i], VvV.hf[i], \
+	&env->hvx_fp_status))
+ITERATOR_INSN_IEEE_FP_16_32_LATE(32, vfmin_sf, "Vd32.sf=vfmin(Vu32.sf,Vv32.sf)", \
+    "Vector IEEE min: sf",  VdV.sf[i] = fp_min_sf(VuV.sf[i], VvV.sf[i], \
+	&env->hvx_fp_status))
+ITERATOR_INSN_IEEE_FP_16_32_LATE(16, vfmax_hf,  "Vd32.hf=vfmax(Vu32.hf,Vv32.hf)", \
+    "Vector IEEE max: hf", VdV.hf[i] = fp_max_hf(VuV.hf[i], VvV.hf[i], \
+	&env->hvx_fp_status))
+ITERATOR_INSN_IEEE_FP_16_32_LATE(32, vfmax_sf,  "Vd32.sf=vfmax(Vu32.sf,Vv32.sf)", \
+    "Vector IEEE max: sf", VdV.sf[i] = fp_max_sf(VuV.sf[i], VvV.sf[i], \
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


