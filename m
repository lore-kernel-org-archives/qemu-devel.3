Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BAA5D2502E
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 20:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf1Zh-0002JQ-Gu; Sun, 11 Jan 2026 14:58:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Zc-0001qo-JJ; Sun, 11 Jan 2026 14:58:04 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Zb-00047A-97; Sun, 11 Jan 2026 14:58:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUf1jXKZm5WNGmvNASYphlb3/8Ir9mE0fpj0Rbeh6pDFPkBzAFdxdcR7xIgmFVPiodNLd9dpLuLDASviH9OE/cBQ9dWalnXevvYZmmmhIjSjJyL2XA37yNzrginJvUuUx1kNk30rXXz5oKdG6ofx6CYirKLK1QMwhIiMwla3Wt9HxwfzmCan9qyO/1dqCKAIjlhjxivUAUB0NC30FuM8uc95HZNC/xJDiJTKUTHpkGGsk6FaxpMDAINY+mq0T5Qc+Gx1kb5IpNoHEsWbYjatRZtlFn2U59FnsON3dyRPQHZhyn7psUef3wr4DnKgg6H8veSm8MCq9fqhnEcw8s4g7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OzkA8b+f8qKwpdhODuHsX7V5qTi6RBSGKjXN2gEEb0=;
 b=vFNU6AlsFYDz6420jXm/gM2ZH3u329x7mtNt+WV3AvltWaH8f/UVyQX+NrRIACyx7xEs0XPEKqN8XnO45IrwYAGuMLwSJiT0Y+4HKfYNYtC+3KrK9TYsCRgovl3Asta9dYU8EcgN0osQpPecWADgb/nWPAJ1FeoEefmTJCMULVgxesZMNR8GgJWPU3G/xrWqRZH7MPNzx4/ovN3Z576KJA9356XXBTJHqHWE1vx5LoNxEkHk9pflnpwvobDp86b2fyR02f/J12/Z1otMqhGIKxLm+Bv9Z/DvrK2swwffVgoCMsixOqCNCXlvXN0riJuZv1PILmfQaueE2csGaYqknA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OzkA8b+f8qKwpdhODuHsX7V5qTi6RBSGKjXN2gEEb0=;
 b=QXUFQysxDLDBjidDjCgx0+ipdKy5uGzR49Y8ybtgBwlcFxSjmLhTmF85nQW9cA+g4zXyudwRyNrsobWpgOHGnE+dlYrH90xfW0r69Sd00AZVKwSj2EWPssQo30v08sUcfzwi9umMbO0ohmvoGG1dhD6jmeB8A78KSPuHkDY7GWEMTXgbp5fWgTATGlj57rlb8UKlP0O+fE4KIFGDNkLYrZyfMaxZyvafma3XAPZi5dYmcKV9lWluTpnOVg7lbZkRlr7qEfC4gPPECr4/WDEG9aTx+bmHjqGE+CUUGpwgD5dD96y2979ij4rz5/IhLSC9m0/pFhWoMpaRyQY2pCsm5w==
Received: from SA0PR11CA0020.namprd11.prod.outlook.com (2603:10b6:806:d3::25)
 by CH1PR12MB9647.namprd12.prod.outlook.com (2603:10b6:610:2b0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sun, 11 Jan
 2026 19:57:52 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:d3:cafe::d1) by SA0PR11CA0020.outlook.office365.com
 (2603:10b6:806:d3::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Sun,
 11 Jan 2026 19:57:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 19:57:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:57:47 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:57:42 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>
Subject: [PATCH v7 23/36] tests/qtest/bios-tables-test: Prepare for IORT
 revison upgrade
Date: Sun, 11 Jan 2026 19:53:09 +0000
Message-ID: <20260111195508.106943-24-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111195508.106943-1-skolothumtho@nvidia.com>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|CH1PR12MB9647:EE_
X-MS-Office365-Filtering-Correlation-Id: 37d6bd06-3c81-43c6-f4e0-08de514bb3f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|7416014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXpkUldRaHNVT3ZEQnJrV2FnUEtTeGduT2JNVS9TYkZNUTA1ZWlTRmVHREph?=
 =?utf-8?B?dDhrRHlGNDI0VUxqZGdPYzJ5WjQzdm5sK1ZOajhtRHI1cXp4cmtxemx3bXJw?=
 =?utf-8?B?c0ZtVVdGQWlyb0R2RUNyTlI5WWpqOEo3U0ttQ3RpdlJJcCtwSzU0VmFGbjJn?=
 =?utf-8?B?c05Nd2tUYm9uWHJ2QkpvWldNTWtxSUlPT1YvNzZVdXpJcW5vS1EybHJqTnF2?=
 =?utf-8?B?VFp2Q2tGZEYzSUMwL0FWMWlvQmRrbm1iUWVsY0lrZThFL01SM1Z0N0cxR05j?=
 =?utf-8?B?QnhyNmdiQXhFQTRSb0lJaFdyYzA1ZUoyTnJZazJNM2JLcEpJZ3JaMFdlc0Ex?=
 =?utf-8?B?ME5NbkhEZXhwenBYUmM3N29MTkNRYWVjNVcyRVE3cktERHJueEFsS2VuZUdD?=
 =?utf-8?B?TkhwSU01TzNZTWRrT0NIY2RCVENuaFJxN3lic0dRenBMUEVUMHdTcDYrWlRH?=
 =?utf-8?B?d2FRclhERnRmdUQ3ZTl3aW5mUEcySGZWNnVHOGl5cXBYdWJ3TGh4OW1DWEYz?=
 =?utf-8?B?M1kxL2lLRXpFRFY1enBkMmU3ajRLeS80OXJrWnFibDlOWTNxODBDOUxXK0ha?=
 =?utf-8?B?TDF1cFBmYk5lRmFnenRKSFNsS1BSS0l0akd5RzI1d2hpcTQrWEY0V3MvRVlW?=
 =?utf-8?B?TE9zWFRlNHp3VFBYQnY3S0RXQXdiaTR6bGRsaUdFT0twb0VKcExrTUpzSDh2?=
 =?utf-8?B?RDYwbVcvUnNmem5TdVlJTGhCc2JqazJkbFRhaFcxYkZFQU5KNWVrb2R5bWdl?=
 =?utf-8?B?a2JvYXdGaURvb2VycGZRZURSVEE2cHNBSlRJbkIvdDdXTlMyaE1HcSthNEhF?=
 =?utf-8?B?TElvbnVjZmJ5R3ZraVB2OGFmSVJqVWVGVnBaTmdPaStKaDNZUFhSVHk4d2dm?=
 =?utf-8?B?U0l6QXg3MDdRcHBabXJtUnZhbXlOdDZyS2hGWVZuOXlmRWhWTnEyWlIrRUNq?=
 =?utf-8?B?N3JXMUgwalNiYzVlZjg0M3Y5SzZGK1NHL0hCY21ER0pQOXJZUlBudU1uSXgv?=
 =?utf-8?B?OUJHSy9CNWlhZFlmSm1OenV0dXFud0JnTjdnaTZJM0RpT0JUSXlVZTFqbnBP?=
 =?utf-8?B?QXlHQjZBMjhiSmNNYlBSZ05GWjdnUTFyb05LZitTU2l2ZWhEVGN4Q0NiVXQz?=
 =?utf-8?B?dldTNGpxczFHejZ1bnJ5LzhmWXhHMU4zMEdQQkYrbFMvRjVwNmxPNU1VQ3Z0?=
 =?utf-8?B?RlZxUWNxd0FxT0U3Mm1CVWM1SjBPdUJ2c2w4dDJmdEQrbE50NnlDaldzQndP?=
 =?utf-8?B?aURFK3lKVnFnMXUyS245clRNS3V6ZHZReks2R3gzTmxVNUc4cXh5dk5VaTg2?=
 =?utf-8?B?azZaY0k4QmJrZFA0eG5GOGZxQzdJSXI5ZHI0SEV4LytwRERudkI1TEZUNXNB?=
 =?utf-8?B?K1FHeG5mejEyekxsUnR2dTludlpyYjJVZmQzV202bFJSWFJiOGRNQUpIdmtF?=
 =?utf-8?B?bUw0d0ZoOEp4R0ZqRzZnZ1Q5VlA0OERqR1JDU2E4VnhkZDFzc0o0WUtUbEFG?=
 =?utf-8?B?NjlDQTZEUmVoZTQxL0pOVkE3Q0diaTJWRlp3WDJEdHpLZDFqVEUxZHo0aVMv?=
 =?utf-8?B?RVArZllpYWtacG5kUDNDYWk4TmhqSWRFa1AyS08wQXpJWDJkeFNjZS9YTDBE?=
 =?utf-8?B?SVZXd3U5c2owRFdZUFBpblZWcjk3TzBET1M1Tnk3VHlKcktjS29ZTGFkdThF?=
 =?utf-8?B?QW9qQXdOY29LNzgxSEVNNEludDBXdFkvTVVqQllxZ3lRUU9uMnMzbE45T3pa?=
 =?utf-8?B?MVpEWUV4RHNqVjlNZ29IQ1ZiSG1LUUxnWjVLYmZnVS9vWHplUlVIKzJYNUZU?=
 =?utf-8?B?NzVlcjlwVHY2WEFMSzJORElNQjFPQ3VlSWlxR3RNSnE4SG5QQjhQZnpXaDVw?=
 =?utf-8?B?aDZvWlRoUU00VjI1U0o2Vyt5NlJMdUNTdmNtYi9mclNZSTNaeWlrUko4UWJ5?=
 =?utf-8?B?YVh5b2hkQ2F2NDBJYy90RlVNU2ZrcG9pUkxWV0M3S2pJSGJNTjBmejNId0V6?=
 =?utf-8?B?NFFxNjk5d3o1OUY5djRYZFIybjgzcHdUcXltUFhFTjZKRHkxbjZzUUFVdWxM?=
 =?utf-8?B?eEhiTWF2di9sR2tkb2hCZVM3YVN0Y09wd2NXV01WR0VwaTlOaEc2L1I5UTN4?=
 =?utf-8?Q?Krzc=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 19:57:51.5279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d6bd06-3c81-43c6-f4e0-08de514bb3f5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9647
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Subsequent patch will upgrade IORT revision to 5 to add support
for IORT RMR nodes.

Add the affected IORT blobs to allowed-diff list for bios-table
tests.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..3279638ad0 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,5 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/IORT",
+"tests/data/acpi/aarch64/virt/IORT.its_off",
+"tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy",
+"tests/data/acpi/aarch64/virt/IORT.smmuv3-dev",
-- 
2.43.0


