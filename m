Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B19FCF65DB
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkK7x-0002OP-TA; Mon, 26 Jan 2026 05:47:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK7u-0001u4-2E; Mon, 26 Jan 2026 05:47:22 -0500
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK7s-0005kh-DB; Mon, 26 Jan 2026 05:47:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIB7Ob/QuPlnrRKo0L6z9MY0zmhlfG5FYzMClGA5XrZe/ZWo7BwzL9UUOghjSw/qfi25wneGKZmWGkyIgwRybvqcEkmLZiPLAMbUwo0F99rLdE+OsUaW6uBRwqOH1LvTnf42BXOYbpE2hD9JwxyluhzvehV7F8S1YZdh18KP/EVXT1OgenP5M386JXWO2Uecyvk0vsawTsgWEJeF+waF2bfIX1HgzEOM4xN5AByVJ0Yizn5R6nqoObGekTYy9Ke6qJq08NoBorpXHpKCjhTNUyDcxOjZ/r8CYMNe0I8MGRZSApMDZcz4KDr1GNMXWkc5GYlusfKMLzkgoykQf3ep/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ii8j999A3tds4SbfY5q1ANlB4mABjg7IBMHh4tl+MA=;
 b=rDx6wjlPSbhCBWP7LVbqNrwZ3jHY5zsDRaQ5PYwIhEIiLHPoL/R6YnPIhykZLJ8qQ7wsabI4A4N9hitQ77fA3go6YApQ5Sll1BZTQxVOKz55OpuS5GzHR3S2AMlQO0d14ikWnbyKT6stXaMWL/YIOT2ri9FTKRNr+BLTz7NpgrIIpBWqVoT1IHWupSaAuIcWamW6Z5MhnzpjezG+DsHB5dJzlKf2eXQQa8vmfU78qBdk3S4+TscAYu+Zo60rewlk1UA2xN8X9tyCpfcONsWyhHuzaE31Z+4KEluWjh1uWbVdhEt0hdi/TcEb/hz8L33ytgt1tqwWtPj2LrhwWFBp6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ii8j999A3tds4SbfY5q1ANlB4mABjg7IBMHh4tl+MA=;
 b=T0pLFYuZGsQc3MINR9qw+jouNtuAq1UDWk/HntHDUI/I2ydD+eTGnwr18R4ZQLtiS8OiphRd6hOo+oTwEjEiblj7xdgtGgTqjgWtyrmNm9EZNTlrGsYacZ6FjuapC+oapiPgAQi8/yI3YhT1csTT0ZvSIrTmfKg/xMPjf+kdX8V2fKg6yyYK2eK7hQEnoV4xSBUmjlc6V6Hm41TPp/hQ/E3xogtTbb6gjy3cXVkgMhIo2Wns3vQC2EYXmvC67xIhbaUzPfPQHxtTdYHW/febiC5t2g1CaQAdx3S1ZvAj5o/oc8YzE+R0jP9G2gOBOJ4+KlofmzJIGBgFTO73zMh9wg==
Received: from BL0PR01CA0004.prod.exchangelabs.com (2603:10b6:208:71::17) by
 SJ2PR12MB9140.namprd12.prod.outlook.com (2603:10b6:a03:55f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Mon, 26 Jan
 2026 10:47:12 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:71:cafe::33) by BL0PR01CA0004.outlook.office365.com
 (2603:10b6:208:71::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 10:46:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 10:47:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:46:55 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:46:50 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v9 29/37] hw/arm/smmuv3-accel: Add a property to specify RIL
 support
Date: Mon, 26 Jan 2026 10:43:26 +0000
Message-ID: <20260126104342.253965-30-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126104342.253965-1-skolothumtho@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|SJ2PR12MB9140:EE_
X-MS-Office365-Filtering-Correlation-Id: 84925fb7-1aa9-4435-ef8e-08de5cc84301
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bDBvcFNST3lGVGxRQ2FsUWtIbWhhclY5eVhJRE40MHR3SUhRRW5jNVViRURu?=
 =?utf-8?B?aXFSaDllYnFVMEFycDVLVkJEZkJ1aTFQTUpLNWVPbFBHTHBRZUlTakl1aTQ4?=
 =?utf-8?B?STh5OUwzWE05UlJRcXQzYm5IL21CWnhwaHJvZjNDUUNYQmF1d2tMK0JpUk5K?=
 =?utf-8?B?QlpOUUNwQk54MDdXdDlTaTNzNXZ4M1pEYzk0TUp6b0RmSzBwekV1dDhFN1RG?=
 =?utf-8?B?VHZxVUVRdExtMFV6YmdaWWFZVzU4anEvd2xiZnE5MlhSNFg4T2VSWlViVGpW?=
 =?utf-8?B?dmVSb1M3VlF2R25IaWpCU05hUlV3TjdiUDVuQ1RwTmY2MERPdURvRVVTam5z?=
 =?utf-8?B?YzNiaDlkeGYzZ0psVkhNaTNFamFzSHZJNUhsU1ZqRzY3eXBUcWtYcDlxbW8v?=
 =?utf-8?B?aUpyb3U3eUxKVWhDeUNtVDNuL0dnWmdRUXR6ZXJnaFRLSnozV1NjSGNyekNt?=
 =?utf-8?B?TjVmbWt3QUNOUlJXR0E4c1Ywd05sUGtsUU1uK2IrVnR0THRSTHhjVmVIcEpV?=
 =?utf-8?B?NHpSeUVrK1FqbjMzVklvSTNRV1hpSGlpNEwwZ3dPQk9aVWZNRWRjby9OTEdN?=
 =?utf-8?B?d1F6Skh0V3dJbDNSQnNxZXFYLzR2RGxMM1p5cTY5cXlZUUNzL3V1Qkc5bWtQ?=
 =?utf-8?B?bmo1UE4xSjlCblc1VlVjWGw0eWcvTzNwcE0wVWRjN2p5TTN2b2NKUHgvQ1RW?=
 =?utf-8?B?UEdPeTRYMFRLdWVpKzg5bU9QeFBpd0pZREx1bDk2QlRJdHYrZEZwVllNOGZo?=
 =?utf-8?B?MDNsc0FOZGRub2NCVzZ5L0FnYkw3TXlGQzhGc1Y1a00vM2R2SWVhZ1RNR3ZG?=
 =?utf-8?B?c25lc1ZBT2xFcXhmYVpJdGlsMWxvS0pjc2JoRXQxZkwwNUZZK1JvZE9sVGQ3?=
 =?utf-8?B?VWtIYWdUTkhFWjdCN3ZST09hWWtuZTRzZmZOUk1FajEvbmt1MEtUM1U4WTVr?=
 =?utf-8?B?ZDg3NzJub2J5dmtmbno1cXRPZ1pSR1V3SWlNK3V1YUgwSUdxMThXcVNVOFlo?=
 =?utf-8?B?RTJzd21MaGYvMG9CTG43dDc2Vk9IVlJRc0dOUHZCN3h0b0JaWjRrMXpGV1VK?=
 =?utf-8?B?TnFNdUJsOWVvbDcra2YrMXpOVXg5WGZ6UDA2NTFwV0ZRRkgzV1VvQzFGY3A0?=
 =?utf-8?B?dmk0Q1k2ZnRRVmpzakZBLzBDWVNTYlFHa2lsamZpMDdsclVJemdDUFkyZGli?=
 =?utf-8?B?UXl0TzFVaE1zR2ROMTdOdVFRR0t1M1dPeUxyNDU2bm5TU1pGeStTay9NRm5P?=
 =?utf-8?B?UkJvZjc4czkvTlkwczZ6NVNlU01mUXJuVnR4OHlxck96NkNnRXcyOHM0MTE5?=
 =?utf-8?B?L2x2ZDAyK0J5cTE4Zm1GMlE4UVJlZ1ZvcjRBa2hjWkF1NzB0bXRkQldRZUFR?=
 =?utf-8?B?cFJzK0VzRUdObUpwSDVTb2Q3R0poenBnZGtoejZ2L25VN0ozVGN2L1VwK01D?=
 =?utf-8?B?S1dlYkhhNUlJMGZIVW5tWll5Zk1QTjN4TlpWSS9JR29mSm5kNHhqeXU1L0Vv?=
 =?utf-8?B?ZkpUY2pXZGEvbTJxc0ovRHpVVExTQktISUd1cXVtWnl1ZnNxM3QzVEgwZGRm?=
 =?utf-8?B?OW5OMTZwSlFacThlSXNLd05xZjkwaTlqUTBmQWdxV3l2bmpQQWJUMFkyanBF?=
 =?utf-8?B?SDRvVUhQajBrMkxWUTIxS2ltZzZiSzVzaU94bGdKQVA5VUtRQzJOL3I2bWpQ?=
 =?utf-8?B?Q1gzYjlOV2NpOHA2aVFvMllYSlFST3pnajNpL1duR2xjdnhsZGJOM1dHOGEx?=
 =?utf-8?B?N1Y0MlRrV0VZSm12eUdhaDlENlBxdUozcjFQc3NGSTlXSC9HYWpyTTdrMi9H?=
 =?utf-8?B?aGRzNzNheDMrOXhxbE1pa1g1Uk03blE0QlJKT1grWGpQcHFuWkNXOXg1UkZ0?=
 =?utf-8?B?ZVlKa1JvZU91dkdLRk1vaWJYYmJpenRySlBPQmhUY0xOZ3RXRkpsbWJ4Szd3?=
 =?utf-8?B?MzNpcXRzWWxQOEZ3ZjRWSnJET0wyMTFPUHQyNERibTNSdHg0dTh4WnEyL1A2?=
 =?utf-8?B?Tlhpcy9BVmtwRU1JRVVocExMbGZjRitxR2dOakE1WGRNdC95UGE0TStVa1E1?=
 =?utf-8?B?Y2NFdmp0V1VlcFJESEhnaURYei9jKzVWWjEyZVpSaU4rU001emladVZnUVBG?=
 =?utf-8?B?czFhUnB2WkNxcEJDbi9tQ2N4ZWtHQnNhSTlkcmJyTjRTelNQbkU2M1R5U2Nr?=
 =?utf-8?B?dnJDcGJWS0FxYUZhSVNBUXdFUTNQTEl6YXF0Zm05a1lacjhrRzdFS2N6RWov?=
 =?utf-8?B?bDB2aVB3eFRPZ0pUU3RBQmdpMFpBPT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:47:11.8812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84925fb7-1aa9-4435-ef8e-08de5cc84301
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9140
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
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

Currently QEMU SMMUv3 has RIL support by default. But if accelerated mode
is enabled, RIL has to be compatible with host SMMUv3 support.

Add a property so that the user can specify this.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c   | 14 ++++++++++++--
 hw/arm/smmuv3-accel.h   |  4 ++++
 hw/arm/smmuv3.c         |  9 +++++++++
 include/hw/arm/smmuv3.h |  1 +
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 33011962e3..df82f1e32a 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -68,8 +68,8 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
         return false;
     }
 
-    /* QEMU SMMUv3 supports Range Invalidation by default */
-    if (FIELD_EX32(info->idr[3], IDR3, RIL) !=
+    /* User can disable QEMU SMMUv3 Range Invalidation support */
+    if (FIELD_EX32(info->idr[3], IDR3, RIL) <
                 FIELD_EX32(s->idr[3], IDR3, RIL)) {
         error_setg(errp, "Host SMMUv3 doesn't support Range Invalidation");
         return false;
@@ -646,6 +646,16 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
     .get_msi_direct_gpa = smmuv3_accel_get_msi_gpa,
 };
 
+void smmuv3_accel_idr_override(SMMUv3State *s)
+{
+    if (!s->accel) {
+        return;
+    }
+
+    /* By default QEMU SMMUv3 has RIL. Update IDR3 if user has disabled it */
+    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, s->ril);
+}
+
 /* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
 bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
 {
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 41b37e3122..a8a64802ec 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -49,6 +49,7 @@ bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
 bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp);
 bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
                                 Error **errp);
+void smmuv3_accel_idr_override(SMMUv3State *s);
 void smmuv3_accel_reset(SMMUv3State *s);
 #else
 static inline void smmuv3_accel_init(SMMUv3State *s)
@@ -76,6 +77,9 @@ smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
 {
     return true;
 }
+static inline void smmuv3_accel_idr_override(SMMUv3State *s)
+{
+}
 static inline void smmuv3_accel_reset(SMMUv3State *s)
 {
 }
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 8ca1d4ad35..cb619f19df 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -305,6 +305,7 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, 1);
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN64K, 1);
     s->aidr = 0x1;
+    smmuv3_accel_idr_override(s);
 }
 
 static void smmuv3_reset(SMMUv3State *s)
@@ -1926,6 +1927,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
 #endif
 
     if (!s->accel) {
+        if (!s->ril) {
+            error_setg(errp, "ril can only be disabled if accel=on");
+            return false;
+        }
         return true;
     }
 
@@ -2059,6 +2064,8 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_BOOL("accel", SMMUv3State, accel, false),
     /* GPA of MSI doorbell, for SMMUv3 accel use. */
     DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
+    /* RIL can be turned off for accel cases */
+    DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2084,6 +2091,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
     object_class_property_set_description(klass, "accel",
         "Enable SMMUv3 accelerator support. Allows host SMMUv3 to be "
         "configured in nested mode for vfio-pci dev assignment");
+    object_class_property_set_description(klass, "ril",
+        "Disable range invalidation support (for accel=on)");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 9c39acd5ca..533a2182e8 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -69,6 +69,7 @@ struct SMMUv3State {
     struct SMMUv3AccelState *s_accel;
     uint64_t msi_gpa;
     Error *migration_blocker;
+    bool ril;
 };
 
 typedef enum {
-- 
2.43.0


