Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD582CAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:18:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UEd-00084q-Jy; Sun, 05 Oct 2025 15:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEA-0007hC-9i
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UE6-0006Rp-Pr
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xavtbsO28Ury7dy3GVu2kZqo6kk8GLRJLz1jzaO4qT4=;
 b=GZT7I4CBzZn50goRAoNn6WTJk2A1g/ElWPT1QM8217u/iY2H756H5B1c6Tr+SkcWSgckU/
 LHACx6Q222qDgsCJVCV64mwwTaXkhg5IMaDZivqz69z7XRb2NXMJ2SMu4sfzQNUnxQ6DY/
 zRdROxM/u/1AfoBBBRd1Ts0Nt87yXIs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-Ra0R3UedN7ee0Pg8blQt6Q-1; Sun, 05 Oct 2025 15:16:56 -0400
X-MC-Unique: Ra0R3UedN7ee0Pg8blQt6Q-1
X-Mimecast-MFC-AGG-ID: Ra0R3UedN7ee0Pg8blQt6Q_1759691816
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e31191379so26931965e9.3
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691815; x=1760296615;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xavtbsO28Ury7dy3GVu2kZqo6kk8GLRJLz1jzaO4qT4=;
 b=Vhzka+QrtWpHOXsZaqG31EIlrGqh16gFbHx1F4wlaWO7z2Y8qZgYXTSkiO7RUASBQf
 FTioCCVBgOQmj+jodBoFHjazX+Z1z0XyZDAVbpby0HrvSBJUzb5OH3nDSDZvHEb5Pbhy
 K0I8AZ8Aq0GIYZE60scM3brSjAxoB4xXd8JuxBoN0OpYLGcRNmKDHAkFOtMPNHDbWB2m
 k1Sv4RfsGypRpYp0qEHOTQzyzqIj0WV3WwrpOD695sim0bExLO2KG7xp1S7+WJt3/DB8
 HdgObmHKfVWcvsS+4jwgK/tj41+wKuQEoSei9NtuXd3cp2RxNuqHOYlAhCY04rzI2CGu
 EELA==
X-Gm-Message-State: AOJu0YwDBgiSUzqWLsncULd6uphfJWrJYMLiszVPf72r6MPa433aTv9v
 W/7H0VPhZm5CioGDT/ew2HBAgQf32Vs5hdGMgyUMjmz61N1KFAOYaWqIYyDl4PXZeGnVG17bDrE
 J/0XnPvFSw543MYQkhgn0PErU0RWNr05az/pMkPDbV+W+1KJCDrXj3nQC8xLxoZK1qgIp4wA1yb
 ps1Qs8JQXR8oPMmOkBwjq1D9xhAZi/oNh/sw==
X-Gm-Gg: ASbGncvoPPDfgULm9yR/ri9UEpJAFHkTF20t6O+IXE3XOOeEqXnUQPLiWq8zpWJRkaz
 EFZNbIhHbyPjHeDbKVz+XWWQTT6oOZiUEGxpOyXB9ejg0PJPvqY9GRr/fX4jF/+mv8yVs9MWfXG
 TcYhRJIfHHiC5g9I8pXjPONO7yTygqRVDEd4dGCPhbwZ9BLpxyVWl7bcTl3ZmN0zz0wENlu6spg
 1flEaoFlG9q7bPdEyWHP930bElc8VNafTui52KPlT+KXJj7DtxIeNx9RkXiMHmsKwG4/jEM80f4
 MVAFjxhasgJNeRB66JllNzymhOI5Wn192X3z6lM=
X-Received: by 2002:a05:600c:154a:b0:46e:45d3:82fa with SMTP id
 5b1f17b1804b1-46e7226ec1amr71530395e9.10.1759691815276; 
 Sun, 05 Oct 2025 12:16:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgwK2V48bBV5m648z4rnqwwnHr2PY/NKOjrKUyPg13UZLzoeVoUF8y4L8b9Nzty4+OleOLMA==
X-Received: by 2002:a05:600c:154a:b0:46e:45d3:82fa with SMTP id
 5b1f17b1804b1-46e7226ec1amr71530125e9.10.1759691814751; 
 Sun, 05 Oct 2025 12:16:54 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a0241bsm215815915e9.11.2025.10.05.12.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:16:54 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:16:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org
Subject: [PULL 23/75] acpi/generic_event_device: add logic to detect if HEST
 addr is available
Message-ID: <f3f747ddcfc9af2c2c58f70a68723b99db82f778.1759691708.git.mst@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Create a new property (x-has-hest-addr) and use it to detect if
the GHES table offsets can be calculated from the HEST address
(qemu 10.0 and upper) or via the legacy way via an offset obtained
from the hardware_errors firmware file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <c4eb3cf32a3f158ae62dac29e866ac3f373956c3.1758610789.git.mchehab+huawei@kernel.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/generic_event_device.c |  2 ++
 hw/arm/virt-acpi-build.c       | 18 ++++++++++++++++--
 hw/core/machine.c              |  5 ++++-
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 55998303c2..b1ff6ab74d 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -349,6 +349,8 @@ static const Property acpi_ged_properties[] = {
                      pcihp_state.use_acpi_hotplug_bridge, 0),
     DEFINE_PROP_LINK("bus", AcpiGedState, pcihp_state.root,
                      TYPE_PCI_BUS, PCIBus *),
+    DEFINE_PROP_BOOL("x-has-hest-addr", AcpiGedState,
+                     ghes_state.use_hest_addr, false),
 };
 
 static const VMStateDescription vmstate_memhp_state = {
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index c856d293c6..ff3b7a794b 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -1129,6 +1129,10 @@ static const AcpiNotificationSourceId hest_ghes_notify[] = {
     { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
 };
 
+static const AcpiNotificationSourceId hest_ghes_notify_10_0[] = {
+    { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
+};
+
 static
 void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
 {
@@ -1186,15 +1190,25 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
 
     if (vms->ras) {
         AcpiGedState *acpi_ged_state;
+        static const AcpiNotificationSourceId *notify;
+        unsigned int notify_sz;
         AcpiGhesState *ags;
 
         acpi_ged_state = ACPI_GED(vms->acpi_dev);
         ags = &acpi_ged_state->ghes_state;
         if (ags) {
             acpi_add_table(table_offsets, tables_blob);
+
+            if (!ags->use_hest_addr) {
+                notify = hest_ghes_notify_10_0;
+                notify_sz = ARRAY_SIZE(hest_ghes_notify_10_0);
+            } else {
+                notify = hest_ghes_notify;
+                notify_sz = ARRAY_SIZE(hest_ghes_notify);
+            }
+
             acpi_build_hest(ags, tables_blob, tables->hardware_errors,
-                            tables->linker, hest_ghes_notify,
-                            ARRAY_SIZE(hest_ghes_notify),
+                            tables->linker, notify, notify_sz,
                             vms->oem_id, vms->oem_table_id);
         }
     }
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 38c949c4f2..7b7a381b0a 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -35,9 +35,12 @@
 #include "hw/virtio/virtio-pci.h"
 #include "hw/virtio/virtio-net.h"
 #include "hw/virtio/virtio-iommu.h"
+#include "hw/acpi/generic_event_device.h"
 #include "audio/audio.h"
 
-GlobalProperty hw_compat_10_1[] = {};
+GlobalProperty hw_compat_10_1[] = {
+    { TYPE_ACPI_GED, "x-has-hest-addr", "false" },
+};
 const size_t hw_compat_10_1_len = G_N_ELEMENTS(hw_compat_10_1);
 
 GlobalProperty hw_compat_10_0[] = {
-- 
MST


