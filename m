Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B84CFA441
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 21:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMCOw-0008RJ-6u; Thu, 20 Nov 2025 16:41:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMCOr-0008Qb-Uf; Thu, 20 Nov 2025 16:41:10 -0500
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMCOn-0004c2-KM; Thu, 20 Nov 2025 16:41:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ynx31lSxnyyG/dv1VVbbt6UDMJ6I/pDcWp0B/ByyVwPfvqf2ktjgOaPKwk2XZdDKBWHBADePJkby3QEdOCTA7OU8BGPXEehSv1UlAlh/1HfDsIxpu2+MvZ58WzoeXhuCNX+9+bohpals3qafJruWCt22KrsVCz0WBG7jpvfNHj1hlCt9lmmuIett+bcEp8GQxdZdKWyfGVwmqOXIKcBEt9A/OlBzfBBr58db6FcM+NmSFSTsPK7hTLbjQlckgJLjfU9rsCzpGqT4G0wIgEQcbjz11j3N3Qd347sZhNyLzrPAjzzMV0HMW6zmUHgZ4fdc7OupenT2PYjgxSn2RYPD/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vav1Jvo17FvWMqC/fOG0sswuIyR5rAyaD+b4dc31cPc=;
 b=SkdMHkqEOrWxGMXya6SrJuxqmIaEB2hSlleHZiGjuXGpOMk24CKWuVt/tV8ebISxNns7PI0Ob6a3mRV7Y/Ml/h4QDT2a64T9PfBFQfGTDRct5s1j2Efvo9mPQH8wyFQifMA7tPxoCFVdgBDH3LHDl7v72NWBN4lXwznTTwLchE/Dg+RFX4C3x9sD/kjz4mj1JaFvIpKqAjk2MvSjWU4zkj10oBtcNfYrHGq1bF1UskXAXmhCk4zrLTdyJhgZpWlolhgH3y47V1AP+ZjtaSQg/hhuLusQ8YXt6IjNXbUxP33ZNK8d6HnRqE/A3iaMqA2U9NPTzz/6rvcvdzjjdGqKOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vav1Jvo17FvWMqC/fOG0sswuIyR5rAyaD+b4dc31cPc=;
 b=N6cnylhQObxsUEq33CpeeTHQG4XOMj7O+l1yOOMRS/b+D1veBeYCSFY2h6Yd5ORyUlKGe/fLMfdx+Ja0/7lV1bf9gxq+dI759S29IGk0j5UWTVRigFNFOn0GDpwnByQJjjZphtsVxeCXE7Ovr466qISdsinTfojLVfTLH4Nd/SMBNiL3y4eIudgaoqKsD7I7FRESucUyu2GP+ZQIXevPl4OhJkqNIAeMd0VAkLpJllYTEKJ6yPKWowoBtpQKU2h1sQoGi+4wE2hWzp4RW69GrizOy/rJ2fApKDrvYLwHVqV30X33dBKUBIilyAjmzmaA5yRQDylTElnmE1tRQndyPw==
Received: from DS7PR06CA0002.namprd06.prod.outlook.com (2603:10b6:8:2a::16) by
 MW4PR12MB7168.namprd12.prod.outlook.com (2603:10b6:303:22d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 20 Nov
 2025 21:40:57 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com (2603:10b6:8:2a::4)
 by DS7PR06CA0002.outlook.office365.com (2603:10b6:8:2a::16) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10
 via Frontend Transport; Thu, 20 Nov 2025 21:40:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 21:40:57 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 13:40:39 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 20 Nov 2025 13:40:39 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 20 Nov 2025 13:40:38 -0800
Date: Thu, 20 Nov 2025 13:40:37 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v6 28/33] hw/arm/smmuv3-accel: Add support for ATS
Message-ID: <aR+K1VKdiy9XHfHH@Asurada-Nvidia>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-29-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251120132213.56581-29-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|MW4PR12MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: adc2eef2-0a14-4600-f13d-08de287d7d50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5SIwR2VgE6LxEibPnIWox+sVukcpOY+drJfy9qbcNdbNarW78fd+Ka2Mug+8?=
 =?us-ascii?Q?e3vVjpuEYNQD+auCJ88TpC60TUryvrJHaAdKRCQy9JOjmDYx+5ZCImPuvMiw?=
 =?us-ascii?Q?tt167CilWj/+JbS6DTk8L0JfrraJ36xRfwJhRcpd+n+4oWHEyX9j09CpkSx0?=
 =?us-ascii?Q?Zue12s7nWjPQCOK9GJgr7KUlE+0P52heU9sPsCwb3sOaMoz+u9+9AvgFWsPO?=
 =?us-ascii?Q?DfNP1O3o75zHfI0c2DcmWSckMtVFNak1m4kb7YfHvGWz92NDYsCjMQXKuMJv?=
 =?us-ascii?Q?L4KdAw+6pdEZFzGDo0CgDXEuGOJO8Fc1/HGBkpKQ6rvfIbwXeri4wj4x+Bgk?=
 =?us-ascii?Q?Ulk8Vs7uyID6rG/4aElEoQvAskxtgmIgunAuf+XOjX7rzBm9Bqmdbx9Pku7x?=
 =?us-ascii?Q?1vi7OUKjS0aImZ5lBQsRHOr15u5UUujJlZ0b3P3LM21nCscLuG+rvQcjrEpK?=
 =?us-ascii?Q?iik66+GB27X755qlTuJ/5wCN2bLLTQuNNl/+lh1SCslNxc9wGzBVLgAEE8Ez?=
 =?us-ascii?Q?Ocwc6SuhTazn11JZaZ2vBfOAksnVBTwsmWkfH0zMso4pCRNa1sYguJq/VKw0?=
 =?us-ascii?Q?em5zaG7TX5WoGyGqhLzs8U/lC9X18pFoP7q1RIzEeF/l1a2os1rqc3Sy/OOz?=
 =?us-ascii?Q?YaZlg6LKHvpmQwFe7zv0+3R5+xWLdalZjw9YkBYBy8MGsYeFbia4aNU4YG1b?=
 =?us-ascii?Q?+3ecmvwcZFMC+eYpbg2lwZj+Azoh6kNazvcjxqzigBLmtkRN5pbjaPQwnApg?=
 =?us-ascii?Q?4ptEDDbYyS18PZ+oeHITRe126tvE160nSkdw2llIzi3ZeY//Yql5xcBwCmQ7?=
 =?us-ascii?Q?fLjyogP/QLWHnTOYYchzgPbi2LQKtFP1CzYec/WLBP1VjZlBD18MbxzDQ3az?=
 =?us-ascii?Q?g4QWQPob6ojYa/tBv4PDnGsFX350DhCvQ3yfK6D0CnGsrrD8OdSLX12RV2a+?=
 =?us-ascii?Q?VRdOj74ZZds8Z8DY5g/i2xFDYLc7a93SnntblmGSZT+Z4E9F4a3GVXqVEIWS?=
 =?us-ascii?Q?RmzxN1VXBv8u/8gQrVzutjWJhzJj+oqiXM7LIJeoFk8vocHttmtX9UH2qRU7?=
 =?us-ascii?Q?wNwUKiCd2QqzDe22imo8EmbCmy3IFxX03sdby3T90r0T6yZK1kaYxn9jNzaI?=
 =?us-ascii?Q?d5J0yzx8ukxxBBUXff0388uAoOyMHWdZJFxxDhMbrCBWQpv1LrZWQXmw3dH5?=
 =?us-ascii?Q?h9ZLetwanwAR/3Udvq41cSCuGmJFNP7wIduBXWoBRbU2351isbLki4wVYlyq?=
 =?us-ascii?Q?dAw4BWOTZRN1PUKS7C7zui/ZSBGfdd74UldHEFvK7bocVOdm5mUvL/rvznww?=
 =?us-ascii?Q?mS477jtRf8/YZDwIgFpN6AvM2/5suBCdQeV3yoEHRN/LFvNsJkTJ4ZOxwkNY?=
 =?us-ascii?Q?j6odaw9uM2K3W9ekwp0daDiywNvTOJFfMKnGw/pMBrwwmC3m27BE4iD68Pt3?=
 =?us-ascii?Q?WeqMcT9pNMKOdzojj6tVfBC2knee+Zb8Mop9SvungeSzqzmzyckx+iXdNI8g?=
 =?us-ascii?Q?V7JdQa9xuVLkbJMTbA3MLT/cVDQXIP/2XsytseHNrMePdAB+l/DZlPhhL/RE?=
 =?us-ascii?Q?ijvcYFPzpDOToRzCGDI=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 21:40:57.0372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adc2eef2-0a14-4600-f13d-08de287d7d50
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7168
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=nicolinc@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Thu, Nov 20, 2025 at 01:22:08PM +0000, Shameer Kolothum wrote:
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 296afbe503..ad476146f6 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1498,13 +1498,24 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
>               */
>              smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2);
>              break;
> +        case SMMU_CMD_ATC_INV:
> +            SMMUDevice *sdev = smmu_find_sdev(bs, CMD_SID(&cmd));
> +
> +            if (!sdev) {
> +                break;
> +            }

Should we do:
    if (!sdev || !s->ats) {
        trace_smmuv3_unhandled_cmd(type);
        break;
    }
?

Otherwise,

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

