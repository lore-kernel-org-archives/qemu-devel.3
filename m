Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B487EF99E2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 22:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vr1Va-0003nZ-Qy; Fri, 13 Feb 2026 17:19:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vr1VX-0003ml-OW; Fri, 13 Feb 2026 17:19:27 -0500
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vr1VW-0005Fz-6E; Fri, 13 Feb 2026 17:19:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jUwpbvIzw82Nm+lro6it3hlK+5rTU586bVNxUZFds5iDNlZeFIrPoA7e4Tqueqvh0kQDEXTqDb0LEyEgG0jrgMCH4pKuBESkNfTCjaJ7H2XWHIsJo8Ig6fidfREwS/+EQnsTfH/U/ueelMA2Vnzh1hj+ZSZOshhBoSE1yHb33ugmqKgISoWj6Qr9EJT/WsBu9TdFxNVpuV1ferhHJ+p3RETnFschEHswfDFpmWLwkmuhFz4XxjlKil8JG6JGCOiJC4cbjNSmTCvAY2+P3WDoPgzC4hc1vvs9xotqNT8SYY7sBIp5ZqM3yURv/ZmCtxMp8qnHPmS/JO3Y/rGhMKvNUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjpvxrqS5oIg8ymoK6xuboOEvQtBzVLnH00V4QH5pXE=;
 b=x+75zh0522SrYkVDuIeP27DKnASRXPvUuygUgohclH28BbtOZ9d9BwNlR7887YchzekAhGeXh/N5RhVQ3aWUOcSIz7LSldZskKteLmTGjQ7qJV49OGvYLf1cjQ7Sox+LTAxdSJlIu/HwboFngLjY7xj5BlrEDCgeWUpkW5Q6YzssLeWmtAe4vCDnK+TcqU2E3PP75oDX9Jk5G9rDzF89YfznSA2rs+v++KEnASvlpt2a2q0i+A2Sl/tm3zd7EVnf3fSOdT0HisHln7F6bOALb2l/gQlS5+5C18+dkpzPjBjWSCqJsoXJws7MHt5J0uksA4JtIfZ5HWoC4rKZDsevPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjpvxrqS5oIg8ymoK6xuboOEvQtBzVLnH00V4QH5pXE=;
 b=I2SwhetzYpyCwwBraMjQXiqAgjvTbKpPlVvN5/OWSR/wsKVd9DJFIkchPRkt62p0/6vPYr1Mivu0A8Qbh4Vnhne121VaN7PjpOCP3inrQr8qvrG8EhFuWlSrIqrK+2B4fa1yqFE5mL7daHqqPkYjiV3EAeSr7kOw+J+ysnJadfjKB7EIdHWoAHSdE4e3JA1t1PpT60mnLFkTxtZC0RvpGN8nQfOFQuSt+AQ7K/cO+oRgDxwIihD4qmOClpbLDaIB4SXZpclEEx787l3HucORSWOtPqPLQaXzi2LqCibzrJJEKDuzW/y0B5apgH5lllXV0Onfy66qiVpLGUVcbYXYmg==
Received: from SJ0PR05CA0181.namprd05.prod.outlook.com (2603:10b6:a03:330::6)
 by MN2PR12MB4173.namprd12.prod.outlook.com (2603:10b6:208:1d8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 13 Feb
 2026 22:19:17 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::93) by SJ0PR05CA0181.outlook.office365.com
 (2603:10b6:a03:330::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.11 via Frontend Transport; Fri,
 13 Feb 2026 22:19:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Fri, 13 Feb 2026 22:19:16 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Feb
 2026 14:19:03 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 13 Feb 2026 14:19:03 -0800
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Feb 2026 14:19:02 -0800
Date: Fri, 13 Feb 2026 14:19:01 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@nvidia.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v6 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
 accelerated SMMUv3 devices
Message-ID: <aY+jVfUUTawwPN+f@nvidia.com>
References: <20260213103942.142823-1-skolothumtho@nvidia.com>
 <20260213103942.142823-4-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260213103942.142823-4-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|MN2PR12MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: 96039de1-47f1-4cf1-e509-08de6b4decbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p5trjb3xJiIsBMhAYMw4DEMWF4d/12RIiJTfGv6Q+aAhpKPmDz5r9ImVVGdT?=
 =?us-ascii?Q?/x3WoVENZTJIGaMi5Lvkv7rsAJWBXF+3WedMFSp5VWJrrNND3lYNd8MMlEC2?=
 =?us-ascii?Q?MbWP4+ww5+I3ZNQYPe3Zde8upDrkPSj+INNL5cpPqu8+//Ilh7VTu0CUjc4r?=
 =?us-ascii?Q?WC5RlcV+44pmbuZcJiIQ/D8gKmpNhsrm6Xi7dqxCW/T21v18hSAXsN9e+qYv?=
 =?us-ascii?Q?qG2qKk05qHnP29NXAqtVdZV7dX8YJ9lZeZ+V0ed5dLk48SOzCQ9GEe9yh/ea?=
 =?us-ascii?Q?x2FxTaxi0avWP45oJ+37vPEESf4WkCV0sqHQOQYClGl9mJHAZyZxSX1sPX7P?=
 =?us-ascii?Q?aTZ3DFMVgUcH2/CKe1h0MOFPBcH84ZZuD+lLyHNYUpj1y+5eWGCV21g7KWAF?=
 =?us-ascii?Q?4J4SOJjTJB8frOdb9ON3jev4ixbuYbDPlxf59S0Qbeyu77yPe7rCQFKBVZ3s?=
 =?us-ascii?Q?eOJXHxQmjjfP1uqG6Ori+2nPTf2lFfxWGRjfbZ+RIx8eicC0uNuV7KjfIqdY?=
 =?us-ascii?Q?9lbYkNlXzlA0Xd3A2LBkERbsCpKEsSi5KYW0G+bJxU47gLIh3wTrg9kOuS74?=
 =?us-ascii?Q?h9BxezBi6I/HXAXUYgRVRHi1Yh4BkySGjfPA7CFEH6dOSIskzihJJ4Oy2VRQ?=
 =?us-ascii?Q?3PcruTul6nWkv0LgJAsTDWw+vYjFTo//6LINadmtRk9+LH73BtOPEoCN/j4d?=
 =?us-ascii?Q?4UOvOr57vNU05NFZOb9TnvcNk+dTp6gP67iPxSEXQpIAOm4tFEXFHU9jtqvL?=
 =?us-ascii?Q?fXSsxRwYvefqPZz2kJUco5aBBmBU+JkWxAlTmvftZNuQtlsSytbJ2aTtVGnH?=
 =?us-ascii?Q?GQ0PwmYxU1ppSn3x+5sUaK61LQDfrm6JlF99X4vvtBJNonq6wIkY09gwzn3V?=
 =?us-ascii?Q?UXSTMj4CcDnmGcMiGIOd/aj1+XjDIsNWPWkacmNkPWM7imrKxBwTVcnykR2r?=
 =?us-ascii?Q?rgyqRE+gUDXiIwpVROolqmFAuPAYBZOGQ20NgrHdXYZh30fqZhGm79i6Jvej?=
 =?us-ascii?Q?Hxgpa0/sFXxZKjjkz5Urvw6iBZWCXlNv7HPd7IfzYsjboNwcIbwOPAAFUNZo?=
 =?us-ascii?Q?YKPuNQrDRjK04BTG5ORSgsAz5MeoRgai0LbIx0SOm8I/TXvB+RUA7QTms2l+?=
 =?us-ascii?Q?x7//Q8/HRrx8NBLVIxUAudL7NdPBaEEKhLNCuR85bSmOfDV7CYThBNnxmq6V?=
 =?us-ascii?Q?q6dNg7rSnFUSHNVEdAI4YT4Z7pmf7oe6v1GH0XpTH/D3wN5EPzzfHvPqjIjm?=
 =?us-ascii?Q?RAQXmCE+4DeWUTm5mnU8DdVSISr658a6FSP2ItcU7rSg1rDPCrHhdqzda/wF?=
 =?us-ascii?Q?YZZFUgJvtcdGEabTTIzGaZGX5O4lqxKd9BBJe/xkysLO9beC+RjN4yd0nv6K?=
 =?us-ascii?Q?VEh8LLXmuNPrLw9vIePTlUmbu4Wr7GPIn0rJtgflir7n5L3yRKZAd+D15Ua0?=
 =?us-ascii?Q?g6GPWGoT55G3O7DpRKbnCuGytWnK8vSVsSQapZLR1WEdoKqIl4CsNRIRx5jr?=
 =?us-ascii?Q?iEJZJydzpxcckFJYqRSZOGCcgFfkC98nc4eGyGq29yRaPFNiyogNZiTijNca?=
 =?us-ascii?Q?m+LWdnPly6dwD+HDonx6l/imRuTulJfCvlnhzZMyq2pAst8nAyy8D6X3pu+j?=
 =?us-ascii?Q?YpvWykv1LX5/2jDH/5Ux3+LCDo8PU2RVHN03SVOy0PfRNMDhFWzDlf2cR0QN?=
 =?us-ascii?Q?lDIaog=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m9SlesEp9zTpaqhz8yubcePvTcztAtekVMTCZ7gGKOaRic2NSgb1aJHfQHBnSkYlsdOC0v9Q0hgBFV8N+29rYrJNLKBhNgAkTNXQZlOsD+uzQ47nUDLRfuGf93YS6Cyv1GqTmDMY3iEpxg1Dod1S/N0dmQsn81lDDMNdLguCdoJa1ydvOVmb6JavUS7Tjca5lNPh6ltandKq30E6zRW3WDlC7gqL7NbUXDbQofonPaghcDPyNHwZPqv/y7dzKIPdmEEavu5qvfF0LdYrlE6T7U/YHfZZV3/C8fcOi+gfmZ1+4xYCBASQOfHjXumZaYn8LIFmd2SgTMe72iX8NGZmVmxXLsyd3cDbivaWzrYAJzFUgMw49t/g0L1+8M4FnNjQIVBPtxPyU17sl3zDAE6etcVyyEM/eKMEc1dYgJ+Z3+jT5fvSiQk+nHNgMJozBMTP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 22:19:16.1240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96039de1-47f1-4cf1-e509-08de6b4decbd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4173
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=nicolinc@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Fri, Feb 13, 2026 at 10:39:40AM +0000, Shameer Kolothum wrote:
>  static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>                                 uint64_t data, MemTxAttrs attrs)
>  {
> -    Error *local_err = NULL;
> +    Error *err = NULL, *local_err = NULL;
>  
>      switch (offset) {
>      case A_CR0:
>          s->cr[0] = data;
>          s->cr0ack = data & ~SMMU_CR0_RESERVED;
>          /* in case the command queue has been enabled */
> -        smmuv3_cmdq_consume(s, &local_err);
> +        smmuv3_cmdq_consume(s, &err);
> +        /* Allocate vEVENTQ if EVENTQ is enabled and a vIOMMU is available */
> +        smmuv3_accel_alloc_veventq(s, &local_err);
> +        error_propagate(&err, local_err);

It would be cleaner to have:

     Error *local_err2 = NULL;
     Error *local_err = NULL;

         smmuv3_cmdq_consume(s, &local_err);
+        /* Allocate vEVENTQ if EVENTQ is enabled and a vIOMMU is available */
+        smmuv3_accel_alloc_veventq(s, &local_err2);
+        error_propagate(&local_err, local_err2);

Otherwise,

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

