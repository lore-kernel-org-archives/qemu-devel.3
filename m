Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F880C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 18:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2YJU-0003YF-07; Fri, 04 Sep 2026 14:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x2YJR-0003XH-Ly; Fri, 04 Sep 2026 14:06:53 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x2YJP-0001jL-Ix; Fri, 04 Sep 2026 14:06:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOtqq7kW1Td7gLEFrEDJguGL7CJYRIyovFRRKVlAYXzPdWm0HiZvIIZqCT60B/8JELbr282GJcL2tDJafQa8Gr9vsuNfp3unRAx+FNW84JsUyy0p4NF+ViAIzFXM0ZWCQofm4/lIvtUkXLuBAaIAC3p8D+4N8q+9foJoXpOmr9l6oZkhY+wz/B9QydYJtLwQBbtQU84JfXT4IGUextGgOHwhdRFrdUH0c0c2Bh2EELfH+YdL86Dc66BBgbgZKREI1tksdL3NAK6BNYlmd19k/i+2yWFcRJNBkbLIa0Oc+UJMK4BsfTu135FG0lAQZ4FnvcXIenEtKnhlKwc/Nzal9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CW4QkCNT8wdo31amE9K2pn1f7Zq2iKinicBxMVElgYY=;
 b=SErNoiuqVYnPemnD1/HI2JnL0CjwLAsiXt6Lk6TQE3LzZCfn8Dsb41/cu8Hq4hYBgHKceOY2GIGe8WoqrqE63Ds/Cz4dnbpL4wx2BlB4HORG0C+6VqDOZDX4/g7lvZVRwJuAqH1RqtSAjNomRNDVMQL3edzD+yj0cL7Gjwa46GY341IYtTi1PbQl0/snc/5BTymEx1OVBQCbBUgaZNNqr6Vh/uljJ3w5F/K7svk/C1d4WaMKiOdC5hLOKh9XRczjDy+08Z01My4mX1F0Z9OCzNW7TyOOLfwxj3/83Q/47dTpHFMm7fWN0hJxae2XtQDj90YWTIuFqI4uuL5fXSZmig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CW4QkCNT8wdo31amE9K2pn1f7Zq2iKinicBxMVElgYY=;
 b=S2yezm+rrnGI+5uLzPjEx+wlJBhDRcOu6GdWpzrB0iN+iOIJ1xnS5+0OISo96Cij2aVpHUqbv12zVib3HBmJkFC4+c/Jb1qDP7RU8rvvYtPOK7bjOmnjv9FeWQgPZVM9/Tx1uxTos2OJkNayD/b8sFiKf/LUVeYH0yNQl2hTPgdJsTkYO7QjCHRWy80bUOOOoIrjhGqXGxyhODsF5QwNteNPLXj7UB14xtrxxYlwD6X39bETvAQnBA00PfRpCJe+kaVExIfQ3F3/yCuZZ7QuAwFrpHq4rmuAHAIIOUe3W4IhE4ky/LwrDw+lowz0tkUr6SALW1wfpafZGlYycE2X5A==
Received: from BN9PR03CA0972.namprd03.prod.outlook.com (2603:10b6:408:109::17)
 by DM4PR12MB7525.namprd12.prod.outlook.com (2603:10b6:8:113::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Fri, 4 Sep 2026
 18:06:40 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:408:109:cafe::41) by BN9PR03CA0972.outlook.office365.com
 (2603:10b6:408:109::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Fri, 4
 Sep 2026 18:06:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 18:06:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 11:06:14 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 11:06:11 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@ziepe.ca>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <skolothumtho@nvidia.com>
Subject: [RFC PATCH 0/7] hw/arm/smmuv3: Live migration for accel=on
Date: Fri, 4 Sep 2026 19:05:06 +0100
Message-ID: <20260904180513.248396-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|DM4PR12MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: 57dab986-7299-4c54-ee24-08df0aaf44d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|13003099007|56012099006|10067099003|11063799006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: T99ThGBoJxdpjRzgUxkofl+LbTdmuT8/E10/AiXZTKf4yNDDRhLNwYO3MRdbEXmjJMrv/Ud3EsyRiBuoqLiR5ZwlHCt8K8rlrV4L8ngL8HCR4Y4EttMD9SyZfFwaYcFDCjmYNZ93njOW+mVU9TZVuYeEMKBzJGkSVTOiJVm8A3vasGYnK3+0s12eZZyc6FKhwGcLNEmy3tLLaGp19hG5mtNZmo/CLWDskpZ0u2qg6pewErnW7MTtkwmYMBLcn/xbb9MNvZYP4nUPMre+HoCPWbSXHPQ9n+5fRuS+w1iQbSolyupOisf9RwKifAPuOay19mXjnYczCPfyR61kAhCiJVuaTKNS56fZbc/s99BX8x7/5ANS9ssyDuAEmM8Vc1pipPIpjsjtDhoSNf8YHvqmBec2IJth3y0B4vzQFZj3HRWIoCoGO+CvDN7sqVonUXdnuKkEq0kMY1RWbbd+iNBxCJK8JdbYM4R+nSVXqBflZmB8ceA/M5ph5LhI4YQWXBt9YyzxbLUddGta+j3QgTEc+PRvK5pW3B6P8iY8RFhtnj/6mM6eIW3TtopqoafEySuOfJ4RtUdtX75oscilaxfK0dhSqIj6Yg9M+RPzB9B+TpxVDn3YuCgawysZHdN5FVhqN9/AaUP70k6U5ZlvUEQtut6de/Z0nLC0sF4mtt3FaFY2czlUMkpMo2X/onMgK4iFom96lyyYT9TnJkS0I+xemw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(13003099007)(56012099006)(10067099003)(11063799006)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dT+abyCnHO4Cy9rPpB89gFD/tr4NsJXGKpHZc5Eq+EyaWCA6qxzXcIzHULuHTdoUUvwOl7gLZwplowPcsgpHRoMoWx40yl1P263PnNfosxVrtXTk+/i9pNNQIka7pPWMM59mDp97/QNZM4DmdAa7TtfJm//LlsfCa8/p1hlnewm7koDWjQYfwOeDQSST6PGmGavB9AKgxDgqWLHbi6yMvcfdwKz1iQfeOPSy1gpGuXLjuKkEH9OxpRPJQGvobEDK7VNf0gsEmBPHWFEtdGYfcBbBGqcrLcq4EJTuE+v8us0eeIa6vRvk8qKwb7lCyyzrBNG6zlYDzR45/M/IIYcOh4qHPPyNpgNIwbypoPuRMVT7inrUiBuk49TrtzRiKHmeIL112kOtbq71BD26OwaH9B0M8SkiwZ5k3hMM1azNHrwTs3yPiNxuFLUQQ+XK7l5t
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 18:06:39.8025 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57dab986-7299-4c54-ee24-08df0aaf44d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7525
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

Hi,

This series adds live migration support for an accelerated SMMUv3
(-device arm-smmuv3,accel=on) with vfio-pci endpoints on the iommufd
backend.

The destination replays rather than receives. The stream table, the STEs,
the CDs and the Stage 1 page tables all live in guest RAM, so once that
and the registers are restored, the destination walks the stream table
again and rebuilds the vDEVICE and the nested HWPT for every device.

What the series does:

 - drains the kernel vEVENTQ into the guest event queue when the VM stops,
   so that pending fault events are not lost (1, 2)
 - migrates the resolved SMMUv3 feature set in a new smmuv3/accel
   subsection and fails the load if the two ends differ (3)
 - replays the guest stream table on the destination and restores the
   vEVENTQ and the GBPA HWPT (4, 5)
 - asks VFIO for dirty tracking on the Stage 2 nesting parent (6)
 - replaces the accel migration blocker with one scoped to CMDQV, which
   cannot be migrated for now (7)

This depends on the host kernel supporting dirty tracking on the Stage 2
nesting parent, for assigned devices that cannot track dirty pages
themselves. A branch based on Jason's iommu page table work is here [0].

Big caveat:

This is not yet tested with a real device that supports migration as I
do not have a test setup for that. Folks who do have such a setup have
reached out and are copied here, so hopefully this RFC lets them give
it a spin and provide some early feedback.

QEMU branch is here:

https://github.com/shamiali2008/qemu-master/tree/smmuv3-accel-live-migrn-rfcv1

Please let me know your feedback.

Thanks,
Shameer
[0]: https://github.com/shamiali2008/linux/commits/iommu_pt_arm64_s2_dbm/ 

Shameer Kolothum (7):
  hw/arm/smmuv3-accel: Factor out the single vEVENT read
  hw/arm/smmuv3-accel: Drain the vEVENTQ when the VM stops
  hw/arm/smmuv3: Migrate the accelerator feature set
  hw/arm/smmuv3-accel: Add a helper to replay all STEs
  hw/arm/smmuv3-accel: Restore accelerator state on incoming migration
  hw/arm/smmuv3-accel: Request dirty tracking on the nesting parent
  hw/arm/smmuv3: Support migration with accel=on

 hw/arm/smmuv3-accel.h       |   2 +
 include/hw/arm/smmuv3.h     |   7 +-
 hw/arm/smmuv3-accel-stubs.c |  17 ++++
 hw/arm/smmuv3-accel.c       | 192 ++++++++++++++++++++++++++++++++++--
 hw/arm/smmuv3.c             |   6 +-
 5 files changed, 210 insertions(+), 14 deletions(-)

-- 
2.43.0


