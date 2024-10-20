Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2605D3C930
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 13:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2VZ1-0002VF-4W; Sun, 20 Oct 2024 09:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1t2VYv-0002Ul-W3
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 09:01:40 -0400
Received: from mail-bn8nam12on20617.outbound.protection.outlook.com
 ([2a01:111:f403:2418::617]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1t2VYt-00060M-C2
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 09:01:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jyJUkzK2zyNhLy33GyVrAunhljvc8dWzyDU+B6BZrtIwGeWFZpSaq7XkxKoCQWejf2EK/uLELNlQndw8p0HQwDp6NWlYeX3zBVvuu/xDbePr0RGTBBMKZwvP/3BAxM/QLm/+SOgAORrPdc8qQ2CQn2y7W0xhQxmcUFlmL8ucBtiJZ4hI/Zfv4hTr3w95pIhkj0kN51UHT6BblD+rOcGzmn/CD0w96olGQ9a9tv/fIWH6t/eVPYUpejiIBNKh24G+T2FCmLFTUYei3L6GbrP3qPrGx+qRs70/3O8oDxoAkwqCRhn6FwFOfVdDunTUMozZgnP5sv2pBM/Qpg3n62YqnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Vpr2+RIpJhd1qrK09AxWT+0B7xyAWckQEeipR5LSu4=;
 b=YbCPQyn+AC5O9oX8+KUM1/2Jd+igvxoC+41ph4j3x8zNH8Lso2bHBoSTeyXTzMdP0EHnbJRnDrJjfAx4ix+QFP3nT2i2T+khTMcj3FUyU9zoz3NJ5T+8GdnNDi4g57poUfuRmisuLH+0KM91fAay0Lvucw230prOThkKW0q4YZhgq0xkef6mhfpnCRG+yFfDAaPNOGNwnZAsaPp7MpmS9IAbYHmW19pjv2Wdmx8J7gebuOhNgK0Uy11qz6OG6jll0oHL11psU5OhEIWXvu388xLZCU/rTnHCXUPnqWSYxzplzNE+W2qpzEYkSxvblmzQc4gdsPgJN12Lb9jBjyM1jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Vpr2+RIpJhd1qrK09AxWT+0B7xyAWckQEeipR5LSu4=;
 b=jiZ3H3HVf0oWVnL1cT2YhGbQheDYP+VtpKMgnXbxRybc/S4PEHViWXzAaCxKKBeMN+nsmQgZi0P45jz+ak6SBLrJZN207aAwBJpec+ZTMOoTiX59j9wamPiz8WSbg5Do9eT2rQnpvu6Kd7c1mov5R+Pzdn/1BCKtX8BnVBPEqaKmhhitue7h8E+ujVxpubYJgJX9JU16i6HA9qlwhN58fFezs3RsXBEFRs33aLcEvCIrp+p5fBTVKwl2N2aQrxZw5q8p0Y9hnPB0yzu7mRbvnCS342CSQAauh8Q3kr5S47rqWlI6AcW7ccSOhM9ogT7RjeFPDWJshc5k5QeN+1AZYQ==
Received: from BN9PR03CA0419.namprd03.prod.outlook.com (2603:10b6:408:111::34)
 by SN7PR12MB6672.namprd12.prod.outlook.com (2603:10b6:806:26c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Sun, 20 Oct
 2024 13:01:28 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:111:cafe::93) by BN9PR03CA0419.outlook.office365.com
 (2603:10b6:408:111::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26 via Frontend
 Transport; Sun, 20 Oct 2024 13:01:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Sun, 20 Oct 2024 13:01:27 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 20 Oct
 2024 06:01:16 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 20 Oct
 2024 06:01:15 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Sun, 20 Oct
 2024 06:01:14 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH 2/3] vfio/migration: Refactor vfio_vmstate_change/_prepare()
 error reporting
Date: Sun, 20 Oct 2024 16:01:07 +0300
Message-ID: <20241020130108.27148-3-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20241020130108.27148-1-avihaih@nvidia.com>
References: <20241020130108.27148-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|SN7PR12MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: aaee65a4-6fa3-4cb3-6436-08dcf1074f58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XepxD/NcfEeZ7416D9AezMpdCeDbzAhQ9EzUm36M13s4lsdptqGNfaNZo5+l?=
 =?us-ascii?Q?zsk9sA6+zYH8IL9UbdfidYGUg9B4Ujyh/KJNASz0P31V6mYNUpSxNxusYsyO?=
 =?us-ascii?Q?BxUZGX8bge0rJZ1YUgkuNx1kMNL/4xCGsbbtXY3YKEpC8pxKSFPXeZOXy1eK?=
 =?us-ascii?Q?5D+neb+Erkzn+QVZ3dNKg+TYo8U22U6zp5qP+d/+zw43NSDxhlPctAQDSXoj?=
 =?us-ascii?Q?EK7/kJ1Vj3O29jN9s8ncL9MqGAsGzKUNLFr1mjVhJjp5U/DyLQkUAK/E94aR?=
 =?us-ascii?Q?E0GsVp+me7/Pt1CnfQ9FWyJkrb5dxWdXPS+aA2kBQIn0SFyp6Cchn78XSOeH?=
 =?us-ascii?Q?rYynuZK6JvIYnxschouhVyxt0CRQRMd7AMMIETJuJ8l8FJJQ7SWAeynl3s8M?=
 =?us-ascii?Q?rMtKgbFsvTjq3sorR1IEsrlj29RJq/IeacLgIocLJs8XL24rS0hRXZ7ptocE?=
 =?us-ascii?Q?7EbWVBt0qIzp9a3CamOk1+GqbnkxHpyFNLbeVZ8dsBVov65ezVYXu3ceVcd0?=
 =?us-ascii?Q?NVqlfnRnUpZeJdXhtxFh6JboRNPY6DcIzw7O08WznRbbrO2ozA4vSDDLV0p5?=
 =?us-ascii?Q?1Ht92EYGGyMbzs5qAXVO0/ScT5HhPqxBQRWNBGQNBai5bwyAbFEZAm4ktjOR?=
 =?us-ascii?Q?LA16CXGEoDb+98h9OYbKUG21/6EfYh2gZ6tvnF0U4dR075LgzC2f5R4Z+evB?=
 =?us-ascii?Q?r+r+PWcYS4Vkm9xyfQA/E+1r+o+XvC4kZAROfpOp+EXEDqetw/qaaXUDcqCI?=
 =?us-ascii?Q?fZ5ZtCsAoaKnjhjc91HBreJ8crUmKeTl3BlRkT3IZW1cd/uAv7jqkTlacsQU?=
 =?us-ascii?Q?ynZRAvYi+YVM3Pl/u+1VrTTl5dIHwC7gj2rUQ3HKr5cumsIqKeCNqDmkMS4K?=
 =?us-ascii?Q?Bme5C5EgFbNN0BKDXk4kz1Vk135Xd/S1D7phcIkRxm23t3EdrmuNg2QTBmOi?=
 =?us-ascii?Q?iKMb4PwKazko5U5TeBrVOfZXicBW9EJG7tPinJeApVDKezHKmce6uz0oZvAI?=
 =?us-ascii?Q?UK2/+lZqo8t+bN8D073X87SL/UEOqcX132/zHDmUflIowCawpBK+BBjcVbqO?=
 =?us-ascii?Q?tLWm4DrlOzd/hAUvWw/Gq0bNQq8LhxiHpfnTvMDZT/y2CIcx00s/6eRngp00?=
 =?us-ascii?Q?KWRSFMetGju6qbFFM3O6ivgZTwqSLT8iGeg4BLakRV0XWBgdYlYliDt9A8v8?=
 =?us-ascii?Q?qV3iMvCnPp3pPTp1bC4d555TD1mZ0fbKoiZMu+ar3QsaH06lM0aPtrW6faHh?=
 =?us-ascii?Q?Dqig/2H0ET1qh1IuEkqyF2/1/LjrpWpHMX3bzCDMnkg4hYOkyOhSM8r00yts?=
 =?us-ascii?Q?5HmHV9bP9qpN+o+VJFklUA90XKJMBDqHt6Wf0pWk9lkIrmiDhoJG31i72Gcx?=
 =?us-ascii?Q?dSKQaKhEAtocajeTsRSvb0z8X5UnfnP+sA2yPT5lmEsOnwZMlQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2024 13:01:27.6150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaee65a4-6fa3-4cb3-6436-08dcf1074f58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6672
Received-SPF: softfail client-ip=2a01:111:f403:2418::617;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When the VM is shut down vfio_vmstate_change/_prepare() are called to
transition the VFIO device state to STOP. They are called after
migration_shutdown() and thus, by this time, the migration object is
already freed (more specifically, MigrationState->qemu_file_lock is
already destroyed).

In this case, if there is an error in vfio_vmstate_change/_prepare(), it
calls migration_file_set_error() which tries to lock the already
destroyed MigrationState->qemu_file_lock, leading to the following
assert:

  qemu-system-x86_64: ../util/qemu-thread-posix.c:92: qemu_mutex_lock_impl: Assertion `mutex->initialized' failed.

Fix this by not setting migration file error in the shut down flow.

Fixes: 20c64c8a51a4 ("migration: migration_file_set_error")
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 hw/vfio/migration.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 992dc3b102..1c44b036ea 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -783,6 +783,25 @@ static const SaveVMHandlers savevm_vfio_handlers = {
 
 /* ---------------------------------------------------------------------- */
 
+static void vfio_vmstate_change_error_report(int ret, Error *err,
+                                             RunState state)
+{
+    if (state == RUN_STATE_SHUTDOWN) {
+        /*
+         * If VM is being shut down, migration object might have already been
+         * freed, so just report the error.
+         */
+        error_report_err(err);
+        return;
+    }
+
+    /*
+     * Migration should be aborted in this case, but vm_state_notify()
+     * currently does not support reporting failures.
+     */
+    migration_file_set_error(ret, err);
+}
+
 static void vfio_vmstate_change_prepare(void *opaque, bool running,
                                         RunState state)
 {
@@ -798,11 +817,7 @@ static void vfio_vmstate_change_prepare(void *opaque, bool running,
 
     ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
     if (ret) {
-        /*
-         * Migration should be aborted in this case, but vm_state_notify()
-         * currently does not support reporting failures.
-         */
-        migration_file_set_error(ret, local_err);
+        vfio_vmstate_change_error_report(ret, local_err, state);
     }
 
     trace_vfio_vmstate_change_prepare(vbasedev->name, running,
@@ -829,11 +844,7 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
 
     ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
     if (ret) {
-        /*
-         * Migration should be aborted in this case, but vm_state_notify()
-         * currently does not support reporting failures.
-         */
-        migration_file_set_error(ret, local_err);
+        vfio_vmstate_change_error_report(ret, local_err, state);
     }
 
     trace_vfio_vmstate_change(vbasedev->name, running, RunState_str(state),
-- 
2.40.1


