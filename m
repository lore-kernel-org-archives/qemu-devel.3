Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F44ACD343B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcxP-00080r-Ha; Wed, 06 May 2026 10:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcwt-0007mX-LH
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:10:05 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcwl-0002HS-IO
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:09:57 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso55500715e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076593; x=1778681393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cRYPq0kfd9OLQZNCTmCz4sOJdP+EazwFZ/SzgSuAvXI=;
 b=xYAwFChVtqAZ8NYGj/kWQ1NQGS2j1S0jrLzPuNioyFVobROlCRYFsgKBx+bjCx3Z8T
 /Vn1+Bc0nqGsf775l2D7Lm++bQ+gZ9dhEoqPgCbo0ojxeaIyXGag5/NRajfJMuWMbNOP
 p0agCO/7btTDsXedeCmvjl5G84v7L37AT8vKdQiwyGSPzo32m62yIUJ0mJA58k0KfsRW
 Z3bLzykEINA23PCVwthyQRyf5EDPeYCc4Goc+9sOdJlzfQcotA2LCC1Jidi5au2XCHRg
 ov6LM1sGFGZ0+xYwl85jnyDnOQPsmxFFOtxikDG8JqUoCtG0sHFdihITZNhfvT7VM+cW
 pATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076593; x=1778681393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cRYPq0kfd9OLQZNCTmCz4sOJdP+EazwFZ/SzgSuAvXI=;
 b=EoR75nn38AvC5P7z5sNnftsqn9pgPONrgoAG20dQ+zwvdzT7pH35q2uFS7BdRb7gBC
 tgusA+NfBdWgmPdYC5A000mdM9IjBNOYQB3Z7iZwvqExzJsEk/i4PCxmFhnGMx/26lO5
 0ysbci/LO0c4QBiqNEQabBkr3qtmH3iYIqtxwz893VLZIkTep/k+lprIOjvuBQpjRvOl
 Uc3WTyFh7XRpu+aiHJEjNuZOQZjk9GBtb1LmwjmmY5DuTsWRkWijceo9Ph4qWnabOaQI
 QEIDGxTyT0XP9uxpwIgy6hkKRPXfBdTvWTO9AJq9hm819+i1pcUedZHK7DcoG3A4kzWI
 iJIA==
X-Gm-Message-State: AOJu0Yzc/4yHBONkGhizY23TK6cWpsD373oRR4xR+joCRka41Q8040Jj
 Uq7Amp3o0tMxejvfPV9uZaR5IyRg34mmj1QW5oHNCwFdJ1WTSRzxbK5i+h8d9hO9vkylChzqKRu
 kIYTAiIk=
X-Gm-Gg: AeBDiese7Kj8GIIPlteuBkkPV8AyUqEGN//suF4HBJMizwUjViIUeFQGwoi1hjfvvXH
 a4Dgc/JbgBfXVvUxHnNt0Euf7z0HX/aub7c6+/AYIzBcFxRBSUUPLDTbx+6mrZPdCuUHz34DBBC
 j/trJf1meRjtgrrZ2t2b+/YEJahXaMHh8jql3FB6WUUufin7q5zLjqwj76DyYAI+yNsK2e1N/AM
 fsopNBC+eDVAnG0ZBUE6wl+yOljYMekuZNLMMlVSlu48pLZFT0Vh7oc799NQJ1kQzWs8t1Oc0TT
 41aLK54zjhFNTDCZYWeii6M4KyqnbYZYPX0tVH3HF7Crm8TddSfGQjmDqvZYWbHLMOjsNpG8xrd
 c8l+0sULr55PCJQu20pQOEV31DuRBRL/ASnLw8rxqdxetYIZ81NdO0BIsIJAolSvm4qvzc6mZ/c
 q4wZ8xcWB2m7YiRBP8FbnFPEF0AOhdm7wdt0a80amQDz0npLajH0yPIiMAKgL1hblmG1P9ErtqI
 WUTLt67UWA=
X-Received: by 2002:a05:600c:3548:b0:487:1108:48b8 with SMTP id
 5b1f17b1804b1-48e51e0a60fmr63594845e9.2.1778076592738; 
 Wed, 06 May 2026 07:09:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53907e8asm49401665e9.13.2026.05.06.07.09.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:09:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 110/110] system/vl: inline qemu_opts_parse_noisily() result
 checks
Date: Wed,  6 May 2026 15:55:22 +0200
Message-ID: <20260506135524.20617-111-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

From: Bin Guo <guobin@linux.alibaba.com>

In qemu_init()'s option parsing switch, several cases assigned the
return value of qemu_opts_parse_noisily() to the shared 'opts'
variable solely to check for NULL, without using the pointer
afterwards.  Inline the call directly into the if-condition, matching
the style already used by QEMU_OPTION_action.

This affects the following options:
  -drive, -numa, -iscsi, -m, -mon, -chardev, -fsdev, -fwcfg

Cases where the returned QemuOpts* is subsequently used (e.g.
-acpitable, -smbios, -virtfs) are left unchanged.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260429062004.36582-4-guobin@linux.alibaba.com>
[PMD: Reduce @opts declaration to innermost block]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/vl.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index 705f0d3a4a9..d2f4044e5d8 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2842,7 +2842,6 @@ void qmp_x_exit_preconfig(Error **errp)
 
 void qemu_init(int argc, char **argv)
 {
-    QemuOpts *opts;
     QemuOpts *icount_opts = NULL, *accel_opts = NULL;
     QemuOptsList *olist;
     int optind;
@@ -2928,6 +2927,7 @@ void qemu_init(int argc, char **argv)
             drive_add(IF_DEFAULT, 0, argv[optind++], HD_OPTS);
         } else {
             const QEMUOption *popt;
+            QemuOpts *opts;
 
             popt = lookup_opt(argc, argv, &optarg, &optind);
             if (!qemu_arch_available(popt->arch_mask)) {
@@ -2963,9 +2963,8 @@ void qemu_init(int argc, char **argv)
                     break;
                 }
             case QEMU_OPTION_drive:
-                opts = qemu_opts_parse_noisily(qemu_find_opts("drive"),
-                                               optarg, false);
-                if (opts == NULL) {
+                if (!qemu_opts_parse_noisily(qemu_find_opts("drive"),
+                                             optarg, false)) {
                     exit(1);
                 }
                 break;
@@ -2990,9 +2989,8 @@ void qemu_init(int argc, char **argv)
                 replay_add_blocker("-snapshot");
                 break;
             case QEMU_OPTION_numa:
-                opts = qemu_opts_parse_noisily(qemu_find_opts("numa"),
-                                               optarg, true);
-                if (!opts) {
+                if (!qemu_opts_parse_noisily(qemu_find_opts("numa"),
+                                             optarg, true)) {
                     exit(1);
                 }
                 break;
@@ -3051,9 +3049,8 @@ void qemu_init(int argc, char **argv)
                 break;
 #ifdef CONFIG_LIBISCSI
             case QEMU_OPTION_iscsi:
-                opts = qemu_opts_parse_noisily(qemu_find_opts("iscsi"),
-                                               optarg, false);
-                if (!opts) {
+                if (!qemu_opts_parse_noisily(qemu_find_opts("iscsi"),
+                                             optarg, false)) {
                     exit(1);
                 }
                 break;
@@ -3106,8 +3103,8 @@ void qemu_init(int argc, char **argv)
                 exit(0);
                 break;
             case QEMU_OPTION_m:
-                opts = qemu_opts_parse_noisily(qemu_find_opts("memory"), optarg, true);
-                if (opts == NULL) {
+                if (!qemu_opts_parse_noisily(qemu_find_opts("memory"),
+                                             optarg, true)) {
                     exit(1);
                 }
                 break;
@@ -3228,17 +3225,15 @@ void qemu_init(int argc, char **argv)
                 default_monitor = 0;
                 break;
             case QEMU_OPTION_mon:
-                opts = qemu_opts_parse_noisily(qemu_find_opts("mon"), optarg,
-                                               true);
-                if (!opts) {
+                if (!qemu_opts_parse_noisily(qemu_find_opts("mon"), optarg,
+                                             true)) {
                     exit(1);
                 }
                 default_monitor = 0;
                 break;
             case QEMU_OPTION_chardev:
-                opts = qemu_opts_parse_noisily(qemu_find_opts("chardev"),
-                                               optarg, true);
-                if (!opts) {
+                if (!qemu_opts_parse_noisily(qemu_find_opts("chardev"),
+                                             optarg, true)) {
                     exit(1);
                 }
                 break;
@@ -3248,8 +3243,7 @@ void qemu_init(int argc, char **argv)
                     error_report("fsdev support is disabled");
                     exit(1);
                 }
-                opts = qemu_opts_parse_noisily(olist, optarg, true);
-                if (!opts) {
+                if (!qemu_opts_parse_noisily(olist, optarg, true)) {
                     exit(1);
                 }
                 break;
@@ -3388,9 +3382,8 @@ void qemu_init(int argc, char **argv)
                 smbios_entry_add(opts, &error_fatal);
                 break;
             case QEMU_OPTION_fwcfg:
-                opts = qemu_opts_parse_noisily(qemu_find_opts("fw_cfg"),
-                                               optarg, true);
-                if (opts == NULL) {
+                if (!qemu_opts_parse_noisily(qemu_find_opts("fw_cfg"),
+                                             optarg, true)) {
                     exit(1);
                 }
                 break;
-- 
2.53.0


