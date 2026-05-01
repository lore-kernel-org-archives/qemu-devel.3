Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C369FF885A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 10:16:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIktw-0003ux-ET; Fri, 01 May 2026 06:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIktu-0003uP-LA
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:14 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIkts-0008Gu-Rd
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:14 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so23183655e9.0
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 03:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777630511; x=1778235311; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jvzQsyH9P5JY6kgKUh6A4LpYKgME6BJ8LWqJR3cPdb8=;
 b=xejwSFayji9UcxSpkowj7symuXRb8Iyk/5nmc3bKye6l2YmiQwKvtkW+0r2vHdGVxE
 1mtxY5BtYfleEuoXN/3cqmdeSK17PUbAsakhBhOMb9Ta++76iExc6uCA3GGoifnr0j01
 +V8cY4U9CxeTDMILxpk1Ep1HNkse7qS+CJ30nH+J5xESay81WBMvpHU/iu1556lMB7lq
 ad0i5BsXIRQ7e2I1mB8V6ME89aWdxGV62Q9YVNxuyVT2hNKJRgF67xWCjyLa5hluDR2A
 rh5srxIJKHznLvwxji+hAOM5YTluRTIXR6mZhEMUb5TXb99t9jZ+Ar8VJK8slltinjSa
 hSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777630511; x=1778235311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jvzQsyH9P5JY6kgKUh6A4LpYKgME6BJ8LWqJR3cPdb8=;
 b=HynQ2vaZRBQvKy8s2CVHLaE7eKoqW3K602WGTPIc9XjjfeZb7n+P71/C1Be58MK88N
 tK3JW38/vkcKsW54+PDVB5i9LZ6GxNU4u7SD8V5XXOLcoyMy681EDF8uqvMfIKoMPHBs
 jI4JRC66lHyDKg/jZasf/cZyP1UrFESNcyjcY3fVYSB73uUHo9xvQNdWzTKyk1xFCajf
 w0MHmBhAdONc0y7yKu8Wl2fVF/L3y28F8zpAMYfEq/HweguJPVn+gIbcPRqV69KodeiZ
 uo7eirL4RLRWmJyFtqmvQ5FXyqNd0AMF85crZ894tx8CfIdIp5uD2gICeloVVlfI9sGS
 x5Bg==
X-Gm-Message-State: AOJu0YzON5H+uZzHIorQTNkBvJKqv/sph5J4RVpi5jkQVBAHGtlSc19+
 BfXBa3AuaoAwRuukMQsBN4ssVZoqEYHJqV+moO60+U0jTOxN1ZLWz+BYHmkat/CYemSGL7jpG/T
 ecFrM
X-Gm-Gg: AeBDietIc9hE/nd6cR8Ezx7Wr9yEcLHIrHuvM3ALyvVScyFY7KroDUtQhFXYrY+1ih6
 PbddjBdqVqtKtZ7dKojKJuKNYAO3Ngs6ulihkB2wBKgtkfkcu2WwOPFqmYQXHj4GI+hwpKLsOYY
 iSS44Cjrn+e8VqYcFWrtZXhz2A49HTNTMIpsl9PV7fNZmt8do1ctCGt0QakVY+5M6DAIRGdU1YG
 TpFP8tjcv/dFmJ5t+lHEu7R9Fyx821EluLok6rBCoMWzvuZAWTRK1fz1sCMy742P8XM2yoUD/ug
 ZiMK8Z6gB+C6nL8rEC7TqVuDpwEQGtTkwf0U/KLtSHyIdr29MpB0PECqOzJyLW4XYdjiEKnQQuw
 rn6767dlVzLEyU5zLXKMsYb6TVbiFlv6/b31h2ugZpizTIMXW0r8OfgkX/q2P/dUvwBAHQwq/vJ
 oiGTpjM6NbSmEEi4n0QEcXIsXa4Rs6CW+epRf+P3AVSHezRA3HmiZzM+dZZ41mpx7LX2gqd9McE
 AzC+ThrApFUeJQIl19GMzAHB//NFXKdmQO7yoDCWg==
X-Received: by 2002:a05:600c:c108:b0:485:40db:d40c with SMTP id
 5b1f17b1804b1-48a8eb61ddfmr26694415e9.3.1777630510661; 
 Fri, 01 May 2026 03:15:10 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8fede418sm12863335e9.6.2026.05.01.03.15.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 03:15:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/28] Revert "sysbus: add irq_routing_notifier"
Date: Fri,  1 May 2026 11:14:40 +0100
Message-ID: <20260501101505.3485916-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501101505.3485916-1-peter.maydell@linaro.org>
References: <20260501101505.3485916-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

The callback has been introduced in commit 715ca691daca ("sysbus: add
irq_routing_notifier") for use in VFIO platform. Meanwhile, VFIO
platform has been removed via commit 762c85543948 ("vfio: Remove 'vfio-
platform'") which was its only user. Remove this unused code.

This reverts commit 715ca691daca081108b33306faa6fa102f0df8d8.

cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-id: 20260308203516.160103-6-shentey@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/core/sysbus.c         | 6 ------
 include/hw/core/sysbus.h | 1 -
 2 files changed, 7 deletions(-)

diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 3adf2f2faf..3e1160ee92 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -104,13 +104,7 @@ qemu_irq sysbus_get_connected_irq(const SysBusDevice *dev, int n)
 
 void sysbus_connect_irq(SysBusDevice *dev, int n, qemu_irq irq)
 {
-    SysBusDeviceClass *sbd = SYS_BUS_DEVICE_GET_CLASS(dev);
-
     qdev_connect_gpio_out_named(DEVICE(dev), SYSBUS_DEVICE_GPIO_IRQ, n, irq);
-
-    if (sbd->connect_irq_notifier) {
-        sbd->connect_irq_notifier(dev, irq);
-    }
 }
 
 /* Check whether an MMIO region exists */
diff --git a/include/hw/core/sysbus.h b/include/hw/core/sysbus.h
index c0d18d9e00..f3c4259d29 100644
--- a/include/hw/core/sysbus.h
+++ b/include/hw/core/sysbus.h
@@ -50,7 +50,6 @@ struct SysBusDeviceClass {
      * omitted then. (This is not considered a fatal error.)
      */
     char *(*explicit_ofw_unit_address)(const SysBusDevice *dev);
-    void (*connect_irq_notifier)(SysBusDevice *dev, qemu_irq irq);
 };
 
 struct SysBusDevice {
-- 
2.43.0


