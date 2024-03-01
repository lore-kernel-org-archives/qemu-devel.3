Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247F4C54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 04:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgGjH-0005LN-DS; Fri, 01 Mar 2024 23:12:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1S-0003ld-Fx
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:35 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1Q-0005gV-MV
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:34 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1dc1ff3ba1aso22794705ad.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334630; x=1709939430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yOzziF9HLP7qTKwq+TAQQdn75nn/2tGow/nkk/g/qYA=;
 b=n8qW/Vdj1XfxhQLXgkEuAxio9cY8kSswbik18Y10rA+9XKz9B1vWAA0dPCqRTkBQ/J
 p/gGl6hUEKTpy0iEkdx804Kjq+csG1xXNLYaFHEjzwOltU66/Kfay3/eEsCqrQAvQoKJ
 tTNYGeYkc00uKhxmuju9/MgUNX619ofhwZS6FuNCf6iv8S1B/uYB7Ee+IA25om/A8bdl
 s6NLhMgTSb2khGnvOBrP+RgxPD0KQ3FU3zYEhxxfErzfZV5M/3sRqqVA0skXDavGBSwv
 irS0I4LH1FR62AtjIQu6QeIVZncA1iZMlEoLkUD4dQc3SMs8KkLwvM1Xg/PIZfWf8p4Q
 /0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334630; x=1709939430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yOzziF9HLP7qTKwq+TAQQdn75nn/2tGow/nkk/g/qYA=;
 b=TcCNQOHIGGi15Upc4mfSjOmMhNbTaL6u3QzFSxiT6hPVHE2gOZPz+b7jDVQ3y/aCLp
 Hu7uWhMkoIuHUFtkuy9iU5IvtfGgxt0y+CRb9UkQ2YBOv9Qa4UFRqnMsYgZJtuWyv/dG
 OsvR+HusdLJUdZ558iohWzTV4Q5LkxpqBl86Rvk4UOc1n53m/2s+LL7zGeR+AwFHH2Cp
 4OgBr9cqZwsZxegEbH+ElmwyhgBFQqV8f2hRg1JKsssW2Eks8sniyFHVbzINOuAZBN+Q
 XrCgSAuoiOZaAvRdH+FKYQRlaoS6X8bPYHiA3ZmuSgo2vfIqBCHtH93zvWZEA4PbCg+0
 mdZA==
X-Gm-Message-State: AOJu0YyHQcHDgZqQAtmzhpj0ZxXwTB081jg+SFjrJ0W9VxXYCSNA2qah
 80IBS9TND95RFS6rTxOZ8vgjKn8ulbcGi5fSN63GjTyKTxQSrJpQdXlxSpJRv0EZttUMWWIrdBy
 J
X-Google-Smtp-Source: AGHT+IGoWY90DxlEftRhTYkzuJytqQj1OK/PetcWHXuMskTB+NlQVv1QXNDyOwWQAg83kh2XvcF7KA==
X-Received: by 2002:a17:90a:a606:b0:299:51db:33aa with SMTP id
 c6-20020a17090aa60600b0029951db33aamr3226010pjq.6.1709334630536; 
 Fri, 01 Mar 2024 15:10:30 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 c2-20020a634e02000000b005e438fe702dsm3449407pgb.65.2024.03.01.15.10.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:10:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 46/60] *-user: Deprecate and disable -p pagesize
Date: Fri,  1 Mar 2024 13:06:05 -1000
Message-Id: <20240301230619.661008-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This option controls the host page size.  From the mis-usage in
our own testsuite, this is easily confused with guest page size.

The only thing that occurs when changing the host page size is
that stuff breaks, because one cannot actually change the host
page size.  Therefore reject all but the no-op setting as part
of the deprecation process.

Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-27-richard.henderson@linaro.org>
---
 docs/about/deprecated.rst | 10 ++++++++++
 docs/user/main.rst        |  3 ---
 bsd-user/main.c           | 11 ++++++-----
 linux-user/main.c         | 12 ++++++------
 4 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 36bd3e15ef..8565644da6 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -63,6 +63,16 @@ as short-form boolean values, and passed to plugins as ``arg_name=on``.
 However, short-form booleans are deprecated and full explicit ``arg_name=on``
 form is preferred.
 
+User-mode emulator command line arguments
+-----------------------------------------
+
+``-p`` (since 9.0)
+''''''''''''''''''
+
+The ``-p`` option pretends to control the host page size.  However,
+it is not possible to change the host page size, and using the
+option only causes failures.
+
 QEMU Machine Protocol (QMP) commands
 ------------------------------------
 
diff --git a/docs/user/main.rst b/docs/user/main.rst
index 7e7ad07409..d5fbb78d3c 100644
--- a/docs/user/main.rst
+++ b/docs/user/main.rst
@@ -87,9 +87,6 @@ Debug options:
    Activate logging of the specified items (use '-d help' for a list of
    log items)
 
-``-p pagesize``
-   Act as if the host page size was 'pagesize' bytes
-
 ``-g port``
    Wait gdb connection to port
 
diff --git a/bsd-user/main.c b/bsd-user/main.c
index e5efb7b845..6ab3efd6c0 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -364,11 +364,12 @@ int main(int argc, char **argv)
         } else if (!strcmp(r, "L")) {
             interp_prefix = argv[optind++];
         } else if (!strcmp(r, "p")) {
-            qemu_host_page_size = atoi(argv[optind++]);
-            if (qemu_host_page_size == 0 ||
-                (qemu_host_page_size & (qemu_host_page_size - 1)) != 0) {
-                fprintf(stderr, "page size must be a power of two\n");
-                exit(1);
+            unsigned size, want = qemu_real_host_page_size();
+
+            r = argv[optind++];
+            if (qemu_strtoui(r, NULL, 10, &size) || size != want) {
+                warn_report("Deprecated page size option cannot "
+                            "change host page size (%u)", want);
             }
         } else if (!strcmp(r, "g")) {
             gdbstub = g_strdup(argv[optind++]);
diff --git a/linux-user/main.c b/linux-user/main.c
index e540acb84a..bad03f06d3 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -332,11 +332,11 @@ static void handle_arg_ld_prefix(const char *arg)
 
 static void handle_arg_pagesize(const char *arg)
 {
-    qemu_host_page_size = atoi(arg);
-    if (qemu_host_page_size == 0 ||
-        (qemu_host_page_size & (qemu_host_page_size - 1)) != 0) {
-        fprintf(stderr, "page size must be a power of two\n");
-        exit(EXIT_FAILURE);
+    unsigned size, want = qemu_real_host_page_size();
+
+    if (qemu_strtoui(arg, NULL, 10, &size) || size != want) {
+        warn_report("Deprecated page size option cannot "
+                    "change host page size (%u)", want);
     }
 }
 
@@ -496,7 +496,7 @@ static const struct qemu_argument arg_table[] = {
     {"D",          "QEMU_LOG_FILENAME", true, handle_arg_log_filename,
      "logfile",     "write logs to 'logfile' (default stderr)"},
     {"p",          "QEMU_PAGESIZE",    true,  handle_arg_pagesize,
-     "pagesize",   "set the host page size to 'pagesize'"},
+     "pagesize",   "deprecated change to host page size"},
     {"one-insn-per-tb",
                    "QEMU_ONE_INSN_PER_TB",  false, handle_arg_one_insn_per_tb,
      "",           "run with one guest instruction per emulated TB"},
-- 
2.34.1


