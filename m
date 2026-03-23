Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD509F46100
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4f8b-0000GO-CG; Mon, 23 Mar 2026 09:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w4f8W-0000Fo-D9
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:16:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w4f8T-0000Lw-Ve
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:16:04 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NADws93539916
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 13:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=egwQItMyVGs
 47MWCx12tDbJndnZBPbX1svAKzwwW5t8=; b=It58Fgya293aP4ADibzKL9+d06H
 nhUwfXCcCbq1leALkgq9ctPY5OphCSwJ0HHrqDbJVrKOY/Ju07813dRVHD6w2sRj
 lvmU0wbB+cvcFervYfXRfVFhKaJ5vp07aFzFF+4tMUXG2Jl7Kh6yIZiY2PI/g9OY
 CoD9DxHx9EvSx1QNzNX7i/tcMuiURfq42FjVtMrWjkuLwH+BDNAhx3J1SVhW6+Lo
 T0BMkJuL/jPdRMwmjajqIuNUert4aS5K+yb1lyZ7G6kaeewCu0B4NpILMKRGH8vs
 I2e/ZhbkmElkusbCXQR+sO4ZBr6Yz8uwJ9+UX91OiUEhf/zXPEm7cU489iQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d33k30ju8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 13:16:00 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2c0f6593ef5so2705606eec.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 06:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774271760; x=1774876560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=egwQItMyVGs47MWCx12tDbJndnZBPbX1svAKzwwW5t8=;
 b=TTf2ExgeWK0NyCoiINO2KiYa0zcr/53KoKOrLFBUt0SXumEtK7IC1RY87VhP0h81+L
 /TAQ9LueZp5Chk1rHh3LB6hRZe9yIE6u0cj+Wb1BRhUH5fdM4u6HtZI/btlkC03B+oiI
 FxSbvk5b3PTIejaObwgnCPBIffb6vh77iLEVP5Ac3iW0CkQ1dqcvZU5GIzSNjsqbdkzF
 EO623zp4Z11uFJXw8L8R2bymXv36L45+J0wMiX3b4z++Up0vLcyW01OSX/+V4I60lsYG
 qqst7HtxgfxmnIKv3KtiP5ADKcjfzIArCFiIN++wYQS/bnRpvTj55RZcpNQLtsDYNlAw
 fWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774271760; x=1774876560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=egwQItMyVGs47MWCx12tDbJndnZBPbX1svAKzwwW5t8=;
 b=mKUOQse/gH9589ax6qI56sc87QrqJaz2VN72WYQVmRQlrvPjlXRTFFmWhhL3l9Tirp
 hxzxdSZItlMKVwR1ie0R7cyTfXe5ok3+MgxNa59lCpAj1rLurkbhPlur7fUUV/IfwM9I
 NVpIGBCegeMXJ5/sPmOTVLjBETUa+C0NpCrqUwXR/v9048dEzzNzWZKO1SMkeZgO8WFd
 mlMV7qrw+qc+Oo0XD0Cs3Z2zLigZRiFf58vOVe6ptlmX5EmB2kSUbf/cFvxHvWltpUuu
 z46QqcP+QuUTNQfT01O+B+PMcKGuE+glQX8p//jdgX58wOpMtDUf2NFgDbP4sub+bT8d
 v4Qg==
X-Gm-Message-State: AOJu0YzdeMe2KH0F1SPoz8YVedHUcvMYXZAyfud4++IULUsm4P6JB9IC
 MYDrH+8XMoZTvWEnLTrhefgodcBGS5IR8WKSq7qP5VLtW3/1WZ+n6F8Uym8146QxVQ4DP+KsFwI
 0wkn9OcTuVYGd0GE+VRVYBAg7ZIw7aYZ5SMYlPpzm/91h1QDEgp1i7zjVZLFsgPwFQX9G
X-Gm-Gg: ATEYQzzC2LlwXYeirTV13O/nP9JsOo9lEUUnxc5NZnxJIoG4U+cen4l28trmj8x8keL
 IwhDh33828drXxV9hF4Jus6WvOzs4bZCOm6+9hhDAbldI+doeEoCpfXNrXLitZLg6lH0B7Qiurm
 8U3Jv3zBCzhn/6l8EK2XdcIDL6fga73aAiZ3kF2tRstjSOihdn5AmM3qewXAMmOGjR5j8qL2pSb
 r5yl/I/Dh9GV3s+Lm26mlIjJgtGbKA/AoZ6Vycn/RawCb5gpUM8IeEXK0+QVovx3txxhsb9CusN
 KpL4NMaFQBz0/NogMTQbbX8yqY1l0HOJ3ThyeGu2lexz8QhskfP/0u17riXBpNyiWj8KpSs4KFU
 fahg8Cs7BTUhBPGb4GhBWdA0LXQCjf5ClO1pBvS5M07EZobclWRF83TFmabUKEVNbMYsajRT07H
 VEpsBths/F
X-Received: by 2002:a05:7300:a883:b0:2c0:d9e6:7eb3 with SMTP id
 5a478bee46e88-2c109728272mr4578581eec.23.1774271759364; 
 Mon, 23 Mar 2026 06:15:59 -0700 (PDT)
X-Received: by 2002:a05:7300:a883:b0:2c0:d9e6:7eb3 with SMTP id
 5a478bee46e88-2c109728272mr4578567eec.23.1774271758508; 
 Mon, 23 Mar 2026 06:15:58 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b14cadbsm14702574eec.3.2026.03.23.06.15.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 06:15:58 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com, marco.liebel@oss.qualcomm.com,
 philmd@linaro.org, quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH 07/13] target/hexagon: add v68 HVX IEEE float conversion insns
Date: Mon, 23 Mar 2026 06:15:43 -0700
Message-Id: <b648b6b7ce4b4c1ab3bc00016d9233a5ede3563b.1774271525.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CYYFJbrl c=1 sm=1 tr=0 ts=69c13d10 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=0QsP6ROi4U8MYujRKJUA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEwMyBTYWx0ZWRfX8p8zzU6ZyfEX
 lEzWdzeFmBcmoioujuwhWDOsU2JY2Oe5mAIm0oPRyCjGAEvwQ4hhLfCsMAeFPqmMTdZhypizGOt
 ta78nb5sBCZ0l8CpzJTcvF0h4pZytvPWSmA6xDJLOlmceSIWo3wqp+j4ob3EdyNcfWQMtJETScV
 62lsJHXHtoUVZTyPI0AgXdFioljrnj5aes4xeJEMmaz2nYkZr6kyFZfyh7AHKwppnrqzvsa7Fdh
 i45hMuO3QDDN1QwetvT14aMouuc0TakcKMVRNSbd/sy998JA+pqb5EGeeFyCBlpk04rbBIgrj9Z
 75tVNZxbG5bu8r6ra5UY5byP22sGzQo2YBv2lDfOFn8IAgVNpewHBbgednHqq4hTCtcC9wKrzGd
 V2073UdYDwO+xRpEOh9kz/4NJraAxX1dPO1Iw/6Jd5Tg8H4CyiW1ZAox1ZFL9tH/6AMDMyCizum
 JFmvvhNUBSQcrmm8chg==
X-Proofpoint-GUID: eMBl-882mHkw5h-_u2cn2I9X5tFs2Jo7
X-Proofpoint-ORIG-GUID: eMBl-882mHkw5h-_u2cn2I9X5tFs2Jo7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230103
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
 target/hexagon/mmvec/kvx_ieee.h              | 21 +++++
 target/hexagon/mmvec/kvx_ieee.c              | 98 ++++++++++++++++++++
 target/hexagon/imported/mmvec/encode_ext.def | 18 ++++
 target/hexagon/imported/mmvec/ext.idef       | 97 +++++++++++++++++++
 4 files changed, 234 insertions(+)

diff --git a/target/hexagon/mmvec/kvx_ieee.h b/target/hexagon/mmvec/kvx_ieee.h
index 263feb7e94..8a6816f6b3 100644
--- a/target/hexagon/mmvec/kvx_ieee.h
+++ b/target/hexagon/mmvec/kvx_ieee.h
@@ -59,4 +59,25 @@ uint32_t qf_min_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
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
diff --git a/target/hexagon/mmvec/kvx_ieee.c b/target/hexagon/mmvec/kvx_ieee.c
index 33621a15f3..bbeec09707 100644
--- a/target/hexagon/mmvec/kvx_ieee.c
+++ b/target/hexagon/mmvec/kvx_ieee.c
@@ -131,3 +131,101 @@ uint16_t qf_min_hf(uint16_t a1, uint16_t a2, float_status *fp_status)
     if (float16_is_pos_nan(f2) || float16_is_neg_nan(f1)) return a1;
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
+    float_status scratch_fpst = {};
+    const float32 W_MAX = int32_to_float32(INT32_MAX, &scratch_fpst);
+    const float32 W_MIN = int32_to_float32(INT32_MIN, &scratch_fpst);
+    float32 f1 = make_float32(a);
+
+    if (float32_is_any_nan(f1) || float32_is_infinity(f1) ||
+        float32_le_quiet(W_MAX, f1, fp_status) ||
+        float32_le_quiet(f1, W_MIN, fp_status)) {
+        return float32_is_neg(f1) ? INT32_MIN : INT32_MAX;
+    }
+    return float32_to_int32_round_to_zero(f1, fp_status);
+}
+
+int16_t conv_h_hf(uint16_t a, float_status *fp_status)
+{
+    float_status scratch_fpst = {};
+    const float16 H_MAX = int16_to_float16(INT16_MAX, &scratch_fpst);
+    const float16 H_MIN = int16_to_float16(INT16_MIN, &scratch_fpst);
+    float16 f1 = make_float16(a);
+
+    if (float16_is_any_nan(f1) || float16_is_infinity(f1) ||
+        float16_le_quiet(H_MAX, f1, fp_status) ||
+        float16_le_quiet(f1, H_MIN, fp_status)) {
+        return float16_is_neg(f1) ? INT16_MIN : INT16_MAX;
+    }
+    return float16_to_int16_round_to_zero(f1, fp_status);
+}
diff --git a/target/hexagon/imported/mmvec/encode_ext.def b/target/hexagon/imported/mmvec/encode_ext.def
index 7138e593dd..5325bbd704 100644
--- a/target/hexagon/imported/mmvec/encode_ext.def
+++ b/target/hexagon/imported/mmvec/encode_ext.def
@@ -841,4 +841,22 @@ DEF_ENC(V6_vfneg_sf,"00011110--0-0110PP1uuuuu011ddddd")
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
index 5ef5baa404..8b832166e0 100644
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
@@ -3032,6 +3035,100 @@ ITERATOR_INSN_IEEE_FP_16_32_LATE(32, vabs_sf,  "Vd32.sf=vabs(Vu32.sf)", \
     "Vector IEEE abs: sf", \
     VdV.sf[i] = ((signF32UI(VuV.sf[i])) ? (VuV.sf[i] ^ 0x80000000) : VuV.sf[i]))
 
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
+    VddV.v[0].sf[i] = f16_to_f32(VuV.hf[2*i], &env->fp_status);
+    VddV.v[1].sf[i] = f16_to_f32(VuV.hf[2*i+1], &env->fp_status))
+
+ITERATOR_INSN_IEEE_FP_16(16,    vcvt_hf_uh, "Vd32.hf=vcvt(Vu32.uh)",
+    "Vector IEEE cvt from int: uh to hf",
+    VdV.hf[i] = uh_to_f16(VuV.uh[i]))
+ITERATOR_INSN_IEEE_FP_16(16,    vcvt_hf_h,  "Vd32.hf=vcvt(Vu32.h)",
+    "Vector IEEE cvt from int: h to hf",
+    VdV.hf[i] = h_to_f16(VuV.h[i]))
+ITERATOR_INSN_IEEE_FP_16_32(16, vcvt_uh_hf, "Vd32.uh=vcvt(Vu32.hf)",
+    "Vector IEEE cvt to int: hf to uh",
+    VdV.uh[i] = f16_to_uh(VuV.hf[i], &env->fp_status))
+ITERATOR_INSN_IEEE_FP_16_32(16, vcvt_h_hf,  "Vd32.h=vcvt(Vu32.hf)",
+    "Vector IEEE cvt to int: hf to h",
+    VdV.h[i]  = f16_to_h(VuV.hf[i], &env->fp_status))
+
+ITERATOR_INSN_IEEE_FP_16(32, vcvt_hf_sf, "Vd32.hf=vcvt(Vu32.sf,Vv32.sf)",
+    "Vector IEEE cvt: sf to hf",
+    VdV.hf[2*i]   = f32_to_f16(VuV.sf[i], &env->fp_status);
+    VdV.hf[2*i+1] = f32_to_f16(VvV.sf[i], &env->fp_status))
+
+ITERATOR_INSN_IEEE_FP_16_32(32, vcvt_ub_hf, "Vd32.ub=vcvt(Vu32.hf,Vv32.hf)", "Vector cvt to int: hf narrow to ub",
+    VdV.ub[4*i]   = f16_to_ub(VuV.hf[2*i], &env->fp_status);
+    VdV.ub[4*i+1] = f16_to_ub(VuV.hf[2*i+1], &env->fp_status);
+    VdV.ub[4*i+2] = f16_to_ub(VvV.hf[2*i], &env->fp_status);
+    VdV.ub[4*i+3] = f16_to_ub(VvV.hf[2*i+1], &env->fp_status))
+
+ITERATOR_INSN_IEEE_FP_16_32(32, vcvt_b_hf,  "Vd32.b=vcvt(Vu32.hf,Vv32.hf)",
+    "Vector cvt to int: hf narrow to b",
+    VdV.b[4*i]   = f16_to_b(VuV.hf[2*i], &env->fp_status);
+    VdV.b[4*i+1] = f16_to_b(VuV.hf[2*i+1], &env->fp_status);
+    VdV.b[4*i+2] = f16_to_b(VvV.hf[2*i], &env->fp_status);
+    VdV.b[4*i+3] = f16_to_b(VvV.hf[2*i+1], &env->fp_status))
+
+ITERATOR_INSN_SHIFT_SLOT_FLT(32, vconv_w_sf,"Vd32.w=Vu32.sf",
+    "Vector conversion of sf32 format to int w",
+    VdV.w[i] = conv_w_sf(VuV.sf[i], &env->fp_status))
+
+ITERATOR_INSN_SHIFT_SLOT_FLT(16, vconv_h_hf,"Vd32.h=Vu32.hf",
+    "Vector conversion of hf16 format to int hw",
+    VdV.h[i] = conv_h_hf(VuV.hf[i], &env->fp_status))
+
+ITERATOR_INSN_SHIFT_SLOT_FLT(32, vconv_sf_w,"Vd32.sf=Vu32.w",
+    "Vector conversion of int w format to sf32",
+    VdV.sf[i] = conv_sf_w(VuV.w[i], &env->fp_status))
+
+ITERATOR_INSN_SHIFT_SLOT_FLT(16, vconv_hf_h,"Vd32.hf=Vu32.h",
+    "Vector conversion of int hw format to hf16",
+    VdV.hf[i] = conv_hf_h(VuV.h[i], &env->fp_status))
+
 /******************************************************************************
  DEBUG Vector/Register Printing
  ******************************************************************************/
-- 
2.37.2


