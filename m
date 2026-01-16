Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51463D4A5F1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgaaT-00053l-Kv; Thu, 15 Jan 2026 22:33:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgaaS-00053b-Pz
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:33:24 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgaaQ-0005AN-Ul
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:33:24 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-81e8b1bdf0cso941393b3a.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534401; x=1769139201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tUu8NW+N/lZtZUgHrpoRBaTBMcRkWiNokPBa1XqwUmI=;
 b=FLWIv9iK2Tw+dDQm4SncGxFyzTgRkKRa4ZLkEWsa1fsmuvAwxv6aVZXFlJ1iM0mYVw
 PWd27CfZRta55BnrUW1+iGOvp0jyM4k8kYzdM+f65il2XBfAr7M3p2KIXMMushJvvRCk
 vsN53Jd/HTX3UzmjtztSauv3FyxJ/FjPULPPupxYqHdBZH6y/AOZiK9xPpwVpjWel4Rt
 vmvkTBpyrDEuB4/v1Sa3ZKBivusoaH9pB0EJx0T8DuaqfYMveD4xz0r4dCce9/LRbnV+
 AvmR7niB3a8okvOzOo/xm9OisklILcuEDZ1bXXvZ0CBvmGKZ9aSuMtHnLSxba0FHwzDJ
 +itQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534401; x=1769139201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tUu8NW+N/lZtZUgHrpoRBaTBMcRkWiNokPBa1XqwUmI=;
 b=E8lHRXded19W7ReCT7T4Xah88OkaQEVSlLPKEk9PHmlaeLJmW1wAjpMXqaWqMl37gI
 DEelsugCLDoCUqi9zwC3pXNICr26kruuWkYE4OS2pWD9w+1qS+rm+67AItxyWFBfBGg0
 suew/YZBtTbJEZZjdZ3PSpujPdkGudaMyzQ/8QLUXte73mBedhjgub4H/fZsC6P/sbJF
 Eble0//WelOA8WYXKNtZt1U0zFTJjNzzW54Kt7MePhEXLA9OSS0w0FfgvB6V0+3Cfbrc
 n4FBCtVw4EluPhZxYeYxbvehQUd8S9w8SrJFYJeqYQyrrwgEvV99xkgOF3GpluQHyQLk
 SGbQ==
X-Gm-Message-State: AOJu0YzftdncSgA1Hq1ebqeh2Jq3VNxYx0F8XrZE6kImUWSIr+EDkmHn
 CwFq3YBJn4t6xANN7f7Mvx62RChr4kXB9q+F2X59Y6zXW8vpbCKukBh1umjX58i2jwxiCoYcSEu
 5X/mXuP7fqw==
X-Gm-Gg: AY/fxX4uShcq56xS9i6BTT2Ztv9PRySFy/SWBaXKfp1xLsGwfDN9yxmbtcdU/H/JdVI
 s2geIV42hqF/8Gda1flaB2EJsUIs8FePsZixjlvVP0vyRbIZcEXAOqSE6YnZdBK5Rw6s5PWpicJ
 AgG3joq3+U7jR+InQ1jXknocvix26HMDtZ+DLKfrsx0IQn2Nh63xzeBHTBmDxwBgpt3d1DEn+T6
 qXRixM9zCfvRUtPOClpFpLTgeW2rDXZRqj6eYAP+eNCCU/ywzdWAWSeM2QLxs8kDg6Br8vpAmek
 uVKl/LI41LCMlurfR2OLpy4fhvyR5xXtMn//ENruS2e8GaN030W7zFJX0xa30FfNvmNFG4SM6Vo
 7G3GYF9liMH4ZNzcK9OtOOr3vTO/s1q1uTfX6XJysFH1can0oyxdX8cRdtef2bbG55KSDgalT7K
 nvGIpOJBs8THMyaYivzQ==
X-Received: by 2002:a05:6a21:4cc7:b0:342:9cb7:649d with SMTP id
 adf61e73a8af0-38dfe60cd83mr1660828637.26.1768534401418; 
 Thu, 15 Jan 2026 19:33:21 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b5c67sm683372b3a.69.2026.01.15.19.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:33:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 01/58] meson: Add wasm64 support to the --cpu flag
Date: Fri, 16 Jan 2026 14:32:07 +1100
Message-ID: <20260116033305.51162-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

From: Kohei Tokunaga <ktokunaga.mail@gmail.com>

wasm64 target enables 64bit pointers using Emscripten's -sMEMORY64=1
flag[1]. This enables QEMU to run 64bit guests.

Although the configure script uses "uname -m" as the fallback value when
"cpu" is empty, this can't be used for Emscripten which targets to Wasm.
So, in wasm build, this commit fixes configure to require --cpu flag to be
explicitly specified by the user.

[1] https://emscripten.org/docs/tools_reference/settings_reference.html#memory64

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <91f16f0e9ae6b36fbf0c2caac510dcf855120400.1768308374.git.ktokunaga.mail@gmail.com>
---
 configure   | 6 +++++-
 meson.build | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 55e0bd3425..92bfc5f976 100755
--- a/configure
+++ b/configure
@@ -365,7 +365,6 @@ elif check_define __APPLE__; then
   host_os=darwin
 elif check_define EMSCRIPTEN ; then
   host_os=emscripten
-  cpu=wasm32
   cross_compile="yes"
 else
   # This is a fatal error, but don't report it yet, because we
@@ -419,6 +418,8 @@ elif check_define __aarch64__ ; then
   cpu="aarch64"
 elif check_define __loongarch64 ; then
   cpu="loongarch64"
+elif check_define EMSCRIPTEN ; then
+  error_exit "wasm32 or wasm64 must be specified to the cpu flag"
 else
   # Using uname is really broken, but it is just a fallback for architectures
   # that are going to use TCI anyway
@@ -519,6 +520,9 @@ case "$cpu" in
   wasm32)
     CPU_CFLAGS="-m32"
     ;;
+  wasm64)
+    CPU_CFLAGS="-m64 -sMEMORY64=1"
+    ;;
 esac
 
 if test -n "$host_arch" && {
diff --git a/meson.build b/meson.build
index c58007291a..600c50007d 100644
--- a/meson.build
+++ b/meson.build
@@ -51,7 +51,7 @@ qapi_trace_events = []
 bsd_oses = ['gnu/kfreebsd', 'freebsd', 'netbsd', 'openbsd', 'dragonfly', 'darwin']
 supported_oses = ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin', 'sunos', 'linux', 'emscripten']
 supported_cpus = ['ppc', 'ppc64', 's390x', 'riscv32', 'riscv64', 'x86', 'x86_64',
-  'arm', 'aarch64', 'loongarch64', 'mips64', 'sparc64', 'wasm32']
+  'arm', 'aarch64', 'loongarch64', 'mips64', 'sparc64', 'wasm32', 'wasm64']
 
 cpu = host_machine.cpu_family()
 
@@ -923,7 +923,7 @@ if have_tcg
     if not get_option('tcg_interpreter')
       error('Unsupported CPU @0@, try --enable-tcg-interpreter'.format(cpu))
     endif
-  elif host_arch == 'wasm32'
+  elif host_arch == 'wasm32' or host_arch == 'wasm64'
     if not get_option('tcg_interpreter')
       error('WebAssembly host requires --enable-tcg-interpreter')
     endif
-- 
2.43.0


