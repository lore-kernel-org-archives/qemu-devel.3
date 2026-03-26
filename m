Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9E610AB82C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 22:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5t82-0003f2-7B; Thu, 26 Mar 2026 18:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1w5t80-0003dT-0J; Thu, 26 Mar 2026 18:24:36 -0400
Received: from mail-westus3azon11010029.outbound.protection.outlook.com
 ([52.101.201.29] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1w5t7y-0001hG-E5; Thu, 26 Mar 2026 18:24:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eG0C+RKY6iv8g9BnDIY4NK6nVDObkWk51OjSs6kMlg+uOzsiZB7rhfnNk67ni0/rA3+dFyDXTSY76wgOEy2VC6Hj98N1MyDA1qdRxT2BzzOZ06yvRmFm5d8+mLViN/6EcrVuXK6wzzg9DzxEjmFnaB39qi/L4Y44MDI2i18Z6xBUD4/9DsPTNcBw4f4iisBYUIEb784FS3PMUmMGTyYMtdPYB7fpQr+cVPjwBoN2RyDBKs1mfH9fWLfXKd9EEeKA0jbSu6ihOnnL4dBU8XUQvw53/zgo9O8JtDO61IQXsDEbx3AvpOmUOXW19NlHvzPiH5CCKkMAXhwCgwOWJ789Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXbRQYzEmVvrzLLx/iVh38/5dL6+vy20G/KaqM71yTk=;
 b=RcRsSQze2l0hx0iY/PCme5uLAAKPirRTI4wj/ISJLlzLyyFwPDlFjTi+YhxUvO0uyhWtSmKqxEosZocpVYyjUi3NNFGUvlBlIbDENa6bsblwvzLDDUeXxUM1Jm7hYLtf9P6ZBzQRb+Kjj+CP9XROPbhTpLahcztkevMne1/yXnsQTJGyf7/XsaQEaVVz8X/EznCLM1a6PKvJVbexYc5C2uu+JxpXUdeyTPX65ybdeJX+17DRrYc2cTPN4hwkm8luxjJEjFq8i2WzoZayarwj1rEbItzygS95IzLouw1pUsFqIsO8L/WHexM7ycbVOUu4uFOxyaNhQzCRM/gRUYir9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXbRQYzEmVvrzLLx/iVh38/5dL6+vy20G/KaqM71yTk=;
 b=bKmJHolB5PScxCS+9QNkqKDswbPqRA20hRM6ZC+eiuEImXPd6POXMm3UtKgUgrGOZRzTLISOHrsakSkZDnmqf2QWYUJJATdWDCbrvRca0nB8ARQCsBRRGITrO1ozVIoJ/TRCK0wbJqj2Cy7peY+JR8oKXZcAE/EoP2oyFE9cbMgSNpvcHFygJJXBsWbONlmiCG3TjxgicYgn/XRSmQd4QQKV3aredVT14CqHWBEwsa2HMJbvT+wZNbezNLr8KnQ7vrqGXfsJPFm9K2S2fpy8Hchf6Km6RC6qHnA1yzMN1PFp3EvbfulARA3g/GhNzxLBr98CrQeEdYcJZO+gc3PBBw==
Received: from SJ0P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::32)
 by MN6PR12MB8565.namprd12.prod.outlook.com (2603:10b6:208:47d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 22:19:25 +0000
Received: from CO1PEPF00012E7D.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::73) by SJ0P220CA0024.outlook.office365.com
 (2603:10b6:a03:41b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Thu,
 26 Mar 2026 22:19:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E7D.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 22:19:24 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Mar
 2026 15:19:09 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Mar
 2026 15:19:09 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Mar 2026 15:18:52 -0700
Date: Thu, 26 Mar 2026 15:18:43 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
CC: <qemu-devel@nongnu.org>, <alex@shazbot.org>, <clg@redhat.com>,
 <eric.auger@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
 <jgg@nvidia.com>, <skolothumtho@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@bull.com>, <kevin.tian@intel.com>,
 <yi.l.liu@intel.com>, <xudong.hao@intel.com>, <qemu-arm@nongnu.org>
Subject: Re: [PATCH v2 02/14] iommufd: Extend attach/detach_hwpt callbacks to
 support pasid
Message-ID: <acWwwzfNEzBg4n96@nvidia.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
 <20260326091130.321483-3-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260326091130.321483-3-zhenzhong.duan@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7D:EE_|MN6PR12MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: acb56a54-3557-4337-cff9-08de8b85bcea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: uHQ9H9g1NJt5J5qBXbCnLkafcff/HxuLLRGnxhdHl0ATyzns/16d8eMCPEolvgEN/CYLPiGHkDPDgf3yoh/aPFxIwJPcWzAwR/0PJAWRhA+SiQMSNnMM8wSH6ZpAr5EB7nONlU4n4YggSwDieuD04dhSlLcOOeQ3cK/HXDBFQbnPDH47iAJpvKhYy4mZXm0aDxXtiaOnJ3ONlTKAOSTIMzlNOUiLlLr1bjeUIh037SkRS1NVcE2dKTsYp8nUeYxC6lfp8O0gH0omq2rXBRoSZzmU8PNTzHwcBiXV200M5hXb56BjsBCxi4IHUqlF867sHy4Z5UoqH76OoRUkJxGT8nGgplvgn47w6Nz3EM+X/aVgpPvOePmL4D72gxzt8NKjL0GJma7krZInJYu5nz4GDr8ZIWtZwOd+x+POlwgX/3P/B4DBx+KIKt1kXSt08azNvIIt3iOGBnMOJa0bUKi/kNH7lsMJQu5U+qFFnjK/y1yraMJtl5vJ3qELXze4rAdrW1rQAl85Y/X+xD060ODiFN8UM/AS8GpDOxeJ71t5VktkxQW7nVE1rFc4cbudZPXzvQQ+ypZ+XrXipEzJsK26JBoraHt1lrsbRHdnSOgisi3pinOvU2/WAssoxRprxXpCYBm+/MpO+IgLbeuXy4rJddIXtQWz/Uu214tR9ZNOQy1sCaamuoR3+0TZe05EIpC1gpXzbqzgIUHASun3OkCLWy0fDlmI/94lb1t6yhLLHW5ybOj7ftURhR8n380HekzxwglIDHyUubLwod7R9WOgzA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rc1FePby7+ahn46tKcX+juR7Rmzyafx+ESBPOOCoEDMKdmug08+2MiojhsxmBFYfAtKxolO7WhQ34OCquwyTBOT+YUUy1yhqS2x48W9yku6aGMpsYogDfA+SInAMVEnSVG9YeEvM1jKgNFPhOquo/PLkojzsD2c+FKj3FRDOil29YHtKwThfGYvNU6Wgrt75su9bk4K1GHQvLwbek2rhliZSezTROZJfy19VcrRDO4BUpLZXpWEoWR8ZdBs0M4OcKCY6j+JB10L6syh5qdVXxtaTnAcMZyhLGHM1AOgHH76EhahK36KbczmYeZMY/CMVfw9kj0T7GSpfrTFrPPoF2YA+rtlt4lqYfzK/wRuujCTst9JF9yLvnuxdccxHk2z7Rb5pf5XF3AfiGDYtVT/jI26Tlrne41DombydaWo28/7slyv1Rc3NqVblWaf2kqiS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 22:19:24.8512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acb56a54-3557-4337-cff9-08de8b85bcea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E7D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8565
Received-SPF: permerror client-ip=52.101.201.29;
 envelope-from=nicolinc@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Mar 26, 2026 at 05:11:16AM -0400, Zhenzhong Duan wrote:
> @@ -138,14 +138,16 @@ struct HostIOMMUDeviceIOMMUFDClass {
>       *
>       * @idev: host IOMMU device backed by IOMMUFD backend.

Not commenting against this patch, but I just found the "host IOMMU
device" and the "HostIOMMUDeviceIOMMUFD" a bit ambiguous. It's not
an "IOMMU device" right? Perhaps somebody can help me understand :)

> +     * @pasid: target pasid of attach.
> +     *

How about "target pasid of the device to be attached"?

The uAPI docs has the narrative "pasid of this device", which makes
it clearer. 

>       * @hwpt_id: ID of IOMMUFD hardware page table.
>       *
>       * @errp: pass an Error out when attachment fails.
>       *
>       * Returns: true on success, false on failure.
>       */
> -    bool (*attach_hwpt)(HostIOMMUDeviceIOMMUFD *idev, uint32_t hwpt_id,
> -                        Error **errp);
> +    bool (*attach_hwpt)(HostIOMMUDeviceIOMMUFD *idev, uint32_t pasid,
> +                        uint32_t hwpt_id, Error **errp);
>      /**
>       * @detach_hwpt: detach host IOMMU device from IOMMUFD hardware page table.
>       * VFIO and VDPA device can have different implementation.
> @@ -154,15 +156,19 @@ struct HostIOMMUDeviceIOMMUFDClass {
>       *
>       * @idev: host IOMMU device backed by IOMMUFD backend.
>       *
> +     * @pasid: target pasid of detach.

Ditto

Otherwise,

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

