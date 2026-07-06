Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA38BC44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgf6i-0002eJ-6c; Mon, 06 Jul 2026 04:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wgf6Q-0001a0-AO
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:55:01 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wgf6O-0007C5-Pn
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:54:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khSrOeeQO8T32Pny78YBAYbSKgFedpvXtD4rEXqVjprPVURt9K5fdpV27Hyx6aI5CuNM49jza/PT+zTG121PIev1E9swxLn/Yjl9osHGThqgdHouZVTgxm5wJi30EIZ0w5rAvzRI77MyeXgUKZt6T/cMxixyabyGBIbR4oE9GD3BzwDsybfgT6FJ4C4hpEgGRzMk5r3sf5kksYIzSxQB55ksVAVPsh5uSDncskNOF5+HlouQfiw31QDvN0BTNGWYIRnkU195tS9pK8e4YQ6F7uQv+m3JANpIyO1W4bhUsRbsYG89GMVAWkjJSHwI6HB0Kdhogsc1OQqWUHKGciB4Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47YHRUF//ZrkahKfwOAepPStuYLt1RbPvqkD10sW/vY=;
 b=ukBPBDnyN2JGSJIH/loCO1Hqbk4oPiiLgGar24uWxv15wYw4CNYNhCEQ3os/BTyThu7eKoP1KN+MqYLOLvgIcNPcfagUSh8aBMEHaKzU6+k4r569r0G0svmR4SsEe/gYdV0DFgk+MOg8W1viqY4TS9phRUI3O8Em6hpSoRhOHlRFJteXNoAcnM1To/1Qr4WmvT0tv0t30YwXOLBEFmzunvHu1AWt6L5ozXhmnui79yUhx7SkedvVZvlXEVBptVae3CpRFP2JejJl6WTvpWxJCZ51g9B+Q9pDY9vL33SfnTa6yJXLfbT7hUg8+eXILLC5YDTDlq4GHDRDlQmZdVHRQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47YHRUF//ZrkahKfwOAepPStuYLt1RbPvqkD10sW/vY=;
 b=QT2EZTQiMTq4e2oOPkBQkb8BG+ArO/gSLIv+tRifwFi6wprEHcK0rgQ12HPS557qKLAVT8SR8/JK0ZynfxWvqYYRxSSvdqmfR/qjmDVka53AOEm7FoTz/GNn2FvkeqZHUQPMmxJq7f83Evi6362ru4siF2BlS1b/ZwTTnMCrwYtFzcvVIS7iqa5aUjkbj+HP6ltDrSRpcRT4+KgWe4toMAglu7jzEqKY5jI5JohFh3Q0G87Ld8hFUPz2WmGMDAgiu83tej/+Aj7s+me8yHJ26ZMkK2vynEHKjOSOerK+PKESklpv6i8ve5P5/9hiY4FnTkvDyc/n8frF3Jk9KbA1rw==
Received: from DS1P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:44c::11) by
 CY8PR12MB7756.namprd12.prod.outlook.com (2603:10b6:930:85::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Mon, 6 Jul 2026 08:54:51 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:8:44c:cafe::4e) by DS1P220CA0025.outlook.office365.com
 (2603:10b6:8:44c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 08:54:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 08:54:51 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 01:54:37 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 01:54:37 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 6 Jul
 2026 01:54:31 -0700
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
 <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Lukas Straub
 <lukasstraub2@web.de>, Maor Gottlieb <maorg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH v5 10/16] vfio/migration: Add Error ** parameter to
 vfio_migration_init()
Date: Mon, 6 Jul 2026 11:52:05 +0300
Message-ID: <20260706085211.13905-11-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260706085211.13905-1-avihaih@nvidia.com>
References: <20260706085211.13905-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|CY8PR12MB7756:EE_
X-MS-Office365-Filtering-Correlation-Id: b648e7cc-6fbc-448d-8f56-08dedb3c3db0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|7416014|82310400026|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 2oYWT+toRyg31cEXYr1+ATPCydS2tGK3MPQEnOhVdlSHR0D3bvL49/KOaHxT9lfLbi54ZYP37wGkVhNIOaebnEDAj3w58eCr0tXiWY9EqlHHTtvhoD6mAN8L3uCJhCUdfVyDEV8/02YopzDkv71J4C1AdwYmhh1Jo8pTM4s2oOBcAakXOqBGH334INEdnpyhB70zQb2DavVgPbVBglgWmIImtyowWAVvFQBdQ7YwxepfIE6DT0YrfPvfWaxwMke63Wr93EYBKst7oudIqbLJPy7t6A64IIQqvE+W1tcLCc67HZZ7ZWbCOhIjjHSOqLoHtSAKpI1qicoUAXSV9IyjeHCtHd6Xqsp4YHSlRm5jsRDZluK2R9YKns/VV8JUqHfbefH7NDRMWb9uHJkXIMXpbOBtWb/2n+YM9h4Ee7VDGn334fbm409pMxFuwXYTFcBRbTUPr4mze9eNNnyBv+hjxfjbPcg0GtijgEqtHmf53Ev9rQwVYOxxzo+D1rtlm260AayhV4X6yu81+7/SHC8S/hWl7JH01Yae0XdFg+gOE71wH8JhSQ/jq0L1jhrf9OwmItmOtZgbL13kXwF1OHzrgap1+Sevsao05YADKVeWVTEI/2CnWsMjR+OMluAFd6duNlMmi+mMn6IRvx5u6v8F7EqZfCMUDdhXkrSfqqOqnmv8euKkNmLN+C+pqJ99RvWf
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(7416014)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ymG0K8NngGflx+fOf9y7Mzy3I0DrYHF5zds0wTPjyl0Xej45aY3tZV2rwIBZ0ZNbDq++5WzqtlVuiOT3mTyW3+JRxSFfxo2TWu1N+C1n8mlYJlbAMiA5EVoJsMmlT+MMePY9thGZVV+DCFydZblMqoJhaOOZ6pC2SqrE1/WoN0AYQ7L/nls+ZHk1bl/gYg+/GtB2og3a6+AOfin9Zb0iZLueXn15Ljz1n1OP/tRqvMYqE/te2Q36WOnlfwL23hnw5+PVFnZk5GBs/LhXM3/Xp4tPhfi1A6dDrCso43337Rxrm7x6Vs3mpZL0mFQSNG1QfG0O0ddqJQoKyL4YI7oqHFsx1fInwGEgjaU4UVz9P4I8TmetoxQ2afLAx7df/OkEf92utviC2iYmmlElO2J36E1ElWsygA0sXQuZ24ohS8Xe++2196Lc77uxncap5lBp
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 08:54:51.1186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b648e7cc-6fbc-448d-8f56-08dedb3c3db0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7756
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=avihaih@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
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


