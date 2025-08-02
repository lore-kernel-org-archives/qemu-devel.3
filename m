Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88793C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 11:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiA45-0005Os-SH; Sat, 02 Aug 2025 07:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pali@kernel.org>) id 1uiA42-0005JS-6d
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 07:06:10 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pali@kernel.org>) id 1uiA3x-0004A8-Ct
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 07:06:09 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7996345237
 for <qemu-devel@nongnu.org>; Sat,  2 Aug 2025 11:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330CEC4CEEF
 for <qemu-devel@nongnu.org>; Sat,  2 Aug 2025 11:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1754132756;
 bh=69Ty8umCX0X11nbT+C0FC2j+6wr3pi9aW76jvcvrnkw=;
 h=From:To:Subject:Date:From;
 b=l3ATeJYRfnVdcXhoEyXLVrZd8uBCrq48yvQLXS1//NwhCnpPRmezqnvOz3ENtMprg
 4gr3AasmUPARfd3SdjOafjK+WoBGHBKyd4creECXFWozqfITl4NeYj75vlhs5SfHwo
 A5hUtx+jGFjBvxfrszQdXjQSu7oc9I5qXPrlNnwyWMhFORksKxwu6Xu96y5awhAa0G
 HGjJibYDIdyo0Oj67EktMP6Dji4/Ls9eYU3MyCzMDvyTDZ1Eo7S3hiQORKWmnm66wA
 x53PeeoUFNPPNxVCuFXjDRqY+m9cEIdTjuJXKW69cz7tPVazYq3j5b9seeRqR6fbPM
 XGfeSvUWU6Mbg==
Received: by pali.im (Postfix)
 id B109A841; Sat,  2 Aug 2025 13:05:53 +0200 (CEST)
From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] qemu-options: Improve description for -smb option
Date: Sat,  2 Aug 2025 13:05:49 +0200
Message-Id: <20250802110549.23438-1-pali@kernel.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=pali@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Add #PRE and #NOFNR flags to LMHOSTS example line.
Include information about LMHOSTS path on Windows 3.x.

Windows NT 3.1 requires #NOFNR flag for successful hostname resolving as
described in MS article Q103765 because qemu/smbd does not respond to
netbios name verification queries. #PRE is suggested in that article too
and decrease delay on Windows 3.x for the first connection.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 qemu-options.hx | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index ab23f14d2178..d5654756f125 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3307,10 +3307,10 @@ SRST
 
         ::
 
-            10.0.2.4 smbserver
+            10.0.2.4 smbserver #PRE #NOFNR
 
-        must be added in the file ``C:\WINDOWS\LMHOSTS`` (for windows
-        9x/Me) or ``C:\WINNT\SYSTEM32\DRIVERS\ETC\LMHOSTS`` (Windows
+        must be added in the file ``C:\WINDOWS\LMHOSTS`` (for Windows
+        3x/9x/Me) or ``C:\WINNT\SYSTEM32\DRIVERS\ETC\LMHOSTS`` (Windows
         NT/2000).
 
         Then ``dir`` can be accessed in ``\\smbserver\qemu``.
-- 
2.20.1


