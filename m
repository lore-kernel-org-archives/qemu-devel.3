Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F848C44501
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wildY-00046R-AG; Sun, 12 Jul 2026 00:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wildU-0003oO-9B; Sun, 12 Jul 2026 00:17:48 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wildS-0006Th-CZ; Sun, 12 Jul 2026 00:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829781; bh=CKKitLXQVQdtvni9ISKmivflqQB3pUtdzBd6TJngwvA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PExqC+DQATzNBWHprWU3VvB7fJG/VtVfkem+Q2HXivwjyTGgILJJp7ZZfGMZ3mARI
 0NpXRj1PKxutAZAc1dVkXfukvCX9rdVDfuggHeHFfhafQ9ndZWa2eIS99gQePa+uG8
 PNDD4WfxNksvGE2eKn0RQHCGsnLy/VoeO2JwGIqkk60xuR9oZ1kPOJzfVa3jCI6BpI
 xuXWizqKYiDBcAphix49kG9HpFFDgPuxSv4H2dLbIB03DjW4Gn5nzY9BYFe3kcc6TY
 2usHstmfICicsIXIW/3CSkMne7Lm5De8tTtpg3HfKGoyXekaiTE+2ITAbvAmLlrY+d
 9P8accPKAnuiQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1BFFE1C0BEE;
 Sun, 12 Jul 2026 07:16:21 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4F3623EB94E;
 Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 415C9133DF; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 19/75] hw/9pfs: enable xattr (mockup) support for
 synth fs driver
Date: Sun, 12 Jul 2026 07:14:37 +0300
Message-ID: <20260712041539.108341-19-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Christian Schoenebeck <qemu_oss@crudebyte.com>

The synth backend is used for testing only. Enable xattr operations
by making lsetxattr and lremovexattr callbacks to return success
result.

They are still actually not doing anything, they just pretend to be
working to prevent 9pfs server from erroring out on xattr requests.

This allows the subsequent test case patches to verify xattr FID
limit enforcement.

Link: https://lore.kernel.org/qemu-devel/9c1c7128135f3bd9c2f62a3f64bb730b6a94ec7a.1781361555.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit 0e3085ddc7fb137b727829913c20ad9d08577bdb)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index 4d1ddb9979a..af8b0474cf9 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -463,15 +463,15 @@ static int synth_lsetxattr(FsContext *ctx, V9fsPath *path,
                                 const char *name, void *value,
                                 size_t size, int flags)
 {
-    errno = ENOTSUP;
-    return -1;
+    /* pretend it worked */
+    return 0;
 }
 
 static int synth_lremovexattr(FsContext *ctx,
                                    V9fsPath *path, const char *name)
 {
-    errno = ENOTSUP;
-    return -1;
+    /* pretend it worked */
+    return 0;
 }
 
 static int synth_name_to_path(FsContext *ctx, V9fsPath *dir_path,
-- 
2.47.3


