Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC1BC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSIY-0003wF-CI; Mon, 14 Jul 2025 19:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSHb-0006jk-9U
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:08:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSHZ-0005hh-7P
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6/OhfZLKBwpQCNEpQVAmadE4Z6ccjSU0gbMdCkgwst8=;
 b=FK7ee7MrGKBgzNKzC3nLWetl7p53pH72zWeqiAwdVxKvHaEovJwxSoCiELSqEGAsml+txX
 o0tH2DiJ9dPk7I9J7dkFychWmwOVLqPPgVavhld4f2Ai9v47c4gb2I9d4Z4N+5cuiDW+re
 a/Z+WLJN6rr7X4NPbweTBvFysxB4IDQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-zvgi3xthNjmVKtvpWNX9ew-1; Mon, 14 Jul 2025 19:08:23 -0400
X-MC-Unique: zvgi3xthNjmVKtvpWNX9ew-1
X-Mimecast-MFC-AGG-ID: zvgi3xthNjmVKtvpWNX9ew_1752534502
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-455e9e09afeso16525125e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534502; x=1753139302;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6/OhfZLKBwpQCNEpQVAmadE4Z6ccjSU0gbMdCkgwst8=;
 b=o8e4dqkfUJVo31Kn2kr0jG59KidBRV/winhFFHtbTE/2llAHqpzURd1lwy89dbPMgN
 3zWgK0iWKidj+rxHfPSCrAUZ/dnTLQt9y98Zsi73IS57cUwpxqGjiaHDaRJxnXbEIqNu
 FQFIv1dYg7XdxTraKNtpX2LgrWvGBxmMXhZSv1/+IPrVDJg5YhXLOBCVkxTE8mlVlRb0
 uS3HA22n86nCDUTamFvG81y8VcRhjcK8BGISZaTPwoANi6WghxDgsqrtQON4df5nBibj
 ZUDaHTek2xTrlbABBY1p06k+XqUT7BicOTkpk00Yo9c60n3HF2LnFSweHYPufTYENH3b
 eQug==
X-Gm-Message-State: AOJu0YzoenyE59qgCwvoDfsX//oxLykinIAi0XVXlfE/8WO0pI4cZ97I
 A5VAUJRyJJN30NcBuSrrY4BNneQJOJTqBOsSY8POBrq3dGBu8oY2bZ3D8I+thVBknTjwqsfvSc9
 3rb1bPEfxDFo17iXbCYKV2z205OQe7krI9UAQwkyGYyMCS9Oz31Uny580iUWIZJg6vxPM/dBSoz
 EtjcnSJ3ZDdYawpEwkIDF0PFd/5/9b3JdfkQ==
X-Gm-Gg: ASbGnctHUf1Y4j1TRk0Z6qkF8ah7fpxU5lXErAVokeXZZ9Dto0f+vmFP9wNl11MSF+c
 i/4PJMFyiPSR6uEHCJTDdZvfkkUmECR+3LXOa3mJI8uiVEVYaz6nqCJRQfTe2iDqmPEpiXC1/xP
 DqCwmDRT7OVVZP2zYDz5QLDVFTY+/8zXSnUI9W1u25sp7Z/dynSAaKWQQeOjvBln3oHd8AGN5Gc
 OiYXK7gmuSigAPuPqWnvlUR1PUMaBInwBHjWBt/woQuf+YRTM+iJDKvlZ++w6QBYJG4FkbX96ej
 aaj0aib5QB4FMGvpvL4tRS2uVe96BijM
X-Received: by 2002:a05:600c:4713:b0:450:ceb2:67dd with SMTP id
 5b1f17b1804b1-454f427985emr130106075e9.33.1752534501814; 
 Mon, 14 Jul 2025 16:08:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5lSilpg5VmNcVVXqHek7z6XkJ4Ehxy457Be+BA/lzQFLEG4FIUj+uFoHoy/aCSLW31eHtmw==
X-Received: by 2002:a05:600c:4713:b0:450:ceb2:67dd with SMTP id
 5b1f17b1804b1-454f427985emr130105875e9.33.1752534501337; 
 Mon, 14 Jul 2025 16:08:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45610a39cacsm69264855e9.38.2025.07.14.16.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:08:21 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:08:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 49/97] hw/pci-host/gpex-acpi: Add native_pci_hotplug arg to
 acpi_dsdt_add_pci_osc
Message-ID: <7e0f0871641a0a1b77180da67505c81f8e825900.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Eric Auger <eric.auger@redhat.com>

Add a new argument to acpi_dsdt_add_pci_osc to be able to disable
native pci hotplug.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-Id: <20250714080639.2525563-4-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci-host/gpex-acpi.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
index 0aba47c71c..f34b7cf25e 100644
--- a/hw/pci-host/gpex-acpi.c
+++ b/hw/pci-host/gpex-acpi.c
@@ -50,7 +50,7 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq,
     }
 }
 
-static void acpi_dsdt_add_pci_osc(Aml *dev)
+static void acpi_dsdt_add_pci_osc(Aml *dev, bool enable_native_pcie_hotplug)
 {
     Aml *method, *UUID, *ifctx, *ifctx1, *elsectx, *buf;
 
@@ -77,11 +77,12 @@ static void acpi_dsdt_add_pci_osc(Aml *dev)
     aml_append(ifctx, aml_store(aml_name("CDW3"), aml_name("CTRL")));
 
     /*
-     * Allow OS control for all 5 features:
-     * PCIeHotplug SHPCHotplug PME AER PCIeCapability.
+     * Allow OS control for SHPCHotplug, PME, AER, PCIeCapability,
+     * and PCIeHotplug depending on enable_native_pcie_hotplug
      */
-    aml_append(ifctx, aml_and(aml_name("CTRL"), aml_int(0x1F),
-                              aml_name("CTRL")));
+    aml_append(ifctx, aml_and(aml_name("CTRL"),
+               aml_int(0x1E | (enable_native_pcie_hotplug ? 0x1 : 0x0)),
+               aml_name("CTRL")));
 
     ifctx1 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(0x1))));
     aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x08),
@@ -192,7 +193,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
             if (is_cxl) {
                 build_cxl_osc_method(dev);
             } else {
-                acpi_dsdt_add_pci_osc(dev);
+                acpi_dsdt_add_pci_osc(dev, true);
             }
 
             aml_append(scope, dev);
@@ -267,7 +268,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
     }
     aml_append(dev, aml_name_decl("_CRS", rbuf));
 
-    acpi_dsdt_add_pci_osc(dev);
+    acpi_dsdt_add_pci_osc(dev, true);
 
     Aml *dev_res0 = aml_device("%s", "RES0");
     aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));
-- 
MST


