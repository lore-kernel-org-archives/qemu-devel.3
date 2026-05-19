Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4161ACD5BA3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHrF-0008K3-5f; Tue, 19 May 2026 06:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHr8-0008Bo-GE; Tue, 19 May 2026 06:39:24 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHr7-0006SI-2Y; Tue, 19 May 2026 06:39:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4uS3X1q9tBrHZBSCHa662O9RsxTFNLni2qESmtx983B/9eBED02bK81iWdDJiBXudSyJDCc+RsiMV2EMdffWu9ax/07tV4tT0XiX6aLM2rXpkxBJRjpVD+Qluxl+87969fniQzffb034M2/s1TFEDMu4RjH7Dkd3Eb6wnpBqvy4ZQLiGBsnAm60Ho21oaM3iddYTJBaIWLea2DLIDOHZImejUt7dWnd51mVt0+2JeyMcvaxssn1dghVqr09i9snPgs1Dc8t4IYGplhx+JKM7n5ZC+SeJme9Ps8N70G/ZA7S8PyUdCShu0Ihj9gIsNAfQxiiRqdboSyGgO4vs0RaTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhNrQCihf+DjDeMqIVYm4bXU+bGz60NlRZq+evYtsNs=;
 b=lrB/5Ak2bqGXtB2F7LNi/XVJhevASgvvw6sWfWLnxqSHX4wPrB77O5TpBgNtit/tzjj0Gdk0MFefAA39fx+iSv6dHtzmiyUezQYBIptzlaDtJwsrY6Yctx5Jd28F+9QwM98jQ6Yn/KMgN2bmxQTTCaieA9bRmabDIt1LSq7tqHzfh4uYQ0E8Mm/YBhQLhmr/orSJgp4szY8yKZUTHZ1C1vWkSQ9qUmtunDm6WKPeBj+6U3hb3zUUjubdfoCXlOjRNHN/OM6JL1MhouIu394074x2kNlHt05NYX1aALXYG31AcTifbGDiridrxiIDoaye1KZt7OOB+542B7STte2r1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhNrQCihf+DjDeMqIVYm4bXU+bGz60NlRZq+evYtsNs=;
 b=LE/l/BYBl8ufh3WimlcyYo/MugfweiU0OIE+uQPUYE9oCimdmC8nDyEdQm6t4LlElcd/rP7A/aoWlrNLVSQR4YqqJP9MAEkqgwkPuBAV1p3Ur4a8tH/Tbmq0jGwc3jSxAqVD4lxUPkIUp+KewFlsMg9fqYpUlaJ+9kNJpcuT24tshc3z31GsDnlzvbecVB5C1DNQQVjejIAXgY8zjCpLCvV68WUMFTPnwdAhDngub/V6cM5JMn9r4IHdY065dt7vLPGSRbxjy0Pfezah4Y9EZ7cgOZyZMYjdI2A1iDUPB0eeE5SaLYwm6JtA2DeY6Du0p98LlVOCbRBvW1AnIVG3QA==
Received: from BL1PR13CA0394.namprd13.prod.outlook.com (2603:10b6:208:2c2::9)
 by MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 10:39:15 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:2c2:cafe::37) by BL1PR13CA0394.outlook.office365.com
 (2603:10b6:208:2c2::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 10:39:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 10:39:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:39:02 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:38:59 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 12/32] hw/arm/virt: Link SMMUv3 CMDQV resources to platform
 bus
Date: Tue, 19 May 2026 11:36:50 +0100
Message-ID: <20260519103727.899332-13-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|MN2PR12MB4256:EE_
X-MS-Office365-Filtering-Correlation-Id: af624a78-4566-4b14-2fea-08deb592df7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: KVsWcBio2TmHnBtpmbjkyk3gj9+ekfj8ci3zLzIg2uARzSJtr0o6kKh5Xpz/oG0dtLLZHDIeGuIvfnZcC3t3NXszUNblzVw9bOJdZC8n2QIsmGlfrzVLBANnYrqavANCCvAx4TB/Z4gmw5S7Latbnm16LfAhB8YQRCPEdwHm2KFUt9esUicdpi34ll5VR21lr9X5CLpKAM+sZ9JoQOa8oPTwoJ07Y1e5zwPGIV9fkRwYrjDxNqrm8Vn27iV0o9RYQy9ttklSrSWMm6SwnoInW+fHXWmmtnBscAN860GyGOpMUiVirokNd6s2fCjjFJ4OkfHIl2fgdAk8r1LzOSYPwj6bphUQG7X3yTZzkJTA/vJfLoksRhx2tyj7ZoPntWma10646wrFsi+xZwLg8kewp7Ymco9aNGzHgj9yURbGdbMRZzL+S8OiuSQ32uqxr+L7Yo5M2v1v+8mehPuDV0hSF4Lh5lyNPqGtHJl+6REUCASLil4KuCC8Xf+aywDydhROFRJqD5uoZHFp/CqF3LfoAAjcpoHn0MRMikkmIlFp9VJP4hFg9o7md3gHtmZC5lrUu6IicKiD+DKylxeUAZEguCtghaIpqdX5AKfcCn+jJ+enrtwH1JnKshfGthnewiD8LGQ2PTcWM+oPjE75u9/w9Cp+SPwsFzSzVDv1MN94dJ4LkLATn/NvdiWEl0HNxwZpWqOBWdasyNyqgbYwBwdsCigFpvFvCxV7F3JfknxgqOU=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(11063799006)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sBjil5EzyR9nb/TwgTQQXQ+w1nnKmpUk4MxZ3GkjqQgcwaXo9NxLo/iFPLTTP8uSD4NsZ+c3Usu/jex2nK9/ZMq7Is0+qmGge6S/aDO/T9QblU6VKm7gmcgzPUOUcT9XtUzmM3iQIgA/cCQugxixkyg23i6WLG2MYjx1s+J1Pi2oAKh6FtFqFpgCvhz84WlVJ9XrfzYmphlz3k1XRPG3UZHK0f7vY5m9PXdUcDGFvp/lQN6aPtLUxhCK2VEoPuiXVGJFuws1vUHdZNEEDr0mk1Cr9sOAWBy4Xk3p2df+6+EaYWWEMUZzRNmI99jG6ht8Q/pS/zsZjWJ91GkWmt7f7nA1OQsleOZuUvekCf8l/e9Ue8bu9ouGhAascoze9NHI0dVDB0e6hKJacTnQDisBAR2NYHhsPnIX5vqVdJUpCp2MT/4l9UhX0YXEUHCQCVkt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:39:15.0668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af624a78-4566-4b14-2fea-08deb592df7c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
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

SMMUv3 devices with acceleration may enable CMDQV extensions
after device realize. In that case, additional MMIO regions and
IRQ lines may be registered but not yet mapped to the platform bus.

Ensure SMMUv3 device resources are linked to the platform bus
during machine_done().

This is safe to do unconditionally since the platform bus helpers
skip resources that are already mapped.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/virt.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ac0606fe87..2add7401a1 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2361,6 +2361,25 @@ static void virt_build_smbios(VirtMachineState *vms)
     }
 }
 
+/*
+ * SMMUv3 devices with acceleration may enable CMDQV extensions
+ * after device realize. In that case, additional MMIO regions and
+ * IRQ lines may be registered but not yet mapped to the platform bus.
+ *
+ * Ensure all resources are linked to the platform bus before final
+ * machine setup.
+ */
+
+static void virt_smmuv3_dev_link_cmdqv(VirtMachineState *vms)
+{
+    for (int i = 0; i < vms->smmuv3_devices->len; i++) {
+        DeviceState *dev = g_ptr_array_index(vms->smmuv3_devices, i);
+
+        platform_bus_link_device(PLATFORM_BUS_DEVICE(vms->platform_bus_dev),
+                                 SYS_BUS_DEVICE(dev));
+    }
+}
+
 static
 void virt_machine_done(Notifier *notifier, void *data)
 {
@@ -2377,6 +2396,9 @@ void virt_machine_done(Notifier *notifier, void *data)
     if (vms->cxl_devices_state.is_enabled) {
         cxl_fmws_link_targets(&error_fatal);
     }
+
+    virt_smmuv3_dev_link_cmdqv(vms);
+
     /*
      * If the user provided a dtb, we assume the dynamic sysbus nodes
      * already are integrated there. This corresponds to a use case where
-- 
2.43.0


