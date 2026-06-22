Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C062FCDB46B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 10:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbbhv-0007JD-EM; Mon, 22 Jun 2026 06:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wbbgx-0006Sh-N4
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 06:15:59 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wbbgt-0006uW-QG
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 06:15:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqf7gctVibseOBf6ml9upX8tRcH2agCLgVTek7sAAO7A6KEKkHGqUzuycEYhGxELSssyrAylNv0Qqk7LwSRIXIsNJEK0tIQqJYKH/4QXtkCFQ/m0iNnf+y0oskX53szxekV8VSrQ2ULpQ67fdWxNpIjHbZrDG3HfRH9Qw7fod2xfIvcSz7xvKtqGRtjFjAe5ND+FAFbaFbCAlkSfk4KjiCUQ3pI05RTpeVXV8EymaFvKmlYJdMMX19YxkXQgj0Mc3fFimnFjZc97TSXVD3SN6i2Wv9TrnETTwS0TyyF1Df46sqg3STyBh8faY/ILxShVUqfuQlVj7uJ62jB6rQqQzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIWs9OW0CLMJr81rb7LaWCbAYbbLBHoNbFiP+UUP1Vo=;
 b=qpwpbHL3sKgTMfahsce2rsWGXxRByNdvYVqt/76hzHS6VAihW4eUF00seinEu0QUcJT3K9949hNcKvoyX2IwyWylmBIaWbqFAsiX3K7M6LUlvmbuw+IEA9BI0HGh1vP8gxy4YljyOhGaZOIB2IIMHf6S75Jk71JI1Lx1f0uCBMp50iSRxLWhBzAnc00/+vI8p+jDYkrds4SxV03CzNg8/QBCfiQDmi1myzAsmveAr4wv1YwEkGknMGtrqK6T1m7/Dht9uRMpE8HAfkqEe5IALDLpzy7q1rfiN68xYMeWvPhuzpJ2ONLVqLgjYv3j5Mg4XeJLaxFFghcH0t1LX23erg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIWs9OW0CLMJr81rb7LaWCbAYbbLBHoNbFiP+UUP1Vo=;
 b=cB5f5Ir1jqweHJmDi+OK3eDPZ5pXXCIe0PRKF/GlzLKLiOkNLsXEYZEwGZnmlii67ZiB/l1SInwPgHLa0wlc/CaIxyeKOQUnlNJds+FTYWv40WC84V70K4qqqmlPpVS3fGsAF2oI4RMlp1BuKG+p1zpFqLZyytDYuzn+cvVf6odLEvYV61tvdKYGaR9XcD/+ahr2bBbpVFqmUf+sjUgqrrCUFMt+LYa0Mbr8aJey3eD0mXnACQFzdlL9oV1ij5pwy9xo3tc25VzJCNBgs+C2E1An+B0BKcc9LOjUEg3AE3B/kPTjQGgz2eiuOTFdUYbtkw3hw8lGeXp5lrARQKZ9GQ==
Received: from MN2PR06CA0024.namprd06.prod.outlook.com (2603:10b6:208:23d::29)
 by PH8PR12MB7158.namprd12.prod.outlook.com (2603:10b6:510:22a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 10:15:35 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::60) by MN2PR06CA0024.outlook.office365.com
 (2603:10b6:208:23d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 10:15:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 10:15:34 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 03:15:19 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 03:15:18 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 22
 Jun 2026 03:15:12 -0700
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
Subject: [PATCH v4 13/14] vfio/migration: Check VFIO_PRECOPY_INFO_REINIT
 during switchover
Date: Mon, 22 Jun 2026 13:12:13 +0300
Message-ID: <20260622101214.25770-14-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260622101214.25770-1-avihaih@nvidia.com>
References: <20260622101214.25770-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|PH8PR12MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: fc024c4f-4854-415b-6bc3-08ded04732b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|82310400026|36860700016|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dhBOMWDS8NXtAjSkt7xLhfN2AH6/x3df//X7oI2md+cWXPOjGAttQJr876VQHiuMUoj/X3yer+8C3B0PFs6FCE7nuICXnozvcoURuVpuEZto693pJkqCQ+CRxRMCu6jON5DyGtBXYv4rN1ouq+6x7w1zDfxcF40mY/7iqKL9UFkFVQ+mQnwrT3I9mOn3VEX+Gpv5JcvzyPEG0vKSPihXutJNPQO7jENZZiYEA2sW8VDQXuit/pIkpMH7DRWiuwqRT7HhxYbmdxSjgjdT8Oz3UzJmk4zHxqpWW8bLrAUQuf50HM6EPuZyNgCepXaEQSvmXWaF+rM8OABS7AT13xCLn1mudMqkFQ6yA1f5rGS8GFnKEhNFmQfkHeUY3kvugAzGC7O/euIdyzKq8s31bglekr8/yCyJC6CyJ7rE1x5vSkhbkouTOGR1ygjwtAIP8NSKcmqzbw4IPBCwpClE2kCHVzOgZwJdoP51KC9MTiNLTo2K5Sj3qrLzcmwd/kaR/wtFLMHsUJQaQZSu8HP2h4k9Om0WWb/5Oc5d4AssWMV3sx/jD2hC1/fV+7jOY9dVvpLF8EfYLMnasf2on4gS0T+jRbV/CVkmgDkPPCBgWM0oG5oiqGcc0i2yB6K1DM5zI9YuAd5ryi8OhWmEUTJdTHd/UusvwgnzeF+LVy5dZq7fWKbgHUcGgwW3vfJXmwNye+HjpuQuRobLyGmOJDbhjQAr/w==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UkThetrybDqZFXr/k7v4219CGEmAPD/u/vIv9wd5f6DP6TgmI2Qq5PyImom6/L/9GqkHD5VA/UJKy3bOkVQs0q+aKU5rqdiTF5wIj60Pej7JMnDjvedzEM9E3xus1xsG08mJrdT4iIvvcC2w86r5tlP7eFHacx8/aNnMIwSM0suLVyMshntvqma2BhjXLBn6qvUjaiWzvuSEhXyAJSPhIdq+qAw7DNNHlGvD0DYjyErUbAfQxqVcctu1C/r36gg/ETaG7mkGXncvpWHobDyJBnd6mtVOwQoL5XyB2iW5OeY1VuQs5uskVeMtUa5nJxB8P1L9Z4DhuHwmGkco6N0vNm3eiixt7M7rF/M/t5A5UW2SBzTC33l2jwArP6p/MScQXbKyBlZ7j/WQkpyYkY2hisyYOTVlFwFUc/ilp+8JFQM7v2KW1TfesF4KMA0iKcxJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 10:15:34.3485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc024c4f-4854-415b-6bc3-08ded04732b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7158
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=avihaih@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
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

VFIO_REPCOPY_INFO_REINIT is checked only during precopy, before the
switchover decision. However, the switchover decision and guest stop are
not atomic, so a VFIO device may want to set VFIO_PRECOPY_INFO_REINIT
and request another switchover ACK in the gap after switchover decision
has been made but before the guest is stopped. This would be missed and
may increase downtime.

Solve this by checking if VFIO_PRECOPY_INFO_REINIT was set during that
gap, and request a new switchover-ack in the final save_state_pending
call. Query precopy info after vCPUs are stopped but before
transitioning from PRE_COPY state, when its valid to call the ioctl.

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 hw/vfio/migration.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 1e172dd10b..73c49d8c24 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -685,6 +685,9 @@ static void vfio_state_pending(void *opaque, MigPendingData *pending,
      * The final pending query runs during switchover downtime. VFIO does not
      * need a fresh device pending-data query then to get the latest dirty
      * data, so avoid the extra work and report the cached counters below.
+     * On the other hand, precopy sync is needed to check if switchover ACK was
+     * requested, but that's already done during guest stop when device is in
+     * PRE_COPY state.
      */
     if (exact && !final) {
         vfio_state_pending_sync(vbasedev);
@@ -964,6 +967,26 @@ static const SaveVMHandlers savevm_vfio_handlers = {
 
 /* ---------------------------------------------------------------------- */
 
+static void vfio_final_precopy_reinit_check(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+    int ret;
+
+    if (!migration->precopy_info_v2_used || !migrate_switchover_ack() ||
+        migrate_switchover_ack_legacy()) {
+        return;
+    }
+
+    ret = vfio_query_precopy_size(migration);
+    if (ret) {
+        error_report("%s: Final precopy reinit check failed (err: %d)",
+                     vbasedev->name, ret);
+        /* If query failed, assume reinit and request switchover-ack */
+        migration->request_switchover_ack = true;
+        migration->initial_data_sent = false;
+    }
+}
+
 static void vfio_vmstate_change_prepare(void *opaque, bool running,
                                         RunState state)
 {
@@ -977,6 +1000,15 @@ static void vfio_vmstate_change_prepare(void *opaque, bool running,
                     VFIO_DEVICE_STATE_PRE_COPY_P2P :
                     VFIO_DEVICE_STATE_RUNNING_P2P;
 
+    if (migration->device_state == VFIO_DEVICE_STATE_PRE_COPY) {
+        /*
+         * Now that vCPUs are stopped, check if new init_bytes are available
+         * since switchover decision, to be reported in the final
+         * save_query_pending.
+         */
+        vfio_final_precopy_reinit_check(vbasedev);
+    }
+
     ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
     if (ret) {
         /*
-- 
2.40.1


