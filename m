Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F330C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNx5-00083h-FH; Sun, 05 Jul 2026 10:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNx3-0007td-14
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:36:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNx1-0001UA-1l
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EowkyqYpt77ogpC25tBSGvHiPA9OIiKf4U4BzNArRJA=;
 b=SZEjojyNFexMXwt9PmERZnu4FAguM1WyPCeeSaSC99oOVr/bDXReVdfGhiEbaQZOxkaBJ+
 sTEjf4iDfN6Fs03aJ/QpC60SP0f62AZmPEIGlB8lujHRYRccVwpWa0iAvBo4bI6Kh7yv12
 UwpQdBME8mKdgQq9XIGxnrNdrP10TDA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-iUDVb1TXMUCwvLJsJIE8Zw-1; Sun, 05 Jul 2026 10:36:05 -0400
X-MC-Unique: iUDVb1TXMUCwvLJsJIE8Zw-1
X-Mimecast-MFC-AGG-ID: iUDVb1TXMUCwvLJsJIE8Zw_1783262164
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-493bf840a69so15255465e9.3
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262164; x=1783866964; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EowkyqYpt77ogpC25tBSGvHiPA9OIiKf4U4BzNArRJA=;
 b=XYa0WefROnuG+ClRTUo17JEeRhvZhJ9mG54ZI9VRoXECHO8mvWE15TAStWObinzb1O
 FEF+M1H1A+Gik0fShF3XYiMOCxoL96GOQ+oJEdY2BVFo+we/3bxLXkCWJIm1jn3pF2me
 Ck0VXJDhKHlkCycW4dFB+cVhb0UlKf+vPFPhP5w6cRz9TDEOcW2i3Xz4/9Dt4RIryBIq
 lqpd9mk1c3k8tMbSnvbUtsIlGs7XQAb5O/tNExvJYeuNuTBFJNSVyXnxpCnDIL/f1URJ
 1cJoKKZ/hEgR+M5dNUB3Bymc7EsIDL0Y3+kehYIUchR1T9v3FJvaeaUQSxs5zyinvsvb
 k7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262164; x=1783866964;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EowkyqYpt77ogpC25tBSGvHiPA9OIiKf4U4BzNArRJA=;
 b=APTBYZufi3skwJTLoPeNUp6jyfYKAAhf/LGFxBUU2uLeVrr9dh9LaqatAmH3Nbh+qD
 8bsRfhQOohes5IorI/SG9UyFzhACfmLWBOY/MEcak6E8Y08S4mRwgWmAEhR3WL6v3KBR
 BjMaorH44KeDdxpxJk01hPQhddcOO/FEW6ja7impJ1a0ie+weUFVGYkBuL90KEkRMUtH
 mecTwXPhBIJhHaE/SVlGI2j3c2kHYS1I0j6/YORPnqKjfe9sVOfzlGT+N0ofxtiu7F1e
 NfgI2myejbeibHbZ/ZSbr19RFgHd1jMcxzp1l9olPtHoWEGYGH1jEafIDuQ+HV/u0uvu
 +/og==
X-Gm-Message-State: AOJu0YybCK5YCAsjwxo6BKkUNgBowfT3zpaJyNSQOr6xdMVHi+iiyXHo
 rs+TT7UKudjSMsZdWbeIION6b/k3ZXK8rAOAceW3EaIgl/LkM30zWSZhBNYz3wLwBVAjmtY7zyV
 yQIe+j8lb5b+wKTFBJ1GDGSn+j5fkhbdt/RDTJ9VawcRPyterkuUWlJXKvev7+KgrVDzYHvs+D8
 PA+4pyOD5gSA5QSBUMFQXlzUlBUhY6Q1mHMg==
X-Gm-Gg: AfdE7cnOOsFplOw5XeVIsrzFPJSN+6SAq4zopW0znhglqn52p6pag3KsZniRthEK6Of
 4VqqklrT/egqCSciZUK0gHH8pP1GwUw/WbTYgW/2fCV4QD7HhX7QwloeGrzrt0gJEC9oeaQc+Gb
 d5LPnRQCTuXKhiVtHetYg8cZXr0MMiIjUKEbhTcmd330Jo6drHKk0Akf+fo8kDUtwTJn/nWHqk7
 e4EcaWftPhGQI02qmsclPnd3e9xqgFB2/2y+VPk5o1opDFHZr+x5NTsLLUCysqsAv5h1H3hPANG
 qe1K5eDcPKjPO971qqTF2xj5YKzwu1+zzLM+bB78dwbYYdTk2Ux0/g47au1MJQHgtkcZTlolNh1
 V7pB+PN6P1hlflyO6UFU3jLIZqQRcUJY9
X-Received: by 2002:a05:600d:110:b0:493:b750:b565 with SMTP id
 5b1f17b1804b1-493d11fe310mr44791065e9.35.1783262163674; 
 Sun, 05 Jul 2026 07:36:03 -0700 (PDT)
X-Received: by 2002:a05:600d:110:b0:493:b750:b565 with SMTP id
 5b1f17b1804b1-493d11fe310mr44790815e9.35.1783262163135; 
 Sun, 05 Jul 2026 07:36:03 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493cce03fa1sm202542715e9.11.2026.07.05.07.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:36:02 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:36:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-arm@nongnu.org
Subject: [PULL 33/44] arm: virt: add support for WDAT based watchdog
Message-ID: <285bc90d5b31775b7803e50822930a2914bf42de.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Igor Mammedov <imammedo@redhat.com>

Add WDAT handling for sbsa-gwdt on arm/virt machine.

WDAT mode is enabled by 'wdat' option: ex: "-device sbsa-gwdt,wdat=on"

When WDAT is enabled:
 - Build the WDAT ACPI table instead of the GTDT watchdog entry,
   since they are mutually exclusive due to different timer
   resolution (WDAT uses 1 kHz vs GTDT's system counter frequency).
 - Skip FDT watchdog node creation, as the DT-based Linux driver
   would use the system counter frequency which doesn't match the
   WDAT-mode 1 kHz clock.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260702145856.1539572-8-imammedo@redhat.com>
---
 docs/system/arm/virt.rst | 15 +++++++++++++++
 hw/arm/virt-acpi-build.c | 34 ++++++++++++++++++++++++++--------
 hw/arm/virt.c            | 12 ++++++++----
 3 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index bf5a9c8f6c..5f6dd17978 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -323,6 +323,21 @@ using ``-device sbsa-gwdt``. It is only supported on the virt machine,
 which wires up statically assigned MMIO regions and IRQs via
 machine-specific plug handlers.
 
+Two modes are available:
+
+Native mode (default)
+  The watchdog is described via the ACPI GTDT table and FDT, using
+  the system counter frequency. Example::
+
+    -device sbsa-gwdt
+
+WDAT mode
+  The watchdog is described via the ACPI WDAT table (no FDT node),
+  using a 1 kHz timer frequency. WDAT and GTDT watchdog entries are
+  mutually exclusive. Example::
+
+    -device sbsa-gwdt,wdat=on
+
 Linux guest kernel configuration
 """"""""""""""""""""""""""""""""
 
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index f5b3b4ce48..f6386088b6 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -65,6 +65,7 @@
 #include "target/arm/cpu.h"
 #include "target/arm/multiprocessing.h"
 #include "hw/watchdog/sbsa_gwdt.h"
+#include "hw/acpi/wdat-gwdt.h"
 
 #include "smmuv3-accel.h"
 #include "tegra241-cmdqv.h"
@@ -859,7 +860,8 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
  * 5.2.25 Generic Timer Description Table (GTDT)
  */
 static void
-build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
+build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms,
+           bool add_watchdog)
 {
     /*
      * Table 5-117 Flag Definitions
@@ -870,7 +872,6 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     AcpiTable table = { .sig = "GTDT", .rev = 3, .oem_id = vms->oem_id,
                         .oem_table_id = vms->oem_table_id };
     uint32_t gtdt_start = table_data->len;
-    Object *wdt = object_resolve_type_unambiguous(TYPE_WDT_SBSA, NULL);
 
     acpi_table_begin(&table, table_data);
 
@@ -903,12 +904,12 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     build_append_int_noprefix(table_data, 0xFFFFFFFFFFFFFFFF, 8);
 
     /* Platform Timer Count */
-    build_append_int_noprefix(table_data,  wdt ? 1 : 0, 4);
+    build_append_int_noprefix(table_data,  add_watchdog ? 1 : 0, 4);
     /* Platform Timer Offset */
     build_append_int_noprefix(table_data,
-        wdt ? (table_data->len - gtdt_start) +
-              4 + 4 + 4 /* len of this & following 2 fields to skip */
-            : 0, 4);
+        add_watchdog ? (table_data->len - gtdt_start) +
+                       4 + 4 + 4 /* len of this & following 2 fields to skip */
+                     : 0, 4);
 
     if (vms->ns_el2_virt_timer_irq) {
         /* Virtual EL2 Timer GSIV */
@@ -921,7 +922,7 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     }
 
     /* ACPI 6.5 spec: 5.2.25.2 ARM Generic Watchdog Structure (Table 5-124) */
-    if (wdt) {
+    if (add_watchdog) {
         hwaddr rbase = vms->memmap[VIRT_GWDT_REFRESH].base;
         hwaddr cbase = vms->memmap[VIRT_GWDT_CONTROL].base;
         int irq = ARM_SPI_BASE + vms->irqmap[VIRT_GWDT_WS0];
@@ -1332,13 +1333,19 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     GArray *table_offsets;
     unsigned dsdt, xsdt;
+    bool has_wdat = false;
     GArray *tables_blob = tables->table_data;
     MachineState *ms = MACHINE(vms);
     CPUCoreCaches caches[CPU_MAX_CACHES];
     unsigned int num_caches;
+    Object *wdt = object_resolve_type_unambiguous(TYPE_WDT_SBSA, NULL);
 
     num_caches = virt_get_caches(vms, caches);
 
+    if (wdt) {
+        has_wdat = object_property_get_bool(wdt, "wdat", &error_abort);
+    }
+
     table_offsets = g_array_new(false, true /* clear */,
                                         sizeof(uint32_t));
 
@@ -1357,6 +1364,17 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     acpi_add_table(table_offsets, tables_blob);
     build_madt(tables_blob, tables->linker, vms);
 
+    acpi_add_table(table_offsets, tables_blob);
+    if (wdt && has_wdat) {
+        uint64_t freq = object_property_get_uint(wdt, "clock-frequency",
+                                                 &error_abort);
+        build_gwdt_wdat(tables_blob, tables->linker,
+                        vms->oem_id, vms->oem_table_id,
+                        vms->memmap[VIRT_GWDT_REFRESH].base,
+                        vms->memmap[VIRT_GWDT_CONTROL].base,
+                        freq);
+    }
+
     if (!vmc->no_cpu_topology) {
         acpi_add_table(table_offsets, tables_blob);
         build_pptt(tables_blob, tables->linker, ms, vms->oem_id,
@@ -1364,7 +1382,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     }
 
     acpi_add_table(table_offsets, tables_blob);
-    build_gtdt(tables_blob, tables->linker, vms);
+    build_gtdt(tables_blob, tables->linker, vms, wdt && !has_wdat);
 
     acpi_add_table(table_offsets, tables_blob);
     {
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index eabc5274d5..fb916c341b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3846,10 +3846,12 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
         qdev_prop_set_array(dev, "reserved-regions", reserved_regions);
         g_free(resv_prop_str);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_WDT_SBSA)) {
-        uint64_t cntfrq = object_property_get_int(OBJECT(qemu_get_cpu(0)),
-                                                  "cntfrq", &error_abort);
+        if (!object_property_get_bool(OBJECT(dev), "wdat", &error_abort)) {
+            uint64_t cntfrq = object_property_get_int(OBJECT(qemu_get_cpu(0)),
+                                                      "cntfrq", &error_abort);
 
-        qdev_prop_set_uint64(dev, "clock-frequency", cntfrq);
+            qdev_prop_set_uint64(dev, "clock-frequency", cntfrq);
+        }
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_ARM_SMMUV3)) {
         if (vms->legacy_smmuv3_present || vms->iommu == VIRT_IOMMU_VIRTIO) {
             error_setg(errp, "virt machine already has %s set. "
@@ -3911,7 +3913,9 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
         sysbus_mmio_map(s, 1, cbase);
         sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->gic, irq));
 
-        create_gwdt_dt_bindings(vms);
+        if (!object_property_get_bool(OBJECT(dev), "wdat", &error_abort)) {
+            create_gwdt_dt_bindings(vms);
+        }
     }
 
     if (vms->platform_bus_dev) {
-- 
MST


