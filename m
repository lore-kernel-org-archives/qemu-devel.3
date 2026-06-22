Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0065CCDB46B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 10:16:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbbhL-0006aj-CP; Mon, 22 Jun 2026 06:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wbbgQ-000644-FF
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 06:15:17 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wbbgO-0006pM-4N
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 06:15:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZfvzmYgKt/FhHYGbbtwCJhe/8zc+slubZtDoP2/wCPXk4hjofvRWhnVb8XRw3PjLQNHZ3zjDUzDraWYR+6sIDVZL8c9i2G8YA3uvlb4U+kw4aG7hM4KQvcFhsd4OXhiuTbsvILQZV6049lolxDvrcS1gBd4xBO8Uq2gWA9tRdeA8SZTl53e2YGVsMacN8CXel0XTLTmxHrRky42APARQB/Wt0Sogba3k1CzvqQ97rFs3vsOVcJo1/BFeA4PYUEA9UHDGM1Mo/EkB6vd7yWD9ONVBCZO1uhC9VJIsD3tZ5auyka3deiCclCVO0qRmzIVJpNxPBTH/+lPjwa2vMOb5Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47YHRUF//ZrkahKfwOAepPStuYLt1RbPvqkD10sW/vY=;
 b=s5fX7ojUnOHSw8l8CJU2i8Yt26PcFH0CqYzRXxq4gHjO+pofRW5qjjs1bqeKrLuOcmEKUoywjjc/8u9wBTgcJWgR1SE6LNvlpDvm2crc+iO5hi4UAc6mVoFqGEva4EBs+S9S2GiPWGbm2AID+4lDKvxTLwR3eS4qagnsnYfoLODxsxtkqMEzcWdxqmP35dYwvI1WlthOqbX33YtQXyAtKgEexq6cgQDL0G3NuFLM1MJ0cbehXSatkxmxt7zFLuup3wwcB7r6rrwHJrM2PFplZcBdrDW8gqe7/PavYI0JZw9KdvF60oZDLp+j/Wr+nHU3bkzr1OKGNVAuGcuFjBx88Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47YHRUF//ZrkahKfwOAepPStuYLt1RbPvqkD10sW/vY=;
 b=T7a1pmsdOA52ds6CF2BAazzSYfWl1xjuWjeNm9y7CdMMyJteqpX2LK/+Sz9u/iUnW4YS1N94Y7Z/TOl+Gx7Pj43QEil8XpWNLxEI0QmwegL3ClMwYXtr3CN5q0KGkxkCmWpk471wToAw0WiHguv8bMvrasE46Gnyr33RPqRDecRJO1mASZ+UsdfmlmApqfItnDRBQpeWfSCuTX8/upMliPrsOunMSMKnxEVtuX2QD0XI7k8QaRwDPIfI4eIYntTISlNq1G6iFHeXHacdjzeY945WmDFh7T73C4bno7rYwMQo6HUbxijeWTllwiCRGnUEyc7QIyMJy0lh4TxEiPED2w==
Received: from BL1PR13CA0191.namprd13.prod.outlook.com (2603:10b6:208:2be::16)
 by IA1PR12MB8336.namprd12.prod.outlook.com (2603:10b6:208:3fc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 10:15:03 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::42) by BL1PR13CA0191.outlook.office365.com
 (2603:10b6:208:2be::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.9 via Frontend Transport; Mon, 22
 Jun 2026 10:15:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 10:15:03 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 03:14:49 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 03:14:48 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 22
 Jun 2026 03:14:43 -0700
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
Subject: [PATCH v4 10/14] vfio/migration: Add Error ** parameter to
 vfio_migration_init()
Date: Mon, 22 Jun 2026 13:12:10 +0300
Message-ID: <20260622101214.25770-11-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260622101214.25770-1-avihaih@nvidia.com>
References: <20260622101214.25770-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|IA1PR12MB8336:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b90efd9-5aad-4143-43b6-08ded047204f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|7416014|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fytT71nQc+ds+vy0V9FTCzuVdHiaghQ6xS0VfqroKInlUjzh1WrA5sXAXYVFO58rmsC1OKNAiR3zaDkEev0AgmFCigbw6JdtKXwIr/wXyPEP5i/6fGCWqza8zf45RZ++k/ZsP8MOLJc7C5HqP7JacBEdiwumTOs47XcaTnAyHzoxyVgqSmr5VGLOHOCt5X/ZLZTOURelwfdYVbFCeH2sYx5NXgi+cwsInstL6mDstTaOR1NPLnKQvz36+3tjC8LsvhugnIlDZy85UilNUkq51/fkdOsWmrARxcEtZYykZ411ZgKdn+haR+Y0G0GEhhrCHlaVYdxzllpXGrs8lBGWnS0+PAQ7dqBuBCGYjSI3gXWHWpmeiMY55KPGOGChiSCCnYU725oKRzlW/ln1fJBil/XyCWeMn4oBs79GxakDj4Akmdv4HgdCZMiD/IfvVF73TNvN5EXIQsRDfgPwx2UAoYmd8kITcAC3DXNCMEhs8Q4mb7cdqQf0MD6a2TbQ25sdxAI/b8fMPP8d+iaEp4rJNwiWAVzulDAtmfUzGPD+4bY89eEV1u9PH/O27v9Q9krRg2ZXpRTMF2mh8iS4hLbIDEg42EV6ATWWmEmrKWbDrCHqBam6Wmhz1/4mRmzxzX05vd58iwf2yeLiHGtulf6RS7dLGKxvradIMGdQkS0PVk3Xdldpm0Kmvhz9xhyrJd/x
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(7416014)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bGl0Hm5BxZFPoC2V6fvnmvCYs5bTqie3BzC8WSdr+Gl6slXWAFAXZBn0OptAq7oLnkIn16y4UugV29Ii1kP4XoTDr+XOp3jhSmDdAzMXEjYUW90S/b0eGrF+KWIXZnPcW6PkscDCN4oSKdO2ppJkirWDWKpOm5TBaGyZ+CiiOPNV5ViaI/FzT9gUu7TrZE5BOgApF5cpq1sGB7Ovn7G75uhZwBAQuj8airpu4CyXYuwlf+KSWCduUfiNm3OIVPq4ziN4uZFPhvhYhkwziRvrQcnduCGBe8+jwTWBz0NsHUh8MC6TViZ0A24lR/A5qjGyWOxIiSVpU1StT1yil+cWgK5ERGTIU6+4SWk+v8135PyLt6EOiPJOHEDEh9KZCRN/U6krHpwHm4sF0DVh+/cpeeLRoWMYw5a6ST/rykOo4qC//oadjq+P/4fDhyEwd134
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 10:15:03.4518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b90efd9-5aad-4143-43b6-08ded047204f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8336
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

vfio_migration_init() already has many failure points and a new one will
be added in next patch.

Add Error ** parameter to vfio_migration_init() to report a detailed
error message through it. Refactor it to return bool as well.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 hw/vfio/migration.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 45f8e346b4..3ab6b7248f 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -1056,7 +1056,7 @@ static bool vfio_dma_logging_supported(VFIODevice *vbasedev)
     return !ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
 }
 
-static int vfio_migration_init(VFIODevice *vbasedev)
+static bool vfio_migration_init(VFIODevice *vbasedev, Error **errp)
 {
     int ret;
     Object *obj;
@@ -1067,22 +1067,32 @@ static int vfio_migration_init(VFIODevice *vbasedev)
     VMChangeStateHandler *prepare_cb;
 
     if (!vbasedev->ops->vfio_get_object) {
-        return -EINVAL;
+        error_setg(errp, "no vfio_get_object handler");
+        return false;
     }
 
     obj = vbasedev->ops->vfio_get_object(vbasedev);
     if (!obj) {
-        return -EINVAL;
+        error_setg(errp, "failed to get object");
+        return false;
     }
 
     ret = vfio_migration_query_flags(vbasedev, &mig_flags);
     if (ret) {
-        return ret;
+        if (ret == -ENOTTY) {
+            error_setg_errno(errp, -ret,
+                             "migration is not supported in kernel");
+        } else {
+            error_setg_errno(errp, -ret, "failed to query migration flags");
+        }
+
+        return false;
     }
 
     /* Basic migration functionality must be supported */
     if (!(mig_flags & VFIO_MIGRATION_STOP_COPY)) {
-        return -EOPNOTSUPP;
+        error_setg(errp, "VFIO_MIGRATION_STOP_COPY is not supported");
+        return false;
     }
 
     vbasedev->migration = g_new0(VFIOMigration, 1);
@@ -1113,7 +1123,7 @@ static int vfio_migration_init(VFIODevice *vbasedev)
     migration_add_notifier(&migration->migration_state,
                            vfio_migration_state_notifier);
 
-    return 0;
+    return true;
 }
 
 static Error *multiple_devices_migration_blocker;
@@ -1279,18 +1289,8 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
         return !vfio_block_migration(vbasedev, err, errp);
     }
 
-    ret = vfio_migration_init(vbasedev);
-    if (ret) {
-        if (ret == -ENOTTY) {
-            error_setg(&err, "%s: VFIO migration is not supported in kernel",
-                       vbasedev->name);
-        } else {
-            error_setg(&err,
-                       "%s: Migration couldn't be initialized for VFIO device, "
-                       "err: %d (%s)",
-                       vbasedev->name, ret, strerror(-ret));
-        }
-
+    if (!vfio_migration_init(vbasedev, &err)) {
+        error_prepend(&err, "%s: VFIO migration init failed: ", vbasedev->name);
         return !vfio_block_migration(vbasedev, err, errp);
     }
 
-- 
2.40.1


