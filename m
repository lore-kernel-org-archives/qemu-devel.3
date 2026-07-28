Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F029FC54F51
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:50:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZlP-0004PT-E2; Tue, 28 Jul 2026 00:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZk7-0002nn-Qq
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:48:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZk5-0002AR-A4
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:48:38 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3akEk1673406
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WUVWrs/POnUdy5koxbqAG2WnkanMpt9AwC18uUHtiuw=; b=V0XUg6RcWeN4KNRF
 4UTPvdIW9+DstXTe9y/sCKOXQV4PeiN/LW+ty48BlbukgMWMkSULJ7/HNU0dqrWM
 KhLkTcrPWynpQLOktx2CLnow5bKp7oeViWYbMj+iJKYD+G2kaAvChHFwA+UwZJNm
 FNwxcIikXb4/XHU+3WkHutelWMFpYS5hJIpH5zXWN7x9H8ctaGn+TWWKnZBoxLF2
 6jP+lTk8Ji88B1mTW3Pq/LCyuEBtaPP20KwdQ6IWKMLY+eFz10PNUc9DNP49Ah6P
 APTeHjrz1p3cvrntxy8o9BLQSrbO2h/UfvXQQZweyEu9UsddnBRwXQbHBWVv0thV
 RMWxrg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbrstcht-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:48:36 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ce7dff6253so5826965ad.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214115; x=1785818915; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WUVWrs/POnUdy5koxbqAG2WnkanMpt9AwC18uUHtiuw=;
 b=I/DfYK8USPWDrt8ENWUcyGt6lcg/U62/htEQr1UNdVi80mvdUj/mIIdjLF+FWP79KK
 Erg6FKLrJcgBJ1sdEwqyWATMQlgVITZmBvmssdwtcZTUcdxqZA9aUI0ZpFB3areKgWDQ
 GTDBxRsfKFhpGmF97EPYQL3bEUVfhw1UmYytjxoj9Wz4GzUIV6+b2KOuxLOc0k6INwRy
 Y6C1nAJdLKKSesv569HFZAeHTULA2419L+FbiJeFD/YEQYJVrCCtwn0rUunfMuUfvwTs
 gnf/eCdf0BK9RGEVFW8BSbaNK9zfloe4Sc6UKE38nyfkLc9lEBsHgaVB9UdXy80XATAJ
 QOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214115; x=1785818915;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WUVWrs/POnUdy5koxbqAG2WnkanMpt9AwC18uUHtiuw=;
 b=sHeokKGNec1WdBQP8gdidfUKPeTvW9NuuV27dMA2njCqpLror0bfJ+Mz6HKaDRxTOc
 0Y/x3PlyEBGyxEw813XwI4yhd+1ubGmduA31JTxqzPPlco8PsP6pXAG7zUQzuBYLVTvN
 An8TwIDgr58/+wA+SGzNubR775/VN9Ul2+cATRHLDYrE+he26SqYObhhQvYtwnaROA1R
 BSfD/Xu508e0j5PzCYeqPiTMOAZgdco5xUN158KlUazhfaG/nSSGOKvJl5AdMa7Khree
 NkGT5Z2bha1pN+70Wczjb4YMo6aeItVOS6G1D8HAqmIHKrm3oaEw6ZxvaE9X8V0Wwh8j
 +C6g==
X-Gm-Message-State: AOJu0YxUsH1bnYAy5rB051xGmuvRhIjZBBclBNwAsWr66APjVpSq6dmz
 xz80WzQkIQldbufbT1wT0YHkNnre5jQcpOXabY2q2oUivWhx9Q7bmszpGIFupnd5tR70K603Nul
 RciQ8J1lPXnRXSZHzzf4No8E0s67KxmSUxN4W0Tnqobf0Tg6w8PYoI+VdgHbWvDoQ2Q==
X-Gm-Gg: AR+sD10l1joWODPES6L+ZuVki0lNYR0wIPwqChnNGM6Tp0ohG6a+w96ykmSbWHwiDhJ
 B92GUj18KKidehd44rom+c4wyMulVj/8wMCxMcjoi0oEW4qPZvIb/qtbH9NsWTkbi0/mByTkuef
 TpwjbfU9P+TDbN0lhxItWi/np2nm3j2H0YtHSmSwusTAM+yE37SpaykweweXOHv7RieqOCFuTZ+
 2vuRD2gAIMP2CSHd4pOdKm+uaMyDp4qOLE+qrK5hjCzi6urAiVeGnFihQiQ2PoSoOn0WAT1xfIu
 PD440qashqo2e+Q4bkljbRMQZ7URepWijuHeD3NFrRzpICEzz1VEDDP9owngNhaSzDJJBT0mzby
 GIUoBMLcJuSvi7jD8uAPVRO39VhcufRkUpY7B3XoUwFdi7hhhXMDb4YkWJQfgwpXHyZR1Dc0=
X-Received: by 2002:a05:6a20:a108:b0:3c4:2f75:719 with SMTP id
 adf61e73a8af0-3c8ba68f129mr1083862637.37.1785214115331; 
 Mon, 27 Jul 2026 21:48:35 -0700 (PDT)
X-Received: by 2002:a05:6a20:a108:b0:3c4:2f75:719 with SMTP id
 adf61e73a8af0-3c8ba68f129mr1083836637.37.1785214114847; 
 Mon, 27 Jul 2026 21:48:34 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13003f12sm103090113c88.2.2026.07.27.21.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:48:34 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 074/103] tests/tcg/ppc64: remove dependency on
 qemu/compiler.h
Date: Mon, 27 Jul 2026 21:42:18 -0700
Message-ID: <20260728044248.137626-75-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX8tbp50kgcZ49
 zFmRty+fhuYd/0tyXnVjLEKqkUI2eMGlPMapok2b/CWYU5Xc4dU56uyKiNCNRdJnRTM7R61V3bO
 mI6eodZuZK8WrFIJddJe1teDBwOhQMq2SlN4FiM77IC4lrz8Tf4GY/Rybvq+OOGgfx6b/H/DtJk
 qUpS//JyUL5DB6DaJcgcJEjBK9o97P3sxzWZviyQMjqPKDAJZAW7xA5HsaQuXSJPHQH9kQRyl5n
 8+Ib5RZ6XF4yUiL67jhmV1uibvoFgp6pXuXYGLlJjpu07p+AgkX1w5cfg4qhgnvSdNplZ+uU1qC
 8VV1xPKmhdeFQo5shZ2mcNCS53qoD28tIEn70mt/PJgZyvr6bJdy/lwnl2j38jKa732l/XBByp5
 TRXmh8z7PALZEDb6lWdDNEHsrYPFTDVJ3fvVCDbK1jqMDNR2MEjfS5xwOqQBS8iLhKcaPjAeoJI
 y13nw8ixzYpqY6nSYFw==
X-Proofpoint-ORIG-GUID: D1tDlfv1DsaMSWpo4YaQRE7bFkLgqxPU
X-Proofpoint-GUID: D1tDlfv1DsaMSWpo4YaQRE7bFkLgqxPU
X-Authority-Analysis: v=2.4 cv=ALkdLnG8 c=1 sm=1 tr=0 ts=6a6834a4 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=UsHlXZ0vMnIq6N_CsqQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX+WB5buPJQonP
 O7FPNsuhkUKU/NwxJJbCRm0Ce7vfmLPTCzpgGo9OkO7x4s4lWLkTdMAGNQd2AgY94xdB/Q35gHs
 V4ocCFQZTv6ewTC/6Y4U+RX2vhwudXg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280041
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


