Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7EFC9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBSSN-0003AK-3C; Tue, 29 Sep 2026 03:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSSI-00038v-Bd
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:40:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSSF-0005qY-DE
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:40:50 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T7Tnwq2570942
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ltkuL0zXGBn
 lXgfAP8TJlBhNn/b1o8G0Dnrulrn0+fI=; b=TJqpfKnqUi5bIc0Me6hY0hgB1dR
 hfwvYUfcizclLvEDsujyQLV3iVTQ5NdqGUgtd8Q9OnKQ3EhjL3BiRUmVXnRJdl7x
 nq52kHjCb89FnQ2OjIUnsrfV5+91ROB0yEDfdCDVGue+H3Y6mogngVioJsKsYqY4
 AkD8Cejg7bzf6EiDGprShhUj6ztu7LjFZ2hMrwhsY8MXXWZiP0FU6JYWBy05zzrq
 VD4eV7Dg+iiS2i8ex9iCWIdwwI19YatzXV1stK0rR+UwC3/MYw+iTz012pK0Vuxf
 g1e4p4DL2CKmGdkvf/JeMQTnFzdh6PbS2K/8rJ+62I6hCVLRjWfRBIgDJRQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h02mn9f9v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:40:45 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-342a0e1d8c4so2107937eec.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 00:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790667645; x=1791272445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ltkuL0zXGBnlXgfAP8TJlBhNn/b1o8G0Dnrulrn0+fI=;
 b=XWmcu82jnfZxdbWAp95Qg1jes+bgV1B/iUG3FXm1ObV78b9pp6LO5gTrOfLx7ckJdf
 LH9PQy/1y9ObtbjzUgHmqHsUwggT68jlkdF1hd4zBY5uqofwwKeudZGA6RxsfBxrmun4
 qoZ5TXV2wwm3g/3TbJB8cWIURR9Hz30syTMNfElRL4DRtT3nAxQzC3MrfhUVcQ1RjKLZ
 ovr3gz0dKiTMdR9nuVSoHLqrT4R+Lkqr2LxSYSMdYpEk6KnW0RWZagAqU+wXPZG9mjrF
 Mherqth7bEffdli3ezPiowFrYdNPa5hXM0Jdt2HGbqkTs6M1MB4u1JOluJjnwbmawxZt
 bqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790667645; x=1791272445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ltkuL0zXGBnlXgfAP8TJlBhNn/b1o8G0Dnrulrn0+fI=;
 b=1ARfEOyWUuW2+2NMN8LNvNn2f5gx9ylyhX9Qov1Z4xxKRLk+uQLBYi8wTtTnEzbIZm
 VKfnTsiD8BY/S+5CBRxlv7ntppT7gwrpqvxnzjR6kSzkI9tUWEMt8/p2EPmE6xKZVxab
 MhxGGcytwLq6z3wYbHv6GZxRLTaX8OxYy7Z1XlUUNN3fHvWu730nZosTOS0hQaE7KhH+
 vZbmpnT/VPFUqGSIf1IF1naEABkqG50MnUL2a94lAT5Uc1R+hxJ9E9QSQrJfesImYsrX
 9e2OdvTwR4A7x8FXc1nfTs02O4Xv65DPSVzX+IUR26aCbeER86UWhvq+kIitJw9OdRIw
 6zcA==
X-Gm-Message-State: AFq9FYKXqcLQ4z1R3bGovJH1N/GOS3XS3l76OFzUXJ9SQug2OCEZEwc+
 RuIgvEIvUG+vvTHMSivIQzGYuoS0dGYxeNh08mED5xKhE1/IQU+agJhfDeOBhM2RyDShdTflOpn
 zeLGyfM5R5/s0Zgqmq3VVA8XFD0b5JSsxOhr92v7ui9wHEp8AR7Tt6It1VkinHad+uA==
X-Gm-Gg: AYBFou1MfS7CNXUXdwddfagxJkdjSiWNQBvSE1ucKuhRsHjjWHp5FI56AElBR+WrQ+V
 xMEQ3e/G3M+Zm5STpiCVgT+5Wp+vIciDeIsdxYP0AGtEs6SYhIUssxGMIbJiQy55h5T4QIN9qEb
 jyBdHAUi7EueFjWc4aTyVQWdLorBAemwBZzEPadiQeEiuwiv5HbkClPR5OMZ6vtqlUYET6D8k+5
 jdaIa+/BK491OygzLKkpCgZovumWlDsoYSYyV1vzA8BebL+i9esWNWSMKUpfVyZ5X1Q1891rJZo
 vcqPE8s3VwyfLYbh4b1JMreSPSbpjfYINBcVRyuQkLgL8tsRk/+rJaUeh5hpzxI6MCxsvF/SXK3
 EzxcMY34lRA8LZWWQScVcSIPsF0pI1iCQImQKkLCJCNrKyz0GTr/IC6Tm6A==
X-Received: by 2002:a05:7301:1f15:b0:33b:bfb7:31cc with SMTP id
 5a478bee46e88-342710ae1f0mr17043928eec.16.1790667644968; 
 Tue, 29 Sep 2026 00:40:44 -0700 (PDT)
X-Received: by 2002:a05:7301:1f15:b0:33b:bfb7:31cc with SMTP id
 5a478bee46e88-342710ae1f0mr17043900eec.16.1790667644214; 
 Tue, 29 Sep 2026 00:40:44 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3444fd04d93sm14647822eec.12.2026.09.29.00.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 00:40:43 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 10/19] tests/tcg/mips64/test_mips64r6: fix include path
Date: Tue, 29 Sep 2026 07:39:58 +0000
Message-ID: <20260929074007.118970-11-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X9fHu2Te c=1 sm=1 tr=0 ts=6abb6b7d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=sNg5_NCLbvA7XQG1W-cA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: I6YHQQ9XFfhqOJfTL8i-yv-zf-08grYr
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfX3UfwDS4ccfR6
 3laePGh7Zv6NeBNrdG5gbdMoZ82moQ/42P27IEWYnadfwohHxVxPTQwkvMyQYBi/N7UTohyjb1D
 XiVgZKRMmeCL9GRye9+2sBMxGWDyHvU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfXw05VLzSaTRev
 eNgZIyRei/yHZKxwUIBcbBrt7qypHT5CB6Rzj/ZyKZ0r5M0fFxMgGe0VgHq6R9icdbW4F91QprO
 HXLftRBtgzkH2j/SeEr0qZIutPvNN/wWgsANVoFXMw5ubX10SdC3InA9237nQ8lpDj84bP0ec0D
 YQ0HI7uwhZ2x5NyPcfRFkSb/mxU5dModBVcjmdEEs01aM+VO0P+rWNUXOyPxmMERhC5iWNP88Ji
 M3k5rwPnko8fGOwCnT9MT8nfR8XQGSaz1ntSky7AQHDNOosiMlhsk0PmpYuP9KkiAmcey5H7aWz
 WMT+0DXNo1mqth7HdiTPrNr7fdc8mM5HjJafB9AGXxQwDQCnLMbPFZiC4iWddedmy/mPZgXfcHB
 EsalO4drH4+m/KTu2xakTaXKBdOxS7Blh5iHJDMViYIOaiPjsz+z0T1IPypWJqM0k8cSvTFgT9R
 V2HUc0Ar1PYOa2vbqEQ==
X-Proofpoint-ORIG-GUID: I6YHQQ9XFfhqOJfTL8i-yv-zf-08grYr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips64/test_mips64r6_and.c      | 6 +++---
 tests/tcg/mips64/test_mips64r6_bitswap.c  | 6 +++---
 tests/tcg/mips64/test_mips64r6_clo.c      | 6 +++---
 tests/tcg/mips64/test_mips64r6_clz.c      | 6 +++---
 tests/tcg/mips64/test_mips64r6_crc32b.c   | 6 +++---
 tests/tcg/mips64/test_mips64r6_crc32cb.c  | 6 +++---
 tests/tcg/mips64/test_mips64r6_crc32cd.c  | 6 +++---
 tests/tcg/mips64/test_mips64r6_crc32ch.c  | 6 +++---
 tests/tcg/mips64/test_mips64r6_crc32cw.c  | 6 +++---
 tests/tcg/mips64/test_mips64r6_crc32d.c   | 6 +++---
 tests/tcg/mips64/test_mips64r6_crc32h.c   | 6 +++---
 tests/tcg/mips64/test_mips64r6_crc32w.c   | 6 +++---
 tests/tcg/mips64/test_mips64r6_dbitswap.c | 6 +++---
 tests/tcg/mips64/test_mips64r6_dclo.c     | 6 +++---
 tests/tcg/mips64/test_mips64r6_dclz.c     | 6 +++---
 tests/tcg/mips64/test_mips64r6_dmuh.c     | 6 +++---
 tests/tcg/mips64/test_mips64r6_dmuhu.c    | 6 +++---
 tests/tcg/mips64/test_mips64r6_dmul.c     | 6 +++---
 tests/tcg/mips64/test_mips64r6_dmulu.c    | 6 +++---
 tests/tcg/mips64/test_mips64r6_dsllv.c    | 6 +++---
 tests/tcg/mips64/test_mips64r6_dsrav.c    | 6 +++---
 tests/tcg/mips64/test_mips64r6_dsrlv.c    | 6 +++---
 tests/tcg/mips64/test_mips64r6_muh.c      | 6 +++---
 tests/tcg/mips64/test_mips64r6_muhu.c     | 6 +++---
 tests/tcg/mips64/test_mips64r6_mul.c      | 6 +++---
 tests/tcg/mips64/test_mips64r6_mulu.c     | 6 +++---
 tests/tcg/mips64/test_mips64r6_nor.c      | 6 +++---
 tests/tcg/mips64/test_mips64r6_or.c       | 6 +++---
 tests/tcg/mips64/test_mips64r6_sllv.c     | 6 +++---
 tests/tcg/mips64/test_mips64r6_srav.c     | 6 +++---
 tests/tcg/mips64/test_mips64r6_srlv.c     | 6 +++---
 tests/tcg/mips64/test_mips64r6_xor.c      | 6 +++---
 32 files changed, 96 insertions(+), 96 deletions(-)

diff --git a/tests/tcg/mips64/test_mips64r6_and.c b/tests/tcg/mips64/test_mips64r6_and.c
index 4d6cf2e1f1d..38ae641e907 100644
--- a/tests/tcg/mips64/test_mips64r6_and.c
+++ b/tests/tcg/mips64/test_mips64r6_and.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_bitswap.c b/tests/tcg/mips64/test_mips64r6_bitswap.c
index df3d1b11f6b..ae2f74b34ee 100644
--- a/tests/tcg/mips64/test_mips64r6_bitswap.c
+++ b/tests/tcg/mips64/test_mips64r6_bitswap.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_clo.c b/tests/tcg/mips64/test_mips64r6_clo.c
index e7ecdc59100..611dcc9572f 100644
--- a/tests/tcg/mips64/test_mips64r6_clo.c
+++ b/tests/tcg/mips64/test_mips64r6_clo.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_clz.c b/tests/tcg/mips64/test_mips64r6_clz.c
index a77a8e4eb59..3f89cbdec2f 100644
--- a/tests/tcg/mips64/test_mips64r6_clz.c
+++ b/tests/tcg/mips64/test_mips64r6_clz.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_crc32b.c b/tests/tcg/mips64/test_mips64r6_crc32b.c
index bb1f3f69249..7b8955cffd5 100644
--- a/tests/tcg/mips64/test_mips64r6_crc32b.c
+++ b/tests/tcg/mips64/test_mips64r6_crc32b.c
@@ -11,9 +11,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_crc32cb.c b/tests/tcg/mips64/test_mips64r6_crc32cb.c
index 1439d44bf20..58479c2733b 100644
--- a/tests/tcg/mips64/test_mips64r6_crc32cb.c
+++ b/tests/tcg/mips64/test_mips64r6_crc32cb.c
@@ -11,9 +11,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_crc32cd.c b/tests/tcg/mips64/test_mips64r6_crc32cd.c
index bf258e0696d..417cd895fb9 100644
--- a/tests/tcg/mips64/test_mips64r6_crc32cd.c
+++ b/tests/tcg/mips64/test_mips64r6_crc32cd.c
@@ -11,9 +11,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_crc32ch.c b/tests/tcg/mips64/test_mips64r6_crc32ch.c
index 0e7b67732e0..9ae4804e687 100644
--- a/tests/tcg/mips64/test_mips64r6_crc32ch.c
+++ b/tests/tcg/mips64/test_mips64r6_crc32ch.c
@@ -11,9 +11,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_crc32cw.c b/tests/tcg/mips64/test_mips64r6_crc32cw.c
index f7110b3a0a4..2e1ca6f836f 100644
--- a/tests/tcg/mips64/test_mips64r6_crc32cw.c
+++ b/tests/tcg/mips64/test_mips64r6_crc32cw.c
@@ -11,9 +11,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_crc32d.c b/tests/tcg/mips64/test_mips64r6_crc32d.c
index e391be803f7..d916ee2586b 100644
--- a/tests/tcg/mips64/test_mips64r6_crc32d.c
+++ b/tests/tcg/mips64/test_mips64r6_crc32d.c
@@ -11,9 +11,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_crc32h.c b/tests/tcg/mips64/test_mips64r6_crc32h.c
index 100f02c7dda..72575e95858 100644
--- a/tests/tcg/mips64/test_mips64r6_crc32h.c
+++ b/tests/tcg/mips64/test_mips64r6_crc32h.c
@@ -11,9 +11,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_crc32w.c b/tests/tcg/mips64/test_mips64r6_crc32w.c
index b4f5f4bbee2..4518b4fe482 100644
--- a/tests/tcg/mips64/test_mips64r6_crc32w.c
+++ b/tests/tcg/mips64/test_mips64r6_crc32w.c
@@ -11,9 +11,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_dbitswap.c b/tests/tcg/mips64/test_mips64r6_dbitswap.c
index 377835940d9..7473f3f0ceb 100644
--- a/tests/tcg/mips64/test_mips64r6_dbitswap.c
+++ b/tests/tcg/mips64/test_mips64r6_dbitswap.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_dclo.c b/tests/tcg/mips64/test_mips64r6_dclo.c
index eb41fbdfdf7..a6f8688b76c 100644
--- a/tests/tcg/mips64/test_mips64r6_dclo.c
+++ b/tests/tcg/mips64/test_mips64r6_dclo.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_dclz.c b/tests/tcg/mips64/test_mips64r6_dclz.c
index be393ac1992..ab2d3eadeff 100644
--- a/tests/tcg/mips64/test_mips64r6_dclz.c
+++ b/tests/tcg/mips64/test_mips64r6_dclz.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_dmuh.c b/tests/tcg/mips64/test_mips64r6_dmuh.c
index eb21615f952..490c81f884a 100644
--- a/tests/tcg/mips64/test_mips64r6_dmuh.c
+++ b/tests/tcg/mips64/test_mips64r6_dmuh.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_dmuhu.c b/tests/tcg/mips64/test_mips64r6_dmuhu.c
index 7316d79e2af..28dd2026418 100644
--- a/tests/tcg/mips64/test_mips64r6_dmuhu.c
+++ b/tests/tcg/mips64/test_mips64r6_dmuhu.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_dmul.c b/tests/tcg/mips64/test_mips64r6_dmul.c
index 3ac1965cca3..2a33d678992 100644
--- a/tests/tcg/mips64/test_mips64r6_dmul.c
+++ b/tests/tcg/mips64/test_mips64r6_dmul.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_dmulu.c b/tests/tcg/mips64/test_mips64r6_dmulu.c
index 0862780e3de..161d1fe96bc 100644
--- a/tests/tcg/mips64/test_mips64r6_dmulu.c
+++ b/tests/tcg/mips64/test_mips64r6_dmulu.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_dsllv.c b/tests/tcg/mips64/test_mips64r6_dsllv.c
index 4f719efda12..fc93e0b218a 100644
--- a/tests/tcg/mips64/test_mips64r6_dsllv.c
+++ b/tests/tcg/mips64/test_mips64r6_dsllv.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_dsrav.c b/tests/tcg/mips64/test_mips64r6_dsrav.c
index 024d508ca87..e496e8fa83a 100644
--- a/tests/tcg/mips64/test_mips64r6_dsrav.c
+++ b/tests/tcg/mips64/test_mips64r6_dsrav.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_dsrlv.c b/tests/tcg/mips64/test_mips64r6_dsrlv.c
index fd1c398ffde..2c4c04f4c42 100644
--- a/tests/tcg/mips64/test_mips64r6_dsrlv.c
+++ b/tests/tcg/mips64/test_mips64r6_dsrlv.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_muh.c b/tests/tcg/mips64/test_mips64r6_muh.c
index ff1ae6fd9ce..8f371e22e61 100644
--- a/tests/tcg/mips64/test_mips64r6_muh.c
+++ b/tests/tcg/mips64/test_mips64r6_muh.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_muhu.c b/tests/tcg/mips64/test_mips64r6_muhu.c
index cb2752767a5..79824c05b13 100644
--- a/tests/tcg/mips64/test_mips64r6_muhu.c
+++ b/tests/tcg/mips64/test_mips64r6_muhu.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_mul.c b/tests/tcg/mips64/test_mips64r6_mul.c
index 5cdc4d56324..9589c4c3a08 100644
--- a/tests/tcg/mips64/test_mips64r6_mul.c
+++ b/tests/tcg/mips64/test_mips64r6_mul.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_mulu.c b/tests/tcg/mips64/test_mips64r6_mulu.c
index ccb3bdc1ac5..72b4d038cfe 100644
--- a/tests/tcg/mips64/test_mips64r6_mulu.c
+++ b/tests/tcg/mips64/test_mips64r6_mulu.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_nor.c b/tests/tcg/mips64/test_mips64r6_nor.c
index 21005ddc53b..04b841c8df1 100644
--- a/tests/tcg/mips64/test_mips64r6_nor.c
+++ b/tests/tcg/mips64/test_mips64r6_nor.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_or.c b/tests/tcg/mips64/test_mips64r6_or.c
index 345b4544fe0..fde9601a78d 100644
--- a/tests/tcg/mips64/test_mips64r6_or.c
+++ b/tests/tcg/mips64/test_mips64r6_or.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_sllv.c b/tests/tcg/mips64/test_mips64r6_sllv.c
index a5fa72b7278..46136de0634 100644
--- a/tests/tcg/mips64/test_mips64r6_sllv.c
+++ b/tests/tcg/mips64/test_mips64r6_sllv.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_srav.c b/tests/tcg/mips64/test_mips64r6_srav.c
index 79e1a047eb7..94c528f8ab8 100644
--- a/tests/tcg/mips64/test_mips64r6_srav.c
+++ b/tests/tcg/mips64/test_mips64r6_srav.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_srlv.c b/tests/tcg/mips64/test_mips64r6_srlv.c
index 1f8c45d8cc8..993d0b75205 100644
--- a/tests/tcg/mips64/test_mips64r6_srlv.c
+++ b/tests/tcg/mips64/test_mips64r6_srlv.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_xor.c b/tests/tcg/mips64/test_mips64r6_xor.c
index 7e36fee517a..3ab67ea0555 100644
--- a/tests/tcg/mips64/test_mips64r6_xor.c
+++ b/tests/tcg/mips64/test_mips64r6_xor.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
-- 
2.43.0


