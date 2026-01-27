Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D71D2D8EF
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 10:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkgRu-0004Sa-F6; Tue, 27 Jan 2026 05:37:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkgQc-0003EA-6V; Tue, 27 Jan 2026 05:36:15 -0500
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkgQV-00017q-73; Tue, 27 Jan 2026 05:36:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJRlw3W+Nvy3QwHcTPQlYyMQi0djTu0/AdbY7UV9VfeRI7zLCGo5PcJjPM5Lf4a5vtBMzx6qjjpB9/FE4mzgV5DZPXfhnadkpa/aAMEx/ffL9qyx1ZLwfM4n3s5xmczeGB+vRH1Pu6DzXCYhb6Ugk8OcwZsrJkQMQMM4A28N8Il1MiGrHUsZIP9RQp5Jx5cKgWcX0MlyiMYRUmg8bFMOgvQaQhjb2bOkzWOzed7nKWSs6nyphsTmLTHxujsvSV0enJGUJFzQZMbbumlwMhw/PqQADypWjBQXr6MZaXerd2T8ZgIY70uPdC2XhBbIQz8UP0tJRJtlhH6Bx31jeaqe8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7XLTBK8Gh2r/wj4zljP+9fHPuER/ZXw6oQx58rGO1o=;
 b=yhH/AJxIoB2x0YePMq/ooGDQl696opoSP/FmqeQj6MDr/6ARo5oVOc/5vWYYIaZS6sovEtHFJmbvbYm/V+6tousMSnDf928+N+Cz6CytwsKNfLgzRlT0/MGLr2dOMPK1oBiBtWa1wa2eDVmjpOs2BDksNXX2lYw9eeAB7ACErppcLB8MFKPrRzHmqXU+ZHZcG6BD/AvbdTKpuPK+o1xXCAZKVj+r3AOYxKugwVu2wFYuivFln8WCUFb4oQU8m5KXFRHUoKFeXK+arCaBmyC/4YvRZsfZJr6ndTxqsD006oDCW0ouqYSS34TRgZg1GotRDcB4dhxRVppuVkziZwXL+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7XLTBK8Gh2r/wj4zljP+9fHPuER/ZXw6oQx58rGO1o=;
 b=t0puA6hbo46z5pr4d30oUUK0lFFNHqWAi32WJzOrNmyOwgfcRTohLsC4IbGzG3q7p2xTIy/Iv+z7yYHfOJ1ll76OKFP/osUUcKhbV/NlW2LFUF2+t/1hvwB2vFB+5xhklwpQxScg9UTPZWgSK3At35G00mpe1rG+MVlCOzYbIJ9dXmDcVbPAvgxMD0nEtRASahx459i3D3oRA8cnS/bUWf0+aWmzaOn8elAQHdo1MHQLtxb3U+c7mwHoOl9MKZUI/OOMdwI1gkQuJYrUrwda7dNygbRiqMKroYUXI050BRgLgvaWJk6QjrxuuKK6+p5slNA3Hh/tXs0nekE8WrdzMg==
Received: from CH0PR03CA0414.namprd03.prod.outlook.com (2603:10b6:610:11b::32)
 by LV5PR12MB9828.namprd12.prod.outlook.com (2603:10b6:408:304::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 10:34:33 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::12) by CH0PR03CA0414.outlook.office365.com
 (2603:10b6:610:11b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Tue,
 27 Jan 2026 10:34:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 10:34:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:34:20 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:34:17 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v3 2/4] hw/arm/smmuv3-accel: Allocate vEVENTQ for accelerated
 SMMUv3 devices
Date: Tue, 27 Jan 2026 10:33:26 +0000
Message-ID: <20260127103328.255382-3-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127103328.255382-1-skolothumtho@nvidia.com>
References: <20260127103328.255382-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|LV5PR12MB9828:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d77cd0-920e-4bbd-c3da-08de5d8fa91d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P6CWcR7id44m0qIoq82kJbzqcpDqzRg2MOmJW66M9/RN4kqnzcNcLMItF8D9?=
 =?us-ascii?Q?DlfzBkYggcLmLzeVfUvPxswi17PqiY5r3pH9oAKMato7Ybg3gTu/jhDzFJ2y?=
 =?us-ascii?Q?LCKiZWCsQ7uMAZsVeY41HkjlbEsTgorlSNlNKplmlE0eDYtEXYcCy2BJb5Aq?=
 =?us-ascii?Q?Bu5XpnrFqihQO3eMw/nLRDGuHytDp02m4wFc//8IK02rLfwJFPoq9VCBwv5t?=
 =?us-ascii?Q?dap2UgW9Mppn0ZMk6poh/EByhofXd8XV2Um9/5R34vhDehbMzA7JY1I7AlrC?=
 =?us-ascii?Q?oQDmGBDlHhQmN/hHbOCi5F22ED1/AaS+vpU5MCB64kZJpMMV19YEk7QKpbEH?=
 =?us-ascii?Q?Bl5Xz7uokY8Hfg+u9ypFpqlundqPgj+1fnYiS++BDKA5gHrFPebHSmf7BtP5?=
 =?us-ascii?Q?nbtBBkv2ZDRP7vXiKmHadoAKHyCklxyW72ubrrexse6t93Et3CIzUTfIGTuD?=
 =?us-ascii?Q?EhNYAIagM9YJzpEd+4m4ZwLKVmKkE2j9tkpWcrSDg/Hcxe1siUveibtDB9sk?=
 =?us-ascii?Q?abjf4KOuvklYUPtI8e/ppfkZWdDeg+TePSsWYkSux/vxRiE2JBgeof3Ihxa/?=
 =?us-ascii?Q?NY8GCDAs6+k5Ns1T+87VOLSnmcLzA9jCpy0r8mi+PjD1qYqG/A9sSfyDs6vS?=
 =?us-ascii?Q?eLO4TJnKxmToDpUAT/aVUB5VsPrWdu5jVnlFwfPje2NPdI/IGogtQihrLahF?=
 =?us-ascii?Q?heRj1/nGh/DolkJuhaMZRXVwPRlbKPNKGyyl18EjTuFJoAg4dmGbOGLBc9m9?=
 =?us-ascii?Q?PLS4pBBbep+BlEceY2AVHQlg0mropF05py07v+4m61YoOIT6ofR1L76Qvom2?=
 =?us-ascii?Q?aA0wfJGTAEBo0LUKJYZKHpHF8MZvruZCApf5/1MlFWSJgxTir2CFRL7kjc0x?=
 =?us-ascii?Q?sgL09wu2CHKVZzWMp6lMECwhtzwbPKTHhS4hKLi9n7zSUwfcwVaTSk1L2M5W?=
 =?us-ascii?Q?Kdm6VX0bmuxON0WV39Lqap3kgycjKqS+CaK55u6++uA1YnzjVTd7vMFFz05y?=
 =?us-ascii?Q?cfCNAKKmWFBW8oxsqioL0J38Gs5CR1sJXyJfM31P2mXDIjJKvqAZ436Ou2lT?=
 =?us-ascii?Q?+YJcyMSaaChG86R1g5MrNX7jrq4N41pf/aJnI0nJ/LTMVzmZtzC+N2HeVYzX?=
 =?us-ascii?Q?zS0WCmFADVjYOJE+8WLOYTAxssQQA7EEBbej5FZtoe/e5Hd9es/OwTaPlNag?=
 =?us-ascii?Q?6bP2J9oROM3p/7zmrv5cpK23fdU++D2uzVl/7iKoQn9sRd4a57DmqC13URy6?=
 =?us-ascii?Q?qd8FfYiu6cNyjrmqR7g00gMCKh/A/kPDTQpPF0EEzrcisrBVPn+HVK7iCG3J?=
 =?us-ascii?Q?KvvLUddChQY6HkT6XvUQMS1E4ndFgyFfwBqjArwZWZR8sy+BCY4kcL6q974U?=
 =?us-ascii?Q?h1RaCEeARMm7eH6L5WWryViThvKaQSPLqaXHD0Y+ItgQ0egCLJrkRYcq87j1?=
 =?us-ascii?Q?PaYyRFGxMxR/MlmRgfL99SDvbwy8vnE3/XT2H2w5hKcTsvnQcC4H/8jpfJZg?=
 =?us-ascii?Q?WmiI2EkR3zuD+FrZPTpRg4mE8cix24u8q47JtZfb49hyhtDYmlditni/CL4A?=
 =?us-ascii?Q?mvfIgYiBBUi9WI343R90bUg1DSviV3Fr0lEofQN0eZ/54NGMpSP1nU+qPX2O?=
 =?us-ascii?Q?bkn9ArXjUiAx3huRcDc8o2bnOkuza6NHKiVLT9HbWG/wCa5U3NLn/KyTBQYU?=
 =?us-ascii?Q?MOS3Hg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 10:34:33.0800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d77cd0-920e-4bbd-c3da-08de5d8fa91d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9828
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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

When the guest enables the Event Queue and a vIOMMU is present, allocate a
vEVENTQ object so that host-side events related to the vIOMMU can be
received and propagated back to the guest.

For cold-plugged devices using SMMUv3 acceleration, the vIOMMU is created
before the guest boots. In this case, the vEVENTQ is allocated when the
guest writes to SMMU_CR0 and sets EVENTQEN = 1.

If no cold-plugged device exists at boot (i.e. no vIOMMU initially), the
vEVENTQ is allocated when a vIOMMU is created, i.e. during the first
device hot-plug.

Event read and propagation will be added in a later patch.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 65 +++++++++++++++++++++++++++++++++++++++++--
 hw/arm/smmuv3-accel.h |  6 ++++
 hw/arm/smmuv3.c       |  4 +++
 3 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index f5cd4df336..e8028d4be5 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -390,6 +390,58 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
                    sizeof(Cmd), &entry_num, cmd, errp);
 }
 
+static void smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
+{
+    IOMMUFDVeventq *veventq = accel->veventq;
+
+    if (!veventq) {
+        return;
+    }
+    iommufd_backend_free_id(accel->viommu->iommufd, veventq->veventq_id);
+    g_free(veventq);
+    accel->veventq = NULL;
+}
+
+bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
+{
+    SMMUv3AccelState *accel = s->s_accel;
+    IOMMUFDVeventq *veventq;
+    uint32_t veventq_id;
+    uint32_t veventq_fd;
+
+    if (!accel->viommu) {
+        return true;
+    }
+
+    if (accel->veventq) {
+        return true;
+    }
+
+    /*
+     * Per Arm SMMUv3 specification (IHI0070 G.b, 6.3.26), the Event Queue
+     * is enabled only after its base and size registers are programmed.
+     * EVENTQEN is checked before allocating the vEVENTQ.
+     */
+    if (!smmuv3_eventq_enabled(s)) {
+        return true;
+    }
+
+    if (!iommufd_backend_alloc_veventq(accel->viommu->iommufd,
+                                       accel->viommu->viommu_id,
+                                       IOMMU_VEVENTQ_TYPE_ARM_SMMUV3,
+                                       1 << s->eventq.log2size, &veventq_id,
+                                       &veventq_fd, errp)) {
+        return false;
+    }
+
+    veventq = g_new(IOMMUFDVeventq, 1);
+    veventq->veventq_id = veventq_id;
+    veventq->veventq_fd = veventq_fd;
+    veventq->viommu = accel->viommu;
+    accel->veventq = veventq;
+    return true;
+}
+
 static bool
 smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                           Error **errp)
@@ -415,6 +467,7 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
     viommu->viommu_id = viommu_id;
     viommu->s2_hwpt_id = s2_hwpt_id;
     viommu->iommufd = idev->iommufd;
+    accel->viommu = viommu;
 
     /*
      * Pre-allocate HWPTs for S1 bypass and abort cases. These will be attached
@@ -434,14 +487,20 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
         goto free_abort_hwpt;
     }
 
+    /* Allocate a vEVENTQ if guest has enabled event queue */
+    if (!smmuv3_accel_alloc_veventq(s, errp)) {
+        goto free_bypass_hwpt;
+    }
+
     /* Attach a HWPT based on SMMUv3 GBPA.ABORT value */
     hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
     if (!host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp)) {
-        goto free_bypass_hwpt;
+        goto free_veventq;
     }
-    accel->viommu = viommu;
     return true;
 
+free_veventq:
+    smmuv3_accel_free_veventq(accel);
 free_bypass_hwpt:
     iommufd_backend_free_id(idev->iommufd, accel->bypass_hwpt_id);
 free_abort_hwpt:
@@ -449,6 +508,7 @@ free_abort_hwpt:
 free_viommu:
     iommufd_backend_free_id(idev->iommufd, viommu->viommu_id);
     g_free(viommu);
+    accel->viommu = NULL;
     return false;
 }
 
@@ -549,6 +609,7 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
     trace_smmuv3_accel_unset_iommu_device(devfn, idev->devid);
 
     if (QLIST_EMPTY(&accel->device_list)) {
+        smmuv3_accel_free_veventq(accel);
         iommufd_backend_free_id(accel->viommu->iommufd, accel->bypass_hwpt_id);
         iommufd_backend_free_id(accel->viommu->iommufd, accel->abort_hwpt_id);
         iommufd_backend_free_id(accel->viommu->iommufd,
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index a8a64802ec..92048bb674 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -22,6 +22,7 @@
  */
 typedef struct SMMUv3AccelState {
     IOMMUFDViommu *viommu;
+    IOMMUFDVeventq *veventq;
     uint32_t bypass_hwpt_id;
     uint32_t abort_hwpt_id;
     QLIST_HEAD(, SMMUv3AccelDevice) device_list;
@@ -50,6 +51,7 @@ bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp);
 bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
                                 Error **errp);
 void smmuv3_accel_idr_override(SMMUv3State *s);
+bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp);
 void smmuv3_accel_reset(SMMUv3State *s);
 #else
 static inline void smmuv3_accel_init(SMMUv3State *s)
@@ -80,6 +82,10 @@ smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
 static inline void smmuv3_accel_idr_override(SMMUv3State *s)
 {
 }
+bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
+{
+    return true;
+}
 static inline void smmuv3_accel_reset(SMMUv3State *s)
 {
 }
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index c08d58c579..210ac038fe 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1605,6 +1605,10 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         s->cr0ack = data & ~SMMU_CR0_RESERVED;
         /* in case the command queue has been enabled */
         smmuv3_cmdq_consume(s, &local_err);
+        /* Allocate vEVENTQ if EventQ is enabled and a vIOMMU is available */
+        if (local_err == NULL) {
+            smmuv3_accel_alloc_veventq(s, &local_err);
+        }
         break;
     case A_CR1:
         s->cr[1] = data;
-- 
2.43.0


