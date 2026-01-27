Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24746D2D8F1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 10:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkgRr-0004NV-Lm; Tue, 27 Jan 2026 05:37:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkgQZ-0003DQ-PY; Tue, 27 Jan 2026 05:36:11 -0500
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkgQR-00017z-OB; Tue, 27 Jan 2026 05:36:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPgRgcmDLxR9rwksAWzPC+AE5zX2GFabmkHt7TzxHpFsJjWilI5EaaR+eS5KdmiF9gqzyRouWSq1TP/fzQFirCVtnuUskhQxyb1WDR4/P2WXF+IyalcQmP5T7S2AIb+cWGRcGSdQgVdipy0WokuHHxvNcBIfB73veD64pywfy2xqz28E2R8TUw4o2BvZevCQH1EeFLrCGQjbFAlaeMoWWk2GMZfOl+jL1V4/SZwzHaxz9BR15ZpAyl8bhTmzveFRKtjtnY4zKJuLCRO3KolhpgZ83INc9vBHKtcnYynrwlF4OCO4hjyhOdf6HmxP4jcp6WTr7yNTNCDSmByc/6Yj3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZ44aXmBt53mz0Slgk1ui4ihtmzEBO/YNiuncm3EwTQ=;
 b=mb8DaVDhP6AunNgNSc7vIRoKhZknNFWrdRwow3IhOcA5JQgWoPLHs4MoJXYHUPaYiJJ/ClUYhqFkNEz9uGsFyU+vAFbc23THg7xEZb5jW/RuWTG1WdoRq+NHuguNyEDMrI+hUHJBoNbFNWtwzLUDmaOZ6n35v84jQPQN2bREIL2ZQ4SznH6T12uHMyEVYr+MX2QtCo/yw6ROLJhp7jaThPoYZWw/+JwI2RAfaIwv0KV/TSqs8hFP+KE9N6M2XSuKosX3I93E01uQkAhnSfhG8xuztG4/VAAVIUFPMJ+CTZ4kFHDHJbQlgCXAlSIuEdMnTj6OiPs7/TVRTLlqebwFJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZ44aXmBt53mz0Slgk1ui4ihtmzEBO/YNiuncm3EwTQ=;
 b=QAnHcpmi35qEpk/5SVLLdzjoTwY5rltYy6ofyvACgArIjr0fElORMJQpQ3YJKgYeKB7MY4r9fp8kTFJ9rkykiotVfe0lKzoQUkuchqOp7Ib+0OH7cWY1OGC/wJlj09XX0yZwTSkrhdacVmu6+kPiNCWq5NyXiLtASZg5tJjQfNiIXaDxYkHOWx0XWpXz5eXCr8EV7zDB3NIamxS24ifNVkieaqaqAFdOEqV++pm0Z87QPvyX4mQMrXOYQpFNGTer6oASIo7HogEX7lW1cow2jXFhqF4mRBOxdYAoVG229HlY1UaNNz9FF9xR9OUdnQepe5lAr4tIAjwWoLqFboiLOQ==
Received: from CH0PR04CA0045.namprd04.prod.outlook.com (2603:10b6:610:77::20)
 by PH0PR12MB5678.namprd12.prod.outlook.com (2603:10b6:510:14e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 10:34:36 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::1e) by CH0PR04CA0045.outlook.office365.com
 (2603:10b6:610:77::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Tue,
 27 Jan 2026 10:34:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 10:34:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:34:24 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:34:21 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v3 3/4] hw/arm/smmuv3: Introduce a helper function for event
 propagation
Date: Tue, 27 Jan 2026 10:33:27 +0000
Message-ID: <20260127103328.255382-4-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|PH0PR12MB5678:EE_
X-MS-Office365-Filtering-Correlation-Id: ddb5ad14-9b7c-4c72-75f4-08de5d8faaad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PKdPfre7gZ6xUYeFolKz6GpVLqxP28HyetesgARPdAp8jCrG7UDMfkJSFe9R?=
 =?us-ascii?Q?qOhNNvY/NPWTB6Nm0UyhIDok2k0qxCx5tDptXKgpHpcGWxUbz9rTsCA1h0z6?=
 =?us-ascii?Q?J4d/P3YY+gm8abrLgKHCrIntu4g70dayMBAkJKd5iggC0IAW2SaaE5BZ1zuC?=
 =?us-ascii?Q?V0GOr5efzKOd0QCowBB5j5pS+xU6K8/A6/W/jYvRDT1XANxUtMxR873GewXs?=
 =?us-ascii?Q?JIT8Bz+4I3tivYF9pbd1EcDN07wuJ3odBw2uqfh2+TgGuKSfA+h8BUUC1KQT?=
 =?us-ascii?Q?G/GsvDRCbwnuzYx4ZuPGdo50vMU2y4TfZWpXXj8KoNaXP8Ee3GK+fsz94L8l?=
 =?us-ascii?Q?GIPnDCJCaicIOdgFX8Kxv0WNZZyl1XS1NelwFLKsUX2Ra420GqBULkTcvR1S?=
 =?us-ascii?Q?9UkUPYr0kcxMZFS/9P7s+px9R5stMnx0fEitpxQuZg6wE2lvzd/OpzDHtEBR?=
 =?us-ascii?Q?OmkviNeGVHfvn1zCXCoimtj8HpMku+3H29789VhR4vuYiBZ0SuEXJEfnQlP7?=
 =?us-ascii?Q?NSepd6kqixFmH8A20ewDFcJhT6u6THGv1OkJWGFQLL59q8D0YXh1lFR1y+Hy?=
 =?us-ascii?Q?w7y/uXKurRpGiUEvoD7718+V6GiESaAqmrIf/Eao4SXd52w/MvYyuXBGb/9b?=
 =?us-ascii?Q?0JH2XOToWsVjFmXpbuhA0An77MArAgpd8WnijBAMhTHPFcC8z0YJnv2Olpgz?=
 =?us-ascii?Q?nzpFoj5kOfIaCjCdo5lprxbZGH8Wg/maaTyjYqV8Xgy+2C/JAP2++D3ggg59?=
 =?us-ascii?Q?LX7jSrOTcQ+rto6e9oa/9kusZLwIPHUo4qp5XgQe/e6KHAb1UkGW6VXSoPXb?=
 =?us-ascii?Q?bAn+f8ZkK6HfGtl6Ac4WMX2sX0hI18PxXAv6y7YqXVWWr8bRgRL9tHJoTUXi?=
 =?us-ascii?Q?Pf2Cl4v/YlynoUggthrEv5XVBCsvkvyz2f6EvNdLTeqke+QsBDFU+wchS2u0?=
 =?us-ascii?Q?BXCjSyxSFZ8nLbBDRlJYp/EdHt0hO7cZo4rCFR5kyr9SF52o+H9BFZpcz3LB?=
 =?us-ascii?Q?deoDw6WQ/2y+S12vMPSN8nQIBa+jwaA1P+ABj0tSxEIHy2cAsDBX7iICoxvP?=
 =?us-ascii?Q?XNTgTtEywy/2PPXaXiFVlFHG3v0xLZRSvbODW7/YwpZ3UI7fHmJKhI9kiWKU?=
 =?us-ascii?Q?yNszqE9zQX93NzdH+UQUAl5kYMtrVwR8kiMbxm3xdKvOl7FsLS9ZcuEJIxan?=
 =?us-ascii?Q?oYePW/u626XWJt2HzPTCdzA/Bw4a3sfPZgwSPpv4KXnqi7LJQz2BZ7pGnV5s?=
 =?us-ascii?Q?kzXEvOkhbgJABIC99xTTTbqi/qqgaYvnlYY5bvoACPyvqBtFl7WKWAoYykh3?=
 =?us-ascii?Q?QRHesVynF27bqC5sZ6EyTqQhBZxclTGalqdy9fLj0oUu2vntYkVrBSbXvTnZ?=
 =?us-ascii?Q?HfldHK8ml4KhcVriwj6wW5TILKNe+IYrCngPQNfTnPRT0ewRcw6l7cMazLDI?=
 =?us-ascii?Q?gCdMNyehz2Jpr6o/4NG9pdrJ64aQ24qkMsSBG2CXg0uIWpxdpmhgwFMLwmHY?=
 =?us-ascii?Q?nhuneO6RrBOWx7dSC78MofHnjmjrc8pabcKiJOglMub8ZHbGkhVoRStioC19?=
 =?us-ascii?Q?ru3scuoRHoKQnqGCctrtaOugB3E+i8dZ779fPVW/6VdvCPoH3BebOEcNCmHc?=
 =?us-ascii?Q?68GBNLsevQftLoASnBTCpFHnXzcgZSyV4jRmgVJ6AuocmzGFL2Bstk421h18?=
 =?us-ascii?Q?P1DyxQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 10:34:35.6818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb5ad14-9b7c-4c72-75f4-08de5d8faaad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5678
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
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


