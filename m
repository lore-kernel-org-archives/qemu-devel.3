Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDCA606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZCXyWquH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVqaG-000582-Pj; Tue, 24 Nov 2026 08:29:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVqaA-00056i-Nt
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 08:29:15 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVqa8-0007OC-SO
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 08:29:14 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-490d59c3edaso3053567f8f.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 05:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795526951; x=1796131751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yrZu0JxvfqtzMFa+0gsiObtAopJnpeWR2MUyCBVS6bI=;
 b=ZCXyWquH7df/TS4akzFyOV0TuUkdR6WPFjilGmt35sdY2Nz3Baxf53GIDf4kuuqPNm
 wE+nWTY3NWF8SFNWlnFlgdMHhx0yMZtMO9aTiB2HczcqF/iiI2XiAlelEfK/cYw9WI6u
 8mMkB5wbVmrB5g0lEm6tYAbMY9I2aHD1kAeIdAPjT9TwI79d9oMhT/c+TegvhD76fEaM
 eqrLrAzYZfF1pY+6wxQjnxTomTBlTL7VzBsmOlfinmr9+yue2gQW8+m3S60VlIoJbN0N
 wrkxyJ5ci++/uY3lCE72OGFB9TEpEARtPI1oYet/0lr/SQbeXtNlZjxPLCVZLwTX0YuQ
 GfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795526951; x=1796131751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yrZu0JxvfqtzMFa+0gsiObtAopJnpeWR2MUyCBVS6bI=;
 b=cILybSwzdlhnyLAUkhPeusL4eMxOBKpQIG+mZtenMwDMpuzdVEl//XrkTVtBdoLE4V
 mICNbauveVtuA5qbnwUZ0dl8NDdhQk0IMll90xNkSlWgGTfAPiQTtkujPNQQuEHNYqjn
 hx3fvknoSAITjgg04cSCpL5l/1lII5llZDX8N3FdRC2dYU7mN6Bbz1u6ksKHN7k+rRPp
 N/ufTGrywytc3PBFZSc8uCde3C0wrA1pyWYIGt/dZC+itrxuQEQn66+jCoWc6wPb5IFm
 UxP63XLFaUMmNJsSHV0cFbWvZdk6bDAaI2QgBxSgdCVpSebXavKMxkhIulBbrlugOXPZ
 VD3w==
X-Gm-Message-State: APuU4Z/Gi/w04s0rloVIcUBkaANMtddB4tzDVj8efPqNBhA22mrNf29J
 FRFi/5gE7Umx9YfxlcuQhD2AVQkUyqNgfwlR1ZQb9aptGTmS0rYqdLRLg6yCFdFGPDNXD1k1Sq2
 RSfAR
X-Gm-Gg: AZFdTZcw3NPomLzdjtEO5U8cP7Wf3Mq7W/57DwiYUAVbQZOjSmqhYkccB0zQwVB4FrH
 OPAfSiHMbma21hWq8M1jG7KdNsS7VjQ4BepwXxr160Oh3JgkkqXawNJIS1bEJ/Ozlynrryo4z23
 biS5nTjBHMTfkvmOkTHnb04AAbavfRaESWz4Bfp5BUYFBEtZMMBGL3AY6cdffBMI9DhMlb0gO+m
 UN7RLI8IPbQ6eT30qmk4BImTM1QDvG4OTDU4H/sE/gDvug27UyVAoKPV/XC50/LOD1of3URbrnD
 GtAdZ9KPo3hqgMbgMb90O3W/J96Al755GUv1zInagAbYoqih3h0n//fWOeT5ZeOaYi+vl86ox7V
 9Ex3H+aKSI763QKm26ueWqk48C+MgaWMxwhqYuCHzv/uIfj3ZEzf5AMkybLUnfgsVHn3Fzl1EiI
 dFg2wjUcpBVtokJEoQTK8amdUbjwwK8A+zckvemidLAbwDmyhod8xexE1qtsHxlfN217N+X9vRs
 6Cx43plOveC4UZcjhxxhtM5w33T25lKNZEzQHz6Fppl7I6tHzMRBuh+6BeNNgLKt7pCWfw+YK/D
 wXcSzIRh6sQTwFTIDUTTY0pSz7yDpRNutVyBsufDnNcJvm7Or7NY5K7K6GDj/Bo2Fpy03iAVs5h
 uZ+hQDmd21bLtPvjPNyAPnOjSgOsWJyezTQ==
X-Received: by 2002:a05:6000:438a:b0:48e:127a:c914 with SMTP id
 ffacd0b85a97d-4aa545e25cdmr38306844f8f.5.1795526951437; 
 Tue, 24 Nov 2026 05:29:11 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b10b2c9sm29098031f8f.31.2026.11.24.05.29.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 05:29:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 5/9] hw/arm/bcm2838: Route system timer interrupts to GIC
Date: Tue, 24 Nov 2026 13:29:00 +0000
Message-ID: <20261124132904.138731-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124132904.138731-1-peter.maydell@linaro.org>
References: <20261124132904.138731-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jayesh Agarwal <agarwaljayesh03@gmail.com>

The system timer interrupts are only routed to the legacy interrupt
controller and not to the GIC, so a guest using the GIC (software that
relies on the system timer interrupts through the GIC, such as bare
metal programs or hobby kernels) never receives them.

A qemu_irq connection follows one output, one input. So also wiring the
timer to the GIC would replace its connection to the legacy controller.

Add a splitter per system-timer interrupt line so that each interrupt
reaches both the legacy controller (output 0 of the splitters) and the
GIC (output 1 of the splitters). The timer channel n goes to GIC SPI
64+n, so channels 0-3 go to SPIs 64-67.

Testing:
The raspi4b machine started in the qtest mode:
	qemu-system-aarch64 -M raspi4b -display none -accel qtest -qtest stdio

Ran following commands:
	irq_intercept_in /machine/soc/peripherals
	readl 0xfe003004
	writel 0xfe00300c 1000
	writel 0xfe003010 2000
	writel 0xfe003014 3000
	writel 0xfe003018 4000
	clock_step 5000000
	readl 0xfe003000

Before the fix:
    clock_step 5000000
    OK 5000000
    readl 0xfe003000
    OK 0x000000000000000f
The alarm fires correctly (status flag outputs 0xf), but no IRQ raise
64-67 reaches the GIC.

After the fix:
    clock_step 5000000
    IRQ raise 64
    IRQ raise 65
    IRQ raise 66
    IRQ raise 67
    OK 5000000
    readl 0xfe003000
    OK 0x000000000000000f
The alarm fires, and all the four channels reached GIC lines 64-67.

Reported-by: Sourojeet Adhikari <s23adhik@csclub.uwaterloo.ca>
Signed-off-by: Jayesh Agarwal <agarwaljayesh03@gmail.com>
Message-id: 20261117193205.8236-1-agarwaljayesh03@gmail.com
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jayesh Agarwal <agarwaljayesh03@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/bcm2835_peripherals.h |  1 +
 include/hw/arm/bcm2838_peripherals.h |  4 ++++
 hw/arm/bcm2835_peripherals.c         | 33 ++++++++++++++++++----------
 hw/arm/bcm2838.c                     |  7 ++++++
 4 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index cd66a734e7c..b262bdccb74 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -54,6 +54,7 @@ struct BCMSocPeripheralBaseState {
     qemu_irq irq, fiq;
 
     BCM2835SystemTimerState systmr;
+    SplitIRQ systmr_irq_splitter[BCM2835_SYSTIMER_COUNT];
     BCM2835MphiState mphi;
     UnimplementedDeviceState txp;
     UnimplementedDeviceState armtmr;
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index f9279daa4d0..bb188422013 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -20,6 +20,10 @@
 /* SPI */
 #define GIC_SPI_INTERRUPT_MBOX         33
 #define GIC_SPI_INTERRUPT_MPHI         40
+#define GIC_SPI_INTERRUPT_SYS_TIMER0   64
+#define GIC_SPI_INTERRUPT_SYS_TIMER1   65
+#define GIC_SPI_INTERRUPT_SYS_TIMER2   66
+#define GIC_SPI_INTERRUPT_SYS_TIMER3   67
 #define GIC_SPI_INTERRUPT_DWC2         73
 #define GIC_SPI_INTERRUPT_DMA_0        80
 #define GIC_SPI_INTERRUPT_DMA_6        86
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index be40c6b92a4..5ab2bac4b11 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -95,6 +95,14 @@ static void raspi_peripherals_base_init(Object *obj)
     /* SYS Timer */
     object_initialize_child(obj, "systimer", &s->systmr,
                             TYPE_BCM2835_SYSTIMER);
+    /*
+     * One splitter per system-timer interrupt line so that each interrupt
+     * reaches both the legacy controller and the GIC.
+     */
+    for (int n = 0; n < BCM2835_SYSTIMER_COUNT; n++) {
+        object_initialize_child(obj, "systmr-irq-splitter[*]",
+                                &s->systmr_irq_splitter[n], TYPE_SPLIT_IRQ);
+    }
 
     /* UART0 */
     object_initialize_child(obj, "uart0", &s->uart0, TYPE_PL011);
@@ -304,18 +312,19 @@ void bcm_soc_peripherals_common_realize(DeviceState *dev, Error **errp)
     }
     memory_region_add_subregion(&s->peri_mr, ST_OFFSET,
                 sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->systmr), 0));
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->systmr), 0,
-        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
-                               INTERRUPT_TIMER0));
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->systmr), 1,
-        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
-                               INTERRUPT_TIMER1));
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->systmr), 2,
-        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
-                               INTERRUPT_TIMER2));
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->systmr), 3,
-        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
-                               INTERRUPT_TIMER3));
+    for (n = 0; n < BCM2835_SYSTIMER_COUNT; n++) {
+        qdev_prop_set_uint32(DEVICE(&s->systmr_irq_splitter[n]),
+                "num-lines", 2);
+        if (!qdev_realize(DEVICE(&s->systmr_irq_splitter[n]), NULL, errp)) {
+            return;
+        }
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->systmr), n,
+                qdev_get_gpio_in(DEVICE(&s->systmr_irq_splitter[n]), 0));
+        qdev_connect_gpio_out(DEVICE(&s->systmr_irq_splitter[n]), 0,
+                qdev_get_gpio_in_named(DEVICE(&s->ic),
+                    BCM2835_IC_GPU_IRQ,
+                    INTERRUPT_TIMER0 + n));
+    }
 
     /* UART0 */
     qdev_prop_set_chr(DEVICE(&s->uart0), "chardev", serial_hd(0));
diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
index 1bde9e68af9..a88d750f76b 100644
--- a/hw/arm/bcm2838.c
+++ b/hw/arm/bcm2838.c
@@ -192,6 +192,13 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
     qdev_connect_gpio_out(DEVICE(&ps_base->spi_irq_splitter), 1,
                           qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_SPI));
 
+    /* Connect the system timer interrupts to the interrupt controller */
+    for (int n = 0; n < BCM2835_SYSTIMER_COUNT; n++) {
+        int int_n = GIC_SPI_INTERRUPT_SYS_TIMER0 + n;
+        qdev_connect_gpio_out(DEVICE(&ps_base->systmr_irq_splitter[n]), 1,
+                              qdev_get_gpio_in(gicdev, int_n));
+    }
+
     /* Connect VC mailbox to the interrupt controller */
     sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->mboxes), 0,
                        qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_MBOX));
-- 
2.43.0


