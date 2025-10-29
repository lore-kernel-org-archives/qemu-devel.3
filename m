Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A59CFCCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 10:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE31I-0004Fv-9o; Wed, 29 Oct 2025 06:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vE31G-0004FV-GW
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 06:03:06 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vE31B-0004Az-SE
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 06:03:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cRGBfcIlr5bSEMAM28j0TivjOtvE2yWLRR6LlPHgW1Aco3UnpgeO/olpwhC1bx7eWQnVyqniYO+gBVYqHPUZYIkiaE1vhquXtZrPu355pvXkPinc0O2uw4RY0szHmc+lpWq1KVPIWPQL0eYGx0OsCLlZbcBnBiVigHAVQ9yLeywxvSr0OtmgO5BU54/t/DLLZOflQmaHoH3IHPC4aewCtvK5FNTBiaYf3+MtO8R21OJh/Dpzjw3Q1fvNoI8Fmt2fzTbFrh5LIjE6ogKHpJtAxRhRRAZiw7szBILtOPSGbvV4b/h6z/eiqwy58544EShFfo/WVBPuV/oN3FHRDWybHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daNL5hgxamLuGLTlEXEONUIm6GASpOYvVR48Zji7D8Q=;
 b=rCkwcrhcOgZckQvvKLdvl2oUECi0xFsL+IzDfv+X/MymQ2+/511+ElbpQXJV7f7krxAARgEOLAzeAqQ2bNBvdfaJJgmrfBfq8SSnsbIseVHHq2AuVk05SzyIE2cdgA1CexWtGzlwAfL1s3BbHzKM06tgAJUec0NUIE2RyUAD9tK9yKJ7U6GOStNsNLlfz/YBZv01LJ0VmYknTvNd6BYNJGnqzZVXZsyO+08ybLAVyGBE54Pl+1D0prPnqK5vu1C7p1svALY9WPN5csBTVPrEo509ORect77S8d/xwcRAQtDBj5jn8rLEwFyR7cGM3KKheR+y7tQ761dWccHH4xzUPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daNL5hgxamLuGLTlEXEONUIm6GASpOYvVR48Zji7D8Q=;
 b=o26NFwN0fsVhqi3ybVt09bXWZo/Fpx8zaWJLaNwHCvoihOqgZOVr0uB1p4ALpL7ZR6nM5ine6pYTPd7Ppslje+Oe7NjEqNHCq9h9r62TAV25XKiZBwk3agVTDbg+CMfvCxGFIWTI33IuhrXybF/I1x/dqo7ou/m+iH5dTZMzxM4=
Received: from BL0PR02CA0086.namprd02.prod.outlook.com (2603:10b6:208:51::27)
 by CH3PR12MB8754.namprd12.prod.outlook.com (2603:10b6:610:170::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 10:02:55 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:51:cafe::f9) by BL0PR02CA0086.outlook.office365.com
 (2603:10b6:208:51::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Wed,
 29 Oct 2025 10:02:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 10:02:54 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 03:02:50 -0700
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <mst@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>, <yi.l.liu@intel.com>,
 <eric.auger@redhat.com>, <zhenzhong.duan@intel.com>, <cohuck@redhat.com>,
 <qemu-devel@nongnu.org>, <alejandro.j.jimenez@oracle.com>,
 <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
CC: Sairaj Kodilkar <sarunkod@amd.com>
Subject: [RFC PATCH 2/5] vfio/iommufd: Add amd specific hardware info struct
 to vendor capability
Date: Wed, 29 Oct 2025 15:31:49 +0530
Message-ID: <20251029100152.4807-3-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029100152.4807-1-sarunkod@amd.com>
References: <20251029100152.4807-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|CH3PR12MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: f4df1af3-4a28-4104-2e05-08de16d2547f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026|7416014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oV/RilCK47mC94t1RZiVnkX0AzWdSjU4fDr0D+MjaOf7Q66mrLmunAHkU2gq?=
 =?us-ascii?Q?7jrhylU6+IMP25YvLlWLfWka99iNGYt8nmifFqdVzoE01XwaBzfbTkdl6bA9?=
 =?us-ascii?Q?C23U/mA9xlg7q271d5kve9gwJgXV3mVc20z+h5ojR0dzX+zDE8gg0KpN5iqd?=
 =?us-ascii?Q?3t+/q4uaBS/HdFhoRizDQMaTS/ifj36Bj2UM1vbg4cWOABbVTDVgHjNI+T5y?=
 =?us-ascii?Q?1v3yQToNV+LsRqb6cCdRELG0YVfixHoE8G5+mnuTQpA0alR7h4PaUINIGwLy?=
 =?us-ascii?Q?9inkAOOT6M68E8ji0zs8YtjZ0lzXiYMUqkuqL28Rd+7N0TkoJj4IRdDrn+Vv?=
 =?us-ascii?Q?XrCMMB1U46Tx8Fs649LxVxQNsGwIFePfPIHT9aTCnUuZ/BDP8Kw89ugnAwli?=
 =?us-ascii?Q?PBFnWT/DYEGtJC/rvqLQHvBV6xPE7WkSHqG5w450Fe63TOjCmwmc47MVS92Z?=
 =?us-ascii?Q?5ApNqKMvL54PNcl2oqkNq62Zf2X3Cbr0/6nRJsl9cR/5c/eHzoVVSMFjyvwU?=
 =?us-ascii?Q?HfMNZMTqg6PRBuhYrE+sQV/2sNKFVfLjKnvFB5pWaUwGkB3+A/PMZAiV21Iw?=
 =?us-ascii?Q?Qr1/tt9YGF2xSZJzbbYuin6xtjC2kR7ff0kD5TDX0iY/MDogcN96md07QwLl?=
 =?us-ascii?Q?L7JII6bg0NQO32+SolYESYkPcmFmkr3NJDy4+8y1P6fmmg5H99ezvZODcl+W?=
 =?us-ascii?Q?SnLNPCy6KI35XNobqwpNx95x6qlgP+uWliIVCNbOe7rAR3dGvpv+dmLaOEMj?=
 =?us-ascii?Q?Ssh3mtbfHON9iqDHBd6nP0UchYgEul07TJjQ+yC4eZDWtG52YOy8UNJIKR+V?=
 =?us-ascii?Q?C72ZEbevlLpWyqW8yvlt6iehLHxLrJC+YDYj0GukStQwLD89jV7w5Th891vD?=
 =?us-ascii?Q?QJG5ixxggkbxrINaGqfo+ZU9VoYTEJLPJFacP8lWWwBZcWv4rHwMRKqag2f0?=
 =?us-ascii?Q?PNkHzerMiI7urslQCySBkma0cmT9YLPKpo/ajsT/QP9MaBV6fqS+rKj1jjsl?=
 =?us-ascii?Q?dLXT+zj54ZM/BHFEWRRBGLi2J2+bJp4qPIng++63pK8EJuWLDhWN55zOd2t4?=
 =?us-ascii?Q?S2zSGvwSS3v+jIyOtp71kS02KUZzxhhXMqLfxswykxEI9DNJqbkBMK6l6tep?=
 =?us-ascii?Q?GhL9y7yZ6vdrVqGylnuTrdK4lU4KYIaAr55GV0/6hZ0gQ1qZskSfrqpEZ8m4?=
 =?us-ascii?Q?1RLvo3hf1f1MTiMShmWvUOIE/E5hpLIYCb2ruS+t613Bh5GbPdnkmOuRdM6f?=
 =?us-ascii?Q?x8Npl27cmagX9EwPTvnCD1eAHtIAmoGWgbtL5ZebZEFLlNy24VLBcZaxLwDp?=
 =?us-ascii?Q?zwriAyr7kyW1QauCoU7i2PesC/CXKyWndrzaZxw/cyTDyh+zDGeUMTPOugSD?=
 =?us-ascii?Q?i9F8GIV6n+Gbu7Cbn8ahC7wfDDBlxBLgfmapYD0FFHPYrP2cV73SQ63kRSUO?=
 =?us-ascii?Q?2IbB+6vLBr91ZBCbOHnhtZi0GScgD2fzOjh1WwnrwJ5eUQNHcElYHNyA3qJV?=
 =?us-ascii?Q?9cJcVjBXDFhT3pYNYAMnoEL6OcfLAcfRLeqIv5Aya5yOa4PLN/ZsxwV59Zlj?=
 =?us-ascii?Q?FkY9hibkwZ2dxoIeg6hAVvoksVbnqdzs4kIZx7Iw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014)(921020);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 10:02:54.9335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4df1af3-4a28-4104-2e05-08de16d2547f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8754
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Update the vendor capability structure to have `struct iommu_hw_info_amd`.
AMD vIOMMU can use this to determine hardware features supported by the
host IOMMU.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 include/system/host_iommu_device.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
index ab849a4a82d5..cb1745b97a09 100644
--- a/include/system/host_iommu_device.h
+++ b/include/system/host_iommu_device.h
@@ -20,6 +20,7 @@
 typedef union VendorCaps {
     struct iommu_hw_info_vtd vtd;
     struct iommu_hw_info_arm_smmuv3 smmuv3;
+    struct iommu_hw_info_amd amd;
 } VendorCaps;
 
 /**
-- 
2.34.1


