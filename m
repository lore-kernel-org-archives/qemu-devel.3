Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771B3CD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 08:15:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKAwI-0001TM-Ou; Tue, 05 May 2026 04:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wKAwG-0001T2-Kh
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:15:32 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wKAwE-0006hy-WC
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:15:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOllNxXrtU+vDFy7Kx9/lsT4FOZ6kjGZabefP5mArd6sD/GY1GzO6HyqpX7Yu++H46QFQY4YxQ/Audhdxnof/cC4Al77g8XqpRUMPs2iWvG6DCfAMzRyGH+w4lSxYt7OGrL2iO3OH19RgD5rISPcTdKyE9vtmz0AZWWo6kqxZcKZA/a9tQli1YPML6c1L90+ryAU05DPZOQh94kI2vcjG/BfOReL/3u77KFwLAAomUKT4hfoYgClmvtoGm2K2Mw55VJYa3gibil+WHVXN7eVXGyqL7jm2IwtSx/aTrUqhvgP8x+jh2x1N9VsGsIyCi5g0TvMLcz2SnQYFQu8WOP3kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4rt2wWMvxPT1n3YN+tfie/nmLbDiC3hPslsI+UnDn8=;
 b=XhQsHZlS2olxhND/SX8Cq7zh8/aWmjYVnGlSdzqxgMZKEzylAnz54sw6pR5yBqxfT9jEp+AYy8/oXq3H8DqdC8K29jRYutfeBPDfX7l43ONveX66WlCIUYiM9ta5QF9mqOqHfPDciCC4lo4wTEpqlkttQzexzXO9DFiDGoLAysxPxfvFoeZYsMZNeIS0FXZJVhJsry7tw+Z0H9l0kZ868QEb1H8SYRO9/ac1Mnt06NbpFcep71Wq2ZubrkXUJfxHm3jXUbLnkjUwKsZt7YG2sQext2m9hb68Qqz72c2wwQeqwW6D8fHbaYt1w4CfLAKo9mTg8Wf5B7lGbVD+M1oswQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4rt2wWMvxPT1n3YN+tfie/nmLbDiC3hPslsI+UnDn8=;
 b=NdkTGUZgIWpicp/7AOK2EV/O8DOi4YoR8k9tXGdISyt3FEI84uBX5Am7SEa2DcNrMoYJ++XX5rcFQSGR3gLbKCUcv+6EfJz7KlA7Fm8lBovT+pQReeCSCtfqf0+MQ5R8BwjV/OHbXa9/FUa3lIuMFRSMOP6/R8De2USyxTfIoPO4qzcrPbcAIdDfNPA9c9r0RDtjCFWiGPpnxgOz2cB6U33a5yuoRhrDgMfuMSAOYeEFXOebdMdGAa/wOKJ7zF+jgqEwuObIW7zmFF8FQVlVS7mDlqInAfRA0+TYepfDUlzYjiNlvJFLxo+JTp7IMXpLHg/bEOJ+Lilr/ykYDR8nZQ==
Received: from PH7P220CA0179.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::27)
 by MN0PR12MB6002.namprd12.prod.outlook.com (2603:10b6:208:37e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 08:15:23 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:510:33b:cafe::d5) by PH7P220CA0179.outlook.office365.com
 (2603:10b6:510:33b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Tue,
 5 May 2026 08:15:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.1 via Frontend Transport; Tue, 5 May 2026 08:15:22 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 01:15:04 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 01:15:04 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 5 May
 2026 01:15:00 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Zhao Liu
 <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH 09/14] vfio/migration: Re-query precopy size before sending
 VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
Date: Tue, 5 May 2026 11:14:18 +0300
Message-ID: <20260505081423.28326-10-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260505081423.28326-1-avihaih@nvidia.com>
References: <20260505081423.28326-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|MN0PR12MB6002:EE_
X-MS-Office365-Filtering-Correlation-Id: fdb5d4f2-f421-4188-c67a-08deaa7e7428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: ST4yKjINOiaRCmXz+b8Fy/yCpGFGSTzmGbjc+P6wM0YF+9i+xEXMQ4cZJtce5CNKzKjap8oNeqT60qyabRkZ/BMyTyq944ldZUz6GwypcNOOSR7D6K8ybWHkPgZUpbi2TJRB/00JshljNCriBrr4GsS5nsqm2ZeSuLiZABpL5dYIOOzmLOp4EQsJKqy+x0cPDhX5BmV7xm+mzjFJ+4L+8XgfTnLxfYQaz397JxdHhCJtCBFK378aXh9z6pygshvgpEQ/jBHgEr7T8wJvo5hjytdaAQ9u3Jk0YJtTf10bAWZFO7w1Mx8ji1Ym9axnU1QlCkdbaeO2kJfBc6l8bKtouSKOE6f6SwYpsdd8PBPnk6gvWQSnvCMXC35oFg7E+S6YR33/lW/eAwe+dMTBpOXqUN1DL/s7Sar9TFebmmdSfey/sfVgw3ub4HxaEoWuIrQubX2rIWbKHESDIDdG73yIsuwakSlAlPpCgy+vcm5GbC2ADR5h9wo0BB1mcEEXUTGaEVH7SDMlm/mZ5WJvI5gxiZ/fLKjMrUK83L2N+9F34zdgxAO+ayvqiqGiogjdEfrZ3wrr+epzZfFfyToEaq3WIP8+XPuN0zCHmopLEIf6bRJGlv8kcFVn89+XWmtVPAOFUsKQf3FIhyRFsNxTXhvbpEGaxkDW3Tl843zoNiEfrsb5OmBo9TOVMD8QyA7MOOWSDIdwtDOUy6qAf0fQd9ExEh51xsx2q1bEtRJy14lp6fM=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(7416014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RSCe/UDvfXcQgvjcnQC2sY8EDJUZAC9tedtE6VLChcJWY5FUy/ONBQWI50o7EKL+mb67lc3jTOtTrjB4tlTh+jRSFbq+WDIpl/KzHTmJQZOLip2CoX3ZT7tzMHOZ/QMX+BRsFWva8mRDrR+GKlkG3RfHkeaHgIZgzciy8Ugsirf477lp4PAoHsiAh8e16DAFYOdRh4N5Y2Txy6a/a1OXjtDJOXSEPhJ6uunYHPhtrcpNXJZMa1GaViWiKcjDpHCDFctFdWeFhwJz3+w0uOeNc3JQ/OyTuf8JV/ITK6RkPqZI7MlTOSQE0WNM0r2G2DuSFpl2NCTJyJjzKJ60qhb7TqsevWuFKPNl8Veu/5oZcM7yen1SKAximffhWNgl4e/H/1xW9EsOoGGKE/hubkKdGM/G8/enZZ/M+UMcOsX5IJ9ycY16RNr2YKCeXnfllG/V
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 08:15:22.3360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb5d4f2-f421-4188-c67a-08deaa7e7428
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6002
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=avihaih@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
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

When precopy initial_bytes reaches zero VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
flag is sent to the destination to indicate that initial data has been
sent, so destination can indicate back to source when it finished
loading it.

To get a more accurate estimation of initial_bytes, re-query precopy
size before sending the flag. Extract the flag sending logic from
vfio_save_iterate() to a new helper for clarity.

This may prevent premature sending of VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
flag if, for example, the previously queried initial_bytes was lower
than actually is. Additionally, it prevents sending the flag if
vfio_query_precopy_size() failed.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 hw/vfio/migration.c  | 37 ++++++++++++++++++++++++++++++++-----
 hw/vfio/trace-events |  1 +
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 2911583ee1..243624b5fe 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -456,6 +456,37 @@ static void vfio_update_estimated_pending_data(VFIOMigration *migration,
                                          data_size);
 }
 
+/* Returns true if the init data flag was sent, false otherwise */
+static bool vfio_send_init_data_flag(QEMUFile *f, VFIOMigration *migration)
+{
+    VFIODevice *vbasedev = migration->vbasedev;
+    int ret;
+
+    if (!migrate_switchover_ack()) {
+        return false;
+    }
+
+    if (migration->precopy_init_size || migration->initial_data_sent) {
+        return false;
+    }
+
+    /*
+     * precopy_init_size holds an estimation of the initial data size, re-query
+     * precopy size to ensure it's really zero before sending init data flag.
+     * Don't send the flag if query fails.
+     */
+    ret = vfio_query_precopy_size(migration);
+    if (ret || migration->precopy_init_size) {
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
@@ -664,11 +695,7 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
 
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
index ab27ff5ea2..e91858354c 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -176,6 +176,7 @@ vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy
 vfio_save_iterate_start(const char *name) " (%s)"
 vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer size %"PRIu64
 vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size, bool exact) " (%s) stopcopy size %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64 " exact %d"
+vfio_send_init_data_flag(const char *name) " (%s)"
 vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
 vfio_vmstate_change_prepare(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
 
-- 
2.40.1


