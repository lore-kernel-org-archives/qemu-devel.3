Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C20CFA441
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 21:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMCC8-00045D-Lh; Thu, 20 Nov 2025 16:28:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMCC7-000451-Gg; Thu, 20 Nov 2025 16:27:59 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMCC6-0000pt-0r; Thu, 20 Nov 2025 16:27:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s9z1vY7P5e8nPdg3zSdQCjE3vKBdJIc6yg9nbcgFqv5WZ0avC/PvLqIYLo6XZ9DPskFehizYsfjYb1AcQ8FwiJZH3/qbpnmxDGIQEcnRAowuuRMY0ua2KMlItLZ2gi2lWiappT4u8UfidXsCnKQEAeIbnUpZmBsjpY/niV/nilFWJTcuKgO+63WLOvfw6ruWHXUjvJ6O/UUgTifTlNPmBYsZhU6ndh+CIDLXRM3cPQtgAO6458GGVdjZOAtO5v+yfHRzqCoUuhdEwZg5crlsL9UlNT788KSVYQewyY7BIB7epYNE8q8XiaQRTMMwMKoTykb+I05hojpEReee++lotQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PS74iF82yiMFhCW7XH+3KlelyRy5Ok2Wo4Yscu9nqog=;
 b=xYSc/xsF0Ivs0C+QqXBYD2ivylyRHdvyP/Stl8RO/xyKZxxuVjkfTRmOXye/g5XGfv76CdqBeyQKy5LglqWPi8njvM+Jomx42BzaBGHg5VwNuCLKZEzSljzBCT3KE61eESaW/LPxf3dOTofUC1DpVig0v4jiUUrxyWlQ39rV8N+GOMVbtFMyD0jCR5k/0jffoD66nlbPP1huaX84aPUWNy3Ob37oldj994Nv+jE/1o9zhdMwy9OVB9JM2mC9jVDh0ZRnXupB9x/ybxzs6EK4si2F8PHhBGq/QgmP+bcdWqNQk2wFLBArKh6FiltdGC0MW2qCJGnjhMlG+e8AFbqb5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PS74iF82yiMFhCW7XH+3KlelyRy5Ok2Wo4Yscu9nqog=;
 b=pfKZU61bG4aSftgB0carS6IWaLDUVU1sssriGKJvkWwClTxXIeQFz8vVTQ86KebTeh5yRd7tmJqh8BIO1C0iXkXzuhTGhyRfS28z3Tw1cmujOv6j+w2GJqUpeKASDbagAeGzfqRBAtWSJEKrGJdQunXBVcBihwQ55VT8ztSo6W7c7vdefR6WOFk51TfJz0kn9ZcIDOIA7tfG86JU0AEfqJdPALgZZDFHAdxIVVbO3/G8xhYO7L1ixDiENmSVGiLCFle4695PlS3kxfI+Z9nCCD5LWFtTjYDsFdosJQENcCLVwuly9AuAKFlFM2RXuAaTxj8d2z+ipgemM4pqlrESwg==
Received: from SJ0PR05CA0001.namprd05.prod.outlook.com (2603:10b6:a03:33b::6)
 by IA0PR12MB7626.namprd12.prod.outlook.com (2603:10b6:208:438::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 21:27:51 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:33b:cafe::41) by SJ0PR05CA0001.outlook.office365.com
 (2603:10b6:a03:33b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.4 via Frontend Transport; Thu,
 20 Nov 2025 21:27:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 21:27:50 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 13:27:25 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 13:27:24 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 20 Nov 2025 13:27:23 -0800
Date: Thu, 20 Nov 2025 13:27:22 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v6 20/33] hw/arm/smmuv3-accel: Get host SMMUv3 hw info
 and validate
Message-ID: <aR+HuvInfdzmtRSs@Asurada-Nvidia>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-21-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251120132213.56581-21-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|IA0PR12MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: 7178f64e-1464-43e0-fbee-08de287ba8a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FfmENXYHdfRzBwmhST/QACeZVcDKQiKC1YpRRgJwNLjsSZKSXS8f/ZCDD8hc?=
 =?us-ascii?Q?1v78UC+huKCQWxeP/YHJ0MnFMhDeb1DPgi7NQFCYBN9e8BiVBEDkuaF+uDH3?=
 =?us-ascii?Q?cHkWKIfhaNBmi6In4a+ncpHUf0AbU2NoW2ApDc2HYn1TspAzEwgF/wAee4Cz?=
 =?us-ascii?Q?EQnea8qQ8GqB+4bsHMJq0dTIDk7oKE6Amy3BZT5VyHtMYDrkepchF+nYGMLV?=
 =?us-ascii?Q?Z1G33HDWHef4vrngOdi4H6PgMz8XeAWqh7kppGqlBy1Fs6Fkg3ixFYAJOurG?=
 =?us-ascii?Q?U0VHzQfVFonUUVkxsXKQzxOOdsWvFZWPBlrHEJY+wGQn2PFRVPMEKAE1M/hm?=
 =?us-ascii?Q?Vm1arxmrP83FfzXPkBXsF4xJKGjdLcilS1AFl71BRSE1TLz5QyNyEGY0Cggc?=
 =?us-ascii?Q?hTMbGUo9608ue+wG48jJfc0Y8nWzBg4N6wRq0d+pZKZlvPFjJmmQfkH+9YDg?=
 =?us-ascii?Q?fXlAZbAsLhC+vVWAq7oxBBTcsM9R78V5bd+v6FaioLUY5ocdmgBtn8b72ubJ?=
 =?us-ascii?Q?FpOtk0PmvlhC5Yh2iPshxJjO7pvqCQEyfJYh5Zt+9vpAgBSENeawWU8aCWl2?=
 =?us-ascii?Q?e5bCVJB35sYLVu4MO5rU1pf435bVES+9TCd0mfTU89CEMZFPTvozcpxicviU?=
 =?us-ascii?Q?XIjBADdJthC2+XdeG6HQj9QK/PO2jDu7DE0rCNJNemaxBm0oDirfToTRc24A?=
 =?us-ascii?Q?7DTC8pAyo8JZvhspoMz5x8kLckxt6mCd8eTSfptI1cFUNycRFz/zcL8S8pi4?=
 =?us-ascii?Q?uwjEE/LtEBhgkkzJxkzNunJv+lgpVdw6lgp6HXnrxFCKefdG+IP47Nwt7pDn?=
 =?us-ascii?Q?V98Sn652J1f0xbFw/hMlKOIKhasfgSSx6BBEfr9aCvmcF9ayvTD4qGI8sUvj?=
 =?us-ascii?Q?4qrIvg19O4ccp6+P9Fp1Jun78AWFAhZDghMywk4Zxg/gRJTDnx0Tzesw/YXJ?=
 =?us-ascii?Q?9KEe9ZKCp1ikRUNkyZ6X+pqFPuwa/jkNEk7iUgKVuckNcd71h6EyJOzIQUM0?=
 =?us-ascii?Q?BncWNndVW1SOMtdwOx/r6ezfzzFYnENjtsDKmOmNfYrXQu92wSrtcpz+5uYQ?=
 =?us-ascii?Q?VDMmJa7A2/Zyh8Pg3sPXs/WdthLDZNL5mpahyo2l0ZfkRqseY2IAHhDJm+QA?=
 =?us-ascii?Q?WkPRlhq6P0wCxBnH/0Ibrsnvm/FO2J5hHslK7L+KulGs0DrKSx8rrKiigF8S?=
 =?us-ascii?Q?ffA6+mb5AN6jmYxCLtWe3iMF9TcvWUEWYzSSgbDoQ1cxoPoKe1mnhfut2xrV?=
 =?us-ascii?Q?YBrV9cUe155n69A06J64Sk//VN7FAf8mca7YtcgRKFKeso2xeWosq07dU+6H?=
 =?us-ascii?Q?8lJivu74eY3q+NFGibnomyNc47uPc1RG8v48bIwr72pOwNl7jRHY6gfwcbSe?=
 =?us-ascii?Q?riGiEry3tKWbbV68nN4XV1kio956dK8VRxt4LfnFm+uoT8Z/EImcHjuodi6h?=
 =?us-ascii?Q?8chOodJBm/lCo2X4223QjNy6uTMtBn6fG95i3kUEIVw07WQrsM5v7WVRNsSQ?=
 =?us-ascii?Q?DgznyKEwXfE8BKP2VH5Qy0BzyQmAjL79FS/4yV3I8nCqr/A6pXd8HzWb/HEe?=
 =?us-ascii?Q?pfPujbIQ/9hpAKT+/5A=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 21:27:50.7997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7178f64e-1464-43e0-fbee-08de287ba8a9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7626
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

On Thu, Nov 20, 2025 at 01:22:00PM +0000, Shameer Kolothum wrote:
> +    /* QEMU SMMUv3 supports Range Invalidation by default */
> +    if (FIELD_EX32(info->idr[3], IDR3, RIL) !=
> +                FIELD_EX32(s->idr[3], IDR3, RIL)) {
> +        error_setg(errp, "Host SMMUv3 doesn't support Range Invalidation");
> +        return false;

If host reports info->ril=1 while VM sets s->ril=0, it could have
worked. But this would reject the case.

I think it should be:
    if (FIELD_EX32(info->idr[3], IDR3, RIL) <
        FIELD_EX32(s->idr[3], IDR3, RIL)) {
?

Nicolin

