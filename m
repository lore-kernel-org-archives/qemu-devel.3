Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82566CD5BA3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHrG-0008LP-Fu; Tue, 19 May 2026 06:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHr8-0008Bs-UU; Tue, 19 May 2026 06:39:24 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHr7-0006SO-89; Tue, 19 May 2026 06:39:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3OThLZwAbW7PNFSxOtpdwCivtdet3QyhPWEF//9+zwV8Ghy/RqnlB9nFa4xvJSuIIGjDqGDIV9uxmWmIq9gKO3Gz5nbTUlnNalG4L0Cn8S0NhKepYoj8cXhzSAYGOIWbq/9JdwDBLw0HTtnlSyGHzfIpYNAfqnV+dtsCekqncw1rrFB030DBhWy5kXvJbE7YVeASKp0AbB5A0sAlELFkPPvK6/atNLFnEkpOoW9ihf8A/djOIJ0PrNSEVlShlyvaq3n0PPQsiVQietGKvEolbLLKtK4Lhmj36CsUvvf5n3aHjWHEJAgnE8cJoG3VwPNZAF4XlfgIRqA+MbHqqcxXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o80xHJPipyEQz163kC0jClUds8kjHNw4Ko2fDKo4Xqw=;
 b=XOgNeyUTqH2oOYzlFQGePva3aDh1AiVx87FV0267wBwXYo9Nv5vSHtxQWgvyV8A1DdklD+ZCc0L7CuEysagFY9LFdMQoW+eSfta3GAWND6dD9L4Sa+lmrqdX6R32aHIrM/dZAwA8MnVMkX5wxENAsqHDNKYD7vTUHL8B44cyb8MiVUT070z+1QDoLJMUhDtSM3e2WLHWz7Xb041FJtH2T7m989gfQ1ImBlWRMHmBD/pxhr7eadoZMu/RQW2CvVfXIHTNy6buVXui2Qzx0GKsotqu7W8LqlCjNtiS12FDKIvJHZAWW4GZtQFM+zcVosmxSAe9ekwXevuvE3+vSrNsKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o80xHJPipyEQz163kC0jClUds8kjHNw4Ko2fDKo4Xqw=;
 b=Zsd7dHMDNIIbIWvjQjH5ptSnifvvcv4oUKeFh7u9FBJ3NNAoL78hEryBH+zhjbhF/wat8qK3BXkx52ZUub0BIGmcOJsLONYBndPlxxd/+CtDTV6oLR/K0IJZepZLCPKKRbL6b5o5Rjr0PfUjOvJsb/h+PqsmUKSztd0uC5sCGcKVwy3WSIs6FSvBsTF6O8wO9qENGnY5fdGaRGqPdZXF0NX15UjKLoo/D3nJ6th+njCGCdeSSeicjSpnTT2hub+W6smqsrVZ/d6BFV2c4hI0ug5fmkLnMHeJjIoEIR4zHm5xKv4sFiJDV0YoZXBnTm08w2nm9Uy6cmxyDGHzzdFgdQ==
Received: from PH8PR07CA0031.namprd07.prod.outlook.com (2603:10b6:510:2cf::11)
 by DM4PR12MB5844.namprd12.prod.outlook.com (2603:10b6:8:67::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 10:39:14 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::9d) by PH8PR07CA0031.outlook.office365.com
 (2603:10b6:510:2cf::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 10:39:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 10:39:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:38:55 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:38:51 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 10/32] hw/arm/tegra241-cmdqv: Probe host Tegra241 CMDQV
 support
Date: Tue, 19 May 2026 11:36:48 +0100
Message-ID: <20260519103727.899332-11-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519103727.899332-1-skolothumtho@nvidia.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|DM4PR12MB5844:EE_
X-MS-Office365-Filtering-Correlation-Id: 85f9bb93-231d-45ce-c734-08deb592df0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2QYkOUFXTtPkkHeQXTbIZpXSp7yrNu+ln+B3GxYvPw0URZLUfXQDLHIf40YLyJRSpxFhQDoo9sxjFstbDrbN7TRDNJJaFIVdxde/qFpp1pwGab8ba2pkhWAMMrwIUkZumLGeoD6oXICgcxfwrbkyeQVsY64ujVPvdQCKROtrq2eimOB+Gy4e7q+JjE7kvET6o9i6rM8+5jPS43500H0Xi5kXEJNCZygjStpe+7XLz6Wgu2+0WDLCQD1D5IU7slqZxClKd5N3mdNcseIGxtck8rZ7Ja9LgdnAubs0owCC3zIU7k9+2vAYT+N9MsQu1eAMAcAZpQBWMcn62mS5ISxkLb8JRQxxd4L5MBOVEu2K4dcLskWEOkVOJWnouEMFvCBWpdCRpgHJ3fbaUijgJhvOKKX2gc5XuATjvO1iKawTHihbIhdloourig2rtnJ0Ps0WO6odHbDiU+sD7U8r2O8dHVF/SdGLw4vM1l81uhKRR5h7M0dMNN+308rS7VMXiLA4DYmtcwZuFHMzYok8tWIoSHCpqm11a5GQYCKuXlRaQ8RRdjomBzgN1cZpWS4je5Cj2EqirKEvGuTdLoxcg+yL12RQWq2Yn6SU7HN5bDTVnwug0eDuhP1CPFYDNQPJBm1LHUksjRBBLl8wm+s3NAJCGmF2LG9/KnKt6Ym9xS/CJucXdiodYDv2vUaeq9fO0wCZ4NE9Uc0w9hLJTW53PH7PqJ9HEe68L4Hy1WsYt6vo95A=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(11063799006)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nwYoaOkKfiRAcegVH0DP7PBsM2rkJ/40fZ8wj4s8eODltx//dCqKkAtt5GkZqRu18nrj2VxJrW2QIS0922ZFw6Np3EN+L3Px3kGriHDM5EijyJWOC+Tzr6fek4qCCkXvFqRHjU4tf4yJasvrAU/8ebklSdTRurcyZ4iV9y20+bqn0V/wKcu9VUGC6Ee3/eepG2zFK7nnxPcRB+5GeJG1OAESxmbBtWeMt4dGAugZI2qdssAjq6oPOm8xziHr5h8bqD+J7r6t/49vSJpXK8CvPx5hNFs044sH7c9F+0Loatwcl/EFZijx+B9bTtsXMx3foUk0YQGtBokGXayajZ2mJ6BlDT4uEWwsGC32dWhYzwzjs5ITridqD+Ta3v9pjnHIL3Xwpck2mECA/c3meXEcEKbId1Te4bLCt3GxNIvjgwkmF8FEcZkc6OXPcPVRvqZD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:39:14.3864 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f9bb93-231d-45ce-c734-08deb592df0e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5844
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


