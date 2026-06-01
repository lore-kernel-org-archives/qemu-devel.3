Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D64CD6E56
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU1Al-0001BX-Mq; Mon, 01 Jun 2026 07:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU1A6-0007y5-A9; Mon, 01 Jun 2026 07:50:33 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU1A2-0005T0-Lo; Mon, 01 Jun 2026 07:50:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJC8VM3FnhrnPOZ8zV8REZUfOnccqrj21hh4hQx5OSuor4ZREuhzKeh481FLGdipxd7LWWtWv02HlvzytlO2kxGtYuKHPrszrqNhZsPouBr6M2dd3wzu8XFxYOSOp7iR5SqpKiKOoIJCGLmwBBGgQxNrqTmuBrmh50xhr3HDdUSre3TwysRSL+Puphr981kRj3okKmyVefZFB9Q5gx4Oc4L3e7YP6QNoLrzE+bQK/s72kOixmnXJS1f9IM8uyoBM4H9BRp2Gy1baT+eh1RLmOiwUVj1CWPf+1aN133EdXwTjmTW/H5YO2FbUC82dMMqI1CFE7kFRLxP/zFbp+JT9FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hVQ/holYJL7aJQ2/r47Snz+ZdcVkBO9PAjJbhtuEm8=;
 b=wA018KUb4ZnghWnqTdVOtrVcSu81OCWMF8n26CGj9fOHgSfIEtYJsVxE2RgWHz5LzdQrktkbUfcKHVp7c5SID/jukTK3XIR3M47r93baa8/aNc0PKk1YoCZ5NIZxK5xFZARwP6HBfAgHjM73jM0Vjki9l/J4gSSkkfyP42pD0hsdHC7FzjoiC3Dcg/pD1gG5G0f/M2uWWPClTIL8UtbZBfvYKgUbkonfzEmPF99ViJS0rHJAun9+qtfD/IUxiPBELk5KRcf4NAuu6X40jxESvAMS6AtSXFZJ6hZveFjQys0+KZM7pMtJg7TIeKrhFXOQM3O22j3yp3pz4Lk00v2+KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hVQ/holYJL7aJQ2/r47Snz+ZdcVkBO9PAjJbhtuEm8=;
 b=YmcGxTM8JkfyrgRI7Ln8pZi2DE6GrVyyv9BdOm8GqgQtEitV4WYFTDbbaEqKIttr15mQpueyPkITti8TMro4Y0Wdcygar3n11p1g3zEkfoFh/tBUy0XCjZMZZ83A4k9Icf3FnbiKpcItzlnRSYLQZdvXqeyAdj8tAdW4aWm2EsGPUZ8jaSMuWEzlIh6Qfdyhy/OoRKCZmAmlMTWqrzRmE7+kqc3s4BhS/2bnBiyvJwDC+UnVh1lmn6zu5fIEhrEUHAu7Faee04x5US0ZylCSE9mM7g0S9PU3Kyvry+8gCNwOrzX0XOZf5Pl0ZXP49jDGlhUam7BuelgReXi2QWa3jA==
Received: from MN2PR07CA0027.namprd07.prod.outlook.com (2603:10b6:208:1a0::37)
 by PH7PR12MB6718.namprd12.prod.outlook.com (2603:10b6:510:1b1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 11:50:17 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:208:1a0:cafe::85) by MN2PR07CA0027.outlook.office365.com
 (2603:10b6:208:1a0::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 11:50:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Mon, 1 Jun 2026 11:50:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:50:04 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:50:01 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 29/31] hw/arm/smmuv3-accel: Enforce viommu association when
 CMDQV is active
Date: Mon, 1 Jun 2026 12:42:19 +0100
Message-ID: <20260601114221.457995-30-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601114221.457995-1-skolothumtho@nvidia.com>
References: <20260601114221.457995-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|PH7PR12MB6718:EE_
X-MS-Office365-Filtering-Correlation-Id: ed00166a-e7cb-4a71-ef0b-08debfd3f2f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|22082099003|56012099006|6133799003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: 1Mpf3qqjkefq0J+tCR+oBwBeDQoRtcK1BzlH2Qg0VRLQU4ttHQUBh2CyoWm5+/ApJVVL0s6UpLQujxzo2g4BQREG1GrXZCdy4YlNy2CVkhuiUmNVydLdtE2Q36ULUDPbGmxX52Ob3gIdZkdQZqdMcIdj0YsPynxrkPwyCJjq9x8I0MK5IEx3RUcxrTstky5riRLTdE/LdpHS8bt6e0f8wCp5PQX7g91qgQFVM2H6X68YHup+sQ40SLmjB/2uqjs2nkKAKok41Uhun5oCC863QS0fOVnWwxbcUugtspYH54ZSr3BIaWA83BW+Cy4oztkdX9Dp82xjWIuf8kzgyTdfS/VF5HHqfrjRykbzIbGiEjXPxWETDOxmSyB3jjE/f7Pzg7ehe+nTvPrz6M5Agh/dVKLSJfPzTP/J8ilAOXq3cDaI04ZWEuAVh8VnIH5MTJpGZgSuktEYge22IPhrq8yCo9tOF6GnLRe+9R03+dZp5lDxc0IgJRRnV52rWywmCUz1XA9A8fOV6pj9YedZMocqY5QnYsM0tanpfyDxWUOwBF3dC1h0pRk2VMRaUoGC0zIt9HoSZmITRMpqkKOUQy0e3/z53CeoiorugRB89mIVa5/WSIRzAgwdXyO4EPtSo0o+U2olY5se/Jb/MxBx5tzAUKrTuDeLsaVrFmxfcYxl9AtfpjZhYrctTpP9DrlRgNShR141acv9dscy8sKdfUa8HuZB8awNeNrf08Ot3HLG4Eo=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(56012099006)(6133799003)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Kquy0/kDMtgJhauNDU6ctyakAvzq2EVNxK4Un0jcSEO7oI/gX4NOMlBN08697MHImp7qRWeAQOLiatQlPfAPoMcb11GBrKM4XXA6Qyzoc6LN/NIFH2+sjvECi3npoTY98WlPUA+FJt0UEEgOE5EHzZYcc7vPSzEnAqJvMXbM3Pt5PC8nVAa0NEWV+pYJojRxDAGPkVsSMWLiLej7DGVyKTM6IH14hdD8Zdb8OnxqRndKs7UM+NIOYKBNb7iYLS9//aVvm/i+ka8M0GL4SzPG540svzBmMfjcD+OVeLObNxPQhbahtV3QgH0YF2luUGGiPCc1ERlEwTCr8uqKSjKEAkigTfhQAG7aDKQJXjm0Qrqz24oOOqGJ3sNhuSJ1iNfEDF8fML3V8ImSa8guaU1vuVzSMopNCrithUXBxeUJOgh334kxf87uwks++xcuH7oc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:50:16.6615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed00166a-e7cb-4a71-ef0b-08debfd3f2f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6718
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
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

When CMDQV is active, the first cold-plugged VFIO device establishes
the viommu to host SMMUv3 association, and the guest's boot-time CMDQV
configuration (VINTFs, VCMDQs) is built on top of that association.

Hot-unplugging that device would release the viommu and tear down all
CMDQV state. Hot-plugging another device behind a different host
SMMUv3+CMDQV would then re-bind the same vSMMUv3 to new host hardware,
while the guest keeps using its boot-time configuration and ends up
issuing commands to the wrong host. Block hot-unplug of the
establishing device to avoid this; retaining the binding across unplug
is non-trivial and not required by any current use case.

Also abort at machine_done if cmdqv=on is requested but no cold-plugged
VFIO device was present to initialize it.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.h |  1 +
 hw/arm/smmuv3-accel.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 5fc85fb89d..dd755c394d 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -84,6 +84,7 @@ typedef struct SMMUv3AccelDevice {
     IOMMUFDVdev *vdev;
     QLIST_ENTRY(SMMUv3AccelDevice) next;
     SMMUv3AccelState *s_accel;
+    Error *unplug_blocker; /* set when CMDQV is active to block hot-unplug */
 } SMMUv3AccelDevice;
 
 bool smmuv3_accel_init(SMMUv3State *s, Error **errp);
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 9c3bd4413d..80900c2521 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -759,6 +759,18 @@ static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
         return false;
     }
 
+    /*
+     * CMDQV is active: block hot-unplug of the device that established the
+     * viommu association. Removing it would cause the vIOMMU to host SMMUv3
+     * association be changed via device hot-plug.
+     */
+    if (s->s_accel->cmdqv_ops) {
+        PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
+        error_setg(&accel_dev->unplug_blocker,
+                   "CMDQV is active: removing the device that established the "
+                   "viommu association would break the guest CMDQV");
+        qdev_add_unplug_blocker(DEVICE(pdev), accel_dev->unplug_blocker);
+    }
 done:
     accel_dev->hiodi = hiodi;
     accel_dev->s_accel = s->s_accel;
@@ -1082,6 +1094,12 @@ static void smmuv3_accel_machine_done(Notifier *notifier, void *data)
                      "at least one cold-plugged VFIO device");
         exit(1);
     }
+
+    if (s->cmdqv == ON_OFF_AUTO_ON && !accel->cmdqv) {
+        error_report("arm-smmuv3 cmdqv=on requires at least one cold-plugged "
+                     "VFIO device");
+        exit(1);
+    }
 }
 
 bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
-- 
2.43.0


