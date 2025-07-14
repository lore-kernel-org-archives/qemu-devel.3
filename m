Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7D3C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 20:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubQ2E-0002au-Kg; Mon, 14 Jul 2025 16:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubOaU-0003io-VT; Mon, 14 Jul 2025 15:11:43 -0400
Received: from mail-dm6nam12on2060e.outbound.protection.outlook.com
 ([2a01:111:f403:2417::60e]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubOaQ-0006dy-AZ; Mon, 14 Jul 2025 15:11:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQJLE/nPUhGWavGgNIR7WCYjtBN9xT3BA5aOzBCxkNY8pMZMVTP0YABwh7MXvvtOHGBMxtTl/Fnra+jwmV01UifRCCTsiilirP+pBfsdPrNB/e1Kiryc5qZLjpDMuFhq7DCnmZBV65D1uz4Yzt/+hhFdYdFZ3gzXY2zfBC4KlDs1vuaLpyTpGZN8ntF/sQkZdZ40Mlk5mR0Y9pjzD7Mu9za19QAxovv2GG5L1tmDHwdcGmxI6b+QKkEVVeG9vpScIuOibBsAHFuB8kDc+d3uXq5fW7KvPadzIGuFCkhrdw32SxNBqf+fn94J6U3ckgRmmBI5RQA1CHz3xsG2JlsldQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgcHsYx+xp4aBZ7/DWcGs9lzM8wWf7bh44mlvCY+N00=;
 b=QZ0GtNYWKh+sEvTQZUpYOrsWmm3rw6ldHU1uGfyad2CPbpLjRVnOLk4EBudERpGxcFrUwtoEKbaRnO6DGJjxFOwT3gwU/0nGwrxcgD9Iha2J6k52HHuuZHIQnmSCVgUJOoHD058TFS7kDZSoR30b7RDSWbVBNoj5ej6AYhYqGLsSbyCS0pt8KLgKwaI7dVhMKabmq32HM5sBWYfdbHqZ4GfLeGxC4CGAUsifenmT6timboGC0SyKuLrC2grc1BfxoEqCtw9cjUuLXq+cO/gyBmNxu6fiXiChbAZTq8dQjyc64QL7kC+cjsNM96NsMewVj2V0zWnLfowy8FbLHaYGaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgcHsYx+xp4aBZ7/DWcGs9lzM8wWf7bh44mlvCY+N00=;
 b=D2QgB1RS9yVEn7J7UkIVmn/rzFOeAYQl215zcTnxpqdTs0FwxBUEfE4AK0z0fsgurLZ8h1zkvgVZ/L+V1hfGA7nrnwECRad9JFetC0v994geLoG4pp9JV+QKbVZ1+rGfTm9KQnMoxsDmHYt+7RS6r8aErumq1HrEUVQCYaQUhCNFl/Xn4yQZ5d9f5IVrGjoUrBvCZrmFpYMh8lzTbcg2y1CHda58mxFbif9JwZGePB6VkDYDl0k42/gJ88tC7l/0o/mzL+lGQYJwMFBWUJQaqIdjj5/p1J7MOvr4bQebhVFI5eMJaxhe+Q0L6/Ycc5ou1kor5WOOEC0EPUxNZYXxag==
Received: from MN0P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::17)
 by DS2PR12MB9823.namprd12.prod.outlook.com (2603:10b6:8:2ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Mon, 14 Jul
 2025 19:11:33 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:208:52a:cafe::28) by MN0P221CA0025.outlook.office365.com
 (2603:10b6:208:52a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Mon,
 14 Jul 2025 19:11:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 19:11:32 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Jul
 2025 12:11:13 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Jul
 2025 12:11:13 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 14 Jul 2025 12:11:12 -0700
Date: Mon, 14 Jul 2025 12:11:10 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>,
 <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 08/15] hw/arm/smmuv3-accel: Add
 set/unset_iommu_device callback
Message-ID: <aHVWTnGogqRiQlhi@Asurada-Nvidia>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-9-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250714155941.22176-9-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|DS2PR12MB9823:EE_
X-MS-Office365-Filtering-Correlation-Id: fa796baf-8d26-4175-7884-08ddc30a3eef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mICNqmtMbHnrkF2nFO/UjHP1yRrNP+DVO6AiZZSnbvf7AHvQDFMFbztqSzcV?=
 =?us-ascii?Q?yFCMLF9/T+0pA0vHXSOhaJ5URTRxxEjNkt+7W/HjsEDbws9AVSkuAHNwCIpj?=
 =?us-ascii?Q?PA2bgJcv0/LbLJMnpTw1th4oGJW3jYwt0bUgPaKuLNq14EwhMUqOW0Ld5fku?=
 =?us-ascii?Q?8s5o1o2cWuKvcxjF7vkXTRp5mHJuFtrlhHkVtML/jq7CsY2ooOLZaIc//XF4?=
 =?us-ascii?Q?dD2f+YIAfxRs24eG+35qjQlNym/h/+PM0xuMW5SmQfRRSTvaaiaTFGViQ1PI?=
 =?us-ascii?Q?qipAFeZ2D4xVPTCORY+Co04YqNeNgBK0fF2ptSdqO86nwZ0Z25CkKZ6BFWpF?=
 =?us-ascii?Q?LXOoNOyCDho60NyQitbe9ncqOjr3naVKW0gPcONgfnGxTRpQO6eYzIkivnCr?=
 =?us-ascii?Q?sWaOJS1guNjsnjPDzq9gN47jykBpkFKkiYZzidIgqnh157/DPt5i3FAlCmag?=
 =?us-ascii?Q?4sKpw/ArNtp9N2WjbbJEjAgMd/3xiRaQYxPf5KTuddHvNxr4CFeOQocFemyb?=
 =?us-ascii?Q?kUtZ8/WPtmF0WdKpd/RIa4dXufLimg+dJZhmVPTcUEf/wgswq5BGdmSksVRT?=
 =?us-ascii?Q?TiZi6g3/qvIOeyucrBCIpPsoAwluFRhWoFTbnBfOgSYAhZHARW0pfj3Nclh+?=
 =?us-ascii?Q?hYg3nwWBcQ8cS+nl2y5VgOhVaOQN98xqATbg+b5nfiRzWyu4AqlxTfKdeY23?=
 =?us-ascii?Q?9gXoA/oc3Gamx60BeDhxo94jzs6bwHPoVRRZ1FXlE1J/ZIdx4sEKOmIHUUma?=
 =?us-ascii?Q?4siZTvK8Gb5HTd/KrYJNqgZtGfDIXqM//4t2jClfLg30R081k0UBmL2l03zK?=
 =?us-ascii?Q?ug46BOMmxYxeYYb2TI6s7e3wfISZ4dU0poatdh++zO63GJIBn5xiC3xIw8yU?=
 =?us-ascii?Q?wojVLj9j+piOwRo2JfXsfRfEej8UWqXWkd+WTDn/KcdIQKh66cT4LYh2ixts?=
 =?us-ascii?Q?oPB+whhMPZLlSPgzi/MgujTz/P5TsyDWiOjQS0eJQSxI4YScm/1KgR7ZovCh?=
 =?us-ascii?Q?kBel/sBZR8TdtOa5OoU9ovtgPrmZashagG6Qenz0fhxXvN4cpOMBMWyvd8fa?=
 =?us-ascii?Q?fWx7wncwZln9Kd5RrUykndOvo3A1Vuk+rotrhZPNYAAOA8Mxi3M8rBI3Zmrl?=
 =?us-ascii?Q?1kX2O3GVIKZhYdaCT3emS3AVe7KNuBKn/R5hgAySV0HLGoLgQo88upyA9M5y?=
 =?us-ascii?Q?xcq/FEfob4xxjk/LIYXgvW5jBVcwmrWR5lTiZrs8OJRD/fCsnp29wcf+zIVu?=
 =?us-ascii?Q?j5ah50uSefhndRxmq1uU/OK6pth2xAk6DkM8fazpsg0/ij+d2BQ/644jG6/G?=
 =?us-ascii?Q?j7BXpoooj+Wco+ScA8k0iXRF1fw1eSMjxParlHRgP7hWFw/XIFSZUl2szSBY?=
 =?us-ascii?Q?MDAwsMAEH99mkKW9A2TKTvEY6aQyC9Kmr+++YXleJHybu4WIYqTvzxAC2qS3?=
 =?us-ascii?Q?+fN8WvUNbtU3AFag1JG8VIp8nrtAsRp0bx/acm1chbwgfpzVDJxSWfZOOorY?=
 =?us-ascii?Q?KvtqxLGh72EhPRHIKpxNFVwT1Ksy7suG5RUK?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 19:11:32.7541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa796baf-8d26-4175-7884-08ddc30a3eef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9823
Received-SPF: permerror client-ip=2a01:111:f403:2417::60e;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

On Mon, Jul 14, 2025 at 04:59:34PM +0100, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
> 
> Implement a set_iommu_device callback:
>  -If found an existing viommu reuse that.
>    (Devices behind the same physical SMMU should share an S2 HWPT)
>  -Else,
>     Allocate a viommu with the nested parent S2 hwpt allocated by VFIO.

s/nested/nesting

>     Allocate bypass and abort hwpt.

Let's spare some words explaining why they are needed:

iommufd provides a vIOMMU model for nested translation support, where its
object encapsulates an S2 nesting parent HWPT. In this mode, devices can't
attach to the S2 HWPT directly, bypassing the iommufd vIOMMU object. Given
that a vIOMMU object isn't directly attachable, allocate two proxy nested
HWPTs (bypass and abort) for devices to attach.

> @@ -7,6 +7,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "trace.h"
>  #include "qemu/error-report.h"

Will look nicer in alphabetical order

>  static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
>                                                  PCIBus *bus, int devfn)

There seems to be an extra space in the 2nd line's indentations.

> +static bool
> +smmuv3_accel_dev_alloc_viommu(SMMUv3AccelDevice *accel_dev,
> +                               HostIOMMUDeviceIOMMUFD *idev, Error **errp)

Ditto

> +{
> +    struct iommu_hwpt_arm_smmuv3 bypass_data = {
> +        .ste = { SMMU_STE_CFG_BYPASS | SMMU_STE_VALID, 0x0ULL },
> +    };
> +    struct iommu_hwpt_arm_smmuv3 abort_data = {
> +        .ste = { SMMU_STE_VALID, 0x0ULL },
> +    };
> +    SMMUDevice *sdev = &accel_dev->sdev;
> +    SMMUState *bs = sdev->smmu;
> +    SMMUv3State *s = ARM_SMMUV3(bs);
> +    SMMUv3AccelState *s_accel = s->s_accel;
> +    uint32_t s2_hwpt_id = idev->hwpt_id;
> +    SMMUS2Hwpt *s2_hwpt;
> +    SMMUViommu *viommu;
> +    uint32_t viommu_id;
> +
> +    if (s_accel->viommu) {
> +        accel_dev->viommu = s_accel->viommu;
> +        return true;
> +    }
> +
> +    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
> +                                      IOMMU_VIOMMU_TYPE_ARM_SMMUV3,
> +                                      s2_hwpt_id, &viommu_id, errp)) {
> +        return false;
> +    }
> +
> +    viommu = g_new0(SMMUViommu, 1);
> +    viommu->core.viommu_id = viommu_id;
> +    viommu->core.s2_hwpt_id = s2_hwpt_id;
> +    viommu->core.iommufd = idev->iommufd;
> +
> +    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
> +                                    viommu->core.viommu_id, 0,
> +                                    IOMMU_HWPT_DATA_ARM_SMMUV3,
> +                                    sizeof(abort_data), &abort_data,
> +                                    &viommu->abort_hwpt_id, errp)) {
> +        goto free_viommu;
> +    }
> +
> +    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
> +                                    viommu->core.viommu_id, 0,
> +                                    IOMMU_HWPT_DATA_ARM_SMMUV3,
> +                                    sizeof(bypass_data), &bypass_data,
> +                                    &viommu->bypass_hwpt_id, errp)) {
> +        goto free_abort_hwpt;
> +    }
> +
> +    s2_hwpt = g_new(SMMUS2Hwpt, 1);
> +    s2_hwpt->iommufd = idev->iommufd;
> +    s2_hwpt->hwpt_id = s2_hwpt_id;

s2_hwpt is core allocated now, so maybe we don't need this object.

> +
> +    viommu->iommufd = idev->iommufd;
> +    viommu->s2_hwpt = s2_hwpt;
> +
> +    s_accel->viommu = viommu;
> +    accel_dev->viommu = viommu;
> +    return true;
> +
> +free_abort_hwpt:
> +    iommufd_backend_free_id(idev->iommufd, viommu->abort_hwpt_id);
> +free_viommu:
> +    iommufd_backend_free_id(idev->iommufd, viommu->core.viommu_id);
> +    g_free(viommu);
> +    return false;
> +}
> +
> +static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
> +                                          HostIOMMUDevice *hiod, Error **errp)
> +{
> +    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(hiod);
> +    SMMUState *bs = opaque;
> +    SMMUv3State *s = ARM_SMMUV3(bs);
> +    SMMUv3AccelState *s_accel = s->s_accel;
> +    SMMUPciBus *sbus = smmu_get_sbus(bs, bus);
> +    SMMUv3AccelDevice *accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
> +    SMMUDevice *sdev = &accel_dev->sdev;
> +
> +    if (!idev) {
> +        return true;
> +    }
> +
> +    if (accel_dev->idev) {
> +        if (accel_dev->idev != idev) {
> +            error_report("Device 0x%x already has an associated idev",
> +                         smmu_get_sid(sdev));
> +            return false;
> +        } else {
> +            return true;
> +        }
> +    }
> +
> +    if (!smmuv3_accel_dev_alloc_viommu(accel_dev, idev, errp)) {
> +        error_report("Device 0x%x: Unable to alloc viommu", smmu_get_sid(sdev));
> +        return false;
> +    }
> +
> +    accel_dev->idev = idev;
> +    QLIST_INSERT_HEAD(&s_accel->viommu->device_list, accel_dev, next);
> +    trace_smmuv3_accel_set_iommu_device(devfn, smmu_get_sid(sdev));

Since we need three direct copies of smmu_get_sid(), it'd be
cleaner to have a local variable?
+    uint16_t sid = smmu_get_sid(sdev);

Or should it have a validation of the sdev pointer like the
unset() does?

> +    return true;
> +}
> +
> +static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
> +                                            int devfn)
> +{
> +    SMMUState *bs = opaque;
> +    SMMUv3State *s = ARM_SMMUV3(bs);
> +    SMMUPciBus *sbus = g_hash_table_lookup(bs->smmu_pcibus_by_busptr, bus);
> +    SMMUv3AccelDevice *accel_dev;
> +    SMMUViommu *viommu;
> +    SMMUDevice *sdev;
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
> +                                               accel_dev->idev->hwpt_id,
> +                                               NULL)) {
> +        error_report("Unable to attach dev to the default HW pagetable");
> +    }
> +
> +    accel_dev->idev = NULL;
> +    QLIST_REMOVE(accel_dev, next);
> +    trace_smmuv3_accel_unset_iommu_device(devfn, smmu_get_sid(sdev));
> +
> +    viommu = s->s_accel->viommu;
> +    if (QLIST_EMPTY(&viommu->device_list)) {
> +        iommufd_backend_free_id(viommu->iommufd, viommu->bypass_hwpt_id);
> +        iommufd_backend_free_id(viommu->iommufd, viommu->abort_hwpt_id);
> +        iommufd_backend_free_id(viommu->iommufd, viommu->core.viommu_id);
> +        iommufd_backend_free_id(viommu->iommufd, viommu->s2_hwpt->hwpt_id);
> +        g_free(viommu->s2_hwpt);

s2_hwpt should be core-managed, so its id should not be free-ed
here at least.

Thanks
Nicolin

