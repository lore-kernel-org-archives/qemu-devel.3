Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3997CDDE7D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 15:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3d4F-0007zr-Rl; Wed, 23 Oct 2024 11:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3d4D-0007zc-Tp
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 11:14:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3d4B-0003Kp-Lw
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 11:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729696469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iFf7+QMf3koSmDd3Jbv4YhPgMZPa/gLlEiHab8iYxPA=;
 b=TU+l5Yb+YtAFxou6jRgmMpII9/0s74BvXjIBwedF3Du74gxAoYAo5VZuaKBNbOBnWrbX6a
 ATUviQd0pG4SiAXZCUyK3D/99i3Rq3bu1AlJNMxQCytpFW/VH/pf1xX/80fsqQ10Eit203
 Wq25DmDojbsot2TMoS7+gU0FUzr+l7E=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-03aGjQ76P-GARJpZuAYr_g-1; Wed, 23 Oct 2024 11:14:27 -0400
X-MC-Unique: 03aGjQ76P-GARJpZuAYr_g-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-277fc980ec7so7362687fac.0
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 08:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729696467; x=1730301267;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iFf7+QMf3koSmDd3Jbv4YhPgMZPa/gLlEiHab8iYxPA=;
 b=qSNI+fCdJMm0O8rE+dAbhVbqSKWGYG5T7xJ3JJuo3pMN3TJqe9x9IMnbgcWtAduJRm
 E7nx+Nc9UX0Ig4PUIyApZO9MPLe0ePTM7+WQ1n0894/RLZ79JvU14PWyUR+wYeR9VrzW
 NdOj2mT30b0nXSc1p37Hr0R64982Kw0Hri7lneMnCOZFbD6/Km3Bso1QSX6SHqRwWmiH
 NriNKDmSokrq/lqqZuEenjWRYkN2oXAhFxgk7knJpr1oVGeHNFwphUUque+3JaVuyVYA
 bUIPSAZMuO1fB61aXU9v9+QEaSKwpxMA6zPnxjTuktYCK4oA8VE3ZJiGMyEF3QvQnIeu
 mi1A==
X-Gm-Message-State: AOJu0Yy5sDbwEV6fbeES41BzFZrlhvhf99OORbU/a+rEEz9yVPE0js+e
 FHTaoVh6n477HLv7Ljx9KTCV3m+XztBZ0CgHmVIQutcvYW3THZmwjgEjioB09hZqtugbRRrzXSN
 YkCgSzCLWnPxd4dFy2S1dbXA4lHLuBj4TFONnoHyB3z6yZNXBkusj
X-Received: by 2002:a05:6870:468e:b0:27b:4f51:d73a with SMTP id
 586e51a60fabf-28ccb8305a1mr3543622fac.21.1729696466999; 
 Wed, 23 Oct 2024 08:14:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5teBFLtCcx3ITJVdLHafV8PL6A3WqEVivHM7bP+6T1T52nAIO8Xc+9X3FQZ+yD5GLndznEQ==
X-Received: by 2002:a05:6870:468e:b0:27b:4f51:d73a with SMTP id
 586e51a60fabf-28ccb8305a1mr3543596fac.21.1729696466614; 
 Wed, 23 Oct 2024 08:14:26 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce009fd21asm40317746d6.133.2024.10.23.08.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 08:14:26 -0700 (PDT)
Date: Wed, 23 Oct 2024 11:14:24 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 1/2] migration: Make all helpers in misc.h safe to use
 without migration
Message-ID: <ZxkS0GCmPrOHN1_V@x1n>
References: <20241022160720.1013543-1-peterx@redhat.com>
 <20241022160720.1013543-2-peterx@redhat.com>
 <0540c704-c2ce-41fc-bbb3-a2d84f0f2fc7@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0540c704-c2ce-41fc-bbb3-a2d84f0f2fc7@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Oct 23, 2024 at 11:30:14AM +0300, Avihai Horon wrote:
> 
> On 22/10/2024 19:07, Peter Xu wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > Migration object can be freed before some other device codes run, while we
> > do have a bunch of migration helpers exported in migration/misc.h that
> > logically can be invoked at any time of QEMU, even during destruction of a
> > VM.
> > 
> > Make all these functions safe to be called, especially, not crashing after
> > the migration object is freed.
> > 
> > Add a rich comment in the header explaining how to guarantee thread safe on
> > using these functions, and we choose BQL because fundamentally that's how
> > it's working now.  We can move to other things (e.g. RCU) whenever
> > necessary in the future but it's an overkill if we have BQL anyway in
> > most/all existing callers.
> > 
> > When at it, update some comments, e.g. migrate_announce_params() is
> > exported from options.c now.
> > 
> > Cc: Cédric Le Goater <clg@redhat.com>
> > Cc: Avihai Horon <avihaih@nvidia.com>
> > Cc: Fabiano Rosas <farosas@suse.de>
> > Cc: Dr. David Alan Gilbert <dave@treblig.org>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   include/migration/misc.h | 33 ++++++++++++++++++++++++++++-----
> >   migration/migration.c    | 22 +++++++++++++++++++++-
> >   2 files changed, 49 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/migration/misc.h b/include/migration/misc.h
> > index bfadc5613b..8d6812b8c7 100644
> > --- a/include/migration/misc.h
> > +++ b/include/migration/misc.h
> > @@ -19,8 +19,26 @@
> >   #include "qapi/qapi-types-net.h"
> >   #include "migration/client-options.h"
> > 
> > -/* migration/ram.c */
> > +/*
> > + * Misc migration functions exported to be used in QEMU generic system
> > + * code outside migration/.
> > + *
> > + * By default, BQL is required to use below functions to avoid race
> > + * conditions (e.g. concurrent free of the migration object).  It's
> > + * caller's responsibility to make sure it's thread safe otherwise when
> > + * below helpers are used without BQL held.
> > + *
> > + * One example of the special case is migration_thread(), who will take a
> > + * refcount of the migration object.  The refcount will make sure the
> > + * migration object will not be freed concurrently when accessing through
> > + * below helpers.
> > + *
> > + * When unsure, always take BQL first before using the helpers.
> > + */
> > 
> > +/*
> > + * migration/ram.c
> > + */
> >   typedef enum PrecopyNotifyReason {
> >       PRECOPY_NOTIFY_SETUP = 0,
> >       PRECOPY_NOTIFY_BEFORE_BITMAP_SYNC = 1,
> > @@ -43,14 +61,19 @@ void ram_mig_init(void);
> >   void qemu_guest_free_page_hint(void *addr, size_t len);
> >   bool migrate_ram_is_ignored(RAMBlock *block);
> > 
> > -/* migration/block.c */
> > -
> > +/*
> > + * migration/options.c
> > + */
> >   AnnounceParameters *migrate_announce_params(void);
> > -/* migration/savevm.c */
> > 
> > +/*
> > + * migration/savevm.c
> > + */
> >   void dump_vmstate_json_to_file(FILE *out_fp);
> > 
> > -/* migration/migration.c */
> > +/*
> > + * migration/migration.c
> > + */
> >   void migration_object_init(void);
> >   void migration_shutdown(void);
> >   bool migration_is_idle(void);
> > diff --git a/migration/migration.c b/migration/migration.c
> > index bcb735869b..27341eed50 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -1121,6 +1121,10 @@ bool migration_is_setup_or_active(void)
> >   {
> >       MigrationState *s = current_migration;
> > 
> > +    if (!s) {
> > +        return false;
> > +    }
> > +
> >       switch (s->state) {
> >       case MIGRATION_STATUS_ACTIVE:
> >       case MIGRATION_STATUS_POSTCOPY_ACTIVE:
> > @@ -1136,7 +1140,6 @@ bool migration_is_setup_or_active(void)
> > 
> >       default:
> >           return false;
> > -
> >       }
> >   }
> > 
> > @@ -1685,6 +1688,10 @@ bool migration_is_active(void)
> >   {
> >       MigrationState *s = current_migration;
> > 
> > +    if (!s) {
> > +        return false;
> > +    }
> > +
> >       return (s->state == MIGRATION_STATUS_ACTIVE ||
> >               s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
> >   }
> > @@ -1693,6 +1700,10 @@ bool migration_is_device(void)
> >   {
> >       MigrationState *s = current_migration;
> > 
> > +    if (!s) {
> > +        return false;
> > +    }
> > +
> >       return s->state == MIGRATION_STATUS_DEVICE;
> >   }
> > 
> > @@ -1700,6 +1711,11 @@ bool migration_thread_is_self(void)
> >   {
> >       MigrationState *s = current_migration;
> > 
> > +    /* If no migration object, must not be the migration thread */
> > +    if (!s) {
> > +        return false;
> > +    }
> > +
> >       return qemu_thread_is_self(&s->thread);
> >   }
> > 
> > @@ -3077,6 +3093,10 @@ void migration_file_set_error(int ret, Error *err)
> >   {
> >       MigrationState *s = current_migration;
> > 
> > +    if (!s) {
> > +        return;
> > +    }
> > +
> 
> I think this is not enough because current_migration is never set to NULL
> after it's destroyed.
> 
> Can we add "current_migration = NULL;" to migration_instance_finalize()?

Good point..

I thought it was cleared already in migration_shutdown(), but now I just
noticed why it can't - we have too many dangling references in migration/
so that it needs to be there even if migration threads holds one refcount.

I'll add one more patch as you suggested as of now and repost soon.  It's
not the cleanest that we clear that global pointer in a finalize(), but
looks like that's the only simple way forward.

Will repost soon, thanks.

-- 
Peter Xu


