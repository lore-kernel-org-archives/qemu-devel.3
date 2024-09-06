Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3120CE7B10
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 13:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smZ1l-0003rl-4x; Fri, 06 Sep 2024 09:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1smZ1f-0003eQ-7S
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:29:23 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1smZ1d-0008NI-4c
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:29:22 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-718d6ad6050so562897b3a.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 06:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725629359; x=1726234159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SYphLTmWYoD1OpVt2MG2OURnM5QTnUzwhzadnnyJCxk=;
 b=KyUlsfwYzJybqf7C8KLyNYayFIQmdZMdzgKWQpmXSwgQUc9v+AUiwoIg1OleeF5brp
 lsffrX8LqIFDoEFhcKZvYlAN2DYVH5gzbfTW6+PsESMzD0a2Ws/xaNV2owQUNUHv0puY
 zxwebX2P+MJlfjhmaMy+DlLsYm9BjXx1eccNsLnp9zaYG63LNQz1eLPxFtrk2y5cnQca
 UVL2blJJAUN1TUpaJVEuYMhjJKA0b5QV49Idi0tOD85/MHOorClqaMhpYBOScxfkEtP1
 T49/4ggOWI2VYVdWXCAgmX4Vh08JbNkYWTjK6O0vpdPE7G68v20A+Mw17bgo6wPU6R++
 5vYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725629359; x=1726234159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SYphLTmWYoD1OpVt2MG2OURnM5QTnUzwhzadnnyJCxk=;
 b=XcsM50WB4JZxVI9Qug0AV9/kjE6EmRnaelZN8HyDkX5Ruprsl1DarjVxGoIrHo/s0P
 hx86Ln3baJrLpjoCfN07aUHVDxkPN0QmsjO+7Skak4Eu5Ja8y4DKGKjT59Us3ONtinjc
 h04RbBV/Gy33KRQkcezjH5QS9FQF7W+TInUK7P7wC4q/ZoA4S4hmHTZL8pHU08rVcPI4
 lygqkimvWwreupYAChXe4I+5JaNcSNc8be69gc0QZfiCHhPLSvlKPFlH1+kT4/PN8Jou
 PTeH+VKLAwlC/AbjCNMSd8UJk+XUfC/cVWzAplTPiF5Tubs7hc8IsDmw3M9uTRc4avrI
 mS7w==
X-Gm-Message-State: AOJu0YwvpXB2Z/IFXvs/7KDsPxRXRIOiY3IFGQ4IUqIpo202q1q9QkZc
 6qtKqaDPCQ6HGhmCBNJGdFgiLdAImi3F2v7ngw/lhr7NNzduxHtUEGtEOQ==
X-Google-Smtp-Source: AGHT+IED6bX7w+elN5FYsoj1ZU1cMFPM3Yw71A497bvjLCZYMB7MKPYk6l5s3UA3rwDtURMWcDnRuA==
X-Received: by 2002:a05:6a20:ac44:b0:1cc:9ff8:eb3a with SMTP id
 adf61e73a8af0-1cf1d059a66mr2526143637.4.1725629359236; 
 Fri, 06 Sep 2024 06:29:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-718dd6461fasm605341b3a.202.2024.09.06.06.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 06:29:18 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 1/3] tmp105: Coding style fixes
Date: Fri,  6 Sep 2024 06:29:10 -0700
Message-ID: <20240906132912.3826089-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906132912.3826089-1-linux@roeck-us.net>
References: <20240906132912.3826089-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Coding style asks for no space between variable and "++". The next patch
in this series will change one of those assignments. Instead of changing
just one with that patch, change all of them for consistency.

While at it, also fix other coding style problems reported by checkpatch.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/sensor/tmp105.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
index a8730d0b7f..77fbf2f8d3 100644
--- a/hw/sensor/tmp105.c
+++ b/hw/sensor/tmp105.c
@@ -29,16 +29,17 @@
 
 static void tmp105_interrupt_update(TMP105State *s)
 {
-    qemu_set_irq(s->pin, s->alarm ^ ((~s->config >> 2) & 1));	/* POL */
+    qemu_set_irq(s->pin, s->alarm ^ ((~s->config >> 2) & 1));   /* POL */
 }
 
 static void tmp105_alarm_update(TMP105State *s)
 {
-    if ((s->config >> 0) & 1) {					/* SD */
-        if ((s->config >> 7) & 1)				/* OS */
-            s->config &= ~(1 << 7);				/* OS */
-        else
+    if ((s->config >> 0) & 1) {                                 /* SD */
+        if ((s->config >> 7) & 1) {                             /* OS */
+            s->config &= ~(1 << 7);                             /* OS */
+        } else {
             return;
+        }
     }
 
     if (s->config >> 1 & 1) {
@@ -89,7 +90,8 @@ static void tmp105_get_temperature(Object *obj, Visitor *v, const char *name,
     visit_type_int(v, name, &value, errp);
 }
 
-/* Units are 0.001 centigrades relative to 0 C.  s->temperature is 8.8
+/*
+ * Units are 0.001 centigrades relative to 0 C.  s->temperature is 8.8
  * fixed point, so units are 1/256 centigrades.  A simple ratio will do.
  */
 static void tmp105_set_temperature(Object *obj, Visitor *v, const char *name,
@@ -118,30 +120,30 @@ static void tmp105_read(TMP105State *s)
 {
     s->len = 0;
 
-    if ((s->config >> 1) & 1) {					/* TM */
+    if ((s->config >> 1) & 1) {                                 /* TM */
         s->alarm = 0;
         tmp105_interrupt_update(s);
     }
 
     switch (s->pointer & 3) {
     case TMP105_REG_TEMPERATURE:
-        s->buf[s->len ++] = (((uint16_t) s->temperature) >> 8);
-        s->buf[s->len ++] = (((uint16_t) s->temperature) >> 0) &
-                (0xf0 << ((~s->config >> 5) & 3));		/* R */
+        s->buf[s->len++] = (((uint16_t) s->temperature) >> 8);
+        s->buf[s->len++] = (((uint16_t) s->temperature) >> 0) &
+                (0xf0 << ((~s->config >> 5) & 3));              /* R */
         break;
 
     case TMP105_REG_CONFIG:
-        s->buf[s->len ++] = s->config;
+        s->buf[s->len++] = s->config;
         break;
 
     case TMP105_REG_T_LOW:
-        s->buf[s->len ++] = ((uint16_t) s->limit[0]) >> 8;
-        s->buf[s->len ++] = ((uint16_t) s->limit[0]) >> 0;
+        s->buf[s->len++] = ((uint16_t) s->limit[0]) >> 8;
+        s->buf[s->len++] = ((uint16_t) s->limit[0]) >> 0;
         break;
 
     case TMP105_REG_T_HIGH:
-        s->buf[s->len ++] = ((uint16_t) s->limit[1]) >> 8;
-        s->buf[s->len ++] = ((uint16_t) s->limit[1]) >> 0;
+        s->buf[s->len++] = ((uint16_t) s->limit[1]) >> 8;
+        s->buf[s->len++] = ((uint16_t) s->limit[1]) >> 0;
         break;
     }
 }
@@ -153,10 +155,10 @@ static void tmp105_write(TMP105State *s)
         break;
 
     case TMP105_REG_CONFIG:
-        if (s->buf[0] & ~s->config & (1 << 0))			/* SD */
+        if (s->buf[0] & ~s->config & (1 << 0))                  /* SD */
             printf("%s: TMP105 shutdown\n", __func__);
         s->config = s->buf[0];
-        s->faults = tmp105_faultq[(s->config >> 3) & 3];	/* F */
+        s->faults = tmp105_faultq[(s->config >> 3) & 3];        /* F */
         tmp105_alarm_update(s);
         break;
 
@@ -175,7 +177,7 @@ static uint8_t tmp105_rx(I2CSlave *i2c)
     TMP105State *s = TMP105(i2c);
 
     if (s->len < 2) {
-        return s->buf[s->len ++];
+        return s->buf[s->len++];
     } else {
         return 0xff;
     }
@@ -215,7 +217,7 @@ static int tmp105_post_load(void *opaque, int version_id)
 {
     TMP105State *s = opaque;
 
-    s->faults = tmp105_faultq[(s->config >> 3) & 3];		/* F */
+    s->faults = tmp105_faultq[(s->config >> 3) & 3];            /* F */
 
     tmp105_interrupt_update(s);
     return 0;
-- 
2.45.2


