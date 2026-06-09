Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA73ECD8C85
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:01:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWrOq-0005X2-30; Tue, 09 Jun 2026 04:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wWrOh-0005Un-DQ
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:01:23 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wWrOf-0004oo-Pa
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:01:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5l4J8HnLwbJJDHDojKujgqAntvFzoMRaoQJM1lsWuYHB2hMwRk7Fb8/qjUu0oWZEW4K8DN7zFPVoa68Y8Oj/sdMtcmbrh0J61OlYLXsiZ36/P6miPBlotj8cR+WkSY5e2NqeXWSxYlIevAUhI7Z6oXUwSxHWQ87u38akq435fQo1f2Lx2MUn1EkUcCTqXpiPWWHjrqlMDH7h9Rn7qNBFHvxUehom/HwV4gpURZTPh5WEe9xK64cDKQFOhd3MMiPtTPxi6hz74aCqijK+V06Nm+yzEIsKQL3BbK5TH/DQ75+7b20D4zsIn3BpCj+3WdcLtqgTJWLhGqPG8RAPnjAYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Faq4RI6ryoWvOUzJOiuhZ+iNbWjhLG95XX4p9ymduyk=;
 b=wbjbBOq7Q0DPDaqNvwtv9GCNTv0Gi+lQUoIyyz1JL74lrH3u0zwjN61yCzT8pwk5UkBXiQRDBBVJxJmuPJ5+HpJWbQ/2EnXOUdImi4zM7UMf0GFJLai2rYAlsh4+HmkI2Mk+NhHD+wfVi6r8k+2VtZV8rP+bw4yG6fF+CsFIUV0ySRaAk1t2YqWyG4Ws2buvxo7XFmGv9H12ttzOYs/hVskg4bFVX5h4sP/HebxItOzvP+zfHCdoGTlWForHya9YsusjQgwZM/Y5m57rtHzJn+z7KUHmKIcRxz6XFKZ5KL70VtDcMhUjoqQN+VaeuyiW9ZwtZG9IXr5RrSLLhgyebg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Faq4RI6ryoWvOUzJOiuhZ+iNbWjhLG95XX4p9ymduyk=;
 b=NjlR7UWzlDxEVnzFtlE6grDhUwimOwbyWPw1M6A8teFj+gSoRVGfIsJCHoLSbLOK5Toi1pGebpsMLk1H8C5gtK11AyqqeDKkBxbCEqOE3uDapIYw/EZqzAY5cazmzzkxgTs1Z/n1KBDZKSjdyAZ8Wui2yDJQcMyTvxO+FEMHzkqkrY+yIIStrfYGn2lF9mPk5uS7rjMziMDcqnqqE2NQEeGK8CGAoKck+Z6YaiDl5xQTga2wy5dcZU0e7PArPmPF2H0xJ/dwSroF4EpLPzIVM+Wfl791tQxzwKBi0IvGW5B2+sGQhuzvpw9mCA9a+sPEu1qPhG9PX/P4Fav18WxJLQ==
Received: from BY1P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::6)
 by SA3PR12MB7997.namprd12.prod.outlook.com (2603:10b6:806:307::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 08:01:07 +0000
Received: from CO1PEPF00012E62.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::a5) by BY1P220CA0017.outlook.office365.com
 (2603:10b6:a03:5c3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 08:01:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00012E62.mail.protection.outlook.com (10.167.249.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 08:01:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 01:00:46 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 01:00:46 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 9 Jun
 2026 01:00:40 -0700
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
Subject: [PATCH v3 10/14] vfio/migration: Add Error ** parameter to
 vfio_migration_init()
Date: Tue, 9 Jun 2026 10:58:08 +0300
Message-ID: <20260609075812.32067-11-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260609075812.32067-1-avihaih@nvidia.com>
References: <20260609075812.32067-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E62:EE_|SA3PR12MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 54230a35-cd5e-4172-1b2d-08dec5fd4306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|7416014|376014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: YIvYFzkafLSGpEgRF2/3L3NJ43EidyxNWQljByncuz7IxmFx/AawTmllQY19UDmZO50AR99RGwGXHqwgcTGpAIMe6OW8Z45vmQvPoccfdPu1tQaaAlvE58e6zd2hu+hMGvKeJAfcH/u9MCHN9tE1RzFo1FE58gmx+iKMy9m5xKBpkDJ6AmxRhvWcS6erOzEuR0sgMW0WaCI12pWKcLjdTqcrwOyWrP9opGg3hLtup0mj9q6ZJfJ8pBQFSfylkRm9Yn/EWdE/Ys85mZdO67NS1y34R9Sqmr0atwwv9fE/c205gLH0j/DzNLc0JeUuHe2MH8g2309Oy/g4awfnGzz1b4siVuMNconiuGnefKcnm8AmwyY4gsI+kniDgUSnX8Vm+sCsxMF1+1CZ6lsz6pbcjPQSsuO/loa2Qjhl6nuILgAzvNy0XUzBK76z64xUhjsp4T2+yUwnIvzTnPaZV1BM6igQla5x8qWqxWdZaKWCNoIJLMN4boG86V4MYBrOZMkUOiZrNvH05yFMKDurjZz0Sz7Nty+sezy1BRrX+rC01Ep4Kx6GEIS6Y3S5vRxWzXw+TeNJ0zGaVvN2eGOoiU2q7XOPK1a71kpaejU3oYMP+GRhba8Mvo7gRDo4RYw+aj289BpMjL/+YNG1y0JvNRo7leE9CMhzX1bZokiBvEMG9DMSDqczSHIdCiD9Nth1rcOnszoXQKExTuGdDpaCEBAAUc1cV776PDfFe32Y3fXFfIk=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(7416014)(376014)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7UpXcOHSHLRrwJnX1EivM5xw75RVGr9p2Nmv7ojFG2zQ0225iB68Q6V0jF3xtB8DnFIjpSrhbxN++8Cd4Renz+ZjKf++Xlhy3JvpYVo58p+MzspLwi3y/H7qgFi6rLPobto4/a5BGlf+d87S7ho7F9UvzK9Osr47XHFvfhiUYbj/ZiGoeF6qXTkpEXL1vL7GN9W2OdODhJ3k6vqyyr0n7/teT8CIAxkJOyIdjetzUUSYtIONtld7n5MggY2Mh7n3qRMeuX7Lu6jtonX9xR1ifRfaYFGbpUCL5in1Nq3fvWjoCBTIY7tGJlp0hmNJSBRQ11oT+CDfTOL9zQ3yBC+KYh3ZdP0R1mrst9xU4xxeIJKil0emR4A50Pf7G7c3yJ+szxuSRHSqWEZ00jJh4l4tb9vslJ3FtstcdKoFzK2nOtKkrK9G6ClWmNEmXNa07Zl6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 08:01:07.3964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54230a35-cd5e-4172-1b2d-08dec5fd4306
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E62.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7997
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


