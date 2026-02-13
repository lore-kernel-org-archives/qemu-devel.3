Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A28EDF152
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 10:43:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqqe2-0008A6-Jf; Fri, 13 Feb 2026 05:43:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqqe1-00087p-8T; Fri, 13 Feb 2026 05:43:29 -0500
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqqdz-0006Zh-PD; Fri, 13 Feb 2026 05:43:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDuOV91HdEdYtLi6AkKJTWrguDzIcsDCETEDUAcTVKOsazJcxO8hbWyNNRRMZIiwWWfFFQz6C+TbHuXAXS/dmUTSE0zNeDGKeFpSvT0ex7y+0LjNOrG9HI7TXinwq2liApVIPDVZ6IV/47XEwKzK/x7/MrQX1V5gXhsEjNy5FpYd0qrGQ5fYn7nCsCWcMm2y+LORXLjs0L86wI3dasPPj0uWbyrsltBRNrLYx/G7SFt9BAEPxAGLuFrVsmiBL34qx11WgUwIv6YKAT47JMHQF47OeLBUJ2szNbItcR/CjN2b/n6Rba9Rr3O6iBlML/uTXShh5y8oCtQp5PxVtetaeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tm5qg++ZxEfyin8nJhyKxvkYdXOUgUcbk/RAi6275gU=;
 b=NSqcTuUH00fbPpc+zti5Jxwvm6BP/WhrGVQBlGJf11tXJ3bp5DXRGomEzB8AQ5xgft4XGJHkoLDYF+FR2NxKTEuzjSYorjXSeC8Gu+vakYdmTftQ8hbceSrsZCI8vz2X+NjxYfQ5BnZdmFQpqmWG583jZG2kGJMDaCgmojbAf3tFFjGr63EdYEq2ORvonWg9ZShya6oIi3ou1veQI8fKKyy9RMszYqMuITNIDaP2g9zBxXulq4VVU3Ovs+oq4LdSCPskD9xkCthOhch2+jZjDMlvZPYyGa+cbxr/IgDdleVqJRDMdfpiZ57DIasTWn6wsaxJL/p67sz1VF1F2fDqdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tm5qg++ZxEfyin8nJhyKxvkYdXOUgUcbk/RAi6275gU=;
 b=eDoMJkIjEU+rnXI4NpZeHMu+tz3GJc4d0obV70/EdGKgwONWxEibKXim/oFzzZAoZtLhGO3/75t7nO6Qps8k678271mXedP8Pt4X5Y28lyBPVJgsjVWGcTaGeNC3uJC4HQxMq27txW+GUDgvC9lzxH7tA3/+sXWyfe2EQRnPRqj5KQGW+bzNxUmyH0Y2T06o42ezDyJBrEyTOjNwqfi65zXXQ0jvflaULmPw3+eKa6K3iFDIR7E+RDIO0kPB75CrfejQGZ95iyZ7dltCSTGSrzqMskivrM3rEMosDEClJ+DwXGxXQMzrULj8msItCqtolyK8MYRJaI8PWyBhVlw/Mw==
Received: from CH5P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::28)
 by PH0PR12MB7908.namprd12.prod.outlook.com (2603:10b6:510:28e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.22; Fri, 13 Feb
 2026 10:43:18 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::eb) by CH5P220CA0022.outlook.office365.com
 (2603:10b6:610:1ef::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.14 via Frontend Transport; Fri,
 13 Feb 2026 10:43:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Fri, 13 Feb 2026 10:43:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Feb
 2026 02:43:07 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Feb
 2026 02:43:03 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@nvidia.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 4/5] hw/arm/smmuv3: Introduce a helper function for event
 propagation
Date: Fri, 13 Feb 2026 10:39:41 +0000
Message-ID: <20260213103942.142823-5-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260213103942.142823-1-skolothumtho@nvidia.com>
References: <20260213103942.142823-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|PH0PR12MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: c0334b47-3b56-478d-0ed1-08de6aecb30b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+j2N1QNfpSFIWzcz2G0pcQ03ofh1jIoSb44n4CBwgL7a4hdSXJtlIyRsWA4C?=
 =?us-ascii?Q?Z1ORrQu3w9xPsp8V9dZrS/oP4aqvPKEscyTqDKA9VnJZkbZZO2H208UswU+u?=
 =?us-ascii?Q?Xoh6HNlXWLWRhXK5k1uS3AAdRvWlIvXXQQHxZJABVdy1dZsDgg02Aa3/o4Cq?=
 =?us-ascii?Q?ReHWB/rTfwuWuRVtZea6ERTocID51pjDaVNqJgGEIDkWn8u/RAARXmNc2EBi?=
 =?us-ascii?Q?9mSvSlj7+KFSsbTLB5AWc7Qg73Hiz/6Gnor9Gyefq7gY8bh+YEdnGNQWDTe/?=
 =?us-ascii?Q?D1eIdJB95V0sY3j99NWVpd94ziio1DUbDu+74y/3N30ZTPiO5D4EdQ/3f1ls?=
 =?us-ascii?Q?yKV844c3aaS8w+FftybZMZ/T5dE8f+B9prmlS9EJas1xis5DuZD1mPRzimuK?=
 =?us-ascii?Q?vkLkbb8e9flqPqM0WLWw99qGXg/ghNIcYJma7gEbgXu+Ki/Trx2dDIMkXFee?=
 =?us-ascii?Q?dH10OU0M5OtG9xNACCKucUzAyAKEC/SYHKkNZmYTkEbDZ4R+GzPgoFRsMVsV?=
 =?us-ascii?Q?ZSVyevsFuLcyw2VdiG7rWbrpu9EJbJD/DUpufRY/eYRQoMixt1fGl9fTKaHt?=
 =?us-ascii?Q?tlTunY5KCt4l880JLUSnALzA6m+wJANzaD/XvskW/ame0MvBRw9wc9SUKjBS?=
 =?us-ascii?Q?1/m73rfeFUVhQqMHtLVBlFTT7aSQ6mJuZOdrm1ufWNeEUqZSPn5hXh9YF4WB?=
 =?us-ascii?Q?OlpaaOfwKsQhoH29Jci95rCejYrHuCulkRSFSrearqqwUQHa2WLJY+pQem7b?=
 =?us-ascii?Q?K4h4LLsY9hhmYT757Gip4Q+RVDt5le53dGkHsWXg4uAO2TFT2EjsaCQz12Sm?=
 =?us-ascii?Q?CbpEJLu24W0zReWrl9amw25v/Q+a6xkQ+amuvC+1rZKgGDKF0tt8qlsJCmoB?=
 =?us-ascii?Q?9HE1ZtGZWO4B1iohdJInFrnaZK/vPfDBF6/PFCS0CTokN3qO1R1bYVyQZ3Ug?=
 =?us-ascii?Q?m3+Z2HW7WDxt2nRcStVc2Tkvrp7NduPIc7LbAGEtR8FBpEdtjZFdjh0qk20o?=
 =?us-ascii?Q?g9cdBE9QKYwNxLn2zxxohdSEjWhx1qff2hOnEUda44CWqx2h86rObjLJy7sW?=
 =?us-ascii?Q?goUx68N4vYcuLnioxburCWEu+kCqwBO3JRhXOvLWH1p3PIbfCrcPx7E8Sue5?=
 =?us-ascii?Q?t6EPOHpNdKVEKkqbNchindI2XAuuwsaEoXLB8s+jtP5Yf4H5qw8EbVkDXqiE?=
 =?us-ascii?Q?E/U3sLLweAxf+7IOeWT3JUerAFJuUblbSkt4XW/JOQYiNO6oszBINCfRmnvB?=
 =?us-ascii?Q?ZJzpPkk5Al7qui6EO5GIBsoFGyogywxqJL9/q6+bQ2HCUO0/LcHJ50L7Gu6q?=
 =?us-ascii?Q?i4UtXOzRcd+IPeBFy5+RAYVx7e5TGMB/mV//wbGmxkn6IxIKQHEJl96hOPKV?=
 =?us-ascii?Q?H265ikqS+RYtt/x3JjJBVPmf/hem14C53DnyfmipmwogGGWs4sPK++eWLSf/?=
 =?us-ascii?Q?IcXRGUX8FU5TfAQmenFFuClP1D2wOP7XhxI2hwW9lnRdeiMN2vII58lGxxo3?=
 =?us-ascii?Q?/dEu7+428nGH204ccJ7bGg8bSxmq2rFPdwYJDxlKP+1LXX96WTAGd9iHyJ/F?=
 =?us-ascii?Q?Gg8HDJEZpNah3Df8MYRUm6RGUMVf8l4t4/K6+1JNg3T1J6YYbVIlxMXFKyj/?=
 =?us-ascii?Q?CMXNJbLV02y1+pwUcSTM6s4GSvRL5udqEaH8iVVVvtAI+VDeakaVMFke8SL6?=
 =?us-ascii?Q?rvyjPw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: flnCeI3Jvglj/U373iCr9CsG4sLiblgdKCtmN2KZ85pBTHeHJ/6Ez2zK3Jp9yMu/6w7+dKCLEXAm9sUE7vl/HQwi0s+rNGXmMlIfGA8DzmqAx117UFVDJD4Q0dCo4l2AGax/AMJItzAV0qFgmrE87ME+J/I1fbaOe8EIO9FTB9HQ118pDQN5pjDL9sUBfBfe6YQYMk2V4zaBliXebErjN5sro6oFWYniE5yN66bsDyrlr43DUzIEucY1FFUvwOkNBp7BhVbhVIRIlIvEIRoVLxOmZ2yfqMQbKzYRy3vriog/OS0R6UYv91Pl3FVxjmegLji+oD2UI/sHJiWBa3kogQGFdDZyHO/vT6IJwEAT8flLsINYUZVzX+Eml5fsAfELmwkZHZHvsF8g464bOHvGKD9/VDlRuztBDTNF8cbyUIV+cvNjZzAylzcGW1XmhF3X
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 10:43:17.9887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0334b47-3b56-478d-0ed1-08de6aecb30b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7908
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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
index f804d3af25..bcb9176c51 100644
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


