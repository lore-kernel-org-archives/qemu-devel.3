Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F63606A32C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RSww2HD7;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mHloRmgv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOD2c-0003vI-5c; Tue, 03 Nov 2026 06:51:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOD2a-0003ua-Mj
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:51:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOD2Y-0000M0-1s
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:51:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793706657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rshh+tIe6aQJAkNotufAQz4PwuypIOwQej5HS2h/j3o=;
 b=RSww2HD7n/wei+3Dx7PgHcjxCV4N+1E3BFEXqCclYd/NSGDsN7lj/jWyVbD4x7HKveZVGq
 eodVx1R20LkvWW0k6xeKPtN2sFbeEaptcrLhA67FE1dFNXCb14aP4wG7xv0FqAp0zab7As
 8jWD1OGstjiv1tK5nSMzm1QFGuj/k8E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-d18wjybaMO2USherxxQnKw-1; Tue, 03 Nov 2026 06:50:54 -0500
X-MC-Unique: d18wjybaMO2USherxxQnKw-1
X-Mimecast-MFC-AGG-ID: d18wjybaMO2USherxxQnKw_1793706653
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48c7fe9736eso3514719f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 03:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793706653; x=1794311453; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Rshh+tIe6aQJAkNotufAQz4PwuypIOwQej5HS2h/j3o=;
 b=mHloRmgv1YHYH34Vu9FDujZ2Ow34JXQy6u8nFCb/5MFX66+WoR1WfCnXDM7cCYN3Ip
 UQCbIW31KKgE6AR1QBlShMrHNlWvn0hLluPym2XtUC/ylW8EUCRucyMkaXcA/Fa7D+r6
 GK5vLjCunFxXeEOk6H7IPPFFqa8ZaAdrXgFnOi5sCJFODBY+eLBhDhUhWZH47Z/DfLg9
 ORbOwW38VLRMTo0bTAZu3vF3yc06CYYhw3vIoT3jvaQFLLpxDGUPwLhNKEJs9P79H8gp
 fdqZ1nJ0hpBXB5vZqWnf6AyvOrBXrmrQWP6ZuUOcUOzg6lvwj6BIk/5sZesOo2AHCrxl
 oDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793706653; x=1794311453;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Rshh+tIe6aQJAkNotufAQz4PwuypIOwQej5HS2h/j3o=;
 b=KGU3NV4nNR3Swecuyl5cXR4hTx6s9Iaf1CCeFOk3bfDrvNtjbMSnaA1cFfX9hmvp2r
 G33UPc1hZ21xW9bAsk7CQvmNYz5kt5ZruzbxdO+UFC511TmL4rIvKYTBN0jn23oG5Zmn
 uwdjic+VNpXIJpjaEWhS/4e7MQB3EbMWP2A1hPeShQG7CaHrQ8loaE9FkCEc+NsrfYNT
 OA+5zMOBOp9ykF699sHJaEGY7B5Vc9nWF1fbQQM8w+qktBcVRVK2no1sn2KR+rPqpqWd
 BBvRnMmqDvaRhqaB0mJuSy4okvcyzxpK0SagkfKFuLj0jY1OWw0x+h1Oh2T0oGJDM62v
 G1jA==
X-Gm-Message-State: APuU4Z9E790GSQ4HM09RZJCS1HGo0oJkbzmMDNj8WZe1eiatscpP7oyu
 c9Na+I2T39M0djRfe6H/dWzYyteNVyPSzTxCoP8EL/BQyn81H/ErJoXuXP/Jf6ru6ruPLYUr0Oi
 fNts5cYspPOxj2MlmCqwS+1DTxYkxO+Vbnay5+lo84nP29ZOBuA8w7lMPwYzdcAnr74dXbMrdm6
 MHrRhOZ+jDe55vD9AupklAnbJkT+mI0akFgA==
X-Gm-Gg: AYBFou0T4+W6FAixlMG262vH5dIB3C8Bb6iA3kpwlx4QuZRt/Pe/lj6mO+5T9Lq2/59
 ibyka9HTP+ZQuAlo33rSAy6RRHWOBrMa+Vk3+zAQAsNUvNuvxXavyPbBUVQSMMDYk4d1+Gbauo0
 y0ikMIj1Jt4O+ryUopuNvVPy56olkWd2YmM+gjF1+gZpDtlVBscdtxyMlDb+os4wnIS0kg6d329
 hPgquYrfKYJtLTBTSRjBsaNo9nfxk+8yYKIdccBbokT5/Kc8vCYcmRu3xObl5V1u3NRNfCm4yox
 BPHdlZ6Qqb+xps7Qz9r/guS1i9q8QY1Ren27WO9f9Ug5uaXwIwEPYjzvA86LqBqwh8U6p613f/O
 nGsFgeTTk2WGUZNQ1RHIES97Dha8rCzX06YQXkKbmmQ==
X-Received: by 2002:a05:600c:1990:b0:4a7:462c:6b9e with SMTP id
 5b1f17b1804b1-4ac1923581cmr280121095e9.32.1793706652739; 
 Tue, 03 Nov 2026 03:50:52 -0800 (PST)
X-Received: by 2002:a05:600c:1990:b0:4a7:462c:6b9e with SMTP id
 5b1f17b1804b1-4ac1923581cmr280120485e9.32.1793706652113; 
 Tue, 03 Nov 2026 03:50:52 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac09bcc967sm249754805e9.3.2026.11.03.03.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 03:50:50 -0800 (PST)
Date: Tue, 3 Nov 2026 06:50:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jishnu Warrier <jishnuvw@linux.ibm.com>,
 Utkarsh Verma <uverma@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 10/17] tests/qtest: Add libqos function for testing MSI-X
 interrupt status
Message-ID: <599bbb67fed50121cfd7598aac4d2356d132bca2.1793706601.git.mst@redhat.com>
References: <cover.1793706601.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

This function is duplicated 3 times, with more potential future users.
Factor it into libqos, using qtest_memset instead of qtest_writel to
clear the message just because that looks nicer with the qtest_memread
used to read it.
Make msix_entry to uint16_t to match other MSI-X helpers and validate it
against qpci_msix_table_size() to correctly catch uninitialized or
out of bounds vectors instead of checking != -1.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Jishnu Warrier <jishnuvw@linux.ibm.com>
Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261102035306.2291147-4-uverma@linux.ibm.com>
---
 tests/qtest/libqos/pci.h               |  2 +
 tests/qtest/libqos/pci.c               | 53 ++++++++++++++++++++++++++
 tests/qtest/libqos/virtio-pci-modern.c | 31 +++------------
 tests/qtest/libqos/virtio-pci.c        | 42 ++++----------------
 4 files changed, 67 insertions(+), 61 deletions(-)

diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
index 8389614523..d51bf240ee 100644
--- a/tests/qtest/libqos/pci.h
+++ b/tests/qtest/libqos/pci.h
@@ -92,6 +92,8 @@ void qpci_msix_enable(QPCIDevice *dev);
 void qpci_msix_disable(QPCIDevice *dev);
 bool qpci_msix_pending(QPCIDevice *dev, uint16_t entry);
 bool qpci_msix_masked(QPCIDevice *dev, uint16_t entry);
+bool qpci_msix_test_interrupt(QPCIDevice *dev, uint16_t msix_entry,
+                              uint64_t msix_addr, uint32_t msix_data);
 uint16_t qpci_msix_table_size(QPCIDevice *dev);
 
 uint8_t qpci_config_readb(QPCIDevice *dev, uint8_t offset);
diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
index a59197b992..f6db133f6a 100644
--- a/tests/qtest/libqos/pci.c
+++ b/tests/qtest/libqos/pci.c
@@ -351,6 +351,59 @@ bool qpci_msix_masked(QPCIDevice *dev, uint16_t entry)
     }
 }
 
+/**
+ * qpci_msix_test_interrupt - test whether MSI-X interrupt has been raised
+ * @dev: PCI device
+ * @msix_entry: MSI-X entry to test
+ * @msix_addr: address of MSI-X message
+ * @msix_data: expected MSI-X message payload
+ *
+ * This tests whether the device has raised an MSI-X interrupt. If the MSI-X
+ * entry is masked, it tests the pending bit array for a pending message
+ * and @msix_addr and @msix_data need not be supplied. If the entry is not
+ * masked, it tests the address for corresponding data to see if the interrupt
+ * fired.
+ *
+ * Note that this does not lower the interrupt, however it does clear the
+ * MSI-X message address to 0 if it is found set. This must be called with
+ * the MSI-X address memory containing either 0 or the value of data, otherwise
+ * it will assert on incorrect message.
+ */
+bool qpci_msix_test_interrupt(QPCIDevice *dev, uint16_t msix_entry,
+                              uint64_t msix_addr, uint32_t msix_data)
+{
+    uint32_t data;
+
+    g_assert(dev->msix_enabled);
+    g_assert_cmpint(msix_entry, <, qpci_msix_table_size(dev));
+
+    if (qpci_msix_masked(dev, msix_entry)) {
+        /* No ISR checking should be done if masked, but read anyway */
+        return qpci_msix_pending(dev, msix_entry);
+    }
+
+    /*
+     * 0 is used as the "not fired" sentinel — callers must program a
+     * non-zero MSI-X data value so the pre-zeroed target memory can be
+     * polled reliably.
+     */
+    g_assert_cmpint(msix_addr, !=, 0);
+    g_assert_cmpint(msix_data, !=, 0);
+
+    /* MSI-X payload is written in little-endian format */
+    qtest_memread(dev->bus->qts, msix_addr, &data, sizeof(data));
+    data = le32_to_cpu(data);
+    if (data == 0) {
+        return false;
+    }
+
+    /* got a message, ensure it matches expected value then clear it. */
+    g_assert_cmphex(data, ==, msix_data);
+    qtest_memset(dev->bus->qts, msix_addr, 0, sizeof(data));
+
+    return true;
+}
+
 uint16_t qpci_msix_table_size(QPCIDevice *dev)
 {
     uint8_t addr;
diff --git a/tests/qtest/libqos/virtio-pci-modern.c b/tests/qtest/libqos/virtio-pci-modern.c
index 097b548f95..0d7d89bbcb 100644
--- a/tests/qtest/libqos/virtio-pci-modern.c
+++ b/tests/qtest/libqos/virtio-pci-modern.c
@@ -126,28 +126,6 @@ static void set_status(QVirtioDevice *d, uint8_t status)
                           status);
 }
 
-static bool get_msix_status(QVirtioPCIDevice *dev, uint32_t msix_entry,
-                            uint32_t msix_addr, uint32_t msix_data)
-{
-    uint32_t data;
-
-    g_assert_cmpint(msix_entry, !=, -1);
-    if (qpci_msix_masked(dev->pdev, msix_entry)) {
-        /* No ISR checking should be done if masked, but read anyway */
-        return qpci_msix_pending(dev->pdev, msix_entry);
-    }
-
-    qtest_memread(dev->pdev->bus->qts, msix_addr, &data, sizeof(data));
-    data = le32_to_cpu(data);
-    if (data == 0) {
-        return false;
-    }
-    /* got a message, ensure it matches expected value then clear it. */
-    g_assert_cmphex(data, ==, msix_data);
-    qtest_writel(dev->pdev->bus->qts, msix_addr, 0);
-    return true;
-}
-
 static bool get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
 {
     QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
@@ -155,8 +133,8 @@ static bool get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
     if (dev->pdev->msix_enabled) {
         QVirtQueuePCI *vqpci = container_of(vq, QVirtQueuePCI, vq);
 
-        return get_msix_status(dev, vqpci->msix_entry, vqpci->msix_addr,
-                               vqpci->msix_data);
+        return qpci_msix_test_interrupt(dev->pdev, vqpci->msix_entry,
+                                        vqpci->msix_addr, vqpci->msix_data);
     }
 
     return qpci_io_readb(dev->pdev, dev->bar, dev->isr_cfg_offset) & 1;
@@ -167,8 +145,9 @@ static bool get_config_isr_status(QVirtioDevice *d)
     QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
 
     if (dev->pdev->msix_enabled) {
-        return get_msix_status(dev, dev->config_msix_entry,
-                               dev->config_msix_addr, dev->config_msix_data);
+        return qpci_msix_test_interrupt(dev->pdev, dev->config_msix_entry,
+                                        dev->config_msix_addr,
+                                        dev->config_msix_data);
     }
 
     return qpci_io_readb(dev->pdev, dev->bar, dev->isr_cfg_offset) & 2;
diff --git a/tests/qtest/libqos/virtio-pci.c b/tests/qtest/libqos/virtio-pci.c
index d2b978d4b1..ea8114e243 100644
--- a/tests/qtest/libqos/virtio-pci.c
+++ b/tests/qtest/libqos/virtio-pci.c
@@ -122,26 +122,12 @@ static void qvirtio_pci_set_status(QVirtioDevice *d, uint8_t status)
 static bool qvirtio_pci_get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
 {
     QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
-    QVirtQueuePCI *vqpci = (QVirtQueuePCI *)vq;
-    uint32_t data;
 
     if (dev->pdev->msix_enabled) {
-        g_assert_cmpint(vqpci->msix_entry, !=, -1);
-        if (qpci_msix_masked(dev->pdev, vqpci->msix_entry)) {
-            /* No ISR checking should be done if masked, but read anyway */
-            return qpci_msix_pending(dev->pdev, vqpci->msix_entry);
-        } else {
-            qtest_memread(dev->pdev->bus->qts, vqpci->msix_addr,
-                          &data, sizeof(data));
-            data = le32_to_cpu(data);
-            if (data == 0) {
-                return false;
-            }
-            /* got a message, ensure it matches expected value then clear it. */
-            g_assert_cmphex(data, ==, vqpci->msix_data);
-            qtest_writel(dev->pdev->bus->qts, vqpci->msix_addr, 0);
-            return true;
-        }
+        QVirtQueuePCI *vqpci = (QVirtQueuePCI *)vq;
+
+        return qpci_msix_test_interrupt(dev->pdev, vqpci->msix_entry,
+                                        vqpci->msix_addr, vqpci->msix_data);
     } else {
         return qpci_io_readb(dev->pdev, dev->bar, VIRTIO_PCI_ISR) & 1;
     }
@@ -150,25 +136,11 @@ static bool qvirtio_pci_get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
 static bool qvirtio_pci_get_config_isr_status(QVirtioDevice *d)
 {
     QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
-    uint32_t data;
 
     if (dev->pdev->msix_enabled) {
-        g_assert_cmpint(dev->config_msix_entry, !=, -1);
-        if (qpci_msix_masked(dev->pdev, dev->config_msix_entry)) {
-            /* No ISR checking should be done if masked, but read anyway */
-            return qpci_msix_pending(dev->pdev, dev->config_msix_entry);
-        } else {
-            qtest_memread(dev->pdev->bus->qts, dev->config_msix_addr,
-                          &data, sizeof(data));
-            data = le32_to_cpu(data);
-            if (data == 0) {
-                return false;
-            }
-            /* got a message, ensure it matches expected value then clear it. */
-            g_assert_cmphex(data, ==, dev->config_msix_data);
-            qtest_writel(dev->pdev->bus->qts, dev->config_msix_addr, 0);
-            return true;
-        }
+        return qpci_msix_test_interrupt(dev->pdev, dev->config_msix_entry,
+                                        dev->config_msix_addr,
+                                        dev->config_msix_data);
     } else {
         return qpci_io_readb(dev->pdev, dev->bar, VIRTIO_PCI_ISR) & 2;
     }
-- 
MST


