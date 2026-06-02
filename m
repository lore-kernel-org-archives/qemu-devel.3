Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6EF5CD6E61
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 09:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wULQF-0006mK-7d; Tue, 02 Jun 2026 05:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wULPs-0006Qw-3b
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 05:28:13 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wULPm-0004KZ-Q0
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 05:28:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cOzPe0HMu1hVwfRCUJm8FPuG5ztkKtgOfYMa+BrYbWmURwFxvZUAEBNg+KV0cUCxejaKgqFRT0BHEgr0V+gTIsypdVy1quRbL5YRZYevNqBJmEqSTk9WNTILBHVfFCWZ72ixKPuhhWLVeqlQCPChnFd+SQiml0Oqg4FEBq5zq0qt14znImGdBnTjLmM3W/IrtjoeuDNf3W/gdNBKiStCXwN34psVf8qN97nWFYxIHfg9Hkml4U9SPIjC24DHrAzPuF/k7kEBHOcGBU3vvCcKM9dbAzW/YHXQNsp8CWj9vveA/w6oaqC++Cv74sKoSb5aqq55rHn/R5N5yB3xeHBTUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsYTiKUMByKP7I84GXZwW9hlEJjiVa5uNAfDYfEJ21E=;
 b=ENyT0M+IOsfIcKPUigsL7yuSf9JzAasPMZiPs+aC5pfZtT9SdPAtgNsal/FYqDEHT3n56lXBiOFmvfAY3mZHga6mDZloolqtUEQdGCTvVzdjws+S8pJEpBSjvhYzRf/WnbiY6vJIcfI0JIkyK/WU9xiCxdMHiuw5rMMyNrtLwH4dStDnj/SY9dBwm4kusNHiFKjL6AkxzVLJ4deZCrz6YDyhxq4p/nVt0yd2zD8X9g8+qhswCxWNM/Jg3DIt7h2Yeg1jwdGUmC8Ya+Hto5jQ8aWI7zy5F8JomdD+vWGTXUy+W916z97rXm0SkYV/e3M8+Th5JUfqEAXPfPkTT3Qz7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsYTiKUMByKP7I84GXZwW9hlEJjiVa5uNAfDYfEJ21E=;
 b=LyuJIFxZUCRREgLwiEsMrV5d2CWteMozubfm9JRh4nkVrecalY/EGWK9bU8KqFUN5b+T5uJTXsWrmNBLousu+yFMGIr4DV+eT0NJhmO7AdVE5sld74ghOUrpC8uK1ah7HAF40RSDHqBZdfltCv5DaG576pC1ua4LIrIME+4pa0LH775ok6YeZSSVJqowksijpgmi12/KP2+7uvKMYsI+sqa7RVi5idVigmTevdjPrWvT4klj7KS/hqAT0kop+EgiWQcm1Qx9u7DkamFqEdb1nmZyIuautc/3d2d/0jYek59dKMp+dAgMx77eWXrANMXnz1dFv3hxms9ixhN6LG6k/w==
Received: from CH5PR05CA0021.namprd05.prod.outlook.com (2603:10b6:610:1f0::18)
 by SJ2PR12MB9115.namprd12.prod.outlook.com (2603:10b6:a03:55c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 09:27:53 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:610:1f0:cafe::2a) by CH5PR05CA0021.outlook.office365.com
 (2603:10b6:610:1f0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 09:27:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 09:27:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 02:27:40 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 02:27:39 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 2 Jun
 2026 02:27:33 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Zhao Liu
 <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, Jason Herne
 <jjherne@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 "Cornelia Huck" <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Vladimir Sementsov-Ogievskiy" <vsementsov@yandex-team.ru>, John Snow
 <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH v2 11/13] vfio/migration: Implement VFIO_PRECOPY_INFO_REINIT
 feature
Date: Tue, 2 Jun 2026 12:26:19 +0300
Message-ID: <20260602092621.382-12-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260602092621.382-1-avihaih@nvidia.com>
References: <20260602092621.382-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|SJ2PR12MB9115:EE_
X-MS-Office365-Filtering-Correlation-Id: a028bf4b-e420-498f-2eb3-08dec0893920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: D51MwbyVMKtukMXxeSU+yjmc6niQfgVbWKS/hs8XQceeWEM2rUt0gdWGJS4q5HWEEsNeIN8jO+6Gld3TAj8Aj2Q0nMhYlr6d73rPu6b8R8dVnc4OivBAezDFurn+x4UNUS6KEAfOvq/JZ4d03mKyh2bycMtDPm48cZD3oU8gHJwZ8W+E6+IwyASfWayqA0k0keV1rgZ0+Ty6fFKccrCP/aR5G1Td67zgbShXDIBlhioAkPCIZ7+E6q/rgmk8SSCQ3OSATklbaFKBzs92KnEGcEILPRi4V2UtSGLq2seWCTCiIhnKQ9peGZOEhyyDcLsxBuMALftYU+BlkL+RcqCH1WU2MvgmsEAc8QXnxmMWAllV9nR6M4SmGwqCt7nE/tOuc6rtEYAq/o40F0Mx1HTKf1gx3crFEc1IL2NYKxg5yQiDS95XCyW5xMIGLuhdSGnoc3mObfetU82XOA5Ngi1E7ogRU70cCFwltZPETdutjxgVv5GTQePKOtpzt6kg22hw5/DBwATzmmXo9Shb1rT+ZZoGyZoOFHX+vo0owMet/8NmPe2IV64NoUjeojYqUxWPLi8rkeWcKtZWg33ba2/xNZ8kI5EbV8g+8jWdxVxHOyrA1nks4bCqG3H+nDKXQ8N+xS+R4ctzlQ2skION17ZxGkz168uSDSvZgCtJr9iHAbOyNawX5CoPEpxpUcQIU4cpNG5F86TpXh56BcIKpvACVDQUBvkOdh3k1cnoVOe/nIs=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dkcQu4bolzQgBBAp8aQwxRVPcbkYDBs+OIizJVSaZH+x9r8pOzx14smEqrIZs0idslV5Avrk/8EEIAFBbPb4FJIaB2Icd/pAFDVlnZwQZ4WtgvINK/tpDuISd0e0ONP7fXnJ1eS2ZkrqxtiE2/OxpVYH8APzS9jmuPZPZw2sFfSrHkk3nA3bGBCaHgfHiJPP5+DshreQip4rvnAo6f/mZ8H6k/N+QORKpextoourYfHN6mlfs8U08RCjCQIQRwVPrPwRd8xggsM8LaMNvW9aZyOS4Bpm1NA7JinfXe5I0YOUs9L+yGcBMzKIZ1Qmn7lbey4sQHC1fttgyi8uaFKnTH9/u1YEu1UWWo1XL1ixvI4q5ZTpv9wLEbOkIvJxrKozueKZu2/Sx+Rf+3RZg2TqkXy8/QzgvPk6Dw+cciLhIwvvxOkTPEPbOsbO0b8wht4J
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 09:27:53.3495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a028bf4b-e420-498f-2eb3-08dec0893920
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9115
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=avihaih@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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
index 2296d0d44b..caf4d5e19f 100644
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
@@ -1053,6 +1073,27 @@ static int vfio_migration_query_flags(VFIODevice *vbasedev, uint64_t *mig_flags)
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
@@ -1074,6 +1115,7 @@ static int vfio_migration_init(VFIODevice *vbasedev, Error **errp)
     char id[256] = "";
     g_autofree char *path = NULL, *oid = NULL;
     uint64_t mig_flags = 0;
+    bool precopy_info_v2_used = false;
     VMChangeStateHandler *prepare_cb;
 
     if (!vbasedev->ops->vfio_get_object) {
@@ -1105,12 +1147,22 @@ static int vfio_migration_init(VFIODevice *vbasedev, Error **errp)
         return -EOPNOTSUPP;
     }
 
+    if (mig_flags & VFIO_MIGRATION_PRE_COPY) {
+        ret = vfio_migration_set_precopy_info_v2(vbasedev);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "failed to set precopy info v2");
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
 
@@ -1133,6 +1185,10 @@ static int vfio_migration_init(VFIODevice *vbasedev, Error **errp)
     migration_add_notifier(&migration->migration_state,
                            vfio_migration_state_notifier);
 
+    trace_vfio_migration_init(vbasedev->name, migration->mig_flags,
+                              migration->precopy_info_v2_used,
+                              vbasedev->dirty_pages_supported);
+
     return 0;
 }
 
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 50722eb717..464c28c860 100644
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


