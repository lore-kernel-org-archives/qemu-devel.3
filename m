Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D2360A6F47
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ca2PjarP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTOut-0007Tu-2M; Tue, 17 Nov 2026 14:32:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agarwaljayesh03@gmail.com>)
 id 1xTOup-0007So-JX
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:32:28 -0500
Received: from mail-dl1-x1230.google.com ([2607:f8b0:4864:20::1230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <agarwaljayesh03@gmail.com>)
 id 1xTOun-0002QN-NA
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:32:27 -0500
Received: by mail-dl1-x1230.google.com with SMTP id
 a92af1059eb24-18818daa3e7so728969c88.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 11:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794943944; x=1795548744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HmYnR1KqHS4CMsKPXreIVS5wq+3xL0tziKeOsDFzLQs=;
 b=Ca2PjarPTddhWO8yec2GoDIUl3jmKEKE1RdNz9s/DEBKxkBBqAYUrFQHRbyp5RmNzo
 Sxkg9ICI3yBogQv06mVOq3hJvtAwxMF4eMbJz4UNAG+0IAAaIVUURL+uKIFxWJct1sYx
 ZVmJcs9kM5SgLfMVewfaGpiPaH+v2X9a0wRjyjVSfFQMR8xY2XN2gy0Q+PKI+hS0lUkP
 Owdo/uTBMCw6tS0ZgJ18w8fI7AH8mp5xv3/GBS7feuYh4gq6+uZWU30D7K4fbFghSk7I
 GiSpwKIR/hsnv0kX8fqgXe4YBzM0GFsQMUCr7dfqcRuKYUzhEHhGX6cY/f8CCoEkAOFP
 EYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794943944; x=1795548744;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HmYnR1KqHS4CMsKPXreIVS5wq+3xL0tziKeOsDFzLQs=;
 b=PCzrJlGKiTlwUWF3HRQPK5Ikn2gdXKW69Uu0fHdHHvqZjXb6Ekz51yT4kcEAE1OhdC
 wm/OhA4Qn92crWpbxtxMh0iKzVrULehAqBNuszfnBO+Dm185Wh3klH2kdXyJE5zATSl6
 h5QdH64fdHvjHfPDAeMrotUHmcsdOvpm2d0IihTzJi4tNpeZjg6RvXfec0ffkHbY+CjH
 71HHUQVVrxo731jHr7v4sUeddmBcCEJa8cqGVKDXFTi6qmeLuCOhg1F9Be2pNjIi1Hlm
 Cd6hqusX1XgpuYk12ws3ypKXCSVNqH88mEH/qwnjAHrDGEVvxcpE9jBSSRvf+7f+KXt3
 hHgg==
X-Gm-Message-State: APuU4Z+3Yux9YnHt1kUaSOwmOUIx8sF7xD4B0UVUAA33hPoaxRtipNpW
 LGU3v5hKrd5yxSqE8GBV1J6t/ikAn0Mf+sL29NyFHLOR4Um2UByidpvdkfmhVltw
X-Gm-Gg: AYBFou1FyG3OvZtYUPi+YGh+mWqUN1rsVeNQ2FZI8LTD5bX9RCUTt1/3YJRXXdY1n/n
 y6FiId7H7HGGeAr2MEGl/v8GvpZ8WeHBQJ1kIpsuwO67tWYfxI29b8yemwLeDLIhnis2yz6bWZB
 eGqhNFtn+GPgXtVV0+mapCsPgD9gnB0r7euC35/NbSvrl/z7zOfYuXPRRLYsp6gYADecpHxs2P3
 H3PCe6aqh/36S8ak/wQN76H/0CrDPrrnW/AT5kRFESMuD/IZwt+c/My0/JtoTdf5EHbIVTqP5U8
 j9q8n2++u4OXuKkhcieaUgRxUvy+tIvFWnrZbVRSwM0Mh072/tu1vFFWzS/E7L+oJvgsLf0v8eE
 hF0826gO5bE2WhSs+M4yui00HvtgEB0Ds4Z5+hu/x4w0f+duTunObmbYuLGYfe/TlwV2PMBaHdP
 CWKA7tXyqjXllD4U+kqDtdt1mgrG4fH0MxZdJvqtK4jAzaNA6rkAt0uYekx96sYMjymtJNr3yXh
 A1Cym//TCc1mihg2+DBec6doIClpFqNvfQlEvLrgF4xxmmSJe1ZT9szvOKjXfF6Lt8dVGHmC/VH
 +40Dpl5Zo9pGmsq31XqXrXyojPzP8vKw8pBL/tAngTTgmoOLT1ymXyguLf1OYvjC7gt4jUyDWUl
 Q3X3KOmNejg==
X-Received: by 2002:a05:701b:4586:20b0:1ab:cbd0:1c96 with SMTP id
 a92af1059eb24-1b53a429876mr2719513c88.4.1794943943468; 
 Tue, 17 Nov 2026 11:32:23 -0800 (PST)
Received: from LinuxMachine.bits-hyderabad.ac.in ([14.98.244.195])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-382a45274aesm159132eec.2.2026.11.17.11.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 11:32:22 -0800 (PST)
From: Jayesh Agarwal <agarwaljayesh03@gmail.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@oss.qualcomm.com, qemu-arm@nongnu.org,
 s23adhik@csclub.uwaterloo.ca, Jayesh Agarwal <agarwaljayesh03@gmail.com>
Subject: [PATCH] hw/arm/bcm2838: Route system timer interrupts to GIC
Date: Wed, 18 Nov 2026 01:02:05 +0530
Message-ID: <20261117193205.8236-1-agarwaljayesh03@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1230;
 envelope-from=agarwaljayesh03@gmail.com; helo=mail-dl1-x1230.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jayesh Agarwal <agarwaljayesh03@gmail.com>
---
This was picked up from Sourojeet's earlier patch, here is the link:
https://lore.kernel.org/qemu-devel/3cca4eb3-09d1-4467-81fd-27a5bfe19a3e@csclub.uwaterloo.ca/

 hw/arm/bcm2835_peripherals.c         | 33 ++++++++++++++++++----------
 hw/arm/bcm2838.c                     |  7 ++++++
 include/hw/arm/bcm2835_peripherals.h |  1 +
 include/hw/arm/bcm2838_peripherals.h |  4 ++++
 4 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 558c180df9..f619beba33 100644
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
@@ -302,18 +310,19 @@ void bcm_soc_peripherals_common_realize(DeviceState *dev, Error **errp)
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
index 650b1fe8f4..d151c50f1e 100644
--- a/hw/arm/bcm2838.c
+++ b/hw/arm/bcm2838.c
@@ -188,6 +188,13 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
     qdev_connect_gpio_out(DEVICE(&ps_base->orgated_i2c_irq_splitter), 1,
                           qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_I2C));
 
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
diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index 4f356f4643..bd41e0de92 100644
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
index 60bfacdce4..af2d3b2030 100644
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
-- 
2.43.0


