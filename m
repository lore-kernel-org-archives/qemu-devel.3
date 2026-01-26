Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7B1CF65D5
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkK80-0002gx-T6; Mon, 26 Jan 2026 05:47:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK7e-0001IW-9w; Mon, 26 Jan 2026 05:47:11 -0500
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK7b-0005jY-2S; Mon, 26 Jan 2026 05:47:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHwPTr/2LvTHjrtNuI1IUtwJHk7j4EXbVj7iapsmdH1WmR7S5SV985auZScn6JBFdqj7KTQ2vdRd4LdInSJxNuvA9eWfK/I5LMzSzMxDdubNjr0cTjaj06A3dXCtQ1+RG03hp9Jtyb5/xHm9Jea5P04EmgTvOSNq4k0ld4nDSPzHPdAseK6duJ3j5YJO0TuAp18VEtNgMEv9ll+WiJnlojx9cThW0ux/rZTho0dLZ/TYecY+av2iwJ8z3jSGBFNnJsR3+e4g4WMI0XwxNm8XtEgGi9YUx3RTTUxCjxTN6BMoRluKxVl8E3BVlgzax+TTP7uCQC10Lxwbq88VnuOMBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uvEMLfnPpjfI4pRy/79USmx/OL3kyxZUOgMXAAK7Bg=;
 b=WlHk779jAKkjGNRxd9PqJcPU9TuVFRyQS3zCi1TShR0M6JWf7snKyzBk1o3yJkOaw5QFKn53KGYaLLJy6Dsp0KCo61DEErkaAjoPJ/IVpq/5CYRJEGSH/EsbFndGiIbebFgydEgyREFIBMA42iNfNDgKDgzggOrYpFKJzLUVbYzZt2SvhW0t1t54NO7wD9fJR/xE7+nYwqSZK2hBGUD+VrmHeOjfV/Dcs0aif0EDpmGEkCm7NQgV6T2ycw7O3y3e37bsU3yBiFskepZjtlsomU7YHLBWWH4PqkrSRw5Ze/PLOv0FgXWYsgLgnfuun7MLkEY3hnVaHatOdKDpBB3kEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uvEMLfnPpjfI4pRy/79USmx/OL3kyxZUOgMXAAK7Bg=;
 b=gHD5a2MNQyrE7Y2plU1PRYerUxbGK0S7MEPBdsThyLe2cHQf/RgY8cz9X+g32WTp0g/qLwKZbbq5HWLvAlLSWp3v/7lhFcAINDag4qwipASgGRA9pkoaSGudmKerDiggKxH3zOiDXojWcBWc6A6lYelxLCOyFzZJzLwGbS3D5REAq6CsfmHiWQaMqEyfLacIewoHm2LbpfcmfC2GasAeC4vWdVDV5GdWTTCC/1H3oroXw9207P9pFzuqTD8RCHEbN/u75hpzEnbLdq3X3KVyt7YKKWTW10nZz73nVhXg6BFqxFlurKXlnhr6jFo4UExmTJ4Z4gxA4IxFQHyERC4ueQ==
Received: from SN7PR04CA0029.namprd04.prod.outlook.com (2603:10b6:806:f2::34)
 by SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 10:46:55 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:806:f2:cafe::ca) by SN7PR04CA0029.outlook.office365.com
 (2603:10b6:806:f2::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Mon,
 26 Jan 2026 10:46:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 10:46:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:46:45 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:46:40 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v9 27/37] hw/arm/smmuv3: Block migration when accel is enabled
Date: Mon, 26 Jan 2026 10:43:24 +0000
Message-ID: <20260126104342.253965-28-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126104342.253965-1-skolothumtho@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|SJ1PR12MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cc80387-4f10-417d-627b-08de5cc83933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|7416014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QwfSggm9CZTihyaH7OoZtekLR9ZnfLcIh+8Wm7VzNRyABDWWg1StPWUnCW45?=
 =?us-ascii?Q?kIiJObiUlc7+jjg7+U52WIW8NHUl2qjJiPtBMjt5YaGTyO2weeNmY1tUlcnA?=
 =?us-ascii?Q?rousGMp91qQBxvr0dVB0aNpDWGuMYcK6JOf3dgD1283QzVjRUU87Vp1hWfjZ?=
 =?us-ascii?Q?DPR8wiRvvBKyE6X3zS5ijFReYqwNM7ijNgZtHIFMqxTg0LTsvaceKzCYSp1V?=
 =?us-ascii?Q?TImBie0mMcrAFRPjtuz3dl1Ly9XsbICjKFwCMBp9V+XtCuq7AyECx8z/PYcm?=
 =?us-ascii?Q?M2Nprk9SS0HeboS+vQX+VLDyJXEEpL8adAfEx466ZgV91PIwjQWDcZu5pWY+?=
 =?us-ascii?Q?H0KJcwEFUiFMYN/FQJSYeXaEp6eg1kNjb8C8pptZDzmo63SkOskixyvhupaZ?=
 =?us-ascii?Q?28ruD58nVCUEKYCYkJvgBg/fvt68GXpwMQLw5YfGWcPDAf7vbuf2heWVpjyY?=
 =?us-ascii?Q?+0Xn35E0pXmKbIcqdpj38LL+a8hPxY4tPG5swmzhkdSR2jsQW4SF9THw30EF?=
 =?us-ascii?Q?RXZfjf5ZgdHVIxGl9xg2KpKtu6Rlxoh+4OFp/NpNF86PF+O5AvNM2bYHyseA?=
 =?us-ascii?Q?eGXnm81OxVRNNa8RTWffEm+P5sUc6OYflh9+vGH4TySKv39HPidMDGw8iszy?=
 =?us-ascii?Q?vel393m6iH582vdaP8R5h+6ANUGcGevVoVMbwPBKWNf8UXQx34yKVcAv0aTU?=
 =?us-ascii?Q?ayIx2YJUnPjUAE+scc+18B5riUi8aCJ/a6fYuxJurvosjaAFmu1BvWn11DLY?=
 =?us-ascii?Q?u0kpG3AfZo9ELtlqpJuJQZgnBnbwlOT53lbvxrkrj+fT1NZgkBIOvYohRh44?=
 =?us-ascii?Q?quMndRKxHEXivtGLVWHLOca8CWfVyK5rv/GjFwAJUiBTI3Dt9/0cb3KSV05n?=
 =?us-ascii?Q?YbmEUqLocirUi3h5lYLxKIlQKdJI1fGP7ffPr6uF7ECWuYhiG550eFR7rPFv?=
 =?us-ascii?Q?OqVIt3BYN+OMc06KjxXUm8EVDrpBLqEYwCNDvQUC5Nt4NE84Thyo+yKp2jWn?=
 =?us-ascii?Q?FeqVgxa2CAJspMwc1AcxYuSVSyiVQ24tZL9hd7DVV7RANFUCCwVVplfcDH26?=
 =?us-ascii?Q?Z56m3d50kF0CkvEVghSglfytriZq+Z80smknGcB+l91YwgJXzRnX3epaVFlC?=
 =?us-ascii?Q?F+PsiG5fnTGe5MR/0ApA3Qtxqy8HjtoIW9PqQwuPO8hpFRtgzDEBR/QPEYMN?=
 =?us-ascii?Q?WKkM2PMs4CaEuVek1mE35+n6jsUO1rok7WTGElvEYtBrMV0U9DAPbvEbNXed?=
 =?us-ascii?Q?EmGMIl4rYB0oFs8XkG968BTmYJRovXXuS6yI9nixS0P4WVNK0aeLbt/GB50L?=
 =?us-ascii?Q?o1I8z02HsB7pdGdzadyxIFAG3Pvs1ai5Ur9GBZ5v98cvj02jwoJecmpRwD2N?=
 =?us-ascii?Q?VeYNdpDDOZ/HyIEnvzuNAimicBi/TAX61ZQaIMn6aOX07Zw++jRhlOtqBvmp?=
 =?us-ascii?Q?3tg5w+UPIo2j8SeD8fmfE4Dw1pApOWkuvtOlIE/gH6LpUBCMoqfLDojmuN5E?=
 =?us-ascii?Q?aofXUbDXWFgNSf5YwRk6u3dBkTHXoJrBE0rR+8Z5yYgBAhVyFYfDqL5w6E8k?=
 =?us-ascii?Q?MmlxMtIg1Zx6/nheKtLkI/XRf11pm9MC4TJFhS7IttjVMVCyTdNVrVQUR9F0?=
 =?us-ascii?Q?rECblJMl9HKPueO7aVk6J1nbZsK/T/stqFqnLBcYxtvVacDbpKjW9FrT8f3C?=
 =?us-ascii?Q?dVbcYA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:46:55.4628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc80387-4f10-417d-627b-08de5cc83933
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6121
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.587, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Live migration is not supported when the SMMUv3 accelerator mode is
enabled. Add a migration blocker to prevent migration in this
configuration.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3.c         | 6 ++++++
 include/hw/arm/smmuv3.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index e301bb467d..2be056d792 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -20,6 +20,7 @@
 #include "qemu/bitops.h"
 #include "hw/core/irq.h"
 #include "hw/core/sysbus.h"
+#include "migration/blocker.h"
 #include "migration/vmstate.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev.h"
@@ -1925,6 +1926,11 @@ static void smmu_realize(DeviceState *d, Error **errp)
 
     if (s->accel) {
         smmuv3_accel_init(s);
+        error_setg(&s->migration_blocker, "Migration not supported with SMMUv3 "
+                   "accelerator mode enabled");
+        if (migrate_add_blocker(&s->migration_blocker, errp) < 0) {
+            return;
+        }
     }
 
     c->parent_realize(d, &local_err);
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 5616a8a2be..9c39acd5ca 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -68,6 +68,7 @@ struct SMMUv3State {
     bool accel;
     struct SMMUv3AccelState *s_accel;
     uint64_t msi_gpa;
+    Error *migration_blocker;
 };
 
 typedef enum {
-- 
2.43.0


