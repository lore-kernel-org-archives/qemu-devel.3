Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91929C44506
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 17:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicSI-0005TS-AT; Wed, 21 Jan 2026 12:57:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicSF-00053I-Ap; Wed, 21 Jan 2026 12:57:19 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicSD-00020W-H8; Wed, 21 Jan 2026 12:57:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wez6pSxB0D6Jah/WETBG6PCyf/Wwmcw8elW4OtmrDZHjx0Dgs7KZ1OuDdtiqb/AtSdvVq0uJfnojA4KP+/R/vOIlRAuuo4ZS8z9kx+yHqmdAf5tmITM6eZwAhNEl6WxKUrcgC6kzh11XRT6HlYBnf099bRLzvRJQ5Aq9D+jxrbezEytWACgLVo4A+aEUXoLJQFB41JiNPMIGdN/Zf24ioixUyWY/sOIGSDLW2p9261J8E2L/D1ByW5Z1D45oEX0rF/D+FOxl3IgbI7edqjYcyee8wCWSp2Scvh29tScBSJQ2TQExFL9xBgxuEzPXYDma+3Yn+4qvUKiU4LYWUKBRuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDr7W8lcVBuyUlNJYOZar7ZEpfqiPid5kYrSkpuLZoI=;
 b=BLL1TThjqk0v7XlgQhr9dTcGZcXddmo+mxMamJN5KW5yqSXXs/O7cwKjTgMy45uVxNKCIJG0HozdqC21XKTOk6GY5W4/dIyeicpV8dHAJaWVXMOjhC+Kr1eQOjTi7uBUCjz0IRlz5j09e6e7rl4t/D+d3MO61IdMZl8PZAEaAGG5FX2jh2AnrqVnU2gxeDpuhx1WU2TAbn77+Yv9jfRcoXkNAm4nNDlrPAcHiiFiwrMvuUsb/GD2vP9Lj33/Viea6Vs5IE+woapls4iM8NJPTgoncQWL/9P1hpMe6z+JxZAP4K719WfjY5kDPn6U0T14qRk4Uo4nH2Bc/fO29z2vTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDr7W8lcVBuyUlNJYOZar7ZEpfqiPid5kYrSkpuLZoI=;
 b=P7Q7kb3YgkAOU8OmLLeL6A7c3qL4V21Nbu1btSUJozJCPkpIElS6zglBPg/hYM07YTcxL5ZUGsCRGNXXhNwe3JcbLnLSLWd/LK+PazE/AvPREkB8zeVt3NO+T7gWKh6V6nHYX5zjwVCxDVSI9EaDXh61LBKqHMo2vvkz3Yus6bo1D1tENtdcPA+a+b9sM0LB43Ie1n+CJwfwiHE+z7oa80C0FbBtHQ89lRkdxPuoHgfE8ctTK8B2FNOIrXe9DwFvKztyRHEEdiKpnES7ouGllCjHz2VC/rTUj/fIB+BYGK4clPNUJoM46HGpnGOsOyGU8aw3yzj5bzERDnLTqzk6JQ==
Received: from BN1PR13CA0028.namprd13.prod.outlook.com (2603:10b6:408:e2::33)
 by IA1PR12MB8540.namprd12.prod.outlook.com (2603:10b6:208:454::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 17:57:06 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::2) by BN1PR13CA0028.outlook.office365.com
 (2603:10b6:408:e2::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via Frontend Transport; Wed,
 21 Jan 2026 17:57:03 +0000
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
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 17:57:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:56:40 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:56:35 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 19/37] hw/arm/smmuv3-accel: Add support to issue
 invalidation cmd to host
Date: Wed, 21 Jan 2026 17:52:24 +0000
Message-ID: <20260121175248.87649-20-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|IA1PR12MB8540:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f229a0-82c5-4593-960e-08de59167d88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDkxY0Z3RW5wM0JkRWtvZGJWV0Zka0tXWkRUeW1VdXZRMkI5b051OHZBeXBv?=
 =?utf-8?B?NEJvVk82QnhVenhrWlNlb1BSNnpMc0sxT0dkdXcycnd2dDljNkhobWJpT2NX?=
 =?utf-8?B?c0hUNFVuS28yMzJPQW9DYU8wdGZjcGU5bnczS1krN3l2U2dKUG5tQVIwaW1s?=
 =?utf-8?B?dnhjV1dpaWkvd1ROemV1Skw0M3FJNWlxU3FZNHhpeUdBSFBqblRCYjUybVYx?=
 =?utf-8?B?ZHBxeDA0Z1QrMkNvWjlZU00zUTEwZVVqOUdaOFFiOFRlQ0RJNGNjNmNKamor?=
 =?utf-8?B?TTNnc0JJL1c0RVNTdWJBYjA1ZTkwTVNYRWxMOXRvVnNxN2xIMlFpc0lDVjQ1?=
 =?utf-8?B?U05sakZHYlBKNlI1MTdaZDNZOThsY0V5ZWZxRnBQS3BkUmwyWEc2YW5JdzJh?=
 =?utf-8?B?ZE9STXdMZ25oK2pCWU4rZWUwcGVkaUtYVXZtSUgwS0puNGtlczcyclFnVGZt?=
 =?utf-8?B?c3VsT0JGem1hVkJTbFJETkVvemxhSUFyWjd3VVJhS2svNHpmWjlHZ2NBOE15?=
 =?utf-8?B?UWhDOUgzdHBCeENBN0VxQ2JUNkFYd2NUdnFmTTkvOFNMZ21OZ3g3cHhDbktN?=
 =?utf-8?B?ZDhid3hQRXhBUEVzTHVVSWM0eDd1UHRTa01iUTFDOWlPdmJOcUszWmpMRnYy?=
 =?utf-8?B?NlZISW9EK2VIckgrNFpFMVRoaEFuUm1Bem50MEhUTTlIWGtMcW9BVnBpQnhi?=
 =?utf-8?B?OThleUVrQW51anp3b2ZacDZKTFh0bENUVVlaNCt0Yk9GUll4ZTY2cEF6VHlE?=
 =?utf-8?B?T2N1elRoVkdSWFZNUC9LZFQwcm5IbkV0WWNWenkzNUlHaWkyS2ZlQ3lLM0V6?=
 =?utf-8?B?T1o2aXB2dmptRVBKdCtrWm9SeUNad1d5eEF3ZEVZOUk2c1NabDFoczlQZ1Rz?=
 =?utf-8?B?NzNvaUt1YjlNRWpNU0xQMTd5ZXp2U1BiOHlQVE4rQVRNQ1luUVV1UXpTZ2pW?=
 =?utf-8?B?L3dQaVdtQ3NtQzBOdTlhYlA0SGZrOXhjc2pQcTBhL1YzZk5Fb0F1K2dmTGEx?=
 =?utf-8?B?dFlJZUhSMUhIUWRYVEMrZytidExnRy9Zc2NSVHFnSnk4eS9Ddk1zZUltLy9G?=
 =?utf-8?B?Zzc3NmRuYnk3a2FMbCtUZmk3aU05NUk5ZDdRWVNla1UwZ3hQVnpWM1psbjNP?=
 =?utf-8?B?Qmcxc1NnSEpVaGMzMmtqelhsQy9wa1FNZlZoaXNqKytQRTFMWU1TSjA2MjVH?=
 =?utf-8?B?M2hZdk0yMlYwRUxBMXA5MFNGL1Z3Z3N2Z2xSRC9zWkRqdGlCTHBoS3dOeTRH?=
 =?utf-8?B?bHBnNUxwbDJFWVhxVFBPaTRTTjVBZ3Jyc1pwMjZlL2JndndIQzJ4eHhoeW5Y?=
 =?utf-8?B?RXdTNjVkMGNlOEZJa1AyOGtIN3NSR0U3OGxpRWhKWm5VVXVRM1RVT2Jad0Mw?=
 =?utf-8?B?NlpISzQzREJZS2lxYnVsOFFabm5zUkh1OGg5dFhSVzBHSHkxSlh3c0U4TFBq?=
 =?utf-8?B?TWdaSkVubWJRYTBhOTZ3U1VISlByZ3V4Nml1SVhNRFozYjBOaGtzMmdTYmdv?=
 =?utf-8?B?ZkdMNDYvNGVxRnNpKzA0dGRBWi9rQWlMK3g0WDJ0L2dQK0ZGU1RIK3VJSzJy?=
 =?utf-8?B?VVpRbWJTeXk2cENZbldRRlRmSXVSSGcxdTU5VmJ0WUZlNHNSYXd0UmFEYmxS?=
 =?utf-8?B?Y0tTai83c3Q2RDNrUk1ubkdrK0t4UzZnZXlDbVV0N3NCRkpSalNvTnJCak9I?=
 =?utf-8?B?ZTVrOEpTenFOdVhQQzNuMm9QZVJOOXQzVGN6SUNwVUpFY0lyS0FaMkNTaFla?=
 =?utf-8?B?ZFRGRFJNTm1QdlAxT1FZMDlaczV3WEJhNzZyUmVhQjRBaVpOOWNpQ1hqVDQv?=
 =?utf-8?B?N2VnSnNCQ3JtRTJjVFRGZlhWbi83cSs0QXVPaUp3Znd1elJ0dHFYc2t6UnJh?=
 =?utf-8?B?andycHVCMk5xSjBlcE54ZTVwWFdrWE1BNHI5VXpwd2hReFE4L0lCSUtaVHZZ?=
 =?utf-8?B?eGlXU25paFYvUEludk55ZlJTTEZDSm9zaTVlRVJBRG1zZmhDSVNrVEpsRWcz?=
 =?utf-8?B?Z2h4ZE1JTmgyc2s4Q0ZSNlJkTytQUHo0S1lidjZGdDFFT1VJQ21JTkZxUDQy?=
 =?utf-8?B?T3lnVTgzdGhDVHovNmZEU3RmOUMyZktOdERTcTZ6Y1VaeGhrRDZwL3QzbWZL?=
 =?utf-8?B?YWF5Z3JidDUrT2JFVzNDaHppQkxKNXZqb3NHd0NpYzBFK1FjNVhESktjc1U1?=
 =?utf-8?B?YWoyd0xFNURpNWVSU3hpbDdjaDZmWFU5WktPbEV5cnRNTmp6QVAyS0hlY2JX?=
 =?utf-8?B?cWxpams0Zk5uNWd1ck44NnN6c2tnPT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:57:06.1531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f229a0-82c5-4593-960e-08de59167d88
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8540
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


