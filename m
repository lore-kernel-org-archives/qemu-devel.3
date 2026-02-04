Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B745EA7942
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:02:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vni8O-0004XK-4N; Wed, 04 Feb 2026 14:01:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vni8E-0004TS-75; Wed, 04 Feb 2026 14:01:42 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vni83-0007TG-E0; Wed, 04 Feb 2026 14:01:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCIY6zUQ66Holnme6sa8ZE+u1Qoe5mvVbEC8T5NdGwn4x1RjRT5msFvdu+aY0osVYeKCwBY2kgDgTaS9g8fcZF3Kl7Sf5YDuTcsE/ZDwhg6UyKDquyQzfqBt2kjFcdyYt2ZQKzDbBsWV/+N76IyP9C6RoxC4WxaEm+55D/qv3yNi+ZmAOmcQYlvQyOzOFUgSev2nD06hmKHi1ADPq8NZUKO3PzPqSwa2XZZ8GfVDK+li7tFviEO4U23hHcTFs94wAg2kgV/2f7XEJOYuW4tcu5YGhvTVb8zEI3Y0pN9KTwFJjAUCj5bvh8IUcdHV3qFM+txWlOhWrx+c/Olsbr5Ung==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZ44aXmBt53mz0Slgk1ui4ihtmzEBO/YNiuncm3EwTQ=;
 b=X5DvCr+5TlEuyR5Ubwy2rcHhWvDbykzsI+Wyo+7fu/G778MkDTAldDTb04K+G7MXG8LXHO/pHlZ+GDsj2ukWiMl/R42FM+5wys2BLXR4T9WKKQbimnS2HjNzYiq0l6SRbLdmq5ZbQxX2cyN2xkWhaLVl40m0to5EiKdfhkhS0xUKSABKOg4mMVC6HkTib+UVwR0ekQ9oLq9uNxtOJwHgXJ82u7Wl6f8ntvZoPn1fRnXVsUyPds1Nzm6cUhzgtEVqtxL9JurDkVQwkOjQg2XGzg32Ha5u+vIzjNkhMS16YPNdT0eQZm8SR1YGSIf7bhxzlTYVYyDTzwaz0FGtK/8gAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZ44aXmBt53mz0Slgk1ui4ihtmzEBO/YNiuncm3EwTQ=;
 b=iEL21jknkIEONUr7PVYaAexkA0gPK9QDN8Fa97NZXwBVOs4o/WWGaYqEJhtMEW+VDzlHmDfXPscFjEMx+xRTSClWROzKKV8/5V3t5UQ6sTui/4egjDcZ4EeW2f2BPEb7r9hJWogzObrW9Lz4TRJc7paVgwDwUsWEkAOYu0RkBf2b8KjDMC5FIs/UhVrv13rA7L2kVnfXWAtxsbNnNJSdlzxoZD1DRQpnAtj4HyW7ci78zsD0eE61pcuiJXfT92iJLwChyqDGxGTMLUHhiXZGcbtcaSl4D1lppwGkjCr8h+CmI4Fc3Uviv35eIVR6NOG5cqyrJdjRi6GqywjtPAmR1g==
Received: from MN2PR18CA0011.namprd18.prod.outlook.com (2603:10b6:208:23c::16)
 by LV8PR12MB9082.namprd12.prod.outlook.com (2603:10b6:408:180::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 4 Feb
 2026 19:01:23 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:208:23c:cafe::6d) by MN2PR18CA0011.outlook.office365.com
 (2603:10b6:208:23c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Wed,
 4 Feb 2026 19:01:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 19:01:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 11:00:57 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 11:00:54 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v4 4/5] hw/arm/smmuv3: Introduce a helper function for event
 propagation
Date: Wed, 4 Feb 2026 19:00:07 +0000
Message-ID: <20260204190008.20070-5-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204190008.20070-1-skolothumtho@nvidia.com>
References: <20260204190008.20070-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|LV8PR12MB9082:EE_
X-MS-Office365-Filtering-Correlation-Id: fdf22a2e-7d41-4d8b-d757-08de641fca70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lt4zZUxM2lvgSNQfS98bpg6LJlji+KQRli2v3JeHU3CAvzWNd5pNGhb1n4pm?=
 =?us-ascii?Q?5HNaz8ztQX2MRwmoklvHtUWcZYuvKZ80MiG15t4edVeuAtrcg5L605J0Dlfx?=
 =?us-ascii?Q?MFPqT1C7fa3SQhzkCOO8eVz3YQb2d301zv2SnSQcob5quLrDqaBjilqzj1ib?=
 =?us-ascii?Q?APxkR5SGF2oGsbf//pZJV0jqL3X4iUwFhQ2wGv6ueNVrRC048LoQd4TlOHLD?=
 =?us-ascii?Q?aaqY5BriC0IEAeYzKM9PX3h8pOkAw5vSfmflWapqPICuoSgR1C/ev75vvBaa?=
 =?us-ascii?Q?ZCuADLYamVPmNxp5qlPOPG5Qew/kfwJ68HOc9U5VfZtMc6u9HCdIQzp+9lLr?=
 =?us-ascii?Q?u+Ry/UC8AUfnuUUvTfAEN3pZkExyoF6lqCkVw5oKiiSl4Uic4AxcGBv3oaad?=
 =?us-ascii?Q?YzEklYnfb+OXNUwSb+ZDDfsro/CVSg4Yob4D1+hVaWz3mVGuoJiz4+5jmMQ1?=
 =?us-ascii?Q?pMf7BcsT1+sJtClJeHg0TvrV5hrMYK+aSXiFOT7F1WE//8rNSCMwOw7MxxoA?=
 =?us-ascii?Q?Du+8B2uvW9X0pXf0DAs0//sEqMveCQtDQ0cWd9xuq0AHKaDREV00576a9/v7?=
 =?us-ascii?Q?SuzXnyNb0sHxOKa7sAdS30V/ztr7MMhSudWmRNTNU82ZJlI+daeaziEDt0SM?=
 =?us-ascii?Q?oGQCx2tDsoBnpuw/Yc6jt9K7T8Tto/YNpg2lZT4caoZFJv+Ws1nXztarnEle?=
 =?us-ascii?Q?53VGDEn0eFbo9YUl1pJBmW/xqex6ym0ozdF/oj65FA6qRs5SCfhjRMRZHZ0A?=
 =?us-ascii?Q?w8znjdpzaVa88l+h3Mpnt/Yxaj3mTbhRjZjEFctzgZhsqTwyhLbLZ9u0J7mw?=
 =?us-ascii?Q?dfXigZyxdYJuY4D6oLjBlYPn+EWXeAKbcl4nFCPpeHnh3G856p4rs5VdNvou?=
 =?us-ascii?Q?4i/GTvLdEO1065QDMnWSZ+j1dayLbWJ7rw7pV5BFmafVSu0f1xclMfxTOkI7?=
 =?us-ascii?Q?JytTENYjqlG32wnLDjqdVCNHzjLTMC7hFuNSE4xgDreKKOas1iKtEFV0HlOK?=
 =?us-ascii?Q?rwx5p2LMAa/Zquj4b794Gi2b5JVFrdqr+pMU4+kgXu5JVVE6xoz2SkHirIxU?=
 =?us-ascii?Q?2q7ZmcNF0SS9XnBRT1/6XNwPLbmBcIDQ/V32Fji2OEJoKzbtQgceORZl9CFv?=
 =?us-ascii?Q?lT7H/ILyh2vs7CGJ1EastqjW3Wc04oFrwPZqlkars0hLqpoBCGKn8uApZhL/?=
 =?us-ascii?Q?s/DwrH/zxshWKZzJYu+FV5cu0o4XFDO2HDmPpSPpRRep3XKSsI1AxfSchIt8?=
 =?us-ascii?Q?4bNcAbQeLmVMgoq84ZYQTPQhgGxCjKIAlZ5CVZVZmWQYgcJtV/T/sLBjqXuV?=
 =?us-ascii?Q?MqHjlTs7dSZHA0U7BpWNr+DmnMhXRk88lcWrc+lACnPyoNUzvlGjYxzhTOE5?=
 =?us-ascii?Q?hgM81U1/9s92XZYfxuHBQI1ezJVSLYsGaYAadjD8s9i1WBYxVDQHuElU06wi?=
 =?us-ascii?Q?Q73PKlSeFPV6X+6WX4AYt+Ncq5s94EF4mzDNol6WBMxYWatXDuJxsIhgWaI1?=
 =?us-ascii?Q?R8UhxxiCQxceEBWeUgQwEaFXqJvt31Ud3oW0DlDd3N7UULgtoxtazjnoIA/p?=
 =?us-ascii?Q?CN4ueHGozNMOLwYdAPnMHGID+uy6Cv+/DaSRqIXrkm/rCADrV/c4Wr5DoerE?=
 =?us-ascii?Q?HJzWiTuVUzEHVAJMVSqs2rXWgV6zFcW0nd+P9IYF25Frqac5t5r1AGTtMqzE?=
 =?us-ascii?Q?t9xzeg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 82g6oD82Nb38zQYEWdlkbuohw1j6OlKffMNNDEuLi5WCYN+Cv5UGUzDmk7q82nPjl/CKCgoPBCsMHl0nn2cXOjprMp9plbio04wkG4NT2//IjNDyRkFGKaDWdQ2vs1ikZvdHiZzP660DylD3T/0ZoxEwk+d43pqJrY3OJZ07jCR4aMo/wmJRqHpn2GmLqUDXZeT5JFzqq56Htu9WWeft193g8tOPEzPmgyYCQunGURO9xu9ZWotbtBjPMbfgvmTXa2Arbuv29VoCzF4hvQX6qVyOJz2SjHZOKPfoVaqFKLnU2qjDK4HXqjj4mdZze7/LTy370X/lFaCfeojQSOVKw7aJXqNJRKv/qSUKrELDK0G7rhqsa4EQyx/eGZ+WxOHW2Lf69OKIWbsS7hi7lhiP777gQLL//o3MH99LQhutFSLOlRT2hynltPCLaUGmdaIH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 19:01:23.4534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf22a2e-7d41-4d8b-d757-08de641fca70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9082
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
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

Since this helper may be called from outside the SMMUv3 core, take the
mutex before accessing the Event Queue.

No functional change intended.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-internal.h |  4 ++++
 hw/arm/smmuv3.c          | 21 +++++++++++++++------
 hw/arm/trace-events      |  2 +-
 3 files changed, 20 insertions(+), 7 deletions(-)

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
index 210ac038fe..148af80efd 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -168,10 +168,23 @@ static MemTxResult smmuv3_write_eventq(SMMUv3State *s, Evt *evt)
     return MEMTX_OK;
 }
 
+void smmuv3_propagate_event(SMMUv3State *s, Evt *evt)
+{
+    MemTxResult r;
+
+    trace_smmuv3_propagate_event(smmu_event_string(EVT_GET_TYPE(evt)),
+                                 EVT_GET_SID(evt));
+    qemu_mutex_lock(&s->mutex);
+    r = smmuv3_write_eventq(s, evt);
+    if (r != MEMTX_OK) {
+        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_EVENTQ_ABT_ERR_MASK);
+    }
+    qemu_mutex_unlock(&s->mutex);
+}
+
 void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
 {
     Evt evt = {};
-    MemTxResult r;
 
     if (!smmuv3_eventq_enabled(s)) {
         return;
@@ -251,11 +264,7 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
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


