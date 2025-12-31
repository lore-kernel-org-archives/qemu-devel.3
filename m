Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B451AEE57D7
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 07:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaqiq-0007aH-TC; Wed, 31 Dec 2025 02:34:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaqip-0007Vj-6B
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 02:34:19 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaqin-0001BG-Jm
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 02:34:18 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7b9387df58cso17030852b3a.3
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 23:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767166456; x=1767771256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hEuXeMxUY2fbqtX5Go3U2puCz5D9qPiuyxDQLIxHFpQ=;
 b=PnkcJakcg+P5yNF1yvmCLMpN0z/ZGiZKAGO8KDldMpX3l1z48InF7wfuV85tQ1/IpO
 vbv+ijyAYww3FaEBV17hwyahdSY1k98HizdhQu+DBe+hrOb9dNIQAZZuSyoyJZm21jJI
 ayvUXDHdMPB9FGEvIWXhlAfuCyalGGJkgfyfMOfuId6G1S8z2ELs2AmL8JAtV/Xv2XY3
 5+Nzpan7Y+eG4ZI67gM8OWu8uvIQqVUJRqWZQeuCMJ6y0EaGnWS1fQ0bRHsdmK1mhvJo
 aG0BVlWSr/x20fLH4alWJ29wkMkN0oYAqCKoYBgJROfKooFOrlqqLDz3TCuISyOSNG2a
 Ig7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767166456; x=1767771256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hEuXeMxUY2fbqtX5Go3U2puCz5D9qPiuyxDQLIxHFpQ=;
 b=VJ9w/pLtJUsHPlxSjBLDgTfZPrsOI6yWf+IyWY1YPtMdM9ZCPP4rhDpkKCYvte7Gfc
 85DEt4BhkDb3RDNX9ZSxxlAuOCXBWAJQjUVOoQFivgbkNsy5GumeLFAi5e8OR5Y+y3SM
 OfI56y6bQ1tXG0KT/4JhSmOrrUkeKDIOpIBqX1QKIIe9ncDETrMwRoqDVcZCPnuTwKj+
 Kn7WWV79mt98892fqiFR8JG6zQbkLGBXI/JN3IrqklnDXAC7SsIthMzsx1QjJl3XEtRH
 HuE2QngZ77VliJiTYKWm+s/sgPssdqsmL8TEVsFOeAZhVtKnpC9e/2RJGWSAqg/a8+lH
 H4Ig==
X-Gm-Message-State: AOJu0YyJoDl5FvFDyzSdKaqJpMDojU6eFjbrX1qRYqiB1iv8eVPCDDIl
 0M3/cL2yvuyDUJIshXAT3/rvkgO1M1bT/uv0NuthpJE4wwX4QPYWKmjU/lVhbeqr8LaG86AqT6W
 1yJ6x
X-Gm-Gg: AY/fxX7vIBBQUsWoXWIPkU/yYEDbTB+/NkMHx9/ZaDaTICNYItu8H1mKIepzVBvvwyG
 Yxr0HL09g4R6IOepS0HS9zGhsoIeGlNCJYNxE5hZ7usCSnNeZBraS95+r/E11NiUte1xUL866Gh
 fxbJ36Rg+9NlJblQeb6lntcTBXWduTbJ3LGM9lOTotT67AJCXShcQm1ZD09dhW/MMj/ONgP6KdH
 M8yq7ixWnAhSXGMRMxY77+vDoVo7G5tkbihuTWh5F05hZ308RLnK2DGSDrepmTOKfas3QvDFa9T
 IYq7tCVFzEpQUUu3j5f5dK5rv2Vg8VlMt1WpWALd5T4L0EniZpVlkgmCHjVf02C9KTYWuP5BVAx
 +ms6Xw7qatKcGslnhFgkUtCOZcqrxWNDQBlW594NoHvqlYkiw0INmxg/wizLHugDYvqA/dAsucw
 qOlZmprrt5N8hh0fTpDOxFJ4MMYv7EvHI+sf+ysb5xeYSipPUfPjMvW642u6++spRd
X-Google-Smtp-Source: AGHT+IGWX0PMjQd/uxeRh+Bar4NH23zZG2vHB6LbYnvIJPdCnBjHAHaa1DWfa+mTO0ciW5O3AbUG7w==
X-Received: by 2002:a05:6a00:bc90:b0:7e8:450c:61ad with SMTP id
 d2e1a72fcca58-7ff67063905mr33870211b3a.68.1767166456291; 
 Tue, 30 Dec 2025 23:34:16 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e48f3d7sm34597984b3a.51.2025.12.30.23.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 23:34:15 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 07/11] meson: fix supported compiler arguments in other
 languages than C
Date: Tue, 30 Dec 2025 23:33:57 -0800
Message-ID: <20251231073401.2097765-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251231073401.2097765-1-pierrick.bouvier@linaro.org>
References: <20251231073401.2097765-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/meson.build b/meson.build
index 3d6c6c702d0..c7042413f20 100644
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


