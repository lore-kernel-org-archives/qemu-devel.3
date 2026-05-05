Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C8BFF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 08:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKAwN-0001WV-80; Tue, 05 May 2026 04:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wKAwK-0001Tc-DM
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:15:36 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wKAwH-0006jT-6Q
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:15:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ns6k09YyBIWhvM+n26dmZaxsep6KiMC+ruSDPWmucgVaXK6eRxvdPYoeYtdict6CNLZxOFxgVZ1hAYXAP2ROK7fkq7t1rNDNkzBuZNClGTxKrFNjr19LDBE7JzbZvzfaf9NmjUa+18wQzxyPtxDGiwUGXd/Rn1jIess+INqFLQf7uQuZyZmIuPHcvyYuayfvZNzrkxX01lZtf0/s78+Ct7FZrIRYKzRTohp1BAbg8K/ncnqtJA6U1Ob/F1fE2mh7PuZ+bTOXeanAkrs/Qau8uHC1LdGteDYD5U3CsUGk3kUbGGoVJ2Oy5B9mdDcPUvdgq8IcND2uJnbMYGYRz698oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxaTd2hU6frvpCjaKMX/TeFHP9yMKhQI8XcqRIcNPOs=;
 b=qdzO0AtpLgvQ7q1Z6Z8GYySbqvK+rJtFwlcYR+sG35VvmGTveHPUy3tHIo1zeQgoaAbv5WunkoIwcyXtAhtBpyzOsj+Azjh36Kektk/gXu1mTbLy+i1FKNSCUtTV9krdZGttvkXeJZpqsltVQM+LovqcwitBygaSX1kIRkZiMq8DrywRfQgUFZrsLYOIU92y+vd5Ge1CtV3Uzy+TtukGKeiogvKYPZFGH1VeQwl4OJL8CRK6kiuaM7SX4NdV2psBdgnhLH2riCzrxlke/ycPthXQJDKp6LYwoosu7O+jXBSss+y77bQdciL77IrFGHQilBx0ZV5kKoQujeRR0iOXjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxaTd2hU6frvpCjaKMX/TeFHP9yMKhQI8XcqRIcNPOs=;
 b=j9zdYQ9tjKeYD0OG1vUfjovaMDF4vKtQm4QwL8bxyaLTp/Q5KrcsqkjlouBMQnLG7OpaJ3P0xSY4ERHSnf/GdRUNnVzj3+uUCnGdTnIywXagBa8PJ46zqkIiYUUsiW3WGAg+TnUwXEJ9Y3+lJ/m1GpGNHKMVoZN0nCEFrq9e4twDAsfmvCnskwMj/HuG+IS656bIUTZF+782Lf7a3WyQy3avuPbF03rosvWkAQz7r/M9kMSIcf4o1w/jlNrVh1Nm9JsoIbQc0amRGiSpcUuR7KhleMPkLwP71pViIwlNcTytP48AVUXDNsdCNq4zvoc8oNY1QGuwNjYHzNaD4zPziA==
Received: from BY3PR10CA0018.namprd10.prod.outlook.com (2603:10b6:a03:255::23)
 by DS0PR12MB7927.namprd12.prod.outlook.com (2603:10b6:8:147::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 08:15:23 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::c) by BY3PR10CA0018.outlook.office365.com
 (2603:10b6:a03:255::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Tue,
 5 May 2026 08:15:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 08:15:22 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 01:15:08 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 01:15:08 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 5 May
 2026 01:15:04 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Zhao Liu
 <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH 10/14] vfio/migration: Add Error ** parameter to
 vfio_migration_init()
Date: Tue, 5 May 2026 11:14:19 +0300
Message-ID: <20260505081423.28326-11-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260505081423.28326-1-avihaih@nvidia.com>
References: <20260505081423.28326-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|DS0PR12MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: c089d67c-5990-4a94-725c-08deaa7e7458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|82310400026|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: esoItCTSbQpnlGJeeE6l8/avaC3q8Shfaimmp01DsKlZ7u9oQsOKRQD6G1KM7FMqbKBfdi0MKxHlCgXCM7J0CzknbKziliUsAZF6BhYu9p2Nz9wRIr6hqUVbNfZn0q497QTHuCC2rq1NJfhukaeWYdzxthKHxa+vSoEX5crXQWBlBSIH0qguhCFzmJW+KnhuiZy8b7eiRyaVngTJZYhOCeViR6FvTH1pt2J3ikntjqPKnH4ySalpp0aPZtfbJG5O9cwXFYdZa65coVWBb4et7M238eekYU916kUNfpmYRadKkbn97kcTZepPL5elDxTaaRbauGL2lf8zRlqBk2UJ0jpmydnTTWRKu5N6iewKpi77+JsssVsZWwd4ey4FMHVM3Ji+MQLT2NjKLtIGbka551aI56lBDPMiivQbouXi/uUB6JkRQ/Ar7ALcmsdKpEVBOMwfb7T7kDL8d4j4fuU+ROaFk69l2kwTCFhZtwNbl3g7Lf5Xaf3KnmXKaNplkcovSXSJAl7y7mq/x7JYev53JZn8LXNSkG6P5AhamBgWWcqDDeCZWfibOkR98/ULgagA2hbSfEgH40QY+OJbS9OeoyMUDp1jH82qwrIZCbJib71JWa36ZqLuCITWWZlZFoN3wJqtan5Xf26oPXgHdKO5VrGcT8bzu5Jtnnh+SNjHEHoHasV6Cg823HlZ5Hymzl8sZs2iq+QyHVs/3a9fKNyzBt2xPkVXkQQmLtDJfXmval8=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4pKAYk8pTFvNECpvAe5N1sR17Ey/pt3cVyMRZzlXyqI01JvsmidhoVClv3yCffszRvBBwhjzkzsEhQ5CWa8dg3SlByIWIx4/bffqLhSGFBKhW+TzPO4RSEhpmDqnG4ZSbePZBwOhvqgKGHpp6eSypePvficJ1Emunyw4KuuH+7WrDWlMVNALZmTTe1+p0nKiMtOhFwJfxLCV11Zul9UYnMHD+mWbINb27mo3x36h9+llu5uZTyZ2yUIy3mw+Bl7Iu5QsQksnBKeVJynthgxQoVcmlnMSRdbAVERvE/LnjpKTsFF5l4LpfoNWumdgcjtUf198Py49p6XQAsrn+3pS0MVdeAFrc2FuWO8a92W5R1XPyebTUyiCAYDKcq8Z8+aKuOeeCnKHN2VoPzjXi4DiTEZ80CJcD+V7GhgAaUEB1Wu2OQ/GSYrZUolCvC5P4RAV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 08:15:22.7444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c089d67c-5990-4a94-725c-08deaa7e7458
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7927
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=avihaih@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
 hw/vfio/migration.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 243624b5fe..b7e929274a 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -1038,7 +1038,7 @@ static bool vfio_dma_logging_supported(VFIODevice *vbasedev)
     return !ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
 }
 
-static int vfio_migration_init(VFIODevice *vbasedev)
+static int vfio_migration_init(VFIODevice *vbasedev, Error **errp)
 {
     int ret;
     Object *obj;
@@ -1047,23 +1047,38 @@ static int vfio_migration_init(VFIODevice *vbasedev)
     g_autofree char *path = NULL, *oid = NULL;
     uint64_t mig_flags = 0;
     VMChangeStateHandler *prepare_cb;
+    g_autofree char *error_prefix =
+        g_strdup_printf("%s: VFIO migration init failed:", vbasedev->name);
 
     if (!vbasedev->ops->vfio_get_object) {
+        error_setg(errp, "%s no vfio_get_object handler", error_prefix);
         return -EINVAL;
     }
 
     obj = vbasedev->ops->vfio_get_object(vbasedev);
     if (!obj) {
+        error_setg(errp, "%s failed to get object", error_prefix);
         return -EINVAL;
     }
 
     ret = vfio_migration_query_flags(vbasedev, &mig_flags);
     if (ret) {
+        if (ret == -ENOTTY) {
+            error_setg_errno(errp, -ret,
+                             "%s migration is not supported in kernel",
+                             error_prefix);
+        } else {
+            error_setg_errno(errp, -ret, "%s failed to query migration flags",
+                             error_prefix);
+        }
+
         return ret;
     }
 
     /* Basic migration functionality must be supported */
     if (!(mig_flags & VFIO_MIGRATION_STOP_COPY)) {
+        error_setg(errp, "%s VFIO_MIGRATION_STOP_COPY is not supported",
+                   error_prefix);
         return -EOPNOTSUPP;
     }
 
@@ -1261,18 +1276,8 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
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
         return !vfio_block_migration(vbasedev, err, errp);
     }
 
-- 
2.40.1


