Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14338606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 16:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=OeFx0tq6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJvnI-0005Tu-M9; Thu, 22 Oct 2026 12:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJvnB-0005T5-E7
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 12:37:25 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJvn8-0006Sb-Hj
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 12:37:24 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso2017518f8f.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 09:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792687041; x=1793291841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HxhAz6bVRmv4Wlodx9ldgv+FyhKQd5+fWXSBsqrB874=;
 b=OeFx0tq6mufH5pcEEBvETeJCOoFfGUNpvp0XmHXR/x0EdyegYuZnumzP6leMyszsQV
 HKTdlnApiv+nMLQT/SnP8tKz8LoeVEwMGJCCUFlYL8EIPAtYA9Jy8aKk4KEWzXf9FN/t
 cLrmFgH8RHuB1VEUkA0O+UXu7qzKp5pKfuzC4XedCxF0p0ENWr333bX/AHh94uKT/O5D
 4AuxGdGr0wxxcwhCS/gDzOEhkMZvdZ8QL6IfwKjgBmbqqjs/c4pbIJRKJA77c6cgo6Lj
 O92yZnoDC/syDhQFH+ei6a4O68C6UNE3wQ01kJrCtTJekcc4z5+/BQSmGz3oqdPm9XXY
 NnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792687041; x=1793291841;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HxhAz6bVRmv4Wlodx9ldgv+FyhKQd5+fWXSBsqrB874=;
 b=2PYSbNDBDvw3QM2j/TEFbWMjARVrqPRuZi95zPA9SAk4Naiwqxd1DpUBHCZyfnoXS0
 6G6VF34BgCnpBJnj5Kf0d6ywjlnYu4H+9x9nKTkF+eaie9Me8LDY0t61/1dySZSMJgK6
 U+AT5QvlwNCU35tSi6M/2uTG3+mdrUQoepgepx+SURO9HW4QiPSkRfjyAeb0xICqQH9G
 1Rd4qjxqFwL6993Zd6GDXx3xfUotsgGyysxD6C6o4KIAa4CdmtVG/IDKfF9bngjOGL7M
 H1uxRCRyyjskylaYVPPfk7/pMA0Ty4wfdDVUyL0hJJthaYUkpj7Dk257UHAWhqwXqFrW
 HVJQ==
X-Gm-Message-State: AFq9FYIh+ngKpUhLeFXXFu8XpP9mq1rw2DZj5cmtV0eaD57f7vWkuRmI
 p1Jvi6xhUGT1jFgJGzHyL17LQeS9OkjdJp5EyjmJuONQC3qR+OaYGUZGGDDj186Dh/7KKnI042T
 DTawXExM=
X-Gm-Gg: AYBFou1aJ61uaLZSbosm0W1tZAwvoV8glr27lvcjhc116zC2b+2CkZHI+8Xve/Ikocc
 /LlYyz4IZafluwO7z0JjFl+ZAvQOWoieDvE4Ww/qGMP9zE/9jXfvXaZXC5/c0qQM3EdX+sBoiLu
 Ju8b8B2ai/TdqA90qVPFrlLLMS+BCuGC9VmwI9gBewGZqnG3fb2pNEdVbQwDgyDRwA4LtbppzkW
 8tUgRWX/E56uK5Ce1tecLY/oDuNzcAkESnR7g2MrQM0VE1dyLXP6ajRpSqUwqOyMYkepK8XUgvL
 UDT2ETt21VgZlBIuBtej/F4fM+yFqztflzjIV+F+fnYOH1fDYhI2adnEMORvq8fxtq8lnMiTXiZ
 Yjfe5698A8YFC4nxMlfF28Xn1FNm5IpLL1bfDX6DmbiPyCx/8FDAe0LilMmOUbv4gmKtkwWkBZM
 cUK3dZIKjWkszsB/SFs/+48Dw7+RyTdmtMV2H2ccnMcu4kh75vzW51ZACzPWw24161x1OLheZCz
 JFVnL//9hCcwpVc2DX1LLGIRHx3g03iJDtldBdtCmXYXhmQf+jgPSIbVcomkGx4QTunYEn2roVd
 RGjObhBeSyoi62MBVb7G+o4TbKHLwtecd+UwdrfQagXXF+zoY/FNBzrNM2y+tZrFGLPdRZ7T7Cx
 eaM9z1A==
X-Received: by 2002:a05:6000:41c7:b0:48c:a08:5858 with SMTP id
 ffacd0b85a97d-48e26489aa9mr10826972f8f.23.1792687040625; 
 Thu, 22 Oct 2026 09:37:20 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e254ef1casm10443116f8f.7.2026.10.22.09.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 09:37:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH] linux-user: Use QemuSemaphore to wait for clone child thread
Date: Thu, 22 Oct 2026 17:37:18 +0100
Message-ID: <20261022163718.562442-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In do_fork() and clone_func() we currently use a pthread_mutex_t and
a pthread_cond_t to allow the parent thread to wait until the child
thread has started and e.g.  set fields like info->tid, before the
parent reads those fields and otherwise proceeds.

Coverity points out that this use of a pthread condition variable
isn't reliable: pthread_cond_wait() may wake up spuriously, so the
idiom for "wait on a condition" should be "loop around calling
pthread_cond_wait() until a predicate that was updated by the caller
of pthread_cond_broadcast() is true".

This is quite old code; rather than fixing up its use of raw pthread
condition variables, we can use a QemuSemaphore.  This gives us the
"thread A waits until thread B signals it" semantics we want.  (Under
the hood it is implemented with a mutex and condition variable.)

Cc: qemu-stable@nongnu.org
Resolves: CID 1527417
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
cc stable because in theory this could result in the parent thread
waking up too early and weird stuff happening; however my guess is
that in practice with one waiter and one signaller that the
"spurious wakeup" case won't happen. At any rate this code has
been like this for a very long time.

Disclaimer: tested with "make check" only, but that does include
various linux-user tests that use multiple threads.
---
 linux-user/syscall.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 0380691a8b1..9d85a193efe 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6932,8 +6932,7 @@ static abi_long do_map_shadow_stack(CPUArchState *env, abi_ulong addr,
 static pthread_mutex_t clone_lock = PTHREAD_MUTEX_INITIALIZER;
 typedef struct {
     CPUArchState *env;
-    pthread_mutex_t mutex;
-    pthread_cond_t cond;
+    QemuSemaphore sem;
     pthread_t thread;
     uint32_t tid;
     abi_ulong child_tidptr;
@@ -6964,9 +6963,7 @@ static void *clone_func(void *arg)
     /* Enable signals.  */
     sigprocmask(SIG_SETMASK, &info->sigmask, NULL);
     /* Signal to the parent that we're ready.  */
-    pthread_mutex_lock(&info->mutex);
-    pthread_cond_broadcast(&info->cond);
-    pthread_mutex_unlock(&info->mutex);
+    qemu_sem_post(&info->sem);
     /* Wait until the parent has finished initializing the tls state.  */
     pthread_mutex_lock(&clone_lock);
     pthread_mutex_unlock(&clone_lock);
@@ -7071,9 +7068,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         }
 
         memset(&info, 0, sizeof(info));
-        pthread_mutex_init(&info.mutex, NULL);
-        pthread_mutex_lock(&info.mutex);
-        pthread_cond_init(&info.cond, NULL);
+        qemu_sem_init(&info.sem, 0);
         info.env = new_env;
         if (flags & CLONE_CHILD_SETTID) {
             info.child_tidptr = child_tidptr;
@@ -7097,7 +7092,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         pthread_attr_destroy(&attr);
         if (ret == 0) {
             /* Wait for the child to initialize.  */
-            pthread_cond_wait(&info.cond, &info.mutex);
+            qemu_sem_wait(&info.sem);
             ret = info.tid;
         } else {
             errno = ret;
@@ -7111,9 +7106,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
 #endif
             g_free(ts);
         }
-        pthread_mutex_unlock(&info.mutex);
-        pthread_cond_destroy(&info.cond);
-        pthread_mutex_destroy(&info.mutex);
+        qemu_sem_destroy(&info.sem);
         pthread_mutex_unlock(&clone_lock);
     } else {
         /* if no CLONE_VM, we consider it is a fork */
-- 
2.43.0


