Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032F4E94622
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 23:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpb24-0006iP-2j; Mon, 09 Feb 2026 18:51:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vpb20-0006hh-Hz; Mon, 09 Feb 2026 18:51:04 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vpb1y-0002Va-63; Mon, 09 Feb 2026 18:51:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ottSRwTqN7pfWYNvN0FlQAnkX+z2IgbOLpPeRyx3I2wRcBmp1aHEBJfX9FI3rd2tgI/lvhzOM+c3qKU3T3Shq0W+rSbxWrZBxZyFyetatwUWz5Iu1v5u9rLnl37nw9t9nZjgcRilb9MYVeuIn8ansBpYoFdyZ2GWM6eNsbnYkZ2l29C2XGkV1b4lxHux7uNSAOoqOy6ofks2rwuqohlmq7sX7uM1UTxmjtlRF3PgCqBM3qil/vE+221h5UVCaumHOnuUvLnRG2GvkwKSKJPpdzAq/l/LVNToMMvIbmXxRjdNFsO6MlfEH1hSc4naUK8zhSECp+eBHg1sT3F7tUiHpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3msGxbIJLGJ0K/b+IrDhx3mpUrl5XOgd5ITSBHz/eLU=;
 b=goqBzp6Zh0/WEaSrouwRpTF5/nW0FvjMHr66hgKoVhOv90+3PuKYHqIZHfQDd+JGbk3/VxeqoaxfMv6a4q7zu9eItEq04xnvcRQLKDnKIF+/6Xd8cRv/FiPU7t6K4JZAsBGGSRXGwv8g1MDyuM4p4yBO21jMDiGDFxm7RyXiGd+mK3N+41Imq0g+P85Wk8pHJ8+/iLo7K1g2zbQk1dd6AStstjRZX4ICOmbz2QrfAsubF47pA8j7y12oBpg3X/FGUiorBh0c/Gt1eGdW+Kw1j87jJRznich+UNqtXGLO8I4l5XmG7Qj2NmZ4zJxmCuG+TcjNKDQMESxsNCdna16SIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3msGxbIJLGJ0K/b+IrDhx3mpUrl5XOgd5ITSBHz/eLU=;
 b=WwGHSs8nf5nJzNllgPszgXiQ8TIoRw6CXMOTGRdO0fUY/1VzwBebcnNcRgGIuP1HdGYpWBdaZ6dZ0SSXlNZqnfL4FF4LpCLEyQaxs4aTG8+U77oYBc5fvnDjS5RMM7MZkKaKXjzXRMN4JESb4H+Tfk+LTGg+rK3goUxIwYuBzjdmpurQXlVqjkn44ReOyTLZUY9Y7v0pmlm1s567Z4dJeYWaKTWd/PuPRdX+o23VX4I9c7E0ieFX3tZ+o+gM7RjAD+Tt/Q9pSW+LOnpnbaotqk0xC4n/RIcMP4I6L149nXkmarbHlN+Lk0nMkLZyNQX3S2/sNofQhsEuyr5ToElfkg==
Received: from PH8P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::24)
 by DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 23:50:49 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:510:345:cafe::d3) by PH8P220CA0004.outlook.office365.com
 (2603:10b6:510:345::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Mon,
 9 Feb 2026 23:50:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Mon, 9 Feb 2026 23:50:48 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 15:50:27 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 15:50:26 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Feb 2026 15:50:25 -0800
Date: Mon, 9 Feb 2026 15:50:24 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <clg@redhat.com>, <alex@shazbot.org>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>, 
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v2 15/24] hw/arm/tegra241-cmdqv: map VINTF page0 MMIO
 region
Message-ID: <aYpywAQ2EHubTEfB@Asurada-Nvidia>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-16-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260206144823.80655-16-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|DM4PR12MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: ca1f052f-b708-4ed8-751e-08de68360cab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jwNP0E01ttOObJ4IAa9Cn2C45aSxzvD7900BvRhD6J4JJYrNRs5uBh1CHqQN?=
 =?us-ascii?Q?vwAiqTgayqfF5+6UYUibzCxvfHulUbKdjwe4W0+6qekRRvenoA/jeSxfS5jx?=
 =?us-ascii?Q?v1yql8Xrk0Xn2DhjijUStgTXxM4zQSPzXEqXI57/DaRITX5r/4l/a41qdHkt?=
 =?us-ascii?Q?RLYjJlQW7OxdZXAv52vKVqYgrbM7y270WVNSzPyVQT63oK4ztHjUTxAHXj9y?=
 =?us-ascii?Q?PZ/UUc/7LQfrpnIqg9oM4EkAYsogMS/Y3rufhkOBAGj45jThaGQsBam6ldOz?=
 =?us-ascii?Q?22iKr8MvpOpS2JM3rRVfjxVt0N3CppOEu7m12mmsRojTYuBq/wr8dnhJXPWE?=
 =?us-ascii?Q?5zAJyMW39wONqsSB2ZJvQB1Zhzd65e8247jZHaA0AOSpJmiHdOHgdvojnp9K?=
 =?us-ascii?Q?sb+IEXOEVQzBaymN+moE7Y4DeKTFu6m0MNC/4++ebs83W97yiDNKmQhHBGbD?=
 =?us-ascii?Q?d91INA900KdVVtueZ0xObqZ+kNmfDJX2KBvJUo9vrlKk6xZX9M8VsCazoNzT?=
 =?us-ascii?Q?dXfyM0KqumjwVpJs9cwHnkxlP2zSRoDdD6bk+CCQY5tEEaS2kw06l98yPUEB?=
 =?us-ascii?Q?49lBw8F7cLydpZDvLizKuT6/uPHgwMbc3iDzvkUjZmGs0oeIMaZUbqRFk7LF?=
 =?us-ascii?Q?uTCT2nJrxgRDWA3deWFk+qKkWlT4BtL/fdxLld4nQm2lcmEjOvo///mk0syi?=
 =?us-ascii?Q?CaCcB0WbWMnqhdB2l++y+aG2Xn53QUzdIlkmOVm6UCxOocQsD38XhgTGyOy/?=
 =?us-ascii?Q?IwBomeoU7B53PJu6MqgOfRccPC3kJiBoY6JlqRX3Pdt+7o2xOUIsmouCeRDC?=
 =?us-ascii?Q?ClbC23wSzarGTbybQKMKoEkaEGwduYnZMwcMc46C53QoQB3lBQSC0jQBA/li?=
 =?us-ascii?Q?7wymjmqGRgWMqgdyguXb9P/F0jf99FZ5cpHiGFtOwhuFqr8/I/M9aIbcFRUA?=
 =?us-ascii?Q?ufi3wl+uhCtoLF1Fz9cRMqFw2cVC5yKk4oQniEWZJrhIyhRu3YCtsHzGKVnh?=
 =?us-ascii?Q?/U3DoFHjHp1kpnZo6eHYplS8rhjhFE/vDRhAzLnmuqBHrF83qZuILpgL9W2k?=
 =?us-ascii?Q?dkZ9gVhvhjGPHriQ7j1eL4DKqG37T7PUpT1b6JPW/7/bir1dJJ1WWFYCJTNC?=
 =?us-ascii?Q?fliJlncKWjOo5Jyw4eSjSzVo7+DHHCC2Bspq2q0sgt1mxxFcklhDiWab90OQ?=
 =?us-ascii?Q?+lGMIy+CyDIBurcSTLs2+fGe2EcsgCYSaHWBAXgud/rVBYJbwcVrn4H1HYxi?=
 =?us-ascii?Q?IetFh7McT7ci9zcru+Q5fDy5yTyLHyj84ilR4sYMaPE20SCwOxtqlzdTJFrE?=
 =?us-ascii?Q?0OtHrWbs3BWlWtyEVo7Q664eJobMRV2XTMDjPvJLZ6/m/47ES3sfSxGt8/yQ?=
 =?us-ascii?Q?EiztQkQntmri9qiwhOk7vxKIs4g7Xu85uy1Pp8UgmXVo7AOsKAQP6PiGuk2m?=
 =?us-ascii?Q?fjdP0vjx66PkCRIYCLNVNphea8ApEEYDn4wpf3b7a9Dr7zCnuQh9Nn8ZMKnW?=
 =?us-ascii?Q?fSzmfB/Ng8qANg2we3TXOvsH3frLHDZ0UKRrIWm+MJtec5sr9HgsKL/HUDrd?=
 =?us-ascii?Q?7GqQJBhR87znSROpO33/j1Yg5ZLWnMTTVCfJI6NT+vXeAlMit2TaffAQ7zUE?=
 =?us-ascii?Q?ZIODUNhNgkKwpoFvZ7ssorpIevZHjxswTbgRJAg0c/d9xXq34OG4MyWGYQB7?=
 =?us-ascii?Q?oSuy1g=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pMH9g0SdYrORaCqN04Z+YWwDb9YFLVGXkk0IcRKMLj2bucAE5RtvK5T2xSp1rCuXL89kettrGhTlUl4HQfcfgIcaRO/jeijPUob2PwdM+9Zciq7AgGdkjP411cFM/SFp4lbeL2p9h1dEBfneax0lzQHgE6TjdGNPxId8bW5ZuultKGPbaGqpJmJmfP3MyIR/xzRmJ9EaDQiA7dQ7QxdHeIgbPHwqLtxZgSR3qp61SF4o1Q95cMsAPNSVjIMrZHH1m4RWvl5plWj6e1NUCKfvfWorqqH3xtzri1l50Kru34X7QE2cSBA4626WZEcJM/Q953lG1zTWAr9VmqRHvQoWoz1wIqMY6ghpUCkH/JNo4AExy+fsJATFuZ/7uXjmTpTLk8tdW7lL4Tbl5CFUm6AwK88nKo7NS215PC3MGZUMuiKTZfVwMXBd/4olfzAlv+UA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 23:50:48.1879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1f052f-b708-4ed8-751e-08de68360cab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5748
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=nicolinc@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
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

On Fri, Feb 06, 2026 at 02:48:14PM +0000, Shameer Kolothum wrote:
> diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
> index 2f4a8ab35f..b92c34e1d7 100644
> --- a/hw/arm/tegra241-cmdqv.h
> +++ b/hw/arm/tegra241-cmdqv.h
> @@ -31,6 +31,8 @@ typedef struct Tegra241CMDQV {
>      MemoryRegion mmio_cmdqv;
>      qemu_irq irq;
>      void *vintf_page0;
> +    MemoryRegion mmio_vintf_page0;

mr_vintf_page0

> +    bool vintf_page0_mapped;

Why do we need another boolean while having vintf_page0 pointer
already?

Nicolin

