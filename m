Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8227BCAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 13:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3E8u-0003z5-GD; Mon, 29 Sep 2025 09:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E8T-0003Ss-KP; Mon, 29 Sep 2025 09:41:49 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E8B-0003t2-Cq; Mon, 29 Sep 2025 09:41:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4bbSe4tGvH0yszbxAWDavP6jXhBCeCiXBZCYh1sdjfwv+o8XWLjpkvX7UzfaF9fUR7m5DEFM8FR2kicFFL0zmDHiDrZWGFW5ZsZR0ES9bDjhwTBtiqso3qGRH3OIxbSi8s31Nw1elS8pY59ylsJHqKuBBvY5Vgcy+M/kKAWLcUpc1skCgUHkyP3wwVjmdf7XmsrtXa328GPhauUJSXGWxLjNhJCd0LhAeQ1gfNkQ7gnb3J4kstyE8rScaoPtcIlusAZRhwFPXjkT4Vh0+AKYAw7ZZTZd4fRus+g725QEA3NNk4o9mb9A7xMvXgEP/mr+n5PiZFWt752Ijda8r50Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3rUQ3miVbAZ4Zbj0o446R24p7Tb+B4MAYHSfY14SQc=;
 b=ts72hKcYN1qqvOivN0Z6sOeSfwpwJUugYC4q+E+nUFwXEdl8cXZOBPc6BoNuhtHbaEyJVHuI8b8SGltjNyF3YztBlyTZPsXI5h9Va8be985c6IjfOdZoCmnUxj0Q5mIEaQGpRJ5pA/+b6w5fzA3/DL2Yo5ahfMNS+aS1YBqkZU+AvJ8MG73acLfEqB6YfBU8AZrN/oMm8mP/DkMRqAIzE9Sxa6Ld18KReqL0WxSqWFiXJAbRQEMtcxPYmqcN+qK1CmMLd8df/xaT1JRpd3mM0zGUz6z2Pb20yRxw/G6tW1kJPMga/PIS+ZpCUn1nKbgUtqUpmfszJTUR8HffYrqKpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3rUQ3miVbAZ4Zbj0o446R24p7Tb+B4MAYHSfY14SQc=;
 b=YLzUyJMh7TFBtPsVO8eEp6dAB3hNfEqEaLJb5qScZgyc1ZM4IBnMRRZnLQwERAEGGqyTzIFPtuats180C78q8MdDHaEK2SXCvuXEvTJAr3uxu2H+9zQRmJm3h0cuAFGYfZpxmZ8i4e+jdM+9IzIcqCtAqQxtDFZyMhj2k+EaWBV3bVYW16ABTQPYvWLwAM30KAm3gQcDPSl55qvLp8ZJos/Hm1CzDGm+k66etltSeJEDLm6DmIVpvCVpvex6z4gfPBjdB/ZgA0JznZVXZJvdpcy5nMVraOElZr5YWdlXzssyaIBUWdlHem2wXEP89yPvsPhUSwPPC1oaEI2mTWHezQ==
Received: from CH5P223CA0024.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::14)
 by DS0PR12MB6557.namprd12.prod.outlook.com (2603:10b6:8:d3::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.16; Mon, 29 Sep 2025 13:41:00 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::cb) by CH5P223CA0024.outlook.office365.com
 (2603:10b6:610:1f3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Mon,
 29 Sep 2025 13:40:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 13:41:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 29 Sep
 2025 06:40:44 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Sep
 2025 06:40:37 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: [PATCH v4 23/27] hw/arm/smmuv3-accel: Add property to specify OAS bits
Date: Mon, 29 Sep 2025 14:36:39 +0100
Message-ID: <20250929133643.38961-24-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250929133643.38961-1-skolothumtho@nvidia.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|DS0PR12MB6557:EE_
X-MS-Office365-Filtering-Correlation-Id: ba30f757-1a1a-40ce-6b77-08ddff5dd3a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xdG81woYIui60VYwFkAIhNrBcruV1T5jBdcTV2pIeGNS6bMy/UoAox4mbBup?=
 =?us-ascii?Q?iiX7MxiDKQEEXV4J0lKNg0KRB7MJvcIsxAzaWDlIY21JszbYXFABYprwTOTN?=
 =?us-ascii?Q?YxSOPhDlxTQhrOB4+AOEdqmPUAvfA6ptRn0ghGcpOt8qSqpOigNN13be+ilY?=
 =?us-ascii?Q?2LDTkxeikUcXThyRNF8PMEIrbXghib/Qb2IlPmfDQfBW7vdp+YbRN48UnDIn?=
 =?us-ascii?Q?TQiNyelf13oQB0sSfoBWxL6X7VoK+52TmDRD9YofpDfPrOrvXqCsXXAsphtJ?=
 =?us-ascii?Q?Nx1O3fAH64SKfi9dM2zhXjmsBgLZf2cRXlgjsP0tKqO1GLvUce5PkSnJd57z?=
 =?us-ascii?Q?CtU1qeSFIj+oCWMC/M3SXCaiT2uz3Ik9PJ3aP6+v7fNzPNTcvAtBb7AS1Rs7?=
 =?us-ascii?Q?ufnE7ajC/60D6uuzBfaqmQKrAIVlRhNoRF2lHf4HgiPM5LlK+OGX3z8SHWm5?=
 =?us-ascii?Q?M4TciRoKRQ6TOo6AM3pUDNWO2jig8jxHFqarsZ9fotl8hAdtAPHCAwWUlxMg?=
 =?us-ascii?Q?GN1Ym56INUS9rmnA2BKcPQuTWNVqh8lDMlW8tdCwBOaiiiQiMR0wLqGZNlVX?=
 =?us-ascii?Q?LGDj7H19y3A3Z7wvoZLOC77J5WMAsQEcDgsmyqC9aiZpoCs9MKsy6iufW6V4?=
 =?us-ascii?Q?7qL+8J4/8sg4FgNc648B9RABI66nBpWOkMtQZmWjLxtJPrl2Z7Ccck/cptTC?=
 =?us-ascii?Q?ylVw4WYegmJJyJNPOSDWWSzf+tXZ7KhoOwogBXunVQFje2AnuJD2zpbU/MCL?=
 =?us-ascii?Q?7Kj5RCMuB/E/6y0d3Rxx5SVYu/oxKJJTbJ1VMAZEdM5JBmjdiCAXrDpM/nXu?=
 =?us-ascii?Q?GmdlYGmSnfFQCJTrrsLMOgxL27RaxnbyRh62vr4vAkgbNv85vfiMiB39zqgT?=
 =?us-ascii?Q?HMsnuKe9hHmcNZPKGohc+yUCjS+wAh/7TfIVsVpveOkoL9z/XwMTox17O1J0?=
 =?us-ascii?Q?hG8/R78+/EiekZ2Dlo5M0nF/2NoO12oT2d3EqQI6beuAcaxJiV/hTTcXsHDO?=
 =?us-ascii?Q?q17R60jOcxF9pVQUOaEERqjDNpdoYgswrAQdS1Yq3eiNkoDl0rB3dLwmbBLB?=
 =?us-ascii?Q?s1WApbMqybO3zW4QmwloOqXx6zwXvodu5YfAQXWGfK2amxI1dxBno80iz8Hu?=
 =?us-ascii?Q?je4vEDADKocyq7tzzXl1E5a8Tdq6JeoFeeFthRP1M/iA///bQsnkCNlXJnjY?=
 =?us-ascii?Q?Cw7CuxI3LnZx8rAg48F7iznjKAdApNDN5gXzd0wbjAlLyd1vWhnzB3Mp7DY0?=
 =?us-ascii?Q?VElEOzL384QP7kxBjBlPeLQkwEzh7KAKaOL1Q+rRTtznUKohgqxyjoEFaHch?=
 =?us-ascii?Q?Z/9vLDuPJSsRNF0w7BNQR0MaP4XNBmwNIaMyGrERUIXyNK4H7x/KjBxBCfo+?=
 =?us-ascii?Q?lGLoZQR5u2uws+8QDuBm6t3YJyfF4t3GwY4PyWMStnpeeSNabCHO53yK5EJl?=
 =?us-ascii?Q?PZSyt+QdDRlCUkTSIexFeg0h8qAXHJbF5RlzsmFm3WnoIrATb4v3jqTOSpsd?=
 =?us-ascii?Q?aSd+yHuQKAtWARJMtVpQwT1bdm2tLLxZT8vxYlYMpp4kA6++JPLQy5lWV9/3?=
 =?us-ascii?Q?vUTdpQo/Jw2fh9cKPXk=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:41:00.3094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba30f757-1a1a-40ce-6b77-08ddff5dd3a9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6557
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, KHOP_HELO_FCRDNS=0.4, SPF_HELO_NONE=0.001,
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

QEMU SMMUv3 currently sets the output address size (OAS) to 44 bits. With
accelerator mode enabled, a guest device may use SVA where CPU page tables
are shared with SMMUv3, requiring OAS at least equal to the CPU OAS. Add
a user option to set this.

Note: Linux kernel docs currently state the OAS field in the IDR register
is not meaningful for users. But looks like we need this information.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c    | 15 +++++++++++++++
 hw/arm/smmuv3-internal.h |  3 ++-
 hw/arm/smmuv3.c          | 15 ++++++++++++++-
 include/hw/arm/smmuv3.h  |  1 +
 4 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index eee54316bf..ba37d690ad 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -86,6 +86,17 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
         return false;
     }
 
+    /*
+     * ToDo: OAS is not something Linux kernel doc says meaningful for user.
+     * But looks like OAS needs to be compatibe for accelerator support. Please
+     * check.
+     */
+    val = FIELD_EX32(info->idr[5], IDR5, OAS);
+    if (val < FIELD_EX32(s->idr[5], IDR5, OAS)) {
+        error_setg(errp, "Host SUMMUv3 OAS not compatible");
+        return false;
+    }
+
     val = FIELD_EX32(info->idr[5], IDR5, GRAN4K);
     if (val != FIELD_EX32(s->idr[5], IDR5, GRAN4K)) {
         error_setg(errp, "Host SMMUv3 doesn't support 64K translation granule");
@@ -648,6 +659,10 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
     if (s->ats) {
         s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, 1); /* ATS */
     }
+    /* QEMU SMMUv3 has oas set 44. Update IDR5 if user has it set to 48 bits*/
+    if (s->oas == 48) {
+        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_48);
+    }
 }
 
 /*
diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index b0dfa9465c..910a34e05b 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -111,7 +111,8 @@ REG32(IDR5,                0x14)
      FIELD(IDR5, VAX,        10, 2);
      FIELD(IDR5, STALL_MAX,  16, 16);
 
-#define SMMU_IDR5_OAS 4
+#define SMMU_IDR5_OAS_44 4
+#define SMMU_IDR5_OAS_48 5
 
 REG32(IIDR,                0x18)
 REG32(AIDR,                0x1c)
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 77d46a9cd6..7c391ab711 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -294,7 +294,8 @@ static void smmuv3_init_regs(SMMUv3State *s)
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, BBML, 2);
 
-    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS); /* 44 bits */
+    /* OAS: 44 bits */
+    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_44);
     /* 4K, 16K and 64K granule support */
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, 1);
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, 1);
@@ -1943,6 +1944,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
     }
 #endif
     if (s->accel) {
+        if (s->oas != 44 && s->oas != 48) {
+            error_setg(errp, "oas can only be set to 44 or 48 bits");
+            return false;
+        }
         return true;
     }
     if (!s->ril) {
@@ -1953,6 +1958,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
         error_setg(errp, "ats can only be enabled if accel=on");
         return false;
     }
+    if (s->oas != 44) {
+        error_setg(errp, "oas can only be set to 44 bits if accel=off");
+        return false;
+    }
     return true;
 }
 
@@ -2078,6 +2087,7 @@ static const Property smmuv3_properties[] = {
     /* RIL can be turned off for accel cases */
     DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
     DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
+    DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2110,6 +2120,9 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
     object_class_property_set_description(klass, "ats",
         "Enable/disable ATS support. Please ensure host platform has ATS "
         "support before enabling this");
+    object_class_property_set_description(klass, "oas",
+        "Specify Output Address Size. Supported values are 44 or 48 bits "
+        "Defaults to 44 bits");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 6f07baa144..d3788b2d85 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -70,6 +70,7 @@ struct SMMUv3State {
     Error  *migration_blocker;
     bool ril;
     bool ats;
+    uint8_t oas;
 };
 
 typedef enum {
-- 
2.43.0


