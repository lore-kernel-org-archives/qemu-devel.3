Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA893C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 12:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM4yY-0000JQ-0A; Tue, 25 Jun 2024 08:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <taisei1212@outlook.jp>)
 id 1sM4yW-0000JB-OQ
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 08:08:40 -0400
Received: from mail-tyzapc01olkn2043.outbound.protection.outlook.com
 ([40.92.107.43] helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <taisei1212@outlook.jp>)
 id 1sM4yU-0004nE-TH
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 08:08:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuiXrgOKNXBrfVQ0L2H5ijProSwYit7h162p7iOkQ1g7v8MC5ljqk2gAiMXA0KHpdXGf/Fzi96ZJPnMhU572fsxCZeBx8aQinmaw+C2icJE14ULcTA3uEXWaaBG+IA8R7lifpbHfsT+tuQTEmmnNzfvM7Z9bN8E4HGo67ChSOUcGugBz39SdlWBb8jX0Yac5rRE61Vh6s9xmZNHky1lxHHyHE2LoF4rYHt9/xT4GDcVUiS7gi1ND6xe32B+efRcyOBzdLj7gOLGX3O5YGI48NzINE1coM6XwxQtiU9rn71ikaKvLl9WdCTPPLQc2y6vCbZ8Qn+mrXijQaASR3zr1iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3Pf+9MZcJGGnLkcNBGmMhQ5TyAytzqR3QSOwztioec=;
 b=HseZWGZ54uTdsvQktsOhJQwO9oM6h5BL2WuS6cmobpJANDZ+Y+d3EIRHWCVbSYORvD1fGAU6COsWIhANCA+RCB4qYZHgopddAtnejX2YLkJql57Ehrt1MiKITySfi6q/iAiZIWhZNpoRmDCUG4pTzV+Jl/Tfga4MAJ3JiY2JRbIIbbpbHSQbsw3mFyfPqYa15y9RggqoOOwJjM8R6WjR/bos99PcoRhGKF5EMZoD212VjiyDgJHIZA/SnJnN4ciOZ2wE18nL11Hs3vyUIzW6HozfLk1rB2TKQEuRZVvHwBPqpmbwm5YjAm/EfjaAO+5KHsYznK+B8eEMeQp+EdFn4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.JP;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3Pf+9MZcJGGnLkcNBGmMhQ5TyAytzqR3QSOwztioec=;
 b=EgXmnJ0k4Ijq1LvNdgoP3R7LfyoBjOl5H3y0ffDSLvf1r1L0M+Kf0CiEi/Ts10u8VXz8SurGHetejz2Ki4qqu2pSQKhmqeCl8VRpT604CZkENlrq3PscC/6pHr0d1qWvXpY/CFaZuq6L4wdLa1NKddwZMIsMKeMT3tozxJYCaDVSjUdRCXaW1uqWzzE1/1lxDVeipvJi2haqDUambFRjG/yDgAw0dAngSmRaEklvu97eEBtBSZ0sQ3B30C0u9rA09TyDCbi2HNrgyZ4He8BdEZBDoqQSBrDhOphariWqj4SYB1zN+cRNjFNRThM4G4kuFmf05IXHR0iZim7gJwjDTQ==
Received: from TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1b0::11) by SEZPR01MB5509.apcprd01.prod.exchangelabs.com
 (2603:1096:101:136::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 12:03:30 +0000
Received: from TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 ([fe80::85c5:f6c5:8a81:ee35]) by
 TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 ([fe80::85c5:f6c5:8a81:ee35%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 12:03:30 +0000
From: TaiseiIto <taisei1212@outlook.jp>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	mst@redhat.com,
	TaiseiIto <taisei1212@outlook.jp>
Subject: [PATCH] hw/intc/ioapic: Delete a wrong IRQ redirection on I/O APIC
Date: Tue, 25 Jun 2024 12:03:09 +0000
Message-ID: <TY0PR0101MB42850337F8917D1F514107FBA4D52@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [ey1RBDlVP0C/Jzvod7dp2FgqSerLf5Jt]
X-ClientProxiedBy: TY2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:404:42::24) To TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1b0::11)
X-Microsoft-Original-Message-ID: <20240625120309.1816-1-taisei1212@outlook.jp>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR0101MB4285:EE_|SEZPR01MB5509:EE_
X-MS-Office365-Filtering-Correlation-Id: a0402720-8e58-403d-c8d9-08dc950ed3fa
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199025|3412199022|440099025|1710799023; 
X-Microsoft-Antispam-Message-Info: R4abf8cy7tlkCJB2ttqTZktbIcU9GdZ04I8oDAjxRAYOhfIT/+T2+HS/AA7LDAlRj2fXdlYVhR4r6pC/0ZvFnl477XTbcqqhaZR6Rk4G+eYEgQaX/qtUfZtGrfHlNgu5hcpXMco+reA2P/3wmfOqLh7CrSYo/nYkWuFHny5/YKwge/npoWFCgLVlmVk8lTSkjSw5oPt2lcgukrR54mod4CJ+q6q4VtdLkj+0sX7FaxcJiiKhYNoBrRTXb1F0KCs1jGr/PUiTizl4bQTK5YYTc/NbbP14BB7j3ZqrP8OfEALnHAGLzty3GqTuYY29EMFxwvh2eR1kXtg2jtda8nsMSN7Y1jt0ZoXz3BasieBEIYvlFpfnhUgY3hBhEVmRqoH+Q2DKVeowiro2qugdGoQ1qUNXfT6A3K2I6PMeOFhdz6oxytLvbhVlXHNYi8nJZ9BICaP9xIGUEfmAlWMYLCjIerqYWLWuzAV3ALwUniSrpSEIYvgVDOT65KDifRus9XEsfmaNdtQkjPyJpwCHtipaJVNbQ6ZAXWY+Y4D+pZZS/3PPzX2TlaP/WfvfIC2iJrKEiGZq++pGGG0XTFF66iZ61YmqnGrWFk6+2OMKUHE+w4M4iaEf9G50qZrf6nPEodlj
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4OgwhwaVuef9SONZ26TN/zP8ne5bQccGiUuW4BZ1eD6ruPyEbl7G7+j+pXoq?=
 =?us-ascii?Q?OKHt0bLyK/Aqkpy3jAbibfEa8IMvYLLbFmyi6XPjrvsGcSENm/EoJhhLh/sM?=
 =?us-ascii?Q?FDvxznnYDit8AqsEXdliNdn3bCOGtpeACHn4HiAB8mqwNhegnOPVB4QWXpAZ?=
 =?us-ascii?Q?QUZLIXqtMuObwUXfZlzxDgr82hGFc5EYkwXRbN+iFTkRPFrR5htywkhcOTx6?=
 =?us-ascii?Q?3kp0mmLSXxc97kW5ctcdNPD1ur+AhP0UJfa6u8AbH5SKW+H0NTflCU5zuRom?=
 =?us-ascii?Q?GKj7GX2gKlTvth0CQRJtIQEk0lNwcxOEaZWb+SmFVQYSXnJc5tPnRt+uGYDH?=
 =?us-ascii?Q?O71LiX9iEKSVaH6OHLRBC4ZR2wmaRNhoultXft3phIPampUkFV/wz1+Y2VMK?=
 =?us-ascii?Q?UTxSeyuW4aSzxNqb+YsWoXJZyIQzNixcwwWPfhjrGJxh0/oLET5FKRHrnbel?=
 =?us-ascii?Q?ift0+s5hKxIjxvKrtkB2dmu5RupJzDwln6ZtLHeJ2U79jgQbkXNVUnn2USxY?=
 =?us-ascii?Q?UThy46EOSQuyUQGaq87i0P1Kog6XfdCNTRnzlFIk5Wql0JMEwY8Efbybfk7B?=
 =?us-ascii?Q?+7uPmd8VxdkKgpPRPW1JPj41SX46QwZRhZE5o7jYb8J/v1foftNfurBrwFQU?=
 =?us-ascii?Q?t4LXUnwni0+eOINHbB6qJEUQ8s/MbLTN8yr1FNafEqcj14SGU+R+Zz7FpO1X?=
 =?us-ascii?Q?nFIgSnJu8+06AOOp4526kQ9Vd9F+DrdBgkFBGyNY8ZOYb8FRK7S0U4/wBWyu?=
 =?us-ascii?Q?ejdXdtI6p6QeiL0yKCJibSK+RIocNG4XPLveiZbEc4kQHAFjabgcZ7RGNCzf?=
 =?us-ascii?Q?CqlqpGlEq9ZPb6fOpITBqbPM1VMXxGfblpyETPXcvlI3cK6ewsLT1qh6l2Vc?=
 =?us-ascii?Q?WR7t1FzgFBzQ4hp/PlU/Kk7H4g3674pJzpGcCky1n119cNN93qvtXKESfsn2?=
 =?us-ascii?Q?UGLYF5Haoayzu3E7Gq8VE/u2EhCaLyky6uBNF1G7oYkcm/T3epK4xWCdse2j?=
 =?us-ascii?Q?s7Se1TzGviK7acaK0QfQ7hc4ZeIlFtlDDE3LbtzA76dOnQFcshqB6k4NlEZU?=
 =?us-ascii?Q?t8JEKiEW/nIZOMy0AbaQpXx7JqxAM9AQ1BU/W53G89VYLDw14LuXV7/ePalE?=
 =?us-ascii?Q?IObo8tzHHtu4pwd7RS3JpWjQl+LGKOvCKlHYKqS0CB6+baOo5GTh9NvF/3lg?=
 =?us-ascii?Q?RUxFfozv5NWUQkK7ZgWVsFjqSrTI33nh4ZtUHuNO4cZoebFqU8QkAHfxlrc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-d8e84.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a0402720-8e58-403d-c8d9-08dc950ed3fa
X-MS-Exchange-CrossTenant-AuthSource: TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 12:03:30.1265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB5509
Received-SPF: pass client-ip=40.92.107.43; envelope-from=taisei1212@outlook.jp;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Before this commit, interruptions from i8254 which should be sent to IRQ0
were sent to IRQ2. After this commit, these are correctly sent to IRQ0. When
I had an HPET timer generate interruptions once per second to test an HPET
driver in my operating system on QEMU, I observed more frequent
interruptions than I configured on the HPET timer. I investigated the cause
and found that not only interruptions from HPET but also interruptions from
i8254 were sent to IRQ2 because of a redirection from IRQ0 to IRQ2. This
redirection is added in hw/apic.c at commit
16b29ae1807b024bd5052301550f5d47dae958a2 but this redirection caused wrong
interruptions. So I deleted the redirection. Finally, I confirmed there is
no problem on 'make check' results and that interruptions from i8254 and
interruptions from HPET are correclty sent to IRQ0 and IRQ2 respectively.

Signed-off-by: TaiseiIto <taisei1212@outlook.jp>
---
 hw/intc/ioapic.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 716ffc8bbb..6b630b45ca 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -154,15 +154,8 @@ static void ioapic_set_irq(void *opaque, int vector, int level)
 {
     IOAPICCommonState *s = opaque;
 
-    /* ISA IRQs map to GSI 1-1 except for IRQ0 which maps
-     * to GSI 2.  GSI maps to ioapic 1-1.  This is not
-     * the cleanest way of doing it but it should work. */
-
     trace_ioapic_set_irq(vector, level);
     ioapic_stat_update_irq(s, vector, level);
-    if (vector == 0) {
-        vector = 2;
-    }
     if (vector < IOAPIC_NUM_PINS) {
         uint32_t mask = 1 << vector;
         uint64_t entry = s->ioredtbl[vector];
-- 
2.34.1


