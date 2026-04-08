Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9B310F9974
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYQo-0006GV-QX; Wed, 08 Apr 2026 15:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wAY0E-0005Ed-QM
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:51:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wAVuC-0006qt-4N
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 12:37:30 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638GGZ884047338
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 16:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=RfmOA1oJRbM
 59T5jNLihWyqgY4oN9Qis1RTJ8xh8eSY=; b=CbqQrBuYRjrg1HrSSsYiWvvgHHY
 z69BU+w4pDwX00kM0YWs2ZFNFmrDbDqiLU3BR56cdFpH2zKKk9IltW3+/sQVLqcf
 gVpPHqvBl7USWrR+cbzmTQfhYcnmZqFUWlbJnvUSF2gvC1cCWjQxDMkLONb4CelH
 OwyIIIR+gmfxtbKzcIy2feYHH1NHMunCDzClrgY9LQmeS6itJig3HZ4/6N07VWch
 xPlxurtQNGPY7rUaQK6iXJeIjahGjCbcw3efFKLXAJkMbBUBAO7XJAb37/ZR65dZ
 +neq78QwYF7fNxLnGFZtFfMVKB/xoX6co77SGcN26CzCp2uXAuzFfwJKO0A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddtd7021a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 16:37:26 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c76b69fb9d6so763223a12.1
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 09:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775666246; x=1776271046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RfmOA1oJRbM59T5jNLihWyqgY4oN9Qis1RTJ8xh8eSY=;
 b=MK1Ns8J5rw9s6ByUsmfBiWCVuQzFtwrYOF8u12DBQRCQBnV/z1KIOgBpIBXNRZ5tD6
 8S3QJnGB4JeYgIMpyU6cflz6ZuMieBQJSh/0TTD3ouAv9Iu/XWNNxlnKe3z1IQzErDbt
 QC+ydcNPl/faerNVIU+AO637KnktmeVaHjeq8nNU7hJEfN1gauHMLEI7mf6CvJrfXka6
 ri25BKyjqh2OMRxUT7Pl1ORv1IaIlJ3+gFrGAM4RWAs6WxpJJbwSZCqEuVqYJaMsG7yd
 c5LmpPhcQS3+FitXX9A/6K8GUQ9IYTKiBoA5inAmZ9HadMga9TWlrN0VnyJ2hYB4TqwB
 yckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775666246; x=1776271046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RfmOA1oJRbM59T5jNLihWyqgY4oN9Qis1RTJ8xh8eSY=;
 b=SI/O5UsdzobnXsEMahr0hmxrH6EbETIcGZ6aHSIUFlNOoMJrZwOomEbXrnKmhnJuNg
 8HVJwxxNtWz2jRlQ5PUfvJljsiULrjTLZAlxshDcNyupFbaHxw4UWEn42sVFEpJljjRC
 z1WQLzKeRyN3J6ikIlrUf3ErYCuaBvGFlFs1IIUxQcxgTe0pIjl7XK14kbRfioLZKqBO
 GMZNbWUIgdbzG4G3EhRYMLFOHxMBhSBOClkVj94ZoCe52VAhAcfNP84dVMoQv4A5UIXt
 ZoudkMIYWWKN7cW6g2eV6SRlIObHOLNuFbsEsaQsJeBETqo8WkwsjBfFF6tYzURxpb/F
 ztJA==
X-Gm-Message-State: AOJu0YypoXR/mGbD5rFtQG2qGfgMPevoNa25tKV/ofZSUWZOH0mfvOMF
 Pb5aAft2Yh1UPbNaxv15lBJSm0ImxhXX3nLFGWTPa6rsW6xgWz3UMrSWC5tqzK5sgpv1XyPs4Mx
 eKQV8grajv7VYiLCz8MZYVdciPmRmRIViS6Z32pGDBpTpDJ1ZmdYwLLwUbbFJoOr5Jkl6
X-Gm-Gg: AeBDieuOJ6TH6Jsj0k2VohxPyGdrG5Bz/fcJ4GGPR4wwoGTUMDqMV/nwVP/FoiFpT70
 vHYZg6KqdbSJtGKMnn+93Bb7+IfEtX1zVYDCZIg9AX/Jn4Fih+Ak1ui4iN1HqEFaA8feaX0P/44
 Fp2EatKuwRb+32nmQHTPa/PFfx5lsBmwJ/WO4MRKx47fPiru4i5e2TzCyalBEWbu0jGJCpHY2W7
 UARxfZQEhm5cyJ65AhrFke3gmBbJrhcohVOg0VAwVDSqvJt4ETNYWLremltKGkxGvEmDlQgdw8l
 Cjrh0lsuz8tjjhKf0ckDqUwTORzLCzeO5cTmL+wOlIcpvqMHVghdJGima8pcJVZDGwTCjw085+W
 WzLF6C9MH76nAobFwfZ3SqYIJkQt2DoXKC3Hj73f351GDCOS5S5axStFE3AZw6F+hxHQTK8apWM
 uL7/di66Hv
X-Received: by 2002:a05:7022:4381:b0:12c:8eb:80b9 with SMTP id
 a92af1059eb24-12c28bfed17mr72315c88.6.1775666245423; 
 Wed, 08 Apr 2026 09:37:25 -0700 (PDT)
X-Received: by 2002:a05:7022:4381:b0:12c:8eb:80b9 with SMTP id
 a92af1059eb24-12c28bfed17mr72293c88.6.1775666244538; 
 Wed, 08 Apr 2026 09:37:24 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c1ff43d04sm4082006c88.4.2026.04.08.09.37.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:37:24 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v3 15/16] tests/hexagon: add tests for v68 HVX IEEE float
 comparisons
Date: Wed,  8 Apr 2026 09:37:06 -0700
Message-Id: <f46538124c66fdd7401438f88f9ba1a3e3a2baf5.1775665981.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QoRuG1yd c=1 sm=1 tr=0 ts=69d68446 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=g6BQdadCeQXt8ut-Y_AA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: HCotoW17JhMe3q4YzU6BX9Utn6F7edHn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE1NCBTYWx0ZWRfXwwiaAuk+trfL
 EbrGlf9ipqN3pG8thUKgFlYoNfYCvXSl8z9eTIltwcXTM/FNL9e3mYR6j2fiompuQE0KMypfRar
 3frTdyx9AYLdgUqZ/WGJ4dSVN+377qsuJeGxGU4XKg7Ynso1WPcUc2NZjQG2O7WoqiEaQruhutw
 scNZcp0OMBmCe4GWVd1ivKSjdaSwK/bXtk3Rcmd3o9fYBfemwABtZEmUELESBZ76iRJrI7LXxHz
 khWGYVGklH1RL66lzTBiUuJgzst+5+hsv36kIgCyUqJpHyfMaEqhc5BQeXdYawBy0dNiyMDYCbd
 OqWSZ/4c2etVD8KZlJnzqiYS72C+83VmNL21iPKMDzPj4jmNEjc+uNrb4cGw97Elm+kMI2B3aBr
 +vHfqs+nd+5f3/jg8eKOOoMm4PJCmc/U5gG+0L4x7bqfep3iwpXxSbMCGvPTs/znUDIKiiStnb4
 yNzEMq0H8+m47/MvIAA==
X-Proofpoint-GUID: HCotoW17JhMe3q4YzU6BX9Utn6F7edHn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080154
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


