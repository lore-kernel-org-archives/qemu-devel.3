Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4AFCD5BA3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHsi-0004oq-Ha; Tue, 19 May 2026 06:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHsc-0004IR-Nm; Tue, 19 May 2026 06:40:56 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHsa-0007Nl-5Z; Tue, 19 May 2026 06:40:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YuoSGpOJfnqCqy3pe/o4KfRGxsWsk/lJuZ8ALoB47gjv/tI0O5ocjvzmY7H28706VxjpJkhud8syPfmiOioiRlCnMxAjZyG/L1Pyc8/IghkSLVcVpKJ9lutxse7oIKeXLOjIeuxojVzgFAfBPJlo4a0qGs1QCO/aS/5QIu/wfJ6KRS8BhoaIEqfCHBxaADOvM3ZCIRzkkR9dxhBURdpP6mfTJJXylmE/3u/SexUIdgeGmtebUnEWZ9CZYINwJnQZfIzRDZut17L7uLazGRVBB07ypgHRiVQR26QTCUqd+oadWRXhf09qomm7+Ow8ipl+H4LRtu+C91F6cu0TjRpOkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csnaU1L1lmT41Vlcpt1LTf0U7LQSrClrSWBlpVr47Gw=;
 b=COevizZLYwX6iISpL4qv6DxZCROAL5xwu63CaYvVdo5NfZMu2v7ma/70Ux/0CGldEfwEsHIM7SWaEdX389/p7jjatbJ4dXmlSunRpnVHu6gTZSvSk51X4T55LpKsl1cRPOOoYfG+ofQUPx2iB6naAp5Emr9/14O3gqt9J6O7KGghKPDERCwjpIMqC63Fqh8Te7A88O/8ueQPR1mT6JVN9OwChINQ6rX13meAn93jBS4dRq4063Faj3D0ClII7f+IYSL5ejy4sb8+xz7J2GylBhgfZYYRzCpGl/LJw1oRdVTMLbDC7kguJWhjbk2aM7XMvsGT122cYVdTWzbeVsdbxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csnaU1L1lmT41Vlcpt1LTf0U7LQSrClrSWBlpVr47Gw=;
 b=eeyK2la5cAQBiO3+rd+DP5One8YEzXULLAKZRh44Zt88BA0UBPq8Uxbhyf+zDoSho6pWtf3nnloJiYD4TI2GybOzlhgf6aim4s84UXk/nRNq7TC/UbwamZeex9AIIF7NbJ+VtWpiIVqPaYP515zc9PbzVfuthAOyCBmVTOldoK3xp3/pNpVhHSFV4amJiHVmN4s2ZY/vBbh1MihH4/H0EwvKQmSIRltoeNnCcka2RjicKCJMD+aohft5dw+oxkSoSgq1UBqFVG7RQ+K0QepLcYJ8FLmH5wsyudApVbOYv5F2VS2iVwTkFz18ON5yfXwQuQhasBgpufR5sHhzkawS/A==
Received: from PH8PR07CA0034.namprd07.prod.outlook.com (2603:10b6:510:2cf::15)
 by DM4PR12MB6039.namprd12.prod.outlook.com (2603:10b6:8:aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 10:40:42 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::bd) by PH8PR07CA0034.outlook.office365.com
 (2603:10b6:510:2cf::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 10:40:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 10:40:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:40:22 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:40:18 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 29/32] hw/arm/smmuv3-accel: Introduce helper to query CMDQV
 type
Date: Tue, 19 May 2026 11:37:07 +0100
Message-ID: <20260519103727.899332-30-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519103727.899332-1-skolothumtho@nvidia.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|DM4PR12MB6039:EE_
X-MS-Office365-Filtering-Correlation-Id: c648c5c4-3ebc-4f2e-de03-08deb593131e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|11063799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 0TyooU6VO8eiL7oRq0Q7dtkUANrxB2NXM+gAeb0NL06hlWNgo+7En5iJc+aEfBrUgsTTqnnohdM2aqQCWLYQpEHc82N7b7NKfL/Pw1cXGsQ2pUG+HahNv1h9zzXn1rr84rNw3KEVs6QqUrIHIIqiqMxmiu0Uybh7bMvrQVr4p38bsJ0sRAMSFiFWk82N5VU/zEOS3WsFYzyYhvL9IAC4PENg235TCYFWawMMXJs91AkOcja043qXr89oCvrx2hR0W5rcXGkl7GceeR6SRmnK5qwf8cJGQvvDKkuMqE2sgL2z+/6+TgqpAHOdMNfSrvu7JDKnfXtV7iT0aOQQcP00UApvQyYRYEkQIvMHfl5xEhS/WadTzk5LRgb2URNmX8DiISXjuegrzk4epjQr2kbnvHeO/mtDUNfPwpmW0sO/J7W10DWaXNOxAe2RyjO36fJ5hAbrSeqV0kntnJvrkXtZr8QYFhsiHTY0O0aZlxlL+q+rvcXe+4daIAPbdZCgjxaX9mEdTeTSyujfbinkScNMtlzVwCWLn80Y23UlhSqR6o2/7vs4OHglRM/mDnBn7hvBQNXDlPlmd2F6Nq+y7XD6x6OMgqE4SdyrfUNKQgIZGSfDA73lV5RnFCjnPoK5YuBisWfwroi2U2AV3L+s+s+DsoNRC2ZUM37QZtOl9CBabKYVZetLdwPVU12iXdoHgUz30Qv09hWB3t0hKaDKTcwDhHi+eBCFZZJduumpb5zw2ao=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(11063799006)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X+AiB2c6r0QGzd5bEERDJT2ZvQcTH8ickMyGnMr/J7Gy1U4hdlxOeWf+ONaW2GTkjnum0kmn3OzoUMyfQzGSWkapE17iiB3Qw2UJbx3wOcjIlW4cSsLjMxnXjMMA6Co5GDfEEZd5ej5zWmGm3EfobyaWH4/v5h02F7wmv2oGTWMMmGz0r60ocB5XjRQLr3tP+apWjUl1BW0ZYgPcxWtK/Wqw6MRUiaPo5MamkdOYpT2LiZklOLZsqwHyK4jFi/RSxZITTwOXW2TcT4mR20bxLZ2fv2f0UWJOdG0TIo4sig9TZprZMUU9D9IFkyGu/kzkE2oSyxs83t979yMuzG3bLmL6oeWFVudf5Q64IHvRAJWDBf16O/Z296hE9DcxF81ZXW3A9YgAHWToXUSFXZhFJYBOrJoro1DBp28/G7XlIKsbMgTKY2IH9EWdfZIqmrSR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:40:41.7407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c648c5c4-3ebc-4f2e-de03-08deb593131e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6039
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
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
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.h       | 10 ++++++++++
 hw/arm/smmuv3-accel-stubs.c |  5 +++++
 hw/arm/smmuv3-accel.c       | 12 ++++++++++++
 hw/arm/tegra241-cmdqv.c     |  6 ++++++
 4 files changed, 33 insertions(+)

diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 241639ec8e..8cf35c2936 100644
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
@@ -43,6 +48,10 @@ typedef struct SMMUv3AccelCmdqvOps {
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
@@ -91,5 +100,6 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp);
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
index acc0ca5251..dbb50d1795 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -1062,6 +1062,18 @@ static void smmuv3_accel_as_init(SMMUv3State *s)
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
 static void smmuv3_machine_done(Notifier *notifier, void *data)
 {
     SMMUv3State *s = container_of(notifier, SMMUv3State, machine_done);
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 7f617bcc97..fb4301aa7d 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -952,6 +952,11 @@ static bool tegra241_cmdqv_init(SMMUv3State *s, Error **errp)
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
@@ -992,6 +997,7 @@ static const SMMUv3AccelCmdqvOps tegra241_cmdqv_ops = {
     .init = tegra241_cmdqv_init,
     .alloc_viommu = tegra241_cmdqv_alloc_viommu,
     .free_viommu = tegra241_cmdqv_free_viommu,
+    .get_type = tegra241_cmdqv_get_type,
     .reset = tegra241_cmdqv_reset,
 };
 
-- 
2.43.0


