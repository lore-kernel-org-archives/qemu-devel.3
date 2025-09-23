Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6CBCAC5A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 19:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v18xP-0005NV-RE; Tue, 23 Sep 2025 15:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1v18xL-0005Mh-6W
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 15:45:43 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1v18xI-0001nL-Js
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 15:45:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fiKwq1E66Q5p/xQNjuqx8vM7oA33NfXJVG0/rRLQ6kKHx4pf4gj6gnf0zOCsdJOTE0qha/2u1mLIsYNqUDiT3YVlDTyRsuoURvYrowrNGqcrrnH+qOaXROCi+4HGZScDlh+2qesZVqrjU+aR7bmWZhFdmlAZ28ouheOFduCThnChIEJ4YbJ67FagcgNLwllk6SrA/LVO9WgCdvqjJeZQh0TyvYybL1GyMwCSXcpEeMThdY3ufNCiyRDV7/sW+bkBCrdLEI5X6SbJAWeROhMQ8JL8rdLB/0yn/ABvbn38jb7B4HhRrAU2CWvqbQABRauP0lipH8MwTMhlNknisuDtyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qAmKXCxanJx/iP2sHA0j/FdddQEUBeY83XjmW/H9lY=;
 b=EYpq0QtHE13pfuFIenHthFrtBuAhnjZY9X8YyvydTVHCDXGCg+AP4dCRSekfgJOo5WVvGK2dRTSttigY5Owf9tpoFMv3bPxL2NJgoDjhwcJJ76ALYDet0gEAkDrK40ryBe4uEFuk9LnGDIf6crhrCXbpSpbHX5g4obX9rxhx3bDKD9iW4cCDTPkL5kxcGJnRhog3Vwl5aDPogu3pV55gQO8n8pV0NCCXR+UIOcFNhmiMrW3AyZjY098GdgIW6Ob2BiTd1guZXZ752iPEXG/sO99jPhjh5wH5zO5szpoM5+tpEYY45TdymGaMnElp7BE8EttHieDXGqdgu0l9KZw31A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qAmKXCxanJx/iP2sHA0j/FdddQEUBeY83XjmW/H9lY=;
 b=GzHP7O74Nz7sa8ZARg7BqG+0ZVB3PUjG/3eww3Fw0RawFDoRKxPWNhhEPRzod5ufjX7zpfurFG/hHtG0u7rVEJScKhDlVZXz3qhcDyMjf1nTozH6ytqym7WNgRvNaRfCpSkAgAfPek/GGImzrRu8Y8Yn/nVD6LcM2xwG/T0Xd4Ebe1FBjoMpP6K6RHB82j+TXgr/xS+XFw+2P1Fj/Yjidtb1wNm1fkRJUYyYKReYNQNMpMz+Ol/G19P5wn8RrktrpmpzGZEqNLrZxvf91jZhMXGQ4+tnqR1bmIzSsOFegAITBd9VflMkSFT23Cdcql2mjKrq/PaHUrbH2k30kr42xw==
Received: from SN4PR0501CA0047.namprd05.prod.outlook.com
 (2603:10b6:803:41::24) by DS0PR12MB7557.namprd12.prod.outlook.com
 (2603:10b6:8:130::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 19:45:33 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:803:41:cafe::b0) by SN4PR0501CA0047.outlook.office365.com
 (2603:10b6:803:41::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 19:45:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 19:45:32 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 23 Sep
 2025 12:45:20 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 23 Sep 2025 12:45:20 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 12:45:19 -0700
Date: Tue, 23 Sep 2025 12:45:18 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
CC: <qemu-devel@nongnu.org>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <eric.auger@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
 <peterx@redhat.com>, <ddutile@redhat.com>, <jgg@nvidia.com>,
 <skolothumtho@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <yi.l.liu@intel.com>, <chao.p.peng@intel.com>
Subject: Re: [PATCH v6 18/22] iommufd: Introduce a helper function to extract
 vendor capabilities
Message-ID: <aNL4zruHP8P8ExrM@Asurada-Nvidia>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-19-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250918085803.796942-19-zhenzhong.duan@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|DS0PR12MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f0e6f22-608b-42d6-3108-08ddfad9c22c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?94b4t5CZUisCO3Ao8yT4oiccPDmsCcXNDJSM5wV6SdqggTD2Uy0Y0gN2RHZg?=
 =?us-ascii?Q?JXhRV9h/OizESMYqy+DX7rI0NdHrZiE6uaFGOTGRsr6Wn4e90/JjFwoiE1LZ?=
 =?us-ascii?Q?7Oiio5ec97XMk7FhcOsgoJXrfu32dqtfr96zUDMf69vN8+w/uRygz5jWDNiQ?=
 =?us-ascii?Q?PhXXpSm3QJKimvX8H5yGNcY1pZXTVsWAFvC7QG22rpF4sFR2mAeaF2zcCMWN?=
 =?us-ascii?Q?VLsq72/m7NrBDXyza3ZuyEM/jy4Uy/jnqLjCqOK5xBZUVl/V5c+m7R5UX7FK?=
 =?us-ascii?Q?3YSvF4+6jnxelMIfBcru9XOKnXBQ3/bH//+4G7Gd7ODqHrIYrXE+k5CotOi5?=
 =?us-ascii?Q?TGiu0J+uz2bObMav9HiIdM3rQCTt942XPJYHdXDsAs39u0O4CbBYZi7ybT0c?=
 =?us-ascii?Q?3di7faxxI/+8tIPlMZJ1HwEoxylaD81ibOPRdePFK/1JeEt//QdLW0OWMo1q?=
 =?us-ascii?Q?ihEMVTXXtGNQgTOy+hc9UWkjwudUCdlcrzOm5pPdn4WqRJcTnX+Ywtx18fYm?=
 =?us-ascii?Q?0snieHK+kzvZh9aGT1/PAAcnkAiuDM+TL0Xfse02cO+zZ+h/bKHOXj0+b5dY?=
 =?us-ascii?Q?BeyR1mOv0RRWkVxEFHFX/lqJ6YGHTf4zTyItyPcdccLOkxTvVQy5TA9YecNl?=
 =?us-ascii?Q?vvwJrmGQo6jzeDWcMW3agJ1TBp/t/Gl7IruNWEa3fxLa9v6fvwlLqs9XY7QB?=
 =?us-ascii?Q?NSG0P+e20+tqYHJSk//ZyBT07XG7doFjA/UkKmnonsIVgAaZF8nTJ7BsOWbH?=
 =?us-ascii?Q?1DsFFOBmkwH6ZH8o2xIsdjOChQTTVSGIrNWYy5D0xwiMz9oJ32ZeYB3BD1Id?=
 =?us-ascii?Q?/27ts2G4CTyEuGMi6wepAJhvfKDXQBz+sLZsF1nwVJx1/mgaXHgaeTZjmnq6?=
 =?us-ascii?Q?VT1eNvgpzN07K/8jb8Kh6jROX8CToLKnIX8Ujr3aZ0/vDl1AdvjlkvLRiV4G?=
 =?us-ascii?Q?k69h4+4SmMtQAHqWCtqM9T+W+jzWPARkVl7aHxIqniy1speLB/YxuzRe9fAR?=
 =?us-ascii?Q?B+qUSnJI/aucfNYWjcKu0lvo3YqvIExlnQma3iECe+hG4B/a5KKEptV4S1y4?=
 =?us-ascii?Q?+0149ZJXWUr6I0IeaTqs3Iai1ZsZ98sYrF2Ob/6/WWxqNI+VQ7/iqd2+rLOb?=
 =?us-ascii?Q?2YEjXQqufCBElfcit12Vy6M/OWplIgrpMLQZFMiUJ20ToX2IaFVsLxaEi03w?=
 =?us-ascii?Q?7XP47CWUGvUCnBFm6iJj34b/A7mhF+HQqrNs7NojU6xiFshJE7VNNzjQWyPQ?=
 =?us-ascii?Q?LChFfnFrMYHwp+phVnfgw4zhBmOBcVpATE883IpLIkFIjRVQxf/V6d2MyHa7?=
 =?us-ascii?Q?/fpB+BGRkxy/LwmuWz1PF+1JrfT0LVUj3VKRfGdiiD3lrVNBUIyoMkNAIMRa?=
 =?us-ascii?Q?X7HMrs1HbIE3JGHT1Z9ewvrPm87CaAOE9zt7j5XkpTN9W67ApcgRWNbhWK+h?=
 =?us-ascii?Q?4AymkHtxiX343SmVP5K4cLHEcXz7Z3NY7KpBcpTFl1p4xkZfL4lUXnlD3s/g?=
 =?us-ascii?Q?GpZxVUs3PEPgW2Fhulg9JN8dRiJfeUv5HY/F?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 19:45:32.7750 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0e6f22-608b-42d6-3108-08ddfad9c22c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7557
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=nicolinc@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

On Thu, Sep 18, 2025 at 04:57:57AM -0400, Zhenzhong Duan wrote:
> In VFIO core, we call iommufd_backend_get_device_info() to return vendor
> specific hardware information data, but it's not good to extract this raw
> data in VFIO core.
> 
> Introduce host_iommu_extract_vendor_caps() to help extracting the raw
> data and return a bitmap in iommufd.c because it's the place defining
> iommufd_backend_get_device_info().
> 
> The other choice is to put vendor data extracting code in vendor vIOMMU
> emulation file, but that will make those files mixed with vIOMMU
> emulation and host IOMMU extracting code, also need a new callback in
> PCIIOMMUOps. So we choose a simpler way as above.
> 
> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

With some nits:

> +enum {
> +    /* Nesting parent HWPT shouldn't have readonly mapping, due to errata */
> +     IOMMU_HW_NESTING_PARENT_BYPASS_RO = BIT_ULL(0),
> +};

I would put a name here too. And given this is defined generically:

/* Host IOMMU quirks. Extracted from host IOMMU capabilities */
enum host_iommu_quirks {
	HOST_IOMMU_QUIRK_NESTING_PARENT_BYPASS_RO = BIT_ULL(0),
};

> +/**
> + * host_iommu_extract_vendor_caps: Extract vendor capabilities

Then:

 * host_iommu_extract_quirks: Extract host IOMMU quirks

> + * This function converts @type specific hardware information data
> + * into a standard bitmap format.
> + *
> + * @type: IOMMU Hardware Info Types
> + *
> + * @VendorCaps: IOMMU @type specific hardware information data
> + *
> + * Returns: 64bit bitmap with each bit represents a capability of host
> + * IOMMU that we want to expose. See IOMMU_HW_* in include/hw/iommu.h
> + * for all possible capabilities currently exposed.

And simplify this:

 * Returns: bitmap with each representing a host IOMMU quirk defined in
 * enum host_iommu_quirks

> +uint64_t host_iommu_extract_vendor_caps(uint32_t type, VendorCaps *caps)
> +{
> +    uint64_t vendor_caps = 0;
> +
> +    if (type == IOMMU_HW_INFO_TYPE_INTEL_VTD &&
> +        caps->vtd.flags & IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17) {
> +        vendor_caps |= IOMMU_HW_NESTING_PARENT_BYPASS_RO;
> +    }
> +
> +    return vendor_caps;
> +}

uint64_t host_iommu_extract_quirks(enum iommu_hw_info_type, VendorCaps *caps)
{
    uint64_t quirks = 0;

#if defined(CONFIG_VTD)
    if (type == IOMMU_HW_INFO_TYPE_INTEL_VTD) {
        if (caps->vtd.flags & IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17) {
            quirks |= HOST_IOMMU_QUIRK_NESTING_PARENT_BYPASS_RO;
        }
    }
#endif

    return quirks;
}

Thanks
Nicolin

