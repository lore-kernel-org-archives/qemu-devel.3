Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BCBFB3CE2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w78aS-0002rZ-GV; Mon, 30 Mar 2026 05:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1w78aH-0002qB-Qr; Mon, 30 Mar 2026 05:06:59 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1w78aA-0008P5-Br; Mon, 30 Mar 2026 05:06:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=deIZfv/ZnCpocfcM78gp7soGpWd3O7IInvltUvAzOcLO5r8oeCTUXrSFJ1JdUEqmq4fCQe1UHlO6PaXwZ329ooyiIOVHlsNUniRFQk1xerHU8Ggb4Ee0qeWKr2iCKm/cimyZtyGG/TxShHwC0xqV6sYG9PJF7FQYAM8Q2qBTMJQsY7GpVZ35ziTyTGMZrkL1DQwad6L6SY29e+n0CcO/uRcssDGZwNq8NSk1GfPUpFx5FhFk2b1JZiDZ+noTZLEUNIEte906JOl1FbB6DNdXZsourU/ozn914x3K/5tJLOz4xsyLhG/eK2nXOnyxwIWOv4d0OoVobvzhbAWG5ZNR+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRTNhmmydbE9C+HfsCv+SCOWZI/V2s28T//D6P+t078=;
 b=UejgTycCsd5xnyBplrcSwooE6mpFR2lhWNU//afHFDsknVHYKfdzsBqfOEkKArT1pSYd35f4CeMuDGOkk/U9Ur91QH8xeFkdl7dshWVFea2B62UahZLRGgK7UCQryDaM7jqypRnppzhqyh+voyhSAc7dByNEjeurtkl0A0lS6KLcs/jJanS1RFj1ulLFKH69MQPbDLK16SDcykkFd8sN7NUQg04MlhCLms0Myfh0v1BWs/RU6EnAC/MAHH7DqJY3DC1C86xakRNbNL5FCSs1zE5mFhIyza7ha3s0hUknDWe8IoJLbpr2vt2IyxXdNKh9ZvwRI8SnQtNWzrP9KYkgeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRTNhmmydbE9C+HfsCv+SCOWZI/V2s28T//D6P+t078=;
 b=kQzHLLOObO0MsxD3Pp+tz+/45Bi9Gv9t3lGUliSXJlyWZxC/tKmVuTrl0E70xHUwVbiaW4mmicllntQc/ai3+RPcIaODhj9P9g3xskgXxJkQ+DQzgRfvGfMJuafJrBglQccMgVDXy5HI7OYqXIvBeOqhHSQTch3++SXRPBypymm8bhFGES6JBWMfIuoAI9EK3p6+7xrRYJwr9QY7EeMXfwD9CYxHFe/rt7712WAgJonP3QlRSjjIU8xb/rDk/si7bg2GYkiz6yBCi7jBXQLfrRAV5mXmzRkJTgUDQO6OVDefD+UdbkZEJqcdjaqfRTW9F7BufoDlbY00g801C5aqCg==
Received: from MN2PR16CA0057.namprd16.prod.outlook.com (2603:10b6:208:234::26)
 by IA1PR12MB7542.namprd12.prod.outlook.com (2603:10b6:208:42e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 09:06:43 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:208:234:cafe::41) by MN2PR16CA0057.outlook.office365.com
 (2603:10b6:208:234::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 09:06:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 09:06:43 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 02:06:28 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 30 Mar 2026 02:06:27 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 30 Mar 2026 02:06:26 -0700
Date: Mon, 30 Mar 2026 02:06:24 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: <eric.auger.pro@gmail.com>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>, <peter.maydell@linaro.org>, <mst@redhat.com>,
 <skolothumtho@nvidia.com>, <nathanc@nvidia.com>
Subject: Re: [PATCH] hw/pci/pci: Enforce pci_setup_iommu_per_bus() is called
 only once per bus
Message-ID: <aco9ECUbZ1+QvbOR@nvidia.com>
References: <20260323183024.4069032-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260323183024.4069032-1-eric.auger@redhat.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|IA1PR12MB7542:EE_
X-MS-Office365-Filtering-Correlation-Id: 237ae19f-2fe8-4b37-e3ff-08de8e3ba9ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5gDScr1wQKe+2ag02URuHxNBe9XILCxHQiSQNeDQAwt9T46S03FsLM1FeBa7W+nKQKK1voEOOZ7HoKgaHowcjgPkiUKHSIx6ufUajq5CD+X7Y8eeVxGgy1alXaXl7gYYfBkxIpN6EnBEffen1Qw589AkS3D0v+X3cEY/6x0728tnsFAaez7tE3bfcQoMV0dwn9pal2v+RhZaSChelIfsmGUyLOrcrf26kV8jZvtyoP7qrhFmsoQu9eWBEy/VBexr6liVgAWAMj1Brs2gKmR3HPF8Lmf2I1yJNUHgvzdGP8BkxsQQB6tEqo2Z9XBu0pKZ49OtR46v2tjqeC6V/c1qS0X7H2uNGnNzh7qpROtlRuVuzJJbBKKSBY8nRQDdAPr8Ijfx2N4UIOBWckheSWObCuVOpNl8XAQgHAdWq7OaMBrQ7mRLbMHGC7rFpRd/sMu+tJ9JSOu5pizq74rpsH/xd3NZLea7Raxi+SBsOQthhkKTTKOdiTxLbHOcxnT77CvdmXrdJMVDP4E5BI8E/FyzrAqtB8JZaap0+94C3bjtlkkz781Pnvppu3Z4cwiKhJddcej2RWHzCnGUg+2YvBgHXGydZyQZ5Nm01EePtkd5SDP5VAD+6srIYY/CrtInW9BxeqvLd7/mr21UJx5BXA9SvcPzOuiNibxqc0cdgI3NBuZgi+SEIrzmVi51uJjxRzre5niWH3PXsunPmaQZLmEbPKW7a1uCRM4AIiX9S0b/MgiW7JvzvrNVGtCjNSeL0OuhJ1QpL0hsqRNUZzqLRRoFVQ==
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hZBQT8JTyEwkhNcNgS92UtlE9HyvGz1FQux6cc/3fEeTl1o/5yvDcu5KgWRjrKh9mpPu4vaplbOYuj+PSLjQbboVP9RCKk+VNd4agKBUSyJpey95D3WVTfoFHS5EHIEJj0MRnY/0zXy4Xi9Lq+IliC7zE9nJaGenTGWSPffdw1/17v/FjWSQZunuRpA2znQDLU3VwjvhPfSBQK0KExwmc3jcpF1EC3WsjbcCRswajkyZbMA96WCjY5g/lDxHeZADjILRsvJ/x7gglxGwjDx1LAPzwc0wRCQyXlPkos+NclnQubPTx9n4pMU2uoIsCgfq1UmhUvTLWx9PHjvheB4WmBfq3Fr2FcPodZEqEqx1vTYDPLaTEFT8PhEd3ZSJGFZyIGuhpMTRDX7XimG6it5ZetYbUL3qXjLYmpdwtijUlHNQGHh4XgRWBbYgxQ1Ef7vP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 09:06:43.6471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 237ae19f-2fe8-4b37-e3ff-08de8e3ba9ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7542
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=nicolinc@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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

On Mon, Mar 23, 2026 at 07:30:20PM +0100, Eric Auger wrote:
> @@ -3307,11 +3307,16 @@ void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque)
>   * IOMMU ops are returned, avoiding the use of the parent’s IOMMU when
>   * it's not appropriate.
>   */
> -void pci_setup_iommu_per_bus(PCIBus *bus, const PCIIOMMUOps *ops,
> -                             void *opaque)
> +bool pci_setup_iommu_per_bus(PCIBus *bus, const PCIIOMMUOps *ops,
> +                             void *opaque, Error **errp)
>  {
> +    if (bus->iommu_per_bus) {
> +        error_setg(errp, "An iommu is already attached to this bus");
> +        return false;
> +    }
>      pci_setup_iommu(bus, ops, opaque);
>      bus->iommu_per_bus = true;
> +    return true;

Do we need the same check in pci_setup_iommu()?

Apart from this question,

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

