Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E87EF513E1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 22:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyGt4-0001D9-P7; Thu, 05 Mar 2026 17:09:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vyGsr-00011N-Ts
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:09:30 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vyGsp-0002F4-GJ
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:09:29 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48378136adcso51909395e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 14:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772748566; x=1773353366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CJx9Hj31eX7Y3Z+9nYTXa1xFEWa58APXwA1Xzcuwa6k=;
 b=ItokNzedvc7ofVgkURsvuc2LN9/GGusoWA0AeW7ldzUnaDwl+BWTWdT6W5eV0rAWz3
 t3A3/E+HBlA061VSMWlj2oAA+3UCEJOfYNrWE7fqMeGNAd2LN+RD/dNzZJRrED5JJnSZ
 g3/shh8cd8ODUeWdDXc0w/syQZjldX6Da453ne2g7ueA8D98dvWp+4yTb0mMU/mPXiys
 loii/tYXvNmJ7iJRIuKvlPA/BcUAqNG/7CtL+KY6ICjOGXRHLTDeV4YjN2GDB90lhPDM
 Kh+bptIt5B87Dz4EoLhfVYDnuwRmofB9YWEEETCopf6mdsUHSuImQMVtt7acmOtfSwJ9
 /6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772748566; x=1773353366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CJx9Hj31eX7Y3Z+9nYTXa1xFEWa58APXwA1Xzcuwa6k=;
 b=jhxfA+Of+DuHXRRaLO1bBdm8RwC1d8/o5PWMZ/65C7FvHv/K6s8xZNpZ16bRjAei13
 kqaPPwnR1JCfC+yZIPj8Vn6opTxFi8WtltxMaJELl119ZDRCYPePCHbobj2YD0jKMZKM
 A7HK4j5RcJWf5coMFF6D5FUCah/HDWc8FVQXJMw+9b7kYeuuXLt3rIsZtFL7TXs+azHi
 N4El97McdC7hsWmscY+IUNy3j6RPdCAbJn2ruQ9PIkbgPpEjXUJ5PFf4guTui8aMEV3F
 fh4I8nP2h6R3Gqh5a/TwkwnqxH1wYrGXUTJNGHOmyYQJqfMDjOXRCQW4wApkQ4DTXpWj
 LP6Q==
X-Gm-Message-State: AOJu0YyezvZ6gZYdYMa95W6D/D2C4BwIBQedERerhpWb4ZV2GX3EBvtG
 42qz+aXJT7UE6DQ5i5JQG0slu2WUPJinPfsCh4C9bqwOxqolxGwrXQbhFoy1XA==
X-Gm-Gg: ATEYQzwAkWXndiRUpsJM13b2mghBybQzx7ZQPk9EVHtIajEN+MNQI2goMyWJ+4aEK9y
 rxO8AhHXbIXZvDlWawPjZIyL1k3J7E1mkWK8FOg6/bbEibrpv0Db/R3WIHvW4QDG9cqAIuwguD4
 TIzzU4vZPt0I4MwjLnL+HiCSRalG4znwLRC0yRX9Bd6U9ZezpJfI8XrDsdQLS+ZiH2HQx6Q0l7f
 83nGCgObeIjmxQCkBbk7P3Jf+Q4sGFJslYusQB1GjncPJs1HL6A2EUnqZqbXQnESEQsOwNWmpvu
 2DdGYRpQzfaYIj6aFw7GT/wIPBGZFqVKiPeiKfPPWkO0Ga0mfjHszcT7f+umGavYsPsaEolQxfs
 WFmUwmW/JHNCPMRgv6O79ExBcodPYjE5mqkjdOuDS8ih+ZHG8HFXFEs/RJfE8Y58T84T2+9PWEk
 PqRCTK2K1HbEyXltG0RxY5lRZC4J0jB4H/MUbXQeE+qqs1g8Hx/UW9QPiALzRSWAVX/jOuC9Kpe
 feM7OZPWzQ7ynpH7Ia8Yb0wFqdcQdozk174mFm1V49ucB4=
X-Received: by 2002:a05:600c:138c:b0:47e:e952:86c9 with SMTP id
 5b1f17b1804b1-485197e7678mr141539665e9.0.1772748565495; 
 Thu, 05 Mar 2026 14:09:25 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-2a02-3100-2989-c400-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2989:c400:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fa87e56sm67419615e9.0.2026.03.05.14.09.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 14:09:25 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Troy Lee <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org,
 Helge Deller <deller@gmx.de>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 05/14] hw/char/serial: Remove explicit cast from void
 pointer
Date: Thu,  5 Mar 2026 23:09:02 +0100
Message-ID: <20260305220911.131508-6-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305220911.131508-1-shentey@gmail.com>
References: <20260305220911.131508-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

A void pointer asks for being casted, so C allows for omitting the
explicit cast. Take advantage of that.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/serial.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index adbd1d1d4a..0f2e79dfba 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -715,7 +715,7 @@ static const VMStateDescription vmstate_serial_thr_ipending = {
 
 static bool serial_tsr_needed(void *opaque)
 {
-    SerialState *s = (SerialState *)opaque;
+    SerialState *s = opaque;
     return s->tsr_retry != 0;
 }
 
@@ -734,7 +734,7 @@ static const VMStateDescription vmstate_serial_tsr = {
 
 static bool serial_recv_fifo_needed(void *opaque)
 {
-    SerialState *s = (SerialState *)opaque;
+    SerialState *s = opaque;
     return !fifo8_is_empty(&s->recv_fifo);
 
 }
@@ -752,7 +752,7 @@ static const VMStateDescription vmstate_serial_recv_fifo = {
 
 static bool serial_xmit_fifo_needed(void *opaque)
 {
-    SerialState *s = (SerialState *)opaque;
+    SerialState *s = opaque;
     return !fifo8_is_empty(&s->xmit_fifo);
 }
 
@@ -769,7 +769,7 @@ static const VMStateDescription vmstate_serial_xmit_fifo = {
 
 static bool serial_fifo_timeout_timer_needed(void *opaque)
 {
-    SerialState *s = (SerialState *)opaque;
+    SerialState *s = opaque;
     return timer_pending(s->fifo_timeout_timer);
 }
 
@@ -786,7 +786,7 @@ static const VMStateDescription vmstate_serial_fifo_timeout_timer = {
 
 static bool serial_timeout_ipending_needed(void *opaque)
 {
-    SerialState *s = (SerialState *)opaque;
+    SerialState *s = opaque;
     return s->timeout_ipending != 0;
 }
 
@@ -803,7 +803,7 @@ static const VMStateDescription vmstate_serial_timeout_ipending = {
 
 static bool serial_poll_needed(void *opaque)
 {
-    SerialState *s = (SerialState *)opaque;
+    SerialState *s = opaque;
     return s->poll_msl >= 0;
 }
 
-- 
2.53.0


