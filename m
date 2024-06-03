Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26318C41513
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 05:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE09p-0004X7-QJ; Mon, 03 Jun 2024 01:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Shivasagar.Myana@amd.com>)
 id 1sE09m-0004W7-Rm
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:22:54 -0400
Received: from mail-dm6nam10on2046.outbound.protection.outlook.com
 ([40.107.93.46] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Shivasagar.Myana@amd.com>)
 id 1sE09k-0000vR-5y
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:22:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gqf7a+AmZCtm+rTdEJd9VTX1le/BkfCiOmO4i24xuAHRm2jizMcxhkei9XNmwy17rNtZvVOWIChzZHjw0upxUrqOIi7LA+8E86bJDD559/I++i0QwPObbqntll13+aYUF/KuJwDJPluBE5k5sse79dPepLU5BC8dZqea9QEb98pBzqlH8p6DKItV5OELS86oy8DgOopIcHm/lDUKURNYWnt173DLCKJj7ZeKlnTEmBkB0sbtmlJYCERkpvgMzYg+7WgZ5kAZZ9ZaT3LDaA3C/l2GPAjYIfkzl3XRk+mlRvMOpcAonaPhkL3d7Ge28WV9WgSB35QmvEbkeBB5xlwK9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFJrrdDgUxmJG+fhMLgr0y4da+l8OpIwBifKFxEymjg=;
 b=kk3BI4Rc0nIQDWi2VSoKad9i7EY+s0QzN80POKFhiTIqudvpYWfOsioM/WnXpKz66iVmeQsNo86I6jc6v5M5NNP2Mvc+iuAa7YluQ6ZHDbLOQm7F6zIgEyf8ueGcQ2nyh9kd+uXLjFcAqPZ4t6AcsTJ+ezCQGlR6jyZPRXsMkSsyEyARbEJFH7GhzvrROK983eQzmVOmPZLimUDYSzo0uq8M9SnQZKQ2OucG5cNYvniZ4IcWvO0lTJX6DQyKj1IxPbh4475BW2elK77Mwcf5xgCdAbdDpOjjdMqNxWM/Q1Wyz1+Tb0i2k5Tn59//pMq0Rrfp90vHnDeVHYt5lGF/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFJrrdDgUxmJG+fhMLgr0y4da+l8OpIwBifKFxEymjg=;
 b=gjw2j3VPH9vTc8L+m8USRp/txmCSUHTMxyVmJFRjZ3UqaAXHI/TGj8cuH4N3doKAFZWbfgFbP1JJ2EF3fB+XaouR9o3B8QMr5tljbIQJ9APsUr+paopQD/5Ae6TYqBtM/g+7nSQXEATQ7yuws0g+9JC9dP7hCjRNlLSsjbvBVSs=
Received: from BL1PR13CA0131.namprd13.prod.outlook.com (2603:10b6:208:2bb::16)
 by MW3PR12MB4425.namprd12.prod.outlook.com (2603:10b6:303:5e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 05:17:44 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:2bb:cafe::ac) by BL1PR13CA0131.outlook.office365.com
 (2603:10b6:208:2bb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.13 via Frontend
 Transport; Mon, 3 Jun 2024 05:17:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 05:17:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 00:17:42 -0500
Received: from xhdsaipava41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via
 Frontend Transport; Mon, 3 Jun 2024 00:17:40 -0500
From: Shiva sagar Myana <Shivasagar.Myana@amd.com>
To: <francisco.iglesias@amd.com>, <jasowang@redhat.com>,
 <qemu-devel@nongnu.org>, <pisa@cmp.felk.cvut.cz>
CC: <peter.maydell@linaro.org>, <sai.pavan.boddu@amd.com>,
 <Shivasagar.Myana@amd.com>
Subject: [QEMU][PATCH v3 1/1] hw/net/can/xlnx-versal-canfd: Fix sorting of the
 tx queue
Date: Mon, 3 Jun 2024 10:47:32 +0530
Message-ID: <20240603051732.3334571-1-Shivasagar.Myana@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Shivasagar.Myana@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|MW3PR12MB4425:EE_
X-MS-Office365-Filtering-Correlation-Id: db0c18a0-6e1c-4a49-36e2-08dc838c7f94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400017|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3Nn0FnjNUGsvRzOIQDbxrAWe3HnTfRWk+1502H8uYPTEjV74L0jWe4Lv2aLi?=
 =?us-ascii?Q?RpxkyRon/eMBPUNJCUeZMj6NjOLRv21HXBuf3uSjWVe+BquCqssehXeQTfXc?=
 =?us-ascii?Q?Vha/we8oQQvIKdBWMtobMndUINjiB6DWH/XrLe8BBatXQsbcUrMkZIeTF3fu?=
 =?us-ascii?Q?JtbJlCX7cIPI182QehKqaZ+8YAoY0Rf3K673exifC8nl01LkkOjz97OmZkXc?=
 =?us-ascii?Q?BIyGsS31wOXzmENjJIPRP4QZudiEmjiyMmdnfmr7twIwN3oOO6vjig8vRvL0?=
 =?us-ascii?Q?O/lDbVWCgd6osuPu4hq/OSHnzQP3OSAaLkOFbD9gy73oAQOEjbLqiJkR2qo5?=
 =?us-ascii?Q?l1XTwlyIElncWgNkzkBziGPW8iSH693a0RpPezNvFfS2jM5KpjkX2zg43BOu?=
 =?us-ascii?Q?q/JkBFHcnW8iM92LQ/A8eWLf5Qe5llxKe+b3NL9UgbXr3W8k/HHyV1kH16e3?=
 =?us-ascii?Q?NB3MFBBQpVkW1qbvL1oe9mw0DPBzm4NRxTjWhjltgm4918pMGOHxqpLUV1le?=
 =?us-ascii?Q?L4avAmPNV2O3HxwuxBHBw6EceJnnSEkfL3A2PHAr3G0fTHqUIRHy4SQ7fZPk?=
 =?us-ascii?Q?DtSrhbfoMfGmoAl1+wL9LDII6rExiQMR+uxThltGlgwc9xWEMzCLqTglA4HQ?=
 =?us-ascii?Q?L2kC+CghjDD+Tbl9hrLOUSOs79+FGM4d6/RjIp9p85/PV8tr39fObIwPSqCz?=
 =?us-ascii?Q?IS2Wn8xZtV2B8LIr5KBrcR7smPd8MenZzyoJw9dvoZDx/USk9eNbmH+DdMKe?=
 =?us-ascii?Q?hBN2NQaJq8OfMSDtUvY1d59hByz98mxMHfiOLR5Ue0K6Kf9AhMUIFVzF+rPR?=
 =?us-ascii?Q?QWjltDqUQ9GDZfUMV+qtksISdvhroDxejB+SCploFhLo/Vh4ZPqjN/gYoGrN?=
 =?us-ascii?Q?MG4E+3moF3w9J8TOEefqngg9fuUEgGud5Zv2nCeo535RqLRPV48hv60c6NTR?=
 =?us-ascii?Q?xifSVEtpC1iI7Myy2tcCFR5XQ0Jod3tKSO9CVfuz4d7t96/Hcqkfnr/sQtZE?=
 =?us-ascii?Q?cVJWvOGJr26MyWOL7wbP1suaR1pWnpObYV09qknB7A7YJTaGXqrnufrUxTt/?=
 =?us-ascii?Q?9UuH7yG931CfoNlQ7EPBQ76X5zNLc6qoAwuG21MREIhi0RonOpOcr+P6pUIW?=
 =?us-ascii?Q?6xASU6cFfRES4PNuHBcc7at8ZBW1C0l9kmShBZiwIdClbBQn9wZeg6qjaa/2?=
 =?us-ascii?Q?J8CVhdHZxq6L251LnuOEolwQtayjxSbp4FnXHgNpy5ZPr3kBHncJr3GQgvlQ?=
 =?us-ascii?Q?95Widpi4qnpwtXy74Irg7+kJ6pqqrjwuUvclLVpzN/+KDobCJB9SbOwiBB35?=
 =?us-ascii?Q?jSMcvu6hWNjgIw0O5k9vs+Ww47N4Oyzbl8pwmnB/6l5yNJ5PPCGK6698CjBW?=
 =?us-ascii?Q?2pqTTd9ISm65+QNf0KU0DkA63Ici?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400017)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 05:17:43.8378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db0c18a0-6e1c-4a49-36e2-08dc838c7f94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4425
Received-SPF: permerror client-ip=40.107.93.46;
 envelope-from=Shivasagar.Myana@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Returning an uint32_t casted to a gint from g_cmp_ids causes the tx queue to
become wrongly sorted when executing g_slist_sort. Fix this by always
returning -1 or 1 from g_cmp_ids based on the ID comparison instead.
Also, if two message IDs are the same, sort them by using their index and
transmit the message at the lowest index first.

Signed-off-by: Shiva sagar Myana <Shivasagar.Myana@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
Changelog:
v1 -> v2 : subject line is modified.
v2 -> v3 : subject line is modified from "[QEMU][master][PATCH" to
"[QEMU][PATCH".

 hw/net/can/xlnx-versal-canfd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index 47a14cfe63..5f083c21e9 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -1312,7 +1312,10 @@ static gint g_cmp_ids(gconstpointer data1, gconstpointer data2)
     tx_ready_reg_info *tx_reg_1 = (tx_ready_reg_info *) data1;
     tx_ready_reg_info *tx_reg_2 = (tx_ready_reg_info *) data2;
 
-    return tx_reg_1->can_id - tx_reg_2->can_id;
+    if (tx_reg_1->can_id == tx_reg_2->can_id) {
+        return (tx_reg_1->reg_num < tx_reg_2->reg_num) ? -1 : 1;
+    }
+    return (tx_reg_1->can_id < tx_reg_2->can_id) ? -1 : 1;
 }
 
 static void free_list(GSList *list)
-- 
2.34.1


