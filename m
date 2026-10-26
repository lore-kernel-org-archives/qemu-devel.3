Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5796606A320
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DOTmepRX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLJV-0000og-1P; Mon, 26 Oct 2026 10:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xLLH6-00078M-4v; Mon, 26 Oct 2026 10:02:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xLLH2-00018s-Fw; Mon, 26 Oct 2026 10:02:07 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QBEYoM3357483; Mon, 26 Oct 2026 14:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=5mxWhWdJtw9hayoAl
 QaBA6vvcOGnARW9bX8PAUj4f2o=; b=DOTmepRXE9fTwDqACFbnabTNv2fJ9mWtW
 Reh5KlR1Mcmi9JXuQxrfIqvE+ybXq3iggaUxypBqzd7zZrHwASPcXXUUdBILrhXQ
 lb+JkF+xCsejQXJGia5B1XckN6Ezjno+SoXtboUhP5BCgYLhXfZGMS2m3Sv4ZcA8
 tN9cQruaMYqiEW+pYMyRhfhvZ1JyviozbErXDdpEhlM5pvXgYBxfqvlDSLTaIJVx
 sePopy9pjPPv7LRpbju9CkEG3lAbPPbSCDttrkYX1aty3jCq1HBuXl5bN3ZT47F5
 ZE4uZg4QQFqEy4d86h++vaRWmDYzpwbn924LvI9wMhenHB2zAbzDQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmav9xg4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2026 14:02:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QBJsDw2442736; Mon, 26 Oct 2026 14:02:01 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh7cveakm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2026 14:02:01 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69QE1xfb65405318
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Oct 2026 14:02:00 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DB4425805D;
 Mon, 26 Oct 2026 14:01:59 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E02958059;
 Mon, 26 Oct 2026 14:01:59 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.109.57]) by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 26 Oct 2026 14:01:58 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Omar Elghoul <oelghoul@linux.ibm.com>, qemu-stable@nongnu.org,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 4/6] s390x/pci: reclaim DMA slots upon IOMMU disable
Date: Mon, 26 Oct 2026 10:01:51 -0400
Message-ID: <20261026140153.2072253-5-farman@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026140153.2072253-1-farman@linux.ibm.com>
References: <20261026140153.2072253-1-farman@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1NCBTYWx0ZWRfXxdMq8W0eSjfQ
 e4fE+ic+VTNvZcsgXC3fd5QlFQHwqjB0PWYfpHMoYyscbe9OgA8lAER7MW5IE/M7X0BwOU9zegM
 JJyI3GRGdAEljHHgeUxg5Huq1nvmY6U=
X-Authority-Analysis: v=2.4 cv=P8SvFSAu c=1 sm=1 tr=0 ts=6adf5d59 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=eA_zop4iBRkCFdGO_iEA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: 0O6OLcTizSjeagI2twbsDwAPYSRPawD8
X-Proofpoint-GUID: 0O6OLcTizSjeagI2twbsDwAPYSRPawD8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1NCBTYWx0ZWRfX4UkTJkJdPIPD
 WLiujwVjjH9uEi/Q5ofzrSQm/IiHlYZje5CKmwkIsFbGuM1kYVAEGZbiNrojlVuIoBxNcz0y41j
 iEqPIT0nOefrLUgoqYrvDATGm4t8wOpifWUWEUtwJBFd00dppV5jq+wUgFOycDbBCRU+ZdRPb/w
 rKyRnC+29iE1d7dfpAIYWN7wxL8nxnIh2ebYRY49M0DzhE8bXP+Za41k2KY5StH05Yyb9Wd5VPY
 nsMgiYjb5C8Qz8BBmgRd2zs7zDb2bASNOhfFFACAYM3llJcxifnDgBrKmnB4eX3zoaweOZ+7wOL
 i23O5Qafotu11TWtH8kQ+ze9mnTDLRLg3V+OmBv+PjevynpHsdJ2EvyuUGMgSXdvTupUttrDUkY
 AFYr/ZClpYLFZaMP935kZ7WAlfuyeA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610190000 definitions=main-2610260054
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

From: Omar Elghoul <oelghoul@linux.ibm.com>

s390_pci_iommu_disable() destroys the I/O TLB and unpins the host's
mappings, but it doesn't account for reclaiming the freed DMA slots.
This is problematic when an IOMMU is disabled and re-enabled while
reusing the container (e.g. during a guest reboot), which may cause the
RPCIT path to fail with DMA slots exhaustion errors, manifesting as
unexplained ENOMEMs in the guest.

Fix it by reclaiming all the entries in the I/O TLB's hash table before
removing all its entries. The actual DMA slots consumed by the IOMMU are
already relinquished to vfio when the memory subregion is deleted in the
same function.

Cc: qemu-stable@nongnu.org
Fixes: 37fa32de7073 ("s390x/pci: Honor DMA limits set by vfio")
Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20261021175031.23840-1-oelghoul@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 2724b27ec2..cdd75cdfd2 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -826,6 +826,14 @@ void s390_pci_iommu_disable(S390PCIBusDevice *pbdev)
 {
     S390PCIIOMMU *iommu = pbdev->iommu;
     pbdev->iommu_enabled = false;
+    if (pbdev->dma_limit) {
+        /*
+         * Account for all the DMA mappings still in the IOTLB; they will be
+         * returned to vfio when we delete the memory subregion via
+         * memory_region_del_subregion() below.
+         */
+        pbdev->dma_limit->avail += g_hash_table_size(pbdev->iotlb);
+    }
     g_hash_table_remove_all(pbdev->iotlb);
     if (pbdev->dm_mr) {
         memory_region_del_subregion(&iommu->mr, pbdev->dm_mr);
-- 
2.56.0


