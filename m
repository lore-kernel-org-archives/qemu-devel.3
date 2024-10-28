Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6908D33998
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 15:50:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5S0c-0005pl-A2; Mon, 28 Oct 2024 11:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5S0S-0005l1-W3
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:50:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5S0R-000461-9V
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730130610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L0xqf3P1F/P6uyMihnRsSQMhKA0aq0RxVEk6cda5w08=;
 b=X6YwpWIc9vUJxE08GWlM5oEdbRdLbeKPwv/g59fWaNVCcHS3E6Oix8oUb7XRyiUiYTqice
 f2fsbGvbof8xJ4e0JQBf6uJaDXdd2jO7i+KZy9O65O5SRI1ev4fpWKIQvc7enbxyLqzM91
 VIkc5b7v+BPyu8NUQmgn+WK2uHcPmi0=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-iWaAql4mNJyPd6MT2jaJ3Q-1; Mon, 28 Oct 2024 11:50:08 -0400
X-MC-Unique: iWaAql4mNJyPd6MT2jaJ3Q-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3e604aeb8ddso4367539b6e.0
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 08:50:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730130608; x=1730735408;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L0xqf3P1F/P6uyMihnRsSQMhKA0aq0RxVEk6cda5w08=;
 b=oIf7qbuwPbsif00cpymf1M/ECFjdSjQek2y3hPpsDZviQgR3U0fT75zVOtryDLc0Gk
 GYj0I8nAkf8II7x1RxIo9QRZyKBlNGEdbkOwcncbP3U1V8zMiXVfu9yfbQqtnYlnVbxQ
 1FTszVWelQWHQSn3xDwzFiGZckH1gfRfsRgNiSbM32xOuFz4JlhFhJhs/KbmhY8lCILS
 LD8aHAo04eaMBBnzQtHzmxMk1lqFwaCPaDXeZfYoY2oZugRhZ8d33tdpn0eHa7MnMqAz
 zlddfW/y06O8WPime5OaljaFDChgytdKGPa+gSz4PybcEswLHpxMV5+vi4J+SbLmkDNd
 ZgzQ==
X-Gm-Message-State: AOJu0Yxod4v9oUkEZ8da0gZvT1EpOHN7AxA/Y2RhKy7n0FlkM3z1jWx/
 YnL7h0klA0yxXC7CFuTiXHmQmQd/faxtk4y2dNZ9daxu+E1ZfN30GkIWooW5jtyuPuyy0udhmmd
 XZKtwEhasCdJKEsxQG7Pfe98uZmzCL/D3U99ICIYeSfdbzZOFKzEc
X-Received: by 2002:a05:6808:21a3:b0:3e6:2d10:2393 with SMTP id
 5614622812f47-3e63823b473mr8068024b6e.3.1730130607720; 
 Mon, 28 Oct 2024 08:50:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGls6mWo4c38O99sfNVieaYMXLAk4imjYwzPSZ5M04dQVgNEDJp4ONSW4fMDn5DOJgqvcvVA==
X-Received: by 2002:a05:6808:21a3:b0:3e6:2d10:2393 with SMTP id
 5614622812f47-3e63823b473mr8068001b6e.3.1730130607363; 
 Mon, 28 Oct 2024 08:50:07 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d1798b764bsm33428926d6.44.2024.10.28.08.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 08:50:07 -0700 (PDT)
Date: Mon, 28 Oct 2024 11:50:05 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Avihai Horon <avihaih@nvidia.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 8/8] migration: Protect updates to current_migration
 with a mutex
Message-ID: <Zx-yra1XrsUxnEk-@x1n>
References: <20241024213056.1395400-1-peterx@redhat.com>
 <20241024213056.1395400-9-peterx@redhat.com>
 <ac9645b9-e188-4f8c-87bb-abaa9da12c74@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac9645b9-e188-4f8c-87bb-abaa9da12c74@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Oct 25, 2024 at 02:50:36PM +0200, Cédric Le Goater wrote:
> On 10/24/24 23:30, Peter Xu wrote:
> > Introduce migration_mutex, protecting concurrent updates to
> > current_migration.
> > 
> > In reality, most of the exported migration functions are safe to access
> > migration objects on capabilities, etc., e.g. many of the code is invoked
> > within migration thread via different hooks (e.g., precopy notifier,
> > vmstate handler hooks, etc.).
> > 
> > So literally the mutex so far only makes sure below two APIs that are prone
> > to accessing freed current_migration:
> > 
> >          migration_is_running()
> >          migration_file_set_error()
> > 
> > Then we'll need to take the mutex too when init/free the migration object.
> 
> we should also drop :
> 
>   static void vfio_set_migration_error(int ret)
>   {
>       if (migration_is_running()) {
>           migration_file_set_error(ret, NULL);
>       }
>   }
> 
> and use directly migration_file_set_error().

We'll need to export migration_is_running() anyway, though.  So maybe we
can do that as a VFIO's follow up?

> 
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   migration/migration.h |  3 +++
> >   migration/migration.c | 43 +++++++++++++++++++++++++++++++++++++++++++
> >   2 files changed, 46 insertions(+)
> > 
> > diff --git a/migration/migration.h b/migration/migration.h
> > index 9fa26ab06a..05edcf0c49 100644
> > --- a/migration/migration.h
> > +++ b/migration/migration.h
> > @@ -473,6 +473,9 @@ struct MigrationState {
> >       bool rdma_migration;
> >   };
> > +extern QemuMutex migration_mutex;
> > +#define  QEMU_MIGRATION_LOCK_GUARD()  QEMU_LOCK_GUARD(&migration_mutex)
> > +
> 
> Why are these definitions exported ?

This is still only used in migration/ so it's not exported to QEMU.  I was
planning this can be available anywhere in migration/ when a function needs
to be exported.

However I think you're right.. this so far is even only used in
migration.c, so we don't need to export it, at least until some other
migration/*.c will export anything.  Will remove it when repost.

Thanks,

> 
> Thanks,
> 
> C.
> 
> 
> 
> >   void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
> >                          MigrationStatus new_state);
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 127b01734d..ef044968df 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -97,6 +97,14 @@ enum mig_rp_message_type {
> >      migrations at once.  For now we don't need to add
> >      dynamic creation of migration */
> > +/*
> > + * Protects current_migration below.  Must be hold when using migration
> > + * exported functions unless the caller knows it won't get freed.  For
> > + * example, when in the context of migration_thread() it's safe to access
> > + * current_migration without the mutex, because the thread holds one extra
> > + * refcount of the object, so it literally pins the object in-memory.
> > + */
> > +QemuMutex migration_mutex;
> >   static MigrationState *current_migration;
> >   static MigrationIncomingState *current_incoming;
> > @@ -110,6 +118,17 @@ static void migrate_fd_cancel(MigrationState *s);
> >   static bool close_return_path_on_source(MigrationState *s);
> >   static void migration_completion_end(MigrationState *s);
> > +/*
> > + * This is explicitly done without migration_object_init(), because it may
> > + * start to use this lock already when instance_init() of the object.  The
> > + * mutex is alive for the whole lifecycle of QEMU, so it's always usable
> > + * and never destroyed.
> > + */
> > +static void __attribute__((constructor)) migration_mutex_init(void)
> > +{
> > +    qemu_mutex_init(&migration_mutex);
> > +}
> > +
> >   static void migration_downtime_start(MigrationState *s)
> >   {
> >       trace_vmstate_downtime_checkpoint("src-downtime-start");
> > @@ -336,6 +355,14 @@ void migration_shutdown(void)
> >        * stop the migration using this structure
> >        */
> >       migration_cancel(NULL);
> > +    /*
> > +     * Release the refcount from the main thread.  It means it can be freed
> > +     * here if migration thread is not running.
> > +     *
> > +     * NOTE: we don't need QEMU_MIGRATION_LOCK_GUARD() on this access
> > +     * because we're sure there's one refcount.  The lock will be taken in
> > +     * finalize() if it triggers, so we can't take it here anyway.
> > +     */
> >       object_unref(OBJECT(current_migration));
> >       /*
> > @@ -1118,8 +1145,14 @@ void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value)
> >   bool migration_is_running(void)
> >   {
> > +    QEMU_MIGRATION_LOCK_GUARD();
> > +
> >       MigrationState *s = current_migration;
> > +    if (!s) {
> > +        return false;
> > +    }
> > +
> >       switch (s->state) {
> >       case MIGRATION_STATUS_ACTIVE:
> >       case MIGRATION_STATUS_POSTCOPY_ACTIVE:
> > @@ -3029,8 +3062,14 @@ static MigThrError postcopy_pause(MigrationState *s)
> >   void migration_file_set_error(int ret, Error *err)
> >   {
> > +    QEMU_MIGRATION_LOCK_GUARD();
> > +
> >       MigrationState *s = current_migration;
> > +    if (!s) {
> > +        return;
> > +    }
> > +
> >       WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
> >           if (s->to_dst_file) {
> >               qemu_file_set_error_obj(s->to_dst_file, ret, err);
> > @@ -3835,6 +3874,8 @@ static void migration_instance_finalize(Object *obj)
> >   {
> >       MigrationState *ms = MIGRATION_OBJ(obj);
> > +    QEMU_MIGRATION_LOCK_GUARD();
> > +
> >       qemu_mutex_destroy(&ms->error_mutex);
> >       qemu_mutex_destroy(&ms->qemu_file_lock);
> >       qemu_sem_destroy(&ms->wait_unplug_sem);
> > @@ -3858,6 +3899,8 @@ static void migration_instance_init(Object *obj)
> >   {
> >       MigrationState *ms = MIGRATION_OBJ(obj);
> > +    QEMU_MIGRATION_LOCK_GUARD();
> > +
> >       /*
> >        * There can only be one migration object globally. Keep a record of
> >        * the pointer in current_migration, which will be reset after the
> 

-- 
Peter Xu


