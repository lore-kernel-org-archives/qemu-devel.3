Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9006C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 21:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts6uC-0005f2-H7; Tue, 11 Mar 2025 17:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ts6uB-0005el-DS; Tue, 11 Mar 2025 17:12:51 -0400
Received: from mail-bn7nam10on2050.outbound.protection.outlook.com
 ([40.107.92.50] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ts6u9-0003xc-CA; Tue, 11 Mar 2025 17:12:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIse3AfLpVdS1DOue5iuVVIInbOnjirg05ASh+3XF0eL/PzoUei4TCGaSPVPGj9yf2tiVcOO9V1S9rJgo7VRk7ifgXY794GCGjbl1FQscEf4mlT43SsOHmAcx+KmJqYNa8yXMsjHWeP8UwP5L7DJutn3zWqIJ6LwvBxKaGk5rOop0GS9aYsw395bFOBixBuX6FNNxNGuN/3u1QGkG5GNimMAxa2Ns0g7UT9PMOgYjxS0/p729Qxy6ndRwibjJqonWZdl5ayYLRChXBsMk7AjdoGTqroOM12Tmz4abZMrKNA4voandfiX59iQnEEsMqyn8sbh/Tu8RlMlf5t5kDRh6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laSnnasma7ieU95DmbBZWO3wzHd8E32IJI1v4/l2P34=;
 b=GR1P/8SZXaz8zGH4uj6uyXz+cEzCtrZQBQCq3IVxEdI/PpgYALHQ9LrJqTp1z7rT6nsZZsUFAn4dfpWPMy8VCRdJMdeb0p65Ojqv6Z+kij/00MyTkhxsAf954AzScPMZ/rHKWMbvY7om14uY3BkdXOPeBSaucE/Kt26lMw/7MYUeOodFZztS7wde4sUKl2KbfstEiZJdooL3z5BJqbYTAtTxrvJmNBDFjg3dM5opgaBspGHjwGJZmigmfhWAYFlA5SOB/A4YlFFfAM0ERLwQKSKApADJybvcIdlH0RBVkQRFlxCSjcbOQXQgSSXpb6xtOiHjS1pH74EK1y6NbJw18g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laSnnasma7ieU95DmbBZWO3wzHd8E32IJI1v4/l2P34=;
 b=UTeuMweTUOZo8LgftPrH04IeYFNKoGG30GFgy0LaCfzhVPV4mxp6ckReU0daQHNjRsPSA2Ac1vIEGppo3Xj09odxxKMWyD8ClSF3GZ4FC/P6Ks6+anBtw/EaK/go6fMcZEXxIOlEIeXfF5sC7H9j/FbDTWIU8Gm/OReffJR9gvNxp+HwLMSTm3Ybs2AJJvve1QFU7BwCLEcz5mtgZ2PHIN/fjJ0hP1ckQTodzkmTa1YWmiNoxIb0x1sPDtyRaEmeCqx0W6Cfwi+kM0SXPxmjchmXB33zEiHrpRXCNqwh+FZPlkaDJCBLDqAUtjTnJw4kWFJZ8rDmOGfHAI5OyPALXw==
Received: from CH5P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::20)
 by SA1PR12MB7174.namprd12.prod.outlook.com (2603:10b6:806:2b1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 21:07:43 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::3e) by CH5P223CA0011.outlook.office365.com
 (2603:10b6:610:1f3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Tue,
 11 Mar 2025 21:07:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 21:07:43 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Mar
 2025 14:07:34 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 11 Mar 2025 14:07:33 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 11 Mar 2025 14:07:32 -0700
Date: Tue, 11 Mar 2025 14:07:31 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH v2 09/20] hw/arm/smmuv3-accel: Add
 set/unset_iommu_device callback
Message-ID: <Z9CmE2oc55lxzW+q@Asurada-Nvidia>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-10-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250311141045.66620-10-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|SA1PR12MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: 65f77e47-4663-4c54-2a0b-08dd60e0c3f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9chRWKVubos5x0KP/UeysWLkm74E0f7psXyZsrvqMjvEvQvCA1KBmv7NFZWE?=
 =?us-ascii?Q?wyhVBQOLDzfN+2eV77Z+z1cErzxPeDGBbdAzAIL36czWx7/ytg0bwHaxrOyQ?=
 =?us-ascii?Q?QobGjh4F8uywT2DEC7txso4Ewy5OW4yHcy/FPYK3g8M6GhhL2HTum2ia0LUq?=
 =?us-ascii?Q?o2g8czRRMpE8AztBFvMt/8pkGJbtNN8i2pix725hJxKxsyNr4MA3bA1Wf6TV?=
 =?us-ascii?Q?dXIzXt07ujtvhydaNKsNykLmsNl08+r1xplyi5ccgd6w2TuwKLtOadWuXnKv?=
 =?us-ascii?Q?FicdopSbmKspXrN0ObUWtSFYKnG3N2Q/Z++nXGBYqzP1QpFWYkLlp3cywWjV?=
 =?us-ascii?Q?MtWYlykubMmEs9Omxhi5E4kr6hpAQ4qNm/O/CGFZYHU/rt9KMK5SjPnFQrY5?=
 =?us-ascii?Q?FRlaKku0pr0UCvG3AQobWU1SIeMTbgA+8WSSSbNpOZPsnbweLLSDFKGh2QYp?=
 =?us-ascii?Q?H3oPCli1y0ss/XnUDpklO3P00PU/7jeMW8wqtc9WsHuRQMRyNLehqvXQXV8N?=
 =?us-ascii?Q?FBDdYMm6Itoo8cjWeXYKzLDjzXZjnXbUvnIEYRh7893eCfSwSPI34tnfrm8Z?=
 =?us-ascii?Q?M9zSasZ1sgyYzCPXLCrPvrQwTx2rnhEED93Ss7yug07eRfWROwG16BfB7LHT?=
 =?us-ascii?Q?Ps+EOjy+ukrqdIbdpWXjfRrGdQ5zVv7nXGDsFNTqH6zuh8nXnasecb3XK3PW?=
 =?us-ascii?Q?tEp8yHsRsdzOdDonlrMer0KkdwTE0NmNBkaCfm/84zKiLNn0YWrQ0dCTxccT?=
 =?us-ascii?Q?PrrzN7igEq8j772EqexZpandbu2Mhw4zg/MRaWqnwbY20ZVVKm5qfrRTB1s5?=
 =?us-ascii?Q?XrddSSwgQA0OPl1pTNJ8VIe8qFEeKEgQe4SyDAxYxNegOcX0jaqh6q53HmhJ?=
 =?us-ascii?Q?fEJtu4EYTYkQT0fTGYFYwae7nOrAhNwJSVhJUsSRAuUs502KzziKboQ2UVHg?=
 =?us-ascii?Q?51RnC7QNeflTSZw0PlR77M83nfNF/fGx1772MbqUa65ukcNwqz5sWvRUmA4p?=
 =?us-ascii?Q?1QlU/+EPk9o1Pw8O94GSvSYHTpk8oEBFhKvRCne7C2FiKXCS8EnioO0QDfRe?=
 =?us-ascii?Q?6jdd7heDA6aS1BUMvtxMlFRfTe1JLhBjQj1uI6SuYPqGojTZMUd8ADVi0pl9?=
 =?us-ascii?Q?4dklKoSnRAoUBRKELuj/5DcpFBeKpt+WeESTQUDTKS3D3rK7s1Os2TRIIVoP?=
 =?us-ascii?Q?R42jtUCKlHkwhV++nzvrFgqo8lznUT/KFK62wX8oS8YyOyhm8Xs2aQA8728Q?=
 =?us-ascii?Q?UQeqONn+hfiD69uHREz32pn4LY4YW5n+vf92FD87JFseS8Ca5H9dZu1PXvuF?=
 =?us-ascii?Q?laU5J7Vw9roXBVffRmeF31MKHDJQizWaE/Utl3c5eMfdgSoIPQ9XxRFYPkkh?=
 =?us-ascii?Q?6YylMVffHSW1fUn4em+rXpHb1KJCagemYSfyHuPWNx6WY4qRa6sZsns+QeIP?=
 =?us-ascii?Q?NGVZOsNbD5vMFzkZTEy2POtf0dljyidQtZPqTxnfbWqvHL044R/MUnocg0Zg?=
 =?us-ascii?Q?3ONdGoFFN6aD7Lw=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 21:07:43.1743 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f77e47-4663-4c54-2a0b-08dd60e0c3f9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7174
Received-SPF: softfail client-ip=40.107.92.50;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Mar 11, 2025 at 02:10:34PM +0000, Shameer Kolothum wrote:
> @@ -30,6 +32,185 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *s, SMMUPciBus *sbus,
>      return accel_dev;
>  }
>  
> +static bool
> +smmuv3_accel_dev_attach_viommu(SMMUv3AccelDevice *accel_dev,
> +                               HostIOMMUDeviceIOMMUFD *idev, Error **errp)

With vEVENTQ v9, vDEVICE (vSID) is required to attach a device
to a proxy NESTED hwpt (applicable to bypass/abort HWPTs too).
So, host_iommu_device_iommufd_attach_hwpt() would fail in this
function because vSID isn't ready at this stage. So all those
calls should be moved out of the function, then this should be
likely "smmuv3_accel_dev_alloc_viommu"?

That being said, I don't know when QEMU actually prepare a BDF
number for a vfio-pci device. The only place that I see it is
ready is at guest-level SMMU installing the Stream Table, i.e.
in smmuv3_accel_install_nested_ste().

> +{
> +    struct iommu_hwpt_arm_smmuv3 bypass_data = {
> +        .ste = { 0x9ULL, 0x0ULL },
> +    };
> +    struct iommu_hwpt_arm_smmuv3 abort_data = {
> +        .ste = { 0x1ULL, 0x0ULL },
> +    };
> +    SMMUDevice *sdev = &accel_dev->sdev;
> +    SMMUState *s = sdev->smmu;
> +    SMMUv3AccelState *s_accel = ARM_SMMUV3_ACCEL(s);
> +    SMMUS2Hwpt *s2_hwpt;
> +    SMMUViommu *viommu;
> +    uint32_t s2_hwpt_id;
> +    uint32_t viommu_id;
> +
> +    if (s_accel->viommu) {
> +        accel_dev->viommu = s_accel->viommu;
> +        return host_iommu_device_iommufd_attach_hwpt(
> +                       idev, s_accel->viommu->s2_hwpt->hwpt_id, errp);

Yea, here is my bad. We shouldn't attach a device to s2_hwpt,
since eventually s2_hwpt would be a shared hwpt across SMMUs.

> +    /* Attach to S2 for MSI cookie */
> +    if (!host_iommu_device_iommufd_attach_hwpt(idev, s2_hwpt_id, errp)) {
> +        goto free_s2_hwpt;
> +    }

With the merged sw_msi series, we don't need this anymore.

> +    /*
> +     * Attach the bypass STE which means S1 bypass and S2 translate.
> +     * This is to make sure that the vIOMMU object is now associated
> +     * with the device and has this STE installed in the host SMMUV3.
> +     */
> +    if (!host_iommu_device_iommufd_attach_hwpt(
> +                idev, viommu->bypass_hwpt_id, errp)) {
> +        error_report("failed to attach the bypass pagetable");
> +        goto free_bypass_hwpt;
> +    }

Ditto. We have to postpone this until vdevice is allocated.

> +static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
> +                                            int devfn)
> +{
> +    SMMUDevice *sdev;
> +    SMMUv3AccelDevice *accel_dev;
> +    SMMUViommu *viommu;
> +    SMMUState *s = opaque;
> +    SMMUv3AccelState *s_accel = ARM_SMMUV3_ACCEL(s);
> +    SMMUPciBus *sbus = g_hash_table_lookup(s->smmu_pcibus_by_busptr, bus);
> +
> +    if (!sbus) {
> +        return;
> +    }
> +
> +    sdev = sbus->pbdev[devfn];
> +    if (!sdev) {
> +        return;
> +    }
> +
> +    accel_dev = container_of(sdev, SMMUv3AccelDevice, sdev);
> +    if (!host_iommu_device_iommufd_attach_hwpt(accel_dev->idev,
> +                                               accel_dev->idev->ioas_id,
> +                                               NULL)) {
> +        error_report("Unable to attach dev to the default HW pagetable");
> +    }
> +
> +

Could drop the extra line.

Thanks
Nicolin

