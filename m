Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32575CD5BA4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHso-0005Wf-6A; Tue, 19 May 2026 06:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHsk-000599-H0; Tue, 19 May 2026 06:41:02 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHsf-0007T1-3y; Tue, 19 May 2026 06:41:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyfRkDWXzk0oLm4oXKx7oGOv6G1uZ7wbceKOWLg7yx3lXbCQU3imUUGknQkswRNr4cowv5hbJ4/ppHgox2SuDuOk71QrNaQkbclyc0AJaAlWYNzqRaKl1H9iqcYgp+Sz5OGleXl/Y/0HmFAy/Cg4L+JZ9+ouqBMRVfKw9NjkhfxCbJqbjWJ7MihHg41N9laauMeQuonsJVOxPcKNB1hJ3lLAT56EWVRz2E/YmPRKfRtUb21UN361ZsxIOG76JQmqv2Wo5mkj2vJ03VpdKFU10o91kDaEcKdLEggMju6MbS13T6hHt5Yei22NzXihM26vPEhHHLjVlOi5PzmuvQ7lkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QN0D18HZCD69yGnIKM2WtBzzjkDTLY++aS7GScREmzw=;
 b=iTyFp08TUsWFWlltzR416Mi12GUsw0AQGwfFHuGUnLQS53JGJOMrxpJx1/cuLuY9bGveq8j3YGH9kZhOUi31GSmjip+qjtmI+F80botbXyucE5v0UutIATQdRAEw9PBSZTeki9oowqPkIZya7/XEDlgVXqAOmYXWyOip4n3CrpWQ6W04j3dQKcOWHwCWxioWnGGliYmMu6wQBNEkTP9POV9DnN6GdNrSi+zDnOZacy31UdJKSwU5krdUpDHuJgHIjsp4aDFX9YBfnglye0aJ+oUkLHgATMbkU6zpi8rIqwKXNjqjZYwql3sQ557aIqshPv9opoUXSGhDEXPGQOYDYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QN0D18HZCD69yGnIKM2WtBzzjkDTLY++aS7GScREmzw=;
 b=iHezbeV6Wav+sWU6klWXITxwa2qqDI3LRIxlfwPAWkdN8gAYCO2ANoCfwjOnHOBPe6jzeBAIq+6tEJi6h8PdQv64SYNckCkpXyxJnX/9OpQEdb6j7PsXie3cuByjFMttv/1/RmikFO9Q6u4l36y8Ng5v6pW3F9vBVPHl6YVXbsvppOXMryWyyTWGATYGxPcM3DO43WAYmJKHGSKbf1ow7W8G9NEJbk4wj5d8V4jUO5KlAjJWYdKMNP6w/GqDN97p/+uY9GDt1DaAhmJaNmUmirQBvBTcAXh7BH1bVJxw1J2U5jjYd1yhZBDMBThWoatpcg4Gacjh+CgfyYFl1cbccA==
Received: from CYXP220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:ee::14)
 by SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 19 May
 2026 10:40:50 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:ee:cafe::d6) by CYXP220CA0011.outlook.office365.com
 (2603:10b6:930:ee::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 10:40:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 10:40:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:40:30 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:40:26 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 31/32] hw/arm/smmuv3-accel: Enforce viommu association when
 CMDQV is active
Date: Tue, 19 May 2026 11:37:09 +0100
Message-ID: <20260519103727.899332-32-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519103727.899332-1-skolothumtho@nvidia.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: b6d64f71-a660-4735-af7d-08deb5931862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|11063799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mdEbbz5exxRp1My4Jx6kzErpqHlEC6a+t52xM1tTV26doajSSUh/tChOTBxVuxSa2v2G6u+wk3PtsAl5agHIwumCnmOki5lipYxvdVuipx/giprwZtNiSX8WlFLYztHQu6tItZYnzQ5wYriyrWVllW3HQrnbMOYLmHqOPCk7jvC5MB+gGn4KamgHd7xNRH99axNu18T9ip1q5U5ZZPJFh0yaaAI13ZVDCe8Sj9YtFRetPjhcwvEQ3Q4Jn4WRdscyDkFMrW5MmdxjpgwUNMOB/a1sxe4v12Hqi9rq4AoKOQIvLfuNI3ZOQmNeb+Tebq7fJ86A3azBtYE6T5BWaEOmniwDC9+nGxY3hsrxWpZn0IAaNJFzi6w8c95SS8N7FU59zFKixrE9eAVpYwYMl9rLAOiirU9kqhTC2EJJTRMJAUA2/5OXlZYZ5QZaK1/7sZVseS2SEPrDrlzjImGGBQLqdiBogfUmzlAEWGPXhAcPoivR71c7l851xRohKH2qfFA37e7/aOjpjTfQxffFmhAwKqu/O3+QbL6jGWBwY2LM2EbxzmdosygxehlIBUe4ZgMykwOuCOt5V5gf4i5WIz33ZlGizj93verjNojZauorMbOeSTuGX9Xmy/Nq7YLw77eacTPJvMbjuIFFtgqWWIcWrd7QfgY4MktFxhFisLunrOJigy7GyHT4Vm/2DpAV5ZOfKVgYo/jb4MFXmvW/jGVK50ZkiqRCebOciMkKpPEOROQ=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(11063799006)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8/PYkDLiOE4+4A0Q1f/O4rOQi0YueAPEJl8MPZmVV4JEftBfL9inC3Nydd+XKV+7xdnMCCk5wISbvCuoXqfZKIXg/148sZ3+1TPPw06LMZnQBeL+dGkIvTfdw0EefuxN3do33/2lf1CVcpK7Z7I8I1xtdk5Ab8kmtHcXxz/VhRL6Un7oItGULmsp3+VULeG+Bk1VHfalO9kUUwIKdWdOrdoEAJ9r767mLHWis/leJiBFktTdjuTo2S4ArXBQkahiI3gNJDWRUrA6PzCwN2M9yQAfsYlLNGnqZsNMjN1BfwHRrr8bnD+l3ZbFxA1dWaWOVVN9S+MZk54gqarhpHSdsnpzYEvyooQyFpgRz6FOhaBvBXFCwmmKySLy3bUKQZ9A6yVN2fgwAxk7mNlhuqKHvjivyEumzfitiXQjnLXhlehL2ayA+s0IwdeDSHvT7C/M
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:40:50.5769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d64f71-a660-4735-af7d-08deb5931862
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442
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

When CMDQV is active, the first cold-plugged VFIO device establishes the
viommu to host SMMUv3 association. Block its hot-unplug to preserve this
association and the guest's boot time CMDQV configuration.

Also abort at machine_done if cmdqv=on is requested but no cold-plugged
VFIO device was present to initialize it.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.h |  1 +
 hw/arm/smmuv3-accel.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 8cf35c2936..4d05eb100a 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -85,6 +85,7 @@ typedef struct SMMUv3AccelDevice {
     IOMMUFDVdev *vdev;
     QLIST_ENTRY(SMMUv3AccelDevice) next;
     SMMUv3AccelState *s_accel;
+    Error *unplug_blocker; /* set when CMDQV is active to block hot-unplug */
 } SMMUv3AccelDevice;
 
 bool smmuv3_accel_init(SMMUv3State *s, Error **errp);
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index dbb50d1795..03575808b3 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -761,6 +761,18 @@ static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
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
@@ -1088,6 +1100,12 @@ static void smmuv3_machine_done(Notifier *notifier, void *data)
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


