Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6675ECCA472
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UEH-0007lK-1r; Sun, 05 Oct 2025 15:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEC-0007hk-CO
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEA-0006Ry-AZ
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wo4k0+GpbcFPiJ6gl4bLvcB2+0oAKyd5LRGZIg/TJvM=;
 b=d3DUCYu7l8nxBEZdMmp3Yd2b0om3BeFSxXQYoV5j4/p7spU3jsRpzpQa5XNQqW1LEGBIJ2
 Mp/CVQQoiT8W2feLXoKcNZtt8e0WUM/QVcZqNyBpe91aDS/YjAsjJH42ilsVXE7Z62yIod
 OCdeI4/aVy4ThtZduPHXxwtSPhuTNBo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-lYG2sRL6Ovi7aWDvU2_X9A-1; Sun, 05 Oct 2025 15:16:59 -0400
X-MC-Unique: lYG2sRL6Ovi7aWDvU2_X9A-1
X-Mimecast-MFC-AGG-ID: lYG2sRL6Ovi7aWDvU2_X9A_1759691818
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e375dab7dso18414165e9.3
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691818; x=1760296618;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wo4k0+GpbcFPiJ6gl4bLvcB2+0oAKyd5LRGZIg/TJvM=;
 b=i60w+u4TPvJQyO0/KJIBiNtfjScAmktxGT/NxalTfo76BtrTYoODr9o6qdthlfeH5C
 z+KzFy6/DQBYFGlsyamaGYkIulpZIJ5xvJxm3+tV+RF6wPlXckLR793Kg07CiVl3BNP7
 UsE4MTRr8uHujDZgUBj7nFXpazaqGzAWypK47lAmaZhJUX8YpFnC+9sLFx0l0NxHFayc
 XtUIYFdLbxpOTOLqvhYWjTI+EHMuEILA3344Uv+1KmJEM+/8Zcu8STa8pMaJDYojNihP
 yrS1CCTvpWlmT6lHcyFdcc5LRS5PgnqQaITY373dov1mLp2ax4vlsgibtVv1aGO9Yoep
 jyUg==
X-Gm-Message-State: AOJu0YwiTjYnVz3b6LyKdvlIyQlj3T+2CfxdsbVd/8L0nRtv8Jrzspe1
 4M3+bivL4auhszQ3rPk0VXoIH2uD76i9T7cKmcmKLklzsttbq+FIhShwzyw5czWdWLCs4JzhyYH
 2S2pRH6+PQ2/n347btGrhixJpg/DagS+iBCkuocX4Ztxv61kEECtn13pZeamGr61W5GCKnm6MLv
 ihREVfXWpLZdJnEuHSQR4/mi3noHGQf7A/JQ==
X-Gm-Gg: ASbGnct2IC3zpfnl7M9trCNI2WGFZO6TcitVx5MNRI/JrxcQpUnr+XDr2TIa1YeHVGZ
 j3uLf5sl5OaTtp4ZPdP5VcvMXgRZkTRzenjyN4KGqPMxBkBvWfzFURM+NNHYyk0XLL/BlsSaJ7k
 aQPmYiOiBrGslEKAOk7o7Jl4w4OUfLGqXyVL9vNfCCcJRMkF6vye9G9R4mt4VZ7HlfXeII+3O9S
 3AeRO2fxj6c6AchHvgLiQt1XdME6cHJB4LE/9Bn456L35f3RNfDecpXMflerpjkfyzHOMkrXxFe
 uvbF8drtMcWn2/8u/lMw2/fx8grosRv56HZ/mUI=
X-Received: by 2002:a05:600c:a085:b0:45d:d609:1199 with SMTP id
 5b1f17b1804b1-46e71151c24mr72241735e9.30.1759691817736; 
 Sun, 05 Oct 2025 12:16:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkzDFi6nuyZGqMEwB9zdBqGx2j8fNsTRjslP3j3HYYpHUK0tMFl+PbY0uvSFypJ6Eh8F2qrQ==
X-Received: by 2002:a05:600c:a085:b0:45d:d609:1199 with SMTP id
 5b1f17b1804b1-46e71151c24mr72241535e9.30.1759691817138; 
 Sun, 05 Oct 2025 12:16:57 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e5b56c792sm126382675e9.0.2025.10.05.12.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:16:56 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:16:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 24/75] acpi/generic_event_device: add an APEI error device
Message-ID: <c498a36bcb59d1f96faf4771efe8f655ff5faa20.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Adds a generic error device to handle generic hardware error
events as specified at ACPI 6.5 specification at 18.3.2.7.2:
https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#event-notification-for-generic-error-sources
using HID PNP0C33.

The PNP0C33 device is used to report hardware errors to
the guest via ACPI APEI Generic Hardware Error Source (GHES).

Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <2790f664c849d53de0ce3049fa8c7950c1de1f86.1758610789.git.mchehab+huawei@kernel.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/acpi_dev_interface.h   |  1 +
 include/hw/acpi/aml-build.h            |  2 ++
 include/hw/acpi/generic_event_device.h |  1 +
 hw/acpi/aml-build.c                    | 10 ++++++++++
 hw/acpi/generic_event_device.c         | 13 +++++++++++++
 5 files changed, 27 insertions(+)

diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
index 68d9d15f50..8294f8f0cc 100644
--- a/include/hw/acpi/acpi_dev_interface.h
+++ b/include/hw/acpi/acpi_dev_interface.h
@@ -13,6 +13,7 @@ typedef enum {
     ACPI_NVDIMM_HOTPLUG_STATUS = 16,
     ACPI_VMGENID_CHANGE_STATUS = 32,
     ACPI_POWER_DOWN_STATUS = 64,
+    ACPI_GENERIC_ERROR = 128,
 } AcpiEventStatusBits;
 
 #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index c18f681342..f38e129719 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -252,6 +252,7 @@ struct CrsRangeSet {
 /* Consumer/Producer */
 #define AML_SERIAL_BUS_FLAG_CONSUME_ONLY        (1 << 1)
 
+#define ACPI_APEI_ERROR_DEVICE   "GEDD"
 /**
  * init_aml_allocator:
  *
@@ -382,6 +383,7 @@ Aml *aml_dma(AmlDmaType typ, AmlDmaBusMaster bm, AmlTransferSize sz,
              uint8_t channel);
 Aml *aml_sleep(uint64_t msec);
 Aml *aml_i2c_serial_bus_device(uint16_t address, const char *resource_source);
+Aml *aml_error_device(void);
 
 /* Block AML object primitives */
 Aml *aml_scope(const char *name_format, ...) G_GNUC_PRINTF(1, 2);
diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
index 2c5b055327..130c014d3f 100644
--- a/include/hw/acpi/generic_event_device.h
+++ b/include/hw/acpi/generic_event_device.h
@@ -103,6 +103,7 @@ OBJECT_DECLARE_TYPE(AcpiGedState, AcpiGedClass, ACPI_GED)
 #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
 #define ACPI_GED_CPU_HOTPLUG_EVT    0x8
 #define ACPI_GED_PCI_HOTPLUG_EVT    0x10
+#define ACPI_GED_ERROR_EVT          0x20
 
 typedef struct GEDState {
     MemoryRegion evt;
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 1e685f982f..2d5826a8f1 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -2629,3 +2629,13 @@ Aml *aml_i2c_serial_bus_device(uint16_t address, const char *resource_source)
 
     return var;
 }
+
+/* ACPI 5.0b: 18.3.2.6.2 Event Notification For Generic Error Sources */
+Aml *aml_error_device(void)
+{
+    Aml *dev = aml_device(ACPI_APEI_ERROR_DEVICE);
+    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C33")));
+    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
+
+    return dev;
+}
diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index b1ff6ab74d..e575b9404b 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -30,6 +30,7 @@ static const uint32_t ged_supported_events[] = {
     ACPI_GED_NVDIMM_HOTPLUG_EVT,
     ACPI_GED_CPU_HOTPLUG_EVT,
     ACPI_GED_PCI_HOTPLUG_EVT,
+    ACPI_GED_ERROR_EVT,
 };
 
 /*
@@ -120,6 +121,16 @@ void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
                            aml_notify(aml_name(ACPI_POWER_BUTTON_DEVICE),
                                       aml_int(0x80)));
                 break;
+            case ACPI_GED_ERROR_EVT:
+                /*
+                 * ACPI 5.0b: 5.6.6 Device Object Notifications
+                 * Table 5-135 Error Device Notification Values
+                 * Defines 0x80 as the value to be used on notifications
+                 */
+                aml_append(if_ctx,
+                           aml_notify(aml_name(ACPI_APEI_ERROR_DEVICE),
+                                      aml_int(0x80)));
+                break;
             case ACPI_GED_NVDIMM_HOTPLUG_EVT:
                 aml_append(if_ctx,
                            aml_notify(aml_name("\\_SB.NVDR"),
@@ -320,6 +331,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
         sel = ACPI_GED_MEM_HOTPLUG_EVT;
     } else if (ev & ACPI_POWER_DOWN_STATUS) {
         sel = ACPI_GED_PWR_DOWN_EVT;
+    } else if (ev & ACPI_GENERIC_ERROR) {
+        sel = ACPI_GED_ERROR_EVT;
     } else if (ev & ACPI_NVDIMM_HOTPLUG_STATUS) {
         sel = ACPI_GED_NVDIMM_HOTPLUG_EVT;
     } else if (ev & ACPI_CPU_HOTPLUG_STATUS) {
-- 
MST


