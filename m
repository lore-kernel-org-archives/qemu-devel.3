Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F37C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgryD-0003Ib-77; Mon, 06 Jul 2026 18:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgry9-0002q0-QX
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:39:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgry8-0007Bb-0j
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:39:17 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KDvv31566461
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=NyU/5WffZBE
 NLyPeBzCqpp8oOqt1j8JnR15jOhVyAak=; b=NBcPq4MuSRpzkyKqlXm3g6pMCp7
 Bb5Wknodjmat7rH8upzKBiPqQFzy5TV1R0aKjH1QKYXx3mW1sO9FwSZR1615SLjJ
 RoCIjYEl9LH7BnykSheyiyUI452HcTqoouSREWdU/1gwKjFDXzVJIhsOWu+BQwti
 9JQ8HIxWdhHV6uEYYMQ3d7O3NweeTYWd/V04R8YkUWhAZIY6fFYQzDedxuwTe1to
 D6WxYjFJ9REFF6UcoPsCsu2jeL9KBhXlKSoRI1bsUHkssZXiCjyZWJ7brhXDAIBM
 nVxdtYKhAyHjEFDchvNpNIhMeswBW3tpWPjxE9iTIXC2CQ20vHnI/baLAqg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87q7ku22-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:39:04 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c9667280edeso4253859a12.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377544; x=1783982344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NyU/5WffZBENLyPeBzCqpp8oOqt1j8JnR15jOhVyAak=;
 b=hsMVPeo3bbAGZhI0dItbE3YxsH+HZkYDZ0smMWaNl3HrlfvIGAd5ypcgVN02dWPHMR
 r5AzlNBuQr7JzuIHGXsBulLjo0oVkAZTUqySwWUaRWj6wAnGLyHCBsOGBb1JTyT+zfGf
 MkgUgDUsB030FgnP3U9uwr9uql1kH1LTF1b+2nLYSfYr+R/b0oszkvw8i4Fuk4E0awRU
 Tfh4a5KYYRCZ9R+6T3FvZb4S4ZkUOh6E9fMu29oP8/iP5Dd8njRbMSzHGAOszOmsotl1
 je7+He2ptSUIf54P1c8y8AGgxw04TUgNkMxkFXMERtOQwMsOh5TCcUdrWUYCv0Gw3b3y
 Z1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377544; x=1783982344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NyU/5WffZBENLyPeBzCqpp8oOqt1j8JnR15jOhVyAak=;
 b=Iyki5ZfBKo1C2GGhU05AIdTAWEgscqWetMkQjx1Xbo11qWYiJ9gtO3bYdTukjr04/1
 9Nmn2AuxzmsJ4FiJT6rE6ofgjPPB698hicli6N39XKoba9EGOS4w/wl1/1LH5w5kpXCq
 AoBvvC+aM3uG/JV5WvcaXtH168wcoic8DfZLZAOaWWD6D0PO8SkdcG9NWD/sjlug6Kf7
 DdPwsWTb+pewa0rigbE6m0wpwVcer+QxGzCLtAZo55COIriddH5PtGWI+kB7YlncKhAS
 vEr74HWPCUE0Up/eC/OlhbQLMJYMnwLBJZbHylVYZKP83bSvwddH4kavCNQsdb7aPB1G
 C3HA==
X-Gm-Message-State: AOJu0YwjOD+naek6x4W5OKtMe54Of+/9SBdOBLbffouz+woODTEZifsx
 /QfEe4WCd7+WswLS3ocKkXPAkhwmK7SzCKclRtATSH2prVFldsegCMoxA1tH8yQWmHPJV89sVld
 0k6dq5+QZZOxehmCuK9IG5qePhr7oqQ7ZVH9nhgezXfwknC6joeowLHrM7RLRT9L7iw==
X-Gm-Gg: AfdE7ck4uB1DqU3UIiv/+5MP39nE5qJ304l157TzGV4ArJSiesCFO94NMacqMhD9L1L
 vMl9SSPuCPwCOIJq2CUoBvgAfJf9aXGfTVNMBkWfbWTTrgSgmkPGQTzLbMQmA2k4gU19h/G2opj
 jlaaj/qBtbpoIOnjaccx9fj9wD9ur2AoYXrXd7mK38Resp/m6B9cnZ6al8ESdthL3pEHN0GJWfV
 afD6J/slKnrSn2l7n9p3L3QJalM5HlpWWFabJw9lc/1zmJHd31Mp84Vgaj3K/0j+hy1Ca/IwsS2
 BgArRM5b8B+tNxHQR4YEJmft51aknpxbmNi+hfgARZm91RFHuF6iFfZU5ygmmK4fYeCGd7XJcHq
 Pum+/v6t3i7HBBKXg+MVzIm0+nFEPD6YKT13bR0F7eD84A0AKDDAmYCEIvIhTGY+XA+0kW6xC8L
 yyuggkFg==
X-Received: by 2002:a05:6a20:9188:b0:3bf:aa1a:d2ef with SMTP id
 adf61e73a8af0-3c08effb0e9mr2996786637.56.1783377543616; 
 Mon, 06 Jul 2026 15:39:03 -0700 (PDT)
X-Received: by 2002:a05:6a20:9188:b0:3bf:aa1a:d2ef with SMTP id
 adf61e73a8af0-3c08effb0e9mr2996754637.56.1783377543054; 
 Mon, 06 Jul 2026 15:39:03 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1399484c88.14.2026.07.06.15.39.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:39:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 69/91] tests/tcg/ppc64: remove dependency on qemu/compiler.h
Date: Mon,  6 Jul 2026 15:33:21 -0700
Message-ID: <20260706223343.988769-70-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX+Qm93LEV7Gux
 ieDR26kBtm1QSRHIq4K5BLLW+mU+NhjhrH3D4cA3/6nfbLMs68UoQr45ZNhT08rUwdGxbfgBmvf
 9EoHtfY42XsNVhM2BdWoizHIyawij7SzruZ+UZMIssbEX/p59Zbw5npBSQy2ZzhtAbZqARxxcTV
 hXZ7+b6Tq1KRkoBQUE6QjvS3KGIaM98rDPF072CSEWxHZZaVlrjq5x8nUDvXZ9Yj/tZI3DRNMp6
 tPrtBupQVbERtGlS/QMcfJ3jct0ejsvcphN1FcmOCkB/Rsznf4q2DOPIwABrVTJDlRMIqA4bpqT
 2aRo1fPhfGYwOEExPloi995zabvHWLb39P3kR6Llp4FutIQ1+nx8AZlBuWPntrQrMyCsqo9Ms6T
 3mS6w+ODthMNvsB+WeXLn0lM2xDHsoMg3QoMiF1wt/+3qTZcIZnVrQkU0PLN8bX3ihdCdskKX7o
 aHI9w6FdDN/S1DiWMaA==
X-Proofpoint-ORIG-GUID: qCBhkLyV27sGT7dwrp1nTzE1iXRmo8bt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX9Yvapur/+OuH
 xXpIDzve3SNDBsi13Qjuk2soN1MVtYi6SZOeCNnnleZYSWUQVyxexYy+yiiiQixEJbX6nG+LjkD
 zTAecPMx/AkyOkbnKMvMresVxvP9bvc=
X-Proofpoint-GUID: qCBhkLyV27sGT7dwrp1nTzE1iXRmo8bt
X-Authority-Analysis: v=2.4 cv=f9N4wuyM c=1 sm=1 tr=0 ts=6a4c2e88 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=T-6bIZUQfWNMp-6iug0A:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060228
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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


