Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808EBCD1297
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSM3-0008Dy-3U; Wed, 10 Apr 2024 03:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSLQ-0006AS-Kk; Wed, 10 Apr 2024 03:26:12 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSLH-0004ZZ-1n; Wed, 10 Apr 2024 03:26:00 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D67615D691;
 Wed, 10 Apr 2024 10:25:04 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7C392B02D2;
 Wed, 10 Apr 2024 10:23:06 +0300 (MSK)
Received: (nullmailer pid 4191749 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 34/87] tests/unit: Bump test-replication timeout to 60
 seconds
Date: Wed, 10 Apr 2024 10:22:07 +0300
Message-Id: <20240410072303.4191455-34-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Kevin Wolf <kwolf@redhat.com>

We're seeing timeouts for this test on CI runs (specifically for
ubuntu-20.04-s390x-all). It doesn't fail consistently, but even the
successful runs take about 27 or 28 seconds, which is not very far from
the 30 seconds timeout.

Bump the timeout a bit to make failure less likely even on this CI host.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20240125165803.48373-1-kwolf@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 63b18312d14ac984acaf13c7c55d9baa2d61496e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index a99dec4312..04b22142b7 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -175,7 +175,8 @@ slow_tests = {
   'test-aio-multithread' : 120,
   'test-crypto-block' : 300,
   'test-crypto-tlscredsx509': 45,
-  'test-crypto-tlssession': 45
+  'test-crypto-tlssession': 45,
+  'test-replication': 60,
 }
 
 foreach test_name, extra: tests
-- 
2.39.2


