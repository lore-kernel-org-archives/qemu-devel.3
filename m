Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDCACD6E57
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 09:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wULOz-0005rp-Eb; Tue, 02 Jun 2026 05:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wULOx-0005rE-Jz
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 05:27:11 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wULOw-00041M-6c
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 05:27:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ey90g4Y7Dtywwn2WkUHILQaQyGZwKdHG8WnAQDiBX2dI2lh2Mz6v7Dn7WLweJ86dzmHJAE0LEo/tHKdRSpdc0lHaL4LvEguT9LE6gxYEfT8zHs7jh9Wo2aQ8Eo/ytgabA9jMzrltFDxPEgxd+NRenvitI3BYWc33dy3JIoo6vMfnh6BewKDG9uYU0sRoTt8Wg2fhHvb4rL7JaAJ70Z7pzww8efJGeXbJhRBRxOPaqkZI7VOdGQiamc8zk0Im31JD3yv1TYtBmZ24xbCDKNXQwoDSIVhEbR2k4W57Dd21goY0usWWRsEmSqvC3YHapRZ0dBxzjWqSqa4OATocqfGaLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5n6UbtBQcN7ozLNDYIg22VzgNx59cINg2pmE/3tCVc=;
 b=Ym6jYONpJonQuqwssvW2/UNW2c1GhA9MOiOtFc8tR4uHa5cThcXHkxVEKuia7DuDRRkOOQNFkpyy/BqyxRMPeyhx58kTnlnvWrjObiMWBnhb3kb3X4dcsbKnnmZOu5US/9Ch4uJFLWTFoe/AN2YhFLGnZyx2EaDuTbfk254gtxbjK8gnRGamHSS41wos2WRK6O6c/YnR0uPF/KGacAnPPD/fNTDpXpa6NtWlEO8y4OeEPmrOcp1ciW6WMiwtZq/30sy5Ago38AqgxPxE9Pv30Q0MnYHA1RixPE801RSutLb2afUTBqhXvXcK4248Wg8a0ICbxfbSxXtK5YLoMfkRzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5n6UbtBQcN7ozLNDYIg22VzgNx59cINg2pmE/3tCVc=;
 b=LB/Q7wtzXIsab72kbrbizxmWgElBt4+OJn/MIByUh0laV51xpvHJeQJWXj6/vnXBzVMq2SY2Vedo5Kp9r5f1wsUufAJEHVGD7Fh7JjzUO4O8a2rm/XgG+9+beWkVgRE6K0EdErm9wwF6e5a/8Wyu6d6mPpqrqqTKqxGIbSXc+QlVHQNDKdmBMC2T2UjZr4ofYBjKSV7/R9GUybL6bH2v4VZtTn1gJFSJ/ER3fgqOWLcgtStKbifswFF4dS3YGBtMD4Huh//5G6LbYrBl8elAkbM9pdSLQvCLC3Ak0SUqqMmtVqk+8mqiR24XiYuy2fukpsWZLGjC8EnUksMJZlxJTQ==
Received: from SA0PR12CA0019.namprd12.prod.outlook.com (2603:10b6:806:6f::24)
 by CY8PR12MB8363.namprd12.prod.outlook.com (2603:10b6:930:7a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 09:27:04 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:6f:cafe::4f) by SA0PR12CA0019.outlook.office365.com
 (2603:10b6:806:6f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Tue, 2
 Jun 2026 09:27:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 09:27:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 02:26:48 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 02:26:47 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 2 Jun
 2026 02:26:42 -0700
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
Subject: [PATCH v2 03/13] migration: Log the approver in
 qemu_loadvm_approve_switchover()
Date: Tue, 2 Jun 2026 12:26:11 +0300
Message-ID: <20260602092621.382-4-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260602092621.382-1-avihaih@nvidia.com>
References: <20260602092621.382-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|CY8PR12MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: 308772cf-3db7-44a3-b963-08dec0891bf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|82310400026|1800799024|376014|36860700016|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: uUQy/YIdK1FdLUZNk3RPIiOFh+x+djjyJks4W7DJQIq3Bjz5I2OlYPjWHbYssZ9VMGbRUVQhOKA2AI/aPzsuJq/OqlVRUcyxa7cJiboJog/Zd+4/gO8qfr8kBuMCGD52t1qMjQEG9xY1t+O0yzsQeqyH8jvkPX/f9/luep8okHccP8HIeb8UCkj0+XN17LpczSIoelbY7GhnPiibcCMyxUtMONJsI9+rsSxpxBP1jFPBBr12EYFUs/OKdlM+/ZKf9Pr00qphtcRcHLfym+hm6WiBjoI4n7IVq1hJM1U5BdbGQnMGUkGGrAYpvbHxc2m7speWgVIpRrO28pISP3o8SGpG80aTc0PN/S72wH81kPK7fi0kKhD4LC5t58yWUcI4oNZXpRPM5EGMtEBk+aD6mrX25ucORLtQR8QOiRPbXzY+Ge4Y14FkoAbEriI492Puh2St+C9eNsUGx5cn6ncIdtMZMN47KweanzKDqLOOV1fiPprnXdLnI7QbH0wYnbiJ4LOPBv3KPx+vTZly4NbQvMf/U1ZQd5qYIZNE0FyRhDENG2oaR/FChhmw4b+07bDnO1AvGW8h2/eM0GVtxRiktZmk3w+rxQn/zGBMMRUZO5qeYnViQD6H5jtp7u5T5xKyuuKyidKbxsoFUxoZi2ODnr5eHPR27hBfzph1+J3JSnNo6r1eLWalnr9pzQ7HEwVStAH8DgaUtMRrLahb1veir6tCKDpXCf7PSWfCRDsGuCo=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OPrcmlR/Dy/u8LepCVIo3y4SDJnSTXKMZ4i4XGPrRYLf1ANC3oGaQsMsllMJhMYW+y3FdglRXC6KpM/A/HhrwyoGCyywkLv1SSgDIjag1mpA42KfjfkYffTV59uxkBnxNToR0U11LT+WeVGjfduWtDpfWaeHfYZVFHolsEOQpEIboZOQ3hWigZOjylRwuH+/Dvw0Y90BW8c5FxR5wCAZy5POnyhz8wsAHmKQbupWpHuctzLFsUChz4euMQZVFwmVXjCtByky18JPLNh5mp+sUW2KB5YUVcnOdeGxh8voMv/MGtign5scRwnWmaV9RM0VK4E5/GomuZWe2gV9npHssZew/5cRWpXgaPD2DpzV+OXLS00u18TT6H/ANsqFccYdw4BJvdR7QO1XPojE2CJuV25bSGyppWHE4SwtIaCgAtotinmHmnSHra8CtLvy6X69
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 09:27:04.3407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 308772cf-3db7-44a3-b963-08dec0891bf0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8363
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=avihaih@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
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

Pass the device name that approved switchover to
qemu_loadvm_approve_switchover() and log it in the trace for debugging
purposes.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/savevm.h     | 2 +-
 hw/vfio/migration.c    | 2 +-
 migration/savevm.c     | 4 ++--
 migration/trace-events | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/savevm.h b/migration/savevm.h
index 10b3d78a5f..0d732eb0f7 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -71,7 +71,7 @@ void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
                            Error **errp);
 int qemu_load_device_state(QEMUFile *f, Error **errp);
-int qemu_loadvm_approve_switchover(void);
+int qemu_loadvm_approve_switchover(const char *approver);
 int qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp);
 int qemu_savevm_state_non_iterable_early(QEMUFile *f,
                                          JSONWriter *vmdesc,
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 95072d6664..49266cbd76 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -846,7 +846,7 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
                 return -EINVAL;
             }
 
-            ret = qemu_loadvm_approve_switchover();
+            ret = qemu_loadvm_approve_switchover(vbasedev->name);
             if (ret) {
                 error_report(
                     "%s: qemu_loadvm_approve_switchover failed, err=%d (%s)",
diff --git a/migration/savevm.c b/migration/savevm.c
index 22cb6a15c6..fd870345b4 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3172,7 +3172,7 @@ int qemu_load_device_state(QEMUFile *f, Error **errp)
     return 0;
 }
 
-int qemu_loadvm_approve_switchover(void)
+int qemu_loadvm_approve_switchover(const char *approver)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
 
@@ -3181,7 +3181,7 @@ int qemu_loadvm_approve_switchover(void)
     }
 
     mis->switchover_ack_pending_num--;
-    trace_loadvm_approve_switchover(mis->switchover_ack_pending_num);
+    trace_loadvm_approve_switchover(approver, mis->switchover_ack_pending_num);
 
     if (mis->switchover_ack_pending_num) {
         return 0;
diff --git a/migration/trace-events b/migration/trace-events
index 1c9212d3e2..c0c433744c 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -24,7 +24,7 @@ loadvm_postcopy_ram_handle_discard_end(void) ""
 loadvm_postcopy_ram_handle_discard_header(const char *ramid, uint16_t len) "%s: %ud"
 loadvm_process_command(const char *s, uint16_t len) "com=%s len=%d"
 loadvm_process_command_ping(uint32_t val) "0x%x"
-loadvm_approve_switchover(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
+loadvm_approve_switchover(const char *approver, unsigned int switchover_ack_pending_num) "Approver %s, switchover_ack_pending_num %u"
 postcopy_ram_listen_thread_exit(void) ""
 postcopy_ram_listen_thread_start(void) ""
 qemu_savevm_send_postcopy_advise(void) ""
-- 
2.40.1


