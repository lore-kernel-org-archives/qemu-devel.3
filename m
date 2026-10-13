Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C34CCC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 04:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGUTf-0004qA-2g; Tue, 13 Oct 2026 00:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pshit@nvidia.com>) id 1xGUTd-0004q2-Kh
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 00:51:01 -0400
Received: from mail-westcentralusazon11013019.outbound.protection.outlook.com
 ([40.93.201.19] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pshit@nvidia.com>) id 1xGUTb-0004Ip-Jk
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 00:51:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQ9g4GWiRv8W/no6vv4rgK8NvpRfSN9GWwUw5w8zZIMdDKRQDlvseAixWxJZzPF1Zmt2kwZcwoNVpF29xKtWk1uIBIY5JHMBHsAV6mhEjOJrq4PRSVbUS/KYJZlbQZs6x0lSa2rNaWH0m6opwePI6cJmPzxNJdhvPmXE1CnmHWMD3RU4XyLwS+n85VJJaAokoaR3w6xaRqu/VrnfeDv4wOlLhdIHhpgen/PatwET7M/2ktEvlyMX2i2DAPCqhFOh7OZN8V7jyrJ/r2o6+lPIhzIIOC9WfbulzBYmxyUEYLuYDBI0ORMUWskpc/llbYhOGp1KYcyPR4Z4PAJuMJg86w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1OOQtfWgK2MeIu2ro0hSgRoEj04+uc4AxfRz6yzZ0E=;
 b=rrCH0eStt1HupE4ZFsowIG8t1BHDWB/LWhxQp0221FBgBUBUner5y+C7oR80W0dpSSFe2wT8QZgon2iwdozFEl/Y2P25DDzuYGE5XPGjo4LJtgXERQCDedzuZAt6uWypNHsbDQEBEjUuKgl5BKGlPo5wprQlogkPbKkp7nsdjMPcnyc6ejMkdmt53g1LSPVVjHAEJQ9Ubqan6jJR96WlMsS+FjIybTxMab1akj//ftat0W1M4npSYidCZZXRctyDoGpxh7c7BmVJrInb9wLNAS8MCa/3+53W/umEf1P1lrp3ffE3lPZ4lJCbg82D5eKlj7R4e9jJvSWgqcgElCb6iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1OOQtfWgK2MeIu2ro0hSgRoEj04+uc4AxfRz6yzZ0E=;
 b=mDgdm/vqNLojFZYpwbej2Rqb/CdzKjChZcDkXfgRl2QHfvWghorWHvgbNHu9pJ5LUXOkWy3zHSfmlCexr3ZLu5ulS9AuI8lfyMrGnaALk9eUs4G5rg83AgE6V7gTpYpMv9QU2RH1G8xsvqw2ECt4ZhS6vbtF7BZLyY1qojtEDqfftRLmefrBvp/OMyHuRqdbpiBk7kOMGypRS0V2WkSJf5hBhJdja5yOKopKzwq6eC+r9VvqNC5phI13I5h6VDdtIITqoaUhPSlNtOQhmLrT/WyDJWG6s74wPGALL8hG43lXZ/eInpDuyRVehLmMRvFW9c3RysR4mfqsvdDgXAv5TA==
Received: from MW4PR03CA0164.namprd03.prod.outlook.com (2603:10b6:303:8d::19)
 by DS0PR12MB503760.namprd12.prod.outlook.com (2603:10b6:8:4ec::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 04:45:53 +0000
Received: from MWH0EPF000C6189.namprd02.prod.outlook.com
 (2603:10b6:303:8d:cafe::4a) by MW4PR03CA0164.outlook.office365.com
 (2603:10b6:303:8d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 04:45:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6189.mail.protection.outlook.com (10.167.249.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 04:45:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 12 Oct
 2026 21:45:37 -0700
Received: from pankaj.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 12 Oct
 2026 21:45:33 -0700
From: Pankaj Kumar <pshit@nvidia.com>
To: <alex@shazbot.org>, <clg@redhat.com>
CC: <qemu-devel@nongnu.org>, <pshit@nvidia.com>, <pmohite@nvidia.com>,
 <dnigam@nvidia.com>, <avihaih@nvidia.com>, <alwilliamson@nvidia.com>,
 <smitra@nvidia.com>, <kwankhede@nvidia.com>, <vkale@nvidia.com>,
 <targupta@nvidia.com>
Subject: [PATCH v2] vfio/migration: Don't reset a device on a declined stop
 transition
Date: Tue, 13 Oct 2026 10:15:20 +0530
Message-ID: <20261013044520.2439021-1-pshit@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261008024329.1996536-1-pshit@nvidia.com>
References: <20261008024329.1996536-1-pshit@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6189:EE_|DS0PR12MB503760:EE_
X-MS-Office365-Filtering-Correlation-Id: 571934f5-1eea-44ac-6e5f-08df28e4dd0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|6133799003|18002099003|22082099003|10067099003|13003099007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 9oGvB8iaeqyIw7nBmDED1dLJf+4bzm/KHW1wKjjxbqhtoKGHHj0i8dlImh22TeDh3XAbUe3TLbKzulNHzS5wTNmbkfL2BGR7EXOZw/d2xeF+dnIMvB2T91LKcxiBLoczXtnZPIHZoMpH3vyNHmL/JO0OsqPCmV81ZppUK2hdX/CPux8fVxLylzzO6wHwJu77hR3+IwhcrXQv17vvKdehTaHldh6EU5JliqBmGKBS6JcCTQadArzdthRG8qOjmDDxzc0AyeSsvVkYSGsKOR0ZWgdoqtm+iBz0MIgsiMiaU7GdnPpiKaQDnAp7lV7J2gu2ysprG8fVHk6XEPBMS0PfA0pZQAN5hS4NGg7o0MpTV0Zdclxd3frRimG/Fpr4MrZZ2+K9vcgZNnq0NCTyHJFWYIp66mdY88qhDZjmgZUlBBxXBYQ1T+kHI1BNhfIrGWLhebba/xqOWvAFyOSeKVkGInDldb8YfhfOnPgYzsO3ZcqDdLkilZcd1X+SkfsU+SgkG/O+RDX9BF/NdjyHerYagU/kWzCbzX6Nbns2JVS4lQpa69CIxGjfMBLwwZDS//eJdamA3LsJ3JnTryDn34otHXfmzittarJTdsMvf2QLoDOac9qUD1G1RDi8vCGEB9ujE+yCkHR8G9BSV01KLYhDIPU2dVLVOAAkAvs6A4joU+qRE4+Et4eMajKq4vuMs9kVSSSq3f5hPTrDc7/bQ+NZiA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(10067099003)(13003099007)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: D2/hD4dQamqBDGdmFUzM5mckzLYL5lc8GfDyHaXsDrOiTkAXKbpMYAWZDbT9VTPlorM0iOpV8OVjM1brf6gO3PDuqCCyqRYzAfpMXy6kp99bN8pROHSXjz2PVV1nnlA2+5PeP0NK3smFxM0VaL+yK3UFQr7h59w2TVomLIwjcWzmd0Gfe0piWe2ZAn29Ir4NWo8u9VVe73e9Y/WppvJN+lxwpBeOmxTIs1Ed3W5q5YvrRlNKW9qvEDWXKonNp5z2VCUI3UE07DplX4ERqeu/qo8I1qPW4FQaNX2+BUxyZGQbMiquIIbxkmSGb1hTn8nXctqbjCGOLCxBvzF2qUr3gU4KZ1ngbXlM0Yapzpcs8oVCoyRBj8U15NI34vymJzH5dwi4ZpB0VKtFwnki0pClzVJ2ZOvbWbfwUISbn/E1zKrEtvQvvKvUedkY35VRiNn+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 04:45:53.5091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 571934f5-1eea-44ac-6e5f-08df28e4dd0a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6189.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB503760
Received-SPF: permerror client-ip=40.93.201.19; envelope-from=pshit@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

QEMU resets a VFIO device whenever a migration state transition it requests
fails. This is done by vfio_migration_set_state_or_reset(), which passes
VFIO_DEVICE_STATE_ERROR as the recover state, forcing an immediate
VFIO_DEVICE_RESET.

However, a device may legitimately decline a state transition, e.g. a vGPU
that refuses to stop while a profiling/debug session is active in the guest.
Such a device is still healthy and running the guest, so resetting it destroys
a perfectly good VM.

Instead of resetting on a declined stop, recover the device to its current
state. The current device state is always a valid, already-reached state, so
recovering to it is effectively a no-op transition that cannot itself fail and
trigger a reset.

Introduce a helper, vfio_migration_set_state_or_recover(), that selects the
recover state based on the transition direction, and route the vmstate change
and save-completion paths through it:

 - vfio_vmstate_change() and vfio_vmstate_change_prepare() recover to the
   current device state for the stop direction. The resume direction keeps
   ERROR as the recover state, since a device that cannot resume is genuinely
   broken.

 - vfio_save_complete_precopy() recovers to the current device state rather
   than STOP. If it runs after an earlier stop was declined (the device still
   in a running state), the stop-copy attempt is then rolled back instead of
   resetting the device.

The existing vfio_migration_set_state_or_reset() is retained for the paths
that must still reset on failure (save cleanup and the migration-failed
notifier).

This lets vendor drivers decline a stop as a matter of policy without losing
the guest, and lets such drivers drop their own workarounds that swallowed the
spurious reset.

Signed-off-by: Pankaj Kumar <pshit@nvidia.com>
---
v2:
 - Introduce a vfio_migration_set_state_or_recover() helper that selects the
   recover state by transition direction, and route all three call sites
   through it instead of open-coding the recover-state selection (Cédric).
 - Keep vfio_migration_set_state_or_reset() for the paths that must still
   reset on failure (save cleanup and the migration-failed notifier).

v1: https://lore.kernel.org/qemu-devel/20261008024329.1996536-1-pshit@nvidia.com/

 hw/vfio/migration.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 73c49d8c24..69d50cebdd 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -246,6 +246,25 @@ vfio_migration_set_state_or_reset(VFIODevice *vbasedev,
                                     VFIO_DEVICE_STATE_ERROR, errp);
 }
 
+/*
+ * On a stop-direction transition failure, recover the device to its current
+ * state instead of resetting it: the current state is valid and already
+ * reached, so recovering to it is effectively a no-op that cannot itself fail.
+ * On a resume-direction (running) failure, the device is genuinely broken, so
+ * reset it by using ERROR as the recover state.
+ */
+static int
+vfio_migration_set_state_or_recover(VFIODevice *vbasedev,
+                                    enum vfio_device_mig_state new_state,
+                                    bool running, Error **errp)
+{
+    VFIOMigration *migration = vbasedev->migration;
+    enum vfio_device_mig_state recover_state =
+        running ? VFIO_DEVICE_STATE_ERROR : migration->device_state;
+
+    return vfio_migration_set_state(vbasedev, new_state, recover_state, errp);
+}
+
 static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
                             uint64_t data_size)
 {
@@ -771,9 +790,16 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
 
     trace_vfio_save_complete_precopy_start(vbasedev->name);
 
-    /* We reach here with device state STOP or STOP_COPY only */
-    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
-                                   VFIO_DEVICE_STATE_STOP, &local_err);
+    /*
+     * We normally reach here with the device in STOP or STOP_COPY. However, if
+     * an earlier stop transition was declined by the device, it may still be in
+     * a running state. Recover to the current device state rather than STOP, so
+     * a device that declines the stop-copy transition is rolled back to its
+     * current state instead of being reset out from under the guest.
+     */
+    ret = vfio_migration_set_state_or_recover(vbasedev,
+                                              VFIO_DEVICE_STATE_STOP_COPY,
+                                              false, &local_err);
     if (ret) {
         error_report_err(local_err);
         return ret;
@@ -1009,7 +1035,8 @@ static void vfio_vmstate_change_prepare(void *opaque, bool running,
         vfio_final_precopy_reinit_check(vbasedev);
     }
 
-    ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
+    ret = vfio_migration_set_state_or_recover(vbasedev, new_state, running,
+                                              &local_err);
     if (ret) {
         /*
          * Migration should be aborted in this case, but vm_state_notify()
@@ -1040,7 +1067,8 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
                 VFIO_DEVICE_STATE_STOP;
     }
 
-    ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
+    ret = vfio_migration_set_state_or_recover(vbasedev, new_state, running,
+                                              &local_err);
     if (ret) {
         /*
          * Migration should be aborted in this case, but vm_state_notify()
-- 
2.25.1


