Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 445ECD3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 00:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSlAz-0007BS-9w; Mon, 08 Dec 2025 19:01:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <37GY3aQYKCuchdKRWiPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--yubinz.bounces.google.com>)
 id 1vSlAu-0007AM-9Y
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 19:01:52 -0500
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <37GY3aQYKCuchdKRWiPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--yubinz.bounces.google.com>)
 id 1vSlAs-0007S6-9S
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 19:01:52 -0500
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-bc0de474d4eso11055603a12.0
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 16:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765238508; x=1765843308; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=+itFqe9iOClWFdQYPXiXyfRgN0EhEj+MWSAts2YlJwo=;
 b=iWkMmJJiaRis1j4QSPAoj8I7RvmVTQg2+NqhzU4n0apUSyZ7D28HkiRTJht3I+yG44
 ed6a+ml+ihNQLyrOIMdz/4NGI2YSMxij3NUhQPImRLPhotIhklTH+epRj039Ho5OpXzU
 9LnCs1OEVLJ51UG/ZhO2yKhG4raI5W/j7Z6cS9XzQqmLU84WwyIYzbywud6CSAfJaW/N
 OPYkb6+82s+JRJcmjPrBE64icvylzho+nHWSQKWNCvn7+7g14qSRRkYX8iWZySGsUTe1
 g31arpvc0UP5Hx1aoajMKZyC6hcZRlgibc32zzUnbwTCIEUy9RaGKF9suDo+xrcR95IU
 n0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765238508; x=1765843308;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+itFqe9iOClWFdQYPXiXyfRgN0EhEj+MWSAts2YlJwo=;
 b=KNQHB0dTaXaAOY9eKdY10yhkJSQlBx6BLxcO51kf3hq8sQnNENBmTphf2btTq83OlW
 zf5VPGlGneL0WViIXgzeUsrTrZWuhhhAqeRQge1mnVgKgNH0o2b7It+ZzYdnFmaD6MhA
 eB+AQtiN9562xUtqJ1e6Bex3LcM6QvodAjdlHPSjN34aVVILCYmGmmrlfBeQ6WTXaY9k
 yr0Sp9wBJwvo7BwMTbrec43cLDP0mmggraEaADnZeiufmO67IDH00xwS9QWd/4Ftf5+8
 sPRlhTP7OCC9oBqoGevh9knwTl0WEUEVH3kwRHdQS5oNk9Vzois2whXVuHDqQjmbUA1h
 dxdg==
X-Gm-Message-State: AOJu0YwkrM1P5gwzUfMcWrolm4iACYQBjxQhOBIUx7hWddlqQQgD3IIs
 LcORWmMRcxwXamg1b/dDe54dnfHP0bNgmdWbRmSU/KU6UlzOmiCvg84OV2p7NhxayE4utN1xfg3
 2UirnG42bmC4eKfgEFxa0UPCaIKKiXup/LKmZq/hSw7ZcroE35CpLgRX6IzUIHp/c7SX49fTc7H
 CtxvZayqdydpu8DXxxhUPCoHrqgk9BVbUVHIo=
X-Google-Smtp-Source: AGHT+IF2tu7LwmcUONnfMxXidevBRZBxTXYI9iD8VG//RH4XA96JSoELfsyN0MNVB0pmy9l+0XORFikNLSY=
X-Received: from dlbpk8.prod.google.com ([2002:a05:7022:3848:b0:119:78ff:fe16])
 (user=yubinz job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:f81:b0:119:e56b:c74f
 with SMTP id a92af1059eb24-11e0315acc3mr6436240c88.20.1765238508206; Mon, 08
 Dec 2025 16:01:48 -0800 (PST)
Date: Tue, 09 Dec 2025 00:01:34 +0000
In-Reply-To: <20251209-aspeed-sgpio-v2-0-976e5f5790c2@google.com>
Mime-Version: 1.0
References: <20251209-aspeed-sgpio-v2-0-976e5f5790c2@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20251209-aspeed-sgpio-v2-2-976e5f5790c2@google.com>
Subject: [PATCH v2 2/6] hw/gpio/aspeed_sgpio: aspeed: Add QOM property
 accessors for SGPIO pins
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=37GY3aQYKCuchdKRWiPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--yubinz.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This commit adds QOM property accessors for the Aspeed SGPIO pins.
The `aspeed_sgpio_get_pin` and `aspeed_sgpio_set_pin` functions are
implemented to get and set the level of individual SGPIO pins. These
are then exposed as boolean properties on the SGPIO device object.

Signed-off-by: Yubin Zou <yubinz@google.com>
---
 hw/gpio/aspeed_sgpio.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/hw/gpio/aspeed_sgpio.c b/hw/gpio/aspeed_sgpio.c
index 8676fa7ced134f1f62dc9e30b42c5fe6db3de268..efa7e574abe87e33e58ac88dba5e3469c6702b83 100644
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
+    if (sscanf(name, "sgpio%d", &pin) != 1) {
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
+    if (sscanf(name, "sgpio%d", &pin) != 1) {
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
+        char *name = g_strdup_printf("sgpio%d", i);
+        object_property_add(obj, name, "bool", aspeed_sgpio_get_pin,
+                            aspeed_sgpio_set_pin, NULL, NULL);
+        g_free(name);
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
2.52.0.223.gf5cc29aaa4-goog


