Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C02CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 10:15:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbbgb-0006Dl-Os; Mon, 22 Jun 2026 06:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wbbgG-0005vB-F4
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 06:15:04 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wbbgE-0006cr-KO
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 06:15:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0Wg3KfI/DBBboPC4cZ4Xij1xryanv92DkOGCkPV1zFR5lqedHaW0QpWcpqnEQenS+kfMCs5sy6yApm/b1xEI7jWbAOSzfRCq9fHbcTw2PPyWWL95kkv+rv8TdCfqQbIuzV55IVqdY6RGuX8dZt7PSBzBwSGdqs3LtQS4QR4/ij22Y6rMAmAYKTGQ8eHfYqlQHeCK+7DVNHi9a41ldmdmaKD8xbzEi8+oRnProVU4lpQp1O1l1hEjurt3arEuwUZnjt3pA8FKCFMafTcc715K3eo0xYHqqsf+HZ6aKJuGkAJU5rFOLS04spIL3wZGAGibPnW40eMow7lIw4klwC8eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqY9k4BSmOqLF52EfgXnt+HIYcLMRZC7le3cgtLmBT0=;
 b=LruzYgKlgoSoowINzS22hB1T8Kik0bR72z/rWh5HGAT6jQ1S3eNGQfrXUImv/st7aXljUjmNz/28Tn9oUoh2HmP8139HTsBiOJlhI9/b4Vm/ZQM4jJ0JfwDvAn5+4/ir+KvwI+BDDpku1Y0m8koe/cG9yS9jOpGz7j7SnqJY0aEyK5CS7X8doa6CCzYTDkc1VAFN0C98IiPd0zXVkxamBeZ1GjpT5smX2kZKUMFdrJkPC+NWs/Vy88abEEBfk374kd3DFIs3MAYymc7H0V37DZ8r/BRseHAMAzaiMEMTpYpjslBsFn9/bcZHiLecp+9KKkj/lobZJO4okjDeUKgtOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqY9k4BSmOqLF52EfgXnt+HIYcLMRZC7le3cgtLmBT0=;
 b=eXQAnLEIl/SlP8Xi9JkdHwoRfcdxFvvK8efS1YnqPKdgOw/kXx2YbHLxGZSbkbXv/Z5oTqlugRFLS6HU1+IhHdj8q+ywuHedF1+vkELmUGXBrBxr4WBjRcXQtAToN4ohQwIX26OoutXHkwUXtijlEvuBQ6M0yi2mo8r0Q9DMFai9j+RsIacfNePztgZHTm+0y6zWXJ2WuA9wZpdl5ndTwArpOeVA3KVwgxRuC4nWjiJmrn/7aAzTUIBdsEziDExBm47G2RzQZgcGzgWSlsSTbiKLSc9ltxNd4bGXW7h68VI118yup/dR8KP7eD0IWfPjp+2JSzuaTYbIuAAf5gNWRQ==
Received: from DS7P220CA0110.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25d::12) by
 SJ2PR12MB9239.namprd12.prod.outlook.com (2603:10b6:a03:55e::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.11; Mon, 22 Jun 2026 10:14:53 +0000
Received: from DM2PEPF00003FC9.namprd04.prod.outlook.com
 (2603:10b6:8:25d:cafe::c) by DS7P220CA0110.outlook.office365.com
 (2603:10b6:8:25d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 10:14:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM2PEPF00003FC9.mail.protection.outlook.com (10.167.23.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 10:14:53 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 03:14:40 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 03:14:38 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 22
 Jun 2026 03:14:33 -0700
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
Subject: [PATCH v4 09/14] vfio/migration: Extract
 VFIO_MIG_FLAG_DEV_INIT_DATA_SENT sending to helper
Date: Mon, 22 Jun 2026 13:12:09 +0300
Message-ID: <20260622101214.25770-10-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260622101214.25770-1-avihaih@nvidia.com>
References: <20260622101214.25770-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC9:EE_|SJ2PR12MB9239:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f481c01-72b2-4f76-9455-08ded0471a0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|7416014|1800799024|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZTSuRzn3Etu3NMKzPdLL9f0P1F9dBBDwQEVMz2qkJZjl/HkafnDiGf6EFQpGvxMk2YPnSeJO85/0iQRn25O9GfiNHmms0bUlfMwqlsNElb/7bk2YC6xtOjC2Lov4zJ//jP50bpdQKDx43AIdMHJJmxJUzcBOuKlXpO6Ef+PRwcNbioY1Qu6i5Gax2BugskRrQFwVaEXIa4SBp5tB74qUGf1S4YMdwSQtQ42O//bAz2TcGuA1G/EQvztWVudQBOONBMzevE606Cpt4cM+Ix1yIc6/rxDsgMP/izFR/Q7p/QtOghfW8Dr5Z/ozkjAoOcpkTqELedOBtXdreTZxOwM/1Wzafwx4a9KDZxnhu00X7rDzG5inF0F4IBOTaKUxta1z6wvS4zsqI2mvAkGs00UMclKfot13cJclL+wIiI2XXSngvi/swK9r043+UDkT7Suy/3OQjh+CCAQxeHNunntBoVNofkteN1OEpExXslm1J+ImWqnxOBGq2QC4JEPa1zJWofpuJ3wGXFcr4CwyM7Q3e2AbVZYyTI8eQtNRuWEx3DMK5phuGzp1RVJiB1/fY69QO3hDKjMm4SXE6MNEQcd4TTU9gLAGYi/y60T6Gw/W6BXNya7Ec2BXskSz2W4rdvY5FgQurWyGA7/A1ak7j8a9DjXSSYMgiKDmT4n7pXK01Z4ZrIlq48h5pTaiZl3yOk805LWYD8BGTO/LzzMH1y+QOg==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(7416014)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 88/wJ829mVjw6l/FjM65UnYLIQaAkM492wEPI8ohOCpLdXUn39xIDhqr4onBNwq38Ewn+12T1P0y2L+veFOJfmIM/f8lXsc6MuIGwCF8GBdsFxh7FQYnDVDR7DEaigSNzUJWnP7MxZOJt+iJqwlL++GLSzT2+TO3cKkR/16OU3Od0asrUAQgAnaDCR3R+AlVXNxYGU1R/FDD9N7svS42KkBhJCznC4oJYUBnoYoEcY2fc345rizmlLAKLyMc9KnTGnStfKOqyw0Mad8jo+uQMEG6CCOuVjuhlUIrIgQ/HNv6K3ehVs+srA4FeK7NSt4MpL+3k2RiPhyRP9w/WtJ2pplg8EghTVaViiy1HpOucYlKQil9p1KgpQkw5tqvjMr3u2NfpxLDvASILAOy9CuaCmCmucVbSOEDdld5nSau7GeYSp32pWbkA9wMbDu51MFz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 10:14:53.0170 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f481c01-72b2-4f76-9455-08ded0471a0e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9239
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=avihaih@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Extract the VFIO_MIG_FLAG_DEV_INIT_DATA_SENT flag sending logic from
vfio_save_iterate() into vfio_send_init_data_flag() for clarity. Also
add a trace while at it.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 hw/vfio/migration.c  | 26 +++++++++++++++++++++-----
 hw/vfio/trace-events |  1 +
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 6b7acb2fa1..45f8e346b4 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -480,6 +480,26 @@ static void vfio_update_estimated_pending_data(VFIOMigration *migration,
                                          data_size);
 }
 
+/* Returns true if the init data flag was sent, false otherwise */
+static bool vfio_send_init_data_flag(QEMUFile *f, VFIOMigration *migration)
+{
+    VFIODevice *vbasedev = migration->vbasedev;
+
+    if (!migrate_switchover_ack()) {
+        return false;
+    }
+
+    if (migration->precopy_init_size || migration->initial_data_sent) {
+        return false;
+    }
+
+    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_INIT_DATA_SENT);
+    migration->initial_data_sent = true;
+    trace_vfio_send_init_data_flag(vbasedev->name);
+
+    return true;
+}
+
 static bool vfio_precopy_supported(VFIODevice *vbasedev)
 {
     VFIOMigration *migration = vbasedev->migration;
@@ -693,11 +713,7 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
 
     vfio_update_estimated_pending_data(migration, data_size);
 
-    if (migrate_switchover_ack() && !migration->precopy_init_size &&
-        !migration->initial_data_sent) {
-        qemu_put_be64(f, VFIO_MIG_FLAG_DEV_INIT_DATA_SENT);
-        migration->initial_data_sent = true;
-    } else {
+    if (!vfio_send_init_data_flag(f, migration)) {
         qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
     }
 
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index fa2204f002..fe0d2cc06f 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -177,6 +177,7 @@ vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy
 vfio_save_iterate_start(const char *name) " (%s)"
 vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer size %"PRIu64
 vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size, bool exact, bool final) " (%s) stopcopy size %"PRIu64", precopy initial size %"PRIu64", precopy dirty size %"PRIu64", exact %d, final %d"
+vfio_send_init_data_flag(const char *name) " (%s)"
 vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
 vfio_vmstate_change_prepare(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
 
-- 
2.40.1


