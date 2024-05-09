Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C06C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 09:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4znT-0004oW-PY; Thu, 09 May 2024 05:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s4znS-0004o9-7F
 for qemu-devel@nongnu.org; Thu, 09 May 2024 05:10:38 -0400
Received: from mail-bn1nam02on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2407::601]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s4znM-0003T4-PR
 for qemu-devel@nongnu.org; Thu, 09 May 2024 05:10:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdaySpgfM8n/vem47ABvCq8sBwiU47Lf1ksQ/Qt/Z8TggYumdNlYteQoXi4tQEzOGIM7CJ+Mfujjc6y8Kt88cVLJ26AoEIi0pEq1eD8zvdRocT7SgR7WZwVurNzATHN+boFEvDjMWEsHwUdsrcp+hgrJut/82Rp0AD0ykTrAukK9PninXdAXLT4j0TG+2mA+/+vT6pA5ut23f7SIpKEuP0BepIphbpuCY1z4QSuuY/lgWCZeQYe9SMTrjiJbZUFJavr0Teh5IqaUrgeGYiEve66eI0/DPtZlNEtSyx/CwTFJM9qmCgEdiT4R6V31QAFIWF3oJasxy7X49aVpyGsCzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lWyV9quOOxfAeWLQKjuqBfvQRwQ9aN5eUYcsXLYsjY=;
 b=MkG+Nld3bVvTCxETiN/4JZuj29++B5CJGVEBf7gcuhSP9CcKeAjI+N2J5dtit/nAap2/FgqTCcRc1D2iMfMZ3JG4HbxcQScdCPUCKZ3L0kXuy4VuyAHOxXgj6YNDMF/H54LvTlZQaEFOnYNo16fmRI9/oCg7iJc3JHjI+UDbkSZh3mSypf6+IOWruSi/se71OUD4FylQL1AgmaHy6QBWH5gi/+QXJjFvKqNSXRbWSdI51L2cPdJGNjcBcCNm5DwfGzySIoZ0j7mFSOEepy8KJgTR+VvJ+K5rAlgu/k0AJhcI7nPOJrulOWEmnVEOoYUURm5NmH+bzYd6wsrkvkzhSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lWyV9quOOxfAeWLQKjuqBfvQRwQ9aN5eUYcsXLYsjY=;
 b=nvpD710oqYo86fdZ8LIZVZrBd45Q4FctltSLq5ZMFHnE2QYE51IoSOFDRKXXaTanAqtBVA/fT/rMS4u9hetB8YFidaGQLr3QqzKq3dZRn2ws0Raodihh/XbBMPA4XUd6txV7gWGE87uiTB7Oy2g5cQTNiFiEdsXWlD0zRsM7Q2cW27119bHGGXfQT3pNAmdbQm9CeKuK5HOLVgAal74fOxgMq7SzJKKdySCZo7Krn3Hp40uZGKYosAONp5HCP8Dy/SKUZqGZ2WRM8x0e+iKk8eTX1ClDIpX10TzeTktXzS040efZMBCHtX/AncOP0LVdfi5v9uEMlGMX/pJpJKwL3w==
Received: from BL1PR13CA0143.namprd13.prod.outlook.com (2603:10b6:208:2bb::28)
 by SN7PR12MB7021.namprd12.prod.outlook.com (2603:10b6:806:262::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 09:10:28 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:2bb:cafe::f3) by BL1PR13CA0143.outlook.office365.com
 (2603:10b6:208:2bb::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Thu, 9 May 2024 09:10:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 09:10:28 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 May 2024
 02:10:09 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 May 2024
 02:10:08 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 9 May
 2024 02:10:05 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, Eric Blake
 <eblake@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH v2 3/3] vfio/migration: Don't emit STOP_COPY VFIO migration
 QAPI event twice
Date: Thu, 9 May 2024 12:09:54 +0300
Message-ID: <20240509090954.16447-4-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240509090954.16447-1-avihaih@nvidia.com>
References: <20240509090954.16447-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|SN7PR12MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: 535c83ff-2185-424a-f053-08dc7007dea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NvohWKiYDR00GrllSuiXfK4OQw0wLXoMuWQlc9a/s4gy5hhclWxWm6K7Gxl8?=
 =?us-ascii?Q?h1P4k84qjlR4fwFLNiyr7SN8ThqhnMcr96FEkGdlnlfUcDxu2xeza5MXC5Wa?=
 =?us-ascii?Q?XBR6mAeOKm2K7zKywLewvrbFP6/4fH+VZOUtqVUgWa3h780wy+OZ0o0DGFP7?=
 =?us-ascii?Q?t801fW2zOGRFraRrlu3wtNpZUQctHxki+62e7w8ogbtdAstn2rkNLktJHBmI?=
 =?us-ascii?Q?8q8xaQIDTsCfCcuD0YqHm/POYBJmkCFXdGoFTwl/xjShWa2eCQwBDxWU9SUV?=
 =?us-ascii?Q?zCnzJHyYfdQnHCwQAi2Vy36cPDZyq57DUXnL/ivh4rAXEO6TSTROeMxaf21e?=
 =?us-ascii?Q?2uRdhgYbj72O/snac0ckXIBhsFkWnk75yyzbbVd4UhFsRdMsZg5aJbuZ/7Rg?=
 =?us-ascii?Q?6Qgt/KeInPebXNIunDDgacG67L3DKeNWmZ+KWMMl0MKmL1r2vm7EpNn48riO?=
 =?us-ascii?Q?wfXwuniyhSrYroyiVWZ+BdEDIgVs9ygRzXOdTgGQELI+TANpZe4tf0FGe4wX?=
 =?us-ascii?Q?d7BScj7CWEhEnDkKXJo17XzxP1iZs7CHKScvERkshgwN0b377z32xA6Yt7H7?=
 =?us-ascii?Q?fudIGw6GDrx6nOLk4MQiH2eh1Yfj+4UaPuDzJnVcDEDSX8Y+LDwz1RZZawEN?=
 =?us-ascii?Q?pPtj8U4PNj+LwLjEtPq3N4QFKdPKKscaRzptPLQRLCp2tZFDWLMY/7WJolaE?=
 =?us-ascii?Q?MI8SSyTZ5xeeiHGlgRJEFwj8NCblMIfn2iRwKOQAuZFCShbmi+kaKWpa69/i?=
 =?us-ascii?Q?QnbW+R3hpOvIodn+5G4PeIo7r9NP856o6NF/K+fTEDFpxylWTOxjT1zNsQnm?=
 =?us-ascii?Q?QwZV2q7/uR6chRJegHwxHNuGAX1TlsGY5b+vcsFj5gfvhlQIXLlfTVRxk2nB?=
 =?us-ascii?Q?2/cvZxfDckqU8CqcEY/FChBWf5nAt8quQkrzsORqIIgg2mOYqY5mtUqIeiK2?=
 =?us-ascii?Q?o5GbQqNydkZMzDj+Wlf4kNYXkYZffBq10nVjf0590vzr9/Wgl9o1UYvaO5ap?=
 =?us-ascii?Q?LYS1vAA8lzxqD4tOTf9LAquuyQivfiWUBAoTLhTmRpz894rRwErKmKj3ob3B?=
 =?us-ascii?Q?MTporCB6dtiGMK+SQb9DcXRFHxo2SKR4AoCSya/cWVIFiHkERCNIDD3jzTeU?=
 =?us-ascii?Q?dShobfA15NKhSDyy5msmITDiX1HbZYW2L9sNOnayVgYXwljn4Viq+DIZS12t?=
 =?us-ascii?Q?zx/RpoyF50bpioPOjFMxR6PB/nt7vceYJnWHV6sccAiC7vWKKmCMoZkcbvnG?=
 =?us-ascii?Q?4dnT93TpOZPw85FSElYc+HtM1ooLQoDQdzzD/hCL64TCAzx27Q24Mok+UfeL?=
 =?us-ascii?Q?uuk/MGodOtxFyv8iBgtlyhjbiBjfAgL6EtWi8E+9fNWq29zJ4wuAV/gIcYZV?=
 =?us-ascii?Q?6rM3eTTF1UeV2G/USHTqPV/xHfgc?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 09:10:28.0064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 535c83ff-2185-424a-f053-08dc7007dea0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7021
Received-SPF: softfail client-ip=2a01:111:f403:2407::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.582,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

When migrating a VFIO device that supports pre-copy, it is transitioned
to STOP_COPY twice: once in vfio_vmstate_change() and second time in
vfio_save_complete_precopy().

The second transition is harmless, as it's a STOP_COPY->STOP_COPY no-op
transition. However, with the newly added VFIO migration QAPI event, the
STOP_COPY event is undesirably emitted twice.

Prevent this by returning early in vfio_migration_set_state() if
new_state is the same as current device state.

Note that the STOP_COPY transition in vfio_save_complete_precopy() is
essential for VFIO devices that don't support pre-copy, for migrating an
already stopped guest and for snapshots.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 hw/vfio/migration.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 5a359c4c78..14ef9c924e 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -143,6 +143,10 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
         (struct vfio_device_feature_mig_state *)feature->data;
     int ret;
 
+    if (new_state == migration->device_state) {
+        return 0;
+    }
+
     feature->argsz = sizeof(buf);
     feature->flags =
         VFIO_DEVICE_FEATURE_SET | VFIO_DEVICE_FEATURE_MIG_DEVICE_STATE;
-- 
2.26.3


