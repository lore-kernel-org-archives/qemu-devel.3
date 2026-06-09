Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA50CD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWrQA-0007Lq-56; Tue, 09 Jun 2026 04:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wWrQ8-0007L5-80
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:02:48 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wWrQ6-000683-OH
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:02:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MRBP2uI3G+esDbN3YDkuJMw+AaN8jGGmPZ8JWIXqlAp948XuXkHTiHI1oeAea8coSFLzjh/4DOh2SVloZT/HQxQ4hwptOn6FBRrUhSfFGfLCcOE6o7eqmJaYVN0gIqgA21EARgwoEDRgakjwrAMbauO5ZL6wdpBFTHmoz1rIYZsLt5g03wKQWwzZlilNr1AB13285nMMJ2BHtovjB370ONmRDu9xHpEanLLWTb3tZDRU3Tp+8/TCNbOvb5BoXcPIDB0eUbgUL96v3OkC/5WCZf1wHZZfnfROhp3mBIDLiNRMWRsLiXmRMVd2enmUkHuqWaoDtuwlB26WSbYjwOsEQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwipct43yTA/LXG4qb+DS18tbfvDcpVvyVNySaLkcnc=;
 b=J4V2MetUkzIBYDSXHzI52aOUI9BMA5W+Kcj8r4+iN2EtU92cSU9caykorIX00kPuDsYFBXIhmiT+ul2xXM5rJmFRYdC7PJqSS8khWkopttgRb8u4c5Nt067YuH1DaalKQuh5m9AfBsjkw3WWUomuMTMrrTgtmx3bhdxZgfqLGufqgP68adDgHB9FOtupBxXA7fmYJOt2Z5kzwdxa4WoDuANW4rXIeltSuVEBG1KSv+ZCSaypR1SAO5NHnhPPSWRBPWIQU17xoiIjgU+F0siCslD5ZBNdHLcogefGGCQABBUNV6Ft0YMR7n5/jV4uFB5FWTdbOQ1/6a3PunAJfqOAXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwipct43yTA/LXG4qb+DS18tbfvDcpVvyVNySaLkcnc=;
 b=STBvSIPqmrmVpy6la9O7nOqdHMnK1yK63/nfRgiZvskHG7R6xwkuM8BXiQkGsQKopxmFqF7HZdS9ExFKcleHFxKxiJIVIYAQHi6tc8/9msEeDVuenN81v29KXpukBXj4RPs35zyNSKf6MHwq2TpH/w5y5U5vwcclaJq/EkKGvLQWmi16gbrtqlX84cz+gKX0BTo0iogaEuxltA9/zYT+2PgSfQvA4lQTutJ96JmiJaAvuurHZArkh/WpKUECVx40vrOYsnioVPZnBMdBk9Rz3E3+jRCAV/tpcaW40Ndgeam9YyX6vZeLg0GYmzkcWmdvRYsdor/SX0nlXdkLDMa9HQ==
Received: from MW4P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::30)
 by DM4PR12MB8571.namprd12.prod.outlook.com (2603:10b6:8:187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 08:00:57 +0000
Received: from CO1PEPF00012E65.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::15) by MW4P221CA0025.outlook.office365.com
 (2603:10b6:303:8b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 08:00:55 +0000
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
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 08:00:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 01:00:34 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 01:00:33 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 9 Jun
 2026 01:00:27 -0700
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
Subject: [PATCH v3 09/14] vfio/migration: Extract
 VFIO_MIG_FLAG_DEV_INIT_DATA_SENT sending to helper
Date: Tue, 9 Jun 2026 10:58:07 +0300
Message-ID: <20260609075812.32067-10-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260609075812.32067-1-avihaih@nvidia.com>
References: <20260609075812.32067-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E65:EE_|DM4PR12MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: 83c93739-45c2-4c29-8e9c-08dec5fd3c01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: NSuTkZB1UW4ne0Lj8vZV4APUPhfRA8lN3JTU6grt0MZf2H8sfFB+kkQRWimA+zPXOZWduacsF6mzmVyolhXWzKmL6oLVLvKyJFZTFQcdQ4emXosZYqHhkLoSWOndnNMuQKCceDzAxwzAwISwICDnj47fUslqBmGQN5qmJApVaApMywEb5K/asjYblmZWnuCKgkqiDPHFk5wrMtpu1OYCkD7zxrwtwDQpZAwC0MHjYWU9kgFOFfr25DF47Z7/FDrNHfv1DEiJClKuYghBgo7L9IqoNhzL9T+frejfnHDXosbOdqNksujpyKFzx+zzrOnhQk36B2rRPU0JapdCqLnFHimPJhPjPjYAuM9zpE4+Sj37k22CHUGyos9+48Y0zSM4xuPzEcCHgD26YnYDLsobT41kNfHetBnhDgLYak1iqYdZKE4Wz5jRdYkwmwfjN2oM5wsN8mEiAFhevSmiC405uxE7qdIM1Mq6df5tsas7zAta2OM58AFZNYsTPsoTOJOUUgVVStrECS0UHVL2jYykI6woSKuiavEzU3bHz6g/MS771AAHGManAXLTZi3U2e0PqlFpiERzCtVhTIneH2i/qcxiMkMuXy6x/dCfzzbIfDPXd6H6np2L2rtl//4aFR3l4wlsFPBvtgAGoWP6npsrHtN7bGXaguTOAkY5ZK5/4ylP+7njyg6qrps7LCAVR5Fg7wg9BxzyFX2OBJtrXh8FRrnDu/6qJLWiS6YyW6L3QHk=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4nCln7/KhJLCJ3KhKD8Apsy3SKrcm4Yp5HsALDMAj5HSifRNy492V2Iaf5LkYQ3lZuUkxVbVrFtugEJGrxdnSanDERhq5CKU4U5l9kzzstZ0s2KY3lNGLqVOpGZJnPdOmyZJtIEKsRur0CU5xMepzTlakuNK4EOwk+174HGUHArC7k1vs8yI5ZL6iE2K3MdkrzoK3e6ZHayY5ir76kOK5utfERcdWvLwbZ9IYOYkwoxo53qZRCu3ABYCYFmCV0sGlvLXrSkGV8UrprYk44lIurPpgORjhTAJWFgpktDpmyTWpi+VWFEMCjrBDNbe75HIXODyfsdlIa0WhK+O87gs4IVdyxXpNMBmFkXVNzl9Q9RqjQofo2kHBJ6ErgMcebYhbuHkPxm5gsRm6udu/KNhY0TbqalqfR6nOVDlJKlDLbR9CigUhkr/TwVq1/Pu1Bz/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 08:00:55.6392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c93739-45c2-4c29-8e9c-08dec5fd3c01
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E65.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8571
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=avihaih@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
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
index 8f57d0b7d8..411a306635 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -176,6 +176,7 @@ vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy
 vfio_save_iterate_start(const char *name) " (%s)"
 vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer size %"PRIu64
 vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size, bool exact, bool final) " (%s) stopcopy size %"PRIu64", precopy initial size %"PRIu64", precopy dirty size %"PRIu64", exact %d, final %d"
+vfio_send_init_data_flag(const char *name) " (%s)"
 vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
 vfio_vmstate_change_prepare(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
 
-- 
2.40.1


