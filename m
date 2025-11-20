Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F41CF885A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 13:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4fr-0003KJ-A4; Thu, 20 Nov 2025 08:26:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4fc-0002gI-Nr; Thu, 20 Nov 2025 08:25:57 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4fa-0002go-V7; Thu, 20 Nov 2025 08:25:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxlt7hIWNgKArtxHlTKrsvg3EESGoll9JlnBSLtLT3gnSHg9h2nyz0Rz7tGQwaJAc/HT5lBilICZ0X6tlNlClsdNsLcybLjGcAR/bWatN3GAPlLtHHROGbAuayXmY8+jWA/8vu8FgvmVPXqPR+O9WZKZiuB+2sfXEh6TmV3VrMNrE0CHfBqd4xd3qcVPw26Xifm4h4emTFHuvDtVtPn6u2m3M75Txvz8mg40to4F9Dur4I9qTXRIKfjA/8HEVDBR+gnqpAD7Q+e/8F6CwE8ayzz0Br40bf1/NJBw6lm4lOV7tim1RWMXAHm/97hNZT8RKHOZFg4yLVsQHrqk1v/L6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ss901bjrvwt7gRrQjwzYzaAa9EWuxaVCzPnkNPPdSeM=;
 b=uC/pq6tph8c1gXqYBD9IS9rK8HEdQranLnwLDuj3IcmNhYKiDGG8ioFfupz3tNI/tM9OtWYLZqPTt+bo9rX8SVtVO4fddMD7no0cAphI+/e/eErcYdWMk2aTUlDVNMflZ7k/mkZAZlWu6M3bh9a1qpHpeD42chqTeC6Bovft5YpL/RimkAb79ySloH94d9ierRu9uydm+Tkek96HK7CAyrBDXlQ7iGSV5cug0yzRmp38ZKOGtaLexeD8kdAju5quF4IYM766HZyOQe0bN1cMADZ8i8dg+sD0y9pNPxufrSUwJu3NEw2cTcqqePtQkkCR81pmTZDTZW3aPHXC5XkjmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ss901bjrvwt7gRrQjwzYzaAa9EWuxaVCzPnkNPPdSeM=;
 b=bnIcs3HyJyAU0FiDsV0nFWKjaO7q7jnWi3SQNNE/SSn8rVnkAWNgsAUOuA58rDjBynxkrHXTfLgh1pg5O97P3trF4+f56Vw+VXrBZCvF09nohNcHuLdGQknse7EavTk7dzLAaUfFpyOy0czFXdkYPDjTSSO0QTSwLNUNl1cPqWurxQjS0goGJxWFMk4XCFEb70Sk8WYaesbTUiVCU+Irx0Pm44HwwQpOzE7+SeMEKa5aIass3fCbxg//Ebj34q5ZmKcIcxtPeJUsNpDo2i69lojs5BmftWfx6qJXsJBT4OZjLa0OfCEpBkws3wDWt4LdE+8ioVfTDvKcMMMygxh8Zw==
Received: from CH0P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::26)
 by LV2PR12MB5894.namprd12.prod.outlook.com (2603:10b6:408:174::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:25:47 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::66) by CH0P223CA0011.outlook.office365.com
 (2603:10b6:610:116::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 13:25:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:25:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:25:31 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:25:28 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v6 31/33] Extend get_cap() callback to support PASID
Date: Thu, 20 Nov 2025 13:22:11 +0000
Message-ID: <20251120132213.56581-32-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120132213.56581-1-skolothumtho@nvidia.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|LV2PR12MB5894:EE_
X-MS-Office365-Filtering-Correlation-Id: 34dfc9b0-4081-4c7d-151c-08de283850d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GvH1aQENilXZNtNx1q9J4QjQSML921UMlDSO9FPDoMElSqT6apzdgs120oBp?=
 =?us-ascii?Q?Iw21oNTcRFTb0yqq6xazy2tMvkEPnf8CIKnXMfAntHnlcNuel7tyWdoxNO1+?=
 =?us-ascii?Q?v0m8aH3PfPsZld7GPAZVeYN2wK05syh9l300kqGJWJP7F1zyUTHenQm2EQQ7?=
 =?us-ascii?Q?BCw+CgDmu99R4QKlmAR/Koe/nu7sc90OrZtAgp44QH3zju0QFOKtJvea+xeX?=
 =?us-ascii?Q?KhS4x2q3UmXHr9bfDbrLJNm8Dcu/NjWpc4IHPTu9lk5G7W/lHKUxwjCmVHkZ?=
 =?us-ascii?Q?O/cT8COKaE+8xu/GU3cTB6vScudCFADWK19iLSQKLci9jTQVMibpzB1V81T9?=
 =?us-ascii?Q?8ng8WslS60e8Du74zOqwcolOfIaaRRWdM7SDswZM9HfWDKkP+yAqdhmfks+1?=
 =?us-ascii?Q?xi4c+01UCkd2XvTpprq2ShxY8tbLhx1hGSL8dMz/KKzjlp8Z7/SHYUWXD9Tk?=
 =?us-ascii?Q?N0vFTzrZDwvizM9rshWpWjpqi8RdDU+9D6M+5WOqnckjV6q0Bq5NRK6XZodQ?=
 =?us-ascii?Q?qL9gEqbZ47cV+n4Lf0fRXZB4Zi1MQAK0T2bsochJ/wsRUKQ1yvXYZJiEzeLk?=
 =?us-ascii?Q?+H8jnR1An7afNmUVSMrdKZRIX168pJ+zoWfGhVrtAEypJ8xgCTMYh2awQCbL?=
 =?us-ascii?Q?pdKLL9bqH4C9h1LZYzIWIE75bKdReH7Svjwv1kph2it4t1XfY4L82nolVcXI?=
 =?us-ascii?Q?H7CS8Jarf5dfGvswlSZmY1vHTLXPQq4oqDsb01hTPWF0Vd775wnSvyTyh4TT?=
 =?us-ascii?Q?W6ltp/G2G6QfYHzygVmmCMWUyIlv2kG1iHQpOjrlYqgtdiMfA0CA62Pq8C8+?=
 =?us-ascii?Q?dpc6oMVNQfA9pkZwAo0haxJrGlsl66ZVkGJgm0zVzGQ/d7tomf6i8wsXnq+F?=
 =?us-ascii?Q?WcO/+JWmOq0p+OhfCJfltEIsULepHcbm3fwIoJgLnooUrJ6teODO2p6wbHjG?=
 =?us-ascii?Q?M8LLuK+rVorm/BvFDHjQ0DAodgDPihuND0XB2oNFOJMoRi8RAGErgURx1ywA?=
 =?us-ascii?Q?3UW4xWilqizfeCOmG65MDlPsV8XDvn2ypUy+t4csu7KJM/AKnSIqCDmy0ro7?=
 =?us-ascii?Q?0t0IOK/IEmbUvFy6Ej7mZMmkJVfrd45oUj4UgNbrA/xdcsCJgez4wvWipQAV?=
 =?us-ascii?Q?rw3223q1oHpBhGB9GPBugEeNoTvfSQxMQAhsD0l6L/QBEM0MfeW8T49qRPZK?=
 =?us-ascii?Q?GvuT/dFSxFpzl9ikkbWp0EJFyPqenBW+6/YQa4db03k6MOY0LdeJqRVK2HEp?=
 =?us-ascii?Q?PYFuw3vNDa40RkbL/W5S0wjpf8gB2fyWeuV4PzvkHlsYo7PgFWOYvE6QrQuy?=
 =?us-ascii?Q?tZ5K00niHQguh/xRBfa8n7wyV2WQxXcl8dSFe2NNR+FW0YLBmQsfxOW+8+aB?=
 =?us-ascii?Q?nty/VsYwLs6xJBBYgsmtjcW2ioupx2TH5EY2j48iwVJZDBqUVP5tq5UB5TVJ?=
 =?us-ascii?Q?CN5L8V8bnVKA1oSsGWrDdVZic0DvaziGh0CTdfybymO6+K7388+ZmfMrXBbm?=
 =?us-ascii?Q?CcIMjinirWB9Ey3lx/BBhNfBUCK4SDL3GcAzb9g0ZK+NV/udmDWOlBKu3AqQ?=
 =?us-ascii?Q?O3+DMNUXMcYJeZt5jNM=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:25:47.0962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34dfc9b0-4081-4c7d-151c-08de283850d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5894
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
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

Modify get_cap() callback so that it can return cap via an output
uint64_t param. And add support for generic iommu hw capability
info and max_pasid_log2(pasid width).

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/iommufd.c                 | 23 ++++++++++++++++++-----
 hw/i386/intel_iommu.c              |  8 +++++---
 hw/vfio/container-legacy.c         |  8 ++++++--
 include/system/host_iommu_device.h | 18 ++++++++++++------
 4 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 6381f9664b..718d63f5cf 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -523,19 +523,32 @@ bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
     return idevc->detach_hwpt(idev, errp);
 }
 
-static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
+static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap_id,
+                                uint64_t *out_cap, Error **errp)
 {
     HostIOMMUDeviceCaps *caps = &hiod->caps;
 
-    switch (cap) {
+    g_assert(out_cap);
+
+    switch (cap_id) {
     case HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE:
-        return caps->type;
+        *out_cap = caps->type;
+        break;
     case HOST_IOMMU_DEVICE_CAP_AW_BITS:
-        return vfio_device_get_aw_bits(hiod->agent);
+        *out_cap = vfio_device_get_aw_bits(hiod->agent);
+        break;
+    case HOST_IOMMU_DEVICE_CAP_GENERIC_HW:
+        *out_cap = caps->hw_caps;
+        break;
+    case HOST_IOMMU_DEVICE_CAP_MAX_PASID_LOG2:
+        *out_cap = caps->max_pasid_log2;
+        break;
     default:
-        error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
+        *out_cap = 0;
+        error_setg(errp, "%s: unsupported capability %x", hiod->name, cap_id);
         return -EINVAL;
     }
+    return 0;
 }
 
 static void hiod_iommufd_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 78b142ccea..d5c131a814 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4605,6 +4605,7 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
                            Error **errp)
 {
     HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
+    uint64_t out_cap;
     int ret;
 
     if (!hiodc->get_cap) {
@@ -4613,12 +4614,13 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
     }
 
     /* Common checks */
-    ret = hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_AW_BITS, errp);
+    ret = hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_AW_BITS, &out_cap, errp);
     if (ret < 0) {
         return false;
     }
-    if (s->aw_bits > ret) {
-        error_setg(errp, "aw-bits %d > host aw-bits %d", s->aw_bits, ret);
+    if (s->aw_bits > out_cap) {
+        error_setg(errp, "aw-bits %d > host aw-bits 0x%" PRIx64, s->aw_bits,
+                   out_cap);
         return false;
     }
 
diff --git a/hw/vfio/container-legacy.c b/hw/vfio/container-legacy.c
index 32c260b345..1acf063762 100644
--- a/hw/vfio/container-legacy.c
+++ b/hw/vfio/container-legacy.c
@@ -1203,15 +1203,19 @@ static bool hiod_legacy_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
 }
 
 static int hiod_legacy_vfio_get_cap(HostIOMMUDevice *hiod, int cap,
-                                    Error **errp)
+                                    uint64_t *out_cap, Error **errp)
 {
+    g_assert(out_cap);
+
     switch (cap) {
     case HOST_IOMMU_DEVICE_CAP_AW_BITS:
-        return vfio_device_get_aw_bits(hiod->agent);
+        *out_cap = vfio_device_get_aw_bits(hiod->agent);
+        break;
     default:
         error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
         return -EINVAL;
     }
+    return 0;
 }
 
 static GList *
diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
index bfb2b60478..4e891e5225 100644
--- a/include/system/host_iommu_device.h
+++ b/include/system/host_iommu_device.h
@@ -88,19 +88,21 @@ struct HostIOMMUDeviceClass {
      * @get_cap: check if a host IOMMU device capability is supported.
      *
      * Optional callback, if not implemented, hint not supporting query
-     * of @cap.
+     * of @cap_id.
      *
      * @hiod: pointer to a host IOMMU device instance.
      *
-     * @cap: capability to check.
+     * @cap_id: capability to check.
+     *
+     * @out_cap: 0 if a @cap_id is unsupported or else the capability
+     * value for @cap_id.
      *
      * @errp: pass an Error out when fails to query capability.
      *
-     * Returns: <0 on failure, 0 if a @cap is unsupported, or else
-     * 1 or some positive value for some special @cap,
-     * i.e., HOST_IOMMU_DEVICE_CAP_AW_BITS.
+     * Returns: <0 if @cap_id is not supported, 0 on success.
      */
-    int (*get_cap)(HostIOMMUDevice *hiod, int cap, Error **errp);
+    int (*get_cap)(HostIOMMUDevice *hiod, int cap_id, uint64_t *out_cap,
+                   Error **errp);
     /**
      * @get_iova_ranges: Return the list of usable iova_ranges along with
      * @hiod Host IOMMU device
@@ -123,6 +125,10 @@ struct HostIOMMUDeviceClass {
  */
 #define HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE        0
 #define HOST_IOMMU_DEVICE_CAP_AW_BITS           1
+/* Generic IOMMU HW capability info */
+#define HOST_IOMMU_DEVICE_CAP_GENERIC_HW        2
+/* PASID width */
+#define HOST_IOMMU_DEVICE_CAP_MAX_PASID_LOG2    3
 
 #define HOST_IOMMU_DEVICE_CAP_AW_BITS_MAX       64
 #endif
-- 
2.43.0


