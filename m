Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21F8CD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWudm-0002MT-N0; Tue, 09 Jun 2026 07:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWudf-0001XJ-CW; Tue, 09 Jun 2026 07:28:59 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWudd-0003s7-05; Tue, 09 Jun 2026 07:28:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUyYWCjXEQRBWpjY6UJSPD90uD/Ed5vNB3fZL91Y74sqauiKWptHQqkfLVtJLnvFle0HX1zXfOfELpQzLMTMu/okJsdhjelm1Nd8wKjVEKM9KHZYyXWXQ1oiNpE4wzvnZjfEfg0EF/YK/F9L+9G8m5Y6icGRotrRKsTl+o2qIYly5OAHEzBZdtSJOytfQGDz3ovoKM3lfFfCmzcR/mtjVExVkYyBnwqk7Eq9qiM8dSNan0b+h3MymDxgnEqGrZvl/hYzJufsA+khqO9G7oqk1WwYS4SwIkH7hawep/GnNvGgZffghseDJyWHOG7ZJbgh/fVfvoPXNlRpHyFNOY0f6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHln2u6H89/lhot0VcYgtLxC9Hbdtn6nOu1bVineaGU=;
 b=udE0btSV6HHFRDPLnB7jaj9OmkMSefh4b9SbpuMsuEHGYz++tN+RCwYUAJP1fDRkjxHlich/jbocwb3hVmnrb6N6FxZVtJTZSTjA3RMpx1tytsa1Sqiz7SsATWwI3o8aRG7mbELzVlrBJu4lPh7FQxdItra/ewG0OFmAr7g+qai8CoUD28GH7vpmA0sVB4vs99ib4Qmp6ZTJ3Z5LICDz0P1zyEcF9vDRsu6noQtxIHmKjLfzA7+lN9rTPYxu7epSE40II8IuyUkH1OTjfUOu2JPhBckTYVMtfK8JI2fU8K4tMjHkmzntqOEC7AG+Ep6tsYs6CSOLCiXIKoGaBIUhsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHln2u6H89/lhot0VcYgtLxC9Hbdtn6nOu1bVineaGU=;
 b=JQq7YVPs7KTZZTQT7yaMrcGBPb00yYb5nJQzX7bpVWmRXk7rzXXzFLXMG1toH/YeGQlOZV5BGuJLXapHYbdm6do2WgTLum8jzJIN4zYIWlXxtHWoP8tXh3573VE280+WHYOVBQcVjAbZJ/giPGJMWXR2nUO5/OYMbhiaQpY4bw/Vbd8AsIDIieW9oFPq3z4K+0NGIeakejeQoAlz+IzOGtIfnEaG1Y1AmDvtRux/I5NUhut1C43SQD5WBnVh4tTAgYOCbLjObmSdsyQcHtbIQndplrb1VS0os240IV5pXC9h8FhHYG5envgUUjv/oRoXljhNShvUNfeWzF0Y+xPHkg==
Received: from SJ0PR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:33b::28)
 by IA1PR12MB6307.namprd12.prod.outlook.com (2603:10b6:208:3e5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Tue, 9 Jun 2026
 11:28:49 +0000
Received: from MWH0EPF000C6184.namprd02.prod.outlook.com
 (2603:10b6:a03:33b:cafe::52) by SJ0PR05CA0023.outlook.office365.com
 (2603:10b6:a03:33b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 11:28:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6184.mail.protection.outlook.com (10.167.249.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 11:28:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:28:32 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:28:29 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 27/31] hw/arm/smmuv3-accel: Introduce helper to query CMDQV
 type
Date: Tue, 9 Jun 2026 12:25:48 +0100
Message-ID: <20260609112552.378999-28-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609112552.378999-1-skolothumtho@nvidia.com>
References: <20260609112552.378999-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6184:EE_|IA1PR12MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: 16763b6b-bcd2-424e-9afd-08dec61a46cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|11063799006|18002099003|22082099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: AZo8kLhjrOlb5WAqbTiTE7soFgQ1ir8lReLoI+L6FWTi4u7eDEaslhmpcc4i+LXsNSwkQE3tJw3qYkNOAygmXDJheApKY1gUiPPCKgKR7RsQvNe3oEuI6nmXPp6TWQl+TwHTMmsiEl0p+E5iOi6tCXEJizPc6SyJx+teOqM58jmU9HQvEvny6WQmz6vI2+WJb/9cwmO3igAWBMCm9fHNQByB1GINys67QlNtPnp11RKfI8tUCE3EEhoQNOF+yRKL9VI/WjKGdPchz1O1wgZvHFdXM9F1UU2Kh11sULW0Qv6vEvG9wXXtIkg/LFnh30r/P7ZtwylgYp75ZQaeLL288iE0PYOlZa767J415UOuyRGYz2hUoyngf6qbwB5gIIjz99wAT77nYT9dmQynjgaLVimgzeOFizI8QYNPoDX4fW50+NTFBMUTjpMkwfrtWvPiL4wzHKqS3P4v4nDAOH6dww5lldch7x8AW1lbPd/fngqIOn+ljZv8nM7SQQr6r9NOEbaccwholSfTAupRB642Pwi9dyci0mJpLHCp67xGSSD6SK7h4BQVQGI7ETx15gsWpv0auXKGvIBPcpLY8ddZLthOq+zfl5zVcowmfnmB/RAdXRqHbKMCqkgjG6kVgYFRt+g62FaOVHDquV7idMHdhTansgpcJVpjMJ1KPvKGG12nw0vsK2n91oJO7uX1M1kafJ4x/BlER2tWwRoe7lmfSC+xvOqSTvDilLfRx2NlVRA=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(11063799006)(18002099003)(22082099003)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DAXWN3VO04qP4PcUkCOCNtSnFpL04JBGEJ1XLUITWN8MlYpyc4NODVYoOonQ2sXHKVEez2dJpWmhYd4se48iIsPV45MOu7ypwhc+YIPGzQeU26NQDN1kKysx5eJPBIiz98hDixwm8dBSrawq3R7DGPNd2Ap+gMXdbqCShkcHafA4HZTVBGqHai7hgivGY/AX9F0jxWUN1pILCHz7KsWafAetefWkNPpYnD/cFTD2+mxhws9ixhjXCxcdPNXJdN7hG2vdH887qI/drNvlmx8GKY1KPqwQZGeOkpTomKnqd/jQBlvc+T6sWIdpM+B1Uh29p6kvWU0BVSTnchj52LaNQYBYsxfQGQNd8yoionaIDMeD3GR1EhJlGmP/EWaqzWQgASKHObKFia9cdpfL4BbAUdbNobTF0jXALD/bhAcL0/5MwUscV2fW/WBNbqPZ3HNE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:28:49.1032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16763b6b-bcd2-424e-9afd-08dec61a46cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6184.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6307
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.h       | 10 ++++++++++
 hw/arm/smmuv3-accel-stubs.c |  5 +++++
 hw/arm/smmuv3-accel.c       | 12 ++++++++++++
 hw/arm/tegra241-cmdqv.c     |  6 ++++++
 4 files changed, 33 insertions(+)

diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 8d0f636338..5fc85fb89d 100644
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
@@ -42,6 +47,10 @@ typedef struct SMMUv3AccelCmdqvOps {
      * If NULL, the viommu_id is freed directly via iommufd_backend_free_id().
      */
     void (*free_viommu)(SMMUv3State *s);
+    /**
+     * @get_type: Optional callback. Return the CMDQV implementation type.
+     */
+    SMMUv3AccelCmdqvType (*get_type)(void);
     /**
      * @reset: Optional callback. Reset CMDQV state.
      */
@@ -90,5 +99,6 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp);
 bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
                                       void *buf, size_t size, Error **errp);
 void smmuv3_accel_reset(SMMUv3State *s);
+SMMUv3AccelCmdqvType smmuv3_accel_cmdqv_type(Object *obj);
 
 #endif /* HW_ARM_SMMUV3_ACCEL_H */
diff --git a/hw/arm/smmuv3-accel-stubs.c b/hw/arm/smmuv3-accel-stubs.c
index 9e6c44a282..147ae06163 100644
--- a/hw/arm/smmuv3-accel-stubs.c
+++ b/hw/arm/smmuv3-accel-stubs.c
@@ -57,3 +57,8 @@ bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
 void smmuv3_accel_reset(SMMUv3State *s)
 {
 }
+
+SMMUv3AccelCmdqvType smmuv3_accel_cmdqv_type(Object *obj)
+{
+    return SMMUV3_CMDQV_NONE;
+}
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index c1c2a67c97..9c3bd4413d 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -1060,6 +1060,18 @@ static void smmuv3_accel_as_init(SMMUv3State *s)
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
 static void smmuv3_accel_machine_done(Notifier *notifier, void *data)
 {
     SMMUv3State *s = container_of(notifier, SMMUv3State, machine_done);
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 4b8f8b15c7..d821eafca1 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -964,6 +964,11 @@ static bool tegra241_cmdqv_init(SMMUv3State *s, Error **errp)
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
@@ -1004,6 +1009,7 @@ static const SMMUv3AccelCmdqvOps tegra241_cmdqv_ops = {
     .init = tegra241_cmdqv_init,
     .alloc_viommu = tegra241_cmdqv_alloc_viommu,
     .free_viommu = tegra241_cmdqv_free_viommu,
+    .get_type = tegra241_cmdqv_get_type,
     .reset = tegra241_cmdqv_reset,
 };
 
-- 
2.43.0


