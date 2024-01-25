Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A56DC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:58:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT32E-0007Vq-Gp; Thu, 25 Jan 2024 11:57:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rT32C-0007Up-MW
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:57:00 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rT329-00017n-TU
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:57:00 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40e72a567eeso82927425e9.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 08:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706201816; x=1706806616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tu0Wmz1gyaDFvvITpysE/w6FwQ0wlgaZK51MD3LFw0E=;
 b=b1sRax/GvB438lPXezIU42qinJF4oEXHnkbT25JikElIKa4NfBd91r7JSgB0NBNTgh
 FTgC7h02zgRWJQwEr3e7JrXfZ4uxOtP8mb3uzvjee/vAIuKbQMiUapQEtvYL7jW8y6zf
 +H1JSfWq9VwzCwesdnlofcqJXTRt/yHUUfnGEird/X0L7NQRfau+W/kUzQh8dRcsbZjZ
 cmOXSrDe4eUYycSFdGUaReFYTMzpNWWccNatneLKDJKsOye58l2DWjcpvotgmdTPdaTn
 NlKa9Ppi801MEZFhbavJ7wZgJTSi58J4kZQGcFZr8gIVm6dAmjByeuWRR1s9O0Pa51lQ
 RMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706201816; x=1706806616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tu0Wmz1gyaDFvvITpysE/w6FwQ0wlgaZK51MD3LFw0E=;
 b=sfOolfffZhGR5V8AGOUVjm0cQvKEHVR/pnfYPM/jF6TL85LqT9XZHiqlyZ1Vjlt/1z
 aafUrxgaopnpTGMNjVDVIx/lbz9/CIVbDgP0VA2kAJhHs3H0PR0FfjvAXWJaowN2KGc1
 TWZLwrQd5G15vTVzQv9thXXbgMQXKWLfMih4fIOfslUuiBXD0WkzS13QPJ5ZN47AnbiX
 I+Sd8BUbW+T9EeYPKcuSou8kT7as01oTkz0p3Zt2V9V0k7wQibzErZU57RaYUZI7t4aQ
 7m8toZFb2gJbJHbr3MHk2I1IM3PR/vmTq1o/ABHwXesBJVHYGDRKNrjnKYXWkCQsUp0Q
 FLuw==
X-Gm-Message-State: AOJu0YwPyIUAEZYZv93YdG4tDvu97fuFRwWjNTejxjbcBn9SNvvzE9Dy
 8UfglOxuLFVYdplBzaFBVslVkfJ1PYcn68N8hoUv9zhMYBZPdZNiGd7J31JubYlWuJWdYREYlk1
 Z
X-Google-Smtp-Source: AGHT+IFwNKe9QDuVNpO7uXV8lT04MZQIjsOE3Rmx5GNIrppU4ZWDIdctSfNNo6qnEUQJir3wKf1H5Q==
X-Received: by 2002:a05:600c:b52:b0:40e:cca8:dd32 with SMTP id
 k18-20020a05600c0b5200b0040ecca8dd32mr7264wmr.364.1706201816314; 
 Thu, 25 Jan 2024 08:56:56 -0800 (PST)
Received: from m1x-phil.lan (lec62-h02-176-184-19-125.dsl.sta.abo.bbox.fr.
 [176.184.19.125]) by smtp.gmail.com with ESMTPSA id
 j11-20020a05600c190b00b0040e53f24ceasm3223034wmq.16.2024.01.25.08.56.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 25 Jan 2024 08:56:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] scripts/coccinelle: Add cpu_env.cocci_template script
Date: Thu, 25 Jan 2024 17:56:45 +0100
Message-ID: <20240125165648.49898-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240125165648.49898-1-philmd@linaro.org>
References: <20240125165648.49898-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Add a Coccinelle script to convert the following slow path
(due to the QOM cast macro):

  &ARCH_CPU(..)->env

to the following fast path:

  cpu_env(..)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                               |  1 +
 scripts/coccinelle/cpu_env.cocci_template | 60 +++++++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 scripts/coccinelle/cpu_env.cocci_template

diff --git a/MAINTAINERS b/MAINTAINERS
index dfaca8323e..1d57130ff8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -157,6 +157,7 @@ F: accel/tcg/
 F: accel/stubs/tcg-stub.c
 F: util/cacheinfo.c
 F: util/cacheflush.c
+F: scripts/coccinelle/cpu_env.cocci_template
 F: scripts/decodetree.py
 F: docs/devel/decodetree.rst
 F: docs/devel/tcg*
diff --git a/scripts/coccinelle/cpu_env.cocci_template b/scripts/coccinelle/cpu_env.cocci_template
new file mode 100644
index 0000000000..53aa3a1fea
--- /dev/null
+++ b/scripts/coccinelle/cpu_env.cocci_template
@@ -0,0 +1,60 @@
+/*
+
+ Convert &ARCH_CPU(..)->env to use cpu_env(..).
+
+ Rationale: ARCH_CPU() might be slow, being a QOM cast macro.
+            cpu_env() is its fast equivalent.
+
+ SPDX-License-Identifier: GPL-2.0-or-later
+ SPDX-FileCopyrightText: Linaro Ltd 2024
+ SPDX-FileContributor: Philippe Mathieu-Daudé
+
+ Usage as of v8.2.0:
+
+ $ for targetdir in target/*; do test -d $targetdir || continue; \
+       export target=${targetdir:7}; \
+       sed \
+           -e "s/__CPUArchState__/$( \
+               git grep -h --no-line-number '@env: #CPU.*State' \
+                   target/$target/cpu.h \
+               | sed -n -e 's/.*\(CPU.*State\).\?/\1/p')/g" \
+           -e "s/__ARCHCPU__/$( \
+               git grep -h --no-line-number OBJECT_DECLARE_CPU_TYPE.*CPU \
+                   target/$target/cpu-qom.h \
+               | sed -n -e 's/.*(\(.*\), .*, .*)/\1/p')/g" \
+           -e "s/__ARCH_CPU__/$( \
+               git grep -h --no-line-number OBJECT_DECLARE_CPU_TYPE.*CPU \
+                   target/$target/cpu-qom.h \
+               | sed -n -e 's/.*(.*, .*, \(.*\))/\1/p')/g" \
+       < scripts/coccinelle/cpu_env.cocci_template \
+       > $TMPDIR/cpu_env_$target.cocci; \
+       for dir in hw target/$target; do \
+           spatch --macro-file scripts/cocci-macro-file.h \
+                  --sp-file $TMPDIR/cpu_env_$target.cocci \
+                  --keep-comments \
+                  --dir $dir \
+                  --in-place; \
+       done; \
+   done
+
+*/
+
+@ CPUState_arg_used @
+CPUState *cs;
+identifier cpu;
+identifier env;
+@@
+-   __ARCHCPU__ *cpu = __ARCH_CPU__(cs);
+-   __CPUArchState__ *env = &cpu->env;
++   __CPUArchState__ *env = cpu_env(cs);
+    ... when != cpu
+
+@ depends on never CPUState_arg_used @
+identifier obj;
+identifier cpu;
+identifier env;
+@@
+-   __ARCHCPU__ *cpu = __ARCH_CPU__(obj);
+-   __CPUArchState__ *env = &cpu->env;
++   __CPUArchState__ *env = cpu_env(CPU(obj));
+    ... when != cpu
-- 
2.41.0


