Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288DBF41990
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 11:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCxxP-0003lZ-Si; Wed, 15 Apr 2026 06:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxxO-0003b8-6Z; Wed, 15 Apr 2026 06:58:54 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxxM-0004GY-R3; Wed, 15 Apr 2026 06:58:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=va2oPEqqZgXXLjTrOwb0Dp+0oCJblMBXvxAUx1OTqOxaHvLlOE86qkqQZ+L5yOet1UpYLW+h9Oipj05TVcPOhK2IafKhjXwoyf0AUM+XcOLSGx2noPzEgSbYN9xeNTEDMR09R6CNbFv6AGQGAfpnuqqxJ0OkhFyXFBxkbAYVF8xAQm/FYLH+C5yy17JM3ICLxkuPtCZjm9MqfL6PYAhrxUvKJs0V689onRyHfk0BbSuHtjaKlNiDtfJfNrG5zYBfehfi2NFWELmFS1ZpoB6NuUOinTbpF5ypFyfE8y05jSRicCCdmgdifxfERSkJDaQzGN8azJD8OGKkZvuDQGZGew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MPbA1aCMuapPIRCCVRZlfeOW2Q/VCUYncDVMpheH24=;
 b=OdGn4QE1GePKnR67tHBekHluG32lTmn3peJMvl83HpbjYzr/qVa5LhA2Xbn9vFsWTWHdOYGah4tR/a4mc9bJCMuewyK5DR+uAhWtuWTay7FGdyMrZ+SRGpdQ3Ndn40VUrWndHeU9vOaYb4TQiXCsjsG8HIMATTf2k+ARRbvRMddhtXr3zo7ZQHirpLBkwe85KaC9BzJZQ+CLUOaj6RKQDxNZoWDDgqf7y9tA4TkOGWzIeGHapvKru69DeDdM/7oQno7B/cSoztFf+I+xnHBboF+F8lDiuV8U4z0XJqSXiu6TQq+u9Ceo2NznHXpGK0lxLVHfHupAnro8TR20vNsDIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MPbA1aCMuapPIRCCVRZlfeOW2Q/VCUYncDVMpheH24=;
 b=OfNhjxh451ew83ee38PebGyOpXFJ0T9sgBwIf/fOiYjBVypQH8U1xHmWYAZD9C8N29ATJYEjg79aT7OGFTANw99uAaSuKL1vNiZ1wJghZj3DQdRq3BDim48TxFcr7wVPKQh4PKGq5o4Dt9WqJsjf3w+FarQJOKkAzCvTZiQDYsnr4+CL3OLkEHwNjVWW6dFoEONhRuYOjpnGjYG4XIxsepmlQxH8JTJy3/toyzk5gyPe0CXDS2Igg3db6H9JoUKdtN5zr+IKslYbJ9swR2gMBLU28/7Zshos+CZAQkpHJX+ze+V9XXYO9VtEq0P2syPDYTbI1GxsF7KgPVHN6mFNCA==
Received: from BLAP220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::22)
 by MW4PR12MB7468.namprd12.prod.outlook.com (2603:10b6:303:212::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.37; Wed, 15 Apr
 2026 10:58:46 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::8e) by BLAP220CA0017.outlook.office365.com
 (2603:10b6:208:32c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Wed,
 15 Apr 2026 10:58:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 10:58:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:58:32 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:58:28 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v4 31/31] hw/arm/smmuv3: Add cmdqv property for SMMUv3 device
Date: Wed, 15 Apr 2026 11:55:52 +0100
Message-ID: <20260415105552.622421-32-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415105552.622421-1-skolothumtho@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|MW4PR12MB7468:EE_
X-MS-Office365-Filtering-Correlation-Id: ace51667-3a90-4ce8-8682-08de9addf73e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: kt7jb16G+ZhVVOp3nqybkgb/Nf4/ASYl6VM10en2ytDx5jKqKO6Owln2xHcXe6cOXbo/2D+gt3DCITDdkH+Fg6VrcpqTbruWQgPp8Yr6butRjIu1xPTnKM8sT8mDlJNYl1qs2mumOHaajFSpffiwWI8QWrX1yBNtXT2NIexl1Cs1q4Fca405mnCK8pOkMotCR4k9KMdeRvEYdvuqERb7pzhhel92dbFJ06COJGtS0JD7HsKNK7iRfkK7+6XyM8wIUYRG3kYX+qsbq8ey1NFbtpdCBKm1kVcmgJuEAkiiMuNGbviIoegQRAX0IQ7xUc6KTmAe237lADtduzfQynbzPYIRp4J7mJufHdd364KeUP29QA4Ug+tQXXDgg2r5oM+dcPvkv1Tn/i/j264K0nhCyi+TOWFpvV53GAezNdOxV6AAxA8Tu9z2nNb9kv7ha/obDuL7EB+vmALJsgqxbPil/iEgDGcUZXOj8uSrbV6YweUchggGSpWKwwWJLGKAqQ4Qb+/OKjPVOOEysqLm9k9Da06cQOJqBBdTYUsCulNXg04ifo52rU0a7QKSS7kq5rcfF4x9/xiCAE2QWnPFidAbprq0/Bz9RK3zYLPug97Y3Pc0km7+MzMhmDOELUAADsjp4ffkLbtTS0phRWWtY5Ygbfuzn8EN9+2nUzeCZEX6WqK1/bUlKSQo1Uocbb+nYjokEQ1JH7R+cMNkprIfocC5369WctrIiqTa45eQVuQ/qtlYJ0cgdZoRgVTMKIJtsD4asoSLqFyuFLAT5kgDTydPUg==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M8SRumFRp7okmHXJCL5f1ChbxK7624B6pkpQdQdOsXs6sHEGrk03SFeYBBDk5vOYmH+ho+/I5wUX7gyTOsYKADyN+KbLFK9s2rnr14rdtd/hqamnlsOCRp7o0bXkBql3Nkwds4g8/QB6y0KIIBP7wtbeJalEl271IkSt54DD9+dD/sYGZx2QmmN2IN7LRFG9XcoYRaSm5IWLDCOkZXbWJhJMlNaKiHZrujImLdqL2PFsycVl5YPvXcLzqMrxZy0qeeO4d/G0/41ZlNTdPZlztpvyvYdsYc1lzVKUVSOrf5DtadXTs+OHTIgEKuvkYDk0DIcir+Z6vqXDrYoPqmopP6tcoUhcS5A7ZSLJQmGC+S7TYIRg9FNqJJ9QZc2XKCL5/lW1Ar/63yxhyEfVKRfEHS1mrDRl1ossMfry9pyNzF91ouypLekh7wLGZ8Al5AEA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 10:58:45.7758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ace51667-3a90-4ce8-8682-08de9addf73e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7468
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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

Introduce a "cmdqv" property to enable Tegra241 CMDQV support.
This is only enabled for accelerated SMMUv3 devices.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index c9ff6298f5..51b7d01da5 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1993,6 +1993,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             error_setg(errp, "ssidsize can only be set if accel=on");
             return false;
         }
+        if (s->cmdqv == ON_OFF_AUTO_ON) {
+            error_setg(errp, "cmdqv can only be enabled if accel=on");
+            return false;
+        }
         return true;
     }
 
@@ -2161,6 +2165,7 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_AUTO),
     DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
                               SSID_SIZE_MODE_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO("cmdqv", SMMUv3State, cmdqv, ON_OFF_AUTO_AUTO),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2200,6 +2205,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "Valid range is 0-20, where 0 disables SubstreamID support. "
         "Defaults to auto. A value greater than 0 is required to enable "
         "PASID support.");
+    object_class_property_set_description(klass, "cmdqv",
+        "Enable/disable CMDQ-Virtualisation support (for accel=on)");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
-- 
2.43.0


