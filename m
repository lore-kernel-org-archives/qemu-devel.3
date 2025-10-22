Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD33CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 10:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBWDi-0006hC-3r; Wed, 22 Oct 2025 06:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vBWDf-0006gn-R1
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 06:37:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vBWDd-0003EB-50
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 06:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761129443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/hEjVPr92PtMdX+gGXcDyd9ZsUcXnGlVPK1AsdsyeM8=;
 b=g/xMtHlzdgG9zFP4DjGeMbiEvItnOtCGcqQ/J6JJ6FBUqz8KqnSp7JLYKn80lBQwnxBUvZ
 qXEzzVExYqXwFg+iFz2T5dkI1kMDdbizbdxCUlqYYAyETuadCRwTTToL2mWMYn59JQIxFt
 AK7QslOXIUA7STvosE7KvXbL29fTgkQ=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-HX4Oc3fNPxiI8sEiny2wLw-1; Wed, 22 Oct 2025 06:37:22 -0400
X-MC-Unique: HX4Oc3fNPxiI8sEiny2wLw-1
X-Mimecast-MFC-AGG-ID: HX4Oc3fNPxiI8sEiny2wLw_1761129441
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-78427dae77eso5702153b3a.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 03:37:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761129430; x=1761734230;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/hEjVPr92PtMdX+gGXcDyd9ZsUcXnGlVPK1AsdsyeM8=;
 b=gWDr00sVz8MC++lQVEXy2ZXEd/tNK5fGEZZp+b4OnlSOjpZF9uJsjAOFsBPMkjPip8
 /wVXzOeifiZUX9387S7uGdU3VnE9Nm685BDfpoIdEjiKbuB24JENr5v/ktWLhP6LIc8i
 k1R+9MZWJYTX3yxojv+pCyIzZvUWx/kIZ3R/XZ7W2O07m3S1egWe/LlwRwXcP6QV/ku6
 /Ec1EmzyUhtzSuCJxNPy1iSjgSWyAveui0LYYKpFznPDPR49FXyyAmbXWsG0KiczmVQl
 2e1WChhgIIwcD7omLZ0LD1vg2q35yfWAjyxTwiAXfI/sOkys+GkZHaar5E0Y+hbn41YE
 lstw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZt717YSF87+oEA12tsA5KF5PZGsWUY/Dd4pPkyDhaWGA6ExbTrZ6eK90PxGHK5qZTCDk1miXElF8g@nongnu.org
X-Gm-Message-State: AOJu0YwzL1Sh5l0m7ATDZjEy8tqIRSPQEIHbJrzx94rQZHGXJokWqulx
 82yd6MTQCEIlTYtdMZc9UQStIwnvwOMu0jN2Aj7KThItFy/TL6Tq7pb18Rj/JYW3ev7i5W5gsAC
 KVPUv1/B0/SA3k3rOAjkfZSmyQG1M35e3DpUEB/IK4x4VxtVMdYToglCU
X-Gm-Gg: ASbGnct030eDC1Y9b4ayUc3v1iokTOmgnkAeJsRmtGdOlcdxzcmU4d8oSfW1J83rnW2
 tFfepwF1nEdIz2w5/rx6KsgX7xlVxcArVqwwPfntLhdVrRekPYz9ZL/56ndsnVS0Hk2EBJ0r5xy
 mE50SZXey/6FAE2lUKUZumanRHTcfE3kPJdLPwFrkPodQf0XV+WcEKheSuKc2Kl5b4uakp1VplI
 AHlyLgzoKuKB/w6YGdK1GleVpISu6eFs7iUrEAeBrsSMAALxx2J5rr+UvlaYSGLa/gTvHDUoS+y
 DzVz0ufAyt9WXYDUM0BV9/521TplVMVLqzVz6NejgT4iC0bcP5JkXdCUZW1JZiLFtAfm8XENapc
 NDonlNAaLfAI/fNdJTb0M7ornpwpmAUKgcfv/P6g=
X-Received: by 2002:a05:6a00:98f:b0:772:4319:e7df with SMTP id
 d2e1a72fcca58-7a220b25d91mr22328332b3a.30.1761129429689; 
 Wed, 22 Oct 2025 03:37:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHCnlHMN5XImgEhaoqXqcUAaKvIYrhq9uSSJBALSRoOcWRhyy3MypEaupwG7lPs/kK/C04Sw==
X-Received: by 2002:a05:6a00:98f:b0:772:4319:e7df with SMTP id
 d2e1a72fcca58-7a220b25d91mr22328297b3a.30.1761129429179; 
 Wed, 22 Oct 2025 03:37:09 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au.
 [175.34.62.5]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a23010e265sm13962493b3a.52.2025.10.22.03.36.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 03:37:08 -0700 (PDT)
Message-ID: <a03ed205-b61a-4bba-9f25-83663b7d8a86@redhat.com>
Date: Wed, 22 Oct 2025 20:36:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC V6 05/24] arm/virt,kvm: Pre-create KVM vCPUs for
 'disabled' QOM vCPUs at machine init
To: salil.mehta@opnsrc.net, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 mst@redhat.com
Cc: salil.mehta@huawei.com, maz@kernel.org, jean-philippe@linaro.org,
 jonathan.cameron@huawei.com, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org, imammedo@redhat.com,
 armbru@redhat.com, andrew.jones@linux.dev, david@redhat.com,
 philmd@linaro.org, eric.auger@redhat.com, will@kernel.org, ardb@kernel.org,
 oliver.upton@linux.dev, pbonzini@redhat.com, rafael@kernel.org,
 borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 gustavo.romero@linaro.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 gankulkarni@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, zhukeqian1@huawei.com, wangxiongfeng2@huawei.com,
 wangyanan55@huawei.com, wangzhou1@hisilicon.com, linuxarm@huawei.com,
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 shahuang@redhat.com, zhao1.liu@intel.com, Keqian Zhu <zhuqian1@huawei.com>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
 <20251001010127.3092631-6-salil.mehta@opnsrc.net>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251001010127.3092631-6-salil.mehta@opnsrc.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/1/25 11:01 AM, salil.mehta@opnsrc.net wrote:
> From: Salil Mehta <salil.mehta@huawei.com>
> 
> ARM CPU architecture does not allow CPUs to be plugged after system has
> initialized. This is a constraint. Hence, the Kernel must know all the CPUs
> being booted during its initialization. This applies to the Guest Kernel as
> well and therefore, the number of KVM vCPU descriptors in the host must be
> fixed at VM initialization time.
> 
> Also, the GIC must know all the CPUs it is connected to during its
> initialization, and this cannot change afterward. This must also be ensured
> during the initialization of the VGIC in KVM. This is necessary because:
> 
> 1. The association between GICR and MPIDR must be fixed at VM initialization
>     time. This is represented by the register
>     `GICR_TYPER(mp_affinity, proc_num)`.
> 2. Memory regions associated with GICR, etc., cannot be changed (added,
>     deleted, or modified) after the VM has been initialized. This is not an
>     ARM architectural constraint but rather invites a difficult and messy
>     change in VGIC data structures.
> 
> To enable a hot-add–like model while preserving these constraints, the virt
> machine may enumerate more CPUs than are enabled at boot using
> `-smp disabledcpus=N`. Such CPUs are present but start offline (i.e.,
> administratively disabled at init). The topology remains fixed at VM
> creation time; only the online/offline status may change later.
> 
> Administratively disabled vCPUs are not realized in QOM until first enabled,
> avoiding creation of unnecessary vCPU threads at boot. On large systems, this
> reduces startup time proportionally to the number of disabled vCPUs. Once a
> QOM vCPU is realized and its thread created, subsequent enable/disable actions
> do not unrealize it. This behaviour was adopted following review feedback and
> differs from earlier RFC versions.
> 
> Co-developed-by: Keqian Zhu <zhuqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhuqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   accel/kvm/kvm-all.c    |  2 +-
>   hw/arm/virt.c          | 77 ++++++++++++++++++++++++++++++++++++++----
>   hw/core/qdev.c         | 17 ++++++++++
>   include/hw/qdev-core.h | 19 +++++++++++
>   include/system/kvm.h   |  8 +++++
>   target/arm/cpu.c       |  2 ++
>   target/arm/kvm.c       | 40 +++++++++++++++++++++-
>   target/arm/kvm_arm.h   | 11 ++++++
>   8 files changed, 168 insertions(+), 8 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 890d5ea9f8..0e7d9d5c3d 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -460,7 +460,7 @@ static void kvm_reset_parked_vcpus(KVMState *s)
>    *
>    * @returns: 0 when success, errno (<0) when failed.
>    */
> -static int kvm_create_vcpu(CPUState *cpu)
> +int kvm_create_vcpu(CPUState *cpu)
>   {
>       unsigned long vcpu_id = kvm_arch_vcpu_id(cpu);
>       KVMState *s = kvm_state;
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 4ded19dc69..f4eeeacf6c 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2152,6 +2152,49 @@ static void virt_post_cpus_gic_realized(VirtMachineState *vms,
>       }
>   }
>   
> +static void
> +virt_setup_lazy_vcpu_realization(Object *cpuobj, VirtMachineState *vms)
> +{
> +    /*
> +     * Present & administratively disabled vCPUs:
> +     *
> +     * These CPUs are marked offline at init via '-smp disabledcpus=N'. We
> +     * intentionally do not realize them during the first boot, since it is
> +     * not known if or when they will ever be enabled. The decision to enable
> +     * such CPUs depends on policy (e.g. guided by SLAs or other deployment
> +     * requirements).
> +     *
> +     * Realizing all disabled vCPUs up front would make boot time proportional
> +     * to 'maxcpus', even if policy permits only a small subset to be enabled.
> +     * This can lead to unacceptable boot delays in some scenarios.
> +     *
> +     * Instead, these CPUs remain administratively disabled and unrealized at
> +     * boot, to be instantiated and brought online only if policy later allows
> +     * it.
> +     */
> +
> +    /* set this vCPU to be administratively 'disabled' in QOM */
> +    qdev_disable(DEVICE(cpuobj), NULL, &error_fatal);
> +
> +    if (vms->psci_conduit != QEMU_PSCI_CONDUIT_DISABLED) {
> +        object_property_set_int(cpuobj, "psci-conduit", vms->psci_conduit,
> +                                NULL);
> +    }
> +
> +    /*
> +     * [!] Constraint: The ARM CPU architecture does not permit new CPUs
> +     * to be added after system initialization.
> +     *
> +     * Workaround: Pre-create KVM vCPUs even for those that are not yet
> +     * online i.e. powered-off, keeping them `parked` and in an
> +     * `unrealized (at-least during boot time)` state within QEMU until
> +     * they are powered-on and made online.
> +     */
> +    if (kvm_enabled()) {
> +        kvm_arm_create_host_vcpu(ARM_CPU(cpuobj));
> +    }
> +}
> +
>   static void machvirt_init(MachineState *machine)
>   {
>       VirtMachineState *vms = VIRT_MACHINE(machine);
> @@ -2319,10 +2362,6 @@ static void machvirt_init(MachineState *machine)
>           Object *cpuobj;
>           CPUState *cs;
>   
> -        if (n >= smp_cpus) {
> -            break;
> -        }
> -
>           cpuobj = object_new(possible_cpus->cpus[n].type);
>           object_property_set_int(cpuobj, "mp-affinity",
>                                   possible_cpus->cpus[n].arch_id, NULL);
> @@ -2427,8 +2466,34 @@ static void machvirt_init(MachineState *machine)
>               }
>           }
>   
> -        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
> -        object_unref(cpuobj);
> +        /* start secondary vCPUs in a powered-down state */
> +        if(n && mc->has_online_capable_cpus) {
> +            object_property_set_bool(cpuobj, "start-powered-off", true, NULL);
> +        }
> +
> +        if (n < smp_cpus) {
> +            /* 'Present' & 'Enabled' vCPUs */
> +            qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
> +            object_unref(cpuobj);
> +        } else {
> +            /* 'Present' & 'Disabled' vCPUs */
> +            virt_setup_lazy_vcpu_realization(cpuobj, vms);
> +        }
> +
> +        /*
> +         * All possible vCPUs should have QOM vCPU Object pointer & arch-id.
> +         * 'cpus_queue' (accessed via qemu_get_cpu()) contains only realized and
> +         * enabled vCPUs. Hence, we must now populate the 'possible_cpus' list.
> +         */
> +        if (kvm_enabled()) {
> +            /*
> +             * Override the default architecture ID with the one retrieved
> +             * from KVM, as they currently differ.
> +             */
> +            machine->possible_cpus->cpus[n].arch_id =
> +                arm_cpu_mp_affinity(ARM_CPU(cs));
> +        }
> +        machine->possible_cpus->cpus[n].cpu = cs;
>       }
>   
>       /* Now we've created the CPUs we can see if they have the hypvirt timer */
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 8502d6216f..5816abae39 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -309,6 +309,23 @@ void qdev_assert_realized_properly(void)
>                                      qdev_assert_realized_properly_cb, NULL);
>   }
>   
> +bool qdev_disable(DeviceState *dev, BusState *bus, Error **errp)
> +{
> +    g_assert(dev);
> +
> +    if (bus) {
> +        error_setg(errp, "Device %s 'disable' operation not supported",
> +                   object_get_typename(OBJECT(dev)));
> +        return false;
> +    }
> +
> +    /* devices like cpu don't have bus */
> +    g_assert(!DEVICE_GET_CLASS(dev)->bus_type);
> +
> +    return object_property_set_str(OBJECT(dev), "admin_power_state", "disabled",
> +                                   errp);
> +}
> +
>   bool qdev_machine_modified(void)
>   {
>       return qdev_hot_added || qdev_hot_removed;
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 3bc212ab3a..2c22b32a3f 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -570,6 +570,25 @@ bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp);
>    */
>   bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp);
>   
> +/**
> + * qdev_disable - Initiate administrative disablement and power-off of device
> + * @dev:   The device to be administratively powered off
> + * @bus:   The bus on which the device resides (may be NULL for CPUs)
> + * @errp:  Pointer to a location where an error can be reported
> + *
> + * This function initiates an administrative transition of the device into a
> + * DISABLED state. This may trigger a graceful shutdown process depending on
> + * platform capabilities. For ACPI platforms, this typically involves notifying
> + * the guest via events such as Notify(..., 0x03) and executing _EJx.
> + *
> + * Once completed, the device's operational power is turned off and it is
> + * marked as administratively DISABLED. Further guest usage is blocked until
> + * re-enabled by host-side policy.
> + *
> + * Returns true on success; false if an error occurs, with @errp populated.
> + */
> +bool qdev_disable(DeviceState *dev, BusState *bus, Error **errp);
> +
>   /**
>    * qdev_unrealize: Unrealize a device
>    * @dev: device to unrealize
> diff --git a/include/system/kvm.h b/include/system/kvm.h
> index 3c7d314736..4896a3c9c5 100644
> --- a/include/system/kvm.h
> +++ b/include/system/kvm.h
> @@ -317,6 +317,14 @@ int kvm_create_device(KVMState *s, uint64_t type, bool test);
>    */
>   bool kvm_device_supported(int vmfd, uint64_t type);
>   
> +/**
> + * kvm_create_vcpu - Gets a parked KVM vCPU or creates a KVM vCPU
> + * @cpu: QOM CPUState object for which KVM vCPU has to be fetched/created.
> + *
> + * @returns: 0 when success, errno (<0) when failed.
> + */
> +int kvm_create_vcpu(CPUState *cpu);
> +
>   /**
>    * kvm_park_vcpu - Park QEMU KVM vCPU context
>    * @cpu: QOM CPUState object for which QEMU KVM vCPU context has to be parked.
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 7e0d5b2ed8..a5906d1672 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1500,6 +1500,8 @@ static void arm_cpu_initfn(Object *obj)
>           /* TCG and HVF implement PSCI 1.1 */
>           cpu->psci_version = QEMU_PSCI_VERSION_1_1;
>       }
> +
> +    CPU(obj)->thread_id = 0;
>   }
>   
>   /*
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 6672344855..1962eb29b2 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -991,6 +991,38 @@ void kvm_arm_reset_vcpu(ARMCPU *cpu)
>       write_list_to_cpustate(cpu);
>   }
>   
> +void kvm_arm_create_host_vcpu(ARMCPU *cpu)
> +{
> +    CPUState *cs = CPU(cpu);
> +    unsigned long vcpu_id = cs->cpu_index;
> +    int ret;
> +
> +    ret = kvm_create_vcpu(cs);
> +    if (ret < 0) {
> +        error_report("Failed to create host vcpu %ld", vcpu_id);
> +        abort();
> +    }
> +
> +    /*
> +     * Initialize the vCPU in the host. This will reset the sys regs
> +     * for this vCPU and related registers like MPIDR_EL1 etc. also
> +     * get programmed during this call to host. These are referenced
> +     * later while setting device attributes of the GICR during GICv3
> +     * reset.
> +     */
> +    ret = kvm_arch_init_vcpu(cs);
> +    if (ret < 0) {
> +        error_report("Failed to initialize host vcpu %ld", vcpu_id);
> +        abort();
> +    }
> +
> +    /*
> +     * park the created vCPU. shall be used during kvm_get_vcpu() when
> +     * threads are created during realization of ARM vCPUs.
> +     */
> +    kvm_park_vcpu(cs);
> +}
> +

I don't think we're able to simply call kvm_arch_init_vcpu() in the lazily realized
path. Otherwise, it can trigger a crash dump on my Nvidia's grace-hopper machine where
SVE is supported by default.

kvm_arch_init_vcpu() is supposed to be called in the realization path in current
implementation (without this series) because the parameters (features) to KVM_ARM_VCPU_INIT
is populated at vCPU realization time.

$ home/gavin/sandbox/qemu.main/build/qemu-system-aarch64           \
   --enable-kvm -machine virt,gic-version=3 -cpu host               \
   -smp cpus=4,disabledcpus=2 -m 1024M                              \
   -kernel /home/gavin/sandbox/linux.guest/arch/arm64/boot/Image    \
   -initrd /home/gavin/sandbox/images/rootfs.cpio.xz -nographic
qemu-system-aarch64: Failed to initialize host vcpu 4
Aborted (core dumped)

Backtrace
=========
(gdb) bt
#0  0x0000ffff9106bc80 in __pthread_kill_implementation () at /lib64/libc.so.6
#1  0x0000ffff9101aa40 [PAC] in raise () at /lib64/libc.so.6
#2  0x0000ffff91005988 [PAC] in abort () at /lib64/libc.so.6
#3  0x0000aaaab1cc26b8 [PAC] in kvm_arm_create_host_vcpu (cpu=0xaaaab9ab1bc0)
     at ../target/arm/kvm.c:1081
#4  0x0000aaaab1cd0c94 in virt_setup_lazy_vcpu_realization (cpuobj=0xaaaab9ab1bc0, vms=0xaaaab98870a0)
     at ../hw/arm/virt.c:2483
#5  0x0000aaaab1cd180c in machvirt_init (machine=0xaaaab98870a0) at ../hw/arm/virt.c:2777
#6  0x0000aaaab160f220 in machine_run_board_init
     (machine=0xaaaab98870a0, mem_path=0x0, errp=0xfffffa86bdc8) at ../hw/core/machine.c:1722
#7  0x0000aaaab1a25ef4 in qemu_init_board () at ../system/vl.c:2723
#8  0x0000aaaab1a2635c in qmp_x_exit_preconfig (errp=0xaaaab38a50f0 <error_fatal>)
     at ../system/vl.c:2821
#9  0x0000aaaab1a28b08 in qemu_init (argc=15, argv=0xfffffa86c1f8) at ../system/vl.c:3882
#10 0x0000aaaab221d9e4 in main (argc=15, argv=0xfffffa86c1f8) at ../system/main.c:71

Thanks,
Gavin

>   /*
>    * Update KVM's MP_STATE based on what QEMU thinks it is
>    */
> @@ -1876,7 +1908,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
>           return -EINVAL;
>       }
>   
> -    qemu_add_vm_change_state_handler(kvm_arm_vm_state_change, cpu);
> +    /*
> +     * Install VM change handler only when vCPU thread has been spawned
> +     * i.e. vCPU is being realized
> +     */
> +    if (cs->thread_id) {
> +        qemu_add_vm_change_state_handler(kvm_arm_vm_state_change, cpu);
> +    }
>   
>       /* Determine init features for this CPU */
>       memset(cpu->kvm_init_features, 0, sizeof(cpu->kvm_init_features));
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index 6a9b6374a6..ec9dc95ee8 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -98,6 +98,17 @@ bool kvm_arm_cpu_post_load(ARMCPU *cpu);
>   void kvm_arm_reset_vcpu(ARMCPU *cpu);
>   
>   struct kvm_vcpu_init;
> +
> +/**
> + * kvm_arm_create_host_vcpu:
> + * @cpu: ARMCPU
> + *
> + * Called to pre-create possible KVM vCPU within the host during the
> + * `virt_machine` initialization phase. This pre-created vCPU will be parked and
> + * will be reused when ARM QOM vCPU is actually hotplugged.
> + */
> +void kvm_arm_create_host_vcpu(ARMCPU *cpu);
> +
>   /**
>    * kvm_arm_create_scratch_host_vcpu:
>    * @fdarray: filled in with kvmfd, vmfd, cpufd file descriptors in that order


