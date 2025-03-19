Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B5BC35FFF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 18:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuyG5-0003Zv-Dd; Wed, 19 Mar 2025 14:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tuyG2-0003XQ-Oc; Wed, 19 Mar 2025 14:35:14 -0400
Received: from mail-bn8nam12on2062d.outbound.protection.outlook.com
 ([2a01:111:f403:2418::62d]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tuyG0-0002Jj-Ku; Wed, 19 Mar 2025 14:35:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2nj3IlMlODbma8zxW51y2dg2CEOJKsPxoS8BWCMrpfhLrDd6EPUJP15cLom2qA8zbNUCQjugcvtp0cQIC5C1o1kHskMSFaBjs+jlT+wWEi4WlhPXKJ8Q9JEdnK28+cDtFzirpLlT7yw8dB3pxd7jDS04RTV8VZJPMPvpCiOkojMaeUFRcKXncA1tl2XMySfgDG18UwEHHdigA6JanJHXudlIsHQILHDawO3rNBxlP6Ekrh7a/bAmV86vu4fYfsPSQBUf6c1c1A5unL3aXeeRca6qD0RFiJRt2hdtIReIN8OM/VVR4Hu/8/gdY3Z4iS/1uEZ3KJQkI1RedQaODnS2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6tPua0UaT0rjbiysElGV/niITZEVHu3kji1sGWLB9A=;
 b=cjbdgJLp6LuZbxa2tjvjbWABSMwqjkulrHaNPZfbYi1Ci0fA/Qu7WpNLbvkSAH++DVemYZ3UD5oSaTaiqSEoGbUjgArfF/Shyw5OELmCPyf/IL57l1VqThIqshEb4UgHfBJ90BwpEnXysGcgPbD0SaTK4Vaf0qBus+oX/RBoyu4Jj+PcTA0nJGutmebK1GHFUYBLoUZcTEvQD2Jc2231rjY8+CJUX1axtuwymsMwaVPuXlhcyTi9RiBJr24jzqjzSmHKQwCpYapVPvpEz1oSlG4tqxPxBDmzz4kpVUj9qOvAubrAURvGTk67pEVvkJMi6yomOTdhObKBNRTHAGn3qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6tPua0UaT0rjbiysElGV/niITZEVHu3kji1sGWLB9A=;
 b=rRuMyA+hxcXVrHx4NLfQtyAjZ5ysVt1sj1wcGx2FtsHtOG1P0d80d/LUAw4OLd3UoBpLD6wIgeC8EcPvh4Y9wwn/eM6kwyg0McKGOMyANlIZKyrP0rA0Fh6NwPFsl4+DfQoP+WHk4M0ws2TuriJ+7KtkZUtWNzpVpb6I39Z3KQDqFVbMEgihtJwNWJCREsIxO5hKB+GpDAxpnXd73q8atEYDHdKciiMg7jeWFtVzCZak41PP2o4oBinVaxGzhEY+bv+9cNXHuL8nPCU3zSSksFjKwZ9WityLt1ZVqAOaoPsL82FFKG7K5AoSmJsqULQkia/jmBjm58zop9jsxLCCeA==
Received: from BL1P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::16)
 by IA0PR12MB8280.namprd12.prod.outlook.com (2603:10b6:208:3df::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 18:35:03 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:2c4:cafe::41) by BL1P223CA0011.outlook.office365.com
 (2603:10b6:208:2c4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.31 via Frontend Transport; Wed,
 19 Mar 2025 18:35:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 18:35:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Mar
 2025 11:34:50 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Mar
 2025 11:34:50 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 19 Mar 2025 11:34:49 -0700
Date: Wed, 19 Mar 2025 11:34:47 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>,
 <jgg@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH v2 03/20] hw/arm/smmuv3-accel: Add initial
 infrastructure for smmuv3-accel device
Message-ID: <Z9sORySxEEL0VXMq@Asurada-Nvidia>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-4-shameerali.kolothum.thodi@huawei.com>
 <d75feb00-72d3-4d79-a7ac-2548eadb6a77@redhat.com>
 <Z9hh8MIAQNQcvNlG@Asurada-Nvidia>
 <71b73212-3d8f-4c9d-93a4-bf07c0f169e3@redhat.com>
 <Z9hzmzHfWw18OyGO@Asurada-Nvidia>
 <11895c78-d6ab-40c8-a500-4abed1565234@redhat.com>
 <Z9r7dT/5E+YToqc9@Asurada-Nvidia>
 <c70fdb0c-ef56-4a52-8591-31df51ff0eec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c70fdb0c-ef56-4a52-8591-31df51ff0eec@redhat.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|IA0PR12MB8280:EE_
X-MS-Office365-Filtering-Correlation-Id: e968d721-ce70-42e4-0018-08dd6714c3c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|7416014|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Dtq4qdz+MMFXTuHJf+x3HiN4bZJ21YZ03hvCW0QYDXZe2J2/Ai67EaLEzQz9?=
 =?us-ascii?Q?H86zdP9y7aJx/dCHpKjmdTD3KVIbkBmKXmlsYbkEPnokJfg/K9lTKigiFZ7m?=
 =?us-ascii?Q?veWeJSOvac6dDnwDdEGmsFCmvqf4qkTyIeF+sn8wz1zQNgcyWYN2uRj6NB0W?=
 =?us-ascii?Q?8F239Yy5Qr+QEJvKErXm7IqulYzqZ0iy1M/NJEifUcl57Qp1u+H8MkYmsR7Z?=
 =?us-ascii?Q?XydZy7VP9B0r5mV+u3Ow+OPrMsmhWMoCGKthqGdz98rcgLVlHQqxXawaGIV6?=
 =?us-ascii?Q?73Wmtb69ps/kluGx1xI1EztTu8byhDNrfIfvtC4PhZg39WjtBO6tWZa1/a4q?=
 =?us-ascii?Q?PymxfcxQE29phh0/v2QIHv6pWwNLEzZapft2tDNYtDpncJ+CU329AFIV/JWk?=
 =?us-ascii?Q?a9jQPo9MDcXqdhhd92nNn0mrEOqiyojx/CnNVrcIEuqdtkWpzNnKd29wXgKK?=
 =?us-ascii?Q?DBHZqnfAo9uoLeoUABcovX2vr533X14wpdll0iCABavdhiiv5oUDi9z+jryR?=
 =?us-ascii?Q?2pUMvgZMo/WTnWsrOstNOlBwu1I8YlZN+MsXnlDnMs22AuZ01q0XpCcMoQ8n?=
 =?us-ascii?Q?lEysAvE4ggLzGk8ORnd4GThfW0GTZMVEVSD2gfz/GjNxaaBlDmovmVjiZeLU?=
 =?us-ascii?Q?32/GEvk23Q9MKo9nuYH8SV6Hb26jDzuQPODHPgFD/bmltOKeXYBr4qBgEm7k?=
 =?us-ascii?Q?L/ruh8IBx8cAPvpkdYMc87tdHyN97dbgMHr1KaFjt8pbAoD9ou6t6lXAmVcl?=
 =?us-ascii?Q?vVIdpNFHFExrnObcgHvr6hhXi5v9oIcS5myaYxdjo0VuwR4JgQ/c78H/qRPq?=
 =?us-ascii?Q?aMzwgweRmKtgGFkJyqYSryqdhxG4jvExTfYBj136Rb4e8xTLD3l72BSmz7cI?=
 =?us-ascii?Q?Dw7o1euK1q4vasHB0SxbU/ROMFnuBHi3X4XaNs+t5tu1JT2P19q3ZzibnlrD?=
 =?us-ascii?Q?cVdL4xVP+vZ2pvk6ojfHO8KBZbeKG5+7ee9/7TJ0ZXxW961HFgsHeBby1vgP?=
 =?us-ascii?Q?K3EattJFD7e2JH3LH5xNAiUvTrmj+P9skwJdewAbGnEIAJXMsoBMiErQ6A4f?=
 =?us-ascii?Q?Jgrg8Zz4CEAJtoP53CIA+hP4ew8l6yN6DFvkNwzQLAdKJsV3vZrsBEPE2LKV?=
 =?us-ascii?Q?UJwOt3UAKTuZo7CdIRdDXYO7oP7e5UjZg9h+CudWOcTpTBjOBet4cKmnGNc7?=
 =?us-ascii?Q?DVtPmJroIdjtyUUHMUz1JCS0JGSxKyPM2+UTrsUJAA4rxFLQuIVpFZBWpaCb?=
 =?us-ascii?Q?g+GHxedFFNJ8dET5OLzaNJs26RnrX62C6191y23mMzLXteKurc/Ng2bK363v?=
 =?us-ascii?Q?gUjltuXu1qgRrvjXWS12vLumCUCzBBdU1yOuCEUDqhTG/4cAmudK8dSgg5qp?=
 =?us-ascii?Q?MTamJ42VtTdxj0T/k62WzXlIdN0VUBgRePJB73nQrhEZwr1fEAfmRkYYAoWE?=
 =?us-ascii?Q?tAZxP7haRsb8gCoAEqluPtAldZ9AMGObg+D50S6L5lsFNC8PHpjjiPp0MBQP?=
 =?us-ascii?Q?o+e0LauyCFh59mw=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 18:35:03.6037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e968d721-ce70-42e4-0018-08dd6714c3c2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8280
Received-SPF: permerror client-ip=2a01:111:f403:2418::62d;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
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

On Wed, Mar 19, 2025 at 07:09:33PM +0100, Eric Auger wrote:
> > Option means something like this:
> > 	-device smmuv3,accel=on
> > instead of
> > 	-device "smmuv3-accel"
> > ?
> >
> > Yea, I think that's good.

> Yeah actually that's a big debate for not much. From an implementation
> pov that shall not change much. The only doubt I have is if we need to
> conditionnaly expose the MSI RESV regions it is easier to do if we
> detect we have a smmuv3-accel. what the option allows is the auto mode.

Mind elaborating your doubt about the MSI RESV region?

Do you mean how VMS code should tag "accel=on" option and generate
RMR nodes in the IORT table?

> > We certainly can't do case (a): not all TLBI commands gives an "SID"
> > field (so would have to broadcast, i.e. underlying SMMU HW would run
> > commands that were supposed for emulated devices only); in case of
> > vCMDQ, commands for emulated devices would be issued to real HW and

> I am still confused about that. For instance if the guest sends an
> NH_ASID, NH_VA invalidation and it happens both the emulated device and
> VFIO-device share the same cd.asid (same guest iommu domain, which
> practically should not happen) why shouldn't we propagate the
> invalidation to the host. Does the problem come from the usage of vCMDQ
> or would you foresee the same problem with a generic physical SMMU?

Host (HW) would end up with executing commands that were issued for
emulated devices, which impacts performance.

With vCMDQ, QEMU cannot trap command queue because all invalidation
commands will be issued to HW directly from the guest kernel driver.
This includes TLBI and ATC_INV commands. It's probably okay to run
TLBI commands with vCMDQ (again perf impact), while ATC_INV commands
would result in "unkonwn SID" errors or directly ATC_INV timeouts.

Thanks
Nicolin

