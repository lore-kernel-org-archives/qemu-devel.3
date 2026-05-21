Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D4BCD5BAB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 21:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQBMG-0007Fc-Fn; Thu, 21 May 2026 17:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wQBME-0007F5-DD; Thu, 21 May 2026 17:55:10 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wQBMB-0007xy-KV; Thu, 21 May 2026 17:55:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJuOHaAOzUEqN2wDwe92vg/8cL16wg21/gjaArJQlUpFEBiETBVuVpOAQHSlmvCNzLJNtDj4GpXqCbPK+xKHROvYmoCCqAh/nethLZQhICeo112J83a5JPJWK74JsgB2qxJdEy9DTRHwf+AIPU6ULaxc3nI8dSHTNSQd3qc5wufCk9C5I2zT3uU9ra/O19ZcdBxXFjsAjePOw0m1Bn6zuTv8U+qd0LaSPW6pVAPvdiukReJfYAkDwKhEFmlumuLq3CPF3vzPmzz3XDllr/LIQe8xfRwPtfLSUvWnxKCQMglY0rZ/jzp2b5ykGYX9Wjy6eHqwfO/3j61FJxfPwNqi+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4cY69vTc6ZX4YgT/kArKS1he7ABAs/qpFt51ThTOoM=;
 b=oB8CP1jeBX1hCxusOEbS9vb9CT7EHgcPLG5WqeL+hD9urzbSNNhFxLJ6RGH3Oaq9H8Cplveh+oXMijgFi7ul9p24HfD1mtvCce4g+oKvYID/BbGLeRPyToqlv3jgExujz6lTsLLgtgSODEbZXEVZcPIcFwdVA0Piwxsex3qI8nfHiAoaV/oLvBBtD5SK4WLC0pJiiDxFwMq9haIpCK12X/VAJvTgf2rLTE7/2uEM0wd63rSXhckrGnXTYdisyasrGuR8zcoixyk04P2luQAbVCZAWawB3yvBj/EfbDIDKPuGbVQnD7cLjb+tkC8jsQVTgdmD7V6miK2ivFX3/9XfJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4cY69vTc6ZX4YgT/kArKS1he7ABAs/qpFt51ThTOoM=;
 b=H+BOp1PEGqm0Q+GHmdRLqNwOGgRn4qeiKVfgpjUxGI42MpbG4jQpqu96Mmz8Ty058FCVyi3yVWa6ljTJW/gZJeOCbLiZlu+fP62bjxF/VSHp2tlGUC97p9q1gE+jwIc2C2K8dfdndwIoS5OQBw99Mr+/tWEdhzGRS19Yf98cYjLpb07hO2TtJSvI23jPGLsX24GaYD5wE/pVxUnRvBzM+nRjQSGsCW6tws2zzXHijhX7GLWNk6OdUIb5hRKDT9JSGLqWNJusoNW7AgWz4IbKQ3VNawzMUcpdcGXN2iyP77J8XNXD8n2YcfM7zYt1v7aAKuWOGOINkqUsewmZ6xgqug==
Received: from CH2PR03CA0028.namprd03.prod.outlook.com (2603:10b6:610:59::38)
 by DS2PR12MB9799.namprd12.prod.outlook.com (2603:10b6:8:270::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 21:55:00 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::c6) by CH2PR03CA0028.outlook.office365.com
 (2603:10b6:610:59::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 21:55:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 21:55:00 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 14:54:50 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 21 May 2026 14:54:50 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 21 May 2026 14:54:49 -0700
Date: Thu, 21 May 2026 14:54:48 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: Shameer Kolothum Thodi <skolothumtho@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>, "phrdina@redhat.com" <phrdina@redhat.com>
Subject: Re: [PATCH v5 19/32] hw/arm/tegra241-cmdqv: Allocate HW VCMDQs once
 configured
Message-ID: <ag9/KMztV/pb7lA0@Asurada-Nvidia>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
 <20260519103727.899332-20-skolothumtho@nvidia.com>
 <166c5efb-0fa3-49f6-a1e7-faec85a6ec44@redhat.com>
 <CH3PR12MB7548314422301EA66803DD40AB0E2@CH3PR12MB7548.namprd12.prod.outlook.com>
 <69ec35de-1f7c-40ae-9ea5-3727c047c590@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <69ec35de-1f7c-40ae-9ea5-3727c047c590@redhat.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|DS2PR12MB9799:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c984f22-fca4-4876-0a33-08deb7839b4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|4143699003|11063799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: eNIxeF8lmDYkzsvcbomZNRvykIviz5Nma1bojeE4ZiFicNFVmSlvpvZjUU9W4Sii7XW936n2NoKhEHj+ORswsZ7mDXpvV5Zi3hZXK6tsGkedXXJDzAILix56/4yWO05GOsH5EmTq2mqwgsM74qApdJvVvV0f4KFmWW2ESgAs4EIOAP9ivK5gSlTyxYV1tQrG/YTmiXvzyHA0IebDZKoHJ7+YEnql79YqKwyJ9N/OhZQd8cV5AfijWhR6UD/X94UiLkFR0lqe7PRyd3V1gYiLaHA69yogqUdwalm4x+J3StJCSaYC5tVYh6MKffFj6OVpDIkFWaucUPEo3okQrcwHgejfQUe27MpxAgtSbPIOu4qLfSku4yLUp44Xsee9G4ZdrgtYeojN0rlx01FNp2UVxslLftl3/iE3lNuXPfCMlEoHkF8W5GJchgQo5OG9rSa7qM0ztboxBvbUDkWjHPjqIons18okox+33PVutNABMef+xPwUjk4W/oViEAHD7SE0rlTwT/5AKbmes74p5WJjOzajjfeyLKnxqKNpSk/Xbg2GgKpErfV6i9kR0Lt30ROxXuiD76/r7jBsHLfhgAOXyJQb+6/4RwvR4mOYXm43mA5lGS1rJBGpMQWJ078pRy2CUx72188wGQNfpXk9HbJn4NQTLH29eNr3J0yqF931uRJTQE1QgcUezDW0TB/5UJmPbZpNcMf1gUh7TYJmYDorx4wBHGtQIrOgxyn59lC7q7c=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(4143699003)(11063799006)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XJ54XhYyNxkKcdHfDG2IP/MKw/LZsuMiVpsKFZdKGCHzs8G8CbNOcy3xExO9E+MpyuWTWqPKoGVVI4ir0Azr4BcVC3nLGIL6Z+NMdbm3cW55ilerZuM5aMboJIW71IFs129JJ5F0pfRTv7ockLtescFn5LD5Gw5b9ibRDD89KZJsNu7lu5xXipLs40kO01c7pF0mtZ+tfQpByJOj6GwIuI5bIkI4mNuzFPmbRAT/tndM1uqFu+Wr1UlflEU4VY9ia6MoDpJJRI3GQgzsvSv4CNFxD26Sf1WVX3o6/HimqXequgopyWRGGO24Fk8/R/OPQYxREarpXIe6IOsCXs9WWR7UGY9RupUrAL37wooqr8/LAmohLQ4BXcaPXJMH4rQ7v8ZNwx8IfdE3a739p7SE6sHdvYnBDLqMvCGgvFJW2FV7Nh1jXJjyzE3pShYl7sD8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 21:55:00.6311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c984f22-fca4-4876-0a33-08deb7839b4f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9799
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=nicolinc@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Thu, May 21, 2026 at 03:27:17PM +0200, Eric Auger wrote:
> On 5/21/26 2:26 PM, Shameer Kolothum Thodi wrote:
> >>> +    /* Ignore any invalid address. This may come as part of reset etc. */
> >>> +    if (!address_space_range_is_ram(&address_space_memory, addr, size)) {

> >> why do you need to test the whole range and not only the start addressa

> > That was to make it more defensive based on v4 discussion here:
> > https://lore.kernel.org/qemu-devel/aft%2FDTFLqQnufzWl@nvidia.com/
> >
> > Please let me know if there is a better way.

> Well it is unclear to me. You want to make sure the GPA was fully set
> through the H and L regs. To me that's enough. As far as I understand
> Nicolin's reply, the kernel checks the rest. But please sync with Jason
> or Nicolin

Yes. Kernel checks if the range is in the stage-2 page table, i.e.,
mapped GPAs. One caveat: mapped GPA doesn't guarantee it's is_ram.

So, what if the GPA is in the IO space (PCI BAR) or reserved space
(firmware)?

AFAIK, kernel doesn't have a way to know. So, it's VMM's job to do
so.

Nicolin

