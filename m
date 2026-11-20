Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99F9606A325
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gbdUTyB+;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=UmPujqkF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUQJT-0004MN-Pn; Fri, 20 Nov 2026 10:14:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xUQJR-0004M0-Mw
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 10:14:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xUQJP-0005aZ-MT
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 10:14:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795187642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EdhKmXOPvykwg5q5sb3W4v1ljwlwcoPvRP2NiQ3jeew=;
 b=gbdUTyB+YSOtS1Q+S5SzLc+aiUBacjBR9t/Wk1IskNAPZsWHE5bGq2FE9M8RHali/AvFxI
 UTWTjgzhOo+e+x/RbQvjlYB2BeoD9th0ADqCnpen9TPcNlb5ZI3mWfepVoTkmOoHXRFEeo
 iMsMBbcFAdzQ0P+qrU4YapThbHLYWf0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-FXHXtNHOMkGn31oqrYWwgA-1; Fri, 20 Nov 2026 15:13:58 +0000
X-MC-Unique: FXHXtNHOMkGn31oqrYWwgA-1
X-Mimecast-MFC-AGG-ID: FXHXtNHOMkGn31oqrYWwgA_1795187638
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-542fc619afaso13677441cf.2
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 07:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795187638; x=1795792438; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EdhKmXOPvykwg5q5sb3W4v1ljwlwcoPvRP2NiQ3jeew=;
 b=UmPujqkF2UhQ51gwCAadkQlvXC5GgyiANIB+lhgC3LSxed6AG9rJIW+wr6HRq5PWVT
 UsOYotfYGiwU49A73uu+z29xfZ6xYD1yYS+aAIOnNWAaBhbjlXCZkmo9g9xIuI4JMPpa
 6uZMahvK2XF8Mh3EXeJ0qgbX1K47TXbrFv0fV+7f9K0jzaIpTeScw8O8qjUHfMOnIH6r
 Xt4KISub/nHBlNKFVNUdABwlwgoH2YmggQx8SZ8bJYov9Xs+QumfMrFac2d3tXTOtgWk
 xBWlQvSHeYZ7sXrnSj9hLWAzdHpr4Bev+Qq2y4GzRGvFvhsgHacNYEmJpUmctYG1ChOg
 2lPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795187638; x=1795792438;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EdhKmXOPvykwg5q5sb3W4v1ljwlwcoPvRP2NiQ3jeew=;
 b=UsZ1lCTrL33onaS2plAuL9nwvqt0v5OMtn8w3I1mnCIm47wr+G/LaQk4MmRnoag2Nx
 nN9mEUlhpCpC3TKc7F9HYVm4OsBQ6SgqsSx3KIo4euarvcRyjGwrMNoSNzpl93bz/hVh
 yJgHwudcpSNUHyHM7XzieQcfkCRV1GO+1+udjYc354RnLuWdKz3WnxMQ2f0feWexklm4
 gnlLEAebhO9sc8jpWkpgkZ+KUUhnhAtpKyuhi146aSRx48vs0al5YunJnkJwUMS2WR39
 Eg0FVI8fvJAToxR9mtXpLMkm78iUZqo0U9HjTJi5KO9uz9IDWb8FDr4UGS3R+JCwhV6R
 lgHw==
X-Forwarded-Encrypted: i=1;
 AL+hErH9GA15+FHaaX2g0iX/jfiZNBuNpdh8Oo0g/OG142oliKJ5a5jhbgKCEcNtPvkXTudt/ZbC6I/+ePwu@nongnu.org
X-Gm-Message-State: APuU4Z/mI+BXdCpc61lF/mGXQOujBUjshWxtlTQcJfieKzgyaUfWu0Lv
 m/B5bnr2pV9D+Zw8TIGU1hagoOKUlTDb4WOhCIEVL40xOf0TiGZepQbJpjFiAALyCYRtNyKv7d3
 7f/emrgzNqaZJRQd1JqKpwgJj6tIsC7E5+1XNgXvu5N4pYWanU3V9wbCC
X-Gm-Gg: AZFdTZcP01O6TNhgOHIkkzlgsvpcs9rzNYZqTY1QIZ6+4aV1BAGX2f9R1ZK9QQiMhwg
 dcskh0lzb3QXidgfqKA5fXR1mp/xKYcg/jmdXfQzFr7R4riEnvNvK6XKC0vfITA0nusg4Nn272L
 yJEM44+yGCzR16sA6lmswk9AU22akTUQb8toDRq/ydzF/PB0dULFyrZ1nfxXs6QDX6FDalCszo4
 nVTStsjR5H+FRGlZwGXIeZOPccknPXPnNPzPxMZPrLPWi5we5AB33gUUCQWTxLnKcAI0h6oww/P
 cKdRuzokwivtVCCPG1uFgEpEz2FzuKQGkLyjJQE20TCrNkoFOPzTjtwqVQmSB5BqGQNvy8C5AMP
 VuiJE6/aFC98vVS7nY0PVn5AQfxto44Qqexq+9e3eUnsQvg==
X-Received: by 2002:a05:622a:2609:b0:55b:d65c:665e with SMTP id
 d75a77b69052e-55d7688cd55mr67217021cf.5.1795187637908; 
 Fri, 20 Nov 2026 07:13:57 -0800 (PST)
X-Received: by 2002:a05:622a:2609:b0:55b:d65c:665e with SMTP id
 d75a77b69052e-55d7688cd55mr67216181cf.5.1795187637262; 
 Fri, 20 Nov 2026 07:13:57 -0800 (PST)
Received: from localhost ([2605:8d80:6d65:87a7:10d7:f219:658f:435a])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d7c654585sm16693861cf.5.2026.11.20.07.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 07:13:56 -0800 (PST)
Date: Fri, 20 Nov 2026 10:13:54 -0500
From: Peter Xu <peterx@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Mark Kanda <mark.kanda@oracle.com>,
 Ben Chaney <bchaney@akamai.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] hostmem: fix cpr-exec of VMs with bound guest memory
Message-ID: <awBb-wKu6j8JqP1V@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260924125800.4188406-1-den@openvz.org>
 <20260924125800.4188406-2-den@openvz.org>
 <cd0292cf-2a87-4716-a8c9-d87853949c76@maciej.szmigiero.name>
 <asZaCerfcnfmAlIw@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <6144855c-f231-41a4-ac6e-b47760b7c8ce@virtuozzo.com>
 <asaPlV0HAyfQm_PS@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <20261105180146.2959656-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261105180146.2959656-1-den@openvz.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 07:01:45PM +0100, Denis V. Lunev wrote:
> On Wed, Oct 07, 2026 at 02:29:41PM -0400, Peter Xu wrote:
> > One thing I can think of that we need host-nodes= is when different
> > backends may be bound to different numa node, but since the current use
> > case already enabled memcg and looks like it can shift to completely
> > different numa nodes, it doesn't seem to be the case.
> 
> That is how these VMs start: libvirt turns the guest NUMA topology it
> gets from OpenStack into one backend per guest node, each with its own
> host-nodes. The cpuset is moved later, and not by libvirt, which
> refuses to change the nodeset of a running domain in strict mode. I
> agree that host-nodes plus a moving cpuset is not a setup to
> recommend, but it is what the stack gives us.

[sorry for a delay on respond]

> 
> > So it looks like a real issue and also looks severe, but it's a matter of
> > whether it should be fixed in qemu. If we want to fix it in QEMU, we
> > should have some solid reasoning.
> 
> QEMU never asks the kernel for a static binding. It calls mbind()
> with MPOL_MF_STRICT | MPOL_MF_MOVE and without MPOL_F_STATIC_NODES.
> Without that flag the kernel contract is that the nodemask follows the
> cpuset: when cpuset.mems changes, the policy is rebound to the new
> nodes (Documentation/admin-guide/mm/numa_memory_policy.rst, the
> MPOL_F_STATIC_NODES section), and on cgroup v2 the pages are migrated
> with it (cgroup-v2.rst, cpuset.mems). By the time of the update the
> running QEMU had its policy rebound and its pages on the new nodes,
> and the guest ran fine.

True.

However also since QEMU uses STRICT+MOVE, it means mbind() is also expected
to fail and ask qemu to bail out early if it can't move them at least when
QEMU boots.  This patch will change that behavior, even if only for
cpr-exec.

> 
> The incoming CPR QEMU is the only one that objects. It takes the
> nodemask from the command line and re-applies it to memory it did not
> allocate and the kernel has already moved. host-nodes no longer
> intersects cpuset.mems, so mbind() fails with EINVAL before it looks
> at a single page, and QEMU exits. The EINVAL itself is documented
> kernel behaviour. What QEMU adds on top is a lost guest.
> 
> A normal migration destination never sees this: it is a fresh process
> which the management layer places before it starts. With CPR the new
> process inherits memory that has a history. Steve fixed the same class
> of problem for ROM contents (b42f28111e), pflash (e56ba1878f), PCI and
> vfio-pci reset (24c156dcd9, 031fbb7110) and IOMMU mappings
> (6ff4cccd13): realize must not redo what the old process already did
> to state that CPR preserved. 2b7e9739fa made the backends inherit
> their fd, but the mbind() and prealloc tail of
> host_memory_backend_memory_complete() still treats the memory as new.

At that time, Steve was pretty advanced on the design, and it's a huge
piece of work so likely we didn't really have enough resources to fully
review and discuss all details.  But I think we should not take that as a
reason to say we can keep adding cpr-exec check into more places: we'll pay
at some point, I have that feeling.

One example, the iommufd change it hid the check into map/unmap, it smells
hackish on its own: IMO it's saner if we can skip all map/unmap completely
from top when cpr-exec dest QEMU boots, if the fd will be preserved.

Another: I don't know why ROMs needs to be skipped either, logically with
aux-ram-share=on it should apply to all such MRs, if not it sounds to me we
should fix that instead of hacking rom code to bypass a memset.

I confess I didn't read anything yet into depth. But these are
pre-this-patch questions, feel free to ignore too and we can focus on this
one.  I just want to say some of them may not stand on its own so I also
don't want to use that as reason to merge more of such.

> 
> Prealloc, when enabled, is the same story. It runs MADV_POPULATE_WRITE
> over the whole inherited guest RAM while the guest is stopped. That is
> downtime growing with the RAM size, spent on pages that already exist.
> 
> Maciej is right about extra backends. A backend the old QEMU did not
> have gets a fresh fd because cpr_find_fd() finds nothing for it, yet
> cpr_is_incoming() is true, so v1 would skip its binding too. v2
> decides per backend, by whether its fd was inherited. For an inherited
> backend it still calls mbind(), reports a failure with warn_report()
> naming the backend, as Maciej suggested, and skips prealloc.
> Continuing after a failed mbind() is safe: at fault time the kernel
> ignores a bind policy with no node in the cpuset and allocates from
> the cpuset. Backends created fresh in the new process keep today's
> behaviour.
> 
> Peter, would that work for you? I would rather agree on the direction
> before sending v2.

So the cpuset is decided from the top, it was broadcasted to qemu in form
of host-nodes=, then if the top changes decision, it should notify qemu or
they're inconsistent.  It's almost by design..

We either shouldn't do it, or we should notify to qemu or at least libvirt
on the change, so that libvirt should know what to do.

At very minimum if such notification is hard: do you still think it's still
feasible fixing your mgmt code to not attach host-nodes= at all for
cpr-exec targets (aka, cpr-exec-command), assuming that doesn't make much
sense if all RAMs are persisted?

Thanks,

-- 
Peter Xu


