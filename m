Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52E7D1BDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:11:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84J5-00033N-T0; Mon, 04 Nov 2024 16:08:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Im-0002hA-LW
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:07:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Ik-0005Qe-JD
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:07:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SEbzwh5CXMMgSRIskBWVC858+AHstI7QTR6oOdrnG3c=;
 b=TEUPNb0fX8tD0BBRLmRE9b/2s3LCLjukuY8txZCisbm93dYX1XHcae4fDkrO0OdzKAKM+1
 GXnPvSDPk01mQHudnx38rr7N9g9bOl4aSwtPQ8qyfuHtZoSEr//WzFJ6fQQxcGzmxx9gDt
 Nu/m27+Cb4ZJj3SbjfIkUX5VsaqoO04=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-eS6HA3PGPlO41o5ByrGXZw-1; Mon, 04 Nov 2024 16:07:51 -0500
X-MC-Unique: eS6HA3PGPlO41o5ByrGXZw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43152cd2843so27537085e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:07:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754470; x=1731359270;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SEbzwh5CXMMgSRIskBWVC858+AHstI7QTR6oOdrnG3c=;
 b=ZWTbzUNVSZrOCUAJFmNaozGOi3vkqlgtnMlT6HyeUTmazh8msWIM/pU+khPW8lk5Sp
 oBn8Mn5ENvDI5X5a6fVmXrEio3HsE1Qcy0h7IwrliSiLz9FypWGiWT6X5N1LD6opM9Kn
 t2wTfflrQiYxmqGaWKGRi8TbCs/dAlI+eA94n42lshXv3WjrZz98j5sT2UxbJE89Kcdq
 Z9GFsPRl1Xdf8jXboKPPZI51ShOGqf6dOQVV27R/uUOMz+3ZpmPTT3ldgVUoCwEsqBNH
 /N6daGDUutmdg+VMPqk8GcSMsn0L8jDMfzWHaUhMVN2eGGEG8Eg3WG0jZvwFJK133HRB
 UfUA==
X-Gm-Message-State: AOJu0YzPUazBbV77S737GD7eKWCEKu97IiR+cUw3+J5arMigMPTjS2CA
 rNaEWnSPRE0RfutfV5J0gqZHuh3ZE40lpWPXDFfXSw/puotu5sQPBi35ukV2WPYAqjLCXjYKIQB
 o2iLDJGw5ZM9nBq4aybEtxMQY4NycPydBLC63WYolz7gAT1UngDckXSks4llg5n/3kFsAKkJTaq
 UvRqxoPsCyFP88zkBtnf2rEBEEzvJBzQ==
X-Received: by 2002:a05:600c:1c94:b0:431:59b2:f0d1 with SMTP id
 5b1f17b1804b1-431bb976dd4mr184005015e9.4.1730754469919; 
 Mon, 04 Nov 2024 13:07:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVb1FEqhrNf0kR3HAjQ/CCgEH/mDlp2ntwv3Bm06ATDPZvsq2zPcCMpuTU7MvM8yx22m9bqQ==
X-Received: by 2002:a05:600c:1c94:b0:431:59b2:f0d1 with SMTP id
 5b1f17b1804b1-431bb976dd4mr184004725e9.4.1730754469429; 
 Mon, 04 Nov 2024 13:07:49 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd947c0esm202542105e9.24.2024.11.04.13.07.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:07:47 -0800 (PST)
Date: Mon, 4 Nov 2024 16:07:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gao Shiyuan <gaoshiyuan@baidu.com>, Zuo Boqun <zuoboqun@baidu.com>,
 Wang Liang <wangliang44@baidu.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexander Bulekov <alxndr@bu.edu>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 33/65] virtio-pci: fix memory_region_find for
 VirtIOPCIRegion's MR
Message-ID: <55fa4be6f76a3e1b1caa33a8f0ab4dc217d32e49.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Gao Shiyuan <gaoshiyuan@baidu.com>

As shown below, if a virtio PCI device is attached under a pci-bridge, the MR
of VirtIOPCIRegion does not belong to any address space. So memory_region_find
cannot be used to search for this MR.

Introduce the virtio-pci and pci_bridge address spaces to solve this problem.

Before:
memory-region: pci_bridge_pci
  0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pci
    00000000fe840000-00000000fe840fff (prio 1, i/o): virtio-net-pci-msix
      00000000fe840000-00000000fe84003f (prio 0, i/o): msix-table
      00000000fe840800-00000000fe840807 (prio 0, i/o): msix-pba
    0000380000000000-0000380000003fff (prio 1, i/o): virtio-pci
      0000380000000000-0000380000000fff (prio 0, i/o): virtio-pci-common-virtio-net
      0000380000001000-0000380000001fff (prio 0, i/o): virtio-pci-isr-virtio-net
      0000380000002000-0000380000002fff (prio 0, i/o): virtio-pci-device-virtio-net
      0000380000003000-0000380000003fff (prio 0, i/o): virtio-pci-notify-virtio-net

After:
address-space: virtio-pci-cfg-mem-as
  0000380000000000-0000380000003fff (prio 1, i/o): virtio-pci
    0000380000000000-0000380000000fff (prio 0, i/o): virtio-pci-common-virtio-net
    0000380000001000-0000380000001fff (prio 0, i/o): virtio-pci-isr-virtio-net
    0000380000002000-0000380000002fff (prio 0, i/o): virtio-pci-device-virtio-net
    0000380000003000-0000380000003fff (prio 0, i/o): virtio-pci-notify-virtio-net

address-space: pci_bridge_pci_mem
  0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pci
    00000000fe840000-00000000fe840fff (prio 1, i/o): virtio-net-pci-msix
      00000000fe840000-00000000fe84003f (prio 0, i/o): msix-table
      00000000fe840800-00000000fe840807 (prio 0, i/o): msix-pba
    0000380000000000-0000380000003fff (prio 1, i/o): virtio-pci
      0000380000000000-0000380000000fff (prio 0, i/o): virtio-pci-common-virtio-net
      0000380000001000-0000380000001fff (prio 0, i/o): virtio-pci-isr-virtio-net
      0000380000002000-0000380000002fff (prio 0, i/o): virtio-pci-device-virtio-net
      0000380000003000-0000380000003fff (prio 0, i/o): virtio-pci-notify-virtio-net

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2576
Fixes: ffa8a3e3b2e6 ("virtio-pci: Add lookup subregion of VirtIOPCIRegion MR")
Co-developed-by: Zuo Boqun <zuoboqun@baidu.com>
Signed-off-by: Zuo Boqun <zuoboqun@baidu.com>
Co-developed-by: Wang Liang <wangliang44@baidu.com>
Signed-off-by: Wang Liang <wangliang44@baidu.com>
Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
Message-Id: <20241030131324.34144-1-gaoshiyuan@baidu.com>
Tested-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pci_bridge.h            |  2 ++
 include/hw/virtio/virtio-pci.h         |  3 +++
 hw/pci/pci_bridge.c                    |  5 ++++
 hw/virtio/virtio-pci.c                 | 10 +++++++
 tests/qtest/fuzz-virtio-balloon-test.c | 37 ++++++++++++++++++++++++++
 tests/qtest/meson.build                |  1 +
 6 files changed, 58 insertions(+)
 create mode 100644 tests/qtest/fuzz-virtio-balloon-test.c

diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index 5456e24883..b0f5204d80 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -72,6 +72,8 @@ struct PCIBridge {
      */
     MemoryRegion address_space_mem;
     MemoryRegion address_space_io;
+    AddressSpace as_mem;
+    AddressSpace as_io;
 
     PCIBridgeWindows windows;
 
diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 9e67ba38c7..971c5fabd4 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -147,6 +147,9 @@ struct VirtIOPCIProxy {
     };
     MemoryRegion modern_bar;
     MemoryRegion io_bar;
+    /* address space for VirtIOPCIRegions */
+    AddressSpace modern_cfg_mem_as;
+    AddressSpace modern_cfg_io_as;
     uint32_t legacy_io_bar_idx;
     uint32_t msix_bar_idx;
     uint32_t modern_io_bar_idx;
diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index 6a4e38856d..2c7bb1a525 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -380,9 +380,12 @@ void pci_bridge_initfn(PCIDevice *dev, const char *typename)
     sec_bus->map_irq = br->map_irq ? br->map_irq : pci_swizzle_map_irq_fn;
     sec_bus->address_space_mem = &br->address_space_mem;
     memory_region_init(&br->address_space_mem, OBJECT(br), "pci_bridge_pci", UINT64_MAX);
+    address_space_init(&br->as_mem, &br->address_space_mem,
+                       "pci_bridge_pci_mem");
     sec_bus->address_space_io = &br->address_space_io;
     memory_region_init(&br->address_space_io, OBJECT(br), "pci_bridge_io",
                        4 * GiB);
+    address_space_init(&br->as_io, &br->address_space_io, "pci_bridge_pci_io");
     pci_bridge_region_init(br);
     QLIST_INIT(&sec_bus->child);
     QLIST_INSERT_HEAD(&parent->child, sec_bus, sibling);
@@ -399,6 +402,8 @@ void pci_bridge_exitfn(PCIDevice *pci_dev)
     PCIBridge *s = PCI_BRIDGE(pci_dev);
     assert(QLIST_EMPTY(&s->sec_bus.child));
     QLIST_REMOVE(&s->sec_bus, sibling);
+    address_space_destroy(&s->as_mem);
+    address_space_destroy(&s->as_io);
     pci_bridge_region_del(s, &s->windows);
     pci_bridge_region_cleanup(s, &s->windows);
     /* object_unparent() is called automatically during device deletion */
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index c5a809b956..5a394821da 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2057,6 +2057,8 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
         if (modern_pio) {
             memory_region_init(&proxy->io_bar, OBJECT(proxy),
                                "virtio-pci-io", 0x4);
+            address_space_init(&proxy->modern_cfg_io_as, &proxy->io_bar,
+                               "virtio-pci-cfg-io-as");
 
             pci_register_bar(&proxy->pci_dev, proxy->modern_io_bar_idx,
                              PCI_BASE_ADDRESS_SPACE_IO, &proxy->io_bar);
@@ -2180,6 +2182,9 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
                        /* PCI BAR regions must be powers of 2 */
                        pow2ceil(proxy->notify.offset + proxy->notify.size));
 
+    address_space_init(&proxy->modern_cfg_mem_as, &proxy->modern_bar,
+                       "virtio-pci-cfg-mem-as");
+
     if (proxy->disable_legacy == ON_OFF_AUTO_AUTO) {
         proxy->disable_legacy = pcie_port ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
     }
@@ -2269,12 +2274,17 @@ static void virtio_pci_exit(PCIDevice *pci_dev)
     VirtIOPCIProxy *proxy = VIRTIO_PCI(pci_dev);
     bool pcie_port = pci_bus_is_express(pci_get_bus(pci_dev)) &&
                      !pci_bus_is_root(pci_get_bus(pci_dev));
+    bool modern_pio = proxy->flags & VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY;
 
     msix_uninit_exclusive_bar(pci_dev);
     if (proxy->flags & VIRTIO_PCI_FLAG_AER && pcie_port &&
         pci_is_express(pci_dev)) {
         pcie_aer_exit(pci_dev);
     }
+    address_space_destroy(&proxy->modern_cfg_mem_as);
+    if (modern_pio) {
+        address_space_destroy(&proxy->modern_cfg_io_as);
+    }
 }
 
 static void virtio_pci_reset(DeviceState *qdev)
diff --git a/tests/qtest/fuzz-virtio-balloon-test.c b/tests/qtest/fuzz-virtio-balloon-test.c
new file mode 100644
index 0000000000..ecb597fbee
--- /dev/null
+++ b/tests/qtest/fuzz-virtio-balloon-test.c
@@ -0,0 +1,37 @@
+/*
+ * QTest fuzzer-generated testcase for virtio balloon device
+ *
+ * Copyright (c) 2024 Gao Shiyuan <gaoshiyuan@baidu.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+/*
+ * https://gitlab.com/qemu-project/qemu/-/issues/2576
+ * Used to trigger:
+ *   virtio_address_space_lookup: Assertion `mrs.mr' failed.
+ */
+static void oss_fuzz_71649(void)
+{
+    QTestState *s = qtest_init("-device virtio-balloon -machine q35"
+                               " -nodefaults");
+
+    qtest_outl(s, 0xcf8, 0x80000890);
+    qtest_outl(s, 0xcfc, 0x2);
+    qtest_outl(s, 0xcf8, 0x80000891);
+    qtest_inl(s, 0xcfc);
+    qtest_quit(s);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("fuzz/virtio/oss_fuzz_71649", oss_fuzz_71649);
+
+    return g_test_run();
+}
+
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 9d51114539..924dc4be57 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -88,6 +88,7 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_MEGASAS_SCSI_PCI') ? ['fuzz-megasas-test'] : []) +    \
   (config_all_devices.has_key('CONFIG_LSI_SCSI_PCI') ? ['fuzz-lsi53c895a-test'] : []) +     \
   (config_all_devices.has_key('CONFIG_VIRTIO_SCSI') ? ['fuzz-virtio-scsi-test'] : []) +     \
+  (config_all_devices.has_key('CONFIG_VIRTIO_BALLOON') ? ['fuzz-virtio-balloon-test'] : []) + \
   (config_all_devices.has_key('CONFIG_Q35') ? ['q35-test'] : []) +                          \
   (config_all_devices.has_key('CONFIG_SB16') ? ['fuzz-sb16-test'] : []) +                   \
   (config_all_devices.has_key('CONFIG_SDHCI_PCI') ? ['fuzz-sdcard-test'] : []) +            \
-- 
MST


