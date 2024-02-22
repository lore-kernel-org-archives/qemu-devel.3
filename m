Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B59D8C5478C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 20:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdFva-0008Ay-IT; Thu, 22 Feb 2024 15:44:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFvZ-00088o-6J
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:44:21 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFvX-0002nk-Ln
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:44:20 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d51ba18e1bso2648285ad.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 12:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708634658; x=1709239458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iM2DWBTbIODm0qN2yhX9D3hAXXDtYwow0kqtsMcFoQE=;
 b=VurPbK1AbyR8HxdE5lor0PPsWgTMf+77WjbJQAKxVmnsOZ8tsDK0c2riN0yar3NTVa
 /tIBpakzQwPJjgEkHQwEnWh+4NCReswMRlK3I8A2wuobUheLcnF+8a6V/20jB41uv3mJ
 msf1i9kzBmlI5OlcbPsEYjla3GQTH9TCE012LUkkEOyfPgHdGX6nNknwYB3BkzqSlSrE
 1Iqy6M37sUMKdgcS5DUBFoezem7bBRYNNwYjqiRq/0ZwEIZ+jgR0QRSYx+xoGWdxVZDg
 jUn0t0giIMhq8WuyzjKHnca8V9GRgZGItheEQ4dfbKGK2gjdUPiyzHy1FZ2rYkrP/FNY
 dj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708634658; x=1709239458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iM2DWBTbIODm0qN2yhX9D3hAXXDtYwow0kqtsMcFoQE=;
 b=LBELrP/K9qDB+3VxUp8rQYQ45uRwrUbidXvTRwNUblHSxWTjcE7qAavED/OgY3D0O8
 SGK2s/oh2Cz3b8Kul5l+LsOB6jLA8HEiwmQTJVnLxGDweR6L0yLZ9XqQ/ge1gkXfdDYs
 0JCiZtTxPp2yt8XRE+b61KZmuQohTD2sUB9z87tpy9AXCH7dJmqJFw4p2P8mUBVGq/DZ
 3WppPh7cWa1cCujxl3I79C2s18YqZ0F4Icun/g8V9C0bpVvizb8G3wo4Dnrh76G/H5+l
 Ayd13sLYOkhEClfJG9IJY27Zn4aO/H/uwtvgq+n5zQ4J9xaAMqHiRcO/KmtrkfNK93RT
 FKWw==
X-Gm-Message-State: AOJu0Yw0FBZLGzEq03NTPwWGnk+QPyNZ6a3r0Z2jUn3ZJLgl3WcVd5vC
 /p8SS7rhW5A60bPWTce3C6BjNNza81TE98h1RnQIs6bUW7YZwowBl8iK99/ZUvBGfKDtbVa24TZ
 o
X-Google-Smtp-Source: AGHT+IG06JrflUAQqv79rhFaLmJaLmi6UpqZx3lE75149ZTqxcXgRF/X2cpbYEMlac+PUPuLyMHCOw==
X-Received: by 2002:a17:902:6b04:b0:1dc:5d2e:c18c with SMTP id
 o4-20020a1709026b0400b001dc5d2ec18cmr1608170plk.67.1708634658496; 
 Thu, 22 Feb 2024 12:44:18 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001d8f81ecebesm10275500plk.192.2024.02.22.12.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 12:44:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 34/39] linux-user: Allow TARGET_PAGE_BITS_VARY
Date: Thu, 22 Feb 2024 10:43:18 -1000
Message-Id: <20240222204323.268539-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222204323.268539-1-richard.henderson@linaro.org>
References: <20240222204323.268539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

If set, match the host and guest page sizes.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-30-richard.henderson@linaro.org>
---
 linux-user/main.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index bad03f06d3..12bb839982 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -55,6 +55,7 @@
 #include "loader.h"
 #include "user-mmap.h"
 #include "tcg/perf.h"
+#include "exec/page-vary.h"
 
 #ifdef CONFIG_SEMIHOSTING
 #include "semihosting/semihost.h"
@@ -680,6 +681,7 @@ int main(int argc, char **argv, char **envp)
     int i;
     int ret;
     int execfd;
+    int host_page_size;
     unsigned long max_reserved_va;
     bool preserve_argv0;
 
@@ -791,6 +793,16 @@ int main(int argc, char **argv, char **envp)
                                  opt_one_insn_per_tb, &error_abort);
         ac->init_machine(NULL);
     }
+
+    /*
+     * Finalize page size before creating CPUs.
+     * This will do nothing if !TARGET_PAGE_BITS_VARY.
+     * The most efficient setting is to match the host.
+     */
+    host_page_size = qemu_real_host_page_size();
+    set_preferred_target_page_bits(ctz32(host_page_size));
+    finalize_target_page_bits();
+
     cpu = cpu_create(cpu_type);
     env = cpu_env(cpu);
     cpu_reset(cpu);
@@ -804,8 +816,6 @@ int main(int argc, char **argv, char **envp)
      */
     max_reserved_va = MAX_RESERVED_VA(cpu);
     if (reserved_va != 0) {
-        int host_page_size = qemu_real_host_page_size();
-
         if ((reserved_va + 1) % host_page_size) {
             char *s = size_to_str(host_page_size);
             fprintf(stderr, "Reserved virtual address not aligned mod %s\n", s);
@@ -904,7 +914,7 @@ int main(int argc, char **argv, char **envp)
      * If we're in a chroot with no /proc, fall back to 1 page.
      */
     if (mmap_min_addr == 0) {
-        mmap_min_addr = qemu_real_host_page_size();
+        mmap_min_addr = host_page_size;
         qemu_log_mask(CPU_LOG_PAGE,
                       "host mmap_min_addr=0x%lx (fallback)\n",
                       mmap_min_addr);
-- 
2.34.1


