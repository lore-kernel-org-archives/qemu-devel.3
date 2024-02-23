Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776B2C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 00:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdJ7C-00056E-Rg; Thu, 22 Feb 2024 19:08:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rdJ78-00055p-Rw
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 19:08:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rdJ76-0003Ye-UL
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 19:08:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708646907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ST/GtjUXDqs6JAeEan2bc4JHLt5TE+M+63yCJHwl5nU=;
 b=idUu0z43UA3bBnGYr1iaR/2s9wZcJwpj0MNVaP0TfGZEI2yDj9QgCSU9oue8NfGhUfpmcY
 ubEO6tsouUrvn5EZthJNJ/jd9sYTIsXQu72I3+yESQhhJaGkFqvNq0/iXhVSe+qWZmVLFl
 1kT2dwO9arRmV7eOmlybTC3A2VSxmTw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-zZjAzW1kOB2V64_46I-OgA-1; Thu, 22 Feb 2024 19:08:26 -0500
X-MC-Unique: zZjAzW1kOB2V64_46I-OgA-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5dc97ac2facso105157a12.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 16:08:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708646905; x=1709251705;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ST/GtjUXDqs6JAeEan2bc4JHLt5TE+M+63yCJHwl5nU=;
 b=L29gY0UAfzaCyoUWhR55rPhA5AvyLT1BIHIjZ/WbVDbGY1ctNS5O/ELBA9NFUBE81j
 I7fE1b7ehQn4blOan7pydWkJZpM/vY4B5ppJTpnQRG90ivRPMSGdjRquKY0ydFgPtckp
 V1KAOqr8QkY/C9WeY9hw5LjThU96mw7n95LFBKYy/KiLx7KOb+0RosuU6mktzk+1R0Su
 /aGT+ATvTihv+s0OUCCkW4P0985dtngwn7gfkOmNORC53uzmhI16GnEfuSx4rmlDWGYP
 egnDKndEy54RTOkdk+8/YCywwUH1/Ow4lxb79SCsJS5ifsAF5XjGYC91WIplRR96WkC/
 Gitw==
X-Gm-Message-State: AOJu0YwUlQGuKJAbxTo8yWtUR316Ui6hf0tVTzZ9arIBFnOMGEo0+8XU
 IVK0ZAl/nsGSL+rlAvGBxCflF/Wmb9LNEv4UaiYOsnRGhfKT+uHoJ0AmArmcryKrY44glUuhOHN
 GBnuYCH28KOuIa7q41sczy0c9/J0iSgTIyWQs53BQEEUtInpQeAWN
X-Received: by 2002:a17:90a:1202:b0:299:1ae1:51b2 with SMTP id
 f2-20020a17090a120200b002991ae151b2mr303712pja.4.1708646905319; 
 Thu, 22 Feb 2024 16:08:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1GcB67OqYD3p7m6UyEXW2uJzu33DNitw4a99sTlGXUmXsPyxZUAm0SdVbHq1Cvgs+w8Md7A==
X-Received: by 2002:a17:90a:1202:b0:299:1ae1:51b2 with SMTP id
 f2-20020a17090a120200b002991ae151b2mr303700pja.4.1708646904798; 
 Thu, 22 Feb 2024 16:08:24 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 qn11-20020a17090b3d4b00b00299d4856e6asm80474pjb.1.2024.02.22.16.08.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 16:08:24 -0800 (PST)
Date: Fri, 23 Feb 2024 08:08:14 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] migration: Fix qmp_query_migrate mbps value
Message-ID: <Zdfh7oOARA6p-Iob@x1n>
References: <20240219194457.26923-1-farosas@suse.de> <ZdVlUsTDJA4hdNhg@x1n>
 <87y1beascb.fsf@suse.de> <ZdcWmVffLWhNB-Q8@x1n>
 <ZddMRroqCeuRWGFA@x1n> <87ttm0a9t3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ttm0a9t3.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.002,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, Feb 22, 2024 at 10:49:12AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Feb 22, 2024 at 05:40:41PM +0800, Peter Xu wrote:
> >> On Wed, Feb 21, 2024 at 09:56:36AM -0300, Fabiano Rosas wrote:
> >> > Peter Xu <peterx@redhat.com> writes:
> >> > 
> >> > > On Mon, Feb 19, 2024 at 04:44:57PM -0300, Fabiano Rosas wrote:
> >> > >> The QMP command query_migrate might see incorrect throughput numbers
> >> > >> if it runs after we've set the migration completion status but before
> >> > >> migration_calculate_complete() has updated s->total_time and s->mbps.
> >> > >> 
> >> > >> The migration status would show COMPLETED, but the throughput value
> >> > >> would be the one from the last iteration and not the one from the
> >> > >> whole migration. This will usually be a larger value due to the time
> >> > >> period being smaller (one iteration).
> >> > >> 
> >> > >> Move migration_calculate_complete() earlier so that the status
> >> > >> MIGRATION_STATUS_COMPLETED is only emitted after the final counters
> >> > >> update.
> >> > >> 
> >> > >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> > >> ---
> >> > >> CI run: https://gitlab.com/farosas/qemu/-/pipelines/1182405776
> >> > >> ---
> >> > >>  migration/migration.c | 10 ++++++----
> >> > >>  1 file changed, 6 insertions(+), 4 deletions(-)
> >> > >> 
> >> > >> diff --git a/migration/migration.c b/migration/migration.c
> >> > >> index ab21de2cad..7486d59da0 100644
> >> > >> --- a/migration/migration.c
> >> > >> +++ b/migration/migration.c
> >> > >> @@ -102,6 +102,7 @@ static int migration_maybe_pause(MigrationState *s,
> >> > >>                                   int new_state);
> >> > >>  static void migrate_fd_cancel(MigrationState *s);
> >> > >>  static bool close_return_path_on_source(MigrationState *s);
> >> > >> +static void migration_calculate_complete(MigrationState *s);
> >> > >>  
> >> > >>  static void migration_downtime_start(MigrationState *s)
> >> > >>  {
> >> > >> @@ -2746,6 +2747,7 @@ static void migration_completion(MigrationState *s)
> >> > >>          migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> >> > >>                            MIGRATION_STATUS_COLO);
> >> > >>      } else {
> >> > >> +        migration_calculate_complete(s);
> >> > >>          migrate_set_state(&s->state, current_active_state,
> >> > >>                            MIGRATION_STATUS_COMPLETED);
> >> > >>      }
> >> > >> @@ -2784,6 +2786,7 @@ static void bg_migration_completion(MigrationState *s)
> >> > >>          goto fail;
> >> > >>      }
> >> > >>  
> >> > >> +    migration_calculate_complete(s);
> >> > >>      migrate_set_state(&s->state, current_active_state,
> >> > >>                        MIGRATION_STATUS_COMPLETED);
> >> > >>      return;
> >> > >> @@ -2993,12 +2996,15 @@ static void migration_calculate_complete(MigrationState *s)
> >> > >>      int64_t end_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> >> > >>      int64_t transfer_time;
> >> > >>  
> >> > >> +    /* QMP could read from these concurrently */
> >> > >> +    bql_lock();
> >> > >>      migration_downtime_end(s);
> >> > >>      s->total_time = end_time - s->start_time;
> >> > >>      transfer_time = s->total_time - s->setup_time;
> >> > >>      if (transfer_time) {
> >> > >>          s->mbps = ((double) bytes * 8.0) / transfer_time / 1000;
> >> > >>      }
> >> > >> +    bql_unlock();
> >> > >
> >> > > The lock is not needed?
> >> > >
> >> > > AFAIU that was needed because of things like runstate_set() rather than
> >> > > setting of these fields.
> >> > >
> >> > 
> >> > Don't we need to keep the total_time and mbps update atomic? Otherwise
> >> > query-migrate might see (say) total_time=0 and mbps=<correct value> or
> >> > total_time=<correct value> and mbps=<previous value>.
> >> 
> >> I thought it wasn't a major concern, but what you said makes sense; taking
> >> it one more time doesn't really hurt after all to provide such benefit.
> >> 
> >> > 
> >> > Also, what orders s->mbps update before the s->state update? I'd say we
> >> > should probably hold the lock around the whole total_time,mbps,state
> >> > update.
> >> 
> >> IMHO that's fine; mutex unlock implies a RELEASE.  See atomic.rst:
> >> 
> >> - ``pthread_mutex_lock`` has acquire semantics, ``pthread_mutex_unlock`` has
> >>   release semantics and synchronizes with a ``pthread_mutex_lock`` for the
> >>   same mutex.
> >
> > Hmm perhaps I wrote too soon.. it should only guarantee the ordering of the
> > update on the lock variable itself v.s. any previous R&Ws, nothing else.
> > Only if the other side uses bql_lock() will it guarantee proper ordering.
> >
> > Put them in bql should work, but I hesitate such use to start using bql
> > to protect state updates.
> 
> Well, on the other hand that's a major use-case of the BQL: protecting
> state that's used by QMP.
> 
> >
> > How about we drop the lock, but use an explicit smp_mb_release()?  We may
> > also want to use smb_load_acquire() in fill_source_migration_info() to use
> > on reading &s->state (all will need some comment).  To me, making sure the
> > total mbps is valid seems more important; while the other races are less
> > harmful, and may not be a major concern?
> 
> That more closely reflects the problem we're trying to solve, which is
> just an ordering one. However, the QMP code already holds the BQL, we
> could just take benefit of that instead of adding more complex
> synchronization primitives.
> 
> May I suggest we keep it simple and move that last migrate_set_state
> into the BQL as well?

It's okay to me, but then let's also extend the comment a little bit on the
two exact requirements we're persuing (atomicity of updating fields,
ordering of state update v.s. mbps)?

We can also rename migration_calculate_complete() to something like
migration_completion_finalize()?  Then move the state update into it.

-- 
Peter Xu


