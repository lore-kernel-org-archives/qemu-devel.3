Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE89606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 03:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OfwKSlXD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNj8m-00026Y-Oq; Sun, 01 Nov 2026 22:55:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xNj8l-00025a-3Q; Sun, 01 Nov 2026 22:55:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xNj8j-0003Jz-3Q; Sun, 01 Nov 2026 22:55:22 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A20jmkk321413; Mon, 2 Nov 2026 03:55:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=zzv5HW
 ViLvYYUHoaqc090i7BiwRJmzdOeD5b2XWCb+k=; b=OfwKSlXDw705W4WhQbRi2/
 WXL7Wg0fAW0Zj5pMU6jIvJFuF3zYxCoBKjOICv94Kl8O0BcexnhuWmslq+OykirU
 eaK48gs/OlEk4fYqFuED/0hgrnDQ3nxcTG4NKT+S79pWnDdE+QzHgx4QVUVTiSQj
 PJOrqqEDuDBmKytuwqR716TJkLVRtaG0LLby+jm39ETpIis2aUShJFhXONzRxaDy
 YUrFaS/rjG3Z7MvLI5pbP/FSeBv+rTH6APYPDNrsAUc+I7YEcPETCg9GUR+BKLYi
 roUffDhjV6H9cCe52LmsFH5vu++y7cxOwsp5H+6boSYezpmM1N77trQz5aLYglyA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn6rcxjpr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 03:55:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A20K8bj148923; Mon, 2 Nov 2026 03:55:16 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hnwbxusf6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 03:55:16 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A23sQf828049970
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Nov 2026 03:54:26 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C68E58056;
 Mon,  2 Nov 2026 03:55:15 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 753F158052;
 Mon,  2 Nov 2026 03:55:08 +0000 (GMT)
Received: from li-bd0dea4c-2912-11b2-a85c-e84940f94d2e.ibmuc.com (unknown
 [9.43.104.91]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  2 Nov 2026 03:55:08 +0000 (GMT)
From: uverma@linux.ibm.com
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, jishnuvw@linux.ibm.com, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, jsnow@redhat.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com, odaki@rsg.ci.i.u-tokyo.ac.jp,
 aleksandr.mikhalitsyn@futurfusion.io,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Utkarsh Verma <uverma@linux.ibm.com>
Subject: [PATCH v7 03/10] tests/qtest: Add libqos function for testing MSI-X
 interrupt status
Date: Mon,  2 Nov 2026 09:22:59 +0530
Message-ID: <20261102035306.2291147-4-uverma@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102035306.2291147-1-uverma@linux.ibm.com>
References: <20261102035306.2291147-1-uverma@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: CuZohf-GcgZiaru1QuuIZ4YXZmD8JIT0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAxNCBTYWx0ZWRfX1dw03Q0fZMUk
 UvyJ9N53o45fHo8HmOnx8K17cR28o0tqzIft6Zy5KStY1oPQMEv0NsFgf8RVr79at9Q1iiWsl+b
 v3oo55pm+lfiQBKq1br21f4VeX/cEk5YPr41Zw5Df8Nm9R1E2SOjQq3alFJOuGjUZ/cwOjnONgP
 rp/8QBHY6Jhe/5kLNrk5QzFdG4pq9ze7FBEBrP+ZdL1Pmug0xyizHBj2mUFtTX7KsDwbx1eysUe
 izTufyPcx0CJqtN2zxsdjRhDrP7hHdrUh6yPZoIXCy8eQ3ZpSYO8S0Jb10iqm5o8nCLWS5xqXu5
 Lx4qrwY4t56sAwxG7MY4f7Xmal+i2/CTV/m3eSZ3Vw6fDhDY2g54I4KHC1PYvbUlxJJOwleOV6G
 Y9xGMjhoMhIN8fdAiSyyimS0nvz9tK/2TXCGBTBwSPK9MQAqwA8LveXOalyonAA6LKxSLHvKtGK
 5buMZPx5lOh8ZNGjWcw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAxNCBTYWx0ZWRfXynwQtteF4Yj7
 463gzDsrq8cKDJdI/oKA3S9L5ABbPQ4BemdSOju5ndw6qWxxnx7AaZDXSFrLfRcaBr/6UzL2AaB
 qLAAFpMerdAdLJda+naUZxM3OOp8YYE=
X-Authority-Analysis: v=2.4 cv=QK391QLL c=1 sm=1 tr=0 ts=6ae809a6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=pGLkceISAAAA:8
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=tX2KDZN593LLYinRZCQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: pRU8w5QWuT6V7wF44nCk1y2gQk1GVvB6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020014
Received-SPF: pass client-ip=148.163.158.5; envelope-from=uverma@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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
---
 tests/qtest/libqos/pci.c               | 53 ++++++++++++++++++++++++++
 tests/qtest/libqos/pci.h               |  2 +
 tests/qtest/libqos/virtio-pci-modern.c | 31 +++------------
 tests/qtest/libqos/virtio-pci.c        | 42 ++++----------------
 4 files changed, 67 insertions(+), 61 deletions(-)

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
2.55.0


