Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BE1C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 08:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucgDD-0000Q2-B7; Fri, 18 Jul 2025 04:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ucgDA-0000JY-Ld; Fri, 18 Jul 2025 04:12:56 -0400
Received: from mail-bn8nam11on20614.outbound.protection.outlook.com
 ([2a01:111:f403:2414::614]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ucgD8-0006BH-CO; Fri, 18 Jul 2025 04:12:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2zVTl2c1TXQbNLnWOnAhYg8b4SS2NnL4ALvH4LLFFvW4edTg/NJFL3qgWnnibW3A9llkgtY6SYsunzPEE9hHzKzfkflK15Jtic1H1v6z3eehtRjLzHahZ+LaA4ZZ722yBquOPsl/bOFgT6WZ1WZgCXlxeuxWH6lqSIFFMdSO0WxK6wTshs6dlH3v+J1NvpJDHlWnTzoMM5JeEFMnsV+02JY/P5w6uY+9zd/RrEB3KfHU6BEYZLjfBgS37fIcphAX5QtWLFYynI0HuFt8Juoehvu4Vh3wbjAw1vxqzJ/Z1N9rB37BUu/3S0uYMxhjTzhwcaWj3rIhfgr98VGRU1B4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeNb+lJ2wB7DhTr+3jucgapvqpLhktN/GObHTq01UzU=;
 b=aojk3/+yZml22ffXXxGqTMbK5m3/E4ih1spkkvjmthePS6IfbrIPendIKCsZz6FOiuXoIQ/CiXLfJZsN3OvfxpDJpqnvVyrp7Uj0wwIQAqKKxUGG8MUqeEdEVlfDOcE6PRA+ffjnazVgHJDYcMvSuOCvtJ+Ba82jWxNw7oauK2BQdh/Js3wyosX1TYiqUyXxJ7oko1u14OjrTOuhEFq2SnlSp9IkmLMfsMR0WRZYmLGyd1JkSdM3X0cQOc0ZNs/ZmWwBX+gXgE6mcXf8z/RBJRJDpkBjnQz1Dx49r74HcK8CWYqmd03ufWb9KLsBi2ifNs/+aXhy9tBB7MCJFZ46wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeNb+lJ2wB7DhTr+3jucgapvqpLhktN/GObHTq01UzU=;
 b=Ups0pFvQvKTecSYE4ilokpYP1EQjoWuZTI/zqfzEQuLOiTNMS2YnM97ijoawGqZ0pRIAvic2nTI4rzHSXnzLYXbUKR9QWCCIjHdt58dT8ld2BDMxfencaQOOcsei0NZUxKeGi9LF0fCw78Z/pCbM+MpQPsS/dHd8Hvh1fff6W0FrvY1eOwzJtKbiXTqGGqMNb2rzgzqQGMza23737RAYCpsnjTkw2udOyDhbXLrBsdmxiXde74TszOBmJMaQWM3IVYhFwqsCfLYR47jGI18fMudNlfmejqtJAd6Q8CH1MsqjAMu45wZwc83yz2sG68UwxkKT3TFadTN2RFGVwOtRXw==
Received: from BLAP220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::22)
 by CH2PR12MB4103.namprd12.prod.outlook.com (2603:10b6:610:7e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 18 Jul
 2025 08:12:45 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::10) by BLAP220CA0017.outlook.office365.com
 (2603:10b6:208:32c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.19 via Frontend Transport; Fri,
 18 Jul 2025 08:12:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 08:12:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 18 Jul
 2025 01:12:27 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 18 Jul
 2025 01:12:27 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 18 Jul 2025 01:12:25 -0700
Date: Fri, 18 Jul 2025 01:12:24 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "gustavo.romero@linaro.org"
 <gustavo.romero@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, Linuxarm
 <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v8 08/12] hw/arm/virt: Allow user-creatable SMMUv3 dev
 instantiation
Message-ID: <aHoB6HvXgkmkMQnv@Asurada-Nvidia>
References: <20250711084749.18300-1-shameerali.kolothum.thodi@huawei.com>
 <20250711084749.18300-9-shameerali.kolothum.thodi@huawei.com>
 <aHnJ+qUsVyu+eFaT@Asurada-Nvidia>
 <f793c36c2cf145b7842eb72795553824@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f793c36c2cf145b7842eb72795553824@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|CH2PR12MB4103:EE_
X-MS-Office365-Filtering-Correlation-Id: 990e7901-1219-4bff-e993-08ddc5d2df70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?So+LuPLD6VJfhOJdNHERwPeIpLZQS5N+Efi3ag6JBZEAqO1GMemxtmMDMnkn?=
 =?us-ascii?Q?O330P+Gfwex21na11yPGVAuBicxPWpPRlbJU8WZzTGVRZcWTmkSLFT/reJNj?=
 =?us-ascii?Q?+gAQ2PoV8bKbCiFWAnedFuRu3hm86QoH3t4Bu0EhwH1mMWuqcpJPkj5Hzhr0?=
 =?us-ascii?Q?cDIFRkkSWHtIC3wzbRjQpeKCieaaMWnDrRSoD2ZEd4TBA3bmyABuiFjceWVk?=
 =?us-ascii?Q?WI5appCeWSWQ/JSDqxAF3pyBc8JIMSOdDWxWj6BwTan+bPQpMNMLrRMSyFRZ?=
 =?us-ascii?Q?6TT+viv3tkkmpe3Dc2hcZgY26msnxBLI8wuzd5P5taMuLewXwuQVhdTEp9N6?=
 =?us-ascii?Q?JCbBaw5mV3ndvFM+9fiQ0iPhamJP9bD+eDL8LPJLXplxR5Ll9v+f+cFUmiNE?=
 =?us-ascii?Q?7Ubdq+uQXLL93s4EdMMWq1kgQsqzTbnsEoKMoAtXq3izGKIjiKVH89ESDgCA?=
 =?us-ascii?Q?RVyfERKK4J0HloISBolNYC7sfxpC8ZXVlmRZkCkk8y42p6aKHdO14hCRUA2v?=
 =?us-ascii?Q?xePHq62m7bgQ9pAHQ/3tqd6NflbzGSBLlgAsLFGLWjClzDZrlV4avnj5DCGv?=
 =?us-ascii?Q?9SL4cLDY3j2uBGFX7SlZSIJk6Nd7SP6zxOpWfitRxQrrtrW3jr2RnC0vvVXP?=
 =?us-ascii?Q?1PN63p6vVgHUcd3YH4tytFsCs0CghHTYUt8UJ7U2eUeXA/5R5ynlmSao6ZoA?=
 =?us-ascii?Q?ZkM3en0GhTrHrorcMrK9PAr0BfC5d8jW9cSjt8pKDuieL1Y7C7mtExtR3esd?=
 =?us-ascii?Q?ca+40vwikA+sTUemE3vbm+rkBm+dikogtWMoZB4y6v4WxIeHM4Gg+rRtJj0s?=
 =?us-ascii?Q?YSuycbgeCyqumtDkIhrRymLBNWGKn00hDVBQuPyBpZyTEA9OaC/NhcXqjgK1?=
 =?us-ascii?Q?PqUiCPEWk7/ufIYcK0YTBgifCd/1/KzdG4UL3hg8crjGCbKJ6vp32y891K3/?=
 =?us-ascii?Q?K+Wr3v4aVv+iBBZHXWfwyq1O+l11/4WFNKn9MhQMWISiJGsY0nUlPftFsBIM?=
 =?us-ascii?Q?STMgp1wPNdpOrcbDz8uT0Vjc0gXzpGfCxsz+zM3B3nQTgK75q55KB8J9/thp?=
 =?us-ascii?Q?BLA2UCr0zFT7Zm7N8/angOFEvf04W3L1D10JM0lAiO/eJFiZUw4I3jJnG+C/?=
 =?us-ascii?Q?wdA68c/f/37L520eERt5Gnn2C+JXknQjMHpaRe+R20b3qRK3ZBsocvcnDBNT?=
 =?us-ascii?Q?WXUnuSQoBZFJ6Fyj7KAKm4f4APw8Er7Y2ChNTi+nlebBteKUPs2TM7TyjDXj?=
 =?us-ascii?Q?64BNcELjfEalEF/vnurfHobbVQg1Jucy4o0Rp4e+cJmyV1gwzs0lGuW17N/D?=
 =?us-ascii?Q?iAo1VEGFK1QgeBVvd3zbLVoFjEWIBcz26D+4OpHDU8LwJQ2rLlZTnh93aQeB?=
 =?us-ascii?Q?Vjq5/GhEDjmsGrAqC+jZPe7MCCTzzg6BmfsoMqy3ZxSlqnrGT0C+0AzVt3yF?=
 =?us-ascii?Q?e3aZ36uok3ypRRjYVRSklJo+JbODGK9yB02NhZ8w13dbuAP3UqSdqTRKtdEz?=
 =?us-ascii?Q?F7+mCuqSOCEogMWoL58yQFgXObIpg1JDhzna?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 08:12:43.6974 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 990e7901-1219-4bff-e993-08ddc5d2df70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4103
Received-SPF: permerror client-ip=2a01:111:f403:2414::614;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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

On Fri, Jul 18, 2025 at 08:01:22AM +0000, Shameerali Kolothum Thodi wrote:
> > > +    int irq = platform_bus_get_irqn(pbus, sbdev, 0);
> > > +    hwaddr base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
> > > +    MachineState *ms = MACHINE(vms);
> > > +
> > > +    if (!(vms->bootinfo.firmware_loaded && virt_is_acpi_enabled(vms))
> > &&
> > > +        strcmp("pcie.0", bus->qbus.name)) {
> > > +        warn_report("SMMUv3 device only supported with pcie.0 for DT");
> > > +        return;
> > > +    }
> > > +    base += vms->memmap[VIRT_PLATFORM_BUS].base;
> > > +    irq += vms->irqmap[VIRT_PLATFORM_BUS];
> > 
> > The code is fine.
> > 
> > Just a related question here:
> > 
> > Do you know where we define the number of IRQs and the range of
> > MMIO for the SysBusDevice?
> > 
> > SMMU has four IRQs. And I see multiple vSMMU instances do have
> > correct intervals to their IRQ numbers, but I cannot find where
> > the magic is done.
> 
> Look for,
> #define PLATFORM_BUS_NUM_IRQS 64
> 
> So in theory we could have around 16 vSMMU per VM. It depends on
> other platform devices specified as well. Do you see a need for more
> on a per VM basis? I know there are host systems with large number of
> SMMUv3s, but how many a VM will get assigned realistically?

Hmm, I was asking how platform bus knows that SMMU only has four
IRQs. But I think number of 16 might not be enough in some cases.

So, my question was: where do we set the number of 4 to the sbdev?
As platform_bus_get_irqn() returned very correctly with 0, 4, 8,
and so on..

Thanks
Nicolin

