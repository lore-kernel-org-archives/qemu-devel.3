Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9867C79F89
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 18:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2YJi-0003b4-M0; Fri, 04 Sep 2026 14:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x2YJg-0003a2-Eq; Fri, 04 Sep 2026 14:07:08 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x2YJe-0001kI-U2; Fri, 04 Sep 2026 14:07:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=woDmjbDye/URxP4sAJoj29QK3F6fJeSXUblzwo10A3cPVJU8lFAi/QP166aeFyvMmiElVRQf5ZIr3FbpO1W09LUnYbh97v9akCqjUxac7E3lP7UcJjeNIvIgQJsAqwYbNnlYMEiB6G4E7I+eCixO+sIGglUqAUVUk99hvNSGY0P3eAH2TYJLBWr3DaFnUu4OZcSFHjS8ihT/vKr/VCCh//AzZxC6ojpGuQmL0qep2jmB1l9ROL98sX8Wd9rUs33yKu3SPnwHmaBMQsYumuYyzC1pEwXxEErPk2Ol8Rj8xSMctyXY/EOUtv8TlbWpnp39l9Wp1jt1h807Xi0FBb4fSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mr7yQ5pbi+LKWU/mdCej+/bvET4Be22onvrhzasP4xE=;
 b=NQJ7t7f0ThaIVQqijFlhbFy3B9PCL/lp2ABPD9u31YlPsOnY2yVPmisMn/OKWBPzYX8qKLHbRx9c7bWRSwT0fuhLq7ThnUYm6B8KjoZ0fFSTxLkfkGFGdLo1tvh1DSEmu27tMWFvPmdaa0MDTkjoTBNeQ3vw8kZpvhyF8z/aoCAhxUoWin59n3rIESzLf/Wx1bJuq1qNU2ZZxy/Nldwl/KKNk/7a+DOCJnBVXTjgQu+ffr0MoOK7u/BAR2yQXkzNQ70cZM6zVwfxnB93MYkKd/AKRn5/pv3vj4Ldti79g3kI1cxIiXZSXfipjTqt6eup0o4rWUQj/NbQ9IRK1d0Eog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mr7yQ5pbi+LKWU/mdCej+/bvET4Be22onvrhzasP4xE=;
 b=C1+a7k9/nx54xiL+12xS7uMSCfQXnRa1u61njy3UNfuI2s21HJxZnL8XLBhbxIGjbVydowc7v4a4pSP+6mdgp/bTn+SDBKwXVA6mey0EkK0JDLlH+PX5S7wnoSpVmyHArHZhLvsqH6czX/kpnQs4KTiknJ1n0WXPwm3tpRitRrI57XG/J6ogVK/JEtWkDQeOKKQcEg+wBIhnxMreLB9kN2hUDCFDPVizImgMvjtN2q4I6ht728oT6GAwOp4sStzfApERiCESf6ERHaHv7trafnVO5KgxzY1cOrs3Ri3aSaPU2vrmGRAVjIASnKRucP96hqH0jZn9KNlWBM2/HbTrmg==
Received: from CH2PR04CA0015.namprd04.prod.outlook.com (2603:10b6:610:52::25)
 by BL1PR12MB5779.namprd12.prod.outlook.com (2603:10b6:208:392::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Fri, 4 Sep 2026
 18:06:56 +0000
Received: from BN5PEPF0004698C.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::4b) by CH2PR04CA0015.outlook.office365.com
 (2603:10b6:610:52::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Fri, 4
 Sep 2026 18:06:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN5PEPF0004698C.mail.protection.outlook.com (10.167.245.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 18:06:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 11:06:27 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 11:06:24 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@ziepe.ca>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <skolothumtho@nvidia.com>
Subject: [RFC PATCH 2/7] hw/arm/smmuv3-accel: Drain the vEVENTQ when the VM
 stops
Date: Fri, 4 Sep 2026 19:05:08 +0100
Message-ID: <20260904180513.248396-3-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904180513.248396-1-skolothumtho@nvidia.com>
References: <20260904180513.248396-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698C:EE_|BL1PR12MB5779:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff6c5da-8c5c-47e0-0039-08df0aaf4e03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|10067099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 4xwJklEjLqkmewYuDWpaT9AQqidXSV6U9+TM6BhAUfSEdGiUdJ0LQPK34dkylHl3dIghpGlsZP8ioBn0nSSyhpVfukdvCErEGgrKiiH/jpQd5FDggFd6fpvh2VZjAADf14HFr18r2MkzzDJGi5ItMFYK57jYLusFpkpM/MIEVt7T/RDhmm69b2rrmdxm/osz5YRT7rpGoDjeii4WBXyir8M3BEHMVcFuRzpCwi6zz1A/nNSI0CyDw/0a/qIm3nQWfWFKakc6V48H5Sa69Bro2CsYfsgPVeVlDgnctBoLbXKI65wAa4lMk4XGUv4KLjHp6Bj9fPNXXUjsPcKr/6MeGS+uJjvky6bo1ciS8+1MKCSZM6fhjtESjcwles/8P80D8IYA0swbntNS59nlJhrIttdf68Lu+P0E8ZoqliuU/40fgcMAU4Udd4aHQ+fBZAWr27v2lczACk+yv7926iuQonD1MteDAk393iPW16Ru6VcIkAEGt+IcXS9c/pX8fmkGJv7XS7XXtR7dtzqCmW+uW4Gv11bC9e2oBB24lvVIA4NKFSRurE90WdXHnTLjc2bgcM4TkNKEJIXMAVjpmpz8QNLROXmbFa5ds77z6hUsg6EKzwboGLzYUcHWdYJVa/BSALZ8MbY0aQlL91I0xmrXy6wyH2/WGQBMHRz65wBSagtUEiKfczKjMgi/DDnYpPQeHT7obg+xNW2e5R5YvW4IGg==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6IbQbJaW49ceIbVPcCn2HzhmddWnT9SnILGjoP3ZivXn0cM3KRi3XqECPa0ZP6H1FzbEqphHh4/50xK3vTpf1J0Ki9QwPMDmkbyqpShi9eqU5eej9YQCDGCg/FA2UzkGkM+5I2Ve9rUKUn/rfc7dkOVdwz1095SeH9GXbXVYBRdIC6bBLc1edWHUO7bv7Rg6lFwo79vlk5sDmltYP8Xwf1yq1wdCV1xtIaN+C5GDBytio97ax6nSdclMlEf541Xn6oZg3UcoSaLH82wEoFS+G/OoBr7IXvYDLbMz4xr5Ec4e1W+mPesUCh8sDiStv8bYhrzusJYv3TREX2ixDySGskRoSft9Ibuy4npoyx1dzY4mIBqQANlnbxwU7t9yIwPSSaXVuJRmby5iv0MeDlHsczAVfv9Q6RGiII2H9EZNq+rQqzEcMkV1JThyDPsj8fHR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 18:06:55.2464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff6c5da-8c5c-47e0-0039-08df0aaf4e03
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN5PEPF0004698C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5779
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
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

Fault events sit in the kernel vEVENTQ until smmuv3_accel_event_read()
moves them into the emulated event queue. The vEVENTQ is an iommufd object
that is not migrated, so anything left in it when the source stops is lost.

Drain it from a VM state change handler, which runs before any state is
saved. Propagating an event writes the record into guest RAM and raises the
event queue interrupt, and both guest RAM and the GIC are saved before the
SMMUv3 device state. A pre_save hook would run after both, hence using
qemu_add_vm_change_state_handler().

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index fc503578f5..73509dbd8d 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -18,6 +18,7 @@
 
 #include "smmuv3-internal.h"
 #include "smmuv3-accel.h"
+#include "system/runstate.h"
 #include "system/system.h"
 #include "tegra241-cmdqv.h"
 
@@ -518,6 +519,37 @@ static void smmuv3_accel_event_read(void *opaque)
     }
 }
 
+/*
+ * Drain the kernel vEVENTQ into the guest event queue whenever the VM stops,
+ * so that a migration does not strand events in an object it does not carry.
+ * Propagating an event writes the record into guest RAM and raises the event
+ * queue interrupt, both of which are saved before the SMMUv3 device state, so
+ * a pre_save hook would be too late for either.
+ *
+ * VFIO registers at a higher priority and the stop path runs in descending
+ * priority, so the devices are already in STOP by the time this runs.
+ */
+static void smmuv3_accel_vm_state_change(void *opaque, bool running,
+                                         RunState state)
+{
+    SMMUv3State *s = opaque;
+    SMMUv3AccelState *accel = s->s_accel;
+    Error *local_err = NULL;
+    int ret;
+
+    if (running || !accel || !accel->veventq) {
+        return;
+    }
+
+    do {
+        ret = smmuv3_accel_event_read_one(s, &local_err);
+    } while (!ret);
+
+    if (ret < 0) {
+        warn_report_err(local_err);
+    }
+}
+
 static void smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
 {
     IOMMUFDVeventq *veventq = accel->veventq;
@@ -1146,5 +1178,8 @@ bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
         qemu_add_machine_init_done_notifier(&s->machine_done);
     }
 
+    /* For migartion of vEVENTQ pending events */
+    qemu_add_vm_change_state_handler(smmuv3_accel_vm_state_change, s);
+
     return true;
 }
-- 
2.43.0


