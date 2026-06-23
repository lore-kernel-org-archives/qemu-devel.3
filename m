Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73395CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 10:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbyZE-0000ct-75; Tue, 23 Jun 2026 06:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wbyZC-0000cO-F6; Tue, 23 Jun 2026 06:41:18 -0400
Received: from mail-westusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c001::5] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wbyZA-0002Bi-Rc; Tue, 23 Jun 2026 06:41:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=huZmNNyNwntW9NYj67eWZ+o3AuZle+I+e4GMvF5Xmcv+rHtQarJxmWdNMub7txUiOIQcq45RCIerXMVlwWUqUNTA4lmHafqAH1FL3w9KXq/1JUD4OSGvPlJYfCEQJVeH2CxgLtXcp7D+rKmnye5tmnYhDD7TmLz6PUBMYDY2V7B9ASg7dKgEFTat6f6qVwu/AbER0oZ6tOU25djrhnwsmcxgwp/ViUNf/85MBxhKpnwe+sx11T4NnhgE9f76hQtmr2AHrZcdJZKNbNThMfG3Gb3FBv+T++O5h8vtfuQLyMuNH0Tu8FQ4lCbeHY1zDN5eMZRAbXuQitZiUsteC2RlVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlvvTZUpSZ8jXhDh/gXFsvCKXG2Yp3XFRtU5TGjygUM=;
 b=Rd1/XnIsqTfWlvBMxMOml1SFce713jnK5hLYajWVFnfMdjfJam/X6N56gjK2PByob3jI4OMtxfIVMw3aY/cSn+QJeGx3J2Y3sv5+XPFEe7z5YUTkVOGaAZeGsI/6Ze3ES8EWO/3R4w9dscoSmBm+oYir23VPKsQFrw6eUjAubCB2AWyqNHuZH3Sisv3HCyIvltNHao/JP2joch3QvqKuengyUqiEJG9XD2NZ0lq2KW5EoFMQF/xEztis8S/Lgpkd9SO3XP/W4esoQ/ajKnVJb5Ni1F9kGeiU5Tw/xl1/d1h1HxMpU33toTr1i3MlTJvboB4dXQZuVyx+BVEfw38zEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlvvTZUpSZ8jXhDh/gXFsvCKXG2Yp3XFRtU5TGjygUM=;
 b=qOHk4i2l6Y4Nq7yZkxQ8EtJxXTPXHrxDXOy9O+KEkyxmh+nZdwe1ZG1Fp3tKQF6P3jJJH6chFlPDRTN31NKzwC/uTzQrv2eZj1ocOgcRFPCUXUw58ByqUIpe6mAGVG6z/6y7rDyxOfZ7hnPQrQOofegDdnjQ0oUhKd0OL9f36STrRxtwXJ12S+9MIUs9twPrKdjujoDeM6ht3foZKbRRL0Td7pYvZxiDcE7zFV+CitOgxKaUaLJ8puFXsZIPhZ+zDb2K+jtJO9+5/bzusRAvy8wpWoWPJ4yT6f62MVjsCCKy3/15MycDRRdNxn7Ek5KpxnJk0dTN3VHtKe96vW2oZQ==
Received: from BN9PR03CA0296.namprd03.prod.outlook.com (2603:10b6:408:f5::31)
 by MW4PR12MB7261.namprd12.prod.outlook.com (2603:10b6:303:229::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Tue, 23 Jun
 2026 10:41:09 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::38) by BN9PR03CA0296.outlook.office365.com
 (2603:10b6:408:f5::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 10:41:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 10:41:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Jun
 2026 03:40:53 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Jun
 2026 03:40:50 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH] docs/system/arm/virt: Document accelerated SMMUv3 and
 Tegra241 CMDQV
Date: Tue, 23 Jun 2026 11:40:03 +0100
Message-ID: <20260623104003.36590-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|MW4PR12MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: 16ad6906-385c-4dfa-7197-08ded113efd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|18002099003|3023799007|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 5Pb6aKHX8HviB+W+cnORLJRILW3hLKqelbGrZEWtK9lkDQrilrUx4qbKCf7iFojAY5Yy1T7daoXJ+STmiTPKYRuMgM6/75FaRKPMvpWf3eioFbi/+lOlhM8WD8awmCT9vzJOutjap+93O4VV1SzrwnpKSHBher9bgBWhN0QlTHWCY18ARfqfuTBUWWbltzI7UNhtjeSIOKajcmXMvX+aPlFh3alcCrpkRg9ShRrBTH450QOusHjY9k75vcE8M6qYi/I3aS7yE471kEKMnpwZu5jFhpfjqNHx4Fmi08nYyb276Ie7cXHkJbrOLKMFpOST8Jb2ygQCAr2amrv7FLq5XakJZqbikRzsdMEkqMD54/Bx8aHVmtf9h59IMGR4z4U1MIWwtbfIOsPKTB7Ty8H0lAuaEe48cyGeTve3wXtZCucjO5oXiU6F1w5b0mVIFLfdOhKKPX/jrVuiUF+7zdt8Ira+Fzm2tHLuODPa23ij3EvQDap+ubKfEsWCFoe4hfaHOuGLVTwxDE4jcTKoyBLfXa5xRMlVCJTb6YjxXMz1u2SyN2rIy7adv7MUV+AjbSRqFe8+dxqc7a+aeG1W3omqcPS8A2NPiOpl4GSxtaxGlilrxG/DqXOgZDq5YhW9L9MDqok6aLHGqztRrtRstZ8OpXOYiFUK49VCm3hJ6TiGVx2aB4cMEw07kVGUpyz9/YeI851uIjXAdavaMJQrkQTOJA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(18002099003)(3023799007)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nFrE9xsS2uuEQeM6in8Si6Qa57GY3nmuvxkFQM09PLn1nRS4lW1tCtSIpkQh3dYhRz0XV2o2Y/0osq/6j48KPe2rNL6263adhREIMJCQHCcVdwgH3+cPtkkCgvMLiCxdkPZsETTC6rTPOZN9oMCGqnPlT9SxPiK+R97LNdKMogrTFf4omkPMCToPCrj+CDYHwHCtDbv/4AZx/HUmSxKGb11j/GtoNeGsHhhN6FL3ePnVbo3ZAofj9ayIlQ2fls9e4TpHHYCJ9zvGT785MnMrn4Cp7WsIQU2yLI5MIIW0qMRxeYvj3fg+zZYGk1b3NM1lX1jup/Bf/9Wo7Yq0WhoRrnWLIodrgbyenED4fwRaVJOCWtuBne8c112zVaW79kXrYf+PvPsmEmx5qgnL1kHLVUj/eyuXJEf4AJRIFIO0h0evtkRMQXFimq36VcfUXHk1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 10:41:08.9590 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ad6906-385c-4dfa-7197-08ded113efd6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7261
Received-SPF: permerror client-ip=2a01:111:f403:c001::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001, WEIRD_QUOTING=0.001 autolearn=no autolearn_force=no
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

Add subsections for accel=on (nested Stage-1/Stage-2 translation) and
cmdqv (Tegra241 CMDQV hardware command queues) under "User-creatable
SMMUv3 devices".

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 docs/system/arm/virt.rst | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index f811e662d6..ae0be35d57 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -288,6 +288,32 @@ User-creatable SMMUv3 devices
       -device pxb-pcie,id=pcie.1,numa_node=1
       -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.1
 
+  *Accelerated SMMUv3 (nested translation)*
+
+  The ``accel=on`` option enables hardware-accelerated nested translation
+  for vfio-pci passthrough devices. In this mode the guest SMMU driver
+  programs its own Stage-1 page tables, with the host SMMUv3 handling both
+  Stage-1 (guest) and Stage-2 (host) translations in hardware. The host
+  SMMUv3 must support nested translation. This mode requires the iommufd
+  backend and is only supported when booting with ACPI (not device tree).
+
+  When ``accel=on``, QEMU automatically derives the values for the
+  ``ril``, ``ats``, ``oas``, ``ssidsize`` and ``cmdqv`` sub-options
+  from the host SMMUv3 capabilities unless they are set explicitly.
+
+  Example::
+
+      -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.0,accel=on
+
+  *Accelerated SMMUv3 command queues (Tegra241 CMDQV)*
+
+  The ``cmdqv`` sub-option enables NVIDIA Tegra241 Command Queue
+  Virtualization (CMDQV) on supported hosts. With CMDQV, each accelerated
+  ``arm-smmuv3`` device gets dedicated hardware command queues and the
+  guest issues SMMU invalidation commands directly to real hardware,
+  bypassing QEMU and improving throughput for workloads that issue many
+  invalidations. Without it, every invalidation command traps into QEMU.
+
 Linux guest kernel configuration
 """"""""""""""""""""""""""""""""
 
-- 
2.43.0


