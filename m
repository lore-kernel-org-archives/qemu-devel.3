Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7829CCA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 20:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBe19-00033r-HY; Tue, 29 Sep 2026 16:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBe0k-00033H-2p
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 16:01:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBe0d-0001eJ-Lt
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 16:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790712061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4/BxsEADs1CrhJltdN32yBsGJrUbEJT2Apgfkgmxyt8=;
 b=G7Do90vi92au5OtzvFj90bdx0stCYCEQ0jPNNfdlalajgPs98AqgCvGjUAZSZTuCM8KZuh
 hFBtiCgoLK6YzqO0qH1mhynebLzd5QnQk3drvz4fsNitqrE85BpM2Z5cpU7SlIjJL/bl8y
 Sli1DLLqAHQ5ilWfZ222UcZPeS2+dfI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-eS7TTfZ2Ntm8DZRzM8NJqQ-1; Tue, 29 Sep 2026 16:00:59 -0400
X-MC-Unique: eS7TTfZ2Ntm8DZRzM8NJqQ-1
X-Mimecast-MFC-AGG-ID: eS7TTfZ2Ntm8DZRzM8NJqQ_1790712059
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93a0b66ecd9so707269185a.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 13:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790712059; x=1791316859; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4/BxsEADs1CrhJltdN32yBsGJrUbEJT2Apgfkgmxyt8=;
 b=sS8yXJYHHlDz+wFoN/zozO6xQVbEVsBCmqaOyuyDIuGMGlcF8xp4hTL+5MNDRJZLWj
 5SAG3YDq2SJBjZv4kXdRf4doNuz80AiIVibeP/51TIhkujjD7l2IBM9G2T+R5uctW924
 wHOdfefxL6m6nhjdZc8FxAmw9Jprct8aciFMexIgU/V2xzme7ub6LB+qz8fiGX6+2GOu
 IFTgKf8myvmaVYM6PA/GwyUTlza4lJ2rbKj2DVKJvjcT2kIwBlv40FCUUcBT/1lYNq6J
 18lBwpNg7OhIzqa7T03Z/e7iJ9Kc7UnKvEBbPkllxXN6yOmYYlLz0flvAh18fmkWBM5B
 rG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790712059; x=1791316859;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4/BxsEADs1CrhJltdN32yBsGJrUbEJT2Apgfkgmxyt8=;
 b=neMjAX8pWHYZQctvqB3Z5M7RPlPBDtzH6BXXoOU3+AH+ATHPM2Vuon5eDt8rWuT2QI
 Sh1P+iTGFAQXBHRQZSsxY0uvQokA+YUg+ICS8wtX2CCcUFxOpMNs6eo/17S2yysAi2iw
 /aRn00J9PS4cC3BHsM8Dcpbq2QJWDhwnw1ARdoJ+rlbtF9d/oQ+7YYQx8/dptgjBn7jy
 HIH8P4V2Hlcr0OltvCNT2gadQDlGkr8oJVIHg7uLTobqEhsTkqPp45sLR6JfCOv18Q8o
 gdI26UxoQZgPYfO7rmyQJdRgSIwz64+ric6Kq/Z05Q7FUJ/khGJ5XDylysAuWsqiuZCC
 0nng==
X-Gm-Message-State: AFuF++lDgvqODKNEay9vIfg81eQ3bkZoTCDPMmjjTf0SKhfrlWHjHeiv
 /P2ottvE+U2KJSmjLXrLPN0+h1GBnlRPKra9yLBvLcoT3wnsKsXZZ5wq6WnNSSxRj8emh66irI0
 km6DAxQnAJ5pmBUQifQ6BZu20BbhJGBSjbxGuCQef6JlgEonibYsJsh3vhmZRDNWcAs8=
X-Gm-Gg: AYBFou2A7kW1hF5tmK5ObqIFO2MuyOXn3Y+V5MN5ZSXG/wEpgPjpyr9+oOV3aVzrnEA
 lA3pl1fteeZdydTUh0Ld4xBzQ6h2oFjFSgxUA42Gu5+9UIXxfU65V69eD1osznYClBYqaSprDBo
 iRQ4vPDwP7CfDauC/HEY+ULYpw/Lzc3Saf5I3K6xr9/jQ8KrmzcacyLU5xdypUxU24mGd5xklXN
 eT8aBzTdyCMkpHqNeJ7q94iBhig1jknGjO3Kz4W6dlQkHiHejog9PnaaaM+LGLD1hSN6AQEAGzF
 mVz9ZKBppTdj0fKTbFLUJGjMH+R/e8NGtrbCCC4DQq54CxYwlnb0jm2QJCgUkxUJS8o1pHk=
X-Received: by 2002:a05:620a:3789:b0:93b:d79a:c469 with SMTP id
 af79cd13be357-93c9f999406mr103356385a.65.1790712057616; 
 Tue, 29 Sep 2026 13:00:57 -0700 (PDT)
X-Received: by 2002:a05:620a:3789:b0:93b:d79a:c469 with SMTP id
 af79cd13be357-93c9f999406mr103342085a.65.1790712056218; 
 Tue, 29 Sep 2026 13:00:56 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c9f462af7sm48486885a.10.2026.09.29.13.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 13:00:55 -0700 (PDT)
Date: Tue, 29 Sep 2026 16:00:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Akash Kulhalli <akulhall@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 6/7] migration: Fix incoming channel race with multifd
 and preempt_pre_7_2
Message-ID: <arwY9i2CcpenwMF9@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260916213558.587304-1-peterx@redhat.com>
 <20260916213558.587304-7-peterx@redhat.com>
 <87wlsa8gdq.fsf@suse.de>
 <arq-dDIjTbGSbT4W@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <87cxtx862v.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87cxtx862v.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Sep 28, 2026 at 05:38:16PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Sep 24, 2026 at 06:54:25PM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > PROBLEM
> >> > =======
> >> >
> >> > Migration reliably hangs with old machine types (7.2-) when these migration
> >> > capabilities are enabled: multifd, postcopy-ram, postcopy-preempt.
> >> >
> >> > Simplest reproducer :
> >> >
> >> >   $ QTEST_QEMU_MACHINE_TYPE=pc-q35-7.2 \
> >> >       QTEST_QEMU_BINARY=./qemu-system-x86_64 \
> >> >       ./tests/qtest/migration-test --full \
> >> >       -r /x86_64/migration/multifd+postcopy/preempt/plain
> >> >
> >> > Current workaround is to kill destination QEMU, cancel the migration on
> >> > source (with/without yank), disable one or more of the features, and retry.
> >> >
> >> > The hang is caused by receiving preempt channel before most of the multifd
> >> > channels, the peek buffer operation will stuck forever.
> >> >
> >> > Incoming side QEMU hang (with relevant tracepoints enabled):
> >> >
> >> >   migrate_set_state new state setup
> >> >   migration_socket_incoming_accepted
> >> >   migration_set_incoming_channel ioc=0x557d82c1caa0 ioctype=qio-channel-socket
> >> >   migration_socket_incoming_accepted
> >> >   migration_set_incoming_channel ioc=0x557d83023840 ioctype=qio-channel-socket
> >> >   multifd_recv_new_channel channel 1
> >> >   migration_socket_incoming_accepted
> >> >   migration_set_incoming_channel ioc=0x557d830c08c0 ioctype=qio-channel-socket
> >> >   multifd_recv_new_channel channel 0
> >> >   multifd_recv_thread_start 1
> >> >   migration_socket_incoming_accepted
> >> >   migration_set_incoming_channel ioc=0x557d8284a010 ioctype=qio-channel-socket
> >> >   multifd_recv_thread_start 0
> >> >   multifd_recv_unfill channel 0 packet_num 0 flags 0x1 next packet size 0
> >> >   multifd_recv_unfill channel 1 packet_num 1 flags 0x1 next packet size 0
> >> >   [dest qemu hangs here]
> >> >
> >> > Incoming side backtrace:
> >> >
> >> >   __syscall_cancel_arch
> >> >   __internal_syscall_cancel
> >> >   __syscall_cancel
> >> >   recvmsg
> >> >   qio_channel_socket_readv
> >> >   qio_channel_readv_full
> >> >   migration_channel_read_peek
> >> >   migration_channel_identify
> >> >   migration_channel_process_incoming
> >> >   socket_accept_incoming_migration
> >> >   qio_net_listener_channel_func
> >> >   qio_channel_fd_source_dispatch
> >> >   g_main_context_dispatch_unlocked.lto_priv
> >> >   g_main_context_dispatch
> >> >   glib_pollfds_poll
> >> >   os_host_main_loop_wait
> >> >   main_loop_wait
> >> >   qemu_main_loop
> >> >   qemu_default_main
> >> >   main
> >> >
> >> > This patch tries to fix it, from incoming side first.  This patch alone
> >> > should enable single-direction migration to this new QEMU.  The next patch
> >> > will propose a fix for the outgoing path, fixing new->old migrations.
> >> >
> >> > BACKGROUND
> >> > ==========
> >> >
> >> > preempt_pre_7_2 used to be a flag marking QEMU releases 7.1/7.2 only
> >> > because they have a flaw on channel establishment on preempt channel.
> >> >
> >> > Now, after we have multifd + postcopy support, new QEMU binaries can
> >> > migrate old machine types with both features enabled.  Juraj reported
> >> > constant migration hang at the very beginning for those old machine types
> >> > in our downstream systems with such setup.  Juraj found it's because of
> >> > this flag.
> >> >
> >> > QEMU source initiates channels in this order on current master when both
> >> > features enabled with postcopy-preempt mode:
> >> >
> >> >   - First, main channel connect() happens,
> >> >   - Second, postcopy_preempt_setup() invokes connect() for preempt channel,
> >> >   - Last, in migration_thread(), multifd_send_setup() invokes connect()s
> >> >     for all the multifd channels
> >> >
> >> > However on an old QEMU, it expect the channels arrive in order of
> >> > "main"->"multifd"->"preempt".  Even on a new QEMU, the destination expects
> >> > the same order of arrival on the channels when the channels are not
> >> > peekable.
> >> >
> >> > For peekable channels (non-tls sockets), this time we'll likely see preempt
> >> > channel appearing very soon, peeking at it causing main thread hang, like
> >> > mentioned in the PROBLEM section above.
> >> >
> >> > SOLUTION
> >> > ========
> >> >
> >> > One major problem of current hang is we try to peek at preempt channel,
> >> > which offers nothing at the beginning.
> >> >
> >> > Since we'll need to accept stream from old binaries, arrival of preempt
> >> > channel early is unavoidable.
> >> >
> >> > What we can do, though, is to allow concurrent monitoring of all channels
> >> > rather than one.  Meanwhile, we shouldn't peek at anything that has no
> >> > data.
> >> >
> >> > migration_channel_read_peek() almost does the wait, but it's too late.
> >> > This patch proposes to watch all channels from the start without reading at
> >> > them at all, relying on an IO watch attached.  This will make sure (1) for
> >> > preempt channel, we never read on it (watch can be gracefully disarmed when
> >> > we know it's preempt channel later) (2) since we have one IO watch for each
> >> > channel, then we can allow accept() to happen in almost any order, process
> >> > only when there's some header to read.
> >> >
> >> > To maintain these watches, a new GArray @channels_early is introduced, with
> >> > each element to be a (ioc, GSource) tuple (@MigEarlyIncomingChannel), so
> >> > that QEMU can manage all the IO watches later with it.  Here I used GSource
> >> > rather than io_tag because the GSource may or may not be attached to the
> >> > default main thread gcontext: when OOB is used, it may be the iothread
> >> > context instead.  IOW, g_source_remove() on io_tags stops working, which
> >> > only works for default main context.
> >> >
> >> > The trick this patch used is when we have the ability to wait on all
> >> > channel headers at the same time, we pick one by one from main and multifd
> >> > channels (since both of the types will contain headers dumped right at the
> >> > very beginning), leave preempt channel alone.  It means, after dest QEMU
> >> > finds all main and multifd channels, there are three possibilities:
> >> >
> >> >   - If preempt not enabled, we finished full channel establishment, done.
> >> >
> >> >   - If preempt enabled,
> >> >
> >> >     - If we have one registered IO watch with the IOC, it must be the
> >> >       preempt channel,
> >> >
> >> >     - If we have no further IO watch, wait for the next accept(), which
> >> >       must be the preempt channel.
> >> >
> >> > This will make channel establish work on incoming side even with the old
> >> > QEMU binaries.
> >> >
> >> > While working on it, I managed to refactor the peeking logic quite a bit:
> >> > we used to have a very convoluted migration_channel_identify() function,
> >> > taking care of two different cases:
> >> >
> >> > (1) when the channel is peekable (like normal socket channels),
> >> > (2) when the channel is not peekable (like TLS or file migrations).
> >> >
> >> > This patch refactored that part to make it crystal clear on how we make
> >> > decisions on which channel is which, and split the peek/identify paths.
> >> >
> >> > One example incoming migration from pc-q35-7.2 after this patch applied,
> >> > and with relevant tracepoints set (8 multifd channels, 1 preempt channel):
> >> >
> >> >   migrate_set_state new state setup
> >> >   migration_channel_process_incoming ioc=0x557dc8af4e20 ioctype=qio-channel-socket
> >> >   migration_incoming_channel_watch ioc=0x557dc8af4e20 ioctype=qio-channel-socket
> >> >   migration_channel_process_incoming ioc=0x557dc8abc5d0 ioctype=qio-channel-socket
> >> >   migration_incoming_channel_watch ioc=0x557dc8abc5d0 ioctype=qio-channel-socket
> >> >   migration_channel_process_incoming ioc=0x557dc953d680 ioctype=qio-channel-socket
> >> >   migration_incoming_channel_watch ioc=0x557dc953d680 ioctype=qio-channel-socket
> >> >   migration_set_incoming_channel ioc=0x557dc8abc5d0 ioctype=qio-channel-socket type=MULTIFD
> >> >   migration_channel_process_incoming ioc=0x557dc898a820 ioctype=qio-channel-socket
> >> >   migration_incoming_channel_watch ioc=0x557dc898a820 ioctype=qio-channel-socket
> >> >   migration_set_incoming_channel ioc=0x557dc953d680 ioctype=qio-channel-socket type=MULTIFD
> >> >   migration_channel_process_incoming ioc=0x557dc919bd70 ioctype=qio-channel-socket
> >> >   migration_incoming_channel_watch ioc=0x557dc919bd70 ioctype=qio-channel-socket
> >> >   migration_set_incoming_channel ioc=0x557dc898a820 ioctype=qio-channel-socket type=MULTIFD
> >> >   migration_channel_process_incoming ioc=0x557dc8734b20 ioctype=qio-channel-socket
> >> >   migration_incoming_channel_watch ioc=0x557dc8734b20 ioctype=qio-channel-socket
> >> >   migration_set_incoming_channel ioc=0x557dc919bd70 ioctype=qio-channel-socket type=MULTIFD
> >> >   migration_channel_process_incoming ioc=0x557dc898bdf0 ioctype=qio-channel-socket
> >> >   migration_incoming_channel_watch ioc=0x557dc898bdf0 ioctype=qio-channel-socket
> >> >   migration_set_incoming_channel ioc=0x557dc8734b20 ioctype=qio-channel-socket type=MULTIFD
> >> >   migration_channel_process_incoming ioc=0x557dc968cfd0 ioctype=qio-channel-socket
> >> >   migration_incoming_channel_watch ioc=0x557dc968cfd0 ioctype=qio-channel-socket
> >> >   migration_set_incoming_channel ioc=0x557dc898bdf0 ioctype=qio-channel-socket type=MULTIFD
> >> >   migration_channel_process_incoming ioc=0x557dc8c31810 ioctype=qio-channel-socket
> >> >   migration_incoming_channel_watch ioc=0x557dc8c31810 ioctype=qio-channel-socket
> >> >   migration_set_incoming_channel ioc=0x557dc968cfd0 ioctype=qio-channel-socket type=MULTIFD
> >> >   migration_set_incoming_channel ioc=0x557dc8c31810 ioctype=qio-channel-socket type=MULTIFD
> >> >   migration_set_incoming_channel ioc=0x557dc8af4e20 ioctype=qio-channel-socket type=MAIN
> >> >   migration_start_incoming
> >> >   migrate_set_state new state active
> >> >   migration_channel_process_incoming ioc=0x557dc8966160 ioctype=qio-channel-socket
> >> >   migration_set_incoming_channel ioc=0x557dc8966160 ioctype=qio-channel-socket type=PREEMPT
> >> >
> >> > While at it, I renamed the four channel incoming/outgoing tracepoints, make
> >> > all to follow migration_[incoming|outgoing]_channel_*().  Especially for
> >> > incoming, then we can enable migration_incoming_channel* for incoming
> >> > channel debuggings.
> >> >
> >> > FINAL NOTE ON TLS
> >> > =================
> >> >
> >> > Note that this solution isn't a magic bullet fixing everything.  TLS is not
> >> > fixable with this approach because TLS isn't peekable channel, hence the
> >> > watch won't help.
> >> >
> >> > We can have other ways to hack it to make it work, e.g. we can make TLS
> >> > channels peekable too, but I don't want to pollute the TLS iochannel only
> >> > for this: let's hope handshake will arrive soon so we can drop these code.
> >> >
> >> > For now, when TLS is involved with such old machine type (7.2-), one needs
> >> > to migrate it out with any combination of features except enabling all
> >> > four (multifd + TLS + postcopy + preempt) to a patched binary, after that,
> >> > all combinations will start working.
> >> >
> >> > BugLink: https://redhat.atlassian.net/browse/RHEL-254933
> >> > Fixes: e27418861288 ("migration: enable multifd and postcopy together")
> >> > Reported-by: Juraj Marcin <jmarcin@redhat.com>
> >> > Signed-off-by: Peter Xu <peterx@redhat.com>
> >> > ---
> >> >  migration/channel.h    |   3 +
> >> >  migration/migration.h  |  35 ++++
> >> >  migration/channel.c    | 414 +++++++++++++++++++++++++++++++++++------
> >> >  migration/migration.c  |  23 ++-
> >> >  migration/trace-events |   7 +-
> >> >  5 files changed, 421 insertions(+), 61 deletions(-)
> >> 
> >> Hi Peter, I think the code looks good, but there are some twists and
> >> turns that I think we can get rid of. I put a fixup patch [1] at the end
> >> with my suggestions and mentioned inline what I changed and why.
> >
> > Thanks, especially for covering the tests while suggesting.
> >
> > I believe I agree with many of them, I'll comment on the rest, see inline.
> >
> >> 
> >> >
> >> > diff --git a/migration/channel.h b/migration/channel.h
> >> > index 678712f291..40bd339a3e 100644
> >> > --- a/migration/channel.h
> >> > +++ b/migration/channel.h
> >> > @@ -49,4 +49,7 @@ bool migration_channel_parse_input(const char *uri,
> >> >                                     MigrationChannel **main_channelp,
> >> >                                     MigrationChannel **cpr_channelp,
> >> >                                     Error **errp);
> >> > +
> >> > +void migration_incoming_free_early_channels(MigrationIncomingState *mis);
> >> > +
> >> >  #endif
> >> > diff --git a/migration/migration.h b/migration/migration.h
> >> > index 683bc7bdd5..6f23e1805b 100644
> >> > --- a/migration/migration.h
> >> > +++ b/migration/migration.h
> >> > @@ -90,6 +90,28 @@ typedef enum {
> >> >      PREEMPT_THREAD_QUIT,
> >> >  } PreemptThreadStatus;
> >> >  
> >> > +typedef struct {
> >> > +    /*
> >> > +     * The GSource we have allocated to track G_IO_IN events for the
> >> > +     * channel.  Note: it may not be attached to the default main gcontext,
> >> > +     * for example, when in case of io watch created during an OOB
> >> > +     * migrate-recover command.
> >> > +     */
> >> > +    GSource *source;
> >> > +    /* The channel we will identify later after getting some buffers to read */
> >> > +    QIOChannel *ioc;
> >> > +} MigEarlyIncomingChannel;
> >> > +
> >> > +typedef struct {
> >> > +    GArray *channels;
> >> > +    /*
> >> > +     * In most cases, channels are only operated with BQl, but since we
> >> > +     * have OOB command support, don't assume it, just use a standalone
> >> > +     * mutex to protect any access to the channels array.
> >> > +     */
> >> > +    QemuMutex mutex;
> >> > +} MigEarlyIncomingChannels;
> >> > +
> >> >  /* State for the incoming migration */
> >> >  struct MigrationIncomingState {
> >> >      QEMUFile *from_src_file;
> >> > @@ -255,6 +277,19 @@ struct MigrationIncomingState {
> >> >  
> >> >      /* Do exit on incoming migration failure */
> >> >      bool exit_on_error;
> >> > +
> >> > +    /*
> >> > +     * Maintains all channels only at early stage.  After incoming
> >> > +     * migration started, this should be an empty array and no use anymore.
> >> > +     *
> >> > +     * TODO: we logically only need this to make new QEMU binaries work for
> >> > +     * old machines who have @preempt_pre_7_2 set on the source, but it's
> >> > +     * also good to have this early stage anyway, making sure when peek the
> >> > +     * channel there will be something in the channel.  Ideally, we should
> >> > +     * manage all migration channels in the future with proper headers,
> >> > +     * then we can drop this.
> >> > +     */
> >> > +    MigEarlyIncomingChannels channels_early;
> >> >  };
> >> >  
> >> >  MigrationIncomingState *migration_incoming_get_current(void);
> >> > diff --git a/migration/channel.c b/migration/channel.c
> >> > index b9065efd03..acb7ef5206 100644
> >> > --- a/migration/channel.c
> >> > +++ b/migration/channel.c
> >> > @@ -12,6 +12,8 @@
> >> >  
> >> >  #include "qemu/osdep.h"
> >> >  #include "qemu/cutils.h"
> >> > +#include "qemu/main-loop.h"
> >> > +#include "qemu/error-report.h"
> >> >  #include "channel.h"
> >> >  #include "exec.h"
> >> >  #include "fd.h"
> >> > @@ -146,61 +148,84 @@ bool migration_has_all_channels(void)
> >> >      return true;
> >> >  }
> >> >  
> >> > -static MigChannelType migration_channel_identify(MigrationIncomingState *mis,
> >> > -                                                 QIOChannel *ioc, Error **errp)
> >> > +static bool qio_channel_is_peekable(QIOChannel *ioc)
> >> > +{
> >> > +    return qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK);
> >> > +}
> >> > +
> >> > +/*
> >> > + * With multiple channels, it is possible that we receive channels out of
> >> > + * order on destination side, causing incorrect mapping of source channels
> >> > + * on destination side.
> >> > + *
> >> > + * When the channel is peekable (e.g. non-TLS socket channels), check
> >> > + * channel MAGIC to decide type of channel.
> >> > + *
> >> > + * Please note this is best effort, postcopy preempt channel does not send
> >> > + * any magic number so avoid it for postcopy live migration.
> >> > + *
> >> > + * Returns: >0 if success, ==0 (CH_NONE) if error.  If error happened,
> >> > + * *errp must be set.
> >> > + */
> >> > +static MigChannelType migration_channel_peek(MigrationIncomingState *mis,
> >> > +                                             QIOChannel *ioc,
> >> > +                                             Error **errp)
> >> >  {
> >> >      MigChannelType channel = CH_NONE;
> >> >      uint32_t channel_magic = 0;
> >> >      int ret = 0;
> >> >  
> >> > -    if (!migration_has_main_and_multifd_channels()) {
> >> > -        if (qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
> >> > -            /*
> >> > -             * With multiple channels, it is possible that we receive channels
> >> > -             * out of order on destination side, causing incorrect mapping of
> >> > -             * source channels on destination side. Check channel MAGIC to
> >> > -             * decide type of channel. Please note this is best effort,
> >> > -             * postcopy preempt channel does not send any magic number so
> >> > -             * avoid it for postcopy live migration. Also tls live migration
> >> > -             * already does tls handshake while initializing main channel so
> >> > -             * with tls this issue is not possible.
> >> > -             */
> >> > -            ret = migration_channel_read_peek(ioc, (void *)&channel_magic,
> >> > -                                              sizeof(channel_magic), errp);
> >> > -            if (ret != 0) {
> >> > -                goto out;
> >> > -            }
> >> > +    assert(qio_channel_is_peekable(ioc));
> >> >  
> >> > -            channel_magic = be32_to_cpu(channel_magic);
> >> > -            if (channel_magic == QEMU_VM_FILE_MAGIC) {
> >> > -                channel = CH_MAIN;
> >> > -            } else if (channel_magic == MULTIFD_MAGIC) {
> >> > -                assert(migrate_multifd());
> >> > -                channel = CH_MULTIFD;
> >> > -            } else if (!mis->from_src_file &&
> >> > -                        mis->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
> >> > -                /* reconnect main channel for postcopy recovery */
> >> > -                channel = CH_MAIN;
> >> > -            } else {
> >> > -                error_setg(errp, "unknown channel magic: %u", channel_magic);
> >> > -            }
> >> > -        } else if (mis->from_src_file && migrate_multifd()) {
> >> > -            /*
> >> > -             * Non-peekable channels like tls/file are processed as
> >> > -             * multifd channels when multifd is enabled.
> >> > -             */
> >> > -            channel = CH_MULTIFD;
> >> > -        } else if (!mis->from_src_file) {
> >> > -            channel = CH_MAIN;
> >> > -        } else {
> >> > -            error_setg(errp, "non-peekable channel used without multifd");
> >> > -        }
> >> > +    ret = migration_channel_read_peek(ioc, (void *)&channel_magic,
> >> > +                                      sizeof(channel_magic), errp);
> >> > +    if (ret != 0) {
> >> > +        /* Failed */
> >> > +        return channel;
> >> > +    }
> >> > +
> >> > +    channel_magic = be32_to_cpu(channel_magic);
> >> > +
> >> > +    if (channel_magic == QEMU_VM_FILE_MAGIC) {
> >> > +        channel = CH_MAIN;
> >> > +    } else if (channel_magic == MULTIFD_MAGIC) {
> >> > +        assert(migrate_multifd());
> >> > +        channel = CH_MULTIFD;
> >> > +    } else if (!mis->from_src_file &&
> >> > +               mis->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
> >> > +        /* reconnect main channel for postcopy recovery */
> >> > +        channel = CH_MAIN;
> >> 
> >> This is not peeking, maybe it should be somewhere else. Not this patch's
> >> fault, we can think about it some other day.
> >
> > If we separate "peek" from "identify", this one still falls into "peek".
> >
> > Per my definition, the latter "identify" only does "pick channels by order
> > they arrive".  Then this doesn't belong to that. As it needs to "peek for
> > at least something readable", rather than blindly rely on the order of
> > arrival.
> >
> > But yeah, it'll be good we leave this for later regardless.
> >
> >> 
> >> >      } else {
> >> > +        error_setg(errp, "Unknown channel magic: %u", channel_magic);
> >> > +    }
> >> > +
> >> > +    return channel;
> >> > +}
> >> > +
> >> > +/*
> >> > + * Returns: >0 if success, ==0 (CH_NONE) if error.  If error happened,
> >> > + * *errp must be set.
> >> > + */
> >> > +static MigChannelType migration_channel_identify(MigrationIncomingState *mis,
> >> > +                                                 QIOChannel *ioc, Error **errp)
> >> > +{
> >> > +    MigChannelType channel = CH_NONE;
> >> > +
> >> > +    if (migration_has_main_and_multifd_channels()) {
> >> >          assert(migrate_postcopy_preempt());
> >> >          channel = CH_POSTCOPY;
> >> 
> >> This check is the same as the one at
> >> migration_channel_process_incoming(). I think we can simplify this.
> >
> > True, this path should be dead code when original patch applied.  I have a
> > slight preference on keeping the other one instead (which I know you tend
> > to think "awkward").  I'll explain below, and we'll see.
> >
> >> 
> >> See [1].
> >> 
> >> > +    } else if (!mis->from_src_file) {
> >> > +        channel = CH_MAIN;
> >> > +    } else if (migrate_multifd()) {
> >> > +        /*
> >> > +         * Non-peekable channels like tls/file are processed as
> >> > +         * multifd channels when multifd is enabled.
> >> > +         */
> >> > +        channel = CH_MULTIFD;
> >> > +    } else {
> >> > +        error_setg(errp, "Unexpected non-peekable channel observed");
> >> >      }
> >> >  
> >> > -out:
> >> >      return channel;
> >> >  }
> >> >  
> >> > @@ -214,31 +239,275 @@ static void migration_incoming_error_propagate(MigrationIncomingState *mis,
> >> >      }
> >> >  }
> >> >  
> >> > +/* Must be with mis->channels_early.mutex held */
> >> > +static void
> >> > +migration_incoming_early_channel_insert(MigrationIncomingState *mis,
> >> > +                                        QIOChannel *ioc,
> >> > +                                        GSource *source)
> >> > +{
> >> > +    MigEarlyIncomingChannel chan = {
> >> > +        .source = source,
> >> > +        .ioc = ioc,
> >> > +    };
> >> > +
> >> > +    object_ref(OBJECT(ioc));
> >> > +    g_source_ref(source);
> >> > +
> >> > +    g_array_append_val(mis->channels_early.channels, chan);
> >> > +}
> >> > +
> >> > +static void migration_incoming_early_channel_free(GArray *channels, int i)
> >> > +{
> >> > +    MigEarlyIncomingChannel *chan;
> >> > +
> >> > +    chan = &g_array_index(channels, MigEarlyIncomingChannel, i);
> >> > +
> >> > +    g_source_destroy(chan->source);
> >> > +    g_source_unref(chan->source);
> >> > +    object_unref(OBJECT(chan->ioc));
> >> > +
> >> > +    g_array_remove_index_fast(channels, i);
> >> > +}
> >> > +
> >> > +/*
> >> > + * Remove this channel from the monitoring of @channels_early array.
> >> > + * Return true if found and successful, false otherwise.
> >> > + */
> >> > +static bool
> >> > +migration_incoming_early_channel_remove(MigrationIncomingState *mis,
> >> > +                                        QIOChannel *ioc)
> >> > +{
> >> > +    GArray *channels = mis->channels_early.channels;
> >> > +    MigEarlyIncomingChannel *chan;
> >> > +    int i;
> >> > +
> >> > +    QEMU_LOCK_GUARD(&mis->channels_early.mutex);
> >> > +
> >> > +    for (i = 0; i < channels->len; i++) {
> >> > +        chan = &g_array_index(channels, MigEarlyIncomingChannel, i);
> >> > +        if (chan->ioc != ioc) {
> >> > +            continue;
> >> > +        }
> >> > +        migration_incoming_early_channel_free(channels, i);
> >> > +        return true;
> >> > +    }
> >> > +
> >> > +    return false;
> >> > +}
> >> > +
> >> > +void migration_incoming_free_early_channels(MigrationIncomingState *mis)
> >> > +{
> >> > +    GArray *channels = mis->channels_early.channels;
> >> > +
> >> > +    QEMU_LOCK_GUARD(&mis->channels_early.mutex);
> >> > +
> >> > +    while (channels->len) {
> >> > +        migration_incoming_early_channel_free(channels, 0);
> >> > +    }
> >> > +}
> >> > +
> >> > +static bool migration_incoming_setup_channel(QIOChannel *ioc,
> >> > +                                             MigChannelType ch,
> >> > +                                             Error **errp)
> >> > +{
> >> > +    trace_migration_incoming_channel_set(ioc,
> >> > +                                         object_get_typename(OBJECT(ioc)),
> >> > +                                         mig_channel_str[ch]);
> >> > +    migration_ioc_register_yank(ioc);
> >> > +    /* TODO: make this return the success status instead */
> >> > +    migration_incoming_setup(ioc, ch, errp);
> >> 
> >> I implemented this TODO. It allows us to skip the main+mfd check after
> >> starting migration because migration_incoming_setup() already returns
> >> that value. See [1].
> >
> > Actually now looking at this patch, this TODO is so trivial.. yes I'll do
> > it.
> >
> > But when I do it, I think it too error prone to return a value returned
> > from migration_has_main_and_multifd_channels() for this function.  I
> > changed it to simple true/false for success or not instead.  I'll attach a
> > 2nd version of the fixup patch at the end, applying most changes you
> > suggested but stick with returning true/false for this one.
> >
> >> 
> >> > +
> >> > +    return *errp == NULL;
> >> > +}
> >> > +
> >> >  static bool migration_incoming_channel_install(MigrationIncomingState *mis,
> >> >                                                 QIOChannel *ioc,
> >> >                                                 Error **errp)
> >> >  {
> >> > -    MigChannelType ch = migration_channel_identify(mis, ioc, errp);
> >> > +    MigChannelType ch;
> >> > +    bool ret;
> >> > +
> >> > +    if (qio_channel_is_peekable(ioc)) {
> >> 
> >> This check is redundant, we can only arrive here via the watch and we
> >> checked peekable already at migration_channel_process_incoming. See [1].
> >
> > Shouldn't? Because the file path uses migration_incoming_channel_install()
> > too, afaict.
> >
> > But I see how your question came, which I'm guessing: I used this function
> > in a peekable only path, so here what I can do minimum is I can move the
> > migration_channel_peek() to the peekable path, then move the other path of
> > migration_channel_identify() to the e.g. file path.  I'll do that.
> >
> >> 
> >> > +        ch = migration_channel_peek(mis, ioc, errp);
> >> > +    } else {
> >> > +        ch = migration_channel_identify(mis, ioc, errp);
> >> > +    }
> >> >  
> >> >      if (!ch) {
> >> > -        assert(*errp);
> >> >          return false;
> >> >      }
> >> >  
> >> > -    trace_migration_set_incoming_channel(ioc,
> >> > -                                         object_get_typename(OBJECT(ioc)),
> >> > -                                         mig_channel_str[ch]);
> >> > -    migration_ioc_register_yank(ioc);
> >> > +    ret = migration_incoming_setup_channel(ioc, ch, errp);
> >> > +    if (!ret) {
> >> > +        return false;
> >> > +    }
> >> >  
> >> > -    if (migration_incoming_setup(ioc, ch, errp)) {
> >> > +    /* Installation succeeded, kickoff migration if needed */
> >> > +    if (migration_has_main_and_multifd_channels()) {
> >> >          migration_start_incoming();
> >> >      }
> >> >  
> >> > -    if (*errp) {
> >> > -        return false;
> >> > +    return true;
> >> > +}
> >> > +
> >> > +static void
> >> > +migration_incoming_channel_preempt_setup(QIOChannel *ioc)
> >> > +{
> >> > +    assert(migrate_postcopy_preempt());
> >> > +    /* Installation of preempt channel should never fail */
> >> > +    migration_incoming_setup_channel(ioc, CH_POSTCOPY, &error_abort);
> >> > +}
> >> > +
> >> > +static void
> >> > +migration_incoming_detect_preempt_channel(MigrationIncomingState *mis)
> >> > +{
> >> > +    GArray *channels = mis->channels_early.channels;
> >> > +    MigEarlyIncomingChannel *chan;
> >> > +
> >> > +    QEMU_LOCK_GUARD(&mis->channels_early.mutex);
> >> > +
> >> > +    /* When preempt mode not enabled, nothing to detect.. */
> >> > +    if (!migrate_postcopy_preempt()) {
> >> > +        /*
> >> > +         * .. but if we found something pending, throw an error only, which
> >> > +         * should not happen.  Even if it happens, resources will still be
> >> > +         * released after incoming migration is completedly.
> >> > +         */
> >> > +        if (channels->len) {
> >> > +            error_report("%s: Found %u unused channels",
> >> > +                         __func__, channels->len);
> >> > +        }
> >> > +        return;
> >> >      }
> >> >  
> >> > -    return true;
> >> > +    /* Preempt channel hasn't yet arrived?  Process it later */
> >> > +    if (!channels->len) {
> >> > +        return;
> >> > +    }
> >> > +
> >> > +    /*
> >> > +     * More than one channel should never happen.. capture it in case if
> >> > +     * it happens, then there's not much we can do.
> >> > +     */
> >> > +    if (channels->len > 1) {
> >> > +        error_report("%s: Found %u unused channels, "
> >> > +                     "can't identify preempt channel",
> >> > +                     __func__, channels->len);
> >> > +        return;
> >> > +    }
> >> > +
> >> > +    assert(channels->len == 1);
> >> > +    /* This is the preempt channel, install it directly */
> >> > +    chan = &g_array_index(channels, MigEarlyIncomingChannel, 0);
> >> > +    migration_incoming_channel_preempt_setup(chan->ioc);
> >> > +    migration_incoming_early_channel_free(channels, 0);
> >> > +}
> >> > +
> >> > +static gboolean migration_incoming_channel_readable(QIOChannel *ioc,
> >> > +                                                    GIOCondition condition,
> >> > +                                                    gpointer opaque)
> >> > +{
> >> > +    MigrationIncomingState *mis = opaque;
> >> > +    Error *local_err = NULL;
> >> > +
> >> > +    /*
> >> > +     * No need to monitor this channel anymore as long as anything arrived,
> >> > +     * remove it from tracking.
> >> > +     *
> >> > +     * NOTE: this means if partial data arrived we may still block here,
> >> > +     * but it shouldn't happen in production, only malicious stream.  Since
> >> > +     * migration stream is trusted (either due to trusted network, or TLS),
> >> > +     * that's non-issue.
> >> 
> >> Could we check the amount of data and keep waiting?
> >
> > We could, but it is about the security side of things, I'd not bother in
> > this patch, and maybe we don't bother forever, hopping that at the end of
> > this year we enable handshake in next release, then this is a ioc read()
> > block reading, as simple as that.
> >
> 
> Ok, no worries.
> 
> >> 
> >> > +     *
> >> > +     * NOTE2: this will also release the ioc ref that we used to hold, but
> >> > +     * it's fine since we have at least one more refcount in the current
> >> > +     * event handler.
> >> 
> >> I don't understand "one more ref in the event handler". Looks like
> >> you're trying to say the refcount is consistent, but why even mention
> >> it? I may be missing something.
> >
> > Not about consistency, it's about holding at least one refcount to make sure
> > migration_incoming_early_channel_remove() won't already free the IOC.
> >
> > But I think maybe you're right: likely nobody will notice the context of
> > this path processing the gsource, and maybe this sentence brings more
> > confusion than clarity?  Let me know, I can drop this line.
> >
> 
> You mean the inc at qio_channel_create_fd_watch()? Then we don't need
> this comment.

Let me remove it.

> 
> >> 
> >> > +     *
> >> > +     * NOTE3: it's theoretically possible that this entry is gone reaching
> >> > +     * here. Example: the main thread is doing incoming cleanup having this
> >> > +     * one removed, while this watch can be registered on the monitor
> >> > +     * iothread's context and fired at the exact same time but in the
> >> > +     * iothread instead.  If it happens, skip the rest.  I'm not sure if
> >> > +     * this could happen at all, may depend on iothread lifespan management
> >> > +     * in the main thread, but be prepared.
> >> 
> >> I wonder if we should extend the locking a bit further. Not because of
> >> what you mentioned here^, but because everything the code running on the
> >> monitor thread touches can race with changes from the main loop. All of
> >> these migrate_foo_bar() helpers, the QEMUFiles, caps, params, etc.
> >
> > Is that about the new lock (mis->channels_early.mutex) or existing code?
> > Possible to do on top, or a new concern introduced from this patch?
> >
> 
> If we can reach migration_channel_process_incoming() via OOB command,
> then everything below it needs to be audited to ensure we're not
> changing global state concurrently. Mostly pre-existing, but you are
> adding more code inside the danger window.

Fair enough.

I'd say migration_channel_process_incoming() isn't that bad accessing
globals?  We have those (ugly..) migrate_incoming_[un]ref_outgoing_state()
managing refcount for MigrationState*, meanwhile the incoming state object
is never freed AFAIU.

OTOH, migration_channel_process_incoming() still in most cases only touches
the ioc, it shouldn't do a lot complex things.  This patch will introduce
more references to the incoming state object indeed, but only that
early_channels structure.  The hope is it is well guarded.. but I think
indeed I can still miss some spots.

> 
> >> 
> >> > +     */
> >> > +    if (!migration_incoming_early_channel_remove(mis, ioc)) {
> >> > +        goto out;
> >> > +    }
> >> > +
> >> 
> >> I moved the peek into here and passed the already identified
> >> channel into migration_incoming_channel_install(). See [1].
> >
> > Agree on this change, better.
> >
> >> 
> >> > +    if (!migration_incoming_channel_install(mis, ioc, &local_err)) {
> >> > +        goto out;
> >> > +    }
> >> > +
> >> > +    if (migration_has_main_and_multifd_channels()) {
> >> 
> >> This check became redundant because the _setup routine already returns
> >> it. See [1].
> >
> > I didn't adopt this in my new fixup, because I want to avoid returning that
> > info deep from stack.  Let's continue the discussion in my fixup there as a
> > reply.
> >
> 
> I wrote a migration_can_start() routine and tried to incorporate some
> preempt channel knowledge into it, but it didn't work so well. I find it
> a bit opaque to look only at main+mfd channels to start the
> migration. Since nothing better came up so far, I agree you keep this
> here.

Yes, it's odd, at that time only to provide the ordering.  I'll remove that
oddity when working on handshake.

> 
> >> 
> >> > +        /*
> >> > +         * Possibilities when reaching here:
> >> > +         *
> >> > +         * (1) if preempt not enabled, this should be no-op, all done,
> >> > +         * (2) if preempt enabled,
> >> > +         *   (2.a) preempt channel arrived @channels_early, handle it now
> >> > +         *   (2.b) preempt channel not arrived, to be handled in
> >> > +         *         migration_channel_process_incoming() later
> >> > +         */
> >> > +        migration_incoming_detect_preempt_channel(mis);
> >> 
> >> Moved this into migration_incoming_channel_install(). See [1].
> >
> > Since my version used migration_incoming_channel_install() for both
> > peekable and non-peekable, this path is not needed for non-peekable.
> > I still left it here, assuming it's clearer it's only needed for peekable.
> > But you can reply with your thought.  I hope at least we can be more
> > focused with most of the rest addressed.
> >
> 
> I tend to prefer having a single path and make it a noop via code than
> to have two paths and use our knowledge of the code to decide what goes
> where. Here we can't escape having two paths, so it's not a huge deal.

Thanks, yes, I believe this is more or less cosmetic difference.

What I wanted to avoid is e.g. migration_incoming_detect_preempt_channel()
not used at all in a "file:" migration, especially, what it does is it will
look up mis->channels_early.channels (no matter preempt mode enabled or
not, currently it still does a sanity check even if !preempt). In "file:"
migrations, we never use mis->channels_early.channels.  It looks a bit
weird to look it up and "fallback to noop" because of that.

> 
> >> 
> >> > +    }
> >> > +
> >> > +out:
> >> > +    if (local_err) {
> >> > +        migration_incoming_error_propagate(mis, local_err);
> >> > +    }
> >> > +
> >> > +    /*
> >> > +     * NOTE: we should have already detached the GSource, returning
> >> > +     * G_SOURCE_REMOVE to be logically consistent only.
> >> > +     */
> >> > +    return G_SOURCE_REMOVE;
> >> > +}
> >> > +
> >> > +static void migration_incoming_channel_watch(MigrationIncomingState *mis,
> >> > +                                             QIOChannel *ioc)
> >> > +{
> >> > +    GMainContext *context = g_main_context_get_thread_default();
> >> > +    GSource *source;
> >> > +    guint io_tag;
> >> > +
> >> > +    trace_migration_incoming_channel_watch(ioc,
> >> > +                                           object_get_typename(OBJECT(ioc)));
> >> > +
> >> > +    /*
> >> > +     * Careful: this can be run from either the main thread or the monitor
> >> > +     * iothread when migrate_recover is used with OOB=on, so we need to
> >> > +     * take the lock and use the full version to specify the correct
> >> > +     * context.
> >> > +     */
> >> > +    QEMU_LOCK_GUARD(&mis->channels_early.mutex);
> >> > +
> >> > +    /*
> >> > +     * We should never watch an @ioc that is not peekable, because there's
> >> > +     * no point.  What is worse is we lose the real order of accept()s via
> >> > +     * the asynchronous IO watch operation.
> >> > +     *
> >> > +     * Another note is TLS channel (non-peekable) may or may not work
> >> > +     * properly with IO watch due to its current .io_create_watch() impl,
> >> > +     * which is another story.  Just guard both points.
> >> > +     */
> >> > +    assert(qio_channel_is_peekable(ioc));
> >> > +    io_tag = qio_channel_add_watch_full(ioc, G_IO_IN,
> >> > +                                        migration_incoming_channel_readable,
> >> > +                                        mis, NULL, context);
> >> > +
> >> > +    /*
> >> > +     * Replace this if one day qio_channel_add_watch*() API can directly
> >> > +     * return the GSource*.. for now, stick with it.
> >> > +     */
> >> > +    source = g_main_context_find_source_by_id(context, io_tag);
> >> > +    /*
> >> > +     * Nothing can race with adding the IO watch, aka, concurrent removal
> >> > +     * is not possible when we have the lock.  So it must be present.
> >> > +     */
> >> > +    assert(source);
> >> > +
> >> > +    migration_incoming_early_channel_insert(mis, ioc, source);
> >> >  }
> >> >  
> >> >  /**
> >> > @@ -254,13 +523,44 @@ void migration_channel_process_incoming(QIOChannel *ioc)
> >> >      MigrationIncomingState *mis = migration_incoming_get_current();
> >> >      Error *local_err = NULL;
> >> >  
> >> > -    trace_migration_channel_process_incoming(
> >> > +    trace_migration_incoming_channel_process(
> >> >          ioc, object_get_typename(OBJECT(ioc)));
> >> >  
> >> >      if (migrate_channel_requires_tls_upgrade(ioc)) {
> >> >          migration_tls_channel_process_incoming(ioc, &local_err);
> >> >      } else {
> >> > -        migration_incoming_channel_install(mis, ioc, &local_err);
> >> > +        if (migration_has_main_and_multifd_channels()) {
> >> 
> >> The fact that this check must come before everything is a major
> >> weirdness. In fact, this is conceptually the same case as the first
> >> branch in migration_channel_identify(). I therefore moved that function
> >> to this point and added a comment explaining why this must come
> >> first. See [1].
> >
> > This is one part that I left alone so far.  My reason is that preempt
> > channel needs special care at least for peekable, it's because it's not
> > peekable there when hitting this case.  So we need to have this separate
> > path.  This is also relevant to below, where..
> >
> 
> You removed the check from _identify, so it's less confusing now.
> 
> >> 
> >> > +            /*
> >> > +             * If all main+multifd channels are present already, this must
> >> > +             * be the preempt channel.
> >> > +             *
> >> > +             * QEMU can't register an IO watch for it if there is only the
> >> > +             * last preempt channel left, because it means the IO watch
> >> > +             * will never fire and nobody will pick it up: we rely on the
> >> > +             * one before the last one to pick both.
> >> > +             *
> >> > +             * See comment in migration_incoming_channel_readable() on
> >> > +             * the migration_incoming_detect_preempt_channel() call.
> >> > +             */
> >> > +            migration_incoming_channel_preempt_setup(ioc);
> >> > +        } else {
> >> > +            /*
> >> > +             * Register an IO watch for peekable channels, so that channels
> >> > +             * can be accept()ed with any order.
> >> > +             *
> >> > +             * Non-peekable channels (file, TLS, etc.) cannot register IO
> >> > +             * watch, not only because there's no data to look at to help
> >> > +             * making the decision, but also because after registering we
> >> > +             * will lose the real ordering we get from accept(), which is
> >> > +             * still so far the only source of truth to identify a channel
> >> > +             * in such case.
> >> > +             */
> >> > +            if (qio_channel_is_peekable(ioc)) {
> >> 
> >> I moved this line into migration_channel_identify(). That way we ensure
> >> the ordering regarding the main+mfd check. The watch is still installed
> >> at this point. See [1].
> >
> > ... you suggested moving this into migration_channel_identify().
> >
> > Personally I think it's against my purpose of split: I wanted to make
> > migration_channel_identify() to only rely on order of arrival to identify
> > channels, nothing else.  Then for all peekable handling, it should be
> > inside the _peek() function.
> >
> 
> ok
> 
> >> 
> >> > +                migration_incoming_channel_watch(mis, ioc);
> >> > +            } else {
> >> > +                migration_incoming_channel_install(mis, ioc, &local_err);
> >> 
> >> This invocation of install does not check for the preempt channel after
> >> it returns. Is this simply assuming that if a non-peekable channel is
> >> present then there will be no preempt channel at all?
> >> 
> >> Or if main+TLS is the first channel, then the next channel will be
> >> preempt and already enter the first branch?
> >
> > Yes.  It's because for non-peekable, preempt channel is only processed
> > above (in my patch logic, with/without my new fixup to be attached).
> >
> > For peekable, preempt channel may be picked up by the 2nd last channel,
> > which is not possible for non-peekable, so that is special way for peekable
> > channels only.
> >
> >> 
> >> > +            }
> >> > +        }
> >> >      }
> >> >  
> >> >      if (local_err) {
> >> > @@ -270,7 +570,7 @@ void migration_channel_process_incoming(QIOChannel *ioc)
> >> >  
> >> >  void migration_channel_connect_outgoing(MigrationState *s, QIOChannel *ioc)
> >> >  {
> >> > -    trace_migration_set_outgoing_channel(ioc, object_get_typename(OBJECT(ioc)));
> >> > +    trace_migration_outgoing_channel_set(ioc, object_get_typename(OBJECT(ioc)));
> >> >  
> >> >      if (migrate_channel_requires_tls_upgrade(ioc)) {
> >> >          Error *local_err = NULL;
> >> > diff --git a/migration/migration.c b/migration/migration.c
> >> > index cfadcc79c2..4cc4077a76 100644
> >> > --- a/migration/migration.c
> >> > +++ b/migration/migration.c
> >> > @@ -334,6 +334,10 @@ void migration_object_init(void)
> >> >      current_incoming->page_requested = g_tree_new(page_request_addr_cmp);
> >> >  
> >> >      current_incoming->exit_on_error = INMIGRATE_DEFAULT_EXIT_ON_ERROR;
> >> > +    /* zero_terminated=false, clear_=true */
> >> 
> >> There's an extra _ after 'clear' I think.
> >
> > See?  I know someone else will get confused too. :)
> >
> 
> hahaha crap. Put a +1 next to that comment and let's increment it every
> time someone mentions this.

Be prepared reviewing more migration patches, just to bump it. :)

To avoid it from happening, I did this instead:

    /* zero_terminated=false, clear_=true (NOTE, "clear_" is not a typo) */

> 
> > https://docs.gtk.org/glib/type_func.Array.new.html
> >
> >     GArray*
> >     g_array_new (
> >         gboolean zero_terminated,
> >         gboolean clear_,
> >         guint element_size
> >     )
> >
> >     ...
> >
> >     clear_
> >     Type: gboolean
> >
> >     If true, GArray elements should be automatically cleared to 0 when they are allocated.
> >
> >> 
> >> > +    current_incoming->channels_early.channels =
> >> > +        g_array_new(FALSE, TRUE, sizeof(MigEarlyIncomingChannel));
> >> > +    qemu_mutex_init(&current_incoming->channels_early.mutex);
> >> >  
> >> >      migration_object_check(current_migration, &error_fatal);
> >> >  
> >> > @@ -447,6 +451,24 @@ void migration_incoming_state_destroy(void)
> >> >      MigrationIncomingState *mis = migration_incoming_get_current();
> >> >      PostcopyState ps = postcopy_state_get();
> >> >  
> >> > +    /* Cleanup listener to make sure no further accept() for sockets */
> >> > +    migration_incoming_transport_cleanup(mis);
> >> > +
> >> > +    /*
> >> > +     * It's safer to free channel watches earlier than most of the rest, in
> >> > +     * case the IO watches could fire in the monitor iothread concurrently
> >> > +     * against this function.
> >> 
> >> Now I'm getting worried. Cleanup races are super annoying. This is
> >> "just" about the recovery command, right?
> >
> > I think so.
> >
> > Note: I didn't have any way to trigger any crash at all, this is something
> > when I had AI review my code and it pointed out this.  I thought I should
> > be safe than sorry.
> >
> 
> It will happen in CI one day when we least expect it, don't worry. =)
> 
> It's fine, I don't think it's good use of our time to overthink this at
> the moment.

I agree.

> 
> > Below is my fixup.  The hope is I addressed most of them but not all, with
> > reasonings inline above.  Let me know.
> >
> >
> > ===8<===
> > From eb03b1b648b91a317a8a7559240186c87d835b8c Mon Sep 17 00:00:00 2001
> > From: Peter Xu <peterx@redhat.com>
> > Date: Mon, 28 Sep 2026 11:35:20 -0400
> > Subject: [PATCH] fixup! migration: Fix incoming channel race with multifd and
> >  preempt_pre_7_2
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/channel.c   | 42 +++++++++++++++++-------------------------
> >  migration/migration.c |  9 +++------
> >  2 files changed, 20 insertions(+), 31 deletions(-)
> >
> > diff --git a/migration/channel.c b/migration/channel.c
> > index acb7ef5206..72de9c9778 100644
> > --- a/migration/channel.c
> > +++ b/migration/channel.c
> > @@ -204,17 +204,14 @@ static MigChannelType migration_channel_peek(MigrationIncomingState *mis,
> >  
> >  /*
> >   * Returns: >0 if success, ==0 (CH_NONE) if error.  If error happened,
> > - * *errp must be set.
> > + * *errp must be set.  NOTE: preempt channel is done separately.
> >   */
> >  static MigChannelType migration_channel_identify(MigrationIncomingState *mis,
> >                                                   QIOChannel *ioc, Error **errp)
> >  {
> >      MigChannelType channel = CH_NONE;
> >  
> > -    if (migration_has_main_and_multifd_channels()) {
> > -        assert(migrate_postcopy_preempt());
> > -        channel = CH_POSTCOPY;
> 
> Fair.
> 
> > -    } else if (!mis->from_src_file) {
> > +    if (!mis->from_src_file) {
> >          channel = CH_MAIN;
> >      } else if (migrate_multifd()) {
> >          /*
> > @@ -314,31 +311,16 @@ static bool migration_incoming_setup_channel(QIOChannel *ioc,
> >                                           object_get_typename(OBJECT(ioc)),
> >                                           mig_channel_str[ch]);
> >      migration_ioc_register_yank(ioc);
> > -    /* TODO: make this return the success status instead */
> > -    migration_incoming_setup(ioc, ch, errp);
> >  
> > -    return *errp == NULL;
> > +    return migration_incoming_setup(ioc, ch, errp);
> >  }
> >  
> >  static bool migration_incoming_channel_install(MigrationIncomingState *mis,
> >                                                 QIOChannel *ioc,
> > +                                               MigChannelType ch,
> >                                                 Error **errp)
> >  {
> > -    MigChannelType ch;
> > -    bool ret;
> > -
> > -    if (qio_channel_is_peekable(ioc)) {
> > -        ch = migration_channel_peek(mis, ioc, errp);
> > -    } else {
> > -        ch = migration_channel_identify(mis, ioc, errp);
> > -    }
> > -
> > -    if (!ch) {
> > -        return false;
> > -    }
> > -
> > -    ret = migration_incoming_setup_channel(ioc, ch, errp);
> > -    if (!ret) {
> > +    if (!migration_incoming_setup_channel(ioc, ch, errp)) {
> >          return false;
> >      }
> >  
> > @@ -409,6 +391,7 @@ static gboolean migration_incoming_channel_readable(QIOChannel *ioc,
> >  {
> >      MigrationIncomingState *mis = opaque;
> >      Error *local_err = NULL;
> > +    MigChannelType ch;
> >  
> >      /*
> >       * No need to monitor this channel anymore as long as anything arrived,
> > @@ -435,7 +418,12 @@ static gboolean migration_incoming_channel_readable(QIOChannel *ioc,
> >          goto out;
> >      }
> >  
> > -    if (!migration_incoming_channel_install(mis, ioc, &local_err)) {
> > +    ch = migration_channel_peek(mis, ioc, &local_err);
> > +    if (!ch) {
> > +        goto out;
> > +    }
> > +
> > +    if (!migration_incoming_channel_install(mis, ioc, ch, &local_err)) {
> >          goto out;
> >      }
> >  
> > @@ -522,6 +510,7 @@ void migration_channel_process_incoming(QIOChannel *ioc)
> >  {
> >      MigrationIncomingState *mis = migration_incoming_get_current();
> >      Error *local_err = NULL;
> > +    MigChannelType ch;
> >  
> >      trace_migration_incoming_channel_process(
> >          ioc, object_get_typename(OBJECT(ioc)));
> > @@ -558,7 +547,10 @@ void migration_channel_process_incoming(QIOChannel *ioc)
> >              if (qio_channel_is_peekable(ioc)) {
> >                  migration_incoming_channel_watch(mis, ioc);
> 
> Please carry my "async" comment if possible. It helps when navigating
> the code because there's a migration_incoming_channel_install() just
> below so we can jump to it without having to read
> migration_incoming_channel_watch() definition.

This I can do.  Since I had a verbose comment above this (now I tend to
think it's a bit wordy..), I did this change instead taking your
suggestion into account, I hope it looks better:

diff --git a/migration/channel.c b/migration/channel.c
index 8c2b0e6c39..5fdc8a17cf 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -529,20 +529,22 @@ void migration_channel_process_incoming(QIOChannel *ioc)
              */
             migration_incoming_channel_preempt_setup(ioc);
         } else {
-            /*
-             * Register an IO watch for peekable channels, so that channels
-             * can be accept()ed with any order.
-             *
-             * Non-peekable channels (file, TLS, etc.) cannot register IO
-             * watch, not only because there's no data to look at to help
-             * making the decision, but also because after registering we
-             * will lose the real ordering we get from accept(), which is
-             * still so far the only source of truth to identify a channel
-             * in such case.
-             */
             if (qio_channel_is_peekable(ioc)) {
+                /*
+                 * Register an IO watch for the peekable channel, deciding
+                 * the type of channel later by peeking at it whenever
+                 * possible.  migration_incoming_channel_install() will be
+                 * postponed.
+                 */
                 migration_incoming_channel_watch(mis, ioc);
             } else {
+                /*
+                 * Non-peekable channels (file, TLS, etc.), cannot register
+                 * IO watch because (1) there's nothing to peek, (2) after
+                 * registering IO watch, QEMU will lose the real ordering
+                 * it gets from accept(), which is still so far the only
+                 * source of truth to identify a channel in this case.
+                 */
                 ch = migration_channel_identify(mis, ioc, &local_err);
                 if (ch) {
                     migration_incoming_channel_install(mis, ioc, ch, &local_err);

> 
> >              } else {
> > -                migration_incoming_channel_install(mis, ioc, &local_err);
> > +                ch = migration_channel_identify(mis, ioc, &local_err);
> > +                if (ch) {
> > +                    migration_incoming_channel_install(mis, ioc, ch, &local_err);
> > +                }
> >              }
> >          }
> >      }
> > diff --git a/migration/migration.c b/migration/migration.c
> > index adba154e46..242b8ed812 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -854,10 +854,7 @@ out:
> >      migrate_incoming_unref_outgoing_state();
> >  }
> >  
> > -/*
> > - * Returns whether all the necessary channels to proceed with the
> > - * incoming migration have been established without error.
> > - */
> > +/* Return true if success, false otherwise (with *errp set) */
> 
> Probably not needed, this is the expected way.

Yep, I put it there only because it may make review easier when it's not a
new function but retval changed, but let me drop it then.

> 
> >  bool migration_incoming_setup(QIOChannel *ioc, uint8_t channel, Error **errp)
> >  {
> >      MigrationIncomingState *mis = migration_incoming_get_current();
> > @@ -886,13 +883,13 @@ bool migration_incoming_setup(QIOChannel *ioc, uint8_t channel, Error **errp)
> >          assert(!mis->postcopy_qemufile_dst);
> >          f = qemu_file_new_input(ioc);
> >          postcopy_preempt_new_channel(mis, f);
> > -        return false;
> > +        break;
> 
> I see. Maybe a separate preliminary patch for this change?

Let me try, not guaranteed though, because IIUC it can be ugly: we used to
rely on migration_has_main_and_multifd_channels() to be returned, then I'll
need to explicitly add it in callers.

> 
> >  
> >      default:
> >          g_assert_not_reached();
> >      }
> >  
> > -    return migration_has_main_and_multifd_channels();
> > +    return true;
> >  }
> >  
> >  void migration_outgoing_setup(QIOChannel *ioc)
> > -- 
> > 2.55.0
> 

-- 
Peter Xu


