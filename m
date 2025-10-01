Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDDDCAC5B8
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 00:25:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3kd1-0006N4-0f; Tue, 30 Sep 2025 20:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3kcz-0006LS-Ev
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 20:23:29 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3kcf-0004yT-9B
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 20:23:25 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7a32c0163bfso324618a34.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 17:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1759278183; x=1759882983; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eul+VXhBaf1gkE6wZjYYdv3LhFGB9jY9qNWLj4CGGe0=;
 b=UNRyKEDL6I+o+1Se7NBOIsXWSAmgaexzaBON0dIFcSRXpNMTcZSpZd54wVP3kxEQY7
 YgnKK7hrnKZ7h3rCoXEVz9F9f5aEcOcJrO5muls8xPuhIte4nvrXy6QjTiA7t2t9WYwt
 QSs3uXPm3zs30i//7NYK+9yE5kIfUQxE4011zVsdMSM8L3is9WbunfQTCtwuMCNwoqlP
 ypx0SFK421pbM8ApvASysNqkW25HwDxpqtNJXuTekGoxmd94fXblZviBZ5yOUqMUH2bh
 GSb/8w+zBXZZgBpxxQwzSQPNvp6WOVZ37dWCmux1D1B11DBRYOIZ77jAoitOk5zKVLQb
 VXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759278183; x=1759882983;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eul+VXhBaf1gkE6wZjYYdv3LhFGB9jY9qNWLj4CGGe0=;
 b=ZOlXeKVta22DS1xh6nBllBPkDF80JcAiAiISLKGNbX5oo4SRw+ks8/GdcqMphKnIzn
 04f6aVA2B0AEDRn75xwGjaUtaMzVJVLBuq95Ac16IO8BG6shrCxCamfA7k5mfaAvXRX7
 r6vkCvpRceK4oJYsb33uBiMuDvljLt4gNIxo2FwCipnVECwZPatdpuc52nbOM4jJQUZh
 6+pkHz4R6Amc+zCg0RWOhnJLeQyPIcPqAlrw72O3YNDK0DqB/WkGHAHfJs9LMk7OXmgu
 DjfUnv+cWsYZFGSH5T3Z5RT/adkk5HThZomft/DDuazM+4XZROLVvPF8JlpQ0qB9SyOo
 wPPA==
X-Gm-Message-State: AOJu0YwUesKUcGHUCknS8ikYYpj4vxL/l1+RUv3BX03xdEpNA9plbuvM
 uzhfq8hm25nnfFoYzj3Q4r7JyVC7ItEMKMcBJe6SsJB+Rispwg04guTmAm1s/LEa8vYbpl/b/Es
 2l9G0D2LqNsJ39NhQTFwHxSpqBVZhPZUG/3NtBAEk/w==
X-Gm-Gg: ASbGnctZmofwZ/00EzjLEIA3RChjixpmOtQOgm1vDDNKFD360WA3DNmjQeGX4EYnJBS
 fgfFafcjMmtwYiqRBGwZeV5/FYiDT5BAKJgDHvawiRBOGCBqzTbcFAw4k/SZbJo5MDjXNBeAFFl
 mtKS5wwzPlQd6UIISaU0WsYomrVJ3NgIj+ixoan0p4VNqwPNIHQ7WtXYNmEtfMDa/O7OdrMClkA
 cBOgLQvOKYRfTpxquFvNe1uHWqqbzEg2DTUk+77GZZ5V7quV+NzzPr3d0inFV4HITWZzQoSkmZS
 rAZ6zLbfY2qM
X-Google-Smtp-Source: AGHT+IHfdFiRxY9aI7zxG0vobKFTy7h5g6Hpsjf4b4qMOAhjNVJWXIj9ASyyEV0khxiA4xbR3tzTSPLVrvrfZpzEujM=
X-Received: by 2002:a05:6808:2f10:b0:43d:20d2:aee1 with SMTP id
 5614622812f47-43fa392ace0mr1042641b6e.12.1759278182747; Tue, 30 Sep 2025
 17:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250930224037.224833-1-salil.mehta@huawei.com>
In-Reply-To: <20250930224037.224833-1-salil.mehta@huawei.com>
From: Salil Mehta <salil.mehta@opnsrc.net>
Date: Wed, 1 Oct 2025 00:22:51 +0000
X-Gm-Features: AS18NWCNnocbHMS2SHiE9qLygNXCwIAQti07u6U3eISdg-THfZFiOPB2qY6wOKQ
Message-ID: <CAJ7pxea721f4EwqpDdcztgRoN-rsB2tqthf-_Kb+mmsRkK1GyQ@mail.gmail.com>
Subject: Re: [PATCH RFC V6 00/24] Support of Virtual CPU Hotplug-like Feature
 for ARMv8+ Arch
To: Salil Mehta <salil.mehta@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com, maz@kernel.org,
 jean-philippe@linaro.org, jonathan.cameron@huawei.com, lpieralisi@kernel.org, 
 peter.maydell@linaro.org, richard.henderson@linaro.org, imammedo@redhat.com, 
 armbru@redhat.com, andrew.jones@linux.dev, david@redhat.com, 
 philmd@linaro.org, eric.auger@redhat.com, will@kernel.org, ardb@kernel.org, 
 oliver.upton@linux.dev, pbonzini@redhat.com, gshan@redhat.com, 
 rafael@kernel.org, borntraeger@linux.ibm.com, alex.bennee@linaro.org, 
 gustavo.romero@linaro.org, npiggin@gmail.com, harshpb@linux.ibm.com, 
 linux@armlinux.org.uk, darren@os.amperecomputing.com, 
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com, 
 gankulkarni@os.amperecomputing.com, karl.heubaum@oracle.com, 
 miguel.luis@oracle.com, zhukeqian1@huawei.com, wangxiongfeng2@huawei.com, 
 wangyanan55@huawei.com, wangzhou1@hisilicon.com, linuxarm@huawei.com, 
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn, 
 shahuang@redhat.com, zhao1.liu@intel.com
Content-Type: multipart/alternative; boundary="00000000000024e1ec06400ddf52"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URI_DOTEDU=1 autolearn=no autolearn_force=no
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

--00000000000024e1ec06400ddf52
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I am unable to find the patch-set I sent on 30th September in the qemu-deve=
l
mailing list archives. I am checking internally with my company=E2=80=99s I=
T
department,
but in the meantime, could you please advise on possible reasons why it may
not
have appeared on the list?

Any leads would be much appreciated.

Best regards,
Salil

On Tue, Sep 30, 2025 at 10:41=E2=80=AFPM Salil Mehta <salil.mehta@huawei.co=
m> wrote:

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (I) Prologue
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> This patch series adds support for a virtual CPU hotplug-like feature (in
> terms
> of usage) to Armv8+ platforms. Administrators are able to dynamically
> scale the
> compute capacity on demand by adding or removing vCPUs. The interface is
> similar
> in look-and-feel to the vCPU hotplug feature supported on x86 platforms.
> While
> this series for Arm platforms shares the end goal with x86, it is
> implemented
> differently because of inherent differences in the CPU architecture and t=
he
> constraints it imposes.
>
> In this implementation, the meaning of "CPU hotplug" is as described in
> the Arm
> Power State Coordination Interface (PSCI) specification (DEN0022F.b, =C2=
=A74.3
> "CPU
> hotplug and secondary CPU boot", =C2=A75.5, 5.6). This definition has not
> changed.
> On Arm platforms, the guest kernel itself can request CPU onlining or
> offlining
> using PSCI calls (via SMC/HVC), since the CPU_ON and CPU_OFF functions ar=
e
> part
> of the standard PSCI interface exposed to the non-secure world.
>
> This patch series instead adds the infrastructure required to implement
> administrative policy control in QEMU/VMM (as privileged software) along
> with
> the ability to convey changes via ACPI to the guest kernel. This ensures
> the
> guest is notified of compute capacity changes that result from per-vCPU
> administrative policy. This is conceptually similar to the traditional CP=
U
> hotplug mechanism that x86 follows. It allows or denies guest-initiated
> PSCI
> CPU_ON/OFF requests by enabling or disabling an already ACPI-described an=
d
> present vCPU via HMP/QMP 'device_set' (a new interface), making it
> (un)available
> to the guest kernel. This provides the look-and-feel of vCPU hotplug
> through
> ACPI _STA.Enabled toggling, while keeping all vCPUs enumerated in ACPI
> tables at
> boot.
>
> Unlike x86, where vCPUs can become not-present after boot and the kernel
> (maybe
> because architecture allows this?) tolerates some level of dynamic topolo=
gy
> changes, the Arm CPU Architecture requires that the number of vCPUs and
> their
> associated redistributors remain fixed once the system has booted.
> Consequently,
> the Arm host kernel and guest kernel do not tolerate removal or addition
> of CPU
> objects after boot.
>
> Offline vCPUs remain described to guest firmware and OSPM, and can be
> brought
> online later by toggling the ACPI _STA Enabled bit. This model aligns wit=
h
> ACPI 6.5 (Table 5.37, GICC CPU Interface Flags), which introduced the
> "Online
> Capable" bit to signal processors that can be enabled at runtime. It is
> also
> consistent with the Arm GIC Architecture Specification (IHI0069H, =C2=A71=
1.1),
> which
> defines CPU interface power domain behavior.
>
> Corresponding kernel changes from James Morse (ARM) have already been
> accepted
> and are part of the mainline Linux kernel since 6.11 release.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (II) Summary of `Recent` Key Changes
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> RFC V5 -> RFC V6
>
> (*) KeyChange: Introduced new infrastructure to handle administrative
> PowerState
>     transitions (enable-to-disable & vice-versa) as-per Policy.
> (*) Stopped using the existing vCPU Hotplug infrastructure code
> (*) Replaced 'device_add/-device' with new 'device_set/-deviceset'
> interface
> (*) Introduced '-smp disabledcpus=3DN' parameter for Qemu CLI
> (*) Dropped 'info hotpluggable'. Added 'info cpus-powerstate' command
> (*) Introduced DeviceState::admin_power_state
> property=3D{enabled,disabled,removed} states
> (*) Introduced new 'PowerStateHandlder' abstract interface with powerstat=
e
> hooks.
> (*) Dropped destruction of disabled vCPU objects post cpu init.
> (*) Dropped vCPU Hotplug ACPI support introduced ACPI/GED specifcally for
> ARM type vCPUs
> (*) Dropped GIC IRQ unwiring support once VM is initialized.
> (*) Dropped vCPU unrealization support. Retained lazy realization of
> disabled vCPUs(boot time).
> (*) All vCPU objects exist for lifetime of VM.
> (*) Introduced a separate ACPI CPU/OSPM interface to handle device check,
> eject
>     request etc. to intimate gues kernel about change in policy.
> (*) Introduced new concept of *userspace parking* of 'disabled' KVM vCPUs
> (*) We do not migrate disabled vCPUs
> (*) Mitigation to pause_all_vcpus() problem. Caching the ICC_CTLR_EL1 in
> Qemu
> (*) Stopped reconciling (for now) vCPU config at destination VM during
> Migration
>
> Dropped Due to change in vCPU handling approach:
>
> [PATCH RFC V5 03/30] hw/arm/virt: Move setting of common vCPU properties
> in a function
> [PATCH RFC V5 04/30] arm/virt, target/arm: Machine init time change commo=
n
> to vCPU {cold|hot}-plug
> [PATCH RFC V5 09/30] arm/acpi: Enable ACPI support for vCPU hotplug
> [PATCH RFC V5 12/30] arm/virt: Release objects for *disabled* possible
> vCPUs after init
> [PATCH RFC V5 14/30] hw/acpi: Make _MAT method optional
> [PATCH RFC V5 16/30] target/arm: Force ARM vCPU *present* status ACPI
> *persistent*
> [PATCH RFC V5 18/30] arm/virt: Changes to (un)wire GICC<->vCPU IRQs durin=
g
> hot-(un)plug
> [PATCH RFC V5 22/30] target/arm/cpu: Check if hotplugged ARM vCPU's FEAT
> match existing
> [PATCH RFC V5 24/30] target/arm: Add support to *unrealize* ARMCPU during
> vCPU Hot-unplug
> [PATCH RFC V5 25/30] tcg/mttcg: Introduce MTTCG thread unregistration leg
> [PATCH RFC V5 30/30] hw/arm/virt: Expose cold-booted vCPUs as MADT GICC
> *Enabled*
>
> Modified or Code reused in other patches:
>
> [PATCH RFC V5 19/30] hw/arm, gicv3: Changes to notify GICv3 CPU state wit=
h
> vCPU hot-(un)plug event
> [PATCH RFC V5 17/30] arm/virt: Add/update basic hot-(un)plug framework
> [PATCH RFC V5 20/30] hw/arm: Changes required for reset and to support
> next boot
> [PATCH RFC V5 21/30] arm/virt: Update the guest(via GED) about vCPU
> hot-(un)plug events
>
> ---------------------------------
> [!] Expectations From This RFC v6
> ---------------------------------
>
> Please refer to the DISCLAIMER in Section (XI) for the correct
> expectations from
> this version of the RFC
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (II) Motivation
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Adds virtual CPU hot-plug-like support for ARMv8+ Arch in QEMU. Allows
> vCPUs to
> be brought online or offline after VM boot, similar to x86 arch, while
> keeping
> all CPU resources provisioned and described at startup. Enables scaling
> guest VM
> compute capacity on demand, useful in several scenarios:
>
> 1. Vertical Pod Autoscaling [9][10] in the cloud: As part of an
> orchestration
>    framework, resource requests (CPU and memory) for containers in a pod
> can be
>    adjusted dynamically based on usage.
>
> 2. Pay-as-you-grow business model: Infrastructure providers may allocate
> and
>    restrict the total compute resources available to a guest VM according
> to
>    the SLA (Service Level Agreement). VM owners can then request addition=
al
>    CPUs to be hot-plugged at extra cost.
>
> In Kubernetes environments, workloads such as Kata Container VMs often
> adopt
> a "hot-plug everything" model: start with the minimum resources and add
> vCPUs
> later as needed. For example, a VM may boot with just one vCPU, then scal=
e
> up
> once the workload is provisioned. This approach provides:
>
> 1. Faster boot times, and
> 2. Lower memory footprint.
>
> vCPU hot-plug is therefore one of the steps toward realizing the broader
> "hot-plug everything" objective. Other hot-plug mechanisms already exist
> on ARM,
> such as ACPI-based memory hot-plug and PCIe device hot-plug, and are
> supported
> in both QEMU and the Linux guest. Extending vCPU hot-plug in this series
> aligns
> with those efforts and fills the remaining gap.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (III) Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The ARM architecture does not support physical CPU hot-plug and lacks a
> specification describing the behavior of per-CPU components (e.g. GIC CPU
> interface, redistributors, PMUs, timers) when such events occur. As a
> result,
> both host and guest kernels are intolerant to changes in the number of CP=
Us
> enumerated by firmware and described by ACPI at boot time.
>
> We need to respect these architectural constraints and the kernel
> limitations
> they impose, namely the inability to tolerate changes in the number of CP=
Us
> enumerated by firmware once the system has booted, and create a practical
> solution with workarounds in the VMM/QEMU.
>
> This patch set implements a non-intrusive solution by provisioning all vC=
PU
> resources during VM initialization and exposing them via ACPI to the gues=
t
> kernel. The resources remain fixed, while the effect of hot-plug is
> achieved by
> toggling ACPI CPU status (enabled) bits to bring vCPUs online or offline.
>
> -----------
> Terminology
> -----------
>
> (*) Possible CPUs: Total vCPUs that could ever exist in the VM. This
> includes
>                    any 'present' & 'enabled' CPUs plus any CPUs that are
>                    'present' but are 'disabled' at boottime.
>                    - Qemu parameter (-smp cpus=3DN1, disabled=3DN2)
>                    - Possible vCPUs =3D N1 + N2
> (*) Present CPUs:  Possible CPUs that are ACPI 'present'. These might or
> might
>                    not be ACPI 'enabled'.
> (*) Enabled CPUs:  Possible CPUs that are ACPI 'present' and 'enabled' an=
d
> can
>                    now be =E2=80=98onlined=E2=80=99 (PSCI) for use by the=
 Guest Kernel.
> All cold-
>                    booted vCPUs are ACPI 'enabled' at boot. Later, using
>                    'device_set/-deviceset', more vCPUs can be ACPI
> 'enabled'.
>
>
> Below are further details of the constraints:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (IV) Constraints Due to ARMv8+ CPU Architecture
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> A. Physical Limitation to Support CPU Hotplug: (Architectural Constraint)
>
>    1. ARMv8 CPU architecture does not support the concept of the physical
> CPU
>       hotplug.
>       a. There are many per-CPU components like PMU, SVE, MTE, Arch
> timers, etc.,
>          whose behavior needs to be clearly defined when the CPU is
>          hot(un)plugged. Current specification does not define this nor
> are any
>          immediate plans from ARM to extend support for such a feature.
>    2. Other ARM components like GIC, etc., have not been designed to
> realize
>       physical CPU hotplug capability as of now. For example,
>       a. Every physical CPU has a unique GICC (GIC CPU Interface) by
> construct.
>          Architecture does not specify what CPU hot(un)plug would mean in
>          context to any of these.
>       b. CPUs/GICC are physically connected to unique GICR (GIC
> Redistributor).
>          GIC Redistributors are always part of the always-on power domain=
.
> Hence,
>          they cannot be powered off as per specification.
>
> B. Limitation in Firmware/ACPI (Architectural Constraint)
>
>    1. Firmware has to expose GICC, GICR, and other per-CPU features like
> PMU,
>       SVE, MTE, Arch Timers, etc., to the OS. Due to the architectural
> constraint
>       stated in section A1(a), all interrupt controller structures of
>       MADT describing GIC CPU Interfaces and the GIC Redistributors MUST =
be
>       presented by firmware to the OSPM during boot time.
>    2. Architectures that support CPU hotplug can evaluate the ACPI _MAT
> method
>       to get this kind of information from the firmware even after boot,
> and the
>       OSPM has the capability to process these. ARM kernel uses
> information in
>       MADT interrupt controller structures to identify the number of
> present CPUs
>       during boot and hence does not allow to change these after boot. Th=
e
> number
>       of present CPUs cannot be changed. It is an architectural constrain=
t!
>
> C. Limitations in KVM to Support Virtual CPU Hotplug (Architectural
> Constraint)
>
>    1. KVM VGIC:
>       a. Sizing of various VGIC resources like memory regions, etc.,
> related to
>          the redistributor happens only once and is fixed at the VM init
> time
>          and cannot be changed later after initialization has happened.
>          KVM statically configures these resources based on the number of
> vCPUs
>          and the number/size of redistributor ranges.
>       b. Association between vCPU and its VGIC redistributor is fixed at
> the
>          VM init time within the KVM, i.e., when redistributor iodevs get=
s
>          registered. VGIC does not allow to setup/change this association
>          after VM initialization has happened. Physically, every CPU/GICC
> is
>          uniquely connected with its redistributor, and there is no
>          architectural way to set this up.
>    2. KVM vCPUs:
>       a. Lack of specification means destruction of KVM vCPUs does not
> exist as
>          there is no reference to tell what to do with other per-vCPU
>          components like redistributors, arch timer, etc.
>       b. In fact, KVM does not implement the destruction of vCPUs for any
>          architecture. This is independent of whether the architecture
>          actually supports CPU Hotplug feature. For example, even for x86
> KVM
>          does not implement the destruction of vCPUs.
>
> D. Considerations in Qemu due to ARM CPU Architecture & related KVM
> Constraints:
>
>    1. Qemu CPU Objects MUST be created to initialize all the Host KVM
> vCPUs to
>       overcome the KVM constraint. KVM vCPUs are created and initialized
> when
>       Qemu CPU Objects are realized.
>    2. The 'GICV3State' and 'GICV3CPUState' objects must be sized for all
> possible
>       vCPUs at VM initialization, when the QOM GICv3 object is realized.
> This is
>       required because the KVM VGIC can only be initialized once, and the
> number
>       of redistributors, their per-vCPU interfaces, and associated data
>       structures or I/O device regions are all fixed at VM init time.
>    3. How should new QOM CPU objects be connected back to the
> 'GICV3CPUState'
>       objects and disconnected from it in case the CPU is being
> hot(un)plugged?
>    4. How should 'unplugged' or 'yet-to-be-plugged' vCPUs be represented
> in the
>       QOM for which KVM vCPU already exists? For example, whether to keep=
,
>        a. No QOM CPU objects Or
>        b. Unrealized CPU Objects
>    5. How should vCPU state be exposed via ACPI to the Guest? Especially
> for
>       the unplugged/yet-to-be-plugged vCPUs whose CPU objects might not
> exist
>       within the QOM but the Guest always expects all possible vCPUs to b=
e
>       identified as ACPI *present* during boot.
>    6. How should Qemu expose GIC CPU interfaces for the unplugged or
>       yet-to-be-plugged vCPUs using ACPI MADT Table to the Guest?
>
> E. How are the above questions addressed in this QEMU implementation?
>
>    1. Respect the limitations imposed by the Arm architecture in KVM,
> ACPI, and
>       the guest kernel. This requires always keeping the vCPU count
> constant.
>    2. Implement a workaround in QEMU by keeping all vCPUs present and
> toggling
>       the ACPI _STA.Enabled bit to realize a vCPU hotplug-like effect.
>    3. Never destroy vCPU objects once initialized, since they hold the
> ARMCPU
>       state that is set up once during VM initialization.
>    4. Size other per-vCPU components, such as the VGIC CPU interface and
>       redistributors, for the maximum number of vCPUs possible during the
> VM=E2=80=99s
>       lifetime.
>    5. Exit HVC/SMC KVM hypercalls (triggered by PSCI CPU_ON/OFF) to user
> space
>       for policy checks that allow or deny the guest kernel=E2=80=99s pow=
er-on/off
>       request.
>    6. Disabled vCPUs remain parked in user space and are never migrated.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (V) Summary of Flow
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -------------------
> vCPU Initialization
> -------------------
>    1. Keep all vCPUs always enumerated and present (enabled/disabled) in
> the
>       guest kernel, host KVM, and QEMU with topology fixed.
>    2. Realize hotplug-like functionality by toggling the ACPI _STA.Enable=
d
> bit
>       for each vCPU.
>    3. Never destroy a vCPU. vCPU objects and threads remain alive
> throughout the
>       VM lifetime once created. No un-realization handling code is
> required.
>       Threads may be realized lazily for disabled vCPUs.
>    4. At VM init, pre-create all possible vCPUs in KVM, including those
> not yet
>       enabled in QEMU, but keep them in the PSCI powered-off state.
>    5. Park disabled vCPU threads in user space to avoid KVM lock
> contention.
>       This means 'CPUState::halted=3D1'; 'CPUState::stopped=3D1'; and
> 'CPUState::parked=3D1' (new).
> -------------------
> VGIC Initialization
> -------------------
>    6. Size 'GICv3State' and 'GICv3CPUState' objects over possible vCPUs a=
t
> VM
>       init time when the QEMU GIC is realized. This also sizes KVM VGIC
>       resources such  as redistributor regions. This sizing never changes
> after
>       VM init.
> -------------------
> ACPI Initialization
> -------------------
>    7. Build the ACPI MADT table with updates:
>       a. Number of GIC CPU interface entries =3D possible vCPUs.
>       b. Boot vCPU as MADT.GICC.Enabled=3D1 (not hot[un]pluggable).
>       c. Hot[un]pluggable vCPUs as MADT.GICC.online-capable=3D1 and
>          MADT.GICC.Enabled=3D0 (mutually exclusive). These vCPUs can be
> enabled
>          and onlined after guest boot (firmware policy).
>    8. Expose ACPI _STA status to the guest kernel:
>       a. Always _STA.Present=3D1 (all possible vCPUs).
>       b. _STA.Enabled=3D1 (enabled vCPUs =3D plugged).
>       c. _STA.Enabled=3D0 (disabled vCPUs =3D unplugged).
> ---------------------------------------------------------------
> vCPU Administrative *First* Enable [=3D vCPU Hotplug-like Action]
> ---------------------------------------------------------------
>    9. The first administrative enable of a vCPU leads to deferred
> realization of
>       the QEMU vCPU object initialized at VM init:
>       a. Realizes the vCPU object and spawns the QEMU vCPU thread.
>       b. Unparks the existing KVM vCPU ("kvm_parked_vcpus" list).
>       c. Reinitializes the KVM vCPU in the host (reset core/sys regs, set
>          defaults).
>       d. Runs the KVM vCPU (created with 'start-powered-off'). Thread
> waits for
>          PSCI.
>       e. Marks QEMU 'GICv3CPUState' interface accessible.
>       f. Updates ACPI _STA.Enabled=3D1.
>       g. Notifies guest (GED Device-Check). Guest sees Enabled=3D1 and
> registers
>          CPU.
>       h. Guest onlines vCPU (PSCI CPU_ON over HVC/SMC).
>          - KVM exits to QEMU (policy check).
>          - If allowed, QEMU calls `cpu_reset()` and powers on the vCPU in
> KVM.
>          - KVM wakes vCPU thread out of sleep and puts vCPUMP state to
> RUNNABLE
> -----------------------------------------------------------
> vCPU Administrative Disable [=3D vCPU Hot-unplug-like Action]
> -----------------------------------------------------------
>   10. Administrative disable does not un-realize the QOM CPU object or
> destroy
>       the vCPU thread. Instead:
>       a. Notifies guest (GED Eject Request). Guest offlines vCPU (CPU_OFF
> PSCI).
>       b. KVM exits to QEMU (policy check).
>          - QEMU powers off vCPU in KVM and
>          - KVM puts vCPUMP state to STOPPED & sleeps on RCUWait
>       c. Guest signals eject after quiescing vCPU.
>       d. QEMU updates ACPI _STA.Enabled=3D0.
>       e. Marks QEMU 'GICv3CPUState' interface inaccessible.
>       f. Parks the vCPU thread in user space (unblocks from KVM to avoid
> vCPU
>          lock contention):
>          - Unregisters VMSD from migration.
>          - Removes vCPU from present/active lists.
>          - Pauses the vCPU (`cpu_pause`).
>          - Kicks vCPU thread to user space ('CPUState::parked=3D1').
>       g. Guest sees ACPI _STA.Enabled=3D0 and removes CPU (unregisters fr=
om
> LDM).
> --------------------------------------------------------------------
> vCPU Administrative *Subsequent* Enable [=3D vCPU Hotplug-like Action]
> --------------------------------------------------------------------
>   11. A subsequent administrative enable does not realize objects or spaw=
n
> a new
>       thread. Instead:
>       a. Unparks the vCPU thread in user space:
>          - Re-registers VMSD for migration.
>          - Adds back to present/active lists.
>          - Resumes the vCPU (`cpu_resume`).
>          - Clears parked flag ('CPUState::parked=3D0').
>       b. Marks QEMU 'GICv3CPUState' interface accessible again.
>       c. Updates ACPI _STA.Enabled=3D1.
>       d. Notifies guest (GED Device-Check). Guest sees Enabled=3D1 and
> registers
>          CPU.
>       e. Guest onlines vCPU (PSCI CPU_ON over HVC/SMC).
>          - KVM exits to QEMU (policy check).
>          - QEMU sets power-state=3DPSCI_ON, calls `cpu_reset()`, and powe=
rs
> on
>            vCPU.
>          - KVM changes MP state to RUNNABLE.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (VI) Work Presented at KVM Forum Conferences
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Details of the above work have been presented at KVMForum2020 and
> KVMForum2023
> conferences. Slides & video are available at the links below:
> a. KVMForum 2023
>    - Challenges Revisited in Supporting Virt CPU Hotplug on architectures
> that don't Support CPU Hotplug (like ARM64).
>      https://kvm-forum.qemu.org/2023/KVM-forum-cpu-hotplug_7OJ1YyJ.pdf
>
> https://kvm-forum.qemu.org/2023/Challenges_Revisited_in_Supporting_Virt_C=
PU_Hotplug_-__ii0iNb3.pdf
>      https://www.youtube.com/watch?v=3Dhyrw4j2D6I0&t=3D23970s
>      https://kvm-forum.qemu.org/2023/talk/9SMPDQ/
> b. KVMForum 2020
>    - Challenges in Supporting Virtual CPU Hotplug on SoC Based Systems
> (like ARM64) - Salil Mehta, Huawei.
>      https://kvmforum2020.sched.com/event/eE4m
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (VII) Commands Used
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> A. Qemu launch commands to init the machine (with 6 possible vCPUs):
>
> $ qemu-system-aarch64 --enable-kvm -machine virt,gic-version=3D3 \
> -cpu host -smp cpus=3D4,disabled=3D2 \
> -m 300M \
> -kernel Image \
> -initrd rootfs.cpio.gz \
> -append "console=3DttyAMA0 root=3D/dev/ram rdinit=3D/init maxcpus=3D2 acp=
i=3Dforce" \
> -nographic \
> -bios QEMU_EFI.fd \
>
> B. Administrative '[En,Dis]able' [akin to 'Hot-(un)plug'] related command=
s:
>
> # Hot(un)plug a host vCPU (accel=3Dkvm):
> (qemu) device_set host-arm-cpu,id=3Dcore4,core-id=3D4,admin-state=3Denabl=
e
> (qemu) device_set host-arm-cpu,id=3Dcore4,core-id=3D4,admin-state=3Ddisab=
le
>
> # Hot(un)plug a vCPU (accel=3Dtcg):
> (qemu) device_set cortex-a57-arm-cpu,id=3Dcore4,core-id=3D4,admin-state=
=3Denable
> (qemu) device_set cortex-a57-arm-cpu,id=3Dcore4,core-id=3D4,admin-state=
=3Ddisable
>
> Sample output on guest after boot:
>
>     $ cat /sys/devices/system/cpu/possible
>     0-5
>     $ cat /sys/devices/system/cpu/present
>     0-5
>     $ cat /sys/devices/system/cpu/enabled
>     0-3
>     $ cat /sys/devices/system/cpu/online
>     0-1
>     $ cat /sys/devices/system/cpu/offline
>     2-5
>
> Sample output on guest after 'enabling'[=3D'hotplug'] & 'online' of vCPU=
=3D4:
>
>     $ echo 1 > /sys/devices/system/cpu/cpu4/online
>
>     $ cat /sys/devices/system/cpu/possible
>     0-5
>     $ cat /sys/devices/system/cpu/present
>     0-5
>     $ cat /sys/devices/system/cpu/enabled
>     0-4
>     $ cat /sys/devices/system/cpu/online
>     0-1,4
>     $ cat /sys/devices/system/cpu/offline
>     2-3,5
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (VIII) Repositories
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> (*) Latest Qemu RFC V6 (Architecture Specific) patch set:
>     https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-v6
> (*) Older QEMU changes for vCPU hotplug can be cloned from below site:
>     https://github.com/salil-mehta/qemu.git
> virt-cpuhp-armv8/rfc-{v1,v2,v3,v4,v5}
> (*) `Accepted` Qemu Architecture Agnostic patch is present here:
>
> https://github.com/salil-mehta/qemu/commits/virt-cpuhp-armv8/rfc-v3.arch.=
agnostic.v16/
> (*) All Kernel changes are already part of mainline v6.11
> (*) Original Guest Kernel changes (by James Morse, ARM) are available her=
e:
>     https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
> virtual_cpu_hotplug/rfc/v2
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> (IX) KNOWN ISSUES & THINGS TO DO
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>
> 1. TCG currently faces some hang issues due to unhandled cases. We aim to
> fix
>    these within the next one to two weeks.
> 2. Comprehensive testing is ongoing. This is fresh code, and we expect to
>    complete testing within two weeks.
> 3. QEMU documentation (.rst) still needs to be updated.
> 4. Migration has been lightly tested but is working as expected.
> 5. Mitigation to avoid `pause_all_vcpus` needs broader community
> discussion. An
>    alternative change has been prepared in KVM, which maintains a shadow =
of
>    `ICC_CTLR_EL1` to reduce lock contention when using KVM device IOCTLs.
> This
>    avoids synchronization issues if the register value changes during VM
> runtime.
>    While not mandatory, this enhancement would provide a more
> comprehensive fix
>    than the current QEMU assumption that the relevant fields are invarian=
t
> or
>    pseudo-static. An RFC for this KVM change will be floated within a wee=
k.
> 6. Mitigation of parking disabled vCPU threads in user space, to avoid
> blocking
>    them inside KVM, needs review by the wider community to ensure no hidd=
en
>    issues are introduced.
> 7. A discussion (if needed) on why `device_set` was chosen instead of
> `qom-set`
>    for administrative state control.
> 8. CPU_SUSPEND/Standy related handling (if required)
> 9. HVF and qtest are not supported or done yet.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> (X) ORGANIZATION OF PATCHES
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
>  [Patch 1-2, 22-23] New HMP/QMP interface ('device_set') related changes
>     (*) New ('DeviceState::admin_power_state') property; Enabled/Disabled
> States and handling
>     (*) New Qemu CLI parameter ('-smp CPUS, disabled=3DN') handling
>     (*) Logic to find the existing object not part of the QOM
>  [Patch 3-5, 10] logic required during machine init.
>     (*) Some validation checks.
>     (*) Introduces core-id,socket-id,cluster-id property and some util
> functions required later.
>     (*) Logic to setup lazy realization of the QOM vCPUs
>     (*) Logic to pre-create vCPUs in the KVM host kernel.
>  [Patch 6-7, 8-9] logic required to size the GICv3 State
>     (*) GIC initialization pre-sized with possible vCPUs.
>     (*) Introduction of the GICv3 CPU Interface `accessibility` property =
&
> accessors
>     (*) Refactoring to make KVM & TCG 'GICv3CPUState' initialization
> common.
>     (*) Changes in GICv3 post/pre-load function for migration
>  [Patch 11,14-16,19] logic related to ACPI at machine init time.
>     (*) ACPI CPU OSPM interface for ACPI _STA.Enable/Disable handling
>     (*) ACPI GED framework to cater to CPU DeviceCheck/Eject Events.
>     (*) ACPI DSDT, MADT changes.
>  [Patch 12-13, 17] Qdev, Virt Machine, PowerState Handler Changes
>     (*) Changes to introduce 'PowerStateHandler' and its abstract
> interface.
>     (*) Qdev changes to handle the administrative enabling/disabling of
> device
>     (*) Virt Machine implementation of 'PowerStateHandler' Hooks
>     (*) vCPU thread user-space parking and unparking logic.
>  [Patch 18,20-21,24] Misc.
>     (*) Handling of SMCC Hypercall Exits by KVM to Qemu for PSCI.
>     (*) Mitigation to avoid using 'pause_all_vcpus' during ICC_CTLR_EL1
> reset.
>     (*) Mitigation when TCG 'TB Code Cache' is found saturated
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (XI) DISCLAIMER
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> This patch-set is the culmination of over four years of ongoing effort to
> bring
> a vCPU hotplug-like feature to the Arm platform. The work has already led
> to
> changes in the ACPI specification and the Linux kernel, and this series n=
ow
> introduces the missing piece within QEMU.
>
> The transition from RFC v5 to RFC v6 resulted in a shift of approach,
> based on
> maintainer feedback, and required substantial code to be re-written. This
> is
> *not* production-level code and may still contain bugs. Comprehensive
> testing is
> in progress on HiSilicon Kunpeng920 SoCs, Oracle servers, and Ampere
> platforms.
> We expect to fix outstanding issues in the coming month and, subject to n=
o
> major
> concerns from maintainers about the chosen approach, a near-stable, non-R=
FC
> version will be posted soon.
>
> This work largely follows the direction of prior community discussions
> over the
> years [see refs below], including mailing list threads, Linaro Open
> Discussions,
> and sessions at KVM Forum. This RFC is intended to validate the overall
> approach
> outlined here and to gather community feedback before moving forward with=
 a
> formal patch series.
>
> [The concept being presented has been found to work!]
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (XII) Change Log
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> RFC V4 -> RFC V5:
> -----------------
> 1. Dropped "[PATCH RFC V4 19/33] target/arm: Force ARM vCPU *present*
> status ACPI *persistent*"
>    - Seperated the architecture agnostic ACPI changes required to support
> vCPU Hotplug
>      Link:
> https://lore.kernel.org/qemu-devel/20241014192205.253479-1-salil.mehta@hu=
awei.com/#t
> 2. Dropped "[PATCH RFC V4 02/33] cpu-common: Add common CPU utility for
> possible vCPUs"
>    - Dropped qemu{present,enabled}_cpu() APIs. Commented by Gavin
> (Redhat), Miguel(Oracle), Igor(Redhat)
> 3. Added "Reviewed-by: Miguel Luis <miguel.luis@oracle.com>" to [PATCH
> RFC V4 01/33]
> 3. Dropped the `CPUState::disabled` flag and introduced
> `GICv3State::num_smp_cpus` flag
>    - All `GICv3CPUState' between [num_smp_cpus,num_cpus) are marked as
> 'inaccessible` during gicv3_common_realize()
>    - qemu_enabled_cpu() not required - removed!
>    - removed usage of `CPUState::disabled` from virt.c and hw/cpu64.c
> 4. Removed virt_cpu_properties() and introduced property `mp-affinity` ge=
t
> accessor
> 5. Dropped "[PATCH RFC V4 12/33] arm/virt: Create GED device before
> *disabled* vCPU Objects are destroyed"
>
> RFC V3 -> RFC V4:
> -----------------
> 1. Addressed Nicholas Piggin's (IBM) comments
>    - Moved qemu_get_cpu_archid() as a ACPI helper inline acpi/cpu.h
>
> https://lore.kernel.org/qemu-devel/D2GFCLH11HGJ.1IJGANHQ9ZQRL@gmail.com/
>    - Introduced new macro CPU_FOREACH_POSSIBLE() in [PATCH 12/33]
>
> https://lore.kernel.org/qemu-devel/D2GF9A9AJO02.1G1G8UEXA5AOD@gmail.com/
>    - Converted CPUState::acpi_persistent into Property. Improved the cove=
r
> note
>
> https://lore.kernel.org/qemu-devel/D2H62RK48KT7.2BTQEZUOEGG4L@gmail.com/
>    - Fixed teh cover note of the[PATCH ] and clearly mentioned about
> KVMParking
>
> https://lore.kernel.org/qemu-devel/D2GFOGQC3HYO.2LKOV306JIU98@gmail.com/
> 2. Addressed Gavin Shan's (RedHat) comments:
>    - Introduced the ARM Extensions check. [Looks like I missed the PMU
> check :( ]
>
> https://lore.kernel.org/qemu-devel/28f3107f-0267-4112-b0ca-da59df2968ae@r=
edhat.com/
>    - Moved create_gpio() along with create_ged()
>
> https://lore.kernel.org/qemu-devel/143ad7d2-8f45-4428-bed3-891203a49029@r=
edhat.com/
>    - Improved the logic of the GIC creation and initialization
>
> https://lore.kernel.org/qemu-devel/9b7582f0-8149-4bf0-a1aa-4d4fe0d35e70@r=
edhat.com/
>    - Removed redundant !dev->realized checks in cpu_hotunplug(_request)
>
> https://lore.kernel.org/qemu-devel/64e9feaa-8df2-4108-9e73-c72517fb074a@r=
edhat.com/
> 3. Addresses Alex Benn=C3=A9e's + Gustavo Romero (Linaro) comments
>    - Fixed the TCG support and now it works for all the cases including
> migration.
>      https://lore.kernel.org/qemu-devel/87bk1b3azm.fsf@draig.linaro.org/
>    - Fixed the cpu_address_space_destroy() compilation failuer in user-mo=
de
>      https://lore.kernel.org/qemu-devel/87v800wkb1.fsf@draig.linaro.org/
> 4. Fixed crash in .post_gicv3() during migration with asymmetrically
> *enabled*
>      vCPUs at destination VM
>
> RFC V2 -> RFC V3:
> -----------------
> 1. Miscellaneous:
>    - Split the RFC V2 into arch-agnostic and arch-specific patch sets.
> 2. Addressed Gavin Shan's (RedHat) comments:
>    - Made CPU property accessors inline.
>
> https://lore.kernel.org/qemu-devel/6cd28639-2cfa-f233-c6d9-d5d2ec5b1c58@r=
edhat.com/
>    - Collected Reviewed-bys [PATCH RFC V2 4/37, 14/37, 22/37].
>    - Dropped the patch as it was not required after init logic was
> refactored.
>
> https://lore.kernel.org/qemu-devel/4fb2eef9-6742-1eeb-721a-b3db04b1be97@r=
edhat.com/
>    - Fixed the range check for the core during vCPU Plug.
>
> https://lore.kernel.org/qemu-devel/1c5fa24c-6bf3-750f-4f22-087e4a9311af@r=
edhat.com/
>    - Added has_hotpluggable_vcpus check to make build_cpus_aml()
> conditional.
>
> https://lore.kernel.org/qemu-devel/832342cb-74bc-58dd-c5d7-6f995baeb0f2@r=
edhat.com/
>    - Fixed the states initialization in cpu_hotplug_hw_init() to
> accommodate previous refactoring.
>
> https://lore.kernel.org/qemu-devel/da5e5609-1883-8650-c7d8-6868c7b74f1c@r=
edhat.com/
>    - Fixed typos.
>
> https://lore.kernel.org/qemu-devel/eb1ac571-7844-55e6-15e7-3dd7df21366b@r=
edhat.com/
>    - Removed the unnecessary 'goto fail'.
>
> https://lore.kernel.org/qemu-devel/4d8980ac-f402-60d4-fe52-787815af8a7d@r=
edhat.com/#t
>    - Added check for hotpluggable vCPUs in the _OSC method.
>
> https://lore.kernel.org/qemu-devel/20231017001326.FUBqQ1PTowF2GxQpnL3kIW0=
AhmSqbspazwixAHVSi6c@z/
> 3. Addressed Shaoqin Huang's (Intel) comments:
>    - Fixed the compilation break due to the absence of a call to
> virt_cpu_properties() missing
>      along with its definition.
>
> https://lore.kernel.org/qemu-devel/3632ee24-47f7-ae68-8790-26eb2cf9950b@r=
edhat.com/
> 4. Addressed Jonathan Cameron's (Huawei) comments:
>    - Gated the 'disabled vcpu message' for GIC version < 3.
>
> https://lore.kernel.org/qemu-devel/20240116155911.00004fe1@Huawei.com/
>
> RFC V1 -> RFC V2:
> -----------------
> 1. Addressed James Morse's (ARM) requirement as per Linaro Open Discussio=
n:
>    - Exposed all possible vCPUs as always ACPI _STA.present and available
> during boot time.
>    - Added the _OSC handling as required by James's patches.
>    - Introduction of 'online-capable' bit handling in the flag of MADT
> GICC.
>    - SMCC Hypercall Exit handling in Qemu.
> 2. Addressed Marc Zyngier's comment:
>    - Fixed the note about GIC CPU Interface in the cover letter.
> 3. Addressed issues raised by Vishnu Pajjuru (Ampere) & Miguel Luis
> (Oracle) during testing:
>    - Live/Pseudo Migration crashes.
> 4. Others:
>    - Introduced the concept of persistent vCPU at QOM.
>    - Introduced wrapper APIs of present, possible, and persistent.
>    - Change at ACPI hotplug H/W init leg accommodating initializing
> is_present and is_enabled states.
>    - Check to avoid unplugging cold-booted vCPUs.
>    - Disabled hotplugging with TCG/HVF/QTEST.
>    - Introduced CPU Topology, {socket, cluster, core, thread}-id property=
.
>    - Extract virt CPU properties as a common virt_vcpu_properties()
> function.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (XIII) ACKNOWLEDGEMENTS
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> I would like to thank the following people for various discussions with m=
e
> over
> different channels during development:
>
> Marc Zyngier (Google), Catalin Marinas (ARM), James Morse (ARM), Will
> Deacon (Google),
> Jean-Philippe Brucker (Linaro), Sudeep Holla (ARM), Lorenzo Pieralisi
> (Linaro),
> Gavin Shan (RedHat), Jonathan Cameron (Huawei), Darren Hart (Ampere),
> Igor Mammedov (RedHat), Ilkka Koskinen (Ampere), Andrew Jones (RedHat),
> Karl Heubaum (Oracle), Keqian Zhu (Huawei), Miguel Luis (Oracle),
> Xiongfeng Wang (Huawei), Vishnu Pajjuri (Ampere), Shameerali Kolothum
> (Huawei),
> Russell King (Oracle), Xuwei/Joy (Huawei), Peter Maydel (Linaro),
> Zengtao/Prime (Huawei), Nicholas Piggin (IBM), Alex Benn=C3=A9e(Linaro) a=
nd all
> those
> whom I have missed!
>
> Many thanks to the following people for their current or past
> contributions:
>
> 1. James Morse (ARM)
>    (Current Kernel part of vCPU Hotplug Support on AARCH64)
> 2. Jean-Philippe Brucker (Linaro)
>    (Prototyped one of the earlier PSCI-based POC [17][18] based on RFC V1=
)
> 3. Keqian Zhu (Huawei)
>    (Co-developed Qemu prototype)
> 4. Xiongfeng Wang (Huawei)
>    (Co-developed an earlier kernel prototype with me)
> 5. Vishnu Pajjuri (Ampere)
>    (Verification on Ampere ARM64 Platforms + fixes)
> 6. Miguel Luis (Oracle)
>    (Verification on Oracle ARM64 Platforms + fixes)
> 7. Russell King (Oracle) & Jonathan Cameron (Huawei)
>    (Helping in upstreaming James Morse's Kernel patches).
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (XIV) REFERENCES
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> [1]
> https://lore.kernel.org/qemu-devel/20200613213629.21984-1-salil.mehta@hua=
wei.com/
> [2]
> https://lore.kernel.org/linux-arm-kernel/20200625133757.22332-1-salil.meh=
ta@huawei.com/
> [3]
> https://lore.kernel.org/lkml/20230203135043.409192-1-james.morse@arm.com/
> [4] https://lore.kernel.org/all/20230913163823.7880-1-james.morse@arm.com=
/
> [5]
> https://lore.kernel.org/all/20230404154050.2270077-1-oliver.upton@linux.d=
ev/
> [6] https://bugzilla.tianocore.org/show_bug.cgi?id=3D3706
> [7]
> https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#g=
ic-cpu-interface-gicc-structure
> [8] https://bugzilla.tianocore.org/show_bug.cgi?id=3D4481#c5
> [9]
> https://cloud.google.com/kubernetes-engine/docs/concepts/verticalpodautos=
caler
> [10]
> https://docs.aws.amazon.com/eks/latest/userguide/vertical-pod-autoscaler.=
html
> [11] https://lkml.org/lkml/2019/7/10/235
> [12] https://lists.cs.columbia.edu/pipermail/kvmarm/2018-July/032316.html
> [13] https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg06517.html
> [14]
> https://op-lists.linaro.org/archives/list/linaro-open-discussions@op-list=
s.linaro.org/thread/7CGL6JTACPUZEYQC34CZ2ZBWJGSR74WE/
> [15] http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg01168.htm=
l
> [16] https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00131.html
> [17]
> https://op-lists.linaro.org/archives/list/linaro-open-discussions@op-list=
s.linaro.org/message/X74JS6P2N4AUWHHATJJVVFDI2EMDZJ74/
> [18]
> https://lore.kernel.org/lkml/20210608154805.216869-1-jean-philippe@linaro=
.org/
> [19]
> https://lore.kernel.org/all/20230913163823.7880-1-james.morse@arm.com/
> [20]
> https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#g=
icc-cpu-interface-flags
> [21]
> https://lore.kernel.org/qemu-devel/20230926100436.28284-1-salil.mehta@hua=
wei.com/
> [22]
> https://lore.kernel.org/qemu-devel/20240607115649.214622-1-salil.mehta@hu=
awei.com/T/#md0887eb07976bc76606a8204614ccc7d9a01c1f7
> [23] RFC V3:
> https://lore.kernel.org/qemu-devel/20240613233639.202896-1-salil.mehta@hu=
awei.com/#t
>
> Author Salil Mehta (1):
>   target/arm/kvm,tcg: Handle SMCCC hypercall exits in VMM during
> PSCI_CPU_{ON,OFF}
>
> Jean-Philippe Brucker (1):
>   target/arm/kvm: Write vCPU's state back to KVM on cold-reset
>
> Salil Mehta (22):
>   hw/core: Introduce administrative power-state property and its accessor=
s
>   hw/core, qemu-options.hx: Introduce 'disabledcpus' SMP parameter
>   hw/arm/virt: Clamp 'maxcpus' as-per machine's vCPU deferred
> online-capability
>   arm/virt,target/arm: Add new ARMCPU {socket,cluster,core,thread}-id
> property
>   arm/virt,kvm: Pre-create KVM vCPUs for 'disabled' QOM vCPUs at machine
> init
>   arm/virt,gicv3: Pre-size GIC with possible vCPUs at machine init
>   arm/gicv3: Refactor CPU interface init for shared TCG/KVM use
>   arm/virt, gicv3: Guard CPU interface access for admin disabled vCPUs
>   hw/intc/arm_gicv3_common: Migrate & check 'GICv3CPUState' accessibility
> mismatch
>   arm/virt: Init PMU at host for all present vCPUs
>   hw/arm/acpi: MADT change to size the guest with possible vCPUs
>   hw/core: Introduce generic device power-state handler interface
>   qdev: make admin power state changes trigger platform transitions via
> ACPI
>   arm/acpi: Introduce dedicated CPU OSPM interface for ARM-like platforms
>   acpi/ged: Notify OSPM of CPU administrative state changes via GED
>   arm/virt/acpi: Update ACPI DSDT Tbl to include 'Online-Capable' CPUs AM=
L
>   hw/arm/virt,acpi/ged: Add PowerStateHandler hooks for runtime CPU state
> changes
>   target/arm/cpu: Add the Accessor hook to fetch ARM CPU arch-id
>   hw/intc/arm-gicv3-kvm: Pause all vCPUs & cache ICC_CTLR_EL1 for
> userspace PSCI CPU_ON
>   monitor,qdev: Introduce 'device_set' to change admin state of existing
> devices
>   monitor,qapi: add 'info cpus-powerstate' and QMP query (Admin + Oper
> states)
>   tcg: Defer TB flush for 'lazy realized' vCPUs on first region alloc
>
>  accel/kvm/kvm-all.c                    |   2 +-
>  accel/tcg/tcg-accel-ops-mttcg.c        |   2 +-
>  accel/tcg/tcg-accel-ops-rr.c           |   2 +-
>  cpu-common.c                           |   4 +-
>  hmp-commands-info.hx                   |  32 ++
>  hmp-commands.hx                        |  30 +
>  hw/acpi/Kconfig                        |   3 +
>  hw/acpi/acpi-cpu-ospm-interface-stub.c |  41 ++
>  hw/acpi/cpu_ospm_interface.c           | 747 +++++++++++++++++++++++++
>  hw/acpi/generic_event_device.c         |  91 +++
>  hw/acpi/meson.build                    |   2 +
>  hw/acpi/trace-events                   |  17 +
>  hw/arm/Kconfig                         |   1 +
>  hw/arm/virt-acpi-build.c               |  75 ++-
>  hw/arm/virt.c                          | 573 +++++++++++++++++--
>  hw/core/cpu-common.c                   |  12 +
>  hw/core/machine-hmp-cmds.c             |  62 ++
>  hw/core/machine-qmp-cmds.c             | 107 ++++
>  hw/core/machine-smp.c                  |  24 +-
>  hw/core/machine.c                      |  28 +
>  hw/core/meson.build                    |   1 +
>  hw/core/powerstate.c                   | 100 ++++
>  hw/core/qdev.c                         | 197 +++++++
>  hw/intc/arm_gicv3.c                    |   1 +
>  hw/intc/arm_gicv3_common.c             |  64 ++-
>  hw/intc/arm_gicv3_cpuif.c              | 270 ++++-----
>  hw/intc/arm_gicv3_cpuif_common.c       |  58 ++
>  hw/intc/arm_gicv3_kvm.c                | 123 +++-
>  hw/intc/gicv3_internal.h               |   1 +
>  include/hw/acpi/acpi_dev_interface.h   |   1 +
>  include/hw/acpi/cpu_ospm_interface.h   |  78 +++
>  include/hw/acpi/generic_event_device.h |   6 +
>  include/hw/arm/virt.h                  |  42 +-
>  include/hw/boards.h                    |  37 ++
>  include/hw/core/cpu.h                  |  71 +++
>  include/hw/intc/arm_gicv3_common.h     |  65 +++
>  include/hw/powerstate.h                | 177 ++++++
>  include/hw/qdev-core.h                 | 151 +++++
>  include/monitor/hmp.h                  |   3 +
>  include/monitor/qdev.h                 |  30 +
>  include/system/kvm.h                   |   8 +
>  include/system/system.h                |   1 +
>  include/tcg/startup.h                  |   6 +
>  include/tcg/tcg.h                      |   1 +
>  qapi/machine.json                      |  90 +++
>  qemu-options.hx                        | 129 ++++-
>  stubs/meson.build                      |   1 +
>  stubs/powerstate-stubs.c               |  47 ++
>  system/cpus.c                          |   4 +-
>  system/qdev-monitor.c                  | 139 ++++-
>  system/vl.c                            |  42 ++
>  target/arm/arm-powerctl.c              |  29 +-
>  target/arm/cpu.c                       |  14 +
>  target/arm/cpu.h                       |   5 +
>  target/arm/helper.c                    |   2 +-
>  target/arm/internals.h                 |   2 +-
>  target/arm/kvm.c                       | 140 ++++-
>  target/arm/kvm_arm.h                   |  25 +
>  target/arm/meson.build                 |   1 +
>  target/arm/{tcg =3D> }/psci.c            |   9 +
>  target/arm/tcg/meson.build             |   4 -
>  tcg/region.c                           |  16 +
>  tcg/tcg.c                              |  19 +-
>  63 files changed, 3800 insertions(+), 265 deletions(-)
>  create mode 100644 hw/acpi/acpi-cpu-ospm-interface-stub.c
>  create mode 100644 hw/acpi/cpu_ospm_interface.c
>  create mode 100644 hw/core/powerstate.c
>  create mode 100644 include/hw/acpi/cpu_ospm_interface.h
>  create mode 100644 include/hw/powerstate.h
>  create mode 100644 stubs/powerstate-stubs.c
>  rename target/arm/{tcg =3D> }/psci.c (96%)
>
> --
> 2.34.1
>
>

--00000000000024e1ec06400ddf52
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div>He=
llo,</div><div><br></div><div>I am unable to find the patch-set I sent on 3=
0th September in the qemu-devel</div><div>mailing list archives. I am check=
ing internally with my company=E2=80=99s IT department,</div><div>but in th=
e meantime, could you please advise on possible reasons why it may not</div=
><div>have appeared on the list?</div><div><br></div><div>Any leads would b=
e much appreciated.</div><div><br></div><div>Best regards,</div><div>Salil<=
br></div></div></div></div></div><br><div class=3D"gmail_quote gmail_quote_=
container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 30, 2025 at 10=
:41=E2=80=AFPM Salil Mehta &lt;<a href=3D"mailto:salil.mehta@huawei.com">sa=
lil.mehta@huawei.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
(I) Prologue<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
This patch series adds support for a virtual CPU hotplug-like feature (in t=
erms<br>
of usage) to Armv8+ platforms. Administrators are able to dynamically scale=
 the<br>
compute capacity on demand by adding or removing vCPUs. The interface is si=
milar<br>
in look-and-feel to the vCPU hotplug feature supported on x86 platforms. Wh=
ile<br>
this series for Arm platforms shares the end goal with x86, it is implement=
ed<br>
differently because of inherent differences in the CPU architecture and the=
<br>
constraints it imposes.<br>
<br>
In this implementation, the meaning of &quot;CPU hotplug&quot; is as descri=
bed in the Arm<br>
Power State Coordination Interface (PSCI) specification (DEN0022F.b, =C2=A7=
4.3 &quot;CPU<br>
hotplug and secondary CPU boot&quot;, =C2=A75.5, 5.6). This definition has =
not changed.<br>
On Arm platforms, the guest kernel itself can request CPU onlining or offli=
ning<br>
using PSCI calls (via SMC/HVC), since the CPU_ON and CPU_OFF functions are =
part<br>
of the standard PSCI interface exposed to the non-secure world.<br>
<br>
This patch series instead adds the infrastructure required to implement<br>
administrative policy control in QEMU/VMM (as privileged software) along wi=
th<br>
the ability to convey changes via ACPI to the guest kernel. This ensures th=
e<br>
guest is notified of compute capacity changes that result from per-vCPU<br>
administrative policy. This is conceptually similar to the traditional CPU<=
br>
hotplug mechanism that x86 follows. It allows or denies guest-initiated PSC=
I<br>
CPU_ON/OFF requests by enabling or disabling an already ACPI-described and<=
br>
present vCPU via HMP/QMP &#39;device_set&#39; (a new interface), making it =
(un)available<br>
to the guest kernel. This provides the look-and-feel of vCPU hotplug throug=
h<br>
ACPI _STA.Enabled toggling, while keeping all vCPUs enumerated in ACPI tabl=
es at<br>
boot.<br>
<br>
Unlike x86, where vCPUs can become not-present after boot and the kernel (m=
aybe<br>
because architecture allows this?) tolerates some level of dynamic topology=
<br>
changes, the Arm CPU Architecture requires that the number of vCPUs and the=
ir<br>
associated redistributors remain fixed once the system has booted. Conseque=
ntly,<br>
the Arm host kernel and guest kernel do not tolerate removal or addition of=
 CPU<br>
objects after boot.<br>
<br>
Offline vCPUs remain described to guest firmware and OSPM, and can be broug=
ht<br>
online later by toggling the ACPI _STA Enabled bit. This model aligns with<=
br>
ACPI 6.5 (Table 5.37, GICC CPU Interface Flags), which introduced the &quot=
;Online<br>
Capable&quot; bit to signal processors that can be enabled at runtime. It i=
s also<br>
consistent with the Arm GIC Architecture Specification (IHI0069H, =C2=A711.=
1), which<br>
defines CPU interface power domain behavior.<br>
<br>
Corresponding kernel changes from James Morse (ARM) have already been accep=
ted<br>
and are part of the mainline Linux kernel since 6.11 release.<br>
<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
(II) Summary of `Recent` Key Changes<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
RFC V5 -&gt; RFC V6<br>
<br>
(*) KeyChange: Introduced new infrastructure to handle administrative Power=
State<br>
=C2=A0 =C2=A0 transitions (enable-to-disable &amp; vice-versa) as-per Polic=
y.<br>
(*) Stopped using the existing vCPU Hotplug infrastructure code<br>
(*) Replaced &#39;device_add/-device&#39; with new &#39;device_set/-devices=
et&#39; interface<br>
(*) Introduced &#39;-smp disabledcpus=3DN&#39; parameter for Qemu CLI<br>
(*) Dropped &#39;info hotpluggable&#39;. Added &#39;info cpus-powerstate&#3=
9; command<br>
(*) Introduced DeviceState::admin_power_state property=3D{enabled,disabled,=
removed} states<br>
(*) Introduced new &#39;PowerStateHandlder&#39; abstract interface with pow=
erstate hooks.<br>
(*) Dropped destruction of disabled vCPU objects post cpu init.<br>
(*) Dropped vCPU Hotplug ACPI support introduced ACPI/GED specifcally for A=
RM type vCPUs<br>
(*) Dropped GIC IRQ unwiring support once VM is initialized.<br>
(*) Dropped vCPU unrealization support. Retained lazy realization of disabl=
ed vCPUs(boot time).<br>
(*) All vCPU objects exist for lifetime of VM.<br>
(*) Introduced a separate ACPI CPU/OSPM interface to handle device check, e=
ject<br>
=C2=A0 =C2=A0 request etc. to intimate gues kernel about change in policy.<=
br>
(*) Introduced new concept of *userspace parking* of &#39;disabled&#39; KVM=
 vCPUs <br>
(*) We do not migrate disabled vCPUs<br>
(*) Mitigation to pause_all_vcpus() problem. Caching the ICC_CTLR_EL1 in Qe=
mu<br>
(*) Stopped reconciling (for now) vCPU config at destination VM during Migr=
ation<br>
<br>
Dropped Due to change in vCPU handling approach:<br>
<br>
[PATCH RFC V5 03/30] hw/arm/virt: Move setting of common vCPU properties in=
 a function<br>
[PATCH RFC V5 04/30] arm/virt, target/arm: Machine init time change common =
to vCPU {cold|hot}-plug<br>
[PATCH RFC V5 09/30] arm/acpi: Enable ACPI support for vCPU hotplug<br>
[PATCH RFC V5 12/30] arm/virt: Release objects for *disabled* possible vCPU=
s after init<br>
[PATCH RFC V5 14/30] hw/acpi: Make _MAT method optional<br>
[PATCH RFC V5 16/30] target/arm: Force ARM vCPU *present* status ACPI *pers=
istent*<br>
[PATCH RFC V5 18/30] arm/virt: Changes to (un)wire GICC&lt;-&gt;vCPU IRQs d=
uring hot-(un)plug<br>
[PATCH RFC V5 22/30] target/arm/cpu: Check if hotplugged ARM vCPU&#39;s FEA=
T match existing<br>
[PATCH RFC V5 24/30] target/arm: Add support to *unrealize* ARMCPU during v=
CPU Hot-unplug<br>
[PATCH RFC V5 25/30] tcg/mttcg: Introduce MTTCG thread unregistration leg<b=
r>
[PATCH RFC V5 30/30] hw/arm/virt: Expose cold-booted vCPUs as MADT GICC *En=
abled*<br>
<br>
Modified or Code reused in other patches:<br>
<br>
[PATCH RFC V5 19/30] hw/arm, gicv3: Changes to notify GICv3 CPU state with =
vCPU hot-(un)plug event<br>
[PATCH RFC V5 17/30] arm/virt: Add/update basic hot-(un)plug framework<br>
[PATCH RFC V5 20/30] hw/arm: Changes required for reset and to support next=
 boot<br>
[PATCH RFC V5 21/30] arm/virt: Update the guest(via GED) about vCPU hot-(un=
)plug events<br>
<br>
---------------------------------<br>
[!] Expectations From This RFC v6<br>
---------------------------------<br>
<br>
Please refer to the DISCLAIMER in Section (XI) for the correct expectations=
 from<br>
this version of the RFC<br>
<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
(II) Motivation<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
Adds virtual CPU hot-plug-like support for ARMv8+ Arch in QEMU. Allows vCPU=
s to<br>
be brought online or offline after VM boot, similar to x86 arch, while keep=
ing<br>
all CPU resources provisioned and described at startup. Enables scaling gue=
st VM<br>
compute capacity on demand, useful in several scenarios:<br>
<br>
1. Vertical Pod Autoscaling [9][10] in the cloud: As part of an orchestrati=
on<br>
=C2=A0 =C2=A0framework, resource requests (CPU and memory) for containers i=
n a pod can be<br>
=C2=A0 =C2=A0adjusted dynamically based on usage.<br>
<br>
2. Pay-as-you-grow business model: Infrastructure providers may allocate an=
d<br>
=C2=A0 =C2=A0restrict the total compute resources available to a guest VM a=
ccording to<br>
=C2=A0 =C2=A0the SLA (Service Level Agreement). VM owners can then request =
additional<br>
=C2=A0 =C2=A0CPUs to be hot-plugged at extra cost.<br>
<br>
In Kubernetes environments, workloads such as Kata Container VMs often adop=
t<br>
a &quot;hot-plug everything&quot; model: start with the minimum resources a=
nd add vCPUs<br>
later as needed. For example, a VM may boot with just one vCPU, then scale =
up<br>
once the workload is provisioned. This approach provides:<br>
<br>
1. Faster boot times, and<br>
2. Lower memory footprint.<br>
<br>
vCPU hot-plug is therefore one of the steps toward realizing the broader<br=
>
&quot;hot-plug everything&quot; objective. Other hot-plug mechanisms alread=
y exist on ARM,<br>
such as ACPI-based memory hot-plug and PCIe device hot-plug, and are suppor=
ted<br>
in both QEMU and the Linux guest. Extending vCPU hot-plug in this series al=
igns<br>
with those efforts and fills the remaining gap.<br>
<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
(III) Background<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
The ARM architecture does not support physical CPU hot-plug and lacks a<br>
specification describing the behavior of per-CPU components (e.g. GIC CPU<b=
r>
interface, redistributors, PMUs, timers) when such events occur. As a resul=
t,<br>
both host and guest kernels are intolerant to changes in the number of CPUs=
<br>
enumerated by firmware and described by ACPI at boot time.<br>
<br>
We need to respect these architectural constraints and the kernel limitatio=
ns<br>
they impose, namely the inability to tolerate changes in the number of CPUs=
<br>
enumerated by firmware once the system has booted, and create a practical<b=
r>
solution with workarounds in the VMM/QEMU.<br>
<br>
This patch set implements a non-intrusive solution by provisioning all vCPU=
<br>
resources during VM initialization and exposing them via ACPI to the guest<=
br>
kernel. The resources remain fixed, while the effect of hot-plug is achieve=
d by<br>
toggling ACPI CPU status (enabled) bits to bring vCPUs online or offline.<b=
r>
<br>
-----------<br>
Terminology<br>
-----------<br>
<br>
(*) Possible CPUs: Total vCPUs that could ever exist in the VM. This includ=
es<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0any &#=
39;present&#39; &amp; &#39;enabled&#39; CPUs plus any CPUs that are<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;p=
resent&#39; but are &#39;disabled&#39; at boottime.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- Qemu=
 parameter (-smp cpus=3DN1, disabled=3DN2)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- Poss=
ible vCPUs =3D N1 + N2<br>
(*) Present CPUs:=C2=A0 Possible CPUs that are ACPI &#39;present&#39;. Thes=
e might or might<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0not be=
 ACPI &#39;enabled&#39;. <br>
(*) Enabled CPUs:=C2=A0 Possible CPUs that are ACPI &#39;present&#39; and &=
#39;enabled&#39; and can<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0now be=
 =E2=80=98onlined=E2=80=99 (PSCI) for use by the Guest Kernel. All cold-<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0booted=
 vCPUs are ACPI &#39;enabled&#39; at boot. Later, using<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;d=
evice_set/-deviceset&#39;, more vCPUs can be ACPI &#39;enabled&#39;.<br>
<br>
<br>
Below are further details of the constraints:<br>
<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
(IV) Constraints Due to ARMv8+ CPU Architecture<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
A. Physical Limitation to Support CPU Hotplug: (Architectural Constraint)<b=
r>
<br>
=C2=A0 =C2=A01. ARMv8 CPU architecture does not support the concept of the =
physical CPU<br>
=C2=A0 =C2=A0 =C2=A0 hotplug. <br>
=C2=A0 =C2=A0 =C2=A0 a. There are many per-CPU components like PMU, SVE, MT=
E, Arch timers, etc.,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0whose behavior needs to be clearly define=
d when the CPU is<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hot(un)plugged. Current specification doe=
s not define this nor are any<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0immediate plans from ARM to extend suppor=
t for such a feature.<br>
=C2=A0 =C2=A02. Other ARM components like GIC, etc., have not been designed=
 to realize<br>
=C2=A0 =C2=A0 =C2=A0 physical CPU hotplug capability as of now. For example=
,<br>
=C2=A0 =C2=A0 =C2=A0 a. Every physical CPU has a unique GICC (GIC CPU Inter=
face) by construct.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Architecture does not specify what CPU ho=
t(un)plug would mean in<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0context to any of these.<br>
=C2=A0 =C2=A0 =C2=A0 b. CPUs/GICC are physically connected to unique GICR (=
GIC Redistributor).<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GIC Redistributors are always part of the=
 always-on power domain. Hence,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0they cannot be powered off as per specifi=
cation.<br>
<br>
B. Limitation in Firmware/ACPI (Architectural Constraint)<br>
<br>
=C2=A0 =C2=A01. Firmware has to expose GICC, GICR, and other per-CPU featur=
es like PMU,<br>
=C2=A0 =C2=A0 =C2=A0 SVE, MTE, Arch Timers, etc., to the OS. Due to the arc=
hitectural constraint<br>
=C2=A0 =C2=A0 =C2=A0 stated in section A1(a), all interrupt controller stru=
ctures of<br>
=C2=A0 =C2=A0 =C2=A0 MADT describing GIC CPU Interfaces and the GIC Redistr=
ibutors MUST be<br>
=C2=A0 =C2=A0 =C2=A0 presented by firmware to the OSPM during boot time.<br=
>
=C2=A0 =C2=A02. Architectures that support CPU hotplug can evaluate the ACP=
I _MAT method<br>
=C2=A0 =C2=A0 =C2=A0 to get this kind of information from the firmware even=
 after boot, and the<br>
=C2=A0 =C2=A0 =C2=A0 OSPM has the capability to process these. ARM kernel u=
ses information in<br>
=C2=A0 =C2=A0 =C2=A0 MADT interrupt controller structures to identify the n=
umber of present CPUs<br>
=C2=A0 =C2=A0 =C2=A0 during boot and hence does not allow to change these a=
fter boot. The number<br>
=C2=A0 =C2=A0 =C2=A0 of present CPUs cannot be changed. It is an architectu=
ral constraint!<br>
<br>
C. Limitations in KVM to Support Virtual CPU Hotplug (Architectural Constra=
int)<br>
<br>
=C2=A0 =C2=A01. KVM VGIC:<br>
=C2=A0 =C2=A0 =C2=A0 a. Sizing of various VGIC resources like memory region=
s, etc., related to<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the redistributor happens only once and i=
s fixed at the VM init time<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0and cannot be changed later after initial=
ization has happened.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0KVM statically configures these resources=
 based on the number of vCPUs<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0and the number/size of redistributor rang=
es.<br>
=C2=A0 =C2=A0 =C2=A0 b. Association between vCPU and its VGIC redistributor=
 is fixed at the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VM init time within the KVM, i.e., when r=
edistributor iodevs gets<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0registered. VGIC does not allow to setup/=
change this association<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0after VM initialization has happened. Phy=
sically, every CPU/GICC is<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uniquely connected with its redistributor=
, and there is no<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0architectural way to set this up.<br>
=C2=A0 =C2=A02. KVM vCPUs:<br>
=C2=A0 =C2=A0 =C2=A0 a. Lack of specification means destruction of KVM vCPU=
s does not exist as<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0there is no reference to tell what to do =
with other per-vCPU<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0components like redistributors, arch time=
r, etc.<br>
=C2=A0 =C2=A0 =C2=A0 b. In fact, KVM does not implement the destruction of =
vCPUs for any<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0architecture. This is independent of whet=
her the architecture<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0actually supports CPU Hotplug feature. Fo=
r example, even for x86 KVM<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0does not implement the destruction of vCP=
Us.<br>
<br>
D. Considerations in Qemu due to ARM CPU Architecture &amp; related KVM Con=
straints:<br>
<br>
=C2=A0 =C2=A01. Qemu CPU Objects MUST be created to initialize all the Host=
 KVM vCPUs to<br>
=C2=A0 =C2=A0 =C2=A0 overcome the KVM constraint. KVM vCPUs are created and=
 initialized when<br>
=C2=A0 =C2=A0 =C2=A0 Qemu CPU Objects are realized.<br>
=C2=A0 =C2=A02. The &#39;GICV3State&#39; and &#39;GICV3CPUState&#39; object=
s must be sized for all possible<br>
=C2=A0 =C2=A0 =C2=A0 vCPUs at VM initialization, when the QOM GICv3 object =
is realized. This is<br>
=C2=A0 =C2=A0 =C2=A0 required because the KVM VGIC can only be initialized =
once, and the number<br>
=C2=A0 =C2=A0 =C2=A0 of redistributors, their per-vCPU interfaces, and asso=
ciated data<br>
=C2=A0 =C2=A0 =C2=A0 structures or I/O device regions are all fixed at VM i=
nit time.<br>
=C2=A0 =C2=A03. How should new QOM CPU objects be connected back to the &#3=
9;GICV3CPUState&#39;<br>
=C2=A0 =C2=A0 =C2=A0 objects and disconnected from it in case the CPU is be=
ing hot(un)plugged?<br>
=C2=A0 =C2=A04. How should &#39;unplugged&#39; or &#39;yet-to-be-plugged&#3=
9; vCPUs be represented in the<br>
=C2=A0 =C2=A0 =C2=A0 QOM for which KVM vCPU already exists? For example, wh=
ether to keep,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0a. No QOM CPU objects Or<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0b. Unrealized CPU Objects<br>
=C2=A0 =C2=A05. How should vCPU state be exposed via ACPI to the Guest? Esp=
ecially for<br>
=C2=A0 =C2=A0 =C2=A0 the unplugged/yet-to-be-plugged vCPUs whose CPU object=
s might not exist<br>
=C2=A0 =C2=A0 =C2=A0 within the QOM but the Guest always expects all possib=
le vCPUs to be<br>
=C2=A0 =C2=A0 =C2=A0 identified as ACPI *present* during boot.<br>
=C2=A0 =C2=A06. How should Qemu expose GIC CPU interfaces for the unplugged=
 or<br>
=C2=A0 =C2=A0 =C2=A0 yet-to-be-plugged vCPUs using ACPI MADT Table to the G=
uest?<br>
<br>
E. How are the above questions addressed in this QEMU implementation?<br>
<br>
=C2=A0 =C2=A01. Respect the limitations imposed by the Arm architecture in =
KVM, ACPI, and<br>
=C2=A0 =C2=A0 =C2=A0 the guest kernel. This requires always keeping the vCP=
U count constant.<br>
=C2=A0 =C2=A02. Implement a workaround in QEMU by keeping all vCPUs present=
 and toggling<br>
=C2=A0 =C2=A0 =C2=A0 the ACPI _STA.Enabled bit to realize a vCPU hotplug-li=
ke effect.<br>
=C2=A0 =C2=A03. Never destroy vCPU objects once initialized, since they hol=
d the ARMCPU<br>
=C2=A0 =C2=A0 =C2=A0 state that is set up once during VM initialization.<br=
>
=C2=A0 =C2=A04. Size other per-vCPU components, such as the VGIC CPU interf=
ace and<br>
=C2=A0 =C2=A0 =C2=A0 redistributors, for the maximum number of vCPUs possib=
le during the VM=E2=80=99s<br>
=C2=A0 =C2=A0 =C2=A0 lifetime.<br>
=C2=A0 =C2=A05. Exit HVC/SMC KVM hypercalls (triggered by PSCI CPU_ON/OFF) =
to user space<br>
=C2=A0 =C2=A0 =C2=A0 for policy checks that allow or deny the guest kernel=
=E2=80=99s power-on/off<br>
=C2=A0 =C2=A0 =C2=A0 request.<br>
=C2=A0 =C2=A06. Disabled vCPUs remain parked in user space and are never mi=
grated.<br>
<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=C2=A0 <br>
(V) Summary of Flow=C2=A0 <br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=C2=A0 <br>
<br>
-------------------=C2=A0 <br>
vCPU Initialization=C2=A0 <br>
-------------------=C2=A0 <br>
=C2=A0 =C2=A01. Keep all vCPUs always enumerated and present (enabled/disab=
led) in the<br>
=C2=A0 =C2=A0 =C2=A0 guest kernel, host KVM, and QEMU with topology fixed.=
=C2=A0 <br>
=C2=A0 =C2=A02. Realize hotplug-like functionality by toggling the ACPI _ST=
A.Enabled bit<br>
=C2=A0 =C2=A0 =C2=A0 for each vCPU.=C2=A0 <br>
=C2=A0 =C2=A03. Never destroy a vCPU. vCPU objects and threads remain alive=
 throughout the<br>
=C2=A0 =C2=A0 =C2=A0 VM lifetime once created. No un-realization handling c=
ode is required.<br>
=C2=A0 =C2=A0 =C2=A0 Threads may be realized lazily for disabled vCPUs.=C2=
=A0 <br>
=C2=A0 =C2=A04. At VM init, pre-create all possible vCPUs in KVM, including=
 those not yet<br>
=C2=A0 =C2=A0 =C2=A0 enabled in QEMU, but keep them in the PSCI powered-off=
 state.=C2=A0 <br>
=C2=A0 =C2=A05. Park disabled vCPU threads in user space to avoid KVM lock =
contention.<br>
=C2=A0 =C2=A0 =C2=A0 This means &#39;CPUState::halted=3D1&#39;; &#39;CPUSta=
te::stopped=3D1&#39;; and &#39;CPUState::parked=3D1&#39; (new).=C2=A0 <br>
-------------------=C2=A0 <br>
VGIC Initialization=C2=A0 <br>
-------------------=C2=A0 <br>
=C2=A0 =C2=A06. Size &#39;GICv3State&#39; and &#39;GICv3CPUState&#39; objec=
ts over possible vCPUs at VM<br>
=C2=A0 =C2=A0 =C2=A0 init time when the QEMU GIC is realized. This also siz=
es KVM VGIC<br>
=C2=A0 =C2=A0 =C2=A0 resources such=C2=A0 as redistributor regions. This si=
zing never changes after<br>
=C2=A0 =C2=A0 =C2=A0 VM init.<br>
-------------------=C2=A0 <br>
ACPI Initialization=C2=A0 <br>
-------------------=C2=A0 <br>
=C2=A0 =C2=A07. Build the ACPI MADT table with updates:=C2=A0 <br>
=C2=A0 =C2=A0 =C2=A0 a. Number of GIC CPU interface entries =3D possible vC=
PUs.=C2=A0 <br>
=C2=A0 =C2=A0 =C2=A0 b. Boot vCPU as MADT.GICC.Enabled=3D1 (not hot[un]plug=
gable).=C2=A0 <br>
=C2=A0 =C2=A0 =C2=A0 c. Hot[un]pluggable vCPUs as MADT.GICC.online-capable=
=3D1 and=C2=A0 <br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MADT.GICC.Enabled=3D0 (mutually exclusive=
). These vCPUs can be enabled<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0and onlined after guest boot (firmware po=
licy).=C2=A0 <br>
=C2=A0 =C2=A08. Expose ACPI _STA status to the guest kernel:=C2=A0 <br>
=C2=A0 =C2=A0 =C2=A0 a. Always _STA.Present=3D1 (all possible vCPUs).=C2=A0=
 <br>
=C2=A0 =C2=A0 =C2=A0 b. _STA.Enabled=3D1 (enabled vCPUs =3D plugged).=C2=A0=
 <br>
=C2=A0 =C2=A0 =C2=A0 c. _STA.Enabled=3D0 (disabled vCPUs =3D unplugged).=C2=
=A0 <br>
---------------------------------------------------------------=C2=A0 <br>
vCPU Administrative *First* Enable [=3D vCPU Hotplug-like Action]=C2=A0 <br=
>
---------------------------------------------------------------=C2=A0 <br>
=C2=A0 =C2=A09. The first administrative enable of a vCPU leads to deferred=
 realization of<br>
=C2=A0 =C2=A0 =C2=A0 the QEMU vCPU object initialized at VM init:=C2=A0 <br=
>
=C2=A0 =C2=A0 =C2=A0 a. Realizes the vCPU object and spawns the QEMU vCPU t=
hread.=C2=A0 <br>
=C2=A0 =C2=A0 =C2=A0 b. Unparks the existing KVM vCPU (&quot;kvm_parked_vcp=
us&quot; list).=C2=A0 <br>
=C2=A0 =C2=A0 =C2=A0 c. Reinitializes the KVM vCPU in the host (reset core/=
sys regs, set<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0defaults). <br>
=C2=A0 =C2=A0 =C2=A0 d. Runs the KVM vCPU (created with &#39;start-powered-=
off&#39;). Thread waits for<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PSCI.<br>
=C2=A0 =C2=A0 =C2=A0 e. Marks QEMU &#39;GICv3CPUState&#39; interface access=
ible.=C2=A0 <br>
=C2=A0 =C2=A0 =C2=A0 f. Updates ACPI _STA.Enabled=3D1.=C2=A0 <br>
=C2=A0 =C2=A0 =C2=A0 g. Notifies guest (GED Device-Check). Guest sees Enabl=
ed=3D1 and registers<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPU. <br>
=C2=A0 =C2=A0 =C2=A0 h. Guest onlines vCPU (PSCI CPU_ON over HVC/SMC).=C2=
=A0 <br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- KVM exits to QEMU (policy check).=C2=A0=
 <br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- If allowed, QEMU calls `cpu_reset()` an=
d powers on the vCPU in KVM.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- KVM wakes vCPU thread out of sleep and =
puts vCPUMP state to RUNNABLE <br>
-----------------------------------------------------------=C2=A0 <br>
vCPU Administrative Disable [=3D vCPU Hot-unplug-like Action]=C2=A0 <br>
-----------------------------------------------------------=C2=A0 <br>
=C2=A0 10. Administrative disable does not un-realize the QOM CPU object or=
 destroy<br>
=C2=A0 =C2=A0 =C2=A0 the vCPU thread. Instead:=C2=A0 <br>
=C2=A0 =C2=A0 =C2=A0 a. Notifies guest (GED Eject Request). Guest offlines =
vCPU (CPU_OFF PSCI).<br>
=C2=A0 =C2=A0 =C2=A0 b. KVM exits to QEMU (policy check). <br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- QEMU powers off vCPU in KVM and<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- KVM puts vCPUMP state to STOPPED &amp; =
sleeps on RCUWait<br>
=C2=A0 =C2=A0 =C2=A0 c. Guest signals eject after quiescing vCPU.=C2=A0 <br=
>
=C2=A0 =C2=A0 =C2=A0 d. QEMU updates ACPI _STA.Enabled=3D0.=C2=A0 <br>
=C2=A0 =C2=A0 =C2=A0 e. Marks QEMU &#39;GICv3CPUState&#39; interface inacce=
ssible.=C2=A0 <br>
=C2=A0 =C2=A0 =C2=A0 f. Parks the vCPU thread in user space (unblocks from =
KVM to avoid vCPU<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lock contention):=C2=A0 <br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- Unregisters VMSD from migration.=C2=A0 =
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- Removes vCPU from present/active lists.=
=C2=A0 <br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- Pauses the vCPU (`cpu_pause`).=C2=A0 <b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- Kicks vCPU thread to user space (&#39;C=
PUState::parked=3D1&#39;).=C2=A0 <br>
=C2=A0 =C2=A0 =C2=A0 g. Guest sees ACPI _STA.Enabled=3D0 and removes CPU (u=
nregisters from LDM).<br>
--------------------------------------------------------------------=C2=A0 =
<br>
vCPU Administrative *Subsequent* Enable [=3D vCPU Hotplug-like Action]=C2=
=A0 <br>
--------------------------------------------------------------------=C2=A0 =
<br>
=C2=A0 11. A subsequent administrative enable does not realize objects or s=
pawn a new<br>
=C2=A0 =C2=A0 =C2=A0 thread. Instead:=C2=A0 <br>
=C2=A0 =C2=A0 =C2=A0 a. Unparks the vCPU thread in user space:=C2=A0 <br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- Re-registers VMSD for migration.=C2=A0 =
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- Adds back to present/active lists.=C2=
=A0 <br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- Resumes the vCPU (`cpu_resume`).=C2=A0 =
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- Clears parked flag (&#39;CPUState::park=
ed=3D0&#39;).=C2=A0 <br>
=C2=A0 =C2=A0 =C2=A0 b. Marks QEMU &#39;GICv3CPUState&#39; interface access=
ible again.=C2=A0 <br>
=C2=A0 =C2=A0 =C2=A0 c. Updates ACPI _STA.Enabled=3D1.=C2=A0 <br>
=C2=A0 =C2=A0 =C2=A0 d. Notifies guest (GED Device-Check). Guest sees Enabl=
ed=3D1 and registers<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPU.<br>
=C2=A0 =C2=A0 =C2=A0 e. Guest onlines vCPU (PSCI CPU_ON over HVC/SMC).=C2=
=A0 <br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- KVM exits to QEMU (policy check).=C2=A0=
 <br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- QEMU sets power-state=3DPSCI_ON, calls =
`cpu_reset()`, and powers on<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vCPU.=C2=A0 <br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- KVM changes MP state to RUNNABLE.=C2=A0=
 <br>
<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
(VI) Work Presented at KVM Forum Conferences<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
Details of the above work have been presented at KVMForum2020 and KVMForum2=
023<br>
conferences. Slides &amp; video are available at the links below:<br>
a. KVMForum 2023<br>
=C2=A0 =C2=A0- Challenges Revisited in Supporting Virt CPU Hotplug on archi=
tectures that don&#39;t Support CPU Hotplug (like ARM64).<br>
=C2=A0 =C2=A0 =C2=A0<a href=3D"https://kvm-forum.qemu.org/2023/KVM-forum-cp=
u-hotplug_7OJ1YyJ.pdf" rel=3D"noreferrer" target=3D"_blank">https://kvm-for=
um.qemu.org/2023/KVM-forum-cpu-hotplug_7OJ1YyJ.pdf</a><br>
=C2=A0 =C2=A0 =C2=A0<a href=3D"https://kvm-forum.qemu.org/2023/Challenges_R=
evisited_in_Supporting_Virt_CPU_Hotplug_-__ii0iNb3.pdf" rel=3D"noreferrer" =
target=3D"_blank">https://kvm-forum.qemu.org/2023/Challenges_Revisited_in_S=
upporting_Virt_CPU_Hotplug_-__ii0iNb3.pdf</a><br>
=C2=A0 =C2=A0 =C2=A0<a href=3D"https://www.youtube.com/watch?v=3Dhyrw4j2D6I=
0&amp;t=3D23970s" rel=3D"noreferrer" target=3D"_blank">https://www.youtube.=
com/watch?v=3Dhyrw4j2D6I0&amp;t=3D23970s</a><br>
=C2=A0 =C2=A0 =C2=A0<a href=3D"https://kvm-forum.qemu.org/2023/talk/9SMPDQ/=
" rel=3D"noreferrer" target=3D"_blank">https://kvm-forum.qemu.org/2023/talk=
/9SMPDQ/</a><br>
b. KVMForum 2020<br>
=C2=A0 =C2=A0- Challenges in Supporting Virtual CPU Hotplug on SoC Based Sy=
stems (like ARM64) - Salil Mehta, Huawei.<br>
=C2=A0 =C2=A0 =C2=A0<a href=3D"https://kvmforum2020.sched.com/event/eE4m" r=
el=3D"noreferrer" target=3D"_blank">https://kvmforum2020.sched.com/event/eE=
4m</a><br>
<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
(VII) Commands Used<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
A. Qemu launch commands to init the machine (with 6 possible vCPUs):<br>
<br>
$ qemu-system-aarch64 --enable-kvm -machine virt,gic-version=3D3 \<br>
-cpu host -smp cpus=3D4,disabled=3D2 \<br>
-m 300M \<br>
-kernel Image \<br>
-initrd rootfs.cpio.gz \<br>
-append &quot;console=3DttyAMA0 root=3D/dev/ram rdinit=3D/init maxcpus=3D2 =
acpi=3Dforce&quot; \<br>
-nographic \<br>
-bios QEMU_EFI.fd \<br>
<br>
B. Administrative &#39;[En,Dis]able&#39; [akin to &#39;Hot-(un)plug&#39;] r=
elated commands:<br>
<br>
# Hot(un)plug a host vCPU (accel=3Dkvm):<br>
(qemu) device_set host-arm-cpu,id=3Dcore4,core-id=3D4,admin-state=3Denable<=
br>
(qemu) device_set host-arm-cpu,id=3Dcore4,core-id=3D4,admin-state=3Ddisable=
<br>
<br>
# Hot(un)plug a vCPU (accel=3Dtcg):<br>
(qemu) device_set cortex-a57-arm-cpu,id=3Dcore4,core-id=3D4,admin-state=3De=
nable<br>
(qemu) device_set cortex-a57-arm-cpu,id=3Dcore4,core-id=3D4,admin-state=3Dd=
isable<br>
<br>
Sample output on guest after boot:<br>
<br>
=C2=A0 =C2=A0 $ cat /sys/devices/system/cpu/possible<br>
=C2=A0 =C2=A0 0-5<br>
=C2=A0 =C2=A0 $ cat /sys/devices/system/cpu/present<br>
=C2=A0 =C2=A0 0-5<br>
=C2=A0 =C2=A0 $ cat /sys/devices/system/cpu/enabled<br>
=C2=A0 =C2=A0 0-3<br>
=C2=A0 =C2=A0 $ cat /sys/devices/system/cpu/online<br>
=C2=A0 =C2=A0 0-1<br>
=C2=A0 =C2=A0 $ cat /sys/devices/system/cpu/offline<br>
=C2=A0 =C2=A0 2-5<br>
<br>
Sample output on guest after &#39;enabling&#39;[=3D&#39;hotplug&#39;] &amp;=
 &#39;online&#39; of vCPU=3D4:<br>
<br>
=C2=A0 =C2=A0 $ echo 1 &gt; /sys/devices/system/cpu/cpu4/online<br>
<br>
=C2=A0 =C2=A0 $ cat /sys/devices/system/cpu/possible<br>
=C2=A0 =C2=A0 0-5<br>
=C2=A0 =C2=A0 $ cat /sys/devices/system/cpu/present<br>
=C2=A0 =C2=A0 0-5<br>
=C2=A0 =C2=A0 $ cat /sys/devices/system/cpu/enabled<br>
=C2=A0 =C2=A0 0-4<br>
=C2=A0 =C2=A0 $ cat /sys/devices/system/cpu/online<br>
=C2=A0 =C2=A0 0-1,4<br>
=C2=A0 =C2=A0 $ cat /sys/devices/system/cpu/offline<br>
=C2=A0 =C2=A0 2-3,5<br>
<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
(VIII) Repositories<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
(*) Latest Qemu RFC V6 (Architecture Specific) patch set:<br>
=C2=A0 =C2=A0 <a href=3D"https://github.com/salil-mehta/qemu.git" rel=3D"no=
referrer" target=3D"_blank">https://github.com/salil-mehta/qemu.git</a> vir=
t-cpuhp-armv8/rfc-v6<br>
(*) Older QEMU changes for vCPU hotplug can be cloned from below site:<br>
=C2=A0 =C2=A0 <a href=3D"https://github.com/salil-mehta/qemu.git" rel=3D"no=
referrer" target=3D"_blank">https://github.com/salil-mehta/qemu.git</a> vir=
t-cpuhp-armv8/rfc-{v1,v2,v3,v4,v5}<br>
(*) `Accepted` Qemu Architecture Agnostic patch is present here:<br>
=C2=A0 =C2=A0 <a href=3D"https://github.com/salil-mehta/qemu/commits/virt-c=
puhp-armv8/rfc-v3.arch.agnostic.v16/" rel=3D"noreferrer" target=3D"_blank">=
https://github.com/salil-mehta/qemu/commits/virt-cpuhp-armv8/rfc-v3.arch.ag=
nostic.v16/</a><br>
(*) All Kernel changes are already part of mainline v6.11<br>
(*) Original Guest Kernel changes (by James Morse, ARM) are available here:=
<br>
=C2=A0 =C2=A0 <a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/mo=
rse/linux.git" rel=3D"noreferrer" target=3D"_blank">https://git.kernel.org/=
pub/scm/linux/kernel/git/morse/linux.git</a> virtual_cpu_hotplug/rfc/v2<br>
<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D<br>
(IX) KNOWN ISSUES &amp; THINGS TO DO<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D<br>
<br>
1. TCG currently faces some hang issues due to unhandled cases. We aim to f=
ix<br>
=C2=A0 =C2=A0these within the next one to two weeks.<br>
2. Comprehensive testing is ongoing. This is fresh code, and we expect to<b=
r>
=C2=A0 =C2=A0complete testing within two weeks.<br>
3. QEMU documentation (.rst) still needs to be updated.<br>
4. Migration has been lightly tested but is working as expected.<br>
5. Mitigation to avoid `pause_all_vcpus` needs broader community discussion=
. An<br>
=C2=A0 =C2=A0alternative change has been prepared in KVM, which maintains a=
 shadow of<br>
=C2=A0 =C2=A0`ICC_CTLR_EL1` to reduce lock contention when using KVM device=
 IOCTLs. This<br>
=C2=A0 =C2=A0avoids synchronization issues if the register value changes du=
ring VM runtime.<br>
=C2=A0 =C2=A0While not mandatory, this enhancement would provide a more com=
prehensive fix<br>
=C2=A0 =C2=A0than the current QEMU assumption that the relevant fields are =
invariant or<br>
=C2=A0 =C2=A0pseudo-static. An RFC for this KVM change will be floated with=
in a week.<br>
6. Mitigation of parking disabled vCPU threads in user space, to avoid bloc=
king<br>
=C2=A0 =C2=A0them inside KVM, needs review by the wider community to ensure=
 no hidden<br>
=C2=A0 =C2=A0issues are introduced.<br>
7. A discussion (if needed) on why `device_set` was chosen instead of `qom-=
set`<br>
=C2=A0 =C2=A0for administrative state control.<br>
8. CPU_SUSPEND/Standy related handling (if required)<br>
9. HVF and qtest are not supported or done yet.<br>
<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>
(X) ORGANIZATION OF PATCHES<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>
<br>
=C2=A0[Patch 1-2, 22-23] New HMP/QMP interface (&#39;device_set&#39;) relat=
ed changes<br>
=C2=A0 =C2=A0 (*) New (&#39;DeviceState::admin_power_state&#39;) property; =
Enabled/Disabled States and handling<br>
=C2=A0 =C2=A0 (*) New Qemu CLI parameter (&#39;-smp CPUS, disabled=3DN&#39;=
) handling<br>
=C2=A0 =C2=A0 (*) Logic to find the existing object not part of the QOM<br>
=C2=A0[Patch 3-5, 10] logic required during machine init.<br>
=C2=A0 =C2=A0 (*) Some validation checks.<br>
=C2=A0 =C2=A0 (*) Introduces core-id,socket-id,cluster-id property and some=
 util functions required later.<br>
=C2=A0 =C2=A0 (*) Logic to setup lazy realization of the QOM vCPUs <br>
=C2=A0 =C2=A0 (*) Logic to pre-create vCPUs in the KVM host kernel.<br>
=C2=A0[Patch 6-7, 8-9] logic required to size the GICv3 State<br>
=C2=A0 =C2=A0 (*) GIC initialization pre-sized with possible vCPUs. <br>
=C2=A0 =C2=A0 (*) Introduction of the GICv3 CPU Interface `accessibility` p=
roperty &amp; accessors<br>
=C2=A0 =C2=A0 (*) Refactoring to make KVM &amp; TCG &#39;GICv3CPUState&#39;=
 initialization common.<br>
=C2=A0 =C2=A0 (*) Changes in GICv3 post/pre-load function for migration <br=
>
=C2=A0[Patch 11,14-16,19] logic related to ACPI at machine init time.<br>
=C2=A0 =C2=A0 (*) ACPI CPU OSPM interface for ACPI _STA.Enable/Disable hand=
ling=C2=A0 <br>
=C2=A0 =C2=A0 (*) ACPI GED framework to cater to CPU DeviceCheck/Eject Even=
ts.<br>
=C2=A0 =C2=A0 (*) ACPI DSDT, MADT changes.<br>
=C2=A0[Patch 12-13, 17] Qdev, Virt Machine, PowerState Handler Changes<br>
=C2=A0 =C2=A0 (*) Changes to introduce &#39;PowerStateHandler&#39; and its =
abstract interface.<br>
=C2=A0 =C2=A0 (*) Qdev changes to handle the administrative enabling/disabl=
ing of device<br>
=C2=A0 =C2=A0 (*) Virt Machine implementation of &#39;PowerStateHandler&#39=
; Hooks<br>
=C2=A0 =C2=A0 (*) vCPU thread user-space parking and unparking logic.<br>
=C2=A0[Patch 18,20-21,24] Misc.<br>
=C2=A0 =C2=A0 (*) Handling of SMCC Hypercall Exits by KVM to Qemu for PSCI.=
<br>
=C2=A0 =C2=A0 (*) Mitigation to avoid using &#39;pause_all_vcpus&#39; durin=
g ICC_CTLR_EL1 reset.<br>
=C2=A0 =C2=A0 (*) Mitigation when TCG &#39;TB Code Cache&#39; is found satu=
rated<br>
<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
(XI) DISCLAIMER<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
This patch-set is the culmination of over four years of ongoing effort to b=
ring<br>
a vCPU hotplug-like feature to the Arm platform. The work has already led t=
o<br>
changes in the ACPI specification and the Linux kernel, and this series now=
<br>
introduces the missing piece within QEMU.<br>
<br>
The transition from RFC v5 to RFC v6 resulted in a shift of approach, based=
 on<br>
maintainer feedback, and required substantial code to be re-written. This i=
s<br>
*not* production-level code and may still contain bugs. Comprehensive testi=
ng is<br>
in progress on HiSilicon Kunpeng920 SoCs, Oracle servers, and Ampere platfo=
rms.<br>
We expect to fix outstanding issues in the coming month and, subject to no =
major<br>
concerns from maintainers about the chosen approach, a near-stable, non-RFC=
<br>
version will be posted soon.<br>
<br>
This work largely follows the direction of prior community discussions over=
 the<br>
years [see refs below], including mailing list threads, Linaro Open Discuss=
ions,<br>
and sessions at KVM Forum. This RFC is intended to validate the overall app=
roach<br>
outlined here and to gather community feedback before moving forward with a=
<br>
formal patch series.<br>
<br>
[The concept being presented has been found to work!]<br>
<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
(XII) Change Log<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
RFC V4 -&gt; RFC V5:<br>
-----------------<br>
1. Dropped &quot;[PATCH RFC V4 19/33] target/arm: Force ARM vCPU *present* =
status ACPI *persistent*&quot;<br>
=C2=A0 =C2=A0- Seperated the architecture agnostic ACPI changes required to=
 support vCPU Hotplug<br>
=C2=A0 =C2=A0 =C2=A0Link: <a href=3D"https://lore.kernel.org/qemu-devel/202=
41014192205.253479-1-salil.mehta@huawei.com/#t" rel=3D"noreferrer" target=
=3D"_blank">https://lore.kernel.org/qemu-devel/20241014192205.253479-1-sali=
l.mehta@huawei.com/#t</a><br>
2. Dropped &quot;[PATCH RFC V4 02/33] cpu-common: Add common CPU utility fo=
r possible vCPUs&quot;<br>
=C2=A0 =C2=A0- Dropped qemu{present,enabled}_cpu() APIs. Commented by Gavin=
 (Redhat), Miguel(Oracle), Igor(Redhat)<br>
3. Added &quot;Reviewed-by: Miguel Luis &lt;<a href=3D"mailto:miguel.luis@o=
racle.com" target=3D"_blank">miguel.luis@oracle.com</a>&gt;&quot; to [PATCH=
 RFC V4 01/33]<br>
3. Dropped the `CPUState::disabled` flag and introduced `GICv3State::num_sm=
p_cpus` flag<br>
=C2=A0 =C2=A0- All `GICv3CPUState&#39; between [num_smp_cpus,num_cpus) are =
marked as &#39;inaccessible` during gicv3_common_realize()<br>
=C2=A0 =C2=A0- qemu_enabled_cpu() not required - removed!<br>
=C2=A0 =C2=A0- removed usage of `CPUState::disabled` from virt.c and hw/cpu=
64.c<br>
4. Removed virt_cpu_properties() and introduced property `mp-affinity` get =
accessor<br>
5. Dropped &quot;[PATCH RFC V4 12/33] arm/virt: Create GED device before *d=
isabled* vCPU Objects are destroyed&quot;<br>
<br>
RFC V3 -&gt; RFC V4:<br>
-----------------<br>
1. Addressed Nicholas Piggin&#39;s (IBM) comments<br>
=C2=A0 =C2=A0- Moved qemu_get_cpu_archid() as a ACPI helper inline acpi/cpu=
.h<br>
=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/D2GFCLH11=
HGJ.1IJGANHQ9ZQRL@gmail.com/" rel=3D"noreferrer" target=3D"_blank">https://=
lore.kernel.org/qemu-devel/D2GFCLH11HGJ.1IJGANHQ9ZQRL@gmail.com/</a><br>
=C2=A0 =C2=A0- Introduced new macro CPU_FOREACH_POSSIBLE() in [PATCH 12/33]=
 <br>
=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/D2GF9A9AJ=
O02.1G1G8UEXA5AOD@gmail.com/" rel=3D"noreferrer" target=3D"_blank">https://=
lore.kernel.org/qemu-devel/D2GF9A9AJO02.1G1G8UEXA5AOD@gmail.com/</a><br>
=C2=A0 =C2=A0- Converted CPUState::acpi_persistent into Property. Improved =
the cover note<br>
=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/D2H62RK48=
KT7.2BTQEZUOEGG4L@gmail.com/" rel=3D"noreferrer" target=3D"_blank">https://=
lore.kernel.org/qemu-devel/D2H62RK48KT7.2BTQEZUOEGG4L@gmail.com/</a><br>
=C2=A0 =C2=A0- Fixed teh cover note of the[PATCH ] and clearly mentioned ab=
out KVMParking<br>
=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/D2GFOGQC3=
HYO.2LKOV306JIU98@gmail.com/" rel=3D"noreferrer" target=3D"_blank">https://=
lore.kernel.org/qemu-devel/D2GFOGQC3HYO.2LKOV306JIU98@gmail.com/</a> <br>
2. Addressed Gavin Shan&#39;s (RedHat) comments:<br>
=C2=A0 =C2=A0- Introduced the ARM Extensions check. [Looks like I missed th=
e PMU check :( ]<br>
=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/28f3107f-=
0267-4112-b0ca-da59df2968ae@redhat.com/" rel=3D"noreferrer" target=3D"_blan=
k">https://lore.kernel.org/qemu-devel/28f3107f-0267-4112-b0ca-da59df2968ae@=
redhat.com/</a><br>
=C2=A0 =C2=A0- Moved create_gpio() along with create_ged()<br>
=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/143ad7d2-=
8f45-4428-bed3-891203a49029@redhat.com/" rel=3D"noreferrer" target=3D"_blan=
k">https://lore.kernel.org/qemu-devel/143ad7d2-8f45-4428-bed3-891203a49029@=
redhat.com/</a><br>
=C2=A0 =C2=A0- Improved the logic of the GIC creation and initialization<br=
>
=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/9b7582f0-=
8149-4bf0-a1aa-4d4fe0d35e70@redhat.com/" rel=3D"noreferrer" target=3D"_blan=
k">https://lore.kernel.org/qemu-devel/9b7582f0-8149-4bf0-a1aa-4d4fe0d35e70@=
redhat.com/</a><br>
=C2=A0 =C2=A0- Removed redundant !dev-&gt;realized checks in cpu_hotunplug(=
_request)<br>
=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/64e9feaa-=
8df2-4108-9e73-c72517fb074a@redhat.com/" rel=3D"noreferrer" target=3D"_blan=
k">https://lore.kernel.org/qemu-devel/64e9feaa-8df2-4108-9e73-c72517fb074a@=
redhat.com/</a><br>
3. Addresses Alex Benn=C3=A9e&#39;s + Gustavo Romero (Linaro) comments<br>
=C2=A0 =C2=A0- Fixed the TCG support and now it works for all the cases inc=
luding migration.<br>
=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/87bk1b3az=
m.fsf@draig.linaro.org/" rel=3D"noreferrer" target=3D"_blank">https://lore.=
kernel.org/qemu-devel/87bk1b3azm.fsf@draig.linaro.org/</a><br>
=C2=A0 =C2=A0- Fixed the cpu_address_space_destroy() compilation failuer in=
 user-mode<br>
=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/87v800wkb=
1.fsf@draig.linaro.org/" rel=3D"noreferrer" target=3D"_blank">https://lore.=
kernel.org/qemu-devel/87v800wkb1.fsf@draig.linaro.org/</a><br>
4. Fixed crash in .post_gicv3() during migration with asymmetrically *enabl=
ed*<br>
=C2=A0 =C2=A0 =C2=A0vCPUs at destination VM<br>
<br>
RFC V2 -&gt; RFC V3:<br>
-----------------<br>
1. Miscellaneous:<br>
=C2=A0 =C2=A0- Split the RFC V2 into arch-agnostic and arch-specific patch =
sets.<br>
2. Addressed Gavin Shan&#39;s (RedHat) comments:<br>
=C2=A0 =C2=A0- Made CPU property accessors inline.<br>
=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/6cd28639-=
2cfa-f233-c6d9-d5d2ec5b1c58@redhat.com/" rel=3D"noreferrer" target=3D"_blan=
k">https://lore.kernel.org/qemu-devel/6cd28639-2cfa-f233-c6d9-d5d2ec5b1c58@=
redhat.com/</a><br>
=C2=A0 =C2=A0- Collected Reviewed-bys [PATCH RFC V2 4/37, 14/37, 22/37].<br=
>
=C2=A0 =C2=A0- Dropped the patch as it was not required after init logic wa=
s refactored.<br>
=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/4fb2eef9-=
6742-1eeb-721a-b3db04b1be97@redhat.com/" rel=3D"noreferrer" target=3D"_blan=
k">https://lore.kernel.org/qemu-devel/4fb2eef9-6742-1eeb-721a-b3db04b1be97@=
redhat.com/</a><br>
=C2=A0 =C2=A0- Fixed the range check for the core during vCPU Plug.<br>
=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/1c5fa24c-=
6bf3-750f-4f22-087e4a9311af@redhat.com/" rel=3D"noreferrer" target=3D"_blan=
k">https://lore.kernel.org/qemu-devel/1c5fa24c-6bf3-750f-4f22-087e4a9311af@=
redhat.com/</a><br>
=C2=A0 =C2=A0- Added has_hotpluggable_vcpus check to make build_cpus_aml() =
conditional.<br>
=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/832342cb-=
74bc-58dd-c5d7-6f995baeb0f2@redhat.com/" rel=3D"noreferrer" target=3D"_blan=
k">https://lore.kernel.org/qemu-devel/832342cb-74bc-58dd-c5d7-6f995baeb0f2@=
redhat.com/</a><br>
=C2=A0 =C2=A0- Fixed the states initialization in cpu_hotplug_hw_init() to =
accommodate previous refactoring.<br>
=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/da5e5609-=
1883-8650-c7d8-6868c7b74f1c@redhat.com/" rel=3D"noreferrer" target=3D"_blan=
k">https://lore.kernel.org/qemu-devel/da5e5609-1883-8650-c7d8-6868c7b74f1c@=
redhat.com/</a><br>
=C2=A0 =C2=A0- Fixed typos.<br>
=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/eb1ac571-=
7844-55e6-15e7-3dd7df21366b@redhat.com/" rel=3D"noreferrer" target=3D"_blan=
k">https://lore.kernel.org/qemu-devel/eb1ac571-7844-55e6-15e7-3dd7df21366b@=
redhat.com/</a><br>
=C2=A0 =C2=A0- Removed the unnecessary &#39;goto fail&#39;.<br>
=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/4d8980ac-=
f402-60d4-fe52-787815af8a7d@redhat.com/#t" rel=3D"noreferrer" target=3D"_bl=
ank">https://lore.kernel.org/qemu-devel/4d8980ac-f402-60d4-fe52-787815af8a7=
d@redhat.com/#t</a><br>
=C2=A0 =C2=A0- Added check for hotpluggable vCPUs in the _OSC method.<br>
=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/202310170=
01326.FUBqQ1PTowF2GxQpnL3kIW0AhmSqbspazwixAHVSi6c@z/" rel=3D"noreferrer" ta=
rget=3D"_blank">https://lore.kernel.org/qemu-devel/20231017001326.FUBqQ1PTo=
wF2GxQpnL3kIW0AhmSqbspazwixAHVSi6c@z/</a><br>
3. Addressed Shaoqin Huang&#39;s (Intel) comments:<br>
=C2=A0 =C2=A0- Fixed the compilation break due to the absence of a call to =
virt_cpu_properties() missing<br>
=C2=A0 =C2=A0 =C2=A0along with its definition.<br>
=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/3632ee24-=
47f7-ae68-8790-26eb2cf9950b@redhat.com/" rel=3D"noreferrer" target=3D"_blan=
k">https://lore.kernel.org/qemu-devel/3632ee24-47f7-ae68-8790-26eb2cf9950b@=
redhat.com/</a><br>
4. Addressed Jonathan Cameron&#39;s (Huawei) comments:<br>
=C2=A0 =C2=A0- Gated the &#39;disabled vcpu message&#39; for GIC version &l=
t; 3.<br>
=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/202401161=
55911.00004fe1@Huawei.com/" rel=3D"noreferrer" target=3D"_blank">https://lo=
re.kernel.org/qemu-devel/20240116155911.00004fe1@Huawei.com/</a><br>
<br>
RFC V1 -&gt; RFC V2:<br>
-----------------<br>
1. Addressed James Morse&#39;s (ARM) requirement as per Linaro Open Discuss=
ion:<br>
=C2=A0 =C2=A0- Exposed all possible vCPUs as always ACPI _STA.present and a=
vailable during boot time.<br>
=C2=A0 =C2=A0- Added the _OSC handling as required by James&#39;s patches.<=
br>
=C2=A0 =C2=A0- Introduction of &#39;online-capable&#39; bit handling in the=
 flag of MADT GICC.<br>
=C2=A0 =C2=A0- SMCC Hypercall Exit handling in Qemu.<br>
2. Addressed Marc Zyngier&#39;s comment:<br>
=C2=A0 =C2=A0- Fixed the note about GIC CPU Interface in the cover letter.<=
br>
3. Addressed issues raised by Vishnu Pajjuru (Ampere) &amp; Miguel Luis (Or=
acle) during testing:<br>
=C2=A0 =C2=A0- Live/Pseudo Migration crashes.<br>
4. Others:<br>
=C2=A0 =C2=A0- Introduced the concept of persistent vCPU at QOM.<br>
=C2=A0 =C2=A0- Introduced wrapper APIs of present, possible, and persistent=
.<br>
=C2=A0 =C2=A0- Change at ACPI hotplug H/W init leg accommodating initializi=
ng is_present and is_enabled states.<br>
=C2=A0 =C2=A0- Check to avoid unplugging cold-booted vCPUs.<br>
=C2=A0 =C2=A0- Disabled hotplugging with TCG/HVF/QTEST.<br>
=C2=A0 =C2=A0- Introduced CPU Topology, {socket, cluster, core, thread}-id =
property.<br>
=C2=A0 =C2=A0- Extract virt CPU properties as a common virt_vcpu_properties=
() function.<br>
<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
(XIII) ACKNOWLEDGEMENTS<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
I would like to thank the following people for various discussions with me =
over<br>
different channels during development:<br>
<br>
Marc Zyngier (Google), Catalin Marinas (ARM), James Morse (ARM), Will Deaco=
n (Google), <br>
Jean-Philippe Brucker (Linaro), Sudeep Holla (ARM), Lorenzo Pieralisi (Lina=
ro), <br>
Gavin Shan (RedHat), Jonathan Cameron (Huawei), Darren Hart (Ampere), <br>
Igor Mammedov (RedHat), Ilkka Koskinen (Ampere), Andrew Jones (RedHat), <br=
>
Karl Heubaum (Oracle), Keqian Zhu (Huawei), Miguel Luis (Oracle), <br>
Xiongfeng Wang (Huawei), Vishnu Pajjuri (Ampere), Shameerali Kolothum (Huaw=
ei), <br>
Russell King (Oracle), Xuwei/Joy (Huawei), Peter Maydel (Linaro), <br>
Zengtao/Prime (Huawei), Nicholas Piggin (IBM), Alex Benn=C3=A9e(Linaro) and=
 all those<br>
whom I have missed!<br>
<br>
Many thanks to the following people for their current or past contributions=
:<br>
<br>
1. James Morse (ARM)<br>
=C2=A0 =C2=A0(Current Kernel part of vCPU Hotplug Support on AARCH64)<br>
2. Jean-Philippe Brucker (Linaro)<br>
=C2=A0 =C2=A0(Prototyped one of the earlier PSCI-based POC [17][18] based o=
n RFC V1)<br>
3. Keqian Zhu (Huawei)<br>
=C2=A0 =C2=A0(Co-developed Qemu prototype)<br>
4. Xiongfeng Wang (Huawei)<br>
=C2=A0 =C2=A0(Co-developed an earlier kernel prototype with me)<br>
5. Vishnu Pajjuri (Ampere)<br>
=C2=A0 =C2=A0(Verification on Ampere ARM64 Platforms + fixes)<br>
6. Miguel Luis (Oracle)<br>
=C2=A0 =C2=A0(Verification on Oracle ARM64 Platforms + fixes)<br>
7. Russell King (Oracle) &amp; Jonathan Cameron (Huawei)<br>
=C2=A0 =C2=A0(Helping in upstreaming James Morse&#39;s Kernel patches).<br>
<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
(XIV) REFERENCES<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
[1] <a href=3D"https://lore.kernel.org/qemu-devel/20200613213629.21984-1-sa=
lil.mehta@huawei.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.ke=
rnel.org/qemu-devel/20200613213629.21984-1-salil.mehta@huawei.com/</a><br>
[2] <a href=3D"https://lore.kernel.org/linux-arm-kernel/20200625133757.2233=
2-1-salil.mehta@huawei.com/" rel=3D"noreferrer" target=3D"_blank">https://l=
ore.kernel.org/linux-arm-kernel/20200625133757.22332-1-salil.mehta@huawei.c=
om/</a><br>
[3] <a href=3D"https://lore.kernel.org/lkml/20230203135043.409192-1-james.m=
orse@arm.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.org=
/lkml/20230203135043.409192-1-james.morse@arm.com/</a><br>
[4] <a href=3D"https://lore.kernel.org/all/20230913163823.7880-1-james.mors=
e@arm.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.org/al=
l/20230913163823.7880-1-james.morse@arm.com/</a><br>
[5] <a href=3D"https://lore.kernel.org/all/20230404154050.2270077-1-oliver.=
upton@linux.dev/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.=
org/all/20230404154050.2270077-1-oliver.upton@linux.dev/</a><br>
[6] <a href=3D"https://bugzilla.tianocore.org/show_bug.cgi?id=3D3706" rel=
=3D"noreferrer" target=3D"_blank">https://bugzilla.tianocore.org/show_bug.c=
gi?id=3D3706</a><br>
[7] <a href=3D"https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming=
_Model.html#gic-cpu-interface-gicc-structure" rel=3D"noreferrer" target=3D"=
_blank">https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.=
html#gic-cpu-interface-gicc-structure</a><br>
[8] <a href=3D"https://bugzilla.tianocore.org/show_bug.cgi?id=3D4481#c5" re=
l=3D"noreferrer" target=3D"_blank">https://bugzilla.tianocore.org/show_bug.=
cgi?id=3D4481#c5</a><br>
[9] <a href=3D"https://cloud.google.com/kubernetes-engine/docs/concepts/ver=
ticalpodautoscaler" rel=3D"noreferrer" target=3D"_blank">https://cloud.goog=
le.com/kubernetes-engine/docs/concepts/verticalpodautoscaler</a><br>
[10] <a href=3D"https://docs.aws.amazon.com/eks/latest/userguide/vertical-p=
od-autoscaler.html" rel=3D"noreferrer" target=3D"_blank">https://docs.aws.a=
mazon.com/eks/latest/userguide/vertical-pod-autoscaler.html</a><br>
[11] <a href=3D"https://lkml.org/lkml/2019/7/10/235" rel=3D"noreferrer" tar=
get=3D"_blank">https://lkml.org/lkml/2019/7/10/235</a><br>
[12] <a href=3D"https://lists.cs.columbia.edu/pipermail/kvmarm/2018-July/03=
2316.html" rel=3D"noreferrer" target=3D"_blank">https://lists.cs.columbia.e=
du/pipermail/kvmarm/2018-July/032316.html</a><br>
[13] <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg06=
517.html" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.org/archiv=
e/html/qemu-devel/2020-01/msg06517.html</a><br>
[14] <a href=3D"https://op-lists.linaro.org/archives/list/linaro-open-discu=
ssions@op-lists.linaro.org/thread/7CGL6JTACPUZEYQC34CZ2ZBWJGSR74WE/" rel=3D=
"noreferrer" target=3D"_blank">https://op-lists.linaro.org/archives/list/li=
naro-open-discussions@op-lists.linaro.org/thread/7CGL6JTACPUZEYQC34CZ2ZBWJG=
SR74WE/</a><br>
[15] <a href=3D"http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg=
01168.html" rel=3D"noreferrer" target=3D"_blank">http://lists.nongnu.org/ar=
chive/html/qemu-devel/2018-07/msg01168.html</a><br>
[16] <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00=
131.html" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.org/archiv=
e/html/qemu-devel/2020-06/msg00131.html</a><br>
[17] <a href=3D"https://op-lists.linaro.org/archives/list/linaro-open-discu=
ssions@op-lists.linaro.org/message/X74JS6P2N4AUWHHATJJVVFDI2EMDZJ74/" rel=
=3D"noreferrer" target=3D"_blank">https://op-lists.linaro.org/archives/list=
/linaro-open-discussions@op-lists.linaro.org/message/X74JS6P2N4AUWHHATJJVVF=
DI2EMDZJ74/</a><br>
[18] <a href=3D"https://lore.kernel.org/lkml/20210608154805.216869-1-jean-p=
hilippe@linaro.org/" rel=3D"noreferrer" target=3D"_blank">https://lore.kern=
el.org/lkml/20210608154805.216869-1-jean-philippe@linaro.org/</a><br>
[19] <a href=3D"https://lore.kernel.org/all/20230913163823.7880-1-james.mor=
se@arm.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.org/a=
ll/20230913163823.7880-1-james.morse@arm.com/</a> <br>
[20] <a href=3D"https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programmin=
g_Model.html#gicc-cpu-interface-flags" rel=3D"noreferrer" target=3D"_blank"=
>https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#gi=
cc-cpu-interface-flags</a><br>
[21] <a href=3D"https://lore.kernel.org/qemu-devel/20230926100436.28284-1-s=
alil.mehta@huawei.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.k=
ernel.org/qemu-devel/20230926100436.28284-1-salil.mehta@huawei.com/</a><br>
[22] <a href=3D"https://lore.kernel.org/qemu-devel/20240607115649.214622-1-=
salil.mehta@huawei.com/T/#md0887eb07976bc76606a8204614ccc7d9a01c1f7" rel=3D=
"noreferrer" target=3D"_blank">https://lore.kernel.org/qemu-devel/202406071=
15649.214622-1-salil.mehta@huawei.com/T/#md0887eb07976bc76606a8204614ccc7d9=
a01c1f7</a><br>
[23] RFC V3: <a href=3D"https://lore.kernel.org/qemu-devel/20240613233639.2=
02896-1-salil.mehta@huawei.com/#t" rel=3D"noreferrer" target=3D"_blank">htt=
ps://lore.kernel.org/qemu-devel/20240613233639.202896-1-salil.mehta@huawei.=
com/#t</a><br>
<br>
Author Salil Mehta (1):<br>
=C2=A0 target/arm/kvm,tcg: Handle SMCCC hypercall exits in VMM during PSCI_=
CPU_{ON,OFF}<br>
<br>
Jean-Philippe Brucker (1):<br>
=C2=A0 target/arm/kvm: Write vCPU&#39;s state back to KVM on cold-reset<br>
<br>
Salil Mehta (22):<br>
=C2=A0 hw/core: Introduce administrative power-state property and its acces=
sors<br>
=C2=A0 hw/core, qemu-options.hx: Introduce &#39;disabledcpus&#39; SMP param=
eter<br>
=C2=A0 hw/arm/virt: Clamp &#39;maxcpus&#39; as-per machine&#39;s vCPU defer=
red online-capability<br>
=C2=A0 arm/virt,target/arm: Add new ARMCPU {socket,cluster,core,thread}-id =
property<br>
=C2=A0 arm/virt,kvm: Pre-create KVM vCPUs for &#39;disabled&#39; QOM vCPUs =
at machine init<br>
=C2=A0 arm/virt,gicv3: Pre-size GIC with possible vCPUs at machine init<br>
=C2=A0 arm/gicv3: Refactor CPU interface init for shared TCG/KVM use<br>
=C2=A0 arm/virt, gicv3: Guard CPU interface access for admin disabled vCPUs=
<br>
=C2=A0 hw/intc/arm_gicv3_common: Migrate &amp; check &#39;GICv3CPUState&#39=
; accessibility mismatch<br>
=C2=A0 arm/virt: Init PMU at host for all present vCPUs<br>
=C2=A0 hw/arm/acpi: MADT change to size the guest with possible vCPUs<br>
=C2=A0 hw/core: Introduce generic device power-state handler interface<br>
=C2=A0 qdev: make admin power state changes trigger platform transitions vi=
a ACPI<br>
=C2=A0 arm/acpi: Introduce dedicated CPU OSPM interface for ARM-like platfo=
rms<br>
=C2=A0 acpi/ged: Notify OSPM of CPU administrative state changes via GED<br=
>
=C2=A0 arm/virt/acpi: Update ACPI DSDT Tbl to include &#39;Online-Capable&#=
39; CPUs AML<br>
=C2=A0 hw/arm/virt,acpi/ged: Add PowerStateHandler hooks for runtime CPU st=
ate changes<br>
=C2=A0 target/arm/cpu: Add the Accessor hook to fetch ARM CPU arch-id<br>
=C2=A0 hw/intc/arm-gicv3-kvm: Pause all vCPUs &amp; cache ICC_CTLR_EL1 for =
userspace PSCI CPU_ON<br>
=C2=A0 monitor,qdev: Introduce &#39;device_set&#39; to change admin state o=
f existing devices<br>
=C2=A0 monitor,qapi: add &#39;info cpus-powerstate&#39; and QMP query (Admi=
n + Oper states)<br>
=C2=A0 tcg: Defer TB flush for &#39;lazy realized&#39; vCPUs on first regio=
n alloc<br>
<br>
=C2=A0accel/kvm/kvm-all.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0accel/tcg/tcg-accel-ops-mttcg.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A02 +-<br>
=C2=A0accel/tcg/tcg-accel-ops-rr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 =C2=A02 +-<br>
=C2=A0cpu-common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
=C2=A0hmp-commands-info.hx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 32 ++<br>
=C2=A0hmp-commands.hx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 30 +<br>
=C2=A0hw/acpi/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +<br>
=C2=A0hw/acpi/acpi-cpu-ospm-interface-stub.c |=C2=A0 41 ++<br>
=C2=A0hw/acpi/cpu_ospm_interface.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| 747 +++++++++++++++++++++++++<br>
=C2=A0hw/acpi/generic_event_device.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 91 +++<br>
=C2=A0hw/acpi/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +<br>
=C2=A0hw/acpi/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 17 +<br>
=C2=A0hw/arm/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0hw/arm/virt-acpi-build.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 75 ++-<br>
=C2=A0hw/arm/virt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 573 +++++++++++++++++--<br>
=C2=A0hw/core/cpu-common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 12 +<br>
=C2=A0hw/core/machine-hmp-cmds.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 62 ++<br>
=C2=A0hw/core/machine-qmp-cmds.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 107 ++++<br>
=C2=A0hw/core/machine-smp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 24 +-<br>
=C2=A0hw/core/machine.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 28 +<br>
=C2=A0hw/core/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0hw/core/powerstate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| 100 ++++<br>
=C2=A0hw/core/qdev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 197 +++++++<br>
=C2=A0hw/intc/arm_gicv3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0hw/intc/arm_gicv3_common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 64 ++-<br>
=C2=A0hw/intc/arm_gicv3_cpuif.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 270 ++++-----<br>
=C2=A0hw/intc/arm_gicv3_cpuif_common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 58=
 ++<br>
=C2=A0hw/intc/arm_gicv3_kvm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 123 +++-<br>
=C2=A0hw/intc/gicv3_internal.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0include/hw/acpi/acpi_dev_interface.h=C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br=
>
=C2=A0include/hw/acpi/cpu_ospm_interface.h=C2=A0 =C2=A0|=C2=A0 78 +++<br>
=C2=A0include/hw/acpi/generic_event_device.h |=C2=A0 =C2=A06 +<br>
=C2=A0include/hw/arm/virt.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 42 +-<br>
=C2=A0include/hw/boards.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 37 ++<br>
=C2=A0include/hw/core/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 71 +++<br>
=C2=A0include/hw/intc/arm_gicv3_common.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 65 +++<=
br>
=C2=A0include/hw/powerstate.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 177 ++++++<br>
=C2=A0include/hw/qdev-core.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 151 +++++<br>
=C2=A0include/monitor/hmp.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +<br>
=C2=A0include/monitor/qdev.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 30 +<br>
=C2=A0include/system/kvm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A08 +<br>
=C2=A0include/system/system.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0include/tcg/startup.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 +<br>
=C2=A0include/tcg/tcg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0qapi/machine.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 90 +++<br>
=C2=A0qemu-options.hx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 129 ++++-<br>
=C2=A0stubs/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0stubs/powerstate-stubs.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 47 ++<br>
=C2=A0system/cpus.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +-<br>
=C2=A0system/qdev-monitor.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | 139 ++++-<br>
=C2=A0system/vl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 42 ++<br>
=C2=A0target/arm/arm-powerctl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 29 +-<br>
=C2=A0target/arm/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 14 +<br>
=C2=A0target/arm/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 +<br>
=C2=A0target/arm/helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0target/arm/internals.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0target/arm/kvm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 140 ++++-<br>
=C2=A0target/arm/kvm_arm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 25 +<br>
=C2=A0target/arm/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0target/arm/{tcg =3D&gt; }/psci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A09 +<br>
=C2=A0target/arm/tcg/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A04 -<br>
=C2=A0tcg/region.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 16 +<br>
=C2=A0tcg/tcg.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 19 +-<br>
=C2=A063 files changed, 3800 insertions(+), 265 deletions(-)<br>
=C2=A0create mode 100644 hw/acpi/acpi-cpu-ospm-interface-stub.c<br>
=C2=A0create mode 100644 hw/acpi/cpu_ospm_interface.c<br>
=C2=A0create mode 100644 hw/core/powerstate.c<br>
=C2=A0create mode 100644 include/hw/acpi/cpu_ospm_interface.h<br>
=C2=A0create mode 100644 include/hw/powerstate.h<br>
=C2=A0create mode 100644 stubs/powerstate-stubs.c<br>
=C2=A0rename target/arm/{tcg =3D&gt; }/psci.c (96%)<br>
<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div>

--00000000000024e1ec06400ddf52--

