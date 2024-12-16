Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86078E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 09:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN7lw-0006c8-44; Mon, 16 Dec 2024 04:52:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tN7lu-0006be-C0
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 04:52:14 -0500
Received: from mail-dm6nam11on2064.outbound.protection.outlook.com
 ([40.107.223.64] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tN7lr-0004sG-0K
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 04:52:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyxQ1XB6qbmURDjFnDqCjjahb+GQHyYqToiFIzVn6O9rF10w6Y9LRI8Y4xvjxhaw6eNgW9HAXkgi3y6k2SceMibKq4gR8CpEPjpfIRjfUnpES+mJzrxN6iNig8BIZBAZuXfRUGyB2Jmu7iWEPWAimf/B+XxVJL378vdS5+jKfDM4UWYjmTTzF9wXiSLRcgfGMyfXHQ6dkLO7gIfuuELHuWfZQMhPwognVSy0LOnCGAIl1Gfu8ZHyWgwntO1265oGXzbPrJPS2pIkye2IlopJdL+dxooPE8OCWdKinHNBtqFzNztTIEvDtIOoM/ZW/uy4Uu7sD2iXSPoRYaXnYxUAng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vulJSYaPjeiUerDJSI3wmQeHrlClSldjHevEun1F0Js=;
 b=xRIVa2CPL9EzpA2EhTYDf5wKYn7T8Pw3+qjINxuPXSTE5HVxc2lv4PNWizdV0waZlcMXidTVXKdlpR6SI7g4M0MIrgBuO+OnXBqqAZ1DpIPr2eh/aU/2H67oKf+Fv5xu8Zxa8zRqZiVnaWCloqDMH0iiX7CGD61ETIyGPHbC/NpO4kz7IV6SX1XOfErILvnU69FXqehjXGRNMfoMuEr9TLNwgWnvK465qlwP5QPtOkxS8552znDZA+yTxXunmtkj8w/dViLPzz+uK0UeqmjnjwGV+bpgBo+aiX8/O8mU2DkAZQHpFlfHxpaFSL+g3MhfRn20HvdjPOLvzCjcjq8quA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vulJSYaPjeiUerDJSI3wmQeHrlClSldjHevEun1F0Js=;
 b=h5kLmh7a+hDxnfMLhzqNuy5Pl8TVLpdfDmi1Lmd8YQ3GkTZgdJbw11aQeUPEW+PMqO5rpHKa0Q25fkcEDTOVjTYuINEhFKpj0wFTdOp7g4rpQI6yMu8sPcEZVD1V+Ur+MhskFvoWd3dnC55XUvmzJTBA0kopWAC4tYPp1CB9GfHSdIWlcQAjM7PCfppU8IE1wgn2fbnuypn2RQ5RH7FRs5l8kwu1kvdU6gMjvQ04Y+ik2KiZ5V1l5AdZt6+agREeCaME8oSOR/bVzA8UqKHmLVNDmbwUil7SF//pXtAWbHbytd+iE4ZVqDzIOPkGVEJ97NV90MaFLxsq47uT36Cnew==
Received: from MW4PR04CA0148.namprd04.prod.outlook.com (2603:10b6:303:84::33)
 by LV8PR12MB9183.namprd12.prod.outlook.com (2603:10b6:408:193::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 09:47:02 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:303:84:cafe::d0) by MW4PR04CA0148.outlook.office365.com
 (2603:10b6:303:84::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.20 via Frontend Transport; Mon,
 16 Dec 2024 09:47:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.0 via Frontend Transport; Mon, 16 Dec 2024 09:47:01 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 01:46:41 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 01:46:41 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 16 Dec
 2024 01:46:39 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Hyman Huang
 <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH 0/9] migration: Drop/unexport migration_is_device() and
 migration_is_active()
Date: Mon, 16 Dec 2024 11:46:29 +0200
Message-ID: <20241216094638.26406-1-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|LV8PR12MB9183:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b885af2-5c3f-422a-102d-08dd1db6977a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gPIfE9iKR7Qh44fR6gl+gnIGmlrJe2vfq4e/MOcvrkoBlUnLostF7vLc85EM?=
 =?us-ascii?Q?gUk0LJcN26EeQYEyHh1H/877lKwp9qNwXo7pj7KP1YtQB3IIspY0BLljOUja?=
 =?us-ascii?Q?Ti7tE8UQaKV9Kh+YQ6wgv0LWyPryxaW2ff/XuT+d8X+GDQ55lJOezpjCK8AK?=
 =?us-ascii?Q?IadAEHFfvSCKljjt5Aqtkud+HEkLQ/NGphTW5uU5D2elEMOTFyU/TUO6EpaG?=
 =?us-ascii?Q?uE2dmE8XXqzQqDFdNoW8Yrlttd9POLGFlKCpMhw97oS9IlmnRjnwmaWh/Qdq?=
 =?us-ascii?Q?XCXss1W/mat4sp0u6ZvSm7fCcOXKhVjIvtIiUnnxo1sj5UBHgZ64hwNZbPXD?=
 =?us-ascii?Q?iDa+SCb0QkU9T4TJexTAS5GGoj9assSADR2wneibaBWEa+cHAS3NGVNk84pp?=
 =?us-ascii?Q?ZqeBBu6Jv+PCtICvtndYHFs6UY94PAsKTxRGIEhJtnDNrDse+BysmKl9PJ4W?=
 =?us-ascii?Q?3XkaR+9ID2uQCQNyF3T2NDZhlOv8AvWtwoL3zR9SCT+I+vuEOhp+8hkOHOE6?=
 =?us-ascii?Q?o2Ia1hDqLzmWzmjl5YA0iu4p9QA8A3RVzC1wR+vjG6Llsdes2OkHc9/ZSp2Q?=
 =?us-ascii?Q?7sCYeGH0NkRTotL8AcKqV+llmvHn6L4hD1FRTxFne3Yb5Q6sWot3c5nceazG?=
 =?us-ascii?Q?K7GoOS/ZlTY6FeClHNF0CB2W6XD90b8R3D7VbcocQfeZlufxYyAR51k+dRRS?=
 =?us-ascii?Q?vsE894lKdBolssU4dPHj6pb8HvXFeadRuYROe9f7CoiBcmrb/YuHE2YL1AHW?=
 =?us-ascii?Q?5ImTnW2WuNePlkjrLEjhD53p7m55wfBa6WxhgnfRd2xIHpynjCw9NXD5ECes?=
 =?us-ascii?Q?Gss789WZd27URNSBs6coom6fTxiAt0SQbdHD3aB4ktRwk3oHMQoo8IQNRGvY?=
 =?us-ascii?Q?+S6F3VtAPj0ZxMDbzZeiC/FbAVtoQLe3XtiqmAp5zGmqyYjyenx0gqAgPcSB?=
 =?us-ascii?Q?oGi+ru7vVfOkmI8/JT7I3KgIc9awV5X2Wo5+mThqmaKApenfjz2Bq2PUqSWX?=
 =?us-ascii?Q?o76IakRzrI9rCxdBv2nWM6wJC96x5zwuML0ptbU/I+Isyy1LvsfMGfW9nNQR?=
 =?us-ascii?Q?Hjzv+c3GU59eBFXkUDzi+OfAmpfb09Vt9/2xjYExfzmM0gWH/yfaQbB9ir8z?=
 =?us-ascii?Q?5BqM+je1VzhhQml74D/cqL2RQCe2Uf7NSdxEa8CFSc1Zz93lFT1AKzurccVb?=
 =?us-ascii?Q?/WmPAw3pUuL3g6rwhWa0KS5Dqe9DAfDXXhF5LBdxtdCBKUlt/94/4XemteKF?=
 =?us-ascii?Q?hfADi3mbJ0v8IRsf4/WwMUcD//H+vebt+GaUGjTHTqa+33JEXbnBRzbDZYxY?=
 =?us-ascii?Q?4DVGJu5s+CcmLCxn3W5b02HWNVeOPTfv74fZcUXESE25fL5NxC7N+bMmBzyD?=
 =?us-ascii?Q?5yjhsFX2UPIGUE03y17gEjE1yyxNwZuax7BHx/FSTGWWqC9+7iKf/EK1UD1Q?=
 =?us-ascii?Q?bOYnO5BzTu5wRTGHc8jP1F4D1MqIvg2OO3O2A0+ED9BIF+GIJq9a+jeMAB1g?=
 =?us-ascii?Q?CZgdUO1AbZcQr+Q=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 09:47:01.7840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b885af2-5c3f-422a-102d-08dd1db6977a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9183
Received-SPF: softfail client-ip=40.107.223.64;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.168,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hello,

This follows up on Peter's series [1] to simplify migration status API
to a single migration_is_running() function.

Peter's series tried to drop migration_is_device() and
migration_is_active(), however VFIO used them to check if dirty page
tracking has been started in order to avoid errors in log sync, so they
couldn't simply be dropped without some preliminary cleanups.

This series handles these preliminary cleanups and eventually drops
migration_is_device() and unexports migration_is_active().

The series has been migration tested with the following:
- VFIO device dirty tracking.
- Legacy VFIO iommu dirty tracking.
- vIOMMU + Legacy VFIO iommu dirty tracking (migration with vIOMMU is
  currently blocked, so I used a patched QEMU to allow it).

I didn't test it with iommu DPT as I don't have access to such HW.
Cedric, I remember you said that you have such HW, it would be very
helpful if you could test it.

Patch structure:
1-6: Refactor and clean up VFIO dirty page tracking helpers.
7: Refactor dirty limit code.
8-9: Drop/unexport migration_is_device() and migration_is_running().

Thanks.

[1]
https://lore.kernel.org/qemu-devel/20241024213056.1395400-1-peterx@redhat.com/

Avihai Horon (9):
  vfio/container: Add dirty tracking started flag
  vfio/migration: Refactor vfio_devices_all_dirty_tracking() logic
  vfio/migration: Refactor vfio_devices_all_running_and_mig_active()
    logic
  vfio/migration: Add vfio_devices_all_dirty_tracking_started() helper
  vfio/migration: Drop vfio_dma_unmap_dirty_sync_needed()
  vfio/migration: Rename vfio_devices_all_dirty_tracking()
  system/dirtylimit: Don't use migration_is_active()
  migration: Drop migration_is_device()
  migration: Unexport migration_is_active()

 include/hw/vfio/vfio-common.h         |  4 +-
 include/hw/vfio/vfio-container-base.h |  1 +
 include/migration/misc.h              |  2 -
 hw/vfio/common.c                      | 61 ++++++++++++---------------
 hw/vfio/container-base.c              |  8 +++-
 hw/vfio/container.c                   |  2 +-
 migration/migration.c                 | 23 ++++------
 system/dirtylimit.c                   |  3 +-
 8 files changed, 48 insertions(+), 56 deletions(-)

-- 
2.40.1


