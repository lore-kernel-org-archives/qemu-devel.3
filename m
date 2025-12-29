Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A69ABE92FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 19:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaJFs-0008NW-TM; Mon, 29 Dec 2025 14:50:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vaJFX-0008Kt-W6; Mon, 29 Dec 2025 14:49:52 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vaJFW-0001mD-Jl; Mon, 29 Dec 2025 14:49:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTZMvd6AgUrPlDxFBV5C9K2YWyPQL5wYZaJdcK7Bhgj+xzu+yM/PlKbq5CC6i9/zE9DYmXQrotNRSNNULnsCTpc/mD2DYSz8pL5jYsowJ5W+Qr1kkADXuI+VamIYLh+ubkAXKY0GDiErsE0QaZInEH7vUTgfj9LfSpEj82q+aOTiK4hfu3ywof28FZTjfUhkZWqWOXwZa6t7ek/N/M658DUcQ3EH+YlbW6sQri7jn0wSPjsuFktVA1QaAIeH2YukybthkCbgO2tsGWNv9in1N/nmpVeV2LI2TIm6czdnJg8xoQ8BF5tx/usgO8ccOdzC3vV63s8+ilqBU4K4BLJ00Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+U1eOLF9Pd3JV1rzok8H/7ZgA/+Vkm4A8jUZWTzSiIU=;
 b=hZHGWgP3mvLApU2MOHW13wtoOGUVu1S4PykgwX31zrwKOCHwDw09Tf7Lpu4cVFqgcAdNi5r3rYd2T2/FltPOiC8s2Plkvc66yoNY7XzaxUk2JY++wV3/K7tj8gXYDCisKNbJdNYn0YB14nCdzIKATqBgDK7PZd9DfDyMP0Y4WdBHhmtJhRPCNtlajktAOZ8nZL2bKNz1w3mL/y/lBsiyeflajMLWBP8MLQRvvpQBk4XuxfB+ESHaoE9FGJ4mSVhLxPwO4N3u68qYPuJpuQcPQ2rl5wUp4vIO1L74zlCiKNaW7BQOfsKdZjBG/z3kvKpTMpkIJ0Bc8ebnosSPlOMPmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+U1eOLF9Pd3JV1rzok8H/7ZgA/+Vkm4A8jUZWTzSiIU=;
 b=AWM65pG/1WWhuI0CC3HX5gxdzIIY9SvowZk8DYt+vYFPSmVQgJqptzxrsFNPYJMYufG0bzGpOVTfmpLPmjOAFW+dogRELDNS0NGLQ7c89Y89oMByATgAftIFtRmo2syi1eu24B2PGNe5joTdQp9KFKipbV4MbdWVuU2zDCVnczYCT7dH2338Xt2lGTq6zc/WKN/5zQGS5QkHVNyL9GADjngqAnRNupsBIfwm3Ae4s1YxjeJ8JiHN1DhAp9bpwzuUSBlHLt1PSiRTf3xktmzJ/cwHu4rUUKI3N3vkWlkQ5WylXz9p7YTSrC1phH7W+GkRA27bTZJdFDA6JrG0m+TDow==
Received: from DM6PR07CA0087.namprd07.prod.outlook.com (2603:10b6:5:337::20)
 by LV9PR12MB9808.namprd12.prod.outlook.com (2603:10b6:408:2e7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Mon, 29 Dec
 2025 19:49:45 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:337:cafe::20) by DM6PR07CA0087.outlook.office365.com
 (2603:10b6:5:337::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.14 via Frontend Transport; Mon,
 29 Dec 2025 19:49:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Mon, 29 Dec 2025 19:49:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Dec
 2025 11:49:33 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Dec
 2025 11:49:33 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Dec 2025 11:49:32 -0800
Date: Mon, 29 Dec 2025 11:49:31 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [RFC PATCH 10/16] hw/arm/tegra241-cmdqv: Allocate vEVENTQ object
Message-ID: <aVLbS6g+Sd6vfaFc@Asurada-Nvidia>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-11-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251210133737.78257-11-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|LV9PR12MB9808:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b780f49-ef3b-4f68-d7d1-08de47136a9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sZhKyuLK8BG4IpX+l4cf9Y3/aAycGVsGzd0Saj481Wj9CTB0hQTlMn2saQMA?=
 =?us-ascii?Q?jpdHUHzJOMcU/kHcZLbDOt9WzUSYMfx/epscOxq89g8ZFVS/grh48PpnImar?=
 =?us-ascii?Q?bkEQbe13ovHajfAoHUlaEEX0rIrh97UKCR57I+mT6veODDqbQEn/2Yt9GNDS?=
 =?us-ascii?Q?vc/rHmA0tzq80xoCYRHit9I9HQZeQ3qlMrINVsJRKmsfrWoc+uhM3n/7gQ3r?=
 =?us-ascii?Q?eZ82FX4HhOZ1T+OAzEC/HDNQmzOfgOgKElrRQAxfb7MqAM3jSCTv247Ovhph?=
 =?us-ascii?Q?Bts/0r4xJLMI7xPLnf8/y0r7bSmctBo0BlF/eTfW9hkYxjkn4+mxL5iUI7iM?=
 =?us-ascii?Q?PTWIxzdg6wyuZidYEXHuXllL9WU/kKjZWnE7SyNei1qXxNSY1Kx/XtsE02tv?=
 =?us-ascii?Q?m+al4p4I4sXscFJKUgsy69+OxR9Q83uIjvwTn2p0s82qlr5aedQXg19vObzx?=
 =?us-ascii?Q?dHGeyXbmkx7EoVf4RIN6NENeWsxvXMYlGKhqDDOtzfQehPH7/NzhrYwcKs8Q?=
 =?us-ascii?Q?VV4Axt7E4+IhW4RKUu66q/tZKtHYz3X8B6ttaQe/+Q+uMc5CVxLqfPW0kKPY?=
 =?us-ascii?Q?ySPY0/jvBgaDlGlomWei5Zt9OFtkNB3QLFNk9ZuuCCTsvMxCNK9tcS7uhWan?=
 =?us-ascii?Q?dB/1RGQQwS329q1cB2OqiOKHw0cQGmftEHPHJhZ1sFxRBJkiRWvIBvmng5n7?=
 =?us-ascii?Q?XxumJ2rLVJ5IdVXUfcl4E6SeBU2RehaxbMMWq2o+yyLiahhZn3Jq7zKTHZj5?=
 =?us-ascii?Q?jFso42Tp284iYNmhHonS32D+y4hyi8eLnIzpGjEHz6HZYQWBXu2nzmwL2dfZ?=
 =?us-ascii?Q?HZB7buTalEJyd5pTBQDrfF89/SkBS28Lrnnaq9JD1eX86I1PYptHIxF+OvYz?=
 =?us-ascii?Q?LJ8fCoiCRoZoNotQvXMVM8W+mGwbrYEiaiAtpDNM1VhylNiqhgmEomx1Y/bo?=
 =?us-ascii?Q?4dMeKE7fvDnCAew1u4HPIYQgg+wpbJz5ySUoVFAJ3CGSqN1s2D7TzLYeAmUh?=
 =?us-ascii?Q?OPKyaS/u7Kq+kbZWlUNNoSyAl21eYl41Usxz0a/K5H/1GWxqoq8O77oI4NnC?=
 =?us-ascii?Q?IHfbyrKWzfYE80qfBu4jjLshT9fOWvHPeQbXps/PEVxQ1P+BPbwO1fj4+zUk?=
 =?us-ascii?Q?eRrx5Ev4PY6DZwCnSR75jSFtwSiES0Wz7N27zjkVW6MUWmIQXlR3Sl/coEOQ?=
 =?us-ascii?Q?LVIagDWFlvYKhoIXy+LqCfMK5lyLIam8LeijZAzWpT5jEgi8lPvw3BhxgMe2?=
 =?us-ascii?Q?cbEOMvCfKAQfwCU2TXl+C3XcxVxYNPGuW3ihZftXcw6Q0ULb1wCfACBJBF4e?=
 =?us-ascii?Q?7fj6qNqoyCRfyMtdLY8GZQNvxob5kvsh4G0XRoCr9FF5ZjrJFE8/tL5Y+5Xe?=
 =?us-ascii?Q?1HdYhwwGBB1J2SABGix2Aqd55N/3nAhlAz9g355SiagpedFRTFGBdip0MhkW?=
 =?us-ascii?Q?r/U+h5SMWLTTGZkiqjQI4g143aQsdENFlQUPaIL/q91kPv4MOFOa/30T5PDb?=
 =?us-ascii?Q?eF4NSs0PGAjcE2KB3TUvZpUMlXtCNbm3P0rGj8re7R1O4wazxhInW0kO+Pcq?=
 =?us-ascii?Q?39eKIWs1skpDOazcAGI=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 19:49:45.0357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b780f49-ef3b-4f68-d7d1-08de47136a9b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9808
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

On Wed, Dec 10, 2025 at 01:37:31PM +0000, Shameer Kolothum wrote:
> @@ -259,11 +305,16 @@ static bool tegra241_cmdqv_setup_vcmdq(Tegra241CMDQV *cmdqv, int index,
>          g_free(vcmdq);
>      }
>  
> +    if (!tegra241_cmdqv_alloc_veventq(cmdqv, errp)) {
> +        return false;
> +    }
> +

I think this should be called in tegra241_cmdqv_alloc_viommu().

FWIW, vEVENTQ is crucial for CMDQV, because VINTF/VCMDQ will not
work if guest OS doesn't recover the HW error correctly.

Nicolin

