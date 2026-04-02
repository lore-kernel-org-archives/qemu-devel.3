Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E03D39410
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 10:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8FbU-0005fu-Fn; Thu, 02 Apr 2026 06:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w8Fap-0004l3-6s
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:48:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w8Fak-0007q9-RK
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:48:06 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6328RsVY352251
 for <qemu-devel@nongnu.org>; Thu, 2 Apr 2026 10:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=RfmOA1oJRbM
 59T5jNLihWyqgY4oN9Qis1RTJ8xh8eSY=; b=SDPCcNE+wHgTOvJwL0HTmbj6QyC
 6gFYb/Sn7UCy3cSl0BdlD0D7Z9FMvy5XERH8b0o9cAZ4S6aX38JcVbG3eN1eUhdL
 brcnmgUb93SBg9TdXh1IIPNeWa7Oqjf/jLe5fW0WrmDHhTjIkNzZ7Jbzumw/vxdv
 4jmPfAwEYdTi+KIpsnglpmcdCVyybiobLUzfgaBz10bm2rvL8B4bfIjRjvqrBvmE
 5Tjyh1dHPJCx7tDbNgtZxuSJYNBZfHnfcuiyZxonhUjRapJlwTDdg6ZnyuxKiqZf
 UFCH3hN8KO187xr6TwbQ+cWkMKYWlEHA5KR9K4pMulYkiTdnzliNFxpel6Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9myh8h1h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 10:47:51 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2c72849f648so3525638eec.0
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 03:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775126871; x=1775731671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RfmOA1oJRbM59T5jNLihWyqgY4oN9Qis1RTJ8xh8eSY=;
 b=Go+OuH3mW0acjhj/qXWxBiP+yWQ6x20xSqVgxLe69g8L0UxiKRxUNwgtPYqMex6uRD
 wFinOvCB8BC2hYtydQlVnToQAaT7/6eecYhKXfpGuwMdRw0zMUeTLvylHec/4Lac/L+D
 iC6W1Zsk41EXb3nVdhUqYB2IXdoKg7Cbj9uS6SHkDM0agp1IY6dCW0qEodfX2yT6TRtr
 0s3JNs3NeIawleNcgNZr1ySQDXcfjqSGodYCmeoSHP19E+o5ZheKi9jmY5NywnOoEU/7
 fX/XHIvooac2QYFwypFPTor5j8sonZt0UXR+AzOyL0BTYnLkp3pUNGWC2tpcgSGIuHYS
 5kPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775126871; x=1775731671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RfmOA1oJRbM59T5jNLihWyqgY4oN9Qis1RTJ8xh8eSY=;
 b=SnDGFwmhc1CWARBe/UVL3aBqju8kPKvPQl5b3krU5AvqPNutrQKwz2s36cA+9uLLts
 qu3H51QSnhQTFGsjtVTPdIQXNBBE28rZdFtpzPai8bkPFazstbNlpFxfeOuqiQNJJZ9n
 fCOYlUka3wSbzxPx1K9TzRv2GpmaXTJVt6qXACDkaGjc2XxRg6rWEgXYmcgUcOv+IMVt
 3p9tGpNCYvO6p0hZTl8ROj1ycI5YeE5IzJfjY3tCN34slps9jIBJAGdXjwBYeMaUWxEg
 JrMv4Lo5lYGYrcbY6wmKUCUw1GRTuV07EbDwjPAe1uxkO2Db7fR+SnYIPi/SlYBeylYP
 iF8A==
X-Gm-Message-State: AOJu0Yz9SzR4toZ4pMUjhGyS5PBNzAEdd68SWtXpiRay/tTToikU79cm
 WOZLhcXpCbnPcQkHI0K8tOuIM5dvZocnStmRrrr5TVQp9GU54oYNAuFP2mqF9Mis4FhNpxeFngi
 Qsw1A9HMQHiQG8gSrJwuhuLQwBgqS0TumVJT6at7Rm06LevjdVDgzjNlveZsIG9iDdg+D
X-Gm-Gg: ATEYQzz+UhoQR8s/urzSWPkAxBb480oQwmA7PQwzqFtOspDpgtVNFml3x+holdub6/7
 sdMFLSmz7SbxTeC0F3J35CZ713P7djdcURHvTmXjk0bRYDnQvY27srQMyAhWJmm4gE1qULrXq5q
 MQQTxexykOwoS7KP90wiSiGWeyESZybk3czcbb6jVmpvPlW7ZNgbVpp/avztE2z90k4uR5ObIT8
 KxOE1wW21CYCnic2jfgHNmcAY7gwygpqw2ssQheCaustNjLeXP7agyKcGAgQ3BRC28FkSvTd4ym
 Oqk59EYCVeX2hscF2Urvlh/cndkhdLn7FI85m38sgBeKQSi2G9TtEoHqHC8Wig+1h7MvEqE6BrT
 HfHDc7wvsqlz9EZ2uUEKV+QV5rTCQtF1/8InmL9wio+3GilO0Il7Vkf2qTe0LLlt3MKX6bwxrMy
 DlBNTzpeSZ
X-Received: by 2002:a05:7300:3708:b0:2c7:ea98:da0 with SMTP id
 5a478bee46e88-2c9323b72c2mr4144145eec.19.1775126870630; 
 Thu, 02 Apr 2026 03:47:50 -0700 (PDT)
X-Received: by 2002:a05:7300:3708:b0:2c7:ea98:da0 with SMTP id
 5a478bee46e88-2c9323b72c2mr4144129eec.19.1775126870016; 
 Thu, 02 Apr 2026 03:47:50 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca7d00f5easm2004783eec.29.2026.04.02.03.47.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 03:47:49 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v2 15/16] tests/hexagon: add tests for v68 HVX IEEE float
 comparisons
Date: Thu,  2 Apr 2026 03:47:32 -0700
Message-Id: <7058091ab3c247cd7c94c6505dec6fc0bd9be196.1775122853.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -Y4RDZ_6zPNN9RbzA5jSUKK8IMVD9Se_
X-Proofpoint-ORIG-GUID: -Y4RDZ_6zPNN9RbzA5jSUKK8IMVD9Se_
X-Authority-Analysis: v=2.4 cv=JII2csKb c=1 sm=1 tr=0 ts=69ce4957 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=g6BQdadCeQXt8ut-Y_AA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA5NyBTYWx0ZWRfXxaRQXCJfRsUb
 kSAIjzE2eq8+r1NFwtB+5O3olZyBG2CXa8u1Yg2uTjns1QrwVE2kVSNn+C5U9mMk7ZQ/z5rZmoA
 22BRhzwMcGJGpQ1P65oIdtaUr2L5wGCNiS5111pj0Cd5ZKRk2Zw9doIT55LjnrzbgwZpwg4UHpu
 WvO0TnmRoE9xi+EIKQe1CkED8JdU+NUq9gJOQhWs9BM6Q6WKNBpchcpCc6vvVSMJHJwcOccJGg8
 A6W/12qmcTiEgpPHJRXN5hZLCuX1txylGJ8QxTU5kzcfbOpvBmcXlZUQjN5Tf9Ry693O/Kg88se
 lGZtBgX7y4VWkSd8M++MyKgYhe15x7nWk+9cfUaX0kFwThmD3DpKKKeR3sDyd1AQRaP2oU6XcuU
 1m5nsnHx3eU7ynZ7dwlHfrDSiI9geXTTo0H/AGcmyxKrEaRWVzJMPesDCQIqj5vleU/o+mD1lBU
 FIKfdh1janh5Vai401w==
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

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 tests/tcg/hexagon/hex_test.h      |   1 +
 tests/tcg/hexagon/fp_hvx_cmp.c    | 227 ++++++++++++++++++++++++++++++
 tests/tcg/hexagon/Makefile.target |   3 +
 3 files changed, 231 insertions(+)
 create mode 100644 tests/tcg/hexagon/fp_hvx_cmp.c

diff --git a/tests/tcg/hexagon/hex_test.h b/tests/tcg/hexagon/hex_test.h
index d5da8ad240..79d30ec61c 100644
--- a/tests/tcg/hexagon/hex_test.h
+++ b/tests/tcg/hexagon/hex_test.h
@@ -115,6 +115,7 @@ const uint16_t HF_INF = 0x7c00;
 const uint16_t HF_INF_neg = 0xfc00;
 const uint16_t HF_QNaN = 0x7e00;
 const uint16_t HF_SNaN = 0x7d00;
+const uint16_t HF_SNaN_neg = 0xfd00;
 const uint16_t HF_QNaN_neg = 0xfe00;
 const uint16_t HF_zero = 0x0000;
 const uint16_t HF_zero_neg = 0x8000;
diff --git a/tests/tcg/hexagon/fp_hvx_cmp.c b/tests/tcg/hexagon/fp_hvx_cmp.c
new file mode 100644
index 0000000000..c4e1c81ce5
--- /dev/null
+++ b/tests/tcg/hexagon/fp_hvx_cmp.c
@@ -0,0 +1,227 @@
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
+#include <assert.h>
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
+#define MAX_TESTS_hf (MAX_VEC_SIZE_BYTES / 2)
+#define MAX_TESTS_sf (MAX_VEC_SIZE_BYTES / 4)
+
+#define TRUE_MASK_sf 0xffffffff
+#define TRUE_MASK_hf 0xffff
+
+static const char *comparisons[MAX_TESTS_sf][2];
+static HVX_Vector *hvx_output = (HVX_Vector *)&output[0];
+static HVX_Vector buffers[2], true_vec, false_vec;
+static int exp_index;
+
+#define ADD_TEST_CMP(TYPE, VAL1, VAL2, EXP) do { \
+    ((MMVector *)&buffers[0])->TYPE[exp_index] = VAL1; \
+    ((MMVector *)&buffers[1])->TYPE[exp_index] = VAL2; \
+    expect[0].TYPE[exp_index] = EXP ? TRUE_MASK_##TYPE : 0; \
+    comparisons[exp_index][0] = #VAL1; \
+    comparisons[exp_index][1] = #VAL2; \
+    assert(exp_index < MAX_TESTS_##TYPE); \
+    exp_index++; \
+} while (0)
+
+#define TEST_CMP_GT(TYPE, VAL1, VAL2) do { \
+    ADD_TEST_CMP(TYPE, VAL1, VAL2, true); \
+    ADD_TEST_CMP(TYPE, VAL2, VAL1, false); \
+} while (0)
+
+#define PREP_TEST() do { \
+    memset(&buffers, 0, sizeof(buffers)); \
+    memset(expect, 0, sizeof(expect)); \
+    exp_index = 0; \
+} while (0)
+
+#define CHECK(TYPE, TYPESZ) do { \
+    HVX_VectorPred pred = Q6_Q_vcmp_gt_V##TYPE##V##TYPE(buffers[0], buffers[1]); \
+    *hvx_output = Q6_V_vmux_QVV(pred, true_vec, false_vec); \
+    for (int j = 0; j < MAX_VEC_SIZE_BYTES / TYPESZ; j++) { \
+        if (output[0].TYPE[j] != expect[0].TYPE[j]) { \
+            printf("ERROR: expected %s %s %s\n", comparisons[j][0], \
+                   (expect[0].TYPE[j] != 0 ? ">" : "<="), comparisons[j][1]); \
+            err++; \
+        } \
+    } \
+} while (0)
+
+static void test_cmp_sf(void)
+{
+    /*
+     * General ordering for sf:
+     * QNaN > SNaN > +Inf > numbers > -Inf > SNaN_neg > QNaN_neg
+     */
+
+    /* Test equality */
+    PREP_TEST();
+    ADD_TEST_CMP(sf, raw_sf(2.2),  raw_sf(2.2),  false);
+    ADD_TEST_CMP(sf, SF_SNaN,      SF_SNaN,      false);
+    CHECK(sf, 4);
+
+    /* Common numbers */
+    PREP_TEST();
+    TEST_CMP_GT(sf, raw_sf(2.2),  raw_sf(2.1));
+    TEST_CMP_GT(sf, raw_sf(0),    raw_sf(-2.2));
+    CHECK(sf, 4);
+
+    /* Infinity vs Infinity/NaN */
+    PREP_TEST();
+    TEST_CMP_GT(sf, SF_QNaN,      SF_INF);
+    TEST_CMP_GT(sf, SF_SNaN,      SF_INF);
+    TEST_CMP_GT(sf, SF_INF,       SF_INF_neg);
+    TEST_CMP_GT(sf, SF_INF,       SF_SNaN_neg);
+    TEST_CMP_GT(sf, SF_INF,       SF_QNaN_neg);
+    TEST_CMP_GT(sf, SF_INF_neg,   SF_SNaN_neg);
+    TEST_CMP_GT(sf, SF_INF_neg,   SF_QNaN_neg);
+    TEST_CMP_GT(sf, SF_SNaN,      SF_INF_neg);
+    TEST_CMP_GT(sf, SF_QNaN,      SF_INF_neg);
+    CHECK(sf, 4);
+
+    /* NaN vs NaN */
+    PREP_TEST();
+    TEST_CMP_GT(sf, SF_QNaN,      SF_SNaN);
+    TEST_CMP_GT(sf, SF_SNaN,      SF_SNaN_neg);
+    TEST_CMP_GT(sf, SF_SNaN_neg,  SF_QNaN_neg);
+    CHECK(sf, 4);
+
+    /* NaN vs non-NaN */
+    PREP_TEST();
+    TEST_CMP_GT(sf, SF_QNaN,      SF_one);
+    TEST_CMP_GT(sf, SF_SNaN,      SF_one);
+    TEST_CMP_GT(sf, SF_one,       SF_QNaN_neg);
+    TEST_CMP_GT(sf, SF_one,       SF_SNaN_neg);
+    CHECK(sf, 4);
+}
+
+static void test_cmp_hf(void)
+{
+    /*
+     * General ordering for hf:
+     * QNaN > SNaN > +Inf > numbers > -Inf > QSNaN_neg > QNaN_neg
+     */
+
+    /* Test equality */
+    PREP_TEST();
+    ADD_TEST_CMP(hf, raw_hf((_Float16)2.2),  raw_hf((_Float16)2.2),  false);
+    ADD_TEST_CMP(hf, HF_SNaN,                HF_SNaN,      false);
+    CHECK(hf, 2);
+
+    /* Common numbers */
+    PREP_TEST();
+    TEST_CMP_GT(hf, raw_hf((_Float16)2.2),  raw_hf((_Float16)2.1));
+    TEST_CMP_GT(hf, raw_hf((_Float16)0),    raw_hf((_Float16)-2.2));
+    CHECK(hf, 2);
+
+    /* Infinity vs Infinity/NaN */
+    PREP_TEST();
+    TEST_CMP_GT(hf, HF_QNaN,      HF_INF);
+    TEST_CMP_GT(hf, HF_SNaN,      HF_INF);
+    TEST_CMP_GT(hf, HF_INF,       HF_INF_neg);
+    TEST_CMP_GT(hf, HF_INF,       HF_SNaN_neg);
+    TEST_CMP_GT(hf, HF_INF,       HF_QNaN_neg);
+    TEST_CMP_GT(hf, HF_INF_neg,   HF_SNaN_neg);
+    TEST_CMP_GT(hf, HF_INF_neg,   HF_QNaN_neg);
+    TEST_CMP_GT(hf, HF_SNaN,      HF_INF_neg);
+    TEST_CMP_GT(hf, HF_QNaN,      HF_INF_neg);
+    CHECK(hf, 2);
+
+    /* NaN vs NaN */
+    PREP_TEST();
+    TEST_CMP_GT(hf, HF_QNaN,      HF_SNaN);
+    TEST_CMP_GT(hf, HF_SNaN,      HF_SNaN_neg);
+    TEST_CMP_GT(hf, HF_SNaN_neg,  HF_QNaN_neg);
+    CHECK(hf, 2);
+
+    /* NaN vs non-NaN */
+    PREP_TEST();
+    TEST_CMP_GT(hf, HF_QNaN,      HF_one);
+    TEST_CMP_GT(hf, HF_SNaN,      HF_one);
+    TEST_CMP_GT(hf, HF_one,       HF_QNaN_neg);
+    TEST_CMP_GT(hf, HF_one,       HF_SNaN_neg);
+    CHECK(hf, 2);
+}
+
+static void test_cmp_variants(void)
+{
+    HVX_VectorPred true_pred, false_pred, pred;
+    memset(&true_pred, 0xff, sizeof(true_pred));
+    memset(&false_pred, 0, sizeof(false_pred));
+
+    PREP_TEST();
+    ADD_TEST_CMP(sf, SF_one,  SF_zero, true);
+    ADD_TEST_CMP(sf, SF_zero, SF_one,  false);
+    ADD_TEST_CMP(sf, SF_one,  SF_zero, true);
+    ADD_TEST_CMP(sf, SF_zero, SF_one,  false);
+
+    /* greater and */
+    pred = Q6_Q_vcmp_gtand_QVsfVsf(true_pred, buffers[0], buffers[1]);
+    *hvx_output = Q6_V_vmux_QVV(pred, true_vec, false_vec);
+    for (int j = 0; j < 4; j++) {
+        int exp = j % 2 ? 0 : 0xffffffff;
+        if (output[0].sf[j] != exp) {
+            printf("ERROR line %d: gtand %d: expected 0x%x got 0x%x\n",
+                   __LINE__, j, exp, output[0].sf[j]);
+            err++;
+        }
+    }
+    pred = Q6_Q_vcmp_gtand_QVsfVsf(false_pred, buffers[0], buffers[1]);
+    *hvx_output = Q6_V_vmux_QVV(pred, true_vec, false_vec);
+    for (int j = 0; j < 4; j++) {
+        if (output[0].sf[j]) {
+            printf("ERROR line %d: gtand %d: expected false\n", __LINE__, j);
+            err++;
+        }
+    }
+
+    /* greater or */
+    pred = Q6_Q_vcmp_gtor_QVsfVsf(false_pred, buffers[0], buffers[1]);
+    *hvx_output = Q6_V_vmux_QVV(pred, true_vec, false_vec);
+    for (int j = 0; j < 4; j++) {
+        int exp = j % 2 ? 0 : 0xffffffff;
+        if (output[0].sf[j] != exp) {
+            printf("ERROR line %d: gtor %d: expected 0x%x got 0x%x\n",
+                   __LINE__, j, exp, output[0].sf[j]);
+            err++;
+        }
+    }
+    pred = Q6_Q_vcmp_gtor_QVsfVsf(true_pred, buffers[0], buffers[1]);
+    *hvx_output = Q6_V_vmux_QVV(pred, true_vec, false_vec);
+    for (int j = 0; j < 4; j++) {
+        if (!output[0].sf[j]) {
+            printf("ERROR line %d: gtor %d: expected true\n", __LINE__, j);
+            err++;
+        }
+    }
+}
+
+int main(void)
+{
+    memset(&true_vec, 0xff, sizeof(true_vec));
+    memset(&false_vec, 0, sizeof(false_vec));
+
+    test_cmp_sf();
+    test_cmp_hf();
+    test_cmp_variants();
+
+    puts(err ? "FAIL" : "PASS");
+    return err ? 1 : 0;
+}
diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
index 83969e0e73..76ba245add 100644
--- a/tests/tcg/hexagon/Makefile.target
+++ b/tests/tcg/hexagon/Makefile.target
@@ -52,6 +52,7 @@ HEX_TESTS += hvx_misc
 HEX_TESTS += hvx_histogram
 HEX_TESTS += fp_hvx
 HEX_TESTS += fp_hvx_cvt
+HEX_TESTS += fp_hvx_cmp
 HEX_TESTS += fp_hvx_disabled
 HEX_TESTS += invalid-slots
 HEX_TESTS += invalid-encoding
@@ -135,6 +136,8 @@ fp_hvx_disabled: fp_hvx_disabled.c hvx_misc.h
 fp_hvx_disabled: CFLAGS += -mhvx -mhvx-ieee-fp
 fp_hvx_cvt: fp_hvx_cvt.c hvx_misc.h
 fp_hvx_cvt: CFLAGS += -mhvx -mhvx-ieee-fp
+fp_hvx_cmp: fp_hvx_cmp.c hvx_misc.h
+fp_hvx_cmp: CFLAGS += -mhvx -mhvx-ieee-fp
 
 run-fp_hvx_disabled: QEMU_OPTS += -cpu v73,ieee-fp=false
 
-- 
2.37.2


