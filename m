Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A71E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 19:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLocn-00053M-SW; Thu, 12 Dec 2024 14:13:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3yjVbZwYKCuMXJFSOHLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--seanjc.bounces.google.com>)
 id 1tLocn-00053E-5A
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 14:13:25 -0500
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3yjVbZwYKCuMXJFSOHLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--seanjc.bounces.google.com>)
 id 1tLoch-00023m-Hb
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 14:13:24 -0500
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-725eb1e9139so1429517b3a.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 11:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1734030795; x=1734635595; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=6ftIVrUurcXgbz47VOJZBrN/RkIsB3yO2o5gVSwEAPY=;
 b=A/QaIKjP+zuv/Lx9PYWDw7ot+fBxTWeMGfx0okt/WXrmcgQBKoF6H7j6siQTT+Pa2W
 teA2aiwbH5oXekTf4JGeFuCJtgo7Oe4TnKJ/yOUJJ7Rbp/X/5XeGt/4Y6u2RswQj8AG6
 seMh6YVD84CL4dTzJFVLoSIfORGZgASjmJXOSXs2IzfeN6oFcBOnaMJ+4eTPhhzhoOlj
 YqSOa8hX9zEpmYn1hkhsAltSOgRC3R+fK8va2qlX5W3FmSofKACbWOcqbYgI/d2mpapg
 Uflg1hbXj197Kr2e5jDvDxCkCHJ4Ak9Gh7tOykChe8lAGnifnYnY4n16dEcXBiOfrklt
 B++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734030795; x=1734635595;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6ftIVrUurcXgbz47VOJZBrN/RkIsB3yO2o5gVSwEAPY=;
 b=jsj7wxBI84MXPwRocUNJfO4M0LKQ2w4PVgioRPn+8xUE1CUamz6kdTbaFsHVH1l2Yh
 CIZ4LW5Q96ohB/QOuS9CuoTnV5iKjs3yTTLyW/sk1MPHTXvxbgO0l+zKhfuCTU+xyL12
 ycJswUDQZ7BbAJI1DWHSJWFmnCfq+S3DVDkC6fXmqqG6ea78nnnqtER+3mz6oVEgyxgo
 FgfdbPgX6w9ImDNQsY6hDYagMc2JxOjEIOArkJ2AMgvqs+sduZtIaZ4U220lfT8yEZNJ
 ohbOzMW6sDri7+JtVD094gbCsIq/dYTzsnrMJGibsoJhfaTt5zQQ0LfJvATxzlr9VCZB
 zUgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYCkxZDMa4HLcLPnGiaLGiVcdd2wKYLxd1j/0ktyGnhMHnE7DMGkKIlDsKsj9GWQUwxHrCKfCzcN5v@nongnu.org
X-Gm-Message-State: AOJu0YwO5bKwowV50ZDg0LuH4LzlcxjkhKtRmjWvHUyEtBxoVGZ5Sqnz
 nxz4tD+n51F5RhTFUVeY3NrRfv4Eky4QpIZ10rrJkDGEHvGVz6kiWwAchRZgriXODUbt7bD5y7B
 vKA==
X-Google-Smtp-Source: AGHT+IF/aSjkRAiUPE7prVrWmTY9lJSRlT0SoFYjGPreKIZ7z0XPtDKtWZqE+xUKFKN++gtnigcObWThIsU=
X-Received: from pfvf8.prod.google.com ([2002:a05:6a00:1ac8:b0:725:d24b:1b95])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:84c:b0:725:eacf:cfdb
 with SMTP id d2e1a72fcca58-72906f4b6demr2262010b3a.24.1734030794662; Thu, 12
 Dec 2024 11:13:14 -0800 (PST)
Date: Thu, 12 Dec 2024 11:13:13 -0800
In-Reply-To: <1a5e2988-9a7d-4415-86ad-8a7a98dbc5eb@redhat.com>
Mime-Version: 1.0
References: <20241212032628.475976-1-binbin.wu@linux.intel.com>
 <Z1qZygKqvjIfpOXD@intel.com> <1a5e2988-9a7d-4415-86ad-8a7a98dbc5eb@redhat.com>
Message-ID: <Z1s1yeWKnvmh718N@google.com>
Subject: Re: [PATCH] i386/kvm: Set return value after handling
 KVM_EXIT_HYPERCALL
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>,
 xiaoyao.li@intel.com, 
 qemu-devel@nongnu.org, michael.roth@amd.com, rick.p.edgecombe@intel.com, 
 isaku.yamahata@intel.com, farrah.chen@intel.com, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=2607:f8b0:4864:20::44a;
 envelope-from=3yjVbZwYKCuMXJFSOHLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--seanjc.bounces.google.com;
 helo=mail-pf1-x44a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
> On 12/12/24 09:07, Zhao Liu wrote:
> > On Thu, Dec 12, 2024 at 11:26:28AM +0800, Binbin Wu wrote:
> > > Date: Thu, 12 Dec 2024 11:26:28 +0800
> > > From: Binbin Wu <binbin.wu@linux.intel.com>
> > > Subject: [PATCH] i386/kvm: Set return value after handling
> > >   KVM_EXIT_HYPERCALL
> > > X-Mailer: git-send-email 2.46.0
> > > 
> > > Userspace should set the ret field of hypercall after handling
> > > KVM_EXIT_HYPERCALL.  Otherwise, a stale value could be returned to KVM.
> > > 
> > > Fixes: 47e76d03b15 ("i386/kvm: Add KVM_EXIT_HYPERCALL handling for KVM_HC_MAP_GPA_RANGE")
> > > Reported-by: Farrah Chen <farrah.chen@intel.com>
> > > Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
> > > Tested-by: Farrah Chen <farrah.chen@intel.com>
> > > ---
> > > To test the TDX code in kvm-coco-queue, please apply the patch to the QEMU,
> > > otherwise, TDX guest boot could fail.
> > > A matching QEMU tree including this patch is here:
> > > https://github.com/intel-staging/qemu-tdx/releases/tag/tdx-qemu-upstream-v6.1-fix_kvm_hypercall_return_value
> > > 
> > > Previously, the issue was not triggered because no one would modify the ret
> > > value. But with the refactor patch for __kvm_emulate_hypercall() in KVM,
> > > https://lore.kernel.org/kvm/20241128004344.4072099-7-seanjc@google.com/, the
> > > value could be modified.
> > 
> > Could you explain the specific reasons here in detail? It would be
> > helpful with debugging or reproducing the issue.
> > 
> > > ---
> > >   target/i386/kvm/kvm.c | 8 ++++++--
> > >   1 file changed, 6 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> > > index 8e17942c3b..4bcccb48d1 100644
> > > --- a/target/i386/kvm/kvm.c
> > > +++ b/target/i386/kvm/kvm.c
> > > @@ -6005,10 +6005,14 @@ static int kvm_handle_hc_map_gpa_range(struct kvm_run *run)
> > >   static int kvm_handle_hypercall(struct kvm_run *run)
> > >   {
> > > +    int ret = -EINVAL;
> > > +
> > >       if (run->hypercall.nr == KVM_HC_MAP_GPA_RANGE)
> > > -        return kvm_handle_hc_map_gpa_range(run);
> > > +        ret = kvm_handle_hc_map_gpa_range(run);
> > > +
> > > +    run->hypercall.ret = ret;
> > 
> > ret may be negative but hypercall.ret is u64. Do we need to set it to
> > -ret?
> 
> If ret is less than zero, will stop the VM anyway as
> RUN_STATE_INTERNAL_ERROR.
> 
> If this has to be fixed in QEMU, I think there's no need to set anything
> if ret != 0; also because kvm_convert_memory() returns -1 on error and
> that's not how the error would be passed to the guest.
> 
> However, I think the right fix should simply be this in KVM:
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 83fe0a78146f..e2118ba93ef6 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10066,6 +10066,7 @@ unsigned long __kvm_emulate_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
>  		}
>  		vcpu->run->exit_reason        = KVM_EXIT_HYPERCALL;
> +		vcpu->run->ret                = 0;

		vcpu->run->hypercall.ret

>  		vcpu->run->hypercall.nr       = KVM_HC_MAP_GPA_RANGE;
>  		vcpu->run->hypercall.args[0]  = gpa;
>  		vcpu->run->hypercall.args[1]  = npages;
> 
> While there is arguably a change in behavior of the kernel both with
> the patches in kvm-coco-queue and with the above one, _in practice_
> the above change is one that userspace will not notice.

I agree that KVM should initialize "ret", but I don't think '0' is the right
value.  KVM shouldn't assume userspace will successfully handle the hypercall.
What happens if KVM sets vcpu->run->hypercall.ret to a non-zero value, e.g. -KVM_ENOSYS?

