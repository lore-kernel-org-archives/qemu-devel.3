Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F9EF45A0A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 18:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBG5u-0006so-3A; Fri, 10 Apr 2026 13:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wBG5r-0006rm-RW
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 13:56:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wBG5l-0001gA-TJ
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 13:56:33 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63AHP9so707656
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 17:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=V6nVKixGSjR
 GXMplnHG6wHz1J9IW5gbrlupSNq0KwoE=; b=d6azzeHuQIsWtlC0SCSG/Xrl4MN
 DSdV5PVdO+m06k+bPWmbts76mJ8hlYzRqzqZoy+23vdMiIlhN/5P+P0CE3RbKIdF
 nb1PfS6f8NTSQQXYtfYYF/o14i0I6K2IXMzOEhFPYElJ4KcrYUG2i+MIrNpz6HM4
 ufsdJ2fTpb0qpVRqdsNFwHomqRExImjkWrDWqEA8gyRINXMwOYM9+K90bHYsCMjk
 RjexjvKoSKrKauDEw2LLknMe5WfhxAA3dAGKKwOKk+dTXB5pt1+0JSIuPwt0xWs3
 Lz+59W0x/WBXoYpOF/ONh7rV65ADwRbMEctI5O0XVUHP47NfdGhMTXXYHyA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deudj2dhq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 17:56:24 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2d443c3b094so4176171eec.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 10:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775843783; x=1776448583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V6nVKixGSjRGXMplnHG6wHz1J9IW5gbrlupSNq0KwoE=;
 b=J1lGF1zMxKiExdOw4dVokylJ/RBfXxKfV4oRBk7z8TkZSQZOcDr4T11oW3yjmEL8wY
 VV6REQ0odjaGQ6Rjl/nV7zLS98So1GPd1fjEnoisI5JGv3Or/f8xUZJWSwez6xBAlrMS
 gv2ZzhOIWPlmh7TdgPxZjkcRS5OUPnkntHvVBudQG4ETdpdjx/r8xh4WSZ3Ap/AXroZz
 zfMw+CA16GpuAEpjXsvCdWS3RUqeM0gpzyqnX/ysp/H/0gQx1IsglAbhjfpgi9ShGtiU
 HLSsTd0tjzGbt+hEM/AIONKvVjDUCrngI1+Q+jrlKYRTBU4w4LgbKm8UvmflJtkZ9URM
 lcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775843783; x=1776448583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V6nVKixGSjRGXMplnHG6wHz1J9IW5gbrlupSNq0KwoE=;
 b=oPC9ucwcsm4C1XmaLGT4UnvYgnjA2awnSMHv6v9DDVmqEcNdJo6EepnvbvReLAdJPA
 flxJE80LX6zFfCIUr1ognByYh8I7O9poxwgqXZaOhj4X621FSeVjdff4tOu04gbfZLob
 DoRjI8UntaBs0wYtSmABO/MDliL77mkNhR9V05CBWtm4N5rOk5MwswCo8UCkEVmu/Cnv
 1XHMweMDG9K0kTbzd0QrM6osOkxCNuQUpjR8MOrvhjnLeI0CNVV+vOfH/AaTolHbqOF+
 1btr0KwbIOdzDpPQr/CdToDbaR1bKIIFb14zLke8h68qHCAsYwkxrq7NJFLiDi5ecJDz
 ki2w==
X-Gm-Message-State: AOJu0YxTWR9j2oZ+iAafWLC+yqoGS7FbWpAp8pJH6+T4Qj+/D9CABjSR
 8I7+2KASwYDYJ3G+MIZh4m2grWIhspJ0SYsF4hpUsk4bEibQXZkrDj6fqeeAUYNHXwP+w5rfI4T
 V5WHBM7qNUO/qTAcG2zb5c6Xv32zHz1vhPKeW70HzYSUShqbxWg34fhaRvaYvlsy3PEgY
X-Gm-Gg: AeBDieuBWBVbFk96VD9NBlr8s7RYoVyu4R40ogPQ4lI0v2a1GjBYP6FI8kgVNd03o58
 Dl0aK8Ud0n9iSGkUH+DP6Zv6nHQBFyklz76avNwPtnV79Ko48SlJAjjlSvC9eOEAWPD1vKv89KX
 XgZn7cuHKZf0WC130dT5y3+vVWRwr27HryPFG2coU1tp8/kzKvLJi81YqFygL66lUfYE1pL0MPZ
 Tj3tBvW/YI1sVRObxB36c+pZAmF0tg2YcU+zTaIli0q8J2nO5oRFx6DSS8LTTUvkokke/qWea5T
 G9xX10jW9hAoyPXCWP5gp0cTTzehRoCAtcNdW7MS/lRvAlP6I2r8uyrarugPeUXJhxvnSde7gCh
 7RdnQ3F6xioyfxECyic7mZKDQqx7TGtIk07dUWjr3frEq1swISfhv2AGGNf/MraM2IGE3fgKehj
 j/DUp4uQYf
X-Received: by 2002:a05:7022:f92:b0:128:bae0:e043 with SMTP id
 a92af1059eb24-12c34f14057mr2569948c88.31.1775843782433; 
 Fri, 10 Apr 2026 10:56:22 -0700 (PDT)
X-Received: by 2002:a05:7022:f92:b0:128:bae0:e043 with SMTP id
 a92af1059eb24-12c34f14057mr2569907c88.31.1775843781697; 
 Fri, 10 Apr 2026 10:56:21 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c3459f7ffsm4256271c88.3.2026.04.10.10.56.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 10:56:21 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v4 14/16] tests/hexagon: add tests for v68 HVX IEEE float
 conversions
Date: Fri, 10 Apr 2026 10:56:02 -0700
Message-Id: <c20a21aad60f09fe7e971d81503370a782c9319f.1775843299.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775843299.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775843299.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: LQxqnRYlL8hfFVOOhp_Aub7f0ltPhE8M
X-Proofpoint-GUID: LQxqnRYlL8hfFVOOhp_Aub7f0ltPhE8M
X-Authority-Analysis: v=2.4 cv=cKfQdFeN c=1 sm=1 tr=0 ts=69d939c8 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=OZRFAO6Uk6ULta4fWVgA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDE2OCBTYWx0ZWRfX49/UIBY06b8K
 PEcmplWEwbb70qpjO7I/0yS19lqPZEni+It3GSstP47xajLx5Mv1Hbk/w6Wm39hzct6CwnLMT2P
 HrjVRtPinqvnnsaZeo2mJg2Tv3+fbS0/44Xk03ONqvT2rVpTu28vxB7U0bBkRV4eeekVtwGbNad
 5wlLbegySHlL+JVzbfnfA7IzKSIryNhqo0fLLNIsb+Av15S0ydMbl46mwpxJfxLJ6crBjcBlEAM
 syOnPEXI/gRRXX2hitMpesWqd0nUL/oKISWMOTtJGkpSnNm8u1TScZmLzRKgIJU6jvGlRUPTa6Q
 wlteHy5Ntz9DIDGVFUFJpVbsSOdayHE3EMOMa8AOXj274BJpwfnFj2CQCOSHnvVOUflyhXAi2Tw
 FDnTxYlVla0NsAweHxZUcW4NpJ29giRL1xkcW6C5LRy2oSabnTlFz5P8R17TYRr438pcqbXAlFN
 eX5z8L5wCyEnPKjTQyw==
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

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 tests/tcg/hexagon/hex_test.h      |  14 +++
 tests/tcg/hexagon/hvx_misc.h      |   2 +
 tests/tcg/hexagon/fp_hvx_cvt.c    | 188 ++++++++++++++++++++++++++++++
 tests/tcg/hexagon/Makefile.target |   3 +
 4 files changed, 207 insertions(+)
 create mode 100644 tests/tcg/hexagon/fp_hvx_cvt.c

diff --git a/tests/tcg/hexagon/hex_test.h b/tests/tcg/hexagon/hex_test.h
index e7a6644d41..d5da8ad240 100644
--- a/tests/tcg/hexagon/hex_test.h
+++ b/tests/tcg/hexagon/hex_test.h
@@ -111,6 +111,20 @@ static inline void __check64_ne(int line, uint64_t val, uint64_t expect)
     "usr = r2\n\t"
 
 /* Some useful floating point values */
+const uint16_t HF_INF = 0x7c00;
+const uint16_t HF_INF_neg = 0xfc00;
+const uint16_t HF_QNaN = 0x7e00;
+const uint16_t HF_SNaN = 0x7d00;
+const uint16_t HF_QNaN_neg = 0xfe00;
+const uint16_t HF_zero = 0x0000;
+const uint16_t HF_zero_neg = 0x8000;
+const uint16_t HF_one = 0x3c00;
+const uint16_t HF_one_recip = 0x3bf9;
+const uint16_t HF_two = 0x4000;
+const uint16_t HF_small_neg = 0x8010;
+const uint16_t HF_any = 0x3c00;
+const uint16_t HF_neg_two = 0xc000;
+
 const uint32_t SF_INF =              0x7f800000;
 const uint32_t SF_INF_neg =          0xff800000;
 const uint32_t SF_QNaN =             0x7fc00000;
diff --git a/tests/tcg/hexagon/hvx_misc.h b/tests/tcg/hexagon/hvx_misc.h
index 0330cb289d..43de20da6a 100644
--- a/tests/tcg/hexagon/hvx_misc.h
+++ b/tests/tcg/hexagon/hvx_misc.h
@@ -69,7 +69,9 @@ CHECK_OUTPUT_FUNC(d,  8)
 CHECK_OUTPUT_FUNC(w,  4)
 CHECK_OUTPUT_FUNC(sf, 4)
 CHECK_OUTPUT_FUNC(h,  2)
+CHECK_OUTPUT_FUNC(uh, 2)
 CHECK_OUTPUT_FUNC(hf, 2)
+CHECK_OUTPUT_FUNC(ub,  1)
 CHECK_OUTPUT_FUNC(b,  1)
 
 static inline void init_buffers(void)
diff --git a/tests/tcg/hexagon/fp_hvx_cvt.c b/tests/tcg/hexagon/fp_hvx_cvt.c
new file mode 100644
index 0000000000..71c3f0fd4f
--- /dev/null
+++ b/tests/tcg/hexagon/fp_hvx_cvt.c
@@ -0,0 +1,188 @@
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
+#if __HEXAGON_ARCH__ > 75
+#error "After v75, compiler will replace some FP HVX instructions."
+#endif
+
+int err;
+#include "hvx_misc.h"
+#include "hex_test.h"
+
+#define TEST_EXP(TO, FROM, VAL, EXP) do { \
+    ((MMVector *)&buffer)->FROM[index] = VAL; \
+    expect[0].TO[index] = EXP; \
+    index++; \
+} while (0)
+
+#define DEF_TEST_CVT(TO, FROM, TESTS) \
+    static void test_vcvt_##TO##_##FROM(void) \
+    { \
+        HVX_Vector *hvx_output = (HVX_Vector *)&output[0]; \
+        HVX_Vector buffer; \
+        int index = 0; \
+        memset(&buffer, 0, sizeof(buffer)); \
+        memset(expect, 0, sizeof(expect)); \
+        TESTS \
+        *hvx_output = Q6_V##TO##_vcvt_V##FROM(buffer); \
+        check_output_##TO(__LINE__, 1); \
+    }
+
+DEF_TEST_CVT(uh, hf, { \
+    TEST_EXP(uh, hf, HF_QNaN, UINT16_MAX); \
+    TEST_EXP(uh, hf, HF_SNaN, UINT16_MAX); \
+    TEST_EXP(uh, hf, HF_QNaN_neg, UINT16_MAX); \
+    TEST_EXP(uh, hf, HF_INF, UINT16_MAX); \
+    TEST_EXP(uh, hf, HF_INF_neg, 0); \
+    TEST_EXP(uh, hf, HF_neg_two, 0); \
+    TEST_EXP(uh, hf, HF_zero_neg, 0); \
+    TEST_EXP(uh, hf, raw_hf((_Float16)2.1), 2); \
+    TEST_EXP(uh, hf, HF_one_recip, 1); \
+})
+
+DEF_TEST_CVT(h, hf, { \
+    TEST_EXP(h, hf, HF_QNaN, INT16_MAX); \
+    TEST_EXP(h, hf, HF_SNaN, INT16_MAX); \
+    TEST_EXP(h, hf, HF_QNaN_neg, INT16_MAX); \
+    TEST_EXP(h, hf, HF_INF, INT16_MAX); \
+    TEST_EXP(h, hf, HF_INF_neg, INT16_MIN); \
+    TEST_EXP(h, hf, HF_neg_two, -2); \
+    TEST_EXP(h, hf, HF_zero_neg, 0); \
+    TEST_EXP(h, hf, raw_hf((_Float16)2.1), 2); \
+    TEST_EXP(h, hf, HF_one_recip, 1); \
+})
+
+/*
+ * Some cvt operations take two vectors as input and perform the following:
+ *    VdV.TO[4*i]   = OP(VuV.FROM[2*i]);
+ *    VdV.TO[4*i+1] = OP(VuV.FROM[2*i+1]);
+ *    VdV.TO[4*i+2] = OP(VvV.FROM[2*i]);
+ *    VdV.TO[4*i+3] = OP(VvV.FROM[2*i+1]))
+ * We use bf_index and index in a way that the tests are always done either
+ * using the first or third line of the above snippet.
+ */
+#define TEST_EXP_2(TO, FROM, VAL, EXP) do { \
+    ((MMVector *)&buffers[bf_index])->FROM[2 * index] = VAL; \
+    expect[0].TO[(4 * index) + (2 * bf_index)] = EXP; \
+    index++; \
+    bf_index = (bf_index + 1) % 2; \
+} while (0)
+
+#define DEF_TEST_CVT_2(TO, FROM, TESTS) \
+    static void test_vcvt_##TO##_##FROM(void) \
+    { \
+        HVX_Vector *hvx_output = (HVX_Vector *)&output[0]; \
+        HVX_Vector buffers[2]; \
+        int index = 0, bf_index = 0; \
+        memset(&buffers, 0, sizeof(buffers)); \
+        memset(expect, 0, sizeof(expect)); \
+        TESTS \
+        *hvx_output = Q6_V##TO##_vcvt_V##FROM##V##FROM(buffers[0], buffers[1]); \
+        check_output_##TO(__LINE__, 1); \
+    }
+
+DEF_TEST_CVT_2(ub, hf, { \
+    TEST_EXP_2(ub, hf, HF_QNaN, UINT8_MAX); \
+    TEST_EXP_2(ub, hf, HF_SNaN, UINT8_MAX); \
+    TEST_EXP_2(ub, hf, HF_QNaN_neg, UINT8_MAX); \
+    TEST_EXP_2(ub, hf, HF_INF, UINT8_MAX); \
+    TEST_EXP_2(ub, hf, HF_INF_neg, 0); \
+    TEST_EXP_2(ub, hf, HF_small_neg, 0); \
+    TEST_EXP_2(ub, hf, HF_neg_two, 0); \
+    TEST_EXP_2(ub, hf, HF_zero_neg, 0); \
+    TEST_EXP_2(ub, hf, raw_hf((_Float16)2.1), 2); \
+    TEST_EXP_2(ub, hf, HF_one_recip, 1); \
+})
+
+DEF_TEST_CVT_2(b, hf, { \
+    TEST_EXP_2(b, hf, HF_QNaN, INT8_MAX); \
+    TEST_EXP_2(b, hf, HF_SNaN, INT8_MAX); \
+    TEST_EXP_2(b, hf, HF_QNaN_neg, INT8_MAX); \
+    TEST_EXP_2(b, hf, HF_INF, INT8_MAX); \
+    TEST_EXP_2(b, hf, HF_INF_neg, INT8_MIN); \
+    TEST_EXP_2(b, hf, HF_small_neg, 0); \
+    TEST_EXP_2(b, hf, HF_neg_two, -2); \
+    TEST_EXP_2(b, hf, HF_zero_neg, 0); \
+    TEST_EXP_2(b, hf, raw_hf((_Float16)2.1), 2); \
+    TEST_EXP_2(b, hf, HF_one_recip, 1); \
+})
+
+#define DEF_TEST_VCONV(TO, FROM, TESTS) \
+    static void test_vconv_##TO##_##FROM(void) \
+    { \
+        HVX_Vector *hvx_output = (HVX_Vector *)&output[0]; \
+        HVX_Vector buffer; \
+        int index = 0; \
+        memset(&buffer, 0, sizeof(buffer)); \
+        memset(expect, 0, sizeof(expect)); \
+        TESTS \
+        *hvx_output = Q6_V##TO##_equals_V##FROM(buffer); \
+        check_output_##TO(__LINE__, 1); \
+    }
+
+DEF_TEST_VCONV(w, sf, { \
+    TEST_EXP(w, sf, SF_QNaN, INT32_MAX); \
+    TEST_EXP(w, sf, SF_SNaN, INT32_MAX); \
+    TEST_EXP(w, sf, SF_QNaN_neg, INT32_MIN); \
+    TEST_EXP(w, sf, SF_INF, INT32_MAX); \
+    TEST_EXP(w, sf, SF_INF_neg, INT32_MIN); \
+    TEST_EXP(w, sf, SF_small_neg, 0); \
+    TEST_EXP(w, sf, SF_neg_two, -2); \
+    TEST_EXP(w, sf, SF_zero_neg, 0); \
+    TEST_EXP(w, sf, raw_sf(2.1f), 2); \
+    TEST_EXP(w, sf, raw_sf(2.8f), 2); \
+})
+
+DEF_TEST_VCONV(h, hf, { \
+    TEST_EXP(h, hf, HF_QNaN, INT16_MAX); \
+    TEST_EXP(h, hf, HF_SNaN, INT16_MAX); \
+    TEST_EXP(h, hf, HF_QNaN_neg, INT16_MIN); \
+    TEST_EXP(h, hf, HF_INF, INT16_MAX); \
+    TEST_EXP(h, hf, HF_INF_neg, INT16_MIN); \
+    TEST_EXP(h, hf, HF_small_neg, 0); \
+    TEST_EXP(h, hf, HF_neg_two, -2); \
+    TEST_EXP(h, hf, HF_zero_neg, 0); \
+    TEST_EXP(h, hf, raw_hf((_Float16)2.1), 2); \
+    TEST_EXP(h, hf, raw_hf((_Float16)2.8), 2); \
+})
+
+DEF_TEST_VCONV(hf, h, { \
+    TEST_EXP(hf, h, 0, HF_zero); \
+    TEST_EXP(hf, h, 2, HF_two); \
+    TEST_EXP(hf, h, -2, HF_neg_two); \
+    TEST_EXP(hf, h, 2049, raw_hf((_Float16)2048)); /* rounds DOWN */ \
+    TEST_EXP(hf, h, 2051, raw_hf((_Float16)2052)); /* rounds UP */ \
+})
+
+DEF_TEST_VCONV(sf, w, { \
+    TEST_EXP(sf, w, 0, SF_zero); \
+    TEST_EXP(sf, w, 2, SF_two); \
+    TEST_EXP(sf, w, -2, SF_neg_two); \
+    TEST_EXP(sf, w, 16777217, raw_sf((float)16777216)); /* rounds DOWN */ \
+    TEST_EXP(sf, w, 16777219, raw_sf((float)16777220)); /* rounds UP */ \
+})
+
+int main(void)
+{
+    test_vcvt_uh_hf();
+    test_vcvt_h_hf();
+    test_vcvt_ub_hf();
+    test_vcvt_b_hf();
+    test_vconv_w_sf();
+    test_vconv_sf_w();
+    test_vconv_h_hf();
+    test_vconv_hf_h();
+
+    puts(err ? "FAIL" : "PASS");
+    return err ? 1 : 0;
+}
diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
index afd3dd6d19..1abc5f2124 100644
--- a/tests/tcg/hexagon/Makefile.target
+++ b/tests/tcg/hexagon/Makefile.target
@@ -51,6 +51,7 @@ HEX_TESTS += scatter_gather
 HEX_TESTS += hvx_misc
 HEX_TESTS += hvx_histogram
 HEX_TESTS += fp_hvx
+HEX_TESTS += fp_hvx_cvt
 HEX_TESTS += fp_hvx_disabled
 HEX_TESTS += invalid-slots
 HEX_TESTS += invalid-encoding
@@ -132,6 +133,8 @@ fp_hvx: fp_hvx.c hvx_misc.h hex_test.h
 fp_hvx: CFLAGS += -mhvx -mhvx-ieee-fp
 fp_hvx_disabled: fp_hvx_disabled.c hvx_misc.h hex_test.h
 fp_hvx_disabled: CFLAGS += -mhvx -mhvx-ieee-fp
+fp_hvx_cvt: fp_hvx_cvt.c hvx_misc.h hex_test.h
+fp_hvx_cvt: CFLAGS += -mhvx -mhvx-ieee-fp
 
 run-fp_hvx_disabled: QEMU_OPTS += -cpu v73,ieee-fp=false
 
-- 
2.37.2


