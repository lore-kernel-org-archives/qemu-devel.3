Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2007DF45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 17:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBG66-0006ug-3n; Fri, 10 Apr 2026 13:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wBG5y-0006u1-7U
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 13:56:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wBG5v-0001gG-UB
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 13:56:41 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63AAp5lg3742884
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 17:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=LeO91WsaGzV
 ObVyI9P5c+YuXc4EOnwbcwp3Fwl89AnQ=; b=No7JbrIa56Xg2JHevTrXvddMxrQ
 lyc2LWGE1T2/BDIvA1999fHIf1Sl8drcJbcDHgjwmcRGYBuzXtBcwMknkt8l1jUg
 RGhwaCXnl64LOMsF/FdtNE5P/Uqqipa8bzC8VLt+HKKWaixDt7alM2rn3or9A5wE
 2rncz/MTdfPQOGO++Qxmap4As1sAxO0TwzUaP5YmDvjfqECoqd+qkzQ1dfKQ4ytL
 3ex3uKpF3/SDjo6U8aD3qe3gTgbfo4ndBF39b8F8awa1nhiG+/2Ysrsn6slVsVjj
 /qaBA/kPVRAbgew7V5oGY96a1u9LI5wckf9LcY4WTM+pF+NocYASOta67mg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deytnh8ur-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 17:56:24 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12bf9974587so2583672c88.0
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 10:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775843784; x=1776448584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LeO91WsaGzVObVyI9P5c+YuXc4EOnwbcwp3Fwl89AnQ=;
 b=fOzhbIUVMsuUIk8eUNnZoDekcHuIJPN6+W07F9kJX1MkOCI3Iujcdj5k1PkqSlzuMH
 m7ADvYHyhVrCzNife2aXVor27MMDvoLOKDYSXJMBdof0GfgYj9QnNyRrVbMzyNCO3zPF
 isfa3Akz/xnoqG5AMNurfxRe1KP+QEhOXo3Zg1/LbC8Dn22B3vytW3zFBaRqVPCCo8DD
 AoqY2djY70AeNJ2cncqHuwzNdfAlcyAap2PeOMHjduCniVoCM0qQ6vrl4d72LvN34pwX
 oQyPXKW1zYcT19uJL70tEffjGO3MYZG+rmOsfrgYlU+WrcMvftVIrbdl0QV6E8iYlASC
 G8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775843784; x=1776448584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LeO91WsaGzVObVyI9P5c+YuXc4EOnwbcwp3Fwl89AnQ=;
 b=GbGOCzgDMUFRweNowFOFwRIcJyrFzPlFRYzWHNJnwV2MqJkDKZ7E2nJkhHSDuOe0dC
 vlDIP4re20m88OioCOMkBYGyHKwo3N4qmA5hU4my89r0QnzEnW2bJkFrXdGYlKLjNkKg
 TBAiK/AvHBIdQU8DZeULkanjh1JHJVyZ5GKLICBkgqFsKEk5RPitWeazECpDdYkZspGM
 nfJM4NNQgtT++IhzQTXZpewCcRUxSG15cClpXr3oNY7D9mssJU+96SdP4Fx+AP2eQ5Hj
 L+upY3paihocrege/UjOrOhsZY+k+00GHLXVcUpRNAcfqrFEbAJTZNl7zWnuI/YcODKV
 AwkQ==
X-Gm-Message-State: AOJu0YxZx1P3YFWsxRFDttFJvR976nsaVGz1ZsqQ4tYwrQ4SFoUr7DNR
 eVD9vU2XN7gq0smbMe44pJhkkTnW8fIhaPrH6r/mUyzkeKj1SSkkHu2b2swOQ6ftY7e8XBBPbuz
 JVE2iF35GKhmlSXpl5FPUihTNAkVkzjgTalE7dMZBVcdDRPU2ZiXZORw7DKnuxwcgoqlB
X-Gm-Gg: AeBDiet39QSpAlAX4WpNjG9sckyPhIhaGwMS44cV8JuXndx4ImqUwDluLlf9b70Zd19
 kjHzC3r4eEGNfr0rITHCcWhkAHqoXu0mIK7YZd0OWd3/nOocXvQjhWhWCMHVKYOjeoh6JObZA+n
 UvUZeCV+wEVgN1eMxv+Z7hYV5We5h+Knec1GLxkF1FAvv7o/3WfSrLsNXMWpU0rAiq3m3wV7PcU
 PUk2Kwe4DXEqbiHWK8g0ZBD+cmrW1UUUa4suc8WnxK2X2MKUgAz3PgtGGvJpfOK7RdgSYAYlJ2R
 TAm0OzqGP4Qddgp4OaBl/CB5Mpu8t2qA68ByHKoFVoaA2DXl7MFWPQ7/hzN09tqiwKa3Nm3k+fM
 N4z5d7mTqKeuqL3EnMgZOwqut6DjA7Il3xuraxs5pDUJcIawe+98i8sGBgYwjTQcj9WpyZAc095
 H8fNepRZH0
X-Received: by 2002:a05:7022:fb04:b0:12b:fc21:8770 with SMTP id
 a92af1059eb24-12c34edea1amr2834099c88.23.1775843783367; 
 Fri, 10 Apr 2026 10:56:23 -0700 (PDT)
X-Received: by 2002:a05:7022:fb04:b0:12b:fc21:8770 with SMTP id
 a92af1059eb24-12c34edea1amr2834061c88.23.1775843782605; 
 Fri, 10 Apr 2026 10:56:22 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c3459f7ffsm4256271c88.3.2026.04.10.10.56.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 10:56:22 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v4 15/16] tests/hexagon: add tests for v68 HVX IEEE float
 comparisons
Date: Fri, 10 Apr 2026 10:56:03 -0700
Message-Id: <6b473acaf5fc50ddbe89d795edc2b0eb9da63be9.1775843299.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775843299.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775843299.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: cRFJxMj5jfmO32iFqcD82zqTyySLxze_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDE2OCBTYWx0ZWRfX9tDf+KRUdIdS
 zg9kzRGuIByh4hfzufCqukB0B+Yvol9CMg3aIzFqrgRe83J8n5qCY1V4btXdEJKCfqLUYPyYibG
 36fHHP//WkDPlT9DwErkwS9Y6pXGD/LE1F6KbfWmzLqjDSksS0fwriUtCiqB6vgRd/4BD3gq0ty
 3kN3xutB5eW9EXkpYDzI8UVc7ji7NITeO8pcS1X8BjM2PMC3eLwp8KDAF11nR5zLh4m3CblgTKs
 ouygTqNx2u+o+bLbC3ZxHNVQd/lyAF45wfUsiftPvMJ+CUL3X7WIaLALd8WLty+Kibepg2zNMCj
 4I7cOtBgEUkcmS4NAWN2OKTcHh3mB7PWGZjj7JetCgJjh8QJrk2VaVHlARP0f5lcWuQhm2PJloH
 FsFD/79Ic6+0NjHD7Tsv4b1x9Dw/jai/E9AdCEgTLejQf7MXbs6jwDp/OkW44HSLEcqfJJrU1sO
 v1vgeYC80FmXvTAaPiQ==
X-Proofpoint-GUID: cRFJxMj5jfmO32iFqcD82zqTyySLxze_
X-Authority-Analysis: v=2.4 cv=crGrVV4i c=1 sm=1 tr=0 ts=69d939c8 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=fI0TtrDCX9pHJ6FobWMA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0
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
 tests/tcg/hexagon/hex_test.h      |   1 +
 tests/tcg/hexagon/fp_hvx_cmp.c    | 224 ++++++++++++++++++++++++++++++
 tests/tcg/hexagon/Makefile.target |   3 +
 3 files changed, 228 insertions(+)
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
index 0000000000..b1352c786a
--- /dev/null
+++ b/tests/tcg/hexagon/fp_hvx_cmp.c
@@ -0,0 +1,224 @@
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
+static void check_byte_pred(HVX_VectorPred pred, int byte_idx, uint8_t exp_mask,
+                            int line)
+{
+    /*
+     * Note: ((uint8_t *)&pred)[N] returns the expanded value of bit N:
+     * 0xFF if bit is set, 0x00 if clear.
+     */
+    for (int i = 0; i < 8; i++) {
+        int idx = byte_idx * 8 + i;
+        int val = ((uint8_t *)&pred)[idx];
+        int exp = (exp_mask >> i) & 1 ? 0xff : 0x00;
+        if (exp != val) {
+            printf("ERROR line %d: pred bit %d is 0x%x, should be 0x%x\n",
+                   line, idx, val, exp);
+            err++;
+        }
+    }
+}
+
+#define CHECK_BYTE_PRED(PRED, BYTE, EXP) check_byte_pred(PRED, BYTE, EXP, __LINE__)
+
+static void test_cmp_variants(void)
+{
+    HVX_VectorPred pred;
+
+    /*
+     * Setup: comparison result will have bits 4-7 set (0xF0 in pred byte 0)
+     * - sf[0]: SF_zero > SF_one = false -> bits 0-3 = 0
+     * - sf[1]: SF_one > SF_zero = true  -> bits 4-7 = 1
+     */
+    PREP_TEST();
+    ADD_TEST_CMP(sf, SF_zero, SF_one,  false);
+    ADD_TEST_CMP(sf, SF_one,  SF_zero, true);
+
+    /* greater and: 0xF0 & 0xF0 = 0xF0 */
+    memset(&pred, 0xF0, sizeof(pred));
+    pred = Q6_Q_vcmp_gtand_QVsfVsf(pred, buffers[0], buffers[1]);
+    CHECK_BYTE_PRED(pred, 0, 0xF0);
+
+    /* greater or: 0x0F | 0xF0 = 0xFF */
+    memset(&pred, 0x0F, sizeof(pred));
+    pred = Q6_Q_vcmp_gtor_QVsfVsf(pred, buffers[0], buffers[1]);
+    CHECK_BYTE_PRED(pred, 0, 0xFF);
+
+    /* greater xor: 0xFF ^ 0xF0 = 0x0F */
+    memset(&pred, 0xFF, sizeof(pred));
+    pred = Q6_Q_vcmp_gtxacc_QVsfVsf(pred, buffers[0], buffers[1]);
+    CHECK_BYTE_PRED(pred, 0, 0x0F);
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
index 1abc5f2124..92bdedf661 100644
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
@@ -135,6 +136,8 @@ fp_hvx_disabled: fp_hvx_disabled.c hvx_misc.h hex_test.h
 fp_hvx_disabled: CFLAGS += -mhvx -mhvx-ieee-fp
 fp_hvx_cvt: fp_hvx_cvt.c hvx_misc.h hex_test.h
 fp_hvx_cvt: CFLAGS += -mhvx -mhvx-ieee-fp
+fp_hvx_cmp: fp_hvx_cmp.c hvx_misc.h hex_test.h
+fp_hvx_cmp: CFLAGS += -mhvx -mhvx-ieee-fp
 
 run-fp_hvx_disabled: QEMU_OPTS += -cpu v73,ieee-fp=false
 
-- 
2.37.2


