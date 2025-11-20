Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90ED9CFA441
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 20:45:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMBWJ-0000OT-17; Thu, 20 Nov 2025 15:44:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMBWH-0000Ng-10; Thu, 20 Nov 2025 15:44:45 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMBWE-0007YD-MJ; Thu, 20 Nov 2025 15:44:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wHRcv4mwhpL95dlV+acrkc+z89HNl5ndl145mCWGgoYFRlGZnYGW1gi3PGUQdfD4Ipf4SreNJOERBZ4XJ9aYJDExkEmI48I8t8Mdfi3b3K1lAsn4HmsDz1NHZURgf1n2Oi33MTkEcbYy+HWUbjR0Dc4g1iTZintMreeaUfHtmfVxVaKVn8xN/tMu9sitzWWYfxoY7bEEldBDAo2KwKdxxexhXZveTw48y8yZkGXEsVRnAUAqNVbMgkzYuYsuTFBkv8N3vjlq5eRRjDEhiAnBICKtwZyN8G9MVTsDrRHu2LsFtmNQZZIDMXZR+oqLD2lcG5SWtKbPV4D2c8SlZD9Y/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMq7pW711Ds0U1nKqaeXncOFkIsabO2RwB42H2dqTw4=;
 b=teNUC6idiRwTkLUsyGpcgBL9burpBVSOSvehjpjVcciNxKNQ4nJRMHf+vbHboVmO0srdeMeREQy6tZBlGWsZh2PQERIDZ2eYxuvl/Cj4h09qR2RO0NLgiZT7PJcwl6Ni9PDPirdcBJ4qSSi3qWGcbSzFJQhSso+Fa4VEj634vc+Sbg9KL4s4OUnNg2PktILltaZnQWz6Ephkt68wnbfDDy+yVDYPOqHrRb1Kr0s0BvTOKf8743i4qwIkTg+iNeEFTIKvmn1ToXLQSQQab+a/8L2vvHz72j+r28kWurGFzFxAwAgCT7mhwwlZKOdDdiwz9mMQor5Ab4A+2wJtTCduoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMq7pW711Ds0U1nKqaeXncOFkIsabO2RwB42H2dqTw4=;
 b=jgONgjBOYVn6w8JvGeId4CRI6id/eDlTOJjXiDZlbmEyCeu+7by1ax+cvzoe/MMHxN7sPa7N+WC7k041hUd1m0JZnIeExq5aYoEgYjyp3emecqqU94VGLpEQd3oSaaXks/94a/llUD6RHv2KUfQmXVMsF0wwXaaE7eatUUbsStjXQStkBPfTLSfSFMtkFEw9hG/tK8ubiYMy4qgynrJVwVy0ZwN4VambbKEnH2zJfjnKwNOm8w5chplHx7V7PQFz7BXnVbygE6x3q25WNrwslHuqUq05lqIYY5gCpih5nDl8xelc79PN+xktpFQekqhgH52h2pkpKIzk7ew27nasVg==
Received: from MN2PR18CA0009.namprd18.prod.outlook.com (2603:10b6:208:23c::14)
 by IA1PR12MB7664.namprd12.prod.outlook.com (2603:10b6:208:423::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Thu, 20 Nov
 2025 20:44:35 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::97) by MN2PR18CA0009.outlook.office365.com
 (2603:10b6:208:23c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 20:44:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 20:44:35 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 12:44:17 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 12:44:17 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 20 Nov 2025 12:44:15 -0800
Date: Thu, 20 Nov 2025 12:44:14 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v6 07/33] hw/pci/pci: Move pci_init_bus_master() after
 adding device to bus
Message-ID: <aR99nhP+06VPIpl2@Asurada-Nvidia>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-8-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251120132213.56581-8-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|IA1PR12MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: 107d925e-12f0-41c7-ad8c-08de28759d9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d4Lm87KR0GQwyltDcfgaB5b9proyRe7TIuprkNipTGOShtHPFeJJ17+R8v0d?=
 =?us-ascii?Q?EpnJNo0f85U2ule3Ve9FKHmZ9mvsg/zZmP2PX5NYH7Okfyjv67OdI+z0BaFT?=
 =?us-ascii?Q?Vdnf2o0MUaM5/aUBBdlvm5PRQBaXwR6kQJw4f/t1lND5ocWkyTFZ5RrQkmZp?=
 =?us-ascii?Q?YnnAk1UJhdaUXpD89cdBMghMH0rsEsP19g1AAFYYOH89GtTVjKXmbrqFx+hL?=
 =?us-ascii?Q?UsZTm7qsZGjOm7YXYs2kvNBi2KoMa2hfJ1QtLhB65PwnuiYkAVV9yKmFVpJB?=
 =?us-ascii?Q?XGajVMu+IyrAhPXeMPDGDdrRXYMf49+7W73EAVC9XC37loJI9TJY1sXVz00C?=
 =?us-ascii?Q?5cseXFaIq/Us7IennFvt9Ae4kuJDn20EdGX3pK6Fw9IsqK8xg2rtWEjuqp+d?=
 =?us-ascii?Q?O2/SuLGMZOhYoLXDfw7xRiBRoGkok5pGlz9HqG9jHsWHgpHYWr/jDJu9zNp2?=
 =?us-ascii?Q?YSIdTDAfkUI9oAU+Uj0XcFrBL9THwpLABWkyRMpAmUrheDVLpthrkguDqXPz?=
 =?us-ascii?Q?GfwZW3wd6h3AL7ALYz8it7uWngPynytQBwWtIeXHuP8GdM0EGA0khre2FEzA?=
 =?us-ascii?Q?F6BkNf/IqiJ6h/RY4DuY6a82gvRkflbYTxdH3FQB1WC0ExqekZr5N876knkZ?=
 =?us-ascii?Q?MfCPWUl9snpkktJ4/930sK0j4NJKJnw9VYc/JNmPUZxXzGVqz2mU90Wb2nJB?=
 =?us-ascii?Q?aRagOLKuRwzCs5oaODkCS0vvaHjZJVSyl6qowQDXeBem4eYh6gRa0fh53BbV?=
 =?us-ascii?Q?0E2jVEH+u02qEq1ahhiZ6ZLa97LvHfQG7Ub4ZjYUSrrCD/B1TkfNPHe75KXg?=
 =?us-ascii?Q?4Dt0r48brRi/VoAU5t3Ulpj2/A8bSFWalKZxW+KJo/yqNl5PlTtpvC5/S7kl?=
 =?us-ascii?Q?ZeGEwKo6Kfea/UpopuMBN4bS6cgs5FvHxdX7PrFefSTseA0LdhozsLAm3Wdi?=
 =?us-ascii?Q?+fjShmoQ3aTkppV7ghAK4pXCtz25IKZ3Q3Tjdmxvw4B4Zjrvr22ikMcyQiEr?=
 =?us-ascii?Q?s05kDOYHE+58fUw1cVzvND6uy9F8i5VBocVDDFn/KqLrcJrFdjwyA5ybGQJj?=
 =?us-ascii?Q?I2St3tn4u/oDfRGln6jUyOqvernqlUekljMtQzi2OZouh2dOBLwDr3VqALpk?=
 =?us-ascii?Q?IlCk541TQCgDICO4qoIzNIsuounNIa/7G4/2c+vrm+wVMkizvgFx298GmhcG?=
 =?us-ascii?Q?XBh9N97PXksBEhyfHVzRj2Cbiv6nSOMGSdPlbQvvhgJB5n8fZtjTBTid/h/u?=
 =?us-ascii?Q?ntoRK09Fu48eOBGGLipRAajXffRTQqcUbE0vaiShL7241VE6+x0qZv57H5Nx?=
 =?us-ascii?Q?RrFRQCTl/D7K+VaRyr94fI49+/8jhsK1hUFgyz7SER76G46SqZplamDQScP2?=
 =?us-ascii?Q?oPcjVezeavqDoYfy3GkGEKLYc+s6D3yzPtNQoYdD4YrbXHumC2EV2eF2t+bc?=
 =?us-ascii?Q?GFX3e+sNplsCj+doFExWbWgiIl7+mmFmBf2R4++0rjxhgs2TFdUw7hGmyP62?=
 =?us-ascii?Q?2VwaaXRggKTgVMq7bYyXbd/ft+bUkaAU45r8Z1ngzGrJ7VoR2F0vPRX4qa9v?=
 =?us-ascii?Q?fj9XgtgVz5FvOuQdAS8=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 20:44:35.1930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 107d925e-12f0-41c7-ad8c-08de28759d9f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7664
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=nicolinc@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On Thu, Nov 20, 2025 at 01:21:47PM +0000, Shameer Kolothum wrote:
> During PCI hotplug, in do_pci_register_device(), pci_init_bus_master()
> is called before storing the pci_dev pointer in bus->devices[devfn].
> 
> This causes a problem if pci_init_bus_master() (via its
> get_address_space() callback) attempts to retrieve the device using
> pci_find_device(), since the PCI device is not yet visible on the bus.
> 
> Fix this by moving the pci_init_bus_master() call to after the device
> has been added to bus->devices[devfn].
> 
> This prepares for a subsequent patch where the accel SMMUv3
> get_address_space() callback retrieves the pci_dev to identify the
> attached device type.
> 
> No functional change intended.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

