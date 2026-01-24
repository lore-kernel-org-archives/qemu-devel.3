Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7656BD715EF
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Jan 2026 18:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjiO7-0004LH-IH; Sat, 24 Jan 2026 13:29:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vjiO6-0004KY-2W
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 13:29:34 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vjiO4-0003d8-2f
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 13:29:33 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-82311f4070cso1284576b3a.0
 for <qemu-devel@nongnu.org>; Sat, 24 Jan 2026 10:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769279370; x=1769884170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rrBMb4pzsR09kFtei/WUANIUl/9qDP19I1CZ/cFKqvE=;
 b=Tp84lJ2r4PA96xQ93z3GAOY11PXe+axPN+EVsHm5DaniLbUvHpcvPI8WXhfaM9WqNT
 KmJds7F+DlzFV7Ubm3C9RZGuEVYooDDvgBU2GLO/yE0oiLU10Rm9fOXcTipWafFHdbVO
 ZbetSRl59hMu4LRTng7izoXhrSEoX3jSWJD/xQnIo7x+tCZNtIVQXsBm4l43bbFIeHtD
 rezja4lTvUv2rm3OaSvNd99J2XzM0oAdgIZ58t8Jv0J2AIvcEUO3aqAFg9VFzlFtOou/
 EbLTAS/sdCbjdf6Nd2AL+xCL0xe5ZKp+ictqh4iW2y3Gh+Ye2wc0tLW7IzXhUzQC6qbo
 lvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769279370; x=1769884170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rrBMb4pzsR09kFtei/WUANIUl/9qDP19I1CZ/cFKqvE=;
 b=haf77L6qXveGkA07QQ+ItfmIdmVnwAJzYxMXUBE3qc6Vulo1Bs+WvWPpIiVkrf+zwK
 FfAyMjvE2bHdCnNu5LBWiIHSiJJyvUvc4fAtzLuKAhvCzKyVbQdQbKa6rx/uS2VvkQ+/
 JdxXP9NTyPMj0TsIoYRsEjXhcA1nVFw9XnU+F/KVJNV7SIdeIG7KD70e+VfIvP8XnpNE
 Z1qRaokEabyIevYMDipmETHl0U4uJvdTAS5Jr4suHCHJYFgS2aL13x4GsQr4j3vNa0U4
 tWURR1ZFX8SjQJXE+WAYl2Dh3VG8HA6zg3rlf77o7h4S63aFn+NIWeeEEF39yhuoiGMb
 xBuA==
X-Gm-Message-State: AOJu0Yxg27ieAwg/B9I1aQKaBhNQVfqme9fUS2SWKduA4U6hsfurzBVZ
 sCmkJZCOuusec1O6wGHEIr4L8xx2NbWK1xRKAa9KkTb/povQgh1wn/UZcVJh/f69z1cg1hK87WE
 dqCB9EUw=
X-Gm-Gg: AZuq6aKSUurBMiBoOVIt05cO5bupSAVa0GigNPIZdsfbj5sm1Y1K7mdh6cpWvADxlKX
 I6G/e3X80uQJoUNhUthzHGXLez50XqCxO6LbykPz8BDhupunKCLs+SQ9aiognrLwlrDfed5DCLb
 6CBBTOki8yDy9cx5XdpF99ZxFH4tQzkkdsBakJAtKmf6sHL3xGn92omy8L3ZfvmZ2LOisFBj1qA
 oVWSnssc91Tl7XiUGb4ZSTZ2BFsplAJeUrjJQVFmPK1baXGfxw+IkONpNmYq9+kKmaJv8vUBkfN
 tPnhw/A4i23GoIiob1BzRvDEpSVKX38TBhvF/bVoEMhsB+CzhdUqFYB0S/hhSnn6bOTxcBA2jNB
 hyWcRD77THN+/KYrBdLm2uE18zq6N/K44ewvdIgdCMza/87HifVVWT0ed7cPGgRlHfqccj62nX9
 D+MAvm9sYTtz6ZKm/5ayNVeR9bgLNgUgzzmIGuinZc7pTBv9EJZSs3HuAg1qekBpr2
X-Received: by 2002:a05:6a00:4f8b:b0:7b8:acdd:23c3 with SMTP id
 d2e1a72fcca58-82197914069mr8911814b3a.11.1769279370334; 
 Sat, 24 Jan 2026 10:29:30 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8231871d432sm5296485b3a.42.2026.01.24.10.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Jan 2026 10:29:29 -0800 (PST)
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
Subject: [PATCH v4 01/11] plugins: move win32_linker.c file to plugins
 directory
Date: Sat, 24 Jan 2026 10:29:11 -0800
Message-ID: <20260124182921.531562-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260124182921.531562-1-pierrick.bouvier@linaro.org>
References: <20260124182921.531562-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 {contrib/plugins => plugins}/win32_linker.c | 0
 contrib/plugins/meson.build                 | 2 +-
 tests/tcg/plugins/meson.build               | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename {contrib/plugins => plugins}/win32_linker.c (100%)

diff --git a/contrib/plugins/win32_linker.c b/plugins/win32_linker.c
similarity index 100%
rename from contrib/plugins/win32_linker.c
rename to plugins/win32_linker.c
diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index eb944b5159a..6f72b2ce0c9 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -10,7 +10,7 @@ t = []
 if get_option('plugins')
   foreach i : contrib_plugins
     if host_os == 'windows'
-      t += shared_module(i, files(i + '.c') + 'win32_linker.c',
+      t += shared_module(i, files(i + '.c') + '../../plugins/win32_linker.c',
                         include_directories: '../../include/qemu',
                         link_depends: [win32_qemu_plugin_api_lib],
                         link_args: win32_qemu_plugin_api_link_flags,
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index 561584159eb..a6e78438510 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -2,7 +2,7 @@ t = []
 if get_option('plugins')
   foreach i : ['bb', 'discons', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall', 'patch']
     if host_os == 'windows'
-      t += shared_module(i, files(i + '.c') + '../../../contrib/plugins/win32_linker.c',
+      t += shared_module(i, files(i + '.c') + '../../../plugins/win32_linker.c',
                         include_directories: '../../../include/qemu',
                         link_depends: [win32_qemu_plugin_api_lib],
                         link_args: win32_qemu_plugin_api_link_flags,
-- 
2.47.3


