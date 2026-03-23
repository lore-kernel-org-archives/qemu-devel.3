Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B04CF4610C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4f8a-0000GI-5y; Mon, 23 Mar 2026 09:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w4f8U-0000Ej-CE
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:16:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w4f8R-0000LU-QD
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:16:02 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NC2FBW3042310
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 13:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=xszGSmvQU22
 66Tq2RhuqXAqX3U6gLi/3258I/JkWnZY=; b=FSsupUqh8GpniWa+JN67vYD09gq
 w7ArXCAi9/sAsTu7Q3H73g6hfohCl1a71e2YAlSCT9fInwH58KswqgFPzx9YXRNw
 o6yX/OQOjfH3NB+STKY+f2cbY2mmZpY41GsB8Uh5Rye+zKjCzE6TvVj8EVBo4pVf
 /LxAVq9VAC5kfe4aZdICHT5bErPqklZ0fivTTOe5aadHITfYmqBMuSHbEIu3o6y2
 2GF3pZBfFhAgwiiO827R+ZoGZE30+SyhSXFItRlAJXGtcyoe8siRaIpNDYRQDAAP
 e73vN8jQEFcUbS/guvE1QSz4cqWAToyYfb/a/fOz0a/tPtlirtY25TcJAjw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d355w07hc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 13:15:57 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2c109ba1296so11016733eec.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 06:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774271756; x=1774876556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xszGSmvQU2266Tq2RhuqXAqX3U6gLi/3258I/JkWnZY=;
 b=DwnHhria4vJtYeD4Wf6JI2+JDpp0YwjJM2/3LqCCbyaSAxFB9Y3ygsgqI/CEkQj2Ut
 arAHbM6MSGI8qi+9AEVEG0b+PUz5cUCAg51FOWQlEyP1gD6f7fxdv3VARd6KeiiVrlVg
 1KzzDyBGj89HV38IkPow1B3xwsESWt3rwGwzqxfpErWf91NOOlPIul4bSAsZZqhMKABr
 xj9QLzH9aY67SF2dE1axfRBm2Z2IXso7q7hdVvXaXlZEqSNZrVSJptgoGgXC+zmL1ozd
 IrBFPEZ/luhfirbx8a5BROQEGDwFdeHVfIrOVqpAJLm22lDUs9rxQRbmK48bqt9XnFY6
 L+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774271756; x=1774876556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xszGSmvQU2266Tq2RhuqXAqX3U6gLi/3258I/JkWnZY=;
 b=OEFJVio6zimHMEcJUHIqkLFgUX0gxBa5oQfQlGaZxNkuqPy6+CPS7XMYrWp7OwtC3+
 7NQzuQYMmGITkYS1/qKtvCsbWzfTHfDPCmXHuKk2XAzx6nqdM9JQNkjZFpqjzoLr54wt
 sKICqLw7g+MHmSjMLclrLxW4wZG7M4RyZJqR6Li1YTRwGKlcvnK5j8sG0bwjkSCMrcaQ
 PAAiymV/F27obTK3hnWPxXKLGC+ZRcuFDsJSUx9i3yw268QA/+PqEGp7pumcP6mzzD2u
 wbyKMCXjGFujmvo9qrGI1qs7I7Ui7EETnIo1vR/E0hK11TVjxlvSyVGGQvsaDF8qrheO
 Yc4g==
X-Gm-Message-State: AOJu0YxtTi/9wmNTffrqvSpcQpcNzSymyvMYyZxW+dqV9WSJ2iClVgKc
 sKjqwH54IkkmjLKNLxkYKQJP1gPqPhikGSnYr4pY0FL6Nt/EPRJXdFMs3swYEOGKej7MvhrckR9
 w71CbIjpvxqyo02VYuSd7Aq+F1QmoqvfDEb9qot1KA65LG2hORw76JmOJ9vhgWe+XWkJ9
X-Gm-Gg: ATEYQzy34hf4uQnnyf7i0kIkuSKsg3lHVEBqPdlMjsZ6GzpOuAg2MqaNJrumgd6OYIX
 OmSwl0sfgwzx0uVPedK8/gzRQFpeaEr7+PTc3mX42m29AU8WNhN+c7CB4rk3/PmGqzOZ000A1U/
 YNj1kgrU47qdh8Z+54YzmoioO17ZQrDx/eH+5fZE0elXiA1c17C5AnIODRlu9LxYqIN5uw9P7yZ
 5OVudYScfsc6amK+dyVQzmz2BS0RMaznjpT80xaYrQ4x8aQm2lLXtJJ025KF9DVKx6nfPAhDeX3
 2bG/uLEqzbSUFH7ZPfyiV9rL6kckRaWMsFi4vJRoMn4BUAx5m+1E4rO62KOg7Q3kIXGxSdKlWAQ
 1D1e/YSPiYGQAIuK1kNfSUhEMg8yP7B4MFSQArWAc+Gwjif3FF6g5lPDYW6t6RZMWBpyCEyzWhC
 07MZ+d1Lx7
X-Received: by 2002:a05:7300:7496:b0:2be:e92:7f33 with SMTP id
 5a478bee46e88-2c1097ecb50mr7361206eec.35.1774271756203; 
 Mon, 23 Mar 2026 06:15:56 -0700 (PDT)
X-Received: by 2002:a05:7300:7496:b0:2be:e92:7f33 with SMTP id
 5a478bee46e88-2c1097ecb50mr7361177eec.35.1774271755453; 
 Mon, 23 Mar 2026 06:15:55 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b14cadbsm14702574eec.3.2026.03.23.06.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 06:15:55 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com, marco.liebel@oss.qualcomm.com,
 philmd@linaro.org, quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH 04/13] target/hexagon: add v68 HVX IEEE float arithmetic insns
Date: Mon, 23 Mar 2026 06:15:40 -0700
Message-Id: <831949008a7266559a6f313f99a394cd68cc9846.1774271525.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fq7RpV4f c=1 sm=1 tr=0 ts=69c13d0d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=jpBV4qzoUt2RcIzicscA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: 6OBPI2fM4fIm8JDEMuNuSxIStz7pZpGp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEwMyBTYWx0ZWRfX3gJJeWzD3i/6
 MWAUqQH1dxcoZWNvLdEvoEA1wpallNXOajDrVAc+D4BlUwvh99S0YtcHBIi3GtS6gYw/1ePK6tq
 CwJXzvNOQLDsZ+sDgenoUZC5HRhzMcAhujP3EK+N0o3B9d+OywYVpLnrmYZ7kk1nlUnEkiiu/w0
 q/7WqCH1QzKCES1yS4bc9bD4rZyv7vnTl5c7kUao3tTheKJxKKB51iAs8vpzq7Q6Hf/sm+9Cz59
 QMcUqjiMPL7X/lXyP1JrO8csEK1xdMKlA8jjMwVwYZ7+QnK4MyZ8/IXfUGmPsciHUtdAFsjttme
 Vuj/hN69h3mxtLxClWCZdKZCNzjoRf/ocli5xbxqdw1opqEURBU3GePsuxVvLATCTgCnSuzXEyO
 rT6o+H21fcZeiVmfpn4EMhwaJHHH75/3YN4Z6i5emyG8gtHSmq+vGwCoi1S6QjtQBi0IldkcsTu
 S7pQYqWJJQXeQ9zqPTw==
X-Proofpoint-GUID: 6OBPI2fM4fIm8JDEMuNuSxIStz7pZpGp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0
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

Add HVX IEEE floating-point arithmetic instructions:
- vmpy_sf_sf, vmpy_sf_hf, vmpy_hf_hf: multiply operations
- vdmpy_sf_hf: dot-product multiply
- vmpy_sf_hf_acc, vmpy_hf_hf_acc, vdmpy_sf_hf_acc: multiply-accumulate
- vadd_sf_sf, vsub_sf_sf, vadd_sf_hf, vsub_sf_hf: add/sub with sf output
- vadd_hf_hf, vsub_hf_hf: add/sub with hf output

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/mmvec/kvx_ieee.h              | 47 ++++++++++
 target/hexagon/mmvec/macros.h                |  1 +
 target/hexagon/mmvec/mmvec.h                 |  2 +
 target/hexagon/attribs_def.h.inc             |  4 +
 target/hexagon/mmvec/kvx_ieee.c              | 87 ++++++++++++++++++
 target/hexagon/hex_common.py                 |  1 +
 target/hexagon/imported/mmvec/encode_ext.def | 18 ++++
 target/hexagon/imported/mmvec/ext.idef       | 93 ++++++++++++++++++++
 target/hexagon/meson.build                   |  1 +
 9 files changed, 254 insertions(+)
 create mode 100644 target/hexagon/mmvec/kvx_ieee.h
 create mode 100644 target/hexagon/mmvec/kvx_ieee.c

diff --git a/target/hexagon/mmvec/kvx_ieee.h b/target/hexagon/mmvec/kvx_ieee.h
new file mode 100644
index 0000000000..e92ddebeb9
--- /dev/null
+++ b/target/hexagon/mmvec/kvx_ieee.h
@@ -0,0 +1,47 @@
+/*
+ *  Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HEXAGON_KVX_IEEE_H
+#define HEXAGON_KVX_IEEE_H
+
+#include "fpu/softfloat.h"
+
+/* Hexagon canonical NaN */
+#define FP32_DEF_NAN      0x7FFFFFFF
+#define FP16_DEF_NAN      0x7FFF
+
+/*
+ * IEEE - FP ADD/SUB/MPY instructions
+ */
+uint32_t fp_mult_sf_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
+uint32_t fp_add_sf_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
+uint32_t fp_sub_sf_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
+
+uint16_t fp_mult_hf_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
+uint16_t fp_add_hf_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
+uint16_t fp_sub_hf_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
+
+uint32_t fp_mult_sf_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
+uint32_t fp_add_sf_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
+uint32_t fp_sub_sf_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
+
+/*
+ * IEEE - FP Accumulate instructions
+ */
+uint16_t fp_mult_hf_hf_acc(uint16_t a1, uint16_t a2, uint16_t acc,
+                           float_status *fp_status);
+uint32_t fp_mult_sf_hf_acc(uint16_t a1, uint16_t a2, uint32_t acc,
+                           float_status *fp_status);
+
+/*
+ * IEEE - FP Reduce instructions
+ */
+uint32_t fp_vdmpy(uint16_t a1, uint16_t a2, uint16_t a3, uint16_t a4,
+                  float_status *fp_status);
+uint32_t fp_vdmpy_acc(uint32_t acc, uint16_t a1, uint16_t a2, uint16_t a3,
+                      uint16_t a4, float_status *fp_status);
+
+#endif
diff --git a/target/hexagon/mmvec/macros.h b/target/hexagon/mmvec/macros.h
index c7840fbf2e..2af3d2d747 100644
--- a/target/hexagon/mmvec/macros.h
+++ b/target/hexagon/mmvec/macros.h
@@ -23,6 +23,7 @@
 #include "mmvec/system_ext_mmvec.h"
 #include "accel/tcg/getpc.h"
 #include "accel/tcg/probe.h"
+#include "mmvec/kvx_ieee.h"
 
 #ifndef QEMU_GENERATE
 #define VdV      (*(MMVector *restrict)(VdV_void))
diff --git a/target/hexagon/mmvec/mmvec.h b/target/hexagon/mmvec/mmvec.h
index 52d470709c..eaedfe0d6d 100644
--- a/target/hexagon/mmvec/mmvec.h
+++ b/target/hexagon/mmvec/mmvec.h
@@ -38,6 +38,8 @@ typedef union {
     int16_t   h[MAX_VEC_SIZE_BYTES / 2];
     uint8_t  ub[MAX_VEC_SIZE_BYTES / 1];
     int8_t    b[MAX_VEC_SIZE_BYTES / 1];
+    int32_t  sf[MAX_VEC_SIZE_BYTES / 4];   /* single float (32-bit) */
+    int16_t  hf[MAX_VEC_SIZE_BYTES / 2];   /* half float (16-bit) */
 } MMVector;
 
 typedef union {
diff --git a/target/hexagon/attribs_def.h.inc b/target/hexagon/attribs_def.h.inc
index c85cd5d17c..d3c4bf6301 100644
--- a/target/hexagon/attribs_def.h.inc
+++ b/target/hexagon/attribs_def.h.inc
@@ -175,6 +175,10 @@ DEF_ATTRIB(RESTRICT_LATEPRED, "Predicate can not be used as a .new.", "", "")
 
 /* HVX IEEE FP extension attributes */
 DEF_ATTRIB(HVX_IEEE_FP, "HVX IEEE FP extension instruction", "", "")
+DEF_ATTRIB(HVX_IEEE_FP_ACC, "HVX IEEE FP accumulate instruction", "", "")
+DEF_ATTRIB(HVX_IEEE_FP_OUT_16, "HVX IEEE FP 16-bit output", "", "")
+DEF_ATTRIB(HVX_IEEE_FP_OUT_32, "HVX IEEE FP 32-bit output", "", "")
+DEF_ATTRIB(CVI_VX_NO_TMP_LD, "HVX multiply without tmp load", "", "")
 
 /* Keep this as the last attribute: */
 DEF_ATTRIB(ZZ_LASTATTRIB, "Last attribute in the file", "", "")
diff --git a/target/hexagon/mmvec/kvx_ieee.c b/target/hexagon/mmvec/kvx_ieee.c
new file mode 100644
index 0000000000..b763899aa3
--- /dev/null
+++ b/target/hexagon/mmvec/kvx_ieee.c
@@ -0,0 +1,87 @@
+/*
+ *  Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "kvx_ieee.h"
+
+#define DEF_FP_INSN_2(name, rt, a1t, a2t, op) \
+    uint##rt##_t fp_##name(uint##a1t##_t a1, uint##a2t##_t a2, \
+                           float_status *fp_status) { \
+        float##a1t f1 = make_float##a1t(a1); \
+        float##a2t f2 = make_float##a2t(a2); \
+        \
+        if (float##a1t##_is_any_nan(f1) || float##a2t##_is_any_nan(f2)) { \
+            return FP##rt##_DEF_NAN; \
+        } \
+        float##rt result = op; \
+        \
+        if (float##rt##_is_any_nan(result)) { \
+            return FP##rt##_DEF_NAN; \
+        } \
+        return result; \
+    }
+
+#define DEF_FP_INSN_3(name, rt, a1t, a2t, a3t, op) \
+    uint##rt##_t fp_##name(uint##a1t##_t a1, uint##a2t##_t a2, \
+                           uint##a3t##_t a3, float_status *fp_status) { \
+        float##a1t f1 = make_float##a1t(a1); \
+        float##a2t f2 = make_float##a2t(a2); \
+        float##a3t f3 = make_float##a3t(a3); \
+        \
+        if (float##a1t##_is_any_nan(f1) || float##a2t##_is_any_nan(f2) || \
+            float##a3t##_is_any_nan(f3)) \
+            return FP##rt##_DEF_NAN; \
+        \
+        float##rt result = op; \
+        \
+        if (float##rt##_is_any_nan(result)) \
+            return FP##rt##_DEF_NAN; \
+        return result; \
+    }
+
+DEF_FP_INSN_2(mult_sf_sf, 32, 32, 32, float32_mul(f1, f2, fp_status))
+DEF_FP_INSN_2(add_sf_sf, 32, 32, 32, float32_add(f1, f2, fp_status))
+DEF_FP_INSN_2(sub_sf_sf, 32, 32, 32, float32_sub(f1, f2, fp_status))
+
+DEF_FP_INSN_2(mult_hf_hf, 16, 16, 16, float16_mul(f1, f2, fp_status))
+DEF_FP_INSN_2(add_hf_hf, 16, 16, 16, float16_add(f1, f2, fp_status))
+DEF_FP_INSN_2(sub_hf_hf, 16, 16, 16, float16_sub(f1, f2, fp_status))
+
+DEF_FP_INSN_2(mult_sf_hf, 32, 16, 16,
+              float32_mul(float16_to_float32(f1, true, fp_status),
+                          float16_to_float32(f2, true, fp_status),
+                          fp_status))
+DEF_FP_INSN_2(add_sf_hf, 32, 16, 16,
+              float32_add(float16_to_float32(f1, true, fp_status),
+                          float16_to_float32(f2, true, fp_status),
+                          fp_status))
+DEF_FP_INSN_2(sub_sf_hf, 32, 16, 16,
+              float32_sub(float16_to_float32(f1, true, fp_status),
+                          float16_to_float32(f2, true, fp_status),
+                          fp_status))
+
+DEF_FP_INSN_3(mult_hf_hf_acc, 16, 16, 16, 16,
+              float16_muladd(f1, f2, f3, 0, fp_status))
+DEF_FP_INSN_3(mult_sf_hf_acc, 32, 16, 16, 32,
+              float32_muladd(float16_to_float32(f1, true, fp_status),
+                             float16_to_float32(f2, true, fp_status),
+                             f3, 0, fp_status))
+
+uint32_t fp_vdmpy(uint16_t a1, uint16_t a2, uint16_t a3, uint16_t a4,
+                 float_status *fp_status)
+{
+    float32 prod1 = fp_mult_sf_hf(a1, a3, fp_status);
+    float32 prod2 = fp_mult_sf_hf(a2, a4, fp_status);
+    return fp_add_sf_sf(float32_val(prod1), float32_val(prod2), fp_status);
+}
+
+uint32_t fp_vdmpy_acc(uint32_t acc, uint16_t a1, uint16_t a2,
+                      uint16_t a3, uint16_t a4,
+                      float_status *fp_status)
+{
+    float32 red = fp_vdmpy(a1, a2, a3, a4, fp_status);
+    return fp_add_sf_sf(float32_val(red), acc, fp_status);
+}
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index c0e9f26aeb..f6a2848db1 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -215,6 +215,7 @@ def need_env(tag):
             "A_LOAD" in attribdict[tag] or
             "A_CVI_GATHER" in attribdict[tag] or
             "A_CVI_SCATTER" in attribdict[tag] or
+            "A_HVX_IEEE_FP" in attribdict[tag] or
             "A_IMPLICIT_WRITES_USR" in attribdict[tag])
 
 
diff --git a/target/hexagon/imported/mmvec/encode_ext.def b/target/hexagon/imported/mmvec/encode_ext.def
index 6d70086b5f..4ce87d09fd 100644
--- a/target/hexagon/imported/mmvec/encode_ext.def
+++ b/target/hexagon/imported/mmvec/encode_ext.def
@@ -804,5 +804,23 @@ DEF_ENC(V6_vmpyewuh,    ICLASS_CJ" 1 111 111 vvvvv PP 0 uuuuu 101 ddddd")
 DEF_ENC(V6_vmpyowh,        ICLASS_CJ" 1 111 111 vvvvv PP 0 uuuuu 111 ddddd")
 DEF_ENC(V6_vmpyuhvs,"00011111110vvvvvPP1uuuuu111ddddd")
 
+/* IEEE FP multiply instructions */
+DEF_ENC(V6_vmpy_sf_sf,"00011111100vvvvvPP1uuuuu001ddddd")
+DEF_ENC(V6_vmpy_sf_hf,"00011111100vvvvvPP1uuuuu010ddddd")
+DEF_ENC(V6_vmpy_hf_hf,"00011111100vvvvvPP1uuuuu011ddddd")
+DEF_ENC(V6_vdmpy_sf_hf,"00011111101vvvvvPP1uuuuu110ddddd")
+
+/* IEEE FP multiply-accumulate instructions */
+DEF_ENC(V6_vmpy_sf_hf_acc,"00011100010vvvvvPP1uuuuu001xxxxx")
+DEF_ENC(V6_vmpy_hf_hf_acc,"00011100010vvvvvPP1uuuuu010xxxxx")
+DEF_ENC(V6_vdmpy_sf_hf_acc,"00011100010vvvvvPP1uuuuu011xxxxx")
+
+/* IEEE FP add/sub instructions */
+DEF_ENC(V6_vadd_sf_sf,"00011111100vvvvvPP1uuuuu110ddddd")
+DEF_ENC(V6_vsub_sf_sf,"00011111100vvvvvPP1uuuuu111ddddd")
+DEF_ENC(V6_vadd_sf_hf,"00011111100vvvvvPP1uuuuu100ddddd")
+DEF_ENC(V6_vsub_sf_hf,"00011111100vvvvvPP1uuuuu101ddddd")
+DEF_ENC(V6_vadd_hf_hf,"00011111101vvvvvPP1uuuuu111ddddd")
+DEF_ENC(V6_vsub_hf_hf,"00011111011vvvvvPP1uuuuu000ddddd")
 
 #endif /* NO MMVEC */
diff --git a/target/hexagon/imported/mmvec/ext.idef b/target/hexagon/imported/mmvec/ext.idef
index 03d31f6181..3f0d8e366e 100644
--- a/target/hexagon/imported/mmvec/ext.idef
+++ b/target/hexagon/imported/mmvec/ext.idef
@@ -2895,9 +2895,102 @@ EXTINSN(V6_vprefixqw,"Vd32.w=prefixsum(Qv4)",   ATTRIBS(A_EXTENSION,A_CVI,A_CVI_
     }
     } )
 
+/* KVX - IEEE FP Instructions */
 
+/* Single pipe, 32-bit output */
+#define ITERATOR_INSN_IEEE_FP_32(WIDTH,TAG,SYNTAX,DESCR,CODE) \
+EXTINSN(V6_##TAG, SYNTAX, \
+ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX,A_HVX_IEEE_FP_OUT_32), \
+DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
 
+/* Single pipe, 16-bit output */
+#define ITERATOR_INSN_IEEE_FP_16(WIDTH,TAG,SYNTAX,DESCR,CODE) \
+EXTINSN(V6_##TAG, SYNTAX, \
+ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX,A_HVX_IEEE_FP_OUT_16), \
+DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
 
+/* Two pipes: P2 & P3, single output: P2, 32-bit output */
+#define ITERATOR_INSN_IEEE_FP_DOUBLE_SINGLE_32(WIDTH,TAG,SYNTAX,DESCR,CODE) \
+EXTINSN(V6_##TAG, SYNTAX, \
+ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX_DV,A_HVX_IEEE_FP_OUT_32), \
+DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
+
+/* Two pipes: P2 & P3, two outputs, 32-bit output */
+#define ITERATOR_INSN_IEEE_FP_DOUBLE_32(WIDTH,TAG,SYNTAX,DESCR,CODE) \
+EXTINSN(V6_##TAG, SYNTAX, \
+ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX_DV,A_HVX_IEEE_FP_OUT_32), \
+DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
+
+/*
+ * single pipe, accumulate instruction, produces 16-bit output, requires 16-bit
+ * accumulate input
+ */
+#define ITERATOR_INSN_IEEE_FP_ACC_16(WIDTH,TAG,SYNTAX,DESCR,CODE) \
+EXTINSN(V6_##TAG, SYNTAX, \
+ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX,A_HVX_IEEE_FP_ACC,A_HVX_IEEE_FP_OUT_16,A_CVI_VX_NO_TMP_LD), \
+DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
+
+/*
+ * single pipe, accumulate instruction, produces 32-bit output, requires 32-bit
+ * accumulate input
+ */
+#define ITERATOR_INSN_IEEE_FP_ACC_32(WIDTH,TAG,SYNTAX,DESCR,CODE) \
+EXTINSN(V6_##TAG, SYNTAX, \
+ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX,A_HVX_IEEE_FP_ACC,A_HVX_IEEE_FP_OUT_32,A_CVI_VX_NO_TMP_LD), \
+DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
+
+/* IEEE FP multiply instructions */
+ITERATOR_INSN_IEEE_FP_DOUBLE_SINGLE_32(32, vmpy_sf_sf,
+    "Vd32.sf=vmpy(Vu32.sf,Vv32.sf)", "Vector IEEE mul: sf",
+    VdV.sf[i] = fp_mult_sf_sf(VuV.sf[i], VvV.sf[i], &env->fp_status))
+ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vmpy_sf_hf,
+    "Vdd32.sf=vmpy(Vu32.hf,Vv32.hf)", "Vector IEEE mul: hf widen to sf",
+    VddV.v[0].sf[i] = fp_mult_sf_hf(VuV.hf[2*i], VvV.hf[2*i], &env->fp_status);
+    VddV.v[1].sf[i] = fp_mult_sf_hf(VuV.hf[2*i+1], VvV.hf[2*i+1], &env->fp_status))
+ITERATOR_INSN_IEEE_FP_16(16, vmpy_hf_hf,     "Vd32.hf=vmpy(Vu32.hf,Vv32.hf)",
+    "Vector IEEE mul: hf",
+    VdV.hf[i] = fp_mult_hf_hf(VuV.hf[i], VvV.hf[i], &env->fp_status))
+ITERATOR_INSN_IEEE_FP_32(32, vdmpy_sf_hf,     "Vd32.sf=vdmpy(Vu32.hf,Vv32.hf)",
+    "Vector IEEE mul reduction: hf widen to sf",
+    VdV.sf[i] = fp_vdmpy(VuV.hf[2*i+1], VuV.hf[2*i], VvV.hf[2*i+1],
+        VvV.hf[2*i], &env->fp_status))
+
+/* IEEE FP multiply-accumulate instructions */
+ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vmpy_sf_hf_acc,
+    "Vxx32.sf+=vmpy(Vu32.hf,Vv32.hf)", "Vector IEEE fma: hf widen to sf",
+    VxxV.v[0].sf[i] = fp_mult_sf_hf_acc(VuV.hf[2*i], VvV.hf[2*i],
+        VxxV.v[0].sf[i], &env->fp_status);
+    VxxV.v[1].sf[i] = fp_mult_sf_hf_acc(VuV.hf[2*i+1], VvV.hf[2*i+1],
+        VxxV.v[1].sf[i], &env->fp_status))
+ITERATOR_INSN_IEEE_FP_ACC_16(16, vmpy_hf_hf_acc,
+    "Vx32.hf+=vmpy(Vu32.hf,Vv32.hf)", "Vector IEEE fma: hf",
+    VxV.hf[i] = fp_mult_hf_hf_acc(VuV.hf[i], VvV.hf[i], VxV.hf[i], &env->fp_status))
+ITERATOR_INSN_IEEE_FP_ACC_32(32, vdmpy_sf_hf_acc,
+    "Vx32.sf+=vdmpy(Vu32.hf,Vv32.hf)", "Vector IEEE fma reduce: hf widen to sf",
+    VxV.sf[i] = fp_vdmpy_acc(VxV.sf[i], VuV.hf[2*i+1], VuV.hf[2*i], VvV.hf[2*i+1],
+        VvV.hf[2*i], &env->fp_status))
+
+/* IEEE FP add/sub instructions */
+ITERATOR_INSN_IEEE_FP_32(32, vadd_sf_sf, "Vd32.sf=vadd(Vu32.sf,Vv32.sf)",
+    "Vector IEEE add: sf",
+    VdV.sf[i] = fp_add_sf_sf(VuV.sf[i], VvV.sf[i], &env->fp_status))
+ITERATOR_INSN_IEEE_FP_32(32, vsub_sf_sf, "Vd32.sf=vsub(Vu32.sf,Vv32.sf)",
+    "Vector IEEE sub: sf",
+    VdV.sf[i] = fp_sub_sf_sf(VuV.sf[i], VvV.sf[i], &env->fp_status))
+ITERATOR_INSN_IEEE_FP_16(16, vadd_hf_hf, "Vd32.hf=vadd(Vu32.hf,Vv32.hf)",
+    "Vector IEEE add: hf",
+    VdV.hf[i] = fp_add_hf_hf(VuV.hf[i], VvV.hf[i], &env->fp_status))
+ITERATOR_INSN_IEEE_FP_16(16, vsub_hf_hf, "Vd32.hf=vsub(Vu32.hf,Vv32.hf)",
+    "Vector IEEE sub: hf",
+    VdV.hf[i] = fp_sub_hf_hf(VuV.hf[i], VvV.hf[i], &env->fp_status))
+ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vadd_sf_hf,
+    "Vdd32.sf=vadd(Vu32.hf,Vv32.hf)",  "Vector IEEE add: hf widen to sf",
+    VddV.v[0].sf[i] = fp_add_sf_hf(VuV.hf[2*i], VvV.hf[2*i], &env->fp_status);
+    VddV.v[1].sf[i] = fp_add_sf_hf(VuV.hf[2*i+1], VvV.hf[2*i+1], &env->fp_status))
+ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vsub_sf_hf,
+    "Vdd32.sf=vsub(Vu32.hf,Vv32.hf)",  "Vector IEEE sub: hf widen to sf",
+    VddV.v[0].sf[i] = fp_sub_sf_hf(VuV.hf[2*i], VvV.hf[2*i], &env->fp_status);
+    VddV.v[1].sf[i] = fp_sub_sf_hf(VuV.hf[2*i+1], VvV.hf[2*i+1], &env->fp_status))
 
 /******************************************************************************
  DEBUG Vector/Register Printing
diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
index d169cf71b2..f9a93975ad 100644
--- a/target/hexagon/meson.build
+++ b/target/hexagon/meson.build
@@ -250,6 +250,7 @@ hexagon_ss.add(files(
     'fma_emu.c',
     'mmvec/decode_ext_mmvec.c',
     'mmvec/system_ext_mmvec.c',
+    'mmvec/kvx_ieee.c',
 ))
 
 #
-- 
2.37.2


