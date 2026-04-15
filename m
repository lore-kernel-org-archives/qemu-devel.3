Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA60DF4198B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 10:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCxvo-0000YY-L7; Wed, 15 Apr 2026 06:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxvn-0000Y2-GG; Wed, 15 Apr 2026 06:57:15 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxvl-0003vf-Pb; Wed, 15 Apr 2026 06:57:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jv39ALU7Zcs2vmdN9a3BZ2SSo5v0+aLKRlNRkMqgwKv5QJABr6SeffjGFOsoX0GKO875wnxEJISN8oUMkt91e65GrRYWqUJ1QEUr5gxS9NVy1Z5lt0y2rjy5RsKvtLGO4gRqIa22GGblvO212ztVfzBZgEd+Sf9a3IhwFLlhxW68n2+o5LzcIjaFvo/guLM7OvREEq64Pg0sglX8lfMzJ9h6OSD/VGv5MXdxOxYNu+mYpWcw0xO51uki71V4FKM9NvtoUEoFOeSUDghSN8z+CRuQXKpwRhnp00hD3aB1q5pO+PUny0Wih9X3Wvsb/qkPB14VXoPe85ZApovcZARxAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTFoqodJfOfTYsMCcMU1Ps9i2UugVBYYZ9XiIf3D2EE=;
 b=zRPBJvssQAdefidO3RT8UoK+xTyxTLDWDuWO2/m9plbTlhiHtCblVIjZw9RZK43Z3ACOU4ErE7shYiydX8QaHeQV3D0DwvaF43YMELkUCmSfa3YVJfeogowpZOCEn7puAWAFCA+PLQG05dLv/luWYC+BallqURUZVS4takjyxSMM+XDCuNSjQlNhgFfItjFLckfwJYSzduLFiTnCNsA+VjQFv/SfdK0Dv2zLPwSrfsQLRqOyv0G1GiSG9s/33RIqtK42UI2KsqAmV0hriXuzClBwDgJLaIhx7bQIoz2IbKOSsw86cprh5xUEmnUZ2VsV9bWmCerAZ7dbSakCWMnkMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTFoqodJfOfTYsMCcMU1Ps9i2UugVBYYZ9XiIf3D2EE=;
 b=czzeUWT2VjikmvHNNQHhozDTB45kaFHLn8EIKOtI1uF1jZb6e5HguQZ6X1yvnVk7Yh4muI8HD5UpbvLiScD8eHfWMO0FXDsgRHbMyhnpZd8gcP7OcxYAFnwRPUOpK9pQjjmdVdPSSrOctfaeSqIBZpchDGcvSHMqZXRpWwO5crJpyDh0L3z/+mEfL/yc9wqOjogsivvVXx65MbOcIVsOqWkygMFE/HMc729/DeRIsP18sojRigx8mFFzefU1+1xxpqSp5gdG5z6kam2ctsnjaDMRGMp9ygXwUUiKJ0nUUfgJywTsWQzVBMVh+FaeK9BFE4Oy42wff3pSLM3TR/29+Q==
Received: from MN0PR05CA0025.namprd05.prod.outlook.com (2603:10b6:208:52c::13)
 by DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 10:57:06 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:52c:cafe::56) by MN0PR05CA0025.outlook.office365.com
 (2603:10b6:208:52c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Wed,
 15 Apr 2026 10:57:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 10:57:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:56:51 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:56:47 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v4 05/31] system/iommufd: Remove unused viommu pointer from
 IOMMUFDVeventq
Date: Wed, 15 Apr 2026 11:55:26 +0100
Message-ID: <20260415105552.622421-6-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|DM4PR12MB6085:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bea79b7-06c0-4d7b-a867-08de9addbbd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: /AEYox9sMcO2ShKt/CW716wUgdw6c07kRPYSzk5oR47YvGrj1mbHm7TscDdda9VAN83s9EXgEsIwDe2r3yTUcS4/JlfKejrRh3udtbyDLOsT4jbsRAOKcVkWGC1s509ADjqD6aRnGtAYV6RY5QXePLdwqW838VUpdKUqPOiIT6LpQnVIcK2zsoY3GF3Ew/WiDj8H5XYlCgqfZhLdAllsN/TF0WKF6TOaoYvHJR9SIU5P0rSzxB4pskJzrCCRjQXMHZuhmxrsicy6wJh7lc/6Wzw6BIB6rcxcAVtW7C8Ll4/ahmmOiUXhBUyiYKQCOwaBry2JvQQ4wGa467AXoJ22Mj9/DqCIXdPPgVwdtrv82fvLGQSGuQBqqZognca+23jrcxLW2XPUsH0pbYVnLG5VDGl5tw1QyxATC92opnV1FunqdVY/EQhEQdUZRLvvOkE+1VihSvRx7vtE4uc0uwOhR8gavSIFosl8oHaxjXLRpE7bi49RQnRzhR/sLkzm0tBYqL53rN4Cv/d6l+4NZ8BowHTTdV0czewFTF/jZ9ZO3W9mnQ4lEIzyH5eB5VBCiUK6DZt5OFHi7go5G//YRCLEsPYUX7zeagdYwGtcGiSSMIsALGmvS5CzfGvtXE067prdEumMbEL9lTtbQ2h2uqA+TGkptGsI050pZnpHOWhAsW1VK7VLUUMoCj3W5jSa6ruEr5eJnFi1tvH/mKdGapsa0xvABtkd10MBwjLYcpmoA2QBS/S/mM9wJlBw6K/8zsCMw6t1EjWk6Dl8I7mjz1ElNQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6LxoizvqTn63H/nEAZs7g51p8f9itFj3d0DM9sYVYzdy1KhTXAJLVPd820UenIvR3AunRph4yprT2uWAxcsZEOlLBpbb1GZLafZylNuX6DC/CJi0WuD9prH2GisD2Xmp7aWvOVpbY3xI4GXLP8XHYNe6iW8DybCbN67v1eK8eTZShkgjkV45mcGOFCM3dPKk0Y0qUwHoUBTxqbT6pZPemkpJPecDE+gqzU4OnmtWDf3NLteJoiS3NNZOBLV4O76L67A0AGT9OnewuWz2bxakZHwpYRMK/P5LB65yVUOG/mFASwq/+qyKBKsfiqk+7OIX5I3ZOkwhuhhp3BEvJlZDlG39VI4R0D7a8BCUoVI6wSy7zPyhfFg+Sthj890BqKSDRxGCOtkhx10dEgXghtLg+9BLlcV/BjPjaD7zGjRaQo+unfx2H7ic0SsdmctmwQoP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 10:57:06.1218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bea79b7-06c0-4d7b-a867-08de9addbbd7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6085
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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

The viommu field is assigned but never used. Callers freeing the
veventq already have access to the IOMMUFDViommu object through other
references, so this field is redundant.

Removing it also simplifies upcoming changes where veventq is
allocated based on the viommu id before the IOMMUFDViommu object is
created (e.g. vendor CMDQV-based veventq allocation).

No functional change.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/system/iommufd.h | 1 -
 hw/arm/smmuv3-accel.c    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 38cfceca84..b6599521b8 100644
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
index c356ff9708..f65e654adf 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -549,7 +549,6 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
     veventq = g_new0(IOMMUFDVeventq, 1);
     veventq->veventq_id = veventq_id;
     veventq->veventq_fd = veventq_fd;
-    veventq->viommu = accel->viommu;
     accel->veventq = veventq;
 
     /* Set up event handler for veventq fd */
-- 
2.43.0


