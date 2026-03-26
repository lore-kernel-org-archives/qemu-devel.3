Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E448210AB827
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 22:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5su6-0001rx-GW; Thu, 26 Mar 2026 18:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1w5su5-0001r7-5Z
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 18:10:13 -0400
Received: from mail-westcentralusazon11010005.outbound.protection.outlook.com
 ([40.93.198.5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1w5su3-0006gn-Gh
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 18:10:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNRxyiS7fxrKoEOLhHfmSDmJk+TE2SZu2aN1jwgCSaZ6A49fcdBtkoSJLdHKLVh5JX96XJyoxSsexu4+2gJrqJn/jlT2JjTPVNbrkfPAuSCseK3dBXLA4SCYFJ1alGR7fo9002MVkOOOlVBoRAM/jq/Cjev5qtw8lBuPlrr6191FWjMQmZPwWYhpa3udIwUahbisbDileeELCUuhYVOoypmFL/rhmMlY8q2dPnJqAsb8k6CtUEOymFYwXXxbZ7Dp7QBam42T3vt46b+RYRbYRGqjEAX0iXmxS/niH/LqRLxgZYDfJaAJbtlRgNKsICIezIZd7PC2BJru0KeY47Hzvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eN1LGfO/c7+wh2NrJiUfEkwXlpNSTyKVNUKYiVkHdOk=;
 b=qrkmZXbZztcSFMMSudrDbMmRaOM1F6vCKQSG8km5opNd6UKxxTX2sKn7fC0WR7SSUHedASrBUKMRXFormgEJuhKiqezpMjf2dk+EHIREeyFBAIeTvskeiBTSJjmX/jkUyJJd03bJtVaAu0YIwTmPlNzCjnAv+ehWFWxek6K96CAar839O02g51ldcNo+zcyfIesR1g4ert2OquwnDg1Ps8nwU3ebQ2gCBkr1ne69XLEmGHejadNjG1V+xs0W6fnevWvMMN8up1WEFHvWu3I3qI7u+XYv7sKoKLNY1eWVhRu4KTaJGViB3zl6IWD/ZL9I3J4VQKLuIX+8f3XuR7DpBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eN1LGfO/c7+wh2NrJiUfEkwXlpNSTyKVNUKYiVkHdOk=;
 b=IDVMktQN9t5M8pMgWb4SK1M6lVJS5v9CO7WfoCbC4fq+ixAEBbbKi1jgGTEj2XVx/FuwB8A+5Qo1YHjI6KTBC7WFx8nBnxSGR8p6NpTqp0HR7otU/eVihREGRZoAo8qOS3glYBi8ZjaajkCNdJ1hsw5go0bfNFmxkkT9CO/cpGHFh6S8t/aPtH8acuavLHZPaQa0YOEl9UTQhoE+4rpKUwma5IqxiGrBvgiEqUxB1PE9gpU9+LBJib/asiDLwH3THlvL4CcaoN0MgYbTP6u4vjZIueUrodbIpyvj3wsmCcsHJ0aZDx0Bz3iEyDBJ8Eq8+7M55bF+GzTtGQGAkTQYQA==
Received: from SJ0PR03CA0189.namprd03.prod.outlook.com (2603:10b6:a03:2ef::14)
 by LVUPR12MB999160.namprd12.prod.outlook.com (2603:10b6:408:3a4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 22:05:03 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::5d) by SJ0PR03CA0189.outlook.office365.com
 (2603:10b6:a03:2ef::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Thu,
 26 Mar 2026 22:05:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 22:05:02 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Mar
 2026 15:04:55 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 26 Mar 2026 15:04:55 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Mar 2026 15:04:40 -0700
Date: Thu, 26 Mar 2026 15:04:29 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
CC: <qemu-devel@nongnu.org>, <alex@shazbot.org>, <clg@redhat.com>,
 <eric.auger@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
 <jgg@nvidia.com>, <skolothumtho@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@bull.com>, <kevin.tian@intel.com>,
 <yi.l.liu@intel.com>, <xudong.hao@intel.com>
Subject: Re: [PATCH v2 01/14] vfio/iommufd: Extend attach/detach_hwpt
 callback implementations with pasid
Message-ID: <acWtbTQHgtuENzLX@nvidia.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
 <20260326091130.321483-2-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260326091130.321483-2-zhenzhong.duan@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|LVUPR12MB999160:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f91e0c0-529d-4750-f122-08de8b83bb26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /ZLTceyRM+4W6/esHnVw1Inpq6j1pHj6yMRe/ZTL2A9H06wdlasC/i/gezemv/biUOfze7g3G49tm0w+9gxlE6uGwlJuAgWe0YOlFFkz3zC/OWybL92zjf3IuHbrqwBTobB7DiX7YfGZX5MphTsamyr+KHc1/L/GN1LCMk3rVi8TovO0lf1UnrLDfwqfQ9kovhBtY3KnNVvX/3/pUgCfBhqKqG6icxuFPmaU6TCCQ6F+t9SweTfMc3XkRtGY+9IBPGib/HGUHAa5KCl9zwM4w2BzgKhdOm4/lp5Bon2UyaGAESkjRwZ7Lq5AG1lgZQThYttMJJME2y3ZDjIqioxNZg3gqcayBRDJ+U2j5UOFfHVaqHLJVzgxN5+cjAh5WqAS656aohQ1R1WYIOnUkJB54NbNkKtZo5RLtebOVtVV8LpwPHCKlFe+v172nD11sUAu/9FN/DixFr2i5z1iMni0qwbY5BYYOVqSe57Hw624dd1ZgvetsiW60Ge/Q1IMyW2cYWs/LGeCAM5CbR6lARt3UBx7uOD+cl2mMsc6n9lXSrfpy49YWkCEQ0rSW3AGCMSJgHXmXX64M+4y8Yt1hgmDQuTlxn9yCqAHZCkh+Fd42E/MQGp3XS3EokYtOqlCQ9K3K0S+DG1ZTidRXUUfTSjeaV9CrLlugRrKL5gSRczvoJC7nbhjcch5S8cvcJloDjkd4u5obxqHhRf5gnYNAZgQXB7LRIhd49p7PhGdzwYo+9RMNrAQDYutIsCjEXbgDDAlefoywtY0HDoYgcUiXF2/1g==
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Mb6fXNFXZiXkfZ3hXIxRjzVLExT4rq8ZeGUZ4yYsh2gSMgrQORpLNGua7R04P7JE2y6Dp4p6C05cbyrLhOXBQmyOXnPEZtmnhgtNuSZTbYn9aotPxf3NqMFHydhafx3SOzEpeS+vPD3HjKwY82Tnhb+TNiZ08NXQTvga2tS3AK5tXYmZjYErOZezXJBN28dEYNFK/UzuHM7cB9eH1ZboerpfE3ychtHsLPQvXaloxP2NXf3JBoc+JdioTdWUQN3LohOUax6taGYeRYljk/ncnM3MHLBKMpvRkhpSNS7FtkfzS1NvR4vNwmewCaKcIoImL1bikh3DYZrdxPpLlkn9A4KvnGp/ZU5SgqrDOY2fDscZTF5CmVcI6x4Xl9JH/pG1p2YDiDNJH2pYqkL9ZEfKBZfX5aA83wcZK4v7tX1eWIhb1vYqCLpjM2SQ2GFE2zbp
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 22:05:02.9711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f91e0c0-529d-4750-f122-08de8b83bb26
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999160
Received-SPF: permerror client-ip=40.93.198.5;
 envelope-from=nicolinc@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On Thu, Mar 26, 2026 at 05:11:15AM -0400, Zhenzhong Duan wrote:
> For attachment with pasid, pasid together with flag VFIO_DEVICE_ATTACH_PASID
> should be passed in.
> 
> Define IOMMU_NO_PASID to represent device attachment without pasid same as
> in kernel.
> 
> The implementation is similar for detachment.
> 
> Suggested-by: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

