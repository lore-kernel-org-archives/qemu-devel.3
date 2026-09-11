Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069F8C88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 10:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4ywF-0004eM-Iy; Fri, 11 Sep 2026 06:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x4yw0-0004XB-OQ; Fri, 11 Sep 2026 06:56:45 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x4yvz-0003DC-7N; Fri, 11 Sep 2026 06:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789124163; bh=8Dn8wSbp5vyXbsqBaW4WnTRu/xhtPvf5vHXkpm4K8vs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mhnCJqiHiTVlUDuWwPp2Z+QQUlNvtEWhAnceED4TN2tsl+Uxv7rEOmAJV4XvjYQod
 QeT8PY/gbINZ1+wDb8d0fWL9NwYMugNPMhVFKx+W8iyGB7TkDcUNqK6kCrXPsIMZ4u
 sgl2OIruCYKqVbZdzBfIJakFqzrCXwPntvkDHZge+MuLnMVIFIaU74SlttGDlZKTRc
 AEF2q9h8B7IenWAfkrxAlYUyCUfnCbR592AmTHyZvHn1RASDjakO2aZyCV+VsLxgwL
 YYQ8jPiDzMpaa9VKclTtb6DEH2f/f1mI4lhPjKh6WSvA0zeoC1QQn0qSGx6M+W8mox
 PdoQuaiYizj+A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 017FF1D3B84;
 Fri, 11 Sep 2026 13:56:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C0584425DFC;
 Fri, 11 Sep 2026 13:56:35 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A92C240F0F; Fri, 11 Sep 2026 13:56:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 3/4] util/cutils: Use qemu_isdigit() instead of isdigit()
Date: Fri, 11 Sep 2026 13:56:31 +0300
Message-ID: <20260911105635.955937-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911105635.955937-1-mjt@tls.msk.ru>
References: <20260911105635.955937-1-mjt@tls.msk.ru>
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

From: Thomas Huth <thuth@redhat.com>

When building QEMU for NetBSD ("make vm-build-netbsd"), the compiler
complains:

  In file included from /usr/include/ctype.h:100,
                 from ../src/include/qemu/osdep.h:123,
                 from ../src/util/cutils.c:25:
  ../src/util/cutils.c: In function 'do_strtosz':
  ../src/util/cutils.c:245:61: warning: array subscript has type 'char' [-Wchar-subscripts]
  245 |         if (retval == 0 && *endptr == '.' && !isdigit(endptr[1])) {

isdigit() should not be used with plain "char" variables since these
can be signed and isdigit() could be implemented as a macro that uses
its parameter to index into an array. Use our wrapper qemu_isdigit()
to fix this problem.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 util/cutils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/cutils.c b/util/cutils.c
index 96c80d4d429..91ddadfd15a 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -242,7 +242,7 @@ static int do_strtosz(const char *nptr, const char **end,
          */
         double fraction = 0.0;
 
-        if (retval == 0 && *endptr == '.' && !isdigit(endptr[1])) {
+        if (retval == 0 && *endptr == '.' && !qemu_isdigit(endptr[1])) {
             /* If we got here, we parsed at least one digit already. */
             endptr++;
         } else {
-- 
2.47.3


