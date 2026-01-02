Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B264FA3755
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 21:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbn0m-0006ph-1L; Fri, 02 Jan 2026 16:48:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vbmzj-0006fy-Lt
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 16:47:44 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vbmzi-0000K1-3E
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 16:47:39 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-34c84ec3b6eso15883074a91.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 13:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767390457; x=1767995257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iqM7COsTdr9LPMsj9apOX/ZpJOoVf7y5fe5bZ4sfTUo=;
 b=NfYvG3dgSnD8gUuhvpO4cH0JA7m+8jvFO8YWWGuLMQOkfDoftBFJmJ/T0h491lO4JY
 +n6f1ZfrSYWQcqXXU6Y1yLqxN7sqWviwCpKNWp5sPtrjH1Ina2aK8sK+OXdQikDSk1bb
 yvEe5i64I6DNNh9Wdo0QBWkxfruZznLRdK43gXLzun1Cd5BZjm8vyV2APSjGusDvuBWD
 ZTsLUjdqiQZRn966aS0Foi7iEutx0fXMua1Ob7q4OaWYSbIlxHCMGR5vz8we98aL7+T6
 t9CA0mS6e2iJDKvBtxuo/BnNJBlw3uG9gQ+962a3EUc0XWLw6KFwnTgOcV97C7R3/bb1
 cGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767390457; x=1767995257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iqM7COsTdr9LPMsj9apOX/ZpJOoVf7y5fe5bZ4sfTUo=;
 b=I2r9VNrukdPTVERzzIVaR+QOnrT7tvAShXxQF8VqJa3GfKcpsBVNOzXfCyRpSIQ0OL
 5q0jdVECPVSMUwg6SopEKX6A/P5CYixnep0WNbPfs7VccqfaSBMD2A8/KQ+ZROZlAyF2
 Oy/5rzdy7aI+12d9y3ZKKg/FO1KcG3r/f5n43993VCKiXA0uFpq+m0QprODSw6rTmAxf
 pN4ldvAAvbangQfBJoR7bjdWItTqqoxZAAIxnQCtLNryM098Wp0/E93EdYi1lDRlN8bM
 f4iugD+95N67FqzOGxJdU0Ndld3twlAbaPQN/ohSKRCsfUETkvyNCuZnRTd9CBBhD/IX
 2Tgw==
X-Gm-Message-State: AOJu0YxHzBg7s+iXAUEYo8CXQ+oBAAGIsXCe7xfTD41bw/vHJO++83aI
 dLCcQyJztErcBXTGQMGDU7hECLXuDQ1FUqI94yaDehh0o3yXmZOnre2iOBHVIHTh+zTlW0U9UDP
 WGaXt
X-Gm-Gg: AY/fxX5Nr+zVGjnMMcfJ8zNUZpHO7WySJ8Zhe/ruluxTEfAzXH02TriSC/H+8Xcp0lP
 /cer5DC5ecjQvD+79q9T/k8g3oPd1L0xukbS92AU+b5ly6yiQsNFp0fr2iqyWP/7KVec+35e9KB
 uX6MaqKdGz59NXaVzHhVFDKmI+N2h8pV3GdC2ODn4wxPY+a8NE9/8q+xBkXAOYhvxKFy1lYGNR7
 l0rLYD3AxKIk74rF9DKUiKEE+QPAQQO3BMTIDV2qtr3lActn0oiJdtzzFRlViwujk/U0OSKs/ld
 fvYCYI7fWfpIk3uI0SaPTuyCKZ+GOxQ243WOf/Ru5puajyrOogIeM2Fh883L8/BQnzi5kaDgWoh
 O4Lbw7xPhuHxrVrZrcnwKuQu5oj9zQZRO1cDAlUXEe6iQOslbhrORaswR1D092q5m7CZa602MdS
 0zuoOS+8SxNZM6HGAZihxPFZiZplGpL6PLH0B6pjTULuOUfDzBBbdf257bdo6fQY58
X-Google-Smtp-Source: AGHT+IHLh5uFiks6muIKVCBWRwRd2b5oFAZ2RzmJlDBY5t7iHCRpstuafvejCJJqcN8F5Y+wH/Yvzw==
X-Received: by 2002:a17:90b:224a:b0:34c:99d6:175d with SMTP id
 98e67ed59e1d1-34e92122004mr31567075a91.2.1767390456736; 
 Fri, 02 Jan 2026 13:47:36 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f476f8f3fsm62925a91.5.2026.01.02.13.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 13:47:35 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 07/11] meson: fix supported compiler arguments in other
 languages than C
Date: Fri,  2 Jan 2026 13:47:20 -0800
Message-ID: <20260102214724.4128196-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
References: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1035.google.com
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

qemu_common_flags are only checked for c compiler, even though they
are applied to c++ and objc. This is a problem when C compiler is gcc,
and C++ compiler is clang, creating a possible mismatch.

One concrete example is option -fzero-call-used-regs=used-gpr with
ubuntu2204 container, which is supported by gcc, but not by clang, thus
leading to a failure when compiling a C++ TCG plugin.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/meson.build b/meson.build
index a8fd8e88225..256cc0cdb21 100644
--- a/meson.build
+++ b/meson.build
@@ -709,10 +709,7 @@ if cc.compiles('extern struct { void (*cb)(void); } s; void f(void) { s.cb(); }'
     hardening_flags += '-fzero-call-used-regs=used-gpr'
 endif
 
-qemu_common_flags += cc.get_supported_arguments(hardening_flags)
-
-add_global_arguments(qemu_common_flags, native: false, language: all_languages)
-add_global_link_arguments(qemu_ldflags, native: false, language: all_languages)
+qemu_common_flags += hardening_flags
 
 # Collect warning flags we want to set, sorted alphabetically
 warn_flags = [
@@ -771,15 +768,19 @@ if 'cpp' in all_languages
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


