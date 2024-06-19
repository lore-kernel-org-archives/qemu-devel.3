Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9468C2BA15
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 07:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJpov-0000dF-5x; Wed, 19 Jun 2024 03:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sJpos-0000cW-Vt; Wed, 19 Jun 2024 03:33:27 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sJpoq-0002eL-ID; Wed, 19 Jun 2024 03:33:26 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4217d808034so55354805e9.3; 
 Wed, 19 Jun 2024 00:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718782402; x=1719387202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=feXgtXlTkQC9v0K3dfEGHl8JmANr4HegvWlnYc3fgvQ=;
 b=NZwPBQ0U9rQGMJEYQpresIbJlpWj4P4E2Ist1ruTxgvcbGL4qCoshLrDH4nribjZDb
 ktoRR2vuHt5m9nEMH9LJnZyUmABzKx1bmRzjlybGIhynpr+KYQJ4PPe0XI+umkBo3+gh
 eQ6Du+oFsuKvNg9rEmbHqexOTDILVSRyiUQRdE+KdYidBZh4NOKT+4xuLvHzYzSip+1+
 NoMr3KmzzGRmpSBTh6shp/niwvRobwsVRpeXOv6vt74ADaoK0EN42V/vevJZigdAI9Hp
 MqQV/a/8Z2WrpvUMXj/hnmcQsIZRx0NT+yO23ngJqNCgyVopGEvfVPn7sTA1Zgj+dTxN
 Hzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718782402; x=1719387202;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=feXgtXlTkQC9v0K3dfEGHl8JmANr4HegvWlnYc3fgvQ=;
 b=t9qKGs9EDmYGJm5MZhv2dx9B/tNhwf3zwGxfuT+IycUFIZtr3AR3/mphwPVlwQL/rw
 gntQKJBzEttRTxkj99RZGKcx9h+69cF/+uPE7myop/tGHSiye/wQr/yR/UruYOuCfrpb
 WvwPAnqqU+lQR8WzxEMpvYy/mZ49nx9zqWQYKwgtsOj/AFQtF8hag18U8MmDnny3OT/6
 wPm5Q9+/998TRY4G35YOK3uepwjyevaOAg/T6aRzY0cdFOcBLP2xtQWo/ZKT373rtMQu
 5phhPnIWdTOOnz/GzdQU5UyHBUa8I3gVuOk5ql9gzIUHSHsVmZ5ytf6KeUgw4esFFQhl
 tz4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUmjXN5vl7FAxlEzu1dLTkJOTkSvArNTSgg4e3xkrH0Clh5EznTJ2LPb2R1cnkvbI4+A4C1ml90n4Hp16ZXdXg4x0x4HbrRGosJ0MAKzWaWHaJU3BalKrR3dA=
X-Gm-Message-State: AOJu0YwLVtm/UAGQZ2rNzrfrUJjYyiCt5SNTSNDj3bRX2ujbMa4IMBpK
 BkqQo6kXsdhot9abpVmsotPO3Un7h1Qrs566d+/rYcAFF23uEnU=
X-Google-Smtp-Source: AGHT+IGl5rFMdnjxu75kj4DwXN+4fy+eaZLQMgPAvrWEXyDY8d5RpZU9QdHfLAic7y8jGYt4pgwllg==
X-Received: by 2002:a05:600c:2317:b0:424:76db:3583 with SMTP id
 5b1f17b1804b1-42476db371emr6452235e9.30.1718782402019; 
 Wed, 19 Jun 2024 00:33:22 -0700 (PDT)
Received: from wing.epfl.ch (dhcp-122-dist-b-021.epfl.ch. [128.178.122.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f5f33be5sm221301565e9.2.2024.06.19.00.33.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 00:33:21 -0700 (PDT)
From: Zheyu Ma <zheyuma97@gmail.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Cc: Zheyu Ma <zheyuma97@gmail.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2] hw/gpio/aspeed: Add reg_table_size to AspeedGPIOClass
Date: Wed, 19 Jun 2024 09:33:01 +0200
Message-Id: <20240619073301.3706650-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=zheyuma97@gmail.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

ASan detected a global-buffer-overflow error in the aspeed_gpio_read()
function. This issue occurred when reading beyond the bounds of the
reg_table.

To enhance the safety and maintainability of the Aspeed GPIO code, this commit
introduces a reg_table_size member to the AspeedGPIOClass structure. This
change ensures that the size of the GPIO register table is explicitly tracked
and initialized, reducing the risk of errors if new register tables are
introduced in the future.

AddressSanitizer log indicating the issue:

==2602930==ERROR: AddressSanitizer: global-buffer-overflow on address 0x55a5da29e128 at pc 0x55a5d700dc62 bp 0x7fff096c4e90 sp 0x7fff096c4e88
READ of size 2 at 0x55a5da29e128 thread T0
    #0 0x55a5d700dc61 in aspeed_gpio_read hw/gpio/aspeed_gpio.c:564:14
    #1 0x55a5d933f3ab in memory_region_read_accessor system/memory.c:445:11
    #2 0x55a5d92fba40 in access_with_adjusted_size system/memory.c:573:18
    #3 0x55a5d92f842c in memory_region_dispatch_read1 system/memory.c:1426:16
    #4 0x55a5d92f7b68 in memory_region_dispatch_read system/memory.c:1459:9
    #5 0x55a5d9376ad1 in flatview_read_continue_step system/physmem.c:2836:18
    #6 0x55a5d9376399 in flatview_read_continue system/physmem.c:2877:19
    #7 0x55a5d93775b8 in flatview_read system/physmem.c:2907:12

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
Changes in v2:
- Introduce the reg_table_size to AspeedGPIOClass
---
 hw/gpio/aspeed_gpio.c         | 17 +++++++++++++++++
 include/hw/gpio/aspeed_gpio.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index c1781e2ba3..fd4912edae 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -559,6 +559,12 @@ static uint64_t aspeed_gpio_read(void *opaque, hwaddr offset, uint32_t size)
         return debounce_value;
     }
 
+    if (idx >= agc->reg_table_size) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: idx 0x%" PRIx64 " out of bounds\n",
+                      __func__, idx);
+        return 0;
+    }
+
     reg = &agc->reg_table[idx];
     if (reg->set_idx >= agc->nr_gpio_sets) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: no getter for offset 0x%"
@@ -785,6 +791,12 @@ static void aspeed_gpio_write(void *opaque, hwaddr offset, uint64_t data,
         return;
     }
 
+    if (idx >= agc->reg_table_size) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: idx 0x%" PRIx64 " out of bounds\n",
+                      __func__, idx);
+        return;
+    }
+
     reg = &agc->reg_table[idx];
     if (reg->set_idx >= agc->nr_gpio_sets) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: no setter for offset 0x%"
@@ -1117,6 +1129,7 @@ static void aspeed_gpio_ast2400_class_init(ObjectClass *klass, void *data)
     agc->nr_gpio_pins = 216;
     agc->nr_gpio_sets = 7;
     agc->reg_table = aspeed_3_3v_gpios;
+    agc->reg_table_size = GPIO_3_3V_REG_ARRAY_SIZE;
 }
 
 static void aspeed_gpio_2500_class_init(ObjectClass *klass, void *data)
@@ -1127,6 +1140,7 @@ static void aspeed_gpio_2500_class_init(ObjectClass *klass, void *data)
     agc->nr_gpio_pins = 228;
     agc->nr_gpio_sets = 8;
     agc->reg_table = aspeed_3_3v_gpios;
+    agc->reg_table_size = GPIO_3_3V_REG_ARRAY_SIZE;
 }
 
 static void aspeed_gpio_ast2600_3_3v_class_init(ObjectClass *klass, void *data)
@@ -1137,6 +1151,7 @@ static void aspeed_gpio_ast2600_3_3v_class_init(ObjectClass *klass, void *data)
     agc->nr_gpio_pins = 208;
     agc->nr_gpio_sets = 7;
     agc->reg_table = aspeed_3_3v_gpios;
+    agc->reg_table_size = GPIO_3_3V_REG_ARRAY_SIZE;
 }
 
 static void aspeed_gpio_ast2600_1_8v_class_init(ObjectClass *klass, void *data)
@@ -1147,6 +1162,7 @@ static void aspeed_gpio_ast2600_1_8v_class_init(ObjectClass *klass, void *data)
     agc->nr_gpio_pins = 36;
     agc->nr_gpio_sets = 2;
     agc->reg_table = aspeed_1_8v_gpios;
+    agc->reg_table_size = GPIO_1_8V_REG_ARRAY_SIZE;
 }
 
 static void aspeed_gpio_1030_class_init(ObjectClass *klass, void *data)
@@ -1157,6 +1173,7 @@ static void aspeed_gpio_1030_class_init(ObjectClass *klass, void *data)
     agc->nr_gpio_pins = 151;
     agc->nr_gpio_sets = 6;
     agc->reg_table = aspeed_3_3v_gpios;
+    agc->reg_table_size = GPIO_3_3V_REG_ARRAY_SIZE;
 }
 
 static const TypeInfo aspeed_gpio_info = {
diff --git a/include/hw/gpio/aspeed_gpio.h b/include/hw/gpio/aspeed_gpio.h
index 904eecf62c..e66036ac39 100644
--- a/include/hw/gpio/aspeed_gpio.h
+++ b/include/hw/gpio/aspeed_gpio.h
@@ -75,6 +75,7 @@ struct AspeedGPIOClass {
     uint32_t nr_gpio_pins;
     uint32_t nr_gpio_sets;
     const AspeedGPIOReg *reg_table;
+    uint32_t reg_table_size;
 };
 
 struct AspeedGPIOState {
-- 
2.34.1


