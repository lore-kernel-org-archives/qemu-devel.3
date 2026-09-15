Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C6D7C88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 20:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Zrt-0001Hh-JC; Tue, 15 Sep 2026 16:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x6Zrr-0001HI-S5
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:35:03 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x6Zrq-0005Zw-5S
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:35:03 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49e6598dd44so1299275e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 13:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789504500; x=1790109300; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XTYYskXjomYjrh7QaEEaHTvJmk0WsJMpAIC97SU4vck=;
 b=nkLMKuv0QMMFsN9GKRib/zJXyhKn8HW9JuT0hb5eZws6X//s5JDzqUwW9EVBPpuy2Y
 1FOqtKga0Jv+FjgF7iwMvDS482lYDZ66P8bjIYG4sXxDgVnAxFv87LRZR3FhRuYgEobT
 h3OZXGJzmU5K6yE3K5kmcHvk6xiorrayw0cZScHVfITs13VXRzleJf36o2f/qi60dNbQ
 aueP6xcy3wTuBoDjc4zf8H2+Vcel0JaaZzu8bqeMiloU93AVGF2cdj2AsSvcU8ULiwNX
 RdC8jXgwc2w6H0Yzv9Lr/pO9aMfVoKtvPLUNbbHjfUhW9Ou0d/JezrgCHwbs2DBdKepT
 QdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789504500; x=1790109300;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XTYYskXjomYjrh7QaEEaHTvJmk0WsJMpAIC97SU4vck=;
 b=phZHWfdRAkxMD97QZD+ZE4VGMd2GmV/nU+9zh/mWv/F+N8f+HJCEmg+PfAgPF3m6KD
 zo4VEB6tfapKLpN35vGGZybQEj820CDSaiNWsvjerG5IIja1f+Qciek393neZk4s10tB
 5upEp6zq4RhFIFJ1XESvxU7bj5zAGLROKTKYZX5kbWoxkO1qdO5LOATE4AwERAvLvwPi
 tlxXqTQ35mndSI4X0/NtkjguooHbIEhaC5ykNHterGlxfCM7USVMfzrhIvmYbjL6ua0O
 cVSEgH8olz0rLaeTzaYEQeBtePw3hmJV4nEquEzFF/zxOu5aglX7hjV+3hZHiMVlAyDc
 DyvA==
X-Gm-Message-State: AFuF++mItoEESR+f6q8tek+Lz2XmOGcCaSuLwyI4DZPPNDoWHUyFjfeW
 rH94gv2TOWKDKn4P0XBJC2h5UoZt5fzyFoerWHV/ZWUgQxndpyLBp67aE6bubHqehy+C2V7v32I
 Sgrma
X-Gm-Gg: AYBFou2ocyfDtQ/XNhrRqr1PvOTsfsCwS4N5gJytUJfYFAGmhx3/tIqXi4e2n6LLakJ
 1KZ1CK0BwqMc2DBaNCUECS7B82YfpY2WRRjq23TGDkh4QID/PFewzHsp21/C0By/ZxiXfOEhJKR
 e9v5ZYOKRKyJAFxxOdzwHARIPjaR4jXIPkRVwINvChyboP0J2iuFzJ/WdfNmNcKuhemq1wkeoMv
 kJgKycSrh/6hmFGrVRpoYVEgSw3gMZgjvwQu9Oo2VZ4K1jehuwRC3ot0hMtlgrtgoEQGSk4dRY2
 xEjgA6LatDglDbJlqUqnIUNjQ0Rwjno6dVC8xZ2Iv7J3D+2cnGA49dPhYRPm5eQHsGvmYzqMw1e
 4dVDNlBoPCiN/D4ZsXkPgVMk9AV5Y8a2OsGlIzcxPZSqHu5uifril9UErro2mxpI35lTzCymsy/
 f+R8r7TabCVMB4EOuDwx9tcLts8e+Ij/50tQ8UqnMl1DMQvgpBXiP+dosKBYrw2UCuXcOX
X-Received: by 2002:a5d:5e91:0:b0:486:e558:604 with SMTP id
 ffacd0b85a97d-4870d062624mr134707f8f.57.1789504500539; 
 Tue, 15 Sep 2026 13:35:00 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:f0fe:c7ed:403d:e487])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf37e69sm1504073f8f.29.2026.09.15.13.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:35:00 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Stefan Weil <sw@weilnetz.de>
Subject: [PATCH 01/10] util/qemu-thread: track bql_locked across the timed
 condvar wait
Date: Tue, 15 Sep 2026 22:34:45 +0200
Message-ID: <20260915203455.580999-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915203455.580999-1-den@openvz.org>
References: <20260915203455.580999-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=den@openvz.org; helo=mail-wm2-x10.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Denis V. Lunev <den@openvz.org>

qemu_cond_timedwait_ts() releases and retakes the mutex around
pthread_cond_timedwait(), but calls the two trace points by hand
instead of going through the mutex hooks, so it never reaches
bql_update_status(). A thread waiting there still reports bql_locked
true while the mutex is released, which is the confusion the hooks were
given that job to end. migration/cpu-throttle.c reaches this through
qemu_cond_timedwait_bql(). The Windows qemu_cond_timedwait_impl() has
the same two trace calls, next to a qemu_cond_wait_impl() that already
uses the hooks.

Call the hooks, which emit the same two trace points.

Fixes: c89d1c879a ("bql: Fix bql_locked status with condvar APIs")
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Cc: Zhao Liu <zhao1.liu@intel.com>
Cc: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 util/qemu-thread-posix.c | 4 ++--
 util/qemu-thread-win32.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 089606c93f..580cdf8079 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -250,9 +250,9 @@ qemu_cond_timedwait_ts(QemuCond *cond, QemuMutex *mutex, struct timespec *ts,
     int err;
 
     assert(cond->initialized);
-    trace_qemu_mutex_unlock(mutex, file, line);
+    qemu_mutex_pre_unlock(mutex, file, line);
     err = pthread_cond_timedwait(&cond->cond, &mutex->lock, ts);
-    trace_qemu_mutex_locked(mutex, file, line);
+    qemu_mutex_post_lock(mutex, file, line);
     if (err && err != ETIMEDOUT) {
         error_exit(err, __func__);
     }
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index 3037732a6f..afdacdb5f2 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -177,11 +177,11 @@ bool qemu_cond_timedwait_impl(QemuCond *cond, QemuMutex *mutex, int ms,
     int rc = 0;
 
     assert(cond->initialized);
-    trace_qemu_mutex_unlock(mutex, file, line);
+    qemu_mutex_pre_unlock(mutex, file, line);
     if (!SleepConditionVariableSRW(&cond->var, &mutex->lock, ms, 0)) {
         rc = GetLastError();
     }
-    trace_qemu_mutex_locked(mutex, file, line);
+    qemu_mutex_post_lock(mutex, file, line);
     if (rc && rc != ERROR_TIMEOUT) {
         error_exit(rc, __func__);
     }
-- 
2.53.0


