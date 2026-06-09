Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BDECD8CAE
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWrPG-0005wj-Fi; Tue, 09 Jun 2026 04:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wWrP1-0005jb-9L
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:01:43 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wWrOy-0004xR-Rn
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:01:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rdttqMRKhCNaicHYEfhILmO3f87dMO39g2UfDCJPi7QyduQX6Rm7MSl+2PxZ8V0oiIwfFNYRC+jzsttB7V42eCneOr3j5MbY55wjALREB6qImlIE3NXVhLMvtbfat/CyZiDhtiHSas8YPHtpxrW0n5VaSRjsz5YE2/YrZNQQ5JNxGWBDvfWWauUXARcU0q+HNsz1wGWhm0zfklDPWMt57lo2IRTJ2iGD+uuK7/IoAGumFR46n2oXPYRXL5zHvJs8lZBHa9MNyJ6aIMmCMiJ44kH/ANrbpQasVc1fJshTlRGRSC0McBuXnlYEWx/tfCcwlpQ9cXyGu0Qiuv6Q/Ln6sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93fh1OwHI68iklAlm8ETJeA+vteug4y5jWG+fFmE/Ss=;
 b=jYJrRYruGhCs/9vd++D6ZgvIwFLH5Yrgqm32iGAS/rBhnZbkPyA5UIUMMbpeKb0ijUr9c4/pxdzdNRB44Whfv0CMJ0JyCMg2HYYI6Z9dvUT5gyN3f/ndL6ZLeud14wQ/E3H4IN4zlhNSwvWtzKOh3GvIZ2Zrxy9XSSGxG+iEJkfMIX2CQFQzdl2lS7tst0CQdMll0WtdijXNOrGwFB98/sVsKNkZeTRJZeJRAkQ8PNruiauYsxL5kKDab9w6aBZMSmI9SYD0fhJVKbo3G0f8b1c4Jj4U7bS/Z8s/NRtIMFNT/WiW4ACeVoHeMzI8I8+MYFwy/cHIgycqWplaMWdnyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93fh1OwHI68iklAlm8ETJeA+vteug4y5jWG+fFmE/Ss=;
 b=o+kTD3fKXI7QHbJSjTJVQDcQmAg7ndGAk7SFob2sLcMV/gtdV+PgfqsUIXQw+lHLxjGWcyCiy7DW+VtI6W0xg7fBttMVGgXXaxDvCBilh0ZPfzTcEqoNlZv088RJuqvVAHImeJPBeIkbAclKSFs/fRu6Xd+dC8NSbtVecumvI18c3bzYufDD312ZdlqW1JgtcFaGSePFhNPWni1NcE68OpU1BNWz3Hbfq5uUUWKNGHC1SnPoaBjEXKbzb2GLqQSkcxLppPZLlRFeGm2dNW2c5tULWZUTb7nRF90OfTle5Kawxs3YvNDEla9T9o1BauucMQh5vbuQ5hMVKQqo+s18Uw==
Received: from MW4P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::21)
 by IA1PR12MB6209.namprd12.prod.outlook.com (2603:10b6:208:3e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 08:01:28 +0000
Received: from CO1PEPF00012E65.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::77) by MW4P221CA0016.outlook.office365.com
 (2603:10b6:303:8b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 08:01:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00012E65.mail.protection.outlook.com (10.167.249.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 08:01:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 01:01:05 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 01:01:04 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 9 Jun
 2026 01:00:59 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>, Zhao Liu
 <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, Jason Herne
 <jjherne@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 "Cornelia Huck" <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Vladimir Sementsov-Ogievskiy" <vsementsov@yandex-team.ru>, John Snow
 <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH v3 12/14] vfio/migration: Implement VFIO_PRECOPY_INFO_REINIT
 feature
Date: Tue, 9 Jun 2026 10:58:10 +0300
Message-ID: <20260609075812.32067-13-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260609075812.32067-1-avihaih@nvidia.com>
References: <20260609075812.32067-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E65:EE_|IA1PR12MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b8ff2de-302d-4843-3835-08dec5fd4f50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|22082099003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Xm5jFUahkgOUkFm3GGfN9XuSGuIYhhN5M5lA+wS5gZfodKyEuHwRiC/0HrSXR+iXFPRw+7KnYmKOz3dY7SNG7lsziiQF7ZzhzrfPfOwY6n9epctIslRTPuxsQtSrThq/gkB9JAMJtY55ULChvihhYOMqZyx2PC+SxMkD9B2jKSYzRIIyBOWHAIDE6N3SGHbNgW1a3CIwJ37Yb2k5de++FUOSilQ9L2H1Od2TV/+y5rXPISVLlq9SjPGTJoYYGS6VND9qUDjkcwua00M7aRsepT+ucs2EBIRENTDVgWlqmDiLyR0p85UUrDqHDRvaSViOC9KdzeDAQ0E+aYOKGm3V99PATSUtVGOVZnKC8EOdcX+8uQkQjskvMAqV/bmzTjWlyFsWlLucgaFO2cNRasPfdW6BS64QIIC2pQhrrI5VZA7lgzs2sYyuc/a4yJ9rBEk6GbaDviY4pmy/xK/P+KK2o5UnExjIKEajcExyd/XDuhQ50vdbq0PC0GlN5UqkjGBsK6BeSf7UTXjD2tVBSYoBNPX2EwqtWBb/pUCx1ESpRmxUiUt3TUpsPveFtT7UcHDpPVTVoEHlZmjkMlfBzoppBjBhPCSCOYinKVXl6sU/llkug23/mYym1Mk1HrFsNpFskfKTcf1tmfjKcudpG5mu+KJIU9xC5HF+MMaUqQUGYPvS4urxVwcZJGOlw/qXp3tXXUuMb8Dedysyo6sk5EVxD2dA+jAgXEWFpjH60DaueY4=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Nej0oU1nZVf4Vgf6O9BzTA4CXKhFJ3GcDdB4BKIoW87ZFvV31Vt6TQnColJr6TxfEYCL+lJnljKNm6b+/e5xoUB6YnP9IMCm4o05R+GERvfv8t3UQGqgVG9QbPMAp2VLJtBTUtdnZDM/ENFpAY+tsyPEeGBmLCg0Fac1Q5Wf9SLS/1CPIoIroxEoMGi7rTdfeD8//VUUowAeaSgM/pGXzEDgOQ7CBdTT1YZN0v05upuXNQuxK8yA/jZvAUeKZ+UcgIzt2ZsaBNkLRXtCWGEOfZC8VWKujrg4c59jbaKLwtamF6vXLXDvQOX2p38fWhS5DD3LNauAh2lYnuYT8kfMBBKSLtz/MGoETENQ5WLYON+F2qSW9HMn26E3nbLu9Leh8uFd4fow7zn4ROkX9MSiJ2+OfLI3tdDYqg6BJWRbLj+B3NObe9Usy5mR+f/1hNVX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 08:01:28.0237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8ff2de-302d-4843-3835-08dec5fd4f50
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E65.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6209
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=avihaih@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 docs/devel/migration/vfio.rst     | 14 +++++++
 hw/vfio/vfio-migration-internal.h |  1 +
 hw/vfio/migration.c               | 68 ++++++++++++++++++++++++++++---
 hw/vfio/trace-events              |  4 +-
 4 files changed, 80 insertions(+), 7 deletions(-)

diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio.rst
index 854277b11c..f235c2d4f9 100644
--- a/docs/devel/migration/vfio.rst
+++ b/docs/devel/migration/vfio.rst
@@ -23,6 +23,20 @@ and recommends that the initial bytes are sent and loaded in the destination
 before stopping the source VM. Enabling this migration capability will
 guarantee that and thus, can potentially reduce downtime even further.
 
+For example, in mlx5 devices, the initial bytes hold metadata used for time
+consuming pre-allocations of resources on the destination. Although init bytes
+may be small in size and sending them may take little time, loading them in the
+destination can take a significant amount of time. Switchover-ack guarantees
+that this pre-allocation doesn't happen during downtime.
+
+Initial bytes was originally defined to be monotonically decreasing, however
+there are cases where a new chunk of initial bytes should be transferred during
+precopy, e.g., due to a device reconfiguration, etc. The
+VFIO_PRECOPY_INFO_REINIT feature addresses this and when supported, allows to
+report a new initial bytes value regardless of any previously reported values.
+In this case, a new switchover ACK will be requested to make sure the new
+initial bytes are loaded in the destination before switching over.
+
 To support migration of multiple devices that might do P2P transactions between
 themselves, VFIO migration uAPI defines an intermediate P2P quiescent state.
 While in the P2P quiescent state, P2P DMA transactions cannot be initiated by
diff --git a/hw/vfio/vfio-migration-internal.h b/hw/vfio/vfio-migration-internal.h
index dc741e5142..a1c58b1126 100644
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
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index ebe2eafded..1e172dd10b 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -373,9 +373,11 @@ static int vfio_query_stop_copy_size(VFIODevice *vbasedev)
 
 static int vfio_query_precopy_size(VFIOMigration *migration)
 {
+    VFIODevice *vbasedev = migration->vbasedev;
     struct vfio_precopy_info precopy = {
         .argsz = sizeof(precopy),
     };
+    bool reinit = false;
     int ret = 0;
 
     if (ioctl(migration->data_fd, VFIO_MIG_GET_PRECOPY_INFO, &precopy)) {
@@ -383,25 +385,43 @@ static int vfio_query_precopy_size(VFIOMigration *migration)
         migration->precopy_dirty_size = 0;
         ret = -errno;
         warn_report_once("VFIO device %s ioctl(VFIO_MIG_GET_PRECOPY_INFO) "
-                         "failed (%d)", migration->vbasedev->name, ret);
+                         "failed (%d)", vbasedev->name, ret);
     } else {
         bool overflow;
 
         migration->precopy_init_size = precopy.initial_bytes;
         migration->precopy_dirty_size = precopy.dirty_bytes;
+        /*
+         * struct vfio_precopy_info.flags is valid only if
+         * VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2 is used.
+         */
+         if (migration->precopy_info_v2_used) {
+            reinit = precopy.flags & VFIO_PRECOPY_INFO_REINIT;
+        }
 
-        overflow  = vfio_migration_check_overflow(migration->vbasedev,
+        overflow  = vfio_migration_check_overflow(vbasedev,
                          migration->precopy_init_size,  "precopy init size");
-        overflow |= vfio_migration_check_overflow(migration->vbasedev,
+        overflow |= vfio_migration_check_overflow(vbasedev,
                          migration->precopy_dirty_size, "precopy dirty size");
         if (overflow) {
             ret = -ERANGE;
         }
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
@@ -1054,6 +1074,27 @@ static int vfio_migration_query_flags(VFIODevice *vbasedev, uint64_t *mig_flags)
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
@@ -1075,6 +1116,7 @@ static bool vfio_migration_init(VFIODevice *vbasedev, Error **errp)
     char id[256] = "";
     g_autofree char *path = NULL, *oid = NULL;
     uint64_t mig_flags = 0;
+    bool precopy_info_v2_used = false;
     VMChangeStateHandler *prepare_cb;
 
     if (!vbasedev->ops->vfio_get_object) {
@@ -1106,12 +1148,22 @@ static bool vfio_migration_init(VFIODevice *vbasedev, Error **errp)
         return false;
     }
 
+    if (mig_flags & VFIO_MIGRATION_PRE_COPY) {
+        ret = vfio_migration_set_precopy_info_v2(vbasedev);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "failed to set precopy info v2");
+            return false;
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
 
@@ -1134,6 +1186,10 @@ static bool vfio_migration_init(VFIODevice *vbasedev, Error **errp)
     migration_add_notifier(&migration->migration_state,
                            vfio_migration_state_notifier);
 
+    trace_vfio_migration_init(vbasedev->name, migration->mig_flags,
+                              migration->precopy_info_v2_used,
+                              vbasedev->dirty_pages_supported);
+
     return true;
 }
 
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 53f0ba357b..9f5c30d2f2 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -158,11 +158,13 @@ vfio_load_state_device_buffer_starved(const char *name, uint32_t idx) " (%s) idx
 vfio_load_state_device_buffer_load_start(const char *name, uint32_t idx) " (%s) idx %"PRIu32
 vfio_load_state_device_buffer_load_end(const char *name, uint32_t idx) " (%s) idx %"PRIu32
 vfio_load_state_device_buffer_end(const char *name) " (%s)"
+vfio_migration_init(const char *name, uint64_t mig_flags, bool precopy_info_v2_used, bool dirty_pages_supported) " (%s) mig_flags 0x%"PRIx64", precopy_info_v2_used %d, dirty_pages_supported %d"
 vfio_migration_realize(const char *name) " (%s)"
 vfio_migration_set_device_state(const char *name, const char *state) " (%s) state %s"
 vfio_migration_set_state(const char *name, const char *new_state, const char *recover_state) " (%s) new state %s, recover state %s"
 vfio_migration_state_notifier(const char *name, int state) " (%s) state %d"
-vfio_query_precopy_size(const char *name, uint64_t init_size, uint64_t dirty_size, int ret) " (%s) init %"PRIu64" dirty %"PRIu64" ret %d"
+vfio_query_precopy_size(const char *name, uint64_t init_size, uint64_t dirty_size, bool reinit, int ret) " (%s) init %"PRIu64", dirty %"PRIu64", reinit %d, ret %d"
+vfio_query_precopy_size_request_switchover_ack(const char *name) " (%s)"
 vfio_query_stop_copy_size(const char *name, uint64_t size, int ret) " (%s) stopcopy size %"PRIu64" ret %d"
 vfio_save_block(const char *name, int data_size) " (%s) data_size %d"
 vfio_save_block_precopy_empty_hit(const char *name) " (%s)"
-- 
2.40.1


