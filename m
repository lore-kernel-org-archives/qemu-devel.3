Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8FDCD3439
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 17:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKgNa-0000Bp-Jo; Wed, 06 May 2026 13:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wKgNY-0000B6-Dg; Wed, 06 May 2026 13:49:48 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wKgNW-0005He-GI; Wed, 06 May 2026 13:49:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9IrjphW/WMZje8bUwCsvKiOOtvcOAL1xh/70wfCtbOG5PJRtcUM/7kRMglH1Dt66zTjjENVUd40WxrznTydk763DdsjxP5djWFjrCRqQEPcO0RBPvKnxY8Eto/+JoW7H6qmfYd8hDE8hHH9T6D+p/SG0PME2r+Kq9vSVyq9BdkfLnm7GndjObGzMHnUTC9nGorzFuEO5hmlu+Nzi7Z1Ci1/2UuA9JjibI1aFUsTbtiYPfT2hKnFgjwxUV1kF7rfJbd40jf4YHD8qpBAcdfwaLvuqU7/+tWLrsA6A5p8PIgEm6DNkAuycNJXjx8cxScqCwdV7Tf4WD8RdkOKQRWruw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiAciXGSbXgjZAs6EDyFaNZryqZ+u/hnLYHee5QK5m0=;
 b=ONmGY+clkGRAqpzz50xLYTNDd4ZSSdDFgCgw8JYKbqNWeQH86bZU2kY+Nz9x/bRfyUk96ZQiSDVz7A5brP0UvgGCDx69ezie4m0wbbsWWLC/odviLmFpXGvj+BFQami8oTmeLQMlyg1/MbWBad+rBNg7nxg5FtcHZ4/vvsmjel2MqEaoBbqxw5d1TGYtL56FR/4KIj2Gfrb1PGzPz7odNnGJ9cZNYe5Srwf7j7O//3FrVuLSUeLaK7c5C9Q4il0K4sJiQ9Kbd+EcOLz5vdqLdtJ7Jh/bdBieZTAz4fZr6y/QUg2xT5Og2zdyh170pb6lYrsbNfDG+7e2byrUF5PJGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiAciXGSbXgjZAs6EDyFaNZryqZ+u/hnLYHee5QK5m0=;
 b=YcEk8zOPjr5WCyKU8EqqXy4UQ3jKE9Tj71hQ3LU4cPIoBfDFlsRKoFBHwCI65Z0NlW8bp4F+nU7+fdG5FiVVJ1Ba6J5gSzXOv1b2pHlTtGcWcq/lWMxgw2CppQPIh5KkgjPnEZm5/AzN95QyhmmP89mwgUyipwZkXwN4EiRAF2G9Ly/iRmicviR/njIrq33ljwswuI3qYIFJaColwnam2lf91ElXrPcvyDWaaNL5XoSJT0usE0Xxo44lCxz3opVko9xmUJNveA480i16IwRD+EXKNRfNjupoRlG5e5IB3kzNdCJyUoLFiDstNTtl7uGt8Dvb6Rnrta7+yEHL2SjxlA==
Received: from PH7PR17CA0010.namprd17.prod.outlook.com (2603:10b6:510:324::10)
 by MW4PR12MB7143.namprd12.prod.outlook.com (2603:10b6:303:222::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 17:49:29 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::ec) by PH7PR17CA0010.outlook.office365.com
 (2603:10b6:510:324::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.16 via Frontend Transport; Wed,
 6 May 2026 17:49:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 17:49:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 6 May
 2026 10:49:07 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 6 May
 2026 10:49:07 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 6 May 2026 10:49:03 -0700
Date: Wed, 6 May 2026 10:49:01 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>, "phrdina@redhat.com" <phrdina@redhat.com>
Subject: Re: [PATCH v4 19/31] hw/arm/tegra241-cmdqv: Allocate HW VCMDQs on
 base register programming
Message-ID: <aft/DTFLqQnufzWl@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-20-skolothumtho@nvidia.com>
 <103d06a5-3203-4545-b617-517f695eb751@redhat.com>
 <CH3PR12MB7548F9BC9DCCE1D5899EA168AB3E2@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CH3PR12MB7548F9BC9DCCE1D5899EA168AB3E2@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|MW4PR12MB7143:EE_
X-MS-Office365-Filtering-Correlation-Id: a8bae589-38ad-4c1e-a71f-08deab97d240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: q8MSOSNLNkLTsnGPxd/D5MPkumDI7Q5zM0g5aCaWwAkzq49gb30ThX5qAF4JbxDf0XxItGFE4VNRc1ydUTWX5D2Rl/UvsXR0cdsgc6bnXeKkmdtS03bhaHD43+TdZuZDrAJgLb2t9csKe2D0MwNJzQRASJWm1+utxd4nsSl+cXjC85lROa3fA5eoOXRV/yTIrVlw2jpWpe+u12p3NglwFm6Ko7NXUXxc5kaJM8O9gfnp9aImsoUccX1UiHumZdXnnYpxMWFi878YAeWsNgEQS7OyZ8xaVQzcBwrlXeZevk5EGKhjWrWwwJZZn7Xeg5+QWrG6O9ub701NKnVgepKV70CXUCKyqb2eh05VSG7SuDK35FoKx9wJDeZWPzI6U+lmL9nasVoaUrMczHGELxEyo0queH78Etn8BJ1ekEH2jS1DG58ndG4XLXb3nkBCezePwtJQvplI9BNoOmdafcIFOidjFw8IQpjjuaJIMp3sqFuLmIHJkNYzRK4Ot9LkwyFeZaRGiAugL9LAPdYSMR4hki/y7z9ERjAYNTqy0e2VU+IC6iM6QCE/ZDxYiL+p657U1wSdGs4nVnBNMKnMsOr8y6dh8YJ1zamhKJ1dDNA16NNhmN9NNoLK6Fx7eJofn7ghtmNUbWEndIuU15JFZ0oy0cEOPCI2bnQ15kcv2MjnmGF7GHrweMFepkJpTFX/G2TqtszmmCTA1Uys36Bo3QrI2J1lbPcJUq4Cw+r3kR2WYCU=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LAdQ8ahaIjPDBRpQD5jcUtj/NPiZUBf3/Ovlj8TViNgsczcmD7VoMj5cZ8aSFPgaIsAMmxusWm5/Ak2mB6HBx9P1DXNSxZOpezdDwUHtBEJ/20Kv/gIJZbOlDwkUJ6CnOprIUF6VNDJ+PNH/AGOd/QYxeZtautgfsgxR3+2LIkku5ua1XTiibSFStUICRZYqX52XrKt8asqSStxVd2S+Gddmf6LNy8xK3fP7CunvsaYfVTw08kW1c1lhd3Se9NlbQaQg7BjC/iR7KLJOY/X7lJjjT6T3DpdiT9MtZ2jYsdFUXtMhdwYeZX7Pj2OgBZHVa/WzMrEouAePUBpSjD1lRakWj3sbdi4us63tUP1f8FEuruaqAPhJCAq2Ehx9/aifCt44YNKpEkkLznmdVF9fQkj4oUMqfeK+TQYX629eGQ6/Jmqhn0UmoTsTjn6OUMqd
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 17:49:28.7847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8bae589-38ad-4c1e-a71f-08deab97d240
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7143
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=nicolinc@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

On Tue, May 05, 2026 at 07:26:29AM -0700, Shameer Kolothum Thodi wrote:
> > > +static void tegra241_cmdqv_free_all_vcmdq(Tegra241CMDQV *cmdqv)
> > > +{
> > > +    /* Free in reverse order to avoid "resource busy" error */
> > can you provide additional details about the above problematic. Is it
> > documented in the spec?
> 
> See p.176:
> 
> Deallocate a VCMDQ from a Virtual Interface 
>     Logical CMDQ being deallocated for a Guest must be in decreasing order
>     starting from the highest numbered LVCMDQ.

Maybe add "Spec demands" to things like this.

> > > +    for (int i = (TEGRA241_CMDQV_MAX_CMDQ - 1); i >= 0; i--) {
> > > +        tegra241_cmdqv_free_vcmdq(cmdqv, i);
> > > +    }
> > > +}
> > > +
> > > +static bool tegra241_cmdqv_setup_vcmdq(Tegra241CMDQV *cmdqv, int
> > index,
> > > +                                       Error **errp)
> > > +{
> > > +    SMMUv3AccelState *accel = cmdqv->s_accel;
> > > +    uint64_t base_mask = (uint64_t)R_VCMDQ0_BASE_L_ADDR_MASK |
> > > +                         (uint64_t)R_VCMDQ0_BASE_H_ADDR_MASK << 32;
> > > +    uint64_t addr = cmdqv->vcmdq_base[index] & base_mask;
> > > +    uint64_t log2 = cmdqv->vcmdq_base[index] &
> > R_VCMDQ0_BASE_L_LOG2SIZE_MASK;
> > > +    uint64_t size = 1ULL << (log2 + 4);
> > > +    IOMMUFDViommu *viommu = accel->viommu;
> > > +    IOMMUFDHWqueue *hw_queue;
> > > +    uint32_t hw_queue_id;
> > > +
> > > +    /* Ignore any invalid address. This may come as part of reset etc. */
> > > +    if (!address_space_is_ram(&address_space_memory, addr) ||
> > > +        !address_space_is_ram(&address_space_memory, addr + size - 1)) {
> > this check looks a little bit risky, no? Don't we have a better way to
> > test the address has been properly set?
> 
> I think eventually kernel will handle any attempt to use an invalid address
> through IOMMU_HW_QUEUE_ALLOC IOCTL:
>      iommufd_hw_queue_alloc_phys()/iommufd_access_pin_pages() etc.
> 
> Any attempt to pass an invalid address will return error, I think.
> 
> @Nicolin, is that a safe assumption to make?

Kernel validates if the gPA range is in the stage-2 page table and
physically contiguous. It might be nicer if QEMU has a way to make
sure that is the range is in RAM.

Nicolin

