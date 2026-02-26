Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF75FC590E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 08:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvX0c-0004vw-OC; Thu, 26 Feb 2026 03:46:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvX0W-0004uF-OD; Thu, 26 Feb 2026 03:46:05 -0500
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvX0U-00053l-9H; Thu, 26 Feb 2026 03:46:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J0mM1ryytmp6jCWfp/GgRBJNEe1KYN2SguzGFD4/Bs06/t9yEVWjV+vUhsncH1gaelKBqGgwaGr+mPv6Ej+n1SbhHVC+SroJeTESpnWHSx8lucNQnzWCogVrDKZTQmcEklcxiWI5vAKaTUbH5/0GHgJgh6crf9RB/XgDG0VlRweXa41tTNaXNzAReWn05qK04yi//wlWXfh6voN0ozxCLpledrN6hGJPYnxIzkYfBLHu51iisrY3uG43tH9ip+06edpcdk3qmLzZtkq3zXfIwKCZ01tXqziHgbDdT9VfH0YggwaDAJXP6IQfyaoV6ih+sSUIO7UlcjbAPUTN4S2sxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryb7l0u+b9lTcLpYAn+FUMKs2MINuV25mqvlij8oFmo=;
 b=WNZL5SMot05zPRObVSZ4jr9fOVfbYLBTRWI99L0OjHzb/gRs+k0I7qgQCGwXbAeik6U0HpBTV/sczGlGfdYH9YYQN/eW4fJHTDerjsneDaPaj+nQyhh0+LjZN7752fpi1FkXwH1qJxC5WP0TQT/VslDgykHSybIKgOgMuS5YE2AeXZQRPkTRgABrmO4gK5SsOXt53E0NHTYLIZ71Y95hFCcRG9vnHCz/6ap3+DdBC8prcOoNLq6nPlZraDo4w74a+Fs5V1Ww5w+gNs/pNl/jr/6D/FGgO0CjFu/R1nO58+sQBIUQ5F7BOoSQtn/oWla31ZhTeTel0iwUBZVq3GvR+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryb7l0u+b9lTcLpYAn+FUMKs2MINuV25mqvlij8oFmo=;
 b=Dp67aCM2umSTPH3RbLbqgFSIVmk9zKPeFLNJRo3kY5p3gkjBK8mX2GokWubvKp/6GFDWN2wu21vBEv5qtkEmJbIfXFt3dMwWIpFoc4aepI8A1hZVrMxK3FUx/jkRHKjREz4MDqyiX8E2dPuZN8zYK4sjdPvsG/EEGJNuWR3Le7VtfGfZ8LDs8U1pdvY317emo8k09O+DxO1PkpCHuNebbVcvME3uV/7MYQLwv9+rTK0vzgaIq/Ptdo/72V6JgQKo3lQbLk2mD30FL5HAEccmmK9k6qfji2Jk3Mgfc3XIcyiHRD9jx+Wf/QWm40VD1LAbAjF3JLiRYMVchm4VNEgskA==
Received: from DS7PR03CA0103.namprd03.prod.outlook.com (2603:10b6:5:3b7::18)
 by PH0PR12MB5608.namprd12.prod.outlook.com (2603:10b6:510:143::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 08:45:55 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::ac) by DS7PR03CA0103.outlook.office365.com
 (2603:10b6:5:3b7::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 08:45:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 08:45:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 00:45:35 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 00:45:32 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@nvidia.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <philmd@linaro.org>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 4/5] hw/arm/smmuv3: Introduce a helper function for event
 propagation
Date: Thu, 26 Feb 2026 08:44:55 +0000
Message-ID: <20260226084456.112142-5-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226084456.112142-1-skolothumtho@nvidia.com>
References: <20260226084456.112142-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|PH0PR12MB5608:EE_
X-MS-Office365-Filtering-Correlation-Id: d4288b16-2b6c-4c48-a771-08de75137473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: L7/12S/eLX9YT8FS0E0rsNESW8q3y8eZGwQ1bHUDmFCtuxg2ER/rneeYKq2xxYu5M2MLHhR/8qKetgMVq4G8XrgftRRfRnJLlfBV0D+jL4meO916WgjKH3e7FE3qLz5KILEpU/jCE0cmb17VbrlUFxb6Y4p/PzyEhzEd411NxRfY8jnbKutfB5jspgVooRHtmlR13ySm/zAz55SKBZAQ9Kcd5PR25NthJ9GkZ0JDHJ6DD6zaVm/GKN309dT3CTj64J32wluvZyFb8sdPTE4ShT4ZIVc4GrKsNOu8l6qZPE2BVQW3nzJmMjXkHD/c2tog5gH6ilK9yrT7NVU6axhbfXFJ/wr+nDvCWYNPgV7syrif9Jg8bsgHRT0a5nQwvV4XIvw/KLNVWAGELhDyMXahMmQi01ecRid13yjmaVlVwnZRGqS8344U1OO0pZSyz5VPdHk0UmWTV+HxLVOwVcaxmRpndx4o4kJtqj1Aoon+r3RjzsTNRpfJCBjNbS4dAbV6zoJmyiGfBQaUgNEHo2OlWeWZ4r77N5co85AW9Uo0EANYQnXLIkVk9MYxK/Ch+Rp8ZkId+uJH7pdAfwq0JeHr9mAFj41C2zN3RaxWQnWNK+N8EOGpeVW4TLSAsn8ZiGr7dOLVsaKT79h+h7CQyvrXXfzel4ylLI5/9X197BH4H77FYvhC5d4G2chb0QYIJXIE4uv+mewO2xWuxJw8LfNiBP/ltuqsLj6F3u++B+nYaXWS09k9nNO7j6FlgF83OvhGfp7bFyhUOIlcUwVFrWwp9G98R915slmqSBf4NjgT6oe/DlvDR0NK75v+QMbqj3Ey6T/NOLxxv49KUrcdGjlYdw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VLL3nhjhhkJQj17wuKI6MdJ6SDuR/yb2EX4FWywXykEiDFiWE2e8aEloaZJCVgx/wzwo82x5vuRm4O8hKyiNiWrJOEd9zTvgVpqsYn/8VUA+1QzP7XnsVTgb0BAwOormjZ4wZLEwrHgV/6SIjPJ8bFVM0LnAtaEX0hLZ0l5YZBjf7MJDvVP1ugvUjDNGvT5PfOpMYONC7ODwhH5+P8f9mXNpQ6jip3BzLO9CwMAjipyi7bBDrTslnWq02TBZ0rwuxJmEI2321ZmtRGtuy1oFVg23Fe4hN7FpDWyFwFNYIh5NcIiZG/N7fZCrMZjgTBwFM6aktivZaPzCM7l2VDnCQ32aEw5la+9Bi7e6SLVMQQu/znJHzsxT6HCZw0KKrSu6cAyj0FV7XXyeBGtm13u5sS1FTWycJJq95d4NuTWqvamZy5QiD/locH7JGv3ysYZN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 08:45:54.8135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4288b16-2b6c-4c48-a771-08de75137473
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5608
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
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
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


