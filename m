Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD6E8C67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 10:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsglX-0006CK-EQ; Fri, 05 Apr 2024 06:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsglP-00068s-Lw
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:41 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsglO-0004p9-42
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:39 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1e0878b76f3so17015955ad.0
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 03:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712312737; x=1712917537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+fs9+k40tx7u0ZrnNCGjYa07BmQdJ80BwtuGhh0yXh4=;
 b=FEnvx95AgCnbF+lWRAS68tf76Bpo9uTrgrUyqP+S83Xm4AQ3lJCgevvZ/WRm8GjUDe
 4lf4XjxoKYo1HcnI3la+uBBrJ5z4LDYRqiUopLXZ6OJotsgkMjl1H/9hZAGLjD0iDUmv
 McnM+1u2ej00HM7Q/qsbWy1suHgoiAxpgRxdwUcsWXbEvu/QjUHZdC+s5crgBLrRFPCY
 Dv7tfiB02OExGkunS0zVJnuAOadUTBzP+LnqEM+M3h7QvGLYkadXR1cS6yemEJAUho3y
 fbvJZja4j1mrY7/+EKSDvLzGLgq7m7rhkO0fvvwz5snG/hl5revXtMZ0A98/3spZ8R3L
 y6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712312737; x=1712917537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+fs9+k40tx7u0ZrnNCGjYa07BmQdJ80BwtuGhh0yXh4=;
 b=r+0S3hQDeoM01hBWgY334jRV1MlSbU+/nlNgI80i0E1pv+qD6nSVuG/Cj0eZnpJjV1
 dqydB4cm69PvzJGzim/GSq8k6rbzBCU3W0UlhfqHyrCtmA513n85bwvEebJ6cjDHiDGx
 VP/OBWT/SgKZObFBbjbMK7t/1paclUeHwsbFa1gdq2hPlbAmmPN+ppv7ivlKQLNTdBv0
 EscR/xwWxX7YJRSO5NU7aNSeO8gAFORY7HLxziIxbDwUfdfAyfCBLsMKGpP/py38XDLp
 097ZfufDyj68OmhfLflFZSoHHVw/w9FBkI6e9X38hqaWTkWPvHio4CfRkJN+HewE2N8Y
 t7KA==
X-Gm-Message-State: AOJu0YzUdLbV+34qYb37HRdT7LaeASKgRIFgxu6eLfjUUqquYEE+m+0c
 vDLOQXS+HNx+2gEJ1PCOt6yibCkN+Y2qjPBuJQUK8NO2NK/eNaz9dF4wAfvx9u3+m/Tkht2F60h
 Y
X-Google-Smtp-Source: AGHT+IHZI/XmTfUfpvsS0r4q/IS0d86tFk9MiJ635TY3Xb0B3el2+53xO+o2sWTFUrJT5ALCvde+9Q==
X-Received: by 2002:a17:902:ce90:b0:1e3:c327:35e4 with SMTP id
 f16-20020a170902ce9000b001e3c32735e4mr1696611plg.5.1712312736873; 
 Fri, 05 Apr 2024 03:25:36 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a63f90a000000b005e438fe702dsm1104304pgi.65.2024.04.05.03.25.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 03:25:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH 27/32] target/cris: Use translator_ld* in cris_fetch
Date: Fri,  5 Apr 2024 00:24:54 -1000
Message-Id: <20240405102459.462551-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405102459.462551-1-richard.henderson@linaro.org>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/cris/translate.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/target/cris/translate.c b/target/cris/translate.c
index b5410189d4..bb2d6612ba 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -222,37 +222,28 @@ static int sign_extend(unsigned int val, unsigned int width)
 }
 
 static int cris_fetch(CPUCRISState *env, DisasContext *dc, uint32_t addr,
-              unsigned int size, unsigned int sign)
+                      unsigned int size, bool sign)
 {
     int r;
 
     switch (size) {
     case 4:
-    {
-        r = cpu_ldl_code(env, addr);
+        r = translator_ldl(env, &dc->base, addr);
         break;
-    }
     case 2:
-    {
+        r = translator_lduw(env, &dc->base, addr);
         if (sign) {
-            r = cpu_ldsw_code(env, addr);
-        } else {
-            r = cpu_lduw_code(env, addr);
+            r = (int16_t)r;
         }
         break;
-    }
     case 1:
-    {
+        r = translator_ldub(env, &dc->base, addr);
         if (sign) {
-            r = cpu_ldsb_code(env, addr);
-        } else {
-            r = cpu_ldub_code(env, addr);
+            r = (int8_t)r;
         }
         break;
-    }
     default:
-        cpu_abort(CPU(dc->cpu), "Invalid fetch size %d\n", size);
-        break;
+        g_assert_not_reached();
     }
     return r;
 }
@@ -2868,7 +2859,7 @@ static unsigned int crisv32_decoder(CPUCRISState *env, DisasContext *dc)
     int i;
 
     /* Load a halfword onto the instruction register.  */
-        dc->ir = cris_fetch(env, dc, dc->pc, 2, 0);
+    dc->ir = cris_fetch(env, dc, dc->pc, 2, 0);
 
     /* Now decode it.  */
     dc->opcode   = EXTRACT_FIELD(dc->ir, 4, 11);
-- 
2.34.1


