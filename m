Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83069CA5FAC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 16:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viEpE-0006ZX-LY; Tue, 20 Jan 2026 11:43:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viEpA-0006Y5-8Q
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 11:43:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viEp6-0004me-Rk
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 11:43:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768927400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cSeAFi29cpBZYNLRSw5+gQtBlJpaEAb7RcNvZPlwgMw=;
 b=iDkgyrcMAm+kFFgXFzOTUlZdBxNnoXiJpTzjjjK4zQjfa+GPRcKzntfavr2BQWy1FzLmmh
 vHbS9HGML9UMIq6qI3zHT0SfmPNuHYCNYSDdJOQhZnP8O2cK2JIaf8KinyfJfXjjFOF1yc
 NoAkkkGlEtMQqpgFC1UZCry2oCgrGdM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-oE-a1lIeP3eN1RGpkjth5A-1; Tue, 20 Jan 2026 11:43:17 -0500
X-MC-Unique: oE-a1lIeP3eN1RGpkjth5A-1
X-Mimecast-MFC-AGG-ID: oE-a1lIeP3eN1RGpkjth5A_1768927397
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8bc4493d315so1497489885a.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 08:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768927397; x=1769532197; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cSeAFi29cpBZYNLRSw5+gQtBlJpaEAb7RcNvZPlwgMw=;
 b=dGufmFjOhNVIuHaRhMyahe382P21p2qfzbHNoMttrfh2x4YehDdqju51YVLc9oIaQ/
 IcAbEOZAGyyXd+nBe27tmXcs2cMnuKm2wL2ORYsGQW0cptdl/j0tA7tfxgymg8t+2IRI
 UZebRXPTPCjmAHOhobP9H+ORhNMskWBBvHcWdH9LHyptcoDIqlJaAe/1IFZw1Mymikli
 CX09UMaJELZ3MzFHStrXC7zIKQOWrEdKywFO0ev83A8wYsFPfLumzOawiQtdO9+I9nGk
 Kt/j0I03dBaldRmw+GZjN9tgHOjBm+/vzng5Qi5qbjHswLtrVhrd+d2XkIte2p+BjpU0
 3/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768927397; x=1769532197;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cSeAFi29cpBZYNLRSw5+gQtBlJpaEAb7RcNvZPlwgMw=;
 b=BGZK0dnsn8bfMFPWF50KS7AMae6XwH6AfYWpT2LUeh9BrT02lQqNCsNVm8IKRwlYAz
 fFw94wEkIYfZiJlUCmpLJJYHDyeAl5ccAak9sPsPFJvIIWWrhn45jc+QNK0Lc05H5rl5
 BqwFYesP3aTTdct9QAXKn6yA398r3xe52+qgE8KKcWqqF8ncRcJis55GohvXiHpqLeja
 glihAX0MIGzqUYuWafOdVJW+shw3yqoUOxc1Z/SNXRR6bE1Gr37sx9pfIhVFWL7MQ6CI
 xW/AwQybnZNNdxcEWsBvI1kgXOrZhXMGk9mGl6T07rWByIAY+7eztpJblafHJrAGWQLc
 Oa5A==
X-Gm-Message-State: AOJu0Yw6LrrIonXgsV/OKUOJhyd8N3RuxeDdhFppo1+4MpiTIT64Lr0I
 pBtm427wYy2IrGmy6ywhE7vAnXKe85VFhywmyyUcCb3ix9a83NU0n/ZVe3KK45XOXNxU7JKx6j5
 ZQ+iqOdYFITk9FTdENWH7BCylOkDN0pJR/yStijfLfW8KI2KZEkdK71Xg
X-Gm-Gg: AY/fxX4nRNpftd/Xxc3ARtTQ843hgQJCAtpBGDs0XPbyL0TjCEehylLBaZzrGFDYvAv
 m3LiZxpD2OEmolgJ7tCQygNQucALV2MR1/4mpscQbwgUXhCCwQYLYXNFj7a1PK75pmOuEoYeXT1
 CIpm3PvkYbYp+3FhZJyX+D/CbkQNh0o2Vq3YODR3YzJ6DOZpjzIheHgeS+m1B+ks5s6Q8KAP51Z
 H6oixVE0ota3dzDgT7pS0Xg14A5c3lzxPjHE4Esy74exWIUyGJ88vdTYBchPFFpT3bpIywBdYE0
 2o1gIndDVYmT6S2XbqkmkhW7DxTlMfJCcVkSbTBVzUxgrb2u7DDmrhZd8F3uRbyOiAdW3K6gqvA
 ssi4=
X-Received: by 2002:a05:620a:4407:b0:8c5:31d9:2c3 with SMTP id
 af79cd13be357-8c6a6949c27mr2087010085a.75.1768927397168; 
 Tue, 20 Jan 2026 08:43:17 -0800 (PST)
X-Received: by 2002:a05:620a:4407:b0:8c5:31d9:2c3 with SMTP id
 af79cd13be357-8c6a6949c27mr2087005085a.75.1768927396664; 
 Tue, 20 Jan 2026 08:43:16 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6a724a484sm1032075485a.33.2026.01.20.08.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 08:43:16 -0800 (PST)
Date: Tue, 20 Jan 2026 11:43:14 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Prasad Pandit <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 00/13] migration: Threadify loadvm process
Message-ID: <aW-wooIYLCU52gtK@x1.local>
References: <20251022192612.2737648-1-peterx@redhat.com>
 <20260117150037.605c9744@penguin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260117150037.605c9744@penguin>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, Jan 17, 2026 at 03:00:37PM +0100, Lukas Straub wrote:
> On Wed, 22 Oct 2025 15:25:59 -0400
> Peter Xu <peterx@redhat.com> wrote:
> 
> > This is v1, however not 10.2 material.  The earliest I see fit would still
> > be 11.0+ even if everything goes extremely smooth.
> > 
> > Removal of RFC is only about that I'm more confident this should be able to
> > land without breaking something too easily, as I smoked it slightly more
> > cross-archs this time.  AFAIU the best (and possibly only..) way to prove
> > it solid is to merge it.. likely in the early phase of a dev cycle.
> > 
> > The plan is we'll try to get to more device setups too soon, before it
> > could land.
> > 
> > Background
> > ==========
> > 
> > Nowadays, live migration heavily depends on threads. For example, most of
> > the major features that will be used nowadays in live migration (multifd,
> > postcopy, mapped-ram, vfio, etc.) all work with threads internally.
> > 
> > But still, from time to time, we'll see some coroutines floating around the
> > migration context.  The major one is precopy's loadvm, which is internally
> > a coroutine.  It is still a critical path that any live migration depends on.
> > 
> > A mixture of using both coroutines and threads is prone to issues.  Some
> > examples can refer to commit e65cec5e5d ("migration/ram: Yield periodically
> > to the main loop") or commit 7afbdada7e ("migration/postcopy: ensure
> > preempt channel is ready before loading states").
> > 
> > It was a coroutine since this work (thanks to Fabiano, the archeologist,
> > digging the link):
> > 
> >   https://lists.gnu.org/archive/html/qemu-devel/2012-08/msg01136.html
> > 
> > [...]
> >
> > Tests
> > =====
> > 
> > Default CI passes.
> > 
> > RDMA unit tests pass as usual. I also tried out cancellation / failure
> > tests over RDMA channels, making sure nothing is stuck.
> > 
> > I also roughly measured how long it takes to run the whole 80+ migration
> > qtest suite, and see no measurable difference before / after this series.
> > 
> > I didn't test COLO, I wanted to but the doc example didn't work.
> > 
> > Risks
> > =====
> > 
> > This series has the risk of breaking things.  I would be surprised if it
> > didn't..
> > 
> > The current way of taking BQL during FULL section load may cause issues, it
> > means when the IOs are unstable we could be waiting for IO (in the new
> > migration incoming thread) with BQL held.  This is low possibility, though,
> > only happens when the network halts during flushing the device states.
> > However still possible.  One solution is to further breakdown the BQL
> > critical sections to smaller sections, as mentioned in TODO.
> > 
> > Anything more than welcomed: suggestions, questions, objections, tests..
> > 
> > TODO
> > ====
> > 
> > - Finer grained BQL breakdown
> > 
> > Peter Xu (13):
> >   io: Add qio_channel_wait_cond() helper
> >   migration: Properly wait on G_IO_IN when peeking messages
> >   migration/rdma: Fix wrong context in qio_channel_rdma_shutdown()
> >   migration/rdma: Allow qemu_rdma_wait_comp_channel work with thread
> >   migration/rdma: Change io_create_watch() to return immediately
> >   migration: Introduce WITH_BQL_HELD() / WITH_BQL_RELEASED()
> >   migration: Pass in bql_held information from qemu_loadvm_state()
> >   migration: Thread-ify precopy vmstate load process
> >   migration/rdma: Remove coroutine path in qemu_rdma_wait_comp_channel
> >   migration/postcopy: Remove workaround on wait preempt channel
> >   migration/ram: Remove workaround on ram yield during load
> >   migration: Allow blocking mode for incoming live migration
> >   migration/vfio: Drop BQL dependency for loadvm SWITCHOVER_START
> > 
> >  include/io/channel.h        |  15 +++
> >  include/migration/colo.h    |   6 +-
> >  migration/migration.h       | 109 +++++++++++++++++--
> >  migration/savevm.h          |   4 +-
> >  hw/vfio/migration-multifd.c |   3 -
> >  io/channel.c                |  21 ++--
> >  migration/channel.c         |   7 +-
> >  migration/colo-stubs.c      |   2 +-
> >  migration/colo.c            |  26 ++---
> >  migration/migration.c       |  81 ++++++++------
> >  migration/qemu-file.c       |   6 +-
> >  migration/ram.c             |  13 +--
> >  migration/rdma.c            | 204 ++++++++----------------------------
> >  migration/savevm.c          |  98 +++++++++--------
> >  migration/trace-events      |   4 +-
> >  15 files changed, 291 insertions(+), 308 deletions(-)
> > 
> 
> Works well in my COLO testing. Fro the whole series:
> 
> Tested-by: Lukas Straub <lukasstraub2@web.de>

Thanks for the testing.

Instead of applying it all over, the major change on COLO is patch 8, I'll
move the tag over if no objections.

-- 
Peter Xu


