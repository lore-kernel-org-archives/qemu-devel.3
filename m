Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D19CF65D5
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkK7j-0001E1-CR; Mon, 26 Jan 2026 05:47:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK71-00083O-LQ; Mon, 26 Jan 2026 05:46:30 -0500
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK70-0005dp-1N; Mon, 26 Jan 2026 05:46:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpj45J4beU0e3HgJAldSdiRGkVcu/8aCUTp0g/taDDXx08/AAMXBmD2Nx8nCu/57S7OBItUGgRUKNu4v/OQgdwbd3ALrgK21oL1z4gSLwJ+fM5L+oD0DFsquTh2soC77QJ2NvgHJbS0u0XdMJmwHA+kucozJ1ORHN0DSf5GO7egXmo9wOVn9nMI3xovtAjnmMzd7xK2zHCPOxCqPFjwxFllqf0+S6ue0UKF0/XlN4UyOgesGdjXQ/0iH4qfEq09OzwtuZOPqVx1WF3IxXGgz2K3DEwbXVZA6HGRskYzmJzVz0sPwZIjwhBgs99jG7gWVLt5oSTvgzxHMCzgwEnGajw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1xsAzGDAdcdPNV6VOkSzf89JAEVK1A+rmJSTaHldLI=;
 b=SHfE6eF0/fL9e3dUFynBRWqjgdw7W8j7UUc/n3gzpRIgvbCxEc3EGOfh5+SQjsq7Wu8Q4jWTSiQmLmJw44bUFvnnBHHBRExFvaHNr+NOAi5LzzqNRIiH210kX9qJE3eQm9QqUzJV+fyf7moGtqatF6UFpIHPwA8ldRCmHRwbzZyjTs5WwK/r+G3Q4oA2FesqGY3yt9pOoZux6Pdc2/xUS8jm4IiQRmQJO6f8E16FSkGJ3jDWq3JG0lZVC6gQyT+cuwtGZN/iVfLvHnZRMeVV0NC9Mz3CukXEl8XAKBIiedP1NKJEYhOnGAjzIT/7B1VqfOaOHAtbYfKFu5BIQbxpeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1xsAzGDAdcdPNV6VOkSzf89JAEVK1A+rmJSTaHldLI=;
 b=Lw3UuEstNQ2TR3ybAES0qEyr6TIAT9ZJfCw3aPmKgoC+ANeEKOafqRO5L7OdCYD0puJHBQou+6y2uZwbw3eFbFSevkr6dBuUS2xqVUrnSfbIKWzAANffjr8cxcj2NCBG6RssLliq3FDrajL25VVitTcsxJPYZCmpLHWJvsNFQoNU1eicQ5AKCXkHqURVcN3oXyq7IQvFJ+J2FNMDUBIt+AFiq8sR3iNvF3HhUWzyPtExt+vMfSOVX3uhXgqbA3OLOKHKmI4Bnmi7V2zYO/IyY/oYRRIJUvDX/Kwfpg5xXDzQXUv7U/CLHScSVF4Jb65Ww1aKq8qbKw6Dsm3bLknIjA==
Received: from BY3PR05CA0027.namprd05.prod.outlook.com (2603:10b6:a03:254::32)
 by DM4PR12MB5747.namprd12.prod.outlook.com (2603:10b6:8:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Mon, 26 Jan
 2026 10:46:19 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:a03:254:cafe::28) by BY3PR05CA0027.outlook.office365.com
 (2603:10b6:a03:254::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.6 via Frontend Transport; Mon,
 26 Jan 2026 10:45:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Mon, 26 Jan 2026 10:46:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:46:08 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:46:03 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v9 20/37] hw/arm/smmuv3: Initialize ID registers early during
 realize()
Date: Mon, 26 Jan 2026 10:43:17 +0000
Message-ID: <20260126104342.253965-21-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|DM4PR12MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a1465e7-cec1-4fae-7fb3-08de5cc823a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|7416014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F21qrdtKJMOf0EYTzcuV0r3ppElw/ue6QisvtZDKEgLPGxP2ksr4WdqI6+fU?=
 =?us-ascii?Q?xirqIvbIU54GFKal/JIAw+UlXnM5ZWjHEZ+9OTFw/glQ6MoU79yd/L3sIGJ5?=
 =?us-ascii?Q?/As4KAxU43FT9NlrOqDijrD9Ni9qLCUZZGuD+oh2f46ytXEgXB1cufNJlJ8z?=
 =?us-ascii?Q?F8V+838iQ2pekwp43LU5/JQNX5N1QvHvv/Nw1sD/jnV4wQJoQD/V8aR9xpwI?=
 =?us-ascii?Q?A+Ke7BmJynP81EwGjKDA66PQtl7kWUuvGBhLwQrny23t3fcaGq404gGn+dfO?=
 =?us-ascii?Q?es9BTRGt/x7/lMg8IZBtNjxCE5ZZaNech7t6l1F54xWI9+WkaIo2khR7mZO0?=
 =?us-ascii?Q?pBr38acPUfZOK1vXTzD3WEXmLqD0Huj41ADaUrtfTvAwrqoudDJGrRYyhu/N?=
 =?us-ascii?Q?nTzU0CSYXWOeZWRArPMHO+bVHOI8NIuje0YDbGvyzmk2i+BQD2FYLz8wSSXF?=
 =?us-ascii?Q?kBfnzNMzomgbHUjdMIiZQvyZCOvqgH9W3B+ItV9UK1PTt9SKBExUW89JpGf+?=
 =?us-ascii?Q?K9zmrtGnP56xIlabQoUp5oowtF25q7XZQO1S6rrlBJxwdqOXp9NPLpy5w0qE?=
 =?us-ascii?Q?IiAcJfbNGC1nZj+IBswHyA2P+y6ejl+GH+KFsG8Fs6Aqzk4Q0bJ8pRVW+IMx?=
 =?us-ascii?Q?O9GAO/irBW3oZKFsKjojbXd3K4Tu34WoF7UoaEHCHA3j1IHOYj4BzV9cpuEt?=
 =?us-ascii?Q?rRKxwjrE255B2FJ/+UqrkQKwa4vRuRzDpazqf721++qlNgx5zcsvet7HBSV8?=
 =?us-ascii?Q?l8AdS5wHWkTnVIqE2cDhVhwZ2yUIX+GOgvCozA5YUorZvqwjyjCaUr+9KgSG?=
 =?us-ascii?Q?ndqL6aDCLZf2evPSCIimNS6ozKcNa90bP0R+3rytmmE1/ecBE4vUExQ88Lx9?=
 =?us-ascii?Q?46Cg5rS07KBH6oNipIB/SSDjT4CSE5ULYosYDfepoq2SbVbuM+yfKbLTiE0G?=
 =?us-ascii?Q?3ln56IvWebSAnzdR0oy1105WSwr1MWwWHIoe7eHB29EzzpYGQ1TF/WK1Y7KQ?=
 =?us-ascii?Q?myHXzUMZu/9W2tr9cYvzGSqQ6mjFS3FHf4WfMHfHmc5EaXgrtGXfRgVOgdHa?=
 =?us-ascii?Q?Tmp3e47Gn3NNLadapCB9zW4nl4AJmdDwViAse21C8nUd5ox4Asuy2NRqlQY5?=
 =?us-ascii?Q?sa5IO5dlw77euEuUoOrOzBGSqYLkHbfdt16TpiI0HEb1IvCGIGhxJ70/+Rqg?=
 =?us-ascii?Q?CTzmaXLaei/eCxSVkqsCmQLGxrVxpwf39LcVuESdh24IIyD3Y7wBTg7ckNUd?=
 =?us-ascii?Q?DqYSFWjS99nPrELGJP9wSmboBHyzFbgVoIGhDXMNiYMeVAMtxqut6e0FOeEl?=
 =?us-ascii?Q?KUci5wnJN6aTUyfHNaoP5G0MiQfwg5mJQQyYDm2BCx4dL0O7iGyR772fTrrc?=
 =?us-ascii?Q?rpq1zlL6yYWcJQFOyElSCMZj4feU4a1wF5zkZlN+NEIP2arzhZ/fGLPnmGFY?=
 =?us-ascii?Q?kxYRxDki9ZptocVotAGkaZteQTbONYYn92GSBnY78142HbIQ174s8LpwNOv9?=
 =?us-ascii?Q?DSQHCW/1VoAH5CGpsOWp2Rse+yx+LvnF+pX5DXga8CdchVA13GeuLirxF0z/?=
 =?us-ascii?Q?RWzUDYo4mdnZ9T7VcwiiS2xcPhWKI083+l80InxWUBaO8dJxJgPrmMXI2lT9?=
 =?us-ascii?Q?jHwnc9AA3Rh9j4BTtQfJi19r/4JhIVAlVmsbCCGO+tqHpWTWcNm4NaavLRwK?=
 =?us-ascii?Q?2tcNaA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:46:19.2881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1465e7-cec1-4fae-7fb3-08de5cc823a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5747
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Factor out ID register init into smmuv3_init_id_regs() and call it from
realize(). This ensures ID registers are initialized early for use in the
accelerated SMMUv3 path and will be utilized in subsequent patch.

Other registers remain initialized in smmuv3_reset().

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 4efef73373..e301bb467d 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -258,7 +258,12 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
     info->recorded = true;
 }
 
-static void smmuv3_init_regs(SMMUv3State *s)
+/*
+ * Called during realize(), as the ID registers will be accessed early in the
+ * SMMUv3 accel path for feature compatibility checks. The remaining registers
+ * are initialized later in smmuv3_reset().
+ */
+static void smmuv3_init_id_regs(SMMUv3State *s)
 {
     /* Based on sys property, the stages supported in smmu will be advertised.*/
     if (s->stage && !strcmp("2", s->stage)) {
@@ -298,7 +303,11 @@ static void smmuv3_init_regs(SMMUv3State *s)
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, 1);
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, 1);
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN64K, 1);
+    s->aidr = 0x1;
+}
 
+static void smmuv3_reset(SMMUv3State *s)
+{
     s->cmdq.base = deposit64(s->cmdq.base, 0, 5, SMMU_CMDQS);
     s->cmdq.prod = 0;
     s->cmdq.cons = 0;
@@ -310,7 +319,6 @@ static void smmuv3_init_regs(SMMUv3State *s)
 
     s->features = 0;
     s->sid_split = 0;
-    s->aidr = 0x1;
     s->cr[0] = 0;
     s->cr0ack = 0;
     s->irq_ctrl = 0;
@@ -1903,7 +1911,7 @@ static void smmu_reset_exit(Object *obj, ResetType type)
         c->parent_phases.exit(obj, type);
     }
 
-    smmuv3_init_regs(s);
+    smmuv3_reset(s);
     smmuv3_accel_reset(s);
 }
 
@@ -1935,6 +1943,7 @@ static void smmu_realize(DeviceState *d, Error **errp)
     sysbus_init_mmio(dev, &sys->iomem);
 
     smmu_init_irq(s, dev);
+    smmuv3_init_id_regs(s);
 }
 
 static const VMStateDescription vmstate_smmuv3_queue = {
-- 
2.43.0


