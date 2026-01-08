Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00AFDD148A0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdibs-0005Pg-UU; Thu, 08 Jan 2026 00:31:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdibo-0005If-5L
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:30:56 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdibm-0005Nb-Jh
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:30:55 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a07fac8aa1so23292715ad.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850253; x=1768455053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6d4jiRagzBQQHiEnfwjlRKGs6G39EMUaQpWILpAj3V8=;
 b=K6Ac1Ut3PDa5wRbQC+GnTM/QCPSDUzYUuwxKfYWCBsyWhSWrlYKeWeXdWYlFdhMOOY
 373wnxlBl8siAw4QBweiz0hf7CJSGvRFaM2exCA4pQSXBmAA2QELsiQsJDxlZVgQIf0F
 KQPGEOoXdlQrBV4qP+ZbQYcX32uj944z25A5/iBEAnnKLK83v/rJxMH4ldxAgP4ZfUpF
 VJCbmdHsYH7uUd+Tu3x4lNuo+uYaH6HFjfyeTXQ+W+aJYYKuTeL3axczJcoKEZse8sjm
 8nqjw19lcRXGFg7dHNSQAteePeO2kl1cojV53Fi+aYTGkcDr6ZbLgM3yVH1xM71A7IgM
 4hLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850253; x=1768455053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6d4jiRagzBQQHiEnfwjlRKGs6G39EMUaQpWILpAj3V8=;
 b=CfT+o0fS5j6958teo0iBxZbZ6ou41d0As5a/iom9lX3ZF5i70i9SETmeh99ACn3ME/
 ZaQgiQdCflak5/u19mLq5GO6nFIaBaw9X1L3iqmzFibxa2nkQUGsBpx4o6zgOpJUXmiC
 wydS1og6KXWLFL6EKpL+tWp9u4+FAMIQpPSEHu1+CJ25a0whj8qKYkrTfNVB0i46hS94
 aPrK62iDlWGVgVgP5wP/u458gffHOXZsoRhNflJFJhhySWnYUghSgyqX9zTijdZSTqH8
 zEOglzoxkbEGgUviB2YhjmQruK2Kz4K+BvFwd256nHJw+8rBqSPoinmhZd2loPQczjHU
 iEog==
X-Gm-Message-State: AOJu0YzMiPBFGNffmZltY4Y4Tk3pWTP8MTQnAcC1Tb1FX/bWbvIUGz2b
 VTMZ0fIu8qscaWoWHGBWFaIPPCZEB0eyTO37PeCF4xn6G32RS7Sgbir7X8tc5DHsRAWoqrMHAe/
 ByocXSJ8=
X-Gm-Gg: AY/fxX4M6fa+gqWhkqSymnvmwAhKhLYq/9hGNc2ByOM0QnYu+wLRQ6nAZqWXjsN8f9u
 ZXuSGUHeIWYgrWnKva+66LMDbGBKCwfzok96qAhFqgypEzoGSwJFaW+QMcBhrKocvTICd0Qa1X1
 6dPPzgEJBYJWk7UZfw1eCXOuVBkVO9t4W/k5P1apnldWt0roVYc+LEKis5D/RTb1MTx5tTa/S7G
 H17d5XmBybuTDIfetFdIKrPZb86T1l/X+oPLxhWk2Ckw4z8eHoNxdavbjC0M8/+CSSpFEqzueyt
 GhP0qWZOymK8bN8uDLVMukbhUE+P+hxlPok1eNZKAc03FWJ68tEBiA4k20/pk4hOIVTBrAvt8tS
 XW5KGjZiAoKcdad2Sj/3xNRp+OJn7xwimGbJQHVbdLMVqXRmm5YiESFktSfjQSyyn8AhoY6C3Vz
 g8P0wBYdWWwLxcDeaNYg==
X-Google-Smtp-Source: AGHT+IEqJc+w3iumYWc8sS9dhg7P1xNSOt15iqnpql2U51Q1zGFE3LlhLURCcXygVkmTOSnsa7vbDw==
X-Received: by 2002:a17:90b:3a8d:b0:34a:adf1:677d with SMTP id
 98e67ed59e1d1-34f68b64d7cmr4144509a91.9.1767850252921; 
 Wed, 07 Jan 2026 21:30:52 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd9d9sm7036552a12.16.2026.01.07.21.30.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:30:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/50] meson: Remove cpu == riscv32 tests
Date: Thu,  8 Jan 2026 16:29:43 +1100
Message-ID: <20260108053018.626690-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

The 32-bit riscv host is no longer supported.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure   | 10 +++-------
 meson.build |  4 +---
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/configure b/configure
index 2d9a603ee8..06a1b441ff 100755
--- a/configure
+++ b/configure
@@ -403,12 +403,8 @@ elif check_define __s390__ ; then
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
@@ -1269,7 +1265,7 @@ EOF
     test "$bigendian" = no && rust_arch=${rust_arch}el
     ;;
 
-  riscv32|riscv64)
+  riscv64)
     # e.g. riscv64gc-unknown-linux-gnu, but riscv64-linux-android
     test "$android" = no && rust_arch=${rust_arch}gc
     ;;
diff --git a/meson.build b/meson.build
index b0fe798ee2..a18b3a5657 100644
--- a/meson.build
+++ b/meson.build
@@ -50,7 +50,7 @@ qapi_trace_events = []
 
 bsd_oses = ['gnu/kfreebsd', 'freebsd', 'netbsd', 'openbsd', 'dragonfly', 'darwin']
 supported_oses = ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin', 'sunos', 'linux', 'emscripten']
-supported_cpus = ['ppc64', 's390x', 'riscv32', 'riscv64', 'x86_64',
+supported_cpus = ['ppc64', 's390x', 'riscv64', 'x86_64',
   'aarch64', 'loongarch64', 'mips64', 'sparc64', 'wasm32']
 
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


