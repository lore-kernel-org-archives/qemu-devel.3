Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D538AE7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWJk0-00020u-L3; Fri, 10 Jan 2025 13:28:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWJjv-00020L-Ck
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:28:11 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWJjt-0007OX-3H
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:28:10 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso17484385e9.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736533687; x=1737138487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zE4qjB0uSRkjg+MUXEy5a73ggSq4M0TRcq7NiIJZjTs=;
 b=fo4SA+W+L6epcOyn9/VDBAm8ZSi8k3EwHmdChUZD8kJvfrmDrAUlrl4xINZI2tqyS7
 vwQRK9Zr1ZhY5i225UOo39qOdwMy69cF6oIXDhjUllj9QV+ckMmzMxVEQggal2by57S1
 OaYIsVBCZBe4QX7I5ZfA06Ow/sWQX0PI99e6KUhrteywWRVm6A1noJ5AA+ujQBaCO2CP
 BLygbX2O3ec4XBshk/oGUgBdJUOcYL06Tp4+kWx4FyY1mXezxJOZGDN8qGOu2lxN2YPw
 5/kaHNaKvqfm3hb0x+Lwfp8GyS4G/Zf5rGl5/fSvYLib01LhhVhXzRjJLrwpW0JfHihA
 WVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736533687; x=1737138487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zE4qjB0uSRkjg+MUXEy5a73ggSq4M0TRcq7NiIJZjTs=;
 b=QdZRokCp0OP3pcxeurkDbjj/HJX7IkMMOTWcuJDJJthMy51ZMOuV7zULM3SCmrvim7
 qfLINJzuiOZqMonhD0P+RPhlxLwuQ/Nyf1XIDrq6m0lKceltPY4TYJrzo+Ftma4AG9z0
 WGYTF3oKsiSDAR4LmgXkWX4avuDENLuq9CiENhw5OFBdJoizO1kSPQclsAE5ihsRd1jA
 v6RUxWPCgi1gotewzIWcgnS6lW0vQ1Rewnc4iMcp8lLZxHkBBaqkl2GwZKg4+bzXV60u
 l2ACghhCzZGAbBdXToA/uSKeoAoaPexPWkOeRHVeLPxUsRiqFuEMS5a4PdmCkSMPv7y7
 nZqw==
X-Gm-Message-State: AOJu0YyuytjCwk/O/YCgAMltzLLUDwcmzMCavIOaTqWMlbpT5FEwKO5z
 O7jlMbKOu+AsQwkbygv8xdyiKTgxCwAsLR59K6nmiRMPFb4wtpQOUXYkJx2pycRMeaXrM0p87qU
 WiXs=
X-Gm-Gg: ASbGncuCZo/T/FNB/QbYYYhPSy8UrQ3ZQQnmmvLEYrMKAqJCFrxe5ELaMd01p3a/KCw
 +rzFi7Sr0uzByUsUCqQ90gM+M/3ooEpcGpbBWKQZ11i5J63CEi9Y7Sw9v+qt9RMnmNz42qia83H
 6MRsgZQDdsT59CHmHVxEpSl6N0WAdyK99vyX0y1BvVi0Rc2a8r8ObCI2RpYmz8EvsNFkI5u/2vm
 tjUJzN198bcziwhnC3NqvQIYlWQRxrMyDfGfBgDJDffFxnOfmNXKg+8bOll/tLX+R/hBJzD2RrX
 FiR94J4guXjcYeKetkI2y+NDBpxnsxs=
X-Google-Smtp-Source: AGHT+IFtWy8r9T7rpcO22c3LXmU8AWfu8InbU5L6ijkdAOWcCh8uaIMPUf0j/u2izh6126TwIkNO2g==
X-Received: by 2002:a05:600c:310c:b0:434:f8a0:9dc5 with SMTP id
 5b1f17b1804b1-436e26a8c21mr111801255e9.13.1736533687220; 
 Fri, 10 Jan 2025 10:28:07 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9d8fc81sm60544255e9.5.2025.01.10.10.28.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Jan 2025 10:28:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/2] hw/char/serial: Ensure SerialState::irq is set when
 realizing
Date: Fri, 10 Jan 2025 19:27:58 +0100
Message-ID: <20250110182759.84071-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110182759.84071-1-philmd@linaro.org>
References: <20250110182759.84071-1-philmd@linaro.org>
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

SerialState::irq must be set by parent when the object is realized.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/serial-pci-multi.c | 2 +-
 hw/char/serial-pci.c       | 2 +-
 hw/char/serial.c           | 2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index 7578e863cfe..5ad2c0e8443 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -106,11 +106,11 @@ static void multi_serial_pci_realize(PCIDevice *dev, Error **errp)
 
     for (i = 0; i < nports; i++) {
         s = pci->state + i;
+        s->irq = pci->irqs[i];
         if (!qdev_realize(DEVICE(s), NULL, errp)) {
             multi_serial_pci_exit(dev);
             return;
         }
-        s->irq = pci->irqs[i];
         pci->name[i] = g_strdup_printf("uart #%zu", i + 1);
         memory_region_init_io(&s->io, OBJECT(pci), &serial_io_ops, s,
                               pci->name[i], 8);
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index 6659cef5d4b..d31a3ccf03b 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -49,13 +49,13 @@ static void serial_pci_realize(PCIDevice *dev, Error **errp)
     PCISerialState *pci = DO_UPCAST(PCISerialState, dev, dev);
     SerialState *s = &pci->state;
 
+    s->irq = pci_allocate_irq(&pci->dev);
     if (!qdev_realize(DEVICE(s), NULL, errp)) {
         return;
     }
 
     pci->dev.config[PCI_CLASS_PROG] = pci->prog_if;
     pci->dev.config[PCI_INTERRUPT_PIN] = 0x01;
-    s->irq = pci_allocate_irq(&pci->dev);
 
     memory_region_init_io(&s->io, OBJECT(pci), &serial_io_ops, s, "serial", 8);
     pci_register_bar(&pci->dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &s->io);
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 70044e14a0f..562931685e7 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -923,6 +923,8 @@ static void serial_realize(DeviceState *dev, Error **errp)
 {
     SerialState *s = SERIAL(dev);
 
+    assert(s->irq);
+
     s->modem_status_poll = timer_new_ns(QEMU_CLOCK_VIRTUAL, (QEMUTimerCB *) serial_update_msl, s);
 
     s->fifo_timeout_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, (QEMUTimerCB *) fifo_timeout_int, s);
-- 
2.47.1


