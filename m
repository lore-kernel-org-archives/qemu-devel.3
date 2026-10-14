Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C5FCC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 04:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGr34-0006dp-QI; Wed, 14 Oct 2026 00:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGr2w-0006cF-2h; Wed, 14 Oct 2026 00:56:58 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGr2m-0008JJ-9E; Wed, 14 Oct 2026 00:56:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KcVKkv5OFYdkmr+4/OyKnaNur6JtZ9VGLovCyZceysVHOc2bhHm03m9LMUJAkBsVWRdSrXBGs+9THCnL+FruQKANSi3T1Lh1su7tkSSsqvQx+yV9TzGh0M61NMVla5LodVqkEvBfkgxkouuvFOIADd6c780ofByN5a4uLjg0LsN7nTYyFcrPkYvgvX7ZhUI04X3lfLg4EisPPlD8+XOyN2TF1o+gLOazOvQO+plQxK2bSAVrdtAUtHRNTE0Pd12CXL8mtky1r7/kvNmnQLABM5DVatfQKtd5ZHHSV2+TwGXP5IPthrUGBzGLG0TgFYU1CLx/C+acSHPQKJYes+NrtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZXG9JJPchRBDcPVVXrtJUQaZF3CJ/gZfCRUoL5ygsY=;
 b=AZUCy9KLfkb5MP4JaCSWcPQyGFNsDPAeZ9n6lLwl87jUeLS6mz3Rrh7lh/w3fo8xn7XTiv5vX0cwO68cg440IZD3O0QjU8npZFHiQIZEbqcIzRmAlHUZCmhu2quQBNqQDSn3IE40qlvCKZAmidtaDgvNaNFjmpT55UI+yuinyDEG3I1G+mqyQ5pos4o/aDucRW7Clqvw0chJEfpKgmwuwCop2BMsLXUG+rgjSurUfwi9GOp4Jlg4l8Ys4pM1aLwvXysu2mnXK86aEW2vWbaug912/GpsB9jxJ4SJKYZ0BD1q84vmlWOvCf1SJyhjcM2Lmjpf4Scl5rXeMA3OnqEb0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZXG9JJPchRBDcPVVXrtJUQaZF3CJ/gZfCRUoL5ygsY=;
 b=bli0eUA5X1jpJWiqL3z0y2/Oj/gs+OFHbarzS9CYS3Wp5NwBIiFRJgeutF3LtqedXKMcGakpjFcZSw1ZwrOwenKCqXsXiVAsAKo1cicvxklkUiMGXvdVZu5m6r8+Kv9JhwlzXrsoAEisc8N5servZISh+8qciRbk36HbNNhM2epeltPgclMdUXomDFgGKg/PakSPQ3AR8CMc0QyxF4zB0mux3bqJ3CQADn5AK3IiEGKLmfIPWi+5MTI0ZHosxl9Thuntawp5UYomOs0KJk342eTfbXmI+FdjOaqCoU6FRnpQKAgWGAm8cxmU7wJO5EiLM2twfoLe9AqXPUrimDCzcA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by JH0PR02MB7213.apcprd02.prod.outlook.com (2603:1096:990:67::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 04:56:36 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 04:56:36 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org
Subject: [PATCH v4 05/10] hw/sd: sdhci: Use a QEMU-local no-busy IRQ quirk bit
Date: Wed, 14 Oct 2026 12:55:55 +0800
Message-ID: <20261014045605.399684-6-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014045605.399684-1-bin.meng@processmission.com>
References: <20261014045605.399684-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYWPR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::7) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|JH0PR02MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: 838b8df7-c157-4045-e958-08df29af869a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|22082099003|18002099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: MkcTizxjBAdquBqh4eowUkcvoxPuobrXFPsb56ooZ//iS0qZlvebYUhAKUBejFsDsoTMXOYNIEJ/aXtckaojXe7sCd1H4uMduIf1NnWk/YufwNiJSYq0Qn8PZ76igwIHuruQnKd7gkpt0PanirB/e092MYAU8zeU1Sdkb1ZsoRJiEyAOcJPc2dKjT0gp1JHd2O1OR0ZCcHef58Z9sQGlZcJx4HEAeMtOJdT9YL2LHL2k+Y6uWLJSWKMrWpXCloWjhl16APohQ8HMK3vbt9kN+VOjT2wGN6A7pc/s+JhPr206w+ohJK9Y1Noosjb2MVUMxp16j5Oyv0PJsbz7UT6evCXYBIN5eF8hLFxqUl+FlxJFvppAZMNQJziw31mAG31j3oXYQwGGY5rU4ihoyl835mSCfjon4x25aPRRbKpE8f5hetIC7LPfP5OAnACPEWzrhhzvNiXq476hmRqmwJMmjtzdifw6kyIR7K5uI6mczdM+kTQSmy8KX16SzH7xWOQ6ryyZ3K/yWzwMOmOofEGDoMBd/69fbQVbIskUU151cmtuwaWYXPPC7YU6h2EQZlkjbZYj+TaoRz6URTmY4U4tOq1q7rmDkFJxmbI1z24kdPtlo0ShpZ3MGk1ptf8z5KL8CfNl0MlXecDdjfuNRH9bow==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(22082099003)(18002099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVNxakVnVlJpaDdPSG5wU3dMQUdOL01XYmJZenRrQkJ1TDY1MkZKTmVwcnQv?=
 =?utf-8?B?bDJYcnRUS3pQa2JaVmFJY3NZQ3ZXNXp3aXhoYWFsYjJWM2ttNGtaaWtHeTBw?=
 =?utf-8?B?VW5Ed0FoajN2S2tjZHFpT29LS0JiR0ZPMW16ZHRpTi80NmI3NmlFSkJMQlpM?=
 =?utf-8?B?VE1VelBMS2t1RHhQRFhlbjdtY01BWnN6VGdKVVpFdlRkNXl6ZVlyN3B1VU40?=
 =?utf-8?B?UUNmZ3hkeVh4WDBHRXU2Ty8rYU1rd2xSZnYrbnVQVDFtL01sYW1zaXhHZ3ZS?=
 =?utf-8?B?TjJQUWVINFFwT2tkQnd3SFliQm05bG1KZUJBVTBUbGVSQUt5YVRrVmxRK0Ex?=
 =?utf-8?B?UVJ1WHg0Q1JUL0FOdW50ZlBja1ByS0ZtVDZUMVl4eDV5dnJqRnZyVWIwb0xK?=
 =?utf-8?B?MzdsYmFEMVBqS0lnUmZWTURyb1poQ1BpcXg0Q09TUE4xR29oaXNrandkUUtn?=
 =?utf-8?B?U2oxSlBYTTR0aUROajJOaElDSUFpTUl4MWJhRm5uLy9qb3U0YVRmazZPZ1di?=
 =?utf-8?B?a2gwRVY1U2tjQTFsaGZlV2tNU0M5VTZ3UnZINE9qVi9FSldmNXAvWHNNMHpr?=
 =?utf-8?B?WG1hM3pUMkhUOElYVEtlSlZDV2NodEN6OC9YOVAwaDk2RW9sTGRlbFpFV0Mz?=
 =?utf-8?B?OEkxeEZ5QmlOdjc4NGVsYzE5VHpVaUdxTUZOVE11b2NCbWxvWWYydlZWYU01?=
 =?utf-8?B?eWJrWHc0K0xCRm1wNjEzcm5zZDZUMEIxbEZCNDNYZFluQXNsNmYyS21EUWNp?=
 =?utf-8?B?TE95NUpKeC9BUDhpOHZlSmVFV1JVSXoyZ0thdDJjeVdYcGRUSnp1cnlYZWVW?=
 =?utf-8?B?MXgxL052TVF1OTlqZm9MWk45RFB6eDJldGFBd3pwSXpFK2N0NmRwUlZrVTVs?=
 =?utf-8?B?RDROb2RwbVVWOXRzeit3YzBsRFhvVGZMTXF0V3JmSEVia0R4SmhIMlgxTkZQ?=
 =?utf-8?B?WDNRWlE0VDZjYzFSTkJIeENSUFIxYjRCazBCdldGamxOaysvYThhWWRLaE5k?=
 =?utf-8?B?d09Cd0c3UEdxVVBDOEUzdlo4N1Y5MnJhWDEvSmQ1RmtwNmxpNnRUdGN0UjdV?=
 =?utf-8?B?QjBjRzFmWmF6UC9qbU1EaGNrWHl5WnA3VVhYRmFBOXhoQXpJTlVVZVdXbi9U?=
 =?utf-8?B?OGUrS1lmU29Samk2anptZ2RyZW9vMXVkMHJyQThIRkgwVm02MGh5R2tkMFRI?=
 =?utf-8?B?WWVnejY0RkwwNXJjMk13dFdqTXVzRnJmNk1yd3oyZElqZVRnSHVWT0dVcmlV?=
 =?utf-8?B?Q29zZTQ5aHpadXIvRFY5K0twKzZCaU85b1prV3h6d0tCNHNHWTdLQjk0WnRR?=
 =?utf-8?B?SXBkL0d0eDNRV3IvSm5VYzJ1eUhnSXFyYWdTYi83d3hBcWVTSkRiZjl1cE5a?=
 =?utf-8?B?STJBdnUyUEIzeEZRR3EvNCtiQVZ1aW95TU5tQnBObTZybzN6RzFPNzJDTUxj?=
 =?utf-8?B?a3BrRjZnOEJKSHUrV1hSenhySVUzbVc4NXU2VzlSd1VVUUNFU2dkYkREVzVz?=
 =?utf-8?B?eXR0UUhYRm9VbUthSFpwYUQ0L0JXbmZ3K0VZVDhVbXVCamFtTkZhT2RRUkYv?=
 =?utf-8?B?dE40Yks4L3A5VzdCK3BMbklhcDBncnJ4dElNQk9pNFdhTVVranFwc0pEb0ZQ?=
 =?utf-8?B?TC9QOWhoMVRvWW42dnBOWjRnSHBveC9CMmlCUlppNmtyMGRIaDRXeGh3WXJz?=
 =?utf-8?B?cnkza21SOWxCUWlCSmdKS0dkcDYvWjhKTUMzTDVjalZxd1U1LzBoZVpFRXlm?=
 =?utf-8?B?anAwZHhNYUp2OFJxOGtqK2N0cU0reEJ0TFFBeG5aVy9ORHpUOGZoUVpWUUx0?=
 =?utf-8?B?RG1iWnVaU2c2QjRzVVplT0FnV21tak9ya2tIL2IxRnJ6cFhsMGpkNFN5YzRJ?=
 =?utf-8?B?amZRM2FwU2pKRElTMnZZcTdYcUFmekNHSi9HcHg2cWZ4USt0Y3grSWZhUzhI?=
 =?utf-8?B?RmNNeDJ5bExjY0NYc00xdUpDOFAzd3VYZ1FYQ0R0czNZQjhRQlFXREhncnZ3?=
 =?utf-8?B?N1lYWHN6ZW1sSER0YlFiS2FSdlZEcVJJY0cxWXQ0SmJTV1paL1pBSC9nOGFM?=
 =?utf-8?B?THJUUTZuaUNtQVN4LzNTOFNCcUtFb2w0WEI4UlN0cWkzVFUwSTZnQUY4N0xl?=
 =?utf-8?B?V3JHeGtTV0xBWUVlZGVhMVdUZis1VnFJUGhMb3hDRXJZS2llR2daMFZpZnNF?=
 =?utf-8?B?MzRSRTg2NDdXNFh6dXRjLzE0MW40RTlBc3haRUJmdXVZa3VVZTdkclQwL1JU?=
 =?utf-8?B?Uml4SCswckdINUtkd0VibFZveWd5aWlnWWgzUEw2cUdpN0c5RzNrcjQ5cHZQ?=
 =?utf-8?B?a3BHUzRBb2NjL1VUQitJN0lIdURnYUNselZ3OUJYOHdXR05FWms5dHZtMjlI?=
 =?utf-8?Q?uAjEoiari9x57Tf0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 838b8df7-c157-4045-e958-08df29af869a
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 04:56:36.6154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jDv4QiwAapgSbeosS1Koo0wchoRfKiPDzzLsliwPk8Eqnx1365Wns/fQOGhLrvX8gIOCr50WUexTB+oMjxnPPrzAp0t3XQqpDJYWyB0YMpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB7213
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

SDHCI_QUIRK_NO_BUSY_IRQ was copied from Linux with its bit number
unchanged. The quirk mask is internal to QEMU: it is neither visible
to guests nor part of migration state. Mirroring Linux therefore
provides no compatibility benefit and constrains local allocations.

Move it to bit zero so QEMU can allocate SDHCI quirks sequentially in
its own namespace.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>

---

(no changes since v3)

Changes in v3:
- Align the quirk definition before adding another bit

 include/hw/sd/sdhci.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index c485277744..c5297310f6 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -111,11 +111,8 @@ typedef struct SDHCIState SDHCIState;
 /*
  * Controller does not provide transfer-complete interrupt when not
  * busy.
- *
- * NOTE: This definition is taken out of Linux kernel and so the
- * original bit number is preserved
  */
-#define SDHCI_QUIRK_NO_BUSY_IRQ    BIT(14)
+#define SDHCI_QUIRK_NO_BUSY_IRQ          BIT(0)
 
 #define TYPE_PCI_SDHCI "sdhci-pci"
 DECLARE_INSTANCE_CHECKER(SDHCIState, PCI_SDHCI,
-- 
2.53.0


