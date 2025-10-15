Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75529CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 01:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8qA6-0000Pn-PJ; Tue, 14 Oct 2025 21:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3a_buaAkKCmILIXIAOYANGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--lixiaoyan.bounces.google.com>)
 id 1v8qA5-0000Oe-8E
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 21:18:41 -0400
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3a_buaAkKCmILIXIAOYANGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--lixiaoyan.bounces.google.com>)
 id 1v8qA1-0003CX-Rr
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 21:18:40 -0400
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-7900f597d08so8378330b3a.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 18:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1760491115; x=1761095915; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=br1b472i1wUs/pSTcxpYafrcAix2wuzSuhGHbD2r6is=;
 b=XxiI9HYMZTh3lWtTqjXNgfDEwm5BZ6/9gl3y0s5aTO6wJPRPjW6cYNgyvrFS9FmyVw
 ZML/Ml9CcGjk47PLudmj5xHT/l41SZmzzAsJuMk5fZAc4v/MukPrezd6ZgREce1kMxh1
 EH8vQjk++i8ofS9TFda3KPJTv8IN5EHZv1YBseKg6UAaRJ/3cKFqmU3xcYAWJZJZNep8
 csdEZE+jlcbpybizY6AMU91sRJhRP1iNsvkaDXHJc1uw252vmFfyRAlR2kq/LD1TWX4x
 WWf+LlxNFMHZ40RBR6TgoGjfmC435W3fzg6yJWV6FV29AZGqExFDrJY6KQ9hQ5YmxiTY
 HjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760491115; x=1761095915;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=br1b472i1wUs/pSTcxpYafrcAix2wuzSuhGHbD2r6is=;
 b=YTKpL34/IdpXfUwm6SyuyUisEMyjAT37triJ09vUlVtnCpXMD3Y4aFVws7Meg9ee+1
 ARNQyHffGyTEmCAlNmN1xO9JZKhsMfh0qPIRPB3RioqLrGwteNUWwD5s1cSnFe0rCYsa
 Ozv1yBrE1qBSHR2PE1a9QHWjNYORo5DZ2BQyTsk6f6RGEEbZTN9WsLJxQRUVMapm2QXM
 eyl1pvsR3J3FX58b/XydpZcvWGqkFwsGkMFwv0MfsBUAzClKcaChdOOXVxni3jfsnfgf
 h2XHs+oLEgFt3H1AAe5v+T93oBOj89wNCo07gqPi5AparOAATpl+kXWWigNOCmKP9B1r
 5EHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+IxekBmTCs669yryvEuExbYeNKhfqYB9SG5ng7/u4djqUmgEElrUMjJ0gUY96tMvhcK06irqwD+z3@nongnu.org
X-Gm-Message-State: AOJu0YwAJe4kDeip5KocF7HnZGOZVd26AwcHYXFCtuozBx/MzH02rYCn
 lVxlI+fHnbd7MxuNCLQSbhKgPwnzuLq3hZYFTwHmjv2nKKXhD5XSU0MljJjv6rm827N2F72LC35
 NvrTzcgc1TK1+Bt2uFQ==
X-Google-Smtp-Source: AGHT+IHbk/xA1p5r1qAbvU3M8yXXgmw/JxqWiFcRjPO95okkaM3zslpG4i9/gx+EzUEtjArn8d56QLt19ZZROyc=
X-Received: from pjzb22.prod.google.com ([2002:a17:90a:e396:b0:338:3770:a496])
 (user=lixiaoyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3383:b0:2f1:a8f0:9631 with SMTP id
 adf61e73a8af0-32da80bb5fcmr35583758637.10.1760491115532; 
 Tue, 14 Oct 2025 18:18:35 -0700 (PDT)
Date: Wed, 15 Oct 2025 01:18:25 +0000
In-Reply-To: <20251015011830.1688468-1-lixiaoyan@google.com>
Mime-Version: 1.0
References: <20251015011830.1688468-1-lixiaoyan@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251015011830.1688468-2-lixiaoyan@google.com>
Subject: [PATCH v2 1/5] hw/gpio: Add property for ASPEED GPIO in 32 bits basis
From: Coco Li <lixiaoyan@google.com>
To: peter.maydell@linaro.org, clg@kaod.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, lixiaoyan@google.com, 
 flwu@google.com, andrew@codeconstruct.com.au, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::44a;
 envelope-from=3a_buaAkKCmILIXIAOYANGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--lixiaoyan.bounces.google.com;
 helo=mail-pf1-x44a.google.com
X-Spam_score_int: -88
X-Spam_score: -8.9
X-Spam_bar: --------
X-Spam_report: (-8.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.269,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5 autolearn=no autolearn_force=no
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

From: Felix Wu <flwu@google.com>

Added 32 bits property for ASPEED GPIO. Previously it can only be access in bitwise manner.

The changes to qobject is to index gpios with array indices on top of accessing with registers.
This allows for easier gpio access, especially in tests with complex behaviors that requires large number of gpios at a time, like fault injection and networking behaviors.

Indexing multiple gpios at once allows qmp/side band client to no longer hardcode and populate register names and manipulate them faster.

Signed-off-by: Felix Wu <flwu@google.com>
---
 hw/gpio/aspeed_gpio.c | 57 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index 609a556908..2d78bf9515 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -1308,6 +1308,57 @@ static void aspeed_gpio_2700_write(void *opaque, hwaddr offset,
 }
 
 /* Setup functions */
+static void aspeed_gpio_set_set(Object *obj, Visitor *v,
+                                        const char *name, void *opaque,
+                                        Error **errp)
+{
+    uint32_t set_val = 0;
+    AspeedGPIOState *s = ASPEED_GPIO(obj);
+    AspeedGPIOClass *agc = ASPEED_GPIO_GET_CLASS(s);
+    int set_idx = 0;
+
+    if (!visit_type_uint32(v, name, &set_val, errp)) {
+        return;
+    }
+
+    if (sscanf(name, "gpio-set[%d]", &set_idx) != 1) {
+        error_setg(errp, "%s: error reading %s", __func__, name);
+        return;
+    }
+
+    if (set_idx >= agc->nr_gpio_sets || set_idx < 0) {
+        error_setg(errp, "%s: invalid set_idx %s", __func__, name);
+        return;
+    }
+
+    aspeed_gpio_update(s, &s->sets[set_idx], set_val,
+                       ~s->sets[set_idx].direction);
+}
+
+static void aspeed_gpio_get_set(Object *obj, Visitor *v,
+                                        const char *name, void *opaque,
+                                        Error **errp)
+{
+    uint32_t set_val = 0;
+    AspeedGPIOState *s = ASPEED_GPIO(obj);
+    AspeedGPIOClass *agc = ASPEED_GPIO_GET_CLASS(s);
+    int set_idx = 0;
+
+    if (sscanf(name, "gpio-set[%d]", &set_idx) != 1) {
+        error_setg(errp, "%s: error reading %s", __func__, name);
+        return;
+    }
+
+    if (set_idx >= agc->nr_gpio_sets || set_idx < 0) {
+        error_setg(errp, "%s: invalid set_idx %s", __func__, name);
+        return;
+    }
+
+    set_val = s->sets[set_idx].data_value;
+    visit_type_uint32(v, name, &set_val, errp);
+}
+
+/****************** Setup functions ******************/
 static const GPIOSetProperties ast2400_set_props[ASPEED_GPIO_MAX_NR_SETS] = {
     [0] = {0xffffffff,  0xffffffff,  {"A", "B", "C", "D"} },
     [1] = {0xffffffff,  0xffffffff,  {"E", "F", "G", "H"} },
@@ -1435,6 +1486,12 @@ static void aspeed_gpio_init(Object *obj)
             g_free(name);
         }
     }
+
+    for (int i = 0; i < agc->nr_gpio_sets; i++) {
+        char *name = g_strdup_printf("gpio-set[%d]", i);
+        object_property_add(obj, name, "uint32", aspeed_gpio_get_set,
+        aspeed_gpio_set_set, NULL, NULL);
+    }
 }
 
 static const VMStateDescription vmstate_gpio_regs = {
-- 
2.51.0.788.g6d19910ace-goog


