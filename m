Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40F0C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT2YK-0002Kh-9Y; Thu, 25 Jan 2024 11:26:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rT2YH-0002Jw-Eh
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:26:05 -0500
Received: from mail-dm6nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2417::601]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rT2YF-0000TE-MT
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:26:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtm+ay/FTkDBLZ1zzKr2UIi0Irk/Fiy+3CO4Th8iQmUTm8hHlnazUOkww3IfxYgzoFy1+6iIjj3f3+qoaZJ1v7/GdqdIbp54leZHGXIsaoGzfFPIfNzfkA/HJv5hKPEaRCQCFHEVVVAedUZ4Mhr7Ev3WoaeuiyBGibHdJM8BNhbuwEZ3gWYlPAOUuNt2qvp79Vx00eMfnYisn8ONVbhJc6ZFfhevwEfFjP2oZ460mGCusxJMwGlVssXnKVV+R+carTkzb9EBulXKay21ywT1cBb+CeojIDmUYKt494CKtfqicK5XKNGVwuQ8VgYiSzlQN5IrA3P4svgFr3VJ9EjqCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMGDN5kBfvfGqyo6Ds6NGGxr7RB3zVAKsYBNcJiHQ+I=;
 b=TzaluZxHBbTcS72TBLn070+t6xJlpRHT2Ls0SzmNtrWJM0McKfLB67e4elpUKhZr6zjHG6gRtutcUWwgKPEW/au4b7j5xHohFirFH3RFxCZJUBZot0UZMUW3RdmjV38iU5/w+cgzEVDsLfta+WyYYKrZopc7MQuoShimnxhIBiXVmsjqf6qB7O+ueYedHv/tZI/Xk3J8uoA1pJqk+BKG8IJyRhDEiKgpyka/N4RiSEDqaKz4IXCg8PI5qqrsMI7lPOCdfyotRRi2ZEkCj0NKGFNjnQOoV+iMrpeKEHSo9tM+F1p8Kzgafvt3H/oD11Hk3NRzKoz3/U18Vb92DPV9pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMGDN5kBfvfGqyo6Ds6NGGxr7RB3zVAKsYBNcJiHQ+I=;
 b=aMPZyFL2Go9qTuGaueuRmxFp8lHICcIn0coSZ4jPzD3cRP17KCgQGEuTZskI0uZq8VMppjJy/DeOdHT0SZzt6SRhsCmCvx+O96JhdbyNH/oOMTcwQ+3I2qpz5bZRLSLdDbTTPiUtz+MpPIrppkzFAVNVXMzh3TijTU2FUCaOR5lUBdm0N2tBzDHKojXCjpN7Fk/nxtFKYzL5A43hQiT1iwizkxh8MEsfniiXMnA39zu31NgE+X0D1sfizeKciQisYZWfyqP1k5vLvYJ7l8RZ28eUqPPSYuUGHOgLbq4sk0rJz6gSGS33ymxvobvkkUUwCdqXhLxkQ4HgF/9r4uTwcA==
Received: from DM6PR07CA0082.namprd07.prod.outlook.com (2603:10b6:5:337::15)
 by IA1PR12MB7495.namprd12.prod.outlook.com (2603:10b6:208:419::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 16:25:57 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::4f) by DM6PR07CA0082.outlook.office365.com
 (2603:10b6:5:337::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27 via Frontend
 Transport; Thu, 25 Jan 2024 16:25:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.16 via Frontend Transport; Thu, 25 Jan 2024 16:25:57 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 25 Jan
 2024 08:25:47 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 25 Jan 2024 08:25:47 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport;
 Thu, 25 Jan 2024 08:25:46 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, "Avihai
 Horon" <avihaih@nvidia.com>
Subject: [PATCH 10/17] migration/postcopy: Use the new TLS upgrade API for
 preempt channel
Date: Thu, 25 Jan 2024 18:25:21 +0200
Message-ID: <20240125162528.7552-11-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240125162528.7552-1-avihaih@nvidia.com>
References: <20240125162528.7552-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|IA1PR12MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: 7887305b-0140-4651-5116-08dc1dc24f8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l5lPSuDEljOKW0cG9F3D/5xMt1vQFsj8RnuyaHteazVSLxoSs8pKlRx4YbyUwJUXgna1iPD2WN1Qkr+uj2Lky/NselMEVhsmItKb2kHJF+n6XVhl2yii/1MhT2Vm79RG/Ngy9EWBXi/QQg5b/BkhMXleY64xjiJoEPv7+ZxxobAWNdeR3CjVy/DPwre+CVKD4qbf2VCBgS60h9gYa8r7LzPxPQ3v8OCH5ekV9iVCfnQZZbTnMDwTWjPJS74GKqJljfU1yxPxZGOrD/DBY+bH+BLAUsOuR7iMkPgI2w90exQSrBtHAqScS4c1kkvOcpeNbkrjqtRf1mBZbJx5VDbctBq6mmS/yWW49MF1FYFnujlhaNpf2jS/XxyCcy+/BrahHM2ibOy9zFhv0VkwVnObpwH8BrYgOkCG0ta/jhGw+64N6FCbQxnS4C11nOQ34ylnAcV1C+U0guzJ+rs01N0dT+fmU6fyNhX1/z6kwUoK8TrTDFNkYbfthG0IH4nVnooN7sj2UHXFvZm0aFcerbbMnhjmp6/yUR1ytxQQPdHl+DWDtmmny/JGl4iIuk7aMcRvh9WXl/Ys0sQmP+dUsl/2H9hjMo0Oht+ABFPBN35xo6TJkQE4345sF5M6/gdvd5e4vxh9zd1G6xmog45rg+BW6MrdH7FBqx7yFREpuqJ0Q3Iglsht2GJ6nQimOEkwhmRzrHalfLZRnzrZlCjrCOfj7qQVfvWm8fz6lHt91qAB66HLzxalruBhTJAN4i8hrD7T
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(40470700004)(46966006)(36840700001)(2906002)(5660300002)(82740400003)(7636003)(36756003)(478600001)(86362001)(356005)(1076003)(83380400001)(7696005)(107886003)(41300700001)(2616005)(47076005)(36860700001)(426003)(6666004)(26005)(336012)(6916009)(54906003)(316002)(8676002)(8936002)(4326008)(70586007)(70206006)(40460700003)(40480700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 16:25:57.4130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7887305b-0140-4651-5116-08dc1dc24f8c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7495
Received-SPF: softfail client-ip=2a01:111:f403:2417::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Use the new TLS upgrade API for postcopy preempt channel and remove old
TLS code.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/postcopy-ram.c | 20 +++++++-------------
 migration/trace-events   |  1 -
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 5408e028c6..3df937e7da 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1644,15 +1644,13 @@ postcopy_preempt_send_channel_done(MigrationState *s,
     qemu_sem_post(&s->postcopy_qemufile_src_sem);
 }
 
-static void
-postcopy_preempt_tls_handshake(QIOTask *task, gpointer opaque)
+static void postcopy_preempt_tls_handshake(QIOChannel *ioc, gpointer opaque,
+                                           Error *err)
 {
-    g_autoptr(QIOChannel) ioc = QIO_CHANNEL(qio_task_get_source(task));
     MigrationState *s = opaque;
-    Error *local_err = NULL;
 
-    qio_task_propagate_error(task, &local_err);
-    postcopy_preempt_send_channel_done(s, ioc, local_err);
+    postcopy_preempt_send_channel_done(s, ioc, err);
+    object_unref(ioc);
 }
 
 static void
@@ -1660,7 +1658,6 @@ postcopy_preempt_send_channel_new(QIOTask *task, gpointer opaque)
 {
     g_autoptr(QIOChannel) ioc = QIO_CHANNEL(qio_task_get_source(task));
     MigrationState *s = opaque;
-    QIOChannelTLS *tioc;
     Error *local_err = NULL;
 
     if (qio_task_propagate_error(task, &local_err)) {
@@ -1668,14 +1665,11 @@ postcopy_preempt_send_channel_new(QIOTask *task, gpointer opaque)
     }
 
     if (migrate_channel_requires_tls_upgrade(ioc)) {
-        tioc = migration_tls_client_create(ioc, s->hostname, &local_err);
-        if (!tioc) {
+        if (!migration_tls_channel_connect(ioc, "preempt", s->hostname,
+                                           postcopy_preempt_tls_handshake, s,
+                                           false, &local_err)) {
             goto out;
         }
-        trace_postcopy_preempt_tls_handshake();
-        qio_channel_set_name(QIO_CHANNEL(tioc), "migration-tls-preempt");
-        qio_channel_tls_handshake(tioc, postcopy_preempt_tls_handshake,
-                                  s, NULL, NULL);
         /* Setup the channel until TLS handshake finished */
         return;
     }
diff --git a/migration/trace-events b/migration/trace-events
index 2c328326e8..9a8ec67115 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -297,7 +297,6 @@ postcopy_request_shared_page(const char *sharer, const char *rb, uint64_t rb_off
 postcopy_request_shared_page_present(const char *sharer, const char *rb, uint64_t rb_offset) "%s already %s offset 0x%"PRIx64
 postcopy_wake_shared(uint64_t client_addr, const char *rb) "at 0x%"PRIx64" in %s"
 postcopy_page_req_del(void *addr, int count) "resolved page req %p total %d"
-postcopy_preempt_tls_handshake(void) ""
 postcopy_preempt_new_channel(void) ""
 postcopy_preempt_thread_entry(void) ""
 postcopy_preempt_thread_exit(void) ""
-- 
2.26.3


