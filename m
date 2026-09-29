Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1989CCA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 08:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBTS7-0005jo-Cj; Tue, 29 Sep 2026 04:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xBTRy-0005jF-CN
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 04:44:35 -0400
Received: from mail-pj2-x0d.google.com ([2607:f8b0:4864:39::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xBTRw-0003lE-H4
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 04:44:34 -0400
Received: by mail-pj2-x0d.google.com with SMTP id
 98e67ed59e1d1-3a0bcdf41a3so2062248a91.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 01:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790671471; x=1791276271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ffn71e+pIgrmkpZMSuNM3s3wiDknQ8z6eWqR0ElZS0U=;
 b=iIpli9QbL8/iTfYlG02uky2uBgeIKRd7pIUduF6u7iHsKoaZG33+ipG7ZXiYl/05Nu
 +uFof/+a7wZQWSEWqLHVhPngP+76kY/c422VCZZTpB7JGMcx8VYXlhcoEsR1NgIO50dK
 gMAkcdMxuIAaG5ESHl5KjlQ/MQeP/7PbuzIBhJ89PEfRtt2X2jVm3OC2MN9lSXczBqWy
 Xd9x6AXLEfddrxXv4gx9TnesUevBmCn0IUxPeYm0Y1XnlojYWKlcJesPhehWTBFcIvoo
 QrXl5aBrNiX7PnhrS+v1JFD+PkhQ0P60dFKRYTmkk1LkvfDYG63Z/Ab2+Lb7xXACT9+/
 tFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790671471; x=1791276271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ffn71e+pIgrmkpZMSuNM3s3wiDknQ8z6eWqR0ElZS0U=;
 b=XUxoCGoByv3WcrbKDtF/GfxaE0ZEfrgml9IL54UuW+CDGimami3iqj9oypHp8t1Xd4
 qYYLTANLFiEDi0Aqvp0gdgInPaZ47/xPZCcbC6Apc5bJ8QjOmnNmCyVlw0MQlQ0t2sxh
 VFVNPSkWkf2Z7Va2nR1o+ebVz+BAiveNReAcdTncMueUw0Ni49+sCg5sHrxVljbMO8rO
 z3KnLATIYZP0uJcIdyucfUFLw0NXQ3ZOTyY+1lNN/P6dvp3Na2oGmNwAade0T36bdXgx
 nL4JUVlblbFyOsrLmjnTainDEpAWxJqRnAVMdmyF8ZIUF8rciPFVv1PSYWi47ejp17iT
 J28g==
X-Gm-Message-State: AFq9FYKGKRKhkf5le9/ekw/zw4mJgYXOZhTkDO92V3oaFuy8toDuT1fb
 2t/3zq5Gm+LjumMRU2824dPBeDG/avYVFOxGPzLfxDuz4FwcDznqcVWgYm4w+9eh
X-Gm-Gg: AYBFou17ltH7lGImLXG7SV+Sw03YcHNqJgrbg2odAf/XTzClhrd40hSgHy67yoXqFnF
 qwAuZSigy7YxoEsnRBAKk8iD6quAmhTpbu2oTEb+cWenVt/1JLtc/GLwlUuzWeMi3Cfkv/w+z5D
 ULRFQuYe/L6czqNcZNKrz2KyAJBkfsL5WAtUq6exsOoufWF5YIrVAHNG3ctmCpmOJ5OCYqsLK+1
 H8gJfGselTj7ojb71PYguGOoCyTCLTC78fw6DhjIAPJuWgJ2y3OvEs2vNV0FmTIrEDRZKpV06em
 zgHsBIEKwgomU3N66h642wnOWqJDpMXXr8X3qLiZwJ7G8L+nro+DVSdMs+UUuRc5K5virwM3pCF
 4RfcPSYfvSrwNDaikaKNbwXiucIlqcTb676UZFwf6THk8NCztL8akyWEcNCimkngfhdv6YrNQRP
 M+61HrskdSUs5qvIgAbhDd605i01SRvGDKWWyPuab7qmugVjoMx4BF52DQmRQ5USDC27mTIlF3G
 HWziUBmrIFpzaAsGREeYAjI/B8=
X-Received: by 2002:a17:90b:1b08:b0:3a4:a064:a487 with SMTP id
 98e67ed59e1d1-3a4a064c554mr1148326a91.28.1790671470972; 
 Tue, 29 Sep 2026 01:44:30 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a497e942eesm5163120a91.4.2026.09.29.01.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 01:44:30 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V18 02/13] iothread: add holder-aware AioContext accessors
Date: Tue, 29 Sep 2026 16:44:05 +0800
Message-ID: <20260929084416.1600199-3-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929084416.1600199-1-zhangckid@gmail.com>
References: <20260929084416.1600199-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::d;
 envelope-from=zhangckid@gmail.com; helo=mail-pj2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 6b0a7c557a..5a4291a2f0 100644
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


