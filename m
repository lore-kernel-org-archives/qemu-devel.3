Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163F5606A31B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 04:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=awYMyIcl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPB8s-0002zS-IT; Thu, 05 Nov 2026 23:01:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>) id 1xPB7d-0002rX-UD
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 23:00:14 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>) id 1xPB7a-0004LD-KM
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 23:00:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPfahe/pwY0WicNrQZHLP5vYvMGqlWT31dRkS6NOj9lLd14JB1BWRGbtW0tlOKrR4OfiIG5PscAdl5S2cghz6vsh5j0N77ZNy3xDTw3yFzMDASxSpflVeKvkXnTtfIzkl8GPULA3J+Hzy0R72jZO3MofarBFFTn/zTkrCUbU0k5EvsZizSN0IElAnKeLC4ffBDuY8nOFgMaZZksRhrlKYYmpf92mxWMkh3iGvlH6EMyxAr3tNhMW2++3n6yskbfT+heO5aZEUfL9nEU/XuSnG3RWwOhnyiMtKbm4lftNi9vYuqJuCCY5oT3VGpGTk0gGWizlVHTNC+Omf/ZnMWpuGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2oIRhr4+PpV8qL2ztAHDI1I/psYhZIPI965XzwrCJI=;
 b=bw4JVxm0QQtubsVwX278LOvFliiz36q4azKPd5JzRrEWOt5uRuFpE7U/hY6n9MiHOtJJLvAvvACD0OKF3D+0Pzjy+XwPKbaSsxrufsYDolsufozIXFOmQ7CtP0RgUcVBFqV3/Isjop6xB5HWOpTs7a3SHQZ4R5sCAw28z2vZQPGWZGyuRshHafhjRsHNanP9HAwPICa2JbY16a84OuCAIJWbw22KQW9Rc0yH6U2Rd0ZbQgo7A+Sksbzj32XzwBaJqp8HjferGZHT6wEQMVwK9eoJye5OwawFOAXRJO8fWLkigkALMnFKmyklNL5416C7lEW64HtA4sBrr+sVrwz1MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2oIRhr4+PpV8qL2ztAHDI1I/psYhZIPI965XzwrCJI=;
 b=awYMyIclXE5e1hVnKya56GpOxMcB6wsF3agx5dS+bpuPmfk2aRIxdSVYSTUngaXvfcm19aqI5Q6ubkXJGcXNotG3mCG+7BdmdXC7/wjuko2Spx+2avJ3HcveNdOoShA34FHNEkkQTPzmYd3qUH6nxF8U0DIE4PIGCTrbo1dEjEAl2WPDhInSEi/ybPgLydfAPzTFipXPwYhrGYcs8bNq0wuWZy8lgZXLiBx7bz+yTrdM3iLKTyUIpdno15WH7cLKnx5BRSkTUXNh9N8A0PRSLph8lI3/1UWmjbucT1YD1a37jWEvuA1r7p+M5jxGaMa3TFN/DW00nQghhkjKIb2cCw==
Received: from CH2PR19CA0004.namprd19.prod.outlook.com (2603:10b6:610:4d::14)
 by CH3PR12MB7643.namprd12.prod.outlook.com (2603:10b6:610:152::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Fri, 6 Nov 2026
 03:59:54 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:610:4d:cafe::6b) by CH2PR19CA0004.outlook.office365.com
 (2603:10b6:610:4d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 03:59:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 03:59:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 19:59:38 -0800
Received: from cxlgalaxy.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 19:59:33 -0800
From: <mhonap@nvidia.com>
To: <jic23@kernel.org>, <alwilliamson@nvidia.com>, <clg@redhat.com>,
 <xueshuai@linux.alibaba.com>, <ira.weiny@intel.com>, <zhiw@nvidia.com>,
 <mst@redhat.com>, <pierrick.bouvier@oss.qualcomm.com>,
 <junjie.cao@linux.dev>, <anisa.su@samsung.com>, <pbonzini@redhat.com>,
 <ankita@nvidia.com>, <vsethi@nvidia.com>, <skolothumtho@nvidia.com>,
 <mochs@nvidia.com>
CC: <cjia@nvidia.com>, <mhonap@nvidia.com>, <kjaju@nvidia.com>,
 <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: [RFC 01/18] hw/cxl: Give the component register .io sub-region read-0
 ops
Date: Fri, 6 Nov 2026 09:28:54 +0530
Message-ID: <20261106035911.1280066-2-mhonap@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106035911.1280066-1-mhonap@nvidia.com>
References: <20261106035911.1280066-1-mhonap@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|CH3PR12MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: dcea80cf-d668-436e-7c8c-08df3bba6a96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|7416014|376014|23010399003|1800799024|10067099003|22082099003|18002099003|261021123027099003|11063799006|261026140227099003|921020|261026121527099003|56012099006|261028144727099003|261009223027099003|261102123227099003|261022105027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: 5zEDCr8H4hOmKqeBqTXO99/HujlG9yFBm+hWnyi3/1qMUmOSAD49Aee4X+O0XUEHAsRn4YKep5LqVQ2MlwByBakf3GylV5+YhzfvpKrEDf4y4dBYMftywk9l9F7qOolb/08nRfGOHIwU0y18ZuzYkcHVYQAwNaHSgyEVHv0EZihYg+WW6q+mq+fh8NgVPMSdbQeWO/QG5MSKpCvT+knNcp+59f1BEmRxZS6Lw6eiONaEPXLbrYf7xIFUcQc8oghCwIY33bn/xAUcU/oJhZuiDEtXX2NRbU0tHT30t/ctW9/qQ/XtyR4zC12ZBnLfbpe+xmxnXEhZ468ZjMsGEYiE1WtZVp5d0D9i6hiKYqW8fuk94a0qKU/AH34LzYMbOaQz7mSImlvYguThjJ/AypiJ25lK06hFejVFv9jMmZe5WHBTrrymJWDY6UObxcXfkyR8hRlWlQ8wlPc7K7JDVPQ3hb9nU40B4XBwtyWb6pe1WQ4PNUktN57JGcQukVG+dBYrN3P7y9Xj0YHThNaXqzgoF4kLfNq5H2tc3inTB7/2qoaYj9i8Kbd7aIJM14wOScRVIIOXIruwaFM2jXH/LEPKC4Jk8Q6NohiaDKO2fPL6xNGOAVlQ/snBRC8IVbR0lKBtAdZM5OGUiAC1sZDnzs1ScI/Ec9jBQVE5Gb16GdOtpTI6K1cxGaalpi/fZibiVpdI7DcvuUzUZcpb1kzFpqa6OK6OuHs3CiF0Cxsqy+WSwB51HQBgs9T9P/4nawKqVTwS
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(23010399003)(1800799024)(10067099003)(22082099003)(18002099003)(261021123027099003)(11063799006)(261026140227099003)(921020)(261026121527099003)(56012099006)(261028144727099003)(261009223027099003)(261102123227099003)(261022105027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EpHCs8TY60Zj7fWBedWG3rlGywqzBaYxx8HZ+wSSEq9A6e1WY6YQ4SEf0tv/4uaHxcvMxhhgrAYAW9xJNGJZXNDNPHNK3kyWWuKhZ/pEzKiJTpFLe8TpDYGT7hMM4aH7lwqtg330dR3l11KBrqG14KtJbQLlZma+492KruUngWLiAV50GbnBCtjauWwThJyd4gCfAV4HgwvsDXHX57Ee4oFB2ptaNXAcIfqwuGiFoaXQv+BZLCuy2Zysk8LPZuGguUvk4Fpv5CZwPQmNweytu4fu5OeMGAUSmHAIRY/fSPwbR6EGz7uJpzAox7LrgvBjZI9MQyd9BfvDDJ/wRdKjQDSqhIp5kYcaMoPlnU0TagpcsiSDObkteEPblm1O75fcYKc3sQQTk4+OZDSrW8ylr/m/WvjnMT8brsAE8yA1rxytRuMqFJYOUBsMua+KKKEu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 03:59:54.6387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcea80cf-d668-436e-7c8c-08df3bba6a96
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7643
Received-SPF: pass client-ip=2a01:111:f403:c10c::1;
 envelope-from=mhonap@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Shuai Xue <xueshuai@linux.alibaba.com>

The .io sub-region of the component register block was created with
NULL ops, so a read falling into it (e.g. a vfio passthrough pread of
a non-decoder dword of the component BAR) failed the bus transaction.
Under TCG this raises a synchronous external abort on Arm guests (ESR
DFSC=0x10).

CXL r4.0 Table 8-73 reserves the range, and reserved registers read 0,
so attach read-0/write-ignore ops to .io.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
[ mhonap: drop the comment above the .io region init ]
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/cxl/cxl-component-utils.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index a624357978..fc32be77a9 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -264,6 +264,23 @@ static const MemoryRegionOps cache_mem_ops = {
     },
 };
 
+/* CXL r4.0 Table 8-73: the CXL.io range is reserved */
+static uint64_t cxl_io_reg_read(void *opaque, hwaddr addr, unsigned size)
+{
+    return 0;
+}
+
+static void cxl_io_reg_write(void *opaque, hwaddr addr, uint64_t val,
+                             unsigned size)
+{
+}
+
+static const MemoryRegionOps cxl_io_reg_ops = {
+    .read = cxl_io_reg_read,
+    .write = cxl_io_reg_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
 void cxl_component_register_block_init(Object *obj,
                                        CXLComponentState *cxl_cstate,
                                        const char *type)
@@ -273,8 +290,7 @@ void cxl_component_register_block_init(Object *obj,
     memory_region_init(&cregs->component_registers, obj, type,
                        CXL2_COMPONENT_BLOCK_SIZE);
 
-    /* io registers controls link which we don't care about in QEMU */
-    memory_region_init_io(&cregs->io, obj, NULL, NULL, ".io",
+    memory_region_init_io(&cregs->io, obj, &cxl_io_reg_ops, NULL, ".io",
                           CXL2_COMPONENT_IO_REGION_SIZE);
     memory_region_init_io(&cregs->cache_mem, obj, &cache_mem_ops, cxl_cstate,
                           ".cache_mem", CXL2_COMPONENT_CM_REGION_SIZE);
-- 
2.53.0


