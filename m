Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD4FCD3430
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 08:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKAwz-0001xa-5x; Tue, 05 May 2026 04:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wKAwU-0001aD-DS
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:15:46 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wKAwQ-0006l2-FS
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:15:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+VVuiDAx2ul0IRW+IopvHD2PPZES3AA4hJNskPpJZFNNF4gvzuWQXkT5TpmMPqHm/U+S1HQiOfXih27WRwRfqrLSCcg9SiumjjVpb7bMlJwi6mkoDkqfSwHLvu/c9g8QrndS39UYRlZz+VKXEbdaHp6Cm7C6MWf0zkeAsIulrG2pbe3KBj2Er97dmvntzxfmP1Bf9uY/awaZD+IeIRAK1/VPlXefDgHERSEtmXkAMBlfw+HOf8St1nslBvI3HaNSryleXMuFa0u9zNsb6JOK4aTzzGhGXp+c68/nPN/Kwi0OKnL8GP7dXXwhEVe2wJ8RpW8Lp1Kr2HHAWTa+hwx8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjZtH7SQQx/j7xbT5PZM0X/pEPIFIcUadc3wR/ShmCA=;
 b=QnzNjBdQ6cVneHwXB17POh1AQoxMWRDOefwjhMmAqXU+DMi18fTixydr0LM7Rxw4ynkOAFxR4/Rou9Hygt1eur3xj2qL7TW72FPhcjyX8S4XluWfl101l3g25sdfXYrggCqsnX2IJEuheBcwPdB8QCarH3nnCk8pym0MIUgDbwtmIE6qKPSTq+1t6QCIAREkgolZBNIDmKXoN9gTeLzTdOnOKrrGmdKhC8iNfGSUWgqQ10p2NRcd3FyiIJYQrSPqonNfzG9oqdDkH6MrgeI6UcKmGEBOHmx7sVBHZs3kDCrU46nQH0jV0O2PipsjHBENP51syWZO5Bwlnq8liIAV9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjZtH7SQQx/j7xbT5PZM0X/pEPIFIcUadc3wR/ShmCA=;
 b=obYUnRtekwVxFuYwyZIEpU194/7NPRV7ULCQzPRg8TrChfmOllX5/LJMYKpYNg0FkITxA8gKHIjVoNu9d9Zl0FLGphyGiFwpQa/lAmiltS4+9grKSIHs5MWPuD2qooUC/b694LCXwLERFeSXHPRZtr4EKJr+e7w9SbhyeZkXsdZW3W00PjrIe9lHooW/b3RbU5ovhlA2xjf75ubZMNjzrhSL+qPhl58GAvf6GVjX703phxsd6EmN4pAYISPS3ZeMhyvzVqyoSDIESMWgN7k4T3JR4p682Rlp8xqPEQuKHye+HVQkQtgE0ED5Uoleu9LqDJd0TKIJDKsy4CVgTgqcKg==
Received: from BYAPR06CA0021.namprd06.prod.outlook.com (2603:10b6:a03:d4::34)
 by LV2PR12MB5871.namprd12.prod.outlook.com (2603:10b6:408:174::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 08:15:31 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::61) by BYAPR06CA0021.outlook.office365.com
 (2603:10b6:a03:d4::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Tue,
 5 May 2026 08:15:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 08:15:30 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 01:15:17 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 01:15:16 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 5 May
 2026 01:15:12 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Zhao Liu
 <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH 12/14] vfio/migration: Implement VFIO_PRECOPY_INFO_REINIT
 feature
Date: Tue, 5 May 2026 11:14:21 +0300
Message-ID: <20260505081423.28326-13-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260505081423.28326-1-avihaih@nvidia.com>
References: <20260505081423.28326-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|LV2PR12MB5871:EE_
X-MS-Office365-Filtering-Correlation-Id: ed21f40d-cdf6-4757-ee25-08deaa7e7937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|36860700016|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: n7Gdqlm5FvUuFXjcqmnLxcw0Ae48ymYvPVGpNKXImPqG8EMdDYLpA3s97TT/68EBsyQ9xe8Y2g07O/bTv78gNR+BDAfIGdF4AUNloLuUrCUxn2rcE1pT7CrrglC4xiLYqfHDMcqMY+PGCTh93yItDc7HcczsBRrlouMxyVu5qJwPjfPS2ROs7jVXRDZGS7WiDllfke6o2uwdfupgodlhkDB3GF8uJ6f5Em4dOexNeIpVM0pizv/5li5SWr8W8szvcuZHmoATbcoSROl5ohAXodDPCJaXVGJxq0LEixQkPI1sLLPasAyqclC7pb1Cxv1vyAHEgAiK2PqNAV1nBrXdy5B+qNhw8DUV6g41oPI72bu00C2svY3MCAg3jsJe3GUtGvQ9iOWcrKwn5KsWiUbDhvFWAE8xwFsYO9TzgXSTKoQIG2WH31mOwkEQ8Dv0oIa7P95fblbAFkQj2sESA9CM0yUpvm4evkEhEy5yRSY0OobupvOQXfjdZpMJIEX3MfoAk0IgbV3uWDjPUjhg62quJrD8cHiFFLAsAihYgx5zOs02QgpO38W2bKOz5QSthbqnZ9TZa5Jd/6CYS8toxg8fSRJlSLhQ7hkAkK/Q4c0Ts0NMoApLrD9jMhnyv3UfPHAczykomjEK8SfIYqFCLhQxWfjkpIE0GXf2ToEDVfuBUHVdkHd2gYDb+jv45CjlUFHjOj5ega8QkeG/UEeJvdpNJ5nFU3Y5JK+KinPwxTTibUc=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KkUNfOZSPGG4BnL84quz8wO8SLdXJnj2UiJQyu2upfJ534+Ok8JIkJT0Q4rBwhuD1tsL3Hloy3JbA6pqDUOVoYDyFPIKECDNrps75bcvfy9FCaDpSHUsTP/KlYVx2d/IiC2eGuvQDsWnko3HWgV3LyWG6VD90J+oDZu0Y0kzuvwjSt0fQ+HNgrpbamsGkR/ps+S2kN+17extdP9dtbynqhGRkcXAPIe7+bpyJpdJ+auQ72K86BMM1Of4/AExN7qxAL15yeo+s3Q5fZLTBqQpB8DTSVjhvO1OEWKkxU1S3bTYI2jjTLcgauKQ8qBt8LQtxVzwhAMXnzWldWZEEjqcMMJWvhT8EEx433mFtBVvmUGA/5mxuB1v8H3e+/Z652lGXOTVkbVlLHKh4UPJknaPbwzE7qkLGcVMpiEDBrwmzz8+z6Vj7LR1xM5o23+46LJM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 08:15:30.9194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed21f40d-cdf6-4757-ee25-08deaa7e7937
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5871
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=avihaih@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

According to VFIO uAPI, precopy initial_bytes is considered as critical
data that should be transferred and loaded prior to moving to STOP_COPY
state to ensure precopy phase would be effective.

As currently defined, initial_bytes can only decrease as it's being read
from the data fd. However, there are cases where a new chunk of
initial_bytes should be transferred during precopy.

The new VFIO_PRECOPY_INFO_REINIT feature addresses this and allows
reporting a new value for initial_bytes regardless of any previously
reported values.

Implement VFIO_PRECOPY_INFO_REINIT feature:
1. Opt-in for VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2 to make
   VFIO_PRECOPY_INFO_REINIT available.
2. Request a new switchover ACK if initial_bytes increases post of a
   previous switchover ACK. This ensures the device is not moved to
   STOP_COPY before initial_bytes has reached zero again.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 hw/vfio/vfio-migration-internal.h |  2 +
 hw/vfio/migration.c               | 73 +++++++++++++++++++++++++++++--
 hw/vfio/trace-events              |  4 +-
 3 files changed, 74 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/vfio-migration-internal.h b/hw/vfio/vfio-migration-internal.h
index a15fc74703..a1c58b1126 100644
--- a/hw/vfio/vfio-migration-internal.h
+++ b/hw/vfio/vfio-migration-internal.h
@@ -45,6 +45,7 @@ typedef struct VFIOMigration {
     void *data_buffer;
     size_t data_buffer_size;
     uint64_t mig_flags;
+    bool precopy_info_v2_used;
     /*
      * NOTE: all three sizes cached are reported from VFIO's uAPI, which
      * are defined as estimate only.  QEMU should not trust these values
@@ -58,6 +59,7 @@ typedef struct VFIOMigration {
     bool multifd_transfer;
     VFIOMultifd *multifd;
     bool initial_data_sent;
+    bool request_switchover_ack;
 
     bool event_save_iterate_started;
     bool event_precopy_empty_hit;
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 2607ce4cec..6eb363d3f3 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -358,9 +358,11 @@ static int vfio_query_stop_copy_size(VFIODevice *vbasedev)
 
 static int vfio_query_precopy_size(VFIOMigration *migration)
 {
+    VFIODevice *vbasedev = migration->vbasedev;
     struct vfio_precopy_info precopy = {
         .argsz = sizeof(precopy),
     };
+    bool reinit = false;
     int ret;
 
     if (ioctl(migration->data_fd, VFIO_MIG_GET_PRECOPY_INFO, &precopy)) {
@@ -368,16 +370,34 @@ static int vfio_query_precopy_size(VFIOMigration *migration)
         migration->precopy_dirty_size = 0;
         ret = -errno;
         warn_report_once("VFIO device %s ioctl(VFIO_MIG_GET_PRECOPY_INFO) "
-                         "failed (%d)", migration->vbasedev->name, ret);
+                         "failed (%d)", vbasedev->name, ret);
     } else {
         migration->precopy_init_size = precopy.initial_bytes;
         migration->precopy_dirty_size = precopy.dirty_bytes;
+        /*
+         * struct vfio_precopy_info.flags is valid only if
+         * VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2 is used.
+         */
+        if (migration->precopy_info_v2_used) {
+            reinit = precopy.flags & VFIO_PRECOPY_INFO_REINIT;
+        }
         ret = 0;
     }
 
-    trace_vfio_query_precopy_size(migration->vbasedev->name,
-                                  migration->precopy_init_size,
-                                  migration->precopy_dirty_size, ret);
+    trace_vfio_query_precopy_size(vbasedev->name, migration->precopy_init_size,
+                                  migration->precopy_dirty_size, reinit, ret);
+
+    /*
+     * If we got new initial_bytes after previous initial_bytes were
+     * transferred, request a new switchover ACK. Don't request if legacy
+     * switchover-ack is used.
+     */
+    if (reinit && migration->initial_data_sent &&
+        !migrate_switchover_ack_legacy()) {
+        migration->initial_data_sent = false;
+        migration->request_switchover_ack = true;
+        trace_vfio_query_precopy_size_request_switchover_ack(vbasedev->name);
+    }
 
     return ret;
 }
@@ -558,6 +578,7 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
 
     migration->event_save_iterate_started = false;
     migration->event_precopy_empty_hit = false;
+    migration->request_switchover_ack = false;
 
     if (vfio_precopy_supported(vbasedev)) {
         switch (migration->device_state) {
@@ -886,12 +907,19 @@ static bool vfio_request_switchover_ack(enum MigSwitchoverAckRequestStage stage,
                                         void *opaque, const char **requester)
 {
     VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    bool request;
 
     *requester = vbasedev->name;
 
     if (stage == MIG_SWITCHOVER_ACK_REQUEST_STAGE_SETUP) {
         /* Precopy support implies switchover-ack is needed */
         return vfio_precopy_supported(vbasedev);
+    } else if (stage == MIG_SWITCHOVER_ACK_REQUEST_STAGE_PENDING_EXACT) {
+        request = migration->request_switchover_ack;
+        migration->request_switchover_ack = false;
+
+        return request;
     }
 
     return false;
@@ -1041,6 +1069,27 @@ static int vfio_migration_query_flags(VFIODevice *vbasedev, uint64_t *mig_flags)
     return 0;
 }
 
+/* Returns 1 on success, 0 if not supported and negative errno on failure */
+static int vfio_migration_set_precopy_info_v2(VFIODevice *vbasedev)
+{
+    uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
+                              sizeof(uint64_t))] = {};
+    struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
+
+    feature->argsz = sizeof(buf);
+    feature->flags =
+        VFIO_DEVICE_FEATURE_SET | VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2;
+    if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
+        if (errno == ENOTTY) {
+            return 0;
+        }
+
+        return -errno;
+    }
+
+    return 1;
+}
+
 static bool vfio_dma_logging_supported(VFIODevice *vbasedev)
 {
     uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
@@ -1062,6 +1111,7 @@ static int vfio_migration_init(VFIODevice *vbasedev, Error **errp)
     char id[256] = "";
     g_autofree char *path = NULL, *oid = NULL;
     uint64_t mig_flags = 0;
+    bool precopy_info_v2_used = false;
     VMChangeStateHandler *prepare_cb;
     g_autofree char *error_prefix =
         g_strdup_printf("%s: VFIO migration init failed:", vbasedev->name);
@@ -1098,12 +1148,23 @@ static int vfio_migration_init(VFIODevice *vbasedev, Error **errp)
         return -EOPNOTSUPP;
     }
 
+    if (mig_flags & VFIO_MIGRATION_PRE_COPY) {
+        ret = vfio_migration_set_precopy_info_v2(vbasedev);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "%s failed to set precopy info v2",
+                             error_prefix);
+            return ret;
+        }
+        precopy_info_v2_used = ret;
+    }
+
     vbasedev->migration = g_new0(VFIOMigration, 1);
     migration = vbasedev->migration;
     migration->vbasedev = vbasedev;
     migration->device_state = VFIO_DEVICE_STATE_RUNNING;
     migration->data_fd = -1;
     migration->mig_flags = mig_flags;
+    migration->precopy_info_v2_used = precopy_info_v2_used;
 
     vbasedev->dirty_pages_supported = vfio_dma_logging_supported(vbasedev);
 
@@ -1126,6 +1187,10 @@ static int vfio_migration_init(VFIODevice *vbasedev, Error **errp)
     migration_add_notifier(&migration->migration_state,
                            vfio_migration_state_notifier);
 
+    trace_vfio_migration_init(vbasedev->name, migration->mig_flags,
+                              migration->precopy_info_v2_used,
+                              vbasedev->dirty_pages_supported);
+
     return 0;
 }
 
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index e91858354c..b6cda19394 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -158,12 +158,14 @@ vfio_load_state_device_buffer_starved(const char *name, uint32_t idx) " (%s) idx
 vfio_load_state_device_buffer_load_start(const char *name, uint32_t idx) " (%s) idx %"PRIu32
 vfio_load_state_device_buffer_load_end(const char *name, uint32_t idx) " (%s) idx %"PRIu32
 vfio_load_state_device_buffer_end(const char *name) " (%s)"
+vfio_migration_init(const char *name, uint64_t mig_flags, bool precopy_info_v2_used, bool dirty_pages_supported) " (%s) mig_flags 0x%"PRIx64", precopy_info_v2_used %d, dirty_pages_supported %d"
 vfio_migration_realize(const char *name) " (%s)"
 vfio_migration_set_device_state(const char *name, const char *state) " (%s) state %s"
 vfio_migration_set_state(const char *name, const char *new_state, const char *recover_state) " (%s) new state %s, recover state %s"
 vfio_migration_state_notifier(const char *name, int state) " (%s) state %d"
+vfio_query_precopy_size(const char *name, uint64_t init_size, uint64_t dirty_size, bool reinit, int ret) " (%s) init %"PRIu64", dirty %"PRIu64", reinit %d, ret %d"
+vfio_query_precopy_size_request_switchover_ack(const char *name) " (%s)"
 vfio_query_stop_copy_size(const char *name, uint64_t size, int ret) " (%s) stopcopy size %"PRIu64" ret %d"
-vfio_query_precopy_size(const char *name, uint64_t init_size, uint64_t dirty_size, int ret) " (%s) init %"PRIu64" dirty %"PRIu64" ret %d"
 vfio_save_block(const char *name, int data_size) " (%s) data_size %d"
 vfio_save_block_precopy_empty_hit(const char *name) " (%s)"
 vfio_save_cleanup(const char *name) " (%s)"
-- 
2.40.1


