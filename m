Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB567CD4F3C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzxS-0001ob-Hb; Fri, 15 May 2026 17:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxR-0001mL-E3
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:33 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxP-00032L-7v
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:33 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7dbcb467f2bso313237a34.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880030; x=1779484830;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lnsqIOReTKaIY4sP0bp5MAeqJ+rJm9GnOiYsfaGABBk=;
 b=theJtp6i2cXJzVBzy83MKdcGHMJVxC8pNm2BYW60dXEGnkKSwI32qyDGP34ftJs5FG
 R1z2ddfAqfFJQntzr5vLOnPt9RoEvJ6wwVycz0xIZ+h/lYotVzF4z7iWBqGENXzBbfu9
 jxgu9fd80vawx5OlV/pvhgdWomGnOyWNrfl/R2rchyQqEqCfnYiMIKwskw6wxdr42trT
 sp4+gWOCuVKzmci7VHc5XUBn54E3EyN+J4mf/2D1OmYElIToAsy0z5U81uBjOwbukXIO
 3SXX4EcVfrJUQJes0wrb3Inn31vkzH512UlJ0TOszmeEsqiFH91g//Onv/exsxhYNMEK
 pMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880030; x=1779484830;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lnsqIOReTKaIY4sP0bp5MAeqJ+rJm9GnOiYsfaGABBk=;
 b=kNLoDamly+0sc0JEx9d1oUfecZNlOG+kUuVX7/ag6VkszY5QCyNeryyEYB4+6sfmE4
 YKR4IoI9XZlUSY3F+UlzID3t3XtjH6JUZDGlul+A3c+COzMScRNuaTJTsWaNPCYMah8d
 XukYidnSM+G9H15H3+rMZi6/nUQfMoP3LvvL0DEXnHKj4O74cgK+XOMUrFZ4iFC7Xpxn
 BrKhJPs0QPuEKy/oy30LYLxQX96ORP10ypA0D6w9ioBLzjzmD7Ss0he+QZm6ikPWNxdg
 9F5U2QrpDWLYSkAGPIA1qy34Hm1A/qx0iYErIvaz50kS4isPM+DDtLPvqFehE8ZP3ynn
 9PrQ==
X-Gm-Message-State: AOJu0YzxsGD8Yhrp+2ZURbXo8Qlz+n4dihWcuoFQV+PB1M7PA03c/1mH
 XS44GfM+s3wKcZkz1q8G4JOyl4eP7HkN3RHwUHmdsYPND/15Ty9q/hHIxC9PweIIlsU=
X-Gm-Gg: Acq92OHvcAGqQcnOocsg+N/vDAxTaLjaMX/GI9bxkzvMA/nyCM6/ROIVXy6sTbg6d5H
 VTcVnpaT7BkdlGhYjqUdtsBOMvvFENj7tBGjW3mWMTmy/lBs3mA08UF7hABF98oXrlATDvAM2tF
 JUwjncDSgkGOqcCiUE6VJwa1ybMyG1fB57kDOXIIOZq1dUVuWyJKrFxbj8nGOActX7sPkemTBrL
 K+Op8RatoYNOBuFjJH6bdMSWZwboNl75oaSbPS07vAZyfrrAdXWihO53RE4lqeVc7KAKBNkQslU
 Ds2HNVDMq4Al7UK27oUJDJVokLYVp9Xd9d6dmne97oasSyy6XZNPg045PCJyN3+Msb09aiFzicK
 8zyCyzuBRkv4nZ+hkVJ1fAzUtbMpVQh3Qq1owtj+CCri+uh+9XgKizr0kLrTww5wDn6oq+ONsHY
 pJVPfViS4Hog==
X-Received: by 2002:a05:6830:6d29:b0:7e3:6b8f:1e93 with SMTP id
 46e09a7af769-7e4ea01c97dmr4064175a34.5.1778880029980; 
 Fri, 15 May 2026 14:20:29 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:29 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:26 -0600
Subject: [PATCH 27/66] bsd-user: Add do_freebsd__umtx_op to os-thread.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-27-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>, 
 Sean Bruno <sbruno@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=13091; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=9kAnlJsg10tbfgn9qQZW4Ig7TCn5tTeM1ijrU6ZeE00=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43kPETLVuUIZLLbrfDTdFZJYRN8TT/9//tIR
 wGiqYYncDmJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN5AAKCRBsHNEofbAR
 AEb3D/4hUgmx4XIl2nGlUiK8f4rPc5djjpM8/A99ObP2z0TkOUpzKwbH68cq/qmTMs78mosKl+O
 fQlgicSKmBmhjk4Z7XSnAQ4L3y+WdteiTCyfSInHPbg9Id5XXhNpSGrjPjxelKYBocZbx3fkMeE
 1ZPxYZ8dYdDnMoW28paenns7qUrNM+T/B2mV04GNwnn80W05wUbQsWxmhpQujO9N6ZOeDMOuQa4
 P/NxMtK+qT9zp4af0Zx2DXTekoYr9T52+eMfUH9hu4RApMYcjd2Y7lKhCVu9gYXs0W3cMzBlW2u
 m3BGc2TqFssDP20sbdnvyCHDngVYT+THH0avdglmfqOFhZlTk5CdQcqOWkWf8+xZ30II60p/I3a
 p4YMn0Ci/mdFRJEgBpXk96WW8w2B/jqm1it73RS/G/9w7xuURBPwDlOMwRE0wXcNjkCkvKL16uC
 E7AKk/UziwgOGHsRtZiiOxKk+R+kJXMPPr4NNZhJ5bw69rWltzeexQde51EmuaNuzP8SGphz1ey
 E/9cfwW0jdHBptw6m6lzdS0JsB86yQuMzmmVGVNjmXABGjVqhUjSn6jDnJv4kvfgIpweC/bkDlV
 Dm4MQDh3CLFTwoSVqOFe8YbP4pyuPeC59QUA/OUHB8HS29v7C715wtFIx3NspYl1Or8NEfqnOSn
 yvuucJydZ+bzzpg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::330;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x330.google.com
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
index d063ea1b05..c9a5e76338 100644
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


