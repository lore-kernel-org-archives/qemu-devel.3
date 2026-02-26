Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F88FC590F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 08:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvX0R-0004sc-9p; Thu, 26 Feb 2026 03:45:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvX0H-0004r5-Pn; Thu, 26 Feb 2026 03:45:49 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvX0G-0004xR-1K; Thu, 26 Feb 2026 03:45:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zIPUwuAhOhari7ZCd6Ei3XmwFto3Nx4Nm02fASG4FxQ239VngCGf9PB77x6Xzyh/7L3+gszzhDwlfnQZLN3krxDDzk5/vgECcYDVnTfMW1vCv24r2iQOVDMjfjO5j1FlzilnXUju8LFp0dxRsipFAf+Ropf68kI0QEK8WIhnOhahKsm26BpBm1z8ZrGKhEC9nw6dNKlm475quJXitBnEmfyar+wgv8w4SDxDDFD6yvZH2c0tKm+vCSP6WfidGqpwbd/dirxC3PhPfjM/5Cctp9R+OF9ppYXeXz6udsW6KWYNVSkwQeWiULW1d9Ml1vhRNyGUvMB+HFtxBBE9vC3bxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpQ5g7zaliFFFeQEJLOzI+BzsbUuXcMQbUCpGjNZ8Cg=;
 b=CKYX2Xek6m3FsYZLwyHfORtRiVOqqarbnpzbiZRoGpPcjnDnwjuJVQE/bt4XBaOPXX5MvD2I1pRgJAJX03mAvYCsa3pFv2KstywK4hOfyJeiF4tp44hPUAY0tpbmDMaiDsj6gZjQfUUvc6AAyv7zzHkcIoOgnCD7N+s7l/uxwLWfe+Q241IIHSq97MWc3OGcjuguucBNL12GaAqRwnVs+qzPfTQ9uO6J4dxoZQbpDIH8VqppjHem73kDoHbEImoKg+/12Hb3YESRSySDN61ZtYbJ425DoxSO5UooQajgcQLrCBqYstXQt2Sv0/kIp5sJhGTRqS7CydyvJxR9zjjnbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpQ5g7zaliFFFeQEJLOzI+BzsbUuXcMQbUCpGjNZ8Cg=;
 b=mKVLZt8aZi5j8boi02iYpnDyDa5j9o2vffzHlrrNQAyxM90GSBIDNu+1PRgS3CSxPtblF1JnD5M59cxPRPxYzV3jAekhCFUapoaiiE3dBetBgkDWmpnHR09um+EudUVCZGc4WXATUUaxLa/aODOVmGhchYUl2hOMscq6G8c47tCt9at2UulRNnSiMuMo6hBLo2fVxAP7w19Z2xH0AGrGl4f7pZiojSapkxhsKIsr6+0UUyIPugvbfONCKiL7ktPNmcax8xNMq1InGN0lvT3Jq60un/ApAeCdrRZnHoEJaezNhGyrikRPpCb8+KdGGxAYRbvWur8U52smX9ZOHuUo/g==
Received: from SJ0P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::31)
 by SN7PR12MB6689.namprd12.prod.outlook.com (2603:10b6:806:273::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Thu, 26 Feb
 2026 08:45:37 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::e0) by SJ0P220CA0011.outlook.office365.com
 (2603:10b6:a03:41b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Thu,
 26 Feb 2026 08:45:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 08:45:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 00:45:17 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 00:45:14 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@nvidia.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <philmd@linaro.org>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 0/5] vEVENTQ support for accelerated SMMUv3 devices
Date: Thu, 26 Feb 2026 08:44:51 +0000
Message-ID: <20260226084456.112142-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|SN7PR12MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: d33ac2f3-9428-4229-95bc-08de7513696a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: Nw5kzv1XMoOdU3BJxBps6Zy8tNcF32OgtZ+/Mbd5dFSBPup08SrssH/UcMSRV+W43LNujNXGs5ccKpJYkUFc7lVrd2QRtkRmKkYkRPOtoWhY61xSvXJbmnCGZdOE4bh/C2dcW6IUde7/WHv0wbnp7lQIBNBbbn5UtHEIVidCu8ROpkMN3ypdodFjJk0Koo0G150nxR2UFXl9c/TVg/vy/FnwI4F/p4SJ1ZL9u1pg384ins0WkCJJkxrECdIPpwdUpIYJAKE+hx4r+kBbRk9SwTzqYYI58AoetZkatseXqNQLPtRD2X8+gwtI2+w4vCZigIGoG8H9FQ9bWMCyc7NHBYQUe7SaiFD0y9kCWfjmnt3+8Rx8rgPM8YV8cFruDo4lY6Ong8FlU1plgZ11U9ZDFtKBiy4c1gEmQa2zmOHUBsgLrms0kwabdbHHRVN7WQc9YcH+/i/d08GtMtPqTnV1Cf5yGYOtxoB9qHR5/ODqLrf+J+kXvgGOAns0L+vkYTRmR7YqDVG2EkJtctA+bZQvPcrWJ6vfSrotHLbQ+DfM8z1Tk1jFn1qincJBuuxS1x7Dl1lBgBChBHr9Pys4IYxmXw6lJ96zGorWaQ0RwX3l9iIbG1aRoPZh8L+5UKdvBWZGtw6ePW/w6EUM4NYuEuwOPbjUnIN2lx9OCg1RadImY107qkE1vMPH/KXGBbwh5jiCS9diRTHLkJw8U6xVqFg/RhVWaCdxcZiyan4aPf6sYqhbSG/o3M/YgxaeKMak2GxyNFAoNMrqXUyQiSUEKOGiQgeCoLKoxFt/+IX41+SlbCPtu+F/TtBUPYjWKzQJdnoq2EujEzch+E9O+Bjy2Mt9ug==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: doqabN5jIHLrYbU9LR9sznX25Bs6srhzJMkUg/qtt/SzU3aGkNzCVKWWpx8sdKePuNeUEGhjRtNBBLmUML8+wvUArPZRQVnP8WTQ2x0F2QGOvg+8ZHsvvkgE5xHkIQcySDuqe3F4rlB1B5p5YBzJN+re7q8ulx3Lx+igFZCxB6YQ2H8YeJu/QH9V97O5qDBbLYyuCstpLYhAnbzPi61x1OJ9usHsXRzU4BUe+FbY7PZ3Udqxu7M6gsYMGZQLng7BjaGmQ8MVAMHnOau9+BvH/KfjlCbctly0uEm62urykpRJBP/l/xDPXGcfp+8bLFDD7vSR8JxGi1h40mLSWYdmtspzJhF2qG03gH6qtgutXb88Zcmkj2WF/WX4n4N/62QdJqrpneCRr3Mlts1omDM++Nnz/Shu+FBnZ/xyn80bpw46KULILLocFieK43N7Kmo1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 08:45:36.3658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d33ac2f3-9428-4229-95bc-08de7513696a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6689
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
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

Changes from v7:
 https://lore.kernel.org/qemu-devel/20260219090103.33697-1-skolothumtho@nvidia.com/
 
 -Picked up R-by/T-by tags. Thanks!
 -No code changes. Commit messages updated to improve descriptions
 (Patch #3)

I think this is now ready for 11.0. Please consider.

Note: There may be a minor conflict with Philippe's CONFIG_DEVICES
cleanup series[0] if that goes first.


Thanks,
Shameer
[0] https://lore.kernel.org/qemu-devel/20260225031658.32095-1-philmd@linaro.org/

---
Background(From v2):

When accel=on is enabled for an SMMUv3 instance, the host hardware SMMUv3
may generate Stage-1 (S1) event notifications that are intended for the
vIOMMU instance in userspace.

This series adds QEMU support for receiving such host events through the
vEVENTQ interface and propagating them to the guest. The implementation
uses the vEVENTQ support provided by the IOMMUFD subsystem in the kernel.

I have tested this on a Grace platform using some hacks to generate
events. Further testing and feedback are welcome.
---

Nicolin Chen (2):
  backends/iommufd: Introduce iommufd_backend_alloc_veventq
  hw/arm/smmuv3-accel: Allocate vEVENTQ for accelerated SMMUv3 devices

Shameer Kolothum (3):
  hw/arm/smmuv3-accel: Add viommu free helper
  hw/arm/smmuv3: Introduce a helper function for event propagation
  hw/arm/smmuv3-accel: Read and propagate host vIOMMU events

 hw/arm/smmuv3-accel.h    |   6 ++
 hw/arm/smmuv3-internal.h |   4 ++
 include/system/iommufd.h |  14 ++++
 backends/iommufd.c       |  31 +++++++++
 hw/arm/smmuv3-accel.c    | 146 ++++++++++++++++++++++++++++++++++++---
 hw/arm/smmuv3.c          |  26 +++++--
 backends/trace-events    |   1 +
 hw/arm/trace-events      |   2 +-
 8 files changed, 215 insertions(+), 15 deletions(-)

-- 
2.43.0


