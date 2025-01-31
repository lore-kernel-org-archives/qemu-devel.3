Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293F8C02194
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyDq-0007b0-Is; Fri, 31 Jan 2025 16:06:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyDo-0007OB-AK
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:06:40 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyDm-0007sU-Ln
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:06:40 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so29122625e9.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738357596; x=1738962396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rqI9LRvktHJX4HtGOA/1PZYCP3HIyYy2w16C7Qz7++g=;
 b=xTX9GH+SuP4fZoAVIFyG9oywBY1rgpNQZd6hhbrTHZzx0oML5+trmEJk3o3jwR9M0n
 4atxJfYz6UC1dRD1zb1c1cHp9iXD9rvQ9sevYkAj45Q3HKbR0Kc3RTw42K8VDNDTXHxd
 nM3BBz8PvD6oAGdOgTo9oGOkafWEAq65RzhDmQbH/a0sGBj+aWvoORsaPFyd6mwBjmw2
 6EhTHaghrshloyFtjpzXb+ag4FK62eD404ruNDgXNhTyhBUBHSc+SJqv2q3hYqJi9Esz
 GDJg0CfOfIBCUvYB0hOVtgawKlpoZco8zoEDH/2IS5LFV29LZUR/D7m8lC84QNn1eGoS
 pk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357596; x=1738962396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rqI9LRvktHJX4HtGOA/1PZYCP3HIyYy2w16C7Qz7++g=;
 b=q8gbxOsLSfkjKDfhrPYNHNMUG8qy+soY7AGQrDj2B58xLFmVfh1ZP4/u0gtOJTD36i
 JnYobXU/R3oNkmEDv5Gizf+rvbJogfqppsHJ4Chbnd7oScqNGLBFwwmgHOsC2WhHs4qH
 YuNOEFPZN7UIlkmz98M17OLBoX24Acht7Td4bVJXxnfWWu/V2IUCSFUyRtqUQ+cOtMLy
 5W7Hb2hBqjp7Vzs/a9bA3/90wGrh1/Pse3lYLmxWvLlABHC1y1htA/spVOOFSPKIDeMt
 Cx/YYAZNuFMp0pYJq/ClOFWyVjGjf7ZqOlVZ3u6yMKvJR8Y/9E7YONtpcNjBCBBdO5oy
 k4xQ==
X-Gm-Message-State: AOJu0YwPfWC5BjNFSD8uHUN7OTsu9tinYoustBcIcGE8l9SVrsmTcnGO
 t1/IOI0R2IaX82LqH+lG/6+0lp6YpsXAgGaAcQByJy0GteJF5fOv3SWJr3ECmBVs7lVkF7GoEfx
 n8t8=
X-Gm-Gg: ASbGnctxmaDDgT7yGjiLRiLpfZyQ61EjLdzrZgrEPGx8k4PWGgbkZU7TIUunHSiPbsd
 YvBo+FBFuJjdUak4g909mSeXX/RfHLqtbvJohKSCL4PMRU4ocstvechuSsttByVTpcH7yMdXz0m
 SaIpu8b6E5zMoPzfZ1FN3kAYF6aewe/WxrTQtKk+mhp/03GAdiaNIrxdqZv+PrODZXssIsH8YYk
 MARg7EnSOR6QSsNiM3SyvI2/hrHLRAh/zS3PmU5BG9wR56UW5xlUl7ijQnLFQObhxY+32ZytC+Y
 2/4wmvvj0KqaAn4Y1+Uh9Y7eFxWrIH3PdWMIMs3SlQyXeblnWtA0/hEmF8fO8/hd2g==
X-Google-Smtp-Source: AGHT+IE2UO3ZMofqihRMOa2Uoaqkcz7qTzdy+D6/6EBnsZqqnhVkX9oEh2+dPVQxFb8rkSShoEZ2Tg==
X-Received: by 2002:a05:600c:1e02:b0:434:a802:e9a6 with SMTP id
 5b1f17b1804b1-438dc3c22acmr146724755e9.7.1738357596422; 
 Fri, 31 Jan 2025 13:06:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc2e239sm100944485e9.18.2025.01.31.13.06.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Jan 2025 13:06:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 15/36] hw/ipack: Remove legacy qemu_allocate_irqs() use
Date: Fri, 31 Jan 2025 22:04:58 +0100
Message-ID: <20250131210520.85874-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131210520.85874-1-philmd@linaro.org>
References: <20250131210520.85874-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

No need to dynamically allocate IRQ when we know before hands
how many we'll use. Declare the 2 of them in IPackDevice state
and initialize them in the DeviceRealize handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250121155526.29982-4-philmd@linaro.org>
---
 include/hw/ipack/ipack.h | 7 ++-----
 hw/char/ipoctal232.c     | 4 ++--
 hw/ipack/ipack.c         | 5 +----
 hw/ipack/tpci200.c       | 6 +++---
 4 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/include/hw/ipack/ipack.h b/include/hw/ipack/ipack.h
index cbcdda509d3..00f397fd020 100644
--- a/include/hw/ipack/ipack.h
+++ b/include/hw/ipack/ipack.h
@@ -12,6 +12,7 @@
 #define QEMU_IPACK_H
 
 #include "hw/qdev-core.h"
+#include "hw/irq.h"
 #include "qom/object.h"
 
 
@@ -19,10 +20,8 @@
 OBJECT_DECLARE_SIMPLE_TYPE(IPackBus, IPACK_BUS)
 
 struct IPackBus {
-    /*< private >*/
     BusState parent_obj;
 
-    /* All fields are private */
     uint8_t n_slots;
     uint8_t free_slot;
     qemu_irq_handler set_irq;
@@ -58,13 +57,11 @@ struct IPackDeviceClass {
 };
 
 struct IPackDevice {
-    /*< private >*/
     DeviceState parent_obj;
-    /*< public >*/
 
     int32_t slot;
     /* IRQ objects for the IndustryPack INT0# and INT1# */
-    qemu_irq *irq;
+    IRQState irq[2];
 };
 
 extern const VMStateDescription vmstate_ipack_device;
diff --git a/hw/char/ipoctal232.c b/hw/char/ipoctal232.c
index d1e5f6dad2e..a2879977fb3 100644
--- a/hw/char/ipoctal232.c
+++ b/hw/char/ipoctal232.c
@@ -184,9 +184,9 @@ static void update_irq(IPOctalState *dev, unsigned block)
     unsigned intno = block / 2;
 
     if ((blk0->isr & blk0->imr) || (blk1->isr & blk1->imr)) {
-        qemu_irq_raise(idev->irq[intno]);
+        qemu_irq_raise(&idev->irq[intno]);
     } else {
-        qemu_irq_lower(idev->irq[intno]);
+        qemu_irq_lower(&idev->irq[intno]);
     }
 }
 
diff --git a/hw/ipack/ipack.c b/hw/ipack/ipack.c
index ed75f791832..b6defae6025 100644
--- a/hw/ipack/ipack.c
+++ b/hw/ipack/ipack.c
@@ -55,22 +55,19 @@ static void ipack_device_realize(DeviceState *dev, Error **errp)
     }
     bus->free_slot = idev->slot + 1;
 
-    idev->irq = qemu_allocate_irqs(bus->set_irq, idev, 2);
+    qemu_init_irqs(idev->irq, ARRAY_SIZE(idev->irq), bus->set_irq, idev);
 
     k->realize(dev, errp);
 }
 
 static void ipack_device_unrealize(DeviceState *dev)
 {
-    IPackDevice *idev = IPACK_DEVICE(dev);
     IPackDeviceClass *k = IPACK_DEVICE_GET_CLASS(dev);
 
     if (k->unrealize) {
         k->unrealize(dev);
         return;
     }
-
-    qemu_free_irqs(idev->irq, 2);
 }
 
 static const Property ipack_device_props[] = {
diff --git a/hw/ipack/tpci200.c b/hw/ipack/tpci200.c
index 88eef4b8308..470a4203ae4 100644
--- a/hw/ipack/tpci200.c
+++ b/hw/ipack/tpci200.c
@@ -275,11 +275,11 @@ static void tpci200_write_las0(void *opaque, hwaddr addr, uint64_t val,
                 if (ip != NULL) {
                     if (val & STATUS_INT(i, 0)) {
                         DPRINTF("Clear IP %c INT0# status\n", 'A' + i);
-                        qemu_irq_lower(ip->irq[0]);
+                        qemu_irq_lower(&ip->irq[0]);
                     }
                     if (val & STATUS_INT(i, 1)) {
                         DPRINTF("Clear IP %c INT1# status\n", 'A' + i);
-                        qemu_irq_lower(ip->irq[1]);
+                        qemu_irq_lower(&ip->irq[1]);
                     }
                 }
 
@@ -344,7 +344,7 @@ static uint64_t tpci200_read_las1(void *opaque, hwaddr addr, unsigned size)
                 bool int_set = s->status & STATUS_INT(ip_n, intno);
                 bool int_edge_sensitive = s->ctrl[ip_n] & CTRL_INT_EDGE(intno);
                 if (int_set && !int_edge_sensitive) {
-                    qemu_irq_lower(ip->irq[intno]);
+                    qemu_irq_lower(&ip->irq[intno]);
                 }
             }
 
-- 
2.47.1


