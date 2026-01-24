Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888C9D715F2
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Jan 2026 18:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjiOE-0004PY-Ox; Sat, 24 Jan 2026 13:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vjiOB-0004Ng-9d
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 13:29:39 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vjiO9-0003iE-FN
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 13:29:39 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-82307c6902eso1413414b3a.3
 for <qemu-devel@nongnu.org>; Sat, 24 Jan 2026 10:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769279376; x=1769884176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aNCaHCsdw3z4/LRHE0WKFQG90phZxLcR78DnNdx9Xiw=;
 b=i1mqdXt3VpdNCYDBjwrpi3q4cVCoD86TK07YLgoDGeaBJ66n0Asxz9EgVFdyIk/Da3
 u6M/65EoAbUtBG6Af+h6degxYQanmPyA1BME/I755ozfczk1wh++Sqgxg1/6d49VrocE
 XeBFOBt3/q9wdB7BZQG+j17XmibXbsocbtYRDD/whp0R8efVjaNietRiDMUBfDUbt0n2
 Hq6BPEr1+rrGmSFKWpcMjYqSILtCk0qNMTr5gHIvbhAgNQKa/6cidXJ6r7LIp7zEIzZj
 +0tTxTz920IQ24uNmsKyEbCIfEQM+Ut+HS2NG9fDwdYhv9GTk2CJc+dyLIqQveSymsh6
 ojxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769279376; x=1769884176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aNCaHCsdw3z4/LRHE0WKFQG90phZxLcR78DnNdx9Xiw=;
 b=QXhaqu9Cun3d+GatdbaqM2tAhcDlSNxyI/puZE04R5yPv+t1tQOPsJrOgbyq9QS6OB
 kbE7DWbyfBmRL3fgSiBFDCzmh0VQGsX7NJypYunNeaSOoI9vbHGVjN5jYLwlgebpu4O9
 WcnHqdypv2zIMqwin/IZN8TsAInozSVsXxsrl+0727GUqZbHtESrHgcE5e/8YVkyHdxf
 uWInrAG4fwg3bN8Ghzmofxji/ZVCPIA/e1k4VdMlF5UqB/6q1EdVxGJddA9tasvUgjKj
 RHMD3es4Ns1IcIZ/vn4FMGTvbAFFULwwXHh9VK93Cf+flSxD5zfdnYjIYL1fXxSUWLjJ
 uClg==
X-Gm-Message-State: AOJu0YyGoZPglMa0ATIl2afAYhtuKiZb1SucWuYpZeCsEAqcOLLq9qLt
 EXiYdZDAveOgPhSRSnTy9BD0p58FOCKbwxQ1AzovKJnaQBOIl6ZQrW9HgzdPQSjowTLTBPy4T9C
 1C8bhVXA=
X-Gm-Gg: AZuq6aIw8wAV7Gw/ISwN+f66SCyRUAnwJCYK7i4nTsCYvd3cQXUu2jWKrd5nB4KaXJv
 amRxPXP4GQ31qHTHNhBIFIGUIj4gS8yFhVkPZ3CQUCPxPlOlLmtY8zdDbvstrpSsDxUbwg+OJxj
 m31dMJpcRjFUROuVxsOHDXH+/AsxUrgZS2zwh7hx+/U5pW/5BhnkznChH9RhwNPFcst1fsJFLxS
 Lut66mzyJWYYc6yXtGpmVJXXCpMp0H9QsHpnPX1fn/o1skmsiu+wpS56xxwxwXbaZG37hHzNoy5
 PSo4y+Xtl+iNRKX4KQlXFbB/avMLmEYZgKvNcdYcu5J4wO+JP3pRlUfjd79o027E2auDWg4XQyV
 DmASWswHfJhIVXVlVrcZJ7jb+1bAwVwC4eYs91Mw246QZEYXp0RvWeiIdZBOcuzNAXgoV1HiQAE
 eVZOhOXASKZcgYhQDptZtZy9+C8eXlBfIShdzwRfzflFnQ5fkTdTj0jYPl5VueKiQi
X-Received: by 2002:a05:6a00:806:b0:81f:8084:7ea0 with SMTP id
 d2e1a72fcca58-82321575ffemr4262163b3a.7.1769279376017; 
 Sat, 24 Jan 2026 10:29:36 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8231871d432sm5296485b3a.42.2026.01.24.10.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Jan 2026 10:29:35 -0800 (PST)
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
Subject: [PATCH v4 07/11] meson: fix supported compiler arguments in other
 languages than C
Date: Sat, 24 Jan 2026 10:29:17 -0800
Message-ID: <20260124182921.531562-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260124182921.531562-1-pierrick.bouvier@linaro.org>
References: <20260124182921.531562-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/meson.build b/meson.build
index 514d48eee72..c96776bb746 100644
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


