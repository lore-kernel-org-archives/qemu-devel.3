Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72486ECD6D3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 18:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqEuW-0006VM-Kh; Wed, 11 Feb 2026 13:26:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vqEuG-0006RS-5O; Wed, 11 Feb 2026 13:25:46 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vqEuA-0005ZP-4g; Wed, 11 Feb 2026 13:25:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FaL4goAVaXge4oWeXtrE0CB4QMxek8raOZ1s9rVq/RL7MubQxrYn1CUWcYMdcyrkfY1u1rDwb+pvkfDiQFP7GVB2FBHH20/iIfOfs1PqfLlmcOGnF6Cq+EcwldVkj+0HTB894IkS5/Tn430DsTuKIfUX8hdrPBziXS4gRCgIecRvWXOnKfaAUX40aLf4peBTPFZDHnI4rtUUpqyGlBU1My2svQiUMiU7Gg4t+dQIQiNNfmX3TzJpzHBCvGRCzMsGqXUvdv3LCTrMfpnLIYg5KdZYKMmfRXvRoPEpHvTt1Djzy3BK60g2UXcv/iLMD0mD7yjpLdTD8VM8E4SVLvsH8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17EStO5SIcy99X6xHOY4bQY5vy81kx5+ztT4xQJKaCM=;
 b=x4efxYmrcyJlwOLcLdjNoZOvMRdHkGWQuNkndSYagDjncvht6PPmpxxDI9AKzO35zKP4PZMHucTswEWa+hJcgKO/nTjxXZipt5pBY4c3EvOJp/ChmoGHa7Bw2i8X5Uok0ftevZCYUklmQOJd0xRKHQvJJh8KdIyY4RQAwK7Puz20rc7PvJkUfqDd1lj2DvNdrZvUYMFLp3lHmcSnFZr8FwL6sZIP/JZpTEut+zbXi8KWuYz1vRaH+i1eCM7t5S59qgYA63u2yhf+gFEuMsJDwY2MSOuklhRfjA/AyxEhc4vXqjbm8YXV8JAQ6yFXuRSxzoYvLM0nOa72hmhw+KDn8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17EStO5SIcy99X6xHOY4bQY5vy81kx5+ztT4xQJKaCM=;
 b=QuVBv+qw8d+dpVLLo/UTQbvnoUAFWI+oq1VZxm2rTidE51WnjP7gTKCgwJlKiZ2gUYOR/nvR+2fI+KOMso9JC0V9Lw4MFzdC1lSl7GC8C4G1/JKRSlPxyXyYxJDAQeUZaWVEQLHCk7Z0yxcSceB+dsMTtBrV1MkuRDHgh/Iwc0TrQmHApNHGNi4yHel6FTkFB9KxwICh+M50LsV9D4VXt/UnqoGrsvihlhFJF6gRk8Inj0R+kDUrdN2RnJB+iKBKvqf/0tlOuM7pI2aX+TvSq4En0rp4KcL8ZU0jO7+d9Mo6BpnsFb1xfiBXQV1HQ7KpoT8ykbXWy2eMO9810BX6FQ==
Received: from BN9PR03CA0408.namprd03.prod.outlook.com (2603:10b6:408:111::23)
 by IA1PR12MB8468.namprd12.prod.outlook.com (2603:10b6:208:445::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 18:25:31 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:111:cafe::9d) by BN9PR03CA0408.outlook.office365.com
 (2603:10b6:408:111::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.10 via Frontend Transport; Wed,
 11 Feb 2026 18:25:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 18:25:30 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 10:25:10 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 11 Feb 2026 10:25:09 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Feb 2026 10:25:09 -0800
Date: Wed, 11 Feb 2026 10:25:08 -0800
To: Eric Auger <eric.auger@redhat.com>
CC: Shameer Kolothum <skolothumtho@nvidia.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v5 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
 accelerated SMMUv3 devices
Message-ID: <aYzJhEFg/zxtrJ8z@Asurada-Nvidia>
References: <20260211083415.133534-1-skolothumtho@nvidia.com>
 <20260211083415.133534-4-skolothumtho@nvidia.com>
 <aYzFeMh1szhJlJJk@Asurada-Nvidia>
 <e66e82d6-0953-49f0-9d84-bf2776e8f3ce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e66e82d6-0953-49f0-9d84-bf2776e8f3ce@redhat.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|IA1PR12MB8468:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c41ddc2-69cc-449d-3d5b-08de699af047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?hM3wE1ZZXPP6PdGTzLI+xTdJCFWfAeQSihUflhF52dUnYDv9qOv8CEtn5G?=
 =?iso-8859-1?Q?DSU/bx2vX6242SRtTGp7rhddp2LtyJBD2LLv2HHHVvvE930pVegVLQuIoj?=
 =?iso-8859-1?Q?XKEZ/fwB2YhyLZg6GU1Pz1JqBDPw9wpcTleppoh0+/FkdfEf9ybPd5ixYE?=
 =?iso-8859-1?Q?Ti1vgD4lLJaGN9jFCOEOavNapMJ0ICgK//hKPKv/je8HoSnak371oA+NbC?=
 =?iso-8859-1?Q?j9tYvtYRgHLL7et8voM5uOIv8tGD+q+UL6Nj1p3oHehf6kgA6Ml6p1icyf?=
 =?iso-8859-1?Q?1ueHyYxr5jBD8xMxUB8ZBlJ1vvuzcrnEpSmkoxIdd9w8yuNN0QsedBj9bb?=
 =?iso-8859-1?Q?8AFaNGlucQ/gTon6YQ+lZ36P4LdL4zxEtkp2Ex3TsOmF4g/nktPhmvpVck?=
 =?iso-8859-1?Q?txibozknzfBye+oahXEfYMOXzk0SHAIJXZ3Vs3/WkMjP0LdrslUxJC7sMA?=
 =?iso-8859-1?Q?zkUT8Ia4fEbvfKLxaYzhkDq6Ibn+Hj+epSEzGQkIBggL0fBGhyKkni4E+X?=
 =?iso-8859-1?Q?+yK8JP33Tf58iZ5twb5aR4KO24PBQ5S/cR1XMQKyQf9+6+BUj8bfA1pZdh?=
 =?iso-8859-1?Q?V0My5e4+aZ1Hvb2rLa8UxN0RN8nX8CsyZWLVzzBJGtdW/aXJLYNHi1rd2f?=
 =?iso-8859-1?Q?vNtpf8HYJbFgeQb1W+5ga/qRnQXft2lRJfuGOBKMlgwhQXWEW3TXdLUsUo?=
 =?iso-8859-1?Q?dC/d44SLNJw6FxNoy5B5Nh3eKSek7HyX0aeGDVPKK3Xd/G2SnMIsPZavtj?=
 =?iso-8859-1?Q?WyVY0oZU0lHwTw01ShlyqVTWn2N/1jXVv+dLxHtYAsgFj/2OKhgubpd+DV?=
 =?iso-8859-1?Q?pP2eafUVvA3+Iv8Ey0d0+Q8P3cIyCIyLiOBiCGb4A9ENRYjjdCQZOx6sfv?=
 =?iso-8859-1?Q?xizJ9Ipkx8FGNvkFknjFnW7Ef6jLB+1KQ8F2tBqZdBF5Idke5+erUBAcg6?=
 =?iso-8859-1?Q?oi5XPCceBEv5yr8IRsB9xWtvJ0yXCkY7bz3rI3XNXDHB0toXFZU+/UBD7L?=
 =?iso-8859-1?Q?l4IOOLcLgggVI/1UbD0NLHFsTDQqXog2AzlHflnzKiPC8dB/+oPF0h8xnM?=
 =?iso-8859-1?Q?SGHIAcdhV1t8d8DKddbCmk4wIaX+RhmS6tNPfHGMAmiOoSoSAp7zcTrjMn?=
 =?iso-8859-1?Q?eIk1Dxd5ux2Ny/pSHE+2Cs8jBYwqR6+3m5vprINlA7nrqEYAHpw/qrbLW9?=
 =?iso-8859-1?Q?dg0UCb2LGvyzibHZrE4pSm0zUO0WUlLnKyeyqXB6z/wpbP9+N7LSnsDHgE?=
 =?iso-8859-1?Q?kX/2HSzIbH73DxqCyRGx9s50mtskWc9h4ao6Lfy1tYKinc1PrC8eHVGRMG?=
 =?iso-8859-1?Q?T4tbwkJyInNIfujkmeOww5v8AKwMxYMAlGkzezr80W+z8z7n32DYPlerRu?=
 =?iso-8859-1?Q?2DLFcyv131qadUXljohI86O92BkMfJdXPdGQsdTjeERyegF1EQcfCLfQss?=
 =?iso-8859-1?Q?57tRH7l/pqXOeeLhgJ1D2Nrotg/Wfy+LVNeT7alN/7sswHz2UjvXJEaudq?=
 =?iso-8859-1?Q?rsTa1sYKbtKsDLsIIsiaSxabnxxGbatt9yZFVT5M5m5p9Wwb+O28+xl6+r?=
 =?iso-8859-1?Q?p0G9ev4JhuMuIih/StA0TdehdY6SKubXadX0kreClLCfRp+/E7dUs6Tnqa?=
 =?iso-8859-1?Q?PWwOVWrL+a7BHumxGNlRVilN7DOBOFsVMSFPKT1hsBoaKtGVJg7uzMq9Go?=
 =?iso-8859-1?Q?h4Dcdj6hsOCLsjbIXpGWybj9WKEwuBtuF5lXXPxa+ya9BtpNo2HvmJ5uoZ?=
 =?iso-8859-1?Q?5t8g=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YzPat0DMv5xpwPtZbmhc9kydnFW7Y3yMiyIUWXUXUnD8jdhPlA/cey2bluJRJE1NONbUYMUqRmrRjWVQtzMQ0dngQd9t57pVjlzPSTPgCbjQTD9xtnLkjKVMkiziy7c1kHfbu3prJj0AubkkH49PDAnPu6csKwxGrwYCx8jr9K7bpK5gQ+SlldA/hEK/Af8+DKQX0PKd6wPHIceEFm3iTvphP4hCf0QitvkA4dz2jrD8ur8oBdYiIy3s9aisIn+1vyM/O7uj+FlTs941omL7NqAQWdaI545g7A1BkVwt6j8o+RIeBY4Uef5dlJN6lYS9W7CcFpu2P4OMxhXLzuPF46dxkhsf/zy+EOpVLTBGzlyImE8Ir4N0A3FeM+A7hPws0XPB/N0ruzacqdOwpNz4FZZfLAPmyJl8qE6i/TU7pKiq/1ueJf+HwVPErQHBCPI0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 18:25:30.8415 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c41ddc2-69cc-449d-3d5b-08de699af047
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8468
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=nicolinc@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, KHOP_HELO_FCRDNS=0.4, SPF_HELO_NONE=0.001,
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
Reply-to:  Nicolin Chen <nicolinc@nvidia.com>
From:  Nicolin Chen via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Feb 11, 2026 at 07:14:40PM +0100, Eric Auger wrote:
> On 2/11/26 7:07 PM, Nicolin Chen wrote:
> > On Wed, Feb 11, 2026 at 08:34:13AM +0000, Shameer Kolothum wrote:
> >> For cold-plugged devices using SMMUv3 acceleration, the vIOMMU is created
> >> before the guest boots. In this case, the vEVENTQ is allocated when the
> >> guest writes to SMMU_CR0 and sets EVENTQEN = 1.
> > [...]
> >> @@ -1605,6 +1605,10 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
> >>          s->cr0ack = data & ~SMMU_CR0_RESERVED;
> >>          /* in case the command queue has been enabled */
> >>          smmuv3_cmdq_consume(s, &local_err);
> >> +        /* Allocate vEVENTQ if EventQ is enabled and a vIOMMU is available */
> > Nit: though it is just following smmuv3_cmdq_consume(), it'd be
> > likely clearer to verify the EVENTQEN in the callers.
> >
> >> +        if (local_err == NULL) {
> > Does eventq need to rely on !local_err from cmdq?

> if local_err is NULL we can safely use it, no? Or maybe I miss your
> point. maybe test !local_err directly?

Point is: if local_err isn't NULL, why can't we allocate vEVENTQ?

E.g. if IOMMU_HWPT_INVALIDATE fails, yes there is something wrong
with the CMDQ, yet it shouldn't block vEVENTQ allocation?

> >> +            smmuv3_accel_alloc_veventq(s, &local_err);
> >> +        }
> > Should probably validate s->accel before calling it?

> it is done in smmuv3_accel_alloc_veventq now

Oh, I just realized I was looking at the v4 branch..

Thanks
Nicolin

