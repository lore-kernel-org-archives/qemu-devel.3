Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC45D715EF
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Jan 2026 18:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjiO9-0004M6-3D; Sat, 24 Jan 2026 13:29:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vjiO7-0004L6-0B
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 13:29:35 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vjiO5-0003gf-9S
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 13:29:34 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-81db1530173so1688458b3a.1
 for <qemu-devel@nongnu.org>; Sat, 24 Jan 2026 10:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769279372; x=1769884172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oLdDxoIHP5wtLXgh0saDARWvUU6NDRvHE/78rry/zWk=;
 b=hh9TBFbNLHP6tcsTeDodZstzqDUtaWnrsVrDrPo8uGtoLVErbw8uuPoSk38xPPFJhw
 IIt2sZAVxR+TowH2WyEQnWiXyMzWMGxEM0vuIjxLmH+Me5kgM2mB7TlmUlith5crAiw8
 xKbvVXHjY516F2AoSqW6GfMOTs4770R4pSoQ1ElFzWhuoFC0AIrO+QQJyMXfz9rSIZlI
 HgNvMc1Y4f19IS2xdOZHrC4N0AOCMDMZ2sJzWjaBs0nrUmMcSSZh1EqsGCQ9RG4qu59x
 s+ehZnlDNNuMq8SvoDeTRqAtOn4wxfJ0dJhexyqNQu0m3VCZ3n7WLe8PTt2oUqv1gTUP
 C6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769279372; x=1769884172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oLdDxoIHP5wtLXgh0saDARWvUU6NDRvHE/78rry/zWk=;
 b=lFlkhDPYHSkrQsjWvzWNTxNwkRuFh5DLJjyORbwKAtxd7EOW30/f+3rl9xI5xBSn/0
 HlShtY5tDHQi86JFbmHjFZBmET7YFobqqc8RRbAYU31koFYGf1TF2vIG6IeQKUCA2mKf
 1kFZUhs06okGCq1XdBG8RXqC+h/czK7pShMzv7jucaw0oQy/kSj+wHhROvLTrQlF0Fom
 GFhtpk6M+9o5Ir4kBEZ9GtAasB/e2Hh+uwKqtEdQfRazx8Danh/eoWrDFwXhYitAf4F+
 wuev7WTV7x43t/UHAAGZWa57vjS7qXomJPy3dJfBu5jrgYyDLxBadoGHb+8LdXXUojfs
 fAWA==
X-Gm-Message-State: AOJu0Yw4FUVm+oesyuHpxSoj+hbDgx3EsrLD0wgNBgMbBzCtaYxSHPzI
 KJ+DdETM3unFXdOYA//eJ5VijFOMQ6m8tTTUq3QEYDlVuecqQpqyvFioFf4qvxZSwH+dfg3R/HP
 ZFUjMbAU=
X-Gm-Gg: AZuq6aKBM/p6x8KRfnqHRVwsT0TamgSV+5edECVRIK4wYfDPrCv943GOdrOH3HIxxGd
 C1HpAhgto0euL21jq/DqkAQLiLl73ZrQUm0mxo+KM7BSmJ6yVjZhUGem5MOeLSkxi9k6YQArp21
 Bsnc7plCEGy7NzGydaI8dYXQi3pMeq8/gJlXVAQ9KU4lTEn+DeZ6+DjeS87G708OIqJmosTkq47
 coyiP9ctWqHvoKucbyFYR6zyo3juURWxh9YarMS9AmJot7+59CDU9D3VUGKKzwpX2cRxUumZ1sJ
 K8W9yvpopOfSJl2RcnrzSzocgYxLfi3PdX7y1D+58763NqJNujrN5gBWICtLpFtTc1l0YKFmVQa
 vsRQHXH987Gz/25+FH0jpnspQ1oVSHEAWSMcQaie2ME+jH7GQWfWlO7Qz5rYgpkOx9fM0SPo7Oz
 UqXNStw8BFKu9px1AzTYTzhlzyLq1rfxNFwNSWsIwGUyT8dN1OhEycWd94SZ18sKVr
X-Received: by 2002:a05:6a00:2381:b0:823:73d:1370 with SMTP id
 d2e1a72fcca58-82317d9d9e6mr5268026b3a.13.1769279371671; 
 Sat, 24 Jan 2026 10:29:31 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8231871d432sm5296485b3a.42.2026.01.24.10.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Jan 2026 10:29:31 -0800 (PST)
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
Subject: [PATCH v4 02/11] plugins: factorize plugin dependencies and library
 details
Date: Sat, 24 Jan 2026 10:29:12 -0800
Message-ID: <20260124182921.531562-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260124182921.531562-1-pierrick.bouvier@linaro.org>
References: <20260124182921.531562-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build                   |  2 +-
 contrib/plugins/meson.build   | 13 ++-----------
 plugins/meson.build           | 15 ++++++++++++++-
 tests/tcg/plugins/meson.build | 13 ++-----------
 4 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/meson.build b/meson.build
index a84f14258b0..e54fe9863eb 100644
--- a/meson.build
+++ b/meson.build
@@ -4450,7 +4450,7 @@ if get_option('plugins')
   if host_os == 'windows'
     # On windows, we want to deliver the qemu_plugin_api.lib file in the qemu installer,
     # so that plugin authors can compile against it.
-    install_data(win32_qemu_plugin_api_lib, install_dir: 'lib')
+    install_data(win32_qemu_plugin_api, install_dir: 'lib')
   endif
 endif
 
diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index 6f72b2ce0c9..6915ffa5fbc 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -9,17 +9,8 @@ endif
 t = []
 if get_option('plugins')
   foreach i : contrib_plugins
-    if host_os == 'windows'
-      t += shared_module(i, files(i + '.c') + '../../plugins/win32_linker.c',
-                        include_directories: '../../include/qemu',
-                        link_depends: [win32_qemu_plugin_api_lib],
-                        link_args: win32_qemu_plugin_api_link_flags,
-                        dependencies: glib)
-    else
-      t += shared_module(i, files(i + '.c'),
-                        include_directories: '../../include/qemu',
-                        dependencies: glib)
-    endif
+    t += shared_module(i, files(i + '.c'),
+                       dependencies: plugins_deps)
   endforeach
 endif
 if t.length() > 0
diff --git a/plugins/meson.build b/plugins/meson.build
index 62c991d87fc..4318e3a1671 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -51,11 +51,24 @@ if host_os == 'windows'
     dlltool_cmd = [dlltool, '--input-def', '@INPUT@',
                    '--output-delaylib', '@OUTPUT@', '--dllname', 'qemu.exe']
   endif
-  win32_qemu_plugin_api_lib = configure_file(
+  win32_qemu_plugin_api = configure_file(
     input: win32_plugin_def,
     output: 'libqemu_plugin_api.a',
     command: dlltool_cmd
   )
+  win32_qemu_plugin_api_lib = static_library('win32_qemu_plugin_api',
+                                             link_depends: win32_qemu_plugin_api)
+endif
+
+if host_os == 'windows'
+  plugins_deps = declare_dependency(sources: [files('win32_linker.c')],
+                                    include_directories: '../include/qemu',
+                                    link_with: win32_qemu_plugin_api_lib,
+                                    link_args: win32_qemu_plugin_api_link_flags,
+                                    dependencies: glib)
+else
+  plugins_deps = declare_dependency(include_directories: '../include/qemu',
+                                    dependencies: glib)
 endif
 
 user_ss.add(files('user.c', 'api-user.c'))
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index a6e78438510..d7823704616 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -1,17 +1,8 @@
 t = []
 if get_option('plugins')
   foreach i : ['bb', 'discons', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall', 'patch']
-    if host_os == 'windows'
-      t += shared_module(i, files(i + '.c') + '../../../plugins/win32_linker.c',
-                        include_directories: '../../../include/qemu',
-                        link_depends: [win32_qemu_plugin_api_lib],
-                        link_args: win32_qemu_plugin_api_link_flags,
-                        dependencies: glib)
-    else
-      t += shared_module(i, files(i + '.c'),
-                        include_directories: '../../../include/qemu',
-                        dependencies: glib)
-    endif
+    t += shared_module(i, files(i + '.c'),
+                       dependencies: plugins_deps)
   endforeach
 endif
 if t.length() > 0
-- 
2.47.3


