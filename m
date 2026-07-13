Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0805BC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 22:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjPNx-0000Oy-Bg; Mon, 13 Jul 2026 18:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wjPNv-0000Oi-6P
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 18:44:23 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wjPNt-0003gP-97
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 18:44:22 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-84a2c90e383so291608b3a.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 15:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783982659; x=1784587459; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LgcBlPclbkMdbp/HtCXTu51Kc/xPI2S2dvfoAEfAMNM=;
 b=q9YWIdnIjpolD3h27FlGF4kg5T4lJ/zBASnjK0MyFDVCvnv1DnlPap/PelQkghu3w2
 NkRDWf3KPrB9W6tQHyiUASRecPsKJ/xaXpV6D3sGCwxNtUyvW3Q1fDj5a4iJzlPOJl6E
 K9EkOfongAOwCWz22diJ+QGOSifTpeLVAvtA0SftqEW2tui1gTN6L4/NHUFU4AF6h80Q
 qlSICvznxBbGj/Ue8Nxj/2SXXRN98XWHSpjP7HRMNubiBP9P/D6bOsahC0Z3ODQ/ZFA3
 qRPzuk1c4NB5bZSZ9aOW28loirkQrWNddSBrXWZdxXZpZjHrwxN1uJhmGHOvR/Q6APLs
 XGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783982659; x=1784587459;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LgcBlPclbkMdbp/HtCXTu51Kc/xPI2S2dvfoAEfAMNM=;
 b=WgWTvMgLckENz6nnVUsxjIq2o7Hlb6TE3Z0XV9IwIqzw2/HeJDNDNwMNsZGrETtu3K
 EkD4C4GuOezvY/Cnqrv7DBxIDQIlPsdkXqMmo1L6x2weLgN1AcAsCmaske25ev5lFqKA
 ku1dxVoaHd1iGYcBWzLSm9DWCy7PIGen4Jxe5Pg9YERdEP4UNNnpfhWw04KdGnCIIWxw
 /Z2z2p9HWCto7aTdLr/CFXMwc3Q5FqTUjaxpXJ4DiKU392Z7GZCioJ2BhwZ2pdjRG48f
 n/QAGBK3xwWKPUx6KR8FagQAXevbAFBxCO1XO0b/7K5GeJ0sgZVM/aE3BNLA2XxuGT9V
 4xhg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp8UCgptGAoWPErQPxryLwC44dwnIUf4X4VZNdLQ7U5gio+i4MWV2KpuFxvewH4xTeyxDzZKPg5n/tk@nongnu.org
X-Gm-Message-State: AOJu0YycSwrNup87sNpI45ShqGc8XtH9ILTh8/7cSbfMc1OgCCqtLcR5
 ZDrA+HdZaLTRFL1PNtDymqlw+YDNKA4FsnqLM05QEnx+pqcdZsUWH/Ow8QMI1Z3m1hM=
X-Gm-Gg: AfdE7cmOjIGfe7UBCm+PBJ80nyaFxYV5LzG9s5WuFnb6I0BAa2dyP0InLeqPtfQG5IP
 Ofvl+fjdmusiM5dE4JRmeMQEbLeB69Asmlyzw3QwMdWN1UHQuL518x4hAm+zVWbS8kuJf1wdpge
 Xh2m4j1tUHUi7OHT95TL0aUAH7WboE/t8ZOVAQndKh9c7FXjQ6QmOIaEsVf+eb+KNEitwQJafF6
 bhMMQnug769q0tXv8ch8x5ZC01BzeAcUKVflm2ngu849bfZf52j2B5ZnqFWDPZDao55Uez2KrTW
 n8Jcp+Td+B3mZ02FXYpl3J/GA6ryS4jdk3G8uFEXDgFdZ0EgqmNkCFhAFakAH601xnn9puRzx/C
 oVS124yGWw/PfZ/oRcg5/WlYPwqNp/tSzl9ACDArx7qx6Lxp4NjISiKcyhYIgBIqu74uioQU+LD
 t1VTnB3j3BpqQyZgQG
X-Received: by 2002:a05:6a00:2286:b0:845:d2e3:b9c8 with SMTP id
 d2e1a72fcca58-8488acd5302mr8622187b3a.28.1783982658927; 
 Mon, 13 Jul 2026 15:44:18 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:3ead:2a56:27bf:77cb])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84a4f238f75sm464398b3a.9.2026.07.13.15.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 15:44:18 -0700 (PDT)
Date: Mon, 13 Jul 2026 16:44:15 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 eblake@redhat.com, armbru@redhat.com, jpb@kernel.org,
 lorenzo.pieralisi@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v1 04/25] target/arm/kvm-rme: Add mechanic to initialize
 realms
Message-ID: <alVqP3H9N5Hh5jyF@p14s>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-5-mathieu.poirier@linaro.org>
 <618fa1ec-c986-4075-9b6f-c720b48d75ce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <618fa1ec-c986-4075-9b6f-c720b48d75ce@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Jul 13, 2026 at 03:14:05PM +1000, Gavin Shan wrote:
> On 7/8/26 8:42 AM, Mathieu Poirier wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > Initialise an @rme_guest object and install a handler to get notified
> > when the Realm is ready to start.  That way we can finish reading the
> > Realm once we know everything is in place.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   target/arm/kvm-rme.c  | 50 +++++++++++++++++++++++++++++++++++++++++++
> >   target/arm/kvm-stub.c |  5 +++++
> >   target/arm/kvm.c      |  7 +++++-
> >   target/arm/kvm_arm.h  |  9 ++++++++
> >   4 files changed, 70 insertions(+), 1 deletion(-)
> > 
> > diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> > index 42e1d1e7b859..b86b9d6a25cb 100644
> > --- a/target/arm/kvm-rme.c
> > +++ b/target/arm/kvm-rme.c
> > @@ -13,6 +13,7 @@
> >   #include "kvm_arm.h"
> >   #include "migration/blocker.h"
> >   #include "qapi/error.h"
> > +#include "qemu/error-report.h"
> >   #include "qom/object_interfaces.h"
> >   #include "system/confidential-guest-support.h"
> >   #include "system/kvm.h"
> > @@ -29,14 +30,63 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> >                                             CONFIDENTIAL_GUEST_SUPPORT,
> >                                             { TYPE_USER_CREATABLE }, { })
> > +static RmeGuest *rme_guest;
> > +
> > +static void rme_vm_state_change(void *opaque, bool running, RunState state)
> > +{
> > +    if (!running) {
> > +        return;
> > +    }
> > +
> > +    kvm_mark_guest_state_protected();
> > +}
> > +
> >   static void rme_guest_class_init(ObjectClass *oc, const void *data)
> >   {
> >   }
> >   static void rme_guest_init(Object *obj)
> >   {
> > +    if (rme_guest) {
> > +        error_report("a single instance of RmeGuest is supported");
> > +        exit(1);
> > +    }
> > +    rme_guest = RME_GUEST(obj);
> >   }
> >   static void rme_guest_finalize(Object *obj)
> >   {
> >   }
> > +
> > +int kvm_arm_rme_init(MachineState *ms, KVMState *s)
> > +{
> > +    static Error *rme_mig_blocker;
> > +    ConfidentialGuestSupport *cgs = ms->cgs;
> > +
> > +    if (!rme_guest) {
> > +        return 0;
> > +    }
> > +
> > +    if (!cgs) {
> > +        error_report("missing -machine confidential-guest-support parameter");
> > +        return -EINVAL;
> > +    }
> > +
> > +    if (!kvm_vm_check_extension(s, KVM_CAP_ARM_RMI)) {
> > +        error_report("KVM doesn't support Realms");
> > +        return -ENODEV;
> > +    }
> > +
> > +    error_setg(&rme_mig_blocker, "RME: migration is not implemented");
> > +    migrate_add_blocker(&rme_mig_blocker, &error_fatal);
> > +
> > +    /*
> > +     * The realm activation is done last, when the VM starts, after all images
> > +     * have been loaded and all vcpus finalized.
> > +     */
> > +    qemu_add_vm_change_state_handler(rme_vm_state_change, NULL);
> > +
> > +    cgs->require_guest_memfd = true;
> > +    cgs->ready = true;
> > +    return 0;
> > +}
> 
> I think it's more reasonable to set ConfidentialGuestSupportClass::kvm_init to
> kvm_arm_rme_init in rme_guest_class_init(). confidential_guest_kvm_init()
> gets called in target/arm/kvm.c::kvm_arch_init(). With this, the pattern matches
> with that for x86.

I agree, it would be nice to align Arm with the other architectures that
support confidential guests.  Let me see what I can do.

Thanks for the review, I'll look at your other comment tomorrow.

Mathieu

> 
> More details can be found from commit 631a2ac5a4be ("i386/tdx: Implement tdx_kvm_init()
> to initialize TDX VM context").
> 
> Thanks,
> Gavin
> 
> > diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
> > index 88cbe8d85c41..eec1ca3dd2e5 100644
> > --- a/target/arm/kvm-stub.c
> > +++ b/target/arm/kvm-stub.c
> > @@ -119,3 +119,8 @@ char *kvm_print_register_name(uint64_t regidx)
> >   {
> >       g_assert_not_reached();
> >   }
> > +
> > +int kvm_arm_rme_init(MachineState *ms, KVMState *s)
> > +{
> > +    g_assert_not_reached();
> > +}
> > diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> > index ed99be7fd80c..28d5643d6779 100644
> > --- a/target/arm/kvm.c
> > +++ b/target/arm/kvm.c
> > @@ -660,7 +660,12 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
> >       hw_breakpoints = g_array_sized_new(true, true,
> >                                          sizeof(HWBreakpoint), max_hw_bps);
> > -    return 0;
> > +    ret = kvm_arm_rme_init(ms, s);
> > +    if (ret) {
> > +        error_report("Failed to enable RME: %s", strerror(-ret));
> > +    }
> > +
> > +    return ret;
> >   }
> >   unsigned long kvm_arch_vcpu_id(CPUState *cpu)
> > diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> > index e7c40fb003e4..6d058b0e08a2 100644
> > --- a/target/arm/kvm_arm.h
> > +++ b/target/arm/kvm_arm.h
> > @@ -240,4 +240,13 @@ void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3);
> >    */
> >   char *kvm_print_register_name(uint64_t regidx);
> > +/**
> > + * kvm_arm_rme_init
> > + * @ms: the machine state
> > + * @s: State of KVM
> > + *
> > + * Prepare the machine to be a Realm, if the user enabled it.
> > + */
> > +int kvm_arm_rme_init(MachineState *ms, KVMState *s);
> > +
> >   #endif
> 

