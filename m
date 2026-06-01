Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D0ACD6E56
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU1Bf-0002Xr-Er; Mon, 01 Jun 2026 07:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU1AL-00006Q-KF; Mon, 01 Jun 2026 07:50:47 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU1AJ-0005b6-3V; Mon, 01 Jun 2026 07:50:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ob+/wsRJLW0PYn4pa4aU2N7VKD/AXP7FO8Gs0/FHyJWAB3Hwut9AZx5aIss8vVrkZe7DKjVn2H1H4eTDvKutiYd5S5kxtUaNSOwZmt4eA8P87sIObiPVfg9c5QoCqZfZAyrQKBFN4xkTmt/oHeKTdLYrnlNy838dU0BLidXD4STBShUqX2vEWok5G+gZ8jI+zjwDpG7zU+zRVel09wlD5rMgBd3FA4UMo1HDmYZGDv2DvZS/xCFrIIuETZRrj4DKizm6VAaNi3CRj9p9ujv3AZRAav3HlM8Fbyd/8jhkG1M5GHmJwudl/+APAPrm2IOaYHinkE8BI20gnhwgXN5eHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J81i+hMYv8NhdiUvO5Mo60nLh8BNWRmBwOipu1J1XYU=;
 b=B8qFf9B1X7ZGc/RmLW3vDTTOf5c9n9n6p6peOWapSVXAWWdTkkdLfS8CgGYImG0OyzbhHUFne6vuROs2xNswCEHucy8woLB2VtNaFQFbWOlX6U2O0ywvrbcS1MMz/4VPJDUvNEhP6mUB/NeyuoJ4dP66gR8otv4uLSFMBbf1QUP66/p2mmmH8fMSm/t2oxxVkye8VTsX0x+MW4d+/WAo9tJFejfqUSyZJkCmDZwY4NAX8cK8tfqFbvtdlOzqQs3FG82dogicW5W9//LLZVG6VRouybjfkw4tCF74FTgH3SV4LIV6nqd54x+6ahma546FJuL3Hry9KYbtzxFzVfh85Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J81i+hMYv8NhdiUvO5Mo60nLh8BNWRmBwOipu1J1XYU=;
 b=E0GKS5S+dEIUHOSDIMBkWsIYBDeSIj9/0OonuhV8momj/zc+Akql6wJXY+N7NRh6H+d68gKlqsf8CWFJspaEwG+On7I0DRnJyGFyrZYV3Zvc6Yh4KMoS17Kmk5jeMZJCJ+XPgHPGH3gqFPB09xsew6Dg9AYjJ42lWPPcPfvz1ASHrw2iWBZqjMmxyZuVFKLxpUPurfrtVlJTxgfNsLV8DuM9SglxmOCr3RS7P0G88WRoyfbataVHtkyh5NeS+t2TUDM40z9iFURkmWRmpN4Matj+xgDpFBuY9m5bOXwluPWwLfLjgtNBseq54g0gZQ57Qb6Ey2Uvkk+mCKB1V2S8hQ==
Received: from BN9PR03CA0958.namprd03.prod.outlook.com (2603:10b6:408:108::33)
 by DS0PR12MB9445.namprd12.prod.outlook.com (2603:10b6:8:1a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 11:50:35 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:408:108:cafe::63) by BN9PR03CA0958.outlook.office365.com
 (2603:10b6:408:108::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Mon,
 1 Jun 2026 11:50:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Mon, 1 Jun 2026 11:50:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:50:15 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:50:11 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 31/31] hw/arm/smmuv3: Add cmdqv property for SMMUv3 device
Date: Mon, 1 Jun 2026 12:42:21 +0100
Message-ID: <20260601114221.457995-32-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601114221.457995-1-skolothumtho@nvidia.com>
References: <20260601114221.457995-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|DS0PR12MB9445:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cbce390-890a-4e16-5b57-08debfd3fdf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: hKLx7bAN+o7RBpwZX0IsBADCFp4zYZy1aG24NNeMtcHq+YZkCOt0RLkTIRjWhvJb6dMQIAq8H/WulO/Ge5MD81IZEJuRVJDUIdQziobcGzqHjUCnavEN3HxDbn0vReHlhlT/frCNyXhUttbZ/AZnYdhRMm2LnOFvsBooAzQBgTWes9aBiZ8QJk4794xBJ39OxhWnuQfmpfgcD3P6zDoOyywwX3DNQzSsg40L2MV4iuH24mlXONw5GgySyB5EWWP36VxKg5nshvaMsHTHgzbm3+lHf/x3cY7YTHcWwEBXmeCji/Buoz+ieo5XLWbrp1NfbP7Vhznpjba8JUgVWVHE5z+MLRLn133WgdECp3p5EznBt0dL9e8TJw42iDDTD3pwhUEdSZKpxM+ScpqZbfYzAoyNBIfcfUGZZMNE7lN52nxYeZ9OEY6SFLFFFkc6WyBSFazj66tQ1tXXvn98k76JciX7Djvwk8ldycGHHk5xyW9emW2gDDqAE0IZFqZeamfaibPVorudDCjvWf8djayjlVg3pxBR2xjAl9ucLnkt2NgWIkywfYfqzSphZ82dBSXQ4sZQsUIK6xbVgYxjSW4pTCqPPpDcTlcLaORpFXSG1gVGMoi6w3gqn/7CkRN0FYhD6yeEu7j8Uv1jp4v6Yz9AAY8fggJMzPnUD9UNGy8HzaFvEXd5CNRZIQYdx7p6ee67xPxDGc039va3VaHwtJpbZEpmLIts6KqO4trRuv3nYzs=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zRh6+hOffVUC+ZejYQbZyWHDgaieSFM2FMuo+s0V93w88L3tPLqWQ1Ojukb//0HCm2HfRJNTGrQxpn9aXflYEQQH+VhTau2d396D0YOuMotZCwYAEhvgD1R5nhDyvkYjGy0XIV2qXkwfYJ3y5JXrdOeFfbLgf5v9SzonhvSQB7gjiJthHpaNyBDuRYTZy3nuark9JXUhaXuFKiO+bLqOPzq6eRW+uBkqH2C6VBhtQuYZWVmvcPWDFqjfOloQrrENnvjSJHuaitJj2yn9xg7GZdxQxyjnrckjb98zG+Wkjy/c0zZ2Fk1nXcVHgsbMFbUWORqw97hCjEH3CzcEBOFG9rakV7GUwF7n0HWanT9QJTHpA142dkqLMM8icNJt5XYuzwLBZ7P6tjGeh/HMe/+yqAPEGHuWu1exMsgyKM/6sa67soSNTYRlJ2uDHWmegvpe
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:50:35.1050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbce390-890a-4e16-5b57-08debfd3fdf4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9445
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Introduce a "cmdqv" property to enable Tegra241 CMDQV support.
This is only enabled for accelerated SMMUv3 devices.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3.c | 8 ++++++++
 qemu-options.hx | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 0d111d638b..23592354ee 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1994,6 +1994,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
                        "bits if accel=on");
             return false;
         }
+        if (s->cmdqv == ON_OFF_AUTO_ON) {
+            error_setg(errp, "cmdqv can only be enabled if accel=on");
+            return false;
+        }
         return true;
     }
 
@@ -2144,6 +2148,7 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_AUTO),
     DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
                               SSID_SIZE_MODE_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO("cmdqv", SMMUv3State, cmdqv, ON_OFF_AUTO_AUTO),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2194,6 +2199,9 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "than 0 is required to enable PASID support."
         "Please ensure the value does not exceed the maximum "
         "SubtreamID size supported by the host platform.");
+    object_class_property_set_description(klass, "cmdqv",
+        "Enable/disable CMDQV support (for accel=on). "
+        "Valid values are on, off, and auto. Defaults to auto.");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/qemu-options.hx b/qemu-options.hx
index d7e48688b5..2eee466be7 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1329,6 +1329,14 @@ SRST
 
         - With accel=off, auto is resolved to 0.
 
+    ``cmdqv=on|off|auto`` (default: auto)
+        Enable hardware Command Queue Virtualization (CMDQV) for the
+        SMMUv3 command queue. Currently only the NVIDIA Tegra241 CMDQV
+        implementation is supported.
+
+        - With accel=on, auto means the value is automatically derived from the host SMMU.
+        - With accel=off, auto is resolved to 'off'.
+
 ``-device amd-iommu[,option=...]``
     Enables emulation of an AMD-Vi I/O Memory Management Unit (IOMMU).
     Only available with ``-machine q35``, it supports the following options:
-- 
2.43.0


