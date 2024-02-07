Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAAA4C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 02:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXXhJ-0004yZ-3P; Tue, 06 Feb 2024 21:30:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXXhG-0004yI-8N
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 21:29:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXXhE-0003rJ-Bq
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 21:29:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707272995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FHKoqWeCkfwWmqm4OjvcEjLYYI3Y6rD+/+1+wEjf/so=;
 b=bhhXcTuY4ykeHKTVEoggbTu+xvNGbsodDqMTwc3geOfOWLHooGpsBbjm3Fx1PCl2xjqrjz
 /tfr6xd5tBAOSjbpuf4HdZZKWgx2xVcPRwp5pBIMTzMxQXtjPy5LEyluQ0srxb1TqbYvi1
 4rTNABart/k3jm0qas1ouA5JX+DsuiY=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-UhjJPBmOOAKW_hQ5b-9G6Q-1; Tue, 06 Feb 2024 21:29:53 -0500
X-MC-Unique: UhjJPBmOOAKW_hQ5b-9G6Q-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6e02f10287cso57915b3a.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 18:29:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707272992; x=1707877792;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FHKoqWeCkfwWmqm4OjvcEjLYYI3Y6rD+/+1+wEjf/so=;
 b=RWM1YwMwpcyyBkoR4zXGX1z1PnbC5WG93ewtp33F2FRCGJD2o8m6K/mdaN4uM3HGtH
 pLM/RWuvgTc+Dvg6kH3NmwW74Pq3tCSrZDEACbs3tfDBHO7Lybq6CAdSYOQuj71rDqQ3
 bpkpIUQ6pSgSWGWihUm80s/T2Tkk8sIExFuoZ2aUtimOT59l9d/MPFGsxgF7+76WpI2K
 Z/cn0QpCkdgjpUxAsQBMCDG8cJasA4e638DVY+eA3IFQPD/mPATUFRqFJhXXzyFfviIu
 vEIPNSnQpHZrDEiyayW7/xZWPmIMpUo8hHgY6mNyxeDeUxcC0TzJVFlaUiHYYOGkhVmH
 xuUQ==
X-Gm-Message-State: AOJu0Yw/BiQNMNybp5dNSPooENE9C0OWxTdQeEDTKxGLN/818ppirbLp
 nSfZ2Gc+WUqkiZ65u6VYs8gFC9W2acIDQ5o2SVrGFy2QhKJ1yz3bCgWzFISEdD5WiyKLbW+vHVJ
 Vhx5jt/Ce7SbrvB77HwRSw9luLp5O9+X3ZmYkxkvzdHceRqqPiZVm
X-Received: by 2002:a05:6a21:7896:b0:19e:5c91:1f64 with SMTP id
 bf22-20020a056a21789600b0019e5c911f64mr4664808pzc.1.1707272992242; 
 Tue, 06 Feb 2024 18:29:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgtrQdnOSyhAsXuOiOwlS8kin6h9Ru1nYLi7SnkTO9LQ1i6VEwBoAYywixIV5ziu+cZith0Q==
X-Received: by 2002:a05:6a21:7896:b0:19e:5c91:1f64 with SMTP id
 bf22-20020a056a21789600b0019e5c911f64mr4664793pzc.1.1707272991865; 
 Tue, 06 Feb 2024 18:29:51 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVy6R0VQgpZsCTuBUeT8qjmi23bQrCo6q3CO8dR/uJdIGpfSF7FGQgeSCQs85Bpf+8+mE2dZ3aOMP0S2sdA8jEpILiF3BcxQsWZb5K7n2GA8snlcGxU0dE=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 mi14-20020a170902fcce00b001d8e41b3f95sm233436plb.51.2024.02.06.18.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 18:29:51 -0800 (PST)
Date: Wed, 7 Feb 2024 10:29:43 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Avihai Horon <avihaih@nvidia.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v3 0/6] migration/multifd: Fix channel creation vs.
 cleanup races
Message-ID: <ZcLrF5HN920rUTSw@x1n>
References: <20240206215118.6171-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240206215118.6171-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 06, 2024 at 06:51:12PM -0300, Fabiano Rosas wrote:
> Based-on: 20240202102857.110210-1-peterx@redhat.com
> [PATCH v2 00/23] migration/multifd: Refactor ->send_prepare() and cleanups
> https://lore.kernel.org/r/20240202102857.110210-1-peterx@redhat.com
> 
> Hi,
> 
> For v3 I fixed the refcounting issue spotted by Avihai. The situation
> there is a bit clunky due to historical reasons. The gist is that we
> have an assumption that channel creation never fails after p->c has
> been set, so when 'p->c == NULL' we have to unref and when 'p->c !=
> NULL' the cleanup code will do the unref.

Yes, this looks good to me.  That's a good catch.

I'll leave at least one more day for Avihai and/or Dan to have another
look.  My r-b persist as of now on patch 5.

Actually I think the conditional unref is slightly tricky, but it's not its
own fault, IMHO, OTOH it's more about a1af605bd5ad where p->c is slightly
abused.  My understanding is we can avoid that conditional unref with below
patch 1 as a cleanup (on top of this series).  Then patch 2 comes all
alongside.

We don't need to rush on these, though, we should fix the thread race first
because multiple of us hit it, and all cleanups can be done later.

=====
From 0830819d86e08c5175d6669505aa712a0a09717f Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Wed, 7 Feb 2024 10:08:35 +0800
Subject: [PATCH 1/2] migration/multifd: Cleanup TLS iochannel referencing

Commit a1af605bd5 ("migration/multifd: fix hangup with TLS-Multifd due to
blocking handshake") introduced a thread for TLS channels, which will
resolve the issue on blocking the main thread.  However in the same commit
p->c is slightly abused just to be able to pass over the pointer "p" into
the thread.

That's the major reason we'll need to conditionally free the io channel in
the fault paths.

To clean it up, using a separate structure to pass over both "p" and "tioc"
in the tls handshake thread.  Then we can make it a rule that p->c will
never be set until the channel is completely setup.  With that, we can drop
the tricky conditional unref of the io channel in the error path.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index adfe8c9a0a..4a85a6b7b3 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -873,16 +873,22 @@ out:
 
 static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque);
 
+typedef struct {
+    MultiFDSendParams *p;
+    QIOChannelTLS *tioc;
+} MultiFDTLSThreadArgs;
+
 static void *multifd_tls_handshake_thread(void *opaque)
 {
-    MultiFDSendParams *p = opaque;
-    QIOChannelTLS *tioc = QIO_CHANNEL_TLS(p->c);
+    MultiFDTLSThreadArgs *args = opaque;
 
-    qio_channel_tls_handshake(tioc,
+    qio_channel_tls_handshake(args->tioc,
                               multifd_new_send_channel_async,
-                              p,
+                              args->p,
                               NULL,
                               NULL);
+    g_free(args);
+
     return NULL;
 }
 
@@ -892,6 +898,7 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
 {
     MigrationState *s = migrate_get_current();
     const char *hostname = s->hostname;
+    MultiFDTLSThreadArgs *args;
     QIOChannelTLS *tioc;
 
     tioc = migration_tls_client_create(ioc, hostname, errp);
@@ -906,11 +913,14 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
     object_unref(OBJECT(ioc));
     trace_multifd_tls_outgoing_handshake_start(ioc, tioc, hostname);
     qio_channel_set_name(QIO_CHANNEL(tioc), "multifd-tls-outgoing");
-    p->c = QIO_CHANNEL(tioc);
+
+    args = g_new0(MultiFDTLSThreadArgs, 1);
+    args->tioc = tioc;
+    args->p = p;
 
     p->tls_thread_created = true;
     qemu_thread_create(&p->tls_thread, "multifd-tls-handshake-worker",
-                       multifd_tls_handshake_thread, p,
+                       multifd_tls_handshake_thread, args,
                        QEMU_THREAD_JOINABLE);
     return true;
 }
@@ -923,6 +933,7 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
 
     migration_ioc_register_yank(ioc);
     p->registered_yank = true;
+    /* Setup p->c only if the channel is completely setup */
     p->c = ioc;
 
     p->thread_created = true;
@@ -976,14 +987,12 @@ out:
 
     trace_multifd_new_send_channel_async_error(p->id, local_err);
     multifd_send_set_error(local_err);
-    if (!p->c) {
-        /*
-         * If no channel has been created, drop the initial
-         * reference. Otherwise cleanup happens at
-         * multifd_send_channel_destroy()
-         */
-        object_unref(OBJECT(ioc));
-    }
+    /*
+     * For error cases (TLS or non-TLS), IO channel is always freed here
+     * rather than when cleanup multifd: since p->c is not set, multifd
+     * cleanup code doesn't even know its existance.
+     */
+    object_unref(OBJECT(ioc));
     error_free(local_err);
 }
 
-- 
2.43.0
=====
From 9e574c3216f6459e3a808096d905e2554d962cad Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Wed, 7 Feb 2024 10:24:39 +0800
Subject: [PATCH 2/2] migration/multifd: Drop registered_yank

With a clear definition of p->c protocol, where we only set it up if the
channel is fully established (TLS or non-TLS), registered_yank boolean will
have equal meaning of "p->c != NULL".

Drop registered_yank by checking p->c instead.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.h | 2 --
 migration/multifd.c | 7 +++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index 8a1cad0996..b3fe27ae93 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -78,8 +78,6 @@ typedef struct {
     bool tls_thread_created;
     /* communication channel */
     QIOChannel *c;
-    /* is the yank function registered */
-    bool registered_yank;
     /* packet allocated len */
     uint32_t packet_len;
     /* guest page size */
diff --git a/migration/multifd.c b/migration/multifd.c
index 4a85a6b7b3..278453cf84 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -648,11 +648,11 @@ static int multifd_send_channel_destroy(QIOChannel *send)
 
 static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
 {
-    if (p->registered_yank) {
+    if (p->c) {
         migration_ioc_unregister_yank(p->c);
+        multifd_send_channel_destroy(p->c);
+        p->c = NULL;
     }
-    multifd_send_channel_destroy(p->c);
-    p->c = NULL;
     qemu_sem_destroy(&p->sem);
     qemu_sem_destroy(&p->sem_sync);
     g_free(p->name);
@@ -932,7 +932,6 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
     qio_channel_set_delay(ioc, false);
 
     migration_ioc_register_yank(ioc);
-    p->registered_yank = true;
     /* Setup p->c only if the channel is completely setup */
     p->c = ioc;
 
-- 
2.43.0
====

Thanks,

-- 
Peter Xu


