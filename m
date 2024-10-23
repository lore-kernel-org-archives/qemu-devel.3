Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6601CCDDE7D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 15:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3dFD-0004aD-AU; Wed, 23 Oct 2024 11:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3dFB-0004a1-KO
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 11:25:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3dF9-00050K-1E
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 11:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729697149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1/J9J/1fkxBxTIlmR7uB0SgkY56/84OFPU1dS8a/rbY=;
 b=dnSvpO/oC+qT/vrNTkB97FnGG6CymFKz8zbb0M7xhqn+AYiDF/Rj4bmdUjSt24yVNcng8l
 q3GJG5vKwOGKD7NwjCAA0vIHMwqXjYI0zbn64uBUhccwe6n1iLWi+Y4FK9UJ26dZ6TmA3T
 MwAGbJldDnw/36RiPVzUtQLemjcAeIM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-CZEVfwHlPP-8VnyD3tw0JA-1; Wed, 23 Oct 2024 11:25:48 -0400
X-MC-Unique: CZEVfwHlPP-8VnyD3tw0JA-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-460d8f8f5d4so52890961cf.1
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 08:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729697148; x=1730301948;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1/J9J/1fkxBxTIlmR7uB0SgkY56/84OFPU1dS8a/rbY=;
 b=k/kkAn+jpUG/P5718fZqgNCHm94mpjwWbi8fLwYaJ8DaHLKmnhiN0Zia1EvRyqhyHo
 XbleHgWSAY07y1EDKfTgih4qx76g0Ci4aChzeIOimxqNanKhFv0khI9gFd4QszXi4Q0t
 VsDfC2PbiXYN5VfwxYb7v4XtF7xRGLYY9tlVnp7vRIr5O6LSYeOMln2UTCh+UHdlNL3L
 4yyAfURgjCXSthyyVHRkLU8W9JtGqTYHqzdrGAxBOO/aTnFpiCxoE2FM2VXPCvCi+Z2c
 pYIjYMmqQI+Iq5d8ak/2FhiGJW1FN63L8DvsHWp8k43+1dGJZDANwSvtFWA/ELwrbI6n
 yZag==
X-Gm-Message-State: AOJu0YywS/JnCeGs5CJnF/Rn5If83zUSDitKS0QGx0keJrxCdCh5OhPv
 mFHLlFKSRBgkDH9xS5Rp5mndHT8W/YMzwnF0GHhV5ojho2AqKFo8PW0bwUg2jKV4hMNS/xIwEzC
 xZAR5O4YJFdpVra4NbwJrxBMTq/vFtuN6rj6gQD3CMRCZrwIRHTRM
X-Received: by 2002:ac8:5904:0:b0:458:2e48:b5ec with SMTP id
 d75a77b69052e-461147065dcmr46728841cf.45.1729697147901; 
 Wed, 23 Oct 2024 08:25:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqwqOwM4XqKbM/dJ9g9zF52S5V1JTuePeGB4E9N0BinJ/ZvuSHKYJcwruunMvYjYlReH7y5g==
X-Received: by 2002:ac8:5904:0:b0:458:2e48:b5ec with SMTP id
 d75a77b69052e-461147065dcmr46728431cf.45.1729697147512; 
 Wed, 23 Oct 2024 08:25:47 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460d39d54f5sm41956821cf.0.2024.10.23.08.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 08:25:47 -0700 (PDT)
Date: Wed, 23 Oct 2024 11:25:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 1/2] migration: Make all helpers in misc.h safe to use
 without migration
Message-ID: <ZxkVeMCac87w2jR_@x1n>
References: <20241022160720.1013543-1-peterx@redhat.com>
 <20241022160720.1013543-2-peterx@redhat.com>
 <0540c704-c2ce-41fc-bbb3-a2d84f0f2fc7@nvidia.com>
 <ZxkS0GCmPrOHN1_V@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxkS0GCmPrOHN1_V@x1n>
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

On Wed, Oct 23, 2024 at 11:14:24AM -0400, Peter Xu wrote:
> On Wed, Oct 23, 2024 at 11:30:14AM +0300, Avihai Horon wrote:
> > 
> > On 22/10/2024 19:07, Peter Xu wrote:
> > > External email: Use caution opening links or attachments
> > > 
> > > 
> > > Migration object can be freed before some other device codes run, while we
> > > do have a bunch of migration helpers exported in migration/misc.h that
> > > logically can be invoked at any time of QEMU, even during destruction of a
> > > VM.
> > > 
> > > Make all these functions safe to be called, especially, not crashing after
> > > the migration object is freed.
> > > 
> > > Add a rich comment in the header explaining how to guarantee thread safe on
> > > using these functions, and we choose BQL because fundamentally that's how
> > > it's working now.  We can move to other things (e.g. RCU) whenever
> > > necessary in the future but it's an overkill if we have BQL anyway in
> > > most/all existing callers.
> > > 
> > > When at it, update some comments, e.g. migrate_announce_params() is
> > > exported from options.c now.
> > > 
> > > Cc: Cédric Le Goater <clg@redhat.com>
> > > Cc: Avihai Horon <avihaih@nvidia.com>
> > > Cc: Fabiano Rosas <farosas@suse.de>
> > > Cc: Dr. David Alan Gilbert <dave@treblig.org>
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >   include/migration/misc.h | 33 ++++++++++++++++++++++++++++-----
> > >   migration/migration.c    | 22 +++++++++++++++++++++-
> > >   2 files changed, 49 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/include/migration/misc.h b/include/migration/misc.h
> > > index bfadc5613b..8d6812b8c7 100644
> > > --- a/include/migration/misc.h
> > > +++ b/include/migration/misc.h
> > > @@ -19,8 +19,26 @@
> > >   #include "qapi/qapi-types-net.h"
> > >   #include "migration/client-options.h"
> > > 
> > > -/* migration/ram.c */
> > > +/*
> > > + * Misc migration functions exported to be used in QEMU generic system
> > > + * code outside migration/.
> > > + *
> > > + * By default, BQL is required to use below functions to avoid race
> > > + * conditions (e.g. concurrent free of the migration object).  It's
> > > + * caller's responsibility to make sure it's thread safe otherwise when
> > > + * below helpers are used without BQL held.
> > > + *
> > > + * One example of the special case is migration_thread(), who will take a
> > > + * refcount of the migration object.  The refcount will make sure the
> > > + * migration object will not be freed concurrently when accessing through
> > > + * below helpers.
> > > + *
> > > + * When unsure, always take BQL first before using the helpers.
> > > + */
> > > 
> > > +/*
> > > + * migration/ram.c
> > > + */
> > >   typedef enum PrecopyNotifyReason {
> > >       PRECOPY_NOTIFY_SETUP = 0,
> > >       PRECOPY_NOTIFY_BEFORE_BITMAP_SYNC = 1,
> > > @@ -43,14 +61,19 @@ void ram_mig_init(void);
> > >   void qemu_guest_free_page_hint(void *addr, size_t len);
> > >   bool migrate_ram_is_ignored(RAMBlock *block);
> > > 
> > > -/* migration/block.c */
> > > -
> > > +/*
> > > + * migration/options.c
> > > + */
> > >   AnnounceParameters *migrate_announce_params(void);
> > > -/* migration/savevm.c */
> > > 
> > > +/*
> > > + * migration/savevm.c
> > > + */
> > >   void dump_vmstate_json_to_file(FILE *out_fp);
> > > 
> > > -/* migration/migration.c */
> > > +/*
> > > + * migration/migration.c
> > > + */
> > >   void migration_object_init(void);
> > >   void migration_shutdown(void);
> > >   bool migration_is_idle(void);
> > > diff --git a/migration/migration.c b/migration/migration.c
> > > index bcb735869b..27341eed50 100644
> > > --- a/migration/migration.c
> > > +++ b/migration/migration.c
> > > @@ -1121,6 +1121,10 @@ bool migration_is_setup_or_active(void)
> > >   {
> > >       MigrationState *s = current_migration;
> > > 
> > > +    if (!s) {
> > > +        return false;
> > > +    }
> > > +
> > >       switch (s->state) {
> > >       case MIGRATION_STATUS_ACTIVE:
> > >       case MIGRATION_STATUS_POSTCOPY_ACTIVE:
> > > @@ -1136,7 +1140,6 @@ bool migration_is_setup_or_active(void)
> > > 
> > >       default:
> > >           return false;
> > > -
> > >       }
> > >   }
> > > 
> > > @@ -1685,6 +1688,10 @@ bool migration_is_active(void)
> > >   {
> > >       MigrationState *s = current_migration;
> > > 
> > > +    if (!s) {
> > > +        return false;
> > > +    }
> > > +
> > >       return (s->state == MIGRATION_STATUS_ACTIVE ||
> > >               s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
> > >   }
> > > @@ -1693,6 +1700,10 @@ bool migration_is_device(void)
> > >   {
> > >       MigrationState *s = current_migration;
> > > 
> > > +    if (!s) {
> > > +        return false;
> > > +    }
> > > +
> > >       return s->state == MIGRATION_STATUS_DEVICE;
> > >   }
> > > 
> > > @@ -1700,6 +1711,11 @@ bool migration_thread_is_self(void)
> > >   {
> > >       MigrationState *s = current_migration;
> > > 
> > > +    /* If no migration object, must not be the migration thread */
> > > +    if (!s) {
> > > +        return false;
> > > +    }
> > > +
> > >       return qemu_thread_is_self(&s->thread);
> > >   }
> > > 
> > > @@ -3077,6 +3093,10 @@ void migration_file_set_error(int ret, Error *err)
> > >   {
> > >       MigrationState *s = current_migration;
> > > 
> > > +    if (!s) {
> > > +        return;
> > > +    }
> > > +
> > 
> > I think this is not enough because current_migration is never set to NULL
> > after it's destroyed.
> > 
> > Can we add "current_migration = NULL;" to migration_instance_finalize()?
> 
> Good point..
> 
> I thought it was cleared already in migration_shutdown(), but now I just
> noticed why it can't - we have too many dangling references in migration/
> so that it needs to be there even if migration threads holds one refcount.
> 
> I'll add one more patch as you suggested as of now and repost soon.  It's
> not the cleanest that we clear that global pointer in a finalize(), but
> looks like that's the only simple way forward.

After a 2nd thought, it might not work.  The issue is when the last
refcount is held by migration_thread, I _think_ it means the migration
thread will invoke this finalize(), reset current_migration, and then it
can race with a main thread calling any of the exported helpers again..

I'll think about it and prepare something else.  Probably we'll need two
variables for now holding the object, while the exported functions should
only reference the global one.  Then the global one can be reset in the
main thread always with no race possible when exit.

-- 
Peter Xu


