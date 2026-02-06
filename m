Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9886EE20A8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 14:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voNAZ-000102-7d; Fri, 06 Feb 2026 09:50:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voN9n-0000Sa-Kb; Fri, 06 Feb 2026 09:50:06 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voN9m-00076b-3c; Fri, 06 Feb 2026 09:50:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MUIMT8tkDAn8zisbK+f8Hb6xS+gO9qelvhADwdWWv+QOVuf6tJif9ygbPusugD4Pwi8M8E2BI3Hj+ziovnpsC2mL0N+7+3ZWQsOZXK3KisEu/d+b40gviz5EkHI+T+4v5mqUWJwoPBrqlzi8qhoTzoLWSCOXEd9/gEmuK30+f/9wKDhmp94KlOkKlEiarXX29D+1lOcZjw2EsgzD2+UbXU1+aCGQCTbHQtKqzebrphuxpLsgl6uBOe1MXRhfFHewC9WtgI6BWBUq+DXPw/4VAf/HE1egsMxAvqf8ewKYW41k+nyXaUWCdHU5bG92XwCwwivPEaKcAENGInXjgeAL+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnSk16UvZJQeuVM1mTvpFojsgrIPMBOIl3U6fV80B7U=;
 b=YWUXelfas/czReDC9l6IinCiCoU6v2VPB2jXuJV++YV0YYPQmYkhAcRV6FJyxL9JlMSoPht+Yu4NK0GKYVI7JaZpLE4RzEfFWxwf5ttP52ogdrpY4I/CTX1SR9AVX5F6jXtmI5ZamS96yjbtunMN13Wshp7aQhbHWBr3TWwr/Ga5RA7H9NflcjFlNwIZBe+XUCgXzpHoVtP65IQBNhw3CQAsj5QTZfH6X+Um0nK5emqgZTL+/9r5OFkRYB/cEUzE8Qw+GO483U/god462O5lZX0WKVZSouDjHsPgnOe37DWFUTqpjZoqdL5LVk8RnilV+uSOoXOcQKEgcuotw5gvqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnSk16UvZJQeuVM1mTvpFojsgrIPMBOIl3U6fV80B7U=;
 b=T8Wm5UIwTUvY0onpomeT+xmKVn9Jq2Rw2aiYnySlIJZtRwY8mv0vqyAQp5I5j5pptWST4RQLLz6S7KJHVgbLE1FAqKJlOTpGIo2n2ry1W5uN/ZhV7u4IZh25RoDPULtldPNrxKsckuRTlPdCJfOZh6DjzKXhIlbjnrkqXfWSKeEQF3Ksz0PNxurjIy9+E+tr8pk8rbsuDHUkNGhwJn/1u5FYkpZq7OJ+CxJTmBnmXdbOe8GW1h6BMLQXWrP/8fxmaQIoE/fFeXLCCqxXkpbr0poLChN7Zq6XhHDmRo56iSpPbtcrIsNoYi442xxWGA7xB9eZxUE287ewtscG3BCUOg==
Received: from BY3PR04CA0011.namprd04.prod.outlook.com (2603:10b6:a03:217::16)
 by DS0PR12MB7873.namprd12.prod.outlook.com (2603:10b6:8:142::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 14:49:52 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::40) by BY3PR04CA0011.outlook.office365.com
 (2603:10b6:a03:217::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 14:49:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:49:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:49:25 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:49:21 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v2 05/24] hw/arm/smmuv3-accel: Introduce CMDQV ops interface
Date: Fri, 6 Feb 2026 14:48:04 +0000
Message-ID: <20260206144823.80655-6-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206144823.80655-1-skolothumtho@nvidia.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|DS0PR12MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: b68e96ad-e716-41ab-34a0-08de658efafd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+0KR467c/id2itm1h+usNuyVQkO+XioHnLYxaAqMB3txyYLYNx6pqzZ9inLK?=
 =?us-ascii?Q?4R8GriSrHsVSf193tegH+Zvyc08EBMo+0FFTJuymHT5nP9zZrOaer6ORXAYn?=
 =?us-ascii?Q?qzf6BzZC387uW8ow7yVZxEyiilil+M7drNEwaadbXifkvuPQ+m2C9BpRX4Vh?=
 =?us-ascii?Q?IlrDQOy+5TnRcWocLl/SZmhMr5Yi+4F9NXCx3k3e85aagzgWQj0MNS56enJl?=
 =?us-ascii?Q?7Le21tk5e9nLn+IkT/cI0zehz02cUriAji4xLffvlnSktNw+hZ4uOu9LuKzh?=
 =?us-ascii?Q?KzpetbW7RbiHqdgcVZzoQ+rfr7aATXwrPW7PdU3WWQO2baNxxnMpKA4/eik/?=
 =?us-ascii?Q?dZ4IgTe8ow+FN2w+Vzo3Hr5Sm0kShnyMW+X+H+FQWIO2BSowTo6dMuLA67kL?=
 =?us-ascii?Q?ehG3fqqOtwD1HWQJphJ4f4dvsXQsofmSyLAUM97y+fnMjP1nCTBgGBXeR3rv?=
 =?us-ascii?Q?277QhJnC8a2atfg73uXDj7XkJp96YyJao5zIlNOeSvfIUb7PmzCgp3JGj/2k?=
 =?us-ascii?Q?BsmoM9rZH5q7nZfugodFavqfqKA9bnm3wnA0L2UtQ6rLA5A5+MXKV0jc5hm8?=
 =?us-ascii?Q?vGWnZNQj4Zb+YJDaF0iRNZ0pEpW4IviKzcZnS+PfDGq3GACqJOSuZ2bnuyg0?=
 =?us-ascii?Q?WHDmLQBAn6PVdFqQ1CSgftD5aAjPW9wVR7QY7xQ4kaEfy0Uyo24WQr9sINBo?=
 =?us-ascii?Q?U/ZUG7HQPUuHhhNkAuTB8mUJIs1HC7skXADDb8PNeWFHf1EUkSb29fQGgiB5?=
 =?us-ascii?Q?ZS8keYkzhccdB2bodd2n6+4rRNosxZMX+NZ5Vjr9wcj1ezUMW/XSUwvP6nK6?=
 =?us-ascii?Q?Y62rXCU5thFqETrvGbZaP4jW4g2xyhVEsKmP/Q9OMhW3So6R5jJAtf/5FkaC?=
 =?us-ascii?Q?PrInF9lL6AI1AvqyP/VrSNG4Cq0Hco+5ctzCww7/QU/v0sn6A4Nb7bE0pSNi?=
 =?us-ascii?Q?J0TnGVR/2nr6Bm4FDdLnE+zlsgWUxLiF39DltNLLSUctq0+gVYFCqTzuTxJX?=
 =?us-ascii?Q?t9btTI8LtQ8dCMsoZNeXDv0K0Pj8+5namLIecL6yzPVCIPl44NsxaE12ar9X?=
 =?us-ascii?Q?hC1n1yR1g5pvV3zXFaILr54ppymJCcvd/qBlHWjMIoozRYl/nF55d2BY5YAi?=
 =?us-ascii?Q?w0jpTykyMc3j5+WplII8wlomQs1TxQgtAOPgvtxB0w4evj1E9QmZMgzbprzX?=
 =?us-ascii?Q?uMHTnoIVpoC1/SWHy62w+AM+w3iPnArWGeGeVNsAv7ZftHqVtF/TM6tEAHq5?=
 =?us-ascii?Q?IBAzTekxwklWU5H96tDxtQrf56VbikRq0GCvZBmmR1mCBANCKDiLMx8dCj+Z?=
 =?us-ascii?Q?D+GcJHlBSeDOFg8WWzv1/lyRkJ4kmtAA8XBo8KpDnXOGVSxsaKXyAakspsVa?=
 =?us-ascii?Q?UVnRiIao1tuXGOGHbupWdD1DFGnYou4x1ssp7rO6/VMSXXhdHN8ErspwyoLD?=
 =?us-ascii?Q?Yy7/eVy6k1b7oFkenjkaPbirF0zxa7m2S90Ub1dKHeNENRll2Ej+49LdT3X9?=
 =?us-ascii?Q?CxAAb9wFK234G86wh0EB7Gh47QNXC69lmJ1yxn6VDQwVviFgy0Vm0RTuLTBG?=
 =?us-ascii?Q?yEObz1DWdK4ZrDj6/qpXGr4YakmjCbrP47AyPnHe0TAvwXaPFcXlZML6dr0T?=
 =?us-ascii?Q?4E6Wnj4eLh85bRUE+5W2KuWKdrjxAoUj9eCRrWOdz7iBZ/6fyHxclSC2bEJz?=
 =?us-ascii?Q?5M3cGg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KSVicrrDh+FgnqpjhZIjQeUrxXjxUdkUss6X3I2pxIm1re182GyCfWGo9F7EQg83DarNny8O59euSbjJJozBUqehw+iPt53Tnr37cIOdVHw+7U6WhQamWtD8vKxqF/U4QJG024ttPolQXOSNZCm+g7KJRGdF9PE2koJSgIeuaSV+g3VqCZmgNVz+9v4WhMePQUs0LYRCtpWktlhL+Yu1t7KcnNDKFdoAiiQrP11jeE9Tuf1UX2e5yMjZfc9wuKupZfqXzAyCj0XgV7JuX4x5fv37VuH35VutCDTSSzeRkwyuxHIvHan5VWX9uAPZgDnN9s5+aunLnMn/FNESSUho2Q3604P88eh5lvoy2sS8pUNqSbbKhgb8unirdlGWGp4FgLwGhuPKia6oliWQC65fJxCWdPwAsgWbjj1Z9j4ntz6UuvVvuOu36uUYy6Gb1d51
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:49:50.1948 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b68e96ad-e716-41ab-34a0-08de658efafd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7873
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

CMDQ-Virtualization (CMDQV) is a hardware extension to SMMUv3 that enables
virtualization of multiple command queues (VCMDQs).

CMDQV support is a specialization of the IOMMUFD backed accelerated
SMMUv3 path. Introduce an ops interface to factor CMDQV specific
initialization and CMDQV vIOMMU/vEVENTQ allocation behavior out of
the base implementation. The ops pointer and associated state are
stored in the accelerated SMMUv3 state.

No functional change

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index c9c10e55c3..ca087240e5 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -16,6 +16,23 @@
 #endif
 #include CONFIG_DEVICES
 
+/*
+ * CMDQ-Virtualization (CMDQV) hardware support, extends the SMMUv3 to
+ * support multiple VCMDQs with virtualization capabilities.
+ * CMDQV specific behavior is factored behind this ops interface.
+ */
+typedef struct SMMUv3AccelCmdqvOps {
+    bool (*init)(SMMUv3State *s, Error **errp);
+    bool (*alloc_viommu)(SMMUv3State *s,
+                         HostIOMMUDeviceIOMMUFD *idev,
+                         uint32_t *out_viommu_id,
+                         Error **errp);
+    void (*free_viommu)(SMMUv3State *s);
+    bool (*alloc_veventq)(SMMUv3State *s,  Error **errp);
+    void (*free_veventq)(SMMUv3State *s);
+    void (*reset)(SMMUv3State *s);
+} SMMUv3AccelCmdqvOps;
+
 /*
  * Represents an accelerated SMMU instance backed by an iommufd vIOMMU object.
  * Holds bypass and abort proxy HWPT IDs used for device attachment.
@@ -28,6 +45,8 @@ typedef struct SMMUv3AccelState {
     uint32_t bypass_hwpt_id;
     uint32_t abort_hwpt_id;
     QLIST_HEAD(, SMMUv3AccelDevice) device_list;
+    const SMMUv3AccelCmdqvOps *cmdqv_ops;
+    void *cmdqv;
 } SMMUv3AccelState;
 
 typedef struct SMMUS1Hwpt {
-- 
2.43.0


