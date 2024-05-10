Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701B6C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 14:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5R4I-0006uu-S9; Fri, 10 May 2024 10:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1s5R4G-0006tn-Qc; Fri, 10 May 2024 10:17:48 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1s5R4E-0001Sz-Ig; Fri, 10 May 2024 10:17:48 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a59ab4f60a6so464540366b.0; 
 Fri, 10 May 2024 07:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715350664; x=1715955464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/QJTpK5sg88UhGs/NKN8PlzaLghfj83OQw0oUqUPB0U=;
 b=nUuRBq/lMsssgKu5AURlgJOhZ19xDafbUl2s19IQjB4IY0tPPXnRZg8xFk+VN0AFse
 LWrxhnU5zZ0KvBPZxkJ8UDma+36dJrnsVEK5mF6u95PoXq6pu4FcEn4jihIkEEBM9EUJ
 924nA6RqpaodeTz799jGAQ2+rzZyK89vVR6Iavsv/UIwU7dgEtY7Fh2DbigspLB5VXTV
 3W9QSfO9PzCGqe8VeHQUx6PbvMwAa7y6XazqZ+SLSvzAwCK4c4/BNGNi2zn0UBFNB3S2
 r65mdSZM+Vfr/lfDOkQDNR5NCAfJxKlxP1celxTvE+Bv5snJlhI2fojUllB8kOTAy8/W
 9EqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715350664; x=1715955464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/QJTpK5sg88UhGs/NKN8PlzaLghfj83OQw0oUqUPB0U=;
 b=pCgWQeNjwO/IPTvJfgf5InPEauXlEXO/kQixjqnTOu/ABXnQzJeHMxwoVPVV8c0h1z
 VpDR8ZWfts2+pB3zS+l+kT1GAY+0r5BrmmSQKGvtHa4uv1Q/S+J6R6R6l3xm/hYVbvpj
 KKk9vnmhfXoemU+TJlFunTnU5S9mp/QHgnalt1kBd2qVXM0AKkjJLPaSiz0PjesWKDDI
 nvh7O5Rkbhbyd3jqS+xASFqZYvO1yDBaxzkZjD9ptNSKZwtladcqChmaDMB5JIVsxD+U
 g5IMfSZsf1jBsm52H1TAxP5dbY7u5KUf349GwxmEJZGDYqgjFaOueyH4h1E2WDLzP18F
 S5BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz/eFva683RSwy2947wljiqVgDbCiDdU7yEPKnBBJUF8a7hPg2trKg1eTXDI5bUmNM1mZuQQyO8Ab78yOPPz5NAjF3
X-Gm-Message-State: AOJu0YxfVanwhVQ7l2fBEtEdj7nq9FB5OLzfElTrwD9FSVtQnvDEmSWY
 G8KwZGeP95+pJzNl+aN80L5PsmX7u//3h298WFgmh0BvMRGomX4ZrLVChw==
X-Google-Smtp-Source: AGHT+IFgHgoroFxgpNwu6AAwABpFYOhUJXePt0GzToVqBYft/DdIy2wtc8Uk+9VIk8sWJrlCNSlcsw==
X-Received: by 2002:a17:906:3809:b0:a59:a05c:b553 with SMTP id
 a640c23a62f3a-a5a2d572471mr293679366b.17.1715350664618; 
 Fri, 10 May 2024 07:17:44 -0700 (PDT)
Received: from localhost.localdomain ([212.70.119.83])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17891f6esm190093466b.54.2024.05.10.07.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 May 2024 07:17:44 -0700 (PDT)
From: Rayhan Faizel <rayhan.faizel@gmail.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 Rayhan Faizel <rayhan.faizel@gmail.com>
Subject: [PATCH 2/3] hw/arm: Connect OTP device to BCM2835
Date: Fri, 10 May 2024 19:40:09 +0530
Message-Id: <20240510141010.656561-3-rayhan.faizel@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510141010.656561-1-rayhan.faizel@gmail.com>
References: <20240510141010.656561-1-rayhan.faizel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=rayhan.faizel@gmail.com; helo=mail-ej1-x62c.google.com
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

Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
---
 hw/arm/bcm2835_peripherals.c         | 13 ++++++++++++-
 include/hw/arm/bcm2835_peripherals.h |  3 ++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 1695d8b453..7d735bb56c 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -116,6 +116,10 @@ static void raspi_peripherals_base_init(Object *obj)
     object_property_add_const_link(OBJECT(&s->fb), "dma-mr",
                                    OBJECT(&s->gpu_bus_mr));
 
+    /* OTP */
+    object_initialize_child(obj, "bcm2835-otp", &s->otp,
+                            TYPE_BCM2835_OTP);
+
     /* Property channel */
     object_initialize_child(obj, "property", &s->property,
                             TYPE_BCM2835_PROPERTY);
@@ -374,6 +378,14 @@ void bcm_soc_peripherals_common_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->fb), 0,
                        qdev_get_gpio_in(DEVICE(&s->mboxes), MBOX_CHAN_FB));
 
+    /* OTP */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->otp), errp)) {
+        return;
+    }
+
+    memory_region_add_subregion(&s->peri_mr, OTP_OFFSET,
+                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->otp), 0));
+
     /* Property channel */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->property), errp)) {
         return;
@@ -500,7 +512,6 @@ void bcm_soc_peripherals_common_realize(DeviceState *dev, Error **errp)
     create_unimp(s, &s->i2s, "bcm2835-i2s", I2S_OFFSET, 0x100);
     create_unimp(s, &s->smi, "bcm2835-smi", SMI_OFFSET, 0x100);
     create_unimp(s, &s->bscsl, "bcm2835-spis", BSC_SL_OFFSET, 0x100);
-    create_unimp(s, &s->otp, "bcm2835-otp", OTP_OFFSET, 0x80);
     create_unimp(s, &s->dbus, "bcm2835-dbus", DBUS_OFFSET, 0x8000);
     create_unimp(s, &s->ave0, "bcm2835-ave0", AVE0_OFFSET, 0x8000);
     create_unimp(s, &s->v3d, "bcm2835-v3d", V3D_OFFSET, 0x1000);
diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index 636203baa5..1eeaeec9e0 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -33,6 +33,7 @@
 #include "hw/usb/hcd-dwc2.h"
 #include "hw/ssi/bcm2835_spi.h"
 #include "hw/i2c/bcm2835_i2c.h"
+#include "hw/nvram/bcm2835_otp.h"
 #include "hw/misc/unimp.h"
 #include "qom/object.h"
 
@@ -71,7 +72,7 @@ struct BCMSocPeripheralBaseState {
     BCM2835SPIState spi[1];
     BCM2835I2CState i2c[3];
     OrIRQState orgated_i2c_irq;
-    UnimplementedDeviceState otp;
+    BCM2835OTPState otp;
     UnimplementedDeviceState dbus;
     UnimplementedDeviceState ave0;
     UnimplementedDeviceState v3d;
-- 
2.34.1


