Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374FCF4198E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 11:02:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCxxP-0003fC-04; Wed, 15 Apr 2026 06:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxxN-0003Yl-L6; Wed, 15 Apr 2026 06:58:53 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxxM-0004GN-2H; Wed, 15 Apr 2026 06:58:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNX/BAAZTjAI4ytySGr84NRqK+n7eBYC6P0l/zsUZ9tIfAbYx7hnNxWeYM+Foej9uhfQ5k96SM93Cu2CcPeN+XhPBvtTWybyRRQfmWHhLhxlmRDBr84lF+LDO+AQ5TGmn+2gaI9AVSGqj6cNoGwrKnZx4jmngTsS9EaattGe7NIhKCmqKB+505FnQEqSuQu+Y9KE6GVZhXYszI1PpziG854NiTgS5jPUBH4fONFnhqOOwtK5Ud1IfIvJ7ESbhcmuf0zu1KPRw3pH2OWD9M0+v0M7JS9gXEGYMuuBLG5N2FgtW/RKNwDFK3Q16OFecObA8IHZa+W0tjTJ0reunXJczg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMPmf7lmQ2JWJnkc5YdE/BwZJCaYGVY3oE6q4JAN488=;
 b=Y22u8JjIiivr2be+ygAHz5D1GDOuC00EtzRJxES66KlPEDMVRnyB3C1a2xryoHbE99bYCbW08PxRZkcsRwypY2hGp/8fcu0irVkRFZwERdKrOCNkaD5eCRFJjM37Vs65o+uBPjYtZ5R9S4MAE4Vw10ZbOPA43p0Gqwf9/tHiT/l0XLyUtwacVy+vsQIhLUjbCLsInSIVGNUm4fRhcmylymxgbBoMiKn07bQpgmpanCA+db/1PSVKgPI82RD1jFLxBpacraxF2ihJivam85EzT2XZvRqGHpOWWDOYx5MmlG2cnED564RhmO0lzFnLYE1aW4p/xl6quYMcemthq4a0mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMPmf7lmQ2JWJnkc5YdE/BwZJCaYGVY3oE6q4JAN488=;
 b=VpyK852k3Xf5nsuCu+nRIxar4Ug7CPRCASlcVuE1m46TSV8Z/AnhrN6QE45IAKwhfI3KeqCTxiBZuFVnfHCXmvfPTH+eML/F+p77elyRaOi4exXgq1XEbjyGOLRtKn1ZjoqlrlNWAe+9An4dez6a+5pV/lzKXEkzCnaYph2Qyo7ggkfM/icD4EJC0PX9PgxXxXtob2wwGfJmuBgx9vMsOw1oLLe6urNA9INLYI7ozujHzz/X9osQLIQtK2heT8ZtCDV13GBosvzgeCAcUk1zqYEed4u71eEYyLS0s0lPJJO21sK65dyrgn99dbTes/hY9De1mqf5HYMvb2iXXrwMqA==
Received: from DM6PR02CA0113.namprd02.prod.outlook.com (2603:10b6:5:1b4::15)
 by LV3PR12MB9266.namprd12.prod.outlook.com (2603:10b6:408:21b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 10:58:45 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:5:1b4:cafe::e2) by DM6PR02CA0113.outlook.office365.com
 (2603:10b6:5:1b4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Wed,
 15 Apr 2026 10:58:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 10:58:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:58:28 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:58:24 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v4 30/31] hw/arm/smmuv3-accel: Enforce viommu association when
 CMDQV is active
Date: Wed, 15 Apr 2026 11:55:51 +0100
Message-ID: <20260415105552.622421-31-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415105552.622421-1-skolothumtho@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|LV3PR12MB9266:EE_
X-MS-Office365-Filtering-Correlation-Id: dad373cd-1b35-474d-d566-08de9addf704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fCneFk8T7P0f3Jr6YUpC+p2k8REBIs5xeLSqyTrUou7kaVjTYHcwMi8isU9YtAuk1H91MMHQixj6imQC3TNoWHac5L0pROvHszoHC7GExPhfqD8REp2PDN43Z9yh9neE6POG2pIDU84RrT4mojPgGSgBDNljIA1hbtcn7wHz5C2pOVwml0cEQkvBkUPILgcVwS8kQratSYNRJODtgHRwtzve/+T9A9ik8X+WRI1dlRqHbsd42UczfxV5Irb1FCsiqs3PaJNG2dW0bTZd5vjQLAq4CUh0UySpVdcE53wTB8gi9D7bkc8ebefklsm1vsEG/K/8BlRWcqIoY3+k4Qo/4E7l5i06nOyNwainP8z1RCLH9nv6e2/t8zAvZzAnERH7XXVq2NWkdAceLMBncs3yJAVSoHqZDjL9fVK0DY1zPhx3cy5iJ0fAktFibFdcW5vK9uTfS5R+mN6CoKFMVSlbn+o9/NQz6RS3pQyiFuFW98U4y2L0Ha9FuGoeFHUNfKI7PXKXqxTT0zURa204oECo3o+x5tjr2YXIKAjoZWb0bFdFtLe9Lriq4WXRX82329Cu7MbcudkflTUxQG9S8ui3+Y8m+kVJJQFWWmLCD3Rz9ivs72/2W0YmM4wQtc9MaiVO5veWJ7DH1vE/PfJ1y8vn2LwmcCDVSAdCZsD56iwRdZoNrISuM9dVlg1gaO6GxBzMjHJQXG5tv7x1Jn9CYxARpVxTsUj2NuB2EMHDPZzRXjQqidSecjzztXwa/rjK+NtvSH5ScHwTOkePYoU8yF8W5A==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PQ38sbHAyQ+irDqTaxLMCsEwYetuARZMdKHTMPYspQDtwFSBYfcXEgRkRXHRcLdAHp7Ms6sfLzi0GspvHGhDuQmdzJyudxvTqF75/1Zq43JwynJbHpNmHY9wgXSZ7EGpFZ0pNr+nSw9JIY9eMdliDgoZJ5SVB/rX48lZMhUPTIJU1JWj9iRoIgs9SM1CStVBJZq316y7a0OZvQ4FWsiP8t1iEa/AA4/a/l3D9Sz5VfWhDgc2ouzeqsorHq//D2oZtjVCd4iNbu6VOd/6j1hv3nbet08TvF/ZvuFRctsxeZpyYgAhiUcY6AEmsUANsnPPitbSs6Tjm9j8R7TrJ4AQbNwhH9c+dGHcFk7keh8XM2q2XYZNhbijsjWmGBNBkvZKIZnxl12Po0mnfInyLab7aef0rrqxSHATp+oqB6CHKSsAIy6cbGwbTZKj1GfzkYEQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 10:58:45.4577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dad373cd-1b35-474d-d566-08de9addf704
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9266
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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

When CMDQV is active, the first cold-plugged VFIO device establishes the
viommu to host SMMUv3 association. Block its hot-unplug to preserve this
association and the guest's boot time CMDQV configuration.

Also abort at machine_done if cmdqv=on is requested but no cold-plugged
VFIO device was present to initialize it.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.h |  1 +
 hw/arm/smmuv3-accel.c | 12 ++++++++++++
 hw/arm/smmuv3.c       |  6 ++++++
 3 files changed, 19 insertions(+)

diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 3ed94ed05c..c4441d5b3f 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -65,6 +65,7 @@ typedef struct SMMUv3AccelDevice {
     IOMMUFDVdev *vdev;
     QLIST_ENTRY(SMMUv3AccelDevice) next;
     SMMUv3AccelState *s_accel;
+    Error *unplug_blocker; /* set when CMDQV is active to block hot-unplug */
 } SMMUv3AccelDevice;
 
 bool smmuv3_accel_init(SMMUv3State *s, Error **errp);
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index a58815ded2..f381702a08 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -754,6 +754,18 @@ static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
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
     accel_dev->idev = idev;
     accel_dev->s_accel = s->s_accel;
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 1d6fdd776c..c9ff6298f5 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -2020,6 +2020,12 @@ static void smmuv3_machine_done(Notifier *notifier, void *data)
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
 
 static void smmu_realize(DeviceState *d, Error **errp)
-- 
2.43.0


