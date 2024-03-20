Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1240CC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 18:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn17z-0007Cn-Pa; Wed, 20 Mar 2024 14:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rn17x-0007CN-80
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 14:57:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rn17t-00016o-J0
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 14:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710961044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zmvww3LzCjKeexNxgdfwJzX3TPo+pwR1ag2WnPC49os=;
 b=UeSTJ9Xtg1VqcMLsITWNpo36hUhvoi8uzfv5yRKchOuPqbIwyafRB9JA3PvbA9QuHcBSMD
 JmOTL3PxJ2EHG9r9MfVxFpm0aLh0aJZDzgMOB4AMPdxV2ywxHo5/AaEEdJYv3WV9qFEB2d
 HM5n8T9H/kPGsR9IGFvHRSTaEW0BIuY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-Jn0b1HddM42S4qVXdvjnTQ-1; Wed, 20 Mar 2024 14:57:23 -0400
X-MC-Unique: Jn0b1HddM42S4qVXdvjnTQ-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4311dd10102so467091cf.0
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 11:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710961042; x=1711565842;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zmvww3LzCjKeexNxgdfwJzX3TPo+pwR1ag2WnPC49os=;
 b=TUhS+XbSXsfgv0C7LOydNbQNSaMej/Y1L8Q34Xfkzd6XUl6PeT2mlSvU+XSwfbjVHd
 DcdVLRdgEpatsO2Ph6uNEN11FlFzmr8lRYQvuUnd8qMr/XsTOj5jWYmiKO0zSpQSFdmP
 SM7QCfEZW9AvFUVSrAs4pA3X2ZiTYSXa3QNrIWIXqjCRpAxGWC56KmqaSzHLbHUHiH4o
 iPdMmKu5WnyZ3Fp/z5Jy8efss/bZua6hic6Kqc3Xjf241maIchJgmL28lYNXH+heXLAT
 RXSTRLUL5Y7r4F6qPY+oKYrzhU2Hqjgj/Md44emM6oDoPgvC5eoJ+ZJ5h8ZmTZX6lYSq
 BC+w==
X-Gm-Message-State: AOJu0YzT5S/Hh/XOU7OtrEOBUbO1MnZys4UV3pZgptF+eZfkWdGoZADn
 VXtYDuYUaG7gFzQ/2Hld3zmm+f+wHXRMRXZkrYdU94U93vquCsiyV0EfB6w9MD072QP1H7PhpCG
 sMPfSBrXc62AbxgHdLzzJ+pJCEDPMcttINjy0Y6dqu8YkcKBXOjyJ
X-Received: by 2002:a05:6214:2e49:b0:690:d02f:f5df with SMTP id
 my9-20020a0562142e4900b00690d02ff5dfmr6886210qvb.5.1710961042457; 
 Wed, 20 Mar 2024 11:57:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqSunSz/3FcPvf08YIQOWHZHVL4GQz37SKRDW6pFy6dJvqKybk4Mr37HzW5A/+pdJT1m7kNQ==
X-Received: by 2002:a05:6214:2e49:b0:690:d02f:f5df with SMTP id
 my9-20020a0562142e4900b00690d02ff5dfmr6886196qvb.5.1710961041998; 
 Wed, 20 Mar 2024 11:57:21 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 jf14-20020a0562142a4e00b00690afbf56d5sm8056819qvb.66.2024.03.20.11.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 11:57:19 -0700 (PDT)
Date: Wed, 20 Mar 2024 14:57:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Prasad Pandit <ppandit@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Bandan Das <bdas@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH 2/3] migration: Drop unnecessary check in ram's
 pending_exact()
Message-ID: <ZfsxjS4Phkf34f4J@x1n>
References: <20240117075848.139045-1-peterx@redhat.com>
 <20240117075848.139045-3-peterx@redhat.com>
 <bc88f4572649084cd38a0880d7e096a939f80b14.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bc88f4572649084cd38a0880d7e096a939f80b14.camel@linux.ibm.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Mar 20, 2024 at 06:51:26PM +0100, Nina Schoetterl-Glausch wrote:
> On Wed, 2024-01-17 at 15:58 +0800, peterx@redhat.com wrote:
> > From: Peter Xu <peterx@redhat.com>
> > 
> > When the migration frameworks fetches the exact pending sizes, it means
> > this check:
> > 
> >   remaining_size < s->threshold_size
> > 
> > Must have been done already, actually at migration_iteration_run():
> > 
> >     if (must_precopy <= s->threshold_size) {
> >         qemu_savevm_state_pending_exact(&must_precopy, &can_postcopy);
> > 
> > That should be after one round of ram_state_pending_estimate().  It makes
> > the 2nd check meaningless and can be dropped.
> > 
> > To say it in another way, when reaching ->state_pending_exact(), we
> > unconditionally sync dirty bits for precopy.
> > 
> > Then we can drop migrate_get_current() there too.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Hi Peter,

Hi, Nina,

> 
> could you have a look at this issue:
> https://gitlab.com/qemu-project/qemu/-/issues/1565
> 
> which I reopened. Previous thread here:
> 
> https://lore.kernel.org/qemu-devel/20230324184129.3119575-1-nsg@linux.ibm.com/
> 
> I'm seeing migration failures with s390x TCG again, which look the same to me
> as those a while back.

I'm still quite confused how that could be caused of this.

What you described in the previous bug report seems to imply some page was
leftover in migration so some page got corrupted after migrated.

However what this patch mostly does is it can sync more than before even if
I overlooked the condition check there (I still think the check is
redundant, there's one outlier when remaining_size == threshold_size, but I
don't think it should matter here as of now).  It'll make more sense if
this patch made the sync less, but that's not the case but vice versa.

> 
> > ---
> >  migration/ram.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/migration/ram.c b/migration/ram.c
> > index c0cdcccb75..d5b7cd5ac2 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -3213,21 +3213,20 @@ static void ram_state_pending_estimate(void *opaque, uint64_t *must_precopy,
> >  static void ram_state_pending_exact(void *opaque, uint64_t *must_precopy,
> >                                      uint64_t *can_postcopy)
> >  {
> > -    MigrationState *s = migrate_get_current();
> >      RAMState **temp = opaque;
> >      RAMState *rs = *temp;
> > +    uint64_t remaining_size;
> >  
> > -    uint64_t remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;
> > -
> > -    if (!migration_in_postcopy() && remaining_size < s->threshold_size) {
> > +    if (!migration_in_postcopy()) {
> >          bql_lock();
> >          WITH_RCU_READ_LOCK_GUARD() {
> >              migration_bitmap_sync_precopy(rs, false);
> >          }
> >          bql_unlock();
> > -        remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;
> >      }
> >  
> > +    remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;
> > +
> >      if (migrate_postcopy_ram()) {
> >          /* We can do postcopy, and all the data is postcopiable */
> >          *can_postcopy += remaining_size;
> 
> This basically reverts 28ef5339c3 ("migration: fix ram_state_pending_exact()"), which originally
> made the issue disappear.
> 
> Any thoughts on the matter appreciated.

In the previous discussion, you mentioned that you bisected to the commit
and also verified the fix.  Now you also mentioned in the bz that you can't
reporduce this bug manually.

Is it still possible to be reproduced with some scripts?  Do you also mean
that it's harder to reproduce comparing to before?  In all cases, some way
to reproduce it would definitely be helpful.

Even if we want to revert this change, we'll need to know whether this will
fix your case so we need something to verify it before a revert.  I'll
consider that the last though as I had a feeling this is papering over
something else.

Thanks,

-- 
Peter Xu


