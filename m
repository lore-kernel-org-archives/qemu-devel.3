Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96127C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x964F-0000j0-Fi; Tue, 22 Sep 2026 15:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x963Z-0000Xm-4H
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:21:38 -0400
Received: from mail-oi2-x11.google.com ([2607:f8b0:4864:32::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x963W-0002Ns-Og
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:21:32 -0400
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4c3b639adbcso228539b6e.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 12:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1790104889; x=1790709689;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d8sJC27NXyd3qQPylvoTQ8kruB5VgXx0Hct3PQ6Zi24=;
 b=kMCA5jC1172xdykMUQIKFflbvmF5SIxYPHKrKkeigeiR0B1VIrv3UZrOVoVWsRY+Tj
 zeqKlRcQq3huboKq3YTI6GXZViLrqoqq2hKIqkWpIChVijWsC9/a+sGN7tTMw1fhCejP
 e6xkCbqHWcjbe7x4DTz5QjSlpJdAxlWjcr072/Or7tTfzYCtFDi6ijzyZnm8SqgArC35
 6+Xf+rLyDkohmEdW/Q84ZwHVwIcxz4BQeM5PkF5cSJ9TL+ZrLqWPgDD020UQluQngj/1
 pIgr6JgeU+DxcMfTIi/ugmSw3gy64XNbi2Fkj0ew4rjEFYbiwffxgiGbQw1F3XXZDFbU
 GRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790104889; x=1790709689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=d8sJC27NXyd3qQPylvoTQ8kruB5VgXx0Hct3PQ6Zi24=;
 b=Suws1nUbM0AoByRNgSBJaFbkwWTFAo92pHCF1bWMFmPrJi4/nKsxE3PeyOSDHcHh4Q
 CrRk4WMLBUBUqQ0oz7M2tRElPEVajDnhJhrFE9FpZYzxZZWbmaQoHqD8jNXwkoXgeiys
 V+DOY1D0SEThix/0ijRQX+DF0ADyyM+b4n+3ZFo2QZApI1gOYee9rxhPIyqD+FeqpnyQ
 QuwEvEY4+dvNxjEr/KhRfM2taMi5wR/+YdUXIS8ZJhOSJNabAg0ZabIqDDbQoSheTKqa
 w1otKKwt8WJ8lFUYpFp9bowT/ve4RXc4CBnSRXnmaV16X8wMRd1Nj3Tn7U0MphjYqlKT
 t+Uw==
X-Gm-Message-State: AFuF++mJgmxch2bD66AstwuR/e7i501WbrlHqdx5NyjFNsFUWOqsIdNR
 aaNhZG3kETu3tbAfL29vTkGmLGMFT9eJ+8qe8Obk5ugiCCzomSwbNHLwkprpx/EdBFOnHZGF8RL
 A1fgZJi8=
X-Gm-Gg: AYBFou0guvSEqABLgFplzIPJSsoXLRId2efFYepGhW+Tf+XtIMNaDXqffG7T0w4UhOm
 ZziKvXMHZT5C42xZJF7yjS7fLp4FD4QtmleWxQD2JJYm3I+LCOuxjfd7Vyz2BTpqVIBT8HV9Do0
 o60X6190wzGXGZ4YgEEGjFDAmd9Fu97g3ro3RDy/vnChHCml6nR7pgoNYd3XUNeCAHBc96jkORs
 Gp/rwnnaprdNibkNIbK9iGQVxdnYeCQruVjKFgK0IuB6vAG+aJKS0+kwUgi4l1L4QxuDTAEmN2y
 Dui55naaTVLi3F8/uO6uyI0y7RSoa/38GuwjQTCHj5Fyy5l25OsMaHs13Am/eeD0eIANnLzCOT5
 fu0ZvN7xwWtHV4of+QbvC3RnEDKZ1cUaqlHtnmpunTGLd+LUMOQDj7Cw0+UiOJurXiJ23miPsR+
 V5OeiYzYfc3HWPI3hriVMmrTFrFmclgoQCBwXiypN+c+0o+9xO+WV+Rz+45A==
X-Received: by 2002:a05:6820:3385:10b0:6cd:3fbd:1d65 with SMTP id
 006d021491bc7-6d2d3017efdmr276959eaf.79.1790104888771; 
 Tue, 22 Sep 2026 12:21:28 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6d2ce763f72sm646776eaf.7.2026.09.22.12.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 12:21:28 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Rick Richard <rick@sloservers.com>
Subject: [PULL 01/11] bsd-user: HOST_BIG_ENDIAN and TARGET_BIG_ENDIAN are
 always
Date: Tue, 22 Sep 2026 13:20:59 -0600
Message-ID: <20260922192109.98467-2-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922192109.98467-1-imp@bsdimp.com>
References: <20260922192109.98467-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::11;
 envelope-from=imp@bsdimp.com; helo=mail-oi2-x11.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Rick Richard <rick@sloservers.com>

TARGET_BIG_ENDIAN and HOST_BIG_ENDIAN are always defined.

lseek and target_offset64() transpose upper and lower halves
on 32-bit ABIs, -strace prints wrong off_t.

Signed-off-by: Rick Richard <rick@sloservers.com>
[ fixed defined() too and moved to C if() instead of ifdef ]
Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-file.h          |  43 +++++++-------
 bsd-user/freebsd/os-misc.h   | 105 +++++++++++++++++------------------
 bsd-user/freebsd/os-thread.h |   2 +-
 3 files changed, 74 insertions(+), 76 deletions(-)

diff --git a/bsd-user/bsd-file.h b/bsd-user/bsd-file.h
index 0fefc07232..5c32aa0396 100644
--- a/bsd-user/bsd-file.h
+++ b/bsd-user/bsd-file.h
@@ -973,30 +973,31 @@ static abi_long do_bsd_lseek(CPUArchState *env, abi_long arg1, abi_long arg2,
         abi_long arg3, abi_long arg4, abi_long arg5)
 {
     abi_long ret;
-#if TARGET_ABI_BITS == 32
-    int64_t res;
 
-    /* 32-bit arch's use two 32 registers for 64 bit return value */
-    if (regpairs_aligned(env) != 0) {
-        res = lseek(arg1, target_arg64(arg3, arg4), arg5);
-    } else {
-        res = lseek(arg1, target_arg64(arg2, arg3), arg4);
-    }
-    if (res == -1) {
-        ret = get_errno(res);
-        set_second_rval(env, 0xFFFFFFFF);
+    if (TARGET_ABI_BITS == 32) {
+        /* 32-bit arch's use two 32 registers for 64 bit return value */
+        int64_t res;
+
+        if (regpairs_aligned(env) != 0) {
+            res = lseek(arg1, target_arg64(arg3, arg4), arg5);
+        } else {
+            res = lseek(arg1, target_arg64(arg2, arg3), arg4);
+        }
+        if (res == -1) {
+            ret = get_errno(res);
+            set_second_rval(env, 0xFFFFFFFF);
+        } else {
+            if (TARGET_BIG_ENDIAN) {
+                ret = ((res >> 32) & 0xFFFFFFFF);
+                set_second_rval(env, res & 0xFFFFFFFF);
+            } else {
+                ret = res & 0xFFFFFFFF;
+                set_second_rval(env, (res >> 32) & 0xFFFFFFFF);
+            }
+        }
     } else {
-#ifdef TARGET_BIG_ENDIAN
-        ret = ((res >> 32) & 0xFFFFFFFF);
-        set_second_rval(env, res & 0xFFFFFFFF);
-#else
-        ret = res & 0xFFFFFFFF;
-        set_second_rval(env, (res >> 32) & 0xFFFFFFFF);
-#endif
+        ret = get_errno(lseek(arg1, arg2, arg3));
     }
-#else
-    ret = get_errno(lseek(arg1, arg2, arg3));
-#endif
     return ret;
 }
 
diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h
index 0f87b21cc8..be549c4bd9 100644
--- a/bsd-user/freebsd/os-misc.h
+++ b/bsd-user/freebsd/os-misc.h
@@ -106,19 +106,19 @@ static inline abi_long do_freebsd_cpuset_setid(CPUArchState *env, abi_long arg1,
     cpuwhich_t which;
 
     target_to_host_cpuset_which(&which, arg1);
-#if TARGET_ABI_BITS == 32
-    /* See if we need to align the register pairs */
-    if (regpairs_aligned(env)) {
-        id = target_arg64(arg3, arg4);
-        setid = arg5;
+    if (TARGET_ABI_BITS == 32) {
+        /* See if we need to align the register pairs */
+        if (regpairs_aligned(env)) {
+            id = target_arg64(arg3, arg4);
+            setid = arg5;
+        } else {
+            id = target_arg64(arg2, arg3);
+            setid = arg4;
+        }
     } else {
-        id = target_arg64(arg2, arg3);
-        setid = arg4;
+        id = arg2;
+        setid = arg3;
     }
-#else
-    id = arg2;
-    setid = arg3;
-#endif
     return get_errno(cpuset_setid(which, id, setid));
 }
 
@@ -135,13 +135,13 @@ static inline abi_long do_freebsd_cpuset_getid(abi_long arg1, abi_ulong arg2,
 
     target_to_host_cpuset_which(&which, arg1);
     target_to_host_cpuset_level(&level, arg2);
-#if TARGET_ABI_BITS == 32
-    id = target_arg64(arg3, arg4);
-    target_setid = arg5;
-#else
-    id = arg3;
-    target_setid = arg4;
-#endif
+    if (TARGET_ABI_BITS == 32) {
+        id = target_arg64(arg3, arg4);
+        target_setid = arg5;
+    } else {
+        id = arg3;
+        target_setid = arg4;
+    }
     ret = get_errno(cpuset_getid(level, which, id, &setid));
     if (is_error(ret)) {
         return ret;
@@ -212,15 +212,15 @@ static inline abi_long do_freebsd_cpuset_getaffinity(cpulevel_t level,
     id_t id;    /* 64-bit */
     abi_ulong setsize, target_mask;
 
-#if TARGET_ABI_BITS == 32
-    id = (id_t)target_arg64(arg3, arg4);
-    setsize = arg5;
-    target_mask = arg6;
-#else
-    id = (id_t)arg3;
-    setsize = arg4;
-    target_mask = arg5;
-#endif
+    if (TARGET_ABI_BITS == 32) {
+        id = (id_t)target_arg64(arg3, arg4);
+        setsize = arg5;
+        target_mask = arg6;
+    } else {
+        id = (id_t)arg3;
+        setsize = arg4;
+        target_mask = arg5;
+    }
 
     ret = get_errno(cpuset_getaffinity(level, which, id, setsize, &mask));
     if (ret == 0) {
@@ -241,15 +241,15 @@ static inline abi_long do_freebsd_cpuset_setaffinity(cpulevel_t level,
     id_t id; /* 64-bit */
     abi_ulong setsize, target_mask;
 
-#if TARGET_ABI_BITS == 32
-    id = (id_t)target_arg64(arg3, arg4);
-    setsize = arg5;
-    target_mask = arg6;
-#else
-    id = (id_t)arg3;
-    setsize = arg4;
-    target_mask = arg5;
-#endif
+    if (TARGET_ABI_BITS == 32) {
+        id = (id_t)target_arg64(arg3, arg4);
+        setsize = arg5;
+        target_mask = arg6;
+    } else {
+        id = (id_t)arg3;
+        setsize = arg4;
+        target_mask = arg5;
+    }
 
     ret = copy_from_user_cpuset_mask(&mask, target_mask);
     if (ret == 0) {
@@ -333,33 +333,30 @@ static inline abi_long do_freebsd_kldsym(abi_long fileid, abi_long cmd,
  * New posix calls
  */
 
-#if TARGET_ABI_BITS == 32
-static inline uint64_t target_offset64(uint32_t word0, uint32_t word1)
-{
-#ifdef TARGET_BIG_ENDIAN
-    return ((uint64_t)word0 << 32) | word1;
-#else
-    return ((uint64_t)word1 << 32) | word0;
-#endif
-}
-#else /* TARGET_ABI_BITS == 32 */
 static inline uint64_t target_offset64(uint64_t word0, uint64_t word1)
 {
-    return word0;
+    if (TARGET_ABI_BITS == 32) {
+        if (TARGET_BIG_ENDIAN) {
+            return ((uint64_t)word0 << 32) | word1;
+        } else {
+            return ((uint64_t)word1 << 32) | word0;
+        }
+    } else {
+        return word0;
+    }
 }
-#endif /* TARGET_ABI_BITS != 32 */
 
 /* posix_fallocate(2) */
 static inline abi_long do_freebsd_posix_fallocate(abi_long arg1, abi_long arg2,
     abi_long arg3, abi_long arg4, abi_long arg5, abi_long arg6)
 {
 
-#if TARGET_ABI_BITS == 32
-    return get_errno(posix_fallocate(arg1, target_offset64(arg3, arg4),
-        target_offset64(arg5, arg6)));
-#else
-    return get_errno(posix_fallocate(arg1, arg2, arg3));
-#endif
+    if (TARGET_ABI_BITS == 32) {
+        return get_errno(posix_fallocate(arg1, target_offset64(arg3, arg4),
+            target_offset64(arg5, arg6)));
+    } else {
+        return get_errno(posix_fallocate(arg1, arg2, arg3));
+    }
 }
 
 /* posix_openpt(2) */
diff --git a/bsd-user/freebsd/os-thread.h b/bsd-user/freebsd/os-thread.h
index 4258b24095..6552c60337 100644
--- a/bsd-user/freebsd/os-thread.h
+++ b/bsd-user/freebsd/os-thread.h
@@ -18,7 +18,7 @@
 int safe_thr_suspend(struct timespec *timeout);
 int safe__umtx_op(void *, int, unsigned long, void *, void *);
 
-#if defined(HOST_BIG_ENDIAN) == defined(TARGET_BIG_ENDIAN) && \
+#if HOST_BIG_ENDIAN == TARGET_BIG_ENDIAN && \
     (TARGET_ABI_BITS == HOST_LONG_BITS || defined(UMTX_OP__32BIT))
 #define _UMTX_OPTIMIZED
 #if defined(TARGET_ABI32)
-- 
2.55.0


