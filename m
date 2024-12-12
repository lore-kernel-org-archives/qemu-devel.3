Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA7CE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 13:10:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLixP-0000QG-UC; Thu, 12 Dec 2024 08:10:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiw@nvidia.com>) id 1tLixG-00009e-7s
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 08:10:12 -0500
Received: from mail-dm6nam12on2073.outbound.protection.outlook.com
 ([40.107.243.73] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiw@nvidia.com>) id 1tLixB-0000qx-Eu
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 08:10:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YhROVff4Uw731UoFjOWBWFb+QEVm6zK1TIm2Rr4C+Nyw6pLCRiPzYnBzDVYkAVxqwlkNCjEUHyTVblBR4L9mqtnsKZiMHi/A6nJmCgplZ5dGI1c6uguqYYwLVp8l50RnN2nR/Jq5T993/mVHj9Rij92FvYbQA9DlKFbRip5cT9+bz5f3Q4Ybyuqcv+f2VNqjViYzgyFKQq/jFJj8hwfcS1Ww3Z0tiCXmkcvVm8Y948s754FuNuMK2UTmRHD5vQPU+3zp3a6Lud1Qlck1sd4IiSQv7dIogZwp/e+DfetskJucULortuYfLWfEA8sjMl6h5gTKea0SeJTGIiuQW6iEDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HrU+PRYm6GYYAjosCrE3ZTuJ1jm9BJHHFgA619lV5Uo=;
 b=nNKM1Gg9h1eh3jhaK6SVTOrIDVQN5V+R3b7POS9sFFSIzElFsLOAheOrDrZv+Na2UpY8y/Ix2xJzVRBBOHuF8iy3FSbn8I1USSoqyQ7FDZH11Es/DsEdMdkW7ocm3kE/QgkhuDqpjL+ut4k/AW0s7EvcWjQUVd6wf0i7fFDYocNnDmo97VrUXpiHQ8uGFL8HkGjmnK6ufcIxKfNVC7FqN9hmgdnSLEB+VYLkL6m81PQb/sdof+gmbLJtLWW3jJXNh6T6FiL28kN7l9XJBQbxNo4daVy/aw6DVoWKL3H9GsjScmwVSBFligNQ3FE1QfBCmKZdv8q6y2Gf8g2M1Xpvng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrU+PRYm6GYYAjosCrE3ZTuJ1jm9BJHHFgA619lV5Uo=;
 b=EP6dmuE5ddESG/4zK6A5JQUM5XaaEVXq3DyS909HjKBnZ0B92KTaJnmjGaEfeEa+2COz+NqSdnh6+YbxsJ4SssYrOfM+/n23DB+U3IliiC7fu2iY0XBOOQaUG4VwKGQ9xxmuXK9gxfMJUbalDxXVFyA1TCBwaOc1pYJUF17jYzoq0bmjPd9linBoLdNejTrWIvme+AnsSLATxfPC28vCvJG6OAvhlq86L+NDSuMzxoBYuq7KS7C7TJ43PsfZ/evc/LEe62lmlQ3f7Kx4DxO2Ti5lUhR3gGBRwPQS5JZLax7jb7CTqx+nxURwKxPFoAcblP92TQrWektAt5NWNHAgoQ==
Received: from SJ0PR12MB8090.namprd12.prod.outlook.com (2603:10b6:a03:4ea::22)
 by SJ1PR12MB6289.namprd12.prod.outlook.com (2603:10b6:a03:458::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 13:04:56 +0000
Received: from DS7PR03CA0228.namprd03.prod.outlook.com (2603:10b6:5:3ba::23)
 by SJ0PR12MB8090.namprd12.prod.outlook.com (2603:10b6:a03:4ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Thu, 12 Dec
 2024 13:04:54 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:3ba:cafe::d4) by DS7PR03CA0228.outlook.office365.com
 (2603:10b6:5:3ba::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Thu,
 12 Dec 2024 13:04:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 13:04:53 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Dec
 2024 05:04:45 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 12 Dec 2024 05:04:45 -0800
Received: from inno-linux.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 12 Dec 2024 05:04:44 -0800
From: Zhi Wang <zhiw@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
 <jonathan.cameron@huawei.com>, <ira.weiny@intel.com>, <fan.ni@samsung.com>,
 <alex.williamson@redhat.com>, <alucerop@amd.com>, <clg@redhat.com>,
 <acurrid@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <zhiw@nvidia.com>, <zhiwang@kernel.org>
Subject: [PATCH 0/3] Introduce CXL type-2 device emulation
Date: Thu, 12 Dec 2024 05:04:19 -0800
Message-ID: <20241212130422.69380-1-zhiw@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|SJ0PR12MB8090:EE_|SJ1PR12MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: 32f2d633-ab45-421c-1352-08dd1aad9212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?49+GHAiTSq0W540uPL1Ud2q2eXMkH0NX/A6oIEYkg+YBCMMVTxvHqBTPMR5Y?=
 =?us-ascii?Q?QKIqAyBesBguLv5xq411ZX4qKX0VR6meR0nIWO0sfOVrItZP1mxP3Sqf+b0D?=
 =?us-ascii?Q?L+9rAk5zKlHdN7JATYRoChvkC347fS/yBcX4Xwp1bNW+qWdFcD+QqHYuISmA?=
 =?us-ascii?Q?BsUQQgNW/jrakjZTGJ4112V4Jnde+Vk+zE2fGz7t/Hsc4rtng+X6fVbQjyPg?=
 =?us-ascii?Q?eJJD81xFL0SA1B8IeB0NxdMy/GzVAffYsyCPwrRUI9KNwrDuTD1OdHeVqDfM?=
 =?us-ascii?Q?6NrtEa/YSwp5t08aRwQROzfux8usSQUV7ufrHnBqdz9iiN2pLkzx4bGs+6YJ?=
 =?us-ascii?Q?397/q7BM4+SJUYewnv5DXUYAQnI1HxxofLsGM3m5Yr2wgsJBPMs9DB4wh4Bw?=
 =?us-ascii?Q?m/WJVj5lz0rhjVZxdHis9YZs+8QXXVXPZah9yZLPBKP+NKNSX7/pAXiMtKMF?=
 =?us-ascii?Q?sQiM1tS4/jxRW5hhToQ68PJP594QC120hCja0vuZj2tQEkh+KAi/27zBO40X?=
 =?us-ascii?Q?vlmE4MC6f/4Q1rgDj2wmIv39Y7NkzsS4pFhr05snf2pIRshRgKRZO1TeN08Y?=
 =?us-ascii?Q?QZ/waOHDBOSXaKc/suvGY9B9hRZyJhlyicJLMnGSqKoY+Cs8OUj/SfiBUj+o?=
 =?us-ascii?Q?k2N3YU9xdh6l0EpwEhAmRi3Ki3PuqZjFZ64ZgoiXmltzeRASXWwe+XwiyS29?=
 =?us-ascii?Q?oFnjyBIb59hSfKRMZ0UZSdpD44t9dskJ63RIMhzTauDhZ09EkLbUH9ONZnEp?=
 =?us-ascii?Q?CHSt++Eu0Zx0X8sJs2iGbQk8tuMYmnRVBTcCQC+UNor631QirgAYX22U56ey?=
 =?us-ascii?Q?/3M1n2hrBx+TtYq7jvmROzvvzBIaJt6ejxRKjOeCJgHg1xSLyNajT22QN4qB?=
 =?us-ascii?Q?nJeYdLoAhU+NF9k+LzQqAl1+1ILjoQA/iEN7bqdTZMpquI3fwMp9Lp2lSBmk?=
 =?us-ascii?Q?iGe05KUOsNY5VokI7S+hjqolp2REn2O6fYtuxO3SvkHUHgXJHKDy7Q/x2c+N?=
 =?us-ascii?Q?6g2TMqIhjtAgHv0KehvQDmgKNe+/7D0sRdKMr5OlZb2Ka9JVs1DFbj0GBUMJ?=
 =?us-ascii?Q?SB02+opqwehXriuC+1Vf7qnccM8EHouwac9CwQTBQHWpDsRhRq/rH91Z2W2G?=
 =?us-ascii?Q?pNjVGhcgU69if+NPagl7rnkQ8ATxLad1lMAQEMkexT2IDhYvac5RlBOmJcjF?=
 =?us-ascii?Q?3lv6Lh6y861iWF1YP815F5/IpopGXRbEnPoKQSFCgyMuj2cP3Dko6XNmfTZo?=
 =?us-ascii?Q?aapWK2K7e6DtBzagHZo8mwrDGA+b5Ti9/t6XbFVARVS+RxeQOSmMQ9PZRxT0?=
 =?us-ascii?Q?hWlUd+q5SSLyy8qXkdp6O1Yrg1lWaF7/i9O0ZUBcoMx6u0Es1y710Sm/0W2K?=
 =?us-ascii?Q?Q2WJ3JRP9odh78ZtamR+tbZP/l6c+3V4EHqKqM1e1iDpwhq3LSZW+fylUekw?=
 =?us-ascii?Q?oYV/oglz7zwIKZ0+Kq5CbiezwxIZ+VBj9a9F/dCbkrzI8pTRc3ydfw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 13:04:53.7394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f2d633-ab45-421c-1352-08dd1aad9212
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6289
Received-SPF: softfail client-ip=40.107.243.73; envelope-from=zhiw@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi folks:

Per the discussion with Ira/Jonathan in the LPC 2024 and in the CXL
discord channel, we are trying to introduce a CXL type-2 device emulation
in QEMU, as there are work currently on supporting CXL type-2 device [1]
in Linux kernel and CXL type-2 device virtualization [2].

It provides a bare minimum base for folks who would like to:

- Contribute and test the CXL type-2 device support in the linux kernel
  and CXL type-2 virtualization without having an actual HW.
- Introduce more emulated features to prototype the kernel CXL type-2
  device features and CXL type-2 virtualization.

To test this patchset, please refer to steps in [3]. Use this patcheset
with the latest QEMU repo to be the QEMU host. It achieves the same output
as in the demo video [4]: The VFIO CXL core and VFIO CXL sample variant
driver can be attached to the emulated device in the L1 guest and assigned
to the L2 guest. The sample driver in the L2 guest can attach to the
pass-thrued device and create the CXL region.

Tested on the CXL type-2 virtualization RFC patches [3] with an extra
fix [5].

[1] https://lore.kernel.org/linux-cxl/20241209185429.54054-1-alejandro.lucero-palau@amd.com/T/#t
[2] https://www.youtube.com/watch?v=e5OW1pR84Zs
[3] https://lore.kernel.org/kvm/20240920223446.1908673-3-zhiw@nvidia.com/T/
[4] https://youtu.be/zlk_ecX9bxs?si=pf9CttcGT5KwUgiH
[5] https://lore.kernel.org/linux-cxl/20241212123959.68514-1-zhiw@nvidia.com/T/#u

Zhi Wang (3):
  hw/cxl: factor out cxl_host_addr_to_dpa()
  hw/cxl: introduce cxl_component_update_dvsec()
  hw/cxl: introduce CXL type-2 device emulation

 MAINTAINERS                    |   1 +
 docs/system/devices/cxl.rst    |  11 ++
 hw/cxl/cxl-component-utils.c   | 103 ++++++++++-
 hw/cxl/cxl-host.c              |  19 +-
 hw/mem/Kconfig                 |   5 +
 hw/mem/cxl_accel.c             | 319 +++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c             |  61 +------
 hw/mem/meson.build             |   1 +
 include/hw/cxl/cxl_component.h |   7 +
 include/hw/cxl/cxl_device.h    |  25 +++
 include/hw/pci/pci_ids.h       |   1 +
 11 files changed, 484 insertions(+), 69 deletions(-)
 create mode 100644 hw/mem/cxl_accel.c

-- 
2.43.5


