Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE42C44506
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 18:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicUH-0001YF-OF; Wed, 21 Jan 2026 12:59:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicTA-0007lf-99; Wed, 21 Jan 2026 12:58:17 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicT8-0002B4-Et; Wed, 21 Jan 2026 12:58:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxi6B0TsZryY8n0PMKLxXVpPjz3eDfxPlmMHS4zKxiyRWJ9+jX3yI1T3gBgaTzmGVNWxRyks3Q8V7g/k3XmmESUwnFo1u2hRaICpAa0DqQaHVVxTPMNzlngRayWQL+sP35D//fXF3V9ZrwLl8MWQCcalzq0RExWqIQQ4k9UZ9CoaxgUvVmJcCmlS8qSJvcM38bLVgkoIOqFTz01kiUZOIEMiHD7HrS+bZu2Qi/wS2LrYRB0kSHJ/FWBloVDrZts0WzS5daX+p8dly7auc0yGsrk8pFVR4dTu+oLLGRIlRqzAufHZS14E8nFVnhLlf5uB/R+U1Wnxf8hLbsVErNi2Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uPcZkFyjMGGf7vAUbb8+OFi6nscyuBpIBfMgZdFkRg=;
 b=cg1TltRs3EOYXBVOac40JBhmlA0cfn9jCan6JVu7a7EGtUhVLprgk2QCPPOGvRdgR7AeAXLqDB0pC0V/+7jOscDxwwWrY/QMSCZAx4MyZ26MtBtET+p5VC1+XPtcNmnB9qioFg+YtAdoU7oL5WJevSJqA1fB+Tg6NFP/ZFkxq/UDczMycWl5TDoDi8/6HjGXCU/WvYPCYGwUIZYjAC/iD4EZ8J72MCc8/8yQA/xlerXQ+hFyiS6F7JX4lsBTl32eQc9f4Jk+dipu1fvmDrsX6uZ4peVvZYeAJ0jpRAdqFJio75GphtDOi2mOO42Dsy0UgtkAkY86Hr2bUSVbEOV+qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uPcZkFyjMGGf7vAUbb8+OFi6nscyuBpIBfMgZdFkRg=;
 b=GHc2JSssgJoSZHJ4rEwkq6gh0SkP/a/vk8pdL2Nq5u0SjGNMBCuc/WmuKAS8+ExJSiuNaljJNNLdwzbWMi6Azk6bq03aNmSuy5DyN2cK5JBOqaKBePsiqpD4362MLkfcndw/mPXwrP9wwfxAk0TX3yyqtYCUmAoq2rjfQYCoX35z5eVVKCqarc7vo6T0YJoBHt3sAP/t0OTD4aIITFN1J4i3P+wGpin2HlvDFeZImT/92PpDMgvdYqBa1z5GX+zlvb77vS52YFRF1t/8V3WvKeD9R3dyLkOkSse9E/10bWKYXSppLDUcpwTCL3TW+PvHSJX39KWW8D6qYko7G3Q4/w==
Received: from CH2PR14CA0012.namprd14.prod.outlook.com (2603:10b6:610:60::22)
 by DS0PR12MB6463.namprd12.prod.outlook.com (2603:10b6:8:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 17:58:06 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::be) by CH2PR14CA0012.outlook.office365.com
 (2603:10b6:610:60::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 17:58:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 17:58:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:57:43 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:57:38 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 30/37] hw/arm/smmuv3-accel: Add support for ATS
Date: Wed, 21 Jan 2026 17:52:35 +0000
Message-ID: <20260121175248.87649-31-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260121175248.87649-1-skolothumtho@nvidia.com>
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|DS0PR12MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: 62dd4699-3a13-45f8-64e5-08de5916a159
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlB1dEhNMnBZdWJiNm0ydVBoM2lRb0dJZkYwZENSeklyZURrZjhHdWtLQ01a?=
 =?utf-8?B?dkZVVU1FKzNERWVUdE95RUhGZkpKcWhaRmE0U1pJczJ3NERlSGVFcHRqRzkr?=
 =?utf-8?B?WGpTQno3cGxIQ2VucURBazB1cFJYbGI3QktWS1ZnZUgvUkl6dys5OStXdWZo?=
 =?utf-8?B?K2lCWDRnTHE2YkFoeCtUK29YZGZpejIyNWtUdThZcXYwNnJzWmlUdzZtbnRm?=
 =?utf-8?B?VlljQkxQU0NPZU5Eb3FjRC8zZVJPcXluZkJOZGt0ZFFzK3BzYXgwaHg2RUFw?=
 =?utf-8?B?TDVPd1BzNDYybmZKYTBqbXNsQTE4di95TkFhNngwb0FtekhTMEpLQ0xoL0p3?=
 =?utf-8?B?WGh4TzlQZkNkQ0Zxb2RLdVBHUGhMT1psSGwvYk9iaHRWb0lCb2pORSt1QU5m?=
 =?utf-8?B?Sjl2TzZod2t3TDIwOU5UVU8ya0ozQ050ZzBVbFVzRWswWHJNZ2VGcWkwaFNS?=
 =?utf-8?B?TmM3OE5nakYzcU8zTGduZHJRK0Q3eWtRMXdadjNHbHVxcFJqVGZxczZFZUl5?=
 =?utf-8?B?S1J2ek9YMUpSaUpwRlFjeG8xUlVpNFdNRDlCU3lteUtDN0c0MEpwNWJkVVpp?=
 =?utf-8?B?b25XT05nbEFhMTBZSXVFczBYZXJqM1M3d0VXNFBSYkVEY1plSkYxZmYxb0VG?=
 =?utf-8?B?R3JDZmVDdEh6d1NLR0RCYjVnRGpOYjJDMGJaWDFjM0N4L3RQYlZTN0g1Smk1?=
 =?utf-8?B?ZXJ6ditBSk9YbW5kVVVmT2c3MzIyanF6bEtxVmZBR1kxSE9maUZGU241bDBF?=
 =?utf-8?B?Mk1TMnlPWEhuSi9lbUVyd3lGOU9DVnNGREJQcHJqK0lFelFFNHZkSGF1L0lm?=
 =?utf-8?B?UVo4Z3AwRGlPdDFsNW9Dd3Z0Wms3RFRscGpKL3J4UWJjd2NGYmU1Nms3c3lt?=
 =?utf-8?B?aWd6NW52RjBkLzNlTDhHYjdBWC9OWDdOUXRNRHJPNkE1Q2prZ2RWOC92RG83?=
 =?utf-8?B?dUYya3B5d2FoSk9mbVhndzY3N25hQjQ3QldvN29xd0hHeFE3Wm5TWGdPZG5m?=
 =?utf-8?B?ZFNYK2ZVSExkVlU3MWFtTlBOZ1RPZEp1UCtzZkV1TjI5QmF6UEV1akt6VldL?=
 =?utf-8?B?MFN3eEh0eDZ0cHoxUlNTVUpZMmwxamF2SFhSNmtpQ2hnd0ZXOG83RzJTc2Y2?=
 =?utf-8?B?ZEdPZU1mdm1uN3FwNGtyamx4T1hIOElZNTZHNWNSdVplN2RzdGthY3V1NUh1?=
 =?utf-8?B?OWtEZjhXWjJIQUxMUEY1eUhLaGlGT1JHekNuRUJOUXhja3R5UUFLMm9UQUNa?=
 =?utf-8?B?WE5wV0x3U0MybDltdXZEbFJUZ01KRzZ3aXp2TktDeHQrZ0JuZ1pSWFFqeW9j?=
 =?utf-8?B?S0xVSnNTQW9DdFFESlB0Q0s4aE1GUUZxQlAzWEw1eFhna2Voc0xlWlRRNnZJ?=
 =?utf-8?B?SmhjL2VDamdBL2dVSTIwT3hydCsvWEVoYmFlaUpPcjdVTzNua1M4NDVMTVpO?=
 =?utf-8?B?K1ZPVEdBTGpENVZ5TXB3aGZvNjZhajRKM1pObE5XMzhUYkJ1SUg5YVhjTHpL?=
 =?utf-8?B?ckw0OEpJUGlyVnQ3Q2c1N05NeUtLdm9VcmFRekkzVUFhbkx5S2dPY1AxZmhO?=
 =?utf-8?B?dzJnWTAzVnZqRDRzMUhZcGM5bGtlU3NPTU41YUdQVXhnU2psYTJwaTFuaURj?=
 =?utf-8?B?RzdOdFVIY1pyU2VodWErd1JXS2R4a2Y4N0J1ZG1tYUxVNmRlQ3NRVnYyK3Y2?=
 =?utf-8?B?YUYzUUZoL015L01hNnhjZTh4R2Nrbk1JS2V5TmplclRMUWRmMFA3WUwwRWs2?=
 =?utf-8?B?T1N3ZlltNkRDTEd6T1JEZFQ4Z0pTVHVOTTFEeFRIdDd2clc1aU4xWWUva1RK?=
 =?utf-8?B?R0tXR1c3SFN0RXlORDJDYW5VdWNqMlI1UXhaYWx5ZU9kY0lGVG5jU1U2a2tE?=
 =?utf-8?B?NlA3QUk5alVkMzh6SnU2dzlKeVN0eWFUY0YwOUdnKzU2VUJqZGx6WEFJNnJ2?=
 =?utf-8?B?MFA5RkNtZ3VYOEo5WTh1d2pSNnVMNkhNdk5VdmIwQzdlUHdoeHM4OUJmYWhB?=
 =?utf-8?B?UzNSZEplSUx1TWFoUzhHazlYUldVUi93NDBxbThzUm8vMExNTXNLZGRKUytp?=
 =?utf-8?B?Mk1LYzBUak9tdDZ3V21Yd3I4VUc3UkNFVnI4Ny9xNG9tak5ZZEtDMzRONGZU?=
 =?utf-8?B?N0Q4bHdkWUVyKzIxUTZSeWF2U21qSml1RWk4eG1zWG9vbDBVOXhleGRBdDli?=
 =?utf-8?B?UGpnczdIQ0lvVW5NbEIxOGptTnJITU5lbWRSazl0eXVpUzNYOHhGS0pIa3hT?=
 =?utf-8?B?bkRFV1hkQlM0NzFwL3JMTzFIZFhnPT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:58:06.2971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62dd4699-3a13-45f8-64e5-08de5916a159
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6463
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
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


