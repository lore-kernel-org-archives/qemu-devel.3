Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B3AD3940D
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 10:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8FbT-0005cD-Lp; Thu, 02 Apr 2026 06:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w8Faq-0004lQ-S8
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:48:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w8Fak-0007q5-7m
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:48:07 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6326btI41965395
 for <qemu-devel@nongnu.org>; Thu, 2 Apr 2026 10:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=gN4yioD5Rgh
 7UznFLRejmfl/X6fbAyKgQNiOL9X2Qck=; b=aBpt8IhUVKWmfYgH9k0nTkZ49Mb
 p01zSbZG5NjIeoSSFyZchHS1QhBc17g7yhpQcKg/YJKFrGZbQAEVDQhvWeU2AKKp
 u/oLGDTrLnqkIQsStCmc4wTjEZH2WMoECKP6kKs+ogOEr72jEx7T+jiIrZcBsvXG
 MaBbDL3HFjioYPav/pfJtuikbngzh5VOmxx8wjLgDEYxdrV04zxsuYhOx2U1UJOv
 gB7r+nIKsUqgvRx/KJfZ3EqhvXlZuy93bGHwEWbKya3mAPxQPg5WpZEgSkholyWY
 MA36YTqd8+dwSiqJQy9NysTC4MMRJYHPLLFn9KhHSpImzULbEJDcO1g9hPg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9b9h2pm6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 10:47:50 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2ba9a744f7dso1115411eec.0
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 03:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775126870; x=1775731670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gN4yioD5Rgh7UznFLRejmfl/X6fbAyKgQNiOL9X2Qck=;
 b=OfsbNJcomBD2PqLen1i+x5nU9W9zCL6/1vN1GYY3HzKwDTH8DHCj8LW9vyEYbasRY6
 kf58FwMUPEOSKECFT85iy6J7y1D0JoXbz9EjlNPE8aJZnOUWxJBxFos9hEie9XDcvw2K
 6iKGc8SNI0u45rXrBzLCFHF9hURWyyOsCZHSGRCCrpgtO/MIqBhrkgd3OKKIef27ZXsZ
 xvBV/a1enXb/+ycvXZkoqTeRUfMOt6JcAApYMF164K+wMFln9Z4xBNTj59U1nWvT5U8X
 ZeWoJXRskvrlzJsu97xckJe89Bwy72hhZ9oQB4TPlErdg6jydHcIsvuK1hb9WZyWQOQ7
 nrpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775126870; x=1775731670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gN4yioD5Rgh7UznFLRejmfl/X6fbAyKgQNiOL9X2Qck=;
 b=H8yewEdslFuCPRTDlCCvBXWznyr40d2MRjXo1Rr50D5pUbU9seSil02is37D9wuRqs
 OVsfPa9bambz0AZqwkmB/R52ct73aAuz+DVYzs7tUGmyCk+LjRE+TPZW+RjyUDP8EGKS
 cbZ2Iln5t4ZQvidgcL4s89VUVQAZet5VS15y4YxFTThuPGQnMb5bHDDkZdxkeuaitJQl
 320yM4tQx3OjYBx6cMnkAlcCWk7DRzPxF3gIaFiqI1LJr+H+NduDVI7MPJUfWJFqxY32
 ka/2mtOSa9L0sRmQRSKqRbyS2TOYuoQ0KGIBRPpU+PM92WvY9k5XpKiixA8lWCepm/JX
 WExQ==
X-Gm-Message-State: AOJu0YyH6tHaLSwICPScM1SJ2dLvtxpvF0P9akWid6Zv9NMCM+/DzfHo
 NPKrS6wrR4nDqNJnOL7iP5VD28XIojD/ZZjZSVkbX2+tbLNVqwgqwQj/4w07ajZB0VgIhM9xuCF
 LL5SL64SWKEuTR6PrIUw1Iw2qYZOxj/i9HDZD8M2xU/ELAs7idCFcJlQOTu3zyrxQtgXd
X-Gm-Gg: AeBDiev14c4Cfby0zXnjSRGivIywU+bWvOe4J9BL4SVJ5I/FAeulnuOq+m4aQ8yx54Z
 UMrctwF2tNhEuykqRJIOftTv2XkREkM+jRWxzvsugPoDRpDIPUyLFSTJvqKV9Wbdp1vB9DX0Z3E
 mCH1gaFbV25XVni3+X8A0eJyFfnMrMzCXBI6xNh55nLRaiIt41Y7pnRafUrELJ7wusA+xnhuUQC
 qNtvQLJZuFv3/tkMSXvHtFE0u594W0fk6/I9c2vDRAm/jb6bZKYB092O0db9Lxj+Wihm6zukp9A
 iqj/Jxg2Ub5Rg3kUipIiGZdAEbSCOUPUGRdV5MKTX1bru98yw0kuANAwhvCFY3x4Pt9IWRLFBDH
 PgsTFn3gNkVAxZL2I69Mf8DBKulIyxSbY2dZI658+ZjxzIYfzaL3FO7hc36Jctw1TZPtrpcXPyh
 JLgtDsGgkH
X-Received: by 2002:a05:693c:2c06:b0:2c1:161f:ac39 with SMTP id
 5a478bee46e88-2ca8f74aa15mr1332277eec.26.1775126869774; 
 Thu, 02 Apr 2026 03:47:49 -0700 (PDT)
X-Received: by 2002:a05:693c:2c06:b0:2c1:161f:ac39 with SMTP id
 5a478bee46e88-2ca8f74aa15mr1332260eec.26.1775126869147; 
 Thu, 02 Apr 2026 03:47:49 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca7d00f5easm2004783eec.29.2026.04.02.03.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 03:47:48 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v2 14/16] tests/hexagon: add tests for v68 HVX IEEE float
 conversions
Date: Thu,  2 Apr 2026 03:47:31 -0700
Message-Id: <4bbaed1625dba497aa7838d5417dd0cad4c10e22.1775122853.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TqLrRTXh c=1 sm=1 tr=0 ts=69ce4956 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=tBVvuLY118niWomA0oIA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: G1AJjcx1uPAjyOjupsLBMEBGCoWEnjHW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA5NyBTYWx0ZWRfX1WNosviEsbKL
 P1nhRwa0Nj2zwgUVUz72RgGWJbwOFTnusn03QCgh4KjegKE1xegIjy1U2NOy1fi9HW2zIR9pKeR
 ZjkHEVXZ+CBr+PykV0f2E6E06Q3mxita+yp378cPLnT0XdK5/iNQhlleN87J5OUBURaDO1PzvfE
 n4/bkh/2aNHssUuvxLvgp/anVmSNSguNkCVuso/honVm6aijpXFWXOT0LxyNboArFegJzEQXHC9
 mWrqc8hZI4yHhXoNY8BBPUxMx/T3nuDhhh+aqCBCm/mS1q4vEjZBwkPWk6k30GQVV65xcn/TxU+
 4G6KmecLKXaDnkWNVUvp67wGvV75lbDsN2zsAcKzw9wfmWmshq6Q0UkZVs3MmLcn2WK3V5hoexz
 zWq4CKtx938crzapNFKBed2GB4Mhg0g87ta9D0B414pbyOgFL39iPzR3g8JYoDXK8HE+a5uHF2Y
 HE5C0J53AkOIWbQJvgg==
X-Proofpoint-GUID: G1AJjcx1uPAjyOjupsLBMEBGCoWEnjHW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
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
index 789721bdac..83969e0e73 100644
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
@@ -132,6 +133,8 @@ fp_hvx: fp_hvx.c hvx_misc.h
 fp_hvx: CFLAGS += -mhvx -mhvx-ieee-fp
 fp_hvx_disabled: fp_hvx_disabled.c hvx_misc.h
 fp_hvx_disabled: CFLAGS += -mhvx -mhvx-ieee-fp
+fp_hvx_cvt: fp_hvx_cvt.c hvx_misc.h
+fp_hvx_cvt: CFLAGS += -mhvx -mhvx-ieee-fp
 
 run-fp_hvx_disabled: QEMU_OPTS += -cpu v73,ieee-fp=false
 
-- 
2.37.2


