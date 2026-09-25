Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF3A6C9831E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 02:00:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9vEx-00019B-5D; Thu, 24 Sep 2026 22:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x9vEq-0000fq-BY
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 22:00:37 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x9vEn-0006gT-4q
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 22:00:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NmiTJcCbrpmXSWYqP5g5EpOlJ417rCHWo1yQJRPbJpHCXDZTXJLbXkw4aebeI8QMryqxyFod2Xo/dxTj3ufOSmj+U9ZSnlvD53VhAcdIHeTFJZmle3v8R/VfjvwDXyx6PJAcWTaquz9lgmidUhOch2NYDjhBiCmW6gxFo2JNr4q8KBhMJvMfHYBjpVxLl9fZTdo7mZDc1chovrrwyV1Xv/JkQ/ngQYZclnUZLjp3MsfdYNVLcXoLhS4/Nf+MLI2INg2+/qK0w8sHfzy6acQCQG3MzOavgCdLTXFoSgOAHi0C/8cSUN1N27VuhAvYxTcGH9aNwUf7RWER5ouMi9MTqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zVhRQe4wMp+VSD4ASdc6w5Uv239UOO8FT66sySDnn8=;
 b=agyBJo0uWeo1Tb5qr4zPGodO1EId74XC7kEXGazO3EHnUSSzpibQTsWmSjKrrMC2un5gQWDpJ6XzsWscgCF+EbFVOSqj2Q9aALSLQTATWO1uLfmHC8Wwgk93EgWHFMvaaq3owPkgAtu+hRuYDI1v+3e/X16hUKNpiVw0GAho3sM2Meog4vi/tLt0KNMn6+f2OoLN2fE13i/BXKS4rkETMLs+4QvEYRBch1Wy5eaenMhYr4PPkLRo0NuaQ1S73lLG7impqaMN7/TZEi7N5Htrq0wy/5Ok6GwaKbX97tcXaVVpO0eEpCXrpeIaaF4n1NCVdy7iOg/YD7Cf9b412ViSfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zVhRQe4wMp+VSD4ASdc6w5Uv239UOO8FT66sySDnn8=;
 b=Nk5GuQkfchJmTORIEYXix9IYFVEv/OTBRnY3unL2OCU3tAuYjJtZriVJc9cYDS2bscLclwaMtg5ObsHHlhtcqbDUbAQuLopx7nh7qrskjheghgpJ4SE9Kgfv/27pA4IPUa70kRejzjs6z4QJoaaBY03uC10WTKohgJP6nfVm7yo=
Received: from MW4PR02CA0006.namprd02.prod.outlook.com (2603:10b6:303:16d::12)
 by SA1PR12MB9490.namprd12.prod.outlook.com (2603:10b6:806:45b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Fri, 25 Sep
 2026 02:00:24 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:303:16d:cafe::27) by MW4PR02CA0006.outlook.office365.com
 (2603:10b6:303:16d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 02:00:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 02:00:24 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 21:00:23 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <david@kernel.org>, <pbonzini@redhat.com>, <peterx@redhat.com>,
 <xiaoyao.li@intel.com>, <berrange@redhat.com>, <armbru@redhat.com>,
 <pankaj.gupta@amd.com>, <chao.p.peng@linux.intel.com>
Subject: [PATCH v6 04/12] ramblock: Rename guest_memfd to guest_memfd_private
Date: Thu, 24 Sep 2026 20:43:10 -0500
Message-ID: <20260925015700.1260501-5-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925015700.1260501-1-michael.roth@amd.com>
References: <20260925015700.1260501-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|SA1PR12MB9490:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dea27aa-0d36-4616-fefe-08df1aa8c356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TQOg74hnDtkhH6GpTpn6VsWcCNgoDA+uERfdv9l0SO2NNKpZFht/W5b3CvVXPrf1DtPtnEZJtz3nMwDLSxAq24lpQ0hSApR/C/NPvNJGoVyJxqZzZatPm0cJb35+jIv4ZL5z18HnoFDRM1LNlXkkWZ5yWYAPOdNHBVX8c9YIbnK8/A/3sHKz2y6a/fLcytQabUx+/hIR5DC6nLfyYx2caWxw/xlSIJ/XJrOxOw0Y18FxkaPl7emejcEFZC2qmEUe/EVHvICl6ZNGqNSxDkuIDRq7NScgS5i6LDOT+R4o8JkDNeC5sWFKCf2V2C5ht7L7/YDo5a+FKv+vOCOGmS4jpSZTlsPPo2jBhW/T/YWex0YXxkylUnAx7PFrmH3Tnt0D5mYq3WTtpA1tEKjMjcZeOYKl6T1F7CbxAFODkZ8U92ahAE052XkquFjRN+UCRObwVPzCPbe8iRn3/HWi844tLft7YMH2GmrsBTtsZRolkMecXEtd6YmdjG8mvm532Y8+Oj3P0oUv8okSOYyPbAG0mc7F3VYqq+0KDoYyjcU3UmQjD/ewaVvtaMg19IBxPLNZWvrtbfXt2fbBu3bnykLXw+4fp/2+F2zD6UdC5IDguwNIZs9lgOhJ7iGE6h2qW8PKj0EC8ivNMvxtv7ihuUge46sUZD13r09W/FROf0ygi6Uf8OhWJDkMDIVjSrc7sexWI997MisbxdgkVbbNTEMdpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lERjaUJ6kR2QmIskxJAUh35CZkmT3O/zWLIJfG17T9kZ0U//zBL754+vFDNoPW3u58Ox8ePcJusrP+OlrvDpxGD/Qha4pxUGyj/ofgDf8y1sAy8BkrKAjrBdpRTz0I8Bn+Db+vwhQXxpOykfjD5z6YfdgjNUCIrvmRS3zTy0THoOI37HsrUg+SD1K0mNEhSfLBx/f1fZz/ntbvjP30d5GdGQkH6yY4y07/X28mpCgMj5gYUVuniXJvrNyjA2isfDcWAyF65sJmAZ7/IJ6fm6Cly4fHEiISb6LzJSPDho64KzSb8ziI4bOCD93CI/iNO6kv34MsNTwmV3mbEdbfWH93z/9H8ipIFzpdrReg7Mu/SSXUXJ7mn4TBIt8fpyQzqN2MB8b82xQFLIEHSdxBkdVcxVCteejG8yhjjkfX2ltAHT/4T+rgF/mn3JZEgvAq6i
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 02:00:24.2300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dea27aa-0d36-4616-fefe-08df1aa8c356
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9490
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=Michael.Roth@amd.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c       |  2 +-
 include/system/memory.h   |  7 ++++---
 include/system/ramblock.h |  7 ++++++-
 system/memory.c           |  2 +-
 system/physmem.c          | 33 +++++++++++++++++----------------
 5 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 0b1407e4ea..a29b1d7a3c 100644
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
index 264dc90c0a..b07d5dc542 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1780,7 +1780,7 @@ void memory_region_set_skip_iommu_map(MemoryRegion *mr, bool skip)
 
 bool memory_region_has_guest_memfd(const MemoryRegion *mr)
 {
-    return mr->ram_block && mr->ram_block->guest_memfd >= 0;
+    return mr->ram_block && mr->ram_block->guest_memfd_private >= 0;
 }
 
 uint8_t memory_region_get_dirty_log_mask(const MemoryRegion *mr)
diff --git a/system/physmem.c b/system/physmem.c
index 1b3f327ed5..156853c8db 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2201,7 +2201,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
             goto out_free;
         }
 
-        assert(new_block->guest_memfd < 0);
+        assert(new_block->guest_memfd_private < 0);
 
         ret = ram_block_coordinated_discard_require(true);
         if (ret < 0) {
@@ -2211,9 +2211,9 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
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
@@ -2230,7 +2230,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         new_block->attributes = ram_block_attributes_create(new_block);
         if (!new_block->attributes) {
             error_setg(errp, "Failed to create ram block attribute");
-            close(new_block->guest_memfd);
+            close(new_block->guest_memfd_private);
             ram_block_coordinated_discard_require(false);
             qemu_mutex_unlock_ramlist();
             goto out_free;
@@ -2366,7 +2366,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
     new_block->max_length = max_size;
     new_block->resized = resized;
     new_block->flags = ram_flags;
-    new_block->guest_memfd = -1;
+    new_block->guest_memfd_private = -1;
     new_block->host = file_ram_alloc(new_block, max_size, fd,
                                      file_size < offset + max_size,
                                      offset, errp);
@@ -2539,7 +2539,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     new_block->used_length = size;
     new_block->max_length = max_size;
     new_block->fd = -1;
-    new_block->guest_memfd = -1;
+    new_block->guest_memfd_private = -1;
     new_block->page_size = qemu_real_host_page_size();
     new_block->host = host;
     new_block->flags = ram_flags;
@@ -2590,8 +2590,8 @@ static void reclaim_ramblock(RAMBlock *block)
         qemu_anon_ram_free(block->host, block->max_length);
     }
 
-    if (block->guest_memfd >= 0) {
-        close(block->guest_memfd);
+    if (block->guest_memfd_private >= 0) {
+        close(block->guest_memfd_private);
         ram_block_coordinated_discard_require(false);
     }
 
@@ -2839,12 +2839,12 @@ int ram_block_rebind(Error **errp)
 
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
@@ -4272,7 +4272,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t offset, size_t length)
         return ret;
     }
 
-    if (rb->guest_memfd >= 0) {
+    if (rb->guest_memfd_private >= 0) {
         ret = ram_block_discard_guest_memfd_range(rb, offset, length);
     }
 
@@ -4286,7 +4286,8 @@ int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t offset,
 
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
     /* ignore fd_offset with guest_memfd */
-    ret = fallocate(rb->guest_memfd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+    ret = fallocate(rb->guest_memfd_private,
+                    FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
                     offset, length);
 
     if (ret) {
-- 
2.43.0


