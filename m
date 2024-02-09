Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DD3C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 12:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYQ43-000826-12; Fri, 09 Feb 2024 07:33:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYQ3z-000814-LF
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 07:33:03 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYQ3w-0001vb-Be
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 07:33:01 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4102f273c46so8076925e9.2
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 04:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707481978; x=1708086778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=663egtvXUtLR9ZdYJglQVLyO0fSnzktyc0JFemad5jI=;
 b=VkZgDstHkxnn2B8fKe0kSgjsWIpARPYbWkRqnwtBnTW2OvQ6jOkp87I8tY9HDRzzOG
 mlSrr5ENvYdjWZRY1YBN5HFhEyxtjc3sLLSYJZOAVvNKZampmi5tkPN8TficGfQj6J9b
 kvoJCqHukPN4Z2BphXB3t0hfhjljopKDKY6XZSYuPZWRhn696AtLrsPTUi3rGPOOPZEG
 CYoSwXA9953ZPm2AhN+XLw2AeSV9ci08nXqC+POTHk++zh1SbM3O9MQo9E8Q/fD68nAL
 dSdtS0Ea3qZlvGHhW+UnsMux2hBRpPeNk7HksoV93wq/kKf4N838SKxhQw3SCYErGrOu
 vE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707481978; x=1708086778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=663egtvXUtLR9ZdYJglQVLyO0fSnzktyc0JFemad5jI=;
 b=LVxTY1opMbh/N+ZUhSZJWaVqpVMIIUcpesqe+Vz27krqylK4A9aWPPwXZ9PcpAbUyA
 YksvCcXlZekQIUGxYWKSow2QnzE5J2Ue1HvKjd7yjWQn3r3jkDs3QIAgP50inIdIm4eV
 8AADtzc8ERDBt2BFPKHxELtI9DwtoXS31Wo9cAqZuox4nosj7pkQ7YbVtZ5mbqyhwSiT
 6IQXbFE/9novL++FEuz1aO4RUZ5UhFUJ5AHoeMOdA4sevCdkeodVwwkbe8adLqjJVxOy
 fyf9ph2i1tauh3LbLU9UzhbUCR6t+Yg5u+JMy2CiI5+v+onkoCfeW7F0mJ04m4njws1o
 UWGg==
X-Gm-Message-State: AOJu0YwJzmPlnyP2qcbWW9WyaFD5NZsbR+NGFMPwZH16kIAvQ13/ozqU
 wVHLYrI9ccUiXoaaR/8Am68PrZuz1i0JIPBY1GkdwQgb8LHgT6sKEHEosssxy9alh4Nc123Ej/m
 x
X-Google-Smtp-Source: AGHT+IE4prvzihhUmQv7VLNgmkJT6shppkEFgUNGyL/tukLQgK2n3DKE2Ckk4+EyptQXl/B3MlLgTQ==
X-Received: by 2002:a05:600c:5490:b0:40e:f9f4:eeb3 with SMTP id
 iv16-20020a05600c549000b0040ef9f4eeb3mr1183393wmb.39.1707481978515; 
 Fri, 09 Feb 2024 04:32:58 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWLFp56gSVTcUfodr1Rna4sVxwxJhyecQssHGjTR7aBYKt+0e/yCFmFwPuM26IDC7BcQRETgc63keWsPYTk88MiGyK1fJK0FzqyxsItQdgx3710dmTLiGkhWgjNo7zZqqDXp4iSLR9uf7CKQWqdBIUgBqqiYoa1je5VtPHBzhCC4xUvriq8lbswPuzTOiBrOh7WeLlR1eUrtf8x0xPtmUjyyltScyNs186w7avU8M4ZlRmopOkY6b86CM4brYlCAuPl6NimMbB1dqMIKjVFuJAqSBECDJprDgQvAj5PAQy+tSlm34l/Cdc8V0c8cH/jpQMe3MKApeMR0PE=
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 n2-20020a05600c294200b0040e3635ca65sm509303wmd.2.2024.02.09.04.32.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Feb 2024 04:32:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC PATCH 5/7] hw/ide/via: Configure IDE bus IRQs after realization
Date: Fri,  9 Feb 2024 13:32:23 +0100
Message-ID: <20240209123226.32576-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240209123226.32576-1-philmd@linaro.org>
References: <20240209123226.32576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We shouldn't call qdev_get_gpio_in() on unrealized devices.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Ideally we should rework the current IDE bus model to really
use QOM and not globals. Left for later.
---
 hw/ide/via.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/ide/via.c b/hw/ide/via.c
index 3f3c484253..caf1b69bd4 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -226,6 +226,15 @@ static void via_ide_realize(PCIDevice *dev, Error **errp)
     qdev_init_gpio_in(ds, via_ide_set_irq, ARRAY_SIZE(d->bus));
     for (i = 0; i < ARRAY_SIZE(d->bus); i++) {
         ide_bus_init(&d->bus[i], sizeof(d->bus[i]), ds, i, MAX_IDE_DEVS);
+    }
+}
+
+static void via_ide_wire(DeviceState *dev)
+{
+    PCIIDEState *d = PCI_IDE(dev);
+    DeviceState *ds = DEVICE(dev);
+
+    for (unsigned i = 0; i < ARRAY_SIZE(d->bus); i++) {
         ide_bus_init_output_irq(&d->bus[i], qdev_get_gpio_in(ds, i));
 
         bmdma_init(&d->bus[i], &d->bmdma[i], d);
@@ -249,6 +258,7 @@ static void via_ide_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
+    dc->wire = via_ide_wire;
     dc->reset = via_ide_reset;
     dc->vmsd = &vmstate_ide_pci;
     /* Reason: only works as function of VIA southbridge */
-- 
2.41.0


