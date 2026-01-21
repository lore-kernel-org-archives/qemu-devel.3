Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C784C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 18:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicUS-0002jI-Gn; Wed, 21 Jan 2026 12:59:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicTQ-00008S-0q; Wed, 21 Jan 2026 12:58:32 -0500
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicTO-0002DB-8i; Wed, 21 Jan 2026 12:58:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OvVsflvHQCSyHT3FGQoEMJuTNDlUZJc0FOvB3P29RRIFhlUM6eX5f5eFOef93QqL8ex17aSQJtAF5z3dJ9Ij0xNIO5n0zzUkO7Ruy46vU9KnDtzM9RMXyfyz3OP5VdgLPs9gfNMFXVEPuMXjUP3kXqMvd2jf3zL3CgAFtuV/id52iqu5bernXrD2fIm2tUNAaXaHMcB/hkylX7T9VHnDWluRUy4hl7oAR4hYVGjTdCsDaoD/m5Qd+yXC08V3LginV9LcsTDCfYpMSNCK6+/FSSRPTD07bEFHH1BtBmphJAG4U9dmV57HEtbMGFbvHiQ0WbGYjfYard1YafXML3+yfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m52r4TxU6csU1hkdxng+K9140zOy6CU4VRXrtdoxDgs=;
 b=r3omoJTU0Vu0Wk7L4pNdev4U7BT2WJlHK/O1uSKhaQELKcl7X5CuXFGrTfYEhFKX1IPw3MpRHq1956cnL/JAA2W9G3+DHbehHD3PSoqnyBDISegsvVpSQOMOiTiOU5hdedrwanYyoC0lKGPklS9b21AOSRnFar8ZVEMU/PjySGcZ4MjA7V+FWliTUe7t5QyH9Z8HJ2aCVIEEMk0++HuhB2NvCQPXHoUZAcfNg3IELqhriWU82/CnLHHbV+LzSqYtJFrXWfpOVGbc9oSjLvSbEl+6vSXLGwIaS8YzpmD+RFgNm6U5/7uNw7Teg6x2zdzegemIXEjVCWXirRhhYVmdzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m52r4TxU6csU1hkdxng+K9140zOy6CU4VRXrtdoxDgs=;
 b=AzZm8TSIzGyWGsFHtpVOG1xPLE3RaTn50+GWUYumxmSExAJUaGUJE2Lh0Z1US+UTcyO0dC7EbpBRda+oOhYZI+mm/1KoKqTC605oqxbomUS8nd1ajZ/PBwTopp4Eg2Ql7kH2b2IdZYJK8yIwHmWy1a8qIJKQdHug4Ia/vCgTUf3vJUcSW9ujhSJzlp6Hu3JdorLXVauw0Kk+bx4HGOWy37SSbYAGfHu4SRhL2ynWfrb9z8HSGtWp3sp0GyrPobjJsjbMqNDfP6uRm4ypAX11xeA1O58pNVExrww6cLlwVtoFZ0WrrHxL5SIHCEbqU8+rZk6OPBw30bGFlW0d0uKhWQ==
Received: from MN2PR12CA0029.namprd12.prod.outlook.com (2603:10b6:208:a8::42)
 by DS0PR12MB8816.namprd12.prod.outlook.com (2603:10b6:8:14f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 21 Jan
 2026 17:58:12 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:a8:cafe::3b) by MN2PR12CA0029.outlook.office365.com
 (2603:10b6:208:a8::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 17:58:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 17:58:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:57:48 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:57:43 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 31/37] hw/arm/smmuv3-accel: Add property to specify OAS bits
Date: Wed, 21 Jan 2026 17:52:36 +0000
Message-ID: <20260121175248.87649-32-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260121175248.87649-1-skolothumtho@nvidia.com>
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|DS0PR12MB8816:EE_
X-MS-Office365-Filtering-Correlation-Id: c6d9cc6c-9105-44e3-8279-08de5916a487
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dTVWRmhmbTRoOHRYaXFScW9jdElsTHNjRU93eTg1dEUwY1ppTnJLaEhxaDdT?=
 =?utf-8?B?aklYT2s4VXB2MnFtaWp4aUhtRmp4SXRTODlQa0p1aldkWThqTnpoMjJhZUZn?=
 =?utf-8?B?ZE5xZm1RdzBKb1JndkVlemV2MW9DUjhSSWN0aGhPenpCUWhDMWUxSERHZGU3?=
 =?utf-8?B?elkzSVZ2TVVZT0UzbUk2QkpqS2YvK0VHdEhERHJDa2V2VHpoT0tsZW9oM3ly?=
 =?utf-8?B?TDNlSXc1UXVtM3poNUlzTzlBT1A5YTBEaXlVakp4RFZRNlMzNkRyczFHaDlE?=
 =?utf-8?B?dThrN3YrR3VPcVR2Q21VQS9mbjd0NlYxNHQ3aVh0QTM4OHB5N3BZM1I5eG5S?=
 =?utf-8?B?a1htbmNORFJqRGxvQzdLNHJBZDBQY2lFRWIvL0NZeVZySzA2V2N0VkVETVdU?=
 =?utf-8?B?blNjdE9EdFliOWhYSUtOT01vY1NZdXFtczd6VEEwU09yYUxNVUtvN095Umd2?=
 =?utf-8?B?dE96MkN0QVFucGRPOUVOaUh4MXYydG1MY3ZBQTIvQitsQVRHL0p3WXVrQjNh?=
 =?utf-8?B?VVgzVmp3U1BzaFpMTWxJc29Wc1pNS3d4ekhZcG5oR2h3ZmVQLzZMRjBIL2dF?=
 =?utf-8?B?MDF5Wi9kYTdTYVdnQzdKaE5NK29oenBoWGs0WXFHYW9HYTgydHRhd2g4YkN4?=
 =?utf-8?B?dk9pZlU3WThVZkFJdWVvaDBBM2NGeEgyaEtmRDFMZUxOZ3FYQk9ibDRSSHBu?=
 =?utf-8?B?Y0RuSjZtd1lHdkxCUjU3ZG5xTTRobTlwaG56cnRUV2x6VGVLYW8vaGp5TTlo?=
 =?utf-8?B?SjRwZ0Iyc0xVYWhnd2RDLzg1UXpFWUxvM2lMeU13bnE5bXA5TEtQdHFHZXlS?=
 =?utf-8?B?WWE0KzB1bldhWGdGWjY5ditDWjRTZ25RaC8rNEVlV0QzQWhZcVJlaEo3ajZE?=
 =?utf-8?B?Q2QvRkROOFloVkcyY2NoNE91QTlnZFI2aGVmN0U5aDhoTWs3TFVwUlZQWHN2?=
 =?utf-8?B?WkpNR2hwaUVPcnNHSW1OYnlIVnk3TUVleW1SUjNMUnFtQzFCL3p2cXNORU1m?=
 =?utf-8?B?aTF1N0VGNzVmVk0ydG1wc1BpOUVoenRnY29neFI5SnVDaG1XVURlbFUySXl0?=
 =?utf-8?B?SlFEVEh5VW5uNjVaM1NZYVk5WUROVjdWL3l3NzJ3SFJsQzYzUXJaQ0JqM1Zt?=
 =?utf-8?B?dXBmbDY3NnVXU3RETzVIbitaeVBYNWtnZnNvMmxjRytMbzZHVFN1YU9rRmcy?=
 =?utf-8?B?bHYvY0FjQWtMOS9GUTA0VjBvZTVnanNCRDJTKzVFTmUwTGVYWDZaVlNUZFp6?=
 =?utf-8?B?Z25JVENlL2RFRGJTWXlINjR1MExqT05EVmZMQjk3ek4rWWJVS0xiTVhZWi80?=
 =?utf-8?B?YmpPL2JKUHdOdU90S0FrcC9hbm82ZFc5Kzdub29EemcybGtsSC94TU5QV0Y5?=
 =?utf-8?B?WExsdVRjdVo4QTdBQkRLY3MyTzBDWjVyYnhQd3AvWFUvbFNTRjZiNXRkR1lT?=
 =?utf-8?B?WDlIaWpLbngwUlVxNWNZdTUyeW5BRS84ZWhPSWhDUzBhRndVSVMvRy9HQTZH?=
 =?utf-8?B?MnZ4OHpSVDBXeGl2cVNKci9OY2FqVElYenVQK1BubVowVzliKytuUE5TWUNw?=
 =?utf-8?B?WXp3MXBGSERNOFk5NDIvME9WMGFweHUxaWhCaXFuT1YyMHF5SU1VZi9WYzhm?=
 =?utf-8?B?VkduUDU5ZDB5Y1VBMmg5U0I4aDJFYnMrTkd0OStnUnZjeG14RXE5RDh2c3Ax?=
 =?utf-8?B?UlRJYVRPZ001NEhhU25ydkJoM1dQMXhLM2pucnhJcmdZZGdrZmdRZHl3WG1k?=
 =?utf-8?B?Mk9Fby9XRWVMUWZvWDBMNDkydG01VExRdUdBdE1VV2VDMTNCaXRsRFBSQi9C?=
 =?utf-8?B?S3ovSVZ4c3J0bXFpWEdOSE53WDBZRzVGY2VsOTFidmZ3MzBzem1VYzZiV2sr?=
 =?utf-8?B?bFI5UVUzRkhUdExXdVh2bWVKTE9VWFJLWG5YdURDOWJ5dEJMSkpyQjBrdVNL?=
 =?utf-8?B?QmVFSXRzMWFneVg5WHlVNEIxb25lRjFMNlg0L2ZrdnFEQXA5OE5tYlRqUTdw?=
 =?utf-8?B?Z1FtNWpidHBNbVR3MG1QMUkxd09ZOEc5c1ZxS3lJT3dRV2lENmRKQXk3WG9h?=
 =?utf-8?B?Q1J2aWRDcm9KaUFwc0ZSQXBrZ2JxWmJCQlhjbWdZbTEwalpKQkVNa2FwZUVW?=
 =?utf-8?B?OGZOU3JycEhsdURpSVo4UnowVlVXYVVWcDJxVm5obDJKSDF4MkJGck95S3dr?=
 =?utf-8?B?RHZxZG5HY2ZjU1NzWGpGTGtGYlVYQnl4NzcrUmh5UzNhTzg5Tk1kckNDUko1?=
 =?utf-8?B?ei9VNXBvVWN4VkVmK1ZGS0Y2aGJ3PT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:58:11.5796 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d9cc6c-9105-44e3-8279-08de5916a487
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8816
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

QEMU SMMUv3 currently sets the output address size (OAS) to 44 bits.
With accelerator mode enabled, a device may use SVA, where CPU page tables
are shared with the SMMU, requiring an OAS at least as large as the
CPU’s output address size. A user option is added to configure this.

However, the OAS value advertised by the virtual SMMU must remain
compatible with the capabilities of the host SMMUv3. In accelerated
mode, the host SMMU performs stage-2 translation and must be able to
consume the intermediate physical addresses (IPA) produced by stage-1.

The OAS exposed by the virtual SMMU defines the maximum IPA width that
stage-1 translations may generate. For AArch64 implementations, the
maximum usable IPA size on the host SMMU is determined by its own OAS.
Check that the configured OAS does not exceed what the host SMMU
can safely support.

Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c          | 22 ++++++++++++++++++++++
 hw/arm/smmuv3.c                | 16 +++++++++++++++-
 include/hw/arm/smmuv3-common.h |  5 ++++-
 include/hw/arm/smmuv3.h        |  1 +
 4 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index a97abc1f79..ea420afeb7 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -27,6 +27,14 @@
 static MemoryRegion root, sysmem;
 static AddressSpace *shared_as_sysmem;
 
+static int smmuv3_oas_bits(uint32_t oas)
+{
+    static const int map[] = { 32, 36, 40, 42, 44, 48, 52, 56 };
+
+    g_assert(oas < ARRAY_SIZE(map));
+    return map[oas];
+}
+
 static bool
 smmuv3_accel_check_hw_compatible(SMMUv3State *s,
                                  struct iommu_hw_info_arm_smmuv3 *info,
@@ -74,6 +82,15 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
         error_setg(errp, "Host SMMUv3 doesn't support Range Invalidation");
         return false;
     }
+    /* Check OAS value opted is compatible with Host SMMUv3 IPA */
+    if (FIELD_EX32(info->idr[5], IDR5, OAS) <
+                FIELD_EX32(s->idr[5], IDR5, OAS)) {
+        error_setg(errp, "Host SMMUv3 supports only %d-bit IPA, but the vSMMU "
+                   "OAS implies %d-bit IPA",
+                   smmuv3_oas_bits(FIELD_EX32(info->idr[5], IDR5, OAS)),
+                   smmuv3_oas_bits(FIELD_EX32(s->idr[5], IDR5, OAS)));
+        return false;
+    }
 
     /* QEMU SMMUv3 supports GRAN4K/GRAN16K/GRAN64K translation granules */
     if (FIELD_EX32(info->idr[5], IDR5, GRAN4K) !=
@@ -657,6 +674,11 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
 
     /* QEMU SMMUv3 has no ATS. Advertise ATS if opt-in by property */
     s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, s->ats);
+
+    /* Advertise 48-bit OAS in IDR5 when requested (default is 44 bits). */
+    if (s->oas == SMMU_OAS_48BIT) {
+        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_48);
+    }
 }
 
 /* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index ca086ba00a..cb02184d2d 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -299,7 +299,8 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, BBML, 2);
 
-    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS); /* 44 bits */
+    /* OAS: 44 bits */
+    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_44);
     /* 4K, 16K and 64K granule support */
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, 1);
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, 1);
@@ -1949,6 +1950,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             error_setg(errp, "ats can only be enabled if accel=on");
             return false;
         }
+        if (s->oas != SMMU_OAS_44BIT) {
+            error_setg(errp, "OAS must be 44 bits when accel=off");
+            return false;
+        }
         return true;
     }
 
@@ -1959,6 +1964,11 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
         return false;
     }
 
+    if (s->oas != SMMU_OAS_44BIT && s->oas != SMMU_OAS_48BIT) {
+        error_setg(errp, "OAS can only be set to 44 or 48 bits");
+        return false;
+    }
+
     return true;
 }
 
@@ -2085,6 +2095,7 @@ static const Property smmuv3_properties[] = {
     /* RIL can be turned off for accel cases */
     DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
     DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
+    DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2115,6 +2126,9 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
     object_class_property_set_description(klass, "ats",
         "Enable/disable ATS support (for accel=on). Please ensure host "
         "platform has ATS support before enabling this");
+    object_class_property_set_description(klass, "oas",
+        "Specify Output Address Size (for accel=on). Supported values "
+        "are 44 or 48 bits. Defaults to 44 bits");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
index 415b7ccde5..abe3565357 100644
--- a/include/hw/arm/smmuv3-common.h
+++ b/include/hw/arm/smmuv3-common.h
@@ -342,7 +342,10 @@ REG32(IDR5,                0x14)
      FIELD(IDR5, VAX,        10, 2);
      FIELD(IDR5, STALL_MAX,  16, 16);
 
-#define SMMU_IDR5_OAS 4
+#define SMMU_OAS_44BIT 44
+#define SMMU_OAS_48BIT 48
+#define SMMU_IDR5_OAS_44 4
+#define SMMU_IDR5_OAS_48 5
 
 REG32(IIDR,                0x18)
 REG32(AIDR,                0x1c)
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 242d6429ed..d488a39cd0 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -71,6 +71,7 @@ struct SMMUv3State {
     Error *migration_blocker;
     bool ril;
     bool ats;
+    uint8_t oas;
 };
 
 typedef enum {
-- 
2.43.0


