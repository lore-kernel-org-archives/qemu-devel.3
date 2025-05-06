Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCA6C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKGA-0005mi-6M; Tue, 06 May 2025 11:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKFe-0004SE-G9
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKFb-0002FQ-Qv
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746545430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LHPitvNNyaabervLj5MUPkMguji4O/epz7bp+YMWz94=;
 b=AgmCXWV92jnyudpK0ycb+FstNXDFXmffusDALySWbxUP3hXK4W6QkSpV9ZvmXQRPNRKNzA
 O/GDxw6gxu6JQUth9UEDz9Qo+V+ord9VkH+mzhmxZkR49QTt98Y3Y5T8scouLDeka8Ac7d
 L5CkpVI3uVXS87A46y1nw668z05XdsY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-18rTPNnFO-SCdrOzyUqm8A-1; Tue, 06 May 2025 11:30:29 -0400
X-MC-Unique: 18rTPNnFO-SCdrOzyUqm8A-1
X-Mimecast-MFC-AGG-ID: 18rTPNnFO-SCdrOzyUqm8A_1746545428
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43ce8f82e66so29968715e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 08:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746545426; x=1747150226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LHPitvNNyaabervLj5MUPkMguji4O/epz7bp+YMWz94=;
 b=qYYFq0ncGsBfZ6oAbHA07TDY13GlPeq9eAGNgPdBGm+MYXiMLlciIyypppU389fuII
 q0E+f/t92ioMhIkda17Nj48pzdeh3RKKgwglO01piScHiO2FL5SFpu1M73jaWwrMkxi4
 RWcVRURyjAd6bup5uwy7QoSDfgykyKRc2BafyK5oI4kgpyrDkQH2CqgTKwwTxeX87A4p
 xwqI5kik5QtmXWu0KSZdVMAKxt7EsQBuAQxWxJpv8hNe2tPfsxRjqMRHI/LSBsjTk255
 Ag2Eev2x2dbdntzii8iicNwQdmi8fyL5yskuPQJkF2pC8LQpr8KOK8Q+dNoyQbc2si/h
 phnQ==
X-Gm-Message-State: AOJu0YwKqZ5dO1CWjtmZvkG/xprQoGlrp3usdiPfJDUkAdU6R+USDUrW
 Q2suVF5WqKbKe8QFQfCFGmpoGD+lX3Ph/FOblenmVahVIZTnYi58TpydCFLcWAe4c54QOzzPbER
 QugbB6yratlcUYbcmWILZdhxVlimQimPkjfLu0aND37P7pfzsPkKXZ4Rr4uORT267pb0ia7/YlD
 z4vIoYS9e7JGmblrBCekTuLmwxtf8rMLztUQ9T
X-Gm-Gg: ASbGncvzTxkWZyhip6vGKb48MAiWOwZvgRKs0smpWx4zSWQRsDOOxwXe1ii0nOBe0kS
 99v5aSxRUxmmqCj3L9dzAg0TyN6F9BreJzILVtgM3C/1G+Bdr9lJ+NMemKTdVnlH5Zo25rZsbBh
 QwaeD64rAEjVfmIqo+Psu65nRKfwrnzMiOTLgV3CP+Xh7ixj8j/GlVXUf3S5gIHvgeec56W/L8f
 1cZwPfe55W6gmJeppxpAMm2o8e6e0yvZLwwMangCEVOCA8khVM5P4CNXk325otd+2ZChz11u8ef
 Sx4kOBi7mUjYdsw=
X-Received: by 2002:a05:600c:34c3:b0:43d:abd:ad1c with SMTP id
 5b1f17b1804b1-441c48b0347mr110511975e9.6.1746545426134; 
 Tue, 06 May 2025 08:30:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2pVkeIYVCnfHClsFHE46KXaBYuUbnyHAnyya85TtZWS1i6ZeKJuux8gLZ6QejW0e9cs2dCA==
X-Received: by 2002:a05:600c:34c3:b0:43d:abd:ad1c with SMTP id
 5b1f17b1804b1-441c48b0347mr110511515e9.6.1746545425583; 
 Tue, 06 May 2025 08:30:25 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b17260sm14410090f8f.98.2025.05.06.08.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 08:30:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 27/30] util: Add coroutine backend for emscripten
Date: Tue,  6 May 2025 17:29:22 +0200
Message-ID: <20250506152927.222671-28-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506152927.222671-1-pbonzini@redhat.com>
References: <20250506152927.222671-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Kohei Tokunaga <ktokunaga.mail@gmail.com>

Emscripten does not support couroutine methods currently used by QEMU but
provides a coroutine implementation called "fiber". This commit introduces a
coroutine backend using fiber. Note that fiber does not support submitting
coroutines to other threads.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Link: https://lore.kernel.org/r/006b683fd578ed6303a2dc8679094da9a7e6dfb4.1745820062.git.ktokunaga.mail@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS           |   1 +
 util/coroutine-wasm.c | 127 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+)
 create mode 100644 util/coroutine-wasm.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2e23dad4bc6..55c47fcd378 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -633,6 +633,7 @@ M: Kohei Tokunaga <ktokunaga.mail@gmail.com>
 S: Maintained
 F: include/system/os-wasm.h
 F: os-wasm.c
+F: util/coroutine-wasm.c
 
 Alpha Machines
 --------------
diff --git a/util/coroutine-wasm.c b/util/coroutine-wasm.c
new file mode 100644
index 00000000000..cb1ec92509c
--- /dev/null
+++ b/util/coroutine-wasm.c
@@ -0,0 +1,127 @@
+/*
+ * emscripten fiber coroutine initialization code
+ * based on coroutine-ucontext.c
+ *
+ * Copyright (C) 2006  Anthony Liguori <anthony@codemonkey.ws>
+ * Copyright (C) 2011  Kevin Wolf <kwolf@redhat.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.0 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/coroutine_int.h"
+#include "qemu/coroutine-tls.h"
+
+#include <emscripten/fiber.h>
+
+typedef struct {
+    Coroutine base;
+    void *stack;
+    size_t stack_size;
+
+    void *asyncify_stack;
+    size_t asyncify_stack_size;
+
+    CoroutineAction action;
+
+    emscripten_fiber_t fiber;
+} CoroutineEmscripten;
+
+/**
+ * Per-thread coroutine bookkeeping
+ */
+QEMU_DEFINE_STATIC_CO_TLS(Coroutine *, current);
+QEMU_DEFINE_STATIC_CO_TLS(CoroutineEmscripten *, leader);
+size_t leader_asyncify_stack_size = COROUTINE_STACK_SIZE;
+
+static void coroutine_trampoline(void *co_)
+{
+    Coroutine *co = co_;
+
+    while (true) {
+        co->entry(co->entry_arg);
+        qemu_coroutine_switch(co, co->caller, COROUTINE_TERMINATE);
+    }
+}
+
+Coroutine *qemu_coroutine_new(void)
+{
+    CoroutineEmscripten *co;
+
+    co = g_malloc0(sizeof(*co));
+
+    co->stack_size = COROUTINE_STACK_SIZE;
+    co->stack = qemu_alloc_stack(&co->stack_size);
+
+    co->asyncify_stack_size = COROUTINE_STACK_SIZE;
+    co->asyncify_stack = g_malloc0(co->asyncify_stack_size);
+    emscripten_fiber_init(&co->fiber, coroutine_trampoline, &co->base,
+                          co->stack, co->stack_size, co->asyncify_stack,
+                          co->asyncify_stack_size);
+
+    return &co->base;
+}
+
+void qemu_coroutine_delete(Coroutine *co_)
+{
+    CoroutineEmscripten *co = DO_UPCAST(CoroutineEmscripten, base, co_);
+
+    qemu_free_stack(co->stack, co->stack_size);
+    g_free(co->asyncify_stack);
+    g_free(co);
+}
+
+CoroutineAction qemu_coroutine_switch(Coroutine *from_, Coroutine *to_,
+                      CoroutineAction action)
+{
+    CoroutineEmscripten *from = DO_UPCAST(CoroutineEmscripten, base, from_);
+    CoroutineEmscripten *to = DO_UPCAST(CoroutineEmscripten, base, to_);
+
+    set_current(to_);
+    to->action = action;
+    emscripten_fiber_swap(&from->fiber, &to->fiber);
+    return from->action;
+}
+
+Coroutine *qemu_coroutine_self(void)
+{
+    Coroutine *self = get_current();
+
+    if (!self) {
+        CoroutineEmscripten *leaderp = get_leader();
+        if (!leaderp) {
+            leaderp = g_malloc0(sizeof(*leaderp));
+            leaderp->asyncify_stack = g_malloc0(leader_asyncify_stack_size);
+            leaderp->asyncify_stack_size = leader_asyncify_stack_size;
+            emscripten_fiber_init_from_current_context(
+                &leaderp->fiber,
+                leaderp->asyncify_stack,
+                leaderp->asyncify_stack_size);
+            leaderp->stack = leaderp->fiber.stack_limit;
+            leaderp->stack_size =
+                leaderp->fiber.stack_base - leaderp->fiber.stack_limit;
+            set_leader(leaderp);
+        }
+        self = &leaderp->base;
+        set_current(self);
+    }
+    return self;
+}
+
+bool qemu_in_coroutine(void)
+{
+    Coroutine *self = get_current();
+
+    return self && self->caller;
+}
-- 
2.49.0


