Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DF3CA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 22:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upa9p-0006Ev-0G; Fri, 22 Aug 2025 18:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1upa9k-0006EW-Qs
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 18:22:44 -0400
Received: from mail-dm6nam12on20605.outbound.protection.outlook.com
 ([2a01:111:f403:2417::605]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1upa9b-0000OE-8z
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 18:22:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7uXy/Kl6agZvO5YapZqhydKbe4reorHdbMwStRHh7mwscnvfkPpO5KPWHh5AEM+AsN5oZOWkW2Y257NASHo1epKYZHp8J40YsPax8KYkJPyxAtzBlgDJ4BbZnbt92zbkrK4jwjCcwMHA2SuNZFn0TOWEAolKTA50nSwBpCy04bGs+jrD/unvXjCVU/u3I8psharPm4q5G7FHH0G8vQzpYbobLvqOD3IB6gYo2f4y8D4KTNrctLH63t82A1GK1QaBCokTpRnQwHN9zb5lGINE4xUaKXO41TblpD3jfSNqQO0mzf9sDidcteuyG0c6ZPiKzG+e4D8rO7VPZLkpu3f/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnG4J7OVkCaclwpfHuJLU2RHArUEWY2qAzOkJFGQX3s=;
 b=AtVszJYCRVpyXvvACo+WDA3fQqmznwXjqYTzvc2rClmMY12JuJ3KzSaQEYlYaD3vRMoqQW5qtuuC04gdHRcEv2jkqzd0mYU31WrSixlbBwapNE59aiUq1eBuAW1PWgSNDfHCdngCeCaGUhQMAlSfDMdgu5rARBLlprBjAFPd8DvsRPd8D0uWI3dwyFNkAgSu/lyJmZfQm81O4s4Q+DEhYTdMIhUBLIHJhI4eB8rt9zOQluRhGnC/tiBV+hYo/983YiHCmPr+L7fDD74u/lsnMMeQi7RBAYomq2+r8UZkQHfn8wpmbW4tAwIF6wIQbejpYo97DOQVFNuZXj1D/iQ7iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnG4J7OVkCaclwpfHuJLU2RHArUEWY2qAzOkJFGQX3s=;
 b=WWV7Wy6msmlvjV11itKMfQsI21OpYG1zEkj/MufVHh8LVbyD9uWUgDlPoLK99BkdtJ+eqaMq0e8/RMkqTAidZZ2PSaZbV1WwkoxNdrK54VKlds1Exun+H2b2iaFTqUss9BAIFy87aRTF1jJHJ6zw0fFpKYE7MBsGdbN+QS3lbESgKYOO7QZZfyqf1IHsfF2Vz1uHcLjFlBh+fEahOdVWhL6QKE8n2n/3/xcaEvX2S+IOVThgEYbkjekjnGVswBPpzgzXBhsDNe/+bGUaJ4HNTs4y73jTAkDCslg+NpQ27ZjsqILFBvRQYUjB5qrFl7/lhhLSVMAyIDGqFf4LcXBNyA==
Received: from DM6PR02CA0118.namprd02.prod.outlook.com (2603:10b6:5:1b4::20)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.14; Fri, 22 Aug 2025 22:22:24 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:5:1b4:cafe::4d) by DM6PR02CA0118.outlook.office365.com
 (2603:10b6:5:1b4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 22:22:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 22:22:23 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 22 Aug
 2025 15:22:10 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 22 Aug
 2025 15:22:10 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 22 Aug 2025 15:22:09 -0700
Date: Fri, 22 Aug 2025 15:22:08 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
CC: <qemu-devel@nongnu.org>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <eric.auger@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
 <peterx@redhat.com>, <ddutile@redhat.com>, <jgg@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <kevin.tian@intel.com>, <yi.l.liu@intel.com>, <chao.p.peng@intel.com>
Subject: Re: [PATCH v5 02/21] hw/pci: Introduce pci_device_get_viommu_cap()
Message-ID: <aKjtkCL2C3FapoWT@Asurada-Nvidia>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-3-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250822064101.123526-3-zhenzhong.duan@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aef41e9-2b17-4a1e-fb5f-08dde1ca5e70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LB7a1a/c3ptrPYw/4NsBYdK8sYBZAA5UgchVDmhW8GUVCH3H8hLDmh7qUL26?=
 =?us-ascii?Q?D9It9PHAvfRSK8MNoRWzQq64jGudyNoRwOwsxriiqdvb7QbEl67bzpJ23pxn?=
 =?us-ascii?Q?1vcjvIEsSu6cbZvrdU5M2O4FsZGlDmZ+sUTWo2Ml0A+I+QwxCzF/jwVbWTTi?=
 =?us-ascii?Q?jhdCpBX+r6bZ/yxUW3s1tO52jW8JFw/Spm80OZQMHAlAN07XWXKfiOig/ngP?=
 =?us-ascii?Q?U1T9GFUBie8gz9EO6tgZ3A3lgSB6hZ/RY3pCxqxbbOeF8xr6HEglNFOD7EVE?=
 =?us-ascii?Q?yWTgvQoaMfbw0BbGoR6Ux14peUS24DQehHCwTrj/MIYHPqia9vNDOuQkpLFu?=
 =?us-ascii?Q?mhazHZrX+tWJ6DWrVP+BgdMpwSnzv5VUayl/yiY9e+ISvbiZRLeu62nZ4Ft6?=
 =?us-ascii?Q?3PtSLKntnXWQt6Mz3TUVzmdtvUwfrGNW3+Efg0twxthH9N9EjoTxXSI4LwCD?=
 =?us-ascii?Q?e4OfOIpd/Kt7UE3xoEMs8b3sZUfxEEogdbWIZHBSfDxE35xrY01e4NMwpemi?=
 =?us-ascii?Q?NifVAIIeBzxF2L9ozrjfosMTggP0pzPfBSWQUwzoaAd+ei3d3G59RUyzheTK?=
 =?us-ascii?Q?GRn5r+w3c0t2AOFlso1dz9AoYlKc0VLFdDi6wmmWMDsNmEHZzBQTe1uNT8QN?=
 =?us-ascii?Q?wZjhaLOyq/U+OIjTXKR2mNnn+L0X26vZSjilXevLnMUF3JEuEAJmpl42w9Q1?=
 =?us-ascii?Q?2Ta+f2u76RL8zvPdPMoo6srY6g/FAmzOSYTHw7tBcf1s1SuOeky/CK0YpxlW?=
 =?us-ascii?Q?rvrfkrILWIW+BzFOYMkTDVZ9EKI5QcTNBgG8DXDGi5ZXwREkUaMuaSrXARrA?=
 =?us-ascii?Q?CgH4Qd/HmlQCy3JAfdUZNbLB/9XhOIxSQDT1XvB5JMTFzXMJJZU13rrFXR6Z?=
 =?us-ascii?Q?s95Eqiw1ZTWYtDVYAk3POeTVcmTKCbY4ra759LqpzArsivgjwUk0qRMUgFr+?=
 =?us-ascii?Q?8hpe7QwPjJiBO9k+yyVRbpQ7t3U/vhSqZv1S6MlThovc5v/ye6OLpBZ1BwFv?=
 =?us-ascii?Q?6gfRtBypF987hJulwtvGEpREKBC9K9Rrgq7YJeT8OpOZkyCLzOBnd2qKZ+Ec?=
 =?us-ascii?Q?9cI2CfxN8ZwgEuBzCJ3WYp8MV758n24/6PsVAfs23NrgOIJwkAoUTzEwpaS0?=
 =?us-ascii?Q?bAlkiFeeJeAPiV+c0bZWg1EtoHUEqvt5cv7QujEyOZwquJ1UPDYKObObwMiZ?=
 =?us-ascii?Q?Z15QtOx5XvjqwiZXCk/3bBUAA8Zxh/2khbHdKZ9A3RMOQ5HDsLotC7xU9PN1?=
 =?us-ascii?Q?ThVmUytaEn+hSTMCFR01OivBCt8Dwt+HPBukm/PjR/DMkE3Vglj3wC3Qd8HV?=
 =?us-ascii?Q?gu/rr4wLARq1zXkYGsmLBxqL5HG2PDmvLo7dOO5n3YtnOdNk1XM4U6JFDfun?=
 =?us-ascii?Q?bkWYhwQ7mjA/B+Gt1PMioIhVXoZHuno1ai5YSASxqRgY1l68udvDNawnJx62?=
 =?us-ascii?Q?HSJNiIHBM6W04Ak5VHbFnzojLHPulnlf5r8TZ4gnYrNebJY4GcO7XDxct3GG?=
 =?us-ascii?Q?7IwyaNIGPIpawm7nJEL2zMT/86v82l4lyb3z?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 22:22:23.8623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aef41e9-2b17-4a1e-fb5f-08dde1ca5e70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392
Received-SPF: permerror client-ip=2a01:111:f403:2417::605;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

On Fri, Aug 22, 2025 at 02:40:40AM -0400, Zhenzhong Duan wrote:
> Introduce a new PCIIOMMUOps optional callback, get_viommu_cap() which
> allows to retrieve capabilities exposed by a vIOMMU. The first planned
> vIOMMU device capability is VIOMMU_CAP_HW_NESTED that advertises the
> support of HW nested stage translation scheme. pci_device_get_viommu_cap
> is a wrapper that can be called on a PCI device potentially protected by
> a vIOMMU.
> 
> get_viommu_cap() is designed to return 64bit bitmap of purely emulated
> capabilities which are only determined by user's configuration, no host
> capabilities involved. Reasons are:
> 
> 1. host may has heterogeneous IOMMUs, each with different capabilities
> 2. this is migration friendly, return value is consistent between source
>    and target.
> 3. host IOMMU capabilities are passed to vIOMMU through set_iommu_device()
>    interface which have to be after attach_device(), when get_viommu_cap()
>    is called in attach_device(), there is no way for vIOMMU to get host
>    IOMMU capabilities yet, so only emulated capabilities can be returned.
>    See below sequence:
> 
>      vfio_device_attach():
>          iommufd_cdev_attach():
>              pci_device_get_viommu_cap() for HW nesting cap
>              create a nesting parent hwpt
>              attach device to the hwpt
>              vfio_device_hiod_create_and_realize() creating hiod
>      ...
>      pci_device_set_iommu_device(hiod)
> 
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

