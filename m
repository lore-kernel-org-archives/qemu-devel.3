Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CFBCCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 22:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9WUe-0007E4-22; Thu, 16 Oct 2025 18:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1v9WUb-0007Do-PS; Thu, 16 Oct 2025 18:30:42 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1v9WUZ-0002Yb-53; Thu, 16 Oct 2025 18:30:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xz5bDtrO3B1Nc6nTaOV6xsI3cE6rLYK6rMb8XeTuvWWwzci5qnsCHCStxGbVgFMvlnx/xQp8+jkGZhFHeFrh4G9ejo4tSGQLnR4Z6HSUND+c6aH0x4M4tISEWoHiAQnvW6BhkOjXcGtsGrrsbc4hJbLAeGnB9OqfMdyTTTSS/9yRRwRZ1WH2caSIKvzL5W45PPApLD6oF7l0cR88kXKr+dLaOW5IUh3ku8a6B0hqouNN8U0YDIfl5A2No8kMBtIMi9TXYy0xIQDd8qhMOeT7rlO6iD3CQmcnU6nB25N5XIKiTld83DdL1y9X2zV+5Fm6MU33lY98hEFTF3hkwl744Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvy+hobdbUndbt+9x6sm7iCCltKis0sdnWimKHxuAyk=;
 b=NY71njUvMHLL6Y+uEge0TxcKKmwwJEtpXepNhNSq8XDegEUytTRYZhrwGsq040CgCErgeUjG7moEmCltZakhMAsEHuIQsFaF2dymTlwl4QJU2ySKidNrep55UmDXmMnwxwFM3hIPU2/FufCOS/PWF4YYt/BeQIZVei+xpBtXt4SLeFyJ3Z1XQlatXDom4rE2kL/9uTq6/4+KsMFHwVVj5itgw/76FOsRR6E6BZin61SzTNME7mQJmQKuWtqIQh2eMWLTqdonn0uElNlKCPwXE/TtV7Qphy7PFoiH9TQNMajosG9zipj991uR2E788CtBzAO3BXwu0CceSSMaRYmuHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvy+hobdbUndbt+9x6sm7iCCltKis0sdnWimKHxuAyk=;
 b=L+jlaqLSp1CWRn9+Lp1/B/WidfzCnVWPBi/nwlyHGo5jn4Dgflh5aYCb0E/i2OtkOS8UCdR/zgtYNXYO9BjUxJqr/TepFxzHdM8p0dQBUGK/qWw2qO2o7hF5OfNxhz5nNl1iaVaFDza9lNblEMXrxIW+K+jAdTjxQgS6TegM1gKxO4BXM4Wf8TN4Ci2f4etmLzIdb9A8i7rsipLl4rBsijWhXCIcoA6Tv4v2jlwuDdMslDXNcYlzSmCHBGmdod3mj0BGgl8uDrDYg61z0wHfh6m/ONym61LdTMGgmTWqYmM47GdRikH5bxqQr+kGPJoyWchGOy7dVBe5F62DHDyjxw==
Received: from BL1PR13CA0111.namprd13.prod.outlook.com (2603:10b6:208:2b9::26)
 by CH3PR12MB9196.namprd12.prod.outlook.com (2603:10b6:610:197::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 22:30:27 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:208:2b9:cafe::c1) by BL1PR13CA0111.outlook.office365.com
 (2603:10b6:208:2b9::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.6 via Frontend Transport; Thu,
 16 Oct 2025 22:30:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 22:30:27 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 16 Oct
 2025 15:30:08 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 16 Oct 2025 15:30:06 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Oct 2025 15:30:06 -0700
Date: Thu, 16 Oct 2025 15:30:04 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: Re: [PATCH v4 11/27] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Message-ID: <aPFx7Egdny+JCO9U@Asurada-Nvidia>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-12-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250929133643.38961-12-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|CH3PR12MB9196:EE_
X-MS-Office365-Filtering-Correlation-Id: ca448ab3-7519-4a48-c236-08de0d039b45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XrdQ/Y2vqeAW9YokUFyKx50rX1gPi6tIXl6DSwC4Lt5yFbIoBQV/UMS0t7Iu?=
 =?us-ascii?Q?kPtqkwQ/TjhBg/ktOsylHXPvA2BoMBDD4G7YH/S05WVBBkmj5i5naAJPjkT0?=
 =?us-ascii?Q?OoQ3oNft3pTmC1DRxH1el6D1nsstC/wwnrupjuvNb9bZ2tpVzEBN+PpZTS/P?=
 =?us-ascii?Q?vuCcd0aHOccl2dcVXGhUU8UQRP8IVEmJZ9SA0z/Kpfp0o3qUSpzIQZe6KaTe?=
 =?us-ascii?Q?4ChdYp/oTTEgvoIHWhTpvHZXuqqB+/s1PylrofVPpd3JPcn6w8NLpD524lvr?=
 =?us-ascii?Q?8CnMYcan3sv4Hf+IchEuE0hmRiXcnQe9szsXhBP4FphjImksklcyYoMGPMaT?=
 =?us-ascii?Q?0BKEm4h4jkqK74XlX7r1MVz303LvyjSH24T2eRBybF4HZ7phDQJXmGRAInv3?=
 =?us-ascii?Q?/tzubsrm/0Cv6Gg6zQ87+esrHmzlaYVxCWBlmG8maQXo0+LNu4s4K/pUUnbr?=
 =?us-ascii?Q?MAOT8kAS3HKlmJFvPb2lVq6elzK2OckEVhPv45Qv/6bU5xYtTPqQkmGlpXNj?=
 =?us-ascii?Q?5MW9yrrrCb0jZBLl66JfLD9NYtAo+uyyz8HqN1rSjcpIWO3NLK0trQNYxpAI?=
 =?us-ascii?Q?t3bYHNRY2TCWafr/2iQFFP4/RT0FUX0ncMkKbhMdqkQJwPIEzZwI5+z6R9N1?=
 =?us-ascii?Q?cThw7ZHGt0KZy5+DW3nsSQ9bBnnTBN85j9BRbFQtI73emI924+AKPjhMlRKC?=
 =?us-ascii?Q?Po5016zcfJl/ap8V5RZWQbPtcGMI+PD0kcYhM8WG0TmOYgJVDdffgzmJP8eI?=
 =?us-ascii?Q?lOk+D8EZeQul8Uk/xq+2snEQOCNGgMnHYCEuVv5PT9IR/VFdJxyYU5wVyP1M?=
 =?us-ascii?Q?vDxSd2MRaKfYA3E18cMLcJGKk7QF1Jr+2SJ/qiseskk9u1yDLJKgU4ijBCwG?=
 =?us-ascii?Q?xhj9F4rXccQCsVRQG85zgVoFeCphNlUt5zTUWQrXgF76ERxj6UCaJmU3mpiU?=
 =?us-ascii?Q?sTMIxkiWH/fOvQIT4o36lyjrvzyL8/2rvkKQ00SS0cuOLSnaiWT/wR1DOQc8?=
 =?us-ascii?Q?ZvLptIs1DMabEE5LHY3PwQJQCgxnxsaSNnJpAdqiAisKjYR23gJWsP8S6+kE?=
 =?us-ascii?Q?J7A22ZSYOiBVTbchZ5unnXuqKaxzyN88aE850apA64c8KFXN+97RvvyoOLEO?=
 =?us-ascii?Q?jGfNBos+EKQ78uy2SZxNwChmdOGOX2axdJ2uE+3egLszO9SVo8oDMyB/iJWI?=
 =?us-ascii?Q?7edwAoV5WXqxUb0HwO3y4L1U7H4VOz2v2UOL3LF+nrhJvx5MXy4L0Oqjjwzp?=
 =?us-ascii?Q?nIRhb33uhyJgr3xpJN9OIvm30UKWlizsFaUUhqF8xWko0c0jBOT6ZbiNB9DA?=
 =?us-ascii?Q?SUfxPCncwKX7/94UeFwWrXsRVL1AFWXPZEsJMT38FkXO8hfCf9GKt2vGN4Fz?=
 =?us-ascii?Q?mJ6ftcpHJtVULV9HYxRyUIJDr0X0sWv3BUbSdKXq2Nvf3bI6jjaWHAIVBb/n?=
 =?us-ascii?Q?r193tlg12bRGZOHQeEL1nQ4De8WhAwVeSqZ9F2Ej906fnDjaDkD9acf3CLHv?=
 =?us-ascii?Q?fvybAplh6J7z+MMzUyCwUHYX81qV6fGbndaviNhlY0jxAaoLDzbpAZteckOI?=
 =?us-ascii?Q?RHMgxCakjAbcbQEasgY=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 22:30:27.2529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca448ab3-7519-4a48-c236-08de0d039b45
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9196
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=nicolinc@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
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

On Mon, Sep 29, 2025 at 02:36:27PM +0100, Shameer Kolothum wrote:
> On ARM, when a device is behind an IOMMU, its MSI doorbell address is
> subject to translation by the IOMMU. This behavior affects vfio-pci
> passthrough devices assigned to guests using an accelerated SMMUv3.
> 
> In this setup, we configure the host SMMUv3 in nested mode, where
> VFIO sets up the Stage-2 (S2) mappings for guest RAM, while the guest
> controls Stage-1 (S1). To allow VFIO to correctly configure S2 mappings,
> we currently return the system address space via the get_address_space()
> callback for vfio-pci devices.
> 
> However, QEMU/KVM also uses this same callback path when resolving the
> address space for MSI doorbells:
> 
> kvm_irqchip_add_msi_route()
>   kvm_arch_fixup_msi_route()
>     pci_device_iommu_address_space()
>      get_address_space()
> 
> This will cause the device to be configured with wrong MSI doorbell
> address if it return the system address space.

I think it'd be nicer to elaborate why a wrong address will be returned:

--------------------------------------------------------------------------
On ARM, a device behind an IOMMU requires translation for its MSI doorbell
address. When HW nested translation is enabled, the translation will also
happen in two stages: gIOVA => gPA => ITS page.

In the accelerated SMMUv3 mode, both stages are translated by the HW. So,
get_address_space() returns the system address space for stage-2 mappings,
as the smmuv3-accel model doesn't involve in either stage.

On the other hand, this callback is also invoked by QEMU/KVM:

 kvm_irqchip_add_msi_route()
   kvm_arch_fixup_msi_route()
     pci_device_iommu_address_space()
      get_address_space()

What KVM wants is to translate an MSI doorbell gIOVA to a vITS page (gPA),
so as to inject IRQs to the guest VM. And it expected get_address_space()
to return the address space for stage-1 mappings instead. Apparently, this
is broken.

Introduce an optional get_msi_address_space() callback and use that in the
above path.
--------------------------------------------------------------------------

> @@ -652,6 +652,21 @@ typedef struct PCIIOMMUOps {
>                              uint32_t pasid, bool priv_req, bool exec_req,
>                              hwaddr addr, bool lpig, uint16_t prgi, bool is_read,
>                              bool is_write);
> +    /**
> +     * @get_msi_address_space: get the address space for MSI doorbell address
> +     * for devices

+     * @get_msi_address_space: get the address space to translate MSI doorbell
+     * address for a device

> +     *
> +     * Optional callback which returns a pointer to an #AddressSpace. This
> +     * is required if MSI doorbell also gets translated through IOMMU(eg: ARM)

through vIOMMU (e.g. ARM).

With these,

Reviewed-by Nicolin Chen <nicolinc@nvidia.com>

