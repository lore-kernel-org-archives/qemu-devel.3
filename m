Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07EB1D1713B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 20:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2zLV-00068E-Bc; Mon, 21 Oct 2024 16:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1t2zLQ-00066Q-9c
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 16:49:40 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1t2zLJ-0007mZ-S5
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 16:49:40 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c95a962c2bso6006663a12.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 13:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1729543771; x=1730148571; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zJjRkR4iZdsap7r0E/MmcCQpkpoIYkh30iqW09pTsJg=;
 b=b35p4sEKx1Ia7vdJqUYPq0x/RAVKkZzOB+Jik4mMyxjy67ZUqEZwMnNDSYcD1DATez
 RfXFk6X8f7oEs845LNpUUzvMDPYCp3W0+3gfc1RHDkYmobiXZM4VAkwLVK8Wev6URJxE
 30bK/9v0XTN9VhpqGDc6ePBU6reWfhN54QqS0evGzqiR+SgnWf099kp7RUpWa8EpsuEU
 wICwCy47ta4XNGFMFCbE0iQiZSLsd4CehC28BYNsn5u703/hVR5M1cMb3szSkv430+Ba
 gmM0RhtqPomMdwfUwBVekH5WqXHQUHvC5cyUkvQwJ3Q8hZgABXzYf3D7T49mtzFKR/9p
 SpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729543771; x=1730148571;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zJjRkR4iZdsap7r0E/MmcCQpkpoIYkh30iqW09pTsJg=;
 b=aorOj3W0WI6ER+4bx2XFHdeQ6bkY9EriTKQu7OUwjM1niU2JuoZW9S0e+owhstgHQr
 c82byGNXJWpDjRSxnQ1KuheSo0tRsqTXuJov3AtyUbsNgHqKjZ6e4yi95HhyIG0xYIDC
 g/Qqnn+G6AD0shaSPJ5wrITKr4jnKmFs9GUG+fBwHdbT1qEQM5mq4e9R31vGjUiIGlvU
 VmIr7FoAF70Me206m5uZ/x+aVAZrOh3V+frwJ7VVaI6KcngOgLLuvvLszY9UkXXvFyrW
 4E0d2SHOYT66928UPRnZY2YoKRMhj+OMfAj+p+9V0TUsD8g0SUdKA9TGyoNjulcrfxZ2
 7zYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/PLRENGJnR2kpAfomk4QTlzwugR9u0daZ8sowLYdUdLui54VIbl2WRWwLFMWiDcF1K/U5hnZbXF7J@nongnu.org
X-Gm-Message-State: AOJu0YzVWeBGchNh2qmGAeFW3nkHixtaqG6sJKVOTN1D7+LVTbpIL6z7
 6QFjYdARlOS/sxrlcQUlSpjMOs3J1ajuS4naAuek5mvuI1QwYGiDhFgEDo2mv+h8jmwDvzATp1i
 vR7QkFdntYqQv81unRHb/AJMfIsunFj0cUdd/1w==
X-Google-Smtp-Source: AGHT+IEBx9V+J2g6jCCgRPOYxFZQh7Fhkzil3Bto0h0p6RsxJx0pXa0JzTcS6BrvhZtyOERLNlR/duGUzfKJzIB1Gtg=
X-Received: by 2002:a17:907:60cb:b0:a9a:f0e:cd4 with SMTP id
 a640c23a62f3a-a9aad3db21cmr17632966b.55.1729543770303; Mon, 21 Oct 2024
 13:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <20241015100012.254223-1-salil.mehta@huawei.com>
 <30478B18-932D-413C-BFF0-5FD70510D9D5@oracle.com>
In-Reply-To: <30478B18-932D-413C-BFF0-5FD70510D9D5@oracle.com>
From: Salil Mehta <salil.mehta@opnsrc.net>
Date: Mon, 21 Oct 2024 21:49:17 +0100
Message-ID: <CAJ7pxeYodLvL7J5AoFk-anjfWZV2H9B0KCt7Yg7azoUAbcOMZg@mail.gmail.com>
Subject: Re: [PATCH RFC V5 00/30] Support of Virtual CPU Hotplug for ARMv8 Arch
To: Miguel Luis <miguel.luis@oracle.com>
Cc: Salil Mehta <salil.mehta@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Marc Zyngier <maz@kernel.org>, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, 
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "peterx@redhat.com" <peterx@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, 
 "will@kernel.org" <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>, 
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, 
 "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, 
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "npiggin@gmail.com" <npiggin@gmail.com>, 
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>, 
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>, 
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>, 
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 Karl Heubaum <karl.heubaum@oracle.com>, 
 "zhukeqian1@huawei.com" <zhukeqian1@huawei.com>, 
 "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>, 
 "wangyanan55@huawei.com" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>, 
 "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>, 
 "shahuang@redhat.com" <shahuang@redhat.com>,
 "zhao1.liu@intel.com" <zhao1.liu@intel.com>, 
 "linuxarm@huawei.com" <linuxarm@huawei.com>, 
 "gustavo.romero@linaro.org" <gustavo.romero@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000000d9b4e062502ca71"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-ed1-x52f.google.com
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

--0000000000000d9b4e062502ca71
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miguel,

On Wed, Oct 16, 2024 at 3:09=E2=80=AFPM Miguel Luis <miguel.luis@oracle.com=
> wrote:

> Hi Salil,
>
> > On 15 Oct 2024, at 09:59, Salil Mehta <salil.mehta@huawei.com> wrote:
> >
> > PROLOGUE
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >
> > To assist in review and set the right expectations from this RFC, pleas=
e
> first
> > read the sections *APPENDED AT THE END* of this cover letter:
> >
> > 1. Important *DISCLAIMER* [Section (X)]
> > 2. Work presented at KVMForum Conference (slides available) [Section
> (V)F]
> > 3. Organization of patches [Section (XI)]
> > 4. References [Section (XII)]
> > 5. Detailed TODO list of leftover work or work-in-progress [Section (IX=
)]
> > 6. Repositories [Section (VII)]
> >
> > The architecture-agnostic patch set was merged into the mainline during
> the
> > last Qemu cycle. This patch is specific to the ARM architecture and is
> > compatible with the latest Qemu mainline version.
> >
> > SECTIONS [I - XIII] are as follows:
> >
> > (I) Summary of `Recent` Key Changes [details in last section (XIV)]
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > RFC V4 -> RFC V5
> >
> > 1. Dropped patches [PATCH RFC V4 {2,12,19}/33]
> > 2. Separated architecture agnostic ACPI/migration changes in separate
> patch-set.
> >   Link:
> https://lore.kernel.org/qemu-devel/20241014192205.253479-1-salil.mehta@hu=
awei.com/#t
> > 3. Dropped qemu{present,enabled}_cpu() APIs.
> > 4. Dropped the `CPUState::disabled` flag
> >
> > RFC V3 -> RFC V4
> >
> > 1. Fixes for TCG. It has been lightly tested but seem to work!
> > 2. Migration related fixes [Both KVM & TCG].
> > 3. Introduction of `gicc_accessble` flag for GICv3 CPU interface
> > 4. Addressed comments from Gavin Shan (RedHat), Nicholas Piggin (IBM),
> >   Alex Benn=C3=A9e's & Gustavo Romero (Linaro)
> > 5. Misc fixes and refatoring.
> >
> >
> > (II) Summary
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > This patch set introduces virtual CPU hotplug support for the ARMv8
> architecture
> > in QEMU. The idea is to be able to hotplug and hot-unplug vCPUs while
> the guest
> > VM is running, without requiring a reboot. This does *not* make any
> assumptions
> > about the physical CPU hotplug availability within the host system but
> rather
> > tries to solve the problem at the virtualizer/QEMU layer. It introduces
> ACPI CPU
> > hotplug hooks and event handling to interface with the guest kernel, an=
d
> code to
> > initialize, plug, and unplug CPUs. No changes are required within the
> host
> > kernel/KVM except the support of hypercall exit handling in the
> user-space/Qemu,
> > which has recently been added to the kernel. Corresponding guest kernel
> changes
> > were posted on the mailing list [3] [4] by James Morse (ARM) and have
> been
> > recently accepted and are now part of v6.11 mainline kernel.
> >
> > (III) Motivation
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > This allows scaling the guest VM compute capacity on-demand, which woul=
d
> be
> > useful for the following example scenarios:
> >
> > 1. Vertical Pod Autoscaling [9][10] in the cloud: Part of the
> orchestration
> >   framework that could adjust resource requests (CPU and Mem requests)
> for
> >   the containers in a pod, based on usage.
> > 2. Pay-as-you-grow Business Model: Infrastructure providers could
> allocate and
> >   restrict the total number of compute resources available to the guest
> VM
> >   according to the SLA (Service Level Agreement). VM owners could
> request more
> >   compute to be hot-plugged for some cost.
> >
> > For example, Kata Container VM starts with a minimum amount of resource=
s
> (i.e.,
> > hotplug everything approach). Why?
> >
> > 1. Allowing faster *boot time* and
> > 2. Reduction in *memory footprint*
> >
> > Kata Container VM can boot with just 1 vCPU, and then later more vCPUs
> can be
> > hot-plugged as needed. Reducing the number of vCPUs in VM can in genera=
l
> > reduce the boot times of the VM esepcially when number of cores are
> increasing.
> >
> > **[UPCOMING]**
> > I've been working on enhancing the boot times of ARM/VMs using the
> hotplug
> > infrastructure proposed in this patch set. Stay tuned for upcoming
> patches that
> > leverage this infrastructure to significantly reduce boot times for
> > *non-hotplug* scenarios. Expect these updates in the next few weeks!
> >
> > (IV) Terminology
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > (*) Possible CPUs: Total vCPUs that could ever exist in the VM. This
> includes
> >                   any cold-booted CPUs plus any CPUs that could be late=
r
> >                   hot-plugged.
> >                   - Qemu parameter (-smp maxcpus=3DN)
> > (*) Present CPUs:  Possible CPUs that are ACPI 'present'. These might o=
r
> might
> >                   not be ACPI 'enabled'.
> >                   - Present vCPUs =3D Possible vCPUs (Always on ARM Arc=
h)
> > (*) Enabled CPUs:  Possible CPUs that are ACPI 'present' and 'enabled'
> and can
> >                   now be =E2=80=98onlined=E2=80=99 (PSCI) for use by th=
e Guest Kernel.
> All cold-
> >                   booted vCPUs are ACPI 'enabled' at boot. Later, using
> >                   device_add, more vCPUs can be hotplugged and made ACP=
I
> >                   'enabled'.
> >                   - Qemu parameter (-smp cpus=3DN). Can be used to spec=
ify
> some
> >   cold-booted vCPUs during VM init. Some can be added using the
> >   '-device' option.
> >
> > (V) Constraints Due to ARMv8 CPU Architecture [+] Other Impediments
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > A. Physical Limitation to Support CPU Hotplug: (Architectural Constrain=
t)
> >   1. ARMv8 CPU architecture does not support the concept of the physica=
l
> CPU
> >      hotplug.
> >      a. There are many per-CPU components like PMU, SVE, MTE, Arch
> timers, etc.,
> >         whose behavior needs to be clearly defined when the CPU is
> > hot(un)plugged. There is no specification for this.
> >
> >   2. Other ARM components like GIC, etc., have not been designed to
> realize
> >      physical CPU hotplug capability as of now. For example,
> >      a. Every physical CPU has a unique GICC (GIC CPU Interface) by
> construct.
> >         Architecture does not specify what CPU hot(un)plug would mean i=
n
> >         context to any of these.
> >      b. CPUs/GICC are physically connected to unique GICR (GIC
> Redistributor).
> >         GIC Redistributors are always part of the always-on power
> domain. Hence,
> >         they cannot be powered off as per specification.
> >
> > B. Impediments in Firmware/ACPI (Architectural Constraint)
> >
> >   1. Firmware has to expose GICC, GICR, and other per-CPU features like
> PMU,
> >      SVE, MTE, Arch Timers, etc., to the OS. Due to the architectural
> constraint
> >      stated in section A1(a), all interrupt controller structures of
> >      MADT describing GIC CPU Interfaces and the GIC Redistributors MUST
> be
> >      presented by firmware to the OSPM during boot time.
> >   2. Architectures that support CPU hotplug can evaluate the ACPI _MAT
> method to
> >      get this kind of information from the firmware even after boot, an=
d
> the
> >      OSPM has the capability to process these. ARM kernel uses
> information in MADT
> >      interrupt controller structures to identify the number of present
> CPUs during
> >      boot and hence does not allow to change these after boot. The
> number of
> >      present CPUs cannot be changed. It is an architectural constraint!
> >
> > C. Impediments in KVM to Support Virtual CPU Hotplug (Architectural
> Constraint)
> >
> >   1. KVM VGIC:
> >      a. Sizing of various VGIC resources like memory regions, etc.,
> related to
> >         the redistributor happens only once and is fixed at the VM init
> time
> >         and cannot be changed later after initialization has happened.
> >         KVM statically configures these resources based on the number o=
f
> vCPUs
> >         and the number/size of redistributor ranges.
> >      b. Association between vCPU and its VGIC redistributor is fixed at
> the
> >         VM init time within the KVM, i.e., when redistributor iodevs ge=
ts
> >         registered. VGIC does not allow to setup/change this associatio=
n
> >         after VM initialization has happened. Physically, every CPU/GIC=
C
> is
> >         uniquely connected with its redistributor, and there is no
> >         architectural way to set this up.
> >   2. KVM vCPUs:
> >      a. Lack of specification means destruction of KVM vCPUs does not
> exist as
> >         there is no reference to tell what to do with other per-vCPU
> >         components like redistributors, arch timer, etc.
> >      b. In fact, KVM does not implement the destruction of vCPUs for an=
y
> >         architecture. This is independent of whether the architecture
> >         actually supports CPU Hotplug feature. For example, even for x8=
6
> KVM
> >         does not implement the destruction of vCPUs.
> >
> > D. Impediments in Qemu to Support Virtual CPU Hotplug (KVM
> Constraints->Arch)
> >
> >   1. Qemu CPU Objects MUST be created to initialize all the Host KVM
> vCPUs to
> >      overcome the KVM constraint. KVM vCPUs are created and initialized
> when Qemu
> >      CPU Objects are realized. But keeping the QOM CPU objects realized
> for
> >      'yet-to-be-plugged' vCPUs can create problems when these new vCPUs
> shall
> >      be plugged using device_add and a new QOM CPU object shall be
> created.
> >   2. GICV3State and GICV3CPUState objects MUST be sized over *possible
> vCPUs*
> >      during VM init time while QOM GICV3 Object is realized. This is
> because
> >      KVM VGIC can only be initialized once during init time. But every
> >      GICV3CPUState has an associated QOM CPU Object. Later might
> correspond to
> >      vCPU which are 'yet-to-be-plugged' (unplugged at init).
> >   3. How should new QOM CPU objects be connected back to the
> GICV3CPUState
> >      objects and disconnected from it in case the CPU is being
> hot(un)plugged?
> >   4. How should 'unplugged' or 'yet-to-be-plugged' vCPUs be represented
> in the
> >      QOM for which KVM vCPU already exists? For example, whether to kee=
p,
> >       a. No QOM CPU objects Or
> >       b. Unrealized CPU Objects
> >   5. How should vCPU state be exposed via ACPI to the Guest? Especially
> for
> >      the unplugged/yet-to-be-plugged vCPUs whose CPU objects might not
> exist
> >      within the QOM but the Guest always expects all possible vCPUs to =
be
> >      identified as ACPI *present* during boot.
> >   6. How should Qemu expose GIC CPU interfaces for the unplugged or
> >      yet-to-be-plugged vCPUs using ACPI MADT Table to the Guest?
> >
> > E. Summary of Approach ([+] Workarounds to problems in sections A, B, C
> & D)
> >
> >   1. At VM Init, pre-create all the possible vCPUs in the Host KVM i.e.=
,
> even
> >      for the vCPUs which are yet-to-be-plugged in Qemu but keep them in
> the
> >      powered-off state.
> >   2. After the KVM vCPUs have been initialized in the Host, the KVM vCP=
U
> >      objects corresponding to the unplugged/yet-to-be-plugged vCPUs are
> parked
> >      at the existing per-VM "kvm_parked_vcpus" list in Qemu. (similar t=
o
> x86)
> >   3. GICV3State and GICV3CPUState objects are sized over possible vCPUs
> during
> >      VM init time i.e., when Qemu GIC is realized. This, in turn, sizes
> KVM VGIC
> >      resources like memory regions, etc., related to the redistributors
> with the
> >      number of possible KVM vCPUs. This never changes after VM has
> initialized.
> >   4. Qemu CPU objects corresponding to unplugged/yet-to-be-plugged vCPU=
s
> are
> >      released post Host KVM CPU and GIC/VGIC initialization.
> >   5. Build ACPI MADT Table with the following updates:
> >      a. Number of GIC CPU interface entries (=3Dpossible vCPUs)
> >      b. Present Boot vCPU as MADT.GICC.Enabled=3D1 (Not hot[un]pluggabl=
e)
> >      c. Present hot(un)pluggable vCPUs as MADT.GICC.online-capable=3D1
> >         - MADT.GICC.Enabled=3D0 (Mutually exclusive) [6][7]
> > - vCPU can be ACPI enabled+onlined after Guest boots (Firmware Policy)
> > - Some issues with above (details in later sections)
> >   6. Expose below ACPI Status to Guest kernel:
> >      a. Always _STA.Present=3D1 (all possible vCPUs)
> >      b. _STA.Enabled=3D1 (plugged vCPUs)
> >      c. _STA.Enabled=3D0 (unplugged vCPUs)
> >   7. vCPU hotplug *realizes* new QOM CPU object. The following happens:
> >      a. Realizes, initializes QOM CPU Object & spawns Qemu vCPU thread.
> >      b. Unparks the existing KVM vCPU ("kvm_parked_vcpus" list).
> >         - Attaches to QOM CPU object.
> >      c. Reinitializes KVM vCPU in the Host.
> >         - Resets the core and sys regs, sets defaults, etc.
> >      d. Runs KVM vCPU (created with "start-powered-off").
> > - vCPU thread sleeps (waits for vCPU reset via PSCI).
> >      e. Updates Qemu GIC.
> >         - Wires back IRQs related to this vCPU.
> >         - GICV3CPUState association with QOM CPU Object.
> >      f. Updates [6] ACPI _STA.Enabled=3D1.
> >      g. Notifies Guest about the new vCPU (via ACPI GED interface).
> > - Guest checks _STA.Enabled=3D1.
> > - Guest adds processor (registers CPU with LDM) [3].
> >      h. Plugs the QOM CPU object in the slot.
> >         - slot-number =3D cpu-index {socket, cluster, core, thread}.
> >      i. Guest online's vCPU (CPU_ON PSCI call over HVC/SMC).
> >         - KVM exits HVC/SMC Hypercall [5] to Qemu (Policy Check).
> >         - Qemu powers-on KVM vCPU in the Host.
> >   8. vCPU hot-unplug *unrealizes* QOM CPU Object. The following happens=
:
> >      a. Notifies Guest (via ACPI GED interface) vCPU hot-unplug event.
> >         - Guest offline's vCPU (CPU_OFF PSCI call over HVC/SMC).
> >      b. KVM exits HVC/SMC Hypercall [5] to Qemu (Policy Check).
> >         - Qemu powers-off the KVM vCPU in the Host.
> >      c. Guest signals *Eject* vCPU to Qemu.
> >      d. Qemu updates [6] ACPI _STA.Enabled=3D0.
> >      e. Updates GIC.
> >         - Un-wires IRQs related to this vCPU.
> >         - GICV3CPUState association with new QOM CPU Object is updated.
> >      f. Unplugs the vCPU.
> > - Removes from slot.
> >         - Parks KVM vCPU ("kvm_parked_vcpus" list).
> >         - Unrealizes QOM CPU Object & joins back Qemu vCPU thread.
> > - Destroys QOM CPU object.
> >      g. Guest checks ACPI _STA.Enabled=3D0.
> >         - Removes processor (unregisters CPU with LDM) [3].
> >
> > F. Work Presented at KVM Forum Conferences:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Details of the above work have been presented at KVMForum2020 and
> KVMForum2023
> > conferences. Slides & video are available at the links below:
> > a. KVMForum 2023
> >   - Challenges Revisited in Supporting Virt CPU Hotplug on architecture=
s
> that don't Support CPU Hotplug (like ARM64).
> >     https://kvm-forum.qemu.org/2023/KVM-forum-cpu-hotplug_7OJ1YyJ.pdf
> >
> https://kvm-forum.qemu.org/2023/Challenges_Revisited_in_Supporting_Virt_C=
PU_Hotplug_-__ii0iNb3.pdf
> >     https://www.youtube.com/watch?v=3Dhyrw4j2D6I0&t=3D23970s
> >     https://kvm-forum.qemu.org/2023/talk/9SMPDQ/
> > b. KVMForum 2020
> >   - Challenges in Supporting Virtual CPU Hotplug on SoC Based Systems
> (like ARM64) - Salil Mehta, Huawei.
> >     https://kvmforum2020.sched.com/event/eE4m
> >
> > (VI) Commands Used
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > A. Qemu launch commands to init the machine:
> >
> > $ qemu-system-aarch64 --enable-kvm -machine virt,gic-version=3D3 \
> > -cpu host -smp cpus=3D4,maxcpus=3D6 \
> > -m 300M \
> > -kernel Image \
> > -initrd rootfs.cpio.gz \
> > -append "console=3DttyAMA0 root=3D/dev/ram rdinit=3D/init maxcpus=3D2
> acpi=3Dforce" \
> > -nographic \
> > -bios QEMU_EFI.fd \
> >
> > B. Hot-(un)plug related commands:
> >
> > # Hotplug a host vCPU (accel=3Dkvm):
> > $ device_add host-arm-cpu,id=3Dcore4,core-id=3D4
> >
> > # Hotplug a vCPU (accel=3Dtcg):
> > $ device_add cortex-a57-arm-cpu,id=3Dcore4,core-id=3D4
> >
> > # Delete the vCPU:
> > $ device_del core4
> >
> > Sample output on guest after boot:
> >
> >    $ cat /sys/devices/system/cpu/possible
> >    0-5
> >    $ cat /sys/devices/system/cpu/present
> >    0-5
> >    $ cat /sys/devices/system/cpu/enabled
> >    0-3
> >    $ cat /sys/devices/system/cpu/online
> >    0-1
> >    $ cat /sys/devices/system/cpu/offline
> >    2-
> >
> > Sample output on guest after hotplug of vCPU=3D4:
> >
> >    $ cat /sys/devices/system/cpu/possible
> >    0-5
> >    $ cat /sys/devices/system/cpu/present
> >    0-5
> >    $ cat /sys/devices/system/cpu/enabled
> >    0-4
> >    $ cat /sys/devices/system/cpu/online
> >    0-1,4
> >    $ cat /sys/devices/system/cpu/offline
> >    2-3,5
> >
> >    Note: vCPU=3D4 was explicitly 'onlined' after hot-plug
> >    $ echo 1 > /sys/devices/system/cpu/cpu4/online
> >
> > (VII) Latest Repository
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > (*) Latest Qemu RFC V5 (Architecture Specific) patch set:
> >    https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-v5
> > (*) Latest Architecture Agnostic ACPI changes patch-set:
> >
> https://lore.kernel.org/qemu-devel/20241014192205.253479-1-salil.mehta@hu=
awei.com/#t
> > (*) Older QEMU changes for vCPU hotplug can be cloned from below site:
> >    https://github.com/salil-mehta/qemu.git
> virt-cpuhp-armv8/rfc-{v1,v2,v3,v4}
> > (*) `Accepted` Qemu Architecture Agnostic patch is present here:
> >
> https://github.com/salil-mehta/qemu/commits/virt-cpuhp-armv8/rfc-v3.arch.=
agnostic.v16/
> > (*) All Kernel changes are already part of mainline v6.11
> > (*) Original Guest Kernel changes (by James Morse, ARM) are available
> here:
> >    https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
> virtual_cpu_hotplug/rfc/v2
> >
> >
> > (VIII) KNOWN ISSUES
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > 1. HVF and qtest are not supported yet.
> > 2. ACPI MADT Table flags [7] MADT.GICC.Enabled and
> MADT.GICC.online-capable are
> >   mutually exclusive, i.e., as per the change [6], a vCPU cannot be bot=
h
> >   GICC.Enabled and GICC.online-capable. This means:
> >      [ Link: https://bugzilla.tianocore.org/show_bug.cgi?id=3D3706 ]
> >   a. If we have to support hot-unplug of the cold-booted vCPUs, then
> these MUST
> >      be specified as GICC.online-capable in the MADT Table during boot
> by the
> >      firmware/Qemu. But this requirement conflicts with the requirement
> to
> >      support new Qemu changes with legacy OS that don't understand
> >      MADT.GICC.online-capable Bit. Legacy OS during boot time will
> ignore this
> >      bit, and hence these vCPUs will not appear on such OS. This is
> unexpected
> >      behavior.
> >   b. In case we decide to specify vCPUs as MADT.GICC.Enabled and try to
> unplug
> >      these cold-booted vCPUs from OS (which in actuality should be
> blocked by
> >      returning error at Qemu), then features like 'kexec' will break.
> >   c. As I understand, removal of the cold-booted vCPUs is a required
> feature
> >      and x86 world allows it.
> >   d. Hence, either we need a specification change to make the
> MADT.GICC.Enabled
> >      and MADT.GICC.online-capable Bits NOT mutually exclusive or NOT
> support
> >      the removal of cold-booted vCPUs. In the latter case, a check can
> be introduced
> >      to bar the users from unplugging vCPUs, which were cold-booted,
> using QMP
> >      commands. (Needs discussion!)
> >      Please check the patch part of this patch set:
> >      [hw/arm/virt: Expose cold-booted CPUs as MADT GICC Enabled].
> >
> >      NOTE: This is definitely not a blocker!
> >
> >
> > (IX) THINGS TO DO
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > 1. TCG is now in working state but would need extensive testing to roll
> out
> >   any corner cases. Any help related to this will be appreciated!
> > 2. Comprehensive Testing is in progress. (Positive feedback from Oracle
> & Ampere)
> > 3. Qemu Documentation (.rst) needs to be updated.
> > 4. The `is_enabled` and `is_present` ACPI states are now common to all
> architectures
> >   and should work seemlessely but needs thorough testing with other
> architectures.
> > 5. Migration has been lightly tested but has been found working.
> > 6. A missing check for PMU state for the hotplugged vCPUs (Reported by:
> Gavin Shan)
> >
> https://lore.kernel.org/qemu-devel/28f3107f-0267-4112-b0ca-da59df2968ae@r=
edhat.com/
> > 7. Need help in Testing with ARM hardware extensions like SVE/SME
> >
> >
> >
> > Best regards,
> > Salil.
> >
> > (X) DISCLAIMER
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > This work is an attempt to present a proof-of-concept of the ARM64 vCPU
> hotplug
> > implementation to the community. This is *not* production-level code an=
d
> might
> > have bugs. Comprehensive testing is being done on HiSilicon Kunpeng920
> SoC,
> > Oracle, and Ampere servers. We are nearing stable code and a non-RFC
> > version shall be floated soon.
> >
> > This work is *mostly* in the lines of the discussions that have happene=
d
> in the
> > previous years [see refs below] across different channels like the
> mailing list,
> > Linaro Open Discussions platform, and various conferences like KVMForum=
,
> etc. This
> > RFC is being used as a way to verify the idea mentioned in this cover
> letter and
> > to get community views. Once this has been agreed upon, a formal patch
> shall be
> > posted to the mailing list for review.
> >
> > [The concept being presented has been found to work!]
> >
> > (XI) ORGANIZATION OF PATCHES
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >
> > A. ARM Architecture *specific* patches:
> >
> >   [Patch 1-8, 11, 12, 30] logic required during machine init.
> >    (*) Some validation checks.
> >    (*) Introduces core-id property and some util functions required
> later.
> >    (*) Logic to pre-create vCPUs.
> >    (*) Introduction of the GICv3 CPU Interface `accessibility` interfac=
e
> >    (*) GIC initialization pre-sized with possible vCPUs.
> >    (*) Some refactoring to have common hot and cold plug logic together=
.
> >    (*) Release of disabled QOM CPU objects in post_cpu_init().
> >   [Patch 9-10, 13-15] logic related to ACPI at machine init time.
> >    (*) Changes required to Enable ACPI for CPU hotplug.
> >    (*) Initialization of ACPI GED framework to cater to CPU Hotplug
> Events.
> >    (*) ACPI DSDT, MADT/MAT changes.
> >   [Patch 17-29] logic required during vCPU hot-(un)plug.
> >    (*) Basic framework changes to support vCPU hot-(un)plug.
> >    (*) ACPI GED changes for hot-(un)plug hooks.
> >    (*) Wire-unwire the IRQs.
> >    (*) GIC notification logic on receiving vCPU hot(un)plug event.
> >    (*) ARMCPU unrealize logic.
> >    (*) Handling of SMCC Hypercall Exits by KVM to Qemu.
> >   [Patch 33] Disable unplug of cold-booted vCPUs
> >
> >
> > (XII) REFERENCES
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > [1]
> https://lore.kernel.org/qemu-devel/20200613213629.21984-1-salil.mehta@hua=
wei.com/
> > [2]
> https://lore.kernel.org/linux-arm-kernel/20200625133757.22332-1-salil.meh=
ta@huawei.com/
> > [3]
> https://lore.kernel.org/lkml/20230203135043.409192-1-james.morse@arm.com/
> > [4]
> https://lore.kernel.org/all/20230913163823.7880-1-james.morse@arm.com/
> > [5]
> https://lore.kernel.org/all/20230404154050.2270077-1-oliver.upton@linux.d=
ev/
> > [6] https://bugzilla.tianocore.org/show_bug.cgi?id=3D3706
> > [7]
> https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#g=
ic-cpu-interface-gicc-structure
> > [8] https://bugzilla.tianocore.org/show_bug.cgi?id=3D4481#c5
> > [9]
> https://cloud.google.com/kubernetes-engine/docs/concepts/verticalpodautos=
caler
> > [10]
> https://docs.aws.amazon.com/eks/latest/userguide/vertical-pod-autoscaler.=
html
> > [11] https://lkml.org/lkml/2019/7/10/235
> > [12]
> https://lists.cs.columbia.edu/pipermail/kvmarm/2018-July/032316.html
> > [13] https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg06517.htm=
l
> > [14]
> https://op-lists.linaro.org/archives/list/linaro-open-discussions@op-list=
s.linaro.org/thread/7CGL6JTACPUZEYQC34CZ2ZBWJGSR74WE/
> > [15]
> http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg01168.html
> > [16] https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00131.htm=
l
> > [17]
> https://op-lists.linaro.org/archives/list/linaro-open-discussions@op-list=
s.linaro.org/message/X74JS6P2N4AUWHHATJJVVFDI2EMDZJ74/
> > [18]
> https://lore.kernel.org/lkml/20210608154805.216869-1-jean-philippe@linaro=
.org/
> > [19]
> https://lore.kernel.org/all/20230913163823.7880-1-james.morse@arm.com/
> > [20]
> https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#g=
icc-cpu-interface-flags
> > [21]
> https://lore.kernel.org/qemu-devel/20230926100436.28284-1-salil.mehta@hua=
wei.com/
> > [22]
> https://lore.kernel.org/qemu-devel/20240607115649.214622-1-salil.mehta@hu=
awei.com/T/#md0887eb07976bc76606a8204614ccc7d9a01c1f7
> > [23] RFC V3:
> https://lore.kernel.org/qemu-devel/20240613233639.202896-1-salil.mehta@hu=
awei.com/#t
> >
> > (XIII) ACKNOWLEDGEMENTS
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > I would like to thank the following people for various discussions with
> me over different channels during development:
> >
> > Marc Zyngier (Google), Catalin Marinas (ARM), James Morse (ARM), Will
> Deacon (Google),
> > Jean-Philippe Brucker (Linaro), Sudeep Holla (ARM), Lorenzo Pieralisi
> (Linaro),
> > Gavin Shan (RedHat), Jonathan Cameron (Huawei), Darren Hart (Ampere),
> > Igor Mamedov (RedHat), Ilkka Koskinen (Ampere), Andrew Jones (RedHat),
> > Karl Heubaum (Oracle), Keqian Zhu (Huawei), Miguel Luis (Oracle),
> > Xiongfeng Wang (Huawei), Vishnu Pajjuri (Ampere), Shameerali Kolothum
> (Huawei),
> > Russell King (Oracle), Xuwei/Joy (Huawei), Peter Maydel (Linaro),
> > Zengtao/Prime (Huawei), Nicholas Piggin (IBM) and all those whom I have
> missed!
> >
> > Many thanks to the following people for their current or past
> contributions:
> >
> > 1. James Morse (ARM)
> >   (Current Kernel part of vCPU Hotplug Support on AARCH64)
> > 2. Jean-Philippe Brucker (Linaro)
> >   (Prototyped one of the earlier PSCI-based POC [17][18] based on RFC V=
1)
> > 3. Keqian Zhu (Huawei)
> >   (Co-developed Qemu prototype)
> > 4. Xiongfeng Wang (Huawei)
> >   (Co-developed an earlier kernel prototype with me)
> > 5. Vishnu Pajjuri (Ampere)
> >   (Verification on Ampere ARM64 Platforms + fixes)
> > 6. Miguel Luis (Oracle)
> >   (Verification on Oracle ARM64 Platforms + fixes)
> > 7. Russell King (Oracle) & Jonathan Cameron (Huawei)
> >   (Helping in upstreaming James Morse's Kernel patches).
> >
> > (XIV) Change Log:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > RFC V4 -> RFC V5:
> > -----------------
> > 1. Dropped "[PATCH RFC V4 19/33] target/arm: Force ARM vCPU *present*
> status ACPI *persistent*"
> >   - Seperated the architecture agnostic ACPI changes required to suppor=
t
> vCPU Hotplug
> >     Link:
> https://lore.kernel.org/qemu-devel/20241014192205.253479-1-salil.mehta@hu=
awei.com/#t
> > 2. Dropped "[PATCH RFC V4 02/33] cpu-common: Add common CPU utility for
> possible vCPUs"
> >   - Dropped qemu{present,enabled}_cpu() APIs. Commented by Gavin
> (Redhat), Miguel(Oracle), Igor(Redhat)
> > 3. Added "Reviewed-by: Miguel Luis <miguel.luis@oracle.com>" to [PATCH
> RFC V4 01/33]
> > 3. Dropped the `CPUState::disabled` flag and introduced
> `GICv3State::num_smp_cpus` flag
> >   - All `GICv3CPUState' between [num_smp_cpus,num_cpus) are marked as
> 'inaccessible` during gicv3_common_realize()
> >   - qemu_enabled_cpu() not required - removed!
> >   - removed usage of `CPUState::disabled` from virt.c and hw/cpu64.c
> > 4. Removed virt_cpu_properties() and introduced property `mp-affinity`
> get accessor
> > 5. Dropped "[PATCH RFC V4 12/33] arm/virt: Create GED device before
> *disabled* vCPU Objects are destroyed"
> >
>
> I've tested this series on the following configurations for both KVM and
> TCG:
>
> -M virt -accel kvm -cpu host
> -M virt,gic_version=3D3 -accel kvm -cpu host
> -M virt,gic_version=3D3 -accel tcg -cpu max
>
> They boot, QEMU is able to hotplug and unplug vCPUs and successive live
> migrations work as expected.
>
> For migrations where the destination VM exceeds the number of vCPUs
> enabled on
> the source VM (patch 26/30) QEMU shows the expected warnings, also for
> both KVM
> and TCG:
>
> qemu-system-aarch64: warning: Found CPU 2 enabled, for incoming *disabled=
*
> GICC State
> qemu-system-aarch64: warning: *Disabling* CPU 2, to match the incoming
> migrated state
>


Thanks for confirming this.



>
> The following configuration of:
>
> -M virt -accel tcg -cpu max
>


Yep, perhaps that's something I missed while testing. Thanks for
identifying.


>
> shows defects in which I had to use the below diff to proceed to boot:
>
> diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
> index 53fb2c4e2d..f5ad33093e 100644
> --- a/hw/intc/arm_gic_common.c
> +++ b/hw/intc/arm_gic_common.c
> @@ -350,6 +350,7 @@ static void arm_gic_common_linux_init(ARMLinuxBootIf
> *obj,
>
>  static Property arm_gic_common_properties[] =3D {
>      DEFINE_PROP_UINT32("num-cpu", GICState, num_cpu, 1),
> +    DEFINE_PROP_UINT32("num-smp-cpu", GICState, num_smp_cpu, 1),
>      DEFINE_PROP_UINT32("num-irq", GICState, num_irq, 32),
>      /* Revision can be 1 or 2 for GIC architecture specification
>       * versions 1 or 2, or 0 to indicate the legacy 11MPCore GIC.
> diff --git a/include/hw/intc/arm_gic_common.h
> b/include/hw/intc/arm_gic_common.h
> index 97fea4102d..a57f20798a 100644
> --- a/include/hw/intc/arm_gic_common.h
> +++ b/include/hw/intc/arm_gic_common.h
> @@ -130,6 +130,8 @@ struct GICState {
>
>      uint32_t num_cpu;
>
> +    uint32_t num_smp_cpu;
> +
>      MemoryRegion iomem; /* Distributor */
>      /* This is just so we can have an opaque pointer which identifies
>       * both this GIC and which CPU interface we should be accessing.
>
> And lastly, one more issue I=E2=80=99ve noticed with this configuration i=
s adding
> a new vcpu
> with -device also needs fixing as is breaking the assert:
>
> `cpu_id >=3D 0 && cpu_id < ms->possible_cpus->len`
>
> in virt_get_cpu_id_from_cpu_topo.
>


sure. Thanks.



>
>
> Thank you
> Miguel
>
>
> > RFC V3 -> RFC V4:
> > -----------------
> > 1. Addressed Nicholas Piggin's (IBM) comments
> >   - Moved qemu_get_cpu_archid() as a ACPI helper inline acpi/cpu.h
> >
> https://lore.kernel.org/qemu-devel/D2GFCLH11HGJ.1IJGANHQ9ZQRL@gmail.com/
> >   - Introduced new macro CPU_FOREACH_POSSIBLE() in [PATCH 12/33]
> >
> https://lore.kernel.org/qemu-devel/D2GF9A9AJO02.1G1G8UEXA5AOD@gmail.com/
> >   - Converted CPUState::acpi_persistent into Property. Improved the
> cover note
> >
> https://lore.kernel.org/qemu-devel/D2H62RK48KT7.2BTQEZUOEGG4L@gmail.com/
> >   - Fixed teh cover note of the[PATCH ] and clearly mentioned about
> KVMParking
> >
> https://lore.kernel.org/qemu-devel/D2GFOGQC3HYO.2LKOV306JIU98@gmail.com/
> > 2. Addressed Gavin Shan's (RedHat) comments:
> >   - Introduced the ARM Extensions check. [Looks like I missed the PMU
> check :( ]
> >
> https://lore.kernel.org/qemu-devel/28f3107f-0267-4112-b0ca-da59df2968ae@r=
edhat.com/
> >   - Moved create_gpio() along with create_ged()
> >
> https://lore.kernel.org/qemu-devel/143ad7d2-8f45-4428-bed3-891203a49029@r=
edhat.com/
> >   - Improved the logic of the GIC creation and initialization
> >
> https://lore.kernel.org/qemu-devel/9b7582f0-8149-4bf0-a1aa-4d4fe0d35e70@r=
edhat.com/
> >   - Removed redundant !dev->realized checks in cpu_hotunplug(_request)
> >
> https://lore.kernel.org/qemu-devel/64e9feaa-8df2-4108-9e73-c72517fb074a@r=
edhat.com/
> > 3. Addresses Alex Benn=C3=A9e's + Gustavo Romero (Linaro) comments
> >   - Fixed the TCG support and now it works for all the cases including
> migration.
> >     https://lore.kernel.org/qemu-devel/87bk1b3azm.fsf@draig.linaro.org/
> >   - Fixed the cpu_address_space_destroy() compilation failuer in
> user-mode
> >     https://lore.kernel.org/qemu-devel/87v800wkb1.fsf@draig.linaro.org/
> > 4. Fixed crash in .post_gicv3() during migration with asymmetrically
> *enabled*
> >     vCPUs at destination VM
> >
> > RFC V2 -> RFC V3:
> > -----------------
> > 1. Miscellaneous:
> >   - Split the RFC V2 into arch-agnostic and arch-specific patch sets.
> > 2. Addressed Gavin Shan's (RedHat) comments:
> >   - Made CPU property accessors inline.
> >
> https://lore.kernel.org/qemu-devel/6cd28639-2cfa-f233-c6d9-d5d2ec5b1c58@r=
edhat.com/
> >   - Collected Reviewed-bys [PATCH RFC V2 4/37, 14/37, 22/37].
> >   - Dropped the patch as it was not required after init logic was
> refactored.
> >
> https://lore.kernel.org/qemu-devel/4fb2eef9-6742-1eeb-721a-b3db04b1be97@r=
edhat.com/
> >   - Fixed the range check for the core during vCPU Plug.
> >
> https://lore.kernel.org/qemu-devel/1c5fa24c-6bf3-750f-4f22-087e4a9311af@r=
edhat.com/
> >   - Added has_hotpluggable_vcpus check to make build_cpus_aml()
> conditional.
> >
> https://lore.kernel.org/qemu-devel/832342cb-74bc-58dd-c5d7-6f995baeb0f2@r=
edhat.com/
> >   - Fixed the states initialization in cpu_hotplug_hw_init() to
> accommodate previous refactoring.
> >
> https://lore.kernel.org/qemu-devel/da5e5609-1883-8650-c7d8-6868c7b74f1c@r=
edhat.com/
> >   - Fixed typos.
> >
> https://lore.kernel.org/qemu-devel/eb1ac571-7844-55e6-15e7-3dd7df21366b@r=
edhat.com/
> >   - Removed the unnecessary 'goto fail'.
> >
> https://lore.kernel.org/qemu-devel/4d8980ac-f402-60d4-fe52-787815af8a7d@r=
edhat.com/#t
> >   - Added check for hotpluggable vCPUs in the _OSC method.
> >
> https://lore.kernel.org/qemu-devel/20231017001326.FUBqQ1PTowF2GxQpnL3kIW0=
AhmSqbspazwixAHVSi6c@z/
> > 3. Addressed Shaoqin Huang's (Intel) comments:
> >   - Fixed the compilation break due to the absence of a call to
> virt_cpu_properties() missing
> >     along with its definition.
> >
> https://lore.kernel.org/qemu-devel/3632ee24-47f7-ae68-8790-26eb2cf9950b@r=
edhat.com/
> > 4. Addressed Jonathan Cameron's (Huawei) comments:
> >   - Gated the 'disabled vcpu message' for GIC version < 3.
> >
> https://lore.kernel.org/qemu-devel/20240116155911.00004fe1@Huawei.com/
> >
> > RFC V1 -> RFC V2:
> > -----------------
> > 1. Addressed James Morse's (ARM) requirement as per Linaro Open
> Discussion:
> >   - Exposed all possible vCPUs as always ACPI _STA.present and availabl=
e
> during boot time.
> >   - Added the _OSC handling as required by James's patches.
> >   - Introduction of 'online-capable' bit handling in the flag of MADT
> GICC.
> >   - SMCC Hypercall Exit handling in Qemu.
> > 2. Addressed Marc Zyngier's comment:
> >   - Fixed the note about GIC CPU Interface in the cover letter.
> > 3. Addressed issues raised by Vishnu Pajjuru (Ampere) & Miguel Luis
> (Oracle) during testing:
> >   - Live/Pseudo Migration crashes.
> > 4. Others:
> >   - Introduced the concept of persistent vCPU at QOM.
> >   - Introduced wrapper APIs of present, possible, and persistent.
> >   - Change at ACPI hotplug H/W init leg accommodating initializing
> is_present and is_enabled states.
> >   - Check to avoid unplugging cold-booted vCPUs.
> >   - Disabled hotplugging with TCG/HVF/QTEST.
> >   - Introduced CPU Topology, {socket, cluster, core, thread}-id propert=
y.
> >   - Extract virt CPU properties as a common virt_vcpu_properties()
> function.
> >
> > Author Salil Mehta (1):
> >  target/arm/kvm,tcg: Handle SMCCC hypercall exits in VMM during
> >    PSCI_CPU_{ON,OFF}
> >
> > Jean-Philippe Brucker (2):
> >  hw/acpi: Make _MAT method optional
> >  target/arm/kvm: Write vCPU's state back to KVM on cold-reset
> >
> > Miguel Luis (1):
> >  tcg/mttcg: Introduce MTTCG thread unregistration leg
> >
> > Salil Mehta (26):
> >  arm/virt,target/arm: Add new ARMCPU {socket,cluster,core,thread}-id
> >    property
> >  hw/arm/virt: Disable vCPU hotplug for *unsupported* Accel or GIC Type
> >  hw/arm/virt: Move setting of common vCPU properties in a function
> >  arm/virt,target/arm: Machine init time change common to vCPU
> >    {cold|hot}-plug
> >  arm/virt,kvm: Pre-create KVM vCPUs for all unplugged QOM vCPUs
> >    @machine init
> >  arm/virt,gicv3: Changes to pre-size GIC with possible vCPUs @machine
> >    init
> >  arm/virt,gicv3: Introduce GICv3 CPU Interface *accessibility* flag and
> >    checks
> >  hw/intc/arm-gicv3*: Changes required to (re)init the GICv3 vCPU
> >    Interface
> >  arm/acpi: Enable ACPI support for vCPU hotplug
> >  arm/virt: Enhance GED framework to handle vCPU hotplug events
> >  arm/virt: Init PMU at host for all possible vCPUs
> >  arm/virt: Release objects for *disabled* possible vCPUs after init
> >  arm/virt/acpi: Update ACPI DSDT Tbl to include CPUs AML with hotplug
> >    support
> >  hw/arm/acpi: MADT Tbl change to size the guest with possible vCPUs
> >  target/arm: Force ARM vCPU *present* status ACPI *persistent*
> >  arm/virt: Add/update basic hot-(un)plug framework
> >  arm/virt: Changes to (un)wire GICC<->vCPU IRQs during hot-(un)plug
> >  hw/arm,gicv3: Changes to notify GICv3 CPU state with vCPU hot-(un)plug
> >    event
> >  hw/arm: Changes required for reset and to support next boot
> >  arm/virt: Update the guest(via GED) about vCPU hot-(un)plug events
> >  target/arm/cpu: Check if hotplugged ARM vCPU's FEAT match existing
> >  tcg: Update tcg_register_thread() leg to handle region alloc for
> >    hotplugged vCPU
> >  target/arm: Add support to *unrealize* ARMCPU during vCPU Hot-unplug
> >  hw/intc/arm_gicv3_common: Add GICv3CPUState 'accessible' flag
> >    migration handling
> >  hw/intc/arm_gicv3_kvm: Pause all vCPU to ensure locking in KVM of
> >    resetting vCPU
> >  hw/arm/virt: Expose cold-booted vCPUs as MADT GICC *Enabled*
> >
> > accel/tcg/tcg-accel-ops-mttcg.c    |   3 +-
> > accel/tcg/tcg-accel-ops-rr.c       |   2 +-
> > cpu-common.c                       |  11 +
> > hw/acpi/cpu.c                      |   9 +-
> > hw/arm/Kconfig                     |   1 +
> > hw/arm/boot.c                      |   2 +-
> > hw/arm/virt-acpi-build.c           |  69 ++-
> > hw/arm/virt.c                      | 840 +++++++++++++++++++++++------
> > hw/core/gpio.c                     |   2 +-
> > hw/intc/arm_gicv3.c                |   1 +
> > hw/intc/arm_gicv3_common.c         |  99 +++-
> > hw/intc/arm_gicv3_cpuif.c          | 253 ++++-----
> > hw/intc/arm_gicv3_cpuif_common.c   |  13 +
> > hw/intc/arm_gicv3_kvm.c            |  40 +-
> > hw/intc/gicv3_internal.h           |   1 +
> > include/hw/acpi/cpu.h              |  19 +
> > include/hw/arm/boot.h              |   2 +
> > include/hw/arm/virt.h              |  64 ++-
> > include/hw/core/cpu.h              |  20 +
> > include/hw/intc/arm_gicv3_common.h |  61 +++
> > include/hw/qdev-core.h             |   2 +
> > include/tcg/startup.h              |  13 +
> > include/tcg/tcg.h                  |   1 +
> > system/physmem.c                   |   8 +-
> > target/arm/arm-powerctl.c          |  20 +-
> > target/arm/cpu-qom.h               |  18 +-
> > target/arm/cpu.c                   | 178 +++++-
> > target/arm/cpu.h                   |  18 +
> > target/arm/cpu64.c                 |  18 +
> > target/arm/gdbstub.c               |   6 +
> > target/arm/helper.c                |  27 +-
> > target/arm/internals.h             |  14 +-
> > target/arm/kvm.c                   | 146 ++++-
> > target/arm/kvm_arm.h               |  24 +
> > target/arm/meson.build             |   1 +
> > target/arm/{tcg =3D> }/psci.c        |   8 +
> > target/arm/tcg/meson.build         |   4 -
> > tcg/region.c                       |  14 +
> > tcg/tcg.c                          |  46 +-
> > 39 files changed, 1714 insertions(+), 364 deletions(-)
> > rename target/arm/{tcg =3D> }/psci.c (97%)
> >
> > --
> > 2.34.1
> >
>
>

--0000000000000d9b4e062502ca71
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Miguel,</div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 16, 2024 at 3:09=E2=
=80=AFPM Miguel Luis &lt;<a href=3D"mailto:miguel.luis@oracle.com">miguel.l=
uis@oracle.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Hi Salil,<br>
<br>
&gt; On 15 Oct 2024, at 09:59, Salil Mehta &lt;<a href=3D"mailto:salil.meht=
a@huawei.com" target=3D"_blank">salil.mehta@huawei.com</a>&gt; wrote:<br>
&gt; <br>
&gt; PROLOGUE<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; <br>
&gt; To assist in review and set the right expectations from this RFC, plea=
se first<br>
&gt; read the sections *APPENDED AT THE END* of this cover letter:<br>
&gt; <br>
&gt; 1. Important *DISCLAIMER* [Section (X)]<br>
&gt; 2. Work presented at KVMForum Conference (slides available) [Section (=
V)F]<br>
&gt; 3. Organization of patches [Section (XI)]<br>
&gt; 4. References [Section (XII)]<br>
&gt; 5. Detailed TODO list of leftover work or work-in-progress [Section (I=
X)]<br>
&gt; 6. Repositories [Section (VII)]<br>
&gt; <br>
&gt; The architecture-agnostic patch set was merged into the mainline durin=
g the<br>
&gt; last Qemu cycle. This patch is specific to the ARM architecture and is=
<br>
&gt; compatible with the latest Qemu mainline version.<br>
&gt; <br>
&gt; SECTIONS [I - XIII] are as follows:<br>
&gt; <br>
&gt; (I) Summary of `Recent` Key Changes [details in last section (XIV)]<br=
>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; <br>
&gt; RFC V4 -&gt; RFC V5<br>
&gt; <br>
&gt; 1. Dropped patches [PATCH RFC V4 {2,12,19}/33] <br>
&gt; 2. Separated architecture agnostic ACPI/migration changes in separate =
patch-set.<br>
&gt;=C2=A0 =C2=A0Link: <a href=3D"https://lore.kernel.org/qemu-devel/202410=
14192205.253479-1-salil.mehta@huawei.com/#t" rel=3D"noreferrer" target=3D"_=
blank">https://lore.kernel.org/qemu-devel/20241014192205.253479-1-salil.meh=
ta@huawei.com/#t</a><br>
&gt; 3. Dropped qemu{present,enabled}_cpu() APIs. <br>
&gt; 4. Dropped the `CPUState::disabled` flag<br>
&gt; <br>
&gt; RFC V3 -&gt; RFC V4<br>
&gt; <br>
&gt; 1. Fixes for TCG. It has been lightly tested but seem to work!<br>
&gt; 2. Migration related fixes [Both KVM &amp; TCG]. <br>
&gt; 3. Introduction of `gicc_accessble` flag for GICv3 CPU interface<br>
&gt; 4. Addressed comments from Gavin Shan (RedHat), Nicholas Piggin (IBM),=
 <br>
&gt;=C2=A0 =C2=A0Alex Benn=C3=A9e&#39;s &amp; Gustavo Romero (Linaro) <br>
&gt; 5. Misc fixes and refatoring.<br>
&gt; <br>
&gt; <br>
&gt; (II) Summary<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; <br>
&gt; This patch set introduces virtual CPU hotplug support for the ARMv8 ar=
chitecture<br>
&gt; in QEMU. The idea is to be able to hotplug and hot-unplug vCPUs while =
the guest<br>
&gt; VM is running, without requiring a reboot. This does *not* make any as=
sumptions<br>
&gt; about the physical CPU hotplug availability within the host system but=
 rather<br>
&gt; tries to solve the problem at the virtualizer/QEMU layer. It introduce=
s ACPI CPU<br>
&gt; hotplug hooks and event handling to interface with the guest kernel, a=
nd code to<br>
&gt; initialize, plug, and unplug CPUs. No changes are required within the =
host<br>
&gt; kernel/KVM except the support of hypercall exit handling in the user-s=
pace/Qemu,<br>
&gt; which has recently been added to the kernel. Corresponding guest kerne=
l changes<br>
&gt; were posted on the mailing list [3] [4] by James Morse (ARM) and have =
been<br>
&gt; recently accepted and are now part of v6.11 mainline kernel.<br>
&gt; <br>
&gt; (III) Motivation<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; <br>
&gt; This allows scaling the guest VM compute capacity on-demand, which wou=
ld be<br>
&gt; useful for the following example scenarios:<br>
&gt; <br>
&gt; 1. Vertical Pod Autoscaling [9][10] in the cloud: Part of the orchestr=
ation<br>
&gt;=C2=A0 =C2=A0framework that could adjust resource requests (CPU and Mem=
 requests) for<br>
&gt;=C2=A0 =C2=A0the containers in a pod, based on usage.<br>
&gt; 2. Pay-as-you-grow Business Model: Infrastructure providers could allo=
cate and<br>
&gt;=C2=A0 =C2=A0restrict the total number of compute resources available t=
o the guest VM<br>
&gt;=C2=A0 =C2=A0according to the SLA (Service Level Agreement). VM owners =
could request more<br>
&gt;=C2=A0 =C2=A0compute to be hot-plugged for some cost.<br>
&gt; <br>
&gt; For example, Kata Container VM starts with a minimum amount of resourc=
es (i.e.,<br>
&gt; hotplug everything approach). Why?<br>
&gt; <br>
&gt; 1. Allowing faster *boot time* and<br>
&gt; 2. Reduction in *memory footprint*<br>
&gt; <br>
&gt; Kata Container VM can boot with just 1 vCPU, and then later more vCPUs=
 can be<br>
&gt; hot-plugged as needed. Reducing the number of vCPUs in VM can in gener=
al<br>
&gt; reduce the boot times of the VM esepcially when number of cores are in=
creasing.<br>
&gt; <br>
&gt; **[UPCOMING]**<br>
&gt; I&#39;ve been working on enhancing the boot times of ARM/VMs using the=
 hotplug<br>
&gt; infrastructure proposed in this patch set. Stay tuned for upcoming pat=
ches that<br>
&gt; leverage this infrastructure to significantly reduce boot times for<br=
>
&gt; *non-hotplug* scenarios. Expect these updates in the next few weeks!<b=
r>
&gt; <br>
&gt; (IV) Terminology<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; <br>
&gt; (*) Possible CPUs: Total vCPUs that could ever exist in the VM. This i=
ncludes<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0an=
y cold-booted CPUs plus any CPUs that could be later<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ho=
t-plugged.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- =
Qemu parameter (-smp maxcpus=3DN)<br>
&gt; (*) Present CPUs:=C2=A0 Possible CPUs that are ACPI &#39;present&#39;.=
 These might or might<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0no=
t be ACPI &#39;enabled&#39;. <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- =
Present vCPUs =3D Possible vCPUs (Always on ARM Arch)<br>
&gt; (*) Enabled CPUs:=C2=A0 Possible CPUs that are ACPI &#39;present&#39; =
and &#39;enabled&#39; and can<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0no=
w be =E2=80=98onlined=E2=80=99 (PSCI) for use by the Guest Kernel. All cold=
-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bo=
oted vCPUs are ACPI &#39;enabled&#39; at boot. Later, using<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0de=
vice_add, more vCPUs can be hotplugged and made ACPI<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#=
39;enabled&#39;.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- =
Qemu parameter (-smp cpus=3DN). Can be used to specify some<br>
&gt;=C2=A0 =C2=A0cold-booted vCPUs during VM init. Some can be added using =
the<br>
&gt;=C2=A0 =C2=A0&#39;-device&#39; option.<br>
&gt; <br>
&gt; (V) Constraints Due to ARMv8 CPU Architecture [+] Other Impediments<br=
>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; <br>
&gt; A. Physical Limitation to Support CPU Hotplug: (Architectural Constrai=
nt)<br>
&gt;=C2=A0 =C2=A01. ARMv8 CPU architecture does not support the concept of =
the physical CPU<br>
&gt;=C2=A0 =C2=A0 =C2=A0 hotplug. <br>
&gt;=C2=A0 =C2=A0 =C2=A0 a. There are many per-CPU components like PMU, SVE=
, MTE, Arch timers, etc.,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0whose behavior needs to be clearly de=
fined when the CPU is<br>
&gt; hot(un)plugged. There is no specification for this.<br>
&gt; <br>
&gt;=C2=A0 =C2=A02. Other ARM components like GIC, etc., have not been desi=
gned to realize<br>
&gt;=C2=A0 =C2=A0 =C2=A0 physical CPU hotplug capability as of now. For exa=
mple,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 a. Every physical CPU has a unique GICC (GIC CPU I=
nterface) by construct.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Architecture does not specify what CP=
U hot(un)plug would mean in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0context to any of these.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 b. CPUs/GICC are physically connected to unique GI=
CR (GIC Redistributor).<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GIC Redistributors are always part of=
 the always-on power domain. Hence,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0they cannot be powered off as per spe=
cification.<br>
&gt; <br>
&gt; B. Impediments in Firmware/ACPI (Architectural Constraint)<br>
&gt; <br>
&gt;=C2=A0 =C2=A01. Firmware has to expose GICC, GICR, and other per-CPU fe=
atures like PMU,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 SVE, MTE, Arch Timers, etc., to the OS. Due to the=
 architectural constraint<br>
&gt;=C2=A0 =C2=A0 =C2=A0 stated in section A1(a), all interrupt controller =
structures of<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MADT describing GIC CPU Interfaces and the GIC Red=
istributors MUST be<br>
&gt;=C2=A0 =C2=A0 =C2=A0 presented by firmware to the OSPM during boot time=
.<br>
&gt;=C2=A0 =C2=A02. Architectures that support CPU hotplug can evaluate the=
 ACPI _MAT method to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 get this kind of information from the firmware eve=
n after boot, and the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 OSPM has the capability to process these. ARM kern=
el uses information in MADT<br>
&gt;=C2=A0 =C2=A0 =C2=A0 interrupt controller structures to identify the nu=
mber of present CPUs during<br>
&gt;=C2=A0 =C2=A0 =C2=A0 boot and hence does not allow to change these afte=
r boot. The number of<br>
&gt;=C2=A0 =C2=A0 =C2=A0 present CPUs cannot be changed. It is an architect=
ural constraint!<br>
&gt; <br>
&gt; C. Impediments in KVM to Support Virtual CPU Hotplug (Architectural Co=
nstraint)<br>
&gt; <br>
&gt;=C2=A0 =C2=A01. KVM VGIC:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 a. Sizing of various VGIC resources like memory re=
gions, etc., related to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the redistributor happens only once a=
nd is fixed at the VM init time<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0and cannot be changed later after ini=
tialization has happened.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0KVM statically configures these resou=
rces based on the number of vCPUs<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0and the number/size of redistributor =
ranges.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 b. Association between vCPU and its VGIC redistrib=
utor is fixed at the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VM init time within the KVM, i.e., wh=
en redistributor iodevs gets<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0registered. VGIC does not allow to se=
tup/change this association<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0after VM initialization has happened.=
 Physically, every CPU/GICC is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uniquely connected with its redistrib=
utor, and there is no<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0architectural way to set this up.<br>
&gt;=C2=A0 =C2=A02. KVM vCPUs:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 a. Lack of specification means destruction of KVM =
vCPUs does not exist as<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0there is no reference to tell what to=
 do with other per-vCPU<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0components like redistributors, arch =
timer, etc.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 b. In fact, KVM does not implement the destruction=
 of vCPUs for any<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0architecture. This is independent of =
whether the architecture<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0actually supports CPU Hotplug feature=
. For example, even for x86 KVM<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0does not implement the destruction of=
 vCPUs.<br>
&gt; <br>
&gt; D. Impediments in Qemu to Support Virtual CPU Hotplug (KVM Constraints=
-&gt;Arch)<br>
&gt; <br>
&gt;=C2=A0 =C2=A01. Qemu CPU Objects MUST be created to initialize all the =
Host KVM vCPUs to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 overcome the KVM constraint. KVM vCPUs are created=
 and initialized when Qemu<br>
&gt;=C2=A0 =C2=A0 =C2=A0 CPU Objects are realized. But keeping the QOM CPU =
objects realized for<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &#39;yet-to-be-plugged&#39; vCPUs can create probl=
ems when these new vCPUs shall<br>
&gt;=C2=A0 =C2=A0 =C2=A0 be plugged using device_add and a new QOM CPU obje=
ct shall be created.<br>
&gt;=C2=A0 =C2=A02. GICV3State and GICV3CPUState objects MUST be sized over=
 *possible vCPUs*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 during VM init time while QOM GICV3 Object is real=
ized. This is because<br>
&gt;=C2=A0 =C2=A0 =C2=A0 KVM VGIC can only be initialized once during init =
time. But every<br>
&gt;=C2=A0 =C2=A0 =C2=A0 GICV3CPUState has an associated QOM CPU Object. La=
ter might correspond to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 vCPU which are &#39;yet-to-be-plugged&#39; (unplug=
ged at init).<br>
&gt;=C2=A0 =C2=A03. How should new QOM CPU objects be connected back to the=
 GICV3CPUState<br>
&gt;=C2=A0 =C2=A0 =C2=A0 objects and disconnected from it in case the CPU i=
s being hot(un)plugged?<br>
&gt;=C2=A0 =C2=A04. How should &#39;unplugged&#39; or &#39;yet-to-be-plugge=
d&#39; vCPUs be represented in the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QOM for which KVM vCPU already exists? For example=
, whether to keep,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0a. No QOM CPU objects Or<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0b. Unrealized CPU Objects<br>
&gt;=C2=A0 =C2=A05. How should vCPU state be exposed via ACPI to the Guest?=
 Especially for<br>
&gt;=C2=A0 =C2=A0 =C2=A0 the unplugged/yet-to-be-plugged vCPUs whose CPU ob=
jects might not exist<br>
&gt;=C2=A0 =C2=A0 =C2=A0 within the QOM but the Guest always expects all po=
ssible vCPUs to be<br>
&gt;=C2=A0 =C2=A0 =C2=A0 identified as ACPI *present* during boot.<br>
&gt;=C2=A0 =C2=A06. How should Qemu expose GIC CPU interfaces for the unplu=
gged or<br>
&gt;=C2=A0 =C2=A0 =C2=A0 yet-to-be-plugged vCPUs using ACPI MADT Table to t=
he Guest?<br>
&gt; <br>
&gt; E. Summary of Approach ([+] Workarounds to problems in sections A, B, =
C &amp; D)<br>
&gt; <br>
&gt;=C2=A0 =C2=A01. At VM Init, pre-create all the possible vCPUs in the Ho=
st KVM i.e., even<br>
&gt;=C2=A0 =C2=A0 =C2=A0 for the vCPUs which are yet-to-be-plugged in Qemu =
but keep them in the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 powered-off state.<br>
&gt;=C2=A0 =C2=A02. After the KVM vCPUs have been initialized in the Host, =
the KVM vCPU<br>
&gt;=C2=A0 =C2=A0 =C2=A0 objects corresponding to the unplugged/yet-to-be-p=
lugged vCPUs are parked<br>
&gt;=C2=A0 =C2=A0 =C2=A0 at the existing per-VM &quot;kvm_parked_vcpus&quot=
; list in Qemu. (similar to x86)<br>
&gt;=C2=A0 =C2=A03. GICV3State and GICV3CPUState objects are sized over pos=
sible vCPUs during<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VM init time i.e., when Qemu GIC is realized. This=
, in turn, sizes KVM VGIC<br>
&gt;=C2=A0 =C2=A0 =C2=A0 resources like memory regions, etc., related to th=
e redistributors with the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 number of possible KVM vCPUs. This never changes a=
fter VM has initialized.<br>
&gt;=C2=A0 =C2=A04. Qemu CPU objects corresponding to unplugged/yet-to-be-p=
lugged vCPUs are<br>
&gt;=C2=A0 =C2=A0 =C2=A0 released post Host KVM CPU and GIC/VGIC initializa=
tion.<br>
&gt;=C2=A0 =C2=A05. Build ACPI MADT Table with the following updates:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 a. Number of GIC CPU interface entries (=3Dpossibl=
e vCPUs)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 b. Present Boot vCPU as MADT.GICC.Enabled=3D1 (Not=
 hot[un]pluggable) <br>
&gt;=C2=A0 =C2=A0 =C2=A0 c. Present hot(un)pluggable vCPUs as MADT.GICC.onl=
ine-capable=3D1=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- MADT.GICC.Enabled=3D0 (Mutually exc=
lusive) [6][7]<br>
&gt; - vCPU can be ACPI enabled+onlined after Guest boots (Firmware Policy)=
 <br>
&gt; - Some issues with above (details in later sections)<br>
&gt;=C2=A0 =C2=A06. Expose below ACPI Status to Guest kernel:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 a. Always _STA.Present=3D1 (all possible vCPUs)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 b. _STA.Enabled=3D1 (plugged vCPUs)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 c. _STA.Enabled=3D0 (unplugged vCPUs)<br>
&gt;=C2=A0 =C2=A07. vCPU hotplug *realizes* new QOM CPU object. The followi=
ng happens:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 a. Realizes, initializes QOM CPU Object &amp; spaw=
ns Qemu vCPU thread.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 b. Unparks the existing KVM vCPU (&quot;kvm_parked=
_vcpus&quot; list).<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- Attaches to QOM CPU object.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 c. Reinitializes KVM vCPU in the Host.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- Resets the core and sys regs, sets =
defaults, etc.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 d. Runs KVM vCPU (created with &quot;start-powered=
-off&quot;).<br>
&gt; - vCPU thread sleeps (waits for vCPU reset via PSCI). <br>
&gt;=C2=A0 =C2=A0 =C2=A0 e. Updates Qemu GIC.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- Wires back IRQs related to this vCP=
U.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- GICV3CPUState association with QOM =
CPU Object.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 f. Updates [6] ACPI _STA.Enabled=3D1.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g. Notifies Guest about the new vCPU (via ACPI GED=
 interface).<br>
&gt; - Guest checks _STA.Enabled=3D1.<br>
&gt; - Guest adds processor (registers CPU with LDM) [3].<br>
&gt;=C2=A0 =C2=A0 =C2=A0 h. Plugs the QOM CPU object in the slot.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- slot-number =3D cpu-index {socket, =
cluster, core, thread}.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 i. Guest online&#39;s vCPU (CPU_ON PSCI call over =
HVC/SMC).<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- KVM exits HVC/SMC Hypercall [5] to =
Qemu (Policy Check).<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- Qemu powers-on KVM vCPU in the Host=
.<br>
&gt;=C2=A0 =C2=A08. vCPU hot-unplug *unrealizes* QOM CPU Object. The follow=
ing happens:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 a. Notifies Guest (via ACPI GED interface) vCPU ho=
t-unplug event.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- Guest offline&#39;s vCPU (CPU_OFF P=
SCI call over HVC/SMC).<br>
&gt;=C2=A0 =C2=A0 =C2=A0 b. KVM exits HVC/SMC Hypercall [5] to Qemu (Policy=
 Check).<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- Qemu powers-off the KVM vCPU in the=
 Host.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 c. Guest signals *Eject* vCPU to Qemu.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 d. Qemu updates [6] ACPI _STA.Enabled=3D0.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 e. Updates GIC.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- Un-wires IRQs related to this vCPU.=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- GICV3CPUState association with new =
QOM CPU Object is updated.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 f. Unplugs the vCPU.<br>
&gt; - Removes from slot.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- Parks KVM vCPU (&quot;kvm_parked_vc=
pus&quot; list).<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- Unrealizes QOM CPU Object &amp; joi=
ns back Qemu vCPU thread.<br>
&gt; - Destroys QOM CPU object.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g. Guest checks ACPI _STA.Enabled=3D0.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- Removes processor (unregisters CPU =
with LDM) [3].<br>
&gt; <br>
&gt; F. Work Presented at KVM Forum Conferences:<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; <br>
&gt; Details of the above work have been presented at KVMForum2020 and KVMF=
orum2023<br>
&gt; conferences. Slides &amp; video are available at the links below:<br>
&gt; a. KVMForum 2023<br>
&gt;=C2=A0 =C2=A0- Challenges Revisited in Supporting Virt CPU Hotplug on a=
rchitectures that don&#39;t Support CPU Hotplug (like ARM64).<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://kvm-forum.qemu.org/2023/KVM-foru=
m-cpu-hotplug_7OJ1YyJ.pdf" rel=3D"noreferrer" target=3D"_blank">https://kvm=
-forum.qemu.org/2023/KVM-forum-cpu-hotplug_7OJ1YyJ.pdf</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://kvm-forum.qemu.org/2023/Challeng=
es_Revisited_in_Supporting_Virt_CPU_Hotplug_-__ii0iNb3.pdf" rel=3D"noreferr=
er" target=3D"_blank">https://kvm-forum.qemu.org/2023/Challenges_Revisited_=
in_Supporting_Virt_CPU_Hotplug_-__ii0iNb3.pdf</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://www.youtube.com/watch?v=3Dhyrw4j=
2D6I0&amp;t=3D23970s" rel=3D"noreferrer" target=3D"_blank">https://www.yout=
ube.com/watch?v=3Dhyrw4j2D6I0&amp;t=3D23970s</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://kvm-forum.qemu.org/2023/talk/9SM=
PDQ/" rel=3D"noreferrer" target=3D"_blank">https://kvm-forum.qemu.org/2023/=
talk/9SMPDQ/</a><br>
&gt; b. KVMForum 2020<br>
&gt;=C2=A0 =C2=A0- Challenges in Supporting Virtual CPU Hotplug on SoC Base=
d Systems (like ARM64) - Salil Mehta, Huawei.<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://kvmforum2020.sched.com/event/eE4=
m" rel=3D"noreferrer" target=3D"_blank">https://kvmforum2020.sched.com/even=
t/eE4m</a><br>
&gt; <br>
&gt; (VI) Commands Used<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; <br>
&gt; A. Qemu launch commands to init the machine:<br>
&gt; <br>
&gt; $ qemu-system-aarch64 --enable-kvm -machine virt,gic-version=3D3 \<br>
&gt; -cpu host -smp cpus=3D4,maxcpus=3D6 \<br>
&gt; -m 300M \<br>
&gt; -kernel Image \<br>
&gt; -initrd rootfs.cpio.gz \<br>
&gt; -append &quot;console=3DttyAMA0 root=3D/dev/ram rdinit=3D/init maxcpus=
=3D2 acpi=3Dforce&quot; \<br>
&gt; -nographic \<br>
&gt; -bios QEMU_EFI.fd \<br>
&gt; <br>
&gt; B. Hot-(un)plug related commands:<br>
&gt; <br>
&gt; # Hotplug a host vCPU (accel=3Dkvm):<br>
&gt; $ device_add host-arm-cpu,id=3Dcore4,core-id=3D4<br>
&gt; <br>
&gt; # Hotplug a vCPU (accel=3Dtcg):<br>
&gt; $ device_add cortex-a57-arm-cpu,id=3Dcore4,core-id=3D4<br>
&gt; <br>
&gt; # Delete the vCPU:<br>
&gt; $ device_del core4<br>
&gt; <br>
&gt; Sample output on guest after boot:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 $ cat /sys/devices/system/cpu/possible<br>
&gt;=C2=A0 =C2=A0 0-5<br>
&gt;=C2=A0 =C2=A0 $ cat /sys/devices/system/cpu/present<br>
&gt;=C2=A0 =C2=A0 0-5<br>
&gt;=C2=A0 =C2=A0 $ cat /sys/devices/system/cpu/enabled<br>
&gt;=C2=A0 =C2=A0 0-3<br>
&gt;=C2=A0 =C2=A0 $ cat /sys/devices/system/cpu/online<br>
&gt;=C2=A0 =C2=A0 0-1<br>
&gt;=C2=A0 =C2=A0 $ cat /sys/devices/system/cpu/offline<br>
&gt;=C2=A0 =C2=A0 2-<br>
&gt; <br>
&gt; Sample output on guest after hotplug of vCPU=3D4:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 $ cat /sys/devices/system/cpu/possible<br>
&gt;=C2=A0 =C2=A0 0-5<br>
&gt;=C2=A0 =C2=A0 $ cat /sys/devices/system/cpu/present<br>
&gt;=C2=A0 =C2=A0 0-5<br>
&gt;=C2=A0 =C2=A0 $ cat /sys/devices/system/cpu/enabled<br>
&gt;=C2=A0 =C2=A0 0-4<br>
&gt;=C2=A0 =C2=A0 $ cat /sys/devices/system/cpu/online<br>
&gt;=C2=A0 =C2=A0 0-1,4<br>
&gt;=C2=A0 =C2=A0 $ cat /sys/devices/system/cpu/offline<br>
&gt;=C2=A0 =C2=A0 2-3,5<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 Note: vCPU=3D4 was explicitly &#39;onlined&#39; after hot=
-plug<br>
&gt;=C2=A0 =C2=A0 $ echo 1 &gt; /sys/devices/system/cpu/cpu4/online<br>
&gt; <br>
&gt; (VII) Latest Repository<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<=
br>
&gt; <br>
&gt; (*) Latest Qemu RFC V5 (Architecture Specific) patch set:<br>
&gt;=C2=A0 =C2=A0 <a href=3D"https://github.com/salil-mehta/qemu.git" rel=
=3D"noreferrer" target=3D"_blank">https://github.com/salil-mehta/qemu.git</=
a> virt-cpuhp-armv8/rfc-v5<br>
&gt; (*) Latest Architecture Agnostic ACPI changes patch-set:<br>
&gt;=C2=A0 =C2=A0 <a href=3D"https://lore.kernel.org/qemu-devel/20241014192=
205.253479-1-salil.mehta@huawei.com/#t" rel=3D"noreferrer" target=3D"_blank=
">https://lore.kernel.org/qemu-devel/20241014192205.253479-1-salil.mehta@hu=
awei.com/#t</a><br>
&gt; (*) Older QEMU changes for vCPU hotplug can be cloned from below site:=
<br>
&gt;=C2=A0 =C2=A0 <a href=3D"https://github.com/salil-mehta/qemu.git" rel=
=3D"noreferrer" target=3D"_blank">https://github.com/salil-mehta/qemu.git</=
a> virt-cpuhp-armv8/rfc-{v1,v2,v3,v4}<br>
&gt; (*) `Accepted` Qemu Architecture Agnostic patch is present here:<br>
&gt;=C2=A0 =C2=A0 <a href=3D"https://github.com/salil-mehta/qemu/commits/vi=
rt-cpuhp-armv8/rfc-v3.arch.agnostic.v16/" rel=3D"noreferrer" target=3D"_bla=
nk">https://github.com/salil-mehta/qemu/commits/virt-cpuhp-armv8/rfc-v3.arc=
h.agnostic.v16/</a><br>
&gt; (*) All Kernel changes are already part of mainline v6.11<br>
&gt; (*) Original Guest Kernel changes (by James Morse, ARM) are available =
here:<br>
&gt;=C2=A0 =C2=A0 <a href=3D"https://git.kernel.org/pub/scm/linux/kernel/gi=
t/morse/linux.git" rel=3D"noreferrer" target=3D"_blank">https://git.kernel.=
org/pub/scm/linux/kernel/git/morse/linux.git</a> virtual_cpu_hotplug/rfc/v2=
<br>
&gt; <br>
&gt; <br>
&gt; (VIII) KNOWN ISSUES<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; <br>
&gt; 1. HVF and qtest are not supported yet.<br>
&gt; 2. ACPI MADT Table flags [7] MADT.GICC.Enabled and MADT.GICC.online-ca=
pable are<br>
&gt;=C2=A0 =C2=A0mutually exclusive, i.e., as per the change [6], a vCPU ca=
nnot be both<br>
&gt;=C2=A0 =C2=A0GICC.Enabled and GICC.online-capable. This means:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 [ Link: <a href=3D"https://bugzilla.tianocore.org/=
show_bug.cgi?id=3D3706" rel=3D"noreferrer" target=3D"_blank">https://bugzil=
la.tianocore.org/show_bug.cgi?id=3D3706</a> ]<br>
&gt;=C2=A0 =C2=A0a. If we have to support hot-unplug of the cold-booted vCP=
Us, then these MUST<br>
&gt;=C2=A0 =C2=A0 =C2=A0 be specified as GICC.online-capable in the MADT Ta=
ble during boot by the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 firmware/Qemu. But this requirement conflicts with=
 the requirement to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 support new Qemu changes with legacy OS that don&#=
39;t understand<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MADT.GICC.online-capable Bit. Legacy OS during boo=
t time will ignore this<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bit, and hence these vCPUs will not appear on such=
 OS. This is unexpected<br>
&gt;=C2=A0 =C2=A0 =C2=A0 behavior.<br>
&gt;=C2=A0 =C2=A0b. In case we decide to specify vCPUs as MADT.GICC.Enabled=
 and try to unplug<br>
&gt;=C2=A0 =C2=A0 =C2=A0 these cold-booted vCPUs from OS (which in actualit=
y should be blocked by<br>
&gt;=C2=A0 =C2=A0 =C2=A0 returning error at Qemu), then features like &#39;=
kexec&#39; will break.<br>
&gt;=C2=A0 =C2=A0c. As I understand, removal of the cold-booted vCPUs is a =
required feature<br>
&gt;=C2=A0 =C2=A0 =C2=A0 and x86 world allows it.<br>
&gt;=C2=A0 =C2=A0d. Hence, either we need a specification change to make th=
e MADT.GICC.Enabled<br>
&gt;=C2=A0 =C2=A0 =C2=A0 and MADT.GICC.online-capable Bits NOT mutually exc=
lusive or NOT support<br>
&gt;=C2=A0 =C2=A0 =C2=A0 the removal of cold-booted vCPUs. In the latter ca=
se, a check can be introduced<br>
&gt;=C2=A0 =C2=A0 =C2=A0 to bar the users from unplugging vCPUs, which were=
 cold-booted, using QMP<br>
&gt;=C2=A0 =C2=A0 =C2=A0 commands. (Needs discussion!)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Please check the patch part of this patch set:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 [hw/arm/virt: Expose cold-booted CPUs as MADT GICC=
 Enabled].<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 NOTE: This is definitely not a blocker!<br>
&gt; <br>
&gt; <br>
&gt; (IX) THINGS TO DO<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; <br>
&gt; 1. TCG is now in working state but would need extensive testing to rol=
l out<br>
&gt;=C2=A0 =C2=A0any corner cases. Any help related to this will be appreci=
ated!<br>
&gt; 2. Comprehensive Testing is in progress. (Positive feedback from Oracl=
e &amp; Ampere)<br>
&gt; 3. Qemu Documentation (.rst) needs to be updated.<br>
&gt; 4. The `is_enabled` and `is_present` ACPI states are now common to all=
 architectures<br>
&gt;=C2=A0 =C2=A0and should work seemlessely but needs thorough testing wit=
h other architectures.<br>
&gt; 5. Migration has been lightly tested but has been found working.<br>
&gt; 6. A missing check for PMU state for the hotplugged vCPUs (Reported by=
: Gavin Shan)<br>
&gt;=C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/28f3107f-026=
7-4112-b0ca-da59df2968ae@redhat.com/" rel=3D"noreferrer" target=3D"_blank">=
https://lore.kernel.org/qemu-devel/28f3107f-0267-4112-b0ca-da59df2968ae@red=
hat.com/</a><br>
&gt; 7. Need help in Testing with ARM hardware extensions like SVE/SME<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; Best regards,=C2=A0 <br>
&gt; Salil.<br>
&gt; <br>
&gt; (X) DISCLAIMER<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; <br>
&gt; This work is an attempt to present a proof-of-concept of the ARM64 vCP=
U hotplug<br>
&gt; implementation to the community. This is *not* production-level code a=
nd might<br>
&gt; have bugs. Comprehensive testing is being done on HiSilicon Kunpeng920=
 SoC,<br>
&gt; Oracle, and Ampere servers. We are nearing stable code and a non-RFC<b=
r>
&gt; version shall be floated soon.<br>
&gt; <br>
&gt; This work is *mostly* in the lines of the discussions that have happen=
ed in the<br>
&gt; previous years [see refs below] across different channels like the mai=
ling list,<br>
&gt; Linaro Open Discussions platform, and various conferences like KVMForu=
m, etc. This<br>
&gt; RFC is being used as a way to verify the idea mentioned in this cover =
letter and<br>
&gt; to get community views. Once this has been agreed upon, a formal patch=
 shall be<br>
&gt; posted to the mailing list for review.<br>
&gt; <br>
&gt; [The concept being presented has been found to work!]<br>
&gt; <br>
&gt; (XI) ORGANIZATION OF PATCHES<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D<br>
&gt; <br>
&gt; A. ARM Architecture *specific* patches:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0[Patch 1-8, 11, 12, 30] logic required during machine init=
.<br>
&gt;=C2=A0 =C2=A0 (*) Some validation checks.<br>
&gt;=C2=A0 =C2=A0 (*) Introduces core-id property and some util functions r=
equired later.<br>
&gt;=C2=A0 =C2=A0 (*) Logic to pre-create vCPUs.<br>
&gt;=C2=A0 =C2=A0 (*) Introduction of the GICv3 CPU Interface `accessibilit=
y` interface<br>
&gt;=C2=A0 =C2=A0 (*) GIC initialization pre-sized with possible vCPUs.<br>
&gt;=C2=A0 =C2=A0 (*) Some refactoring to have common hot and cold plug log=
ic together.<br>
&gt;=C2=A0 =C2=A0 (*) Release of disabled QOM CPU objects in post_cpu_init(=
).<br>
&gt;=C2=A0 =C2=A0[Patch 9-10, 13-15] logic related to ACPI at machine init =
time.<br>
&gt;=C2=A0 =C2=A0 (*) Changes required to Enable ACPI for CPU hotplug.<br>
&gt;=C2=A0 =C2=A0 (*) Initialization of ACPI GED framework to cater to CPU =
Hotplug Events.<br>
&gt;=C2=A0 =C2=A0 (*) ACPI DSDT, MADT/MAT changes.<br>
&gt;=C2=A0 =C2=A0[Patch 17-29] logic required during vCPU hot-(un)plug.<br>
&gt;=C2=A0 =C2=A0 (*) Basic framework changes to support vCPU hot-(un)plug.=
<br>
&gt;=C2=A0 =C2=A0 (*) ACPI GED changes for hot-(un)plug hooks.<br>
&gt;=C2=A0 =C2=A0 (*) Wire-unwire the IRQs.<br>
&gt;=C2=A0 =C2=A0 (*) GIC notification logic on receiving vCPU hot(un)plug =
event.<br>
&gt;=C2=A0 =C2=A0 (*) ARMCPU unrealize logic.<br>
&gt;=C2=A0 =C2=A0 (*) Handling of SMCC Hypercall Exits by KVM to Qemu.<br>
&gt;=C2=A0 =C2=A0[Patch 33] Disable unplug of cold-booted vCPUs<br>
&gt; <br>
&gt; <br>
&gt; (XII) REFERENCES<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; <br>
&gt; [1] <a href=3D"https://lore.kernel.org/qemu-devel/20200613213629.21984=
-1-salil.mehta@huawei.com/" rel=3D"noreferrer" target=3D"_blank">https://lo=
re.kernel.org/qemu-devel/20200613213629.21984-1-salil.mehta@huawei.com/</a>=
<br>
&gt; [2] <a href=3D"https://lore.kernel.org/linux-arm-kernel/20200625133757=
.22332-1-salil.mehta@huawei.com/" rel=3D"noreferrer" target=3D"_blank">http=
s://lore.kernel.org/linux-arm-kernel/20200625133757.22332-1-salil.mehta@hua=
wei.com/</a><br>
&gt; [3] <a href=3D"https://lore.kernel.org/lkml/20230203135043.409192-1-ja=
mes.morse@arm.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.kerne=
l.org/lkml/20230203135043.409192-1-james.morse@arm.com/</a><br>
&gt; [4] <a href=3D"https://lore.kernel.org/all/20230913163823.7880-1-james=
.morse@arm.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.o=
rg/all/20230913163823.7880-1-james.morse@arm.com/</a><br>
&gt; [5] <a href=3D"https://lore.kernel.org/all/20230404154050.2270077-1-ol=
iver.upton@linux.dev/" rel=3D"noreferrer" target=3D"_blank">https://lore.ke=
rnel.org/all/20230404154050.2270077-1-oliver.upton@linux.dev/</a><br>
&gt; [6] <a href=3D"https://bugzilla.tianocore.org/show_bug.cgi?id=3D3706" =
rel=3D"noreferrer" target=3D"_blank">https://bugzilla.tianocore.org/show_bu=
g.cgi?id=3D3706</a><br>
&gt; [7] <a href=3D"https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Progra=
mming_Model.html#gic-cpu-interface-gicc-structure" rel=3D"noreferrer" targe=
t=3D"_blank">https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_M=
odel.html#gic-cpu-interface-gicc-structure</a><br>
&gt; [8] <a href=3D"https://bugzilla.tianocore.org/show_bug.cgi?id=3D4481#c=
5" rel=3D"noreferrer" target=3D"_blank">https://bugzilla.tianocore.org/show=
_bug.cgi?id=3D4481#c5</a><br>
&gt; [9] <a href=3D"https://cloud.google.com/kubernetes-engine/docs/concept=
s/verticalpodautoscaler" rel=3D"noreferrer" target=3D"_blank">https://cloud=
.google.com/kubernetes-engine/docs/concepts/verticalpodautoscaler</a><br>
&gt; [10] <a href=3D"https://docs.aws.amazon.com/eks/latest/userguide/verti=
cal-pod-autoscaler.html" rel=3D"noreferrer" target=3D"_blank">https://docs.=
aws.amazon.com/eks/latest/userguide/vertical-pod-autoscaler.html</a><br>
&gt; [11] <a href=3D"https://lkml.org/lkml/2019/7/10/235" rel=3D"noreferrer=
" target=3D"_blank">https://lkml.org/lkml/2019/7/10/235</a><br>
&gt; [12] <a href=3D"https://lists.cs.columbia.edu/pipermail/kvmarm/2018-Ju=
ly/032316.html" rel=3D"noreferrer" target=3D"_blank">https://lists.cs.colum=
bia.edu/pipermail/kvmarm/2018-July/032316.html</a><br>
&gt; [13] <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-01/=
msg06517.html" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.org/a=
rchive/html/qemu-devel/2020-01/msg06517.html</a><br>
&gt; [14] <a href=3D"https://op-lists.linaro.org/archives/list/linaro-open-=
discussions@op-lists.linaro.org/thread/7CGL6JTACPUZEYQC34CZ2ZBWJGSR74WE/" r=
el=3D"noreferrer" target=3D"_blank">https://op-lists.linaro.org/archives/li=
st/linaro-open-discussions@op-lists.linaro.org/thread/7CGL6JTACPUZEYQC34CZ2=
ZBWJGSR74WE/</a><br>
&gt; [15] <a href=3D"http://lists.nongnu.org/archive/html/qemu-devel/2018-0=
7/msg01168.html" rel=3D"noreferrer" target=3D"_blank">http://lists.nongnu.o=
rg/archive/html/qemu-devel/2018-07/msg01168.html</a><br>
&gt; [16] <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-06/=
msg00131.html" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.org/a=
rchive/html/qemu-devel/2020-06/msg00131.html</a><br>
&gt; [17] <a href=3D"https://op-lists.linaro.org/archives/list/linaro-open-=
discussions@op-lists.linaro.org/message/X74JS6P2N4AUWHHATJJVVFDI2EMDZJ74/" =
rel=3D"noreferrer" target=3D"_blank">https://op-lists.linaro.org/archives/l=
ist/linaro-open-discussions@op-lists.linaro.org/message/X74JS6P2N4AUWHHATJJ=
VVFDI2EMDZJ74/</a><br>
&gt; [18] <a href=3D"https://lore.kernel.org/lkml/20210608154805.216869-1-j=
ean-philippe@linaro.org/" rel=3D"noreferrer" target=3D"_blank">https://lore=
.kernel.org/lkml/20210608154805.216869-1-jean-philippe@linaro.org/</a><br>
&gt; [19] <a href=3D"https://lore.kernel.org/all/20230913163823.7880-1-jame=
s.morse@arm.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.=
org/all/20230913163823.7880-1-james.morse@arm.com/</a> <br>
&gt; [20] <a href=3D"https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Progr=
amming_Model.html#gicc-cpu-interface-flags" rel=3D"noreferrer" target=3D"_b=
lank">https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.ht=
ml#gicc-cpu-interface-flags</a><br>
&gt; [21] <a href=3D"https://lore.kernel.org/qemu-devel/20230926100436.2828=
4-1-salil.mehta@huawei.com/" rel=3D"noreferrer" target=3D"_blank">https://l=
ore.kernel.org/qemu-devel/20230926100436.28284-1-salil.mehta@huawei.com/</a=
><br>
&gt; [22] <a href=3D"https://lore.kernel.org/qemu-devel/20240607115649.2146=
22-1-salil.mehta@huawei.com/T/#md0887eb07976bc76606a8204614ccc7d9a01c1f7" r=
el=3D"noreferrer" target=3D"_blank">https://lore.kernel.org/qemu-devel/2024=
0607115649.214622-1-salil.mehta@huawei.com/T/#md0887eb07976bc76606a8204614c=
cc7d9a01c1f7</a><br>
&gt; [23] RFC V3: <a href=3D"https://lore.kernel.org/qemu-devel/20240613233=
639.202896-1-salil.mehta@huawei.com/#t" rel=3D"noreferrer" target=3D"_blank=
">https://lore.kernel.org/qemu-devel/20240613233639.202896-1-salil.mehta@hu=
awei.com/#t</a><br>
&gt; <br>
&gt; (XIII) ACKNOWLEDGEMENTS<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<=
br>
&gt; <br>
&gt; I would like to thank the following people for various discussions wit=
h me over different channels during development:<br>
&gt; <br>
&gt; Marc Zyngier (Google), Catalin Marinas (ARM), James Morse (ARM), Will =
Deacon (Google), <br>
&gt; Jean-Philippe Brucker (Linaro), Sudeep Holla (ARM), Lorenzo Pieralisi =
(Linaro), <br>
&gt; Gavin Shan (RedHat), Jonathan Cameron (Huawei), Darren Hart (Ampere), =
<br>
&gt; Igor Mamedov (RedHat), Ilkka Koskinen (Ampere), Andrew Jones (RedHat),=
 <br>
&gt; Karl Heubaum (Oracle), Keqian Zhu (Huawei), Miguel Luis (Oracle), <br>
&gt; Xiongfeng Wang (Huawei), Vishnu Pajjuri (Ampere), Shameerali Kolothum =
(Huawei), <br>
&gt; Russell King (Oracle), Xuwei/Joy (Huawei), Peter Maydel (Linaro), <br>
&gt; Zengtao/Prime (Huawei), Nicholas Piggin (IBM) and all those whom I hav=
e missed!<br>
&gt; <br>
&gt; Many thanks to the following people for their current or past contribu=
tions:<br>
&gt; <br>
&gt; 1. James Morse (ARM)<br>
&gt;=C2=A0 =C2=A0(Current Kernel part of vCPU Hotplug Support on AARCH64)<b=
r>
&gt; 2. Jean-Philippe Brucker (Linaro)<br>
&gt;=C2=A0 =C2=A0(Prototyped one of the earlier PSCI-based POC [17][18] bas=
ed on RFC V1)<br>
&gt; 3. Keqian Zhu (Huawei)<br>
&gt;=C2=A0 =C2=A0(Co-developed Qemu prototype)<br>
&gt; 4. Xiongfeng Wang (Huawei)<br>
&gt;=C2=A0 =C2=A0(Co-developed an earlier kernel prototype with me)<br>
&gt; 5. Vishnu Pajjuri (Ampere)<br>
&gt;=C2=A0 =C2=A0(Verification on Ampere ARM64 Platforms + fixes)<br>
&gt; 6. Miguel Luis (Oracle)<br>
&gt;=C2=A0 =C2=A0(Verification on Oracle ARM64 Platforms + fixes)<br>
&gt; 7. Russell King (Oracle) &amp; Jonathan Cameron (Huawei)<br>
&gt;=C2=A0 =C2=A0(Helping in upstreaming James Morse&#39;s Kernel patches).=
<br>
&gt; <br>
&gt; (XIV) Change Log:<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; <br>
&gt; RFC V4 -&gt; RFC V5:<br>
&gt; -----------------<br>
&gt; 1. Dropped &quot;[PATCH RFC V4 19/33] target/arm: Force ARM vCPU *pres=
ent* status ACPI *persistent*&quot;<br>
&gt;=C2=A0 =C2=A0- Seperated the architecture agnostic ACPI changes require=
d to support vCPU Hotplug<br>
&gt;=C2=A0 =C2=A0 =C2=A0Link: <a href=3D"https://lore.kernel.org/qemu-devel=
/20241014192205.253479-1-salil.mehta@huawei.com/#t" rel=3D"noreferrer" targ=
et=3D"_blank">https://lore.kernel.org/qemu-devel/20241014192205.253479-1-sa=
lil.mehta@huawei.com/#t</a><br>
&gt; 2. Dropped &quot;[PATCH RFC V4 02/33] cpu-common: Add common CPU utili=
ty for possible vCPUs&quot;<br>
&gt;=C2=A0 =C2=A0- Dropped qemu{present,enabled}_cpu() APIs. Commented by G=
avin (Redhat), Miguel(Oracle), Igor(Redhat)<br>
&gt; 3. Added &quot;Reviewed-by: Miguel Luis &lt;<a href=3D"mailto:miguel.l=
uis@oracle.com" target=3D"_blank">miguel.luis@oracle.com</a>&gt;&quot; to [=
PATCH RFC V4 01/33]<br>
&gt; 3. Dropped the `CPUState::disabled` flag and introduced `GICv3State::n=
um_smp_cpus` flag<br>
&gt;=C2=A0 =C2=A0- All `GICv3CPUState&#39; between [num_smp_cpus,num_cpus) =
are marked as &#39;inaccessible` during gicv3_common_realize()<br>
&gt;=C2=A0 =C2=A0- qemu_enabled_cpu() not required - removed!<br>
&gt;=C2=A0 =C2=A0- removed usage of `CPUState::disabled` from virt.c and hw=
/cpu64.c<br>
&gt; 4. Removed virt_cpu_properties() and introduced property `mp-affinity`=
 get accessor<br>
&gt; 5. Dropped &quot;[PATCH RFC V4 12/33] arm/virt: Create GED device befo=
re *disabled* vCPU Objects are destroyed&quot;<br>
&gt; <br>
<br>
I&#39;ve tested this series on the following configurations for both KVM an=
d TCG:<br>
<br>
-M virt -accel kvm -cpu host<br>
-M virt,gic_version=3D3 -accel kvm -cpu host<br>
-M virt,gic_version=3D3 -accel tcg -cpu max<br>
<br>
They boot, QEMU is able to hotplug and unplug vCPUs and successive live<br>
migrations work as expected.<br>
<br>
For migrations where the destination VM exceeds the number of vCPUs enabled=
 on<br>
the source VM (patch 26/30) QEMU shows the expected warnings, also for both=
 KVM<br>
and TCG:<br>
<br>
qemu-system-aarch64: warning: Found CPU 2 enabled, for incoming *disabled* =
GICC State<br>
qemu-system-aarch64: warning: *Disabling* CPU 2, to match the incoming migr=
ated state<br></blockquote><div><br></div><div><br></div><div>Thanks for co=
nfirming this.</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
<br>
The following configuration of:<br>
<br>
-M virt -accel tcg -cpu max<br></blockquote><div><br></div><div><br></div><=
div>Yep, perhaps that&#39;s something=C2=A0I missed while testing. Thanks f=
or identifying.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
<br>
shows defects in which I had to use the below diff to proceed to boot:<br>
<br>
diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c<br>
index 53fb2c4e2d..f5ad33093e 100644<br>
--- a/hw/intc/arm_gic_common.c<br>
+++ b/hw/intc/arm_gic_common.c<br>
@@ -350,6 +350,7 @@ static void arm_gic_common_linux_init(ARMLinuxBootIf *o=
bj,<br>
<br>
=C2=A0static Property arm_gic_common_properties[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_UINT32(&quot;num-cpu&quot;, GICState, num_c=
pu, 1),<br>
+=C2=A0 =C2=A0 DEFINE_PROP_UINT32(&quot;num-smp-cpu&quot;, GICState, num_sm=
p_cpu, 1),<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_UINT32(&quot;num-irq&quot;, GICState, num_i=
rq, 32),<br>
=C2=A0 =C2=A0 =C2=A0/* Revision can be 1 or 2 for GIC architecture specific=
ation<br>
=C2=A0 =C2=A0 =C2=A0 * versions 1 or 2, or 0 to indicate the legacy 11MPCor=
e GIC.<br>
diff --git a/include/hw/intc/arm_gic_common.h b/include/hw/intc/arm_gic_com=
mon.h<br>
index 97fea4102d..a57f20798a 100644<br>
--- a/include/hw/intc/arm_gic_common.h<br>
+++ b/include/hw/intc/arm_gic_common.h<br>
@@ -130,6 +130,8 @@ struct GICState {<br>
<br>
=C2=A0 =C2=A0 =C2=A0uint32_t num_cpu;<br>
<br>
+=C2=A0 =C2=A0 uint32_t num_smp_cpu;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0MemoryRegion iomem; /* Distributor */<br>
=C2=A0 =C2=A0 =C2=A0/* This is just so we can have an opaque pointer which =
identifies<br>
=C2=A0 =C2=A0 =C2=A0 * both this GIC and which CPU interface we should be a=
ccessing.<br>
<br>
And lastly, one more issue I=E2=80=99ve noticed with this configuration is =
adding a new vcpu<br>
with -device also needs fixing as is breaking the assert:<br>
<br>
`cpu_id &gt;=3D 0 &amp;&amp; cpu_id &lt; ms-&gt;possible_cpus-&gt;len`<br>
<br>
in virt_get_cpu_id_from_cpu_topo.<br></blockquote><div><br></div><div><br><=
/div><div>sure. Thanks.</div><div><br></div><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
<br>
<br>
Thank you<br>
Miguel<br>
<br>
<br>
&gt; RFC V3 -&gt; RFC V4:<br>
&gt; -----------------<br>
&gt; 1. Addressed Nicholas Piggin&#39;s (IBM) comments<br>
&gt;=C2=A0 =C2=A0- Moved qemu_get_cpu_archid() as a ACPI helper inline acpi=
/cpu.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/D2GFC=
LH11HGJ.1IJGANHQ9ZQRL@gmail.com/" rel=3D"noreferrer" target=3D"_blank">http=
s://lore.kernel.org/qemu-devel/D2GFCLH11HGJ.1IJGANHQ9ZQRL@gmail.com/</a><br=
>
&gt;=C2=A0 =C2=A0- Introduced new macro CPU_FOREACH_POSSIBLE() in [PATCH 12=
/33] <br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/D2GF9=
A9AJO02.1G1G8UEXA5AOD@gmail.com/" rel=3D"noreferrer" target=3D"_blank">http=
s://lore.kernel.org/qemu-devel/D2GF9A9AJO02.1G1G8UEXA5AOD@gmail.com/</a><br=
>
&gt;=C2=A0 =C2=A0- Converted CPUState::acpi_persistent into Property. Impro=
ved the cover note<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/D2H62=
RK48KT7.2BTQEZUOEGG4L@gmail.com/" rel=3D"noreferrer" target=3D"_blank">http=
s://lore.kernel.org/qemu-devel/D2H62RK48KT7.2BTQEZUOEGG4L@gmail.com/</a><br=
>
&gt;=C2=A0 =C2=A0- Fixed teh cover note of the[PATCH ] and clearly mentione=
d about KVMParking<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/D2GFO=
GQC3HYO.2LKOV306JIU98@gmail.com/" rel=3D"noreferrer" target=3D"_blank">http=
s://lore.kernel.org/qemu-devel/D2GFOGQC3HYO.2LKOV306JIU98@gmail.com/</a> <b=
r>
&gt; 2. Addressed Gavin Shan&#39;s (RedHat) comments:<br>
&gt;=C2=A0 =C2=A0- Introduced the ARM Extensions check. [Looks like I misse=
d the PMU check :( ]<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/28f31=
07f-0267-4112-b0ca-da59df2968ae@redhat.com/" rel=3D"noreferrer" target=3D"_=
blank">https://lore.kernel.org/qemu-devel/28f3107f-0267-4112-b0ca-da59df296=
8ae@redhat.com/</a><br>
&gt;=C2=A0 =C2=A0- Moved create_gpio() along with create_ged()<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/143ad=
7d2-8f45-4428-bed3-891203a49029@redhat.com/" rel=3D"noreferrer" target=3D"_=
blank">https://lore.kernel.org/qemu-devel/143ad7d2-8f45-4428-bed3-891203a49=
029@redhat.com/</a><br>
&gt;=C2=A0 =C2=A0- Improved the logic of the GIC creation and initializatio=
n<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/9b758=
2f0-8149-4bf0-a1aa-4d4fe0d35e70@redhat.com/" rel=3D"noreferrer" target=3D"_=
blank">https://lore.kernel.org/qemu-devel/9b7582f0-8149-4bf0-a1aa-4d4fe0d35=
e70@redhat.com/</a><br>
&gt;=C2=A0 =C2=A0- Removed redundant !dev-&gt;realized checks in cpu_hotunp=
lug(_request)<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/64e9f=
eaa-8df2-4108-9e73-c72517fb074a@redhat.com/" rel=3D"noreferrer" target=3D"_=
blank">https://lore.kernel.org/qemu-devel/64e9feaa-8df2-4108-9e73-c72517fb0=
74a@redhat.com/</a><br>
&gt; 3. Addresses Alex Benn=C3=A9e&#39;s + Gustavo Romero (Linaro) comments=
<br>
&gt;=C2=A0 =C2=A0- Fixed the TCG support and now it works for all the cases=
 including migration.<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/87bk1=
b3azm.fsf@draig.linaro.org/" rel=3D"noreferrer" target=3D"_blank">https://l=
ore.kernel.org/qemu-devel/87bk1b3azm.fsf@draig.linaro.org/</a><br>
&gt;=C2=A0 =C2=A0- Fixed the cpu_address_space_destroy() compilation failue=
r in user-mode<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/87v80=
0wkb1.fsf@draig.linaro.org/" rel=3D"noreferrer" target=3D"_blank">https://l=
ore.kernel.org/qemu-devel/87v800wkb1.fsf@draig.linaro.org/</a><br>
&gt; 4. Fixed crash in .post_gicv3() during migration with asymmetrically *=
enabled*<br>
&gt;=C2=A0 =C2=A0 =C2=A0vCPUs at destination VM<br>
&gt; <br>
&gt; RFC V2 -&gt; RFC V3:<br>
&gt; -----------------<br>
&gt; 1. Miscellaneous:<br>
&gt;=C2=A0 =C2=A0- Split the RFC V2 into arch-agnostic and arch-specific pa=
tch sets.<br>
&gt; 2. Addressed Gavin Shan&#39;s (RedHat) comments:<br>
&gt;=C2=A0 =C2=A0- Made CPU property accessors inline.<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/6cd28=
639-2cfa-f233-c6d9-d5d2ec5b1c58@redhat.com/" rel=3D"noreferrer" target=3D"_=
blank">https://lore.kernel.org/qemu-devel/6cd28639-2cfa-f233-c6d9-d5d2ec5b1=
c58@redhat.com/</a><br>
&gt;=C2=A0 =C2=A0- Collected Reviewed-bys [PATCH RFC V2 4/37, 14/37, 22/37]=
.<br>
&gt;=C2=A0 =C2=A0- Dropped the patch as it was not required after init logi=
c was refactored.<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/4fb2e=
ef9-6742-1eeb-721a-b3db04b1be97@redhat.com/" rel=3D"noreferrer" target=3D"_=
blank">https://lore.kernel.org/qemu-devel/4fb2eef9-6742-1eeb-721a-b3db04b1b=
e97@redhat.com/</a><br>
&gt;=C2=A0 =C2=A0- Fixed the range check for the core during vCPU Plug.<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/1c5fa=
24c-6bf3-750f-4f22-087e4a9311af@redhat.com/" rel=3D"noreferrer" target=3D"_=
blank">https://lore.kernel.org/qemu-devel/1c5fa24c-6bf3-750f-4f22-087e4a931=
1af@redhat.com/</a><br>
&gt;=C2=A0 =C2=A0- Added has_hotpluggable_vcpus check to make build_cpus_am=
l() conditional.<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/83234=
2cb-74bc-58dd-c5d7-6f995baeb0f2@redhat.com/" rel=3D"noreferrer" target=3D"_=
blank">https://lore.kernel.org/qemu-devel/832342cb-74bc-58dd-c5d7-6f995baeb=
0f2@redhat.com/</a><br>
&gt;=C2=A0 =C2=A0- Fixed the states initialization in cpu_hotplug_hw_init()=
 to accommodate previous refactoring.<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/da5e5=
609-1883-8650-c7d8-6868c7b74f1c@redhat.com/" rel=3D"noreferrer" target=3D"_=
blank">https://lore.kernel.org/qemu-devel/da5e5609-1883-8650-c7d8-6868c7b74=
f1c@redhat.com/</a><br>
&gt;=C2=A0 =C2=A0- Fixed typos.<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/eb1ac=
571-7844-55e6-15e7-3dd7df21366b@redhat.com/" rel=3D"noreferrer" target=3D"_=
blank">https://lore.kernel.org/qemu-devel/eb1ac571-7844-55e6-15e7-3dd7df213=
66b@redhat.com/</a><br>
&gt;=C2=A0 =C2=A0- Removed the unnecessary &#39;goto fail&#39;.<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/4d898=
0ac-f402-60d4-fe52-787815af8a7d@redhat.com/#t" rel=3D"noreferrer" target=3D=
"_blank">https://lore.kernel.org/qemu-devel/4d8980ac-f402-60d4-fe52-787815a=
f8a7d@redhat.com/#t</a><br>
&gt;=C2=A0 =C2=A0- Added check for hotpluggable vCPUs in the _OSC method.<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/20231=
017001326.FUBqQ1PTowF2GxQpnL3kIW0AhmSqbspazwixAHVSi6c@z/" rel=3D"noreferrer=
" target=3D"_blank">https://lore.kernel.org/qemu-devel/20231017001326.FUBqQ=
1PTowF2GxQpnL3kIW0AhmSqbspazwixAHVSi6c@z/</a><br>
&gt; 3. Addressed Shaoqin Huang&#39;s (Intel) comments:<br>
&gt;=C2=A0 =C2=A0- Fixed the compilation break due to the absence of a call=
 to virt_cpu_properties() missing<br>
&gt;=C2=A0 =C2=A0 =C2=A0along with its definition.<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/3632e=
e24-47f7-ae68-8790-26eb2cf9950b@redhat.com/" rel=3D"noreferrer" target=3D"_=
blank">https://lore.kernel.org/qemu-devel/3632ee24-47f7-ae68-8790-26eb2cf99=
50b@redhat.com/</a><br>
&gt; 4. Addressed Jonathan Cameron&#39;s (Huawei) comments:<br>
&gt;=C2=A0 =C2=A0- Gated the &#39;disabled vcpu message&#39; for GIC versio=
n &lt; 3.<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/20240=
116155911.00004fe1@Huawei.com/" rel=3D"noreferrer" target=3D"_blank">https:=
//lore.kernel.org/qemu-devel/20240116155911.00004fe1@Huawei.com/</a><br>
&gt; <br>
&gt; RFC V1 -&gt; RFC V2:<br>
&gt; -----------------<br>
&gt; 1. Addressed James Morse&#39;s (ARM) requirement as per Linaro Open Di=
scussion:<br>
&gt;=C2=A0 =C2=A0- Exposed all possible vCPUs as always ACPI _STA.present a=
nd available during boot time.<br>
&gt;=C2=A0 =C2=A0- Added the _OSC handling as required by James&#39;s patch=
es.<br>
&gt;=C2=A0 =C2=A0- Introduction of &#39;online-capable&#39; bit handling in=
 the flag of MADT GICC.<br>
&gt;=C2=A0 =C2=A0- SMCC Hypercall Exit handling in Qemu.<br>
&gt; 2. Addressed Marc Zyngier&#39;s comment:<br>
&gt;=C2=A0 =C2=A0- Fixed the note about GIC CPU Interface in the cover lett=
er.<br>
&gt; 3. Addressed issues raised by Vishnu Pajjuru (Ampere) &amp; Miguel Lui=
s (Oracle) during testing:<br>
&gt;=C2=A0 =C2=A0- Live/Pseudo Migration crashes.<br>
&gt; 4. Others:<br>
&gt;=C2=A0 =C2=A0- Introduced the concept of persistent vCPU at QOM.<br>
&gt;=C2=A0 =C2=A0- Introduced wrapper APIs of present, possible, and persis=
tent.<br>
&gt;=C2=A0 =C2=A0- Change at ACPI hotplug H/W init leg accommodating initia=
lizing is_present and is_enabled states.<br>
&gt;=C2=A0 =C2=A0- Check to avoid unplugging cold-booted vCPUs.<br>
&gt;=C2=A0 =C2=A0- Disabled hotplugging with TCG/HVF/QTEST.<br>
&gt;=C2=A0 =C2=A0- Introduced CPU Topology, {socket, cluster, core, thread}=
-id property.<br>
&gt;=C2=A0 =C2=A0- Extract virt CPU properties as a common virt_vcpu_proper=
ties() function.<br>
&gt; <br>
&gt; Author Salil Mehta (1):<br>
&gt;=C2=A0 target/arm/kvm,tcg: Handle SMCCC hypercall exits in VMM during<b=
r>
&gt;=C2=A0 =C2=A0 PSCI_CPU_{ON,OFF}<br>
&gt; <br>
&gt; Jean-Philippe Brucker (2):<br>
&gt;=C2=A0 hw/acpi: Make _MAT method optional<br>
&gt;=C2=A0 target/arm/kvm: Write vCPU&#39;s state back to KVM on cold-reset=
<br>
&gt; <br>
&gt; Miguel Luis (1):<br>
&gt;=C2=A0 tcg/mttcg: Introduce MTTCG thread unregistration leg<br>
&gt; <br>
&gt; Salil Mehta (26):<br>
&gt;=C2=A0 arm/virt,target/arm: Add new ARMCPU {socket,cluster,core,thread}=
-id<br>
&gt;=C2=A0 =C2=A0 property<br>
&gt;=C2=A0 hw/arm/virt: Disable vCPU hotplug for *unsupported* Accel or GIC=
 Type<br>
&gt;=C2=A0 hw/arm/virt: Move setting of common vCPU properties in a functio=
n<br>
&gt;=C2=A0 arm/virt,target/arm: Machine init time change common to vCPU<br>
&gt;=C2=A0 =C2=A0 {cold|hot}-plug<br>
&gt;=C2=A0 arm/virt,kvm: Pre-create KVM vCPUs for all unplugged QOM vCPUs<b=
r>
&gt;=C2=A0 =C2=A0 @machine init<br>
&gt;=C2=A0 arm/virt,gicv3: Changes to pre-size GIC with possible vCPUs @mac=
hine<br>
&gt;=C2=A0 =C2=A0 init<br>
&gt;=C2=A0 arm/virt,gicv3: Introduce GICv3 CPU Interface *accessibility* fl=
ag and<br>
&gt;=C2=A0 =C2=A0 checks<br>
&gt;=C2=A0 hw/intc/arm-gicv3*: Changes required to (re)init the GICv3 vCPU<=
br>
&gt;=C2=A0 =C2=A0 Interface<br>
&gt;=C2=A0 arm/acpi: Enable ACPI support for vCPU hotplug<br>
&gt;=C2=A0 arm/virt: Enhance GED framework to handle vCPU hotplug events<br=
>
&gt;=C2=A0 arm/virt: Init PMU at host for all possible vCPUs<br>
&gt;=C2=A0 arm/virt: Release objects for *disabled* possible vCPUs after in=
it<br>
&gt;=C2=A0 arm/virt/acpi: Update ACPI DSDT Tbl to include CPUs AML with hot=
plug<br>
&gt;=C2=A0 =C2=A0 support<br>
&gt;=C2=A0 hw/arm/acpi: MADT Tbl change to size the guest with possible vCP=
Us<br>
&gt;=C2=A0 target/arm: Force ARM vCPU *present* status ACPI *persistent*<br=
>
&gt;=C2=A0 arm/virt: Add/update basic hot-(un)plug framework<br>
&gt;=C2=A0 arm/virt: Changes to (un)wire GICC&lt;-&gt;vCPU IRQs during hot-=
(un)plug<br>
&gt;=C2=A0 hw/arm,gicv3: Changes to notify GICv3 CPU state with vCPU hot-(u=
n)plug<br>
&gt;=C2=A0 =C2=A0 event<br>
&gt;=C2=A0 hw/arm: Changes required for reset and to support next boot<br>
&gt;=C2=A0 arm/virt: Update the guest(via GED) about vCPU hot-(un)plug even=
ts<br>
&gt;=C2=A0 target/arm/cpu: Check if hotplugged ARM vCPU&#39;s FEAT match ex=
isting<br>
&gt;=C2=A0 tcg: Update tcg_register_thread() leg to handle region alloc for=
<br>
&gt;=C2=A0 =C2=A0 hotplugged vCPU<br>
&gt;=C2=A0 target/arm: Add support to *unrealize* ARMCPU during vCPU Hot-un=
plug<br>
&gt;=C2=A0 hw/intc/arm_gicv3_common: Add GICv3CPUState &#39;accessible&#39;=
 flag<br>
&gt;=C2=A0 =C2=A0 migration handling<br>
&gt;=C2=A0 hw/intc/arm_gicv3_kvm: Pause all vCPU to ensure locking in KVM o=
f<br>
&gt;=C2=A0 =C2=A0 resetting vCPU<br>
&gt;=C2=A0 hw/arm/virt: Expose cold-booted vCPUs as MADT GICC *Enabled*<br>
&gt; <br>
&gt; accel/tcg/tcg-accel-ops-mttcg.c=C2=A0 =C2=A0 |=C2=A0 =C2=A03 +-<br>
&gt; accel/tcg/tcg-accel-ops-rr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02=
 +-<br>
&gt; cpu-common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 11 +<br>
&gt; hw/acpi/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A09 +-<br>
&gt; hw/arm/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt; hw/arm/boot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt; hw/arm/virt-acpi-build.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 69 ++-<br>
&gt; hw/arm/virt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | 840 +++++++++++++++++++++++------<br>
&gt; hw/core/gpio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt; hw/intc/arm_gicv3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A01 +<br>
&gt; hw/intc/arm_gicv3_common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 99=
 +++-<br>
&gt; hw/intc/arm_gicv3_cpuif.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 253 ++++=
-----<br>
&gt; hw/intc/arm_gicv3_cpuif_common.c=C2=A0 =C2=A0|=C2=A0 13 +<br>
&gt; hw/intc/arm_gicv3_kvm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 40 +-<br>
&gt; hw/intc/gicv3_internal.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A01 +<br>
&gt; include/hw/acpi/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
|=C2=A0 19 +<br>
&gt; include/hw/arm/boot.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
|=C2=A0 =C2=A02 +<br>
&gt; include/hw/arm/virt.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
|=C2=A0 64 ++-<br>
&gt; include/hw/core/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
|=C2=A0 20 +<br>
&gt; include/hw/intc/arm_gicv3_common.h |=C2=A0 61 +++<br>
&gt; include/hw/qdev-core.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 =C2=A02 +<br>
&gt; include/tcg/startup.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
|=C2=A0 13 +<br>
&gt; include/tcg/tcg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt; system/physmem.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A08 +-<br>
&gt; target/arm/arm-powerctl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 20=
 +-<br>
&gt; target/arm/cpu-qom.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 18 +-<br>
&gt; target/arm/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 178 +++++-<br>
&gt; target/arm/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 18 +<br>
&gt; target/arm/cpu64.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 18 +<br>
&gt; target/arm/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A06 +<br>
&gt; target/arm/helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 27 +-<br>
&gt; target/arm/internals.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 14 +-<br>
&gt; target/arm/kvm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 146 ++++-<br>
&gt; target/arm/kvm_arm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 24 +<br>
&gt; target/arm/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 =C2=A01 +<br>
&gt; target/arm/{tcg =3D&gt; }/psci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A08 +<br>
&gt; target/arm/tcg/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A04 -<br>
&gt; tcg/region.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 14 +<br>
&gt; tcg/tcg.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 46 +-<br>
&gt; 39 files changed, 1714 insertions(+), 364 deletions(-)<br>
&gt; rename target/arm/{tcg =3D&gt; }/psci.c (97%)<br>
&gt; <br>
&gt; -- <br>
&gt; 2.34.1<br>
&gt; <br>
<br>
</blockquote></div></div>

--0000000000000d9b4e062502ca71--

