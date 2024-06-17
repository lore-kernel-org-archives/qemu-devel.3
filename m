Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF3CC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 22:40:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJL1J-0000z9-M2; Mon, 17 Jun 2024 18:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sJL1D-0000yK-9F; Mon, 17 Jun 2024 18:40:07 -0400
Received: from mail-sn1nam02on20631.outbound.protection.outlook.com
 ([2a01:111:f400:7ea9::631]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sJL1A-0001B8-B2; Mon, 17 Jun 2024 18:40:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifTk3bTHigReFKfQDj4d8Zreenl+yuZ7GSk/KhN8jURaiOAYx4whw99ESvD7A4URw8llPdTUx1cXTEGZ3Oxcxc7koX5IZxpGwllWualuk1oWYz9hD9cLxFnRm610wuEQJ03PA7dbHTgNOPMInJIbmgpHXxuZcyqAjfpldhLVmddVUNiw0w5zKCrU8YzHwD6z8EqYKsYpU7G1mbjggUVLH5nP0Tk7h8XtYgxbdVh0JRRp+kTtXVZ8RTb2MDKMh9iQpygq+8XgdiL21MU7TAKmIir4dt8QPsypFVLtQ07z9b26PXUbV0SIj8JARHikFiOyEPhTExk2NMuROwEmf+0aiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=teZZVeUSDbzyQe2C133buV18UH33T1ln7UFS+rXbDVI=;
 b=ehp+WPkSSJchzWOufbrEHLTXpXc+3sXygatxqMvNX3b40seIA1xCoRYKaqFhChbCFYXqSLnotUBOdmZXGXf08GAJh4H2NrQbq2sTplaT683eTkBB8XO6RWmIRS6MYGdtBFfoGyRdhmfmP2TVZlwE3NbE/WkSdCGeBvphB7230Of6zlD/1XMed0U5y4FxoONwDz9MLnhudPy0sU8YT6rDfYRwAM8+9xem154SE/W9UrNBdAIam6ynyT4O+6vKrdkJOjnhFES242P9j35kwP9pPjkfSKsw2jiJgjjAgngR8uYkcSXC6xWJJTzsSGyLYEMbNIbjEdvMpPCBi2Eq+J62vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=teZZVeUSDbzyQe2C133buV18UH33T1ln7UFS+rXbDVI=;
 b=Ih1Gk6Xm0UlXQHttCoI07RQaOM+TTHSd0y9bDUFMWjvUQdr2TQx9GXBZMAGQz0htZRu1U/cWXJHAksDeIkwL8WkpbOjBaLh2QZfTNLl4i4R2vGQmGinwvduv+0+iIVUVUpxRaXAh5EfLKSsphLm9yJlTz4eKNWjCqFyFrBoKB6Kb9s1LFHAgM+aGBW6z3xl7e/KFdjpDHVQe8RFmmBdujP3IsbEieIB3AukZz0pqyVfdVShLWWCJ9BLUv7H/L5icm9ORre29NEQicE2UmqWUKMr7DH+ndCRACfoccLl2/EpnwQGHdCSao/W/M9awwdqRGy3E6RXoXG1TOZOO0Yqfkg==
Received: from BN8PR12CA0024.namprd12.prod.outlook.com (2603:10b6:408:60::37)
 by MW4PR12MB7143.namprd12.prod.outlook.com (2603:10b6:303:222::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 22:39:55 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:60:cafe::1a) by BN8PR12CA0024.outlook.office365.com
 (2603:10b6:408:60::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 22:39:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 22:39:55 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 15:39:46 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 15:39:46 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 17 Jun 2024 15:39:46 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <peter.maydell@linaro.org>, <wangxingang5@huawei.com>,
 <shannon.zhaosl@gmail.com>, <mst@redhat.com>, <imammedo@redhat.com>,
 <anisinha@redhat.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: [PATCH v2] hw/arm/virt-acpi-build: Fix IORT id_count
Date: Mon, 17 Jun 2024 15:39:45 -0700
Message-ID: <20240617223945.906996-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|MW4PR12MB7143:EE_
X-MS-Office365-Filtering-Correlation-Id: e83a7d4e-2aec-4fab-729f-08dc8f1e68fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|376011|82310400023|1800799021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9qM67wx/nBpIQo4iyDluQchdnGjWzCeEeTNgkW4sXUecE7e/fgVM5W7RWPKD?=
 =?us-ascii?Q?c2ICd+wjoKbJLXmzUQkmxvo0OiFwakuLtmOLSOmbgkT9VirPWy//9vum+vYt?=
 =?us-ascii?Q?kRGipfBYOeeV2UyZlmkkSTLDNKub9xBPhtBNrxYcrVle2HbBfklgT6UIHVWA?=
 =?us-ascii?Q?r5RgpveYQuU7v9Tav1JZmq0kgm+QMKw0ES2VnrtthpwIIL7iHgC5Kip+Eqie?=
 =?us-ascii?Q?m/U+AqYFZHG/D5SyWpCSaiYamTSwuNoz/XE8BqofEJrA3EDjGtoVfsKq6Hld?=
 =?us-ascii?Q?b9/RCjJ2iQLMY0xRAA7MWtjWx1Al8IC2U5+YAzsdpjpoix2hGTFZv5aJjBx/?=
 =?us-ascii?Q?zbnSLoJnVpYP84Ml9vAXkF1weK3+phH6SBm3ZMlRipHXUYzv1oAJG3xjaX23?=
 =?us-ascii?Q?wZ3zct5jXvVdpQg+IFUvuCXjOvB9LkVO9WreqnYiZQidzQ1IqNPLHOCHn/hP?=
 =?us-ascii?Q?uVB8paS6idxtpePMhvtmEWVakXB2tfRYuzB7QKqdWoc/L995Ef0lREd1xsUw?=
 =?us-ascii?Q?p0vW/QP7eHqr5tpPs7X1FzTWNGMTDqxyzpSG62H+hxX3pAq7UVjbDOP7yV4G?=
 =?us-ascii?Q?e9RR//uNZqY7DiMGTvixJ0bBavykRgRGt+9z2M4lJGWAi6zqnCogVP8Xoi72?=
 =?us-ascii?Q?ftZX0pALU+vIMQnosvMCjtmaCIBSFGCBFiC75Rztu1Yx68jSGZW8UwnB6T3/?=
 =?us-ascii?Q?JguRRjAWNIbbxIsZfAZjxuWOaMMF1sek1HC1rM0+H3rvAq1q2JyJ2TNoJqwU?=
 =?us-ascii?Q?23gbBQL066nGSC29PyjDqZ5R71Tezz6R4i1tNwjUVCSDI+EVzoQ9lSr8WZMT?=
 =?us-ascii?Q?7iU1pHe7ZDSEuprnX/+5N2kxhapM2gfXWiUqo1oXet95Ehdd/y5XoYwH5G0I?=
 =?us-ascii?Q?9dGmEZtM1UUvgKSQbfcdSW6f2On5z2HPeSjBOOhyRaSPtkTNym6conqIk4GN?=
 =?us-ascii?Q?QPIP3XeXgSlCRNoA9NE9jyI2TL+vMyBXZLcJ/1Y/Wh//s8jwuFjG+cpxrjQu?=
 =?us-ascii?Q?DBzX6mRPXYCicnAE3pk4VmVKYOwNYsNoGXjLvCUpk7lCgF+tVReRvaeGL19c?=
 =?us-ascii?Q?wcIhBcuMCOI2hGKht7kIl8Joe1EoghdNUXKRwfdnVC4VNVYS77SvqtCPFLLE?=
 =?us-ascii?Q?U6iaeVp9YVWLzD2yO6V3v/gIw432S3KmX711PcfoA9AHZPpVXmpDLszDVj/t?=
 =?us-ascii?Q?14MmysFFOl0sCTba+mou/yWvw8WINkc6V+A9eNdrb5SBrntPu3x1ZWibysFC?=
 =?us-ascii?Q?OjI0r01kyYY2LwabEmjApyiVCsyFV/1ql3qqYMc8OV4IVEph25EhZKC2wcB0?=
 =?us-ascii?Q?024Tt0PaKCA/o6kUA6BCFrNSSCUzMj0jAiE9rhTNGchDafhmAwAH3Rh20+Dh?=
 =?us-ascii?Q?4RMclRZKvItev6HtdrllkI+te7poFAmceN176wLEw2YesABNlQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230037)(36860700010)(376011)(82310400023)(1800799021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 22:39:55.1058 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e83a7d4e-2aec-4fab-729f-08dc8f1e68fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7143
Received-SPF: softfail client-ip=2a01:111:f400:7ea9::631;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The IORT doc defines "Number of IDs" ("id_count" in the virt-acpi-build)
to be "the number of IDs in the range minus one". Otherwise, Linux kernel
reports "conflicting mapping for input ID" FW_BUG at the overlapped ID.

Fixes: 42e0f050e3a5 ("hw/arm/virt-acpi-build: Add IORT support to bypass SMMUv3")
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
Changelog
v2:
 * Moved "-1" to the same line of id_count calculation
 * Added "+1" to the next_range.input_base calculation
v1:
 https://lore.kernel.org/all/20240613234802.828265-1-nicolinc@nvidia.com/

 hw/arm/virt-acpi-build.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index c3ccfef026..631f2c6d04 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -243,7 +243,8 @@ iort_host_bridges(Object *obj, void *opaque)
 
             AcpiIortIdMapping idmap = {
                 .input_base = min_bus << 8,
-                .id_count = (max_bus - min_bus + 1) << 8,
+                /* id_count is the number of IDs in the range minus one */
+                .id_count = ((max_bus - min_bus + 1) << 8) - 1,
             };
             g_array_append_val(idmap_blob, idmap);
         }
@@ -298,11 +299,13 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             idmap = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
 
             if (next_range.input_base < idmap->input_base) {
-                next_range.id_count = idmap->input_base - next_range.input_base;
+                /* id_count is the number of IDs in the range minus one */
+                next_range.id_count = idmap->input_base -
+                                      next_range.input_base - 1;
                 g_array_append_val(its_idmaps, next_range);
             }
 
-            next_range.input_base = idmap->input_base + idmap->id_count;
+            next_range.input_base = idmap->input_base + idmap->id_count + 1;
         }
 
         /* Append the last RC -> ITS ID mapping */
-- 
2.43.0


