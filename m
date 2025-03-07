Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F07D2C28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZUK-0000G0-J6; Fri, 07 Mar 2025 10:19:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tqZRq-00060u-Ac
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:17:16 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tqZRn-0005Nv-Gp
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:17:12 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ac1f5157c90so315028866b.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 07:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741360630; x=1741965430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+CTcpzuaeeEyMegjx5gxK5aEnSLYS7kDzIlZT2t/FUE=;
 b=xJ0Un8UKGeOgIdPEHMKHnwO0dMO420QAnmBo75or9A4PSPziY3WzOS+cW2LHp0pHs+
 ZcwFyAiXU5qXOgRxgpElXpEuaKPadNMKDpVVAvruB9Vg8VIvBuUFE5ESa9h8OWkLRFxP
 OziYJ5Ux+U/kKGF8sSbZhpMhR6KhDAA0VwmB/Qirfgxq43O7DYd7u3494ie2uG1RWMwW
 Y9yNH5cXCjBSmWRVGP6gdJ4qeoVvMSzOPpCz5BDG1o8IGjId2aZJXtiVRDZZxg1+qZgh
 0bGmNbpjKsWg0JxGj6FcNFqHj/u2iVlMp5tczDSPOHbJNDY0W7EqLck3KvzLAvPcwrMe
 dptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741360630; x=1741965430;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+CTcpzuaeeEyMegjx5gxK5aEnSLYS7kDzIlZT2t/FUE=;
 b=e5mebz/9QOnufg6TGUHPle7QsO61Bafdag06Kg2x1MuqyND4b0NR0G5W4n21JUc94c
 z5kn06Smw3TnyKp9NrWMrCJBfbnVYLuKevu+RrGuxNAZzGXfVRKWL1qdqFqYOpEDQNql
 +q3PJkgOwMRJdC44legCtlPNd8hYJu5RJEAptRbQBhpeDUZXZNLjhseu5QDVM8+IZs/+
 AstIPu8hf0Gvsdpu/YI0IH8oAM5//CblH1SjT7PdaALBVDchj989IEsx9aR+YDbTKP3x
 8Txzn/oRGVgwf+dMEXN2SWq2l1gqiGBBeDcIRShjhUG7Oi5jGCQANac6fc6SPqwc1acd
 6T7A==
X-Gm-Message-State: AOJu0YxhKTG1MQQXFkmOuhGZ//jeeuRHWVRPwMgYTXTPwRLrdf8PvH7e
 nfjbVdaTA1YiHxp4zfzs1kOUoaNAdFK8q+M52cgg4z0FHOlAWdo+oZiWDehsLmo=
X-Gm-Gg: ASbGncui0ZIsAR0+5HiJaGAP2RXKExZSE4MBRZw3zzT540NxkwkTVBg/STsAMhCO/0H
 1kocH7fGgsf8wSb/P9nfs1u1NUvNafIVNI7ur7UXTp/LpPKt/S22S8Va4bdV4GGnmIKpyFcenW9
 vtLf3VtOjg7bYsWt+hHM2LvKCog7vrdtDJKUVzt4oFnWB2tnsWhvsgH3J8tSqSWWXecxojUa59n
 tx7d/LahrRvscOxr0VbbrDrnltxTfsKWGxLQCFC+r7qxNKcZwI5k/55DvO39L0WU52fIINHR6HH
 CInsN1vTYgUQasZW3g4ot9ZWX3B0480MplDMSsTSxx4LMRk=
X-Google-Smtp-Source: AGHT+IF/apRyZMulGi/fjoOa7+vlyGTwizuh0IIS4TnBmVpVxnwBKEEmhkmJKhT1OJ7vQ09lhqkwdA==
X-Received: by 2002:a17:907:5c1:b0:abf:4bde:51b1 with SMTP id
 a640c23a62f3a-ac252aadb09mr373486166b.21.1741360628265; 
 Fri, 07 Mar 2025 07:17:08 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac23988830csm288505666b.131.2025.03.07.07.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 07:17:07 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CA8625F90C;
 Fri,  7 Mar 2025 15:17:06 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4] meson.build: default to -gsplit-dwarf for debug info
Date: Fri,  7 Mar 2025 15:17:03 +0000
Message-Id: <20250307151703.2564073-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This option is supported by both gcc (since 4.7) and clang (since
7.0). Not only does this make the linkers job easier by reducing the
amount of ELF it needs to parse it also reduces the total build size
quite considerably. In my case a default build went from 5.8G to
3.9G (vs 1.9G for --disable-debug-info).

The --disable-split-debug option allows distros to keep all the info
together for ease of packaging.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

---
v1
  - add --disable/enable-split-debug
  - move to option_cflags
v2
  - removed unneeded []'s
  - fix stray whitespace
v3
  - set qemu_cflags instead of option_cflags
  - move up to the rest of the qemu_cflag setting code
  - update build size numbers with --disable-debug-info
v4
  - we don't need to pass -g, due to meson doing it under the hood
  - add comment around option_cflags to make mesons roll clear
---
 meson.build                   | 6 ++++++
 meson_options.txt             | 2 ++
 scripts/meson-buildoptions.sh | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/meson.build b/meson.build
index 8d0abe7f12..a8db76fccc 100644
--- a/meson.build
+++ b/meson.build
@@ -601,6 +601,10 @@ if get_option('tsan')
   qemu_ldflags = ['-fsanitize=thread'] + qemu_ldflags
 endif
 
+if get_option('debug') and get_option('split_debug')
+  qemu_cflags += '-gsplit-dwarf'
+endif
+
 # Detect support for PT_GNU_RELRO + DT_BIND_NOW.
 # The combination is known as "full relro", because .got.plt is read-only too.
 qemu_ldflags += cc.get_supported_link_arguments('-Wl,-z,relro', '-Wl,-z,now')
@@ -4589,6 +4593,8 @@ if have_rust
   summary_info += {'bindgen':         bindgen.full_path()}
   summary_info += {'bindgen version': bindgen.version()}
 endif
+# option_cflags is purely for the summary display, meson will pass
+# -g/-O options directly
 option_cflags = (get_option('debug') ? ['-g'] : [])
 if get_option('optimization') != 'plain'
   option_cflags += ['-O' + get_option('optimization')]
diff --git a/meson_options.txt b/meson_options.txt
index 59d973bca0..3432123fee 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -362,6 +362,8 @@ option('debug_mutex', type: 'boolean', value: false,
        description: 'mutex debugging support')
 option('debug_stack_usage', type: 'boolean', value: false,
        description: 'measure coroutine stack usage')
+option('split_debug', type: 'boolean', value: true,
+       description: 'split debug info from object files')
 option('qom_cast_debug', type: 'boolean', value: true,
        description: 'cast debugging support')
 option('slirp_smbd', type : 'feature', value : 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 3e8e00852b..aca6e68830 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -504,6 +504,8 @@ _meson_option_parse() {
     --disable-strict-rust-lints) printf "%s" -Dstrict_rust_lints=false ;;
     --enable-strip) printf "%s" -Dstrip=true ;;
     --disable-strip) printf "%s" -Dstrip=false ;;
+    --enable-split-debug) printf "%s" -Dsplit_debug=true ;;
+    --disable-split-debug) printf "%s" -Dsplit_debug=false ;;
     --sysconfdir=*) quote_sh "-Dsysconfdir=$2" ;;
     --enable-tcg) printf "%s" -Dtcg=enabled ;;
     --disable-tcg) printf "%s" -Dtcg=disabled ;;
-- 
2.39.5


