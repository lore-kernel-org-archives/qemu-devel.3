Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF7EE9A04A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 13:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt4VO-0007RT-8b; Thu, 19 Feb 2026 08:55:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manali.Shukla@amd.com>)
 id 1vswpN-0006Nx-JB
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:43:53 -0500
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manali.Shukla@amd.com>)
 id 1vswpL-0007uG-UR
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:43:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bguMqKQsAQA7hxaK8EfK4XWy1/ZwNDVNZ4DQvlXihunRnCOBr3tw0f3Dj+36Ozy6ZaRDpDfcw8XWnbgjeRS/hHP19ijTJVkhmXOsNx9R8fWX/1GO3gs5knz+XfvQwPittW4ObOeJgLntJj49yOK2ihfffZ4fL8wMwFiEa71jhRg9DqEnjAHA8qdRGL9PvKOlECj3udSsKDR8NP4X3LMjqv0QaT63Wl9w49MhHETKKrHtP7AEocWUOXCBeh+vJBN+3Bx9ADpU3N3EDzNaSBjejaXTsLp6y5OnIjIWWIiTmIdAqZW6yCCH2ICQ0alJaFvS5VCpEA7B4SIlEX2WdwbVyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZEm9e4GVICj+l9f6e0apbmSyYBEM2DqI43+jVavfsA=;
 b=eQwrwkNjsOQeDLcXYoj7fmfnwXidDumb/eZe5GcUWbfjOxxgpPvKq0a1W3vHwUC53pKAyDC1xBWGl34FjUx4JOPWa4BwZ5dAm15Z1hlYzqhX+cK13mSL3iUKvAbecg95YclP55DbEuHM3rJ/Bs/we56z6ZeCpyNsnB7paoSySJ004ung7sJoETNQGDXaXh3EXIWXttLEnVw2Wqb307M9lGV9z2EECer9flz7gQtkNuzg148Rlg6LfhXKA0d9lRsC6h4HPLTlR9QZRnOxmAht8yu7imKNEvwj0dUX9Q3P2scVR1QP33CsTonjtZF4fZyB1fjN6jtD7IVaju0iEuNCCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZEm9e4GVICj+l9f6e0apbmSyYBEM2DqI43+jVavfsA=;
 b=QQu0tEYRt/YzUmEiOcXRpmiZtWksSSmLWsnPMOLV9OSHpSKrTTpbNL7rB00bd+ZI+ByO5NtIqw7iqLJutRn3+HtIam7aceFXtniFQbF6eeYwKQZA4EtGTxiAsoKC7LJ9jMj9Ud8WaTXPGtNz63O2rfvm7d0hKvYVg3vZ12OawfM=
Received: from SJ0PR13CA0110.namprd13.prod.outlook.com (2603:10b6:a03:2c5::25)
 by MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 05:43:45 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::3d) by SJ0PR13CA0110.outlook.office365.com
 (2603:10b6:a03:2c5::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 05:43:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 05:43:44 +0000
Received: from brahmaputra.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Feb
 2026 23:43:40 -0600
From: Manali Shukla <manali.shukla@amd.com>
To: <qemu-devel@nongnu.org>
CC: Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 <kvm@vger.kernel.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Marcelo Tosatti" <mtosatti@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, "Paolo Bonzini" <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Richard Henderson <richard.henderson@linaro.org>, Naveen
 N Rao <naveen@kernel.org>, Nikunj Dadhaniya <nikunj@amd.com>,
 <manali.shukla@amd.com>
Subject: [PATCH v1 7/8] apic_common: migrate extended APIC fields
Date: Thu, 19 Feb 2026 05:42:06 +0000
Message-ID: <20260219054207.471303-8-manali.shukla@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219054207.471303-1-manali.shukla@amd.com>
References: <20260219054207.471303-1-manali.shukla@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|MN2PR12MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: 69dbbe61-126f-4998-f487-08de6f79d8b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CSP0l17PDwrvzqtw/cthxz4nYwtZrdehNyPjiQIEpnPWOD1Blht+FRCLM/8i?=
 =?us-ascii?Q?WXGncdPSREhp2YNxY/0LdrRM4yKPgAtrw6gpW5j03PQXKwt960+rE0PidHdj?=
 =?us-ascii?Q?FCaLDiFjSO/fnt4Qn5GeJ1GnsisdE/pgktPUql1oMw+E+XZYs1i9t8pjapdz?=
 =?us-ascii?Q?SXAubz5tT8L2jXTiLNdQgNoAg9C2Ro+p//7dOPF6bN6oFV76ZLK199Un37N5?=
 =?us-ascii?Q?z8iSOaacXQL8qZKlHLDzi2vl5hwwDD+MANI8B/0Qj+RUIBjrgRo7dQi4QVR7?=
 =?us-ascii?Q?iM6kygQlevLnMqUKbtSMyHzT3olIKzgaXffwBpyHqIBBfOLV2lCUxBKVM05q?=
 =?us-ascii?Q?AiWVI4Avjcc+V/XGAYZOOxk+pP09opZIF6r0EPMcDEhSlb55Rv0TUpA83bWO?=
 =?us-ascii?Q?AazvC/u3R/LCcHRK45YPSzAqIrj/4MWYazsEfjUkfruMFbl/9+MLOxXhk3NX?=
 =?us-ascii?Q?tDqxBgqmK2duS+eJEfjqfwh62p4KvJYiL9vFtDIwlAIPd/odan2AnIPxAoXt?=
 =?us-ascii?Q?bMbh6ZrGovZpeFfn63978vWMjS8mhExosyVzfUD+hbe0zN8ej+iumN9OhPqG?=
 =?us-ascii?Q?+ZUQZxS8Ji90ga642l6yYkgkb8bTgDzmZW+lKNBnB7BcVbBLDsHUiGxpoIqL?=
 =?us-ascii?Q?HuPHmZfX+6HhCcvnCEd7E5a2myXy4LW12Nb7842NgMPFzvfDkwbFkCpwuZnS?=
 =?us-ascii?Q?jVZ2a4wPrll+KMFCbY7hC+jjXFWUzJTEVvjgQE4emTHRIvmmWmYa875hAB8H?=
 =?us-ascii?Q?XvUeJXywCP8qYZhcispW4gbEeCRfLlL3eGdzoqO2kbJBNj6+1LCEOYUreqKI?=
 =?us-ascii?Q?k+6rKowBN03jWcB4jvH4YwWiZ2wEi+rcHSUQq/tzdDDSjHA5QuyBFZPTKIni?=
 =?us-ascii?Q?Gge6JqCkc78rTH6N8QkfQhKdWffiHpuDjshPIYW82dAFBt4Bll1+4DpPGjET?=
 =?us-ascii?Q?92/UV+ChP1iJm0HDQIjiqQuQperS/T+2FBFEWHGmrK0JdFhUF1WOU9Wfm0PU?=
 =?us-ascii?Q?/C5ohKcLtENM8UFNPHNhrkMEKi8SGP+xqRbfdD5sbh+XXJvNmFMfQ9xa1qEx?=
 =?us-ascii?Q?dIF/SGEKGjOvQxeInIr8mxkCWVxRdl/GuyrPp9l399I6/KRt6egxG3NPNbMs?=
 =?us-ascii?Q?LeCmL+J/0tAylclNuYB6nCBAcEQu7hS+GVMRTLK6s4ekjpYUJAj6XS5875zz?=
 =?us-ascii?Q?RKd8kJiL/xCv0+Z+kk6yi1R0DWE6S+hL8PTBCSZWnHCEn+GUnM0K84oJ4VIZ?=
 =?us-ascii?Q?dls3FoCXJ7RiiISr09X8NVCTIAmsBBsorPX/c3f+LvKVcDbq08PjJd7oK07D?=
 =?us-ascii?Q?yZtepPHXhaGrdXFoSZriFtJHM71MLgDByBDjydskQkHsfoPu4vhwIpKYjxiJ?=
 =?us-ascii?Q?0ekSXO3htpshskKYXAa6bxh99HVIWX/8egXyrka8Q4Ja+Dn1b8W8ranXjqzg?=
 =?us-ascii?Q?Jd3BC39neQFDlDw2XaIh5OeT9Lgm/0BvaMdJdVzuVY3Z7/fr60jskL1YHNFc?=
 =?us-ascii?Q?AjxkUKOoKycSBhISH9UYlgQq7hZlxbOQKor4n0sgeeXSIE/Lpr4hF9Z3BNuK?=
 =?us-ascii?Q?Axn8pw2zhUP5IKzEC6v4TePYu9iWu8SPdjfys9lpok7q1jORA1cna6y2Ii/D?=
 =?us-ascii?Q?8DwhQWeTh/8mgJJqaz6ibTLj4aM/kdL7fsglFFj42MYjbD+IGBD2q3gQ34XL?=
 =?us-ascii?Q?0yk6yQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NT5FiaZb/C328VzNmvz74ZP+Tt2tEJw4uIiquLwDRZFCsBgsZfpbzlV57f512DER92Xhy1NkW4LszGtywXWSOcYkDhxBt52+jRMLDx/I7o/GKxHiPcRc9xnM6oujyWx+JwVc/4hCt4ieSJC+KgU3YA59qozsfxNeDGobW+J6xl/J9689TjgB4ReLjdgYwnTHxgfNMRAXQdf+TiZfl0FMlhLHwYHZw2kD3EVuSZUkcaiJGLZ8hYEPvgMG81pIVWz4fj8P/HhzhOIMTMLBEwMKIs5IJ2Ih0YCEuBpFjW6G08SFqkEp9rD8N/1iD+QCxdX9JAXjmnV+c6196yF3d5EuDhu9v4elogvFiYEE9ma/H9hucP4UNIejO9vLGLFxd/drgx8CnTMUJ+Cgpu786aKdS3urHeuUgv7a99WQZJujAVhJ7ExDC62zh9vmHjj+yZij
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 05:43:44.9397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69dbbe61-126f-4998-f487-08de6f79d8b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=Manali.Shukla@amd.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 19 Feb 2026 08:55:36 -0500
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

This patch adds extended APIC fields like efeat, ectrl, variable sized
array extlvt to a new subsection of the vmstate of the apic_common
module. Saving and loading of these fields makes migration of the apic
state deterministic when extapic is enabled.

Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 hw/intc/apic_common.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 37a7a7019d..cd4b480c8e 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -360,6 +360,12 @@ static bool apic_common_sipi_needed(void *opaque)
     return s->wait_for_sipi != 0;
 }
 
+static bool apic_extended_needed(void *opaque)
+{
+    APICCommonState *s = opaque;
+    return s->nr_extlvt > 0;
+}
+
 static const VMStateDescription vmstate_apic_common_sipi = {
     .name = "apic_sipi",
     .version_id = 1,
@@ -372,6 +378,20 @@ static const VMStateDescription vmstate_apic_common_sipi = {
     }
 };
 
+static const VMStateDescription vmstate_apic_extended = {
+    .name = "apic_extended",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = apic_extended_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(efeat, APICCommonState),
+        VMSTATE_UINT32(ectrl, APICCommonState),
+        VMSTATE_VARRAY_UINT32(extlvt, APICCommonState, nr_extlvt, 0,
+                             vmstate_info_uint32, uint32_t),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_apic_common = {
     .name = "apic",
     .version_id = 3,
@@ -404,6 +424,7 @@ static const VMStateDescription vmstate_apic_common = {
     },
     .subsections = (const VMStateDescription * const []) {
         &vmstate_apic_common_sipi,
+        &vmstate_apic_extended,
         NULL
     }
 };
-- 
2.43.0


