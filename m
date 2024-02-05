Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5576C48291
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 04:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWqiI-0007cf-KE; Sun, 04 Feb 2024 23:36:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rWqiG-0007cS-Tl
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 23:36:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rWqiC-0006D7-3y
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 23:36:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707107763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zKCdGgtj/2S/1ID9cHd1jSy5vS2/cXMpKwCO/cj2+5c=;
 b=PxOoHuyj7hh+IjPYV1bBnAtJo0vuaGyV0DUT4rtMre/Tqjbw2PkefQnylXU4r4dkNKgxGU
 OVKcCkGXv5krGAeaW2PR45ZseUvu8LnOsrnOvYkxRAt0ihse/j0VV/Z1CZXBryl8vL4WVd
 30dZcS3yJCF2rzmRs8tCcaHLU28u6KA=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-L73sAayKPjS6FOackngt_A-1; Sun, 04 Feb 2024 23:35:57 -0500
X-MC-Unique: L73sAayKPjS6FOackngt_A-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1d99192d3f6so454455ad.0
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 20:35:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707107756; x=1707712556;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zKCdGgtj/2S/1ID9cHd1jSy5vS2/cXMpKwCO/cj2+5c=;
 b=hQes6xAGFGNgytrbuuxPfn2TkJLq3rkMMNjbi42udUgmn5SRGzPtPaxwnNzKsFj+Ax
 ZwsRORqu2Yyf1oPfUT5MCFqv06FXg2G+5QIJRRaXPnoiYjjaUbgpCwpaZxb/sFxbLmTJ
 RdGnlVNtMT0d4PExfIC3QaiENuPoHKyyDzpN0xcN+JXHP6MNo0raXUTWQCzaTPf5ePnj
 UJq4C0Rs5k6+uVsTLC56voWqWq0z0k2Yd3HVAnlZE4FCSCR5za8hU/Xso3T4f5S8fA8W
 Z6CIvBSIHbr1ErgYSc3ho9ENu/jUH9dJ7g49P9hpcB0kHUTxVDlT6a6+T1CrPn86XqEn
 e/XQ==
X-Gm-Message-State: AOJu0YzJZMGFl8WiSPEZRuXDXsgqKEoF8sX2sH8cDz/adKYKmd81ao8w
 jWdcny4HiMRIrdLuq3HKtIxITgh0YnKg6c4uYEnFFqj1lKvBJW+CoDbxoy0NjbGgbinTW6QkCWU
 TXNJbwmdsNzNPCOZm8svVGxgvX55vEJG+ykqSnRUgALMXyP6tQVp2
X-Received: by 2002:a17:902:9f88:b0:1d9:73df:8e52 with SMTP id
 g8-20020a1709029f8800b001d973df8e52mr9312145plq.3.1707107756468; 
 Sun, 04 Feb 2024 20:35:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEchaDx5NgrdZCqwk5brqrFpqoLzU51+rMm2jQ6nlRTgoYpXBAAhVnertHDgb836DWoSozU7w==
X-Received: by 2002:a17:902:9f88:b0:1d9:73df:8e52 with SMTP id
 g8-20020a1709029f8800b001d973df8e52mr9312133plq.3.1707107756133; 
 Sun, 04 Feb 2024 20:35:56 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCX2EGrOyo+MZOsZph0Cf1z4uUo2F9qgC/9kl6v3yXJgGc+5QjgYV9GjNFzYCZ6i7Wu6yFEgoKILMAUjc4QS1M1MFoZMLB6Nn6kyo3/2W0dHATyO+ZWX64N63YDNhJ9koEhO9C/6EALW7T8oAo0MY5FdY+LdhYHHRi4SeLq8pPjrCwJLc3rOggTOOJ+Wr20pblp7AXgHaugIi6hNaDCQij8=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 la7-20020a170902fa0700b001d949393c50sm5258852plb.187.2024.02.04.20.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 20:35:55 -0800 (PST)
Date: Mon, 5 Feb 2024 12:35:45 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Hao Xiang <hao.xiang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>,
 Avihai Horon <avihaih@nvidia.com>, Yuan Liu <yuan1.liu@intel.com>,
 Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2 23/23] migration/multifd: Optimize sender side to be
 lockless
Message-ID: <ZcBloXUWBORVraiu@x1n>
References: <20240202102857.110210-1-peterx@redhat.com>
 <20240202102857.110210-24-peterx@redhat.com>
 <87wmrmft4f.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wmrmft4f.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Feb 02, 2024 at 06:34:08PM -0300, Fabiano Rosas wrote:
> peterx@redhat.com writes:
> 
> > From: Peter Xu <peterx@redhat.com>
> >
> > When reviewing my attempt to refactor send_prepare(), Fabiano suggested we
> > try out with dropping the mutex in multifd code [1].
> >
> > I thought about that before but I never tried to change the code.  Now
> > maybe it's time to give it a stab.  This only optimizes the sender side.
> >
> > The trick here is multifd has a clear provider/consumer model, that the
> > migration main thread publishes requests (either pending_job/pending_sync),
> > while the multifd sender threads are consumers.  Here we don't have a lot
> > of comlicated data sharing, and the jobs can logically be submitted lockless.
> 
> complicated
> 
> >
> > Arm the code with atomic weapons.  Two things worth mentioning:
> >
> >   - For multifd_send_pages(): we can use qatomic_load_acquire() when trying
> >   to find a free channel, but that's expensive if we attach one ACQUIRE per
> >   channel.  Instead, make it atomic_read() on the pending_job flag, but
> 
> s/make it/keep it/
> 
> The diff doesn't show the atomic_read already there so it's confusing.

Right.  I also has a trivial typo on s/atomic_read/qatomic_read/..

I tried to rephrase the last sentence:

  - For multifd_send_pages(): we can use qatomic_load_acquire() when trying
  to find a free channel, but that's expensive if we attach one ACQUIRE per
  channel.  Instead, keep the qatomic_read() on reading the pending_job
  flag as we do already, meanwhile use one smp_mb_acquire() after the loop
  to guarantee the memory ordering.

Maybe slightly clearer?

> 
> >   merge the ACQUIRE into one single smp_mb_acquire() later.
> >
> >   - For pending_sync: it doesn't have any extra data required since now
> >   p->flags are never touched, it should be safe to not use memory barrier.
> >   That's different from pending_sync.
> 
> pending_job?

Yep, all the rest fixed.

> 
> >
> > Provide rich comments for all the lockless operations to state how they are
> > paired.  With that, we can remove the mutex.
> >
> > [1] https://lore.kernel.org/r/87o7d1jlu5.fsf@suse.de
> >
> > Suggested-by: Fabiano Rosas <farosas@suse.de>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/multifd.h |  2 --
> >  migration/multifd.c | 51 +++++++++++++++++++++++----------------------
> >  2 files changed, 26 insertions(+), 27 deletions(-)
> >
> > diff --git a/migration/multifd.h b/migration/multifd.h
> > index 98876ff94a..78a2317263 100644
> > --- a/migration/multifd.h
> > +++ b/migration/multifd.h
> > @@ -91,8 +91,6 @@ typedef struct {
> >      /* syncs main thread and channels */
> >      QemuSemaphore sem_sync;
> >  
> > -    /* this mutex protects the following parameters */
> > -    QemuMutex mutex;
> >      /* is this channel thread running */
> >      bool running;
> >      /* multifd flags for each packet */
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index b317d57d61..ef13e2e781 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -501,19 +501,19 @@ static bool multifd_send_pages(void)
> >          }
> >      }
> >  
> > -    qemu_mutex_lock(&p->mutex);
> > -    assert(!p->pages->num);
> > -    assert(!p->pages->block);
> >      /*
> > -     * Double check on pending_job==false with the lock.  In the future if
> > -     * we can have >1 requester thread, we can replace this with a "goto
> > -     * retry", but that is for later.
> > +     * Make sure we read p->pending_job before all the rest.  Pairs with
> > +     * qatomic_store_release() in multifd_send_thread().
> >       */
> > -    assert(qatomic_read(&p->pending_job) == false);
> > -    qatomic_set(&p->pending_job, true);
> > +    smp_mb_acquire();
> > +    assert(!p->pages->num);
> >      multifd_send_state->pages = p->pages;
> >      p->pages = pages;
> > -    qemu_mutex_unlock(&p->mutex);
> > +    /*
> > +     * Making sure p->pages is setup before marking pending_job=true. Pairs
> > +     * with the qatomic_load_acquire() in multifd_send_thread().
> > +     */
> > +    qatomic_store_release(&p->pending_job, true);
> >      qemu_sem_post(&p->sem);
> >  
> >      return true;
> > @@ -648,7 +648,6 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
> >      }
> >      multifd_send_channel_destroy(p->c);
> >      p->c = NULL;
> > -    qemu_mutex_destroy(&p->mutex);
> >      qemu_sem_destroy(&p->sem);
> >      qemu_sem_destroy(&p->sem_sync);
> >      g_free(p->name);
> > @@ -742,14 +741,12 @@ int multifd_send_sync_main(void)
> >  
> >          trace_multifd_send_sync_main_signal(p->id);
> >  
> > -        qemu_mutex_lock(&p->mutex);
> >          /*
> >           * We should be the only user so far, so not possible to be set by
> >           * others concurrently.
> >           */
> >          assert(qatomic_read(&p->pending_sync) == false);
> >          qatomic_set(&p->pending_sync, true);
> > -        qemu_mutex_unlock(&p->mutex);
> >          qemu_sem_post(&p->sem);
> >      }
> >      for (i = 0; i < migrate_multifd_channels(); i++) {
> > @@ -796,9 +793,12 @@ static void *multifd_send_thread(void *opaque)
> >          if (multifd_send_should_exit()) {
> >              break;
> >          }
> > -        qemu_mutex_lock(&p->mutex);
> >  
> > -        if (qatomic_read(&p->pending_job)) {
> > +        /*
> > +         * Read pending_job flag before p->pages.  Pairs with the
> > +         * qatomic_store_release() in multifd_send_pages().
> > +         */
> > +        if (qatomic_load_acquire(&p->pending_job)) {
> >              MultiFDPages_t *pages = p->pages;
> >  
> >              p->iovs_num = 0;
> > @@ -806,14 +806,12 @@ static void *multifd_send_thread(void *opaque)
> >  
> >              ret = multifd_send_state->ops->send_prepare(p, &local_err);
> >              if (ret != 0) {
> > -                qemu_mutex_unlock(&p->mutex);
> >                  break;
> >              }
> >  
> >              ret = qio_channel_writev_full_all(p->c, p->iov, p->iovs_num, NULL,
> >                                                0, p->write_flags, &local_err);
> >              if (ret != 0) {
> > -                qemu_mutex_unlock(&p->mutex);
> >                  break;
> >              }
> >  
> > @@ -822,24 +820,31 @@ static void *multifd_send_thread(void *opaque)
> >  
> >              multifd_pages_reset(p->pages);
> >              p->next_packet_size = 0;
> > -            qatomic_set(&p->pending_job, false);
> > -            qemu_mutex_unlock(&p->mutex);
> > +
> > +            /*
> > +             * Making sure p->pages is published before saying "we're
> > +             * free".  Pairs with the qatomic_load_acquire() in
> 
> smp_mb_acquire()

Fixed.

Any more comment on the code changes before I repost?

(maybe I can repost this single patch in-place to avoid another round of
 mail bombs..)

-- 
Peter Xu


