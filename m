Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640E1C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 16:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tprPU-0006qM-Vq; Wed, 05 Mar 2025 11:15:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tprP4-0006ch-BS
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:15:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tprP1-0008GR-7x
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:15:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741191318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YSbtf0VeiXuQ2EGGhQqCS9w7SUBpRjiKEgQOM2AIrLo=;
 b=YPhZqV4FiPFG+LCSe9G7cvzvw+PIntID1iE4vdVvHFHqVsHTf2r3SeVjn7+aXuTt7oGr2O
 v5QW1iLybR4Wel6aXc+sSFZxRXUVX1bVJaHVPc6jgRPS93TNiDvr376McpR9flBuzbxPCP
 NUR1JOliIEprEny8NIXwSWi8OywGh30=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-UnXWuuewPgm7WqISzk4FxA-1; Wed, 05 Mar 2025 11:15:11 -0500
X-MC-Unique: UnXWuuewPgm7WqISzk4FxA-1
X-Mimecast-MFC-AGG-ID: UnXWuuewPgm7WqISzk4FxA_1741191311
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c0b0cf53f3so1292864585a.2
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 08:15:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741191311; x=1741796111;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YSbtf0VeiXuQ2EGGhQqCS9w7SUBpRjiKEgQOM2AIrLo=;
 b=aCJyMuohNsqJ9sVRiTh9BK0oJZg5b/+gbvpNsUssRC88iGw4zfsvhrisixSjHaIUWk
 22ITQEyqD9uP2/n2J+/yR/mFnaj9gPyZJaJwvyl6MjA/oOhsPCpy/+8hqBhKfLFcxgpO
 RD/ZDbeOft2+zxMUviQitmXXhoIpdItUpKpJ7ZVNx8xdXs2nffVytw7WLXuKH12DKR2K
 XtTSOus03oct441RJ+9OSQuAfVQy+yVe8Vg7AHLQHzm3Lqx6GGtbWNUyUM8ezpA64GDY
 uI71gZnBYtRARuPzzHAuH25stQcHvSO/Bxce1rj3JHgaApWQYMONH6q1BN5WLNYeAt66
 QCcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2Nrr42PMzNV9oTzj3Itu77jK+QtY5vT326j3EC/xO9khsNfGfXN1LZnR3UFJGKeEdSlY1g0NAzdGC@nongnu.org
X-Gm-Message-State: AOJu0Yxf1Lo1TfrwqCEyRYzw1q8JXVsrX9VzMPzwPafd5Wuuy/rHbxv5
 wr8LD573ZADR+hSsxrUOjok1Zd68Kt8emPcaHD4XrwqNs8/46eEAZ9R+KiPVviEsCqmz/M6BqDg
 pSooZCry28yMBSct5DeP33yNfyQnX4FxtOO+6ux4kThu0NZhjZ422
X-Gm-Gg: ASbGncsC0b84argMu94DxtAQn5XZ4Ozs4j+OCzc2W06NJ2h6iH4t12zPIwPabNO4/wX
 JTtI6c5aYnhD5Dtfg0M+m0n5c8uTu/CLTwTizKMTf6HXTTkgkPiYWwW5YzokX7FDjF3q62/Aif4
 ZO8mMPJEKSq2J2Dqzg6sjbhJTOj+8FsBR/lsKEbT6VoyipHWFeatx5IlzoZ+9Az2MSUasgIeUj6
 Xi/Nef/aqOiOD4qP/jqgvdAUMeE471ARn3v9MVzll4TIoi0B3DP/rSiJAv/8pPXp3SW2jE8IkMD
 9Qz4m8Q=
X-Received: by 2002:a05:620a:2815:b0:7c0:9ac5:7f9a with SMTP id
 af79cd13be357-7c3d8e17302mr735460385a.7.1741191311193; 
 Wed, 05 Mar 2025 08:15:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlD0pRyV3W4fDIpo4QcKCwrpitCTRdi69ahnTabZjjsXKrbz++nEOeRLo4MGh4QB2DasAtLw==
X-Received: by 2002:a05:620a:2815:b0:7c0:9ac5:7f9a with SMTP id
 af79cd13be357-7c3d8e17302mr735455185a.7.1741191310783; 
 Wed, 05 Mar 2025 08:15:10 -0800 (PST)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c3d29d77dasm202640485a.115.2025.03.05.08.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 08:15:10 -0800 (PST)
Date: Wed, 5 Mar 2025 11:15:07 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v6 07/36] migration: postcopy_ram_listen_thread() should
 take BQL for some calls
Message-ID: <Z8h4i3Ima6BhaoBs@x1.local>
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <24a7412cc151f8b48d74cd170a3bdc1ce8e6c879.1741124640.git.maciej.szmigiero@oracle.com>
 <Z8hE3ujEKkwsBiJO@x1.local>
 <4aac2a7e-f42e-4e92-8e27-3b0e9a7b6603@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4aac2a7e-f42e-4e92-8e27-3b0e9a7b6603@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, Mar 05, 2025 at 04:11:30PM +0100, Maciej S. Szmigiero wrote:
> On 5.03.2025 13:34, Peter Xu wrote:
> > On Tue, Mar 04, 2025 at 11:03:34PM +0100, Maciej S. Szmigiero wrote:
> > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > > 
> > > All callers to migration_incoming_state_destroy() other than
> > > postcopy_ram_listen_thread() do this call with BQL held.
> > > 
> > > Since migration_incoming_state_destroy() ultimately calls "load_cleanup"
> > > SaveVMHandlers and it will soon call BQL-sensitive code it makes sense
> > > to always call that function under BQL rather than to have it deal with
> > > both cases (with BQL and without BQL).
> > > Add the necessary bql_lock() and bql_unlock() to
> > > postcopy_ram_listen_thread().
> > > 
> > > qemu_loadvm_state_main() in postcopy_ram_listen_thread() could call
> > > "load_state" SaveVMHandlers that are expecting BQL to be held.
> > > 
> > > In principle, the only devices that should be arriving on migration
> > > channel serviced by postcopy_ram_listen_thread() are those that are
> > > postcopiable and whose load handlers are safe to be called without BQL
> > > being held.
> > > 
> > > But nothing currently prevents the source from sending data for "unsafe"
> > > devices which would cause trouble there.
> > > Add a TODO comment there so it's clear that it would be good to improve
> > > handling of such (erroneous) case in the future.
> > > 
> > > Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> > > ---
> > >   migration/migration.c | 16 ++++++++++++++++
> > >   migration/savevm.c    |  4 ++++
> > >   2 files changed, 20 insertions(+)
> > > 
> > > diff --git a/migration/migration.c b/migration/migration.c
> > > index 9e9db26667f1..6b2a8af4231d 100644
> > > --- a/migration/migration.c
> > > +++ b/migration/migration.c
> > > @@ -402,10 +402,26 @@ void migration_incoming_state_destroy(void)
> > >       struct MigrationIncomingState *mis = migration_incoming_get_current();
> > >       multifd_recv_cleanup();
> > > +
> > >       /*
> > >        * RAM state cleanup needs to happen after multifd cleanup, because
> > >        * multifd threads can use some of its states (receivedmap).
> > > +     *
> > > +     * This call also needs BQL held since it calls all registered
> > > +     * load_cleanup SaveVMHandlers and at least the VFIO implementation is
> > > +     * BQL-sensitive.
> > > +     *
> > > +     * In addition to the above, it also performs cleanup of load threads
> > > +     * thread pool.
> > > +     * This cleanup operation is BQL-sensitive as it requires unlocking BQL
> > > +     * so a thread possibly waiting for it could get unblocked and finally
> > > +     * exit.
> > > +     * The reason why a load thread may need to hold BQL in the first place
> > > +     * is because address space modification operations require it.
> > 
> > Hold on...
> > 
> > This almost says exactly why load_cleanup() should _not_ take BQL... rather
> > than should..
> > 
> > So I had a closer look at the latest code, it's about this:
> > 
> > static void vfio_load_cleanup_load_bufs_thread(VFIOMultifd *multifd)
> > {
> >      /* The lock order is load_bufs_mutex -> BQL so unlock BQL here first */
> >      bql_unlock();
> >      WITH_QEMU_LOCK_GUARD(&multifd->load_bufs_mutex) {
> >          while (multifd->load_bufs_thread_running) {
> >              multifd->load_bufs_thread_want_exit = true;
> > 
> >              qemu_cond_signal(&multifd->load_bufs_buffer_ready_cond);
> >              qemu_cond_signal(&multifd->load_bufs_iter_done_cond);
> >              qemu_cond_wait(&multifd->load_bufs_thread_finished_cond,
> >                             &multifd->load_bufs_mutex);
> >          }
> >      }
> >      bql_lock();
> > }
> > 
> > It doesn't make much sense to me to take it only because we want to drop it
> > unconditionally. Can we guarantee the function not taking BQL instead?  I
> > had a quick look on pmem's pmem_persist() (from libpmem, qemu_ram_msync <-
> > qemu_ram_block_writeback <- ram_load_cleanup), it looks ok.
> > 
> > So the question is, is it safe to unlock BQL in whatever context (in
> > coroutines, or in a bottom half)?
> > 
> > If the answer is yes, we could make migration_incoming_state_destroy()
> > always not taking BQL (and assert(!bql_locked()) instead).
> 
> All the other callers of migration_incoming_state_destroy() are holding BQL:
> process_incoming_migration_bh(), process_incoming_migration_co() (called on,
> failure path only), load_snapshot() and qmp_xen_load_devices_state().
> 
> So AFAIK the safer way is to standardize on holding BQL when calling
> that function.
> > If the answer is no, then vfio_load_cleanup_load_bufs_thread()'s current
> > version may not work either..
> 
> I think the reason for BQL is to serialize access to the QEMU internals
> which are not thread-safe.
> 
> So as long as these internals aren't touched when not holding BQL then
> we should be safe - I don't see any particular state that's cached
> around these BQL calls and would need explicit reloading after re-gaining
> it.

OK, I checked with misterious force and looks like it's ok.

Would you please rephrase the comment, though?  I want to make it crystal
clear that what we're looking for is not holding BQL.. Maybe something like
this:

    /*
     * The VFIO load_cleanup() implementation is BQL-sensitive. It requires
     * BQL must NOT be taken when recycling load threads, so that it won't
     * block the load threads from making progress on address space
     * modification operations.
     *
     * To make it work, we could try to not take BQL for all load_cleanup(),
     * or conditionally unlock BQL only if bql_locked() in VFIO.
     *
     * Since most existing call sites take BQL for load_cleanup(), make
     * it simple by taking BQL always as the rule, so that VFIO can unlock
     * BQL and retake unconditionally.
     */

We may also want to update the subject.  Currently:

  "migration: postcopy_ram_listen_thread() should take BQL for some calls"

It's not accurate anymore, it could be:

  "migration: Always take BQL for migration_incoming_state_destroy()"

If with all above, please feel free to take:

Acked-by: Peter Xu <peterx@redhat.com>

I'm OK if it'll be touched up when merge too.

Thanks,

-- 
Peter Xu


