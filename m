Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85ABE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuIL-0006fG-DF; Wed, 18 Dec 2024 08:40:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tNuII-0006eq-V0
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:40:54 -0500
Received: from mail-dm6nam10on2061a.outbound.protection.outlook.com
 ([2a01:111:f403:2413::61a]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tNuIH-0004h7-0V
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:40:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fx6MVl3PqAN+63qPisv2aK/yT6IVJtdczMWntaTiI+eblbh+aSBscyDGzqLBOzss+Y3C9682zREnqrLxXCTikJL4DPiB6zboLrddzsHLFMhgW5kjjcKjVw67UHeF6O0PqWO5ikWGjWGXr/dcCQpcmZbMkDwIKKH4YyH0Rz2e9JQpoWOGgyXAUO8+lR6/ndjvByAnZDjV6k7Ynz3TOJE34xUsILbbfoi4j4fsKC0z146AclZfC/jbfrAMOyQvE2FwQEtLlkmdOybr1EPkTVufHmac5vFZ9a9aWL2bJ/nUpNHXMtyB7ubU2DfJsTjNWqARpwD7ECCq5bX23acPOyIU6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XG7Kek0hDWz6Trc/DRDzAZ1rqHwRn1to69oRMngrhfI=;
 b=qLZeqY0o/xs2NMybVqXsveoIbexYJXCCURU+Vx/cTV+JSTfJq2ymbiCC0Sw6SV6/xi6Mv1vkPUAjo0zy7Crn8ltvL0Fc0ckACBAkwoEJf9EK1q3jf6TUYH2XP50Tx+0T295D5xV/tPaPOoQiAyL6ZR28P+jBg+G7/YN6tzLn20Am8l0Tx35a5oi1ptHfZfrsobzN8lUC4k1z2r5d+VFTx4zW2Iptb/NXEU3UXboh77/Uv51lfNTnM/zdbbw0l0O2vp7wTOurRsS9p4TLrQv0AzsShoXe4s/v/znFNqDaovQY/GvKC/FPein1k/b2/zHsFrjR46VE6jNdjsPpjmunNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XG7Kek0hDWz6Trc/DRDzAZ1rqHwRn1to69oRMngrhfI=;
 b=qOwbeTVzU6bHZxUNqlDh5Ya6yAb0AUYFzxeXb/PVNTNM6CEmDbRyNKwPEEFRBJZhTfmClgXI6OqjajqGIyHYqF//E3Ul+WD85fyZXMMNYwePnplGcdoSNYhVD5101e/pgY6yQTMkUs8/wUENLvzWk4px5/kMkFT9gDAFC0HZ6DS9cPWb3lUY9C+X8upHpqQmbwJYgzj9s/KQZ+bu0Eh7VD74PP3zs6RTDndxE4EGfX9frQLqlYS+nUH4pUc9l8lynm/7q3I4Kn6bQjS3jv+oS0KIhdXhydo30pWRijDr0N58dZ02KibhuXZN+zXwNoeTpEhUYKpgbE1AzUypFJL2bw==
Received: from MW4P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::31)
 by CH3PR12MB7617.namprd12.prod.outlook.com (2603:10b6:610:140::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 13:40:48 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:115:cafe::24) by MW4P220CA0026.outlook.office365.com
 (2603:10b6:303:115::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Wed,
 18 Dec 2024 13:40:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 13:40:46 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 05:40:36 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 18 Dec 2024 05:40:35 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport;
 Wed, 18 Dec 2024 05:40:33 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Hyman Huang
 <yong.huang@smartx.com>, Joao Martins <joao.m.martins@oracle.com>, "Maor
 Gottlieb" <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH v2 4/7] vfio/migration: Rename
 vfio_devices_all_dirty_tracking()
Date: Wed, 18 Dec 2024 15:40:19 +0200
Message-ID: <20241218134022.21264-5-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20241218134022.21264-1-avihaih@nvidia.com>
References: <20241218134022.21264-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|CH3PR12MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: bb0c6421-cc91-4288-f80a-08dd1f6993b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sfnh9acgJVmvkRsl0hKHhVHKidPmAc4uJB5rc8+jaSnD9mJWTU6Jk/7Zt+gU?=
 =?us-ascii?Q?FzmELBtagr2lVyhyVTIqPbeAKP3rJIM8+iY23DmCGG5GKJCoZ+S0xzv0zbYh?=
 =?us-ascii?Q?WRqNdsfYAHec/97yrFMyKjT5SvC5GUxlhJ5l1VU+UDh2gI53cFpd/6FyIlQk?=
 =?us-ascii?Q?wZ5m8P2a+8uk4gA9GDEO0/IiqTnALPXBCyLXyBE0xe14K07Zglv4/jfL/k+/?=
 =?us-ascii?Q?URFwUeKu0pGRPw4P367FvmkEcmp/bDk/fCJvD+YOCzcU3Lcq7dkmVncMESXZ?=
 =?us-ascii?Q?N2m28UXGSK4sXxiqXbE3fGLcFgf0kyJMN99kSEw5EvMgAmO72Vxq8yT/1JAK?=
 =?us-ascii?Q?ESPDKUrGy5XWBqEmdC1YxRUa3ciX00InMChy2+WeMzjDywloYRqhSg2e5yj7?=
 =?us-ascii?Q?l657yPgp3HGqtzKf4ld0AghMkGP5ts8mDbgT6lXJl4W3VRhdSpb+3TnQx4A0?=
 =?us-ascii?Q?HyjrGlFL3DNRDfK8ocjlYgbqsUTUP5GZ29vA0fU8ngXiBijtScHokF4dr0qa?=
 =?us-ascii?Q?okl+AbK+MNCBdiuL2wQYC5YrTS8GJigX5miAnWhKiVxkO7/nUWpPzXtTMWJn?=
 =?us-ascii?Q?JysEV94alO7b7GPQHI8YIC5zBvrJ4ZR8zs5T/1IC5xLl0+pTNIHxlWPULvpn?=
 =?us-ascii?Q?HzJMpgdzQejPT9DDGCGfheX7UoBxNShYi54ZVMRCkARfjVqUydfnW3EqxSx/?=
 =?us-ascii?Q?/sMsgLWSC/LqKKxI2cmYQuYg8RTHcOHZjRxHfRjUjCUbKExD7pQthXJDdCKo?=
 =?us-ascii?Q?jgwUecm81v4EeXvlZs9jOzciLJ6+HyDfGUY8HPFPL0wL08SXE8aDsEsrjeRN?=
 =?us-ascii?Q?W9Pxi795mtD6ArfQJAgjLoflNhBwhCpGVLFSKA3bV4RRn7rnJZltkt9MyG8w?=
 =?us-ascii?Q?x2gbgO6idqb40n27Jad8t+DhwFG3mPpaB/SBvm/wZ8t/xbgN3xZ5EnN+T1zM?=
 =?us-ascii?Q?83m78+zwMNe1lqUH11ZshTtaGEaRRJgGOkepmLGtxwWs4WCC+2alUxFf8oxI?=
 =?us-ascii?Q?RhH3S7Rc7hbLuJDwC4n0rGH+WtG3YGo+h1mB6tqIa9eRW2yfKk+cMj1hCHQo?=
 =?us-ascii?Q?lfl4Tc1ceD+O9HBQowMMomlqFp4NT1lyJfRF2Df2zN1pw/wEY4oc+3AQ15F3?=
 =?us-ascii?Q?qlM3ecLIpDRINPMwbTmLuCckz1lwFWTgt+IwhJWMHQlWKD9DRYLaHkp59jEU?=
 =?us-ascii?Q?H1BZwaXaks+Jk44XtUmoDJIqha/y/Y1BRGKwl19WdyDZumrdomC0zywU/iWU?=
 =?us-ascii?Q?G5P4JEy6a8ZC9bNs/nMQMlDIfd/ayr1A6Y73lpv65x0biYkP/f0RjaCE8bJS?=
 =?us-ascii?Q?/sCetePb+mq4yv8lzF5h9YiOxwyCY/oeiMGk22xAN06VVyFT+nZRIP8DbHw5?=
 =?us-ascii?Q?GqrgqAnB3wC+ztbCX02SKmC6rXNbMdlsNrVOpunENIzwRdnCpMJM+CKllmMK?=
 =?us-ascii?Q?kzPAlgkWV8gllCkP5FEnewtyWvC6S1+Mr3BWLvNPd7bsnm4QoUIdSjLA2WBX?=
 =?us-ascii?Q?Aq8i8n6pjbHGVyA=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 13:40:46.5613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0c6421-cc91-4288-f80a-08dd1f6993b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7617
Received-SPF: softfail client-ip=2a01:111:f403:2413::61a;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

vfio_devices_all_dirty_tracking() is used to check if dirty page log
sync is needed. However, besides checking the dirty page tracking
status, it also checks the pre_copy_dirty_page_tracking flag.

Rename it to vfio_devices_log_sync_needed() which reflects its purpose
more accurately and makes the code clearer as there are already several
helpers with similar names.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
---
 hw/vfio/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 2831f674ff..d113d8f4f5 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -191,7 +191,7 @@ bool vfio_devices_all_dirty_tracking_started(
            bcontainer->dirty_pages_started;
 }
 
-static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
+static bool vfio_log_sync_needed(const VFIOContainerBase *bcontainer)
 {
     VFIODevice *vbasedev;
 
@@ -1364,7 +1364,7 @@ static void vfio_listener_log_sync(MemoryListener *listener,
         return;
     }
 
-    if (vfio_devices_all_dirty_tracking(bcontainer)) {
+    if (vfio_log_sync_needed(bcontainer)) {
         ret = vfio_sync_dirty_bitmap(bcontainer, section, &local_err);
         if (ret) {
             error_report_err(local_err);
-- 
2.40.1


