Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5071C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 18:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicTv-0000Ta-Lt; Wed, 21 Jan 2026 12:59:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicT4-0007ZM-GI; Wed, 21 Jan 2026 12:58:12 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicT2-00029y-9G; Wed, 21 Jan 2026 12:58:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MXHUqOgXK4dJr3dhp5M/tuh1ccaj9cCmByZORpO7TvQFPQIkJcyb0WVDbVsz4M13b1N2GywHyA5Hk3npg8OfdArHEcvnAMo+u+7pZdYhMTbT7RlJI8OWDeK2UbVE8pfXMY14fHgqhTPzzerArHOHqNjtwt+ObNKwo2icF+TAuGvU23GuRv3TBjwOa/ItMvoJeSegpdXVYCy9LsdMfKFUNnX8yTAvPWNKAzzhYlbYOVM1mU4QdQqp22qp+cPyiKV76wqrdP9ng736Wo57ZU8MGEzPFYsfdty8C96GedvSmKnbz3ABbtGPOn/feLzJiKg/rjFXrhMMb11+mLUPl5a0oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ii8j999A3tds4SbfY5q1ANlB4mABjg7IBMHh4tl+MA=;
 b=w0ES0qUCvmtmduX4rZiNHk/73ZoNpWdehNRYA3ETfEtq8tTE6GHqv7IJ27a37K/Z9IbYpMG5nAeOZdMauygd7Om3VHkt9vLx4K+6Pzq5lBQ1lSECim19lel8lkO2zkK9s49DH+uk20HTErofSkX2PzHBm+8zFJqP77WN27uU0DKHBD5CqVCAeMgT2UNQhZKSoc/SE9jUnK6Vv7D1yeH/Qih5Au1XgV1vbGP5rztaCitto7fqTsm7uOdvviJxGTFMImsuu1jb0LwFBMIGgvExU49XBO1ZHTI93wkxjAIM1hWH9kTtPbOTe3LGVbPQr6zYWNM5qwqpv6y6Cdza/p8y+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ii8j999A3tds4SbfY5q1ANlB4mABjg7IBMHh4tl+MA=;
 b=rQQUr4UgM/i0zJsZrcdz5JWLFHhH7e8W6VkYgwwE8O8HlltveuJPZNZb5zip4u8ydJKRAZAjEXzMSMUdfu3bmNmhtFR/jN9pCIrwNxZlKxCN7qrOoQ/tmsnx91rznPgJGQaNQO5yuMkOYWNzfDUxh/OzOF7+nvrZvov2VTdlGdeycLubX7+1N1GlFOzDs1YqQoNdl+26m9jVkIEystEehIicn0F9DJipm3pr4pqhgd2+qPycIGKDaxJUNC4chu4bWcyOzi5YzjAWUtxJX34/JUSHhOl/a3QZK3E10CrRTNBTueUyKYpzEqKa1h2fD5P0bTEeyGO1u7l1NxMuT/5kQQ==
Received: from MN0P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::29)
 by IA0PR12MB7577.namprd12.prod.outlook.com (2603:10b6:208:43e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 17:58:01 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::d9) by MN0P220CA0001.outlook.office365.com
 (2603:10b6:208:52e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 17:57:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 17:58:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:57:37 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:57:32 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 29/37] hw/arm/smmuv3-accel: Add a property to specify RIL
 support
Date: Wed, 21 Jan 2026 17:52:34 +0000
Message-ID: <20260121175248.87649-30-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260121175248.87649-1-skolothumtho@nvidia.com>
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|IA0PR12MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: ec382778-83a7-403e-f117-08de59169e44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|7416014|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bTVsU3lYZ1FHUzFId043ZG9SM255bG5WeERDRFVrSTd2WnBLRVFHTVlFbGQ0?=
 =?utf-8?B?MzJhMzdOY2tWSDFaaHpSaUNjdi9BZW0ybzkvQ1RSeUE3RzQrbHdHRWY2bG1B?=
 =?utf-8?B?NDIzOUcyNndxaXRNeWhSejdOcmUzNENhRDZsRkhRM0hLc2NETitqd0RmeURH?=
 =?utf-8?B?NTR1WEEwTVVtZk9RaGx6S1JtNkdIbzJ2UkRnWGdNSFZMUExYS00vckZRNld4?=
 =?utf-8?B?MlNvb0lDN3JsRGdaaGd1RW9xYlYyNHlkeDhDdTQ5SjBIOXVOajkvUUFOL3BL?=
 =?utf-8?B?SkpyVjFTM1dNNlJkU2wvWVNabmdaV09iYW9yZGpoT2lSUXBMa1J0dTNLdkJ4?=
 =?utf-8?B?TzhlRDYrL3l3WGIzeE51Ymc4UkZXT0V1UlQ1VzdKSm5wN2JEL1N2M3pnKzJY?=
 =?utf-8?B?YnliVzN6WTJHTUN1NENxQWgraWVZTHFVZnNBcUdYT0hwY3dOMVF5Z3k2Z01n?=
 =?utf-8?B?Rk9SZUdJZS9meGN2My93QmhzcG9yNTMvRUorRE1ST3BSRFBoVGJZcUp4Z3B0?=
 =?utf-8?B?SEVjNi96Y1ZhcjhVaytNUGQydkNZNnJnOXJMdjVvdEpXck9IeEpOZE9GTjlq?=
 =?utf-8?B?U1QwK3RUdmZLMytudGxLdWNjUVBxenZvS0ZwbVRHWUdPbEswOGo4ZDNwZjFs?=
 =?utf-8?B?aDVGSG8vWG16L0tGdG9vTVpWQVdQcUdBcTYyYXFVaDhRTHovVEU3cFBDNTUv?=
 =?utf-8?B?NGhRY09MZWxlWStGVzA3ejYwSXl1WVM2YTNPbVdKdmxVcnVBcDErdEhTTjRv?=
 =?utf-8?B?R3JmQnU2cWlFcEdnY2gxVnJRb0tCcTAyVlNnL25va28zck9BQXJOZFZab1ZQ?=
 =?utf-8?B?NTMrMjFFZFplSTVWazhGQVhQdzZIb1dkZHVJSlVpQk0zSTJwYUpRYW8vcTlT?=
 =?utf-8?B?WE9TanJlbS8vc3pWWmZZT1M2Sm1LWWhwQ3paOEhTM3FTZGJ0ZE41UVpDL1hN?=
 =?utf-8?B?Q0pFd2dwTHJxTUgxTFVNeUk5dUNNWjhOUHB6Z1Y3cEgvTXhXRnU0MXJQWFdy?=
 =?utf-8?B?SFF1SmpPZlVaR0Q4YzhiU0Rvbm5CSzRFNm56RzZ1MnFjSHF1cFZFa0xVWHJS?=
 =?utf-8?B?QkVzYm8yQUFrQnBoL2dBWmwxNzluM01PZmcxZnYwZ0JDenRFRWpvQlNzNnRQ?=
 =?utf-8?B?UkVNNTJVMldQMUxPejNSQzdWZWplZWFtSEFnS1RsV1BqL1FzR0p4NWlPV0pG?=
 =?utf-8?B?RFNjNUNRVlBqZ3h5c05reGY0aUpCUkVBQVlzd0tkeTJtTllvZXBkTGRTZVhq?=
 =?utf-8?B?UU45a01FWUNpMm9wdXlVM3VSZ1pOb01sK3lpd0ZVd2lSTTQ1UVppdDJxUG9H?=
 =?utf-8?B?MDNFbENoR0YyOFBLYTZkM0kwRm9HVk5wbWx6M05Oem02Q1B3S0RzMnJvMnEw?=
 =?utf-8?B?Nk1iclkrakphMjZHQUdlSXpvc0dTUng5ZndXUnRjbTM4UlZNaTJCYjlJWS9o?=
 =?utf-8?B?bUlVazl1NW1XRS9RVDFlQ2hQdWFNT3E4ekFQQmJzeWQ0dTRtdllDVno2RTJ6?=
 =?utf-8?B?dkNYVDZYVnVVaitaZng5U2FBdW93ck10RHNsNzlaWDh1TUczMmFUVC9QblBz?=
 =?utf-8?B?NldLZ29VRDgyY2JvM0tNSkVxaGt6ZGRCT25FSU8wNUpwdkQ4ZGdPZnQ4ck5a?=
 =?utf-8?B?MHgxc2xrdHAzOU1wT2hTL2NZcjR5Z1J6L0kxcGFLVGdaNGhpMmhyOHRnUmlF?=
 =?utf-8?B?VjgxYXNNM2tTKzVUYlNMQXV4M0wzMGZXZVk4VkVTK2xPVjBtV1R4NXFVazh0?=
 =?utf-8?B?eXVBUC9sektIVHpOWGp3NjVNSkFLcjZtMTVDUVVwVytMbkJQdXdTZXc4UHFn?=
 =?utf-8?B?QVFDVkdrbjc1RU9Ocy8wdG5rR0VOMFIzdmJqQkhneHpBL0JEeVozU05ZRmEx?=
 =?utf-8?B?L09BaC9yTFRkRThJY3E1Q0JQNWVxQ3R2WXI0SUttN2VpRjNkSXVwSG55NjVE?=
 =?utf-8?B?Q0lOdXNmclk5VDhHSlJURkdBUFNQdXBHc1hlbjZkSExyTXYrd05HWEtVU1l6?=
 =?utf-8?B?RmFIZlY3MnBjVkExZ1Jvc1RIR0puMlBicmNWNmo5c1A5VTZFWDZ0SWJWV1Fa?=
 =?utf-8?B?ZGEwSmtEWGYvU0t6RkI5Q2lYL25yZCtjSjRYQllGTU15dTYvclk2QUxzdWRN?=
 =?utf-8?B?c04zZU01OWhQK3dJMisySklsY3F4elVmbGNPK081Q1pTY3RqSWk5dXhXQmp1?=
 =?utf-8?B?a3VBWHRnQXFrbGs1MzBrTTdzaDRvMDFmTzY1bkZlR1FkbWMwTFVINUEyUXhy?=
 =?utf-8?B?d05ZZ3pYSnVUWUM4dDZZRWE3OHpRPT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:58:01.0033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec382778-83a7-403e-f117-08de59169e44
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7577
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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


