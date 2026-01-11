Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE33D2502D
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 20:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf1ah-0003cI-Jj; Sun, 11 Jan 2026 14:59:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1aH-0002rK-Ab; Sun, 11 Jan 2026 14:58:46 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1aE-0004DL-Pi; Sun, 11 Jan 2026 14:58:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNityoJz8gtET2ET78FXNf+6NDL4xIpIxD2BxCr8EJT5Ht3gK642goVEkFCd0qBgWh0zsmD1oR25CXbhR9SwOCvP4woii73wgLvR3aSJ79utppIOF11dn+vYv3LzY0XAZbKEVcnFDO7FBHzFLs97UM7LEw/BOuPsiyAuUfvW+nn0fVQX0EbV/SNvlW9t/CJDD2E36yK0/0QqKrmoQmZ62TkcUQFKK6erA8jWy31nFwJPwKeAzQsSBY9KIzLXCnrwY91Mnpgg6TCYErqzd7tguXZ19NokXn73vNfo6mSG5mY3i/i2PI32FbZcdGLvCjZR4xABhqZhN4JRvbQBLRCU6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIzFpKbOojJ6crMQmoJ9CK3oEJst93DL3LwPTcEwSqA=;
 b=exBwcCx0P6Xmu/IRJO8fj0CQuD0YLqiSdHKpnrMkYvrTV1BiDYVHyqI3FCeCyBauWCTquhk6Nkiv6wbi6HPPrdeyXbW3phwfOtG7Y/tx36KOMH/LDJsvpeZkAmqleBeOG2YBfFAnjeMfHMjGITvyQvZbrBcmg4Cr1q3DKabs+UNpDgJjgrkbgsu05IFBbcc+YQsCF/TGQtvFa7fNyrq7DTBLdvvstwfl6UeogbG4iHzO0r5sM4+tQ4aeM2o642he6Rw625ZUjKzhhfIQo5VGNvAvyS7pfceJfvE8QNsBJ7N4ItQ6Bx9w7eNUznydLBm3YFYXQS1okxIhZq3bFvdNJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIzFpKbOojJ6crMQmoJ9CK3oEJst93DL3LwPTcEwSqA=;
 b=JyJZ8jt1niuJPBmqy8oWdYZE22Z9j4QmQfEgb1+mhOlsGf8tRfDVLbd0jcMBSlxoiIOm+fuwNN3RlJ1p/XgEeiPHAMLsBwCz9U9OXrAYlcY3eEHQHHso/eqEAq3COqt0F1Q4j3vwGdhFp1SS5K+gj27hJJbxPBgovR0w4q7dUZDtcOQRIxgZM8x0tZlOWwy+beOPMSigbvE5Zc2PJYh68FBSEshLLcVZfqnUIh99D7OfA1FAXfFGJPIntnF5Ym4UQNiCKh0RPD0kE/0CVoY6WgKQAJtAS+t1IrLKZmoXU5xHcM13be9y8xsVmRadl2GMZdtoozyXKkAhe48PdoEV6Q==
Received: from SA1PR03CA0006.namprd03.prod.outlook.com (2603:10b6:806:2d3::19)
 by PH0PR12MB7984.namprd12.prod.outlook.com (2603:10b6:510:26f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 19:58:36 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:806:2d3:cafe::e5) by SA1PR03CA0006.outlook.office365.com
 (2603:10b6:806:2d3::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Sun,
 11 Jan 2026 19:58:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 19:58:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:58:25 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:58:21 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>
Subject: [PATCH v7 30/36] hw/arm/smmuv3-accel: Add property to specify OAS bits
Date: Sun, 11 Jan 2026 19:53:16 +0000
Message-ID: <20260111195508.106943-31-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|PH0PR12MB7984:EE_
X-MS-Office365-Filtering-Correlation-Id: 919817c5-e772-44f5-235f-08de514bcecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0QwZ0pUQi9Wek5VQXB6SlpXeHJuK2VEQ25lZVJZaVdRVW5SWUNPUHkwUFEv?=
 =?utf-8?B?R05qWURmTkZENFErY2g2UUNlV244dGdxU0Q4R2lXb3JtWThVYnp4WFJWZy9H?=
 =?utf-8?B?M01KM3g1YVhpZHgzZ0xWQWlwS3pPSlJzRXZwNWVadXVib3U3cUsvSTA1UEk3?=
 =?utf-8?B?UlNudDlROGRsV1JUOU9EMVpKZXpkWVRhbHJobHJ6eDUvcEpWRFJwdHN6cEMx?=
 =?utf-8?B?Z2ZqeitOMW45cXQrdlVFZkUzaTUrdHpxbjRlZ0IwZ2MvOEl3ZWtaN1hJa0hY?=
 =?utf-8?B?S2FYVmhjWFZDMjRNelRhclE2ZEtiUS9jeVpnb2prVlJ0a1NLcWFuaUlkWVJN?=
 =?utf-8?B?ZkxjYjgwU3ZlckN1T0UzOFlLa0ptSGdwMXF0cm5UcjJWY3JnZWpaVGFvRk8x?=
 =?utf-8?B?dXRuZmxqdFp2dzJwQVZKK2dhOWh6NG9Da1p0YnE1TW96c2RMUlZoYnlFaUdt?=
 =?utf-8?B?eHRNOVF5L2NKSzI3aG9zNEFOYUlzYWhpOStpRVRZVEl2ZW5iZFFHcFo3U0pQ?=
 =?utf-8?B?M1pZWTdTcU9JcnZWV0lHcTFtM3R0Zjk2RUkxNjVzWExSUE8ycGtaOWZvSnIw?=
 =?utf-8?B?OGtXd01iVmoxdVVrN0lUMWIybjFVcURnenJCT05IbE5zbDFWVDBvYlZIRUo1?=
 =?utf-8?B?V3k1VmNaaWFVU0dMV2F1azRPODRHeC9DOUJVOEdnY2lrajhUOW9uSTE4dWRW?=
 =?utf-8?B?NWJkZUZkRi9NVHZYNHZUbTBBM1FiZDZJT25nN2JHdUcxMGdzcXB6NXRIeS9t?=
 =?utf-8?B?Z2ZESUNScHp6M3ZtUWZyVnJjU0k5cm50YjNFOEcrSTVkREYvQjNRN2NMeVJz?=
 =?utf-8?B?VkVqemF0Z3hGdXZmcXBvNk9iU3poc1lXaFNuREllMjVyazdxbFhscFYxTmVE?=
 =?utf-8?B?YU9LV09DRzI0QUpIaXNzYVZFMWdZamJNTXZ6RGszdDR5aGNVVXFhbEh1Wi8w?=
 =?utf-8?B?YmVJVnd1NmVKWFhmNVZXR1Y2cHpLM1lob2V6M0d4dkt5QXBTZlVjNzJLM1By?=
 =?utf-8?B?Qm5FTENKeVFXZ3M0OC93eG5NVTFmQVNjOUxjdjBsK0plMVdseVpJUnU5cFhs?=
 =?utf-8?B?V2dWZTd0d0x6WWZ5ajVteDVrSU4rSmY5eFhrVUxKMjNJMHR2dkxYN0h4VVQ3?=
 =?utf-8?B?dkY3WnJuVGJGclFGUExlTEhyWXpNWnVHcFo0a3cxdzF0YUZkWkhvRHhHazRP?=
 =?utf-8?B?a2EwUEhqUkNWQ3NJR0EvRXFGMkkzQmRocGlRQmR1Z0hZdXVERm0zQzMyRW1i?=
 =?utf-8?B?RW92WHUxT2l1bm9LeVN4QjRTRHdTSVhIay9STVhLZllWd0c4SDJXMnowWWVR?=
 =?utf-8?B?RlE4VUVwcExsTVUvclQ2UGplUGpQcGFwcmZEc1FwVXRQY1Iyc1pVZGVxck10?=
 =?utf-8?B?ZFk0VzRSRy93RWl3c29pR04xWW9xdVVKZlVjWml2bUNHeVhhOGIrbVlHYVRw?=
 =?utf-8?B?ell1RHJ0UmNuV3MxZnBlR2J5NVBhWG1GZjdYMWNHUzhSWnlNT093VUU4Z2xa?=
 =?utf-8?B?NkM3K2R5NVNtN05jMVFndzRydHl0TVFtdTRrelZoSXJOd285UGRVOFFvRzNo?=
 =?utf-8?B?T2xlTkZva2NFenFSMmtvRW5qNjF1QVFxTG45RDNSZUNaOHNLMWM3VnVOQUpk?=
 =?utf-8?B?UCs1MnBsQVM4YlFyY3pZOU85dEQzWG8xZDV2RmQxMWUvTXVqdnlReDRPSEFY?=
 =?utf-8?B?UjVVMU8xVlBsK1lHRmphTHVDaXNUS0laV3dsRUx2WWhKZytBYUNKRUo1L1Rp?=
 =?utf-8?B?ME5Cbmk5ZXAzRTNlaXJ0Si9BL1lXdHR0U0U0Z1BUREVGek1LTTlEZEMrMGdz?=
 =?utf-8?B?OEpBOW9QbTcwMFI2RENaSk9wSlRucjVjTUtJOGNDdUQ4eGVjY25LdFk0dVpj?=
 =?utf-8?B?dVIyMDVERkoyaFZFS3dOZFNTc3AxTUIwbm1wRkFWZkIrZmhTK0FPS1A1YnlN?=
 =?utf-8?B?b2hSMFl5NnBKSm9OMFoxcEM2VVdXb2FwaTFEcHV3R2IzMlBCYkk1aW5VS2Za?=
 =?utf-8?B?Wkx1WmpGTzJHMkhCUmozRXBFUnNzVzNhaThtcGdLNkxNMjlCUnlEbVo0RDRS?=
 =?utf-8?B?Q3BvK3lvYmdESTFpbnBUWE5LUFVYbzIrbUdFREZFcEYxN2EwQkFvQ3FrRUlo?=
 =?utf-8?Q?1sx4=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 19:58:36.5643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 919817c5-e772-44f5-235f-08de514bcecd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7984
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
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

QEMU SMMUv3 currently sets the output address size (OAS) to 44 bits.
With accelerator mode enabled, a device may use SVA, where CPU page tables
are shared with the SMMU, requiring an OAS at least as large as the
CPU’s output address size. A user option is added to configure this.

However, the OAS value advertised by the virtual SMMU must remain
compatible with the capabilities of the host SMMUv3. In accelerated
mode, the host SMMU performs stage-2 translation and must be able to
consume the intermediate physical addresses (IPA) produced by stage-1.

The OAS exposed by the virtual SMMU defines the maximum IPA width that
stage-1 translations may generate. For AArch64 implementations, the
maximum usable IPA size on the host SMMU is determined by its own OAS.
Check that the configured OAS does not exceed what the host SMMU
can safely support.

Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c    | 22 ++++++++++++++++++++++
 hw/arm/smmuv3-internal.h |  5 ++++-
 hw/arm/smmuv3.c          | 16 +++++++++++++++-
 include/hw/arm/smmuv3.h  |  1 +
 4 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index a97abc1f79..ea420afeb7 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -27,6 +27,14 @@
 static MemoryRegion root, sysmem;
 static AddressSpace *shared_as_sysmem;
 
+static int smmuv3_oas_bits(uint32_t oas)
+{
+    static const int map[] = { 32, 36, 40, 42, 44, 48, 52, 56 };
+
+    g_assert(oas < ARRAY_SIZE(map));
+    return map[oas];
+}
+
 static bool
 smmuv3_accel_check_hw_compatible(SMMUv3State *s,
                                  struct iommu_hw_info_arm_smmuv3 *info,
@@ -74,6 +82,15 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
         error_setg(errp, "Host SMMUv3 doesn't support Range Invalidation");
         return false;
     }
+    /* Check OAS value opted is compatible with Host SMMUv3 IPA */
+    if (FIELD_EX32(info->idr[5], IDR5, OAS) <
+                FIELD_EX32(s->idr[5], IDR5, OAS)) {
+        error_setg(errp, "Host SMMUv3 supports only %d-bit IPA, but the vSMMU "
+                   "OAS implies %d-bit IPA",
+                   smmuv3_oas_bits(FIELD_EX32(info->idr[5], IDR5, OAS)),
+                   smmuv3_oas_bits(FIELD_EX32(s->idr[5], IDR5, OAS)));
+        return false;
+    }
 
     /* QEMU SMMUv3 supports GRAN4K/GRAN16K/GRAN64K translation granules */
     if (FIELD_EX32(info->idr[5], IDR5, GRAN4K) !=
@@ -657,6 +674,11 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
 
     /* QEMU SMMUv3 has no ATS. Advertise ATS if opt-in by property */
     s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, s->ats);
+
+    /* Advertise 48-bit OAS in IDR5 when requested (default is 44 bits). */
+    if (s->oas == SMMU_OAS_48BIT) {
+        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_48);
+    }
 }
 
 /* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 5475627253..bcf04d0a27 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -111,7 +111,10 @@ REG32(IDR5,                0x14)
      FIELD(IDR5, VAX,        10, 2);
      FIELD(IDR5, STALL_MAX,  16, 16);
 
-#define SMMU_IDR5_OAS 4
+#define SMMU_OAS_44BIT 44
+#define SMMU_OAS_48BIT 48
+#define SMMU_IDR5_OAS_44 4
+#define SMMU_IDR5_OAS_48 5
 
 REG32(IIDR,                0x18)
 REG32(AIDR,                0x1c)
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index ca086ba00a..cb02184d2d 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -299,7 +299,8 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, BBML, 2);
 
-    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS); /* 44 bits */
+    /* OAS: 44 bits */
+    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_44);
     /* 4K, 16K and 64K granule support */
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, 1);
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, 1);
@@ -1949,6 +1950,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             error_setg(errp, "ats can only be enabled if accel=on");
             return false;
         }
+        if (s->oas != SMMU_OAS_44BIT) {
+            error_setg(errp, "OAS must be 44 bits when accel=off");
+            return false;
+        }
         return true;
     }
 
@@ -1959,6 +1964,11 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
         return false;
     }
 
+    if (s->oas != SMMU_OAS_44BIT && s->oas != SMMU_OAS_48BIT) {
+        error_setg(errp, "OAS can only be set to 44 or 48 bits");
+        return false;
+    }
+
     return true;
 }
 
@@ -2085,6 +2095,7 @@ static const Property smmuv3_properties[] = {
     /* RIL can be turned off for accel cases */
     DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
     DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
+    DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2115,6 +2126,9 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
     object_class_property_set_description(klass, "ats",
         "Enable/disable ATS support (for accel=on). Please ensure host "
         "platform has ATS support before enabling this");
+    object_class_property_set_description(klass, "oas",
+        "Specify Output Address Size (for accel=on). Supported values "
+        "are 44 or 48 bits. Defaults to 44 bits");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 242d6429ed..d488a39cd0 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -71,6 +71,7 @@ struct SMMUv3State {
     Error *migration_blocker;
     bool ril;
     bool ats;
+    uint8_t oas;
 };
 
 typedef enum {
-- 
2.43.0


