Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1692C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ6Q-0008Oq-10; Fri, 10 Jul 2026 17:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ6O-0008Ge-9J
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:49:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ6M-00058p-BM
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:49:44 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3GeN1621358
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WUVWrs/POnUdy5koxbqAG2WnkanMpt9AwC18uUHtiuw=; b=jWp+dkDuHdiROlue
 XpFT5ryHAdQUrjuSEOOYQB66slurEJlw9k+JxM/Xq53gnuJIEhzi9hvL5r/HFnVU
 gerQaxYh+1noEXZ5aqrrhOQJtagDBNuVWZhzIs4iq/xaweKQ2SkFgO4djMR1qWIX
 cRoAYPcZjOUaiBnXPvxNpve6YKQiAHPEwUykpoBC7wYdeU4erltX86sgGhkB6Sh/
 xxH9Na6nz/AhcxzUnlR5zvwuG2LzSNvS4iUH2RTfHFj3a8aWVyZi5zlpIsfWWaNc
 GTIher48ZbdxJpVt+ItbNfUXOr+5ROrDHPLfFY+LGNkWlSIi0lKN5LwEu8ZdymB6
 eo5lyg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb4rm8v7k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:49:30 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3812b0c6f23so1586810a91.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720170; x=1784324970; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WUVWrs/POnUdy5koxbqAG2WnkanMpt9AwC18uUHtiuw=;
 b=DUPDQWaX0Zxi8mHwwgPupChltu+lcHKsORe3XlWblxrqX0Z9pfgMEqknc8syJH812U
 hrrm3rql/pxOq1mpSy4GQFotAdO5tylMSHKNe09wPjUdN0p9UPkQs+ZV02rLztsfX/zJ
 yOum24Mp01FDYHfuQ/1wwEi626x6asU9NZk+xcrqPhP8nae/eNiJQlj3PDTrKBo+bvzq
 1Fw7iG2uOUksjVp31gKjuz55WcggwTsy0Rp62w/hGkmEvYl4WmfZDidRRH96ZB0HHRW5
 w4CuzfEE0CruNxFvBUotGwUfbPXhAoU6z5Tc79Uky8mWUf6rTWdX5JRzDTRIH/uL/+b+
 gN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720170; x=1784324970;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WUVWrs/POnUdy5koxbqAG2WnkanMpt9AwC18uUHtiuw=;
 b=X1XCLcn7Zk/yIiAj1i972ZbnzMzbvBpg/Z+IagKY+4j7GK3l2NPLs06bo2SJPbE0lh
 2GtWl56ulaYF8vtSuD+7OzXm4hka2GEvs7S4jbNmi8N+rYuJDB8krez2E+oxc80rCPnb
 BTv3QmxrPte3ilPpGu2tbctOqoHk8PMMUeDEuCUeI/NrEDJvPVEczLsdVKO0KOMk+8Qk
 PkTeo67z7RgzW89DNHnBEb0zOuBGTppuyVQcVZPPbkbFg00jngqZnM693+5+CbidbB4L
 eJquAldTGFdcexNsDzON40OauxyrmGW6whO3BK3MMt7WK+bnc4+ftc3ioAJ8A3AbmEUS
 ZK/g==
X-Gm-Message-State: AOJu0Yzo133CuDfNmOlLLg/ghKrNalOT73galesnHVqtEL5WXUARqKje
 pcgMKJh57MmJv3Ygesi5Eiii5Hh5GRPFZiAZnSpj6p9iKu6vVhcJt0iTWKgzBMN1veyw8UpJHD3
 JaB9yTvpK5EhHkXmnMFiu3F2q/JGDC9NEphJB9ySPS94JsG1djT8Ng2lIJ8vXdAkh4w==
X-Gm-Gg: AfdE7cmysp2k3NQw66fqi6WinyOGiNEHk1Tmgo6x76uESoesZMs3KOx8wEMI/rgUCPj
 8ZQ7k1WB99czSzyZkporfmlA3+ZLk3s0X1QVNj+DK2UldFuJx2hQ2uhl6B9i75ZGiEukf0eFsnB
 wbNkvqQ8kAKFLfjZoKFtO9n24OWFn11e9DtiSXJNsWapMhsPpU61tiF24yTyCWNzvQc/k37IwmT
 lHSB+82MKm0yzfdlbJCQWbWzLb11Lnwa191aW2OGmEMjT6G3uiPFhB7IKnukATlCp7x4bYV5hb+
 NM/36Ux+9m3O/FSmWzeGm7p1TsLXbDHZxNi2Mk3JGnFfhSIATAGGQNCGqW4pHqg5MbsYsBxDt+3
 qWU5fZ+CTN7ban7WjwsLHk3e/hke0onnPUUz9qns5pBDV5SKBPN6eNDHWiJkWsuqhWN9Mfs10xa
 aPTQsuUQ==
X-Received: by 2002:a17:90b:254d:b0:37f:9ce1:735c with SMTP id
 98e67ed59e1d1-38dc779d6c2mr703616a91.29.1783720170148; 
 Fri, 10 Jul 2026 14:49:30 -0700 (PDT)
X-Received: by 2002:a17:90b:254d:b0:37f:9ce1:735c with SMTP id
 98e67ed59e1d1-38dc779d6c2mr703590a91.29.1783720169683; 
 Fri, 10 Jul 2026 14:49:29 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311838c9235sm39886355eec.21.2026.07.10.14.49.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:49:29 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 73/98] tests/tcg/ppc64: remove dependency on qemu/compiler.h
Date: Fri, 10 Jul 2026 14:43:17 -0700
Message-ID: <20260710214343.2065491-74-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: XO_sNl-FzZgAQJLOwFf10WYPj6AjSdyI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX29u3lJLVrxt4
 bstUXe2wCq8X0Hoq7N7HzMIqVjQm7vv/NdoKo0unqSJl+rau3nN3uF3bG4kgmbG094p6xiMcEl9
 9PrtH/y/WOmjJlld8gefNQirfhXye0PH4LzTovOgasNrWFYYkfcJ07DS85kl5OAf7pEd2bWEv5l
 0/HbnY4Avo6UX87+CGahR3FZ6W826f+QLDggo9XvAIoabsunbHZmVw1I5d/E4IZSmwyzbTpomHL
 DLld7mi3Q5F778kobgZYThkfUO1GzpAa0+OufevAVkOU6jICvGc9xFqsoYe6W8NBkkBKnzudcDn
 tvvbB6oFqk2yP1RPRLEzoeZtKzcyF6EX3UTuY9zDn6K1ngP1fg0z41HDWaclNcODOYM1jy6I1K4
 badQLPzaGWQ4GI4gAP0z+m8czePBBArQ9vEBrJZmkRVMPWhk+BFHO1GTYMHVSSoGjJNMresaSBu
 SDGjREvt0HCHP2mSt0Q==
X-Authority-Analysis: v=2.4 cv=JIYLdcKb c=1 sm=1 tr=0 ts=6a5168ea cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=UsHlXZ0vMnIq6N_CsqQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: XO_sNl-FzZgAQJLOwFf10WYPj6AjSdyI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfXzhwzgAuLjAXW
 wxkUrlxg0GWiL/OiqhaNBMb9+bXgK6GlMaqjdUT/UYnIJblniH+twa0pkfVNjZVN0ot0dViU+Qw
 CHyq2pKdwjJBDrRBQwcKeckSv8nSPDk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100219
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

Replace definition of vector attribute, remove unlikely, and detect
endianness from __BYTE_ORDER__.

It's the only tests that use this, so for consistency, it's better to
not make exceptions. Also, not having this include path by default
prevents anyone from having the "good" idea to reuse any other header
from qemu in the future.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/ppc64/vector.c      | 11 ++++++-----
 tests/tcg/ppc64/vsx_f2i_nan.c |  7 ++++---
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/tests/tcg/ppc64/vector.c b/tests/tcg/ppc64/vector.c
index cbf4ae93323..70491d59251 100644
--- a/tests/tcg/ppc64/vector.c
+++ b/tests/tcg/ppc64/vector.c
@@ -1,6 +1,7 @@
 #include <assert.h>
 #include <stdint.h>
-#include "qemu/compiler.h"
+
+#define vector __attribute__((altivec(vector__)))
 
 int main(void)
 {
@@ -15,28 +16,28 @@ int main(void)
     vector __uint128_t vbc_qi_src;
 
     asm("vextractbm %0, %1" : "=r" (result_wi) : "v" (vbc_bi_src));
-#if HOST_BIG_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
     assert(result_wi == 0b1101111111000011);
 #else
     assert(result_wi == 0b1100001111111011);
 #endif
 
     asm("vextracthm %0, %1" : "=r" (result_wi) : "v" (vbc_hi_src));
-#if HOST_BIG_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
     assert(result_wi == 0b10010011);
 #else
     assert(result_wi == 0b11001001);
 #endif
 
     asm("vextractwm %0, %1" : "=r" (result_wi) : "v" (vbc_wi_src));
-#if HOST_BIG_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
     assert(result_wi == 0b0011);
 #else
     assert(result_wi == 0b1100);
 #endif
 
     asm("vextractdm %0, %1" : "=r" (result_wi) : "v" (vbc_di_src));
-#if HOST_BIG_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
     assert(result_wi == 0b10);
 #else
     assert(result_wi == 0b01);
diff --git a/tests/tcg/ppc64/vsx_f2i_nan.c b/tests/tcg/ppc64/vsx_f2i_nan.c
index 94b1a4eb02d..6a9d54faf52 100644
--- a/tests/tcg/ppc64/vsx_f2i_nan.c
+++ b/tests/tcg/ppc64/vsx_f2i_nan.c
@@ -1,5 +1,6 @@
 #include <stdio.h>
-#include "qemu/compiler.h"
+
+#define vector __attribute__((altivec(vector__)))
 
 typedef vector float vsx_float32_vec_t;
 typedef vector double vsx_float64_vec_t;
@@ -104,7 +105,7 @@ static inline vsx_uint64_vec_t vsx_mask_out_float32_vec_to_uint64_vec(
 static inline vsx_int32_vec_t vsx_mask_out_float64_vec_to_int32_vec(
     vsx_int32_vec_t v)
 {
-#if HOST_BIG_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
     const vsx_int32_vec_t valid_lanes_mask = {-1, 0, -1, 0};
 #else
     const vsx_int32_vec_t valid_lanes_mask = {0, -1, 0, -1};
@@ -209,7 +210,7 @@ static inline int test_vsx_conv_##SRC_T##_vec_to_##DEST_T##_vec(         \
     const int test_result =                                              \
         vsx_##DEST_T##_all_eq(expected_result, actual_result);           \
                                                                          \
-    if (unlikely(test_result == 0)) {                                    \
+    if (test_result == 0) {                                    \
         fputs("FAIL: Conversion of " #SRC_T " vector to " #DEST_T        \
               " vector failed\n", stdout);                               \
         fputs("Source values: ", stdout);                                \
-- 
2.47.3


