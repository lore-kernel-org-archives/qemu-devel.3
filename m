Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78619E77182
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 22:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLrP2-0002FA-Mk; Thu, 12 Dec 2024 17:11:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3hl9bZwYKCvMnZVieXbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--seanjc.bounces.google.com>)
 id 1tLrP1-0002El-E3
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 17:11:23 -0500
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3hl9bZwYKCvMnZVieXbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--seanjc.bounces.google.com>)
 id 1tLrOz-0006p4-Nm
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 17:11:23 -0500
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-72467cd273dso1911791b3a.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 14:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1734041478; x=1734646278; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=O8hFG6HST0+xz5AWr8oNcEUA/Zcqg9a67DpfzgQIv1s=;
 b=Xo7mlPQfaOHsaF3i7NaVsxT++FCL0OJk7ApoYXTW9yP17Szg2le6Yr/16SQifB1XFz
 V5tJoW0XQy96eq6Z/dq4s/cmxmyqfYjtv9FNnNDJmQqQR2B1UD7JGWeAtVUnOOOQVhxp
 hJDS5wAmZcCgL3Ta+XWkMQbu1lsqQ6i9ugV6bfd20NZpTQONQEQF/fj9k6P2Oew7DExn
 XrTVQKHWFrx90gtBAaO7QcX2fQ7N9mWOEY2Y5lL+D9j60twVQzknPRHTPpPpzk+GhMWZ
 S941Bwqlj252t+gie08kQxKpo7EL3xeH+cYh6BiBgbaUWpSFkVkBQJjoPUsINQLd58lA
 dIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734041478; x=1734646278;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O8hFG6HST0+xz5AWr8oNcEUA/Zcqg9a67DpfzgQIv1s=;
 b=YDA+CcxPiz9SmG39UoN+Wdud5IQcCv+j+Nrh/I1L4FqfqR3IFD5TsVoj3h7JXcPD0u
 1DGdfcdaFqhTqI1br4R51jfZJULnxwwGA/qrq+XC+wTR7vjAA+mxCYSe/zSmmwEDbduy
 qh+952gDh3ZPfg1cgJBHdNRQU3wcLoA3Q5lVpzH0zxZ070NgcEClF+9CpLAc7PyOKBO3
 Q30RcHdEFVQct0msf/rLsgeKLufKg41hJC9+SULKPR6AmB/AiQRz6IgWJVn9wXN6gQ/n
 ddyboOychCsqWcVegfTkgjD2kjDnCpmb7Kv/LOhUmkXheeeeAjhYHve4hCY/vJWwi6qM
 8bZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzqMs0aEe3MRpga+wj9nFEqTgiiMeTAstHa3M44hfeCkfebAtKnDkGF7QUjh8PIY10k859k/M/zxbE@nongnu.org
X-Gm-Message-State: AOJu0YxbfNSOTRL6GXVUUjDGd5yuzxCdoKxs9o5C8QR3DAunktdBfGzL
 /ajLNbWEPrsOJmKpHyfa4qBTdY/jW+CHzUwSDCmi4ZaUynV7pTn7G2s1dQGrDgSej9e7y2UTR9k
 G6A==
X-Google-Smtp-Source: AGHT+IEYe3oACuEmMt/hCqKoxzL+HdkacaXms03GcWAAvu/hVYwocKnminOiRi57LHIwzOhfSkY+i2gDxzI=
X-Received: from pfde6.prod.google.com ([2002:aa7:8c46:0:b0:725:e37e:7451])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2347:b0:725:f18a:da37
 with SMTP id d2e1a72fcca58-7290c3aee61mr234715b3a.0.1734041478467; Thu, 12
 Dec 2024 14:11:18 -0800 (PST)
Date: Thu, 12 Dec 2024 14:11:16 -0800
In-Reply-To: <5b8f7d63-ef0a-487f-bf9d-44421691fa85@redhat.com>
Mime-Version: 1.0
References: <20241212032628.475976-1-binbin.wu@linux.intel.com>
 <Z1qZygKqvjIfpOXD@intel.com> <1a5e2988-9a7d-4415-86ad-8a7a98dbc5eb@redhat.com>
 <Z1s1yeWKnvmh718N@google.com>
 <5b8f7d63-ef0a-487f-bf9d-44421691fa85@redhat.com>
Message-ID: <Z1tfhPaHruhS3teK@google.com>
Subject: Re: [PATCH] i386/kvm: Set return value after handling
 KVM_EXIT_HYPERCALL
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>,
 xiaoyao.li@intel.com, 
 qemu-devel@nongnu.org, michael.roth@amd.com, rick.p.edgecombe@intel.com, 
 isaku.yamahata@intel.com, farrah.chen@intel.com, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=3hl9bZwYKCvMnZVieXbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--seanjc.bounces.google.com;
 helo=mail-pf1-x449.google.com
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

On Thu, Dec 12, 2024, Paolo Bonzini wrote:
> On 12/12/24 20:13, Sean Christopherson wrote:
> > On Thu, Dec 12, 2024, Paolo Bonzini wrote:
> > > If ret is less than zero, will stop the VM anyway as
> > > RUN_STATE_INTERNAL_ERROR.
> > > 
> > > If this has to be fixed in QEMU, I think there's no need to set anything
> > > if ret != 0; also because kvm_convert_memory() returns -1 on error and
> > > that's not how the error would be passed to the guest.
> > > 
> > > However, I think the right fix should simply be this in KVM:
> > > 
> > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > index 83fe0a78146f..e2118ba93ef6 100644
> > > --- a/arch/x86/kvm/x86.c
> > > +++ b/arch/x86/kvm/x86.c
> > > @@ -10066,6 +10066,7 @@ unsigned long __kvm_emulate_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
> > >   		}
> > >   		vcpu->run->exit_reason        = KVM_EXIT_HYPERCALL;
> > > +		vcpu->run->ret                = 0;
> > 
> > 		vcpu->run->hypercall.ret
> > 
> > >   		vcpu->run->hypercall.nr       = KVM_HC_MAP_GPA_RANGE;
> > >   		vcpu->run->hypercall.args[0]  = gpa;
> > >   		vcpu->run->hypercall.args[1]  = npages;
> > > 
> > > While there is arguably a change in behavior of the kernel both with
> > > the patches in kvm-coco-queue and with the above one, _in practice_
> > > the above change is one that userspace will not notice.
> > 
> > I agree that KVM should initialize "ret", but I don't think '0' is the right
> > value.  KVM shouldn't assume userspace will successfully handle the hypercall.
> > What happens if KVM sets vcpu->run->hypercall.ret to a non-zero value, e.g. -KVM_ENOSYS?
> 
> Unfortunately QEMU is never writing vcpu->run->hypercall.ret, so the guest
> sees -KVM_ENOSYS; this is basically the same bug that Binbin is fixing, just
> with a different value passed to the guest.
> 
> In other words, the above one-liner is pulling the "don't break userspace"
> card.

But how is anything breaking userspace?  QEMU needs to opt-in to intercepting
KVM_HC_MAP_GPA_RANGE, and this has been KVM's behavior since commit 0dbb11230437
("KVM: X86: Introduce KVM_HC_MAP_GPA_RANGE hypercall").

Ah, "ret" happens to be deep in the union and KVM zero allocates vcpu->run, so
QEMU gets lucky and "ret" happens to be zero because no other non-fatal userspace
exit on x86 happens to need as many bytes.  Hilarious.

FWIW, if TDX marshalls hypercall state into KVM's "normal" registers, then KVM's
shenanigans with vcpu->run->hypercall.ret might go away?  Though regardless of
what happens on that front, I think it makes to explicitly initialize "ret" to
*something*.

I checked our VMM, and it does the right thing, so I don't have any objection
to explicitly zeroing "ret".  Though it needs a comment explaining that it's a
terrible hack for broken userspace ;-)

