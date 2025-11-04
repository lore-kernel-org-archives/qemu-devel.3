Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 781DCCCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 18:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGM1m-0006uW-Uw; Tue, 04 Nov 2025 13:45:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vGM1b-0006p1-Ld; Tue, 04 Nov 2025 13:45:05 -0500
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vGM1X-0003EZ-M8; Tue, 04 Nov 2025 13:44:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCzYLIWBq8EmgOZqurWH+i6TYrPCTjQZvpezRouEzMiB2gjpeISzeaebuZ1q8OT+tq/0bx8NVF9SGKJKKpy26YPbD5xdCdnUaU0WQNTu7on9jEBDD8DHjPeEL+mm565yhkSF76Bw7YA87T3+RVfNQ2uFJYj7suqdu7+DUJvKkMU3KNAmFX7tc/SC6Ws58B9k6/0qGV4Plsri59wTdxddhe62j93/XC9h+OtneWs+xw9WSr1jR94Jh/uMs0gC281Nk9wplOyG1YerpAYs71BICQTgoWdy8ojYNlx/mv7NUqmwjbj74y0N9egD6tm3GIRIBc/biDbhz2/YAryNI0DryA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Br4z7TQoV1h5B6+FmntCaowlSokCfKdpvGBbsb+8yo=;
 b=O232GDxV9i2JFzcVEWcUYttQCSxygtDPUazcv64GS43vZAm+v2C6lrbNrG6HBBMwkwsu7gbqSv1JsforQVPu5NgClWg475IyKHusVOIqd3uLASwrUJh0sOIRlAwX/n2QQX67h2fXOEquJBunwHeW2CEI5RJC+YdGka+2R6X9stZ/LZgvS2+cyzvKcLW/0iTAUIZqDu8BsZcPWQSKz69lfKcZ6F6vK2vcAp2QyHnG2RVobK1l4Wliv+Qo3jAJNvpwgaEWYBq3jHTvwSDSSqQZt+2UA3IBVwlRyuP2jMx7GSViEP93hSS5EWTtbmgXRIh/Pzl5dOe6EyelD5Qaj5Huvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Br4z7TQoV1h5B6+FmntCaowlSokCfKdpvGBbsb+8yo=;
 b=P4BZC3X0Lxx6abkhCPdyjW3imnaJ1L39aFScr2ob/5uhlDUjw4DtgAP5cgIrkZz/mR0eTLNBg6hGXNElgkSho99Jpa2Pk2OBXWRFPW+yFKrRcVQabMdTFEho0dX4kCa78pmSYH4P/kusGO8Q4y2yAIWVHHznMwjHYeNJfnox8wIH3aCbrDznkloTF2BNetqDD7gDUSWdNk/++BE2DorJf0r4nh3O0KZl2Mr14Eaze4RyCvAhRwDmpJs5NnArJqDx5aT09s/3+OpmIKPd4y8zcWZOEiOsTdh/HUVGTX8eP0n4xQO+EJtFT8hweLYoZc0X58O1+Ahvi0t8oCLga+mGgQ==
Received: from BYAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:a02:a8::40)
 by SN7PR12MB7912.namprd12.prod.outlook.com (2603:10b6:806:341::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Tue, 4 Nov
 2025 18:44:47 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a02:a8:cafe::4c) by BYAPR03CA0027.outlook.office365.com
 (2603:10b6:a02:a8::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 18:44:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 18:44:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 10:44:31 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 10:44:30 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 4 Nov 2025 10:44:29 -0800
Date: Tue, 4 Nov 2025 10:44:27 -0800
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
Message-ID: <aQpJi37XslsYV+Ez@Asurada-Nvidia>
References: <CH3PR12MB7548E5E1A2DFE297C4C65E0AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20251104145157.GF1537560@nvidia.com>
 <CH3PR12MB7548379E64E7A12904B5BF7AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20251104151234.GG1537560@nvidia.com>
 <CH3PR12MB754877D400D19E57AFB16D0BABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20251104153535.GH1537560@nvidia.com>
 <aQoz2+bLMJWNoVwx@Asurada-Nvidia>
 <20251104174152.GI1537560@nvidia.com>
 <aQo+oT0GvhDqtTuT@Asurada-Nvidia>
 <20251104180928.GK1537560@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251104180928.GK1537560@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|SN7PR12MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: ddbf0f82-cd64-47d5-7319-08de1bd23a99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|7416014|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DWZS4j8Us9/4PG0Q4Fb58IW5uFXiidaszxvvzSWAtHExH536H1UZ5KNEbrzx?=
 =?us-ascii?Q?jorrxEM0ZZU6NXV/Q4hpzg0o8vTusIp7jbY788I2xpBSvUUaba6WOCD1hNZ5?=
 =?us-ascii?Q?EXL1QdfzrlI9r49OmKVeyTSgaa5aX7S8Bd/+epH244jxlpYt7HwEZ3gVBAJJ?=
 =?us-ascii?Q?P4FbpAmL5PPmXGn2oPPSjBh52DDKKjp4lSVSnAApP3A8P6yEn74+FrRJGPic?=
 =?us-ascii?Q?hKt0adf5WDZxhTG25WspI6NJimEsf76ENKiatv8vKGeiBJ6JLk5PlsUkQE5U?=
 =?us-ascii?Q?+lYmFV9Pzd60ZHGeXq2M2nu9BmfTokskYrBInjzl93XSnj2/BuLTeosSsxoH?=
 =?us-ascii?Q?vR/8qarpHywa91Vkh7Yv5q1QDMNxXFwFpDloSDl5w3rNtsvIUOifXL3VELU7?=
 =?us-ascii?Q?gIycv1hMezwwfbNP0MGpwGWOWeXm0GYJU7coWmQvWC1x6glcMzYxqJvzyH62?=
 =?us-ascii?Q?yCNytcUcYWEWPBs5kaHUH7zweAxOOIY3jAvhCgXIQ3t2o2jsqshr5lG3VBpe?=
 =?us-ascii?Q?yL7j3uNDBz5TO18XJJdoDH4FkwNIBqgmqJ6QbUSuijJZMky5xVDMzWhBKy0U?=
 =?us-ascii?Q?GrWsNsqlKAqxfPjMcxVbe5j6AG0gcx2QyjhWZNbnwPPM4HE/vimM2mfR9Ysx?=
 =?us-ascii?Q?bWqnsv7e6Deo3vpIsqG1WHOuJhaF3TrrOWsxDYUhXERogHhZT3TRRzlWYOS9?=
 =?us-ascii?Q?8cu2GNIvM7BQBwp0UNH0b9Pu547kP1kdECjfa1g4VpigYV1DKyd25oqyI5SN?=
 =?us-ascii?Q?JFambE8t0M5l7RhqoEGeA2uZHirDm6Ia7ktBNYMct0JO6g6HScW+kBeDnUJO?=
 =?us-ascii?Q?FnuzNkZ/LbWlYEduXt/FJLXjj66pAOHWl891m/AgvPGxbh9YX8i65DrhSbh8?=
 =?us-ascii?Q?bHpUSkXIxv7mENQHg3BLHh6jUde1x0npWzNHeSfpPuQLXQPjG4K7s3beNosV?=
 =?us-ascii?Q?WduvEpThDm1WAO5znIU2EewB8tR1qigZNtOo2cOk+ceP59HN18JebnTslrGE?=
 =?us-ascii?Q?TfR83f0ELW5mEVbMQAYW0AERdNSCcoBZZVI38wJF3129Db0EzzyQT+FZPUt3?=
 =?us-ascii?Q?cHWhhFVg9eNrE3S/AvO0R1DxQXFE+Hqj8pRROg+joOYj4pjNepB1vjGSa+ix?=
 =?us-ascii?Q?B1vBYhfdOFSynpblAWbGKrUuiJMaKb5M7JIq7eRSQqAkRNYT/IB9ZAtF8Wjq?=
 =?us-ascii?Q?f9NLse+POm09JtIfTIhu7XGISVfb5AnK+B7QaLudGoYhVos7DrFSPJ55b+E1?=
 =?us-ascii?Q?BSxEwnQXrfSgD6TBn7ZSYtiJ4q/zesg+OQP1qp0vEQTwlhpsNut8BxRLBEiZ?=
 =?us-ascii?Q?T7qIFVkTTBgtXdKiWdHMqzTmJqRji8mF1dxGCnLy2VHTiTHeqdVttH6cqUR5?=
 =?us-ascii?Q?wwMR3pHB73BOheYEewMdkL4fMNhwyggfZzsuAglari6WFrl4fZ3W71aLjSr6?=
 =?us-ascii?Q?ucYtSAcl8z32FrjI+AU3q0H/deLDDEkgCQWg2QX9swf090+vgYtLWujJac1I?=
 =?us-ascii?Q?J9d2zgx41uD8bJQ/qgS5WgsNRcLEh6SJW6d4s6NFV1NI8qJ0w8/cyhZ0Qgh4?=
 =?us-ascii?Q?G6798+D0rRgVBqAzr5A=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 18:44:47.3158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddbf0f82-cd64-47d5-7319-08de1bd23a99
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7912
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=nicolinc@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 04, 2025 at 02:09:28PM -0400, Jason Gunthorpe wrote:
> On Tue, Nov 04, 2025 at 09:57:53AM -0800, Nicolin Chen wrote:
> > On Tue, Nov 04, 2025 at 01:41:52PM -0400, Jason Gunthorpe wrote:
> > > On Tue, Nov 04, 2025 at 09:11:55AM -0800, Nicolin Chen wrote:
> > > > On Tue, Nov 04, 2025 at 11:35:35AM -0400, Jason Gunthorpe wrote:
> > > > > On Tue, Nov 04, 2025 at 03:20:59PM +0000, Shameer Kolothum wrote:
> > > > > > > On Tue, Nov 04, 2025 at 02:58:44PM +0000, Shameer Kolothum wrote:
> > > > > > > > > Sure it is trapped, but nothing should be looking at the MSI address
> > > > > > > > > from the guest, it is meaningless and wrong information. Just ignore
> > > > > > > > > it.
> > > > > > > >
> > > > > > > > Hmm.. we need to setup the doorbell address correctly.
> > > > > > > 
> > > > > > > > If we don't do the translation here, it will use the Guest IOVA
> > > > > > > > address. Remember, we are using the IORT RMR identity mapping to get
> > > > > > > > MSI working.
> > > > > > > 
> > > > > > > Either you use the RMR value, which is forced by the kernel into the
> > > > > > > physical MSI through iommufd and kernel ignores anything qemu
> > > > > > > does. So fully ignore the guest's vMSI address.
> > > > > > 
> > > > > > Well, we are sort of trying to do the same through this patch here. 
> > > > > > But to avoid a "translation" completely it will involve some changes to
> > > > > > Qemu pci subsystem. I think this is the least intrusive path I can think
> > > > > > of now. And this is a one time setup mostly.
> > > > > 
> > > > > Should be explained in the commit message that the translation is
> > > > > pointless. I'm not sure about this, any translation seems risky
> > > > > because it could fail. The guest can use any IOVA for MSI and none may
> > > > > fail.
> > > > 
> > > > In the current design of KVM in QEMU, it does a generic translation
> > > > from gIOVA->gPA for the doorbell location to inject IRQ, whether VM
> > > > has an accelerated IOMMU or an emulated IOMMU.
> > > 
> > > And what happens if the translation fails because there is no mapping?
> > > It should be ignored for this case and not ignored for others.
> > 
> > It errors out and does no injection. IOW, yea, "ignored".
> 
> "does no injection" does not sound like ignored to me..

Sorry. I think I've missed your point.

The hardware path is programmed with a RMR-ed sw_msi in the host
via VFIO's PCI IRQ, ignoring the gIOVA and vITS in the guest VM,
even if the vPCI is programmed with a wrong gIOVA that could not
be translated.

KVM would always get the IRQ from HW, since the HW is programmed
correctly. But if gIOVA->vITS is not mapped, i.e. gIOVA is given
incorrectly, it can't inject the IRQ.

(Perhaps vSMMU in this case should F_TRANSLATION to the device.)

What was the meaning of "ignore" in your remarks?

Thanks
Nicolin

