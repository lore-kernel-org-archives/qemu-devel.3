Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7650CA9EBE
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 20:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFHEm-0001bR-EV; Fri, 09 Oct 2026 16:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1xFHEj-0001bG-Su
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 16:30:37 -0400
Received: from mail-northcentralusazon11010054.outbound.protection.outlook.com
 ([52.101.193.54] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1xFHEi-00073t-H0
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 16:30:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5xJ9RHbkcYfwq/oa0yuGjMNrWIIgCGnhzIE0ebZPOPRigrPIt2meBUvJKm0gxLek1kl99VKCci5gpVYweJa2xWm9DHbsYAY4VkWRrdhKTx76R+k7x9tA082xvALzh8HazAcZr7koNnAL7q0rFF+nxl5BNZtp28NC9HFXppmjR+XVdeKCexdu6z31yB9SxyeysAhEqcSnaU0XazE114HwWV/s1OYE/ngrqF8U3F15qsFzuGHJobhwSVyyGDIbNHrmJl5ksR9og9xIA0B5EyxrE0p0kZ3Nf5r0uBWEYZGdcP4GlyQoct0UoVF/fmQMH7O8WrZdUB5a6v0kjKL8vAf2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0gpEl9yerJ1xZSxkCpZixDXDLXhTNXNk3YGZXYW32Q=;
 b=KqZT+ZlZDpkOhLUl95jIF0AWvzS73PYfKC8eI2tNiVt6e7m35a4TwrAokwC21gLDCtFpjRsxS3zoRL6OR6x3pUQoht0dCqhb/76zqrZa9f+UYpHDnZwXLa8opH1xU7EZpyhEcS5IpL+DFePH9ymhyrPmXzsHhVnLD/RHCcnvUX7t/FahHMXpBTcUUIdneXcb/KstDikllbxW2s5sVs8CCAuhRcSigVnG4m9cdaDxwyFxuzyZQz68CpcDkWcHGxSm82mqeZIGyVAmoQdKz10kokCIr+QXxUGhIhuoXkzUzXgwwLQ2KpXsnjbeRVpZJolPhvAeMdnmcyUhpp9/DWos+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0gpEl9yerJ1xZSxkCpZixDXDLXhTNXNk3YGZXYW32Q=;
 b=KTAa3smEeDuTMakB7BCHH2exsRMQKcWj3YTCo8uI1IV63fHV0mKIBpBRAsT/OT1DWTN7jgen7GDl+eOrMpDbMHaMR6rFtdUuYOeGruxsTcA2nDj6CMnLkiFwzyCZ8a3Iti3PH7q1AdHYBNGydSg5Q1A4SeoCq17wl34G3j/TkuovHbbCdwLqVZmiEd/KqCaRXshthJ6frZvVNn+4ZFWldBoVaEZnC4T2neYen57SnkmZq0F7N4FO3LDecmNrQcePFsDOy/nVz3VNAMTMeBO1DLeWnfGdXDyGY9P1B/wWL9E4lG8RkCKEqM2JR+CmKFwpksz6UF4dXfY7O9dXL3Qisg==
Received: from DS1PR07CA0024.namprd07.prod.outlook.com (2603:10b6:8:44d::6) by
 SA1PR12MB8699.namprd12.prod.outlook.com (2603:10b6:806:389::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 9 Oct
 2026 20:25:21 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:8:44d:cafe::19) by DS1PR07CA0024.outlook.office365.com
 (2603:10b6:8:44d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 20:25:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.0 via Frontend Transport; Fri, 9 Oct 2026 20:25:20 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 13:24:59 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 13:24:59 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Fri, 9 Oct 2026 13:24:58 -0700
Date: Fri, 9 Oct 2026 13:24:56 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
CC: <qemu-devel@nongnu.org>, <alex@shazbot.org>, <clg@redhat.com>,
 <eric.auger@redhat.com>, <mst@redhat.com>, <jasowangio@gmail.com>,
 <jgg@nvidia.com>, <skolothumtho@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@bull.com>, <kevin.tian@intel.com>,
 <yi.l.liu@intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH v8 2/6] backends/iommufd: Introduce
 iommufd_backend_alloc_faultq
Message-ID: <aslNmEcvvRVReRCJ@nvidia.com>
References: <20261009090737.3930000-1-zhenzhong.duan@intel.com>
 <20261009090737.3930000-3-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261009090737.3930000-3-zhenzhong.duan@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|SA1PR12MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: f536fed0-7be6-4d1f-6997-08df264370ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|23010399003|11063799006|56012099006|4143699003|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: oy+pf2zbugpwpWoRmo7MnpF8uPFQ9POfjAuv0zCd+E/BuxOJIjr1jGXcF/Iu6UidLA/KP0gZIEfCspMc2jwBCkOrb65suDOZg6aneV0L5dpZn+QhUkTRQ8x5Ju7izxkcPwgp7sQAJW/7XfQyGN0OxCB8Oj9glqiaKp74i5e6+6dFtiFY3JBPV2FRGfoLJK4+WmX5ArK9gKDgR4u9cFm60REtRpYMXGlsb3qWGKB357+Dys/L/xY2EhSSbDArkbPhCU2ffnMfwjt1u74EEQ3VitipNFnTqMoYkI7vgWgDYUT1/RL32n3qvmgyvr4MThlN0z8Q3ZU6lIhHPfVKoZQLewnamDEk/Hibsx6Efugy6vnmQXBTPx/QwL4UToeB4OkOGb3W01gg3JBus20H/SLFYJ3npJ89DTjiweK8cp4LVT2NHYVopHUVAnvG/nwG2taqLxUOnd1+mJKyyEomr9+p1yjmQeBoYitGKaEI+rgbb8MPIHJSC6xPAvWQi0zB1u1XJqawLyTE1GyJCTeV3na9n5g9tqU5QtuZhmjBWML5KYaMSYaI/lttUKTGd3cds1MinGB1Ajk8Rxwh214w25Drd+5TgAXm9KTMeRg/ZKhnOHiBcOeSNh68mEJrb4mRnVNCcKYAWa3NDd9+Mm0Yf6uurxOPu3f6JK399j474Tdl+c+sOV7aIX/PfCDpflHudjUPtPPQRqBJwyhw7EAXzIZvJQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(23010399003)(11063799006)(56012099006)(4143699003)(22082099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: skaGDt65K0rEFrqC/g7IKqabETr5RWKFiYubBHBabmEcFU+qk0U6t3WapjlKLpwTm6MNrBXBZBNeuSlUdMgCUdH64P1k7Z5fHjUOWTLf1h5jvSsMhk+XIFOkWyvoegN1C89Ffaszx51+PmnyzmSkSITSZ0hSfSkEQXPebEaSbuJw/OHcf3yWpVFZkSQo64dFq0N+XY6x07BtIXRJQ2yYucYzWUqJGEaV9Wax6Q8Y5y5Z1WjNi7Pp7ExOs9YGHZ/4NvEGLEn1GeI75OFbZmwjruaz/ynEC5iE2LLgZ/S5nA77N0NIPEoO+8UtAsrwp3kXVc6pM6GFTMGmfGl0sJzjDrPxqnnGuv6rTWeJjmxgsBY+2ZpbMU6jhmIMdKgwq8DVY9gH3gn9C/C9Rq+qZgR/H2IGJ4+xmeb+IQmOuQyw7+CQ7o9LW3BjZAomhItT2sD+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 20:25:20.7638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f536fed0-7be6-4d1f-6997-08df264370ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8699
Received-SPF: permerror client-ip=52.101.193.54;
 envelope-from=nicolinc@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, Oct 09, 2026 at 05:07:32PM +0800, Zhenzhong Duan wrote:
> Add a new helper for IOMMU_FAULT_QUEUE_ALLOC ioctl to allocate a fault
> handling object which will be used in hwpt allocation.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> Tested-by: Xudong Hao <xudong.hao@intel.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

