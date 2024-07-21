Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D3CC3DA5D
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2024 20:01:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVcjW-0000ru-0x; Sun, 21 Jul 2024 16:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.ziming@hotmail.com>)
 id 1sVbbf-0001Ew-QM
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 14:48:28 -0400
Received: from mail-sy4aus01olkn2140.outbound.protection.outlook.com
 ([40.92.62.140] helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.ziming@hotmail.com>)
 id 1sVbbd-0004Gd-WE
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 14:48:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FaYrz0btHKYidvEKB2gsUMDwfM/p5nLLk7hLIFPtb+APZ/tHwdVXAmBpZqq9GypGBFlyGtXPUnnXDVyw641UwGyyAS42dytB5kqBVC/DxzbsHYjnGIcmzTUkMa5ZxZ2rtxICYsmBpziuQ2LaHm6UQS8RSf5LOOByrWBB36/OhJpEJplcbaOz3QHpNSlAIfT/EmVgp2b8mBZwiQ15u617j8uA2swTTiWCt/uj+GGaV2gwDJMEsDaQ7UC1AiAh81fluKhKCTOR8espYoB72W5SRRZ9KxAlkgwCUAhF5pcUvVgIHcpwT72xbx0FIgCT7nNuvv4HrhDAnJNaK4DLhokXQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1WIvnOm8WuhEFKxoggcOml/AcHMyOO2yEtnW/u5uqk=;
 b=aGOeZFv6nfjhu3BXT/D/UQ1aKW8iP6JaSUKVpZQzfXaqauiQBGbVKsDpsUEdZFSw5Ix8JFd9q8KGNRPoY334q9zzh91tD12HtayvKvmeC3zNQwyyDdVFH4RLpXNfmgyG3ZLHooe4Eg6i129RN5EjRxiM6ts5nX9Cd/fqnqvXqFboUNDpDbRmtB1c/drdARlsAmM5Ci7mdTkKl35N78S6hcx4miLWwzq3Xzf0AzEymZ46TfdRd+Z6fm2i88DNmmJ4JvhZX8jlpylvQ+m3FWPoJP2NZtZJsNjv27yAvWE7QtE2qZNmyULGI69aCJQMZZgD7khqhm0emxdQ25zPSmBoew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1WIvnOm8WuhEFKxoggcOml/AcHMyOO2yEtnW/u5uqk=;
 b=GAFsf8/7dD4VlLgKr6dabrDMnKbZ07njLAxnGBgsHYVZ3mYehYUxNUxCz3pcAeG7iKePhnm2usSBle9/Igug/YAGgUswGbQkUmAfIxHLxL/0OZmOEFdtIUWPvj3kDOnW0vn+fOp4U5HixgqDOaQ6E4SnBhd0GaoaVCOfzI2SXiGb/gk9NGfEUTjo56Ui9Ez5qgaVboxC3YCxf+KgPs6W6oAPgslFa8QJCUiOKsL/NQOqK0v7v4uPepFzYuPsDBCz0UposB4pbgp3PKs5eI7a3R1yeVbY32p8uRzT0FvhFYeRYnVqoZRJBUQi5lA4jY6OM6OxpGZoKA8eUISw8LV4Vg==
Received: from ME3P282MB2548.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:10e::12)
 by ME4P282MB0822.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:9d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Sun, 21 Jul
 2024 18:43:17 +0000
Received: from ME3P282MB2548.AUSP282.PROD.OUTLOOK.COM
 ([fe80::e85:7caf:eaf4:c0fa]) by ME3P282MB2548.AUSP282.PROD.OUTLOOK.COM
 ([fe80::e85:7caf:eaf4:c0fa%4]) with mapi id 15.20.7784.017; Sun, 21 Jul 2024
 18:43:17 +0000
From: songziming <s.ziming@hotmail.com>
To: qemu-devel@nongnu.org
Cc: songziming <s.ziming@hotmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] chardev/char-win-stdio.c: restore old console mode
Date: Mon, 22 Jul 2024 02:36:27 +0800
Message-ID: <ME3P282MB25482B87915BEBE85CCE7E898CAF2@ME3P282MB2548.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.45.1.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Bbl3mrtKJunjFUbCQg7HaSNFM2HhSvjUr2qUH9ladwpFkCsyAhQbD8vZuKMs1gIo]
X-ClientProxiedBy: TYBP286CA0032.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::20) To ME3P282MB2548.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:10e::12)
X-Microsoft-Original-Message-ID: <20240721183643.1028-3-s.ziming@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME3P282MB2548:EE_|ME4P282MB0822:EE_
X-MS-Office365-Filtering-Correlation-Id: a752c0d3-5e86-4001-d0ce-08dca9b4fbf3
X-MS-Exchange-SLBlob-MailProps: WaIXnCbdHrORrPiYp+O3K2PHowtbVet0a+BB+iU3UuwNBkHBRykGT0Ajzi912SoQz80VUxaLcYOJF/FpDKUouxmCvlQCYzqLlFHdUbOwE6GPOvtS0LiYav6E/4HXWEL+T4ZC5StPwE4QWxhDHEAAqZ9Rc3ZjNxHmoK7an6/FYK2IZEnVGVyIFRL7WOQh/KwNylE3dPeFhwU59bAmJNxFnc5lTSwQyBvtXkgAE9nfXeZKVlCBs9jvIDQ7UDIazNC2LGLoEyuuWJD16yVqdjtVrcSW2lRLy12fDUKLssVgSEzBxUAE/ffvfV5MxKf7U1gqi0uzSzqbu1vmwpMAoiC7Nki7zJ6AdNLSeFNKVnfDc0ywqwEH61nzYqMkKM+VTV53yJANmHChMsB+rhZcp4NArSAeSS0ijxEFR24YP1V98mE7pca0yOmzUnwRv0xybpxClAqb9lwIvwsS9E4tQo74UNHo0X5aRTMSewcRJBQ8ZWhs1Lwkpyu41foUvTI2Hrzn+OT2XSKlf0R4yXXJInk6xaKyvGStSVRnIwn+SudMVdFIx2aQkqgPLfXkn8ZYGri3vlV5onhDTsIJDqV+5zEiFJ6RjNYZbCOUtxivVAgKd1Nh44afhjgEGnCyFm/lAvPLWRIamyPmonwGDUgWoE5tetumhwlR1BjcMpZeYcoT5qUn0E4L9686wV214Yy1ny19FDIizW/sAlOtNrgvsuEy2K9FEtIjf+iHF+6bVqWqWrXJ84yaNNSGPffhKCiyCWg1/JT1/YSA/ik=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|19110799003|8060799006|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info: Z4axgxXRRdYq+NEMo/dgYlJe7WkOTek6fesxelQtOALx/uYQV+ZJyOhygRhFrZ/67s616ZlsUNW2hgW9K9N6u9EL+jVg3ytFDJ0IDf8iMwfvuUwh6up3oP92BSOKhxX968d+5fIdZg5KMP1P3mhCPuTOb7ojkK8xftXz+Dim2eQobthhYI+hrjRYcWAxecVBFAHOa/tcMUHCoTyRQfDVEvDSXMfF2N32B7IYq7iGod0TeSiO4TZFAZH2jJ7FgAiEw73KPtmFQU9ha+TrvS58F81vxxkseyi+sFkwa7ne0+PoKo3sZ9zJRG2URG5TFJx2oFf+CfWnV8agpQicSFzpBJRFhxNn/RxW8RZxAGS7cHI4y+kbc9k8vGz6bMs7KFcAai3NI1Ba6GVSmYmeWoC1S9A5pjBiUTqpM/y00+dpd2VN9E6IEi3tr66XJcAIUclZ0cxWv+cVlsSV21ViREHVsV8qMQWTknBrtl3zPOCgcw3Kotbk2bX4m0ok1ddYAhEeWrDkiQnDEcQ1ZOZYgw/wDXdg5cuTiWJRxD3pt59qEJpvK6xQlsBriu3CMuMRu4eybbqgxd1zwp3Ly1FZWT5hJ2CbQXRc2uaNA7lowvwiX1zMcle83VhNzo2htH1fr+lZ6L+iEyMgOVAvd/8PUSqSHVCk56mCh8CrVhE0boXd83E=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g5ZZSKtkrqtoJ4kU8UdqjeGJJA+HGxPoYdZoHx8sf5Z/RO2F/eb2A9Gw/BnG?=
 =?us-ascii?Q?tSbjsSj+aJWb2cCv6vuAvH7joSuDEt02gPGrsMmOkna7YP15g6Qfjck6B/7r?=
 =?us-ascii?Q?1XsYDJbB5sp+W8VlHwjuKQk3qbuVL4jAk06MybjAPjJBHjsGjBOdw3XI6QYM?=
 =?us-ascii?Q?R6n3QZCR/tprmNMy7qgSZvAEb0YtIN1YcbQNomPkuk6wfO9DOtX8aluWBxZ3?=
 =?us-ascii?Q?8JxobRdAgHej8vgIt6riiQSt4v5tk/8ieD060VVts5c6qdoRRgXSIpmVwuAF?=
 =?us-ascii?Q?9Dtd5zlEGdBYHN8tuZHJom2DRtCYf32/05OpGAsoscQtcXw6sbG2RmgPOE0y?=
 =?us-ascii?Q?FSVhKcLyQd+SMnvccsLB9WieCzOvC9wqwLbySio8/35Wh8rXNnaNq9Mm0u18?=
 =?us-ascii?Q?tUtBLCUaH6P198lOH7yiA3DkLFRr62T77XeSWrQtyv1tKzoPPuHjyswU3ZUr?=
 =?us-ascii?Q?m3Zt9+PuBOs4GBGbSyvHRNtNk66p5Hs++bjutd4+zRT036KLmlvuFD9atJuO?=
 =?us-ascii?Q?rC9BpiIjSLlKAKWAvaoM5QIDCfIXMqG3WGiBETYPZZ763r0CgnVoTfu91dq/?=
 =?us-ascii?Q?dZQA2cGFfWLHFykldVE4LXzlglQRlsLbzqAuz5kTfA3l893Gzf9DRduERbBf?=
 =?us-ascii?Q?vjVej4YB+x8GuxVLNyn2akRN2O3jkRpjg5z7dxxxQ8luNj4SSU68gwHbBIoZ?=
 =?us-ascii?Q?VqgU/bTpYtrHwmgYfsRwgYgOxpApf44argnncBxMUcRlQDxs9D25yb7kofcp?=
 =?us-ascii?Q?UECiYvSZ/kWcaVHWKm3gmaIvOoaRift+enthf8kbDpKfnCpaFKXxzpPwmI6n?=
 =?us-ascii?Q?5oMtyXdDAvTkoxO5Z/1kC2WCLIk1UpdqlHg0kpQbO+twAfvdkyywISNL0De1?=
 =?us-ascii?Q?esTqOTBBvN37d0XjPM0vTrIPrIlaC/sUXW4nQ1W05etp6AFZuBd5Vj58VEW0?=
 =?us-ascii?Q?dYhkqc33G8VXVr0Bi6Vc2EFkdUN8z3PfT0xA5z52JbPXJ5XQ5ZRUpoKJY4v1?=
 =?us-ascii?Q?I8utz1uPhKwycwcgZ+zywLlxIfBh5s8faAbryuIg+MyqRsbtJ+CV/sX1KF2J?=
 =?us-ascii?Q?niDTtzeSIH3oFkx5o32sKg+eHiD0KIp6LFF8555J/I18zK+Ii2PM1TaK6XhF?=
 =?us-ascii?Q?lMafuQGgBR3oKJL+xK321Y6QvwWzCvF89cnVqG6IV0DikJXX8dqIFf5b4+Ci?=
 =?us-ascii?Q?LQsrUllnYJh4jFh6MyAUPVNBMj00BxMkD29jbwiEHBPOrfLBwTIdNO+NQP7x?=
 =?us-ascii?Q?SeQ+xaiFjJihAZbYYRMO7FK4DMtreISw88yp3PtVkcPZboY00loc3i8cGiHs?=
 =?us-ascii?Q?xvs=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-722bc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a752c0d3-5e86-4001-d0ce-08dca9b4fbf3
X-MS-Exchange-CrossTenant-AuthSource: ME3P282MB2548.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2024 18:43:17.0143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME4P282MB0822
Received-SPF: pass client-ip=40.92.62.140; envelope-from=s.ziming@hotmail.com;
 helo=AUS01-SY4-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 21 Jul 2024 16:00:35 -0400
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
 chardev/char-win-stdio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
index 1a18999..5b24893 100644
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
@@ -220,6 +222,7 @@ err1:
 static void char_win_stdio_finalize(Object *obj)
 {
     WinStdioChardev *stdio = WIN_STDIO_CHARDEV(obj);
+    SetConsoleMode(stdio->hStdIn, stdio->dwOldMode);
 
     if (stdio->hInputReadyEvent != INVALID_HANDLE_VALUE) {
         CloseHandle(stdio->hInputReadyEvent);
-- 
2.45.1.windows.1


