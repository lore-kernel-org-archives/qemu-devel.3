Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF66CD3439
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 08:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKAwG-0001Sy-Pa; Tue, 05 May 2026 04:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wKAwD-0001Sj-7I
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:15:29 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wKAw9-0006cu-9U
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:15:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oi/w/gmoIJe0p9v0FkQkjDOffx2dzSgoeOUWx+YsybrHuLQPOTE1KhtlOnD1kGp7WusA81dCCd3CuOuBk33P7wKyA3NYs1RJ6T3KeBwf9fflpnPOshx3WNovqyxFKGGnuSLr6NAMH8Orx4VIcQhJgWx1bsRrsEH3r6e4Mt3bNTFe+bBTaDKg8IM8pDkaH/XUKxiVodGxkm1P5eg/4p4MLIqaxzcP8Ro2IXX8kNpR+VM5NSJNk1iITHm3STw+8GlfcrLR1B3q5Y7AC+uVSEvtdcw+6+xAIDW/fEhbq8xC0B0U3WlgJIyw3gBK9VHzNFhEdzDlCnDYCR6Yjxd3n8g2AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UK7Ao/R6F015juGPJnKa3fiPfGaDyoqYHVlD3ljVIJc=;
 b=Vuhnh1W5kojhkREBlOPUEoBBi9ObHHJkwBKMB7NX5pdCLTdf6G/CekHLyfg0rto2bAf3ywDyppGz7HxX2+7nUbOSPfCoFFsWK8oWni+/hKOMr8BjD671y9u+G98t1AxO6Pv7txYCJqre2EDEeVkYGf/gUw1toxGQwJ6FR0eYFaJ2YsC0y882v8tPiYyHGSyPqYf/cvjdSBwmDv5nLBWXN1+Yi9itdDvEm3F1lcJnuvlc+zPEzpEnrR64NXi78B+V8T9Y73kJKamurQRjnc9LGQdh16d1BDhbqyBOdDidvswsJvwY9iQBhFaS96UZFZ/QEJch8Y03ztGCJzaIRAm/gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UK7Ao/R6F015juGPJnKa3fiPfGaDyoqYHVlD3ljVIJc=;
 b=XriDp/KMVHNE/dbFM54ty/nQDf4Evk2sr32CTRhwDKVNC7I2vuq5+fcd/HcgorKyGhw+IgA/Q1OTNthI4fARaIGUezLolBqUoaeb2Hzljsfy0GscvbsKQEryOqCAsyCAebJYZH8uhE07WHD+CyByz5kzMpY7QVHdoCuKnoh7xouD8XZDLuaprLbcJUPHAr9hf4O2BXxJLuHnVijjUCE1E0tl1cAGlDAqMNjL9/ivfNaAKNKcR8nmoQYIWWLCrXMbZlECdGz8mAs7dB6MwjMvJEb7thrul1l1Kn6pcTRq+0VgwZOuC/FyjIHXdwnow0BbhGYNpNteJmKwYZEhjD5+vg==
Received: from BN9PR03CA0890.namprd03.prod.outlook.com (2603:10b6:408:13c::25)
 by SN7PR12MB7979.namprd12.prod.outlook.com (2603:10b6:806:32a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 08:15:16 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:13c:cafe::92) by BN9PR03CA0890.outlook.office365.com
 (2603:10b6:408:13c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Tue,
 5 May 2026 08:15:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 08:15:15 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 01:15:00 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 01:15:00 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 5 May
 2026 01:14:56 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Zhao Liu
 <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH 08/14] migration: Check switchover-ack during switchover phase
Date: Tue, 5 May 2026 11:14:17 +0300
Message-ID: <20260505081423.28326-9-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260505081423.28326-1-avihaih@nvidia.com>
References: <20260505081423.28326-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|SN7PR12MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: c1e5623c-a368-423a-8081-08deaa7e705d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: GmPjwmdpQioIb26ccusjXC1REczm9SuSTowGXY3iqBEs2ezcK7AyYI3+Ae/oNdLl1Z4AS/MLvBphXpzixSYeDt28+JKQJ/d+b/K36sCpbCBMq6g6efsydQFSUDrCfwuK0E+6OwAfIwvWy2SkOWFgPSyWLabRQZVd0N7A6VRF14euTvKY7QAlzXk76iTy0tWiyii6MscTdRXOiokiehuHbRa1UsV/cNwlGygGmYTQWGoZk+vPLiDTLX1faYtaQKlayMy+tL9SyNsKn8tL/l6ZQjHEAZJBhVDZs7wZaQ3pLzpQZKVKLrdhP15GZjAvLCgBEjmsayH+3nfDyOA3fyXyLO0NXbI3K3csB5wsBURl+aiygKLbM1cqXKz+CPLUTKOglMhbtaO9Cb/+lsZxjbh3KkcrGRzPNXy7/iHB7brbvCHvSBNkAtyKcnR8U9V1UiRT5x4GhseZ6awPlNVUKjR2p1SORFUhu5p4ajaD/ZdgCCfvuvEmR7WJEstX/grv7fmvKaiL9eiIzOr/oG4L4VfJlhrFtJZtDwMheCrirCHFP0Uh4DBfuS3h0I+UmbVCnuydWe7F0JLSSpFHlspk+GErxTr1OUy5uraVKBx9JwNyneaQZI3CHktCHMTnwgiL/xbHSpFKflqIBwiF0M0NCpd02S4GNLqORsZeJUpFH0j0cTxefWHHnAm93EOWB4KkVgVpSdPhpzmdTypPp+kMEkwBqAvBtd+Yp2OimcGNZUXUKk4=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SP/hMN4xOjpSt2r/RpeueaN+T9qik7f5FmiQ7s/3HJndhxari9QM3TxYf/oDxpdL9Ear6zpPlLagQFcTt76p9Qbgxn0fBIoACWnZbec73wI4NBxUsRGKv4NK3f9iSeOoL5cmQKNRNScR+WpEWD3LUwEaQIJ/ThBULVAYv5QJUjGhdun9bZO0lzA8jF73JKup9cdy25H1QgSJQEX2+P7/MAu4DzROqJFPMC2/2Q1BrVFhJkWTgEjzqjOJZYKr8aiAjam45Zsa7UBGsj0yPX0CptDMQQkkfuKGlFQFp8T/bKjlPakajj26rSyOR/9zATjCU83KVQf/GCJ+0NtoyCFYSW9KL9VI90tNkZ1zjbQGtdlV8Jw5RRYh/lR2hxiK8QqkYxI0oL43qPNqoRgAJSDU1UXiesTmUfNGh1nNRYSGS7ooTs5POpiVv3xkcNU/NoD6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 08:15:15.9077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e5623c-a368-423a-8081-08deaa7e705d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7979
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=avihaih@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

Switchover ACK is checked only during precopy while the guest is still
running. The last migration_can_switchover() decision and guest stop are
not atomic, so a device may want to request another switchover ACK in
the gap after switchover decision has been made but before the guest is
stopped. Migration would then miss that request, which can increase
downtime.

Cover this case by checking switchover ACK again during the switchover
phase, after the guest has been stopped. If a new ACK is required at
that point, fail migration so the condition is not ignored.

Ideally, precopy iterations should be resumed in this case, however,
VFIO doesn't support going back to precopy after being stopped, so
implementing such logic would require non-trivial changes to the guest
start/stop flow. Given the above and that this case should be rare,
failing the migration seems reasonable.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 include/migration/register.h | 1 +
 migration/migration.c        | 7 +++++++
 migration/savevm.c           | 9 +++++++++
 3 files changed, 17 insertions(+)

diff --git a/include/migration/register.h b/include/migration/register.h
index f43f47a679..755e590676 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -33,6 +33,7 @@ typedef struct MigPendingData {
 enum MigSwitchoverAckRequestStage {
     MIG_SWITCHOVER_ACK_REQUEST_STAGE_SETUP,
     MIG_SWITCHOVER_ACK_REQUEST_STAGE_PENDING_EXACT,
+    MIG_SWITCHOVER_ACK_REQUEST_STAGE_COMPLETE,
 };
 
 /**
diff --git a/migration/migration.c b/migration/migration.c
index b86ceea6ff..94980fcd37 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2776,6 +2776,13 @@ static bool migration_switchover_prepare(MigrationState *s)
 static bool migration_switchover_start(MigrationState *s, Error **errp)
 {
     ERRP_GUARD();
+    int ret;
+
+    ret = qemu_savevm_request_switchover_ack(
+        MIG_SWITCHOVER_ACK_REQUEST_STAGE_COMPLETE, errp);
+    if (ret < 0) {
+        return false;
+    }
 
     if (!migration_switchover_prepare(s)) {
         error_setg(errp, "Switchover is interrupted");
diff --git a/migration/savevm.c b/migration/savevm.c
index b6076579de..9150cb93ad 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1480,6 +1480,8 @@ switchover_ack_stage_to_str(enum MigSwitchoverAckRequestStage stage)
         return "SETUP";
     case MIG_SWITCHOVER_ACK_REQUEST_STAGE_PENDING_EXACT:
         return "PENDING_EXACT";
+    case MIG_SWITCHOVER_ACK_REQUEST_STAGE_COMPLETE:
+        return "COMPLETE";
     default:
         return "UNKNOWN";
     }
@@ -1505,6 +1507,13 @@ int qemu_savevm_request_switchover_ack(enum MigSwitchoverAckRequestStage stage,
         requester = NULL;
         if (se->ops->request_switchover_ack(stage, se->opaque, &requester)) {
             requester = requester ?: se->idstr;
+            if (stage == MIG_SWITCHOVER_ACK_REQUEST_STAGE_COMPLETE) {
+                error_setg(errp,
+                           "Switchover ACK requested by %s during switchover",
+                           requester);
+                return -EPERM;
+            }
+
             pending_num = qatomic_inc_fetch(&s->switchover_ack_pending_num);
             if (pending_num == 0) {
                 error_setg(errp, "Switchover ack pending num overflowed by %s",
-- 
2.40.1


