Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1E4CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmmz-0007Kz-UX; Fri, 31 Oct 2025 06:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmlw-0004dm-0v; Fri, 31 Oct 2025 06:54:27 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmlq-0002zV-IN; Fri, 31 Oct 2025 06:54:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CrdEQAOrWsB8Bg53fsNGV2beg6DDMHjyvyGasMxlFNO4e+SiLY9CWzFGvdhcP2luYWDvIT5xcV2FhjpRwrgQ43ul5uIdsZ5TefdAnFRK+B/Ztz0Y31hFLPvi9cb6gCOSavIJbzoS/XYL91YLjOov3bJUDV8tbMxJvggTHWuGxlIcH2yUpRVk5/udx+h3/VfnjhDRW+8DK52emBhJ35gOl+nsoE/Umaouqj13cdYCTEqGhzJffG8otTo0eqYUBvN6LEXxSvXf8U/md9fXW7TxXsAqq3oagNmS6Mjk3+LjjWmvGKy7WTIKc78WVlSqwFviZlgiO9I47p81Ujl8EtJXvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zaJPUeRUDJXOTWHES77yxEK6wd+zsMjye2o/PJBq/1o=;
 b=dZtM5Y6zDQ8MBsN6gvXe/saH1oaHcWHN3NGfaA0N2bNQj9QETcK4Z8Nl2L6oZblzq+33vZUG66y8JsMfKmTiSZ8TiBzubPKkurz8r4BuwqVpYbNhjr9ZGZEj39FBB01HNUMMCNggdQVHruIirJm0kuE1pu+veES2bbVA8IQmbe4hcyC8AwK0Nq0cIaPSnXhRv9uNi8a7tXzRwSNnizdoisa6b0qjJ6qdYBKoG5MZjCB7cMnXURdgzThxFerbXQgL1xV/BaD+/JQrPZVmcN80+2AQEc+k1geA6B0aKqkgE37TRnrFPBys6i9oEqMKCVHyfzKg5M+XYY15CPmNgkGGVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaJPUeRUDJXOTWHES77yxEK6wd+zsMjye2o/PJBq/1o=;
 b=oFxszCTwhT0sbG4TW3S3o5+jp4wceTrRF5XFY7Et9sI/HNZzG67DJoe14u07jlJyL7WVCWodWerU6uw05IluR7k6NqYIxD677l2NB8JDfoqqM16wDYg7N4eiglEWukQGozdNieY4Eoz1Bf4J2Y6W+5JVoHmBkdz7+YA1kp+9vXAFw5mw9yP/Lb9eaEisbcwLpNGU509bF7sb7mP3XRxCsG2wWqOWe96KKCvF6N/14GMzouJGRLqW9yQPExsYUhL8TA3LsQPRf5xuKc5UfKclSlMYO61zOcWfbj3dqAIPYQ0GRNSaiFEYMRVVu43qiq2iiWFTHD0o+QSOdmZAhXQqnA==
Received: from MN2PR02CA0033.namprd02.prod.outlook.com (2603:10b6:208:fc::46)
 by CH3PR12MB9024.namprd12.prod.outlook.com (2603:10b6:610:176::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 10:54:04 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:fc:cafe::63) by MN2PR02CA0033.outlook.office365.com
 (2603:10b6:208:fc::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Fri,
 31 Oct 2025 10:54:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:54:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 31 Oct
 2025 03:53:53 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:53:49 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v5 17/32] hw/arm/smmuv3-accel: Add support to issue
 invalidation cmd to host
Date: Fri, 31 Oct 2025 10:49:50 +0000
Message-ID: <20251031105005.24618-18-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031105005.24618-1-skolothumtho@nvidia.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|CH3PR12MB9024:EE_
X-MS-Office365-Filtering-Correlation-Id: dac1f42e-ab1c-4f54-13fd-08de186bceb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHorZHBjN0hYbnUzNW5CYlVTSXZsS2xPVkRXbldxYThqRTUyRDQ3T3lkMUxx?=
 =?utf-8?B?b2lNK2lkNFFhRkNPK3BHcnZjYUtSSDdtdW1yOWc5TVZESzAwQWVTaytrVW5T?=
 =?utf-8?B?NWdycUpzYnlESE5leWNUdG16TkpGRlhad2Q3UG1xRjZtYURQZTZQc1Bpd3pn?=
 =?utf-8?B?UU9TMDhzT1R0RWo2THZ3WS83QzZqVGVBS3hXTjhvOHc1ZkNtR20vTGZJd1dU?=
 =?utf-8?B?UVJCT3RVb0JNMTFUMWNHZUpqakpIYlpGZWpnbElBd1lTTXpvLzkyek1BYWlM?=
 =?utf-8?B?b3k0TnpOWmhPeEp5azhyOUxjRlRYMWJqaVQ2V3NmK3N4SHczb1hoN0MyTEdZ?=
 =?utf-8?B?Y2QrY05EOHpJWkgwUTBwS3ZFck1ta3JtNTVtbHh2NjRSNWlBODhocUdmOFp5?=
 =?utf-8?B?OTVpZ1Z4alV4ZDlXc1BWODQ4N0ZGNTAyOXU2NWp4MGVBU2QvQ3VjSmxxNDBv?=
 =?utf-8?B?RUZaL2xKbmNWYTAzdzZJWHcrMTdacVVDQjZ0TjMvdW5XT1hzT3F5V21oTkhn?=
 =?utf-8?B?NERvMFVwSnp1QlU1NlNBTjlDSytyRytyalA3elFXSDV1YXRLQWllZVVmcjhR?=
 =?utf-8?B?ait4aDIwTTBkRCtjdG53UHVlQmZQdzBZTFFyMDhPUkIzbTdLMDFXTCtDTjV2?=
 =?utf-8?B?bmNwSVgwTVhlRll4dXFsNG5rUW11WHBtL04yRnA0UG1Rb0ZxMlZZcnZSV05I?=
 =?utf-8?B?RGJMYWtkWGtMbE4wcFBxZ3Z2alU2YWRNNWt5eVlJeUxtc0ZhUTgwcXhGTU1o?=
 =?utf-8?B?WlprNWZtWUNRZENaY2dNTERHaDFDdkUrZFNHcUxHUjdJQkpYelNrWlRDZzFM?=
 =?utf-8?B?Z0U1S2M5K0grMk5adlhzUFVSdmtVaDJyUHJTR0tWRkd5M0F3Zm5IamhjRGZU?=
 =?utf-8?B?UGkweW96V3BNSDBoRlFMMjlMTkhYdFFCd20zaHpBaWExdXhYSlMwQmZBd3JY?=
 =?utf-8?B?cFJtZWN5d2U4dHRuN3lpTHh4bXJMNzZ0b1h2NUVNVDRSbnZVdk1aZ2xqbnVr?=
 =?utf-8?B?N3RnT2ZBdTVSQ1hBR2JvQVo0Rkt4bEVwQnBGZTNLYW4zbk5SaENxNTBCalh5?=
 =?utf-8?B?Mk5aRnluendWYjVESnhIcGtta3hVb1cwMW5TSnQ4ZC8waUk5VmVFWXI2VnY3?=
 =?utf-8?B?MUN5MlUrcU0yY0F1VC9ZYWxsbWl0YU1nL2pIS2lWN0U5UUlxdzNJTzNDTjYy?=
 =?utf-8?B?WktnaGQzSVpsTlh3ZlhiU0dKT3oxNlhlWDQrMlEzVHBpRnFRNi96dVljaU1k?=
 =?utf-8?B?RDgzaWo2TmtERVRVU2xYL1JZMXNnNWh5V3NPZ1RGOUFrNUJBU0tKT3RBQVJM?=
 =?utf-8?B?V1Q1a0Nlbm9vbVBxZzlCSHhLb3Y2OVAwZnRlMzhCVzlJb1ZkeU9Oa2NPb2dB?=
 =?utf-8?B?eFVCblVubFh1MldtWTE4K3NJNFRXY2c1K3VQdVJhUmFHc2ZuYzMrMFZEaGVQ?=
 =?utf-8?B?WFc2QzVPQVg0aURMRG5DUWIrL1lJUGxUQ0RjbnVSV1MrMmdRYjRreWt5dThp?=
 =?utf-8?B?SXVld2N5M3dBdlpTS2Q5RmQwenlDUGQvK2syVmZtZzBBdFpUVVJ2QnZUNXd0?=
 =?utf-8?B?emNrRUMraytXNFBzeFp2K0ZLci9xRS9XVUVQY0FPZGRSQ0tQemowandQa1Ny?=
 =?utf-8?B?V0J2cEQydFZtVlhIUjk1ek8rN2o5c09kNnRadVExYkJIOXNnVEN5Zy9takZl?=
 =?utf-8?B?VGRzb1pTMDBPQ1grRWZQazZnQzRhZTg1WW5Qdmo1bTh6d0ZGVUF6dHJyaGtP?=
 =?utf-8?B?clBVbEt4ZHJXdHBTaEpLeWtxTnNSQUlncHN5TFY4M2haYmJQUlB6dlBudHdV?=
 =?utf-8?B?bG1kN3EwQmxkUDc0Y3h0ZE9UM2Z4d1g3VGpGUitEcGdVQXFjbXpqalllcXpv?=
 =?utf-8?B?S0c1TWVyQm5sSDZ0bHl1cEIxSVhPMjZaNXZGZEZDMy9lV0s1YUJQVUVUMkhX?=
 =?utf-8?B?NzU1cHJCSENQL05lRCtPbHRlV2hubzAzblNuajJDNjM0NXlFdFk2WlJBMFpN?=
 =?utf-8?B?eTBKdHp1Q1k1aDMwSzEzc0RTU1F2QTVsbWIxM2tLZXlNUmUrMStvcFdIYUdF?=
 =?utf-8?B?L3FpSFJiQUt4VGlIUHBrSDE1ZWtYY2Y2V2Y3QWZ2TWR1VTJVcU5wZmpCOU0r?=
 =?utf-8?Q?PgkU=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:54:04.0221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dac1f42e-ab1c-4f54-13fd-08de186bceb8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9024
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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

Provide a helper and use that to issue the invalidation cmd to host SMMUv3.
We only issue one cmd at a time for now.

Support for batching of commands will be added later after analysing the
impact.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 35 +++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h |  8 ++++++++
 hw/arm/smmuv3.c       | 30 ++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 395c8175da..a2deda3c32 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -213,6 +213,41 @@ bool smmuv3_accel_install_nested_ste_range(SMMUv3State *s, SMMUSIDRange *range,
     return true;
 }
 
+/*
+ * This issues the invalidation cmd to the host SMMUv3.
+ * Note: sdev can be NULL for certain invalidation commands
+ * e.g., SMMU_CMD_TLBI_NH_ASID, SMMU_CMD_TLBI_NH_VA etc.
+ */
+bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
+                                Error **errp)
+{
+    SMMUv3State *s = ARM_SMMUV3(bs);
+    SMMUv3AccelState *s_accel = s->s_accel;
+    IOMMUFDViommu *viommu;
+    uint32_t entry_num = 1;
+
+    /* No vIOMMU means no VFIO/IOMMUFD devices, nothing to invalidate. */
+    if (!s_accel || !s_accel->vsmmu) {
+        return true;
+    }
+
+    /*
+     * Called for emulated bridges or root ports, but SID-based
+     * invalidations (e.g. CFGI_CD) apply only to vfio-pci endpoints
+     * with a valid vIOMMU vdev.
+     */
+    if (sdev && !container_of(sdev, SMMUv3AccelDevice, sdev)->vdev) {
+        return true;
+    }
+
+    viommu = &s_accel->vsmmu->viommu;
+    /* Single command (entry_num = 1); no need to check returned entry_num */
+    return iommufd_backend_invalidate_cache(
+                   viommu->iommufd, viommu->viommu_id,
+                   IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3,
+                   sizeof(Cmd), &entry_num, cmd, errp);
+}
+
 static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
                                                PCIBus *bus, int devfn)
 {
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 8931e83dc5..ee79548370 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -51,6 +51,8 @@ bool smmuv3_accel_install_nested_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
                                      Error **errp);
 bool smmuv3_accel_install_nested_ste_range(SMMUv3State *s, SMMUSIDRange *range,
                                            Error **errp);
+bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
+                                Error **errp);
 void smmuv3_accel_gbpa_update(SMMUv3State *s);
 void smmuv3_accel_reset(SMMUv3State *s);
 #else
@@ -69,6 +71,12 @@ smmuv3_accel_install_nested_ste_range(SMMUv3State *s, SMMUSIDRange *range,
 {
     return true;
 }
+static inline bool
+smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
+                           Error **errp)
+{
+    return true;
+}
 static inline void smmuv3_accel_gbpa_update(SMMUv3State *s)
 {
 }
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index cc32b618ed..15173ddc9c 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1381,6 +1381,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
         {
             uint32_t sid = CMD_SID(&cmd);
             SMMUDevice *sdev = smmu_find_sdev(bs, sid);
+            Error *local_err = NULL;
 
             if (CMD_SSEC(&cmd)) {
                 cmd_error = SMMU_CERROR_ILL;
@@ -1393,11 +1394,17 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
 
             trace_smmuv3_cmdq_cfgi_cd(sid);
             smmuv3_flush_config(sdev);
+            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, sdev, &local_err)) {
+                error_report_err(local_err);
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
             break;
         }
         case SMMU_CMD_TLBI_NH_ASID:
         {
             int asid = CMD_ASID(&cmd);
+            Error *local_err = NULL;
             int vmid = -1;
 
             if (!STAGE1_SUPPORTED(s)) {
@@ -1416,6 +1423,11 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
             trace_smmuv3_cmdq_tlbi_nh_asid(asid);
             smmu_inv_notifiers_all(&s->smmu_state);
             smmu_iotlb_inv_asid_vmid(bs, asid, vmid);
+            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, &local_err)) {
+                error_report_err(local_err);
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
             break;
         }
         case SMMU_CMD_TLBI_NH_ALL:
@@ -1440,18 +1452,36 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
             QEMU_FALLTHROUGH;
         }
         case SMMU_CMD_TLBI_NSNH_ALL:
+        {
+            Error *local_err = NULL;
+
             trace_smmuv3_cmdq_tlbi_nsnh();
             smmu_inv_notifiers_all(&s->smmu_state);
             smmu_iotlb_inv_all(bs);
+            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, &local_err)) {
+                error_report_err(local_err);
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
             break;
+        }
         case SMMU_CMD_TLBI_NH_VAA:
         case SMMU_CMD_TLBI_NH_VA:
+        {
+            Error *local_err = NULL;
+
             if (!STAGE1_SUPPORTED(s)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
             smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1);
+            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, &local_err)) {
+                error_report_err(local_err);
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
             break;
+        }
         case SMMU_CMD_TLBI_S12_VMALL:
         {
             int vmid = CMD_VMID(&cmd);
-- 
2.43.0


