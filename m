Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B231EC5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 03:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reoWd-0001E4-Cg; Mon, 26 Feb 2024 22:53:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reoWb-0001Df-MP
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 22:53:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reoWZ-00013r-N1
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 22:53:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709005977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3+xhJmEmPchUQ3/u0nJClQQar8o9ZNvqwLYEkf6noH8=;
 b=gg+AY4mPJSFcg4hstF4cAAnZJXi9UxsVlKnZRCY9q13ZknY5LyUxLmnw8DO+34pgtr/pCE
 X/g6Df0h33GkNTEbYVjGmHW/HRm6SdSTCD1Fn6uWXd2S2/Irv4tjaQr1Bgq1sQUDcAFbo0
 cqmjPNHz6jIn4yNT0Mw3yrpZpm8kGtc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-yMBE_8htMT6xfTdesriJig-1; Mon, 26 Feb 2024 22:52:56 -0500
X-MC-Unique: yMBE_8htMT6xfTdesriJig-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-299565dfd2dso557712a91.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 19:52:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709005975; x=1709610775;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3+xhJmEmPchUQ3/u0nJClQQar8o9ZNvqwLYEkf6noH8=;
 b=fmxpFTRfIE4bENVtw53VmEctqmAUvX9NVz2BAM3lL340Z/u8ebnpcgST83UbfgdghR
 ILC+uTUvmBfzUnvSr2RuWMZq1wdTTLH1aI/KpK4M/6ImiBdaoUsSGDimdGjHbkDJElTS
 kRDHilavupgJ22+uGpXmYQaaI3wlT3F02CADSDEljppUnypZ1C1ImZ/JO7jQP2gVzmfb
 xrV1yC9snsHf2JNw+g9fDOSELh5HaLx0u6uTfU3nLg5hzQsPrMZtUZY7Rjx42Uz1dJVM
 xzk78IY39FWAhs9iMoxphXRPKsbMPHkod+wVcaDukN5FMrW202/KVzT7bGHVbIibnhkg
 YEsg==
X-Gm-Message-State: AOJu0Yyg1twHQ5x8PtwL5llGgr2XJE8f19Cc4EeD1Fm7qX25642N1p0g
 VeJCSkFv8lioS9L/IachnZcRFh4MtPngKGJGY3Y4u1HqP3jQgyQ7Kzx+ZN04MmV60HCN6i9aX4D
 yyrT00X1krlKQhKMe5O9mEUQKQXXmJE95ah/GXKxajse1onICKBQd
X-Received: by 2002:a17:903:2448:b0:1dc:a04a:377e with SMTP id
 l8-20020a170903244800b001dca04a377emr5021192pls.2.1709005975447; 
 Mon, 26 Feb 2024 19:52:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEP/McTBamHannExSpnq2sPdoGoOgfPna+EdkEKYoIX8JVnsEFmD4KLtzCM52dCZHIdTyHLQ==
X-Received: by 2002:a17:903:2448:b0:1dc:a04a:377e with SMTP id
 l8-20020a170903244800b001dca04a377emr5021180pls.2.1709005975018; 
 Mon, 26 Feb 2024 19:52:55 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 mn15-20020a1709030a4f00b001da2924e576sm435474plb.204.2024.02.26.19.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 19:52:54 -0800 (PST)
Date: Tue, 27 Feb 2024 11:52:47 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v4 22/34] migration/multifd: Prepare multifd sync for
 fixed-ram migration
Message-ID: <Zd1cj4jkIpUktu6k@x1n>
References: <20240220224138.24759-1-farosas@suse.de>
 <20240220224138.24759-23-farosas@suse.de> <ZdxCLmKFirsXPia-@x1n>
 <87y1b6alej.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y1b6alej.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
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

On Mon, Feb 26, 2024 at 07:52:20PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, Feb 20, 2024 at 07:41:26PM -0300, Fabiano Rosas wrote:
> >> The fixed-ram migration can be performed live or non-live, but it is
> >> always asynchronous, i.e. the source machine and the destination
> >> machine are not migrating at the same time. We only need some pieces
> >> of the multifd sync operations.
> >> 
> >> multifd_send_sync_main()
> >> ------------------------
> >>   Issued by the ram migration code on the migration thread, causes the
> >>   multifd send channels to synchronize with the migration thread and
> >>   makes the sending side emit a packet with the MULTIFD_FLUSH flag.
> >> 
> >>   With fixed-ram we want to maintain the sync on the sending side
> >>   because that provides ordering between the rounds of dirty pages when
> >>   migrating live.
> >> 
> >> MULTIFD_FLUSH
> >> -------------
> >>   On the receiving side, the presence of the MULTIFD_FLUSH flag on a
> >>   packet causes the receiving channels to start synchronizing with the
> >>   main thread.
> >> 
> >>   We're not using packets with fixed-ram, so there's no MULTIFD_FLUSH
> >>   flag and therefore no channel sync on the receiving side.
> >> 
> >> multifd_recv_sync_main()
> >> ------------------------
> >>   Issued by the migration thread when the ram migration flag
> >>   RAM_SAVE_FLAG_MULTIFD_FLUSH is received, causes the migration thread
> >>   on the receiving side to start synchronizing with the recv
> >>   channels. Due to compatibility, this is also issued when
> >>   RAM_SAVE_FLAG_EOS is received.
> >> 
> >>   For fixed-ram we only need to synchronize the channels at the end of
> >>   migration to avoid doing cleanup before the channels have finished
> >>   their IO.
> >> 
> >> Make sure the multifd syncs are only issued at the appropriate
> >> times. Note that due to pre-existing backward compatibility issues, we
> >> have the multifd_flush_after_each_section property that enables an
> >> older behavior of synchronizing channels more frequently (and
> >> inefficiently). Fixed-ram should always run with that property
> >> disabled (default).
> >
> > What if the user enables multifd_flush_after_each_section=true?
> >
> > IMHO we don't necessarily need to attach the fixed-ram loading flush to any
> > flag in the stream.  For fixed-ram IIUC all the loads will happen in one
> > shot of ram_load() anyway when parsing the ramblock list, so.. how about we
> > decouple the fixed-ram load flush from the stream by always do a sync in
> > ram_load() unconditionally?
> 
> I would like to. But it's not possible because ram_load() is called once
> per section. So once for each EOS flag on the stream. We'll have at
> least two calls to ram_load(), once due to qemu_savevm_state_iterate()
> and another due to qemu_savevm_state_complete_precopy().
> 
> The fact that fixed-ram can use just one load doesn't change the fact
> that we perform more than one "save". So we'll need to use the FLUSH
> flag in this case unfortunately.

After I re-read it, I found one more issue.

Now recv side sync is "once and for all" - it doesn't allow a second time
to sync_main because it syncs only until quits.  That is IMHO making the
code much harder to maintain, and we'll need rich comment to explain why is
that happening.

Ideally any "sync main" for recv threads can be called multiple times.  And
IMHO it's not really hard.  Actually it can make the code much cleaner by
merging some logic between socket-based and file-based from that regard.

I tried to play with your branch and propose something like this, just to
show what I meant. This should allow all new fixed-ram test to pass here,
meanwhile it should allow sync main on recv side to be re-entrant, sharing
the logic with socket-based as much as possible:

=====
diff --git a/migration/multifd.c b/migration/multifd.c
index a0202b5661..28480f6cfe 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -86,10 +86,8 @@ struct {
     /* number of created threads */
     int count;
     /*
-     * For sockets: this is posted once for each MULTIFD_FLAG_SYNC flag.
-     *
-     * For files: this is only posted at the end of the file load to mark
-     *            completion of the load process.
+     * This is always posted by the recv threads, the main thread uses it
+     * to wait for recv threads to finish assigned tasks.
      */
     QemuSemaphore sem_sync;
     /* global number of generated multifd packets */
@@ -1316,38 +1314,55 @@ void multifd_recv_cleanup(void)
     multifd_recv_cleanup_state();
 }
 
-
-/*
- * Wait until all channels have finished receiving data. Once this
- * function returns, cleanup routines are safe to run.
- */
-static void multifd_file_recv_sync(void)
+static void multifd_recv_file_sync_request(void)
 {
     int i;
 
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
-        trace_multifd_recv_sync_main_wait(p->id);
-
+        /*
+         * We play a trick here: instead of using a separate pending_sync
+         * to send a sync request (like what we do on senders), we simply
+         * kick the recv thread once without setting pending_job.
+         *
+         * If there's already a pending_job, the thread will only see it
+         * after it processed the current.  If there's no pending_job,
+         * it'll see this immediately.
+         */
         qemu_sem_post(&p->sem);
-
         trace_multifd_recv_sync_main_signal(p->id);
-        qemu_sem_wait(&p->sem_sync);
     }
-    return;
 }
 
+/*
+ * Request a sync for all the multifd recv threads.
+ *
+ * For socket-based, sync request is much more complicated, which relies on
+ * collaborations between both explicit RAM_SAVE_FLAG_MULTIFD_FLUSH in the
+ * main stream, and MULTIFD_FLAG_SYNC flag in per-channel protocol.  Here
+ * it should be invoked by the main stream request.
+ *
+ * For file-based, it is much simpler, because there's no need for a strong
+ * sync semantics between the main thread and the recv threads.  What we
+ * need is only to make sure all recv threads finished their tasks.
+ */
 void multifd_recv_sync_main(void)
 {
+    bool file_based = !multifd_use_packets();
     int i;
 
     if (!migrate_multifd()) {
         return;
     }
 
-    if (!multifd_use_packets()) {
-        return multifd_file_recv_sync();
+    if (file_based) {
+        /*
+         * File-based multifd requires an explicit sync request because
+         * tasks are assigned by the main recv thread, rather than parsed
+         * through the multifd channels.
+         */
+        multifd_recv_file_sync_request();
     }
 
     for (i = 0; i < migrate_multifd_channels(); i++) {
@@ -1356,6 +1371,11 @@ void multifd_recv_sync_main(void)
         trace_multifd_recv_sync_main_wait(p->id);
         qemu_sem_wait(&multifd_recv_state->sem_sync);
     }
+
+    if (file_based) {
+        return;
+    }
+
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
@@ -1420,11 +1440,12 @@ static void *multifd_recv_thread(void *opaque)
             }
 
             /*
-             * Migration thread did not send work, break and signal
-             * sem_sync so it knows we're not lagging behind.
+             * Migration thread did not send work, this emulates
+             * pending_sync, post sem_sync to notify the main thread.
              */
             if (!qatomic_read(&p->pending_job)) {
-                break;
+                qemu_sem_post(&multifd_recv_state->sem_sync);
+                continue;
             }
 
             has_data = !!p->data->size;
@@ -1449,10 +1470,6 @@ static void *multifd_recv_thread(void *opaque)
         }
     }
 
-    if (!use_packets) {
-        qemu_sem_post(&p->sem_sync);
-    }
-
     if (local_err) {
         multifd_recv_terminate_threads(local_err);
         error_free(local_err);

==========

Note that I used multifd_recv_state->sem_sync to send the message rather
than p->sem, not only because socket-based has similar logic on using that
sem, but also because main thread shouldn't care about "which" recv thread
has finished, but "all recv threads are idle".

Do you think this should work out for us in a nicer way?

Then we talk about the other issue, on whether we should rely on migration
stream to flush recv threads.  My answer is still hopefully a no.

In the ideal case, fixed-ram image format should even be tailed to not use
a live stream protocol.  For example, currently during ram iterations we
should flush quite a lot of ram QEMU_VM_SECTION_PART sections contains
mostly rubbish but then ending that with RAM_SAVE_FLAG_EOS. Then we keep
doing this in the iteration loop.  Here the real meat is during processing
of QEMU_VM_SECTION_PART, the src QEMU will update the guest pages with
fixed offsets in the file.  That however doesn't really contribute to
anything valuable in the migration stream itself (things sent over
to_dst_file).

AFAIU we chose to still use that logic only for simplicity, even if we know
those EOSs and all RAM streams are garbage.  Now we tend to add one
dependency on part of the garbage, which is RAM_SAVE_FLAG_MULTIFD_FLUSH in
this case; which is useful in socket-based but shouldn't be necessary for
file.

I think I have a solution besides ram_load(): ultimately fixed-ram stores
all guest mem in the QEMU_VM_SECTION_START section of the ram, through all
of the RAM_SAVE_FLAG_MEM_SIZE (which leads to parse_ramblocks()).  If so,
perhaps we can do one shot sync for file at the end of parse_ramblocks()?
Then we decouple sync_main on recv for file-based completely against all
stream flags.

-- 
Peter Xu


