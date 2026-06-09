Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4251CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWudA-00076f-MF; Tue, 09 Jun 2026 07:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWucT-0006Sf-BT; Tue, 09 Jun 2026 07:27:51 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWucR-000302-Lg; Tue, 09 Jun 2026 07:27:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iKzV/Ka07y3rR8qCzZRWKfa0vlt+IiqPdD4kyL0YeijHDu2zcj9OAZ9Hlz2WMJ4iAHDdTdV0OefhAjfJH03c96RR60Itc/QRmbyJDYnhvrbMXEickYjUHIuh41xOnIbOg3VuZJGhWWzfr16/eO+e1OaaP3dG/qO2TM7ZUig9cLTbTsKm68VZr+QjhVNdpRg5ZpqYZZbkVaSUEbupwJlGsvjx9afnr/4W5EG93lhw0gjjN03uERAYJlWsAyF7RrArfVULo6IwLCwkWke/B+pQ8V9oSeRy7O1Y4o/9H+B6XMThxY85gGfz8e1PPU8a2Z6z+p4sAQvRelzN0wZ5idP8EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LeYnSC7To87fa9wOxXZfYFuwwozAACu/yKVaR8t2ZGI=;
 b=VYUAkncCxHnMMgrBu/q2Zozwf/c//yz2dPjuOm+CLBxu7X4PWWmaiw1WJ+1V5dErQJeaykCxmHT/6HhRVg5tgADOumIx6Hv3EgRAPUrUchAxRDQuFa+1CJwtddcTXkNDriXR6K2jumWQ9jLPJhAEoBm0BCGa986y/rCpjS2oWXif4jLUXdkxyC9PoG/bhx1rkYOCikft94/rqzWQhzEvneUBa8lSWIXTRUsPNuvYWNib+segVNfHjhIco8zH2X47KenralG9gMCL56B22+GUE9GoiWXh1/pUxUxoTFXEKs7Bm3UGX3liAuzL8Z2lgIMadEFO3BoSJzJKMJqcFSLQgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeYnSC7To87fa9wOxXZfYFuwwozAACu/yKVaR8t2ZGI=;
 b=h6g3aVTSF8RNtjtkBAI8UR/f0m8MN85iHI++OwYTY1TwHyJPDyRzJPs9j5oBCvR05v32UjfwU9915ZhnN2nqfpu+GlRdaxnXn8PKKd8v89HGm+B2zyA4aU0hxQ2sYX2kde7WcY6sTWCpzOJlRg4ZgKYWhJ/jcgEExenEmNgfyGUjagNMo9qPod+aHzJQRrAUrKCNAs8dhPexNXF+/FYFvEZSjvf1EQTpdVWw4Onc67TGF5dALzMc9oPvhPKhghlP56NATathRTU1I6oD+MDur4QDKeoR3wslifcfp/OjU5FeoK0twUjiRVqskPk/eRBAi9dZZ7oRzujTMMiHx9SMRQ==
Received: from SJ0PR03CA0249.namprd03.prod.outlook.com (2603:10b6:a03:3a0::14)
 by PH8PR12MB7206.namprd12.prod.outlook.com (2603:10b6:510:226::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Tue, 9 Jun 2026
 11:27:35 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::2c) by SJ0PR03CA0249.outlook.office365.com
 (2603:10b6:a03:3a0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.14 via Frontend Transport; Tue, 9
 Jun 2026 11:27:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 11:27:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:27:19 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:27:16 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 10/31] hw/arm/tegra241-cmdqv: Probe host Tegra241 CMDQV
 support
Date: Tue, 9 Jun 2026 12:25:31 +0100
Message-ID: <20260609112552.378999-11-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|PH8PR12MB7206:EE_
X-MS-Office365-Filtering-Correlation-Id: 524c6fa2-170d-4a9d-c1bd-08dec61a1ab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: zln16sjDqPFug2uUMt0oK4ViHm1kdV5hLU8f/WuTwvEj58nUuEo6/sjxHTMxrwv6Q4nVrJPLntKu+nogeBmxfNKCP6Nzx9cAsObM8VSWYke5LUQ4kPP+byfaYoY+qMAfYaHigCYN4LF9pyDNWDtJXYmOQ161h08aTPFYASho/RUs2sYAEP4iXitB9pJ/TX0OwidfhDZFMwl6NfsilP/wC3KX4W7RyFyPeP0eAQ3p9dT4IG5RjnnnNDVmqkqNWNvEE6c8FuIIn5/WERUKM0Qx5kHaAzud2/68+n8TrkzHVxCMDWwWK9y9UBbnJmWm2aQbrlKxUhxenPpZ48xSu5I0WlA1uKAEMUb65X8mw+ofoTh0c6wWFmNo12al1FhE/PhrldUDqf1/vHpqmXfUB/ZLM+xTPyMD36ToOSu7et/7y2kCLHq6qJD8cZRbbfBl/ss6bSy+GG1Gl9WOXdIOFcwXk4fugCZvKLJ5jXA5/pfyQLu+Je0dlcR9nGKLWRx6S6ckO/VNGL9Z9HTdCtIfLn+LPgQZ/i3qVNIE82/yvTf7a2LHXIYsJqmEXiFyBRjYKfhTUzUTm54dwGEh8y3BkfjgtXyk1++QxLKylsF9VMQTKXQ6xg1OHRNIODF82wJex67aPE5Fvc+ENUTA7UaEhtr869jcmsgCLpDxGUPV6ijY4C1NS/0Q7kXl0+cFMqju6z7eVd5/jhw/KzC0yP2ZdeRNepS4VnY7EI76/wwJXKROQmo=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZHqzrpzMi/xIofmVAWmUwnmMcQ2+p0NOo5kjweVpLA+DyifGaryrX2x6OuRvamgVdSj0GcmX5HJDI4TUDfq8CSJAtHfzMJxXjNajF6nEaJ85I6H9uN1qSEAVGowh8dDkbVjKIGB0QmyKOj1toVNdvNgIm+R4zXnJk/AB7k/dgajEYuuv4TeRcW99dDvlqB0XPuQI/+7irvGn9MHb1xMOJLOVX8N9FP3/wJK4bfPtJNUcZTukM49t5B7dYT6JX4g4uXRZRosAnREWi70OeMXNxfH51RQxq0l4ySs73fAqL3KRnv3zavBPX3bP/Olu2NFw/dpiddzof8CM9VJdiMXkxaU2JHj2hwzG7gKxVFv3DokWiUc8SqcjE4AIOfsFom/fI03tx7VKNzltke6upaB2inqmdcj6hn5kNyvgttcl+WlJ8QscFN7m6U2oUanepozx
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:27:35.1495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 524c6fa2-170d-4a9d-c1bd-08dec61a1ab6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7206
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
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

Use IOMMU_GET_HW_INFO to query host support for Tegra241 CMDQV.

Validate the returned data type, version, and minimum number of vCMDQs and
SIDs per Tegra241 CMDQ Virtual Interface(VI). Fail the probe if the host
does not meet these requirements.

The QEMU model supports one Virtual Interface(VI) per VM with 2 vCMDQs and
16 SIDs per VI, so the probe ensures the host implementation is compatible
with these limits.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.h |  4 ++++
 hw/arm/tegra241-cmdqv.c | 32 ++++++++++++++++++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 74a6954017..38c8b27b4d 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -10,6 +10,10 @@
 #ifndef HW_ARM_TEGRA241_CMDQV_H
 #define HW_ARM_TEGRA241_CMDQV_H
 
+#define CMDQV_VER                 1
+#define CMDQV_NUM_CMDQ_LOG2       1
+#define CMDQV_NUM_SID_PER_VI_LOG2 4
+
 const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
 
 #endif /* HW_ARM_TEGRA241_CMDQV_H */
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index ad5a0d4611..3a19a1af56 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -38,8 +38,36 @@ static bool tegra241_cmdqv_init(SMMUv3State *s, Error **errp)
 static bool tegra241_cmdqv_probe(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                                  Error **errp)
 {
-    error_setg(errp, "NVIDIA Tegra241 CMDQV is unsupported");
-    return false;
+    uint32_t data_type = IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV;
+    struct iommu_hw_info_tegra241_cmdqv cmdqv_info;
+    uint64_t caps;
+
+    if (!iommufd_backend_get_device_info(idev->iommufd, idev->devid, &data_type,
+                                         &cmdqv_info, sizeof(cmdqv_info), &caps,
+                                         NULL, errp)) {
+        return false;
+    }
+    if (data_type != IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV) {
+        error_setg(errp, "Host CMDQV: unexpected data type %u (expected %u)",
+                   data_type, IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV);
+        return false;
+    }
+    if (cmdqv_info.version != CMDQV_VER) {
+        error_setg(errp, "Host CMDQV: unsupported version %u (expected %u)",
+                   cmdqv_info.version, CMDQV_VER);
+        return false;
+    }
+    if (cmdqv_info.log2vcmdqs < CMDQV_NUM_CMDQ_LOG2) {
+        error_setg(errp, "Host CMDQV: insufficient vCMDQs log2=%u (need >= %u)",
+                   cmdqv_info.log2vcmdqs, CMDQV_NUM_CMDQ_LOG2);
+        return false;
+    }
+    if (cmdqv_info.log2vsids < CMDQV_NUM_SID_PER_VI_LOG2) {
+        error_setg(errp, "Host CMDQV: insufficient SIDs log2=%u (need >= %u)",
+                   cmdqv_info.log2vsids, CMDQV_NUM_SID_PER_VI_LOG2);
+        return false;
+    }
+    return true;
 }
 
 static const SMMUv3AccelCmdqvOps tegra241_cmdqv_ops = {
-- 
2.43.0


