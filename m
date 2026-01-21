Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A4CC44506
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 17:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicS5-0003Mb-If; Wed, 21 Jan 2026 12:57:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicS2-000301-KB; Wed, 21 Jan 2026 12:57:06 -0500
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicS1-0001ie-7N; Wed, 21 Jan 2026 12:57:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lU4sGIWhrME871vR1Qb0k0uNoD/cwD2OVwnCfR+A2WA7azwLZobqo1DEbhLwQmJ8A51Gm/7wLnu8tSUxtjATnIloWqAuvPqJD+BNE/5GSjcVDHZKoYNeGVXvlppL/zrx2CQhER4weCsR2sBiVrs7KkwVes9rPndFnMP2xCZvE8LLpOk2UinYYyHEo8Un8bi5w5ocvCfsZpZ88/wNLbuKfNRyFUiUH3Tzj1rDYrmaxDhN7Js8wl0CYvRRlJ4IThH2GUX3tTaM1b6OlqNYtKO5+uwzHhg5gBkVfNycmrCLYJ4Y4/yv8T2VWV+paR0xR2thgFe22k7tD60LXWN29OTgvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6Yeyns9hi4PhO3ZdAtonA9P0TD9lBtsl1LyHXMt+UA=;
 b=eHbZDAn9Pf51LT80gd+mo8HP8wK7Xj/lCvZ+YkelYZqQCM0R1GgP+FY7ayKAXbVbXCDydy3qxs6Y1r/WOVZoSP0SKf/shFI9Tmn8cCp6hdNP18RocJxlacns51xnvZXoknPKM69JG8dir7NcrzMD1Ql5OGjQwSTRCJi5W7QC5UYl3B9IdoDKdscearVd5xek9S4iCi2Lu7k4knzArBDjL1GDoZOhHIP2Vlm/YAMhexHfuZjAxE4Q1sIavRw2ccXslxJ/6oy/ZhISyawY3Fck0mF/XPfOQg2BqUjJTDocBkXBwTJ6kY+zKSwC4xpCcDu3cDGW/LZ3jBtgLwGy0cDokw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6Yeyns9hi4PhO3ZdAtonA9P0TD9lBtsl1LyHXMt+UA=;
 b=M6JsEf6oRq1OpJBb7mZClGA8i1pUIYUuQC8UPEcHmcKcaJBBaQpq5LKdaX4FFBizWodbr1gB9MQjVFEaXYMPdwk6tI7KZLoI3PynIeHuT5p7j75LzYN3wS1l4wd1YXjLUY2BV+dtwS8DzgukgeG1gHAuSouvUK0GHWXJDy75kMjhUYPf/cOqmwqaIRgW2W+NxyINhQBY9rXHzKmK3OX6fuc74AbQGoHAHSKxxUZmEIsla2QdPGDbDujH3b6wySzJ0KKDa/q1ZXUXdmHPshuB3IxYNjazJL6Noa02HYRpxt+JF6lKGHzqActXKxA0gacIRlPQRNHtkFhGNvs4pNepqA==
Received: from MN0PR05CA0002.namprd05.prod.outlook.com (2603:10b6:208:52c::11)
 by DS7PR12MB8229.namprd12.prod.outlook.com (2603:10b6:8:ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 17:57:00 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:208:52c:cafe::ec) by MN0PR05CA0002.outlook.office365.com
 (2603:10b6:208:52c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via Frontend Transport; Wed,
 21 Jan 2026 17:56:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 17:56:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:56:34 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:56:29 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 18/37] hw/arm/virt: Set msi-gpa property
Date: Wed, 21 Jan 2026 17:52:23 +0000
Message-ID: <20260121175248.87649-19-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260121175248.87649-1-skolothumtho@nvidia.com>
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|DS7PR12MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ca472c-eaae-45f0-0a55-08de591679a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TlGONzqWWsoGUtsn8uP7gOxBLfxPB5JOYpenak8yybMv9LxP/pGdZr6ymWrA?=
 =?us-ascii?Q?QJPV2wRJqWfYcALWefHjHfHTtHd2DDEZvr5a9C3scKU5ITaB2u/MVKD4j5CY?=
 =?us-ascii?Q?aLKQy5SYAivXEByRbhkf47FEUP1ChgyalGS1Rr0u+TdS5pwt41Up5+gkKsQl?=
 =?us-ascii?Q?/hUjTYeGnOSDHoNK/F3RxVwu3HCG3xX7bX9P6qRfTjJS+GzAZ/6fEI7Rf+1N?=
 =?us-ascii?Q?pAIioKzdskZbCwyYuNgzeawFPRvsRIVBkkmXyh3boVFuUmxXPIRdUlhYZmY2?=
 =?us-ascii?Q?KS2g8UUqtJppn6H/IqfK33Shqb2ZZzxgdPuofYc2ynI0AEF53tKDNiueGwoh?=
 =?us-ascii?Q?fm2PrqPMqSEQqrLXQhq6O4T4hsrXpLnuCjZDyvrvqNMlfiQsIDPTezzUIu1Z?=
 =?us-ascii?Q?Ab44DlxvDBOlGaIc4qCFDHQQXudgWUYvTy/8UfgCPXN1EUPy3qrUze+FKxe/?=
 =?us-ascii?Q?HkSUAZXa6c2TJ9wsSCD8ZD0jWauCf8o2F4mPbKpyOKnH9YbDpoQ7lAOjZiJX?=
 =?us-ascii?Q?Tog98IYfWJj0XeAKmdJ3YX3bBKvRCXUgEkKlufaMZWNw4o+e38IbLtcO0PaV?=
 =?us-ascii?Q?kXFZ5uz+hSZYAHglYns7Azpo69IQkq4NfD6nCXCSEy6TPe6mzajaujqqHTaq?=
 =?us-ascii?Q?g9jTpJtjtmGhfuxehRPXLh13u++rXD6S/2uTjTJmfdk2qTeozp6jorSILHhs?=
 =?us-ascii?Q?n7zO+BiwgZN2MtucjL9xEhDwwRySuqyMxCs8t3FigxULU6PWgoyiQxj/x00h?=
 =?us-ascii?Q?/vQgwofDI41867y4ckdWlA9iKN1qXy8T+HfPqYQqeYneo7h/yx6Xxjp/FCXw?=
 =?us-ascii?Q?61+zR7hCEmS8Ywm8rpRBhAUzfZ224I7WAyWNef8XyMJgFTlLswP1fekNmF31?=
 =?us-ascii?Q?NFeqJivZxZpfrALIf7nj3HqIuQJRTJppaY1yGX+Lg3VGLXHOMrgliQJSAF5c?=
 =?us-ascii?Q?V8oasII+ZbO6guHLlUURyY+bKuhyj/peahGJfSZPhW/yh1CGW8cpppF4nBJu?=
 =?us-ascii?Q?/35gRhP63HNVKACOdckFHKUQMfFVK9N1/KhboKmnriu+HZ8dgKRVVMGG3jHN?=
 =?us-ascii?Q?8Vs5lx4V5ab9qHkK/QfSmAqUyj9fRoMvAvzS0y6CRF4RZcBcy3tY4tAdXYaA?=
 =?us-ascii?Q?cyMB7DNkeigz1B3eEsyr5ZpLJLgYJSMkRcQP4fLKeXFrylcitk7Swn8lpZWX?=
 =?us-ascii?Q?4cSXeo2CsQLBDszXYHEaXaOFaAR7gRIrtgKFAstuqMsDnwA8rJ+3OJB9TiEl?=
 =?us-ascii?Q?J//fnMe733FkTIm46HzKbwLF+q+anh9mwN+N6BDeI5BvRsddokheytF4vOC2?=
 =?us-ascii?Q?LHHx0IPoBBNv1X5SZPwujGDoopJ3UeSLpPcjfvNwEErUSZ+X611CMlxTLlPW?=
 =?us-ascii?Q?hpa++aVYvGE1lyws5AeOjSg6Grq29hIWBqTNp2uoh8lHpNB8vJyQYd91pgqp?=
 =?us-ascii?Q?UTmWlVCIXRfIaT8xfUc2pe7hUB1W8R9scSb7x9xhri8+vVP7bzC09iwfgpgH?=
 =?us-ascii?Q?4Mj6k2TppejZjptWgcbTv/Jh+MQw5LW2w4fO6PQwhzXFK8xSnbRpANWKJ6SR?=
 =?us-ascii?Q?CNtqywrYLigf0GPtSTXwM8TSReSekHlcJzoqHDD1lsxyIi7GPJL5sSTOzIyY?=
 =?us-ascii?Q?GsTYEZYxWbZaYbBuVuNjLZzd3Gccp449jbsjLyRvLgIiWnzz4xBg9/CwATWs?=
 =?us-ascii?Q?RSu4eg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:56:59.6569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ca472c-eaae-45f0-0a55-08de591679a9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8229
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
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

Set the MSI doorbell GPA property for accelerated SMMUv3 devices for use
by KVM MSI setup. Also, since any meaningful use of vfio-pci devices with
an accelerated SMMUv3 requires both KVM and a kernel irqchip, ensure
those are specified when accel=on is selected.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/virt.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 4badc1a734..1bbc5d94db 100644
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
+                    return;
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


