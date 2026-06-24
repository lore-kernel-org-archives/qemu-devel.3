Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A99CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNsz-0003Fg-En; Wed, 24 Jun 2026 09:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNsY-0002k7-VS; Wed, 24 Jun 2026 09:42:59 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNsX-00022L-Ar; Wed, 24 Jun 2026 09:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782308007; bh=iazvMrVmZE5ISJAL7v7sv9o2wPrqoCv21izsEMeF+OI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bxNUFsQldQSRhp7H4ont1OUDg5eVnGTP4la5WTAqItvdNOrk8QN9jL1NPAE/vfEtd
 m/pUGVQVs6vlfAbg071F3nVMce2gqteu2UCuX6HljQ38Ls+QJNQ/jLKJ93bvhrk8dF
 uTZOLOTyudDUchF6wdGrivcsLueBdd/wIXP6K7zZn1kWhSetQNLLTvzyOrIc3vwqLn
 U0XK8Y96Y8glN8Sb+ag8QKGReg4hJ+M8+SjDBYGSqybHrBQYxNz8RkXZqdZcx4t0e8
 nVva9FT4G6HyhQLvhVERC2hdo99CY+h9D/UzQFEenOCqn3rtIoBK+D1D5kULcWrB7F
 0IC3W7pCXQsvg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 195261BAA16;
 Wed, 24 Jun 2026 16:33:27 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id A7F213DEA65;
 Wed, 24 Jun 2026 16:33:32 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ryan Zhang <ryan.zhang@nxp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 100/107] ui/sdl2: Set GL ES profile before creating
 initial GL context
Date: Wed, 24 Jun 2026 16:31:45 +0300
Message-ID: <20260624133301.403266-100-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
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

From: Ryan Zhang <mailto>

When the user selects GLES via '-display sdl,gl=es', we need to set
SDL_GL_CONTEXT_PROFILE_MASK to SDL_GL_CONTEXT_PROFILE_ES before
calling SDL_GL_CreateContext(). This ensures SDL_GL_LoadLibrary()
loads the correct GLES driver instead of the desktop OpenGL driver.

Fix the below issue: qemu-system-aarch64: /usr/src/debug/libepoxy
/1.5.10/src/dispatch_common.c:872: epoxy_get_proc_address: Assertion
`0 && "Couldn't find current GLX or EGL context.\n"' failed.

sdl2_gl_create_context() already sets the profile mask correctly for
ES mode, but the initial context created in sdl2_window_create() is
missing the same treatment.

Fixes:da3f7a3ab9ea0091955b58f8909dfcee01f4043e ("ui/sdl: try to instantiate the matching opengl renderer")

Signed-off-by: ryan.zhang@nxp.com
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <DU2PR04MB9018BB3650BA218438C01F2A83042@DU2PR04MB9018.eurprd04.prod.outlook.com>
(cherry picked from commit 490a3e1867f025c68fa13db766b5c8da16c6eca4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 9dd5e305e1..eccc5b0e90 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -113,6 +113,8 @@ void sdl2_window_create(struct sdl2_console *scon)
 
         if (scon->opts->gl == DISPLAY_GL_MODE_ES) {
             driver = "opengles2";
+            SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK,
+                                SDL_GL_CONTEXT_PROFILE_ES);
         }
 
         SDL_SetHint(SDL_HINT_RENDER_DRIVER, driver);
-- 
2.47.3


