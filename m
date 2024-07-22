Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D51C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 10:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVpu4-00026T-O0; Mon, 22 Jul 2024 06:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.ziming@hotmail.com>)
 id 1sVpu3-0001zo-00
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 06:04:23 -0400
Received: from mail-sy4aus01olkn20801.outbound.protection.outlook.com
 ([2a01:111:f403:2819::801]
 helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.ziming@hotmail.com>)
 id 1sVpu1-0007V7-9i
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 06:04:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XocSx7nVZqPnSQzKHOtf/HuQADvagwIEvVsSBsmnjkbGOQsn7zxONL82KkQWk7zrkVWdhQe9WcdNgjaYd+6vbfZCnQHJS+Y1bs4UnbvUcwBUP/tWbCPfdt04f8MNfXtLKdTvvlpNNlMMzFP5/dbWW5quITZ1fX5PGvNGCSibvrgDxQqSB83UtaHYNDnF3x1xkRmEaFIX6EnADrKCBWbeLCL85BQSAnG4hz/D0+SGaXAbAksudXlsAaPTYTKk7f5cOOJBfR0NPxUTjYskbfLEy5op88iUNcduMtrAac4AzwVANA9/+WCrW21hmmNeWOpAeqURBWMubuQ7mf/erhjp5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kuiyzpBTU98dPRFNKnYqyEFsNoieKPCD/0q8YSn9lk=;
 b=fNNrR1+lr6yc8IhzuIvZlXiHQh4HVutmgMEpX/X+USgUrawNy5T0HNvuSs0iyKqXcZjV2zMziXHItwmfFQDdIySLBEayUjACH2q6s5yFQ6U99cN8T4nSWDv+bwBSdvIx++iloE2O9xMgHedqFVvTOXz3lEvEr5HNZ20eces8IVWmU+CqiYhg6RFGdYxOftINK/FBG3XvDQR63g90WHjWIX719jJFegkv4ZkoGzNPrb0VeT0cv3Mud/KQT8SB5eb4rk+jvvUbkoR40wXudq/m8NZGitZgF+yPouYsSnVuKMBZ1xrEic6S4fk2wpUK3HH6zAV5998rQfkAdhdqCdmyTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kuiyzpBTU98dPRFNKnYqyEFsNoieKPCD/0q8YSn9lk=;
 b=SSJpJuzEK9oID2o5tDX9TmbaasWXBybmQfDkuRmBuoFTPndLlb6aAM83LaVK+CCZCSD6ZmJYVwvifh6bUQOhSVOTqa8TUsbq9RkP1c90o/0wlqcbzDSwGsAKeEztKNKOe5j4ebWT2wJcd8AAHM9zv3ZUwCTko2qNAJQH2jXifTaDV7U8rBNt8D8GvlFNOvdv0Xn4QDNuGVIPHYsKnKbx8ynn1DUhdQLQeriVuOPO9qYSoURPLqwj8gugEGqttN79DrKU2qROCxpBC8TJ8cvmGugy238PmMMZX0HSDa3hi66HlXr1uBB9Y+tKeLxJjjRdTVS6JNAwhXzSYzZ/LzJsWw==
Received: from ME3P282MB2548.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:10e::12)
 by ME3P282MB0929.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:86::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Mon, 22 Jul
 2024 10:04:15 +0000
Received: from ME3P282MB2548.AUSP282.PROD.OUTLOOK.COM
 ([fe80::e85:7caf:eaf4:c0fa]) by ME3P282MB2548.AUSP282.PROD.OUTLOOK.COM
 ([fe80::e85:7caf:eaf4:c0fa%4]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 10:04:15 +0000
From: songziming <s.ziming@hotmail.com>
To: qemu-devel@nongnu.org
Cc: songziming <s.ziming@hotmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2] chardev/char-win-stdio.c: restore old console mode
Date: Mon, 22 Jul 2024 17:52:55 +0800
Message-ID: <ME3P282MB25488BE7C39BF0C35CD0DA5D8CA82@ME3P282MB2548.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [rwES6enf2NLNhNan5O0Uwp/G4P1KmBX0]
X-ClientProxiedBy: SI2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:195::9) To ME3P282MB2548.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:10e::12)
X-Microsoft-Original-Message-ID: <20240722095254.428-1-s.ziming@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME3P282MB2548:EE_|ME3P282MB0929:EE_
X-MS-Office365-Filtering-Correlation-Id: aaab3a34-c1ef-40bf-2755-08dcaa35a489
X-MS-Exchange-SLBlob-MailProps: WaIXnCbdHrORrPiYp+O3K2PHowtbVet0nUv2sK4iCW7hI5wYMFvFVElV5QFv4CifNCw107C2fhbOYhxhqGzB5FQ+2y+Tjo6oc3/2xJP9BlOcnt7S3LXetDDbLSzfWBeXQ3K/YJvHjtP95u6UUor4CrQQ67yZ16CajrF5sKBfGxKuOKoX5B+lKa37vs5+duAtaAltCal+C6Sy2+SeyvtcUNcgzFEA735ryvv6NYxPngzPQ1kqX5FOjHu/ftHv9cYWyjqv1eIwn5ajaasMPLJ0IWBV1WjN2upqFFHbfxk8su48NIm9N77fhqEqAIq5+Wh9ZPqzrJ8gsGjk5www7pA4U3xxLoOkd717BkyRpJ+jqP+cjLMch8QCCKj4yvccccpwOVII0eJJDyHmaoX8z95wPyTwEmwtM0Iy8QyBI7uxYCywv34gg5tsn0+5oYt1vUvHExv7A26ivu0StRbOBIbDjgMbs4Q/1yW0xwV9stO6QtmsRpMnsmbSfhGAxu6CJNlYhm43b/p6ueuuri4S0dWrsgm3xdh0wy7c8whHKXhQm5P0niz/GkgVcAKt3fB/FzcA3C3NNkIR1UrnS3e/l5mPGd2ABFUg1wrSj9K0B8QFQ/NDy5G6vxK1VtUTj/xEU896Pg6baB7GAFzWOLHLA2WUKFHucVVielf7IV7ioShal/11YkBKprHKFMOe3GMx5esQvxPUbEvzNTTIELrsezYwVhts6DKqQE5iYnOeltZVxpDHflIRZCfxSpRz7b4El3HhSql2UmZC4os=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|19110799003|8060799006|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info: +b5cnqsCFUVRynssluRlcqSL6xc8FbtYXiBF/FMZ/zAwmA6Q4tE1QtHeXjduhdF5YMS4cWLcCP2aUvVy7naY42iqL7EtMKr5jNQtIv2Boj0Cy6YZ5+jRrulHKXrVWPNjV3+KNOh2BXB4NOjlG6DMxV6WugxCck+uQEOrRRLFAMomQwmUMserNmoZhcyvW+QSdeGR6ghLpfHsrEVBAcYxQ1bx/NYQIwJQb7cHm21ygKmJ0JF5uMVrhC7+854cqtzp+Wd6X6aISJ44jVuufpf84QjHd1L/5R21girFiZyzdYpWz2UqVEctGe0p206hyrSMy0CqSwQ3gxvKP2Q89C+Uo8RF5fwbi0PIm4NlqWN8RdgM25nCYcnNPUMQ12RunyofH8jS3b71uxUG63kAnBAXbjz5aAHEXc4wzbsWicagmchWF9A4CGbPPkmVfjzAbULTSE/lkzb9jAWqc1TgL4jxTm55fO8Tl9z5nvWY02wzTDwYw2ynlEQNr3pSZXaH9efbVsSZLst3ikwfEf26EiDntglKLmUOrhgMFQcbPH4aiuRC/Lfx87BXJfNMLpybS3ay3MaUnxIpgKOLr8kV1svJI24sG+SeRDIt+UH7ZiZHRdbkn1gfh1FSEQasP3jMcVMTTVj1LUk6yrSnGVbdNA+h5jR0UqPRUXDhEHyELl7mn48=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a6MmrsJskXlLJC7QlHJeQdUg0lr44UfpgnrXe+wogkLjO9qg0s3/fttbDgNJ?=
 =?us-ascii?Q?89nh1K+2pDmok85v/26ZC4xou6tzJKgcnXGRWeMBCyB6gOP1pY2wdDHI+EQG?=
 =?us-ascii?Q?MKWkoqooQkyVq0RTXijeWCyCIRSKTUHumgQIqhI/MoVEQNNMp3YoFVJO68Fs?=
 =?us-ascii?Q?R0ZTX2dgGqmqooUf6ZJZBwmDcDrsb756E+RcNwGXkFasb429DjP4sfcAZk/v?=
 =?us-ascii?Q?KCX5HaYhDV9OsEDSH2VSzeTYje418hIiR1P0nQGFW4f8YZgePSfCIw9UQg3t?=
 =?us-ascii?Q?fmWtatnmBd+gK3yYZo1PGxxzej5ptYkUdf3p4sh9RVuRMNTSzBWgHasN32sL?=
 =?us-ascii?Q?M6hE0mNcfY9frg5bZnj7dtkkTy5mpXaLGLCqBU48X9GkaDCaJtflOF7Hkmjz?=
 =?us-ascii?Q?B4YlHTtD2XAHICE0No6QH6UoGb/vMSN6xbSjrkaiuFS6cgYGHB4U2/wX69Yj?=
 =?us-ascii?Q?iMlQaJu3ypO2Kksi+9pkC3H3VZZZgALyYpI0nrlyN6VhNAzLsVsFc5lxBuJ9?=
 =?us-ascii?Q?BLE1PRwC6+Gx7fO6G+CTOIo9RtrExr6nXdmlonvWQtY8jvLKbnjUXl8KlDm/?=
 =?us-ascii?Q?n/4QcGBnDEQdJ0gpjecvEvGDuNVS7D1x3XnbmngnFtKn10rsLA1KKE52UJXE?=
 =?us-ascii?Q?54ng+PUF6Vh1LB+MgpfJEFfrJxU3swTu1BjpOJhfJfzEOUFJstZ5Dx+cUr24?=
 =?us-ascii?Q?4S9U1KhuKwZ27vks4gBU8TJuStJ63yjp1DECc15soucDA3+nFTNkmEtx8yhH?=
 =?us-ascii?Q?sN0mFbZon5YXR83veO8+UHsz8/7dmaGjtWC8zfqAvHSh1BwEg0bcfU9xHFF9?=
 =?us-ascii?Q?4JkQ04De5LlQoQ/fubLJLggjLWLBebvKGkx4ZRI0p/SMJDu1TrUnfsk5RI72?=
 =?us-ascii?Q?7bn5Ih4hUpOiaZL5ymLcvSz2dxqjio7AqX/ARav7PDus3QrwYQGqVdbBzqHM?=
 =?us-ascii?Q?xfc2poen8EKwFnlgKdcdsGPHESaPfNgpHLp4i/P4YrnNMoacFJg9SAj0uz1V?=
 =?us-ascii?Q?06p7doV8/lwUL83kLq83HqLSrH57jy+QWk5OguQI3u7Vi2Z6cTceYQznNIsf?=
 =?us-ascii?Q?NnZqlXBaNLwbXKPV7G0ssOSbHO9ZDMJaiPJ5Q5Oz8fkSTaYeuts9JBK2R6zY?=
 =?us-ascii?Q?i+0qD0ib2BE43HZzi88lvb3ggGWgSCnjSYmV0/rxbx0LOm7jEOFvNq5ZtFS+?=
 =?us-ascii?Q?NuwPV+VXp0nfwcecUa+5vIQV5xAWaq1mJi+cAA0uA6PgSlkjhdMJGJsA6KI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-722bc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: aaab3a34-c1ef-40bf-2755-08dcaa35a489
X-MS-Exchange-CrossTenant-AuthSource: ME3P282MB2548.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 10:04:15.2644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB0929
Received-SPF: pass client-ip=2a01:111:f403:2819::801;
 envelope-from=s.ziming@hotmail.com;
 helo=AUS01-SY4-obe.outbound.protection.outlook.com
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

If I use `-serial stdio` on Windows, after QEMU exits, the terminal
could not handle arrow keys and tab any more. Because stdio backend
on Windows sets console mode to virtual terminal input when starts,
but does not restore the old mode when finalize.

This small patch saves the old console mode and set it back.

Signed-off-by: Ziming Song <s.ziming@hotmail.com>
---

Changes in V2: only reset mode when console handle is valid

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


