Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD5CC9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBSSW-0003CW-CX; Tue, 29 Sep 2026 03:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSSU-0003Bq-FL
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:41:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSSS-0005rm-Ej
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:41:02 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T7U4MM3221467
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:40:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=5YE19x1blEu
 tyi92n8x0iT8zwHG5zqqblAAA2ATMedw=; b=VvX4jMbG+pLTgR0hYOssSOx/IiZ
 1j8T975k1WYRo1ZENem6WKlxwOtfqr4um/WV5Xw0jBNK6kE5jem/GyXLil8Tq+yg
 VnB7H28TOHGLSd5soP0IB+nopbGWvjSM1AeLrfIUSQUmrYepqkJV9/wURMmApZLy
 Sr5FYlP4HhW6OHpGzLjUGOn6oOsq12eLZdBousonhtaw0Mhv3GIzRr4q1MIQVZUQ
 0NKe4TjfJF5YihY4U/RKOs0r2hKKbtLnSB2rxhGw38YVaOknbPcILO+3KhlK+Xtp
 27CZoN+tPnjtwonXvqSjCX/uBv587jHMjRD/1/eW7QnObhoHl0qe5vZQfew==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyvw22v1b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:40:52 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-342a0e1d8c4so2108206eec.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 00:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790667652; x=1791272452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5YE19x1blEutyi92n8x0iT8zwHG5zqqblAAA2ATMedw=;
 b=S48LzrXUfZHExj9eagUpMquoRdqC0i04jE7UpN07b26wQl2LpiJsT2XvdZCDaEv6kP
 swuSQB+0uy6DdU0uJhLiLW5ITJ3wVcyvCB0UZdI5cmDuorpO3Nyn+vPYFCN31rA/3hLi
 2nhcniLgZB8CjCP1sIMNHnP0rRk4eFEpfLHwdj5w+XF7RkXdgfGrUTT9Vb+jaRKBZoMJ
 zfuwIMdb04/NKndoURj6O9n1uKpvwM136hwgNM3XGonI7oWT8Qn4L8Oygdzorglj7Cvp
 WYYcB0gZajPLr3XEdSw29r9eDJV2/AxO3XB8voD3JXxAEt5uVQBsek+56ONvDR5BzUk/
 0MGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790667652; x=1791272452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5YE19x1blEutyi92n8x0iT8zwHG5zqqblAAA2ATMedw=;
 b=bu7zcoxPsTNnz2Nmumy+hrtV+Lvh6rKEgrLE6KOYRzXu5ASflG7v4ciS18BJs5R8Xm
 kMrWy0jNqGAjg9nT00RMIVrDLIOiG0thEfOmOEmyVlHijcktmu0jqtSXTZz+qubgpRs7
 hmaSldGchgrZBKPdxBic8QNUpoT5qYk6FYAmHHTc1x/UMgHsbipLLYO7XMekvxxYfGo4
 bMiYkjZuxUt6TTxyYk8BoM/rhqxtGbvRI5ACo7cILl1lbwo6lvg3jDv8iEt2wtUznuu6
 baWL3nrqN+8/A7jOMsjnT6PRDMa9pCMXy6sdwmFFI9XhunRAwcvWjVajWG1LklDCTj+o
 VEEw==
X-Gm-Message-State: AFq9FYJoth+QzFT+yQ2mM51n0w6Nr6DbPWv3nTFP0UI2R1p2X9nQH9zD
 fzN9oHAohfjv7nH74SUd1vNBr4j8bGT4gQCO4wdqKkMzJxTGiLJUmfFhLXaHZFloQOK8BbBl2Jy
 tYnoQ732q6MGOHvpyYxLtFBHed3/dwydK+/w4Sczsl7d2n0faSVNgSWySi3uiDrlaNw==
X-Gm-Gg: AYBFou3wwlyKsbNSSYxuHUz0gVlX95KawJIkvRq+gsl7luqHQoK5qTKyJO61lIFqEcE
 CKdNWqMI0r0b0yQzEZgsiVvEpr1SnY6Ne6OB1NMyAlokwEAt8/LyTUFsiCl8KWlRXIFix8nGCoN
 oh1pEP9lXBaQ1Hfl7pOEvgxHWZomFzuvOApojI7uFHAswJSPvCtS/1yRBh+MAoSqNP0331LYX6H
 r1zwXPn8//JZzTfDAkc4Wnd0efoECwMCNEoZ8nnkKmrJLpNkH1jYd0IJbeHNi9UF8ZzlL/VyplY
 6DqP5Duo5KGRqxiA1oco/ma37srEcsVxTM0/TOfWMxQLmuUTleP5AerGVMIgpJ59AIbFKWb5iG9
 4VcaqZrId7GaPoSaNtDlDOXSI7arGA/O2Py9uHzyz2i80izBzkTpeXrZGjw==
X-Received: by 2002:a05:7301:4d0b:b0:341:1d4b:451c with SMTP id
 5a478bee46e88-34272371097mr13607633eec.21.1790667652091; 
 Tue, 29 Sep 2026 00:40:52 -0700 (PDT)
X-Received: by 2002:a05:7301:4d0b:b0:341:1d4b:451c with SMTP id
 5a478bee46e88-34272371097mr13607599eec.21.1790667651448; 
 Tue, 29 Sep 2026 00:40:51 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3444fd04d93sm14647822eec.12.2026.09.29.00.40.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 00:40:50 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 15/19] tests/tcg/mips/include/test_utils_64.h: add
 check_binary_op_64
Date: Tue, 29 Sep 2026 07:40:03 +0000
Message-ID: <20260929074007.118970-16-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=N6i8hG9B c=1 sm=1 tr=0 ts=6abb6b84 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=DumKuXrDE2KHUNgktGwA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: _TAIfyryAOeoCcDa_LRVzkCyfNreQ2oT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfX/e/0ahQf+A1b
 4/JZhZ6OmZw4gVwvCoZMe6tcJ00LM6jpQfe/sd3RGyAWe2dPekNKFfCTn9TAvwAOiiP0UyK5Is7
 0cBhOItXloz1ny7NNw+7aI8UCzlvGPwukCkpdC2WZgo37WppxIWME2fNpGojXWgGrfpdDGsxmuv
 NPk0Kt0BFRN7c0wEDLBmTQag54XLCIUdoa5chAUf01ayfdt4mDEGyTA9Ab+q7WFCJAw19FhYM3h
 1mseNmuWPN+6qF/TXx8pVhSXuxJ9hL5Lq9k++paWONi2ghmD1WsCv/wNJFWzOa0gH+b96/h+7vA
 pgM0foSXkH/m/2nVkmg+1hvw5pvfCOood4uYQjIKdaH6bD23BV/r2dF9/yPhDLeIoy9/GU2xZQX
 +f7CIgtibMq/CHOqM4VRMAsZUsBEMtdZqrvIxIaHn/a2v0v6QOkGYQ7jE1okuOqG8Fq7lr+X1Tc
 xtLZW0dUBhr1mnUe8NA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfX3NZIlScBj/2A
 jm/Vv/QKKxQiDdxZSLRthl2T6RdmS26GD65OGTKtLn3nPoSzm3DpfwlVvK+T61s+SrMExN/HonE
 EzGC8P9+bymc10GvEZRuTd22+aa3hv0=
X-Proofpoint-GUID: _TAIfyryAOeoCcDa_LRVzkCyfNreQ2oT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290030
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Each mips64r6 test copies the same loops, to generate an output vector,
that is compared to expected one. Also, input values are not reported,
making a failure hard to debug.

Instead of this, factorize this loop in a single function, and compare
elements one by one. This function generates a C compatible output, that
can be compiled on host to check that all values are correct.

We use that for the few failing tests to update their reference, and
check it's correct.

At this point, failing tests are:
- mips64r6-linux-user-test_mips64r6_and
- mips64r6-linux-user-test_mips64r6_nor
- mips64r6-linux-user-test_mips64r6_or
- mips64r6-linux-user-test_mips64r6_srav
- mips64r6-linux-user-test_mips64r6_xor

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/include/test_utils_64.h | 40 ++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tests/tcg/mips/include/test_utils_64.h b/tests/tcg/mips/include/test_utils_64.h
index c9609d8281f..b785c26d093 100644
--- a/tests/tcg/mips/include/test_utils_64.h
+++ b/tests/tcg/mips/include/test_utils_64.h
@@ -22,6 +22,7 @@
 #ifndef TEST_UTILS_64_H
 #define TEST_UTILS_64_H
 
+#include <stdbool.h>
 #include <stdio.h>
 #include <stdint.h>
 #include <inttypes.h>
@@ -77,5 +78,44 @@ static inline int32_t check_results_64(const char *isa_ase_name,
     }
 }
 
+typedef void (*binary_op_64) (const uint64_t*, const uint64_t*, uint64_t*);
+static inline bool check_binary_op_64_with_input(binary_op_64 op, const char *op_str,
+                                                 const uint64_t *expect,
+                                                 const uint64_t *input,
+                                                 size_t rows, size_t cols)
+{
+    bool ret = true;
+    for (size_t i = 0; i < rows; i++) {
+        for (size_t j = 0; j < cols; j++) {
+            uint64_t input1 = input[i];
+            uint64_t input2 = input[j];
+            uint64_t expected = expect[i * cols + j];
+            uint64_t res = 0;
+            op(&input1, &input2, &res);
+            printf("assert(0x%"PRIx64" == %s(0x%"PRIx64", 0x%"PRIx64"));\n",
+                   res, op_str, input1, input2);
+            if (expected != res) {
+                printf("// error: expected 0x%"PRIx64"\n", expected);
+                ret = false;
+            }
+        }
+    }
+    return ret;
+}
+
+static inline bool check_binary_op_64(binary_op_64 op, const char *op_str,
+                                      const uint64_t *expect)
+{
+    bool res = true;
+    size_t pattern_size = PATTERN_INPUTS_64_SHORT_COUNT;
+    res &= check_binary_op_64_with_input(op, op_str,
+                                         expect,
+                                         b64_pattern, pattern_size, pattern_size);
+    size_t random_size = RANDOM_INPUTS_64_SHORT_COUNT;
+    res &= check_binary_op_64_with_input(op, op_str,
+                                         expect + (pattern_size * pattern_size),
+                                         b64_random, random_size, random_size);
+    return res;
+}
 
 #endif
-- 
2.43.0


