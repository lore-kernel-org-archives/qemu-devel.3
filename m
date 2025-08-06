Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE193C87FD3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 17:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujhZR-0002ZG-Rk; Wed, 06 Aug 2025 13:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ujgPT-0007Is-UJ
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 11:50:39 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ujgPS-00037t-9y
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 11:50:35 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-24022261323so11860255ad.1
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 08:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754495433; x=1755100233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0jQ+A2B4/31X3g/xelQjAlNcCLkEAfdCCEhDs8zkIhU=;
 b=lI/PRlGJM5ORunZcYCuGSnT2VAapwUKs1rrN7tOEWTQopEOFaV1ZwbfpLiv3sg+Xm8
 Tv3L9B0kjA0kCi8qENnNN87MBAFd/edaHfMrDoKF1dR4PBPsaaRA2dxRR7bP6Iu/wo66
 2hMM+8G6/iS6gMF3uyG1ujSx5IqRUIcwmZb8rIaNvw6nGYXwofXX8ix8j+vtu4imeczD
 eHPos8nDVLkvrQDLJWmvWybbhH8SUOODunZ2ha4kHSbvH/BRlNGRRV6Owzq0NCkONHqQ
 +G2P0Q4+Uh6XE4+Wfzvogx1Qril/J849mM3nv5EPObMIIa6fg/Pou8AVmEU63+HfGkXh
 Pgnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754495433; x=1755100233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0jQ+A2B4/31X3g/xelQjAlNcCLkEAfdCCEhDs8zkIhU=;
 b=NMfkuFH5vPs5mVAlf17I6j2CqbQ/9OpZrP1DN0rVtjbXtpkY+k9WLOlmbPtccUuwKq
 VxmjlE7sRcErid6QKhcgodVuEUOW8njfWHEWf+7fmYMdM/cvCoENAUK9lK76JVGd7+is
 11WdsOfmkEVMmXBm8Zb0H8a6UGAnSWIVg5s53Cki6ZYD7bm/Q7F6tVJ03obeqi2OWSVB
 i8ugw5v5EnUPa8KHCLE0Vh/scK9pY8CovDy07BL7DIE3i9w7G4SpELFBxr3joMKy/vJs
 lvg36N4KJy/4cM9UeYgFrI15QBbTMX6A3nwWxsC+EdvXu/3lD/3Uf6b44/uoizmtN2yP
 s6pw==
X-Gm-Message-State: AOJu0Yy1PsmAp6hIYJGF3j64AQHdnyc0uTXXwZvvHq1gjEQDVBgv++e0
 Yj8QNqtEKBUHhXYzBe89b9HopefNnb8e/JviIIFoi1OOQ89lQaaypQBOlepssg==
X-Gm-Gg: ASbGncux0tkwX+KNMGKProtyGkwsxCcOVF4RbORgrC0DSqQJFKu46h5dLhdEQDysZ9g
 3g0CPjMQ34ofLVuRPhWEAeLx3aLkJbkaK6lYjvLi0tgVNmdejtk/jhlGNyidehhTrcggljOypeE
 D1Xbzcyg2iFSIADbVNeFCnll1gm0u1LAFOlpMJ3aujobxvZxg4De4Pl2kaVesX9wijyUVTHdLU8
 xqjITw+VuwjFcpczR8uOHdIGoXm/9OCJOFeWrRuhWK6TIdjXbqUAjuSmhUVrppJkj2o5yZ0vCDT
 52T7C1GziiYSlpJi0rRS+uAOnJoKKNPRA9QveMO3qVAlXiWlbvbfnl8OFaVka6WTQqZIxYrBpni
 ROWWOQtq85a/vWT2wnY4tFtXVFRROJiq3
X-Google-Smtp-Source: AGHT+IHdpja8+IelLL2/3wg0X3v9sNx1NDvFbS3W0Agk2ElfjDlbsptB7U3qxYfze07FWXXM1W/1tA==
X-Received: by 2002:a17:902:f68f:b0:23f:75d1:3691 with SMTP id
 d9443c01a7336-242b06b35b9mr551645ad.15.1754495432777; 
 Wed, 06 Aug 2025 08:50:32 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:4cca:cbdb:3f01:1165])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8976a3asm163374575ad.87.2025.08.06.08.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 08:50:32 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH v2 2/4] configure: Enable to propagate -sMEMORY64 flag to
 Emscripten
Date: Thu,  7 Aug 2025 00:49:49 +0900
Message-ID: <112b6882f9bd370deffb8637116fc44e043c250f.1754494089.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1754494089.git.ktokunaga.mail@gmail.com>
References: <cover.1754494089.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Currently there are some engines that don't support wasm64 (e.g. unsupported
on Safari[1]). To mitigate this issue, the configure script allows the user
to use Emscripten's compatibility feature, "-sMEMORY64=2" flag[2].

Emscripten's "-sMEMORY64=2" flag still enables 64bit pointers in C code. But
this flag lowers the output binary into wasm32, with limiting the maximum
memory size to 4GB. So QEMU can run on wasm32 engines.

[1] https://webassembly.org/features/
[2] https://emscripten.org/docs/tools_reference/settings_reference.html#memory64

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 configure | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

V2:
- Changed --wasm64-memory64 flag to --wasm64-32bit-address-limit to avoid
  exposing the -sMEMORY64 value directly to the users. This can be
  considered as a significant change from the previous version of this patch
  so the Reviewed-by tag has been removed.
- Added a link to the Emscripten documentation about -sMEMORY64 in the
  configure script.

diff --git a/configure b/configure
index 7f3893a42f..0587577da9 100755
--- a/configure
+++ b/configure
@@ -182,6 +182,10 @@ EXTRA_CXXFLAGS=""
 EXTRA_OBJCFLAGS=""
 EXTRA_LDFLAGS=""
 
+# The value is propagated to Emscripten's "-sMEMORY64" flag.
+# https://emscripten.org/docs/tools_reference/settings_reference.html#memory64
+wasm64_memory64=1
+
 # Default value for a variable defining feature "foo".
 #  * foo="no"  feature will only be used if --enable-foo arg is given
 #  * foo=""    feature will be searched for, and if found, will be used
@@ -239,6 +243,8 @@ for opt do
   ;;
   --without-default-features) default_feature="no"
   ;;
+  --wasm64-32bit-address-limit) wasm64_memory64="2"
+  ;;
   esac
 done
 
@@ -537,7 +543,7 @@ case "$cpu" in
     CPU_CFLAGS="-m32"
     ;;
   wasm64)
-    CPU_CFLAGS="-m64 -sMEMORY64=1"
+    CPU_CFLAGS="-m64 -sMEMORY64=$wasm64_memory64"
     ;;
 esac
 
@@ -795,6 +801,8 @@ for opt do
   ;;
   --disable-rust) rust=disabled
   ;;
+  --wasm64-32bit-address-limit)
+  ;;
   # everything else has the same name in configure and meson
   --*) meson_option_parse "$opt" "$optarg"
   ;;
@@ -920,6 +928,8 @@ Advanced options (experts only):
   --disable-containers     don't use containers for cross-building
   --container-engine=TYPE  which container engine to use [$container_engine]
   --gdb=GDB-path           gdb to use for gdbstub tests [$gdb_bin]
+  --wasm64-32bit-address-limit Restrict wasm64 address space to 32-bit (default
+                               is to use the whole 64-bit range).
 EOF
   meson_options_help
 cat << EOF
-- 
2.43.0


