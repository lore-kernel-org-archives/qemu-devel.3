Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FD4C35FF3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 20:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsor5-0005qr-Nz; Thu, 13 Mar 2025 16:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tsor4-0005qd-0Z
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 16:08:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tsoqy-0007rX-Ap
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 16:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741896504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v0+6bqShOgsfqYwAjYaI+zOXFfxvzy5KEGu87l7Mc5Y=;
 b=Fl3l/xKkW5VQyQRsUgRb5W5qdCDFFAVvOsffv21JZCNmhuaU1+5dMCSaR7iHXDUX672+qp
 M3aDL2/mpVEnmCBDub0ZFwlgHD3IRAkREKDts5qkU/AnCFL3bFGYQYJAsYL/OYDbwTfUZk
 rNMnyqFvfT1NtPb2n6zXS6mphggoZkk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-Js_iGOq-OXqQpJp70R8ITg-1; Thu, 13 Mar 2025 16:08:22 -0400
X-MC-Unique: Js_iGOq-OXqQpJp70R8ITg-1
X-Mimecast-MFC-AGG-ID: Js_iGOq-OXqQpJp70R8ITg_1741896502
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c548e16909so140435785a.2
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 13:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741896502; x=1742501302;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v0+6bqShOgsfqYwAjYaI+zOXFfxvzy5KEGu87l7Mc5Y=;
 b=rZuYMsIgmWQNQNJNfMcI1XVcMyNpNsclS2gcecLyFhraZItGoY/9QRULRDEDRvdX/C
 dwP7ruw2dOiXU0ekaB0qtQDljyv+oHGdKq2IZPx7g0NGwez5myyQ5aEZ8zV70u/DJBSp
 6nw2IHfcTcmKjSoKXoum9Ldz2hpNuIjiODue1rY0387PxNUP20N9Nan7CfY74eWy8VGZ
 S6MCSOQVyjLA9F3pjFW2qR/n9qjj1h0/PTeVhZWZP3gnN2ktQmfxZGVaVXxqkW/vcw/h
 DqURhRdEKyxtkQXgLo0BorWyGFYOj68YMqG4n29sGrH6PJ5JDKzK2KP20Pzq3diWoUhW
 CSjQ==
X-Gm-Message-State: AOJu0Yz3n17ytMOqHnZJuYzsibJGLwcAjvlpwGaQRM2dCk7OnD/914yj
 D8R/WrO1Bi3TkdGXcs3/Dh5nXE6fZaUXeuihSTqPqCmlECS7Y6LhSi6gZuN24vBAddkLhZiUT0f
 Lkgp9HkIQer19ROrVY9XKbrN/1Rf8fv4q/etnsXqdBCctAd0ST/T7
X-Gm-Gg: ASbGnct71VQvNc8DEfDSIypFOh9LO5x2sbBLt/f5vzC6u78YQJf7NLP/UwGwBTuhd2P
 UT9Kco6ZRKeJ4F0LylkfmpUVYbc/srfsbpLkrs8fwgp+9n+tf8zt2eNXYkdBXyLJ3TbANBLvk6A
 6qsj4KSDtm1JnTAsMre29nolliB2DLQtUeh/PvbbkgyoWEo+P8wiUU0tac+2KvRle9bj1K2dFFE
 +35+LcO/cX8jicTG0jJHw7Qk78g/a9uLZQUUu1MHRXq/HSsh3bXImfZ4nQBemOAyPedJL8KL5vE
 sBFqIiU=
X-Received: by 2002:a05:620a:6291:b0:7c5:60c7:346 with SMTP id
 af79cd13be357-7c579eb43cbmr140336885a.10.1741896501788; 
 Thu, 13 Mar 2025 13:08:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEo0YseDLcO+itss2u+ME0PiYVt3wzb1B27N0paUOUDNTqvlZwJ8eS0KV2k7kkOykqObwntqg==
X-Received: by 2002:a05:620a:6291:b0:7c5:60c7:346 with SMTP id
 af79cd13be357-7c579eb43cbmr140333685a.10.1741896501427; 
 Thu, 13 Mar 2025 13:08:21 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c7c6d0sm138297085a.37.2025.03.13.13.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 13:08:20 -0700 (PDT)
Date: Thu, 13 Mar 2025 16:08:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v7 5/5] migration: add MULTIFD_RECV_SYNC migration command
Message-ID: <Z9M7MYUPqHFIQPuV@x1.local>
References: <Z8G9Wj3DWSgdLkNQ@x1.local>
 <CAE8KmOxenqyqOxEFozgP1gBZPtneEqcbop9F_f+VW3ukPfw37A@mail.gmail.com>
 <Z8XBowkG72G-l3L4@x1.local>
 <CAE8KmOyssf_2RYBw2LLpxP2Z5bmtyU==Qs+4HWp=mOVb9o82-g@mail.gmail.com>
 <Z8cPnxqOvp1hFpx8@x1.local>
 <CAE8KmOw1CCQUt0wyELVhy5j-CfwVuA2XNsecW=y6rwJv7dempw@mail.gmail.com>
 <Z8hJeneeuKqD1i8Q@x1.local>
 <CAE8KmOyKiEt9t0vUwVyqD7tx01vkm+NHA1p1tmQnJ9mKY0Za7w@mail.gmail.com>
 <Z8t3uKo54T_Xls_O@x1.local>
 <CAE8KmOwdLk4oZg8TAt0z6rd27f0MpbSS54TWNDshZFU7WPxk-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOwdLk4oZg8TAt0z6rd27f0MpbSS54TWNDshZFU7WPxk-Q@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Mar 13, 2025 at 06:13:24PM +0530, Prasad Pandit wrote:
> +int qemu_savevm_state_postcopy_prepare(QEMUFile *f)
> +{
> +    int ret = 0;
> +    SaveStateEntry *se;
> +
> +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +        if (strcmp(se->idstr, "ram")) {
> +            continue;
> +        }
> +
> +        save_section_header(f, se, QEMU_VM_SECTION_PART);
> +
> +        ram_save_zero_page(f, se->opaque);

I'll stop requesting a why here... but I think this is another example that
even if all the tests pass it may not be correct.

> +        if ((ret = multifd_ram_flush_and_sync(f)) < 0) {
> +            return ret;
> +        }
> +        qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
> +
> +        trace_savevm_section_end(se->idstr, se->section_id, ret);
> +        save_section_footer(f, se);
> +        if (ret < 0) {
> +            qemu_file_set_error(f, ret);
> +            return -1;
> +        }
> +    }
> +
> +    return ret;
> +}

[...]

> * Does this patch look okay?

I've written the relevant patches below, please review and take them if you
agree with the changes.

Thanks,

===8<===

From f9343dfc777ef04168443e86a1fa3922296ea563 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Thu, 13 Mar 2025 15:34:10 -0400
Subject: [PATCH 1/2] migration: Add save_postcopy_prepare() savevm handler

Add a savevm handler for a module to opt-in sending extra sections right
before postcopy starts, and before VM is stopped.

RAM will start to use this new savevm handler in the next patch to do flush
and sync for multifd pages.

Note that we choose to do it before VM stopped because the current only
potential user is not sensitive to VM status, so doing it before VM is
stopped is preferred to enlarge any postcopy downtime.

It is still a bit unfortunate that we need to introduce such a new savevm
handler just for the only use case, however it's so far the cleanest.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/register.h | 15 +++++++++++++++
 migration/savevm.h           |  1 +
 migration/migration.c        |  4 ++++
 migration/savevm.c           | 33 +++++++++++++++++++++++++++++++++
 4 files changed, 53 insertions(+)

diff --git a/include/migration/register.h b/include/migration/register.h
index c041ce32f2..b79dc81b8d 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -189,6 +189,21 @@ typedef struct SaveVMHandlers {
 
     /* This runs outside the BQL!  */
 
+    /**
+     * @save_postcopy_prepare
+     *
+     * This hook will be invoked on the source side right before switching
+     * to postcopy (before VM stopped).
+     *
+     * @f:      QEMUFile where to send the data
+     * @opaque: Data pointer passed to register_savevm_live()
+     * @errp:   Error** used to report error message
+     *
+     * Returns: true if succeeded, false if error occured.  When false is
+     * returned, @errp must be set.
+     */
+    bool (*save_postcopy_prepare)(QEMUFile *f, void *opaque, Error **errp);
+
     /**
      * @state_pending_estimate
      *
diff --git a/migration/savevm.h b/migration/savevm.h
index 138c39a7f9..2d5e9c7166 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -45,6 +45,7 @@ void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
 void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
                                         uint64_t *can_postcopy);
 int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy);
+bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp);
 void qemu_savevm_send_ping(QEMUFile *f, uint32_t value);
 void qemu_savevm_send_open_return_path(QEMUFile *f);
 int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len);
diff --git a/migration/migration.c b/migration/migration.c
index d46e776e24..212f6b4145 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2707,6 +2707,10 @@ static int postcopy_start(MigrationState *ms, Error **errp)
         }
     }
 
+    if (!qemu_savevm_state_postcopy_prepare(ms->to_dst_file, errp)) {
+        return -1;
+    }
+
     trace_postcopy_start();
     bql_lock();
     trace_postcopy_start_set_run();
diff --git a/migration/savevm.c b/migration/savevm.c
index ce158c3512..23ef4c7dc9 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1523,6 +1523,39 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
     qemu_fflush(f);
 }
 
+bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp)
+{
+    SaveStateEntry *se;
+    bool ret;
+
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        if (!se->ops || !se->ops->save_postcopy_prepare) {
+            continue;
+        }
+
+        if (se->ops->is_active) {
+            if (!se->ops->is_active(se->opaque)) {
+                continue;
+            }
+        }
+
+        trace_savevm_section_start(se->idstr, se->section_id);
+
+        save_section_header(f, se, QEMU_VM_SECTION_PART);
+        ret = se->ops->save_postcopy_prepare(f, se->opaque, errp);
+        save_section_footer(f, se);
+
+        trace_savevm_section_end(se->idstr, se->section_id, ret);
+
+        if (!ret) {
+            assert(*errp);
+            return false;
+        }
+    }
+
+    return true;
+}
+
 int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
 {
     int64_t start_ts_each, end_ts_each;
-- 
2.47.0


From 299e1cdd9b28802f361ed012673825685e30f965 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Thu, 13 Mar 2025 15:56:01 -0400
Subject: [PATCH 2/2] migration/ram: Implement save_postcopy_prepare()

Implement save_postcopy_prepare(), preparing for the enablement of both
multifd and postcopy.

Please see the rich comment for the rationals.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 424df6d9f1..119e7d3ac2 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4420,6 +4420,42 @@ static int ram_resume_prepare(MigrationState *s, void *opaque)
     return 0;
 }
 
+static bool ram_save_postcopy_prepare(QEMUFile *f, void *opaque, Error **errp)
+{
+    int ret;
+
+    if (migrate_multifd()) {
+        /*
+         * When multifd is enabled, source QEMU needs to make sure all the
+         * pages queued before postcopy starts to be flushed.
+         *
+         * Meanwhile, the load of these pages must happen before switching
+         * to postcopy.  It's because loading of guest pages (so far) in
+         * multifd recv threads is still non-atomic, so the load cannot
+         * happen with vCPUs running on destination side.
+         *
+         * This flush and sync will guarantee those pages loaded _before_
+         * postcopy starts on destination. The rational is, this happens
+         * before VM stops (and before source QEMU sends all the rest of
+         * the postcopy messages).  So when the destination QEMU received
+         * the postcopy messages, it must have received the sync message on
+         * the main channel (either RAM_SAVE_FLAG_MULTIFD_FLUSH, or
+         * RAM_SAVE_FLAG_EOS), and such message should have guaranteed all
+         * previous guest pages queued in the multifd channels to be
+         * completely loaded.
+         */
+        ret = multifd_ram_flush_and_sync(f);
+        if (ret < 0) {
+            error_setg(errp, "%s: multifd flush and sync failed", __func__);
+            return false;
+        }
+    }
+
+    qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
+
+    return true;
+}
+
 void postcopy_preempt_shutdown_file(MigrationState *s)
 {
     qemu_put_be64(s->postcopy_qemufile_src, RAM_SAVE_FLAG_EOS);
@@ -4439,6 +4475,7 @@ static SaveVMHandlers savevm_ram_handlers = {
     .load_setup = ram_load_setup,
     .load_cleanup = ram_load_cleanup,
     .resume_prepare = ram_resume_prepare,
+    .save_postcopy_prepare = ram_save_postcopy_prepare,
 };
 
 static void ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host,
-- 
2.47.0


-- 
Peter Xu


