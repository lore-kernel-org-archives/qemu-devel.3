Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A46C54798
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 01:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdgTo-0006FL-Lq; Fri, 23 Feb 2024 20:05:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdgTl-0006El-Qm
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 20:05:26 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdgTk-0006qV-5J
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 20:05:25 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e46b5e7c43so589488b3a.2
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 17:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708736722; x=1709341522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xfZZqsebUHyUVLONNyqFeLCKzRlol9H6yrC5xBxB6h0=;
 b=xfN+vP47w542nj7U7ySVg+ZwYyKT234mFOMWOuyKaHdhcTuKe4WhoWeu+ZVMU5KJRy
 bVIW2HLmgx7jVguSpobKPy0LMIg+Od3RrCwp+hKpF6qr9aS6fhzkXd9hbk/gI9GMjuap
 W/0Nyoy+1eiv4u+VqIDfAPE2pDmddjpfw0cx0xnNlDsdolCvIQQAPEu9tWnVQ2u7aQxD
 0pB4wCTMfp1NFOPpGLx3pQnleYYFPUFLd0NrVaQPvmWGg74m9OIEtyT9zVpoIeS0XSbd
 6wh1BA39/shGUwR9G76HQGtBzdkT0hKVglEctPgR/cgCS/BNe1qq/ZOGJ8oD5PdZhVUb
 SVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708736722; x=1709341522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xfZZqsebUHyUVLONNyqFeLCKzRlol9H6yrC5xBxB6h0=;
 b=SbqMWMa2okA5gtngJ/2Lk3hVa4z90PtYSmFZT/dxavZaHh0E0w5dRJmoU3HiOtlBo4
 +6gV4Ycbz/DvNw5G75I/jom8oTZLzAi3C8+zB+gcltVq5akWTtzvtxfRXEcMK/Dj8152
 6bkgAVT7KE1h3AbqpQTXZTej6jhtA2DoWrUmoCVdCtTDDFv2d/1XEd0jjEQccdAVHK7A
 Nj5E/oFKO9sSUy+lRr414M2c1aaZSvyWPvWTvOs/TQe3zdW8sH2qJOKzGXm0fzCpNcpT
 Q+dUWTFweqgOaSpjKifWvWTOVZvwm5zxoQGbVVb7/7iL5XhhQG65kM6u5NXeFhq/gHeF
 t5YQ==
X-Gm-Message-State: AOJu0Yz+iM6qsyulsB5TN2ZkCv/Alt4/pG6qd/E6vBBpyBGHD8DRsRam
 E+iT8fUXu8NYn7qiKY8ImRoW9m8zF2MuwnEwSHPBUQBs2be6Gkxh/XbEYSFFTFgm5s+LsViv2LF
 c
X-Google-Smtp-Source: AGHT+IGd+Mbe0pZO4QS/37LvPQ7jfS3B2OFDATPqnUAlgOaBExmecKAXytvFI8Gwmb/3CiyJO9scYg==
X-Received: by 2002:aa7:9a1d:0:b0:6e4:8793:61ff with SMTP id
 w29-20020aa79a1d000000b006e4879361ffmr1342628pfj.32.1708736722374; 
 Fri, 23 Feb 2024 17:05:22 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a62e311000000b006ddc7ed6edfsm93513pfh.51.2024.02.23.17.05.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 17:05:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PULL v2 31/39] *-user: Deprecate and disable -p pagesize
Date: Fri, 23 Feb 2024 15:05:16 -1000
Message-Id: <20240224010517.619640-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240224010517.619640-1-richard.henderson@linaro.org>
References: <20240224010517.619640-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
index 5a2305ccd6..3074303b9c 100644
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


