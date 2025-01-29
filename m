Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011F4C02193
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 14:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td9Il-0000gc-Rg; Wed, 29 Jan 2025 09:44:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1td9Id-0000fc-32
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:44:15 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1td9Ib-0001Oy-G4
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:44:14 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TEXwBu030043;
 Wed, 29 Jan 2025 14:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=fFGPfNEOWDKfuNCS4QbEJKiyfGjv8sj2hdhxlp4ZQLU=; b=
 MKbg9OOTj/OEJ6rAx6fhpMpxfVaUOVa29rMalpueTcLF/FKROVVfqhgYABa3wPvs
 S7Eiijn+qYQjXhjSwrEdOdRCfhGIVcakz9fdco9UxGERCLXMU7u1js5pbF0bTA3G
 TW6T10N5EeK3M+p/mgRhn04M+GNOibaN8lUPuzvjIChZ5VNZgylocFzF7zbdROtn
 Tm/+HvQhV8Fvp3izF/vw500knMP5zhkRCOdUiglTm3obs292IED0RBG0BqlQ020S
 KTfupUZh3PgP16+XRfbO6qrqM1Isjfz0VZ93jT3yLr5urDsBYBYxtfN8CW0y56zi
 ohh7c08wrVhFImx4Cy5wMg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fn2ug60t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 14:44:00 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50TEQoH8034253; Wed, 29 Jan 2025 14:43:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44cpd9s4vt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 14:43:59 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50TEhf96003307;
 Wed, 29 Jan 2025 14:43:59 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 44cpd9s49q-27; Wed, 29 Jan 2025 14:43:59 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 26/26] iommufd: preserve DMA mappings
Date: Wed, 29 Jan 2025 06:43:22 -0800
Message-Id: <1738161802-172631-27-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501290119
X-Proofpoint-ORIG-GUID: fhiwTlGeI-kyrM7ve5A7D3nASY62RJV6
X-Proofpoint-GUID: fhiwTlGeI-kyrM7ve5A7D3nASY62RJV6
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.498,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

During cpr-transfer load in new QEMU, the vfio_memory_listener causes
spurious calls to map and unmap DMA regions, as devices are created and
the address space is built.  This memory was already already mapped by the
device in old QEMU, so suppress the map and unmap callbacks during CPR --
eg, if the reused flag is set.  Clear the reused flag in the post_load
handler.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 backends/iommufd.c    | 8 ++++++++
 hw/vfio/cpr-iommufd.c | 1 +
 2 files changed, 9 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index e9452e4..cc61432 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -226,6 +226,10 @@ int iommufd_backend_map_file_dma(IOMMUFDBackend *be, uint32_t ioas_id,
         .length = size,
     };
 
+    if (be->reused) {
+        return 0;
+    }
+
     if (!readonly) {
         map.flags |= IOMMU_IOAS_MAP_WRITEABLE;
     }
@@ -257,6 +261,10 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
         .length = size,
     };
 
+    if (be->reused) {
+        return 0;
+    }
+
     ret = ioctl(fd, IOMMU_IOAS_UNMAP, &unmap);
     /*
      * IOMMUFD takes mapping as some kind of object, unmapping
diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
index 711e5cf..5b93b24 100644
--- a/hw/vfio/cpr-iommufd.c
+++ b/hw/vfio/cpr-iommufd.c
@@ -63,6 +63,7 @@ static const VMStateDescription vfio_container_vmstate = {
     .name = "vfio-iommufd-container",
     .version_id = 0,
     .minimum_version_id = 0,
+    .priority = MIG_PRI_LOW,   /* Must happen after devices and groups */
     .pre_save = vfio_container_pre_save,
     .post_load = vfio_container_post_load,
     .needed = cpr_needed_for_reuse,
-- 
1.8.3.1


