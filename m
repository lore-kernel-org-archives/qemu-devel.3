Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0535DCD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:52:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU18l-0004nO-Hp; Mon, 01 Jun 2026 07:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU18i-0004dh-FN; Mon, 01 Jun 2026 07:49:04 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU18e-0004y6-Nd; Mon, 01 Jun 2026 07:49:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2t+NaBYB37PTxucml8o+akrPbOK9XzWhpm5Fz4WvHn4zMq8HsSpOPswK1FrrYY/krFytOBpVkP/BhIIcfLMK6rsM2d0csqQpuJKEKAzrEzud+BdR7RrsOltDg/oCQoMWnculEUugL9+J+P79CY2i1JSg1FNEsnWfSYQXWl/5FI+npA0BXk65JWCto/ooeaENtGRS8lEwEiTrpGKUGp0PT2fdo3oWyuRBn5+Iq8d04eMacCJCe66/cyAIPa1Fc2p32Pm77FT54CxbuQX95Z3FDF3UFOftLXRTvGEPVY8AgnHfLBfW1ISNzFkOrzN70ZOS2Z595F1rz9vOZZ10LmWNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o80xHJPipyEQz163kC0jClUds8kjHNw4Ko2fDKo4Xqw=;
 b=k9hYDGtlRbhV+zAWuorCrdDxmbpBswL9/CFo4Fqml+5jqHGqq63+RJz5EFopwczWL0lStS2gipQAlMCNdR2bFJh80Li5fJr82h9kccr0mCCBZvmb4O1AXAMJM9O+gp/crPxmGsDTH/OtlMKBx7O/kwdGOaUlaw+u+cPSdg5WVCv/oRYaX4vKks5p6uea5FDfXAcbbMDl7DJgBdP6dxSZuzzYPCg9f33i601a7Ff/Co+zPVGMvioMo6xXb0CBTdWfZZizz9KsAserJ0j/0LtAi0QXoU4qVWVkBlMmcLi2EucEauRiHLaXZzLdDsfbCnTNDwIKQOi0To7l8VU5qiyOeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o80xHJPipyEQz163kC0jClUds8kjHNw4Ko2fDKo4Xqw=;
 b=Ifciy4IYHG/2nb18f932/YYMBiBqySVAAM18ctZ/aMFl2bvqx6QvFQMkMLCU7gK+gklVQ6gLjswMFgwFeTG9kvMCE1FrlWRHOJMlVmKk1ISg/iMp1BIyYRqZZtVudd2Axjvziz3it88wSUIqTQFCYFMKfF/2YOJTSdINQCHcjARux3Dbi7jrPw/wW+v8YDFTVzciICG6Wbo0C9ZE8LrKQ8j1bKhc7pu/mMUWI95TUtwg9YhsCs2CpN2g0ofUgHKVHFC3mLzte33wMRJNZ/62g7Oz4zLawzKeU+K9fWtnfkOMB1qZBW7MBucHY6Odqm5QBcOk3l0nvG60jDWer+gKLg==
Received: from IA1P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::14)
 by MN0PR12MB6080.namprd12.prod.outlook.com (2603:10b6:208:3c8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 11:48:51 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:461:cafe::94) by IA1P220CA0008.outlook.office365.com
 (2603:10b6:208:461::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Mon, 1
 Jun 2026 11:48:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 11:48:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:48:41 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:48:38 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 10/31] hw/arm/tegra241-cmdqv: Probe host Tegra241 CMDQV
 support
Date: Mon, 1 Jun 2026 12:42:00 +0100
Message-ID: <20260601114221.457995-11-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|MN0PR12MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: cc9e4713-d09f-4667-0a26-08debfd3c036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: ZDi4b6svP+B/vTEaD6x+0vT/ZBjhy+q25DfYIMAyOir0dIAJ5WgoMDKovun4VaJ/BsSjQpMhGWr/OqncfTxEOLQLftFpM9khcdK/ngxV40pvOR1IXNKrB/UO+SveO40CJdqkUnmqF3ugLvVS/z0TQNXCMluZSITmtDyTP/+nGHWItfCRPNaaddrQ1dRFFNx1rLmvc4UdEyuKNKLaA1/J6x2Bwg4paiEAPny3bfJhAWO9B6sGlCPwg5HG5DNdcvwx5KZgu2W8tmBjDiaUT6r74GS89I1u8sbzEbLbIepFCYsO1TikA/o6alUoyIRF7svbmVKYrEVRYdm6SCmc21SjOAzVX8c9X2mrB4wN8r1TtBdQW/kt3ZxgiixJMpoo+OwkK7BjM65+zkTB9zsCNXJDP1VKz91PPC5ddzlk9gVVQfHn8fI4diGjmFqDmFG8PYRf4hORRPYIex0HdRi/TqI3pomn1P3Govbi52CR8O3vWWcte9ZEYM263dPpeNateou49QsTBAtpyfMKgkuY17Sw4pr5tM+mjnerf1S4sM5B0mTS7tiOXuAy8fffnTI3+HwVpzPpVOAELtOiG8bMM6N9sLZ7NKVsDih/KDnInQ51BAvvPpLjmyLXX3w6fJNZSKM2zg4DaT69E9GLqZnGlma6SImnxDHUw7RYOVh/+eqLSBQ77E72KqbJC/2FszEAocK3i0p+s/dRZ9LUGuKIyUzm/c6E66d+rp9sBMDtHoMNx2M=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uqCJp5M4adlE4EI6l+LFMhoYfievUjDWzjfMvq2LkiVQcLJIHbhy0a/sbXrUj+eZY8DZ7UbwJ4mP9rEEe4emJQtu3skP643A2bSAGf3jYUV7zu6Ym+yUzyA0zLQs4mUSoG7xJbfdcytb22n8RwF4w4cx4LizC4zuBsgtMkDlnumMixdbTIxAyshSYhllLmiuhn4Ehua5T4ZfPXuNuCDYq07UxNneceFQffxhar8BUzAQJ+tSx/0qI0xMQ/s0kk38e8zQ26kJRbVFU62szdNBGLk6xlv7OnxqbyfFJFV8vd4/mMfAZuollT8xQBVrSk0bj8TRMONAj71vmiOso+p1dB4UIfrQR2sJaACCWdQ8Pz1+Zn9NAMdBqg/WB6yxOQyeeytOJmFYo4oiP5znlsyeo+HmI5Gmskxtn6wNlX7iTmg4NSR9XPOzgWBIlEyTIRUU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:48:51.5040 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9e4713-d09f-4667-0a26-08debfd3c036
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6080
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


