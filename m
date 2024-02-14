Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC0AC48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 14:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raFs1-0003kS-J1; Wed, 14 Feb 2024 09:04:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1raFrz-0003ju-Fn
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 09:04:15 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1raFru-0007A2-Kq
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 09:04:15 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e10614c276so840815b3a.3
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 06:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707919449; x=1708524249;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x7o0f+2eBhpAdnxYl6dNF6Xpyr2tIU7JtYT+MKb4Z9w=;
 b=o+o7IFG5CJ7q4yWAVbuIVSXLkwuWOIF83fS/DqGGjddCg4/D8hO+NIyBj1xg/c2K1y
 O7YZ8yBEeN7YRt2zjUNO7GUYJKJYI7Lql+qX+6dw7C25wAi/q1dyw6IxlNh3AUM7hqSJ
 FnkRBsN6sPRNeUlUJGBtn0oDGDZwc9z/o4FZqBwJRQJYAm1JEhtz2/B0fqt4sWe9ofno
 TdPWyhwR0yt/V8+QivP6rgGvKq0msZEN88b0O+fMgLgowECWQiaiwCjVqvjxy4K4+k2k
 Rb9JQdunTM2TopkWjz4zUQ3fxxTzhpY58CAsOD83TMaYmdsUzhHHWq0JwGKXr120n6EV
 Ppjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707919449; x=1708524249;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x7o0f+2eBhpAdnxYl6dNF6Xpyr2tIU7JtYT+MKb4Z9w=;
 b=jV4DdOx61N18y2mefJghIr5/Nge9J70+p7qquRP2SwTl0QNQxoIpRj9SEvOZzh5hzo
 tW8bglWrrr68qQBmMsL8i4/A5j2rPf5+Hy5wOmLN9Dazz9l0GqBHtrjnY1iAU5+IGgrU
 6O/lQd8bQLxpFsFuwCZ6bWsUMGyolITVCZCqPfOCIn2DE7nyoj7l0+QHlMCjfm2/TpEX
 SxJouN35cZ6xWNFybnAoqBYJhOjHsX3+6SXq70h4uOIPPuOs6MYLmLF5+9zQq7LmG8+J
 1WRv3OqVdTHx0Hl/+xSs/IqCE1wlOE8t8SxzTnT7+vKKtaL0loi2R9S302/6M+0GQZUV
 6xPQ==
X-Gm-Message-State: AOJu0YyI+D93m5KnBQ6dYVCgOWdax5o8XyFDWspw9SZ2BzHP39aF1ezj
 eznPEKBaxgKcc8D/mcB6Xo6Vbbshqd0KKDVOOczAZWC/pbOBd5TU66MqLy1YyNk=
X-Google-Smtp-Source: AGHT+IEo4TCr/qznm2dPEcpdwHt9CbdGzju2djIP074ZiNg18OFvueQg4sUP3ALIL4u/O2Itlnpscg==
X-Received: by 2002:a05:6a00:a01:b0:6e0:3f77:ddcd with SMTP id
 p1-20020a056a000a0100b006e03f77ddcdmr2651955pfh.25.1707919448966; 
 Wed, 14 Feb 2024 06:04:08 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWxUILAcQkO9eF7FLOv6o5N2ILDbQ8h46CioWEuiD8nRTkQxy6WqmzEGCT8CNoMM7fjIJg00wjE1adKG7hMIzuauXPbmWIdzpZ49OPSuNYLL0VXXFeHw4JLj/zBKnxiob71gVRpmV2+6pkHRS1FX7KcLdMY3q7idxLK8SqziwdSy/KwgSp4foNwDk4xuIxkJSS5R7tu9gLXFuzjFO7jLEybj/YWDhC3CtLkbLnN6xJxqNG8ZhcSeMkQNy96ariP
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 n25-20020aa78a59000000b006dd8a07696csm9315520pfa.106.2024.02.14.06.04.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Feb 2024 06:04:08 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 14 Feb 2024 23:03:56 +0900
Subject: [PATCH v7 1/3] audio: Depend on dbus_display1_dep
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240214-dbus-v7-1-7eff29f04c34@daynix.com>
References: <20240214-dbus-v7-0-7eff29f04c34@daynix.com>
In-Reply-To: <20240214-dbus-v7-0-7eff29f04c34@daynix.com>
To: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::42e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

dbusaudio needs dbus_display1_dep.

Fixes: 739362d4205c ("audio: add "dbus" audio backend")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/audio/meson.build b/audio/meson.build
index c8f658611f42..608f35e6af78 100644
--- a/audio/meson.build
+++ b/audio/meson.build
@@ -30,7 +30,8 @@ endforeach
 
 if dbus_display
     module_ss = ss.source_set()
-    module_ss.add(when: [gio, pixman], if_true: files('dbusaudio.c'))
+    module_ss.add(when: [gio, dbus_display1_dep, pixman],
+                  if_true: files('dbusaudio.c'))
     audio_modules += {'dbus': module_ss}
 endif
 

-- 
2.43.0


