Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7D36082BC2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ECGHi4ns
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNugC-0001K8-4c; Mon, 02 Nov 2026 11:14:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xNug6-0001Gq-BF; Mon, 02 Nov 2026 11:14:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xNug4-0000fB-0G; Mon, 02 Nov 2026 11:14:34 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2G0oN03272039; Mon, 2 Nov 2026 16:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=RVQ398IIhQ2TObBVP
 gERaWtXysorSg2xjDrnLvajCg4=; b=ECGHi4nsPfWb9TTCWxowfvpSf+2lMf54H
 JdR4KskXOcgSZ1MiCSqjfp4I5CJ6E7EcwL6zGJY/n9SJ3Fltx9QTuXYdZKVSbMwM
 lPEKNE6qhvGWjkSjfuXrZUR0/d8p4/9cU4MgYd+W9C9kX/9cgUsoxRbFDZVDsvrT
 gHxidOjBgvp6t8sppJw0Bb4vOpE34bamDpLv3JHpf2X9ALBdi8wvJjQnx5J7nudK
 SH8klTzLRc3vsXhdjgsTHRIRhlt9WhVtJW19HiE5U5FDG/Qt3zCIZv4y7KsUedvj
 i1fhx9CbQBzudqHSiPYdj50TO6Mc7UEPJ5iCXppqISp3sTINj6zGw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn5rhhqt0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 16:14:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2Dp3vE932188; Mon, 2 Nov 2026 16:14:29 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnunjxq18-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 16:14:29 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A2GES8a31588946
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Nov 2026 16:14:28 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3ADDE58045;
 Mon,  2 Nov 2026 16:14:28 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 510DE58050;
 Mon,  2 Nov 2026 16:14:27 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8058-b2c04f424b34.ibm.com.com (unknown
 [9.61.98.239]) by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  2 Nov 2026 16:14:27 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.ibm.com>,
 qemu-stable@nongnu.org, Eric Farman <farman@linux.ibm.com>
Subject: [PULL 1/2] s390x/pci: Free FMB timer on zPCI device unplug
Date: Mon,  2 Nov 2026 11:14:23 -0500
Message-ID: <20261102161424.241623-2-farman@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102161424.241623-1-farman@linux.ibm.com>
References: <20261102161424.241623-1-farman@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UDm1oYHMXjF1tAw9Ivf6u_LBbH_suBcf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2NCBTYWx0ZWRfX8tvXsT1ArwTz
 ZhOnyvXEu8Xht7B+krr8ydzLe3pzlC2TCi1aK3FIC9BKLSwfkPbX4CWTW+dBzE5uwU3kmEhtnHd
 pjXp4p8PEJuvlxtqA7NC8JmU1aDgqUw=
X-Authority-Analysis: v=2.4 cv=LokHWXdc c=1 sm=1 tr=0 ts=6ae8b6e6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=1vifk-m14LeYL4mQbhwA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2NCBTYWx0ZWRfX/SQGWjU7VCM5
 Ft1pALlPQwfC77kvn5SMOn/Mcyl0qDKaUf5b8QeufVO7aVNuELnxBIy67jxQqW/NRxn+tQKkPeZ
 kEdgGd81Cz3gd0nx9ghDbPzztGimTkhSQg6CmqVlq1yVhxdbrsKBEBfzPoLbqm4dFU8E+QYsZH5
 0h3s+rm0dkWSeI8sOhkwYEas+1achrGsCW/OlBPKNZ+QEto6mKncPxwCigd/kvKYPaAAGJEkVDA
 6T08kMZttdHiRgnnnc4JpAwGkVYKl4ZMEU3wTYVUNuMgQcfh3zz3tiaOy7dOVuph63YMaDBnhZj
 Xgf2LP1fg15lRpi3S5og67veUdZCsVblbPpUVfpUSi8iTKNV0nw3zdYXy1mfXASoaCNGkwWKSG8
 S5uGDLhn3aJrd8PdKjuYbeUzAXQDh6MUThRg3eT8kwHgZZh3S6fUDpgDuBnuHWu2hgh2RPb2ph0
 0MN1DqLRYV5s0yxWvnw==
X-Proofpoint-GUID: UDm1oYHMXjF1tAw9Ivf6u_LBbH_suBcf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020064
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Farhan Ali <alifm@linux.ibm.com>

On an SCLP deconfigure we don't clean up the FMB timer. If there is a
pending unplug request then we can destroy the S390PCIBusDevice object
without correctly cleaning up the timer. So fmb_update() will then run on
freed memory. Clean up the FMB timer before we destroy the S390PCIBusDevice
object to prevent this use after free.

When FMB was introduced with commit 6e92c70c37 ("s390x/pci: add common
function measurement block") we originally cleaned up the FMB timer in
s390_pcihost_unplug(). This behavior was changed in the re-work done with
commit e0998fe89104 ("s390x/pci: Introduce unplug requests and split unplug
handler").

Fixes: e0998fe89104 ("s390x/pci: Introduce unplug requests and split unplug handler")
Cc: qemu-stable@nongnu.org
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20261028224611.240515-1-alifm@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index cdd75cdfd2..32f78a1f21 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1400,6 +1400,7 @@ static void s390_pcihost_unplug(const HotplugHandler *hotplug_dev, DeviceState *
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
         pbdev = S390_PCI_DEVICE(dev);
         pbdev->fid = 0;
+        fmb_timer_free(pbdev);
         QTAILQ_REMOVE(&s->zpci_devs, pbdev, link);
         g_hash_table_remove(s->zpci_table, &pbdev->idx);
         if (pbdev->dma_limit) {
-- 
2.56.0


