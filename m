Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017A6C88E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 10:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4yAP-0006IQ-OV; Fri, 11 Sep 2026 06:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x4yAN-0006I3-P4
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 06:07:31 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x4yAM-0007Ev-3Q
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 06:07:31 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccc09d65so558819a91.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 03:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789121248; x=1789726048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Pz3DcON57YEbbfHibWzK/oVMwkZxaS7iLzoMd5bKkPw=;
 b=rh+Rpyd6NaB20CJvcW5lH+pz3ppMqamo8zO5T4Wv6/mBuUbIkCh/4WCUPkHMgDpiql
 /R+pKWCcgLQoIH7PIVNPPnKVSoI6bfNUxUl8AiIZSBVMgVVfOh/FbtZT0cjJodbfZOlN
 EGnntUpxzYNXQ8i+Q4qyxMZ9yFpZP48a7n+XEOShm3kuXwquXfNzdEq/S0/sklpHN/de
 t/VcVHaxu8NLMVcED5Hsf1pfJPLhLimO9FMpDBLYDO+hHxri82mhyKBzBJGuIhDUFGYp
 4fE6gl1NdnlkEN96Z3Vkz6/BKko3Ulam97R7fb5SZFpARU2IMcoaZtwOOnXNRRSWWAoa
 L4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789121248; x=1789726048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Pz3DcON57YEbbfHibWzK/oVMwkZxaS7iLzoMd5bKkPw=;
 b=Ar73TA6ZrkmSIsp9cmIe3kzKjyP4cC5BuD529mU6amidBJRazflD2g3R/+TzTx9bbr
 8ynsb31ozfApXS6HXMxZwzqI5ADVX3MYiTv+O+agR0u4rQL+MAHaDwBu3QtBLTMRfP1N
 S4JCJt3QeLPj8fRYjFJb4zVJ7xEqvjGhP8tJN9sxHd0Zo7339nH28oyzFBHrvSM/J/xs
 Fdf/lf2l/+c6jJjODU8gfwH/WXryygCcDKkz8ZQO7pP+bQg2ifyGwH83X/ekNfB7PTzS
 Yv9V3D7ZdWzoT8f8qU/Zgl0s8t9WixyfhvpULgBZARbhcWhyqc13VZlDFFioX4+Ukm84
 koMQ==
X-Gm-Message-State: AFuF++lbUgTqtrCR+TXdpTsnqbfQOXlshISD8a6zuh/gVTJZO/0mW1WP
 mGg+rqH4ekm3FGFg2A06xwYTtcyczA1lUrl5OqbW6LM1iC+qFJlpR9zny4VQBg==
X-Gm-Gg: AYBFou2rd6ZKIVgrpFRae2+cMz4lI5BRAPYGZdOUOSY+U/7hpgTW7Tc3K89e2NGa3PI
 Ots7wyUGVUKKLGN8p10/bHrCOP5Kg4y3gUCFqxCeUArbrzggBcjP9c8fq5DmnR8l1NJANZcJZ8o
 GIO/ZpNHFZiplzY25fU1Y2tcJhR+XBLtXisuivIjE76LowV77mgEIVlVIKta/UR2LD+EOquJaSn
 /hc4EDBlSvYSI/KB7tgJeeJRz7xGBrc5nU3/JZJfBg0SurRCw35O6AdTiB0oqocXr/ITIIAFQgU
 Gcwyes2d0GVDpfqneNm2YSLeBT1CsH2pu8usan+xTI+ysu/TsMejS+ESV/AmARQaHFUubgH97gR
 snHBW09acExlSUXJy1ae8PlHaWNxPrjZ/IsBrlICpohoLYiHakJsVyVmBSNVpdoa8GqY/b/tjKi
 oOycG2wQvIq56CR6imR6gfW+noj8hBdi+u9kNAAK+xO+fpJ/nKm+qDN51dL1aE84hRGVwbv63Rh
 j38nqW15VwZgC7daKrIVo5po/8=
X-Received: by 2002:a17:90b:5111:b0:39a:e002:f192 with SMTP id
 98e67ed59e1d1-39d9c3f0dbamr5943540a91.22.1789121248398; 
 Fri, 11 Sep 2026 03:07:28 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d951d6b08sm4514800a91.8.2026.09.11.03.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 03:07:27 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V16 02/13] iothread: add holder-aware AioContext accessors
Date: Fri, 11 Sep 2026 18:06:58 +0800
Message-ID: <20260911100709.726366-3-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911100709.726366-1-zhangckid@gmail.com>
References: <20260911100709.726366-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=zhangckid@gmail.com; helo=mail-pj2-x10.google.com
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

Introduce iothread_ref_and_get_aio_context() with a holder argument
and its counterpart iothread_unref_and_put_aio_context().

Previously, users of an IOThread AioContext did not explicitly record
their identity, making it difficult to debug which devices or
subsystems were pinning an IOThread. These new helpers provide the
infrastructure for callers to register their identity. Subsequent
patches convert existing users to the new helpers.

Registering a holder takes an IOThread object reference so that the
IOThread and its AioContext stay alive until the matching put
operation. Document the ownership and BQL requirements.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 include/system/iothread.h | 22 ++++++++++++++++++++++
 iothread.c                | 24 +++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/include/system/iothread.h b/include/system/iothread.h
index b8aeb32b0e..f6c5f95dd9 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -67,6 +67,28 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
 char *iothread_get_id(IOThread *iothread);
 IOThread *iothread_by_id(const char *id);
 AioContext *iothread_get_aio_context(IOThread *iothread);
+
+/*
+ * Register @holder and return @iothread's AioContext.  The holder is copied,
+ * and a reference is taken on @iothread so that both the IOThread and its
+ * AioContext remain alive.
+ *
+ * The caller must eventually call iothread_unref_and_put_aio_context() with an
+ * equivalent holder.  This function is not thread-safe and must be called
+ * under the Big QEMU Lock (BQL).
+ */
+AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
+                                             const IOThreadHolder *holder);
+
+/*
+ * Unregister @holder and release the corresponding reference on @iothread.
+ * Calling this function without a matching
+ * iothread_ref_and_get_aio_context() call is a programming error.
+ *
+ * This function is not thread-safe and must be called under the BQL.
+ */
+void iothread_unref_and_put_aio_context(IOThread *iothread,
+                                        const IOThreadHolder *holder);
 GMainContext *iothread_get_g_main_context(IOThread *iothread);
 
 /*
diff --git a/iothread.c b/iothread.c
index 66dfde626e..58dace351c 100644
--- a/iothread.c
+++ b/iothread.c
@@ -33,6 +33,11 @@ void iothread_ref(IOThread *iothread, const IOThreadHolder *holder)
     assert(holder);
 
     QAPI_LIST_PREPEND(iothread->holders, QAPI_CLONE(IOThreadHolder, holder));
+    /*
+     * This guarantees that the IOThread and its AioContext remain alive
+     * as long as there is a holder.
+     */
+    object_ref(OBJECT(iothread));
 }
 
 static int iothread_holder_compare(const IOThreadHolder *holder_a,
@@ -78,6 +83,7 @@ void iothread_unref(IOThread *iothread, const IOThreadHolder *holder)
             *prev = curr->next;
             curr->next = NULL;
             qapi_free_IOThreadHolderList(curr);
+            object_unref(OBJECT(iothread));
             return;
         }
         prev = &curr->next;
@@ -199,7 +205,7 @@ static void iothread_init_gcontext(IOThread *iothread, const char *thread_name)
     g_autofree char *name = g_strdup_printf("%s aio-context", thread_name);
 
     iothread->worker_context = g_main_context_new();
-    source = aio_get_g_source(iothread_get_aio_context(iothread));
+    source = aio_get_g_source(iothread->ctx);
     g_source_set_name(source, name);
     g_source_attach(source, iothread->worker_context);
     g_source_unref(source);
@@ -421,6 +427,22 @@ AioContext *iothread_get_aio_context(IOThread *iothread)
     return iothread->ctx;
 }
 
+AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
+                                             const IOThreadHolder *holder)
+{
+    /* Add IOThreadHolder to the list */
+    iothread_ref(iothread, holder);
+
+    return iothread->ctx;
+}
+
+void iothread_unref_and_put_aio_context(IOThread *iothread,
+                                        const IOThreadHolder *holder)
+{
+    /* Delete IOThreadHolder from the list */
+    iothread_unref(iothread, holder);
+}
+
 static int query_one_iothread(Object *object, void *opaque)
 {
     IOThreadInfoList ***tail = opaque;
-- 
2.43.0


