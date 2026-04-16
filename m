Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2798AF8A163
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 11:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDL4T-0005GZ-Gx; Thu, 16 Apr 2026 07:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wDL4N-0005DJ-De
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:39:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wDL4L-0003Ce-1L
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:39:39 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G9Jk201553312
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=LeO91WsaGzV
 ObVyI9P5c+YuXc4EOnwbcwp3Fwl89AnQ=; b=SMexECvgeYkpxgEdl0bujeTgoX6
 EL/q2xqiuqN+TrvW7baHYYonO6kSCY4uFVbUuFz04GZrX33/syLfJI4nXj8jG8zs
 kkxE0hw0QxxZQ+ad7MY4pAgiJk/0+GwbKSp2X9N/oF55kSS0SwuIBPU5me+/duQI
 MCsACcljd2wzs7olRGkPp6p6D+RCznu0bbbnxfC73el8m0ECfpM7rP36YBHZy5Cl
 /6IF7jD7QwrUNgEEMbkBhEvOVKS6jI1KX6vmZvAmWMEOle9mVYznP5JMaY81V9bi
 MkARLHBBh8edFdCBCWNbGJ7NGPA5bVAUtWVULiHUZxduXrDsMXW73xp2StA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djrsn9g9g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:39:25 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2bdd327d970so391619eec.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 04:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776339565; x=1776944365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LeO91WsaGzVObVyI9P5c+YuXc4EOnwbcwp3Fwl89AnQ=;
 b=gyD7MFdTxGmS89JdQMzO1JqHZrxoSGhH7I9jpd5T2YrnFgFgfqOgkfXJPrUXMK1n24
 QC4fsbKte+tLr6refyCrLA0q50+9AWZBllrxgZV2mFcRNpvJuWO0e4wO7DSYS37TpqLc
 32NTbg8jbxmHRN2IcQGXfd8v0+vugGgBGe/vqriXSCO1OCdHEfhuHMSfebv7K9mgYF9U
 gWvaQhZIi0TbgtUtsbVb89PLd64ukkQT1kaV4I/fHxncguYSoBqDadKxllPAc/xxeVww
 pueoR64QnNxnPAp4B35iQ/t2ANKkkmZI3j4lnehLdiOt8fdGRCRfp9Jm6rrrTHxRXB1h
 cdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776339565; x=1776944365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LeO91WsaGzVObVyI9P5c+YuXc4EOnwbcwp3Fwl89AnQ=;
 b=fwDeQDXYLiI3pwuDML8VKopiurgelL7tNd0KRJrUDwTVCI6RgwxE09l9/pdadXLDU8
 xSCa06oDzLxJMZbt5OKrLNjAo6jcw+W938xTlq573AOYW7IF5UMaYScZ1S/0VufIe3en
 ZFMuUg3caN7Z8AON1zTZTPn9Ss99qv/vdDhNLIRG3HRoQD0+n2u1VQZThwdwrti4rPEJ
 uY4cIxmhIGWIJMwnMxF/f72v24gtu+tKxwjPuEiS4qkBvql0Gh0i/gqHdaqMsXjNEwby
 lfItx9eeqck999rohqzEvJweOKKQyyQuVKvIJ5lna9ApXX5NY5tfRVFq4vvJYr8ZMv4G
 Ik1w==
X-Gm-Message-State: AOJu0YyYIainJEbKaKIURJgMhO8XJgrYvKar4r1vpRCmm4Fr8xVHK6d3
 5+xVRO1TQrslAfqZIksstmI6a4iSgEQLZ0KF3dtP4T022mThN5o/fmYRhODjE7D9s0MNL+Mehnj
 GwESQTwz0zX7Mc4cOelDsX0Klzu0OF/60IzT5yhW7+cwrI6EsrLtHDisOTDvNd/AMa1ah
X-Gm-Gg: AeBDiethNca5vXzBHDkZo3XVB4izJ/DxCc1UiQC++tfCR30BGOjb/AsnkDpp/DsOnpB
 wfqb5Hv1UuQV3GzRg+epozp7iMlh2qbNs523wYMM6WHyFCKaWO0Ujk0LOcLzyYoGkQIbh1ig2eL
 FE9ny4wexXL9w6Sd7GVDj63o1Emo7rwvOeIm/nD5e39VcB6cYT+247j/Ul7O1d6K5BN0q6A0ZRO
 wgDMn5UhZnKxbgH7GK3Y0FV8i39FuaZe+rqu9W6pY5aJHL7RqV/feIfzHddX1jcGYo/P8Fa9pke
 CMBELiIkPT5a0h3nvHUJ/J44yGM2bqr5pbhRfBaxugk2vrjDYfLkPgA5PWshMSpyf+GCGvbxWs/
 kxgSKVGKryYW6afaog6MuBh9/1aoIEJ6I5ZDQKFr13MxCZKz+SrfOACQRZCeMUkzo7lQvYGsNxX
 EE5tX+9C/DlSNzakpoZrQ=
X-Received: by 2002:a05:7300:2216:b0:2c0:beb1:8507 with SMTP id
 5a478bee46e88-2df7a2f5608mr1310345eec.0.1776339564381; 
 Thu, 16 Apr 2026 04:39:24 -0700 (PDT)
X-Received: by 2002:a05:7300:2216:b0:2c0:beb1:8507 with SMTP id
 5a478bee46e88-2df7a2f5608mr1310317eec.0.1776339563661; 
 Thu, 16 Apr 2026 04:39:23 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c10a65asm6845391eec.6.2026.04.16.04.39.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 04:39:23 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v5 15/16] tests/hexagon: add tests for v68 HVX IEEE float
 comparisons
Date: Thu, 16 Apr 2026 04:39:04 -0700
Message-Id: <53e73707092d31bcde6ed8189c5496b00345f8fa.1776339451.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1776339451.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1776339451.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Z-1J9_b77Ri9rO-7bDqpR9J4GECY-o4O
X-Proofpoint-GUID: Z-1J9_b77Ri9rO-7bDqpR9J4GECY-o4O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDExMCBTYWx0ZWRfX6puhuMzoJ6Us
 qky2ly6P0uQtmK9JFjyMM+V4/6KK8GrJVyuauaV5J+nddUf97+9ebFlWgK6rxx+NYZ2037OdHIY
 e9VBfx5sjFvwAtVB+WOHcRdg2S6VBNInQIt0NQLs0C/sqHoTi9DhH3aa3eEZ2Mri+Ll4da4RrZ6
 AuGNFJvgTH7eH5W2EEwOABi+v5Kl0gSgqBywsFW5eEOqwVNY+M1Lm51nn3ZcJ4PI2gkE2eabWj3
 +p5pyWl3DT5p+c5JRmGU0NPTgZ1XihFMMhXdDItevmw+hntHbNcgRsyehxRkb1nGdyjeO4uEJGP
 3abR9RbuvMHnttyBVl+R3Y/ruUxp58XzoxJenM+oJtxotzFfZURjk0+cNLnEtYBQJF2o8Gg2HBq
 5wTi/UJtL7yAzjAYTkj9NviMZ8DX5cO6RA6Qg2NYG0Qfpi2jZWWrKtcb0zb7MZCLNMX82V1/plr
 wHF0mbbZ5l7BQ+qOdYA==
X-Authority-Analysis: v=2.4 cv=EojiaycA c=1 sm=1 tr=0 ts=69e0ca6d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=fI0TtrDCX9pHJ6FobWMA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 phishscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604160110
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


