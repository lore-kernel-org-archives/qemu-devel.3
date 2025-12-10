Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00A4D3C54A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTKPu-0007dv-1v; Wed, 10 Dec 2025 08:39:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTKPj-0007Y9-Rc; Wed, 10 Dec 2025 08:39:33 -0500
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTKPg-0001QX-FO; Wed, 10 Dec 2025 08:39:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wAQ19rowxGSHKfvhz2vsdmoXlCRkbH/Di8KijR4XDaL8lEzcp5LMzJ83W1c4IoKcT+G63XSDwsZL5NiNuO8V6zQ0waLO9gLZshKtaIrP4Mt5hSfvqwFCDj0zuuOnt86iD6Gf9ysZPSgFMCIxtpMVcIy1ZaQLwjOqVg91Olue+3b9bZ+9IqO3fQdUtJWa2UZgumaYU2sDPEOLP6oohPIjjb0titEQlLNaViSaQQFj9WmBiS0wz3QHuZoNhyBI58xns3zEUNzmn0FrrmkbFs3FMLc0SAQ6/uw8PA1PtH4yTNPujYAMZoU0+cYqrujsavR0nm4DZVD6Z4N5rRmR+1U0Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQWQ0qn1WY8pahQUPzCzZCaJ0GsTBV9miUpC51umYRg=;
 b=qFdcSWOBx3eeT31g0NzkRO5Y8y4ifk8LPkpXIXQsgFsc1t6+TPHG8SiZ0ZK92sArRMqNEc1Q0gTfPyCSpEcBlgcG4B5XIX11fnf3grNzzLobIjENkPUTH1dMSj+UGP+cBwBvzbAIDGLVwe6cq6fbKPWFUGMoypfOly10ds1VjWweOYfx/4e7EiXmTRjNmK/Kh6ABUkY884hlallBI04MW/TlOQ1RUkz60H4Ly3yfPfTqwtD+hxBYVRNo/+4PzQ02WxocGKojs1yDDaXCOE3BX374VG5h2wpQD/h9yJhtKPja/DOcZDWqQB+1bEKcPBfVgGWmE31DQttD+/hB0yKBUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQWQ0qn1WY8pahQUPzCzZCaJ0GsTBV9miUpC51umYRg=;
 b=Y8jdvBrMtYq8OD0zeo32z5N+VNowrUW5baBS3HA47EVO3+8ecP7ISOAI7RAQ0c9iBIcGmHtpaV3CPr7tQ7MUWfHRsouZ8tXoniSkQsMdsYHh+4g81tNq8FWqY87MRS5bJECA55L0TDnHR0depBNfd/P1LdupoAqh6AGbKVWKA+zB9yKJnWxY/8N1mOC/powf91bg5pYzpePb4H/Ky1RK6sQ1846jwTcP21eMm1YGcF8q+IGNpX0W+5VeiOIAmUpIWjesOnCw/X9dPNkx+NaMNOYVrmqoEAGvYGjl9ThC8vEspFVB9x4w7G54VS93h50ryOxoX3SzomN+PIMpmLkktQ==
Received: from SJ2PR07CA0017.namprd07.prod.outlook.com (2603:10b6:a03:505::17)
 by BN7PPF62A0C9A68.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 10 Dec
 2025 13:39:18 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::ff) by SJ2PR07CA0017.outlook.office365.com
 (2603:10b6:a03:505::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.7 via Frontend Transport; Wed,
 10 Dec 2025 13:39:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Wed, 10 Dec 2025 13:39:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:39:01 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:38:58 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: [RFC PATCH 12/16] hw/arm/tegra241-cmdqv: Add reset handler
Date: Wed, 10 Dec 2025 13:37:33 +0000
Message-ID: <20251210133737.78257-13-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251210133737.78257-1-skolothumtho@nvidia.com>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|BN7PPF62A0C9A68:EE_
X-MS-Office365-Filtering-Correlation-Id: eda6874f-66a8-4c43-83a7-08de37f1846f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8b54iP95uHS5SlxqNpIGPPoGc4kz9653ZOCLQ6qr6HkPxD/C5X6/u00IKg3m?=
 =?us-ascii?Q?lK2KmmFpX/RO6MGGrNsBzN68zo9TsyQEwoR31q4tH5wYzPDH54R4xLJqijkG?=
 =?us-ascii?Q?pb/+ZlkcV1nxYNzLF0CUpbyWPk+fdutOKa8CTJxzp80p+vHKs1mE4eS/jMKy?=
 =?us-ascii?Q?KYiL9J4lMpklaFS3oypIaX44kjSbWPL3JTmZepXJiH3u5LajPq3XOBDCsAag?=
 =?us-ascii?Q?8aQNJaXtUgqvD0vbBd+l951venBe/iXMrSwDFmtd3g9Af0MuPPMe6otIhh+8?=
 =?us-ascii?Q?vvqgTax5DjBJyQFJSmkzYstZfhwuERN+FXF9sIhcBLoMrn0atXq8NnkkgsZF?=
 =?us-ascii?Q?ycHSco5+o83xQnePHcDRkEp2ElukyP5RNPEZtdwTdyH5+y+DVi5QMdwchUP1?=
 =?us-ascii?Q?kGNQfL05Tl0YbEN/qooUG1MtUj4qscjHr6NG7rBohKt1a2SIYc4UPD4t+PBj?=
 =?us-ascii?Q?S1MSyncRgoWiU9cBIP8lAxUmXzyqYm0FpUv3GJcIydrhCcxS4aU8wQ7iHsNH?=
 =?us-ascii?Q?FbIHiY81u8z04h1SvQP/xLc+XlZ9pHtFQzY+z/NcU+4fFOhKfWtJbxYprqqx?=
 =?us-ascii?Q?uClBNyXZf0eo2h8dwq+q2MOh876nq2dIzVxgOl9J/Q41sFF++uWhCjAsCicy?=
 =?us-ascii?Q?f2M5uoCUXNuCodby0yqbbZnmDOccEoWUnp3BMTyRWwiGOXzkOZKsZCmHkhh1?=
 =?us-ascii?Q?+DmR2xVe3IJeg5gn7oz2XbSwEWtvemh9YbHLi8l7YPp1I6dE+m8bYNEi2zTN?=
 =?us-ascii?Q?BMnr8ihSMnEtYaJe+hILeRN8Qm0wWgcSmgn38/8E73Etff7G/hnJqwn9QZzN?=
 =?us-ascii?Q?JIvDU2K+epHhd1P0Tp0P5VvcfQ9ZBnjJojZ9mZ/sWo57LMgsd7n2WqZNCwzW?=
 =?us-ascii?Q?oHANLW0YCJvNO8yqw8TuHfPhM7Xy1P9GcCG0JQt9jbaItx9ZxEoOSw3RGLXx?=
 =?us-ascii?Q?U3n7RTLPpccvh5A8VkZQFvE6+ed1WoTDkxrktWGqWDZH03H3DMJvNzGist8p?=
 =?us-ascii?Q?jxGh6XO6st4hN+kqfXQgHpzVTldQIVFGlqW+2arOvI477HwHYAJpLUIWvFlv?=
 =?us-ascii?Q?GmDB4aoty+QHiTd5AWQ0jpXfSy1fwsh5hdIg6jtlJwM0hxmQIb2Zodooh8+9?=
 =?us-ascii?Q?0KrKhxKRmyWwfqyyPOxj/vCL0qs8ZX/z3qZrufyaRBtSqtYwG+OXj/c9Aw+S?=
 =?us-ascii?Q?b2dCodwE2RABSZeg93gL9C5Q0Dtk0LCFcCBZcRym4COYyoL/VThCJyH7o3U5?=
 =?us-ascii?Q?HEsAyzN9XRkKPFARKaCo31QsF8xCRbn4sins9VUGPyXlsIaI+5D0avVecDh0?=
 =?us-ascii?Q?/pxpXvLzqEMO0h/gHPt/5m4Zt3E+vm27K+g1UV0R49lI9FhRInXINEOE+JOq?=
 =?us-ascii?Q?W7cW5+/KwqC4sLO1xRQO2P5XCXR2F+UJudci63ofr67bDHULkGjEW0poL8Ca?=
 =?us-ascii?Q?/dUHIjZlhDao4Mo2wgspP8WE2caJZF+xH4GXrca5DSoF/ubz4FhwnN+r6SZP?=
 =?us-ascii?Q?NAJFx5TE5zmb3z50EURzrGGeB8rvsxilNHatJLe4h9vSQCarFNiSDFkj+C5u?=
 =?us-ascii?Q?J83c9hWzqnLBDh/ZSqQ=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 13:39:18.0717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eda6874f-66a8-4c43-83a7-08de37f1846f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF62A0C9A68
Received-SPF: softfail client-ip=2a01:111:f403:c007::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Nicolin Chen <nicolinc@nvidia.com>

Introduce a reset handler for the Tegra241 CMDQV and initialize its
register state.

CMDQV gets initialized early during guest boot, hence the handler verifies
that at least one cold-plugged device is attached to the associated vIOMMU
before proceeding. This is required to retrieve host CMDQV info and
to validate it against the QEMU implementation support.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3.c         |   1 +
 hw/arm/tegra241-cmdqv.c | 105 ++++++++++++++++++++++++++++++++++++++++
 hw/arm/tegra241-cmdqv.h |   7 +++
 hw/arm/trace-events     |   1 +
 4 files changed, 114 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 02e1a925a4..ec8687d39a 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1943,6 +1943,7 @@ static void smmu_reset_exit(Object *obj, ResetType type)
 
     smmuv3_reset(s);
     smmuv3_accel_reset(s);
+    tegra241_cmdqv_reset(s);
 }
 
 static bool smmu_validate_property(SMMUv3State *s, Error **errp)
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 5b8a7bdff2..1f62b7627a 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -592,6 +592,111 @@ bool tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
     return true;
 }
 
+static void tegra241_cmdqv_init_regs(SMMUv3State *s, Tegra241CMDQV *cmdqv)
+{
+    SMMUv3AccelState *s_accel = s->s_accel;
+    uint32_t data_type = IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV;
+    struct iommu_hw_info_tegra241_cmdqv cmdqv_info;
+    SMMUv3AccelDevice *accel_dev;
+    Error *local_err = NULL;
+    uint64_t caps;
+    int i;
+
+    if (QLIST_EMPTY(&s_accel->device_list)) {
+        error_report("tegra241-cmdqv=on: requires at least one cold-plugged "
+                     "vfio-pci device");
+        goto out_err;
+    }
+
+    accel_dev = QLIST_FIRST(&s_accel->device_list);
+    if (!iommufd_backend_get_device_info(accel_dev->idev->iommufd,
+                                         accel_dev->idev->devid,
+                                         &data_type, &cmdqv_info,
+                                         sizeof(cmdqv_info), &caps,
+                                         NULL, &local_err)) {
+        error_append_hint(&local_err, "Failed to get Host CMDQV device info");
+        error_report_err(local_err);
+        goto out_err;
+    }
+
+    if (data_type != IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV) {
+        error_report("Wrong data type (%d) from Host CMDQV device info",
+                     data_type);
+        goto out_err;
+    }
+    if (cmdqv_info.version != TEGRA241_CMDQV_VERSION) {
+        error_report("Wrong version (%d) from Host CMDQV device info",
+                     cmdqv_info.version);
+        goto out_err;
+    }
+    if (cmdqv_info.log2vcmdqs != TEGRA241_CMDQV_NUM_CMDQ_LOG2) {
+        error_report("Wrong num of cmdqs (%d) from Host CMDQV device info",
+                     cmdqv_info.version);
+        goto out_err;
+    }
+    if (cmdqv_info.log2vsids != TEGRA241_CMDQV_NUM_SID_PER_VM_LOG2) {
+        error_report("Wrong num of SID per VM (%d) from Host CMDQV device info",
+                     cmdqv_info.version);
+        goto out_err;
+    }
+
+    cmdqv->config = V_CONFIG_RESET;
+    cmdqv->param =
+        FIELD_DP32(cmdqv->param, PARAM, CMDQV_VER, TEGRA241_CMDQV_VERSION);
+    cmdqv->param = FIELD_DP32(cmdqv->param, PARAM, CMDQV_NUM_CMDQ_LOG2,
+                          TEGRA241_CMDQV_NUM_CMDQ_LOG2);
+    cmdqv->param = FIELD_DP32(cmdqv->param, PARAM, CMDQV_NUM_SID_PER_VM_LOG2,
+                          TEGRA241_CMDQV_NUM_SID_PER_VM_LOG2);
+    trace_tegra241_cmdqv_init_regs(cmdqv->param);
+    cmdqv->status = R_STATUS_CMDQV_ENABLED_MASK;
+    for (i = 0; i < 2; i++) {
+        cmdqv->vi_err_map[i] = 0;
+        cmdqv->vi_int_mask[i] = 0;
+        cmdqv->cmdq_err_map[i] = 0;
+    }
+    cmdqv->vintf_config = 0;
+    cmdqv->vintf_status = 0;
+    for (i = 0; i < 4; i++) {
+        cmdqv->vintf_cmdq_err_map[i] = 0;
+    }
+    for (i = 0; i < 128; i++) {
+        cmdqv->cmdq_alloc_map[i] = 0;
+        cmdqv->vcmdq_cons_indx[i] = 0;
+        cmdqv->vcmdq_prod_indx[i] = 0;
+        cmdqv->vcmdq_config[i] = 0;
+        cmdqv->vcmdq_status[i] = 0;
+        cmdqv->vcmdq_gerror[i] = 0;
+        cmdqv->vcmdq_gerrorn[i] = 0;
+        cmdqv->vcmdq_base[i] = 0;
+        cmdqv->vcmdq_cons_indx_base[i] = 0;
+    }
+    return;
+
+out_err:
+    exit(1);
+}
+
+void tegra241_cmdqv_reset(SMMUv3State *s)
+{
+    SMMUv3AccelState *s_accel = s->s_accel;
+    Tegra241CMDQV *cmdqv = s->cmdqv;
+    int i;
+
+    if (!s_accel || !cmdqv) {
+        return;
+    }
+
+    for (i = 127; i >= 0; i--) {
+        if (cmdqv->vcmdq[i]) {
+            iommufd_backend_free_id(s_accel->viommu.iommufd,
+                                    cmdqv->vcmdq[i]->hw_queue_id);
+            g_free(cmdqv->vcmdq[i]);
+            cmdqv->vcmdq[i] = NULL;
+        }
+    }
+    tegra241_cmdqv_init_regs(s, cmdqv);
+}
+
 void tegra241_cmdqv_init(SMMUv3State *s)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(OBJECT(s));
diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 97eaef8a72..0e8729c0b0 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -13,6 +13,9 @@
 #include "hw/registerfields.h"
 #include CONFIG_DEVICES
 
+#define TEGRA241_CMDQV_VERSION 0x1
+#define TEGRA241_CMDQV_NUM_CMDQ_LOG2 0x1
+#define TEGRA241_CMDQV_NUM_SID_PER_VM_LOG2 0x4
 #define TEGRA241_CMDQV_IO_LEN 0x50000
 
 typedef struct Tegra241CMDQV {
@@ -314,11 +317,15 @@ A_VINTFi_CONFIG(0)
 #ifdef CONFIG_TEGRA241_CMDQV
 bool tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                                  uint32_t *out_viommu_id, Error **errp);
+void tegra241_cmdqv_reset(SMMUv3State *s);
 void tegra241_cmdqv_init(SMMUv3State *s);
 #else
 static inline void tegra241_cmdqv_init(SMMUv3State *s)
 {
 }
+static inline void tegra241_cmdqv_reset(SMMUv3State *s)
+{
+}
 static inline bool
 tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                             uint32_t *out_viommu_id, Error **errp)
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 76bda0efef..ef495c040c 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -74,6 +74,7 @@ smmuv3_accel_install_ste(uint32_t vsid, const char * type, uint32_t hwpt_id) "vS
 
 # tegra241-cmdqv
 tegra241_cmdqv_err_map(uint32_t map3, uint32_t map2, uint32_t map1, uint32_t map0) "hw irq received. error (hex) maps: %04X:%04X:%04X:%04X"
+tegra241_cmdqv_init_regs(uint32_t param) "hw info received. param: 0x%04X"
 
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
-- 
2.43.0


