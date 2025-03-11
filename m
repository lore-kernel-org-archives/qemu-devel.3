Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C44C2BA1B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 17:50:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts3j1-0002DQ-IZ; Tue, 11 Mar 2025 13:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1ts3ia-0001UQ-9u
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:48:41 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1ts3iS-0000qC-Cm
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:48:40 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BGQsbJ030854;
 Tue, 11 Mar 2025 17:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2023-11-20; bh=Az7FZic/mj+KLEz6iSTDbirr9nzRq
 Vqn6fHV2zAw7DM=; b=UCS4v4+EZpUt3wl6nbohSq8hXg5JxM3iihfq+PRh92kVB
 L/WOB8zEdYBEceXlZErdPJw+tqkHctEk1B8ggJOd8m0dG0sf2r353zCcZPdvO0hw
 7iFjf+Y85h0GsjGjf9Nf6UKv87h0TskW/JMhYD4SBWh1px+dkiJhkhjPHnPX88wW
 bhNBD9pk99j7FW/QqBlyHKuT8ndGEmOEFelNbwM8fPxE62hXpoMDZN/LQe5j4WS7
 3H4jQcRVZK/3ztRYyj2mHZeiRVE/phhraji66BiYKPd3WCGSrBC0zCm4AD72Ylxv
 lQYWeVpBLpUVIDv8nyKVgyMG4JvgSm6pAS7aViJZw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458cg0wh2m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Mar 2025 17:48:24 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 52BGxUWl030679; Tue, 11 Mar 2025 17:48:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 458gcnqtwt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Mar 2025 17:48:24 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52BHmNtj001438;
 Tue, 11 Mar 2025 17:48:23 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-154-169-91.vpn.oracle.com
 [10.154.169.91])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 458gcnqtrj-1; Tue, 11 Mar 2025 17:48:23 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH] vfio/pci: Drop debug comentary from
 x-device-dirty-page-tracking
Date: Tue, 11 Mar 2025 17:48:07 +0000
Message-Id: <20250311174807.79825-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503110114
X-Proofpoint-GUID: BnGYoVVcHDca3bhI_2ZdI1QIpk082IUe
X-Proofpoint-ORIG-GUID: BnGYoVVcHDca3bhI_2ZdI1QIpk082IUe
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The intent behind the x-device-dirty-page-tracking option is twofold:

1) development/testing in the presence of VFs with VF dirty page tracking

2) deliberately choosing platform dirty tracker over the VF one.

Item 2) scenario is useful when VF dirty tracker is not as fast as
IOMMU, or there's some limitations around it (e.g. number of them is
limited; aggregated address space under tracking is limited),
efficiency/scalability (e.g. 1 pagetable in IOMMU dirty tracker to scan
vs N VFs) or just troubleshooting. Given item 2 it is not restricted to
debugging, hence drop the debug parenthesis from the option description.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 hw/vfio/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 64629c13b6fb..3496a0b6b099 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3531,7 +3531,7 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
     object_class_property_set_description(klass, /* 9.1 */
                                           "x-device-dirty-page-tracking",
                                           "Disable device dirty page tracking and use "
-                                          "container-based dirty page tracking (DEBUG)");
+                                          "container-based dirty page tracking");
     object_class_property_set_description(klass, /* 9.1 */
                                           "migration-events",
                                           "Emit VFIO migration QAPI event when a VFIO device "
-- 
2.43.5


