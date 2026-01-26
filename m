Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03170CF65DC
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkK76-0008R8-MU; Mon, 26 Jan 2026 05:46:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK6x-0007rx-Sz; Mon, 26 Jan 2026 05:46:29 -0500
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK6s-0005bs-BM; Mon, 26 Jan 2026 05:46:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YwDl4h9SOtaQvtn5FWQch0sD68fztjewOvOkf2VWP0q2CT3H4kKaFXYIF4rBfTWfSphvBzzLitJYqcY/znlOOSjTZeuyQqZaRtI//sRpUjC+OKh3bVY4civIg/mkAj/wgVm+sfOq9JmaTrp1kJOLtxZe9zGmADhReZawBG3uP1IwACXYwWIAZLcxhDu7EtPZwTJOUzlhbti3tYO5dAmtEJzljE6grbzdJYvCwq/NL6c+nfnD069sKfDalz8f9D5kVtdtMiWPVF+kQ6NiqNkiNYtB/SlnxI8jdT5Uy5l5VNIV2OrM6OwyPnG/EuwpSVVk7QhozvvjkLvZvCVpAFrCCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UigXJqVNdH4o31UVHBSKCeurMuBL3OTd10uVITZEwaE=;
 b=CaGsSnsmNeL619SceV1SedPDZuPJgAWuOMjtTBAU0w0VIXdVbJf3h78EwmJ+YtmIKMDM5setzqpRAXpaKmfRylbjYcOxgiiCeSZqc3dVo/5zQKjqJTy+qTIC1/nzSOqoEeTwFRT4T4dbRTznmE/LWzWMs175DdH9QaPo1RDcyRZyamp1z+YtcfI37HKx5GaOT/Wlhdqcd+kyD2nWm8GjPngHWaSN6jCkkNH1yd7A79xgYRc11a3Pp1nbroCBFPg/Z0wAnlAErf6+V/R2dTMiNBFtKr1jkSAdEm451ZtsqgGVs8THR4OGV/915Kv2FFQXNXBaXdULkowf1ct4E9daHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UigXJqVNdH4o31UVHBSKCeurMuBL3OTd10uVITZEwaE=;
 b=hbyknNOgqBlQkVdB82iYYhsBqTofgCpeGYzzpVw/4G9RXYQBlDbuQMAHh5MvEsYv+x9u8rJ9IE9ZANMD4V1kAaW2QWcitTGgXzl6se95nEDDRF/q/IVKJwWlIArOtQ3dZb9F/K6sxTGD/0g+6sqdvjriE3ZLju2iVqaz/1CoF/TdpSk7cTXkuBDl/gn+Se043MNOgRHltC20ohHRK+AfDUFOc8SQ0gWChDhYK1cokI1PkIvYNByDhb5bKZ/hLsbFxfkP8BYI5P9CnsB6uy0iPMR54No1tpFTkAPwjt5LYysSN5dqjmJkBAN4NT53x+zjghd0OiBPt0JcNC2+vtqUmQ==
Received: from BL1PR13CA0003.namprd13.prod.outlook.com (2603:10b6:208:256::8)
 by MW6PR12MB8899.namprd12.prod.outlook.com (2603:10b6:303:248::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Mon, 26 Jan
 2026 10:46:10 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::a5) by BL1PR13CA0003.outlook.office365.com
 (2603:10b6:208:256::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Mon,
 26 Jan 2026 10:46:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 10:46:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:45:58 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:45:53 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v9 18/37] hw/arm/virt: Set msi-gpa property
Date: Mon, 26 Jan 2026 10:43:15 +0000
Message-ID: <20260126104342.253965-19-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126104342.253965-1-skolothumtho@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|MW6PR12MB8899:EE_
X-MS-Office365-Filtering-Correlation-Id: c4646377-ccaa-49e5-070a-08de5cc81e18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NGxy38zJ5Asa+ifGd+4IqJcvFg3aWGd9GjJrI1u5sAud9a5rBu5nActVYeWW?=
 =?us-ascii?Q?wej+jV1TMqBDvuziw9FLmCozVyczHFGiWlh9my4o45y2nbqiHBrUAoO0xHnY?=
 =?us-ascii?Q?EXqWk8wq02oSgxFvIW5HVEAz7rmYnMAJoNHeap0WJ5jajhy8DDBNRufEpHPB?=
 =?us-ascii?Q?ND0gL/GKhMOvYCg0JlxZV0uiu/ee/g72Y8MYZC27KZ15rhMWha8tyLGIKOqe?=
 =?us-ascii?Q?pAq5ipgpt/Tw/Oi9JKPH7fdXWrBrlF1ziFxHkaapJWPRhT0e9wI1WjCS1Ad1?=
 =?us-ascii?Q?K9CW/2XXY9IFvV5F1AMvYzggS/GsmClzGbLYH2cFVDrC5ujlgEMV1XFBHRho?=
 =?us-ascii?Q?KSJfi7pS9oIuzWJWiI42McH8oiIai0pvHVn9AdmEZjz53iYIrAmZQQDlVMAl?=
 =?us-ascii?Q?mFK7KEnQtPvY8qOWajNC6FZeGxoyIiYUxLpQrHRW6yTyslU/aJjC952hBzCe?=
 =?us-ascii?Q?6T5/teLQDCA+wTfDHay5nYfk6ckZeMowSh3+dIC940bIj59yNAmyfSoWU6o3?=
 =?us-ascii?Q?eONXZEkZtPIIKIgP6EBno/UExHPicIFRqh+BWQGxTFDOcdE4zHt1i8SS2A73?=
 =?us-ascii?Q?70vKzANMzrD9rRJSH2RtqF7CYFBHIU7f0AujJvphQPgStR/by01J0EPy6SiQ?=
 =?us-ascii?Q?/qSg7xys3/omD5xFGzMyv4xl6wfFY/bBNgDuLgaAmEDw6U9fmNecVPQ8HQ4X?=
 =?us-ascii?Q?M7UA6D4h9r3q2fN51FykKfYgDDdsQSb9zHKzN2Ingd7X/Bo4mxDNbukPfQM5?=
 =?us-ascii?Q?ro1wJ4MnYHwJ5XRKkOgkvRjsJw/54x+MREuwGTO9QXKBjoFgwCgvGkqwlHR8?=
 =?us-ascii?Q?kvuIlxXYptL3otRF+Lw2S+3mbhDYffMTZRONW6Cm0N/FF23zbwNQHEiiJWHO?=
 =?us-ascii?Q?syCece1bEgEFLy0vW4oynRb0rNaJHej3AQQSwVUE2R0sAJwaOYAbAvXtVHgh?=
 =?us-ascii?Q?zg5O3NsQLuSHh3YU2Mom2y07HV5AT+yMvcf0Xp49eP9sbfd5hYzyFXZniSTk?=
 =?us-ascii?Q?haFqdh8Wp046yHaIGT/mroeXTwwSBRoYbmBGyoZOwGrfLDr+QscQ7QT4M4jJ?=
 =?us-ascii?Q?tYmtQXNIBRJsK2m4bC2rfizr9IQ9VWYW36pJe+abhM73tc4meSNrhq/cvFjc?=
 =?us-ascii?Q?sGmpP8NzHAJoDS2YpgAUffl3pOupDKjY5M3r7MG4Pixm7DeKN2t6IUzDWQS1?=
 =?us-ascii?Q?JgMckSBQe3ttouBuhw5qIyotpGtJzJyPFRY7qBrwPDQGcM6GjXeQXv0xVvNJ?=
 =?us-ascii?Q?k9i67/0cUns5a19ZTktHrxS/0NTitmVPjuApYYBpt0CrjfcSBQrnRZEsqIpT?=
 =?us-ascii?Q?aBFjp7JDmyq516jQQNLP6hgL+kKYyJu/5opF+KALRD1ispj8uoyCjyLdTYh6?=
 =?us-ascii?Q?J//lALBTNQfXNZ1URwO5Ag6zeK72sZjRrxNbU7TYoMe2ot4qhkZ5ayvdHs4J?=
 =?us-ascii?Q?TDkeQgoWPcudn8zpNKQdp68A4/4ofERV75dcBaqP7pLvuft0YtO3VCS3pG5Q?=
 =?us-ascii?Q?FQlctwna4cWvMtPnpLteGI6Mhe72Ta4X6g5176eljCg613rwcxheUp0Z9kA0?=
 =?us-ascii?Q?fmVmg5e34vFNmmVNRkWSevzdIg0WYGiyoAevPLL9m65cL4QgqjL+yeZn823c?=
 =?us-ascii?Q?E/1zMBB64hhtZG9mYbcJN3+KSDC4B87/XG+OOHdsWa31eCE+zCWZYBxnVDMV?=
 =?us-ascii?Q?tuy+uQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:46:09.9203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4646377-ccaa-49e5-070a-08de5cc81e18
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8899
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.587, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Set the MSI doorbell GPA property for accelerated SMMUv3 devices for use
by KVM MSI setup. Also, since any meaningful use of vfio-pci devices with
an accelerated SMMUv3 requires both KVM and a kernel irqchip, ensure
those are specified when accel=on is selected.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/virt.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 4badc1a734..91fec582ed 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3061,6 +3061,26 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
             object_property_set_link(OBJECT(dev), "secure-memory",
                                      OBJECT(vms->secure_sysmem), NULL);
         }
+        if (object_property_find(OBJECT(dev), "accel") &&
+            object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
+            hwaddr db_start = 0;
+
+            if (!kvm_enabled() || !kvm_irqchip_in_kernel()) {
+                error_setg(errp, "SMMUv3 accel=on requires KVM with "
+                           "kernel-irqchip=on support");
+                return;
+            }
+
+            if (vms->msi_controller == VIRT_MSI_CTRL_ITS) {
+                /* GITS_TRANSLATER page + offset */
+                db_start = base_memmap[VIRT_GIC_ITS].base + 0x10000 + 0x40;
+            } else if (vms->msi_controller == VIRT_MSI_CTRL_GICV2M) {
+                /* MSI_SETSPI_NS page + offset */
+                db_start = base_memmap[VIRT_GIC_V2M].base + 0x40;
+            }
+            object_property_set_uint(OBJECT(dev), "msi-gpa", db_start,
+                                     &error_abort);
+        }
     }
 }
 
-- 
2.43.0


