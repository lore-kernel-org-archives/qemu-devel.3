Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD2CCCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 00:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBjJL-0008JF-O4; Wed, 22 Oct 2025 20:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1vBjJK-0008Ik-E5
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 20:36:10 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1vBjJH-0000L1-FG
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 20:36:10 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-3c988d13473so138092fac.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 17:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1761179765; x=1761784565; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2dswqsRz7R3QP1cqeEENFdbMsDvMSTsXMWw/YX/9Qhc=;
 b=eBqcq9E0XZSy13j/zGjJT1CXawdMJF6dCd0caXIRSX0EsLaxq8JDezi2648ofxorD3
 w4cLs/Fh/5j+hC2/rNwB3p6TI65Sicw33CkWKAOnkEdDezYqSmcqwDTKcQbNKfaOPKWE
 PEp7rYuTWp5NYJwdAx12uF/72m+NLfvQJziY8kkc4vdimvsoHLTxxloockU54FcfyJll
 0TBFGHpqT5nnsNbzS2O6DxO8Sa5WdmT5AWomrsZWTfjLMmr/R5lV10bpZ5/icsugkGAB
 rtMDDOOugFhIrAoIJlHb3kHjG8QyzA8HCmRg2PhPBLld3D4SrZlJvcM4Je9vIr8AN50B
 3mQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761179765; x=1761784565;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2dswqsRz7R3QP1cqeEENFdbMsDvMSTsXMWw/YX/9Qhc=;
 b=k8y8u+wCyELteqmm70a4oDeAjok/85FaV/vwMNxfA+BYJr0nROlzHdzikpe7znUXl0
 hyRpv+7nwBlbtq4iZGVT3T3I0RILjceE3NYf7eHMf57jZ5bxzgUWMuEm3cFIYxim/N7S
 WrMn2bGQ4T9qvb8o1nFQFBLbsesAsLkCbarsBUASrw7u8Y34VoigH8IkUVE1OvTczCPt
 009Ehdldlkb4OIsK8xqk7itg3UcyzK3epMOilN90JfRrN1JVVuSeBX5grB5qC/KZeb4l
 m1+45OCEuUuwTULSXCS+0OE6W39D0qBu3tY5VKyuxUmP16e4cz6wz2BcGsQJMlQNg3+e
 DYhg==
X-Gm-Message-State: AOJu0YzSsaTyhkeecTlj3WQYXZTBXNNpv+zJ6ngsVNbRlxqlj/0bwBFE
 NQZbYptebp3Evb0rJHFpYTapU/pKf+AxUtm5az+A2Cu5TsrTU8/9xCUFpzADyz9l0xzcNM8a5dl
 8MEgOei6jbSvn+Ys++ZbXWwh+6tgzuBD5P71ibvQLxw==
X-Gm-Gg: ASbGncs8m6c1x4kbKxnHSbYXshc6YXzk6ZaqG1p0N+UBrzrfk4eD8f0xPS0wfptyzOB
 j6id2iBW+YCt5uphnNyxDJgSSN8sHyn/FJxeexx17SPWRmcJtja6O4o4ihvsAWxjFAwu6kMaSpx
 Y4Vjts8OnbLGHR3V0y66VYadkC747RCta53au2kiR5TMsO7cUWXwDGRJxZow4W+fkvIXxcNbxpL
 /TCsaiQopmHah1QBnu/NZ0e7EUn0JE9mt/5F/P+C36SZCQLXbdRANhLinlydtmichLkE3VvNNri
 9emWKw19obDH/h3VfXVs9rN539SGKWIaExqziUCYsg==
X-Google-Smtp-Source: AGHT+IEMb9G2Yb0XONcRcCtsCMKiulXlgdJPidb+jEsoxFmjDUv9ZNY1mTzpPMqOB57ZUABsbv9PcjXkPLl8TfL4JLQ=
X-Received: by 2002:a05:6870:a551:b0:377:bbde:5278 with SMTP id
 586e51a60fabf-3c98d134535mr9188104fac.37.1761179765006; Wed, 22 Oct 2025
 17:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
 <20251001010127.3092631-6-salil.mehta@opnsrc.net>
 <a03ed205-b61a-4bba-9f25-83663b7d8a86@redhat.com>
 <CAJ7pxeYurHLqj8GnLrfznmofMpsaw91GeZ3KMyucL0B_gn9gPg@mail.gmail.com>
 <CAJ7pxeaUfUeXwtTVheCTxej-aCTCx0n8-XyAKaFneVUjcWL_7w@mail.gmail.com>
 <beab3dd4-0c19-441c-a9f5-ecae9e791753@redhat.com>
In-Reply-To: <beab3dd4-0c19-441c-a9f5-ecae9e791753@redhat.com>
From: Salil Mehta <salil.mehta@opnsrc.net>
Date: Thu, 23 Oct 2025 00:35:53 +0000
X-Gm-Features: AS18NWAvh6Bbr7wmuXpM9fKl2jrJ3Ut01I6veF2NjR09qd27aBckQXAMWOjUBcE
Message-ID: <CAJ7pxeYEpJGhtL1-3qFEJYTzL-s19fF-it6p5dkq=fg384wBpg@mail.gmail.com>
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
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-oa1-x2b.google.com
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

HI Gavin,

On Thu, Oct 23, 2025 at 12:14=E2=80=AFAM Gavin Shan <gshan@redhat.com> wrot=
e:
>
> Hi Salil,
>
> On 10/23/25 4:50 AM, Salil Mehta wrote:
> > On Wed, Oct 22, 2025 at 6:18=E2=80=AFPM Salil Mehta <salil.mehta@opnsrc=
.net> wrote:
> >> On Wed, Oct 22, 2025 at 10:37=E2=80=AFAM Gavin Shan <gshan@redhat.com>=
 wrote:
> >>>
> >>> Hi Salil,
> >>>
> >>> On 10/1/25 11:01 AM, salil.mehta@opnsrc.net wrote:
> >>>> From: Salil Mehta <salil.mehta@huawei.com>
> >>>>
> >>>> ARM CPU architecture does not allow CPUs to be plugged after system =
has
> >>>> initialized. This is a constraint. Hence, the Kernel must know all t=
he CPUs
> >>>> being booted during its initialization. This applies to the Guest Ke=
rnel as
> >>>> well and therefore, the number of KVM vCPU descriptors in the host m=
ust be
> >>>> fixed at VM initialization time.
> >>>>
> >>>> Also, the GIC must know all the CPUs it is connected to during its
> >>>> initialization, and this cannot change afterward. This must also be =
ensured
> >>>> during the initialization of the VGIC in KVM. This is necessary beca=
use:
> >>>>
> >>>> 1. The association between GICR and MPIDR must be fixed at VM initia=
lization
> >>>>      time. This is represented by the register
> >>>>      `GICR_TYPER(mp_affinity, proc_num)`.
> >>>> 2. Memory regions associated with GICR, etc., cannot be changed (add=
ed,
> >>>>      deleted, or modified) after the VM has been initialized. This i=
s not an
> >>>>      ARM architectural constraint but rather invites a difficult and=
 messy
> >>>>      change in VGIC data structures.
> >>>>
> >>>> To enable a hot-add=E2=80=93like model while preserving these constr=
aints, the virt
> >>>> machine may enumerate more CPUs than are enabled at boot using
> >>>> `-smp disabledcpus=3DN`. Such CPUs are present but start offline (i.=
e.,
> >>>> administratively disabled at init). The topology remains fixed at VM
> >>>> creation time; only the online/offline status may change later.
> >>>>
> >>>> Administratively disabled vCPUs are not realized in QOM until first =
enabled,
> >>>> avoiding creation of unnecessary vCPU threads at boot. On large syst=
ems, this
> >>>> reduces startup time proportionally to the number of disabled vCPUs.=
 Once a
> >>>> QOM vCPU is realized and its thread created, subsequent enable/disab=
le actions
> >>>> do not unrealize it. This behaviour was adopted following review fee=
dback and
> >>>> differs from earlier RFC versions.
> >>>>
> >>>> Co-developed-by: Keqian Zhu <zhuqian1@huawei.com>
> >>>> Signed-off-by: Keqian Zhu <zhuqian1@huawei.com>
> >>>> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> >>>> ---
> >>>>    accel/kvm/kvm-all.c    |  2 +-
> >>>>    hw/arm/virt.c          | 77 +++++++++++++++++++++++++++++++++++++=
+----
> >>>>    hw/core/qdev.c         | 17 ++++++++++
> >>>>    include/hw/qdev-core.h | 19 +++++++++++
> >>>>    include/system/kvm.h   |  8 +++++
> >>>>    target/arm/cpu.c       |  2 ++
> >>>>    target/arm/kvm.c       | 40 +++++++++++++++++++++-
> >>>>    target/arm/kvm_arm.h   | 11 ++++++
> >>>>    8 files changed, 168 insertions(+), 8 deletions(-)
> >>>>
> >
> > [...]
> >
> >>>> +void kvm_arm_create_host_vcpu(ARMCPU *cpu)
> >>>> +{
> >>>> +    CPUState *cs =3D CPU(cpu);
> >>>> +    unsigned long vcpu_id =3D cs->cpu_index;
> >>>> +    int ret;
> >>>> +
> >>>> +    ret =3D kvm_create_vcpu(cs);
> >>>> +    if (ret < 0) {
> >>>> +        error_report("Failed to create host vcpu %ld", vcpu_id);
> >>>> +        abort();
> >>>> +    }
> >>>> +
> >>>> +    /*
> >>>> +     * Initialize the vCPU in the host. This will reset the sys reg=
s
> >>>> +     * for this vCPU and related registers like MPIDR_EL1 etc. also
> >>>> +     * get programmed during this call to host. These are reference=
d
> >>>> +     * later while setting device attributes of the GICR during GIC=
v3
> >>>> +     * reset.
> >>>> +     */
> >>>> +    ret =3D kvm_arch_init_vcpu(cs);
> >>>> +    if (ret < 0) {
> >>>> +        error_report("Failed to initialize host vcpu %ld", vcpu_id)=
;
> >>>> +        abort();
> >>>> +    }
> >>>> +
> >>>> +    /*
> >>>> +     * park the created vCPU. shall be used during kvm_get_vcpu() w=
hen
> >>>> +     * threads are created during realization of ARM vCPUs.
> >>>> +     */
> >>>> +    kvm_park_vcpu(cs);
> >>>> +}
> >>>> +
> >>>
> >>> I don't think we're able to simply call kvm_arch_init_vcpu() in the l=
azily realized
> >>> path. Otherwise, it can trigger a crash dump on my Nvidia's grace-hop=
per machine where
> >>> SVE is supported by default.
> >>
> >> Thanks for reporting this. That is not true. As long as we initialize
> >> KVM correctly and
> >> finalize the features like SVE we should be fine. In fact, this is
> >> precisely what we are
> >> doing right now.
> >>
> >> To understand the crash, I need a bit more info.
> >>
> >> 1#  is happening because KVM_ARM_VCPU_INIT is failing. If yes, the can=
 you check
> >>        within the KVM if it is happening because
> >>       a.  features specified by QEMU are not matching the defaults wit=
hin the KVM
> >>             (HInt: check kvm_vcpu_init_check_features())?
> >>       b. or complaining about init feate change kvm_vcpu_init_changed(=
)?
> >> 2#  or it is happening during the setting of vector length or
> >> finalizing features?
> >>
> >> int kvm_arch_init_vcpu(CPUState *cs)
> >> {
> >>     [...]
> >>           /* Do KVM_ARM_VCPU_INIT ioctl */
> >>          ret =3D kvm_arm_vcpu_init(cpu);   ---->[1]
> >>          if (ret) {
> >>             return ret;
> >>         }
> >>            if (cpu_isar_feature(aa64_sve, cpu)) {
> >>          ret =3D kvm_arm_sve_set_vls(cpu); ---->[2]
> >>          if (ret) {
> >>              return ret;
> >>          }
> >>          ret =3D kvm_arm_vcpu_finalize(cpu, KVM_ARM_VCPU_SVE);--->[3]
> >>          if (ret) {
> >>              return ret;
> >>          }
> >>      }
> >> [...]
> >> }
> >>
> >> I think it's happening because vector length is going uninitialized.
> >> This initialization
> >> happens in context to  arm_cpu_finalize_features() which I forgot to c=
all before
> >> calling KVM finalize.
> >>
> >>>
> >>> kvm_arch_init_vcpu() is supposed to be called in the realization path=
 in current
> >>> implementation (without this series) because the parameters (features=
) to KVM_ARM_VCPU_INIT
> >>> is populated at vCPU realization time.
> >>
> >> Not necessarily. It is just meant to initialize the KVM. If we take ca=
re of the
> >> KVM requirements in the similar way the realize path does we should be
> >> fine. Can you try to add the patch below in your code and test if it w=
orks?
> >>
> >>   diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> >> index c4b68a0b17..1091593478 100644
> >> --- a/target/arm/kvm.c
> >> +++ b/target/arm/kvm.c
> >> @@ -1068,6 +1068,9 @@ void kvm_arm_create_host_vcpu(ARMCPU *cpu)
> >>           abort();
> >>       }
> >>
> >> +     /* finalize the features like SVE, SME etc */
> >> +     arm_cpu_finalize_features(cpu, &error_abort);
> >> +
> >>       /*
> >>        * Initialize the vCPU in the host. This will reset the sys regs
> >>        * for this vCPU and related registers like MPIDR_EL1 etc. also
> >>
> >>
> >>
> >>
> >>>
> >>> $ home/gavin/sandbox/qemu.main/build/qemu-system-aarch64           \
> >>>     --enable-kvm -machine virt,gic-version=3D3 -cpu host             =
  \
> >>>     -smp cpus=3D4,disabledcpus=3D2 -m 1024M                          =
    \
> >>>     -kernel /home/gavin/sandbox/linux.guest/arch/arm64/boot/Image    =
\
> >>>     -initrd /home/gavin/sandbox/images/rootfs.cpio.xz -nographic
> >>> qemu-system-aarch64: Failed to initialize host vcpu 4
> >>> Aborted (core dumped)
> >>>
> >>> Backtrace
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> (gdb) bt
> >>> #0  0x0000ffff9106bc80 in __pthread_kill_implementation () at /lib64/=
libc.so.6
> >>> #1  0x0000ffff9101aa40 [PAC] in raise () at /lib64/libc.so.6
> >>> #2  0x0000ffff91005988 [PAC] in abort () at /lib64/libc.so.6
> >>> #3  0x0000aaaab1cc26b8 [PAC] in kvm_arm_create_host_vcpu (cpu=3D0xaaa=
ab9ab1bc0)
> >>>       at ../target/arm/kvm.c:1081
> >>> #4  0x0000aaaab1cd0c94 in virt_setup_lazy_vcpu_realization (cpuobj=3D=
0xaaaab9ab1bc0, vms=3D0xaaaab98870a0)
> >>>       at ../hw/arm/virt.c:2483
> >>> #5  0x0000aaaab1cd180c in machvirt_init (machine=3D0xaaaab98870a0) at=
 ../hw/arm/virt.c:2777
> >>> #6  0x0000aaaab160f220 in machine_run_board_init
> >>>       (machine=3D0xaaaab98870a0, mem_path=3D0x0, errp=3D0xfffffa86bdc=
8) at ../hw/core/machine.c:1722
> >>> #7  0x0000aaaab1a25ef4 in qemu_init_board () at ../system/vl.c:2723
> >>> #8  0x0000aaaab1a2635c in qmp_x_exit_preconfig (errp=3D0xaaaab38a50f0=
 <error_fatal>)
> >>>       at ../system/vl.c:2821
> >>> #9  0x0000aaaab1a28b08 in qemu_init (argc=3D15, argv=3D0xfffffa86c1f8=
) at ../system/vl.c:3882
> >>> #10 0x0000aaaab221d9e4 in main (argc=3D15, argv=3D0xfffffa86c1f8) at =
../system/main.c:71
> >>
> >>
> >> Thank you for this. Please let me know if the above fix works and also
> >> the return values in
> >> case you encounter errors.
> >
> > I've pushed the fix to below branch for your convenience:
> >
> > Branch: https://github.com/salil-mehta/qemu/commits/virt-cpuhp-armv8/rf=
c-v6.2
> > Fix: https://github.com/salil-mehta/qemu/commit/1f1fbc0998ffb1fe26140df=
3c336bf2be2aa8669
> >
>
> I guess rfc-v6.2 branch isn't ready for test because it runs into another=
 crash
> dump with rfc-v6.2 branch, like below.


rfc-6.2 is not crashing on Kunpeng920 where I tested. But this
chip does not have some ARM extensions like SVE etc so
Unfortunately, I can't test SVE/SME/PAuth etc support.

Can you disable SVE and then try if it comes up just to corner
the case?

>
> host$ /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64            =
         \
>        -accel kvm -machine virt,gic-version=3Dhost,nvdimm=3Don           =
              \
>        -cpu host,sve=3Don                                                =
            \
>        -smp maxcpus=3D4,cpus=3D2,disabledcpus=3D2,sockets=3D2,clusters=3D=
2,cores=3D1,threads=3D1 \
>        -m 4096M,slots=3D16,maxmem=3D128G                                 =
              \
>        -object memory-backend-ram,id=3Dmem0,size=3D2048M                 =
              \
>        -object memory-backend-ram,id=3Dmem1,size=3D2048M                 =
              \
>        -numa node,nodeid=3D0,memdev=3Dmem0,cpus=3D0-1                    =
                \
>        -numa node,nodeid=3D1,memdev=3Dmem1,cpus=3D2-3                    =
                \
>        -L /home/gavin/sandbox/qemu.main/build/pc-bios                    =
          \
>        -monitor none -serial mon:stdio -nographic -gdb tcp::6666         =
          \
>        -qmp tcp:localhost:5555,server,wait=3Doff                         =
            \
>        -bios /home/gavin/sandbox/qemu.main/build/pc-bios/edk2-aarch64-cod=
e.fd      \
>        -kernel /home/gavin/sandbox/linux.guest/arch/arm64/boot/Image     =
          \
>        -initrd /home/gavin/sandbox/images/rootfs.cpio.xz                 =
          \
>        -append memhp_default_state=3Donline_movable
>          :
>          :
> guest$ cd /sys/devices/system/cpu/
> guest$ cat present enabled online
> 0-3
> 0-1
> 0-1
> (qemu) device_set host-arm-cpu,socket-id=3D1,cluster-id=3D0,core-id=3D0,t=
hread-id=3D0,admin-state=3Denable
> qemu-system-aarch64: kvm_init_vcpu: kvm_arch_init_vcpu failed (2): Operat=
ion not permitted


Ah, I see. I think I understand the issue. It's complaining
about calling the  finalize twice. Is it possible to check as
I do not have a way to test it?


int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu, int feature)
{
switch (feature) {
case KVM_ARM_VCPU_SVE:
[...]
if (kvm_arm_vcpu_sve_finalized(vcpu))
return -EPERM;-----> this where it must be popping?
[...]
}


>
> I picked the fix (the last patch in rfc-v6.2 branch) to rfc-v6 branch, sa=
me crash dump
> can be seen.

Are you getting previously reported abort or above new problem?


Thanks
Salil.

