Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D010E68952
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 04:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MQp-0003lK-RT; Thu, 31 Oct 2024 00:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6MQg-0003dU-RU
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:05:03 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6MQf-0004q1-2s
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:05:02 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2e56750bb0dso381466a91.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 21:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730347500; x=1730952300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fv7fP7ICWyfxL2x/CP9SZRa4THtQuAFnXp8RQEnngd8=;
 b=BJCL8X/lA4a8SS5Y57Zp/+YXEwlvrqdmuWrdCnynK/ZZYsZlzh6AT46FZ0uqSuPW+G
 EyvItsTlhYQh+NVMLBQvhba8byYj2l4n+nPx68wshcVBiw0tCMoGwi0tQEo+jr+9bRux
 oncAjkv5yKI+kt02BosphueN8+chuYdH1yZC/jqRyTDYzCwsr3fqEZY/TYYukncktwPW
 XVMbouGinVUsuWx/Phs0s1YZGVzpy2iR/y51+ZakxH3WWDJhZEE/FI1e5W2QdoiSftcL
 gtqFLaDxi4HUYdyIZHryVzMTZ3H/E9TneUWNRGXZTUlrP+l1rdXgKMyAIQo/3YBZjFMy
 Dumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730347500; x=1730952300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fv7fP7ICWyfxL2x/CP9SZRa4THtQuAFnXp8RQEnngd8=;
 b=mbUkjh0zPXkzYmhfqPiamKEaqtxujvN0TQ6HDBay5CgSMW1O9s1wt5IoXWqwVcNMo2
 mne7XdA8OPfvHZrssZ1/miDwGSsh/tNtVGnnRVl7qzBx8I7juhMC+y7UnXE/M7GxA6+A
 6z8xEtwKiTxA3IHKySf8jHkg6jjbCh47pFiauGCkEdH3ErcBoLCaqIhvkZFVhp2nN7Pz
 lxWVdi5FGCubXwQRfIzNTl/AG8vDV4/MQ9440cw1kxN9Ee2KAN9WUTDLAd7AL677hSKF
 dRDKgYQ3bWmqn5d01FFQlO3tJaVtPx+RUgAteuABIjHvkfcLN/piTudtTePtUVM/rWyo
 /4XA==
X-Gm-Message-State: AOJu0YwSzh0NVegB27GfedA01GE6+GGf758zIt72ctffIgOJY4gK2ZEj
 eN7xRowLM4v2hSSf4UQZtREJsIqPHzZgSnldHf0ms5uaFfYNukJ0A/rbhUaqIWW4yOofkIENfOS
 fwVSOLg==
X-Google-Smtp-Source: AGHT+IFpQxDk8p2VP4nriXIupYuXJBOVQI3fMflZN8u0ftZ0x8kXb92WWWiHWfBfhK898FPlWB2tsw==
X-Received: by 2002:a17:90b:2741:b0:2e2:b64e:f506 with SMTP id
 98e67ed59e1d1-2e8f105b461mr21551918a91.13.1730347499654; 
 Wed, 30 Oct 2024 21:04:59 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e93db3a023sm428438a91.49.2024.10.30.21.04.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 21:04:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 03/12] meson: build contrib/plugins with meson
Date: Wed, 30 Oct 2024 21:04:17 -0700
Message-Id: <20241031040426.772604-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
References: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
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

Tried to unify this meson.build with tests/tcg/plugins/meson.build but
the resulting modules are not output in the right directory.

Originally proposed by Anton Kochkov, thank you!

Solves: https://gitlab.com/qemu-project/qemu/-/issues/1710
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build                 |  4 ++++
 contrib/plugins/meson.build | 28 ++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 contrib/plugins/meson.build

diff --git a/meson.build b/meson.build
index f7d45175212..d8af08299e0 100644
--- a/meson.build
+++ b/meson.build
@@ -3684,6 +3684,10 @@ subdir('accel')
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
index 00000000000..63a32c2b4f0
--- /dev/null
+++ b/contrib/plugins/meson.build
@@ -0,0 +1,28 @@
+contrib_plugins = ['bbv', 'cache', 'cflow', 'drcov', 'execlog', 'hotblocks',
+                   'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger']
+if host_os != 'windows'
+  # lockstep uses socket.h
+  contrib_plugins += 'lockstep'
+endif
+
+t = []
+if get_option('plugins')
+  foreach i : contrib_plugins
+    if host_os == 'windows'
+      t += shared_module(i, files(i + '.c') + 'win32_linker.c',
+                        include_directories: '../../include/qemu',
+                        link_depends: [win32_qemu_plugin_api_lib],
+                        link_args: ['-Lplugins', '-lqemu_plugin_api'],
+                        dependencies: glib)
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
2.39.5


