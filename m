Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0BAC79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3vzH-0004fu-3h; Tue, 08 Sep 2026 09:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x3vzF-0004dA-Gi
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:35:45 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x3vys-0006F3-K0
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:35:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6TY7B8PTvRfKgsPLMxZCtEEhaewGcq0puSNRfWx5YxrG5pBN9iP0rA7l/q+zw3ngdx54eE7JnrJbJSCaC4vb9F6VgmNufHTFjEZ5o8U4xZ9Rmiy0E58iIj2V7QEP/wBSrPIgmAPdEMwXCT8ghObavZJ/q2dE/ByLzMbgX87znevdAeplSdefhjwgquaI1y10CTnRRK3ow11FAh5WcR5ALLtyK/FJPdejm2wK4+L1FD974fzXCu99pwWT2BLKWvhSw6gT4NmafXJBME0gE5+y/HDw69hnt4j3b0aqB1D137e4C/UbZe9yEETBDJcwykDnRKq2Iy3FBlALqrxpT/H3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOH6FG1inEF95EbCicIU5bLbmk5LHYfnVUfKRVcHmfc=;
 b=rVer8BB2W2eLb940D6e51pfA1xnnVanSvO9taWvhSSebXEjawL16xohCnxz/sRUxa+Wy2mv6zmSVGlefPWKTXlKjeVNMHq9SeBN0yZe9d1SlnPI+vUuYTalzB0fNhsRlo9IVq49FJWUfHOIUSs2CCM3EDUArkVlFh7Eq36pNQTj4tSDnvyELVaCksVkwxFYI8B29fRcV8xln8OI35vxt/dbf4Cdqw54gTXPl9/5BFU+bc8SRD6MUGlp+2PryOZ4KDa/w75uQfSMWqdKlim6nTICoL1UUnFbRXBYf1EAy+ZnN4DUFSTUYXwpFmMPWsJ/RcgXcKPPdJOQlLw7HcFlxyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOH6FG1inEF95EbCicIU5bLbmk5LHYfnVUfKRVcHmfc=;
 b=Oblt36zLH9Wly07tJsSFWBgscHo2ECz5e17YW0O25bk5cMSKSfeSMpU/Kj82ER38gYs2QL+50m+lUHrine5mwnsOSZnLYHCrOm5zurg/qHX2ik3+r5M+8w9dRoiBgqQ3JLgslFF+WSaOqPfqKu91g4l+IZtkLI7cElxkZRz/zFk=
Received: from CH2PR16CA0023.namprd16.prod.outlook.com (2603:10b6:610:50::33)
 by DSSPR12MB999214.namprd12.prod.outlook.com (2603:10b6:8:378::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 13:35:18 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::9) by CH2PR16CA0023.outlook.office365.com
 (2603:10b6:610:50::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 13:35:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 13:35:18 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 08:35:12 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <berrange@redhat.com>, <armbru@redhat.com>,
 <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>, <xiaoyao.li@intel.com>,
 <chao.p.peng@linux.intel.com>, <david@kernel.org>, Peter Xu
 <peterx@redhat.com>
Subject: [PATCH v5 04/12] ramblock: Rename guest_memfd to guest_memfd_private
Date: Tue, 8 Sep 2026 08:30:54 -0500
Message-ID: <20260908133151.836685-5-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908133151.836685-1-michael.roth@amd.com>
References: <20260908133151.836685-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|DSSPR12MB999214:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ddfc4d0-c127-4e1b-e8b8-08df0dae05ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mr90pHjTm1tb9ZNPGVEE7jJdYlYybGk8aoQNyotTxDJFtpHy2DVjudkc3hQ8EkKN5Ln13FWOGPBGOAxMTPbVbmIq8DvJ4CMM4ipW4OIHyNhPxh0InTPpI6hjMeVP4v5eX+QxCpKXTB/zoiU3zRsD6FVBdJPYL0Uw8G00CEUq/4MY5yRyhdfbF1cx6sGK07HZqIwLGZ9r7HvKjGFWkuVbPm7ZJzXI5VKWvtD9TCcGdK2oYwcZ4k56OEqp2f3sDU2Z+3VSksPtUELKoiaB5lAWpOzOxJgk4t7coE79UhHrY3lUpunxCK1XNCsF5c/w73Pe6SMGMPHxNTI393tuF356inyOwWY6WCNCUv0uk/LVBCvdNOv+C7VSIYn02o59O7cSoHwVGNKa2ZJwFXKzDDD10K3lpAq1mu9tNMI4P0DQllSosBCUXqYWad9CYMpvh7kdqm0lbFXAm4aJXEXpNUuhEMY/msAJfjrw5LHznx7CK17FaPkIEULoFHps1qcRfIyX1VB1/NjH90GdB9SFuCjkvY5h09RISC8l6Vuk6ZhlpeuVoq9eYVGAanY8WZtdJ6C/f9mREfqNI8L8o1hKRlUpUs3K8uWJH8ZrbaIEKsPLlpXzjlotg8Glsf+H074qJd/+7dFnjSNh7HinEEodo48pz9BaL5wPbq19XTg5xV6KZDhGVOcH6yGeRYGNt9OurUGs3ZSkxXytCPHZvMlo95eAKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mmG56f6srH0rlbyDPAJP+MypsUazAp0HGi+n7Ub9T0zMIvpsIQuhT7kd9atJ23Zsj153mRrTYQy6c385DfMUTjViuUWbv3cwCJ1YIsXp32++KFRiexVnfuTGy+GvOxRMVPia31SG6UCFJA5q60KnXS8dl2av75VxwzBgYAFtfoY666+zAq9v/9R7UkbdxBxy8eW06x1y5w9mFao+PUuLYy/9V1dyLwf4LEG/f2NDexAK9eHdxWuGv6UCdbw5Vr34UtJAOLSq+JhIBghYCtEtjqGO6GYufk2HzQxLfhPtxgGLywD/XV5mRw+Z8maoyBhe1hqissAAUYHhMjIU/nquWKhty0PNhEcIwhV96i922Tgqn4fguVNHwN5HRd8tth1Kkd9NuyCPVTQ7TrNSGO87R/H/nBf9YVzcLviOax3qDtiLcMosRTuv0O//3C0otiuv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 13:35:18.4476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ddfc4d0-c127-4e1b-e8b8-08df0dae05ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR12MB999214
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=Michael.Roth@amd.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Peter Xu <peterx@redhat.com>

Rename the field to reflect the fact that the guest_memfd in this case only
backs private portion of the ramblock rather than all of it.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c       |  2 +-
 include/system/memory.h   |  7 ++++---
 include/system/ramblock.h |  7 ++++++-
 system/memory.c           |  2 +-
 system/physmem.c          | 33 +++++++++++++++++----------------
 5 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index a851b8f628..6f3f619b8c 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1729,7 +1729,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         mem->ram_start_offset = ram_start_offset;
         mem->ram = ram;
         mem->flags = kvm_mem_flags(mr);
-        mem->guest_memfd = mr->ram_block->guest_memfd;
+        mem->guest_memfd = mr->ram_block->guest_memfd_private;
         mem->guest_memfd_offset = mem->guest_memfd >= 0 ?
                                   (uint8_t*)ram - mr->ram_block->host : 0;
 
diff --git a/include/system/memory.h b/include/system/memory.h
index a7e03fc3e7..aef555af80 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1507,10 +1507,11 @@ bool memory_region_skip_iommu_map(const MemoryRegion *mr);
 void memory_region_set_skip_iommu_map(MemoryRegion *mr, bool skip);
 
 /**
- * memory_region_has_guest_memfd: check whether a memory region has guest_memfd
- *     associated
+ * memory_region_has_guest_memfd: check whether a memory region has
+ *     guest_memfd_private associated
  *
- * Returns %true if a memory region's ram_block has valid guest_memfd assigned.
+ * Returns %true if a memory region's ram_block has valid guest_memfd_private
+ * assigned.
  *
  * @mr: the memory region being queried
  */
diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index 84624aca2c..0388d6cc6b 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -40,7 +40,12 @@ struct RAMBlock {
     Error *cpr_blocker;
     int fd;
     uint64_t fd_offset;
-    int guest_memfd;
+    /*
+     * When RAM_GUEST_MEMFD_PRIVATE flag is set, this ramblock can have
+     * private pages backed by guest_memfd_private specified, while shared
+     * pages are backed by the ramblock on its own.
+     */
+    int guest_memfd_private;
     RamBlockAttributes *attributes;
     size_t page_size;
     /* dirty bitmap used during migration */
diff --git a/system/memory.c b/system/memory.c
index 9760721e45..bd9e22ab7e 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1805,7 +1805,7 @@ void memory_region_set_skip_iommu_map(MemoryRegion *mr, bool skip)
 
 bool memory_region_has_guest_memfd(const MemoryRegion *mr)
 {
-    return mr->ram_block && mr->ram_block->guest_memfd >= 0;
+    return mr->ram_block && mr->ram_block->guest_memfd_private >= 0;
 }
 
 uint8_t memory_region_get_dirty_log_mask(const MemoryRegion *mr)
diff --git a/system/physmem.c b/system/physmem.c
index b665cd3c33..305a3febca 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2198,7 +2198,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
             goto out_free;
         }
 
-        assert(new_block->guest_memfd < 0);
+        assert(new_block->guest_memfd_private < 0);
 
         ret = ram_block_coordinated_discard_require(true);
         if (ret < 0) {
@@ -2208,9 +2208,9 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
             goto out_free;
         }
 
-        new_block->guest_memfd = kvm_create_guest_memfd(new_block->max_length,
-                                                        0, errp);
-        if (new_block->guest_memfd < 0) {
+        new_block->guest_memfd_private =
+            kvm_create_guest_memfd(new_block->max_length, 0, errp);
+        if (new_block->guest_memfd_private < 0) {
             qemu_mutex_unlock_ramlist();
             goto out_free;
         }
@@ -2227,7 +2227,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         new_block->attributes = ram_block_attributes_create(new_block);
         if (!new_block->attributes) {
             error_setg(errp, "Failed to create ram block attribute");
-            close(new_block->guest_memfd);
+            close(new_block->guest_memfd_private);
             ram_block_coordinated_discard_require(false);
             qemu_mutex_unlock_ramlist();
             goto out_free;
@@ -2363,7 +2363,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
     new_block->max_length = max_size;
     new_block->resized = resized;
     new_block->flags = ram_flags;
-    new_block->guest_memfd = -1;
+    new_block->guest_memfd_private = -1;
     new_block->host = file_ram_alloc(new_block, max_size, fd,
                                      file_size < offset + max_size,
                                      offset, errp);
@@ -2536,7 +2536,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     new_block->used_length = size;
     new_block->max_length = max_size;
     new_block->fd = -1;
-    new_block->guest_memfd = -1;
+    new_block->guest_memfd_private = -1;
     new_block->page_size = qemu_real_host_page_size();
     new_block->host = host;
     new_block->flags = ram_flags;
@@ -2587,8 +2587,8 @@ static void reclaim_ramblock(RAMBlock *block)
         qemu_anon_ram_free(block->host, block->max_length);
     }
 
-    if (block->guest_memfd >= 0) {
-        close(block->guest_memfd);
+    if (block->guest_memfd_private >= 0) {
+        close(block->guest_memfd_private);
         ram_block_coordinated_discard_require(false);
     }
 
@@ -2836,12 +2836,12 @@ int ram_block_rebind(Error **errp)
 
     RAMBLOCK_FOREACH(block) {
         if (block->flags & RAM_GUEST_MEMFD) {
-            if (block->guest_memfd >= 0) {
-                close(block->guest_memfd);
+            if (block->guest_memfd_private >= 0) {
+                close(block->guest_memfd_private);
             }
-            block->guest_memfd = kvm_create_guest_memfd(block->max_length,
-                                                        0, errp);
-            if (block->guest_memfd < 0) {
+            block->guest_memfd_private = kvm_create_guest_memfd(
+                block->max_length, 0, errp);
+            if (block->guest_memfd_private < 0) {
                 qemu_mutex_unlock_ramlist();
                 return -1;
             }
@@ -4269,7 +4269,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t offset, size_t length)
         return ret;
     }
 
-    if (rb->guest_memfd >= 0) {
+    if (rb->guest_memfd_private >= 0) {
         ret = ram_block_discard_guest_memfd_range(rb, offset, length);
     }
 
@@ -4283,7 +4283,8 @@ int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t offset,
 
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
     /* ignore fd_offset with guest_memfd */
-    ret = fallocate(rb->guest_memfd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+    ret = fallocate(rb->guest_memfd_private,
+                    FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
                     offset, length);
 
     if (ret) {
-- 
2.43.0


