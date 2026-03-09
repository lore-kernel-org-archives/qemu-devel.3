Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46AD7F4181F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzeM7-0008UP-2I; Mon, 09 Mar 2026 13:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vzeLg-0008Nj-LA; Mon, 09 Mar 2026 13:24:58 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vzeLc-00077J-Vf; Mon, 09 Mar 2026 13:24:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=msWRm3CZzpTO2MOT/JgTPoIxjZTPA+pD2GmATCgI+e8/y5x/c1FYOn1Rsk1/+qkFv9VB0kSORZu/77nKEjux9SHgiUUB0YVzWsXbTWn1NBbY/5xLIVnsdseCKR2hcbz9FX1xGr4LDlpAhY6aQKcPLbJCzohsoCqf3VmNmBrDknaaLkEYsthpBHvMA6qpJFVIMncF4ujRwtxBxiHtWGkVRoJfgxukwgkNKC1HKKW+U/S6NntB//3Cc7CGl6u3CKj9brMuHRe4mC1sJzK5eXso8a0JbpZcjr/jtxJbfmHWkl3PGITHySB2sjjaZeehKeOWghesHmDibB7bdGFakueF5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLDHEfgDj6/YWFYQz7wiVSqAvfzftv3SRl9CUROm9WE=;
 b=cVFPE8AqYmeS3SvxzhRev5ARZePUcLeS5GvLZB/Lo/QoizQGa4HyGWP1yJGUEYiFMcNbfn2h0n+CPJ581Zj/gAeGq8qv+jQ9orCSxh58RNHkBGHQw7P+NM106DzLWWyvsqUlGBwcRaoIRw9CTJiox7djAlyCRlT9WNm6RBnUlzJJ8QN7aBTj6LYsGdFqZXU8HSKRKHa6bzVboA96YMt1n8EyBKZJRzpYXJYnhVikKyULUivaPv+aox6z/zgN9srCYh+4XjI1PZRlo58cpQzxNC3lrsI27SF3BZX37nT9KrTZ3G4udERlGHaMCRRGZTJCnOAJXkhQKCxkuH3gJtWQWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLDHEfgDj6/YWFYQz7wiVSqAvfzftv3SRl9CUROm9WE=;
 b=n6ShJ6QWnB5ZvxHJdbF9GpFyMQE6YyvOeV4/68XzeCAfyBWcPzagG9yuDdBORWAjbmJN50A+WmQ4+nNjhkEi4OYckDzg0z9PNZD7dn+h9Y5RmMEAaNAKBAJ44q4Rz/+7GKZssKajeUIUqSeqmzuGx+CwKaHw4a1f72LIGSm9J9Smfv2FnK6RR7rOiugGxMSuQ2uePZg7jIBnxwyLLw+WFnrGzLXFgElosLHJzP83TyDJ9JCT9lK/nQDf+4A/hl1dUfE/Rr1LB1HDh4uSz8stiyE9iMnRu+w9TEjhovhUIUk4OFL4wfvtXuakWG8zY52FrU54YvW+3n3Xl6asW16+jA==
Received: from CH0PR03CA0052.namprd03.prod.outlook.com (2603:10b6:610:b3::27)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 17:24:42 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::dd) by CH0PR03CA0052.outlook.office365.com
 (2603:10b6:610:b3::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 17:24:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 17:24:41 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 10:24:23 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 9 Mar 2026 10:24:23 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Mar 2026 10:24:22 -0700
Date: Mon, 9 Mar 2026 10:24:21 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <clg@redhat.com>, <alex@shazbot.org>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>, 
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>
Subject: Re: [PATCH v3 22/32] hw/arm/tegra241-cmdqv: Add vEVENTQ allocation
 and free
Message-ID: <aa8CRT0gv3tr5GkV@Asurada-Nvidia>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <20260226105056.897-23-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260226105056.897-23-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|MN2PR12MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: 93bc73f2-be93-4d0e-405e-08de7e00bfb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|36860700016|1800799024; 
X-Microsoft-Antispam-Message-Info: QOUhzU+hxuuc0XleVdlozt9aAgIZSfHGXfFdvo2hgOzMwFGI9OnjDtiOi07K7m6zaPCcjcCNSjRd8CV5q1AoyCkqtp1If0NVjGNR7kBYghUkX4N/U2/AACvmZPHndg/G90OUGJBDgSzRsqkcltJ1qKkn+u+CtUhVI9zg0RRFRLzchOK2JiCV3yedYqdapfHIb2kQL0ZxoVj3GUJoAL2Ew3t0iXi0hvutmLyNRSg5P/t5J1Z0VaYbMzmlChB1GPEVFogbRF3naKqcv8hIlmbwlaqSH1B2IUACV2KQM4Coz7aCR9Op3ofqkBShL0HTlch7TOQAqA+bfspoLzBn/YsAMdt6f4fm+7xaoXOs5y4El770DmrVd7fv0e6vGZA+/KWcHShX7pGWL7M1dQ84hHwQ6D6YVZQ56Q0LKAT7FxhqMn1QQalmK2+eN4Wc8AX0yNFBOYIsdL42xERNNtyyAy9F6bRGAx7B9QzqV608t4En0nuEO6AqNrrk0dDl7aaDT4qprBuVgRswuR48C+CRosAniNA679kyhZgXABX98SVAGlqCK+Rd7CuLbWh/J4VL/C+ZuNOKupYKStMuSAS0wOxnEmTLC7ROZ8Ut5vhNWf/lOAdtFBI9zKdERhQFV3hr9pKswJnOyboB561fi/mO6HoXL9huYnpMAQqFa6W4eBlhQHpXcpMcIoqzf38VWw++Zd1Yn5xZNb+Xvv4FHfiZn+lrpRK1U5QcGJfB8qcuBL9l7f9rb4y+8CDp5orT3wzMl2X5+eiZu7keDy5+Ui8TihhjAw==
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: L6GcmcS+20s7cxHwNe3fZjYkWsc3lnEx3tiWmY9FIqGBsS3SnXFnRFhvG+bobmTQ07T46XBYRzapuluJE72XHM/jnS9gdLZAUU4if80IW6OFSo8zXMVnCZKC9TwmIAcf7KntLPWQIFcnBoqUDYGYWCd95UiI19ctMvkth2C4x6MQ/jF0On42Q3qjFINOpTQWbB26Ah0OeEjXbMloJdmOTFHfJrw8QpoBSg0QSmvblFTb4r+lffFrw19i2xnD2nzyF0JfFKUQjtGx3dSUJwa93FVTjCypap0Wr0e0FTd3U7PwGPSUk1BELG6QQoBv3nwGP8zH3s5JNi2GIJXb2RZMyYNyij0jEs4THi4+QkDjjx+f37g56gncKaqtKxbAPCLMj3Z+fHaPKUOc4J6VVc6E6VtRLtn/Y75UnKPeYzwtWDjpg3FtOz1vaEIhV5TjonWq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 17:24:41.3048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93bc73f2-be93-4d0e-405e-08de7e00bfb4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=nicolinc@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Thu, Feb 26, 2026 at 10:50:46AM +0000, Shameer Kolothum wrote:
> Allocate a CMDQV specific vEVENTQ via IOMMUFD, and add the
> corresponding teardown path to free the vEVENTQ during cleanup.
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.h   |  2 ++
>  hw/arm/tegra241-cmdqv.h |  1 +
>  hw/arm/smmuv3-accel.c   | 10 ++++++++-
>  hw/arm/tegra241-cmdqv.c | 47 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index 7d6e4c6b76..4bff90e2c1 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -28,6 +28,8 @@ typedef struct SMMUv3AccelCmdqvOps {
>                           uint32_t *out_viommu_id,
>                           Error **errp);
>      void (*free_viommu)(SMMUv3State *s);
> +    bool (*alloc_veventq)(SMMUv3State *s,  Error **errp);
> +    void (*free_veventq)(SMMUv3State *s);

As I replied in v2, this should really depend on viommu and should
be simply added to tegra241_cmdqv_alloc/free_viommu().

The alloc_viommu is an override of the standard viommu type, so it
might be useful to have an op. 

> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 4373bbd97b..f6602f51aa 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -576,13 +576,21 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>          goto free_bypass_hwpt;
>      }
>  
> +    if (cmdqv_ops && !cmdqv_ops->alloc_veventq(s, errp)) {
> +        goto free_veventq;
> +    }
> +

But, this veventq op is completely in parallel to the standard one.
There is no need for the smmuv3-accel to initiate the allocation?

Thanks
Nicolin

