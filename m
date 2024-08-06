Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1705C52D73
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 13:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbJk1-0001KH-My; Tue, 06 Aug 2024 08:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJi6-0002Bj-7J
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:54:51 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJi3-0000PN-UM
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:54:41 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5ba482282d3so716977a12.2
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 05:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722948878; x=1723553678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qK43iUJyWAfHzKeE0GH3CsavBGdCBQ3nQYJeK6ymPbo=;
 b=sELFRUduu8i2rI103JjxHxNwZ0Ywih3+j0E2y3BjR0LnspCaI5ARnpIHiFvLiuA2/0
 XO5+z1Vy1r1Vjz5YAbnxf/qX0P865rDegvHBKIz3VaLyRqpwJ3tfeU3up4IR9B65qQTb
 4eiUYjzskrUEAHcj6POu+g4dygo86y5KPSGEsttj4yeE7sdnjU5GM7I5ggiqVg28HQ0F
 +T3xJVvO7hUQzY60IJY6j+7rU+pTyF9T4g8HAF/zhsG//wUWp+sUZNzwG5cg1EVMzSUs
 EHD+8Bam+TUzzlio+eOsLWu2XN28CptyjjlBADnlrpSEEzOSYo1nP+LP8nom9Tb8XDU9
 ydXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722948878; x=1723553678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qK43iUJyWAfHzKeE0GH3CsavBGdCBQ3nQYJeK6ymPbo=;
 b=Qkmp1YyNF6JllIKhHCXTOtf7zxNn88Hdk0dpqFkiqGaEWtVhq4PCPVnblPFELnEYus
 Wanuzry7epv47mZ12pedj3mHyvWtUIwFSD7/ydZW8o7NZwZ4I0r5mnysD3O6EfpLmy/1
 yNdTkvomCs4ukT8lipKqBvIH0psEPpkj18m+MdMPv3omfE+YjuHXAxp6ppe551G5+GiL
 IJ5lDDDXuOrBwY8RF23+YkCZtgk5gow2GRmILrDDORbYjJU3Y7SUECJv0wP4b9BmQy5q
 Z2Xwd3Ta1LFHL1fYYn52BiEVDPFSng1UWB5X9FNk5hUVIFS+78Y+wsPXbtDVuKoTKWOw
 ImBQ==
X-Gm-Message-State: AOJu0YwSaaBB0keZzq6oD2gn9Eg23tsX1Bfa0IKUTVMXE3GoAToMkp0E
 kv3IGNBmSeKaGDyGKq1Hj82EJtEIA/VcYzBmvbexJiFOAocczJPS4Hz7on4Ajume8cv8NNZXCxh
 I
X-Google-Smtp-Source: AGHT+IFrCtNnDxLV9mdPl+IEdRjqO2zb6dmQKfr9A62yysxW6BEXU4Fuq9niM0mqy0Ztra9idjXhRA==
X-Received: by 2002:a17:906:794d:b0:a79:8318:288f with SMTP id
 a640c23a62f3a-a7dc4e45470mr977941266b.16.1722948877958; 
 Tue, 06 Aug 2024 05:54:37 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9e80e04sm553901866b.175.2024.08.06.05.54.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Aug 2024 05:54:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 26/28] hw/pci-host/gt64120: Reset config registers during RESET
 phase
Date: Tue,  6 Aug 2024 14:51:54 +0200
Message-ID: <20240806125157.91185-27-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806125157.91185-1-philmd@linaro.org>
References: <20240806125157.91185-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

Reset config values in the device RESET phase, not only once
when the device is realized, because otherwise the device can
use unknown values at reset.

Since we are adding a new reset method, use the preferred
Resettable API (for a simple leaf device reset, a
DeviceClass::reset method and a ResettableClass::reset_hold
method are essentially identical).

Reported-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240802213122.86852-3-philmd@linaro.org>
---
 hw/pci-host/gt64120.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index 573d2619ee..33607dfbec 100644
--- a/hw/pci-host/gt64120.c
+++ b/hw/pci-host/gt64120.c
@@ -1217,17 +1217,24 @@ static void gt64120_pci_realize(PCIDevice *d, Error **errp)
 {
     /* Values from chapter 17.16 "PCI Configuration" */
 
-    pci_set_word(d->config + PCI_COMMAND, 0);
-    pci_set_word(d->config + PCI_STATUS,
-                 PCI_STATUS_FAST_BACK | PCI_STATUS_DEVSEL_MEDIUM);
-    pci_config_set_prog_interface(d->config, 0);
-
     pci_set_long(d->wmask + PCI_BASE_ADDRESS_0, 0xfffff008); /* SCS[1:0] */
     pci_set_long(d->wmask + PCI_BASE_ADDRESS_1, 0xfffff008); /* SCS[3:2] */
     pci_set_long(d->wmask + PCI_BASE_ADDRESS_2, 0xfffff008); /* CS[2:0] */
     pci_set_long(d->wmask + PCI_BASE_ADDRESS_3, 0xfffff008); /* CS[3], BootCS */
     pci_set_long(d->wmask + PCI_BASE_ADDRESS_4, 0xfffff000); /* ISD MMIO */
     pci_set_long(d->wmask + PCI_BASE_ADDRESS_5, 0xfffff001); /* ISD I/O */
+}
+
+static void gt64120_pci_reset_hold(Object *obj, ResetType type)
+{
+    PCIDevice *d = PCI_DEVICE(obj);
+
+    /* Values from chapter 17.16 "PCI Configuration" */
+
+    pci_set_word(d->config + PCI_COMMAND, 0);
+    pci_set_word(d->config + PCI_STATUS,
+                 PCI_STATUS_FAST_BACK | PCI_STATUS_DEVSEL_MEDIUM);
+    pci_config_set_prog_interface(d->config, 0);
 
     pci_set_long(d->config + PCI_BASE_ADDRESS_0, 0x00000008);
     pci_set_long(d->config + PCI_BASE_ADDRESS_1, 0x01000008);
@@ -1243,7 +1250,9 @@ static void gt64120_pci_class_init(ObjectClass *klass, void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
+    rc->phases.hold = gt64120_pci_reset_hold;
     k->realize = gt64120_pci_realize;
     k->vendor_id = PCI_VENDOR_ID_MARVELL;
     k->device_id = PCI_DEVICE_ID_MARVELL_GT6412X;
-- 
2.45.2


