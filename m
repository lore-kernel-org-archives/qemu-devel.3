Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9C4606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 10:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=r+p4IKWs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLefq-0005IS-EA; Tue, 27 Oct 2026 06:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xLefo-0005Ha-0o; Tue, 27 Oct 2026 06:44:56 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xLefm-0007qr-Ck; Tue, 27 Oct 2026 06:44:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACDlpph9Ju+2bF0JZT+JfRUeqlkaV/ZvjXmMf05Ehq5m+/2KvaYQsOND32fcQYqysM6BJ58DMy3QrHbnZii0ALHGmz5BzOYtF+c9GKUxLJt2NAf+ZxQguNH23lG7hSoGFwIo3k/KS44epepFDtLfRUejfme9NeGIMwqhVe2FD/wT+cRyrL8UzHaSjnR+hDcdkYtMZtRUsitDOrv1ws2PesnOjWgKhloTr1kH7ARMPSYAmQZu+3WUtNZ1EIakPYBf4VjijbnwIRWkiyJiiOQbzWPn/92tSnHUSGR9jml1W2qVRxmeAIXCI5s8+GulIAjQ0Uqa1O3FwEApIBqyGEWhKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OCQWm68N975aLBgeM7SJwe03X0BrozXPkgwDpkCtAg=;
 b=FnR1SeyiL0WbEN1MQHAuANf6dmBkARavQ3R/jRcvFya2sCn1X30d5X84pUJQAIoYl5toJhlj/AjClPCscvttLEwda3zFnGt4JANKi5Kr06IjwL/jpZLqKRVACoo9CEtGYK4e6fOtQTpSqtzXXgU78EWoJGWqs9bplw7adY72y4RfJn0HC8TZTy5YXXqDdoXtz2ow85hbq7yq80/k1RuohuAhX6z6k9vkVyGsKGJDrIxO4LT3tac5soZgGpKPKzSwXCTtwjAaK7HQzNb2YQLUKeRbEcXPXYRfOIYsjQNMtt9YqRfe45z3ebvQkg8+okMDT8bWxv4e7jRylS7KPIBahg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OCQWm68N975aLBgeM7SJwe03X0BrozXPkgwDpkCtAg=;
 b=r+p4IKWsV4tuV4no1DMdzv+pfkS7R2Y9+unMIzcabc/t7ZZLxFpG58mDzaCJqsrDGmg5v3foHdSs3Tg1ShFPrO0xmtiLgLNnYqlzscaptpMsJwzN6MXVLUpWycV+NwrIcOOgnbmegnlGHhuaSnQyuz4Hc6oQigLHywvce9rq5N1pun4uuDYAZglhlJQ7T4iTgUPOLIX6UkjgL1xdVeHsYoZpE2HQQFLI9VbvOPzDuUCeQKOkPG4JwgrhU4YXp/NduUjF8kCjmJQeA0iyPQDUhp7WwLh2DSiXKRuhJux6NRgT4uQWTUE/K7xMdmqAE1w9TdLuNXJK9M94+7pSUZi0/w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS2PR08MB8805.eurprd08.prod.outlook.com
 (2603:10a6:20b:5f5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 10:44:48 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 10:44:48 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 jean-louis@dupond.be, andrey.drobyshev@virtuozzo.com, den@openvz.org
Subject: [PATCH 0/3] qcow2: fix discard-no-unref=on data corruption
Date: Tue, 27 Oct 2026 12:44:38 +0200
Message-ID: <20261027104441.830212-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIUP296CA0070.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:337::8) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS2PR08MB8805:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d406111-dfdd-4960-3025-08df3417525f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|52116014|376014|38350700014|56012099006|261009223027099003|261021123027099003|261021121427099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: g+ZUDiEI1Nw5mZHeoC5VL4DkdrQ4CV9ReoYzvwBqAV8cPgHZp3cF2ObZBHgZ3krU8rQrO+SvAfq9UckhzeD/aFTmjjOJ3Xqh9EFmnjAPXSWIzRTLUClQSj5kTArCEHZNrUzUlywUz+0QLyE0rhI2/dXbVqyPJMSziPHKbMsIsQvoO+I7N18zAVuiGhk+sixM1gbLQ+n9drjNzbFM29oyR9T8L4+uxH4uJCPz9gooJz5t6Xmuq/Hbp0FwAcYTu57LnmETgoecB9tJlr5xAulvJWq6XBtNZw8BtsEJqXKh/DGgtVarVJgDINequD2oy2XZzcw3eMM4apSEBPF+74/PRRQcVtAHkIA86MYk2VMjg3gGhutsbR+fDwwkBlGfShvG/DkqUFKNN3ru0APsqctpqE+Fm40D19laBbousz257/OnER6YDw5R3N2hXLNbTqPY6ly7YSjJiYomRSBvIVjMgqrlC12T7htfMvWqqao+IJRsOrP+pAovdZ0XcsS052q+3jvuzoyaMwwfR1soC/UMZgkvvQATLqDfLHNetMiztBo9alSpVnV0BASY6HdwQRj2k39oIGCk8QpRMw6VUMW+gf5w9Zq/ZR1o5zbrUelZ5pBNI8ZHBBTiLQMqjra8iOHymkR0kMW4iiKnbiEc+yQmaqhTVzgKx0ZOVYe2YbSvjQk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(52116014)(376014)(38350700014)(56012099006)(261009223027099003)(261021123027099003)(261021121427099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lFjuo9GJq+KHF6FtP/t/ejwAyMrZNFx7Pfs1/kLMCiIg0aGsKjnpRr8hWHJ1?=
 =?us-ascii?Q?s3Vy8mcgFD0L/6gNFNL9AYKpOOxJT1vhoDUOcjs3cuUXP0yDJExtbGoJbMoW?=
 =?us-ascii?Q?oFNdJqy1xYwqIOIPvXcCEhR7pYS31/hIOSjn5DKRPdFWMB9mdIrI461ujS7p?=
 =?us-ascii?Q?H7e/WNIq1wZQyjwOEhQDI/1DIIf5JqXOYOtrj2uVnABtyESsTAMmmJ529ksS?=
 =?us-ascii?Q?ETGn28mLWnVdvIdFg1q82JD94bD9LofvsKWzNZhcpZnoU36no4LH6agUV/el?=
 =?us-ascii?Q?D37nVvToXQZuQINPI3w4CT+MevT1go6MrrnJn7IPOMXx8JZ+EMGud2JgtpEM?=
 =?us-ascii?Q?rMak6g5P8HxaxhC4B3KZHvH396L+eiBW8wG0PMUB3/lrW/nKJcAg6kiolOiJ?=
 =?us-ascii?Q?IOTE40gpYZqvOt5mXXbfrPKDhUP/T1ZzYyQ8ysWO3mJsnb1ofser+Q58uup5?=
 =?us-ascii?Q?fAAn12XW7KLkA5zllzPmoSItEXXHKmULAQrg7GD9+kNc2aCDWH8rhZ6FV7eK?=
 =?us-ascii?Q?N49CuPiLvohlF6/syBCKAaEbRK73keAeFHv2uttSic23gAukgeQuW9ItY/Vm?=
 =?us-ascii?Q?KH2Ru0Xcuab7qXjQFgV5rHsDk+GyH0jRiHV4SXuegRarjMUcIod2ZBoQFRSt?=
 =?us-ascii?Q?akjQDXGKFHqwxwQ1VGptpk5fhYwx61D2QHl0qCO35C6Xan5bRrRWE5mt1XiC?=
 =?us-ascii?Q?6deTWrfcnVyDkUFh6W27FU83f0lAFVTT4jlTnf31djtpF8Mu8m2lYMcT+jFF?=
 =?us-ascii?Q?UNPKabjlMIQyXWjktIwfV/kDRH51s187nKWxEjs2n37KFPwCzKI0x1B89qXR?=
 =?us-ascii?Q?oS2G7hWekfcHq2PgYtcucBSmtoZfRIgTJw3LWhE1KOag5egA+6r6RUpoH8Fr?=
 =?us-ascii?Q?pmWu2rFx+OCK2USEv0s79Xff2gZt2BEaKWmEQHfN5NBLIZtismwM7FmiKVvf?=
 =?us-ascii?Q?aWwHi+M10vBXc+S85u/EYne74K5iXKMPKt1NiuXpco7FBpkIkIzUCMaWQnP6?=
 =?us-ascii?Q?56gayzNh88DFNjoZ1fabAewHxCOpeIOgrqHvVM5xvpkAfwGTP/n+wLENqPuS?=
 =?us-ascii?Q?k5PWgLvjMtsuv22ziJjsWoI/QI9kmolxsAzH44fYXNyI9UO+gmSGiohekqGa?=
 =?us-ascii?Q?5HnMYwdhhB34jWB13aSkyuczGuOtyRbTsbwINmh3kt7eiqKSLJi2nnU9MUQq?=
 =?us-ascii?Q?WeE4IGZj1ZRL2tj3c+C4QfU9HTX1OWOilH56rWa/z8AKqcZeVtv525ei5y0T?=
 =?us-ascii?Q?3mlUmszd83zFvwWpeUHMm19//sZ44O7dLm/8I4g2F+eJj1ODynWy3XFuj3Cg?=
 =?us-ascii?Q?Ii2v1GHnqxk45lkoXEqx2J5ay7fU6QRgatLgf47muN8uDxC8rCKsJ8pYOgPm?=
 =?us-ascii?Q?Hu1ukdKGIynzFADXmrCauM8wpBqkCPR8i9QCbo31c+Gqv+F2qOUqbGNYQS/+?=
 =?us-ascii?Q?lLJBGippKGPrrUhEdobmVtgI07baCEn2UNzlYt+JHDOk6cUpzEqZsRxvJY3V?=
 =?us-ascii?Q?ijvOLHFALJxYJiHm+dAETU6SyxtBMbmbXwcgzLJqaTjDBKm8OyIKrfdbY5cp?=
 =?us-ascii?Q?Xp1+9S6HVj1u2RXfRZ/MacZmIQo6P661qiQV56uLXpHV3l5YGmrNYclsiqeJ?=
 =?us-ascii?Q?Y23PhZo5inVLAmW3sqZd4HpBklCV5aXkYVjxR74M3SyWQSQjFP+Uo4N3O+tA?=
 =?us-ascii?Q?eGfTTQEYMFq6ZAo2wrpTdAVg0WntHNLr3NVFKDP5l7OUcEyxfwPpKhPWOeye?=
 =?us-ascii?Q?C6ix+sw3VzePCTI3Y9OoWRUQWwoOsgE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d406111-dfdd-4960-3025-08df3417525f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 10:44:48.2229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNU1ZBMqwTSf0s+COqpW3nn7HBwq3NNzLfq/jdICHObsNMAzrwkiolxuoqgEiK3godgTvpJ9Hr3HR1/t9orgApxjqrFMmvyrX0N1hBfprf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8805
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

1st commit with tests is my own old commit from previously unmerged
subcluster series [1].
2nd is the actual bug fix, 3rd is the regression test.

[1] https://lore.kernel.org/qemu-devel/20240913163942.423050-1-andrey.drobyshev@virtuozzo.com

Andrey Drobyshev (3):
  iotests/290: add test case to check 'discard-no-unref' option behavior
  qcow2: fix snapshot data corruption with discard-no-unref=on
    #VSTOR-151885
  iotests/290: add 'discard' and 'write -z -u' case with a snapshot
    #VSTOR-151885

 block/qcow2-cluster.c      |  6 +++--
 tests/qemu-iotests/290     | 50 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/290.out | 33 +++++++++++++++++++++++++
 3 files changed, 87 insertions(+), 2 deletions(-)

-- 
2.47.1


