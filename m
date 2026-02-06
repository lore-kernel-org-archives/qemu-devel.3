Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822ABEE20A6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 14:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voNAn-00013a-VA; Fri, 06 Feb 2026 09:51:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voN9u-0000Tu-7k; Fri, 06 Feb 2026 09:50:12 -0500
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voN9r-0007Jq-PP; Fri, 06 Feb 2026 09:50:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gMWL1KueLmuEHcGELBgFUEVazbhb+sXlgbiiGpY1iJKN2Keafu0DIX+vP2PM0uuj0kY0dzY3UN0oZP5gePsRKn+CWk0h6TJPF9tLD1zkpq3puTRSy5B1DTws2P8PI+VATjCAOHaP1B/1LPOQhcJV1YQihKo/kuMO4FdcG45m4TdZ424bTsyFgZqSjIsgCiBKakt9LFFyT42eT1XMgy1ZPzpcYeODtXhM+zTAePaIJXYlIMH/VlQy7a6+M2ih7rIiXkf7AMxjaYsK9svMZRtWFqv5U7ZkZPW+6wdj3Sw7tLy9GUG6SKVl1tIb04mJXGU7htfn5VyLmGMvMpMdhDTG1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qu6CE2Wo71XoLyHx9YZ0GLTUumkgBn+1Z9gtLaz+YyM=;
 b=vOasZGUqiU+rCXx4eRsSYPhF/DG3IrVlqnH3pjfet8uETVoZQl98PJGtGt/CC07ud9MsZFLuW3J7JaDkXr80on5y05xcLoHEm0b+xoQsdS7/GdLsK1vt++7tLN6wYEBb74nKG7xVtha3wfz8bXWpn9274iPylI6eAO5mkD9vjN3Zxeppyk5j5ojUKzRMKDgAMnCMNWxRV5Ws/uzlhK87HvwPGQudkqOuA3pPuOljnDB8ZAaHwzXGKv5fIHopt0IB5TVNdLRgrbhm4ozLnPROm8P/2F4cj5zrOKQTtmM2QS7OBzYqnKv8HUEBrUNIqibscsA56NIVGYqtY8FCcFIKSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qu6CE2Wo71XoLyHx9YZ0GLTUumkgBn+1Z9gtLaz+YyM=;
 b=uD9ZU7TQVxtEIfV+PMFflYmequhg74j6+/CLoe4O8KofgBrBS7jy8kqsVuLx8g2RKDsFF6g1CmQb7jUqbZWgJ17NgGwoXHql6PV9D2xMR891ITwkXoFQ96Rzv/aaeYeAv3xBAs1dSMZUU1XcKwbBwzAtBVjs3It6CrIUtly6asOhjm+bpscj6q20INTeDqI+ZV51TmXcQUwNavu164YKYg3PnYo/iB0oSoyUPQQS3uIS7WSpCCF6BP1+Gx9K1UO6LuOTdHuh3dgeHSt4xUbvtti7XH+4ib+jyUNihD0fDPMaZofvA56vbHKJE9eOy+wo1O0wbz0aTkj7QcXhTjU2Hg==
Received: from BY5PR13CA0022.namprd13.prod.outlook.com (2603:10b6:a03:180::35)
 by CY3PR12MB9553.namprd12.prod.outlook.com (2603:10b6:930:109::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 14:49:59 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::75) by BY5PR13CA0022.outlook.office365.com
 (2603:10b6:a03:180::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 14:50:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:49:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:49:36 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:49:33 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v2 08/24] hw/arm/tegra241-cmdqv: Implement CMDQV init and
 vIOMMU allocation
Date: Fri, 6 Feb 2026 14:48:07 +0000
Message-ID: <20260206144823.80655-9-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206144823.80655-1-skolothumtho@nvidia.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|CY3PR12MB9553:EE_
X-MS-Office365-Filtering-Correlation-Id: 948a3efa-cbc2-4af7-26a5-08de658f0016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ligTsnCRkvQXR2YphnS5bAiYhqjyH+aQDIo9weyeooUqFzBqzyGFqeFzY5ht?=
 =?us-ascii?Q?V6piROVcgSvd1fyYX2UkZBPgdZ2h6oq/FSrISTprY8WMR/j2Gni6F7Qxa6Mb?=
 =?us-ascii?Q?00SNv09TTuuVOLdW7WjxyDcjfaxIyVrX8j5e2YniJVKuBckRHR/sbmQ0WEXS?=
 =?us-ascii?Q?Fb/H/xWhu2mR2dRu/djgbI50pVSFLbZUKyJXOBqJKYBvYNQoblL9502JWvqX?=
 =?us-ascii?Q?tpS08SY9JdVeVNePP+xnwmU5yXXWzgjuLNn5383SdCmRtebHuOnluhnGIEZQ?=
 =?us-ascii?Q?1bvAYJoNt8I6r/yN+UcjP614r2tdwhcnGPQHlnxHx1IOszcdwjRp8u8JGptv?=
 =?us-ascii?Q?Cxzze/RKvixDMn9wXRQLaLKZz1Bno7vMyxbUEP21pidqGYV1JLdeSOhTETH9?=
 =?us-ascii?Q?zm/oHjFCI9q4h5mcvCIxNGdD7jn7IEO3zRiFaboVmxFJsh3rrfKsmnkLXuNu?=
 =?us-ascii?Q?wBaIACx5+4ukAEpVPGkKskMhkvk7AMmR9p3HZ/5GVtEvoKrCrdwGWr4lLqZk?=
 =?us-ascii?Q?jPKeaZePvylDPT+lxpcc9Wb6bVBVU5gqZrPaRlCw1HDa+Gm97Q7kTkMH8Gzw?=
 =?us-ascii?Q?YjlTxrwOnyDAgRgj/6pbBjTrc3ZDb6xXsnZtA9DrtNhtUDL3qZyPTi7bKDqz?=
 =?us-ascii?Q?qKCZ3PawSLy0uROGR1T/GIEyh++NlCSmGwP8y84zGWw2VwG3GvnUPOinPF3y?=
 =?us-ascii?Q?dUyjkycKzjayAytpbsjAzTvehOcRtc3knWvDMWD56XMNDhXRloVSlhtY31du?=
 =?us-ascii?Q?3yD3V7oHL3Z2v5Mo8m2I2/RX6DuEx+fmtYAola2qHjNtQt7FpVWYN1GTwwca?=
 =?us-ascii?Q?tJ4y9xWMtDRG62JwQ7ZyKFH8kTwQXQJ3A0KVQPPWU0SxU3MT9mFFjzDfuTgp?=
 =?us-ascii?Q?4I8OKBKapppqYk9nCeM3wNu4j3/t7Aq2JyVjDrim/5eJvsga2AcHMXL4fwJ1?=
 =?us-ascii?Q?Y7TzjW3yNKu6zM1wvdDwqU002yatFKgsdYeGmTqWFL7XI4HAcFcNH5Io6TCV?=
 =?us-ascii?Q?eO/21cfEnsKmOV3xdczHvlu3JCPdtwGFu0XqzC+Igm76ity3wnfQFGAlfvzo?=
 =?us-ascii?Q?FWO0abex2NbLZfXfN0cXEjpebFvDrZ7bzQ6g/goYL/VgOiMMv0gaKV/TAQFJ?=
 =?us-ascii?Q?SFCTQcyVkWxlmefZyhCTD3RALzltaHOamoFppM3ybSLl7JqrZq6SmFjKaQ4a?=
 =?us-ascii?Q?Q5qm3dZguoPhabV5b69UZmwiCnyxQxEXxK9kgmcrAnMIVlEo7t4xCaKrcxrP?=
 =?us-ascii?Q?CUTdne7tOTV0A1JBikwLdP9Mboky9IkN3RWlJBq9ABCP/vIMjBSX3yFjbH4S?=
 =?us-ascii?Q?TOvt3INMgV9PZBzyj48eHf+XVf4lejqIbX3K3/W8PDXmSPod8e+GyA8kmNIp?=
 =?us-ascii?Q?yhs29jt6H8nPaCdec1dYHfCFqtcd1tfP4+AgMPtUnujbJbCQA/sp8dr0IjnF?=
 =?us-ascii?Q?CQdwdI8ETdeuLwlohrEVccFx+0twBmeV8FsXwwcSOsJtULMu4oIUl8HE+WoX?=
 =?us-ascii?Q?JX7/6NPczRIya0ZQmKAN98bFSktjtADz9YbXaAa0px6bj6y3GGneSxWeb3+p?=
 =?us-ascii?Q?N95mayZraGZxOReQqFh/AtmgT1Vy6TUskdMJhKio+yzeczSxow1BGZaYmF08?=
 =?us-ascii?Q?8VfyEYQ+etjLvbA1cq/+dS7Q3+bZ2qia99fzz3Q7CfWgxMti8se3vLUnMvNM?=
 =?us-ascii?Q?L63Ppg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gz4EAs4tAZjAugvF741+f4O8bu8DCPpeikv5OB+E21Hv3L2ZIgYEb8lyVo68JsmWMgEiS55p5cSbz1FtBn/RTQqrffTJJKMeg84mGI7ppb/s5LVIB4Kz1CQ3YEIPJKgvGF1Q+yII9DZhGRrm2bvA7fq0INUGSpkfB5ap+hRwh5hUS95CazxmeBnws4FyjBRZos9bSzzjYKCJTlAC1v+7ft6PaXDfB4oSHWY0QwWQ9dEk/IPlUonIWRdcKQrubMXD2oUlJ98eDQFxac1R3JUfUQ61pz2d0IeieA9qcJ1egmNXWW4z+jitNtl9QOU8ByFQTuQBrVxHzgL2QdIEg0dAVFJnT0s3Jp6M1KgP1Tt+h98HdbG2K+Qd6swdnYvHUJeWvsxS0sov0kWWKRamzQ63Nd99MKH4pS7aQ2WRGBN7PvmWWGKkEw+IN8rVXfnCYZzl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:49:58.8198 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 948a3efa-cbc2-4af7-26a5-08de658f0016
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9553
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Nicolin Chen <nicolinc@nvidia.com>

Add initial Tegra241 CMDQV support by wiring up initialization and
IOMMUFD backed vIOMMU allocation. The CMDQV MMIO region and IRQ are
registered, while register handling remains a stub and will be completed
in subsequent patches.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 55 ++++++++++++++++++++++++++++++++++++++---
 hw/arm/tegra241-cmdqv.h | 19 ++++++++++++++
 2 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 6f30ca035b..596b1c5595 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -13,6 +13,16 @@
 #include "smmuv3-accel.h"
 #include "tegra241-cmdqv.h"
 
+static uint64_t tegra241_cmdqv_read(void *opaque, hwaddr offset, unsigned size)
+{
+    return 0;
+}
+
+static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
+                                 unsigned size)
+{
+}
+
 static void tegra241_cmdqv_free_veventq(SMMUv3State *s)
 {
 }
@@ -25,24 +35,61 @@ static bool tegra241_cmdqv_alloc_veventq(SMMUv3State *s, Error **errp)
 
 static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
 {
+    SMMUv3AccelState *accel = s->s_accel;
+    IOMMUFDViommu *viommu = accel->viommu;
+
+    if (!viommu) {
+        return;
+    }
+    iommufd_backend_free_id(viommu->iommufd, viommu->viommu_id);
 }
 
 static bool
 tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                             uint32_t *out_viommu_id, Error **errp)
 {
-    error_setg(errp, "NVIDIA Tegra241 CMDQV is unsupported");
-    return false;
+    Tegra241CMDQV *cmdqv = s->s_accel->cmdqv;
+
+    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
+                                      IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
+                                      idev->hwpt_id, &cmdqv->cmdqv_data,
+                                      sizeof(cmdqv->cmdqv_data), out_viommu_id,
+                                      errp)) {
+        error_append_hint(errp, "Tegra241 CMDQV support unavailable");
+        return false;
+    }
+    return true;
 }
 
 static void tegra241_cmdqv_reset(SMMUv3State *s)
 {
 }
 
+static const MemoryRegionOps mmio_cmdqv_ops = {
+    .read = tegra241_cmdqv_read,
+    .write = tegra241_cmdqv_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
 static bool tegra241_cmdqv_init(SMMUv3State *s, Error **errp)
 {
-    error_setg(errp, "NVIDIA Tegra241 CMDQV is unsupported");
-    return false;
+    SysBusDevice *sbd = SYS_BUS_DEVICE(OBJECT(s));
+    SMMUv3AccelState *accel = s->s_accel;
+    Tegra241CMDQV *cmdqv;
+
+    if (!accel) {
+        error_setg(errp, "Tegra241 CMDQV requires SMMUv3 acceleration");
+        return false;
+    }
+
+    cmdqv = g_new0(Tegra241CMDQV, 1);
+    memory_region_init_io(&cmdqv->mmio_cmdqv, OBJECT(s), &mmio_cmdqv_ops, cmdqv,
+                          "tegra241-cmdqv", TEGRA241_CMDQV_IO_LEN);
+    sysbus_init_mmio(sbd, &cmdqv->mmio_cmdqv);
+    sysbus_init_irq(sbd, &cmdqv->irq);
+    cmdqv->s_accel = accel;
+    accel->cmdqv = cmdqv;
+    return true;
 }
 
 static const SMMUv3AccelCmdqvOps tegra241_cmdqv_ops_impl = {
diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 81c9deb384..6ea0087f61 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -10,8 +10,27 @@
 #ifndef HW_TEGRA241_CMDQV_H
 #define HW_TEGRA241_CMDQV_H
 
+#include "smmuv3-accel.h"
 #include CONFIG_DEVICES
 
+/*
+ * Tegra241 CMDQV MMIO layout (64KB pages):
+ *
+ * 0x00000: Global CMDQV registers
+ * 0x10000: Global VCMDQ registers, page 0
+ * 0x20000: Global VCMDQ registers, page 1
+ * 0x30000: VINTF0 logical VCMDQ registers, page 0
+ * 0x40000: VINTF0 logical VCMDQ registers, page 1
+ */
+#define TEGRA241_CMDQV_IO_LEN 0x50000
+
+typedef struct Tegra241CMDQV {
+    struct iommu_viommu_tegra241_cmdqv cmdqv_data;
+    SMMUv3AccelState *s_accel;
+    MemoryRegion mmio_cmdqv;
+    qemu_irq irq;
+} Tegra241CMDQV;
+
 #ifdef CONFIG_TEGRA241_CMDQV
 const SMMUv3AccelCmdqvOps *tegra241_cmdqv_ops(void);
 #else
-- 
2.43.0


