Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCC1CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcHjc-00051Y-Rs; Wed, 24 Jun 2026 03:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcHja-0004zg-FT
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:09:18 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcHjY-00033L-SD
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:09:18 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c85822059d8so433210a12.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782284955; x=1782889755; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lSVN7N0tEjZKy75a4H0lIBwRWq1dCfq0ezm3QlZHeNQ=;
 b=c41jMqpKgaAgWO59aT8PwPzrNWBdew5KhdZF1jd49FADywD/nWeYjX84vhbuuIsjxJ
 2Xp/wRquJ1oMlE20S2jY7qKE8OFrzCNPisu2ZH0K5piNupwsoOlUyOYUkvlgpneV88X4
 Ziqh/evoD8ATSoqBRMwTeZ/2zSscyklvdp41PqxbTp+KM1yIMLM5MVXy8aB7s7lGrqOU
 mtl9LT2n7du8piUfLg88jPyJOHejai6V23Fi6PgA16+0KULtMEa3zgFba0hji9cDrHHe
 p+Pax5ly6yLfklrrZ14DkMlXl1z8SVB8wFuGFSI5iphjB9fjUNnXXJenweO9H20gn+Vx
 gqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782284955; x=1782889755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lSVN7N0tEjZKy75a4H0lIBwRWq1dCfq0ezm3QlZHeNQ=;
 b=Iksw8JE0srE863Ag/hNLe6hGy+n8v6I5W5FvVM37E0ltlDM3q9kDpmvBgGQptWF26u
 3tvBz7NuWYTntM8FrH6DCJHCPocpv5i9daLlAErs7pCAKi5eER+BSie2kDrCKXPVzCUO
 xkW6SIVJZfVW8NcRxhwHZ/sxQ7Ye5rAAao3PHzbSJgP/8ngfr9oNYWEt+MFd/TBJohSp
 MhA47zJkyTEPRbpn7rGdPetLrjPCF3Jl+cypq/VMR2PxGpnmnVQ8uL/2irsCTLSqFFDx
 9/tfgHLoZeozKrx7bfb3JRPaPXwhfJtJLwls6mNHOCuE7SPlvTyoM4nJ7Sw7OF0+tUpw
 Ypww==
X-Gm-Message-State: AOJu0Yy9b/PaUKDwGDa99q6yNhPUHRIuoPHH8SVfo+dhELtUcC7XKmd5
 6bkIeaK1G28JNGWzlbgKoYb6xF+8X3BlrQq8/621GOtAg+M/s0ociKhRfqnz9vTREes=
X-Gm-Gg: AfdE7ckgPFZwvfXcKxcZA9Xke99A33MHRsaLMRvuK/YAl22+YCpF/+x6P1nu/KMIfbB
 EO7e9f6gZ/CZ3qgm3UgZ1x4fy4WKXlL0+gpV4U4dfSz4erv3nnkZC2WRceG03LCg5JIskUfnYJK
 hCAU2MiG0lgOpkr2jhaM0Sr8Tuc+jjolUpMH4Pv0zlYbJgCWaocBEZhHpfJkwsPHsN8S3t0OFRt
 RAW7gt4dkCAN/p9+TtC4Z2xCwHU6y1Gad+a+SV3laQFhO1e1wKBBzOfKwF45TAgs21nL9fUY/R+
 XfgB2r/Yzb0R3KdRqG9fqMPnIK7KM0toCf4sbf6SKKmng33qlKRwN9AgMMbibNpDjggCSzmGS1h
 JIi9XGWrZRyxSkJD90M4avdvF9dG65yyfOI1IB9q7sbXRI6k+B3zoPMFSlmTjdBW6L6G5KJqSpI
 BcOH+N36OHa/usbKYKaLb9NZTiGuR9NU+XAymun5RJ4YpX8Z9r7jhb
X-Received: by 2002:a05:6a21:3403:b0:3b4:93b9:2b91 with SMTP id
 adf61e73a8af0-3bd2d06a58fmr2620736637.12.1782284955331; 
 Wed, 24 Jun 2026 00:09:15 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49::1277]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8bc2c8e92asm10736569a12.2.2026.06.24.00.09.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jun 2026 00:09:14 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Fam Zheng <fam@euphon.net>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V9 03/17] iothread: tracking iothread users with holder name
Date: Wed, 24 Jun 2026 15:08:37 +0800
Message-ID: <20260624070851.13342-4-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260624070851.13342-1-zhangckid@gmail.com>
References: <20260624070851.13342-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x529.google.com
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

In iothread_instance_finalize(), we now retrieve the source name from
the GMainContext to correctly unref the initial internal holder.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 include/system/iothread.h |  4 ++++
 iothread.c                | 31 +++++++++++++++++++++++--------
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/include/system/iothread.h b/include/system/iothread.h
index b9207ad829..b483bbfab3 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -18,6 +18,7 @@
 #include "qemu/thread.h"
 #include "qom/object.h"
 #include "system/event-loop-base.h"
+#include "qapi/qapi-types-misc.h"
 
 #define TYPE_IOTHREAD "iothread"
 
@@ -70,6 +71,9 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
 char *iothread_get_id(IOThread *iothread);
 IOThread *iothread_by_id(const char *id);
 AioContext *iothread_get_aio_context(IOThread *iothread);
+AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
+                                             const IOThreadHolder *holder);
+void iothread_put_aio_context(IOThread *iothread, const IOThreadHolder *holder);
 GMainContext *iothread_get_g_main_context(IOThread *iothread);
 
 /*
diff --git a/iothread.c b/iothread.c
index 3301b8d495..528002c34a 100644
--- a/iothread.c
+++ b/iothread.c
@@ -55,6 +55,12 @@ static void iothread_ref(IOThread *iothread, const IOThreadHolder *holder)
     }
 
     iothread->holders = g_list_prepend(iothread->holders, h);
+
+    /*
+     * This guarantees that the IOThread and its AioContext remain alive
+     * as long as there is a holder.
+     */
+    object_ref(OBJECT(iothread));
 }
 
 static int iothread_holder_compare(gconstpointer a, gconstpointer b)
@@ -109,6 +115,8 @@ static void iothread_unref(IOThread *iothread, const IOThreadHolder *holder)
     IOThreadHolder *h = (IOThreadHolder *)link->data;
     qapi_free_IOThreadHolder(h);
     iothread->holders = g_list_delete_link(iothread->holders, link);
+
+    object_unref(OBJECT(iothread));
 }
 
 static void *iothread_run(void *opaque)
@@ -223,7 +231,7 @@ static void iothread_init_gcontext(IOThread *iothread, const char *thread_name)
     g_autofree char *name = g_strdup_printf("%s aio-context", thread_name);
 
     iothread->worker_context = g_main_context_new();
-    source = aio_get_g_source(iothread_get_aio_context(iothread));
+    source = aio_get_g_source(iothread->ctx);
     g_source_set_name(source, name);
     g_source_attach(source, iothread->worker_context);
     g_source_unref(source);
@@ -442,17 +450,24 @@ char *iothread_get_id(IOThread *iothread)
 
 AioContext *iothread_get_aio_context(IOThread *iothread)
 {
-    /* Remove in next patch for build */
-    IOThreadHolder holder = {
-        .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
-        .u.qom_object.qom_path = (char *)"tmp_path",
-    };
-    iothread_ref(iothread, &holder);
-    iothread_unref(iothread, &holder);
+    return iothread->ctx;
+}
+
+AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
+                                             const IOThreadHolder *holder)
+{
+    /* Add IOThreadHolder to the list */
+    iothread_ref(iothread, holder);
 
     return iothread->ctx;
 }
 
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


