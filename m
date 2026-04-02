Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB864D39410
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 10:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Fag-0004jp-4x; Thu, 02 Apr 2026 06:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w8FaZ-0004gf-61
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:47:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w8FaV-0007oT-MT
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:47:50 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6326w5KS4010110
 for <qemu-devel@nongnu.org>; Thu, 2 Apr 2026 10:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3PB+fajE6hK
 x1JiZo+b7XWJ8ECYSiC+34vAh9YpHzhg=; b=ghgO341La5i62AjSVT9JlP4jmCx
 zCyK1m+E6ewZOdwmZ1H+LPGlSGgBDC2xEcl0tUuQdVDqvC8nmw0tkxNhnhZMNqRQ
 osF2GaS686+WpB3IzvQfhzGN00z4XKYovK9LaLP7njylcbhhIfSJM3L0VXlcxXnT
 GlSYVgnxUJIY6VPzDmtHGBP/l3AFw3bCaos7MP9xrIqou1FqXT79Bhc/rw6CA+69
 QB+3Mnr53S65eH4jkZ/W830lV6cJGpaW3aKm/ALSif1iIWR3GZr0zZhNYcI/HLBJ
 qp5ed+u7OsYQZhisLtDJ/cDGuL93xRx2R467n4E5pxqKpLsZSnxGGMfoMcw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d97e03jy0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 10:47:46 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2bdf75bc88fso825521eec.0
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 03:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775126865; x=1775731665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3PB+fajE6hKx1JiZo+b7XWJ8ECYSiC+34vAh9YpHzhg=;
 b=OxCCGJkvFpUN751NwQ2AF3pE2X/hejDw43lN+4MTHrsvzVvxxOOxam+YsRqbEDyYmR
 h0hY0FTLm2py2wAAYMVR2kHdNxFFPm1qqahUQctNcW/QxaZBL3DfR9vRZH2nL5BPBEoc
 6ApAzJ7FS+9CY5NX5zCsL42jKSw3WRX9S12qi4G84cezV+gJ6rNOzRKAW6WpzuOEfx3a
 G/CHbRMX/cqHqQBWpIQ48O0pInjThkMQDCB4Ac/R1dTNgTIu1tRgnEbN2fRXpbZBCogN
 0b6+1f05EdhW4JxFtILbVoHd/rWvDs/+GKcvktxAGszLKTT82TK7/iRL/hElqTA4/QVb
 1vaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775126865; x=1775731665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3PB+fajE6hKx1JiZo+b7XWJ8ECYSiC+34vAh9YpHzhg=;
 b=cFTvHY0oAyJPpSnNdSYbBLt4tuB06iF1s3Qmom7hSdhayjS3xHj3DqS6n4gRAbL4aN
 nVuCmSPTDUSuLavwGnblDnb9yeuA5OwphADUuf5YXGqwMj8uDWAYQwB2e8aYn6V/FH8m
 TuiXjUx9n9VNtGUrRPK3OGhygwz68zywr/M6wwDQaTQ0UiqrOvr+VTwI2QozKCk9hSYj
 oWulgTSFeDA2mgKt2AP+jUXimxi4IwxZz7iBUGTIGNNFb51a4MkcTBPjdEaTbPbNrzMw
 o9rhKuva7vlL6yehVoY7SKkX866AT3TaVWQaYUDeVjtkbNWi8XZrNsIr5KOKIgA8cVSf
 i/kQ==
X-Gm-Message-State: AOJu0YwdOU3NqYIbGHEY3uPbt8bTy170krFFZst2TId+4bMSab9nXc5S
 K7rELMvUYyiuAX0V6SiN8YzNr02+OkI1L+OmXA0TVvN/5IVtQe4covfM9uKxFi/BjjI57L5eC4D
 gXXmaWa/ywL+fmLGy9qrMLB8AGS793TaPWzhBz5urwp7Gng7+8bWyqG9SHkllHPLrk8t3
X-Gm-Gg: ATEYQzxNBJBG/mj0YZcOhA7DPblScuCaXQyl1usyN+IsPgtg6FZj1JY2KxGki46HMgL
 tw6UZ2EbIV5cfNZjCBVeSwwjMi95gmVpKpUFofuBPIkofz/4Jw9eQc+VieApXOflbWXwpWV3H0O
 +9hGQ03liKbZrawW0FeTElBiO5ZC6hCO252lX0lyypkYbdFLsfgYeNWB4m4CV27TReOgefjO+j9
 /fMDuCqeD3jPfCEtv3fBKdj5wR156RXkmPu2+6hn+Y6KkK3jhuIFFZ+gJTJh+PdjTfbPULifVJ0
 jUMf74bcPT1QWs+qU3n+0kmgxdUFhxGU8MRFO6zG1vN7MlZ+g1kc2RCRFp6lNZMqXvUDTNKwFM1
 Ab7rId7qF+PZDfIiTHV5ZCmCMxRQHINbKx9rmkmPqL3Wjy8Lcrt6HZdd/WkblRGXHf8RVmu0yvO
 uKHoBhjeRy
X-Received: by 2002:a05:7301:fa0d:b0:2c1:85a:d25d with SMTP id
 5a478bee46e88-2c930e6bc1emr3630270eec.1.1775126865181; 
 Thu, 02 Apr 2026 03:47:45 -0700 (PDT)
X-Received: by 2002:a05:7301:fa0d:b0:2c1:85a:d25d with SMTP id
 5a478bee46e88-2c930e6bc1emr3630251eec.1.1775126864614; 
 Thu, 02 Apr 2026 03:47:44 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca7d00f5easm2004783eec.29.2026.04.02.03.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 03:47:44 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v2 09/16] target/hexagon: add v68 HVX IEEE float conversion
 insns
Date: Thu,  2 Apr 2026 03:47:26 -0700
Message-Id: <b9f7a06aedb453f9bc8df21d42f5026472ffbc26.1775122853.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fdGgCkQF c=1 sm=1 tr=0 ts=69ce4952 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=0QsP6ROi4U8MYujRKJUA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: OZlH77gEeTFi41fSFZWzM5CudxbZFM42
X-Proofpoint-GUID: OZlH77gEeTFi41fSFZWzM5CudxbZFM42
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA5NyBTYWx0ZWRfX8/ByERKflPEx
 15smUxWMVFPHItj8Uzzvv+glQjxWSyG3d2AzWWSeC5yCR73thI746AEsuX/VtUkgOHLaISUSARC
 ZmXCklSPydPg2cx7Z0JX/RqePKrUXP37MlRpxPRe54lMveapjov8yYdgu27ouHqkYvBt9e4yBQI
 i7Mg32r+s8Irq0in4UmtCjMBEZxbIRh1JFXHSC18llCHsdVLMGaWkMIE54x2zp3C6X3cgidBr3F
 cc2RMw+iPJ1pVOIt1LC6aZXqnqD01pTsbmjCfCmK8MdJTWSQPhGzPkCsDBg/UKnSMmarvu3ZYOP
 tz3vcjLeuO8Nr15TgQodYtDORrJoRMMrD894y2im/sfaqAWBhk5AkPzJpS/kwP+hOkAGIvzRel6
 xYxwPSUJ6sqzXagvq8jMpQ9mtJj/Y9ViXtwaxl4d+CBZH12rqP72K6ndMmm9q0HPO28HeW1ItQ+
 IZvpvU/+QxzReghWVCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

Add HVX IEEE floating-point conversion instructions:
- vconv_hf_h, vconv_h_hf, vconv_sf_w, vconv_w_sf: vconv operations
- vcvt_hf_sf, vcvt_sf_hf: float <-> half float conversions
- vcvt_hf_b, vcvt_hf_h, vcvt_hf_ub, vcvt_hf_uh: int to half float
- vcvt_b_hf, vcvt_h_hf, vcvt_ub_hf, vcvt_uh_hf: half float to int

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/mmvec/hvx_ieee_fp.h           | 21 +++++
 target/hexagon/mmvec/hvx_ieee_fp.c           | 88 ++++++++++++++++++
 target/hexagon/imported/mmvec/encode_ext.def | 18 ++++
 target/hexagon/imported/mmvec/ext.idef       | 97 ++++++++++++++++++++
 4 files changed, 224 insertions(+)

diff --git a/target/hexagon/mmvec/hvx_ieee_fp.h b/target/hexagon/mmvec/hvx_ieee_fp.h
index f4801e3be9..e73f8161b1 100644
--- a/target/hexagon/mmvec/hvx_ieee_fp.h
+++ b/target/hexagon/mmvec/hvx_ieee_fp.h
@@ -56,4 +56,25 @@ uint32_t qf_min_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
 uint16_t qf_max_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
 uint16_t qf_min_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
 
+/*
+ * IEEE - FP Convert instructions
+ */
+uint16_t f32_to_f16(uint32_t a, float_status *fp_status);
+uint32_t f16_to_f32(uint16_t a, float_status *fp_status);
+
+uint16_t f16_to_uh(uint16_t op1, float_status *fp_status);
+int16_t  f16_to_h(uint16_t op1, float_status *fp_status);
+uint8_t  f16_to_ub(uint16_t op1, float_status *fp_status);
+int8_t   f16_to_b(uint16_t op1, float_status *fp_status);
+
+uint16_t uh_to_f16(uint16_t op1);
+uint16_t h_to_f16(int16_t op1);
+uint16_t ub_to_f16(uint8_t op1);
+uint16_t b_to_f16(int8_t op1);
+
+int32_t conv_sf_w(int32_t a, float_status *fp_status);
+int16_t conv_hf_h(int16_t a, float_status *fp_status);
+int32_t conv_w_sf(uint32_t a, float_status *fp_status);
+int16_t conv_h_hf(uint16_t a, float_status *fp_status);
+
 #endif
diff --git a/target/hexagon/mmvec/hvx_ieee_fp.c b/target/hexagon/mmvec/hvx_ieee_fp.c
index 086e8dd29e..d39a883ab7 100644
--- a/target/hexagon/mmvec/hvx_ieee_fp.c
+++ b/target/hexagon/mmvec/hvx_ieee_fp.c
@@ -129,3 +129,91 @@ uint16_t qf_min_hf(uint16_t a1, uint16_t a2, float_status *fp_status)
     }
     return fp_min_hf(a1, a2, fp_status);
 }
+
+uint16_t f32_to_f16(uint32_t a, float_status *fp_status)
+{
+    return float16_val(float32_to_float16(make_float32(a), true, fp_status));
+}
+
+uint32_t f16_to_f32(uint16_t a, float_status *fp_status)
+{
+    return float32_val(float16_to_float32(make_float16(a), true, fp_status));
+}
+
+uint16_t f16_to_uh(uint16_t op1, float_status *fp_status)
+{
+    return float16_to_uint16_scalbn(make_float16(op1),
+                                    float_round_nearest_even,
+                                    0, fp_status);
+}
+
+int16_t f16_to_h(uint16_t op1, float_status *fp_status)
+{
+    return float16_to_int16_scalbn(make_float16(op1),
+                                   float_round_nearest_even,
+                                   0, fp_status);
+}
+
+uint8_t f16_to_ub(uint16_t op1, float_status *fp_status)
+{
+    return float16_to_uint8_scalbn(make_float16(op1),
+                                   float_round_nearest_even,
+                                   0, fp_status);
+}
+
+int8_t f16_to_b(uint16_t op1, float_status *fp_status)
+{
+    return float16_to_int8_scalbn(make_float16(op1),
+                                   float_round_nearest_even,
+                                   0, fp_status);
+}
+
+uint16_t uh_to_f16(uint16_t op1)
+{
+    return uint64_to_float16_scalbn(op1, float_round_nearest_even, 0);
+}
+
+uint16_t h_to_f16(int16_t op1)
+{
+    return int64_to_float16_scalbn(op1, float_round_nearest_even, 0);
+}
+
+uint16_t ub_to_f16(uint8_t op1)
+{
+    return uint64_to_float16_scalbn(op1, float_round_nearest_even, 0);
+}
+
+uint16_t b_to_f16(int8_t op1)
+{
+    return int64_to_float16_scalbn(op1, float_round_nearest_even, 0);
+}
+
+int32_t conv_sf_w(int32_t a, float_status *fp_status)
+{
+    return float32_val(int32_to_float32(a, fp_status));
+}
+
+int16_t conv_hf_h(int16_t a, float_status *fp_status)
+{
+    return float16_val(int16_to_float16(a, fp_status));
+}
+
+int32_t conv_w_sf(uint32_t a, float_status *fp_status)
+{
+    float32 f1 = make_float32(a);
+    /* float32_to_int32 converts any NaN to MAX, hexagon looks at the sign. */
+    if (float32_is_any_nan(f1)) {
+        return float32_is_neg(f1) ? INT32_MIN : INT32_MAX;
+    }
+    return float32_to_int32_round_to_zero(f1, fp_status);
+}
+
+int16_t conv_h_hf(uint16_t a, float_status *fp_status)
+{
+    float16 f1 = make_float16(a);
+    /* float16_to_int16 converts any NaN to MAX, hexagon looks at the sign. */
+    if (float16_is_any_nan(f1)) {
+        return float16_is_neg(f1) ? INT16_MIN : INT16_MAX;
+    }
+    return float16_to_int16_round_to_zero(f1, fp_status);
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
index 54bed47083..6d5bab0894 100644
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
@@ -3038,6 +3041,100 @@ ITERATOR_INSN_IEEE_FP_16_32_LATE(16, vabs_hf,  "Vd32.hf=vabs(Vu32.hf)", \
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
+    VddV.v[0].hf[2*i]   = ub_to_f16(VuV.ub[4*i]);
+    VddV.v[0].hf[2*i+1] = ub_to_f16(VuV.ub[4*i+1]);
+    VddV.v[1].hf[2*i]   = ub_to_f16(VuV.ub[4*i+2]);
+    VddV.v[1].hf[2*i+1] = ub_to_f16(VuV.ub[4*i+3]))
+
+ITERATOR_INSN_IEEE_FP_DOUBLE_16(32,  vcvt_hf_b,  "Vdd32.hf=vcvt(Vu32.b)",
+    "Vector IEEE cvt from int: b widen to hf",
+    VddV.v[0].hf[2*i]   = b_to_f16(VuV.b[4*i]);
+    VddV.v[0].hf[2*i+1] = b_to_f16(VuV.b[4*i+1]);
+    VddV.v[1].hf[2*i]   = b_to_f16(VuV.b[4*i+2]);
+    VddV.v[1].hf[2*i+1] = b_to_f16(VuV.b[4*i+3]))
+
+ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vcvt_sf_hf, "Vdd32.sf=vcvt(Vu32.hf)",
+    "Vector IEEE cvt: hf widen to sf",
+    VddV.v[0].sf[i] = f16_to_f32(VuV.hf[2*i], &env->hvx_fp_status);
+    VddV.v[1].sf[i] = f16_to_f32(VuV.hf[2*i+1], &env->hvx_fp_status))
+
+ITERATOR_INSN_IEEE_FP_16(16,    vcvt_hf_uh, "Vd32.hf=vcvt(Vu32.uh)",
+    "Vector IEEE cvt from int: uh to hf",
+    VdV.hf[i] = uh_to_f16(VuV.uh[i]))
+ITERATOR_INSN_IEEE_FP_16(16,    vcvt_hf_h,  "Vd32.hf=vcvt(Vu32.h)",
+    "Vector IEEE cvt from int: h to hf",
+    VdV.hf[i] = h_to_f16(VuV.h[i]))
+ITERATOR_INSN_IEEE_FP_16_32(16, vcvt_uh_hf, "Vd32.uh=vcvt(Vu32.hf)",
+    "Vector IEEE cvt to int: hf to uh",
+    VdV.uh[i] = f16_to_uh(VuV.hf[i], &env->hvx_fp_status))
+ITERATOR_INSN_IEEE_FP_16_32(16, vcvt_h_hf,  "Vd32.h=vcvt(Vu32.hf)",
+    "Vector IEEE cvt to int: hf to h",
+    VdV.h[i]  = f16_to_h(VuV.hf[i], &env->hvx_fp_status))
+
+ITERATOR_INSN_IEEE_FP_16(32, vcvt_hf_sf, "Vd32.hf=vcvt(Vu32.sf,Vv32.sf)",
+    "Vector IEEE cvt: sf to hf",
+    VdV.hf[2*i]   = f32_to_f16(VuV.sf[i], &env->hvx_fp_status);
+    VdV.hf[2*i+1] = f32_to_f16(VvV.sf[i], &env->hvx_fp_status))
+
+ITERATOR_INSN_IEEE_FP_16_32(32, vcvt_ub_hf, "Vd32.ub=vcvt(Vu32.hf,Vv32.hf)", "Vector cvt to int: hf narrow to ub",
+    VdV.ub[4*i]   = f16_to_ub(VuV.hf[2*i], &env->hvx_fp_status);
+    VdV.ub[4*i+1] = f16_to_ub(VuV.hf[2*i+1], &env->hvx_fp_status);
+    VdV.ub[4*i+2] = f16_to_ub(VvV.hf[2*i], &env->hvx_fp_status);
+    VdV.ub[4*i+3] = f16_to_ub(VvV.hf[2*i+1], &env->hvx_fp_status))
+
+ITERATOR_INSN_IEEE_FP_16_32(32, vcvt_b_hf,  "Vd32.b=vcvt(Vu32.hf,Vv32.hf)",
+    "Vector cvt to int: hf narrow to b",
+    VdV.b[4*i]   = f16_to_b(VuV.hf[2*i], &env->hvx_fp_status);
+    VdV.b[4*i+1] = f16_to_b(VuV.hf[2*i+1], &env->hvx_fp_status);
+    VdV.b[4*i+2] = f16_to_b(VvV.hf[2*i], &env->hvx_fp_status);
+    VdV.b[4*i+3] = f16_to_b(VvV.hf[2*i+1], &env->hvx_fp_status))
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
+    VdV.sf[i] = conv_sf_w(VuV.w[i], &env->hvx_fp_status))
+
+ITERATOR_INSN_SHIFT_SLOT_FLT(16, vconv_hf_h,"Vd32.hf=Vu32.h",
+    "Vector conversion of int hw format to hf16",
+    VdV.hf[i] = conv_hf_h(VuV.h[i], &env->hvx_fp_status))
+
 /******************************************************************************
  DEBUG Vector/Register Printing
  ******************************************************************************/
-- 
2.37.2


