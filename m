Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3F5EE6452
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 06:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sodhG-0004VY-8N; Thu, 12 Sep 2024 02:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sodhE-0004Py-S4
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:52:52 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sodhC-0003R3-IH
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:52:52 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42cb6f3a5bcso6203995e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 23:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726123968; x=1726728768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V5BN+QwDDBigOpVAkHKfRD9kl52tOEsyOrGfIU6uf3I=;
 b=fgD/Ppqm2kWBOy2kW376Ib9pzFf5aj5jWbob5uuZ8Ec5tvcsznAD0ahaz81yC8FO3i
 zbKME9gB46Vq1rridUA7sov3OxkdIdJVRZGAcXOtpqU+rFX3mNRzXdk5iOJBdrZdXOJM
 UBdSmzzSiUDCYQunwLGmlU6Rsw1ek16bMd2SKURpj/ygOyaU6qtS54pk+AoDC2jfCC7Q
 TkPnWTuHgp6jYMTWQp67T1exkGJM+VexWFkBHaZUc38jN2A+7WWYNyTXKMFUcWaYkdsg
 UuYbmh7NtqwySYoG8nKfmOAQgLXnbcVseM1uoxQapCShMzV0g5vHHOsNSuu0nIqalQXC
 AuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726123968; x=1726728768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V5BN+QwDDBigOpVAkHKfRD9kl52tOEsyOrGfIU6uf3I=;
 b=o3ht71DMfeDzxf3Cmd8w9fzgm8r7vrrKK2n8/MXY5qzjnToHZEPWyR6ko5SppjvPRJ
 1JYaxFNk2cG4FVw5YVPlKwSEvp9Eqn7HyFoFk5bRWXqVj64hspnoUDC4Vn45e7z6untR
 KzpzFs9QeY10EvM4sWt+qYVxxDZpyM12q0F8RsBEgUU0nAWAUxafzCPVKn/TDAq7cU/x
 VSVjsJV5Rx5WDrS/uaGoBCZacgnkPpp64fOduaflA3+2mMPlhmopwetio+C9MUM4it24
 L1vrn/8rMW5oHg2vowYYLX0O7MZy3YdiQicc4AQT9HTcxsxnXCiy1I/tS5JbzkJmWA6t
 oraw==
X-Gm-Message-State: AOJu0Yyb6tfY4msLmMR3KxbCEvUKX0vljY1VZDWjaYUqUg3Gt2yeVaxa
 ZZsFTBjmkWByrbrMXtxX+yKssXbxYgg760VpDaJEZUNdRFaP5UN8sDHRIEWxknXTzgFc2psEtcF
 w
X-Google-Smtp-Source: AGHT+IFAYZkWItKLEkRJuLBGZ/s8Cuq1yzDXlSLDwb8p1b6IWNT64I+33xzSu/y+U/0NJv609FqhcA==
X-Received: by 2002:a05:600c:154c:b0:42c:b950:6821 with SMTP id
 5b1f17b1804b1-42cdb5495e8mr13462905e9.19.1726123968162; 
 Wed, 11 Sep 2024 23:52:48 -0700 (PDT)
Received: from m1x-phil.lan (mic92-h03-176-184-33-210.dsl.sta.abo.bbox.fr.
 [176.184.33.210]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956e8700sm13401232f8f.116.2024.09.11.23.52.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 23:52:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 46/61] hw/sensor/tmp105: Pass 'oneshot' argument to
 tmp105_alarm_update()
Date: Thu, 12 Sep 2024 08:52:17 +0200
Message-ID: <20240912065227.67848-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240912065227.67848-1-philmd@linaro.org>
References: <20240912065227.67848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

The next commit will clear the ONE_SHOT bit in the WRITE
path (to keep the READ path trivial). As a preliminary step,
pass the 'oneshot' value as argument to tmp105_alarm_update().
No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Message-Id: <20240906154911.86803-4-philmd@linaro.org>
---
 hw/sensor/tmp105.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
index 150d09b278..6740200aea 100644
--- a/hw/sensor/tmp105.c
+++ b/hw/sensor/tmp105.c
@@ -40,10 +40,10 @@ static void tmp105_interrupt_update(TMP105State *s)
     qemu_set_irq(s->pin, s->alarm ^ FIELD_EX8(~s->config, CONFIG, POLARITY));
 }
 
-static void tmp105_alarm_update(TMP105State *s)
+static void tmp105_alarm_update(TMP105State *s, bool one_shot)
 {
     if (FIELD_EX8(s->config, CONFIG, SHUTDOWN_MODE)) {
-        if (FIELD_EX8(s->config, CONFIG, ONE_SHOT)) {
+        if (one_shot) {
             s->config = FIELD_DP8(s->config, CONFIG, ONE_SHOT, 0);
         } else {
             return;
@@ -119,7 +119,7 @@ static void tmp105_set_temperature(Object *obj, Visitor *v, const char *name,
 
     s->temperature = (int16_t) (temp * 256 / 1000);
 
-    tmp105_alarm_update(s);
+    tmp105_alarm_update(s, false);
 }
 
 static const int tmp105_faultq[4] = { 1, 2, 4, 6 };
@@ -168,7 +168,7 @@ static void tmp105_write(TMP105State *s)
         }
         s->config = s->buf[0];
         s->faults = tmp105_faultq[FIELD_EX8(s->config, CONFIG, FAULT_QUEUE)];
-        tmp105_alarm_update(s);
+        tmp105_alarm_update(s, FIELD_EX8(s->buf[0], CONFIG, ONE_SHOT));
         break;
 
     case TMP105_REG_T_LOW:
@@ -177,7 +177,7 @@ static void tmp105_write(TMP105State *s)
             s->limit[s->pointer & 1] = (int16_t)
                     ((((uint16_t) s->buf[0]) << 8) | s->buf[1]);
         }
-        tmp105_alarm_update(s);
+        tmp105_alarm_update(s, false);
         break;
     }
 }
-- 
2.45.2


