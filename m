Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FDDD3940D
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 10:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8FbR-0005Ip-QI; Thu, 02 Apr 2026 06:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w8Fan-0004kc-EE
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:48:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w8Fai-0007pg-Gs
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:48:02 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6328dAMk1249516
 for <qemu-devel@nongnu.org>; Thu, 2 Apr 2026 10:47:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=D7rnSVAJp6s
 d+gvxD4uEflttLT9iHzjnYVqCVfxs/yE=; b=JZGRk0+BSB4A3CJdrnxKHWs5ZuM
 vRr/MVByKuNUD3jluNrjUfG04tP/WRsWymY9ywmMVhhXzK4ma97NJCXDPXvbDEzL
 XNJNXKkM/q31wmIkeWf9gG5LnTHXBmzBGHxoYD8y7kFSPoJm1rpjBBKvq86mXUm5
 RXScDegqbHP+Ad64A969JIIexsssKGSGQ+uKDskOntRrydiYwKrx/X8ard1VwbDT
 QMhGZcpcWm3FW+ZPnDOfP1ZlOkIctxNG2ksu4MkN0bzT+UCuby8xEKXbSJ+IfziS
 bWThnjvpRowmJpC2pPTYHogTn5cNUVfXkIzW8//57Qm3guX2p5h/3HjezdQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9n4t0fsx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 10:47:48 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2cb6f605b95so549707eec.1
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 03:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775126868; x=1775731668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D7rnSVAJp6sd+gvxD4uEflttLT9iHzjnYVqCVfxs/yE=;
 b=iPcf0Y13/rTaRfUnlxF9LH66GExS6Sy+lNpn3l1uetveo2FXrDPmJ6ytrC15sszpGO
 o9OVKg+C8QdC0qlx82bYXC/a+IaKIREieOt1ZJbLlyuDrncfzFO78PKhL5KOldJZQZCw
 EY8d6rJcdNbY9aI6jRHmlROwEGPTHWoWrQUzfB9qozcnAoYQ0/pIlKv98aIchUqaIfLC
 AlH2SZdoKcGFM9wkhXO6nk14UoCSnqfoXlZg7cUBpxm4uEA7kbxpzBXFs1jLD5BPp9Je
 yfCUq9zCN0b0wg+R8lauTVbh9TFU1+n8C1mdsgEv+hzxrZrZFhAoZ2jGxJJGR7dvvqhR
 Vw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775126868; x=1775731668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D7rnSVAJp6sd+gvxD4uEflttLT9iHzjnYVqCVfxs/yE=;
 b=o+o/dSqefe1s9Ht/XNgzuNFDd8v7pQblMJpoV8Rkh1EE1kVQaoNjlTmj0O2+JcZE5F
 0dQwAELe0E9gItEtGiqOK4Y4mzhYaPOnywBXziCYDO9qM8ziY64+UZYqJ1BHLarRmRco
 l2EAyUrVjuq7gqbEpEr9gHf59+vhPJjoeIYHko/qDfPreqgzh7fkcQwdsY7jUQbN9h1E
 p74QBO70/mV1FqW0i6tgO8yXtTB5bc79+LZY+52nTQxqEQ9W3mzNjiXo1aolgg2/OhCg
 MWyhneqLBnb983kkHFIwDBYJ92gjN5G/bBT9CC9H7LSSiYasGjqUWIKXFyihwiZRFJEI
 FDww==
X-Gm-Message-State: AOJu0YxamVCWc2wdd+xWHLH4Nk++fLjRg2oCFR2CpfV5pMKweUoA3JPB
 ha1e2C0HSTPUdqaOnBWy2CWwBMj1yF7P9u6YIJTAFDxP+QutCSkOM2hugJT4DeqIXh74VsvYKac
 vfd5gb32+uY1jHet49a9Nh+WT7qk8LglPyVL9kVGvxXmROU9TAzLlyYwuhxaO37YmgUlu
X-Gm-Gg: ATEYQzw9MUQgt0ZIuBY5zd3nBaLXa+vJDbe5Crn2tz5bjFLzQe2uoT6XhJJAvK9+YpG
 V6MflZu3dNzZL2XdEUuFkeQu64yyLr5vQtyXU3Tem4bv9HdJzCwBBAOOuOeaja4z1eCqfZxmAaD
 U+oMrxHfttF/Gq7Wf2tCUWBky7uGLa8vwPp1M4fucRrr85eMMoCQvAuYPF6iDOnwnenqgK9RC18
 e5UPx6cRBAC3Ro/kvBjB+Wplo66B5rXXU5dvMyxTL+Bz3sP+UVdYtKE7eeCsuMQ4vUIZZraMAPr
 nYV2SGaxfsrVJGMr8Zfpt4FCoUJKg0bSoKqzMpUbAtZYwR6oHssuoorw+WZIWBDizt/+tjNSiNd
 9zx2Tblim0RTZ2E7/BQocMFHI1WCyOiDlmlGbmZxMBk4XHH3bybn+Tf9QC8Z/TK+kMJRruqFWq5
 EMVVVgk4Yq
X-Received: by 2002:a05:693c:3117:b0:2c6:7f49:a87a with SMTP id
 5a478bee46e88-2c930d75fafmr3937213eec.9.1775126867949; 
 Thu, 02 Apr 2026 03:47:47 -0700 (PDT)
X-Received: by 2002:a05:693c:3117:b0:2c6:7f49:a87a with SMTP id
 5a478bee46e88-2c930d75fafmr3937189eec.9.1775126867413; 
 Thu, 02 Apr 2026 03:47:47 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca7d00f5easm2004783eec.29.2026.04.02.03.47.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 03:47:47 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v2 12/16] tests/hexagon: add tests for v68 HVX IEEE float
 arithmetics
Date: Thu,  2 Apr 2026 03:47:29 -0700
Message-Id: <719aeb5d4f23bd3315932888dd9d1bae9fb636d8.1775122853.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: URjdAVqljVZA5kSf341kf9NeU_gJ8MtY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA5NyBTYWx0ZWRfX207SSM3u/SCF
 vem+I9eMqtZtove2FTIUhYClsO7/d1W8qQJwJsgm03fma1gMqlXpPXFDmVR9nIAh3Qi4+U3uwUN
 /HruCnM0Czr7+FmvXE2auc7hbUEl8bg4iLQeh6kx4TU1Vhy2nKwa0j69xPmrtOe8ck+WbSzj7L+
 aPegczVtPK3td+MnzK1Q1S8K4z3WZYjldghbsoWasR1fqikU809Bsk5MBsKHcGE67+uyNVW6us9
 sRYt4/Cgg+ADKNs0F61IHyn/npcSqVfB+TslA8W73mWbcBMIDVG6qhDvFSvzrTF9xgKcWpZ/TOw
 B1zafHPIf8Md4gxLrvyTwNvu5qpT/01UOkKPwEQhTD1blVIiYmrTNObqeflwcAS3V2Pj2CUG3ZR
 7KsoRYYLrXkg23cBMAX41qtEhA4987FzDWjgb+b/NKZ9VUavrDJk5hDF70hakGKAb0ualra4Y8u
 mnS5Mldg/LaS/7+WuSQ==
X-Proofpoint-GUID: URjdAVqljVZA5kSf341kf9NeU_gJ8MtY
X-Authority-Analysis: v=2.4 cv=Ap/jHe9P c=1 sm=1 tr=0 ts=69ce4955 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=p626gilfWeCCYUnsPZkA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020097
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

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 tests/tcg/hexagon/hex_test.h        |   4 +
 tests/tcg/hexagon/hvx_misc.h        |  41 ++++++++
 tests/tcg/hexagon/fp_hvx.c          | 155 ++++++++++++++++++++++++++++
 tests/tcg/hexagon/fp_hvx_disabled.c |  57 ++++++++++
 tests/tcg/hexagon/Makefile.target   |   8 ++
 5 files changed, 265 insertions(+)
 create mode 100644 tests/tcg/hexagon/fp_hvx.c
 create mode 100644 tests/tcg/hexagon/fp_hvx_disabled.c

diff --git a/tests/tcg/hexagon/hex_test.h b/tests/tcg/hexagon/hex_test.h
index cfed06a58b..e7a6644d41 100644
--- a/tests/tcg/hexagon/hex_test.h
+++ b/tests/tcg/hexagon/hex_test.h
@@ -19,6 +19,8 @@
 #ifndef HEX_TEST_H
 #define HEX_TEST_H
 
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
 static inline void __check32(int line, uint32_t val, uint32_t expect)
 {
     if (val != expect) {
@@ -110,6 +112,7 @@ static inline void __check64_ne(int line, uint64_t val, uint64_t expect)
 
 /* Some useful floating point values */
 const uint32_t SF_INF =              0x7f800000;
+const uint32_t SF_INF_neg =          0xff800000;
 const uint32_t SF_QNaN =             0x7fc00000;
 const uint32_t SF_QNaN_special =     0x7f800001;
 const uint32_t SF_SNaN =             0x7fb00000;
@@ -128,6 +131,7 @@ const uint32_t SF_large_pos =        0x5afa572e;
 const uint32_t SF_any =              0x3f800000;
 const uint32_t SF_denorm =           0x00000001;
 const uint32_t SF_random =           0x346001d6;
+const uint32_t SF_neg_two =          0xc0000000;
 
 const uint64_t DF_QNaN =             0x7ff8000000000000ULL;
 const uint64_t DF_SNaN =             0x7ff7000000000000ULL;
diff --git a/tests/tcg/hexagon/hvx_misc.h b/tests/tcg/hexagon/hvx_misc.h
index 2e868340fd..0330cb289d 100644
--- a/tests/tcg/hexagon/hvx_misc.h
+++ b/tests/tcg/hexagon/hvx_misc.h
@@ -18,6 +18,8 @@
 #ifndef HVX_MISC_H
 #define HVX_MISC_H
 
+#include "hex_test.h"
+
 static inline void check(int line, int i, int j,
                          uint64_t result, uint64_t expect)
 {
@@ -34,8 +36,10 @@ typedef union {
     uint64_t ud[MAX_VEC_SIZE_BYTES / 8];
     int64_t   d[MAX_VEC_SIZE_BYTES / 8];
     uint32_t uw[MAX_VEC_SIZE_BYTES / 4];
+    uint32_t sf[MAX_VEC_SIZE_BYTES / 4]; /* convenience alias */
     int32_t   w[MAX_VEC_SIZE_BYTES / 4];
     uint16_t uh[MAX_VEC_SIZE_BYTES / 2];
+    uint16_t hf[MAX_VEC_SIZE_BYTES / 2]; /* convenience alias */
     int16_t   h[MAX_VEC_SIZE_BYTES / 2];
     uint8_t  ub[MAX_VEC_SIZE_BYTES / 1];
     int8_t    b[MAX_VEC_SIZE_BYTES / 1];
@@ -63,7 +67,9 @@ static inline void check_output_##FIELD(int line, size_t num_vectors) \
 
 CHECK_OUTPUT_FUNC(d,  8)
 CHECK_OUTPUT_FUNC(w,  4)
+CHECK_OUTPUT_FUNC(sf, 4)
 CHECK_OUTPUT_FUNC(h,  2)
+CHECK_OUTPUT_FUNC(hf, 2)
 CHECK_OUTPUT_FUNC(b,  1)
 
 static inline void init_buffers(void)
@@ -81,6 +87,33 @@ static inline void init_buffers(void)
     }
 }
 
+static const uint32_t FP_VALUES[] = {
+    SF_INF, SF_INF_neg, SF_QNaN, SF_QNaN_special, SF_SNaN, SF_QNaN_neg,
+    SF_SNaN_neg, SF_HEX_NaN, SF_zero, SF_zero_neg, SF_one, SF_one_recip,
+    SF_one_invsqrta, SF_two, SF_four, SF_small_neg, SF_large_pos, SF_any,
+    SF_denorm, SF_random, SF_neg_two,
+};
+#define FP_VALUES_MAX ARRAY_SIZE(FP_VALUES)
+
+static inline void init_buffers_fp(void)
+{
+    _Static_assert(BUFSIZE * (MAX_VEC_SIZE_BYTES / 4) >
+                   FP_VALUES_MAX * FP_VALUES_MAX,
+                   "test arrays can't fit all FP_VALUES combinations");
+    int counter1 = 0, counter2 = 0;
+    for (int i = 0; i < BUFSIZE; i++) {
+        for (int j = 0; j < MAX_VEC_SIZE_BYTES / 4; j++) {
+            buffer0[i].sf[j] = FP_VALUES[counter1];
+            buffer1[i].sf[j] = FP_VALUES[counter2];
+            counter2++;
+            if (counter2 == FP_VALUES_MAX) {
+                counter2 = 0;
+                counter1 = (counter1 + 1) % FP_VALUES_MAX;
+            }
+        }
+    }
+}
+
 #define VEC_OP1(ASM, EL, IN, OUT) \
     asm("v2 = vmem(%0 + #0)\n\t" \
         "v2" #EL " = " #ASM "(v2" #EL ")\n\t" \
@@ -175,4 +208,12 @@ static inline void test_##NAME(bool invert) \
     check_output_b(__LINE__, BUFSIZE); \
 }
 
+#define float_sf(x) ({ typeof(x) _x = (x); *((float *)&(_x)); })
+#define float_hf(x) ({ typeof(x) _x = (x); *((_Float16 *) &(_x)); })
+#define raw_sf(x) ({ typeof(x) _x = (x); *((uint32_t *)&(_x)); })
+#define raw_hf(x) ({ typeof(x) _x = (x); *((uint16_t *)&(_x)); })
+#define float_hf_to_sf(x) ((float)x)
+#define bytes_hf 2
+#define bytes_sf 4
+
 #endif
diff --git a/tests/tcg/hexagon/fp_hvx.c b/tests/tcg/hexagon/fp_hvx.c
new file mode 100644
index 0000000000..0365833753
--- /dev/null
+++ b/tests/tcg/hexagon/fp_hvx.c
@@ -0,0 +1,155 @@
+/*
+ *  Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdio.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <string.h>
+#include <hexagon_types.h>
+#include <hvx_hexagon_protos.h>
+
+int err;
+#include "hvx_misc.h"
+
+#if __HEXAGON_ARCH__ > 75
+#error "After v75, compiler will replace some FP HVX instructions."
+#endif
+
+/******************************************************************************
+ * NAN handling
+ *****************************************************************************/
+
+#define isnan(X) \
+     (sizeof(X) == bytes_hf ? ((raw_hf(X) & ~0x8000) > 0x7c00) : \
+                              ((raw_sf(X) & ~(1 << 31)) > 0x7f800000UL))
+
+#define CHECK_NAN(A, DEF_NAN) (isnan(A) ? DEF_NAN : (A))
+#define NAN_SF float_sf(0x7FFFFFFF)
+#define NAN_HF float_hf(0x7FFF)
+
+/******************************************************************************
+ * Binary operations
+ *****************************************************************************/
+
+#define DEF_TEST_OP_2(vop, op, type_res, type_arg) \
+    static void test_##vop##_##type_res##_##type_arg(void) \
+    { \
+        memset(expect, 0xff, sizeof(expect)); \
+        memset(output, 0xff, sizeof(output)); \
+        for (int i = 0; i < BUFSIZE; i++) { \
+            HVX_Vector *hvx_output = (HVX_Vector *)&output[i]; \
+            HVX_Vector hvx_buffer0 = *(HVX_Vector *)&buffer0[i]; \
+            HVX_Vector hvx_buffer1 = *(HVX_Vector *)&buffer1[i]; \
+            *hvx_output = \
+                Q6_V##type_res##_##vop##_V##type_arg##V##type_arg(hvx_buffer0, \
+                                                                  hvx_buffer1); \
+            for (int j = 0; j < MAX_VEC_SIZE_BYTES / bytes_##type_res; j++) { \
+                expect[i].type_res[j] = \
+                    raw_##type_res(op(float_##type_arg(buffer0[i].type_arg[j]), \
+                                      float_##type_arg(buffer1[i].type_arg[j]))); \
+            } \
+        } \
+        check_output_##type_res(__LINE__, BUFSIZE); \
+    }
+
+#define SUM(X, Y, DEF_NAN) CHECK_NAN((X) + (Y), DEF_NAN)
+#define SUB(X, Y, DEF_NAN) CHECK_NAN((X) - (Y), DEF_NAN)
+#define MULT(X, Y, DEF_NAN) CHECK_NAN((X) * (Y), DEF_NAN)
+
+#define SUM_SF(X, Y) SUM(X, Y, NAN_SF)
+#define SUM_HF(X, Y) SUM(X, Y, NAN_HF)
+#define SUB_SF(X, Y) SUB(X, Y, NAN_SF)
+#define SUB_HF(X, Y) SUB(X, Y, NAN_HF)
+#define MULT_SF(X, Y) MULT(X, Y, NAN_SF)
+#define MULT_HF(X, Y) MULT(X, Y, NAN_HF)
+
+DEF_TEST_OP_2(vadd, SUM_SF, sf, sf);
+DEF_TEST_OP_2(vadd, SUM_HF, hf, hf);
+DEF_TEST_OP_2(vsub, SUB_SF, sf, sf);
+DEF_TEST_OP_2(vsub, SUB_HF, hf, hf);
+DEF_TEST_OP_2(vmpy, MULT_SF, sf, sf);
+DEF_TEST_OP_2(vmpy, MULT_HF, hf, hf);
+
+/******************************************************************************
+ * Other tests
+ *****************************************************************************/
+
+static void test_vdmpy_sf_hf(bool acc)
+{
+    memset(expect, 0xff, sizeof(expect));
+
+    for (int i = 0; i < BUFSIZE; i++) {
+        HVX_Vector hvx_buffer0 = *(HVX_Vector *)&buffer0[i];
+        HVX_Vector hvx_buffer1 = *(HVX_Vector *)&buffer1[i];
+        HVX_Vector *hvx_output = (HVX_Vector *)&output[i];
+
+        uint32_t PREFIL_VAL = 0x111222;
+        *hvx_output = Q6_V_vsplat_R(PREFIL_VAL);
+
+        if (!acc) {
+            *hvx_output = Q6_Vsf_vdmpy_VhfVhf(hvx_buffer0, hvx_buffer1);
+        } else {
+            *hvx_output = Q6_Vsf_vdmpyacc_VsfVhfVhf(*hvx_output, hvx_buffer0,
+                                                    hvx_buffer1);
+        }
+
+        for (int j = 0; j < MAX_VEC_SIZE_BYTES / 4; j++) {
+            float a1 = float_hf_to_sf(float_hf(buffer0[i].hf[2 * j + 1]));
+            float a2 = float_hf_to_sf(float_hf(buffer0[i].hf[2 * j]));
+            float a3 = float_hf_to_sf(float_hf(buffer1[i].hf[2 * j + 1]));
+            float a4 = float_hf_to_sf(float_hf(buffer1[i].hf[2 * j]));
+            /*
+             * Note, IEEE FP specifies +0.0 + -0.0 == +0.0. So we use -0.0 in
+             * the default case to preserve the zero sign.
+             */
+            float prev = acc ? float_sf(PREFIL_VAL) : -0.0;
+            expect[i].sf[j] = raw_sf(CHECK_NAN((a1 * a3) + (a2 * a4) + prev, NAN_SF));
+        }
+    }
+    check_output_sf(__LINE__, BUFSIZE);
+}
+
+static void test_new(void)
+{
+    asm volatile("r0 = #0x2\n"
+                 "v0 = vsplat(r0)\n"
+                 "vmem(%1 + #0) = v0\n"
+                 "r1 = #0x1\n"
+                 "v1 = vsplat(r1)\n"
+                 "v2 = vsplat(r1)\n"
+                 "{\n"
+                 "  v0.sf = vadd(v1.sf, v2.sf)\n"
+                 "  vmem(%0 + #0) = v0.new\n"
+                 "}\n"
+                 :
+                 : "r"(output), "r"(expect)
+                 : "r0", "r1", "v0", "v1", "v2", "memory");
+    check_output_w(__LINE__, 1);
+}
+
+int main(void)
+{
+    init_buffers_fp();
+
+    /* add/sub */
+    test_vadd_sf_sf();
+    test_vadd_hf_hf();
+    test_vsub_sf_sf();
+    test_vsub_hf_hf();
+
+    /* multiply */
+    test_vmpy_sf_sf();
+    test_vmpy_hf_hf();
+
+    /* dot product */
+    test_vdmpy_sf_hf(false);
+    test_vdmpy_sf_hf(true);
+
+    test_new();
+
+    puts(err ? "FAIL" : "PASS");
+    return err ? 1 : 0;
+}
diff --git a/tests/tcg/hexagon/fp_hvx_disabled.c b/tests/tcg/hexagon/fp_hvx_disabled.c
new file mode 100644
index 0000000000..388a42e2b7
--- /dev/null
+++ b/tests/tcg/hexagon/fp_hvx_disabled.c
@@ -0,0 +1,57 @@
+/*
+ *  Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <hexagon_types.h>
+#include <hvx_hexagon_protos.h>
+
+int err;
+#include "hvx_misc.h"
+
+static void test_disabled(void)
+{
+    memset(output, 0xAA, sizeof(output));
+    memset(expect, 0, sizeof(expect));
+    asm volatile("r0 = #0xff\n"
+                 "v0 = vsplat(r0)\n"
+                 "r1 = #0x1\n"
+                 "v1 = vsplat(r1)\n"
+                 "v2 = vsplat(r1)\n"
+                 "v0.sf = vadd(v1.sf, v2.sf)\n"
+                 "vmem(%0 + #0) = v0\n"
+                 :
+                 : "r"(output)
+                 : "r0", "r1", "v0", "v1", "v2", "memory");
+    check_output_w(__LINE__, 1);
+}
+
+static void test_disabled_with_new(void)
+{
+    memset(output, 0xAA, sizeof(output));
+    memset(expect, 0, sizeof(expect));
+    asm volatile("r0 = #0xff\n"
+                 "v0 = vsplat(r0)\n"
+                 "r1 = #0x1\n"
+                 "v1 = vsplat(r1)\n"
+                 "v2 = vsplat(r1)\n"
+                 "{\n"
+                 "    v0.sf = vadd(v1.sf, v2.sf)\n"
+                 "    vmem(%0 + #0) = v0.new\n"
+                 "}\n"
+                 :
+                 : "r"(output)
+                 : "r0", "r1", "v0", "v1", "v2", "memory");
+    check_output_w(__LINE__, 1);
+}
+
+int main(void)
+{
+    test_disabled();
+    test_disabled_with_new();
+    puts(err ? "FAIL" : "PASS");
+    return err ? 1 : 0;
+}
diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
index 549c95082f..789721bdac 100644
--- a/tests/tcg/hexagon/Makefile.target
+++ b/tests/tcg/hexagon/Makefile.target
@@ -50,6 +50,8 @@ HEX_TESTS += vector_add_int
 HEX_TESTS += scatter_gather
 HEX_TESTS += hvx_misc
 HEX_TESTS += hvx_histogram
+HEX_TESTS += fp_hvx
+HEX_TESTS += fp_hvx_disabled
 HEX_TESTS += invalid-slots
 HEX_TESTS += invalid-encoding
 HEX_TESTS += multiple-writes
@@ -126,6 +128,12 @@ v68_hvx: CFLAGS += -mhvx -Wno-unused-function
 v69_hvx: v69_hvx.c hvx_misc.h
 v69_hvx: CFLAGS += -mhvx -Wno-unused-function
 v73_scalar: CFLAGS += -Wno-unused-function
+fp_hvx: fp_hvx.c hvx_misc.h
+fp_hvx: CFLAGS += -mhvx -mhvx-ieee-fp
+fp_hvx_disabled: fp_hvx_disabled.c hvx_misc.h
+fp_hvx_disabled: CFLAGS += -mhvx -mhvx-ieee-fp
+
+run-fp_hvx_disabled: QEMU_OPTS += -cpu v73,ieee-fp=false
 
 hvx_histogram: hvx_histogram.c hvx_histogram_row.S
 	$(CC) $(CFLAGS) $(CROSS_CC_GUEST_CFLAGS) $^ -o $@ $(LDFLAGS)
-- 
2.37.2


