Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92D1C83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 08:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucgSK-00030t-QS; Fri, 18 Jul 2025 04:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ucgSH-0002y9-Ci; Fri, 18 Jul 2025 04:28:33 -0400
Received: from mail-dm6nam10on2061e.outbound.protection.outlook.com
 ([2a01:111:f403:2413::61e]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ucgSE-000503-I4; Fri, 18 Jul 2025 04:28:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FpY3mPDzEHjaHoJo1dcwEpYWm5CCPqno0QoQNn7xhz8EsecURqvMPMkfrIPI5juRN1gmgd79dr8tmFYVLMtNZBAY5dhbA8Lii1aRSbj1gketyYp0B1MsrA4FLa/gR3pSRDv5ZA4LHia2j1+Du+SJgaxAABS43GSUPYw70ZBI+9nt1la8q6wOWC3Zxyceaya1/0oEpE6bIM1EgrNPF6xMIZqddoIIHPPhUbx1K5PbbivkceUC/1cNSY5pcJXL7k8pqmFbiU2WkWubB/NUApVz/CJKmLy3gCssijX3CqYrkVPP37oEaeNl9eyrDr9U/A1Ko/drEdr817gGLhbA1KUCrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHfHlBDxmxqbpiwiLH3WWVYx5ohmijv5+wBg6h39T7A=;
 b=ybxJAzobM97G1uUuuUd4RDpb4T7SKOF864RiSLLCe/JkMVM0SDTIHBu7Bc8DH+Y8Q4h/3R1P5aMfaogznT/AM4CcR9jMe6WvznLxGolvpB08dwNUoy2OeF6wCCgTXiqQ2gK4laOUe/2xqunxODr5AXMVifiwiDFwvajTfU95Zd/le2MjdnZLiUQsVu+1uSkfywlYSqFuDZdHlUiarfLxTRXDt2H1iEK35QFmSxpguzRXxnEPi+9gPxdnmGeDA/7jEKRKgT8wxXgkD2fDErPmYp5CuwBPfQdM/Djn/WKSc16pgz+dNCyuJS5e/YEVIgTw7VB6EzOc9oE/bAHdR414vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHfHlBDxmxqbpiwiLH3WWVYx5ohmijv5+wBg6h39T7A=;
 b=STr+SfWCUC2m7NL2euda/ediku8qcY8A51696KYuFBvrCnxd0BgCszLPpHtC07OFYZRiBaOB32RWvrZOGpN2qFbTX6tJXBeOjTZfjekPL5oq7RBaPzxoo3YXiQduXLTM/23yPsmUhcsiivgkLYFgFb84z6rdreofdqRh/+Lnd1U/QZRHTC3oOaeZCCR9KNLc2QA2fRc+dpIAQ4k9sopHypdBtGsRdFlAJuJKvvOPPxTAzN2yfZqPABM/qKIzLDnqa/+mD7rVaGKspviDCA1t+SxnA4OZ7yzrXxsmCGn/jrwkJeqRO+DuVIXuGF1MGItUFsuNZyDV6D0kVbzPin5N6A==
Received: from SJ0PR13CA0033.namprd13.prod.outlook.com (2603:10b6:a03:2c2::8)
 by CH3PR12MB8879.namprd12.prod.outlook.com (2603:10b6:610:171::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.37; Fri, 18 Jul
 2025 08:28:22 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::9e) by SJ0PR13CA0033.outlook.office365.com
 (2603:10b6:a03:2c2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.12 via Frontend Transport; Fri,
 18 Jul 2025 08:28:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 08:28:21 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 18 Jul
 2025 01:28:08 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 18 Jul
 2025 01:28:07 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 18 Jul 2025 01:28:06 -0700
Date: Fri, 18 Jul 2025 01:28:05 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "gustavo.romero@linaro.org"
 <gustavo.romero@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, Linuxarm
 <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v8 08/12] hw/arm/virt: Allow user-creatable SMMUv3 dev
 instantiation
Message-ID: <aHoFlS5x3MbKc/Sc@Asurada-Nvidia>
References: <20250711084749.18300-1-shameerali.kolothum.thodi@huawei.com>
 <20250711084749.18300-9-shameerali.kolothum.thodi@huawei.com>
 <aHnJ+qUsVyu+eFaT@Asurada-Nvidia>
 <f793c36c2cf145b7842eb72795553824@huawei.com>
 <aHoB6HvXgkmkMQnv@Asurada-Nvidia>
 <028e156593614a5cb8493304e1c6a447@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <028e156593614a5cb8493304e1c6a447@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|CH3PR12MB8879:EE_
X-MS-Office365-Filtering-Correlation-Id: 977fc34c-b1d7-4050-1ae6-08ddc5d50e91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|7416014|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g1CWmQnOnYyJfoC662AQ7rNG3THa2Vv1ZYDaNfUm4eo25YEN5ZFO1xB7uwHD?=
 =?us-ascii?Q?wPxAWN67kXb+vlYW6RCyk9/m93ycTjMvQlXyjy7gDebQp9rTqgJa5vmAFNTg?=
 =?us-ascii?Q?JXCOyn2rhrDYIiMA6OooWAvmZx/nUxGO3K0UKVZ1kK3zOWe16uV9lreCZbe/?=
 =?us-ascii?Q?tPjoMkkBml1iHNj81NYYwew3C3Da+CICoi/HKui1jNr3TLiKK7pE1ifMhhim?=
 =?us-ascii?Q?kfvwY7wwvhDI4GTDIyqVEu1m1ZI9br1WjRq3xQyTPsJ7a51MI5vdGiRrSdo9?=
 =?us-ascii?Q?sJENhTbSQvnud/+bhHatiAfrWwmi/CozXt2R9bCVkEQMsPgJq7ngC7qLRUtb?=
 =?us-ascii?Q?LD4sii6Ru1BC562qb6gEcnuc7GBS/G5CPN0O8H/RCC2UzfxCPhrB499Gi06U?=
 =?us-ascii?Q?Ri/sF5j3Gx/APSmDx9OBpMGqsFrsAqT7TOskm2qvjvHu775TyJox447AGTx5?=
 =?us-ascii?Q?tbl1K+kcRG0fP1VQVvmyfl5DCYhhRcrXg84CTk37XFgH8iaiHtEhwF0eRt/s?=
 =?us-ascii?Q?tsKtzi0PI/kGJSdoLIa8HLUPJBQqLk4onr1L/EEGOTRFNQnuXQDG1NBqsAvn?=
 =?us-ascii?Q?uHeE2F0AVyzkLPC3u6u1dH0JGhh34q1Y1wMeTLSF4qGNUxREXBJ+GQpbWick?=
 =?us-ascii?Q?0Km+upZ6FIUazliOXXN+1Gvs7vWh+igr2iPLHtB/uGtS0LrlEafNygWs/PWn?=
 =?us-ascii?Q?o3c8NI353yqXygNHTke3RLR0bim1HDjPsuv6TgP9XTW91K1ZSZTrurSeEFfk?=
 =?us-ascii?Q?6D2/Y8Ys2HuZE+dbbdE57jvkAsZ20zakUw5gULK/jeVslG3lb4xKWaLr3ciE?=
 =?us-ascii?Q?uhmA2ODmPSmtuVlcBBN4ZAtgTQK8A+O0/n9+QuTb04VyoFgVhz2rX36YCrMF?=
 =?us-ascii?Q?JiU00eJuweP+xT7+RtdNoeySVSsGSjbrlCa38plY5ifWDLQik3nbqxxE/8d8?=
 =?us-ascii?Q?QuFPYeTcvIhZDj2FYY9SLh7uOk/9/vOKLIyTwjR1XKqdXVPeZTG02RKqt6c4?=
 =?us-ascii?Q?U2xggZxlgeVO6apH4PvZfV0ockUs4/mp78xJNalLiGT4ACG4iq0s7pVnbgTe?=
 =?us-ascii?Q?zuZ3n9bTw3HNLGf0ErhiU2/E4M7gCb0LxYD7EGLQeBKIrBmQgQng/YMZHbol?=
 =?us-ascii?Q?zIqqzSXP8mZV7/fNzHYb/ezTyxrHP0wkVcFx1qBASe0vXBf1JlyYoNhnhnph?=
 =?us-ascii?Q?suJHGRm6an+c7rKo7P5mToCNdmgmHYJYEf8IqXMI5k5V+Ac5hBYyWq35sSm5?=
 =?us-ascii?Q?ovNo96EJGNcVfbLtzqwZW7oBgcq86c7Dxc92GsvCafs/acbHjkoNRhmy0MC4?=
 =?us-ascii?Q?ozqbToTQmI6qqDESEB3cmPlTjiNECJGO23T+SPUexBACW/mLmBuZpqSUyp6B?=
 =?us-ascii?Q?rlzBnNEeSPRYYDwntfss7KrvjXmKXKU7jhTh+BmbdoTL7871S8daSp9m6Qfu?=
 =?us-ascii?Q?tHDHoUcnwPxMfOF3JrnzAZ1n59SWsKWhOOhoptZfPHFUpwMPIexctXmQ56bS?=
 =?us-ascii?Q?LOJ5n/qDU7I+o335aeRkz3ZXKc35xM7QJMkr?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 08:28:21.9130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 977fc34c-b1d7-4050-1ae6-08ddc5d50e91
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8879
Received-SPF: permerror client-ip=2a01:111:f403:2413::61e;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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

On Fri, Jul 18, 2025 at 08:22:09AM +0000, Shameerali Kolothum Thodi wrote:
> > So, my question was: where do we set the number of 4 to the sbdev?
> > As platform_bus_get_irqn() returned very correctly with 0, 4, 8,
> > and so on..
> 
> See smmu_realize() --> smmu_init_irq()
> 
> And then in virt_machine_plug_cb() --> platform_bus_link_device()

Oh, feels like a runtime setup. Interesting.

Thanks!
Nicolin

