Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B51606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 03:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OUELqviF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNj9h-000372-Dd; Sun, 01 Nov 2026 22:56:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xNj9R-0002pp-LA; Sun, 01 Nov 2026 22:56:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xNj9N-0003Pf-LT; Sun, 01 Nov 2026 22:56:05 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A20iFep4052437; Mon, 2 Nov 2026 03:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Si4LBAx1tS56O2Vwo
 bPObhxKZkXLhMJPlmomJcZRmkI=; b=OUELqviFyyKdvG4ZP8ePI3TPmE8Q1KO10
 EZTbFAvobwjUvXJgzJRFJxxV1OZwI3HDYpzm17RQO6Cp4DNyA74+EeSdvTW9Owlj
 o1GJ+mO6Pw3HAA0Z2JpglKX9GY2Ja8CJHRhj4KBoSu3KJysTwkpjYvyhBda+Zz/k
 pronDjcUKHk1oXoEpWfYBMFcUG8BoZZjpgj26FZsk3Pa/ahxBKBCCxtkjCu6Zx5T
 ATf8VEzjRK7qIupEA5yXh/36ylHV7ByizY8JwD+3/oKBC+0rEtFVQzeXxU/VS1Zn
 aZ0QKxcmioNKpFWNf78JfKR2mUWfKWp7t0QzhRS7pBlSo4FhKcz8w==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn80seh8u-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 03:55:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A20KBCg168803; Mon, 2 Nov 2026 03:55:55 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnv5gky0v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 03:55:55 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A23t52c28902116
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Nov 2026 03:55:05 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C82C58052;
 Mon,  2 Nov 2026 03:55:54 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 23D815805E;
 Mon,  2 Nov 2026 03:55:46 +0000 (GMT)
Received: from li-bd0dea4c-2912-11b2-a85c-e84940f94d2e.ibmuc.com (unknown
 [9.43.104.91]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  2 Nov 2026 03:55:45 +0000 (GMT)
From: uverma@linux.ibm.com
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, jishnuvw@linux.ibm.com, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, jsnow@redhat.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com, odaki@rsg.ci.i.u-tokyo.ac.jp,
 aleksandr.mikhalitsyn@futurfusion.io,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Utkarsh Verma <uverma@linux.ibm.com>
Subject: [PATCH v7 08/10] qtest/libqos/pci: Enforce balanced iomap/unmap
Date: Mon,  2 Nov 2026 09:23:04 +0530
Message-ID: <20261102035306.2291147-9-uverma@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102035306.2291147-1-uverma@linux.ibm.com>
References: <20261102035306.2291147-1-uverma@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: dmZRI_2KCsIy0c9tMoOE-w31SEc-T0ir
X-Proofpoint-ORIG-GUID: MUkn_EzgNkpFyzOwR9DohyFw62WDT-ej
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAxNCBTYWx0ZWRfXz9DzEcTwVnCI
 kgyVsWgh7f2uc19kYaKr8z2fK5HftTH0iqfIJNLECoborks+z23kZkQmQAosxUlOEv/6k7AOJKA
 dVYF1lI5lyT7ifYUtTM80P3r0gYWle7f/fXepzGSOWUP8MCvI3+jXYEdzb8BODfL2gOeMhOACGr
 /v0iacECfvJSUn9ZclowJg+dBu3ZKLOQ9BgfLn6vMubxUwH+OCX8xfSXbSatVZTjHYk6LfAb+t3
 ULtMdQkh2UICxWJkl/SWJ5IWdc/McDgGEtTcQzQDVDOYZSNb4NJtgu1li5+KCb0nlizD/n+Ck1h
 MR9CEePiKdfM9FB7KsiiaJoWwpjWZbK85Mh/n1kVSa1p1UkwTtJNo9MHPc9R/rSDs0AOkNDgu0A
 Qep75Klo7WzzSzAHVYN+UxZ+PtZr6Lx5O41/PMYFiw1CzUiMSpcJdmiFpWPhGIl01TZqfM2IXgB
 lTId1od2/QREydBwizA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAxNCBTYWx0ZWRfX2w5j9WGeEIc8
 gDQ/6vz4+ZHOLCrt2eeaWm7kHpWUTy9kw9sZvaB+f7/8plSEv9F3kbW7GP7TcLmxdonzxhfrF5W
 GUfr3wOCRI4x+PF+SGQunRTryYxk4ew=
X-Authority-Analysis: v=2.4 cv=FIqOVOos c=1 sm=1 tr=0 ts=6ae809cd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=z4glEzOvAAAA:8
 a=VnNF1IyMAAAA:8 a=EYfZ3pbYV0xu6guzAtsA:9 a=92dS5hN0c3Q7EetK7xW5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020014
Received-SPF: pass client-ip=148.163.156.1; envelope-from=uverma@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
---
 tests/qtest/libqos/ahci.c |  3 ++-
 tests/qtest/libqos/pci.c  | 57 +++++++++++++++++++++++++++++++++++----
 tests/qtest/libqos/pci.h  | 10 +++++++
 3 files changed, 64 insertions(+), 6 deletions(-)

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
-- 
2.55.0


