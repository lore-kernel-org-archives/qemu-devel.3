Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C5AC52D7D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 23:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seNY8-0001to-Jm; Wed, 14 Aug 2024 19:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seNY7-0001p8-D1
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 19:37:03 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seNY5-0006Wa-PL
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 19:37:03 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-710bdddb95cso243734b3a.3
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 16:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723678620; x=1724283420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6xxCvfMwAVvNf1Qjn5/JJVvbogoK1VhpQom3xuwjm28=;
 b=aiQWDBY6zf8f1lj7oc9D7HtAADOZBVFGBccCyPqKtc+1BOlfwk++OO4SoDNC8NJr4B
 qwNAoT/qeqWHHrOysJwV+A40oMgbQ0EHTKGmHy0sIDOynHUws1e7+MQeq901lfUy1Mzs
 oiURi0WKVHYkErEenCH/8bRx8DQb5YRsU3wBBlY+LAnAgXIjQB8crsedJJ8AqtmXnhf1
 HxJnnq6Ei6V8wIq29qZaeosok+ZWmBiPTih1VosHFfjWsAIoodST/5moYFAc5bj10A1l
 v/KRiUBBsQX6i5aUoyiI66/ZWQ04IlYYwA80Qz0lIandR5YhTClnyGEkdzr7PHu6ijVe
 y4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723678620; x=1724283420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6xxCvfMwAVvNf1Qjn5/JJVvbogoK1VhpQom3xuwjm28=;
 b=aVQ9ld/3zI15o0MbWpr991vQP/+OMe+PbQPRABH6qokz8p6cPZjg/beDavBHrASUoB
 Hx76TrrDIMPDxwGuQftnr+86QBA07a8qEnGd8lPoKLij6di3i+hM9YNsNiOP5LK9yu5O
 tlLpwwL/wSswGWOdwmx/gcW0tOLbzKIfR5v2IwmbQK1ZwV+Al0FpUsT5naOEhAuYYpVu
 EQSkqPr4ZMigwBqScfnKiWnz4hFm9YEV57Y5xR9xPiBSUv7/SYR4R6Ngzc6nERfOyg+F
 8eM/+/W5p/FV42w8MnWCFRGCzBHGEzSjC5ToUicqNhKsnKLafvDGrF8oOIaNwDGiGlcn
 HeyA==
X-Gm-Message-State: AOJu0YxLUHk4vqBwMCSUc0O5xsp1MF/9LnQxkyH3TsjEUSLqKc7M0/VP
 6M1+RLKWcimvvDQvE0Sg0BfmNw4cuQ/mc6JUMMiVBvJsHc4yhHFMF5NgqaqA4InuKnlUTYe45Ad
 UFBw=
X-Google-Smtp-Source: AGHT+IEB++ca/kEhIM7Xhy6J0p9gyqcx9Z6lEU++DwNjIjAiRgGm0xyZ4Sb71DVMzfeye7LSxlhT0A==
X-Received: by 2002:a05:6a20:d49b:b0:1c6:b364:dbd1 with SMTP id
 adf61e73a8af0-1c8eae6f450mr6196973637.19.1723678620260; 
 Wed, 14 Aug 2024 16:37:00 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127aef57dfsm112164b3a.115.2024.08.14.16.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 16:36:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/6] meson: build contrib/plugins with meson
Date: Wed, 14 Aug 2024 16:36:44 -0700
Message-Id: <20240814233645.944327-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
References: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Tried to unify this meson.build with tests/tcg/plugins/meson.build but
the resulting modules are not output in the right directory.

Originally proposed by Anton Kochkov, thank you!

Solves: https://gitlab.com/qemu-project/qemu/-/issues/1710
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build                 |  4 ++++
 contrib/plugins/meson.build | 23 +++++++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 contrib/plugins/meson.build

diff --git a/meson.build b/meson.build
index 52e5aa95cc0..4efe1e782ba 100644
--- a/meson.build
+++ b/meson.build
@@ -3627,6 +3627,10 @@ subdir('accel')
 subdir('plugins')
 subdir('ebpf')
 
+if 'CONFIG_TCG' in config_all_accel
+  subdir('contrib/plugins')
+endif
+
 common_user_inc = []
 
 subdir('common-user')
diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
new file mode 100644
index 00000000000..a0e026d25e2
--- /dev/null
+++ b/contrib/plugins/meson.build
@@ -0,0 +1,23 @@
+t = []
+if get_option('plugins')
+  foreach i : ['cache', 'drcov', 'execlog', 'hotblocks', 'hotpages', 'howvec',
+               'hwprofile', 'ips', 'lockstep', 'stoptrigger']
+    if host_os == 'windows'
+      t += shared_module(i, files(i + '.c') + 'win32_linker.c',
+                        include_directories: '../../include/qemu',
+                        link_depends: [win32_qemu_plugin_api_lib],
+                        link_args: ['-Lplugins', '-lqemu_plugin_api'],
+                        dependencies: glib)
+
+    else
+      t += shared_module(i, files(i + '.c'),
+                        include_directories: '../../include/qemu',
+                        dependencies: glib)
+    endif
+  endforeach
+endif
+if t.length() > 0
+  alias_target('contrib-plugins', t)
+else
+  run_target('contrib-plugins', command: find_program('true'))
+endif
-- 
2.39.2


