Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF86CF8859
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 13:32:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4fT-0001rO-NP; Thu, 20 Nov 2025 08:25:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4fO-0001SA-Ey; Thu, 20 Nov 2025 08:25:42 -0500
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4fM-0002eh-GI; Thu, 20 Nov 2025 08:25:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N4NQL5Ay5n1SDCjYdpYIm/enZyn1B2DuNPC2EcE6eGNODwr4r8bMs1hOdk7Di/SOEJ1HX7VVBGzIeP2pDgxn0zHHjpCGr4oxYwBwLoKqpkcklLxjVj1d7LtfZav2gPAo3cOXy/mvir3cFSW/dsAeSXkh4iFyHpPLZobgAgPuQgdhpxre6fRmJx6qXAwTaQiaH4iYK9G7OeqsMlbHARNFxDIclHio0DOEciFS0JxEbN+UmxhOZIxOLUjImeZCN315BNYfPC+ZHWUb9/1IEaUSEbK/+Bi9LNGCtoFl+aljLaT/UHeP3bKVi5efVKSnlWUxdlP8KCEEXX3klr42gprFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mW5rfFlOXNawYPK8EQNSB4EK3ZTO7p64D4bcZwv2Owg=;
 b=bm6lax7lL2aE8ut0bDDx7oYOeP2ZrElVCStxofyQb3fUJkDX48KUREm52QFtNq4AWk2fFHqiYdconnEkFUfqJ8a17kvfbtSF9Xawrmv10HEvlxj61YOL0kO5SPt/uEjZ3vdjn5kc+mKAbRk5Eu97lnQNcVIWn9P2A98AV0hxj7WzovIIJbHmtanz+mMLbHRb4hS2XMiYPCnN4DT/oEXZWRDyPHSo8kmOMzsuCj47xOvtSxxZtmMBJ1MY24CL05qMUeOAALuBjRU55y7PWczICVaVSOwHlnRK/d8FvD1fVymzAPIhThN2QG+33ooxNBXxHTFmrVHzpn0v8fOe0d5eTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mW5rfFlOXNawYPK8EQNSB4EK3ZTO7p64D4bcZwv2Owg=;
 b=qa6PKGRhezpNkHdI7yzoeGotoL6CN5815ul9IiPEpa4ye6GRZ+0t2NcE17Gesty3ylefPAn2Vn/lQCb4wo1PSftWlmRpKZARMATKyR9Cu47Dw5sfSeagjuqW9jS4RiQ3XrCasbqx6bGDD56su+jpqVEx+4tV8mUnfhwKXr9Luv6/wK0kcg4MJ4jf1ZSrK6E74lx2kSq0TN+PEb0ZUO+8WhJvcSU8TkZMdMyiPqIoZrjUt/jgiiuYrymoEfOQV9RxUP7jgxjZqzfL/JU/ERE4XIiAgRjCP5mk5mKfl6C43W8AeoB8C/WoPJV6XTSu+3SDRLGurvWnFpb42I+6/Jylrg==
Received: from CH0PR03CA0231.namprd03.prod.outlook.com (2603:10b6:610:e7::26)
 by DS2PR12MB9773.namprd12.prod.outlook.com (2603:10b6:8:2b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 13:25:35 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::4c) by CH0PR03CA0231.outlook.office365.com
 (2603:10b6:610:e7::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 13:25:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:25:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:25:19 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:25:15 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v6 28/33] hw/arm/smmuv3-accel: Add support for ATS
Date: Thu, 20 Nov 2025 13:22:08 +0000
Message-ID: <20251120132213.56581-29-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120132213.56581-1-skolothumtho@nvidia.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|DS2PR12MB9773:EE_
X-MS-Office365-Filtering-Correlation-Id: 15954a17-8a78-493e-79a8-08de283849be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|7416014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0VEdVBpZHo3S1grNFprRGJ5T2xuYUtqazhYNGcyRW1wY0FsTjROQmZmWTBD?=
 =?utf-8?B?UFhLVzRCd3FsVHF1cVBFdzU5cWJBT2NSWkJKc1RYQ0I0NXZPVGY5SElabzI1?=
 =?utf-8?B?WWtJY21JSWxERmJHUFdGa2tJR1RDRG5vaFY4OGxkbm9EQVZxTkRNVWdBdy9l?=
 =?utf-8?B?b2hNSFkvZXR0VENwTGh0ZzhmTkduWWRpaTFDeWJTWVlldTlPK2tkcndzcml1?=
 =?utf-8?B?RFhoUURWcnU2L1ZuQ2ZobEFVUUx6eEVXNnVNbW5YUld4YjB6NGxXQ0ZGWDls?=
 =?utf-8?B?Vkp4QWZGNTlJVldNL2dtSTE1cGQvamJMZGFYR1lab2ZxbzNlUjFwRGs2R01l?=
 =?utf-8?B?U2lwSkczRTQwVVpiTU9kWkxHK1dFZFBDTWE3SHZRWnJQUG9Sd0NKcUxTcWg0?=
 =?utf-8?B?b2xQdERibHUrbGl6U1pjemNFWm91QzJ3V0hScFhDQ0xYYkFieUdrd0dvMitz?=
 =?utf-8?B?VjRBbVVhcEplRWxRckRFajNnVE5VSFpwekVPeDgvUDVHK2FPSmZwQmw5eGVC?=
 =?utf-8?B?MnZnQUFjcVhXUC9nWGRKenIxS3RHUEgrK0g3T0pVT21wWW1idXNxYWt6MXc5?=
 =?utf-8?B?M0pNbTVTMEN2YzVMYnFEWDZsc1A0SEFqazh6dnM0ZHJaU2ZZM0Y4TVRCems5?=
 =?utf-8?B?cVlhWXI1NUV5TUFmbVVXSVg1MG85enl5VzNIRWh3Lytld1VpNmEyeC9oYzB2?=
 =?utf-8?B?dTYrbjBvaDdKVElmSVZyQXFFbEEzdDFKUEtwNHhnQ09QVTVDaENWT21EZmlj?=
 =?utf-8?B?NDh6WWpBQkVnb0ZlOXB5d2FxYWZRSXBpU2FDUWsveGxQNFBNNXgzaVIweU13?=
 =?utf-8?B?cHhoM2RGQTJ4NEFaZldNTWVITHl6NEMycHY1dnJ1M3RYZTBudUNEdldtQmRV?=
 =?utf-8?B?M0hvMFVNVUJBSTVVTWNHWFhLWFNqbUpIaW9McXZIb2ZzQ3N4R0FhNjlhUWll?=
 =?utf-8?B?MDNGS083LzB1QVVmK0dCSDlTekFmMDB4emRPVkNsMnJLRXR5YklMT29ma2hY?=
 =?utf-8?B?ZnV3UnR2WU05QWxSRG41OTNseUZxc1FIcVM3VjV1VXlyemFub0JFQUVUY3BX?=
 =?utf-8?B?czBlcDF2RE9NUXl3NnB5aDlhZThXWHRIc1IweDliYnBHeHAzUFpjK3UwdmFr?=
 =?utf-8?B?ejdkVFFKSmtCNk9FdmlES3FUWHlJVHA5S1NUbVQzWmJUUnZrZzB3bnREeFNH?=
 =?utf-8?B?OGQvVjNzZWtycnpJRG41SHJDZTd6L3laZUdGQkxQU1BkMmF3NW4xVXNnN3Nm?=
 =?utf-8?B?dVdWajBMT01Zd242UURsRWpjT2JvYnpDTFU4bldUN1FHK3k5YjhJSzJjY0Ns?=
 =?utf-8?B?dkFJSW5ta0swVXNWWUoraksvTHU1NThnQmdoU3VacWZBcmpwS1NVa2xDZHJD?=
 =?utf-8?B?cytZMi9mNWhOUXVPVDNoa21kVVRzUXRyVEFnZFF5SmlLY2F1aUZqMUhWZnlU?=
 =?utf-8?B?aFFMNklEZFRYNjVRL2FwTzhvZnQzZExlYTZJR0dZWDRzVURmSkx2SDVzcm9I?=
 =?utf-8?B?Q3hsLzJwWU9nWmJDOXhjNXBFR3ovbFBGOFBLRDFUeWJpaXlCWjZKR0crMWxQ?=
 =?utf-8?B?ZDhIZStETXRDdlhjbXV4SjYrQ3RENkFIYWtPZ05xUCtBb1RMQit4TExQcy9D?=
 =?utf-8?B?K2pxT0UxVUU3ck9zOW9YQjJwdUpiRGpjVE5JalZleDkya3NHRG16U3gzN3JF?=
 =?utf-8?B?cVBoUUkrZ1dGMGhCeEhoTThWSHA1a3BvOXJLT1pFZ3pHVTNIVFJmMWJvQm1o?=
 =?utf-8?B?cTZIMzJMbHVUbzVlb3RZV0FrT29hMXdYRDFpY1hpWUlFQnhScElJNWE3a3Fy?=
 =?utf-8?B?NVhQMGFuQ2ZTOWVhY2dMY1RSbWpqNWU2MDJCUzdYRUZnUG5EVFhBU1ZLQ1Nq?=
 =?utf-8?B?eXpueDF1STEvTUZudG5VeU01WTZwOElNaVdiaFBaaGMwQ2pwQ3VsdnY5RmJW?=
 =?utf-8?B?MTZPSGFtQkNaWGZSUXdNZC9KdXJ5YXpjczRtQ3d3b3lZckdjbkZMbVpxODhu?=
 =?utf-8?B?SEdOZnY0dDNwc1RaTG43bEhpdU5LcE1nNmUwd2lYam9wUGtxanF2Q09iWFMx?=
 =?utf-8?B?S2xyV2R1THpLdWl6OHRGejc5d21rMnU1N1k4cERqOW1Kb2RVS2VUalZ4L1dP?=
 =?utf-8?Q?AcI4=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:25:35.2201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15954a17-8a78-493e-79a8-08de283849be
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9773
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c    |  3 +++
 hw/arm/smmuv3.c          | 21 ++++++++++++++++++++-
 hw/arm/virt-acpi-build.c | 10 ++++++++--
 include/hw/arm/smmuv3.h  |  1 +
 4 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index b6429c8b42..73c7ce586a 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -647,6 +647,9 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
 
     /* By default QEMU SMMUv3 has RIL. Update IDR3 if user has disabled it */
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, s->ril);
+
+    /* QEMU SMMUv3 has no ATS. Advertise ATS if opt-on by property */
+    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, s->ats);
 }
 
 /* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 296afbe503..ad476146f6 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1498,13 +1498,24 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
              */
             smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2);
             break;
+        case SMMU_CMD_ATC_INV:
+            SMMUDevice *sdev = smmu_find_sdev(bs, CMD_SID(&cmd));
+
+            if (!sdev) {
+                break;
+            }
+
+            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, sdev, errp)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
+            break;
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
@@ -1930,6 +1941,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             error_setg(errp, "ril can only be disabled if accel=on");
             return false;
         }
+        if (s->ats) {
+            error_setg(errp, "ats can only be enabled if accel=on");
+            return false;
+        }
         return true;
     }
     return true;
@@ -2057,6 +2072,7 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
     /* RIL can be turned off for accel cases */
     DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
+    DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2084,6 +2100,9 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "configured in nested mode for vfio-pci dev assignment");
     object_class_property_set_description(klass, "ril",
         "Disable range invalidation support (for accel=on)");
+    object_class_property_set_description(klass, "ats",
+        "Enable/disable ATS support (for accel=on). Please ensure host "
+        "platform has ATS support before enabling this");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index fd78c39317..1e3779991e 100644
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


