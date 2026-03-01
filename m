Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE03FFD0078
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 22:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwpDt-0002F0-1N; Sun, 01 Mar 2026 17:25:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1vwpDq-0002EG-Sh
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 17:25:10 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1vwpDp-0002K9-38
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 17:25:10 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-483703e4b08so32571455e9.1
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 14:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772403907; x=1773008707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fwGhUDJm3nLm1RfDvQ6EYdXYf68EBpwYdfuRzXBmWrY=;
 b=ngg7h89XRWWhDES6vqSq1LqV/bA30uMgu9MK8TVY0K0/fbmsqYLo9mIHIeRuHKVdUn
 q6rhi0NQ4FwsVbMSMQGTzqadVNw0feo9q7cvY61rEZK9vqzauW/M5ZtHpXFbgRqxPsOz
 j1rDT23b6clvCOrQVZF3daKX8njSu/OcqTf+uY/Vp0DN/wqdBNkbcJUNm5XuvT2tPNJD
 VT50X2vUA43jA0v/dK3Y+lC2CTUniZ3K5JP5JjKDlvQa5XYtOBPYzHuz2e0/PRc0cUQd
 P0qKSdUrBWazbUTtmGvuyMeZ0c0Uhs6HdE6Jguu6fz49jhA6wAMbCkCTinR3PmmGUdGl
 BZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772403907; x=1773008707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fwGhUDJm3nLm1RfDvQ6EYdXYf68EBpwYdfuRzXBmWrY=;
 b=kP5YN7NQgBvpYESzwD5SDH6dXftZD7oALaeE1C3b3xdpJv1NRreIhfmnGweUv2Wj8W
 QI4fQHFN6CUjVsWNw0ZNyJNttsE4tLHp0kZuPasN70pvyqi+mAdOkj5uoFT1ogGjnlSU
 7j5XGR9Tk2uQ/it5dmRmsCPjo3Y+xGCxEdvEwVDq1KTu9rXZpLx1fhI/7oaxVHWHHuZU
 xt38xMtCwcADtK/k7pG2uoq3rtJxjljCV3vMDmh0t71ISYlAF84+en19817zHdV4GYIu
 Y0UqfL0xuqNWESfdvNWJZjJqvqw2fC6SsOQR3I4QOaZhKYOmN1/ipoNfGLVst/7rIX66
 JuRQ==
X-Gm-Message-State: AOJu0YwmIUhOVaAMBbX3Oy2pJRIZibpLGMz8JoCRBuKbxUoYKXGizNNY
 rb3ezeEUH95NGjFL4LnaXQcCDM4G6SHFlwgdLFE9Td1AWnv9bdkwcEqyMb3chw==
X-Gm-Gg: ATEYQzze7t+Q2WQbqQ6xdiT3uQYf5V32QuDLjwD1YlnzjFyiEltI1Mxc88o7NHOgN3a
 urKeM8fw9GdixVzAD/HlzBg79PeuN5l96WEVM/NclJQ0UOkrRRTBp18Q9Z3iBT4iYTrn3YfPAKh
 w7QLbmZSE/QXO/3Sj47HN/bqTGaylsXzLtfSQ1J5ZqWHDdDdFM44levgAPp55Qsowus7i8oPjN4
 EHXPBqqjrHslxUMagcele8GqLo41j8RGKrdyI9TDTIOUwErsTsVLUHn8CqsLxeIc6FnYoRxKxxn
 9LC/srXlnggPcEsKHYmM141kdobF/7f02E2bdKitTaJRS5nrgPanOwgxqmn/GZlYLZgLCiT80fN
 TWE7PUkzeGi7k6/YZyL2LHqDNwhb2bm+ScEP9grE7LeWntn4xDd9EQNMe3RdrgQUMFxEYlAY/35
 tirV0a6IT5HS1Vvb+XFYTtVV6teRMWxbr/3ZY/qUE=
X-Received: by 2002:a05:600c:8b5b:b0:481:a662:b3f3 with SMTP id
 5b1f17b1804b1-483c990c263mr203763715e9.7.1772403907014; 
 Sun, 01 Mar 2026 14:25:07 -0800 (PST)
Received: from tuf-gaming ([158.173.157.82]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b770e7sm261779655e9.9.2026.03.01.14.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 14:25:06 -0800 (PST)
From: =?UTF-8?q?Jean-Christian=20C=C3=8ERSTEA?=
 <jean.christian.cirstea@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, jean-christian.cirstea@tuta.com, deller@gmx.de,
 =?UTF-8?q?Jean-Christian=20C=C3=8ERSTEA?= <jean.christian.cirstea@gmail.com>
Subject: [PATCH v2] linux-user/strace: fix printing of file offsets
Date: Mon,  2 Mar 2026 00:25:00 +0200
Message-ID: <20260301222500.215320-1-jean.christian.cirstea@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <a3587955-7ad2-42d7-8354-4e6c4c03e721@gmx.de>
References: <a3587955-7ad2-42d7-8354-4e6c4c03e721@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=jean.christian.cirstea@gmail.com; helo=mail-wm1-x32b.google.com
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

Previously, 64-bit file offsets (loff_t) were printed using `print_raw_param()`
function, which led to silent truncation of the upper part. This commit fixes
this issue by adding two helper functions:

1. print_file_offset32(): prints 32-bit file offsets (off_t)
2. print_file_offset64(): prints 64-bit file offsets (loff_t)

Signed-off-by: Jean-Christian CÎRSTEA <jean.christian.cirstea@gmail.com>
Reviewed-by: Helge Deller <deller@gmx.de>
---
Changelog v2:

1. Make `print_file_offset32()` static.
2. Use `last` parameter in `print_file_offset32()`.
3. Rename `low` and `high` parameters of `print_file_offset64()` to `word0`,
`word1` respectively
4. Convert `last` to bool for `print_file_offset[32,64]()`
5. Use `PRId64` instead of `PRIu64` for `print_file_offset64()`
6. Fix `print__llseek()`

 linux-user/strace.c | 43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 758c5d32b6..285fc987f5 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -85,6 +85,10 @@ UNUSED static void print_enums(const struct enums *, abi_long, int);
 UNUSED static void print_at_dirfd(abi_long, int);
 UNUSED static void print_file_mode(abi_long, int);
 UNUSED static void print_open_flags(abi_long, int);
+UNUSED static void print_file_offset32(abi_long offset, bool last);
+UNUSED static void print_file_offset64(abi_long word0,
+                                       abi_long word1,
+                                       bool last);
 UNUSED static void print_syscall_prologue(const struct syscallname *);
 UNUSED static void print_syscall_epilogue(const struct syscallname *);
 UNUSED static void print_string(abi_long, int);
@@ -1664,6 +1668,20 @@ print_open_flags(abi_long flags, int last)
     print_flags(open_flags, flags, last);
 }
 
+/* Prints 32-bit file offset (off_t) */
+static void
+print_file_offset32(abi_long offset, bool last)
+{
+    print_raw_param(TARGET_ABI_FMT_ld, offset, last);
+}
+
+/* Prints 64-bit file offset (loff_t) */
+static void
+print_file_offset64(abi_long word0, abi_long word1, bool last)
+{
+    print_raw_param64("%" PRId64, target_offset64(word0, word1), last);
+}
+
 static void
 print_syscall_prologue(const struct syscallname *sc)
 {
@@ -2187,11 +2205,13 @@ print_fallocate(CPUArchState *cpu_env, const struct syscallname *name,
     print_raw_param("%d", arg0, 0);
     print_flags(falloc_flags, arg1, 0);
 #if TARGET_ABI_BITS == 32
-    print_raw_param("%" PRIu64, target_offset64(arg2, arg3), 0);
-    print_raw_param("%" PRIu64, target_offset64(arg4, arg5), 1);
+    /* On 32-bit targets, two registers are used for `loff_t` */
+    print_file_offset64(arg2, arg3, false);
+    print_file_offset64(arg4, arg5, true);
 #else
-    print_raw_param(TARGET_ABI_FMT_ld, arg2, 0);
-    print_raw_param(TARGET_ABI_FMT_ld, arg3, 1);
+    /* On 64-bit targets, one register is used for `loff_t` */
+    print_file_offset64(arg2, 0, false);
+    print_file_offset64(arg3, 0, true);
 #endif
     print_syscall_epilogue(name);
 }
@@ -2597,8 +2617,7 @@ print__llseek(CPUArchState *cpu_env, const struct syscallname *name,
     const char *whence = "UNKNOWN";
     print_syscall_prologue(name);
     print_raw_param("%d", arg0, 0);
-    print_raw_param("%ld", arg1, 0);
-    print_raw_param("%ld", arg2, 0);
+    print_file_offset64(arg1, arg2, false);
     print_pointer(arg3, 0);
     switch(arg4) {
     case SEEK_SET: whence = "SEEK_SET"; break;
@@ -2619,7 +2638,7 @@ print_lseek(CPUArchState *cpu_env, const struct syscallname *name,
 {
     print_syscall_prologue(name);
     print_raw_param("%d", arg0, 0);
-    print_raw_param(TARGET_ABI_FMT_ld, arg1, 0);
+    print_file_offset32(arg1, false);
     switch (arg2) {
     case SEEK_SET:
         qemu_log("SEEK_SET"); break;
@@ -2650,7 +2669,7 @@ print_truncate(CPUArchState *cpu_env, const struct syscallname *name,
 {
     print_syscall_prologue(name);
     print_string(arg0, 0);
-    print_raw_param(TARGET_ABI_FMT_ld, arg1, 1);
+    print_file_offset32(arg1, true);
     print_syscall_epilogue(name);
 }
 #endif
@@ -2667,7 +2686,7 @@ print_truncate64(CPUArchState *cpu_env, const struct syscallname *name,
         arg1 = arg2;
         arg2 = arg3;
     }
-    print_raw_param("%" PRIu64, target_offset64(arg1, arg2), 1);
+    print_file_offset64(arg1, arg2, true);
     print_syscall_epilogue(name);
 }
 #endif
@@ -2684,7 +2703,7 @@ print_ftruncate64(CPUArchState *cpu_env, const struct syscallname *name,
         arg1 = arg2;
         arg2 = arg3;
     }
-    print_raw_param("%" PRIu64, target_offset64(arg1, arg2), 1);
+    print_file_offset64(arg1, arg2, true);
     print_syscall_epilogue(name);
 }
 #endif
@@ -3239,7 +3258,7 @@ print_stat(CPUArchState *cpu_env, const struct syscallname *name,
     print_syscall_epilogue(name);
 }
 #define print_lstat     print_stat
-#define print_stat64	print_stat
+#define print_stat64    print_stat
 #define print_lstat64   print_stat
 #endif
 
@@ -4228,7 +4247,7 @@ print_pread64(CPUArchState *cpu_env, const struct syscallname *name,
     print_raw_param("%d", arg0, 0);
     print_pointer(arg1, 0);
     print_raw_param("%d", arg2, 0);
-    print_raw_param("%" PRIu64, target_offset64(arg3, arg4), 1);
+    print_file_offset64(arg3, arg4, true);
     print_syscall_epilogue(name);
 }
 #endif
-- 
2.51.0


