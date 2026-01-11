Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C32D2502E
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 19:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf1aX-0002yG-5t; Sun, 11 Jan 2026 14:59:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Zn-0002Vv-7f; Sun, 11 Jan 2026 14:58:18 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Zk-00049J-Ce; Sun, 11 Jan 2026 14:58:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYxH38s4e6fvGoCqGN6Awz3l2YcxmW0NuD1bp2g1+61YesCZeRb1uoTwcLF0V5V748HqBzeAFo5jFiCfhIskioeVkbuk6FsA1aIDkWOAOV5xsxAUFifRwk+R91l5NulbvFOxWR8ILRRFsM7K5LcH+pwlKdN9xvPguVY7abJcbX5dnyTkkLllNUkw1vLAGDiG3EPYQ8sUyw4ok8drycOmsTWAJE+hEDiXC2awXvhJcLAR4sgXfKbiWgiDfhYvNytY1ZACOnupTcUVggpaeU6bZglE3vpPbNd6DcVJMRcBd3edBqqVVxSnADh7EV+PvAFvqfcwO1IJ8+d5Mv63X6eNuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uH2twHtJr7H2dW6oDKHOrxZhJ8DuCogXU2858oBv8JU=;
 b=YTPX7d/vYpRT5ninNYfoJRbplbIkr0SVn8Bw7sApD/Qd8qFo+NskP63fZhYxcazqNOTtN94bYaZTkV4EBdLNSCm2GSVFA9IXvm4ujsMsbl5QJUZmGLtJuif5Jn+CYtcjOZ0IfDMO0Zjvgeh8t6r9QagR3QVmFEzBnZlMOnW0+FqGGclDH1y91tVV7oJsqHbApj7gStpLJi+WaoxPJrKxm4g+ovW8vuq3OeGxH8WiQECKg2Hj3d5XKO7XjGXAHeCHqrEMCwS7SN1xhuDYt4Hjaxt0GgaWlknQWnWP3VARVJIxkgZaPgWPGebQqJwz+8SZq4VMf7ZQH82LjPO1xErV8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uH2twHtJr7H2dW6oDKHOrxZhJ8DuCogXU2858oBv8JU=;
 b=FpUJqtXgnlOx6RayJms0d0jHXd0kjsFQTZVL+8BdZUc4wAFKBYCnHZGJYpHeeqxD/AXTRkV4uaHrpVBxJZ2/drzsaSsZVXOG/yt7Nu/ca79hPj35FRdA8xjBcPYbXlReQHmMgdSxG9nbdmQ//HAHYwMuR82XuvcGJtBgY2OkEqvxXYs7Q1b7XsSIuTfrn+56JnVVnlTHDwymW7RZeP+N5CiWGHpC+De1bqyWsERoPHxmcvnBNhTJocndOAiJpyZAh7gaYE0FwXIrQB257U2gtBcfKtnEzGujTnJJ02T0UDT+QrZ8ROplmBCWWtCop5IAEbOhvEQyhCk0XRzo2sO+GQ==
Received: from SA9PR13CA0134.namprd13.prod.outlook.com (2603:10b6:806:27::19)
 by CH1PR12MB9623.namprd12.prod.outlook.com (2603:10b6:610:2b3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 19:58:06 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:27:cafe::72) by SA9PR13CA0134.outlook.office365.com
 (2603:10b6:806:27::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.3 via Frontend Transport; Sun,
 11 Jan 2026 19:57:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 19:58:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:57:58 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:57:53 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>
Subject: [PATCH v7 25/36] tests/qtest/bios-tables-test: Update IORT blobs
 after revision upgrade
Date: Sun, 11 Jan 2026 19:53:11 +0000
Message-ID: <20260111195508.106943-26-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111195508.106943-1-skolothumtho@nvidia.com>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|CH1PR12MB9623:EE_
X-MS-Office365-Filtering-Correlation-Id: a379a3a4-b417-46f9-87b0-08de514bbc7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Qao6ueKDdzofXe0LpSbXE8hUwjwI9k3RQ3HfBEocCvkcaM641y01uSXo2Sro?=
 =?us-ascii?Q?pH3H9Jhg+WKuVAFLRPKrEpyyKyGsIRK36TUKK3rf+bqIonVL+tQz52Hn5Zhm?=
 =?us-ascii?Q?LBvoGavraom0NIMAkKlynPWFxIn1eqJyfphqbQ75oOn0osUeB2CTTb3CdYHy?=
 =?us-ascii?Q?Hn5fyKIw29pr5s2dTeDStehLp1ufO8EsPfqhqzX758IZjiJfvGPxT4urzaUV?=
 =?us-ascii?Q?UsMiasjCBL1a8XFgMIh/wq3ayshME1iaqR1zQ3lMT4IyhQOAokgqSyNRf/Pk?=
 =?us-ascii?Q?8Cq1+MDnrSd/XmbTKhTG0JNm//pAE2L8bILuQ4kR7QF6cmieQS5eVWcVJxJ/?=
 =?us-ascii?Q?d1QcBtusi2XCFsnvlQyqF4xIJPcZrJ2LsxoDyn9cKHacKYFQOR9w1+hx8Ozi?=
 =?us-ascii?Q?BEc2KaQs/6cqixYkW8mVMdOK8Q/3D31eN8wtfXhVvXQC2vZCK7MSPDEZKpEM?=
 =?us-ascii?Q?BuY//MWATzBLvwdiZsNd7Yz4V/GPN0/Rgzh/k5TEKwZpo69C7721nmKHjZKy?=
 =?us-ascii?Q?pM8Yymq0Itt5npRCPaR6zQB/W20rIRnvnef8wLmiXFj2ZyzSabtQO4+AuwnX?=
 =?us-ascii?Q?QmIkeqTraQGTeEDksjou5GQUtUtvihQY2JY3gzuexTY9lNfYnpWGnP1U2GsJ?=
 =?us-ascii?Q?FLWftbYCl8J+zH+O6GbrtcLjvV8jb45xR0HllVbn65kQrwL5mHu7NNRjFIuJ?=
 =?us-ascii?Q?4jDKrhXXRxfeeRQK89SXl00WaejZ5I5yjAykS+s6YHY6xvfPS/bSPhad61hy?=
 =?us-ascii?Q?0sBUR5Jo8ewzuU8vqERpzTcnQxW5k8K0InXCjhz8JKt1aja+RxYbbzz6OgPU?=
 =?us-ascii?Q?FPXB5I8FUdaH5MXMUj7HGbKadgliXrMmoIjrpX/3yk2KSm5m6WuWWT5QX9Vc?=
 =?us-ascii?Q?hU1zFbBGMlOeZQKy/aPbV7G8bjuAns3L63Wgv4gjf5jRIcGdIaRcQZwnD9Zg?=
 =?us-ascii?Q?j9DxaCGH1p+Nx8rBEdG25GE/PnUSsOn0TtiuEDFoL345+9m6EY0OPYIq5jB3?=
 =?us-ascii?Q?uQkYEtH8y/S6u6Wq1t98P4o05ew+FmH7kzuw2EqmGBxjMy7+K8UxuY0dOBcN?=
 =?us-ascii?Q?Bru1/+SW+/31ePO9Tcat8VaQ+wnVnot8dVdKwN7gRM3tVU5MDNtBGIIkrZ1/?=
 =?us-ascii?Q?1k7l1oEUZ/o0xfpjukqqmBU2TGoZ5gHtd9oezurVrFWK4x4nOHr+E2y9mTsj?=
 =?us-ascii?Q?2T96JSYgXeYedom66vpsQYkmZTOlsgpfyqcj7zaI1OCXGUrVVFeKg2Km52hI?=
 =?us-ascii?Q?OioULsixA6RWi8ml0nikU20YmxlCCdpikjfLLBwm+vkUT7dL4XL6uztxyOJU?=
 =?us-ascii?Q?uFALSxRHEHqFgqx3smjo+uZA62kpkJaSgVtdovyjSR8htdM4TTHXckSvXKWN?=
 =?us-ascii?Q?1ApUu26MnAzePMTzFHonYxOpAwQamGhGKV7rddvheKMJuMlIXHGm5PJWFfAI?=
 =?us-ascii?Q?MFqXVZOiOkQ4vqpcw4c3fszfLefp3JJaxhXR7ZNsdrkOvlzT0FTOcUwF8mFQ?=
 =?us-ascii?Q?JeDgnUbz9GzC8LideSNkEApTX9QOpZgE5XAMFSpScNz36K81MUmQYAeKyukC?=
 =?us-ascii?Q?rdm18ySa5BOLcrRuk+w=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 19:58:05.8319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a379a3a4-b417-46f9-87b0-08de514bbc7c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9623
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Update the reference IORT blobs after revision upgrade for RMR node
support. This affects the aarch64 'virt' IORT tests.

IORT diff is the same for all the tests:

 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20230628 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
- * Disassembly of tests/data/acpi/aarch64/virt/IORT, Mon Oct 20 14:42:41 2025
+ * Disassembly of /tmp/aml-B4ZRE3, Mon Oct 20 14:42:41 2025
  *
  * ACPI Data Table [IORT]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
  */

 [000h 0000 004h]                   Signature : "IORT"    [IO Remapping Table]
 [004h 0004 004h]                Table Length : 00000080
-[008h 0008 001h]                    Revision : 03
-[009h 0009 001h]                    Checksum : B3
+[008h 0008 001h]                    Revision : 05
+[009h 0009 001h]                    Checksum : B1
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
 [018h 0024 004h]                Oem Revision : 00000001
 [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
 [020h 0032 004h]       Asl Compiler Revision : 00000001
 ...

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 tests/data/acpi/aarch64/virt/IORT               | Bin 128 -> 128 bytes
 tests/data/acpi/aarch64/virt/IORT.its_off       | Bin 172 -> 172 bytes
 tests/data/acpi/aarch64/virt/IORT.smmuv3-dev    | Bin 364 -> 364 bytes
 tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy | Bin 276 -> 276 bytes
 tests/qtest/bios-tables-test-allowed-diff.h     |   4 ----
 5 files changed, 4 deletions(-)

diff --git a/tests/data/acpi/aarch64/virt/IORT b/tests/data/acpi/aarch64/virt/IORT
index 7efd0ce8a6b3928efa7e1373f688ab4c5f50543b..a234aae4c2d04668d34313836d32ca20e19c0880 100644
GIT binary patch
delta 18
ZcmZo*Y+&T_^bZPYU|?Wi-8hk}3;-#Q1d;#%

delta 18
ZcmZo*Y+&T_^bZPYU|?Wi-aL`33;-#O1d;#%

diff --git a/tests/data/acpi/aarch64/virt/IORT.its_off b/tests/data/acpi/aarch64/virt/IORT.its_off
index c10da4e61dd00e7eb062558a2735d49ca0b20620..0cf52b52f671637bf4dbc9e0fc80c3c73d0b01d3 100644
GIT binary patch
delta 18
ZcmZ3(xQ3C-(?2L=4FdxM>(q%{ivTdM1ttIh

delta 18
ZcmZ3(xQ3C-(?2L=4FdxM^Yn>aivTdK1ttIh

diff --git a/tests/data/acpi/aarch64/virt/IORT.smmuv3-dev b/tests/data/acpi/aarch64/virt/IORT.smmuv3-dev
index 67be268f62afbf2d9459540984da5e9340afdaaa..43a15fe2bf6cc650ffcbceff86919ea892928c0e 100644
GIT binary patch
delta 19
acmaFE^oEJc(?2LAhmnDS^~6T5Bt`%|fCYU3

delta 19
acmaFE^oEJc(?2LAhmnDS`P4?PBt`%|eg%C1

diff --git a/tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy b/tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy
index 41981a449fc306b80cccd87ddec3c593a8d72c07..5779d0e225a62b9cd70bebbacb7fd1e519c9e3c4 100644
GIT binary patch
delta 19
acmbQjG=+)F(?2Lggpq-P)oUXc7b5^FiUXej

delta 19
acmbQjG=+)F(?2Lggpq-P*=Hjc7b5^Fhy$Mh

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 3279638ad0..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,5 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/IORT",
-"tests/data/acpi/aarch64/virt/IORT.its_off",
-"tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy",
-"tests/data/acpi/aarch64/virt/IORT.smmuv3-dev",
-- 
2.43.0


