Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABB8EA7942
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnit7-00080P-7V; Wed, 04 Feb 2026 14:50:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vnit5-0007xb-42; Wed, 04 Feb 2026 14:50:07 -0500
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vnit3-0001Gz-8s; Wed, 04 Feb 2026 14:50:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=deXW1ti7EMhj2eR1qiS+FFAD96NkcD7uFJ25qR5RaoVLhdyNUs9v0qb686B/00yD0a1AIHDDbVHEsfDcgXFi00ifCH1v/oX7btIozpl+hyaWj/zcPTYJQqupgNCJN2i7HawBwiieDREIQxnGttchhonv/Q9g2giAMTUJqa98H/ktFnYXd/YRGwhgYAgU7uEHp603sxm/QPbldDuMw7psCr45hxJR01LaDlwSj2LOl4N4N8biYp/T8WuVUYkkhRA8zZl0M9mZvDjkfzN/m5zbVXDbywLOc6iZ+Plgo0+WTfNjtRc16EQFO1jBgITgZGUlDqBDE3IF0PSJX5MHeL21uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ll3VqRU1tbwZVC1YV9ojC4wUvpQZZrJ9L2mTNoLVNI=;
 b=mgHyUuUNYnfRarSdltCGIZliySNT12FvWQ+x/rxZ/wh2v+N+Pe4m6PitDVfHo8sC5rDYtO4L3JjeIg6IC18jUlgI1sb6iz8Jb4g+5BfuKgZH20Naq/5qHKN3pmmTy6u/AfbRvLpbWU5TQJ/+3rNHl83jtwMt7g3LesXfHTAE1au4kZLLc95ddv6b5phc5vKLVsCmnH+j6mktZQ/7NNO4C8sdoYYyImqBgzbikRbzc7rUXbJF/fgKzhCwiaCsYhdGyTj4cBZIMHkJgQ/gYGUkVFhmj0UD9x872qCak8dcDE7mI7926u8iRz7f4fydqXgrrIR5OCmmEwlemeWhc4Ybwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ll3VqRU1tbwZVC1YV9ojC4wUvpQZZrJ9L2mTNoLVNI=;
 b=LOl3QLSb3pbA+3hJqYnnJJVgnYoLGp+884YL8C5Jx58B0oOcR8XiZid7Q5is7AbhFd4ZsOQkv+nYoUsR7ZyR+YotrEi/i99jnDOYRIamvAWTH/ZNEv3EqGApyWkYuoFjsyNURjE58vyucVny7v/WlDJ3shwcaPYpUTOhUq9K0wCHBpx15AVGLaXz1/Tl/v6WpWuCDPwKB5SGFztTRnWst6gVdmb9jx+1zhqcuU5ZBozXT3TK29c2F9EndDRg7lqUZ9r4TnRQlmYT0yjVRzR+J3Hh0A37QAY/8d4qxDim+Xy5AtubVfqZvzwVJV7AO/zg01QG65r6AzdE3u9rSf5J4g==
Received: from MN2PR18CA0020.namprd18.prod.outlook.com (2603:10b6:208:23c::25)
 by DM4PR12MB6184.namprd12.prod.outlook.com (2603:10b6:8:a6::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.12; Wed, 4 Feb 2026 19:49:57 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:23c:cafe::d8) by MN2PR18CA0020.outlook.office365.com
 (2603:10b6:208:23c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Wed,
 4 Feb 2026 19:49:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 19:49:56 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 11:49:41 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 4 Feb 2026 11:49:41 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 4 Feb 2026 11:49:40 -0800
Date: Wed, 4 Feb 2026 11:49:39 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v4 2/5] hw/arm/smmuv3-accel: Add viommu free helper
Message-ID: <aYOi07H88pXyqn5j@Asurada-Nvidia>
References: <20260204190008.20070-1-skolothumtho@nvidia.com>
 <20260204190008.20070-3-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260204190008.20070-3-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|DM4PR12MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: 6acbcb46-1de3-4a32-855c-08de6426928b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tRhF/WphQW2WbAyEr6Z+s404fvSstECKo+S36TBQlH5R0S7PrMhFSyC7n+kP?=
 =?us-ascii?Q?B50XKhGmN0b+9s8cM+0aRhZUFqMXLD4HQYa2tHGeROERZPTUtlZglyuk87g0?=
 =?us-ascii?Q?aK2aat3WQ8/fq2Sox+Qt47yqUJX6M9sOwBtx5+qYdc0E5Fmz2vSuD17t77jG?=
 =?us-ascii?Q?VNT5tQ9ikChQ7eLTQTKAdkDEeFWLEJUfKtQJTvPdDZYeoNDIdeoY4BSKXUYq?=
 =?us-ascii?Q?l9YLG1ZjwTPopIF6o9RNWqcRoF6igS/iNUGyEf2W3fDG5R5NW+j7sLTbwrRi?=
 =?us-ascii?Q?BGhP5gJ9O6H3DwLdnOapyYDAJMCFu57T5itVzoHinytbGreZkKCC1D8lmokR?=
 =?us-ascii?Q?SKkvjLkIiZJs4cZ+qPQSui3iUodlg6DPL+Q99YbRYxh13xwyw86QJDG4Um32?=
 =?us-ascii?Q?DmQRu9EXC4hnENFtTMHsPTCzJhuIz3t9mn/NeIW6Qr+A4sb8+Gy3cepDzsvc?=
 =?us-ascii?Q?KCDOdsr8s/7YVlVUnmapPuifd8iAPtCP0ty9I9KhV63YvSwIPaRImMkjiEja?=
 =?us-ascii?Q?1MCH8Nld1+XrUyXMujfSVyGnfPCU1ZlJrfn36zVqWxQXUmtTmZz+sBZwVFDi?=
 =?us-ascii?Q?5Egg2/QBqKzASt8uCrCKffUhKwGbUPk9DxxMhos5aSzjKvcSMIZ1Rx5j34eN?=
 =?us-ascii?Q?vBl73xe00jzFvgx1OkHlU7xvq6BGkPuUCtJsczNphAsK9C16p1eKQZzsy5mW?=
 =?us-ascii?Q?7ZTUdE4i8MY07IQRSvyCTKQIAavj2LLIiJTEmgF/8yNYIcxn0pcyb/oAw7Bx?=
 =?us-ascii?Q?OxFcSTtXkVuxRNmiqpXUVZKa28qIAdb+l/iTvjYTJkQS0b/cxSVgu0lu22JT?=
 =?us-ascii?Q?siRspHkZy5v6eukSHRuXwcKvOTdy4UVjmRGBxybjX+kiBqPutK8/5Oisna5Z?=
 =?us-ascii?Q?Oy9UCwl2insu2cx1M9NdB+icNMtLG4o1hfPCPJLPr1O8++VKW4MOtqXANgps?=
 =?us-ascii?Q?NlYD67ExslhusjQ+Uscccj4HWuGVD7omoGdBOfSxmSWn9jQ5mUCLEymoGhe3?=
 =?us-ascii?Q?FQcFOdX6OguwsWXuA784MNyGb/lOUvN2sKeX1A0NAxcLQ9XxKJVPVLsFps8K?=
 =?us-ascii?Q?ALufGEJvZv1swAKHd5Vs+gc8W15iyoPTWUkmXrwLQLuCFrpN0r09+NnUJL9R?=
 =?us-ascii?Q?/u2vmkQwmdGtG8vdkG7LwJMu+3qYlk7+yRjc/G1ZpyAbsYZ+o7Md+9+vXQ65?=
 =?us-ascii?Q?Q00eSSP2CMkLkET9oJF7lzTwBV2WFNqfWTEgezGpUR7TKCKbDfl0PAE8DSIT?=
 =?us-ascii?Q?ZCI5VjCQpSYEFsCuzAd9UlumCVjKOGthPEEkxyQSGRsTZotlB1c7JS0SxpsE?=
 =?us-ascii?Q?J2Z5kuYReTKsuD0fx6zymguzC8MOv/7IdYEui1k5+wcEBX447hRAPsgRvbJz?=
 =?us-ascii?Q?srhZXebncVV+A6tgvsHWL9kIdE/yG6I+nhTbwgQC5VQJEQOWYIt5ko5PDySw?=
 =?us-ascii?Q?yDZjHDitfm7LQBLJ/8her81AVUKv87qXWWJ+yg/IoeoRFTxg3B42dYT1wj/O?=
 =?us-ascii?Q?8BUnsA5vcOji38emVZIAN5M+APM1MF+Z8UqC+8EQFEoaQiujlAS1tTy0IaOh?=
 =?us-ascii?Q?7xduV1IyfSMCzzCrl6IuHXebdVEbpS8yS0EDXJEZbUoh46nhHsOOFei5gwyt?=
 =?us-ascii?Q?bzPtxWh0zaACWYxoJarY2SpIOq2KjFEJNjxNm7fw9svB5Vw+Yph4hCwkIZob?=
 =?us-ascii?Q?NmE4Jw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 460QsSeY8PdM/lNhF0oPa1G/bBHHAr2FY/9GWirHRcXSjYon6RJDDi1lrcd2lgScF5qOa4VeyL8at0cR7qAlKqPPPnq+559KQNFxx26L54SkMRCJ1n6vXClcoLWztaYkdHG5tp5uZ1X13hxjJO6JORABjDC7FKEvaf/133sOsa3YWv9PtLr1T0PAKWmAsxYm4v0VPKAKwDbS+z9sJb/lLOTZzMU+3zehYPTSI7Esst+RfY8aU/WNPHblUJPQNRNwjjbPB54NKExuEO5LG8WWm+FJe6lxq1KqLN/WJmwM9cZ6uUhMNdCaij0kiOsPx45rn44DXGRFsUjalgClcdRoGgC5lDE8Vgrb6wxdwgpydhyvB4Zv1MU5DU0odm/b/+y/K7MuDczR1E0cad+t/8eT0Z0UouO/2D+IIWVXji0G1j3mAaSiep92jRxsPLtb6840
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 19:49:56.1623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6acbcb46-1de3-4a32-855c-08de6426928b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6184
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=nicolinc@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
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

On Wed, Feb 04, 2026 at 07:00:05PM +0000, Shameer Kolothum wrote:
> Move viommu teardown into a helper function and use it from the
> last device removal path. No functional change.
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
 
Seems there is still only one caller by the end of the series..

Anyway,

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

