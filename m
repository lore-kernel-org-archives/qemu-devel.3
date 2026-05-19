Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4A1CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 17:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPO0J-0000cT-KW; Tue, 19 May 2026 13:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPO0H-0000ao-19
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:13:13 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPO0E-0007Op-BR
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:13:12 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48e8132c6d0so25667835e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 10:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779210784; x=1779815584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XCEJ6qDdNbwTKvqImY9OH3y5ocoLUF7QvLyzezwoPI4=;
 b=YNWbp4JxKB4WdaehVrQZorUElViTve7mh0bAQIiDfJSdqwgUBz6mEiTUegpONnARRR
 KlbY7A7KcdNNvOJS3zKtETb+gwM1Bi9lUH+9WPb6mY8E156KujyloLB10wz45fapw7D/
 /q3iQEZX9V+3Ci3FQWc+3V0P2adEvrW9u5r4JjTK+9X4/v9nUl3JpCySaY+1KdNVE4Vc
 Vy3X4imuDXRMQCjTCU/kn8HPy5H0INrskxa80H23fNEvr9w/VSCMKc9AT/R+60SV9sCW
 8AfXNwCdSxW88+JZU+77518zM4z7tApMmU4sJG5cGagC7WMVuDv2kC833wYGExmWFElS
 oCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779210784; x=1779815584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XCEJ6qDdNbwTKvqImY9OH3y5ocoLUF7QvLyzezwoPI4=;
 b=Eweu1HuFiNYVNGJk78rKNztJSxb8OdnkjThYnfZkrOVxX4+CaGWyWbMTMEcmLjHBY6
 J6skEETweMwWfoFHhdvvfYpyIMKwJuKQTxCAIWHjqjhtaa7FtUAJceyAxO3LDFdqJzfy
 cLQMW9IV9G8Qc7jggdbqUdNuT7rZlUjxRTiR0791Mtab6xhfRbo4+DM0HsXTHAsBRMpW
 7vtzVCTHQTsXmJZLYfe3v5FZRa/6x2Ms+gTz5Alp8PZDcACPvW6YIIpbaT+e9xIGNbRq
 B7gjObEBi5pzD3nz1b/272W94CQN+XNBPBzTs3zetrFJo7GRtIT/adtoKrQPA4HTgiD4
 QcrQ==
X-Gm-Message-State: AOJu0YzI8aDkbya9aLCNP5f0Oqz2tvW+XjQVr+k1YQVvXrq3MTJhydPv
 EhHv2n8GXxMer7TcEs4FcvcKmbYaEygE87jOhkTG+0GFaxifOpc8SHrUYJ9RA7RPhO7umC//0C6
 Dex/DGwA=
X-Gm-Gg: Acq92OFpPNY4w7TYkItmUkSNRe/i47uv8jUDeS2S4aQc2PhgWLPallyrACNBmHEUkV0
 yRGP1q0lcCErpKWQhjUYDKKCA7fJRqOocw7/eZwoMp02QbXTJBx/viRsSvXPSmrnaaaeIFqWbHc
 fLv4HQB3S9tfl25FZvIt73osp+t/DbCDzX3asXGfwkdpsxkc/BaMu6BstvWnGv1GXUbfLHi4Uz0
 lxC153ujAaj+cev9qtp+UfSFS5chKO7QXpe3cjNowX/0YmZIt9tj9vKv7zZr6M4Cwv/SJe07avr
 mmh0B/kASE7Ul42apAeFicr1ZJpv3WQK35+sLpo4j+bpOX1psz7s38wm1nSrsCe96c7n/9FhPpy
 5dmCp3obQq5H5mZgE3nKdpy762/gQkhuuSk5HLvSMNgJTBk74TdsKQN/24YSFb6JjJuEaZzxE3K
 ubHL8o4j7lB/pTG6sBTn6mLMhwgUwi87QpiG5ROhrbsWa+yZbbcTU8/GXfL+kkAE/jWRHx12L+m
 F1XNXKX0kCfkxnEyqencQ==
X-Received: by 2002:a05:600c:3f0a:b0:48e:82af:d9 with SMTP id
 5b1f17b1804b1-48fe6612a59mr323653355e9.29.1779210784404; 
 Tue, 19 May 2026 10:13:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe6afe7sm106855245e9.24.2026.05.19.10.13.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 May 2026 10:13:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org
Subject: [PATCH v2 3/4] buildsys: Stop checking for ESA/390 host
Date: Tue, 19 May 2026 19:12:39 +0200
Message-ID: <20260519171240.97420-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519171240.97420-1-philmd@linaro.org>
References: <20260519171240.97420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We still build QEMU tools on 32-bit hosts (see commit
cf634dfcd8f), however no OS supported by QEMU still runs
on ESA/390 (Linux dropped support in release 4.1 in 2015).

Remove the configure check, directly checking for the 64-bit
z/Architecture.

Also per commit 3704993f545 from 2020:

  "we don't support s390, only 64-bit s390x hosts".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configure                 | 12 ++----------
 include/qemu/cacheflush.h |  2 +-
 include/qemu/timer.h      |  2 +-
 block/file-posix.c        |  2 +-
 disas/disas-host.c        |  2 +-
 util/cacheflush.c         |  2 +-
 6 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/configure b/configure
index eea90306728..513ef7a153d 100755
--- a/configure
+++ b/configure
@@ -401,12 +401,8 @@ elif check_define _ARCH_PPC64 ; then
   fi
 elif check_define __mips64 ; then
   cpu="mips64"
-elif check_define __s390__ ; then
-  if check_define __s390x__ ; then
-    cpu="s390x"
-  else
-    cpu="s390"
-  fi
+elif check_define __s390x__ ; then
+  cpu="s390x"
 elif check_define __riscv && check_define _LP64 ; then
   cpu="riscv64"
 elif check_define __aarch64__ ; then
@@ -469,10 +465,6 @@ case "$cpu" in
     linux_arch=riscv
     ;;
 
-  s390)
-    linux_arch=s390
-    CPU_CFLAGS="-m31"
-    ;;
   s390x)
     host_arch=s390x
     linux_arch=s390
diff --git a/include/qemu/cacheflush.h b/include/qemu/cacheflush.h
index 8c64b878145..0618966ddde 100644
--- a/include/qemu/cacheflush.h
+++ b/include/qemu/cacheflush.h
@@ -19,7 +19,7 @@
  * mappings of the same physical page(s).
  */
 
-#if defined(__x86_64__) || defined(__s390__)
+#if defined(__x86_64__) || defined(__s390x__)
 
 static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
 {
diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index b931181f53d..fc021f8f966 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -889,7 +889,7 @@ static inline int64_t cpu_get_host_ticks(void)
     return val;
 }
 
-#elif defined(__s390__)
+#elif defined(__s390x__)
 
 static inline int64_t cpu_get_host_ticks(void)
 {
diff --git a/block/file-posix.c b/block/file-posix.c
index e49b13d6abb..5019ddade9b 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -79,7 +79,7 @@
 #include <linux/hdreg.h>
 #include <linux/magic.h>
 #include <scsi/sg.h>
-#ifdef __s390__
+#ifdef __s390x__
 #include <asm/dasd.h>
 #endif
 #ifndef FS_NOCOW_FL
diff --git a/disas/disas-host.c b/disas/disas-host.c
index 7cf432938e0..d41235250a0 100644
--- a/disas/disas-host.c
+++ b/disas/disas-host.c
@@ -74,7 +74,7 @@ static void initialize_debug_host(CPUDebug *s)
     s->info.print_insn = print_insn_little_mips;
 #elif defined(__m68k__)
     s->info.print_insn = print_insn_m68k;
-#elif defined(__s390__)
+#elif defined(__s390x__)
     s->info.cap_arch = CS_ARCH_SYSZ;
     s->info.cap_insn_unit = 2;
     s->info.cap_insn_split = 6;
diff --git a/util/cacheflush.c b/util/cacheflush.c
index c043c5f881a..77440ddb478 100644
--- a/util/cacheflush.c
+++ b/util/cacheflush.c
@@ -223,7 +223,7 @@ static void __attribute__((constructor)) init_cache_info(void)
  * Architecture (+ OS) specific cache flushing mechanisms.
  */
 
-#if defined(__x86_64__) || defined(__s390__)
+#if defined(__x86_64__) || defined(__s390x__)
 
 /* Caches are coherent and do not require flushing; symbol inline. */
 
-- 
2.53.0


