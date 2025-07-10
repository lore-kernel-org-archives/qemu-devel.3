Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852E8C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 17:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZvQy-0000OT-0i; Thu, 10 Jul 2025 13:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uZuk9-0000BY-SI; Thu, 10 Jul 2025 13:07:46 -0400
Received: from mail-bn8nam12on20606.outbound.protection.outlook.com
 ([2a01:111:f403:2418::606]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uZuk7-0008Pf-NJ; Thu, 10 Jul 2025 13:07:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QVjZ91SVBOn2HDKE0y7MPmg5H76WSHhn9XDMrdp6cac7HLddU15Ez3TFewOdBX9WJUWo22Dk67s0XMJ6vaut5YgFTsrKRvSwSArndpwgyb/GvZR7Wa9BWlsjQESaXk5dKCP+H+1t8oepJ090hvbChz7mUcHc7QrFJbksqHclbqet85DBvxY5RwzhU8ntH/5a6hR1wfurt0TglolUxfwkh/FCHdrhN3E0s333whjC6qT6/n+JS6txDsJlLUWvXs+ySycNJVyZoTjRQnkACuEOe+HZFnKc+r2hqqALA/9ZYMqcvj+BeSVwNeBpat+AaMKD88AYqfrZakXFwIbAOrCF/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8w/w1z/Nd5D8La0MLKtab56GJrVjawEQnAA02zpoJUA=;
 b=gRWSd16q5Se11qAzlRf9RaRqzQ7hMKgyLFaMa26U7jk4xnWrBo8JZMlSlYLNDml9K7LNWNUv8GE20UikxEiOP1QoKA8B/GHk/d1iy+Gh7GYecJcCyHoxcrwm2JwO/rK7jkudcZ9lqTH0vyah/LraiSL7pGoN9HQfxNm2ns3uTD1yRPR+sWttn7Myoghbp5AnWU3NWdsRfUbE5/LlcvxlStW6p3sEkGBS/dFY2pkzWtECeAsG9MlLcra7HqWkRaB4MNZFUvNVGAmoYVNdi5W6WJPH/EuGIjoDCMWORhGwNnwkzGR1KAy1wSZjnSq2VrXmNoB44KphW2GQ8+cv/YIhLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8w/w1z/Nd5D8La0MLKtab56GJrVjawEQnAA02zpoJUA=;
 b=SZx93rf7W20W9GRT+hQFZc1L7bJ73nvygH1n8RxoR1pKIeoxXk1skiWW9WhHHA5lP8t8pzkjOjNHAQEu+v+f3ztWIVuaJedMhHTcYCB0dWdpri/RpH83L1z1w7lo1LY3fQys2g+cvJTZvlXvncs/vCQ9r4hnPmMDMtJv0v5IuNO1Ah/N65nZ4dUm30ZCC3Ddqz5K2HFEfyazZsT0Qy6vwvzF5UfDFKGMXUylH/bTcP8xig8CJTkplSOfF8YvyJbhniGG8yl6GaJHQx6UegIAH1dRdQ6OuUS1arL4dlMWwV07TcaN8606k+IX3eN4X6xsczaC8Y5zuNFAe6FuSfaCog==
Received: from BN1PR10CA0007.namprd10.prod.outlook.com (2603:10b6:408:e0::12)
 by PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Thu, 10 Jul
 2025 17:07:25 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:408:e0:cafe::3a) by BN1PR10CA0007.outlook.office365.com
 (2603:10b6:408:e0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Thu,
 10 Jul 2025 17:07:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 17:07:23 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Jul
 2025 10:07:04 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 10 Jul
 2025 10:07:03 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Jul 2025 10:07:02 -0700
Date: Thu, 10 Jul 2025 10:07:00 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <imammedo@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <gustavo.romero@linaro.org>,
 <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <linuxarm@huawei.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v7 02/12] hw/arm/smmu-common: Check SMMU has PCIe Root
 Complex association
Message-ID: <aG/zNOJT/5P6xHEB@Asurada-Nvidia>
References: <20250708154055.101012-1-shameerali.kolothum.thodi@huawei.com>
 <20250708154055.101012-3-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250708154055.101012-3-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|PH7PR12MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: b3babfc1-f74e-4de1-695e-08ddbfd43d1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AJ3QHvz5WKevTOl4GkwcCcajLdgPpcIX8WVgkP5dFtZvMxOU2ow1FWhbfyoj?=
 =?us-ascii?Q?RgsTp7Ssh0D5VdNOVODZjodBk8zx+bDUfODeBaZf0OWSnAA1SkDYyun9F54L?=
 =?us-ascii?Q?fHhBmqk/EtEbvETCOTOMKViWAIR8qNqYaTfT9RS/H1l4jprEWt1/IroO+4ll?=
 =?us-ascii?Q?xDHpiYOP6Os9GzvAXUX6US8Ijl7+4Qk5cSpK3YMFTCmOlCmNbhYaGoVqW6O7?=
 =?us-ascii?Q?pHw+VU6i9JQng8cMrfgxG34cfbha1mENwUChsWVlNHo72z3PF8AejKszFta0?=
 =?us-ascii?Q?BiknACwYRws4cENJU7eNesY0qrXmrswL/ft1otZwVkMSH5DjHzQeAd+hHw7s?=
 =?us-ascii?Q?DvGdZ0zTvgseONXlaueO5b/QZlOJGHnPpT5KJh4HHMgBPJr6TAaTGLGidmSg?=
 =?us-ascii?Q?2A6A86I6hpfodR9hvcCD0u9Jr8Z49PTfom4rbD0u0lGl45n5Ygdg3pAlXN/g?=
 =?us-ascii?Q?LNexznNDLheGlvOsVAC0XwGhq7BeqeQUsSxP0hnZPomfne1nvyjOyW7KbCR1?=
 =?us-ascii?Q?PgmbWsy9/15ZMjrBGOfZlpu8Hul4Rk7brR6NxyKf20axZwEbbM6gV2UkHirg?=
 =?us-ascii?Q?YADCUDc1oXeeVoPx4SNsrIq5/AH3mZEaYwupeOuFPUAOe+2gl+MSVMr1o3UM?=
 =?us-ascii?Q?WpnSntRqXciu3zjOLW9ULu4DhSfoc/Fs74wUMbmKEBJAn001OvSb9q98bCH3?=
 =?us-ascii?Q?0T3LpydFoUqJ/i7bIGEENbTFuuFX7hqt1zX96MApZiROHhvbB8+/ZJFXMXJJ?=
 =?us-ascii?Q?ou9SPqCYFbEfpFYIBz0Ex/U9SadmEPDqPHtKt3pWP8tEKspoh4C+3cFMm1Qb?=
 =?us-ascii?Q?1eh/Rkzc0SouSJltPH3wFhLg76xc+E93G3PjgXbbDdaqtLbCeYbzsU2Ao1p6?=
 =?us-ascii?Q?rY5Mg/R8OsPxhswIzVdRyoT9b9HVO8P/T1LQkH8Mwz7HCsF0X5//x9vczOoe?=
 =?us-ascii?Q?/godHu8wJaCf9o4ZF7OudoeICAtxPN1dHTxBSoa6kcbZzXypypS8MJN9x/Ug?=
 =?us-ascii?Q?tO9PQizy58qR4VoqBFScLQn6KU+zO4TkSHb/P1tYv23raQEFjgn+TBVWjaWI?=
 =?us-ascii?Q?KiVXpplJ71I5GzW3jiWEv7DLSkTctwDXgnOpxlav6+YDZRhOSs46x46EIDuX?=
 =?us-ascii?Q?z/94XmuHeg0MB7XZOZFyaHiyO4pgi8S91s8fGo8CVNb6Gg+cGEom8d12AnvR?=
 =?us-ascii?Q?Ejez8CqnzVy7xSKlIxdhlZKNV7PccLjiyNHmkVUlibI0b68AUnjIRI5Lq+++?=
 =?us-ascii?Q?v0VRrWRGZpoHN6m2YaUZKomHycnUe8rhaLme/Q0MWaG8osxDhBFR/2MW+nNT?=
 =?us-ascii?Q?fT/fXf5MJU78F6ve3COemdcLVRvsvjODEHULY05T9pPqQI8jozviLIOZUxMw?=
 =?us-ascii?Q?VmfGzrkkp1vyl5cHLdoJAUc5ikpcQ6oFxcgV4YwkAU5cTBMfVzhUEZ2gKsmg?=
 =?us-ascii?Q?v5XRA6xQnuqzUo3e3z/J7GR3mJWNZJUYif3i4hbqG8oz384NjIbvfbHl6wZk?=
 =?us-ascii?Q?I3Eqra2c0EEXtyFzP+eYcCyE/GgFGaF7PUOp?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 17:07:23.4203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3babfc1-f74e-4de1-695e-08ddbfd43d1f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7820
Received-SPF: permerror client-ip=2a01:111:f403:2418::606;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

On Tue, Jul 08, 2025 at 04:40:45PM +0100, Shameer Kolothum wrote:
> We only allow default PCIe Root Complex(pcie.0) or pxb-pcie based extra
> root complexes to be associated with SMMU.
> 
> Although this change does not affect functionality at present, it is
> required when we add support for user-creatable SMMUv3 devices in
> future patches.
> 
> Note: Added a specific check to identify pxb-pcie to avoid matching
> pxb-cxl host bridges, which are also of type PCI_HOST_BRIDGE. This
> restriction can be relaxed once support for CXL devices on arm/virt
> is added and validated with SMMUv3.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Nathan Chen <nathanc@nvidia.com>
> Tested-by: Eric Auger <eric.auger@redhat.com> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

With a small suggestion for clarification.

> +    /*
> +     * We only allow default PCIe Root Complex(pcie.0) or pxb-pcie based extra
> +     * root complexes to be associated with SMMU.
> +     */
> +    if (pci_bus_is_express(pci_bus) && pci_bus_is_root(pci_bus) &&
> +        object_dynamic_cast(OBJECT(pci_bus)->parent, TYPE_PCI_HOST_BRIDGE)) {
> +        /*
> +         * For pxb-pcie, parent_dev will be set. Make sure it is
> +         * pxb-pcie indeed.
> +         */

        /*
         * While pcie.0 doesn't set the parent_dev, either pxb-pcie or pxb-cxl
         * does. Re-test the type to make sure it is pxb-pcie indeed.
         */

> +        if (pci_bus->parent_dev) {
> +            if (!object_dynamic_cast(OBJECT(pci_bus), TYPE_PXB_PCIE_BUS)) {
> +                goto out_err;

