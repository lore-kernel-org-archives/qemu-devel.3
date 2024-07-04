Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9140DC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 03:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPCpT-0003qn-7n; Wed, 03 Jul 2024 23:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPCpS-0003qY-7s; Wed, 03 Jul 2024 23:08:14 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPCpP-000189-DJ; Wed, 03 Jul 2024 23:08:13 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fa3bdd91c1so871265ad.2; 
 Wed, 03 Jul 2024 20:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720062489; x=1720667289; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VHiSBZnxS40GSLKvLVKSV6Nxm0QoNiS8xCzamFxaQ3w=;
 b=I43BxA/Dh6KXQZg3sYOY7AD/R++jO7Ql7lvr8ZPj61nONhZPMJqrHxROCbQAC1wQVw
 wnC/EYdMWvDr5MvknauW2bot7N4xM7KLb4cX7HRuGKwuQqv8VedHfb0tIfGjD+2YOJpw
 EE1HbX863yBzLBedq1C2XwvT6XqlvQxMKWN/ZCg0naFzb8uqJC8qr0zsxAENXS2NJoqQ
 UPz2rXbL9ISXwvxsnCLE7Pb0kgj3x4E4tg1OQHarg004vbCbmScxfzk9Ovuj1CgVAVzM
 OIXEo4D7axopPCqEYCERa4TlzelWXLVscWsQ8SR2Kdl1QxaSDQ1f0cbbffOO6Dq0ymHN
 427A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720062489; x=1720667289;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VHiSBZnxS40GSLKvLVKSV6Nxm0QoNiS8xCzamFxaQ3w=;
 b=X2ys1FQE8WFLUN0HG37Tn5dz3wX1MzAUDcS8rppcqadQDYCzomScjhOReki0F8sypn
 SWs8M3+yhUfNdaAuTd8PV22xyZz4s97IEJNIUtgFkmSglHFeIPchdXRsVifwIGix96gN
 ArsrM2JelvwE3dZcy8/QldU4nOw83X8L0Kw3j0Qn+eFa1q8ROTjOIK4UY09qIf5jzYDU
 y/+WQJTzmUjcqs/bldHdD/p0oXZd2euV3RjX5VKIirwodhbvbDAwEBurEFkQC1xkBQek
 +KzPn0yql0MLmDtaWilMCbQGb0nq+NSa0wQEowtcY7NTT6DoUCHlNN8n8mj0RZo8iTNj
 Jv2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGMwLaeI/Uy2YfezpiXM5oaMxw3mbXeA/uXCHqyOwmNuKzcizuPIt1yHWYpQVDzeg5+4b1omesQLfMV7JphC9r60ofJ69VEjWebzhhAlOcN/nuGUmbSqDtikQ=
X-Gm-Message-State: AOJu0YzPZRagpaymfx5tq/aBb7jjqFI5I41WRhXz1V2xDwVVLRaO6mN6
 I4U3VMGANd7BOuO1ESxCW8lEPHiwYKzeKXKl4peDm1a/kvbmHff1
X-Google-Smtp-Source: AGHT+IHAw52xSXmCVkVsSv9/zWXJAZpGYwx7sSfiHkRI/9TRSsUYjdsGiDOu4FnjihuLnrxrUklBUQ==
X-Received: by 2002:a17:902:d484:b0:1f9:9768:ea61 with SMTP id
 d9443c01a7336-1fb33e05067mr4520595ad.2.1720062489397; 
 Wed, 03 Jul 2024 20:08:09 -0700 (PDT)
Received: from localhost ([1.146.95.80]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac10c8f81sm111305105ad.28.2024.07.03.20.07.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 20:08:08 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 13:07:50 +1000
Message-Id: <D2GF9A9AJO02.1G1G8UEXA5AOD@gmail.com>
Cc: <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <eric.auger@redhat.com>, <will@kernel.org>,
 <ardb@kernel.org>, <oliver.upton@linux.dev>, <pbonzini@redhat.com>,
 <gshan@redhat.com>, <rafael@kernel.org>, <borntraeger@linux.ibm.com>,
 <alex.bennee@linaro.org>, <harshpb@linux.ibm.com>, <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>, <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>, <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>, <salil.mehta@opnsrc.net>,
 <zhukeqian1@huawei.com>, <wangxiongfeng2@huawei.com>,
 <wangyanan55@huawei.com>, <jiakernel2@gmail.com>, <maobibo@loongson.cn>,
 <lixianglai@loongson.cn>, <shahuang@redhat.com>, <zhao1.liu@intel.com>,
 <linuxarm@huawei.com>
Subject: Re: [PATCH RFC V3 08/29] arm/virt: Init PMU at host for all
 possible vcpus
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Salil Mehta" <salil.mehta@huawei.com>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>, <mst@redhat.com>
X-Mailer: aerc 0.17.0
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-9-salil.mehta@huawei.com>
In-Reply-To: <20240613233639.202896-9-salil.mehta@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri Jun 14, 2024 at 9:36 AM AEST, Salil Mehta wrote:
> PMU for all possible vCPUs must be initialized at the VM initialization t=
ime.
> Refactor existing code to accomodate possible vCPUs. This also assumes th=
at all
> processor being used are identical.
>
> Past discussion for reference:
> Link: https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00131.html

I guess it's something for the ARM people, but there's a lot of
information in there, could it be useful to summarise important
parts here, e.g., from Andrew:

 KVM requires all VCPUs to have a PMU if one does. If the ARM ARM
 says it's possible to have PMUs for only some CPUs, then, for TCG,
 the restriction could be relaxed.

(I assume he meant ARM arch)

>
> Co-developed-by: Salil Mehta <salil.mehta@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>  hw/arm/virt.c         | 12 ++++++++----
>  include/hw/arm/virt.h |  1 +
>  2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index ac53bfadca..57ec429022 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2045,12 +2045,14 @@ static void finalize_gic_version(VirtMachineState=
 *vms)
>   */
>  static void virt_cpu_post_init(VirtMachineState *vms, MemoryRegion *sysm=
em)
>  {
> +    CPUArchIdList *possible_cpus =3D vms->parent.possible_cpus;
>      int max_cpus =3D MACHINE(vms)->smp.max_cpus;
> -    bool aarch64, pmu, steal_time;
> +    bool aarch64, steal_time;
>      CPUState *cpu;
> +    int n;
> =20
>      aarch64 =3D object_property_get_bool(OBJECT(first_cpu), "aarch64", N=
ULL);
> -    pmu =3D object_property_get_bool(OBJECT(first_cpu), "pmu", NULL);
> +    vms->pmu =3D object_property_get_bool(OBJECT(first_cpu), "pmu", NULL=
);
>      steal_time =3D object_property_get_bool(OBJECT(first_cpu),
>                                            "kvm-steal-time", NULL);
> =20
> @@ -2077,8 +2079,10 @@ static void virt_cpu_post_init(VirtMachineState *v=
ms, MemoryRegion *sysmem)
>              memory_region_add_subregion(sysmem, pvtime_reg_base, pvtime)=
;
>          }
> =20
> -        CPU_FOREACH(cpu) {
> -            if (pmu) {
> +        for (n =3D 0; n < possible_cpus->len; n++) {
> +            cpu =3D qemu_get_possible_cpu(n);
> +

Maybe a CPU_FOREACH_POSSIBLE()?

Thanks,
Nick

> +            if (vms->pmu) {
>                  assert(arm_feature(&ARM_CPU(cpu)->env, ARM_FEATURE_PMU))=
;
>                  if (kvm_irqchip_in_kernel()) {
>                      kvm_arm_pmu_set_irq(ARM_CPU(cpu), VIRTUAL_PMU_IRQ);
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 36ac5ff4a2..d8dcc89a0d 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -155,6 +155,7 @@ struct VirtMachineState {
>      bool ras;
>      bool mte;
>      bool dtb_randomness;
> +    bool pmu;
>      OnOffAuto acpi;
>      VirtGICType gic_version;
>      VirtIOMMUType iommu;


