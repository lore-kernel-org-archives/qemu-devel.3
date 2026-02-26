Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4B5FC592E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:57:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvZ0G-0007mS-KF; Thu, 26 Feb 2026 05:53:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvZ0F-0007gY-2R; Thu, 26 Feb 2026 05:53:55 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvZ0D-00016V-IH; Thu, 26 Feb 2026 05:53:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+ggAhyjtW0KTsv8DaZMjhfeC8IAtO5j4lzN2u8vpkkGoT8QjER9gPbGa4dkphjpkKCs2PllD4dB9LsCiKTGNfUjGjy9cqvyDiJAA9FgYfwRE45qa371F7rdM2zLPE+Zgtyx2eQBFv/bjsypxpbA6sLTSSNtHanCVY3gTW823LrkxLEzzEiEUXFjjtx1/y7hWjDbKbfCgdKUGySgrAMcWuuoEC0c9KpPQd5yjygLfThVyeJ4svJJUBTS8EOnQLGhJKp7rgNgX7SxmEgViw6gGsXBZmwORQPnUzdbyS1TSHCPodlAmKFoct08W+mrfTW3xtY6s31X8AqT+cTLG0VmHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hamSleTIM41lOBwZx562HF/+XNgbHUgVmAYDhcA1vM8=;
 b=PBDEcQesD/8Q7bZRUCuniljcDvBJ2bBhDEtaFN/JAaF6IJjy938VAZCsDaECYc6DEj87WRi2yv9Fy9bJOLiwGFt0ZJD3JNw+Wm3IUKL5UnOmeoO4+Jp4/Hy0EmPmCCpCwNFnTg9KRD2vlJuf7shsv5wZfcRcxc+ZeZCI3exxAA3upDxdN7YYEV+4zNtXZyNeFm/PpNC/esx/RD7YDQcGmGtHf5G6k2+gbFdTQgP0dJlCE/9f026J4Q8TsjDm7RYvVhVrKXD43tKZVPLuG1lhLXHA+1ovRoUkGKGqGx15qiZZyE8cEgZoVGh81BpqHlOy+Tac9OQXSanbc6OZ3eVylA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hamSleTIM41lOBwZx562HF/+XNgbHUgVmAYDhcA1vM8=;
 b=l5fYlXNamnIdjXOTP61U04WUmamSYZflal8zanNIyu4AgVQ0GogBGjwwMJJg59RfglDRKzTSb+at3qO6gGkXRQ4IAQHSOsV3oHDgBv2T0S9acD36m3UfCdGHijuGGaQdotPaHN+CP+Fj+KPuVySbsLh9IQsDfcvcgJ8ksMcWLHcH9HpF60tIWGtlJZkuZs+yvxMz4hKCPv5ioIF5UV9alcmTAqKRrKfJ4/hPAKfnDRSiyD3ouK+LKYXTNjyBaezVjqwDzb1ddXbwT1NphEgNm4rtLGEDRIehy58AinP0fs21qka178PQNkVDrB7FEpzp1VDi+te0JdLidcGHGPR7QA==
Received: from SN1PR12CA0065.namprd12.prod.outlook.com (2603:10b6:802:20::36)
 by PH0PR12MB8173.namprd12.prod.outlook.com (2603:10b6:510:296::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Thu, 26 Feb
 2026 10:53:48 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:802:20:cafe::c8) by SN1PR12CA0065.outlook.office365.com
 (2603:10b6:802:20::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.24 via Frontend Transport; Thu,
 26 Feb 2026 10:53:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 10:53:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:53:24 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:53:20 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v3 30/32] hw/arm/smmuv3-accel: Introduce helper to query CMDQV
 type
Date: Thu, 26 Feb 2026 10:50:54 +0000
Message-ID: <20260226105056.897-31-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226105056.897-1-skolothumtho@nvidia.com>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|PH0PR12MB8173:EE_
X-MS-Office365-Filtering-Correlation-Id: 0088907a-bfaf-4bd3-933d-08de752551c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: CFoeFdVw0kFFRKTYPdBwb5bW5yr9Jfa1FAxDEgsfS0ktSwz4jYu1X1Ern3jNhIhYvgsIRiSNWrEww3L+wnzCWyURlE/Hx8t4A//uGiffZO7K3J6hQ04S6vSTG98wm6BaXk8V6Xfhl+nHbCnJ/kU65Nv2k2rWedqRWcQgBryIUWiGr1MrfZTnUZp1SAWG44I5UBoIAuT64x6CTm6WcOQRgTaphP6eKiy5ORiSh1KE6Nh/nrWdDdGQUJPWcaEdI4rHjFQ7n3elnccHQelbJfXNnUhCnOqrwiY8sj0VelDRN+zEn9+Q67g5Xmdb7/KMO8Dal44vWoGvXFX9KsV2N6m6Cn79Qmj6Z95ZlxB1ErLDx1TTFtMX92t+phH5ql/LJ0yV82lrYgnxJ4cp3d20vqQIbkPWPfyw7cM7vRudNuVyBzSAhVUqBSQAds910gicnQ2oJ3Io2DNNXx6c09w21iq6jbJeqiwjNt2QLyr/s5LgjeG6t0C+j4LdZGgZiv5VvrJQ+fr8eiOwbPGbm176YDQVp0sDrWv+k4bdPZs1R7Tnw2f3ySejNRtJDIIUmVvxWrTS+d6t75o5iem3VIIY+iVLEnXUoxMseSlq7Cza30CEYHiOmzaIOHYbF90JIVW72cC87na7p85C3XLlPJu8JEoLmBd8ETEVBqETF05+6ZPzufr1AZUNQxMmotdAV4hDMHunOX7nhVZFLyRK77z9iDFaokKZCESkKcnTjSTm3U7lcSilhhgXS13bPWFu3LCfgos5HmP95TTBvVl32GtCMfnQ/vMStwvPwn74JhJ97WTz5TvohLYf8jMcWh2VnOcRh3U0rs8oEQ5NGhj3939LSP4QKw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RTGm9rcoIf270eAdz/DDpoGf1lx9jU//+sVV/b/rHrHC6rP5mnCwVHDzu7jnnv/DNYaunVmtPe5Bi2ikdsuRzNE89gd7fIMyuOwDBQdvZzhurgIeZIMQ1nnsTfGT2xtEjppji2clQmi5EFK6griG9EozU7MbgZP6/b/Lp6JS4vfX0LALul2s5cEhZIWyddEbeeBQRBiyLJp4Ph4vF2pN/wXLgy+OtVe5qi1fQxcEAcJeJ3VlQTwMraBZz/oha9zM8rCvyBhhuR8quFY+jtdeAF8bHULXso3XHF6UlBoOhUYoIrajRuAmI82pahgPosr/6MnAny+b/4wG340R8nFbb9Nbfy4EE3IME/rVtxg0Apvmy+e9BekGpSxDqQuotoGo2gbpWLggWcntcK3U6uuznytoip0qohUZEfHY7pQVeiRNeIhfnjO8bXFRUo18oVkZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:53:47.5040 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0088907a-bfaf-4bd3-933d-08de752551c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8173
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Introduce a SMMUv3AccelCmdqvType enum and a helper to query the
CMDQV implementation type associated with an accelerated SMMUv3
instance.

A subsequent patch will use this helper when generating the
Tegra241 CMDQV DSDT.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.h       |  7 +++++++
 hw/arm/smmuv3-accel-stubs.c |  5 +++++
 hw/arm/smmuv3-accel.c       | 12 ++++++++++++
 hw/arm/tegra241-cmdqv.c     |  6 ++++++
 4 files changed, 30 insertions(+)

diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index c349981e79..6d21788006 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -15,6 +15,11 @@
 #include <linux/iommufd.h>
 #endif
 
+typedef enum SMMUv3AccelCmdqvType {
+    SMMUV3_CMDQV_NONE = 0,
+    SMMUV3_CMDQV_TEGRA241,
+} SMMUv3AccelCmdqvType;
+
 /*
  * CMDQ-Virtualization (CMDQV) hardware support, extends the SMMUv3 to
  * support multiple VCMDQs with virtualization capabilities.
@@ -30,6 +35,7 @@ typedef struct SMMUv3AccelCmdqvOps {
     void (*free_viommu)(SMMUv3State *s);
     bool (*alloc_veventq)(SMMUv3State *s,  Error **errp);
     void (*free_veventq)(SMMUv3State *s);
+    SMMUv3AccelCmdqvType (*get_type)(void);
     void (*reset)(SMMUv3State *s);
 } SMMUv3AccelCmdqvOps;
 
@@ -73,5 +79,6 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp);
 bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
                                       void *buf, size_t size, Error **errp);
 void smmuv3_accel_reset(SMMUv3State *s);
+SMMUv3AccelCmdqvType smmuv3_accel_cmdqv_type(Object *obj);
 
 #endif /* HW_ARM_SMMUV3_ACCEL_H */
diff --git a/hw/arm/smmuv3-accel-stubs.c b/hw/arm/smmuv3-accel-stubs.c
index 1d5d3bb10c..5ca94d605f 100644
--- a/hw/arm/smmuv3-accel-stubs.c
+++ b/hw/arm/smmuv3-accel-stubs.c
@@ -55,3 +55,8 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
 void smmuv3_accel_reset(SMMUv3State *s)
 {
 }
+
+SMMUv3AccelCmdqvType smmuv3_accel_cmdqv_type(Object *obj)
+{
+    return SMMUV3_CMDQV_NONE;
+}
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 9a570b8af9..585b460943 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -998,6 +998,18 @@ static void smmuv3_accel_as_init(SMMUv3State *s)
     address_space_init(shared_as_sysmem, &root, "smmuv3-accel-as-sysmem");
 }
 
+SMMUv3AccelCmdqvType smmuv3_accel_cmdqv_type(Object *obj)
+{
+    SMMUv3State *s = ARM_SMMUV3(obj);
+    SMMUv3AccelState *accel = s->s_accel;
+
+    if (!accel || !accel->cmdqv_ops || !accel->cmdqv_ops->get_type) {
+        return SMMUV3_CMDQV_NONE;
+    }
+
+    return accel->cmdqv_ops->get_type();
+}
+
 bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
 {
     SMMUState *bs = ARM_SMMU(s);
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index a379341c0a..42d7dbfde7 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -736,6 +736,11 @@ static bool tegra241_cmdqv_init(SMMUv3State *s, Error **errp)
     return true;
 }
 
+static SMMUv3AccelCmdqvType tegra241_cmdqv_get_type(void)
+{
+    return SMMUV3_CMDQV_TEGRA241;
+};
+
 static bool tegra241_cmdqv_probe(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                                  Error **errp)
 {
@@ -778,6 +783,7 @@ static const SMMUv3AccelCmdqvOps tegra241_cmdqv_ops = {
     .free_viommu = tegra241_cmdqv_free_viommu,
     .alloc_veventq = tegra241_cmdqv_alloc_veventq,
     .free_veventq = tegra241_cmdqv_free_veventq,
+    .get_type = tegra241_cmdqv_get_type,
     .reset = tegra241_cmdqv_reset,
 };
 
-- 
2.43.0


