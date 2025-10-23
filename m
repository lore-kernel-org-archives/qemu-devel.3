Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3CFCCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 01:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBk9I-0005jg-Ok; Wed, 22 Oct 2025 21:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1vBk9H-0005jO-Jc
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 21:29:51 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1vBk9E-0006Fs-LM
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 21:29:51 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-3c978f55367so158286fac.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 18:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1761182986; x=1761787786; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JbS7DWNkjaRtOeQKkVUNfO5+R/utuynE2kVQqawniPw=;
 b=WbE6TrZSc3h8RoIHpm/tApuyzPqulC60sckJt136M3B4oGCgodpSRe3fEbeI3tfDKk
 Iq6R1yoK2gRv/isYOV8dfrSsIN3HRDLi8WBAtn8DAW0QABe7xld9VCEyi5gNptOGYp7G
 UnksPBwrF+OgII7JjOjXvPSL7BaCY1tQQmkcLyucf34qxjtve0d+ROtMcyyyg1rmK9xD
 ILbVA2jPS5pZyvo1A+oUYuhxUjcXEwiADBtqHrq53GzysGVu0Jk+wypuUgKsexAr6m44
 r3B40q/T5YQn5NNKSLX3knBSRtsWHObk2qbDIsimrZrkULnMR1ovr3WsSWoAs5guO2zS
 kiyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761182986; x=1761787786;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JbS7DWNkjaRtOeQKkVUNfO5+R/utuynE2kVQqawniPw=;
 b=pGE0dxojCP6wCK2tvjMjBVmafJW0R16Wx+lXsXjLuab0W/WZ+xRMF+GiqH3Vx4Cvjy
 rTf17JILeKS+mvS+UfiYqrfMMMhV9a8/w7+ESNLnYIh3hRB4YY14VMJvgsL5m5lTN51p
 tRoathSjd7mmpiMUyz+qqgP+wRSoN1scKkrWATpYbgEUpQHPKVrzfFpNtPJ66OoAhh5+
 8EqVwXfrtXf6lTSMpdvXmxx8c54WNYOY0wOe90lYsYA2u+o9Wk/1le70O1+8EoaLhuCR
 TLJKtKtCcy+caBO6ZbwGiwhZmFk2mJWVaWJXEhDlaMpM72ZykDmj1ClaAAoe4mSVtlRk
 xiJw==
X-Gm-Message-State: AOJu0YylleybvYW2kNTcjCCSQASdFhd0SyRguqOQY4VWPTvHfK9f8yKn
 oBN6aNzu4LKr80rV2rREVwZNurmjL6iFPakdIEEPUP4EM9FldIqgGs/0yBQZlxHK8Sm/6zAYB/b
 t1fJN29PU95UdCMVt87zfc46lrfii921rePs5s+Pnlw==
X-Gm-Gg: ASbGnctxu313F/c2r5ytWY0X0VzQDo4SaBheLwnuOvNEpep/R2XzMmM69AzY1aAUWsq
 aoyDHd2+nTzif0iMKwiHJrdCKHP8Vi0/W1t/hxuDkCtl8+oGa5u9uDECRRweEXAoQHMCQHGdcDf
 0MUAuZCPXeuA/h6u5ySGlC8C2zNds7SEAVxVeo5Bk1pURu2RqcdCFPvQPVwgsbLGMv5C7gPpYMv
 na0z1T5jhp8rd7Y94maY6mwCKqTURhzt2uJk+A2QZFuYChqtx6vXjyiS00j5hddiLIjsEDeEcTt
 KkjN3BE7L1feCsnxc+ZTpziNNElAPVoZz78A2ICHYysKW+l0g4GL
X-Google-Smtp-Source: AGHT+IHeYXbAg1Pyk2ClfL4MF1j+v6VNnuO1jm28/TBzGf9WG+ZB0B0y8la+9xAJusW6W3hMdvO6GjKjcjhc1yaqNyw=
X-Received: by 2002:a05:6870:9721:b0:35b:a4be:c076 with SMTP id
 586e51a60fabf-3c98cf268e9mr8700985fac.3.1761182986142; Wed, 22 Oct 2025
 18:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
 <20251001010127.3092631-6-salil.mehta@opnsrc.net>
 <a03ed205-b61a-4bba-9f25-83663b7d8a86@redhat.com>
 <CAJ7pxeYurHLqj8GnLrfznmofMpsaw91GeZ3KMyucL0B_gn9gPg@mail.gmail.com>
 <CAJ7pxeaUfUeXwtTVheCTxej-aCTCx0n8-XyAKaFneVUjcWL_7w@mail.gmail.com>
 <beab3dd4-0c19-441c-a9f5-ecae9e791753@redhat.com>
 <CAJ7pxeYEpJGhtL1-3qFEJYTzL-s19fF-it6p5dkq=fg384wBpg@mail.gmail.com>
In-Reply-To: <CAJ7pxeYEpJGhtL1-3qFEJYTzL-s19fF-it6p5dkq=fg384wBpg@mail.gmail.com>
From: Salil Mehta <salil.mehta@opnsrc.net>
Date: Thu, 23 Oct 2025 01:29:34 +0000
X-Gm-Features: AS18NWBADk8WQJlHCPqrcb4QzMADot2olENlMPQhcYHKg40G3U5l1s8fxtQJYuM
Message-ID: <CAJ7pxeZG1w++2DNVD5L5N3sEPRLYPFSFECLqFgh3BYgKpfJtog@mail.gmail.com>
Subject: Re: [PATCH RFC V6 05/24] arm/virt,kvm: Pre-create KVM vCPUs for
 'disabled' QOM vCPUs at machine init
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com, 
 salil.mehta@huawei.com, maz@kernel.org, jean-philippe@linaro.org, 
 jonathan.cameron@huawei.com, lpieralisi@kernel.org, peter.maydell@linaro.org, 
 richard.henderson@linaro.org, imammedo@redhat.com, armbru@redhat.com, 
 andrew.jones@linux.dev, david@redhat.com, philmd@linaro.org, 
 eric.auger@redhat.com, will@kernel.org, ardb@kernel.org, 
 oliver.upton@linux.dev, pbonzini@redhat.com, rafael@kernel.org, 
 borntraeger@linux.ibm.com, alex.bennee@linaro.org, gustavo.romero@linaro.org, 
 npiggin@gmail.com, harshpb@linux.ibm.com, linux@armlinux.org.uk, 
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com, 
 vishnu@os.amperecomputing.com, gankulkarni@os.amperecomputing.com, 
 karl.heubaum@oracle.com, miguel.luis@oracle.com, zhukeqian1@huawei.com, 
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, wangzhou1@hisilicon.com, 
 linuxarm@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn, 
 lixianglai@loongson.cn, shahuang@redhat.com, zhao1.liu@intel.com, 
 Keqian Zhu <zhuqian1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-oa1-x30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Gavin,

On Thu, Oct 23, 2025 at 12:35=E2=80=AFAM Salil Mehta <salil.mehta@opnsrc.ne=
t> wrote:
>
> HI Gavin,
>
> On Thu, Oct 23, 2025 at 12:14=E2=80=AFAM Gavin Shan <gshan@redhat.com> wr=
ote:
> >
> > Hi Salil,
> >
> > On 10/23/25 4:50 AM, Salil Mehta wrote:
> > > On Wed, Oct 22, 2025 at 6:18=E2=80=AFPM Salil Mehta <salil.mehta@opns=
rc.net> wrote:
> > >> On Wed, Oct 22, 2025 at 10:37=E2=80=AFAM Gavin Shan <gshan@redhat.co=
m> wrote:
> > >>>
> > >>> Hi Salil,
> > >>>
> > >>> On 10/1/25 11:01 AM, salil.mehta@opnsrc.net wrote:
> > >>>> From: Salil Mehta <salil.mehta@huawei.com>
> > >>>>
> > >>>> ARM CPU architecture does not allow CPUs to be plugged after syste=
m has
> > >>>> initialized. This is a constraint. Hence, the Kernel must know all=
 the CPUs
> > >>>> being booted during its initialization. This applies to the Guest =
Kernel as
> > >>>> well and therefore, the number of KVM vCPU descriptors in the host=
 must be
> > >>>> fixed at VM initialization time.
> > >>>>
> > >>>> Also, the GIC must know all the CPUs it is connected to during its
> > >>>> initialization, and this cannot change afterward. This must also b=
e ensured
> > >>>> during the initialization of the VGIC in KVM. This is necessary be=
cause:
> > >>>>
> > >>>> 1. The association between GICR and MPIDR must be fixed at VM init=
ialization
> > >>>>      time. This is represented by the register
> > >>>>      `GICR_TYPER(mp_affinity, proc_num)`.
> > >>>> 2. Memory regions associated with GICR, etc., cannot be changed (a=
dded,
> > >>>>      deleted, or modified) after the VM has been initialized. This=
 is not an
> > >>>>      ARM architectural constraint but rather invites a difficult a=
nd messy
> > >>>>      change in VGIC data structures.
> > >>>>
> > >>>> To enable a hot-add=E2=80=93like model while preserving these cons=
traints, the virt
> > >>>> machine may enumerate more CPUs than are enabled at boot using
> > >>>> `-smp disabledcpus=3DN`. Such CPUs are present but start offline (=
i.e.,
> > >>>> administratively disabled at init). The topology remains fixed at =
VM
> > >>>> creation time; only the online/offline status may change later.
> > >>>>
> > >>>> Administratively disabled vCPUs are not realized in QOM until firs=
t enabled,
> > >>>> avoiding creation of unnecessary vCPU threads at boot. On large sy=
stems, this
> > >>>> reduces startup time proportionally to the number of disabled vCPU=
s. Once a
> > >>>> QOM vCPU is realized and its thread created, subsequent enable/dis=
able actions
> > >>>> do not unrealize it. This behaviour was adopted following review f=
eedback and
> > >>>> differs from earlier RFC versions.
> > >>>>
> > >>>> Co-developed-by: Keqian Zhu <zhuqian1@huawei.com>
> > >>>> Signed-off-by: Keqian Zhu <zhuqian1@huawei.com>
> > >>>> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> > >>>> ---
> > >>>>    accel/kvm/kvm-all.c    |  2 +-
> > >>>>    hw/arm/virt.c          | 77 +++++++++++++++++++++++++++++++++++=
+++----
> > >>>>    hw/core/qdev.c         | 17 ++++++++++
> > >>>>    include/hw/qdev-core.h | 19 +++++++++++
> > >>>>    include/system/kvm.h   |  8 +++++
> > >>>>    target/arm/cpu.c       |  2 ++
> > >>>>    target/arm/kvm.c       | 40 +++++++++++++++++++++-
> > >>>>    target/arm/kvm_arm.h   | 11 ++++++
> > >>>>    8 files changed, 168 insertions(+), 8 deletions(-)
> > >>>>
> > >
> > > [...]
> > >
> > >>>> +void kvm_arm_create_host_vcpu(ARMCPU *cpu)
> > >>>> +{
> > >>>> +    CPUState *cs =3D CPU(cpu);
> > >>>> +    unsigned long vcpu_id =3D cs->cpu_index;
> > >>>> +    int ret;
> > >>>> +
> > >>>> +    ret =3D kvm_create_vcpu(cs);
> > >>>> +    if (ret < 0) {
> > >>>> +        error_report("Failed to create host vcpu %ld", vcpu_id);
> > >>>> +        abort();
> > >>>> +    }
> > >>>> +
> > >>>> +    /*
> > >>>> +     * Initialize the vCPU in the host. This will reset the sys r=
egs
> > >>>> +     * for this vCPU and related registers like MPIDR_EL1 etc. al=
so
> > >>>> +     * get programmed during this call to host. These are referen=
ced
> > >>>> +     * later while setting device attributes of the GICR during G=
ICv3
> > >>>> +     * reset.
> > >>>> +     */
> > >>>> +    ret =3D kvm_arch_init_vcpu(cs);
> > >>>> +    if (ret < 0) {
> > >>>> +        error_report("Failed to initialize host vcpu %ld", vcpu_i=
d);
> > >>>> +        abort();
> > >>>> +    }
> > >>>> +
> > >>>> +    /*
> > >>>> +     * park the created vCPU. shall be used during kvm_get_vcpu()=
 when
> > >>>> +     * threads are created during realization of ARM vCPUs.
> > >>>> +     */
> > >>>> +    kvm_park_vcpu(cs);
> > >>>> +}
> > >>>> +
> > >>>
> > >>> I don't think we're able to simply call kvm_arch_init_vcpu() in the=
 lazily realized
> > >>> path. Otherwise, it can trigger a crash dump on my Nvidia's grace-h=
opper machine where
> > >>> SVE is supported by default.
> > >>
> > >> Thanks for reporting this. That is not true. As long as we initializ=
e
> > >> KVM correctly and
> > >> finalize the features like SVE we should be fine. In fact, this is
> > >> precisely what we are
> > >> doing right now.
> > >>
> > >> To understand the crash, I need a bit more info.
> > >>
> > >> 1#  is happening because KVM_ARM_VCPU_INIT is failing. If yes, the c=
an you check
> > >>        within the KVM if it is happening because
> > >>       a.  features specified by QEMU are not matching the defaults w=
ithin the KVM
> > >>             (HInt: check kvm_vcpu_init_check_features())?
> > >>       b. or complaining about init feate change kvm_vcpu_init_change=
d()?
> > >> 2#  or it is happening during the setting of vector length or
> > >> finalizing features?
> > >>
> > >> int kvm_arch_init_vcpu(CPUState *cs)
> > >> {
> > >>     [...]
> > >>           /* Do KVM_ARM_VCPU_INIT ioctl */
> > >>          ret =3D kvm_arm_vcpu_init(cpu);   ---->[1]
> > >>          if (ret) {
> > >>             return ret;
> > >>         }
> > >>            if (cpu_isar_feature(aa64_sve, cpu)) {
> > >>          ret =3D kvm_arm_sve_set_vls(cpu); ---->[2]
> > >>          if (ret) {
> > >>              return ret;
> > >>          }
> > >>          ret =3D kvm_arm_vcpu_finalize(cpu, KVM_ARM_VCPU_SVE);--->[3=
]
> > >>          if (ret) {
> > >>              return ret;
> > >>          }
> > >>      }
> > >> [...]
> > >> }
> > >>
> > >> I think it's happening because vector length is going uninitialized.
> > >> This initialization
> > >> happens in context to  arm_cpu_finalize_features() which I forgot to=
 call before
> > >> calling KVM finalize.
> > >>
> > >>>
> > >>> kvm_arch_init_vcpu() is supposed to be called in the realization pa=
th in current
> > >>> implementation (without this series) because the parameters (featur=
es) to KVM_ARM_VCPU_INIT
> > >>> is populated at vCPU realization time.
> > >>
> > >> Not necessarily. It is just meant to initialize the KVM. If we take =
care of the
> > >> KVM requirements in the similar way the realize path does we should =
be
> > >> fine. Can you try to add the patch below in your code and test if it=
 works?
> > >>
> > >>   diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> > >> index c4b68a0b17..1091593478 100644
> > >> --- a/target/arm/kvm.c
> > >> +++ b/target/arm/kvm.c
> > >> @@ -1068,6 +1068,9 @@ void kvm_arm_create_host_vcpu(ARMCPU *cpu)
> > >>           abort();
> > >>       }
> > >>
> > >> +     /* finalize the features like SVE, SME etc */
> > >> +     arm_cpu_finalize_features(cpu, &error_abort);
> > >> +
> > >>       /*
> > >>        * Initialize the vCPU in the host. This will reset the sys re=
gs
> > >>        * for this vCPU and related registers like MPIDR_EL1 etc. als=
o
> > >>
> > >>
> > >>
> > >>
> > >>>
> > >>> $ home/gavin/sandbox/qemu.main/build/qemu-system-aarch64           =
\
> > >>>     --enable-kvm -machine virt,gic-version=3D3 -cpu host           =
    \
> > >>>     -smp cpus=3D4,disabledcpus=3D2 -m 1024M                        =
      \
> > >>>     -kernel /home/gavin/sandbox/linux.guest/arch/arm64/boot/Image  =
  \
> > >>>     -initrd /home/gavin/sandbox/images/rootfs.cpio.xz -nographic
> > >>> qemu-system-aarch64: Failed to initialize host vcpu 4
> > >>> Aborted (core dumped)
> > >>>
> > >>> Backtrace
> > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >>> (gdb) bt
> > >>> #0  0x0000ffff9106bc80 in __pthread_kill_implementation () at /lib6=
4/libc.so.6
> > >>> #1  0x0000ffff9101aa40 [PAC] in raise () at /lib64/libc.so.6
> > >>> #2  0x0000ffff91005988 [PAC] in abort () at /lib64/libc.so.6
> > >>> #3  0x0000aaaab1cc26b8 [PAC] in kvm_arm_create_host_vcpu (cpu=3D0xa=
aaab9ab1bc0)
> > >>>       at ../target/arm/kvm.c:1081
> > >>> #4  0x0000aaaab1cd0c94 in virt_setup_lazy_vcpu_realization (cpuobj=
=3D0xaaaab9ab1bc0, vms=3D0xaaaab98870a0)
> > >>>       at ../hw/arm/virt.c:2483
> > >>> #5  0x0000aaaab1cd180c in machvirt_init (machine=3D0xaaaab98870a0) =
at ../hw/arm/virt.c:2777
> > >>> #6  0x0000aaaab160f220 in machine_run_board_init
> > >>>       (machine=3D0xaaaab98870a0, mem_path=3D0x0, errp=3D0xfffffa86b=
dc8) at ../hw/core/machine.c:1722
> > >>> #7  0x0000aaaab1a25ef4 in qemu_init_board () at ../system/vl.c:2723
> > >>> #8  0x0000aaaab1a2635c in qmp_x_exit_preconfig (errp=3D0xaaaab38a50=
f0 <error_fatal>)
> > >>>       at ../system/vl.c:2821
> > >>> #9  0x0000aaaab1a28b08 in qemu_init (argc=3D15, argv=3D0xfffffa86c1=
f8) at ../system/vl.c:3882
> > >>> #10 0x0000aaaab221d9e4 in main (argc=3D15, argv=3D0xfffffa86c1f8) a=
t ../system/main.c:71
> > >>
> > >>
> > >> Thank you for this. Please let me know if the above fix works and al=
so
> > >> the return values in
> > >> case you encounter errors.
> > >
> > > I've pushed the fix to below branch for your convenience:
> > >
> > > Branch: https://github.com/salil-mehta/qemu/commits/virt-cpuhp-armv8/=
rfc-v6.2
> > > Fix: https://github.com/salil-mehta/qemu/commit/1f1fbc0998ffb1fe26140=
df3c336bf2be2aa8669
> > >
> >
> > I guess rfc-v6.2 branch isn't ready for test because it runs into anoth=
er crash
> > dump with rfc-v6.2 branch, like below.
>
>
> rfc-6.2 is not crashing on Kunpeng920 where I tested. But this
> chip does not have some ARM extensions like SVE etc so
> Unfortunately, I can't test SVE/SME/PAuth etc support.
>
> Can you disable SVE and then try if it comes up just to corner
> the case?
>
> >
> > host$ /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64          =
           \
> >        -accel kvm -machine virt,gic-version=3Dhost,nvdimm=3Don         =
                \
> >        -cpu host,sve=3Don                                              =
              \
> >        -smp maxcpus=3D4,cpus=3D2,disabledcpus=3D2,sockets=3D2,clusters=
=3D2,cores=3D1,threads=3D1 \
> >        -m 4096M,slots=3D16,maxmem=3D128G                               =
                \
> >        -object memory-backend-ram,id=3Dmem0,size=3D2048M               =
                \
> >        -object memory-backend-ram,id=3Dmem1,size=3D2048M               =
                \
> >        -numa node,nodeid=3D0,memdev=3Dmem0,cpus=3D0-1                  =
                  \
> >        -numa node,nodeid=3D1,memdev=3Dmem1,cpus=3D2-3                  =
                  \
> >        -L /home/gavin/sandbox/qemu.main/build/pc-bios                  =
            \
> >        -monitor none -serial mon:stdio -nographic -gdb tcp::6666       =
            \
> >        -qmp tcp:localhost:5555,server,wait=3Doff                       =
              \
> >        -bios /home/gavin/sandbox/qemu.main/build/pc-bios/edk2-aarch64-c=
ode.fd      \
> >        -kernel /home/gavin/sandbox/linux.guest/arch/arm64/boot/Image   =
            \
> >        -initrd /home/gavin/sandbox/images/rootfs.cpio.xz               =
            \
> >        -append memhp_default_state=3Donline_movable
> >          :
> >          :
> > guest$ cd /sys/devices/system/cpu/
> > guest$ cat present enabled online
> > 0-3
> > 0-1
> > 0-1
> > (qemu) device_set host-arm-cpu,socket-id=3D1,cluster-id=3D0,core-id=3D0=
,thread-id=3D0,admin-state=3Denable
> > qemu-system-aarch64: kvm_init_vcpu: kvm_arch_init_vcpu failed (2): Oper=
ation not permitted
>
>
> Ah, I see. I think I understand the issue. It's complaining
> about calling the  finalize twice. Is it possible to check as
> I do not have a way to test it?
>
>
> int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu, int feature)
> {
> switch (feature) {
> case KVM_ARM_VCPU_SVE:
> [...]
> if (kvm_arm_vcpu_sve_finalized(vcpu))
> return -EPERM;-----> this where it must be popping?
> [...]
> }

I've pushed the fix to avoid calling the finalizing SVE
feature (KVM_ARM_VCPU_FINALIZE) twice on the
same RFC-V6.2 branch.

May I kindly request you to validate the fix again and
check SVE works on NVIDIA grace-hopper?

Many thanks!

Best regards
Salil.

