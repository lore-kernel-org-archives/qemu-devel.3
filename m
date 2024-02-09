Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FA7C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 12:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYQ3w-0007zN-Lk; Fri, 09 Feb 2024 07:33:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYQ3m-0007rx-Jn
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 07:32:58 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYQ3k-0001sz-Gm
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 07:32:50 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33b401fd72bso495714f8f.3
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 04:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707481967; x=1708086767; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DoeBrV+EEZMMsB2lJU5mfdts4xYAcXXfL7ZG+bYHvck=;
 b=mwVIjU74L8EpSrWA9GC+FnmdAzyXxTT+Lmx3qbxkNBpXeQNry7PU83htKlu1nn7i9H
 1r7eYgQtRMlPOJLy8llHaVrF6xz/76bzXwk4XNw4OFmcnP9/KT13MKipzjidpP8N69RQ
 OXTQmLmy2hcMeuDpCw9U7t3TjJYDNmXVFLYskXvsV4OfvjhGUR3vgFiWmWnacJbMBJ2/
 fO+ZlLNoqGThDsntD1pI5UnH1jB6GDhBW9vWXjmU9aHoAkRgpAC7Kgw6gm4eRhqBJ1KU
 6S9Hcm8GHebNSjsVzpmCMsw8jMijph3XdtGHkRJ4TBlIHeJQvwSVoEn4xJQXEC2PYMSq
 o/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707481967; x=1708086767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DoeBrV+EEZMMsB2lJU5mfdts4xYAcXXfL7ZG+bYHvck=;
 b=gQE94tbzNMowQ6OT1nhldu8pprgMFZmnmfVxT3Jv9BAHaOngRZov17L2OlH4iIqsms
 YdCSRTIINiFPYrF211VKO3dQ+QIH82/8ce0AVGo0wwgyb73PryQ7xo1CjealweQPkCNo
 47GkQEt5tydtQQKa+M87PqC80nzhG0BLTZU7ISO1kl9fxgTEafhdLibFRpqeZfHpEd52
 XejBtMSsMmzVoQ9h4sJ5X0jadQaN7URMZz8Whc8CmwZP6x1/pUJsjU6KRLxS/3mpBfR+
 wPChhNn/wEg/rxnblDzJhWTVysLVKpa01yXsMj3FW3TA4W83tWRZV63uSohCD8tNiKyI
 4uzQ==
X-Gm-Message-State: AOJu0YxAfyVcSnL3iHe/J/wJcl2wlW+y6x7pubmfbwz/+VAvLUTct93x
 1SJp65f7QLFVZakQkVhVZxy/vd/5R/+mzHi8LDfo4z+qOpkOMx77FJr0lJkPkj8F8B0yUu5w28h
 Y
X-Google-Smtp-Source: AGHT+IH6ARJjacuRf08FpRNTvoF3O1HvWResn8vP28ypStmZYCDHLC/5YVi242T8Fhhh+agYdxqLmw==
X-Received: by 2002:adf:a442:0:b0:33b:61ed:b899 with SMTP id
 e2-20020adfa442000000b0033b61edb899mr892320wra.56.1707481966785; 
 Fri, 09 Feb 2024 04:32:46 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXzfgXHMN47aQ/KCNhBxpV4Z3YyKPRl2YquyCugn1MlusU6NZEj5P66bCUgW3gpussgOGP+xANi+EeuF+NG8em8JEZKUh2yttWi4MnxBqiDLxQXopMjKPdXDU+90V/3v1NeIbXhr7cdmnh+hWKmOxADeH7HtF5hNd7e76gOgYou3cfEjEDdRk0c+QcWPz3/262htCsWFmn+KBJU1JLprRzmorl+uwiCJUo2oI/k3WcCdoAjeAQItdLyJ/52aEZiEzRw9bBmS3lOoAqbutHOB55EsKbgx5dz8wxZghUYOmrRhr5bCp5lQMfS68bjY1wAAGbWm/bDS0GNpFc=
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 d23-20020adfa357000000b0033ae50e2c6asm1712299wrb.83.2024.02.09.04.32.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Feb 2024 04:32:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC PATCH 3/7] hw/ide/cmd646: Configure IDE bus IRQs after
 realization
Date: Fri,  9 Feb 2024 13:32:21 +0100
Message-ID: <20240209123226.32576-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240209123226.32576-1-philmd@linaro.org>
References: <20240209123226.32576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

We shouldn't call qdev_get_gpio_in() on unrealized devices.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Ideally we should rework the current IDE bus model to really
use QOM and not globals. Left for later.
---
 hw/ide/cmd646.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index c0bcfa4414..92e1e7a4fc 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -291,9 +291,18 @@ static void pci_cmd646_ide_realize(PCIDevice *dev, Error **errp)
     /* TODO: RST# value should be 0 */
     pci_conf[PCI_INTERRUPT_PIN] = 0x01; // interrupt on pin 1
 
-    qdev_init_gpio_in(ds, cmd646_set_irq, 2);
     for (i = 0; i < 2; i++) {
         ide_bus_init(&d->bus[i], sizeof(d->bus[i]), ds, i, 2);
+    }
+}
+
+static void pci_cmd646_ide_wire(DeviceState *dev)
+{
+    PCIIDEState *d = PCI_IDE(dev);
+    DeviceState *ds = DEVICE(dev);
+
+    qdev_init_gpio_in(ds, cmd646_set_irq, 2);
+    for (unsigned i = 0; i < 2; i++) {
         ide_bus_init_output_irq(&d->bus[i], qdev_get_gpio_in(ds, i));
 
         bmdma_init(&d->bus[i], &d->bmdma[i], d);
@@ -324,6 +333,7 @@ static void cmd646_ide_class_init(ObjectClass *klass, void *data)
 
     dc->reset = cmd646_reset;
     dc->vmsd = &vmstate_ide_pci;
+    dc->wire = pci_cmd646_ide_wire;
     k->realize = pci_cmd646_ide_realize;
     k->exit = pci_cmd646_ide_exitfn;
     k->vendor_id = PCI_VENDOR_ID_CMD;
-- 
2.41.0


