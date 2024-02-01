Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4E6C47DDF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 10:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVURY-00078K-WA; Thu, 01 Feb 2024 05:37:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVURY-000782-4Q
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 05:37:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVURW-0005Sd-Ey
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 05:37:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706783833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tY2Oq+oOJbWhUQrXh9UmQx0VV8y8itcOcHOyc8IwILs=;
 b=d6ZAO8W3jHRd//d7tuMnW+xl1ivYWYiLHQBx781rOzEELQM/Y3Pqaj9LgBr7EjUpiLVzDI
 OxW8HdZ/aUf6jruV7weUC9Cnv1Kr46AvElLiiRU2UR1AyYn+jYoFvpxK2OGcRfDNIMJA9j
 MLL+WLD4BAhFC5r/8h+8/njAEnvu6J4=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-sBk6YwEjMNildm7-aKra6Q-1; Thu, 01 Feb 2024 05:37:11 -0500
X-MC-Unique: sBk6YwEjMNildm7-aKra6Q-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6dde498715fso130165b3a.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 02:37:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706783831; x=1707388631;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tY2Oq+oOJbWhUQrXh9UmQx0VV8y8itcOcHOyc8IwILs=;
 b=gGuX47Ksqqu1TTTiB80x5KR3thbCFM1lRnF4xzRN77BEyqeHcYSBeURUtAlxCNm/uw
 IhNcf0OpTNXtdgsAOj/61xVYtkTyxd7UGgjehZcDfnRIsycvvu6CWdUmRZvTS4CTr2qY
 7rAxqLc3ZSycuDkGftIlAcFwrxvyV7WaF122I/aBBqznrDvZxTCfD7aYBb14s3QZ0PeT
 p+0Bmji0JS163cg1qNOpW1SXyiuu5nRPRlu0cFCIpywVElI57VxvF67zd9ggjhsRbk+e
 +PktRPO7rRkZfPu47NfBa6odrWDLX3LurLCYfF6KdpjiBLLjkqoNll7smOtF0F6gioRP
 xRZw==
X-Gm-Message-State: AOJu0Ywv6PmrIgZSjZTpFJs18fa1GjiequybsChyfwQKG63pK3CMcfWs
 osIzXSSf6XArpeUrkNV7BxBIKSnfbFmBKHy+JPI/8h4Nbbs3Stl3HJr4JzmeUXTY6PR+9/pQeRu
 fp58QAcSfxgPWTGdmPr1qGHAyj9nWStEMgzwrMsCUKOJIksEafWnP
X-Received: by 2002:a05:6a20:1441:b0:19e:317c:b353 with SMTP id
 a1-20020a056a20144100b0019e317cb353mr2214199pzi.2.1706783830879; 
 Thu, 01 Feb 2024 02:37:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHinkLTPL+weWHWwgsNS4XyPwxg2+qMOxj2SWhFcAIaO+MIKtYk8UjKaxPFpQlRMcfE0R+b4A==
X-Received: by 2002:a05:6a20:1441:b0:19e:317c:b353 with SMTP id
 a1-20020a056a20144100b0019e317cb353mr2214184pzi.2.1706783830474; 
 Thu, 01 Feb 2024 02:37:10 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCX/FSZQeH2rJqzmKfK4iVfUCNdJApSHKxOpw5F5m7ZtuVd7n4ixjepOEa+9vr81c9Mw6shtzUrquDBY4htm1Pb8bFZ8hUALaoriEKj/8sHtDJ0Z6DvlQfdGXMrRVoDaFjqIOU5qPX6hMPZsi7Y+UAMis7esClRcliiwIIz2GZNyqubaEbMIYW8MWEWjd3zi4LOvFcMbwVvbAAOUeqB7hRk=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001d95407f6f5sm847097plb.48.2024.02.01.02.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 02:37:10 -0800 (PST)
Date: Thu, 1 Feb 2024 18:37:01 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Bryan Zhang <bryan.zhang@bytedance.com>,
 Prasad Pandit <ppandit@redhat.com>, Yuan Liu <yuan1.liu@intel.com>,
 Avihai Horon <avihaih@nvidia.com>, Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH 07/14] migration/multifd: Simplify locking in sender thread
Message-ID: <Zbt0TUeKR3UTJnC0@x1n>
References: <20240131103111.306523-1-peterx@redhat.com>
 <20240131103111.306523-8-peterx@redhat.com>
 <87o7d1jlu5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o7d1jlu5.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5,
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

On Wed, Jan 31, 2024 at 05:21:06PM -0300, Fabiano Rosas wrote:
> peterx@redhat.com writes:
> 
> > From: Peter Xu <peterx@redhat.com>
> >
> > The sender thread will yield the p->mutex before IO starts, trying to not
> > block the requester thread.  This may be unnecessary lock optimizations,
> > because the requester can already read pending_job safely even without the
> > lock, because the requester is currently the only one who can assign a
> > task.
> 
> What about the coroutine yield at qio_channel_writev_full_all()? Is it
> safe from yield while holding a lock? Could the main loop dispatch the
> cleanup function, it calls join on the multifd thread and it deadlocks?

This should be fine, IMHO, as sender threads are never in a coroutine?
IOW, it should be qemu_in_coroutine()==false always.

> 
> >
> > Drop that lock complication on both sides:
> >
> >   (1) in the sender thread, always take the mutex until job done
> >   (2) in the requester thread, check pending_job clear lockless
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/multifd.c | 23 ++++++++++++++++-------
> >  1 file changed, 16 insertions(+), 7 deletions(-)
> >
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index 6a4863edd2..4dc5af0a15 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -429,7 +429,9 @@ static int multifd_send_pages(void)
> >          return -1;
> >      }
> >  
> > +    /* We wait here, until at least one channel is ready */
> >      qemu_sem_wait(&multifd_send_state->channels_ready);
> > +
> >      /*
> >       * next_channel can remain from a previous migration that was
> >       * using more channels, so ensure it doesn't overflow if the
> > @@ -441,17 +443,26 @@ static int multifd_send_pages(void)
> >              return -1;
> >          }
> >          p = &multifd_send_state->params[i];
> > -        qemu_mutex_lock(&p->mutex);
> > +        /*
> > +         * Lockless read to p->pending_job is safe, because only multifd
> > +         * sender thread can clear it.
> > +         */
> >          if (!p->pending_job) {
> 
> The worst it could happen is we read at the same time the thread is
> clearing it and we loop to the next channel. So it doesn't need to be
> atomic either.

Yep.  Actually the worst case is when all the rest N-1 channels are all
busy, then we loop N more times to fetch this pending_job finally became
false, but only if a race, so should be fine.

I'll switch to qatomic_read|set() in v2, btw, which I forgot yesterday.  in
case some compiler does register-cache tricks here to avoid a dead loop.

> 
> > -            p->pending_job = true;
> >              next_channel = (i + 1) % migrate_multifd_channels();
> >              break;
> >          }
> > -        qemu_mutex_unlock(&p->mutex);
> >      }
> > +
> > +    qemu_mutex_lock(&p->mutex);
> 
> What data this lock protects now? Everything below here only happens
> after this thread sees pending_job==false. It seems we would only need a
> barrier on the multifd thread to make sure p->pending_job=false is
> ordered after everything.
> 
> Even for the "sync" case, it appears the lock is not needed as well?

Great question. :)

Let's see whether we can remove the lock.  Since I'll need to run for
today, I'll have a closer look tomorrow.

Hopefully we still keep this patch untouched? The goal of this patch
originally was only trying to simplify the sender thread on releasing lock
one more time.  Current change should avoid that already.

> 
> We might need to remove p->running first and move the kick from
> multifd_send_terminate_threads() into multifd_save_cleanup() like I
> suggested, but it seems like we could remove this lock.
> 
> Which would make sense, because there's nothing another thread would
> want to do with a channel's MultiFDSendParams unless the channel is idle
> waiting for work.
> 
> > +    /*
> > +     * Double check on pending_job==false with the lock.  In the future if
> > +     * we can have >1 requester thread, we can replace this with a "goto
> > +     * retry", but that is for later.
> > +     */
> > +    assert(p->pending_job == false);
> > +    p->pending_job = true;
> >      assert(!p->pages->num);
> >      assert(!p->pages->block);
> > -
> >      p->packet_num = multifd_send_state->packet_num++;
> 
> I noticed this line cannot be here. If the channel thread takes long to
> wakeup, the "sync" code will increment once more and overwrite this
> field. This and the identical line at multifd_send_sync_main() should go
> into multifd_send_fill_packet() I think.

Another good one.

This is similarly relevant to my effort to split pending_job into two:
these two things (job/sync) are potentially racy on using *p.

Moving it to threads will require an atomic op, but I'll do it, because
otherwise it's racy as you correctly pointed out.

Another work for me tomorrow; I'll prepare something.

> 
> >      multifd_send_state->pages = p->pages;
> >      p->pages = pages;
> > @@ -704,8 +715,6 @@ static void *multifd_send_thread(void *opaque)
> >              multifd_send_fill_packet(p);
> >              p->num_packets++;
> >              p->total_normal_pages += pages->num;
> > -            qemu_mutex_unlock(&p->mutex);
> > -
> >              trace_multifd_send(p->id, packet_num, pages->num, p->flags,
> >                                 p->next_packet_size);
> >  
> > @@ -725,6 +734,7 @@ static void *multifd_send_thread(void *opaque)
> >              ret = qio_channel_writev_full_all(p->c, p->iov, p->iovs_num, NULL,
> >                                                0, p->write_flags, &local_err);
> >              if (ret != 0) {
> > +                qemu_mutex_unlock(&p->mutex);
> >                  break;
> >              }
> >  
> > @@ -733,7 +743,6 @@ static void *multifd_send_thread(void *opaque)
> >  
> >              multifd_pages_reset(p->pages);
> >              p->next_packet_size = 0;
> > -            qemu_mutex_lock(&p->mutex);
> >              p->pending_job = false;
> >              qemu_mutex_unlock(&p->mutex);
> >          } else if (p->pending_sync) {
> 

-- 
Peter Xu


