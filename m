Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A22606A326
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hXVu+OwW;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Hdv4MtPh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOD2k-0004Rg-BP; Tue, 03 Nov 2026 06:51:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOD2i-0004L2-My
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:51:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOD2g-0000Mn-GA
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:51:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793706665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yQCH9SYugeT5hKKSsRS5jJSKFCmvsBmXHBibJ+Nshmg=;
 b=hXVu+OwWsk7JByBg0kzd6xVQYr/cXyhxqP9CaNLy1/7CSVR7ZSDCRAypF3o2qGY0tOOS6Y
 1tl1tJ3Dxds3xI4NWtCsgPrHskep/uOvduDSZ6igmOjmUrF4BqHabtLl/hVdzo7h0oe0/1
 mNv0bnoiOlCA4fA8LsFf09QmKjOC+N0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-OQPAHvq6Ox6i3KeWwQPaYQ-1; Tue, 03 Nov 2026 06:51:04 -0500
X-MC-Unique: OQPAHvq6Ox6i3KeWwQPaYQ-1
X-Mimecast-MFC-AGG-ID: OQPAHvq6Ox6i3KeWwQPaYQ_1793706663
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48df730c035so2854237f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 03:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793706663; x=1794311463; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yQCH9SYugeT5hKKSsRS5jJSKFCmvsBmXHBibJ+Nshmg=;
 b=Hdv4MtPhJbgp6TYP8rvc6pUBr6YtAJyC4kkU8nF3DUdX3rJ3fWBldxOlG/Os7GFp/B
 8WNzP4xX5GR1Oyw6izGyHtUUgme27Xc8JP3P8rfD0QzVT34/h3nEyiRHQfsgqJFdZuop
 K+EnWTO/0Hz1XSBcm/L40SSZEgaTMMqsLJ3kpkFVeJJJeWlzsQ+Wl0+gBZE8c071V2s/
 q/RTlH/3YxCqMhPNfrQpljLmm44r2pZVe3pZ1AZAl27fuCvWC3TMhDJhN6omkBlkyGhT
 OA2YdjRKD0pPiKMi4NkXbF8if7ARfNKxrooOPR+JSViLVqQH3jXw/NIMGWA9PRRIgxNI
 evWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793706663; x=1794311463;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yQCH9SYugeT5hKKSsRS5jJSKFCmvsBmXHBibJ+Nshmg=;
 b=amuefeXFXw7GaBdgdfEF2vfwVzsumsC6QdSTC/0bKAB7gmk6Oqj+uLzkVN5WYRZPaQ
 ls7tGICnLEVAp3cbjMG7EBbIsEIYOkNIkWI/n7nz9DkRbOOdVRE96yDbVO5Cg7Ua1456
 PxeFkhwLAVGvUtXGFd1+PYsjrhFEQ0UCnUERJSfqJ+hwn3V3VlemI3pK0pPqbOQegwgg
 UrISlm4M2WRnDgm7MgmlD1FXGp6ybJAkhMjaCF3ZJUG94xZyCUxRHfPtF7Ak9Qt1E3J4
 VdMLRit9LntonHWRwAn68t/77dAOVhzArvOzYhqZTrDNFSGIVJp6MQBX3TCcOOLEKRnp
 VpQg==
X-Gm-Message-State: APuU4Z+60+eY0g4OPku/t/pJVa+DbnwAcgjfpYOjoupOKQx741PFm3Zm
 4bD0LL1A04PoTE0hviR6f54cmxpUAx/JFhgzf+L2YZn0zcoSTA/h+t/TuBmv2kl3spCJE34w38b
 cUUe2CTue/J7XIxfKsAnSYR7qJGQ1/BY2L/JEVJ8yTPZW1QJopE4ucqb8f6oIWvfFKzMBQwKSab
 kQE+dtAuNXnu4/JiNRiAZFOWHslE9DRA8m8Q==
X-Gm-Gg: AYBFou2lk/HFnJgAYI6coXbSH7D5EuAMMFGBUiHw1op/CTAS0f6ToCVevizX0Wkxto6
 dArwtjiaAt0soccG3k/QfBGciMYsgDT48aAMvVtlZm+Af3GKcnK8K3ljIXzpz4nFPlqHAGO9XvM
 1jX7YFAeQhP9UTxyPL2QX6j75vx2VSuyO5HQbJ9FFOXdUDgg2G2UzRaLgJX9CR/Ir7lcXrKX+XP
 jhMeGxkj4uuYBWvaswsk5GZK7/5Gr76+I78kPZQWKaB/yUwsAaHK4IGwYo596BssI0hAUoQ8T8J
 6XsNIJHW+0Jt1eYnTTeCOmrvoMPcDsUqVAKZ1gZb40Twig9Rk3CBvX9XHtwcNDlDlnO0hMetoyl
 hqEfLS3DFkgMoM404iSelYuxmXX9O9L0F3dSiBpJA/g==
X-Received: by 2002:a05:6000:4313:b0:48e:679a:4af3 with SMTP id
 ffacd0b85a97d-48e6e4fcfd7mr29527032f8f.49.1793706663213; 
 Tue, 03 Nov 2026 03:51:03 -0800 (PST)
X-Received: by 2002:a05:6000:4313:b0:48e:679a:4af3 with SMTP id
 ffacd0b85a97d-48e6e4fcfd7mr29526944f8f.49.1793706662451; 
 Tue, 03 Nov 2026 03:51:02 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b725b8sm24750840f8f.20.2026.11.03.03.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 03:50:57 -0800 (PST)
Date: Tue, 3 Nov 2026 06:50:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Jishnu Warrier <jishnuvw@linux.ibm.com>,
 Utkarsh Verma <uverma@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org
Subject: [PULL 12/17] tests/qtest: Enable spapr dma with linear iommu
Message-ID: <97e4f09a1fcbc73e67f1b36ec1f6ebe2ad3cac9f.1793706601.git.mst@redhat.com>
References: <cover.1793706601.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793706601.git.mst@redhat.com>
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

From: Nicholas Piggin <npiggin@gmail.com>

qtests spapr dma was broken because the iommu was not set up.

spapr requires hypercalls to set up the iommu (TCE tables), but
there is no support for that or a side-channel to the iommu in
qtests at the moment, so add a quick workaround in QEMU to have
the spapr iommu provide a linear map to memory when running
qtests.

The buggy msix checks can all be removed since the tests all work
now.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Jishnu Warrier <jishnuvw@linux.ibm.com>
Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261102035306.2291147-6-uverma@linux.ibm.com>
---
 tests/qtest/libqos/pci.h             |  4 ----
 hw/ppc/spapr_iommu.c                 | 10 +++++++++-
 tests/qtest/e1000e-test.c            | 21 ---------------------
 tests/qtest/igb-test.c               | 21 ---------------------
 tests/qtest/libqos/generic-pcihost.c |  1 -
 tests/qtest/libqos/pci-pc.c          |  3 ---
 tests/qtest/libqos/pci-spapr.c       |  7 ++++---
 tests/qtest/libqos/pci.c             | 14 --------------
 tests/qtest/nvme-test.c              |  4 ----
 tests/qtest/vhost-user-blk-test.c    |  6 ------
 tests/qtest/virtio-blk-test.c        | 12 ------------
 11 files changed, 13 insertions(+), 90 deletions(-)

diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
index d51bf240ee..c3a0f85fef 100644
--- a/tests/qtest/libqos/pci.h
+++ b/tests/qtest/libqos/pci.h
@@ -51,7 +51,6 @@ struct QPCIBus {
     QTestState *qts;
     uint64_t pio_alloc_ptr, pio_limit;
     uint64_t mmio_alloc_ptr, mmio_limit;
-    bool has_buggy_msi; /* TRUE for spapr, FALSE for pci */
     bool not_hotpluggable; /* TRUE if devices cannot be hotplugged */
 
 };
@@ -83,9 +82,6 @@ QPCIDevice *qpci_device_find(QPCIBus *bus, int devfn);
 void qpci_device_init(QPCIDevice *dev, QPCIBus *bus, QPCIAddress *addr);
 int qpci_secondary_buses_init(QPCIBus *bus);
 
-bool qpci_has_buggy_msi(QPCIDevice *dev);
-bool qpci_check_buggy_msi(QPCIDevice *dev);
-
 void qpci_device_enable(QPCIDevice *dev);
 uint8_t qpci_find_capability(QPCIDevice *dev, uint8_t id, uint8_t start_addr);
 void qpci_msix_enable(QPCIDevice *dev);
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index e6264b0785..5470602ef1 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -22,6 +22,8 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "system/kvm.h"
+#include "system/qtest.h"
+#include "exec/target_page.h"
 #include "kvm_ppc.h"
 #include "migration/vmstate.h"
 #include "system/dma.h"
@@ -125,7 +127,13 @@ static IOMMUTLBEntry spapr_tce_translate_iommu(IOMMUMemoryRegion *iommu,
         .perm = IOMMU_NONE,
     };
 
-    if ((addr >> tcet->page_shift) < tcet->nb_table) {
+    if (qtest_enabled()) {
+        /* spapr qtests does not set up the IOMMU, shortcut a linear map */
+        ret.iova = addr & TARGET_PAGE_MASK;
+        ret.translated_addr = addr & TARGET_PAGE_MASK;
+        ret.addr_mask = ~TARGET_PAGE_MASK;
+        ret.perm = IOMMU_RW;
+    } else if ((addr >> tcet->page_shift) < tcet->nb_table) {
         /* Check if we are in bound */
         hwaddr page_mask = IOMMU_PAGE_MASK(tcet->page_shift);
 
diff --git a/tests/qtest/e1000e-test.c b/tests/qtest/e1000e-test.c
index de9738fdb7..8300bf5a5b 100644
--- a/tests/qtest/e1000e-test.c
+++ b/tests/qtest/e1000e-test.c
@@ -139,13 +139,6 @@ static void test_e1000e_tx(void *obj, void *data, QGuestAllocator * alloc)
 {
     QE1000E_PCI *e1000e = obj;
     QE1000E *d = &e1000e->e1000e;
-    QOSGraphObject *e_object = obj;
-    QPCIDevice *dev = e_object->get_driver(e_object, "pci-device");
-
-    /* FIXME: add spapr support */
-    if (qpci_check_buggy_msi(dev)) {
-        return;
-    }
 
     e1000e_send_verify(d, data, alloc);
 }
@@ -154,13 +147,6 @@ static void test_e1000e_rx(void *obj, void *data, QGuestAllocator * alloc)
 {
     QE1000E_PCI *e1000e = obj;
     QE1000E *d = &e1000e->e1000e;
-    QOSGraphObject *e_object = obj;
-    QPCIDevice *dev = e_object->get_driver(e_object, "pci-device");
-
-    /* FIXME: add spapr support */
-    if (qpci_check_buggy_msi(dev)) {
-        return;
-    }
 
     e1000e_receive_verify(d, data, alloc);
 }
@@ -173,13 +159,6 @@ static void test_e1000e_multiple_transfers(void *obj, void *data,
 
     QE1000E_PCI *e1000e = obj;
     QE1000E *d = &e1000e->e1000e;
-    QOSGraphObject *e_object = obj;
-    QPCIDevice *dev = e_object->get_driver(e_object, "pci-device");
-
-    /* FIXME: add spapr support */
-    if (qpci_check_buggy_msi(dev)) {
-        return;
-    }
 
     for (i = 0; i < iterations; i++) {
         e1000e_send_verify(d, data, alloc);
diff --git a/tests/qtest/igb-test.c b/tests/qtest/igb-test.c
index 3d397ea697..1b3b5aa6c7 100644
--- a/tests/qtest/igb-test.c
+++ b/tests/qtest/igb-test.c
@@ -142,13 +142,6 @@ static void test_igb_tx(void *obj, void *data, QGuestAllocator * alloc)
 {
     QE1000E_PCI *e1000e = obj;
     QE1000E *d = &e1000e->e1000e;
-    QOSGraphObject *e_object = obj;
-    QPCIDevice *dev = e_object->get_driver(e_object, "pci-device");
-
-    /* FIXME: add spapr support */
-    if (qpci_check_buggy_msi(dev)) {
-        return;
-    }
 
     igb_send_verify(d, data, alloc);
 }
@@ -157,13 +150,6 @@ static void test_igb_rx(void *obj, void *data, QGuestAllocator * alloc)
 {
     QE1000E_PCI *e1000e = obj;
     QE1000E *d = &e1000e->e1000e;
-    QOSGraphObject *e_object = obj;
-    QPCIDevice *dev = e_object->get_driver(e_object, "pci-device");
-
-    /* FIXME: add spapr support */
-    if (qpci_check_buggy_msi(dev)) {
-        return;
-    }
 
     igb_receive_verify(d, data, alloc);
 }
@@ -176,13 +162,6 @@ static void test_igb_multiple_transfers(void *obj, void *data,
 
     QE1000E_PCI *e1000e = obj;
     QE1000E *d = &e1000e->e1000e;
-    QOSGraphObject *e_object = obj;
-    QPCIDevice *dev = e_object->get_driver(e_object, "pci-device");
-
-    /* FIXME: add spapr support */
-    if (qpci_check_buggy_msi(dev)) {
-        return;
-    }
 
     for (i = 0; i < iterations; i++) {
         igb_send_verify(d, data, alloc);
diff --git a/tests/qtest/libqos/generic-pcihost.c b/tests/qtest/libqos/generic-pcihost.c
index b77617524c..93cc3b8561 100644
--- a/tests/qtest/libqos/generic-pcihost.c
+++ b/tests/qtest/libqos/generic-pcihost.c
@@ -182,7 +182,6 @@ void qpci_init_generic(QGenericPCIBus *qpci, QTestState *qts,
 
     qpci->gpex_pio_base = 0x3eff0000;
     qpci->bus.not_hotpluggable = !hotpluggable;
-    qpci->bus.has_buggy_msi = false;
 
     qpci->bus.pio_readb = qpci_generic_pio_readb;
     qpci->bus.pio_readw = qpci_generic_pio_readw;
diff --git a/tests/qtest/libqos/pci-pc.c b/tests/qtest/libqos/pci-pc.c
index 147009f4f4..8b79d858bd 100644
--- a/tests/qtest/libqos/pci-pc.c
+++ b/tests/qtest/libqos/pci-pc.c
@@ -124,9 +124,6 @@ void qpci_init_pc(QPCIBusPC *qpci, QTestState *qts, QGuestAllocator *alloc)
 {
     assert(qts);
 
-    /* tests can use pci-bus */
-    qpci->bus.has_buggy_msi = false;
-
     qpci->bus.pio_readb = qpci_pc_pio_readb;
     qpci->bus.pio_readw = qpci_pc_pio_readw;
     qpci->bus.pio_readl = qpci_pc_pio_readl;
diff --git a/tests/qtest/libqos/pci-spapr.c b/tests/qtest/libqos/pci-spapr.c
index 3723cbb38d..b58cc1b59f 100644
--- a/tests/qtest/libqos/pci-spapr.c
+++ b/tests/qtest/libqos/pci-spapr.c
@@ -20,6 +20,10 @@
  * PCI devices are always little-endian
  * SPAPR by default is big-endian
  * so PCI accessors need to swap data endianness
+ *
+ * The spapr iommu model has a qtest_enabled() check that short-cuts
+ * the TCE table and provides a linear map for DMA, since qtests does
+ * not have a way to make hcalls to set up the TCE table.
  */
 
 static uint8_t qpci_spapr_pio_readb(QPCIBus *bus, uint32_t addr)
@@ -155,9 +159,6 @@ void qpci_init_spapr(QPCIBusSPAPR *qpci, QTestState *qts,
 {
     assert(qts);
 
-    /* tests cannot use spapr, needs to be fixed first */
-    qpci->bus.has_buggy_msi = true;
-
     qpci->alloc = alloc;
 
     qpci->bus.pio_readb = qpci_spapr_pio_readb;
diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
index f6db133f6a..e9233c81e9 100644
--- a/tests/qtest/libqos/pci.c
+++ b/tests/qtest/libqos/pci.c
@@ -53,20 +53,6 @@ void qpci_device_foreach(QPCIBus *bus, int vendor_id, int device_id,
     }
 }
 
-bool qpci_has_buggy_msi(QPCIDevice *dev)
-{
-    return dev->bus->has_buggy_msi;
-}
-
-bool qpci_check_buggy_msi(QPCIDevice *dev)
-{
-    if (qpci_has_buggy_msi(dev)) {
-        g_test_skip("Skipping due to incomplete support for MSI");
-        return true;
-    }
-    return false;
-}
-
 static void qpci_device_set(QPCIDevice *dev, QPCIBus *bus, int devfn)
 {
     g_assert(dev);
diff --git a/tests/qtest/nvme-test.c b/tests/qtest/nvme-test.c
index edf982a111..09972b50ff 100644
--- a/tests/qtest/nvme-test.c
+++ b/tests/qtest/nvme-test.c
@@ -493,10 +493,6 @@ static void test_migrate(void *obj, void *data, QGuestAllocator *alloc)
         { 333, false }
     };
 
-    if (qpci_check_buggy_msi(pdev)) {
-        return;
-    }
-
     /* create temporary dir and prepare unix socket path for migration */
     tmpfs = g_dir_make_tmp("nvme-test-XXXXXX", &err);
     if (!tmpfs) {
diff --git a/tests/qtest/vhost-user-blk-test.c b/tests/qtest/vhost-user-blk-test.c
index ea90d41232..3e71fdb9d7 100644
--- a/tests/qtest/vhost-user-blk-test.c
+++ b/tests/qtest/vhost-user-blk-test.c
@@ -554,14 +554,8 @@ static void idx(void *obj, void *u_data, QGuestAllocator *t_alloc)
     uint32_t desc_idx;
     uint8_t status;
     char *data;
-    QOSGraphObject *blk_object = obj;
-    QPCIDevice *pci_dev = blk_object->get_driver(blk_object, "pci-device");
     QTestState *qts = global_qtest;
 
-    if (qpci_check_buggy_msi(pci_dev)) {
-        return;
-    }
-
     qpci_msix_enable(pdev->pdev);
     qvirtio_pci_set_msix_configuration_vector(pdev, t_alloc, 0);
 
diff --git a/tests/qtest/virtio-blk-test.c b/tests/qtest/virtio-blk-test.c
index 722bd0711f..a7e864ee81 100644
--- a/tests/qtest/virtio-blk-test.c
+++ b/tests/qtest/virtio-blk-test.c
@@ -476,14 +476,8 @@ static void msix(void *obj, void *u_data, QGuestAllocator *t_alloc)
     uint32_t free_head;
     uint8_t status;
     char *data;
-    QOSGraphObject *blk_object = obj;
-    QPCIDevice *pci_dev = blk_object->get_driver(blk_object, "pci-device");
     QTestState *qts = global_qtest;
 
-    if (qpci_check_buggy_msi(pci_dev)) {
-        return;
-    }
-
     qpci_msix_enable(pdev->pdev);
     qvirtio_pci_set_msix_configuration_vector(pdev, t_alloc, 0);
 
@@ -586,14 +580,8 @@ static void idx(void *obj, void *u_data, QGuestAllocator *t_alloc)
     uint32_t desc_idx;
     uint8_t status;
     char *data;
-    QOSGraphObject *blk_object = obj;
-    QPCIDevice *pci_dev = blk_object->get_driver(blk_object, "pci-device");
     QTestState *qts = global_qtest;
 
-    if (qpci_check_buggy_msi(pci_dev)) {
-        return;
-    }
-
     qpci_msix_enable(pdev->pdev);
     qvirtio_pci_set_msix_configuration_vector(pdev, t_alloc, 0);
 
-- 
MST


