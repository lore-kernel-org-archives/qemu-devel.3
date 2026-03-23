Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494F0F46101
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4f8h-0000HZ-CG; Mon, 23 Mar 2026 09:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w4f8Y-0000G3-Nb
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:16:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w4f8W-0000MN-7K
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:16:06 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NCegDN2475971
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 13:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=nncu3t7ihMb
 7k526f+gk25Y9drXeyPy+eVtfolGEQOM=; b=kFkeM25JRT2dMhR7iLhtKbpUTNS
 IMEyPBwO69lzTL9+RgKQ4s2Zb51JG+7IBgySlJ2snBscafWuw4XPFCLKGe+8ozEO
 oEjHQDJyfD4xKRfpK1a7gyFtqcwaFvjsOastbYZIO3hu5GG5ZPZwQ3twecO5fu5R
 uX4uzjBmJSp2rOeK2HVyh8dkglyiJU/7qmUDbFrAwEd5Abijhh+uEIt47tNUkCvK
 0FmD9AIwKc+CPd/1gObVVEXFXor7kApVnx+YRRzi1NE0o+ydoss76S6GM8raorq9
 PWrNFMVpUvhXqf8n6vEvq13SEmKz5W15BT9LOxwWyS+iYFlVfm8MD2lYD/A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d35r203fj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 13:16:03 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2c0e264d802so12704842eec.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 06:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774271762; x=1774876562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nncu3t7ihMb7k526f+gk25Y9drXeyPy+eVtfolGEQOM=;
 b=PJkkME8HRXB6Z0ZHyVThVTTjk9xfDqoHe9WQkpp86gx5XYwUMm1NStx/Z9bXCsw3c7
 v2999lmOZI5bDrVphTD0YtnoAxYc5MCgphOTFsyoQq8k2HRQH9gyBeVzlRtrKXa22Mcb
 oMoSBvmDltJLizVtriY/wyyJ5kDNhB2bDFPn5bB6hv5ZqCY3N8Xhr8bpfgR1oCRS65ay
 nM/A1ykPA/RKWwvi70J0JlNyTrAgsGqdqmzZ8FFr0JKhqPdW9YyjS4VYH4c/esXyshU9
 ToWZrhfJ6//VzyF8GsGy3jOm2Enf9BdQj7otJBmowl6Am0rcdcs+7YKsVk6VkoTnQO1O
 XlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774271762; x=1774876562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nncu3t7ihMb7k526f+gk25Y9drXeyPy+eVtfolGEQOM=;
 b=HV+izYY7xBNdQthbaohNR/pyLwNvxMftfb7vqVK6svNZeWKuY9zyJpyZv/mAJVmpBv
 sm38ykkz7mRiLTifdfbR8/2od91GxVTocJpZ83yAF5CAMRHGT90MYFUoj3pXAxfjuvEg
 2x/02OcMkxPhuond0PVqOeqj4HAEKvZwPsbo2rbJuvxzCZaGBBcBa6KxeESU2LEV2Jtt
 8x8HrfSNW+mKZSwkUD6t5bpqgdzmRuKi92+dcjtmypzMezEs/dTlF//mFWbSiVmEyd5O
 /hxiUHx367LcnYzVvvfBZ47/48njoOHsjDp0HFJBABZNJCGeTc4H2mOTf7r1MIFhVGa9
 q1rQ==
X-Gm-Message-State: AOJu0YxohcQNKkby6HL+/YVP8N8hLn9sZTXxBXv1KjQjGDkBw4p3MTDL
 4TaVnuHu2A9UMLpvIUSLgIm5GsZYxtrhykzGM44mGGmLJPuTCsi939bJOY1nAISFBQHEHAXcYuU
 p9ESSWjHH+SHVWnhSm8OMfusCkyAVE/cpuTQEcrrughys5H5GbgGKUpsdMsivj2x5I1D+
X-Gm-Gg: ATEYQzzYw+VEQ5ZopMv1qytSKFKT11AxoAqQPtPxvO8TBJNiYv1S7ehLX4lc72bmh/s
 Dr02+12px3JYlAHIoTe62xqdzf79j6xJ9i8hrkSYq7KulBe0m3FBzvEuwhlG2UlnRRVrGwtldbf
 5hkOhtFfBdXhm8daTDZA3myXKn3FznnEcNQlEhJV9khLOBX8qWTqnq+MLQFMHnWSN50OXIVnqBX
 LhDwjuqXmxVzOMk+vTmBaIpqT3SV6zInm3aHmL2TiO+pDJY2koqln7HGKD7Cc3zO0fH6MPfMKd0
 wCplBfu0rDR5u4k4sJTxiCoxQBKYFs9jo3rxuYZKVy+/BkOzWp0QCmN5q4uV2XDcp0EWCcNdAfm
 T+N9U14GVXns9lntXemIwu7lSDAWZxeeKFmwHKwq/GSYBpxj2/M7R2q/QX3DaVGNDEAGPfIuvGk
 bEC9XbCUmy
X-Received: by 2002:a05:7300:5707:b0:2c0:d690:7b9 with SMTP id
 5a478bee46e88-2c10970eb6dmr6179315eec.22.1774271761648; 
 Mon, 23 Mar 2026 06:16:01 -0700 (PDT)
X-Received: by 2002:a05:7300:5707:b0:2c0:d690:7b9 with SMTP id
 5a478bee46e88-2c10970eb6dmr6179296eec.22.1774271760828; 
 Mon, 23 Mar 2026 06:16:00 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b14cadbsm14702574eec.3.2026.03.23.06.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 06:16:00 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com, marco.liebel@oss.qualcomm.com,
 philmd@linaro.org, quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH 09/13] target/hexagon: add v73 HVX IEEE bfloat16 insns
Date: Mon, 23 Mar 2026 06:15:45 -0700
Message-Id: <003328f47c0b5e286ef06ba55cc9734e7bba4af8.1774271525.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VvUuwu2n c=1 sm=1 tr=0 ts=69c13d13 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=RUNPfk55iMBok5ld-isA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: JiWAiCRp6bUnp3JuSlXFpdSNMLBvUBW6
X-Proofpoint-ORIG-GUID: JiWAiCRp6bUnp3JuSlXFpdSNMLBvUBW6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEwMyBTYWx0ZWRfX4LyEJl6y6zUd
 3cIJ+/Fn6YV9JvV3oIQmooNuIkPqdD9QyNSLTLmKmpFaVnHz1RZ3PKWg3SdWO61X/0GqvnLRPVy
 cwqJZ0XjdnyUZjOIYymYGenbdhSr5e/ISm2jFxJbYXkjtJ95qeAayM1Nj1cr6XPZQi/VSz5QETE
 CZ2UDiP/TDXYY7EAjeQipkVkSZmLiL15TIW7rG/qMXhKbWqUogjeoGnSgyk9QGMZddiVYYCZC9N
 GmklFqga4j4D8RKVLGs8E9xVeAvyw/S2yx6bE7XhW3LDAMWxnfeEG8g4wnnFxNuw6z+A2yZHH2e
 Y0RTXHQyKQzeEPYmB1oKvfTHYMytC8mG5qddzxp0Pz6hwOPCN2JX5whGnk0YNh244T/kaDz+pOS
 QVJ5jmy7dizVoZprMNnYmxOxXj06f0/MSITq/jerOxs/1qvzTCpjevtgSFZ8oRvRV3oHbBjckkb
 Vm9fQsA2gAGITRNolHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
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
 target/hexagon/mmvec/kvx_ieee.h              | 36 +++++++++++
 target/hexagon/mmvec/macros.h                |  5 ++
 target/hexagon/mmvec/mmvec.h                 |  1 +
 target/hexagon/mmvec/kvx_ieee.c              |  3 +
 target/hexagon/imported/mmvec/encode_ext.def | 15 +++++
 target/hexagon/imported/mmvec/ext.idef       | 64 ++++++++++++++++++++
 6 files changed, 124 insertions(+)

diff --git a/target/hexagon/mmvec/kvx_ieee.h b/target/hexagon/mmvec/kvx_ieee.h
index 8a6816f6b3..eb670d4ec3 100644
--- a/target/hexagon/mmvec/kvx_ieee.h
+++ b/target/hexagon/mmvec/kvx_ieee.h
@@ -80,4 +80,40 @@ int16_t conv_hf_h(int16_t a, float_status *fp_status);
 int32_t conv_w_sf(uint32_t a, float_status *fp_status);
 int16_t conv_h_hf(uint16_t a, float_status *fp_status);
 
+/* IEEE BFloat instructions */
+
+#define fp_mult_sf_bf(A, B) \
+    fp_mult_sf_sf(((uint32_t)(A)) << 16, ((uint32_t)(B)) << 16, &env->fp_status)
+#define fp_add_sf_bf(A, B) \
+    fp_add_sf_sf(((uint32_t)(A)) << 16, ((uint32_t)(B)) << 16, &env->fp_status)
+#define fp_sub_sf_bf(A, B) \
+    fp_sub_sf_sf(((uint32_t)(A)) << 16, ((uint32_t)(B)) << 16, &env->fp_status)
+
+uint32_t fp_mult_sf_bf_acc(uint16_t op1, uint16_t op2, uint32_t acc,
+                           float_status *fp_status);
+
+#define bf_to_sf(A) (((uint32_t)(A)) << 16)
+
+#define fp_min_bf(A, B) ({ \
+    uint32_t _bf_res = fp_min_sf(bf_to_sf(A), bf_to_sf(B), &env->fp_status); \
+    (uint16_t)((_bf_res >> 16) & 0xffff); \
+})
+
+#define fp_max_bf(A, B) ({ \
+    uint32_t _bf_res = fp_max_sf(bf_to_sf(A), bf_to_sf(B), &env->fp_status); \
+    (uint16_t)((_bf_res >> 16) & 0xffff); \
+})
+
+static inline uint16_t sf_to_bf(int32_t A)
+{
+    uint32_t rslt = A;
+    if ((rslt & 0x1FFFF) == 0x08000) {
+        /* do not round up if exactly .5 and even already */
+    } else if ((rslt & 0x8000) == 0x8000) {
+        rslt += 0x8000; /* rounding to nearest number */
+    }
+    rslt = float32_is_any_nan(A) ? FP32_DEF_NAN : rslt;
+    return rslt >> 16;
+}
+
 #endif
diff --git a/target/hexagon/mmvec/macros.h b/target/hexagon/mmvec/macros.h
index c342507d1a..b70996578e 100644
--- a/target/hexagon/mmvec/macros.h
+++ b/target/hexagon/mmvec/macros.h
@@ -25,6 +25,9 @@
 #include "accel/tcg/probe.h"
 #include "mmvec/kvx_ieee.h"
 
+#define fBFLOAT()
+#define fCVI_VX_NO_TMP_LD()
+
 #ifndef QEMU_GENERATE
 #define VdV      (*(MMVector *restrict)(VdV_void))
 #define VsV      (*(MMVector *restrict)(VsV_void))
@@ -366,4 +369,6 @@
     (int16_t)(A) > (int16_t)(B) : \
     float16_compare((A), (B), &env->fp_status) == float_relation_greater)
 
+#define fCMPGT_BF(A, B) fCMPGT_SF(((int)A) << 16, ((int)B) << 16)
+
 #endif
diff --git a/target/hexagon/mmvec/mmvec.h b/target/hexagon/mmvec/mmvec.h
index eaedfe0d6d..9d8d57c7c6 100644
--- a/target/hexagon/mmvec/mmvec.h
+++ b/target/hexagon/mmvec/mmvec.h
@@ -40,6 +40,7 @@ typedef union {
     int8_t    b[MAX_VEC_SIZE_BYTES / 1];
     int32_t  sf[MAX_VEC_SIZE_BYTES / 4];   /* single float (32-bit) */
     int16_t  hf[MAX_VEC_SIZE_BYTES / 2];   /* half float (16-bit) */
+    uint16_t bf[MAX_VEC_SIZE_BYTES / 2];   /* bfloat16 */
 } MMVector;
 
 typedef union {
diff --git a/target/hexagon/mmvec/kvx_ieee.c b/target/hexagon/mmvec/kvx_ieee.c
index bbeec09707..b5c434ad6d 100644
--- a/target/hexagon/mmvec/kvx_ieee.c
+++ b/target/hexagon/mmvec/kvx_ieee.c
@@ -229,3 +229,6 @@ int16_t conv_h_hf(uint16_t a, float_status *fp_status)
     }
     return float16_to_int16_round_to_zero(f1, fp_status);
 }
+
+DEF_FP_INSN_3(mult_sf_bf_acc, 32, 16, 16, 32,
+              float32_muladd(bf_to_sf(f1), bf_to_sf(f2), f3, 0, fp_status))
diff --git a/target/hexagon/imported/mmvec/encode_ext.def b/target/hexagon/imported/mmvec/encode_ext.def
index 3f84a1691b..352a8ec14b 100644
--- a/target/hexagon/imported/mmvec/encode_ext.def
+++ b/target/hexagon/imported/mmvec/encode_ext.def
@@ -869,4 +869,19 @@ DEF_ENC(V6_vgthf_or,"00011100100vvvvvPP1uuuuu001101xx")
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
index 304c4966d8..afe9de3716 100644
--- a/target/hexagon/imported/mmvec/ext.idef
+++ b/target/hexagon/imported/mmvec/ext.idef
@@ -3149,6 +3149,15 @@ ITERATOR_INSN_SHIFT_SLOT_FLT(16, vconv_hf_h,"Vd32.hf=Vu32.h",
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
@@ -3187,8 +3196,63 @@ ITERATOR_INSN_SHIFT_SLOT_FLT(16, vconv_hf_h,"Vd32.hf=Vu32.h",
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
+    VxxV.v[0].sf[i] = fp_mult_sf_bf_acc(VuV.bf[2*i], VvV.bf[2*i],
+                                        VxxV.v[0].sf[i], &env->fp_status);
+    VxxV.v[1].sf[i] = fp_mult_sf_bf_acc(VuV.bf[2*i+1], VvV.bf[2*i+1],
+                                        VxxV.v[1].sf[i], &env->fp_status);
+    fCVI_VX_NO_TMP_LD(); fBFLOAT())
+ITERATOR_INSN_IEEE_FP_16(32, vcvt_bf_sf,
+    "Vd32.bf=vcvt(Vu32.sf,Vv32.sf)",   "Vector IEEE cvt: sf to bf",
+    VdV.bf[2*i]   = sf_to_bf(VuV.sf[i]);
+    VdV.bf[2*i+1] = sf_to_bf(VvV.sf[i]); fBFLOAT())
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


