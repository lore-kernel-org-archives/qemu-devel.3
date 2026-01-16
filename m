Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B9AD4A61B
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 09:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vggAb-0002U1-KK; Fri, 16 Jan 2026 04:31:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vggAY-0002Rt-G7; Fri, 16 Jan 2026 04:31:02 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vggAW-0005Ns-Su; Fri, 16 Jan 2026 04:31:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NsOCzPk6sMfBh34vYbsT2Y4cVzfS0XvWnEbHMMuOmxYjrwXt/mHpUcyiViqFpqtZq3t3h0qJ7XCw9PA0eTYd2y5R+OHtwypDMvZNkhNKpW8RM+2iyvGP/mL84YV+IS5q2rbvkZBryYTAV7ugsbU7EJFMge6RcXkGTZJg8BEM90kWnMIa971OePXAuYOUVo+pToyLfITxnEDPUPdDycXs+WG9ClWqPqciBnTInLyuTKQZsPSBSQeXncOfdNGqFPhGuEFhRKNrQKVISYBYxZfviJisN6hmUm1lYdUIRlKY0O5Y4bNpoVwqdHF8GVIqvVOe3JMRgVlamOLlL+TXU09d3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1MQ5S3SxwrGXmVILpXwpinEZE750KSEdo/wFgyRZNQ=;
 b=c2OSoxdfBhn0UF/LTiTE3oP00ja1z/hw3da5NeNA7crj9n76wNtS4JfZLkxCkp6fznGGayHgleNIyaXaLr3cgcrjLI0REITCgw0jr84WOYkgpIkHRfC/9IEogZ1Jtoswn0SK/60er5ic06EFqZPafvpb7nicomKHlcCPGeXREN8FqTVoV5xlcsq4di8X0vI423u7RgqA9Vj34WmLQjRGOHavqpa0Lum2zPu6+Dm40t/b+C5vLWTonpfjt/sW+gY299f/89b1dgm+g+J5stcdlZPJI+69MMR6jGAx3mA+RJ1J0JBFFPk0AN3BF8Y5Uw7U7I3DdtWusmUuCaRKHtx4Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1MQ5S3SxwrGXmVILpXwpinEZE750KSEdo/wFgyRZNQ=;
 b=D2CPeRyGb7iNwm/qQLQwWSg4TyMT2Ir05sBFqtugc/K4UHda3TEfo7PFrLVEonuG+prH0AWyCpeJ5De9VsD/Cq6fMGN6SS8igV1CtD6CRzAMJQd88fk1MhptaNyKjfYGJ0iq6Yx87vZ8HOPYQU/oAJ6Pg5na7LDWReMkQ+Y+KHLemq6XO+W7G+e3w+gA90QEjiVVS8IOw5CcXMv87YyCNmFzy8362H2pEIfbeqhYdd+Si16g+9+Nd4LiIJbq0plDS+qZHsj3RYtzSKHxulIaAiE1kPxH/xwTZrAi/ktMCa0TutQTdpFvHZ/2njNgfyP1V7AqD754dTqbmVmlnrp47w==
Received: from BYAPR01CA0052.prod.exchangelabs.com (2603:10b6:a03:94::29) by
 CH3PR12MB8307.namprd12.prod.outlook.com (2603:10b6:610:12f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 09:30:54 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:94:cafe::1a) by BYAPR01CA0052.outlook.office365.com
 (2603:10b6:a03:94::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.7 via Frontend Transport; Fri,
 16 Jan 2026 09:30:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 09:30:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 01:30:38 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 01:30:34 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <alex@shazbot.org>, <clg@redhat.com>,
 <cohuck@redhat.com>, <mst@redhat.com>, <nicolinc@nvidia.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <vivek.kasireddy@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v3 0/4] vfio: Add DMABUF support for PCI BAR regions
Date: Fri, 16 Jan 2026 09:29:45 +0000
Message-ID: <20260116092950.15796-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|CH3PR12MB8307:EE_
X-MS-Office365-Filtering-Correlation-Id: c955474a-19c5-44af-a9e9-08de54e1f22e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|7142099003|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWhtejdFVTJFM0xNeHJ1ZlI1VURFcGJLNkVYOVRtUUtOeXRjNUsveHNIaGFk?=
 =?utf-8?B?eGRMMjhzZzBGM01MSi9YYThnVktwSjlZUHR3NjNTY1NwOWxaaTkySkdZT2Iz?=
 =?utf-8?B?OTg4UzBMY0FMbEVzUEU2Z2RZNE94ZnRWUTR1eEhNYW1TUW5OQXBzb2wrK3RS?=
 =?utf-8?B?QmJrWTYyQ0V6b3UySGNNV2dVRHdBcnRNRlBzQUVZUlJ2Zi91K0d0eHlHWUV2?=
 =?utf-8?B?WDJWZ2JSNGZoaFc0YVVBTy96RU5QYU14VmEwSHR0UitBTkxkT2k1T2JyZ3pl?=
 =?utf-8?B?UWd5RVBZb1J3T21rWVN4eTQ0Y09RME9zMWxTcTBXRVJYQ3dMbDE1SCs2NVBw?=
 =?utf-8?B?SFllVWFPaVFLMXFoVlJYMmtHQUxJMGdMaGcyV1NjVTFxQzFUcURIMkVWRkdF?=
 =?utf-8?B?aXNVVVd1VGNzNnl5NnBaMWFxYjB2R25JZW9FY1dFd0xVb05ydG4yRnNBQWpn?=
 =?utf-8?B?RVZDRldtcWpPSFd1dDFBc1VOZnAvQ3NESERTc1grajEvZG1TM04yOHpxSmxq?=
 =?utf-8?B?anJ5TFBBUHoxaFd0TkRYNUJEVFoyb0hncWp2TGZIUTZRVlk5K1gvWllXb1Q3?=
 =?utf-8?B?SXdVVDRWUWE0ZWFadXNEWnRlY3h3TGh4YStrMFl4aTZKQndSZFhrZklLYVBO?=
 =?utf-8?B?RDBlZDJwejBHaTJQTFBHSnN0VjBpOXZLN3Z3YUE2dnNWNjVSbGZoL2xTd3ZY?=
 =?utf-8?B?c1VWWFJTN3JabmllaUFPTGhEdElTOU5BTlBIOEtOTzdqKzY2Y0dJVGFrUVdz?=
 =?utf-8?B?NkpqbUZWM28xSFllV0h6aHBEOHRFWTNuVUlFQW9Ob2xoUjFvUFdHZHR2UElO?=
 =?utf-8?B?dS9vQzVLNXU5TEVpVDJPMzdjWDlpK3lUWkFETnpoM2tnUU5rdEl3bGs0Tmdt?=
 =?utf-8?B?SGFJaVFRdlI4ay8rSmVKMHlCN1pHZmJvMjl5ZC84V29jRVZPdjVqK25QRXVk?=
 =?utf-8?B?S0JjVS96QVE5S3lncm14QnpjSW4yN0crazlNL2tHRkVHNytDRjVDZXYwQzd6?=
 =?utf-8?B?VXNrWTdLVDFURWxsSkVSRXJZZnV4WUtDREszS0xDbmhTR0prYjZ2SGc5dllz?=
 =?utf-8?B?V1NPL1ZWTDA2aXlESytQVFE2NmNISWVjVE1hS01lNG5mRnYrd0ovUGIzbzR3?=
 =?utf-8?B?MWJaUnBsYWJLR0ZVYjRmcUdBaTRocVlnQ1ZjTCtlSkhYV0h4ekJaSk1kbThm?=
 =?utf-8?B?czBDOTZYR1lBSXJJTDVsQmFvNzNTbEFJUmZFbCt1VktJZ200WXZ3dEExZkFP?=
 =?utf-8?B?ajZtbEtaTFZSLytRVzZhZ0tEc2h4ZTgzSWcyclpGZUJlbnU3Zlg1bjhYd0JT?=
 =?utf-8?B?SGNXN3Q4ekRxVExhM1JDOE8wNEF3SmxxaUIrRURvcWh0eGFKaEdBczNKZVJ4?=
 =?utf-8?B?VHg4TkJnS01oV25yVlhDYmNWOWl3V0ZaS05VL3hTZE9pZnhGaWdsRTM2cDBU?=
 =?utf-8?B?enZ1N1VTRWtVb2EyMXVUbUF0M1ZtS2VWZkpFM1F3RnpNU1REdDBNZlQ3aExh?=
 =?utf-8?B?MGJQb05DRWhVYkZoYzFyQnRkNG1KM2NGdkllUEt3VEsrM1U2MUIrOXNtaDJS?=
 =?utf-8?B?ZkVLSE9JUEMyTVplSG85V2RnTVpmdWkxOHAvQUJlVjJ2UjMzdURjZzQweUha?=
 =?utf-8?B?MythRjladXlPck9tbVN0eVVLQVpXVGdVVVVWV2w0bjJJRW5tUStTZUxyd015?=
 =?utf-8?B?cVlRd1g1UmxwdklaMi9wbjBlRlRjV0NDcHpzN0Q1c3AzVWhMNmw4akpLcWE3?=
 =?utf-8?B?bzA4WUlwVlRmVlB5bEpxNUI0d3dENk5wdUZHSFowNEdwNlFNc05rMG5RNkc0?=
 =?utf-8?B?dGtOUGM5Z25OWURwWkV2V1AyMFplRXdzVmVCbE9RY0J6cjJDUXBjZjJ6Wnc1?=
 =?utf-8?B?Q2h5bVV0dUlORTFUUFZ1NU1Fa1BvWUVtZ2JvUWovUXgveVk1WjRneUorWnZw?=
 =?utf-8?B?eW5GZnhmeDNCWmFDb1VnVjI5MFJJY0h2bHc5MVBJN3NET3N2SlhOTFVtVUdm?=
 =?utf-8?B?TmlHd2lONXFCWFZjWW1xTEtNUDVTUU5RUHdndDh2bW9RMGtCTXVOL09qRm9I?=
 =?utf-8?B?RWE3US9GV3M5ZmYvRGd6ZVdqeFhXTGQxSGVxazdaaXJUcUQ0NjdEUHJ2TlMr?=
 =?utf-8?B?OVhpRy9UNHlpUVpoNnNSczFYN3I0UnlJR2tCSWNtcmtITkhXb2V3YzVVaXJM?=
 =?utf-8?B?UktPdHgyVjI0MjdEc0dxeXJHeEE2NVJUNDkwdE5PS1dSWGszVEdwNFVkcnpr?=
 =?utf-8?B?MGhEdXFUT2o1UXpVOXVyT21oeG1RPT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(7142099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 09:30:54.0040 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c955474a-19c5-44af-a9e9-08de54e1f22e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8307
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

Linux now provides a VFIO dmabuf exporter to expose PCI BAR memory for P2P
use cases. This adds support for vfio devices to create a dmabuf for
each mapped BAR region.

Changes from v2:
https://lore.kernel.org/qemu-devel/20260113113754.1189-1-skolothumtho@nvidia.com/
 
 - Addressed feedback on v2 and picked up R-by/T-by tags. Thanks!.
 - This has dependnecy on patches sent by Cédric[0][1] 

The dmabuf support was sanity tested on an NVIDIA grace paltform.

Please take a look and let me know.

Thanks,
Shameer
[0] https://lore.kernel.org/qemu-devel/20260112155341.1209988-1-clg@redhat.com/
[1] https://lore.kernel.org/qemu-devel/20260108185012.2568277-1-clg@redhat.com/

Nicolin Chen (1):
  hw/vfio/region: Create dmabuf for PCI BAR per region

Shameer Kolothum (3):
  linux-headers: Update to Linux v6.19-rc1
  hw/net/virtio-net: Adapt hash handling to updated UAPI
  hw/vfio: Add helper to retrieve device feature

 hw/net/virtio-net.c                           |  11 +-
 hw/vfio/container.c                           |   2 +-
 hw/vfio/device.c                              |   9 +
 hw/vfio/listener.c                            |   4 +-
 hw/vfio/region.c                              |  65 ++-
 hw/vfio/trace-events                          |   1 +
 include/hw/vfio/vfio-device.h                 |   3 +
 include/standard-headers/drm/drm_fourcc.h     |  25 +-
 include/standard-headers/linux/ethtool.h      |   5 +
 .../linux/input-event-codes.h                 |  14 +-
 include/standard-headers/linux/pci_regs.h     |  89 ++++
 include/standard-headers/linux/virtio_net.h   |   3 +-
 include/standard-headers/linux/virtio_pci.h   |   2 +-
 linux-headers/asm-arm64/kvm.h                 |   2 +-
 linux-headers/asm-arm64/unistd_64.h           |   1 +
 linux-headers/asm-generic/unistd.h            |   4 +-
 linux-headers/asm-loongarch/kvm.h             |   1 +
 linux-headers/asm-loongarch/unistd.h          |   6 +
 linux-headers/asm-loongarch/unistd_64.h       |   1 +
 linux-headers/asm-mips/unistd_n32.h           |   1 +
 linux-headers/asm-mips/unistd_n64.h           |   1 +
 linux-headers/asm-mips/unistd_o32.h           |   1 +
 linux-headers/asm-powerpc/unistd_32.h         |   1 +
 linux-headers/asm-powerpc/unistd_64.h         |   1 +
 linux-headers/asm-riscv/kvm.h                 |   3 +
 linux-headers/asm-riscv/unistd_32.h           |   1 +
 linux-headers/asm-riscv/unistd_64.h           |   1 +
 linux-headers/asm-s390/bitsperlong.h          |   4 -
 linux-headers/asm-s390/unistd.h               |   4 -
 linux-headers/asm-s390/unistd_32.h            | 446 ------------------
 linux-headers/asm-s390/unistd_64.h            |   9 +-
 linux-headers/asm-x86/kvm.h                   |   1 +
 linux-headers/asm-x86/unistd_32.h             |   1 +
 linux-headers/asm-x86/unistd_64.h             |   1 +
 linux-headers/asm-x86/unistd_x32.h            |   1 +
 linux-headers/linux/iommufd.h                 |  10 +
 linux-headers/linux/kvm.h                     |  11 +
 linux-headers/linux/mshv.h                    | 116 ++++-
 linux-headers/linux/psp-sev.h                 |  66 ++-
 linux-headers/linux/vfio.h                    |  28 ++
 40 files changed, 450 insertions(+), 506 deletions(-)
 delete mode 100644 linux-headers/asm-s390/unistd_32.h

-- 
2.43.0


