Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841CFCD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMulF-0001D0-3D; Tue, 12 May 2026 17:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuky-0000c9-AA; Tue, 12 May 2026 17:35:12 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMukq-0003dD-RO; Tue, 12 May 2026 17:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619501; bh=LY0TJ+s2kr/iIXJIunpGAvKJ7pHGKcccos8a298YuYA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=u48iDz4lO+CvQqSTtIuGIfZguZClwWWo+X+WBLlrxSoN2U49jjxqC1436gOK7QEOd
 lAOX0ty9jkwcg701pS4s/Qmq/TOmBfGN+0nSVWq3XcTbJZIT+K/J+1/hQf+yiNDW7m
 lXzOUBJslZzpWhsWUW+lrS8hye7BrZtE8WKEMfyXLgtW4louIp2dkj7cKgDZ+a9vDb
 nH7/pXShoMXyiWQgH1s+3X2Z0bjOUtwBkOvSI1uS3niZyq8gEHjMfI4uZkf7SgaKTB
 3hb62Ac7dapmNtbCelGdpE0kV+2yEIX3lcerrg7TQzKBGDlbhpcNjb2cWMELBUXDn9
 26rNo6HQf3ToQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 04D9E1AA406;
 Tue, 12 May 2026 23:58:21 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0F5C33ABD5D;
 Tue, 12 May 2026 23:58:25 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.1 58/58] tests/functional: Make socat wait longer in
 migration exec test
Date: Tue, 12 May 2026 23:58:19 +0300
Message-ID: <20260512205820.361821-58-mjt@tls.msk.ru>
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

From: Fabiano Rosas <farosas@suse.de>

The migration_with_exec test is failing sporadically for all
architectures due to a race when the destination socat process takes
too long to start listening while the source process is already
issuing connect().

The race is inherent because the exec: migration spawns the
to-be-exec'ed command asynchronously and returns from the
migrate-incoming command. The localhost-only testcase is not
representative of the majority of migrations. In a real scenario
between two different hosts that race wouldn't happen.

Fix the testcase by configuring the source socat command to wait
indefinitely while trying to connect.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260422230001.3168-1-farosas@suse.de
Signed-off-by: Fabiano Rosas <farosas@suse.de>
(cherry picked from commit b4ec2e8dae4da74498068536a336fd7424f8446e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/functional/migration.py b/tests/functional/migration.py
index 144f091ba8..3b7674af3b 100644
--- a/tests/functional/migration.py
+++ b/tests/functional/migration.py
@@ -85,5 +85,5 @@ def migration_with_exec(self):
         with Ports() as ports:
             free_port = self._get_free_port(ports)
             dst_uri = 'exec:socat TCP-LISTEN:%u -' % free_port
-            src_uri = 'exec:socat - TCP:localhost:%u' % free_port
+            src_uri = 'exec:socat - TCP:localhost:%u,forever' % free_port
             self.migrate(dst_uri, src_uri)
-- 
2.47.3


