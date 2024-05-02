Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58ED8C04FFE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2YlE-0000x9-Vc; Thu, 02 May 2024 11:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2Yl0-0000uf-Nc
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:54:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2Ykw-0002Nb-8C
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714665236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KT/QFvRlHjzCcc4urMYslx+97zsa5gUvdtO4XnBpBY0=;
 b=OCkNtkXt7J8TSL2ZrKt3+trGY9HY9/PdyHL/WV2NJx/678v+BBpkH4Gs6BrjGJyZxXJ6gh
 lhBRgDa2tezsBfDcS7hzgYPbzTe5OBmHF6tSpYE5egqkydq3qb8sX7vJTPzNQ4OnA/wP8t
 IrZe+Ig0Rvuqr9xtqVobSXOekyFI6Vs=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-MjtwNKMBPb2yg3PUB6TxMQ-1; Thu, 02 May 2024 11:53:54 -0400
X-MC-Unique: MjtwNKMBPb2yg3PUB6TxMQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-51b0eed7614so6186247e87.1
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 08:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714665233; x=1715270033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KT/QFvRlHjzCcc4urMYslx+97zsa5gUvdtO4XnBpBY0=;
 b=Yra8gUoGLGxm94xuRhUWFHmIH8ALxtOfNj/SU/SNJFJK3qWPoG+xUo05PpTioyPIXb
 qQ5xHsbdokiEjjm9/1Fl0RSP87UYARIrSfgAO+H8Vt5vtS4BkHCOL08tcKrhQasDpjAV
 UFWsYOfJo6KHHg93shBzV5+eSB5Z/FfBatt3KYyJ3TwVTcx0ojWA30roOQig+g5zDfZ/
 ibiv8M6D+NJCCXkNc0v1wZdAvTgMD6bEHGaXwec2bDLwTo2zA+yrPVun/aqn7Q8H2WWh
 gbmyGVJxaRPA4nnY70rTsGFc0UYFUaE6uLeIV/Wp59xTC7eh3wDYmBcb4K7EiPa+zIS9
 Mj+Q==
X-Gm-Message-State: AOJu0YxbBrpdGpSB3kv/V3xKQ9fH0ut3M7NtnEgudfPxU5l7xOCowSti
 JX0r/78dHWq3NCSfaQ/ffenFExQ9TYeM3u8TpBg2kYfzkmYQrZG8+EPibV434LmK40Lc1cn+QP/
 d6Kg0L6r2EHpUezU0lX9AxFD20dBvfzXOHYgzKQWkoFEQdF0n3PkFS34Kotv+7y4F+D64LYl0GZ
 oy4YB/pf/NEVhnbF/LuJ14ObrqTPPJMoByQa6s
X-Received: by 2002:ac2:532a:0:b0:51f:3e0c:ace3 with SMTP id
 f10-20020ac2532a000000b0051f3e0cace3mr176282lfh.16.1714665232266; 
 Thu, 02 May 2024 08:53:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOTbe9PoKPyS6hYgOixwdpygg1srCpp6QkON/VCvK3r67HDyNTp6KkA1r9HAQxXGDomVKXsg==
X-Received: by 2002:ac2:532a:0:b0:51f:3e0c:ace3 with SMTP id
 f10-20020ac2532a000000b0051f3e0cace3mr176254lfh.16.1714665231486; 
 Thu, 02 May 2024 08:53:51 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 x19-20020a1709065ad300b00a55bbc4fd16sm689953ejs.48.2024.05.02.08.53.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 08:53:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/13] lockable: remove QemuLockable from typedefs.h
Date: Thu,  2 May 2024 17:53:25 +0200
Message-ID: <20240502155331.109297-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502155331.109297-1-pbonzini@redhat.com>
References: <20240502155331.109297-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


