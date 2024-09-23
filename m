Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D298CCF9C72
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 10:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssg7K-0001f2-Gl; Mon, 23 Sep 2024 06:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssg7I-0001VV-3l; Mon, 23 Sep 2024 06:16:29 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssg7G-0003n3-7t; Mon, 23 Sep 2024 06:16:27 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a8d13b83511so507825566b.2; 
 Mon, 23 Sep 2024 03:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727086584; x=1727691384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iW9Nb8JYiU7FYlwU62yCNJWG+ELvo3kziCKhcjaKlnk=;
 b=ASsz3Q0rQ99i5i5NnLloRJU95pgwtPqmc3ePOLazHa38bPzD1VIYG4uBny7cxmVsYN
 NXUrHXr4OCULKgefp0YYwnEdvLbgZpnlPB+kjYJj2fQaxXDN3orlGKIHvwm4VqrSQI3i
 ifrH2K/IyQTuagfXKS10hCScA4Y/eT05gnsdFo9wFtkBhO0kWzM0+jmqhuSWIyhfBc76
 aCkeP8nTmBufSD7m6tCziD1UJC2afGhsBFCLoTS1YC7ekWq4FPouPEvqJRZh9urMcgC0
 1yBVAUOXZNays6YNHwqcFu0+zpvnrRrf0RVROaDIHQqaHE9G7ckNv1oEca/KK1eeVYu1
 j5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727086584; x=1727691384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iW9Nb8JYiU7FYlwU62yCNJWG+ELvo3kziCKhcjaKlnk=;
 b=wS/yzOjCXjpbZWiiIA4NZXWfPhOK4JO7KkHP6mRq/YmwlmuKLS83YpFcF2ir/rHzj3
 6Z3h7Uq8XwFy9fEHCydGuZCZ2ZpBDk4+jnUkMP4pjAjPYxWwcJblB0rG3cQ1si4Y9DIA
 mud8ah8cYnTTPlkfveCEPuuBpTE7Johl/tc4p3neXAlCyoEOHwndx5M4XJBB5FyMaWKj
 ttdXuuSJoU/9PwaWLDO8nYAHbkYmBr9iLqIVb4gRiEF13u3tXoZqIIFhdy/rfqKHconi
 MMbI+S44RacjNt1r0m+Vi+q5VyBJmOO8X8NxlMWdoeSttYrib8f2FZafaONqEnaabej5
 fVVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHrs+4Um5yAj9n10VsOOieP5Ys1s3fKXJGSiYhQq7yz+7aCHteyDAKhl/aySnPCdC+YG2vTMOugg==@nongnu.org
X-Gm-Message-State: AOJu0YwUp626aFAou/CSYQwNf+8dKiq+vvp31GaEgT7wUWhaJOrUzEXB
 aDxELzuw8s8FxzWR47WabduKpghW2hQD/c23XUx3PSrVZJsL1UepgxzCvQ==
X-Google-Smtp-Source: AGHT+IFzDg9rF7QWcx+azBaWgHy519glAU7tWioYphCjR1Cs849WfTmBHBj2sEc+bhZiVLTzn+8MBQ==
X-Received: by 2002:a17:907:7f90:b0:a91:7af:d3f2 with SMTP id
 a640c23a62f3a-a9107afd632mr313835266b.63.1727086583504; 
 Mon, 23 Sep 2024 03:16:23 -0700 (PDT)
Received: from archlinux.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90610f43e9sm1187655566b.72.2024.09.23.03.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 03:16:23 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 3/3] hw/ppc/e500: Reuse TYPE_GPIO_POWEROFF
Date: Mon, 23 Sep 2024 12:15:54 +0200
Message-ID: <20240923101554.12900-4-shentey@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923101554.12900-1-shentey@gmail.com>
References: <20240923101554.12900-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The ppce500 machine provides a device tree node whose compatible property is
"gpio-poweroff". This matches TYPE_GPIO_POWEROFF like used in the ARM virt
machine, so reuse it.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/ppc/e500.c  | 15 +++------------
 hw/ppc/Kconfig |  1 +
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 3bd12b54ab..af74b32c13 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -30,7 +30,6 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
 #include "sysemu/reset.h"
-#include "sysemu/runstate.h"
 #include "kvm_ppc.h"
 #include "sysemu/device_tree.h"
 #include "hw/ppc/openpic.h"
@@ -47,7 +46,6 @@
 #include "hw/platform-bus.h"
 #include "hw/net/fsl_etsec/etsec.h"
 #include "hw/i2c/i2c.h"
-#include "hw/irq.h"
 #include "hw/sd/sdhci.h"
 #include "hw/misc/unimp.h"
 
@@ -892,13 +890,6 @@ static DeviceState *ppce500_init_mpic(PPCE500MachineState *pms,
     return dev;
 }
 
-static void ppce500_power_off(void *opaque, int line, int on)
-{
-    if (on) {
-        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
-    }
-}
-
 void ppce500_init(MachineState *machine)
 {
     MemoryRegion *address_space_mem = get_system_memory();
@@ -1086,7 +1077,7 @@ void ppce500_init(MachineState *machine)
     sysbus_create_simple("e500-spin", pmc->spin_base, NULL);
 
     if (pmc->has_mpc8xxx_gpio) {
-        qemu_irq poweroff_irq;
+        DeviceState *poweroff_dev;
 
         dev = qdev_new("mpc8xxx_gpio");
         s = SYS_BUS_DEVICE(dev);
@@ -1096,8 +1087,8 @@ void ppce500_init(MachineState *machine)
                                     sysbus_mmio_get_region(s, 0));
 
         /* Power Off GPIO at Pin 0 */
-        poweroff_irq = qemu_allocate_irq(ppce500_power_off, NULL, 0);
-        qdev_connect_gpio_out(dev, 0, poweroff_irq);
+        poweroff_dev = sysbus_create_simple("gpio-poweroff", -1, NULL);
+        qdev_connect_gpio_out(dev, 0, qdev_get_gpio_in(poweroff_dev, 0));
     }
 
     /* Platform Bus Device */
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 5addad1124..31764ef909 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -158,6 +158,7 @@ config E500
     imply VIRTIO_PCI
     select ETSEC
     select GPIO_MPC8XXX
+    select GPIO_POWEROFF
     select OPENPIC
     select PFLASH_CFI01
     select PLATFORM_BUS
-- 
2.46.1


