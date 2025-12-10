Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA6CD3E783
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 23:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTTcw-00048T-If; Wed, 10 Dec 2025 18:29:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3YQI6aQYKCp4WS9GLXEMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--yubinz.bounces.google.com>)
 id 1vTTcs-00046Q-0P
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 18:29:42 -0500
Received: from mail-dl1-x124a.google.com ([2607:f8b0:4864:20::124a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3YQI6aQYKCp4WS9GLXEMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--yubinz.bounces.google.com>)
 id 1vTTcq-0005hQ-7e
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 18:29:41 -0500
Received: by mail-dl1-x124a.google.com with SMTP id
 a92af1059eb24-11bd7a827fdso2064272c88.1
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 15:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765409378; x=1766014178; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=zDfTc10h+sN6Hw4TsR9A/uoTVOWxiNQn/0DS/fxireU=;
 b=uF9kllZOqOp/Comx5tOjOE4cXg+snTlUJt4pZkuCMCL0j1kqutuZLTOfL8zbNJRjY7
 kGgTVAZPRZfYc7nOxX+DYXbkx6yHq+PNXzpI41xARmqqlvrAohC/EtD9qFI+a+Gf9tIh
 6TCxS5RW2k6HKOyDmi+dxGW0cgSllJBqElgee7DDiLk/MNuidAnkc4vRUwV+voaVZazL
 l64Tnu523RAvSf3NFnyzPPbpd6+NEgCFzvvC/3WrbFnZ93Js6WWFPqENmBfYvmSNtJsv
 /06mDxHzm3YXvY297//APD/3TIzJpvtPl/x2broGOGSW9hrROYceXbfV9gaAMgyCkOnp
 fo+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765409378; x=1766014178;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zDfTc10h+sN6Hw4TsR9A/uoTVOWxiNQn/0DS/fxireU=;
 b=d8P7igbntwPVWmyGnSn6W3Limba7Ed5+XErKq5hTc/DeHoonEaIOTbC57cIjtWJ8Zz
 RroeJ3DYhzYgNJWjpztsJcYukYcNNysqvS7Ro6Hsu6PzpM6NdwnrGrMMhIoeXsSBAIUb
 VtAwO+obnba3Bm4R/dkIUJwjCkxNDF619xD54U3TsJ4rsSct8eBQmDmYsAT5fQZ/SE/t
 9x9o/b3IrvaBjWtNTAO+VxH4ZVsF67dNrxkTlCaqHQ9m5r4VUtS0ys2ugWuyYM08doNo
 wcqm+t7glGP/qXBSye9YA7oXgi4snRR+vVuF+cORpYQkEJbfPdrgvY3lKq0wjOFvAA8b
 GV/Q==
X-Gm-Message-State: AOJu0YwASs0vqt56MqKmUi0gCQP7kKEZlRyaHCUxTLSbRY+ZJK72qx5p
 j6vsXyzNi4jznaE3+sCwZo05wnypIrwcTh7/7xlkyr9hOLxzOWqYOqZkO9TBtdmu5UGJOtCXsTH
 HgAj0CoqSyqCyU8RxQzFddaKHG43KPsp59El2yuxV3oapdC0eWkbd6gbDiCeCUe/Gpz8yLSAxxT
 9L9QoY8CnpOq92w7gnIwCjit6+63R8tAdtNfk=
X-Google-Smtp-Source: AGHT+IEMhUFqF7UGlgCfQl3WjgMo8efqK7w82qvcQA9TcZztAujwXrJFTJDaW7lGHYKHvQdLRxEJQIcF4NE=
X-Received: from dlbbu28.prod.google.com
 ([2002:a05:7022:221c:b0:11d:cdd1:432c])
 (user=yubinz job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:791:b0:11d:fcc9:f225
 with SMTP id a92af1059eb24-11f2ee840f0mr80137c88.14.1765409377793; Wed, 10
 Dec 2025 15:29:37 -0800 (PST)
Date: Wed, 10 Dec 2025 23:29:13 +0000
In-Reply-To: <20251210-aspeed-sgpio-v3-0-eb8b0cf3dd51@google.com>
Mime-Version: 1.0
References: <20251210-aspeed-sgpio-v3-0-eb8b0cf3dd51@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20251210-aspeed-sgpio-v3-2-eb8b0cf3dd51@google.com>
Subject: [PATCH v3 2/6] hw/gpio/aspeed_sgpio: Add QOM property accessors for
 SGPIO pins
From: Yubin Zou <yubinz@google.com>
To: qemu-devel@nongnu.org
Cc: "=?utf-8?q?C=C3=A9dric_Le_Goater?=" <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>, 
 Nabih Estefan <nabihestefan@google.com>, qemu-arm@nongnu.org, 
 Yubin Zou <yubinz@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::124a;
 envelope-from=3YQI6aQYKCp4WS9GLXEMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--yubinz.bounces.google.com;
 helo=mail-dl1-x124a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

The `aspeed_sgpio_get_pin` and `aspeed_sgpio_set_pin` functions are
implemented to get and set the level of individual SGPIO pins. These
are then exposed as boolean properties on the SGPIO device object.

Signed-off-by: Yubin Zou <yubinz@google.com>
---
 hw/gpio/aspeed_sgpio.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/hw/gpio/aspeed_sgpio.c b/hw/gpio/aspeed_sgpio.c
index 8676fa7ced134f1f62dc9e30b42c5fe6db3de268..27c406d5042f423b914d53de000b727cb7242dc9 100644
--- a/hw/gpio/aspeed_sgpio.c
+++ b/hw/gpio/aspeed_sgpio.c
@@ -91,6 +91,73 @@ static void aspeed_sgpio_2700_write(void *opaque, hwaddr offset, uint64_t data,
     }
 }
 
+static bool aspeed_sgpio_get_pin_level(AspeedSGPIOState *s, int pin)
+{
+    uint32_t value = s->ctrl_regs[pin >> 1];
+    bool is_input = !(pin % 2);
+    uint32_t bit_mask = 0;
+
+    if (is_input) {
+        bit_mask = SGPIO_SERIAL_IN_VAL_MASK;
+    } else {
+        bit_mask = SGPIO_SERIAL_OUT_VAL_MASK;
+    }
+
+    return value & bit_mask;
+}
+
+static void aspeed_sgpio_set_pin_level(AspeedSGPIOState *s, int pin, bool level)
+{
+    uint32_t value = s->ctrl_regs[pin >> 1];
+    bool is_input = !(pin % 2);
+    uint32_t bit_mask = 0;
+
+    if (is_input) {
+        bit_mask = SGPIO_SERIAL_IN_VAL_MASK;
+    } else {
+        bit_mask = SGPIO_SERIAL_OUT_VAL_MASK;
+    }
+
+    if (level) {
+        value |= bit_mask;
+    } else {
+        value &= ~bit_mask;
+    }
+    s->ctrl_regs[pin >> 1] = value;
+}
+
+static void aspeed_sgpio_get_pin(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    bool level = true;
+    int pin = 0xfff;
+    AspeedSGPIOState *s = ASPEED_SGPIO(obj);
+
+    if (sscanf(name, "sgpio%03d", &pin) != 1) {
+        error_setg(errp, "%s: error reading %s", __func__, name);
+        return;
+    }
+    level = aspeed_sgpio_get_pin_level(s, pin);
+    visit_type_bool(v, name, &level, errp);
+}
+
+static void aspeed_sgpio_set_pin(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    bool level;
+    int pin = 0xfff;
+    AspeedSGPIOState *s = ASPEED_SGPIO(obj);
+
+    if (!visit_type_bool(v, name, &level, errp)) {
+        return;
+    }
+    if (sscanf(name, "sgpio%03d", &pin) != 1) {
+        error_setg(errp, "%s: error reading %s", __func__, name);
+        return;
+    }
+    aspeed_sgpio_set_pin_level(s, pin, level);
+}
+
 static const MemoryRegionOps aspeed_gpio_2700_ops = {
   .read       = aspeed_sgpio_2700_read,
   .write      = aspeed_sgpio_2700_write,
@@ -114,6 +181,16 @@ static void aspeed_sgpio_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
+static void aspeed_sgpio_init(Object *obj)
+{
+    for (int i = 0; i < ASPEED_SGPIO_MAX_PIN_PAIR * 2; i++) {
+        char *name = g_strdup_printf("sgpio%03d", i);
+        object_property_add(obj, name, "bool", aspeed_sgpio_get_pin,
+                            aspeed_sgpio_set_pin, NULL, NULL);
+        g_autofree(name);
+    }
+}
+
 static void aspeed_sgpio_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -143,6 +220,7 @@ static const TypeInfo aspeed_sgpio_ast2700_info = {
   .name           = TYPE_ASPEED_SGPIO "-ast2700",
   .parent         = TYPE_ASPEED_SGPIO,
   .class_init     = aspeed_sgpio_2700_class_init,
+  .instance_init  = aspeed_sgpio_init,
 };
 
 static void aspeed_sgpio_register_types(void)

-- 
2.52.0.239.gd5f0c6e74e-goog


