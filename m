Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72626EE20A6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 14:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voNCe-0005ZU-0J; Fri, 06 Feb 2026 09:53:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voNAt-0001LR-8u; Fri, 06 Feb 2026 09:51:12 -0500
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voNAq-0007XM-T7; Fri, 06 Feb 2026 09:51:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ooEI0j48o263JR9XO0mWu2Y7cAFZt5ypQ18JP2Bex1l8im3OiraHd+sleUa/YJnkxBqxJGq1bnaQBG1FFUgf28BdbALvb/h/Ep2Kc8fg0fq4wzaqy/dC8g5/+esFndOTFJhE9Qw7TfVh1pfYB/9PL8DGLTh6QGw3P3gEHUFwrn8zmu8g+KbRgCftxXBFr52dLanzEoilWWEEPh6NgLBaxItu+iWXBRtKtlUyjNfLLfVGBtP0F0uWl+JPPpIUkmcJRaxtzjfYHVZVXT4stP3ByovIy/0UyleYfoy5Lu3tgVWrr1lPGClk+4QP3GN9061GY25cIJ3xsCtRGZoS6fagAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRg/4kcus58d3FrX/e6P4dgnFILugNVaZXxxHPuZGUI=;
 b=MGWrylvYpBa7qLZJ32F48PQVORWMDJ+0n9slbGMrCoyJyvIUPuE1LA/HSAU3vjkaJoMnwGtDOnadlxbnelpiqQj/n/geeAmqI5a632wfxFfwPyt3CmpDPHbtiIEOg3XV8i9apeR0/4yz30YjrVrvUqCtfH1lHYO+UDgbtLjBSw1F58WO4MuWd5bm1eYhkDmu04tdbGfGG8eSpIXEgcojNnDcL2ZGeDdHGhZkJayWUMwSKACNsOadU4QMCzZsws7QNrlP26jaPISWwYbKM+2JC9B8s1GPftIAC/Mk72hqapnHHJy1zykVs57FeUHDjHbeOuqbicFz+ZZfa9wXOhyG8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRg/4kcus58d3FrX/e6P4dgnFILugNVaZXxxHPuZGUI=;
 b=r+W3JjV0VmvyRdjjvJUt2TPIjwZM4uE4nQlZiYW4nmGEqltTrQndsVuvBFw4Upf6Simq+YyJjd2CVPjky72LeXmD54mLwS3lstxKajmLEBNR5lWRwbYuN2GUJFb3ajkhvvHFyWM69hefulj+1woMjVRsxGA2NvA6DsFCsQbTfkULEjrH68rbTZsGe8sfxBGw9pztLXqrgJTlgorFrmxkFomof0v5v5Hnknf/CFz3+39P7d28dPEPGYr9azSpbEn5gA+FCOrzS21Y0lnZja/p26L32Zq/5mBZ6sm2wg0Z0slHSEa3OdzcF+4IeS/j0ItgsDkq28aiIurarBqEVprUTQ==
Received: from PH8P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::20)
 by CH3PR12MB8458.namprd12.prod.outlook.com (2603:10b6:610:155::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 14:50:51 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::b8) by PH8P223CA0010.outlook.office365.com
 (2603:10b6:510:2db::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 14:50:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:50:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:50:22 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:50:18 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v2 19/24] hw/arm/tegra241-cmdqv: Add reset handler
Date: Fri, 6 Feb 2026 14:48:18 +0000
Message-ID: <20260206144823.80655-20-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206144823.80655-1-skolothumtho@nvidia.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|CH3PR12MB8458:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce1eb1f-e049-4636-c0f1-08de658f1f09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?muEBUnK4Q0QUQRUMHiE0Lkql0lceT+sqw33c/s2aaOBU9UR+B5jUG3094w9+?=
 =?us-ascii?Q?pZy8H/cC+2vs338eZxwlsEJ9bQV7K2L6bDlQIHVrah1iBuoZ7F8wQnKKQUs4?=
 =?us-ascii?Q?ZUGW9OYMOS0FfEcgbDx5tmH0yK/utUtA7OecyBuJidbLCIuorNGuAat5oinx?=
 =?us-ascii?Q?IkumLirzGVwoiggTd1ljfqdT54PcVJE+kUtyGgpLrcQCZ+7kz1RMJBLNKRDw?=
 =?us-ascii?Q?h4xm2NWDmiLlO1bKuNAVSPxEijoOj84eCSDNJI/gbO+nDffUhdL87IcdB0m3?=
 =?us-ascii?Q?omDgxWYpxuS1LMp8ppUQICGJRL2qfOY6BgLeqBmZLOLAjCkaxpw6k9xvgrNp?=
 =?us-ascii?Q?IZg17B6N+bSi0Qhbsg8SggygShhQ4huIGrp6SMcmh4peimI89DJ5me8C/9mm?=
 =?us-ascii?Q?0FTP6Zw0a1QvJIViuNUsRv+8XfBfAdzyvVeOB8glYTy/Hg+vK2+hKkJ3a56z?=
 =?us-ascii?Q?KYozsCI2gGTZrYDW++qAcxQ60eRkXdBU5J3Fqe1V9cn6XcjlHpfEJ/VP9D9h?=
 =?us-ascii?Q?awh4WqcmDIAvZPH1OfsztjDM/ggbkdukmFe8i4LILWO6MqZYvaD1zy9HlY+9?=
 =?us-ascii?Q?6Uo5us/wTEdfulpFtlYUHBW1qMjOuFBb2p6kYRZY+g9OPIGpl0CKcJ9E/O/S?=
 =?us-ascii?Q?+aIjvTzSg6DMxeDmD7DX+3FEOg3msuiVB1D/Cu4ZFXp3BsuISl+rI/IYxYrD?=
 =?us-ascii?Q?HNV2N9aZMq10YHzqRy3ghCcTqHwiRqhjHsjmFnKIlv15UfcHc7QQtpRWx6i+?=
 =?us-ascii?Q?b5jsxikMDOJ9QH1kZbRZqJzBTjC3lZTaw2tMnjmdF7o0Fzi/ZEFCgo23FwoH?=
 =?us-ascii?Q?Hzjcugw3fvIp0tRqFfLFsp8TYFBPIVhxg5sFVQpa/5Lqm/pXquKUywgVY8Ud?=
 =?us-ascii?Q?BCVLdw8NjNO6cT+Y2rRoi9xiB9ULbCmmiVrObo0OQQ06lRPEniHH+YhFOyio?=
 =?us-ascii?Q?efSFFPoxjI3x+Gt1ybEaOuf0reN1WhmDhOpDD8xedwYlpCRA1RnO6zCK4s4T?=
 =?us-ascii?Q?m8sDSNQ9j49KnZo6XLFyQgSTnSYqAWWR+hn96M/b7psDmvB+H167M0EUkAJL?=
 =?us-ascii?Q?pQn2IDuoFvv8a8D9iD18QdkYKDO/X4zD2G8mNhsewJhAf1dFgaVCOfS0c4yH?=
 =?us-ascii?Q?LapAa7+sAn/7Plogm0xKBRhv01EPEx3g4CBRVAcUHJ3YvYiUlrt0nh0ybCSD?=
 =?us-ascii?Q?zWdWB8dUhDHcrAzlNtZxOYi7HS4s5p2reJb76CNxcU8UuCakbTw1i+1KzqAO?=
 =?us-ascii?Q?9ZS/ZqfE7HB1ZdblnuUOorDjoGUdO1zZiLvcnzE5humSls3Veug3kEfr9VsU?=
 =?us-ascii?Q?yrb4ex+ko3l3BUzUowooANkRBPkKbizy7B1HRHShlhu7K0JAV4/hLJfDufib?=
 =?us-ascii?Q?XGEsCeY+Vy78J9j1nP1NS5QNb0KWov/kosy3V5xWKwHNuF1gFh4VjniR1aUe?=
 =?us-ascii?Q?el8hrU7LcMdBSOTT43m/GAKyCL15e0aQNP+uVt6vVivlUUDIhJFdbFFEQwvC?=
 =?us-ascii?Q?9FCScvhVipzsKuzdGGV/rJNZ5w1ZeqYWTJCd0sQblh2mmFlwbL1xd4l+8R5t?=
 =?us-ascii?Q?GSCFdp1nfmnvX3I07A11UNOS4eyZ+Fc4+kG1HM53yFXXnR2WbUXmBYr71alQ?=
 =?us-ascii?Q?CqOoFTJhDK/JFjgOC+QM35sco6SdhtyaO0UnChaabMe9eSUqD0SAy4EXh8J6?=
 =?us-ascii?Q?EysGyg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WihB0IjiQqrek+W2Oz1HRaSBBkanHcY0RCZNtQosj+0yEc1CkjUQhfCtg83Ce9pUkBsXxrJX2T7H8nS+KzNdy8ciw0XM8VZ+5xqpx8ApGZ80TLyiqmuD8eWnZjCtu4lQ2ARbF3100t365tlNXR+RhDJxLRv6Ce9dbJpc0Goz68tQvSfEoVL6DX8l55j4Png3BX3SiAx4Hcw5arzrfKNzIw7nCNMWpJIorEtHnvmtSqnw5XhBM2h3xLZvtkKS2GnEoI7rIHQadaOscx8wiwZKOmXS6hKHrUNZ9vZbGs2gJ8BAV7De4VDPUV5owMcMNUdtQ1umkqToxrxh/jWwRXuaIoswUTWGZn9Ji5sqmF52So2EgGqUk9qCB1veLJkL5b6EIEkI6bJltDjV4ADr0Uk4T/9JDu6gJw+1znSoKBjUMx/7ZxFR8K/I/4L5ZAZCFFQN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:50:50.7480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce1eb1f-e049-4636-c0f1-08de658f1f09
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8458
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
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

From: Nicolin Chen <nicolinc@nvidia.com>

Introduce a reset handler for the Tegra241 CMDQV and initialize its
register state.

CMDQV gets initialized early during guest boot, hence the handler verifies
that at least one cold-plugged device is attached to the associated vIOMMU
before proceeding. This is required to retrieve host CMDQV info and
to validate it against the QEMU implementation support.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c   |   6 ++-
 hw/arm/tegra241-cmdqv.c | 107 ++++++++++++++++++++++++++++++++++++++++
 hw/arm/tegra241-cmdqv.h |   6 +++
 hw/arm/trace-events     |   1 +
 4 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index b1a8ab79b5..96224a7632 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -707,7 +707,11 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
     QLIST_REMOVE(accel_dev, next);
     trace_smmuv3_accel_unset_iommu_device(devfn, idev->devid);
 
-    if (QLIST_EMPTY(&accel->device_list)) {
+   /*
+    * Keep the vIOMMU alive when CMDQV is present, as the vIOMMU to host
+    * SMMUv3 association cannot be changed via device hot-plug.
+    */
+    if (QLIST_EMPTY(&accel->device_list) && !accel->cmdqv) {
         smmuv3_accel_free_viommu(accel);
     }
 }
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 3dc5315677..678e53d23e 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -582,8 +582,115 @@ tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
     return true;
 }
 
+static void tegra241_cmdqv_init_regs(SMMUv3State *s, Tegra241CMDQV *cmdqv)
+{
+    SMMUv3AccelState *s_accel = s->s_accel;
+    uint32_t data_type = IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV;
+    struct iommu_hw_info_tegra241_cmdqv cmdqv_info;
+    SMMUv3AccelDevice *accel_dev;
+    Error *local_err = NULL;
+    uint64_t caps;
+    int i;
+
+    if (QLIST_EMPTY(&s_accel->device_list)) {
+        error_report("tegra241-cmdqv=on: requires at least one cold-plugged "
+                     "vfio-pci device");
+        goto out_err;
+    }
+
+    accel_dev = QLIST_FIRST(&s_accel->device_list);
+    if (!iommufd_backend_get_device_info(accel_dev->idev->iommufd,
+                                         accel_dev->idev->devid,
+                                         &data_type, &cmdqv_info,
+                                         sizeof(cmdqv_info), &caps,
+                                         NULL, &local_err)) {
+        error_append_hint(&local_err, "Failed to get Host CMDQV device info");
+        error_report_err(local_err);
+        goto out_err;
+    }
+
+    if (data_type != IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV) {
+        error_report("Wrong data type (%d) from Host CMDQV device info",
+                     data_type);
+        goto out_err;
+    }
+    if (cmdqv_info.version != TEGRA241_CMDQV_VERSION) {
+        error_report("Wrong version (%d) from Host CMDQV device info",
+                     cmdqv_info.version);
+        goto out_err;
+    }
+    if (cmdqv_info.log2vcmdqs != TEGRA241_CMDQV_NUM_CMDQ_LOG2) {
+        error_report("Wrong num of cmdqs (%d) from Host CMDQV device info",
+                     cmdqv_info.version);
+        goto out_err;
+    }
+    if (cmdqv_info.log2vsids != TEGRA241_CMDQV_NUM_SID_PER_VM_LOG2) {
+        error_report("Wrong num of SID per VM (%d) from Host CMDQV device info",
+                     cmdqv_info.version);
+        goto out_err;
+    }
+
+    cmdqv->config = V_CONFIG_RESET;
+    cmdqv->param =
+        FIELD_DP32(cmdqv->param, PARAM, CMDQV_VER, TEGRA241_CMDQV_VERSION);
+    cmdqv->param = FIELD_DP32(cmdqv->param, PARAM, CMDQV_NUM_CMDQ_LOG2,
+                          TEGRA241_CMDQV_NUM_CMDQ_LOG2);
+    cmdqv->param = FIELD_DP32(cmdqv->param, PARAM, CMDQV_NUM_SID_PER_VM_LOG2,
+                          TEGRA241_CMDQV_NUM_SID_PER_VM_LOG2);
+    trace_tegra241_cmdqv_init_regs(cmdqv->param);
+    cmdqv->status = R_STATUS_CMDQV_ENABLED_MASK;
+    for (i = 0; i < 2; i++) {
+        cmdqv->vi_err_map[i] = 0;
+        cmdqv->vi_int_mask[i] = 0;
+        cmdqv->cmdq_err_map[i] = 0;
+    }
+    cmdqv->vintf_config = 0;
+    cmdqv->vintf_status = 0;
+    for (i = 0; i < 4; i++) {
+        cmdqv->vintf_cmdq_err_map[i] = 0;
+    }
+    for (i = 0; i < 128; i++) {
+        cmdqv->cmdq_alloc_map[i] = 0;
+        cmdqv->vcmdq_cons_indx[i] = 0;
+        cmdqv->vcmdq_prod_indx[i] = 0;
+        cmdqv->vcmdq_config[i] = 0;
+        cmdqv->vcmdq_status[i] = 0;
+        cmdqv->vcmdq_gerror[i] = 0;
+        cmdqv->vcmdq_gerrorn[i] = 0;
+        cmdqv->vcmdq_base[i] = 0;
+        cmdqv->vcmdq_cons_indx_base[i] = 0;
+    }
+    return;
+
+out_err:
+    exit(1);
+}
+
 static void tegra241_cmdqv_reset(SMMUv3State *s)
 {
+    SMMUv3AccelState *accel = s->s_accel;
+    Tegra241CMDQV *cmdqv = accel->cmdqv;
+    int i;
+
+    if (!cmdqv) {
+        return;
+    }
+
+    if (cmdqv->vintf_page0_mapped) {
+        memory_region_del_subregion(&cmdqv->mmio_cmdqv,
+                                    &cmdqv->mmio_vintf_page0);
+        cmdqv->vintf_page0_mapped = false;
+    }
+
+    for (i = 127; i >= 0; i--) {
+        if (cmdqv->vcmdq[i]) {
+            iommufd_backend_free_id(accel->viommu->iommufd,
+                                    cmdqv->vcmdq[i]->hw_queue_id);
+            g_free(cmdqv->vcmdq[i]);
+            cmdqv->vcmdq[i] = NULL;
+        }
+    }
+    tegra241_cmdqv_init_regs(s, cmdqv);
 }
 
 static const MemoryRegionOps mmio_cmdqv_ops = {
diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index fddb3ac6e9..2aad697170 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -25,6 +25,10 @@
  */
 #define TEGRA241_CMDQV_IO_LEN 0x50000
 
+#define TEGRA241_CMDQV_VERSION 0x1
+#define TEGRA241_CMDQV_NUM_CMDQ_LOG2 0x1
+#define TEGRA241_CMDQV_NUM_SID_PER_VM_LOG2 0x4
+
 typedef struct Tegra241CMDQV {
     struct iommu_viommu_tegra241_cmdqv cmdqv_data;
     SMMUv3AccelState *s_accel;
@@ -67,6 +71,8 @@ FIELD(CONFIG, CMDQ_MAX_CLK_BATCH, 4, 8)
 FIELD(CONFIG, CMDQ_MAX_CMD_BATCH, 12, 8)
 FIELD(CONFIG, CONS_DRAM_EN, 20, 1)
 
+#define V_CONFIG_RESET 0x00020403
+
 REG32(PARAM, 0x4)
 FIELD(PARAM, CMDQV_VER, 0, 4)
 FIELD(PARAM, CMDQV_NUM_CMDQ_LOG2, 4, 4)
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 76bda0efef..ef495c040c 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -74,6 +74,7 @@ smmuv3_accel_install_ste(uint32_t vsid, const char * type, uint32_t hwpt_id) "vS
 
 # tegra241-cmdqv
 tegra241_cmdqv_err_map(uint32_t map3, uint32_t map2, uint32_t map1, uint32_t map0) "hw irq received. error (hex) maps: %04X:%04X:%04X:%04X"
+tegra241_cmdqv_init_regs(uint32_t param) "hw info received. param: 0x%04X"
 
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
-- 
2.43.0


