Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0312DD3C90A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTKQD-0007ws-Ll; Wed, 10 Dec 2025 08:40:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTKPv-0007hK-6Z; Wed, 10 Dec 2025 08:39:43 -0500
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTKPs-0001Ss-78; Wed, 10 Dec 2025 08:39:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFhisAL7O/+EDKMaiNBeDyG1USjjI2WyBJGA8y2xaLFuN9IvA00dmB8lrgZjk8hVxDIzgw9A/GvU3GxlYKLh+lWA4S1XxDVVour2SgYbwyqHWVAUjlNjgKxJwPAo8KTwIYBWVzJp4RoDBsTfz0SLfW2V6o10YHeT+Eprv2oLTZtb9mZwBFFGAjvDwmxmG5ryGgv8QUSYtY3x37RgIbV2Vfjg6JkOQNkLm3O6tVfOSZr4ql89ZrSlgsp+LvFPV2ZjoSLiiJbitGxOeXsYfS7KTeJYgZ86g6Luf+mpSD3gMz/JusWI558lO0eoSmd/uhmlJdqq3XWzkww3ELhAOjZtPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBsByYqOh5Lq6NJTlVHkkUFV6ULfIDML0Aiid/GVCjI=;
 b=c5kzyAisoYzq+X7/uhBkcTqohQXI17pKeTFyVq6g05dDzvekXlEWphLHQKDv6ZeCkj5VUG/yw2odrYnX/inPXB8thoo45YbCfN4QCrLaMYqOF10abRUE71SjXovVbRd4zKL8XdnKN0La7WKOufi1Km17dGnsDk5xr3tRYdkiuGAJg5ZJi/h+3NRDggwBiV2oTgnLHbHdU6ilQdJAM82QiUqVR53imkrwWvzI5gzsR5RuWAEzD1KaxknRLH9CBXkbIYrDf4uZehWFmirQmqOHy3UlBS/BOZD5QhkPfuHrTwvQncRBYcbbwTFQfNXECFl62k2lUOtVjwRP9drMii1oAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBsByYqOh5Lq6NJTlVHkkUFV6ULfIDML0Aiid/GVCjI=;
 b=XeQwCKoCe3Wr4BKn4meAWj/YednmXXsmCG6njsxNcgPC7hDVQkMjDcE+RVz2LdiCB+f0PEU9WZnrMQ/Bpa8WtwJ3ceQ3oTmqJwOu1z+Dt7bxBWEzg2bIuYO8O1qHybHxkJp2OTOrlf/B5r2lDyLDSTeViQNMTEv7FTum+RqSWjQ10WqEw4dEkNsvnrzMTcpCSvMksbr3ah/3tmrCpXEkoRaA9hnBeSkAags3JuADPBNpP6m9xdMttBhiEKkQrHQ8/frl00vsoBJWr2Skx87r+Zapz7SjGI25SN8qP6hXhYZC2LOinaNuK+Ofyo/chyNUiLoTk+uo92riNqD9L3WGJw==
Received: from BY5PR17CA0006.namprd17.prod.outlook.com (2603:10b6:a03:1b8::19)
 by IA0PR12MB8424.namprd12.prod.outlook.com (2603:10b6:208:40c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Wed, 10 Dec
 2025 13:39:34 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::a3) by BY5PR17CA0006.outlook.office365.com
 (2603:10b6:a03:1b8::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.8 via Frontend Transport; Wed,
 10 Dec 2025 13:39:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Wed, 10 Dec 2025 13:39:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:39:17 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:39:14 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: [RFC PATCH 16/16] hw/arm/smmuv3: Add tegra241-cmdqv property for
 SMMUv3 device
Date: Wed, 10 Dec 2025 13:37:37 +0000
Message-ID: <20251210133737.78257-17-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251210133737.78257-1-skolothumtho@nvidia.com>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|IA0PR12MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: d908f1a5-b0d7-4bee-abc1-08de37f18dbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHA1ZWQwcTJDcUN5bmhYMTlZekJMT1h6bTh0WkJCbDJGUWhVdXVBKzNjOGxM?=
 =?utf-8?B?U080V0RGRnh3S3I0dG5LMitqQVhXS29ETzlaYnlXT2U1am1IWVl4TlVoc3lt?=
 =?utf-8?B?Vmgzb0lodWNjd1JNSzQreC9JNnRwb3ZQUURIVVRWWU1ySGVKUk5YbUZTcEpV?=
 =?utf-8?B?eFQwUnZGQVlZTTJGejR3cTliZHBqM2I1dnpJYWcvekRBUWF5UDBBOXRlTkRy?=
 =?utf-8?B?L1VFOGdWZmVwbzI3Y1c3NkZFZVc1L0FoL0tpNkR0TE1taUNBQld0RlhPeFB2?=
 =?utf-8?B?R0ZodlowUVRpNlc3dWE0NXAyWmphT1NhQzRmc3Z2T2g2aEJVY2dGUm9CeGRC?=
 =?utf-8?B?MnM2OFZCeUJXSmJOQmt2WVhiRkZFemV4azBwUXJJSmVSeXBWd0s5M3Q2SkZi?=
 =?utf-8?B?aktXalhTV1UvRjY5bHRhV3hmS0MxQmIzakllckh3bU1paDRXdER1bGlNYndB?=
 =?utf-8?B?VDRSQkJ1RjBuUWVzTy9YVko0Y25HalUzQkkyZDBvSjdUSFE0YUVnTUluNFpn?=
 =?utf-8?B?azVZZ2s2UWN5SFdhdzdjc283Z2ljT1AvaUFKY1NObVpyYVRLQmt4aFVuTGp0?=
 =?utf-8?B?VTdGMExENmRFdTdIMSttMURlSC9OTkc3QVluQVlmNERuWkxDOGdWRnIyUVI1?=
 =?utf-8?B?c1l2MC9UYWdlOFJxZXZCVUFra0F6TjJjdjgxcXVHZXo1Y2xUVnNpUFFscWxp?=
 =?utf-8?B?WTBhRnh3L2daOEdBZTZXYk1PaVdKOSt4Mnlzakk1dTB1QUY5ZzhEZFA1Tm5K?=
 =?utf-8?B?U3VRdzU0anMyUTdYWWdyWEpNakhOMnlISVZSd1NUV3BaRkwxeXpjYjdpZStx?=
 =?utf-8?B?NFEyalYzNU9EMWpJbHF1eXZoWkFVTUJHNzYwMVhhTEIrV0xma3p5OWxmZlBF?=
 =?utf-8?B?alZWek1jUkFhRksxZGplYURReEJjbDMrbHhXVDhFYzlDTEpXelR5MUQ1ZENX?=
 =?utf-8?B?T0k5SXJIdFR6WGJRcXZJa2llakQ1NlNSVFV2eElON0crSmJsbUwweDdualpl?=
 =?utf-8?B?TG9TSlJlcnVZRlpoNkRZM1k4amNnMmNVUVF0QU5yWjAxM1NxVTdoZkNPeDJ1?=
 =?utf-8?B?U3ljcFhXU2NxQkxGbi92ajNteFR5a0l0N3lLMjlRQUZrak53NXB6dnl0Z0lL?=
 =?utf-8?B?OU1CVmgwUlNNdlBJM0pURGgwUERpNFY3dnphZHRTSFhlMVVTRkdjaUYrelQ2?=
 =?utf-8?B?Z2RBL1lqdzRwTjRYTU5rZU4wQXJ3NUUxL0Nhejh3dzV2TU9qNlFjNG9aOTds?=
 =?utf-8?B?bHRvNEc3V3lEalBxNWhmWGZrWXkxdEhqQzhDVDNwV0ZiOUg3QVBacDc0Uksr?=
 =?utf-8?B?dm90d1ZpUTJRWUtxa0VLbHNOdUJ2TUJjbnUwRStFem1Ib0JUaEFjQWROUDdt?=
 =?utf-8?B?bmlZR0V4aDRONU05NTN3eGd5SzdFRGdqVFArTWJ3NmdGenZDVlJhLzVSbkox?=
 =?utf-8?B?TVpOVWtWeGNRdlEwUW5zOXZsZDFXVWxCZXl3QlF5ZUV6VW9oZDBUYmZOUTdk?=
 =?utf-8?B?cllZeS9adTdvUlkzN28ybUJ2T05RelhsYzJnNkcrZUtzZ2RkaDlGZDdhN1NH?=
 =?utf-8?B?bDJITVJWcHZHNUhTR0tGUmJjRXNxdDFXVUZNeTIyclBrQVRJd1oza0RFeVIv?=
 =?utf-8?B?ZG5ZUTEvY1pQSGpCbmoyNXE3aENpeFNOS0laWWtLSThxQ3pPNFZLaGNpaXhZ?=
 =?utf-8?B?REdhOWpZMWJQcWRaMUp3a0VmaU15ODNOMGREWVhkQkUzK3pRUHM0eWE1SSs5?=
 =?utf-8?B?THVFSzdZTDFFdURqdllvbW5tZUp3bWZpeWVlSEhWb09UN1Blc29BVmRQTHd2?=
 =?utf-8?B?UDdDeUtlaHZZb2ZISWFpTTV3c00wZXlLL2dnR3Y2TXk1YndEbk8rQ1hGVDB6?=
 =?utf-8?B?NkUxY3FRVHJIQU1qdjlzU1UyUmIrdGQ5Vkw3RjJ4enFSSXdVM1RDT3VzbUVi?=
 =?utf-8?B?aHo4Y3VpZzF6UzJrSUVUZkVOOHlvN3B5VmFJUktwSk9DSHFiaFgzWEVGYUZJ?=
 =?utf-8?B?aVNOd2EzY3NBYkNiN1VBWDZ1cHBkc1lFcU9hYnNRVm9uVHRrNTlFODk0cElN?=
 =?utf-8?B?QmNxS3lqT0tIbEI0TzF2NVVsU2sxYUdiWndOc0huWXovalV3ekpPME5vaUZm?=
 =?utf-8?Q?Bpyg=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 13:39:33.6885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d908f1a5-b0d7-4bee-abc1-08de37f18dbe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8424
Received-SPF: softfail client-ip=2a01:111:f403:c111::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
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

Introduce a “tegra241-cmdqv” property to enable Tegra241 CMDQV
support. This is only enabled for accelerated SMMUv3 devices.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index ec8687d39a..58c35c2af3 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1953,6 +1953,12 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
         error_setg(errp, "accel=on support not compiled in");
         return false;
     }
+#endif
+#ifndef CONFIG_TEGRA241_CMDQ
+    if (s->tegra241_cmdqv) {
+        error_setg(errp, "tegra241_cmdqv=on support not compiled in");
+        return false;
+    }
 #endif
     if (!s->accel) {
         if (!s->ril) {
@@ -1971,6 +1977,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             error_setg(errp, "pasid can only be enabled if accel=on");
             return false;
         }
+        if (s->tegra241_cmdqv) {
+            error_setg(errp, "tegra241_cmdqv can only be enabled if accel=on");
+            return false;
+        }
         return true;
     }
 
@@ -2109,6 +2119,7 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
     DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
     DEFINE_PROP_BOOL("pasid", SMMUv3State, pasid, false),
+    DEFINE_PROP_BOOL("tegra241-cmdqv", SMMUv3State, tegra241_cmdqv, false),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2144,6 +2155,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "are 44 or 48 bits. Defaults to 44 bits");
     object_class_property_set_description(klass, "pasid",
         "Enable/disable PASID support (for accel=on)");
+    object_class_property_set_description(klass, "tegra241-cmdqv",
+        "Enable/disable Tegra241 CMDQ-Virtualisation support (for accel=on)");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
-- 
2.43.0


