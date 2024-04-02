Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F8EC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 09:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rraVg-0005u6-OU; Tue, 02 Apr 2024 05:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rraVY-0005s0-Hn; Tue, 02 Apr 2024 05:32:46 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rraVH-0004PG-BV; Tue, 02 Apr 2024 05:32:40 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 063925B08D;
 Tue,  2 Apr 2024 12:33:41 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0189AA9349;
 Tue,  2 Apr 2024 12:31:58 +0300 (MSK)
Received: (nullmailer pid 2931152 invoked by uid 1000);
 Tue, 02 Apr 2024 09:31:57 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Dayu Liu <liu.dayu@zte.com.cn>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 4/4] hmp: Add help information for watchdog action: inject-nmi
Date: Tue,  2 Apr 2024 12:31:57 +0300
Message-Id: <20240402093157.2931117-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240402093157.2931117-1-mjt@tls.msk.ru>
References: <20240402093157.2931117-1-mjt@tls.msk.ru>
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

From: Dayu Liu <liu.dayu@zte.com.cn>

virsh qemu-monitor-command --hmp help information of
watchdog_action missing inject-nmi which already supported
in Commit 795dc6e4

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2247
Signed-off-by: Dayu Liu <liu.dayu@zte.com.cn>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
[Mjt: decode and word-wrap commit message and add Resolves: tag]
---
 hmp-commands.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 17b5ea839d..2e2a3bcf98 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1412,7 +1412,7 @@ ERST
     {
         .name       = "watchdog_action",
         .args_type  = "action:s",
-        .params     = "[reset|shutdown|poweroff|pause|debug|none]",
+        .params     = "[reset|shutdown|poweroff|pause|debug|none|inject-nmi]",
         .help       = "change watchdog action",
         .cmd        = hmp_watchdog_action,
         .command_completion = watchdog_action_completion,
-- 
2.39.2


