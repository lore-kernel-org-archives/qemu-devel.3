Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F976CD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 12:45:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrH0r-0004IK-4r; Mon, 01 Apr 2024 08:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.dayu@zte.com.cn>)
 id 1rrED9-0003fX-B1; Mon, 01 Apr 2024 05:44:16 -0400
Received: from mxhk.zte.com.cn ([63.216.63.40])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.dayu@zte.com.cn>)
 id 1rrED6-00075w-KX; Mon, 01 Apr 2024 05:44:15 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4V7R0t4KL7z8XrRM;
 Mon,  1 Apr 2024 17:43:58 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
 by mse-fl2.zte.com.cn with SMTP id 4319hrwt020445;
 Mon, 1 Apr 2024 17:43:53 +0800 (+08)
 (envelope-from liu.dayu@zte.com.cn)
Received: from mapi (szxlzmapp06[null]) by mapi (Zmail) with MAPI id mid13;
 Mon, 1 Apr 2024 17:43:55 +0800 (CST)
Date: Mon, 1 Apr 2024 17:43:55 +0800 (CST)
X-Zmail-TransId: 2b08660a81dbffffffffbd6-88095
X-Mailer: Zmail v1.0
Message-ID: <20240401174355899iU6IFrpOQSiGe36G4PToz@zte.com.cn>
Mime-Version: 1.0
From: <liu.dayu@zte.com.cn>
To: <qemu-devel@nongnu.org>
Cc: <qemu-trivial@nongnu.org>, <jiang.xuexin@zte.com.cn>
Subject: =?UTF-8?B?UGF0Y2ggZm9yIHFlbXUtcHJvamVjdC9xZW11IzIyNDcgaXNzdWU=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 4319hrwt020445
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 660A81DE.001/4V7R0t4KL7z8XrRM
Received-SPF: pass client-ip=63.216.63.40; envelope-from=liu.dayu@zte.com.cn;
 helo=mxhk.zte.com.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 01 Apr 2024 08:43:42 -0400
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

hmp: Add help information for watchdog action: inject-nmi

virsh qemu-monitor-command --hmp help information of watchdog_action missing inject-nmi which already supported in Commit 795dc6e4

Signed-off-by: Dayu Liu <liu.dayu@zte.com.cn>

---
 hmp-commands.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 772ab996a..bc7e6d1dc 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1412,7 +1412,7 @@ ETEXI
     {
         .name       = "watchdog_action",
         .args_type  = "action:s",
-        .params     = "[reset|shutdown|poweroff|pause|debug|none]",
+        .params     = "[reset|shutdown|poweroff|pause|debug|none|inject-nmi]",
         .help       = "change watchdog action",
         .cmd        = hmp_watchdog_action,
         .command_completion = watchdog_action_completion,
--

