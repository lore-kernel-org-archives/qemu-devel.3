Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F1CD1713F
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 21:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t30Io-0000Tk-4w; Mon, 21 Oct 2024 17:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1t30Ij-0000Sm-VY
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 17:50:58 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1t30Ig-0006sG-64
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 17:50:57 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a9a0472306cso669231466b.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 14:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1729547452; x=1730152252; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jzRd+28RgNdAiAza9BnKC0jKiQQBoobdnl+vVV+OMwU=;
 b=MrQTugktYcciUzK+y8+eGabTupFIuiUJEJKf3iyqxyd0pgKFvKUyaTmwWQbXQoDvkZ
 sovytod8yMHkuNYJ4EeuU9eisfInUzJyrk5elJ1GMAsJv3GEfyu2/t5oykwySx81rBrR
 urv2CxzTje0qiMDeDl7TtXiEfHzOXffP3FhHVUB9ZYXXHOIyBI51cqocWpMFw6a4HXy4
 xuxuakR10y7VepUgF1Fal/42n9oNRZCOIH2ckEHWuyqZxANgbbYx+Ok1UuyAvfI9SSF6
 BEm+1UE1uv7NC70s7TW+Y7lwsmRUal2sKE5L+1/TI/6KfjEyTxuebxcBgeJ+68JavL0a
 Qvbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729547452; x=1730152252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jzRd+28RgNdAiAza9BnKC0jKiQQBoobdnl+vVV+OMwU=;
 b=jT5l8p+sfahMv/2mEjKo2KGgt4TtSOiNoDv9m7zVp5+53dX/DsevQX1ColGiqexHQS
 Luqe80RSHOkgIrkF+8APhTLEJh8DAQ2S0f33lbQXQGTaEDlddJ4xZnTwkPj2TKKqDn5x
 cfYrE2K1M+LWuhgNRhDkssDRQhjLyeAsfL5iTO9IZYnJUtfMQkxDVw3Ka/61zQTz5QuT
 M3lTnNjZ3xjeM8WTsppLrXXPpw0nNbxJA3du0gMZZ2fCmcGiwk4dixlvhW50PF6xB4Hq
 zylqcn9SYT3F4iiY8mMkXDeRLdrUXhqGqs7o6SkaxIn9MT9pJ8nci+7ckP312sYajWVl
 YHZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhUIhfLpct0vJrDJLic7Z4eyFzYl2qclyyDMAa4tFv/yfYBrUYeM84/6yChENZ8mCQ374Jo2L1ZwtN@nongnu.org
X-Gm-Message-State: AOJu0YzVmvcpLqDLMS6KpAQJzSJgKpX/9SepiDR6LKBUORtdhtpmxTY/
 0POgCO4wTL0DaQs10ZCwA4F57/T3w2rSyAFPTWKdWJABZWXjjTCCOVXGy7KsO4MxlvxPx5SZyU7
 m30TohAqIkgF0rRA/L21oOgCJXmb9cfivDmLssQ==
X-Google-Smtp-Source: AGHT+IF9WRLaJtqZZSd8amgSkm8wnWKghT9WgQliy6RTA969DC6QPWyvmWB8ZJMKOFSu0cQlYURdo7sle+vBgC4ZJRs=
X-Received: by 2002:a17:906:dace:b0:a99:e745:d47f with SMTP id
 a640c23a62f3a-a9aace55645mr44739366b.21.1729547451917; Mon, 21 Oct 2024
 14:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <20241014192205.253479-1-salil.mehta@huawei.com>
 <20241014192205.253479-2-salil.mehta@huawei.com>
 <20241018161116.73b12156@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241018161116.73b12156@imammedo.users.ipa.redhat.com>
From: Salil Mehta <salil.mehta@opnsrc.net>
Date: Mon, 21 Oct 2024 22:50:40 +0100
Message-ID: <CAJ7pxebmkChnxUHCVisLSvPT5XYLNo-QV8re0vhWVUbfeOCgaQ@mail.gmail.com>
Subject: Re: [PATCH V1 1/4] hw/acpi: Initialize ACPI Hotplug CPU Status with
 Support for vCPU `Persistence`
To: Igor Mammedov <imammedo@redhat.com>
Cc: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, 
 mst@redhat.com, maz@kernel.org, jean-philippe@linaro.org, 
 jonathan.cameron@huawei.com, lpieralisi@kernel.org, peter.maydell@linaro.org, 
 richard.henderson@linaro.org, andrew.jones@linux.dev, david@redhat.com, 
 philmd@linaro.org, eric.auger@redhat.com, will@kernel.org, ardb@kernel.org, 
 oliver.upton@linux.dev, pbonzini@redhat.com, gshan@redhat.com, 
 rafael@kernel.org, borntraeger@linux.ibm.com, alex.bennee@linaro.org, 
 npiggin@gmail.com, harshpb@linux.ibm.com, linux@armlinux.org.uk, 
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com, 
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com, 
 miguel.luis@oracle.com, zhukeqian1@huawei.com, wangxiongfeng2@huawei.com, 
 wangyanan55@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn, 
 lixianglai@loongson.cn, shahuang@redhat.com, zhao1.liu@intel.com, 
 linuxarm@huawei.com, gustavo.romero@linaro.org
Content-Type: multipart/alternative; boundary="0000000000007e808a062503a5e0"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000007e808a062503a5e0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Igor,

Thanks for taking time to review and sorry for not being prompt. I was in
transit
due to some difficult personal situation.

On Fri, Oct 18, 2024 at 3:11=E2=80=AFPM Igor Mammedov <imammedo@redhat.com>=
 wrote:

> On Mon, 14 Oct 2024 20:22:02 +0100
> Salil Mehta <salil.mehta@huawei.com> wrote:
>
> > Certain CPU architecture specifications [1][2][3] prohibit changes to C=
PU
>                                           ^^^^^^^^^
> these do not point to specs but never mind
>
> > presence after the kernel has booted. This limitation exists because
> many system
> > initializations rely on the exact CPU count at boot time and do not
> expect it to
> > change later. For example, components like interrupt controllers, which
> are
> > closely tied to CPUs, or various per-CPU features, may not support
> configuration
> > changes once the kernel has been initialized. This presents a challenge
> for
> > virtualization features such as vCPU hotplug.
>
> well, x86 (incl cpu,interrupt ctrls) also doesn't have architectural
> hotplug.
> It's just OEM managed to implement it regardless and then bothered to mak=
e
> OS changes to work with that.
> It's just ARM community doesn't want to go there at this point of time
> but using above reasoning as justification for this series doesn't look
> good to me.
>


There is a difference though. vCPU presence cannot be changed after the
system has
initialized in the ARM world due to the Architectural constraint. I think
in the x86 world
it is allowed?


>
> So what ARM would like to support is not CPU hotplug but rather a fixed
> system with standby CPUs (that can be powered on/off on demand).
> With ACPI spec amended to support that (MADT present/enabled changes), it=
's
> good enough reason to add 'enabled' handling to acpi cpu-hotplug code
> instead
> of inventing alternative one that would do almost the same.
>


Not sure what you mean here but this is what is being done.



> But lets get rid of (can't/may not) language above and use standby CPUs
> reasoning
> to avoid any confusion.
>


I've to disagree here. Standy-by means you will have to keep all the vCPUs
states
realized and the objects will always exist. This is a problem for larger
systems
with vCPU hotplug support as it drastically affects the boot times. Please
check
the KVM Forum 2023 slides for objective values.

It's been a long time since this series was actually conceived and at that
time we wanted
to use it for kata containers but later with the gradual adoption of
various microvms
and the cloud hypervisor requirements have bit changed. Boot time still
remains one
of the major requirements. Not bounding boot time while using this feature
will
seriously affect performance if the number of vCPUs increases



>
> PS:
> I'm taking about hw hotplug (at QEMU level) and not kernel hotplug
> (where it's at logical cpu level).
>

sure


>
> > To address this issue, introduce an `is_enabled` state in the
> `AcpiCpuStatus`,
> > which reflects whether a vCPU has been hot-plugged or hot-unplugged in
> QEMU,
> > marking it as (un)available in the Guest Kernel.
> good so far
>
> > The `is_present` state should
> > be set based on the `acpi_persistent` flag. In cases where unplugged
> vCPUs need
> > to be deliberately simulated in the ACPI to maintain a persistent view
> of vCPUs,
> > this flag ensures the guest kernel continues to see those vCPUs.
>
> that's where I have to disagree, vCPU is present when a corresponding QOM
> object
> exists. Faking it's presence will only confuse at the end.
>


Not faking care of it will mean realization  of the unnecessary vCPU
threads during
the VM init time, which in turn will increase the boot time. Trade-off
between more
clean design and performance.


>
> I get that you want to reuse device_add/del interface, but that leads to
> pulling the leg here and there to make thing fit. That in short therm
> (while someone remembers all tricks) might work for some, but long therm
> it's not sustainable).
>


I do not understand why?


>
> Maybe instead of pushing device_add/del, we should rather implement
> standby CPU model here, as ARM folks expect it to be.
> i.e. instead of device_add/del add 'enabled' property to ARM vCPU,
> and let management to turn on/off vCPUs on demand.
> (and very likely this model could be reused by other sock based platforms=
)
> For end-user it would be the same as device_add/del (i.e. vCPU becomes
> usable/unsable)
>

One of the main goals is to facilitate seamless migration from the x86
world to
ARM world. Hence, preservation of the x86 interface is important. It is a
requirement.
Just imagine if Apple had to change end user interface experience after
migrating iOS
from x86 to ARM architecture. ?



>
> I'd bet it would simplify your ARM CPU hotplug series a lot,
> since you won't have to fake vCPU object lifetime and do
> non trivial tricks to make it all work.
> Which it turn will make ARM hotplug series much more approachable
> for reviewers /and whomever comes later across that code/.
>

Tricks are just for ACPI and GIC and nothing else. Rest is a
boilerplate code of the
vCPU hotplug framework which x86 is also using.


>
> Regardless of said, we would still need changes to ACPI cphp code,
> see my comments inline.
>

sure.


>
>
> > Additionally, introduce an `acpi_persistent` property that can be used =
to
> > initialize the ACPI vCPU presence state accordingly. Architectures
> requiring
> > ACPI to expose a persistent view of vCPUs can override its default
> value. Refer
> > to the patch-set implelenting vCPU hotplug support for ARM for more
> details on
> > its usage.
> >
> > References:
> > [1] KVMForum 2023 Presentation: Challenges Revisited in Supporting Virt
> CPU Hotplug on
> >     architectures that don=E2=80=99t Support CPU Hotplug (like ARM64)
> >     a. Kernel Link:
> https://kvm-forum.qemu.org/2023/KVM-forum-cpu-hotplug_7OJ1YyJ.pdf
> >     b. Qemu Link:
> https://kvm-forum.qemu.org/2023/Challenges_Revisited_in_Supporting_Virt_C=
PU_Hotplug_-__ii0iNb3.pdf
> > [2] KVMForum 2020 Presentation: Challenges in Supporting Virtual CPU
> Hotplug on
> >     SoC Based Systems (like ARM64)
> >     Link: https://kvmforum2020.sched.com/event/eE4m
> > [3] Check comment 5 in the bugzilla entry
> >     Link: https://bugzilla.tianocore.org/show_bug.cgi?id=3D4481#c5
> >
> > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> > ---
> >  cpu-target.c          |  1 +
> >  hw/acpi/cpu.c         | 35 ++++++++++++++++++++++++++++++++++-
> >  include/hw/acpi/cpu.h | 21 +++++++++++++++++++++
> >  include/hw/core/cpu.h | 21 +++++++++++++++++++++
> >  4 files changed, 77 insertions(+), 1 deletion(-)
> >
> > diff --git a/cpu-target.c b/cpu-target.c
> > index 499facf774..c8a29ab495 100644
> > --- a/cpu-target.c
> > +++ b/cpu-target.c
> > @@ -200,6 +200,7 @@ static Property cpu_common_props[] =3D {
> >       */
> >      DEFINE_PROP_LINK("memory", CPUState, memory, TYPE_MEMORY_REGION,
> >                       MemoryRegion *),
> > +    DEFINE_PROP_BOOL("acpi-persistent", CPUState, acpi_persistent,
> false),
>
> I agree with Gavin, it's not CPU property/business, but a platform one.
>
> Pass it as argument to cpu_hotplug_hw_init(),
> and maybe rename to always_present.
> Then make sure that it's configurable in GED (which calls the function),
> and just turn it on for arm/virt machine.
> Other platforms might want to use x86 approach with GED and have
> vCPU actually disappearing. /loongson and maybe risc-v/
>

can we move it to Machine level or fetch it through firmware?


>
> >  #endif
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> > diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> > index 5cb60ca8bc..083c4010c2 100644
> > --- a/hw/acpi/cpu.c
> > +++ b/hw/acpi/cpu.c
> > @@ -225,7 +225,40 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object
> *owner,
> >      state->dev_count =3D id_list->len;
> >      state->devs =3D g_new0(typeof(*state->devs), state->dev_count);
> >      for (i =3D 0; i < id_list->len; i++) {
> > -        state->devs[i].cpu =3D  CPU(id_list->cpus[i].cpu);
> > +        struct CPUState *cpu =3D CPU(id_list->cpus[i].cpu);
> > +        /*
> > +         * In most architectures, CPUs that are marked as ACPI
> 'present' are
> > +         * also ACPI 'enabled' by default. These states remain
> consistent at
> > +         * both the QOM and ACPI levels.
> > +         */
> > +        if (cpu) {
> > +            state->devs[i].is_enabled =3D true;
> > +            state->devs[i].is_present =3D true;
> > +            state->devs[i].cpu =3D cpu;
> > +        } else {
> > +            state->devs[i].is_enabled =3D false;
> > +            /*
> > +             * In some architectures, even 'unplugged' or 'disabled'
> QOM CPUs
> > +             * may be exposed as ACPI 'present.' This approach provide=
s
> a
> > +             * persistent view of the vCPUs to the guest kernel. This
> could be
> > +             * due to an architectural constraint that requires every
> per-CPU
> > +             * component to be present at boot time, meaning the exact
> count of
> > +             * vCPUs must be known and cannot be altered after the
> kernel has
> > +             * booted. As a result, the vCPU states at the QOM and ACP=
I
> levels
> > +             * might become inconsistent. However, in such cases, the
> presence
> > +             * of vCPUs has been deliberately simulated at the ACPI
> level.
> > +             */
>
> if cpus are not 'simulated', you will not need comments explaining that a=
ll
> over place and whole hunk would likely go away.
>

I can reduce the content if you wish.


>
> > +            if (acpi_persistent_cpu(first_cpu)) {
> > +                state->devs[i].is_present =3D true;
> > +                /*
> > +                 * `CPUHotplugState::AcpiCpuStatus::cpu` becomes
> insignificant
> > +                 * in this case
> > +                 */
> > +            } else {
> > +                state->devs[i].is_present =3D false;
> > +                state->devs[i].cpu =3D cpu;
> > +            }
> > +        }
> >          state->devs[i].arch_id =3D id_list->cpus[i].arch_id;
> >      }
> >      memory_region_init_io(&state->ctrl_reg, owner, &cpu_hotplug_ops,
> state,
> > diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
> > index 32654dc274..bd3f9973c9 100644
> > --- a/include/hw/acpi/cpu.h
> > +++ b/include/hw/acpi/cpu.h
> > @@ -26,6 +26,8 @@ typedef struct AcpiCpuStatus {
> >      uint64_t arch_id;
> >      bool is_inserting;
> >      bool is_removing;
> > +    bool is_present;
> with always_present, it might be better to move field to CPUHotplugState
> as it's not per vCPU anymore, and in standby case state->devs[i].cpu
> should work as implicit present flag. (see below wrt doc first comment)
>

I'm still not convinced of the stand-by approach because of the performance
impact
it will have upon increasing the number of possible vCPUs and its worst
case is
unbounded. That's a major problem.



> > +    bool is_enabled;
> I'd move introduction of this field into a separate patch.
>
> BTW: new ABI/fields accessible by guest should be described in
> docs/specs/acpi_cpu_hotplug.rst.
> It would be better to have the spec as patch 1st, that we all agree on
> and then follow with implementation.
>

We can do that.


> And also include there an expected workflow for standby case.



We need more discussion on this as our requirements for which we floated
this
feature are not being met using stand-by cases.

Thanks!

Best regards
Salil.

>
>
> >      bool fw_remove;
> >      uint32_t ost_event;
> >      uint32_t ost_status;
> > @@ -75,4 +77,23 @@ extern const VMStateDescription vmstate_cpu_hotplug;
> >      VMSTATE_STRUCT(cpuhp, state, 1, \
> >                     vmstate_cpu_hotplug, CPUHotplugState)
> >
> > +/**
> > + * acpi_persistent_cpu:
> > + * @cpu: The vCPU to check
> > + *
> > + * Checks if the vCPU state should always be reflected as *present* vi=
a
> ACPI
> > + * to the Guest. By default, this is False on all architectures and ha=
s
> to be
> > + * explicity set during initialization.
> > + *
> > + * Returns: True if it is ACPI 'persistent' CPU
> > + *
> > + */
> > +static inline bool acpi_persistent_cpu(CPUState *cpu)
> > +{
> > +    /*
> > +     * returns if 'Presence' of the vCPU is persistent and should be
> simulated
> > +     * via ACPI even after vCPUs have been unplugged in QOM
> > +     */
> > +    return cpu && cpu->acpi_persistent;
> > +}
> >  #endif
> > diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> > index 04e9ad4996..299e96c45b 100644
> > --- a/include/hw/core/cpu.h
> > +++ b/include/hw/core/cpu.h
> > @@ -542,6 +542,27 @@ struct CPUState {
> >      CPUPluginState *plugin_state;
> >  #endif
> >
> > +    /*
> > +     * To implement the vCPU hotplug feature (which simulates CPU
> hotplug
> > +     * behavior), we need to dynamically create and destroy QOM vCPU
> objects,
> > +     * and (de)associate them with pre-existing KVM vCPUs while
> (un)parking the
> > +     * KVM vCPU context. One challenge is ensuring that these
> dynamically
> > +     * appearing or disappearing QOM vCPU objects are accurately
> reflected
> > +     * through ACPI to the Guest Kernel. Due to architectural
> constraints,
> > +     * changing the number of vCPUs after the guest kernel has booted
> may not
> > +     * always be possible.
> > +     *
> > +     * In certain architectures, to provide the guest kernel with a
> *persistent*
> > +     * view of vCPU presence, even when the QOM does not have a
> corresponding
> > +     * vCPU object, ACPI may simulate the presence of vCPUs by marking
> them as
> > +     * ACPI-disabled. This is achieved by setting `_STA.PRES=3DTrue` a=
nd
> > +     * `_STA.Ena=3DFalse` for unplugged vCPUs in QEMU's QOM.
> > +     *
> > +     * By default, this flag is set to `FALSE`, and it must be
> explicitly set
> > +     * to `TRUE` for architectures like ARM.
> > +     */
> > +    bool acpi_persistent;
> > +
> >      /* TODO Move common fields from CPUArchState here. */
> >      int cpu_index;
> >      int cluster_index;
>
>

--0000000000007e808a062503a5e0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Igor,<div><br></div><div>Thanks for ta=
king time to review and sorry for not being prompt. I was in transit</div><=
div>due to some difficult=C2=A0personal situation.</div></div><br><div clas=
s=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 18, 202=
4 at 3:11=E2=80=AFPM Igor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.co=
m">imammedo@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">On Mon, 14 Oct 2024 20:22:02 +0100<br>
Salil Mehta &lt;<a href=3D"mailto:salil.mehta@huawei.com" target=3D"_blank"=
>salil.mehta@huawei.com</a>&gt; wrote:<br>
<br>
&gt; Certain CPU architecture specifications [1][2][3] prohibit changes to =
CPU<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^=
^^^^^^^^<br>
these do not point to specs but never mind<br>
<br>
&gt; presence after the kernel has booted. This limitation exists because m=
any system<br>
&gt; initializations rely on the exact CPU count at boot time and do not ex=
pect it to<br>
&gt; change later. For example, components like interrupt controllers, whic=
h are<br>
&gt; closely tied to CPUs, or various per-CPU features, may not support con=
figuration<br>
&gt; changes once the kernel has been initialized. This presents a challeng=
e for<br>
&gt; virtualization features such as vCPU hotplug.<br>
<br>
well, x86 (incl cpu,interrupt ctrls) also doesn&#39;t have architectural ho=
tplug.<br>
It&#39;s just OEM managed to implement it regardless and then bothered to m=
ake<br>
OS changes to work with that.<br>
It&#39;s just ARM community doesn&#39;t want to go there at this point of t=
ime<br>
but using above reasoning as justification for this series doesn&#39;t look=
 good to me.<br></blockquote><div><br></div><div><br></div><div>There is a =
difference though. vCPU presence cannot be changed after the system has</di=
v><div>initialized in the ARM world due to the Architectural constraint. I =
think in the x86 world</div><div>it is allowed?</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
<br>
So what ARM would like to support is not CPU hotplug but rather a fixed<br>
system with standby CPUs (that can be powered on/off on demand).<br>
With ACPI spec amended to support that (MADT present/enabled changes), it&#=
39;s<br>
good enough reason to add &#39;enabled&#39; handling to acpi cpu-hotplug co=
de instead<br>
of inventing alternative one that would do almost the same.<br></blockquote=
><div><br></div><div><br></div><div>Not sure what you mean here but this is=
 what is being done.</div><div>=C2=A0</div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
But lets get rid of (can&#39;t/may not) language above and use standby CPUs=
 reasoning<br>
to avoid any confusion.<br></blockquote><div><br></div><div><br></div><div>=
I&#39;ve to disagree here. Standy-by means you will have to keep all the vC=
PUs states</div><div>realized and the objects will always exist. This is a =
problem for larger systems</div><div>with vCPU hotplug support as it drasti=
cally affects the boot times. Please check</div><div>the KVM Forum 2023 sli=
des for objective=C2=A0values.</div><div><br></div><div>It&#39;s been a lon=
g time since this series was actually conceived and at that time we wanted=
=C2=A0</div><div>to use it for kata containers but later with the gradual a=
doption=C2=A0of various microvms</div><div>and the cloud hypervisor require=
ments have bit changed. Boot time still remains one</div><div>of the major=
=C2=A0requirements. Not bounding boot time while using this feature will</d=
iv><div>seriously affect performance if the number of vCPUs increases</div>=
<div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
<br>
PS:<br>
I&#39;m taking about hw hotplug (at QEMU level) and not kernel hotplug<br>
(where it&#39;s at logical cpu level).<br></blockquote><div><br></div><div>=
sure</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
<br>
&gt; To address this issue, introduce an `is_enabled` state in the `AcpiCpu=
Status`,<br>
&gt; which reflects whether a vCPU has been hot-plugged or hot-unplugged in=
 QEMU,<br>
&gt; marking it as (un)available in the Guest Kernel. <br>
good so far<br>
<br>
&gt; The `is_present` state should<br>
&gt; be set based on the `acpi_persistent` flag. In cases where unplugged v=
CPUs need<br>
&gt; to be deliberately simulated in the ACPI to maintain a persistent view=
 of vCPUs,<br>
&gt; this flag ensures the guest kernel continues to see those vCPUs.<br>
<br>
that&#39;s where I have to disagree, vCPU is present when a corresponding Q=
OM object<br>
exists. Faking it&#39;s presence will only confuse at the end.<br></blockqu=
ote><div><br></div><div><br></div><div>Not faking care of it will mean real=
ization=C2=A0 of the unnecessary vCPU threads during</div><div>the VM init =
time, which in turn will increase the boot time. Trade-off between more</di=
v><div>clean design and performance.</div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
<br>
I get that you want to reuse device_add/del interface, but that leads to<br=
>
pulling the leg here and there to make thing fit. That in short therm<br>
(while someone remembers all tricks) might work for some, but long therm<br=
>
it&#39;s not sustainable).<br></blockquote><div><br></div><div><br></div><d=
iv>I do not understand why?</div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
<br>
Maybe instead of pushing device_add/del, we should rather implement<br>
standby CPU model here, as ARM folks expect it to be.<br>
i.e. instead of device_add/del add &#39;enabled&#39; property to ARM vCPU,<=
br>
and let management to turn on/off vCPUs on demand.<br>
(and very likely this model could be reused by other sock based platforms)<=
br>
For end-user it would be the same as device_add/del (i.e. vCPU becomes usab=
le/unsable)<br></blockquote><div><br></div><div>One of the main goals is to=
 facilitate seamless=C2=A0migration from the x86 world to</div><div>ARM wor=
ld. Hence, preservation of the x86 interface is important. It is a requirem=
ent.</div><div>Just imagine if Apple had to change end user interface exper=
ience after migrating iOS</div><div>from x86 to ARM architecture. ?</div><d=
iv><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
<br>
I&#39;d bet it would simplify your ARM CPU hotplug series a lot,<br>
since you won&#39;t have to fake vCPU object lifetime and do<br>
non trivial tricks to make it all work.<br>
Which it turn will make ARM hotplug series much more approachable<br>
for reviewers /and whomever comes later across that code/.<br></blockquote>=
<div><br></div><div>Tricks are just for ACPI and GIC and nothing else. Rest=
 is a boilerplate=C2=A0code of the</div><div>vCPU hotplug framework which x=
86 is also using.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
<br>
Regardless of said, we would still need changes to ACPI cphp code,<br>
see my comments inline.<br></blockquote><div><br></div><div>sure.</div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
&gt; Additionally, introduce an `acpi_persistent` property that can be used=
 to<br>
&gt; initialize the ACPI vCPU presence state accordingly. Architectures req=
uiring<br>
&gt; ACPI to expose a persistent view of vCPUs can override its default val=
ue. Refer<br>
&gt; to the patch-set implelenting vCPU hotplug support for ARM for more de=
tails on<br>
&gt; its usage.<br>
&gt; <br>
&gt; References:<br>
&gt; [1] KVMForum 2023 Presentation: Challenges Revisited in Supporting Vir=
t CPU Hotplug on<br>
&gt;=C2=A0 =C2=A0 =C2=A0architectures that don=E2=80=99t Support CPU Hotplu=
g (like ARM64)<br>
&gt;=C2=A0 =C2=A0 =C2=A0a. Kernel Link: <a href=3D"https://kvm-forum.qemu.o=
rg/2023/KVM-forum-cpu-hotplug_7OJ1YyJ.pdf" rel=3D"noreferrer" target=3D"_bl=
ank">https://kvm-forum.qemu.org/2023/KVM-forum-cpu-hotplug_7OJ1YyJ.pdf</a><=
br>
&gt;=C2=A0 =C2=A0 =C2=A0b. Qemu Link:=C2=A0 <a href=3D"https://kvm-forum.qe=
mu.org/2023/Challenges_Revisited_in_Supporting_Virt_CPU_Hotplug_-__ii0iNb3.=
pdf" rel=3D"noreferrer" target=3D"_blank">https://kvm-forum.qemu.org/2023/C=
hallenges_Revisited_in_Supporting_Virt_CPU_Hotplug_-__ii0iNb3.pdf</a><br>
&gt; [2] KVMForum 2020 Presentation: Challenges in Supporting Virtual CPU H=
otplug on<br>
&gt;=C2=A0 =C2=A0 =C2=A0SoC Based Systems (like ARM64)<br>
&gt;=C2=A0 =C2=A0 =C2=A0Link: <a href=3D"https://kvmforum2020.sched.com/eve=
nt/eE4m" rel=3D"noreferrer" target=3D"_blank">https://kvmforum2020.sched.co=
m/event/eE4m</a><br>
&gt; [3] Check comment 5 in the bugzilla entry<br>
&gt;=C2=A0 =C2=A0 =C2=A0Link: <a href=3D"https://bugzilla.tianocore.org/sho=
w_bug.cgi?id=3D4481#c5" rel=3D"noreferrer" target=3D"_blank">https://bugzil=
la.tianocore.org/show_bug.cgi?id=3D4481#c5</a><br>
&gt; <br>
&gt; Signed-off-by: Salil Mehta &lt;<a href=3D"mailto:salil.mehta@huawei.co=
m" target=3D"_blank">salil.mehta@huawei.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 cpu-target.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 hw/acpi/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 35 ++++++++++++=
++++++++++++++++++++++-<br>
&gt;=C2=A0 include/hw/acpi/cpu.h | 21 +++++++++++++++++++++<br>
&gt;=C2=A0 include/hw/core/cpu.h | 21 +++++++++++++++++++++<br>
&gt;=C2=A0 4 files changed, 77 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/cpu-target.c b/cpu-target.c<br>
&gt; index 499facf774..c8a29ab495 100644<br>
&gt; --- a/cpu-target.c<br>
&gt; +++ b/cpu-target.c<br>
&gt; @@ -200,6 +200,7 @@ static Property cpu_common_props[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_LINK(&quot;memory&quot;, CPUState, mem=
ory, TYPE_MEMORY_REGION,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0MemoryRegion *),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_BOOL(&quot;acpi-persistent&quot;, CPUState,=
 acpi_persistent, false),<br>
<br>
I agree with Gavin, it&#39;s not CPU property/business, but a platform one.=
<br>
<br>
Pass it as argument to cpu_hotplug_hw_init(),<br>
and maybe rename to always_present.<br>
Then make sure that it&#39;s configurable in GED (which calls the function)=
,<br>
and just turn it on for arm/virt machine.<br>
Other platforms might want to use x86 approach with GED and have<br>
vCPU actually disappearing. /loongson and maybe risc-v/<br></blockquote><di=
v><br></div><div>can we move it to Machine level or fetch it through firmwa=
re?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
<br>
&gt;=C2=A0 #endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST(),<br>
&gt;=C2=A0 };<br>
&gt; diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c<br>
&gt; index 5cb60ca8bc..083c4010c2 100644<br>
&gt; --- a/hw/acpi/cpu.c<br>
&gt; +++ b/hw/acpi/cpu.c<br>
&gt; @@ -225,7 +225,40 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object=
 *owner,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 state-&gt;dev_count =3D id_list-&gt;len;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 state-&gt;devs =3D g_new0(typeof(*state-&gt;devs),=
 state-&gt;dev_count);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; id_list-&gt;len; i++) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 state-&gt;devs[i].cpu =3D=C2=A0 CPU(id_li=
st-&gt;cpus[i].cpu);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct CPUState *cpu =3D CPU(id_list-&gt;=
cpus[i].cpu);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* In most architectures, CPUs that =
are marked as ACPI &#39;present&#39; are<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* also ACPI &#39;enabled&#39; by de=
fault. These states remain consistent at<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* both the QOM and ACPI levels.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpu) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 state-&gt;devs[i].is_enable=
d =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 state-&gt;devs[i].is_presen=
t =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 state-&gt;devs[i].cpu =3D c=
pu;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 state-&gt;devs[i].is_enable=
d =3D false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* In some architectur=
es, even &#39;unplugged&#39; or &#39;disabled&#39; QOM CPUs<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* may be exposed as A=
CPI &#39;present.&#39; This approach provides a<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* persistent view of =
the vCPUs to the guest kernel. This could be<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* due to an architect=
ural constraint that requires every per-CPU<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* component to be pre=
sent at boot time, meaning the exact count of<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* vCPUs must be known=
 and cannot be altered after the kernel has<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* booted. As a result=
, the vCPU states at the QOM and ACPI levels<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* might become incons=
istent. However, in such cases, the presence<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* of vCPUs has been d=
eliberately simulated at the ACPI level.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
<br>
if cpus are not &#39;simulated&#39;, you will not need comments explaining =
that all<br>
over place and whole hunk would likely go away.<br></blockquote><div><br></=
div><div>I can reduce the content if you wish.</div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (acpi_persistent_cpu(fir=
st_cpu)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 state-&gt;dev=
s[i].is_present =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* `CPUH=
otplugState::AcpiCpuStatus::cpu` becomes insignificant<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* in th=
is case<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 state-&gt;dev=
s[i].is_present =3D false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 state-&gt;dev=
s[i].cpu =3D cpu;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 state-&gt;devs[i].arch_id =3D id_lis=
t-&gt;cpus[i].arch_id;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 memory_region_init_io(&amp;state-&gt;ctrl_reg, own=
er, &amp;cpu_hotplug_ops, state,<br>
&gt; diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h<br>
&gt; index 32654dc274..bd3f9973c9 100644<br>
&gt; --- a/include/hw/acpi/cpu.h<br>
&gt; +++ b/include/hw/acpi/cpu.h<br>
&gt; @@ -26,6 +26,8 @@ typedef struct AcpiCpuStatus {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint64_t arch_id;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool is_inserting;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool is_removing;<br>
&gt; +=C2=A0 =C2=A0 bool is_present;<br>
with always_present, it might be better to move field to CPUHotplugState<br=
>
as it&#39;s not per vCPU anymore, and in standby case state-&gt;devs[i].cpu=
<br>
should work as implicit present flag. (see below wrt doc first comment)<br>=
</blockquote><div><br></div><div>I&#39;m still not convinced of the stand-b=
y approach because of the performance impact</div><div>it will have upon in=
creasing the number of possible vCPUs and its worst case is</div><div>unbou=
nded. That&#39;s a major problem.</div><div><br></div><div><br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 bool is_enabled;<br>
I&#39;d move introduction of this field into a separate patch.<br>
<br>
BTW: new ABI/fields accessible by guest should be described in<br>
docs/specs/acpi_cpu_hotplug.rst.<br>
It would be better to have the spec as patch 1st, that we all agree on<br>
and then follow with implementation.<br></blockquote><div><br></div><div>We=
 can do that.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
And also include there an expected workflow for standby case.</blockquote><=
div><br></div><div><br></div><div>We need more discussion=C2=A0on this as o=
ur requirements for which we floated this</div><div>feature are not being m=
et using stand-by cases.=C2=A0</div><div>=C2=A0</div><div>Thanks!</div><div=
><br></div><div>Best regards</div><div>Salil.</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex"> <br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool fw_remove;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint32_t ost_event;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint32_t ost_status;<br>
&gt; @@ -75,4 +77,23 @@ extern const VMStateDescription vmstate_cpu_hotplug=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VMSTATE_STRUCT(cpuhp, state, 1, \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0vmstate_cpu_hotplug, CPUHotplugState)<br>
&gt;=C2=A0 <br>
&gt; +/**<br>
&gt; + * acpi_persistent_cpu:<br>
&gt; + * @cpu: The vCPU to check<br>
&gt; + *<br>
&gt; + * Checks if the vCPU state should always be reflected as *present* v=
ia ACPI<br>
&gt; + * to the Guest. By default, this is False on all architectures and h=
as to be<br>
&gt; + * explicity set during initialization.<br>
&gt; + *<br>
&gt; + * Returns: True if it is ACPI &#39;persistent&#39; CPU<br>
&gt; + *<br>
&gt; + */<br>
&gt; +static inline bool acpi_persistent_cpu(CPUState *cpu)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* returns if &#39;Presence&#39; of the vCPU is pe=
rsistent and should be simulated<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* via ACPI even after vCPUs have been unplugged i=
n QOM<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 return cpu &amp;&amp; cpu-&gt;acpi_persistent;<br>
&gt; +}<br>
&gt;=C2=A0 #endif<br>
&gt; diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h<br>
&gt; index 04e9ad4996..299e96c45b 100644<br>
&gt; --- a/include/hw/core/cpu.h<br>
&gt; +++ b/include/hw/core/cpu.h<br>
&gt; @@ -542,6 +542,27 @@ struct CPUState {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 CPUPluginState *plugin_state;<br>
&gt;=C2=A0 #endif<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* To implement the vCPU hotplug feature (which si=
mulates CPU hotplug<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* behavior), we need to dynamically create and de=
stroy QOM vCPU objects,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* and (de)associate them with pre-existing KVM vC=
PUs while (un)parking the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* KVM vCPU context. One challenge is ensuring tha=
t these dynamically<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* appearing or disappearing QOM vCPU objects are =
accurately reflected<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* through ACPI to the Guest Kernel. Due to archit=
ectural constraints,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* changing the number of vCPUs after the guest ke=
rnel has booted may not<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* always be possible.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* In certain architectures, to provide the guest =
kernel with a *persistent*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* view of vCPU presence, even when the QOM does n=
ot have a corresponding<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* vCPU object, ACPI may simulate the presence of =
vCPUs by marking them as<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* ACPI-disabled. This is achieved by setting `_ST=
A.PRES=3DTrue` and<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* `_STA.Ena=3DFalse` for unplugged vCPUs in QEMU&=
#39;s QOM.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* By default, this flag is set to `FALSE`, and it=
 must be explicitly set<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* to `TRUE` for architectures like ARM.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 bool acpi_persistent;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* TODO Move common fields from CPUArchState here.=
 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int cpu_index;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int cluster_index;<br>
<br>
</blockquote></div></div>

--0000000000007e808a062503a5e0--

