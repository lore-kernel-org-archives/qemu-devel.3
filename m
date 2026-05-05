Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17596CD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 08:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKAx9-0002IS-My; Tue, 05 May 2026 04:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wKAwi-0001wz-A5
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:16:05 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wKAwc-0006lg-77
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:15:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9BEKxyNTzw6tmwzIvvoi3Bd7dqbLhn08a0PaehQYNs6sRSM0gIsiaGNyVrVLlwmEZa7hvZSITEEdSyOVZhanBFgmz6aHTgvEuMERLHbadPTEO01qx+Edi217DnWX8E/PmnDXpZhpYKMFs9y9yUh0Gjzbg/Ip1bZ2qW2zcMlMtWoxaVKmWV5JHaZ1xlHUEfJwnJesZTNLnk1jf4gJS/WmTbf8XFIGfxgxT2s9AhuUHFffWSWhgo8YYfIzWNpPgDFftPIfKIxtkapboOgdNuqXn5FiSpsifQMYm4/tZCjVqD5csdXkLSveIVVTfSAlUfQQhd7j02nwLodGsFREOqhNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wObNtDY1dWd9SbzTWOw1VWJ32qiUUAts4XSDSfNhIEY=;
 b=XqOu6xHEWah7o/PFXh9c+bp2Du8G6FiSWXNDFPLi0nQfPVj95zydwlBU0lNdcin2+t9oknglVPSaq+Omx7cyYDA7WvY5W7HaoAUXYcH8WGBDK3jnspZH8Aa+5bY41dLRPpGPCaRGnQdWhU3ZKoPiME53nLZJVGrWEXVVKY5QD9+x+T3letuMNm93/Fa88hJ2mfJosq1gJDzO8JVUVhzE1LXYCKdZHSGlF0PIih3Y9lj6rQ7FV2TlEy9RY8Vmwqlgr8XPaJweDJKKbnbATKgYZ/DYz7h/DWNbxPqZQURQOwwI2PLmZMV5bYm0WaoY6OxfJP7WZ7roRsuh+RCq7+wvlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wObNtDY1dWd9SbzTWOw1VWJ32qiUUAts4XSDSfNhIEY=;
 b=l1MQPKjSc8+V6QrLJsk9H0W4xRxCGDHLe9s93i1OtFGKU115vlXtmjmOXKRs3oLc3pBktPazNNSNUXA3Ro/JPYJu3KWCbgPB4EZNd1GYgK3THmJP1aUjah+HZn6K5id8W/5hHYu20V+w+rKPvbJ/LS6ynmKZJN97ZSaLzV5jGhLawOW3x3XEzcJ+D2kdyHaYl223rE3nTPqGSCdvcKI9FC2wfLx2XTejmMF58c2cbrERMbtVW/95a5CR9bNJRnmFzTw0OW00lgLgkqYcciyZzx1im1rZ2n+/002kDlq9n+N079FNRX6fBZY8rEtzGALcuOxWaIklDe22/ZKdUFdXpw==
Received: from SJ0PR13CA0200.namprd13.prod.outlook.com (2603:10b6:a03:2c3::25)
 by DS0PR12MB8788.namprd12.prod.outlook.com (2603:10b6:8:14f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 08:15:45 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::3c) by SJ0PR13CA0200.outlook.office365.com
 (2603:10b6:a03:2c3::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Tue,
 5 May 2026 08:15:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.1 via Frontend Transport; Tue, 5 May 2026 08:15:44 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 01:15:21 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 01:15:20 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 5 May
 2026 01:15:17 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Zhao Liu
 <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH 13/14] vfio/migration: Check VFIO_PRECOPY_INFO_REINIT during
 switchover
Date: Tue, 5 May 2026 11:14:22 +0300
Message-ID: <20260505081423.28326-14-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260505081423.28326-1-avihaih@nvidia.com>
References: <20260505081423.28326-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|DS0PR12MB8788:EE_
X-MS-Office365-Filtering-Correlation-Id: b6a7e338-2eed-4d04-3cf4-08deaa7e819a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|82310400026|376014|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: pmHZEpSI8zfwa7RDuwZKz/7mjNKN2+VksTwv7vo1apDNybyRXKh1wa7XRW42ZX+ralBgtX88ybui2hgBssiAR8xCHlECEKl1Ec77CgtiB4K/aUzRYV2y/JC9K6dTst9aTC4sFXizgO1BxTVdDkZtWmgIvGoS01j9yQ8oxLSc4pyGT7u+wE5e8cPziiAqIyfrXh4/sPaV6hB0QIvDKDNFgFJGaWzmBQt3avmI2+8sWzRLZshH2dWbI7h1WDTx9C3DZnUESex3LhSIn/ZAWrInb8Rs+h6PN5YxmKAii4Htyc7Y8mDufegCgfBftYaKzoMnqFDf2NOHl2OChwpYW20W/IZ4moNxHdHl8G8xNbvheeZSiggxGdK9WEM9b14yoULLjg8GTKKa0d8MpbyiBxIu/5T0P5qCdPfNcj/DqJkUQnqTKVk3E/2IV/dgp59S9S2abohqoKISMXKT/TB0O3kXHTGALnQTvfEe9OLz0AY3RWI/Zmj/EowsPyKDAitNKyUCFvAtbuMBO0eZ9vR/NL8WEWLVKUydHx43PW9a1Dt+tnfwQJzrPGnnkGHKilpuqNWKqvuKUioobEGe17wykGX2wuKR/Dsn9laPYYCdz9lUhx02r5+vej4JmnoRZrP6nu0Kpu+yKi/uQ29CMhvRxuGRUyCzydKaYBoPKeThEsYXodvnBdlFKA0adAgFJKvLCadzlgHiLUKlXEwAfEoMQgm0nn96uwULsgeO23VjmG9CUnc=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6do3VIFA09yOdSu/nxeGR6yJCsYBM3E3BoQcYfbAqqjBeeo8gsu+m19Bn9VL4dcbXGC8B0jvnriWByuv9TmhqQO4Nf9iXgSYEPkcvE2byksTLIKxhYcTgaGsSqBeHSUMHPa9sQ4AGlMj1hmbQxoPNx9Le7QoESGRVKByX2+EJscu8ImSVW/bQ6We8JhvjgmkUZMJrGPXKK26MLHN+NC4qWrv6eSiXyd2ni1MnKSzinHBBaUwaV5QHq1dWKpygjco1Ec9xkOP+I4GgEuZjYz4qtHXO0RP7nofdmPVWqntFP7sv3GnZyjJfn+NXQTxDOgvcQkU1IxS/VUam/DZ7y+R8GXiUqLCSzhY/P3UJn0uCQd/kpvOM5SGNbqe7+Okb4dcVVZhS4aJEzyBkAm9SAh4FAYsUU0UfKkIpRVjAQCL20lNZBxkZU+adqEDxJMPYTgq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 08:15:44.8697 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a7e338-2eed-4d04-3cf4-08deaa7e819a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8788
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=avihaih@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
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

VFIO_REPCOPY_INFO_REINIT is checked only during precopy, while the guest
is running. However, the switchover decision and guest stop are not
atomic, so a VFIO device may want to set VFIO_PRECOPY_INFO_REINIT and
request another switchover ACK in the gap after switchover decision has
been made but before the guest is stopped. This would be missed and may
increase downtime.

Solve this by checking if VFIO_PRECOPY_INFO_REINIT was set during that
gap, and request a new switchover-ack in the COMPLETE stage. Query
precopy info after vCPUs are stopped but before transitioning from
PRE_COPY state, when its valid to call the ioctl.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 hw/vfio/migration.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 6eb363d3f3..675560f1e0 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -915,7 +915,8 @@ static bool vfio_request_switchover_ack(enum MigSwitchoverAckRequestStage stage,
     if (stage == MIG_SWITCHOVER_ACK_REQUEST_STAGE_SETUP) {
         /* Precopy support implies switchover-ack is needed */
         return vfio_precopy_supported(vbasedev);
-    } else if (stage == MIG_SWITCHOVER_ACK_REQUEST_STAGE_PENDING_EXACT) {
+    } else if (stage == MIG_SWITCHOVER_ACK_REQUEST_STAGE_PENDING_EXACT ||
+               stage == MIG_SWITCHOVER_ACK_REQUEST_STAGE_COMPLETE) {
         request = migration->request_switchover_ack;
         migration->request_switchover_ack = false;
 
@@ -959,6 +960,26 @@ static const SaveVMHandlers savevm_vfio_handlers = {
 
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
@@ -972,6 +993,15 @@ static void vfio_vmstate_change_prepare(void *opaque, bool running,
                     VFIO_DEVICE_STATE_PRE_COPY_P2P :
                     VFIO_DEVICE_STATE_RUNNING_P2P;
 
+    if (migration->device_state == VFIO_DEVICE_STATE_PRE_COPY) {
+        /*
+         * Now that vCPUs are stopped, check if new init_bytes are available
+         * since switchover decision, to be reported in switchover-ack COMPLETE
+         * stage.
+         */
+        vfio_final_precopy_reinit_check(vbasedev);
+    }
+
     ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
     if (ret) {
         /*
-- 
2.40.1


