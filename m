Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB732CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 15:50:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGflY-0006hG-3F; Wed, 05 Nov 2025 10:49:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vGflT-0006gJ-R1; Wed, 05 Nov 2025 10:49:40 -0500
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vGflR-0002To-Jd; Wed, 05 Nov 2025 10:49:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PImBnyV1GJNkaFrH01TEzT8i0qyx107FtLAANiMPgbBtNAZL+zaAS74fAVpiF6cRojQ0FHHSNPpwBXWO0vqFfX6YhfQDQT8bC1BPDBB5mfr+RKctQrMUJW64DM6P166j7siBY5J6cbUxJ6p5B68sjVISGx57iOc2GxeW/4/8GhGNzb+rHTLCNQ6+EEmqMyqehRQTtZEksy4csWnhRtogxqxB9Ir+flJmXFo68wlYia9IA6x3XjiWJfdA9Li0xBHj22J+iRGnu1ZxdaWvRnUIK0klmY8S1o6J5zvlMzK5uSRX1sHMFDe4W2axVj6vlceTheTYjAicRD78WFDODK0+Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXx02k3J3Vta/ic++IK+fT83IiPTz+SqDaHwMiTEL+s=;
 b=e1jfSBhrCBHAhvnC4Lsr3C4ahVm5UobAB/c5wxyIHWZNb2/FB0vq76O9kAz6xKF3OoVxN021rBCykjYWDnB5e13i+6PkKM5qiRVbAyoHYGQfKRszNzqmsuFCj4N6zqEMTd+5E0u+coyMwXUBxCE0Zxvjg2iwiQDyH+5RZipjFSVf1jiaVGeXr8CWQv5IU94UaxpbMR5L9ad4aXpeLS7V5aTcfw6hnQuYStFl9bv62EONkzIznraAmOdmpCC46b4CI89zoU/JNjGXS8QwFnBIYsW4tfBUZIFfgO8JPQachbxDCsldK9hcd4h/CwkV6WlEG+kUOrLrq9bqj0S5H+KP2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXx02k3J3Vta/ic++IK+fT83IiPTz+SqDaHwMiTEL+s=;
 b=usTNzZ/F5ZsY00DzAOSd2JikMK/tfP13TXNMYeXx5VIpnvR5Oih9cshcXMuGrQ8MLZAxvoP9onS0hjGIAJlovU9J768qxlz7mu1kDo7XQbK48OPwNBkEwlxFdf1GKWEjfENLTlDNsf2NigDzzghBaj7DS2ZZ0M1/kAqj/C6CL6ryIfO/6PoLzR+sj6DuvRdTnQdeEDPm0bSmFcRa36WPwk8ZOSHKIXpSXLfDqh4cXt5S91XoSEMRf3MERi93FaFpKhlAEbndlt/y3lEWF6cjmtYGqTbbwM+A9qpHIg6s66eD01vVy0gR5OkHEA2+1t5ajEcwhLz51UJQT09r7lMjZg==
Received: from BN0PR04CA0194.namprd04.prod.outlook.com (2603:10b6:408:e9::19)
 by PH0PR12MB8149.namprd12.prod.outlook.com (2603:10b6:510:297::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 15:49:32 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:e9:cafe::bf) by BN0PR04CA0194.outlook.office365.com
 (2603:10b6:408:e9::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.9 via Frontend Transport; Wed, 5
 Nov 2025 15:49:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 15:49:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 07:49:14 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 07:49:12 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <jgg@nvidia.com>, <kjaju@nvidia.com>
Subject: [RFC PATCH 3/4] hw/arm/smmuv3: Introduce a helper function for event
 propagation
Date: Wed, 5 Nov 2025 15:46:51 +0000
Message-ID: <20251105154657.37386-4-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105154657.37386-1-skolothumtho@nvidia.com>
References: <20251105154657.37386-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|PH0PR12MB8149:EE_
X-MS-Office365-Filtering-Correlation-Id: e02bbb90-abd8-4e2c-6568-08de1c82e95d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a8+7fIxzlxmD8aMKNx3WH3RTZFII/RitlgGHk/vbhbDh6MCg+qn1qrMxr9Ie?=
 =?us-ascii?Q?oEmCb2RS+Y83WfdGiGB+VLohRUiEnRaVM1Yfa07CLGeB4VD27Ri4bjzTwAtF?=
 =?us-ascii?Q?RSPfXEHpIuPezZajRgucBwM1Zfb/B4bboH6/Py9BVSDvfXJQQyfwXTcdDrny?=
 =?us-ascii?Q?E8kmNzy/n/AQ50Z5mM6R44v9kKSp8J8V81eqm/eKJS1jQjcFQHqLClqqTReX?=
 =?us-ascii?Q?sN/GW1i2BWugfZz8U2H8UDtpFf6TGpReCWVMaUkTUFn+tdmTGhYGAd8I6jCe?=
 =?us-ascii?Q?Yl+ACu38vC+vNUtd8doMKOV4LKpfRTUWyhm1QSZhAGmU9CCkeHDrkwedTzZv?=
 =?us-ascii?Q?vK/rFKzWpNM++PeadalY3pj/7DLfy3jchrLofOt6M9ZsMcEyJdQ+r0BDzTzl?=
 =?us-ascii?Q?GDHHfj7GrBwMtYK8zOdkHoPfgh6dFIa3Q06NHc8yAN++i5Hqe36NpqAXypnE?=
 =?us-ascii?Q?lABZbpuIli2NauuMnn6q7siB31+Qv7vk2r/nwxGW7xK1J4H/+5Skl5VxjEOH?=
 =?us-ascii?Q?Iy5Rf2dXXT8D0RWgAElYcu72jy0rqnHNOWi3iVk+sXVDzFcd0Vuo9f4qt7kD?=
 =?us-ascii?Q?HgrpnJnTg8ZUJ7FpSpF9p8fv/bCkPnA/cf9i6gulPt0NInbBRFz9HFVPCJLO?=
 =?us-ascii?Q?S+ddiD2k3Cn+A6Yiw8Hxmpz/gLRwYG/ka3bqjHlw63OtCFZOeCHbs82km434?=
 =?us-ascii?Q?OX8lKi9EHKPAjh8VCys40nHI+JswAzL18Wum1/IsMkVjqPyOfDKlYeYimw56?=
 =?us-ascii?Q?CXGA9MRJwm8Fl8Q39SyNWdKIgBQev6FWzRNTJKpcCXMvUQCVJs3ej9weUutV?=
 =?us-ascii?Q?iUcgyccqEWVKb0rHrOycQ14rRanogtVCdUIWRRLBXLuWFF8ivGWuX1+70UPB?=
 =?us-ascii?Q?DMJjdeMKTVc6qRtMX5H3j8rET+pnY3lKZzSYI6H65QdN4l3cTqJonNDLtrEq?=
 =?us-ascii?Q?nmqYa1b2L5C+7IqrvsTLPCJSLUqfHPgEkkZ2kxrgKT91IqPiAqqlY2CtCxQD?=
 =?us-ascii?Q?QGNCIjSGiIFATVDy61rEsUdpNy/ZzvB+l6zZKBbko10f7CwcAlFSFRD7BvFv?=
 =?us-ascii?Q?Z1P+tY92Hz8l9qrCFTlrl848msKc0WggEBDF3mQoTwvKbJO3r8DUiE4ul5oa?=
 =?us-ascii?Q?iQ6NBST8hms9yerqnI4sON+XZoAzw3OGyP3yW1RnuSPaiHsWLb7gUuNz8c3t?=
 =?us-ascii?Q?hlUttwloLkbFuC+pn+DOSjncwqrKSwuWAYbMjBhpbGXN3AGeeME/uKKhUpNA?=
 =?us-ascii?Q?BrfbsLAOJp2GhCfJQ9DMHUtaq+sU2GUOUXrHI8eJDRmE29w1ynMk5sZFuU1r?=
 =?us-ascii?Q?fvf9BCivP+ywMfxfeCtCRmq34Lino6QAM/GTW5sDD8FQj05oeNhkmHpGX/iZ?=
 =?us-ascii?Q?SWGhKp3oEMoSZSgTg2UofB8QQLzhjIHC/dXLPKgOVJrp6R+/nUDauivjdBQW?=
 =?us-ascii?Q?RmnjSVNKC6Y2lZos69OBTVYuacISadHMAEdCgAQ3mQ1cHo2ICRZ4FJyJDW4r?=
 =?us-ascii?Q?xrq88B0/MUkKRyu733rrOU6Lpa8K2919cqkl2Xq3RncEIzpG7AQwVc+ZjxOJ?=
 =?us-ascii?Q?s83Kb9HtaxdY6Xe8TH0=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 15:49:31.7966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e02bbb90-abd8-4e2c-6568-08de1c82e95d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8149
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
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
index 2e0d8d538b..58dfa64eb3 100644
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
index 976a436bd4..43d297698b 100644
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
+                              EVT_GET_SID(evt));
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
index 2e0b1f8f6f..bbe989d042 100644
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


