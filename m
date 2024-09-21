Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7456CCF9C5B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2024 11:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sry75-0003MH-Hk; Sat, 21 Sep 2024 07:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiw@nvidia.com>) id 1sruPP-0001wl-7p
 for qemu-devel@nongnu.org; Sat, 21 Sep 2024 03:19:59 -0400
Received: from mail-mw2nam12on2081.outbound.protection.outlook.com
 ([40.107.244.81] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiw@nvidia.com>) id 1sruPM-0003Fb-UQ
 for qemu-devel@nongnu.org; Sat, 21 Sep 2024 03:19:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMPhbPoWZpyr0wrDIGtwI9EzrVrrPTuSlU8qp/W1B/gQfdbkpflUF+TwlrtjudfJmFLh1rlmP2xt6FltncnSenqoS3M+nhYfD/fN5kqfO53+Pe0DgZfFhgMsBzerPw5w6KG6MOAcDW4VFgDhFgyvqHDg1GDFAIU7fuqNyj7fNdRSYfkWj8vkQQRTE5GgW+EPGJgxu4u3lR/x4D+C/42n6y2oWs9KWjETzAFdBfiYOIJVq6tq3Zq3Fe7ZbLBRpFUwJozrAfZNYCLb4gqNfrp0NLJHjHpOm5vPEY9HWzOobL/ff3KRP6ZQ4rbXYafRIwdTeEda+N0fEozlNUiQWSr8MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBDwVbLm6vfmJFsa/Q0ax92YXqeWMa5oxkcvuAdppBs=;
 b=gQcIpXWKGy8Pj/0O2ET1EuiAOFtlW5GfhjZsXDKzH7j9VyjE6q8MbLBefxRNvTr8aCVf79yFcjh5nkqOTmJ79UCezASRZOnV+9dimlDNVQ+mnzwV/zUlMuXsGe9iL9bjBaY9bj5GcuzIJen3HYKGZFALC0ucRrgKrnY4j1QBeJabTxGPDIsNH2Xk43nrQwej9ddGhVJ1iu7erV2xof2FBVnxmyBus/2SzBMp5zluuFtUrWSc4M78TwtgZYuazJVMBjEDCZIuPk1kZR2oUEl64ijSRL0OsQinXrFDZJQCjf4eDdB5VFX197pEInsZvXVtzl51mb0lCvZzAayn9mdXig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBDwVbLm6vfmJFsa/Q0ax92YXqeWMa5oxkcvuAdppBs=;
 b=Fy4onrKX83K3EpxpMaONYgu9K4QfB+BP2D3UHwvHsCC99OFrVKL2uKPBI1hwYgNBS05kygdosi5EB7mL2HRpBuWFy6y97KKo+WQuts+jjVycWPcHiWr4apWBPIPKbC0+Katb7uxkXgjIC3jFFUBZPccIhJBoJmqycSG5BeVwNCwco+vr7NMPANK7b2zeB9mqNIB6nGQtXHLR7A2pSE3/Knp2F7SZ09INy0dnRIrlLIBrvq+LkIqYIuKcGz9x5QJ9sVzo2ki+WBYUrQh8+YFcxUSv1zbGng/hi8LQPKwlKG5YVz9LlAJwTVMiDLClERBTJCF7VVpbMilReGGBDiBV1w==
Received: from CH0PR03CA0362.namprd03.prod.outlook.com (2603:10b6:610:119::9)
 by CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Sat, 21 Sep
 2024 07:14:48 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::3c) by CH0PR03CA0362.outlook.office365.com
 (2603:10b6:610:119::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.29 via Frontend
 Transport; Sat, 21 Sep 2024 07:14:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Sat, 21 Sep 2024 07:14:47 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 21 Sep
 2024 00:14:44 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 21 Sep
 2024 00:14:43 -0700
Received: from inno-linux.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 21 Sep 2024 00:14:42 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-cxl@vger.kernel.org>
CC: <alex.williamson@redhat.com>, <kevin.tian@intel.com>, <jgg@nvidia.com>,
 <alison.schofield@intel.com>, <dan.j.williams@intel.com>,
 <dave.jiang@intel.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
 <ira.weiny@intel.com>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
 <clg@redhat.com>, <qemu-devel@nongnu.org>, <acurrid@nvidia.com>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <zhiw@nvidia.com>, <zhiwang@kernel.org>
Subject: [RFC 0/1] Introduce vfio-cxl to support CXL type-2 device passthrough
Date: Sat, 21 Sep 2024 00:14:39 -0700
Message-ID: <20240921071440.1915876-1-zhiw@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|CY8PR12MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: 57cae869-804a-4a0b-c45a-08dcda0d13c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2m2zj3KceAhytFwKNfodHFQ1sffwZ9NEYW6d8zVZfny28b4xUv/Mvl91HnhT?=
 =?us-ascii?Q?wNXDv+CgTIQfRhNFAmaOlXlCH/s72aDjUr51Fv6N56AIa2TdyNeD+L5QmtAg?=
 =?us-ascii?Q?WBU+si2c703+z/wHwZr56eoAd3dGZ6dNFZ/modIinaE8XUAXngCSXfm56GlG?=
 =?us-ascii?Q?MD5ylivNpRWL9I49yMevi3nO6L1mrPo1SgC1+iCWaIpK4eXPn1Y0x2IJ4qlQ?=
 =?us-ascii?Q?uTDp/C/CWGNTQZmvGyhLpz8yIjc8N7DhJbPdF3uKzwyatgtioVHjA1mhE/fz?=
 =?us-ascii?Q?Y/SNjDydrDaUntJHhsYlBBDY1HPtLFi8oFMYamOw1YY9bTGPXRh3ES0owDoP?=
 =?us-ascii?Q?2Nsvlc9SNa79YjHypfCQ8wtJZaNqO0pRwjTNwrh2kYzztSj/+kTetnNcgcvP?=
 =?us-ascii?Q?NEuxy/jDgHxEry0Yznggv+LT+dDV6KZ/sbfxRtoz2z2MSQxSK4zElbcYscZw?=
 =?us-ascii?Q?hYvVIJrl8sc9I5PyXuZT7ubSomnvKIXkENMs7/1vc1v0qIzPHNFcVZOYGYWe?=
 =?us-ascii?Q?xhBF0HHrLkEaGy7kshJe1CDvfBD1IKihCYwltzjBdAlVJW/5vWaHAmI+cYze?=
 =?us-ascii?Q?ikGIzv/TNMuNW9o8k5DPGRVkPsSgMjzBjIAUTkBh9YQTSJZjph2Dcx1ZD+2N?=
 =?us-ascii?Q?GOMQ0h4zP5OOeamPdORl1r2VQjSchyTjiCyccz++CqDZF4IW+tE/w3o4dNOY?=
 =?us-ascii?Q?X5Gd+SYl8a6oA6BKSP3KdggOp1Y4p+CwFVs23NToCpTOZRjfkUMPwLTPFzFw?=
 =?us-ascii?Q?dA24um8LRP61+VoZozD5yBVOhDSdpVKqS5boLuR22lNdLCHt8c4sHrhwbrCK?=
 =?us-ascii?Q?RWiifbm15XYCH3V8b5OHr9MCPhqiG4IYcYizTG8cfbJ9GaddnnH7YmWBYPU+?=
 =?us-ascii?Q?K9YwOQVSunfakLvCu2KjD3V3dEq4KP/PaD94WF0GRG36//USppEwFIgYyH3l?=
 =?us-ascii?Q?vp1DvUNwqeRf1xYIjT8reKclZJihFASVeFnDSO3DQYL/w7ggdZyw7s8bOky4?=
 =?us-ascii?Q?nEWfpidP5pU+0f3ecQKHOZ4hbAaTgqhD276NartHIu36aLvjEs1FyusQg3Ne?=
 =?us-ascii?Q?VpjxM3lcFJFFuZFzXM3ILez7V2lxxfNV8eLg4SfD9tOH5xE2mF6JvsvL2/Ib?=
 =?us-ascii?Q?dfzyPLFlLMA8JI8wDJ4IgNrEL+8ZpPSrC5pxu9ZmItAQbSGBPKVIUPC5PJIu?=
 =?us-ascii?Q?059AzwAAVlmpvBY1kUrVamuLO4E4H0AnbSUejz+olwo85LjzdjkyWzIxx8EC?=
 =?us-ascii?Q?I4MOnVWUeCAqsEYyk0Bz+Q62tDVlhopg6gPnmrvbS+CnSnVG2ujimztc9KA5?=
 =?us-ascii?Q?K0mwvLFGxuOAQ8t6/r1JQbHdAxwx5KGjvrID23Aga92sIZKhgb7ZIZQL1mvh?=
 =?us-ascii?Q?fVTD81ujERap+WHbR8rJ9XWoVj2Q?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2024 07:14:47.9559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57cae869-804a-4a0b-c45a-08dcda0d13c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7099
Received-SPF: softfail client-ip=40.107.244.81; envelope-from=zhiw@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-1.048, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 21 Sep 2024 07:17:16 -0400
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

Compute Express Link (CXL) is an open standard interconnect built upon
industrial PCI layers to enhance the performance and efficiency of data
centers by enabling high-speed, low-latency communication between CPUs
and various types of devices such as accelerators, memory.

Although CXL is built upon the PCI layers, passing a CXL type-2 device can
be different than PCI devices according to CXL specification. Thus,
addtional changes on are required.

vfio-cxl is introduced to support the CXL type-2 device passthrough.
This is the QEMU VFIOStub draft changes to support it.

More details (patches, repos, kernel config) all what you need to test
and hack around, plus a demo video shows the kernel/QEMU command line
can be found at:
https://lore.kernel.org/kvm/20240920223446.1908673-7-zhiw@nvidia.com/T/

Zhi Wang (1):
  vfio: support CXL device in VFIO stub

 hw/vfio/common.c              |   3 +
 hw/vfio/pci.c                 | 134 ++++++++++++++++++++++++++++++++++
 hw/vfio/pci.h                 |  10 +++
 include/hw/pci/pci.h          |   2 +
 include/hw/vfio/vfio-common.h |   1 +
 linux-headers/linux/vfio.h    |  14 ++++
 6 files changed, 164 insertions(+)

-- 
2.34.1


