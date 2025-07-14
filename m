Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350A1C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 17:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubNAI-0005bK-M5; Mon, 14 Jul 2025 13:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubM2Z-0005T6-5m; Mon, 14 Jul 2025 12:28:32 -0400
Received: from mail-bn7nam10on2060e.outbound.protection.outlook.com
 ([2a01:111:f403:2009::60e]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubM2U-0003XN-RX; Mon, 14 Jul 2025 12:28:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wB/+1e8QacnBTL5m7gNpWvr7LiwXJfk/YiPXnDjVrwYx6QztS2uG690ZWrdn58aEtoWJLHWhOtDGyBO8aChVr4xRaHtCK3UOD+HQZaJoRD8ntn2G/9EPiQf77n/46pvJoPP2CXcwZL8ys0AkvWUeWDItIjAN2l+RjPz1BjwWL1FGienMQADMzL612Qem1GzbonHBUw0QOfHU3Baf5P41M81pRQG4UhwbnjYUObJ0kNHAqgk3gsxYTEAKzMmNUXRaG94hn8p2HTkqcb7j95DUuvQOpaS6dOUisM+2CvdEfFwuxcvaoNRZhDCt4Q+HTSv5vbDLvWUIR/qIcvgO9x37pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CH6Eag7jHbtVmxHPHstgeCNCsAVI+JEcyRx38QkH2RE=;
 b=LY77rNziHVD43bf9phwnEREAdUDE+3skxs6guEkC64zSBZ8GV7BED4PfL8s1B3/2xgyNdO/rOlcGStr6PljSMvtn7jkSVOFSBUaWxjj584g5D0nTstAoLbMGxBKrsOKCZjhl6peYDT5t12Kq9r/tFOXqIqJFlW+rbfdznbQR1Pu0vDkUAc2EOJTrg42MEhzYgH1g9TyK8ONpZ7/ffromEmw11frD4xzLeJC8LCZ3RLqQlbVPv42alI01GkIhY2R2msROKnNXV9Q+3k0jIe6M5RDjeMq/ejBq98k0WIBD5pOvYou5GfMFsz4LOJrIUGepJZTcOXDjQICe3xuDcFZmBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CH6Eag7jHbtVmxHPHstgeCNCsAVI+JEcyRx38QkH2RE=;
 b=EC+Pe8rAKpnu4u4LuTW4Kf4QSFHd3RNgc+pHYJ2XyK2u5ArakdjQW7DGom2rMykZHCyLwRWVaY3QiQLDbR+PJ1zv3THR0DO1S9TEuxeX5wbeBsev0sn3m2FWA0njq8vRIM+T6Zh2HevY4t4ToiNZjvN31KtourowRSEbE9FHLFLvePDQV0YUdOPGMckSmQ1BbtHwU6rZfJJTaTP5IRDtjWVndmKJhOV20PBqD0KZcGEcIfHoePgCO1dfy2qPCpjuqD6BZudRzSX7Djwf+51JM8gRnLyTDGR8DfNe6d14XREjiLtJLEz7/ek4hGLiLsOcsU27y4wROfiQsvEkLL+kVg==
Received: from BY5PR17CA0020.namprd17.prod.outlook.com (2603:10b6:a03:1b8::33)
 by SA3PR12MB7950.namprd12.prod.outlook.com (2603:10b6:806:31c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Mon, 14 Jul
 2025 16:28:19 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::c0) by BY5PR17CA0020.outlook.office365.com
 (2603:10b6:a03:1b8::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Mon,
 14 Jul 2025 16:28:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 16:28:17 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Jul
 2025 09:27:57 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Jul
 2025 09:27:56 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 14 Jul 2025 09:27:55 -0700
Date: Mon, 14 Jul 2025 09:27:54 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>,
 <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 02/15] backends/iommufd: Introduce
 iommufd_vdev_alloc
Message-ID: <aHUwCgckXCVniagD@Asurada-Nvidia>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-3-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250714155941.22176-3-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|SA3PR12MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d0db59f-e173-4d2c-e316-08ddc2f3709d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4/fTtceWXZgd3Sq2Gl2ttHKhJ2X39DWAjSJgeWMIJLxA/QkhWgN0ceJefL5b?=
 =?us-ascii?Q?WNcxVuEASscinbk41v4X+YEHhfbRVsyUr2J4wBEp2HfnbxsOJ51wLk+eqKx5?=
 =?us-ascii?Q?Pv3T4fGItH+YlF5ihKwFB/pTrzxd+0P6BRBVvA6KlDrPjMB57zMLbB25vSVK?=
 =?us-ascii?Q?k9byBb58DO0XfmNeSIqS9gIs3Y2u7t8pcz/sNlT2wAQIIQNZyAziCJrxqObx?=
 =?us-ascii?Q?Cw8hK+Ioqhw+FqkCNHCo2YOaTtfh8ckPAFNShQ/X257YsBDgzjE6b6+WNoRC?=
 =?us-ascii?Q?t3HzNKOvFF5UQ4GGwGBj4FwOoCCqfKuEh96rexu098pT+kuOdKxb9jmqG5uS?=
 =?us-ascii?Q?AekwKIBWiN6SxLXrWmC7TetkzB8+RvvIsoLl4+Hc3taXcHX++k7+IK1qkTYB?=
 =?us-ascii?Q?YxXCbxzk3jkFNKjjy127oIrFEfs3jdJIMSVvLvyLnfS4sWgrtAhrNFyF2rA7?=
 =?us-ascii?Q?t0cjkD32HsetjNfWLzF5NEaygrHulcW/NNF+OfxpNwJ3DElUQ+w4xQtz5dPo?=
 =?us-ascii?Q?YTFMbDiqtdEjpoNPd0/Q8Gj+XoTVfVTHSvBkdwfkWR2Yy8KFqiG51zkC+tQ4?=
 =?us-ascii?Q?kpW9aBHZNukwxmDRv750Wab6AgVyjPvdFr4dTTCrysMBTwUGs5tWKfKCDtwP?=
 =?us-ascii?Q?2oue+RWMwsg2T99ZNMV/F6anPkwm10OwPAhHcRFr1Q53p8ViOykusvXRmAbe?=
 =?us-ascii?Q?JSV4XUdtOubUzsSdBjVJNHvySy46NMf0XVnChH4mOH2+YQTzh6KKr/maRRB+?=
 =?us-ascii?Q?ip0lkcK06MDrqT1C8hK5O+Kjb/TmiJDuVxR8sZAPrzzy98fbntJlk8ePftxE?=
 =?us-ascii?Q?tUCEIJf1QjO2a+89Tub0q7jFeIuYZ2f1BjnXZvciUTMLxb4o/5rrhROMBWXG?=
 =?us-ascii?Q?1m1kD/fJe42D+E54gAE0XevWTBhh721nlNkmAAqD02it+qjoZ48BEuVAHUBN?=
 =?us-ascii?Q?2g+HaVkRcGY37QHfMV7svfN1t1VrqFsoOea+Isf87l1c6Lx/8vwCLokheNUb?=
 =?us-ascii?Q?G3eEpGJ5e6EoUFkrHRNNW1NXU2TOvPpruzQbbaLySP6bhqFKKa2CdyAvRI6C?=
 =?us-ascii?Q?u8KyjpNIq53va2ayG8JeWB13EkUIzbDbaMzZCRt6h7F1wzbFO70Bn+sIq3kg?=
 =?us-ascii?Q?E9jAMZ40IqjYb9+ui8xviSg+QUjOLAX1gGkNhdNUvRWGC85oSMRX3/zUD5FT?=
 =?us-ascii?Q?+OlS9HCBR4UbQKN+FBeCqBFt3rwfio7Tgx2wLyUCK03GDI/+AoWfivLEfq0L?=
 =?us-ascii?Q?esj54c+Xd/XLiYpwB+FFfFIH5pNC9k0MQZ9NtfK4g7wJzFBSFTm01umjBxMK?=
 =?us-ascii?Q?sXypGI7kEYbEcBiCpzm3/k0LrTq2zwGChyGzfuw7D2E7PLPxJe4Gr/DSmcVm?=
 =?us-ascii?Q?lXXk11mGYZDKoWrSvix1WaJa2n46tnjZ5nBN6g8gV4eqqMJTQ3KeOFeulXSE?=
 =?us-ascii?Q?C6jvXcbFpMdzvVvYxX/DHB3fWSjw9MqjOfIBbwaZoi9I81YvrKJ0DER1U0sS?=
 =?us-ascii?Q?eoyN8S0AXh6K8kNeIQIYWnYtLK1kUVuPgJgV?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 16:28:17.7808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0db59f-e173-4d2c-e316-08ddc2f3709d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7950
Received-SPF: permerror client-ip=2a01:111:f403:2009::60e;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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

On Mon, Jul 14, 2025 at 04:59:28PM +0100, Shameer Kolothum wrote:
> +bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,
> +                                uint32_t viommu_id, uint64_t virt_id,
> +                                uint32_t *out_vdev_id, Error **errp)
> +{
> +    int ret, fd = be->fd;
> +    struct iommu_vdevice_alloc alloc_vdev = {
> +        .size = sizeof(alloc_vdev),
> +        .viommu_id = viommu_id,
> +        .dev_id = dev_id,
> +        .virt_id = virt_id,
> +    };
> +
> +    ret = ioctl(fd, IOMMU_VDEVICE_ALLOC, &alloc_vdev);
> +
> +    trace_iommufd_backend_alloc_vdev(fd, dev_id, viommu_id, virt_id,
> +                                     alloc_vdev.out_vdevice_id, ret);
> +
> +    if (ret) {
> +        error_setg_errno(errp, errno, "IOMMU_VDEVICE_ALLOC failed");
> +        return false;
> +    }
> +
> +    *out_vdev_id = alloc_vdev.out_vdevice_id;

g_assert(out_vdev_id);

Thanks
Nicolin

