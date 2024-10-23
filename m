Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F4DCFA462
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 20:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3ha8-0006rK-4o; Wed, 23 Oct 2024 16:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3hZz-0006qo-OS
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 16:03:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3hZu-0004oB-UD
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 16:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729713812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tvDkId3UzGEP9fhWU7PXzk8/4OUe1f/4nO0CuLXMGj4=;
 b=bn8fc/FB8yrFVFUOPqoWV6wEtj3/KDgtJPnud05JjI6A2grYKEB80PAM6xzEekHk1NAKU0
 mgfklh60VWISSSG+5RDcd9LuB2mISuUB5y7JghSBQeKAfjGNEMuYbkaVZGKVFcq/5/7Wx/
 azSoJ/GvDPNeoPPdgPlTZqmd+WVZfbM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-KQoIA8g3MhG6M2aWKYxw3w-1; Wed, 23 Oct 2024 16:03:30 -0400
X-MC-Unique: KQoIA8g3MhG6M2aWKYxw3w-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b1786fe413so28817785a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 13:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729713810; x=1730318610;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tvDkId3UzGEP9fhWU7PXzk8/4OUe1f/4nO0CuLXMGj4=;
 b=jGpe3ZVkdaFBPy1Qux1gPsY6aIPl2zDHs0LFJmsMguYLCEyUt32r4534w237dLzVfX
 An5YgMHwdx00ZokpCnPFYTxaA6M98sp6ASGEBXZAojVE+2S+nWob05OOGieH7++syPLn
 gynPtmTXNEX0L5GfUcCmNAOC6cVFapjm3fmf9c4+uxuAFAiU+eNREusMGXGOgQtPxVKF
 CUv9QaEPouyHkBBHgbRXcHmSGNLYV9QCAf8PaiKWzqUPxcYPPxlSmWKT+pDOBKcs7fAP
 Eas7JuSQxgPXI65FXEthWn6yQXTyAbLplqk1XTxu+z6DF+WIphMa/PyE3za3m8lcP8lE
 Fhwg==
X-Gm-Message-State: AOJu0Yzjop5URroM0mV2QczayKtzTk+1OzQbo1AIg0sMrGTBVCJPMQ/z
 ZhG5I11NEC+K9w4UzA6w27r5I9LiFWph4omsTOfTtGBr5pWEONYhB5IBtqEwxghlJV9HBbgjq0L
 YJJKhuQp184TJ6kRqCu9H6cdkiOBl+6AlOI3eim8SX374D1jETQS0
X-Received: by 2002:a05:620a:198a:b0:7b1:51df:116a with SMTP id
 af79cd13be357-7b17e56c8e3mr481165985a.14.1729713810219; 
 Wed, 23 Oct 2024 13:03:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFu+4xgex7kicvJv2Yrkyk0ygrtSuR94XVCtEStvKvkJszRWezVZ2HY8JA0kr+iNtta25CSxQ==
X-Received: by 2002:a05:620a:198a:b0:7b1:51df:116a with SMTP id
 af79cd13be357-7b17e56c8e3mr481160685a.14.1729713809753; 
 Wed, 23 Oct 2024 13:03:29 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b165a78c22sm417021985a.121.2024.10.23.13.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 13:03:29 -0700 (PDT)
Date: Wed, 23 Oct 2024 16:03:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH v2 0/4] Migration: Make misc.h helpers available for
 whole VM lifecycle
Message-ID: <ZxlWjpVfRzCg1PJA@x1n>
References: <20241023180216.1072575-1-peterx@redhat.com>
 <87ed46fwem.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ed46fwem.fsf@suse.de>
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

On Wed, Oct 23, 2024 at 04:32:01PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > This is a follow up of below patch from Avihai as a replacement:
> >
> > https://lore.kernel.org/qemu-devel/20241020130108.27148-3-avihaih@nvidia.com/
> >
> > This is v2 of the series, and it became a more generic rework on how we do
> > migration object refcounts, so I skipped a changelog because most of this
> > is new things.
> >
> > To put it simple, now I introduced another pointer to migration object, and
> > here's a simple explanation for both after all change applied (copy-paste
> > from one of the patch):
> >
> > /*
> >  * We have two pointers for the global migration objects.  Both of them are
> >  * initialized early during QEMU starts, but they have different lifecycles.
> 
> The very next person that needs to access one of those in migration code
> will get this wrong.

Migration code should never access global_migration except during init /
shutdown (or a renamed version of it), that's the plan.. so no one should
use it within migration/.

> 
> >  *
> >  * - current_migration
> >  *
> >  *   This variable reflects the whole lifecycle of the migration object
> >  *   (which each QEMU can only have one).  It is valid until the migration
> >  *   object is destroyed.
> >  *
> >  *   This is the object that internal migration so far use.  For example,
> >  *   internal helper migrate_get_current() references it.
> >  *
> >  *   When all migration code can always pass over a MigrationState* around,
> >  *   this variable can logically be dropped.  But we're not yet there.
> 
> Won't dropping it just bring us back to the situation before this patch?
> I'd say we need the opposite, to stop using migrate_get_current()
> everywhere in the migration code and instead expose the
> current_migration via an internal header.

I meant dropping all the global access to current_migration within
migration/ dir.

Consider all functions has the 1st parameter as MigrationState*, for
example.  Then we don't need that for internal use, while global_migration
is still needed for external use, but only for external use.

> 
> >  *
> >  * - global_migration
> 
> Both are global, we can't prefix one of them with global_.

I can rename it to migration_export, but the question is whether the name
is the issue, or you'd think having two global variables pointing to
migration object is the issue / concern.

So I think fundaementally we indeed only need one global var there, if we
can cleanup the migration/ everywhere to always take the pointer from the
caller, then migration thread will take 1 refcount and that guarantees it's
available for migration/.

> 
> >  *
> >  *   This is valid only until the migration object is still valid to the
> >  *   outside-migration world (until migration_shutdown()).
> >  *
> >  *   This should normally be always set, cleared or accessed by the main
> >  *   thread only, rather than the migration thread.
> >  *
> >  *   All the exported functions (in include/migration) should reference the
> >  *   exported migration object only to avoid race conditions, as
> >  *   current_migration can be freed concurrently by migration thread when
> >  *   the migration thread holds the last refcount.
> >  */
> 
> Have you thought of locking the migration object instead?

Yes, logically we could use RCU if we want, then take BQL for example only
if update.  but I worry that's an overkill: we'll need too many rcu read
lock all over the places..

> 
> Having two global pointers to the same object with one having slightly
> different lifecycle than the other will certainly lead to misuse.

That's indeed tricky, it's just that this is so far the easiest change I
can think of.

> 
> I worry about mixing the usage of both globals due to some migration
> code that needs to call these exported functions or external code
> reaching into migration/ through some indirect path. Check global and
> try to use current sort of scenarios (and vice-versa).

Yeh I get your concern.  I actually tried to observe such usages (for now,
especially when migration/ uses the misc.h exported functions) and they're
all safe.  I should have mentioned that.

For the other way round, I don't yet expect that to happen: the plan is
anything outside must call a function in include/migration/* and that must
only use global_migration.

> 
> Similarly, what about when a lingering reference still exists, but
> global_migration is already clear? Any migration code looking at
> global_migration would do the wrong thing.

That's how it works: migration thread will take one refcount and that'll
happen when migration is running but when VM shutdowns itself.  I checked
that all the migration code should be fine when using the exported
functions even if they should reference current_migration.

So logically if with such design, indeed internal migration/ code shouldn't
reference global_migration at all just to be always safe.

Any idea in your mind that can make this easier?  I'm definitely open to
suggestions.

> 
> >
> > It allows all misc.h exported helpers to be used for the whole VM
> > lifecycle, so as to never crash QEMU with freed migration objects.
> 
> Isn't there a race with the last reference being dropped at
> migration_shutdown() and global_migration still being set?

It needs to be protected by BQL in this case, so anyone using exported
functions need to take BQL first.

> 
> >
> > Thanks,
> >
> > Peter Xu (4):
> >   migration: Unexport dirty_bitmap_mig_init() in misc.h
> >   migration: Reset current_migration properly
> >   migration: Add global_migration
> >   migration: Make all helpers in misc.h safe to use without migration
> >
> >  include/migration/misc.h | 29 ++++++++----
> >  migration/migration.h    |  4 ++
> >  migration/migration.c    | 99 +++++++++++++++++++++++++++++++++++-----
> >  3 files changed, 113 insertions(+), 19 deletions(-)
> 

-- 
Peter Xu


