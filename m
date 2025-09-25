Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65034CAC5AE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 01:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1aJv-0001jW-KG; Wed, 24 Sep 2025 20:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3vZPUaAkKCoQtq5qiw6ivowwotm.kwuymu2-lm3mtvwvov2.wzo@flex--lixiaoyan.bounces.google.com>)
 id 1v1aJt-0001is-P5
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 20:58:49 -0400
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3vZPUaAkKCoQtq5qiw6ivowwotm.kwuymu2-lm3mtvwvov2.wzo@flex--lixiaoyan.bounces.google.com>)
 id 1v1aJm-0004lw-2P
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 20:58:47 -0400
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-32eae48beaaso364850a91.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 17:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1758761917; x=1759366717; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=yBZzaq4OPnrNzR5BlCDzRnqVDQ5Ky610bUSrxowzc/0=;
 b=CQsQ6BmnUIVnvT0CZuWFPH8hA4HFYeDe56PajwX2m73NtCLWwfKpgiasXshEZgIBQf
 W7bTpxlQWbcPeGOyb21IA4eEPUJRc3yV+swgPEUpH06YP0oBRvW9d0ddxrevXQ4Xk3Z5
 wITi0vbCiJXBrqXc1YByHIWKz/4qnNLnHknK78wR8aZKdOa4peRxGBZrXPKe0y0ItBCx
 aDNiM+K6+MgBzDaZYbCz4yeYJkNkynTHG1HdA98eQRWhch0mUfjDXrRfKU7osNzc5jxk
 racybRQfsHbYr9xNeeoa7mPzWiOi4ZYVBqtg/XK0kGCfqjAbg7lrHCa8RbL5OpJq2AQj
 SgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758761917; x=1759366717;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yBZzaq4OPnrNzR5BlCDzRnqVDQ5Ky610bUSrxowzc/0=;
 b=vGaHFd/3CsbSVCVZhHEURJviZhFY96vSC5i7N5X9EIoeTnfzas2iHUX91g7Zz6Jyfs
 F5J/RdvyIe96CKwiCvMoyAuIpOXzFyXTDGoxvkb7GxCssWJXnbQlac1v0cGsu+mJznUu
 iqMlmdPF3LNP2p/nqVdH88MIQKqwHy61x7gUfOjUo0lZBurIxrsiQL+6Gh54lV3DSUbz
 5Wi+RLsvZhG9J0n+pnDpo+qMSlEUiZ+Bp1mQXWQwhcHDwbOdDoFJntmT7xhHfwGyYEV8
 byaowFaQAUZ65XKHKgy2ZmD2yCk3skLOHB4vwFmPJxbGMwEJUEHLcHYllLqXQbxarfCp
 vgvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVW7/Sk/n2ayda7vp3ikMGcviCdOwmq33NAh+htURgrkNruuY+TXu4B1/7ByDOiKAVrAUYCMfPhwj7D@nongnu.org
X-Gm-Message-State: AOJu0YxSH+a8ylVmrUFUOCUjzIAnypJl+neYcKjJH3W5+gmqa0y1wrtC
 WmhB86a8dXhWFbYJvwcfQIRWem7PcmTubKzLR508kuIFkZ6uR+e4IdFEPb4LF6JdpzhOO+Wnlni
 5GwgcRvik6mlhd5L0wg==
X-Google-Smtp-Source: AGHT+IHjVh5Hcl5LmRu88onDqyDDdsuWzXcT4ON0E3PEKUbh2975IlIaQWr1vFOhf9RNVZt4mdgdgZWuOl3VAU4=
X-Received: from plgk12.prod.google.com ([2002:a17:902:ce0c:b0:269:8538:446e])
 (user=lixiaoyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:c94f:b0:24c:7b94:2f87 with SMTP id
 d9443c01a7336-27ed49d0885mr17118235ad.14.1758761917549; 
 Wed, 24 Sep 2025 17:58:37 -0700 (PDT)
Date: Thu, 25 Sep 2025 00:58:28 +0000
In-Reply-To: <20250925005832.3708492-1-lixiaoyan@google.com>
Mime-Version: 1.0
References: <20250925005832.3708492-1-lixiaoyan@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250925005832.3708492-2-lixiaoyan@google.com>
Subject: [PATCH v1 1/5] hw/gpio: Add property for ASPEED GPIO in 32 bits basis
From: Coco Li <lixiaoyan@google.com>
To: peter.maydell@linaro.org, clg@kaod.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, lixiaoyan@google.com, 
 flwu@google.com, andrew@codeconstruct.com.au
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3vZPUaAkKCoQtq5qiw6ivowwotm.kwuymu2-lm3mtvwvov2.wzo@flex--lixiaoyan.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -85
X-Spam_score: -8.6
X-Spam_bar: --------
X-Spam_report: (-8.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
2.51.0.536.g15c5d4f767-goog


