Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F3FD2502D
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 19:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf1ZB-0000gu-51; Sun, 11 Jan 2026 14:57:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Z8-0000aW-Rc; Sun, 11 Jan 2026 14:57:34 -0500
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Z7-00043f-9S; Sun, 11 Jan 2026 14:57:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxcIbWdA099gqsGuFNt2uxstPkSJumANLI8g2fMtzn0moCV4DBJ1JcypbSEtDtCQz2NUli5883PyCb4cDKsANKf7qP15dBSANAqIsUx1YQoDgT8XBQ7EcgWZr/2Y40cWMNijWI7875qRWNPLQ/eBF/Io6Vv53hQVtZxqrUg/MPVQMVAx9675Ya3s3hCD4uzjjb2urd0pe6rRtbJODSvlOK+0SSsglbGol71ZwFUkZhobkoHSC3qo1GoRO9aTLlKOiS4fDEyLuTMHRHg4Vd5JCi9J/CRPGZq3Z5fHZQjq6VshHPm3wL7876EHfKYMZi9qILLpZVUk1KpC9++NCj+raQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZ+67CXJWMGqlQqKnv/3nilkw+KRuQ8yVApJTssCros=;
 b=BZjNisKPFAsGpbGt2/LWA2OvI2aQxkWP/ol5XtAkoQk/liqDUwYi8RH0V3M5SMSR5BMV5zRMP0DZAa95eAv3arKdAou+gosFa7Fyl1gSxjbAE5Mi7j2jTGs2QQtLrqZNW3krGP1tAILGRBCQvZqS2euKpF7mj4CYlPrVcJQT4iJWxPrhrC7QqFcW19Y1ankgkKXYnEJzGcBIDzMHlyurBBFJiUA5GOV9WE9mxM1BMJ3xYNwB2kXZDbpMubhDAKphmpnIzb1ph01yp72tcorwL31sFYSvb/b7BzZFgC3KDHhChL09V4UU8sBYdnZJ/ir4m5JV8KJPux5Fo+ienkRBkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZ+67CXJWMGqlQqKnv/3nilkw+KRuQ8yVApJTssCros=;
 b=I9ljbIGOXiB+rStBvSYKzF3dv9zUkBXkC4oFtk1Qn3o+GSq6f228ZSGqh0edWns7YRY3Tq10QYZnCjwQ6ZOgnFnrUc82gfq+300qs/vsCshEumzCdzOjCnFMTLqsC3zN1E/Qz5rTkpJRPcZUXtXDZZZ9CviJRXQLVO55a4GLN+Fl/TzGq/k1WQxE7Ya52I/fCqvxtPWsIH4mLB7ZDcp8rep29HI6Jf9FGVdlV8CNe78T2ti6BX/sr28UqLkcBBc9oCuUNfaXEyOu/I9pGLLekxBdHzESs57mmjmVflZnxVsK5KhDCYy41/R1lBQhrBbjhsuNGPdZMekf5U7vwawujA==
Received: from SN6PR08CA0026.namprd08.prod.outlook.com (2603:10b6:805:66::39)
 by SA1PR12MB6775.namprd12.prod.outlook.com (2603:10b6:806:25a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 19:57:26 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:805:66:cafe::56) by SN6PR08CA0026.outlook.office365.com
 (2603:10b6:805:66::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.5 via Frontend Transport; Sun,
 11 Jan 2026 19:57:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 19:57:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:57:25 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:57:21 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>
Subject: [PATCH v7 19/36] hw/arm/smmuv3: Initialize ID registers early during
 realize()
Date: Sun, 11 Jan 2026 19:53:05 +0000
Message-ID: <20260111195508.106943-20-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111195508.106943-1-skolothumtho@nvidia.com>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|SA1PR12MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: 711f9b89-6ef0-4b89-29c0-08de514ba4fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sRUuGFv/TA/P4TPJIcWPZEklqSupJwXTxK+uYcVNcvQwJz/PAIBkrwlTz9dd?=
 =?us-ascii?Q?dvRvPokZLaTs/PKBU+wSMpDWvt0REDEbi8UxUJ3n3zyPT+gIOmnBrYHbBotV?=
 =?us-ascii?Q?vfp4ZwVrKEQGzyrqpQVFnJgQhcgLQyipkxlpwiNzC4lGMZe/nyCXqkjiIwqi?=
 =?us-ascii?Q?NmMIXQtl6zZx07GrLXOUOnCPKBwHtMykYBsDKbUiAvyFV66AHlfCRZQ4OUn5?=
 =?us-ascii?Q?4ikgZtzgHaWqK26qaE/XgLUg1P7BxRlQVTIxCnrkT3ZCySfY1D39iyKqWdd7?=
 =?us-ascii?Q?p5N6qLlWeBlvnAhf6iC6hRJWWJ4v0czWlYKI9GugsTL/H3XdZmg9ufKxLBHq?=
 =?us-ascii?Q?u39v3vdbFFNQtRGgZkiZppEnfKdi+vj/4HEeMwxm8I77LkUHE8rSm8m5vCwT?=
 =?us-ascii?Q?vXJLA8soV7EJHjDFjNsWakvBjx9SYLq0xdk3uV/YHIJlSAt2gPLb0gYVNP4Q?=
 =?us-ascii?Q?512dWhOflUOXzLrkcE9cpPjsgQ9+tOr0P8KVR5FESGUQjcrAJL5Ch5QMC3OP?=
 =?us-ascii?Q?BBQcutwMIGz7U2Vg7w6S64NqUTC/rR7VcxbynbSY1XAmvYAKs4ZfYiVZlzxp?=
 =?us-ascii?Q?lyYBtMnOZalT8adk5fqeGmS3K9G6cpOoS9yDOpnF9Q1W0BdOkGUqr70Rfdrc?=
 =?us-ascii?Q?DyBtaawkKm9irYJ2VVgE6S1n0HIBzg4uqtVIgAlwqJWGpv2/UT+9NuqMrJG2?=
 =?us-ascii?Q?ebI3+1XBoYZcoRAZ9oxmy1/E9ilhUdiIxYkUOXqwxl2Ri6baxf6wGnuQqHhO?=
 =?us-ascii?Q?OjFyNXn5eBjSeFThSnk7XbkKQzJK+gvTickc7PBM3LcF6B8XVS/4se7f4nzZ?=
 =?us-ascii?Q?aso0iQx4pvgkEh/bsisWY3SsQDlghLLlwiJMPJ8u2aKMMPWxbE6ak5rPqaYU?=
 =?us-ascii?Q?osyrtM0oaf2+UIbn+O+fEqeptaFzcW1Ps+2bpAo/0qNrKGqxeWvF4Njw02jr?=
 =?us-ascii?Q?+x/lax/0w3mZSJciBeUy/b92JN0RA2F/D7Yk2yevf5sEpZIDhbjmOAqkyHpd?=
 =?us-ascii?Q?rfW2qKjqMPoCRSsQcR/Vy8lZJ3iDYq/kyP8nmYkV4IJYfkjyIoRuIVR6DDjf?=
 =?us-ascii?Q?jpf5v7ZWriX2jTpC5NKmKwz6s6QMsO637eo6sEcwIl2i5K1X3YxdWzLm7Xf3?=
 =?us-ascii?Q?AWIKSJ73xPr5tsFnh7vGDp+PEbHTrLk+o5NfQkipWpKRIWPDzHKya/ty/D03?=
 =?us-ascii?Q?hSBjGDq+LTzcXbjYeZHxsQWws/sEvQWNiiD3ywc4tuGHSxmiQJCsHVjmez7g?=
 =?us-ascii?Q?Ctm5HR8NcIqDpz8kq2iewj2Kl7jHfCTdhoPymktYGVm6c0+ATUJCeie8///v?=
 =?us-ascii?Q?CVdLCEklYMu2A4hLrQEp2bh807ZWpo/kdzc3O/u03fI99ze+KzKDxcY6jby/?=
 =?us-ascii?Q?BKxxnCltl0v/J0v6LWrpWwYrFVXmIoa127Jg9CQ0f2frhYWm7QpjZ0fB0FGK?=
 =?us-ascii?Q?EbaF6xN277yaElxYESkeu1KUdoggHJOkFE/uc8XW43OjdzBq7ayXWJmav3dJ?=
 =?us-ascii?Q?ocXfkuC1N8mOJm1cSap27hQEkyjjCU9YYGXFpILHSUh0LnwgYjExFtFvdDor?=
 =?us-ascii?Q?bgS2sgHIp/klkDwtYfk=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 19:57:26.4054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 711f9b89-6ef0-4b89-29c0-08de514ba4fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6775
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
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

Factor out ID register init into smmuv3_init_id_regs() and call it from
realize(). This ensures ID registers are initialized early for use in the
accelerated SMMUv3 path and will be utilized in subsequent patch.

Other registers remain initialized in smmuv3_reset().

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 4efef73373..e301bb467d 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -258,7 +258,12 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
     info->recorded = true;
 }
 
-static void smmuv3_init_regs(SMMUv3State *s)
+/*
+ * Called during realize(), as the ID registers will be accessed early in the
+ * SMMUv3 accel path for feature compatibility checks. The remaining registers
+ * are initialized later in smmuv3_reset().
+ */
+static void smmuv3_init_id_regs(SMMUv3State *s)
 {
     /* Based on sys property, the stages supported in smmu will be advertised.*/
     if (s->stage && !strcmp("2", s->stage)) {
@@ -298,7 +303,11 @@ static void smmuv3_init_regs(SMMUv3State *s)
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, 1);
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, 1);
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN64K, 1);
+    s->aidr = 0x1;
+}
 
+static void smmuv3_reset(SMMUv3State *s)
+{
     s->cmdq.base = deposit64(s->cmdq.base, 0, 5, SMMU_CMDQS);
     s->cmdq.prod = 0;
     s->cmdq.cons = 0;
@@ -310,7 +319,6 @@ static void smmuv3_init_regs(SMMUv3State *s)
 
     s->features = 0;
     s->sid_split = 0;
-    s->aidr = 0x1;
     s->cr[0] = 0;
     s->cr0ack = 0;
     s->irq_ctrl = 0;
@@ -1903,7 +1911,7 @@ static void smmu_reset_exit(Object *obj, ResetType type)
         c->parent_phases.exit(obj, type);
     }
 
-    smmuv3_init_regs(s);
+    smmuv3_reset(s);
     smmuv3_accel_reset(s);
 }
 
@@ -1935,6 +1943,7 @@ static void smmu_realize(DeviceState *d, Error **errp)
     sysbus_init_mmio(dev, &sys->iomem);
 
     smmu_init_irq(s, dev);
+    smmuv3_init_id_regs(s);
 }
 
 static const VMStateDescription vmstate_smmuv3_queue = {
-- 
2.43.0


