Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9204FF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLOQ-00005S-Gj; Mon, 27 Apr 2026 08:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNL-0007lE-80
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:47:51 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNI-0005Q2-7V
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:47:45 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso94444795e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294062; x=1777898862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=inQc7p7BRhy2EMrunHSD0peg/ahwU+n5t+qLitof4+E=;
 b=E559pA4cIaUjMIDcq/hr+Braf6Kt+XRkFvaOAeGDI2UOWRQ/yr45zC5S2IdIgHWKhk
 66TZicQLZJUW3cPn7/CXtZjROZc5J99mYJEY/A625cKQ3xN7oH2pSadchertUa5tZZQn
 z4xIxeXJbPbWkWGDT/fTo2ho0z0kMdS+epjZC7rqz9FgJq+m6Yy/vTn9aeQUCJnJvDDH
 96VItj/NUZ5avJaASyY2D4TP4pepm0mJ4IiSW5vcny0DeDbmgw0LdDc1Hdr7RWwofYgM
 eofSDgh2IMp1PD/EDGPZaVPcWJKN7i5NSIdrpo0EVAsa+X2D7Gogh7r12Rr4PP3mS0ac
 xmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294062; x=1777898862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=inQc7p7BRhy2EMrunHSD0peg/ahwU+n5t+qLitof4+E=;
 b=UdkbRMvcizDx5MpJ9yseGxVfY6i/y9dON1F/2tQoorB00lvelO+vT4j80M/r9MalKZ
 dJuDP1m1VuYeBUnoCHlGp3HUcZ4qtTrxvZWJn8nDMwzxdX9rB+E4VsdB4jrfSzqCREMK
 Fn39NB6h7SrU0JSWMKi93Hpg0ZkF/V2jZOT1kNl8hmEtSts7jIAQxR6gse9wnHDiQ6Vi
 RUwvzYyOwdOf9zN27szEMyKkI92whq5ROaYLf87Pd5vY7hD4BvhGFFQ4XXj6XTNNolXr
 OdeibVvz1iWPIePW1r1OCpt7Oqf+d6UolQVGkOv4EgCCtU2ZbZIQr2JhA0Vu6ym+NiB7
 WRTg==
X-Gm-Message-State: AOJu0Yw5rIZ5hyipzEDkJRxYwo0GflzEJbS7OiY8bRCZ+C3Q4vt5//ao
 S9plCOiDXHAKkRQquGgTdGGXIUUbqC9shcul/z7O11SsobF6+DloV3f59dprbqxUxy+s6LoVBuF
 ZcEG0
X-Gm-Gg: AeBDieuAxBccExZ7fplN9omSJ6/oJh0cB8K3qI+k/LNnesYoj9QyNkBdTTXXdnjmGAT
 Actq31z76VrH5hTVJG8De8p0Wzm/bZvIQkXyOfCH9HQrw456G2a3aswBTIogC9vhOk+ccxXmVwq
 BfE9XFuk5FlaHB0A34UT8LR9OmBbbYSFkksPOfk6PqZmvHg35AFcrpZndtbVaDawyTPiuZ0pwqs
 dJTJ+kY5dclCu0KsvLuORsylSvLnrRfN4yrUJWWqQhTzAESJ7u2aVkGf8n/lB0UCmFBKOBZgffM
 V6kQPPCJfSTx3JzJWbwSP+AZoV7TCbhM3E/EU+clMuS9Aask3mREtrAYbNvJuGWFZtIUM4zyQnO
 Pv0zUMJCSWHM6SSg6VWsIy0M9JGjwCmp/fdLShCSWUwiUFNumviqGlA6wwcRxTIaG4zahYC/d85
 5nDNNi/B2SRTZljF9vM+5UJVtBZ+ZpNTiQ+oUjqXX1B5L6LGPMnkh4NqwajUPcXJISmFOemcriF
 L9HOUvZvmdUTIWG0+P3PM1k8/NQHa1Kb23qBNUUyg==
X-Received: by 2002:a05:600c:498a:b0:489:ad:7b5b with SMTP id
 5b1f17b1804b1-48900ad7b76mr305185965e9.24.1777294062055; 
 Mon, 27 Apr 2026 05:47:42 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.47.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:47:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/63] hw/misc/imx8mp_analog: Add property to analog device
Date: Mon, 27 Apr 2026 13:46:37 +0100
Message-ID: <20260427124738.966578-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Gaurav Sharma <gaurav.sharma_7@nxp.com>

Add configurable properties for register reset values that differ
between i.MX 8M variants (Plus, Mini, etc.). This allows the same
device implementation to be shared across multiple SoCs.

Properties added:
- arm-pll-fdiv-ctl0-reset: ARM PLL divider control reset value

Default value is set to match i.MX 8MP reset value (0x000FA031).
This can be overridden in the variant like iMX8MM with its own
reset value.

Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/imx8mp_analog.c         | 12 +++++++++++-
 include/hw/misc/imx8mp_analog.h |  3 +++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/misc/imx8mp_analog.c b/hw/misc/imx8mp_analog.c
index 23ffae84f8..592512071c 100644
--- a/hw/misc/imx8mp_analog.c
+++ b/hw/misc/imx8mp_analog.c
@@ -12,6 +12,7 @@
 #include "qemu/log.h"
 
 #include "hw/misc/imx8mp_analog.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 
 #define ANALOG_PLL_LOCK BIT(31)
@@ -51,7 +52,10 @@ static void imx8mp_analog_reset(DeviceState *dev)
     s->analog[ANALOG_VPU_PLL_LOCKD_CTRL] = 0x0010003f;
     s->analog[ANALOG_VPU_PLL_MNIT_CTRL] = 0x00280081;
     s->analog[ANALOG_ARM_PLL_GEN_CTRL] = 0x00000810;
-    s->analog[ANALOG_ARM_PLL_FDIV_CTL0] = 0x000fa031;
+
+    /* Use property value instead of hardcoded */
+    s->analog[ANALOG_ARM_PLL_FDIV_CTL0] = s->arm_pll_fdiv_ctl0_reset;
+
     s->analog[ANALOG_ARM_PLL_LOCKD_CTRL] = 0x0010003f;
     s->analog[ANALOG_ARM_PLL_MNIT_CTRL] = 0x00280081;
     s->analog[ANALOG_SYS_PLL1_GEN_CTRL] = 0x0aaaa810;
@@ -138,11 +142,17 @@ static const VMStateDescription imx8mp_analog_vmstate = {
     },
 };
 
+static const Property imx8mp_analog_properties[] = {
+    DEFINE_PROP_UINT32("arm-pll-fdiv-ctl0-reset", IMX8MPAnalogState,
+                       arm_pll_fdiv_ctl0_reset, 0x000fa031), /* imx8mp default */
+};
+
 static void imx8mp_analog_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     device_class_set_legacy_reset(dc, imx8mp_analog_reset);
+    device_class_set_props(dc, imx8mp_analog_properties);
     dc->vmsd  = &imx8mp_analog_vmstate;
     dc->desc  = "i.MX 8M Plus Analog Module";
 }
diff --git a/include/hw/misc/imx8mp_analog.h b/include/hw/misc/imx8mp_analog.h
index 6996e53771..0765e607b9 100644
--- a/include/hw/misc/imx8mp_analog.h
+++ b/include/hw/misc/imx8mp_analog.h
@@ -76,6 +76,9 @@ struct IMX8MPAnalogState {
     } mmio;
 
     uint32_t analog[ANALOG_MAX];
+
+    /* Property for variant-specific reset values */
+    uint32_t arm_pll_fdiv_ctl0_reset;
 };
 
 #endif /* IMX8MP_ANALOG_H */
-- 
2.43.0


