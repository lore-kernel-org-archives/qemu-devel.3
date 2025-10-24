Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3EACCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 04:09:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC95w-0003rv-BY; Fri, 24 Oct 2025 00:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vC95u-0003rY-L1
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 00:08:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vC95o-0002c0-7e
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 00:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761278873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kBImMTmBA58V8o4pMjCWgFsG872zkzaD9U7BClbIZzk=;
 b=G1o77TlziW2WFCyW11yVCc2z+fzRtgINU0CUxrLIpmG86nKp1hXVvpSQBjb3oH4nEZGbGH
 dv1HyPBnZvlJpP05cLJ4oG1NTz32v9zYl72kUtM44/Q4S3EpHyVRle+Pei8eBhWPtSSWSK
 idl2newt4FPM3w7bRGFF4NUNACVMBJM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-A9eklSI0M0-BEPhrRSzQ8g-1; Fri, 24 Oct 2025 00:07:51 -0400
X-MC-Unique: A9eklSI0M0-BEPhrRSzQ8g-1
X-Mimecast-MFC-AGG-ID: A9eklSI0M0-BEPhrRSzQ8g_1761278870
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-33da21394adso1526678a91.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 21:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761278870; x=1761883670;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kBImMTmBA58V8o4pMjCWgFsG872zkzaD9U7BClbIZzk=;
 b=bwSVnWm/q4h6JnJPPopNea6/lYEoDagpliN5dPttwYdyl8tBEaatEgANCHkstAuFma
 Bome0EPN4H7sZ0iHknXBRPVimdPuAmVCgqfkJYMn+K2/UJ7wD9ej0ekcIa5hjsMTFb0M
 gO00wVCYfg8hGvXdLOGtK4WtJR7ne+AEs9ws9zdPyiejYEzwstv2+6mlGppTQLGCgCKy
 PDxWvNIPPit9BRsEKaabA9wXEcwbCMl81csP0hlikmznBNhjt4ugHCRghAMBx7/rdJij
 GJlRltFFe9yo0yinaSDcD2GYMjOx8s8bEpALuEiKcTQhxCSNtx8GJfdTdRB2Z+50DBhv
 K8wQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPvZJL1GyShyc7iOjWTIVovIXRwMhXcWLtnKxtIrW90mCx7+ioI1od2zpsJ+o0UDkhIZS3RIvQE7Dw@nongnu.org
X-Gm-Message-State: AOJu0YymzZLUkBsI0GafT8uFPKLcrdyL7f/8tnHx9h5//lyaKRw7UfDQ
 HKIcxKDpb+i2FEplFFRQZLV4Z7kUP973T5qKoKO+htwSzMJR/pj3juxyA9CY6D+0mfZSHc540Wu
 9HpVZjEb3DQPIndqI0GOfOv8Q9o5Bw53HUDTe0Zj7F59galP8eTYP3KrJ19XKe+vU
X-Gm-Gg: ASbGnctbNO3NJLBKb9IMxvkflkepv3vccoWDRoq/IhlVR2wMIYtbzvEOmnsvTuHso4w
 2/1eoOPlOmCFepvLf5icCumP0d6vZvVjFr7v8yQZk8Luf2NSVE1KkwxY916OUx+u388GvodBtob
 P4XiB91EuQ0BxROx0/YM1BmP+lejuX59yQnQ/pZqi5jm5vmH5pKRH6i2CaCwOU0YkFVnFS7aTtP
 /dWkPBfP0mE2SKphC4DXY9aueB+H91fI7KrNN699DL/4Pu91M1vNilNOcCaoKoBf7aOGgg8efsT
 ABnpDRlI6R92YjFNpFDm6kFKnxyOu1ThFvCLIi82zkkLDVJY0D9ZVMk30ZYb8PE20PlNz+1zwOg
 Kr0ag9CXhmDJ7jUcQOHisoHSFZqB7CYUv0ocy8bY=
X-Received: by 2002:a17:90b:3909:b0:33b:bed8:891c with SMTP id
 98e67ed59e1d1-33bcf8f7376mr36498183a91.23.1761278869604; 
 Thu, 23 Oct 2025 21:07:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZANsaYiulkjsambefTyfpSAHmg4M1SxEi8s7oOr4zwPZHVHigUt/PCDnt3kiDNitWv+BSWg==
X-Received: by 2002:a17:90b:3909:b0:33b:bed8:891c with SMTP id
 98e67ed59e1d1-33bcf8f7376mr36498145a91.23.1761278868857; 
 Thu, 23 Oct 2025 21:07:48 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au.
 [175.34.62.5]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6cf4e2d787sm3706811a12.29.2025.10.23.21.07.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Oct 2025 21:07:47 -0700 (PDT)
Message-ID: <da4ff28d-8b02-455c-88f9-92e4f5a788c3@redhat.com>
Date: Fri, 24 Oct 2025 14:07:32 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC V6 08/24] arm/virt, gicv3: Guard CPU interface access
 for admin disabled vCPUs
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
 shahuang@redhat.com, zhao1.liu@intel.com
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
 <20251001010127.3092631-9-salil.mehta@opnsrc.net>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251001010127.3092631-9-salil.mehta@opnsrc.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
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
> Per Arm GIC Architecture Specification (IHI0069H_b, §11.1), the CPU interface
> and its Processing Element (PE) share a power domain. If the PE is powered down
> or administratively disabled, the CPU interface must be quiescent or off, and
> any access is architecturally UNPREDICTABLE. Without explicit checks, QEMU may
> issue GICC register operations for vCPUs that are offline, removed, or
> otherwise unavailable—risking inconsistent state or undefined behavior in both
> TCG and KVM accelerators.
> 
> To address this, introduce a per-vCPU gicc_accessible flag that reflects the
> administrative enablement of the corresponding QOM vCPU in accordance with the
> policy. This is permissible when the GICC (GIC CPU Interface) is online-capable,
> meaning vCPUs can be brought online in the guest kernel after boot. The flag is
> set during GIC realization and used to skip VGIC register reads/writes, SGI
> generation, and CPU interface updates when the GICC is not accessible. This
> prevents unsafe operations and ensures compliance when managing administratively
> disabled but present vCPUs.
> 
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   hw/core/qdev.c                     | 26 +++++++++++++++++
>   hw/intc/arm_gicv3_common.c         | 23 +++++++++++++++
>   hw/intc/arm_gicv3_cpuif.c          |  8 +++++
>   hw/intc/arm_gicv3_cpuif_common.c   | 47 ++++++++++++++++++++++++++++++
>   hw/intc/arm_gicv3_kvm.c            | 18 ++++++++++++
>   include/hw/intc/arm_gicv3_common.h | 24 +++++++++++++++
>   include/hw/qdev-core.h             | 24 +++++++++++++++
>   7 files changed, 170 insertions(+)
> 
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 5816abae39..8e9a4da6b5 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -326,6 +326,32 @@ bool qdev_disable(DeviceState *dev, BusState *bus, Error **errp)
>                                      errp);
>   }
>   
> +int qdev_get_admin_power_state(DeviceState *dev)
> +{
> +    DeviceClass *dc;
> +
> +    if (!dev) {
> +        return DEVICE_ADMIN_POWER_STATE_REMOVED;
> +    }
> +
> +    dc = DEVICE_GET_CLASS(dev);
> +    if (dc->admin_power_state_supported) {
> +        return object_property_get_enum(OBJECT(dev), "admin_power_state",
> +                                        "DeviceAdminPowerState", NULL);
> +    }
> +
> +    return DEVICE_ADMIN_POWER_STATE_ENABLED;
> +}
> +
> +bool qdev_check_enabled(DeviceState *dev)
> +{
> +   /*
> +    * if device supports power state transitions, check if it is not in
> +    * 'disabled' state.
> +    */
> +    return qdev_get_admin_power_state(dev) == DEVICE_ADMIN_POWER_STATE_ENABLED;
> +}
> +
>   bool qdev_machine_modified(void)
>   {
>       return qdev_hot_added || qdev_hot_removed;
> diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
> index f6a9f1c68b..f4428ad165 100644
> --- a/hw/intc/arm_gicv3_common.c
> +++ b/hw/intc/arm_gicv3_common.c
> @@ -439,6 +439,29 @@ static void arm_gicv3_common_realize(DeviceState *dev, Error **errp)
>           CPUState *cpu = machine_get_possible_cpu(i);
>           uint64_t cpu_affid;
>   
> +        /*
> +         * Ref: Arm Generic Interrupt Controller Architecture Specification
> +         * (GIC Architecture version 3 and version 4), IHI0069H_b,
> +         * Section 11.1: Power Management
> +         * https://developer.arm.com/documentation/ihi0069
> +         *
> +         * According to this specification, the CPU interface and the
> +         * Processing Element (PE) must reside in the same power domain.
> +         * Therefore, when a CPU/PE is powered off, its corresponding CPU
> +         * interface must also be in the off state or in a quiescent state—
> +         * depending on the state of the associated Redistributor.
> +         *
> +         * The Redistributor may reside in a separate power domain and may
> +         * remain powered even when the associated PE is turned off.
> +         *
> +         * Accessing the GIC CPU interface while the PE is powered down can
> +         * lead to UNPREDICTABLE behavior.
> +         *
> +         * Accordingly, the QOM object `GICv3CPUState` should be marked as
> +         * either accessible or inaccessible based on the power state of the
> +         * associated `CPUState` vCPU.
> +         */
> +        s->cpu[i].gicc_accessible = qdev_check_enabled(DEVICE(cpu));
>           s->cpu[i].cpu = cpu;
>           s->cpu[i].gic = s;
>           /* Store GICv3CPUState in CPUARMState gicv3state pointer */
> diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
> index a7904237ac..6430b2c649 100644
> --- a/hw/intc/arm_gicv3_cpuif.c
> +++ b/hw/intc/arm_gicv3_cpuif.c
> @@ -1052,6 +1052,10 @@ void gicv3_cpuif_update(GICv3CPUState *cs)
>       ARMCPU *cpu = ARM_CPU(cs->cpu);
>       CPUARMState *env = &cpu->env;
>   
> +    if (!gicv3_gicc_accessible(OBJECT(cs->gic), CPU(cpu)->cpu_index)) {
> +        return;
> +    }
> +
>       g_assert(bql_locked());
>   
>       trace_gicv3_cpuif_update(gicv3_redist_affid(cs), cs->hppi.irq,
> @@ -2036,6 +2040,10 @@ static void icc_generate_sgi(CPUARMState *env, GICv3CPUState *cs,
>       for (i = 0; i < s->num_cpu; i++) {
>           GICv3CPUState *ocs = &s->cpu[i];
>   
> +        if (!gicv3_gicc_accessible(OBJECT(s), i)) {
> +            continue;
> +        }
> +
>           if (irm) {
>               /* IRM == 1 : route to all CPUs except self */
>               if (cs == ocs) {
> diff --git a/hw/intc/arm_gicv3_cpuif_common.c b/hw/intc/arm_gicv3_cpuif_common.c
> index f9a9b2d8a3..8f9a5b6fa2 100644
> --- a/hw/intc/arm_gicv3_cpuif_common.c
> +++ b/hw/intc/arm_gicv3_cpuif_common.c
> @@ -12,6 +12,9 @@
>   #include "qemu/osdep.h"
>   #include "gicv3_internal.h"
>   #include "cpu.h"
> +#include "qemu/log.h"
> +#include "monitor/monitor.h"
> +#include "qapi/visitor.h"
>   
>   void gicv3_set_gicv3state(CPUState *cpu, GICv3CPUState *s)
>   {
> @@ -21,6 +24,41 @@ void gicv3_set_gicv3state(CPUState *cpu, GICv3CPUState *s)
>       env->gicv3state = (void *)s;
>   };
>   
> +static void
> +gicv3_get_gicc_accessibility(Object *obj, Visitor *v, const char *name,
> +                             void *opaque, Error **errp)
> +{
> +    GICv3CPUState *cs = (GICv3CPUState *)opaque;
> +    bool value = cs->gicc_accessible;
> +
> +    visit_type_bool(v, name, &value, errp);
> +}
> +
> +static void
> +gicv3_set_gicc_accessibility(Object *obj, Visitor *v, const char *name,
> +                             void *opaque, Error **errp)
> +{
> +    GICv3CPUState *gcs = opaque;
> +    CPUState *cs = gcs->cpu;
> +    bool value;
> +
> +    visit_type_bool(v, name, &value, errp);
> +
> +    /* Block external attempts to set */
> +    if (monitor_cur_is_qmp()) {
> +        error_setg(errp, "Property 'gicc-accessible' is read-only externally");
> +        return;
> +    }
> +
> +    if (gcs->gicc_accessible != value) {
> +        gcs->gicc_accessible = value;
> +
> +        qemu_log_mask(LOG_UNIMP,
> +                      "GICC accessibility changed: vCPU %d = %s\n",
> +                      cs->cpu_index, value ? "accessible" : "inaccessible");
> +    }
> +}
> +

The property can be modified from the external by 'qom-set'.

(qemu) qom-list /machine/unattached
device[2] (child<kvm-arm-gicv3>)

(qemu) qom-get /machine/unattached/device[2] gicc-accessible[0]
true
(qemu) qom-set /machine/unattached/device[2] gicc-accessible[0] false
(qemu) qom-get /machine/unattached/device[2] gicc-accessible[0]
false

Thanks,
Gavin

>   void gicv3_init_cpuif(GICv3State *s)
>   {
>       ARMGICv3CommonClass *agcc = ARM_GICV3_COMMON_GET_CLASS(s);
> @@ -28,6 +66,15 @@ void gicv3_init_cpuif(GICv3State *s)
>   
>       /* define and register `system registers` with the vCPU  */
>       for (i = 0; i < s->num_cpu; i++) {
> +        g_autofree char *propname = g_strdup_printf("gicc-accessible[%d]", i);
> +        object_property_add(OBJECT(s), propname, "bool",
> +                            gicv3_get_gicc_accessibility,
> +                            gicv3_set_gicc_accessibility,
> +                            NULL, &s->cpu[i]);
> +
> +        object_property_set_description(OBJECT(s), propname,
> +            "Per-vCPU GICC interface accessibility (internal set only)");
> +
>           agcc->init_cpu_reginfo(s->cpu[i].cpu);
>       }
>   }
> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> index 4ca889da45..e97578f59a 100644
> --- a/hw/intc/arm_gicv3_kvm.c
> +++ b/hw/intc/arm_gicv3_kvm.c
> @@ -457,6 +457,16 @@ static void kvm_arm_gicv3_put(GICv3State *s)
>           GICv3CPUState *c = &s->cpu[ncpu];
>           int num_pri_bits;
>   
> +        /*
> +         * We must ensure that we do not attempt to access or update KVM GICC
> +         * registers if their corresponding QOM `GICv3CPUState` is marked as
> +         * 'inaccessible', because their corresponding QOM vCPU objects
> +         * are in administratively 'disabled' state.
> +         */
> +        if (!gicv3_gicc_accessible(OBJECT(s), ncpu)) {
> +            continue;
> +        }
> +
>           kvm_gicc_access(s, ICC_SRE_EL1, ncpu, &c->icc_sre_el1, true);
>           kvm_gicc_access(s, ICC_CTLR_EL1, ncpu,
>                           &c->icc_ctlr_el1[GICV3_NS], true);
> @@ -615,6 +625,14 @@ static void kvm_arm_gicv3_get(GICv3State *s)
>           GICv3CPUState *c = &s->cpu[ncpu];
>           int num_pri_bits;
>   
> +        /*
> +         * don't attempt to access KVM VGIC for the disabled vCPUs where
> +         * GICv3CPUState is inaccessible.
> +         */
> +        if (!gicv3_gicc_accessible(OBJECT(s), ncpu)) {
> +            continue;
> +        }
> +
>           kvm_gicc_access(s, ICC_SRE_EL1, ncpu, &c->icc_sre_el1, false);
>           kvm_gicc_access(s, ICC_CTLR_EL1, ncpu,
>                           &c->icc_ctlr_el1[GICV3_NS], false);
> diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
> index 3720728227..bbf899184e 100644
> --- a/include/hw/intc/arm_gicv3_common.h
> +++ b/include/hw/intc/arm_gicv3_common.h
> @@ -27,6 +27,7 @@
>   #include "hw/sysbus.h"
>   #include "hw/intc/arm_gic_common.h"
>   #include "qom/object.h"
> +#include "qapi/error.h"
>   
>   /*
>    * Maximum number of possible interrupts, determined by the GIC architecture.
> @@ -164,6 +165,7 @@ struct GICv3CPUState {
>       uint64_t icc_apr[3][4];
>       uint64_t icc_igrpen[3];
>       uint64_t icc_ctlr_el3;
> +    bool gicc_accessible;
>   
>       /* Virtualization control interface */
>       uint64_t ich_apr[3][4]; /* ich_apr[GICV3_G1][x] never used */
> @@ -329,4 +331,26 @@ void gicv3_init_irqs_and_mmio(GICv3State *s, qemu_irq_handler handler,
>    */
>   const char *gicv3_class_name(void);
>   
> +/**
> + * gicv3_gicc_accessible:
> + * @obj: QOM object implementing the GICv3 device
> + * @cpu: Index of the vCPU whose GICC accessibility is being queried
> + *
> + * Returns: true if the GICC interface for vCPU @cpu is accessible.
> + * Uses QOM property lookup for "gicc-accessible[%d]".
> + */
> +static inline bool gicv3_gicc_accessible(Object *obj, int cpu)
> +{
> +    g_autofree gchar *propname = g_strdup_printf("gicc-accessible[%d]", cpu);
> +    Error *local_err = NULL;
> +    bool value;
> +
> +    value = object_property_get_bool(obj, propname, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +        return false;
> +    }
> +
> +    return value;
> +}
>   #endif
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 2c22b32a3f..b1d3fa4a25 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -589,6 +589,30 @@ bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp);
>    */
>   bool qdev_disable(DeviceState *dev, BusState *bus, Error **errp);
>   
> +/**
> + * qdev_check_enabled - Check if a device is administratively enabled
> + * @dev:  The device to check
> + *
> + * This function returns whether the device is currently in administrative
> + * ENABLED state. It does not reflect runtime operational power state, but
> + * rather the host policy on whether the guest may interact with the device.
> + *
> + * Returns true if the device is administratively enabled; false otherwise.
> + */
> +bool qdev_check_enabled(DeviceState *dev);
> +
> +/**
> + * qdev_get_admin_power_state - Query administrative power state of a device
> + * @dev:  The device whose state is being queried
> + *
> + * Returns the current administrative power state (ENABLED or DISABLED),
> + * as stored in the device's internal admin state field. This reflects
> + * host-level policy—not the operational runtime state seen by the guest.
> + *
> + * Returns an integer from the DeviceAdminPowerState enum.
> + */
> +int qdev_get_admin_power_state(DeviceState *dev);
> +
>   /**
>    * qdev_unrealize: Unrealize a device
>    * @dev: device to unrealize


