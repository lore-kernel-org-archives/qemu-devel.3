Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0EEEC021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 15:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl8Uw-0000ig-Ox; Thu, 20 Feb 2025 10:29:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tl8Uv-0000iN-I7
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:29:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tl8Ut-0000UT-9F
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:29:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740065394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qoEVwqvuRK4GSVKg6hVbJi87SGH0Yd8nD+rlC9kkM5g=;
 b=iEOo70mikw0x2p0yBO+SsyPVObQrcGOGXwjF8L5tM7faMZn37eAixMvigTmQ1/kunL8Xu7
 W8qQ9TwD1bDX2gvia8AUHNsGOWZY0yw8MplGM3uaJFDLiW5DsHXJMRVSoD2uhJ4zrgNpkI
 R1hPHSgXqNa+dyoqdrOkuFF/+9RWLt4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-4jyaGuwMNXesfRlLZKbTLA-1; Thu, 20 Feb 2025 10:29:53 -0500
X-MC-Unique: 4jyaGuwMNXesfRlLZKbTLA-1
X-Mimecast-MFC-AGG-ID: 4jyaGuwMNXesfRlLZKbTLA_1740065393
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c0ade6095bso196420385a.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 07:29:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740065393; x=1740670193;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qoEVwqvuRK4GSVKg6hVbJi87SGH0Yd8nD+rlC9kkM5g=;
 b=ZO5T76UEcoI91iEJqlwCnsRKmrhIFcakj76zFTE+mspaeiqgVMNyjKGuM8f3yfrbfc
 GMJZUvDBMB0eykjWoYIRPRrvEGQlSRo6wgmu0nN0/uVeFHxAkrXIvzDmOG4ms8Ni8vpR
 lfC0pD/YVojjcLUWyvD872G5kqqO+m/Z/G73zcQ5Aj940IosPQ7teHwg32fCGTz5H8Ff
 o4j7ez4WDuh33xA7dFIXDI4os4Xap3gMEaJR0tpzIzu7ln8U9x/Mrtw21JnQgAluPiC7
 //szCdn4WtpXRfGfvUcNmhoXE50+hnrfxmcL8JsuMWbTa2fdvYTUhDI0mpRMewf20FWZ
 jOFw==
X-Gm-Message-State: AOJu0Yy0D0dAokFziXmo5rFXYkabKu1GjVk9IjQ+dX5JyGuULAINnT0+
 T5KJZtiySy7uEoS77JSYfEQN3t5SwuobIdMyAyfaNp28LzclZUhap5I/JNw3u4lNiQWgKwQyhzW
 /0uPmbj8M5aK6vsoaC/6fEDEGEIHEM1d+NaTgsvr2Ovae4CBh7M1K
X-Gm-Gg: ASbGncthlMh010oFcjxYBtUTsnG+8FG9hGzT47xN+M43dMQb3Rf1lQ6u4NXsTrqJ1lm
 LK+D00aHyBI+x4MINh2Uxkr358iNM3QRCYHfoYGNj8crpV9gl6LE+Q3uUv4qDEaIEQnotOpkP2U
 aRc3dyCh0hmHgEeXsipYm+qhaGzK6zS4MfESLBymF8L5UTcm+3ZbVOslnBQA/qocwVJbxWuqrZm
 /8JNjg0BjNrv9sJY12WOVDhrU9dT225+ewZ8iFbaWmjPhYbNsLoi1oF9IM=
X-Received: by 2002:a05:620a:460f:b0:7c0:b185:a946 with SMTP id
 af79cd13be357-7c0b534f436mr1010470985a.39.1740065392549; 
 Thu, 20 Feb 2025 07:29:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHx2LhglIdemyX/mFZgT6tp7qpfdV3GVDEvt1RdpLWnOMfGbCLX9KT4+jSmyFBTtG1zWC60/g==
X-Received: by 2002:a05:620a:460f:b0:7c0:b185:a946 with SMTP id
 af79cd13be357-7c0b534f436mr1010468085a.39.1740065392139; 
 Thu, 20 Feb 2025 07:29:52 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c0b0b7f637sm295561885a.33.2025.02.20.07.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 07:29:51 -0800 (PST)
Date: Thu, 20 Feb 2025 10:29:48 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Yan Fu <yafu@redhat.com>
Subject: Re: [PATCH] migration: Fix UAF for incoming migration on
 MigrationState
Message-ID: <Z7dKbGc5eA2QXbPD@x1.local>
References: <20250220132459.512610-1-peterx@redhat.com>
 <87h64o90dn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h64o90dn.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Feb 20, 2025 at 11:06:12AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On the incoming migration side, QEMU uses a coroutine to load all the VM
> > states.  Inside, it may reference MigrationState on global states like
> > migration capabilities, parameters, error state, shared mutexes and more.
> >
> > However there's nothing yet to make sure MigrationState won't get
> > destroyed (e.g. after migration_shutdown()).  Meanwhile there's also no API
> > available to remove the incoming coroutine in migration_shutdown(),
> > avoiding it to access the freed elements.
> >
> > There's a bug report showing this can happen and crash dest QEMU when
> > migration is cancelled on source.
> >
> > When it happens, the dest main thread is trying to cleanup everything:
> >
> >   #0  qemu_aio_coroutine_enter
> >   #1  aio_dispatch_handler
> >   #2  aio_poll
> >   #3  monitor_cleanup
> >   #4  qemu_cleanup
> >   #5  qemu_default_main
> >
> > Then it found the migration incoming coroutine, schedule it (even after
> > migration_shutdown()), causing crash:
> >
> >   #0  __pthread_kill_implementation
> >   #1  __pthread_kill_internal
> >   #2  __GI_raise
> >   #3  __GI_abort
> >   #4  __assert_fail_base
> >   #5  __assert_fail
> >   #6  qemu_mutex_lock_impl
> >   #7  qemu_lockable_mutex_lock
> >   #8  qemu_lockable_lock
> >   #9  qemu_lockable_auto_lock
> >   #10 migrate_set_error
> >   #11 process_incoming_migration_co
> >   #12 coroutine_trampoline
> >
> > To fix it, take a refcount after an incoming setup is properly done when
> > qmp_migrate_incoming() succeeded the 1st time.  As it's during a QMP
> > handler which needs BQL, it means the main loop is still alive (without
> > going into cleanups, which also needs BQL).
> 
> We should start documenting uses of BQL and dependencies on the main
> loop more thoroughly. Otherwise later when we decide to move stuff into
> threads or QMP people decide to rework how QMP uses coroutines,
> etc. there we'll be many bugs.

Yeh better documentation is always good.  Maybe there're too many things
depend on BQL so it's not easy to provide a document.  Normally, afaiu, we
document the other way round, where things do not need BQL.

> 
> I think the BQL is irrelevant here. The concurrent access is prevented
> by qmp_migrate_incoming() not being a coroutine, hence keeping the main
> loop from looping.
> 
> This case would be "relying on the qmp_migrate_incoming() being
> serialized with the dispatch of the incoming coroutine by the main
> loop".

I checked just now, it's still true indeed now that both of them
(qmp_migrate_incoming, and the cleanup code) need to be run in the main
thread.  But I'll not be surprised if someone moves (or moved) it out into
a separate iothread like what we do with the OOB commands.

When I was working on OOB stuff, I _think_ all things are ready to create
yet another iothread to process cmds need bql, probably just not necessary.
Fundamentally, the requirement, AFAIU, is qmp handlers run by default with
BQL, and it doesn't need to always be on the main thread.

Let's keep the "BQL" term?  I think I'm ok with your version as it states
the facts at least as of now, but I still think BQL is the slightly more
accurate term.

> 
> >
> > Releasing the refcount now only until the incoming migration coroutine
> > finished or failed.  Hence the refcount is valid for both (1) setup phase
> > of incoming ports, mostly IO watches (e.g. qio_channel_add_watch_full()),
> > and (2) the incoming coroutine itself (process_incoming_migration_co()).
> >
> > Note that we can't unref in migration_incoming_state_destroy(), because
> > both qmp_xen_load_devices_state() and load_snapshot() will use it without
> > an incoming migration.  Those hold BQL so they're not prone to this issue.
> >
> > PS: I suspect nobody uses Xen's command at all, as it didn't register yank,
> > hence AFAIU the command should crash on master when trying to unregister
> > yank in migration_incoming_state_destroy()..  but that's another story.
> >
> > Also note that in some incoming failure cases we may not always unref the
> > MigrationState refcount, which is a trade-off to keep things simple.  We
> > could make it accurate, but it can be an overkill.  Some examples:
> >
> >   - Unlike most of the rest protocols, socket_start_incoming_migration()
> >     may create net listener after incoming port setup sucessfully.
> >     It means we can't unref in migration_channel_process_incoming() as a
> >     generic path because socket protocol might keep using MigrationState.
> >
> >   - For either socket or file, multiple IO watches might be created, it
> >     means logically each IO watch needs to take one refcount for
> >     MigrationState so as to be 100% accurate on ownership of refcount taken.
> >
> > In general, we at least need per-protocol handling to make it accurate,
> > which can be an overkill if we know incoming failed after all.  Add a short
> > comment to explain that when taking the refcount in qmp_migrate_incoming().
> >
> > Bugzilla: https://issues.redhat.com/browse/RHEL-69775
> > Tested-by: Yan Fu <yafu@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/migration.c | 40 ++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 38 insertions(+), 2 deletions(-)
> >
> > diff --git a/migration/migration.c b/migration/migration.c
> > index c597aa707e..f57d853e9f 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -116,6 +116,27 @@ static void migration_downtime_start(MigrationState *s)
> >      s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> >  }
> >  
> > +/*
> > + * This is unfortunate: incoming migration actually needs the outgoing
> > + * migration state (MigrationState) to be there too, e.g. to query
> > + * capabilities, parameters, using locks, setup errors, etc.
> > + *
> > + * NOTE: when calling this, making sure current_migration exists and not
> > + * been freed yet!  Otherwise trying to access the refcount is already
> > + * an use-after-free itself..
> > + *
> > + * TODO: Move shared part of incoming / outgoing out into separate object.
> > + * Then this is not needed.
> 
> It will be needed on the new object still, no?

In that case IIUC we don't need special treatment for incoming side like
this, but only when QEMU starts it grabs that common object ref once,
either release it at the very end of qemu, or just make it static.

> 
> > + */
> > +static void migrate_incoming_ref_outgoing_state(void)
> > +{
> > +    object_ref(migrate_get_current());
> > +}
> > +static void migrate_incoming_unref_outgoing_state(void)
> > +{
> > +    object_unref(migrate_get_current());
> > +}
> > +
> >  static void migration_downtime_end(MigrationState *s)
> >  {
> >      int64_t now = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> > @@ -850,7 +871,7 @@ process_incoming_migration_co(void *opaque)
> >               * postcopy thread.
> >               */
> >              trace_process_incoming_migration_co_postcopy_end_main();
> > -            return;
> > +            goto out;
> >          }
> >          /* Else if something went wrong then just fall out of the normal exit */
> >      }
> > @@ -866,7 +887,8 @@ process_incoming_migration_co(void *opaque)
> >      }
> >  
> >      migration_bh_schedule(process_incoming_migration_bh, mis);
> > -    return;
> > +    goto out;
> > +
> >  fail:
> >      migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
> >                        MIGRATION_STATUS_FAILED);
> > @@ -883,6 +905,9 @@ fail:
> >  
> >          exit(EXIT_FAILURE);
> >      }
> > +out:
> > +    /* Pairs with the refcount taken in qmp_migrate_incoming() */
> > +    migrate_incoming_unref_outgoing_state();
> 
> Nit, the comment is redundant, the function name is already clear
> enough.

The function says the "incoming" path "unref"s an "outgoing state", not
where it's taken?  But yeah I can drop it, let me know.

> 
> >  }
> >  
> >  /**
> > @@ -1888,6 +1913,17 @@ void qmp_migrate_incoming(const char *uri, bool has_channels,
> >          return;
> >      }
> >  
> > +    /*
> > +     * Making sure MigrationState is available until incoming migration
> > +     * completes.
> > +     *
> > +     * NOTE: QEMU _might_ leak this refcount in some failure paths, but
> > +     * that's OK.  This is the minimum change we need to at least making
> > +     * sure success case is clean on the refcount.  We can try harder to
> > +     * make it accurate for any kind of failures, but it might be an
> > +     * overkill and doesn't bring us much benefit.
> > +     */
> 
> Hopefully not any real leak... Let's see what my scripts say about
> it. If it doesn't trigger with migration-test that's fine.

I remember there could be leaks but only "it fails and dest qemu will quit
immediately" kind of leak.  So possible it could trigger with some failure
cases, but not sure whether existing cases will trigger those specific
paths, most failure paths should still get covered.

> 
> > +    migrate_incoming_ref_outgoing_state();
> >      once = false;
> >  }
> 

-- 
Peter Xu


