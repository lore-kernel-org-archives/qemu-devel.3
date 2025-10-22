Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6203CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 08:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBTuC-0000L0-3S; Wed, 22 Oct 2025 04:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vBTu7-0000Ki-Rg
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 04:09:07 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vBTu6-0001yQ-0o
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 04:09:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmYeZGlogH2CERWxjq9CA+Dr+OAlY147vPF8UFCVv72UJkSOC8HtijCWnIUdfYf1adY5LFyXkmfi6H06a/dDvKnvrMaZBxomhq5SoOCPV07m3xH7GuGJ7/I4chcuMeOxNsnEc22sUEvvKrFkVLxEfqnJrHmqdZ1QNwxcnlHGm+LKEtw5OaBhTgYb+wI79g8SE2KSKv09LKZIHCVkkpAVjRER+I8r7BYwdYqLufC32wNXvcyPZBdRRZMpS0I3Pln/+tGte+xn1veJZBb0DzC40YYqVCeYGemy1dazMUZW0YyA3DkZADF79KxNXCx4iSZ+jjrQb0vOU3cFlkxISYu57g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJBhvcFKY897vnt0+XsT6f6xdYujCNcODJ/XuFtGe4s=;
 b=bKZDNKqWIlmua14CSx6kqqfyPZarVqRn7b1uA5e5gNR2habs4MiPcjIpkqht5DcgrToOq+3ceZtMuk1za2Zl+1EmlFrYVCEpRqUXJfzchhmQdt6NxbYlWY4bEBuMKLRm6/BWGk8lWIOcw8N+p6LzLamIgOhv9i3WeiLwCJ/nAv44CqcF7AtrwduJUO63axIk5zq3t24ItdMwgpOqIMty1a75bS9ovvb0fw54IbJ2B9wVpUn5qi/sNl6xtGclfQMtBQICO1Fl0GM1gScy8Ovn83tMCy9nZo8aGURS5ztBN7IEuh1BlPojj7AxSChGaO98upWpUHhzdUUveaDh0TZN8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJBhvcFKY897vnt0+XsT6f6xdYujCNcODJ/XuFtGe4s=;
 b=KIqZ27a2G8B2MmrP7DoApDGKqMYQ1H270SQb7ZwkMI9lSqSxJTNqhMQ5fWnLdsOmm+VQeC3ALQaPwlPbqwiBQkPFMaIGUxrFdiccjWaKQ9ck7xfZU9HwOKFlzBpkANYyaEkKJQliAuOVI4Xzbao6EFscK2rfyZPbBDuHnTjIl/VHWAEtagmcfH3z2/p+oHcHRlW60FJpUhu3MKZZQWOggQB2Bq4WOrcAl2JTjlj4UjDyubIxv181J/Ny6eTGmyLIIDn8T3nDmeAY9rkzGeu7WoDOftTuuK90TtBxWVCe33SkE6du9Qe9zE6Y+vfBAbr7UHliaEbXJCMqe+cwa/It6Q==
Received: from BLAPR05CA0004.namprd05.prod.outlook.com (2603:10b6:208:36e::8)
 by CY8PR12MB7340.namprd12.prod.outlook.com (2603:10b6:930:50::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 08:08:55 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:36e:cafe::e1) by BLAPR05CA0004.outlook.office365.com
 (2603:10b6:208:36e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 08:08:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 08:08:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Wed, 22 Oct
 2025 01:08:36 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 01:08:33 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <imammedo@redhat.com>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [PATCH 1/3] tests/qtest/bios-tables-test: Prepare for _DSM change in
 the DSDT table
Date: Wed, 22 Oct 2025 09:06:37 +0100
Message-ID: <20251022080639.243965-2-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022080639.243965-1-skolothumtho@nvidia.com>
References: <20251022080639.243965-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|CY8PR12MB7340:EE_
X-MS-Office365-Filtering-Correlation-Id: a250b9ac-565d-4fd9-f004-08de11423e64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFl6S3dudnJjWEQ5ckM5OTZSSWwyMXlET2ZzVnBWQktTcEtmYUJ1M2RoeVkz?=
 =?utf-8?B?OStHVHRYY01NWjBNRWRSeDlQY0JlOTVxbXlIbDJiTHkvZG1aUGljSjRlZVY2?=
 =?utf-8?B?ZEh2bTB3anFmK0M5Q2VhT2tDcTR6K0pNSXI2S0Y1akdqRExDaEVsV3J2Zm1i?=
 =?utf-8?B?Y1hQcW1XMThyekZkcVpnSnFsM3A3UlBEVENnem1UZ2hCdDVkYWZDNDJFbW03?=
 =?utf-8?B?cERuMnUwK0VyZjJvVkFCZzZyRS9wRk9FSnIzU0R2aVhzTUt6YlVyWmNUUzRa?=
 =?utf-8?B?Wng1OEdIb2kxQ1dKbG1nZHRYcXQ2RUl4ci9DSlFJa3F1SGFiK3pibG9pVUtQ?=
 =?utf-8?B?RHVSeHVsMWlDeitUbUMzOUczQzMvS3hJZ1hYN1F4dHNlT25LSEdFaFhmVnB3?=
 =?utf-8?B?cE5RWjRjVVA1OGF4cXVieUdSUzRST2hFUC9OODRybkhuN2t6YU1VZC9UZFR6?=
 =?utf-8?B?WWV0NURtcHVrSW9KSHdXZVNyNWh4YzZac2lBWkJPSFJVbFYxRy9uV0dsYkIz?=
 =?utf-8?B?UEJ0bnNXdHQvcXBqb2wyODU2SDhRelQzMW44M3lrOXZ4eDZZQThiYjJOZzJM?=
 =?utf-8?B?U3ZTNnVOaVFsNGxNZ1NqV1NEd2ZMQko5N0wzbERKR2hEc3dBRjdBV1ZWTEU4?=
 =?utf-8?B?NndXd01pcDdzcGFYRnRBM2JVRjhWZncwbXRieGlCTEdEWmZXUklWRFIvR2Zi?=
 =?utf-8?B?aDlwTGdkbVZheEpPYVBpN00zaXpkOXkzUmdHS1IwdG5sdlM5UHduRnVzQUtC?=
 =?utf-8?B?YmtNZ0hydWxpd01sS0p6NnVMTWV2NC9SN09tWVlzOHliak1JeUVsamFQNjgw?=
 =?utf-8?B?Qnd1YW90eEdlNllsWEduNW45b3VYaUtLME04V3FvY0lITUdkSjIvOWl4bjlm?=
 =?utf-8?B?UFVYRzRQS0VFT08yRm4yUDRoRDBWVDFCVWJ3ek5MVXQwMFFzb0lQY1UxNWd3?=
 =?utf-8?B?NllOZXJaRG9zOG13TUpBSThndlpjcitGUVBPZkl6VUlRcnNiZC9nbDZ4QTZ0?=
 =?utf-8?B?TERDWjJ1NU1qZE5DYlkyYmFUWkdTNzNjYlU2Um9qUU44NTVEeGtZclhMMjho?=
 =?utf-8?B?ZzlLeUZncituNTd0dHRnSExRYzNVUk5hSlVvdkhLN1JHQ05rS1hPU2VWYS9h?=
 =?utf-8?B?STdCQjNTRGxvL2JJWkRXSEF3d3pzYzVJOXViSlRzcnhieVhOeWZuVmxHRkpa?=
 =?utf-8?B?Y3g5aVhmcFlDelhTUWtCV2Q2RkhZSHU5OE9SKy91RVl0NUM4RDZXdm1aTVZX?=
 =?utf-8?B?c1FkRXhkWVpvT2NObm5LRk5IRTFZbWVac0VHbzRGeGJucVZpSGNjM1VOamht?=
 =?utf-8?B?TGJiN2JvZ011NlBlRC94TlF0WkFBSlhycU0xYi85TUZFSUFjcjk4UDExOC9V?=
 =?utf-8?B?WFFBMXYyUURERWJIRHlWN0R1RnJNQzNuQk8rYnJGb0Nydi9VOFo3TWhzRFd6?=
 =?utf-8?B?WGhWQkI5Q0JaUjIvYXNrSlZEZjk5VVlYOS81UHVRYzFYTmNFTmhHVDFxTWI2?=
 =?utf-8?B?c0FINzMxTC9OUHkrSGFHa2k4eHg3T29EOGMzRllVUUEwSTFPTCtHaFZlUWlM?=
 =?utf-8?B?NC81c0ppbzZVR3g2ZHVRREJCdVdHMWNHNWpwM0tIWjJvaE5ib2F5YldNUDY0?=
 =?utf-8?B?MUlYUUpYRDJsUlgxS3dKVlNDQWdrUDd5dkRpTG14RmFVY01iYlVpSWtWZnFw?=
 =?utf-8?B?YTZmUDdoamRaWEJMZFQwS0JZb2RFeGNtdDRSNHhBcFNVM3RtZzFlNFMzWVZI?=
 =?utf-8?B?OVc2UzJrZGMrV2JOOW42UW9sTjB5M0RSd0RnWG9UTGhoVkhLTnpjVm50SFly?=
 =?utf-8?B?ZnVpemZUcDE5UFlHWWtERGNSZVpTT3hzWHVuM1lrL2UxaUJhR3gxMFJpR3Jm?=
 =?utf-8?B?UUJvdHdYeXhYell3eUdaZVUrTlN2RG5nVDJESC84cVBCQ1RncmpvVHdUL2dU?=
 =?utf-8?B?TDlXNEwwa0xXZDFCTk8rWjBEdE1ZNThPVERoOEppNUJ6cWdZVFJkaGQxbXR2?=
 =?utf-8?B?eENHcUtwRjVEQnJjdjhqellTWnB6cDYwWkdqaFJYR1VTWFhidi9NTVF0aHlL?=
 =?utf-8?B?YTVqQmF5dmdPSGhZaXZ3VUdBREhvWUtzdkxGVFlNc1N5SUYxa0V4Q2NzcnJW?=
 =?utf-8?Q?xAt4=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 08:08:54.3670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a250b9ac-565d-4fd9-f004-08de11423e64
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7340
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
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

Subsequent patch will fix the GPEX _DSM method. Add the affected DSDT blobs
to allowed-diff list for bios-table tests.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..e2fce2e972 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,17 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/DSDT",
+"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
+"tests/data/acpi/aarch64/virt/DSDT.memhp",
+"tests/data/acpi/aarch64/virt/DSDT.pxb",
+"tests/data/acpi/aarch64/virt/DSDT.topology",
+"tests/data/acpi/aarch64/virt/DSDT.acpipcihp",
+"tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex",
+"tests/data/acpi/aarch64/virt/DSDT.viot",
+"tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy",
+"tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev",
+"tests/data/acpi/riscv64/virt/DSDT",
+"tests/data/acpi/loongarch64/virt/DSDT",
+"tests/data/acpi/loongarch64/virt/DSDT.topology",
+"tests/data/acpi/loongarch64/virt/DSDT.numamem",
+"tests/data/acpi/loongarch64/virt/DSDT.memhp",
+"tests/data/acpi/x86/microvm/DSDT.pcie",
-- 
2.43.0


