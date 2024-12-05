Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B176E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 22:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJKJU-0002Mn-UO; Thu, 05 Dec 2024 17:27:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJKJT-0002MP-QD
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 17:27:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJKJO-0008V8-Jg
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 17:27:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733437618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nANu9mszsssAaXs5OxpL7C5Qmgi7JkI2H7i5oy1fgbg=;
 b=S/vO7yRuhfnL1ywjtVBq05d1t2OGaVRyeHhL5SWC6yUYdRtt5NfsLHw+YZwHslyOJS6FeD
 AP1ixV1wr5ek7bV9ejlZ9Si2eGHKxE76WS9B5cq/63hPOjATjnOHnoagME2pOqSMPzWwQq
 IB9ouYsBmfB3Qx7pygUuStM491A4NJ4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-hmPMOUfGMaaHtmqLIa3lQQ-1; Thu, 05 Dec 2024 17:26:57 -0500
X-MC-Unique: hmPMOUfGMaaHtmqLIa3lQQ-1
X-Mimecast-MFC-AGG-ID: hmPMOUfGMaaHtmqLIa3lQQ
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6d8b3173b5bso23844396d6.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 14:26:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733437617; x=1734042417;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nANu9mszsssAaXs5OxpL7C5Qmgi7JkI2H7i5oy1fgbg=;
 b=Vx9bIjDKMX/40tJxRyOzobzyxPBzcqA4EL5+ygQ96IojS8+UT5wbU5qo3o5EJMcGqE
 6JJAkO9nV0GkpxOxSVtAwivz9kY+FFWg+kemRSCisC2c6075AoFwU4a3F24G8t6UJF6t
 GSR87mr/ynLKEttFshisd9GOj4/5mRm09qddVOyihycEEVgv4GijGPBNU6Vg9PIXbXOg
 X79UQeqiy58htInPkGVOXf0qha65hwIjew1HaSdr+vzsrMhiD0XiGYjqZEwP4bigij4Q
 9Z/6F9GYgp62sTyodYKPhq5VjNLgGAU4/Imv58ECuSA1RG0eBmdatAQh4XfpEwrUPUK8
 yqVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJ5wkaukBitfoUKFcA588khH/N2hfALy3HUISXUVsw4noa1e8XbFL2aK0+0nzTAV/EjwyrdkO1FWVg@nongnu.org
X-Gm-Message-State: AOJu0Yy+M0WKkt+z6xovFplVui1DAdbA/y1CHyCeZui8y2rBAuuP9ZMS
 ILNgPs7XD61gZoJO9u+dcKLxAYiPEPaohhNPXuaoXhuv5BL0XtNb9GVk1jitRVZyR/7pi6syYJ1
 gO/NvGRba/co+WIVxvR9M9xWTEEnS0ilmKUiJkL9Hu9//hdoI81YV
X-Gm-Gg: ASbGncsb0b3vEk4pI2B4u5KeFOc4drVTs2CO8Kj+6cljMAKhwa+24Rr7uh4E/o8bYeV
 es/kFDIRXEk8ONJeQ74PT/1cpOXjss+zsE8+PI6u1GMnHigxNgahXRJw98J1zxTDF70nSzOCUvb
 nSZQlKUPK/nVVdWlaxk2+fEdG9iFCOSeu6hpxdO0JCmI+7yVbeXBtm4r/Q/trB9/m+LPGwsT5Mq
 0Tnf1vx8C+jk9dL6MZmjthr4ZV6ejE3K4yO1LiK9pkptzs/RRa8mIkfarBokc4272Xe/cYgGrSi
 sSkAHtpCHLU=
X-Received: by 2002:a05:6214:400b:b0:6d4:36ff:4356 with SMTP id
 6a1803df08f44-6d8e7175765mr10177276d6.19.1733437616630; 
 Thu, 05 Dec 2024 14:26:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEj9FZfF0vhtJSwO5JOSHddWcA2i7ZtdGA1lAbtRsc9CKBlJD/Atsxh9Z2FhAxGKchYPXEuFw==
X-Received: by 2002:a05:6214:400b:b0:6d4:36ff:4356 with SMTP id
 6a1803df08f44-6d8e7175765mr10176886d6.19.1733437616218; 
 Thu, 05 Dec 2024 14:26:56 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8dabfb7afsm11140206d6.109.2024.12.05.14.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 14:26:55 -0800 (PST)
Date: Thu, 5 Dec 2024 17:26:53 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org,
 berrange@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v1 3/4] migration: refactor ram_save_target_page functions
Message-ID: <Z1IorZjVKNoF4_nA@x1n>
References: <20241126115748.118683-1-ppandit@redhat.com>
 <20241126115748.118683-4-ppandit@redhat.com>
 <87ed2xn16y.fsf@suse.de>
 <CAE8KmOwfzFyBWfq_Vhr-hjT4jGQQqi6_gZwkNGtd8SVLxhi0QQ@mail.gmail.com>
 <875xo8n4ue.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875xo8n4ue.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Wed, Nov 27, 2024 at 11:12:09AM -0300, Fabiano Rosas wrote:
> Prasad Pandit <ppandit@redhat.com> writes:
> 
> > On Wed, 27 Nov 2024 at 02:49, Fabiano Rosas <farosas@suse.de> wrote:
> >> This patch should be just the actual refactoring on top of master, with
> >> no mention to postcopy at all.
> >
> > * Okay. We'll have to ensure that it is merged before multifd+postcopy change.
> >
> >> > +            if (migrate_multifd() && !migration_in_postcopy()
> >> > +                && (!migrate_multifd_flush_after_each_section()
> >> > +                    || migrate_mapped_ram())) {
> >>
> >> This is getting out of hand. We can't keep growing this condition every
> >> time something new comes up. Any ideas?
> >
> > * In 'v0' this series, !migration_in_postcopy() was added to
> > migrate_multifd(), which worked, but was not okay.
> >
> > * Another could be to define a new helper/macro to include above 3-4
> > checks. Because migrate_multifd(),
> > migrate_multifd_flush_after_each_section() and migrate_mapped_ram()
> > appear together at multiple points. But strangely the equation is not
> > the same. Sometimes migrate_mapped_ram() is 'true' and sometimes it is
> > 'false', so a combined helper may not work.  It is all to accommodate
> > different workings of multifd IIUC, if it and precopy used the same
> > protocol/stream, maybe such conditionals would go away automatically.
> 
> Maybe this would improve the situation. Peter, what do you think?
> 
> -->8--
> From e9110360eb0efddf6945f37c518e3cc38d12b600 Mon Sep 17 00:00:00 2001
> From: Fabiano Rosas <farosas@suse.de>
> Date: Wed, 27 Nov 2024 11:03:04 -0300
> Subject: [PATCH] migration: Rationalize multifd flushes from ram code
> 
> We currently have a mess of conditionals to achieve the correct
> combination of multifd local flushes, where we sync the local
> (send/recv) multifd threads between themselves, and multifd remote
> flushes, where we put a flag on the stream to inform the recv side to
> perform a local flush.
> 
> On top of that we also have the multifd_flush_after_each_section
> property, which is there to provide backward compatibility from when
> we used to flush after every vmstate section.
> 
> And lastly, there's the mapped-ram feature which always wants the
> non-backward compatible behavior and also does not support extraneous
> flags on the stream (such as the MULTIFD_FLUSH flag).
> 
> Move the conditionals into a separate function that encapsulates and
> explains the whole situation.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/ram.c | 198 ++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 157 insertions(+), 41 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 05ff9eb328..caaaae6fdc 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1277,6 +1277,149 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss)
>      return pages;
>  }
>  
> +enum RamMultifdFlushSpots {
> +    FLUSH_SAVE_SETUP,
> +    FLUSH_SAVE_ITER,
> +    FLUSH_DIRTY_BLOCK,
> +    FLUSH_SAVE_COMPLETE,
> +
> +    FLUSH_LOAD_POSTCOPY_EOS,
> +    FLUSH_LOAD_POSTCOPY_FLUSH,
> +    FLUSH_LOAD_PRECOPY_EOS,
> +    FLUSH_LOAD_PRECOPY_FLUSH,

POSTCOPY ones could be confusing, because we don't support them at all.  We
should remove them actually from ram_load_postcopy()..

> +};
> +
> +static int ram_multifd_flush(QEMUFile *f, enum RamMultifdFlushSpots spot)
> +{
> +    int ret;
> +    bool always_flush, do_local_flush, do_remote_flush;
> +    bool mapped_ram = migrate_mapped_ram();
> +
> +    if (!migrate_multifd()) {
> +        return 0;
> +    }
> +
> +    /*
> +     * For backward compatibility, whether to flush multifd after each
> +     * section is sent. This is mutually exclusive with a
> +     * RAM_SAVE_FLAG_MULTIFD_FLUSH on the stream
> +     */
> +    always_flush = migrate_multifd_flush_after_each_section();
> +
> +    /*
> +     * Save side flushes
> +     */
> +
> +    do_local_flush = false;
> +
> +    switch (spot) {
> +    case FLUSH_SAVE_SETUP:
> +        assert(!bql_locked());
> +        do_local_flush = true;
> +        break;
> +
> +    case FLUSH_SAVE_ITER:
> +        /*
> +         * This flush is not necessary, only do for backward
> +         * compatibility. Mapped-ram assumes the new scheme.
> +         */
> +        do_local_flush = always_flush && !mapped_ram;
> +        break;
> +
> +    case FLUSH_DIRTY_BLOCK:
> +        /*
> +         * This is the flush that's actually required, always do it
> +         * unless we're emulating the old behavior.
> +         */
> +        do_local_flush = !always_flush || mapped_ram;
> +        break;
> +
> +    case FLUSH_SAVE_COMPLETE:
> +        do_local_flush = true;
> +        break;
> +
> +    default:
> +        break;
> +    }
> +
> +    if (do_local_flush) {
> +        ret = multifd_ram_flush_and_sync();
> +        if (ret < 0) {
> +            return ret;
> +        }
> +    }
> +
> +    /*
> +     * There's never a remote flush with mapped-ram because any flags
> +     * put on the stream (aside from RAM_SAVE_FLAG_MEM_SIZE and
> +     * RAM_SAVE_FLAG_EOS) break mapped-ram's assumption that ram pages
> +     * can be read contiguously from the stream.
> +     *
> +     * On the recv side, there's no local flush, even at EOS because
> +     * mapped-ram does its own flush after loading the ramblock.
> +     */
> +    if (mapped_ram) {
> +        return 0;
> +    }
> +
> +    do_remote_flush = false;
> +
> +    /* Save side remote flush */
> +    switch (spot) {
> +    case FLUSH_SAVE_SETUP:
> +        do_remote_flush = !always_flush;
> +        break;
> +
> +    case FLUSH_SAVE_ITER:
> +        do_remote_flush = false;
> +        break;
> +
> +    case FLUSH_DIRTY_BLOCK:
> +        do_remote_flush = do_local_flush;
> +        break;
> +
> +    case FLUSH_SAVE_COMPLETE:
> +        do_remote_flush = false;
> +        break;
> +
> +    default:
> +        break;
> +    }
> +
> +    /* Put a flag on the stream to trigger a remote flush */
> +    if (do_remote_flush) {
> +        qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
> +        qemu_fflush(f);
> +    }

Unify RAM_SAVE_FLAG_MULTIFD_FLUSH is definitely great.

> +
> +    /*
> +     * Load side flushes.
> +     */
> +
> +    do_local_flush = false;
> +
> +    switch (spot) {
> +    case FLUSH_LOAD_PRECOPY_EOS:
> +    case FLUSH_LOAD_POSTCOPY_EOS:
> +        do_local_flush = always_flush;
> +        break;
> +
> +    case FLUSH_LOAD_PRECOPY_FLUSH:
> +    case FLUSH_LOAD_POSTCOPY_FLUSH:
> +        do_local_flush = true;
> +        break;
> +
> +    default:
> +        break;
> +    }
> +
> +    if (do_local_flush) {
> +        multifd_recv_sync_main();
> +    }

Having send/recv call the same function can be prone to errors, IMHO.

> +
> +    return 0;

This is a lenghy function!

It solves one problem where the caller is clean, however it didn't solve
the other problem on when we want to know whether a sync is done, it's
harder to follow to me. :(

> +}
> +
>  static int ram_save_multifd_page(RAMBlock *block, ram_addr_t offset)
>  {
>      if (!multifd_queue_page(block, offset)) {
> @@ -1323,19 +1466,10 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
>          pss->page = 0;
>          pss->block = QLIST_NEXT_RCU(pss->block, next);
>          if (!pss->block) {
> -            if (migrate_multifd() &&
> -                (!migrate_multifd_flush_after_each_section() ||
> -                 migrate_mapped_ram())) {
> -                QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
> -                int ret = multifd_ram_flush_and_sync();
> -                if (ret < 0) {
> -                    return ret;
> -                }
> -
> -                if (!migrate_mapped_ram()) {
> -                    qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
> -                    qemu_fflush(f);
> -                }
> +            int ret = ram_multifd_flush(rs->pss[RAM_CHANNEL_PRECOPY].pss_channel,
> +                                        FLUSH_DIRTY_BLOCK);
> +            if (ret < 0) {
> +                return ret;
>              }
>  
>              /* Hit the end of the list */
> @@ -3065,18 +3199,13 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
>      }
>  
>      bql_unlock();
> -    ret = multifd_ram_flush_and_sync();
> +    ret = ram_multifd_flush(f, FLUSH_SAVE_SETUP);

Not relevant to this patch.  I believe this flush_and_sync() is also not
needed for modern QEMUs.  It was there also for the same reason as
complete(): EOS requires that on old ones..

>      bql_lock();
>      if (ret < 0) {
>          error_setg(errp, "%s: multifd synchronization failed", __func__);
>          return ret;
>      }
>  
> -    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()
> -        && !migrate_mapped_ram()) {
> -        qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
> -    }
> -
>      qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
>      ret = qemu_fflush(f);
>      if (ret < 0) {
> @@ -3209,12 +3338,10 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>  
>  out:
>      if (ret >= 0 && migration_is_running()) {
> -        if (migrate_multifd() && migrate_multifd_flush_after_each_section() &&
> -            !migrate_mapped_ram()) {
> -            ret = multifd_ram_flush_and_sync();
> -            if (ret < 0) {
> -                return ret;
> -            }
> +
> +        ret = ram_multifd_flush(f, FLUSH_SAVE_ITER);
> +        if (ret < 0) {
> +            return ret;
>          }
>  
>          qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
> @@ -3283,7 +3410,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>          }
>      }
>  
> -    ret = multifd_ram_flush_and_sync();
> +    ret = ram_multifd_flush(f, FLUSH_SAVE_COMPLETE);
>      if (ret < 0) {
>          return ret;
>      }
> @@ -3797,14 +3924,11 @@ int ram_load_postcopy(QEMUFile *f, int channel)
>              }
>              break;
>          case RAM_SAVE_FLAG_MULTIFD_FLUSH:
> -            multifd_recv_sync_main();
> +            ram_multifd_flush(f, FLUSH_LOAD_POSTCOPY_FLUSH);
>              break;
>          case RAM_SAVE_FLAG_EOS:
>              /* normal exit */
> -            if (migrate_multifd() &&
> -                migrate_multifd_flush_after_each_section()) {
> -                multifd_recv_sync_main();
> -            }
> +            ram_multifd_flush(f, FLUSH_LOAD_POSTCOPY_EOS);
>              break;
>          default:
>              error_report("Unknown combination of migration flags: 0x%x"
> @@ -4237,19 +4361,11 @@ static int ram_load_precopy(QEMUFile *f)
>              }
>              break;
>          case RAM_SAVE_FLAG_MULTIFD_FLUSH:
> -            multifd_recv_sync_main();
> +            ram_multifd_flush(f, FLUSH_LOAD_PRECOPY_FLUSH);
>              break;
>          case RAM_SAVE_FLAG_EOS:
>              /* normal exit */
> -            if (migrate_multifd() &&
> -                migrate_multifd_flush_after_each_section() &&
> -                /*
> -                 * Mapped-ram migration flushes once and for all after
> -                 * parsing ramblocks. Always ignore EOS for it.
> -                 */
> -                !migrate_mapped_ram()) {
> -                multifd_recv_sync_main();
> -            }
> +            ram_multifd_flush(f, FLUSH_LOAD_PRECOPY_EOS);
>              break;
>          case RAM_SAVE_FLAG_HOOK:
>              ret = rdma_registration_handle(f);
> -- 
> 2.35.3
> 

I do come up with a plan to clean this up.  I gave it a shot, it's less
code change than this one, and I hope it's acceptable and easier to read.
But I'm ready if you want to say no to it.  Let's discuss.

Meanwhile since the VFIO patch would be relevant (on complete()), I'll need
to resend that two patches series, but add my version of cleaning this on
top.

Give me a few hours to test it, then I'll resend that one with this
altogether.  Let's see how you think about it.

-- 
Peter Xu


