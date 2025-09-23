Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA05CAC5A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 18:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v188D-0000f2-BF; Tue, 23 Sep 2025 14:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1v188A-0000et-VO
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 14:52:51 -0400
Received: from mail-eastus2azon11010007.outbound.protection.outlook.com
 ([52.101.56.7] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1v1887-0003P4-Aj
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 14:52:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wViOlmOnmU1rgKYM5IBp0o16X1iZgSkmPN2azuvzGvpQ27IiixtW+zWKaVOdBTQjR6v+OppyQVoJ/aC5C0J6ZW91Enr8/3XvMHpc5j6MjPG8E+5QTLh3nJ/gUxyxKsv97OClRoLbScAWe0RSOMUZqg2cCr6kCry+sZBlNjrvZT0ralWXXmFNesNnx8Ud7CnJEywO0gKSsyIO7ouJW95ctAUa4Ec5l0SEAxrnrxFlwgYIQDS1Z2pc/WcOKnZB/9iTh4/dzObbNVMkAGkar7dieZ20N5uGv2JfCajsxitckdur1A6nGYXL3zlHVG+6RggJfelE0mfG05Gtjdqz2jN0Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biTBG7TtbjrlNAO8UJLEWCSmiwdLJFuNpJ4Pm7AbJWc=;
 b=HonGbTbksdF393cBSjgVoiJ5Om9TNAhn9Ez+3FBK2cY164Y6TSmlfMv3f8o2b1BN6NXgxXhTzymW5ck57RMnN+xA3U5qGN7QANtp/K9u4Kk+syMeNivagk3jrF18LgvsPJRojGpl5KEvUdYlndnmLUvcU9VgZSIJAXa4LiBFCEIEEsz11itvnJaXCqqcyOBXgEMrfCIfehkcMSyB3d2StbrJFjhysPZFJhfLOyUkt883ds1qCdUiTmYW2Ku0lJi6gCJFyYQSbNJSHn74ArLGyx2zwV1aIDZt8uu6vOpGQPs0tRVg7rKoiBMxtYMhmHelBgQ+2wtobwlSZgzm8b+3uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biTBG7TtbjrlNAO8UJLEWCSmiwdLJFuNpJ4Pm7AbJWc=;
 b=D4kNlcTK9Qv+MctWCoasaZxDoKKsMW8tYfbOGnoZc4M8hCVdl6UFOeFIIlLuGC8ohyKyAPp1//XyJQqpk9VWEMtExVojDm3soIiMRY60gtNjHf9ZRaUcXfXu42uXWtKs2HZduZPeFwP6YP/dbSWzf717azR7aut/hPDsDAZChJVN8/getZEYznKsMY7obXXSySaxZ1pXe7C/JmTXoeysBOa8UEsv1qzdsc2ATQOxYR91ByqUmDscQ6eaGdV4cy+PoDoG/MgHINcezcM9fwR8+MI2RiXBf1EnvFnRhAbinqOcnFlzvOjo3gkdNpfVz7DYm8epXEC85rLkalc+tWyNEQ==
Received: from SA0PR11CA0197.namprd11.prod.outlook.com (2603:10b6:806:1bc::22)
 by MN2PR12MB4375.namprd12.prod.outlook.com (2603:10b6:208:24f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 18:47:39 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:1bc:cafe::b8) by SA0PR11CA0197.outlook.office365.com
 (2603:10b6:806:1bc::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 18:47:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 18:47:38 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Tue, 23 Sep
 2025 11:47:23 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 23 Sep
 2025 11:47:23 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 23 Sep 2025 11:47:22 -0700
Date: Tue, 23 Sep 2025 11:47:20 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
CC: <qemu-devel@nongnu.org>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <eric.auger@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
 <peterx@redhat.com>, <ddutile@redhat.com>, <jgg@nvidia.com>,
 <skolothumtho@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <yi.l.liu@intel.com>, <chao.p.peng@intel.com>
Subject: Re: [PATCH v6 05/22] hw/pci: Introduce pci_device_get_viommu_flags()
Message-ID: <aNLrOIbBxZy00cS4@Asurada-Nvidia>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-6-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250918085803.796942-6-zhenzhong.duan@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|MN2PR12MB4375:EE_
X-MS-Office365-Filtering-Correlation-Id: f2093e82-a8f6-4e29-c4be-08ddfad1aba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y6GOWr2TgnOB09bt7SC1n/Qsun+j8aAPrqdpM+32htE+P70Xt9zN4Q3pCFvq?=
 =?us-ascii?Q?DtZkXmr6pUOnnWSzb3WdVURMB9upSKjo3GhtSwrvdOsSdRM8XvgbFRuWBxNg?=
 =?us-ascii?Q?u2Bb1HE6G1X2ov18dPd+Q9eUoPKcCJX4USEJF5Xft/4MQrLs8P2YERLEHLxJ?=
 =?us-ascii?Q?TdZHwKrTS5sqv+GwCOoRF7Zg1NkljU0XBoHmE/QxFcDR48eJRnoN7tYS/ozk?=
 =?us-ascii?Q?LB86lQyR9NtXWZ8GATOnpU2Fr9TnCMmkBbd6lr1QvQscMmspHayvb09yjfvp?=
 =?us-ascii?Q?+l19seor1rcEJAiJaNYRyVO/pA1fef5shXBHtLxirtonZRAPyCDXq2cIu7En?=
 =?us-ascii?Q?VJue7SzeDt5Loiof6srMKlkm1MVK4vr1AkfWD6LrJz6YTJpTnWlgxg4xMjKk?=
 =?us-ascii?Q?oI8XHqmCtK4H0YJxiuZe7xNriVVc3z7yoe4yHbX7zODZxWjU4uwDpM9avmVA?=
 =?us-ascii?Q?nx02XDmA4EVnt2O0210x/Q7FGeMt4r5JMLVg93HPVPhTL0QijjBu8GNuy6Fa?=
 =?us-ascii?Q?01v3x/kTYNq2INzePOWubP4vjm/7ijjyLWlfDXlI3KtpI5whxayGb/8f7WfH?=
 =?us-ascii?Q?o3yJ3b4YHJIa54ZYla0DYNLrLpcz56YFpzBQ4/mm5djNj6H0skumeRXruYf1?=
 =?us-ascii?Q?qQ7bjQM/mr2aushrj70JzH3INEqSEAEpMlfY6XnxVN970T63R5uQg03QD9cg?=
 =?us-ascii?Q?AV2WKHoGzEoFXao1C1Pdmf4yEdP2guehsnLazdmjqj/i3rJ2AYX+Dg3MJA/1?=
 =?us-ascii?Q?P6IWAwuS8ZYEcBfPcjs7jpUXuuvzdGgWt/Ypz5wHMllm2aZQLxzJBUX0LwyS?=
 =?us-ascii?Q?UUiTAWnNOTVaXSnDuK+wdIEXyBzJfN2m/2FeZtyGidrMqucJ5FjG3G4uDTuC?=
 =?us-ascii?Q?LME7M18RvRkGcjMqCi156uegBlNBGrsnG821HtdXqQskMKoR6xNMn5dp/7pg?=
 =?us-ascii?Q?gHHo5Se/dJpCBW8TLNKxJXDvh+IeVopDU0DBukRsFEVTwgvsS+GT/rBEIQ8U?=
 =?us-ascii?Q?USACAYNCvf5XeV+ujbt51ExVHtHa78ls6Dr+9YeibwN3M28QFIbyK6IyD8ZH?=
 =?us-ascii?Q?FMHlbqwJrv2CsvrIqEqTSp1YY6iO//TsZpzwauY2CoSF3qV93zOgzjOQHMbP?=
 =?us-ascii?Q?9iRyjKDM9CatQInWGkykYhwQVnv5d9ufD9nJxEg4FD2oCycsN9hmSSjXXd/E?=
 =?us-ascii?Q?1gcvA1jSvO6ee3fXDdpPPXgHtBqDeRz95FxpsVq5RPq1ViaSG/NnLCAq5pUh?=
 =?us-ascii?Q?OHPzWD73Ndtl1L+ShYWweXSpuEvQoX/AkZJbht/L0TySLbYUjNcuoh3scwOo?=
 =?us-ascii?Q?fXTF/qp1/pkugdovyou1YTuq7cVOmtL9buEmsf3qPOqzuD38dmfSVS7OD4mg?=
 =?us-ascii?Q?tYgw7js+PQ0m73JbXeZpKREAnTd1G/VJ74svT+jepMk7bHLwcvrNxCMDw9B9?=
 =?us-ascii?Q?31oX+hOgsN2QhJ4LDPH9Pjml5BDYuj7jW7v/73v5nd1A8LBb87nr/Ov+kbMj?=
 =?us-ascii?Q?hTvtgBphYI4SyV+6Iif1Yl5bdxWTg2VVIW7J?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 18:47:38.9731 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2093e82-a8f6-4e29-c4be-08ddfad1aba4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4375
Received-SPF: permerror client-ip=52.101.56.7;
 envelope-from=nicolinc@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On Thu, Sep 18, 2025 at 04:57:44AM -0400, Zhenzhong Duan wrote:
> Introduce a new PCIIOMMUOps optional callback, get_viommu_flags() which
> allows to retrieve flags exposed by a vIOMMU. The first planned vIOMMU
> device flag is VIOMMU_FLAG_WANT_NESTING_PARENT that advertises the
> support of HW nested stage translation scheme and wants other sub-system
> like VFIO's cooperation to create nesting parent HWPT.
> 
> pci_device_get_viommu_flags() is a wrapper that can be called on a PCI
> device potentially protected by a vIOMMU.
> 
> get_viommu_flags() is designed to return 64bit bitmap of purely vIOMMU
> flags which are only determined by user's configuration, no host
> capabilities involved. Reasons are:
> 
> 1. host may has heterogeneous IOMMUs, each with different capabilities
> 2. this is migration friendly, return value is consistent between source
>    and target.
> 3. host IOMMU capabilities are passed to vIOMMU through set_iommu_device()
>    interface which have to be after attach_device(), when get_viommu_flags()
>    is called in attach_device(), there is no way for vIOMMU to get host
>    IOMMU capabilities yet, so only pure vIOMMU flags can be returned.

"no way" sounds too strong..

There is an iommufd_backend_get_device_info() call there. So, we
could have passed the host IOMMU capabilities to a vIOMMU. Just,
we chose not to (assuming for migration reason?).

>    See below sequence:
> 
>      vfio_device_attach():
>          iommufd_cdev_attach():
>              pci_device_get_viommu_flags() for HW nesting cap
>              create a nesting parent HWPT
>              attach device to the HWPT
>              vfio_device_hiod_create_and_realize() creating hiod
>      ...
>      pci_device_set_iommu_device(hiod)
> 
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Despite some nits, patch looks good to me:

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

> +enum {
> +    /* Nesting parent HWPT will be reused by vIOMMU to create nested HWPT */
> +     VIOMMU_FLAG_WANT_NESTING_PARENT = BIT_ULL(0),
> +};

How about adding a name and move the note here:

/*
 * Theoretical vIOMMU flags. Only determined by the vIOMMU device properties and
 * independent on the actual host IOMMU capabilities they may depend on.
 */
enum viommu_flags {
	...
};

> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index bde9dca8e2..c54f2b53ae 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -462,6 +462,23 @@ typedef struct PCIIOMMUOps {
>       * @devfn: device and function number of the PCI device.
>       */
>      void (*unset_iommu_device)(PCIBus *bus, void *opaque, int devfn);
> +    /**
> +     * @get_viommu_flags: get vIOMMU flags
> +     *
> +     * Optional callback, if not implemented, then vIOMMU doesn't support
> +     * exposing flags to other sub-system, e.g., VFIO. Each flag can be
> +     * an expectation or request to other sub-system or just a pure vIOMMU
> +     * capability. vIOMMU can choose which flags to expose.

The 2nd statement is somewhat redundant. Perhaps we could squash
it into the notes at enum viommu_flags above, if we really need.

> +     *
> +     * @opaque: the data passed to pci_setup_iommu().
> +     *
> +     * Returns: 64bit bitmap with each bit represents a flag that vIOMMU
> +     * wants to expose. See VIOMMU_FLAG_* in include/hw/iommu.h for all
> +     * possible flags currently used. These flags are theoretical which
> +     * are only determined by vIOMMU device properties and independent on
> +     * the actual host capabilities they may depend on.
> +     */
> +    uint64_t (*get_viommu_flags)(void *opaque);

With the notes above, we could simplify this:

     * Returns: bitmap with each representing a vIOMMU flag defined in
     * enum viommu_flags

> +/**
> + * pci_device_get_viommu_flags: get vIOMMU flags.
> + *
> + * Returns a 64bit bitmap with each bit represents a vIOMMU exposed
> + * flags, 0 if vIOMMU doesn't support that.
> + *
> + * @dev: PCI device pointer.
> + */
> +uint64_t pci_device_get_viommu_flags(PCIDevice *dev);
 
and could make this aligned too:

     * Returns: bitmap with each representing a vIOMMU flag defined in
     * enum viommu_flags. Or 0 if vIOMMU doesn't report any.

Nicolin

