Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6C7E7AD62
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Dec 2025 18:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYqCl-0002Qa-92; Thu, 25 Dec 2025 13:36:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1vYqCj-0002QN-Fr
 for qemu-devel@nongnu.org; Thu, 25 Dec 2025 13:36:53 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1vYqCh-0001HZ-Oi
 for qemu-devel@nongnu.org; Thu, 25 Dec 2025 13:36:53 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-477563e28a3so41807545e9.1
 for <qemu-devel@nongnu.org>; Thu, 25 Dec 2025 10:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766687809; x=1767292609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0CEF0zBQOnUjFMdWcjPG1Oj/0FI36VszIcd67or6R58=;
 b=CwxUC2Z9NJxinO/vwcWYI36PltCXVT0FFHDC5BkZXfYgsu724qmqHx0LwgfWtWeHgO
 J0zakaQDFtjDOy8PVtVw4O/aVTHiiwTg6LCcwFc2ldjj38xfbZglr2UhSEe7ZRZOGprJ
 FhB7Fr0e9b6yhZO+R5irV1S2OJnSxR2gkQn8XSfjs3UMLKqCktex71PJ03+28vjB/xJO
 BWKV09/RcTDUnj2SO2lvaRpvviWf1jPPjnU5L+V2552yddgWXmUnm3jvT04jRaKF+IVv
 LsFQmKZLE6b4Fl4Du1xBWgUl4ue9A3rSvsAKmd3DqzvzuHG+2lskH41tGz27ZrKX8gHg
 NvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766687809; x=1767292609;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0CEF0zBQOnUjFMdWcjPG1Oj/0FI36VszIcd67or6R58=;
 b=jcL7ZwEVrBYLiKUewzusXyHBugEbjh30C+pZ3ybcjC60WsQ4NBdj6epLN5PJuMHO3r
 jf/KlaSqic7GWd9ULhRHb5RdCRNXSNFdPb6vIf3cKbMXaiPg6/HkmNoNvQmDBVl4BQik
 ZZfkWVCPcSVaYBfhsNo6PyYb5QT3I76GQBtfaYoQWUXreMGiR28s9V8KfyGVq0Dbo5PO
 roNQqspJYthR/b5NOMYdTNH8CngGT5bFBOl4Pg6GAAJBX2549AQXlaeXMX8YV1EsQTAf
 brAVZFYt4s9lp9KhS8oECeS5fmhWQfDuPyVelU9Q7iefEv9tH+wxR6eanLsINpDYEGIi
 OVeQ==
X-Gm-Message-State: AOJu0Yzk4opS1J+KNTY27suIeYPSp/RKCyWdPjQ4xAIDB4Xb1WLzmyp4
 KS65MjF4jN2bZbtVqpHcuVkDy8vYgeersUekuOIU/0XQ9HH6BQRINqqCYjK9WCZz
X-Gm-Gg: AY/fxX72NRjd9jS+7o0NrU6KK0GNkmJlhuzADqXPitBjXbCG+srTVHj9iHIOcWNNBdW
 xJD3z98uSqBGWtY55kFVtgmUtxOQGi9M8g6Azn2jNNEsGWJ9anE6w8k6sRuUoxEjClYYZeoSej1
 n+vLr3UQ36zmVsz6E++EaFBsJikYiqVq0f+9gO0kQorDe3JXy/5+TL6/EI4MBSquLHd4KODjZxM
 P98jwad2iixiw3lqs54J/+tojDmn9Ziug0KLvmp4aAPjDUt/bnAgttEcDFt+skI0XikbsAs5Vf5
 7ZnjitGuo9f3Mxh48QaKc4y0nYOeWHbsqc+XY5OVyiPerlmv/1wGb6I9Y/2IaD29ecxui9LyOuL
 OxAI7lvFFt8J8Is/f+2ftEJvOJzS1lAigBOOma2DT5kqpmZKkx5JKVRSYhZ/KXo0ybg5/k5vlIe
 hABzOgIi/wSjv/jbuG+MgV2p2KuKxsL8U=
X-Google-Smtp-Source: AGHT+IEB+iXNo/27BavAr/btX0ZR/wQ8paMoQxMir1FL6Y4llPm9gF17EAA6Xl/0V7TwHWDvJxJ+Qw==
X-Received: by 2002:a05:600c:45c4:b0:47d:403a:277 with SMTP id
 5b1f17b1804b1-47d403a0498mr50232525e9.4.1766687809321; 
 Thu, 25 Dec 2025 10:36:49 -0800 (PST)
Received: from tuf-gaming ([2a02:2f01:750c:5d01:f353:1d29:b301:e06a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d19362345sm354519855e9.6.2025.12.25.10.36.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Dec 2025 10:36:48 -0800 (PST)
From: =?UTF-8?q?Jean-Christian=20C=C3=8ERSTEA?=
 <jean.christian.cirstea@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Jean-Christian=20C=C3=8ERSTEA?= <jean.christian.cirstea@gmail.com>
Subject: [PATCH] linux-user/strace: fix printing of file offsets
Date: Thu, 25 Dec 2025 20:36:44 +0200
Message-ID: <20251225183644.1919184-1-jean.christian.cirstea@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=jean.christian.cirstea@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Previously, 64-bit file offsets (loff_t) were printed using `print_raw_param()`
function, which led to silent truncation of the upper part. This commit fixes
this issue by adding two helper functions:

1. print_file_offset32(): prints 32-bit file offsets (off_t)
2. print_file_offset64(): prints 64-bit file offsets (loff_t)

*NOTE*: checkpatch.pl gives the following errors:

```
ERROR: externs should be avoided in .c files
#30: FILE: linux-user/strace.c:88:
+UNUSED void print_file_offset32(abi_long offset, int);

ERROR: storage class should be at the beginning of the declaration
#31: FILE: linux-user/strace.c:89:
+UNUSED static void print_file_offset64(abi_long low, abi_long high, int);
```

The errors are may be removed if `UNUSED` and `static` are switched. Should this
patch fix this and swap all `UNUSED`s and `static`s?

Signed-off-by: Jean-Christian CÎRSTEA <jean.christian.cirstea@gmail.com>
---
 linux-user/strace.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 758c5d32b6..f790cab4da 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -85,6 +85,8 @@ UNUSED static void print_enums(const struct enums *, abi_long, int);
 UNUSED static void print_at_dirfd(abi_long, int);
 UNUSED static void print_file_mode(abi_long, int);
 UNUSED static void print_open_flags(abi_long, int);
+UNUSED void print_file_offset32(abi_long offset, int);
+UNUSED static void print_file_offset64(abi_long low, abi_long high, int);
 UNUSED static void print_syscall_prologue(const struct syscallname *);
 UNUSED static void print_syscall_epilogue(const struct syscallname *);
 UNUSED static void print_string(abi_long, int);
@@ -1664,6 +1666,20 @@ print_open_flags(abi_long flags, int last)
     print_flags(open_flags, flags, last);
 }
 
+/* Prints 32-bit file offset (off_t) */
+static void
+print_file_offset32(abi_long offset, int last)
+{
+    print_raw_param(TARGET_ABI_FMT_ld, offset, 0);
+}
+
+/* Prints 64-bit file offset (loff_t) */
+static void
+print_file_offset64(abi_long low, abi_long high, int last)
+{
+    print_raw_param64("%" PRIu64, target_offset64(low, high), last);
+}
+
 static void
 print_syscall_prologue(const struct syscallname *sc)
 {
@@ -2187,11 +2203,13 @@ print_fallocate(CPUArchState *cpu_env, const struct syscallname *name,
     print_raw_param("%d", arg0, 0);
     print_flags(falloc_flags, arg1, 0);
 #if TARGET_ABI_BITS == 32
-    print_raw_param("%" PRIu64, target_offset64(arg2, arg3), 0);
-    print_raw_param("%" PRIu64, target_offset64(arg4, arg5), 1);
+    /* On 32-bit targets, two registers are used for `loff_t` */
+    print_file_offset64(arg2, arg3, 0);
+    print_file_offset64(arg4, arg5, 1);
 #else
-    print_raw_param(TARGET_ABI_FMT_ld, arg2, 0);
-    print_raw_param(TARGET_ABI_FMT_ld, arg3, 1);
+    /* On 64-bit targets, one register is used for `loff_t` */
+    print_file_offset64(arg2, 0, 0);
+    print_file_offset64(arg3, 0, 1);
 #endif
     print_syscall_epilogue(name);
 }
@@ -2619,7 +2637,7 @@ print_lseek(CPUArchState *cpu_env, const struct syscallname *name,
 {
     print_syscall_prologue(name);
     print_raw_param("%d", arg0, 0);
-    print_raw_param(TARGET_ABI_FMT_ld, arg1, 0);
+    print_file_offset32(arg1, 0);
     switch (arg2) {
     case SEEK_SET:
         qemu_log("SEEK_SET"); break;
@@ -2650,7 +2668,7 @@ print_truncate(CPUArchState *cpu_env, const struct syscallname *name,
 {
     print_syscall_prologue(name);
     print_string(arg0, 0);
-    print_raw_param(TARGET_ABI_FMT_ld, arg1, 1);
+    print_file_offset32(arg1, 1);
     print_syscall_epilogue(name);
 }
 #endif
@@ -2667,7 +2685,7 @@ print_truncate64(CPUArchState *cpu_env, const struct syscallname *name,
         arg1 = arg2;
         arg2 = arg3;
     }
-    print_raw_param("%" PRIu64, target_offset64(arg1, arg2), 1);
+    print_file_offset64(arg1, arg2, 1);
     print_syscall_epilogue(name);
 }
 #endif
@@ -2684,7 +2702,7 @@ print_ftruncate64(CPUArchState *cpu_env, const struct syscallname *name,
         arg1 = arg2;
         arg2 = arg3;
     }
-    print_raw_param("%" PRIu64, target_offset64(arg1, arg2), 1);
+    print_file_offset64(arg1, arg2, 1);
     print_syscall_epilogue(name);
 }
 #endif
@@ -3239,7 +3257,7 @@ print_stat(CPUArchState *cpu_env, const struct syscallname *name,
     print_syscall_epilogue(name);
 }
 #define print_lstat     print_stat
-#define print_stat64	print_stat
+#define print_stat64    print_stat
 #define print_lstat64   print_stat
 #endif
 
@@ -4228,7 +4246,7 @@ print_pread64(CPUArchState *cpu_env, const struct syscallname *name,
     print_raw_param("%d", arg0, 0);
     print_pointer(arg1, 0);
     print_raw_param("%d", arg2, 0);
-    print_raw_param("%" PRIu64, target_offset64(arg3, arg4), 1);
+    print_file_offset64(arg3, arg4, 1);
     print_syscall_epilogue(name);
 }
 #endif
-- 
2.51.0


