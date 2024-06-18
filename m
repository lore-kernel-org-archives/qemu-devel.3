Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B49C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbNG-0005Ho-To; Tue, 18 Jun 2024 12:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbNE-00052a-Nl
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:07:56 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbNC-000838-Vd
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:07:56 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4218314a6c7so47747695e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726873; x=1719331673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m05MQTWN136ywld4BWQZjNr1NDxuOKLdLbQOIjKC4nw=;
 b=K6zo6OshfOFlvMdyPKvZJ8SiszAugyMxK2BkjQN9fnFBXLMjftdocJekJWWuKciDZg
 w77AMMH0INptV2W+OZ5ncnWLQ/9kz3F8yM2QnF2vMZVESeSW97TP99AlGvpshPwz8Ci8
 02JlJEb1D9aBKrTi/cfbDZfX0m5k0hTuwz36F+FzOEJTCXiCxsxp9asDaZ6y7V/1DMbv
 91rStaqrKIukqjpmTh0VnSnkoZVPRZJZGlFKIAp/fTwuCBtdhmDsX29L5q6XQXZdGbK5
 AZWEZkV0alRIgN6sokFSIIGF/kO6YweOv7dWEsc6rLhaFJo8XZcJ1ylahkOfLHPuOCs6
 iBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726873; x=1719331673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m05MQTWN136ywld4BWQZjNr1NDxuOKLdLbQOIjKC4nw=;
 b=ZgxPof1y7hSB+StrfLWpp5JxB2i1ptFpsbywgBsCm/3tD02ZmUGG2kqXqrbQvePdLO
 Np3vLc1ReDS/GF8qeO/5/Em5cMMIsiiIU4kQ2RCeKsb4dCU9okVtqtCCp2PsdttdapWk
 WXr/Z/Q5FRfiO/Us3qtiv+Tfj8FQVpnDsZ9RFQlyDJqsAjvEvFd0a9abDKd1Mm1R4Jqp
 vClIGDu6LliP6mZ5Beq30E4aA9Rpkt6Vf9v6wi+Xs+BZYiDog/jcFKrcK0ItDA83+Kx0
 b5lztSpP/+gr6/qxDbJtx9hxmqzvPBf7O1gleySTt/I49+S7f40kyn1lWoGW0DD4hUU3
 ak7A==
X-Gm-Message-State: AOJu0YxCpmS4jcIG06qqYW5HGO97ucAc5rHvK91HZKrSOW+9mivbaO3x
 d5Z4IJH2X7rVoxGw77auuVHjSMmVXkk1/8Cg+o74R2SskDX/57cfwRMYHWMwdPO2M1v3BkHyKaX
 7
X-Google-Smtp-Source: AGHT+IE1FbWP1ePPyzm/b+3U+RlQjLx2ljZxwdkCqYhJQSZzvBJZDj+WiwDlH6cltfDSNbeOO+Secw==
X-Received: by 2002:a05:600c:4f84:b0:422:7037:54d7 with SMTP id
 5b1f17b1804b1-4230484fa59mr113319525e9.28.1718726872795; 
 Tue, 18 Jun 2024 09:07:52 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f641a5b4sm192298675e9.41.2024.06.18.09.07.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:07:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 75/76] ui+display: rename is_placeholder() ->
 surface_is_placeholder()
Date: Tue, 18 Jun 2024 18:00:37 +0200
Message-ID: <20240618160039.36108-76-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Gerd Hoffmann <kraxel@redhat.com>

No functional change.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240605131444.797896-3-kraxel@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/ui/surface.h | 2 +-
 ui/console.c         | 2 +-
 ui/sdl2-2d.c         | 2 +-
 ui/sdl2-gl.c         | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/ui/surface.h b/include/ui/surface.h
index 4244e0ca4a..273bb4769a 100644
--- a/include/ui/surface.h
+++ b/include/ui/surface.h
@@ -50,7 +50,7 @@ static inline int is_buffer_shared(DisplaySurface *surface)
     return !(surface->flags & QEMU_ALLOCATED_FLAG);
 }
 
-static inline int is_placeholder(DisplaySurface *surface)
+static inline int surface_is_placeholder(DisplaySurface *surface)
 {
     return surface->flags & QEMU_PLACEHOLDER_FLAG;
 }
diff --git a/ui/console.c b/ui/console.c
index 1b2cd0c736..c2173fc0b1 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1510,7 +1510,7 @@ void qemu_console_resize(QemuConsole *s, int width, int height)
     assert(QEMU_IS_GRAPHIC_CONSOLE(s));
 
     if ((s->scanout.kind != SCANOUT_SURFACE ||
-         (surface && !is_buffer_shared(surface) && !is_placeholder(surface))) &&
+         (surface && !is_buffer_shared(surface) && !surface_is_placeholder(surface))) &&
         qemu_console_get_width(s, -1) == width &&
         qemu_console_get_height(s, -1) == height) {
         return;
diff --git a/ui/sdl2-2d.c b/ui/sdl2-2d.c
index 06468cd493..73052383c2 100644
--- a/ui/sdl2-2d.c
+++ b/ui/sdl2-2d.c
@@ -72,7 +72,7 @@ void sdl2_2d_switch(DisplayChangeListener *dcl,
         scon->texture = NULL;
     }
 
-    if (is_placeholder(new_surface) && qemu_console_get_index(dcl->con)) {
+    if (surface_is_placeholder(new_surface) && qemu_console_get_index(dcl->con)) {
         sdl2_window_destroy(scon);
         return;
     }
diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index 28d796607c..91b7ee2419 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -89,7 +89,7 @@ void sdl2_gl_switch(DisplayChangeListener *dcl,
 
     scon->surface = new_surface;
 
-    if (is_placeholder(new_surface) && qemu_console_get_index(dcl->con)) {
+    if (surface_is_placeholder(new_surface) && qemu_console_get_index(dcl->con)) {
         qemu_gl_fini_shader(scon->gls);
         scon->gls = NULL;
         sdl2_window_destroy(scon);
-- 
2.41.0


