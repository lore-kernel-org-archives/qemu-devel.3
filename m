Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1E3CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWudx-0003ST-PI; Tue, 09 Jun 2026 07:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWudu-0003AM-HC; Tue, 09 Jun 2026 07:29:14 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWuds-0004am-Lj; Tue, 09 Jun 2026 07:29:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TeuLYBfaf8Xa4AVXb4Zbxr81xMQcmLHAHeEmijMoicLT8ZBN/lT4ZsCOmoqKDn0aciMULt/wYJxRUGYR6CojP1N+fdOfrm9+qLRO+PSxyWD8vQfHz8E3+tk7oxPOyT+pK/bAajHX+AZMcehb0KyVGGXJBF86UK9uePkhCOri6Rdy3gRwxcTKl8tTPavHVlxsWIe5C4Pv46CLqj5zgFimqYBMwvDWCKe0tNJMJ4OkrnyXX1FNggnM6hfWOYF+Xa2tPWxgR3S4Ea5BfCMvttbKERyiK0uToj4CYTO+69aFUZdfQzdvnDNtZEqrXYQWloEpKLuXiqpJa+WzZudIlV2FeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPBsrcR3NF1oSbOhexmR4WkWa6SDtHlDExhNSz38gUE=;
 b=vEUmtgqnw2hdYRoi9F2JVTA81Y83S1y+UYZHpnZgyMJUmPxCDLS9b7YCWaB+EGp06vYBzorKwNAUsAkPyCXAUSPkyNckXUnD/3tVjVkMSk5Wkm2jmWuaLViWX3fDMjmdlyn4bvJctZwgNNVXo49iflPTY09L7IKgd01ZxPY8Z6p4x18KiQjAmDVJUGQd/8Cxc0m70xhuZcGOuAOfRxLCsolPAtSslnix2dOKQ3IMev72W5sL7Dh4N9ZtL9yvyRaquJ/ILDW5GuGoCD/f0t+mf7B3pdt58Z5p1GJJUdtCKopGetP4x6SlXtSlbyO9AgpohAu3nHghgotbbn2ZUlNFCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPBsrcR3NF1oSbOhexmR4WkWa6SDtHlDExhNSz38gUE=;
 b=faY1qrOe8F4vOmk8bjJa+OsH3ErGLHe3E4k4zgZ8A1lIIo4u5RWHJAr+8fSFabky6bYJh4Rvnl4HlbvJt4rdm4VOl6gtwMzRBFOpzbDvZ3DW1aZkog3F5jfSU6WoT+CxEH7mR9Fpsc9uQCPThpXjoWkB5IYiRlZ+VxLw8YgiN1C3ftX6pJqqj0waXVl5wnpf9qR6+N0zjfWPKu883S+Y2rgC10WuRnLo0kOg+Hg5b+KYMZGPa8UTGZscNGCUxwjoEcnToDWMXbQaV8j4NVZ0GDVbgoAv80JFPv0stlVDIMpppVat5+55ib9YgMvC/X4b/ZmWE1uO8gv9yGb27BRb+Q==
Received: from BY3PR10CA0007.namprd10.prod.outlook.com (2603:10b6:a03:255::12)
 by SA1PR12MB5657.namprd12.prod.outlook.com (2603:10b6:806:234::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 11:29:06 +0000
Received: from MWH0EPF000C6188.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::8c) by BY3PR10CA0007.outlook.office365.com
 (2603:10b6:a03:255::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 11:29:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6188.mail.protection.outlook.com (10.167.249.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 11:29:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:28:49 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:28:46 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 31/31] hw/arm/smmuv3: Add cmdqv property for SMMUv3 device
Date: Tue, 9 Jun 2026 12:25:52 +0100
Message-ID: <20260609112552.378999-32-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609112552.378999-1-skolothumtho@nvidia.com>
References: <20260609112552.378999-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6188:EE_|SA1PR12MB5657:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b54923f-7a8f-4c1b-573b-08dec61a50a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: mUd6gHk/chINTyKRvs5XYp7IE5fPQw43++0qwURAxjj0mVHBFkfnPGfutOXeTn1CWiu3nqjYtsFe4oGg2AhYSyBF6y4jDJqTYgk3nXnQ+CfkMWn5WcFLqF8dCsy1A2NRqoTmYdWCC5BzvBYmQlYPAmQev3PYGNt+YcQH4/X04oLwDxR+FSNzEih65rnFy7QV942o9E56ZUXsaNhtgIK4gpeNe4ep6CGehlHdLYgmYWE7NUrjWH07+bVaPrN93JvFUeF3D+m1WmsQmDVWrZRjTzDCJtsF34ms0vGE/XuHvG0sxumZMSj/Fa3Oyjrndodtf0L66NHQnLksucyQgeaNuhJvLG4npn1MAKEYHUHvPPeqYnd0PX6mU/pk5KyDUMpvF1yfBPCGLtTD56bcBHq+I/IGapyOewBtHehEjIMuQqvR4jI2Ydm4tyHdvPw1NA6QXOIEfn2DObfOS0UHy/kWi8CuXopZFjEiefIZGdtzJiPjInE83gQbFncSfbILtyfyao0XyOX60qrQXM8uvaJoU7RSRt+sp1uWipEpO3iGGeZK9p0qrhHp8W3wJFdBVUYAZxW2evIZCiwLngv8PHPLPmwsS7NSvVq8vN+7m5rRCcJK7wjWeo6GhT+A4XOvFu+q3ao/UlYhy3yongqZ3v8VKU08Cc/+SFz6d6tqq2/hqWgUlOCZoVio70zyvklmxknudSbQ0ebKPYfLeDlYr3wRXewND/qYb+FxVBIuRruDc9M=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZjqJwgmtMVb0eHT2f/xhe6XItfAJbba0SGPN+CG7M6eqCd6ogawwzXwFFzkYmll0+t6fTrgw6Bd6cM/IP+HB3Zt+KmzZHldiLZX4au2z1Xdsfk5BJoFKxu/MQMLt9A4fCANH09s4FpJg2D4Gx53S4tGPRFR0/6+y4stQQjGsrhXGspn/4TB1BlGbvGF5+Q49UGuwRvyMesJwaUgZ9paDVdMXjtJTRxzSgfJqfKG6EK4mAu2YGlrEfDvuqHPNKuhuHL41W7fOmNs0o2xSDKcoI62BME+xbJjMgFowZZAVpeN6bc9kGGsrSiwn2eMJRzw0eTwv/9ud8m20fEimuCxzZFy/2wBeI5PzyLngpAgHwr0TzOATmSltjL37F71pZ3JJE+uSr1j/tfiGhQjED8rIOkj2Z5xTR8OkR1DwVphWElQKackiBen3EKs3Fh3/02IC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:29:05.6449 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b54923f-7a8f-4c1b-573b-08dec61a50a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6188.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5657
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3.c | 8 ++++++++
 qemu-options.hx | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index a8fb10e531..5e5a6a960c 100644
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
         "SubstreamID size supported by the host platform.");
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


