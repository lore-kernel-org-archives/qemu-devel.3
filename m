Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C25CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuVo-0002oW-HD; Tue, 12 May 2026 17:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuV9-0001ln-G7; Tue, 12 May 2026 17:18:53 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuV6-0007uB-Do; Tue, 12 May 2026 17:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619497; bh=WzazOYJib6UYK1Lpk5NVX9UN/ML2FUg6X18bS+E6jgQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=UB6bwHOBZEq6XsyRMFkG2LYC673VPnI7PaFIxIAvwiR/UNXqi2KFof4DDCjbV9TdK
 /SLhTXJQqX9GXqFnI4HKaiLjKHvYVUqtHRGsXqLsTmj0gYS0K9cX2nCTUeQg7Xvh2U
 oXloyyBRFf/zxKh1ruclBX53lwsyjmoo2bZrlox8dDSmmTd1rYwFf0eUVRGCY3WA93
 9RN49eCbD4yz+ApPmSwzzd9j/ZVlism3Peyr6dPm2/xIK/MJpn3OpMPcAEtkfTXKh/
 ZadPV4kuZSbY24NLbhJu+0CtUGTDFgp0rSLniHyHepOo0SXQUMmP7IeZPQZpbvnVw1
 CLwC6JTeVDFKQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8FE091AA3D5;
 Tue, 12 May 2026 23:58:17 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8F3273ABD2D;
 Tue, 12 May 2026 23:58:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stepan Popov <Stepan.Popov@kaspersky.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.1 10/58] meson: add missing semicolon in
 pthread_condattr_setclock test
Date: Tue, 12 May 2026 23:57:31 +0300
Message-ID: <20260512205820.361821-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
References: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Stepan Popov <Stepan.Popov@kaspersky.com>

The test code was missing a semicolon after the pthread_condattr_t
variable declaration.

Signed-off-by: Stepan Popov <Stepan.Popov@kaspersky.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Fixes: 657ac98b58c ("thread-posix: use monotonic clock for QemuCond and QemuSemaphore", 2022-02-22)
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20260330131406.87080-1-Stepan.Popov@kaspersky.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 79bc1771867723cb70dac0fae8f2c26fda1a635d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/meson.build b/meson.build
index ab3e97eb9f..d7b03e4746 100644
--- a/meson.build
+++ b/meson.build
@@ -2890,7 +2890,7 @@ config_host_data.set('CONFIG_PTHREAD_CONDATTR_SETCLOCK', cc.links(osdep_prefix +
 
   int main(void)
   {
-    pthread_condattr_t attr
+    pthread_condattr_t attr;
     pthread_condattr_init(&attr);
     pthread_condattr_setclock(&attr, CLOCK_MONOTONIC);
     return 0;
-- 
2.47.3


