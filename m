Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997C0C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 18:03:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicSe-0006Um-Dw; Wed, 21 Jan 2026 12:57:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicSM-0005h3-IG; Wed, 21 Jan 2026 12:57:26 -0500
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicSJ-00022A-O9; Wed, 21 Jan 2026 12:57:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y65Xt041vez2KHs6OJHPngNgtBTyCJKglcgDNjBbR1fo7I7w6KXQa4Klfzi+9OHxgYNA8xAGdW3Fh505wiKS7glh9r/wwb8N7gd4Z6UWvNuf5B59h+hIS6b5hA/p2/8cV018yI3oVcygGGCpsIYIVC3Wot2EzvEUS1Em0ZseyJcR/ZsoKpnu5tomJAcR8fezeB4OeZHI1vTA9L+jrMtd/0yMSSNswF+3UJp6Kh3nZpw/V0q7O/5f9iF2jzK0yZw/JUn0mm/xcLGf83oTWknsnNrRKT6+74LDGxDX5rWJUkXo2QJd5wLneF54XtMn3ssTjEiwZofFZsiK69DL/exjQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nr17xfYvG8GllODuWFtLwMWj4+SdmkHQWfMv/dYea7U=;
 b=MluQo9Hdb2xKp3g0okteSC/NmxceAbIji8iySLw4th20NaSSbwny8TIwx+1/fzxCPkZ7FO5AjjJ1rGIUeMzOE7tZli6iJRhzbyzeWWMWAHk8n9skSpDnFC79D9jMJh0LLlRGLtthYh93BVn0rulPgiByxl+K0INyZM3hOFj8KiOYJqHhbMDCJ8IAy8errHDhcay8awKnbHTdNd1XrNRDp8qK66zi6A9HdVAMW7+jXdNWekKWLsz7N90kk68Ocf2K92NICYifSPAw0XkRtEXKYjNyA1GEGvZ/PQrENyJBdB8/Gy5jeeWFYNWPmond2LW2rocqF9U0uwCJbYvTc6DhOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nr17xfYvG8GllODuWFtLwMWj4+SdmkHQWfMv/dYea7U=;
 b=oW1nqSy4dJ7i3dja9QrWiYG6UKmi+Igd2tTmRZ4zY4g+YCHreCeKXzq5zLYDqPCDziCAAgq3el3oA65GMIrhKQUAOD9bIvsZEfRXOfmTwgbpR5XVKTfia07Y5Mzds5X2ShWN0ixo9kR+x9OAIQH3Ma31aHmRf35bxTfyw0aBOWrVioWcV7Tgr3feO38gjAHsN8ZjgB2xUMJ1EQuY1zwMw6PZRju2hQ0APli6FFWHkzuog5cSoXrK9DWXE36giImPixd50yy7Suufks6JgaI0eHrh0xmMRi1/GzVm1lFARjP96P02QXOnSlV47IFUWcyzlr4QZmr755rh1xq1aJwSTw==
Received: from BN1PR13CA0004.namprd13.prod.outlook.com (2603:10b6:408:e2::9)
 by DM3PR12MB9326.namprd12.prod.outlook.com (2603:10b6:0:3d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 17:57:14 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::fe) by BN1PR13CA0004.outlook.office365.com
 (2603:10b6:408:e2::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 17:57:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 17:57:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:56:51 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:56:46 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 21/37] hw/arm/smmuv3-accel: Get host SMMUv3 hw info and
 validate
Date: Wed, 21 Jan 2026 17:52:26 +0000
Message-ID: <20260121175248.87649-22-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|DM3PR12MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: f4ca24a3-abbb-4fa6-6638-08de5916827f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+VJPagLyIyu4us60RtgYosmps334I+5Pqx75NgyNHLaDug+4ZywFn2CQPm+d?=
 =?us-ascii?Q?N1ClfIOHSI6qTegw3bN+aT9e4ix8+kD4mSQ19os7OA9U9zfno8Q0SVyGK/Oj?=
 =?us-ascii?Q?qHYeAUlneGKpenXwES882K97IDVFyvU4BfVsHd61EfNXpXAAKi9TkuJgJ6Bn?=
 =?us-ascii?Q?GYo/wIWWIkgOEs5EsSbJOjJ2effOLWIvDB1KqCjfn7oLqNsloGyYtGeC6sv2?=
 =?us-ascii?Q?J78dAPaMdgBngRb40cj0g13TqUeu0nisq5mPAHzzMr/xXCL7MB6djpMu5CxY?=
 =?us-ascii?Q?0rU8LK3/aGh56Vvpb+9OnLjDvAWnmwKQuFoLqHVbXnysJDcACe4iXShM2Y9z?=
 =?us-ascii?Q?oPOsvAcOv3Y2vk7Yngta4s79hfr7vXuSw9QEScz1AdZFcsHeplxQaZi3VaHt?=
 =?us-ascii?Q?VJJ+watJlPZ3A5CtQrDCSaBafnb6n6RM+f+7idNQWAHHYHQa070GCqlSCkrg?=
 =?us-ascii?Q?pb3BLljFD0RFzp18FQoa2JWQlI30/ShXBnbQqG+atTTp77WzxyzRayzjpBGP?=
 =?us-ascii?Q?ngSxUX0cQEh7HXjYciNyL7vbBoHZYeDdEflgI/6IVhCul/0Cn0e7mUu+lPj7?=
 =?us-ascii?Q?22/sjLg9cPJ8VwbPsi/SZdJ+7ZgZMyQC8O6PD0yA1xdwpIcgFzoIAaIFfw8W?=
 =?us-ascii?Q?L+3DbzkUEIfAj5p1I8QenfnkwKEQLWRqMfIZvw8yyjDE6khHRN6nU33YLIuL?=
 =?us-ascii?Q?tkYG4SEJ484W5wEgRdBt21GLFeUl8OEuBC8bo1MKXmGR/yPf5W1rZd/NvV/9?=
 =?us-ascii?Q?r23ruKQZUgFFZ1ak3n8rv+Zr4Gqzr4/WgKTm6FTH1JOcyV42rlR5WnpBo0Ux?=
 =?us-ascii?Q?cjrWpvhF9iARx7xE6qWE8UoV9xXGWfgAYwq4Qmk+YcmUuKeKGMaMv64AWVc+?=
 =?us-ascii?Q?aThU05J2S+eCfGkjbrizultGRtUMT/JqqFj/mxN4hsUvoC78oIr9WREMq6PQ?=
 =?us-ascii?Q?4SYVvyGs4t4hJTxLV/ADHq42XUxzLjRjs3yqcjs87bGzzAjdbnBRp39tmhTH?=
 =?us-ascii?Q?6Hq6VTVg5sRTu5yPh3fDZ7P5AglkS1Oi3h0Kg5iiN6MkNdgtKfuoWVbAMsHG?=
 =?us-ascii?Q?Fn7GgvVTlQWwWaz2XCNtqVa7+KQz7/7HSySbKkdaVLkqM8btXBKsKGMknRxO?=
 =?us-ascii?Q?smEu+at5g+QPb/jqegZ44c2RhPCBOdQxnA9sGXwGNRLfupZNw1RfizQj/k4Q?=
 =?us-ascii?Q?felyG7UqZgUIYI3ZnVJQ2TrqI7b7BEfX/jIWUilWKppEvyaDDlad33awRAFg?=
 =?us-ascii?Q?BAVDALQODRsawP/JbDQrsZuI0GqAfcobRYbjXVNd3MDKYRTRfiSm/cvyG5MR?=
 =?us-ascii?Q?l89i1O3Mul90n1HHkpAX6E8qVQW45Y80Al7vI9HB1i1yj/uBTy6d5tZCs7fO?=
 =?us-ascii?Q?erkRuMitGYOzshYIn+gVFAwNpiEA5T/uQ+6VPMNLoNhEU+QSwUVpCfAst6Pe?=
 =?us-ascii?Q?phD+PgDUdJes7aj9zanURexoSxUh+al0h5p0qj1A5ySCAyQD6q1woKCFlFuj?=
 =?us-ascii?Q?Pig1HEiAKWLEunKQWvnEEPQ1dYVoXZOs29u/Ow8bmCmb0MSrZrmOiDNIM4mT?=
 =?us-ascii?Q?2DuYJrt2p0pa/pzRsmScE63L9HIttoIhqyT2fq4Mg0wqxv9kPe+CkwcsNPgc?=
 =?us-ascii?Q?YZTuIPruzg3fGc11h2ZmywZZEIRtjBUP12X1Js4ahqNn/rodWQDZ3us6majH?=
 =?us-ascii?Q?kFmdsA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:57:14.4907 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ca24a3-abbb-4fa6-6638-08de5916827f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9326
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

Just before the device gets attached to the SMMUv3, make sure QEMU SMMUv3
features are compatible with the host SMMUv3.

Not all fields in the host SMMUv3 IDR registers are meaningful for userspace.
Only the following fields can be used:

  - IDR0: ST_LEVEL, TERM_MODEL, STALL_MODEL, TTENDIAN, CD2L, ASID16, TTF
  - IDR1: SIDSIZE, SSIDSIZE
  - IDR3: BBML, RIL
  - IDR5: VAX, GRAN64K, GRAN16K, GRAN4K

For now, the check is to make sure the features are in sync to enable
basic accelerated SMMUv3 support. AIDR is not checked, as hardware
implementations often provide a mix of architecture features regardless
of the revision reported in AIDR.

Note that SSIDSIZE check will be added later when support for PASID is
introduced.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 101 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 89dc6f991c..33011962e3 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -27,6 +27,99 @@
 static MemoryRegion root, sysmem;
 static AddressSpace *shared_as_sysmem;
 
+static bool
+smmuv3_accel_check_hw_compatible(SMMUv3State *s,
+                                 struct iommu_hw_info_arm_smmuv3 *info,
+                                 Error **errp)
+{
+    /* QEMU SMMUv3 supports both linear and 2-level stream tables */
+    if (FIELD_EX32(info->idr[0], IDR0, STLEVEL) !=
+                FIELD_EX32(s->idr[0], IDR0, STLEVEL)) {
+        error_setg(errp, "Host SMMUv3 Stream Table format mismatch "
+                   "(host STLEVEL=%u, QEMU STLEVEL=%u)",
+                   FIELD_EX32(info->idr[0], IDR0, STLEVEL),
+                   FIELD_EX32(s->idr[0], IDR0, STLEVEL));
+        return false;
+    }
+
+    /* QEMU SMMUv3 supports only little-endian translation table walks */
+    if (FIELD_EX32(info->idr[0], IDR0, TTENDIAN) >
+                FIELD_EX32(s->idr[0], IDR0, TTENDIAN)) {
+        error_setg(errp, "Host SMMUv3 doesn't support Little-endian "
+                   "translation table");
+        return false;
+    }
+
+    /* QEMU SMMUv3 supports only AArch64 translation table format */
+    if (FIELD_EX32(info->idr[0], IDR0, TTF) <
+                FIELD_EX32(s->idr[0], IDR0, TTF)) {
+        error_setg(errp, "Host SMMUv3 doesn't support AArch64 translation "
+                   "table format");
+        return false;
+    }
+
+    /* QEMU SMMUv3 supports SIDSIZE 16 */
+    if (FIELD_EX32(info->idr[1], IDR1, SIDSIZE) <
+                FIELD_EX32(s->idr[1], IDR1, SIDSIZE)) {
+        error_setg(errp, "Host SMMUv3 SIDSIZE not compatible "
+                   "(host=%u, QEMU=%u)",
+                   FIELD_EX32(info->idr[1], IDR1, SIDSIZE),
+                   FIELD_EX32(s->idr[1], IDR1, SIDSIZE));
+        return false;
+    }
+
+    /* QEMU SMMUv3 supports Range Invalidation by default */
+    if (FIELD_EX32(info->idr[3], IDR3, RIL) !=
+                FIELD_EX32(s->idr[3], IDR3, RIL)) {
+        error_setg(errp, "Host SMMUv3 doesn't support Range Invalidation");
+        return false;
+    }
+
+    /* QEMU SMMUv3 supports GRAN4K/GRAN16K/GRAN64K translation granules */
+    if (FIELD_EX32(info->idr[5], IDR5, GRAN4K) !=
+                FIELD_EX32(s->idr[5], IDR5, GRAN4K)) {
+        error_setg(errp, "Host SMMUv3 doesn't support 4K translation granule");
+        return false;
+    }
+    if (FIELD_EX32(info->idr[5], IDR5, GRAN16K) !=
+                FIELD_EX32(s->idr[5], IDR5, GRAN16K)) {
+        error_setg(errp, "Host SMMUv3 doesn't support 16K translation granule");
+        return false;
+    }
+    if (FIELD_EX32(info->idr[5], IDR5, GRAN64K) !=
+                FIELD_EX32(s->idr[5], IDR5, GRAN64K)) {
+        error_setg(errp, "Host SMMUv3 doesn't support 64K translation granule");
+        return false;
+    }
+
+    return true;
+}
+
+static bool
+smmuv3_accel_hw_compatible(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
+                           Error **errp)
+{
+    struct iommu_hw_info_arm_smmuv3 info;
+    uint32_t data_type;
+    uint64_t caps;
+
+    if (!iommufd_backend_get_device_info(idev->iommufd, idev->devid, &data_type,
+                                         &info, sizeof(info), &caps, errp)) {
+        return false;
+    }
+
+    if (data_type != IOMMU_HW_INFO_TYPE_ARM_SMMUV3) {
+        error_setg(errp, "Wrong data type (%d) for Host SMMUv3 device info",
+                     data_type);
+        return false;
+    }
+
+    if (!smmuv3_accel_check_hw_compatible(s, &info, errp)) {
+        return false;
+    }
+    return true;
+}
+
 static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
                                                PCIBus *bus, int devfn)
 {
@@ -353,6 +446,14 @@ static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
         return true;
     }
 
+    /*
+     * Check the host SMMUv3 associated with the dev is compatible with the
+     * QEMU SMMUv3 accel.
+     */
+    if (!smmuv3_accel_hw_compatible(s, idev, errp)) {
+        return false;
+    }
+
     if (s->s_accel->viommu) {
         goto done;
     }
-- 
2.43.0


