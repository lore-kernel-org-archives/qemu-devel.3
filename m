Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3903C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 10:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN7cA-0006Ro-SV; Thu, 05 Jun 2025 06:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.lugou@provenrun.com>)
 id 1uN7c4-0006R1-EU; Thu, 05 Jun 2025 06:14:20 -0400
Received: from mail-francecentralazlp170120004.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::4] helo=PR0P264CU014.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.lugou@provenrun.com>)
 id 1uN7c2-0000oZ-Jj; Thu, 05 Jun 2025 06:14:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZC78aJtOTSQDb9slrwn7jOMStmLuUEZm/lp6Vb75PHug9rjd3nV52Iu9lSFgcKdrZAg6fvwq+LTP0t4jsg/7Z2NbeEXeNuW87RbJ0hemD6Z+RVh+hc+R4kVugtYZrOYPM80INBQfYowA79IbMJhKWq2IJXY3LgYfTkdeCq806PQRT16vK4KqtHJtllm4ZRWnv33u4izAL8xfW0KpuQy82fLnf5atPwEz2tYj+HnPbLuy3yR2LnC7ZV0XWsQP3v1UBtJ4D3nSlsiPKAfKIUG5vIk1f42jF98Z7gOGKB6N2mL21sMXPfPIlYlkpQ8+xtvnG4Q7WGphX+jitsO793lDWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNNmC9DPK9z6eg12wa+7yO9kZX3lCGBfL/RrMa/skNk=;
 b=cHiAHYFNXBQ0HkPUZyzG6qt67zAcwrGxdMClnSY4IKF7eB3zsXOn5VhTqET5/anYyMY3OFc/Bm3aM+U3j3H9ju9BCm4+Bt+HZZjJLCc8Ur9PFBmEdKhHEB5smVHiDo0DOD8xsSZODGdOjgg6iVfGGzqByIynqxpTdlz8M22wqlsa+RgBDoRba351w7YIIDbv8/aji04zRcYP6N9D1bFbrFkmhZTlqNjCG/24Y1ki/ooFeAo/GeT1oZti8j7D39/OONNsDCxtoaL1KoYmfcxJdkQi2kVgQpQm458prF1nJQdnn5VZnt/R8Ify/LFmqspNn6hF9AMCiYNzQXOEMgwGVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=provenrun.com; dmarc=pass action=none
 header.from=provenrun.com; dkim=pass header.d=provenrun.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=provenrun.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNNmC9DPK9z6eg12wa+7yO9kZX3lCGBfL/RrMa/skNk=;
 b=DLl/tRwfFUtScZdQnbhsFCPtRdlhDonrb91xi/8KuTjSfgQpXb+1WCh0zIY7a2cSgAkzNWcRoNGCNOp4UIMMdolYh93DMpLDKWEzdyu7LmpgunrvpczYxcbZlYVExvOHUhLuMNFp90p0ZW3/CYigyVEriIlV88QA/zXxWzSx6Y7UrWFOBtFnAZarXjnw+f05attnMefFeUT/ORlBWky64Aoajph8Qp7DbF96NL/0V6xySTPl3RFlF9WmhVJRvAoccLxczWSsdAjPRICla/8/zLd3xYsCrgS+Wr1gyBK7mILjeVRHZFvkP67d9svvNE1ErPxu6XZGaQCRF0qQkeSq3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=provenrun.com;
Received: from PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f2::18)
 by PARP264MB4788.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:42c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Thu, 5 Jun
 2025 10:14:13 +0000
Received: from PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ef1:e8a1:244f:3ca7]) by PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ef1:e8a1:244f:3ca7%3]) with mapi id 15.20.8813.020; Thu, 5 Jun 2025
 10:14:13 +0000
From: Florian Lugou <florian.lugou@provenrun.com>
To: qemu-devel@nongnu.org
Cc: Florian Lugou <florian.lugou@provenrun.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines)
Subject: [PATCH] hw/char: sifive_uart: Avoid infinite delay of async xmit
 function
Date: Thu,  5 Jun 2025 12:12:54 +0200
Message-ID: <20250605101255.797162-1-florian.lugou@provenrun.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0109.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34c::10) To PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f2::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAZP264MB2990:EE_|PARP264MB4788:EE_
X-MS-Office365-Filtering-Correlation-Id: 4209cdb7-5e48-4b94-728c-08dda419b84e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|10070799003|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FkbWEw3aDrRzO5a8q6qlA3fk/4NiTM5bT523q8qYYJuA+RcLVEQQAzqb9Ak4?=
 =?us-ascii?Q?udA2FpWw5hODlAYot8LBwnuh4nYxVQCRDIMMu5lEiGwktx9nTrtEP42vOZLt?=
 =?us-ascii?Q?obGiIUowjRSJZpzdR8aa9mI1keXDD+MTBpO1zwMf0MlaGUfSdfJ1a6ZBTZQx?=
 =?us-ascii?Q?9K5SzF9IsEmOmzbeamKdFtL4/rlHy/RUVwN7C+4KJvNoVEPOrs726noQ5bzM?=
 =?us-ascii?Q?gpSRkL6Ig+GLhFMYzUbcnikdcg46uxMFFt7ndbDqbyXokQkJBApjLFZ6H4+G?=
 =?us-ascii?Q?U0vJFFjlNjxiX2knHoUPY1A9R3MRWvH4twfhetPvJJwrRzE2eqha0fQn1uFU?=
 =?us-ascii?Q?IF1EUwUCdbyUedJ5x2k9iBJh3l7/QVU/usDzlSLZXC5OX83k1qQ8c6ytfdQ3?=
 =?us-ascii?Q?EfmBW73gyOrjg+e7/uTRZd5PfCli8XI5Sbn8R3K/nRHDCA43P0mT8WgfwW40?=
 =?us-ascii?Q?XOXLuGyqrzOww5aPHvkjTU3teq64HtY9Xl1oe0oTJEpTOEZ2nb7zSKKK2k/V?=
 =?us-ascii?Q?CgtghBMnOA+BE8l4/ul8ljByyLLYBETGvK0zF13w7QtrU0IbrZA4Xu4NbL0j?=
 =?us-ascii?Q?qlrqH+ZQ97rRbzbYfx/3fUOrvm74olW2GsrSOhyt9kEz+uPduKkZE6u5NCAW?=
 =?us-ascii?Q?ofNPfGLAVVLxTuZdlTZfNyxz6OgcLmStV9yBMM51K6m4yrilBSUq/JkEH9uS?=
 =?us-ascii?Q?NTxShHbj7EHf+ccwcBQyvzeL20vRFquY75QhZre4KLxqy8lvSnBZ2biLxnLl?=
 =?us-ascii?Q?vrMa8IcuwQtgc+C1Ld5FfFayJlqhS94hLihqDFuJpPry1OZbpY/5/O9yeblN?=
 =?us-ascii?Q?TskJA+1nnb2ThBLHSzVNZhnHvY9HVxyDXO3d3Nc9766fW2HuT/BzIod0vipC?=
 =?us-ascii?Q?wZcxR03XkeeHSfwynsqzFHsLWGUkiOacDsbVBTmewdizgBxGPot0w7jgTI16?=
 =?us-ascii?Q?ERwizJhuaC8fCFEh62a1dj/OsjNvsK95/OJyqSwL+VvfQS/EHtYwcIhJI82D?=
 =?us-ascii?Q?/rU36WmugrL1IEwMPrLRSq2wtTUHQKoePbvQkfE/IRS33iSSzBKrzQSf6IGk?=
 =?us-ascii?Q?yi6czZVFUQL9xahEpzIFU2XLIhlIPJaUSG+y7j+nHQGgYx6DaPMIh4+ZqN2L?=
 =?us-ascii?Q?cLJbgeVA67GqWt886LvPgYC2GLL9LbLWJD0/sZtfhHZ63CDYvmdmjYOZkQST?=
 =?us-ascii?Q?Cmfq9hVkYc9skXhE9+30QExmRaM7D/r1LnoPvXUx/zdtcKKFucp+q35LSnJj?=
 =?us-ascii?Q?h9B9STLFMypXevFnKCe2xHuM3zoz9eaJ3wS3cIOOOLPOBHSJtfYLqzXLiCKf?=
 =?us-ascii?Q?0PBZZYvddR1FRz1CE6QVJ9ojdmy/ereYdQEsNzEmk135B1osNCzMK6cbxQB4?=
 =?us-ascii?Q?XmBbWHOfRMthwAH7TwaZO9Q/zxElNUi2xmohr0VRO1l1tU4CzwomV71/Ccim?=
 =?us-ascii?Q?/ZzALNFy7Tc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(10070799003)(1800799024); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OYux2Kr7oP+kVqPs79sO3zvRXe13EIjtpwwJ6q+dKlQVCd5yEahv3ca18Aq8?=
 =?us-ascii?Q?3gc0kGBYyHVHfeWzwH07TS+l6zVwZYt/VmK625nkpPbyj23rC3DMWOSbzZIA?=
 =?us-ascii?Q?L7VzAPw4TveA+Q3KuvD5N0ZMRA/Qwd9fIzVfQMvnn1GZ7uDnNCZ/KbLimsc6?=
 =?us-ascii?Q?hBRShtP0RCOwMBiJesxI5E5JGomYUrcG+V6fmx/TOw3iGzjycTtotK2bxph6?=
 =?us-ascii?Q?QQrnZNFbj5tz0F3ehcKbNhXofoORF/GLg4eOj16x+EjKyFgoR6yMFmYuhmgt?=
 =?us-ascii?Q?NrGNJFzdCQ30ondi1EijqR+HgLYUlS9sxpE4eyTpphsAu3h5ug0eczZELDcH?=
 =?us-ascii?Q?Tt/ICoxzZ1tnuPa+sGWV++GyMyuxNLpbw0oBWSoXJxjjF5L1qtbHDt70/tom?=
 =?us-ascii?Q?+mz9x3LPB7NHwBJ8sbx5F3q9s38kXFxDcAKofd5Ddpbst2DfcPLdg/VnwTTU?=
 =?us-ascii?Q?cVDQPzqNEl8WfvuKVn7fCZTBAaTtdswL09TcvAwpazOUxIAs6rZEuFatZ8u8?=
 =?us-ascii?Q?EoE6Ivlb25Q2FAzhMIv40xTa0/zWvBRz6XS93On3ZCFHZOLlPX90gOy3A8wo?=
 =?us-ascii?Q?jMH1kSrX+YeRWQG/7HtwoYgyCJ90IFwQD04l4uvdrNfBMvsbT4MMWG7kb0AR?=
 =?us-ascii?Q?4B1JVuY92DZNoUH+V0DdHRsMTwXUYX/dVCeox56lxIbfAjfVD3hKVZS6IlYZ?=
 =?us-ascii?Q?JTIrNyU77YN226dAQQCnzQa3lXFdKAAJhX8Qpw+CVdC3uUT9Z5IxSjkvh/CU?=
 =?us-ascii?Q?HEgviWcUMX1XOIJ70c1w+ln/inh4t2iHPpXm2fozCWBOmg3R76LKmvsBxP52?=
 =?us-ascii?Q?Euk6v3cH0WKe2plFAM+cfJ5yOp2l0JJ7ymnlO6DZ1JmjSzwKubBJYm90rNt/?=
 =?us-ascii?Q?uP/gULWUM2YwmoX0HHvHOwc8MSSoEdjUnJEOn9a2HYmEHBYQo6+f0SxA1TWq?=
 =?us-ascii?Q?g9ul7WghQqihouxLoXdGrdOBAjfn9cVpgKqJvcgZI9p7anPTS2NV826KJ27T?=
 =?us-ascii?Q?z/l4q3VnRDqOS7ILOXj02zTmmNeScRATwjZiMB11ygplElOdXhcK4uSkEYI3?=
 =?us-ascii?Q?RvzQHgWsrK0NiCWu0/+H4ScyawOyxFHJ9+pueP0iZ/9Dp7dk7K50JZrXM0Xc?=
 =?us-ascii?Q?WtN5hqzM1zK1xHY5GhRbgnKmlOXLdYVKr0qPerjkWqBI8TXusq7fLEM4F3Wc?=
 =?us-ascii?Q?PWGwIo38W+QOjHbGKOstUdPam8i/Vi4zAUEt0azMA09km+MiltenJyepTVGH?=
 =?us-ascii?Q?k4eR7nm8VDUo62NGGXsWCXGAxvwCU9BsCcAeJ4cZg7iawvvApIro11kVeOxU?=
 =?us-ascii?Q?WUJKh6137p6laC/ddAsOSZZpoNA1ACX71qk+Ofts0nkHdro97bCUhpWp9Cxf?=
 =?us-ascii?Q?yXz9FrP31lRIltkoNvdjm9G9X8w0Jop8goASTANn1L2VwWqNwC4kBgAmO9gM?=
 =?us-ascii?Q?Ra0qUJBDeMAUqiPXr/VbySf6qdj7P8KLQnipVzs34d00w+Oa4Zy/ehD0qkHX?=
 =?us-ascii?Q?HIx8eHYU/QYqDSQgITHAcY1A6mGahGACuZ21PT0DnA+Gl6/oAheIdS74C5n5?=
 =?us-ascii?Q?lfMNnsnn2NN9rQDjml9ZL5wQNKj2bmR2/TWcLYFdYjE4kPcylPNsFibNQlii?=
 =?us-ascii?Q?Q6wEmefaQOPQFQphE5SvwESceTy0XSQBuSXebRBOqzdlGy3wBa6j7DZ+2dED?=
 =?us-ascii?Q?b/dQqw=3D=3D?=
X-OriginatorOrg: provenrun.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4209cdb7-5e48-4b94-728c-08dda419b84e
X-MS-Exchange-CrossTenant-AuthSource: PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 10:14:13.1527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff654c30-3eb4-4445-b89f-a54a92b1f03d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8JRLwVG9zOEAHKzV7sM2DVIoAVTIGxWIgc8dqhQADCofdycApr9VuCUX6vHZFhnD0+yJ+eBOZK4VoRH08bK70g54/IV+/3ZWdzu5oTJHiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB4788
Received-SPF: pass client-ip=2a01:111:f403:c20a::4;
 envelope-from=florian.lugou@provenrun.com;
 helo=PR0P264CU014.outbound.protection.outlook.com
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

The current handler for TXFIFO writes schedules an async callback to
pop characters from the queue. When software writes to TXFIFO faster
than the async callback delay (100ns), the timer may be pushed back
while the previous character has not be dequeued yet. This happens in
particular when using -icount with small shift values. This is
especially worrysome when software repetitively issues amoor.w
instructions (as suggested by SiFive specification) and the FIFO is
full, leading to the callback being infinitly pushed back.

This commit fixes the issue by never pushing back the timer, only
updating it if it is not already active.

Signed-off-by: Florian Lugou <florian.lugou@provenrun.com>
---
 hw/char/sifive_uart.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index 0fc89e76d1..9bc697a67b 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -128,8 +128,10 @@ static void sifive_uart_write_tx_fifo(SiFiveUARTState *s, const uint8_t *buf,
         s->txfifo |= SIFIVE_UART_TXFIFO_FULL;
     }
 
-    timer_mod(s->fifo_trigger_handle, current_time +
-                  TX_INTERRUPT_TRIGGER_DELAY_NS);
+    if (!timer_pending(s->fifo_trigger_handle)) {
+        timer_mod(s->fifo_trigger_handle, current_time +
+                      TX_INTERRUPT_TRIGGER_DELAY_NS);
+    }
 }
 
 static uint64_t
-- 
2.43.0


