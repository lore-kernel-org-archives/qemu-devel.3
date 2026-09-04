Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64020C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TQB-0001Zs-QI; Fri, 04 Sep 2026 08:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQA-0001Ya-5s
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:30 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQ7-0000eT-VB
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:29 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49556f97a9dso8384455e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788526406; x=1789131206; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qFmr5jSpF3rNojzP+DzlrO5/yYTA3YpYFFZaBsdxuIk=;
 b=Jn9bZIy1cUAcdH9/nPkK046L3DjIruAa2XK1NaBxZd/EiBwNMySxGmwUmw9vFzDocr
 J+/ocAwkP4Wr6zhaoD+i7R/jMHfNt5BBFzL31yMsD7Pzm0Kr9d0Lehm+qMIYdcMRL9so
 eUhetwxnnVVQLrpsQc7N0Wjewc0pW1xOCsRtx9j79nh2p8aTA0lbcT/0QprUrf/kmgnY
 HDSNfW0meuisCKS+azRo4ZvwE4x1VJXXffWwVi8SfT85Ef7GQg5WQrljcG+XsnwovnE/
 YIvkFdlDHbhP9ZRkpuejleCT5T3HMiniq4tzgMd+flFWpZekyPydgLtvRp5lIc9ZRqJq
 iOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788526406; x=1789131206;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qFmr5jSpF3rNojzP+DzlrO5/yYTA3YpYFFZaBsdxuIk=;
 b=BFxuVuiVWZ2EmABY3GdT0a9fxzSQ5/qVCalvW6K4C7U7JEcx1GYrT/w532ZbCawTsZ
 fLjwDv6MIsTXJlp08bmR+kIJuIyN56bRKREqx0WrHWTEkZZMKNe19yfEzhUIPiMCeJkr
 D0bCa4chfaCFjFW78Y+wjMcVkZpJZChL6I+i0zJum5BUHqEGqntyVfMfwyhR5H1qDNK9
 dR18MReMGLhoWQPZSoqrUYGcEN4RsR9/l/FWrUXjXqAD701BVX67o4jCbSFRpRm8RXfY
 QTxzQ7ro/jUF9eQn1yL1LYi9FBhJ+2qjJpjbKDGj6+4XgRoC5dsm7UL9wfcRoBF91dBs
 xqOQ==
X-Gm-Message-State: AFuF++nYRotxKXru405Ad7wmb6QhSGT7YYOnSPfhxttA4OWV33MWXg/d
 NRu/DLbmSIaUJODxTS7yneCYKplyvOW1gZDWfEXKbTVZNsQVpXa7B748BEipNMLyF48=
X-Gm-Gg: AYBFou1XPOkskGp1Fp2Ss05xFCTB9yK6pT4f3IavPcFQI92tmCkPrFhJZ0sM28iexGB
 QrTr3Lvdh0q7A1LPflQby5ddOod02efbZQ/kaFYO/M9xNItD526rVqRsoUZ53cLDrPmLNmtepEH
 AmhU2bUe+fKlXNvdQFxVP4QSpOQOLztnZ8R1r55qFTowOF4/eoWs/NO/qHaLa0w1og8zjKsHsd+
 cW+L2otId2OHDqXYaEGbxabfv9wLEYvZQ7xcpxENnrTtehnEFq2ZVhLciQJeAKqRbBvsRCBW9KM
 zbTPZ7Vjjbs5FPa3RIHPUTewwSqrqbMNPGGFR1YtxG+bVOjBUUw6PyZxfmd20EDu3Xj7irTSlZY
 NbchXWR+UPSEEiMhLlDDxx9tu04HLq1vbfxJKpkJlwdKFjZaRa/YTbEODG/QhS2fYUiTkqWqyk0
 VIpJ9wjuv397KWc5IqDS7zH8nM0yrxTVghhZ23EQe2OPccdMf4fWjlU/etONAqbdC19wJjvu8=
X-Received: by 2002:a05:600c:3b01:b0:49c:fa21:e73b with SMTP id
 5b1f17b1804b1-49cfa21e86cmr35179125e9.17.1788526406232; 
 Fri, 04 Sep 2026 05:53:26 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7739b7asm64646865e9.13.2026.09.04.05.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:53:23 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5F0F4613A9;
 Fri, 04 Sep 2026 13:46:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs)
Subject: [PULL 075/105] tests/tcg/ppc64: remove dependency on qemu/compiler.h
Date: Fri,  4 Sep 2026 13:45:29 +0100
Message-ID: <20260904124604.2207440-76-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

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
Message-ID: <20260827221506.91574-76-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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


