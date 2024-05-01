Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE09C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 15:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2C9W-0007ld-4W; Wed, 01 May 2024 11:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2C9Q-0007lH-Vn
 for qemu-devel@nongnu.org; Wed, 01 May 2024 11:45:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2C9I-0000ti-KF
 for qemu-devel@nongnu.org; Wed, 01 May 2024 11:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714578334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wy3VUWSRVNutg4GX65RHmitdH7ZXND2jPkSiioTqETQ=;
 b=TzWAJnw/LSdrL0TOR/54RheHqn/iwpWL2vH1vDqUMf2KSi7Fn7mws87c/yrTClTOFR4ucd
 wtzwJFjneIl+096ed4q8CnOXFDMVbYZ+LAwMQhf11CINEd8DrNM4J/CmSo0zdTLGy2oOtK
 z/mThbG4X/jl/Xhc/oxlV6+mNl2agEE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-LTcZCeD1N7qxO3cjddRWeA-1; Wed, 01 May 2024 11:45:33 -0400
X-MC-Unique: LTcZCeD1N7qxO3cjddRWeA-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2b072271f2cso832116a91.3
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 08:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714578332; x=1715183132;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wy3VUWSRVNutg4GX65RHmitdH7ZXND2jPkSiioTqETQ=;
 b=ed3Ey+Zy04/V8aXrp+WrP1aHsZApb3/APrQKrndg/h8WTAAzVC8tE3iEsDJFtNCB30
 0k2Sq53rHxlMHqwVF+bef3HyR6DYiAfxX3oQ9i0CkPJIq3Mx42yXSFUa8mpji6TZYsIZ
 5DXfx4vNrQ065nKsZhFX4GZuY673RcGqWdKxnASyUKo27lPS7LFfL0BFhQnFXDnurmiK
 z8h5JEAa2tE4dC/mIw0zOIm4us21ZKvolRftlVekusJjO4sCKmpQPI8MOcpHscSpFsXB
 iBD7C4bVkYsfaQYaKUeqwwzkRJNnhbvHiD6eHj2sZEcIVx15DSoDj6POaZP1I9xOaGTP
 ZJyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXrgq4MygDrZuSQTEtr6tHnoqyVrLh5bRV/3PQcoYZrE8nG9yI8rECuD3Eiqan12v9paRSgq3ORqSsrjuowDc1NVNRBlY=
X-Gm-Message-State: AOJu0YyY9iP3gvK0mQYUj7BEEl2ho0nlBSCXIUtsnPIg1H2pOi7ZfUQ6
 b8GuOdWjPkDD2XyHKbtcRmhPQ060RJ4hzw4QfRt7T+EgoFqVeRhRk6VVLHJP+ItbcA+HCrj2bW6
 uExVVIwxaMuh9r4xpCrNZzWZtgk+2ncervtaWN3M7S90DYyUmIto6
X-Received: by 2002:a17:90b:15c6:b0:2a5:3f1f:a1d1 with SMTP id
 lh6-20020a17090b15c600b002a53f1fa1d1mr2852728pjb.0.1714578331853; 
 Wed, 01 May 2024 08:45:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXgDFgq68YqkKirMYBdO3mwI80BI4hMe4Gnp8wUhIL7FL8VhE7KsElAd6jCJvY7ygG/2bXsQ==
X-Received: by 2002:a17:90b:15c6:b0:2a5:3f1f:a1d1 with SMTP id
 lh6-20020a17090b15c600b002a53f1fa1d1mr2852684pjb.0.1714578331148; 
 Wed, 01 May 2024 08:45:31 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 pb11-20020a17090b3c0b00b002a2dbbbb36asm1484834pjb.37.2024.05.01.08.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 08:45:30 -0700 (PDT)
Date: Wed, 1 May 2024 11:45:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org,
 Tianrui Zhao <zhaotianrui@loongson.cn>, pbonzini@redhat.com,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 maobibo@loongson.cn, lixianglai@loongso.cn
Subject: Re: [PATCH] target/loongarch/kvm: Fix VM recovery from disk failures
Message-ID: <ZjJjl2fIU1s24uFD@x1n>
References: <20240430012356.2620763-1-gaosong@loongson.cn>
 <f9956c18-3530-4fc2-8150-beba7b673f89@linaro.org>
 <87edanlzlz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87edanlzlz.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.897,
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

On Tue, Apr 30, 2024 at 11:00:24AM -0300, Fabiano Rosas wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
> > (Cc'ing migration maintainers)
> >
> > On 30/4/24 03:23, Song Gao wrote:
> >> vmstate does not save kvm_state_conter,
> >> which can cause VM recovery from disk to fail.
> >
> > Cc: qemu-stable@nongnu.org
> > Fixes: d11681c94f ("target/loongarch: Implement kvm_arch_init_vcpu")
> >
> >> Signed-off-by: Song Gao <gaosong@loongson.cn>
> >> ---
> >>   target/loongarch/machine.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >> 
> >> diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
> >> index c7029fb9b4..4cd1bf06ff 100644
> >> --- a/target/loongarch/machine.c
> >> +++ b/target/loongarch/machine.c
> >> @@ -191,6 +191,8 @@ const VMStateDescription vmstate_loongarch_cpu = {
> >>           VMSTATE_STRUCT_ARRAY(env.tlb, LoongArchCPU, LOONGARCH_TLB_MAX,
> >>                                0, vmstate_tlb, LoongArchTLB),
> >>   
> >> +        VMSTATE_UINT64(kvm_state_counter, LoongArchCPU),
> >> +
> >>           VMSTATE_END_OF_LIST()
> >>       },
> >>       .subsections = (const VMStateDescription * const []) {
> >
> > The migration stream is versioned, so you should increase it,
> > but this field is only relevant for KVM (it shouldn't be there
> > in non-KVM builds). IMHO the correct migration way to fix that
> > is (untested):
> >
> > -- >8 --
> > diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
> > index c7029fb9b4..08032c6d71 100644
> > --- a/target/loongarch/machine.c
> > +++ b/target/loongarch/machine.c
> > @@ -8,8 +8,27 @@
> >   #include "qemu/osdep.h"
> >   #include "cpu.h"
> >   #include "migration/cpu.h"
> > +#include "sysemu/kvm.h"
> >   #include "vec.h"
> >
> > +#ifdef CONFIG_KVM
> > +static bool kvmcpu_needed(void *opaque)
> > +{
> > +    return kvm_enabled();
> > +}
> > +
> > +static const VMStateDescription vmstate_kvmtimer = {
> > +    .name = "cpu/kvmtimer",
> > +    .version_id = 1,
> > +    .minimum_version_id = 1,
> > +    .needed = kvmcpu_needed,
> > +    .fields = (const VMStateField[]) {
> > +        VMSTATE_UINT64(kvm_state_counter, LoongArchCPU),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +#endif /* CONFIG_KVM */
> > +
> >   static const VMStateDescription vmstate_fpu_reg = {
> >       .name = "fpu_reg",
> >       .version_id = 1,
> > @@ -194,6 +213,9 @@ const VMStateDescription vmstate_loongarch_cpu = {
> >           VMSTATE_END_OF_LIST()
> >       },
> >       .subsections = (const VMStateDescription * const []) {
> > +#ifdef CONFIG_KVM
> > +        &vmstate_kvmcpu,
> > +#endif
> >           &vmstate_fpu,
> >           &vmstate_lsx,
> >           &vmstate_lasx,
> > ---
> 
> LGTM, I'd just leave only the .needed function under CONFIG_KVM instead
> of the whole subsection.

But when !KVM it means there's no ".needed" and it'll still be migrated?

IMHO it depends on whether loongarch is in the state already of trying to
keep its ABI at all.  I think we should still try to enjoy the time when
that ABI is not required, then we can simply add whatever fields, and let
things break with no big deal.

Note that if with CONFIG_KVM it means it can break migration between kvm
v.s. tcg when only one qemu enabled kvm when compile.  Considering the
patch is from the maintainer (which seems to say "breaking that is all
fine!") I'd say the original patch looks good actually, as it allows kvm /
tcg migrations too as a baseline.

Thanks,

-- 
Peter Xu


