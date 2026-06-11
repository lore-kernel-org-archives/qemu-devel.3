Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BA2CD98CC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXcJh-0001lb-T0; Thu, 11 Jun 2026 06:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wXcJf-0001ki-0i
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 06:07:16 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wXcJc-00074D-9B
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 06:07:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OsFYpRvHdOwGrmj964YANtLhNW8yrSS05sBIXWP/tts8wgcrhnFXv2dXOIluaZkWOjjViitYkdFauHSl7gqu76mL5opB6puiudyXlGBkuGhHez4noHT5/0gt58TDBKVWvwYO9dl8IFQPQikkDnMhNFNwp2R34qbGx7cu0hSfliYH5KygZtbhf5nSIgOmNfh4Hw71Jlpy1KqGDt0K5g51fKJh7JME/QNm94mEUQoJn5lmvs7fhL4Rni2BOzumW7bBxDaf+5YeIPzkx1PB81Hg1HkG3iI+6mSzuqEiLx1Uupn9iJHmuFgye06qsatgwphDhKGirIwsncwpOpSiYExzTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMGYAl7+N8SzoiEY6KKg+rfN6dscNHkFuaT1cf2lpFE=;
 b=ffCCUkwhUgidiVxGrWtxkAp4Xup8TGsgNqafoJA9zQ98NFeRXmcQs1aJl685NTCjxsPzAVXUuXdccwD71sUOHuf0Zk5UGZUj4DLyiC5SiZHmP2rBzkUfBd/qfu6vl1wVWy9GUWdzZrKUuVTHcckrvF3isbjc7I/nfrgPsRn0PiacB5vSM/nmLMAi5GJRn0fy2iY5FE1NSB2fzGsUndbv+THI7lANYyfKx0tDoX3y9h0/EpU425wg7pILuWbIaquUyBSicZI8qxPj6Uzof0lxfhjYAeY878u8ZCgkFWWG379+KQjqtfBKuGxzi7GP61+NGX7FCiogPz7fss+E+oUhgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMGYAl7+N8SzoiEY6KKg+rfN6dscNHkFuaT1cf2lpFE=;
 b=4+wmZRdHrMjlawwEQ1worN+jcdSMciwmTl4n+hGgLNo5JbZs1ENqYlLwzCTleinkpJddgmj8xnQQz5QxS4ZLXk/kdrVG91JQOZ6W9scKoBtXyxDd5uqehtfcwPm/o8/27lX9dC27SqhN8MIlNJBFI82hJEQlJpWx3NX6kxivxDM=
Received: from BN1PR13CA0001.namprd13.prod.outlook.com (2603:10b6:408:e2::6)
 by SA0PR12MB7073.namprd12.prod.outlook.com (2603:10b6:806:2d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Thu, 11 Jun
 2026 10:07:07 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:e2:cafe::ad) by BN1PR13CA0001.outlook.office365.com
 (2603:10b6:408:e2::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.5 via Frontend Transport; Thu, 11
 Jun 2026 10:07:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 10:07:07 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 05:07:04 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@kernel.org>, <imammedo@redhat.com>,
 <gourry@gourry.net>, <philmd@mailo.com>
CC: <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, fanhuang
 <FangSheng.Huang@amd.com>
Subject: [PATCH v11 4/4] MAINTAINERS: cover sp-mem under Memory devices,
 add R: tag
Date: Thu, 11 Jun 2026 18:06:37 +0800
Message-ID: <20260611100637.2460507-5-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611100637.2460507-1-FangSheng.Huang@amd.com>
References: <20260611100637.2460507-1-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|SA0PR12MB7073:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f57eb8-cec2-474c-aa73-08dec7a131bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|18002099003|22082099003|11063799006|56012099006|43062017;
X-Microsoft-Antispam-Message-Info: zMYxpJqX2643D31Xi2nCeMGNnWnR2Bmw+erbElHxboe3YswV1wppDtUJCSfmraLXJgAV1MDYlZK3YTjWBPuV97ydhNauFgT97w/SOtzl4KxUZL56Jh+wQeKsuRplHTSei8Z6fmHAOsVbiqsZShI0XjB4bEnkGKt6ONE4WZZvrNOiqirPhErTg9dDipt53cxuxZ3zAWcl5rUcRMmO4XIWGRSvve73m9XPwtT3EUXXIKcoRXPCpKpYGbs41Sz4vbXVPwDqq6AU5y3XNZ6YdFA9kHQ2EgbeyPd6hIjdfWBFhGIwupyHs3mJ8TbXY77Qi1nLzWMCaPmD3leqG8Xh+ACpNZ6+d3msEENhpQeocznjSj47LXKFKTRosFftUDrXMYS/3sm4jCHxb5JAop4YdKOoFUoXkptRLyHn630144sJef7VEFPhk7Z8wVF455KYlRfAE7vLZbFlKlkPFeX1WXK8KS1/1K/+OcPAl+gvg91RQe/HpO8elZYfwNoshksHurWVZ6opMR3tKmLELHEY/+Q8t7/7H6XI4VowORuG0Z+i4P5M0oUMUCPUzKJBjegjcBeI348jgOxEYMhSqkqAMp27ffx8Xlz9GPYK2LmKfZhxz5NxGcA8cTR7cmCPtQzDyyFtSCfMc/y8rSNG67Im/ZOMryC9/Pp8A/N4z0YpY2RgP+glG3kEmsLw0Wbr7q42AZDETPwRYKH+CKj05Y2tj2bGNIhRHUoNq2FQvBT2AoMcXxWynVZ95c8sH2ndsHFjs1HERn0U6ExcBcVbnf49ybOxAxA9TZ6yEfG9tHBkMWJ0+RQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(22082099003)(11063799006)(56012099006)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AUwW+IaRwGTGoR/W4GbTkCGA9HNJvCaX3Q8fA01AzquIE8/vFR2xLkC0ozporjLV/8AS+6aBJMXaLguyJzmSre7qTm8Xzcp31WtdeQyf1qKN2dWyxNEpogi13bmE8PeuTXJqT4cUjsCL7Lmb9gYh6IHv9G1+EHiqyRLK1EKNQcPyORf4Iy5ttNlPbpLHz0ljzEFvnmoqdXxy2WFKVYuvS0EgPbTeDKjicc1jR1xFWxxrkf9y0HDSmHKAjQjibndgQXNvdjM/+rFrgs8RqCVPW30CO0mc3BVDw+x50diog07UjA9U/GaHEPn+a6egxMFX747YIjD4lV1lJ4JYYEwXnozBUe5Ga7cKMo0peNL3zjtOyIGZoFaW7H9q8J/P1ZmzFZFty2rrY+S8ayCemcLm9eYpOlZepHjTxUXtqZ1An3BxOqrgkeqHoQARQSV57WL5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 10:07:07.0905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f57eb8-cec2-474c-aa73-08dec7a131bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7073
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=FangSheng.Huang@amd.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: David Hildenbrand <david@kernel.org>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 748ec77beb..0e445932ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3361,13 +3361,16 @@ F: scripts/coccinelle/memory-region-housekeeping.cocci
 Memory devices
 M: David Hildenbrand <david@kernel.org>
 M: Igor Mammedov <imammedo@redhat.com>
+R: FangSheng Huang <FangSheng.Huang@amd.com>
 S: Supported
 F: hw/mem/memory-device*.c
 F: hw/mem/nvdimm.c
 F: hw/mem/pc-dimm.c
+F: hw/mem/sp-mem.c
 F: include/hw/mem/memory-device.h
 F: include/hw/mem/nvdimm.h
 F: include/hw/mem/pc-dimm.h
+F: include/hw/mem/sp-mem.h
 F: docs/nvdimm.txt
 
 SPICE
-- 
2.34.1


