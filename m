Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4046CF65DB
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkK7s-0001kJ-Tw; Mon, 26 Jan 2026 05:47:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK6x-0007ry-SA; Mon, 26 Jan 2026 05:46:28 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK6t-0005c6-1d; Mon, 26 Jan 2026 05:46:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NvswgsSywV/vXfnxjGtJXEKOBLrnpE2+Vc3zacuqXIqVSMh5hAaO0pvW7aky9C4oL5xnj+XJD2dvX75JH6OREEeOsgs3mRlIX20kUlr4rFoiDeZWwb7H2Rt1q2FEso867fNUoFELwLmoZcyQqYKtC5FsHGFLbWV5iJP8q/Odajxqhao2U+lU/hLtIEeoqJJExdOO0sPEfRwnLsV1V2LYk3yxslQUNp0mN4AYSYtqB0g+dwWo0IXysSdZkbB6nf2bnlMLpLCTnMnmiiTPh+jmS6fYjkHzck2KU24iskFWcAseFGHndGXvDnXmLuxNOgpnQ/DDwJWe4DWuxqap0KAVnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDr7W8lcVBuyUlNJYOZar7ZEpfqiPid5kYrSkpuLZoI=;
 b=yhbMwpDNs8u+AH3gDMUMqd+IXUS21bf5zQ4Lu84D8M6YsUjserm/2n52IC6awSiICAt2UYNi6iz5TkCTbQxpbQH4GtiNcJvoa5HVsaEKdRbBNjyrd+aJjOimb+34as6QrDzxXFUMBRnceP5Q5x6BjvIhd+CFx8VD1QKTE27Xo/WOlgoNEpyaoz7qrNfigX4RjCgfE1GlTHUym7Ou2X5jgywnoTD/1Xs/becvwYDULiX89AliSIu5TzhrbQA+ypM9h92gvoACISY+nrq7qwd+vgFN+Nk8+oztdRacbR0f3jPGolUHxm38B/YVEjec9LRZ7WXJYKB8Z3hEtzn0ozcOHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDr7W8lcVBuyUlNJYOZar7ZEpfqiPid5kYrSkpuLZoI=;
 b=qZEk0JMa7igSqEZ53kAfveOzV5BILfUIJMgxtsZ8k1ZM6I33KweGl6dQA0zU1CWKapDE7D3+vLTWY5tbHN55HdaGzFUB49cT5x8iQMxSfyn96ftg9POtKuDrCFViS73VWhkXRRrcAXiEB+ARvK9ldkDh8pG4SWplDWR9K9Dnq2YlWyiY9kjyX7mQGDFe1YUassASN09fUAsgNXthFsl+jSMUOE37yEYTGNQW+ErORcdofQca8IWGdh7m12KFdLEsfItw4JtGVT2Hr9OXyhc8Y8JaTDjDvJ3hkrBHi4V52tHb0aO/gWPKbetH6korrtgR8817hAM8uaUamLcgZUkEDA==
Received: from BL1PR13CA0008.namprd13.prod.outlook.com (2603:10b6:208:256::13)
 by CH3PR12MB8482.namprd12.prod.outlook.com (2603:10b6:610:15b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 10:46:14 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::65) by BL1PR13CA0008.outlook.office365.com
 (2603:10b6:208:256::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.6 via Frontend Transport; Mon,
 26 Jan 2026 10:46:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 10:46:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:46:03 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:45:59 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v9 19/37] hw/arm/smmuv3-accel: Add support to issue
 invalidation cmd to host
Date: Mon, 26 Jan 2026 10:43:16 +0000
Message-ID: <20260126104342.253965-20-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|CH3PR12MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: fe6dff2d-f867-4682-e820-08de5cc82075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bnoxQnR0TWl1M3B6cTRJdGJHOGtnMHFmWEsvWVIvMGJvcE5EaGEzc3d1RmRN?=
 =?utf-8?B?cjhlZGtlK3ZjQmRRcW1OTldhbXdrMUJyVlU3OHhncTByTVBDV1N0ZzNaeVh5?=
 =?utf-8?B?OTM2c3dLc056UVdNNDk5NTBLbXQzcnB5Rkh6TEhPYmt6OERtZEVYVGFMS2hG?=
 =?utf-8?B?QUt4cXdnV0RxSlZkSVpUeDBlbzhKd1RZdkh2d0dqVEtPUDVxZjVMRTJHMTVm?=
 =?utf-8?B?dk8xNHJtNUN1aWpyOWFDR2dZalkvaGFyVEZucXJuelg4SzFqUXZBNm8wdnpL?=
 =?utf-8?B?N3pkQmJSL2phaEFzWUgyalJQTVR6MzlWWi9UdU9HTGdBdmQ3VjhQM1hTZ3hV?=
 =?utf-8?B?N21zbmQ3Q3JXRDUzWlRNb1ZnQnFXYnE3U0lIYUZ0N1BsRXVBVytURTU5SjRl?=
 =?utf-8?B?c2I2UnVKUHQ1QjJEMUg0Y3Rab3V4ZklPQlJNSlhRUGdsd2tLQmJnWlYyTmpY?=
 =?utf-8?B?U3ZKY3FEYTJlcjl4S0xrbnU1RkxqRHdHQWw4cnBQWi9MdlpjeSswOGRVam9n?=
 =?utf-8?B?TVZRTiszKzdoSTRZeXNxd3g3N3FKaTg3Z3QxbXluaU5uclRXell3OGRKN3B2?=
 =?utf-8?B?S24zQWQyYmlTdXVFaWF2Q0FQQkxWc1VkaUtld3BNWUFsRHdzOXZidWcyVWQ2?=
 =?utf-8?B?SnpBeFcwZXI1WHhxTmU0UzFHOXdGTitCeCtuUGVTUFV5Q1VJTm0vMkpHamxt?=
 =?utf-8?B?TjN4UnFzdEJwb0VuSHdhbFB6TVpIYnJ3citWeVFISy9rYXI3Nm9lRTlxTXpM?=
 =?utf-8?B?ZWJlQUJSZDFUQ2hocjh0akNwbnh1ZGMvenFHbXYrMGFyaDJxQ2w4L3pnZVBC?=
 =?utf-8?B?NS9tdWF3YU0vQzBiUHZHWnBCZXowamZxSlV1U3MvVnQ1dkU4TjcxYnBHVXpI?=
 =?utf-8?B?S3NYWVV2OWs5WGpqMVFoNDlyOHY5dlFoVlA1cWx1Z1FiZ1VMK1N1TmdnZy9k?=
 =?utf-8?B?cU9rRzVDSlgzUEVaSHRvL2h2MTk3MlQ4M0NPOXRIdFR0OVRnT3d6S2xnNFla?=
 =?utf-8?B?M1hmZndLQzVncUtpNCtUL0l5eTBpRDB5cWQycEk5VWVlUUUxMHFwaUJ4MExu?=
 =?utf-8?B?Tlhzd3h2NmNScXVqa3F5dXdqcEVSZzY0ZjQ4TkNqbVZnKzVqY0U0Z0FkTi9x?=
 =?utf-8?B?bTZ2ejZUTUh1eWRZUEswbWhJUlM0eGRlUm1OTmw5NVhjTlB2Q1FVUWx3RHJy?=
 =?utf-8?B?QklCem5SMkNxK1lvdGFMZDEwenF4Z29RWUhSRzdyOWE2SCtPVUtpNnFQS0lW?=
 =?utf-8?B?bWVkckVHa293VFNxY0g3WUpGaUVHZnA0K1BiMzdZN016SlhJYjV4Q1pMTHRJ?=
 =?utf-8?B?SzkwSXFVOGVacGduRmRDd0ZKS0doWFcrL3k3bE9aR3haS2JJZk5mMVFWczM4?=
 =?utf-8?B?TGtvY1c0UzZLZHptb3JmcmV4RlpFaExOU2d3Rzg3bEVyckIvdnBXNG1vek55?=
 =?utf-8?B?UzdsMnM1ck0ybDYrdFIvK3h0Nmd1TnNKR2xLV0lONkgrVWlrYzJTRk95Szdq?=
 =?utf-8?B?WVdWNlZDQWJ5aVNGa1FpYjNYeS9zdkZ4RVhhQ25XbzNvY3c0ZmgvWWxVOVBi?=
 =?utf-8?B?YVVDcmNpVkNnRVhVWHRvQVNudkZUTlVhVW5aT1d3b3o1QUprOW9uZWd3Y1Ix?=
 =?utf-8?B?cm9sakRWY1EwdWlSUTFHQlVsdjVTWFZDUXBudFA4UjZqeFF3cVJKMzdQdlNn?=
 =?utf-8?B?bDVkSXZjQW5HOVFpVktOKzRnOVA4VlNiYkJsU2JIRHRiMWdXNFlNdnNFaCtX?=
 =?utf-8?B?RmZBVWYxSXdkTkdjWEJaZFI2Z1pOMFpabHBIenJoYUEzbG05aFRkcXZVT0Ev?=
 =?utf-8?B?VWVJVkkwMGV4b1RIUkF1Zm9ZaURTcjRFY1dsNmdLNVZ3OGQ1aStkWVdRUi9R?=
 =?utf-8?B?R1hpNkJ5RzdnNGZ0RzRmRmtFMGtsTzlKYkplVTNGK2tyRUd5S2hEOGVEV3dY?=
 =?utf-8?B?N3JWQnpZWEt3MHpYUkdQcVZLMFI3S2h6UWVrSmU1bUdpVloyMEwxa3ZodTd0?=
 =?utf-8?B?YUhQNHZQQzljQU8xZENBbXJSNzFwUkZOQ1c3UHZBRm5COU9vSTl4N3lrdFdq?=
 =?utf-8?B?MldVdTZSMm5VUmtkQm5vbjJhQ3ZCd2lyakEyU1g2azlSL1RIZEpGbFZaRHFz?=
 =?utf-8?B?UzF1MzF4S09LS0JBYjZQMlFRZkhubWFmalZlNkJPSTd4UmFiYTFvNkFZYThW?=
 =?utf-8?B?UG5Hb3BoM2FQY0dTK0tQU3NtekJZa2R6bUxrNWtZRHJtakQxamMrY0UyZDNv?=
 =?utf-8?B?ZWN3U1c4MVJFem1JaXJXS2RCTUZnPT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:46:13.9201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6dff2d-f867-4682-e820-08de5cc82075
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8482
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.587, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Provide a helper and use that to issue the invalidation cmd to host SMMUv3.
We only issue one cmd at a time for now.

Support for batching of commands will be added later after analysing the
impact.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 36 ++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h |  8 ++++++++
 hw/arm/smmuv3.c       | 16 ++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index c6ee123cdf..89dc6f991c 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -233,6 +233,42 @@ bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
     return all_ok;
 }
 
+/*
+ * This issues the invalidation cmd to the host SMMUv3.
+ *
+ * sdev is non-NULL for SID based invalidations (e.g. CFGI_CD), and NULL for
+ * non SID invalidations such as SMMU_CMD_TLBI_NH_ASID and SMMU_CMD_TLBI_NH_VA.
+ */
+bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
+                                Error **errp)
+{
+    SMMUv3State *s = ARM_SMMUV3(bs);
+    SMMUv3AccelState *accel = s->s_accel;
+    uint32_t entry_num = 1;
+
+    /*
+     * No accel or viommu means no VFIO/IOMMUFD devices, nothing to
+     * invalidate.
+     */
+    if (!accel || !accel->viommu) {
+        return true;
+    }
+
+    /*
+     * SID based invalidations (e.g. CFGI_CD) apply only to vfio-pci endpoints
+     * with a valid vIOMMU vdev.
+     */
+    if (sdev && !container_of(sdev, SMMUv3AccelDevice, sdev)->vdev) {
+        return true;
+    }
+
+    /* Single command (entry_num = 1); no need to check returned entry_num */
+    return iommufd_backend_invalidate_cache(
+                   accel->viommu->iommufd, accel->viommu->viommu_id,
+                   IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3,
+                   sizeof(Cmd), &entry_num, cmd, errp);
+}
+
 static bool
 smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                           Error **errp)
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index c7ed4dce3a..41b37e3122 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -47,6 +47,8 @@ bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
 bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
                                     Error **errp);
 bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp);
+bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
+                                Error **errp);
 void smmuv3_accel_reset(SMMUv3State *s);
 #else
 static inline void smmuv3_accel_init(SMMUv3State *s)
@@ -68,6 +70,12 @@ static inline bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
 {
     return true;
 }
+static inline bool
+smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
+                           Error **errp)
+{
+    return true;
+}
 static inline void smmuv3_accel_reset(SMMUv3State *s)
 {
 }
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 6ed9914b1e..4efef73373 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1388,6 +1388,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
 
             trace_smmuv3_cmdq_cfgi_cd(sid);
             smmuv3_flush_config(sdev);
+            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, sdev, errp)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
             break;
         }
         case SMMU_CMD_TLBI_NH_ASID:
@@ -1411,6 +1415,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
             trace_smmuv3_cmdq_tlbi_nh_asid(asid);
             smmu_inv_notifiers_all(&s->smmu_state);
             smmu_iotlb_inv_asid_vmid(bs, asid, vmid);
+            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
             break;
         }
         case SMMU_CMD_TLBI_NH_ALL:
@@ -1438,6 +1446,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
             trace_smmuv3_cmdq_tlbi_nsnh();
             smmu_inv_notifiers_all(&s->smmu_state);
             smmu_iotlb_inv_all(bs);
+            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
             break;
         case SMMU_CMD_TLBI_NH_VAA:
         case SMMU_CMD_TLBI_NH_VA:
@@ -1446,6 +1458,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
                 break;
             }
             smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1);
+            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
             break;
         case SMMU_CMD_TLBI_S12_VMALL:
         {
-- 
2.43.0


