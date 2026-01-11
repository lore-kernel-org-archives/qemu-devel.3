Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F148D2502E
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 20:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf1ah-0003bO-4z; Sun, 11 Jan 2026 14:59:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1a8-0002mY-Ef; Sun, 11 Jan 2026 14:58:37 -0500
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1a6-0004D1-MQ; Sun, 11 Jan 2026 14:58:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVpM5u0IKUuEdQkVHQmW8RxmQztG/luh+cA0/S3RgswucBnJJLBVJnP6wFj5UOQD4qdfampUVoip/kEQd6qQm4P39m4cGW+WZfEmGUusncPKVO4uL3wdzwEIzxezdBZxB3doJN0kPJSuUiGFmp7DCIDh2zGmCHCCozvDpGSJwCZRFtujpxhI7xpA9xLD9ZgM2Uhok7Lg/6e9qMjZ+nSXWNzFTWbnp1jBwnpTDC52h3rOXlgyU6qh8WUV5j2mdRlVbj/2K9nSvBmls9krCXpC9xBv88IPIFNs++pQ/SjMatux5nV+XOippF5XvpFYqijlUm00CaMLfVPUJQ5Cj+e/5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOoBgHMB/uGW+rtqkkeRlPDweujg/WAyjuEVUYBiLpA=;
 b=yBGH6LpBTR5sn6Gz/ZaYja0emiS60xtccFMdyXBXG7wYzL/d6+toJP74/E+I2w2qoWgD/rPP1hf0WpjcfIe+Zv2gyAGRJUdKNCZF9ZTyXuIbWcREqMI16ctZEFOxBwEZWd0oUZTRCp/IlR2imjj2F8czPTcCzTbnrpHxlrffFDk/bjOf7ehFDOsYVuf3vlgIcWbS6wVN8m2t010iAXkogquek4tk4FecKOFMbTwi4oNPnKlyKwF+HUi+Zzg3F9AndcTvWjZnmGhlsrp9ymixZv9BxyL+YrBHyb0dTZ3iIG/Q1iKZMdX+DzK1LLjCxVWf/kJxH90L+TSX+sg48Gl+Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOoBgHMB/uGW+rtqkkeRlPDweujg/WAyjuEVUYBiLpA=;
 b=AGwDPqM2tfzjHGA5HU2RVvQ1J4znpJXhh0cMZXBkn6oVtmYy7jwU8C0rLuoUyj8pQ7V4k1wGyEasuH/+z6E73mEGaDTrdUnL7cxYG9rNE2o04mLUjYP/VwgZKMORkUwK3eoSvl0xGmGIpqTd0xB62av6+xUeJOaxAm8+Qtjow+2C570wSPUvqnpf65n37Z4fA5yj8QCYbg2h4v1wOJrUdwb/ZSmAuseqh8uLGWThdvbk7iQ3KukDXqz4MS5qfuq1XHb3lmBWqv41T+JO7A4pGL5oSsDcn7QBCViZEz+np4Fl6oiH1iUpfYlp3jGqp7uI7XkqL76G4mjLZ7ND3uQy6A==
Received: from SA1P222CA0026.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::27)
 by SJ2PR12MB7798.namprd12.prod.outlook.com (2603:10b6:a03:4c0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 19:58:27 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:22c:cafe::98) by SA1P222CA0026.outlook.office365.com
 (2603:10b6:806:22c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Sun,
 11 Jan 2026 19:58:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 19:58:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:58:20 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:58:15 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>
Subject: [PATCH v7 29/36] hw/arm/smmuv3-accel: Add support for ATS
Date: Sun, 11 Jan 2026 19:53:15 +0000
Message-ID: <20260111195508.106943-30-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111195508.106943-1-skolothumtho@nvidia.com>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|SJ2PR12MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f3e2f35-9a5d-40e5-8a2d-08de514bc93b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXhVR1Urdis5WU44YTJKTzA3Y2lMN1ljbEtWQjJINjhHT0dFTTdoRjJQZUhD?=
 =?utf-8?B?Zy9sR3NHTkpidzlVR2lTUFg2b1l3THRFTGxCL1VWZ1IxOFB5RTNLMThydnpv?=
 =?utf-8?B?WEVnWDZsSXZNSXZtK0FsQWxydVQrT2crV1hxVlg4ME1mZVl5T2lVRkUvbUwx?=
 =?utf-8?B?U2RZUEwxL2JWVk1GQjdsQ2dzbGtheXR3L0IzZzBWaFlRMW5ZQVBDeXpMWTBX?=
 =?utf-8?B?ckY1dG90VmhEK3RibWpDUkpsd3Y2OWVaMlRGSE0rbHdNK3A0NkxTclVGQ3BM?=
 =?utf-8?B?eW42UmIrR3dEcTVQclJoQ1pkalQ5RTBKQnFHWFdxVGpXZlppZytSeXBaRU11?=
 =?utf-8?B?SGZaZkp3ZldCeVdYc1N3VlN2Z2Y4cmFMSVRPUG9pclBMQjR5c09pQWptazda?=
 =?utf-8?B?NVV3dDlISUhheWRSbHlyM1BCaUw5Mnc5QzQyLzkxcEJmbVdaM2ZueG9hL1pB?=
 =?utf-8?B?Vk8vNU80Yk01a2JJSnNlMmV3cXRsaHh4VlZMM3JmRGNyUWEwSFQ1Ym50YVVv?=
 =?utf-8?B?Y2dQT3kzT09OaCtISUVlWVFFWWdXSDIwNzluVldmUFZxbWM4Qk1OdTV0WFBx?=
 =?utf-8?B?QlRPeklEN1EyY2JuMVA4VVRITHE0OGErdU9BckZmQkRzbyt5R3E4c3l0dk14?=
 =?utf-8?B?L2k0SmxRY3JTc1pBNWNWQy9vLytGdHQyN1pTZGw0SzJ4ejVJYm5zQ3BHYWJ0?=
 =?utf-8?B?U0JGN0lQdUViWW9iSFlPU2UzNU5mekdFWXNtbTh5TlZmQUlYZFU1Q1QwYTRS?=
 =?utf-8?B?NUJBbnlJQTF5VGdzSkpMSDJyMUF2QkI5dm1rb0VlUmhDYWdRbFlCRUJ1cE9s?=
 =?utf-8?B?NEorOG1XTDNqNEdJUllGeFhrRUs1WG00QWNzM2xLa3Vqd216dXJOcXlldjdH?=
 =?utf-8?B?ZDRhamUxenI5b3dNbGM3aDVraXdTUHlMZHR0L2NoNU1IdGNCYzB1bWg5NStT?=
 =?utf-8?B?VENRdWIzMkQ5N01ZamNQM05rVHlQNXVENmNHZ3NCRy9INjByeHhXaFNZeDhx?=
 =?utf-8?B?VWJRbFh2U2djWWdoVGQwSmtqRDZ0RWFzeEFNai9TN1Z3dmZqK05kQk1SVGRt?=
 =?utf-8?B?RlBwSkZ3djlNT0t5RFAzMS9PczNsY3hETGhvSG4wamlrZHNkeUZhbUlYbm9x?=
 =?utf-8?B?czdmV1poNnRHYmE0TjloQ1JYRGMveDhSV0ptNFNxN2lWNUlESDZWOVN1UWQ0?=
 =?utf-8?B?elhxNzZ6cmxtNi9zV29qVU81YjFwMVJaWk9uSll1eDFPTHJWc0tMNVpGSmVr?=
 =?utf-8?B?UFdzN1Q2V09xUDFTRGxFMkFFcU5jS2hHczhQdy85RDVqcm9MelRQZ0RzdjBo?=
 =?utf-8?B?S0VRbzRQU2J1UWlkV29RVGk4UGVoVUR4M1Q5OCtKR1grT2FlZXVjSFFnemp5?=
 =?utf-8?B?QWlnK1daVVdvVnZQUExhV1hHdFpQRmsvbHh5d25UOFhYTnA2QW0vT2JXZWRD?=
 =?utf-8?B?M1A4TU1MZjBYaXd2WkdHR292djhqUkxXVks2WFpsTDRpVE1yMTFoUnpTenBI?=
 =?utf-8?B?cG1EVzVhNk8vSVRBb1ZFekY3Y3MrUW9VbHdIaTc1ZG85anpFQml1d0RLWnZI?=
 =?utf-8?B?TjRMNEo0Rmp4NzRuanY4Ry8reWdtd0ZpRzJKT05LRTBRVlpDRlRtbFhCSnJF?=
 =?utf-8?B?QWZIWEFQeHdNT1RXM3NqbVlnUXN0YndCT0RoVDZRZ1RYQUlSdC9ObHhkaTJV?=
 =?utf-8?B?MEdMK3dGaCtBSXVwNlU1cUJrajk4NEdqZXErVXdGcUs1amE0UnorY2g0U1l2?=
 =?utf-8?B?bXo5SkFVM1BadXkwd1VBVW9WVTl1Rzl2b2tUYVpVYjhMZm1TS05zdklxS2RZ?=
 =?utf-8?B?c3BIOTFoazRVTW5vV3k2TnpNcUhuZ0p1OFgyaFcweVg5cy9kVUxlQXIzVmRQ?=
 =?utf-8?B?MGxhcmtNVTFNeGU0K0VodTNiQ0VGVEVHbkNkTkpIZjN0NE9pR0dLZGNxc2hW?=
 =?utf-8?B?NTNtVTFXMTVJMHBVWDV2SEU5TXE2aW0xcUxkQ0pMMDdjMlk0UncxNnlzUjBN?=
 =?utf-8?B?cjNVUm56NWRNZDRDdnBrRDF6SjBxcm9wSS95dk1YVndMZVpMQTd2UmVDNmJ1?=
 =?utf-8?B?M0Yzd2V5VXJ6dzJUK3Jkc3oxaEYxNjZnUGlFSUQ5OXpGTmtlR1ljOERNY005?=
 =?utf-8?Q?Rfm0=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 19:58:27.2149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3e2f35-9a5d-40e5-8a2d-08de514bc93b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7798
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
index bb408de43a..60d8fda755 100644
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


