Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A75D2502E
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 19:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf1ZB-0000h5-7O; Sun, 11 Jan 2026 14:57:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Z8-0000a1-KB; Sun, 11 Jan 2026 14:57:34 -0500
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Z6-00043d-Ia; Sun, 11 Jan 2026 14:57:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2KOOPCYUB0FuVuXu9tpTlugjY7poQ7RtixdOTQhOB9B+Yx0o1dbzNK+3YvooZTpWAoGx0JFXGnkznewKfG4vL4m6Uy2aoH1naLCwzomb/1515Cast0iVJ5AAyunJfURYb2tFYJFTjdsdCppPuqUixGkb8N4epFKuxntA4/qopV3KLWTyB2MASELVgoNxj4rGv0kQVv/I/aevudSx9btwAGZY+5Inf9gCKfhSlauVngKK9jS0cfvoEwGYo2OA381CUoHZBcSMR/5L94T+lv9fdzQrX32JQzhRiaFI21Iyxh5aN/9oTHICLdLT2WIpbGlY6rG8xMbKbaGWqyUWZoLbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTpKPb6xGTLkJaZS5nxjbQYh+FY2wKT9Pn1thCy7mfg=;
 b=LW1wjW8Fz+oFAb5Wr1ccWBq5miPhHzs7ZjlY+rWCoX49f5g/d97S9PBZQFPhtSbqHMc3ofVf1NeDsWNoUO6k8l6ha5wyZyPD2FUfHXSc4z/RpZEho4h8J1NjGdcKn9U+o3ZApvruJxLRDyggz5B0rYnfVmdpSNJfMM73SbqyNyS9V0RRcaZdcTzo+XzPEjShvJ1iwU1/ON5JLS9KkM0w3rH47WXllRm26UE9Y7h9Hye2JsRm0o+ekK9gz/GdoTRbp7XEZLS6bm+T12eAxviYcGu4yrQwQdNL/vDjPycMYEqJO9bVm2fZvuh145uOvb6QW2C9li0Lr4ZNMbXOFP7LHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTpKPb6xGTLkJaZS5nxjbQYh+FY2wKT9Pn1thCy7mfg=;
 b=DbXX2QbF8wyCFpoFWnZRBptAdu7mtMpDhwxfhlEqEh1/emCuuBWnD28NM76nwg+6KhsIi8FhauGit+yyV7pYlOCtCy1qe8iEei6GmEPXx4qNNt8sbzkIGY332jkPFGVMILtZVkhybfgZADeX914jBHh+p2onXa4dkUI31m3BIF9X/MO5v8zZbO8TrIgrAsI5QLBbEB6qsbqwGl3m4JRb8cpxwA8QamO51YJPp7yfjKCbM/Itn9rp1kTqaj3QM3S0vbWKoQapOGMPMwN34J5tdR4QME+vSjEs/KrqNyua9wgtrV1r0l9yyYKwMnbGHJ4d7UHT0tFBESQOW2KEIZiFjw==
Received: from PH0PR07CA0085.namprd07.prod.outlook.com (2603:10b6:510:f::30)
 by BY5PR12MB4290.namprd12.prod.outlook.com (2603:10b6:a03:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 19:57:27 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:510:f:cafe::66) by PH0PR07CA0085.outlook.office365.com
 (2603:10b6:510:f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Sun,
 11 Jan 2026 19:57:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 19:57:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:57:20 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:57:15 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>
Subject: [PATCH v7 18/36] hw/arm/smmuv3-accel: Add support to issue
 invalidation cmd to host
Date: Sun, 11 Jan 2026 19:53:04 +0000
Message-ID: <20260111195508.106943-19-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111195508.106943-1-skolothumtho@nvidia.com>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|BY5PR12MB4290:EE_
X-MS-Office365-Filtering-Correlation-Id: 390eeeba-1101-4291-42c0-08de514ba53f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NExOTWFSczRsMnR1cUdrZEQxS0YvZ0huajNMODJJQVlzK2t6dlJmVlZmU08w?=
 =?utf-8?B?cFM2YjRFVjlYRWlFMUVlR091N2JEU2pIS0pvdjhNaTlOclRXSXk3b212ZERt?=
 =?utf-8?B?cGlJSm9OaWhFMGVlQkVDZ2VtOGNldnFhYnVBQ3h4Y0Y1VStIRnJzWThtVHJu?=
 =?utf-8?B?ZDB4aUxMSjBTbHFtNzd0ZVM1RFZ5bUJlZVlPdU9tVFFoTXFyRVBqTjhUWWUy?=
 =?utf-8?B?NlZCdjhRNHQzR1ZjSzRzaDlmbGx2MXZMZUQ5Rzd3S1Nna3QrcDA1NTdnbWp1?=
 =?utf-8?B?Q1VDQkpKQ3dXOWh2VExqRENRWVhMemZxV2NUZDJUMERDK01hL0wzWUpsY0VX?=
 =?utf-8?B?ZXNsWElKcE5XTUVDMytzZ0pOU0IvVXVjdUs1ZFpDbjQrMHdBMjhKcGtwMWJo?=
 =?utf-8?B?QmdYTi9hYmpxb25RbWw2bmo5ZjgwV2ZaWlZOZ29lUXZkbEttMDFiMTB2TGhr?=
 =?utf-8?B?U3NMVjZvSEtiRlBaOGk4bEJzM3lId1M1MktiOERhWVptaVJ1MkRKSHhUK2tq?=
 =?utf-8?B?ZVBkT1cvYnBLSExzZGt4UUxwOXNMWW5SMzNIUkxqeUZWY09WaDJBdnFLMUZC?=
 =?utf-8?B?b1JYMmY2bHpZeUFlTkhPREorWUNTOVBRMERMK3ZVOFRSaEJJUTR5Uk5nZndD?=
 =?utf-8?B?SWVEb0sySWMyTElvN2ZUU0NYUDNkRHFiT3U5N1NLcng4ZmtRcWc4NU80T29M?=
 =?utf-8?B?MHUzdXVZN0FpTEFFYzU1WFRBTzlRQ1JqNWh5dVhBSjhuNFFYOXNKMVlJeE5H?=
 =?utf-8?B?M1N2L3E5MDBDVXU0U2xacjZHS1N6WUFNTFFiVElPUk92V2liOEdtaS9RVkk4?=
 =?utf-8?B?cFhZc2ZmSDJsd3owZnVlekprUkFEQ2Ivd0wvdnpCWkFzUno5TkNqSHJ3VDNX?=
 =?utf-8?B?bVRNaWN1TW9sOXFHVXhxNU1RbHVDRXVLTmY3enJOcDVlRFJEZ0FIcHlCYndn?=
 =?utf-8?B?WW1HNHorbUlPQ0dLTmVhZktpK0NxaUljT3BzTjA0b3RRVW1zcGhrOSs0enRI?=
 =?utf-8?B?b2xIM2w1NGMydUJoTElOTjVwdnBFT2l4TmMrTFBFOXhYSk45WXZsUmdHcUhS?=
 =?utf-8?B?d1ZkTkZIUG5zcG5uT0NFaEt2Q3lUK1RqUUVBZWwzYyt2ZFVFRGZKUHVVQW9r?=
 =?utf-8?B?Y3pJaExsTG5wS1hBN1hkbXVTUmQyK0VVQXBJZ0ZHS0MwV2pvVGZrdVlsK3hR?=
 =?utf-8?B?MmZwaHpwb2tDb2ZiZWRVRTFaVy8ya3k4ZVEwZEZLUUJzb0UwWEdRMDZOTlZC?=
 =?utf-8?B?eXh3bGY0VEl1dks2b0x2U3NTaU85YUlQREUwTTAzdFZOMFQ2eFlDUXRKWjdG?=
 =?utf-8?B?T0RVdmRYMExDa1E1cDhzL2s3MVdPRTEyTjNvYk5EcmRsNW9oYVRhc1hTUVZh?=
 =?utf-8?B?aFA4KzZrUUg4ZmxkRVlQZDRzVWhLVGN5Tmh1cHFpckVqVytSN2lERXpPUHp6?=
 =?utf-8?B?VnJ2Yk15WUhXUnBCbjRwUUp6dEhXNlA2NVVFcTVSZmJFMHRwYTd3NlJxV2FO?=
 =?utf-8?B?cS9ERGd6b3cwcVpJaEtEN1lZWEFFbjNqMU1valdwYk4zVlhGZTd4amx1WTZK?=
 =?utf-8?B?SWU2V0JORHRwK1Nwbm1EWGVuL3VlQ3NlQzRBckpncFB0bk5GeS80a0NLY3hp?=
 =?utf-8?B?dU5COWNnNTZ6TmJqRGdNQ0JLT0psNW9TOUJBYnRXdDM0elhzMm5ybFdTZlVn?=
 =?utf-8?B?SFJPZm1SUWgzR0lNWGptcTZKcE9NRjhPRm5XY01LZ3BPaGFkMnZ1eVh2Q1R3?=
 =?utf-8?B?WUtBcld5aEJkREVIc1ZJcENTYUdGMUREN1N6Qm5BNjQySXJHZm5vZjBqdit6?=
 =?utf-8?B?dkM4bEYzK0dOTG9xTnk5TUZEK2piME9lVzE3ZzYvVExsWVBqaVZRM2tBcCsz?=
 =?utf-8?B?dGNOcGN1SlZMT3RVL05scTIyMzhIaUNoakprUGRibjJMdkFQaTJ3aS8yZ0Fn?=
 =?utf-8?B?MlYrTE1GaHprbFhGVHpOUllZczU5RU1EYStDa0VMYVZQVjZLUDdLV2dVUnJW?=
 =?utf-8?B?YTFZeXJJV0ZRejZwY1dwWVRUd1VkSmtYaGUrc1pYNllaN003N3RTdjZ2MTBj?=
 =?utf-8?B?RnVUN2VwMWMwM2FHY0w5YmFoQ203NThNZ00vTEhCa2hoS05XSUF5UktYcHhr?=
 =?utf-8?Q?uogE=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 19:57:26.8432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 390eeeba-1101-4291-42c0-08de514ba53f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4290
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Provide a helper and use that to issue the invalidation cmd to host SMMUv3.
We only issue one cmd at a time for now.

Support for batching of commands will be added later after analysing the
impact.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 36 ++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h |  8 ++++++++
 hw/arm/smmuv3.c       | 16 ++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index c6ee123cdf..89dc6f991c 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -233,6 +233,42 @@ bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
     return all_ok;
 }
 
+/*
+ * This issues the invalidation cmd to the host SMMUv3.
+ *
+ * sdev is non-NULL for SID based invalidations (e.g. CFGI_CD), and NULL for
+ * non SID invalidations such as SMMU_CMD_TLBI_NH_ASID and SMMU_CMD_TLBI_NH_VA.
+ */
+bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
+                                Error **errp)
+{
+    SMMUv3State *s = ARM_SMMUV3(bs);
+    SMMUv3AccelState *accel = s->s_accel;
+    uint32_t entry_num = 1;
+
+    /*
+     * No accel or viommu means no VFIO/IOMMUFD devices, nothing to
+     * invalidate.
+     */
+    if (!accel || !accel->viommu) {
+        return true;
+    }
+
+    /*
+     * SID based invalidations (e.g. CFGI_CD) apply only to vfio-pci endpoints
+     * with a valid vIOMMU vdev.
+     */
+    if (sdev && !container_of(sdev, SMMUv3AccelDevice, sdev)->vdev) {
+        return true;
+    }
+
+    /* Single command (entry_num = 1); no need to check returned entry_num */
+    return iommufd_backend_invalidate_cache(
+                   accel->viommu->iommufd, accel->viommu->viommu_id,
+                   IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3,
+                   sizeof(Cmd), &entry_num, cmd, errp);
+}
+
 static bool
 smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                           Error **errp)
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index c7ed4dce3a..41b37e3122 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -47,6 +47,8 @@ bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
 bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
                                     Error **errp);
 bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp);
+bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
+                                Error **errp);
 void smmuv3_accel_reset(SMMUv3State *s);
 #else
 static inline void smmuv3_accel_init(SMMUv3State *s)
@@ -68,6 +70,12 @@ static inline bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
 {
     return true;
 }
+static inline bool
+smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
+                           Error **errp)
+{
+    return true;
+}
 static inline void smmuv3_accel_reset(SMMUv3State *s)
 {
 }
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 6ed9914b1e..4efef73373 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1388,6 +1388,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
 
             trace_smmuv3_cmdq_cfgi_cd(sid);
             smmuv3_flush_config(sdev);
+            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, sdev, errp)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
             break;
         }
         case SMMU_CMD_TLBI_NH_ASID:
@@ -1411,6 +1415,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
             trace_smmuv3_cmdq_tlbi_nh_asid(asid);
             smmu_inv_notifiers_all(&s->smmu_state);
             smmu_iotlb_inv_asid_vmid(bs, asid, vmid);
+            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
             break;
         }
         case SMMU_CMD_TLBI_NH_ALL:
@@ -1438,6 +1446,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
             trace_smmuv3_cmdq_tlbi_nsnh();
             smmu_inv_notifiers_all(&s->smmu_state);
             smmu_iotlb_inv_all(bs);
+            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
             break;
         case SMMU_CMD_TLBI_NH_VAA:
         case SMMU_CMD_TLBI_NH_VA:
@@ -1446,6 +1458,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
                 break;
             }
             smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1);
+            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
             break;
         case SMMU_CMD_TLBI_S12_VMALL:
         {
-- 
2.43.0


