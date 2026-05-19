Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E15CD4F57
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHqu-0007pb-09; Tue, 19 May 2026 06:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHqs-0007oH-3m; Tue, 19 May 2026 06:39:06 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHqq-0006Qe-Ip; Tue, 19 May 2026 06:39:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9MULfVM/fdiQgTMbyIOUXUcVzH1ZqLh9RgQ5FBGTTkN4o9luvCXR1eE9ZPhtinSbz8HxvciyKHayLpys/6Prd0H5RtFjft1S6hlug6rqbT9ARaCf2gyCUJTq4v/CjVChYAq4PggFakPi24MyMQ69SF2stkeZ5Tc+owrKIKsGlA10NICmC4r/BF/ndS1fHRH+yV+EX+V9GUiBgCoG5QJghgQN+Qgh9vT0JNpfAMZAfyfGOUL3C21F5Kg6caWNaGm6kiVuQSif5mVgpXQl7hl7DQRmaq9TlvSfRKQzue1WmRKZ/Re9LTshibIYnKMa8FitWO+9L9LuVbsDd9b8W49jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzN3gQSCr3I3Ifm8NwiaRMXUJ5s5wawTFcIcy3w7rpc=;
 b=JeFgsF3HqMNfZVpN+p6vMH9m88c2/0jCJ8lFvhCuO3bXTpM9ZeHx22ca2E2jnE2MMEmYVnA8gshpg2aHkBO0mQ5Uo6nMTNBJP494mooIce+lntl0z4gWqmjOrn16GYW3wr+GR3vp+J2Ekfo4pnbURA0tJIjC1PDFlMoykjJnA9LlNmsCYAYmRdXHWf7F6MTqv8cXlfg6BgQzHtVaQjkrccD0HqSaikaqRrz7h/EvEa4gGJF3EYuXTrB9jSi8ZbksnI9hYo0AW85U6xlaNZT6Vv+8gYW3gthBK0blEcv2FA5aQaCsVEFeP/vWT5xJWi1tBK8HEntzpi5f4u21k+zzCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzN3gQSCr3I3Ifm8NwiaRMXUJ5s5wawTFcIcy3w7rpc=;
 b=Z6sQ6GR0UbK5xJyGodfGihEfLzqSRXZEW3+hGVrcKDpO0vcTcKZzcRLmHEjrDD9Z/GkP3HYHcZMXEJljyNQOngKCjez9HZqrvkN721TZlGujRm1A7q0WhHe+b5hsrAcVXE857tmtKdLjDPWfUkJyAaRRlNPkAu5L2J7tPetVcuYEF2TKMRk1wfTnJS80UVPueHZl+sX47k3+c8o1u5xqRoxiG3uH2SuKOzKDwDioYL7YSUDqZ5Y5usLx/jOnqObjpFCUpi4BFuq93ZTgwu+yb4CtnEggLUP4cMqJHiOZH5dM+N1e4iWS3ty/SjhTAQeVCCEyqIjw5Qyu5WkkbT4qmQ==
Received: from BL1PR13CA0239.namprd13.prod.outlook.com (2603:10b6:208:2bf::34)
 by DS0PR12MB7874.namprd12.prod.outlook.com (2603:10b6:8:141::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 19 May
 2026 10:38:53 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:2bf:cafe::c) by BL1PR13CA0239.outlook.office365.com
 (2603:10b6:208:2bf::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 10:38:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 10:38:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:38:35 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:38:31 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 05/32] system/iommufd: Remove unused viommu pointer from
 IOMMUFDVeventq
Date: Tue, 19 May 2026 11:36:43 +0100
Message-ID: <20260519103727.899332-6-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|DS0PR12MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ab83e40-9490-4de1-694f-08deb592d243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 3+AhyveI+1J3mPRgxxskPJXXa6ALEIg7iSDcFpnUZY1cfjUs2YtLeDbsh+xB44OJyoWed/vk4uMqLjgt/SYVWPYZE91D4dCAtV8YGlBosSM9hyCTOlFAM22CW4/USESFCwNBqtUQifI/h6atm828Jcj0eNqZ6VcixIP+mszWyUEdE7y21woMk7PxORAAo1utm2uCrDLcP6VeebJYUYr5RzNUfbPDCbdV1erCj/OL6gE2slY1z+DrVlI/vffSOHcj0rSP/Xoj7hZ7Gp203P4g6YI5FISBv4GVFEYYeBufnaM0R9lcH2anBy2VI6SvE85V8uE1fHIVFyahPziQDi0pi/c6p2gm9MiZOnq1B+dsRWGWzaKsAXJ8wfImep3AS3sxZcNH2jf04oPNU4trUnA50o20ti0HIZCvjEd1C/pfwr1bwQakDdn4y509xd8umEJiWuqVvOVP98j7jlffAP5ooVTh2e7bsMWJulkmNTZx86HdojMt9i9u6i0Cmgb4RvFD1O1sX2YoF8DMYZjjzGX+5cLoSJnTuO5aCA5SD+n0SN2XsJbp7DyCpw7lxEICRfJlB9mUd7bjqZbCL1t5Cezl/8JLFvMO5cT2QPy3R5iu7Wmt9wq5eX9XYo7QU30bbMgAvElL0L6T8EvAqXFk/X9pXm/6lhTiCnBRH55//RI/tJ3QLAQ9AgV3WBJhpGzbE1qW5++A+PY7wypxwIlqYFkBds5yf+VmV7yoBmnk99Gr4Sg=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DnAPVijAhvb/PVyGWkKf+cS0Xpw9gDPYo9Qdcmry84+5aIAW2eUIbSm8b5yuteY3RfPC+O4Y8V6t2Z8LWjnnwALDvPQO34sH4QoTdsesuqAXGFI75J0hTKlinee31A3WyetDh2dHlgvR2Hcc2HbwnWu6zB82yeCmfelEpSUVCgobASF4Ch7mmUWvZTBmgaNkJ7i8oQ9DHLckxeP6WkDvM2/0Mixdyz9afsAkxybto4nByjpoO6b8wHm1DvhbZoRS6mlXXY7jKuu3FLD0HvjYxjKN1QuNk6jfwquZDbogAwLUZPYN347YxH3EAaLa1GkadGRJztv6GFph6TFrFNe6zhKKCp7ExA8l4Xtk/hA69zy823f6PkASnIpRwLBDJkJ3aa/e4ygmIzjp/gz0gcWR4F8U4nrLvgTS7klLN+Bp/aEokSy7R2kHxJ5k2GICB+i1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:38:52.8693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab83e40-9490-4de1-694f-08deb592d243
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7874
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

The viommu field is assigned but never used. Callers freeing the
veventq already have access to the IOMMUFDViommu object through other
references, so this field is redundant.

Removing it also simplifies upcoming changes where veventq is
allocated based on the viommu id before the IOMMUFDViommu object is
created (e.g. vendor CMDQV-based veventq allocation).

No functional change.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/system/iommufd.h | 1 -
 hw/arm/smmuv3-accel.c    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index bb8d5081d7..da68ba0037 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -58,7 +58,6 @@ typedef struct IOMMUFDVdev {
 
 /* Virtual event queue interface for a vIOMMU */
 typedef struct IOMMUFDVeventq {
-    IOMMUFDViommu *viommu;
     uint32_t veventq_id;
     uint32_t veventq_fd;
     uint32_t last_event_seq; /* Sequence number of last processed event */
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index bfa6a03f9e..30c498ffcf 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -553,7 +553,6 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
     veventq = g_new0(IOMMUFDVeventq, 1);
     veventq->veventq_id = veventq_id;
     veventq->veventq_fd = veventq_fd;
-    veventq->viommu = accel->viommu;
     accel->veventq = veventq;
 
     /* Set up event handler for veventq fd */
-- 
2.43.0


