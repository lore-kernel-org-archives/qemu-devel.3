Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D63C3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 01:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdgAD-000513-KG; Mon, 12 Aug 2024 21:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sdgAC-0004zx-4U
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 21:17:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sdgA8-0004UA-Fk
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 21:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723511840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R/NzavlB9aam14kH4Hp/v1TfseVW/xmMR2ba+MwAhng=;
 b=VtzyCJPfPXlMblTyx+7MyWGgKDJ1rKpRAWTakouv+vyWExzKOhfmMmqa1kao3dhGuZzDri
 drXkQq9uxbbnhHWr71czm5FN3uNqVKEEBTF2kjPVLKpQMtC90O5evaZAH3nEukppwPnOYj
 O3HAeAhIcylrQ6gaaD+IJm950msQ6RI=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-uecf3N8-NEGFKKEsNQ7LQg-1; Mon, 12 Aug 2024 21:17:18 -0400
X-MC-Unique: uecf3N8-NEGFKKEsNQ7LQg-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1fc6db23c74so51149275ad.0
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 18:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723511837; x=1724116637;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R/NzavlB9aam14kH4Hp/v1TfseVW/xmMR2ba+MwAhng=;
 b=I9zlAVt1NyMO2NZztVMgyk6pKVobfnJjaxkROnHz9EoWAGzbCoHnTIFOyuT30k/AoS
 Xql6Z2nwyVg7/5j8CCqahF4NTFHPuroZaGcd365TBDP6saQPd1NbSK0DfoH9B+xGYelR
 hPUaTX2PReuCoVJgYcD65aN2QdECq4VtS1vna30YdWZb3MBnK+aCfIssx/T1w+W1tisa
 ootiqY0haxNOXTgBtvOikjz2Eyap5UU9yWlUNwtcPFEsLzmcc5ZT/cpqdf1cwwEPKENW
 hmwiJOLjyZaFIE1F2UHFSH6e8WYK46gBsP8QVP/2KWT4q/oUVr1DLUqS4LOnGpdpft9z
 cZvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFspLXHZzLVwhjWShJbMPGpYhO+XIPc1gLKMDKIepDNM1AY46Uws9YwTaL3xXqsidhlFOX/CBF9Ew+eEUGWdnnb9wPLhM=
X-Gm-Message-State: AOJu0Yx/tAWe8pP56QPdT0DTDgiLAyxeqRkQr0SNhlX/6h4Q1Sc0GIrs
 Vs3zXkvbAq8KKjzFqI2hH+XQQbyyjySuYrhU5vHC7zBQC3HQfebS4JhMhvIGXS6/adKK2Gjcjev
 GTm3Y5y57VwlXYnw8mX9bqUJPRW//grNf/zrCCn1eQXg8iyXE+L96
X-Received: by 2002:a17:903:24f:b0:1fc:2ee3:d460 with SMTP id
 d9443c01a7336-201ca18316bmr24914045ad.35.1723511837375; 
 Mon, 12 Aug 2024 18:17:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEH+8NoaTm5Gx4x/n+o9SzHBmQDPYS6llOsAEijV8IuKeeV3nQuWiFyFBfnuTb+3gX3ciObsw==
X-Received: by 2002:a17:903:24f:b0:1fc:2ee3:d460 with SMTP id
 d9443c01a7336-201ca18316bmr24913655ad.35.1723511836900; 
 Mon, 12 Aug 2024 18:17:16 -0700 (PDT)
Received: from [192.168.68.54] ([103.210.27.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201cd1ba02bsm2779345ad.229.2024.08.12.18.17.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 18:17:16 -0700 (PDT)
Message-ID: <51dc0813-7dc9-4927-a24b-bd718be54e46@redhat.com>
Date: Tue, 13 Aug 2024 11:17:02 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC V3 17/29] arm/virt: Release objects for *disabled*
 possible vCPUs after init
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com, will@kernel.org,
 ardb@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 rafael@kernel.org, borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 npiggin@gmail.com, harshpb@linux.ibm.com, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, shahuang@redhat.com,
 zhao1.liu@intel.com, linuxarm@huawei.com
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-18-salil.mehta@huawei.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240613233639.202896-18-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/14/24 9:36 AM, Salil Mehta wrote:
> During `machvirt_init()`, QOM ARMCPU objects are pre-created along with the
> corresponding KVM vCPUs in the host for all possible vCPUs. This is necessary
> due to the architectural constraint that KVM restricts the deferred creation of
> KVM vCPUs and VGIC initialization/sizing after VM initialization. Hence, VGIC is
> pre-sized with possible vCPUs.
> 
> After the initialization of the machine is complete, the disabled possible KVM
> vCPUs are parked in the per-virt-machine list "kvm_parked_vcpus," and we release
> the QOM ARMCPU objects for the disabled vCPUs. These will be re-created when the
> vCPU is hotplugged again. The QOM ARMCPU object is then re-attached to the
> corresponding parked KVM vCPU.
> 
> Alternatively, we could have chosen not to release the QOM CPU objects and kept
> reusing them. This approach might require some modifications to the
> `qdevice_add()` interface to retrieve the old ARMCPU object instead of creating
> a new one for the hotplug request.
> 
> Each of these approaches has its own pros and cons. This prototype uses the
> first approach (suggestions are welcome!).
> 
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   hw/arm/virt.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 9d33f30a6a..a72cd3b20d 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2050,6 +2050,7 @@ static void virt_cpu_post_init(VirtMachineState *vms, MemoryRegion *sysmem)
>   {
>       CPUArchIdList *possible_cpus = vms->parent.possible_cpus;
>       int max_cpus = MACHINE(vms)->smp.max_cpus;
> +    MachineState *ms = MACHINE(vms);
>       bool aarch64, steal_time;
>       CPUState *cpu;
>       int n;
> @@ -2111,6 +2112,37 @@ static void virt_cpu_post_init(VirtMachineState *vms, MemoryRegion *sysmem)
>               }
>           }
>       }
> +
> +    if (kvm_enabled() || tcg_enabled()) {
> +        for (n = 0; n < possible_cpus->len; n++) {
> +            cpu = qemu_get_possible_cpu(n);
> +
> +            /*
> +             * Now, GIC has been sized with possible CPUs and we dont require
> +             * disabled vCPU objects to be represented in the QOM. Release the
> +             * disabled ARMCPU objects earlier used during init for pre-sizing.
> +             *
> +             * We fake to the guest through ACPI about the presence(_STA.PRES=1)
> +             * of these non-existent vCPUs at VMM/qemu and present these as
> +             * disabled vCPUs(_STA.ENA=0) so that they cant be used. These vCPUs
> +             * can be later added to the guest through hotplug exchanges when
> +             * ARMCPU objects are created back again using 'device_add' QMP
> +             * command.
> +             */
> +            /*
> +             * RFC: Question: Other approach could've been to keep them forever
> +             * and release it only once when qemu exits as part of finalize or
> +             * when new vCPU is hotplugged. In the later old could be released
> +             * for the newly created object for the same vCPU?
> +             */
> +            if (!qemu_enabled_cpu(cpu)) {
> +                CPUArchId *cpu_slot;
> +                cpu_slot = virt_find_cpu_slot(ms, cpu->cpu_index);
> +                cpu_slot->cpu = NULL;
> +                object_unref(OBJECT(cpu));
> +            }
> +        }
> +    }
>   }

It's probably hard to keep those ARMCPU objects forever. First of all, one vCPU
can be hot-added first and then hot-removed afterwards. With those ARMCPU objects
kept forever, the syntax of 'device_add' and 'device_del' become broken at least.
The ideal mechanism would be to avoid instanciating those ARMCPU objects and
destroying them soon. I don't know if ms->possible_cpus->cpus[] can fit and how
much efforts needed.

Thanks,
Gavin

>   
>   static void virt_cpu_set_properties(Object *cpuobj, const CPUArchId *cpu_slot,


