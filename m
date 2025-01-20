Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5BDC02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 18:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZwaW-00020c-0m; Mon, 20 Jan 2025 13:33:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tZwaU-0001zr-76
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 13:33:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tZwaR-0006pD-KY
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 13:33:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737398001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aM4yh0+VbSepU7uunJEpWr7/he49rP8M1CCdvoDaS84=;
 b=RAFREQ6U7vC2nG9lqbjAb0giMTdK58VChALQCdAHJsxTcz50csPJl5Mg5OsimHwfDxdOZZ
 NQX+EmmLWnX/Slyuhj0ysiKnSoQtLkbzy6xW4AmTUvij1Y3bndSzsrknf1HfRMu9HWxb9Y
 xslYNxhG0Sius+4QU4DwymxFZ2OSZRk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-dVE07HZ4NNW2OpnvsWZyLg-1; Mon, 20 Jan 2025 13:33:20 -0500
X-MC-Unique: dVE07HZ4NNW2OpnvsWZyLg-1
X-Mimecast-MFC-AGG-ID: dVE07HZ4NNW2OpnvsWZyLg
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6d8e6046f0fso73216226d6.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 10:33:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737397999; x=1738002799;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aM4yh0+VbSepU7uunJEpWr7/he49rP8M1CCdvoDaS84=;
 b=ttl1tSp0dkl/qVrOKBXPvCP/umvFEUMRppeAkVbszAeDvu7xiITA3YnXAN5opI3Li9
 erOR5jzc0F2UQpM5IWPZRVLah31tHlbMmd1ZvVmh9jTkb8OJh+G4nfWqZWDDMdVJVR/B
 spzQBDoPCyMfY23WLCFxMxy53Ey1QR7mIsPA+Ndlbl14bQ96AWtbo/vZ0jH9D0HjiSjm
 Ms5OaZjvRNpAQbZei7CL3wZgGQ+R/YvsgMjckWLS8I8dovFHBa5R38pDEA11/Z3Qk8a4
 AOW+zJHfuDlmZOz1J96dkdK0mEaHKQVBUz3gqlWw6TvEOHFfKNxFX3QsVzNBk7YnqnTg
 76aQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL9x1Omzx5CMUWctDFG2MF0GisecyunY6u6zSw2LmpjjljjvLDhpc1IR8pl2WBRl3oS8o2nFRLnjGG@nongnu.org
X-Gm-Message-State: AOJu0YxtzCsy7GQtpuptCAOK+yaZeYRDYFE5eXv32yt4cwBkAUR3EvPl
 gMD0PERnb+fpyoynQCdf5eA1vSd+5RKQp/e7iNevN6CUzZuNoNxupJpgWGQUWEjIAVClC1OV0h8
 lBGDQTRUWTL088gVazQet0M1akj9Ne1HTJiYEKoqrwalO8vvdF/n9
X-Gm-Gg: ASbGncs0Y/1tOMH4xt2r9wl/GXZN8Fol4sWP6X2tn6oO1R5sq2JbMcFCGHICUdUb3sX
 WbyjXDd4Vq9fb6iQ3HL1IPA/drmOYrpAhK1Wb1k/4i1vihPNiKhs0RdYuFRhyvVnWdscv1kVM4V
 PZfIb0mXaxBVsXuXcgCg1uiVLbcCWkti3VzUpQhpPQ3Sk7fXrN0mFAXf3ZgRpbYtzY8+BIJbJcu
 ubRMVreE9kpUTk+B2QqAt8AsTr8ahLGMkHK7DUbF+YeXhmLVkSYz95juQAnLatYhEZ/tU4dFpzV
 hPvBWqDkn9lCWx4cdct++fvMkc4xkF4=
X-Received: by 2002:a05:6214:e4d:b0:6d3:65ad:af2f with SMTP id
 6a1803df08f44-6e1b217a5e7mr174102986d6.16.1737397999638; 
 Mon, 20 Jan 2025 10:33:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBSfqBz0nwd7lGheZJNvjpjuH55KhUHRvq1O+paABvGDhjd4N4YWtUHv11+y5PvvRoIZ8ogw==
X-Received: by 2002:a05:6214:e4d:b0:6d3:65ad:af2f with SMTP id
 6a1803df08f44-6e1b217a5e7mr174102756d6.16.1737397999325; 
 Mon, 20 Jan 2025 10:33:19 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1cc9e8b54sm20246006d6.86.2025.01.20.10.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 10:33:18 -0800 (PST)
Date: Mon, 20 Jan 2025 13:33:16 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 2/7] guest_memfd: Introduce an object to manage the
 guest-memfd with RamDiscardManager
Message-ID: <Z46W7Ltk-CWjmCEj@x1n>
References: <20241213070852.106092-1-chenyi.qiang@intel.com>
 <20241213070852.106092-3-chenyi.qiang@intel.com>
 <d0b30448-5061-4e35-97ba-2d360d77f150@amd.com>
 <80ac1338-a116-48f5-9874-72d42b5b65b4@intel.com>
 <9dfde186-e3af-40e3-b79f-ad4c71a4b911@redhat.com>
 <c1723a70-68d8-4211-85f1-d4538ef2d7f7@amd.com>
 <f3aaffe7-7045-4288-8675-349115a867ce@redhat.com>
 <Z46GIsAcXJTPQ8yN@x1n>
 <7e60d2d8-9ee9-4e97-8a45-bd35a3b7b2a2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7e60d2d8-9ee9-4e97-8a45-bd35a3b7b2a2@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jan 20, 2025 at 06:54:14PM +0100, David Hildenbrand wrote:
> On 20.01.25 18:21, Peter Xu wrote:
> > On Mon, Jan 20, 2025 at 11:48:39AM +0100, David Hildenbrand wrote:
> > > Sorry, I was traveling end of last week. I wrote a mail on the train and
> > > apparently it was swallowed somehow ...
> > > 
> > > > > Not sure that's the right place. Isn't it the (cc) machine that controls
> > > > > the state?
> > > > 
> > > > KVM does, via MemoryRegion->RAMBlock->guest_memfd.
> > > 
> > > Right; I consider KVM part of the machine.
> > > 
> > > 
> > > > 
> > > > > It's not really the memory backend, that's just the memory provider.
> > > > 
> > > > Sorry but is not "providing memory" the purpose of "memory backend"? :)
> > > 
> > > Hehe, what I wanted to say is that a memory backend is just something to
> > > create a RAMBlock. There are different ways to create a RAMBlock, even
> > > guest_memfd ones.
> > > 
> > > guest_memfd is stored per RAMBlock. I assume the state should be stored per
> > > RAMBlock as well, maybe as part of a "guest_memfd state" thing.
> > > 
> > > Now, the question is, who is the manager?
> > > 
> > > 1) The machine. KVM requests the machine to perform the transition, and the
> > > machine takes care of updating the guest_memfd state and notifying any
> > > listeners.
> > > 
> > > 2) The RAMBlock. Then we need some other Object to trigger that. Maybe
> > > RAMBlock would have to become an object, or we allocate separate objects.
> > > 
> > > I'm leaning towards 1), but I might be missing something.
> > 
> > A pure question: how do we process the bios gmemfds?  I assume they're
> > shared when VM starts if QEMU needs to load the bios into it, but are they
> > always shared, or can they be converted to private later?
> 
> You're probably looking for memory_region_init_ram_guest_memfd().

Yes, but I didn't see whether such gmemfd needs conversions there.  I saw
an answer though from Chenyi in another email:

https://lore.kernel.org/all/fc7194ee-ed21-4f6b-bf87-147a47f5f074@intel.com/

So I suppose the BIOS region must support private / share conversions too,
just like the rest part.

Though in that case, I'm not 100% sure whether that could also be done by
reusing the major guest memfd with some specific offset regions.

> 
> > 
> > I wonder if it's possible (now, or in the future so it can be >2 fds) that
> > a VM can contain multiple guest_memfds, meanwhile they request different
> > security levels. Then it could be more future proof that such idea be
> > managed per-fd / per-ramblock / .. rather than per-VM. For example, always
> > shared gmemfds can avoid the manager but be treated like normal memories,
> > while some gmemfds can still be confidential to install the manager.
> 
> I think all of that is possible with whatever design we chose.
> 
> The situation is:
> 
> * guest_memfd is per RAMBlock (block->guest_memfd set in ram_block_add)
> * Some RAMBlocks have a memory backend, others do not. In particular,
>   the ones calling memory_region_init_ram_guest_memfd() do not.
> 
> So the *guest_memfd information* (fd, bitmap) really must be stored per
> RAMBlock.
> 
> The question *which object* implements the RamDiscardManager interface to
> manage the RAMBlocks that have a guest_memfd.
> 
> We either need
> 
> 1) Something attached to the RAMBlock or the RAMBlock itself. This
>    series does it via a new object attached to the RAMBlock.
> 2) A per-VM entity (e.g., machine, distinct management object)
> 
> In case of 1) KVM looks up the RAMBlock->object to trigger the state change.
> That object will inform all listeners.
> 
> In case of 2) KVM calls the per-VM entity (e.g., guest_memfd manager), which
> looks up the RAMBlock and triggers the state change. It will inform all
> listeners.

(after I finished reading the whole discussion..)

Looks like Yilun raised another point, on how to reuse the same object for
device TIO support here (conversions for device MMIOs):

https://lore.kernel.org/r/https://lore.kernel.org/all/Z4RA1vMGFECmYNXp@yilunxu-OptiPlex-7050/

Thanks,

-- 
Peter Xu


