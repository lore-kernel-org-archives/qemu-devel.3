Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C2FEA7942
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vni86-0004RU-VY; Wed, 04 Feb 2026 14:01:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vni7w-0004Qe-8S; Wed, 04 Feb 2026 14:01:24 -0500
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vni7q-0007Mr-UD; Wed, 04 Feb 2026 14:01:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SK4yU3mPIBtTbY8jb1Mb5jr4Jbxs4ewAaW1J9++acHNGE5B59Ow30XGD5ZgKrUoa+lVd2IdTgQHEBh0pQsO4cekpACiwPifXQU0c34DdnLZvSJ6jY5L1NShG9ppEhqb0HQN/FjeSH80wRrYMAiNekw0dmI47EAAHOibs11DIOYPWHzL1rkH+NUfoFzfDT3QJyN/fXcRT/Hek1Cs7NeebyM47RlUHzs0VcuveC5iQcOhP5S8VRH8hNfrZJVMaaSwuZ3Q9o78xrBmN9ASDRdF0P7m+BIWYSZ2yKr9SBlMIWMtZJ7ZQmThNrz5XyzxjLHPSjUw/ORcH986dThczjQ9L1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nY1jUQXDtRsgLtcw5/7lOwR1WCKi6HUV/srERsVwcOc=;
 b=R1FbbTjpiDrHLhA2BvV8NWVp+TwSbYVQDHMJjjsIghK2rw0+ndJJ7PH8i+Pw37LI3nOR/YOHbSTGN7ofECBIBc5n1Zbnqk4r3tghvXZdUYf4GKo3wDpqBLYkIzyVUjmz6DGMk80trjVkRhX1dKa73pojj48f2jeKla9aFCnWxHcDWMmv8tGpyHGreVZIVie/fYVQoNYrgd+l2vP2VhXVaAGlWVYmx8AJ668GjZy7CSdqNve6oEgR7qZHxL8t8xvRZFegIfP3oxjo9wW0g6cLY8hfkULe3Kl5nc30sBS8v+aEosZ978nIIzYjsWazh/dXrq/ngfOuuJPtcd/pNDY49A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nY1jUQXDtRsgLtcw5/7lOwR1WCKi6HUV/srERsVwcOc=;
 b=qSoKGHbVrfvSxRseRZ8xQJNhcqcmhGCeO/qe7dQyP0+b/FTN8KqFwX8E5VRblVwgUGn8g6nCzy1Oruey4MEZEn0RwA7a6f88zUhzGJPMxoYbSLCEH0mfvQlsItDp4sy42HRBNuwOrXpWsW6JHKa1/YAf597EwYz7In2pSxYMjRnddcYXwM5DY6vrjSTx32SN9n1lm4ch4lQAT9VVb4nXD7svKhLzqoXcq0GUfblJtN1u+8BFo/ucpSWuie3e+YMixozV1lrTkRKsXMDGPhUZz7mo3kJLcsmebC06fM5uxjTMv4UrmFN5CuE/wFM9cULin12PqJubwA79EVAUyMD5BQ==
Received: from BL1PR13CA0236.namprd13.prod.outlook.com (2603:10b6:208:2bf::31)
 by SJ1PR12MB6315.namprd12.prod.outlook.com (2603:10b6:a03:456::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 19:01:05 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::8) by BL1PR13CA0236.outlook.office365.com
 (2603:10b6:208:2bf::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Wed,
 4 Feb 2026 19:01:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 19:01:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 11:00:35 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 11:00:32 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v4 0/5] vEVENTQ support for accelerated SMMUv3 devices
Date: Wed, 4 Feb 2026 19:00:03 +0000
Message-ID: <20260204190008.20070-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|SJ1PR12MB6315:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f0c9ac-71b0-4c38-7bf3-08de641fbf2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmY3RlV6bjk1dHMvbDJ3d1VkUDQxYmdSd1dRM3VVZ1piQ2FqZjdLWXl1eGdO?=
 =?utf-8?B?b1NjbzZSOUZSZW1qM3o4ZjYzRjBveHpjaTZBOTVIMFI3S0x0TTF6UWFQMXZ2?=
 =?utf-8?B?UlhQWHNPK210YzFQN21XQnduU0IvMThKWnZoV25YWlM3UXVRQnIwbTZXNWFD?=
 =?utf-8?B?NHFWU2cxSHRvU3F3YWM0a2hURVJZeGpIS2lodFJ5b0pnZWFnTHZ4ZFlXejZS?=
 =?utf-8?B?bjRtMkUya2MxN1JwQ3RCMEE5TlpSNFF0K2QvZGVUSUNjcVpzWFBEMHVrd0Ni?=
 =?utf-8?B?bXF6bnhuRUxFS0ZvOU9LZTdtajUzZmhRbmFrckpDWnR0K2VuOENsS3d4N1dx?=
 =?utf-8?B?bExybDdTVFFUaElsL2ZDb29DaFJCVHgyaU51bVo3OU04TnV6aXNJK2NmajRW?=
 =?utf-8?B?OXg0dk5mYjIrK2s0MnNGM01DdkgzbHVob203NU1vRnNPWGVya3JWcmdZYUQx?=
 =?utf-8?B?d0NHdlZXTnhFZ3V0RTc4SXBvYVRzVXRQVmRQK3p5UXQxNmlSdVJ0Y0Z6bDVu?=
 =?utf-8?B?Z01jYjBUOVhGZDFYU3c4STVQalArSVFleUQrM0thazUyZFFwODJoU1djK0pI?=
 =?utf-8?B?S25BYTY0Zk80dDVDM013enA5TkpZZ2ZwNStmN04zNzJJMjIzWjBDL01WcllF?=
 =?utf-8?B?dUovaXNyOHg5SElMQkwyalV4SWVFVDJVR0w0b2VhSGo0RGMzYjFSbG1CSzM0?=
 =?utf-8?B?NW11dWdoVnBLd09qb2lJQ2NIZ0JtdGFyck00ZWhSVDVxU1BNTXI4dGprbFhu?=
 =?utf-8?B?OXorT1ArZTlXRmJ1VDBKcHZTRFpkMDIwM29tOEYxZjNsR3cvME1nSEJiUGhh?=
 =?utf-8?B?YkZPOExrZ2NZL1RhS0NhbDFabmJVdzJZOUxjWUthdElPTXJrajMzS2UrcFFC?=
 =?utf-8?B?SHJDbGZjRVZFQ2o0MVo3My9jd0o2aSt5Z000Lzh5WmNBdHlDTjFxZm5zK1JD?=
 =?utf-8?B?VW8vcUcvdk1kRjdyNERjRGxka1Z0VGNBYTRLVm0zYUpScGpncGExKzkxT3BJ?=
 =?utf-8?B?cWNCaFpXSWJjY2gyd1JzTDNRalNHemRsQm5JRjYrSEdSVGk0ZGF1ak52SUVt?=
 =?utf-8?B?SEU4cDRUdU5rTTMwWm9FSy9pU1FkbDVsZkNnUjZCUSs3QS9QRkhDdTlTNjIw?=
 =?utf-8?B?YThqTkVEcUYrRzdBQVFsN0tWZFhxU2xDN20wYmMzcVpaRlhsU3gwODlrR0pV?=
 =?utf-8?B?M1dDOVBkRWI1RWxORVhhNkFaUmZ0c0xqYTNuSG1jMWJyNDJQekl5dllnQ3ZF?=
 =?utf-8?B?VFJxcGZzYTJRcVhhdU5JOUdydGJVZExJeWY1QjgzYTBFNEhqczdORDRKVi8v?=
 =?utf-8?B?NVVzT0svakJnOEJaQnRobTZqb2hDb245cXBiRm5tVjhEWExPdEdGL1d2Zndv?=
 =?utf-8?B?SU1KbWtqSHpjcWFleXR5bWNrbnFKSnhXTVlSVGVieStSMm5BOTVrNWR0R1RN?=
 =?utf-8?B?c0N0RlAwTHBuZFNmK1FBREs1SlV0KzBuUFFPLzNpY1RiT2VvV3lKTGlZaUZx?=
 =?utf-8?B?bWo5SzBNcmpJNHR4NEdqdU53YUYyWW9NeVBSRk1BZlA5VXEyenFLWnZncEt1?=
 =?utf-8?B?bWd2c1FDMUJIWlMrK3c5TzdGdmtaTy9kRTkyZDh6R0hYaDB1STZ0M2E3d0tQ?=
 =?utf-8?B?TlNYUlNFQkRDOWtpdm1yeEw2V1NxUEY2OG9IeGMzNFZxY0o1NnhKV3lrSWpy?=
 =?utf-8?B?bVFlS2RqY2U4akRpVFZGMlp4eGNzcGFhWC9aZ25hcTRYMHZhMG1QY3c3NXEv?=
 =?utf-8?B?OTd1RFNaUkJrc0VoRWh0RXpySXlNNUVRSWR0SjR4RDBrL2FlVGxQejNwYUJH?=
 =?utf-8?B?anZja0tubm9INjBENXU4eWNORVhXT2NGNFRUQXMzeXZGU0Jtckh5eUlHbDFa?=
 =?utf-8?B?aDJSZVJPOHhqa3c1QnlWNEcwUkxieHdKd3ZiTE94SERhamlCTC9aYjE4K0hN?=
 =?utf-8?B?Yi9BenV2dHBibVFiYWxNWHNqNlVMOFF6L2lRakVEeVAxMFJuZHZjSmV5cWxY?=
 =?utf-8?B?Rm56S2phOVNYbFVDTVkxS1pCUFduYXpXVXNOZnczVXJDc0t4ZXA1Mkp3a2Z4?=
 =?utf-8?B?WStLdlZWK0gvcHBkYUtQRHJqeXA5Z3kwSzZnQnBqNU9YY0I0ZDhqQ3RYTXpx?=
 =?utf-8?B?MDNjWmx5cHBSQStzYWdzaDBJN211U2ZQVGRrd0lsYlhTbUZhdG1iU2NVUU1p?=
 =?utf-8?B?dmpqckt4S3JQa2xia1NNOExWenB0V3NmRkVDWU1haFhPZ0dyTlJ5RkpkK1RD?=
 =?utf-8?Q?LT65hC7FIQ9tVI6GggmCWQQASbv9S2O8NUJoMS/NLg=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bFG+zE5pHmWGBvtV4ZCR7Ts9LapZXdqSw9abWXdJZVxQgfiePqIn6HrNjuWlY0Tq7MJnm85GxcJ96ajM3i6p5bo41YQYoz8YFg+6NODF2TjJGfxnI/gKa0teBUNlrkDKLsEXunF7qPl5LjIcoO7YRlgyWNp07BDZXWPiHupT/unZ7rgoCVc1Mp9AyqxCspyVgvs0mUOL/YBpTsSCoS+RT8ki7vFYNerKMQ+lCNZ8G5oVEiWuM14sYrmqBFtW5v2mw2PT0SbnxbpNq0Q6acn0dRvL5pfPer9KM4xUlZI09gJXwOLYJIxcvixvIU/DH/0uNg7Q+1KpJuZ0gOudONFUKwPFAyO6PPSF0JPeWWbIDX158vg0tAdVNxlOgaRUEAPjpZ/xMZ55Uq2Nz7V4T70LtOJFXtstiChvuG0XM98Bco9qltTY4zYGVfW+4xUWTMJf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 19:01:04.5346 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f0c9ac-71b0-4c38-7bf3-08de641fbf2a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6315
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Changes from v3:
 https://lore.kernel.org/qemu-devel/20260127103328.255382-1-skolothumtho@nvidia.com/

 -Addressed feedback and picked up tags. Thanks!
 -Added an helper for viommu free(patch #2)
 -Removed explicit overflow handling in sequence checking,
  since sequence numbers are uint32_t (patch #5)

From v2:

When accel=on is enabled for an SMMUv3 instance, the host hardware SMMUv3
may generate Stage-1 (S1) event notifications that are intended for the
vIOMMU instance in userspace.

This series adds QEMU support for receiving such host events through the
vEVENTQ interface and propagating them to the guest. The implementation
uses the vEVENTQ support provided by the IOMMUFD subsystem in the kernel.

I have tested this on a Grace platform using some hacks to generate
events. Further testing and feedback are welcome. The complete branch
is here:
https://github.com/shamiali2008/qemu-master/tree/master-smmuv3-accel-v9-dmabuf-v4-veventq-v4

Given that the accelerated SMMUv3 v9 series is now applied, I think it
makes sense for this small series to go along with it.

Thanks,
Shameer
[0] https://lore.kernel.org/qemu-devel/20260126104342.253965-1-skolothumtho@nvidia.com/

Nicolin Chen (2):
  backends/iommufd: Introduce iommufd_backend_alloc_veventq
  hw/arm/smmuv3-accel: Allocate vEVENTQ for accelerated SMMUv3 devices

Shameer Kolothum (3):
  hw/arm/smmuv3-accel: Add viommu free helper
  hw/arm/smmuv3: Introduce a helper function for event propagation
  hw/arm/smmuv3-accel: Read and propagate host vIOMMU events

 backends/iommufd.c       |  31 +++++++++
 backends/trace-events    |   1 +
 hw/arm/smmuv3-accel.c    | 144 ++++++++++++++++++++++++++++++++++++---
 hw/arm/smmuv3-accel.h    |   8 +++
 hw/arm/smmuv3-internal.h |   4 ++
 hw/arm/smmuv3.c          |  25 +++++--
 hw/arm/trace-events      |   2 +-
 include/system/iommufd.h |  12 ++++
 8 files changed, 212 insertions(+), 15 deletions(-)

-- 
2.43.0


