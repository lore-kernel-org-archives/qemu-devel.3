Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3972F4198B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 11:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCxxD-0003Df-RT; Wed, 15 Apr 2026 06:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxxC-00037u-2P; Wed, 15 Apr 2026 06:58:42 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxxA-0004F8-Kb; Wed, 15 Apr 2026 06:58:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJ70AnabVfkVu5NFTrUP3lahcYS0MNHb5B9aMpyeOJdvY7eyMYwa+KKiXYQciMg9jVK2IMXx+jVAXNBpmiNHAJCKvUsxE69KD6pvNgnAQdgwmLpWSHvPmmUyberlr85sLtP6vJFG0jwy8O+WwRwoJ47y9mthdQP2VOIAU2+3CFed/jM+UU0sLgzRKdyL0ZMa+n88PC6G9bNRoNZekGEOqDMeKETgM7IkuVg8IbXqNmPRvZzJIj4ygJnAt3m5D2qsEJhZNNaL7CQ32+jhUVwRuLI9wx4ND1CKw1VIAJZclFsNtZo2VFRs2BUjng3Wcb9IW9qArz3RXUriGlC9o1vgAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2olgw6L5ljtehMlDF6yBTFNYzcFVKUqvn8hXd3J4O3c=;
 b=AjOWZFCeCl8FHhC8Ny7ga85z8W9PvGY2BKeIbWm5LPg9MegZcmqpfpnU13mwtaC+bqawiT0/tXlN44zkD94B+00vWgUfL9P0rbArv7reh8DgzCosibjT1SLp5qB23/OiHBOxnGCL90qqf+B1YqVmAnD6nQop/jmhqTzdSrd7icSuhFtpnAiGiq7C+6ozJNuAK30q+MPajv5uxiNSDLz1T17fBrjCnXGzNpxPdTRF18ZnwAG5HOSSExFvchf5OPX8oqnfPociyvvv5eR7u6R7j8UJSK7zUvri7YY0dN2iagCkjfltQsS0Xr7qnKtuDXJifaDq3kKBOInFREx4I7Gpgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2olgw6L5ljtehMlDF6yBTFNYzcFVKUqvn8hXd3J4O3c=;
 b=aC9OSMGzsbQZ90RjNaUOW+zMsZAp6mCwjeR7idaLTmpQ1N0dkRfzufo84/DE0zQ5HFYkGO8i4T37e1MrRH1Kx4kazRsPpR3pkKx7LmBcc6PPgmbY8J0wrw6z9JvOrOIC/ebV6yeRJ/P1mXDr+Eo2AjEpwIXPuNE08RBYwbg606ig8m0KIh1iQrp4CHUG2qTZF4bOkTvim65VyhIpziCFyMNr4hKK0YnJb083aQG7iqoL+FHaZF0pIbrJqXkBsrlqVresXjl4yeYc9SHWhi6qFHbiyLvObWFnUz2gg+8/X5ugX4a0kkyCaf9r8tfCpNML0rzeVq+ozKlxG8HOyBDn3w==
Received: from MN0P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::18)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 10:58:35 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::77) by MN0P223CA0029.outlook.office365.com
 (2603:10b6:208:52b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Wed,
 15 Apr 2026 10:58:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 10:58:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:58:20 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:58:16 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v4 28/31] hw/arm/smmuv3-accel: Introduce helper to query CMDQV
 type
Date: Wed, 15 Apr 2026 11:55:49 +0100
Message-ID: <20260415105552.622421-29-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415105552.622421-1-skolothumtho@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: 012b1764-ed97-4cbd-c35a-08de9addf0de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: HtmOg1eAk37/kfsnoD2lEHZ4+BXAIExJRIwLYh8+p8/xwPzRhtYc1dMYLGNTjEqBzm/b3eN36z3S4R5QFtW8YBi+A7m7IHDNNwJqPMGW3Cae8B8+6fh+CDdKvvoOtbnTI4iAw9lpldOHH7RdGexukEP0bkQrULTiNySyFrpW9h2g6OPhgWmzsmqqsNmDzEKPBpmDC8LAeUAw/h0U3xx3nEEDhHTzmglNJX2yuy8zzQgnaX5AgoGSLIKx8/LWoAEzr3eZ3cbbxY4pTruB9IxLHJ/TUDyDkdL+MqPMG9ko11pBaLZpgYFJQOE3435Z1bJU4/+LTAt+UBjWLhR1/tTJ/19361akiAAI+doJRYIjaYoy6OkUT+SD/rmbTtiMMliGzT1GprGnrsT0hZA2l8UwCcEQD/o55kyIsWXdGlX8yTEdemBEEGNg2Z1uliUIqUZkMFwNgSAq2AJpVG0cCH3vyd+MixxEQ5BpUMNyvFiadoHkpsntFjTZQaXEbBmCzxoTYzIJNxtSwthquhvHLNQGMy01whd+wW2gtxYhn/Cwwh4sYIirWmzpba5pj8bKhfd8zrMLcPLSjy7o4C83cuAi9XBkxvFbEvAA2Wtv6TcioomwdjoIgbKQF7QsX9RFXkKiuDyB5Q9Bz8KLnb6fIbYyglGTnukbTJ72Lm8kcs4A5eT9x7fGpbjq4sDKKPMxca70KBSqqpWFSkKLm/3VUPOSvykITjQB4I8+rFXWtnXpSFrR3B5IG9o6SF+bHKD5D+iKX7ocfvKyfu/+1C1QvOCCSg==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QhMbMSogXBoev6F3c/dDL/yFZstMm55GfCtq6zdTg1BAiAS5mGCBuxyQnOFAykaqPMSLKc1YoumUYwVN20CBA1EZGFjHVtmwBOj1P4ue7FFPA+6us8dgv2h3H0L0Hyz6hPKCx0Kfm7VyY3UUZfHwnSUcJVBvA+P4EzTk5nE36TboEUnZcgOp8reOA/fk3CrxPyHZi0ciHptDvqgV55YvgiCL7zKZ2ddqbfv+NdAlT/a1amieX9n5pSVbKLqmpMrb5pDQbNQOUhv2BfpyFvWWx+a/w4U5O6FY/aOlq3bHZisticRdGH42YZfyKXb4OKWMUI0HLzqjGQT9mYN5lS4IfacTOOAJCxQjU5N+2jsorc4c7U2tkjc9tVJelCCKEnrr9lkAPE8QPfern/hWxvdOCx5LNXGAxH/abGNGhvKkCTDesbG6q+osoGf9ymex8Bse
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 10:58:35.0846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 012b1764-ed97-4cbd-c35a-08de9addf0de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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

Introduce a SMMUv3AccelCmdqvType enum and a helper to query the
CMDQV implementation type associated with an accelerated SMMUv3
instance.

A subsequent patch will use this helper when generating the
Tegra241 CMDQV DSDT.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.h       |  7 +++++++
 hw/arm/smmuv3-accel-stubs.c |  5 +++++
 hw/arm/smmuv3-accel.c       | 12 ++++++++++++
 hw/arm/tegra241-cmdqv.c     |  6 ++++++
 4 files changed, 30 insertions(+)

diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 448f47c0ca..3ed94ed05c 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -16,6 +16,11 @@
 #include <linux/iommufd.h>
 #endif
 
+typedef enum SMMUv3AccelCmdqvType {
+    SMMUV3_CMDQV_NONE = 0,
+    SMMUV3_CMDQV_TEGRA241,
+} SMMUv3AccelCmdqvType;
+
 /*
  * CMDQ-Virtualization (CMDQV) hardware support, extends the SMMUv3 to
  * support multiple VCMDQs with virtualization capabilities.
@@ -29,6 +34,7 @@ typedef struct SMMUv3AccelCmdqvOps {
                          uint32_t *out_viommu_id,
                          Error **errp);
     void (*free_viommu)(SMMUv3State *s);
+    SMMUv3AccelCmdqvType (*get_type)(void);
     void (*reset)(SMMUv3State *s);
 } SMMUv3AccelCmdqvOps;
 
@@ -74,5 +80,6 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp);
 bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
                                       void *buf, size_t size, Error **errp);
 void smmuv3_accel_reset(SMMUv3State *s);
+SMMUv3AccelCmdqvType smmuv3_accel_cmdqv_type(Object *obj);
 
 #endif /* HW_ARM_SMMUV3_ACCEL_H */
diff --git a/hw/arm/smmuv3-accel-stubs.c b/hw/arm/smmuv3-accel-stubs.c
index e8f08dc833..08de01d909 100644
--- a/hw/arm/smmuv3-accel-stubs.c
+++ b/hw/arm/smmuv3-accel-stubs.c
@@ -55,3 +55,8 @@ bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
 void smmuv3_accel_reset(SMMUv3State *s)
 {
 }
+
+SMMUv3AccelCmdqvType smmuv3_accel_cmdqv_type(Object *obj)
+{
+    return SMMUV3_CMDQV_NONE;
+}
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 230f608f03..a58815ded2 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -1049,6 +1049,18 @@ static void smmuv3_accel_as_init(SMMUv3State *s)
     address_space_init(shared_as_sysmem, &root, "smmuv3-accel-as-sysmem");
 }
 
+SMMUv3AccelCmdqvType smmuv3_accel_cmdqv_type(Object *obj)
+{
+    SMMUv3State *s = ARM_SMMUV3(obj);
+    SMMUv3AccelState *accel = s->s_accel;
+
+    if (!accel || !accel->cmdqv_ops || !accel->cmdqv_ops->get_type) {
+        return SMMUV3_CMDQV_NONE;
+    }
+
+    return accel->cmdqv_ops->get_type();
+}
+
 bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
 {
     SMMUState *bs = ARM_SMMU(s);
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 2870886783..71f89abcb4 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -762,6 +762,11 @@ static bool tegra241_cmdqv_init(SMMUv3State *s, Error **errp)
     return true;
 }
 
+static SMMUv3AccelCmdqvType tegra241_cmdqv_get_type(void)
+{
+    return SMMUV3_CMDQV_TEGRA241;
+}
+
 static bool tegra241_cmdqv_probe(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                                  Error **errp)
 {
@@ -802,6 +807,7 @@ static const SMMUv3AccelCmdqvOps tegra241_cmdqv_ops = {
     .init = tegra241_cmdqv_init,
     .alloc_viommu = tegra241_cmdqv_alloc_viommu,
     .free_viommu = tegra241_cmdqv_free_viommu,
+    .get_type = tegra241_cmdqv_get_type,
     .reset = tegra241_cmdqv_reset,
 };
 
-- 
2.43.0


