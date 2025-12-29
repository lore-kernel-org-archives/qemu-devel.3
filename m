Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671A6E92FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 19:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaIvb-00073c-Pm; Mon, 29 Dec 2025 14:29:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vaIv0-0006wc-V3; Mon, 29 Dec 2025 14:28:42 -0500
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vaIuz-00060v-8O; Mon, 29 Dec 2025 14:28:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGubPDiua11KG5DhKsLIj7rtkE8bUQ8xffAqaqbFMpCP5bJ3SwwU7pq0runfJgVIehqmxG7LrzVqkrHv2B/tb3c5yllW517bSEQS4Oh1zahwW7fH0oXrFz7NyM1T4r7rpK8W+/Q3JAk5Q/bnv1jc6iO/+RH1cAgpRtF/uC70/Rc2CieOF7zJuxfURfzk0uYYXFT9wBtbvfwD0CSMhuRtYqzsEy6mxOJllCVWIx8h8Obp2X3H9D+pvllgS/Geeya5bYxnAakFgMq3AHptzzFIQHzJQ82TrHBeP3bg/7E1dqDBgR8MTOv8hoqAcSmTCjSjxJxV996rgEj4zpxWUTar8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7v2xavG1N8Cudz0aOj0F5j+umOaZorTKBR9YTBxLSCE=;
 b=eJkA+IZmrgpEnVUoqm82ALFsuarPL/hT/t1khTFrqlzJXJjA3eyoZ78l7I4FYk3InMk+6jJsEwKKczteaIv3o6nS/gEbTTJCzfVncqkXEJ2fjPJtqaGt21wMqXuNsuTSXQeQ448fhCjv4POoEV2EZ8KwG1BSEcB5Criro3qEQSSlLQ+1t4S/3NR9TT0Tt6fxbRPBA+aVMGQJTKDlKQMLMvq/P9gG4YT9kVvMmABNiZ6UFmX67JKS/sms5GEEol1Ae8KuIvBfI1FCf5n0aFIKzPMRSLdM3AKSjK8/4JvqTHOdg8utAzFfR4gDDr9uwpny8oQ08HhfoxgREHT/Fdkhmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7v2xavG1N8Cudz0aOj0F5j+umOaZorTKBR9YTBxLSCE=;
 b=kCw5VOXR2C8ZV8/0l3H1uL5VPXy+WxEKTFAtZ7l0cOzMHbxiETY+D8OEUyOXyuacQNbgInphraBabBWSDP70PBxmNePpS/x5/g0jBjI3LwVqQ7/gLD2NsrZ7cpYAZvYVUipbT+MCDJJV/anWjx+4OBT3PPNsWeoONvj5IUlwF3igi/w4jOPXPWBUlVz6/9C72LNfyrwTdEPlyfGXKc71TNaJIBUml/xxtFEVe8YUV9G0gVTTqAcnXK18LKVTJurzaHd1n36zBvZs7STNEc38TPAR001LuPHV4R2/KzAmYDO1hivJBgn4qIHig6m283zUDaAXqcirveqcPcQElt69sQ==
Received: from DS0PR17CA0011.namprd17.prod.outlook.com (2603:10b6:8:191::13)
 by CH2PR12MB9459.namprd12.prod.outlook.com (2603:10b6:610:27d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 19:28:28 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::a8) by DS0PR17CA0011.outlook.office365.com
 (2603:10b6:8:191::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.14 via Frontend Transport; Mon,
 29 Dec 2025 19:28:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Mon, 29 Dec 2025 19:28:28 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Dec
 2025 11:28:13 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Dec
 2025 11:28:12 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Dec 2025 11:28:11 -0800
Date: Mon, 29 Dec 2025 11:28:10 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [RFC PATCH 06/16] hw/arm/tegra241-cmdqv: Map VINTF Page0 into
 guest
Message-ID: <aVLWSp9JCEjXnjvr@Asurada-Nvidia>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-7-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251210133737.78257-7-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|CH2PR12MB9459:EE_
X-MS-Office365-Filtering-Correlation-Id: 92eb759b-cada-4971-a6ee-08de471071ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R10MjljLWWdBvcWby6GeYEJSBOOQyfjgglvZ7EL5Qf79L8VpeC+GQj4w/R+X?=
 =?us-ascii?Q?tYR7ULo2iCCHJlfZU+9amPcazNysXVMrb8kH2FUl2ENeylTwg1oL/uamGd4d?=
 =?us-ascii?Q?BR8yWDDXg5d8JUO0084XxXzzT/yuQ8+2NYEmCl9/VEVYKJwlTp/+WV7qg5EC?=
 =?us-ascii?Q?eKw5nzhfMirqDJkcSjSaX8AoPlwr8Qff845MlaC2hVimzFhLSrRnmxzL+CIF?=
 =?us-ascii?Q?5j/uUs/q0Sj9HhN4fkQcvmp3MbmqfwwVl81MBYEpGHqZxGox9fctM3j3W9r4?=
 =?us-ascii?Q?KnTdBSLAz/ahuZ+uNCWgcn5h70G04T4XrRZcHpZ7SRW4r5D7dcLJklufMGe0?=
 =?us-ascii?Q?jUaSARifloZv1M/a+71sQnn/i9qwBbHgpa4d/kRPEoDrE8HGArk9pQaKeKjc?=
 =?us-ascii?Q?p87eFmW07UK3U5FIyPwQV6Z8bU2sB7lqMX5pnmlrsSKxC73WIdgbFUCQQ3sa?=
 =?us-ascii?Q?qXYgvtx7g18BV8a52HMxKRS0MpG3bQkNqJanYEF7viMsT7yM1lUgUmoVL8b0?=
 =?us-ascii?Q?7Xjb4+5aTenE9mlDSW8qePYYbBv8Xtf3xaMUDGVNdnsQgqwSfV8/j27n1V9I?=
 =?us-ascii?Q?MYaEgGEzBfE9f5vaTXVbd1g6iyQUqeVvVxYXfKv0XH+IYvI51SueHDF6nGJE?=
 =?us-ascii?Q?OxYPz3N2FhssP5peSmTnmUGoAe8/xXLVGl/osYDqtulLAxye/NpQ6VP5cyw+?=
 =?us-ascii?Q?jayqhPg68OnNXhaEQaYFDoRsIX/ZuIJS8XQPPh5MBqJI5RbrXSI9IUr6OohP?=
 =?us-ascii?Q?vWy7nVa8GDG/84IUj8RtsS6g8THVy6a/+WXdRwqfX2x8bNwhkL4aYPi3ttzp?=
 =?us-ascii?Q?17QjDL1fjhgrvSOUtSFqi9a8g/ti4xvcCdGXBoh88ViAkcxTJC8iWouE7Im5?=
 =?us-ascii?Q?QC5AJorReYIjp1CUenZWNluqTKV8K2ua3ls7FyyhUOqZjGTI0gh7gC0WVKl/?=
 =?us-ascii?Q?M6tOjkHZOfnTP2f96AGIUDXR7tZ3klliEHWuQWu+ztzWk0KxXNuZPz1fZJ70?=
 =?us-ascii?Q?BO7eOA8tDPeghhdfPshc9zVRgk7IjhMvXJhPJcOja6F4GVk0hbBYqSR+DMv5?=
 =?us-ascii?Q?tPOe9FpNOlz7/rhFqDtUvU9IkWkVf7jwbRd1iTDyzSR/PhQeldySKUJ805Dw?=
 =?us-ascii?Q?cxcgyDwk16aB/z5nX6waBGzNVBWrTcr5VljDYi6YVsnNMKdIyrtvg6V/LekE?=
 =?us-ascii?Q?cNU6uw4YpJU1mHCVIVMBg9ddtoEiYlqPGoS7dDzLZqpmONfzHftP0doY1vKT?=
 =?us-ascii?Q?ExaPLa3k2RIYMp3ogYP1iQmPdZTf5rm8hG9KbuTP4sJIKEV1lb56SO82rnLM?=
 =?us-ascii?Q?rqYuLS80snan/oX7GFLmFmfzzSQtlyT88+6j/aTMF7Yj+vc2UXVbUD1/IwW6?=
 =?us-ascii?Q?T5djV9zXTZeBIRF8OZTWN3dT/xuzklQEg47zYP4v18fozoZLQfQidAA8oNIf?=
 =?us-ascii?Q?hhxk8ent6BHmwjClKJE+bXXHdVdlG990q/sp0prn3l2uHZTB/4fZEy6pmVlQ?=
 =?us-ascii?Q?Gad8AM4Z2s/VdZM39lOAocsOMihIlIxHf1ncYXKnNApblEwcCVXc2WKRg1ur?=
 =?us-ascii?Q?VBOA5CRqfMI8QNkljpo=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 19:28:28.4019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92eb759b-cada-4971-a6ee-08de471071ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9459
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=nicolinc@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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

On Wed, Dec 10, 2025 at 01:37:27PM +0000, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
> 
> Tegra241 CMDQV assigns each VINTF a 128KB MMIO region split into two
> 64 KB pages:
>  - Page0: guest accessible control/status registers for all VCMDQs
>  - Page1: configuration registers (queue GPA/size) that must be trapped
>           by the VMM and translated before programming the HW queue.
> 
> This patch implements the Page0 handling in QEMU. Using the vintf offset
> returned by IOMMUFD during VIOMMU allocation, QEMU maps Page0 into
> guest physical address space and exposes it via two guest MMIO windows:
>  - 0x10000 :VCMDQ register

global VCMDQ MMIO pages.

>  - 0x30000 :VINTF register

private VINTF MMIO pages

> +static bool tegra241_cmdqv_init_vcmdq_page0(Tegra241CMDQV *cmdqv, Error **errp)
> +{
> +    SMMUv3State *smmu = cmdqv->smmu;
> +    SMMUv3AccelState *s_accel = smmu->s_accel;
> +    IOMMUFDViommu *viommu;
> +    char *name;
> +
> +    if (!s_accel) {
> +        return true;
> +    }

g_assert?

The entire thing can't work without s_accel, so returning true
doesn't seem to make sense.

> +    viommu = &s_accel->viommu;
> +    if (!iommufd_backend_viommu_mmap(viommu->iommufd, viommu->viommu_id,
> +                                     VCMDQ_REG_PAGE_SIZE,
> +                                     cmdqv->cmdqv_data.out_vintf_mmap_offset,
> +                                     &cmdqv->vcmdq_page0, errp)) {
> +        cmdqv->vcmdq_page0 = NULL;

We probably shouldn't nuke the vcmdq_page0.

And I think we should add g_assert(!cmdqv->vcmdq_page0) too. It
would be a bug if we pass in a valid page0 pointer.

> +    name = g_strdup_printf("%s vcmdq", memory_region_name(&cmdqv->mmio_cmdqv));
> +    memory_region_init_ram_device_ptr(&cmdqv->mmio_vcmdq_page,
> +                                      memory_region_owner(&cmdqv->mmio_cmdqv),
> +                                      name, 0x10000, cmdqv->vcmdq_page0);
> +    memory_region_add_subregion_overlap(&cmdqv->mmio_cmdqv, 0x10000,
> +                                        &cmdqv->mmio_vcmdq_page, 1);
> +    g_free(name);
> +
> +    name = g_strdup_printf("%s vintf", memory_region_name(&cmdqv->mmio_cmdqv));
> +    memory_region_init_ram_device_ptr(&cmdqv->mmio_vintf_page,
> +                                      memory_region_owner(&cmdqv->mmio_cmdqv),
> +                                      name, 0x10000, cmdqv->vcmdq_page0);
> +    memory_region_add_subregion_overlap(&cmdqv->mmio_cmdqv, 0x30000,
> +                                        &cmdqv->mmio_vintf_page, 1);

Let's add some comments here (maybe something similar in commit log also):

    /*
     * Each VM can only own one VINTF exposed by the kernel via a VIOMMU object.
     * And all available VCMDQs are already preallocated in the VINTF. Thus, the
     * global VCMDQ MMIO page0 and the private VINTF MMIO page0 are effectively
     * the same, i.e. cmdqv->vcmdq_page0.
     */

Nicolin

