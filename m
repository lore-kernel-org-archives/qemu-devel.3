Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8479CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 13:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3E8n-0003v0-4w; Mon, 29 Sep 2025 09:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E7m-0002py-N3; Mon, 29 Sep 2025 09:41:09 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E7N-0003iw-2W; Mon, 29 Sep 2025 09:41:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQKg+PsLMtvY5upIg3HOSyNot/+Agssy3x59rrV57aVz5+B/N4lCPBTlWUj+ctR/rz/RE0JQTZI4CERye+6J3qKzoMb02JWYAnRFdSAmVWR3USinLOV4uJX4rHPGTVEJefG5WWafEVbbcZV5/lBGXQ/F7A/Zxq35F1mj/PTXppGZODAjXApR+Fs8bjTOGmaNhH500pOFgLPRMUeb92RN2qe4q+ogsH2OxcizChbouiF3MVekaDV24nhqSKeiAl3FKDwCdDFpqaAULKesLZIc0Cm6Oxw864BJBtsu7TS3MC4BAqbwl+8UO1QKimUpIwItbbbJ9EIuHOf3R4klsYuScA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9ZE0BNT4Jhz0OftsOucQtdejwxUJq4cIgUvY88/UAc=;
 b=pkWl3wWQhFQpDJPQcUxQzX7yaHHC4sdflqBZrBD9UmKtyICKEbvXhxxsNPiPrFeWA6kPS69COuBoGVjB1vdm8EbWdLQmdbiMTYPe/05x2Npwxo4YFOsOOSpsKwGC2mTG4zWjjVmm853VOHtHUQr/LaWLS83G2+a/4Ok2sPAyE7uveCW0t/+dGj05w/u68NZT/Mk6DNL2b6KLV9WYY+ejZbuwvto4KFDXycs7I05oJfjX9/fHTqM3sch46tW0lliZTUww5LN61geZLUHC5bmyUkXEBPBHd0R6F98H2fzK9nWfzTEpNiXTdRfHyKCzGdd+eSWdNaLnCKXzho7FMzOV4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9ZE0BNT4Jhz0OftsOucQtdejwxUJq4cIgUvY88/UAc=;
 b=n4ujZnICcCaYDrM/uQtUBBbIRso/Ya/Flycc9gHdO/usKGV/6StbG4CqcAtA3PaD7KYfYaF1kY0K9EFlMOTthl3ivWjVfw6IqmCS8yPrnkflyBlU7lI5RPK/XTRX89DM6wWHHCmT6+Bu7CnFujgF4bjhwJkQIq4M60gEXaSQ7IbLPmYtxjtguYGN9PSUMzdAEK2kljH+7EBHl7hyr4mdJtNacZtJ9go7jBRDU1cifRS5+g1hT0+LW1cmDnQnQhjR9m+guhEzx3LqRuuayxIhPJG48HJ70Er3XZ4P5yRskg2MQzjIto19InxgsUGHNV6Tln4vleT7c/kTPY8fiA5ZDw==
Received: from CH0PR07CA0018.namprd07.prod.outlook.com (2603:10b6:610:32::23)
 by BY5PR12MB4292.namprd12.prod.outlook.com (2603:10b6:a03:212::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 13:40:24 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::94) by CH0PR07CA0018.outlook.office365.com
 (2603:10b6:610:32::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Mon,
 29 Sep 2025 13:40:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 13:40:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 29 Sep
 2025 06:40:07 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Sep
 2025 06:40:03 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: [PATCH v4 15/27] acpi/gpex: Fix PCI Express Slot Information function
 0 returned value
Date: Mon, 29 Sep 2025 14:36:31 +0100
Message-ID: <20250929133643.38961-16-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|BY5PR12MB4292:EE_
X-MS-Office365-Filtering-Correlation-Id: d84a41f3-c1c4-4650-fbee-08ddff5dbe1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ctWaNVEPwuBqCJ/p79X0PKy0lj+sr8LgjvkksqjeS2bZuJ4ReVIADofC9gGm?=
 =?us-ascii?Q?6S7GWch1vdzZN2e77a4BSl7BTpxmbR2yGjy1x+9+r+jHiuOA9gx7iU/gPxzi?=
 =?us-ascii?Q?PWFfJp+ZCsExUv2FwLXZ4hxATemLDGX6CDGMvaf1753o91B3gWSwFKWjzipN?=
 =?us-ascii?Q?dZL1El0bAPEqgJzdFVM2QrVOM8QZZpMt31HkusErWtTDlHcFcdsNTBUsUU9G?=
 =?us-ascii?Q?ak10ebYeUNjbdfmcADqmse/ofSA9JqC3dSHn6kImoT3Ks5nuPIuyF5aeGD/x?=
 =?us-ascii?Q?CqTxVKF9fVLkMrtwlY8rXLjKIDYyUGXVU8p7yx0G2No3fgEc/VRcF6gulHWo?=
 =?us-ascii?Q?kI8gR1rIkjFeFCleOup50sdrWAbojR5M1/Oe8TqCYfnVyZgrr2Y/EMAiAKz7?=
 =?us-ascii?Q?8xrFHzq40eZnbr8DftOI8hHigX/3hyAR8TyH8KRi2AC83IEv+svxnvfkuAwd?=
 =?us-ascii?Q?w0xTwdU5NQNOeOwK7+NI5AxuP1Wy0r0LQ7GqYvBZeul/ouI1xJJA/BZf81iN?=
 =?us-ascii?Q?+SqrSMJc4FPL9E2nqvFNKDEGHuaqe+iQwJu1ws0O4gSADyMsXyUH15kAYttd?=
 =?us-ascii?Q?UDy+tAXeo8zxSC0benDcphBfezSdUhqCZG/4cGxBtwmxOXzZ5+eFvZZ4mMlz?=
 =?us-ascii?Q?9RtAskpikheufLkLZ+kNhy7ukcTLmT5KqCS++GTMo5Rae/cvEqUNrH1OvlRV?=
 =?us-ascii?Q?iRQduGOrMNdpavjL/mU+i9rcjNIs6JBl9+zh9hYtQ/7XSjjsnwJnFLLaVco/?=
 =?us-ascii?Q?7YzrLBbHuUSXBmr89lODUWGj+yl83tTOvRJhKzaN42buS4TGIws7oZ1EmAbm?=
 =?us-ascii?Q?rd42AzSOGR00UPqBkf4gPpXH6nv113F8+S34E/KJJK0Sb+E2ED5d+HVc4SLJ?=
 =?us-ascii?Q?94TA6K9aeX9VHoNZyY9Vx3z7d+699yMe3QxCVi2/eu4djkKLQf3qXv+Brv9c?=
 =?us-ascii?Q?thdqT2ICUllFsqbqxchohoTF91hLClL3fggma6gHk/LbpkxWV8LZBg6Q2W81?=
 =?us-ascii?Q?WsPgNjD+8upD1fECyZUmx/SDKLmLr2DtbdQpu7oydhP7f2NDeOhsK6rRrwOL?=
 =?us-ascii?Q?RIBryBZfcPmrb46E5zayVXaWsgln4rACWyYarzDWQwn9XMfADLMO7NQJw65/?=
 =?us-ascii?Q?YOpktv8CJQltCM+4++CaQjN3kGE9mwpFupED6Rm6QsMejcGOldBlDHB+s/j3?=
 =?us-ascii?Q?FP9DoFIZxg4/8Uca57DHJQJRCc9LGHH71o7uyTDZy5JHpvJ9bi1BbB+Q12Ep?=
 =?us-ascii?Q?lRr2kF975SbTj5YLhcg0JVuzdfD7jQBOgd2NRrCpEeDcJ/ub9RIZRzifjS59?=
 =?us-ascii?Q?CbMvuvlP/uzgNjQ+PJABezSYf+Aj5GRshEABY4GS7Yu6Cikg94YtuhedZpYT?=
 =?us-ascii?Q?T66DtWlWr6KPR5+0l1GRWUFq1mXSbDt+QxQNPoExq3a1ZFXMXkf8cncGXAwN?=
 =?us-ascii?Q?x0EzDFYyMdSR8OLZpfFxM1UuWTOUO12hhBDdqj4YGHy8hvbDNIUjlPqyxWDt?=
 =?us-ascii?Q?+wwoVRyGJiN0+YbWW1pI0SIDnrSay7YqGNTOxteuamAdn0o0S9IbdDsQ7bx+?=
 =?us-ascii?Q?CK/fcIJLWFoBhWYJVuM=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:40:24.1641 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d84a41f3-c1c4-4650-fbee-08ddff5dbe1f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4292
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

From: Eric Auger <eric.auger@redhat.com>

At the moment we do not support other function than function 0. So according
to ACPI spec "_DSM (Device Specific Method)" description, bit 0 should rather
be 0, meaning no other function is supported than function 0.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/pci-host/gpex-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
index 952a0ace19..4587baeb78 100644
--- a/hw/pci-host/gpex-acpi.c
+++ b/hw/pci-host/gpex-acpi.c
@@ -64,7 +64,7 @@ static Aml *build_pci_host_bridge_dsm_method(void)
     UUID = aml_touuid("E5C937D0-3553-4D7A-9117-EA4D19C3434D");
     ifctx = aml_if(aml_equal(aml_arg(0), UUID));
     ifctx1 = aml_if(aml_equal(aml_arg(2), aml_int(0)));
-    uint8_t byte_list[1] = {1};
+    uint8_t byte_list[1] = {0};
     buf = aml_buffer(1, byte_list);
     aml_append(ifctx1, aml_return(buf));
     aml_append(ifctx, ifctx1);
-- 
2.43.0


