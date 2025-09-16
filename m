Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC66CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 12:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyUgv-0004i4-V6; Tue, 16 Sep 2025 08:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uyUgu-0004ho-2G
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 08:21:48 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uyUgn-0008Bn-AQ
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 08:21:47 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 7C6E44CB82;
 Tue, 16 Sep 2025 14:21:28 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: kkostiuk@redhat.com,
	michael.roth@amd.com
Subject: [PATCH] scripts/qemu-guest-agent/fsfreeze-hook: improve script
 description
Date: Tue, 16 Sep 2025 14:19:49 +0200
Message-ID: <20250916122111.36019-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1758025280563
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

With the current wording, users might think that the -F option is not
required as long as the script is placed in the default path. Be clear
that the option is always required. Also includes some minor language
improvements in the rest of the comment.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 scripts/qemu-guest-agent/fsfreeze-hook | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/scripts/qemu-guest-agent/fsfreeze-hook b/scripts/qemu-guest-agent/fsfreeze-hook
index c1feb6f5ce..5b915af017 100755
--- a/scripts/qemu-guest-agent/fsfreeze-hook
+++ b/scripts/qemu-guest-agent/fsfreeze-hook
@@ -1,11 +1,12 @@
 #!/bin/sh
 
-# This script is executed when a guest agent receives fsfreeze-freeze and
-# fsfreeze-thaw command, if it is specified in --fsfreeze-hook (-F)
-# option of qemu-ga or placed in default path (/etc/qemu/fsfreeze-hook).
-# When the agent receives fsfreeze-freeze request, this script is issued with
-# "freeze" argument before the filesystem is frozen. And for fsfreeze-thaw
-# request, it is issued with "thaw" argument after filesystem is thawed.
+# This script is executed when the guest agent receives fsfreeze-freeze and
+# fsfreeze-thaw commands, provided that the --fsfreeze-hook (-F) option of
+# qemu-ga is specified and the script is placed in /etc/qemu/fsfreeze-hook or in
+# the path specified together with -F. When the agent receives fsfreeze-freeze
+# requests, this script is called with "freeze" as its argument before the
+# filesystem is frozen. And for fsfreeze-thaw requests, it is called with "thaw"
+# as its argument after the filesystem is thawed.
 
 LOGFILE=/var/log/qga-fsfreeze-hook.log
 FSFREEZE_D=$(dirname -- "$0")/fsfreeze-hook.d
-- 
2.47.2



