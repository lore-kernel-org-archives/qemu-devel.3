Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE603CD6E56
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU18Y-0004bG-AG; Mon, 01 Jun 2026 07:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU18P-0004ZN-7K; Mon, 01 Jun 2026 07:48:45 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU18M-0004rr-RD; Mon, 01 Jun 2026 07:48:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yOqyiV+UYA6N8L75lw4R477Lo2qSLq2KMI87v9ehUFpQWBg8OvZDbwAm/n9jS8WZG2cPsI0Sa10NkeUmduV6mTP7+l4GoTdAWG5Yq0ePtEar/VaIU1vYgy5WeXspM1Gxtr1Ce9diDKm3OOq/zbMlfAd6BiOHwz5GSB4bFBRVecphNnfCbfrfPxR2UseEh9X3ILbME514tF+GuGmOCeKSgCuQUXrIE3D73BsUw7XkVMbiv91plToVYwbACHkY2wSxWsGAiwHDqtqHucjCDj42HDMJvQb3nyvCbYTpncFK9xTM61Iblo5/+xRrclLGmdh1Fvx9tKvVCYJZ1bJo7p/xxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYFxbdCl4TMFnNouDRJliyJgp3mSEERfe1JEu43Bqds=;
 b=LVsCiqPP8SLOfaQUr5ZF+clZpYdnEvi8GYxkC4HMTCdoY7dPTAxW2tIEPkQKVzJV6+7REvcIL++iaKCTQqcajPL5HKkqTB0EqcB3wUzVDxeDPefGQLIfpr7A9jxXjTRCJ9gB/MmvA4Q+JWzpY/0fCkacJ3yu43XokyKUi9JlaXfAIunESgw3C4SySaSiYFdzRxB7rAnP/9FMvqiBNWyYygCrJ1CfKe/icVix2gUwFMybj1vL+kVq7TJFNVRN28A7g4MtOYdkUv9EfR9epsCeH15GRiRP8UeswgsfRu8ch5VOD394UNgWdWAKhIKoQdZwxfnNh+lptM4zArwYWPhgmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYFxbdCl4TMFnNouDRJliyJgp3mSEERfe1JEu43Bqds=;
 b=AVnOqNtXEREXxi4L4uYHUtxUz+yIGqTkNj9+RKRrvVNCcd5uhk81L78zU/Q38cyHSq7CPiUhTU1pruMirfH6PUXm76UoSR4pc3WKv6+SVttXB7l1ctU3x7dpCODjzCl3rNKajOv0KAF3Hgdl9PHg7fZ0T2VVHEu74IF/J2IBUUHsv4xBuQwDaCHcjWuWtfDc3FevAN/7mezts2V6eIoA516x3pelaLAJQxsD4IF8UKPGm3pYyegZ5fdePVjaMgUpOyZwSAz6FYFB6x+HGIL9SjkybhgKfbnolRfRpfZ7G+F8t0Gcv+siGYTJX5h89fMEv8mfxHXkz8iG+OH3VGHRJw==
Received: from BL1PR13CA0234.namprd13.prod.outlook.com (2603:10b6:208:2bf::29)
 by DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.15; Mon, 1 Jun 2026 11:48:35 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::91) by BL1PR13CA0234.outlook.office365.com
 (2603:10b6:208:2bf::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.6 via Frontend Transport; Mon, 1
 Jun 2026 11:48:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 11:48:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:48:20 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:48:16 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 05/31] system/iommufd: Remove unused viommu pointer from
 IOMMUFDVeventq
Date: Mon, 1 Jun 2026 12:41:55 +0100
Message-ID: <20260601114221.457995-6-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|DS7PR12MB6048:EE_
X-MS-Office365-Filtering-Correlation-Id: 40d8cc25-f6f6-4758-275e-08debfd3b5b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 5uOuottRzJ7feLoaD7Ui+WyBuBbK5cN41Qzt0HXRFod+u7ekXsIHcLRu3oSoJ+eln1inuvmom9v2IW0aS2TgSVvfSXVaOM2NF10NnsvIoP0TVCoDizX2bTR/Is+gxmV68ucr+sNvKLdRbHarCtXAz2iwTYuVZCeSJWNC+bzttX84tiWL/PEZW7K99jDCuhpUNXqP2qMKreWIjcMVZoWkb6ff0fRmhwjRYvtUcGxoXUTU/6WSc+/60esyq+RZvhUp0II1Jda3rd299W8YXC3OuzABVEiQICPpmXXDH2VLKi1dWW8pFFUM2+ZC0Zy+bTzRunyn2lEdTiXC9A0MVmbVvNfrB8ThuCHOV9dtaywadwoQg0z8zVStRx7oMOBRB/ssBGAAqr/hn1VnUcSEtAQze0wF3Q8C2w5FKpdGHukHIGTyyJCMrrkGjyE3ebfG2G1ZUJQPBjo+5Sn9RZ0oMv6NCU1sqCS1EH/0rGFEU+/X8R6ZEa1DXV9cMcTgAngqGo4/p0MpQIuqpFcghtp/4ZUhun7xgzpPyxOA/F/eMZ6t5PxAugnrBj+Oxf9KncWbpoq2X9tqSdLhBYkCpl4IEPfiwmLnodiDyb3pswKI52DCiVkijO/qz92CXlg4irPOOsUgKUfix7AVFAPmg/IP5HhNeKK0y1/CbAd+Hccp4cighByrmB7faAIdaabe6G1mjcDRYA158qDtHpBzplrXg31Ri05m4cx/uKFNAM1ZgpTQJPI=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QuCo7WOcYBaJ3yb4kg/X6GQYW0LnwPa6ZyX+EG+0MAS3eHFSScsKZ7/8/dYzYYC2SKfmk6bjkTi98UvDhEGeohDm+QRJJoTHiFA2WOV5bEjtiEgdVL+uCCTcoPTLuxEdKahTkYPxfUo4TTBObCgyXUPveZCnbOK6l29SOILzsi20NrwW6XL7ptf8e8IWa+FNREBWQFAZlWEpAzDxS8M1Q9cf/+t/pDQVHZzAUMr0QP1dujd88lE9bUAO6x5jlrf6904E0OPWng8fmbm78qb4zOtCGmwXfU5dCLRl1lTgmIECJULn6fxQ1x4FA5gZO/YPuNymmoKmgKm6OtwFHIaA4KNHKhfpJH2LtvJOfeR2jdl/XckaFXX4fUwZ4uSeLyVt6Kt6h7Rq1x3JZZespGBpG+mPlEQ0IwxKSVqwOG/byFcJT1zuGHrbjXe4BY4kth9l
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:48:33.9030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d8cc25-f6f6-4758-275e-08debfd3b5b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6048
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
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


