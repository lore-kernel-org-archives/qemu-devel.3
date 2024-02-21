Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3BEC48BF6
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 08:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rchqx-000160-HZ; Wed, 21 Feb 2024 03:21:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rchqo-00012e-5G; Wed, 21 Feb 2024 03:21:10 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rchqm-00029Y-Ff; Wed, 21 Feb 2024 03:21:09 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3237F4F3C3;
 Wed, 21 Feb 2024 11:21:20 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id F3932860A2;
 Wed, 21 Feb 2024 11:20:58 +0300 (MSK)
Received: (nullmailer pid 2142001 invoked by uid 1000);
 Wed, 21 Feb 2024 08:20:58 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Yihuan Pan <xun794@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.2 05/60] qemu-docs: Update options for graphical frontends
Date: Wed, 21 Feb 2024 11:19:53 +0300
Message-Id: <20240221082058.2141850-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.2-20240221110049@cover.tls.msk.ru>
References: <qemu-stable-8.2.2-20240221110049@cover.tls.msk.ru>
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

From: Yihuan Pan <xun794@gmail.com>

The command line options `-ctrl-grab` and `-alt-grab` have been removed
in QEMU 7.1. Instead, use the `-display sdl,grab-mod=<modifiers>` option
to specify the grab modifiers.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2103
Signed-off-by: Yihuan Pan <xun794@gmail.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(cherry picked from commit db101376af52e81f740a27f5fa38260ad171323c)

diff --git a/docs/system/keys.rst.inc b/docs/system/keys.rst.inc
index bd9b8e5f6f..2e2c97aa23 100644
--- a/docs/system/keys.rst.inc
+++ b/docs/system/keys.rst.inc
@@ -1,8 +1,9 @@
-During the graphical emulation, you can use special key combinations to
-change modes. The default key mappings are shown below, but if you use
-``-alt-grab`` then the modifier is Ctrl-Alt-Shift (instead of Ctrl-Alt)
-and if you use ``-ctrl-grab`` then the modifier is the right Ctrl key
-(instead of Ctrl-Alt):
+During the graphical emulation, you can use special key combinations from
+the following table to change modes. By default the modifier is Ctrl-Alt
+(used in the table below) which can be changed with ``-display`` suboption
+``mod=`` where appropriate. For example, ``-display sdl,
+grab-mod=lshift-lctrl-lalt`` changes the modifier key to Ctrl-Alt-Shift,
+while ``-display sdl,grab-mod=rctrl`` changes it to the right Ctrl key.
 
 Ctrl-Alt-f
    Toggle full screen
-- 
2.39.2


