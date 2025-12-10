Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2C7D3C54A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTKQB-0007oz-HJ; Wed, 10 Dec 2025 08:40:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTKPq-0007cX-3d; Wed, 10 Dec 2025 08:39:38 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTKPn-0001SI-Vb; Wed, 10 Dec 2025 08:39:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F43+jdAue1rn6jtiKImhxL8L35qWriDdz9a+X1JOFZulrg5lMgS3VrrXmhdVVjuGie485Lvzf/tcYPZpjf9i6/e374NbWkqZLIqarci+z0wUnUMngR5S4b4PSJ809oNtY7IKDEeSKjnB1JZXPHuC+RlpBEZG5AhxgKImiU27rRbcahrZS8Hw39EWrqdG8oK7v08ffxoqTkmt6nke1fJBCNXfLiz/yt1w9a34Wk6/5z6FPehz6JnZRKd5D85QMtg2ySWHrRMHOQVR/wXhT9PUyo6v9hZGe3HY8BA6XZSqD31orL0MnR0AQcej3+r/OHjRaPR0w9enbEGrk4GrnCtnVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TybDKc9IbYuymdCdNUTbM4eSP4dUqUf/vNRspvui12Y=;
 b=IEg0/X8jbCqxodGw0L4UwNXXvG69IAhCiXArFBvBiS1ByLV1MDgbtsXcjNmS2FSRrg3H4P4ooGgLWsvCUIlZUMwXzAsGrdbLuEcJBTHwSBrUxWh0SMaR3LWIgVLnV1qP9edJDPbW4cl2x0SJM3ajdhql/bp7Etj0NBVdLR1lPKDTKDwk1V/FX+si4f9L6FxdzkaK9afzY5uzlp81CLx2zcA8EzUpnZyCBJcAIyFk8MbAP9BMFZV+/ztDg5zJpjl0OjaCO3XvSyXAO1IJqn/J9Q0/y2Jio3CH6djAOwVKXrE/QUu0LFnF5t3vKGeKM+mehvvNjvBasWNtGfvBkBNFhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TybDKc9IbYuymdCdNUTbM4eSP4dUqUf/vNRspvui12Y=;
 b=gUt4D+xAFeT1RRCDwtuxhD1py/fuSZ3z79NWu72UPJ/Z+0ByEcgowyTcPieifn27J0tW9GiQP8GrIiW89Fj8Slo3tQxzbk6RrQlTyRI3uezMgpMaF6u+36ZcSOidugZJr3SKW06bHLvz8y0kyC2+ebzNT0oPAldt/2zzcOoMQxDeMt9fjzokKkhPJvryIKiFeysT4xvyDE9+HdIGiKTpN1xPFX1bK7185tcPFGbC4N/fT1WR90RsQ9WQFL+wPtGnTecpF/SNvmhBMDjONQ5oo+VsCbavu49sng0+h3iIBbI3lEn2WulZWxjcUrFcTXBgu+HgCWKP9OtEzNQo628ezw==
Received: from BY5PR20CA0009.namprd20.prod.outlook.com (2603:10b6:a03:1f4::22)
 by DM4PR12MB5820.namprd12.prod.outlook.com (2603:10b6:8:64::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.6; Wed, 10 Dec 2025 13:39:28 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::5a) by BY5PR20CA0009.outlook.office365.com
 (2603:10b6:a03:1f4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Wed,
 10 Dec 2025 13:39:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 13:39:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:39:06 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:39:03 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: [RFC PATCH 13/16] hw/arm/tegra241-cmdqv: Limit queue size based on
 backend page size
Date: Wed, 10 Dec 2025 13:37:34 +0000
Message-ID: <20251210133737.78257-14-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251210133737.78257-1-skolothumtho@nvidia.com>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|DM4PR12MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aff3870-bb35-402b-bc43-08de37f18a05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QW5MK2NaeGN2RmRGSTM1bTkxZGRtTkhYQUxJSmZpcEtKYUdjb3I5VEc5ZC9D?=
 =?utf-8?B?MGhBOWtxTFlxcURHQ2ZRTHlUdytqQUt2ZkQrRWFta1I3SmZYWWRoS0JpZVFq?=
 =?utf-8?B?eHdBSW5HTjA3TXpsNU5yQytMb2tmUDhhS0xVK0YxVS9rUzVTaHpQeGM0Yy9O?=
 =?utf-8?B?WkFrSytyK3JOUUU5NitjeGEvcjB1SE1pTmhJRzVnV1NOVlg5NGhTUEVSa2dY?=
 =?utf-8?B?MmhmbzB3YVlhK01VVUxjTGtFZ0czUy81QngvdU9OK3Vuby80T1dOR09PTHAr?=
 =?utf-8?B?Uk9lSHh3SndRY2ZHNm5raGRXTk1rMGV2bnk5QlkrV0lwQVB1SzBDdXBxakFs?=
 =?utf-8?B?TnFmUi9DT0JVYjlzWnBHZjg4M0VuMHBhNGtEZWsyMm1UaVJ3bkwxMmhaQUtF?=
 =?utf-8?B?SmczRUFkOVpXU1BERnZuZDBVY29kNjR5WjdnU1pRL2pCclNycVcxSXg5djlM?=
 =?utf-8?B?dE4xZExqVG5vZ0dlT20ycmZ5QlMvTmRtK0pKN3pHeXovMkViQjE2NG1HSTBY?=
 =?utf-8?B?aTZyVmVneWJnMi90dkJXb1JXbjVuYUNvOVV0bWF4RzAvS0NJY2p2OUFsdmFq?=
 =?utf-8?B?TVNBNUFMYmUySW51MFIzN2N4d1hXd3JRM2ZKbnkvZi9YWE5XdmxIOWNqWFhl?=
 =?utf-8?B?SVgvK3VtRVdNTzR2T0dqSnpqTTNXb0ErZldhdHVlNjZZZUtxWklZMEI3Wm9n?=
 =?utf-8?B?OGRtN3ZjKzlLQ1plaE15amFwSm1IdnNKdHNJZUx3SW51VU1sT1RrMnF0bFJX?=
 =?utf-8?B?dE1IWmVFMVZzK05oQTh0UEUrK2pTY2ZHTytSOWdIN1cvbmRZSW1vbEp4M3RK?=
 =?utf-8?B?QjFsQ1JzaytIcGlHbFBhUmZuTTBGek54RU1STzdWYmZJZDJQQ2gxYnZTdldI?=
 =?utf-8?B?SUNHeU1JR3E4MjZ5WmgxTStZSlpRaEZmYVI2ZG83b0lNb2dvZVI1anA4V3FL?=
 =?utf-8?B?STlmQ3FzaTBOL0NYbTBLWldUOEE4eFhzR3lZL0VjaXdzODNaTEhZc0dJR2tC?=
 =?utf-8?B?UnlYaGY1aXJjVnRNbnZPUVg2cVp6VDV4UHBvdjE0b1BZME1xZDJDN3NxZnls?=
 =?utf-8?B?YW1nZGpJL0JWRjVWQWpCTjgrR2ZraThHUEZCeEhlR3BxQmRHbmdaWW1ITVZh?=
 =?utf-8?B?b1B6dkluMzZJWW56NDhtcm92cDc5QmtNRmhkQk9vNnlUVkpmV0VCWE5hTEVq?=
 =?utf-8?B?Z1JZZE00UVlWSXYvUlJBejRVRTZCaDUxdExRVWRjbUFnWnc0WDgzTUlZVGVV?=
 =?utf-8?B?eGFVMW0rRHl6cFN0OHhLZFVVcENhNFM2NjNIS1VTT205bGhZWGZRRm1vanl5?=
 =?utf-8?B?ekc0U2hidjV6L2sxeTFXV1U0R254aUhQRnFLcUp6d3FpQkxOcURHWVoxV0pk?=
 =?utf-8?B?cU16VC90SkZJSTZ6amhha2xDeHlFaEpFekRSN2dmNUtzczhwalVWMmJoQStQ?=
 =?utf-8?B?LzBnL0crbW9PV1BtSTlLY3g1eVFaNm5aVDRWS3RhN0RjRWJjRHh1ZFhVbkJo?=
 =?utf-8?B?N2t2NkNiYVVCYXpOQUhNNWVuOVMzVTVheGJvb0ZWeFJXVk5lRHpnejJ4Z08v?=
 =?utf-8?B?K3ZFVGd5TXZXS1RBenRiZzkxRUdSVTlyRzk0TjBnYmh5S2FGSmhTdzV1MW9x?=
 =?utf-8?B?cm9OaXJhUnAza254SkJ4NzNENXRENlA5dlJ1TWFDMjF3a3NMa3Jiek5wUGkr?=
 =?utf-8?B?elJ0TnA4TS9lR2h4R2QySlQvSkVPWERnaXNTSlBNWkpYMG9rdEpBRTUxNitL?=
 =?utf-8?B?UGNNbXNLc3NESE1zNW5xaG1YdUI4TXpJY0NCSXdIMDdsOE1EMEZoTEx2UUwy?=
 =?utf-8?B?OXYrcWhyV1ZSZ0g5Rk8xYWhlR3BzT1ZITmpmNDNSNnEzQlp0bzI5OSt0dTh2?=
 =?utf-8?B?SGRYb3FNUW5SbkJGd0laRlhGTlp1aDlSeUo1Q1RMM05tc0tlSURJMVFYeXY4?=
 =?utf-8?B?YUVXbjRJendpT25PZkYvditBRHdxcGtPNjgrNy9mdUdocVRpRmhEYnZpTGpJ?=
 =?utf-8?B?LzF3VGhuSG5VQktCM1dreHk2bWNDL3hPVVhJb0FLWk5rQThzWFRpMVh0QjEw?=
 =?utf-8?B?a215UHlMYUM5Yk5xRU92dk4rcjQrcGVMSk1ad1l0dkNVY3Z6YWo5Tm55bjEr?=
 =?utf-8?Q?PUjU=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 13:39:27.3912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aff3870-bb35-402b-bc43-08de37f18a05
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5820
Received-SPF: softfail client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Nicolin Chen <nicolinc@nvidia.com>

CMDQV HW reads guest queue memory in its host physical address setup via
IOMUUFD. This requires the guest queue memory isn't only contiguous in
guest PA space but also in host PA space. With Tegra241 CMDQV enabled, we
must only advertise a CMDQV size that the host can safely back with
physically contiguous memory. Allowing a CMDQV larger than the host page
size could cause the hardware to DMA across page boundaries leading to
faults.

Limit IDR1.CMDQS so the guest cannot configure a CMDQV that exceeds the
host’s contiguous backing.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 43 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 1f62b7627a..1996d899a1 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -11,10 +11,14 @@
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "trace.h"
+#include <math.h>
 
 #include "hw/arm/smmuv3.h"
 #include "hw/irq.h"
 #include "smmuv3-accel.h"
+#include "smmuv3-internal.h"
+#include "system/ramblock.h"
+#include "exec/ramlist.h"
 #include "tegra241-cmdqv.h"
 
 static bool tegra241_cmdqv_init_vcmdq_page0(Tegra241CMDQV *cmdqv, Error **errp)
@@ -592,6 +596,33 @@ bool tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
     return true;
 }
 
+static size_t tegra241_cmdqv_min_ram_pagesize(void)
+{
+    RAMBlock *rb;
+    size_t pg, min_pg = SIZE_MAX;
+
+    RAMBLOCK_FOREACH(rb) {
+        MemoryRegion *mr = rb->mr;
+
+        /* Only consider real RAM regions */
+        if (!mr || !memory_region_is_ram(mr)) {
+            continue;
+        }
+
+        /* Skip RAM regions that are not backed by a memory-backend */
+        if (!object_dynamic_cast(mr->owner, TYPE_MEMORY_BACKEND)) {
+            continue;
+        }
+
+        pg = qemu_ram_pagesize(rb);
+        if (pg && pg < min_pg) {
+            min_pg = pg;
+        }
+    }
+
+    return (min_pg == SIZE_MAX) ? qemu_real_host_page_size() : min_pg;
+}
+
 static void tegra241_cmdqv_init_regs(SMMUv3State *s, Tegra241CMDQV *cmdqv)
 {
     SMMUv3AccelState *s_accel = s->s_accel;
@@ -599,7 +630,9 @@ static void tegra241_cmdqv_init_regs(SMMUv3State *s, Tegra241CMDQV *cmdqv)
     struct iommu_hw_info_tegra241_cmdqv cmdqv_info;
     SMMUv3AccelDevice *accel_dev;
     Error *local_err = NULL;
+    size_t pgsize;
     uint64_t caps;
+    uint32_t val;
     int i;
 
     if (QLIST_EMPTY(&s_accel->device_list)) {
@@ -670,6 +703,16 @@ static void tegra241_cmdqv_init_regs(SMMUv3State *s, Tegra241CMDQV *cmdqv)
         cmdqv->vcmdq_base[i] = 0;
         cmdqv->vcmdq_cons_indx_base[i] = 0;
     }
+
+    /*
+     * CMDQ must not cross a physical RAM backend page. Adjust CMDQS so the
+     * queue fits entirely within the smallest backend page size.
+     * FIXME: Migration support requires this to be taken care.
+     */
+    pgsize = tegra241_cmdqv_min_ram_pagesize();
+    val = FIELD_EX32(s->idr[1], IDR1, CMDQS);
+    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, CMDQS, MIN(log2(pgsize) - 4, val));
+
     return;
 
 out_err:
-- 
2.43.0


