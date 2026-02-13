Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C93EF99E5
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 23:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vr2Fl-0004n2-C5; Fri, 13 Feb 2026 18:07:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vr2Fi-0004mC-VX; Fri, 13 Feb 2026 18:07:10 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vr2Fh-0003bR-6i; Fri, 13 Feb 2026 18:07:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixKCFfZ7XklGkq9AzStAMuIljX0d0HZUED+mKpfgxu1T/Cz6EqECkj01Q/0tNw3C9pDoo3lolEUMoSlKy0H9HbHd/txTopnclnMrkYJWLpINl6xex0HRhKpbl2iljR5Ra1zR8QGewkth6uhae5HIVGm88xQD+WPdfiI2AP6S2OoQsi0+Ns6KSlHGBcBFY51YWl8xq50jJ4l1gn9x67jdXq/0vq24K2E40iJydZqwAPh1we8JuRgwmon3ZSAlHrE36OVzxA+7ih9gGxFJH28rcb8mXUhA7GOb4vMywLK+aUNZptjSi+K43OPA/ZB0shNPMyQnpRmWp9UBUr5WCTDIfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OR5EBklqxxnUAaMLLH8soFE2RLQz13v7gTJAewWXhSw=;
 b=tBCe2bKHmRjV0dkfCGYuT02dfpRfVBuZ7ReS7h11xxVzVBOy+ZC+TEUppVkesEjD641xUNqSu2/8kOmFBmNr6C5OOVuEKY4KIw1BZtrt+smPDx56bRMndOXAV48dr0nXeEXsMVQv3Jv98Cp3PjWNcp6zRvX0XgmgsR/W5ALRT4D3BIuwZLg4+t0WG1rV0YD2Hk0mD/bl6XFQaUZne3ddEeC787GN5cORE29VQz3D9FR7iXrlQuKB393bC5xYbzQ+gKgnH/wMYPCIqMQDYjM4M0N4JQYpTXp94vn6lTii7/KnahFmgKbneudMlTTJDNoxfof/DeJUTEoQOMHAfgeV4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OR5EBklqxxnUAaMLLH8soFE2RLQz13v7gTJAewWXhSw=;
 b=m1KQ750XWwCy4YX9RzvpI3gOQcv/fSActlbi015F1Cww88mPYC2Vr+FtcfJBWBMwjmwvvFXvY+O2+6Xxvg+X45ZaD+YzvLtg35cwoctrLZ99n1eDRkEHTkxgbCJ06Mxuz5pyJqUZd4qMthz/udTAPjIyfTMwrZvZAY62OIkR9YKEVDZVRSa2ReyKfojANoRawgMcTYH/aLQWuv3UnSag8RC5cjD1Am7czSspMSnloOvqk6tS7X0T9J9rfdOgfRbVbWqMu3BePk9f1014WYa+/B3S3NykdNeSslWr7hyjOpOPktLBBP6EE6GN2RuBQBrjJ4SpjDxeSQ2r+/Gues6SiA==
Received: from BY5PR03CA0029.namprd03.prod.outlook.com (2603:10b6:a03:1e0::39)
 by DS0PR12MB9039.namprd12.prod.outlook.com (2603:10b6:8:de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Fri, 13 Feb
 2026 23:06:56 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::c4) by BY5PR03CA0029.outlook.office365.com
 (2603:10b6:a03:1e0::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.11 via Frontend Transport; Fri,
 13 Feb 2026 23:06:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Fri, 13 Feb 2026 23:06:55 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Feb
 2026 15:06:40 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Feb
 2026 15:06:39 -0800
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Feb 2026 15:06:38 -0800
Date: Fri, 13 Feb 2026 15:06:37 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <clg@redhat.com>, <alex@shazbot.org>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>, 
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v2 15/24] hw/arm/tegra241-cmdqv: map VINTF page0 MMIO
 region
Message-ID: <aY+ufT8pR/N+c8q8@nvidia.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-16-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260206144823.80655-16-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|DS0PR12MB9039:EE_
X-MS-Office365-Filtering-Correlation-Id: 52d45f76-7557-46d9-4116-08de6b549514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T+PFUicpLojYgr1PcYOdtma3ZCRVy/kr8bwjl9NdsvzxKehudjbuACrzrubu?=
 =?us-ascii?Q?iHgP5X0xb0oBK0+k6gy1nsNsCI3Lun14Jy78mqbSPJQ2FdtK7OsugbcFe8Qe?=
 =?us-ascii?Q?UujepFR83A/bvreAGt4zE8VXtKYfu5ALQeYLq7yWI1NAANv8uOi1fFjZIpzb?=
 =?us-ascii?Q?MG0vwacFPm0CDCHfXBztd1wwLvOie5Q3uaYBQMkixJGgekW/8CpanmK9d9sa?=
 =?us-ascii?Q?0es4DdindJbMBfpYHrNMsTJVoPmMDbw/ShccN5OWiu3H5MJ43Ale+fCWgnJ4?=
 =?us-ascii?Q?o/+lqtY2HIlUddD+5T14PKTeWaLQF6IVYmTadqcskpbnfSE79pCa2MVObP3b?=
 =?us-ascii?Q?aHHEKKujo+q8Am8z26trc24Feui7qbZAhCCv/BjMteW/eNNYLqHMiFqjDL7j?=
 =?us-ascii?Q?qLoX9wAw92ioQontvkw8xxaA1SP+lRTEUVE0SVVJzH6epZTCmNqJrXAI6f6A?=
 =?us-ascii?Q?4VXo2W18MmVicXYAefrD7D1q+3HM1MDLv+XZeyQo2YFGINcwrvOrsXUAjXYv?=
 =?us-ascii?Q?BWELjVH2msEQSuvywNvJSYnVCpRo/+tY5TN2ZnDQohWIa9DvJIQAfj+nPhir?=
 =?us-ascii?Q?f4Dds+6thA669kF7py7a17vUllxKnKSk+ES031ylARgLQ42zpG6uG9+XviOb?=
 =?us-ascii?Q?tdq9m1jKVSUyTXT83175ruguEI9SLDKkm5zB9NMmobd0O0JURBmaxlOdpm+i?=
 =?us-ascii?Q?Qc6C59VcRQGzvVC0/BmjTax97kOCFljtCi+NnI18nlBPPozi2H2VQOzJbdCb?=
 =?us-ascii?Q?ldbMPFbQiTcQYNnkYWl6p21j7rU4sg08Tzt8wb+mpVCsPm1xtrT2IAUSIgv0?=
 =?us-ascii?Q?D12Pha8Yu/88nMuk652OaHYDUYvFqk/8z2jKTpyc5Akwe8Gqyk8xc0fbz2gi?=
 =?us-ascii?Q?yBIFPu6GE2mUvLqntJnHjzY0FwBdSppZMSHRKPpAtFg/2rQGKWkc6YlWt3YK?=
 =?us-ascii?Q?ekSRT+7IB88O5WC/kD8GxBAFPlrd1xrxqqHseJWwBM9067qmV9NO7l7usWNX?=
 =?us-ascii?Q?vQGBoiOOnaCQLxRuYV6ooN74sWMmeCNQ4cKQmGmklBD6CC50+iONwqhifb66?=
 =?us-ascii?Q?R1tzt1nY5dRyqeTmsfy1L+vrsf5z428kmI4m8vZkQs7FdQeB+ErsbULXqRye?=
 =?us-ascii?Q?gA/HBjR87motWWUoZkPWlq0y+3Re+8KxEovVGJT25QzktI60g22ULffUGWtq?=
 =?us-ascii?Q?OQtcDujajufT/feAzLbQjB2cfQeRhmGoyZqU6XG1BlbFmZtRCrWBHYRaYPJc?=
 =?us-ascii?Q?FV2hbyqPTjnv+Wgre2nrCm4GmFyZCJoe+qOoe7FpEnrBZt/HJry8VTpsdrB/?=
 =?us-ascii?Q?cJ82chwByclMDCPPWJ3x8Sv3l9H7h4O1yIU5XRznm6f3krlb12vSKFy2rBUt?=
 =?us-ascii?Q?S5iZR56nucUl0Q5i/NS/nqjJtYyLki1VESi1C+bERSnPxvvNx5e+OXCXDqE/?=
 =?us-ascii?Q?n26GXKvEZmIRLOWeWXkIQKVrXUZUoRWn+Iu40KLVAapQ/1nbwvAw/U0EGUlN?=
 =?us-ascii?Q?co39btTtw37KR8UVbo5a3GxSlvZhMZeYT2fPoQ/MslLifbsEsVl7AFmjVpb+?=
 =?us-ascii?Q?8xIXT7p+tXh+6NEwNIzmhN3ahIaSGOn+26Ki8e76cmy8hYKxSzK6vINootfB?=
 =?us-ascii?Q?MZ/4p4VQDKV5xE/ADAYs4gQPRQpA0h5lwjMIYli2XxNZGJG7w3aTXPTZU8gS?=
 =?us-ascii?Q?7XHtQw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ELUNinqc/aBjUWMXQ0nBWGnuSg5UZy21oJlRM+/Mv24gl33/2V/wG5QWPLhyBzqZaVKnhEJPTUHEZ8x05pSCAaf5dbMuxVTmoibz9BM7gkmqNnUqWstpe7tIDr+XBjJlxBJmneG9VqKdLzp2gsefm0u51kkyJd+3wyeSRcLOrXcMn/v8SpbZAdydQhVj2ulMMYrcc7fealDiDtuQCgiHPuSt4qD0X7ojpSqOx3V1GDmqbYy3BSm8vs00TlJ2VwO8NLPgCpPwM5YsjbfkwsnnVU7fLXSnuoHAjntaemGvCAk4TOlVvIuRVUVOoaieOR/o9MJK/aXjZM5SiXVFjbO7LKrLcXIvxRsXSRbZSoWAQkZK9OsaXEJBFs92VN06OC3Q2h/qlH/WHd+CXFVk11QYlqCxtFn6Tl0lsT2rS53oIDcfHiwtelvRgzLqNRrp2oiE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 23:06:55.4363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d45f76-7557-46d9-4116-08de6b549514
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9039
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=nicolinc@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
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

On Fri, Feb 06, 2026 at 02:48:14PM +0000, Shameer Kolothum wrote:
> +static void tegra241_cmdqv_map_vintf_page0(Tegra241CMDQV *cmdqv)
> +{
> +    char *name;
> +
> +    if (cmdqv->vintf_page0_mapped) {
> +        return;
> +    }
> +
> +    name = g_strdup_printf("%s vintf-page0",
> +                           memory_region_name(&cmdqv->mmio_cmdqv));
> +    memory_region_init_ram_device_ptr(&cmdqv->mmio_vintf_page0,
> +                                      memory_region_owner(&cmdqv->mmio_cmdqv),
> +                                      name, VINTF_REG_PAGE_SIZE,
> +                                      cmdqv->vintf_page0);
> +    memory_region_add_subregion_overlap(&cmdqv->mmio_cmdqv, 0x30000,
> +                                        &cmdqv->mmio_vintf_page0, 1);

I wonder if you see this:

[    0.853123] arm-smmu-v3 arm-smmu-v3.0.auto: allocated 524288 entries for vcmdq0
[    0.854739] arm-smmu-v3 arm-smmu-v3.0.auto: allocated 524288 entries for vcmdq1
iommufd_backend_alloc_vdev  iommufd=142 dev_id=1 viommu_id=4 virt_id=0x200 vdev_id=8 (0)
iommufd_cdev_attach_ioas_hwpt  [iommufd=142] Successfully attached device 0009:01:00.0 (143) to id=6
smmuv3_accel_install_ste vSID=0x200 ste type=bypass hwpt_id=0x6
iommufd_viommu_alloc_eventq  iommufd=142 viommu_id=4 type=1 veventq_id=9 veventq_fd=153 (0)
iommufd_backend_alloc_hw_queue  iommufd=142 viommu_id=4 queue_type=1 index=0 addr=0xe2000000 size=0x800000 queue_id=10 (0)
vfio_listener_region_add_ram region_add [ram] 0xc0b0000 - 0xc0bffff [0xfffff7f00000]
iommufd_backend_map_dma  iommufd=142 ioas=2 iova=0xc0b0000 size=0x10000 addr=0xfffff7f00000 readonly=0 (-1)
qemu-system-aarch64: warning: IOMMU_IOAS_MAP failed: Bad address, PCI BAR?
[Switching to Thread 0xffffdd7aee80 (LWP 52426)]

Thread 38 "qemu-system-aar" hit Breakpoint 2, vfio_container_region_add (bcontainer=0xaaaaaf1220a0, section=0xffffdd7ade00, cpr_remap=false) at ../hw/vfio/listener.c:620
620             error_setg(&err, "vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
(gdb) bt
#0  vfio_container_region_add (bcontainer=0xaaaaaf1220a0, section=0xffffdd7ade00, cpr_remap=false) at ../hw/vfio/listener.c:620
#1  0x0000aaaaab8a9290 in vfio_listener_region_add (listener=0xaaaaaf1220d0, section=0xffffdd7ade00) at ../hw/vfio/listener.c:492
#2  0x0000aaaaab3035f8 in address_space_update_topology_pass (as=0xaaaaaefa6de0, old_view=0xffffec5171b0, new_view=0xffffc8001410, adding=true) at ../system/memory.c:1030
#3  0x0000aaaaab303974 in address_space_set_flatview (as=0xaaaaaefa6de0) at ../system/memory.c:1106
#4  0x0000aaaaab303bd4 in memory_region_transaction_commit () at ../system/memory.c:1158
#5  0x0000aaaaab3084e0 in memory_region_update_container_subregions (subregion=0xaaaaaefa7b00) at ../system/memory.c:2653
#6  0x0000aaaaab3085a0 in memory_region_add_subregion_common (mr=0xaaaaaefa79e0, offset=196608, subregion=0xaaaaaefa7b00) at ../system/memory.c:2668
#7  0x0000aaaaab308644 in memory_region_add_subregion_overlap (mr=0xaaaaaefa79e0, offset=196608, subregion=0xaaaaaefa7b00, priority=1) at ../system/memory.c:2685
#8  0x0000aaaaab570f68 in tegra241_cmdqv_map_vintf_page0 (cmdqv=0xaaaaaefa79c0) at ../hw/arm/tegra241-cmdqv.c:275
#9  0x0000aaaaab571188 in tegra241_cmdqv_setup_vcmdq (cmdqv=0xaaaaaefa79c0, index=0, errp=0xffffdd7ae0e8) at ../hw/arm/tegra241-cmdqv.c:317
#10 0x0000aaaaab571550 in tegra241_cmdqv_write_vcmdq (cmdqv=0xaaaaaefa79c0, offset0=131072, index=0, value=3791650835, size=4, errp=0xffffdd7ae0e8) at ../hw/arm/tegra241-cmdqv.c:378
#11 0x0000aaaaab571a60 in tegra241_cmdqv_write (opaque=0xaaaaaefa79c0, offset=131072, value=3791650835, size=4) at ../hw/arm/tegra241-cmdqv.c:484

Nicolin

