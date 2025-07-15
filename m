Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAFBC83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 17:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubjYf-0004SP-7k; Tue, 15 Jul 2025 13:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubj8b-0006nk-0a; Tue, 15 Jul 2025 13:08:31 -0400
Received: from mail-sn1nam02on20605.outbound.protection.outlook.com
 ([2a01:111:f403:2406::605]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubj8X-00049M-M8; Tue, 15 Jul 2025 13:08:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rEqAsnLE0+dvDK5Po5KKFNhTlXkzV92I9aBE4OXR1JYY7K4iGCOurH9aMHuTeBwfcheI0FmNbcs9jCK5UwbP02MTvWG/D9c1yrd4TbtJ4znbZvn1Rrp9naKIjIXY2pNHGoNx9Rs184sClJYhI6jviuFwIoh6ouuxbx8b86mhxCi7T7quWA+gASwf5dGdzrHKcnfwAW1UA1Or0fxpBGEv2KP0auJxsMiCAhMvB3bHKP6cAZarmbpnzvBOHtf3pba8NSlN0cu2/UiMTKk1oKHiSKXZKi8WSwKim5aligCgiw1zDNqCSg0aKat1GaSiaXohW7rki3bSRmYljtfogdhcww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsIw30JH3JJ9dIoVU1tdCaUqyimVT37kBHQZvHZ9VZA=;
 b=aeLYaNaKI80ZT5oAcjd6o4Dga1WB6pMlemyZqJSIN5oz7PbdHFP8e2UeNmzVTk6Lo+REPOp2DzfLA+h99PeiRQ+VKDcdqJHnYxw/ia8to9lsweVuLNwvDTx29U1S+3YtaAbWyC/100zLqLNN0NOFzZinCrFJmJqPjKArDI00MjdUWcbQAPY5cJvGOTCOyw/XrGTbF9Ryg1s84vRcVcKG2TguCIlHKY9cfpZEth9GRwSuRbvjuezMu1aWN5vE54bDoc6tAP7uPwpMeorSyt01Ii7unzyRK/mfa3NojCfUd+IagtDmTwx10X7Od8F/09LGkndBVOa2u17waPNYWN4IOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsIw30JH3JJ9dIoVU1tdCaUqyimVT37kBHQZvHZ9VZA=;
 b=Zj1uwbx1J5THSGp43XllcpaXxxszsxYT6Jar+0cHFQ4/pcaPHjzTwX5U7TCLuBNxNlP4csEvli/FAtQ7OYuZzrK3Bm92NPjBXI4rDfXRefs3sMQ2hgW1IpyIVbA+3upCvZOm3+ezHz3t2wM4MTqJTCinu7suUR5pRxneBkL/qnshJyrilzUNcb2RKZMbGF5EbJDtTqRnjIZrMhrcYElrqp52li2hzU0TJCGHGTMcRBs/C9h1WKZjE2oOK35zF8NNFM0cxYDL+NYxD7j79pKFMVbZnyCtq11LQwhGN/RobbgVfrq5/9T5x6sYLcVRet3fGEoOs7yVHPv+0tInrd8wAg==
Received: from BN9PR03CA0287.namprd03.prod.outlook.com (2603:10b6:408:f5::22)
 by PH7PR12MB6419.namprd12.prod.outlook.com (2603:10b6:510:1fd::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 17:08:08 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::c) by BN9PR03CA0287.outlook.office365.com
 (2603:10b6:408:f5::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.19 via Frontend Transport; Tue,
 15 Jul 2025 17:08:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 17:08:06 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Jul
 2025 10:07:47 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 15 Jul
 2025 10:07:47 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 15 Jul 2025 10:07:45 -0700
Date: Tue, 15 Jul 2025 10:07:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 <linuxarm@huawei.com>, <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>,
 <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 12/15] hw/arm/smmuv3-accel: Introduce helpers to
 batch and issue cache invalidations
Message-ID: <aHaK4FGggq6MzWUV@Asurada-Nvidia>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-13-shameerali.kolothum.thodi@huawei.com>
 <20250715113954.0000449e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250715113954.0000449e@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|PH7PR12MB6419:EE_
X-MS-Office365-Filtering-Correlation-Id: 6026711d-f5d3-4bdf-c0d8-08ddc3c22b24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|7416014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qlfMDHLqPhFcckxu9eVqNvTs0WUuewAjrBfcvFNP9FOOVbjpY7ly6B48pGyr?=
 =?us-ascii?Q?CNYqXS1MK1Q8BqeMGrfhkHlPk+qKScHrM51uWCFimfp1WjYINsgirs+en7FL?=
 =?us-ascii?Q?6EyMsXzeAkKgC1Plkv8cs0fU4MeiMHrPF/2nZuwYCfM6mn47VkJwVcSvIKSg?=
 =?us-ascii?Q?o5X+Ythgm2pfkh0ZmghdjAdJCMNPtCGZJlyQq/uFnme/pwBLjdPgaD0uigLC?=
 =?us-ascii?Q?KYGKqav46OIummpVezkQ43y6ZiYY5kiRovp8Q74gnYMUZ7q5NGM3dnzbKPl7?=
 =?us-ascii?Q?cdZda/gqgAUAqBrmpU0v/zTDLwrNF5m+0UrPlPQ4G9AV8aEq3i5rTJAywAxD?=
 =?us-ascii?Q?qekmK6AHudFIy+0Vvv91Yks0DmlPoj9RiQ/1aaq7UAfLHqsv4L8Ch2AKY4d3?=
 =?us-ascii?Q?GrdEqVDQgsa6LF725qn6ukYXSxB9VQG4RSaypTXHACyGAVEaGDYlgROyaznC?=
 =?us-ascii?Q?ZgIOilB8M9s+lIn7I4ktYGLQppXIbTncZrQEU0K8rP7BnCtLiF0LJQIFIE/j?=
 =?us-ascii?Q?MVFuRkk6LklJRbRa8/VoPkXjdsdHqNfstsf39ulSWs25syV7A8gbt+Wtf7RQ?=
 =?us-ascii?Q?Q1tTLVe+C0PXKaNHIEQQEAXmOEQPXtXuchnCN9dtn6Gf4UhC90ypKbG01Mak?=
 =?us-ascii?Q?1ZHL/2myexESMGfjyfi0+if+wzjMdjOAEqLi8Ti9l26jOSL34Xz1Bt6UoFQa?=
 =?us-ascii?Q?S8jhdZpa4mDKc/dlgr455gUmKdOsh7cLkTqAO1kA4/YfxqDGW7qE9WrkRBrL?=
 =?us-ascii?Q?qIX/qhZiz4pyd0zd2AoVuSl3knYQDpfbL/p2RHabQTZejnsRyJ26zf+kp33T?=
 =?us-ascii?Q?UwI0E897rQ8m1/3fr5cDzV6lRlOcCqW+s/GJVJR5ohShqd9O4o+xwIbVtFbz?=
 =?us-ascii?Q?PLQta7Jg3yN1ukwjav7PZDCJ5oqoPzwWRsLfb/TqC2KzKgJ5lDzzX23E3VTw?=
 =?us-ascii?Q?BG6Zh67lAkQKZQhbXpZc7LhZ7hm4mPSlhdfaPZ6JtTJzqYPXFVsaMPJ+o7VT?=
 =?us-ascii?Q?5QWC/NLRP0M2q27ZJ/VZkd+BMy3isV1+E/tLWQGGMqOrgxoGiPTFW1isHfKt?=
 =?us-ascii?Q?LcpfWhK2CFgLR39uZSVg/i43X2JddWpWTjWC2syRjNOZ9GlkALO7ugUyvobX?=
 =?us-ascii?Q?R+Ikij/X0iYqSXN2bvblgleAAfKfHlkMZ6/77mJrwYuyIrb4q+4fYq0nwg0h?=
 =?us-ascii?Q?Nevx0CLZ2PhUqoVDdiFd+eeU91y76xmh8/A9e89DKjhmvH0nfwKpwbcZuzA4?=
 =?us-ascii?Q?e/OH2EEH0EevBlEeRqEFOL0sCkTfhSO/xHhQVK2KqBJD8TDmIufP1vmbfqSi?=
 =?us-ascii?Q?fkupn2xtcPjL7nFD/GvSEKgKXcStgr7V32Qebn8qUjsXJTnUFb/bEl2H98kV?=
 =?us-ascii?Q?YGcaMW6BpOjQA+BwJrlLhtf2eVPtwUxKEH5IVwAXxNdsE170sREuO+NkVQIr?=
 =?us-ascii?Q?ByCAIDeG94sBohkY7c52+7bC3xELCc1bSqqwNCik5NEFz9sl7ZzZ7AD1IRoJ?=
 =?us-ascii?Q?4jz6iKINen4JibgzMOocqJBrlVyIozsSZQgS?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 17:08:06.9448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6026711d-f5d3-4bdf-c0d8-08ddc3c22b24
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6419
Received-SPF: permerror client-ip=2a01:111:f403:2406::605;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 15, 2025 at 11:39:54AM +0100, Jonathan Cameron wrote:

> > +/* Update batch->ncmds to the number of execute cmds */
> 
> Not obvious what the return value here means. Maybe a comment?

I think it would be clear once we fix the typo in the current one:
s/execute/executed

That being said, if something else is still preferred, we can add:
Return is true if all cmds are issued correctly. False otherwise.

Thanks
Nicolin

