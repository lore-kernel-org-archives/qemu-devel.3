Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF73606A8A0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pAsVYxer
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSueO-0003qL-Jk; Mon, 16 Nov 2026 06:13:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueE-0003ow-OZ
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:19 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueB-00027k-I1
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:18 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48fd2e38825so2074335f8f.2
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 03:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794827588; x=1795432388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5rBiFwwMVmpfqyc5w3Wjsy/YNwNF2ZPWBBCtGodzQgA=;
 b=pAsVYxeradEM3CNCBVrwvXEWgpaMICqsLSWmWiP1cQa8MuvldEGdfkVbmmYbMo5XhT
 MnmIfLLG+96P8fQZpFV60oZOGEDyVf7yPr/eF6nmZFo9R+2oA8MTBaBGrQTGJWaPjR7N
 E3BEvQ7niwjlhvdaclDzAHc3705JQCVnPKsmWQDnltVS5G6IniyPAfyuGFXmDHVDZ+uC
 bgeA0QQcqyIoAwKKd2dIsOFfsxNr4xUZlTNcd9mdu2iSyxR+gEn979yDV4YFvDSHSlKZ
 /Z7tLmfx0lKGFo6y1X2AaTGZQTr8iYW50Y8Vcf0YXf2pbed1cqnxHs31JHCvxKH8F6IM
 O6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794827588; x=1795432388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5rBiFwwMVmpfqyc5w3Wjsy/YNwNF2ZPWBBCtGodzQgA=;
 b=uGxfp3Y1EGLucugj6YmToBc3ZLI2RISwZNI7nXUKcfPlXMO/b+tHo3y8PA/DyeDjBu
 3kVBIh+CKjVDAIy9+lHxpjBqUf8dYl9Ug8U2xlQ/lh2oMR4ToEks97diDugDDafLf/Xa
 cU2t4pJ/oknaamd1BL0oifKgpWcs+E+A0GpL5d4ct9wGRAHP8pZLN+ukfCRtcH6S+ObT
 8CLC2TAaswAoUgY9sZ6m0uxYChSb9Zmdo6gJzX0J3BE8I17eKrbu+wBvDzMuSbjJ2DPy
 PHoUSblNUnNqN4BX+jeVzGz5VRMxJuyCS8xK5eOfoWGaTh1d4CoQREe+2wwjX0GrGi2+
 qqWA==
X-Gm-Message-State: APuU4Z+7tSJpw8iSF4cHbbUdj+OeypMPrLPLF+4hbRk1MyqmuLN/R8ar
 AkVbA6Q4E86RGf34UUOEW14prhp9hwHaBV7kAHLhN72UlNItp9nJ+hPm+2codVXDVKNTfiHOAoQ
 jM3qqdqs=
X-Gm-Gg: AZFdTZdpsy7bo1X/3n+nK1hMRkH9Bt9T+7PUJekPzvQvl6ugan3il6mI6TKqAlgpZBJ
 FGZm5U5z4jjPVx5HNLpX6hS4s+Gf3kdLd/mMMdw/ydU2hZOiUyDUrIVJydV1PZx36gK4jpeWRpL
 ds3Fd7q6eYXMwvH/A7gCQsZ6OC8o/dcNdAgF39Npkwu27hHs/M/TsTrhBV/FLTGcbilWobWHBVz
 FTPFlGAc3pnCks/KeCeZ2pIw0kvq9nL+SZUGmWEHaNesG4quYVcIkK33BCPln7O5RxoFC6qO4O9
 SfNeiOpZNc4aVLdRWhyinOwfYHBprSM2CKB96iQiD7orN1EiVNfjyOGK2g6RZqVDpuNvNiPgvdU
 3hCvAkaRKvtGytF6ycRhOPkFRZSUN+PctFUDb4UiFqmysqP0FP9wLztKRtBTi/hbExDguukqQgJ
 vh5Vi/adoQEBPGj/V54U6q76yApy1j8c6ALm+6v+WH0hiZK8bC6jMh87B2z/Gt7lB0x/w2Udtay
 0v5zzVZZ19KcKEwHd6pyiQzA0nX/0EPZNgAiFo3vevQ9fWX9BOwV6rUi+YtEPPg4SW3cnJ1eSsP
 532awdlHH38/D5RNzoOvXxx27Z8IABAX3vgXke5rciHz47WWcczJtPT8qOYuQx7EIezMcPOOJdt
 d2222XxnHIcXPfanYBdDGRVI1oRqh1d9FjA==
X-Received: by 2002:a05:6000:4b0b:b0:48e:20f9:8d75 with SMTP id
 ffacd0b85a97d-49c72c9c398mr21246550f8f.48.1794827587675; 
 Mon, 16 Nov 2026 03:13:07 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6d079a2asm19490469f8f.16.2026.11.16.03.13.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:13:06 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/33] hw/arm/bcm2838: Route SPI0 interrupt to GIC
Date: Mon, 16 Nov 2026 11:12:32 +0000
Message-ID: <20261116111303.1692832-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116111303.1692832-1-peter.maydell@linaro.org>
References: <20261116111303.1692832-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Hanyu <hywei737@utexas.edu>

On raspi4b, SPI0's interrupt is connected only to the legacy interrupt
controller. Linux guests whose device trees use the GIC therefore
can't detect an SPI0 interrupt.

This patch adds a two-output IRQ splitter to deliver SPI0's interrupt
to both the legacy controller and GIC SPI 118. This follows commit
fb3e0557a4cb ("hw/arm/bcm2838: Route I2C interrupts to GIC").

Testing

Add these options to the QEMU invocation:

  -device m25p80,bus=spi,drive=flash0 \
  -blockdev node-name=flash0,driver=file,filename=flash.bin

Before the change, probing fails and /proc/mtd contains no devices:

  spi-nor spi0.0: SPI transfer timed out
  spi_master spi0: failed to transfer one message from queue
  spi-nor: probe of spi0.0 failed with error -2

After the change, the flash is detected:

  spi-nor spi0.0: m25p80 (1024 Kbytes)
  # cat /proc/mtd
  dev:    size   erasesize  name
  mtd0: 00100000 00010000 "spi0.0"

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3013
Signed-off-by: Hanyu <hywei737@utexas.edu>
Message-id: 20261109035234.722952-1-hywei787@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/bcm2835_peripherals.h |  1 +
 include/hw/arm/bcm2838_peripherals.h |  1 +
 hw/arm/bcm2835_peripherals.c         | 14 +++++++++++---
 hw/arm/bcm2838.c                     |  4 ++++
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index 4f356f46435..cd66a734e7c 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -71,6 +71,7 @@ struct BCMSocPeripheralBaseState {
     BCM2835SDHostState sdhost;
     UnimplementedDeviceState i2s;
     BCM2835SPIState spi[1];
+    SplitIRQ spi_irq_splitter;
     BCM2835I2CState i2c[3];
     OrIRQState orgated_i2c_irq;
     SplitIRQ orgated_i2c_irq_splitter;
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index 60bfacdce49..f9279daa4d0 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -27,6 +27,7 @@
 #define GIC_SPI_INTERRUPT_DMA_9_10     88
 #define GIC_SPI_INTERRUPT_AUX_UART1    93
 #define GIC_SPI_INTERRUPT_I2C          117
+#define GIC_SPI_INTERRUPT_SPI          118
 #define GIC_SPI_INTERRUPT_SDHOST       120
 #define GIC_SPI_INTERRUPT_UART0        121
 #define GIC_SPI_INTERRUPT_RNG200       125
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 558c180df9f..be40c6b92a4 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -166,6 +166,8 @@ static void raspi_peripherals_base_init(Object *obj)
     /* SPI */
     object_initialize_child(obj, "bcm2835-spi0", &s->spi[0],
                             TYPE_BCM2835_SPI);
+    object_initialize_child(obj, "spi-irq-splitter",
+                            &s->spi_irq_splitter, TYPE_SPLIT_IRQ);
 
     /* I2C */
     object_initialize_child(obj, "bcm2835-i2c0", &s->i2c[0],
@@ -480,10 +482,16 @@ void bcm_soc_peripherals_common_realize(DeviceState *dev, Error **errp)
 
     memory_region_add_subregion(&s->peri_mr, SPI0_OFFSET,
                 sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->spi[0]), 0));
+    qdev_prop_set_uint32(DEVICE(&s->spi_irq_splitter), "num-lines", 2);
+    if (!qdev_realize(DEVICE(&s->spi_irq_splitter), NULL, errp)) {
+        return;
+    }
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi[0]), 0,
-                       qdev_get_gpio_in_named(DEVICE(&s->ic),
-                                              BCM2835_IC_GPU_IRQ,
-                                              INTERRUPT_SPI));
+                       qdev_get_gpio_in(DEVICE(&s->spi_irq_splitter), 0));
+    qdev_connect_gpio_out(DEVICE(&s->spi_irq_splitter), 0,
+                          qdev_get_gpio_in_named(DEVICE(&s->ic),
+                                                 BCM2835_IC_GPU_IRQ,
+                                                 INTERRUPT_SPI));
 
     /* I2C */
     for (n = 0; n < 3; n++) {
diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
index 650b1fe8f44..1bde9e68af9 100644
--- a/hw/arm/bcm2838.c
+++ b/hw/arm/bcm2838.c
@@ -188,6 +188,10 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
     qdev_connect_gpio_out(DEVICE(&ps_base->orgated_i2c_irq_splitter), 1,
                           qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_I2C));
 
+    /* Connect the SPI interrupt to the interrupt controller */
+    qdev_connect_gpio_out(DEVICE(&ps_base->spi_irq_splitter), 1,
+                          qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_SPI));
+
     /* Connect VC mailbox to the interrupt controller */
     sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->mboxes), 0,
                        qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_MBOX));
-- 
2.43.0


