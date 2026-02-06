Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287DFEE20A6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 14:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voNBw-000354-SZ; Fri, 06 Feb 2026 09:52:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voNB9-0001kF-AB; Fri, 06 Feb 2026 09:51:28 -0500
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voNB1-0007Yl-Bb; Fri, 06 Feb 2026 09:51:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uuzO5Lf2MO0XysKaek5dVl4MfODBEyezxGqZvfNsj9+udaeC8lZLpsAc5BZ5d8XQ7ZPzEOmm/pI2+Ovm7mAVJRKf3vUAf4nnBIwfnnip/r+YJPV7CbBxD1MOmvsnz7CC+g20RtqwNzWVsVWEjtcmeN7MIMOoo/TSJFyn/R7sWUosbCM9NTqPIA8kKZpglq0U3pGGFFq9QnZx4rIAO2UcIYq9oDAeJlQIJTn2ZnbQztlNgyRKye3zJtoKi1XoCLy782LyFSuwcPPy6HcMIKVT6McWYMNN/VuJkC9dr2b/FyA71L/os6uXMWgLM4BN3tMjq8Ig7+5tiQzgtwdtzoOgjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKEaUG/TNwvdPTULNaQkD9fifgWQ4rm610vwU2XOBTQ=;
 b=nym/Ogo3/R2Md7HUEoAMwq3g7Edy0IbC2xoPPkO11OoDndUuRawLASp890t02ENKLY2I4SKxZ06FKf37aY1neA7mA3ndrD4qW23KhDhDS8H/iWw68rlWyGveiRyy9erBrWBmCZsIS8Px03/CBp2CNeMi4hxchgk485Xw8WvwvfdmYXkk+/tgIhyBkjJRL3UVCCNxCZDyfXSxFJjf21vIBC+mrlRkBiKEBujdqBdxgYW/0lvVTn3AJ077gpggVCXbLH0jOHP/Uy0LlYUWvV0a1atcimHKufEzi0Mno4dvD1pDcXqe+BicOsQIZl7OUM2lh/znr46BAz64ejOpJht01Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKEaUG/TNwvdPTULNaQkD9fifgWQ4rm610vwU2XOBTQ=;
 b=gDzgeMOObmn9iAJxorqg6Tn0FBuwbPgOG4VHMtX6KGfN5srYLF/dj0fPGay51TDGiaZxV4MeWu7UJ/v83Xma1D0x0oYIlLYfYsBnZuAaF4JqY7M3bnAjGQNnkuG7xITWc+YmI9fPH4PSO11T6/IBKEmGl9q6DpobARxMu3IzEhZ1MYURhrZv2bnv5Ra9u5Mc35fnpbpnluL15ewqLYikEwUPY05j/ghXk6DNWQMKXJaoBoKliZP55UOKWSsiO5Q1fO9emsyv95K5Ekf7b1Ncf9huUrsPi8FDnqovXOY+S60VaPZpD2ibE99O1c41WPkgoo0oLzSOZtXRejQ1SsDzxw==
Received: from BY5PR13CA0005.namprd13.prod.outlook.com (2603:10b6:a03:180::18)
 by MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Fri, 6 Feb
 2026 14:51:10 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::db) by BY5PR13CA0005.outlook.office365.com
 (2603:10b6:a03:180::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 14:51:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:51:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:50:43 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:50:39 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v2 24/24] hw/arm/smmuv3: Add tegra241-cmdqv property for
 SMMUv3 device
Date: Fri, 6 Feb 2026 14:48:23 +0000
Message-ID: <20260206144823.80655-25-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206144823.80655-1-skolothumtho@nvidia.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|MN0PR12MB6101:EE_
X-MS-Office365-Filtering-Correlation-Id: e771e090-57fd-48b8-3f0f-08de658f2a3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0RjTzAyZTF3REs3ak14Uys0bVRCbkJzSFFqVFhqT0hVM2hhY2l4SEQ5VzVt?=
 =?utf-8?B?R2RGQktRNURmckhQVUdwbkdWcUJFZmpzdncvaDVrSnFITGNyNUR0QlVZNDdI?=
 =?utf-8?B?QVBYZHhvRVlVZjQ5d2F2aGxOMzdwMGo0YTVsTTI1WGhNRHB2SzVkV2M2OHc5?=
 =?utf-8?B?c2ZtL0plcGFKRTNuaHpZNVpXZzFrVWx1Zk9JK2tZNTl1M1BSVTNiTHFiaGh2?=
 =?utf-8?B?MjlQWU9rMHo0MFRUdTRXUDJMeWY3VUZXR1E0eUxTOTlEVWE3ZzNtOGNJQXA4?=
 =?utf-8?B?dkJBaStrY1hnS1l6WjVDSVpDbWNDV2dEbktPVkkyUnkxTUF1RFpWdlRoU2Jl?=
 =?utf-8?B?MDkrL3ZCL2N2WlQ1K2Nsc0lzNVB0bUVaaitTYzZlTUVTRE5kaEY3eHRMNXRh?=
 =?utf-8?B?Q3h6b1NCVEFOVkoyQW9OT3FRQ3VYdm9oV0JVUVdxbFJlN2gwUzR3N3NGdURP?=
 =?utf-8?B?OElNTGxqT0JpQkpiZitxc0h2bzZpL0NHVEcyWW56V2REUWhMcXVXNCtqTnJv?=
 =?utf-8?B?MG52Wk01NVA1TFJlUlQ4V21xN01GVU15a2F5K0psT1JnYUtaWll4SDUzb3l5?=
 =?utf-8?B?K1MzMTJkQzdldjUweXVXckNZb3VKTHl4K3kwRVFpRzJwKzVyMDRIbDY1YWJE?=
 =?utf-8?B?bVpUUDF2TkRERnNjMzYvdDhWdCt1cXpFWWxDMTRSRTBQWGFTS3JSVGlhRTZ3?=
 =?utf-8?B?M05oem5MaFhRY09wM096eTl0bFdwRWcxMzFrNTVTS0dqQ3ZHcFNhVktTSmJY?=
 =?utf-8?B?d1lzbm9jcVg4NjlHM3RyU3J0YVR1N0xoWU1QdFZIa3htbHh6cDh1SmlGUldV?=
 =?utf-8?B?Z0ZKUVUrendwNU1rczgwNlFMdHFYUUduNzZYZzkvOEFrSW9jM1RwZXdHaVRK?=
 =?utf-8?B?elpieDBRN0F0Y1k2L1JINXZ6aDRVcEY0UjhQdU9SYmh3SlBEbmNXWlRVUzA5?=
 =?utf-8?B?czkzdkJ2SmRqdW1kSmR0V2Q1R0ovWE1SditHTnd1R040Q0JWdmw4VFY1NzE5?=
 =?utf-8?B?VlFxQjYzcHA5LzJGWGphdm85cm43OWRUTWNjRFJuOUdQN2RGYnl0TUI4K21o?=
 =?utf-8?B?cXRSeDVVWDNiVjZuVnZvTTE5RzNDNENZMHYyYW1KYmJiQU5nQWhodkRqdmFB?=
 =?utf-8?B?U1VGT0xnMDdLc2ZmYXhWRVA3Z094ZkphNFhacEVZT29YdUxlbEpNN0o1azVm?=
 =?utf-8?B?SFNwMGNiRVhhODlZRmxzSlQ3WHhKOXlZL1RqWUV1ZU45SzQyTnJiMDZ6T0dl?=
 =?utf-8?B?UEp6QmdGa3ZrckptMjNHWkRMR2ZkQWZ0QlBoajZPSEx4TTZTYlVXTTkyNldT?=
 =?utf-8?B?T0diUjdkVGNKRzl3L3lCTnpUVncwT1h3TkY2OXBjWVhzWkxxa2YveXZyeWNL?=
 =?utf-8?B?RHpBeUtrbDRPYzlTN1IxTnNUTUpTRmIrZCt3eGtXdE0yQS9SOFNHejNXcm1K?=
 =?utf-8?B?dTRqSm5ScTJOZTY1Y1U3aGRVWnFwc1NjeDl2M3k3NG5maWwrNUt1b2dIbjVS?=
 =?utf-8?B?TGtYQ2J0SjFkdWxxdUhVa3MvZlRtYlQweXVhR3pGclA4L29kdGFybGlheTcz?=
 =?utf-8?B?NHBaNDgrNkFiRzM0d3NhTW5RM3BwMXN3eXkzaGpNSGhZYjd1UnR5eXZadkIw?=
 =?utf-8?B?THRUTG9meEtRKzhRaThIb0lwZzVtMmUzcTVTT2VGL0ljMGRqYzFsa3l5Ym0r?=
 =?utf-8?B?QmZ0eHlkSUNUTEtqYTk0angzekZ6S0xySiszWURNZVRxQ0plSlVLY1dzeWM4?=
 =?utf-8?B?N3ZpU2tOdnBLQ1kxUHZhZlJzc3lkOVZkRGtkbUx6bnM4TzB3Ly9LbGg0K0pw?=
 =?utf-8?B?ZlZ0NzRLMHF3YmlTV0I0TmFockdQa0FGYTdzcG91cUJTZENnckJQTHdGdVJw?=
 =?utf-8?B?UXQxVDdKYU1ubnRZWG15MzBlZXZIOHg3OURYQlJBWUUxSGdEeW90OEZHaTVM?=
 =?utf-8?B?empobHVlSURHa002RVVNbS9YYjJJZUlyMk5tM1k3RDh5U3VqZ0J0T3ZFeVYx?=
 =?utf-8?B?b0xiQi9NQ1hybEttdk5PVkJ3Q3BtWlhlVDAyMWNWYmpydDJaZXROcnRoRmVW?=
 =?utf-8?B?ams2NHZFa0pBV3ZEdEFpdGhGWnA3NjRGUFduVkljWTVIb1dJd2dRVGpTOTBN?=
 =?utf-8?B?NnNHeHJoVmFkN004Z3NwL2RPSkdtY3VIT21XWFU5eTJlc3ZJRldpWFA1RDIv?=
 =?utf-8?B?SVpjN3hTMGdaLzFkT05YS0tUZFpmWmF2WnlnVkIycG9GVHZjSGcyMzU0cG0r?=
 =?utf-8?B?K0p5UnNScXdjQURxRmIrRkJsMVBnPT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6m2LuWIu4Fnl/6RnXXoBI9b8Wc99ZrMniBe0QTGKUIFHovVXelbF1cwS5IldpNgErgCrfzYPelObXV3IcEcNJdNixE/rV9/9Q6etzByU8Tn/mZg8JAxwVCSGFDsbRxXlxeJweVle+9VlKgJmfgCzraLEN2hasEqfzZZBknJ7qMlMN509NwnWnSB36namm7mLb3bc0O49UhiPpsaTbsNZLJjuCmOVchz8dNynhNoTz80gtB/kga69VzG9kd10f8eWpsUYoW+9M1BO4Jx2fn+7wr59Djjn4mOOgwoHWLCTDCtS0GRw5qiTutGfEfinyMab/lWLqB2NgWMVPukHDfPhxVGOd0YHNOKdlnOUvdOZttPIWKTvaieVI/vn+gYDckMWQDDaBKSKkbvzlnXDhosUABq32Lzwo7rbgu+Bqqj7Arb4T5A2+jnASD89REXqUl+2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:51:09.4514 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e771e090-57fd-48b8-3f0f-08de658f2a3a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6101
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

Introduce a “tegra241-cmdqv” property to enable Tegra241 CMDQV
support. This is only enabled for accelerated SMMUv3 devices.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 7f84c87a46..84dc5351d1 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1956,6 +1956,12 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
     }
 #endif
 
+#ifndef CONFIG_TEGRA241_CMDQV
+    if (s->tegra241_cmdqv) {
+        error_setg(errp, "tegra241_cmdqv=on support not compiled in");
+        return false;
+    }
+#endif
     if (!s->accel) {
         if (!s->ril) {
             error_setg(errp, "ril can only be disabled if accel=on");
@@ -1973,6 +1979,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             error_setg(errp, "ssidsize can only be set if accel=on");
             return false;
         }
+        if (s->tegra241_cmdqv) {
+            error_setg(errp, "tegra241_cmdqv can only be enabled if accel=on");
+            return false;
+        }
         return true;
     }
 
@@ -2123,6 +2133,7 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
     DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
     DEFINE_PROP_UINT8("ssidsize", SMMUv3State, ssidsize, 0),
+    DEFINE_PROP_BOOL("tegra241-cmdqv", SMMUv3State, tegra241_cmdqv, false),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2162,6 +2173,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "Valid range is 0-20, where 0 disables SubstreamID support. "
         "Defaults to 0. A value greater than 0 is required to enable "
         "PASID support.");
+    object_class_property_set_description(klass, "tegra241-cmdqv",
+        "Enable/disable Tegra241 CMDQ-Virtualisation support (for accel=on)");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
-- 
2.43.0


