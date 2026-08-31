Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE0FC624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x14Rx-0002LM-JG; Mon, 31 Aug 2026 12:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x14Rg-00025Q-JK
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 12:01:24 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x14Re-0001Vb-Ov
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 12:01:16 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2d6d28aa26cso25855435ad.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 09:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788192073; x=1788796873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W884SMK/ObSjn0HriCAb/q7q3xniAJ75u4sPHtyJFWw=;
 b=q4z37CnxitvbMvz01zF2kkK95WshiF0uUcx3SlmUTILv2YYdMNH3PdCSTPkUljuQUH
 kXPODz0+aYhgxGvkTeuMveyg+6YRQUi8p2BlhATECqiyp8zQY4ELrUVzMO93+K9YksX2
 o5P8Wj4jDSwPt77D9PBaSd4yxvSvzWnC3KK3uco+S0no5rVzYEDEZw3R/jS7DDqI6ypn
 Ocvqm5DTYR6m+ljveWpg5mq/cm74hcefxQfike2H14eQHFNCmTrDeLEX+b/mkF191dFH
 jnw+QM+mTnmg2yzzlaH84tF/eJE5vanqqjJ2aNrDQ2iy50aAfm7lqdm7qyKRR5kB6m1q
 d9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788192073; x=1788796873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=W884SMK/ObSjn0HriCAb/q7q3xniAJ75u4sPHtyJFWw=;
 b=niImoui0M8t8Y71Giu/PC1B3xzA9ZKL/elV0gsWN1OdCKXr605hLb4ceAJDWgB+NQs
 7reHQwGCZG4CJfb2Rme2N/AWLWNmHAuB5KbbITrOdWq/UFhn9M+PImlE9XnOtKgWbtBt
 NlxQXi9Kfo+8lsYUpmRzcaBisL70VS7+JB7+GfhVuKoH386cktvWz+Rz/sCURgwSzLN0
 8tOQ/1+Bpj0w8FBsomE7+FhalZcA8Oz5Opr5oOkNi3eStlqyHPpPv0FiCADnGe0RDgFy
 bWIXQ0atvpCvCzFuW2yRFZp2Luf4LKFoN5I/9EE3d7ciZhwOLfKjHAEuS2KIGtmAuQFW
 tI5w==
X-Gm-Message-State: AFuF++lQ7kujDKJMRI9Y+X8GxE+LXElbuwqRBh1SEEMJSslavqio6+lr
 gwcfGfJDTRsZ+YCQfOB39yyjCx+04CxmoS56guSpGfDSLyM1elchXpwpoGkZuIQlG1vYSWmc
X-Gm-Gg: AYBFou0jR6Ie5BhGBqk1IL0P7SchnUUnZZqoB8TYw1TQF75UDoaMDwspKYplrp/2l5Y
 AxtaJglKiGRB5iuEZ0TTKOHngOg/lO1LDmyE6eEn12ubVEOn8MYdIGVN+aNBRZ1pco4jah9MEj+
 gXlPJpSarruwH1prBz+P5YXN57qgQK3TO/ukjL/Z4SuuMix3iLKDJ1xmivIV0EjUtuU6c8Qwi0P
 yAJbueFcMjhlzepF7h7HqD3E4aYLZMNO5KTsbk+pMNQoQC31GdTadNfFUAFxPvru+FQiyoB6dQ2
 cs0rujBkzakgt1SqEjI3kQ03i1/rRI33dAF+l+PvDk/g9bRltRkgPeDnZ/yAx3r9LU79ZWYaiqp
 zz2WQwJiEqgBaFKR229AKZRs/XUyjYrwe89LEzocyYTdXmwA7CVmB+tymJUOOmlxk2/dGq4rJJw
 bwm2XqCNo535Nvb5KCh1JJ5CjH6oyyOdNvFjgQ/RJH1GmWEf73umdw7nB8YtIj/gHX+Tudb4FHp
 bd/n8jF
X-Received: by 2002:a17:903:f8d:b0:2ca:f21a:a6c5 with SMTP id
 d9443c01a7336-2d74dbea25bmr454472955ad.1.1788192071283; 
 Mon, 31 Aug 2026 09:01:11 -0700 (PDT)
Received: from catgo-fnos.taila0cd24.ts.net ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32b28ab0571sm22689520eec.4.2026.08.31.09.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 09:01:10 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V14 03/15] iothread: add holder-aware AioContext accessors
Date: Tue,  1 Sep 2026 00:00:24 +0800
Message-ID: <20260831160038.221776-4-zhangckid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831160038.221776-1-zhangckid@gmail.com>
References: <20260831160038.221776-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62a.google.com
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
2.55.0


