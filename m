Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D48AC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh3w3-0004PD-8M; Tue, 07 Jul 2026 07:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wh3w0-0004P1-RE; Tue, 07 Jul 2026 07:25:52 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wh3vy-0003lI-E5; Tue, 07 Jul 2026 07:25:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/1EitT/11Hu6Ls0H2Er78cAgGVPTTe6n7h6NKo6tzZIi1Qxz4tvKCLiDed8Kzu/xxttL2UU7MIxmOOtattbQMRsEvP9ksocLltG7uKw0B4uVfJl2RjkPusYGFXM9LXOTKAcW7NrtGA6xHFJw+fniui0pELf8HGbuizFnz99BjY5OAm50Z9dFsrbp+gFKT67A3y9m/rlHfN/0c13cCMcAIw9KoGoiYa9AAcRle9enmuh097TvFyTvxDvZ4C2X1g73YzimvboJJ98JZaK8vayYsdJcjA33MJLcGUJu0amT3jfWFuUAYRwHvZvcXuHxCjVJrN29aFTvX7g1JuGJlIUYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ob5DSvitCiOldR6aDRNT5IDYoUCCopnSf9oAg6XhIgM=;
 b=TBvU9VWAhlgFxn0riApkXd6/A1h92r3q1z+tKEd4gvX79OhxKkS5y1NyPaBCSd4hkTckngmVM1Gfw6fhtvP81j+Bef6I759SXWCwXEib9SaLB6+t/b7n/mWsPeh4dMU4UqvJY+LICWYDrJHSaahu08UBunO0KRPcqpdq3IXRoHwG4FCVLMZ4d268qbdyEgdf2ztv9fk491SqAttHXfYxQQ3OEIBn0LMhHYGByDMwUnf/jAjSScK1ivCrHJbCEHvLd4/Hz40FaSM1fHQdpAVMkK/bNQwYv/O5HBphcX4Y5iL+TxsqNA7Zr+lKzVrfbBK6uY3YT1s4nk+YdNOemO1ZYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ob5DSvitCiOldR6aDRNT5IDYoUCCopnSf9oAg6XhIgM=;
 b=P0SC3Hl8FWMqu5TSq89Tei1N42h0qPrf8KueROGD75Xffn6F4sNK1L2trAyFXPk/ncYxc8YM3TLoR2+IfEfFg0mi/9aj4mtf8PxPVcD9EbQbNXi48mgXmfQdwzWqEIwjOaUHdk/+Y7MYyebBbZ1CwhNgKwcYqNxWwtXtQ/o4LP5eJlBn7zIIBtj0HI1KQ3wW5kyCzXGAFCuhIpQky37QymxviFG7bI5iWMBGWXjXWm5Vpu6cj911WT19MMGTD5Qc1EAhU1gN0fSGjCtRoVF1Ssc5KzHH/WJ0BxIcbaVdjm/+QtUnpikHwkp2PvrnKHUwuDy86ssTWrle3O7y4uRMug==
Received: from DS7PR03CA0266.namprd03.prod.outlook.com (2603:10b6:5:3b3::31)
 by SJ0PR12MB6856.namprd12.prod.outlook.com (2603:10b6:a03:47f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 11:25:40 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::85) by DS7PR03CA0266.outlook.office365.com
 (2603:10b6:5:3b3::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 7
 Jul 2026 11:25:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 11:25:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 04:25:24 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 04:25:22 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH] hw/arm/tegra241-cmdqv: Do not sync GERRORN on VCMDQ allocation
Date: Tue, 7 Jul 2026 12:24:50 +0100
Message-ID: <20260707112450.111178-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|SJ0PR12MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: 3727d0cf-7e5c-43c7-4136-08dedc1a7966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: tshgovm6GnwHzS8MNA/MfoBC+9JIGbzFCMG2a2vqBAeNfFk6yI1IZE8HNYKutEaCLw4+jHkGDHYktlGErY1KZa3m0aaWMzIBnXtle6IJeyWldU1i+leKogt4wROXQ2qc5kh6L0JlCyrO64IWF6f4O4sHRdt6rYP1WjUcciaJA9vhP/ANKiK2hhU1Z+yPAQ2Lico9ETBb0yIZWMe5rigzS2PSAY2DwoSFuAPzAFo/i9Ksz1nEiWEs6IL0SjI3NXwlaofD+fTmNiuer5yLNRXTfknhRfdwsFFOP9CB5fSuU5X0tGt3bqc8K6JkaF5s1gIPT8OWYblOZVoE57TnJn/9uHvUSM1mm2AATi5Qb2LryfSKAzY0eSDEcKNRzgHDhT1P2KLyVJBCg90w3cRtNvUxE/u53W40AWgIVOM1BVzhuqkB2jev5ss+qpGZNgYmt3G9NYZXH1LzN9IKBs4Syxk+Ro7mjsobqyHP/uTo+VVi91dhy8ozTCPknqf6inJe7KA+k/jb9yNnPnPHklDbK/bQKz4Pc1AF2zJLlZTAO0vUa9d39K4V6Qp3auIjKa1ly7LMybbGPgV5NtTlbbALmLAgqaJEpGkfwLO3YDh/poLIG85kt1Z0ne4trvDasrgy7OZZ879OHBKV4gHs4BELrgrF37zQE5PUCJmxgLx7rlb0yBCKQUnkAeGFEMjdm73OJyQ2NzTI0zxGDiGb1/1Fi/KYpw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AHTf0c26l4KotGnpfyRf7XvhEb9bFv1POJTXgoIdgX+yvuidVbsxyDfhQOYUyDOroaS/Hxr4KF4kLJkj/ShaLvF2laiao9rzFm8GJegn7qxflMWGP4seqbseWwzDn78owbrjrzTiXkuqbP0NXwFFfrrrxZ5fr/V/engJsSjPvNFKopMdcOzb7c+Ontty1oX8y9ff75wgyqGUZm+hfd8EkxdABzwXND5lYwCbLnpwDrWsq0jfzR3ENbzQFjzjOPrWMkvRlZ5FII3pEwRtQZs/jVnUv3wlkBK8sXdkB/fLnqVRHxbhhqH14NUdHmDXnNWURd6vZ1CKe4K1E3rd4czseDqNY9Dd8vW/QCSemtw9cPzJoJLBluFLZMxv3O8LSIHCOiIiuf6XaLTR0lQreASLNOoTNna+RFQ1v+E6pSa0xDf2NMrSxWNKEHK/sLHRnQbd
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 11:25:39.5879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3727d0cf-7e5c-43c7-4136-08dedc1a7966
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6856
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

When a guest hits a command error, the hardware sets GERROR and the guest
acknowledges it by writing GERRORN to match. These registers use toggle
semantics, and since GERROR is read-only, both GERROR and GERRORN may
remain set after an error has been handled. As long as they stay equal
there is no pending error, so a subsequent VM is unaffected.

When a new VM starts, QEMU allocates the hardware VCMDQ and flushes its
cached GERRORN of zero, while the hardware may still have both GERROR and
GERRORN set from an error the previous guest acknowledged. This makes them
differ again, so the hardware sees a pending error and stall the VCMDQ,
leading to CMD_SYNC timeouts.

Do not sync GERRORN when allocating a hardware VCMDQ.

Fixes: 1d0f77535417 ("hw/arm/tegra241-cmdqv: Route allocated VCMDQ Page0 accesses to the mmap'd host VINTF page0")
Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 29c488e0e4..fe88bec41f 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -212,7 +212,9 @@ static inline uint32_t *tegra241_cmdqv_vintf_lvcmdq_ptr(Tegra241CMDQV *cmdqv,
 /*
  * Flush cached register writes into the mmap'd host VINTF page0 after a
  * successful HW_QUEUE_ALLOC, so the guest's earlier writes survive
- * the cache-to-hardware transition.
+ * the cache-to-hardware transition. GERRORN is intentionally not synced,
+ * as overwriting it with the cached value could recreate a GERROR != GERRORN
+ * mismatch and stall the VCMDQ.
  */
 static void tegra241_cmdqv_sync_vcmdq(Tegra241CMDQV *cmdqv, int index)
 {
@@ -229,9 +231,6 @@ static void tegra241_cmdqv_sync_vcmdq(Tegra241CMDQV *cmdqv, int index)
 
     ptr = tegra241_cmdqv_vintf_lvcmdq_ptr(cmdqv, index, A_VCMDQ0_CONFIG);
     *ptr = cmdqv->vcmdq_config[index];
-
-    ptr = tegra241_cmdqv_vintf_lvcmdq_ptr(cmdqv, index, A_VCMDQ0_GERRORN);
-    *ptr = cmdqv->vcmdq_gerrorn[index];
 }
 
 /*
-- 
2.43.0


