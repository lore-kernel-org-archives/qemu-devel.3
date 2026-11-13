Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DBC606A33E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hRWiov6z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRnYW-0000bQ-45; Fri, 13 Nov 2026 04:26:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xRnYL-0000WD-7P
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:26:39 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xRnYJ-0005zO-HY
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:26:36 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2ed3d8877e6so10060015ad.3
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 01:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794561993; x=1795166793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Aa1Se10rnJvM268DxeWKC18tnn8TJ+vPA37YY/Vutk4=;
 b=hRWiov6z52UcwY+t7JuzrRCC7ZN+DXnZZj8+nPHHjoPC+AEW9Pw0wz8PC+n17huv19
 nuaI23FAL9NWKvAQ411MFmeokocJp7PdoiNvzqpo9t2fXKOEVT/EURRJZPDa42U/DZd/
 rwtIU9bFWmnP4t4qw+6iMOH9xy2BMX7Uo0KuJpcoLGOUjx75W8YAaeo2ioilEGbzrXuz
 QirvidpOKxlMc18C+ZCeK+imvkd6Jl/JF8wAUZVllne8/WFNvo+4BR+Vb5fNbYVfjHxz
 VObLH9pO/YMdqizMhm7fof0oX9w/J7jOZXw8QQuXf/DvWFQ5xMc2MsIL0DVWYajA51xr
 bOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794561993; x=1795166793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Aa1Se10rnJvM268DxeWKC18tnn8TJ+vPA37YY/Vutk4=;
 b=U+LTOZKap6KCW7pyDC+oU7xOpoWUxDvxznJ/G4J2Yys4KVywhqyejwApJd4rhGEoWH
 fyvsCCZJMijxoaq9MM8DGoP1pWE3QyQTnwT6mNJ28+rwcMUtB6xU9ceToiOCz2uGNuue
 FkpROOiEM9GF9R+5KT0uH96nXXBtiaPnn3XDKtyR+pCOgiWpMd5J2T/7Gg8sNdwaKL/L
 Pdgiib5Fs1jkaFTY1DlxvSMs/CB9TswlVGxWaq6oZCKUweTeCnEG1T8BEQwKrraQr6pS
 otLzCfw5NJqboWXawpE2eVkUdV2vWY4iE9iVZ0Kv6TkToNdARUaV2TgBFTEcI4t4CyNM
 I7Wg==
X-Gm-Message-State: APuU4Z/47G7USoxITYoepVf4OUgSVW2Yoy5+VNOXBzTkkUtsNbBIBalm
 yvA6BpUzEJPsBrqi557dhNGX9uSQmD19MlBPymVf4lNcwQjR+DEAuLNNI8iY1mPZ
X-Gm-Gg: AYBFou231SE/1sK75sXma1tj0jYF1ntxdS2iAHjKLLptYX/h0e2out3lXv5uO/ppYFp
 shq04UJ2Id0AVirdAuVTOgklCPwVyaCmqVPgYCsK+GxkxLXK1FAkLBRVgoBbNwv+fGcp2O3mEfo
 tZQGI4H0ZuS8frTFMUpH9YiUUFgE1QzHg8fQAick2xTbDRRNeBWK9oP2kcx0KBcRaMwU/0HMnIS
 bIwh838gY5QDJ1uJEKvqn5VrMlhOpykw6CclyyxNmZdMp5Npw1N0yYKTWrEg9ZuuPu9k/cbUnik
 fNd+0O08A4bjNXcxGYTtLmVd1EGeQAEY88czf/0d1kKMoR7P7urgqaW3MLhz4pGgO+hBD+yf3/C
 AiRP/Z/Amy39ukY00VSyGobg/UIk5vimduDtorJ0Fp0W1K8BRNCEDmkwQAP13qrhLaEW6i97LmC
 tB0MOR3FCqPwpT0LcpSFuzz1OJYkLArBTqvY+X1xLd8K/la4aMEZsCXM6oVr2Vl4dBcE1Hg8Nvy
 qltOErY2FBVvGQO/LKXSKyqBuiEmH24Y2Z9s3VJxOFVsByfydaRLxRxBtIkC8CiX8bOqx4/oNyV
 lYW2WM5otu9ZTRQmiPWnz5NJzJCqzPNjLnYCIYI0ACvl68C1noF1XHjh2uE=
X-Received: by 2002:a17:903:1c2:b0:2ec:ff7f:6f8 with SMTP id
 d9443c01a7336-2ee0deed26amr23259825ad.57.1794561992589; 
 Fri, 13 Nov 2026 01:26:32 -0800 (PST)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ee0f7d0887sm7428605ad.32.2026.11.13.01.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 01:26:32 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V20 02/14] iothread: add holder-aware AioContext accessors
Date: Fri, 13 Nov 2026 17:25:53 +0800
Message-ID: <20261113092605.942292-3-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113092605.942292-1-zhangckid@gmail.com>
References: <20261113092605.942292-1-zhangckid@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x630.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index b9889be845..774c356b71 100644
--- a/iothread.c
+++ b/iothread.c
@@ -34,6 +34,11 @@ void iothread_ref(IOThread *iothread, const IOThreadHolder *holder)
     assert(holder);
 
     QAPI_LIST_PREPEND(iothread->holders, QAPI_CLONE(IOThreadHolder, holder));
+    /*
+     * This guarantees that the IOThread and its AioContext remain alive
+     * as long as there is a holder.
+     */
+    object_ref(OBJECT(iothread));
 }
 
 static int iothread_holder_compare(const IOThreadHolder *holder_a,
@@ -79,6 +84,7 @@ void iothread_unref(IOThread *iothread, const IOThreadHolder *holder)
             *prev = curr->next;
             curr->next = NULL;
             qapi_free_IOThreadHolderList(curr);
+            object_unref(OBJECT(iothread));
             return;
         }
         prev = &curr->next;
@@ -200,7 +206,7 @@ static void iothread_init_gcontext(IOThread *iothread, const char *thread_name)
     g_autofree char *name = g_strdup_printf("%s aio-context", thread_name);
 
     iothread->worker_context = g_main_context_new();
-    source = aio_get_g_source(iothread_get_aio_context(iothread));
+    source = aio_get_g_source(iothread->ctx);
     g_source_set_name(source, name);
     g_source_attach(source, iothread->worker_context);
     g_source_unref(source);
@@ -422,6 +428,22 @@ AioContext *iothread_get_aio_context(IOThread *iothread)
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
2.53.0


