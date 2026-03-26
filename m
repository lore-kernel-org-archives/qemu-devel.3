Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606CF10AB82D
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 22:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5tbC-0000di-8l; Thu, 26 Mar 2026 18:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1w5tb9-0000d5-TZ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 18:54:43 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1w5tb8-0000Z7-D7
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 18:54:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnGQ4+87NJ8c2xRmzvpf3A9E8r3bP1zOeQA26zl6iZewX2Fo4BMHd3MdaQ+zHKIx/Th5YBOYZzJNGmZeJlYQwn3WYW+bUy25fhFTHzI7yyIm5BIqQRvATtPlZFHX6gsAiaRssLE1BfiRBXwEdMAY2CNJSYTsD7EperoBzstxRAKYizINxxinBJ9FYOZmDpHA4r9a5n/pNuisrX99DuuBRny0zeQvnGiyNvwdTLV+O+6OTKTfhNJnjnH5T7pXqZVn7+dOkuBS0Akcaje0t5JSM2Nink3DprksQjByogjDlILFUS20DzXjo22HjJV9LyQPVMaqG0dlXlhvHWiX6tStFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=za8XwMW0M9CjZN0rQPq+IEf7Eh2cb5KjQMyO+2w7DCs=;
 b=qcBBtCKdgp+k/A5MU5cyIcF0mlJRmKHcTlzCZOQHiVT43fhJDfM0BGAQULWWqtcb0P8ctlZYXhviSmrXCzXWG5atPoAkPN1sy8QdpCfBmbwINVKbGVTMRxlCzkl4jCOABoqxqan6yuhnOuX4fyCqELKzaCz01one/sZ8Jon5vdUyIav8vzRa4vi/xwwuk/c2WMSeUmAiGC/XAleh097TJW1q+u4vGpuLrlWyW1vZlFxNEJ09U90yh9uQqZTD3Jr5N4wW5RJebSFVle/YHrpYUxkMAbqmdKY1cAVwHOlglgNUDwoUYi5vbllk5vTZy4rJBsT54CVECywS1brTd31LGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=za8XwMW0M9CjZN0rQPq+IEf7Eh2cb5KjQMyO+2w7DCs=;
 b=FrsPlCv37rYh+UCgue9qlqcnC7FIymGo+yhwFxYKLUKTLejPBehsTOD9sijlhGrTkc7lChOvFS2f79JQE1cM/y07gNQ5ve4Ba7t3li1ySIuMlesUjoDfOT+IC38Csl6obSL0ypJ/lp1/szMwCcipyxakKmkiNLF4sW0Lun77niyUoopjwm+LLUELxrTdiC4ggJQdmNNmXX2gUXaO/pg4ek451NDusQcCkQoHcQgKX2ceva25U5osWN2H/HoydKrbD5FYfMPW5TLOp5OPpPs8WoGUCTSZT4WpAA2a5rlrCusNN0pf272aguf2aa3wfEbsMTvmIUAlyzHd3Hfl635qYw==
Received: from PH8PR02CA0041.namprd02.prod.outlook.com (2603:10b6:510:2da::23)
 by PH0PR12MB7791.namprd12.prod.outlook.com (2603:10b6:510:280::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 22:54:29 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:510:2da:cafe::d3) by PH8PR02CA0041.outlook.office365.com
 (2603:10b6:510:2da::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 22:54:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 22:54:29 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Mar
 2026 15:54:18 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Mar
 2026 15:54:17 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Mar 2026 15:54:03 -0700
Date: Thu, 26 Mar 2026 15:53:53 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <skolothumtho@nvidia.com>
CC: <qemu-devel@nongnu.org>, <alex@shazbot.org>, <clg@redhat.com>,
 <eric.auger@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
 <jgg@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@bull.com>, <kevin.tian@intel.com>,
 <yi.l.liu@intel.com>, <xudong.hao@intel.com>
Subject: Re: [PATCH v2 03/14] vfio/iommufd: Create nesting parent hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Message-ID: <acW5AXhPDT+wZ2qf@nvidia.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
 <20260326091130.321483-4-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260326091130.321483-4-zhenzhong.duan@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|PH0PR12MB7791:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ca5f87e-b96e-4570-b2e6-08de8b8aa325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: TyEEbV8ji1IM2E26QdLW3JuMYJ0lVZ7hKRB9VcGfzI94cepIJMotm4glLZ4u5dXwiA9FJjFeOlwQhYzFKW2dZlSOwS8/OD8WPMktANzVdtLZ4EGwxJFG57PygE4s7FEu+d1s7pV3o+eSbSu8kx7g4RV6CV7oP7vPc1HRKl2fx7Qk1+N/PgIShq54GR7GVL1hvNuVEsqVHwEMW9ygQxt1mFt2LlGO9HIzmrAMC3rsN3+V/XRJk9xN1m++Ku8O3tbjYs/lVgT32Xu2vfNt+QFId05u7awQAq28WnASAnkVrj3O2pxeN25DXzXrH/2/D7sDnTXMYz6KIOiHXfPjz1ziPkZlp4WpSnVbSwONNFUfOzSzsf1ouu/hB9MLQHXYKqcBn4Cs1ORdub+tj/EKzRUO4EwcVhWhnFJ8BviZ2D91zfntU97kQRz4DLVP1/oFfH5dcwTS8/n56+KXF9ndl3bUOmOxQvC5rx92fbZvlgZk4CfWSUB0WzLtoOjFVeUZ4DZ+GZ5exw1xetAAzBLtdbE0S/kYl8nzZo5K6s9Am60rKzpiyeOfDD1NJ/RNrLgFRH6FRwqCjAGJUHmkxARBxEKU5jw/6NTvXSn8Wur6bmnnb9OhwP4b+FoENbel08lvRc54yaL7VEBO/mLfJhcYgK+QgW90k5+m++3xjHjaKHleP9xwoeovXa36MXuZ2fs6u/qT6ZFNYY5AJTzFBtQnJR98CuAOpqsb5S0gwO8ElhT3tWXIGsgCDNb1hXVSWcOLLQtgiQYhXFIWMRPh1sY1gauFdg==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: C9EmpK802KTKHrD0ef+ij8XwliNgDhG0AjhSzynqQXE87qFb7A7quItSNTQmibqLj7epr23QNJjD2olmswBFyilurI7iznp/LkVBrOB92bVmY9Cl37O7a5kwYMYIuZH3kuK+l7AxB9oWofdZxIjP5+k8yn/ogxFsOC4b9DvNlByh7wYShzTbIDpgXPl8/wANtnhNpjA9rn6zrwqkOnku09AwKMlB9QB+addwtFtvM/ClJphAFHJApksVd7JiZrj+Ran3i9jB1YS+6LDZL+2acYpAeWnhysE2+FizB6HZ2W2Ag5W+eXPEtvfd7t/w420AbV1D9Osjc5sbs5L1uT0g2K4+ZXNBauJOSkh/l/txfHZuH+T4UkQ5+8nQsP2XsYbn07kV4MxE09WwK9/ImLS59SJ442cRguPcQvsJVMcC0F6VjMzatYeKKe/CqHeWQcpw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 22:54:29.0657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca5f87e-b96e-4570-b2e6-08de8b8aa325
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7791
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=nicolinc@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
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

On Thu, Mar 26, 2026 at 05:11:17AM -0400, Zhenzhong Duan wrote:
> @@ -430,6 +431,11 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>          }
>      }
>  
> +    if (max_pasid_log2 &&
> +        vfio_device_get_viommu_flags_pasid_supported(vbasedev)) {
> +        flags |= IOMMU_HWPT_ALLOC_PASID;
> +    }

This would set it to:
	IOMMU_HWPT_ALLOC_PASID | IOMMU_HWPT_ALLOC_NEST_PARENT
which isn't supported on ARM :-/

The VIOMMU_FLAG_PASID_SUPPORTED flag is to allow PCI core to expose
PASID cap. It feels like we need a different VIOMMU flag for VT-d,
e.g. VIOMMU_FLAG_WANT_PASID_ATTACH?

Thanks
Nicolin

