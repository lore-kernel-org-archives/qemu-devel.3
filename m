Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45D2D4A5EE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgabp-0007Yx-Uo; Thu, 15 Jan 2026 22:34:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgabm-0007Mj-2l
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:34:47 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgabk-0005o9-Jk
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:34:45 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a12ebe4b74so15908365ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534482; x=1769139282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yAk5bdNYmUwoFtPTTu8n12DNLYrg+PZEaFEkzjHimDM=;
 b=HZa/XnFTsBmhtYQ7teI6JEbu2WAFaw92hxjts4gSS1CLvIErFk+Ie/kVrk/SPetsTP
 5DqTTtWCIXm/+V0w7AUBmXRashe3V2T/fmm0+PzBoGD/xjFSf4s4M6zDgdMmZVp6D9MV
 SIBsOpN54irkrX/xaWNwcZgncDsXNwkcLuP9qvlV9t9QBVCQdejEKksctoJSYkhyZNsP
 FMwxz7DlL2HPr622RybtRXLGSdEqk+saIeWwvQJIKRTq7Npzu0ljS0Xakkh35PMXtFyd
 VMqodiDCEj5cJ9o+bT8H+ZH5dLvA2PSWUpKA7do3ZS7RwsjOtj+kmEU9G8Nb0wqMA/0A
 FjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534482; x=1769139282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yAk5bdNYmUwoFtPTTu8n12DNLYrg+PZEaFEkzjHimDM=;
 b=fI3NHgy1r0a/k9OVJUu9boEtoJ/WEq4hLUDxrkGNSnHKcSEAuYmSWB0PndmQbprtF3
 l+EkN+KWWjfM4USw1plrZ5ytpZrPRaP470BlRyXjnm+DT9vt0AiK67Tw7R6RDypNsJ+k
 cc59CW9CctnBA12B470H3nR1id2bB6GcvoJysF0iv65pKMZGF5jXI1hkl0MbJ0wfmzxU
 xd8uSa4YoeiU0CCgKvgJYRIqH6L2MM4iRgdMIMwRtxrtWO/06Bfz5Yb+yhelcZDztT/g
 SIOEXmCaXEsdKbo/o1mZH8bFDsFqh71sNWyWaR8Q88vFWIPio5SIKkMFRG8YvUwMHoyX
 8uFg==
X-Gm-Message-State: AOJu0YzjR5TMN9Qn56TGuOAXIAEWmC7hjN15LeCy6QuuepV1pUBRDsEG
 aUihziLq3nfnuPQ07AepLqH+l6FQtBal5imfITG4sz/6BWV4wD5BLXbHS2/fq2YiR7hV61Adql8
 d7al40uhHfQ==
X-Gm-Gg: AY/fxX5A3PXfd4ZXRTk5uP+xlv6EXyuACX+nTVmw1usXLMDKESBrkTAGnYDLD+gF67c
 Ejs74M838pDhwVkpAIDUstsbCgzWtT+MYEBVyLThDQQpGoZOjjuJNM/ZgjOK3GBfNPk3UJ/e7kj
 6eb+JUeqOOXnyBQIGH48A0r23LC6pDComhP4IjSG8M2MYLRrXp2p4A8c2We6GOA8WZRQBiFKplW
 yXCOvHbLc1lvLAcTb+dEugAt5Hhk4NVD4W9/0O9JofXsCB/wT4DKuNgKNifbsgWy+qQyhF/p96Q
 9j3kDkA5aNjAC5PdFjMLCGHA0dP+S18uE9AxBKkUXYantaTjTGSxayX+ENy2iyhew0Ea4MUC6+t
 vl/cbS3zOyLcDBLlk+VyQ6uyWlr3baxzkjuKYGhnBBbIFE7KIm0EGcv+E1PbwudtbLhMpXjQBLo
 PRRvkjctKz9oVWVuA6+g==
X-Received: by 2002:a17:903:1ae4:b0:2a0:f828:24a3 with SMTP id
 d9443c01a7336-2a7175cc0f1mr17370305ad.28.1768534481754; 
 Thu, 15 Jan 2026 19:34:41 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b5c67sm683372b3a.69.2026.01.15.19.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:34:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 22/58] meson: Remove cpu == riscv32 tests
Date: Fri, 16 Jan 2026 14:32:28 +1100
Message-ID: <20260116033305.51162-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

The 32-bit riscv host is no longer supported.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure   | 10 +++-------
 meson.build |  4 +---
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/configure b/configure
index ee09f90125..e69b3e474e 100755
--- a/configure
+++ b/configure
@@ -408,12 +408,8 @@ elif check_define __s390__ ; then
   else
     cpu="s390"
   fi
-elif check_define __riscv ; then
-  if check_define _LP64 ; then
-    cpu="riscv64"
-  else
-    cpu="riscv32"
-  fi
+elif check_define __riscv && check_define _LP64 ; then
+  cpu="riscv64"
 elif check_define __aarch64__ ; then
   cpu="aarch64"
 elif check_define __loongarch64 ; then
@@ -1280,7 +1276,7 @@ EOF
     test "$bigendian" = no && rust_arch=${rust_arch}el
     ;;
 
-  riscv32|riscv64)
+  riscv64)
     # e.g. riscv64gc-unknown-linux-gnu, but riscv64-linux-android
     test "$android" = no && rust_arch=${rust_arch}gc
     ;;
diff --git a/meson.build b/meson.build
index e1ac764793..0189d8fd44 100644
--- a/meson.build
+++ b/meson.build
@@ -50,7 +50,7 @@ qapi_trace_events = []
 
 bsd_oses = ['gnu/kfreebsd', 'freebsd', 'netbsd', 'openbsd', 'dragonfly', 'darwin']
 supported_oses = ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin', 'sunos', 'linux', 'emscripten']
-supported_cpus = ['ppc64', 's390x', 'riscv32', 'riscv64', 'x86_64',
+supported_cpus = ['ppc64', 's390x', 'riscv64', 'x86_64',
   'aarch64', 'loongarch64', 'mips64', 'sparc64', 'wasm64']
 
 cpu = host_machine.cpu_family()
@@ -279,8 +279,6 @@ elif cpu == 'ppc64'
   kvm_targets = ['ppc-softmmu', 'ppc64-softmmu']
 elif cpu == 'mips64'
   kvm_targets = ['mips-softmmu', 'mipsel-softmmu', 'mips64-softmmu', 'mips64el-softmmu']
-elif cpu == 'riscv32'
-  kvm_targets = ['riscv32-softmmu']
 elif cpu == 'riscv64'
   kvm_targets = ['riscv64-softmmu']
 elif cpu == 'loongarch64'
-- 
2.43.0


