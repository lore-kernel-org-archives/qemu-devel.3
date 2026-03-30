Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC021061B0F
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 16:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7FPK-0003J0-Eo; Mon, 30 Mar 2026 12:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Stepan.Popov@kaspersky.com>)
 id 1w7FP9-0003GX-Dn
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 12:23:56 -0400
Received: from mx9.kaspersky-labs.com ([195.122.169.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Stepan.Popov@kaspersky.com>)
 id 1w7FP4-0007eV-Mp
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 12:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
 s=mail202505; t=1774887825;
 bh=Quya0BzXbsiUAgi/EXNtiWQQJwjEn4SsQ0vC4c4JGMM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=hPfoPKOZDEiOKqQGZ8EGoU50f+9HYcXtk5KVaKLz9VQgsoeAEr6cSS0oMi6Ervywj
 9ASuB1y/Cr9QSvpoeTGB0GX5ob3LoiXUuNKfPDmJ47mjPtwRorBxxjjxwkwX/t0jLS
 ynobDm4TT+CcLUpir+hB0etOiGW+PjBXXpnEx3cdDQopGfd9WEJR3ZGQ5Eg3MrfXGI
 E1JMv5l5KOjZv/0cQLBw294XctTn+wetwGCR8tEL18E+XKKcYJgiRjV9OFaV1weWo+
 ygOY05ooIXXZ4/+74bu2k4Cj16C01dwYaV6FpFcSEIKe/F/MZjMWh8CINTNNpVkg5w
 o/h/5rvWRlwxw==
Received: from relay9.kaspersky-labs.com (localhost [127.0.0.1])
 by relay9.kaspersky-labs.com (Postfix) with ESMTP id 438CF8A0BDF;
 Mon, 30 Mar 2026 19:23:45 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.208])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "mail-hq2.kaspersky.com",
 Issuer "Kaspersky MailRelays CA G3" (verified OK))
 by mailhub9.kaspersky-labs.com (Postfix) with ESMTPS id 0F2D88A079C;
 Mon, 30 Mar 2026 19:23:45 +0300 (MSK)
Received: from stepan-vm.localdomain (10.16.90.37) by HQMAILSRV1.avp.ru
 (10.64.57.51) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 30 Mar
 2026 19:23:06 +0300
From: Stepan Popov <Stepan.Popov@kaspersky.com>
To: <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Stepan Popov <Stepan.Popov@kaspersky.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2] meson: add missing semicolon in pthread_condattr_setclock
 test
Date: Mon, 30 Mar 2026 19:22:50 +0300
Message-ID: <20260330162250.97380-1-Stepan.Popov@kaspersky.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.16.90.37]
X-ClientProxiedBy: HQMAILSRV5.avp.ru (10.64.57.55) To HQMAILSRV1.avp.ru
 (10.64.57.51)
X-KSE-ServerInfo: HQMAILSRV1.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 03/30/2026 16:07:17
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 201797 [Mar 30 2026]
X-KSE-AntiSpam-Info: Version: 6.1.1.22
X-KSE-AntiSpam-Info: Envelope from: Stepan.Popov@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 95 0.3.95
 0e4b6d4f1992c354ebd6a5cc3c5624a3b0aa8cbc
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_black_eng_exceptions}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; kaspersky.com:5.0.1,7.1.1
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 03/30/2026 16:09:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 3/30/2026 2:56:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310,
 bases: 2026/03/30 05:24:00 #28352470
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52
Received-SPF: pass client-ip=195.122.169.44;
 envelope-from=Stepan.Popov@kaspersky.com; helo=mx9.kaspersky-labs.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The test code was missing a semicolon after the pthread_condattr_t
variable declaration.

Fixes: 657ac98b58 ("thread-posix: use monotonic clock for QemuCond and
QemuSemaphore")
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Stepan Popov <Stepan.Popov@kaspersky.com>
---
v2:
- Added Fixes: tag

 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index d7c4095b39..5447504ea8 100644
--- a/meson.build
+++ b/meson.build
@@ -2882,7 +2882,7 @@ config_host_data.set('CONFIG_PTHREAD_CONDATTR_SETCLOCK', cc.links(osdep_prefix +
 
   int main(void)
   {
-    pthread_condattr_t attr
+    pthread_condattr_t attr;
     pthread_condattr_init(&attr);
     pthread_condattr_setclock(&attr, CLOCK_MONOTONIC);
     return 0;
-- 
2.34.1


