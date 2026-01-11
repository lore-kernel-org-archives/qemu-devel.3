Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11F1D2502E
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 20:05:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf1Z5-0000KI-0V; Sun, 11 Jan 2026 14:57:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Z2-0000Fc-2B; Sun, 11 Jan 2026 14:57:28 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Z0-0003yk-NV; Sun, 11 Jan 2026 14:57:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gfypopvzhw28Rgj4OI6I4yUKQ/OJBo1SXCaGcxmUS1UgVvDU2KUWNwozsO6gcu1IMQPAZPPg224YtrMf9/3oRU/7j1Q5zkX9Ka+Xf7n7oRFXIjNd6VkkVrL2wd69G/hJbz5aAXwnYhpSiqIVYN0PpVollHqu0VJaPcuS3sAaN56xBoFIhNZHRIgCrgOUT1ArFrIs3VOw0p/gZaeQ30SIFYIm4vmMY9C2Qi1qUYV8Zb6vUXYM50d+xM+EKow5I7nI3c2qtvqgC8uHEeVG6tz8F3Nyp3FTrQVZzeOixZ9fsCB/35xnrNZvLgWu6z8CWxOYXWBa7iJ1liN1yjUeENgLxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxk9b1ekpHI8QsiCXqD7PJu9H5zvZbmw64TCMicK6Wc=;
 b=wYZASJiFBbmVjOWmXlMCqKFkHCaiUGYEJosjKqehppDxvqtElIKcR0MNIskYZNImfpDrfz+zaisupmIeakvBrxxkxSuWEASRAUtyznRzVKj1SEG+6NczHSodAytRL+vDC3vqYAoe2UNemY3apEBO74NGCHU7CyW2gzLhPGyzifKCpUuU0JlyClNbLas/ivKYoijBLvjR/f6UVvznngdfBFeQIsIyTW/nPox9RXWAbTeWuIs7r0BotemRJiTwyJ97qrkKqviSLcEpdAeAVZDZQqQHw1VK7clqqtoL3z19eXJ6iBcwGtKnhcAZRe2ZbG7zHEc1u0TlFu3TPV+ca8Es6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxk9b1ekpHI8QsiCXqD7PJu9H5zvZbmw64TCMicK6Wc=;
 b=AQt9fa0DPZAP8PEAPxUt5IXRhd3qdH4uR366naDsaM1bvLB6oU1LwXj1L+J+Ke7QiLr9EQGR62our6KO8tdhpAg13QIWJzD4qWLlixf5vpiEtcRKJ/dzc0WTSLcHLCSf5eN9HTAhoc1Wb4lFTmWGXEJmV/e1VsqC2INidZhnPdbujOUrc3kiscHoMLq6mdYDh6LWAmVLl3M05XJ1YPjPNxkddolDZMD0xk6ihohXU121IPK8/FLncfeZhrkkDZj/MABM9qDwkqg5xraoM7QYrLZVTsUlO2nGrv/jrGib83emkcyB178OMjkn8+qOVrFBjO/ritfhkcjv9TL/emr0Pg==
Received: from SA9P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::23)
 by CH0PR12MB8508.namprd12.prod.outlook.com (2603:10b6:610:18c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 19:57:20 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:25:cafe::dc) by SA9P221CA0018.outlook.office365.com
 (2603:10b6:806:25::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Sun,
 11 Jan 2026 19:57:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 19:57:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:57:15 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:57:10 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>
Subject: [PATCH v7 17/36] hw/arm/virt: Set msi-gpa property
Date: Sun, 11 Jan 2026 19:53:03 +0000
Message-ID: <20260111195508.106943-18-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|CH0PR12MB8508:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ed4716b-50e0-4a39-c6f4-08de514ba0ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5DV8VxxFPMvmcIPFuYgN+fMg5YlL7Dj7nAhB9XZGX5/u9UGSC0Mizv6saNxb?=
 =?us-ascii?Q?rdTxx7GvGY1U/LSnJw9eknT6hYZPqqfWW6J41EHsxIfWJts4JxZwqkgLiVQe?=
 =?us-ascii?Q?B3E1qQHVZp5C2dQgtJ2HH0pArFAIJdMzQQ7d/e+1rTeVOcBNDSSsoRqhcGch?=
 =?us-ascii?Q?DICyFQKyVbzwpBMYtuk4ixbeyHnUfsHaLYNvmk5cySQmiI6PQYIOrpJ0jMcb?=
 =?us-ascii?Q?oVVnst2oJ4gd1b13nhyGBYv6QNmxZgToL1lYBP0FZ9E40+5xLAp/N393aLhS?=
 =?us-ascii?Q?eNzbJ4Nn6Ch8ZqqVrjJdXDoGlRoK/q3hD2/SYDXHXbWR/yEA0mSedafy+u/G?=
 =?us-ascii?Q?480j97XaAxzCZPidtnSKAsnMBdCKCwOzQ3g6iYEjBpY5RA273QvvqYoaknLe?=
 =?us-ascii?Q?H5xiv/jL5qaLjd9nQQGP2/7DJkvJXjZMdNDY6imwLsOvXEqo1nmLSKLx3VRJ?=
 =?us-ascii?Q?OuqnPa84xCXHEXn757uVNXCXEVZOYl7xMz4IPJ/ai4pZx7UpKb8vDce92Dtl?=
 =?us-ascii?Q?2O1jw4mDwyKCYpHZnUtECmDHX+61sJW7in6U1n+rGByeGzPW53UK88uiJSvf?=
 =?us-ascii?Q?YQRyHweCBGKJNiupchxar4/Pbni4iHLhO0HMA3f7wlgUo8m1x0NkKK9EPSqS?=
 =?us-ascii?Q?MHafQDJ9IJClw+w1REsyRPHMGzXrsRSJlkFuBYSS/94DB0ZqOcoGDFs+kirs?=
 =?us-ascii?Q?rK3YvCjbuyeN54x3ivKWe1UnoEWZGCLn1Q+zCLcbaGL1M2kIrg9Tke5uwXDW?=
 =?us-ascii?Q?X0wp2w19g60RBSohQYNEUBWZh6oeqJJ9+E+jVY6wlsM3CfY+2Q972twEH9JE?=
 =?us-ascii?Q?K1K/nqQfhcsKIl/EmMWFPxxSvR7wEgIbH+VBISLzXh/lWkFIX2e0P+sNuNnL?=
 =?us-ascii?Q?YVlNNzkFRCL4xI3270PBW6sLd7imqGEzPs95Et7JaxUozGLMTLlBnLModDzs?=
 =?us-ascii?Q?/gvpaa3u+A5TWUkOyXY1L/keptElqFJqhMjD6/zsp7FW6ejnWE/E1PyaIS/G?=
 =?us-ascii?Q?7K2WLANeStESdZEXgnS14mdnKsYUkZtH7wrBz8HZectIkVwUFgqJILzCVobC?=
 =?us-ascii?Q?pWBASb41YiOQ19iQnk35Af495GcpbKbBjSQpByaPPOXjvIw0jCJDMTIzGlv2?=
 =?us-ascii?Q?KiJXuWwhqj09D6EfKBwjdLnz71i1n/y2sJr4hVw5j0DWdJL6y5TBEyt85WZt?=
 =?us-ascii?Q?7nQ69z9RA065IEFPeRFOWz6xBvpn14jjw1YtTuR8MD9QO/8bIX9SLwOOGLBl?=
 =?us-ascii?Q?kghDU54vtQowhbCZlBEJmEuwg88VXzAH2lWVRIjY4kqcLYpMQiZMY/ySv3ZM?=
 =?us-ascii?Q?T7Oxu8Jwxn/dP9zB1k1FAZEEw32XmLcyOJ1ImdfwgjemZ2fuqDFe4y7XC0/S?=
 =?us-ascii?Q?jzeTYkfVwCNNMr1Mkh1pr59IPfy3/8wgASQYiHKZeUlSE/JR6PYwAvGZbcC/?=
 =?us-ascii?Q?bcmCz3rRbb9MR9Qj3MCFYfPB4vaVYN8nXdpSLXwkHFWiyCVHL/K17PgKqjHQ?=
 =?us-ascii?Q?WuFq7oNcO0JuQHi62rg/6vWMrFz5az9kBA071qBNxcXV1b+U87xqGioyNsIW?=
 =?us-ascii?Q?ogroNpGQNJMQNrlkVWA=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 19:57:19.6134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed4716b-50e0-4a39-c6f4-08de514ba0ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8508
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

Set the MSI doorbell GPA property for accelerated SMMUv3 devices for use
by KVM MSI setup. Also, since any meaningful use of vfio-pci devices with
an accelerated SMMUv3 requires both KVM and a kernel irqchip, ensure
those are specified when accel=on is selected.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/virt.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9d0568a7d5..08feadf0a8 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3052,6 +3052,26 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
             /* The new SMMUv3 device is specific to the PCI bus */
             object_property_set_bool(OBJECT(dev), "smmu_per_bus", true, NULL);
         }
+        if (object_property_find(OBJECT(dev), "accel") &&
+            object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
+            hwaddr db_start;
+
+            if (!kvm_enabled() || !kvm_irqchip_in_kernel()) {
+                error_setg(errp, "SMMUv3 accel=on requires KVM with "
+                           "kernel-irqchip=on support");
+                    return;
+            }
+
+            if (vms->msi_controller == VIRT_MSI_CTRL_ITS) {
+                /* GITS_TRANSLATER page + offset */
+                db_start = base_memmap[VIRT_GIC_ITS].base + 0x10000 + 0x40;
+            } else {
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


