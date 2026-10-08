Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48794CA6007
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 04:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEfNK-0006B7-DF; Thu, 08 Oct 2026 00:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pshit@nvidia.com>) id 1xEeC5-0003Vv-JM
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 22:49:17 -0400
Received: from mail-westcentralusazon11013046.outbound.protection.outlook.com
 ([40.93.201.46] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pshit@nvidia.com>) id 1xEeC3-0001d1-Ki
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 22:49:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EkCCaApREW30RqphTGMptiJhy0tW/6aa3bIb4zzbDf7ac5PlBpS+xtVmDphhjUA3qpqb9oiAN+FZGDEeLsFIlsQlTEhgbAMaESdQvDSTzkadYgtG3zKTkl5U5YCTNcIjDpYlIW9y0xyTCzeGSYma45zl2pK3LYGXEDeYdHgV8RWhzBzRqi092dEGF5HfZmW1iS7N88wMrw5n1I2L5mVIaxPB4kOykv0NGwAYGlpnx1SPieHp8NOcEmazfxX7MpnNd00kScv2NEFdFsO0FyjYsT013E3XAOdwSxr6mu8r4fpeOBZfXAm3Rczfyi+dmmMeX9e38PhmcAZn4FD136tYhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZCyLUTYDPXcaLpz6waLPVVOCUPg154tg/O2asMh5fA=;
 b=f+nPHsFxPPliir8aMIISY1VkphuZ1+9nNv2FSN1s+3WFezZYm5KseQNxWEqknSNN94O6MhalGl6tveyMRqHgvCmFJ30JS5PrmY52T7hcoiH0lTX56Qrmfq+INq5vQNnjg3l3RF/PSYm4ZrWOQalnGMRUFujeqy1VO6oYNmypyvZTwOFW7MggCoqd3pysTkWXkaw4kyhxzcsMqfLnRfcKxWJRBYIXyn/A8+RG5/LuELX5GGUMMxNf5H1ACExiNchu3a8QKjXnjemTGj3u/fd1a8dHoMPdAbOtTIdaFSRXlfupQo9KlfqFpPyNNFk4cxredJk21vNpVy1Kuu7ETWNnBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZCyLUTYDPXcaLpz6waLPVVOCUPg154tg/O2asMh5fA=;
 b=TLjssVoTbPv1+g50bkg7YBm6skKkH40qmH+KdEN9czUBSaWWBJC2kzYWW7CO4R8nAEncZPAzd+sR0LpKndtzE7EHZsQ2eaA84s9WxlmA+pnBXGMRX5ErgLtRJHtlOJcxyniOURM4lAd08rrf12d+Y6fy1RdypDVgBXm5/ahpkZY1GgS83/dacqaWTbOUdwyC7EBuwip2y0R4BVOkA6bvqWf+//0N+xDaAZfs6V/3BwDBf4n4F4Uj4jt/uRv5TaH4QNjYR7cmkqeB37oPMsXpSDUDaPe/HftD8C6QrCcAURwxCSe7wCu1vzvocuzqtWRsijUD4PWOvY1Q97QRGCcxRw==
Received: from CH2PR10CA0011.namprd10.prod.outlook.com (2603:10b6:610:4c::21)
 by CY5PR12MB6033.namprd12.prod.outlook.com (2603:10b6:930:2f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 02:44:06 +0000
Received: from BN5PEPF00046988.namprd02.prod.outlook.com
 (2603:10b6:610:4c:cafe::1d) by CH2PR10CA0011.outlook.office365.com
 (2603:10b6:610:4c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Thu, 8
 Oct 2026 02:44:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN5PEPF00046988.mail.protection.outlook.com (10.167.245.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Thu, 8 Oct 2026 02:44:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 19:43:47 -0700
Received: from pankaj.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 19:43:44 -0700
From: Pankaj Kumar <pshit@nvidia.com>
To: <alex@shazbot.org>, <clg@redhat.com>
CC: <qemu-devel@nongnu.org>, <pshit@nvidia.com>, <pmohite@nvidia.com>,
 <dnigam@nvidia.com>, <avihaih@nvidia.com>, <alwilliamson@nvidia.com>
Subject: [PATCH] vfio/migration: Don't reset a device on a declined stop
 transition
Date: Thu, 8 Oct 2026 08:13:29 +0530
Message-ID: <20261008024329.1996536-1-pshit@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF00046988:EE_|CY5PR12MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: 61f914ac-1c49-471e-1410-08df24e605a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|6133799003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: C8wZJdA0suiRJTaYdX9oO1xC8Ig3YkkrAp20nT4N81VNYJUjJ5ixAdiKhF9AwXNoNWxZC2wam1POVeyy8ftCWiJnwiRFhIcv1Q+I2/E9cj7FBIDNqj69MXo6iyjHT55/jfvz9nhmMDjfWZ15b2AfH/GvKPM/YfRONqBQ7fDWax4XKBUwu2pAZTnH0dBt/DV8mZ3KL2ASUSupFHiZwuXGz+zRlW5Z36X7PGCRBwKdBMQPW3/vlG1jkZCo3CqgxruUu3cAql/htmdknMc8WI0S2BhZI4186YaxzFgnvOeMPYApiUbzcsZZfSVoFTZ5xCBYjK07xG2H6HWkUwArNKmC1g69iEHvTEQ50/gmwMGRPju7iqeRkzYVthC/dh77l0/rRR1VIjzSBiGWOt1qLdfU7eD+DHTYu4qh5HAW8SFI33zBauA5+jIAw7cF/tmULJPVfxYwgAaR30SRQqfIqITfEt/yq33r5U/99oTDG/CthX/2kKe3z8j+rm7r8bGmciPUvxLcowseHLsSqiZ2x2+3wuAFJS4L8bRhEZ+K9HV79v/d5WuEVGjt1sMqLeDphJsCgyqwO3sRH//Qy7XTO5NDgquO+Ix08y2v67BTCFcshDZ3YdIVQbneH9Vf+qdF5SgXoVCgvdLwfGtzrKsNUzrGB8og8E0wBcLIhIjxOife1hS8DrGI2fSMMR0XgmmYYxPpuyk5nFDt+NBZ0H21a5ElWQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(6133799003)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JbvCDtUh+SI3ahHbstQTkFl1+boTd4BOloDQAL1VRvfvWH226xFW/LNzAC2U+BOSIWxUlbbA509LqwqYln/AmGb6G4aZEZDRJvUSXP0sMF1cYY6EQbi+ouyL0FPJrYN3E09VeHnS72WVMvpQVIsTl7KdfISaxiASMfVh6NLs5h3heGGNLxfOhZDvjKfhiAo/PiCrku++x8kiggWQaKtC8EkDH/S/E7auNr2gaTyrujHkZ625qCSBlPz6jy0OQRiUnsSykw0GovazC+KPUoc4P1Z7RqB94H8748dy2TAEXiTh5/uif4zxe7UiJd2YP/4vjfgUJzN27UmjcNsXFMM2k0ZC6lVykR3JfWaE8C71+doigvkkNezuy5cdtRFZFB0Aqwhy74rrGmq11pwF7twyLOGDNfuBALR/ExT3gUwL/BhcRIIjzIHH2XrWF9j+i8C0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 02:44:06.3916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f914ac-1c49-471e-1410-08df24e605a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN5PEPF00046988.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6033
Received-SPF: permerror client-ip=40.93.201.46; envelope-from=pshit@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 08 Oct 2026 00:04:50 -0400
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
trigger a reset:

 - vfio_vmstate_change() and vfio_vmstate_change_prepare() recover to the
   current device state for the stop direction. The resume direction keeps
   ERROR as the recover state, since a device that cannot resume is genuinely
   broken.

 - vfio_save_complete_precopy() recovers to the current device state rather
   than STOP. If it runs after an earlier stop was declined (the device still
   in a running state), the stop-copy attempt is then rolled back instead of
   resetting the device.

This lets vendor drivers decline a stop as a matter of policy without losing
the guest, and lets such drivers drop their own workarounds that swallowed the
spurious reset.

Signed-off-by: Pankaj Kumar <pshit@nvidia.com>
Reviewed-by: Avihai Horon <avihaih@nvidia.com>
---
 hw/vfio/migration.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 73c49d8c24..4a98afa7c2 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -771,9 +771,16 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
 
     trace_vfio_save_complete_precopy_start(vbasedev->name);
 
-    /* We reach here with device state STOP or STOP_COPY only */
+    /*
+     * We normally reach here with the device in STOP or STOP_COPY. However, if
+     * an earlier stop transition was declined by the device, it may still be in
+     * a running state. Recover to the current device state rather than STOP, so
+     * a device that declines the stop-copy transition is rolled back to its
+     * current state instead of being reset out from under the guest.
+     */
     ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
-                                   VFIO_DEVICE_STATE_STOP, &local_err);
+                                   vbasedev->migration->device_state,
+                                   &local_err);
     if (ret) {
         error_report_err(local_err);
         return ret;
@@ -993,6 +1000,7 @@ static void vfio_vmstate_change_prepare(void *opaque, bool running,
     VFIODevice *vbasedev = opaque;
     VFIOMigration *migration = vbasedev->migration;
     enum vfio_device_mig_state new_state;
+    enum vfio_device_mig_state recover_state;
     Error *local_err = NULL;
     int ret;
 
@@ -1009,7 +1017,15 @@ static void vfio_vmstate_change_prepare(void *opaque, bool running,
         vfio_final_precopy_reinit_check(vbasedev);
     }
 
-    ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
+    /*
+     * If the device declines a stop-direction transition, roll it back to its
+     * current state instead of resetting it out from under the guest. On resume
+     * (running), a device that cannot transition is genuinely broken, so reset
+     * it by using ERROR as the recover state.
+     */
+    recover_state = running ? VFIO_DEVICE_STATE_ERROR : migration->device_state;
+    ret = vfio_migration_set_state(vbasedev, new_state, recover_state,
+                                   &local_err);
     if (ret) {
         /*
          * Migration should be aborted in this case, but vm_state_notify()
@@ -1026,21 +1042,34 @@ static void vfio_vmstate_change_prepare(void *opaque, bool running,
 static void vfio_vmstate_change(void *opaque, bool running, RunState state)
 {
     VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
     enum vfio_device_mig_state new_state;
+    enum vfio_device_mig_state recover_state;
     Error *local_err = NULL;
     int ret;
 
     if (running) {
         new_state = VFIO_DEVICE_STATE_RUNNING;
+        /*
+         * If the device fails to resume, it is genuinely broken, so reset it
+         * by using ERROR as the recover state.
+         */
+        recover_state = VFIO_DEVICE_STATE_ERROR;
     } else {
         new_state =
             (vfio_device_state_is_precopy(vbasedev) &&
              (state == RUN_STATE_FINISH_MIGRATE || state == RUN_STATE_PAUSED)) ?
                 VFIO_DEVICE_STATE_STOP_COPY :
                 VFIO_DEVICE_STATE_STOP;
+        /*
+         * A device may decline to stop (e.g. it is busy). Roll it back to its
+         * current state rather than resetting it out from under the guest.
+         */
+        recover_state = migration->device_state;
     }
 
-    ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
+    ret = vfio_migration_set_state(vbasedev, new_state, recover_state,
+                                   &local_err);
     if (ret) {
         /*
          * Migration should be aborted in this case, but vm_state_notify()
-- 
2.25.1


