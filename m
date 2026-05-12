Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0FACD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuFU-00012L-Aa; Tue, 12 May 2026 17:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuDt-0006uL-Dr; Tue, 12 May 2026 17:01:04 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuDr-0006LJ-76; Tue, 12 May 2026 17:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619277; bh=HTBE+4uWbe8jRkHSoc5EWVScW05kW5626zuV3t53MVk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HRIbijYcyi36aJqa5QfAt/a7V6e2VJT/0qlTLw3z6AOWPiScgb30AfGmR+58xlMYH
 Hrm1NNWuuPmTBL4J3GmyqjCw+/odZOGZj4Z5BGBJasDhoz/bKSGUmWYOJxlxyet7tX
 8OT8x8yHncdYbmc55M/1JOILJTcCZa9mQl1M5yxP8nLQJcDn2QBZrszmaqpWUDNMa+
 sBIWv6o1r8AoNY6sKqpBGpFON4at/xLOMEPZd3BtT5GuIUoGDhlvRyZtrsdbOf3tQV
 pOI4DFE0atBGk8uQBvOtOuhH8QNwTn92NO5mr1qICN2+pR1JRWgpDYEmUGgQNAEfzN
 /Q06Ke9AOIJ3w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9D4EA1AA30C;
 Tue, 12 May 2026 23:54:37 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9DD5E3ABC7D;
 Tue, 12 May 2026 23:54:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stepan Popov <Stepan.Popov@kaspersky.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 064/107] meson: add missing semicolon in
 pthread_condattr_setclock test
Date: Tue, 12 May 2026 23:53:51 +0300
Message-ID: <20260512205437.360850-64-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
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
index 327c1e19f8..0fb949de14 100644
--- a/meson.build
+++ b/meson.build
@@ -2845,7 +2845,7 @@ config_host_data.set('CONFIG_PTHREAD_CONDATTR_SETCLOCK', cc.links(osdep_prefix +
 
   int main(void)
   {
-    pthread_condattr_t attr
+    pthread_condattr_t attr;
     pthread_condattr_init(&attr);
     pthread_condattr_setclock(&attr, CLOCK_MONOTONIC);
     return 0;
-- 
2.47.3


