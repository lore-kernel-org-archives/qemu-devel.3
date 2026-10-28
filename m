Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B998606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TG11WZBC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLzvd-0006tA-Eb; Wed, 28 Oct 2026 05:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xLzvb-0006sX-4W
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:26:40 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xLzvZ-0006fR-Dl
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:26:38 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2e812e2b31bso3883645ad.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 02:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793179595; x=1793784395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rIUTlELGNNNkAoHqgdJyqZqXtRy4dZzDoVcLYBQBIBU=;
 b=TG11WZBC+IWee9ofRVJfX9/TldRBu2LLalWRPxH0rvkACvPEpOTdRHdJOBWKJAK5+D
 0RCkVhMpwzwqhkknWvOdED9gmJTC2PKxv0eEc+hiC443ZecnFgeHVWhYEzhmNZ7A/DKi
 rRIQ7HLx8L6YG6HGOlqFzgv0682a8lF4XDqmowtiWngt85g87oJhreVteGVfW9cegfp9
 xto0MseiQsnLj4Gd13t1P3hY2MUGO9TmvVkWyges2PFl3ZmNMOSMd+7byEkV+qYKdBPC
 9jHrRNZkLfNLjr4QP27Qs6tIB/AXgGC9SZ9qyYekyfbhyMnSWRK/HT6gEWc3iir7F4nU
 Rg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793179595; x=1793784395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rIUTlELGNNNkAoHqgdJyqZqXtRy4dZzDoVcLYBQBIBU=;
 b=EUT5lBU4lAghoNycQ3wmVCi0S5H64YCSu0B58MntHhm9UOPpHSV9aD0f0Z5tXBhp76
 K+QG2TWe5pbfkvHbsmQXAQt7R3/zLz0HaOB4LZzhrIGfL9bXXDtptIvMafsGVD0M8r2Q
 9s5lw2nF98BBs3/ehedkQsJ+pz6XzmtwH7bczR3zaYRSdxtiv1izP5f6WQrkJ7Gr+SWI
 vGyIbT+Dg1eFiZ/FlRpVl5U/Nc19ONqAmPBnqhzFhfMhO67RDNu/FSD0RPSfoRmPIbuc
 jlP0H1KG35bSWy6q195PtZBGQijMLYfrolb9LXYfSMieWIdp1JxYZpwKdb4PE90iHwmh
 WM3w==
X-Gm-Message-State: AFq9FYL/LCCFb2l7qfkKwIsmyLui1/Jq1jwo18h6GI2nVsXgJT67QAlD
 OAWJ5qGiTUsAKskYlzHXvlsA/LqoWYjpfqBa9fkSAU8WI7KuKjMzUHU8FEN3YkL7
X-Gm-Gg: AYBFou0Utrt0T1YxGpPr2HBTy25Ly3m0IfSCE64EqQPxtWoBIUd5AFeNY8uqSGvn3yP
 xghiProBXKg+G0/orh/6Jc4Ja4oB/K+10zd96Ibc7IL0z5gamIH77sx7WpZC30hNOWDAMQyJY/1
 vGEJsUdR7MkGUzNnFKlO/YiDMd7l71kiVE3ZWrfeLvgS3+lsB9wkZKturBptqyjn+YDH1B4d7j4
 X3zBp87KIwih7OEW3Mc6IKLqv/zYOetFjp9klQlhTaGv/6uuBKtQ0vlO3jL/lZoiDVIWvFBWO/A
 0yyPLjWcBoZp9l0Dx0u6WmT4LS/Vcp7PYx2+EOx5Rgn2M7544i/uy2EQlayiyhU+wY8uy68yg0/
 zmnff980pS86KOXs7BFi7aVFX/Y/rWKBG673z3q8zd7l2CMd0Vg040TRlo3DOApkjbX+fpLNRfu
 URPSaVWn23KidacBep6QmtRB4RNzOARVsvdJHRjQ4QCmVjbMYihisFHoXa6IDSmdHlkymrmVyGD
 mlT07kE3uuhxUsHWPaQX7mpsUFRnI1tYmeqhDY2FWTWIh9aWi+yp+7ll3yC2lK/hfyCNkgvVRrD
 qUAPQrlmPkZAfMDEvfP4Zk1TFXD8j8/XfB4qG+wsd00+pTbTt/JHKosse/dMEJt2PjkJhC9JCmr
 kf3Fj
X-Received: by 2002:a17:902:f707:b0:2ea:fcdf:9260 with SMTP id
 d9443c01a7336-2eb0042efb8mr18677135ad.53.1793179594916; 
 Wed, 28 Oct 2026 02:26:34 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6b7a691sm19481635ad.26.2026.10.28.02.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 02:26:34 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V19 02/14] iothread: add holder-aware AioContext accessors
Date: Wed, 28 Oct 2026 17:26:07 +0800
Message-ID: <20261028092619.1654474-3-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028092619.1654474-1-zhangckid@gmail.com>
References: <20261028092619.1654474-1-zhangckid@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62c.google.com
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
2.53.0


