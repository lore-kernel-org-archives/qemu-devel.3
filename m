Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805C6EF9008
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxpR4-0003tS-0A; Wed, 04 Mar 2026 11:50:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxpQz-0003qF-Lc
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:50:53 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxpQx-0002Q0-MQ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:50:53 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-65faaa8b807so3594670a12.3
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 08:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772643049; x=1773247849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+kubWz9KDgycCqkZClTxhaq/ye7WarZSE8+MZWS4vpo=;
 b=iUSIXFMfE5ZLFMU3kTXxNmi5r2iO8obG/tHKwRIuI+O7Mp8W3LWDtdVIASe29O+I1T
 h4+RcPZgsX4aVUSkuDuC1s08ElqW9Wv7QsqjS4i8wlgZ5tBlf7vX6UqaNRzDQ5ThwnAc
 6dLQzU4HHfSQwY+NzNgdd4XMBGs6Qrl28nE/t1wWIPORgGMYjF0uUG+KP/F/sYXKTSox
 0AXMjmepL6K0S4XzLI6Zfqr/F8PmwXSs2VuJAGvMOk0wFFBtNPFq/YDP8CJ8bhzhRleb
 GGWsMfFGq40qFDMHdR/g4kH4JeeZJT7rT9GGRZv4gVagCg//r+3iw2hxjiUjLLr3SZdN
 reeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772643049; x=1773247849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+kubWz9KDgycCqkZClTxhaq/ye7WarZSE8+MZWS4vpo=;
 b=GgpylXNGstZTAM0gzCrBitDZGcJnTYe0agc89H8pAzUoXJAn6fFD0VDm1jZZWBhEnG
 zEQ937BU8TPp8HddX4Bwzdwom1U78nVyNzFmIywjcBZjnlAzLTeUKHi88sSrPsLfAfKA
 05T0x/u3OP8PIrCpqUjMr9Xpu64TqHl5S5amfq+teG921WfdUxfjE8gGOLJssJC18Rdw
 NnSFac0l6OLD6zdbG0oNDAvSSx0HIku6pNNxpagV8SIHfZHNE4BRvHKivI6fG95V6aed
 eQ92d895UyiN5c1FKmos4wBMmmxwGTFNLTmO7ELsmRP8lQTzNpKxuHqKO7Mooy0tJqCg
 KX3Q==
X-Gm-Message-State: AOJu0YzZhzxSIsY0DpilqFyRXy80Bt38Yfm412/d7xIEmIhuOI/+R6jG
 K+NBmzBTzLrYhi7BGpWkzRR36Iy/zq7vXbkTDlv7vCnWL8uD5QJdXKQIvfMYNw4G4UA=
X-Gm-Gg: ATEYQzymrz97nB64FDhDjC+8UEve0IBnhJUcmxp3zivv+hpEx5NWnbDx8rV1E3HaC4r
 IsAhEdrz6eiFX2fQo6S47FVWUrNMpu2sOg7xJPaQX8r1eXAs+ityboGvBcNslEUfLVR9C1fIboc
 45PhA0ONQxQvgVAo/6nP8U49JGwZXwwwYfeKbZaEZib0gk6c2KGQ2EwId1b0FIFqSLT1cTbR7HM
 xNxXabBOX47lBApv16Fg+mmnojmN5GIiFXcbVmXEZQfJB398iJaNC070LSY6RWOVghQ2898zHKr
 AL5+Cbi4l2K42xATSM3BSOdCAJyCyD8PxGqzjkVjJbqCARHtzSfvSe7xDb35t+XCNILwuPE7dgk
 qlN2cunpKbg7H+mfOgcZNrYIeadbFctu1XU5YZT/6MgG3GMIORJoybIBiOWL9e8mXogyH2OUEFh
 WilfaB1Bjt4M9K7XiwikzPliw=
X-Received: by 2002:a05:6402:27cd:b0:65f:8271:3f7a with SMTP id
 4fb4d7f45d1cf-660efcac9e1mr1509478a12.16.1772643049273; 
 Wed, 04 Mar 2026 08:50:49 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65fabd4695bsm5941315a12.12.2026.03.04.08.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 08:50:47 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 163DD6016A;
 Wed, 04 Mar 2026 16:50:44 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Yiwei Zhang <zzyiwei@gmail.com>
Subject: [PATCH 04/20] ui/sdl2: Don't disable scanout when display is refreshed
Date: Wed,  4 Mar 2026 16:50:26 +0000
Message-ID: <20260304165043.1437519-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304165043.1437519-1-alex.bennee@linaro.org>
References: <20260304165043.1437519-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Display refreshment is invoked by a timer and it erroneously disables
the active scanout if it happens to be invoked after scanout has been
enabled. This offending scanout-disable race condition with a timer
can be easily hit when Qemu runs with a disabled vsync by using SDL or
GTK displays (with vblank_mode=0 for GTK). Refreshment of display's
content shouldn't disable the active display. Fix it by keeping the
scanout's state unchanged when display is redrawn.

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Yiwei Zhang <zzyiwei@gmail.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-ID: <20260303151422.977399-3-dmitry.osipenko@collabora.com>
---
 ui/sdl2-gl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index 3be17d1079a..5eca0248233 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -51,7 +51,6 @@ static void sdl2_gl_render_surface(struct sdl2_console *scon)
     int ww, wh;
 
     SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
-    sdl2_set_scanout_mode(scon, false);
 
     SDL_GetWindowSize(scon->real_window, &ww, &wh);
     surface_gl_setup_viewport(scon->gls, scon->surface, ww, wh);
-- 
2.47.3


