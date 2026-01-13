Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296A6D2D105
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 13:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vferT-0003F8-1f; Tue, 13 Jan 2026 08:55:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vferR-0003EN-1X
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 08:55:05 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vferP-0000RQ-Cz
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 08:55:04 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a137692691so50036985ad.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 05:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768312502; x=1768917302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KSK09h4xKjsISSidIbADfOirq0TnGihmtXpNzolifyA=;
 b=cytRlgf4f3q2P1syW8yjAgVk0PFeSrrjg+dur/UXw1smjjaLrkDgfx0M0Wit4Crocr
 HLK/3JrAJ6UJNjeyPQtEpn/U5TMnL5AbHOSfYvL87bdMZkXglIi+O/cUQ8sgYUGkMyBj
 M5kcgVCtO86kDpMgmnM2HgnSyRs8Ywtwe41A09YQTzY+XgC6l1BR8hUtHk+RzrXulmo3
 dG7nKX064+n0oInPVCXEqEhCWk2tbOtOoWmxhCQ2BRMY0WhHVKERlDg7eMaTk3SSqlfG
 TU9JN3+DkTw398QTmlA2cOH4WJ9lLXm/jLFrU9tf/OIx8uKVJODTYWrL1MJElDbvZt+P
 N8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768312502; x=1768917302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KSK09h4xKjsISSidIbADfOirq0TnGihmtXpNzolifyA=;
 b=p13ChpW/hLdjM09AH3R5SUtenSiNekCOMYBKGJqPpuPVketBePrMu+gJPwaodM3q0W
 Qd+TScvMZlB+rBf7v98l/RGa5YaoYoWCPgaz3G/DhEIgl0LpBdkYfvC8Xl+Wz2/Z2g5Y
 mdZuFYfK7AmRCgc/4dyO/XPLIqOxklK2hItXzMEhn36zzY0RjwfY3WVli/Cmp2MsUkVW
 OerKee/ijKsw2J9mVBtBlzU3RhqPjz7EsRWhMiL+sxSZ7rHx5MeIqKrlsxLYVTVMFo3A
 9/7zJzx1sEbymO2uUmpxryrxwxxx1mrSdMd4YnZVw1ntmgByznGACj9wQZMOlcC2eZID
 KWew==
X-Gm-Message-State: AOJu0YyJfTadhSq+mUGr+sNz0E7c0O+rWcvW4CE70nvmFfH4ZWsST0f8
 auuML/4EDzS3218HyrOZzbjrpInl9QiPIjm38CNjWdu/TSv6ovXigQ5+8qG/7Qp/
X-Gm-Gg: AY/fxX4M1wZM4ccJihN5siemaH9WHZMWw+Xqac8pMFTdj/rd9U1vDPflahVEPD54k8w
 n3IrYlpmkwDYPWBI9kRs/ScJoF2b1pRLTeZnEdjwFQV7UBRhcqF6D+6WDGggWdBf/nvABPwouL8
 /sx07gcoPk1TOH4k5aajfWPJMLZHO/5giNxljLASz3XRcNYRAIp5Cj5MDIvoro6ZFV2uxLA+zpY
 Kh4j/04Z7tMj5KcGnF5OfGDCVS4liNLMaOk7iC/qcObot2leXaaqWCG61W2FtAUYL9h8Gh26xCD
 tgOHsxkHLaO8hQVYm05IwvBrW8PgUcGcO17AW8jadW8fIIxCjCDX1hCjsgSkfSTtHUHjrVFdDRa
 lnpt9AxC+ibtNtL0TOryYFYtwIBTIiH9hKgMdUYoqeXbCk/tO3PwSZSubB3xXpb+75GFUUAvCJf
 9p2U7iNEw+ZA==
X-Google-Smtp-Source: AGHT+IFJ4xNyRvc45LnSLRhtPvJefl/YLACSGyGRmV7U2ClFrkkFuNQTxyRybRiVquiveKU/RSNkEQ==
X-Received: by 2002:a17:903:388e:b0:2a2:f0cd:4351 with SMTP id
 d9443c01a7336-2a3ee4e85f6mr187471985ad.37.1768312502089; 
 Tue, 13 Jan 2026 05:55:02 -0800 (PST)
Received: from ktock.. ([240d:1a:3b6:8b00:eb29:7536:a39f:7476])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3a2eesm38240465ad.6.2026.01.13.05.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 05:55:01 -0800 (PST)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 2/4] configure: Enable to propagate -sMEMORY64 flag to
 Emscripten
Date: Tue, 13 Jan 2026 22:54:29 +0900
Message-ID: <a2f068c7884a629fe3e4b297368d70b0956ab048.1768308374.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1768308374.git.ktokunaga.mail@gmail.com>
References: <cover.1768308374.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x631.google.com
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

Currently there are some engines that don't support wasm64 (e.g. unsupported
on Safari[1]). To mitigate this issue, the configure script allows the user
to use Emscripten's compatibility feature, "-sMEMORY64=2" flag[2].

Emscripten's "-sMEMORY64=2" flag still enables 64bit pointers in C code. But
this flag lowers the output binary into wasm32, with limiting the maximum
memory size to 4GB. So QEMU can run on wasm32 engines.

[1] https://webassembly.org/features/
[2] https://emscripten.org/docs/tools_reference/settings_reference.html#memory64

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 configure | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 92bfc5f976..326d27dab1 100755
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
 
@@ -521,7 +527,7 @@ case "$cpu" in
     CPU_CFLAGS="-m32"
     ;;
   wasm64)
-    CPU_CFLAGS="-m64 -sMEMORY64=1"
+    CPU_CFLAGS="-m64 -sMEMORY64=$wasm64_memory64"
     ;;
 esac
 
@@ -779,6 +785,8 @@ for opt do
   ;;
   --disable-rust) rust=disabled
   ;;
+  --wasm64-32bit-address-limit)
+  ;;
   # everything else has the same name in configure and meson
   --*) meson_option_parse "$opt" "$optarg"
   ;;
@@ -904,6 +912,8 @@ Advanced options (experts only):
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


