Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5786BEB597C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 08:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq5hU-0006oA-1c; Wed, 11 Feb 2026 03:35:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vq5hM-0006mT-Rk; Wed, 11 Feb 2026 03:35:49 -0500
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vq5hH-0002lt-Fk; Wed, 11 Feb 2026 03:35:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=enfqcDLNBkmZV01md2+IBMyCfjY5JqKr927LYtBG3XkQs+WO/6D55KMtiUq0FSnLjm7FctQGfTLj2R9El1CatDWOyqPQjtWJofs8hd+d7FEwIxlxOvKFnIYmp+ee8YHGU4OqefolpeMjewp/m5pnuUSjQfEaN6k4mwB1s8iH+VikxnA64mkAUxRcDAWoHD9T77Q8ZTrcsDvX/wMsmncRVWHNRSHoT7vYN+EH2iJJdFymWpaelK4vSh2+c3E0stYG7E7cLwkfE4ftKSqva8/rOxndZl6YYs/MooVjaf9oTUXMwz3L2phvMxkhXVvQGRkNzWAYRMfTxGb2U9jRAunhbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZ44aXmBt53mz0Slgk1ui4ihtmzEBO/YNiuncm3EwTQ=;
 b=JdWdTP8gGBZ95XrPNwejhh0J1llXJmVCEDV+X2IGodGi3rzzetTkyEZ27B0t4Bu8HPzJx9s5cgujZiH4zHGEsGa3O/srhOfC4Nv0SXTxRrwTWgcRDsKZrRiif4iJBouTj/eIMs2e9KA7rOa3cT16YGT/jxzlI7WhsAs0epebA9oylktARPlrJb3s2ZsgTJciF4svGwdaAByJNKVUrTImjBisaPq0r6Nc+QK5vRXGPVHkNz/Y1SmXmIVEfLwkOlUZAFCNG99WXRvKDV3pQphmh/6iDwv+0g0Ht8YCvoqsjHhctQO3UNoTF1cX/u+uDbgSWLalyphCfFI7lKELBckotw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZ44aXmBt53mz0Slgk1ui4ihtmzEBO/YNiuncm3EwTQ=;
 b=KQiY99iJL0iz5SucT1VBtyKmyaY1zJHAtmnXDLSHrp4s+h7mq32mRjFDhbd/IgCNyv/Lsbn5Oxk6aGqprUHpcP6Yo7Q8e0dD2ePwc8oZMC7/bBPfUb+Q+TYd6HvXvOmn/WcFS0HspRbicAfmcRGr+bodCT03qIz4x85F0mYrT+W98l8UNZ0fCeQXqKLVNibJiR+Yy6rFjiQO5fLpsuiPfc0cN2lvUivjPt9mjhyRLQu3+9gXRYtlMMyctKE0EBtOHlR4y7mEA1iqeMuo85k+8sllxpfkrm9ijC0qQ5RJEWRe9rWs5TFLzLa2371ugL4zicxQ9tg6KbQPPSOdQJc9dQ==
Received: from BLAPR03CA0063.namprd03.prod.outlook.com (2603:10b6:208:329::8)
 by DS4PR12MB999101.namprd12.prod.outlook.com (2603:10b6:8:2fb::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 08:35:36 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:208:329:cafe::ce) by BLAPR03CA0063.outlook.office365.com
 (2603:10b6:208:329::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Wed,
 11 Feb 2026 08:35:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Wed, 11 Feb 2026 08:35:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 00:35:19 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 00:35:15 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@nvidia.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 4/5] hw/arm/smmuv3: Introduce a helper function for event
 propagation
Date: Wed, 11 Feb 2026 08:34:14 +0000
Message-ID: <20260211083415.133534-5-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260211083415.133534-1-skolothumtho@nvidia.com>
References: <20260211083415.133534-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|DS4PR12MB999101:EE_
X-MS-Office365-Filtering-Correlation-Id: b9bdf8c4-387b-4acc-75f2-08de6948873b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tnlQmRPhwPLoM8FVx+TgUZwq+fantoyhTpXiYvm1pZKrDWSpspoXMKhS9Dgc?=
 =?us-ascii?Q?Twr0kYXwuRVsy39GqaJJKkYrKdsfxBenDkRBgqdhlhMtLgNbd39qYRTHypFR?=
 =?us-ascii?Q?hzgOC8Yw92tcGxEtgWf0+aWkST9K8ocLQl3ifFkyHHjR+og+KcK0EkYlItGd?=
 =?us-ascii?Q?W/+K/9lw8ts3oXyJJGrkUzOvkWPJRTjy0cH0ZDGipG050lk0Bfo2yRPd4NFF?=
 =?us-ascii?Q?LT4xsZUnJbprlVq1itcePcBOBvP4jNZEcEdWPiwVII56FB+U+AZVrN7pkX7K?=
 =?us-ascii?Q?3pp6l73F/hr0uuFH7uVTmsAwRuC7tEjhrR+yk5spSf9k+1sIOJ5IOnwrYkQC?=
 =?us-ascii?Q?thRLCLuFmJI6PkwhtL0ElOEM8ynEttzS5K2yw59EE2qu2iSCaNc5Ruh5C9Cp?=
 =?us-ascii?Q?/dRrRweHNhts3l2iAgU6lEFCCT1t0Bq1IjubM1dWqdDa4ejJMf0cAFUEpyC2?=
 =?us-ascii?Q?6LVn4dfmr0tSSvjunPoG5Tw2lkW5B9zSa5iTD+i52sNu0W0UYHioUOA3mZ56?=
 =?us-ascii?Q?MOQGTkW8hM3EFLEaizFeeJ5M7Dwc1FD9ShID7filVHIASem5qysTMWKTiLnL?=
 =?us-ascii?Q?oLhSJG7DkaJqMXvgeHZQIG5bgM34JjwbxHeohttUbkxdQNzuE+hgu0nNASv3?=
 =?us-ascii?Q?Hx9gOfyRtjSVvsHVRZ5hazehEYEYYqvPu0duodf+I0fKkEgsrr6WO/kKeDZK?=
 =?us-ascii?Q?TC/0BLwJzTX12o4LrcuRhF1z6RK3iQPIq+WPmUfb3K6pJ0y4pIwZhYNaxqFg?=
 =?us-ascii?Q?sXhnCPqPMrhv+c18VqWLi0g41VN+Vr4C7oybcNvgEuDzVU/TyZpLtzJSXmkm?=
 =?us-ascii?Q?cUAKC5yIgOahwpbTkJ0Qv0M24rSGevC61Jw9jw694N7Y3JxU+H/vio8vQBWa?=
 =?us-ascii?Q?jDf5xRioWHvobarIXA9GGKiELWmLFg8RKpudPXXUvmt3iToi5s1S53lrTHWK?=
 =?us-ascii?Q?UpiXEU8aUMIcjXsFO10q+tbOsljHlQO2Qokpf3rtdUTNcTV7ysrxFPNvs2YH?=
 =?us-ascii?Q?Tc+EoEXAf6KaYGM8r/i5fepZ48bqEF5DGSgJOpFSkJTKnsqXy9F6qEm1ZWdE?=
 =?us-ascii?Q?nKlesQB0skXk4eWYa8XiyUfycXaPfWkZNtasxxdP/RcTXC5LYSHa/xjClHDP?=
 =?us-ascii?Q?IU2XiKcRlch8LUdrOV0du19xQOGEaROsT9rBu7c/iA8hK5Rg0CedERqxKKm7?=
 =?us-ascii?Q?OgtdIFVWPlIYorlqxiFpPvOPQv2IaUOpWbaYRrMySs8WZ6p7v98nnet9bmma?=
 =?us-ascii?Q?aPFgMJCFaE/AdhUcvsYJDlkx2pJ7uBhSXsN73P9n88Z1X9Pqmoz9YR/6FabT?=
 =?us-ascii?Q?uL+EqnVix57a0CoO2hZAPYRJ0F8LxtpxdYk2vAyV4MJd2C6oQbW4fPAQWRwo?=
 =?us-ascii?Q?15IYq7uYbzo93AKG1mXiY50acuWE4vHgqEHMv67hZRUcxMOLZFrSHaX47ODR?=
 =?us-ascii?Q?O4wICvio3+DAceevuP/7KpkJgbig+IziNQxjhAlhgmTka9kQR1aU6Ha9ZJeM?=
 =?us-ascii?Q?XNjbsefLRk8tLJX9sKO96VRIqBxGrjkdRf/jUiB8SAaBBgYEchl0GA2Tqte7?=
 =?us-ascii?Q?MSFZUwxtFVO8kXYrTgaUqNsnysmzMA9L1et+bYxobM86eYmbYL+zcc5UfrYB?=
 =?us-ascii?Q?WQUKV/nlfUe1mWROX8C24cSKrFUFfV92fXNfZM8s7Oor/z2iVs1qHN7pqZQo?=
 =?us-ascii?Q?TEkR9g=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Xh/O5jzYcwF62RPilHEYbfb3WIO1EiQeYrmPJ5v4TuMHEBKp2Hvq6f6rJ7Q+OFhqto+xSWhD1APdv1Eia+NqVmRx0es84WGMvoPveSfERWmZ5rbJoWO1Z5O66+PMniIhh9eC/SJvSd3N/5LdqY6j+4nWLplk9FLvluI88JsModIaj7zyinezLAXkIHDqGdaDryhzSOyeaByLBU1ihNsc0oMITdHETd6AsVh0znteodQ+H0zAQNJ4CFsU4ooSwx+OTnqTrV9G+QsxLcxCNUzaghgtdxemHNlXAtyHRX9JZB1YV1GnQyuYzT40ZY0QV1unx3q+msmkAbd9pDiNvqjJkcX7QTmfQvlAMgh9IKxtqqZA3POTg7Ut40IZwhSQQFLQTnDmwT8NZ7G6Rh8Y+ej5QAQ4S2XUlbCs2mHtS/VYJ+C2JTJjpIY2rMaaArApaJou
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 08:35:35.8554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9bdf8c4-387b-4acc-75f2-08de6948873b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999101
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
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


