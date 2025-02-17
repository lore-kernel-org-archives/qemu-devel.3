Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA237C021AB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 14:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk2RU-0005ht-LI; Mon, 17 Feb 2025 09:49:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tk2RT-0005ha-GC
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:49:51 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tk2RR-0005FB-LQ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:49:51 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HEMZX6001808;
 Mon, 17 Feb 2025 14:49:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=bY8BmlAw/xageBiERV7ZAwcWOjAiKjgeX3stpudwP4c=; b=
 l5iQ6qfy1yts8Bmio0qSzR+EwIBfxZlnXSF2WozE4z233rKKeHCsvlmmI/n8YrzK
 H0RS09tJTVYOP650fn265bCCMyK0jG0RszFTEuSTOnbN0hedst/HGZoBkGL6lw3u
 anOrP1LoFo1gK2PClxRjtZ8kSCmn8Nky7v8iBvI6Ngnlt7fWjb0X6rhyzpXSZ6DA
 gHU/qqmaHn9wccBswmRiHbj3IVXgR1rSNq2CvquZIWHsZeaBPDAckQJ2Fgp01cpi
 MMW/dAsLd0QclLRBq6k6v9wajQHm1CAvHK1SQLWrPlE4BG7We30bV5jQ1wjJ7Dk0
 QRIygnTwXuyO2dh1q+Yg1Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44tkft4ebd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Feb 2025 14:49:48 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51HDqXYS025113; Mon, 17 Feb 2025 14:49:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44thc8039f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Feb 2025 14:49:47 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51HEndFe020797;
 Mon, 17 Feb 2025 14:49:47 GMT
Received: from jonah-ol8.us.oracle.com
 (dhcp-10-43-68-193.usdhcp.oraclecorp.com [10.43.68.193])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 44thc8033q-4; Mon, 17 Feb 2025 14:49:46 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: eperezma@redhat.com, mst@redhat.com, leiyang@redhat.com, peterx@redhat.com,
 dtatulea@nvidia.com, jasowang@redhat.com, si-wei.liu@oracle.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [PATCH v2 3/3] vhost-iova-tree: Update documentation
Date: Mon, 17 Feb 2025 09:49:34 -0500
Message-ID: <20250217144936.3589907-4-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250217144936.3589907-1-jonah.palmer@oracle.com>
References: <20250217144936.3589907-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502170125
X-Proofpoint-ORIG-GUID: zHBQwtmYm8vFTI3rlIhIz1FLpf9URkDd
X-Proofpoint-GUID: zHBQwtmYm8vFTI3rlIhIz1FLpf9URkDd
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

Minor update to some of the documentation / comments in
hw/virtio/vhost-iova-tree.c.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 hw/virtio/vhost-iova-tree.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree.c
index 9d2d6a7af2..fa4147b773 100644
--- a/hw/virtio/vhost-iova-tree.c
+++ b/hw/virtio/vhost-iova-tree.c
@@ -37,9 +37,9 @@ struct VhostIOVATree {
 };
 
 /**
- * Create a new IOVA tree
+ * Create a new VhostIOVATree
  *
- * Returns the new IOVA tree
+ * Returns the new VhostIOVATree.
  */
 VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
 {
@@ -56,7 +56,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
 }
 
 /**
- * Delete an iova tree
+ * Delete a VhostIOVATree
  */
 void vhost_iova_tree_delete(VhostIOVATree *iova_tree)
 {
@@ -69,10 +69,10 @@ void vhost_iova_tree_delete(VhostIOVATree *iova_tree)
 /**
  * Find the IOVA address stored from a memory address
  *
- * @tree: The iova tree
+ * @tree: The VhostIOVATree
  * @map: The map with the memory address
  *
- * Return the stored mapping, or NULL if not found.
+ * Returns the stored IOVA->HVA mapping, or NULL if not found.
  */
 const DMAMap *vhost_iova_tree_find_iova(const VhostIOVATree *tree,
                                         const DMAMap *map)
@@ -81,10 +81,10 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIOVATree *tree,
 }
 
 /**
- * Allocate a new mapping
+ * Allocate a new IOVA range and add the mapping to the IOVA->HVA tree
  *
- * @tree: The iova tree
- * @map: The iova map
+ * @tree: The VhostIOVATree
+ * @map: The IOVA mapping
  * @taddr: The translated address (HVA)
  *
  * Returns:
@@ -92,7 +92,7 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIOVATree *tree,
  * - IOVA_ERR_INVALID if the map does not make sense (like size overflow)
  * - IOVA_ERR_NOMEM if tree cannot allocate more space.
  *
- * It returns assignated iova in map->iova if return value is VHOST_DMA_MAP_OK.
+ * It returns an assigned IOVA in map->iova if the return value is IOVA_OK.
  */
 int vhost_iova_tree_map_alloc(VhostIOVATree *tree, DMAMap *map, hwaddr taddr)
 {
@@ -117,9 +117,9 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *tree, DMAMap *map, hwaddr taddr)
 }
 
 /**
- * Remove existing mappings from iova tree
+ * Remove existing mappings from the IOVA-only and IOVA->HVA trees
  *
- * @iova_tree: The vhost iova tree
+ * @iova_tree: The VhostIOVATree
  * @map: The map to remove
  */
 void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map)
-- 
2.43.5


