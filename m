Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D9BCAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 13:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3E8e-0003gc-4P; Mon, 29 Sep 2025 09:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E7U-0002mv-PZ; Mon, 29 Sep 2025 09:40:50 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E74-0003eR-Dh; Mon, 29 Sep 2025 09:40:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ElGEWbFnSakaQU9AHlCMeRjZJ6Cf4GKZqoQbv0gm6FIJcvMEfDJvT23C7RA/fQmOhJNKZjWadaj0hy2lfq1xYFdoFzZZAqH9IpJOHK/5eEenvBfTjxb12BnOsli2fHz2zTBGv53k733iUVSNQFGMyBnPQMivLc99LeU8kl/YvjJ60sXhRPxSkZPmgSIfxh36r8++7fzSijjXWioGfU49enw/ha5RsjcvWCh9UFKa5619B4JXylOd/CQKkELTu+SIEGtgKu67c4tNRyMkzmk9JcH1LNmOf8HrNhKT9nQbcREFxy5qehvUCgCwDp26PAxEL3rWvAWdeLAmQfsfRJzRKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7ZHigqJaeIqfjlrzeCbf9i6sGY386bvQBikviDzzVk=;
 b=Spo/0o4ZN5Q2nLC5SVJ2qXHpE6ne+Tcxyr8pwhNNNTqphgtUSrwgjl2y46DYBRgBVKikWFX/71xo3Vwp/32YEWNf2fDq7bO3xGYTUbVakZ3zeDeMQf99q8YTRtYWJg/MknDHCQSqxYhTcFvY9uG6reh6BgV7QwnAj8+UkxWx8W97AlV11uskjafZdr4wsR55BnXo5EEtisXU7xZgUyotWLkt53UkKNQxR+1JShS688Wy3jcvfzQf4NxOHXVljrIb44L0im3BjqmNG0f2DRyg7HiRbTIPtAIqTN44PoPh2NhAGJqm1DClHO8cdaMBdomblCANAp31WaYv1bKuFCFSIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7ZHigqJaeIqfjlrzeCbf9i6sGY386bvQBikviDzzVk=;
 b=khFw6nYjml4y1TOSK6IT7+FTb/UiYQF7u57xPia9SMXL3uSa97qHmGXwL+dvFolq9/PW1tAokh0nV5vLgBhDoDkAZWBosza9L3QfomYSZaNa/3GoGNMjArS2qK04I3yGVrbTbACwjXuXpjplXaU3XsiboQLszwywxstSP+j/AdAx0cPnEmXkewGuyhgZFg6Xu/r4SPLXpQQOkFiHTk8wPqD4Tv/CclM01iHLx4BACdnvO7XsUaQywGsI2lQxlsuwxOm9ITQjrCQQQDHTKjOlqaA7J9qiPDNVeYvpsUDc65Kaggd5C/WZ2wek5lii0xYQ5ApL3hI0QGdeCrzws8Mgfg==
Received: from CH2PR08CA0014.namprd08.prod.outlook.com (2603:10b6:610:5a::24)
 by DS0PR12MB6605.namprd12.prod.outlook.com (2603:10b6:8:d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 13:40:09 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::d1) by CH2PR08CA0014.outlook.office365.com
 (2603:10b6:610:5a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.16 via Frontend Transport; Mon,
 29 Sep 2025 13:40:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 13:40:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 29 Sep
 2025 06:39:58 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Sep
 2025 06:39:54 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: [PATCH v4 13/27] hw/arm/smmuv3-accel: Add support to issue
 invalidation cmd to host
Date: Mon, 29 Sep 2025 14:36:29 +0100
Message-ID: <20250929133643.38961-14-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250929133643.38961-1-skolothumtho@nvidia.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|DS0PR12MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: a52c8ddc-6b66-47a1-7b3f-08ddff5db56b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|7416014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0wrdFQzTUdNRWFQK2prVEV3QnhGRkliMlMxbG5tVGlpcU9GNjNQWENRU3RY?=
 =?utf-8?B?V0xWYnovZWdvbFJKbDFicUxQN0FTcWFQeC9qNEFzSnA3NC93STJyaDZTMmRB?=
 =?utf-8?B?RXhid1VmOWxCTmdJcmwvTjlPVXYxeEYwNld4NS9PYy9sY3dMNDcydGJmWVFD?=
 =?utf-8?B?N0RJMVROS1hzSjlIcC9ib1huVlRqWUc3Vmc1T0NVcVhEMWxFQU9HRzRkRzZB?=
 =?utf-8?B?NFRyUUhhYkM4V3B0OWVNNFVrSFRPdGd5enUxYXFwZW1YdTRtUlVGUDFPV3ZW?=
 =?utf-8?B?bllibG5sYkJna0NxMlAxZmN4ZFY1enhRc1g3eGJ1SzIwclhkdm5wOWx4VHgw?=
 =?utf-8?B?UDJKcVVreWRhR1NhN2ZpS3dIeDlIQkFtQmNjRDJXRy9LNEN4YnkwSnVMaDZ6?=
 =?utf-8?B?QytpZFBoemRLR0YvUm1UWjkzUHpnRDVMY0F5elpFUkFMaUZldEJROVRVZXd3?=
 =?utf-8?B?ZVpXbWh2aktJMW9sTjZpeHF6Z0N2ZzAzcTZ5QytIbmtKZGZCd0FaN2o2UGZU?=
 =?utf-8?B?dE5scnAralF6L3hvSGpKamljaXI5S0IzMUVzUUVNdFlUcTVmT29oMDhKRklP?=
 =?utf-8?B?elo5VndBKzN0b3RGeWlkRmwrM21KTjl4Vkl1c0xPMFUrNTNBRi9ETDcxaHJN?=
 =?utf-8?B?MXU5ZEx6Q2lyM0dLQkhMYWR3dk5nMkt3MncxbDRqODREdld4eUF3Y0k1N1VX?=
 =?utf-8?B?Z044aFYxS2Z6QU5adTFmbjlYS3FJWWROd1NVemQrUFZiclEwL0MwdllCRC8x?=
 =?utf-8?B?L2lpcHU1dVBhR3RJRmFpN04vSnlndVBZUytsWktXS2dqMFgyRTRKYlRGZ011?=
 =?utf-8?B?bkg4S1JZWnByQ0w1UjdBb0ROUFVreEIxc2JuZFBnUXNKdG5RbnhmK2d2Mllq?=
 =?utf-8?B?VkRCTlJyZW1vbUlxajNNTjB3NUlsSlhxUEU3TUNiZHBTajl0cjA5aHA3b3Rz?=
 =?utf-8?B?OVE3b01tK1Y0b2VzZVdaTGttZHFwOWx0UEZmNG04RHFJZUtzK2xBdmFMT3Fm?=
 =?utf-8?B?L09lK1M4aHdnblRZbndUbFBORzlhRnM0ZUtsOXZDZi8vSmZJY2dvMzFwZWFI?=
 =?utf-8?B?RlRtaDROWGQyWUcvTC9mdnVFZDdGT2JmWHgvTWw1OHBvTzcrcFlBdWtTZVZQ?=
 =?utf-8?B?VUsrb3NCbHNrZTBnamsrL3RSVHhWdEFJb1lEM0c4QWJnbzN3Vmk2RElabXlC?=
 =?utf-8?B?VTgveWdhZ3ZJOURaWUFXMGpHUjVKbTJaNGZSc3JXdGhPNVBnNUdGWkV1UUFm?=
 =?utf-8?B?MVNMdHZteWVsUno3WGd1dHZpb3I5bmdyNGo4VTNWYXhCaHhvejJ1ODRucUQv?=
 =?utf-8?B?RGNxNUttTmJqOUZMaW0rNjdmOE9Vc3JwN1FJY3NRVWpkc2g1b0Y2cDI1aWIv?=
 =?utf-8?B?Y2hXbXZtZjlyNEVWeUlBWjIrMkxYRDQwSEZ0NTBaZjRLVnhFUi8zS1gxcWV4?=
 =?utf-8?B?NHZENGxvOXpKRklTamVLbnJHYjlWYVlYWnZIM2tSUDUrRkJ2REIwaDBpZlZm?=
 =?utf-8?B?eTBpbktiTE13NExpS0o1U25ocmFuRnJqUGhKMURiRzlkVjBpeUJCYnhSbHJq?=
 =?utf-8?B?dTI5bTdTc213SWJsYmFvU1VabUpJVkQyYVN5OVZFRlNqMVZHZjZ2ZVUvcG44?=
 =?utf-8?B?WXpmY3Y5aGk4b25vUXRoNWZJNmU3ZmhqVC9SMUI5TkxIOUZEbE4vQ05IQ0dn?=
 =?utf-8?B?OHF6VWZxenpkbjk4dGFqYXNlSkNhTFczMktrSy9HOGlUU0hsY1FPMEFCRUJR?=
 =?utf-8?B?MGJHK3ZMR1MrZWRjNHFWZENGdFYzZm5hU3RvRjFVaWRycENEc2Nudk5Ia2gy?=
 =?utf-8?B?cmZpaGdrblVxTlFPeG9yRHhKVHoxaytaNTlWQ1pXQWd1MHhDR2Q1aURFQ24x?=
 =?utf-8?B?L1hVTU1DT3dOOEpHYmJBN3JmSStoeHNDejNaNERlYlBGZWt6dkVGZ2xDZHR1?=
 =?utf-8?B?OWI2S0ZBYVRmT0RKWTREWFBOL2pZZElXckhOeFVOQzZQZWU1UG0zVmQrWkxE?=
 =?utf-8?B?T2tTOVhUZnNld3owaVdySEN2TFhoQzhOVFZUWmtMdnhtZUhndWErYld1TWlY?=
 =?utf-8?B?ci90L0RGcTJSUTRlWHVnUldKM2FMWnRSanV3SCtwbW9KNnJuSVhyNFpQV3R2?=
 =?utf-8?Q?tbYU=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:40:09.5778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a52c8ddc-6b66-47a1-7b3f-08ddff5db56b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6605
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
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

Provide a helper and use that to issue the invalidation cmd to host SMMUv3.
We only issue one cmd at a time for now.

Support for batching of commands will be added later after analysing the
impact.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 38 ++++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h |  8 ++++++++
 hw/arm/smmuv3.c       | 30 ++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index f4e01fba6d..9ad8595ce2 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -218,6 +218,44 @@ bool smmuv3_accel_install_nested_ste_range(SMMUv3State *s, SMMUSIDRange *range,
     return true;
 }
 
+/*
+ * This issues the invalidation cmd to the host SMMUv3.
+ * Note: sdev can be NULL for certain invalidation commands
+ * e.g., SMMU_CMD_TLBI_NH_ASID, SMMU_CMD_TLBI_NH_VA etc.
+ */
+bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
+                                Error **errp)
+{
+    SMMUv3State *s = ARM_SMMUV3(bs);
+    SMMUv3AccelState *s_accel = s->s_accel;
+    IOMMUFDViommu *viommu_core;
+    uint32_t entry_num = 1;
+
+    if (!s->accel || !s_accel->viommu) {
+        return true;
+    }
+
+   /*
+    * We may end up here for any emulated PCI bridge or root port type devices.
+    * However, passing invalidation commands with sid (eg: CFGI_CD) to host
+    * SMMUv3 only matters for vfio-pci endpoint devices. Hence check that if
+    * sdev is valid.
+    */
+    if (sdev) {
+        SMMUv3AccelDevice *accel_dev = container_of(sdev, SMMUv3AccelDevice,
+                                                    sdev);
+        if (!accel_dev->vdev) {
+            return true;
+        }
+    }
+
+    viommu_core = &s_accel->viommu->core;
+    return iommufd_backend_invalidate_cache(
+                   viommu_core->iommufd, viommu_core->viommu_id,
+                   IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3,
+                   sizeof(Cmd), &entry_num, cmd, errp);
+}
+
 static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
                                                PCIBus *bus, int devfn)
 {
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 6242614c00..3bdba47616 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -46,6 +46,8 @@ bool smmuv3_accel_install_nested_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
                                      Error **errp);
 bool smmuv3_accel_install_nested_ste_range(SMMUv3State *s, SMMUSIDRange *range,
                                            Error **errp);
+bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
+                                Error **errp);
 #else
 static inline void smmuv3_accel_init(SMMUv3State *s)
 {
@@ -62,6 +64,12 @@ smmuv3_accel_install_nested_ste_range(SMMUv3State *s, SMMUSIDRange *range,
 {
     return true;
 }
+static inline bool
+smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
+                           Error **errp)
+{
+    return true;
+}
 #endif
 
 #endif /* HW_ARM_SMMUV3_ACCEL_H */
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 1fd8aaa0c7..3963bdc87f 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1381,6 +1381,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
         {
             uint32_t sid = CMD_SID(&cmd);
             SMMUDevice *sdev = smmu_find_sdev(bs, sid);
+            Error *local_err = NULL;
 
             if (CMD_SSEC(&cmd)) {
                 cmd_error = SMMU_CERROR_ILL;
@@ -1393,11 +1394,17 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
 
             trace_smmuv3_cmdq_cfgi_cd(sid);
             smmuv3_flush_config(sdev);
+            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, sdev, &local_err)) {
+                error_report_err(local_err);
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
             break;
         }
         case SMMU_CMD_TLBI_NH_ASID:
         {
             int asid = CMD_ASID(&cmd);
+            Error *local_err = NULL;
             int vmid = -1;
 
             if (!STAGE1_SUPPORTED(s)) {
@@ -1416,6 +1423,11 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
             trace_smmuv3_cmdq_tlbi_nh_asid(asid);
             smmu_inv_notifiers_all(&s->smmu_state);
             smmu_iotlb_inv_asid_vmid(bs, asid, vmid);
+            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, &local_err)) {
+                error_report_err(local_err);
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
             break;
         }
         case SMMU_CMD_TLBI_NH_ALL:
@@ -1440,18 +1452,36 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
             QEMU_FALLTHROUGH;
         }
         case SMMU_CMD_TLBI_NSNH_ALL:
+        {
+            Error *local_err = NULL;
+
             trace_smmuv3_cmdq_tlbi_nsnh();
             smmu_inv_notifiers_all(&s->smmu_state);
             smmu_iotlb_inv_all(bs);
+            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, &local_err)) {
+                error_report_err(local_err);
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
             break;
+        }
         case SMMU_CMD_TLBI_NH_VAA:
         case SMMU_CMD_TLBI_NH_VA:
+        {
+            Error *local_err = NULL;
+
             if (!STAGE1_SUPPORTED(s)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
             smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1);
+            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, &local_err)) {
+                error_report_err(local_err);
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
             break;
+        }
         case SMMU_CMD_TLBI_S12_VMALL:
         {
             int vmid = CMD_VMID(&cmd);
-- 
2.43.0


