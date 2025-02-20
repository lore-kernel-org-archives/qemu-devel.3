Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53A3C021AD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 08:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl1Vt-0005lx-RX; Thu, 20 Feb 2025 03:02:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl1Vs-0005lo-Nf
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 03:02:29 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl1Vq-00050H-Q1
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 03:02:28 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-439a2780b44so3459995e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 00:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740038544; x=1740643344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FS7o0D5fLSCXS8ZwtnjjXhADHES9mreJS2p3qJ4gTp4=;
 b=S+1oOcltdGGsWtIJIc/OThBGblzDq0yFBqXST9Px6ekGUCkD13i6y01/l0ZoKc2dJY
 6B3m1hzH3LEIdjLP0gPLs7T31dWNRB4xpdyOkiq4Yos0Vi7e5cYtDok75nxAb2GS+/iT
 VXcBQ70z2qir1iHGpHQWwddeSIfwf/FSVRTfLUThDnE8qOfB6cL45fBDo8c/IeGqz8tt
 ymFvHoTMUpqgkZNf4lHNgaTtDdzmXBZcCJOvrS71nXqBm1IykBGgsJoBzrfJBENVetwg
 uGGcnzo4Z9hRBwPC53cuLkEmWXambMggvtL36GaqbwmbGq83Y05JesrpXbjqYNzYjfNu
 /XZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740038544; x=1740643344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FS7o0D5fLSCXS8ZwtnjjXhADHES9mreJS2p3qJ4gTp4=;
 b=GcuKFa4udI6HoDpo01glSdZqu9QJ6zsiScTyq4AgTwuh2HmXldDGVaGlmmja41iSya
 BeMZzUoTCNqiSEO1ecZjSTcI8psnJqHqqlRk3X/FHJAuZG23TZO7mFgc/mwnd4iQoMki
 5ugzHKsdC42ogYl3JJc26jVygjkzVHQXy3s9JAa62lHmYbkmPpaK871aEHE8N+pDeakQ
 zKCUiaOhNxVwoP7Yi9MwWv9CJWlQrZ8cS4ay5JM3Il0dZ3rS24l18XgdLXweP27RxKIk
 f+s0OV1ZGlTsv0DtduigL9Ypr94q/kc7LTpFd9sDdoFPVTA7qcB+s5hRorCK574joUEt
 JJDA==
X-Gm-Message-State: AOJu0Yz5NQbmSsPXYqsQj38rWKD1mU4U5FiKaNcEIRJmWqjk4VfBzvfi
 P9G9FlNT6JiBpfKfl2antxuAh8yKpFvv+WO4feX/EAAu3pAgWFRDH56ILwF1kanpGPOw11rJUVZ
 a2Cg=
X-Gm-Gg: ASbGncuc0JnewKzxdUgUbxk7rpVTlZ+H+OXgNqD+exbTKjuR+VnWvTpsL584/G3Wjw5
 QaIHuc4heu1hlfTm7bQoFWMpSgqi3Thwlwi8Qve8T3Q4uAsYeSoqlDq2iMjnh7ne39kTY6gwdDD
 6+/oA5nAhYCXlw0Dl89r1anA8pXL5COdjtJ8b5fGzqxybpudz85BHg6/+q4FyIeMoZwIv9CrkxN
 W/LtZhOWjA7+OoX9oNqkxPN2URFWY2rbZZ37Si5miIaOx59Fgd7i9+okgD/U2gjuXBYdH3WCytO
 2951n8/hAeq1E4FvcWYWHUc/T2Kd243IJQvgO5JhAJHpy5nBW5JcLzsJDV4b77c33Q==
X-Google-Smtp-Source: AGHT+IHue+mbCMrY9B4kzdkCP6NYsQ23UhHbSOD2mSDmA0XgRe5GA7szSsowdBXA7HkL/sB72Sk/kQ==
X-Received: by 2002:a05:600c:3501:b0:439:955d:7ad9 with SMTP id
 5b1f17b1804b1-43999da89c7mr70299325e9.14.1740038544102; 
 Thu, 20 Feb 2025 00:02:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439930a9966sm74391905e9.15.2025.02.20.00.02.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Feb 2025 00:02:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 1/3] plugins: add explicit dependency in functional tests
Date: Thu, 20 Feb 2025 09:02:13 +0100
Message-ID: <20250220080215.49165-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250220080215.49165-1-philmd@linaro.org>
References: <20250220080215.49165-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

./tests/functional/test_aarch64_tcg_plugins.py needs to have plugin
libinsn built. However, it's not listed as a dependency, so meson can't
know it needs to be built.

Thus, we keep track of all plugins, and add them as an explicit
dependency.

Fixes: 4c134d07b9e ("tests: add a new set of tests to exercise plugins")
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build                   | 1 +
 contrib/plugins/meson.build   | 2 ++
 tests/functional/meson.build  | 2 +-
 tests/tcg/plugins/meson.build | 2 ++
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 0ee79c664d3..4588bfd8642 100644
--- a/meson.build
+++ b/meson.build
@@ -3657,6 +3657,7 @@ qtest_module_ss = ss.source_set()
 
 modules = {}
 target_modules = {}
+plugin_modules = []
 hw_arch = {}
 target_arch = {}
 target_system_arch = {}
diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index 484b9a808c8..fa8a426c8b5 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -26,3 +26,5 @@ if t.length() > 0
 else
   run_target('contrib-plugins', command: find_program('true'))
 endif
+
+plugin_modules += t
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index b516d21cba1..2d41908c0a8 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -362,7 +362,7 @@ foreach speed : ['quick', 'thorough']
       # 'run_target' logic below & in Makefile.include
       test('func-' + testname,
            python,
-           depends: [test_deps, test_emulator, emulator_modules],
+           depends: [test_deps, test_emulator, emulator_modules, plugin_modules],
            env: test_env,
            args: [testpath],
            protocol: 'tap',
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index 87a17d67bd4..c8cb0626a6d 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -19,3 +19,5 @@ if t.length() > 0
 else
   run_target('test-plugins', command: find_program('true'))
 endif
+
+plugin_modules += t
-- 
2.47.1


