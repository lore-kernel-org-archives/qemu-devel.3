Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219DDCF65D5
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkK8I-0003kD-Bk; Mon, 26 Jan 2026 05:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK80-0002jZ-OO; Mon, 26 Jan 2026 05:47:28 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK7y-0005lA-PZ; Mon, 26 Jan 2026 05:47:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZcJA6lmqruN5avqX5aa9i8C6YWhJg12Yfu9LgFkOv3tHi5K3uotC1yLY0qf2Ct1M2JdPX2/IBpHoj/mJcVOiCXuFzkbLMyqQsubJnLyelMO4TXTfDzqhK3OLY5NJ8geNVSlR6mxBucTB4KyTp7M2BqYWLXOWRD/xwI6Pu9vzhRLezpb688BgIOYkarOr/EEjEnDon5gTU4THNcGCOzq9ESfLnyMmR1QCeROdcY1Vyjd/DJLb5vcwj1kz4Z+pZH4mdmZBeykDaSTTawUrRVpQdq7WjBJ8tBJlyVc1mfid6GMwF/d8FtBfhYZZJ02GIimfJd13hKP2C3vkXlHgO+TAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzKmiMzWkQ1gI/bYLaW1zL76IR5rD6/GhEp75br9aRM=;
 b=dXLOrAn1xo1MFJ7cA3f5AWAjGwQ8Y+gephOlIzkshFpaac8pYOhX7XyGGULJKZ9CNP28TkGWgq/swu7xSru9pGknNt7P1YfvuQImVMvmrGJTksjSkaLf+kxdO+QptGEFtJensiBJGnpYMWB4ntnYN3ygJ5d4STalIvC5KCXlxXuBm/Vly3XYP6izzLUz1Derg3D5gHug+jox7S17fomGi/lW3+GcDjhXarD53U7ArHqQFDG6sKcAHf/bsny+TKAnsi026sgLdi0dntIuJDFZJ8KemB59LO+lqrVw7J6mymkh2YbSZvQnnXjysinmYzBAp+Bj3bGTPshGGsTkgkV3NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzKmiMzWkQ1gI/bYLaW1zL76IR5rD6/GhEp75br9aRM=;
 b=Ncf5cnq/sAZ+9NM9iND6mpPkXV3HyhYlGHs1oAUKEcBNlkRDD+HeSuxDAsYO7Fmr4JQTO+yUEtgUalaScrPuiGDnqqM/3wozV7zEzwYXW0qMVMIBEetpVskBsZ7BmEYNWpq7W3/Rw34i11Hs/NVnJVzVyJqwod16KLTwJTfULFY748rY6QoufR9SorFMhLTNATmMFlryDg9ZOPt0TqFlxgGxYVOzK06MPNhHbYoRQFTLu2p3St8pFmiguInvTLMbJug46bKAnM2PWv4Swgou2wVw3YKs5V0CqyzMbTdmRlnMdWjVc+QwQRvH+txrROJWwuQAvlxF9HhtGCnQues6sQ==
Received: from SN7PR04CA0016.namprd04.prod.outlook.com (2603:10b6:806:f2::21)
 by DS0PR12MB7680.namprd12.prod.outlook.com (2603:10b6:8:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Mon, 26 Jan
 2026 10:47:20 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:806:f2:cafe::da) by SN7PR04CA0016.outlook.office365.com
 (2603:10b6:806:f2::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Mon,
 26 Jan 2026 10:47:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 10:47:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:47:00 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:46:55 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v9 30/37] hw/arm/smmuv3-accel: Add support for ATS
Date: Mon, 26 Jan 2026 10:43:27 +0000
Message-ID: <20260126104342.253965-31-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126104342.253965-1-skolothumtho@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|DS0PR12MB7680:EE_
X-MS-Office365-Filtering-Correlation-Id: 8180fa7c-eac6-49fe-d964-08de5cc847bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|7416014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0Z6aWhDWWRlckpHZXJiRHM5UUo0OEVZaExCVmZEOFZ1T1dydkVpbHZQOGdP?=
 =?utf-8?B?NE1Fd0tPTVBXN3BVc0I1UitEbldSUVREQndiYWc1MDJSUzltTWxlYWVPVFpL?=
 =?utf-8?B?M2VJK2tEYUJSNlM2ZmxqakxuTDJGbDBBcUhYWWJMamwvQ1BxN0d6K3lTSjlH?=
 =?utf-8?B?MkovN2hUZlhhYjBhUGhEOUhOMDJMdHNsMjJZRXRkaEY3MmVQcUFpR1hzUmtl?=
 =?utf-8?B?YmFZcyttdWd4MGZYU0l3QWdoNFNaT0xQMENwb2tzQk1JZFhBSGtLdmNRWDNl?=
 =?utf-8?B?RVQxeTdLNVJEZ0JwTElGSEwzR3hERlp4ajdabGE0dzJUb3JhVnp2UmJxT1Ax?=
 =?utf-8?B?c1J1VloraXFNb1NGQnZ0YUk1OXFQT3RzYmk1b1YxVXdsLzBTRG5qMVZLU05N?=
 =?utf-8?B?YlYzT1BZZEFLUEE0SCtjUFNtN2Y1U2dmY0d4cjZ4K0FKSXJLYTRncldFMEpn?=
 =?utf-8?B?ZXNlMGdVSmNEN0JiY003OUFHMllvYmVZb2xsb016TFdGNDVXcWtTbkV0eHhQ?=
 =?utf-8?B?N0VyWWp1bTM0NzdEWmxRc21UbmI4bUM0RzZPTEh4Q0JWOTlSKzdZVm85MGxS?=
 =?utf-8?B?cUQ0OFBZbjJVQmV2YUQxZ2g1Y3MrdzJGeUo1SEMrNkRseU9kVERLaUd0d2pC?=
 =?utf-8?B?MlJGb1NKaEF0WXN1SG0yR1o5b3hEckw5dmVvTDIxSlBCTVVUTEl4UjNSOHVX?=
 =?utf-8?B?dDNUREdpQnhEbThUejRJVnc0WGZKbnlGd0M0Q3VVb3NvWXVObDNtVkxBaWhm?=
 =?utf-8?B?clQ4eEVlQ2hGcFJSWWVBRFY4WENLTCt0TW16bjZkaXNFM2hhNDBpVGVieFBH?=
 =?utf-8?B?ajV4eUhwc1N6R3pRbUorWmhvNERBaWp2SDN1R1lPQkN3c2wxYkxKcmI0aTBv?=
 =?utf-8?B?c2xGYU5CdjJJNEZrUXlBeEk1Tnpzd1NZQW5BVHVQVUJxdGttMmUvcm82aEFv?=
 =?utf-8?B?ZkpFOEpTeGJmVVZxbXRGVGIrSjFlSkV6OThQS2dCOTg4TVRvNHFzM2xhd3JD?=
 =?utf-8?B?ZU9iM1VuVW41N2lKK2YvMFdBYXplczhVR3Z1a0dEN2ZzS2t1ZjhMZDBBbHcw?=
 =?utf-8?B?WDdxOWtwSkJsK013ZjA0MVRQRHQyZ1N4ZHlLbWFEKzgyaUg5cWxnbUxjdnRu?=
 =?utf-8?B?YVcyQVFBWCttYTNqK09ROUVDRmdIZWpIbG9SWTZhMmpYWEp5dG5kYk1KbEpR?=
 =?utf-8?B?TXMrcnVPUGtjZGVXb0x2Z1lsVGpVeUFwSGVGbUI0SEovLzVHcEtlWGN6a0Ns?=
 =?utf-8?B?QktwaWVTYkJkREgwS3R4TEc3dWkzNXhwQzMvR3VMYkhwdjRVMmZndi8wclgv?=
 =?utf-8?B?c2g3MzUzRm1rbFZGZHhYbFdLdkFNRlJmeUZ3MjNmbzFpbHJGa05hY0xONnBh?=
 =?utf-8?B?UXB4TWRiV1l6c1RFWG1ibFRVeVUvUVBQOVVsTXN6blZLYzNWQ1FtTHpNOGps?=
 =?utf-8?B?ak95NFB3MmxyR09YYzh5K041Vk1lMVg5dkQvT2NkNnlkRmVnN05IZGxwemdF?=
 =?utf-8?B?Q1JLdWFKU2FLZEQzK0VzQWVxOCtFZGRUeE5HVjZFMjlwd1VJcUo4M1dyQ0xI?=
 =?utf-8?B?UjJ3dUJUOHhta3BtVk9xS20vL2V5b2Y5Y0RzTkhvN291WG50bmc2aFFXS285?=
 =?utf-8?B?RDFuTElsTWV0RmNWWm05d1ZWSWNWRnVMa0NQbm9NeEcwSHhhMXZiQUlLd1BJ?=
 =?utf-8?B?Mm9MZE9sa2dnMThrZHNDZVBPOGx4dTViNmZxN0laR0ZLWVJwK29kdjNZUTk3?=
 =?utf-8?B?Ym41OUs0QXVCZTFKUGRrMEFYdGV1cTZjTjU3TFBLMzdXTGM2NXptbURaTk00?=
 =?utf-8?B?M09uOEowT2FDc09JM1FOUllNT2RDQkNnUFN4emVGMjV3V3lSaFJ3Nk1EQlE0?=
 =?utf-8?B?bjdBVE85a2VCNXdpYkNyNkQzQUJvazZpekEveGFOZ3dUR1NHZTZBVllSWjZs?=
 =?utf-8?B?ZmFPcG9xTGdUVnEvYUhUekp5MTNBdUVLNUovbnBCNFpmVis3Z2N4WElESGFU?=
 =?utf-8?B?QXFoRzhmSDVlRC95UTQxcEVhSVdCSjFrUVNoN1Z5Zlc0MjVsUkJhZlgvbTFR?=
 =?utf-8?B?MzJ2WmVsdmduNjFFd1lUR1NTRGFQaXNISWM0RG94aStEOHhFMXlDdGs2MWwx?=
 =?utf-8?B?UkdKSHlKYlJyS2VSTERzSVBvY291WlAyamQ3RDBqRmkyRUFwemNLQ1NpQmRO?=
 =?utf-8?B?cFdBTytOaUFWM3JEcENCTUt6czJkWHVoZTBnbjR2TDd2UGFOOXVhWHI3ZWFO?=
 =?utf-8?B?Vk9FWHNUTWpSYzZYaWo3SmFKWDF3PT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(7416014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:47:19.8337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8180fa7c-eac6-49fe-d964-08de5cc847bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7680
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.587, SPF_HELO_PASS=-0.001,
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

QEMU SMMUv3 does not enable ATS (Address Translation Services) by default.
When accelerated mode is enabled and the host SMMUv3 supports ATS, it can
be useful to report ATS capability to the guest so it can take advantage
of it if the device also supports ATS.

Note: ATS support cannot be reliably detected from the host SMMUv3 IDR
registers alone, as firmware ACPI IORT tables may override them. The
user must therefore ensure the support before enabling it.

The ATS support enabled here is only relevant for vfio-pci endpoints,
as SMMUv3 accelerated mode does not support emulated endpoint devices.
QEMU’s SMMUv3 implementation still lacks support for handling ATS
translation requests, which would be required for emulated endpoints.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c    |  3 +++
 hw/arm/smmuv3.c          | 24 +++++++++++++++++++++++-
 hw/arm/virt-acpi-build.c | 10 ++++++++--
 include/hw/arm/smmuv3.h  |  1 +
 4 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index df82f1e32a..a97abc1f79 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -654,6 +654,9 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
 
     /* By default QEMU SMMUv3 has RIL. Update IDR3 if user has disabled it */
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, s->ril);
+
+    /* QEMU SMMUv3 has no ATS. Advertise ATS if opt-in by property */
+    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, s->ats);
 }
 
 /* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index cb619f19df..ca086ba00a 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1498,13 +1498,27 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
              */
             smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2);
             break;
+        case SMMU_CMD_ATC_INV:
+        {
+            SMMUDevice *sdev = smmu_find_sdev(bs, CMD_SID(&cmd));
+
+            if (!sdev || !s->ats) {
+                trace_smmuv3_unhandled_cmd(type);
+                break;
+            }
+
+            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, sdev, errp)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
+            break;
+        }
         case SMMU_CMD_TLBI_EL3_ALL:
         case SMMU_CMD_TLBI_EL3_VA:
         case SMMU_CMD_TLBI_EL2_ALL:
         case SMMU_CMD_TLBI_EL2_ASID:
         case SMMU_CMD_TLBI_EL2_VA:
         case SMMU_CMD_TLBI_EL2_VAA:
-        case SMMU_CMD_ATC_INV:
         case SMMU_CMD_PRI_RESP:
         case SMMU_CMD_RESUME:
         case SMMU_CMD_STALL_TERM:
@@ -1931,6 +1945,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             error_setg(errp, "ril can only be disabled if accel=on");
             return false;
         }
+        if (s->ats) {
+            error_setg(errp, "ats can only be enabled if accel=on");
+            return false;
+        }
         return true;
     }
 
@@ -2066,6 +2084,7 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
     /* RIL can be turned off for accel cases */
     DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
+    DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2093,6 +2112,9 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "configured in nested mode for vfio-pci dev assignment");
     object_class_property_set_description(klass, "ril",
         "Disable range invalidation support (for accel=on)");
+    object_class_property_set_description(klass, "ats",
+        "Enable/disable ATS support (for accel=on). Please ensure host "
+        "platform has ATS support before enabling this");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 3126aca42c..c145678185 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -346,6 +346,7 @@ typedef struct AcpiIortSMMUv3Dev {
     /* Offset of the SMMUv3 IORT Node relative to the start of the IORT */
     size_t offset;
     bool accel;
+    bool ats;
 } AcpiIortSMMUv3Dev;
 
 /*
@@ -401,6 +402,7 @@ static int iort_smmuv3_devices(Object *obj, void *opaque)
 
     bus = PCI_BUS(object_property_get_link(obj, "primary-bus", &error_abort));
     sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
+    sdev.ats = object_property_get_bool(obj, "ats", &error_abort);
     pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
     sbdev = SYS_BUS_DEVICE(obj);
     sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
@@ -544,6 +546,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     int i, nb_nodes, rc_mapping_count;
     AcpiIortSMMUv3Dev *sdev;
     size_t node_size;
+    bool ats_needed = false;
     int num_smmus = 0;
     uint32_t id = 0;
     int rc_smmu_idmaps_len = 0;
@@ -579,6 +582,9 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         /* Calculate RMR nodes required. One per SMMUv3 with accelerated mode */
         for (i = 0; i < num_smmus; i++) {
             sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
+            if (sdev->ats) {
+                ats_needed = true;
+            }
             if (sdev->accel) {
                 nb_nodes++;
             }
@@ -678,8 +684,8 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     build_append_int_noprefix(table_data, 0, 2); /* Reserved */
     /* Table 15 Memory Access Flags */
     build_append_int_noprefix(table_data, 0x3 /* CCA = CPM = DACS = 1 */, 1);
-
-    build_append_int_noprefix(table_data, 0, 4); /* ATS Attribute */
+    /* ATS Attribute */
+    build_append_int_noprefix(table_data, ats_needed, 4);
     /* MCFG pci_segment */
     build_append_int_noprefix(table_data, 0, 4); /* PCI Segment number */
 
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 533a2182e8..242d6429ed 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -70,6 +70,7 @@ struct SMMUv3State {
     uint64_t msi_gpa;
     Error *migration_blocker;
     bool ril;
+    bool ats;
 };
 
 typedef enum {
-- 
2.43.0


