Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897E0CA1018
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 22:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utvrH-0005Dw-4I; Wed, 03 Sep 2025 18:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3SbW4aAkKCuIPMbMEScERKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--lixiaoyan.bounces.google.com>)
 id 1utvBN-0005jO-Mi
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 17:38:21 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3SbW4aAkKCuIPMbMEScERKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--lixiaoyan.bounces.google.com>)
 id 1utvBL-0003S5-Ta
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 17:38:21 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-e931c30dc0eso634923276.0
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 14:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1756935497; x=1757540297; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=7YmXbfGBvimAKdLcD+dHyCW8+I0vDsbzJdW19c8VFSA=;
 b=gAsmMsqz0f1DObFDFhkAhJGGmCVkZ0g3L8Th4/BSZCdEvj4yAk8stmSYqBrrUUbm1W
 O2qFzIa8uSe6Qd4X0bsiN10LFBwC+WYe19SZLtUKJ6Kp0x1ShpSLkx/wkEawF0ht1+PF
 aAtwMhNYYpzJ9vb8tSiyEuXNgXQ4M/XaInwd13YsWkq1uUZ/GUPmxTaG9kLQ4DYudYuC
 ABlb/C+xYsdOsyIWrTyHGiFE8+uVI9M/ZAaeVQ9ccFPuwWknbb4lbSVtKfoiLJTaW2aU
 5S9WAY7zXItqxbOg/bWbrRlpcmNlRJpINbxszDLEScJoBvmqNYiva9zYTtY/GFez/n5C
 Fvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756935497; x=1757540297;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7YmXbfGBvimAKdLcD+dHyCW8+I0vDsbzJdW19c8VFSA=;
 b=VnesSrUI8FuQRD+YpOiXmpgbegwWN3JJxGiyoHhBzhjIGGD47Gy0cjN6MyDmkrmwZ2
 tRoPmQcTfTCv+I0mXi+5LBAS05tY/XD39MCbYFQqfuiWViinRuig7IyshPrbR0bp4rZB
 QjM72HtU/T9Twxk6hg2+ITTg5myT9DkC052hA60s/XNutL5mxzeXnpx9Y14O0nPrzi5O
 aDXGUA3WlVFU3UjUpwATNHQZosdOIe46b7kFlij6c0JGXVclyrmhu1t5SEOxvFx3q1T8
 qtZfPyozqVmFJuIypQdhLA+EWIa6oqOzsCL+XwG88o/evjE1tchxVJRb36vdHzKtSO//
 glVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvaser6aC/NBx7WyhZZxu+VPnwgPMvJIBNW/avn140m5/EWCQgANxyRO+UIOta9QtsCVH36tQ7Mm2F@nongnu.org
X-Gm-Message-State: AOJu0YwktTdXV9qBX8lOuOhABmjEergNN7YVQHfZ6QgiBGnU544tLw7G
 web82YjW7fn5q978kDzflb0wDaevYpjn7ndw/9QXTfpmKU0SuA/6+gRmF0LGa6MFJliZFnTCG/Q
 aXIhWIwykO5h1brkskQ==
X-Google-Smtp-Source: AGHT+IGnr80oMbMZwKeA62+/WdLQoGMgHXnxIa4mPkQDbm6ESxOgMgJRfSEzlQcjN/4REELZ42qrkChL1I7Yr2Q=
X-Received: from ybey126.prod.google.com ([2002:a25:dc84:0:b0:e9d:6756:ec1f])
 (user=lixiaoyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6902:18c4:b0:e8f:e04f:ef9d with SMTP id
 3f1490d57ef6-e98a3654661mr19462528276.0.1756935497485; 
 Wed, 03 Sep 2025 14:38:17 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:38:05 +0000
In-Reply-To: <20250903213809.3779860-1-lixiaoyan@google.com>
Mime-Version: 1.0
References: <20250903213809.3779860-1-lixiaoyan@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250903213809.3779860-2-lixiaoyan@google.com>
Subject: [PATCH 1/5] hw/gpio: Add property for ASPEED GPIO in 32 bits basis
From: Coco Li <lixiaoyan@google.com>
To: peter.maydell@linaro.org, clg@kaod.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Felix Wu <flwu@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3SbW4aAkKCuIPMbMEScERKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--lixiaoyan.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -86
X-Spam_score: -8.7
X-Spam_bar: --------
X-Spam_report: (-8.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_FROM=0.938, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 03 Sep 2025 18:21:24 -0400
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

This change gives ASPEED similar behavior as Nuvoton.

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
2.51.0.338.gd7d06c2dae-goog


