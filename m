Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C03C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 09:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVpBk-0007Dg-GB; Mon, 22 Jul 2024 05:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.ziming@hotmail.com>)
 id 1sVpBi-00077W-VQ
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 05:18:35 -0400
Received: from mail-me3aus01olkn20800.outbound.protection.outlook.com
 ([2a01:111:f403:2818::800]
 helo=AUS01-ME3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.ziming@hotmail.com>)
 id 1sVpBh-00070L-7R
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 05:18:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0BYgIg+grnt4LexwAoctjvHx9y4OYRwVby3G3qnAwxhCxqswIVGpe2z/OMQOXEA3xy8vHCUWFOB9ZwqhoUCTx0eJDGJzzT3JVH7dDwuLIjvkRzCcEIy9d6DFISbA+sWBpcZJdtCHOusdQjLVN+sfcIqOfu26LkCIxloMNEubBqq9ZFc29EfQZHlfJi5jp+0Lr69iY8Hf3NJUv3pHR1m0rZ05wgiyGwTvPQxXdenZ4BcBTX+Z5G+TbuPVFXBYDRU13tdW34AIba5U5jmLq9zwq2fHNPXT/t9TJU+mPiHbzbjPV/aK9zbwlxYgQuz2dNtYjXVfC0RmxkqLCQhRQluXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIMDSheINXwKc9jqQHtzcYJ1Mqg42IQOcxVZpaKscAI=;
 b=hqsZsmgQwYRsaJk2PQVgapkvktK52Lr70Q2AEmSlrPsQNswvntUG7gCCPFvVU6W5LQiGU2BUp3gVY79vwuqJEiB2MCk5FHeaRoYa51XBorpesVOCq3L4ZDyWOq8YYP6hqXCTh64s+JZLEiAnWktZh6Ehe7AD6D755rYJY7m9ODrtaYq02bEblqP0l6AGMyNJoaHOWC8FwGPDWOPPYZtIVtu/C5WvGCr76ti8KpXlYEgqHk7yHfOJqhEiizqUM/TeIeojsZQFxR/FBKUPJ3R+/zZ2/39C6htStcYN8oL3ZQYctaAHSoWdq0VHYvqeSgdq35/iLTyJxivvQ5sJJLZ2qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIMDSheINXwKc9jqQHtzcYJ1Mqg42IQOcxVZpaKscAI=;
 b=m4dk8RSaCzBuvjVVvpeUVKzsBOtU49G66htV4JHtthxS/jSC4FChA1684T+BhMDx1SQ1KyZLI62/HqkikDBZktpaO2WwWpjHWIC/Zuws1a3NH04yk6iMQdAvI2Rhj3bZylsXgjPP0vOG7Bv4CRqRHk+H5EQb7+StazyQ/9jUteI2JrlHPw+TpajK0J5eVZTOsgz91ECXRESnrlKmX8ql3JZXQKEyc2boxRcYFkSn+KTqD6JD1z0dTs9dFxaToFfacuO7hi4Wc0gLctG/0JpWJGYra/kGRLOOH96VntyMh4QfkP+b20xmz2y94Y+l1/s1JdTGYHcBY0oLshnw/3M7nA==
Received: from ME3P282MB2548.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:10e::12)
 by ME3P282MB0708.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:8a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Mon, 22 Jul
 2024 09:18:27 +0000
Received: from ME3P282MB2548.AUSP282.PROD.OUTLOOK.COM
 ([fe80::e85:7caf:eaf4:c0fa]) by ME3P282MB2548.AUSP282.PROD.OUTLOOK.COM
 ([fe80::e85:7caf:eaf4:c0fa%4]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 09:18:27 +0000
From: songziming <s.ziming@hotmail.com>
To: qemu-devel@nongnu.org
Cc: songziming <s.ziming@hotmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] chardev/char-win-stdio.c: restore old console mode
Date: Mon, 22 Jul 2024 16:54:48 +0800
Message-ID: <ME3P282MB2548B9C3523209F6045785D18CA82@ME3P282MB2548.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <CAJ+F1CJXWRSktYPucOvO5F-zC73VMaUFfxUxksxMTLKugYNB8A@mail.gmail.com>
References: <CAJ+F1CJXWRSktYPucOvO5F-zC73VMaUFfxUxksxMTLKugYNB8A@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [gpm5MfbB9iQVKnbzSFn0AZQsatm5OJI7]
X-ClientProxiedBy: SI2P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::14) To ME3P282MB2548.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:10e::12)
X-Microsoft-Original-Message-ID: <20240722085448.2025-1-s.ziming@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME3P282MB2548:EE_|ME3P282MB0708:EE_
X-MS-Office365-Filtering-Correlation-Id: b5c78851-c7e3-4395-13e2-08dcaa2f3e4f
X-MS-Exchange-SLBlob-MailProps: WaIXnCbdHrORrPiYp+O3K2PHowtbVet0a+BB+iU3UuwNBkHBRykGT0cHQ3KoDOc8CqPuGbtXmq4HZlIGlOxofyFTXMYPG9LcAjifsWZSHGAqdITEWqwgK+ZJaN9SmuZNfyjwnZwUNUE8Kr10yln3MjNw+NroWZoD7LvWJDWln+Q2CKcBDOLUe4MYJxL6g7RQdvnX87n+NwrT0JToXP4r5PFd29KCb0IwxggH97WQauz5W/q6bE2TqN/hdFJygt1pNYDnpPbS6fyk0Fe6Ay72tJ0t6qKpbfxNnzPci6i0vJKfkHMWEOdXKmvVX8PPxBjPXLHMBx1Q7hnHysmrWBFGQfVpwnsMIggTXlf6XpJHgtNZ9+x+lUOO98L0CDGfJB+EatirZctqiBbikjqq2+S7HIsYIHXhATGU+XtyJlps4TobeUWiBliCsNj6d6vmeTAqBvERx+5B6LgZMA7RBMSg2mRZ83cmg8lPQTcnlbfstxbEXRD91SnEREkpuGC4VvzQXFxKcqWQX182VkTxCfFKyPgj5eQe3um95cB4Dtnq9UdlQRA9MDW7cGOtd9VgXuu1weFCXZ7IRTpUYGtAmGkdul11snqgE0euXKYOcI61kaU3UzIcpuzce4S7VfO7XJ/tO63tp8kmOm08/wQcyqdX3TACdzVEgdmb0QmOpyqCjz7P5eewTMR0ei1NIHYmRIWXBmzx4f1i225ivZ0iAjJxLY3vRx8WoliT0JD0JBrEVSvPrcSFFX+zqE9qQZ2saxuRCtedtRg9HfM=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|19110799003|8060799006|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info: 7raXGqZbXijNxnxdH3o6XwAJzyB0cf0BXNdWg7KgLGOaiX8tZo3Ku/2M1Q7LAXO4uFMlAjQyZyTLDa8jhvq6iJ9cpIWtifH1/fmKDKvG9fXGYt9av356dNDX15xS5RK0JaGO2zdwlXpwXKnEvPTYBOya/KuYTuejRajIzF3gf1XbAMtPtdSYlWl0cczUQl0BfrdPI/X/dljwh/4wyycGuZmE83osruS84MkO/cIRVfpyj3ENLgo7jCiu7VT2dWgZHFMA0sXHpBWnX85R0F7vVcjnsqt8fr1+TinUAd9DYnbfLbFZnGtrhafoCq9RrgKXrtThowpyYF2qGaNPLDrkBZidXT/q5pCkaoL3El73FYUyRWUgFQf5p4rQ4buuu+5qZMCxXuK2XgjgfODAU9BoxUcM/TDjRWPiXvUWgrfRR666DCwtiADxxYW6nMUY8MYBYOuGLVUZtD/WGrILqcanCSjqE7HsoRBAdrVlVly63X+fNB1g7Q937i8NA9ExrFWmx3grB4ZDw9OO4F1v+4K+T1gDBkbaZ6TWO4RCArlkMel5udK7/qCFoMX5BrQ8erTK0gLAu7iDhDfrt9FBopp8oGPQrJOwW9FQy/6Vz8FfKIohfKQG3yoiiVxHXwYUb7wU2FzYkHRGOIJdz/5884S1eRAufMxI97KcfnshNKG2frs=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?krPRILkRfjctbAyulST3rUghwcmWxyFdYP+NaZlG9Z8sdEG0u8rleoaUDtsn?=
 =?us-ascii?Q?0ZdJ8JszD3+gzGmeA5zwIKw5rK9iCmyeA5/oUcG1iHt+3bYdlQl0fpeFO37Y?=
 =?us-ascii?Q?mNtdfIjqxpPhy0ryLWuIHMAXwbpNDBFkd7MCtxbD/V+2p+51XApxcv4Ze8cO?=
 =?us-ascii?Q?3PH/1cqExOvGSvuHO3hhR/sgCTzx0vgPyfWDUI9oA+0ApDoJwjESR1xKZCNV?=
 =?us-ascii?Q?4GuUQBFnuWOXF9Gq0s7wXzhY9xMVDlRiMY/IvF5vDza3Ogrj7BbOTH4gfx7e?=
 =?us-ascii?Q?r0vQOMuTjSEv1BLalmD0/dalhjuuvy+8/bR4u3adYVlhIVczTgMs+1DfjGKe?=
 =?us-ascii?Q?MeC5+tAe7lxJeomOeweNcr8eP55/w3wRBatwzyQYc+h8NUM/tcNVFS1pwLJI?=
 =?us-ascii?Q?sONOFfMpK5IKIdQvbW1W0s4Oc8vnXG0WBdMzgOPy4JARckyOtJ1nLV1iOYpK?=
 =?us-ascii?Q?42gQErc7NwcBxm2ZoUThWiHhL+sLUKYyAsDWMiM2gAfsut26bt/ipNo51pcP?=
 =?us-ascii?Q?PvEloCGUesnJrCqvjvAP/bVHdFjp5+K3VPFpx6DZp/cY8SbyvuPi5oJPad8L?=
 =?us-ascii?Q?gyI2g6UtV7n6JnvvrWE/qk0YatvrJWyrgH6FL7H1Nedkr9spCqPvcNJhsxX4?=
 =?us-ascii?Q?FSrhxvulR5zFk/5dXz78/dZCTtd1bwbSPwjmOSuS42Y/pNCeoYjngYLUEqgi?=
 =?us-ascii?Q?+XsmN9U3NrQBuxfC9UObGf+2vQnQNaarASsXdVWInTCfoQsjkWedcRf7LKbo?=
 =?us-ascii?Q?8/5Oey3hbT2IEVYii0d1ouOp2pqX5HvczWR22fU3GH2QeyYFNF5rtqg6sbBn?=
 =?us-ascii?Q?VLPtQDtkZZv2OgpBf7YcpNzYcxdPLcvZe0VgOaPIqb4eI7mBPaq8uDEj8Lim?=
 =?us-ascii?Q?4RnKtmTJeWWQUP90mVGNm+iiwIxuqRP2ftaBBeZiJsAeyohLEQZ6C+23+7lF?=
 =?us-ascii?Q?Ybv7OETnAoPpVAIlgFna+MVBe8rFU9GE2vCOcbGLdWllDRbgz3jM5bUperaR?=
 =?us-ascii?Q?aKYNCUgaDdGyP5Hty2JoxQZoC1AIHwx+o2ZXPkjqjopTn365P1ul0/9mDw9x?=
 =?us-ascii?Q?NnyRIzQ49e3wUOZ8tismYLsfbdPNHuZGalcViGT/1610hCwmF+KJYBfbKbu6?=
 =?us-ascii?Q?z57GpbhRzKrcR48lQ9CbJMrWtaDuvI/dANrvSHvs6DViFfoLC6NsBlytBl7p?=
 =?us-ascii?Q?QcdRDmeHJ1RWcl6yuqOuEsjwdRCkPSwFB5NIU0NB8RMtm9ha9r/w3MIo4PU?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-722bc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c78851-c7e3-4395-13e2-08dcaa2f3e4f
X-MS-Exchange-CrossTenant-AuthSource: ME3P282MB2548.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 09:18:26.9388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB0708
Received-SPF: pass client-ip=2a01:111:f403:2818::800;
 envelope-from=s.ziming@hotmail.com;
 helo=AUS01-ME3-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

I've updated the patch.

Now it only reset mode if handle is valid.

Signed-off-by: Ziming Song <s.ziming@hotmail.com>

---
 chardev/char-win-stdio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
index 1a18999..13325ca 100644
--- a/chardev/char-win-stdio.c
+++ b/chardev/char-win-stdio.c
@@ -33,6 +33,7 @@
 struct WinStdioChardev {
     Chardev parent;
     HANDLE  hStdIn;
+    DWORD   dwOldMode;
     HANDLE  hInputReadyEvent;
     HANDLE  hInputDoneEvent;
     HANDLE  hInputThread;
@@ -159,6 +160,7 @@ static void qemu_chr_open_stdio(Chardev *chr,
     }
 
     is_console = GetConsoleMode(stdio->hStdIn, &dwMode) != 0;
+    stdio->dwOldMode = dwMode;
 
     if (is_console) {
         if (qemu_add_wait_object(stdio->hStdIn,
@@ -221,6 +223,9 @@ static void char_win_stdio_finalize(Object *obj)
 {
     WinStdioChardev *stdio = WIN_STDIO_CHARDEV(obj);
 
+    if (stdio->hStdIn != INVALID_HANDLE_VALUE) {
+        SetConsoleMode(stdio->hStdIn, stdio->dwOldMode);
+    }
     if (stdio->hInputReadyEvent != INVALID_HANDLE_VALUE) {
         CloseHandle(stdio->hInputReadyEvent);
     }
-- 
2.34.1.windows.1


