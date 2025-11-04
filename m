Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E055CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 19:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGMlU-00068J-2g; Tue, 04 Nov 2025 14:32:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vGMlS-000680-Gh; Tue, 04 Nov 2025 14:32:22 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vGMlP-0001Fa-Qd; Tue, 04 Nov 2025 14:32:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h42aj1SQ3jOTAyL2ttDRvr1owzoznE4IBkVTIG2GBgZyQO8bfNgtBRl9QSQwclOfP7mYsQps5kpT7W1AQAAXeDCKpC01G/Eu3Endr8ALa9GhZrI6fs7av5o7RgOVARpze2q4ILMGkcVZtgJ0pAflFjdN6rHsuduPRR4vDxSrmYwL+Wh0fo8OENxLtVeBIMMXjpj30QqYH0pTf5aDs64ecRrzEHt8B1VgYb8oL7DsPX4ePLdjw02bRJmEhfdx/WpPk7v1NsUgpJDp2qslQfHcHsKZJfOiWz5m9GzTBk4R+iMKU4jBus2Ggy9EFfygfRgf5vtNWpyR5zMbLQf0a4wD5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W02p/EiNhN4nS8TR7jCwXh3ayTRcTGL6dPxJ3hDiruk=;
 b=GNPYHj10gAPfwnyD6eTlOcBs7Tc01NKdr0jTECbxLWql54Yt/e9q7Hktx9qVGZ8kZcNLixq0rorAI2Oh2tyeeJui+XTCneFUxLaeQGsHgNzPH2onv5m/0xg7oM2yIXTpq9cssbJHHBEDzxq9Y3h36ANcsDIEx/hfYyGR2ylMynH6/976LwDn5RBY0FEuOtY1nbQlQCPP4OLP0ptsYLqEPvkQ1KKK9wGSC1sB/zAfTRMN94qVGmvpdGOvZfXzumRlyEG9Tkpaew5RjZZFApszulpDqOcVEGG9tYlJixzD6n+UKUGgyZW90JxIZ8/EIU/KJbY21kbUYbNJ3aqoMyP0Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W02p/EiNhN4nS8TR7jCwXh3ayTRcTGL6dPxJ3hDiruk=;
 b=setiebMb1MXv1fpqiZcGiZfFNDA0GFRIbkilgUHfcLAIx0lAkJgeokfy2OrmsifIr3ugK3YzT+e6rkV1ylSobaZHO54lvmv1WhFaZC1cOY/BY2oYzkTMSAoGtb48m8Ha+Fgsu3M0OR9c5Yih6APGF+SvA+BnnqnpYj8G2CPvn+Vic6+BS+IQ0Zwvohoh/opwS3MIYIJAt7VGA3KlK24/9S4mT3rsTfE1dP1Rm4l6W9F4oQ4KVLDPM6AudbSkcc0xNCeeQ0uXjG/lyBBBTsrfwlBbOYPNCh40bjdT1viZYRLom8pzQb2T8vFOZnL8BxKdbTK01LAoQSqfbU55YBE8sw==
Received: from IA4P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::13)
 by LV8PR12MB9181.namprd12.prod.outlook.com (2603:10b6:408:18d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 19:32:13 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:558:cafe::e5) by IA4P220CA0002.outlook.office365.com
 (2603:10b6:208:558::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 19:32:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 19:32:13 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 11:31:52 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 11:31:52 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 4 Nov 2025 11:31:51 -0800
Date: Tue, 4 Nov 2025 11:31:50 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Shameer Kolothum <skolothumtho@nvidia.com>, Eric Auger
 <eric.auger@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Message-ID: <aQpUpv3Rde0PCCIv@Asurada-Nvidia>
References: <CH3PR12MB7548379E64E7A12904B5BF7AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20251104151234.GG1537560@nvidia.com>
 <CH3PR12MB754877D400D19E57AFB16D0BABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20251104153535.GH1537560@nvidia.com>
 <aQoz2+bLMJWNoVwx@Asurada-Nvidia>
 <20251104174152.GI1537560@nvidia.com>
 <aQo+oT0GvhDqtTuT@Asurada-Nvidia>
 <20251104180928.GK1537560@nvidia.com>
 <aQpJi37XslsYV+Ez@Asurada-Nvidia>
 <20251104185651.GL1537560@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251104185651.GL1537560@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|LV8PR12MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: 984d98f8-e7f3-4850-c274-08de1bd8dae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YgiKKoYEA4spGNFL4nZ+0Lt/lqKRTGZn+gX/OsXcMZTonSXfkd4VYHFS0Lw7?=
 =?us-ascii?Q?PWHw1A22OFb2RTRFTIEFEXPCnB+dbZK7j9fSDDriZ1cvzV6NHeAINXIITs5u?=
 =?us-ascii?Q?Y/GS2fZ4PnxgUBc61Yudc/wP1ED0sF9M5ZLUHy222HaP/fvssUO3d0x8EMZx?=
 =?us-ascii?Q?hUl/aNJftM/4mIjJwmedahJTHql7c7d+XoIjOat8WTz5M+okbPnuLtAek3O1?=
 =?us-ascii?Q?Of1SN4jBkgp2AEPHWrfiDQEAqgl8Ew83OITOJsrkD5euFHwv/rd1CqnAb/VN?=
 =?us-ascii?Q?eq18lXZdFZ5twIareCvCpmhb2i87RDNcRkIqjbqWSHg7nL6U7EG99yjOka9j?=
 =?us-ascii?Q?8KMdm7PyRPdd0zVVHI4ztKEtEknxmytG+2tEF4+ThC8ybDVGaOnmOCoijQN8?=
 =?us-ascii?Q?6k8PYbcptS1Hvv6pClxVk4lfc2tLs9sdFYw9tVAeEAgyh8qrSxuu23wZ/Hfm?=
 =?us-ascii?Q?bLzy7QQXE7ZTFfOhJ/J4dDLSb9r4NsF2iFhlWx+Une6JrF09L6+9dqofgcOT?=
 =?us-ascii?Q?EXdRDuhE+2SuL6PPRuvTzrBVv2Fv5e6/y3eHuV9r8Gj7n5DkKLpjUBzfwgM1?=
 =?us-ascii?Q?NZXZqFmKhD33P7j9jZFjIKh5c7ruutIdfHwRa4/KF9YVAcFVOwKp3pNbXmLl?=
 =?us-ascii?Q?E2gTRfGVSe94jvtYT/bRY0wnXMoNkuUnC3sqvyNi6XgAD6tStJvmz42Myb41?=
 =?us-ascii?Q?/5Q+52j9HcxD8+d76SKV1hI4KDyjvdYFr9UeWsVtKMH67yyjCF/wpjU1NE9d?=
 =?us-ascii?Q?pghZrgaxAWNH2CupSUztp81vz5EH1GXNlhjBuGAoSDigvrVcoqpZY6ceKZJH?=
 =?us-ascii?Q?7jvUenNci8c5qwRQ1jm+9w8auC7dqXfWvTc5nAp5yUQ54onM7v7QJnNWbrVu?=
 =?us-ascii?Q?rhhvlOpssJWbkhf8/TrCB8Ex1IyAfnWEp5CWaEhXe/qOKiYl0xJPFm3U+7Yt?=
 =?us-ascii?Q?sy37oJPCxcdiOo4RNlkCYwQJ6nyV3auj/zQXLFetgPeCy9x/2WrPcxnwKr7U?=
 =?us-ascii?Q?uK3ILmVBd1TPavYhfBQQDISNECujZo7GiCtjyuvh5OeOvQGSvag6M52pPN4r?=
 =?us-ascii?Q?Vdd+Qpvx6dkeLMecWZfqt8fJnGHMEquGf20aPu7Fv6gGHOksYQbFD8e6ua8V?=
 =?us-ascii?Q?+7LeH/Ty17WODX3r7LX1MwtMEsG+YODXiIJK5LmdknOCpAL/Er4CivbCDD+N?=
 =?us-ascii?Q?b3Artl8/fu6QP4GSkIwVT8Stw+nTHULiPsNfaa3Gn8Gvm/CBC74UCUqutMr8?=
 =?us-ascii?Q?PSXghrIV1QadzUz54rjVLw7PNnHIUOFpoVMbbKe/2n89tBeM7YvjFHfh1IpJ?=
 =?us-ascii?Q?w3n95UJngp0sDCQ17neOHjIvkdwYH0DGirELtclGDhUv1n7I6FpOR6Isq7Y7?=
 =?us-ascii?Q?iXMg5gf30GCuxxKtxW2jpjYtBEya0GepIC7rhQNeO4KoqvRIVDxY0Ys7RcRX?=
 =?us-ascii?Q?L8tf9VAJLNiTxg+GYbx6Kk57I5U3hGE2B4iSQaTqpN/gqc2w1RxDV+tcAVCF?=
 =?us-ascii?Q?t1A8RUz7eTBssjLZFb49cegJtkZdO8/wS7G5z/u/u13o0HwYTOdHT9aoxWzy?=
 =?us-ascii?Q?1CfLQOFAMNyP+wSVvoY=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 19:32:13.0773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 984d98f8-e7f3-4850-c274-08de1bd8dae6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9181
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=nicolinc@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 04, 2025 at 02:56:51PM -0400, Jason Gunthorpe wrote:
> On Tue, Nov 04, 2025 at 10:44:27AM -0800, Nicolin Chen wrote:
> > KVM would always get the IRQ from HW, since the HW is programmed
> > correctly. But if gIOVA->vITS is not mapped, i.e. gIOVA is given
> > incorrectly, it can't inject the IRQ.
> 
> But this is a software interrupt, and I think it should still just
> ignore vMSI's address and assume it is mapped to a legal ITS
> page. There is just no way to validate it.
>
> Even SW MSI shouldn't fail because the vMSI has some weird IOVA in it
> that isn't mapped in the S2. That's wrong and is something the guest
> is permitted to do.

Hmm, that feels like a self-correction? But in a baremetal case,
if HW is programmed with a weird IOVA, interrupt would not work,
right?

Thanks
Nicolin

