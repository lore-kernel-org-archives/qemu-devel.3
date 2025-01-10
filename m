Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F5F3E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 23:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWO3L-00045P-0Y; Fri, 10 Jan 2025 18:04:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWO3J-00045B-N5
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 18:04:30 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWO3H-0006UE-UN
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 18:04:29 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43635796b48so16555285e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 15:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736550266; x=1737155066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Muk3Xr8MIihrIrbDkjhh00FHcA0k7qw08J1GSh04wv4=;
 b=AeunHivgmZDcyh8p58ZkvQt5OgXez61Ijguk1J0YlGVO4Y6O2k3fD5wK6ftN/DNnxb
 /OwjZXERXOVX1Ic9YJMGNorE3c45WmPdhRYgcE/DkMXKPsNYQgSoVefduOzYGa/aTo+1
 dqW8ev3lFzuv6TXwKv6LI2c9NTnpHdXyPFnZMYkh8A/fRFQ9C1aNI5UFcgaa/8cQmLpG
 MjBkj5elHmiEKjOOMrBm7jJ4gwqs4Z/zdAeZkJFLbDwqcy60we7aPs+QCXd6e7AgekwZ
 HieRtgVsJHkd/ZPhA2wGbp+cudwFIelkBzgr1+K9TOuqax2Gl72dgzcBFBCJGUG5rGMQ
 YVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736550266; x=1737155066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Muk3Xr8MIihrIrbDkjhh00FHcA0k7qw08J1GSh04wv4=;
 b=E/13tsOTCwcJRSa8JNT/o/ttj97JFj8iymTZC6wdTuIVe3yrBhTV0cQ/E8OSWXS51q
 V0wnZ+TBRQv53658GL4pbL5JDwIhhy4gRce97imLx8os6s/QksR5jYAz4/kWW+f+ad+A
 P1Q2oSgU3mRKSC+cmu6T2cr/4tpV3dH211K7AB7puKi+f2MrNSedWMxm9RE/sPr6wKq/
 obwCTP6cZ5+SaTcrroeXI4rIC2gLSjOTlJCbW3l7GQZTGFwevLsC2+wvSCePZPLqk3Bp
 +kFHX21TMNpVkzVDNtoOJ3zOJos75pKXrmFQCfxa0ZckBWDevfP2YlQG9jW93WZZLhZl
 siWA==
X-Gm-Message-State: AOJu0Yypleodnrl7psm19Q2RDEy18Dbf/gU8cEGTzlSCfq3qJJKs3k2H
 Us18qslXPgdREGLvtrsV10Sh28ALlYWaQP+ODA2M1vcXOxKsA+kXBtdQYLvQwowawLBbzwDYrJM
 gz64=
X-Gm-Gg: ASbGncuuVDmRRhMJANtlRvSqwQ1fOWYuHs5JSP0eIuA2L2oiEtDL2LcG3RO3KU9hPIZ
 NxGmZjqh9sUexVQgVkBZm8VbfgqNZvja0umdmnF6wX9jNoqjFV3EbRarw1aCNBM76J9SbcOzVcg
 X75uX5DBzD1jA8VuIajAX2s6xSu1xUdISdj5mpXjGZkyjXWrRFN8aq/b0hkdmhDto+DvMEzaX+J
 tG7Je2ZJgcWMWYuNT5Xe/pziVVzWIts6Wb6kFfVQUvOVbEEmCr3JnRpr2svg+HF6CQ+NxgSpY8l
 U+wZPl9YCod7Lxw7hbKkkr610Kd7gYh4RPXa
X-Google-Smtp-Source: AGHT+IFd+6FHa3SOSQk9GWHFjuzDL0cZxVBBhz9C3/FPYssrNCSpfAxGNtnC9Kq9FK6QcNRL+MW5ow==
X-Received: by 2002:a05:600c:4f14:b0:434:92f8:54a8 with SMTP id
 5b1f17b1804b1-436ec060a4cmr59189325e9.0.1736550266032; 
 Fri, 10 Jan 2025 15:04:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e89e14sm100144905e9.33.2025.01.10.15.04.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Jan 2025 15:04:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 1/2] hw/char/serial: Expose SerialState::irq as QDev GPIO
Date: Sat, 11 Jan 2025 00:04:17 +0100
Message-ID: <20250110230418.95571-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110230418.95571-1-philmd@linaro.org>
References: <20250110230418.95571-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Use the QDev GPIO API to set the TYPE_SERIAL output
IRQ, this way we don't have to explicitly set the
SerialState::irq pointer before realizing the object.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/serial-isa.c       | 2 +-
 hw/char/serial-pci-multi.c | 2 +-
 hw/char/serial-pci.c       | 2 +-
 hw/char/serial.c           | 2 ++
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index 3d913891dcb..2e755eaf440 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -76,8 +76,8 @@ static void serial_isa_realizefn(DeviceState *dev, Error **errp)
     }
     index++;
 
-    s->irq = isa_get_irq(isadev, isa->isairq);
     qdev_realize(DEVICE(s), NULL, errp);
+    qdev_connect_gpio_out(DEVICE(s), 0, isa_get_irq(isadev, isa->isairq));
     qdev_set_legacy_instance_id(dev, isa->iobase, 3);
 
     memory_region_init_io(&s->io, OBJECT(isa), &serial_io_ops, s, "serial", 8);
diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index 7578e863cfe..54b6224f4da 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -110,7 +110,7 @@ static void multi_serial_pci_realize(PCIDevice *dev, Error **errp)
             multi_serial_pci_exit(dev);
             return;
         }
-        s->irq = pci->irqs[i];
+        qdev_connect_gpio_out(DEVICE(s), 0, pci->irqs[i]);
         pci->name[i] = g_strdup_printf("uart #%zu", i + 1);
         memory_region_init_io(&s->io, OBJECT(pci), &serial_io_ops, s,
                               pci->name[i], 8);
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index 6659cef5d4b..4291bfc4e7f 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -52,10 +52,10 @@ static void serial_pci_realize(PCIDevice *dev, Error **errp)
     if (!qdev_realize(DEVICE(s), NULL, errp)) {
         return;
     }
+    qdev_connect_gpio_out(DEVICE(s), 0, pci_allocate_irq(&pci->dev));
 
     pci->dev.config[PCI_CLASS_PROG] = pci->prog_if;
     pci->dev.config[PCI_INTERRUPT_PIN] = 0x01;
-    s->irq = pci_allocate_irq(&pci->dev);
 
     memory_region_init_io(&s->io, OBJECT(pci), &serial_io_ops, s, "serial", 8);
     pci_register_bar(&pci->dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &s->io);
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 70044e14a0f..cdff29ccee2 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -923,6 +923,8 @@ static void serial_realize(DeviceState *dev, Error **errp)
 {
     SerialState *s = SERIAL(dev);
 
+    qdev_init_gpio_out(dev, &s->irq, 1);
+
     s->modem_status_poll = timer_new_ns(QEMU_CLOCK_VIRTUAL, (QEMUTimerCB *) serial_update_msl, s);
 
     s->fifo_timeout_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, (QEMUTimerCB *) fifo_timeout_int, s);
-- 
2.47.1


