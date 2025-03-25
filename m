Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2993EC36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 18:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx8zq-0004zM-Vl; Tue, 25 Mar 2025 14:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tx8zP-0004xP-Go; Tue, 25 Mar 2025 14:27:12 -0400
Received: from mail-mw2nam12on20605.outbound.protection.outlook.com
 ([2a01:111:f403:200a::605]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tx8zK-00083H-MK; Tue, 25 Mar 2025 14:27:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6tZ3IdO0OomIPEKF/iV66TQBxtGVIPV/RLYuvkh8/0Aa9+GbtvWa3iFONgoeJCyjUueImtb5unQ9Ozqm6s5KM5thnwOcVZfDMgB0AAf2lSxDX4fvA+5PoL4sa5GFP45GM1YBzdRY4b7VPAZTIk+IaOWlG1Cw1FhzIKb/lqh0FJOjrnNoqn+PMgb3o79nFiRNfrqdYHwmYsWDqtaXFYGjbhtlW8upewQQsaRR8GURBqTSk4OBzvOn2JucCEZvXKlJZZG/lhV3d6ovwajSH5DzyDr0380cIYvpM90TmnIEZ5r9bmBwWEP0vb3vshbRZGE+PG9FAk2DPVzAG4lrFySzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUenuxkKP2bsske68nx6c1v+hUbfP0EV3Pb6dogmCGw=;
 b=EhLAUES22X9eDo7PrU/YFn0rMLATdlscsfz/RHScasu9T5W3HFk35ruCFShgLNNZW8IT7UN6dtCxIo1YktG47Rt4zfLZLN5qEsYmnxUoGKFFW0csTBgnuJL0xfEE4mUL77VRCEAt4sUinxyJqv981h7fzoAGaXTC7BsYvhERgxpDnttzKM/WpeAJINFVEg2J5Aec+coVqEUbhl1A6X7a4NjgmkLcZw3gd0mW8KiTt5SWR2hbhA4YMLnaDnsX7GH+WO5QIUkimLeOLuDgcMU70Sm7Vffc4DFpPY+W2go7mhNaS35O4X9vhUZJ0LXmrXJnWcPdlUtpfq2R6sLVQaHVWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUenuxkKP2bsske68nx6c1v+hUbfP0EV3Pb6dogmCGw=;
 b=PpnwXHGLdRvgdnQPERaEvjNrZEoEeRrZ2bSMUOKgmkl8o7k5Q3xcaLdDqm8dyoPOcoAfOvy5Ul1sFCM0WjFlBmfwrP61ZVY7MIVDE5K9Y2VzClq90CmeKwSIMCCaAAjIYvbbEP+COEu9anMqGaS7odD5+W4vX13Q6HqQh8vHW4eu7WpPa93DtTiVm7DA7F66GR8bYGGlyjlo2+2GTOw6lHUqLIk6XkWcA8YkJFQqzS5Tl3UjuM+DudrftvlvMtt500uPMzEJqWfwUOZ8WV6k5K7zU4eyZFFFWmWIJhvBQVE+4/K64i4ngmB9QLCQFuDmOL0o3yMOM6inEk/XN5+xbA==
Received: from SJ0PR03CA0199.namprd03.prod.outlook.com (2603:10b6:a03:2ef::24)
 by MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 18:26:48 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::61) by SJ0PR03CA0199.outlook.office365.com
 (2603:10b6:a03:2ef::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 18:26:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 18:26:47 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Mar
 2025 11:26:29 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Mar
 2025 11:26:29 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 25 Mar 2025 11:26:26 -0700
Date: Tue, 25 Mar 2025 11:26:24 -0700
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "nathanc@nvidia.com"
 <nathanc@nvidia.com>, "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH v2 00/20] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Message-ID: <Z+L1UEKFjBRPqXWV@nvidia.com>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <dbc0ee83-cb24-4fa5-9060-54a34a324f2c@redhat.com>
 <ffff33965d2a4ed4a5bf22c1bda6d774@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ffff33965d2a4ed4a5bf22c1bda6d774@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|MW6PR12MB8898:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f169ef-6735-424e-afd5-08dd6bca9aaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013|7416014; 
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?eMyhIk25qTxxzu7IC8w3ceSnzaYISkmZ116LU/dq+1yuD0xx3fVePz3Frr?=
 =?iso-8859-1?Q?N045khv3pSCAXGQgPN9EkLWyh9sCAjf/c+72E9rjfE/URNB8KwD6o5Gd7T?=
 =?iso-8859-1?Q?g9+XHCPNVFjmBHA+JS+ZQhIMIfqQBOyFNvReHgM5goYAD5AwVfBxHQSudv?=
 =?iso-8859-1?Q?6tyuxwXC5xBKRyVNgIA95IdUKco1454CcHu2omWWqDcc7wf++dZEreuwMl?=
 =?iso-8859-1?Q?F0HyT8kUjHWg4dzh8yvlfmGfhmM3to9bNNDlA8Kjc25deoAGopbY4Xn1F8?=
 =?iso-8859-1?Q?AQR+fFlCGUlJZQ/i8XPIhDGeqWzEdtDf97xbOAW5TJ2LtrzG2mH/Va9iNs?=
 =?iso-8859-1?Q?hukKDHbJjMiQ9HoqlCPpFmTlnHZ3D9wHWrTreK/aOt3tqpv8K2wDqGA9qC?=
 =?iso-8859-1?Q?YN7mJRlzd/7TALCn1deqx21ROW+GKGwfQZLi5xz4EgJIf4xAkFmVeVroz4?=
 =?iso-8859-1?Q?5mJGbHNz1pr32kqoiO1efnTiWr7/l7604Qr6HnXJuKTxe+MOY7UTttoXRv?=
 =?iso-8859-1?Q?vmSOEGd0SP6EJBzSSXr/yBLfqDXjRm3aiOX1/k3j2c0xVSt1cc2D4Ghgf/?=
 =?iso-8859-1?Q?JMNtKVlz8mM88nhjdjQcymayU0gq/VEEpxyfFSuIwb0KFOf2OckUaxGwjY?=
 =?iso-8859-1?Q?5vbClx6NvK4QeX5ZZsLuE5C+27iOBp6h67rgF9TbpcoCv7KAOJJPSAwr/Y?=
 =?iso-8859-1?Q?3eyXvrzqFdsGGoK2ctLiIvMpwedrnwWZnyF5SSmNdpjJIqyBy/cMEqtM5H?=
 =?iso-8859-1?Q?ZbTtTaWl9iMRtfovcD9K8Zoe3Mgh69pJpGO2JT0STRixy9EpiGBCm27trP?=
 =?iso-8859-1?Q?RngNgmMX0UdqqlKzXZSCwUD2QJAPaHZqn2mZ+yG9ZAcYxh43iSKMiMXtmP?=
 =?iso-8859-1?Q?h9rhfDPLfWZf4+Occru4z+Z3j71b/M2YEfp/8XetMQ29mTZHIlZiQRxlU4?=
 =?iso-8859-1?Q?rd46SzM/BkiDZ/Z8dQBoEzrZRmDXHr32SyflqSw6r2g0FyGBiVCk3i/4iM?=
 =?iso-8859-1?Q?CCFU/Uj1cfvZt1+Yeu+v1SGB8rBrCvGvH47borLUmsntJmOMNzSQ6tvNQW?=
 =?iso-8859-1?Q?eXVSUaU2eceg24XSL8zU1N8V2KMAzeGx3I2ahH6S0L5B/v6JubCk0X/ggc?=
 =?iso-8859-1?Q?h0SzjmIgMsj+AC0mhsoOjwcwVqdcOuAOjZg5bHOG0tgqulWGH3RyBOlaR6?=
 =?iso-8859-1?Q?2GhBlQ+Av2RV+5bZJku8mvm+bdkm2AJW8/cnVxNcGgUCjzLEFIluhdyScO?=
 =?iso-8859-1?Q?0vUDy0nUFGe6sb1+s9gOoU+5j7zzK184SmRdMKMc4atKY/P5plpLzbtqIt?=
 =?iso-8859-1?Q?/a+pNC/9zGhrOD81oxylg71LjMI2zww/4ka33NZ6RH/1PzIDaJF+kdG456?=
 =?iso-8859-1?Q?FOp8WG37T1rihLV4/OnV8Ka+yeq9X78z0MeBy4qPmvpdqhUDq2SdMGiJ1y?=
 =?iso-8859-1?Q?HG4JaNu2U472F16N/h5FvJ0xG8WYf+aBQlKjFNzqxmupFU9U4M/w86UVws?=
 =?iso-8859-1?Q?CRZlALtJOtg3sRaJP2pyFy5st+EsXWpUGpuKSI7JaLPoBteMC+HDxvoYnE?=
 =?iso-8859-1?Q?gh/RTow=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 18:26:47.7515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f169ef-6735-424e-afd5-08dd6bca9aaa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8898
Received-SPF: permerror client-ip=2a01:111:f403:200a::605;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Mar 25, 2025 at 03:43:29PM +0000, Shameerali Kolothum Thodi wrote:
> > For the record I tested the series with host VFIO device and a
> > virtio-blk-pci device put behind the same pxb-pcie/smmu protection and
> > it works just fine
> > 
> > -+-[0000:0a]-+-01.0-[0b]----00.0  Mellanox Technologies ConnectX Family
> > mlx5Gen Virtual Function
> >  |           \-01.1-[0c]----00.0  Red Hat, Inc. Virtio 1.0 block device
> >  \-[0000:00]-+-00.0  Red Hat, Inc. QEMU PCIe Host bridge
> >              +-01.0-[01]--
> >              +-01.1-[02]--
> >              \-02.0  Red Hat, Inc. QEMU PCIe Expander bridge
> > 
> > This shows that without vcmdq feature there is no blocker having the
> > same smmu device protecting both accelerated and emulated devices.
> 
> Thanks for giving it a spin. Yes, it currently supports the above. 
> 
> At the moment we are not using the IOTLB for the emulated dev for a
> config like above.  Have you checked performance for either emulated or
> vfio dev with the above config? Whatever light tests I have done it shows
> performance degradation for emulated dev compared to the default
> SMMUv3(iommu=smmuv3). 
> 
> And if the emulated dev issues _TLBI_NH_ASID, the code currently will propagate
> that down to host SMMUv3. This will affect the vfio dev as well.

VA too. Only commands with an SID field can be simply excluded.
I think we should be concerned that the underlying SMMU CMDQ HW
has a very limited command executing power, so wasting command
cycles doesn't feel very ideal as it could impact the host OS
(and other VMs too).

Thanks
Nicolin

