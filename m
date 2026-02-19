Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5454FE9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 09:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vszvX-000576-QH; Thu, 19 Feb 2026 04:02:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vszvA-00050L-Ty; Thu, 19 Feb 2026 04:02:05 -0500
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vszv8-0002Q9-Uz; Thu, 19 Feb 2026 04:02:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=joviZNqeZ13JzNeIZHEK5ECTNqwORfbTqlLW7dI51hpzKUoT7+VSIVvzpFc3M3BcCGqdHI+98P9oweSCosanJdFTaeR1vbngOKmEFquUh53W8HRkNY05nYO+CtT5i0s9AT3092fUwHUNmwEcr0KNm+M58h6/kaua5stwMXrtCTK+aR00FKNKlSGXt9Bvnb2HDC+icZ/884OLMXnjWgribjnAqK/mYOLbOelRBjGqNcb0Gn3GoIMne1jx8iEqCcYbrvTTftXBGROLriMAf2vLuB150KCTUO7Bz1NcZwuYvADhzNd1rn1jQKH97aIq1p0EvBXgKiXfsA8qidCJhQVv/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHankhQhgy64XL3EfEYVVmLt4bL12B3NLTDmlBMP8is=;
 b=gG/Day9okmjx8ki6dDE8AN8RPVRn/wJvJnfYcNdfNYHPso0bOjMX1STg+5QxnN3D7NjmobVWth2uDDG6CtIU7//CKlwLJZBBokUk0OsFNntd2tH8nekMHNDnXSXu/EOSvC5bWm/j4AYV/PGk3LkXrCXJv8JSTUmBRX+nxvDq+xFkQm7onRyzLM2Z3aK30dODSXW0Iq2Rj5t1HPFMUgq9AR0G3DDJjEjR06U78vZsMqQzjYXRQv5YGMOx6qucUYSqdJuw6234wp0dwKp9nunyY/2DwmzQo93qEOWFWWu7DYSmIZyBUl67HxTRWQkYEM/XVzA0osUO+tq+T2wr7dOeSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHankhQhgy64XL3EfEYVVmLt4bL12B3NLTDmlBMP8is=;
 b=FDb8N6vOQgxqxteSIiRu+L0nBGeb0QgYLuH2OxdomA4KiQsPZRkOf+aMrc+S1aHMg/FgoHt2xMj+/vv+1cuI1yjP6M72zlfshv3mlkWsqkF09MdCCGADpSF39uN2r8S+AhCKZy6sOlYZDawwL5ba5xQvw4A6RQHoiuM6sYrqmesq5lOt7DBuFtOUwnFpRFUHTx0DXgPvzpDDTlOp7UANTrdj1i/c9ldWBFNfOFdzy3tiU6MlPpvGf4FnNuxNAWVtVPD6tEHtYa1/irF8BHAlKS8mSN7+EZvwFfXP1WA/aKkJRrL/YbcC5GX0Ma6aQSk3P+1Lle26yXITTL/hHAZK9Q==
Received: from SJ0PR03CA0022.namprd03.prod.outlook.com (2603:10b6:a03:33a::27)
 by SJ0PR12MB5663.namprd12.prod.outlook.com (2603:10b6:a03:42a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Thu, 19 Feb
 2026 09:01:56 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::23) by SJ0PR03CA0022.outlook.office365.com
 (2603:10b6:a03:33a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 09:01:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 09:01:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 01:01:43 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 01:01:40 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@nvidia.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 4/5] hw/arm/smmuv3: Introduce a helper function for event
 propagation
Date: Thu, 19 Feb 2026 09:01:02 +0000
Message-ID: <20260219090103.33697-5-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219090103.33697-1-skolothumtho@nvidia.com>
References: <20260219090103.33697-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|SJ0PR12MB5663:EE_
X-MS-Office365-Filtering-Correlation-Id: 11e05fde-2d5c-4255-a8af-08de6f95884c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J6fV0R+6iNuV8eTy9hDXc8E33Xw2sEXoQgtwjLsqJ1NdPtEEVjEMAWAJBMTq?=
 =?us-ascii?Q?RxPvHZEWL1IvuNjUoJdJEVJdTzwq2dNbJtTn498JBVLQ1ZE/sOpydxSD54zR?=
 =?us-ascii?Q?uYSDABxwZUL8A8Pj4tfgzQwHd/bPw1XXVYp5UVxg6XyHUZKvktIbJZy+bHqA?=
 =?us-ascii?Q?qyRkcMCIi0fWWXXVJ7Nc6mW8E2GxVsB+tn+ZDPCoW8Qy1iJap0gL05PL+kJT?=
 =?us-ascii?Q?9PzN/20ayiQmaG6yG2dopyVijB1t2Zg8p8/+8jwIOExxHycrkn6cQDd5A94B?=
 =?us-ascii?Q?KB+TV2U8J/D+q5dO7oBy2oehW20TUYnCnNQvvpH8wv+WyyobENG9qsI5NIAy?=
 =?us-ascii?Q?Ao2I0c5akE9hf05IMr56mXl4p4cqzUUS8eC87ALVX+Zr4GJBLzIFxbdNmnvp?=
 =?us-ascii?Q?B73J2XnWxxqNt2hyOYsImm8xW2ZeuhdbGbzBGGo5cFtTgtgBW4RGqXqUB30/?=
 =?us-ascii?Q?llD59THyqW5onMWe4CTXElVF+124SvNCCpKw3T07qcUzg1a2TUVnFiqLgmCj?=
 =?us-ascii?Q?TlqcyaHPl8R1K2A5hotxezcntMwiooKfh41jju6PM2Ejy4AgP8AxFRSmHD21?=
 =?us-ascii?Q?hX1+rQ0NXCp0Rs2x4b+/0k0Yi9cRM3gIYL8DJoxyRYuHnaKj8iBGdntP6RkV?=
 =?us-ascii?Q?pKQeknrjOHTW3VB9bmxt4FZKrzQwKEmUT2no1eAh0BCpDZRoycb0izzgsQay?=
 =?us-ascii?Q?s8HLvLBPXK/h2OjyJms16+nmIpqORMalBHuQHCDMhaTgIfvQobP651lMo+KM?=
 =?us-ascii?Q?cCODDY4+tFKdABGSOL8/vManhyj+coKOWDX6JtxJ0bLBXx/hrw2yjhCO3s/Z?=
 =?us-ascii?Q?HhHmjXYa8fnOHl61d0u7cEGvllBWGFAlWBe3VFZVsVtq1Jp2qUgbO5XrBRf3?=
 =?us-ascii?Q?v2yWv5op0vh/AMNCyOtlVdD8tNv4rgzKKF/anmV/W2LwnmuCV2F7hpz91dB1?=
 =?us-ascii?Q?qHMarYDpQLV3YB72VWaxZ0UwnPDVZxzCGvoEAaUKbqd3ycm+2IwtPm5xMqpP?=
 =?us-ascii?Q?gTCoqWIsyNx0G2EvHcHEN9TxeGLjj76BUvit7AgYm6eIS6lgYnxC052OKZqR?=
 =?us-ascii?Q?g6q4pyy1qjsGpOaauVB5CG0tq356LhW2Dmpfo0OGsaaWNNmhSs7xpLjo4sAQ?=
 =?us-ascii?Q?OQGZZNWwp8TaPg5ZKLKJt6OgnXexWuUla4XYPx9KczTu5YHcY1no1zKOUvw2?=
 =?us-ascii?Q?K9/TJlqwWpU0nKKF7i2MxaLyC7omeBzoMnPq2EvZFIgnmYAFd8JGG158fO3o?=
 =?us-ascii?Q?8x40azakm0XoiKeTnlvXQXjbefnF5SJyTBKZnWy7Q/uPU1y8hlVHJc6h1Iay?=
 =?us-ascii?Q?Fu3s3fpUUNEkSSho4mzVeryMpUJ+wf1E8w4vADWed20k8LJZ6W/lpXWI3vVS?=
 =?us-ascii?Q?O4u/A4rh29jCf2SX58SHy5YAK8uvntHeCXALjA2SVxkh05pKHlQ/nPb+VO8N?=
 =?us-ascii?Q?O1J79MkQmjMlq/Kg5AEqkdN5I71l9SZQ4W2BedJGoLpZP2SqG+4Clv164Ofr?=
 =?us-ascii?Q?KRbfTIjJvvoV7ehJDixfbrl0YpnFG/AZ0Oe9J8ISAqyVUUCr8vV+RlMZ3PAQ?=
 =?us-ascii?Q?q3kazwnENqL2ceaIW2xEltyPqugBqrRkN2wCOhrs2alurfoR52jrpric+U4U?=
 =?us-ascii?Q?rf4ISlwGMwRU6XZoeoLv4ygrHq1PDhQZc77mjFN+cnRvlXPpbf10m6DfJ/Pp?=
 =?us-ascii?Q?wjDuvg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /ykhRiguPKcl9qTFFyZQNfB2y6hyHrCm+6U8qbAicNH7wFD8kNuAl/+tzcI+3vaMeUNouc1aigBG/hZxerM9K2Ppw3G+VnVC/uByalk5l07gyRJMJPrX2zgqRmdq8aGzuXF6C4uVGnZ86CXWLQ1+C9slLPtnyQEjQqxA7NdA6eTp4UCL9E0du23pBsD7Vg2fNNspB7rXRQQC78P9Dfr1MS1llDhTzjCAMJYLnKIhJQq5eUAn0M4vpiIkCY8hcGwj3yADC4F5x48QVpBSVxmyTj0JLsYcn0E6ujSId9fFHSAqNfM1xlRjClcDTXkcBosJAM+E/NXjT6KMuU6rkvSgSauwY1WVIPzvysNkR3I0AVtNZv9CumLe6It4aYbHmxDepOv5I/w9IHQAe/pM5o/D3z8vg1XDsWpQAguTyHnoxv19AdVhQ7OsHjFEIE+vwuBJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 09:01:55.9916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e05fde-2d5c-4255-a8af-08de6f95884c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5663
Received-SPF: softfail client-ip=2a01:111:f403:c000::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
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

Factor out the code that propagates event records to the guest into a
helper function. The accelerated SMMUv3 path can use this to propagate
host events in a subsequent patch.

Take the mutex inside the helper before accessing the Event Queue.
Today event propagation occurs only in the core SMMUv3 path and is
effectively serialized. A subsequent patch will also invoke this helper
from the accelerated event read path, which may run concurrently.
Therefore serialization is required here.

No functional change intended.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-internal.h |  4 ++++
 hw/arm/smmuv3.c          | 20 ++++++++++++++------
 hw/arm/trace-events      |  2 +-
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index a6464425ec..b666109ad9 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -352,7 +352,11 @@ typedef struct SMMUEventInfo {
             (x)->word[6] = (uint32_t)(addr & 0xffffffff); \
     } while (0)
 
+#define EVT_GET_TYPE(x)  extract32((x)->word[0], 0, 8)
+#define EVT_GET_SID(x)   ((x)->word[1])
+
 void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *event);
+void smmuv3_propagate_event(SMMUv3State *s, Evt *evt);
 int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event);
 
 static inline int oas2bits(int oas_field)
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 5d718da764..af7a54143f 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -168,10 +168,22 @@ static MemTxResult smmuv3_write_eventq(SMMUv3State *s, Evt *evt)
     return MEMTX_OK;
 }
 
+void smmuv3_propagate_event(SMMUv3State *s, Evt *evt)
+{
+    MemTxResult r;
+
+    trace_smmuv3_propagate_event(smmu_event_string(EVT_GET_TYPE(evt)),
+                                 EVT_GET_SID(evt));
+    QEMU_LOCK_GUARD(&s->mutex);
+    r = smmuv3_write_eventq(s, evt);
+    if (r != MEMTX_OK) {
+        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_EVENTQ_ABT_ERR_MASK);
+    }
+}
+
 void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
 {
     Evt evt = {};
-    MemTxResult r;
 
     if (!smmuv3_eventq_enabled(s)) {
         return;
@@ -251,11 +263,7 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
         g_assert_not_reached();
     }
 
-    trace_smmuv3_record_event(smmu_event_string(info->type), info->sid);
-    r = smmuv3_write_eventq(s, &evt);
-    if (r != MEMTX_OK) {
-        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_EVENTQ_ABT_ERR_MASK);
-    }
+    smmuv3_propagate_event(s, &evt);
     info->recorded = true;
 }
 
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 8135c0c734..3457536fb0 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -40,7 +40,7 @@ smmuv3_cmdq_opcode(const char *opcode) "<--- %s"
 smmuv3_cmdq_consume_out(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "prod:%d, cons:%d, prod_wrap:%d, cons_wrap:%d "
 smmuv3_cmdq_consume_error(const char *cmd_name, uint8_t cmd_error) "Error on %s command execution: %d"
 smmuv3_write_mmio(uint64_t addr, uint64_t val, unsigned size, uint32_t r) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x(%d)"
-smmuv3_record_event(const char *type, uint32_t sid) "%s sid=0x%x"
+smmuv3_propagate_event(const char *type, uint32_t sid) "%s sid=0x%x"
 smmuv3_find_ste(uint16_t sid, uint32_t features, uint16_t sid_split) "sid=0x%x features:0x%x, sid_split:0x%x"
 smmuv3_find_ste_2lvl(uint64_t strtab_base, uint64_t l1ptr, int l1_ste_offset, uint64_t l2ptr, int l2_ste_offset, int max_l2_ste) "strtab_base:0x%"PRIx64" l1ptr:0x%"PRIx64" l1_off:0x%x, l2ptr:0x%"PRIx64" l2_off:0x%x max_l2_ste:%d"
 smmuv3_get_ste(uint64_t addr) "STE addr: 0x%"PRIx64
-- 
2.43.0


