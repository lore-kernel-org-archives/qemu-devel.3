Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FEDDCA5FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2026 01:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDu2l-0003ee-J0; Mon, 05 Oct 2026 21:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1xDu2h-0003dz-3y
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 21:32:31 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1xDu2f-0008CY-CD
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 21:32:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0YvjlweWPmn17Fn+sQSWpKxT2dAAc0URX91Cl91e9PJbXHEojqQCcKLhcG1tbo0do0MmReH7VnT7Hvai3XrABtRERZtUHDWEd/arASsuXNFqVY4iLyoD5Jb5chV28km1lqTceNy+nA3xZ5G6EovLI3H058LYciDhGNBBKmq416V6Cah1Xlo0eDcYWSa8BvM6rjg/lzmSoLN3V/Azc6srSGWPVwAYuUWL3OrHj7qeR/yx3laDMuDI+yEUCebNaFDONgv7Rv/HfPrcbJqZ+xpi2WSk6shspzGLNhkfUV8i39MbArmL/D/K2Qw88cI3ppquKTViy0X34S+2cEXZR3bgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDv3IvEwyZ6NYGyQnijNjfgDufCc1bC48BqUkqt7VX4=;
 b=Waqkf2ID5q2ryGNr1ai1nv6uLjDBHAF47tTdtkGRpqY05bhDLW9FVyVwgHecGCZoKieQUGPrOVb0NI3y1JEFAYUce+JfMjT6s2uVDR2nrjmWqJsSCe+XzuEsOxWzAEhQc/9wUjE0bmb25J5b6+JZWzwChNNnY5jSbDCg9Qdc5sFiZLfi9U05MBZvgwbSBfJZ7JJOXgXQwqi/1bHQFM8mQ1N2AyK16aW/EoNunWYPsCixONRDt325bdAITV5iOwxvR9by0rRX+wNoTne2Voub5EbbPw1hPLj/ApDDEle2MAR81o6HV1BkKyfftmksnkecUtJI/WfNlZ9c07HPsbiqnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDv3IvEwyZ6NYGyQnijNjfgDufCc1bC48BqUkqt7VX4=;
 b=AettlSfNRUMRw7cYyz+ZgdunKZ0AWPK3QTsfriz8HCHW9B65BOm/pCPu36WkWMgV6rTdEGzDH+p9+RpCOOgIWSTRhFmCwWdeHIm2LwnC4cWPaLbscRoxusyDN5E3sKiAS7eceNg0bvoaiTHV8E2L0RzLz2vOltFXKvCccThLWDmq0VCwKYRpQ2uUUC27/vkpGghLrpPlOBr2DePZxylGrZADMZZANSvBr90bEJcPX9DnIhxyasPt7PHQ6+Hf7axu7d+px4NVmOX4m4U0lRWBWOtFDmZ8EFiTkXvIgd6G9chpSIjnGSIlOlBppfQTDkdNay/pTRDn4Ozj1KIJcdNtNQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by CY0PR12MB154213.namprd12.prod.outlook.com
 (2603:10b6:930:130::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 01:31:47 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 01:31:47 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, philmd@oss.qualcomm.com, zhao1.liu@intel.com,
 yishaih@nvidia.com, alwilliamson@nvidia.com, jgg@nvidia.com,
 skolothumtho@nvidia.com
Subject: [PATCH v2 3/3] hw/pci: Make ACS Control read-only to guests
Date: Mon,  5 Oct 2026 20:31:33 -0500
Message-Id: <20261006013133.3457555-4-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261006013133.3457555-1-tdave@nvidia.com>
References: <20261006013133.3457555-1-tdave@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::19) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|CY0PR12MB154213:EE_
X-MS-Office365-Filtering-Correlation-Id: a30dd437-a5a3-4b6b-7977-08df234996a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: VXNKpGWQI48b4Io+gjvXlZJPU36vT/I/rTW3zOYAXrLkVzrcoA9/2eB2opqCo3u08/dIGjMRlFogOqBCUdx6igVuUQBBV6acTobe1+5WqARBAH4KnguBVZmi+Z1M8DSnod4xpuG0Wtcazg9nXML4g9RUS9xSY7TdZErh+IBDZM36oPBwdSXUbsQxjXDkXNoo59//41V5tsb/jtMVVU8gtQnNjFtMyvUzlKvJPvjJ2gRnqhjPsm614xCWnurecVOzXVrSQQAvJtyBE2B/JTWkQQQR1Z1iwOXSkAYHGyOoEBAeypkyH5I8dqgdONbzriSQDiGcsQ/wMRtaXf4Oo2n0VTbfbta2AD9oUCJRYWapdMAyJv2h6aNXJxW5def/6GHy2soXEoDBJqHyEvUcviIUe3VuKCmApLUVDZrDJUAWbz7RXfaf4aqhYWS4hAHSxxm9VpCj9MRFJPKhzNbeGPZAk+f/TuXIWtsmVlZG5GEV62a6Q6+71gb/fy2qpc3Sn94OuTMEKvmaEZUJj+9CI5MkSHt6iursXA+7cePfGBr3yLkvNscvcYoO5/FReur10JutfnBX0cr356MdPAp8ttzSEqdh7wP8u03cWBb3bP3eY57HgkQBjCMT4vNDHKLHa9SLKZzHcCvffG1KJNla71upEE2JggAM8fj4+LHLDiy2ALk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zva0Ck9U9hbSm3baq+D0ciqgY5It2S7NtiH7DjzzVEgVoSZe+PeAx+ibVOYH?=
 =?us-ascii?Q?eqD5syQlSjVqBg6QI6V0oXNxzvsfo5NlirhUbwUi8u2i1liQoOe5wbXhXLIs?=
 =?us-ascii?Q?1Zj6wrF/KaiMCFWqTFY1f7k2dWqEAzu+x3r/Q6l3ieqfVOPuNh6Artk/l/od?=
 =?us-ascii?Q?1gAQgwnT1EvQ8ugakV6LCa5J+qLbnJGmUNGEO06zJJZ7lo4UpTuLwZ2ig+CT?=
 =?us-ascii?Q?n/QNReki/Jm31eA88MjDHylQM4zfekk629pGWuVuNiy987UYr9zy7vfdaImR?=
 =?us-ascii?Q?iFJIwx/hG05nlboqP8lCGApPYWYKZsb2/YsJ0TZZGwA/8JPQZ+r6sCcnY/kl?=
 =?us-ascii?Q?9GeQ1nSyLzFgJIQg4bYkF3HkjL2zz8D9ewNhKIOwgkSsc83l2KpXPc0/HUA3?=
 =?us-ascii?Q?rHscKQmd8Sg/uE0PZlRflmjqxTh5bFa16y+rD1WKdSnTSFvXAjgHcyheJ8+N?=
 =?us-ascii?Q?8GNgqbgl1JKa8QZGWhgpyNN4eeZuVE9DIrsuF3qRVM7zzGR63uXNlw6v8+Xx?=
 =?us-ascii?Q?zjkQdkA+0ZGatHG8p34lYDZEiqkIgqxlUZwGD1KcLmgFMyXoDt6cYziP8tfl?=
 =?us-ascii?Q?KkIlcMruTylMj02NwHMLTLk0feJdroj1t/iQDlZzsSZgqBn+hFPNUCdnfkWk?=
 =?us-ascii?Q?Q0GTBrJRhFr5xBE0iB4+wo3OqGZ8Q6UebquHqxNAaCM7g91yFcB40dZkbIpb?=
 =?us-ascii?Q?H3k0YH3+QTGcPgSGl+/XXdLu7CmXC6XFMAX5j4V+in9YjQGXPgBKaq3MsCH5?=
 =?us-ascii?Q?DadhTJpzweYXvDa0yWilbIvIi8VQI5wO5jF0mzgpbp1OiG35mAP6Gl8vxSrM?=
 =?us-ascii?Q?FThzTMRz1PX0VYucmLa7q4pPpIs9IvS9cXovlBgv316ACtEBlPHZg6cXHZEB?=
 =?us-ascii?Q?6sE/gTd0Zcq4q9xep6JC8JsveCfmIDKCDG8s47wdVrldHLRNKVuyDqPOOSfa?=
 =?us-ascii?Q?X8h65kzs0ogYbH2jDMpZdLo/l7ieK/9hMclx/1drXkZUzZzHxW9azgjO3hLv?=
 =?us-ascii?Q?Y1l8QsqtIUXZy8PdgE1OzldVQeZ8DT2j1eCls2YHx3j+ziJAJi7kvcmYVglN?=
 =?us-ascii?Q?WHoqzHwC7zlzRFr+8oa0tf0/QGogB5DKImGMnfoCcZWnVocNUn5BxbdkjtMe?=
 =?us-ascii?Q?n735ZhbMNetly3dj+GGSGR85yCbSEMDN+RV33GV+BrQE/na/nxGl02m4vQAK?=
 =?us-ascii?Q?JkSYg+/P3QZsgFJ9xJnlnZ31AKCTPFCKBbTBgLBWVj62C8pwDrMc8HOkj+GG?=
 =?us-ascii?Q?5BoOHG4lCD4eeBwRUlRJc1CGl1GtA8xpkndCEJxkOL6I/gQVkt4PH8P9xNnh?=
 =?us-ascii?Q?XhjguacX7juufdxTfMYxRlbW9m1m/SKZKCPbl+n7UBOInlTLoyulbZ3hrMP/?=
 =?us-ascii?Q?65zHCiRIGV/lNzd+IdkWYLkL2n/PFI9h3BEcGAFkqSbQypQupZ/hIL5m0rt5?=
 =?us-ascii?Q?/Go9gNeMpGLW8BKsom+DU8tfA9VGPPnX2xdRq4U7ZaxXQ2b0SDKqjSCnzWrz?=
 =?us-ascii?Q?S++a5pEOdOE1m09s/6RziJUrvilWbvpVRj4nt6flarmvj/liBSRlwM2xpQE8?=
 =?us-ascii?Q?EFxlI/OZ77tL6zooQ567cWxK4HCLBUV5C4Rmh8M5xB/CjKJTKrqrwPJe+fbi?=
 =?us-ascii?Q?9ActRXwOpA2L9Wp8b9fpdO9XK3Z+FD81Ad1L0A5JUFZyGeEFNCJx/xjIBe/U?=
 =?us-ascii?Q?whGOrY7mSTjAQ3y4u+3xyWUkoZ4QqxjNKOJWgw4jekElVknl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a30dd437-a5a3-4b6b-7977-08df234996a4
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 01:31:47.7423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JumCIebRTuQa0Y+VDO8AUjPU0Rmu4AvpO6C+hr8Hj6YsD+HbKJpq/Ii71rtv4fZwOivw7I8CsG8EZTMdabL1KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY0PR12MB154213
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=tdave@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

GPUDirect RDMA using data-direct requires a specific ACS configuration
on PCIe Root Ports and Downstream Ports.

While ACS can be configured via QEMU's 'acs-ctrl' property, the guest
kernel may overwrite ACS during standard programming.

This change blocks all guest writes to the PCIe ACS Control register and
preserves QEMU-provided ACS settings across device resets on PCIe Root Ports
and Downstream Ports.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 hw/pci-bridge/pcie_root_port.c     |  5 ++--
 hw/pci-bridge/xio3130_downstream.c |  5 ++--
 hw/pci/pcie.c                      | 46 ++++++++++++++++++++++++++++--
 include/hw/pci/pcie.h              |  3 ++
 include/hw/pci/pcie_port.h         |  1 +
 5 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index e7cce8c0ee..6ac64c8b2b 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -123,7 +123,7 @@ static void rp_realize(PCIDevice *d, Error **errp)
         if (rc < 0) {
             goto err;
         }
-    } else if (p->acs_ctrl) {
+    } else if (p->acs_ctrl_configured) {
         error_setg(errp, "acs-ctrl is not supported by this root port");
         goto err;
     }
@@ -159,7 +159,8 @@ static void rp_exit(PCIDevice *d)
 static const Property rp_props[] = {
     DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
-    DEFINE_PROP_UINT16("acs-ctrl", PCIEPort, acs_ctrl, 0),
+    DEFINE_PROP_UNSIGNED_NODEFAULT("acs-ctrl", PCIEPort, acs_ctrl,
+                                   qdev_prop_acs_ctrl, uint16_t),
 };
 
 static void rp_instance_post_init(Object *obj)
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index e243dfdf7d..66d25098d7 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -120,7 +120,7 @@ static void xio3130_downstream_realize(PCIDevice *d, Error **errp)
         if (rc < 0) {
             goto err;
         }
-    } else if (p->acs_ctrl) {
+    } else if (p->acs_ctrl_configured) {
         error_setg(errp, "acs-ctrl requires x-pcie-acs to be on");
         goto err;
     }
@@ -154,7 +154,8 @@ static const Property xio3130_downstream_props[] = {
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
     DEFINE_PROP_BIT("x-pcie-acs", PCIDevice, cap_present,
                     QEMU_PCIE_ACS_BITNR, true),
-    DEFINE_PROP_UINT16("acs-ctrl", PCIEPort, acs_ctrl, 0),
+    DEFINE_PROP_UNSIGNED_NODEFAULT("acs-ctrl", PCIEPort, acs_ctrl,
+                                   qdev_prop_acs_ctrl, uint16_t),
 };
 
 static const VMStateDescription vmstate_xio3130_downstream = {
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index af24ec7fd9..1fead3a053 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1265,6 +1265,8 @@ int pcie_acs_init(PCIDevice *dev, uint16_t offset, uint16_t ctrl_bits,
 {
     bool is_downstream = pci_is_express_downstream_port(dev);
     uint16_t cap_bits = 0;
+    PCIEPort *p = (PCIEPort *)object_dynamic_cast(OBJECT(dev), TYPE_PCIE_PORT);
+    bool configured = p && p->acs_ctrl_configured;
 
     /* For endpoints, only multifunction devs may have an ACS capability: */
     assert(is_downstream ||
@@ -1286,7 +1288,7 @@ int pcie_acs_init(PCIDevice *dev, uint16_t offset, uint16_t ctrl_bits,
         cap_bits = PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
             PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT;
 
-        if (ctrl_bits & ~cap_bits) {
+        if (configured && (ctrl_bits & ~cap_bits)) {
             error_setg(errp,
                        "acs-ctrl 0x%hx has bits not supported by this port "
                        "(supported: 0x%hx)", ctrl_bits, cap_bits);
@@ -1295,7 +1297,17 @@ int pcie_acs_init(PCIDevice *dev, uint16_t offset, uint16_t ctrl_bits,
     }
 
     pci_set_word(dev->config + offset + PCI_ACS_CAP, cap_bits);
-    pci_set_word(dev->wmask + offset + PCI_ACS_CTRL, cap_bits);
+
+    if (is_downstream && configured) {
+        /*
+         * Block guest writes to ACS Control entirely to preserve QEMU
+         * ACS settings
+         */
+        pci_set_word(dev->wmask + offset + PCI_ACS_CTRL, 0);
+    } else {
+        pci_set_word(dev->wmask + offset + PCI_ACS_CTRL, cap_bits);
+    }
+
     pci_set_word(dev->config + offset + PCI_ACS_CTRL, ctrl_bits);
 
     return 0;
@@ -1308,6 +1320,36 @@ void pcie_acs_reset(PCIDevice *dev, uint16_t val)
     }
 }
 
+static void set_acs_ctrl(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    PCIEPort *p = PCIE_PORT(obj);
+    const Property *prop = opaque;
+    uint16_t *ptr = object_field_prop_ptr(obj, prop);
+
+    if (!visit_type_uint16(v, name, ptr, errp)) {
+        return;
+    }
+    p->acs_ctrl_configured = true;
+}
+
+static void get_acs_ctrl(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    const Property *prop = opaque;
+    uint16_t *ptr = object_field_prop_ptr(obj, prop);
+
+    visit_type_uint16(v, name, ptr, errp);
+}
+
+const PropertyInfo qdev_prop_acs_ctrl = {
+    .type = "uint16",
+    .description = "PCIe ACS ctrl configuration (if set, even to 0, "
+                   "makes ACS Control read-only to the guest)",
+    .get = get_acs_ctrl,
+    .set = set_acs_ctrl,
+};
+
 void pcie_pasid_common_init(PCIDevice *dev, uint16_t offset,
                             uint8_t pasid_width, bool exec_perm, bool priv_mod)
 {
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 678ad73f7f..bbb11fd402 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -26,6 +26,7 @@
 #include "hw/pci/pcie_aer.h"
 #include "hw/pci/pcie_sriov.h"
 #include "hw/core/hotplug.h"
+#include "hw/core/qdev-properties.h"
 
 typedef struct PCIEPort PCIEPort;
 typedef struct PCIESlot PCIESlot;
@@ -86,6 +87,8 @@ struct PCIExpressDevice {
 
 #define COMPAT_PROP_PCP "power_controller_present"
 
+extern const PropertyInfo qdev_prop_acs_ctrl;
+
 /* PCI express capability helper functions */
 int pcie_cap_init(PCIDevice *dev, uint8_t offset, uint8_t type,
                   uint8_t port, Error **errp);
diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index 2ad9a563d9..ef2c2ec2cd 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -37,6 +37,7 @@ struct PCIEPort {
     /* pci express switch port */
     uint8_t     port;
     uint16_t    acs_ctrl;
+    bool        acs_ctrl_configured;
 };
 
 void pcie_port_init_reg(PCIDevice *d);
-- 
2.34.1


