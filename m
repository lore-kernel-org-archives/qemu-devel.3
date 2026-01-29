Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4F2D73E80
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 17:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlVyV-0004tI-7K; Thu, 29 Jan 2026 12:38:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyT-0004rX-D3
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:33 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyR-0000gG-LD
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:33 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-8230c33f477so618450b3a.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 09:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769708310; x=1770313110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v5uxG/Q2SM3Aouk+ewwF3GM6TTHW2fcEuokwAO/vUYM=;
 b=COUJekAy5TfQAwThLw/6bSpuKYNYOsbocJcpp0FPfZbwGHVlShFPESkJOD3IxikHB3
 VesF5fxvpiN7XN2l0M2FiQ/i88qkdp0eY05ynjIKR2UEqJGr9E60uSqEhUgyedctbPys
 qig5vjtf5zIi2rHybHunXzRjebA9TPxGdcLXuDlCKs5l/SBpcCN/ij9/mpPLkE/EsQ7p
 4xFuQeZtL0vSpK3Rcud93DeGesk5PogrjO4Yb/xhQk+YXNwkPBpOe7lfMIr/e+npgE67
 4PfUNqyr0oOnSeIY4HJFVtHmRi2XvO0p2BBc3viHbNFL7OVb8M/XqTeX+5oAsNbd+wKe
 q9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769708310; x=1770313110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v5uxG/Q2SM3Aouk+ewwF3GM6TTHW2fcEuokwAO/vUYM=;
 b=b8OL0VoF2vJ6augO+4789ghQHHfXdASAswz6daIHjb+xV7cmAOSADQ4642Outh0KcK
 sSCtD8xf9EsttwmFggNSyI9Go6M0AZ7xPGXpD2ZsqKIpYaqD6sb1rqk2LtjXkwJPvbBU
 8Ae0+6e3ELM5WIGyr2eIs/uDjr9tEAP6eOAnGmWPCjFgjJH7qfFiI+FI1TDTZpIDpX8a
 sgClr6o/1kwJ0qZdTiZIU/iYK1Nc/SlEZ+l8R5SUkqhvg8Vk5dV5sqnz9urxjZPv/PhL
 47hgHBXrkzj5QaBtd6QZayyvWuX+scH7j0wvTvcMuLAMtsZlizgwARbF8EXzdon1MNzi
 3ZMg==
X-Gm-Message-State: AOJu0Yxm4rFLromcR2ArnMDUO79KSTgTpvybFNnTcZkdgTypFNlCYcoX
 qlr15LkCVhcdSMY8MZBYHMwvaxV065VCLSYuYvD3yyQWbTH9QPtFb5kMP5YQOTVgSrdUYItEqWp
 QnpWQ
X-Gm-Gg: AZuq6aJNb+NgmYmKYxyea5zXkxVPmiSx6bxmub/l/I+kDXU43+tm2L+AZvLyIWsvImy
 4QgT7mWk4Za3kSjkB4MKUyuqrV/9Vo8T/7mMUjmBSGyQ2Zpz04flkqNy9vVkPAZ03HopDDnMyen
 1tWMToUiioK5Xm3jMJ3CCI4rEEcPPqO29XRIGrx4E1hA1KAmIaLXVjxG1bnC3e+tPDl7OtuZSH7
 V+SFFh1WJb9fGyDyhi6TmULe7vJ4lPdPwY8VsIPbu8GGHSotm8CAR72Xu1wRVbtr9KFjNVsQxcM
 sjecjXS/bXDbHyWcSgGg9bMXevtebEvPeRxfhJd2bDw+1aUYqq6bYZ1UeCbGKvK+M5I/CvNY9cl
 jF2Q2fjxUWhpIbKyAFX20IRQkwUZ0Ce712GdW6qk9ehUZzIzUZcBwCV7yQW8LG4fYNOxfjQeVbv
 xOMb4LVEuJ3yfZSsR0F3n3dJ/pU6Mr14MTG/aV9oZnv4pCJyq5FUTPWU0psajSjEjL
X-Received: by 2002:a05:6a00:7607:b0:821:8569:7f19 with SMTP id
 d2e1a72fcca58-823692ee7bemr7265995b3a.59.1769708310300; 
 Thu, 29 Jan 2026 09:38:30 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379b222f1sm6706246b3a.7.2026.01.29.09.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 09:38:29 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 16/21] meson: fix supported compiler arguments in other
 languages than C
Date: Thu, 29 Jan 2026 09:38:02 -0800
Message-ID: <20260129173811.138036-17-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
References: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

qemu_common_flags are only checked for c compiler, even though they
are applied to c++ and objc. This is a problem when C compiler is gcc,
and C++ compiler is clang, creating a possible mismatch.

One concrete example is option -fzero-call-used-regs=used-gpr with
ubuntu2204 container, which is supported by gcc, but not by clang, thus
leading to a failure when compiling a C++ TCG plugin.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260124182921.531562-8-pierrick.bouvier@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/meson.build b/meson.build
index 23252afc7d0..ad8550d9e97 100644
--- a/meson.build
+++ b/meson.build
@@ -682,10 +682,7 @@ if cc.compiles('extern struct { void (*cb)(void); } s; void f(void) { s.cb(); }'
     hardening_flags += '-fzero-call-used-regs=used-gpr'
 endif
 
-qemu_common_flags += cc.get_supported_arguments(hardening_flags)
-
-add_global_arguments(qemu_common_flags, native: false, language: all_languages)
-add_global_link_arguments(qemu_ldflags, native: false, language: all_languages)
+qemu_common_flags += hardening_flags
 
 # Collect warning flags we want to set, sorted alphabetically
 warn_flags = [
@@ -744,15 +741,19 @@ if 'cpp' in all_languages
   qemu_cxxflags = ['-D__STDC_LIMIT_MACROS', '-D__STDC_CONSTANT_MACROS', '-D__STDC_FORMAT_MACROS'] + qemu_cflags
 endif
 
-add_project_arguments(qemu_cflags, native: false, language: 'c')
-add_project_arguments(cc.get_supported_arguments(warn_flags), native: false, language: 'c')
+add_project_arguments(cc.get_supported_arguments(qemu_common_flags + qemu_cflags + warn_flags),
+                      native: false, language: 'c')
+add_global_link_arguments(qemu_ldflags, native: false, language: all_languages)
+
 if 'cpp' in all_languages
-  add_project_arguments(qemu_cxxflags, native: false, language: 'cpp')
+  add_project_arguments(cxx.get_supported_arguments(qemu_common_flags + qemu_cxxflags),
+                        native: false, language: 'cpp')
   add_project_arguments(cxx.get_supported_arguments(warn_flags), native: false, language: 'cpp')
 endif
 if 'objc' in all_languages
   # Note sanitizer flags are not applied to Objective-C sources!
-  add_project_arguments(objc.get_supported_arguments(warn_flags), native: false, language: 'objc')
+  add_project_arguments(objc.get_supported_arguments(qemu_common_flags + warn_flags),
+                        native: false, language: 'objc')
 endif
 if host_os == 'linux'
   add_project_arguments('-isystem', meson.current_source_dir() / 'linux-headers',
-- 
2.47.3


