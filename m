Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35F5C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSJl-00067N-OT; Mon, 14 Jul 2025 19:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSHv-0000st-UO
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:08:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSHu-0005lK-42
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E82N8uMrxYhqX3KZPSCakRCqzr2EespoSFv7KAFnOcU=;
 b=IWO0CsqPnq2EnDbIXfA1KzCq75csJHgaLiGng/F11fuCmSQS8L7X4RBKJENjJBUDHWRJVN
 +CSKfnYTnI+Fxfp9l/tX8qtM3mXMlCvQGPG5wIuUYWxUKlWlCBzEZzYTVphiu56UDZjOcs
 NwjnhS1kJr0jFdB/VbKZGUDWQoLnF/Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-12NsChnYPnmABp9uQvTiKg-1; Mon, 14 Jul 2025 19:08:44 -0400
X-MC-Unique: 12NsChnYPnmABp9uQvTiKg-1
X-Mimecast-MFC-AGG-ID: 12NsChnYPnmABp9uQvTiKg_1752534523
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4538f375e86so39566155e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534522; x=1753139322;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E82N8uMrxYhqX3KZPSCakRCqzr2EespoSFv7KAFnOcU=;
 b=Ii7qyxn8xuM5TFnLj2UYy2lTCH1HUezUTFb6gxYp4qZ9nPUalvTd4Dkr8Lr2DmwV9V
 L7mn8mxkCg6EOOtMGhmP3b+xWGaxDIYlEqgZLBul9kt78802gcn3PjCVSKhNvx6zp14Q
 Qyvpycwi2FN/3XxoW2uG7ipRmgetSFtnIGtXuZqM6z1pl4HbmIv4r1JB51Y9/0tFoTe6
 ElPHXwzy5MQoCGkXkZZn0kNRsPpJy6fRytl18UNiI6tmrSdL+bwqpUOuzsGSxBEj+4Nu
 GrErAA5EZx75qdjE3rRIopFvUo5fXugV6eyqoxtMrGDdjn3DqmLM3VvcJOfbUKRG84Tj
 YEMQ==
X-Gm-Message-State: AOJu0YxnLGA7ybgfL4UaP3O1i+MuaVE54mBSlT/nFVuoMFAs9fTE2v8U
 phaVnlWf/siAYlgibS1nREIDkU7LEiakW9Bo1wPAOsszZpiQZZXvn/Wbh4Fy4syIPuclasr/V22
 UftV8glMBf5ZnBVyy+aGJcRb7hL5JxUFNsiVAi7rqcMrGvECTIGdmGffySkFeSYM+R1plBseFX+
 MbhspJ4H1vLc1D1XXFhGn7beM10JoHYhNLGg==
X-Gm-Gg: ASbGncthWskyJyADBk+LRkWyeasVwUiTwAuyQAi9ZwsPOsIWk1D/ekqaCFFKvIzsnkU
 jgzv07hJJ9dqGLmXVq4cat9Xo03xfbf3ZXorid7mnZeB7VuJjkqgYwDu6rkYYB8FScpFxh+vXDS
 vdNclXgXwutyN+GKtTg3UWE1JT2sMvwJKnXNh9p8so5LTKtJPhvRBsMuQ5f3KHpefS3hPUNY444
 g/iAptDZYM564uP3mquPn92SELVLlMbN5GS6dKko4V2R/ImpykHbu1XOSB4EOJZp4YLKN73O2xJ
 azseHQKsE+BFl4sxSGaKDRYa3hJvy+AZ
X-Received: by 2002:a05:600c:34c3:b0:43c:fc04:6d35 with SMTP id
 5b1f17b1804b1-456272d2519mr3743915e9.4.1752534522568; 
 Mon, 14 Jul 2025 16:08:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqrrhGRaR7onCaVgzSmXjg7LgwAN4MIfbe/hR5vxBDf5UyHeB6/rvD+udUh25lmotQUFWI8g==
X-Received: by 2002:a05:600c:34c3:b0:43c:fc04:6d35 with SMTP id
 5b1f17b1804b1-456272d2519mr3743645e9.4.1752534522082; 
 Mon, 14 Jul 2025 16:08:42 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e2cfsm13369771f8f.75.2025.07.14.16.08.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:08:41 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:08:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 57/97] hw/i386/acpi-build: Introduce
 build_append_pcihp_resources() helper
Message-ID: <f5ffd909a6cce8a1804922d7d99a4b6b8a3d294e.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

Extract the code that reserves resources for ACPI PCI hotplug
into a new helper named build_append_pcihp_resources() and
move it to pcihp.c. We will reuse it on ARM.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-Id: <20250714080639.2525563-12-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/pcihp.h |  2 ++
 hw/acpi/pcihp.c         | 18 ++++++++++++++++++
 hw/i386/acpi-build.c    | 15 ++-------------
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
index 971451e8ea..8a46a414cc 100644
--- a/include/hw/acpi/pcihp.h
+++ b/include/hw/acpi/pcihp.h
@@ -75,6 +75,8 @@ void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
 
 void build_acpi_pci_hotplug(Aml *table, uint64_t pcihp_addr);
 void build_append_pci_dsm_func0_common(Aml *ctx, Aml *retvar);
+void build_append_pcihp_resources(Aml *table,
+                                  uint64_t io_addr, uint64_t io_len);
 
 /* Called on reset */
 void acpi_pcihp_reset(AcpiPciHpState *s);
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index cbe7e01385..5ca36c8619 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -685,6 +685,24 @@ void build_acpi_pci_hotplug(Aml *table, uint64_t pcihp_addr)
     aml_append(table, scope);
 }
 
+/* Reserve PCIHP resources */
+void build_append_pcihp_resources(Aml *scope /* \\_SB.PCI0 */,
+                                  uint64_t io_addr, uint64_t io_len)
+{
+    Aml *dev, *crs;
+
+    dev = aml_device("PHPR");
+    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A06")));
+    aml_append(dev,
+               aml_name_decl("_UID", aml_string("PCI Hotplug resources")));
+    /* device present, functioning, decoding, not shown in UI */
+    aml_append(dev, aml_name_decl("_STA", aml_int(0xB)));
+    crs = aml_resource_template();
+    aml_append(crs, aml_io(AML_DECODE16, io_addr, io_addr, 1, io_len));
+    aml_append(dev, aml_name_decl("_CRS", crs));
+    aml_append(scope, dev);
+}
+
 const VMStateDescription vmstate_acpi_pcihp_pci_status = {
     .name = "acpi_pcihp_pci_status",
     .version_id = 1,
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 91945f716c..52cef834ed 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1432,19 +1432,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
 
     /* reserve PCIHP resources */
     if (pm->pcihp_io_len && (pm->pcihp_bridge_en || pm->pcihp_root_en)) {
-        dev = aml_device("PHPR");
-        aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A06")));
-        aml_append(dev,
-            aml_name_decl("_UID", aml_string("PCI Hotplug resources")));
-        /* device present, functioning, decoding, not shown in UI */
-        aml_append(dev, aml_name_decl("_STA", aml_int(0xB)));
-        crs = aml_resource_template();
-        aml_append(crs,
-            aml_io(AML_DECODE16, pm->pcihp_io_base, pm->pcihp_io_base, 1,
-                   pm->pcihp_io_len)
-        );
-        aml_append(dev, aml_name_decl("_CRS", crs));
-        aml_append(scope, dev);
+        build_append_pcihp_resources(scope,
+                                      pm->pcihp_io_base, pm->pcihp_io_len);
     }
     aml_append(dsdt, scope);
 
-- 
MST


