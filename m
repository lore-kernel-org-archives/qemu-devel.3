Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A85CD6E7D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 14:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVVzj-0003P5-PC; Fri, 05 Jun 2026 10:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wVVzV-0002ji-18
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 10:57:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wVVzQ-0005kS-On
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 10:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780671459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Abg8/nQrACcenQd4RtIegocJUYM1brJSJtZ5eLx/oX0=;
 b=S3cpJhcnTtYo3/t3QJSdgPezC3oXsX7GQ06Zm7gJFIdHNQfeCS2Jw43GxVytWUliXn6aUU
 pq6+dFhrjX1v8Z2qalOmQ9jEXctI6uN3VGru8LVTTNvqaEBUSXiifsFu7DY2HYUqVMaQaQ
 rvKKFZ50THoNOBLpqe9zFg1NHGkPKN8=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-B5xYt_mTOXa81ge09tA60Q-1; Fri, 05 Jun 2026 10:57:38 -0400
X-MC-Unique: B5xYt_mTOXa81ge09tA60Q-1
X-Mimecast-MFC-AGG-ID: B5xYt_mTOXa81ge09tA60Q_1780671457
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-7d9222ae3adso39179507b3.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2026 07:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780671457; x=1781276257; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Abg8/nQrACcenQd4RtIegocJUYM1brJSJtZ5eLx/oX0=;
 b=sgnh1aQQo7ltw4iSpBGcdnlGELAHL3XlVDwkfxdlsc/by56mq0cpV55uKztndkgHdx
 fyt8PJJu2bYHGzwbgbk6u1inbNjLDeBED2TkmV4bFXD1tH4CajsyImojgL6GbxTfH3rp
 dpq53G6xl1dIpYaNvOZpl8t7JH5ZoGqqSja+LFLpCxaOw+CtJ3KBPJjrsUjQjTB4OUh5
 1u6RHDbgsjr1aZ4PBkJzEjk3K2RX3HKyhhHpwzg2tI4CTdr+nluUMhbVH7cyCFBP4wiD
 Y870hDnm13zG5roT/XTycaRrAzd+KjhrViDBjXqv0RqEOUqsHoAIzyIriOJ/GRvib+As
 04RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780671457; x=1781276257;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Abg8/nQrACcenQd4RtIegocJUYM1brJSJtZ5eLx/oX0=;
 b=JGJQ37g2FzsKUx7v4+y8MHRw3IeJ4Wk3JkXETwDInwu9WwTzWk8GLxilrLoLhZgc6R
 yNislQa2j+cTGPgJgPiaPfMIgnctiQbRsbt7MBTHPiddWJQmoxtfOZM6VqprlJJTJSwo
 l6uXvOe1gugBhpAX7wTtqWU9InrZpLzmWziYKWy23UbwQgM+4k8yOxjs+nsy9NE7hZ45
 VENFFP2V2SwdErPRyA50L5XXYz6oCHHf6RTAKZJU5RpWKnm0deFIX4z2sxq7cB4fyy7p
 whsCz9+IP+Wi9SVUIoN1pRwOvQwDGv/xvGyLgGwN85da5Vb23EGDsf+b0wHUbUJ3/zs4
 Z57A==
X-Gm-Message-State: AOJu0YxspfyjcAZu+Drwe+qSACs65BS4DjST67kCbsRs4yIdRFs412YM
 risG/zn7Av3cdVX3lm38gZgsoqGCHv3UY1glQgJw9VqQMZXFhoTlP9XyysIDbdPCwCh2O+Au6nI
 PyE023VKy5fcYa0hl0oe4SwUk4Ta/nBJTRLPZJsyL0ykrahxfbQ21bCjS
X-Gm-Gg: Acq92OFM4Taj0L+OudSPBXWFUzkinEonuSrvzdUqvGDCZruFB6lvcMGTG9LVgVrvWAW
 dHYBeT9poiEqO6+lrXe3ICbmj9J0QFr6umsgzTLGXZIqo6Wjebz87JkLyIFNUbMD597TwA1Kjpd
 LGlk/Bk9QxY95KvS07ssWA+F0zsZFsicWutwDN+I3R+bsHWzgBtzBFiVb0Nx7OynkxIPtaiToIQ
 K/Q3187aDgS85Se+uD95QqN8vnZ8jlHHN5RTXKwrL/UDFCkzUJN+ojZDZuMUzryRVxDKRZIuXme
 NYJkB9z87+ZFiiQbQ46uDrAffkhMg+n8klci5CrJVBFaRRJC08u22NrWKiFQ5IUP6J3tc3bHRSq
 qRtBUQWA0UkMW1MzI0whmNStXnQ==
X-Received: by 2002:a05:690c:c24b:b0:7db:ccda:a412 with SMTP id
 00721157ae682-7ed0a200ecemr42449097b3.2.1780671457265; 
 Fri, 05 Jun 2026 07:57:37 -0700 (PDT)
X-Received: by 2002:a05:690c:c24b:b0:7db:ccda:a412 with SMTP id
 00721157ae682-7ed0a200ecemr42448737b3.2.1780671456690; 
 Fri, 05 Jun 2026 07:57:36 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-7ea215825dfsm51356067b3.15.2026.06.05.07.57.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 07:57:36 -0700 (PDT)
Date: Fri, 5 Jun 2026 10:57:34 -0400
From: Peter Xu <peterx@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 David Hildenbrand <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>,
 Fabiano Rosas <farosas@suse.de>, Alexey Kardashevskiy <aik@amd.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>
Subject: Re: [PATCH v3 00/12] KVM/hostmem: Support init-shared guest-memfd as
 VM backends
Message-ID: <aiLj3o7IIixCvX2A@x1.local>
References: <20251215205203.1185099-1-peterx@redhat.com>
 <rjqfiwh57gip3u3psqg33jhmo7ixaj2qwzupc7zdk7f3d26qnu@tglactz67ogk>
 <aiCAFWKEAHkPLCO5@x1.local>
 <lpkcfd2crgparcd64ydry3ocryx3sfc5gj5pzrrms4nwvw6j4c@ulc3wa3rmefo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <lpkcfd2crgparcd64ydry3ocryx3sfc5gj5pzrrms4nwvw6j4c@ulc3wa3rmefo>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 04, 2026 at 05:36:42PM -0500, Michael Roth wrote:
> > IIUC it's a matter of if we expect future property of guest-memfd that will
> > stop applying to memfd anymore?
> 
> Yah, I think that's the main thing to consider. There's a few things in the
> pipeline where the options associated with guest_memfd might diverage
> quite a bit from memfd:

Thanks for all these contexts.  I'll throw some random questions below,
some of them may not be directly related to the current discussion, but
please bare with me.

> 
>   - hugetlb: yes, these could potentially use the same options memfd
>     uses, and I'm guessing that will end up being the case, but one
>     large gap there is that shared memory is always split to 4K, which
>     we've accepted for now, but if you consider use-cases like DPDK
>     there can still be major performance bottlenecks that would drive
>     us to try to enable larger mappings for the shared ranges, and then
>     we'd end up with guest-memfd-specific parameters intermix with
>     normal memfd options, and our related documentation would need to
>     covers these differences case by case

The first thing I thought about is mTHP and how it can also be similarly
applied to normal memfd (now, or in the future, that I'm not sure).

Before that..  shouldn't the whole concept of private mem / gmem about
reducing the area of mapping the host (including dpdk, if we're talking
about things like OpenVswitch)?  Can you roughly describe how huge mapping
is expected to be allowed in such case?  Does it mean the guest driver
should also be aware to allocate huge continuous physical mem for DMA only?

>   - DAX-like stuff: there are some proposals for making device memory
>     available to use as private guest memory, and since 'guest-memfd'
>     is generally responsible for managing private memory, it will
>     likely end up being extended to handle this at some point. One
>     proposal/PoC[1] would involve at least needing additional options
>     for the /dev/dax path, but there have also been discussions about
>     having a general notion of custom allocators that can be plugged
>     into guest_memfd, and some of these might have overlapping options
>     WRT things like hugepages/etc. But at a high-level, DAX would map
>     more to memory-backend-file than memory-backend-memfd, so we'd
>     already be crossing up some wires there.

I have no deep understanding on this, but IIUC we used to stick with
memory-backend-file for dax.  Why switch to memory-backend-guest-memfd?
Are we still exposing a dax via a file path ultimately, even with CoCo?

Note, here I want to differenciate two concepts: QEMU interfacing and
kernel/KVM interfacing.  I mean, I have a gut feeling that for coco dax we
could still stick with memory-backend-file, even if internally we can still
use new KVM ioctls to set them up: there's no rule to say only
memory-backend-guest-memfd can use the KVM ioctl.  IMHO they're different
stories, and here I'm focused more on the QEMU interfacing that we're
discussing here.

IMHO for QEMU's interfacing, any memory-backend should play one solo role
which is to point to QEMU (as a hypervisor) a backing store for some piece
of resource that can be used as guest memory backend.  It doesn't need to
have any implication on how we implement that backend internally.

>   - live update: there's work[2] on enabling preservation of confidential
>     guest memory across kexec by preserving it through guest_memfd. This
>     one is still a bit mind-blowing to me but I could see us needing
>     some additional options here that would really make no sense for
>     memfd.

Could you elaborate what kind of parameter you would expect?

I'm not sure if you have investigated QEMU's CPR approach, now memfd
backend is really the core of supporting such infrastructure, where fds can
be persisted.  For live update, it'll be persisted across kexec and kernel
switchover.  For CPR, it actually also works when with cpr-reboot with its
own tricky way to persist memory.

In general, what I want to say is, I really think they should play the same
in term of live update case too: if we need to register some fd for
persistency, we need to register gmem, kvm, but also memfd if some of them
are attached to the current VM, right?

>   - directmap removal: these[3] patches allow a new guest_memfd flag to
>     be set to unmap guest_memfd pages from kernel directmap to help
>     mitigate speculative attacks, probably would involve a new option
>     as well that wouldn't be applicable to normal memfds

Now the question is, do we want to remove directmap for "some" memory
backend, or do we want to remove it per-VM?

This is another thing I want to make sure we're on the same page: I want to
make sure we don't introduce per-VM setup for memory backends.

Say, "init-shared" or "in-place CoCo", what should we use for one gmem fd?
IMHO it shouldn't be a parameter in the memory-backend.  It should be a
parameter for the -machine or some similar per-vm setup, which will apply
to all gmemfd across the current VM.

My understanding is directmap removal is similar in this case, which seems
to be a per-VM (rather than per-memory-backend) attribute?  We can still
operate on that per-memory-backend, but then it'll be internally, the
backends need to understand the VM setup and do things properly, IMHO.

> 
> It could also end up that even memory-backend-guest-memfd is too
> generic, and that some of these would involve a more specialized memory
> backend where may they can share a common base class for some of the
> core guest_memfd stuff but otherwise be separate backends with their
> own specific options. So to me, starting off building up
> memory-backend-memfd seems like a potential misstep, whereas we don't
> really lose much to start with a clean slate.
> 
> [1] DAX: https://lwn.net/ml/all/20260423170219.281618-1-dave.jiang@intel.com/
> [2] LUO: https://lore.kernel.org/all/cover.1779080766.git.tarunsahu@google.com/#r
> [3] directmap removal: https://lore.kernel.org/kvm/20260317141031.514-1-kalyazin@amazon.com/
> 
> > 
> > > 
> > > I also saw you were open to having someone pick up these patches if you
> > > don't think you'll have a chance to get to them near-term, so I'd be
> > > happy to pick them up if that's preferable.
> > 
> > Sure!  Indeed I don't have bandwidth to keep working on this one in the
> > near future. Please feel free to pick whatever needed into your series.
> 
> Ok, sounds good, I'll pick these up for my next posting and incorporate
> any changes/comments that might still be pending at that time.
> 
> Thanks for getting things to this stage!

Thanks for picking it up!  Juraj in our team may have some future
exploration on gmem over 1G for postcopy on init-shared, so it's great the
code is moving closer to that direction.

Thanks,

-- 
Peter Xu


