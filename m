Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EE3C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:31:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPUf-0001G5-7h; Tue, 18 Aug 2026 15:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPUd-0001Ao-Gd
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:29:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPUb-0007d9-Kw
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:29:03 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHH6ms3003316
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:28:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 v10mKXwu+nKBetXxCTpDguNMbWArrru1Gn4U3yP/OY8=; b=fWvKh6ss0Dh6fjwk
 zrmKsBMY/HfJcTY8v3vgERSmgQtE5PsTmGnKWg4C1vJpOG+iPY0bV0Cj4ET43EcC
 xUuKt/tYFlR2hUSGa7+6T6jMbWU/H+I7WBpcR6TH+8E6aeDW1tL1pTK/gQN04zjF
 1PJT0CdgC5PNZOSymahBirHNrI/9ZWh8jR62Pjf1mH8O0IbTfGkjii65u+n4GL9X
 N0j1HO/dkiwvmHFLbSIXTs+/2gdVLi8c0JN1Qdhs+SHg1cfUjM6Vqp0c4UxaFkHQ
 SX9K9mwSvHiKNmZjQAmPC8rPibnAYPVzwtWBT9/sCTGtN7V2/TwZPYb265YbautJ
 +90d9w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4frmv43u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:28:49 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3954def0191so403994a91.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081329; x=1787686129; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v10mKXwu+nKBetXxCTpDguNMbWArrru1Gn4U3yP/OY8=;
 b=dIqwWdfqIP/vaj7A8filryrWEp2dq6rdn4oJwArXuqiTXpuhHXQvi/LfNYrgiQLyxq
 gXrebEsFg7ruNsxEE/EcHTA/w6l5GzuQeBXOQKvZ8frO1PLswJeQ+j3NQTjOdJcnT2BT
 hVHVhDHb/k4Ay5CX7JxEJQ43A6E9ycx+5M88KDDrWmL4tY+Ro50sZxwRZk3yCIep2P7+
 GVKgXCknaTgc9e/xuRsVE5eUvQOA+SUljkc+2h5PS6jX7wtiMfnl/sWpSrO7icptimlM
 c3q3La5bgS1Iecf52uQ9dCBg+VvKCQ8ZsVbI/pcsMc3SuCODFtfqHpQ51WpEiDEvZ+W2
 m77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081329; x=1787686129;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v10mKXwu+nKBetXxCTpDguNMbWArrru1Gn4U3yP/OY8=;
 b=j5IlggVagahM58T6E6y96d8JKj6VsnX0wKKuTXe5PHMaaweqcbwWXHDcBDPega6q9e
 eWsHTMG0HmixC214g3udYnPAUUV1tWOq/MfYblOde8LC2uNjAsWm76dXHA+NHieq3+hB
 tuBzTF8+U20ipGjnGLMeVNUNYGP66cbNL9/8sv+A+FU4nPDNZWEE6Wa3pakPuOyILWr4
 z9Rdd7tL9d2RTmhmziJi1t87QK0yAhLwEqJC6s8UtWj3bUD34cZ6yaX3PtbpWx303oE2
 gchj211s36uw8gyUyVlGSTYcGy5863nwQj/dtKrfh4BbrHF9w6ELl/0jdIKU1/es+FUz
 g8jA==
X-Gm-Message-State: AOJu0YyiS6E8qH47ldg9fTfIF209I4uV6FBWphJscd3XluSq0V4hbwxL
 6qKLKhCz7vdOA/YwLa/DBZTCWHi4GjYyLfYYdM2DOg3qaPeFN4xz/seOUEhxCH3o0cBwoLsKvL0
 sNJroDzeUKBA8p0o6pG/MrI5GirA2xA8KWx/awj4WGKpvtctPJbJEPt52EjQX5OeSSQ==
X-Gm-Gg: AR+sD10SeQgjvwd5B1AraYNvmJeLcuJuPhiCjohsl7+WFybilpDUhn1uyDQE0c4WgU2
 HfDL8xN+p8oUQOTysxUN0WYFtUpLUsZNcEaqY4SzFGPWhoo9Gmst4tGg9127VamfN0ds8nbyFs0
 n9etw7qm1nqcY25W0FhP9/DFIhfqIPuV7tCZoLo/AqqfMbtAF8X7nR5dogwfbwWFW6nc84HAH2w
 CACAOhJus/PNnrt2fbWwl1FNJ1rJttqjCkovHGIdcgzdOJKXqfkrh+OW/gC6+sHMQ9hQqhpbQP+
 xVgo81ITg4VJ06+8MTaxnZW2HNsHOzSzZd14m6F9rAPB36qfwqIZllikj6i3hrJfU+GAZM2i8dS
 QT/hSMywzic5NuyBsi1smZDVmQ3gXrxDIAKTMJcRE2lgr5tCPhhmrQULCbVw=
X-Received: by 2002:a17:90b:1c03:b0:381:152b:d596 with SMTP id
 98e67ed59e1d1-3957b2c98c3mr92158a91.11.1787081328778; 
 Tue, 18 Aug 2026 12:28:48 -0700 (PDT)
X-Received: by 2002:a17:90b:1c03:b0:381:152b:d596 with SMTP id
 98e67ed59e1d1-3957b2c98c3mr92088a91.11.1787081328374; 
 Tue, 18 Aug 2026 12:28:48 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326794c0c94sm36782451eec.9.2026.08.18.12.28.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:28:47 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 075/104] tests/tcg/ppc64: remove dependency on
 qemu/compiler.h
Date: Tue, 18 Aug 2026 19:22:39 +0000
Message-ID: <20260818192309.22169-76-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX5jN2Z+8VHCR3
 8lkrSJaI46oxEx9v8LCcXwiM82WVxQ9x/xzmIsdIhN5hwDY/rKEHGabpZpAUNaOSYp0QfPHX6pA
 Jt6Pt7mmNQ1sUhrWA+4W5Kh/ThrTpQmJ98q2VviYZ5HaCwJghbtaQ9kyQDp/Y4J9nXPdVRClpaQ
 GlyKMXEf43uGg0a5V/BTX6JYQv3TjtRj5UCd/BDXSZIiRgezp6VW64GWq730HNZ2uIrBsobNbKr
 udi3Nesrlkdj/lL6LoDCBC8a3QUPxYYPazWlRaTJGiKvtslNF1RKuzZrdxbSWHv6ucuxvc33XDU
 tgctiA8TKhb7HUPf3dEDo8iiBzbLRKnp2HQGI3vdQhyHhPemcJk2IZFm2z4vhW2nJWNzqpsY45f
 yIxb0a9n7M+avVXyTBdS0zRIblBOjFRTA07o+7QaVCi5J3s3Jn2l8WLISv757aYhczEGQQTu86J
 8ZkUH0o0NHXeAZNt/9g==
X-Proofpoint-GUID: BCkwfa9_l5YAOC2_i_CQe_-cFlfaekKg
X-Proofpoint-ORIG-GUID: BCkwfa9_l5YAOC2_i_CQe_-cFlfaekKg
X-Authority-Analysis: v=2.4 cv=GtlyPE1C c=1 sm=1 tr=0 ts=6a84b271 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=UsHlXZ0vMnIq6N_CsqQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX+i/MTINQsdd9
 97EpxQFvIKqWkfekJWd3EKfACoQdOLQsbUAO2o0fk2Ys3ZQonq9hUKUThzxis5GDzr8INMOfXVQ
 jYLLPL10pNCfJEInaajfGNTW6iMQYzo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
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
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
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
2.43.0


