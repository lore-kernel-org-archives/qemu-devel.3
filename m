Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A69FCC44506
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 18:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicUW-00036y-HV; Wed, 21 Jan 2026 12:59:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicTv-0000ao-Oj; Wed, 21 Jan 2026 12:59:07 -0500
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicTs-0002Fs-JO; Wed, 21 Jan 2026 12:59:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1/TGdWNXJ7FPXxIhifFtOq2jg8VeIzMIplPV6u20YDgUj5WtGhc0LH5/WW8VSMZRYubKOd/j8r1LX9IBTqPtgp/kmcIevJ2wGczwlFchDXeZXh8ahGOX7zPkki7jJX0u1XCrarfK7xJg+bIInu4V2LPMLgFtXY2aOAGziomLwDX/1Tw0MQqwFBCDwSnVay6WQhmeo2VnssZYl9HjmOKHshlRKJOfet2WXRLxfjeE2eCYju3Ymf/bbH3rmaoNJpHhoIE7UuZKPf6m1cC0x0yCLdi11aIDVoAcXUOSd0A/6l4+MAsy8ZqnC1EHQ9gC63xlkq6ibwj4CLu7PEyY2XXLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ov4tQAUHPzrhFsFrfKxGL6wrulTQ2yGB8yRjycHkvuM=;
 b=yODJHLQqvJatFewQdMyGrD6lY/EkmcwXEls1MRmnOCZwnN6sKWjD+/nsOpvGfOhxD48fPz9swVhDlCqnp1HNrkcOLbF6QHFPLcbRJlQoHpTwbb6rocnAOI6NcYLaRkvER/BCkarM88Ey1n7NieHs4Wo92zgtdWJ3clmz+5T1mbjj6ukNkilVSECn5inuCMqN1AHegVP0YABWVBYnW/V1DBq70U+ZcOCJ5RvbFyDtkn3/yZSUSrbbwEtdDLpTzKnwY33FR8AViYkLsBFOr5YyJJsy8jFlfJ88xtvXt3z3pzAZv0RVFw35jy17ptLXSbn21/YOvxfYVBZAqR6LPvtHtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ov4tQAUHPzrhFsFrfKxGL6wrulTQ2yGB8yRjycHkvuM=;
 b=NNomd51BviKmGYSpF7JAbiPvZ2KCHG4OSxP1EYk34Z1l/mHQg0mWWr2kzLTmd0zqBx7z4M51C8AcAf/p+eoOHxUAFYGwW3fe+ri1aJM0dNMBTFRpdnp7fPBPpIXhwzjb39MFr0jl9BGmwDNa8MB9SCXiUe1eKgaBdjTS+BKO71U8K1RRAeKqqyXSOshz4iKa7vgKfA8z4SMd5BnsDm5TcQvrTLjBm81EVmrazzS6Km3B2ctoK5yeubFvUMjbJzePnHBUEePTWCFkpFt8AxBUffOa4ACu/l6UM1NTtgxWb6t/FgJwojmI3J6qBRLXyghdD+cFQXxaYxqCWAcGa1Pkug==
Received: from BN9PR03CA0287.namprd03.prod.outlook.com (2603:10b6:408:f5::22)
 by MN0PR12MB6001.namprd12.prod.outlook.com (2603:10b6:208:37d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 17:58:47 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:f5:cafe::39) by BN9PR03CA0287.outlook.office365.com
 (2603:10b6:408:f5::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 17:58:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.0 via Frontend Transport; Wed, 21 Jan 2026 17:58:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:58:25 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:58:20 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 37/37] hw/arm/smmuv3-accel: Make SubstreamID support
 configurable
Date: Wed, 21 Jan 2026 17:52:42 +0000
Message-ID: <20260121175248.87649-38-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260121175248.87649-1-skolothumtho@nvidia.com>
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|MN0PR12MB6001:EE_
X-MS-Office365-Filtering-Correlation-Id: fca8c885-176a-40c8-8ffe-08de5916b984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|7416014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HGhF6oCTw4zyVPFjC1zEzrJnFkxVidwQEm1jfAtK5P1QiN+sLCY3LFtlZ3A4?=
 =?us-ascii?Q?Hisq+2ug+BwJt6WIyBXrHpKTO4HWJVc3Ae3ieue6QX8PqofinFkN6m+wkwcO?=
 =?us-ascii?Q?owHhtO+IlHqhtDgRz8X22biWvni2DYNX/CslbeC3oPJAiIKf/sQXtbXZ54km?=
 =?us-ascii?Q?HEoVxqmEN2zOIxRpjTqUbQa9eJB5+M7LqExiWkb51sOl0E0yvzAWPn+9AkTu?=
 =?us-ascii?Q?lB/feUr5wP0dvLCEj6O4vXOcPxVJiOqGGT49dFY/guSmzJ9l3wsVcTbhApWU?=
 =?us-ascii?Q?zpHBuQ4PPqWrS4MIfdUEi2OOEuY/Upk+dDtn46Tfuvq9WFDAlwpOB/02OBw4?=
 =?us-ascii?Q?ODKnpGfpw3b3dluxvQluX33TBNsoIBDKuxdPGvbuD/8AxcCc1HA5lZyIhfyb?=
 =?us-ascii?Q?1Ns+bRi4MQm8Uyesma4scvi306al8aDA4Z9GzrtvGlalJoxQW8UHL5+bN0jP?=
 =?us-ascii?Q?XgHth6MNS/aRjQCy9u5pxdd6NQTMY9GT1t1Ma1MYEENauw3NPcaln7Q0Qgmr?=
 =?us-ascii?Q?2NO3ENRtQx0KuaW3YzD+5Ol9Ljte5VlXnnTs8U+TUP5KQoUn0aK1Tev7gJDC?=
 =?us-ascii?Q?B6d3h8LRJ1R9U2djDKCw6MDSioqbUTuFiqeFa9EtSbWosd1yxBagXDIXu5ta?=
 =?us-ascii?Q?MLmfgJmYYQtPCr2Wy4IyNNgHQPCrkklwJX26jJWf3s/Xr0kNSnumShZO1NqU?=
 =?us-ascii?Q?75WDXeFk4vIF88EDrJDb+2vX7HtbOIXXSag6dHbMx+rDvIpBDPxCEQTpuYOJ?=
 =?us-ascii?Q?eSUi1JnVN0A2n3jhGwpb4IKNbNfwzJstR6EWUqbGRa/krcJoPn/PZLjVEpNx?=
 =?us-ascii?Q?WuQLV4AgPdgzzPtMwKbNQD+sThElpXq4x++7EYOwLsDNHghKkQBT0SOnX4JS?=
 =?us-ascii?Q?umMBRBdlnN8+hkNS4tX+of1oxEtZldBji0I796x4vV2DeSGQDDI3Q+6AeIdZ?=
 =?us-ascii?Q?cN++y8aakJwMO/84j4LrBmQjYgsf0DMe52D714WY/Chzjk8zdiRh2GDxVPX1?=
 =?us-ascii?Q?igCS6877/TYFmxZoN28iNGICkv6dbBAgC8qbG49i4LJVCW3G78djOhCS3Ode?=
 =?us-ascii?Q?ieH4PQpKhHzFmQHpaU9qdWBmQDLmDhoZ+SWvW/xar3grUMdJXpIzAWoOaq5n?=
 =?us-ascii?Q?s9L1TIzztGoxO4ehXoTLTsv+RXjualO+0u+qenmztcDAsKhSt8RFprMtlA9B?=
 =?us-ascii?Q?rtLVxt5ISB+dPfFMyiPgOHQjKIepp1tY2DpkcJM7boJTZOjc4KegenreED4Z?=
 =?us-ascii?Q?DIz8bmN/qn8i209T/9+FYpCN3bpt8LbpVvtzz/d6ovOeq5lpMVte4/byW9SL?=
 =?us-ascii?Q?xlAl6RO1R0XtURzM33vz3jI4WkgrhWWd5LHGZN3qIJnxOLKwMmvKfW9FW7bx?=
 =?us-ascii?Q?I0qK3OeYNL0dsTzaMP/9V5UGd0pjiRIcMbXRU951BA6teVTyj7WHBt8w5sEp?=
 =?us-ascii?Q?ttVRT23sVt4MPyosZH4jf7GLEBpt4DxuI5for5fZViNRfZOB+2KKShkM5ovI?=
 =?us-ascii?Q?1eoTYWL8NTzNYzCAaqtoIOe7LgLXUxwGcahOu1vbrOya8P3TeqqxlmDfySHT?=
 =?us-ascii?Q?p07ka2X7HSy3qmqzALyTbiZRKjXlnNKfmn/QVqtSlJky9IptJR5XLbdE9RTK?=
 =?us-ascii?Q?+NGTy1iXoP8CG6O1blzCg/lFfJAgZltLeCdJy82D9rXLpmlTD3ny2d085fIH?=
 =?us-ascii?Q?awvcjA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:58:46.8052 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fca8c885-176a-40c8-8ffe-08de5916b984
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6001
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
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

QEMU SMMUv3 currently reports no SubstreamID support, forcing SSID to
zero. This prevents accelerated use cases such as Shared Virtual
Addressing (SVA), which require multiple Stage-1 context descriptors
indexed by SubstreamID.

Add a new "ssidsize" property to explicitly configure the number of bits
used for SubstreamIDs. A value greater than zero enables SubstreamID
support and advertises PASID capability to the vIOMMU.

The requested SSIDSIZE is validated against host SMMUv3 capabilities and
is only supported when accel=on.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c          | 25 ++++++++++++++++++++++++-
 hw/arm/smmuv3.c                | 22 ++++++++++++++++++++--
 include/hw/arm/smmuv3-common.h |  1 +
 include/hw/arm/smmuv3.h        |  1 +
 4 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 342944da23..f5cd4df336 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -76,6 +76,16 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
         return false;
     }
 
+    /* Check SSIDSIZE value opted-in is compatible with Host SMMUv3 SSIDSIZE */
+    if (FIELD_EX32(info->idr[1], IDR1, SSIDSIZE) <
+                FIELD_EX32(s->idr[1], IDR1, SSIDSIZE)) {
+        error_setg(errp, "Host SMMUv3 SSIDSIZE not compatible "
+                   "(host=%u, QEMU=%u)",
+                   FIELD_EX32(info->idr[1], IDR1, SSIDSIZE),
+                   FIELD_EX32(s->idr[1], IDR1, SSIDSIZE));
+        return false;
+    }
+
     /* User can disable QEMU SMMUv3 Range Invalidation support */
     if (FIELD_EX32(info->idr[3], IDR3, RIL) <
                 FIELD_EX32(s->idr[3], IDR3, RIL)) {
@@ -652,7 +662,14 @@ static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
      * The real HW nested support should be reported from host SMMUv3 and if
      * it doesn't, the nesting parent allocation will fail anyway in VFIO core.
      */
-    return VIOMMU_FLAG_WANT_NESTING_PARENT;
+    uint64_t flags = VIOMMU_FLAG_WANT_NESTING_PARENT;
+    SMMUState *bs = opaque;
+    SMMUv3State *s = ARM_SMMUV3(bs);
+
+    if (s->ssidsize) {
+        flags |= VIOMMU_FLAG_PASID_SUPPORTED;
+    }
+    return flags;
 }
 
 static const PCIIOMMUOps smmuv3_accel_ops = {
@@ -680,6 +697,12 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
     if (s->oas == SMMU_OAS_48BIT) {
         s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_48);
     }
+
+    /*
+     * By default QEMU SMMUv3 has no SubstreamID support. Update IDR1 if user
+     * has enabled it.
+     */
+    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE, s->ssidsize);
 }
 
 /* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index cb02184d2d..c08d58c579 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -611,9 +611,11 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
         }
     }
 
-    if (STE_S1CDMAX(ste) != 0) {
+    /* Multiple context descriptors require SubstreamID support */
+    if (!s->ssidsize && STE_S1CDMAX(ste) != 0) {
         qemu_log_mask(LOG_UNIMP,
-                      "SMMUv3 does not support multiple context descriptors yet\n");
+                "SMMUv3: multiple S1 context descriptors require SubstreamID support. "
+                "Configure ssidsize > 0 (requires accel=on)\n");
         goto bad_ste;
     }
 
@@ -1954,6 +1956,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             error_setg(errp, "OAS must be 44 bits when accel=off");
             return false;
         }
+        if (s->ssidsize) {
+            error_setg(errp, "ssidsize can only be set if accel=on");
+            return false;
+        }
         return true;
     }
 
@@ -1968,6 +1974,11 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
         error_setg(errp, "OAS can only be set to 44 or 48 bits");
         return false;
     }
+    if (s->ssidsize > SMMU_SSID_MAX_BITS) {
+        error_setg(errp, "ssidsize must be in the range 0 to %d",
+                   SMMU_SSID_MAX_BITS);
+        return false;
+    }
 
     return true;
 }
@@ -2096,6 +2107,7 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
     DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
     DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
+    DEFINE_PROP_UINT8("ssidsize", SMMUv3State, ssidsize, 0),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2129,6 +2141,12 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
     object_class_property_set_description(klass, "oas",
         "Specify Output Address Size (for accel=on). Supported values "
         "are 44 or 48 bits. Defaults to 44 bits");
+    object_class_property_set_description(klass, "ssidsize",
+        "Number of bits used to represent SubstreamIDs (SSIDs). "
+        "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
+        "Valid range is 0-20, where 0 disables SubstreamID support. "
+        "Defaults to 0. A value greater than 0 is required to enable "
+        "PASID support.");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
index abe3565357..67a23fbeaa 100644
--- a/include/hw/arm/smmuv3-common.h
+++ b/include/hw/arm/smmuv3-common.h
@@ -311,6 +311,7 @@ REG32(IDR1,                0x4)
     FIELD(IDR1, TABLES_PRESET, 30, 1)
     FIELD(IDR1, ECMDQ,        31, 1)
 
+#define SMMU_SSID_MAX_BITS 20
 #define SMMU_IDR1_SIDSIZE 16
 #define SMMU_CMDQS   19
 #define SMMU_EVENTQS 19
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index d488a39cd0..26b2fc42fd 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -72,6 +72,7 @@ struct SMMUv3State {
     bool ril;
     bool ats;
     uint8_t oas;
+    uint8_t ssidsize;
 };
 
 typedef enum {
-- 
2.43.0


