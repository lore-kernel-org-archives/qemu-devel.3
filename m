Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD79C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:13:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg8A7-0008Ou-MF; Thu, 06 Feb 2025 15:07:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tg85n-0002sX-Ri
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:03:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tg85l-0001cw-MT
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:03:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738872195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DKqGPfhuKIGtj4Hghs+eXC5K6q9Go7OMpG2M9IoV/XY=;
 b=R0Bk8ek+Xti0xoAo8KfDcY5JbGf5WZRyh3BjfCtEuR+aRgmkTLe1S1B3dSkDR3tOH5OpkU
 ImRViaQe9xbHlkubmbahU/7uMMmOyQHeSFggk3d6fGAmJkcdKxz6ZwvZtvkYoECyZvW3nu
 5cUsXFY0CMvJNZ+Nwnb9ZT73e8wrUwE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-3hGmFWovPNCyfcxJz7Aszw-1; Thu, 06 Feb 2025 15:03:14 -0500
X-MC-Unique: 3hGmFWovPNCyfcxJz7Aszw-1
X-Mimecast-MFC-AGG-ID: 3hGmFWovPNCyfcxJz7Aszw
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-467b19b5641so25802811cf.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 12:03:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738872194; x=1739476994;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DKqGPfhuKIGtj4Hghs+eXC5K6q9Go7OMpG2M9IoV/XY=;
 b=h+UmFRMTO4BoVEWBsXAuy2uUtLjPCEuKKfc3yoYTPBUIbWFAKwvQW4sscHW+Kop/ah
 GPaSDiI/yZkjy5rXrslIp7C4TqrjhbymXjkLo+7pvS9wz/dBFlmTIdQvlCuh0t2dmALU
 K1kz+jy1Kwfci0zbUtR6rgQ4tnI1d6rpZlCv26ytlD0x1bPuR9YkeF5bEFovSENIaEwj
 YRrE/lefjT83TdSTwnq6j++fOo7i8nFx3c8aSkMVsijGR6uymKPfFarTNrDSLDLrNXUU
 xaheXtNJwhr9i/vJ6QptSNv1jiGWQ6xqGt2lAc7NW+2UGrfBr9pWiCEEvR/PVbuEusDP
 0ZXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEyPz4uL/VIHx6Dg37T92G99UB0ndYX5DiBtvtl6cweUZCkV+uOJjMRDMfC9yENLL9Qc66gyzsPsHu@nongnu.org
X-Gm-Message-State: AOJu0Yz8FShSDG0b57OhVBzk14rAvRg/Yen5CkZxJ5mhsLRPK8lwp4NL
 ZAER4HSUAYobDNpqJRnXzyoipCjNj+5lt9ZNPq8/HU4z0t3k2A8fZpMWRmnG35wFpWQ3JAbiOBc
 ZzwsTpvrRYrhXjeUs1Gb1YFtVUogXE6o4OePNV7Slu6q+iYRXdmZY
X-Gm-Gg: ASbGnctcu09fuyGSdO7gz/WI34wQ7sBq9WeQjPqOtBdQpE0LXMHzSR0xT9PlFXmz4cX
 N08AqbWJ3RaZuLH7LJYhEsiJ88y2h8QmUdsWjz6Ebt9GqmHIJXhUDTVW7SqceRQPdw4i/wfOc5L
 CE4PBjMq9jn8q9oz3ea7DfxwAf5Y+6Bs6thl/jSct1lEoKG0dp9kvhS6MrcwXA7uZ2vJ+rNPsTC
 XoMn5DAxgmBY+H6RJnlzdmI6keM3rtJmpNWY6qpqk5UxXHIliaFcUlmncV3agojbroRM8FQdUbr
 j2P22D3wJmppU+meAHnsTqIf4k3vMkS+J5UXOvaPdtkm2dOX
X-Received: by 2002:a05:622a:256:b0:467:7109:c783 with SMTP id
 d75a77b69052e-4716798aeedmr9263571cf.3.1738872193992; 
 Thu, 06 Feb 2025 12:03:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENmMKXdalwsDefa/7t7DHwVYizdH9C6eqbzxx/dcYYf6qBnHuQPjPtuYUdoaY4dulor+h2mg==
X-Received: by 2002:a05:622a:256:b0:467:7109:c783 with SMTP id
 d75a77b69052e-4716798aeedmr9262931cf.3.1738872193467; 
 Thu, 06 Feb 2025 12:03:13 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47153beaa5csm8459611cf.68.2025.02.06.12.03.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 12:03:12 -0800 (PST)
Date: Thu, 6 Feb 2025 15:03:10 -0500
From: Peter Xu <peterx@redhat.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 2/7] guest_memfd: Introduce an object to manage the
 guest-memfd with RamDiscardManager
Message-ID: <Z6UVfrllv-Ahex73@x1.local>
References: <95a14f7d-4782-40b3-a55d-7cf67b911bbe@amd.com>
 <Z5C9SzXxX7M1DBE3@yilunxu-OptiPlex-7050> <Z5EgFaWIyjIiOZnv@x1n>
 <Z5INAQjxyYhwyc+1@yilunxu-OptiPlex-7050> <Z5Jylb73kDJ6HTEZ@x1n>
 <Z5NhwW/IXaLfvjvb@yilunxu-OptiPlex-7050> <Z5O4BSCjlhhu4rrw@x1n>
 <Z5WtRYSf7cjqITXH@yilunxu-OptiPlex-7050>
 <Z5uom-NTtekV9Crd@x1.local>
 <Z6SRxV83I9/kamop@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z6SRxV83I9/kamop@yilunxu-OptiPlex-7050>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, Feb 06, 2025 at 06:41:09PM +0800, Xu Yilun wrote:
> On Thu, Jan 30, 2025 at 11:28:11AM -0500, Peter Xu wrote:
> > On Sun, Jan 26, 2025 at 11:34:29AM +0800, Xu Yilun wrote:
> > > > Definitely not suggesting to install an invalid pointer anywhere.  The
> > > > mapped pointer will still be valid for gmem for example, but the fault
> > > > isn't.  We need to differenciate two things (1) virtual address mapping,
> > > > then (2) permission and accesses on the folios / pages of the mapping.
> > > > Here I think it's okay if the host pointer is correctly mapped.
> > > > 
> > > > For your private MMIO use case, my question is if there's no host pointer
> > > > to be mapped anyway, then what's the benefit to make the MR to be ram=on?
> > > > Can we simply make it a normal IO memory region?  The only benefit of a
> > > 
> > > The guest access to normal IO memory region would be emulated by QEMU,
> > > while private assigned MMIO requires guest direct access via Secure EPT.
> > > 
> > > Seems the existing code doesn't support guest direct access if
> > > mr->ram == false:
> > 
> > Ah it's about this, ok.
> > 
> > I am not sure what's the best approach, but IMHO it's still better we stick
> > with host pointer always available when ram=on.  OTOH, VFIO private regions
> > may be able to provide a special mark somewhere, just like when romd_mode
> > was done previously as below (qemu 235e8982ad39), so that KVM should still
> > apply these MRs even if they're not RAM.
> 
> Also good to me.
> 
> > 
> > > 
> > > static void kvm_set_phys_mem(KVMMemoryListener *kml,
> > >                              MemoryRegionSection *section, bool add)
> > > {
> > >     [...]
> > > 
> > >     if (!memory_region_is_ram(mr)) {
> > >         if (writable || !kvm_readonly_mem_allowed) {
> > >             return;
> > >         } else if (!mr->romd_mode) {
> > >             /* If the memory device is not in romd_mode, then we actually want
> > >              * to remove the kvm memory slot so all accesses will trap. */
> > >             add = false;
> > >         }
> > >     }
> > > 
> > >     [...]
> > > 
> > >     /* register the new slot */
> > >     do {
> > > 
> > >         [...]
> > > 
> > >         err = kvm_set_user_memory_region(kml, mem, true);
> > >     }
> > > }
> > > 
> > > > ram=on MR is, IMHO, being able to be accessed as RAM-like.  If there's no
> > > > host pointer at all, I don't yet understand how that helps private MMIO
> > > > from working.
> > > 
> > > I expect private MMIO not accessible from host, but accessible from
> > > guest so has kvm_userspace_memory_region2 set. That means the resolving
> > > of its PFN during EPT fault cannot depends on host pointer.
> > > 
> > > https://lore.kernel.org/all/20250107142719.179636-1-yilun.xu@linux.intel.com/
> > 
> > I'll leave this to KVM experts, but I actually didn't follow exactly on why
> > mmu notifier is an issue to make , as I thought that was per-mm anyway, and KVM
> > should logically be able to skip all VFIO private MMIO regions if affected.
> 
> I think this creates logical inconsistency. You builds the private MMIO
> EPT mapping on fault based on the HVA<->HPA mapping, but doesn't follow
> the HVA<->HPA mapping change. Why KVM believes the mapping on fault time
> but doesn't on mmu notify time?

IMHO as long as kvm knows it's a private MMIO and there's no mapping under
it guaranteed, then KVM can safely skip those ranges to speedup the mmu
notifier.

Said that, I'm not suggesting to stick with hvas if there're better
alternatives.  It's only about the paragraph that confused me a bit.

> 
> > This is a comment to this part of your commit message:
> > 
> >         Rely on userspace mapping also means private MMIO mapping should
> >         follow userspace mapping change via mmu_notifier. This conflicts
> >         with the current design that mmu_notifier never impacts private
> >         mapping. It also makes no sense to support mmu_notifier just for
> >         private MMIO, private MMIO mapping should be fixed when CoCo-VM
> >         accepts the private MMIO, any following mapping change without
> >         guest permission should be invalid.
> > 
> > So I don't yet see a hard-no of reusing userspace mapping even if they're
> > not faultable as of now - what if they can be faultable in the future?  I
> 
> The first commit of guest_memfd emphasize a lot on the benifit of
> decoupling KVM mapping from host mapping. My understanding is even if
> guest memfd can be faultable later, KVM should still work in a way
> without userspace mapping.

I could have implied to suggest using hva, not my intention.  I agree
fd-based API is better too in this case at least as of now.

What I'm not sure is how the whole things evolve with either gmemfd or
device fd when they're used with shared and mappable pages.  We can leave
that for later discussion for sure.

> 
> > am not sure..
> > 
> > OTOH, I also don't think we need KVM_SET_USER_MEMORY_REGION3 anyway.. The
> > _REGION2 API is already smart enough to leave some reserved fields:
> > 
> > /* for KVM_SET_USER_MEMORY_REGION2 */
> > struct kvm_userspace_memory_region2 {
> > 	__u32 slot;
> > 	__u32 flags;
> > 	__u64 guest_phys_addr;
> > 	__u64 memory_size;
> > 	__u64 userspace_addr;
> > 	__u64 guest_memfd_offset;
> > 	__u32 guest_memfd;
> > 	__u32 pad1;
> > 	__u64 pad2[14];
> > };
> > 
> > I think we _could_ reuse some pad*?  Reusing guest_memfd field sounds error
> > prone to me.
> 
> It truly is. I'm expecting some suggestions here.

Maybe a generic fd+offset pair from pad*?  I'm not sure whether at some
point that could also support guest-memfd there too, after all it's easy
for kvm to check whatever file->f_op it's backing, so logically kvm should
allow backing a memslot with whatever file without HVA.  Just my 2 cents.

Thanks,

-- 
Peter Xu


