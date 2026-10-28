Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9D9606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 22:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jDo2nqIS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMCPY-000128-KM; Wed, 28 Oct 2026 18:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1xMCPV-00010X-VW; Wed, 28 Oct 2026 18:46:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1xMCPU-0007Ou-8q; Wed, 28 Oct 2026 18:46:21 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SME60A2657859; Wed, 28 Oct 2026 22:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=1UJw3h
 DbT6qtf/pZjMTH/gIeIlFKfIKXL4NoQZsPUrQ=; b=jDo2nqISBNAFMWktrd8ozW
 CtSReBGY/LkcVPev/s+gzEfySDaKqqFbien4Sh90Pkd2Gqpx6WJfQlaWhRwssP3Y
 KTWJk0lL5xQ47QPwq02AWL2w4dSwrEN2tPo2n0aWFxgeLkR2lwJ5+eSst5MQJubu
 rTpeQsGeli+NJFTTxY0CWrhIwaApP7j9RO5Y5jInRYTD9NMqSCjEbFyYCewHHPU8
 Nuk4xvQ9NqBo/7zmRF1LZ9GjEDHQYos3eQUeLmtXy8xMyg8QtSk8kNTWowNwjCgg
 oD6isW9dDWhPigLk0HyjMMb161vFlfLDFH/QTTX8+bSd/M9x/jBx4sCJARXoHc9Q
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgm6479xd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 28 Oct 2026 22:46:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SMJxZd2253508; Wed, 28 Oct 2026 22:46:14 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh8gh9cr3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Oct 2026 22:46:14 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69SMkDWK32506540
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Oct 2026 22:46:13 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A081D5805E;
 Wed, 28 Oct 2026 22:46:13 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E5FA158051;
 Wed, 28 Oct 2026 22:46:12 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.241.44])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 28 Oct 2026 22:46:12 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
 cohuck@redhat.com, oelghoul@linux.ibm.com, qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 2/2] s390x/pci: Change reset method from legacy to
 resettable exit
Date: Wed, 28 Oct 2026 15:46:11 -0700
Message-ID: <20261028224611.240515-2-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028224611.240515-1-alifm@linux.ibm.com>
References: <20261028224611.240515-1-alifm@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA5MCBTYWx0ZWRfX6HaPtXayHUnf
 QMSSUE/dqiyDtVA08867cr8+Wpbpms+spcrmQVddTsE+fOrdQ4En39Yw2hWKyeatHIw16tXzhUV
 TEbGpfukoTz1d9+MJI1jdIsySLCADQc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA5MCBTYWx0ZWRfX0NsNJWQzUFW4
 IyOZIzQXwZW5cBDv55NoaTjKsx9fL2ey8DFutP/+A+Y2q0mnZdiUhGOCWrtapUdIFt+2v7RZ+Vv
 Lnk55DrCWkTzV3Ii39fTktZx9AMP3lfr7Ndeb+rE5wLLZ6NexvG/FfccymwzpDyaSAGbGWnMJgz
 /su8T1Vu4+paAyWKjduUdOCYSMXe06svkbyaCVL2LfIlw2nPzsKi1LpvHkVlbSSkmrIaWL+qB0C
 jiPnz/GhXU07vzPKBTsTa9Tjhzj/bpfT4oRg2NQ2gux/P1NSXj7Gm7OkZoCTFojXuJH7dW1c0Td
 z6Ez0QLi4IhgvxOky293zuoWKLcwf2ywmeac2adbk760MTZOE6/7UH9MvkPHAqOoJ3IULLDvkmY
 nPil8WmohyeezIyKw+3edos4whINYyFyuoVLTi2NH0HJ6guoaShP/Ig83yEG46AjSH3+/RMkx+N
 D3Je4UlJaEl9BqLyfwQ==
X-Proofpoint-ORIG-GUID: kvBlKmdXXiZWuP9RQ5hWUyRe7SfAXkCZ
X-Authority-Analysis: v=2.4 cv=Uu32pOwB c=1 sm=1 tr=0 ts=6ae27b37 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=69wJf7TsAAAA:8
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=d1GJVicS2NaZ5qTk1R8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: kvBlKmdXXiZWuP9RQ5hWUyRe7SfAXkCZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280090
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On subsystem reset of the s390 PCI host bridge (TYPE_S390_PCI_HOST_BRIDGE),
child buses S390PCIBus and PCIBus are reset in order. Because S390PCIBus
devices are reset first via the legacy reset hook, IOMMU mappings are torn
down before the PCI device itself is reset. For a PCI passthrough device
this opens a window where the device may issue DMA to addresses that no
longer have valid IOMMU mappings, causing an error (PEC 0x7) on the host.

The QEMU reset documentation (docs/devel/reset.rst) specifies that IOMMUs
should perform teardown in the resettable 'exit' phase, after all devices
have completed their 'hold' phase. Move the S390PCIBusDevice reset logic
from the legacy reset hook to the resettable exit phase to close this
window.

Fixes: 3e5cfba3ca0a ("s390x/pci: introduce S390PCIBusDevice qdev")
Cc: qemu-stable@nongnu.org
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Omar Elghoul <oelghoul@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 32f78a1f21..69832e9cf1 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1786,9 +1786,9 @@ static void s390_pci_device_realize(DeviceState *dev, Error **errp)
     zpci->fmb.format = ZPCI_FMB_FORMAT;
 }
 
-static void s390_pci_device_reset(DeviceState *dev)
+static void s390_pci_device_reset_exit(Object *obj, ResetType type)
 {
-    S390PCIBusDevice *pbdev = S390_PCI_DEVICE(dev);
+    S390PCIBusDevice *pbdev = S390_PCI_DEVICE(obj);
 
     switch (pbdev->state) {
     case ZPCI_FS_RESERVED:
@@ -2019,10 +2019,11 @@ static const VMStateDescription s390_pci_device_vmstate = {
 static void s390_pci_device_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->desc = "zpci device";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-    device_class_set_legacy_reset(dc, s390_pci_device_reset);
+    rc->phases.exit = s390_pci_device_reset_exit;
     dc->bus_type = TYPE_S390_PCI_BUS;
     dc->realize = s390_pci_device_realize;
     device_class_set_props(dc, s390_pci_device_properties);
-- 
2.43.0


