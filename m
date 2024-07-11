Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCEACC3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 22:07:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS1wO-0002H9-Cy; Thu, 11 Jul 2024 18:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sS1wM-00029n-L5
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 18:07:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sS1wJ-0001zr-M5
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 18:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720735617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nQWxzVUjjz5+YAqJFKhEfdQBBNRvSt7+NLlawdSmQrE=;
 b=hQfqTQ1H5DiJcjqRd2/faWZL03nKn3NLf+Hf7IVUNOCIlPbj/5CxAJ5dQa3TocNKRGzKHY
 BjtthFSb8U2Ryq/Qf4mzsm3JG3ekKMA4vglbg2jjaMJXWhJWfpKxaD4UUbmhs2PxcuXQLL
 Qs++dspVfjHfWNAJcffv0KJvZ8FgAKc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-6TYdShXjNJyGARQIyPCoZg-1; Thu, 11 Jul 2024 18:06:55 -0400
X-MC-Unique: 6TYdShXjNJyGARQIyPCoZg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-447dfad3387so3319731cf.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 15:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720735614; x=1721340414;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nQWxzVUjjz5+YAqJFKhEfdQBBNRvSt7+NLlawdSmQrE=;
 b=e0pCsfK5yMmeYA8spBpJ2LSZCd1ou3bHGKZFRYotN3PaMuG6+G+tBuLS0BLdNi7d1t
 P6yGHJR5BYvsijUmmxekkY3+IwVixEMv4a2VoKBRxGYS829a4YNRnhZ7MOM10Whf2UxW
 WlBjtDul3n4LbIXb/FP4zYVTjywK7s+qZPuW9wSNn0ldRK/HZlHnEuqpBncyF8NoGmVq
 JhzKWEZKaD3W0++jwDK1I9HOfPG5dKIA2OhGYKWFIxNRN2fYsFdi4oTV+7RmJi25i4x+
 qt8iwpFAkXtkJpBYuFB6tbNoIl/5iOjmivRGjP/s4Lg2dfik6siqqsn4NxzT4nKEQ/dr
 a2TA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhpArmEd+vE0xJyNIE1hfo4DbZrzKtJXxYgzLbLDyhMoqB186r4SMicXXOzjEoUKED+PLYPaA5ghkW0xZtXlxvrdnNf2U=
X-Gm-Message-State: AOJu0Yz4YHAwSpa6W9ledpMFSgoYmbxRmZMOBBDypZ/BrVwCCKnKh1QA
 hWgXwxe1t6nZWtHFo8Z0pgj0gG+PHGa376SBrdd0L2e/Mz86GAqo2PFKukaWPC2hTG1qhTW7zQj
 fuvYV9dIo0dTTU+zAFkac0LJwoaufPSrG8UDVts366280McN04YCX
X-Received: by 2002:a05:6214:1cc2:b0:6b5:6a3:7e4 with SMTP id
 6a1803df08f44-6b61c3d733cmr102992996d6.6.1720735614476; 
 Thu, 11 Jul 2024 15:06:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwjsxLIBlnU9dhwM7i/ZUeswFNJTdVj1PRZd5J9yX968BVYHZL7E3KtOgvqVkc9a1T5W5WaQ==
X-Received: by 2002:a05:6214:1cc2:b0:6b5:6a3:7e4 with SMTP id
 6a1803df08f44-6b61c3d733cmr102992836d6.6.1720735614055; 
 Thu, 11 Jul 2024 15:06:54 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b61ba73d74sm29425726d6.82.2024.07.11.15.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 15:06:53 -0700 (PDT)
Date: Thu, 11 Jul 2024 18:06:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: "Wang, Lei" <lei4.wang@intel.com>, qemu-devel@nongnu.org,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH 6/7] migration/multifd: Move payload storage out of
 the channel parameters
Message-ID: <ZpBXejPa8Vac6ZqG@x1n>
References: <Zn15y693g0AkDbYD@x1n> <877cdtfcsi.fsf@suse.de>
 <Zo7cncqkxB89AUBe@x1n> <87y169dmu3.fsf@suse.de>
 <Zo8DaHbWlrNe3RXL@x1n> <87msmodnly.fsf@suse.de>
 <ZpAEIvbNr-ANuASV@x1n> <87bk33en41.fsf@suse.de>
 <ZpBAL3U6G46OBGEN@x1n> <878qy7eipf.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878qy7eipf.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Thu, Jul 11, 2024 at 06:12:44PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Jul 11, 2024 at 04:37:34PM -0300, Fabiano Rosas wrote:
> >
> > [...]
> >
> >> We also don't flush the iov at once, so f->buf seems redundant to
> >> me. But of course, if we touch any of that we must ensure we're not
> >> dropping any major optimization.
> >
> > Yes some tests over that would be more persuasive when it comes.
> >
> > Per my limited experience in the past few years: memcpy on chips nowadays
> > is pretty cheap.  You'll see very soon one more example of that when you
> > start to look at the qatzip series: that series decided to do one more
> > memcpy for all guest pages, to make it a larger chunk of buffer instead of
> > submitting the compression tasks in 4k chunks (while I thought 4k wasn't
> > too small itself).
> >
> > That may be more involved so may not be a great example (e.g. the
> > compression algo can be special in this case where it just likes larger
> > buffers), but it's not uncommon that I see people trade things with memcpy,
> > especially small buffers.
> >
> > [...]
> >
> >> Any piece of code that fills an iov with data is prone to be able to
> >> send that data through multifd. From this perspective, multifd is just a
> >> way to give work to an iochannel. We don't *need* to use it, but it
> >> might be simple enough to the point that the benefit of ditching
> >> QEMUFile can be reached without too much rework.
> >> 
> >> Say we provision multifd threads early and leave them waiting for any
> >> part of the migration code to send some data. We could have n-1 threads
> >> idle waiting for the bulk of the data and use a single thread for any
> >> early traffic that does not need to be parallel.
> >> 
> >> I'm not suggesting we do any of this right away or even that this is the
> >> correct way to go, I'm just letting you know some of my ideas and why I
> >> think ram + device state might not be the only data we put through
> >> multifd.
> >
> > We can wait and see whether that can be of any use in the future, even if
> > so, we still have chance to add more types into the union, I think.  But
> > again, I don't expect.
> >
> > My gut feeling: we shouldn't bother putting any (1) non-huge-chunk, or (2)
> > non-IO, data onto multifd.  Again, I would ask "why not the main channel",
> > otherwise.
> >
> > [...]
> >
> >> Just to be clear, do you want a thread-pool to replace multifd? Or would
> >> that be only used for concurrency on the producer side?
> >
> > Not replace multifd.  It's just that I was imagining multifd threads only
> > manage IO stuff, nothing else.
> >
> > I was indeed thinking whether we can reuse multifd threads, but then I
> > found there's risk mangling these two concepts, as: when we do more than IO
> > in multifd threads (e.g., talking to VFIO kernel fetching data which can
> > block), we have risk of blocking IO even if we can push more so the NICs
> > can be idle again.  There's also the complexity where the job fetches data
> > from VFIO kernel and want to enqueue again, it means an multifd task can
> > enqueue to itself, and circular enqueue can be challenging: imagine 8
> > concurrent tasks (with a total of 8 multifd threads) trying to enqueue at
> > the same time; they hunger themselves to death.  Things like that.  Then I
> > figured the rest jobs are really fn(void*) type of things; they should
> > deserve their own pool of threads.
> >
> > So the VFIO threads (used to be per-device) becomes migration worker
> > threads, we need them for both src/dst: on dst there's still pending work
> > to apply the continuous VFIO data back to the kernel driver, and that can't
> > be done by multifd thread too due to similar same reason.  Then those dest
> > side worker threads can also do load() not only for VFIO but also other
> > device states if we can add more.
> >
> > So to summary, we'll have:
> >
> >   - 1 main thread (send / recv)
> >   - N multifd threads (IOs only)
> >   - M worker threads (jobs only)
> >
> > Of course, postcopy not involved..  How's that sound?
> 
> Looks good. There's a better divide between producer and consumer this
> way. I think it will help when designing new features.
> 
> One observation is that we'll still have two different entities doing IO
> (multifd threads and the migration thread), which I would prefer were
> using a common code at a higher level than the iochannel.

At least for the main channel probably yes.  I think Dan has had the idea
of adding the buffering layer over iochannels, then replace qemufiles with
that.  Multifd channels looks ok so far to use as raw channels.

> 
> One thing that I tried to look into for mapped-ram was whether we could
> set up iouring in the migration code, but got entirely discouraged by
> the migration thread doing IO at random points. And of course, you've
> seen what we had to do with direct-io. That was in part due to having
> the migration thread in parallel doing it's small writes at undetermined
> points in time.

On the locked_vm part: probably yes, we'd better try to avoid using page
pinning if possible. It just looks like it becomes a more important
scenario nowadays to put VMs into containers, it means then such feature
may not be always usable there.

For the rest: I really don't know much on iouring, but I remember it can be
fast normally only in a poll model with interrupt-less context?  Not sure
whether it suites here for us, as I guess we should avoid consuming cpu
resourcess with no good reason, and polling for perf falls into that
category, I think.  Even without it, kubevirt now already has issue on
multifd eating cpus, and people observe multifd threads causing vcpu
threads to be throttled, interrupting guest workloads; they're currently
put in the same container.  I also not sure how much it'll help comparing
to when we have the multi-threading ready.  I suspect not that much.

-- 
Peter Xu


