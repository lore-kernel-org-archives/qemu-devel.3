Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D17C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 18:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhDPs-0008CS-1R; Mon, 04 Mar 2024 13:52:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1rhDPp-0008Bz-E4
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 13:51:57 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1rhDPn-0006m6-IN
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 13:51:57 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3B06252E1B;
 Mon,  4 Mar 2024 21:52:37 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E52498FDC8;
 Mon,  4 Mar 2024 21:51:50 +0300 (MSK)
Received: (nullmailer pid 1475350 invoked by uid 1000);
 Mon, 04 Mar 2024 18:51:50 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Roth <Michael.Roth@amd.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH] make-release: switch to .xz format by default
Date: Mon,  4 Mar 2024 21:51:49 +0300
Message-Id: <20240304185149.1475336-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

For a long time, we provide two compression formats in the
download area, .bz2 and .xz.  There's absolutely no reason
to provide two in parallel, .xz compresses better, and all
the links we use points to .xz.  Downstream distributions
mostly use .xz too.

For the release maintenance providing two formats is definitely
extra burden too.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 scripts/make-release | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/make-release b/scripts/make-release
index 9c570b87f4..6e0433de24 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -47,5 +47,5 @@ meson subprojects download $SUBPROJECTS
         CryptoPkg/Library/OpensslLib/openssl \
         MdeModulePkg/Library/BrotliCustomDecompressLib/brotli)
 popd
-tar --exclude=.git -cjf ${destination}.tar.bz2 ${destination}
+tar --exclude=.git -cJf ${destination}.tar.xz ${destination}
 rm -rf ${destination}
-- 
2.39.2


