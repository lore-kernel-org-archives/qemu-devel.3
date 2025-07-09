Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5A6C83F17
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 23:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZecm-0006Rj-4Y; Wed, 09 Jul 2025 19:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uZeck-0006RG-WC; Wed, 09 Jul 2025 19:54:51 -0400
Received: from mail-mw2nam12on20607.outbound.protection.outlook.com
 ([2a01:111:f403:200a::607]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uZeci-0006Ja-59; Wed, 09 Jul 2025 19:54:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nkz8lzKNx3whbLXmcqForQKXsX627rJ42KC+eGIXXlsaHOJvarzntfIpy/Iy00L6BRv3vjY0FoU/NWea6fZzgEpVxYPAjYILDEHqyfsrigycpzoD+MxCkp4A3pSWeMHey8zGkfZz08D6jQM1Up7+E7LhkIVVvG99iwPz4fN76Wnwm1BB5M/Yw3Mp7WI7IcSpUAG+CwBShFiKl0LZHCp128yxZsf1wyH/ed3caUeEDdQVZ/jyHVk5sJqxb5uyNxf13O0Flzjr3ZtDl/Mn7Kd1HZ4wEUy8jW7Oum1p58YyAhpX0YtRId5obaC/haMwESqCR1HckwsLoGMi7C9816dsCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sXhx0bk2m5EI+PS22mnNmEQ5s50FEOt/PvFImUROAU=;
 b=uwktM9hxjaxYLftuzBLJMUJjGS14/RkMFcfkAknmqrs3oUe7QQrSpHLi6cxX/fVfBgECsEsJaXbQ5BZD4ggcOSyLW3GXxtWwQURdwWuTpTmxeZmL2NAvyo1FflsPV3E5l5qUX+5B8TWHZqJmb3IvaFM6twM4Co11zRnBvwE6Ycc5UcmrrbcLeeOSFUVERmwl+fNboPbt1yVNNWskVqkrmfLMWgqLqmaQIaNTUgeKoC6tbukcvG1hMUbSOumAxsM0ZmUWaaY12PLmu9AXKNmykTT+zSUhhtoScEZl580PuOdctDacdzmTvNgHHO2QevLeGvCEA8n7m+mC2vRSgol/+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sXhx0bk2m5EI+PS22mnNmEQ5s50FEOt/PvFImUROAU=;
 b=JzuWOY/wRrX3qTj1yPAn+9pe6jQAS0HUb5NkyI0BVa057d5pENUSFz4EgllmVhiOO+ZdknUzYcDUuhqB7nihYbGBWKj6ozaUc0qkgOye2Z6CAU8+cc0cOHMOWp7A9FJ+N+nfLelq113bKlih5Ut+d85ZHDN7+DfwblO8meWEoQVGMo/QAXBlBBeKC1YvRW9ZNuhzJ1Uz+DzcJ1arj2jMWeOyCUkhWIJK6EtsVRanJO2zN8mPHFP1dJ06OooXFghnxihtKc0ETjyWTeAynntFIhkyn9rrKHgb7tSsXwXiuLE3Q1RGjpb2FZDpaIg7ZYh7PaIEOVJLPXpKHCXsVB6GnA==
Received: from BN9PR03CA0602.namprd03.prod.outlook.com (2603:10b6:408:106::7)
 by IA1PR12MB6307.namprd12.prod.outlook.com (2603:10b6:208:3e5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Wed, 9 Jul
 2025 23:54:34 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:408:106:cafe::39) by BN9PR03CA0602.outlook.office365.com
 (2603:10b6:408:106::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Wed,
 9 Jul 2025 23:54:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Wed, 9 Jul 2025 23:54:32 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 16:54:21 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 16:54:20 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 16:54:18 -0700
Date: Wed, 9 Jul 2025 16:54:17 -0700
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
Subject: Re: [PATCH v7 02/12] hw/arm/smmu-common: Check SMMU has PCIe Root
 Complex association
Message-ID: <aG8BKexuSHtSvySv@Asurada-Nvidia>
References: <20250708154055.101012-1-shameerali.kolothum.thodi@huawei.com>
 <20250708154055.101012-3-shameerali.kolothum.thodi@huawei.com>
 <aG2GNcXW89stIZHa@Asurada-Nvidia>
 <92ca69322dea4a0b966ce9dd7eff0fb3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <92ca69322dea4a0b966ce9dd7eff0fb3@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|IA1PR12MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: 900191fc-4624-461b-9bc7-08ddbf43f3d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?shy6Q02+/NB6PWN1lUujeh+JY1o639qHrD53l4EYEKsE8eR3muVZg8G+4LTk?=
 =?us-ascii?Q?epzq49n5bjAvNYPSXAHDVHM11ufKkrGe21CDxAv0OncyzsGHb8VZLNdvedt1?=
 =?us-ascii?Q?Fl1wt18pAmuot4q3Kz+et4i9upaet0w8qUWfWnBDfz8luUgHcBURh1Ud5whA?=
 =?us-ascii?Q?5Lvj7MrvvF+jGCySqWZuN7ha36B6vbsKq5C9DGI2qrTT4a4dnZtVIT7QKj1M?=
 =?us-ascii?Q?Lwo4hKwtHjtQPoambev5rLBAGHepaNL4UJn42KFdZyXnxSD+7AfnDzQ4f6As?=
 =?us-ascii?Q?ajXEkw3g7gEB4q5cEEBaC+sXCcoSravkvlu6f4T0Mzyp5YZzwszBrC/2G25/?=
 =?us-ascii?Q?Af4eebXjIODCjX+4fBYyz3rwqfyKqrQgbf5AfHumDVpqfZ/qjU5igtTvan7r?=
 =?us-ascii?Q?fCbIiwI1Lar/4LBYJS56aY6KaTycHtS0N/+0CI5tTx9AOWEdW1rif4iGjiRI?=
 =?us-ascii?Q?Tk2D5bTHpyMby8oCg79LnygeLk8nCKTELKKHZnvRR/wWgc04lbW+YuFTBo/8?=
 =?us-ascii?Q?QpvgCE9jjqCfBsVS1LzUJkmJaUiaJXqFPx2SpvgVehfz0gcqw+JT21z2faUO?=
 =?us-ascii?Q?RjyPKYCDp+1mYOSc7xQZcSxQ808tudm8QXnG7hEziuRyvrAzJjmZcpb7j/Wp?=
 =?us-ascii?Q?a2hg9kmn844xClptW7sTKnltqihoTLJBgzRWVafnbLzlaIfK+SzB1+5s9vC1?=
 =?us-ascii?Q?zmhBSBJAg6dctkbr1xOiHxIvAeAJa2WI2I6nhq56z3rnEEwRXh0iTVNtuMWx?=
 =?us-ascii?Q?uBvJR29y97uLBHxD2+J66VlUk9Afz1KlLlUGjJ3yRBYjZxTBEjsfSdIbFLmq?=
 =?us-ascii?Q?5cdGh6T9cJkAMQ5PVnPoAqPiHkG9hBa+79/5ugKDHQrRlpQQvNJq35oYI957?=
 =?us-ascii?Q?jE82X/SXRboXUvTTA4a1eFOfl4Q1TJaheVIl1AYoKa/NnSCs3ZAbpTfRYb1s?=
 =?us-ascii?Q?7KCk7VTu6nDkBkY4c6lSnJBsPZNRWtqAvux8Y2wn0BkJ+crZZkC30N7olRI9?=
 =?us-ascii?Q?FF8ng3pq3NrK2BUWbc0rDG1Fdfu5cgWSDRfdVlGRPNK10/05Of06kMhfMuGT?=
 =?us-ascii?Q?FewmUwUh/DmqYkSTYYVVD9g36tcjEk1kmWOCtUKoa82khhOnGhBu++99Zlli?=
 =?us-ascii?Q?5LI//CZ98Ja70zzPPN6HuBirkLyB+dAFRd9vNgzxkh+8GZEvBa7OMEr1oa7n?=
 =?us-ascii?Q?Q7gQ41/M53wAY2lKBy3QUHRqJFmcFWEKq9P4VmPUhOYXNwAyOeCNVaMp+2or?=
 =?us-ascii?Q?YxcSNB93hys8XXBeDZRcDMbP+OnKi/1DmM3TPBqpmirzkFzuFMQDOd3MoBgS?=
 =?us-ascii?Q?wdL/zLJGFGMQI1PyndwFVFyS8uQ0MVBa9H5hpw2/baDEjBo/y5N9AQZoRopG?=
 =?us-ascii?Q?5U70Tm9Wb0E/UefO2vpUkkFVh6RY8cUvCCVw3SALUmr/ymii1PT22hJvbM4F?=
 =?us-ascii?Q?LryvlSfCaQKRwawSxaudFE1+rIodC3qkuCxaBaujYKo+oq9+U97g8IBExzGA?=
 =?us-ascii?Q?eHgC6kNphmIHA92opuF5tpQ/K/YnDCk+3GCN?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 23:54:32.9391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 900191fc-4624-461b-9bc7-08ddbf43f3d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6307
Received-SPF: permerror client-ip=2a01:111:f403:200a::607;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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

On Wed, Jul 09, 2025 at 08:08:49AM +0000, Shameerali Kolothum Thodi wrote:
> > On Tue, Jul 08, 2025 at 04:40:45PM +0100, Shameer Kolothum wrote:
> > > @@ -937,11 +939,32 @@ static void smmu_base_realize(DeviceState
> > *dev, Error **errp)
> > >                                       g_free, g_free);
> > >      s->smmu_pcibus_by_busptr = g_hash_table_new(NULL, NULL);
> > 
> > Although this is not introduced by this patch, is there a
> > g_hash_table_remove() somewhere in the code?
> 
> g_hash_table_remove()  is to remove a key/value pair, isn't it?

Yes.

> Or you meant
> a corresponding free in case of failure here?

Yes. But I saw the other two g_hash_table_new_full calls were not
reverted in the exit path either. Then I saw smmu_base_reset_exit
does the clean up of those two but not this smmu_pcibus_by_busptr.

> It's a realize() fn and errp is set
> if something goes wrong and QEMU will exit. Not sure we need an explicit
> free here.
>  
> > > +    /*
> > > +     * We only allow default PCIe Root Complex(pcie.0) or pxb-pcie based
> > extra
> > > +     * root complexes to be associated with SMMU.
> > > +     */
> > > +    if (pci_bus_is_express(pci_bus) && pci_bus_is_root(pci_bus) &&
> > > +        object_dynamic_cast(OBJECT(pci_bus)->parent,
> > TYPE_PCI_HOST_BRIDGE)) {
> > > +        /*
> > > +         * For pxb-pcie, parent_dev will be set. Make sure it is
> > > +         * pxb-pcie indeed.
> > > +         */
> > > +        if (pci_bus->parent_dev) {
> > > +            if (!object_dynamic_cast(OBJECT(pci_bus), TYPE_PXB_PCIE_BUS)) {
> > 
> > The pci_bus_is_express(pci_bus) at the top is equivalent to:
> > 	object_dynamic_cast(OBJECT(pci_bus), TYPE_PCIE_BUS)
> > Then here it is doing:
> > 	object_dynamic_cast(OBJECT(pci_bus), TYPE_PXB_PCIE_BUS)
> 
> Yes.

Hmm?

We have these two types defined as two different strings, right?

#define TYPE_PCIE_BUS "PCIE"
#define TYPE_PXB_PCIE_BUS "pxb-pcie-bus"

So the first test is to make sure pci_bus string is "PCIE",
then the second one testing the same pci_bus string will
never be true?

> > So, this checks the same pci_bus but expects two different types?
> 
> In QEMU,  we can have three types of PCIe root complexes to be specified for
> virt machine. 
> 
> 1. default pcie.0 (TYPE_GPEX_HOST --> TYPE_PCIE_HOST_BRIDGE --> TYPE_PCI_HOST_BRIDGE)
> 2. pxb-pcie (TYPE_PXB_HOST  -->TYPE_PCI_HOST_BRIDGE)
> 2. pxb-cxl (TYPE_PXB_CXL_HOST  --> TYPE_PCI_HOST_BRIDGE)
> 
> The above first check is to see whether the bus is  PCIE && root bus && parent 
> of type TYPE_PCI_HOST_BRIDGE. This will identify all the above three cases.
> 
> Both pxb-pcie and pxb-cxl are special extra root complexes based on PCI
> expansion bridges and has a parent_dev set(both has pcie.0 has parent bus).
> 
> Hence we check to see parent_dev is set and make sure it is indeed 
> TYPE_PXB_PCIE_BUS to avoid attaching to pxb-cxl. 

I see. That's clear now. I think it'd help by writing:
		/*
		 * While pcie.0 doesn't set the parent_dev, either pxb-pcie or
		 * pxb-cxl does. Re-test the type to make sure it is pxb-pcie.
		 */

Thanks
Nicolin

