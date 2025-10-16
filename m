Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3715ECCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 23:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Wwn-0004VS-4e; Thu, 16 Oct 2025 18:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1v9Wwl-0004UH-Eh; Thu, 16 Oct 2025 18:59:47 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1v9Wwh-00069h-Ph; Thu, 16 Oct 2025 18:59:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6/j89+8dyiaEfdHq+u0q9bHQD55SB8DV8NPyqFDKd6ubSuMnC/Z0iYYmMxYiSQG/dZCFYXjXcu+UKxDP8N7B5ce5sclCj+fmpNDxMJyP7THwF6XIsDKNruSn2ynZwRLNOPPq/T8fi+aBE9dXLC1hWRqN0Jtypwr9mkOLLbF4Kr+EktjQx1O37NhKUn7KDQ0C7SlWb/jGq1utkp+OvVvDrJ8O8ABcqq2J7vMuwMp1uVdROB9rR2VjInfAOqJTgaVSRd75jpmMvdKlepVbV3xoOJHcq0MkXIazZCK3EIsHsU/wEEv9KG2balAjuvroPhcqqmY4pO55xXY4LayzsaR3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXqpW4Pe8cpc3A0aB6+Kb/geyyQek8M7OEuYE8DvwtU=;
 b=ZY8Z+ew296Y8pxsmxQko4ndNmv6u79R9B5StJfcunOuyz/iy0Xq35hdX4svy6aoDHE88CUiFu7+DZqup4lQ5rf3a+REY5sX1Qz9CxGJMei/bOP1E76QzpHhDobkMeWJfcp8ndUAthsqIp5e5jV+hdLre6HGr7Gaj8K7QOAIRALoRtxjnwua884HULjbjn+TXoTgQTRYgVhvWJYjfHmhOMKzD77Gw1SPvY6a/YkejdA6tXFVhkOVIBuGasfbTXd/vhuyi91nWsazrKsqXEd07K1xtdisZ6lrgLhVYsNnPUZAfQdpX41aWChSL5SqlMxfQ3krx8TqlXTZLWhuig7iazA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXqpW4Pe8cpc3A0aB6+Kb/geyyQek8M7OEuYE8DvwtU=;
 b=VL1zHo+7n1LJc0JcDVXcrcKClT79J7I1Mu9+YYA81gUptYeMMs2W7fu3Bcue013pmk9+dwEM8rKiworXBcbVnp9T1MtDMjYub0pSskC4/OI5uVMAmaDzCcb1Dyrw9Mwzp94+TalSOTSp5iPzyl6X/eWqBTrMxBbcr40ThG7MiXEcXEOTfi2Xk2CahSAbw+ZYdozvl1P4UZWA1l1wAvA+pm/vKc5ADL2wJq7J1xGBk2X6Zo/x3O2XNvTkXSLD9VRTljRZia5TGwhSJbFpGhlzv+eb5xFDppMdcFEmJw+WGPyhhnXCxye+DyVTpDbXczW5RT/en7SEg5Yy099fQSI89g==
Received: from DM6PR12CA0010.namprd12.prod.outlook.com (2603:10b6:5:1c0::23)
 by SA1PR12MB6680.namprd12.prod.outlook.com (2603:10b6:806:253::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Thu, 16 Oct
 2025 22:59:37 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:1c0:cafe::4) by DM6PR12CA0010.outlook.office365.com
 (2603:10b6:5:1c0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Thu,
 16 Oct 2025 22:59:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 22:59:36 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 16 Oct
 2025 15:59:26 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 16 Oct 2025 15:59:26 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Oct 2025 15:59:25 -0700
Date: Thu, 16 Oct 2025 15:59:23 -0700
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: Re: [PATCH v4 13/27] hw/arm/smmuv3-accel: Add support to issue
 invalidation cmd to host
Message-ID: <aPF4y4+/jeZN1ZE5@Asurada-Nvidia>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-14-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250929133643.38961-14-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|SA1PR12MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: af25cb16-8fb2-42fb-b0c8-08de0d07ae18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|7416014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?TWh83CrKE2MJnJGNw1X2c/ijao5wXCmnRH6t+Bo/NCLIOu5E+zB2hGG4of?=
 =?iso-8859-1?Q?y1swsefzT7D+cV0HwUV3Ppw6PdorsGv8aUO2809xhk1RpuilFG/C4blfaC?=
 =?iso-8859-1?Q?PZzgxarmGG5kugn8tLZ4+X+tBp/ZvwIE3yW/Eec3UvGulV7UpURsocQ3bD?=
 =?iso-8859-1?Q?wdK6zhSMFG1HvyLBCiIR8ohyvI0JSxMI4y4UT+VdU/A7JjFzXvsIrcpkWY?=
 =?iso-8859-1?Q?vlWFnXmFa3JxFfkZ/XcESN/Vu9uTF0ro6gcuAJYoNqaCbVjf6h6YLqyVOW?=
 =?iso-8859-1?Q?5cnVAOZp+/hNDmzWcSQyEoqTkad5872GfZLoozuQCLCqUX2UtTxnZH4uTD?=
 =?iso-8859-1?Q?pSGDLm9gYwpuZiqBpauHBhPh+m7dWuIETT4qketpZIIbbWzX0drnQX6Rzs?=
 =?iso-8859-1?Q?fqNmTcuWAok0vIViGuZqRcNDgNKlEIce/ttZxc4rCsWJcKPVWdAJFMR9m+?=
 =?iso-8859-1?Q?Gc/Zjuphi+Khp7C8KhpFgQX8NQ76glxHMKWMRGm+YpwuVJeGBtYeMoY5Br?=
 =?iso-8859-1?Q?gJnX8uXvIHB3s0O3lqc7bvjHtd5o2QM3aavdy4YQpW9i6EFWxt82rswlij?=
 =?iso-8859-1?Q?Z3+0YyOu5ZKaRmEQqab8boORFmjmbxpIiLHimHraZRtV+FNoqZKMOG4A5v?=
 =?iso-8859-1?Q?/woNuRDQr++5iXdifXl08d2J3SCIF95yf1C+gr2GHBHWVTzKpkQlc/vnXC?=
 =?iso-8859-1?Q?5QxlIm2JGivu3CpRPFlkZ/6LT75pp50NdqIAeyIKRStUfrTKeoqPIvruYM?=
 =?iso-8859-1?Q?xOyxdgIvHQVdH5r2EutQVdXP2jCVELYo6JwL7/G2W0xiQArpWt7Oiin1R8?=
 =?iso-8859-1?Q?i981RMlTP+pN46+KhPvZQhJ3/AEAF6eO1kM05hq+E6U1mS8yjUIILMTu06?=
 =?iso-8859-1?Q?YNqRKGgUMlJjFV7hxcxI31IZBVCom8FtGvIYbxbGTs36PjPzstyxHaTxaQ?=
 =?iso-8859-1?Q?S0TUdK8s+XfaxDrHQR1S21Pzwf0aihrVA3TShDIjMXQVucU2USH5CLqAOU?=
 =?iso-8859-1?Q?lNh7mmatDSSGzadR7kNGgFxDbDkOIzDI7nQExV2PnisHh/uC/1193ebmbW?=
 =?iso-8859-1?Q?l0/BOpkkd5Yf2E8jq3uW3n3XDj40nO1iWzkLbAQurb1biFCgssQV5KG93U?=
 =?iso-8859-1?Q?ccBxxKMdtRlTQq1vKA3mWPks2yAIzWl7kjWeX1QJVP0RQ0/wdhO+AlUs9V?=
 =?iso-8859-1?Q?p8sPh9q02/JDXVXJzNwCYyYOwnyHi5znlrqAb7Z0ON0hCeRj+eBpQbXdDt?=
 =?iso-8859-1?Q?ben5CATgBMDJnVlwWBQrnnn49cOl12BweIvtfyCZs0QmlXbI2eiJVgWnor?=
 =?iso-8859-1?Q?HF0hCnabPVR5r2wwaLnKxiDAthGfjeaLYxVG2BB0eUE7q5GtSO1be45o5E?=
 =?iso-8859-1?Q?8kGkHyVdhXYezsWpNyPx2L0MbgXE4IF8WLFEN1HcC4n+pIbsp9y+WhST8N?=
 =?iso-8859-1?Q?GFmjUBdZDMMBTvTzoUEED7ilPqPTSIVeN6fArnEUdohtkecbbA918L6Fky?=
 =?iso-8859-1?Q?oCr1UqpPZNmpxcrb++03bdYRfEFhZIaNcNg/ZdPhK+sq+1f7NUTw4Kfiyz?=
 =?iso-8859-1?Q?aLztspxShfQZhxanWXs/BBI6SRNVuGithWOqYcvD8xo+DYZVP1oDxYftwk?=
 =?iso-8859-1?Q?yRHx5i5ly9ltE=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 22:59:36.8700 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af25cb16-8fb2-42fb-b0c8-08de0d07ae18
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6680
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=nicolinc@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FORGED_SPF_HELO=1, KHOP_HELO_FCRDNS=0.399,
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
Reply-to:  Nicolin Chen <nicolinc@nvidia.com>
From:  Nicolin Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Sep 29, 2025 at 02:36:29PM +0100, Shameer Kolothum wrote:
> Provide a helper and use that to issue the invalidation cmd to host SMMUv3.
> We only issue one cmd at a time for now.
> 
> Support for batching of commands will be added later after analysing the
> impact.
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c | 38 ++++++++++++++++++++++++++++++++++++++
>  hw/arm/smmuv3-accel.h |  8 ++++++++
>  hw/arm/smmuv3.c       | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 76 insertions(+)
> 
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index f4e01fba6d..9ad8595ce2 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -218,6 +218,44 @@ bool smmuv3_accel_install_nested_ste_range(SMMUv3State *s, SMMUSIDRange *range,
>      return true;
>  }
>  
> +/*
> + * This issues the invalidation cmd to the host SMMUv3.
> + * Note: sdev can be NULL for certain invalidation commands
> + * e.g., SMMU_CMD_TLBI_NH_ASID, SMMU_CMD_TLBI_NH_VA etc.

* Note a TLBI command is passed in with a NULL sdev.

> + */
> +bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
> +                                Error **errp)
> +{
> +    SMMUv3State *s = ARM_SMMUV3(bs);
> +    SMMUv3AccelState *s_accel = s->s_accel;
> +    IOMMUFDViommu *viommu_core;
> +    uint32_t entry_num = 1;
> +
> +    if (!s->accel || !s_accel->viommu) {

    if (!accel || !s_accel->viommu) {

> +   /*
> +    * We may end up here for any emulated PCI bridge or root port type devices.
> +    * However, passing invalidation commands with sid (eg: CFGI_CD) to host
> +    * SMMUv3 only matters for vfio-pci endpoint devices. Hence check that if
> +    * sdev is valid.
> +    */

I think we should use "allowed" over "matters".

> +    if (sdev) {
> +        SMMUv3AccelDevice *accel_dev = container_of(sdev, SMMUv3AccelDevice,
> +                                                    sdev);
> +        if (!accel_dev->vdev) {
> +            return true;
> +        }
> +    }

And we could simplify with:

    /*
     * Only a device associated with the vIOMMU (by having a valid vdev) is
     * allowed to flush its device cache
     */
    if (sdev && !container_of(sdev, SMMUv3AccelDevice, sdev)->vdev) {
        return true;
    }

> @@ -1440,18 +1452,36 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>              QEMU_FALLTHROUGH;
>          }
>          case SMMU_CMD_TLBI_NSNH_ALL:
> +        {
> +            Error *local_err = NULL;
> +
>              trace_smmuv3_cmdq_tlbi_nsnh();
>              smmu_inv_notifiers_all(&s->smmu_state);
>              smmu_iotlb_inv_all(bs);
> +            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, &local_err)) {
> +                error_report_err(local_err);
> +                cmd_error = SMMU_CERROR_ILL;
> +                break;
> +            }
>              break;
> +        }

local_err is not used but only only printed. It'd be cleaner to
move it inside smmuv3_accel_issue_inv_cmd(). So, you would not
need to add "{}" nor have an "Error *" parameter in the helper.

Only cmd_error should stay.

With these,

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

