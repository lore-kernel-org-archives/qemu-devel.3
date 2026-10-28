Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A42B606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MoyJrs54;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=j62xFejp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7HN-00037l-8n; Wed, 28 Oct 2026 13:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Gx-0001eC-A9
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:17:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Gt-0003zi-AK
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BdRSOQrYlcv9m7KstSABxRosvTx2r28hlh0BeKbE/iU=;
 b=MoyJrs54xI5tA/BqCO09kPksVEsfeaW/I82rqsT86g8laPaiby+iu2G1HViuPDLzlGNUzr
 iz6vUOsDDQR4/yHNyOaT1PaZWqfl8/qMq87Ps+e9kEcxLTWfiNcDet6mFjaRPax4SKgGJ5
 e6sS5QNKQQpLmRKzBFDCTNXShm8lVvg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-ywrPhis0NWicK6GZ9Q_XOA-1; Wed, 28 Oct 2026 13:17:04 -0400
X-MC-Unique: ywrPhis0NWicK6GZ9Q_XOA-1
X-Mimecast-MFC-AGG-ID: ywrPhis0NWicK6GZ9Q_XOA_1793207823
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a1f03f2e8aso11114115e9.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207823; x=1793812623; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BdRSOQrYlcv9m7KstSABxRosvTx2r28hlh0BeKbE/iU=;
 b=j62xFejpY+nf3yDb8djbevz+9dgzRUMy1VVyMCXe+qTjH7WEM0lQXm5sUxnCUjhkiT
 hWHnPktcASuKjepVPXQANo4JNxzYvomm4HiBK6roGQ/ggJM9WPRjQov9M9311WCwMVFE
 +Dbn8QFEFV0F+9JGHklc7GXkVh718x21XNcR+OTjzu7H3c6YrSw5i31CtDaFSczhifGl
 uS7tXn0UXh732IyhDJ1LG3r6t357AQLIgobkV4y9NH0NinJGMqdF9vezt+SZd9X3ZHpD
 z9Turcrz0xPbLBwuF7y35Rh0JkFhpjVAUjCrK41uTVX5WjkBZ6g25U3ssVARevGHUSNv
 +dWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207823; x=1793812623;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BdRSOQrYlcv9m7KstSABxRosvTx2r28hlh0BeKbE/iU=;
 b=tI2cPdHT/GtgiIXLla8VZr8F7CxaU3aKuhk1mEhP75PuA5lFu21VitHHvPdslvPQbD
 E9rgA5/ErJtaz+Vyc72hh2NCf5fNeEbkosa8JlfCd7CXNXPlZKgHnkU+YVQtwXW/DrvE
 pvfSQJft9iyzEplwKv3udmUoUUqhYO9Lb7YOzFnDJ3mi7BPDqhJn8N/czlDqr5VQGPXs
 QQeavNsh7fns0ny1yW0HFLdqzPht4rovY4+kSgwj3noIYhq3Q/qRU31yy5Jd62RXo81F
 YQ/DPHtqeCtER6UUebDQPGW8QVpD0szJMTvVNtd0ZUQ8SVigrLvG4VPQ0cQRjNa5g2x9
 m0IA==
X-Gm-Message-State: AFq9FYJS5T9WQp5dTgYJXFiKUPgBYQAQ5/pGrlBF2mk8uYnqhfzWZGCg
 4511ZnNBy0//JkYFmh5DE0DU/kHm8JnwpdV54GOuGejfFRUQgNVZ/Vtsdle6PCvxp5bpg5neU/+
 WOdvBoVxW/cvCEK+iEGvHh4SgOK4+T+qr+187NpKgDs/VILgNFcVhJ7zmdzQV5E8pUSDZgGDNU3
 yjdFQgj+LTO0pypSdDvhC3xeixndg7ErcpQQ==
X-Gm-Gg: AYBFou0TR5FvcoV+E80N4ioTnXIQ7zj+tGGCIb2oTmAeSPC7MsV6jifGUG3GZkJWRj7
 JyZPOGxSbx3IISlgpstEXVv6LOEU0nrmvacKiEyI6CTJHb26pqgs+bWgVCWh8/sGEAldAult6FN
 3rCR2T352T87C8ZrzSMAOZpem63Z9PatwIH8UEiHzCIHamYDOecRherCJ203h7CS5Xs5+t/XoDK
 tkIeW2OCOaos08O+6H5HFt88LASL3wg7x8xi+qjfFuAWPVbWK8OEYEv//o6tE5+RCMnERQEJmPT
 k2GEhL9duxANO2Q8ISKVwWKY1Qn0P2JUUpi5R6WcvMIyezqBkfhucKs8N5EPrTrHn4G+HalcbbZ
 HH7G7ltGfoe+eKeaS9vLwkp6BHEbGCRI5wlETXtDf
X-Received: by 2002:a05:600c:8b05:b0:4a1:fa21:fd90 with SMTP id
 5b1f17b1804b1-4a965ec95ebmr66830605e9.9.1793207823173; 
 Wed, 28 Oct 2026 10:17:03 -0700 (PDT)
X-Received: by 2002:a05:600c:8b05:b0:4a1:fa21:fd90 with SMTP id
 5b1f17b1804b1-4a965ec95ebmr66829265e9.9.1793207822037; 
 Wed, 28 Oct 2026 10:17:02 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7ee575e2sm6502885e9.1.2026.10.28.10.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:17:01 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:16:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 68/78] amd_iommu: Allow IOMMU to attachment on non-system
 (pcie.0) bus
Message-ID: <297f7526a65aaf84fa713868263f6ed6921415b8.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Allow the AMD IOMMU to attach on the pcie-root-port using pci device's "bus"
property. This helps in isolating the set of devices by creating a pcie
hierarchy under the pci expansion bus (pxb-pci). The IOMMU always tries
to find the first root bus by traversing up the PCI hierarchy and serves
all the devices under that bus.

Example1, for below PCI configuration, IOMMU will serve all the devices
under pxb-pci (i.e. Device1 and Device2) since its a first root bus,
but will not serve Device3 and Device3, effectively isolating the
devices under pxb-pci bus.

pcie.0 -+- pxb-pci -+- pcie-root-port1 --- AMD IOMMU
        |           +- pcie-root-port2 --- Device1
        |           \- pcie-root-port3 --- Device2
        +- Device3
        \- Device4

Example2, for below PCI configuration, IOMMU will serve all the devices
Device[1-4], since first root bus in the parent hierarchy is pcie.0

pcie.0 -+- pcie-root-port1 --- AMD IOMMU
        +- pcie-root-port2 --- Device1
        +- pcie-root-port3 --- Device2
        +- Device3
        \- Device4

AMD IOMMU uses this root bus to register pci IOMMU ops and build the IVRS
table.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261014053433.24564-9-sarunkod@amd.com>
---
 hw/i386/amd_iommu.c | 55 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 14ea8274b2..2d5c7b5cdf 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -24,6 +24,7 @@
 #include "hw/i386/pc.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/pci_bus.h"
+#include "hw/pci/pci_bridge.h"
 #include "migration/vmstate.h"
 #include "amd_iommu.h"
 #include "qapi/error.h"
@@ -2680,6 +2681,50 @@ static const VMStateDescription vmstate_amdvi_sysbus_migratable = {
      }
 };
 
+/* Go up in the PCI hierarchy and find the root bus pcie.0 or pxb-pci */
+static PCIBus *get_root_bus(struct PCIBus *bus)
+{
+    while (bus) {
+
+        if (!pci_bus_is_express(bus)) {
+            error_report("attached to non PCI express bus %s",
+                         bus->qbus.name);
+            goto err_out;
+        }
+
+        if (bus->iommu_ops) {
+            error_report("different IOMMU already serves bus %s",
+                         bus->qbus.name);
+            goto err_out;
+        }
+
+        if (pci_bus_is_root(bus) &&
+            object_dynamic_cast(OBJECT(bus)->parent, TYPE_PCI_HOST_BRIDGE)) {
+
+            if (bus->parent_dev &&
+                !object_dynamic_cast(OBJECT(bus), TYPE_PXB_PCIE_BUS)) {
+
+                    error_report("only supports PXB-PCI as extra root bus");
+                    goto err_out;
+            }
+            /* We found the valid root bus so return it to the user*/
+            goto out;
+        }
+
+        if (bus->parent_dev) {
+            bus = pci_get_bus(bus->parent_dev);
+        } else {
+            error_report("could not find valid PCIE bus");
+            goto err_out;
+        }
+    };
+
+err_out:
+    exit(EXIT_FAILURE);
+out:
+    return bus;
+}
+
 static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
 {
     DeviceClass *dc = (DeviceClass *) object_get_class(OBJECT(dev));
@@ -2687,7 +2732,7 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
     MachineState *ms = MACHINE(qdev_get_machine());
     PCMachineState *pcms = PC_MACHINE(ms);
     X86MachineState *x86ms = X86_MACHINE(ms);
-    PCIBus *bus = pcms->pcibus;
+    PCIBus *iommu_bus;
 
     if (s->pci_id) {
         PCIDevice *pdev = NULL;
@@ -2703,17 +2748,19 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
             return;
         }
 
+        iommu_bus = pci_get_bus(pdev);
         s->pci = AMD_IOMMU_PCI(pdev);
         dc->vmsd = &vmstate_amdvi_sysbus_migratable;
     } else {
+        iommu_bus = pcms->pcibus;
         s->pci = AMD_IOMMU_PCI(object_new(TYPE_AMD_IOMMU_PCI));
         /* This device should take care of IOMMU PCI properties */
-        if (!qdev_realize(DEVICE(s->pci), &bus->qbus, errp)) {
+        if (!qdev_realize(DEVICE(s->pci), &iommu_bus->qbus, errp)) {
             return;
         }
     }
 
-    s->root_bus = bus;
+    s->root_bus = get_root_bus(iommu_bus);
 
     s->iotlb = g_hash_table_new_full(amdvi_iotlb_hash,
                                      amdvi_iotlb_equal, g_free, g_free);
@@ -2767,7 +2814,7 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    pci_setup_iommu(bus, &amdvi_iommu_ops, s);
+    pci_setup_iommu(s->root_bus, &amdvi_iommu_ops, s);
     amdvi_init(s);
 }
 
-- 
MST


