Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63083CD6E57
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 09:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wULPb-00062T-9s; Tue, 02 Jun 2026 05:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wULPZ-00062L-Sz
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 05:27:49 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wULPY-0004J4-G1
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 05:27:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTL5oRyMFBzxAJHhmJh7erwa1wBy0rvPebxYo5zS9Cb1IVoIFO0DiSfx9+Kfzf0AUAo5KqpzUGn8qoB30YdSRGa3IChKBsEgj+1jc5GQtN6aSJ8wLgK+V6xR7LpJVNead6ACoMbyO9VvosqOfcBLmbmvUAXLDCylEqDCM1cDpxxaWy7MJwMT1gPYbJw5dY5C0iJl4gvtWuZRS34oefnLRp+bW7gf3s39uMNfaZ8tK/YrHwXoZUCe1DnPh3yv4A21M1FewBrbBz4WjpezOof3YSfp3cLPsMkbZ12EKo+R1X/RI39f9gs9VWse/LxAwnOmt3gZo/pQGynfZtTpYkMkXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSadcmZWNggkVFRixwLYfj9QC/MBSzVomxP79ut3tV4=;
 b=sdep4mSctic1VTHRpQviAqxGSDgvZbz+bETNHNaTEOMhCF+P4AvN0X7BgS0RfliwxJn/zLIlcI1rCW8b8flwUdyHzk3dUQuq01b55yRaarvXQgo5sqVVx0zOGRgw079wnet4pBttvHp4OF+w56skTIpZohoz6oclW3Z29i+pqOMFL0UKHvmR7N47JW2oPKPNdeemR74tKwM+gJJ62bOy2JEs0Hil0l0pwHwEevHBOEe76thu020RqHL55Ol2T7OTewlUp5m2l63d3FuP6/lU75CENmDEdM5Kn0WxYgnQU3njUv83KyTwLhT/Ei2NlZQce/ELagT2WcQ9H3dx7BgTnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSadcmZWNggkVFRixwLYfj9QC/MBSzVomxP79ut3tV4=;
 b=S3jc22udRCiref0Q5Kj90ALkBwkbEuJgoUqBQBLZFhptJ6wFN/w/lhjx6VRcnSs/efJgnOFJtSNnYi2lTM79vaGrtfbDvHsuOEetDdu2lYsA97LgWY+6FG7Oa2S2dbyP/z/wis7QzOB7xvx72EeRrHQfhdCgXHg/WKiTSFEw/dxnFKOzECRkKKpLcNahyioQRvp6cV90b9iUoZ5dNarOc31Iy8gyLwlAeoIYm1L3QTQtjQyI4chGd/NhpU9zT1LhJaxY4pY0Apgf8QQyGRga6FlxgWM571UmvITA8zErQKrikVpZAmhsG5Yinmczr/3lrk+PyLyfn4Chuh0NkSATHg==
Received: from BLAPR03CA0048.namprd03.prod.outlook.com (2603:10b6:208:32d::23)
 by SA1PR12MB6750.namprd12.prod.outlook.com (2603:10b6:806:257::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Tue, 2 Jun 2026
 09:27:42 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::81) by BLAPR03CA0048.outlook.office365.com
 (2603:10b6:208:32d::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.15 via Frontend Transport; Tue, 2
 Jun 2026 09:27:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 09:27:42 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 02:27:27 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 02:27:26 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 2 Jun
 2026 02:27:20 -0700
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
Subject: [PATCH v2 09/13] vfio/migration: Add Error ** parameter to
 vfio_migration_init()
Date: Tue, 2 Jun 2026 12:26:17 +0300
Message-ID: <20260602092621.382-10-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260602092621.382-1-avihaih@nvidia.com>
References: <20260602092621.382-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|SA1PR12MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: e1714fac-dca4-4b9c-bc31-08dec089326c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|7416014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Vrbxu9VT98zK+SFf1NisVDeazf30RBbFrRuN6Pf6JdK+hFQ6pOaEhKc3GrTsmVhez0FdaTxYMzMs5sPCWfU6/pJFzfSGJPuFlRDZbCjtQ6I4m5Zdckfg6o/JAtb7W5vERrdQ21b9llDIqR4zuxrghpYQZVI8qYjcJddtbOOAr3e89lLb5OJ7W3e1Yjvee/MH/CyxEa6VXCC+PnsVDy3CVX8AWPXYnenhUjjPjyUT1kwSfFNThRIn21jWkkBGVCnmoWk4710RIp7X7QQMWvEFqg3O0+Dh/t9N2L2wK5F+gnLiFL8ekFtwT+Sfrjl566X0DOS6XwvuI50iAsqyaaEKue55Iv9oY8QZmGGT3hHz0LeKHjpZoWQJdlodSh5rFhQ5Q96UV1yq/PWzKaf1UE1D85lI2dAlL/MmiG+RWK0a5AiMsdMYcEp/wMXVUffhjUEkcOYU76Mj/rfuzHFDTCByp/a5pB67d3zX5ou6a8mVEHbASS3DjNjgv4POJut3MxvJFjhL0spuFkxblKa2wsmYIgBmzHaugP1Ij4y/oVnjIE8Du4K3QrrDkArLtb9QiX+gEyvjOw8V1mMV3YB+3TrLUK/juY/YbwCsAkh6QntHv8hbhnAlmY+7u1Wl8f14jQB6sA9Ih6FxZxtWELaXpq3WBszzpyXz3XIAXcxOXOaE25zQJjwUYi1I/f11EKQ3YX73+jxC8lS+KLi8l9qxoWEfyJ5k1K5Nl5yW5t9VAGRRJWk=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(7416014)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KfuuJx7C7TcaaQhpAwVzJhm06mkLjD8my8esp6Fc9cFkBeURuURxKf5Rbr29ly6WGzI/DpZN/XXfudKgpwCKBC4NSqSAt6kC5cHlzS45I/nJmiMWLS6mPdjT5HJjvc2xxYWYEIKHYbvMEEDWK2JdZBOtoNmjv/F0+KAqZaAy401WxnskOp/E9+b8SDQfogI2V7OGEeL1PpMki4wNu0hwbNBbT3D7eCv/DFSKFOZmQPmDaP3uHXtFXIpccs2ajs2AYOY3BBK1tsAm7iPoEd1N0nSdnXlUvS9n4LMDBQQMggTrmsRUgv/UNfuvktggZA8/KD2x0wfQrXTA0W0TqqZ4Bn2ux4ss1jKezFe2Acy0/BtoeMREt7hY2QB1za0d+dOIekWCNvB85m+wC9DtQ7AzoXmGbCZa/V9cZOEB7PVope0za36c5Uy/8ha/TSEDrgEV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 09:27:42.0215 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1714fac-dca4-4b9c-bc31-08dec089326c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6750
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=avihaih@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
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
error message through it.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 hw/vfio/migration.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index a15e877fd3..02ef216712 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -1055,7 +1055,7 @@ static bool vfio_dma_logging_supported(VFIODevice *vbasedev)
     return !ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
 }
 
-static int vfio_migration_init(VFIODevice *vbasedev)
+static int vfio_migration_init(VFIODevice *vbasedev, Error **errp)
 {
     int ret;
     Object *obj;
@@ -1066,21 +1066,31 @@ static int vfio_migration_init(VFIODevice *vbasedev)
     VMChangeStateHandler *prepare_cb;
 
     if (!vbasedev->ops->vfio_get_object) {
+        error_setg(errp, "no vfio_get_object handler");
         return -EINVAL;
     }
 
     obj = vbasedev->ops->vfio_get_object(vbasedev);
     if (!obj) {
+        error_setg(errp, "failed to get object");
         return -EINVAL;
     }
 
     ret = vfio_migration_query_flags(vbasedev, &mig_flags);
     if (ret) {
+        if (ret == -ENOTTY) {
+            error_setg_errno(errp, -ret,
+                             "migration is not supported in kernel");
+        } else {
+            error_setg_errno(errp, -ret, "failed to query migration flags");
+        }
+
         return ret;
     }
 
     /* Basic migration functionality must be supported */
     if (!(mig_flags & VFIO_MIGRATION_STOP_COPY)) {
+        error_setg(errp, "VFIO_MIGRATION_STOP_COPY is not supported");
         return -EOPNOTSUPP;
     }
 
@@ -1278,18 +1288,9 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
         return !vfio_block_migration(vbasedev, err, errp);
     }
 
-    ret = vfio_migration_init(vbasedev);
+    ret = vfio_migration_init(vbasedev, &err);
     if (ret) {
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
+        error_prepend(&err, "%s: VFIO migration init failed: ", vbasedev->name);
         return !vfio_block_migration(vbasedev, err, errp);
     }
 
-- 
2.40.1


