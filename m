Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15DB4CCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 20:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEZ2D-0005TW-At; Thu, 30 Oct 2025 16:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEZ20-0005RR-BU
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 16:14:03 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEZ1l-0002zT-Gw
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 16:13:58 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1a8f:0:640:2fa2:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id E6A81C00F5;
 Thu, 30 Oct 2025 23:13:32 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:861::1:2b])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id VDmLnP0FIqM0-7VUKEBAb; Thu, 30 Oct 2025 23:13:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761855212;
 bh=FNRZt8jiMGXVRM9MBgJ5gyia098sWupMtwtZcP0XKbo=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=Ve8ioeN77khigmTRN6HZPrxfoCmq1LMNl4PWR9K7CFBVLlMgnQZXxu1fzTPhsfL5X
 /T/uVwPVhap1HLJrajZ1sJXtvWpEGXPNS4RZcdxZvcvTrLiBRV+nkjQIza3BBg12eR
 60bSrU0BToGYihZCzUcW5Ajq/KROwdcFtuSm+FUY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peter.maydell@linaro.org
Cc: berrange@redhat.com, qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH] scripts/checkpatch.pl: remove bogus patch prefix warning
Date: Thu, 30 Oct 2025 23:13:19 +0300
Message-ID: <20251030201319.858480-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Remove the 'patch prefix exists, appears to be a -p0 patch' warning
entirely as it is fundamentally flawed and can only produce false
positives.

Sometimes I create test files with names 'a' and 'b', and then get
surprised seeing this warning. It was not easy to understand where it
comes from.

How it works:
1. It extracts prefixes (a/, b/) from standard diff output
2. Checks if files/directories with these names exist in the project
   root
3. Warns if they exist, claiming it's a '-p0 patch' issue

This logic is wrong because:
- Standard diff/patch tools always use a/ and b/ prefixes by default
- The existence of files named 'a' or 'b' in the working directory is
  completely unrelated to patch format
- The working directory state may not correspond to the patch content
  (different commits, branches, etc.)
- In QEMU project, there are no single-letter files/directories in root,
  so this check can only generate false positives

The correct way to detect -p0 patches would be to analyze the path
format within the patch itself (e.g., absolute paths or paths without
prefixes), not check filesystem state.

So, let's finally drop it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 scripts/checkpatch.pl | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d3d75f3f13..d0f4537f25 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1741,13 +1741,7 @@ sub process {
 			}
 		} elsif ($line =~ /^\+\+\+\s+(\S+)/) {
 			$realfile = $1;
-			$realfile =~ s@^([^/]*)/@@ if (!$file);
-
-			$p1_prefix = $1;
-			if (!$file && $tree && $p1_prefix ne '' &&
-			    -e "$root/$p1_prefix") {
-				WARN("patch prefix '$p1_prefix' exists, appears to be a -p0 patch\n");
-			}
+			$realfile =~ s@^[^/]*/@@  if (!$file);
 
 			if (defined $fileinfo && !$fileinfo->{isgit}) {
 				$fileinfo->{lineend} = $oldhere;
-- 
2.48.1


