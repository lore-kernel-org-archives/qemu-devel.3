Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF979CD343F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 21:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP5Vm-0000Xt-Il; Mon, 18 May 2026 17:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5Vg-0000Vm-RX
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:26 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5Ve-0000Zz-L2
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:24 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7e36bb16a92so1712551a34.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 14:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779139700; x=1779744500;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=if9zs5/BYj3vgggDFOtTdd7tyuToJLpo8aht9ThzVZ4=;
 b=NLJ2+8703OJlqvl0TDW+GLk5FwGTK9Dl6lI1qXBqsMB8kHXA+zQfb5ymwstSnZH13d
 nXDmiH6EW5D9KucTdsYCZbohqIW50+HvijIr90e36fcxwWx9sL5o+MyaVsC0yHLFWznD
 3KNKOX2T8aM5vytGbw+/S+/XfyAURrOXDoQhnIf5CmyK2O4JtIG1pZkI2+c3XecOFNqn
 iEnUPrgI0NvReYL1ozVXdjpxLm3lwUwS5DHfMsh6+OKLDFyye6vbBMosDcwj0TSy6gsx
 6eZ+5JVu+/0RAu4viwpB6TO526uO3XoxRTKeGCjXkUCJlGsWwrd3izDoIIwdXxJhm57f
 RzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779139700; x=1779744500;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=if9zs5/BYj3vgggDFOtTdd7tyuToJLpo8aht9ThzVZ4=;
 b=ruRi40ibt2QgOJsf10mphK/Rnm8wfMGEyE7Xqd5JlMiMo0bGeJzpZIRqqtxKrlcSv9
 8WFHeyOssl3j8IntLB1cHuW+t0o8DobymRnc99yIUQEqE4zqkgRhn8JuiDBb9fxAG8uK
 k1hFHx5nPNHm9bXPSp6lVJUrG5j5Yt49IyVgZAov3ekrNd1XQAd9eJSA+lm7BuJyuq0C
 hmmZSgjk7T45Wws7TzdLn36y23/GlO3HpoQVzAiuZZ3b12+djNWbNuyF4jN3UZVxd3Z4
 xKyhv291hpwbLWCGh+ef1VttCsVxj6My1HOp0Vrf+Am2W1FI1G6dRiBAAo1FROBUws/c
 mkWA==
X-Gm-Message-State: AOJu0YyKIarSgQHVaZ6yKVdpJvEuZS8DwuTmWYBT+O9AnWCvMlRFpFy4
 xwfxXh6rN51xeqKvkP7Q6jCjNCVpMTerK4EOMQPwKc3yJmkrt/Td437kqGEiPvsXhGw=
X-Gm-Gg: Acq92OGl70k4lnkLJ9FD4KrdlKn4XkHS9AzrLvSSEdW2Ldul0ZpOtEUn/Enl+2EujbM
 YkNBbh7KzPYyrKaEbBIcULaqt6owhNWo4StGXuQsTZOdUUNxZpYgbjtiWZZ63Mc8KkkjaAEhQIU
 eJkZkvNtnJeBw2q2ooxt2STkDRbPU7GgNHLNK75Vx6NLt/g/4RLhCAiSwA7ym7mFKw/WwqwADT5
 xIODxLCitRyNIEPFhT6bdDef7B2o3Us90uxxjoAARBJhIsPkyUlxxfcpgH7+tpRvJcC+du/HP/c
 utowkEIv1JrJYrftVHLTrkNWPZp7J0wrZplnJS8a+4z8RRxCsrIJuKSU7HdeqKYatTvd98O3WQJ
 taCHT9MbcK9HWIAMa1HQI2vcmlk6rLjej+l7Fj7zSilzRGtz0fxdesdoK2iqogETpnle5oEgrUR
 bEuWd/CmnRgA==
X-Received: by 2002:a9d:3e17:0:b0:7e5:6f53:5bee with SMTP id
 46e09a7af769-7e56f535debmr6516762a34.21.1779139700162; 
 Mon, 18 May 2026 14:28:20 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b81cc5asm7980358a34.8.2026.05.18.14.28.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:28:19 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 18 May 2026 15:27:45 -0600
Subject: [PATCH v2 27/37] bsd-user: Add do_freebsd__umtx_op to os-thread.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-misc-2026q2-v2-27-6c16fe448301@bsdimp.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
In-Reply-To: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>, 
 Sean Bruno <sbruno@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=13091; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=4+GA8QrCmXfs+eg4WCBeD7ThMbhd3jADQhQetC+1sMw=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqC4RIbENyMNLx/ppCPS1aLYRJtrTnWDkDPmPgV
 VL7m/u+60GJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaguESAAKCRBsHNEofbAR
 AEPVEACcWjbLH9UCPw7pu2EWfRmdJSrPI6U9OqMuwJKf9qBcdMGEwimQKppCS8PWlm2zwZuX7Nr
 k6m/y3s+TNwbggRqSSOwXLyCmEVkKQ19mdXC8EcIYmnWMZXsf7V+lty0medAJiMHXbbbRBXEJd3
 yb1/POMlHfAApU60WQ4YhMaQJ0hTGsJpQ1jAAdBYd1FlSaf1imEoemET4AWZmGeEElOFD0bWPvf
 pu+u2N9cth8/Kz23QFlC1v4STeECiySHtk1wXyoSOsa1+nvYKaGU7uQXL3CO7Em5jrr8kUTeItn
 zNa7LFdcdNHzFKYlo/Wx/f4zO6WFLhEEiTwGXIQ193hDFTzy0S5gtUHtjn9fERa+2/E/ynCTE7p
 7Q3FquXbBHa51ACMZMMyYiWOdnw9VeF0Xp3e/DabVXyYkTS77zXr+iC+AheePFZGsoET1MOm7oN
 92hV9jjEoUQ1fO6/2eFY5hR8PC3EHTTM/aA5HnoScRO/MWfiR7GEKylfZdlw07SY16kuRAxvn23
 3UyBNPuO7KlLTKH/7636bpzg2oC0nmYOyAWLFmP6P/fqc2ivDIhdcw+6cbQOEhfHM0hIyJEWYHc
 JUtml3rpnJVZC2qQcSy0+VMU0XmfxWCBx/FWzvHVuEjUgcwkWHuDEurXGhPIYiIjwINC3VsigL5
 Ew9UWbPP9G1aRVQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::336;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x336.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add the _umtx_op system call implementation with support for
UMTX lock/unlock, mutex operations, condition variables, reader-writer
locks, semaphores, shared memory, and robust lists.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
Signed-off-by: Sean Bruno <sbruno@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/os-thread.h | 352 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 352 insertions(+)

diff --git a/bsd-user/freebsd/os-thread.h b/bsd-user/freebsd/os-thread.h
index bb8f279060..98fcd61009 100644
--- a/bsd-user/freebsd/os-thread.h
+++ b/bsd-user/freebsd/os-thread.h
@@ -240,5 +240,357 @@ static inline abi_long do_freebsd_swapcontext(CPUArchState *env, abi_ulong arg1,
  * undocumented _umtx_op(void *obj, int op, u_long val, void *uaddr,
  *                           void *target_time);
  */
+static inline abi_long do_freebsd__umtx_op(abi_ulong obj, int op, abi_ulong val,
+        abi_ulong uaddr, abi_ulong target_time)
+{
+    abi_long ret;
+#ifndef _UMTX_OPTIMIZED
+    struct _umtx_time ut[2];
+    struct timespec ts;
+    size_t utsz;
+    long tid;
+#endif
+
+    switch (op) {
+    case TARGET_UMTX_OP_WAIT:
+        /* args: obj *, val, (void *)sizeof(ut), ut * */
+#ifdef _UMTX_OPTIMIZED
+        if (target_time != 0 && !access_ok(VERIFY_READ, target_time, uaddr)) {
+            return -TARGET_EFAULT;
+        }
+        ret = freebsd_umtx_wait(obj, val, uaddr,
+                                safe_g2h_untagged(target_time));
+#else
+        if (target_time != 0) {
+            ret = t2h_freebsd_umtx_time(target_time, uaddr, ut, &utsz);
+            if (is_error(ret)) {
+                return ret;
+            }
+            ret = freebsd_umtx_wait(obj, tswapal(val), utsz, &ut);
+        } else {
+            ret = freebsd_umtx_wait(obj, tswapal(val), 0, NULL);
+        }
+#endif
+        break;
+
+    case TARGET_UMTX_OP_WAKE:
+        /* args: obj *, nr_wakeup */
+        ret = freebsd_umtx_wake(obj, val);
+        break;
+
+    case TARGET_UMTX_OP_MUTEX_LOCK:
+#ifdef _UMTX_OPTIMIZED
+        if (target_time != 0 && !access_ok(VERIFY_READ, target_time, uaddr)) {
+            return -TARGET_EFAULT;
+        }
+        ret = freebsd_lock_umutex(obj, 0, safe_g2h_untagged(target_time), uaddr,
+                                  0, val);
+#else
+        ret = get_errno(thr_self(&tid));
+        if (is_error(ret)) {
+            return ret;
+        }
+        if (target_time != 0) {
+            ret = t2h_freebsd_umtx_time(target_time, uaddr, ut, &utsz);
+            if (is_error(ret)) {
+                return ret;
+            }
+            ret = freebsd_lock_umutex(obj, tid, ut, utsz, 0, tswapal(val));
+        } else {
+            ret = freebsd_lock_umutex(obj, tid, NULL, 0, 0, tswapal(val));
+        }
+#endif
+        break;
+
+    case TARGET_UMTX_OP_MUTEX_UNLOCK:
+#ifdef _UMTX_OPTIMIZED
+        ret = freebsd_unlock_umutex(obj, 0);
+#else
+        ret = get_errno(thr_self(&tid));
+        if (is_error(ret)) {
+            return ret;
+        }
+        ret = freebsd_unlock_umutex(obj, tid);
+#endif
+        break;
+
+    case TARGET_UMTX_OP_MUTEX_TRYLOCK:
+#ifdef _UMTX_OPTIMIZED
+        ret = freebsd_lock_umutex(obj, 0, NULL, 0, TARGET_UMUTEX_TRY, val);
+#else
+        ret = get_errno(thr_self(&tid));
+        if (is_error(ret)) {
+            return ret;
+        }
+        ret = freebsd_lock_umutex(obj, tid, NULL, 0, TARGET_UMUTEX_TRY,
+            tswapal(val));
+#endif
+        break;
+
+    case TARGET_UMTX_OP_MUTEX_WAIT:
+#ifdef _UMTX_OPTIMIZED
+        if (target_time != 0 && !access_ok(VERIFY_READ, target_time, uaddr)) {
+            return -TARGET_EFAULT;
+        }
+        ret = freebsd_lock_umutex(obj, 0, safe_g2h_untagged(target_time), uaddr,
+            TARGET_UMUTEX_WAIT, val);
+#else
+        ret = get_errno(thr_self(&tid));
+        if (is_error(ret)) {
+            return ret;
+        }
+        if (target_time != 0) {
+            ret = t2h_freebsd_umtx_time(target_time, uaddr, ut, &utsz);
+            if (is_error(ret)) {
+                return ret;
+            }
+            ret = freebsd_lock_umutex(obj, tid, ut, utsz, TARGET_UMUTEX_WAIT,
+                tswapal(val));
+        } else {
+            ret = freebsd_lock_umutex(obj, tid, NULL, 0, TARGET_UMUTEX_WAIT,
+                tswapal(val));
+        }
+#endif
+        break;
+
+    case TARGET_UMTX_OP_MUTEX_WAKE:
+        /* Don't need to do access_ok(). */
+        ret = freebsd_umtx_mutex_wake(obj, val);
+        break;
+
+    case TARGET_UMTX_OP_SET_CEILING:
+        ret = 0; /* XXX quietly ignore these things for now */
+        break;
+
+    case TARGET_UMTX_OP_CV_WAIT:
+#ifdef _UMTX_OPTIMIZED
+        if (target_time != 0 && !access_ok(VERIFY_READ, target_time, uaddr)) {
+            return -TARGET_EFAULT;
+        }
+        ret = freebsd_cv_wait(obj, uaddr, safe_g2h_untagged(target_time), val);
+#else
+        /*
+         * Initialization of the struct conv is done by
+         * bzero'ing everything in userland.
+         */
+        if (target_time != 0) {
+            if (t2h_freebsd_timespec(&ts, target_time)) {
+                return -TARGET_EFAULT;
+            }
+            ret = freebsd_cv_wait(obj, uaddr, &ts, val);
+        } else {
+            ret = freebsd_cv_wait(obj, uaddr, NULL, val);
+        }
+#endif
+        break;
+
+    case TARGET_UMTX_OP_CV_SIGNAL:
+        /*
+         * XXX
+         * User code may check if c_has_waiters is zero.  Other
+         * than that it is assume that user code doesn't do
+         * much with the struct conv fields and is pretty
+         * much opauque to userland.
+         */
+        ret = freebsd_cv_signal(obj);
+        break;
+
+    case TARGET_UMTX_OP_CV_BROADCAST:
+        /*
+         * XXX
+         * User code may check if c_has_waiters is zero.  Other
+         * than that it is assume that user code doesn't do
+         * much with the struct conv fields and is pretty
+         * much opauque to userland.
+         */
+        ret = freebsd_cv_broadcast(obj);
+        break;
+
+    case TARGET_UMTX_OP_WAIT_UINT:
+#ifdef _UMTX_OPTIMIZED
+        if (target_time != 0 && !access_ok(VERIFY_READ, target_time, uaddr)) {
+            return -TARGET_EFAULT;
+        }
+        ret = freebsd_umtx_wait_uint(obj, val, uaddr,
+                                     safe_g2h_untagged(target_time));
+#else
+        if (!access_ok(VERIFY_READ, obj, sizeof(abi_ulong))) {
+            return -TARGET_EFAULT;
+        }
+        /* args: obj *, val, (void *)sizeof(ut), ut * */
+        if (target_time != 0) {
+            ret = t2h_freebsd_umtx_time(target_time, uaddr, ut, &utsz);
+            if (is_error(ret)) {
+                return ret;
+            }
+            ret = freebsd_umtx_wait_uint(obj, tswap32((uint32_t)val),
+                                         utsz, &ut);
+        } else {
+            ret = freebsd_umtx_wait_uint(obj, tswap32((uint32_t)val), 0, NULL);
+        }
+#endif
+        break;
+
+    case TARGET_UMTX_OP_WAIT_UINT_PRIVATE:
+#ifdef _UMTX_OPTIMIZED
+        if (target_time != 0 && !access_ok(VERIFY_READ, target_time, uaddr)) {
+            return -TARGET_EFAULT;
+        }
+        ret = freebsd_umtx_wait_uint_private(obj, val, uaddr,
+            safe_g2h_untagged(target_time));
+#else
+        if (!access_ok(VERIFY_READ, obj, sizeof(abi_ulong))) {
+            return -TARGET_EFAULT;
+        }
+        /* args: obj *, val, (void *)sizeof(ut), ut * */
+        if (target_time != 0) {
+            ret = t2h_freebsd_umtx_time(target_time, uaddr, ut, &utsz);
+            if (is_error(ret)) {
+                return ret;
+            }
+            ret = freebsd_umtx_wait_uint_private(obj, tswap32((uint32_t)val),
+                    utsz, &ut);
+        } else {
+            ret = freebsd_umtx_wait_uint_private(obj, tswap32((uint32_t)val),
+                    0, NULL);
+        }
+#endif
+        break;
+
+    case TARGET_UMTX_OP_WAKE_PRIVATE:
+        /* Don't need to do access_ok(). */
+        ret = freebsd_umtx_wake_private(obj, val);
+        break;
+
+    case TARGET_UMTX_OP_RW_RDLOCK:
+#ifdef _UMTX_OPTIMIZED
+        if (target_time != 0 && !access_ok(VERIFY_READ, target_time, uaddr)) {
+            return -TARGET_EFAULT;
+        }
+        ret = freebsd_rw_rdlock(obj, val, uaddr,
+                                safe_g2h_untagged(target_time));
+#else
+        if (target_time != 0) {
+            ret = t2h_freebsd_umtx_time(target_time, uaddr, ut, &utsz);
+            if (is_error(ret)) {
+                return ret;
+            }
+            ret = freebsd_rw_rdlock(obj, val, utsz, &ut);
+        } else {
+            ret = freebsd_rw_rdlock(obj, val, 0, NULL);
+        }
+#endif
+        break;
+
+    case TARGET_UMTX_OP_RW_WRLOCK:
+#ifdef _UMTX_OPTIMIZED
+        if (target_time != 0 && !access_ok(VERIFY_READ, target_time, uaddr)) {
+            return -TARGET_EFAULT;
+        }
+        ret = freebsd_rw_wrlock(obj, val, uaddr,
+                                safe_g2h_untagged(target_time));
+#else
+        if (target_time != 0) {
+            ret = t2h_freebsd_umtx_time(target_time, uaddr, ut, &utsz);
+            if (is_error(ret)) {
+                return ret;
+            }
+            ret = freebsd_rw_wrlock(obj, val, utsz, &ut);
+        } else {
+            ret = freebsd_rw_wrlock(obj, val, 0, NULL);
+        }
+#endif
+        break;
+
+    case TARGET_UMTX_OP_RW_UNLOCK:
+        ret = freebsd_rw_unlock(obj);
+        break;
+
+#ifdef UMTX_OP_MUTEX_WAKE2
+    case TARGET_UMTX_OP_MUTEX_WAKE2:
+        ret = freebsd_umtx_mutex_wake2(obj, val);
+        break;
+#endif /* UMTX_OP_MUTEX_WAKE2 */
+
+#ifdef UMTX_OP_NWAKE_PRIVATE
+    case TARGET_UMTX_OP_NWAKE_PRIVATE:
+        ret = freebsd_umtx_nwake_private(obj, val);
+        break;
+#endif /* UMTX_OP_NWAKE_PRIVATE */
+
+    case TARGET_UMTX_OP_SEM2_WAIT:
+        /* args: obj *, val, (void *)sizeof(ut), ut * */
+#ifdef _UMTX_OPTIMIZED
+        if (target_time != 0 && !access_ok(
+            (uaddr > sizeof(struct target_freebsd__umtx_time) ? VERIFY_WRITE :
+             VERIFY_READ), target_time, uaddr)) {
+            return -TARGET_EFAULT;
+        }
+        ret = freebsd_umtx_sem2_wait(obj, uaddr,
+                                     safe_g2h_untagged(target_time));
+#else
+        if (target_time != 0) {
+            ret = t2h_freebsd_umtx_time(target_time, uaddr, ut, &utsz);
+            if (is_error(ret)) {
+                return ret;
+            }
+            /* Kernel writes out the ut[1] if utsz >= _umtx_time + timespec. */
+            ret = freebsd_umtx_sem2_wait(obj, utsz, ut);
+            if (ret == -TARGET_EINTR && (ut[0]._flags & UMTX_ABSTIME) == 0 &&
+                utsz >= sizeof(struct target_freebsd__umtx_time) +
+                sizeof(struct target_freebsd_timespec)) {
+                abi_ulong cret;
+
+                cret = h2t_freebsd_timespec(target_time +
+                    sizeof(struct target_freebsd__umtx_time), &ut[1]._timeout);
+                if (is_error(cret)) {
+                    ret = cret;
+                }
+            }
+        } else {
+            ret = freebsd_umtx_sem2_wait(obj, 0, NULL);
+        }
+#endif
+        break;
+
+    case TARGET_UMTX_OP_SEM2_WAKE:
+        /* Don't need to do access_ok(). */
+        ret = freebsd_umtx_sem2_wake(obj);
+        break;
+    case TARGET_UMTX_OP_SEM_WAIT:
+        /* args: obj *, val, (void *)sizeof(ut), ut * */
+#ifdef _UMTX_OPTIMIZED
+        if (target_time != 0 && !access_ok(VERIFY_READ, target_time, uaddr)) {
+            return -TARGET_EFAULT;
+        }
+        ret = freebsd_umtx_sem_wait(obj, uaddr, safe_g2h_untagged(target_time));
+#else
+        if (target_time != 0) {
+            ret = t2h_freebsd_umtx_time(target_time, uaddr, ut, &utsz);
+            if (is_error(ret)) {
+                return ret;
+            }
+            ret = freebsd_umtx_sem_wait(obj, utsz, ut);
+        } else {
+            ret = freebsd_umtx_sem_wait(obj, 0, NULL);
+        }
+#endif
+        break;
+
+    case TARGET_UMTX_OP_SEM_WAKE:
+        /* Don't need to do access_ok(). */
+        ret = freebsd_umtx_sem_wake(obj);
+        break;
+    case UMTX_OP_SHM:
+        ret = freebsd_umtx_shm(uaddr, val);
+        break;
+    case TARGET_UMTX_OP_ROBUST_LISTS:
+        ret = freebsd_umtx_robust_list(uaddr, val);
+        break;
+    default:
+        return -TARGET_EINVAL;
+    }
+    return ret;
+}
 
 #endif /* FREEBSD_OS_THREAD_H */

-- 
2.52.0


