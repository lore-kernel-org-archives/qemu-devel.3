Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52466606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 03:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FakguFhi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNj9M-0002eC-Cm; Sun, 01 Nov 2026 22:56:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xNj9G-0002YG-Fw; Sun, 01 Nov 2026 22:55:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xNj9E-0003OU-TP; Sun, 01 Nov 2026 22:55:54 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A20iMRe1484985; Mon, 2 Nov 2026 03:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=AAXocX7k/LRCeVdBA
 DCPvzxDS6SZUjmPT2ytArZOacI=; b=FakguFhiQpaT3c4AJSg2HeEp6G0UzcZjD
 MzZpMejgeUFkEQ2Elumjio9wgeol1V3lW2hexUIu1npiMx/7gMAbPdwMHIt3FSHU
 +ALTStcXkpXRTffH3pcojDIJiX8qORzBl3J9R84Jifih3PSVHdCLTTI7sqdJQ0DS
 /3pU4RNPb7jfiVLZd51vr4nHdH9lPAlvxruj4wwV9F3LIHdm2nEMjUWmp+sS3MFY
 3PFvdM4Oc2MClKTZFkM4I8uV9RcoAWl0NCN/OrZJ5uOR9DAQofmr0FRYxHItCiZH
 +wYIDVmO/oqhso3O17KRKsu3kqrTLTSE/gH01XZ6MYtqC+fWSb8vA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7yrpf3t-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 03:55:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A20KA1g148942; Mon, 2 Nov 2026 03:55:47 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hnwbxusgj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 03:55:47 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A23tj7I30147084
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Nov 2026 03:55:45 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3ADAA58056;
 Mon,  2 Nov 2026 03:55:45 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 71EC95805A;
 Mon,  2 Nov 2026 03:55:38 +0000 (GMT)
Received: from li-bd0dea4c-2912-11b2-a85c-e84940f94d2e.ibmuc.com (unknown
 [9.43.104.91]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  2 Nov 2026 03:55:38 +0000 (GMT)
From: uverma@linux.ibm.com
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, jishnuvw@linux.ibm.com, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, jsnow@redhat.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com, odaki@rsg.ci.i.u-tokyo.ac.jp,
 aleksandr.mikhalitsyn@futurfusion.io,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Utkarsh Verma <uverma@linux.ibm.com>
Subject: [PATCH v7 07/10] tests/qtest/libquos/pci: Add migration fixup helper
 for pci devices
Date: Mon,  2 Nov 2026 09:23:03 +0530
Message-ID: <20261102035306.2291147-8-uverma@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102035306.2291147-1-uverma@linux.ibm.com>
References: <20261102035306.2291147-1-uverma@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Mcr5KJ/f c=1 sm=1 tr=0 ts=6ae809c4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8 a=z4glEzOvAAAA:8 a=VnNF1IyMAAAA:8
 a=1QeK4cZ67AMexZ3nFI0A:9 a=92dS5hN0c3Q7EetK7xW5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAxNCBTYWx0ZWRfX8Ru9myfrDSBS
 qoP9tOgGgcQpiq5kK93aYYi0eEcy0QB2R6bXkmX1163YsMn9s+9eK2sHrSzUcXOIeLnJUcqObFA
 U1wYOH3wNSzDnVyubMmQdundAzRHF4Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAxNCBTYWx0ZWRfX6WRAphUrjIpA
 d9q5VWv4Zkb8muwoeD02tDnGr/MPQ2qqrlh0zsrnS9VF4SN0lnNyOZwoOrIuttzJKkOD50hb0PK
 pVkvCxQ1/0HFhz1vsPDYzd/Ahg/oBl7bUqODQIsSFJdzeKRFRuYub7pW0+sj7Kaa0Fn4anKuxIq
 9AiRvmwAZ980DUd9lQlJyoYoUURWBoJmRVkS8vUdZTY1/V5tHfDZpY5KaxxE5wMaTU/XmseLUPm
 M+KiNpbc8c0Io6+81Ikz9V6sVykR6dyzOX0Bw2croaCERi6lsuSWJho94sad3uFV3PgP786wPyc
 oSFjb+GNF6gZo9pFRUOHpgch5eZZi82FxtMx/7QGF2lnEvc3Otp7KWn5vovw1QbaHq2sZm4L/Oj
 MQsHfLa8PZ/TN+2A9LbLz1jykTxrP9VakzwL+KAJbU1olpMTX2UN+R22OSJ4oCBB7jN6PhmFfRR
 ubiH8qU8tVyHAC6SNFQ==
X-Proofpoint-GUID: iXGlrgYTnlnjL3t0BkV04tarZjWNFxTE
X-Proofpoint-ORIG-GUID: yxzqLam1HIwgOWVbSYbRv48PdhSkzHTq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020014
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

Migration tests can create new QPCI devices for the destination
machine which may need to take on some state of the source machine
after destination is complete.

Add a migration fixup helper and call it from ahci and nvme migration
tests.
This is currently a noop and will be used subsequently.

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Jishnu Warrier <jishnuvw@linux.ibm.com>
Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
---
 tests/qtest/ahci-test.c  | 1 +
 tests/qtest/libqos/pci.c | 4 ++++
 tests/qtest/libqos/pci.h | 1 +
 tests/qtest/nvme-test.c  | 4 +---
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 043a916fdd..291f29e762 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -137,6 +137,7 @@ static void ahci_migrate(AHCIQState *from, AHCIQState *to, const char *uri)
     memcpy(to, from, sizeof(AHCIQState));
     to->parent = tmp;
     to->dev = dev;
+    qpci_migrate_fixup(to->dev, from->dev);
 
     tmp = from->parent;
     dev = from->dev;
diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
index e9233c81e9..e78dd4d4c7 100644
--- a/tests/qtest/libqos/pci.c
+++ b/tests/qtest/libqos/pci.c
@@ -625,6 +625,10 @@ QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr)
     return bar;
 }
 
+void qpci_migrate_fixup(QPCIDevice *to, QPCIDevice *from)
+{
+}
+
 void add_qpci_address(QOSGraphEdgeOptions *opts, QPCIAddress *addr)
 {
     g_assert(addr);
diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
index c3a0f85fef..cfb7c17dd3 100644
--- a/tests/qtest/libqos/pci.h
+++ b/tests/qtest/libqos/pci.h
@@ -120,6 +120,7 @@ void qpci_memwrite(QPCIDevice *bus, QPCIBar token, uint64_t off,
                    const void *buf, size_t len);
 QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr);
 void qpci_iounmap(QPCIDevice *dev, QPCIBar addr);
+void qpci_migrate_fixup(QPCIDevice *to, QPCIDevice *from);
 QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr);
 
 void qpci_unplug_acpi_device_test(QTestState *qs, const char *id, uint8_t slot);
diff --git a/tests/qtest/nvme-test.c b/tests/qtest/nvme-test.c
index 09972b50ff..dfa59cfbce 100644
--- a/tests/qtest/nvme-test.c
+++ b/tests/qtest/nvme-test.c
@@ -517,8 +517,6 @@ static void test_migrate(void *obj, void *data, QGuestAllocator *alloc)
     test_migrate_setup_nvme_ctrl(ctrl);
     test_migrate_send_nvme_reqs(ctrl, test_reqs, ARRAY_SIZE(test_reqs));
 
-    qpci_iounmap(ctrl->pdev, ctrl->bar);
-
     dest_cmdline = g_string_new(qos_get_current_command_line());
     g_string_append_printf(dest_cmdline, " -incoming %s", uri);
 
@@ -528,8 +526,8 @@ static void test_migrate(void *obj, void *data, QGuestAllocator *alloc)
     /* Get access to PCI device from destination VM */
     nvme = qos_allocate_objects(to, &ctrl->alloc);
     pdev = &nvme->dev;
+    qpci_migrate_fixup(pdev, ctrl->pdev);
     ctrl->pdev = pdev;
-    ctrl->bar = qpci_iomap(ctrl->pdev, 0, NULL);
     g_assert(pdev->bus->qts == to);
 
     /* Migrate VM */
-- 
2.55.0


