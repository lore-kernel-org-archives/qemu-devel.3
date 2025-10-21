Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A961DCCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 18:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBHXn-000446-9T; Tue, 21 Oct 2025 14:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vBHXi-000438-8n; Tue, 21 Oct 2025 14:57:10 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vBHXg-0005gN-0Z; Tue, 21 Oct 2025 14:57:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HjPETUiH80tftcfvsEaXrzMVQLKjbWuHipt0LkqP6k1e9neDa0pbuR8R76utBJlggpwDm74AWsnRDfS+U0jtfWf/s1duvKTahJo8fG9/n3qP94/ujRw4Hc6pxq7NTifS83mTq0/Tz4Ap8N9LIzb3P/St73D4LbS43HD6MbN4j+rbZTXXZe8IB+7Zv7dA9Un5viz4rQk14EAp3s51kofhmSqfVXPo8SS7tk9s7Vx68o6Cy03LN4Gz7x2dTbNQPzjTBBj7kY+iBsBiZorYBGrkgNCwiQO+jw8VoRPU1rnHLcuc/RGCiX71kRT+QEHMBlU+EBZe3LUBiuOKGNO17rf8JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alchfP4f2aqwlTcTGCQjjgQZIJ+cGaRx8CaLZ6IK0/k=;
 b=badKSXFcKU0rJOuMUkw3+hhiQj3aEUljQnZwu3l7vC4nP4pl/xLIPF3fQ+IPW7MY+BDOzU2cLc7fy7HLGEOQUgPf42yVv3PMBqcjFMhxk4Rwttr6NSvFC4scJqBjUKm5me0kenALvRpjD6/faXnJpIb6nm9jKUiPU/cJiwIWRUn4sE5RdTZOmTDShDgeNUZN9K9BeJASUNukLpPdvTFMBbKb1lqkWSOxX4v4BG61gVwWFp++U85C1/74WRMi0DOdLRERYz2I7bSeKy0/RBRT/4eVuDp53OBXnv85ZIfFda8b7w0ouGtPvffWHqYF7m9umDT8aOqLAgzKL/0RKh38Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alchfP4f2aqwlTcTGCQjjgQZIJ+cGaRx8CaLZ6IK0/k=;
 b=UsUlNXIU8Uq1lMiMCjbdcaEYM7zAyPeCQI+gTf0a+yDq59mYW3vHqAlJw6nwNXd67EULJSVef2Fld+svaAq2KsFRp+wE6dvPMW5CgZPxQ7EygsEjKs73X2WjLgz6eLhb4i16XmvH3OY4b4sN9Eut/u95K23tz4Kk6hHEW9/27wH3QABx4q+jTEjO4iU9vMmp2VU4yb4uOFC98hOVf2YkqL4cHcRWqVY26wio6yHo4B7mXPl2eZhrpH2NWD4bwruP3DB+sdvNkGWLqDpJ226HktD1nOongs622HqCFl5PHLmoU5yeOpIYUy1lYXhUzJusyOIOP7rw7HLmvoSuo5AHGA==
Received: from PH1PEPF000132F7.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::3c)
 by BL4PR12MB9508.namprd12.prod.outlook.com (2603:10b6:208:58e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Tue, 21 Oct
 2025 18:56:50 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2a01:111:f403:f90e::3) by PH1PEPF000132F7.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Tue,
 21 Oct 2025 18:56:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Tue, 21 Oct 2025 18:56:50 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Tue, 21 Oct
 2025 11:56:27 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Oct
 2025 11:56:27 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 21 Oct 2025 11:56:26 -0700
Date: Tue, 21 Oct 2025 11:56:24 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: Shameer Kolothum <skolothumtho@nvidia.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <shameerkolothum@gmail.com>
Subject: Re: [PATCH v4 11/27] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Message-ID: <aPfXWKE70OuumOQD@Asurada-Nvidia>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-12-skolothumtho@nvidia.com>
 <aPFx7Egdny+JCO9U@Asurada-Nvidia>
 <291fe8be-405e-4ea3-acfb-d090f6a7cd15@redhat.com>
 <aPZ4tcsMfN+2puGL@Asurada-Nvidia>
 <add07edd-3652-430d-b52c-cb2bdbc7f587@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <add07edd-3652-430d-b52c-cb2bdbc7f587@redhat.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|BL4PR12MB9508:EE_
X-MS-Office365-Filtering-Correlation-Id: f4a5e1b2-8686-4e08-7069-08de10d397df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|7416014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KuT/yxBx6F0tnGIQH1IqxMfMRh5RRaKnUWggEa0LT5WNZoyW3zOiXMhdBlk0?=
 =?us-ascii?Q?Tf3WBBekvucMJnui9TWnF9UwhZrACqcxCNBfO/EN6VgYug+wLlLL3YO7kJC4?=
 =?us-ascii?Q?Kq8tjWZ3FZmJGv2wNDKfshXUODMkHmQVlukEY5WlNsvInD7bykD8ABaeXeXl?=
 =?us-ascii?Q?+ci7xnztFT6e5hE16mvjWd8noHhUwveSzln/+kuY4hTztREdv+Zv/lBPbsFf?=
 =?us-ascii?Q?ULlGzrlSdvPRv/v8VFUGBHgGd6EJ+CO46d7Nq66NZfKzxxOukJIS7XunGUqV?=
 =?us-ascii?Q?+0Ih1VPGdMNXInmqrQpvYKZJ/0PLw54B/9oKod1mAgXxeKgwPIHj8jfEQujZ?=
 =?us-ascii?Q?hzvMsJ8mxCpqWyet3ikmj5sdVRmp71e0H2V9O6vEa/+oBj5goFV29K8Kah2L?=
 =?us-ascii?Q?D0KnJs0gT0om4q4O+nKkTxhrGCdO4zjVt0D+ClrcbYftrd5upk4K79nZYmBh?=
 =?us-ascii?Q?hqjDiR4KjuOo49XXUIrOei3nHSOsCd36t/ziij31AZnyH5fsw9HPxldPvMNO?=
 =?us-ascii?Q?7kcy3nvDRkcunnW2xkzWFEXRQ6CO7YBkOXl2Qo41iamFjd2Gj0akcPBcVkzR?=
 =?us-ascii?Q?kpr8by08XrKOn++9JaCMQ1qZ1fxmWDqkKJ+zbAfdPD52+62JKg2fgpBT6y6d?=
 =?us-ascii?Q?tFTyLuIGuJzMd67iqfT7Ds7BOaoeED4x/5ExaUX8l6mLu9JbGVlyVJNNXM/X?=
 =?us-ascii?Q?eocDsuhQ+ESkYbYzpjElFnl9+78PrSV6XM66U7w1uLoxFSqdG8L5cVb7FGY9?=
 =?us-ascii?Q?e5HatNQTheUiTcc4YoS4KEJgWLplgA9Dqjx7oWJbj0rKm2l6qkcYG/a0rYfg?=
 =?us-ascii?Q?48mHgTUkacT86vm5nT45Mkk/4jg+b8TZVW5YK5tEcdrl8hYPSBq6v1L/C1pJ?=
 =?us-ascii?Q?HVkPVMnT6w5sn2lomqdfBynzSha7wDKJCoNRHJG4X60i4/kmWnwXZQQqpgqf?=
 =?us-ascii?Q?BPFXSBzwt0SscJS6GO4aeM6VOZ6q2diuwymjZRlk8SUudzfsSbC9XzOAzzEG?=
 =?us-ascii?Q?USP5dSoHeI3vPdm09yfNq8UIXchdTimp7I/+hX50769exxSLuvcN16tU4kHP?=
 =?us-ascii?Q?Q92Kn7ielol1RdoJx8Pj2EKe7HdIUmrybJIVZIjS0FaqoNtil3IbrbrmHNOf?=
 =?us-ascii?Q?tHH3nznBW3fnoptqIr0wYM0mPkfIbFwx5tdJT019o2KK8zNqi4msJ3DlIPwB?=
 =?us-ascii?Q?vdxSlAacAlpZ7L0eCnIRKuvbSABvCfG322Kwjg2aDNueDWqqJU6KzE8Gz7YV?=
 =?us-ascii?Q?/mED80JZOn63iyY5qS9kpmaSa/8iWVPkqE825hymMDtMUta7YI8GOTGha9km?=
 =?us-ascii?Q?pogzrEa7Hy5eXfMzPU4QXdgBgWGbljCKomPGMS0em2dAYkCPEDXUdZ2sc4Xn?=
 =?us-ascii?Q?CUIksl1yePLTN6axHlzkIBE5ebHFyVMlfulLnIXIh+afTajXXRKzC9rZvHfM?=
 =?us-ascii?Q?PcMSBuyiF0FSQF1QuxFnIgdVxqiA16XeIOenpcquOcgp4JvmjmNjvxRTq8gI?=
 =?us-ascii?Q?8eWmstzJ9kpVNIJn6fjQED3PbahE0bM2xlnsgikOlRc2u2N7ZF+PxTTF+LPv?=
 =?us-ascii?Q?8iEqbLzsjEZZJAKkO5o=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 18:56:50.3901 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a5e1b2-8686-4e08-7069-08de10d397df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9508
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=nicolinc@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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

On Tue, Oct 21, 2025 at 06:26:39PM +0200, Eric Auger wrote:
> Hi Nicolin,
> 
> On 10/20/25 8:00 PM, Nicolin Chen wrote:
> > On Mon, Oct 20, 2025 at 06:14:33PM +0200, Eric Auger wrote:
> >>>> This will cause the device to be configured with wrong MSI doorbell
> >>>> address if it return the system address space.
> >>> I think it'd be nicer to elaborate why a wrong address will be returned:
> >>>
> >>> --------------------------------------------------------------------------
> >>> On ARM, a device behind an IOMMU requires translation for its MSI doorbell
> >>> address. When HW nested translation is enabled, the translation will also
> >>> happen in two stages: gIOVA => gPA => ITS page.
> >>>
> >>> In the accelerated SMMUv3 mode, both stages are translated by the HW. So,
> >>> get_address_space() returns the system address space for stage-2 mappings,
> >>> as the smmuv3-accel model doesn't involve in either stage.
> >> I don't understand "doesn't involve in either stage". This is still not
> >> obious to me that for an HW accelerated nested IOMMU get_address_space()
> >> shall return the system address space. I think this deserves to be
> >> explained and maybe documented along with the callback.
> > get_address_space() is used by pci_device_iommu_address_space(),
> > which is for attach or translation.
> >
> > In QEMU, we have an "iommu" type of memory region, to represent
> > the address space providing the stage-1 translation.
> >
> > In accel case excluding MSI, there is no need of "emulated iommu
> > translation" since HW/host SMMU takes care of both stages. Thus,
> > the system address is returned for get_address_space(), to avoid
> > stage-1 translation and to also allow VFIO devices to attach to
> > the system address space that the VFIO core will monitor to take
> > care of stage-2 mappings.

> but in general if you set as output 'as' the system_address_memory it
> rather means you have no translation in place. This is what I am not
> convinced about.

You mean you are not convinced about "no translation"?

> you say it aims at
> - avoiding stage-1 translation - allow VFIO devices to attach to the
> system address space that the VFIO core will monitor to take care of
> stage-2 mappings. Can you achieve the same goals with a proper address
> space?

Would you please define "proper"?

The disagreement is seemingly about using system address space or
even address_space_memory, IIUIC.

To our purpose here, so long as the vfio core can setup a proper
listener to monitor the guest physical address space, we are fine
with any alternative.

The system address space just seems to be the simplest one. FWIW,
kvm_arch_fixup_msi_route() also checks in the beginning:
    if (as == &address_space_memory)

So, returning @address_space_memory seems to be straightforward?

I think I also need some education to understand why do we need
an indirect address space that eventually will be routed back to
address_space_memory?

Thanks
Nicolin

