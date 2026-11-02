Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E51606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 18:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hkUyYwgY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNwXR-0004yl-Tk; Mon, 02 Nov 2026 13:13:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xNwXD-0004vf-ID; Mon, 02 Nov 2026 13:13:39 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xNwX9-0003Yr-Hs; Mon, 02 Nov 2026 13:13:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZK+cLvk91NTdwB45fB54fdvYcbNDjtNIrttqaYlhf8XPjPNM6/VDZ+Jd5MmZIwSaVmQiU3OObQoScudSf7opMVzGADfjQc84Kke924RRzISivDPWRdE+8hHhE+tLex2CSJem6c8ANbLVrUjBpq3Umf3l82VKEPNCBQ6BKjK7wGUkmfblbhLGo9yrMec0+jtrTesIpZq0sg7DB/Fhr5EtFQPyM7qDn6Edr7nVqX8FuRiACPSdt6kBQNp8bFkJK3PgQ1z7wdhqT1p2g3B7ix51T3WXyz3mxZYtwZOZsoTsXIHWN65PJv7bEAdPlRrtEehmMd6IRRYZXFI6tJuzo+2eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdBh7qEPaosmkVuXl4SCo6IOUmSBfPREroHerGR4Fio=;
 b=Jgyws37YxghiLt5l5q6Pd/w+kxrUy1PQXVXYzv5oslI5WtOg/ZUgKsgFXNgWRfrjAMyuOmKYHcTkBXXj29J5ZhrspXmpHIIU8yLhSrUF3ZOcPkuLNp2BcDAh0X00bNCPIsjNGS5JCBXXwuliMwEeBccJiFNpFgrqM2j7GSGtA2HRCje2uCcPJIGrJP8eb3wwKmo4j2HFHUrc3SL2vxJAsyLQyY1JYkkYjB+39u8Tc5PC7N4q7vsF7AIvOWpSvngEtpw2R7mvZ6dK204A6uyYZRuwrS0dY52kHEzQRdAGii6jR4pQk6epkOjJ7Bxc6pLGBuF1QXW+h0Iu2Fz6YYPYZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdBh7qEPaosmkVuXl4SCo6IOUmSBfPREroHerGR4Fio=;
 b=hkUyYwgYfijYCSAKlgnzENDX/bkBiLhjI3gBnoaCC3ZhMI3Iz7Lf+nXvAktv1mBeYd4K78txoRLhr2A4NN6tQpa9f0MwCK2+9p6As05mNshuoJTbMJ3NhewonB+R1dIngxguVEaCywa6d6EbCyeRWjjwainy3dGjjFf70muoPZTFALE+aSNTFLxg0H4EbqQ35goQUw/s0CdXa1AU2mFowbpKRE5q0SqmPtTxDisTY9wdHXfO78/ww3hXrMEGgT7VnYz9QOoi+CqDTTjRQuJjP5unZh2zHkWV2cD67JOO7X14/Cvcs6YS8np/B5v4DnU+LBCp2HeJbqGdftNrJwqAMA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by BL1PR12MB5993.namprd12.prod.outlook.com
 (2603:10b6:208:399::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 18:13:05 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 18:13:05 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel@redhat.com, devel@edk2.groups.io, alwilliamson@nvidia.com,
 jgg@nvidia.com, skolothumtho@nvidia.com, ardb@kernel.org,
 kraxel@redhat.com, tdave@nvidia.com
Subject: [PATCH v2 3/5] hw/pci: add fixed BAR fw_cfg blob export
Date: Mon,  2 Nov 2026 12:12:39 -0600
Message-Id: <20261102181241.3077981-4-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102181241.3077981-1-tdave@nvidia.com>
References: <20261102181241.3077981-1-tdave@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0044.namprd04.prod.outlook.com
 (2603:10b6:610:77::19) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|BL1PR12MB5993:EE_
X-MS-Office365-Filtering-Correlation-Id: 6405cb2e-b1b4-45fd-4bc4-08df390ceede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|261021123027099003|260925021311599003|260925021911599003|260925022911599003|5023799004|261026130827099003|11063799006|261021133027099003|56012099006|261021135927099003|261009223027099003|261028144727099003|261026135527099003|261021121427099003|261022115727099003|261026140227099003|261022075727099003|261021130227099003|261026121527099003|261022113327099003|261022105027099003|10067099003|22082099003|18002099003|261102123227099003|6133799003|3023799007|261102130727099003;
X-Microsoft-Antispam-Message-Info: Ce3mfS/QTVmkStTA1H75gDvhFvQEATf64/qojBi+QxbLChRKXE8SCUgXiTp74AbNt4kf7pTHgns6IHj29RCK4On3788+oa7w2K5WhmTsqbSa/zUt57rPuZpvQBQ+OJPImRToHaQra9k9SHZ97PCo1k9XGQswhOFvi9B98E6e0DcAfcKiLo0YcqjRVieWGVke5qHb6qGzuws0fuAME+dBvJmu3RUBy+PuHdCDczjuk2NF2rHdZG44iIbUNKGfmDH+FmoKi24EGK1iUWyfB3EVzJpenGJX7HaPPRz93ftLPMy3p7KHrUjAaYe5oi6OHFOJhxe4x191p9/zCywu+eNtU1T5D12McaI5Nqmj1/kbIp8rUrj8rBHFTOc0J3B2n51DGStasYTzm/vt9cez64WIpntu0m1DZUGTw4aBIabwhSk42caE2xL7pv6vkKsDPJEVn9qUNKhKgGRR3y9VqZ7hBOQIUX3EX763f9bQdMBlcnlIJyXJN5OydRD+PoVd90NWUTQqOzmnES0kujhJgYTb72+DSgv9pzXhh8wRZtZUKirxINy75MsQh7dvMIoQ3l3zxyrq9lX7SeXCyiQsaQusakBgbYqnnY22f4c/q10IIQlKdeVPjGGWl0d637nOhT460gvpP4kTeFot/BR8gj046B19jsZcLrjPZtByHz9Q2PI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(261021123027099003)(260925021311599003)(260925021911599003)(260925022911599003)(5023799004)(261026130827099003)(11063799006)(261021133027099003)(56012099006)(261021135927099003)(261009223027099003)(261028144727099003)(261026135527099003)(261021121427099003)(261022115727099003)(261026140227099003)(261022075727099003)(261021130227099003)(261026121527099003)(261022113327099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(261102123227099003)(6133799003)(3023799007)(261102130727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHBmaWg5dWR5cnphQVZOdGtzWndudFowcUU4Z0pOMnI4c3pCVzBIWjFlYWpU?=
 =?utf-8?B?bFQ3YmhNLzZLU1Z4M2ZIVmRRVjl4OERxS2VxMlhoNWtTc0lMdGl5NDQ0cXJV?=
 =?utf-8?B?YWZYL25ibnJQMThhWUk3Sk1RRlNmZzBKY1FvTVNIWmxyRGFTNUtDUG50NzlT?=
 =?utf-8?B?VHpRMjNJR0ZSbTFGbXlSZ0IxOHhqbDVuZk9hcjl4TVk3SnZpS1p6bkUvNzU5?=
 =?utf-8?B?dmhZQ3d1MDJtVFR3UElYS1UvNWM1MzM4UFE4ZWRGNEpYdjR3d2NjSjJKM3JK?=
 =?utf-8?B?TVdyQ1lnbEdXYUhpV0diNDJHbS9Yd29WTUNDRGttdnN2ZVgxM3RpcDlCR3Jv?=
 =?utf-8?B?R0dYNm1DMHRRb3FVc2JYRkxLeDhzVk53R3FUY0dZclFndVhsMWdDcy93M1J4?=
 =?utf-8?B?dXpzbUFIVStCbzhBdmM1WWpGNTRjbW9BT2N4c2l2dldONnFmR28yWU4wYVNY?=
 =?utf-8?B?SVR4NElMTFhaY2lmSjM5VFJ3Y1ZQUE9ycjIyKy9tbHgzbE1zNGxEUW5iQXVi?=
 =?utf-8?B?N2YrdFhKQk1nTERjN3laL2lOS1lWQ2ZHZVlwSitDOFh0K3JIR1RKajR3Z1Ew?=
 =?utf-8?B?V1RlVWVMT1V2akY4cVExZ21VRjFkMEwyMVJzQ2RVS2JFdFV2dnhacEdOVkZO?=
 =?utf-8?B?TjVtNFJhZHRReFNGelo0TENRL2N4QitiL29TaGFZR3l2ZzJBUnpMSHVRTlRB?=
 =?utf-8?B?UHo3ZDNlTDJ5ckV5STg5aEVPT3oyd0R4cVdqU2NiUDZiWFlPKy9EZ3BseEF3?=
 =?utf-8?B?Y01BRUEwMGxSbHkwWWh3L0VJQUpkbytOanN5NDRSRGhMLzV6OHFNS21rVUp1?=
 =?utf-8?B?QkJSYzlaMEZJckpSL3F0YkVWZlFiR25veE9Kd2VyV0ZZbC9EN1M5c0VIQ1lo?=
 =?utf-8?B?eXljYVFiaWVkdVJZWlJpQTd3bG05TjdnSzRHMktiVU40bDdzUVlBOUVTUURo?=
 =?utf-8?B?TDlwM3hoYmV2TEw5YmdkN3NVR3FzZUZuU0ZpOUloNkcyRmZaRTgxTldSRTRi?=
 =?utf-8?B?dUhBUTdaUEJ5cjNPTGRkNElUeUJ0R0xCMmtWdHMvdHhzRTBuY0QwbHRWTzRR?=
 =?utf-8?B?bUlRSG8vMkpJMTJ3aWJpMzhUdm02eFdHYWh5akgrQTdMem9Fb0wwZkQ4Nnll?=
 =?utf-8?B?L0FRNnR0NC8xaTBLYm1BSXlJdmQwS2xOMEV3MDZDZkluZ2hwYkJhc1B5WUg1?=
 =?utf-8?B?V3hIVXo0UzYvd3BhUzVyUFNaMGQ3dFJXM1NBc0lGWXlCalRpeWJmdkVpcy8x?=
 =?utf-8?B?RmRBaUtqTzZiWnIxY2pka2ZLci94d296RWNCbkxLTDZGYTZYMm02RWhTaFBI?=
 =?utf-8?B?Wi9CSWVoNG5FaUNkNU9WT2VGb3IrZUVpcm9taTlpV09VYk1VeHNLb2ZpdFR6?=
 =?utf-8?B?azdCUVl3cFo3TTN2Y0lrWFdvYVFZbWdGNjI2VllHWGN1ek0zZkMzWTdicXpy?=
 =?utf-8?B?UmVmVytZK0NmRzdQMzlxbDFuRDRRTWpGWjRKM3F0SlgvK2doTk9PdEJZV2E2?=
 =?utf-8?B?Tm5hTFNNRUZ2NW1yRW5JR3dUQ21aU0kzWmhFOXBid3VpS3d1T3hzcUxwRHJL?=
 =?utf-8?B?NStJbm1DRHFseXloM2NxQWdiSzhJRE93dkV0bWg3bWoxR2VyNGJWY2dDWXpL?=
 =?utf-8?B?Q3hrS1ljdXhJb2F2dFh1SEFaN0dxNHBYMlZjTHdpakswRDV4MFBaa2tydEkz?=
 =?utf-8?B?Z1RNYTFSbnlmY2VQdGFBZmJINkF4NmVpUURZci9sSy8rRE8rRmFrcnFrVmEy?=
 =?utf-8?B?SVpKZW0vZjA4ejdEYngyQ3BSTmgxWU1LK0M1Zk9sOXRtTjdUbHVkU2creWhs?=
 =?utf-8?B?KzF3KzBDU1RML2w1NVFMRDkyQnZOM2tDMkppc25id2hxekxnTkRzYU5IMUx5?=
 =?utf-8?B?aDJTSlhqb3poTWtTeDhGcnVrZUpKOStwdFdTVFVHaTlBRjZKc3ZkNlA5a2Q2?=
 =?utf-8?B?ZG1BUnFSTGxCSjk1dnVlN0NIOGJJRW1rT2o3aEZkdEs4NTYwNnBVRm9WazFV?=
 =?utf-8?B?VjFTSnl5endRRWUyQWRQa2Y1L3R0bEtPSG95YlFMMVhoWmxuMi9IdHlieENo?=
 =?utf-8?B?R0dqcGZLYWZmUThiQSt6dnJBSmcyZE03STZTdW5TbDZuTE9YOGtIMGQ4KzhF?=
 =?utf-8?B?TmJwWC9YQ2p3RjlaVzcwa1hUZkxDa2VBWDFGNkhoSHhSaklZQnEyMXFwWlVs?=
 =?utf-8?B?Q0dMQnJrdGJSZjc2VUJtLzZRQzVFeW5zQ2JWdmMrV3UvSC9oWVNMeWV2Umcz?=
 =?utf-8?B?T3hWMFVsd3hWRHdQNXh5ZmpHWVdmU2VZVlliT1NHMDdhV0FsaEpnQ3pqbUZV?=
 =?utf-8?Q?bBbn0PIeGQ05sz5X/2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6405cb2e-b1b4-45fd-4bc4-08df390ceede
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 18:13:02.0684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 293nHCGNYAxJevbUAjPIWBtkIVB89K/lq2F+4Mek7ufrhUoXMG+EBmB9EFXJGC30PeX6T+RDA5a+gUtnofzmLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5993
Received-SPF: pass client-ip=2a01:111:f403:c10d::1;
 envelope-from=tdave@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Introduce a fixed BAR fw_cfg blob exporter that serializes PCI
device and BAR information into the "etc/fixed-bars" fw_cfg file.

The blob contains an entry for every PCI function with memory BARs.
Each entry carries the device's vendor and device ID, whether it
has a fixed BAR configuration, and its firmware device path. Fixed
BAR entries also include the configured BAR address, size, and type
information for each BAR.

Document the format in docs/specs/pci-fixed-bars.rst.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 docs/specs/index.rst           |   1 +
 docs/specs/pci-fixed-bars.rst  |  75 ++++++++
 hw/pci/meson.build             |   1 +
 hw/pci/pci-fixed-bar-blob.c    | 308 +++++++++++++++++++++++++++++++++
 include/hw/pci/pci-fixed-bar.h |  63 +++++++
 5 files changed, 448 insertions(+)
 create mode 100644 docs/specs/pci-fixed-bars.rst
 create mode 100644 hw/pci/pci-fixed-bar-blob.c
 create mode 100644 include/hw/pci/pci-fixed-bar.h

diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index 44e108db02..15cdf4698b 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -11,6 +11,7 @@ guest hardware that is specific to QEMU.
    pci-ids
    pci-serial
    pci-testdev
+   pci-fixed-bars
    ppc-xive
    ppc-spapr-xive
    ppc-spapr-numa
diff --git a/docs/specs/pci-fixed-bars.rst b/docs/specs/pci-fixed-bars.rst
new file mode 100644
index 0000000000..708566550e
--- /dev/null
+++ b/docs/specs/pci-fixed-bars.rst
@@ -0,0 +1,75 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+..
+   Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved
+
+PCI fixed BAR fw_cfg
+====================
+
+A PCI device can be given a fixed guest address for each of its memory BARs
+with the ``fixed-bar-N`` device properties, where ``N`` is the BAR number,
+for example ``-device e1000,fixed-bar-0=0x20000000``. A machine that
+supports this validates the addresses and passes them to the firmware in the
+``etc/fixed-bars`` fw_cfg file, so that the firmware can place each BAR at
+the requested address instead of assigning one.
+
+The file is present only when at least one device has a fixed BAR. All
+fields are little-endian and the structures are packed.
+
+Layout
+------
+
+The file is a header followed by one device record for every PCI function
+that has a memory BAR, fixed or not. A device record is followed by one BAR
+record for each of its fixed BARs. A device with any fixed BAR has all of its
+memory BARs fixed, so it has a BAR record for each of them.
+
+The device records are in the order in which the firmware discovers the
+devices. Host bridges come in ascending bus number order, the devices of a
+bus in devfn order, and the devices behind a bridge follow the bridge.
+
+Header
+~~~~~~
+
+====== ======= ====================================================
+Offset Size    Description
+====== ======= ====================================================
+0      4       ``version``, currently 1
+4      4       ``num_devices``, the number of device records
+====== ======= ====================================================
+
+Device record
+~~~~~~~~~~~~~
+
+====== ======= ====================================================
+Offset Size    Description
+====== ======= ====================================================
+0      2       ``vendor_id``
+2      2       ``device_id``
+4      1       ``dev_flags``, bit 0 is set if the device has fixed BARs
+5      1       ``rp_bus``, the primary bus number of the root port the
+               device is under, or the bus number of its host bridge
+               if it is not under a root port
+6      1       ``num_bars``, the number of BAR records that follow,
+               0 if the device has no fixed BARs
+7      1       reserved, 0
+8      128     ``fw_path``, the firmware device path of the device,
+               NUL-terminated
+====== ======= ====================================================
+
+BAR record
+~~~~~~~~~~
+
+====== ======= ====================================================
+Offset Size    Description
+====== ======= ====================================================
+0      1       ``bar``, the BAR number
+1      3       reserved, 0
+4      4       ``flags``, bit 0 indicates the BAR type (0 for 32-bit,
+               1 for 64-bit), and bit 1 indicates whether the BAR is
+               prefetchable (0 for non-prefetchable, 1 for
+               prefetchable). All other bits are reserved and must
+               be zero.
+8      8       ``address``, the fixed guest address of the BAR
+16     8       ``size``, the size of the BAR
+====== ======= ====================================================
diff --git a/hw/pci/meson.build b/hw/pci/meson.build
index 150085c997..b81cc056c0 100644
--- a/hw/pci/meson.build
+++ b/hw/pci/meson.build
@@ -20,6 +20,7 @@ pci_ss.add(files('pcie.c', 'pcie_aer.c'))
 pci_ss.add(files('pcie_doe.c'))
 system_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files('pcie_port.c', 'pcie_host.c'))
 system_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files('pci-fixed-bar-validate.c'))
+system_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files('pci-fixed-bar-blob.c'))
 system_ss.add_all(when: 'CONFIG_PCI', if_true: pci_ss)
 
 stub_ss.add(files('pci-stub.c'))
diff --git a/hw/pci/pci-fixed-bar-blob.c b/hw/pci/pci-fixed-bar-blob.c
new file mode 100644
index 0000000000..dc94debfad
--- /dev/null
+++ b/hw/pci/pci-fixed-bar-blob.c
@@ -0,0 +1,308 @@
+/*
+ * Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ * Write validated fixed-BAR device info to the etc/fixed-bars fw_cfg blob.
+ *
+ * Written by Tushar Dave
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/nvram/fw_cfg.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci/pci_host.h"
+#include "hw/pci/pcie_port.h"
+#include "hw/core/qdev.h"
+#include "qemu/error-report.h"
+#include "pci-internal.h"
+#include "hw/pci/pci-fixed-bar.h"
+#include "pci-fixed-bar-validate.h"
+
+typedef struct {
+    uint8_t  bar;
+    uint32_t flags;
+    uint64_t addr;
+    uint64_t size;
+} BarInfo;
+
+/* One PCI function entry to be written to the blob. */
+typedef struct {
+    uint8_t  rp_bus;     /* primary bus of the root port this device is under */
+    uint16_t vendor_id;
+    uint16_t device_id;
+    bool     is_fixed;
+    char     fw_path[QEMU_FIXED_BARS_MAX_PATH];
+    GArray  *bars;  /* array of BarInfo */
+} DeviceInfo;
+
+typedef struct {
+    GArray *devices;
+    PCIBus *root_bus;
+} CollectCtx;
+
+static void collect_device(PCIBus *bus, PCIDevice *pdev, void *opaque);
+
+/* Visit every device on this bus, in devfn order. */
+static void collect_bus(PCIBus *bus, void *opaque)
+{
+    pci_for_each_device_under_bus(bus, collect_device, opaque);
+}
+
+/*
+ * Primary bus number of the nearest TYPE_PCIE_ROOT_PORT ancestor of bus
+ * — i.e. the bus the root port device itself lives on, not its
+ * secondary bus. Falls back to the host bridge's own bus number if bus
+ * isn't under any root port (e.g. a device directly on the host
+ * bridge's primary bus).
+ */
+static uint8_t find_root_port_bus(PCIBus *bus, PCIBus *host_bus)
+{
+    PCIDevice *parent;
+
+    while (bus) {
+        parent = bus->parent_dev;
+        if (!parent) {
+            break;
+        }
+        if (object_dynamic_cast(OBJECT(parent), TYPE_PCIE_ROOT_PORT)) {
+            return pci_bus_num(pci_get_bus(parent));
+        }
+        bus = pci_get_bus(parent);
+    }
+    return pci_bus_num(host_bus);
+}
+
+static void collect_device(PCIBus *bus, PCIDevice *pdev, void *opaque)
+{
+    CollectCtx *ctx = opaque;
+    bool has_mem_bar = false;
+    bool is_64bit, is_pref;
+    DeviceInfo dev;
+    PCIIORegion *r;
+    PCIBus *sec;
+    BarInfo bi;
+    int i;
+
+    for (i = 0; i < PCI_NUM_REGIONS - 1; i++) {
+        r = &pdev->io_regions[i];
+        if (r->size && !(r->type & PCI_BASE_ADDRESS_SPACE_IO)) {
+            has_mem_bar = true;
+            break;
+        }
+    }
+
+    /*
+     * Every device with a memory BAR gets an entry, fixed or not — not
+     * just ones with fixed-bar-N= set. This preserves the exact device
+     * sequence CheckDevice() needs for positional VID:DID matching (see
+     * collect_all_host_bridges()); only fixed devices carry BAR records
+     * (dev.bars stays empty, dev.is_fixed false, otherwise).
+     */
+    if (has_mem_bar) {
+        g_autofree char *fw_path = qdev_get_fw_dev_path(DEVICE(pdev));
+
+        memset(&dev, 0, sizeof(dev));
+        dev.rp_bus    = find_root_port_bus(bus, ctx->root_bus);
+        dev.vendor_id = pci_get_word(pdev->config + PCI_VENDOR_ID);
+        dev.device_id = pci_get_word(pdev->config + PCI_DEVICE_ID);
+        dev.is_fixed  = false;
+        for (i = 0; i < PCI_NUM_REGIONS - 1; i++) {
+            if (pdev->fixed_bar_addr[i] != PCI_BAR_UNMAPPED) {
+                dev.is_fixed = true;
+                break;
+            }
+        }
+        if (fw_path) {
+            g_strlcpy(dev.fw_path, fw_path, sizeof(dev.fw_path));
+        }
+        dev.bars = g_array_new(false, true, sizeof(BarInfo));
+
+        if (dev.is_fixed) {
+            for (i = 0; i < PCI_NUM_REGIONS - 1; i++) {
+                r = &pdev->io_regions[i];
+                if (!r->size || (r->type & PCI_BASE_ADDRESS_SPACE_IO)) {
+                    continue;
+                }
+                is_64bit = !!(r->type & PCI_BASE_ADDRESS_MEM_TYPE_64);
+                is_pref  = !!(r->type & PCI_BASE_ADDRESS_MEM_PREFETCH);
+
+                memset(&bi, 0, sizeof(bi));
+                bi.bar   = i;
+                bi.addr  = (uint64_t)pdev->fixed_bar_addr[i];
+                bi.size  = r->size;
+                bi.flags = (is_64bit ? QEMU_FIXED_BAR_F_MEM64 : 0) |
+                           (is_pref  ? QEMU_FIXED_BAR_F_PREF  : 0);
+                g_array_append_val(dev.bars, bi);
+            }
+        }
+        g_array_append_val(ctx->devices, dev);
+    }
+
+    if (!object_dynamic_cast(OBJECT(pdev), TYPE_PCI_BRIDGE)) {
+        return;
+    }
+    sec = pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
+    if (sec) {
+        collect_bus(sec, opaque);
+    }
+}
+
+static gint cmp_host_bus_num(gconstpointer a, gconstpointer b)
+{
+    PCIHostState *ha = *(PCIHostState **)a;
+    PCIHostState *hb = *(PCIHostState **)b;
+    return (gint)pci_bus_num(ha->bus) - (gint)pci_bus_num(hb->bus);
+}
+
+/*
+ * EFI_INCOMPATIBLE_PCI_DEVICE_SUPPORT_PROTOCOL's CheckDevice interface
+ * (UEFI PI Spec 1.2 Vol 5) only passes VendorId/DeviceId/RevisionId/
+ * SubsystemVendorId/SubsystemDeviceId, no BDF — so in EDK2 we can't
+ * match a blob entry to a specific device directly using BDF. To work
+ * around that, we prepare the blob entries in the same order PciBusDxe
+ * discovers devices, so matching by VID:DID inherently works. Each entry
+ * also carries the firmware device path. The CheckDevice interface cannot
+ * use it today, but it could if the interface is extended.
+ */
+static void collect_all_host_bridges(CollectCtx *ctx)
+{
+    PCIHostState *hb;
+    GPtrArray *sorted;
+    guint i;
+
+    sorted = g_ptr_array_new();
+    QLIST_FOREACH(hb, &pci_host_bridges, next) {
+        if (hb->bus) {
+            g_ptr_array_add(sorted, hb);
+        }
+    }
+    g_ptr_array_sort(sorted, cmp_host_bus_num);
+
+    for (i = 0; i < sorted->len; i++) {
+        hb = g_ptr_array_index(sorted, i);
+        ctx->root_bus = hb->bus;
+        collect_bus(hb->bus, ctx);
+    }
+
+    g_ptr_array_free(sorted, true);
+}
+
+static uint8_t *create_blob(CollectCtx *ctx, size_t *blob_size)
+{
+    QemuFixedBarsDevice *dout;
+    QemuFixedBarsBar *bout;
+    QemuFixedBarsHdr *hdr;
+    DeviceInfo *dev;
+    uint8_t *blob;
+    uint8_t *ptr;
+    BarInfo *bi;
+    size_t sz;
+    guint d, b;
+
+    sz = sizeof(QemuFixedBarsHdr);
+    for (d = 0; d < ctx->devices->len; d++) {
+        dev = &g_array_index(ctx->devices, DeviceInfo, d);
+        sz += sizeof(QemuFixedBarsDevice);
+        sz += dev->bars->len * sizeof(QemuFixedBarsBar);
+    }
+
+    blob = g_malloc0(sz);
+    hdr  = (QemuFixedBarsHdr *)blob;
+    hdr->version     = cpu_to_le32(QEMU_FIXED_BARS_VERSION);
+    hdr->num_devices = cpu_to_le32(ctx->devices->len);
+
+    ptr = blob + sizeof(*hdr);
+    for (d = 0; d < ctx->devices->len; d++) {
+        dev  = &g_array_index(ctx->devices, DeviceInfo, d);
+        dout = (QemuFixedBarsDevice *)ptr;
+
+        dout->vendor_id = cpu_to_le16(dev->vendor_id);
+        dout->device_id = cpu_to_le16(dev->device_id);
+        dout->dev_flags = dev->is_fixed ? QEMU_FIXED_BARS_DEV_F_FIXED : 0;
+        dout->rp_bus    = dev->rp_bus;
+        dout->num_bars  = dev->bars->len;
+        dout->reserved  = 0;
+        memcpy(dout->fw_path, dev->fw_path, sizeof(dout->fw_path));
+        ptr += sizeof(QemuFixedBarsDevice);
+
+        for (b = 0; b < dev->bars->len; b++) {
+            bi   = &g_array_index(dev->bars, BarInfo, b);
+            bout = (QemuFixedBarsBar *)ptr;
+
+            bout->bar     = bi->bar;
+            bout->flags   = cpu_to_le32(bi->flags);
+            bout->address = cpu_to_le64(bi->addr);
+            bout->size    = cpu_to_le64(bi->size);
+            ptr += sizeof(QemuFixedBarsBar);
+        }
+    }
+
+    *blob_size = sz;
+    return blob;
+}
+
+/*
+ * fixed_bars_write_blob - validate fixed BAR addresses and write fw_cfg blob.
+ *
+ * @fw_cfg:       fw_cfg state to write the etc/fixed-bars blob into.
+ * @mmio32_base:  base of the machine's 32-bit PCIe MMIO aperture.
+ * @mmio32_size:  size of the machine's 32-bit PCIe MMIO aperture.
+ * @mmio64_base:  base of the machine's 64-bit PCIe MMIO aperture.
+ * @mmio64_size:  size of the machine's 64-bit PCIe MMIO aperture, or 0
+ *                if the machine has none.
+ * @errp:         set if the apertures or any BAR address fail validation.
+ *
+ * Returns true if any fixed BAR device was found and the blob was
+ * written, false if there was nothing to do or on error.
+ */
+bool fixed_bars_write_blob(FWCfgState *fw_cfg,
+                           uint64_t mmio32_base,
+                           uint64_t mmio32_size,
+                           uint64_t mmio64_base,
+                           uint64_t mmio64_size,
+                           Error **errp)
+{
+    FixedBarsInfo info;
+    CollectCtx ctx;
+    uint8_t *blob;
+    size_t blob_size;
+    guint d;
+
+    if (!mmio32_size) {
+        error_setg(errp, "fixed-bar: zero-size 32-bit PCIe MMIO aperture");
+        return false;
+    }
+    if (mmio32_size - 1 > UINT64_MAX - mmio32_base ||
+        (mmio64_size && mmio64_size - 1 > UINT64_MAX - mmio64_base)) {
+        error_setg(errp, "fixed-bar: PCIe MMIO aperture base+size overflows "
+                   "(32-bit base=0x%"PRIx64" size=0x%"PRIx64", "
+                   "64-bit base=0x%"PRIx64" size=0x%"PRIx64")",
+                   mmio32_base, mmio32_size, mmio64_base, mmio64_size);
+        return false;
+    }
+
+    info.mmio32_base = mmio32_base;
+    info.mmio32_limit = mmio32_base + mmio32_size - 1;
+    /* An absent 64-bit aperture is an empty window, no BAR fits in it. */
+    info.mmio64_base = mmio64_size ? mmio64_base : 1;
+    info.mmio64_limit = mmio64_size ? mmio64_base + mmio64_size - 1 : 0;
+
+    if (!fixed_bars_validate(&info, errp) || !info.any_fixed) {
+        return false;
+    }
+
+    ctx.devices  = g_array_new(false, true, sizeof(DeviceInfo));
+    ctx.root_bus = NULL;
+    collect_all_host_bridges(&ctx);
+
+    blob = create_blob(&ctx, &blob_size);
+    fw_cfg_add_file(fw_cfg, FW_CFG_FIXED_BARS, blob, blob_size);
+
+    for (d = 0; d < ctx.devices->len; d++) {
+        g_array_free(g_array_index(ctx.devices, DeviceInfo, d).bars, true);
+    }
+    g_array_free(ctx.devices, true);
+
+    return true;
+}
diff --git a/include/hw/pci/pci-fixed-bar.h b/include/hw/pci/pci-fixed-bar.h
new file mode 100644
index 0000000000..2c5af536dc
--- /dev/null
+++ b/include/hw/pci/pci-fixed-bar.h
@@ -0,0 +1,63 @@
+/*
+ * Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ * Fixed-BAR — QEMU side declarations.
+ *
+ * Written by Tushar Dave
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_PCI_FIXED_BAR_H
+#define HW_PCI_FIXED_BAR_H
+
+#include "hw/nvram/fw_cfg.h"
+
+#define FW_CFG_FIXED_BARS        "etc/fixed-bars"
+#define QEMU_FIXED_BARS_VERSION  1
+#define QEMU_FIXED_BARS_MAX_PATH 128
+
+/*
+ * On-wire layout (little-endian, packed):
+ *
+ *   QemuFixedBarsHdr
+ *
+ *   For each device (num_devices total):
+ *     QemuFixedBarsDevice               -- device header
+ *     QemuFixedBarsBar[num_bars]        -- one record per BAR (FIXED only)
+ */
+
+typedef struct {
+    uint32_t version;     /* QEMU_FIXED_BARS_VERSION */
+    uint32_t num_devices;
+} QEMU_PACKED QemuFixedBarsHdr;  /* 8 bytes */
+
+typedef struct {
+    uint16_t vendor_id;
+    uint16_t device_id;
+    uint8_t  dev_flags;  /* QEMU_FIXED_BARS_DEV_F_* */
+    uint8_t  rp_bus;     /* primary bus of the root port this device is under */
+    uint8_t  num_bars;
+    uint8_t  reserved;
+    /* qdev_get_fw_dev_path(), NUL-terminated */
+    char     fw_path[QEMU_FIXED_BARS_MAX_PATH];
+} QEMU_PACKED QemuFixedBarsDevice;  /* 8 + QEMU_FIXED_BARS_MAX_PATH bytes */
+
+typedef struct {
+    uint8_t  bar;
+    uint8_t  reserved[3];
+    uint32_t flags;    /* QEMU_FIXED_BAR_F_* */
+    uint64_t address;
+    uint64_t size;
+} QEMU_PACKED QemuFixedBarsBar;  /* 24 bytes */
+
+#define QEMU_FIXED_BAR_F_MEM64       (1u << 0)
+#define QEMU_FIXED_BAR_F_PREF        (1u << 1)
+#define QEMU_FIXED_BARS_DEV_F_FIXED  (1u << 0)
+
+bool fixed_bars_write_blob(FWCfgState *fw_cfg,
+                           uint64_t mmio32_base,
+                           uint64_t mmio32_size,
+                           uint64_t mmio64_base,
+                           uint64_t mmio64_size,
+                           Error **errp);
+
+#endif /* HW_PCI_FIXED_BAR_H */
-- 
2.34.1


