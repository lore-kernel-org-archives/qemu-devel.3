Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1135C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 21:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzkXN-00072h-Mc; Wed, 24 Apr 2024 17:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzkXK-000724-PI
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 17:52:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzkXI-0000i6-If
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 17:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713995535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N876Yfb+PMmsdEqjbe4od1uYZnv5ljJY1q7oWqc1ehM=;
 b=L5ocVeJIML7jdAqcTsqu+kbv75Mk8Tmi3h81CMVh//aVnN9jl6mjrxO1ZqbKBl8o1mn2GD
 GAL+FoxRydNkSY+CacBJgH4CYIqmeMvYsFoU2SKW5xLPfvw9GW+L8czzK0RmhSdNm8ocRj
 5Q/1vwNkpMD31eYMlJMre5RngumYMOA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-vZJX998sPMCUGKepems5YQ-1; Wed, 24 Apr 2024 17:52:13 -0400
X-MC-Unique: vZJX998sPMCUGKepems5YQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6a094939dedso1006706d6.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 14:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713995533; x=1714600333;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N876Yfb+PMmsdEqjbe4od1uYZnv5ljJY1q7oWqc1ehM=;
 b=WFvMKM89jabbD6zG6jmMX273Ft/89Z220TI/L/3jEvz8p8/9e8F2YoBWobe2lE8z9w
 IW47Xxcc8GxIj0A9xpK/ofJUaLqZajroCPoyD+X8551ivt8FlCkg2xpiX1x7T9lj6vBx
 z/6JxgdLQxNyu7+nPL9hCGbFukc0+7J8A5FV7ftF+oJPgz8so7AeiG665vAGhdX/UaVS
 xe1jCFVXdqHk6OG+uTFUE5U+dx9dZSWzkf4UtFdbjdN/dPX/ScQzKXb72yLX5bVNBtMJ
 +5iGz0m7i21S4jCOzbhbnQKwl3k+0e7KPL8py/d2q2k70NqFkllpX5Q5kHhIcWoOJ422
 8Ifw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJsXj03u6suu1dnLB2eqi3kNLUyNkknBxmVSoWsv1YrrvYxhV19/WAwYZ0pdQmxzr0xnZNtCQEKXvLAEMjJIThYqOF8wA=
X-Gm-Message-State: AOJu0Ywlxsr3dzaKalLSqvTW83+k1nrDVldsxBbRysRzxwS0c5kGbRjH
 WU51W4MWEFovdXeIRC/eCIN8bjuTDD6Qr5PKf9LYI0dOXqIpQAhCNUpU2Bm5b5RDOIkrac511A1
 FJ4d75Br+kUzbeAvjS65a5NxGPTL+Xz7I4yzKmosTZVtME8WTGyqQ
X-Received: by 2002:a05:6214:21cc:b0:696:b235:f39 with SMTP id
 d12-20020a05621421cc00b00696b2350f39mr3973712qvh.6.1713995532622; 
 Wed, 24 Apr 2024 14:52:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDARA+20ZBS6H5IwdBPVPJLEQvGU7DdwwNSQVpdO3N8WJ4oLGsV+lXu67gwO49kMQv8Jp+HQ==
X-Received: by 2002:a05:6214:21cc:b0:696:b235:f39 with SMTP id
 d12-20020a05621421cc00b00696b2350f39mr3973691qvh.6.1713995532175; 
 Wed, 24 Apr 2024 14:52:12 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 k11-20020a0cf28b000000b006a053b4c3adsm6369533qvl.118.2024.04.24.14.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 14:52:11 -0700 (PDT)
Date: Wed, 24 Apr 2024 17:52:09 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org, yc-core@yandex-team.ru
Subject: Re: [PATCH v2 1/2] migration: rework migrate_set_error() to
 migrate_report_err()
Message-ID: <Zil_CUVe7O2NjLRt@x1n>
References: <20240424174245.1237942-1-vsementsov@yandex-team.ru>
 <20240424174245.1237942-2-vsementsov@yandex-team.ru>
 <ZilgISOGWfODZvMC@x1n>
 <0230a7ce-af4f-4767-984d-ac069b0a9d19@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0230a7ce-af4f-4767-984d-ac069b0a9d19@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Apr 24, 2024 at 10:50:14PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 24.04.24 22:40, Peter Xu wrote:
> > On Wed, Apr 24, 2024 at 08:42:44PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > 1. Most of callers want to free the error after call. Let's help them.
> > > 
> > > 2. Some callers log the error, some not. We also have places where we
> > >     log the stored error. Let's instead simply log every migration
> > >     error.
> > > 
> > > 3. Some callers have to retrieve current migration state only to pass
> > >     it to migrate_set_error(). In the new helper let's get the state
> > >     automatically.
> > > 
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > > ---
> > >   migration/migration.c    | 48 ++++++++++++----------------------------
> > >   migration/migration.h    |  2 +-
> > >   migration/multifd.c      | 18 ++++++---------
> > >   migration/postcopy-ram.c |  3 +--
> > >   migration/savevm.c       | 16 +++++---------
> > >   5 files changed, 28 insertions(+), 59 deletions(-)
> > > 
> > > diff --git a/migration/migration.c b/migration/migration.c
> > > index 696762bc64..806b7b080b 100644
> > > --- a/migration/migration.c
> > > +++ b/migration/migration.c
> > > @@ -285,7 +285,7 @@ void migration_bh_schedule(QEMUBHFunc *cb, void *opaque)
> > >   void migration_cancel(const Error *error)
> > >   {
> > >       if (error) {
> > > -        migrate_set_error(current_migration, error);
> > > +        migrate_report_err(error_copy(error));
> > >       }
> > >       if (migrate_dirty_limit()) {
> > >           qmp_cancel_vcpu_dirty_limit(false, -1, NULL);
> > > @@ -779,13 +779,6 @@ process_incoming_migration_co(void *opaque)
> > >       }
> > >       if (ret < 0) {
> > > -        MigrationState *s = migrate_get_current();
> > > -
> > > -        if (migrate_has_error(s)) {
> > > -            WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
> > > -                error_report_err(s->error);
> > > -            }
> > > -        }
> > >           error_report("load of migration failed: %s", strerror(-ret));
> > >           goto fail;
> > >       }
> > > @@ -1402,10 +1395,6 @@ static void migrate_fd_cleanup(MigrationState *s)
> > >                             MIGRATION_STATUS_CANCELLED);
> > >       }
> > > -    if (s->error) {
> > > -        /* It is used on info migrate.  We can't free it */
> > > -        error_report_err(error_copy(s->error));
> > > -    }
> > >       type = migration_has_failed(s) ? MIG_EVENT_PRECOPY_FAILED :
> > >                                        MIG_EVENT_PRECOPY_DONE;
> > >       migration_call_notifiers(s, type, NULL);
> > > @@ -1418,12 +1407,14 @@ static void migrate_fd_cleanup_bh(void *opaque)
> > >       migrate_fd_cleanup(opaque);
> > >   }
> > > -void migrate_set_error(MigrationState *s, const Error *error)
> > > +void migrate_report_err(Error *error)
> > >   {
> > > +    MigrationState *s = migrate_get_current();
> > 
> > Avoid passing in *s looks ok.
> > 
> > >       QEMU_LOCK_GUARD(&s->error_mutex);
> > >       if (!s->error) {
> > >           s->error = error_copy(error);
> > 
> > I think I get your point, but then looks like this error_copy() should be
> > removed but forgotten?
> > 
> > I remember I had an attempt to do similarly (but only transfer the
> > ownership):
> > 
> > https://lore.kernel.org/qemu-devel/20230829214235.69309-3-peterx@redhat.com/
> > 
> > However I gave up later and I forgot why.  One reason could be that I hit a
> > use-after-free, then found that well indeed leaking an Error is much better
> > than debugging a UAF.
> 
> Hmm, yes I saw a leaked Error somewhere, and this patch should fix it. But may be I missed introducing this use-after-free again)

Ah do you mean you fixed a bug?  If so please use a standalone patch for
that and we'll need to copy stable.

I did notice that in this series on patch looks like does more than one
thing.  It'll be helpful too for reviewers when patch can be split
properly.

> 
> > 
> > So maybe we simply keep it like before?  If you like such change, let's
> > just be extremely caucious.
> > 
> > >       }
> > > +    error_report_err(error);
> > 
> > The ideal case to me is we don't trigger an error_report() all over the
> > place.  We're slightly going backward from that regard, IMHO..
> > 
> > Ideally I think we shouldn't dump anything to stderr, but user should
> > always query from qmp.
> > 
> 
> Sounds reasonable to me. I'm just unsure, if keep it like before, how
> should I correctly update logging to stderr in
> process_incoming_migration_co(). Could we just drop error reporting to
> stderr? Or should it be kept as is for the case when exit_on_error is
> true?

I'm not sure I get the question, but I'll comment in patch 2 very soon, so
we can move the discussion there.

Thanks,

-- 
Peter Xu


