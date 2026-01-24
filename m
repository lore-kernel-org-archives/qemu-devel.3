Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB487D715EE
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Jan 2026 18:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjiOD-0004PE-Lk; Sat, 24 Jan 2026 13:29:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vjiOC-0004OB-5u
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 13:29:40 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vjiOA-0003iV-Be
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 13:29:39 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c62239decbeso1144600a12.2
 for <qemu-devel@nongnu.org>; Sat, 24 Jan 2026 10:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769279377; x=1769884177; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pgN4lT+3Fn9OxJJ4Avwf4Qy3fV8Y6wNBbz/d+1i1a1E=;
 b=mHVeSdY7/70Gdyz7KcZyxN5WPtGGa2Y/3uMphJQY3QruT6X0cMFeCWQirRcPkauOO7
 s/jihWMdCavYLoKNs3nI/KPYgzm7yKKhahjmYj7Xd3AGXl68tFqtkvFjsMOKWWrAiG+O
 x1p8KOzarEj1He7b+q9++ehJRYxqTYdzk9yWTC7I7lVkum+bP0+FT+Bnzz86m4o0n+9c
 KIe4PCp1jkLIDM8RNZ5qvZ5GbdYEgucV3GFs8TmTltCR1XfxDf+uUmB0zylPPQFZQUGX
 wIUsxp5QdjGHdlKEQ4bC9Cg9QQ0KdxUmX5PITJZpq6PYQEnDo1zgN2Id3RpD/Po285eQ
 XCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769279377; x=1769884177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pgN4lT+3Fn9OxJJ4Avwf4Qy3fV8Y6wNBbz/d+1i1a1E=;
 b=AQD0rVBLjoJJfiCQWPwTSFplMQxn6KZRUfVFioxqr1tDKk+KL+b0/uovlQptPijcp/
 2A66VVoENdJtfeWcmxEyZbJO+jyuyAUw9ECfQ0IHqaPDa8Ag8aqvNR3jFgpUP0tQ8PmS
 TB44Fzk8id75mZcjYm+N1CN1uGyaPJg9i6tdQJnUPIaS/deJSyzvCcSvUt9ojIUBETsa
 xBTBqm8zFA+HUY9n26CGVvIg0EBucdeMGEUv20uY7OqwS1bd8Rrg0kmWR9Msiki18vjV
 DNkZpE+dKoaxPs3BuvRclQUnIcKn0dIjH3TNqcj4Dhlgc5AiyRDrglM3ZPbBf1gzeyUu
 2EJg==
X-Gm-Message-State: AOJu0Yx1RuUQLlTTffRzUeOZH9VnfI1Fu6Ej7I4hlX0cMP2eLujWB3fa
 oDEvZr5OtNhX/0cu01z2NzAwKx6dA2AwypuadkfGMKDSuIaFRcx8NTLhlfMe3R7UYRpf5lLe/5X
 7a8znqVE=
X-Gm-Gg: AZuq6aLjVvjpt/E03i+ikIENePeqqMCF0GbzsJqXDBiH/7y/hm7NVWFtHaHNRdB3oFz
 W7UNSHoXNzc2pP/aUaTaJJ8BPhC/oo4YO0HPGOCyt2nfigD2fgD1zL/HANni0iS4ai7SH6vVZX2
 t1Q5jwgi637ZWAAu9TyR3IyH9fLKJ/6uSfPJDfyfVsQGO27mcezBZ203niy/xYmGT+jUJX4NXwf
 8ApBEhRUl5RWccjYZJ+Hrv7EA3Df1c4dWTp3TobPNDbGAJzm7NOsaEcq8eIY3xheox7thWPmTU8
 giPYe8fY7Jr6Tws7a/xkawPVYH56jD+kQnJlg0PGD2+pwJy41IgxLmGKWzh7mzq9It7ISJE5DJu
 +VrIfJKbYchTpTU07mGycMrzOcnFqCjpMBXX1tSgGA5hBNQK03Y42ah5Zc4JzLC8RSEHv4OAfxO
 QPk0xicETXusPd7is67x5Pokq8Z2Kh5jf71JIQv1ssSqV7KWUJXEGZqW8tBIfmjKv3
X-Received: by 2002:a17:90b:54c8:b0:353:2e1:95f2 with SMTP id
 98e67ed59e1d1-35367010e20mr5785457a91.8.1769279376809; 
 Sat, 24 Jan 2026 10:29:36 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8231871d432sm5296485b3a.42.2026.01.24.10.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Jan 2026 10:29:36 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v4 08/11] meson: enable cpp (optionally) for plugins
Date: Sat, 24 Jan 2026 10:29:18 -0800
Message-ID: <20260124182921.531562-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260124182921.531562-1-pierrick.bouvier@linaro.org>
References: <20260124182921.531562-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index c96776bb746..d50f9b502f3 100644
--- a/meson.build
+++ b/meson.build
@@ -77,7 +77,8 @@ python = import('python').find_installation()
 
 cc = meson.get_compiler('c')
 all_languages = ['c']
-if host_os == 'windows' and add_languages('cpp', required: false, native: false)
+enable_cpp = host_os == 'windows' or get_option('plugins')
+if enable_cpp and add_languages('cpp', required: false, native: false)
   all_languages += ['cpp']
   cxx = meson.get_compiler('cpp')
 endif
-- 
2.47.3


