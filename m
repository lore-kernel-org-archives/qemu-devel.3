Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1281260A2609
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h6sy23Z0;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=LK33oPC/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7HS-0003eZ-68; Wed, 28 Oct 2026 13:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Gy-0001fv-G0
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:17:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Gw-000407-2X
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H85Tytk0oaU/ibnfdrB63eJgjeQdIV2POVsyoAuUAMs=;
 b=h6sy23Z0/xVATufzt6jvnjCwPS2zFp7S4047baQc80waSEJPqbPTKQoXBQjpQLWF+3+d56
 Cjyd69JCGYQQktFyD7IVAYG5VWmjKEjA+lCSDQsbMJibKxKnAfJw0rya6aYX1CeXz/RqjB
 Npaf07J6l19uX7rykfnINOUzlwo6ytg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-MGgKuoTRO5u_vRFHXOTgJA-1; Wed, 28 Oct 2026 13:17:02 -0400
X-MC-Unique: MGgKuoTRO5u_vRFHXOTgJA-1
X-Mimecast-MFC-AGG-ID: MGgKuoTRO5u_vRFHXOTgJA_1793207821
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a80bd45e1cso6881825e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207821; x=1793812621; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=H85Tytk0oaU/ibnfdrB63eJgjeQdIV2POVsyoAuUAMs=;
 b=LK33oPC/Uy2pV3NAhnxp9wdasswAxWqlZ+7tmtcooNlbSLH/VexsRlJLZqce7AycEU
 cOv82AHpqR89VTAiWb7W/cAgVAtHmRNW8mfZ1Lc2nif/QmnnVvhlwjVHg/AW3nV5/nxl
 E5Y8wzdySpNqTcBQwhW5oxYwmXbiSEKnB3mR+a5JUQNBWz+91uJXZcjU2UKOpH0vPPzK
 UHFLxHxeIv1kJTYblZ1C+3cJHI0XUsevcskXB7e+l6XOU675MQcJFW3O+F8yU5JemiFK
 87RXLmpetDR5ur2mzgjlSo8D7QaZJmXZcib2VbSoefHpbqD2bybNCWIYJZAwpc/BfBuQ
 M0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207821; x=1793812621;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H85Tytk0oaU/ibnfdrB63eJgjeQdIV2POVsyoAuUAMs=;
 b=eReEUOCr59HWHeyFaRAuvWfxzpjySH4s6y5gdVcM3dBbmw6s36BZkIK30zUw4CcZaH
 xehI1i6vuhm15rBWrFMCCeE2y2Mqww0H8VN/uzZnm+TXHDKzGjgia8iZgssmQxVzCSpv
 tqrqY4VoNN6MrmBh8EEvRd6EUPdMN94XQtG44ELa2snI5GNnZdzkvtFNEWWDupEjZ+nY
 2m+eCfDCWTR1q2lgDGLbf+2T8bNyhAwkIv5aCveGnD9WMX0Z/jLysKmJGuOALjg+qwyH
 nkQujV3WUohLlL98tjcXhkewqfxPCW3JTHUhg32j6dwl8twhIu3bTBi7sBH4aR+hWzlZ
 6KwQ==
X-Gm-Message-State: AFq9FYJu8Xv6uWSwleD8xGMjEXmq1SN7ozIbaemW6kDuc0jkoFJEJJDt
 x9VSCk+ut8O/wn+R6rrkN/loBO9t4tFlCFuUzKHuUwVKIUtDgMmlq6GoowM8nuhOD5C7K0O+ytL
 F1H9WzmFfQkI51gXN5K012pgQicr8LO2l/GNYmZsaxTMnP4jpnP8wPa0FtkzLr8zxa8ximmAwMp
 IZG9wsn+76yR1HwEuoq4FKBuXVZpGFBAYCQQ==
X-Gm-Gg: AYBFou0L9cWaJtcdspPS7099zBUVnL+O9R7YGUI2CpVmkhka6O2YDhiT1myuDbZ06em
 hVeGCw7MLQNJ7CYmqO61hOmHKGdDngZlsP4NEPCS6IJHw3GzOp+1RYYDLwvfQTOOzTECY7XZj+a
 dd8PyZ/mgQROdDB8rUjLVQLQXZ3ujd8WGWLC6piAXofGnI7/uy8U0XPYzXlenPJrF0XhR/Z1zCC
 5/42M1J0VaszzhJWatpGlMAddGze5HExZfcPu+pr16v592CVaugGlmtdVaiPp6N8guRWoltXXvC
 cdeosE9JI8W2uK0KkDPQm6FdyCEfd6Vf7/N74aQ2JAp2Ug2p7GlpZE6kSv61iJeNHC+YILdFRv2
 sdVCicGs1/XXnpMTZedTZ8Ws+wbuddQ7O/xzMa52u
X-Received: by 2002:a05:600c:3556:b0:4a2:1cc:6551 with SMTP id
 5b1f17b1804b1-4a9678c3cadmr71325825e9.35.1793207820521; 
 Wed, 28 Oct 2026 10:17:00 -0700 (PDT)
X-Received: by 2002:a05:600c:3556:b0:4a2:1cc:6551 with SMTP id
 5b1f17b1804b1-4a9678c3cadmr71324535e9.35.1793207819618; 
 Wed, 28 Oct 2026 10:16:59 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7fdb7691sm6109085e9.11.2026.10.28.10.16.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:16:58 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:16:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 67/78] acpi-build: Create PCI topology using amd iommu root bus
Message-ID: <30ce0dcb3276b064d37df46f2a8bf866b8e35e5a.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sairaj Kodilkar <sarunkod@amd.com>

Current AMD IOMMU ACPI build adds all the devices and buses under the
IVHD. In order to support the IOMMU attached on a non system bus and
serving only child devices of that bus, start exploring devices from the
child bus. Also, use child list provided by the PCIBus, instead of
iterating over all the objects in the qemu to find pci bridges.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261014053433.24564-8-sarunkod@amd.com>
---
 hw/i386/acpi-build.c | 152 ++++++++++++++++++++++---------------------
 1 file changed, 79 insertions(+), 73 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 6d7308b4e4..9855154349 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1763,83 +1763,89 @@ insert_ivhd(PCIBus *bus, PCIDevice *dev, void *opaque)
     /* "Select" IVHD entry, type 0x2 */
     entry = PCI_BUILD_BDF(pci_bus_num(bus), dev->devfn) << 8 | 0x2;
     build_append_int_noprefix(table_data, entry, 4);
-
-    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
-        PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(dev));
-        uint8_t sec = pci_bus_num(sec_bus);
-        uint8_t sub = dev->config[PCI_SUBORDINATE_BUS];
-
-        if (pci_bus_is_express(sec_bus)) {
-            /*
-             * Walk the bus if there are subordinates, otherwise use a range
-             * to cover an entire leaf bus.  We could potentially also use a
-             * range for traversed buses, but we'd need to take care not to
-             * create both Select and Range entries covering the same device.
-             * This is easier and potentially more compact.
-             *
-             * An example bare metal system seems to use Select entries for
-             * root ports without a slot (ie. built-ins) and Range entries
-             * when there is a slot.  The same system also only hard-codes
-             * the alias range for an onboard PCIe-to-PCI bridge, apparently
-             * making no effort to support nested bridges.  We attempt to
-             * be more thorough here.
-             */
-            if (sec == sub) { /* leaf bus */
-                /* "Start of Range" IVHD entry, type 0x3 */
-                entry = PCI_BUILD_BDF(sec, PCI_DEVFN(0, 0)) << 8 | 0x3;
-                build_append_int_noprefix(table_data, entry, 4);
-                /* "End of Range" IVHD entry, type 0x4 */
-                entry = PCI_BUILD_BDF(sub, PCI_DEVFN(31, 7)) << 8 | 0x4;
-                build_append_int_noprefix(table_data, entry, 4);
-            } else {
-                pci_for_each_device(sec_bus, sec, insert_ivhd, table_data);
-            }
-        } else {
-            /*
-             * If the secondary bus is conventional, then we need to create an
-             * Alias range for everything downstream.  The range covers the
-             * first devfn on the secondary bus to the last devfn on the
-             * subordinate bus.  The alias target depends on legacy versus
-             * express bridges, just as in pci_device_iommu_address_space().
-             * DeviceIDa vs DeviceIDb as per the AMD IOMMU spec.
-             */
-            uint16_t dev_id_a, dev_id_b;
-
-            dev_id_a = PCI_BUILD_BDF(sec, PCI_DEVFN(0, 0));
-
-            if (pci_is_express(dev) &&
-                pcie_cap_get_type(dev) == PCI_EXP_TYPE_PCI_BRIDGE) {
-                dev_id_b = dev_id_a;
-            } else {
-                dev_id_b = PCI_BUILD_BDF(pci_bus_num(bus), dev->devfn);
-            }
-
-            /* "Alias Start of Range" IVHD entry, type 0x43, 8 bytes */
-            build_append_int_noprefix(table_data, dev_id_a << 8 | 0x43, 4);
-            build_append_int_noprefix(table_data, dev_id_b << 8 | 0x0, 4);
-
-            /* "End of Range" IVHD entry, type 0x4 */
-            entry = PCI_BUILD_BDF(sub, PCI_DEVFN(31, 7)) << 8 | 0x4;
-            build_append_int_noprefix(table_data, entry, 4);
-        }
-    }
 }
 
-/* For all PCI host bridges, walk and insert IVHD entries */
-static int
-ivrs_host_bridges(Object *obj, void *opaque)
+/*
+ * Insert IVHD entry for device and recurse, insert alias, or insert range as
+ * necessary for the PCI topology.
+ */
+static void add_ivhd_entries_from_bus(PCIBus *bus, GArray *table_data)
 {
-    GArray *ivhd_blob = opaque;
+    uint8_t sub;
+    uint32_t entry;
+    PCIBus *child_bus;
+    PCIDevice *parent_dev;
 
-    if (object_dynamic_cast(obj, TYPE_PCI_HOST_BRIDGE)) {
-        PCIBus *bus = PCI_HOST_BRIDGE(obj)->bus;
-
-        if (bus && !pci_bus_bypass_iommu(bus)) {
-            pci_for_each_device_under_bus(bus, insert_ivhd, ivhd_blob);
-        }
+    if (!bus->parent_dev) {
+        goto select_devices;
     }
 
-    return 0;
+    parent_dev = bus->parent_dev;
+    sub = parent_dev->config[PCI_SUBORDINATE_BUS];
+
+    if (pci_bus_is_express(bus)) {
+        /*
+         * Walk the bus if there are subordinates, otherwise use a range
+         * to cover an entire leaf bus.  We could potentially also use a
+         * range for traversed buses, but we'd need to take care not to
+         * create both Select and Range entries covering the same device.
+         * This is easier and potentially more compact.
+         *
+         * An example bare metal system seems to use Select entries for
+         * root ports without a slot (ie. built-ins) and Range entries
+         * when there is a slot.  The same system also only hard-codes
+         * the alias range for an onboard PCIe-to-PCI bridge, apparently
+         * making no effort to support nested bridges.  We attempt to
+         * be more thorough here.
+         */
+        if (sub != pci_bus_num(bus)) {
+            goto select_devices;
+        }
+        /* "Start of Range" IVHD entry, type 0x3 */
+        entry = PCI_BUILD_BDF(sub, PCI_DEVFN(0, 0)) << 8 | 0x3;
+        build_append_int_noprefix(table_data, entry, 4);
+        /* "End of Range" IVHD entry, type 0x4 */
+        entry = PCI_BUILD_BDF(sub, PCI_DEVFN(31, 7)) << 8 | 0x4;
+        build_append_int_noprefix(table_data, entry, 4);
+
+        return;
+    } else {
+        /*
+         * If the secondary bus is conventional, then we need to create an
+         * Alias range for everything downstream.  The range covers the
+         * first devfn on the secondary bus to the last devfn on the
+         * subordinate bus.  The alias target depends on legacy versus
+         * express bridges, just as in pci_device_iommu_address_space().
+         * DeviceIDa vs DeviceIDb as per the AMD IOMMU spec.
+         */
+        uint16_t dev_id_a, dev_id_b;
+
+        dev_id_a = PCI_BUILD_BDF(pci_bus_num(bus), PCI_DEVFN(0, 0));
+
+        if (pci_is_express(parent_dev) &&
+            pcie_cap_get_type(parent_dev) == PCI_EXP_TYPE_PCI_BRIDGE) {
+            dev_id_b = dev_id_a;
+        } else {
+            dev_id_b = PCI_BUILD_BDF(pci_bus_num(pci_get_bus(parent_dev)),
+                                     parent_dev->devfn);
+        }
+
+        /* "Alias Start of Range" IVHD entry, type 0x43, 8 bytes */
+        build_append_int_noprefix(table_data, dev_id_a << 8 | 0x43, 4);
+        build_append_int_noprefix(table_data, dev_id_b << 8 | 0x0, 4);
+
+        /* "End of Range" IVHD entry, type 0x4 */
+        entry = PCI_BUILD_BDF(sub, PCI_DEVFN(31, 7)) << 8 | 0x4;
+        build_append_int_noprefix(table_data, entry, 4);
+        return;
+    }
+
+select_devices:
+    pci_for_each_device_under_bus(bus, insert_ivhd, table_data);
+
+    QLIST_FOREACH(child_bus, &bus->child, sibling) {
+        add_ivhd_entries_from_bus(child_bus, table_data);
+    }
 }
 
 /*
@@ -1904,8 +1910,8 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
      * blob further below.  Fall back to an entry covering all devices, which
      * is sufficient when no aliases are present.
      */
-    object_child_foreach_recursive(object_get_root(),
-                                   ivrs_host_bridges, ivhd_blob);
+    assert(s->root_bus);
+    add_ivhd_entries_from_bus(s->root_bus, ivhd_blob);
 
     if (!ivhd_blob->len) {
         /*
-- 
MST


