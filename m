Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B08E6FE2D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 15:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smbDF-0008IJ-1S; Fri, 06 Sep 2024 11:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smbDE-0008Hl-8q
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 11:49:28 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smbDC-0008Av-Jf
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 11:49:28 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a89c8db505bso300447366b.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 08:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725637765; x=1726242565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TW+gKU0Fbu3XeokU7+BEDwC7NasKVljAZ5Retp9xJ60=;
 b=TeaYyO3Fpw34pVk3kE7HRDM8do4Fpwx4UCQ6BJnCIdQtmHZx3eKB/px8GINs5qYGlJ
 5T5puCYFVWgxt3GM0ws+0d/DAqK9C/AVIL5KSncibP5IDNSXU8H0VXa2sLK/U7m2nN/M
 Gh36vhLC3DL7wNogIUXSgIJNwUoYWGRrx0JKB0jdIaQKAocSl4ioWTA4DbJwTsoWoOCU
 SbNfgt+xdclTJWPwaX3HKa647yrmb94p8F5hJvmBN0ZHHLrEl0AEAV/V0gtFrRHCQpX0
 qxlmG2xltLSHfodwHPwm+EuqudvNaIsl9E164ymjHBl9jEyKX4ZxM70daZAyoHdR8NkA
 S4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725637765; x=1726242565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TW+gKU0Fbu3XeokU7+BEDwC7NasKVljAZ5Retp9xJ60=;
 b=PzsLBc5oJHnQt0FVXujXSZ4JJesTg692IDFMPpMrxUjsHaInh4i9/PzqZgCCRXEBvb
 KsAlSWS0/wj7+WzQmf/yXPC2uRTzNroVHnSg60v0kBgmWse4cDKVP9RGJnNGWpkDTqKI
 mHt974fulv6Lk/jk3FtIJqUkgzpxDxh2CS2KZtVrhWU0w0fBX5MVBQOJHRMq0dA3WubB
 kbQVLiyvTiSPl4D7x1afTzsZsfGnqvUpc6FNIKVzCco4KdkOmsP/AOaamqtjRZ4wPBKv
 423IhAq7giJHOYqgs3jpAgjWC31mmrGT8mi0D20qLZPEsR6+juwL4YL+b4Hf/RCsc5SU
 akZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzHHb+DR8bWr3MVLreambaB1sAD08n7/2ufzJwAJstGQwmgaHlyr7E9RPcQgAKmN+3XTlNDUZc9Vpv@nongnu.org
X-Gm-Message-State: AOJu0YxzA8yuVbpJZ7dVvoeFToERa1Eel/3YpHyc9XdHFo526hZVEGZd
 n15Iwz+YMtDLjsfgCxaKN4NruAhUD4hGQqhG1JbjtScOyrrkG/R+51aQu8aUmNs=
X-Google-Smtp-Source: AGHT+IFPi+PTmBJ7SaTs/2nCAPb+g9c7BE2U7m/FoWHk1FKsOLdzg5NQYi+r0LLwFwPggXNGMo1dWQ==
X-Received: by 2002:a17:907:ea4:b0:a86:99e9:ffa1 with SMTP id
 a640c23a62f3a-a8a888f11a7mr237329666b.64.1725637764786; 
 Fri, 06 Sep 2024 08:49:24 -0700 (PDT)
Received: from localhost.localdomain (225.13.23.93.rev.sfr.net. [93.23.13.225])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a6236d16fsm292217866b.99.2024.09.06.08.49.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Sep 2024 08:49:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 2/5] hw/sensor/tmp105: Use registerfields API
Date: Fri,  6 Sep 2024 17:49:08 +0200
Message-ID: <20240906154911.86803-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906154911.86803-1-philmd@linaro.org>
References: <20240906154911.86803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


