Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFD1C36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 22:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txD0V-0002Tf-GM; Tue, 25 Mar 2025 18:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txD0N-0001x7-C9
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:44:19 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txD0L-00076I-HY
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:44:19 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so64503605e9.3
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 15:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742942656; x=1743547456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rRDzb4lcoabfa1g7TNESo0TRQTsJDJlMbDcBcNVFOTk=;
 b=wTPWNk3cyN+IV0t2U7Ul5bXcNcZ0ImvJGn7+KmwU2FV62F+Nd2c94u7F17v6Phq2eG
 khvx5h4j6FhuoPPX1TIBX5XNkwUvlzGv5liLmWU1kGRW44mXnIhz5jG0BMvp242s09Q/
 IhscxvM+dVfCaugQJLpIGY3uj5fe6x4dQrgCb0lYBtDeNU7T0BsCRKF8egKKHlqns8JG
 StXQtgg1jlWB2jOgo07E2+7XfW7UNKqek470mLwJBCPGgPdBvBIzPBNT48mNfs31HtYx
 5Jwz6T63GI/9khEuZBDDS8wkIHfb1TdOs3CVfVCQOCFpYNyOxAH6VfI0MfexBdgU/rLm
 djZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742942656; x=1743547456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rRDzb4lcoabfa1g7TNESo0TRQTsJDJlMbDcBcNVFOTk=;
 b=nTJxpuJeuP8CV5l0Yizh4FDLWpX8BQPLL/asqrQJxp0EE6bAlx5u8GehHO2TvNi21T
 92pSv8507LUN8gMqLo0n3TC2XwU6oZnsivliMk5ePyJvvqtjkIs8uJsLr59PW1PeIaow
 1m6aYAmSqd4SUeljKLhCYGi3KXklMm2uxNpfL59D038PImmardQHPAQ02Da1L/dq1gf+
 PQxj7PDD9Tb4zEXndJiydceRgoRgcxQQdQEtJemowqJgIdBbdZsgRnxghbqxrqOZF33T
 jo2GJlr2bInnxxHAIs6fpwSWhgA+DB7aIu04SAZIfju6rzy5aE1+fHwGuja7g/DnzIhx
 jzHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvqfV+5Uv+Jxu23rCP1PqvZw9OAyY3kQMUvj0xzDYXFMb5/uvN5dFdB1+3cEDP03B0/2BjUudueQyt@nongnu.org
X-Gm-Message-State: AOJu0YwVbUfdX3T3TShaw4E3V1xoiOSECfALkAPYNMEzGLyhY4NBRmwp
 2tXKp/ennNcwakvpnosdQOfPnOf+aiyeV8mUjt/1/WtMk9q/kLLSs2+PIueiggE=
X-Gm-Gg: ASbGnct3cmYluFZDpQnW/sGiHpxt9GgMJskrPhggRdEaAgLf92v72GBi9XFrslFPaHY
 oEhMDgbDDKwx7z/rNebfLZy04aWnNMVbO5fJM2YCIrmsFEiNiyKM72W53a+N8A/7KR1ea1nWzem
 4ceak0HfFcLF506Fnm2Q2GEMufg68YfwhPPj+mrdt269m/THPmPM++OxOOT4x7AsMUzpftyZMgK
 WPI+nWAFD5eH+0UJBnLM0sy9qZRTClLZfEIxrrAsiD++RH0NDjcQlJAo0eIdz5w5PrQEp8nFJgZ
 /JVXaUdCihxzrxLC7WjaaW0EcFewpBCvgKaqmuxcgTi2PagrZEw/oDVt2vDasISQzIyMyRqZCv+
 vzYpqlFrgwSmSJ7Y7+wiFtTDqGpPz+g==
X-Google-Smtp-Source: AGHT+IHHXuXOJ3rhPPn57mhx+DzpUGOFlQZLvBBz9tlzmWRDdef0QxEooRidexd+Q7/SyNK8Dd/jMA==
X-Received: by 2002:a5d:47a5:0:b0:390:f699:8c27 with SMTP id
 ffacd0b85a97d-3997f902e3dmr16502105f8f.12.1742942656024; 
 Tue, 25 Mar 2025 15:44:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f99561dsm15172846f8f.12.2025.03.25.15.44.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Mar 2025 15:44:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>,
	qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Glenn Miles <milesg@linux.ibm.com>, Samuel Tardieu <sam@rfc1149.net>,
 qemu-block@nongnu.org, Patrick Leis <venture@google.com>,
 David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Bernhard Beschow <shentey@gmail.com>, Hanna Reitz <hreitz@redhat.com>,
 Hao Wu <wuhaotsh@google.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org
Subject: [PATCH-for-10.0 11/12] hw/sensor/temp: Categorize and add description
Date: Tue, 25 Mar 2025 23:43:09 +0100
Message-ID: <20250325224310.8785-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250325224310.8785-1-philmd@linaro.org>
References: <20250325224310.8785-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sensor/dps310.c  | 2 ++
 hw/sensor/emc141x.c | 6 ++++++
 hw/sensor/tmp105.c  | 2 ++
 hw/sensor/tmp421.c  | 4 ++++
 4 files changed, 14 insertions(+)

diff --git a/hw/sensor/dps310.c b/hw/sensor/dps310.c
index 6966a53248b..e1e6df6b60a 100644
--- a/hw/sensor/dps310.c
+++ b/hw/sensor/dps310.c
@@ -207,6 +207,8 @@ static void dps310_class_init(ObjectClass *klass, void *data)
     k->send = dps310_tx;
     device_class_set_legacy_reset(dc, dps310_reset);
     dc->vmsd = &vmstate_dps310;
+    dc->desc = "Infineon DPS310 temperature and humidity sensor";
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
 static const TypeInfo dps310_info = {
diff --git a/hw/sensor/emc141x.c b/hw/sensor/emc141x.c
index 33c1bd330fd..6adb94e7ff5 100644
--- a/hw/sensor/emc141x.c
+++ b/hw/sensor/emc141x.c
@@ -280,19 +280,25 @@ static void emc141x_class_init(ObjectClass *klass, const void *data)
 static void emc1413_class_init(ObjectClass *klass, void *data)
 {
     EMC141XClass *ec = EMC141X_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
 
     emc141x_class_init(klass, data);
     ec->model = EMC1413_DEVICE_ID;
     ec->sensors_count = 3;
+    dc->desc = "SMSC EMC1413 temperature sensor";
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
 static void emc1414_class_init(ObjectClass *klass, void *data)
 {
     EMC141XClass *ec = EMC141X_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
 
     emc141x_class_init(klass, data);
     ec->model = EMC1414_DEVICE_ID;
     ec->sensors_count = 4;
+    dc->desc = "SMSC EMC1414 temperature sensor";
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
 static const TypeInfo emc141x_info = {
diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
index ef2824f3e1b..6a38f2c6670 100644
--- a/hw/sensor/tmp105.c
+++ b/hw/sensor/tmp105.c
@@ -323,6 +323,8 @@ static void tmp105_class_init(ObjectClass *klass, void *data)
     k->recv = tmp105_rx;
     k->send = tmp105_tx;
     dc->vmsd = &vmstate_tmp105;
+    dc->desc = "TI TMP105 temperature sensor";
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
 static const TypeInfo tmp105_info = {
diff --git a/hw/sensor/tmp421.c b/hw/sensor/tmp421.c
index 007f7cd018b..ba42ab328e0 100644
--- a/hw/sensor/tmp421.c
+++ b/hw/sensor/tmp421.c
@@ -342,6 +342,7 @@ static void tmp421_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
     TMP421Class *sc = TMP421_CLASS(klass);
+    g_autofree char *name_up = NULL;
 
     dc->realize = tmp421_realize;
     k->event = tmp421_event;
@@ -349,6 +350,9 @@ static void tmp421_class_init(ObjectClass *klass, void *data)
     k->send = tmp421_tx;
     dc->vmsd = &vmstate_tmp421;
     sc->dev = (DeviceInfo *) data;
+    name_up = g_ascii_strup(sc->dev->name, -1);
+    dc->desc = g_strconcat("TI ", name_up, " temperature sensor", NULL);
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 
     object_class_property_add(klass, "temperature0", "int",
                               tmp421_get_temperature,
-- 
2.47.1


