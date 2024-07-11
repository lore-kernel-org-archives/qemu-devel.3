Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF389C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 16:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRwOG-0007cv-FK; Thu, 11 Jul 2024 12:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sRwOC-0007Sz-9H
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 12:11:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sRwO8-0001U3-VM
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 12:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720714279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ph6lIvdR1pvrTmUHKPdx7Gko7Qm/tr8mYN5mwtlf4NE=;
 b=KmOLRNVT2bQ8WiKR7s0tjABH/APGAnhjVnP9m+XqcILjtkCICcxz/O2fpFCkfjKyunHQXz
 CXwuuKniSmziCBI5NGKZcmQnfZ4dZcSq1WRmFvKX1SbtVhgqKPnU4SSRdLQ1j9Ce3YcX/A
 XiTwXygkbJneQi52qpIwPmE0m3avY+c=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-mcpTvmytOv6D-Od6Vio9cg-1; Thu, 11 Jul 2024 12:11:18 -0400
X-MC-Unique: mcpTvmytOv6D-Od6Vio9cg-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-79f7b0e4f82so3447685a.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 09:11:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720714277; x=1721319077;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ph6lIvdR1pvrTmUHKPdx7Gko7Qm/tr8mYN5mwtlf4NE=;
 b=CbabVFD/FoIGwtqFm2Q6odkVQtSpgd378YWApwNiUDocpWw+fhUgWXXltFuKHDZQxR
 Uan6IDvgtjYqGltWhll5mHtrN1b/fyb87QdUN2BNKtHMs5Gw10VbD+ZTBretWmwXEcgC
 Lzsi98aqRGL/o4i+3JDQRDuSng/ef8SdSKrN2W+6/jkM6IFJlrMYh5BoNND5tN5zfn5n
 u4hsArFFqZUQ7fsQs47DbNOBKKFdJqjkrNILLIKy58QnN8B2wH1dOI7HbgDEhSaQwiFN
 bHFCW+oJuu5gBLMOi//NeYR/YIaUmlg43KkzNmd6jJIyoOcwfWOF9GzXgXeqj7wHt0ls
 lvpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8uPfxHNVCo3GblHLXl1WsJfOuDBV8GGC+pnXscKTRvvmL5gM6ToHYiGmawNM53EQh8zw35gC6ONsv0/Si9IJGL8RjHTo=
X-Gm-Message-State: AOJu0Ywq7ZWGzEj+m/7UUG387huy5hL4jfXhavE8jHixrW7mqfJTcye8
 jwqzpcuz8cx3TvCGVdI4bZhdTlvsn+omUwVOVGLda6dqx2VTWJlh5zJeiFS/69SU0duPNASfl4J
 SphVIT/HXcDv2JhL23CgHnSuQu4lwjOOMhqqHg/Ehp4LjNmn6ijiEXvyW+lZJ
X-Received: by 2002:a05:620a:997:b0:79f:ff1:b765 with SMTP id
 af79cd13be357-7a1470e7237mr251672185a.0.1720714277018; 
 Thu, 11 Jul 2024 09:11:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHONkQzRqo/R9whPSvmKmftI45HdiPsHgTmch41B/JDFIUXJdCQfC9Dtef5KekF/UfaLz3rTA==
X-Received: by 2002:a05:620a:997:b0:79f:ff1:b765 with SMTP id
 af79cd13be357-7a1470e7237mr251669185a.0.1720714276670; 
 Thu, 11 Jul 2024 09:11:16 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79f1909a56dsm304670185a.101.2024.07.11.09.11.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 09:11:15 -0700 (PDT)
Date: Thu, 11 Jul 2024 12:11:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: "Wang, Lei" <lei4.wang@intel.com>, qemu-devel@nongnu.org,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH 6/7] migration/multifd: Move payload storage out of
 the channel parameters
Message-ID: <ZpAEIvbNr-ANuASV@x1n>
References: <20240620212111.29319-1-farosas@suse.de>
 <20240620212111.29319-7-farosas@suse.de>
 <e60bc0c7-dc49-400e-88f1-a30c32943f25@intel.com>
 <Zn15y693g0AkDbYD@x1n> <877cdtfcsi.fsf@suse.de>
 <Zo7cncqkxB89AUBe@x1n> <87y169dmu3.fsf@suse.de>
 <Zo8DaHbWlrNe3RXL@x1n> <87msmodnly.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87msmodnly.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On Thu, Jul 11, 2024 at 11:12:09AM -0300, Fabiano Rosas wrote:
> What about the QEMUFile traffic? There's an iov in there. I have been
> thinking of replacing some of qemu-file.c guts with calls to
> multifd. Instead of several qemu_put_byte() we could construct an iov
> and give it to multifd for transfering, call multifd_sync at the end and
> get rid of the QEMUFile entirely. I don't have that completely laid out
> at the moment, but I think it should be possible. I get concerned about
> making assumptions on the types of data we're ever going to want to
> transmit. I bet someone thought in the past that multifd would never be
> used for anything other than ram.

Hold on a bit.. there're two things I want to clarity with you.

Firstly, qemu_put_byte() has buffering on f->buf[].  Directly changing them
to iochannels may regress performance.  I never checked, but I would assume
some buffering will be needed for small chunk of data even with iochannels.

Secondly, why multifd has things to do with this?  What you're talking
about is more like the rework of qemufile->iochannel thing to me, and IIUC
that doesn't yet involve multifd.  For many of such conversions, it'll
still be operating on the main channel, which is not the multifd channels.
What matters might be about what's in your mind to be put over multifd
channels there.

> 
> >
> > I wonder why handshake needs to be done per-thread.  I was naturally
> > thinking the handshake should happen sequentially, talking over everything
> > including multifd.
> 
> Well, it would still be thread based. Just that it would be 1 thread and
> it would not be managed by multifd. I don't see the point. We could make
> everything be multifd-based. Any piece of data that needs to reach the
> other side of the migration could be sent through multifd, no?

Hmm.... yes we can. But what do we gain from it, if we know it'll be a few
MBs in total?  There ain't a lot of huge stuff to move, it seems to me.

> 
> Also, when you say "per-thread", that's the model we're trying to get
> away from. There should be nothing "per-thread", the threads just
> consume the data produced by the clients. Anything "per-thread" that is
> not strictly related to the thread model should go away. For instance,
> p->page_size, p->page_count, p->write_flags, p->flags, etc. None of
> these should be in MultiFDSendParams. That thing should be (say)
> MultifdChannelState and contain only the semaphores and control flags
> for the threads.
> 
> It would be nice if we could once and for all have a model that can
> dispatch data transfers without having to fiddle with threading all the
> time. Any time someone wants to do something different in the migration
> code, there it goes a random qemu_create_thread() flying around.

That's exactly what I want to avoid.  Not all things will need a thread,
only performance relevant ones.

So now we have multifd threads, they're for IO throughputs: if we want to
push a fast NIC, that's the only way to go.  Anything wants to push that
NIC, should use multifd.

Then it turns out we want more concurrency, it's about VFIO save()/load()
of the kenrel drivers and it can block.  Same to other devices that can
take time to save()/load() if it can happen concurrently in the future.  I
think that's the reason why I suggested the VFIO solution to provide a
generic concept of thread pool so it services a generic purpose, and can be
reused in the future.

I hope that'll stop anyone else on migration to create yet another thread
randomly, and I definitely don't like that either.  I would _suspect_ the
next one to come as such is TDX.. I remember at least in the very initial
proposal years ago, TDX migration involves its own "channel" to migrate,
migration.c may not even know where is that channel.  We'll see.

[...]

> > One thing to mention is that when with an union we may probably need to get
> > rid of multifd_send_state->pages already.
> 
> Hehe, please don't do this like "oh, by the way...". This is a major
> pain point. I've been complaining about that "holding of client data"
> since the fist time I read that code. So if you're going to propose
> something, it needs to account for that.

The client puts something into a buffer (SendData), then it delivers it to
multifd (who silently switches the buffer).  After enqueued, the client
assumes the buffer is sent and reusable again.

It looks pretty common to me, what is the concern within the procedure?
What's the "holding of client data" issue?

> 
> > The object can't be a global
> > cache (in which case so far it's N+1, N being n_multifd_channels, while "1"
> > is the extra buffer as only RAM uses it).  In the union world we'll need to
> > allocate M+N SendData, where N is still the n_multifd_channels, and M is
> > the number of users, in VFIO's case, VFIO allocates the cached SendData and
> > use that to enqueue, right after enqueue it'll get a free one by switching
> > it with another one in the multifd's array[N].  Same to RAM.  Then there'll
> > be N+2 SendData and VFIO/RAM needs to free their own SendData when cleanup
> > (multifd owns the N per-thread only).
> >
> 
> At first sight, that seems to work. It's similar to this series, but
> you're moving the free slots back into the channels. Should I keep
> SendData as an actual separate array instead of multiple p->data?

I don't know.. they look similar to me yet so far, as long as multifd is
managing the N buffers, while the clients will manage one for each.  There
should have a helper to allocate/free the generic multifd buffers (SendData
in this case) so everyone should be using that.

> 
> Let me know, I'll write some code and see what it looks like.

I think Maciej is working on this too since your absence, as I saw he
decided to base his work on top of yours and he's preparing the new
version. I hope you two won't conflict or duplicates the work.  Might be
good to ask / wait and see how far Maciej has been going.

-- 
Peter Xu


