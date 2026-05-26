Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB93CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 20:38:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRyXB-0000c5-H7; Tue, 26 May 2026 16:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyX6-0000bf-RS
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:37:48 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyX5-0006pk-4j
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:37:48 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49041e84237so38131515e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 13:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779827865; x=1780432665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GpOhw5w0OQWgKeewy6hW+oiYNCxDv2biTVZ26Aup/v8=;
 b=xyfFC5L6AyUAaPsBm7FT5irRzk+YAaStAJ5VYIGEOP2RRGrjFwk2dEwMJ5goQ12RI5
 76oqnlDO9fSRgZ9ycIPQFXEXDsP+sA/VFiymTKrcO81fvptCTP+67mIUa1yTie+cqKUO
 y95jzdNNt/wZH+ayhds4qzVvVOjjopN1UfLQfdmK80XWHr6zLTBp0LZn5kVZ8ZqmaPYL
 Mid2Axdcm3Sw5T8JgwZ/qOLRk+U2W614QZuJSZdzLDEMCPwtg9w3ho+0H1KeUNP4kvhO
 ar1I6GBvcrK1AiUVs0g8jqwE3qhFoyl2JGDfOOwAmGwc9cxYGhDuZ3veDNBlcw+dhZfX
 3jcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779827865; x=1780432665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GpOhw5w0OQWgKeewy6hW+oiYNCxDv2biTVZ26Aup/v8=;
 b=G/1+7B8vnGG4XzLlay1G6bqKF50l2LLI6c/zEiEy/emRiwqMt+VdTbizX6/xd7qpwq
 CY1QnmU9yyO15Qa0b1N9kbgTxc7uJ9Z5J3yspWBpzjUOxy9xK9YDBhkTXPFJnbugVSL3
 i8tvcijP/iTAHoBOn0h590fm887xD/QG9P42qj+kPosg/5aByWeuisIjX6CsgjNcAvtQ
 0Dd/NoAoTspuTAz5O13HG1plW0iI7IVI7CjU3FDVXieDmgeB4iL+rX3ILHBbTMhgB71m
 0DIcQD5s1d5Za5ZR6qRUAfwl0WNiuHQNs3nsGUwTraxI/NPlTZnLXSuyTeVmHqgGy/ZR
 iebw==
X-Gm-Message-State: AOJu0YwoDZNZh4r1TAbg8jwJpEyjjegzRrJGqwgNpwc7a9ocMdrWvQMK
 DaxSc1XgQBhEdm77HjCocMUBV8Udl22Zd9yBGKt0R0TKyLGOtNottqGqVC2N6HEcNoafgNIkdnm
 Q9VYw6ROXgA==
X-Gm-Gg: Acq92OEE4dOwsF7kwCn0OGHnZ4NExWknp/LwMJSCeDY1u9ONdFrR2OpJ6amfN0r1liE
 SQdcw9zeANkgH224EDbpO+OuYW6E1mUO6nwwq8PKghI1MaAyGn4cMD2+lXJUoQ+3gUApq7I4Sqq
 w6pzmLMjr33lEPjuiuoqg+PAsFkG5njoASsGPI7czWIQfSXlyGHm2c8S8HRQAksYobr40swpRWz
 SiKp2uG/E7GxB/npXIaVUrB5BLzxxnUEjHB4uotZTdzuC3Wpxe/es4y3VfcNg/67Jk1Ylc1csi9
 B3uQl0M2GPeWzcooOMEzkP4qCKy9gaGguy7Q76D87y3k1gZ/EgjLp83NkIGLys3erhjuEyG3MvS
 ocHBrz9hb+7U5aoovPKlrKVCDopfndNLpsrQMmo9EEP1T3zMqdatJ4Q55FjL3j5yxpZq6kIVSUJ
 1cHJXmF+g7EGxabcqzSqO563+GxbKmr8o7YywnwyVf142Zo7CdMBeYkLFP2pQaakWQmA==
X-Received: by 2002:a7b:c7ca:0:b0:490:4b89:5372 with SMTP id
 5b1f17b1804b1-4904b8956c5mr176027065e9.11.1779827865492; 
 Tue, 26 May 2026 13:37:45 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454cfcaesm344673275e9.4.2026.05.26.13.37.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 May 2026 13:37:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v9 03/17] hw/arm/aspeed: Do not realize 64-bit CPU types under
 QTest
Date: Tue, 26 May 2026 22:37:08 +0200
Message-ID: <20260526203722.79463-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526203722.79463-1-philmd@linaro.org>
References: <20260526203722.79463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed_ast27x0.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index d7ce14e8c56..dddd7d21060 100644
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


