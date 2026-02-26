Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF35FC592C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvZ0Q-0008Cs-92; Thu, 26 Feb 2026 05:54:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvZ0O-00081F-2a; Thu, 26 Feb 2026 05:54:04 -0500
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvZ0M-00017Z-J8; Thu, 26 Feb 2026 05:54:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVkxUYsZqttR6k48W+6PQsLitfDFsaWwLNFvjC3I+GXMhiVLiu15y0cuyq+Q80jDAuvcs+YOKKAq3Lz37lOQBuJiO399VUJL/QAJBQ8KOa9PdGqPhOcZQILcA6kI8GJEdsy2jN21N9QrGG3Rj+2UMgh5IqM0N5+6o+rVeB1Voj+JhXSCUkDLGKb+8viM+oK8JqbSlij1KVMi14KHghjWQHsMxCZGelDzySzzWvJX81Vr2t5/6XbDpRUTPEI1LT9RxdVB7jF/ZTetqlvqbmFb6P1EAaJ4dg364c+27UXjnhCgED6N68N5sgVnrv2mtkO2lfPNCYfm3bzCR8+G7XymQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6zcL8egW8OBg5Hzxr3z7eDDsDzF6ejiccc7ySyLxUU=;
 b=xo3WBEqFcgZnvGleN0xiuhmij4h6m6NEWVwqpCvtO05Fr1/rYWQWXet3zVX+T4enJxApJWmih7fE5DdS6VXeKfAwdOO14K7tWRjQvEjVJH4LwwxlF0zEtI5U08XdI5kvqvukCOEKAAhkJ7wcP7khuABnSgBQBiUZ77k+Yjqgf8UGxKEzXMUBTS5L/Y2xbjzHlj5mdAQkIj9uCRrF30BQKKCZq42S3f1ZkkYZ1+zFctBjLL62BY5kIwspMAyaFYKZ46Q6jxb6myRt+eHLmDOSPS8q14xogzXYh57q3XBTzpOTuRmKZblgP2PNp9NkXqbDqwN3NE+mGSDeYfT19acwPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6zcL8egW8OBg5Hzxr3z7eDDsDzF6ejiccc7ySyLxUU=;
 b=qVdKUT7kNhtR0gMbm7nej0CAZ76Lsz2OpgixSBfXywI90qIRcoDvlIyvklCmP+CMyy3nzbN3cQILpPGs8/lf8jj/NbAEC8xfqZsjUZMazh/SyXg84aU27u0vU0VJUHN1042oQ8tH1v+XZKz6IksX/1eH2hM+0/xj1VG6kMpWFgaaaZ4lPTgyDa5bijuTxLvHTQCNzW6RSpTqnaCjzylUnBmPvmpKe21jDGclnMZj4DNZlf+BmnWSHpQl1+QzwLfTyOmc3xorhWcIAbdnMo3Q3Eje5+n2ewtFiCHTKG6xa9r6V9neZACHG8P/ge8Zcw9r0fdUJa2Gs2a38YQMCVoyjQ==
Received: from SN1PR12CA0070.namprd12.prod.outlook.com (2603:10b6:802:20::41)
 by DM4PR12MB5892.namprd12.prod.outlook.com (2603:10b6:8:68::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.14; Thu, 26 Feb 2026 10:53:56 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:802:20:cafe::f) by SN1PR12CA0070.outlook.office365.com
 (2603:10b6:802:20::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Thu,
 26 Feb 2026 10:53:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 10:53:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:53:32 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:53:28 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v3 32/32] hw/arm/smmuv3: Add cmdqv property for SMMUv3 device
Date: Thu, 26 Feb 2026 10:50:56 +0000
Message-ID: <20260226105056.897-33-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226105056.897-1-skolothumtho@nvidia.com>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|DM4PR12MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: be09bc0f-5fd5-4c13-9829-08de752556d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: riCYYDGN7s6y8vYdUZ0Zjp4CE0OJutu7UA4PRrS8zVsHQ0qOY4+v2aZ/5Eygzxj9lneZWEfgpJP0ND1NICo4IG7nZ+qo7azqfBeScmGpuquiUsmlFoaQdgO9xSAF2crc8F9wM7sTslsOBTye5mINWHwxek3utHpFyX3BrYcBcCodIibWtUJzlhdH/XJGmPGiTZoAAFWjax/rWAy4jooFRKYSxvBNYXIM5DelWoqFleyIWa7dAEWtvKVy+Ho0GAdCDiPRWj8iwB7VIe40j5EgrugKLMwQ/Bc79Egd8UNG+yGUD60itPEpMW9u4UR9iinuwxRnQPrfnWrOwWzTGKcWePHXqfvCCbrfDqaY3kfbvN6M7XhtnpDX43uOoXvrl08rpbjBdVDnYf53c7i+Z+qBBGjZkdtGYtmRFWAzlVjgzjaSloUH3G5I+7BY7HRAlUEwOrIDCmCVWMG1vxxXmIDRMX5jMv40ShE65sHLHn7tNSFRJP0WJGb5pr0WSvVjUbTWuo8HR5eVfp7FuWVZ2ttGbKQ4QJClwy/mgDYgozcH5qpwHdeI5umN0jBfpvVz+rWlbDdRma2i0d2sDBPKfJgeA4IaS4yvfiq7U/QMV4yQOlpk0nYqQeAjHZett6R7GHw0uYScsZRLQqcvSBsmQR7d5kK1OJ1mir2pv+o3xIws6qU3BgjGvJ1Ib0Y1+b06UKhHEWPgZctpyhHJNVoZ/1x6+WRXyn8udg3+T73N+p4aPs+WB7Ld0mGlutFqzcx2PXrpJpCaSb1Q8Cty6npG4g/dCvtrDOFl6dw1L0QBA1RnQ1//beK7VJvQMewVJweRZRnaksPYW2BmumYCQNvFiNDYfg==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Oey/rwzRGwEJAo2mVR/JrB1RDa1SEkT7gOnrZROwM4OqSZRNyclkkyDb5iaS02mWdtPI3KSHjKNdNVtt0bCqSXsFPfA6Udl7B9EmzGXHjD2YfXPh5oZVT9IOkIhzEbiHJ4hIXIVBW7gKY91gq+6L+20VWpSCQ8wfwQXGYzhx1uq4fUx25deT+6k+wfUtbNEi/8XVV2tDwfDML47UldmnRB5hWTHAEFBoiCRCElZgWdHp4tB8j+QRLep3ia3/WHdd0+zYrRkCST5PVCk0XV7vNZLgi+Tdws/NwPdRdnWv7Cl5OEDtAihyF8e9n5WXwNcDBypaiDxDGw3HfUuyZ1JhyMLa85jGeVikqBl062bF6VaIkJ+nkzuDjXpqOZ7U17qz/KpVXCE4ED67vHftzsZNMIsj6gj+aIqfRT640nFvQBEHBv3SpZGUJGxEZFb43Jjy
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:53:56.1228 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be09bc0f-5fd5-4c13-9829-08de752556d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5892
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
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

Introduce a “cmdqv” property to enable Tegra241 CMDQV support.
This is only enabled for accelerated SMMUv3 devices.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index c1f84bedd4..70135af015 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1967,6 +1967,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             error_setg(errp, "ssidsize can only be set if accel=on");
             return false;
         }
+        if (s->cmdqv == ON_OFF_AUTO_ON) {
+            error_setg(errp, "cmdqv can only be enabled if accel=on");
+            return false;
+        }
         return true;
     }
 
@@ -2119,6 +2123,7 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
     DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
     DEFINE_PROP_UINT8("ssidsize", SMMUv3State, ssidsize, 0),
+    DEFINE_PROP_ON_OFF_AUTO("cmdqv", SMMUv3State, cmdqv, ON_OFF_AUTO_AUTO),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2158,6 +2163,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "Valid range is 0-20, where 0 disables SubstreamID support. "
         "Defaults to 0. A value greater than 0 is required to enable "
         "PASID support.");
+    object_class_property_set_description(klass, "cmdqv",
+        "Enable/disable CMDQ-Virtualisation support (for accel=on)");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
-- 
2.43.0


