Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CC7CD4F48
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 17:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOIcS-0002Q4-JA; Sat, 16 May 2026 13:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOIcR-0002PW-C5
 for qemu-devel@nongnu.org; Sat, 16 May 2026 13:16:07 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOIcP-00084q-Oy
 for qemu-devel@nongnu.org; Sat, 16 May 2026 13:16:07 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso14966285e9.1
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 10:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778951764; x=1779556564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AsSTIk+0JSWuno3/dEFZUZlrRwN5mUJXqdEg56UWohE=;
 b=OLKNG/Tog/r1CyFig2kVI1i+s0KPWjYGl4YXADXC1HR/fNH6u1MBRbF2ws18ZgHe0/
 SU0mNBOKv+HjgW0VSuDfarBJ0E5LXxp5xYhaFheOR8ES8qrpGw80N3O+mcqYf2GW8Gan
 2pnDusbKfHZU/Qt/nX+z/OueqQ4KRv7Okf/7t5l9rq/VJRH5GQIdrjJ+tCeR+4G8DHoe
 cpJPL0HNtBpoiKq375SWqlXwGJ5maaza2AR2LwIIILVY5Q7RX9HLNoHQ5aDdBeSapKU7
 jZHRhqEAYlHITEnPPTsmzhEF8R6POyCxJY7CvBLnDe1u1nn0C7fkdwHDrGUFDbk+BODK
 2NtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778951764; x=1779556564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AsSTIk+0JSWuno3/dEFZUZlrRwN5mUJXqdEg56UWohE=;
 b=lojRtDrxoOiKZ62YzTVQEAFyX5MwV/EwzMEQtFzSIGZ34KlODsdcgaj31qxGPX3eJo
 hDbwwGEt7WTXgd7o2NI1dTkhjyd7ncz31aCY0Jfz8o9spymIhXtgyJUcgna7OSPKdDGP
 CC78Ugy7cSMlvKyh6YhsWHL1hB0NR8v86g7CwZbvlue4zBrk9cJzmymaXfCJqUYVPfYK
 OcwEKPv+tLr2p6mDY4XXiDK3aYZ+lE5Jsm4nHC05yvvX5NmY368WRxx45YdsNxT3iIsW
 lqIMEIUSuy/H+N2bixG+5dxzrE7v7BVxdaQ6EMTyFlzI6ZM9/ZKXhsYypC7ZzKxf1f7B
 cwvg==
X-Gm-Message-State: AOJu0Yw1vAMh2FuT1Dz6xfBVlLDqnEuz/DzoNM+m4wNyL+p0eivRwW5z
 ufMiW+8KsLF25iUUPDCn147T4nP3o+CvYP2ur4yoC2dODy5eqk7QtL9oiCSBhBxS7kfHltpvnEC
 V8n1QpvY=
X-Gm-Gg: Acq92OEB9Dix1y2x80EOJ8ZB/xQOvI++0X/LghJkilh+eZacfy33a+vhyUXxlhN6jxd
 I7JAB+z+hx6H5DqPJsQGyZKotfqx/Ttm151svKn+FKoirDkN84GDyuqHkwj9Y51Nb+G/LhXngZR
 pNijPMzt6NvM1Q21JwJj5dYR0Q1QuYZkP2/6sIRoFpPguVenGqbt3avVADmD7t/Si0hGTNv57S+
 4x/GtG/uy65/OR9m6eZ9mZB2i/IRlhG27fLp4yLWAHcSYdI9tR8GqnXO9+jGZT6iKk9CCWsYQR6
 uIdF43rXRVuixkIu26LMHV6S07w8+N8PrurCJ1J+3LCIG70tsEdGDRCBgFVynasktU3RVpcOBO5
 r3191BgCEwWDn8SsHpJpRiPTVg62irnMnwkoJE2Ts3jWLFPwcVOR8IlqFE6agsBVzHQCwBLBHmR
 CrgHt2f/Udv6KS/S8KHcDyZNi8JLtWwzjhRjtMzGIf8jrbm3XKUM9bTGUOjLlKozDW1BUaNN7U
X-Received: by 2002:a05:600c:46d0:b0:489:1abb:5559 with SMTP id
 5b1f17b1804b1-48fe4dad784mr107868645e9.5.1778951763841; 
 Sat, 16 May 2026 10:16:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fead15bf3sm42602285e9.6.2026.05.16.10.16.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 16 May 2026 10:16:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Joel Stanley <joel@jms.id.au>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Troy Lee <leetroy@gmail.com>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v7 05/21] hw/arm/aspeed: Do not realize 64-bit CPU types under
 QTest
Date: Sat, 16 May 2026 19:15:07 +0200
Message-ID: <20260516171524.19184-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516171524.19184-1-philmd@linaro.org>
References: <20260516171524.19184-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

aspeed_ast27x0.c models 2 similar SoC based on a 64-bit only
CPU (Cortex-A35), only available in the 64-bit binary.

If we build this file as common object, these SoCs become
available in both 32 and 64-bit binaries; however when running
the introspection test on the 32-bit binary, the init() method
tries to init the Cortex-A35 type -- although not realizing it
-- which is not available. Simply skip CPU initialization when
running QTests on a 32-bit binary, asserting the realization
step is not reached.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/aspeed_ast27x0.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 87dcb82e1b0..8311902f0c7 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -18,6 +18,7 @@
 #include "qemu/error-report.h"
 #include "hw/i2c/aspeed_i2c.h"
 #include "net/net.h"
+#include "system/qtest.h"
 #include "system/system.h"
 #include "hw/intc/arm_gicv3.h"
 #include "qobject/qlist.h"
@@ -419,6 +420,15 @@ static void aspeed_soc_ast2700_init(Object *obj)
     }
 
     for (i = 0; i < sc->num_cpus; i++) {
+        if (qtest_enabled() && !target_aarch64()) {
+            /*
+             * Introspection qtest just want to create this object
+             * without realizing it. ARM_CPU_TYPE_NAME("cortex-a35")
+             * is not available on 32-bit binary: skip it since we
+             * won't even realize it.
+             */
+            continue;
+        }
         object_initialize_child(obj, "cpu[*]", &a->cpu[i],
                                 aspeed_soc_cpu_type(sc->valid_cpu_types));
     }
@@ -693,6 +703,10 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     qemu_irq irq;
     int uart;
 
+    if (qtest_enabled() && !target_aarch64()) {
+        g_assert_not_reached();
+    }
+
     /* Default boot region (SPI memory or ROMs) */
     memory_region_init(&s->spi_boot_container, OBJECT(s),
                        "aspeed.spi_boot_container", 0x400000000);
-- 
2.53.0


