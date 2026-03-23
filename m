Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62C1F46101
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4f9A-0000X8-I7; Mon, 23 Mar 2026 09:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w4f8l-0000Il-P1
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:16:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w4f8j-0000NL-PS
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:16:19 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NBgUZq123583
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 13:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=dFL4dAtjRg5
 Tov9boz2LT8i8YFT494sJ8UQ7RaiQI7w=; b=Vd5cg3sTtEGhPh3TtH6TFXUJf07
 RUsyEG4tRJedBSeXSvg6NWB3IysbXBlb92MZo0dHFAMhtpEi7N07MmbKJqdhhN41
 0kbQnu3ZM45V2tKVLLWOch6S6ReTCmpbVNw7XhF3qW0xxlkweLuEW85RDexzgeXB
 KIfUjdafViAeSrI9JWEjvXpS43DheIWl3rkJ4Z4DHHOgOcbCSiIcSTYYZDdKU+zn
 dPgLG5OaLaoDHOiQabHPwWayYLtfZ6PF6RlQ9wuRdOgqHjilyuBbd22++3uZzStY
 vsGXxuW/k0IH593Kvz3tcO+i+bzU/0RML4I0DwQwFZrfJtX2DVXBnQMDMXA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d34vkr9fw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 13:16:06 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2c109ba1296so11018578eec.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 06:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774271765; x=1774876565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dFL4dAtjRg5Tov9boz2LT8i8YFT494sJ8UQ7RaiQI7w=;
 b=H9pwkyGBK60FfHQLeW+lCZ7YqyL8qCbV3ISek9OTABak4ONpuqKfAcGgdbHINokenB
 srqGvG/STTWeSBuSzpLBpUXsbgPgNFbe0PGKWsX3MfSOyqhM3/R0B/Ug0X74qOJKyceu
 nRsWV7zUMMg4+wtEaPLD+/gUzsXLc0lxLFTl3RyYFyrE90W1VDv4xPVojjqb+dOT+rTJ
 QLmubwnVfsz6Ulg/Tx898SSckDcEls0U3soezjheG6TH0EQWVRTpnOaOkD1ZthFMdoAR
 a5nOAnUmjtDn8dBnMaDuD0Z9NH/z5BTDN4fz5tNHr2Oflpb3n1lJ5JNf7MFtT5OBYFgp
 oo+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774271765; x=1774876565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dFL4dAtjRg5Tov9boz2LT8i8YFT494sJ8UQ7RaiQI7w=;
 b=fkcnFjV0OZQWw78bE1pZn8wfR0PxH0en5MOIFOpOO0Vj1ezpXRPgj4+z2WQggzqj0s
 jyjWWpOZSLTH/b+laC/9TtLps+bUQR6YKqKKl9eqsj9d8L+IHyP+B3/p8wU8yfySXjce
 UGo5WsoOIU1KtSHWZJyfds+TU6sHRr5x3oe0cgjX4R6QdVDKrnsItXlJuq91Eh6auAtY
 gjS17u0jY1NgiVxFzmU1G30YMGyzfCdSE5I3l+uBjCXlTMzax1f2j7eTuJVhRbXfwELy
 YnJqR0HPb/S5sFfk1TPGGO/UdRRmfC2o7wa1He+S5wyucOM3vZ9nlO9MGiuR3OdQjuTO
 H1Kw==
X-Gm-Message-State: AOJu0Ywl4yum3u6rN9F3MRouRV/78xLEvSD8zZuHZ/cvp7u9Wwxcd6nx
 HL7uvevz5XK2CyXVSkCKqiYbdZx4syO3/GfWgkZJo/OmsRniubjrrT110pHl7Fw8jMMuMgujXqb
 2oR+PnfA27Xna0TJG41cncJ9lFNQ5o6AN2Rx+pWgWUroZxIESl6hDnrcatrG+03re6T2H
X-Gm-Gg: ATEYQzwzqEeq8J/YDbqs0t9GcXuDLnsbvWTEgTiK0njoyKA6KDLY0Yq9GftfwL/aKgB
 s4WUBtk78HAfErIa2W84tL1sQq+rFCOhyzMcoIkVYDDs93584FuPRoHnp+RIXMnAKaspfzXPv1Y
 2A3LEQ2yUZu9v+s4BwAjYyluxN2QmWy9OSyUygCsEe87iPrBR/HiQ89fmTLzyiDWYuhdrBSHJt5
 UhvXG7jeP83pfmohqZ+1f1qmoOLWsv/2qy2/Ow3MhL/uTdPFeOMaTPXMDCAvfw709t3kKGAF1Lt
 l0bXS0ZdMUBsW2F9nFcgY/MUEp1SV5w6fZNouMJz2+W/2JKRBDkigPKpgB/CfjRyaSyRBVeQbCw
 /OkzEMfBpgjDMDhk40xfVu3+znvTaivXFvbU0as7vXQhjxqzuHQWhqs54n0hDXa3Q7EY8S01kf7
 ArDf6s5LGX
X-Received: by 2002:a05:7300:7496:b0:2be:e92:7f33 with SMTP id
 5a478bee46e88-2c1097ecb50mr7361558eec.35.1774271765095; 
 Mon, 23 Mar 2026 06:16:05 -0700 (PDT)
X-Received: by 2002:a05:7300:7496:b0:2be:e92:7f33 with SMTP id
 5a478bee46e88-2c1097ecb50mr7361523eec.35.1774271764437; 
 Mon, 23 Mar 2026 06:16:04 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b14cadbsm14702574eec.3.2026.03.23.06.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 06:16:03 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com, marco.liebel@oss.qualcomm.com,
 philmd@linaro.org, quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH 12/13] tests/hexagon: add tests for v68 HVX IEEE float
 conversions
Date: Mon, 23 Mar 2026 06:15:48 -0700
Message-Id: <b3c261d1c76838c3b6c593ae77dc0b1ed1459f32.1774271525.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEwMyBTYWx0ZWRfXydWzQiXvXNQY
 4338gZND4v/473QkL7UQuF8RUn0P4DH8ddpwxckULfMOezUn1ysSrufxrK0TykMHVYLYin84GN/
 kL42NB/hignx2EOh+i1dmvhrre0aG7P+JJN3sBNCv00vMlJsYgHRDDV0XgxEP4XS83VIcGm8lxT
 VQNUY7vrk5L1W96dmb5npQ2Kk9LnTqHT4l1Nya4DcENI8lYXVeRTfszhDm0Z/RFhU1rNB4CX9aD
 bj7Ygb0rrGmqsGl67M0Z2Q+sgBR7vKpFj8za3FqLLcEpjsLSfVYakg93HHWQH2aJ6wA+x1Yxonz
 o9UPFHzQAA3THo6JYWntYqEgGmiU0FuX3Sz6Cf/9dC8n14KKVD2JXz7oucQU4QVB4uwf/IV3XOK
 GQ5sCxeIeG6aGu7A5UqNOFe3T5q6UFViwJdsVCA7CkINAwoXdbr0rtWzNfRytZKSrpk2IE9oelt
 5AfsqCeoZd5lehfnCOw==
X-Authority-Analysis: v=2.4 cv=eMoeTXp1 c=1 sm=1 tr=0 ts=69c13d16 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=0od7JiDa8KAJqeLmwRIA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: AZwx2ZaKmaEY2R8HR3uDJWEFm_msutuv
X-Proofpoint-ORIG-GUID: AZwx2ZaKmaEY2R8HR3uDJWEFm_msutuv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
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

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 tests/tcg/hexagon/hex_test.h      |  15 +++
 tests/tcg/hexagon/hvx_misc.h      |   2 +
 tests/tcg/hexagon/fp_hvx_cvt.c    | 194 ++++++++++++++++++++++++++++++
 tests/tcg/hexagon/Makefile.target |   3 +
 4 files changed, 214 insertions(+)
 create mode 100644 tests/tcg/hexagon/fp_hvx_cvt.c

diff --git a/tests/tcg/hexagon/hex_test.h b/tests/tcg/hexagon/hex_test.h
index cfed06a58b..28522faf04 100644
--- a/tests/tcg/hexagon/hex_test.h
+++ b/tests/tcg/hexagon/hex_test.h
@@ -109,6 +109,20 @@ static inline void __check64_ne(int line, uint64_t val, uint64_t expect)
     "usr = r2\n\t"
 
 /* Some useful floating point values */
+const uint16_t HF_INF = 0x7c00;
+const uint16_t HF_INF_neg = 0xfc00;
+const uint16_t HF_QNaN = 0x7e00;
+const uint16_t HF_SNaN = 0x7f80;
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
 const uint32_t SF_QNaN =             0x7fc00000;
 const uint32_t SF_QNaN_special =     0x7f800001;
@@ -128,6 +142,7 @@ const uint32_t SF_large_pos =        0x5afa572e;
 const uint32_t SF_any =              0x3f800000;
 const uint32_t SF_denorm =           0x00000001;
 const uint32_t SF_random =           0x346001d6;
+const uint32_t SF_neg_two =          0xc0000000;
 
 const uint64_t DF_QNaN =             0x7ff8000000000000ULL;
 const uint64_t DF_SNaN =             0x7ff7000000000000ULL;
diff --git a/tests/tcg/hexagon/hvx_misc.h b/tests/tcg/hexagon/hvx_misc.h
index 771a4a22b6..26dd9ad774 100644
--- a/tests/tcg/hexagon/hvx_misc.h
+++ b/tests/tcg/hexagon/hvx_misc.h
@@ -67,7 +67,9 @@ CHECK_OUTPUT_FUNC(d,  8)
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
index 0000000000..7497455ac6
--- /dev/null
+++ b/tests/tcg/hexagon/fp_hvx_cvt.c
@@ -0,0 +1,194 @@
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
+    void test_vcvt_##TO##_##FROM(void) \
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
+    void test_vcvt_##TO##_##FROM(void) \
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
+    void test_vconv_##TO##_##FROM(void) \
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
+    TEST_EXP(h, hf, raw_hf(2.1), 2); \
+    TEST_EXP(h, hf, raw_hf(2.8), 2); \
+})
+
+DEF_TEST_VCONV(hf, h, { \
+    TEST_EXP(hf, h, INT16_MAX, HF_QNaN); \
+    TEST_EXP(hf, h, INT16_MAX, HF_SNaN); \
+    TEST_EXP(hf, h, INT16_MIN, HF_QNaN_neg); \
+    TEST_EXP(hf, h, INT16_MAX, HF_INF); \
+    TEST_EXP(hf, h, INT16_MIN, HF_INF_neg); \
+    TEST_EXP(hf, h, 0, HF_small_neg); \
+    TEST_EXP(hf, h, -2, HF_neg_two); \
+    TEST_EXP(hf, h, 0, HF_zero_neg); \
+    TEST_EXP(hf, h, 2, raw_hf(2.1)); \
+    TEST_EXP(hf, h, 2, raw_hf(2.8)); \
+})
+
+DEF_TEST_VCONV(sf, w, { \
+    TEST_EXP(sf, w, INT32_MAX, SF_QNaN); \
+    TEST_EXP(sf, w, INT32_MAX, SF_SNaN); \
+    TEST_EXP(sf, w, INT32_MIN, SF_QNaN_neg); \
+    TEST_EXP(sf, w, INT32_MAX, SF_INF); \
+    TEST_EXP(sf, w, INT32_MIN, SF_INF_neg); \
+    TEST_EXP(sf, w, 0, SF_small_neg); \
+    TEST_EXP(sf, w, -2, SF_neg_two); \
+    TEST_EXP(sf, w, 0, SF_zero_neg); \
+    TEST_EXP(sf, w, 2, raw_sf(2.1f)); \
+    TEST_EXP(sf, w, 2, raw_sf(2.8f)); \
+})
+
+int main(void)
+{
+    test_vcvt_uh_hf();
+    test_vcvt_h_hf();
+    test_vcvt_ub_hf();
+    test_vcvt_b_hf();
+    test_vconv_w_sf();
+    puts(err ? "FAIL" : "PASS");
+    return err ? 1 : 0;
+}
diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
index 16072c96fd..e240372fd2 100644
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
@@ -129,6 +130,8 @@ fp_hvx: fp_hvx.c hvx_misc.h
 fp_hvx: CFLAGS += -mhvx -mhvx-ieee-fp
 fp_hvx_disabled: fp_hvx_disabled.c hvx_misc.h
 fp_hvx_disabled: CFLAGS += -mhvx -mhvx-ieee-fp
+fp_hvx_cvt: fp_hvx_cvt.c hvx_misc.h
+fp_hvx_cvt: CFLAGS += -mhvx -mhvx-ieee-fp
 
 run-fp_hvx_disabled: QEMU_OPTS += -cpu v73,ieee-fp=false
 
-- 
2.37.2


