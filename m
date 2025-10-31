Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8593CCFA05
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 21:12:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEwOv-0007CG-Pr; Fri, 31 Oct 2025 17:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vEwOt-00078G-BV; Fri, 31 Oct 2025 17:11:12 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vEwOk-000104-Ij; Fri, 31 Oct 2025 17:11:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTrhiSAiXVUGEs76WvWxQbJRvnUMtuQd5DNECDPPScWnIc56YcAraeKDErdKBwGeJ9ATXQ6woywqMV41BY0QIh/QgJ1h3kuKEMW8xIvXLYL+mR7wOmUF1Wi3eR16y5rccEcPBgPEluFm+jXhcOLm1qy+0jhtjVpGU/9+vkU5IORWJGyAyBXKa/iTIRnsNMxyoTietQ+vGUjX6FCZTMbHuo4WcblraGb9UbapK73mM+iaGUXN/eLXv5FjgPD3zqlTQum/YUluS2wZYS86sNOrOJx2jkzr/pjnT7EYUlX2rLAdxUUt3ckLOd/7SZl+mxkJhW67pyNUfVoO0CvzQUBPMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPGLtVt6Uh6JkpMA9nNpKCEcIGHhQedbkd1HRqA/r7M=;
 b=C+AmL5QcWkVGWbAfUSiI2f64UjlSPaLwdtbFvDr82xtWjY3mHc3lOLjeH+qk/nABPEkH7zfXRo41VWolzPa8lLV3lCajv4afUKbBKd/Td2bPJsfmjVOsIk4j0YUz8+qsGaABb1wObjQ8FblhLL4/Gkx9tmyxNd/XCsFWT7/MyiG3TLXZiZDEsW0QoFhZuWj/A5Z/6RxN2kZnVVK7Wp02SmQqcPB9cuo4k0fiM4SpTKhlHlz5p2vEvBYoX6H5k6oltXSnGoKzXNjr8x7+uLuBPAO/UdaJAAtv/Uoqo5IXQ+Q6O/mXv3YYGXk7mwCXIojQ03rlweHS10Rw/SkjshV3Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPGLtVt6Uh6JkpMA9nNpKCEcIGHhQedbkd1HRqA/r7M=;
 b=Pa5rJ0i5sdTMRzewW5nC2wxw7b3dOImxoJX4vThvpcbDO6tDSN702rxIqV7FETPSWZLEyqp6pmDpoB9O63BHSAMtKg/D4FJqoT+L3fabkeT51PWpx2X6ndsXiBqugC8IE2Rz8wxg0KAiVbbmJtU737NcLO06WOBxt2yS23JqbiIqZSAvW83uVVMq4bTv5VWE4R+reM9Ek1+/wWdcETCtzUvjyI56xYBR7V5v9w1+XVvlv88E2XN4c1960+hYZR2sflj1kgbeZHZwrVP8BNxTxhZouHGVnxeJTzJ7VnggbkUaGrG867nx5dqP8fHtBXmwPlAGr2VMiDcuwndyFiUQGw==
Received: from BYAPR02CA0038.namprd02.prod.outlook.com (2603:10b6:a03:54::15)
 by SN7PR12MB6671.namprd12.prod.outlook.com (2603:10b6:806:26d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 21:10:50 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:54:cafe::c9) by BYAPR02CA0038.outlook.office365.com
 (2603:10b6:a03:54::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 21:10:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 21:10:50 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 31 Oct
 2025 14:10:37 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 31 Oct 2025 14:10:36 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 14:10:36 -0700
Date: Fri, 31 Oct 2025 14:10:34 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v5 06/32] hw/arm/smmuv3-accel: Initialize shared system
 address space
Message-ID: <aQUlypv8TqmZM0PU@Asurada-Nvidia>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-7-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251031105005.24618-7-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|SN7PR12MB6671:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e2c70ba-3e72-4654-8dac-08de18c1f842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|7416014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Jss3jtMVFZg/4LS1CnECgUFY2TxPJnKcbQmmvdXPsQuCpfQwDZgk9uytnxvd?=
 =?us-ascii?Q?pC1m2JsMfzt/EYN5+V3uIu7zeXcS42OqrSmtSdBiyFwSM4OxmA5e/6Hh96lN?=
 =?us-ascii?Q?KOsNsm3sg6wP1vtGOofcE/gxcRYvcwOT2vP7mVZv1STSQ4kIjqtrFcTm2a76?=
 =?us-ascii?Q?JAWnExVgQJ8V4oEZ7atiGVDD7ZWfAFJHAvFGTims3IcSU4gVUjtztgWOvXuo?=
 =?us-ascii?Q?/cRNIbQihM9DsZ1051XhyLHuDCUawf1aZKoZvnUW7QQsYR7kNPypi2KuWSH7?=
 =?us-ascii?Q?M3iWqZP7/can0LP5A9N1Y/QXbP3Iws9CLPYpEUCOt1TjxbfXNFWPN0hfq+iI?=
 =?us-ascii?Q?S+ztcFUAvwNOQA36uWw+uvURysrWGzoN4nSlcdI5TbVBab9yaVTpXvb6ZN9O?=
 =?us-ascii?Q?1KnbEwqFKOGx6Tsr7ZF45x4jlIB2JvDPe6JbQQURkLzPSDuPHKdQJIXbjN0A?=
 =?us-ascii?Q?kLFUlvQK+VE4H+rliOYX9diU8ub4NSJo1vPc2vz3N0t7+KHLDrfJgbHLZqPd?=
 =?us-ascii?Q?Z0j/4xIp2RfIilMd8F0tM0hFjsyKeyo84LWgRrLpeeKZSoH9k/RTO41/QQpa?=
 =?us-ascii?Q?jiku7IOTsM+aY9B+VUIOTcfc7MC+Lzkvo4SCFf2aKy9rYMgnbKLzIaOyAOzT?=
 =?us-ascii?Q?1Q/lmdVyb//eqE2OsOBPMzvCi5srgAnKBp42MuioMMGJSmZGbJZu40o0j28G?=
 =?us-ascii?Q?iwX8pSn+cU2P/h411cOu3tzATBarO96WNVDSy+RDelR6czWAc0URwNZc7jxE?=
 =?us-ascii?Q?d04TVwJkQgu1WJow32H8vWHaKxfMaLFOobtp9QogkAXotl3BNwxadS6wPku2?=
 =?us-ascii?Q?3TzXr7ynHODecvojgv+cHi8RFM09F5tl0GjFKl8EqoW0wHPNLQxaqvX1WRdJ?=
 =?us-ascii?Q?jJAn9IiioI7RZtjdeO/f2QKzzsJrMkoYzYU1xDmm+sEeaeDZbcVraoKoqR5q?=
 =?us-ascii?Q?G/a81r+5ibvcDu29/ygddABQ4S0r5ZktNlMw/IzJsfdoJwwpMTLRoZf5aFVt?=
 =?us-ascii?Q?yNGUMITOeWBjifn6hzGYGyVuEMQS0cDstnYAv79KHqgNGzO2vHkpQH9cFdzM?=
 =?us-ascii?Q?EeaeU2texMCRkVoE27G0xu8ztzdiXaelOhYdgign4RPtqze56urj+Y+pRNsR?=
 =?us-ascii?Q?hisMg/bTUcvqwyds4ebmri43kXEvOzPoGS0JUv83i+azqU/lqWmEdSQH6GKg?=
 =?us-ascii?Q?Qs0ATBpr9Ac8F2hxPU4sPRaZE+WCGVzovbHxdsLwfhUzU0l92AoZaoEoKw1P?=
 =?us-ascii?Q?R05X1AsE5cSfZrUpHCdOPKiXv7u6Sws7A6HzrXxuIJHF2aJ4X4XASMP8BrVA?=
 =?us-ascii?Q?+CBBOI78Dn1JmDJCkDFShehWuinMYmHHTnUEgmRPcBQvJxzGfQMHlQyl5zeO?=
 =?us-ascii?Q?bzYot3vNIwX3KeWI6iBVdful3ifYljsASJBhoSP+LmMwowr36XhBFBlrv/yI?=
 =?us-ascii?Q?HJoKGFYxfzigwF47MCXjyTwe6lWrMbKD65OKF7qcthQUmndkyULRymtouj62?=
 =?us-ascii?Q?IAFuSmxBSIdDN3Vw+odMul5bmmZRSuz2adwfy6j5LwASwmsE7PK94vV6it/U?=
 =?us-ascii?Q?oLkh5cV9H+h0KmH7aWo=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 21:10:50.4011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2c70ba-3e72-4654-8dac-08de18c1f842
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6671
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=nicolinc@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
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

On Fri, Oct 31, 2025 at 10:49:39AM +0000, Shameer Kolothum wrote:
> To support accelerated SMMUv3 instances, introduce a shared system-wide
> AddressSpace (shared_as_sysmem) that aliases the global system memory.
> This shared AddressSpace will be used in a subsequent patch for all
> vfio-pci devices behind all accelerated SMMUv3 instances within a VM.
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

> +/*
> + * The root region aliases the global system memory, and shared_as_sysmem
> + * provides a shared Address Space referencing it. This Address Space is used
> + * by all vfio-pci devices behind all accelerated SMMUv3 instances within a VM.
> + */
> +MemoryRegion root;
> +MemoryRegion sysmem;
> +static AddressSpace *shared_as_sysmem;

static MemoryRegion root, sysmem; ?

