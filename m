Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643F2CD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 11:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXdfU-0000k6-Vc; Thu, 11 Jun 2026 07:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1wXdfS-0000jc-Mw
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:33:50 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1wXdfQ-0006cC-KR
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:33:50 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DEDF443C6E;
 Thu, 11 Jun 2026 11:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0EB21F00898;
 Thu, 11 Jun 2026 11:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781177625;
 bh=XtoZWIMpe3XFCu0G91C2SFq1eUNILXm0sAmFmixCCyM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=gIe0w9AmozqqfUq8T5lHXjY3BMZjgk8Cn7DxaotNGqQ8lPrKGq/RwuJJZKClxiEZg
 0cC4XxKb7yL5y0myOSdVrRgaeLhF/tBJmOAa9B0+s2QxciJiWY1skChI5BLEvqXPmZ
 UDTWpTPq3X0OoqLp8k/6MC2REzCAa9Dm682Yr+H1xPkmZT73XTC+EqD5QYxzo0DaQ1
 TI+Hl/9AFI8o9X5J+DXuje1fewbBbuwq2gZFZAI7jCSkorLhQn/ITrAaFNvbJv15Ft
 sXR9iTz8QE01y4ZU1wMoqRnQN2y4HOG6t7/yQ0n3k+cbiJmSJ2ptbOawxxcTXv40QA
 M0E3sbSwyDUaQ==
Date: Thu, 11 Jun 2026 17:02:56 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Michael Roth <michael.roth@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, 
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Nikunj A Dadhania <nikunj@amd.com>, 
 Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Srikanth Aithal <srikanth.aithal@amd.com>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC PATCH] target/i386: SEV: Allow pflash devices with SEV-ES
 guests
Message-ID: <aiqWjTxzTeyeDyZp@blrnaveerao1>
References: <20260602071213.2084388-1-naveen@kernel.org>
 <b7xwzrdt4zg5g45ufhqj46d3f4uezpy733gnsc7bv4cploxevz@rw327aciq2cg>
 <ailAARL2xS7qSNzL@blrnaveerao1>
 <88d332b0-8756-444a-9d32-53299a0ebfa8@amd.com>
 <mlvawqkbrcucfylk3cigfs3fnh37njaea3l3hvt3dnu5xl73am@x6ixj57thfjk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mlvawqkbrcucfylk3cigfs3fnh37njaea3l3hvt3dnu5xl73am@x6ixj57thfjk>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=naveen@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jun 10, 2026 at 02:33:20PM -0500, Michael Roth wrote:
> On Wed, Jun 10, 2026 at 09:52:00AM -0500, Tom Lendacky wrote:
> > On 6/10/26 06:30, Naveen N Rao wrote:
> > > [+Sean]
> > > 
> > > Hi Mike,
> > > 
> > > On Tue, Jun 09, 2026 at 07:35:46PM -0500, Michael Roth wrote:
> > >> On Tue, Jun 02, 2026 at 12:42:13PM +0530, Naveen N Rao (AMD) wrote:
> > >>> KVM commit 66155de93bcf ("KVM: x86: Disallow read-only memslots for
> > >>> SEV-ES and SEV-SNP (and TDX)"), and the subsequent commit d30d9ee94cc0
> > >>> ("KVM: x86: Only advertise KVM_CAP_READONLY_MEM when supported by VM")
> > >>> stopped advertising KVM_CAP_READONLY_MEM support for encrypted guests
> > >>> (KVM_X86_SEV_ES_VM and KVM_X86_SNP_VM), but not for KVM_X86_DEFAULT_VM
> > >>> type SEV-ES guests. As a result of this, it is no longer possible to
> > >>> start SEV-ES guests with any SEV feature enabled (in particular,
> > >>> debug-swap) with pflash devices.
> > >>>
> > >>> This is an issue since SEV-ES guests have historically used pflash
> > >>> devices for OVMF. Guests on older KVM+Qemu are able to enable debug-swap
> > >>> while using pflash devices, so work around the KVM limitation by
> > >>> switching to using a VMA-based write protection. This allows
> > >>> well-behaved SEV-ES guests to continue to work with pflash devices and
> > >>> enable debug-swap. Mis-behaving guests trying to write to the protected
> > >>> OVMF area will be killed.
> > >>
> > >> Based on Sean's description, a write access to a read-only memslot would
> > >> cause the vCPU to permanently spin on #NPFs if trying to write to it as
> > >> MMIO due to #VC handler not triggering, and that's why we don't support
> > >> read-only memslots. But since SEV-ES was previously working with pflash,
> > >> it seems like it does not rely on this functionality...
> > > 
> > > Right, normal well-behaved SEV-ES/SNP guests work just fine as they 
> > > don't write to any of the read-only areas.
> > 
> > Yes they do. There is specific support to make a direct GHCB MMIO
> > request because of the lack of the #VC exception (see
> > OvmfPkg/QemuFlashFvbServicesRuntimeDxe/QemuFlashDxe.c).

Good to know!

> 
> With that change in place, it seems like we don't have remaining guest-side
> code for ES/SNP guests that relies on emulate-on-write in OVMF for private
> MMIO (seems like it never would have worked properly anyway).
> 
> It's possible we still rely on emulate-on-write for writes to shared MMIO
> ranges though. But in that case I don't see why it wouldn't be okay to
> continue to just forward the corresponding write-faults to userspace as
> KVM_EXIT_MMIO events since QEMU can access shared memory just fine.
> 
> It's only the private MMIO that would misbehave because the emulation
> path ... but I'm a little confused on this, because we'd still get #NPFs
> due to the write protection... and it looks like this would trigger a
> KVM_EXIT_MEMORY_FAULT to QEMU... so if QEMU really wanted to catch this
> case... which seems to be the only one that's indicative of misbehavior,
> we could just terminate if the access is to a read-only memslot and we
> are running an ES/SNP guest... so if that's all that's holding us back
> on the kernel side, we could directly start re-advertising
> KVM_CAP_READONLY_MEM, or some new variant of it where userspace needs to
> be aware of these additional considerations for private MMIO.

Right, Sean did suggest a change to do exactly that (send out -EFAULT to 
userspace on writes to RO memslots):
https://lore.kernel.org/kvm/aUq9_cUDWeEW_qli@google.com/

This change kills a KVM_X86_DEFAULT_VM SEV-ES guest if it writes to RO 
memslot. If Sean's change disabling KVM_CAP_READONLY_MEM for SEV-ES 
guests (and the subsequent commit d30d9ee94cc0 ("KVM: x86: Only 
advertise KVM_CAP_READONLY_MEM when supported by VM")) are reverted, 
this results in what you are describing: killing SEV-ES guests that 
write to RO memslot without #NPF loop.

This was discussed in PUCK and my understanding is that Sean is still 
opposed to enabling KVM_CAP_READONLY_MEM for SEV-ES guests (and he has 
written as much in the above mail I have linked to).

Introducing a variant of KVM_CAP_READONLY_MEM might be a good option 
- I suppose Qemu can just check for that capability for encrypted guests 
  and everything else can mostly work as-is.

Sean?

> 
> I think maybe the case that Sean is referencing in his commit, where we
> can't make use of MMIO stub entries to trigger #VC, comes into play 
> when QEMU switches the memory region from romd_mode to !romd_mode, which
> then unmaps the memslot and relies on the noslot MMIO handling. That's
> where private MMIO would stop triggering the (desired) QEMU crash, but
> KVM would catch this too as an #NPF, and this would also be forwarded
> to userspace as a KVM_EXIT_MEMORY_FAULT... so just like the above, if
> we accept that private MMIO is not possible, and only want to actively
> catch it so we can crash the guest or warn... then we can handle this
> the same as above and error if the KVM_EXIT_MEMORY_FAULT is for a
> private access to a GPA range backed by a read-only memslot...

My understanding from Sean's commit is about the romd_mode itself. For 
!romd_mode, we install MMIO SPTEs with reserved bits set, so all 
accesses trap. But, for romd_mode, we can't set reserved bits since we 
want to allow read access, and if reserved bits are not set, there won't 
be a #VC generated and the #NPF will end up being an automatic exit, 
which KVM can't emulate or do anything about, short of punting to 
userspace.

> 
> *maybe* the fault info would need some flag to indicate that this is MMIO
> since we do allow implicit conversions via KVM_EXIT_MEMORY_FAULT in general.
> and userspace might like some way to easily differentiate between the
> good/bad conversions without tracking to much state, but wouldn't that
> work in theory at least?
> 
> Thanks,
> 
> Mike


Thanks,
Naveen


