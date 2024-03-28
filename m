Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB27CD1283
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 14:04:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpqMC-0002f2-Rs; Thu, 28 Mar 2024 10:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rpqMB-0002em-Av
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 10:03:51 -0400
Received: from mail-dm6nam10on20611.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::611]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rpqM7-0003Ti-9F
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 10:03:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXkqSlw547YCmbE/Vg21ZkQ0L0IRjjZQMmslaHzUrV1ArIcwBn3CVtfrpXJ+QFICyhViP28KhRe23DgoZP95M89ZbzdEI+5zk1D0iQBhqq+ycfQN0/wVD5bx/l3mSNieyTYNUy0/sdPfhiTv8/ThZTFXqd+qQOVZmvbb50cBVCo2EnvHz+LVpqHGKTmXkSjnl/YD4f6Hw2eKZoU89dnNJerLF0zkn8e9BXgf+PJ1y5+VwueNeKsTC+1anRYIDwB3QyVgZxOuHlaqZvYn5/EdlO/pHs0BtW/lHaeirijau7iQSBWYfdxprWET0+WCx1E2NO3n0Xh3KCPcI/Tn3ASMJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ad3lBFmv4eP7B2XJq2P915lHjVbzo6H5dj7gnKqPPkA=;
 b=DjmDCq9Ki2mtbFSwpUg5t9kNEg4rJ4KA0+rexfrMBjq6s4dhnZnrux8lmCaoz0xGpOW8p5MpFzBA/zucAWZj7Hz+wZYmdfJH4sWnWFdd4HxlW/YyjnihdToo0I5RjTZq/wHps7OzfOQmE7K6nZxqMFjWWk8/2WWYJ7aLCl0XfMBM42EWDOMGL8IJi6/yMlf0aQjAoxC1gdfS0l9SrRzrAVDQiJ9gLHK1fHjTXBjccJ4CpLRN4QAlY79OgBtpcwyx6IVZyuVSWVYSw3c/Mye9A4WkYndL2l0rQwiYEqgz+3MsbNXp9KhFH14kQ6cwDQ3vYv/JPRk/Wdtc1dZgXFqpqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ad3lBFmv4eP7B2XJq2P915lHjVbzo6H5dj7gnKqPPkA=;
 b=uJNR+2issKMSDvRy5rOIf7BCWngPuCqUGlKntiAVlSmhLhqDMnyjVlLQx2+5Qnsi6qB0lyWutUTOh2qbqM4gob5a2bO4z39lPStDHypGVmIXwIfGVAdSBztO8bpajZinB1wtoZ6Lr6tAc0h09oygl6aQ4X1pc8wg+/++hQgbtJouv7BksB8h703X1fm2JQXmHfbfMK2XYm6cGejPV0j1iGXzTv5IHg697xqooIA0aKppnB0GmPj2bZnbipad/78UjXFQ+Zgp22lcunKbMglH3pqzUIPisr76JGTvHdoUptKGKXbqoZX4xiX7f6NG3fZgljK+T5b7/iLXPOpzgUuiQg==
Received: from SN6PR16CA0047.namprd16.prod.outlook.com (2603:10b6:805:ca::24)
 by SA1PR12MB6848.namprd12.prod.outlook.com (2603:10b6:806:25f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 14:03:41 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:805:ca:cafe::a7) by SN6PR16CA0047.outlook.office365.com
 (2603:10b6:805:ca::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33 via Frontend
 Transport; Thu, 28 Mar 2024 14:03:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 14:03:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 28 Mar
 2024 07:02:57 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 28 Mar
 2024 07:02:56 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Thu, 28
 Mar 2024 07:02:55 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH for-9.0 1/2] migration: Set migration error in
 migration_completion()
Date: Thu, 28 Mar 2024 16:02:51 +0200
Message-ID: <20240328140252.16756-2-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240328140252.16756-1-avihaih@nvidia.com>
References: <20240328140252.16756-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|SA1PR12MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: 42f59d95-f70a-4a46-35f2-08dc4f2fdfec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wzi5w9x5We/m2NBZ7XwFGVmTMQ5KpbQJv7DtS4+oZA3jTm2wtoFXhAPUUBeBAwnU/wranCYNlURTRB3OPoBf//2VxLrn8vJ3pdbqIkhChARN2oPrfuIDhnpXuuRdaiI2374yxE2hqNRev639neKGQuSTzQYZLlRoWQqyY6g9h8Qr36HCXfY2HcKDixBnIzIxX2OI7eEVhD6fUBxGM5lOhlTBV20IbCFWSn58tYnn4PLtaoBqxXFfJwCg4fBncg/sgeM8x3F1suwC81eO6bjdT3JBfAGKp4ABW3PyLdNTGJziltqNsKszhn0R6BUiHKGGaMlqWsjOSRVgVUpurtv0H33kwiZZx8d1CDhDeuQSXSBO7t+HnlubVyBfl0b1oiYO2FlnZPUMv5fFIfAZ1C+v8SElAlhXbknMMm+EzqQB3RejwPY9zuQOdOflEk94+Pb5DLe1u+jg3wk5vjrvQflIX/Ua6h0FBrHVgZQUwaNdj1pVBexE0tyRxc/hVg3BYMVqMKrLwgJfXfwdFvIx8KontDDDBU6XUBrUXMDNeVmOcZEP92o3CA+hUX0O25/2lcwlxmFycult32OXn3YKD5e37hyCZHdZmYzEBSGabgSWCw4iM529ao/25D5Gun3rWlmCjIWY5NwTvIIQwuowCPMSEFQyYLzwI8D6AjY56NNZe6tOjQ9sFyBXMbcc2bycvcBDGeSM91YO9KkOujsT3LZU3hksGxaQnleqvpY5PGCIN6n03oHZDxAJg9JgYbtuJ8Ya
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 14:03:41.7218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f59d95-f70a-4a46-35f2-08dc4f2fdfec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6848
Received-SPF: softfail client-ip=2a01:111:f400:7e88::611;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

After commit 9425ef3f990a ("migration: Use migrate_has_error() in
close_return_path_on_source()"), close_return_path_on_source() assumes
that migration error is set if an error occurs during migration.

This may not be true if migration errors in migration_completion(). For
example, if qemu_savevm_state_complete_precopy() errors, migration error
will not be set.

This in turn, will cause a migration hang bug, similar to the bug that
was fixed by commit 22b04245f0d5 ("migration: Join the return path
thread before releasing to_dst_file"), as shutdown() will not be issued
for the return-path channel.

Fix it by ensuring migration error is set in case of error in
migration_completion().

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/migration.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 9fe8fd2afd7..b73ae3a72c4 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2799,6 +2799,7 @@ static void migration_completion(MigrationState *s)
 {
     int ret = 0;
     int current_active_state = s->state;
+    Error *local_err = NULL;
 
     if (s->state == MIGRATION_STATUS_ACTIVE) {
         ret = migration_completion_precopy(s, &current_active_state);
@@ -2832,6 +2833,15 @@ static void migration_completion(MigrationState *s)
     return;
 
 fail:
+    if (qemu_file_get_error_obj(s->to_dst_file, &local_err)) {
+        migrate_set_error(s, local_err);
+        error_free(local_err);
+    } else if (ret) {
+        error_setg_errno(&local_err, -ret, "Error in migration completion");
+        migrate_set_error(s, local_err);
+        error_free(local_err);
+    }
+
     migration_completion_failed(s, current_active_state);
 }
 
-- 
2.26.3


