Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135A1C27C65
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 04:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFRB4-0004mc-3R; Fri, 07 Jun 2024 00:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sFRAw-0004l0-JT
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 00:26:04 -0400
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sFRAu-00051Q-Ts
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 00:26:02 -0400
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3748d68b713so6912055ab.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 21:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1717734359; x=1718339159;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e+E8YdlwBZo6utgAOnWf5bK8eXZtaIP4XDr+Yf1pIjg=;
 b=LaVZ/IABIW32bfoBKkT16T29k2jugDXPH2HWoKpJnGjC0v9TNVP4eYpwDf5zc+O1ZE
 vy3D7ku/deddRslkXOOFo33+1PUrSdWInz5eG+4pqrb6b1XPldanUIepAZiFmf4en7MG
 1KPLYX418D5iBdEhDPkpBAf3Q/msdCxGC/t038teNCsUDKexoZzdtsVJaQzhIxbzro66
 CVKEeiMSJHvLssYlyMW/lPF+r6ZnQQsPmN93OM2RGuZf44Su9VxH8pRQ2AaKn21B43RP
 ZKsS8cBn0TKIvtZ7YA4BjQcr2eqzaJJKhBL4IKjqdr5P/SQBskWTuzIi4QMTaWA38wh6
 4zcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717734359; x=1718339159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e+E8YdlwBZo6utgAOnWf5bK8eXZtaIP4XDr+Yf1pIjg=;
 b=PzdYHn53MgbhovkEF5ZiorgTfGf5/04o31QniQbDNk+a9cGHP4w7qEmkK7osoAeuEV
 uiHv7Bs4RVv7YtZsTCSk/8rcsGZ9fALgvAP7DmvUxappNN/aT8+7EGuXwOC/xU1mYAdW
 aga1oUOjrfJq7wh77GiyV/V4sgl8xy6ldyJIbaDfbgyh6kuYXPbsny97ObH44ThdTKgi
 rZqXnSXURya8yANV6yFfsxcfFmCdbmZbVvPpQo2EksGePUtri5WGGPnbOQmnKQv8tO4T
 eDeoxPkcmkojaGxGYAQjTqfoXZqRpAn339NjoRTLG+bw8ibBKs9vvh5ckl6vdZWz7kIR
 sm8A==
X-Gm-Message-State: AOJu0YxKRtWZ6l3zqZBB/2TWSlFtT4kQaM85OwrstJoHgvZQphFmlw92
 5gH1NjMA2u00/5SbdwlMOF5mpT5gMYjURqGEdCImSItjgZOnL/rNEIrd60aCaWY580r0sTY5/1D
 Yfzg=
X-Google-Smtp-Source: AGHT+IGW1966wtxuskI4e/9BuhuG1QlxDl+dGxHBJWO4tqdRYVUvC5/IuumJlyFx3Q/NEuIR/n1Pmw==
X-Received: by 2002:a92:c569:0:b0:374:5a2d:178 with SMTP id
 e9e14a558f8ab-3758030a2fdmr18999515ab.2.1717734358912; 
 Thu, 06 Jun 2024 21:25:58 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-374bc15d9d9sm6162585ab.37.2024.06.06.21.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 21:25:57 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>
Subject: [PATCH 3/3] bsd-user: Catch up to run-time reserved_va math
Date: Thu,  6 Jun 2024 22:25:03 -0600
Message-ID: <20240607042503.25222-4-imp@bsdimp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240607042503.25222-1-imp@bsdimp.com>
References: <20240607042503.25222-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::12d;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x12d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Catch up to linux-user's 8f67b9c694d0, 13c13397556a, 2f7828b57293, and
95059f9c313a by Richard Henderson which made reserved_va a run-time
calculation, defaulting to nothing except in the case of 64-bit host
32-bit target. Also include the adjustment of the comment heading that
work submitted in the same patch stream. Since this is a direct copy,
squash it into one patch rather than follow the Linux evolution since
breaking this down further at this point doesn't make sense for this
"new code".

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/main.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index d685734d087..dcad266c2c9 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -77,25 +77,16 @@ bool have_guest_base;
 # if HOST_LONG_BITS > TARGET_VIRT_ADDR_SPACE_BITS
 #  if TARGET_VIRT_ADDR_SPACE_BITS == 32 && \
       (TARGET_LONG_BITS == 32 || defined(TARGET_ABI32))
-#   define MAX_RESERVED_VA  0xfffffffful
+#   define MAX_RESERVED_VA(CPU)  0xfffffffful
 #  else
-#   define MAX_RESERVED_VA  ((1ul << TARGET_VIRT_ADDR_SPACE_BITS) - 1)
+#   define MAX_RESERVED_VA(CPU)  ((1ul << TARGET_VIRT_ADDR_SPACE_BITS) - 1)
 #  endif
 # else
-#  define MAX_RESERVED_VA  0
+#  define MAX_RESERVED_VA(CPU)  0
 # endif
 #endif
 
-/*
- * That said, reserving *too* much vm space via mmap can run into problems
- * with rlimits, oom due to page table creation, etc.  We will still try it,
- * if directed by the command-line option, but not by default.
- */
-#if HOST_LONG_BITS == 64 && TARGET_VIRT_ADDR_SPACE_BITS <= 32
-unsigned long reserved_va = MAX_RESERVED_VA;
-#else
 unsigned long reserved_va;
-#endif
 
 const char *interp_prefix = CONFIG_QEMU_INTERP_PREFIX;
 const char *qemu_uname_release;
@@ -293,6 +284,7 @@ int main(int argc, char **argv)
     envlist_t *envlist = NULL;
     char *argv0 = NULL;
     int host_page_size;
+    unsigned long max_reserved_va;
 
     adjust_ssize();
 
@@ -493,6 +485,29 @@ int main(int argc, char **argv)
     cpu_reset(cpu);
     thread_cpu = cpu;
 
+    /*
+     * Reserving too much vm space via mmap can run into problems with rlimits,
+     * oom due to page table creation, etc.  We will still try it, if directed
+     * by the command-line option, but not by default. Unless we're running a
+     * target address space of 32 or fewer bits on a host with 64 bits.
+     */
+    max_reserved_va = MAX_RESERVED_VA(cpu);
+    if (reserved_va != 0) {
+        if ((reserved_va + 1) % host_page_size) {
+            char *s = size_to_str(host_page_size);
+            fprintf(stderr, "Reserved virtual address not aligned mod %s\n", s);
+            g_free(s);
+            exit(EXIT_FAILURE);
+        }
+        if (max_reserved_va && reserved_va > max_reserved_va) {
+            fprintf(stderr, "Reserved virtual address too big\n");
+            exit(EXIT_FAILURE);
+        }
+    } else if (HOST_LONG_BITS == 64 && TARGET_VIRT_ADDR_SPACE_BITS <= 32) {
+        /* MAX_RESERVED_VA + 1 is a large power of 2, so is aligned. */
+        reserved_va = max_reserved_va;
+    }
+
     if (getenv("QEMU_STRACE")) {
         do_strace = 1;
     }
-- 
2.43.0


