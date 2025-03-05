Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887A9C021B8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 00:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpd0y-0002Qp-Ns; Tue, 04 Mar 2025 19:53:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpd0k-0002Dk-2C
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 19:53:22 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpd0i-0007XM-AG
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 19:53:21 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-390fb1b987fso4249449f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 16:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741135997; x=1741740797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DSiKYdB6630hg7am6WhMyssXSt9ts03i324UUBol9bo=;
 b=n1msjOdGswzmLJirKE03HDTmsAVFoPfesF7pqbfv5BfGq0e15DVV9kmxZ43kEGl331
 52O8eLJebc8sbif/beLrz+t3H85NYw6cfxV4LvUwyuO8rOWBs9gosdsKpZFINqNgr1xA
 4BjhMquQpl5ff+EO2Ex+Efi0yQxWXJo+giu6Z/mikCsxJlHZsX6lHgMS/arsWVcXA8BO
 v9fjKIvGy9+U+vkCuQrLEmnjsvYk6Q1a89/AVgHohLVfrwRnHyGUboxGieKXRbbSpS1L
 P8MHFn/X7B3gZZ5ggbj2EKPwC48j+eSHV05waDJPRo8ih3bsYgw1cLYZ5SKnUbmZZmFr
 ls1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741135997; x=1741740797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DSiKYdB6630hg7am6WhMyssXSt9ts03i324UUBol9bo=;
 b=WAQSxvec4132eD0/lIObiKbIJ4azjIVI5KquW71itzGrBhk78PVHj4racQd4N02Hdo
 amFL3/zuegmlRUkgjHS3HUqTORRFs6oO/5W8HxfLMbzcDEEuhcQCJfJNFL988F4qyV2U
 SjimwrbpbHDROulo6rbPebKJjcIeLUdw3ICg70NrlsgD5RXVqrY7NkirkL719RPONtCF
 scXA1Rx5DyK70KcdtUsqCXTvpkwkdxUH1a7yZ4rYFuJCQM8ZRH8D+mZk1RuvTB/MCy+x
 NPvr1YBijrG7O5aR/6aHWSUodvdYYqmdTe3aulvnQOOJQ173n96ujFKH8nWv8bfKZDLW
 oDJQ==
X-Gm-Message-State: AOJu0Yw9dINjIWeRvjZTla6DYv63aXVtkB9FetXYMzhLXrN1gIpz2j5k
 5IUCYt+QP3QrJLhevHl/O21YnD6UJvgWKHVceQVapIs2wv5Gjm4khNYhBUbJHH+8rerYfU7ujXD
 2bLw=
X-Gm-Gg: ASbGnctqGEYMWGMk9qE8M6FUrzxNRL9WwSjEQi7HzXln7C1W5DprDw1j4ieZNw1Uvae
 t75iYu4CsJWySyTVJByfr1r2mlOeFdON80lpBmLJ1R9PofQKV08YHAH3OW21F+2CRTLg+TERlui
 GG7DJ12wFK7aRh57gF6a4+nUvtVx0sQO3jhPJJeG6dFZccUF23N6wBgx885HyIKJn4xfcrLcbqJ
 752BTLUj8bck76/FaINXnVM3X5uNWEnza4IVoKxDsfnuUtxN2laVq9wFbOj+DjsE2GVZah9ObJm
 pcAOsk6JAGXLm3wCu/8hSG/dT1vqAbnDoQI5jXILGzSuPuFVxcHZwmv7AbU+JKYZgRzgb8KVolA
 GPYDkbRySANn5ZGyNybw=
X-Google-Smtp-Source: AGHT+IG3egKbw9YIe/FSr3ntlHLIugkrh9BelKaDhfu61mibtTzaXiYY69Gx3hZ4lBTY1mh6EM46Tg==
X-Received: by 2002:a5d:64c5:0:b0:391:1218:d5f7 with SMTP id
 ffacd0b85a97d-3911f7bb7a9mr582723f8f.40.1741135996445; 
 Tue, 04 Mar 2025 16:53:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e46f580bsm18957749f8f.0.2025.03.04.16.53.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 16:53:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 09/11] user: Replace TARGET_NAME -> target_name()
Date: Wed,  5 Mar 2025 01:52:23 +0100
Message-ID: <20250305005225.95051-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305005225.95051-1-philmd@linaro.org>
References: <20250305005225.95051-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

In order to avoid the target-specific TARGET_NAME definition,
replace it by the generic target_name() helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 bsd-user/main.c   |  9 ++++++---
 linux-user/main.c | 12 +++++++-----
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index fdb160bed0f..683003c2d52 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -25,6 +25,7 @@
 #include "qemu/help-texts.h"
 #include "qemu/units.h"
 #include "qemu/accel.h"
+#include "qemu/arch_info.h"
 #include "qemu-version.h"
 #include <machine/trap.h>
 
@@ -150,9 +151,11 @@ void cpu_loop(CPUArchState *env)
 
 static void usage(void)
 {
-    printf("qemu-" TARGET_NAME " version " QEMU_FULL_VERSION
+    const char *target = target_name();
+
+    printf("qemu-%s version " QEMU_FULL_VERSION
            "\n" QEMU_COPYRIGHT "\n"
-           "usage: qemu-" TARGET_NAME " [options] program [arguments...]\n"
+           "usage: qemu-%s [options] program [arguments...]\n"
            "BSD CPU emulator (compiled for %s emulation)\n"
            "\n"
            "Standard options:\n"
@@ -188,7 +191,7 @@ static void usage(void)
            "\n"
            QEMU_HELP_BOTTOM "\n"
            ,
-           TARGET_NAME,
+           target, target, target,
            interp_prefix,
            target_dflssiz);
     exit(1);
diff --git a/linux-user/main.c b/linux-user/main.c
index 5c74c52cc52..0e4722ea273 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -21,6 +21,7 @@
 #include "qemu/help-texts.h"
 #include "qemu/units.h"
 #include "qemu/accel.h"
+#include "qemu/arch_info.h"
 #include "qemu-version.h"
 #include <sys/syscall.h>
 #include <sys/resource.h>
@@ -432,8 +433,8 @@ static void handle_arg_strace(const char *arg)
 
 static void handle_arg_version(const char *arg)
 {
-    printf("qemu-" TARGET_NAME " version " QEMU_FULL_VERSION
-           "\n" QEMU_COPYRIGHT "\n");
+    printf("qemu-%s version " QEMU_FULL_VERSION
+           "\n" QEMU_COPYRIGHT "\n", target_name());
     exit(EXIT_SUCCESS);
 }
 
@@ -543,14 +544,15 @@ static const struct qemu_argument arg_table[] = {
 static void usage(int exitcode)
 {
     const struct qemu_argument *arginfo;
+    const char *target = target_name();
     int maxarglen;
     int maxenvlen;
 
-    printf("usage: qemu-" TARGET_NAME " [options] program [arguments...]\n"
-           "Linux CPU emulator (compiled for " TARGET_NAME " emulation)\n"
+    printf("usage: qemu-%s [options] program [arguments...]\n"
+           "Linux CPU emulator (compiled for %s emulation)\n"
            "\n"
            "Options and associated environment variables:\n"
-           "\n");
+           "\n", target, target);
 
     /* Calculate column widths. We must always have at least enough space
      * for the column header.
-- 
2.47.1


