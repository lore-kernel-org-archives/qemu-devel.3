Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51944C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 16:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Aje-0007L1-Rb; Thu, 03 Sep 2026 12:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2Ajc-0007HG-Vn
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 12:56:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2Ajb-000141-67
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 12:56:20 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G3FRb346269
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 16:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /2lBJFzMZsPVEsEtRONralg5NQQvmPwzKBmCGKbETJ4=; b=T0P5SuJcku1T2V1f
 AmwH92JateWin10QlymPKuR/salOa19CZA7WXHDyWWNx3qRFDOq4k84neRp9bAdh
 uKSbviQwEKyPzBvFXLIZyoQlHA9kbPk+NX8Eg68Hn4n6GyUf2l59SQLDSy0GLI6K
 IEfe5XTUcCg3GweNidYEuHgmXausxaMSMgSSZVzVSo7tHtescsoEZHd1gF1wKz0s
 T1y2nRZXI0F+fRIIymPAdHcoKvPDYokzQyyFRpP7sT9eBaP0CarZ3UPK1Vjfodoa
 tOUVtRoePrRifg2VSHyaOoLTZo/DEJjVfbeEtTsUkQHi5DyG2ByzRx/KF/A31zfu
 z2jtRg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf5pdt4t8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 16:56:17 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-9103f4ddce5so287656d6.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 09:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788454577; x=1789059377; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/2lBJFzMZsPVEsEtRONralg5NQQvmPwzKBmCGKbETJ4=;
 b=Ef7Zr5UVbtLXQ5MOzKaJ098p6zHWujf0ITUlF+bnvr+F+lYEs1+tJzmg9Rw2pJ8E6D
 5nQanZnRzeU0cCQuuT4nrfSHEDsCdykNsImH2fjw32+tDGstZ+/dTZL32TNDeCMiNl2I
 b67XkdX20g7uM4dD96vH4OD23vSmx6U/B38Uo+Jf5SRmGdODpMRB91T6uGoxLOJWjwRE
 bk8WvSZDlfgmGp+NnHgag37qqIFO8URacb+AH+FKFLoAvlmXbtlAwBq+YpzE/23RRhmY
 wlx2HkeqHirLdCnn+hHUTJiLpS9OrICiYot1clPexc1b9mm03i/dQMBBGeJyA3YNENpu
 sZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788454577; x=1789059377;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/2lBJFzMZsPVEsEtRONralg5NQQvmPwzKBmCGKbETJ4=;
 b=anIi6TGBXALY+ZGqKJPSeGI0UIaniqXioAZP7E9V+3zzgCL9gAo+4A1MxrBAVccqw9
 HsAA8x/1k7TbDR89727h1qMGyxl/rOjm2ST46fbv7/P1NrsG5TUtyC+wN0yU3AJxokLn
 FzkqnNGeyaDPhnY/sH4fUk4/RkxhO2ScqdqGQaA8PEqGA6AD8EyEy4PhsdRZFNwF/isR
 a39JOowFqbmF+wd4XZLBi/uEK6x2vnpunWXbw2JwEvww9gkYLdrtDGcoj+weaV/ExN/E
 rJJb43lEbjQ+dmpSAKEpXMt+cBLVuNVRaoP7jEbfdJLoCeVel72lJq/xZEpuhHu6gWDR
 6z/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5HUHUzq2JROJ9WCmSHFzuOOH/u1nYt300BOP8QlXMks+ir/COFqiOB7nVbD64gpnqBj+OKEjl1TxD@nongnu.org
X-Gm-Message-State: AFuF++k/nVSXwdOvEsMkLiyiYLs3zqN8p5Ue03HR+BpPUU+Y/VfA0SZN
 VWskcGk0GBj6cajAONJckLAlefUFEW+6b0yz2t4G/FiOo/WavJSro8Gk8idahgHBbVxqHoW/q0R
 Ro6DwYclv9wuDiMh+Tj9Ih25R9ZbP7VuaabFeiHKj1aqhuRlYkfh23iM+9A==
X-Gm-Gg: AYBFou07sHL1OgvXtqSaO2bnkgf1bs+WLkdD51V31vCaInN9yFjwu49V7f+NWSSIEs3
 q7ICG1UwFG6ujz3uFiONAWdBspU4nZ6opTLM+DLmQUZeCJbkSKT94CtumtupC4UG4IHqHz9ihot
 3fPM421Jsfyegggq+98RnysTedV+kPYKnoY7WFtezMJVqiE7kUQ0SwLntzqqof1nVugrCEEHTpk
 uOL1vo1Z7OxsW+G9DW90q5WJOI+VxB88KFr5eWe5i8hCSjs8KukKRwB+BzZPz/FmL5c7jpODsCu
 jUUq5fnSnnn+3D5OrkrShOSTtMFNjx3ZukZD1hm3r0FX4wGUXVI0qzmS0FPS1kuvfZbjwIeLHph
 bjzVBnGEBGSACzJOZkGmuOMfNlUA0As6zAg==
X-Received: by 2002:a05:620a:8906:b0:939:6de9:208b with SMTP id
 af79cd13be357-9397ee4185bmr140650585a.48.1788454576536; 
 Thu, 03 Sep 2026 09:56:16 -0700 (PDT)
X-Received: by 2002:a05:620a:8906:b0:939:6de9:208b with SMTP id
 af79cd13be357-9397ee4185bmr140643785a.48.1788454575897; 
 Thu, 03 Sep 2026 09:56:15 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5dec54sm100241595e9.12.2026.09.03.09.56.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 09:56:15 -0700 (PDT)
Message-ID: <0795176d-4580-4acc-a3cf-c40f8d221661@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 18:56:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/33] hw/arm: Add basic Phytium Pi machine
Content-Language: en-US
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20260903112532.3276678-1-bin.meng@processmission.com>
 <20260903112532.3276678-3-bin.meng@processmission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260903112532.3276678-3-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE0NyBTYWx0ZWRfX7qTFcWwWy2b6
 ZAD1wR6uuQYWIh2FktIorFTA1R0Qz25v1OPdyDrRC4q35ZsS9gF9sqReHs+Z5zuk5XZ8ck4bc6H
 kKez5GBSPCPHB8ctupXgtOGCnUFwQDg=
X-Proofpoint-ORIG-GUID: 9KOWmwQFZOfegJMVtlt67o3_yYYFK8XV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE0NyBTYWx0ZWRfX/U8N9Muqre9D
 5IfwjaL2Ype83zsgf5JiwgJufy8g2gX65GJAC2+c/cIRsO6Lf4Sffnh0B+j2mO+cyQYyvXSIU14
 Qoob7eW/SOU3wUc3zroemppuAliAIGxk5z/P8umouBlLeeCt8+Qwf0crjT764b5WBlZqkUrizBV
 KxQZ6tS1h8txkXVW0rP/3zxXHr+AGFhjqAOoRiW39q5wNp0UEkr8qgoKlctjeaG5mfTlhosabPv
 /eojIamFB5trWo1TjR7591nfV8Crct7YuaVr+8fiy7yBPG8xoXLzcycUHq6k5r8QXYtppxPBvgw
 VqcxSgPcMrHHNeQObZXQWN2u18xGHh98ZhAJpeUetr9V1NvqBl3C0nQNylYO8S30ptv9IjTKJr9
 1ugPU0yWm0HEPGrQSo2WlMmj9jie2vJYHjQ7RlE/LOua0S5uo19F3gPQopVUyXDxY4mGFWEMQq5
 wiX2oCh0U5uG3S+5jfA==
X-Authority-Analysis: v=2.4 cv=RsL16imK c=1 sm=1 tr=0 ts=6a99a6b1 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=vsFwFmOi1xvdgcyoJY0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-GUID: 9KOWmwQFZOfegJMVtlt67o3_yYYFK8XV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030147
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/9/26 13:24, Bin Meng wrote:
> Add the base topology for the Phytium Pi board built around the
> E2000Q SoC, with two FTC310 and two FTC664 CPUs, RAM, GICv3/ITS,
> and PL011 UARTs.
> 
> Describe the CPUs as three non-uniform clusters matching the vendor
> Linux device tree. Preserve the board CPU slot order so firmware
> MPIDR 0x200 maps to QEMU CPU index 2.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
> 
>   hw/arm/Kconfig         |   8 +
>   hw/arm/meson.build     |   1 +
>   hw/arm/phytium_e2000.c | 406 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 415 insertions(+)
>   create mode 100644 hw/arm/phytium_e2000.c


> +struct PhytiumE2000State {
> +    MachineState parent;
> +    struct arm_boot_info bootinfo;
> +    DeviceState *gic;
> +    MemoryRegion ram_low;
> +    MemoryRegion ram_high;
> +};


> +static void phytium_e2000_create_gic(PhytiumE2000State *s)
> +{
> +    MachineState *ms = MACHINE(s);
> +    SysBusDevice *gicbusdev;
> +    QList *redist_region_count;
> +    int i;
> +
> +    s->gic = qdev_new(gicv3_class_name());
> +    qdev_prop_set_uint32(s->gic, "revision", 3);
> +    qdev_prop_set_uint32(s->gic, "num-cpu", ms->smp.cpus);
> +    qdev_prop_set_uint32(s->gic, "num-irq", PHYTIUM_E2000_NUM_IRQS + 32);
> +    qdev_prop_set_bit(s->gic, "has-security-extensions", true);
> +    qdev_prop_set_bit(s->gic, "has-lpi", true);
> +
> +    redist_region_count = qlist_new();
> +    qlist_append_int(redist_region_count, ms->smp.cpus);
> +    qdev_prop_set_array(s->gic, "redist-region-count", redist_region_count);
> +
> +    object_property_set_link(OBJECT(s->gic), "sysmem",
> +                             OBJECT(get_system_memory()), &error_fatal);
> +
> +    gicbusdev = SYS_BUS_DEVICE(s->gic);
> +    sysbus_realize_and_unref(gicbusdev, &error_fatal);
> +    sysbus_mmio_map(gicbusdev, 0,
> +                    phytium_e2000_memmap[PHYTIUM_E2000_GIC_DIST].base);
> +    sysbus_mmio_map(gicbusdev, 1,
> +                    phytium_e2000_memmap[PHYTIUM_E2000_GIC_REDIST].base);
> +
> +    for (i = 0; i < ms->smp.cpus; i++) {
> +        DeviceState *cpudev = DEVICE(qemu_get_cpu(i));

I'd rather you keep a reference in PhytiumE2000State when creating
in [*] and access the CPUs that way, not with qemu_get_cpu() (because
we plan to restrict it to accel/, as it is problematic on heterogeneous
emulation).

> +        int intidbase = PHYTIUM_E2000_NUM_IRQS + i * GIC_INTERNAL;
> +        static const int timer_irq[] = {
> +            [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
> +            [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
> +            [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
> +            [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
> +        };
> +
> +        for (int irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
> +            qdev_connect_gpio_out(cpudev, irq,
> +                qdev_get_gpio_in(s->gic, intidbase + timer_irq[irq]));
> +        }
> +        qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt", 0,
> +            qdev_get_gpio_in(s->gic, intidbase + ARCH_GIC_MAINT_IRQ));
> +        qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
> +            qdev_get_gpio_in(s->gic, intidbase + VIRTUAL_PMU_IRQ));
> +
> +        sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
> +        sysbus_connect_irq(gicbusdev, i + ms->smp.cpus,
> +                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
> +        sysbus_connect_irq(gicbusdev, i + 2 * ms->smp.cpus,
> +                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
> +        sysbus_connect_irq(gicbusdev, i + 3 * ms->smp.cpus,
> +                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
> +    }
> +
> +    phytium_e2000_create_its(s);
> +}


> +static void phytium_e2000_create_cpus(PhytiumE2000State *s)
> +{
> +    MachineState *ms = MACHINE(s);
> +    const CPUArchIdList *possible_cpus;
> +    int i;
> +
> +    possible_cpus = MACHINE_GET_CLASS(ms)->possible_cpu_arch_ids(ms);
> +
> +    for (i = 0; i < ms->smp.cpus; i++) {
> +        Object *cpuobj = object_new(possible_cpus->cpus[i].type);

[*]

> +        CPUState *cs;
> +
> +        object_property_set_int(cpuobj, "mp-affinity",
> +                                possible_cpus->cpus[i].arch_id,
> +                                &error_abort);
> +        object_property_set_int(cpuobj, "cntfrq", PHYTIUM_E2000_GTIMER_HZ,
> +                                &error_abort);
> +        if (object_property_find(cpuobj, "has_el3")) {
> +            /*
> +             * The generic-loader U-Boot path starts after the EL3 firmware
> +             * stages that normally provide the Phytium SMC services.
> +             */
> +            object_property_set_bool(cpuobj, "has_el3", false, &error_abort);
> +        }
> +        object_property_set_link(cpuobj, "memory", OBJECT(get_system_memory()),
> +                                 &error_abort);
> +        cs = CPU(cpuobj);
> +        cs->cpu_index = i;
> +        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
> +        object_unref(cpuobj);
> +    }
> +}
> +
> +static void phytium_pi_init(MachineState *ms)
> +{
> +    PhytiumE2000State *s = PHYTIUM_PI(ms);
> +    int i;
> +
> +    if (kvm_enabled()) {
> +        error_report("phytium-pi: KVM is not supported");

Why is it relevant?
> +        exit(1);
> +    }

> +}
Conditional to not using qemu_get_cpu():
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


