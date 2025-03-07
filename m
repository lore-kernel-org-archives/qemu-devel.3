Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 654F7C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 13:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqXTL-0002q7-QJ; Fri, 07 Mar 2025 08:10:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqXSv-0002oZ-60
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 08:10:13 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqXSr-0001TW-K6
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 08:10:11 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-39127512371so1125405f8f.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 05:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741353007; x=1741957807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lNWRd/3bpDqDY9go9fwbBzHVlSOjDlQlmHNSNyWLCFQ=;
 b=yUdeLq3jnlkWZlltyx+pXnhbgeqqqF/saWeRbJtV9pF+77cyt9R1Uj6d5xMNk0GOB4
 Td28VjoDk99fQRSg2LVQNr8wyEJR/6ALXc2CBcMIsWLqA6w1d0YveGgCoQKf5SlgEb1G
 M9gtY8NXvqdqrALyFZdL7jsAdNw0yz28QOuVDCHr+ThnNxkSHGSeODn8aKS8Rl9BwmBf
 3TdG2P1CBxt5pCm1vZmjcEBl6BsN/ZYl9suhe6nUhDlFHmziz7dnhjK3v+et/vszgRUW
 Kgw3lNsbTaijt3rQ1adAV0Gz1OJI9hvdMj67f9sV0/5gfAY1bZgsW5QP1Z9B259LE0HM
 HstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741353007; x=1741957807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lNWRd/3bpDqDY9go9fwbBzHVlSOjDlQlmHNSNyWLCFQ=;
 b=PUVzD2rWgvUdpVWg3TcGeQess1Y0ipyZuiUKmfkz+jPqldlUXwcKVX4oC4vle0nWdT
 NEaO6iDCnhitfIJ7/ruuU2LrxnF7tOwHBrJ7vLd2pnAhxSYZvDD/TWgAnzhSoAyxUW42
 nNrJCIVecVv6hN5Vs5cz6329SzI6+81es6FsyQXz3wGxK0XAtbQGIX0wzf2o/vTjoQsv
 Z71f265zXFmBie4DGUjxP2Wl9AX4rQTVkVsdo2k1bvCwtaCFpoLHInfl2EHo8fWFY2GG
 cnp32nPzHRidf94QWglGw2sLSMasp7WqqtgAxCjyxoPvv1gOiJhsdlmYNqql4zJH24U4
 Mn0w==
X-Gm-Message-State: AOJu0Yw92A2E8Mhg1zqw0GyU9N4hy0Do1zviP0vAkKOu7wdYcsXEug/H
 ZiNb8yzT1pXA9zERxidXkaVSehHH9CKH0hU3hdTbEaUkNGz5xZbJ/dUxOsW48DtRks07yIk7Fgc
 BClw=
X-Gm-Gg: ASbGncvrWUyeXEzUjEx8OnkwjgMnpsZ7po2krcNW8TaoZWuWx/JYFsezwHlU8Tsa1eT
 DNDKVsrS40pxWVS+DBHzNaCRSV6z2C/gUJGsTorVkAQJERamoP0jGU600R2rHOQX5GoH/0lvejN
 UItcxBs5eR7HGrPWZBHXJBkDkLv43RmNK94ZRtO6GJusuVzPv7Zrs1pRY2qRsa2W9lOdvemGb7b
 AiDmu+B1TMix7Qn2Qe2C0yyZHlez2b+qEGqXgHa3thA0pp/h34X+pFzrnRjgCDxXewTt+t7A4Pv
 9OUJqTYS6PGNX8NElKxHHJk6H02EAYL5P+UM3tw42kodAoJHMcJP8HzQiFLJU+ezvk25bAmcgdV
 xlRfnqBuNmDzk3/Az/ck=
X-Google-Smtp-Source: AGHT+IEPVIFMKocCD3jCPYbRF/oYb0vgNWSBKX8TUtvoqF/C4a8ingzOxsi1FbRQFHjURUZIE7JJRA==
X-Received: by 2002:a5d:584e:0:b0:38d:cf33:31d6 with SMTP id
 ffacd0b85a97d-39132d68426mr2062622f8f.3.1741353006878; 
 Fri, 07 Mar 2025 05:10:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd42c5880sm80124445e9.19.2025.03.07.05.10.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 05:10:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 3/3] user: Extract common MMAP API to 'user/mmap.h'
Date: Fri,  7 Mar 2025 14:09:51 +0100
Message-ID: <20250307130951.4816-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307130951.4816-1-philmd@linaro.org>
References: <20250307130951.4816-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Keep common MMAP-related declarations in a single place.

Note, this disable ThreadSafetyAnalysis on Linux for:
- mmap_fork_start()
- mmap_fork_end().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/qemu.h        | 12 +-----------
 include/user/mmap.h    | 32 ++++++++++++++++++++++++++++++++
 linux-user/user-mmap.h | 19 ++-----------------
 3 files changed, 35 insertions(+), 28 deletions(-)
 create mode 100644 include/user/mmap.h

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 0b3bd65b180..c1c508281a8 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -32,6 +32,7 @@
 extern char **environ;
 
 #include "user/thunk.h"
+#include "user/mmap.h"
 #include "target_arch.h"
 #include "syscall_defs.h"
 #include "target_syscall.h"
@@ -233,19 +234,8 @@ void print_taken_signal(int target_signum, const target_siginfo_t *tinfo);
 extern int do_strace;
 
 /* mmap.c */
-int target_mprotect(abi_ulong start, abi_ulong len, int prot);
-abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
-                     int flags, int fd, off_t offset);
-int target_munmap(abi_ulong start, abi_ulong len);
-abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
-                       abi_ulong new_size, unsigned long flags,
-                       abi_ulong new_addr);
 int target_msync(abi_ulong start, abi_ulong len, int flags);
-extern abi_ulong mmap_next_start;
-abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong alignment);
 void mmap_reserve(abi_ulong start, abi_ulong size);
-void TSA_NO_TSA mmap_fork_start(void);
-void TSA_NO_TSA mmap_fork_end(int child);
 
 /* main.c */
 extern char qemu_proc_pathname[];
diff --git a/include/user/mmap.h b/include/user/mmap.h
new file mode 100644
index 00000000000..4d5e9aac70a
--- /dev/null
+++ b/include/user/mmap.h
@@ -0,0 +1,32 @@
+/*
+ * MMAP declarations for QEMU user emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef USER_MMAP_H
+#define USER_MMAP_H
+
+#include "user/abitypes.h"
+
+/*
+ * mmap_next_start: The base address for the next mmap without hint,
+ * increased after each successful map, starting at task_unmapped_base.
+ * This is an optimization within QEMU and not part of ADDR_COMPAT_LAYOUT.
+ */
+extern abi_ulong mmap_next_start;
+
+int target_mprotect(abi_ulong start, abi_ulong len, int prot);
+
+abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
+                     int flags, int fd, off_t offset);
+int target_munmap(abi_ulong start, abi_ulong len);
+abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
+                       abi_ulong new_size, unsigned long flags,
+                       abi_ulong new_addr);
+
+abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong alignment);
+
+void TSA_NO_TSA mmap_fork_start(void);
+void TSA_NO_TSA mmap_fork_end(int child);
+
+#endif
diff --git a/linux-user/user-mmap.h b/linux-user/user-mmap.h
index b94bcdcf83c..dfc4477a720 100644
--- a/linux-user/user-mmap.h
+++ b/linux-user/user-mmap.h
@@ -18,6 +18,8 @@
 #ifndef LINUX_USER_USER_MMAP_H
 #define LINUX_USER_USER_MMAP_H
 
+#include "user/mmap.h"
+
 /*
  * Guest parameters for the ADDR_COMPAT_LAYOUT personality
  * (at present this is the only layout supported by QEMU).
@@ -39,24 +41,7 @@
 extern abi_ulong task_unmapped_base;
 extern abi_ulong elf_et_dyn_base;
 
-/*
- * mmap_next_start: The base address for the next mmap without hint,
- * increased after each successful map, starting at task_unmapped_base.
- * This is an optimization within QEMU and not part of ADDR_COMPAT_LAYOUT.
- */
-extern abi_ulong mmap_next_start;
-
-int target_mprotect(abi_ulong start, abi_ulong len, int prot);
-abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
-                     int flags, int fd, off_t offset);
-int target_munmap(abi_ulong start, abi_ulong len);
-abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
-                       abi_ulong new_size, unsigned long flags,
-                       abi_ulong new_addr);
 abi_long target_madvise(abi_ulong start, abi_ulong len_in, int advice);
-abi_ulong mmap_find_vma(abi_ulong, abi_ulong, abi_ulong);
-void mmap_fork_start(void);
-void mmap_fork_end(int child);
 
 abi_ulong target_shmat(CPUArchState *cpu_env, int shmid,
                        abi_ulong shmaddr, int shmflg);
-- 
2.47.1


