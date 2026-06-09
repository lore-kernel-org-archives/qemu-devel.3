Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCD7CD8CBE
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWudI-0007uE-Ar; Tue, 09 Jun 2026 07:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWucE-0006MB-9y; Tue, 09 Jun 2026 07:27:39 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWucC-0002yR-Px; Tue, 09 Jun 2026 07:27:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x35PYG8vwPtGv5NVeiPsFoMJdw6RbddDTXErzcmHI8jex25BHkKzl5SA+ES5qeoki6+219VcTmrk8qRG3AE9uTpgn2+88YREwqgJyIRtKRFvW6Q6P2F/VTgKat8sSxcbRxQEwdK4BNTeGL62PFMIJhA2UZCRp6AhkCOlQWTWnuIkDHZhkLQJWvXkWohbyYTZ3O7XSVE1sr7dO8mWwGWkqjFVgQxqCvCVZPk6TDWMuTxQLsiA4wgcfTsaTw44qkqwaDzK2HaHb3e/PvQGh4sr4ZUMnJQFxbGcRb1bod8o6OgpSuEnI38lq4Z2xDrW0Rf4rTYaBYipA65Ceby2XPM+1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlJh1vl4sOTD7une3BywM6TTdMZTX09BUYTEZPiCtpE=;
 b=lC4ecK87NcRBDPz50/vfnG8IN0u8NyM/zJdjXmHHUC47QxzFyOWh2tcsknSznKq48KjZN8CLGJlUJxRTTHUCXyWOsUmhHxYysBiDTEPZTMAxdiZ6FbRs/Y1RlXlpv7uQm+W472GIjbYW23VCH2FLVPEbA/XgPWVF7N6UF1N94debOvmEjrfZjLrmV7Ib3VTD+11DXp6QkcMjkdTT9WqyDmPfmZvfaTNvDOnWfG72tt0lVK5lQUwCpIvuqMz8CB7ssiDi0LxyguE7hrHZGYWQboAvDqHkaeWnj0RPrKFNl4GS3YYXOXvMwdo6IGGGSSwRth2v2R6yOSNlxsf/Gin9wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlJh1vl4sOTD7une3BywM6TTdMZTX09BUYTEZPiCtpE=;
 b=MhOl7gzwAH1K+T8VpHB0HxY5n6nz5dixAlKtNjV2Tlr5/CPTWlgp/Gj+y4Rg9k+xYw+zIYUDtGZH/3jU54ZjL4/6nojTHBFel6PcNNO/UzWF6Lqtd/7/PN5c54IeRavPF+m1vT2/VdSuFkt+fEYUMhE8ThrDEVFhjie0WYpyCTC+lVzeAPElPIpCVTPAPlXRXNiBmdfknEiV84CaLKg811QzLLQZQcsJ/seTofvasIpOXHFA/PLaZi6njd8pBs3veY4mTVH/che0a7jy3PkFJ8n/qnbu8riGCMoj9ovHjkVaFriYXmzb7EnDbypHdxR7rYXs6pVWHMHeMiazY1QwZA==
Received: from MW4PR03CA0123.namprd03.prod.outlook.com (2603:10b6:303:8c::8)
 by DM6PR12MB4108.namprd12.prod.outlook.com (2603:10b6:5:220::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 9 Jun 2026
 11:27:20 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:303:8c:cafe::6d) by MW4PR03CA0123.outlook.office365.com
 (2603:10b6:303:8c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.14 via Frontend Transport; Tue, 9
 Jun 2026 11:27:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 11:27:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:26:57 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:26:54 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 05/31] system/iommufd: Remove unused viommu pointer from
 IOMMUFDVeventq
Date: Tue, 9 Jun 2026 12:25:26 +0100
Message-ID: <20260609112552.378999-6-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609112552.378999-1-skolothumtho@nvidia.com>
References: <20260609112552.378999-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|DM6PR12MB4108:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d5ebe52-1455-47f1-91d2-08dec61a11e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099006|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: yCbnxrnE+DHhmWuzoC5q/Vw2HiekCyvGLwqBq9HbHCCjQZbOQHi2QAzWrW0bL0BuQPtvtCf3IwWG1C/bsPZ87bDXE0+bX8J+DgOkDomiHwQ8SoeYz4BkJHajGRHmFTfY6IMVa+vL89yDuKRtw3Ayb3MTXRQG5bf4/eDrq3yw5QMBJx9i8l7evSN559ab2sQ4bmiadUzY+e9mzMoESzlELmM1QhqEcub18hq4j3XpxCu1wKbO30SBTY53C/v1wAS5GyF5le4wZ4CBzAgKpzh6O445G8NoSClS6P2rRUxm8ZEVUYXhZsEKDyyba2+4xWiPgGu9DwwO/6kUyKnC9+Rm40LtcOO+XkGrATfv889hT3cUW2tiPV+jY6zG3f4I6aZGr/R+70yvpqwdyBbEjtAriNV6csmvCybrcR3TG51xvdgGIK5lFsZjSUkgXb2J3VqittGwzEHKGnqjDDEyiaXIhWq/QsZC1953qtO29XNMekTGEB2iORFSEYfaO6zvyJGydro3tSeBItuS913feXEb6TVyBt/YkeXpeYULcR7ExWiAzglXBVlMwyxzFeLN/5UoHjbWQl+m+aztHbSA2h7R/KBjXs1ck3KWUmD7Zp3tnB5yAzb29oKhnHWT3DwcwQJSLu2ZmfmN2zI5pu+IMoRU3LAq4H2ByLqQ3A6SyrKf22f9K+GDDl948yu3erUWMomW4iufWQdWqpTbjLfi6mVDgzOW2G3MPsFevwERSaIzLKI=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099006)(22082099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: x6SeXNHUbz5Na3ygUATH+/DNj6+oZaP0Q22pXsZ05kzkOmkoV/y6dvYGwhujxVpGY5uG244PKYOl8W13KxTpZonLBX3rSX6avAXJ/5maY5IlSfx/alSe/fcOVQsUez/zBpzHTUpFOqYwXTV/e8AzUQB4TlQvPbdUAkVBnZ9wJ7e61w+rEioD1nu4i+XVgAbsPxAry4xAkGPm8OH1nGVqLxUh5kGfvlhhlsEJzOMSl6+oZVZ31BS4IJOKCw8WO4+QCoKCRiH+HC6vTs5iCSDCXeq+cp1YyAJ8GjSJM1JeijGoTFiCXO7aY+cO3NV3L43bLAyGlrJo37O/BuQcHTyx7MwG4hZ/NmD9m7TGaD0WqNVAjfGxzcZhBADgVVAwHt4zYcupB5hmZn6kpaZahbOT/oM1dDjTsl29qNCLcQVGWxlK50/RCRqU05i5/pIt2H44
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:27:20.3502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5ebe52-1455-47f1-91d2-08dec61a11e9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4108
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
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
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
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
index 4cef487679..70b2581c17 100644
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


