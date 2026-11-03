Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF2A606A337
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FPH+h3r5;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=MJ8CUKXo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOD32-0005fl-RF; Tue, 03 Nov 2026 06:51:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOD31-0005bh-87
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:51:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOD2z-0000PS-8i
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:51:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793706684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HffnJCbg1QtlWwhIPhB98LHrLu4vD50Q+fEQLlHW3Vo=;
 b=FPH+h3r52qjKoGisqtKXx5PZn+ol3+78xmBYgwA0FvmCUKfCByvSvfGcZr63/m/AO/xpvj
 io3FqMTPQtpF7035/50LE7YoGT0lLWrRN0mXHa/ryjNxSbnI7qYmWpeFLFwTd8wWjImQOb
 BAaZ/j1XWq69MN2uhgXmKP0xrkYtatY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-A8T25PGbOR-56527X1DJ2g-1; Tue, 03 Nov 2026 06:51:22 -0500
X-MC-Unique: A8T25PGbOR-56527X1DJ2g-1
X-Mimecast-MFC-AGG-ID: A8T25PGbOR-56527X1DJ2g_1793706681
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4ad3d35e899so23574585e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 03:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793706681; x=1794311481; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HffnJCbg1QtlWwhIPhB98LHrLu4vD50Q+fEQLlHW3Vo=;
 b=MJ8CUKXo1zvBIAXNHcBm2aJDL0rBFNRBNoKWxcKEtNb5qmn/oUyT2GEMtJQTlQiYdO
 CvCWn1s//RI9KVIITGtOum1tT5mipmZX/Md8FlwyrkYo3dGcJWze5knp5k6BOSA4VMNc
 e2xtRmqSGLG+gpKj1AmWyZCfoiRCrzn5OHXoUsKlohH9Ujk8Xk/3vxzkD4zqLJIBNWAP
 GQXHzRzAvKe8by3yAymapK+TDoXFbBstQ7+4UVQOrTFaFd1XpNOqIVXghKoyDJ9WUdjg
 VT61KFTnfH2NXRMSp5lX0r5GOA1SwdiNXdfOHBEVNqsPqNQ9r4RA0qk07OFKSEgWCDvA
 wJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793706681; x=1794311481;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HffnJCbg1QtlWwhIPhB98LHrLu4vD50Q+fEQLlHW3Vo=;
 b=1lDyrd23VzsWkDGz1ZS7jKFrCvu8jZennAzAfwYVGXm/dDgpSr9TaR/l3hsv+2MjXY
 kNZcQmepUmY1fwtyyg7F1lS5aN1PTfR7zebInC4pVN9Jap116Y57ySaE9JYlRRNxA5IF
 4cbjf1gIGuRwh1D9Bu2ShWkrEX7e6Xt8kQAKEVyQjH9sQWDhWifzqftdDwwBh5TpLZcE
 aCjWU01pXJEeXj2Sa6jDM8wqygmv9cwCZ5K4ufxI63oW9+WC/5fJJMu2mjfjIKh/0UaQ
 T+AIEIHBTPbR6M8m1VPG7ke+IRSXcM4bxBX2ln+JqpiQ62ues8LwX0aJMCxUxOMLmcqf
 t1+w==
X-Gm-Message-State: APuU4Z+P7cN/NRZDb0ve5e4qB5Zbcdy65hV57CsZOWobJ3lO//25nCLA
 9vlyv9j+yzdhzgD9rLOHm85+5BU1od5G0X4v9NoRBnElhG1I22x4rQQmni/nq0xYMqqWux38rbY
 ibcfD0kJl3VsUU5MvANOhpl4qzOSJGL3I8l7FXvIyO83q+YiAx5CmHe1D+jw/MrLVVryMN5fCzT
 NjPBrl+VMzHH9BuB/kscPxgdI3vOogCWogVQ==
X-Gm-Gg: AYBFou3isjlZ74FFyUumL6vuTnMNmM07tqEuUVMM/RQY85Lla3nYWGfOx257rGJQSat
 QJyhno4JY6yW1aAjMj0pwa2rX9WZrV67SnfOkiGLX9clF3txQBYWYMVl2r4+SKbehsEaajylU3f
 aYX2k8MqsnonQBVy9G8CZAwu2+dSDN/RdFfvRZw2batA6VidI4FzZY/ogsTyVrf+m+W5YegaLk8
 0k0r1+0ZlmuL1s8uK4eO7s6UDyfW+hsZEYVK1J8UNm853z+Fyk+KoTcskEAV4z8/lMaEXATL/0U
 t5qiHIJzXSrVNLjPreIIOEdc2NXyUhfKwQoJ3D1Ptf8ZZ7m+zqAElAZ8l4kitU0RCCrcbFDqURh
 sdrNV0M52gwKFfK5+wr4KjVD/pUSWCjyUqnClzYhUpw==
X-Received: by 2002:a05:600c:8116:b0:4a2:150f:160f with SMTP id
 5b1f17b1804b1-4ac1913eecdmr289687805e9.25.1793706680709; 
 Tue, 03 Nov 2026 03:51:20 -0800 (PST)
X-Received: by 2002:a05:600c:8116:b0:4a2:150f:160f with SMTP id
 5b1f17b1804b1-4ac1913eecdmr289687275e9.25.1793706680132; 
 Tue, 03 Nov 2026 03:51:20 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a82cebc1sm76836865e9.1.2026.11.03.03.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 03:51:19 -0800 (PST)
Date: Tue, 3 Nov 2026 06:51:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Jishnu Warrier <jishnuvw@linux.ibm.com>,
 Utkarsh Verma <uverma@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 17/17] qtest/libqos/pci: Factor msix entry helpers into pci
 common code
Message-ID: <cc82fad46af62a3f5488538b6261eb7d54837294.1793706601.git.mst@redhat.com>
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

Setting msix entry address and data and masking is moved into
common code helpers from virtio tests.

For now that remains the only user, but there are changes under
development to enable msix vectors for msix, e1000e, and xhci
tests, which can make use of them.

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Jishnu Warrier <jishnuvw@linux.ibm.com>
Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261102035306.2291147-11-uverma@linux.ibm.com>
---
 tests/qtest/libqos/pci.h        |  3 ++
 tests/qtest/libqos/pci.c        | 49 +++++++++++++++++++++++++++++++++
 tests/qtest/libqos/virtio-pci.c | 48 ++++----------------------------
 3 files changed, 57 insertions(+), 43 deletions(-)

diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
index 2fcddd19a8..986cc53c3a 100644
--- a/tests/qtest/libqos/pci.h
+++ b/tests/qtest/libqos/pci.h
@@ -97,8 +97,11 @@ void qpci_device_enable(QPCIDevice *dev);
 uint8_t qpci_find_capability(QPCIDevice *dev, uint8_t id, uint8_t start_addr);
 void qpci_msix_enable(QPCIDevice *dev);
 void qpci_msix_disable(QPCIDevice *dev);
+void qpci_msix_set_entry(QPCIDevice *dev, uint16_t entry,
+                         uint64_t guest_addr, uint32_t data);
 bool qpci_msix_pending(QPCIDevice *dev, uint16_t entry);
 bool qpci_msix_masked(QPCIDevice *dev, uint16_t entry);
+void qpci_msix_set_masked(QPCIDevice *dev, uint16_t entry, bool masked);
 bool qpci_msix_test_interrupt(QPCIDevice *dev, uint16_t msix_entry,
                               uint64_t msix_addr, uint32_t msix_data);
 uint16_t qpci_msix_table_size(QPCIDevice *dev);
diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
index 41f9673022..253c5df3e4 100644
--- a/tests/qtest/libqos/pci.c
+++ b/tests/qtest/libqos/pci.c
@@ -339,6 +339,24 @@ void qpci_msix_disable(QPCIDevice *dev)
     dev->msix_pba_off = 0;
 }
 
+void qpci_msix_set_entry(QPCIDevice *dev, uint16_t entry,
+                         uint64_t guest_addr, uint32_t data)
+{
+    uint64_t vector_off = dev->msix_table_off + entry * PCI_MSIX_ENTRY_SIZE;
+
+    g_assert(dev->msix_enabled);
+    g_assert_cmpint(entry, <, qpci_msix_table_size(dev));
+
+    qpci_io_writel(dev, dev->msix_table_bar,
+                   vector_off + PCI_MSIX_ENTRY_LOWER_ADDR, guest_addr & ~0UL);
+    qpci_io_writel(dev, dev->msix_table_bar,
+                   vector_off + PCI_MSIX_ENTRY_UPPER_ADDR,
+                   (guest_addr >> 32) & ~0UL);
+
+    qpci_io_writel(dev, dev->msix_table_bar,
+                   vector_off + PCI_MSIX_ENTRY_DATA, data);
+}
+
 bool qpci_msix_pending(QPCIDevice *dev, uint16_t entry)
 {
     uint32_t pba_entry;
@@ -346,6 +364,8 @@ bool qpci_msix_pending(QPCIDevice *dev, uint16_t entry)
     uint64_t  off = (entry / 32) * PCI_MSIX_ENTRY_SIZE / 4;
 
     g_assert(dev->msix_enabled);
+    g_assert_cmpint(entry, <, qpci_msix_table_size(dev));
+
     pba_entry = qpci_io_readl(dev, dev->msix_pba_bar, dev->msix_pba_off + off);
     return (pba_entry & (1 << bit_n)) != 0;
 }
@@ -357,6 +377,8 @@ bool qpci_msix_masked(QPCIDevice *dev, uint16_t entry)
     uint64_t vector_off = dev->msix_table_off + entry * PCI_MSIX_ENTRY_SIZE;
 
     g_assert(dev->msix_enabled);
+    g_assert_cmpint(entry, <, qpci_msix_table_size(dev));
+
     addr = qpci_find_capability(dev, PCI_CAP_ID_MSIX, 0);
     g_assert_cmphex(addr, !=, 0);
     val = qpci_config_readw(dev, addr + PCI_MSIX_FLAGS);
@@ -370,6 +392,33 @@ bool qpci_msix_masked(QPCIDevice *dev, uint16_t entry)
     }
 }
 
+void qpci_msix_set_masked(QPCIDevice *dev, uint16_t entry, bool masked)
+{
+    uint8_t addr;
+    uint16_t val;
+    uint64_t vector_off = dev->msix_table_off + entry * PCI_MSIX_ENTRY_SIZE;
+
+    g_assert(dev->msix_enabled);
+    g_assert_cmpint(entry, <, qpci_msix_table_size(dev));
+
+    addr = qpci_find_capability(dev, PCI_CAP_ID_MSIX, 0);
+    g_assert_cmphex(addr, !=, 0);
+    val = qpci_config_readw(dev, addr + PCI_MSIX_FLAGS);
+    g_assert(!(val & PCI_MSIX_FLAGS_MASKALL));
+
+    val = qpci_io_readl(dev, dev->msix_table_bar,
+                         vector_off + PCI_MSIX_ENTRY_VECTOR_CTRL);
+    if (masked && !(val & PCI_MSIX_ENTRY_CTRL_MASKBIT)) {
+        qpci_io_writel(dev, dev->msix_table_bar,
+                      vector_off + PCI_MSIX_ENTRY_VECTOR_CTRL,
+                      val | PCI_MSIX_ENTRY_CTRL_MASKBIT);
+    } else if (!masked && (val & PCI_MSIX_ENTRY_CTRL_MASKBIT)) {
+        qpci_io_writel(dev, dev->msix_table_bar,
+                      vector_off + PCI_MSIX_ENTRY_VECTOR_CTRL,
+                      val & ~PCI_MSIX_ENTRY_CTRL_MASKBIT);
+    }
+}
+
 /**
  * qpci_msix_test_interrupt - test whether MSI-X interrupt has been raised
  * @dev: PCI device
diff --git a/tests/qtest/libqos/virtio-pci.c b/tests/qtest/libqos/virtio-pci.c
index ea8114e243..16e0220920 100644
--- a/tests/qtest/libqos/virtio-pci.c
+++ b/tests/qtest/libqos/virtio-pci.c
@@ -290,66 +290,28 @@ void qvirtio_pci_device_disable(QVirtioPCIDevice *d)
 void qvirtqueue_pci_msix_setup(QVirtioPCIDevice *d, QVirtQueuePCI *vqpci,
                                         QGuestAllocator *alloc, uint16_t entry)
 {
-    uint32_t control;
-    uint64_t off;
-
     g_assert(d->pdev->msix_enabled);
-    off = d->pdev->msix_table_off + (entry * 16);
-
-    g_assert_cmpint(entry, >=, 0);
-    g_assert_cmpint(entry, <, qpci_msix_table_size(d->pdev));
     vqpci->msix_entry = entry;
-
     vqpci->msix_addr = guest_alloc(alloc, 4);
     qtest_memset(d->pdev->bus->qts, vqpci->msix_addr, 0, 4);
-    qpci_io_writel(d->pdev, d->pdev->msix_table_bar,
-                   off + PCI_MSIX_ENTRY_LOWER_ADDR, vqpci->msix_addr & ~0UL);
-    qpci_io_writel(d->pdev, d->pdev->msix_table_bar,
-                   off + PCI_MSIX_ENTRY_UPPER_ADDR,
-                   (vqpci->msix_addr >> 32) & ~0UL);
-    qpci_io_writel(d->pdev, d->pdev->msix_table_bar,
-                   off + PCI_MSIX_ENTRY_DATA, vqpci->msix_data);
-
-    control = qpci_io_readl(d->pdev, d->pdev->msix_table_bar,
-                            off + PCI_MSIX_ENTRY_VECTOR_CTRL);
-    qpci_io_writel(d->pdev, d->pdev->msix_table_bar,
-                   off + PCI_MSIX_ENTRY_VECTOR_CTRL,
-                   control & ~PCI_MSIX_ENTRY_CTRL_MASKBIT);
 
+    qpci_msix_set_entry(d->pdev, entry, vqpci->msix_addr, vqpci->msix_data);
+    qpci_msix_set_masked(d->pdev, entry, false);
     d->msix_ops->set_queue_vector(d, vqpci->vq.index, entry);
 }
 
 void qvirtio_pci_set_msix_configuration_vector(QVirtioPCIDevice *d,
                                         QGuestAllocator *alloc, uint16_t entry)
 {
-    uint32_t control;
-    uint64_t off;
-
     g_assert(d->pdev->msix_enabled);
-    off = d->pdev->msix_table_off + (entry * 16);
-
-    g_assert_cmpint(entry, >=, 0);
-    g_assert_cmpint(entry, <, qpci_msix_table_size(d->pdev));
     d->config_msix_entry = entry;
-
     d->config_msix_data = 0x12345678;
     d->config_msix_addr = guest_alloc(alloc, 4);
     qtest_memset(d->pdev->bus->qts, d->config_msix_addr, 0, 4);
 
-    qpci_io_writel(d->pdev, d->pdev->msix_table_bar,
-                   off + PCI_MSIX_ENTRY_LOWER_ADDR, d->config_msix_addr & ~0UL);
-    qpci_io_writel(d->pdev, d->pdev->msix_table_bar,
-                   off + PCI_MSIX_ENTRY_UPPER_ADDR,
-                   (d->config_msix_addr >> 32) & ~0UL);
-    qpci_io_writel(d->pdev, d->pdev->msix_table_bar,
-                   off + PCI_MSIX_ENTRY_DATA, d->config_msix_data);
-
-    control = qpci_io_readl(d->pdev, d->pdev->msix_table_bar,
-                            off + PCI_MSIX_ENTRY_VECTOR_CTRL);
-    qpci_io_writel(d->pdev, d->pdev->msix_table_bar,
-                   off + PCI_MSIX_ENTRY_VECTOR_CTRL,
-                   control & ~PCI_MSIX_ENTRY_CTRL_MASKBIT);
-
+    qpci_msix_set_entry(d->pdev, entry, d->config_msix_addr,
+                                        d->config_msix_data);
+    qpci_msix_set_masked(d->pdev, entry, false);
     d->msix_ops->set_config_vector(d, entry);
 }
 
-- 
MST


