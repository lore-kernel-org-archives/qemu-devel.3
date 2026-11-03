Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9EA606A32E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J+Olz1Va;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=BTX1aOKf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOD2x-0005M2-PE; Tue, 03 Nov 2026 06:51:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOD2v-0005I3-Tr
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:51:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOD2u-0000Ol-2c
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:51:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793706679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vh/HExgeMIX4Em0/d9K1PmkLbGHVgRKObwEntphz+ug=;
 b=J+Olz1VagGIQApFonXs3L9aSWpXHF1MWH3ZHPsTbgOdSVji7HHZh+fmvyq7lEAMFL9wVRf
 dXk2qU9YrQhMZJpCW/OSHB7Erg1476J16x8x/2cqDkqB0znOXAw0Xm3NDRorhf4wnlpscs
 6qhPEjjpoI8ezwVdq3fqmB8m8hwctNU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-NDPUhed4Pxa3Vt2puJzWvg-1; Tue, 03 Nov 2026 06:51:16 -0500
X-MC-Unique: NDPUhed4Pxa3Vt2puJzWvg-1
X-Mimecast-MFC-AGG-ID: NDPUhed4Pxa3Vt2puJzWvg_1793706675
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a009f82bedso31753725e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 03:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793706675; x=1794311475; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Vh/HExgeMIX4Em0/d9K1PmkLbGHVgRKObwEntphz+ug=;
 b=BTX1aOKfMGhkqvVeu0i70Z42QF8TgAMDcpFUI3S+d1EZ2bXcpfoLyWoB2nqsapoR1J
 ljYk71z+yq2aaDH3+TOsjO1xI+r8A27Z9QgWLq6h0Q5ADIwF6tamnn+xBzpIB5mvCMOE
 0Qow3WzX28yzhlcprn5hVEaPlXEyN8Q2FLi+qH6sLFVezLZKZuQs9+bth/kK/CRqQgzG
 z7BlLzB4pn1w7/AhqQSMrRIIcX7EYO0it8EpaV2JKhQorHioxKHVX48GAH/728rGGvk8
 jPoTydeoLt6jcWf1xdOZHZZT2KnrliNFbe/tnCvgkaWuauqmJTTFS8uazS0Zgx4E6mnL
 0afg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793706675; x=1794311475;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vh/HExgeMIX4Em0/d9K1PmkLbGHVgRKObwEntphz+ug=;
 b=jpYxKM2CCKKPmquep4KLJSBkuHB8DqcqwTOcdx2cVBwClket62G8oH7TCPuJEgw3R9
 OYcKVghiswgzxpoFnNoRjup1eokuJtuke18R2biIE8NNbU/SuBKdefdub8QNSLemQOsj
 IecXDpRyRhVBc9AUFehR2l4q7Sygw/Cpn0dMuwmGJ//aHfdEFjLOlOwGQxcAIo1GatSP
 3dOVkMtPIdYLG0yd+hcyO4cSkmI1fn1NT+qGdNNfxW5h7/5D+ci7PPBWSd+XD+QlglmA
 P3e60nxycha/vOkCUtkK8c70628/wHNvq2oxe7Riuch9+94abGz27ByFS+/BXeatO8CD
 367A==
X-Gm-Message-State: APuU4Z/XTNw0iuYDipLsml2KO7WzbaZj2SAf5lU8HXSzfOkzgfHNsYK6
 LM2cIfM56XAafCWlmL99V0gVaqtCenE97KUrRRVRdEa8HCgQ4FYxXpb6mKQ2pKlY6unbZNditsX
 BQO9OzmGTPc7NsUADlGsAH1SNIdjNTVICK/rP3vPObpq5JcHRMhhBufgTCWQTpcaV3ojVwvDowz
 RxsN4tAn2Y97fQOzCv8lTAP3jv8n6hHLsSPw==
X-Gm-Gg: AYBFou0wJQXa5Np0HUfZtxVIf6RDAW8mRuAXYFOOKF5NBPY4+5+35CyxaFd7KCvhCqJ
 q+ioxpiFrg2UPUA2szE/2PGTfnZgN0QVUyltFmppZd1bMgOyEEkvEzqrdbkUUJUEWVK/jlH+O7p
 vpGnb5SNxrzMDCsVSdSq7UtKNS3+8mtv1CiwpkEhNJnx8jXfeo8DLcSZnvlpZvcqDkYMO0w9EBt
 2DbI4BTD2doMptKsn1ebknIh/ilqoMx6grGx72V4SVi2/JAORNE5S5w9mrnYFVfudq7mbeDaHVg
 HtbzJeyADElFOroUfUx8QjTsbUpdjCc4A23o8pS5kN2uxcKkPqLEW4xxqqnwTqL/8FxkrljDksW
 Ewlh2VNpTpD1PVn5dJbYlAQ9LahPrFoRyApFwQLphGA==
X-Received: by 2002:a05:600c:c171:b0:49c:fa20:cbfd with SMTP id
 5b1f17b1804b1-4ad739eb30fmr212353555e9.20.1793706675016; 
 Tue, 03 Nov 2026 03:51:15 -0800 (PST)
X-Received: by 2002:a05:600c:c171:b0:49c:fa20:cbfd with SMTP id
 5b1f17b1804b1-4ad739eb30fmr212352935e9.20.1793706674338; 
 Tue, 03 Nov 2026 03:51:14 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a80e0fe6sm59972555e9.1.2026.11.03.03.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 03:51:11 -0800 (PST)
Date: Tue, 3 Nov 2026 06:51:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Fabiano Rosas <farosas@suse.de>,
 Jishnu Warrier <jishnuvw@linux.ibm.com>,
 Utkarsh Verma <uverma@linux.ibm.com>, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
Subject: [PULL 15/17] qtest/libqos/pci: Enforce balanced iomap/unmap
Message-ID: <19fd038a6b741fb925ad95bb608923111cb32bfe.1793706601.git.mst@redhat.com>
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

Add assertions to ensure a BAR is not mapped twice, and that only
previously mapped BARs are unmapped. This can help catch bugs and
fragile coding.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Jishnu Warrier <jishnuvw@linux.ibm.com>
Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261102035306.2291147-9-uverma@linux.ibm.com>
---
 tests/qtest/libqos/pci.h  | 10 +++++++
 tests/qtest/libqos/ahci.c |  3 ++-
 tests/qtest/libqos/pci.c  | 57 +++++++++++++++++++++++++++++++++++----
 3 files changed, 64 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
index cfb7c17dd3..2f9555ae4e 100644
--- a/tests/qtest/libqos/pci.h
+++ b/tests/qtest/libqos/pci.h
@@ -58,12 +58,22 @@ struct QPCIBus {
 struct QPCIBar {
     uint64_t addr;
     bool is_io;
+    bool mapped;
 };
 
+/*
+ * hw/pci permits 7 (PCI_NUM_REGIONS) regions, the last for PCI_ROM_SLOT.
+ * libqos does not implement PCI_ROM_SLOT at the moment, and as such it
+ * permits 6.
+ */
+#define QPCI_NUM_REGIONS 6
+
 struct QPCIDevice
 {
     QPCIBus *bus;
     int devfn;
+    bool bars_mapped[QPCI_NUM_REGIONS];
+    QPCIBar bars[QPCI_NUM_REGIONS];
     bool msix_enabled;
     QPCIBar msix_table_bar, msix_pba_bar;
     uint64_t msix_table_off, msix_pba_off;
diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
index a709558aac..53a98bd6cb 100644
--- a/tests/qtest/libqos/ahci.c
+++ b/tests/qtest/libqos/ahci.c
@@ -225,7 +225,7 @@ void start_ahci_device(AHCIQState *ahci)
 
 void stop_ahci_device(AHCIQState *ahci)
 {
-    /* Unmap AHCI's ABAR */
+    /* Unmap AHCI's ABAR (no-op if not mapped) */
     qpci_iounmap(ahci->dev, ahci->hba_bar);
 }
 
@@ -250,6 +250,7 @@ void ahci_hba_enable(AHCIQState *ahci)
     uint8_t num_cmd_slots;
 
     g_assert(ahci != NULL);
+    g_assert(ahci->hba_bar.mapped);
 
     /* Set GHC.AE to 1 */
     ahci_set(ahci, AHCI_GHC, AHCI_GHC_AE);
diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
index e78dd4d4c7..365fde1fb9 100644
--- a/tests/qtest/libqos/pci.c
+++ b/tests/qtest/libqos/pci.c
@@ -79,12 +79,17 @@ QPCIDevice *qpci_device_find(QPCIBus *bus, int devfn)
 void qpci_device_init(QPCIDevice *dev, QPCIBus *bus, QPCIAddress *addr)
 {
     uint16_t vendor_id, device_id;
+    int i;
 
     qpci_device_set(dev, bus, addr->devfn);
     vendor_id = qpci_config_readw(dev, PCI_VENDOR_ID);
     device_id = qpci_config_readw(dev, PCI_DEVICE_ID);
     g_assert(!addr->vendor_id || vendor_id == addr->vendor_id);
     g_assert(!addr->device_id || device_id == addr->device_id);
+
+    for (i = 0; i < QPCI_NUM_REGIONS; i++) {
+        g_assert(!dev->bars_mapped[i]);
+    }
 }
 
 static uint8_t qpci_find_resource_reserve_capability(QPCIDevice *dev)
@@ -554,21 +559,31 @@ void qpci_memwrite(QPCIDevice *dev, QPCIBar token, uint64_t off,
     dev->bus->memwrite(dev->bus, token.addr + off, buf, len);
 }
 
-QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr)
+static uint8_t qpci_bar_reg(int barno)
 {
-    QPCIBus *bus = dev->bus;
     static const int bar_reg_map[] = {
         PCI_BASE_ADDRESS_0, PCI_BASE_ADDRESS_1, PCI_BASE_ADDRESS_2,
         PCI_BASE_ADDRESS_3, PCI_BASE_ADDRESS_4, PCI_BASE_ADDRESS_5,
     };
+
+    g_assert(barno >= 0 && barno < QPCI_NUM_REGIONS);
+
+    return bar_reg_map[barno];
+}
+
+QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr)
+{
+    QPCIBus *bus = dev->bus;
     QPCIBar bar;
     int bar_reg;
     uint32_t addr, size;
     uint32_t io_type;
     uint64_t loc;
 
-    g_assert(barno >= 0 && barno <= 5);
-    bar_reg = bar_reg_map[barno];
+    g_assert(barno >= 0 && barno < QPCI_NUM_REGIONS);
+    g_assert(!dev->bars_mapped[barno]);
+
+    bar_reg = qpci_bar_reg(barno);
 
     qpci_config_writel(dev, bar_reg, 0xFFFFFFFF);
     addr = qpci_config_readl(dev, bar_reg);
@@ -611,12 +626,40 @@ QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr)
     }
 
     bar.addr = loc;
+    bar.mapped = true;
+
+    dev->bars_mapped[barno] = true;
+    dev->bars[barno] = bar;
+
     return bar;
 }
 
 void qpci_iounmap(QPCIDevice *dev, QPCIBar bar)
 {
-    /* FIXME */
+    int bar_reg;
+    int i;
+
+    if (!bar.mapped) {
+        return; /* bar was never mapped; no-op */
+    }
+
+    for (i = 0; i < QPCI_NUM_REGIONS; i++) {
+        if (!dev->bars_mapped[i]) {
+            continue;
+        }
+        if (dev->bars[i].addr == bar.addr) {
+            dev->bars_mapped[i] = false;
+            dev->bars[i].mapped = false;
+            bar_reg = qpci_bar_reg(i);
+            qpci_config_writel(dev, bar_reg, 0xFFFFFFFF);
+            /* FIXME: the address space is leaked */
+            return;
+        }
+    }
+    /*
+     * bar was not iomap()ed; treat as no-op for callers that may
+     * call iounmap unconditionally during cleanup paths.
+     */
 }
 
 QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr)
@@ -627,6 +670,10 @@ QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr)
 
 void qpci_migrate_fixup(QPCIDevice *to, QPCIDevice *from)
 {
+    memcpy(to->bars_mapped, from->bars_mapped, sizeof(from->bars_mapped));
+    memset(from->bars_mapped, 0, sizeof(from->bars_mapped));
+    memcpy(to->bars, from->bars, sizeof(from->bars));
+    memset(from->bars, 0, sizeof(from->bars));
 }
 
 void add_qpci_address(QOSGraphEdgeOptions *opts, QPCIAddress *addr)
-- 
MST


