Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6A0C02185
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 08:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta9sj-0002f6-AU; Tue, 21 Jan 2025 03:45:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ta9sh-0002et-Nd
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 03:45:07 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ta9sf-0004X1-HZ
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 03:45:07 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so61363725e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 00:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737449103; x=1738053903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O9Odkfv+T0SBkcj1j7P4mQ5s3sBRtwgNR1LFLkXVhUw=;
 b=nwUvLYQ8Fhlmkn75EC0L6XSjr6zp+jIiY+epgr3uwGMrf+43/0mKb3d4VntF+nCXpf
 VZKTetFlsOkccbdOkiaJfLTjH0d3Q37xA6iENIbvNDF1nX3ploVJSLVLLW19IKDuaDXv
 BvtDMitAyOC9uUqQqquvrTWNvnT2mxhzggKMs4eIN5m73HR5FZuQwnTDUIrc0FNsx0Dq
 4WwPQZnO+famBe4+C3O782kfVjtItYVObhJ8TLUeaRjmVIpZtCTqa/PlA9fQTZfBIjzG
 cGVYsHg5hmq/Pjs9xALdBSZ/JtvM/vMNZYt29/GwFfDc2QOJP9z5METKFXczHwDQA7Gp
 +oiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737449103; x=1738053903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O9Odkfv+T0SBkcj1j7P4mQ5s3sBRtwgNR1LFLkXVhUw=;
 b=snlxwwvxkRSdoVbULKxxeXEgEqNYOeRA7wswUDjYG1e+oPFzwsZLczaTt+yIzIST4g
 reee5jH6iT7qODGpuMnJSYb4CJmlX4WCYjfT1c6wRcEhppt+3LHvnI+e2+y2EKvXhcKQ
 u5wNojU4fT1pFvwIDhwolNiYV2P1Lzj4w2Wc4+K9sr1KoDPcuJIxrIBK1upWkSWEa5go
 MHc1m90qY3KEs5dzFrSS+MGYxgIVya0g2XQRwoG7DJ6SZrAK4GtavCemvm8Nqe2LfILT
 HTI2OCIsTKo/32759pjdGgxr6fmIpD5e3ei1i85FMXJkIDFN2d+g8N5Lp+QwnuBsJoPz
 AEFg==
X-Gm-Message-State: AOJu0YxC3V8RoyzuojH3sk9DDpsDia0kr7hu0DxXyOMf04hlVn6ImZor
 gMWWAaIxUAy3o5kR1z/iJGbpMSOc3nUuYydifwoZ1VxjdKX8bF0tY9SgovDlMLkcHujRitCnUTJ
 refI=
X-Gm-Gg: ASbGncvhczsZv5I7dyAjv36Jxfz3tt9QENNJp3IqRlgt/N/QHPJpS9EJOH4UGsCWq1r
 ilGSf5mpLHnMImmEiTszO9LJ5iGdTVtUT2cGV1VFWFumJderwJqSqiGcdOW9/qlnmYIZqxbP33A
 KL6BMOw7TOuFLLY9dSGM3WgdMUT/IEVKCbZNVsHr16pb5yKUhvuDE3BOwdDT66kMjOF/LDP30C5
 rjlet0fitTVrv36dDgj02RE3mePUrjy0IGMkUA+HQhcNojOKUveAh2GbuVfGO8Jhs+aWmiNdbPv
 p9sIoVU1GH+zKOpeke1olOj+1gOb8Ywv24pyCu9SsXB4
X-Google-Smtp-Source: AGHT+IEY6xw4OjY6ogtTXo+XUbqHVwYkQ6+X/EicVa+fgx2qsNOEscPOL/zXzJc9nZyvtsHwLa+hyg==
X-Received: by 2002:a05:600c:1d1d:b0:434:a815:2b5d with SMTP id
 5b1f17b1804b1-4389141c211mr130228225e9.24.1737449103567; 
 Tue, 21 Jan 2025 00:45:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7499821sm230496135e9.2.2025.01.21.00.45.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 00:45:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/2] hw/ipack: Remove legacy qemu_allocate_irqs() use
Date: Tue, 21 Jan 2025 09:44:52 +0100
Message-ID: <20250121084452.81941-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121084452.81941-1-philmd@linaro.org>
References: <20250121084452.81941-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
---
 include/hw/ipack/ipack.h | 7 ++-----
 hw/char/ipoctal232.c     | 4 ++--
 hw/ipack/ipack.c         | 7 +++----
 hw/ipack/tpci200.c       | 6 +++---
 4 files changed, 10 insertions(+), 14 deletions(-)

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
index ed75f791832..eeb48dd331c 100644
--- a/hw/ipack/ipack.c
+++ b/hw/ipack/ipack.c
@@ -55,22 +55,21 @@ static void ipack_device_realize(DeviceState *dev, Error **errp)
     }
     bus->free_slot = idev->slot + 1;
 
-    idev->irq = qemu_allocate_irqs(bus->set_irq, idev, 2);
+    for (int i = 0; i < ARRAY_SIZE(idev->irq); i++) {
+        qemu_init_irq(&idev->irq[i], bus->set_irq, idev, i);
+    }
 
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


