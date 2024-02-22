Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F5BC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 16:02:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdBWQ-0007FF-MK; Thu, 22 Feb 2024 11:02:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rdBWL-0007E9-00
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 11:02:04 -0500
Received: from mail-bn8nam12on2087.outbound.protection.outlook.com
 ([40.107.237.87] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rdBWA-0000wl-Kr
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 11:01:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6/rtNSPzRHQTZVuRBWqxZWQPC77Kwmo8sd1rAV+u8emJLmZZLz+pDOEQPENNIIETcvslVoK1Kyo//gOsQN3+3Pj7WhMbsoAWqKYAHGxyYU+skXacaof8P0chx4z8vn2aZwHxw1mRD2kqKGXemORvOhoZiSE83bTEN9xs0lWjTodbyeDtBU3cTeRrv2DcygCCSzJGm5RRP8iufx4SpVSkqOOhFbMk/C2efA1+9iyxxbBkev7hQlrv3j1eI7vqqoZelDY/QTfWgcp96GAxihMDpKdGiv5b7VNLtiy4UArX9G+pPq0ckcNBzu3rm+fTHoakfNYb4Z7lL0AgAVew8JSjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TP5qxz/4G5mBZWEa4ivd/eGgGMsqhrM+7NFeZCmpCjM=;
 b=jPn72dX8JO4OKIq1k0m5iRYtI0BcfyGGeCQule/dhH5s+TZybWV+a5oHSdnr2PZF3rtVw1yRn03aki2JCwv+01gcucv2C4SYoYpRNMtNBT5IpEcLJ9JyY5Kp4EtNgj0IZfGCr/7qDzPp2A/tNRGmU1a2hT3nYedFWB8vimZSz9yd6nVOCvAvx6dyz2aBbvG6BxSaRsgtIrVi3bp1D7PNc/547K9l4WoHUd+av0rCE7xMdUF9cu2s++ayqlijl1tGIY+wFXSusocxyd7hMNZpVtFzMan2g8/oOMFaM2wVaLmBIVHamIDQXMtQ8wm6tdGvdeuYIHZpHGS3Gt+rrOzf0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TP5qxz/4G5mBZWEa4ivd/eGgGMsqhrM+7NFeZCmpCjM=;
 b=kiQBN60qJvMT2AQYdZR4VSn2Ba7BK00MU+nbb419/3gEBCqqMMhsrn75dEWwbzcByy6tbSshivR7bhBCLaBgzf13M3h2i67YNLgXXMX3RtJbozVIVQ/Vz+XdMp8SG6PiXEtQi5pTcUMHAqSEgEqtMs2wEHOhmfFeQDfAkzitqVox3Q/5zb9o+m/bsqPEPZl6sdqHoqWALY1zqfvzNj1th8Hj2U0FDLCV8KDs61vrXBjG40VDgMMdouAXR/Ieqz98F7V7PvyKjxSeCtvfl6R/cvl1wqYKsklkD1lTmO+jz4igIxH13w0DH+a2skHgfIJx11ZSl+GS7MXPTu3vKZ6BLQ==
Received: from MW4PR03CA0243.namprd03.prod.outlook.com (2603:10b6:303:b4::8)
 by SJ0PR12MB6710.namprd12.prod.outlook.com (2603:10b6:a03:44c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 15:56:40 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:303:b4:cafe::65) by MW4PR03CA0243.outlook.office365.com
 (2603:10b6:303:b4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Thu, 22 Feb 2024 15:56:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Thu, 22 Feb 2024 15:56:39 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 22 Feb
 2024 07:56:30 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Thu, 22 Feb 2024 07:56:30 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport;
 Thu, 22 Feb 2024 07:56:28 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, "Joao
 Martins" <joao.m.martins@oracle.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH] migration: Don't serialize migration while can't switchover
Date: Thu, 22 Feb 2024 17:56:27 +0200
Message-ID: <20240222155627.14563-1-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|SJ0PR12MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: 423676ff-473b-4424-0d7a-08dc33bedb6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: izAGlMBiPDkQ9DeFfAjyGr8ELpV9CFvAWI7BhmoORautd19UvAmWOaqC0qBiadwnTIOp8f8IQVC44J4oMfd5x02Y36jcrcP1/0Le+eRpDI3GUfnmOVpOn3lfgph/Op9wb4URB/iWEMnyC4Usl578SYBRaKATw6RfMIc7WYpg+ocvgqXwICeSt0/gzOIPJoBui6GusKgcdu7TawE+TJbdm72aExPsXAC1ZkKrHPZ3YRlKEKoeoyO1YsZ//6EqeK2ZnDBezdz+ymrar9n4p9MfPX/vRQoBO+V7l4J6pzhsc5aZS/Svz09BoQ0g73t06nSLRrOahvbmzS/ITpO0+Ig2zK/nwWlbbgeC5cItBKcD6UpwARvHnyF6Op9+6RXdhcZRzBdxvpQ5mqlxZzuKMEm2RS/AxrZqv69VqJDy9wuNSlNU+aYl94kumwEF/ax3XToUewXJUta56Lajq7oSKMoCuALRIVY8OF5T4tv/j12FG24Xz5sujSDn4QuLtdhN5iBaNKoM8xOnnuiO1YMYTmBaEO4y4XwgVgVT/vMB7+DpVH0jsYnYBeGsSH2ePBBUtr7RswDDbYUZMOBaEYlt24613+HZZW0KT4+rm+oJcdq6uDbveOqBORDaQjAcvhl5j4Esbc2HfFkh/QRtgTrFuPL/YvGNlP5Nnq+wWVO9JtNTXlI=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(36860700004)(46966006)(40470700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 15:56:39.7146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 423676ff-473b-4424-0d7a-08dc33bedb6d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6710
Received-SPF: softfail client-ip=40.107.237.87;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.002,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Currently, migration code serializes device data sending during pre-copy
iterative phase. As noted in the code comment, this is done to prevent
faster changing device from sending its data over and over.

However, with switchover-ack capability enabled, this behavior can be
problematic and may prevent migration from converging. The problem lies
in the fact that an earlier device may never finish sending its data and
thus block other devices from sending theirs.

This bug was observed in several VFIO migration scenarios where some
workload on the VM prevented RAM from ever reaching a hard zero, not
allowing VFIO initial pre-copy data to be sent, and thus destination
could not ack switchover. Note that the same scenario, but without
switchover-ack, would converge.

Fix it by not serializing device data sending during pre-copy iterative
phase if switchover was not acked yet.

Fixes: 1b4adb10f898 ("migration: Implement switchover ack logic")
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/savevm.h    |  2 +-
 migration/migration.c |  4 ++--
 migration/savevm.c    | 22 +++++++++++++++-------
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/migration/savevm.h b/migration/savevm.h
index 74669733dd6..d4a368b522b 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -36,7 +36,7 @@ void qemu_savevm_state_setup(QEMUFile *f);
 bool qemu_savevm_state_guest_unplug_pending(void);
 int qemu_savevm_state_resume_prepare(MigrationState *s);
 void qemu_savevm_state_header(QEMUFile *f);
-int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
+int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy, bool can_switchover);
 void qemu_savevm_state_cleanup(void);
 void qemu_savevm_state_complete_postcopy(QEMUFile *f);
 int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
diff --git a/migration/migration.c b/migration/migration.c
index ab21de2cadb..d8bfe1fb1b9 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3133,7 +3133,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
     }
 
     /* Just another iteration step */
-    qemu_savevm_state_iterate(s->to_dst_file, in_postcopy);
+    qemu_savevm_state_iterate(s->to_dst_file, in_postcopy, can_switchover);
     return MIG_ITERATE_RESUME;
 }
 
@@ -3216,7 +3216,7 @@ static MigIterateState bg_migration_iteration_run(MigrationState *s)
 {
     int res;
 
-    res = qemu_savevm_state_iterate(s->to_dst_file, false);
+    res = qemu_savevm_state_iterate(s->to_dst_file, false, true);
     if (res > 0) {
         bg_migration_completion(s);
         return MIG_ITERATE_BREAK;
diff --git a/migration/savevm.c b/migration/savevm.c
index d612c8a9020..3a012796375 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1386,7 +1386,7 @@ int qemu_savevm_state_resume_prepare(MigrationState *s)
  *   0 : We haven't finished, caller have to go again
  *   1 : We have finished, we can go to complete phase
  */
-int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
+int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy, bool can_switchover)
 {
     SaveStateEntry *se;
     int ret = 1;
@@ -1430,12 +1430,20 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
                          "%d(%s): %d",
                          se->section_id, se->idstr, ret);
             qemu_file_set_error(f, ret);
+            return ret;
         }
-        if (ret <= 0) {
-            /* Do not proceed to the next vmstate before this one reported
-               completion of the current stage. This serializes the migration
-               and reduces the probability that a faster changing state is
-               synchronized over and over again. */
+
+        if (ret == 0 && can_switchover) {
+            /*
+             * Do not proceed to the next vmstate before this one reported
+             * completion of the current stage. This serializes the migration
+             * and reduces the probability that a faster changing state is
+             * synchronized over and over again.
+             * Do it only if migration can switchover. If migration can't
+             * switchover yet, do proceed to let other devices send their data
+             * too, as this may be required for switchover to be acked and
+             * migration to converge.
+             */
             break;
         }
     }
@@ -1724,7 +1732,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
     qemu_savevm_state_setup(f);
 
     while (qemu_file_get_error(f) == 0) {
-        if (qemu_savevm_state_iterate(f, false) > 0) {
+        if (qemu_savevm_state_iterate(f, false, true) > 0) {
             break;
         }
     }
-- 
2.26.3


