Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0127DCCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 23:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEyvt-0007zN-CI; Fri, 31 Oct 2025 19:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vEyvr-0007zA-OV; Fri, 31 Oct 2025 19:53:24 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vEyvj-0000PG-1x; Fri, 31 Oct 2025 19:53:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZovGmEUOQwr5fTimuQ803F1PWupU+iVg+lCOluMjmaTYgF5MbZQsC929DaBoEUbguXDGILX/ou65NPhPTuxFG3qiWEVG5djQ8+7VkZ2bjIaFumbkmX9j8G+X7MZzRd+NIfy6PmmxTzwzJBm3JTUXzKsgchOn+tcHvxmO/0Yq4nK++IXwAz349//4c/0VAJcm2e8vHflbVsGjhUe7rzvnNbrjHIrcTagDsLqOB5qov1C6aYVfaDnbs9dvxZGnlXxx4wV3koKw5RXrHVKaQXcwBBtKTbcd0vTP5sj5Q6URTVRbrz8t3EeGZ1EX0OFLjDW/wsS2JNdMxfCdgeQaQ+Qg6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxmP4MmtaadBG2VmfzBZ/3J1mYT/sC1Kscr3dKVNZGs=;
 b=LBlhEUoQxfxtWl8cE/Ya9kFDkU97vUwYnyLAhv1X0NuJnuui9ri9vmUDzqKqcTZqJtTBGN1Na72jNaTMn1o3/BAoxydm8XKloLJwhjrLBCjQpbnr9YQbwMKO70K6TaUiPBQJIS7/1TdRPI9D/Po1MTPV0pzRLEDMEtlM9XslaBBRWrU8IKSoLtSWTjU9s1TNzeT675UyLvnPStx4i6suEz9x0jGd9HLYwCWKU3OVUYn2Gh2qD39S6FrqBZKxlfziaghToanzUKKBL4LKnfHvsSJpf0DRy93ofoPmyt0L5qe16d2UkqR7zAj8kChAsNIrK9Y81prjG7JUwmz8mhTpOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxmP4MmtaadBG2VmfzBZ/3J1mYT/sC1Kscr3dKVNZGs=;
 b=psaQoUYPqkSnCJAY0urhSVtbjjdQhNpKs64jUTl12njbvIRqTMKnh9lvP8H2AQFZcVaZuV6dzFdjtCrK51LYxToCNhzWnKu7Fv2gHZKNKJG4HjhgpGZg3AlOjwXq1PjNqPl8HO4gnLISCB5xuv8XDZuDjytxRGJ7oJP2Fxz6i0f7uLh1vi5q/brhQsGq7rIk/Bsb9bmpOXy25ZffguD+PnIYK0zPBYUwo3JlglaKcheNRV+zSELBQt7o7+AJqARV7uO9qPyqm/zuW+DNMIrXNqFeKKb3P4S+IBM8mkLTphsQyDPMuCbm7PnDfAxPyVOccROktb6e5hLzAXpQR4rc2A==
Received: from DS0PR17CA0005.namprd17.prod.outlook.com (2603:10b6:8:191::6) by
 LV3PR12MB9402.namprd12.prod.outlook.com (2603:10b6:408:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 23:53:00 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:8:191:cafe::7) by DS0PR17CA0005.outlook.office365.com
 (2603:10b6:8:191::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 23:53:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 23:52:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 16:52:47 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 16:52:47 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 16:52:46 -0700
Date: Fri, 31 Oct 2025 16:52:45 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v5 13/32] hw/arm/smmuv3-accel: Add nested vSTE
 install/uninstall support
Message-ID: <aQVLzfaxxSfw1HBL@Asurada-Nvidia>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-14-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251031105005.24618-14-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|LV3PR12MB9402:EE_
X-MS-Office365-Filtering-Correlation-Id: f6458a31-d861-4a21-0ba3-08de18d89f7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|7416014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y9mIye+WnfGpsk81hTnW+JeNBVUzaEvNnfmsZR+pVC6JksYkl0h1eopK0Tps?=
 =?us-ascii?Q?dVXCQKTbzr7aAYI7IKxHBLvEytCsjJvO7cOxn2KZwyykVIe9TES91fFxBCEy?=
 =?us-ascii?Q?/qR0ku8iZsL84dcr6ySbB86ODGkgymVfATPiRThTSx7uZvrKFMSn5JA4me8Q?=
 =?us-ascii?Q?1of31UhggQOkIasfmxqC1TazlGmpfcrIic0elPH+wfQNX6nc/HMppdwBghIg?=
 =?us-ascii?Q?kGWKjpAozkHuLr5GTgOFQVZTbOSbNF/iCdpTkY96/AkM/7m9wS7g3bHqsuQ8?=
 =?us-ascii?Q?snhwe7+ZKUoJlVpaojLAfrMPjRND85dM9pksKMDA70h+6Sc8zYavT2i9d/TG?=
 =?us-ascii?Q?tI5yLOdvuRhih1Y0X+pmlSlTsB5Ic9QKNHDZqSXhTCKrgzLLocC5/qPia6qT?=
 =?us-ascii?Q?kuebH1QbBNeT5wTyXCXf4lzVqWevvoa7Syv1CR7AkSP9kNjlot6Vhqq/TOM6?=
 =?us-ascii?Q?q3zED2mN68N8OJzEaO//43Uh3Eawd5T5Qd3QPnRaqi9cWK3W8dNftaZCPzmC?=
 =?us-ascii?Q?stGSbRVcwku4hM9/g1aBD4pPRv3tRru2uIBuY71r0vTRgmQC6RyhMp4AJi2N?=
 =?us-ascii?Q?FYHvvUflKdzNPJ4KH0GyhG4lZbzUMgxFKZDPwJVK059gTFAPkZOgmkvHEeMi?=
 =?us-ascii?Q?oawlnlxL8rlj0YoKjFmH7pKxKle1OvEL1TeLBQgcBTags+4hBt3KR15VAX7j?=
 =?us-ascii?Q?mss33dHDQdPQlYCIcYTzaehCUwiT16+koAZ/4SL+qoY61tU9HDKb9AXneQhD?=
 =?us-ascii?Q?Ct4FI2aa147yuXBtEgsbkeP0zKaRi+o05nOlSSrUXG9Oq4KOyaJf3QGhqj6c?=
 =?us-ascii?Q?//c1n7ZIeS3+xK0wCbCXDbAU0auFaqydiWCFJKSQivWOEzxFQOxsd//RlTi6?=
 =?us-ascii?Q?5rS3CAGjynDzhq2mYPI4LcWy8+qTs05Y/16kqVzBvkx1nnDFZ0gxNOxxp9uS?=
 =?us-ascii?Q?CxwBTZxGnQWA9moOnsMAaOow3+lAJr3h0ejkHdf/SChqap8rZ5oUcYPyQ2qP?=
 =?us-ascii?Q?s12UoYp7J9aPIV135n9ZCM86VvpO3TuwuPNIfT9Vu3XW7udWN/RHqdH2CyU8?=
 =?us-ascii?Q?Hk8RSh/aJcOUXpgZ2RGyacCC9zairVGrfYCTslqRHekgarjDU32+VyhZ68YU?=
 =?us-ascii?Q?leXqIwlVMf2iXmTuMKQaPegl3qo2jtxuvdkyf/oRocwtQ9hJ4Eky/1qJ4vzC?=
 =?us-ascii?Q?0NSx5YBwAfTYzSAybD9IyhUSynkwUMXBZuDXpgtf7vmUaX0XOZIxWbfkDfs3?=
 =?us-ascii?Q?sdpnSKUQD5ae9An9w0TW01T4dAdVSTCy14tjhKfi5uJNgZnSriQdvqxS6B+P?=
 =?us-ascii?Q?p+hpqlIt8jRf41WznoATlN9R19q/AgZvVfat6wMcU/Zwk7Z64OQAWOmxSTdb?=
 =?us-ascii?Q?vJ5igK4C7a2+XZsnuKv/96pvxiQ3WIXgsdT2ETslObxBtisrI3bpMACJSfxx?=
 =?us-ascii?Q?gR4bDC+aXcdGODLwC2LKiilp9EChI3ZDBySCjr2ITmiwoz6PY+jWoPpAXdbq?=
 =?us-ascii?Q?gcClahcguHRdDJ5t0F9crHJF0UZbRE6l/coeFdQYg64wYNMpaEO2iQZ/eHAB?=
 =?us-ascii?Q?5UnFDy4z0DyZQXvyeJo=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 23:52:59.9542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6458a31-d861-4a21-0ba3-08de18d89f7d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9402
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=nicolinc@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
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

On Fri, Oct 31, 2025 at 10:49:46AM +0000, Shameer Kolothum wrote:
> +static bool
> +smmuv3_accel_alloc_vdev(SMMUv3AccelDevice *accel_dev, int sid, Error **errp)
> +{
> +    SMMUViommu *vsmmu = accel_dev->vsmmu;
> +    IOMMUFDVdev *vdev;
> +    uint32_t vdevice_id;
> +
> +    if (!accel_dev->idev || accel_dev->vdev) {
> +        return true;
> +    }

We probably don't need to check !accel_dev->dev. It should have
been blocked by its caller, which does block !accel_dev->vsmmu.
Once we fix the missing "accel_dev->vsmmu NULL", it should work.

> +
> +    if (!iommufd_backend_alloc_vdev(vsmmu->iommufd, accel_dev->idev->devid,
> +                                    vsmmu->viommu.viommu_id, sid,
> +                                    &vdevice_id, errp)) {
> +            return false;
> +    }
> +    if (!host_iommu_device_iommufd_attach_hwpt(accel_dev->idev,
> +                                               vsmmu->bypass_hwpt_id, errp)) {
> +        iommufd_backend_free_id(vsmmu->iommufd, vdevice_id);
> +        return false;
> +    }

This should check SMMUEN bit?

Linux driver (as an example) seems to set CMDQEN and install all
the default bypass STEs, before SMMUEN=1.

In this case, the target hwpt here should follow guest's GBPA.

> +static bool
> +smmuv3_accel_dev_uninstall_nested_ste(SMMUv3AccelDevice *accel_dev, bool abort,
> +                                      Error **errp)
> +{
> +    HostIOMMUDeviceIOMMUFD *idev = accel_dev->idev;
> +    SMMUS1Hwpt *s1_hwpt = accel_dev->s1_hwpt;
> +    uint32_t hwpt_id;
> +
> +    if (!s1_hwpt || !accel_dev->vsmmu) {
> +        return true;
> +    }
> +
> +    if (abort) {
> +        hwpt_id = accel_dev->vsmmu->abort_hwpt_id;
> +    } else {
> +        hwpt_id = accel_dev->vsmmu->bypass_hwpt_id;
> +    }

This should probably check SMMUEN/GBPA as well.

Likely we need "enabled" and "gbpa_abort" flags in SMMUState.

> +static bool
> +smmuv3_accel_dev_install_nested_ste(SMMUv3AccelDevice *accel_dev,
> +                                    uint32_t data_type, uint32_t data_len,
> +                                    void *data, Error **errp)
> +{
> +    SMMUViommu *vsmmu = accel_dev->vsmmu;
> +    SMMUS1Hwpt *s1_hwpt = accel_dev->s1_hwpt;
> +    HostIOMMUDeviceIOMMUFD *idev = accel_dev->idev;
> +    uint32_t flags = 0;
> +
> +    if (!idev || !vsmmu) {
> +        error_setg(errp, "Device 0x%x has no associated IOMMU dev or vIOMMU",
> +                   smmu_get_sid(&accel_dev->sdev));
> +        return false;
> +    }
> +
> +    if (s1_hwpt) {
> +        if (!smmuv3_accel_dev_uninstall_nested_ste(accel_dev, true, errp)) {
> +            return false;
> +        }
> +    }

I think we could have some improvements here.

The current flow is:
    (attached to s1_hwpt1)
    attach to bypass/abort_hwpt // no issue though.
    free s1_hwpt1
    alloc s2_hwpt2
    attach to s2_hwpt2

It could have been a flow like replace() in the kernel:
    (attached to s1_hwpt1)
    alloc s2_hwpt2
    attach to s2_hwpt2 /* skipping bypass/abort */
    free s1_hwpt

> +smmuv3_accel_install_nested_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,\
[...]
> +    config = STE_CONFIG(&ste);
> +    if (!STE_VALID(&ste) || !STE_CFG_S1_ENABLED(config)) {
> +        if (!smmuv3_accel_dev_uninstall_nested_ste(accel_dev,
> +                                                   STE_CFG_ABORT(config),

This smmuv3_accel_uninstall_nested_ste() feels a bit redundant now.

Perhaps we could try something like this:

#define accel_dev_to_smmuv3(dev) ARM_SMMUV3(&dev->sdev.smmu)

static bool smmuv3_accel_dev_install_nested_ste(SMMUv3AccelDevice *accel_dev,
                                                int sid, STE *ste)
{
    SMMUv3State *s = accel_dev_to_smmuv3(accel_dev);
    HostIOMMUDeviceIOMMUFD *idev = accel_dev->idev;
    uint32_t config = STE_CONFIG(ste);
    SMMUS1Hwpt *s1_hwpt = NULL;
    uint64_t ste_0, ste_1;
    uint32_t hwpt_id = 0;

    if (!s->enabled) {
        if (s->gbpa_abort) {
            hwpt_id = accel_dev->vsmmu->abort_hwpt_id;
        } else {
            hwpt_id = accel_dev->vsmmu->bypass_hwpt_id;
        }
    } else {
        if (!STE_VALID(ste) || STE_CFG_ABORT(config)) {
            hwpt_id = accel_dev->vsmmu->abort_hwpt_id;
        } else if (STE_CFG_BYPASS(config))
            hwpt_id = accel_dev->vsmmu->bypass_hwpt_id;
        } else {
            // FIXME handle STE_CFG_S2_ENABLED()
        }
    }

    if (!hwpt_id) {
        uint64_t ste_0 = (uint64_t)ste->word[0] | (uint64_t)ste->word[1] << 32;
        uint64_t ste_1 = (uint64_t)ste->word[2] | (uint64_t)ste->word[3] << 32;
        struct iommu_hwpt_arm_smmuv3 nested_data = {
            .ste[2] = {
                cpu_to_le64(ste_0 & STE0_MASK),
                cpu_to_le64(ste_1 & STE1_MASK),
            },
        };

        trace_smmuv3_accel_install_nested_ste(sid, nested_data.ste[1],
                                              nested_data.ste[0]);
        s1_hwpt = g_new0(SMMUS1Hwpt, 1);
	[...]
	iommufd_backend_alloc_hwpt(..., &s1_hwpt->hwpt_id);
        hwpt_id = s1_hwpt->hwpt_id;
    }

    host_iommu_device_iommufd_attach_hwpt(.., hwpt_id);

    if (accel_dev->s1_hwpt) {
        iommufd_backend_free_id(idev->iommufd, accel_dev->s1_hwpt->hwpt_id);
    }
    accel_dev->s1_hwpt = s1_hwpt;
    return true;
}

> +bool smmuv3_accel_install_nested_ste_range(SMMUv3State *s, SMMUSIDRange *range,
> +                                           Error **errp)
> +{
> +    SMMUv3AccelState *s_accel = s->s_accel;
> +    SMMUv3AccelDevice *accel_dev;
> +
> +    if (!s_accel || !s_accel->vsmmu) {
> +        return true;
> +    }
> +
> +    QLIST_FOREACH(accel_dev, &s_accel->vsmmu->device_list, next) {
> +        uint32_t sid = smmu_get_sid(&accel_dev->sdev);
> +
> +        if (sid >= range->start && sid <= range->end) {
> +            if (!smmuv3_accel_install_nested_ste(s, &accel_dev->sdev,
> +                                                 sid, errp)) {
> +                return false;
> +            }
> +        }

This is a bit tricky..

I think CFGI_STE_RANGE shouldn't stop in the middle, if one of the
STEs fails. 

That being said, HW doesn't seem to propagate C_BAD_STE during a
CFGI_STE or CFGI_STE_RANGE, IIUIC. It reports C_BAD_STE event when
a transaction starts. If we want to perfectly mimic the hardware,
we'd have to set up a bad STE down to the HW, which will trigger a
C_BAD_STE vevent to be forwarded by vEVENTQ.

Nicolin

