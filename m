Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760FACD6E56
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU18y-0005BM-QT; Mon, 01 Jun 2026 07:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU18v-00053f-GW; Mon, 01 Jun 2026 07:49:17 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU18u-000522-0V; Mon, 01 Jun 2026 07:49:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CIN6BqCn4h4I3sWzVn1EM+bR+/KnQ0xdXmRkJNQhOYe/Joq57Fb48D8HMH4SZ1ICX/qaZq3pzBJsIO+R8UXzwvaqs93CbmTVh50j4WDw5gkvctaDmlqfhcA5mGQSpr/s8roIoW332DHMuTVnMEeirZNtG3+TTFZQ4AH5x+VijPLSJJAMqAoTWGlcmzHof7TSvAD93sbT56B+sJ4U6JpcbWre38o1qBhSxsfS1PWIYef6rSEMdcRA1mGrgem3Q6Njgti9sSnIFtfOyQ0LxJNV9KPRu2COB6JD8MynbwiSX0zqLgZIam9a4rLPSbVmgdaWHGIHo7fLhoPrbZc/edsyrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhNrQCihf+DjDeMqIVYm4bXU+bGz60NlRZq+evYtsNs=;
 b=wfhY37WNT6UDfwkhS/2royw7ysM7xTpJNR8dy22aiAIpNSpGVD0myJoaVpcIOdM5YTplsSGBYI3+H4ZJ3nN0JWhIBqqkXB53ivC5GxYqg7KXZi2hLIiHCh+ym+DkUlH/orFVdIY216phu7DOCmRULBDxx4azF5FgWN039XZYCQ8V0eZ3197mBVqxupKslknMAvG5/cJNB3r5HAqh0LHXAqp5QmmPbOIhxmXs9Q+OtXD0hMHzBTLlh4IVu+4j9M8dYM09h3rs0b1o2oH1fH2nRYROO0fBkqe4kbRmREHjxqWACTOkmsBwKkPq5NPjk1ldrQ/bXbEx/hRw6PIuXIJmyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhNrQCihf+DjDeMqIVYm4bXU+bGz60NlRZq+evYtsNs=;
 b=mvt8uFVWQc2k/w0nBuEzi7jTKNGIGNYqU3Ot8jiBn5fRVk/di788S8vYvFEYuDtRCqHUJkJiu292tthqhkkBHa1iY6Fb+PQrRoAiFOufFxSFtIA1X/29PLz8VpwBzWOB2I4CG92ZpzkHYX5zlORKe5jwDQ86uQNOU80gRHGbCCINsZDUZj854XKP0BINqcfqYB7wmyEyxaFKUu57gN2tcf68wdG3QKczWHWvURXwHQ/MkeciKiaMyBSgqzql1RoRezm62FGZJZWXcgJZ25Szpfd0UmWtOilXh3GTo4kdKiOjnzZxBBCaSgOB/gV7pd7nj75gVTiSv44TX0ujCQ8ocA==
Received: from MN0P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::21)
 by DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 11:49:05 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:208:52b:cafe::65) by MN0P223CA0008.outlook.office365.com
 (2603:10b6:208:52b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 11:49:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Mon, 1 Jun 2026 11:49:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:48:50 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:48:46 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 12/31] hw/arm/virt: Link SMMUv3 CMDQV resources to platform
 bus
Date: Mon, 1 Jun 2026 12:42:02 +0100
Message-ID: <20260601114221.457995-13-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|DM4PR12MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 91ace266-d184-41a7-3d98-08debfd3c827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: y4Nkd/fEtaq8lt7DbtpZSZqOnOGQzhLjDtvYGpUNzF/Yl/MT6C0Z/k3CuXbJYYqXva4Kju4pgelG3LdHAZycqJipdgPQvtaNiDwyOmrCyLM+1BPFxARX5muflSkje9bF4/WdsB+xBUwUyh4jju4jWD9qhuscnYF7Lp640kurjpONOZw2VfLSri2Edm0hRdjygcWfxe/uRU+FGQsYF4gRgxjXaH7n/IPj8ZtXtHDXTIilpA5HAAae9ym/yrbd7LK+pFUnoVNI+30eRilh9Aj9UJAwGvAiX9CBaTJgHPbbQvf+cWQ0WM4yOLrjb/4Uzr9eACHKF3eWN4xMNkY+0BuV6SYE+KLvYOaSra7WvIYNxn+14CFHOgvAPNreBzhmsluPWLXIV+4CNOCdp/zWzZSFx5b/D+K3xbL3eaIfIWxeUHq7gn6KUSwW/k8TOZla/aBTKhbmuL1Da43IL889RFWQ65TXBW+OwJ+clsPS5cEiaDgtF7kNQJTS+/u3s4JWLxTjqlsq0fCnTjMoABVan/0u5X24s93VtiPhwe9FIzb8xPhhVAZ1+U+vluGQUKrMMCSXY3jathUm92VDDEPPc49u8xZoYSrtaneiMYPmW2J+bQ+xy2bgcgqe5ncN7IpP700KhDqwkQSQyPpQ6/AwMBCPQde7ZAOhYnmnWJ6MVpa+/SyIJRxfKlXj8yXQg+cGePQMfW3jTTWkuuQbvchyzLu0NOcGmCas4zJ0nSAH+gXLIRw=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wZzu92qDTy1K39MKnP5m7sbUCWx376og22Cl/Y5TjmBNrlif5yT02/SJmHMuQTWmMj0RgSJTQ251Mqg76+Zx5Amw4zDoNtylV0MelbHlIZG8c8m5oSAqZ8gaOv7zjl7euTSdRA1rMowh4FxkEe9iSYI3bTjoTw9NW9+uYRj37p0PJWgqrEfg1mogpauHXPm9LkvCG8lBdlgH49ToZjbUf1OYNAnG6Om/gpk5vEK7z8BK+30S0AkEXLJl6dURmP/fWBuof6pju7x3LUiHFMwuugAXikfsluBpEfK048ZWU+mXowNU1aj9dUztatLdLxK5stRGsJUQq49WN8mjOhYNxYvE9rKxf6oD7yHj9llWgUUY4TrpqUYRpzPNxqODiZmyGEyhJHul0tSAJ+IxDoj62WlkH8Lep0ytnu3MzxClwNb3dr7T3nubyDE6bZH0ZSBV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:49:04.8282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ace266-d184-41a7-3d98-08debfd3c827
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7742
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
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


