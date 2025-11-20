Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDE2CF885A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 13:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4fa-0002RX-B7; Thu, 20 Nov 2025 08:25:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4fU-00021S-Mn; Thu, 20 Nov 2025 08:25:48 -0500
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4fS-0002fO-Tr; Thu, 20 Nov 2025 08:25:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yfTkFmgWu93Ut8qxpvKGuTMlRJFC9hVLUQB6+8LGnU1GUWL/EHyA/fXMweQCN4imIw35BQpe4jg4WHIft66CD/H8nFMJyylkEYx72yzgKZiJdR00Xk4JIFlRKkeq9gVmnFqNHGafVAU1cJCaNDuFrkirzJIrNw+roZya7p/1RCBMOSi03whvN5U82q9R5cQw8cuaYUbt0RtJlhaRupN/GWBfV7LkAMwZxWgKXeFHYF2Hr2IpqW7xV1OipLPu1ISnSaDkKFu2TkgIe5NMpTAC+hzu1/ApsehFJf1/3RXhu+XC+kC4xgGjpzVhIGJDQbdliyhhTkgqwPYSFF+m0cw5qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrFzw50ruNkrL91oJWkKJk0KIo9sEe46S7OSt/rxrkw=;
 b=aD8WWrqq/xdwc0Ab6jUncPBr7KScptOi7w3037rqRyogkAQvaPsGNl/0S60BxqzS8K6JuAZazLkqvs1deXxVohew3ZUXFZRsRU2y0zkiIO4cmVHmP6Rh0dMkWKNJrvm9PaW2dMvIqhf057HxTEo5vqmp+9uE+2eMepZpVe2gfiWW0E234RaonNVWdWcFaF+EDGkhXuNjia1JXPYMIu8x5ehYOcE53A9yrJC7uT+n94rSHPO3XMmORGdSSKhcUnF25TCxfL3jbWmp4up7oo1H4FLXilqfImbFbOjvC33pihp0jtU0WLi/QFlOvf3jH0ep3795dBEhRTXBy+Fx/vtFuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrFzw50ruNkrL91oJWkKJk0KIo9sEe46S7OSt/rxrkw=;
 b=ms7wJwctcWyHVIvDZ4NxcBieoR6bcaWDJRinVCC16ffcPS0Ro6mxJj7K/z2ZiHWuzRPfHIz0Nvu+SOwhWjcOyj8WddpR8deb2R8ktqzPl37X+kkIX4dy0umJR+ZawcKMkO18L2q1WDbQiC8QRwwGu/uuKdh2vRvG5ai+NEJo2xK07Kpsxo6/na4XJrCw4G3KZCBniDCZSJ991oVFZSIX07AOcNJa/8ZXeQrfp7Rq+CzOeA9TCSGdbn+dEdH7QqcucrsXx2k+OWg31Kq3pJD2RCUCIHzqJ76DC5g8zr1xzDijZGX4AHw4lwIwDG1YtPyydNPlwKap18s1Lyo47gXi3w==
Received: from SJ0PR03CA0342.namprd03.prod.outlook.com (2603:10b6:a03:39c::17)
 by LV8PR12MB9270.namprd12.prod.outlook.com (2603:10b6:408:205::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 13:25:37 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:39c:cafe::51) by SJ0PR03CA0342.outlook.office365.com
 (2603:10b6:a03:39c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 13:25:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:25:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:25:15 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:25:11 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v6 27/33] hw/arm/smmuv3-accel: Add a property to specify RIL
 support
Date: Thu, 20 Nov 2025 13:22:07 +0000
Message-ID: <20251120132213.56581-28-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120132213.56581-1-skolothumtho@nvidia.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|LV8PR12MB9270:EE_
X-MS-Office365-Filtering-Correlation-Id: 48c446c8-ffd7-4eb4-7c04-08de28384a9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|7416014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U051T3dqS3VrY2p5WnNCZTE3SE9MMWFraC9xSFVKTEp1YzFGaTg3dk9ZR2FD?=
 =?utf-8?B?aGxES0dwQmZVZ1RBeDZhVzJpUUpkOGVHeStQMi9pZGg2amt3ZUhRNXJ6NEJi?=
 =?utf-8?B?UUlHTE5abHE2bE9TTTRxcUw4SVpzRXRuVmtYZllIYk85WTZLUHhOSHEzWFBw?=
 =?utf-8?B?M2NMYVNsYnV2WU1wemFib2tGVUdFcVkwcnlhUzV6RlVKV3BBclN5TFEvWGgw?=
 =?utf-8?B?RlVQc2N3QVpQem9MdWthTWdXeFlvc1kzdEtNdFRGQlIrOGFQMzkvaWw3K2ha?=
 =?utf-8?B?ckhKYzJCVTlBVUl5SkJTdjZPWHdpMFBOUjI4YWNJaDBXTDArYTFxSFliSGRp?=
 =?utf-8?B?RzBwMVdRejQ0YzNCQk1manlvTThMcnh1N0RZdk0rSXpNZnA1bzQ5WkVzS1Bv?=
 =?utf-8?B?QWdYV0RlRW9LeWJwWHA2OHdqSlVQRzB4a2psMXovNVF5dWV2Nkl1ZStvNEtL?=
 =?utf-8?B?cUhnd2pyeEpIS1BBK1c3dXZtVWpVQ3hMMWsyTEU5ZStoTTdZSUxGbnhIejkx?=
 =?utf-8?B?VDhZbDBGemYzOUNGUDVQbEZXUVNJTGJnM0ZTQ2VyNE1OekVPYmFpWWsxSm5v?=
 =?utf-8?B?aFdVL0J4RDlnNFpCQ0ExNEdjZFFtUlZIUjRUbDlZZ3dScEVxQ3NXTW8rV29C?=
 =?utf-8?B?QktpNUdKK05RSWhTUGtrWDBzUTZjRW1sSkFGOWM3ZHg0YlI1T0NGdy9WbUg0?=
 =?utf-8?B?OTFqMnFOakhVL2owaEpyT3pYNlJTWnhpRDRwcmpHYjZFRmU0YmE4c2dJUGh6?=
 =?utf-8?B?QUQrMkxZOVd3NjhiZ1h0cFB5RkFOZEt2TWNXaER4RlNvYkh2bnVCOFA3SWNl?=
 =?utf-8?B?VWE4RVdCdXdUdWEzc0xHRVY3QWxBanRSaytqVkVYUURQbU1vcGg4dFVDaVEw?=
 =?utf-8?B?NzNNaUR3VGw5bXY1ZkdJSVhrVzJjWnhKQnZIbDlKTjVhVFhtdkVSYXZGeCt4?=
 =?utf-8?B?UUtSdTJQQndySFQ4SUZPYkd1bHBhUUhxTjlYaFVWMlYrMHJicEhWemJlUWNx?=
 =?utf-8?B?OERZMzNJNVYvZUk4TW9UQTNnYzBtSklKaFNqOTM2eitqdlVCWVJYaUlKY1RS?=
 =?utf-8?B?b1EwSFVTSU9WdUs5VmFtUURLamhjckZGNVV0ajZJNU51M3BzTVR2WkYrUjdv?=
 =?utf-8?B?Tkc2cVpPQ21XbnNMVzNOT0Q4UEp6MSt3TC9yVmZ0S1AydXVuOG1Sdy9ubDlq?=
 =?utf-8?B?QmdMVWVhMkJIclhXaElzQ2JhUmZ5RU92RlBUTHNTYW9xdjI3VE5hMmQzVzhm?=
 =?utf-8?B?R0phWUQxSC9OblZPNm5TcklqWEMzSlBjT3FxWWxBcmxyVThMUHlnN2N6eDQw?=
 =?utf-8?B?QThHSjg3eHFtQ0FTRHdXOVpIRTB2VEVhR0V1V1NBQmk1eWtkaXFrTnVwOWhp?=
 =?utf-8?B?MTZIUmowRmZRT3l1WGxtd2JGblQ4QkJ6b2wvSkpaS2NoUXMvM2Vabit2djAy?=
 =?utf-8?B?TWx1WHlrUGZ4OEZYWXNaaGlSN0hjTlNLMVV2QThuTUIxcTIrYzA3V0NTTHVG?=
 =?utf-8?B?d1ZOSDQyNG5NdzAzQkVoYTlqczhxT1FQTUU5U3lIdjhzeWs3d0pWNE1DVTlq?=
 =?utf-8?B?aHkxaTJFWThTOWxiOGR5MEU5RUJENlFJbEtiaW01aDFXRmV2bStObjlxNVVm?=
 =?utf-8?B?NWNUS3AxN25qQUZIQk4yY1RXaFZwUG13Tk5FMmhkZXVwRUhNR3Z4YS9Vd1N3?=
 =?utf-8?B?OWpIM2JyWWlpOU1wNnNZeEw0UVpXenNpQnk5UHJEM2lIZUlSajR5ZDBYcGdl?=
 =?utf-8?B?clJhSmorYnAxMjl5QTdTOVUySmN3ZVNvaXBBWXg4Rnd1dkkrTTN4OS9UVTRm?=
 =?utf-8?B?bHZjK0ticTFGUWF1alZsK0lrU2JjcEpjZVFtb0JVZ0tzWXpPSWNVQzUvK3dq?=
 =?utf-8?B?dVp6YXljQnpMcjhrdXV6dXVLMEZ0U0tIMldsclFJQnZDd2lDbmpCRlAzMXA5?=
 =?utf-8?B?eW1wc3RPeFp0aFFSVm9tZXVoRC9xM3ZJVGlmT2tBNUw5SkUwTVgveStESCth?=
 =?utf-8?B?aU9lclF3UkNGa3BrMk90OExPRkF2d0F2cm1qaE55Vm5peUFhRGs4SzBYMmhB?=
 =?utf-8?B?WU96YXlVUjIzaExoVWFTckhVa0x1SWxoVU5JeDkxU1NQNVZYWGIvVEEraGZp?=
 =?utf-8?Q?kB6o=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:25:36.7337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c446c8-ffd7-4eb4-7c04-08de28384a9d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9270
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

Currently QEMU SMMUv3 has RIL support by default. But if accelerated mode
is enabled, RIL has to be compatible with host SMMUv3 support.

Add a property so that the user can specify this.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c   | 14 ++++++++++++--
 hw/arm/smmuv3-accel.h   |  4 ++++
 hw/arm/smmuv3.c         | 12 ++++++++++++
 include/hw/arm/smmuv3.h |  1 +
 4 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index aae7840c40..b6429c8b42 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -62,8 +62,8 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
         return false;
     }
 
-    /* QEMU SMMUv3 supports Range Invalidation by default */
-    if (FIELD_EX32(info->idr[3], IDR3, RIL) !=
+    /* User can disable QEMU SMMUv3 Range Invalidation support */
+    if (FIELD_EX32(info->idr[3], IDR3, RIL) >
                 FIELD_EX32(s->idr[3], IDR3, RIL)) {
         error_setg(errp, "Host SMMUv3 doesn't support Range Invalidation");
         return false;
@@ -639,6 +639,16 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
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
index 7186817264..2f2904d86b 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -47,6 +47,7 @@ bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
 bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp);
 bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
                                 Error **errp);
+void smmuv3_accel_idr_override(SMMUv3State *s);
 void smmuv3_accel_reset(SMMUv3State *s);
 #else
 static inline void smmuv3_accel_init(SMMUv3State *s)
@@ -74,6 +75,9 @@ smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
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
index 8352dd5757..296afbe503 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -305,6 +305,7 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, 1);
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN64K, 1);
     s->aidr = 0x1;
+    smmuv3_accel_idr_override(s);
 }
 
 static void smmuv3_reset(SMMUv3State *s)
@@ -1924,6 +1925,13 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
         return false;
     }
 #endif
+    if (!s->accel) {
+        if (!s->ril) {
+            error_setg(errp, "ril can only be disabled if accel=on");
+            return false;
+        }
+        return true;
+    }
     return true;
 }
 
@@ -2047,6 +2055,8 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_BOOL("accel", SMMUv3State, accel, false),
     /* GPA of MSI doorbell, for SMMUv3 accel use. */
     DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
+    /* RIL can be turned off for accel cases */
+    DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2072,6 +2082,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
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


