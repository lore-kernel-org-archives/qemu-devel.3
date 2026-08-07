Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80B6C5AC9E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 06:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsDt8-0004Yx-IU; Fri, 07 Aug 2026 02:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wsDsx-0004Sy-N3
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 02:16:57 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wsDsv-0001jy-AQ
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 02:16:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XC3QSoiSZDnR2pCGVBlL+1Ump7RPey79imdPfWgs1aji5Ml7OnKB9beOAn3B3FwnNe6h7IFcUtqu6uNpOTpSxcMkDOhgtFm1i8evg+79KL9vgk9PnrldAT9W82habXlgvrcJLva5koZQ5ymLUTqbIIw2WY9jfg/URLiHSQ5rQQeBiZVdMU35dDplIk1VWa/rz2tRdo9xYtsh19Hk2YomsY30yQc1CJFiegpNKYTjjEyT3pXRP8qW66daOrF+U+NGHAxa/Mm9h/mEWvt14fEDMbCx53qO7lQUJFfx6CGcIFm9FXIZOT5CaAxvxzfFdygSUzON9LWbq6SlIBSjiJvJ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5OwHnAWVM04WBVJ4uXYlg5PTUvN+OAwYYRVBlDS71I=;
 b=r9/f+dAFLnFcb7zckWD1Wf6H2ISFmBHYXl64fcxhgjlo4qVTD+keY2iK8LZIag+NYInrdc4qbFugOrP08D61JtYV6KaRkxe5EfJf2ZfGmvMkuw6R0FdSMwIDCJpzwi/PUzjv4zgiYB2l0tWovFJU05xCiVM+4fRZQex9PQpVS7lQW4ZImrmocsOJPJBA5s0TWF4KS3IuM+m0pCbJC16yehV+nEz5MtNeyHm/xDhHEoXNxPGsqVzfZ8mV5d2a5py4qLoUQbMvudvfp+xxIVqM1z223ej7jsHLb1e8VGmIrXzk3rTQKxbOUbYOjZejYb4WR2Gnrdb7v0W0JuvX+5PzMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5OwHnAWVM04WBVJ4uXYlg5PTUvN+OAwYYRVBlDS71I=;
 b=hXWVjaVeFZn0hR+xjTrKOo2diMNas6JXyL91YqtRLp+2vvMTE4+8ZmpDL9q5gD46J4Eoov3M9ilKk+eekM36geOFIA1Y6iR1OmNJnnV2IwqfkD4/FIZceGLb/WTgiigKRj5QOTzqVEqVUa27wLUFoZSCYvQoupMiReTyLIUQTys=
Received: from MW4PR04CA0056.namprd04.prod.outlook.com (2603:10b6:303:6a::31)
 by DM4PR12MB6303.namprd12.prod.outlook.com (2603:10b6:8:a3::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.23; Fri, 7 Aug 2026 06:16:38 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:303:6a:cafe::c) by MW4PR04CA0056.outlook.office365.com
 (2603:10b6:303:6a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.21 via Frontend Transport; Fri, 7
 Aug 2026 06:16:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 06:16:38 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 01:16:34 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Alejandro Jimenez
 <alejandro.j.jimenez@oracle.com>, Ani Sinha <anisinha@redhat.com>, "Igor
 Mammedov" <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Richard Henderson" <richard.henderson@linaro.org>, Sairaj Kodilkar
 <sarunkod@amd.com>, <qemu-devel@nongnu.org>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 2/7] tests/acpi: x86: Allow IVRS acpi table changes
Date: Fri, 7 Aug 2026 11:42:45 +0530
Message-ID: <20260807061250.27739-3-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807061250.27739-1-sarunkod@amd.com>
References: <20260807061250.27739-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|DM4PR12MB6303:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e10553e-6bea-4e8a-bf59-08def44b709a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: Z227yFTQMDUBh1c/L08IyzHrOg1hFagyEeoMnBX0jG+thQfpOYlUmc81pclZl1rC9Kj8lm90vWmh/aDpX8IknDKt7Rp62aRDvxNentqsNhDjGM4uaC3xKKX9KVizV1UvzTaQSmVGRppOYdKEUpZ2Hekx9+YJnYMV4YswbQatMtaOfbRsb8LVmvX9sfl5O/cIlaOUYi4M9p3cBjb8R1/1wSzaJLm9oGm6Gu3eDqbUB23OQlAWnq7k7XC1yoyUU+UwgSy4xwRmR7HcJCsUxwlmKAehOrNpUPvvtqGElT6umR9DBZCldLm/alzYjKiKHt8yUELf7TgY/3jzvOKZp5Re6ovfgh7DO/19mGEFWil0LMd1pOZCkTgGZUUt4b8y+VjJL0NL+d939HVnv/cVZjJh9Q2IWqGb/yT12VTU8YmJI947rpbHfYGkpzeVM/kYoi2JpE7iGjX8pe712zjT3kyz89mHO5fyy+OJeQmWvZF8umtXlMcXcdklBfQ5IzIIvkebBvzWNdMBRNW/YTXS1X3f8AFexnMJDch3xb8k8QokoLvRyJiNcypvORw3dnUgFp58z1AdMezfnAVmdYUWQHBQImotZuH8KysVEPifnkowR2MgnOEP92T4BrwaACpo31P2IuiY+xHwLt9eO1MZ+/f7dSI0JohQXSG2JR1qf226m0NepjIyL0jurRusFR/q73kNXa6AgHyv2tBL+7H+InJlMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tHWnaXkiUgz1TQ+jirgSjL1AGKbPBq0Enu/5eOcAOupt0FkQSjRD7aTWvsuvvEEorCEWZ6EMXJTlUj0sURoT0RQ7ZYik1dwpZAqWgbXsZgULAXijZPd2ApiIV/p1ikb5l8Mza+OsF2QOi2DwBft+n6ShmJu6BkPjmxcXPi8FD6qElc4uQ6SS6n+PVkIniQEnR6dmEfnrV1l0W2crfudIJCsXICJQ1d1jjUgMlv2bOcY5lWTmeuMjH29xpLKsGU7KNm2fG9Z+mXMQ8sMB+XG+diIqsWCydkgHGZnu0SqnRHsvieBq9+peKbxU2csOzFyLuSzCdn1EXFGYXPQt1T/OLsCNO3ka6D9p+49aSvhiEJ11RTeDn7yzLkKxrAXea6y4wPpYU2XMtu7EIN22HhYBJPZyk44XHWR8SlavqJbwWt2FthvkIDBB+fFejtGdDW4A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 06:16:38.0760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e10553e-6bea-4e8a-bf59-08def44b709a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6303
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=Sairaj.K@amd.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8bf4..33e998165591 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+tests/data/acpi/x86/q35/IVRS.ivrs
-- 
2.34.1


