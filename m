Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3628A606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=rh4rTsE/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQ1aK-0006fE-LQ; Sun, 08 Nov 2026 07:01:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1aB-0006dY-Ab; Sun, 08 Nov 2026 07:01:12 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1a9-0000V3-Q6; Sun, 08 Nov 2026 07:01:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otnwYqhxPbW48tWsJbOvSAvLFvU4cwFkvSoxFauT+HpD6e8CdrLxGNnYFDI9b3WE8b/AQhwB2qwGqvV1kmh40VvEzqkH7PiuMH7zMMNIxAd4v9oCxBXYa9dByLIix+CuD5ZVGMYg3Hwvm3pTUBtacEvdHodUqP0RPp4CfIq74Y1uPa0YJnEpXriGYKqClnxwfSC1t1p9RQVyfNZQ0mrt0qTSFexbWW6I3DQ0AjeW7Tj6EWpp//V6vbeVCZ2j1YBmqyT994THIb4OqGTz2Vp9HP4Lk84kDjJUVvlBV+o6YBkXMQ4zG/LnkYYMiDwPMdP9VHx0YRR93lGpHfE84F4Ugw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D02y+cIvjUAzB757R0YDXuVc3yehvU4wayvNzFJsPeY=;
 b=CSSscWCafqaMbRsThtYaUjSou9C0x5JsvL0Lpw5fF7xNOEmmFW9JWsEbaFNB3npUhHh9d18oylgBpTi1Ml7f2kVykxYGv6mKOv8tctl9yXmrJIRZxJP6YQQej0igQcxOMMnBVL623Z5L60O32IZMmsmzFS5+l9gAJySUH2tOPGOz893q+K+kp05epv+Qo1gvDWE3Pc0awL7aHVYEQGtSlwfiHc6CrqMPcdYMXbkgpIP+gpK/9o0Bh6PIPWlzpNt1hDWsY9XjAHbdmonb+kk4cuJmZTP6HFgmN2iXvQCJetYf5BF1UtXR2xB8Ic5gFlfK4yAPvhDkyBFb3l4MWeNMtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D02y+cIvjUAzB757R0YDXuVc3yehvU4wayvNzFJsPeY=;
 b=rh4rTsE/AuYl8KrgDhgPRdUHjjSOrCqHAUKQ7vhPda87+mYtVj7zu3WPDSkRAam8rKGJLOuTIX6r1XPj9aZZKNSUM0Gp1gg9HVA4vWXmcuazFJHl21G7TnG5OLkxv0BRMQTgyfd5II0MYoWMOBl/I1Cm6i6snntZ/rvSfWSwPdwa5iKICJgcBAn30MIAWsaxojSe8sFx9v/HY2tGIKZVAZMq8P7KYSMjLOeS46grRbTXkIEmBW3WhYYYeVC//Hr7hWEZ9YpmokuqWKocHnWlOixDq73dJ9VsL//MhtRlM9ix7hEIBq5R9ovsaljRuVUqyJ83HoWDMuBMGzhE+/rhpg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com (2603:1096:820:116::10)
 by KUZPR02MB9138.apcprd02.prod.outlook.com (2603:1096:d10:61::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 12:00:58 +0000
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c]) by KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 12:00:58 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 02/23] target/ppc: Correct the MAS5 SPR number
Date: Sun,  8 Nov 2026 20:00:01 +0800
Message-ID: <20261108120034.1755008-3-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108120034.1755008-1-bin.meng@processmission.com>
References: <20261108120034.1755008-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0219.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::15) To KL1PR02MB7144.apcprd02.prod.outlook.com
 (2603:1096:820:116::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB7144:EE_|KUZPR02MB9138:EE_
X-MS-Office365-Filtering-Correlation-Id: 4303d179-c969-4099-8fe1-08df3d8ff35b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|10067099003|261102123227099003|56012099006|261021123027099003|261021121427099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: JJVpmzA9Jm07ScJg5Yebmi9Lxh8u7C3R0OxcXtGp5s2MTo6fXtQfreddxce2qikTldHHAhE21DkrZMMUvFk42U+rfw2O1K7e9lfiqdtNSwQOcUvzxGlbQLEe3N3EylIdncrhOFsxy8DJbtyQFU+r33H2WWSapO9qcQK6giQsz1jpaE1tBNrr6tfXeSCY5cDjDRB7Wwyy/7l7UZK//nOD0k7uduTImkX2vL59jXIqv9kPHGQEBQzpwrvQzqldxBVKBfjWZDd+Z+n0znlmDNr+6WznGxAPSOwfodNOibkqHAVxK4O2XSXLzxE3UatzRWgOV0FzLPYziEGo+JfS86/AGDU2FSKLHvG4j9Zz0IWycm82TZoITina5LqvRtiREnfGw+oNm8+jFeOFN/a1o2oJkspoOkDFAbn/BWF+6HwtMnDgwv+4mWoylPbggc0kY8hx2ufRxxI5kdL7dSOxnZjUZ+WBZZHi3i5xLH987CMxUAHkT1vA57OFsnTtVXgRnrmzG4Hit6n9FlTbmrbYjeUq12VozVogDzX9uebP1meKmDfeYNpjgAQYagyevwmmFGuGEaHUGx9zZE4eHGrRvZ2stwS/yz9C/rHbN5qC+vkHq+pTJq2kqYxmSndWneBPvpAzNjTWUl62cn3CDmKG2e0KtA8vy+Z0eY3mYS+4vqdu0+U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB7144.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(261102123227099003)(56012099006)(261021123027099003)(261021121427099003)(261026121527099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Br4pNthfQPu1NlcAtDwP/22trHF+T3uE0xu1awsFmOvSIlEXOxFGqlQfi/fP?=
 =?us-ascii?Q?Q2e0p0b1+wX0dS+iSdGglsYH/oEh2HWs/5UhBSgiuTN57LRrYAtqOyLW5AbW?=
 =?us-ascii?Q?slg2Bdmo8I3TWCVrmvPHj6e3jiarG2JrqLR1aLTxpoMaVzAvrONRImO2ihF9?=
 =?us-ascii?Q?jcfqFbyPu8PBK715SC7EgzbweqCdauKwA3SuoTBozrE20BefQWWh2yodDl9D?=
 =?us-ascii?Q?lw8581hrQQpmz11aisyxKcKP0HB6jsJ9tqbinSpA2DAXrgvcrCrnYGO32F/O?=
 =?us-ascii?Q?yHlWb6hdWnFGRCq+KPXXBD80UMorTecd2s31eDU+P7MMQTQGaPPkqnVEeuyp?=
 =?us-ascii?Q?+8Mzwf5+rHS/kKRH04t+6PhUYYp9CQjIFPvX7DtMRDNiQAv+K+R7R0hOsboM?=
 =?us-ascii?Q?xDCWkqM7vpg4BvlQzKH6zueaK/mR40P2hiGKcGvFC9XKHKNmMwf/4vPt984/?=
 =?us-ascii?Q?FnvjAOLMxMWNvascVOY2Y2J6FNshgT0ULEFQ7UTJs4pz5EbtfZGNXfFjF6wy?=
 =?us-ascii?Q?Z4mebROZBU2oqnvDit6mpo15FsBHPlV+nDZpos/Iy3iA9shRNSQUZj13ZPLu?=
 =?us-ascii?Q?Z56I/8kRMdGLiN+WmYbIW1ZLjcGJ0G0o4FvFTkL6LpVNwkZLLjdvrlKriKeY?=
 =?us-ascii?Q?TzAcw1NCoV6d2IJkd/F+srPWC2XQJBBAvAld0zAiCSN27HVl4dvvfbivgeyT?=
 =?us-ascii?Q?ttO8XNZj3VBldiWI48wkJCKYLaeqbaX8TEHGzAb9a483cj6MzcZmASLvWH9e?=
 =?us-ascii?Q?vLwx7ABTXeeZZduQpVG0lo+9LyEFjbR4tTole8uknnflMWZW1h8dmb+rpTgb?=
 =?us-ascii?Q?QG02ZXEZUwNrKBvx1EARhz5T4235hld1a64cyhdUqpunIvlIsqmuV+Vx2NYE?=
 =?us-ascii?Q?hqN86/3wXu81UZpuojcBSi8lEUwJKDEhCB/pRThUfhitxfIYunVNH8bUMZZZ?=
 =?us-ascii?Q?3YTSyMxqt0mDCNc8oGHb4xG58Et+r2wfhNgoqF/nsH60iO4ZgH3JHhfiF5Hm?=
 =?us-ascii?Q?YS6rTgiS2pJ16hOl3Ux/bNaxZk4B1TLsV3GHfhTvfEy99WLvj/sT0D2AZBtI?=
 =?us-ascii?Q?sQrjnjSW29BtOPUMSPeTzK67z63x7JA58qCDGFrQAJ9zqjLx7r4+Qio8iPlW?=
 =?us-ascii?Q?EyMkM2FX2ykV2dGUTa0dZ2XWfabmcWmwF5PBR4ym1tyO0+mwPdxT+EaB0C1f?=
 =?us-ascii?Q?WRiZPnNFuNPC1+oucQDN1xvuGuzcQ58pHa6DI+9QrvPMIwnyRG9llVxM70ZY?=
 =?us-ascii?Q?rFburil0cqIHKqselt6a8txmiRc4Dv/FnNe5a/IEACxRr/bOiE5nYwVeilHG?=
 =?us-ascii?Q?PyeqXs0gjIsNmd2tqi+1wdyy3G1peyVzXXyODH2xELjykSK0aQ/a79WWUGwt?=
 =?us-ascii?Q?aRRMJGaRgX7c6vtXVSdETxwixIqyHaNZjxZ0deF+FtVpI1rgZdA9HRiVykZ9?=
 =?us-ascii?Q?6W6H0HwiXwLTkhefD7MnHpReS6p/egty3nZjvans4yxpXqGBkcrag+/Fdg/c?=
 =?us-ascii?Q?AVdUmPwD+m02a+Ue4v7chzRShM4qMkTxzJmak4rNgIR+thrj0ZHhvYMyktEY?=
 =?us-ascii?Q?yVesu8to0xb9KjtyDeiSocFkE7g/ZtdM/3aBb73G5ysYCfrlUFA06CXnmw+2?=
 =?us-ascii?Q?6q6GD8kehRSlmiMNVegISHhlLJuB56DEqPrETLFMS/+igLuJ0syS2j38Pn7S?=
 =?us-ascii?Q?1jaioTSkhKX8i2Yzk89HRbBP7r/V4GiWx/5ROD4fEb0HicenTiRHfa1PsVwM?=
 =?us-ascii?Q?TTH7WzJNtvDKr26MYtX0eHvfKjv17s0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4303d179-c969-4099-8fe1-08df3d8ff35b
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB7144.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 12:00:58.3003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kR533X4yPHPD76rOsKzDKeIPl7kEtuwWVD4/wQ061rvMI9aAH31gDDvIAs5puNH98JjXs1fk01equkBoHuVesEHBPLJ/C/TSVpmZ7sH1j5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR02MB9138
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The e500mc, e5500 and e6500 core manuals define MAS5 as SPR 339
(0x153), but the existing definition assigns it number 629 (0x275).
Correct the number and place the definition in its numeric group.

While we are here, adjust the order of SPR_HEIR so that it is
inserted in ascending order.

Fixes: 80d11f4467c4 ("Add definitions for Freescale PowerPC implementations")
Cc: qemu-stable@nongnu.org
Signed-off-by: Bin Meng <bin.meng@processmission.com>

---
Reference: EREF_RM (Rev.1), section 4.2.2 and 4.12.10.6
https://www.nxp.com/webapp/Download?colCode=EREF_RM

(no changes since v1)

 target/ppc/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 0f44096bad..0cbc55c470 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1928,8 +1928,9 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_HMER              (0x150)
 #define SPR_HMEER             (0x151)
 #define SPR_PCR               (0x152)
-#define SPR_HEIR              (0x153)
 #define SPR_BOOKE_LPIDR       (0x152)
+#define SPR_HEIR              (0x153)
+#define SPR_BOOKE_MAS5        (0x153)
 #define SPR_BOOKE_TCR         (0x154)
 #define SPR_PPE42_TCR         (0x154)
 #define SPR_BOOKE_TLB0PS      (0x158)
@@ -2044,7 +2045,6 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_BOOKE_MAS2        (0x272)
 #define SPR_BOOKE_MAS3        (0x273)
 #define SPR_BOOKE_MAS4        (0x274)
-#define SPR_BOOKE_MAS5        (0x275)
 #define SPR_BOOKE_MAS6        (0x276)
 #define SPR_BOOKE_PID1        (0x279)
 #define SPR_BOOKE_PID2        (0x27A)
-- 
2.53.0


