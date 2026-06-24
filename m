Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF9ACDB470
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcFoZ-0007YN-9e; Wed, 24 Jun 2026 01:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFoP-0007Ap-H1; Wed, 24 Jun 2026 01:06:09 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFoN-0005di-Sa; Wed, 24 Jun 2026 01:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782277476; bh=ylRD3FLvc+MwoHh+YbAD+GRu9KzjAXC6DydIi10G1Rk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=qmyYmg/tlH9O0eZMVAg7yfWug4vb/wyZ9AZnWxCsrmzFp7goO+A1pj4xx1fPuXkQI
 CBDD9m1BpfhlcuZRNCblskZSy9eMjKXZjFegDtsaPTYLUqogl59qJI5i1m2J6pK2bm
 AYf8TRlr9Nuqf4DIY4o5FwEhiSwFq7CuxmZBaF5eK1HlQras9IPJdJ3oC4+IK1gQLF
 CgEvWVMHg+C557RzoHeI+FDgAgYIse9NDuRYu7o4yTWKfLuXIsQoVG/gx4emC8R01L
 4vtLLfS3siVH11K8Cx2BINvW9uwltWbwvHW93D79vsbvdfhCwz4dNEDXrGJssAf6x/
 /iGa0tjnqasMw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AB0401BA646;
 Wed, 24 Jun 2026 08:04:36 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 92E833DDACE;
 Wed, 24 Jun 2026 08:04:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ryan Zhang <ryan.zhang@nxp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.11 80/86] ui/sdl2: Set GL ES profile before creating
 initial GL context
Date: Wed, 24 Jun 2026 08:02:51 +0300
Message-ID: <20260624050404.394225-24-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.11-20260624080222@cover.tls.msk.ru>
References: <qemu-stable-10.0.11-20260624080222@cover.tls.msk.ru>
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
index b00e421f7f..c798654c99 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -109,6 +109,8 @@ void sdl2_window_create(struct sdl2_console *scon)
 
         if (scon->opts->gl == DISPLAY_GL_MODE_ES) {
             driver = "opengles2";
+            SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK,
+                                SDL_GL_CONTEXT_PROFILE_ES);
         }
 
         SDL_SetHint(SDL_HINT_RENDER_DRIVER, driver);
-- 
2.47.3


