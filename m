Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCA9C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 21:00:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPTY3-0003AU-PW; Thu, 04 Jul 2024 16:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sPTXy-00036A-Gs; Thu, 04 Jul 2024 16:59:18 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sPTXw-0000nT-Vy; Thu, 04 Jul 2024 16:59:18 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-58c947a6692so1347909a12.0; 
 Thu, 04 Jul 2024 13:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720126754; x=1720731554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ljcer9zvdVKMvDgAjw0WDcSBwhOat54Z1xUNuYnsdSE=;
 b=E3Q9a20KHi4xECeEcBX/wKoT6nrsH/bQg3ZUAl7Vy5mqsYeN6DO7H9fKWKrKYHvcVT
 U7RMdfQfGrWO46fIFFhBwtNbZVMggfOs4TAN4dOJGl3aXW3FLybrKzUK4E30xx9zD4CZ
 xuWsgaJXWxZDUC3E0g5KbzJurvPiUud1unRP4v5ad2g63UIEh0LxnGVnDswMP4VYZY6n
 W57GL1NkXx/5rtjvxHwPEFQcjH9uYTJcg3/UsnsYt/br34poRjMQSFAaGu0zH57zGz79
 q/tLGVygWekTFjUPjkWio5jhBgSIK3AAm6yq4qu4P2OdEe99+6mgzJSee4On58DGeQvO
 pXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720126754; x=1720731554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ljcer9zvdVKMvDgAjw0WDcSBwhOat54Z1xUNuYnsdSE=;
 b=tzq43aSQgYwMBaVUmGQoh7cLDx9ksTtWxRsZ5C1brY/LU9NNOS9e14zYCk0sKC03RW
 3Iy9f59YX9BfMjqXuEXyUljq4J/yFpTv2QnyNN0iyCM0WDEHL47n8MDalhTCs2YMH+ZQ
 2GGiMbYm0SXOUiB1QKCXn6W/E0lAw16gto6tb/gW9opRt9x0VnhS/dHGdDDXvzMDTFEd
 91o8H/OEqXKCxNgF97Yy1tlXBWXLKK1yZ+z4p3gkQRI6ynTqZ8MydiT95GijC7JmUpaS
 LIPynF6NBnH0sZjzmRR3qacQTF/1CKqe8TVj3pCT7pvdLOCW6ndb9M4XtifUHQJINGWN
 kBtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDl4Dp4ZXQ4lQ9b53wA69y/wx80277P+nQKPBT+JAM4rfkxghOh9nfsVMmZfyqvoSqqGgjRGbsjFcb5BXs5C41ZBF3
X-Gm-Message-State: AOJu0Yww79drjc5/mLXoorqaoxHOURxuSRY/DXkzYHoP1RzbOETXm4I+
 OCSRzk/BL7KnLPpKjFipg0qMMDJgBGTz+PQBOxhAIISRg0ucBMJQxHolPQ==
X-Google-Smtp-Source: AGHT+IH4owux7zm2dmqCwga00syW870P08hZPTPVzBpBzcJIFyh643XzCTtN+VYQITtjxYCq3C8z2Q==
X-Received: by 2002:a17:906:31c1:b0:a75:115a:25d0 with SMTP id
 a640c23a62f3a-a77ba70a896mr155201966b.50.1720126754445; 
 Thu, 04 Jul 2024 13:59:14 -0700 (PDT)
Received: from archlinux.. (dynamic-077-188-087-180.77.188.pool.telefonica.de.
 [77.188.87.180]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7400456582sm526153866b.153.2024.07.04.13.59.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 13:59:13 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Huacai Chen <chenhuacai@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 1/3] hw/isa/vt82c686: Turn "intr" irq into a named gpio
Date: Thu,  4 Jul 2024 22:58:52 +0200
Message-ID: <20240704205854.18537-2-shentey@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704205854.18537-1-shentey@gmail.com>
References: <20240704205854.18537-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x532.google.com
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

Makes the code more comprehensible, matches the datasheet and the piix4 device
model.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/isa/vt82c686.c   | 2 +-
 hw/mips/fuloong2e.c | 2 +-
 hw/ppc/amigaone.c   | 4 ++--
 hw/ppc/pegasos2.c   | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 8582ac0322..505b44c4e6 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -719,7 +719,7 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
     ISABus *isa_bus;
     int i;
 
-    qdev_init_gpio_out(dev, &s->cpu_intr, 1);
+    qdev_init_gpio_out_named(dev, &s->cpu_intr, "intr", 1);
     qdev_init_gpio_in_named(dev, via_isa_pirq, "pirq", PCI_NUM_PINS);
     isa_irq = qemu_allocate_irqs(via_isa_request_i8259_irq, s, 1);
     isa_bus = isa_bus_new(dev, pci_address_space(d), pci_address_space_io(d),
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index a45aac368c..6e4303ba47 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -299,7 +299,7 @@ static void mips_fuloong2e_init(MachineState *machine)
                               object_resolve_path_component(OBJECT(pci_dev),
                                                             "rtc"),
                               "date");
-    qdev_connect_gpio_out(DEVICE(pci_dev), 0, env->irq[5]);
+    qdev_connect_gpio_out_named(DEVICE(pci_dev), "intr", 0, env->irq[5]);
 
     dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
     pci_ide_create_devs(PCI_DEVICE(dev));
diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index ddfa09457a..9dcc486c1a 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -153,8 +153,8 @@ static void amigaone_init(MachineState *machine)
     object_property_add_alias(OBJECT(machine), "rtc-time",
                               object_resolve_path_component(via, "rtc"),
                               "date");
-    qdev_connect_gpio_out(DEVICE(via), 0,
-                          qdev_get_gpio_in(DEVICE(cpu), PPC6xx_INPUT_INT));
+    qdev_connect_gpio_out_named(DEVICE(via), "intr", 0,
+                                qdev_get_gpio_in(DEVICE(cpu), PPC6xx_INPUT_INT));
     for (i = 0; i < PCI_NUM_PINS; i++) {
         qdev_connect_gpio_out(dev, i, qdev_get_gpio_in_named(DEVICE(via),
                                                              "pirq", i));
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index c1bd8dfa21..9b0a6b70ab 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -195,8 +195,8 @@ static void pegasos2_init(MachineState *machine)
     object_property_add_alias(OBJECT(machine), "rtc-time",
                               object_resolve_path_component(via, "rtc"),
                               "date");
-    qdev_connect_gpio_out(DEVICE(via), 0,
-                          qdev_get_gpio_in_named(pm->mv, "gpp", 31));
+    qdev_connect_gpio_out_named(DEVICE(via), "intr", 0,
+                                qdev_get_gpio_in_named(pm->mv, "gpp", 31));
 
     dev = PCI_DEVICE(object_resolve_path_component(via, "ide"));
     pci_ide_create_devs(dev);
-- 
2.45.2


