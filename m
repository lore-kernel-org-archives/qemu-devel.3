Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFE9C44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgf7O-0003OR-Kr; Mon, 06 Jul 2026 04:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wgf73-0003BV-Gh
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:55:39 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wgf71-0007VT-Rt
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:55:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TgTS587mte4QpWFveIWBHpskSYikBzy2DKmwoGTS9gy9+aYxbtG3uCyumKnk9rEe7Npmj8KCgWyOrSC+JI7JsH67FSdSy+ZeU1PYkNr/eocWYQwr7Nq8it1pcwM59RHP3g/nNBRLM7xgKE5xRnQAs9AqHlAwJMciNvQUWmqi3iT0emD2GWQVF6D3/I4R0tb2n6dEnR04jsirsQBf93jtGv6HOvYl/1o4w2W/qQ+Z7SEV3VL8YMrgeHjhypEobY/W+Wj4mqb1x85/eJSp5Bi+/gboqF8tl7oBKAXTV/kS5jjON77SpT4XwKfI3se0601ai6p7kxDuY1dECP/Uwo8pew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIWs9OW0CLMJr81rb7LaWCbAYbbLBHoNbFiP+UUP1Vo=;
 b=XuZMM+5nlH8SAxfTATJWtf9bMnQ6Ei4xPu7uKVNIBGkJPcz1qKH62H/tLDsVqE4CeVMTtMI5qBg4vFH32IzIWQdv+FBsqXVCUcBAvqtXxtEmVb3zqdbnzSWOvnaQi90zFE2u8pHPckazqflhogWYoYxaqOIBluVMntPciLrGjt4l3Xgtiaih+nBUvYzJMzHLnslib5EFfEf/PAglq10GXmiY/hmOLjsk4lOU0jEeiJppXqj1RO+e0/PN0poZufKajCCjcCP6wqa9vml02dqhva8hf7S4NEmcuigbjf3guNwi2nb1cUFVPHH1MR7zs4wl9VHx6ceN85dWZOFEgjsM6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIWs9OW0CLMJr81rb7LaWCbAYbbLBHoNbFiP+UUP1Vo=;
 b=dwlc/AGyhKLjpmbCoNaVpLwj+D1BcjB/7HcvMRnHeTbtul3Y7ES//jtOjwU6GZkwmiy0SKJNHwnLC5jgshHXA16J4yVFcgNZ77SlzJc5125fIMcwLQ+IyAnZ4xrkrkc8av/TKBntuxIVjI1vIXSYtYtrrBhG2I3Q9JClBvofD9UIPV18nK9xl5xTbJW7Cb8UkcSQ/o2jnVzoVsGyH1qLViZq2DK8794VfS+KJ+HDUqLgauzuk71yTpl+Osy6x6+FaWEax2kSjTJ0p5A+jKYeurLWTytvq89UIRkqPVgTfajwyxCrGvRuMPOnDfpoc5htDejIncv2ORh8IFQZ25y+qg==
Received: from CH0PR03CA0074.namprd03.prod.outlook.com (2603:10b6:610:cc::19)
 by CH3PR12MB9218.namprd12.prod.outlook.com (2603:10b6:610:19f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 08:55:28 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::4c) by CH0PR03CA0074.outlook.office365.com
 (2603:10b6:610:cc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 08:55:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 08:55:28 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 01:55:13 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 01:55:05 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 6 Jul
 2026 01:54:59 -0700
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
 <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Lukas Straub
 <lukasstraub2@web.de>, Maor Gottlieb <maorg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH v5 13/16] vfio/migration: Check VFIO_PRECOPY_INFO_REINIT
 during switchover
Date: Mon, 6 Jul 2026 11:52:08 +0300
Message-ID: <20260706085211.13905-14-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260706085211.13905-1-avihaih@nvidia.com>
References: <20260706085211.13905-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|CH3PR12MB9218:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f76d309-8814-474f-d4ef-08dedb3c53ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|82310400026|1800799024|36860700016|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9+lDjTZi9c5sP27sD0qorXT8/sn5KCWG0UVQB5LSzxUE7o0704OO2Rgj9wgPqp0gRJGCTMSs4CTzO3IR0CSFz9gGTOBwKSjoaiJuhlSz7ZwElo+7JhON6GZCpCfNeuu99nvB3gyL+Vvc0JxyBQfbx+/PpG5ZR27DNHnFEOxPbC4ysJVAQFXVMfj7tPSD3jccHSXbG7HsBETC0IzF3eU0ivcC+A0Q+yQrz2ICfbWeKoT5zdm/1xmgZOOSP8FL0DQAdXfhRNGrrrY13tZREuWe7lcnPaCrjkg2zSOq/xI/5YnpLc+rnBqpYZ0qRuveoOVLI9cTq83eHMtyiWbnVQEPnjguIoKnYx3fHLhqbcJ0M4Hqf+boqyXe7jQ5x+T7JCO9WEogr50j3ZExZCsfU4Gp6QYkALYf2BrQVjMraJJW7DLt2H3euO8FTqZkes/mVQRMcV5lyR9Qdrz9A/9O6CVtA2G5kl8NiXOEsMaExOa7RORXPWu11MtkElmgEw9Cw1kVGA4vQjHqMLzdvn7FkzwCHdqVemLqu4uKAJnCsbDiRvLvI49DvxQPULDlFEfKQbz0que9fkc0xTLhrQoUcIotztQqya60LJRH1yLOkhyAMjHrH+6/cEzIsRqUd1sc6TZLphWDkknbPAm4+eFN+21JwxM0sOeWdoWFIgbM4WYCOHRLtxrE9DJgKfagEVGMLSIrflSu/aw0s1vQuH1xan01cg==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(82310400026)(1800799024)(36860700016)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ue6oXJYZw1v6UJEIxOcLeGzlBZCjXFLTYPIqucyolkzjhuZ7gOMT+EqD0oIPLkktEbuv6DMvxx8QipWM393+PYFXVTehxGuSdrsEm0z7C7kxYUFrstnzE6mvHliMFuMPZSH3llJkA5FfmAq26AGXeIAz16inQza/9laRL9VtC7ySXxf0Cg9NWcBfK41NVz2IrLcPaVVz80+jkWAQFO0DNSbu3XcwAnpCpp2Wb0Crpe07wH6M5L+Fl9QMLke1jG42h9dbyEfP3yZXkMnPFMucsHHw8mYOd72XtLeprLs/4tAaalWobx+DJUKBGOj5LK6pu3HNuTEhAKXnTeRzr2MWNjVHdCfyXIlwgiw4XtKvd7t0pwg3wk2cCHMvinYq+SpqqAraHonA1avrRiH2YPzBGhx7YHkD5bQhPgaStw+vjE04VHDUo9T0/nVliFTCEp/f
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 08:55:28.0025 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f76d309-8814-474f-d4ef-08dedb3c53ad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9218
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=avihaih@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
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


