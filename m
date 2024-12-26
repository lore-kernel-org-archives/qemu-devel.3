Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3570E7718E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 14:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQoOp-0005Vm-Cl; Thu, 26 Dec 2024 08:59:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsogomonian@astralinux.ru>)
 id 1tQnWh-0000q9-0d; Thu, 26 Dec 2024 08:03:43 -0500
Received: from mail-gw02.astralinux.ru ([195.16.41.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsogomonian@astralinux.ru>)
 id 1tQnWe-00028U-U1; Thu, 26 Dec 2024 08:03:42 -0500
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
 by mail-gw02.astralinux.ru (Postfix) with ESMTP id 5AC8F1F9C5;
 Thu, 26 Dec 2024 16:03:35 +0300 (MSK)
Received: from new-mail.astralinux.ru (gca-yc-ruca-srv-mail04.astralinux.ru
 [10.177.185.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
 Thu, 26 Dec 2024 16:03:33 +0300 (MSK)
Received: from rbta-msk-lt-328534.astralinux.ru (unknown [10.177.20.66])
 by new-mail.astralinux.ru (Postfix) with ESMTPA id 4YJpj04sfdzkWxV;
 Thu, 26 Dec 2024 16:03:31 +0300 (MSK)
From: Tigran Sogomonian <tsogomonian@astralinux.ru>
To: kfting@nuvoton.com, wuhaotsh@google.com, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org
Cc: Tigran Sogomonian <tsogomonian@astralinux.ru>
Subject: [PATCH] hw/misc: cast rpm to uint64_t
Date: Thu, 26 Dec 2024 16:03:11 +0300
Message-Id: <20241226130311.1349-1-tsogomonian@astralinux.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: tsogomonian@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 49 0.3.49
 28b3b64a43732373258a371bd1554adb2caa23cb, {Tracking_internal2},
 {Tracking_from_domain_doesnt_match_to}, astralinux.ru:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; new-mail.astralinux.ru:7.1.1;
 127.0.0.199:7.1.2, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 190075 [Dec 26 2024]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854,
 bases: 2024/12/26 09:04:00 #26918328
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1
Received-SPF: pass client-ip=195.16.41.108;
 envelope-from=tsogomonian@astralinux.ru; helo=mail-gw02.astralinux.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 26 Dec 2024 08:59:37 -0500
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

The value of an arithmetic expression
'rpm * NPCM7XX_MFT_PULSE_PER_REVOLUTION' is a subject
to overflow because its operands are not cast to
a larger data type before performing arithmetic. Thus, need
to cast rpm to uint64_t.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Tigran Sogomonian <tsogomonian@astralinux.ru>
---
 hw/misc/npcm7xx_mft.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/misc/npcm7xx_mft.c b/hw/misc/npcm7xx_mft.c
index 9fcc69fe5c..e565cac05d 100644
--- a/hw/misc/npcm7xx_mft.c
+++ b/hw/misc/npcm7xx_mft.c
@@ -172,8 +172,9 @@ static NPCM7xxMFTCaptureState npcm7xx_mft_compute_cnt(
          * RPM = revolution/min. The time for one revlution (in ns) is
          * MINUTE_TO_NANOSECOND / RPM.
          */
-        count = clock_ns_to_ticks(clock, (60 * NANOSECONDS_PER_SECOND) /
-            (rpm * NPCM7XX_MFT_PULSE_PER_REVOLUTION));
+        count = clock_ns_to_ticks(clock,
+            (uint64_t)(60 * NANOSECONDS_PER_SECOND) /
+            ((uint64_t)rpm * NPCM7XX_MFT_PULSE_PER_REVOLUTION));
     }
 
     if (count > NPCM7XX_MFT_MAX_CNT) {
-- 
2.30.2


