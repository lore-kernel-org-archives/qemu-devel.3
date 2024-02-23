Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226FBC54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 12:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdUxo-0007Ji-J7; Fri, 23 Feb 2024 07:47:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdUuj-0000iY-Ub
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 07:44:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdUui-0003u5-Fm
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 07:44:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708692267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KX5mFYyzGrbXN9qLjuG0MCdCO6Thw7ipfGXYojSpuyc=;
 b=Ey1TkBP4w2pFEOR3t8SoEoWwyt5j/eUZhOPugpsyPOPrkVGj7CLDUQB/d5i2jw4zXLF2RH
 w4t/1jl7eOBMjMe6BFXCENtx2BQI0s8+9bdeFl9iAyyotkMuYS1fIe08M3CgqRZu7UY0K/
 KkKGNPSL5SG7TctinTWvwc+Sv2JJztY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-LXKv0L9uPYaASjDm13dvyQ-1; Fri, 23 Feb 2024 07:44:26 -0500
X-MC-Unique: LXKv0L9uPYaASjDm13dvyQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2d25a02f48fso6416781fa.3
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 04:44:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708692263; x=1709297063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KX5mFYyzGrbXN9qLjuG0MCdCO6Thw7ipfGXYojSpuyc=;
 b=Co4u29jEQRRVujpUpQSYgAkDc8z0ukgh9dl2x+zJ/5hvCqq4sW6zXnlItEaMXfpfty
 8q6fRmSCl7ZdY0jHtyngUti7CO14WrDgfKvNAnsByGxKvL2ol4irJPaKWJ+bYajfQAME
 Htx4O09nnFRHJ5v9x7sU/xoQjdSntem7/1QiGdrLa/GBZYGTuTqu8H8+fVC3eTxzZ4tY
 Du4Ag29kpZCJTHlwK7ce9mBOtmqcCltLLtDOUpgvW2vwnn5jwFbANzgKDAJYQRsJXaOO
 +FpZ32+EnKmrvMBMX6s+a7GCA0PrGM5hDRgZiK/mvzCI5bfCPIph3W1tnVnvO4Eg1CBd
 +g9g==
X-Gm-Message-State: AOJu0YyugBwHxEtvWlHD1oGFfOIWTu2eq8v7cmFOulq6w40p82XbCXn2
 pJn486XP+DaCQSeslmf2jbAwQ2nuix6PB+ppM/6IIc3a7OoegT9rdan+Qs6KQpd53a44uVLiptU
 1TABju9DvOdRKkX3VxyO47a5zl6BgIRgtYRm4x2vmJBzVTzyTDaoL812jM1yLxXcVU2SjulFcqR
 rLTOjVY3KOj41TgFJq4OzzkIrH0ZdlGRwrC+EG
X-Received: by 2002:a2e:7c13:0:b0:2d2:4fa4:f4b2 with SMTP id
 x19-20020a2e7c13000000b002d24fa4f4b2mr1181114ljc.28.1708692263686; 
 Fri, 23 Feb 2024 04:44:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESCRktr+2eQ1mc6e1iEHnu9EoSdBhBHSEHa+T8BhbcHfs/921+ZhKU3wa6u08IThcw5VZRkw==
X-Received: by 2002:a2e:7c13:0:b0:2d2:4fa4:f4b2 with SMTP id
 x19-20020a2e7c13000000b002d24fa4f4b2mr1181100ljc.28.1708692263222; 
 Fri, 23 Feb 2024 04:44:23 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 m6-20020a7bce06000000b00410bca333b7sm2219456wmc.27.2024.02.23.04.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 04:44:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	balaton@eik.bme.hu
Subject: [PATCH 05/10] hppa: do not require CONFIG_USB
Date: Fri, 23 Feb 2024 13:44:01 +0100
Message-ID: <20240223124406.234509-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223124406.234509-1-pbonzini@redhat.com>
References: <20240223124406.234509-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

With --without-default-devices it is possible to build a binary that
does not include any USB host controller and therefore that does not
include the code guarded by CONFIG_USB.  While the simpler creation
functions such as usb_create_simple can be inlined, this is not true
of usb_bus_find().  Remove it, replacing it with a search of the single
USB bus on the machine.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/hppa/machine.c | 7 ++++---
 hw/hppa/Kconfig   | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 5fcaf5884be..11982d5776c 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -396,10 +396,11 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
     }
 
     /* create USB OHCI controller for USB keyboard & mouse on Astro machines */
-    if (!lasi_dev && machine->enable_graphics) {
+    if (!lasi_dev && machine->enable_graphics && defaults_enabled()) {
         pci_create_simple(pci_bus, -1, "pci-ohci");
-        usb_create_simple(usb_bus_find(-1), "usb-kbd");
-        usb_create_simple(usb_bus_find(-1), "usb-mouse");
+        Object *usb_bus = object_resolve_type_unambiguous(TYPE_USB_BUS, &error_abort);
+        usb_create_simple(USB_BUS(usb_bus), "usb-kbd");
+        usb_create_simple(USB_BUS(usb_bus), "usb-mouse");
     }
 
     /* register power switch emulation */
diff --git a/hw/hppa/Kconfig b/hw/hppa/Kconfig
index dff5df7f725..ee7ffd2bfb5 100644
--- a/hw/hppa/Kconfig
+++ b/hw/hppa/Kconfig
@@ -2,6 +2,7 @@ config HPPA_B160L
     bool
     imply PCI_DEVICES
     imply E1000_PCI
+    imply USB_OHCI_PCI
     imply VIRTIO_VGA
     select ASTRO
     select DINO
@@ -17,4 +18,3 @@ config HPPA_B160L
     select LASIPS2
     select PARALLEL
     select ARTIST
-    select USB_OHCI_PCI
-- 
2.43.0


