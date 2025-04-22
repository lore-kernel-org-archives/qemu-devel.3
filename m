Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA30C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 17:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7HHx-00082F-5e; Tue, 22 Apr 2025 13:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7HHu-00081P-3U
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:20:02 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7HHr-0005cN-Th
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:20:01 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-39ee5ac4321so5850793f8f.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 10:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745342397; x=1745947197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xNKLj4D/gE4uh7HIOOJVJs77DuL5s6j/qlx9j1pTj+s=;
 b=P6R0fzFLubvs3q2WF/Q+mbhT4vdrUrzhQYpEOYnR0NgqIcK5xPxwWohKPp6nIWDPz+
 x6GdUfsneNXmHTykfcej1oy1wLYoCTRdGCHFFO7xUWubME4dGQk3LGRgAd2Vr/tVyXhK
 zYNprKWe7rhZWeghxBPs50bE2Ack/pX/kJ5IQ5S7hqpxfYsQqeZ0TrO8cOzSUfNecafG
 9AJ96znc63CzM1hUpIzMo2ch4Ek7EVCUr47PO+UKO29HHvJY7oW6Q4cOLVRUhimsbV6n
 MrbIxUr0vqycjzlfRt8Efpg/X3g7Dv/yLlwec7vwe8o31KDZqtUFZdTi840gsQrofSyV
 HDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745342397; x=1745947197;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xNKLj4D/gE4uh7HIOOJVJs77DuL5s6j/qlx9j1pTj+s=;
 b=abVydH1LFnQ2TI6ISdTZ/f7hOFXssmFB9UG2Of0LLF16XGhEBrVh37MIgt/srANbke
 U1dRt2YUk76RRtK2LgwdvtgpYbUY7iL70eLGC+Rbtudl3oZf3ZvLowiQakR0bjbhIGEG
 F/nCiYxfVEUOusosKWsE8x/1LkAzSslyvT0oljbIQfcL7uUjE3VNQ81y1ukIojVEFruU
 iJU7wN+j8GW+QAKZsEbD3er/QtIl9YZDa9dDjCrJyYxq8VpHIncpzM+LXo4lh5/ETqVI
 n2//RgUN5lnp6oY5akVoj8BgnI9crhxbZW9K+rm8vy37PNIKowjsr21QCU9kC8Jy3cqG
 xGqg==
X-Gm-Message-State: AOJu0YyPaJOXxhFUlLnV3M9FqDsXcldiS4n9/JnYFF875CNmJ0VThCot
 j5awUOWIuG7qWmQ9r58IgmMQY4PVrVTW4+87cbTvjaJq3Mo35Sr3czKB4Qs9FoqOLcbmDBXbhOL
 8
X-Gm-Gg: ASbGnctc6Ok85XnjZ6aF5Mc5Hkk54gt6SGAU1l2dSPSjQsNRrlfpYBnCfMgt1XELfCW
 IN+3MURD5AvejDqZAU/2wcdpi980g3U3CAWAMwiFFC1KhiUUEDmWM+t0F+zmHhwbIbgybeF0C5p
 4PfUbhyfA4R2HLz1gtsGyzgBRLSY4pU5BalIpnjBMteuAsZ7QrJYAt7TGPAeG8z5QkWFYB6xm2v
 Ig9UKsQZhGU2GWfO2r7GenTVyxNU0bnyk847GzlVC7A/mr0sWZJ2T85r4EHYi6bKhtctHSIAB0L
 2okvQWDnKQHzd8Uxr0O3Pvza2Ax8xfiNGTief1oP+jLQmWYlMuHE5CpPzDyLpppoSpcYfslxuC/
 dFbG5cDw7AX0zT4E=
X-Google-Smtp-Source: AGHT+IFuOHwjLyD1O62W/6sDhxunTt23ThlwfHs351PkMU+xQ1O0GrvkfmXvRyUd+O1HM9u6Mubelg==
X-Received: by 2002:a05:6000:2483:b0:391:241d:a13e with SMTP id
 ffacd0b85a97d-39efbaf6c45mr12230559f8f.48.1745342397379; 
 Tue, 22 Apr 2025 10:19:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa493207sm15940721f8f.79.2025.04.22.10.19.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Apr 2025 10:19:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH] buildsys: Disable 'unguarded-availability-new' warnings
Date: Tue, 22 Apr 2025 19:19:55 +0200
Message-ID: <20250422171955.11791-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

When using Visual Studio Code (v1.99.3) and Apple clangd v17.0.0
I get:

  In file included from ../../qapi/string-output-visitor.c:14:
  qemu/include/qemu/cutils.h:144:12: error: 'strchrnul' is only available on macOS 15.4 or newer [-Werror,-Wunguarded-availability-new]
    144 |     return strchrnul(s, c);
        |            ^~~~~~~~~
  /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/_string.h:198:9: note: 'strchrnul' has been marked as being introduced in macOS 15.4 here, but the deployment target is macOS 15.0.0
    198 |         strchrnul(const char *__s, int __c);
        |         ^
  qemu/include/qemu/cutils.h:144:12: note: enclose 'strchrnul' in a __builtin_available check to silence this warning
    144 |     return strchrnul(s, c);
        |            ^~~~~~~~~
  1 error generated.

Disable this -Wunguarded-availability-new warning as a
short term band-aid fix.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/meson.build b/meson.build
index 41f68d38069..539368f82b1 100644
--- a/meson.build
+++ b/meson.build
@@ -735,6 +735,7 @@ warn_flags = [
   '-Wstrict-prototypes',
   '-Wtype-limits',
   '-Wundef',
+  '-Wunguarded-availability',
   '-Wvla',
   '-Wwrite-strings',
 
@@ -747,6 +748,7 @@ warn_flags = [
   '-Wno-string-plus-int',
   '-Wno-tautological-type-limit-compare',
   '-Wno-typedef-redefinition',
+  '-Wno-unguarded-availability-new',
 ]
 
 if host_os != 'darwin'
-- 
2.47.1


