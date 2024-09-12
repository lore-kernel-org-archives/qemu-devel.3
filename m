Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE89EE6451
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 06:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sodhA-00047S-M3; Thu, 12 Sep 2024 02:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sodh8-00046Z-Uc
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:52:47 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sodh6-0003Pz-J3
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:52:46 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42cb0f28bfbso4675265e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 23:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726123963; x=1726728763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Botq1S9eMbImFvY+BTnSLblpWc6KEMCJ0flPbOePxcU=;
 b=ITyET9NG1v9LS/5ZY7GOKpj7YqwZoB9F+ijElH/w3l9vtJDT4fn8Veg3p2A6B0fBqI
 9MFvQgZ1DPFuuY99QscwjYwjy1oc7JH4FY5cbTgc6ykSWAjBVVGlU63YvW3byrFb9lo1
 WTyabpuIsufL7pzSYLRaqHRXQwu0oP3f9RjH6LspV7tSPrnIReLuADzZ+f/mvKSeB5Ig
 /5+F5g9NTHDiEiWLMM19Gkc8x9YL1Pn/ERHtxLxY5d1ohqLeWSnDWUJtXCd6bNzElRDY
 U5dE3fj+XUTuqOdKyQz4bJ+vwLb8YZWu4rqd60ll3ft9t41Lo8KyQeg+KCSjp4l22XTb
 r5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726123963; x=1726728763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Botq1S9eMbImFvY+BTnSLblpWc6KEMCJ0flPbOePxcU=;
 b=oEmrAvWzy0NawNYMwrpiS9u+PdC9SA/z9u0Ryf3rv3BUIsNr7z5JEPbzPxnp9w/ete
 BjGKQveAGA6Evj/jKEbDFpkxCiPV/r3/EhzP+CUWnUh5c/WKGOjvGXuYGGhfVsnA185q
 LT0O5YiGkkCAd1Lo0cPl3N9/G5O6qB857vSolzUk7hkq6PocniwK/hMLFOQfBUmy1vt4
 iC/+3gHFGgqqilBSArD1jmEo3g4M1N7BlFJ/cQ/xAswwKIqcOAmlGj7oYpsvsGQzGF9N
 00Y5H5eq044KaZmB+q5ER+ldPpGX5HV/bR6LA4cI6rJvEq+ehyKqrKVcn9dBtSeNxzms
 OE2A==
X-Gm-Message-State: AOJu0YwU7SB16plYLhOF5K9zjf1N+UVN+hNi1BlwtYGZehJ23aU4Lh18
 y/5L0fj+tzcJGVmWpXYtmc/C2duPVdywCM66c8aIOsz6BrA/K9lhKtB99ylzpbSPT3yP/CS311Q
 c
X-Google-Smtp-Source: AGHT+IHRQwKC2UekPFyHaijhqQBIk/3zbj2uJ4HN28LWHW4ZhKqw2CfX1qJEisa4O6F2p1XWtY96Ag==
X-Received: by 2002:a05:600c:4e10:b0:42b:a9b4:3f59 with SMTP id
 5b1f17b1804b1-42cdb529b15mr13640265e9.14.1726123962664; 
 Wed, 11 Sep 2024 23:52:42 -0700 (PDT)
Received: from m1x-phil.lan (mic92-h03-176-184-33-210.dsl.sta.abo.bbox.fr.
 [176.184.33.210]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956d363asm13523896f8f.72.2024.09.11.23.52.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 23:52:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 45/61] hw/sensor/tmp105: Use registerfields API
Date: Thu, 12 Sep 2024 08:52:16 +0200
Message-ID: <20240912065227.67848-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240912065227.67848-1-philmd@linaro.org>
References: <20240912065227.67848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

To improve readability, use the registerfields API.
Define the register bits with FIELD(), and use the
FIELD_EX8() and FIELD_DP8() macros. Remove the
abbreviations in comments.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Message-Id: <20240906154911.86803-3-philmd@linaro.org>
---
 hw/sensor/tmp105.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
index ad97c9684c..150d09b278 100644
--- a/hw/sensor/tmp105.c
+++ b/hw/sensor/tmp105.c
@@ -26,23 +26,31 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qemu/module.h"
+#include "hw/registerfields.h"
+
+FIELD(CONFIG, SHUTDOWN_MODE,        0, 1)
+FIELD(CONFIG, THERMOSTAT_MODE,      1, 1)
+FIELD(CONFIG, POLARITY,             2, 1)
+FIELD(CONFIG, FAULT_QUEUE,          3, 2)
+FIELD(CONFIG, CONVERTER_RESOLUTION, 5, 2)
+FIELD(CONFIG, ONE_SHOT,             7, 1)
 
 static void tmp105_interrupt_update(TMP105State *s)
 {
-    qemu_set_irq(s->pin, s->alarm ^ ((~s->config >> 2) & 1));   /* POL */
+    qemu_set_irq(s->pin, s->alarm ^ FIELD_EX8(~s->config, CONFIG, POLARITY));
 }
 
 static void tmp105_alarm_update(TMP105State *s)
 {
-    if ((s->config >> 0) & 1) {                                 /* SD */
-        if ((s->config >> 7) & 1) {                             /* OS */
-            s->config &= ~(1 << 7);                             /* OS */
+    if (FIELD_EX8(s->config, CONFIG, SHUTDOWN_MODE)) {
+        if (FIELD_EX8(s->config, CONFIG, ONE_SHOT)) {
+            s->config = FIELD_DP8(s->config, CONFIG, ONE_SHOT, 0);
         } else {
             return;
         }
     }
 
-    if (s->config >> 1 & 1) {
+    if (FIELD_EX8(s->config, CONFIG, THERMOSTAT_MODE)) {
         /*
          * TM == 1 : Interrupt mode. We signal Alert when the
          * temperature rises above T_high, and expect the guest to clear
@@ -120,7 +128,7 @@ static void tmp105_read(TMP105State *s)
 {
     s->len = 0;
 
-    if ((s->config >> 1) & 1) {                                 /* TM */
+    if (FIELD_EX8(s->config, CONFIG, THERMOSTAT_MODE)) {
         s->alarm = 0;
         tmp105_interrupt_update(s);
     }
@@ -129,7 +137,7 @@ static void tmp105_read(TMP105State *s)
     case TMP105_REG_TEMPERATURE:
         s->buf[s->len++] = (((uint16_t) s->temperature) >> 8);
         s->buf[s->len++] = (((uint16_t) s->temperature) >> 0) &
-                (0xf0 << ((~s->config >> 5) & 3));              /* R */
+                (0xf0 << (FIELD_EX8(~s->config, CONFIG, CONVERTER_RESOLUTION)));
         break;
 
     case TMP105_REG_CONFIG:
@@ -155,11 +163,11 @@ static void tmp105_write(TMP105State *s)
         break;
 
     case TMP105_REG_CONFIG:
-        if (s->buf[0] & ~s->config & (1 << 0)) {                /* SD */
+        if (FIELD_EX8(s->buf[0] & ~s->config, CONFIG, SHUTDOWN_MODE)) {
             printf("%s: TMP105 shutdown\n", __func__);
         }
         s->config = s->buf[0];
-        s->faults = tmp105_faultq[(s->config >> 3) & 3];        /* F */
+        s->faults = tmp105_faultq[FIELD_EX8(s->config, CONFIG, FAULT_QUEUE)];
         tmp105_alarm_update(s);
         break;
 
@@ -219,7 +227,7 @@ static int tmp105_post_load(void *opaque, int version_id)
 {
     TMP105State *s = opaque;
 
-    s->faults = tmp105_faultq[(s->config >> 3) & 3];            /* F */
+    s->faults = tmp105_faultq[FIELD_EX8(s->config, CONFIG, FAULT_QUEUE)];
 
     tmp105_interrupt_update(s);
     return 0;
@@ -277,7 +285,7 @@ static void tmp105_reset(I2CSlave *i2c)
     s->temperature = 0;
     s->pointer = 0;
     s->config = 0;
-    s->faults = tmp105_faultq[(s->config >> 3) & 3];
+    s->faults = tmp105_faultq[FIELD_EX8(s->config, CONFIG, FAULT_QUEUE)];
     s->alarm = 0;
     s->detect_falling = false;
 
-- 
2.45.2


