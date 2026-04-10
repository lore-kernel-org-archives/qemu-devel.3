Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00738F459FC
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 17:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBG5s-0006sV-Or; Fri, 10 Apr 2026 13:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wBG5p-0006qu-U1
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 13:56:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wBG5l-0001fk-Su
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 13:56:33 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63AHoHSO4148794
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 17:56:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=2OUE2BZvCkh
 P3m2KzBqhz4prBprubJMeMyYTeAjRTI8=; b=kfUKsc4PtmF97uGgoiMqgX3gZQK
 IqUeIcHA45hKmWh2pShdi+3Y3nSK93gzdQHuFfThy0HnEMXhi2I56z0WgP+Y6aom
 9Lxu31vBzKukTkzGlyEaKqE8ZeKAVRUsNRBv0XuAl6Vtt9d4ESZq+XOCkGuh5VJX
 wdsSR/S8mAN6ZqO0YUt4qs7BcOX045oGYza3gFXf87bpwHevpB3YyuAfBqxnXsHn
 lrtkBRdGNdcoO6rjb+U81lZdnHDU1eI5w1Ww7+GFm7qYYrQmxIqloCm5Q5R705Pk
 tNXS+Nnr6gbr+jI5Hv9jo6juRsNOu//JslEa23joncsNbBdnaF4/VIu0qqA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deudgjcd6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 17:56:19 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12c0ed22849so1126068c88.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 10:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775843779; x=1776448579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2OUE2BZvCkhP3m2KzBqhz4prBprubJMeMyYTeAjRTI8=;
 b=F8vkbSOTSJDmLRR0kFoht2Cx+24MRbQQGzyMCkTq/cDBQbcFUlaI7DH+s0AqzFrZtT
 /gXrgXZy2morUxjsJocploUsteRCQb/VdrbLCkU5Car5pwNcoRT9g1WDiwof3YNP60MB
 YXNn/+8ypL0fx5ILTnG14qs3hZZ1ot0a6zei2KDJFDS+NpTOslcCuPhnQBqTqotj/wWK
 buEkJUUV0bE3E5PukAYyAhtJY0bNqhE2VypDORzfeqNb3XGXm4yyydKFMVd/UnYJfLeu
 Y21QboYoQR+BjGsjhvvq/ASXc0Q63rkqLnHHTMBcGSKJNRXC5nSSPrmEmrgxICckaQ7L
 AnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775843779; x=1776448579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2OUE2BZvCkhP3m2KzBqhz4prBprubJMeMyYTeAjRTI8=;
 b=NM/GXS8wciOKzMx+h12fvCLCC/uL135H63zqOoKxB7kKMuuZnU5onwNHMz9bevwEDm
 Bxq0qMRfZ4tZKY+Nw1LzqCZLrg7uqpg6WJVhRgzrUFHatOWF1LFwLzj5gCr38qjIg3Ub
 ts22lwoVn6fE8aM4/wjtTfMswAzhMDk32yBkAAb5AsVY06vGVMhGkEOWlUCxZx7tOKnf
 JtTh/o/Ac9viUc2iLoJq9TkqLDI2b8Wt9ah7FmtF8mRkHA9xSoveldqSpRpr7t6UZx00
 BTSvoE2QOdhXDKGkNWEGVzQf6f5dPQbc0bJsI+0zGCUgwD3gJHGa6zc5784Ct9SAdCqy
 /seA==
X-Gm-Message-State: AOJu0YwrNvmC1SuvJXaGbSW8KmfmzsPgLBaBTIum1oAbDJDC3Asb3FXV
 T4wDVDwJ/tOai2qsIJc1VLkbrBEfMfU3zLYYTrW/wG6fD5Qwfns+D7BA2H0b7TJFOz8Jfu11n6O
 DYmVj3SZZ8My2LvhE8PSR0P4vAfrFFVbI5nfyslv6ZS1XshPF7aS9uDdIbeMuxwDyTwpn
X-Gm-Gg: AeBDieu4r+FqVPLKLoVlmi0iWYMjuO6iRWGUFO0fmiL9rJ0gqLqWgz2kS4JsQ2k4yN/
 IC+ozwGoWPemRmAaTLF+8JKV3CWcVF4w/4H1sW839o0mp+8Cslz1V0rtOLOIk8lErSTejhaoVmu
 pOugIxX92a/p6rFZxi4oMjJbhTrhygXxfIgnhyHk7QVm/plfBLCL24HwEmDsfc/10Y3vN7goTY0
 YMEL/pLddVg8q454Q+T6zbEV3fDXiOYTFcuGUS51a9WU9fEx+aKX7wWBwPa7xYix5UFfOCe5ABU
 Z3vRTbp1DdWx2Gffp0MIxyLmQWJ885MpNGSpvj/6tEdeI/+3SK/YyIdVE6iAdUFcnztXEHo+ISe
 RF7we6MRaucKUTuv1xviAJbkZWhMwRMrHGeajkkah9UDzAdtbuyr+UiG0Pv8VpRzYUPA18fogrf
 8J21Ck9Nle
X-Received: by 2002:a05:7022:439f:b0:12c:d3b:f0eb with SMTP id
 a92af1059eb24-12c28bff23bmr4142893c88.8.1775843778389; 
 Fri, 10 Apr 2026 10:56:18 -0700 (PDT)
X-Received: by 2002:a05:7022:439f:b0:12c:d3b:f0eb with SMTP id
 a92af1059eb24-12c28bff23bmr4142879c88.8.1775843777787; 
 Fri, 10 Apr 2026 10:56:17 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c3459f7ffsm4256271c88.3.2026.04.10.10.56.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 10:56:17 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v4 10/16] target/hexagon: add v68 HVX IEEE float compare insns
Date: Fri, 10 Apr 2026 10:55:58 -0700
Message-Id: <ebc920dfcffb0cade4baf5d0a7b8635486118744.1775843299.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775843299.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775843299.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: L4Pv3UHQJgDebEQF2YQrJkDiwbrh5oZB
X-Proofpoint-GUID: L4Pv3UHQJgDebEQF2YQrJkDiwbrh5oZB
X-Authority-Analysis: v=2.4 cv=H/brBeYi c=1 sm=1 tr=0 ts=69d939c3 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=kUWl_rcrYXyUEKLnQikA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDE2OCBTYWx0ZWRfX3fihM46dIFpC
 5NswUCU+6hlF+37RCpFrRb+SJg5njeTYhQ6qDtnqaIiyW+xp9GDFKVVyLHWHkQkLUXVy+4yx8HZ
 mgQoE9igwih+JOd3UYHsA5a7b+L4uVAs8cLZ1KFfm8V6moTwaj0BdS4UxlVyw4FverSRX38nsYc
 k6xCEckwwmqHQ40JdXWOkuPLaDyoHkE0hpFusT3ahG9bhJYZ8+NpjUInCDJLsgW49QIhjp6CBNO
 4MK0gTyvZEMVmqdSkamZ/gIQaftHdThP4xgM6JKrlFooZA9q9LZR5pSEdCOI4k01HwxuG7zJO1H
 g+mET8aJSzDum1Medu2m1vri3TdJ0JYqOAbvj6jskRw0ZY3E/eSWazcEhxCt4kCFxomaza3JW/v
 abmZ23I3jwCuhTozOglIJzDK2O+TBgA8JVDf/uGZkoqosiViUYNxKlzXVJE+hYoKIV73akUpUSw
 zsexz1urlIMpyuq1Rsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015
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

Add HVX IEEE floating-point compare instructions:
- V6_vgthf, V6_vgtsf: greater-than compare
- V6_vgthf_and, V6_vgtsf_and: greater-than with predicate-and
- V6_vgthf_or, V6_vgtsf_or: greater-than with predicate-or
- V6_vgthf_xor, V6_vgtsf_xor: greater-than with predicate-xor

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/mmvec/hvx_ieee_fp.h           |  4 ++
 target/hexagon/mmvec/macros.h                |  3 +
 target/hexagon/mmvec/hvx_ieee_fp.c           | 48 +++++++++++++++
 target/hexagon/imported/mmvec/encode_ext.def | 10 ++++
 target/hexagon/imported/mmvec/ext.idef       | 61 ++++++++++++++++++++
 5 files changed, 126 insertions(+)

diff --git a/target/hexagon/mmvec/hvx_ieee_fp.h b/target/hexagon/mmvec/hvx_ieee_fp.h
index bdc21e08f0..01728121eb 100644
--- a/target/hexagon/mmvec/hvx_ieee_fp.h
+++ b/target/hexagon/mmvec/hvx_ieee_fp.h
@@ -25,4 +25,8 @@ float16 qf_min_hf(float16 a1, float16 a2, float_status *fp_status);
 int32_t conv_w_sf(float32 a, float_status *fp_status);
 int16_t conv_h_hf(float16 a, float_status *fp_status);
 
+/* IEEE - FP compare instructions */
+uint32_t cmpgt_sf(float32 a1, float32 a2, float_status *fp_status);
+uint16_t cmpgt_hf(float16 a1, float16 a2, float_status *fp_status);
+
 #endif
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
diff --git a/target/hexagon/mmvec/hvx_ieee_fp.c b/target/hexagon/mmvec/hvx_ieee_fp.c
index 697f35b5ed..d7751adbe2 100644
--- a/target/hexagon/mmvec/hvx_ieee_fp.c
+++ b/target/hexagon/mmvec/hvx_ieee_fp.c
@@ -87,3 +87,51 @@ int16_t conv_h_hf(float16 a, float_status *fp_status)
     }
     return float16_to_int16_round_to_zero(a, fp_status);
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
+uint32_t cmpgt_sf(float32 a1, float32 a2, float_status *fp_status)
+{
+    if (float32_is_any_nan(a1) || float32_is_any_nan(a2)) {
+        return float32_nan_compare(a1, a2, fp_status);
+    }
+    return float32_compare(a1, a2, fp_status) == float_relation_greater;
+}
+
+uint16_t cmpgt_hf(float16 a1, float16 a2, float_status *fp_status)
+{
+    if (float16_is_any_nan(a1) || float16_is_any_nan(a2)) {
+        return float16_nan_compare(a1, a2, fp_status);
+    }
+    return float16_compare(a1, a2, fp_status) == float_relation_greater;
+}
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
index 788ce1d2ae..a7043d598c 100644
--- a/target/hexagon/imported/mmvec/ext.idef
+++ b/target/hexagon/imported/mmvec/ext.idef
@@ -3143,6 +3143,67 @@ ITERATOR_INSN_SHIFT_SLOT_FLT(16, vconv_hf_h,"Vd32.hf=Vu32.h",
     "Vector conversion of int hw format to hf16",
     VdV.hf[i] = float16_val(int16_to_float16(VuV.h[i], &env->hvx_fp_status)))
 
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


