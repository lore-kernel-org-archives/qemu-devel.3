Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FEFD358F9
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 10:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlPHE-00030E-Kx; Thu, 29 Jan 2026 05:29:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vlPHC-0002zY-AS
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 05:29:26 -0500
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vlPH8-0000jT-Un
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 05:29:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/+fYEIt1oNqF0SsjBZ3LMax+wzKBeqsmJh4jPYVDZXu0yJB6UhsVfE/RewZOHssUBq+B1U4ubtSVm+qgLJJtYK1xYnpqyRk0fzyUbR1UiNuaeaLy136+1esUYPNNrwUM25f+gEohAa0M8e7NsFIqhaU/cXRwpWnaUz9iybPu0V5WW9SR5gqhBEua7KPqFg+dTzhbXyHzgPBIPi51F3mGLe5BXtl89epov05Il07BMMxKUGJwahcpbgJX3L4Ib4i7/llX37frVO5DS5D5HPBLqkr6SC4BZL/tQTnsBvZ7pXtB2/05CDclIVLDazRxZbetwr7shQGmIUtt3NA8M8aHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0Gvs0z8/xvF6piE3zVN60oRSMV4pYrKNjMlazVF4wI=;
 b=RqVLN4DZ5+DuNT4KtyOaZWOApEOVvbrq68gto4TFCJaDq3i35EPZHCm9hqc9yO/OV2g7mEHe9gle6VN/MHfOFpCKEbsvk962iOyJ1xgtEGtKDnnFuDZqV9M52R6ZIT3t4441z/zcN/nNCwGiNo9J9sQqDOqvg0BVNWH34H0l1c2Q379QWrdarKd4fUsAGC/t0huPZUazbCA+9rRaRbGVT3T0JDuxmss3TGN6upwxYVioqZRzwClOkm1Y4OxvpUzdX28d6oNXC+nwSn14RFdHSdd1E/esPqUXx0QZVJ96EX6va87ZtHL4AnR6jXZQRBWMhnxR7WhXfHyQm+j3cZAzrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0Gvs0z8/xvF6piE3zVN60oRSMV4pYrKNjMlazVF4wI=;
 b=xJaCA6Zo99D9PPyXuMcNOB128Q+8Qf21ZEDQP6uJJRZRenqrS+P8jgJsPYLjjD50hWFTX2I4qXQ/oyX+UCfPkY4C7fZVdzuIVjI8Ea7qluUP6lzn3qWAyYe6hlJ6Vx60FT0lnGTdOiHDJC1x156OF7XSfIHOy1DhCd98YWP1prQ=
Received: from SA9PR11CA0022.namprd11.prod.outlook.com (2603:10b6:806:6e::27)
 by DM4PR12MB8523.namprd12.prod.outlook.com (2603:10b6:8:18e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Thu, 29 Jan
 2026 10:29:14 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:6e:cafe::2c) by SA9PR11CA0022.outlook.office365.com
 (2603:10b6:806:6e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Thu,
 29 Jan 2026 10:29:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 10:29:13 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 29 Jan
 2026 04:29:10 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <alejandro.j.jimenez@oracle.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <vasant.hegde@amd.com>, Sairaj Kodilkar
 <sarunkod@amd.com>
Subject: [PATCH v2 2/3] amd_iommu: Turn on XT support only when guest has
 enabled it
Date: Thu, 29 Jan 2026 15:58:13 +0530
Message-ID: <20260129102814.4488-3-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260129102814.4488-1-sarunkod@amd.com>
References: <20260129102814.4488-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|DM4PR12MB8523:EE_
X-MS-Office365-Filtering-Correlation-Id: c0dd0897-f3d7-4604-c812-08de5f213f39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VZisml6Smun5njIVM2AtK5UHiFi0BTDlPcaXZXLXmIIY+KAPHj9GbSO7yupe?=
 =?us-ascii?Q?uPZMLZH63xz0cVsQA7bVUUZ3YZPVCW7PgVxp0aG9vLAjFXLiusXs5XvnLJIv?=
 =?us-ascii?Q?xRje/ZHvMbbxfZOjQHsS1LnbFGTWAqB4489k34PelUsrRl9o6tVTpoHPNy1r?=
 =?us-ascii?Q?kFbmt5KofRWjXe/pIwuZ6DE23WVaCU8NvAX+Qr65dZJllGO0Nr2nu+dFELiM?=
 =?us-ascii?Q?C6T5GgV0tP/Vn5ynCYegBferXyZHZyDMhHeUkKOpCFvQ7CofNN4YY+4QWsnb?=
 =?us-ascii?Q?0YMACoxcLFLn23h2FBtLyInzO7OMTJ4jo3z7bT0hHCx2O02KYedQynMML8V8?=
 =?us-ascii?Q?yTcs62XtMX3vGkHLqATFPDZvtKvutJexmORxJmc7yWk2wk4cijjK1Y8WbR7Y?=
 =?us-ascii?Q?nOEUJNRAhFcm2H81ExY4pIaTyP9NvHonvY70LNTD9VHbzpCVLHBEV66mMXdF?=
 =?us-ascii?Q?bCuy+EAvwDB0Ojs/LEUfLwinTw6YknNHfeTSB0Sd0KwVgJUST92jcv2AbpTf?=
 =?us-ascii?Q?RGtvKs/Gy6u8wZoM7KIi+UIyajmBNco+IzLCaNjKEjukLwkh196mmTlN1rI2?=
 =?us-ascii?Q?cYsQ2q6yPjmNNWKmb2W1nuuoLBPK5hKVVcVcoc3895MJ+u11ciPSX36sRXa6?=
 =?us-ascii?Q?838MOlsU/ClVNoqJNM/vsj6tdz+nF0DSH/fpH7ZgXjyNe8xwQTgv/TDpLa/O?=
 =?us-ascii?Q?C+S392vQ8GQhVPOxHwjkZ3A5vzkbavhSOlglEbK0+qzqMKvP9bOYLsBrGn7Y?=
 =?us-ascii?Q?N2aQXGeETjHI7OSWu1wqSEXW2Jc7BZP1NwExeO4YIdUCGqsoGvQRFnCg+taX?=
 =?us-ascii?Q?n2oIJ8ABttOB4bBK+SH5MxdtW6sK3JTwUptnhO+SVsCrsQY9bn/xhqU5bacs?=
 =?us-ascii?Q?UfbqWGHoiPIK1396gHfa83d8TGj3uljPzmgAOFrnrMOm9ar9Piu80mhr45WB?=
 =?us-ascii?Q?x78jN1UEXWfxZKB5NwU7L3pTFuQngclVDL7ywUkatoJnF0s1QBhdSq6KUfLL?=
 =?us-ascii?Q?LdhfhdLHIKIiXal8iCjBf6fFn0VKXyQCF4/MgHxBtpZM8Q7zaRkTYvhnMXO7?=
 =?us-ascii?Q?hNqoM3lq85kw+Oid5yebmHc7TvsNDt88C+NEbAuMHh157YGpupToyX2pyirP?=
 =?us-ascii?Q?dHL6793SDmx/7NXp0+gpv8zqmYnLZMnF2iicxWB9wM8M4EJ6ENdSCZBFudfK?=
 =?us-ascii?Q?9HCUy2WGubOuld/rrsYMZnAIDWqmo0UXGmKgdRjqTTmXanafoq44w9/IJpQm?=
 =?us-ascii?Q?mEkh7ZCeNQjsw+U2IKx1egcS8GccCGMos7m2N/5ZtiqBXZuxD/tCf1H2yBp4?=
 =?us-ascii?Q?X8/lNwpqtAG6kXxwT48QyH/AMtgh0PCz+15V8tFuYmCqxWiPPuYVMNLvF8D9?=
 =?us-ascii?Q?PxGro6ECDYfl/pJoSTv5v8V9bWkkQB5uFLakjYPy+lS9rvIensNTDjgjWcIX?=
 =?us-ascii?Q?zTxNpMmqrRaS4GkxEPXw7ggpa/rG4scNUpOTJcutECPYuTVtiVDbJRqeZwxS?=
 =?us-ascii?Q?pINzkdNlXeX6uxfvVU4Z5iW6Cbiz4IlxeR6x+ssbGAJCWCT17W6j6XxRVnKn?=
 =?us-ascii?Q?z/0F+m/7nl4uNJORTKbDBDfB5/Wes5Hq/uOjf5gybN4X7QLPnjAZzT4M7++Z?=
 =?us-ascii?Q?BlR1RcmtSueq7uakyaOjnz5KRPP5XsUG8CUqGn5jtRWwNsUjKx9GHeRbJAxm?=
 =?us-ascii?Q?4enPaA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:29:13.1810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0dd0897-f3d7-4604-c812-08de5f213f39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8523
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Current code uses 32 bit cpu destination irrespective of the fact that
guest has enabled x2APIC support through control register[XTEn] and
completely depends on command line parameter xtsup=on. This is not a
correct hardware behaviour and can cause problems in the guest which has
not enabled XT mode.

Introduce new flag "xten", which is enabled when guest writes 1 to the
control register bit 50 (XTEn). Also, add a new subsection in
`VMStateDescription` for backward compatibility during vm migration.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 hw/i386/amd_iommu.c | 21 +++++++++++++++++++--
 hw/i386/amd_iommu.h |  4 +++-
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 62175cc366ac..850d3920a76d 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1535,6 +1535,8 @@ static void amdvi_handle_control_write(AMDVIState *s)
     s->cmdbuf_enabled = s->enabled && !!(control &
                         AMDVI_MMIO_CONTROL_CMDBUFLEN);
     s->ga_enabled = !!(control & AMDVI_MMIO_CONTROL_GAEN);
+    s->xten = !!(control & AMDVI_MMIO_CONTROL_XTEN) && s->xtsup &&
+              s->ga_enabled;
 
     /* update the flags depending on the control register */
     if (s->cmdbuf_enabled) {
@@ -2007,7 +2009,7 @@ static int amdvi_int_remap_ga(AMDVIState *iommu,
     irq->vector = irte.hi.fields.vector;
     irq->dest_mode = irte.lo.fields_remap.dm;
     irq->redir_hint = irte.lo.fields_remap.rq_eoi;
-    if (iommu->xtsup) {
+    if (iommu->xten) {
         irq->dest = irte.lo.fields_remap.destination |
                     (irte.hi.fields.destination_hi << 24);
     } else {
@@ -2390,6 +2392,7 @@ static void amdvi_init(AMDVIState *s)
     s->mmio_enabled = false;
     s->enabled = false;
     s->cmdbuf_enabled = false;
+    s->xten = false;
 
     /* reset MMIO */
     memset(s->mmior, 0, AMDVI_MMIO_SIZE);
@@ -2454,6 +2457,16 @@ static void amdvi_sysbus_reset(DeviceState *dev)
     amdvi_reset_address_translation_all(s);
 }
 
+static const VMStateDescription vmstate_xt = {
+       .name = "amd-iommu-xt",
+       .version_id = 1,
+       .minimum_version_id = 1,
+       .fields = (VMStateField[]) {
+           VMSTATE_BOOL(xten, AMDVIState),
+           VMSTATE_END_OF_LIST()
+       }
+};
+
 static const VMStateDescription vmstate_amdvi_sysbus_migratable = {
     .name = "amd-iommu",
     .version_id = 1,
@@ -2498,7 +2511,11 @@ static const VMStateDescription vmstate_amdvi_sysbus_migratable = {
       VMSTATE_UINT8_ARRAY(romask, AMDVIState, AMDVI_MMIO_SIZE),
       VMSTATE_UINT8_ARRAY(w1cmask, AMDVIState, AMDVI_MMIO_SIZE),
       VMSTATE_END_OF_LIST()
-    }
+    },
+    .subsections = (const VMStateDescription *const []) {
+                    &vmstate_xt,
+                    NULL
+     }
 };
 
 static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 302ccca5121f..e9401f3a5c27 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -106,6 +106,7 @@
 #define AMDVI_MMIO_CONTROL_COMWAITINTEN   (1ULL << 4)
 #define AMDVI_MMIO_CONTROL_CMDBUFLEN      (1ULL << 12)
 #define AMDVI_MMIO_CONTROL_GAEN           (1ULL << 17)
+#define AMDVI_MMIO_CONTROL_XTEN           (1ULL << 50)
 
 /* MMIO status register bits */
 #define AMDVI_MMIO_STATUS_CMDBUF_RUN  (1 << 4)
@@ -418,7 +419,8 @@ struct AMDVIState {
 
     /* Interrupt remapping */
     bool ga_enabled;
-    bool xtsup;
+    bool xtsup;     /* xtsup=on command line */
+    bool xten;      /* guest controlled, x2apic mode enabled */
 
     /* DMA address translation */
     bool dma_remap;
-- 
2.34.1


