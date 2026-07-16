Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E885C44515
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkNJT-0007EP-7U; Thu, 16 Jul 2026 10:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkNHX-0005ut-OD
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:41:49 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkNHU-00078l-3P
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:41:46 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2cad4170e8eso85460395ad.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 07:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784212901; x=1784817701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HCRIGz+meMvB1Fw1XaOb2hIZjHMSMXvcXe7z6nBrirk=;
 b=G7QOIu1/P6Fu0tx4WMfLkRRAFQeMrg6hVfMe/H6IPB35KC/Z+9a1BbXvNes0Esqrk4
 dEwCqVDlUqw9Zg3Y61/Zzn4L4izcYoKVxrt79U6vGmx2UfSSiD2H8GywNQYlRxxr1CsW
 bmzhc3EGL+w4EHCTwlyvPMENhmvVeejlkpSU/rtNPXK1Es7X3eCzKxBcEnmt+rcfp3D1
 mO+T/a+VunX1gpvnkARNuXM24L6enjc2jKemRvpNSvbAhobdGj0xoiTvbsdeuLHd63tP
 hEpxPFXXSZ+Ogem+9/fvB1zZsUJSKVtbMu9DA/Xt39q6uiKnGd1E7Ec6mJ1TPQ5250Ac
 QcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784212901; x=1784817701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HCRIGz+meMvB1Fw1XaOb2hIZjHMSMXvcXe7z6nBrirk=;
 b=afIc2oF8VnjrJWnG4q+W/PMQXB64HQoYvJiWv2NTMUrFRcOt6QaxZQvuPe4T5nS18d
 CLhYYZclpVS3p8TubA4aed61ne92tk1u1MFdAlk0/N7UFQGfFA/NMYpNNzWGqrDeZl3F
 cHps2LhDPwICaOMMwAeZG3Ci0bdN0dcCPOJQ0fpWIez4m9e4ZwOZYGnxHUKlHJZqkOGJ
 R2EimHvsvCwYVIKH0WjO+juVZ69olOYauq9jMxGZc/Rm58U/g3ke3fROivgZQlDQ65Es
 bSVxKSKDRkr7r2Z5SoBWO953kJlf93Gl/Rnm++9CW7I987m88zV86wOmftlvFKoWv4RG
 Aq+A==
X-Gm-Message-State: AOJu0YzwQOZNAz/NDMZNJ36tjqDz9h3ZPKKRgJLgKb6dE83NDTzb1Sr2
 YDa4iimUx6lF3qE7tFtJchePt+fLo0SWsDokrz5nbZ3ElcWZXSFKr0OnPPwpIc1chvI=
X-Gm-Gg: AfdE7clkblGL/YubefNmAUnj4T2IykNzuB/RjC7ujgPGmwPewrQXJY4tQ0Tpz07jnLb
 o7kxDBEnZAeK8DnnQtWI6d9BPHQv0jtgUQuJcr/k3CuEA/G5GxjaKeQf+roPf2bzzlo8VJWrBeR
 BhCJUKEEqpzEYIY42HrH9YeDI7ZCHGuiHtmeVdaYUn22GsrkgIwiTKn9gHpz8mZ/6VnBsXpcY46
 lNrAsXCcSFRgzROdCsEgz+rCNZ3zBFVNrTbtTl/38dgm/AczMsbMrZhkqlPmM/2m5knRCgmLMFp
 cKeQW6cgSnkYBWaK471ZN1myS/KwwicRYN7QvAIjWzER8V/ccb7OV+q8zoY4zQ7r2yoeJkrST/j
 UtQk1LIJrusboQeRSbBCJ6Vz+EKf41NAkCUc58P3F06gq26XNwlXnCs+3OuzAhXtHb8UiQNV7iE
 0IGd8Fop6KH3VXWUVNNz+vs7bdl5FKY126DdvQgon5
X-Received: by 2002:a17:903:1a0d:b0:2cc:6329:b7ba with SMTP id
 d9443c01a7336-2cef1328355mr124745345ad.16.1784212900985; 
 Thu, 16 Jul 2026 07:41:40 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49::677]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf100e42a1sm20991165ad.15.2026.07.16.07.41.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jul 2026 07:41:40 -0700 (PDT)
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
Subject: [PATCH V10 03/15] iothread: tracking iothread users with holder name
Date: Thu, 16 Jul 2026 22:40:28 +0800
Message-ID: <20260716144043.76414-4-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260716144043.76414-1-zhangckid@gmail.com>
References: <20260716144043.76414-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x636.google.com
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


