Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8BD3C4453C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWWb-0007dQ-Ll; Wed, 22 Jul 2026 08:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWU7-0001l5-IO; Wed, 22 Jul 2026 08:55:40 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWU5-0003Q1-Ql; Wed, 22 Jul 2026 08:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724575; bh=s3s9oP/bcNs4nflLd+KbE5R+nM/kjFOdWRbRh+VQJ+g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=wbNj37WTmEqg6kbZC4vnp7wbXMJB09DOllIufUDDno4teB9gCv95cqb0OXt2Yli4s
 4qNo79h6D+5TTD6VnE0MJ/R+qLKiHpH8MhdG/J+EY/KMwud/PnCBZtRTgs776Z8TjQ
 dHeLEP54V1/Dhd4JOJY74FR6ik4/EC/U5WSVOHXEwG9h8TvJSfiO8DWPBg2EZaGW4T
 eJ+YbQv+24oo7zW9Vx3/YzuIjQPyllz46nS14YmjghouVxGgj6X39NnqZJg77qE76H
 +gc+IOkciTA6tVnzqiPqiYDuMLuzOALetN4OhNvioNmOUDFsAfcBGkMKwketJTwGKo
 DBDQMO6BpjKVg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6FE0D1C3B5A;
 Wed, 22 Jul 2026 15:49:35 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B85EC3F37AA;
 Wed, 22 Jul 2026 15:49:52 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 062B017F89; Wed, 22 Jul 2026 15:49:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Matthew Jackson <matthew@pq.io>, Alexander Graf <agraf@csgraf.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 v2 125/127] hw/misc/applesmc: Fix a typo setting MSSD
 key
Date: Wed, 22 Jul 2026 15:48:50 +0300
Message-ID: <20260722124859.32371-44-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

In commit 1ddda5cd364 we meant to set MSSD=3, but due
to a typo we ended setting MSSD=0. Convert the two other
NATJ and MSSP keys to use hexadecimal notation to avoid
similar copy/paste typos.

Cc: qemu-stable@nongnu.org
Fixes: 1ddda5cd364 ("AppleSMC device emulation")
Reported-by: Matthew Jackson <matthew@pq.io>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alexander Graf <agraf@csgraf.de>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-Id: <20260720115336.75063-1-philmd@oss.qualcomm.com>
(cherry picked from commit 2142689d92ca87b53ad1a0a8d48f439baf17e13a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index fd96f5f245f..d004e8b4431 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -333,9 +333,9 @@ static void applesmc_isa_realize(DeviceState *dev, Error **errp)
     applesmc_add_key(s, "REV ", 6, "\x01\x13\x0f\x00\x00\x03");
     applesmc_add_key(s, "OSK0", 32, s->osk);
     applesmc_add_key(s, "OSK1", 32, s->osk + 32);
-    applesmc_add_key(s, "NATJ", 1, "\0");
-    applesmc_add_key(s, "MSSP", 1, "\0");
-    applesmc_add_key(s, "MSSD", 1, "\0x3");
+    applesmc_add_key(s, "NATJ", 1, "\x00");
+    applesmc_add_key(s, "MSSP", 1, "\x00");
+    applesmc_add_key(s, "MSSD", 1, "\x03");
 }
 
 static void applesmc_unrealize(DeviceState *dev)
-- 
2.47.3


