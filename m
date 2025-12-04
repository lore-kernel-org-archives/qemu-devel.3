Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B11D1D892
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 09:25:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR5Zg-0003O5-5K; Thu, 04 Dec 2025 04:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vR5Ze-0003KD-Bt; Thu, 04 Dec 2025 04:24:30 -0500
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vR5Zc-0004nN-T8; Thu, 04 Dec 2025 04:24:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNTLrZDY+TMm/Nsy3nAUFU5njmAwWobzFsQZzyl5IU89nn2iBdYk+WTnIUVwMrg/zdebRu+lmhXjWCM6OlOrAzf0AyurFcbH1KoUJyYQirtzWu8trpadYTrNni8RdRV7koxaP6AwPFkM5Mpn3CiOvFpjhVCUKIDdmu4PkuPV4YYgNekxgcma6DcBXwALImJEVyf3iJHjN0Bj+y8FVXiJsrGp2NRzFqeQJNVR+qogtNWb5i9eDS9nqDMkfMcP3SrzU7R/HRarllLYeheA45COxHsSXwqx/eHVbJKJ3YxOLlBYdWrKQBpcpPxmzeOie2++GP+weDbEnN5hpmhpfJighg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwhQpELUaCe/68J830KtnZE/KdzhYLDxu365wBhoSFs=;
 b=E/Gdz0Ua9riJmhpvjq/Vcg1/OY7k6gvkgKoSHAoYvfPiebPv9P+kVeVLaeoz1JMi/T6xw8h4BbOY7dhKPz9xhrlsXLNd6THKQj+II0p/KGrYa6SBzjnbFLxJ3oMblpXTlfdV7K3nId+Y/Jo5Rq6WRqp3a1C7dSBkkqmAUYEIQuouFxvOipYlmFHXk8NpKyyMVCRr/ePRCiWZ2e6dqpwPMjCClKlNvxOY0KOU0OU0VHwOgPH7nJFEHqICzonp+PdP49WCrMKyFctAuq/OrFiWEQPjGD9rrC2HvHgbiwHX4b1+UMvu7r8whvP2LJFt3xvoSUhBwbOyCkTY8EuT/67RzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwhQpELUaCe/68J830KtnZE/KdzhYLDxu365wBhoSFs=;
 b=AwhJnUb6JWlHXOpn6RLsy2VrwktmNze+p8Kqm+Bkg3cc1PWdfhwSx1e2Tj5h45Id4jYPlmoQ7g9ms6hmNnpKEqm17xuxGV6QbZjPPQN6KLG9ItJdg3ZKtCn+zubegctVlw/Gvv5qwFD1dkAJL3+oPgdqeWt0GULuyBpw3K1oGRviS4VUYZz2kA+RUzPpJGPPjVxyxMACXAw9GzMPEf92xHhcv+35egTD/eF53XTczC5bo/E5WKCVCQhY/qaCPCRMJc9wqcfp7YX6T1PhAmtKJ7QlYnGPONkAx4bjlXIt22J56hzviaCgMmi8WrZyg5V1cxXp6Mqwn3yKyaty8gbSTg==
Received: from BN8PR04CA0047.namprd04.prod.outlook.com (2603:10b6:408:d4::21)
 by CH3PR12MB9172.namprd12.prod.outlook.com (2603:10b6:610:198::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 09:24:21 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:d4:cafe::ad) by BN8PR04CA0047.outlook.office365.com
 (2603:10b6:408:d4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Thu, 4
 Dec 2025 09:24:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 4 Dec 2025 09:24:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 01:23:31 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 01:23:28 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v2 3/4] hw/arm/smmuv3: Introduce a helper function for event
 propagation
Date: Thu, 4 Dec 2025 09:22:40 +0000
Message-ID: <20251204092245.5157-4-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204092245.5157-1-skolothumtho@nvidia.com>
References: <20251204092245.5157-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|CH3PR12MB9172:EE_
X-MS-Office365-Filtering-Correlation-Id: 48680cef-d69b-43b5-6740-08de3316e849
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UE2YxApXFmCD6lOCoeSP03rkQa+vCm9JjJUqkkumD8hBkzBAEt1AqjvqlCCo?=
 =?us-ascii?Q?jjwOdd4si8dglDms4Jh8BtixhvSMfHPCa2cdQScThhZCWZ+TVa44C50JsQI9?=
 =?us-ascii?Q?ItrIqVKgSGKq58b4m1XgeSUEM0zjsZj3NG+dQ145/L8gZ5iSHjarsY6NQB2M?=
 =?us-ascii?Q?/wqmIYdIeHfHTiaLhWIcI3G+Ixb4S0eAxDAb85F/NWC26kX+6RRKCHMJwukH?=
 =?us-ascii?Q?aC9RLDZSkZZaYG5tQeOA22bY+rIehYwZNKwC74zTU4WCeQzHYbIUXJYi22PV?=
 =?us-ascii?Q?wxftYNXysqrNvLFXr90hZkXGhkA/fX842oE9mRdCIJPJouj4MZTO2gZWKtEK?=
 =?us-ascii?Q?a+MeHxfwUAw9e5qYRayn0d6iYdN3QOOeVWvE8jCPUOiqYOohcgoUKOWWnzFT?=
 =?us-ascii?Q?3gYd4TzzKUwldtLy9xSV4UU5YoX1RTVBBjnTtp561pyT6whXMZt4Of/HceCs?=
 =?us-ascii?Q?bVTnlZJOgynZq2gf4O85vp1dawVtM3MnJvDTyTsD7v8HacapkARKWXXg8bK2?=
 =?us-ascii?Q?0wWa0NU0xTLGkGQTIC2BzMYh7VEBtSRAA5lsUwEK8SPiYsTEvoYTft4NSBAq?=
 =?us-ascii?Q?rlGaK3pEtIuLS7u2yfJUBtEuIrTlv40IqXecwXWXkm4CLRYG3LhMhH1yXHcB?=
 =?us-ascii?Q?0YzRCvhlpTAxNUgQEIk5AaDegoKJc1HKcfPy9g63uL1r2n6LzT0Rocyd7oBs?=
 =?us-ascii?Q?xGWsjR85/Ta5blzp2JmBL99KfUwCzSEFx6ca70P3i2tMZQcC9RPGrLna/2Qf?=
 =?us-ascii?Q?Ajn0LL28Pxhcb1SfSBiyhfkk8c8TMHsShYBeco2L+YonDc6e922hcfc7iM3f?=
 =?us-ascii?Q?0t72vav0ssZs6mkzkStmpTgKqjxaLJBkDbQYyCHV5RhlEiVqg0Ax30WX6z9R?=
 =?us-ascii?Q?+N4oVsEforzBPAC0Sotl1MY38OOEhLq1+pPTQ7msGTWrcxj9SgBjr1jKt4uF?=
 =?us-ascii?Q?mcfGtpqUT7+0svEykr0Rlo/NviD2wxKcVEHlsHaPb2dDpOs5DwcB01TtCZjv?=
 =?us-ascii?Q?k6k6S0AkENh0b+pKJpK+ae8YPNFTMrEDXx/M9luzuxJk8+I/ioMVXIIrutJ2?=
 =?us-ascii?Q?Vxllt2EVnASGigvuj5t9iwsHwcNGSY332zQaC2wrtxGsqRBY56CxWDJITwq9?=
 =?us-ascii?Q?erEqHQBuSHIfVAN5O+vcjdzm0lp7z+2Spqys6LSYCCv0HQLOBqeCClum9aG8?=
 =?us-ascii?Q?5ZFb+8XVMdbezfnnk5rR54RyoiZwN3HhFJSzBrHAlQrQnHOHAEHbf/beHmGe?=
 =?us-ascii?Q?xd5lvHT8CjNU2GrZ32GRoDRs0Yho9dlQMWC4oGqKLE6bD6CuZm7HvF0GSoP/?=
 =?us-ascii?Q?s96DWkJiWDnuAScqhF3pF/6CnM577rxSyE4bV0DrVX2RpOq2AKwVWMY5jBA6?=
 =?us-ascii?Q?iEoDr77XH6kZ/5qJFZqLyCE9F9YqrbynClXTfH4PqKxPLwvzxePzurDTj7ct?=
 =?us-ascii?Q?1IHv9TuyiDrmJV2kBlbAweFbeB07bpAGG9yZ3dWpwqjdVUmADLeEx03iq9jw?=
 =?us-ascii?Q?ZMYzxsu1ydSkx+1FLuJqMFMWLPKzXLeuFbT7T4wZgweNcBoNPZT25v5SSMYO?=
 =?us-ascii?Q?QYrxHoZqLTwB4eQtUlw=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 09:24:19.9822 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48680cef-d69b-43b5-6740-08de3316e849
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9172
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
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

Factor out the code that propagates event records to the guest into a
helper function. The accelerated SMMUv3 path can use this to propagate
host events in a subsequent patch.

Since this helper may be called from outside the SMMUv3 core, take the
mutex before accessing the Event Queue.

No functional change intended.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-internal.h |  4 ++++
 hw/arm/smmuv3.c          | 21 +++++++++++++++------
 hw/arm/trace-events      |  2 +-
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index e45aad27f7..ad7f5e6640 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -525,7 +525,11 @@ typedef struct SMMUEventInfo {
             (x)->word[6] = (uint32_t)(addr & 0xffffffff); \
     } while (0)
 
+#define EVT_GET_TYPE(x)  extract32((x)->word[0], 0, 8)
+#define EVT_GET_SID(x)   ((x)->word[1])
+
 void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *event);
+void smmuv3_propagate_event(SMMUv3State *s, Evt *evt);
 
 /* Configuration Data */
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index ac60ca0ce7..9b7b85fb49 100644
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


