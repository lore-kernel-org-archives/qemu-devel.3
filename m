Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DD9CD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 16:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXi05-000782-G3; Thu, 11 Jun 2026 12:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3JN4qagYKCuMXJFSOHLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--seanjc.bounces.google.com>)
 id 1wXi02-00077c-Gg
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 12:11:23 -0400
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3JN4qagYKCuMXJFSOHLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--seanjc.bounces.google.com>)
 id 1wXhzz-0001hh-Vl
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 12:11:21 -0400
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-36bba9b849dso59427a91.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 09:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781194277; x=1781799077; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=VAhuLqyDn4y87Nrawd5bOjFYnqraA/wl7PaPEa9yl8I=;
 b=TNoChEffVnmPXLtilp2QY5OcGw48CeWbifiUCH8X0Lp5bdQdhdvlOB1N+juWcArRva
 LStIJBikxPubn1sIi8pENZ0b8zlck7ramxdjTBwzdShPBYfEPuyIWch6BIacSs2DqRxC
 je5cZV+IqHHSWIa50HPP/jhmDxIxOzLqun+z9EKHEVuxcv/80P317482J+ToUXNtw+Kp
 E1QdCFyAzpc84EU5St8/vmWFj3rLNZ7QvCzhk6kbaAOc6bV0Er51lWyLLjgiyS4xZ+Yd
 uh6BAzmJvtiRSnq6I3Z2dXWo371KgSiFy5SDSo1kN+f8m8Dc82CjOWM2og0D9NDaeBd7
 Xz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781194277; x=1781799077;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VAhuLqyDn4y87Nrawd5bOjFYnqraA/wl7PaPEa9yl8I=;
 b=I4xnNkJ89tEPxWt+OCCUsa5FM1Vx7HePcvymzMk0NrfiktZ+xXKb51TxSEPBnSCccK
 Aktf2bicxg1Ofl714SKCuDXTz/LoXE/Oew7Ih8ErYx09MiSdLS5410kvf34UkajWL+TQ
 yzgzedLVjGqHX+OEt4Esg5uwQhmJNyqtkutWaP5eRzP9DJt8ysb9LRtFJb2tdXukUoHV
 OzBNJnKiaCSGWSR4edzp/A0J5HwhKygAqM/t8+gpSIni9DTqKEI0mC4b8hIEbW6j0ZLC
 auAVXwn1r15tqcolXUiqSkOwOrEClaH5EE+1YoRrsxJ9ghF5WbVb4XwOhJCrxxyKQEsu
 hwEQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8H15p/AqcjuzXJjyo2gEvp7yjnBrEjmFKrB/SfvV198YL8iglAjZ2m+KlUfwqxfb2dWx1eD1lHIyTs@nongnu.org
X-Gm-Message-State: AOJu0YzBhMcZo/QY3D3yurNykQu32w5NefWyB4MgUTsDJ0iPkfVaGUiu
 z/+boHKbDBFl6OSAcAbjJZxW5zB37aRYSMPFk6dMcKGm+XajJ4/P2YqDchupKhWIk6yOchSmREh
 jNZUhYA==
X-Received: from pgjn24.prod.google.com ([2002:a63:e058:0:b0:c7d:a2e8:5b54])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3d91:b0:368:a297:bd3d
 with SMTP id 98e67ed59e1d1-3779bade859mr4235946a91.3.1781194276780; Thu, 11
 Jun 2026 09:11:16 -0700 (PDT)
Date: Thu, 11 Jun 2026 09:11:16 -0700
In-Reply-To: <aiqWjTxzTeyeDyZp@blrnaveerao1>
Mime-Version: 1.0
References: <20260602071213.2084388-1-naveen@kernel.org>
 <b7xwzrdt4zg5g45ufhqj46d3f4uezpy733gnsc7bv4cploxevz@rw327aciq2cg>
 <ailAARL2xS7qSNzL@blrnaveerao1> <88d332b0-8756-444a-9d32-53299a0ebfa8@amd.com>
 <mlvawqkbrcucfylk3cigfs3fnh37njaea3l3hvt3dnu5xl73am@x6ixj57thfjk>
 <aiqWjTxzTeyeDyZp@blrnaveerao1>
Message-ID: <aireJOVp7VZcQ1vF@google.com>
Subject: Re: [RFC PATCH] target/i386: SEV: Allow pflash devices with SEV-ES
 guests
From: Sean Christopherson <seanjc@google.com>
To: Naveen N Rao <naveen@kernel.org>
Cc: Michael Roth <michael.roth@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 "Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?=" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Nikunj A Dadhania <nikunj@amd.com>, Roy Hopkins <roy.hopkins@randomman.co.uk>, 
 Srikanth Aithal <srikanth.aithal@amd.com>, Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3JN4qagYKCuMXJFSOHLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--seanjc.bounces.google.com;
 helo=mail-pj1-x1049.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

On Thu, Jun 11, 2026, Naveen N Rao wrote:
> On Wed, Jun 10, 2026 at 02:33:20PM -0500, Michael Roth wrote:
> > > > Right, normal well-behaved SEV-ES/SNP guests work just fine as they 
> > > > don't write to any of the read-only areas.
> > > 
> > > Yes they do. There is specific support to make a direct GHCB MMIO
> > > request because of the lack of the #VC exception (see
> > > OvmfPkg/QemuFlashFvbServicesRuntimeDxe/QemuFlashDxe.c).
> 
> Good to know!
> 
> > With that change in place, it seems like we don't have remaining guest-side
> > code for ES/SNP guests that relies on emulate-on-write in OVMF for private
> > MMIO (seems like it never would have worked properly anyway).
> > 
> > It's possible we still rely on emulate-on-write for writes to shared MMIO
> > ranges though. But in that case I don't see why it wouldn't be okay to
> > continue to just forward the corresponding write-faults to userspace as
> > KVM_EXIT_MMIO events since QEMU can access shared memory just fine.
> > 
> > It's only the private MMIO that would misbehave because the emulation
> > path ... but I'm a little confused on this, because we'd still get #NPFs
> > due to the write protection... and it looks like this would trigger a
> > KVM_EXIT_MEMORY_FAULT to QEMU... so if QEMU really wanted to catch this
> > case... which seems to be the only one that's indicative of misbehavior,
> > we could just terminate if the access is to a read-only memslot and we
> > are running an ES/SNP guest... so if that's all that's holding us back
> > on the kernel side, we could directly start re-advertising
> > KVM_CAP_READONLY_MEM, or some new variant of it where userspace needs to
> > be aware of these additional considerations for private MMIO.
> 
> Right, Sean did suggest a change to do exactly that (send out -EFAULT to 
> userspace on writes to RO memslots):
> https://lore.kernel.org/kvm/aUq9_cUDWeEW_qli@google.com/
> 
> This change kills a KVM_X86_DEFAULT_VM SEV-ES guest if it writes to RO 
> memslot. If Sean's change disabling KVM_CAP_READONLY_MEM for SEV-ES 
> guests (and the subsequent commit d30d9ee94cc0 ("KVM: x86: Only 
> advertise KVM_CAP_READONLY_MEM when supported by VM")) are reverted, 
> this results in what you are describing: killing SEV-ES guests that 
> write to RO memslot without #NPF loop.
> 
> This was discussed in PUCK and my understanding is that Sean is still 
> opposed to enabling KVM_CAP_READONLY_MEM for SEV-ES guests (and he has 
> written as much in the above mail I have linked to).
> 
> Introducing a variant of KVM_CAP_READONLY_MEM might be a good option 
> - I suppose Qemu can just check for that capability for encrypted guests 
>   and everything else can mostly work as-is.
> 
> Sean?

If you're ok terminating the guest, just map the memory as read-only in the VMA
so that faulting in the PFN fails with KVM_PFN_ERR_FAULT => -EFAULT.

If we also need to support guest_memfd, then I would prefer to add support for
RWX memory attributes (per-VM), which are allegedly being working on by Amazon
and/or Microsoft for VBS(-like) support in KVM.

https://lore.kernel.org/all/Y1a1i9vbJ%2FpVmV9r@google.com

