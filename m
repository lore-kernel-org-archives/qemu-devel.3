Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEDA1062893
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 12:40:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0IrQ-0008H0-Ud; Wed, 11 Mar 2026 08:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1w0IrL-0008FW-OG
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 08:40:21 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1w0IrJ-0005rv-7z
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 08:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773232776; bh=1KKUFgNh9gZ7oLeTU+FTwfCvbuS0tBBJLiihjEM0l9A=;
 h=From:To:Cc:Subject:Date;
 b=rTXW6XFWzPAxvYY+79ND4onRYjNtkAC492JY68p5BYz+7Dl4J434VwPNmJjHIg2zL
 1mVmBktXnw+K9Hppl7jsh1g7OLh1YZ9q8v/12Zjratdnkv4lgj/XMU4763evCvFCDA
 TkCp+VqpbLppx+Lxs7Jx6SzKeGbttsWcPHtradefyAaSRemkmrX7tsWmc7gSG7PwVg
 UhCWqm6UuHA6ijA8LEdqkTi4w5C92vp3u0q9Dplg/EwPjhTNDZtiduAE93ouVMR07f
 fcUBhsmyuUL1jYztCNVxroTjJhQEqDk5XRQ/kgsWnY15z2xQ2TvhPsJ5GOaHP5fjBM
 R+VzgwUoBGekQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 14512191D56;
 Wed, 11 Mar 2026 15:39:36 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C1EBE37C1E8;
 Wed, 11 Mar 2026 15:40:13 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: Warner Losh <imp@bsdimp.com>,
	qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] meson.build: stop checking for inotify_init()
Date: Wed, 11 Mar 2026 15:40:06 +0300
Message-ID: <20260311124008.1070746-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

the only place in qemu which used the check for inotify_init()
was linux-user, which now assumes inotify_init() is always
present.  There's no need to check for this function anymore.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
This is on top of:
 https://lore.kernel.org/qemu-trivial/20260119140557.2167351-2-mjt@tls.msk.ru/T/#u
which gets rid of usage of CONFIG_INOTIFY from linux-user/.

 meson.build | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index 5143639a19..a513d3eb3a 100644
--- a/meson.build
+++ b/meson.build
@@ -2675,15 +2675,12 @@ endif
 config_host_data.set('CONFIG_ASAN_IFACE_FIBER', have_asan_fiber)
 
 inotify = not_found
-have_inotify_init = cc.has_header_symbol('sys/inotify.h', 'inotify_init')
 have_inotify_init1 = cc.has_header_symbol('sys/inotify.h', 'inotify_init1')
-if (have_inotify_init or have_inotify_init1) and not cc.has_function('inotify_init1')
+if have_inotify_init1 and not cc.has_function('inotify_init1')
   # FreeBSD 14 and older need libinotify-kqueue wrapper
   inotify = cc.find_library('inotify')
-  have_inotify_init = have_inotify_init and inotify.found()
   have_inotify_init1 = have_inotify_init1 and inotify.found()
 endif
-config_host_data.set('CONFIG_INOTIFY', have_inotify_init)
 config_host_data.set('CONFIG_INOTIFY1', have_inotify_init1)
 
 # has_header_symbol
-- 
2.47.3


