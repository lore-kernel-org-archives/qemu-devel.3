Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFC8D5C0C8
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 13:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9PNV-0005PI-VI; Fri, 08 Nov 2024 08:50:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t9PNU-0005P8-Nd
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 08:50:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t9PNS-0004t9-2W
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 08:50:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731073816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N7IIHp2htkATktS74xh5+MpR42+z5btxMLC9PgzQKio=;
 b=S4hn9olmusbSNeUE0I+JtOTbtkF5BbGonDaWXrPqmwzPOU6HRk+LJDouigVkgZPwtbIqlJ
 lk+j0OWGibJg3PyxSAhvAMj7VBce+F3dcaSweKSl4Ud0NsC+6qexiHLhzH0Nwqv5dxGtHA
 UUu1UPVAUXJ/kRfy5CD3YbN6zJlu+Lg=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-cpo4APmWOjuIk2q-nj-DrQ-1; Fri, 08 Nov 2024 08:50:15 -0500
X-MC-Unique: cpo4APmWOjuIk2q-nj-DrQ-1
X-Mimecast-MFC-AGG-ID: cpo4APmWOjuIk2q-nj-DrQ
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3e60970ed1dso2481603b6e.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 05:50:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731073814; x=1731678614;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N7IIHp2htkATktS74xh5+MpR42+z5btxMLC9PgzQKio=;
 b=fzkJPVKrC9lHxgerKKwfKuIPLoftEPvkZtNVEHM/83B2Fzd/3EEcpLCNrARdtmrm+k
 fSM4F3crLDGcUbxF/oCfcqtToSadoDmOwe6D+vWLlOfVbcH6kwYm7vbzTL/rTgIoGRoh
 7KOy5r03cbOZJb35EFkTMXpRlzV8fWE6A3Zoyjzj5RkcO3C5la3xIQ+fg+z0ndaMGMb9
 RCBQoYuH1mp2umtG6JwDzFcvuPsJtD4d1ONYg1DhKbhwBVvzay2p7t+b+/U9zcUlOYaa
 9TA77cd29tSqJInY5A0tBo6BHbPYjXuGxwm48M5Mfi3IDXR7qnBZRfsmiN1HSXTkbjdG
 r6XA==
X-Gm-Message-State: AOJu0Yw/auXk6+2W/W67XpBshjEzqFRouDQIJ6k7B4Zlw6U3DwVx1izs
 /9Q3Y1ufsol6EFi48DxvUB1m8Dp6DWv06Z5m6REz0dQEavA25AN6OLk5skBPzvB2XjUgrD1fYTc
 wmQ4c7q+8TIIP0ArPmNMRbvfCv5uqkO2AfTQ4OYCoCoNHsqn/Gi9L
X-Received: by 2002:a05:6808:21a7:b0:3db:1cd1:cadd with SMTP id
 5614622812f47-3e79467a5d7mr3359863b6e.18.1731073814384; 
 Fri, 08 Nov 2024 05:50:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBhCjEW6nL8iwDazYmZ/uBcmMGHAGJvlnMb8G4Focx5WTa9aH1KnoF1owLkHzr3CW3IYFgPQ==
X-Received: by 2002:a05:6808:21a7:b0:3db:1cd1:cadd with SMTP id
 5614622812f47-3e79467a5d7mr3359850b6e.18.1731073813971; 
 Fri, 08 Nov 2024 05:50:13 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3e78ccbdf63sm702000b6e.30.2024.11.08.05.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 05:50:12 -0800 (PST)
Date: Fri, 8 Nov 2024 08:50:10 -0500
From: Peter Xu <peterx@redhat.com>
To: Yong Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Do not perform RAMBlock dirty sync during the
 first iteration
Message-ID: <Zy4XEjI2JIagxsyB@x1n>
References: <ad543bac0eb9e7113eaec266add58c19f9f6eda0.1730973055.git.yong.huang@smartx.com>
 <ZyzqosT0uE6_G4as@x1n>
 <CAK9dgmZCZp3scJTAGJc=KF9dgaftxD=V3uUADeyyYqFc_yGhkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK9dgmZCZp3scJTAGJc=KF9dgaftxD=V3uUADeyyYqFc_yGhkA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

On Fri, Nov 08, 2024 at 02:03:47PM +0800, Yong Huang wrote:
> On Fri, Nov 8, 2024 at 12:28 AM Peter Xu <peterx@redhat.com> wrote:
> 
> > On Thu, Nov 07, 2024 at 05:56:50PM +0800, yong.huang@smartx.com wrote:
> > > From: Hyman Huang <yong.huang@smartx.com>
> > >
> > > The first iteration's RAMBlock dirty sync can be omitted because QEMU
> > > always initializes the RAMBlock's bmap to all 1s by default.
> > >
> > > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > > ---
> > >  migration/cpu-throttle.c |  2 +-
> > >  migration/ram.c          | 19 ++++++++++++++++---
> > >  2 files changed, 17 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/migration/cpu-throttle.c b/migration/cpu-throttle.c
> > > index 5179019e33..674dc2004e 100644
> > > --- a/migration/cpu-throttle.c
> > > +++ b/migration/cpu-throttle.c
> > > @@ -141,7 +141,7 @@ void cpu_throttle_dirty_sync_timer_tick(void *opaque)
> > >       * effect on guest performance, therefore omit it to avoid
> > >       * paying extra for the sync penalty.
> > >       */
> > > -    if (sync_cnt <= 1) {
> > > +    if (!sync_cnt) {
> > >          goto end;
> > >      }
> > >
> > > diff --git a/migration/ram.c b/migration/ram.c
> > > index 05ff9eb328..a0123eb93e 100644
> > > --- a/migration/ram.c
> > > +++ b/migration/ram.c
> > > @@ -2718,7 +2718,7 @@ static void ram_list_init_bitmaps(void)
> > >  {
> > >      MigrationState *ms = migrate_get_current();
> > >      RAMBlock *block;
> > > -    unsigned long pages;
> > > +    unsigned long pages, clear_bmap_pages;
> > >      uint8_t shift;
> > >
> > >      /* Skip setting bitmap if there is no RAM */
> > > @@ -2736,6 +2736,7 @@ static void ram_list_init_bitmaps(void)
> > >
> > >          RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> > >              pages = block->max_length >> TARGET_PAGE_BITS;
> > > +            clear_bmap_pages = clear_bmap_size(pages, shift);
> > >              /*
> > >               * The initial dirty bitmap for migration must be set with
> > all
> > >               * ones to make sure we'll migrate every guest RAM page to
> > > @@ -2751,7 +2752,12 @@ static void ram_list_init_bitmaps(void)
> > >                  block->file_bmap = bitmap_new(pages);
> > >              }
> > >              block->clear_bmap_shift = shift;
> > > -            block->clear_bmap = bitmap_new(clear_bmap_size(pages,
> > shift));
> > > +            block->clear_bmap = bitmap_new(clear_bmap_pages);
> > > +            /*
> > > +             * Set clear_bmap to 1 unconditionally, as we always set
> > bmap
> > > +             * to all 1s by default.
> > > +             */
> > > +            bitmap_set(block->clear_bmap, 0, clear_bmap_pages);
> > >          }
> > >      }
> > >  }
> > > @@ -2771,6 +2777,7 @@ static void
> > migration_bitmap_clear_discarded_pages(RAMState *rs)
> > >
> > >  static bool ram_init_bitmaps(RAMState *rs, Error **errp)
> > >  {
> > > +    Error *local_err = NULL;
> > >      bool ret = true;
> > >
> > >      qemu_mutex_lock_ramlist();
> > > @@ -2783,7 +2790,13 @@ static bool ram_init_bitmaps(RAMState *rs, Error
> > **errp)
> > >              if (!ret) {
> > >                  goto out_unlock;
> > >              }
> > > -            migration_bitmap_sync_precopy(false);
> > > +            /*
> > > +             * Bypass the RAMBlock dirty sync and still publish the
> > > +             * notification.
> >
> > Hmm.. Why should QEMU notify AFTER_BITMAP_SYNC if the sync didn't happen?
> >
> 
> Indeed, logically, we should not make the notification.
> 
> Some features, like VIRTIO_BALLOON_F_FREE_PAGE_HINT, use this notification
> to indirectly detect whether the RAMBlock's bmap has been updated. This
> allows the
> free page optimization to begin clearing parts of the bitmap that contain
> free pages.
> 
> virtio_balloon_free_page_hint_notify
> ......
>     switch (pnd->reason) {
>     case PRECOPY_NOTIFY_BEFORE_BITMAP_SYNC:
>         virtio_balloon_free_page_stop(dev);
>         break;
>     case PRECOPY_NOTIFY_AFTER_BITMAP_SYNC:
>         if (vdev->vm_running) {
>             virtio_balloon_free_page_start(dev);
>             break;
>         }
> 
> The free page optimization may miss the first time window to execute if we
> don't
> send out a notification after starting the migration and initializing the
> bmap with all 1s.
> 
> May we change the old behavior of optimization?

I see.

It looks like an abuse to me so far to use AFTER_BITMAP_SYNC as start of
free page hinting.  There's no guarantee a sync is needed when start
migration.

I think we may want a pre-requisite patch to enable free page hinting
during PRECOPY_NOTIFY_SETUP too, like PRECOPY_NOTIFY_AFTER_BITMAP_SYNC.
That patch (if you agree) will need to copy David Hildenbrand and Wei Wang
(original author).

Thanks,

-- 
Peter Xu


