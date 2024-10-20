Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE7BD3C92A
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 13:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2VZ3-0002W2-VP; Sun, 20 Oct 2024 09:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1t2VYy-0002Us-8l
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 09:01:40 -0400
Received: from mail-mw2nam04on2062d.outbound.protection.outlook.com
 ([2a01:111:f403:240a::62d]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1t2VYv-00060g-Ul
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 09:01:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HX2aGp76SrnAyo7U8KIDi8/1v0lIe6PGQX8z3jkZyWGabieC2myhcKZZprdFhPTDGHpW1JBklhCYIWbQLvFzabuPpy8HCYJoOCGbyKTGddL08KXn5hXiYzxKB7cPTTPW73mo+MEfW1WVgi/DLk7IYjTdLZUw0tWX7nFPiev+47wMudhsrC1WqQtPL4Dz/7G1kS7MZcUR8Yc6ecdZfUXKc9NjlmrA41my0I6rcTixIhdo64se83H3tz92m/KAEiO3iViWFht8FQE6JnUU6mIfBN1yQMQr9t87dK+V1ZcaGUmFux9nQ6aiQq/pFeT2hYk8ERQu/blyEgklfOs2WYWp7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXGLve0Y1+n51c7Ice9d331PIxvUbAPEnvpjOHMKuhQ=;
 b=XimuF9j4o+NNInFHqkdC28+DmGbxwF/CfvRnR+OYtbZBhEHyLA9ruPOUHkRdAgHiFP9/jEDTwbRCdfmaj96b0lW6eF/H6QqxaMDgpduYkensJgziKZvKXbSAWt5GWBmTd+vKHiNZEixgzCr1onErOQEAQ9cjXEkJ3LgjfumkICvCpg0xEdMhrc/Gx++5Fs3BT8KHgE8QBEro0wPS0K4FzV4TfBJ8QJc0oSfF3J0EMwlIMrSMBWI36hf7jowWv9PmMPl6xROWg2cB4jwxqrRJJTN3cnGZAGh0LjtMwXF49/Kp1j+cEd33ndBXfo3X9Di9QPcNxjGspdyIU5NVBb3Lkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXGLve0Y1+n51c7Ice9d331PIxvUbAPEnvpjOHMKuhQ=;
 b=VHoc5AgP60VybcjKokKTBjfS3CsGwBDS3dOw6ao83DUuXqqLzyIgWPkRfrFE5vPQc8vrQshn8RqHSC+Z3xWfW21CqJ/mYMhl9g87laFZZJ2zO++BrRi9IrmqEjLM+YeCDgyPMnJ9pR6/neVRPvoP3FVouaQ5mquZJ0tOdBs9GYTP4ZfVvXJbCu4K9Oau5G5d0ZHGSaGLBnN1QM1AhzStjviigDPzVkL16ieoPXcpESJ9MPhmIHzbuKUJEtfV51R1zMeKx2KHCkxly4SMoEQejYE94g/dv4WHweZt+Or+u2qtM0ilYv7PxL9Iz8yd1Xhw4juoZ2GdpU+fpSO365gxdw==
Received: from BLAPR03CA0037.namprd03.prod.outlook.com (2603:10b6:208:32d::12)
 by MW4PR12MB5644.namprd12.prod.outlook.com (2603:10b6:303:189::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Sun, 20 Oct
 2024 13:01:30 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:32d:cafe::22) by BLAPR03CA0037.outlook.office365.com
 (2603:10b6:208:32d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Sun, 20 Oct 2024 13:01:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Sun, 20 Oct 2024 13:01:29 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 20 Oct
 2024 06:01:18 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 20 Oct
 2024 06:01:18 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Sun, 20 Oct
 2024 06:01:16 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH 3/3] vfio/migration: Change trace formats from hex to decimal
Date: Sun, 20 Oct 2024 16:01:08 +0300
Message-ID: <20241020130108.27148-4-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20241020130108.27148-1-avihaih@nvidia.com>
References: <20241020130108.27148-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|MW4PR12MB5644:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fefc4a7-8525-4592-2ade-08dcf10750ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5vxHPHa4fOQOx2eODZf1Nhispwy1A4u2k+HgcWhNAuT1CpnT/uAOhKy9cIvp?=
 =?us-ascii?Q?q6yDOI/PZ5YOxpZNFMd9Eo+UfYCanpekeQdGMU2RlV0fN7WV46C0pfoDZOdA?=
 =?us-ascii?Q?ikWYd77zV/Fz/WpcFWuX6dH7GM0xb2CDfld5XUGZxfCxeAwcfq4f4PwAA7TT?=
 =?us-ascii?Q?o5IbTTCAMvOfgpBw6tPvd34g++OBpF4rLhOjevMh3+tmN4Kc9cIZ+lYyF+F8?=
 =?us-ascii?Q?OhAt7c/C5MNjjVAnAhYonG6HYO07dWIpJT6ITE525Y2NbUN83FJa+7Eh2tZw?=
 =?us-ascii?Q?+1Xk8KG09Iz1iGDnIGtqeyGjpadzRTu0GIDFJrAQ0oI2INBQh6wRVCUT0KIz?=
 =?us-ascii?Q?3raVlyGJP1jM6tqr4e+i1261Vx48PxjBLTegZkdCCBTy0mDUnzYD1yIYuyrR?=
 =?us-ascii?Q?aTSTdTJTNEVv2nRIRRNkglE6cDRWGAoWeEkW0VcGAkL3opvizDYTZMGk0bw3?=
 =?us-ascii?Q?160XIOXCAicQK3+1kNlJ4OcY5dh+xjxR5nEcci+baOQ2Q1wgwgWP8glRwYNp?=
 =?us-ascii?Q?zIF4JgEYVrPMS0KS4ZiJYMm+oMEdGg7b47ieitmCvyaR43hXIFo9bQ/r9lzg?=
 =?us-ascii?Q?tyzLfs4tzDjWsE8TrJgVCUz1iQjcUkozg0O4Su1YVzy7CbXru4LfvwKhnNjq?=
 =?us-ascii?Q?2PEZxja4hOb7n9gwD6nPz78zTMxkAti05Gh3PgkxJz10iSmGgdBR0H/L4y+y?=
 =?us-ascii?Q?iv/KvVYdXNcsMgm7pOhLhQHAPtow/acQly8GlOSWiP0zncFd+SmE9Mx31PDb?=
 =?us-ascii?Q?eW7UW0BJM1C8/23L1X2cIvZhaFSq7kIwC0e42g4zyDtlJRfWSa4cspTK7nf9?=
 =?us-ascii?Q?ojuDXRM7fyNeXiApzlrsBVve8OIMyoJooBhGOIsHExn6bkyLxJ4Wn5Ua4BF7?=
 =?us-ascii?Q?qc2Qr8Xcvice48OylauvPNFgwtTaxhfVfBK+GpravrSjfr7O0pqTCWDBY9rE?=
 =?us-ascii?Q?dyXlNSgMuojsH0EnlOi1dDn+9fU1nNtlQRs3Un3sxUUjC5dedgfmnAnoO6fW?=
 =?us-ascii?Q?0+ZFviTEKZZyOf2cy9a2hOvXEbIPb63whkEZVy2i89A5BfZyNhQ3piy9tK/O?=
 =?us-ascii?Q?t8MRCbWL6OXJLz0Ix8y7lLljOoY+4xpFgzANpi6LNO9O6DIaS/GHG9S9kIu5?=
 =?us-ascii?Q?XsRSVOQd6LTG2yXR9GqYKJvypXyHPI7WryB8YONQ7hO2HKc7F7yYBaRVfSmB?=
 =?us-ascii?Q?hPV6hqDRKA8vQ0dDQ7enPwtizdNhj+NAtbMtv4L+afGGLDxie8T5PZpb+G+a?=
 =?us-ascii?Q?oWAvEk0eGnpQuu7XpXYADASy671WdPPUXcIedL9ztMnBzYfDlnUc05BEEXHX?=
 =?us-ascii?Q?//811ReNiFa8s93xT3B5wBFZhWnBkFWVuVkO8UzUGQ11NwhwY14r0E8N4usM?=
 =?us-ascii?Q?UIJU5XYg/yWCyUSZfvTqvwrefOPpSecyzon8KzbFi2XblsASqQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2024 13:01:29.9179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fefc4a7-8525-4592-2ade-08dcf10750ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5644
Received-SPF: softfail client-ip=2a01:111:f403:240a::62d;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
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

Data sizes in VFIO migration trace events are printed in hex format
while in migration core trace events they are printed in decimal format.

This inconsistency makes it less readable when using both trace event
types. Hence, change the data sizes print format to decimal in VFIO
migration trace events.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 hw/vfio/trace-events | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index c475c273fd..29789e8d27 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -151,7 +151,7 @@ vfio_display_edid_write_error(void) ""
 vfio_load_cleanup(const char *name) " (%s)"
 vfio_load_device_config_state(const char *name) " (%s)"
 vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
-vfio_load_state_device_data(const char *name, uint64_t data_size, int ret) " (%s) size 0x%"PRIx64" ret %d"
+vfio_load_state_device_data(const char *name, uint64_t data_size, int ret) " (%s) size %"PRIu64" ret %d"
 vfio_migration_realize(const char *name) " (%s)"
 vfio_migration_set_device_state(const char *name, const char *state) " (%s) state %s"
 vfio_migration_set_state(const char *name, const char *new_state, const char *recover_state) " (%s) new state %s, recover state %s"
@@ -160,10 +160,10 @@ vfio_save_block(const char *name, int data_size) " (%s) data_size %d"
 vfio_save_cleanup(const char *name) " (%s)"
 vfio_save_complete_precopy(const char *name, int ret) " (%s) ret %d"
 vfio_save_device_config_state(const char *name) " (%s)"
-vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
-vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer size 0x%"PRIx64
-vfio_state_pending_estimate(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
-vfio_state_pending_exact(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" stopcopy size 0x%"PRIx64" precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
+vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy initial size %"PRIu64" precopy dirty size %"PRIu64
+vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer size %"PRIu64
+vfio_state_pending_estimate(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy %"PRIu64" postcopy %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64
+vfio_state_pending_exact(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy %"PRIu64" postcopy %"PRIu64" stopcopy size %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64
 vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
 vfio_vmstate_change_prepare(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
 
-- 
2.40.1


