Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E04CC5DF87
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNCl-0007VQ-ID; Tue, 18 Aug 2026 13:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCk-0007V5-B0
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:26 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCi-0004o9-T9
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:26 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-ca00f126b7eso10048a12.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072543; x=1787677343; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AqfSwhFQ5ZXhK2egjzylQrSHloLAK+d258nL1VsL+MU=;
 b=YxYaf6PwqbpY8L8KXwOJNdg+3dRX5Y4FjN1bNIjAgMOwMlFkiChUzHp5CbxWjWNH9K
 5B720o+C/6Dv8uH2yJE164h1pfI6m3goyTP57kKrjHSKM0z5PkJHkvsdmsgz9arbw3s5
 66n+bCfE2WmT+QDNC+ZdlylU7q2ohDvzHwL7ZouCz2T1qoI7RoT+Y6UriEhPbVuNc0+8
 nnQA/34cto/mkQNsYB9zQ5ffknoyi2K/cFeOWDZAKpQumAl/k/Pu1y9plKdoo4c+OkwR
 ADIgfHLn1eg3eULViqpjqUZATZMPzrisBbQemguEBYIB4f11FgJYur/DKhHVWl88zZrH
 H0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072543; x=1787677343;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AqfSwhFQ5ZXhK2egjzylQrSHloLAK+d258nL1VsL+MU=;
 b=R+yMr7CRzc7zsckB45WRAPmE+grTAqoNH5xuRqc9+kvPH3qnOljdbN2Xb3qAAYTQJz
 KNiAUr0/6Huq0ZO1cR19z5+aNkGLss52+HdYqVuTPIYhtTTxsMK6FTxU4D/3ZiphA/75
 Rd1CEHacF+3BjMBF+X0/Bi56fjVY53ivuvMKoILzBjq7z7iFlBy4owb56woBdO9WR03o
 mznwTuKGYoRUXGk8hQKIbsxJLgTzHQMwuh1WGh49qoM9m9TvXiHFsHZigswPhZHqnK1p
 z5Rr+dyfP/4FomrE6plHk2wAkukV0Y0Qcw8OgtXuEDvdVrKNWvPbvSrMByQ3wCYrQSrf
 sddQ==
X-Gm-Message-State: AOJu0YxNx3dAm9Aqq23jzyTYFLtJfAF6DXH7kzGPkRpTSVYp40VamoEf
 xgOSSJI903tacS3+GRZ/yqHkZWRjyOaPK34dHnB0+pVDhz7C6ZkSpCAcBPcgALE5ZG+H1YVsGtN
 UN5rAxjw=
X-Gm-Gg: AR+sD12pBxC7KFlTx/DCRFF+dZRizlkaDzTSs+gemBbKWtL2D00SCTCuIJW2OSDtw7L
 +irh/QFpxQLBaR2LulX84dnXnvqvruGr1GEv4eXUb27F7FXDuAlFO3681tTkO3teJgJJu9tWUxw
 AIES8r2NybL/xmPJfHYo0CXDZodgQF13cwNc60lQRtakegOLbtiJeCvqJ0Bq+kox027GBzU6GIO
 wlbIYO/s7w0fTf2PrORma/HWXE4Q84adWGkuijHACmsURbLH8tUAOmYIVCfl0IIcvd0WiP5X532
 nmPGeoPxw42rMiWwoyYPF3JmwRyqe5CO1ywbTGKdQKbfrvRLjkL2bOZIrpIvacyDvWojCvZkBxC
 9BzU8lJl7SoeJhcnbMNv4Rc/x/S8oMD8E08wvvoONhr2EVaepWhQNJKpJhpfu8jfKU4Dw2eRZj5
 td1BSbTRCz1h5U+6Asvy8j9iGaQRPDTCmlfh9kaSmhBshw3uPFVSWZJ6KDJBTj258r6Tdo19O9J
 3OjbkkJurahELsS2/WCOvb7e1P4dRIr2K0=
X-Received: by 2002:a05:6a00:2383:b0:84e:89a:b8ec with SMTP id
 d2e1a72fcca58-84fde3d4d3emr33939674b3a.11.1787072543252; 
 Tue, 18 Aug 2026 10:02:23 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:02:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 21/38] tests/tcg/loongarch64: Tidy test_bit.c
Date: Tue, 18 Aug 2026 10:01:38 -0700
Message-ID: <20260818170155.1907006-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Use one macro for all test templates.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/loongarch64/test_bit.c | 69 +++++++-------------------------
 1 file changed, 15 insertions(+), 54 deletions(-)

diff --git a/tests/tcg/loongarch64/test_bit.c b/tests/tcg/loongarch64/test_bit.c
index a6d9904909..69b2eaac78 100644
--- a/tests/tcg/loongarch64/test_bit.c
+++ b/tests/tcg/loongarch64/test_bit.c
@@ -2,62 +2,23 @@
 #include <inttypes.h>
 
 #define ARRAY_SIZE(X) (sizeof(X) / sizeof(*(X)))
-#define TEST_CLO(N)                                     \
-static uint64_t test_clo_##N(uint64_t rj)               \
-{                                                       \
-    uint64_t rd = 0;                                    \
-                                                        \
-    asm volatile("clo."#N" %0, %1\n\t"                  \
-                 : "=r"(rd)                             \
-                 : "r"(rj)                              \
-                 : );                                   \
-    return rd;                                          \
+
+#define TEST(C, I)                                       \
+static uint64_t test_##C(uint64_t rj)                    \
+{                                                        \
+    uint64_t rd;                                         \
+    asm volatile(I " %0, %1\n\t" : "=r"(rd) : "r"(rj));  \
+    return rd;                                           \
 }
 
-#define TEST_CLZ(N)                                     \
-static uint64_t test_clz_##N(uint64_t rj)               \
-{                                                       \
-    uint64_t rd = 0;                                    \
-                                                        \
-    asm volatile("clz."#N" %0, %1\n\t"                  \
-                 : "=r"(rd)                             \
-                 : "r"(rj)                              \
-                 : );                                   \
-    return rd;                                          \
-}
-
-#define TEST_CTO(N)                                     \
-static uint64_t test_cto_##N(uint64_t rj)               \
-{                                                       \
-    uint64_t rd = 0;                                    \
-                                                        \
-    asm volatile("cto."#N" %0, %1\n\t"                  \
-                 : "=r"(rd)                             \
-                 : "r"(rj)                              \
-                 : );                                   \
-    return rd;                                          \
-}
-
-#define TEST_CTZ(N)                                     \
-static uint64_t test_ctz_##N(uint64_t rj)               \
-{                                                       \
-    uint64_t rd = 0;                                    \
-                                                        \
-    asm volatile("ctz."#N" %0, %1\n\t"                  \
-                 : "=r"(rd)                             \
-                 : "r"(rj)                              \
-                 : );                                   \
-    return rd;                                          \
-}
-
-TEST_CLO(w)
-TEST_CLO(d)
-TEST_CLZ(w)
-TEST_CLZ(d)
-TEST_CTO(w)
-TEST_CTO(d)
-TEST_CTZ(w)
-TEST_CTZ(d)
+TEST(clo_w, "clo.w")
+TEST(clo_d, "clo.d")
+TEST(clz_w, "clz.w")
+TEST(clz_d, "clz.d")
+TEST(cto_w, "cto.w")
+TEST(cto_d, "cto.d")
+TEST(ctz_w, "ctz.w")
+TEST(ctz_d, "ctz.d")
 
 struct vector {
     uint64_t (*func)(uint64_t);
-- 
2.43.0


