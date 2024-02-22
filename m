Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A69C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 09:31:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd5Po-0002cj-JR; Thu, 22 Feb 2024 04:30:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rd5Pn-0002cU-HZ
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 04:30:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rd5Ph-0003T7-Rv
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 04:30:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708594244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wQWZQd5IIthXH2NXDvoC5sfAG+rxOyX78odZFjhCI3E=;
 b=ZO6CbXVVI05F6YcanNABbVPUKOadGNONtJWSAulj23ixMC6mUVgpXCGucXcuLzK8z8rLMg
 mTNp/vWv1tRcxNqwrEy+LR13QUXKKzroKvqF3QFNEZkg9+jLo3nEv09GoYXqPE1O73dv4W
 G4nRgdrC/WEv6JXP9KUWGbUDnEZbAM8=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-6c5khnWMN_a7QGfZB1lYyw-1; Thu, 22 Feb 2024 04:30:43 -0500
X-MC-Unique: 6c5khnWMN_a7QGfZB1lYyw-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5a0168a3df5so517655eaf.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 01:30:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708594242; x=1709199042;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wQWZQd5IIthXH2NXDvoC5sfAG+rxOyX78odZFjhCI3E=;
 b=C+ZLZqTNaR6zQpokGC9dS+NGyqeXpAHMcKJAwOL0Nj0Xs9jGwP0BFrdKTlbacG3PHc
 X4HZ5/QdgNJAILDKxmyEkpYvEbwgk6En+dSWA1jbJu2ec7boYKFMGEhuDslHv/CvJr/Z
 MgQ5tw6r7WuFRZts3u6nSxfOK2zM1G0cf5wECI9nBBtL04fKIHf83UJ6It6FKZ3QAWC4
 OrU1zr/g4K/pGD2Ok4QG0J1f+Vuh3k/9NDPkotoe4p0fxm8IpxN4hhyVaYYqyiQ32DKV
 qbFVCuzsWA43zWmqkSHBn5k3FWaDcslzSop610Xdt0NwqHiYBqAEJ3cnRI3fdAIKUqdX
 qmNQ==
X-Gm-Message-State: AOJu0YwCCVpL9sMJdqiyWssH++RqjrqAx4fDkKXQGezZj/j3EvvGoxPq
 /spfiM14eby3ydyb40T5fctuzJnyTPUyfU4i8ng1R7XyvFKYpZBfVYQDLiiQlAurC9NP2XOGUAD
 f3q+MZJMSnZpBlHJgcu7df0noICNKqRjI/9hNdWU4YY86hqL29boo
X-Received: by 2002:a05:6358:cc26:b0:17b:6b42:8da3 with SMTP id
 gx38-20020a056358cc2600b0017b6b428da3mr1666284rwb.2.1708594242386; 
 Thu, 22 Feb 2024 01:30:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDiq7wzX2olNqs80gOcws6On2xz3d5+py0jbcEcxtsHtCYLdUjhBvIfxbk44yjw0VfnxsWzQ==
X-Received: by 2002:a05:6358:cc26:b0:17b:6b42:8da3 with SMTP id
 gx38-20020a056358cc2600b0017b6b428da3mr1666275rwb.2.1708594241983; 
 Thu, 22 Feb 2024 01:30:41 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 t4-20020a62d144000000b006e3b868b8b8sm9499268pfl.130.2024.02.22.01.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 01:30:41 -0800 (PST)
Date: Thu, 22 Feb 2024 17:30:32 +0800
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH V3 10/13] migration: stop vm for cpr
Message-ID: <ZdcUODYUBm8sfnOq@x1n>
References: <1707418446-134863-1-git-send-email-steven.sistare@oracle.com>
 <1707418446-134863-11-git-send-email-steven.sistare@oracle.com>
 <ZdRVz7gvh-qGNxXZ@x1n>
 <91c57365-a61d-4ae7-bc63-454a39c1a6ec@oracle.com>
 <ZdcQFbIJ46sSPf2i@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZdcQFbIJ46sSPf2i@x1n>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 22, 2024 at 05:12:53PM +0800, Peter Xu wrote:
> On Wed, Feb 21, 2024 at 04:20:07PM -0500, Steven Sistare wrote:
> > On 2/20/2024 2:33 AM, Peter Xu wrote:
> > > On Thu, Feb 08, 2024 at 10:54:03AM -0800, Steve Sistare wrote:
> > >> When migration for cpr is initiated, stop the vm and set state
> > >> RUN_STATE_FINISH_MIGRATE before ram is saved.  This eliminates the
> > >> possibility of ram and device state being out of sync, and guarantees
> > >> that a guest in the suspended state remains suspended, because qmp_cont
> > >> rejects a cont command in the RUN_STATE_FINISH_MIGRATE state.
> > >>
> > >> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > >> ---
> > >>  include/migration/misc.h |  1 +
> > >>  migration/migration.c    | 32 +++++++++++++++++++++++++-------
> > >>  2 files changed, 26 insertions(+), 7 deletions(-)
> > >>
> > >> diff --git a/include/migration/misc.h b/include/migration/misc.h
> > >> index 6dc234b..54c99a3 100644
> > >> --- a/include/migration/misc.h
> > >> +++ b/include/migration/misc.h
> > >> @@ -60,6 +60,7 @@ void migration_object_init(void);
> > >>  void migration_shutdown(void);
> > >>  bool migration_is_idle(void);
> > >>  bool migration_is_active(MigrationState *);
> > >> +bool migrate_mode_is_cpr(MigrationState *);
> > >>  
> > >>  typedef enum MigrationEventType {
> > >>      MIG_EVENT_PRECOPY_SETUP,
> > >> diff --git a/migration/migration.c b/migration/migration.c
> > >> index d1fce9e..fc5c587 100644
> > >> --- a/migration/migration.c
> > >> +++ b/migration/migration.c
> > >> @@ -1603,6 +1603,11 @@ bool migration_is_active(MigrationState *s)
> > >>              s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
> > >>  }
> > >>  
> > >> +bool migrate_mode_is_cpr(MigrationState *s)
> > >> +{
> > >> +    return s->parameters.mode == MIG_MODE_CPR_REBOOT;
> > >> +}
> > >> +
> > >>  int migrate_init(MigrationState *s, Error **errp)
> > >>  {
> > >>      int ret;
> > >> @@ -2651,13 +2656,14 @@ static int migration_completion_precopy(MigrationState *s,
> > >>      bql_lock();
> > >>      migration_downtime_start(s);
> > >>  
> > >> -    s->vm_old_state = runstate_get();
> > >> -    global_state_store();
> > >> -
> > >> -    ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
> > >> -    trace_migration_completion_vm_stop(ret);
> > >> -    if (ret < 0) {
> > >> -        goto out_unlock;
> > >> +    if (!migrate_mode_is_cpr(s)) {
> > >> +        s->vm_old_state = runstate_get();
> > >> +        global_state_store();
> > >> +        ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
> > >> +        trace_migration_completion_vm_stop(ret);
> > >> +        if (ret < 0) {
> > >> +            goto out_unlock;
> > >> +        }
> > >>      }
> > >>  
> > >>      ret = migration_maybe_pause(s, current_active_state,
> > >> @@ -3576,6 +3582,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
> > >>      Error *local_err = NULL;
> > >>      uint64_t rate_limit;
> > >>      bool resume = s->state == MIGRATION_STATUS_POSTCOPY_PAUSED;
> > >> +    int ret;
> > >>  
> > >>      /*
> > >>       * If there's a previous error, free it and prepare for another one.
> > >> @@ -3651,6 +3658,17 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
> > >>          goto fail;
> > >>      }
> > >>  
> > >> +    if (migrate_mode_is_cpr(s)) {
> > >> +        s->vm_old_state = runstate_get();
> > >> +        global_state_store();
> > >> +        ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
> > >> +        trace_migration_completion_vm_stop(ret);
> > >> +        if (ret < 0) {
> > >> +            error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
> > >> +            goto fail;
> > >> +        }
> > >> +    }
> > > 
> > > Could we have a helper function for the shared codes?
> > 
> > I propose to add code to migration_stop_vm to make it the helper.  Some call sites emit
> > more traces (via migration_stop_vm) as a result of my refactoring,
> 
> This should be fine.
> 
> > and postcopy start sets 
> > vm_old_state, which is not used thereafter in that path.  Those changes seem harmless to me.
> 
> Not only harmless, I think it was a bug to not set vm_old_state in
> postcopy_start()..  See:
> 
> https://issues.redhat.com/browse/RHEL-18061
> 
> I suspect that was the cause.
> 
> > Tell me what you think:
> 
> I'll have a closer look later, but so far it looks all good.
> 
> Thanks,
> 
> > 
> > -------------------------------------------------------
> > diff --git a/migration/migration.c b/migration/migration.c
> > index fc5c587..30d2b08 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -107,12 +107,6 @@ static int migration_maybe_pause(MigrationState *s,
> >  static void migrate_fd_cancel(MigrationState *s);
> >  static bool close_return_path_on_source(MigrationState *s);
> > 
> > -static void migration_downtime_start(MigrationState *s)
> > -{
> > -    trace_vmstate_downtime_checkpoint("src-downtime-start");
> > -    s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> > -}

Ah.. one more thing: would you mind keep this helper even if it can be
squashed when sending formal patch?  I want to keep downtime start/end
super clear and paired as they're important hook points.  It should be
inlined anyway by the compiler.

> > -
> >  static void migration_downtime_end(MigrationState *s)
> >  {
> >      int64_t now = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> > @@ -161,11 +155,20 @@ static gint page_request_addr_cmp(gconstpointer ap, gconstpo
> >      return (a > b) - (a < b);
> >  }
> > 
> > -int migration_stop_vm(RunState state)
> > +static int migration_stop_vm(MigrationState *s, RunState state)
> >  {
> > -    int ret = vm_stop_force_state(state);
> > +    int ret;
> > +
> > +    trace_vmstate_downtime_checkpoint("src-downtime-start");
> > +    s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> > +
> > +    s->vm_old_state = runstate_get();
> > +    global_state_store();
> > +
> > +    ret = vm_stop_force_state(state);
> > 
> >      trace_vmstate_downtime_checkpoint("src-vm-stopped");
> > +    trace_migration_completion_vm_stop(ret);
> > 
> >      return ret;
> >  }
> > @@ -2454,10 +2457,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
> >      bql_lock();
> >      trace_postcopy_start_set_run();
> > 
> > -    migration_downtime_start(ms);
> > -
> > -    global_state_store();
> > -    ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
> > +    ret = migration_stop_vm(ms, RUN_STATE_FINISH_MIGRATE);
> >      if (ret < 0) {
> >          goto fail;
> >      }
> > @@ -2654,13 +2654,9 @@ static int migration_completion_precopy(MigrationState *s,
> >      int ret;
> > 
> >      bql_lock();
> > -    migration_downtime_start(s);
> > 
> >      if (!migrate_mode_is_cpr(s)) {
> > -        s->vm_old_state = runstate_get();
> > -        global_state_store();
> > -        ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
> > -        trace_migration_completion_vm_stop(ret);
> > +        ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
> >          if (ret < 0) {
> >              goto out_unlock;
> >          }
> > @@ -3498,15 +3494,10 @@ static void *bg_migration_thread(void *opaque)
> >      s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
> > 
> >      trace_migration_thread_setup_complete();
> > -    migration_downtime_start(s);
> > 
> >      bql_lock();
> > 
> > -    s->vm_old_state = runstate_get();
> > -
> > -    global_state_store();
> > -    /* Forcibly stop VM before saving state of vCPUs and devices */
> > -    if (migration_stop_vm(RUN_STATE_PAUSED)) {
> > +    if (migration_stop_vm(s, RUN_STATE_PAUSED)) {
> >          goto fail;
> >      }
> >      /*
> > @@ -3659,10 +3650,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
> >      }
> > 
> >      if (migrate_mode_is_cpr(s)) {
> > -        s->vm_old_state = runstate_get();
> > -        global_state_store();
> > -        ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
> > -        trace_migration_completion_vm_stop(ret);
> > +        ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
> >          if (ret < 0) {
> >              error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
> >              goto fail;
> > diff --git a/migration/migration.h b/migration/migration.h
> > index aef8afb..65c0b61 100644
> > --- a/migration/migration.h
> > +++ b/migration/migration.h
> > @@ -541,6 +541,4 @@ int migration_rp_wait(MigrationState *s);
> >   */
> >  void migration_rp_kick(MigrationState *s);
> > 
> > -int migration_stop_vm(RunState state);
> > -
> >  #endif
> > -------------------------------------------------------
> > 
> > - Steve
> > 
> 
> -- 
> Peter Xu

-- 
Peter Xu


