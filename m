Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB7CC4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 07:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3tAJ-0008WH-9w; Mon, 06 May 2024 03:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9l-0007o9-UY
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:53:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9j-0001mI-6m
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aMFGRpwt2MBQ9BUPbkLkgJfLIroL0bh0oM+o3o5bzu8=;
 b=M7iloKjM5FQL6I9OEiDbREjFE6WfTl1czHvpI7bPqqJiHVovU8NyEQWAQJoVl5TaZ0wpgl
 by09Qlu05onVcRBwIiwZkk0xPs8Q6eRQKvIXNTconXTPRCronxuYxI0aYcJG+WbN3gjGjZ
 zkkN/QCu9PrKrwKlBOK/XqdfLy9EFwA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-0fp_OR84NFeXSGm23n76aQ-1; Mon, 06 May 2024 03:53:01 -0400
X-MC-Unique: 0fp_OR84NFeXSGm23n76aQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a59c3cf5f83so65166266b.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981979; x=1715586779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aMFGRpwt2MBQ9BUPbkLkgJfLIroL0bh0oM+o3o5bzu8=;
 b=Gf65Kp4hUsIG/N+K4CwmtN/64tJv9kWzIy/r8CzLJiiqMm0d+8OHTKA6Ai5T0R9Tc3
 JLWXde/eMiWJw1Zf1IbPN9FuRlEnJTXigIoN30Od/9aolzsPK3mV8sPmycYAdD42g28g
 SLPTtngv+VZtFfVro37wlIz9PXiBrnEv5pYwC9rzIksYGaFM9wGdozMgelh1kwOgKYvy
 +r2s0ZWy1n4cKFikbgB6tFr9P5OPoJPrXYn/JTMI7wSLQnX9YTpCFYj50Rc+6Ll55ptK
 lJ54Tb/m4LhrQc4NszjYcliz9WTtpXnmWN9B3OZeGKttpm0Mf67Byn5nLjUCoeR13wLR
 dDnQ==
X-Gm-Message-State: AOJu0YwgPV7b4hv9ZLx5k6cD3k/E/kPxJG3QSlPaL8XLx90lGMuoKAQI
 VDpM5EALzotif4nS7d+JsAHhcqn68aFLWyAKZN5dM9cBDmOX4LI4bj6CQ/hgkVxdBjPQm9B8ktf
 JrHSi9923ciRITRoFlSmNVSXXLz1O/hRcLBjxeCG3Rg8vnkEPpkGsDbT9WxLjnNr24ldFRd3m3o
 iIL/LfEg/AElhj4aeIduSoustCWlEPtSf6klZj
X-Received: by 2002:a17:907:28c2:b0:a59:9e01:e788 with SMTP id
 en2-20020a17090728c200b00a599e01e788mr4307619ejc.34.1714981979354; 
 Mon, 06 May 2024 00:52:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5G+vZDqLJMPUBVbRk49Dvv2JGQKGMy2W4e5ngrPKvXzNpnZRwSoh2R9U0CYtm42Lth7EHVg==
X-Received: by 2002:a17:907:28c2:b0:a59:9e01:e788 with SMTP id
 en2-20020a17090728c200b00a599e01e788mr4307610ejc.34.1714981979003; 
 Mon, 06 May 2024 00:52:59 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 v6-20020a1709067d8600b00a599e65808asm3375943ejo.18.2024.05.06.00.52.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:52:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 37/46] lockable: remove QemuLockable from typedefs.h
Date: Mon,  6 May 2024 09:51:16 +0200
Message-ID: <20240506075125.8238-38-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
References: <20240506075125.8238-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Using QemuLockable almost always requires going through QEMU_MAKE_LOCKABLE().
Therefore, there is little point in having the typedef always present.  Move
it to lockable.h, with only a small adjustment to coroutine.h (which has
a tricky co-dependency with lockable.h due to defining CoMutex *and*
using QemuLockable as a part of the CoQueue API).

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/coroutine.h | 4 ++--
 include/qemu/lockable.h  | 4 ++--
 include/qemu/typedefs.h  | 1 -
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index e6aff453017..ff3084538b8 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -84,6 +84,8 @@ static inline coroutine_fn void qemu_co_mutex_assert_locked(CoMutex *mutex)
            mutex->holder == qemu_coroutine_self());
 }
 
+#include "qemu/lockable.h"
+
 /**
  * CoQueues are a mechanism to queue coroutines in order to continue executing
  * them later.  They are similar to condition variables, but they need help
@@ -281,8 +283,6 @@ void qemu_coroutine_inc_pool_size(unsigned int additional_pool_size);
  */
 void qemu_coroutine_dec_pool_size(unsigned int additional_pool_size);
 
-#include "qemu/lockable.h"
-
 /**
  * Sends a (part of) iovec down a socket, yielding when the socket is full, or
  * Receives data into a (part of) iovec from a socket,
diff --git a/include/qemu/lockable.h b/include/qemu/lockable.h
index 9823220446d..62110d2eb74 100644
--- a/include/qemu/lockable.h
+++ b/include/qemu/lockable.h
@@ -18,11 +18,11 @@
 
 typedef void QemuLockUnlockFunc(void *);
 
-struct QemuLockable {
+typedef struct QemuLockable {
     void *object;
     QemuLockUnlockFunc *lock;
     QemuLockUnlockFunc *unlock;
-};
+} QemuLockable;
 
 static inline __attribute__((__always_inline__)) QemuLockable *
 qemu_make_lockable(void *x, QemuLockable *lockable)
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 090e219248a..ab24ca2876c 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -105,7 +105,6 @@ typedef struct QEMUBH QEMUBH;
 typedef struct QemuConsole QemuConsole;
 typedef struct QEMUCursor QEMUCursor;
 typedef struct QEMUFile QEMUFile;
-typedef struct QemuLockable QemuLockable;
 typedef struct QemuMutex QemuMutex;
 typedef struct QemuOpts QemuOpts;
 typedef struct QemuOptsList QemuOptsList;
-- 
2.44.0


