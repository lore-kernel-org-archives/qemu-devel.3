Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3ABC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 12:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYQ3u-0007vj-Rl; Fri, 09 Feb 2024 07:32:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYQ3h-0007mx-AO
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 07:32:46 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYQ3f-0001qe-9N
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 07:32:45 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33b6489b593so368792f8f.3
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 04:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707481961; x=1708086761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=69j+RQz2yVIlaeXDXqDQZrASP/0yIinBEEqkOClQG7M=;
 b=P4wzSV+a6sgmuzRwokbfT6ciRLCDEo8QN2qpDkMLMpLZBhDi/0cmCuKNyGLa/atwVM
 ksTwrrLX5O7b/dzPsQ/eOmZBb/UQDSB1TE5RBBTkrpvZAm3FVU0fp/5OX98n8vasSKnw
 i96RVyNWmubCz3HRaQHw0+VadVgae994EY02SqTJHZ5IYxqF6a/1VS+Xx1fUB4+n+8n8
 thksn+dGt72By4gDIZDl67Qyq3mAUSk8Gi2VbkSXwAecjzZRz/lr4YBXGCCLbANY/UCH
 W56K6r1ZJFadbuRfMM6mC6znZ/cFrSC8PAof4XUBoldZWU2S1G7SRrk7jPssL4FU2Yar
 M2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707481961; x=1708086761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=69j+RQz2yVIlaeXDXqDQZrASP/0yIinBEEqkOClQG7M=;
 b=GdxaAoXTuEXwF1PjLcAPvBLeRSYB7+G5zf+wl0Jdeg89xcEIImSnJqphZoP36Uzl9c
 FBsnb+Pp1Jew/EXWIygQtrOGKVXvI+BwtvaUbNuDmRpUfI16ioSnusNH2eTV1hE3Wgee
 vI5tIdBFwzFDJ+qCi75xGmo3ruNoY9REV03WFTP+CP1fTlzIVcocf2HcNYCgabQh9ctM
 7P369oUjrLXK/Q9XC2gweYbJLDWe+ey71mtAqQ0gIeAJX8XBf+nZrRMabGPo93d6GnYH
 zJvN2D1HfhoeH8f9HJrsvUzuIjXh8Q+H31jd7Kj7Naykv3r4vzRjfIkiRzrhkIWOegOT
 PVvw==
X-Gm-Message-State: AOJu0YxhBuRH3uDVHecnF/5/EXHViA95gNNt15TNCL1orV1KhVcjK49d
 9vRjgPpV35aYKmiqFGrdiCMS0olCjai7vhMvFZRKnBxHUR1R/y1/hhYGyLcDymUwbIItCXhPogk
 0
X-Google-Smtp-Source: AGHT+IFrojkLy+30hPSoP396FCQnrQzJLM/6A1dVhEbU25punV2uYzj4wgsn5X35GgtrYq50fE+Kzw==
X-Received: by 2002:adf:fec6:0:b0:33b:2fba:1eab with SMTP id
 q6-20020adffec6000000b0033b2fba1eabmr1153828wrs.30.1707481961213; 
 Fri, 09 Feb 2024 04:32:41 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWKpUTsflMN6iBfwhdcCPB7CZWVS28YAPQUX5KuMdLc6vQUFRlw1ZEbpa9mXhNLkTOgl+4BDQfy04mgkEVY5W6yfOlUiFVDo6iAZ26OCVWeGW7bGfdBLk5FiRL5d0920LEYFWgK8WBwBrebO1U5bP8pmbvxEyYUH9udoA1f/84+D4AvwzO6Pae760UO4YCGD8R/46vh2kCQz2jek0u1AvfShDr1eFTod5RBIFt35Hxq537j85RrunFND8Hmput79yJLeM2ykzNQZEYJnL0hpYNk+D30bQM3HQCvmMh7S3Jn689lKLJ56MqBCf672h+nMmPAS07URRIXpCc=
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 dw8-20020a0560000dc800b0033b0d2ba3a1sm1703790wrb.63.2024.02.09.04.32.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Feb 2024 04:32:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC PATCH 2/7] hw/input/pckbd: Connect i8042 GPIOs once
 mouse/keyboard are realized
Date: Fri,  9 Feb 2024 13:32:20 +0100
Message-ID: <20240209123226.32576-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240209123226.32576-1-philmd@linaro.org>
References: <20240209123226.32576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

While a device is not realized, we shouldn't call:
 - qdev_get_gpio_in_named()
 - qdev_connect_gpio_out()
 - isa_connect_gpio_out()

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Probably better would be to declare the ISA wiring handlers
in ISADeviceClass, but such class doesn't exist yet.
---
 hw/input/pckbd.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index 90a4d9eb40..76175f6fe8 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -707,6 +707,12 @@ static void i8042_mmio_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&ks->ps2mouse), errp)) {
         return;
     }
+}
+
+static void i8042_mmio_wire(DeviceState *dev)
+{
+    MMIOKBDState *s = I8042_MMIO(dev);
+    KBDState *ks = &s->kbd;
 
     qdev_connect_gpio_out(DEVICE(&ks->ps2kbd), PS2_DEVICE_IRQ,
                           qdev_get_gpio_in_named(dev, "ps2-kbd-input-irq",
@@ -756,6 +762,7 @@ static void i8042_mmio_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = i8042_mmio_realize;
+    dc->wire = i8042_mmio_wire;
     dc->reset = i8042_mmio_reset;
     dc->vmsd = &vmstate_kbd_mmio;
     device_class_set_props(dc, i8042_mmio_properties);
@@ -878,9 +885,6 @@ static void i8042_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    isa_connect_gpio_out(isadev, I8042_KBD_IRQ, isa_s->kbd_irq);
-    isa_connect_gpio_out(isadev, I8042_MOUSE_IRQ, isa_s->mouse_irq);
-
     isa_register_ioport(isadev, isa_s->io + 0, 0x60);
     isa_register_ioport(isadev, isa_s->io + 1, 0x64);
 
@@ -888,18 +892,10 @@ static void i8042_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    qdev_connect_gpio_out(DEVICE(&s->ps2kbd), PS2_DEVICE_IRQ,
-                          qdev_get_gpio_in_named(dev, "ps2-kbd-input-irq",
-                                                 0));
-
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->ps2mouse), errp)) {
         return;
     }
 
-    qdev_connect_gpio_out(DEVICE(&s->ps2mouse), PS2_DEVICE_IRQ,
-                          qdev_get_gpio_in_named(dev, "ps2-mouse-input-irq",
-                                                 0));
-
     if (isa_s->kbd_throttle && !isa_s->kbd.extended_state) {
         warn_report(TYPE_I8042 ": can't enable kbd-throttle without"
                     " extended-state, disabling kbd-throttle");
@@ -909,6 +905,25 @@ static void i8042_realizefn(DeviceState *dev, Error **errp)
     }
 }
 
+static void i8042_wire(DeviceState *dev)
+{
+    ISADevice *isadev = ISA_DEVICE(dev);
+    ISAKBDState *i8042 = I8042(dev);
+    KBDState *s = &i8042->kbd;
+
+    isa_connect_gpio_out(isadev, I8042_KBD_IRQ, i8042->kbd_irq);
+    isa_connect_gpio_out(isadev, I8042_MOUSE_IRQ, i8042->mouse_irq);
+
+
+    qdev_connect_gpio_out(DEVICE(&s->ps2kbd), PS2_DEVICE_IRQ,
+                          qdev_get_gpio_in_named(dev, "ps2-kbd-input-irq",
+                                                 0));
+
+    qdev_connect_gpio_out(DEVICE(&s->ps2mouse), PS2_DEVICE_IRQ,
+                          qdev_get_gpio_in_named(dev, "ps2-mouse-input-irq",
+                                                 0));
+}
+
 static void i8042_build_aml(AcpiDevAmlIf *adev, Aml *scope)
 {
     ISAKBDState *isa_s = I8042(adev);
@@ -954,6 +969,7 @@ static void i8042_class_initfn(ObjectClass *klass, void *data)
     device_class_set_props(dc, i8042_properties);
     dc->reset = i8042_reset;
     dc->realize = i8042_realizefn;
+    dc->wire = i8042_wire;
     dc->vmsd = &vmstate_kbd_isa;
     adevc->build_dev_aml = i8042_build_aml;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
-- 
2.41.0


