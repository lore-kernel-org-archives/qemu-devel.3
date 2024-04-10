Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619D6CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 18:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rucN1-0000gp-JS; Wed, 10 Apr 2024 14:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rucN0-0000ge-IR
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 14:08:26 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rucMy-0005Mx-PA
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 14:08:26 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-417d08135b6so211425e9.1
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 11:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712772502; x=1713377302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=J9NiNwxiik0OPXqS4C5bJncJdvLmqX2i9ON6pLi1lts=;
 b=y/OqxLa7FJQuKj4DNIuXc5+nZni8/Qfg+c/9vWgRBHnysSGTjeYJquECaYBILZyfJ8
 uOrUPQEgRK69NM07uXpgsnW/u2D7XHEz2A7k8EU8oUUgjs8LKuw6Kfgtpo5ZbBZv+Dl0
 FnBDqMnzmx4bvF+DdWTpzY/cJKK8B1kNDlBiWTHHFqh+6kZtZyQisHnsUaSooHoQWP+3
 iocRElFGJwJahCJKjT1ZcboFWX/oHcHhnf+Tg3FGjfww1FxZKrZblg0MatcyPChV6sbp
 KYJAqU5SaoXz03QQHZBVBNOzCtDu24qhybzpIDHozIeKrxB5c2k1a/MbfXNLt/smhzGb
 5j4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712772502; x=1713377302;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J9NiNwxiik0OPXqS4C5bJncJdvLmqX2i9ON6pLi1lts=;
 b=LzqaRT5gcI5ZfwXzH8gbBMDeRf9KeU2HEyBIiFDqnIchVqy5eHmvaHuaBucXng+kbT
 x3F0PMCPnClZnrXRG8BMt+qs8bQQWUEEcbTdfqQh/nLrg7KY8tjKGGBaO8GAR0yQYxEX
 7nXP7B2w1UNs/yZGwqBl59bmigiaPEB9iXXLL78qFlxAgfoJ5rBfEGtwytxKdOJUMX8Q
 QUHjz6EeBx3GxWB+UIsPeIOnC3X6vpI1oAP/VlcQ+ZBYr72n0oYpLmnjAsq5Rdwt3KQl
 E7m5rvnczgvXZbQd1dVf1Og/ilHX2MfMLeBVL4cZicAewuGUB2tQlnR4+HoTQQjezm4m
 rifw==
X-Gm-Message-State: AOJu0YxKb75DpexkaGlxDDu4AewTG1dwgb3qFMILQn5MfYLcPl5reWxo
 rB7u0p+J5nG2fndApVDbYmWTgp0nv9R8IfIRyiDYb9e6XwOxr9Ph1DSXlxzV/hp2GfDBRuc5tPc
 s
X-Google-Smtp-Source: AGHT+IHgxOsAGDmbAXnkH7bXvZ0Qg81OHJFmyDq06HHKwXqdta1dfrVEYnXLNkO3ZvVt6Tp9ToG+ng==
X-Received: by 2002:a05:600c:5654:b0:415:6daf:c64b with SMTP id
 js20-20020a05600c565400b004156dafc64bmr2815076wmb.16.1712772502216; 
 Wed, 10 Apr 2024 11:08:22 -0700 (PDT)
Received: from m1x-phil.lan (arl95-h02-176-184-34-173.dsl.sta.abo.bbox.fr.
 [176.184.34.173]) by smtp.gmail.com with ESMTPSA id
 n3-20020a05600c4f8300b0041627ab1554sm3006269wmq.22.2024.04.10.11.08.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Apr 2024 11:08:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/misc/applesmc: Simplify DeviceReset handler
Date: Wed, 10 Apr 2024 20:08:19 +0200
Message-ID: <20240410180819.92332-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Have applesmc_find_key() return a const pointer.
Since the returned buffers are not modified in
applesmc_io_data_write(), it is pointless to
delete and re-add the keys in the DeviceReset
handler. Add them once in DeviceRealize, and
discard them in the DeviceUnrealize handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
As discussed in
https://lore.kernel.org/qemu-devel/6fbcf565-f12c-4196-b6c8-559843c7a78c@linaro.org/
---
 hw/misc/applesmc.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index 14e3ef667d..59a4899312 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -145,7 +145,7 @@ static void applesmc_io_cmd_write(void *opaque, hwaddr addr, uint64_t val,
     s->data_pos = 0;
 }
 
-static struct AppleSMCData *applesmc_find_key(AppleSMCState *s)
+static const struct AppleSMCData *applesmc_find_key(AppleSMCState *s)
 {
     struct AppleSMCData *d;
 
@@ -161,7 +161,7 @@ static void applesmc_io_data_write(void *opaque, hwaddr addr, uint64_t val,
                                    unsigned size)
 {
     AppleSMCState *s = opaque;
-    struct AppleSMCData *d;
+    const struct AppleSMCData *d;
 
     smc_debug("DATA received: 0x%02x\n", (uint8_t)val);
     switch (s->cmd) {
@@ -269,23 +269,10 @@ static void applesmc_add_key(AppleSMCState *s, const char *key,
 static void qdev_applesmc_isa_reset(DeviceState *dev)
 {
     AppleSMCState *s = APPLE_SMC(dev);
-    struct AppleSMCData *d, *next;
 
-    /* Remove existing entries */
-    QLIST_FOREACH_SAFE(d, &s->data_def, node, next) {
-        QLIST_REMOVE(d, node);
-        g_free(d);
-    }
     s->status = 0x00;
     s->status_1e = 0x00;
     s->last_ret = 0x00;
-
-    applesmc_add_key(s, "REV ", 6, "\x01\x13\x0f\x00\x00\x03");
-    applesmc_add_key(s, "OSK0", 32, s->osk);
-    applesmc_add_key(s, "OSK1", 32, s->osk + 32);
-    applesmc_add_key(s, "NATJ", 1, "\0");
-    applesmc_add_key(s, "MSSP", 1, "\0");
-    applesmc_add_key(s, "MSSD", 1, "\0x3");
 }
 
 static const MemoryRegionOps applesmc_data_io_ops = {
@@ -343,6 +330,24 @@ static void applesmc_isa_realize(DeviceState *dev, Error **errp)
     }
 
     QLIST_INIT(&s->data_def);
+    applesmc_add_key(s, "REV ", 6, "\x01\x13\x0f\x00\x00\x03");
+    applesmc_add_key(s, "OSK0", 32, s->osk);
+    applesmc_add_key(s, "OSK1", 32, s->osk + 32);
+    applesmc_add_key(s, "NATJ", 1, "\0");
+    applesmc_add_key(s, "MSSP", 1, "\0");
+    applesmc_add_key(s, "MSSD", 1, "\0x3");
+}
+
+static void applesmc_unrealize(DeviceState *dev)
+{
+    AppleSMCState *s = APPLE_SMC(dev);
+    struct AppleSMCData *d, *next;
+
+    /* Remove existing entries */
+    QLIST_FOREACH_SAFE(d, &s->data_def, node, next) {
+        QLIST_REMOVE(d, node);
+        g_free(d);
+    }
 }
 
 static Property applesmc_isa_properties[] = {
@@ -377,6 +382,7 @@ static void qdev_applesmc_class_init(ObjectClass *klass, void *data)
     AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(klass);
 
     dc->realize = applesmc_isa_realize;
+    dc->unrealize = applesmc_unrealize;
     dc->reset = qdev_applesmc_isa_reset;
     device_class_set_props(dc, applesmc_isa_properties);
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-- 
2.41.0


