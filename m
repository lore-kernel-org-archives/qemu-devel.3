Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227C5CCFA1F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 11:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stn9G-0004Md-TJ; Thu, 26 Sep 2024 07:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1stn9F-0004Fa-5f
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 07:59:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1stn9B-00084x-VC
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 07:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727351941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7fcjzsnStZgg3SO4jsGsi7Mw9C58sNDVCW5aPcZdIlY=;
 b=Wzi/5xPeBnwIS6Lp5VLMZkzmyjqPbYjuYy81w3IhMe+oCkX0zuOEIv6riZ1dqFktwNSLP9
 ed+G1hsZbcG31avmt8cSsIcL2ACEZhQQOYCuOysXx6Nt/csOaY9Ry55YndovJuSaZnR5v3
 cFVcfEyC2/2qv5gw73osVHFFq9fg2I8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-kR99Q5bLNM-7vkyxhcKz5g-1; Thu, 26 Sep 2024 07:57:35 -0400
X-MC-Unique: kR99Q5bLNM-7vkyxhcKz5g-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2f8c3c83d4dso8192181fa.2
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 04:57:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727351854; x=1727956654;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7fcjzsnStZgg3SO4jsGsi7Mw9C58sNDVCW5aPcZdIlY=;
 b=Vwy9W2ieY9FwVga6zF9QOVkJtkfSrZMF9qJiizwRwUeru3kbm5UQdRe1C4uWKnLjvI
 i06dFV4lCXmexVkl4huLEpYRynYAJk3lO9fiSPcByA1NlE8vC026n5VlAjkcm0YBvnrM
 UldI9Y2zcj4uwgSE6PyPewmkmKWQD+ifGJmLTM/qSUwKABrMqGDh1yfMWWwM/Fot+Pf3
 ycU/hLGkWdJyr9MWkhsG84G7jOYu0jPIbkMlF1NYwGegBI2AbTHkYGt2S1qRib8xa7kO
 jexlyrCggppcx/n89XTaKU6QMo8QzkguA/rcSQBw0RDPV8TLFyrX6MYQfNtWqcZDp9ZA
 ZRwQ==
X-Gm-Message-State: AOJu0YzUEg3QXTShlefl415QgYBkoJ/v98k9ZW0qmyvDIgCcn7xLfCEo
 ijI7PsbgGsxb1xl4Q6iUyNOEpZC0YCsgxHqSNweV+awyPoXkvpdPf/s5n2ERF/+BdPRode5/wzF
 4H90wAW8IXJDkNFvujIOCDSLxpGzy9s/dJU/R8cvbackI2kWAXIcdCtneq9oI+Nnuim31aEAVOL
 LnKobnnwxMxdTVMpeMXlWCMHsXlF4=
X-Received: by 2002:a2e:a54d:0:b0:2f1:a30c:cd15 with SMTP id
 38308e7fff4ca-2f91ca59247mr39705951fa.36.1727351853725; 
 Thu, 26 Sep 2024 04:57:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhR3vP5Rd2CBWNrLfSxVs94dhfltxnc+0g7/oVHFMr1efFDIHUfeKtcx1+ZnyJtIcUXm6HlfF+f+eH7DYPRvI=
X-Received: by 2002:a2e:a54d:0:b0:2f1:a30c:cd15 with SMTP id
 38308e7fff4ca-2f91ca59247mr39705741fa.36.1727351853176; Thu, 26 Sep 2024
 04:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240925153625.183600-1-jusual@redhat.com>
 <20240925153625.183600-2-jusual@redhat.com> <ZvRcPBMYLlczv-3P@x1n>
In-Reply-To: <ZvRcPBMYLlczv-3P@x1n>
From: Julia Suvorova <jusual@redhat.com>
Date: Thu, 26 Sep 2024 13:57:22 +0200
Message-ID: <CAMDeoFX8vKHhV=y+bJUSR27NsShPJSfHW_DjpbPDTEQ5+t3cOw@mail.gmail.com>
Subject: Re: [PATCH 1/2] kvm: Allow kvm_arch_get/put_registers to accept
 Error**
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsuvorov@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 25, 2024 at 8:53=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Sep 25, 2024 at 05:36:22PM +0200, Julia Suvorova wrote:
> > This is necessary to provide discernible error messages to the caller.
> >
> > Signed-off-by: Julia Suvorova <jusual@redhat.com>
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> One nitpick below:
>
> > ---
> >  accel/kvm/kvm-all.c        | 41 +++++++++++++++++++++++++++++---------
> >  include/sysemu/kvm.h       |  4 ++--
> >  target/arm/kvm.c           |  4 ++--
> >  target/i386/kvm/kvm.c      |  4 ++--
> >  target/loongarch/kvm/kvm.c |  4 ++--
> >  target/mips/kvm.c          |  4 ++--
> >  target/ppc/kvm.c           |  2 +-
> >  target/riscv/kvm/kvm-cpu.c |  4 ++--
> >  target/s390x/kvm/kvm.c     |  4 ++--
> >  9 files changed, 47 insertions(+), 24 deletions(-)
> >
> > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > index fe4cd721d9..19e09067b3 100644
> > --- a/accel/kvm/kvm-all.c
> > +++ b/accel/kvm/kvm-all.c
> > @@ -2762,9 +2762,15 @@ void kvm_flush_coalesced_mmio_buffer(void)
> >  static void do_kvm_cpu_synchronize_state(CPUState *cpu, run_on_cpu_dat=
a arg)
> >  {
> >      if (!cpu->vcpu_dirty && !kvm_state->guest_state_protected) {
> > -        int ret =3D kvm_arch_get_registers(cpu);
> > +        Error *err =3D NULL;
> > +        int ret =3D kvm_arch_get_registers(cpu, &err);
> >          if (ret) {
> > -            error_report("Failed to get registers: %s", strerror(-ret)=
);
> > +            if (err) {
> > +                error_report_err(err);
> > +            } else {
> > +                error_report("Failed to get registers: %s", strerror(-=
ret));
> > +            }
> > +
> >              cpu_dump_state(cpu, stderr, CPU_DUMP_CODE);
> >              vm_stop(RUN_STATE_INTERNAL_ERROR);
> >          }
> > @@ -2782,9 +2788,15 @@ void kvm_cpu_synchronize_state(CPUState *cpu)
> >
> >  static void do_kvm_cpu_synchronize_post_reset(CPUState *cpu, run_on_cp=
u_data arg)
> >  {
> > -    int ret =3D kvm_arch_put_registers(cpu, KVM_PUT_RESET_STATE);
> > +    Error *err =3D NULL;
> > +    int ret =3D kvm_arch_put_registers(cpu, KVM_PUT_RESET_STATE, &err)=
;
> >      if (ret) {
> > -        error_report("Failed to put registers after reset: %s", strerr=
or(-ret));
> > +        if (err) {
> > +            error_reportf_err(err, "Restoring resisters after reset");
>
> IMO it'll be nice to use the same error report pattern, either
> error_report_err() or error_reportf_err() for all the four call sites.
>
> If to use error_reportf_err(), better add comma at the end (e.g. "PREFIX:=
 "
> instead of "PREFIX") to make the print looks slightly better.

Good call, I'll fix it :)

Best regards, Julia Suvorova.

> Thanks!
>
> > +        } else {
> > +            error_report("Failed to put registers after reset: %s",
> > +                         strerror(-ret));
> > +        }
> >          cpu_dump_state(cpu, stderr, CPU_DUMP_CODE);
> >          vm_stop(RUN_STATE_INTERNAL_ERROR);
> >      }
> > @@ -2799,9 +2811,15 @@ void kvm_cpu_synchronize_post_reset(CPUState *cp=
u)
> >
> >  static void do_kvm_cpu_synchronize_post_init(CPUState *cpu, run_on_cpu=
_data arg)
> >  {
> > -    int ret =3D kvm_arch_put_registers(cpu, KVM_PUT_FULL_STATE);
> > +    Error *err =3D NULL;
> > +    int ret =3D kvm_arch_put_registers(cpu, KVM_PUT_FULL_STATE, &err);
> >      if (ret) {
> > -        error_report("Failed to put registers after init: %s", strerro=
r(-ret));
> > +        if (err) {
> > +            error_reportf_err(err, "Putting registers after init");
> > +        } else {
> > +            error_report("Failed to put registers after init: %s",
> > +                         strerror(-ret));
> > +        }
> >          exit(1);
> >      }
> >
> > @@ -2991,10 +3009,15 @@ int kvm_cpu_exec(CPUState *cpu)
> >          MemTxAttrs attrs;
> >
> >          if (cpu->vcpu_dirty) {
> > -            ret =3D kvm_arch_put_registers(cpu, KVM_PUT_RUNTIME_STATE)=
;
> > +            Error *err =3D NULL;
> > +            ret =3D kvm_arch_put_registers(cpu, KVM_PUT_RUNTIME_STATE,=
 &err);
> >              if (ret) {
> > -                error_report("Failed to put registers after init: %s",
> > -                             strerror(-ret));
> > +                if (err) {
> > +                    error_reportf_err(err, "Putting registers after in=
it");
> > +                } else {
> > +                    error_report("Failed to put registers after init: =
%s",
> > +                                 strerror(-ret));
> > +                }
> >                  ret =3D -1;
> >                  break;
> >              }
> > diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> > index 613d3f7581..c3a60b2890 100644
> > --- a/include/sysemu/kvm.h
> > +++ b/include/sysemu/kvm.h
> > @@ -359,7 +359,7 @@ int kvm_arch_handle_exit(CPUState *cpu, struct kvm_=
run *run);
> >
> >  int kvm_arch_process_async_events(CPUState *cpu);
> >
> > -int kvm_arch_get_registers(CPUState *cpu);
> > +int kvm_arch_get_registers(CPUState *cpu, Error **errp);
> >
> >  /* state subset only touched by the VCPU itself during runtime */
> >  #define KVM_PUT_RUNTIME_STATE   1
> > @@ -368,7 +368,7 @@ int kvm_arch_get_registers(CPUState *cpu);
> >  /* full state set, modified during initialization or on vmload */
> >  #define KVM_PUT_FULL_STATE      3
> >
> > -int kvm_arch_put_registers(CPUState *cpu, int level);
> > +int kvm_arch_put_registers(CPUState *cpu, int level, Error **errp);
> >
> >  int kvm_arch_get_default_type(MachineState *ms);
> >
> > diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> > index 849e2e21b3..f1f1b5b375 100644
> > --- a/target/arm/kvm.c
> > +++ b/target/arm/kvm.c
> > @@ -2042,7 +2042,7 @@ static int kvm_arch_put_sve(CPUState *cs)
> >      return 0;
> >  }
> >
> > -int kvm_arch_put_registers(CPUState *cs, int level)
> > +int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
> >  {
> >      uint64_t val;
> >      uint32_t fpr;
> > @@ -2226,7 +2226,7 @@ static int kvm_arch_get_sve(CPUState *cs)
> >      return 0;
> >  }
> >
> > -int kvm_arch_get_registers(CPUState *cs)
> > +int kvm_arch_get_registers(CPUState *cs, Error **errp)
> >  {
> >      uint64_t val;
> >      unsigned int el;
> > diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> > index ada581c5d6..039ed08825 100644
> > --- a/target/i386/kvm/kvm.c
> > +++ b/target/i386/kvm/kvm.c
> > @@ -5118,7 +5118,7 @@ static int kvm_get_nested_state(X86CPU *cpu)
> >      return ret;
> >  }
> >
> > -int kvm_arch_put_registers(CPUState *cpu, int level)
> > +int kvm_arch_put_registers(CPUState *cpu, int level, Error **errp)
> >  {
> >      X86CPU *x86_cpu =3D X86_CPU(cpu);
> >      int ret;
> > @@ -5206,7 +5206,7 @@ int kvm_arch_put_registers(CPUState *cpu, int lev=
el)
> >      return 0;
> >  }
> >
> > -int kvm_arch_get_registers(CPUState *cs)
> > +int kvm_arch_get_registers(CPUState *cs, Error **errp)
> >  {
> >      X86CPU *cpu =3D X86_CPU(cs);
> >      int ret;
> > diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
> > index 4786cd5efa..30ec16025d 100644
> > --- a/target/loongarch/kvm/kvm.c
> > +++ b/target/loongarch/kvm/kvm.c
> > @@ -588,7 +588,7 @@ static int kvm_loongarch_put_cpucfg(CPUState *cs)
> >      return ret;
> >  }
> >
> > -int kvm_arch_get_registers(CPUState *cs)
> > +int kvm_arch_get_registers(CPUState *cs, Error **errp)
> >  {
> >      int ret;
> >
> > @@ -616,7 +616,7 @@ int kvm_arch_get_registers(CPUState *cs)
> >      return ret;
> >  }
> >
> > -int kvm_arch_put_registers(CPUState *cs, int level)
> > +int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
> >  {
> >      int ret;
> >
> > diff --git a/target/mips/kvm.c b/target/mips/kvm.c
> > index a631ab544f..a98798c669 100644
> > --- a/target/mips/kvm.c
> > +++ b/target/mips/kvm.c
> > @@ -1172,7 +1172,7 @@ static int kvm_mips_get_cp0_registers(CPUState *c=
s)
> >      return ret;
> >  }
> >
> > -int kvm_arch_put_registers(CPUState *cs, int level)
> > +int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
> >  {
> >      CPUMIPSState *env =3D cpu_env(cs);
> >      struct kvm_regs regs;
> > @@ -1207,7 +1207,7 @@ int kvm_arch_put_registers(CPUState *cs, int leve=
l)
> >      return ret;
> >  }
> >
> > -int kvm_arch_get_registers(CPUState *cs)
> > +int kvm_arch_get_registers(CPUState *cs, Error **errp)
> >  {
> >      CPUMIPSState *env =3D cpu_env(cs);
> >      int ret =3D 0;
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index 907dba60d1..a361d9d23c 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -900,7 +900,7 @@ int kvmppc_put_books_sregs(PowerPCCPU *cpu)
> >      return kvm_vcpu_ioctl(CPU(cpu), KVM_SET_SREGS, &sregs);
> >  }
> >
> > -int kvm_arch_put_registers(CPUState *cs, int level)
> > +int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
> >  {
> >      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> >      CPUPPCState *env =3D &cpu->env;
> > diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> > index f6e3156b8d..2bfb112be0 100644
> > --- a/target/riscv/kvm/kvm-cpu.c
> > +++ b/target/riscv/kvm/kvm-cpu.c
> > @@ -1192,7 +1192,7 @@ const KVMCapabilityInfo kvm_arch_required_capabil=
ities[] =3D {
> >      KVM_CAP_LAST_INFO
> >  };
> >
> > -int kvm_arch_get_registers(CPUState *cs)
> > +int kvm_arch_get_registers(CPUState *cs, Error **errp)
> >  {
> >      int ret =3D 0;
> >
> > @@ -1237,7 +1237,7 @@ int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, =
int state)
> >      return 0;
> >  }
> >
> > -int kvm_arch_put_registers(CPUState *cs, int level)
> > +int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
> >  {
> >      int ret =3D 0;
> >
> > diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> > index 94181d9281..8ffe0159d8 100644
> > --- a/target/s390x/kvm/kvm.c
> > +++ b/target/s390x/kvm/kvm.c
> > @@ -472,7 +472,7 @@ static int can_sync_regs(CPUState *cs, int regs)
> >  #define KVM_SYNC_REQUIRED_REGS (KVM_SYNC_GPRS | KVM_SYNC_ACRS | \
> >                                  KVM_SYNC_CRS | KVM_SYNC_PREFIX)
> >
> > -int kvm_arch_put_registers(CPUState *cs, int level)
> > +int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
> >  {
> >      CPUS390XState *env =3D cpu_env(cs);
> >      struct kvm_fpu fpu =3D {};
> > @@ -598,7 +598,7 @@ int kvm_arch_put_registers(CPUState *cs, int level)
> >      return 0;
> >  }
> >
> > -int kvm_arch_get_registers(CPUState *cs)
> > +int kvm_arch_get_registers(CPUState *cs, Error **errp)
> >  {
> >      CPUS390XState *env =3D cpu_env(cs);
> >      struct kvm_fpu fpu;
> > --
> > 2.45.0
> >
>
> --
> Peter Xu
>


