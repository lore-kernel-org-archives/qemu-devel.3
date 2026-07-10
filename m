Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7310AC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4gv-0001u0-08; Fri, 10 Jul 2026 02:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4gt-0001pd-OM
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:26:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4gs-000640-2I
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:26:27 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3n7g23661843
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WUVWrs/POnUdy5koxbqAG2WnkanMpt9AwC18uUHtiuw=; b=XDOLth3RWQ/rU54h
 kZavxwjX/ZqibHy30vOSpaSYQyJOzg7kXbGNgiUlC+y68lrUV4xpZQVtFCDhgpTX
 2kPMwLNhS3NdzMOxHWaUOtIlqFokZ6RXvwCPIzwjHHcZFAJKwPhn3B3lESRRZMHR
 /xvpa8RcRoUx4f9OajKVkWf3DFbSGE2inEVWf03OcJVLlX5LjZ5wNZ/+7wnMaQ1g
 uAmOUEC+5EGA/DWIUGV93NfHfs+FGOHubXvlU9v2myuJJFIn5HPJq+D4eQNvRwjm
 KD97OyVFDqBkjLq4i/cox5akWY4hRrCwIlmgDDSTPdmWudzZk2st2AhW6gUraWhA
 MRRXwQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf24twu0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:26:15 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c9c26587e67so642975a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664774; x=1784269574; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WUVWrs/POnUdy5koxbqAG2WnkanMpt9AwC18uUHtiuw=;
 b=PC7FtLptubbM74h+YsS5TvdLbyLVkpxvI8BjTMbgrw3n+tMCfxFxDyN9rfdS+fHaE7
 E7Q00UJJn3vtETlzAFPieH4ykAIUf7gZGohVludHvNdys/O75wGTYw9ydo+lWHpiqh5m
 kgCvRP47Xjkc2bnRd/uy+XdHoU0HRGD4LJk6lYvRIY3N0XBWXQ2y1vy8sJdN9yYkox8k
 hrw6n6JVAUmT4fM7ZShLO5q0SaQ4TEgIaWOkV18iF8ydpMeQdHoDRFvTIElR9q+deuKJ
 8h4KOtG1LhCB8z2F8ovYLGMffVuvkrW+naiGEmqn8pajKs/OBt5sFl3dxLvzvlO5LuyM
 WzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664774; x=1784269574;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WUVWrs/POnUdy5koxbqAG2WnkanMpt9AwC18uUHtiuw=;
 b=FrmW443p5kBLTcrit1XWuWyx3TCER3Chm+dezzZzj/jdJcz1JxNOyc1YcfwBsqmmpS
 /E70JUkBsrkIuFued6qyCF8LLchNkZ2RvR+XPr8+KQffZ/DMsEzIBaxJPze7u7XzSAXp
 B1UMg/H0EEUl7LL2xwxGtMlokawPqIG8v9J7Jjt7BejaxbssEOvSKF2bcDdxfu+vwf4q
 yd7fFrpFTJdGUTlBT67SMrqpl4G8CNEuElT4zVSME79YboCZSqJzbiHvEX/6TSazoy4r
 W3jjvjtP1iCnuC4NWb12BQ9nkOvn5cxhKL4okRP6NMfpN6pgLLvR4YdUEq0gw8PS6F54
 k2Hg==
X-Gm-Message-State: AOJu0YyToeNFw37YskKTxc+Xllom+Zl5mabpry1pZilzFfv4OvS2+Rvd
 NwP6b4NQyY9GoGjZkpU9z847veGSi/QhBT8GdZm6IazjP2QONv4zUutmROMdAnJAFA6ISqLYmv6
 QDs32MuG+D6jZZO2yXc4pSTXZboJ9ApgiDpqxBxEuJXlkuEKCdXV1jcZqoS380sWdTw==
X-Gm-Gg: AfdE7cnEVg5RZz3oAtGwzUUXn9/9L+fm9jDXM0pYLwkIi83+sRmlYRVF6ubw+03hI1i
 VYltYdkJWcL3tdbi5mL84ZhhL8dLAP7YRDO5B4WUMcUkGuOF9YUPnKTBRDeXFnyEXaulJzO4MyY
 gjgI4fuaX8p8O81UPelKQkSTiSvv+EyLXQ0yogw5v/fNNT65ybqGR+MfZqbqsvaI+3Jjk0lxu1T
 rD3wPhGR56cpD62xrWcz0YrJ+gm63smljAMprrpq/dNNmal9KuaDhXj0Zsn0gkDDRTF9I2TDIPm
 0Pk1khph6On++iD4gTGchPp9EpbG4811yDMzZCDjPKAG+Z2ilQ1QMtTMSOmzt7E3QeAyFBxS+cI
 NxX6B+cC14jxUgi2Sj91b9P3BjITud1BmE/VEvyeZFPJvJBAoxYFMesIAW+luoMch0lAmBjmjmW
 aVrfGeZg==
X-Received: by 2002:a05:6a20:d4c:b0:3b4:8c67:51d4 with SMTP id
 adf61e73a8af0-3c0f0c4bf32mr2846130637.39.1783664774091; 
 Thu, 09 Jul 2026 23:26:14 -0700 (PDT)
X-Received: by 2002:a05:6a20:d4c:b0:3b4:8c67:51d4 with SMTP id
 adf61e73a8af0-3c0f0c4bf32mr2846102637.39.1783664773574; 
 Thu, 09 Jul 2026 23:26:13 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b6593c4ddsm40606060c88.1.2026.07.09.23.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:26:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 72/97] tests/tcg/ppc64: remove dependency on qemu/compiler.h
Date: Thu,  9 Jul 2026 23:19:50 -0700
Message-ID: <20260710062016.1818125-73-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Bown5784OM-QkAFl3voIaQ8is6vS6tj-
X-Proofpoint-ORIG-GUID: Bown5784OM-QkAFl3voIaQ8is6vS6tj-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfXwRUNP5Xj31jM
 1Os1qxrHB0gczKcYQZ+ZJw/CkY3lxwzQihnJ2G4bMMcbubFpAre8aNdgoxRTL6v0xDPKEnHN779
 57MSQvrg6xzNhXYlCPoNZNCQgrPDUxk=
X-Authority-Analysis: v=2.4 cv=daKwG3Xe c=1 sm=1 tr=0 ts=6a509087 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=UsHlXZ0vMnIq6N_CsqQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX4pu8Nkcocx52
 fwRdp33o1oy+bpDqJlE4WoizoUWZ7tSoSBfziZ3VN8/Yvbpuk1NvgSBvTmXvRpzh4cWbA79FgCM
 3xRdLCxzpa1+I4HGOR1/Lmrx3vuDZqEG6I+0TqU4W9GwDAskwFCWWiCnPx0mVYckGlVOxJBm/gK
 8SXePty56f/97/SIkYzTxF5grVYrO1AfcbVykYWjTJiZBQK51G7IAPp1M+NxSdOoCTSYKrXJmsQ
 mgSHiczPA1bwPOMjUBIjMLwsP+rIP0/KIkYVr0gwT1Vpl4dOIW8uMp2rnx8/KGLnjbQ/y17Nep1
 bPYFixGiF0AodPJbXJzgOHt2eri82dGqF0OSXNSI6O/F1W7d/JAg5cXhBgNa4cu6U4Xbrrrjkrn
 83uTNnyrMp8CzMrQm8OoAJ6tjC68HjW45rNiWKxWs5PNBeBz5gCw3BBFeMCUp0VKsA0P9mrO/xc
 IVtQSgx3AZflFobBFYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100059
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


