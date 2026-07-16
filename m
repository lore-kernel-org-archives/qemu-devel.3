Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A311DC44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkPmG-0005po-IO; Thu, 16 Jul 2026 13:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkPmF-0005pV-3k
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:21:39 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkPmD-0000SD-KO
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:21:38 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c9d1fff21edso4529075a12.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 10:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784222496; x=1784827296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HCRIGz+meMvB1Fw1XaOb2hIZjHMSMXvcXe7z6nBrirk=;
 b=WX9hGgizeDWjH4orI+nh6/OJbWff9Pt0gDz0U2GMWv+KFJuWh/OeTVq9MPubSaLgj2
 OtG5tivDqIYSmkPsbPqw/KTyiEvYB/jyVhKw/nGOzPHXA9Iwq6KZuo40wAd66ZikvW2c
 N4YJUl9ZmmywYYNayEw6D1z4zw01pzKyPVFNXTLT/1SJhZa0fbuv0sg0j/jsDcJE/vs3
 DEv3bxokIkF3798w16HGAzfcPIKQ1eflowzlb44sthURF9M2UziVVA8IbQHYtFcneOI4
 GJeL6ZJf21rkgEqe7RqAX3nraIXxf6S4ADxPdyn/aCt8/xAm6xphcjz/Omy6jAOo36Gx
 J+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784222496; x=1784827296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HCRIGz+meMvB1Fw1XaOb2hIZjHMSMXvcXe7z6nBrirk=;
 b=Hg7Co/bIG9sEhIiqn0WuL5TWfhxKQKk3uJCY1foH6AamKv278RLMr6D02n3qQ6sg7w
 bzTXTj5D7oaoc2qWnlPCb81T/MfDSsXyoiJU3AD0f+F5sdcJORLnmxqn6uIy5xoi/EEy
 BQ4aORdf7f5Ec7Gg7yy6bGFA7lTkcSGvt1r5rQOxbykToo/5Bc3S1K9MY3YBdyW2yFtM
 ledxTlEF+Ca8jk94/CzD6aG48GfBb9w1QQNsbLvyjrtoHBY2/wq+adLhn1Lgy1B+cHR4
 jvyWEd8MVv79JVoTS1SPoIORf+AJFiJmdLFeQ7mJKLudqYUujYXAItA+FhyiqDb/dE0R
 d7VA==
X-Gm-Message-State: AOJu0YwGWWt6U23PDIWVPZ4Fr2taFY44cdkoxH74uCg1CFmD9RYkXOf0
 z8B7R5+iZdQPuqyk0p0gsk+VE9g/kBZYlY9ZuLkJAetvdgXsRZJN6czzUMSvXJVvW9U=
X-Gm-Gg: AfdE7cngRSsyCypnjFTmhbLfFGgleNZvTAkUJB4kR+eNKJrh0D5753G6JLmFoOp6HdE
 v3Bg2FxvJrj3kojChPsgjLSwlur2JJ3/VoDCH5rKwkAekswAZ4l1anJwrz1xHfM2BFRyyckMcQT
 CCm15coPmb+a9UZMFjwaKB2Ru2PunJz92xgs5IpYbUN76cCBxdLikto0r9annyCY3ruM/Yqepk9
 m7zPsiqzUTdKpQUA27Rwm+GI1L1YHqpBloF+vyuW25+LZVzKvObD6n+zPJg9/rYTaNjjIfH3Nje
 zTlABC1F8Vt7ikyK70AWw13ZuZHbnm54+jKKDQcuneDFsTz4zFsyFl9svTqGw9X8y0BODps63BC
 vLBow6OWBDgPn3RxmETGLpCI0SDsfIz9AuMY9wiGWTr+YV4EK80CRyCVCn4B6RuVuwQ9xrZfj3r
 rz1jAGieauhxegQPcaP5sqyQJgYgU4uA==
X-Received: by 2002:a05:6a20:6a24:b0:3bf:96c6:78a9 with SMTP id
 adf61e73a8af0-3c34d5284b7mr14045883637.2.1784222495817; 
 Thu, 16 Jul 2026 10:21:35 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.28.233.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e5326c0sm16800417eec.11.2026.07.16.10.21.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jul 2026 10:21:35 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [RESEND PATCH V10 03/15] iothread: tracking iothread users with
 holder name
Date: Fri, 17 Jul 2026 01:20:44 +0800
Message-ID: <20260716172108.87700-4-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260716172108.87700-1-zhangckid@gmail.com>
References: <20260716172108.87700-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: 26
X-Spam_score: 2.6
X-Spam_bar: ++
X-Spam_report: (2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Introduce iothread_get_aio_context() (In this patch named
"iothread_ref_and_get_aio_context" for build, will change the name
in the last patch) with a 'holder' argument and its
counterpart iothread_put_aio_context().

Previously, users of an IOThread's AioContext did not explicitly
record their identity, making it difficult to debug which devices or
subsystems were pinning an IOThread.

This patch enhances the reference counting mechanism by:
1. Automatically incrementing the object reference count when a context
   is retrieved.
2. Tracking holders using iothread_ref() and iothread_unref().

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 include/system/iothread.h |  8 ++++++++
 iothread.c                | 23 ++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/system/iothread.h b/include/system/iothread.h
index ef0b2f9648..86f02c5a7d 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -18,6 +18,7 @@
 #include "qemu/thread.h"
 #include "qom/object.h"
 #include "system/event-loop-base.h"
+#include "qapi/qapi-types-misc.h"
 
 #define TYPE_IOTHREAD "iothread"
 
@@ -72,7 +73,14 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
 
 char *iothread_get_id(IOThread *iothread);
 IOThread *iothread_by_id(const char *id);
+/*
+ * The iothread_get_aio_context() and iothread_put_aio_context() are not
+ * thread-safe and must be called under the Big QEMU Lock (BQL).
+ */
 AioContext *iothread_get_aio_context(IOThread *iothread);
+AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
+                                             const IOThreadHolder *holder);
+void iothread_put_aio_context(IOThread *iothread, const IOThreadHolder *holder);
 GMainContext *iothread_get_g_main_context(IOThread *iothread);
 
 /*
diff --git a/iothread.c b/iothread.c
index 38f273c0e9..f5d4708b25 100644
--- a/iothread.c
+++ b/iothread.c
@@ -39,6 +39,11 @@ void iothread_ref(IOThread *iothread, const IOThreadHolder *holder)
     assert(holder);
 
     QAPI_LIST_PREPEND(iothread->holders, QAPI_CLONE(IOThreadHolder, holder));
+    /*
+     * This guarantees that the IOThread and its AioContext remain alive
+     * as long as there is a holder.
+     */
+    object_ref(OBJECT(iothread));
 }
 
 static int iothread_holder_compare(const IOThreadHolder *holder_a,
@@ -85,6 +90,7 @@ void iothread_unref(IOThread *iothread, const IOThreadHolder *holder)
             *prev = curr->next;
             curr->next = NULL;
             qapi_free_IOThreadHolderList(curr);
+            object_unref(OBJECT(iothread));
             return;
         }
         prev = &curr->next;
@@ -206,7 +212,7 @@ static void iothread_init_gcontext(IOThread *iothread, const char *thread_name)
     g_autofree char *name = g_strdup_printf("%s aio-context", thread_name);
 
     iothread->worker_context = g_main_context_new();
-    source = aio_get_g_source(iothread_get_aio_context(iothread));
+    source = aio_get_g_source(iothread->ctx);
     g_source_set_name(source, name);
     g_source_attach(source, iothread->worker_context);
     g_source_unref(source);
@@ -428,6 +434,21 @@ AioContext *iothread_get_aio_context(IOThread *iothread)
     return iothread->ctx;
 }
 
+AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
+                                             const IOThreadHolder *holder)
+{
+    /* Add IOThreadHolder to the list */
+    iothread_ref(iothread, holder);
+
+    return iothread->ctx;
+ }
+
+void iothread_put_aio_context(IOThread *iothread, const IOThreadHolder *holder)
+{
+    /* Delete IOThreadHolder from the list */
+    iothread_unref(iothread, holder);
+}
+
 static int query_one_iothread(Object *object, void *opaque)
 {
     IOThreadInfoList ***tail = opaque;
-- 
2.49.0


