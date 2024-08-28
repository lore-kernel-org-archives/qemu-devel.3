Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72437C7112F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 20:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjPOj-00057u-Ur; Wed, 28 Aug 2024 16:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sjPOi-00055k-Bh
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 16:36:08 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sjPOd-0006wl-Te
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 16:36:08 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2d3da6d3f22so5530768a91.0
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 13:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724877362; x=1725482162; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s1trmLPRkPfRFs6Wv6T6v28aX4rEb09UT8+D5oshYQw=;
 b=XUHdW/2Kmp/P/jimQbPSCl7z5nGibA/x/ixAUIJtVOEk55L9YSEteheeGKTSHiqCl2
 J5PtvAbRY7C5j/jE9556+ZnTtLw23Ts178gYRJgtsLUgLRxt3xGofJ3eZ3xtutVQ72qN
 UdXwzBIBU3TY9T9Pn8dbTgpf8WGjKp6KAeWlsQMAb7bn3vYQxK9fNji0QyGsmhKz3j/N
 wBj6XHD4mpl1NG+Xf8fzrufBaq1W/q4Pt9+Et/XX3LiBWjrTdNaIxG6Vn2PDa50/4lya
 NS9pauQZ/D4m6ewYTqvkgQW6l9BGkec560asVViPUTAFqd0rfr3s4GGA63LahsUgzxJu
 1M9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724877362; x=1725482162;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s1trmLPRkPfRFs6Wv6T6v28aX4rEb09UT8+D5oshYQw=;
 b=NPrOLkAaE+qNrcEnXqshIL2p0YRByxCiKM1QcAyEIKUCtACpQEfS056tnIW+RZb+tt
 DEvGMS63arsZi91rzGd44GEYEM74ROcbvzdfg0CNDS8vZVmvktiGAwmMl9I87bcbHu5L
 RG+XITczr+9ZF+5G5II3YsOH53d6Qb2+UhXDcXJESuuoIagyG/hj0E6ZltXPycXtyKxW
 kzRljKdVgvJMkkSFzyUbkihE5wk+hWYut+RFG9yadNhzLuQ8TcPhF8VV0kdi83CSES7O
 NgAVkjvoL0/y2Oe3ZwwWcdmOPiqj4GdlCSPDFDzlXaSCEkzq+FGR1BSGW02CzBOOZAas
 4HsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdZ8x0KwlzdPdGJXV+qHFTWRbJ5/mbIQh7yewhr2g4ZZ0hUgXpNkYbi4QRX6Z9BbhKKilKAC0MIHw/@nongnu.org
X-Gm-Message-State: AOJu0YxWfeuDnnXnpF9LPuf5MOJqXvYf1IdX3+Rfa2X7cyiIiNy7GVSx
 5egLW+Il7rXj41t6MsokbNVXL6gWCi7nY9NIDw0ubeOaiiRI35EvYOAJ3WFEkko=
X-Google-Smtp-Source: AGHT+IFn58/lcdS386T9ylDSN6H9WzZ3YFji6dKYQoY69n7CgNYKjy3c8iue0ueclPLFNBty0RQZNw==
X-Received: by 2002:a17:90b:4b01:b0:2d3:ce8d:f7f1 with SMTP id
 98e67ed59e1d1-2d8561c7556mr591178a91.25.1724877361576; 
 Wed, 28 Aug 2024 13:36:01 -0700 (PDT)
Received: from ?IPv6:2804:7f0:b400:bb79:4bdf:de43:1f6c:1151?
 ([2804:7f0:b400:bb79:4bdf:de43:1f6c:1151])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d8445e80absm2373471a91.13.2024.08.28.13.35.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Aug 2024 13:36:00 -0700 (PDT)
Subject: Re: [PATCH RFC V3 00/29] Support of Virtual CPU Hotplug for ARMv8 Arch
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com, will@kernel.org,
 ardb@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 gshan@redhat.com, rafael@kernel.org, borntraeger@linux.ibm.com,
 alex.bennee@linaro.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 karl.heubaum@oracle.com, miguel.luis@oracle.com, salil.mehta@opnsrc.net,
 zhukeqian1@huawei.com, wangxiongfeng2@huawei.com, wangyanan55@huawei.com,
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 shahuang@redhat.com, zhao1.liu@intel.com, linuxarm@huawei.com
References: <20240613233639.202896-1-salil.mehta@huawei.com>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <9227bac3-aecd-fbde-3691-5e949373fad0@linaro.org>
Date: Wed, 28 Aug 2024 17:35:50 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20240613233639.202896-1-salil.mehta@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.084,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 URI_DOTEDU=1 autolearn=unavailable autolearn_force=no
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

Hi Salil,

On 6/13/24 8:36 PM, Salil Mehta via wrote:
> PROLOGUE
> ========
> 
> To assist in review and set the right expectations from this RFC, please first
> read the sections *APPENDED AT THE END* of this cover letter:
> 
> 1. Important *DISCLAIMER* [Section (X)]
> 2. Work presented at KVMForum Conference (slides available) [Section (V)F]
> 3. Organization of patches [Section (XI)]
> 4. References [Section (XII)]
> 5. Detailed TODO list of leftover work or work-in-progress [Section (IX)]
> 
> There has been interest shown by other organizations in adapting this series
> for their architecture. Hence, RFC V2 [21] has been split into architecture
> *agnostic* [22] and *specific* patch sets.
> 
> This is an ARM architecture-specific patch set carved out of RFC V2. Please
> check section (XI)B for details of architecture agnostic patches.
> 
> SECTIONS [I - XIII] are as follows:
> 
> (I) Key Changes [details in last section (XIV)]
> ==============================================
> 
> RFC V2 -> RFC V3
> 
> 1. Split into Architecture *agnostic* (V13) [22] and *specific* (RFC V3) patch sets.
> 2. Addressed comments by Gavin Shan (RedHat), Shaoqin Huang (RedHat), Philippe Mathieu-Daudé (Linaro),
>     Jonathan Cameron (Huawei), Zhao Liu (Intel).
> 
> RFC V1 -> RFC V2
> 
> RFC V1: https://lore.kernel.org/qemu-devel/20200613213629.21984-1-salil.mehta@huawei.com/
> 
> 1. ACPI MADT Table GIC CPU Interface can now be presented [6] as ACPI
>     *online-capable* or *enabled* to the Guest OS at boot time. This means
>     associated CPUs can have ACPI _STA as *enabled* or *disabled* even after boot.
>     See UEFI ACPI 6.5 Spec, Section 05, Table 5.37 GICC CPU Interface Flags[20].
> 2. SMCC/HVC Hypercall exit handling in userspace/Qemu for PSCI CPU_{ON,OFF}
>     request. This is required to {dis}allow online'ing a vCPU.
> 3. Always presenting unplugged vCPUs in CPUs ACPI AML code as ACPI _STA.PRESENT
>     to the Guest OS. Toggling ACPI _STA.Enabled to give an effect of the
>     hot{un}plug.
> 4. Live Migration works (some issues are still there).
> 5. TCG/HVF/qtest does not support Hotplug and falls back to default.
> 6. Code for TCG support exists in this release (it is a work-in-progress).
> 7. ACPI _OSC method can now be used by OSPM to negotiate Qemu VM platform
>     hotplug capability (_OSC Query support still pending).
> 8. Misc. Bug fixes.
> 
> (II) Summary
> ============
> 
> This patch set introduces virtual CPU hotplug support for the ARMv8 architecture
> in QEMU. The idea is to be able to hotplug and hot-unplug vCPUs while the guest VM
> is running, without requiring a reboot. This does *not* make any assumptions about
> the physical CPU hotplug availability within the host system but rather tries to
> solve the problem at the virtualizer/QEMU layer. It introduces ACPI CPU hotplug hooks
> and event handling to interface with the guest kernel, and code to initialize, plug,
> and unplug CPUs. No changes are required within the host kernel/KVM except the
> support of hypercall exit handling in the user-space/Qemu, which has recently
> been added to the kernel. Corresponding guest kernel changes have been
> posted on the mailing list [3] [4] by James Morse.
> 
> (III) Motivation
> ================
> 
> This allows scaling the guest VM compute capacity on-demand, which would be
> useful for the following example scenarios:
> 
> 1. Vertical Pod Autoscaling [9][10] in the cloud: Part of the orchestration
>     framework that could adjust resource requests (CPU and Mem requests) for
>     the containers in a pod, based on usage.
> 2. Pay-as-you-grow Business Model: Infrastructure providers could allocate and
>     restrict the total number of compute resources available to the guest VM
>     according to the SLA (Service Level Agreement). VM owners could request more
>     compute to be hot-plugged for some cost.
> 
> For example, Kata Container VM starts with a minimum amount of resources (i.e.,
> hotplug everything approach). Why?
> 
> 1. Allowing faster *boot time* and
> 2. Reduction in *memory footprint*
> 
> Kata Container VM can boot with just 1 vCPU, and then later more vCPUs can be
> hot-plugged as needed.
> 
> (IV) Terminology
> ================
> 
> (*) Possible CPUs: Total vCPUs that could ever exist in the VM. This includes
>                     any cold-booted CPUs plus any CPUs that could be later
>                     hot-plugged.
>                     - Qemu parameter (-smp maxcpus=N)
> (*) Present CPUs:  Possible CPUs that are ACPI 'present'. These might or might
>                     not be ACPI 'enabled'.
>                     - Present vCPUs = Possible vCPUs (Always on ARM Arch)
> (*) Enabled CPUs:  Possible CPUs that are ACPI 'present' and 'enabled' and can
>                     now be ‘onlined’ (PSCI) for use by the Guest Kernel. All cold-
>                     booted vCPUs are ACPI 'enabled' at boot. Later, using
>                     device_add, more vCPUs can be hotplugged and made ACPI
>                     'enabled'.
>                     - Qemu parameter (-smp cpus=N). Can be used to specify some
> 	           cold-booted vCPUs during VM init. Some can be added using the
> 	           '-device' option.
> 
> (V) Constraints Due to ARMv8 CPU Architecture [+] Other Impediments
> ===================================================================
> 
> A. Physical Limitation to Support CPU Hotplug: (Architectural Constraint)
>     1. ARMv8 CPU architecture does not support the concept of the physical CPU
>        hotplug.
>        a. There are many per-CPU components like PMU, SVE, MTE, Arch timers, etc.,
>           whose behavior needs to be clearly defined when the CPU is hot(un)plugged.
>           There is no specification for this.
> 
>     2. Other ARM components like GIC, etc., have not been designed to realize
>        physical CPU hotplug capability as of now. For example,
>        a. Every physical CPU has a unique GICC (GIC CPU Interface) by construct.
>           Architecture does not specify what CPU hot(un)plug would mean in
>           context to any of these.
>        b. CPUs/GICC are physically connected to unique GICR (GIC Redistributor).
>           GIC Redistributors are always part of the always-on power domain. Hence,
>           they cannot be powered off as per specification.
> 
> B. Impediments in Firmware/ACPI (Architectural Constraint)
> 
>     1. Firmware has to expose GICC, GICR, and other per-CPU features like PMU,
>        SVE, MTE, Arch Timers, etc., to the OS. Due to the architectural constraint
>        stated in section A1(a), all interrupt controller structures of
>        MADT describing GIC CPU Interfaces and the GIC Redistributors MUST be
>        presented by firmware to the OSPM during boot time.
>     2. Architectures that support CPU hotplug can evaluate the ACPI _MAT method to
>        get this kind of information from the firmware even after boot, and the
>        OSPM has the capability to process these. ARM kernel uses information in MADT
>        interrupt controller structures to identify the number of present CPUs during
>        boot and hence does not allow to change these after boot. The number of
>        present CPUs cannot be changed. It is an architectural constraint!
> 
> C. Impediments in KVM to Support Virtual CPU Hotplug (Architectural Constraint)
> 
>     1. KVM VGIC:
>        a. Sizing of various VGIC resources like memory regions, etc., related to
>           the redistributor happens only once and is fixed at the VM init time
>           and cannot be changed later after initialization has happened.
>           KVM statically configures these resources based on the number of vCPUs
>           and the number/size of redistributor ranges.
>        b. Association between vCPU and its VGIC redistributor is fixed at the
>           VM init time within the KVM, i.e., when redistributor iodevs gets
>           registered. VGIC does not allow to setup/change this association
>           after VM initialization has happened. Physically, every CPU/GICC is
>           uniquely connected with its redistributor, and there is no
>           architectural way to set this up.
>     2. KVM vCPUs:
>        a. Lack of specification means destruction of KVM vCPUs does not exist as
>           there is no reference to tell what to do with other per-vCPU
>           components like redistributors, arch timer, etc.
>        b. In fact, KVM does not implement the destruction of vCPUs for any
>           architecture. This is independent of whether the architecture
>           actually supports CPU Hotplug feature. For example, even for x86 KVM
>           does not implement the destruction of vCPUs.
> 
> D. Impediments in Qemu to Support Virtual CPU Hotplug (KVM Constraints->Arch)
> 
>     1. Qemu CPU Objects MUST be created to initialize all the Host KVM vCPUs to
>        overcome the KVM constraint. KVM vCPUs are created and initialized when Qemu
>        CPU Objects are realized. But keeping the QOM CPU objects realized for
>        'yet-to-be-plugged' vCPUs can create problems when these new vCPUs shall
>        be plugged using device_add and a new QOM CPU object shall be created.
>     2. GICV3State and GICV3CPUState objects MUST be sized over *possible vCPUs*
>        during VM init time while QOM GICV3 Object is realized. This is because
>        KVM VGIC can only be initialized once during init time. But every
>        GICV3CPUState has an associated QOM CPU Object. Later might correspond to
>        vCPU which are 'yet-to-be-plugged' (unplugged at init).
>     3. How should new QOM CPU objects be connected back to the GICV3CPUState
>        objects and disconnected from it in case the CPU is being hot(un)plugged?
>     4. How should 'unplugged' or 'yet-to-be-plugged' vCPUs be represented in the
>        QOM for which KVM vCPU already exists? For example, whether to keep,
>         a. No QOM CPU objects Or
>         b. Unrealized CPU Objects
>     5. How should vCPU state be exposed via ACPI to the Guest? Especially for
>        the unplugged/yet-to-be-plugged vCPUs whose CPU objects might not exist
>        within the QOM but the Guest always expects all possible vCPUs to be
>        identified as ACPI *present* during boot.
>     6. How should Qemu expose GIC CPU interfaces for the unplugged or
>        yet-to-be-plugged vCPUs using ACPI MADT Table to the Guest?
> 
> E. Summary of Approach ([+] Workarounds to problems in sections A, B, C & D)
> 
>     1. At VM Init, pre-create all the possible vCPUs in the Host KVM i.e., even
>        for the vCPUs which are yet-to-be-plugged in Qemu but keep them in the
>        powered-off state.
>     2. After the KVM vCPUs have been initialized in the Host, the KVM vCPU
>        objects corresponding to the unplugged/yet-to-be-plugged vCPUs are parked
>        at the existing per-VM "kvm_parked_vcpus" list in Qemu. (similar to x86)
>     3. GICV3State and GICV3CPUState objects are sized over possible vCPUs during
>        VM init time i.e., when Qemu GIC is realized. This, in turn, sizes KVM VGIC
>        resources like memory regions, etc., related to the redistributors with the
>        number of possible KVM vCPUs. This never changes after VM has initialized.
>     4. Qemu CPU objects corresponding to unplugged/yet-to-be-plugged vCPUs are
>        released post Host KVM CPU and GIC/VGIC initialization.
>     5. Build ACPI MADT Table with the following updates:
>        a. Number of GIC CPU interface entries (=possible vCPUs)
>        b. Present Boot vCPU as MADT.GICC.Enabled=1 (Not hot[un]pluggable)
>        c. Present hot(un)pluggable vCPUs as MADT.GICC.online-capable=1
>           - MADT.GICC.Enabled=0 (Mutually exclusive) [6][7]
> 	 - vCPU can be ACPI enabled+onlined after Guest boots (Firmware Policy)
> 	 - Some issues with above (details in later sections)
>     6. Expose below ACPI Status to Guest kernel:
>        a. Always _STA.Present=1 (all possible vCPUs)
>        b. _STA.Enabled=1 (plugged vCPUs)
>        c. _STA.Enabled=0 (unplugged vCPUs)
>     7. vCPU hotplug *realizes* new QOM CPU object. The following happens:
>        a. Realizes, initializes QOM CPU Object & spawns Qemu vCPU thread.
>        b. Unparks the existing KVM vCPU ("kvm_parked_vcpus" list).
>           - Attaches to QOM CPU object.
>        c. Reinitializes KVM vCPU in the Host.
>           - Resets the core and sys regs, sets defaults, etc.
>        d. Runs KVM vCPU (created with "start-powered-off").
> 	 - vCPU thread sleeps (waits for vCPU reset via PSCI).
>        e. Updates Qemu GIC.
>           - Wires back IRQs related to this vCPU.
>           - GICV3CPUState association with QOM CPU Object.
>        f. Updates [6] ACPI _STA.Enabled=1.
>        g. Notifies Guest about the new vCPU (via ACPI GED interface).
> 	 - Guest checks _STA.Enabled=1.
> 	 - Guest adds processor (registers CPU with LDM) [3].
>        h. Plugs the QOM CPU object in the slot.
>           - slot-number = cpu-index {socket, cluster, core, thread}.
>        i. Guest online's vCPU (CPU_ON PSCI call over HVC/SMC).
>           - KVM exits HVC/SMC Hypercall [5] to Qemu (Policy Check).
>           - Qemu powers-on KVM vCPU in the Host.
>     8. vCPU hot-unplug *unrealizes* QOM CPU Object. The following happens:
>        a. Notifies Guest (via ACPI GED interface) vCPU hot-unplug event.
>           - Guest offline's vCPU (CPU_OFF PSCI call over HVC/SMC).
>        b. KVM exits HVC/SMC Hypercall [5] to Qemu (Policy Check).
>           - Qemu powers-off the KVM vCPU in the Host.
>        c. Guest signals *Eject* vCPU to Qemu.
>        d. Qemu updates [6] ACPI _STA.Enabled=0.
>        e. Updates GIC.
>           - Un-wires IRQs related to this vCPU.
>           - GICV3CPUState association with new QOM CPU Object is updated.
>        f. Unplugs the vCPU.
> 	 - Removes from slot.
>           - Parks KVM vCPU ("kvm_parked_vcpus" list).
>           - Unrealizes QOM CPU Object & joins back Qemu vCPU thread.
> 	 - Destroys QOM CPU object.
>        g. Guest checks ACPI _STA.Enabled=0.
>           - Removes processor (unregisters CPU with LDM) [3].
> 
> F. Work Presented at KVM Forum Conferences:
> ==========================================
> 
> Details of the above work have been presented at KVMForum2020 and KVMForum2023
> conferences. Slides & video are available at the links below:
> a. KVMForum 2023
>     - Challenges Revisited in Supporting Virt CPU Hotplug on architectures that don't Support CPU Hotplug (like ARM64).
>       https://kvm-forum.qemu.org/2023/KVM-forum-cpu-hotplug_7OJ1YyJ.pdf
>       https://kvm-forum.qemu.org/2023/Challenges_Revisited_in_Supporting_Virt_CPU_Hotplug_-__ii0iNb3.pdf
>       https://www.youtube.com/watch?v=hyrw4j2D6I0&t=23970s
>       https://kvm-forum.qemu.org/2023/talk/9SMPDQ/
> b. KVMForum 2020
>     - Challenges in Supporting Virtual CPU Hotplug on SoC Based Systems (like ARM64) - Salil Mehta, Huawei.
>       https://sched.co/eE4m
> 
> (VI) Commands Used
> ==================
> 
> A. Qemu launch commands to init the machine:
> 
>      $ qemu-system-aarch64 --enable-kvm -machine virt,gic-version=3 \
>        -cpu host -smp cpus=4,maxcpus=6 \
>        -m 300M \
>        -kernel Image \
>        -initrd rootfs.cpio.gz \
>        -append "console=ttyAMA0 root=/dev/ram rdinit=/init maxcpus=2 acpi=force" \
>        -nographic \
>        -bios QEMU_EFI.fd \
> 
> B. Hot-(un)plug related commands:
> 
>    # Hotplug a host vCPU (accel=kvm):
>      $ device_add host-arm-cpu,id=core4,core-id=4
> 
>    # Hotplug a vCPU (accel=tcg):
>      $ device_add cortex-a57-arm-cpu,id=core4,core-id=4

Since support for hotplug is disabled on TCG, remove
these two lines in v4 cover letter?


Cheers,
Gustavo

>    # Delete the vCPU:
>      $ device_del core4
> 
> Sample output on guest after boot:
> 
>      $ cat /sys/devices/system/cpu/possible
>      0-5
>      $ cat /sys/devices/system/cpu/present
>      0-5
>      $ cat /sys/devices/system/cpu/enabled
>      0-3
>      $ cat /sys/devices/system/cpu/online
>      0-1
>      $ cat /sys/devices/system/cpu/offline
>      2-5
> 
> Sample output on guest after hotplug of vCPU=4:
> 
>      $ cat /sys/devices/system/cpu/possible
>      0-5
>      $ cat /sys/devices/system/cpu/present
>      0-5
>      $ cat /sys/devices/system/cpu/enabled
>      0-4
>      $ cat /sys/devices/system/cpu/online
>      0-1,4
>      $ cat /sys/devices/system/cpu/offline
>      2-3,5
> 
>      Note: vCPU=4 was explicitly 'onlined' after hot-plug
>      $ echo 1 > /sys/devices/system/cpu/cpu4/online
> 
> (VII) Latest Repository
> =======================
> 
> (*) Latest Qemu RFC V3 (Architecture Specific) patch set:
>      https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-v3
> (*) Latest Qemu V13 (Architecture Agnostic) patch set:
>      https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-v3.arch.agnostic.v13
> (*) QEMU changes for vCPU hotplug can be cloned from below site:
>      https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-v2
> (*) Guest Kernel changes (by James Morse, ARM) are available here:
>      https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git virtual_cpu_hotplug/rfc/v2
> (*) Leftover patches of the kernel are available here:
>      https://lore.kernel.org/lkml/20240529133446.28446-1-Jonathan.Cameron@huawei.com/
>      https://github.com/salil-mehta/linux/commits/virtual_cpu_hotplug/rfc/v6.jic/ (not latest)
> 
> (VIII) KNOWN ISSUES
> ===================
> 
> 1. Migration has been lightly tested but has been found working.
> 2. TCG is broken.
> 3. HVF and qtest are not supported yet.
> 4. ACPI MADT Table flags [7] MADT.GICC.Enabled and MADT.GICC.online-capable are
>     mutually exclusive, i.e., as per the change [6], a vCPU cannot be both
>     GICC.Enabled and GICC.online-capable. This means:
>        [ Link: https://bugzilla.tianocore.org/show_bug.cgi?id=3706 ]
>     a. If we have to support hot-unplug of the cold-booted vCPUs, then these MUST
>        be specified as GICC.online-capable in the MADT Table during boot by the
>        firmware/Qemu. But this requirement conflicts with the requirement to
>        support new Qemu changes with legacy OS that don't understand
>        MADT.GICC.online-capable Bit. Legacy OS during boot time will ignore this
>        bit, and hence these vCPUs will not appear on such OS. This is unexpected
>        behavior.
>     b. In case we decide to specify vCPUs as MADT.GICC.Enabled and try to unplug
>        these cold-booted vCPUs from OS (which in actuality should be blocked by
>        returning error at Qemu), then features like 'kexec' will break.
>     c. As I understand, removal of the cold-booted vCPUs is a required feature
>        and x86 world allows it.
>     d. Hence, either we need a specification change to make the MADT.GICC.Enabled
>        and MADT.GICC.online-capable Bits NOT mutually exclusive or NOT support
>        the removal of cold-booted vCPUs. In the latter case, a check can be introduced
>        to bar the users from unplugging vCPUs, which were cold-booted, using QMP
>        commands. (Needs discussion!)
>        Please check the patch part of this patch set:
>        [hw/arm/virt: Expose cold-booted CPUs as MADT GICC Enabled].
>     
>        NOTE: This is definitely not a blocker!
> 5. Code related to the notification to GICV3 about the hot(un)plug of a vCPU event
>     might need further discussion.
> 
> 
> (IX) THINGS TO DO
> =================
> 
> 1. Fix issues related to TCG/Emulation support. (Not a blocker)
> 2. Comprehensive Testing is in progress. (Positive feedback from Oracle & Ampere)
> 3. Qemu Documentation (.rst) needs to be updated.
> 4. Fix qtest, HVF Support (Future).
> 5. Update the design issue related to ACPI MADT.GICC flags discussed in known
>     issues. This might require UEFI ACPI specification change (Not a blocker).
> 6. Add ACPI _OSC 'Query' support. Only part of _OSC support exists now. (Not a blocker).
> 
> The above is *not* a complete list. Will update later!
> 
> Best regards,
> Salil.
> 
> (X) DISCLAIMER
> ==============
> 
> This work is an attempt to present a proof-of-concept of the ARM64 vCPU hotplug
> implementation to the community. This is *not* production-level code and might
> have bugs. Comprehensive testing is being done on HiSilicon Kunpeng920 SoC,
> Oracle, and Ampere servers. We are nearing stable code and a non-RFC
> version shall be floated soon.
> 
> This work is *mostly* in the lines of the discussions that have happened in the
> previous years [see refs below] across different channels like the mailing list,
> Linaro Open Discussions platform, and various conferences like KVMForum, etc. This
> RFC is being used as a way to verify the idea mentioned in this cover letter and
> to get community views. Once this has been agreed upon, a formal patch shall be
> posted to the mailing list for review.
> 
> [The concept being presented has been found to work!]
> 
> (XI) ORGANIZATION OF PATCHES
> ============================
>   
> A. Architecture *specific* patches:
> 
>     [Patch 1-8, 17, 27, 29] logic required during machine init.
>      (*) Some validation checks.
>      (*) Introduces core-id property and some util functions required later.
>      (*) Logic to pre-create vCPUs.
>      (*) GIC initialization pre-sized with possible vCPUs.
>      (*) Some refactoring to have common hot and cold plug logic together.
>      (*) Release of disabled QOM CPU objects in post_cpu_init().
>      (*) Support of ACPI _OSC method to negotiate platform hotplug capabilities.
>     [Patch 9-16] logic related to ACPI at machine init time.
>      (*) Changes required to Enable ACPI for CPU hotplug.
>      (*) Initialization of ACPI GED framework to cater to CPU Hotplug Events.
>      (*) ACPI MADT/MAT changes.
>     [Patch 18-26] logic required during vCPU hot-(un)plug.
>      (*) Basic framework changes to support vCPU hot-(un)plug.
>      (*) ACPI GED changes for hot-(un)plug hooks.
>      (*) Wire-unwire the IRQs.
>      (*) GIC notification logic.
>      (*) ARMCPU unrealize logic.
>      (*) Handling of SMCC Hypercall Exits by KVM to Qemu.
>     
> B. Architecture *agnostic* patches:
> 
>     [PATCH V13 0/8] Add architecture agnostic code to support vCPU Hotplug.
>     https://lore.kernel.org/qemu-devel/20240607115649.214622-1-salil.mehta@huawei.com/T/#md0887eb07976bc76606a8204614ccc7d9a01c1f7
>      (*) Refactors vCPU create, Parking, unparking logic of vCPUs, and addition of traces.
>      (*) Build ACPI AML related to CPU control dev.
>      (*) Changes related to the destruction of CPU Address Space.
>      (*) Changes related to the uninitialization of GDB Stub.
>      (*) Updating of Docs.
> 
> (XII) REFERENCES
> ================
> 
> [1] https://lore.kernel.org/qemu-devel/20200613213629.21984-1-salil.mehta@huawei.com/
> [2] https://lore.kernel.org/linux-arm-kernel/20200625133757.22332-1-salil.mehta@huawei.com/
> [3] https://lore.kernel.org/lkml/20230203135043.409192-1-james.morse@arm.com/
> [4] https://lore.kernel.org/all/20230913163823.7880-1-james.morse@arm.com/
> [5] https://lore.kernel.org/all/20230404154050.2270077-1-oliver.upton@linux.dev/
> [6] https://bugzilla.tianocore.org/show_bug.cgi?id=3706
> [7] https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#gic-cpu-interface-gicc-structure
> [8] https://bugzilla.tianocore.org/show_bug.cgi?id=4481#c5
> [9] https://cloud.google.com/kubernetes-engine/docs/concepts/verticalpodautoscaler
> [10] https://docs.aws.amazon.com/eks/latest/userguide/vertical-pod-autoscaler.html
> [11] https://lkml.org/lkml/2019/7/10/235
> [12] https://lists.cs.columbia.edu/pipermail/kvmarm/2018-July/032316.html
> [13] https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg06517.html
> [14] https://op-lists.linaro.org/archives/list/linaro-open-discussions@op-lists.linaro.org/thread/7CGL6JTACPUZEYQC34CZ2ZBWJGSR74WE/
> [15] http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg01168.html
> [16] https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00131.html
> [17] https://op-lists.linaro.org/archives/list/linaro-open-discussions@op-lists.linaro.org/message/X74JS6P2N4AUWHHATJJVVFDI2EMDZJ74/
> [18] https://lore.kernel.org/lkml/20210608154805.216869-1-jean-philippe@linaro.org/
> [19] https://lore.kernel.org/all/20230913163823.7880-1-james.morse@arm.com/
> [20] https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#gicc-cpu-interface-flags
> [21] https://lore.kernel.org/qemu-devel/20230926100436.28284-1-salil.mehta@huawei.com/
> [22] https://lore.kernel.org/qemu-devel/20240607115649.214622-1-salil.mehta@huawei.com/T/#md0887eb07976bc76606a8204614ccc7d9a01c1f7
> 
> (XIII) ACKNOWLEDGEMENTS
> =======================
> 
> I would like to take this opportunity to thank below people for various
> discussions with me over different channels during the development:
> 
> Marc Zyngier (Google)               Catalin Marinas (ARM),
> James Morse(ARM),                   Will Deacon (Google),
> Jean-Phillipe Brucker (Linaro),     Sudeep Holla (ARM),
> Lorenzo Pieralisi (Linaro),         Gavin Shan (Redhat),
> Jonathan Cameron (Huawei),          Darren Hart (Ampere),
> Igor Mamedov (Redhat),              Ilkka Koskinen (Ampere),
> Andrew Jones (Redhat),              Karl Heubaum (Oracle),
> Keqian Zhu (Huawei),                Miguel Luis (Oracle),
> Xiongfeng Wang (Huawei),            Vishnu Pajjuri (Ampere),
> Shameerali Kolothum (Huawei)        Russell King (Oracle)
> Xuwei/Joy (Huawei),                 Peter Maydel (Linaro)
> Zengtao/Prime (Huawei),             And all those whom I have missed!
> 
> Many thanks to the following people for their current or past contributions:
> 
> 1. James Morse (ARM)
>     (Current Kernel part of vCPU Hotplug Support on AARCH64)
> 2. Jean-Philippe Brucker (Linaro)
>     (Prototyped one of the earlier PSCI-based POC [17][18] based on RFC V1)
> 3. Keqian Zhu (Huawei)
>     (Co-developed Qemu prototype)
> 4. Xiongfeng Wang (Huawei)
>     (Co-developed an earlier kernel prototype with me)
> 5. Vishnu Pajjuri (Ampere)
>     (Verification on Ampere ARM64 Platforms + fixes)
> 6. Miguel Luis (Oracle)
>     (Verification on Oracle ARM64 Platforms + fixes)
> 7. Russell King (Oracle) & Jonathan Cameron (Huawei)
>     (Helping in upstreaming James Morse's Kernel patches).
> 
> (XIV) Change Log:
> =================
> 
> RFC V2 -> RFC V3:
> -----------------
> 1. Miscellaneous:
>     - Split the RFC V2 into arch-agnostic and arch-specific patch sets.
> 2. Addressed Gavin Shan's (RedHat) comments:
>     - Made CPU property accessors inline.
>       https://lore.kernel.org/qemu-devel/6cd28639-2cfa-f233-c6d9-d5d2ec5b1c58@redhat.com/
>     - Collected Reviewed-bys [PATCH RFC V2 4/37, 14/37, 22/37].
>     - Dropped the patch as it was not required after init logic was refactored.
>       https://lore.kernel.org/qemu-devel/4fb2eef9-6742-1eeb-721a-b3db04b1be97@redhat.com/
>     - Fixed the range check for the core during vCPU Plug.
>       https://lore.kernel.org/qemu-devel/1c5fa24c-6bf3-750f-4f22-087e4a9311af@redhat.com/
>     - Added has_hotpluggable_vcpus check to make build_cpus_aml() conditional.
>       https://lore.kernel.org/qemu-devel/832342cb-74bc-58dd-c5d7-6f995baeb0f2@redhat.com/
>     - Fixed the states initialization in cpu_hotplug_hw_init() to accommodate previous refactoring.
>       https://lore.kernel.org/qemu-devel/da5e5609-1883-8650-c7d8-6868c7b74f1c@redhat.com/
>     - Fixed typos.
>       https://lore.kernel.org/qemu-devel/eb1ac571-7844-55e6-15e7-3dd7df21366b@redhat.com/
>     - Removed the unnecessary 'goto fail'.
>       https://lore.kernel.org/qemu-devel/4d8980ac-f402-60d4-fe52-787815af8a7d@redhat.com/#t
>     - Added check for hotpluggable vCPUs in the _OSC method.
>       https://lore.kernel.org/qemu-devel/20231017001326.FUBqQ1PTowF2GxQpnL3kIW0AhmSqbspazwixAHVSi6c@z/
> 3. Addressed Shaoqin Huang's (Intel) comments:
>     - Fixed the compilation break due to the absence of a call to virt_cpu_properties() missing
>       along with its definition.
>       https://lore.kernel.org/qemu-devel/3632ee24-47f7-ae68-8790-26eb2cf9950b@redhat.com/
> 4. Addressed Jonathan Cameron's (Huawei) comments:
>     - Gated the 'disabled vcpu message' for GIC version < 3.
>       https://lore.kernel.org/qemu-devel/20240116155911.00004fe1@Huawei.com/
> 
> RFC V1 -> RFC V2:
> -----------------
> 1. Addressed James Morse's (ARM) requirement as per Linaro Open Discussion:
>     - Exposed all possible vCPUs as always ACPI _STA.present and available during boot time.
>     - Added the _OSC handling as required by James's patches.
>     - Introduction of 'online-capable' bit handling in the flag of MADT GICC.
>     - SMCC Hypercall Exit handling in Qemu.
> 2. Addressed Marc Zyngier's comment:
>     - Fixed the note about GIC CPU Interface in the cover letter.
> 3. Addressed issues raised by Vishnu Pajjuru (Ampere) & Miguel Luis (Oracle) during testing:
>     - Live/Pseudo Migration crashes.
> 4. Others:
>     - Introduced the concept of persistent vCPU at QOM.
>     - Introduced wrapper APIs of present, possible, and persistent.
>     - Change at ACPI hotplug H/W init leg accommodating initializing is_present and is_enabled states.
>     - Check to avoid unplugging cold-booted vCPUs.
>     - Disabled hotplugging with TCG/HVF/QTEST.
>     - Introduced CPU Topology, {socket, cluster, core, thread}-id property.
>     - Extract virt CPU properties as a common virt_vcpu_properties() function.
> 
> Author Salil Mehta (1):
>    target/arm/kvm,tcg: Register/Handle SMCCC hypercall exits to VMM/Qemu
> 
> Jean-Philippe Brucker (2):
>    hw/acpi: Make _MAT method optional
>    target/arm/kvm: Write CPU state back to KVM on reset
> 
> Miguel Luis (1):
>    tcg/mttcg: enable threads to unregister in tcg_ctxs[]
> 
> Salil Mehta (25):
>    arm/virt,target/arm: Add new ARMCPU {socket,cluster,core,thread}-id
>      property
>    cpu-common: Add common CPU utility for possible vCPUs
>    hw/arm/virt: Limit number of possible vCPUs for unsupported Accel or
>      GIC Type
>    hw/arm/virt: Move setting of common CPU properties in a function
>    arm/virt,target/arm: Machine init time change common to vCPU
>      {cold|hot}-plug
>    arm/virt,kvm: Pre-create disabled possible vCPUs @machine init
>    arm/virt,gicv3: Changes to pre-size GIC with possible vcpus @machine
>      init
>    arm/virt: Init PMU at host for all possible vcpus
>    arm/acpi: Enable ACPI support for vcpu hotplug
>    arm/virt: Add cpu hotplug events to GED during creation
>    arm/virt: Create GED dev before *disabled* CPU Objs are destroyed
>    arm/virt/acpi: Build CPUs AML with CPU Hotplug support
>    arm/virt: Make ARM vCPU *present* status ACPI *persistent*
>    hw/acpi: ACPI/AML Changes to reflect the correct _STA.{PRES,ENA} Bits
>      to Guest
>    hw/arm: MADT Tbl change to size the guest with possible vCPUs
>    arm/virt: Release objects for *disabled* possible vCPUs after init
>    arm/virt: Add/update basic hot-(un)plug framework
>    arm/virt: Changes to (un)wire GICC<->vCPU IRQs during hot-(un)plug
>    hw/arm,gicv3: Changes to update GIC with vCPU hot-plug notification
>    hw/intc/arm-gicv3*: Changes required to (re)init the vCPU register
>      info
>    arm/virt: Update the guest(via GED) about CPU hot-(un)plug events
>    hw/arm: Changes required for reset and to support next boot
>    target/arm: Add support of *unrealize* ARMCPU during vCPU Hot-unplug
>    hw/arm: Support hotplug capability check using _OSC method
>    hw/arm/virt: Expose cold-booted CPUs as MADT GICC Enabled
> 
>   accel/tcg/tcg-accel-ops-mttcg.c    |   1 +
>   cpu-common.c                       |  37 ++
>   hw/acpi/cpu.c                      |  62 +-
>   hw/acpi/generic_event_device.c     |  11 +
>   hw/arm/Kconfig                     |   1 +
>   hw/arm/boot.c                      |   2 +-
>   hw/arm/virt-acpi-build.c           | 113 +++-
>   hw/arm/virt.c                      | 877 +++++++++++++++++++++++------
>   hw/core/gpio.c                     |   2 +-
>   hw/intc/arm_gicv3.c                |   1 +
>   hw/intc/arm_gicv3_common.c         |  66 ++-
>   hw/intc/arm_gicv3_cpuif.c          | 269 +++++----
>   hw/intc/arm_gicv3_cpuif_common.c   |   5 +
>   hw/intc/arm_gicv3_kvm.c            |  39 +-
>   hw/intc/gicv3_internal.h           |   2 +
>   include/hw/acpi/cpu.h              |   2 +
>   include/hw/arm/boot.h              |   2 +
>   include/hw/arm/virt.h              |  38 +-
>   include/hw/core/cpu.h              |  78 +++
>   include/hw/intc/arm_gicv3_common.h |  23 +
>   include/hw/qdev-core.h             |   2 +
>   include/tcg/startup.h              |   7 +
>   target/arm/arm-powerctl.c          |  51 +-
>   target/arm/cpu-qom.h               |  18 +-
>   target/arm/cpu.c                   | 112 ++++
>   target/arm/cpu.h                   |  18 +
>   target/arm/cpu64.c                 |  15 +
>   target/arm/gdbstub.c               |   6 +
>   target/arm/helper.c                |  27 +-
>   target/arm/internals.h             |  14 +-
>   target/arm/kvm.c                   | 146 ++++-
>   target/arm/kvm_arm.h               |  25 +
>   target/arm/meson.build             |   1 +
>   target/arm/{tcg => }/psci.c        |   8 +
>   target/arm/tcg/meson.build         |   4 -
>   tcg/tcg.c                          |  24 +
>   36 files changed, 1749 insertions(+), 360 deletions(-)
>   rename target/arm/{tcg => }/psci.c (97%)
> 

