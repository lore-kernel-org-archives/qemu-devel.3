Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8CAFF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 08:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKAvy-0001Lb-Rf; Tue, 05 May 2026 04:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wKAvu-0001HW-8Z
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:15:12 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wKAvs-0006Uk-JT
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:15:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IcHs4z22xs4M0MpIKaGVCCZIW5RB9xmguk4idtoSDYVdm1fHc/w8q6SgB8RmOtmtrX2ugBM3DkU37ckOX4DGRtTlYH+fNX4nKImLeYUzkVQGnVh9tRWrSe3XkobuKYN+zuxYelKD3GxKod7wL2r7JL2QBkBMnBhrK1CfdgL61Hj5ssi6CJP8n3Xzp9thOMt/Z46vbXUFluzw/GvAB8FlmdXaEeyxU0Y1uoycoFyPdp74+ZP1Ultdmh5G1x94G2ibYCqMt8jNi5aF5BQU3c0Yqzh9Aly+9CLnrbkTHoOY/9r5MNgRc4ZzROaR/yKzCMTEDk0JJQqpOxXEuQ0UFyToWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/Wubmllej8nHTLIDvPFPClz1dgBjqX64mdciksiDlA=;
 b=b/zSj60mVKgaVyN/MPoeH6KUtaac83FyBwjX9H/BKPw2/Dt8wB+nwvJTRKygx3byYuXxiuR5Xpi0VXrXC1xyAiefrw7+rvRJvtdVuFgwGmm2G0RdaZgp2Bvbdk/NWFKpP8VDXqxaBlhar4rzXie0X6Ea31j0m63g1/clWzk7eSWc/V6iYB5jfGeqkO9z1Bxl+Xf2oH5aCC95soussGu64kf9au/Y9Di8aR6PjwA1ZCoukJM03qcwqtyuePaD0bednhWsxasww9yMIWG/Isw4lhGNfh1rZSyt41iGvrRfGxoM30H78VsSJI6vBPluvTEpteFrwWjr6ojXmOIO8Jrzaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/Wubmllej8nHTLIDvPFPClz1dgBjqX64mdciksiDlA=;
 b=bWF8fB5Z/ZTqYD+IOZU5zwtFFlIR8vjXcSYKg/AXGJGc4aY0rsRWAMlf/Zl3vIP/9rBBQnAziaIKvxygF4H2GHDzewXUh7gmorg44k44mAxwgqrw+zzTg9pQw6rPgP1uVjI1tcGHvf9DxsKzQeDuCrcSdG3y4zMWad7ajQrs8Wmpn4izxTdx5UDR/2RMWckrR1k2cWwK+RSMWarSd0Wk3W1CVIkcrVga7wWx8cFKosgHX7luM7qjqwtBhVbMoR+FccbIm19E7xyzb0gihfuq2VvdIKU8ZAHflP3AyLnAGpVEItnWT2R2ldn8lKZ3n2D21qDEIbYyKq7GtkB7vgpWeQ==
Received: from SJ0PR03CA0164.namprd03.prod.outlook.com (2603:10b6:a03:338::19)
 by DM6PR12MB4185.namprd12.prod.outlook.com (2603:10b6:5:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 08:15:00 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::f7) by SJ0PR03CA0164.outlook.office365.com
 (2603:10b6:a03:338::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.22 via Frontend Transport; Tue,
 5 May 2026 08:15:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 08:14:58 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 01:14:44 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 01:14:44 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 5 May
 2026 01:14:40 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Zhao Liu
 <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH 04/14] migration: Log the approver in
 qemu_loadvm_approve_switchover()
Date: Tue, 5 May 2026 11:14:13 +0300
Message-ID: <20260505081423.28326-5-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260505081423.28326-1-avihaih@nvidia.com>
References: <20260505081423.28326-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|DM6PR12MB4185:EE_
X-MS-Office365-Filtering-Correlation-Id: 13cb3fa1-1b86-4fd5-4918-08deaa7e662f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wMpfWRAPg/UaT3IaRSBFkEUz/EjXwWdXXtSxpeHrRCXZu7H6YJupm6Lt/WHiGs5SRr8304Pa1Qixdmn3Y5rysMldJ57p20cQU2kvhUb0d4rasY1rfp73lHTNIg/GagXF11I/guybM6wHKmCbqmhgq5MwLsXt8pc7oOlWZaR+K44miCINBzv+/+/v3lpmHF5wjOIF4V6v1GG0yJ2ZWFcsYXUAeMQFxPTO4+98iEbd8mZcJG7M7FsirCWTbUsazTjDDB6IHoJOmuklus+/s4YG8IjL7Mty4O7/JJwGmXhq/cLkryjRb6+h1GYbav0m9UEur8tmvqEG8veBXHs3fqoWN0m0wGDZXbjy/QiztR1gH89EfGvM888r+Y9fgAyw35K9f+urlqetVXExivt+Ln9J2oAR6QMKqt18c9d4fmwvC6ssPRydkjYCPohg5gMsAzR5sK4QJdZK6jefj7dtWguH8BWavmflXi+0QblzSUDy88FmSZfX+NmrjfFaeB5HvaEWSiHMthSaSAeVq03gro2J7hA0Mqdl/0sC7RYMoJTw6bBI6qhm3ufqAxQc9wqIwvHf5xHf12+U1rEjLnBibaZ4FYSFUfiXcVXIZbgyuzPSd9cyMVWneQRS1AYruMq9oF4Cg0yZ+Wmmo/E2f5f1ZbW8f3hkkNNneTZCDJxqlOkiZa1B9NNsBX0Ng7yl1qULO97ITcIzUE0p9LhQB9o+5WESUUSZDwfqLll6gcXUtRApKFE=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QQLIk93OdSLQ6a2ENdiJ7eqmgPsRYJ35Iw+M9ijIsXZsCcdNui/+KH2f9nmiFR6oPY9G6kVGW9QYBOvUaOPidJ3eRyeyB/reOujKJuqwzo+FFjeFgjgw+wEQBdUIsb29XVDCaYbKP91zAOl2ndMkWy5b4n9tR1f6/TtiO3OlnkyobHajhFvhkSAtJJVZzzPmNRC3wmRYmaDvwTrrUTPBoGyUHnITxFOW2EzV5hARGJlhFknmIh9vYfqJnkLTicLCoHlcDOperg3NMZvcc7KNlP2YZRtL653LfTAJ4OurcEdzl05XfQU0Z/FHCP6k49CUlFgtUuYhNw/1MxAHleXqupGphBsd+z2mJARpZx6Pq1yPugTSyUSbo/ikEvi3+NbK3RdiBon/dk1lvHAD9WiGphkw12RYN/xHgHlGqzWCw3qLsKfP0k7TbqqkpZidwAtx
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 08:14:58.9776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13cb3fa1-1b86-4fd5-4918-08deaa7e662f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4185
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=avihaih@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
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

Pass the device name that approved switchover to
qemu_loadvm_approve_switchover() and log it in the trace for debugging
purposes.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/savevm.h     | 2 +-
 hw/vfio/migration.c    | 2 +-
 migration/savevm.c     | 4 ++--
 migration/trace-events | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/savevm.h b/migration/savevm.h
index 96fdf96d4e..1efbe1d79d 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -70,7 +70,7 @@ void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
                            Error **errp);
 int qemu_load_device_state(QEMUFile *f, Error **errp);
-int qemu_loadvm_approve_switchover(void);
+int qemu_loadvm_approve_switchover(const char *approver);
 int qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp);
 int qemu_savevm_state_non_iterable_early(QEMUFile *f,
                                          JSONWriter *vmdesc,
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 150e28656e..c3dd30d619 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -818,7 +818,7 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
                 return -EINVAL;
             }
 
-            ret = qemu_loadvm_approve_switchover();
+            ret = qemu_loadvm_approve_switchover(vbasedev->name);
             if (ret) {
                 error_report(
                     "%s: qemu_loadvm_approve_switchover failed, err=%d (%s)",
diff --git a/migration/savevm.c b/migration/savevm.c
index d1dd696c17..bd8c6ada5a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3158,7 +3158,7 @@ int qemu_load_device_state(QEMUFile *f, Error **errp)
     return 0;
 }
 
-int qemu_loadvm_approve_switchover(void)
+int qemu_loadvm_approve_switchover(const char *approver)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
 
@@ -3167,7 +3167,7 @@ int qemu_loadvm_approve_switchover(void)
     }
 
     mis->switchover_ack_pending_num--;
-    trace_loadvm_approve_switchover(mis->switchover_ack_pending_num);
+    trace_loadvm_approve_switchover(approver, mis->switchover_ack_pending_num);
 
     if (mis->switchover_ack_pending_num) {
         return 0;
diff --git a/migration/trace-events b/migration/trace-events
index de99d976ab..d9084a2692 100644
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


