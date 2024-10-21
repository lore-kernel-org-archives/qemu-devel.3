Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D14D3C92F
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 02:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2hrl-00069S-0O; Sun, 20 Oct 2024 22:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1t2hrj-00068a-Np
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 22:09:51 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1t2hrh-0001dA-VB
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 22:09:51 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20ce65c8e13so34155215ad.1
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 19:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729476588; x=1730081388; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t+B5k0OIf9JD/kCuC10w5oEnui5YaC88U76aEr+T5BY=;
 b=S347osnNSM8lHU7DR0qv0hnLXOgQteKLXj56MLSvFYRZOQQzwFVFxwsl5hXmHV+4Zk
 4LUlcsNOnRWansFLWok6n0EyoL2SkIq/xwEl6Jay2Bj/U4ivH//ZMoaeS74Uiconxchj
 35vZKiewhQjcEoBKYDITDCvQEiyxoewM53S07J788vMhqCzjcEAUJNtRbv9X6pe9+snS
 WskXIXFaQdKo7p7u0efP+yJ5b3WKhpoihaZ5XyML5pEF1v/anJdJqmkf1l3RHSkiWsdo
 Wgov5+bgKF5XECmqGxoZtMy1J0f3Y3Ab/zD/YVZAexIArH0Yc33cvL8t8YkFfQd85VjR
 7PeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729476588; x=1730081388;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t+B5k0OIf9JD/kCuC10w5oEnui5YaC88U76aEr+T5BY=;
 b=akRiv/mWhESB9V+5Nb8F55TD1kMtOxNOeewpfxpic5pN6/Uc7AsytTCDUSpf1Drzoz
 gfU4Bb/9nt0SGlXvRQxWLqHeKA0g12OPihoOVsF+R6NcY6qvF8QME6M7kE+xZIu8TqPh
 mKUBhbetPUbAPBJs9N7sq1awty5Omg19vq9EvsR21s2/aKLHjK0GPZBI6QKzTErN6eIe
 /fFlYQUFafh0TwLDzAt/NUwNFReAGMqilYb3P0tGikdP5dsn2THDPEhXFaYkBrcGokQT
 V9s9m37p5gCU/27YnY9y9ulnzIS1RsZW9CAW4FyBGJo2MrLCZ4bk0pG+At5RtSKNdOFI
 9uzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVevWuPX9paLm4fRWRVmDlXSGKh+OMLBMdm8WkQi8EY+vhKo5G7PAsnoHwsRWJN6HMnY+mQ+3EK7ayg@nongnu.org
X-Gm-Message-State: AOJu0YwR43x5tzphxxvFSMKlbck9NXAn7sirvFQTh6fOkx7E4+YApZvO
 Llgh8hcLpXO4EkfL5UHibshxWqxNXgS/25c/mzJUdq5oa7wP8Glf3B1fN/k5ro4=
X-Google-Smtp-Source: AGHT+IFSPN/N8NU7wAYTx1hTZ3wa3ZfNOxByIPkQJZLgNgoOOvwgKGcb7UA/LYVie5Zh5e87Xv/X/g==
X-Received: by 2002:a17:903:40ce:b0:205:709e:1949 with SMTP id
 d9443c01a7336-20e5aaab6camr108995705ad.57.1729476587944; 
 Sun, 20 Oct 2024 19:09:47 -0700 (PDT)
Received: from [192.168.0.102] ([187.121.94.4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7eee622dsm15941015ad.6.2024.10.20.19.09.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Oct 2024 19:09:47 -0700 (PDT)
Message-ID: <700f6b4b-e609-42fe-afaf-e9ea62a049e1@linaro.org>
Date: Sun, 20 Oct 2024 23:09:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 3/4] hw/acpi: Reflect ACPI vCPU {present,enabled}
 states in ACPI _STA.{PRES,ENA} Bits
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
References: <20241014192205.253479-1-salil.mehta@huawei.com>
 <20241014192205.253479-4-salil.mehta@huawei.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20241014192205.253479-4-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x635.google.com
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

Hi Salil,

On 10/14/24 16:22, Salil Mehta wrote:
> Reflect the ACPI CPU hotplug `is_{present, enabled}` states in the `_STA.PRES`
> (presence) and `_STA.ENA` (enabled) bits when the guest kernel evaluates the
> ACPI `_STA` method during initialization, as well as when vCPUs are hot-plugged
> or hot-unplugged. The presence of unplugged vCPUs may need to be deliberately
> *simulated* at the ACPI level to maintain a *persistent* view of vCPUs for the
> guest kernel.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   hw/acpi/cpu.c | 26 ++++++++++++++++++++++----
>   1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index 700aa855e9..23ea2b9c70 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -63,10 +63,11 @@ static uint64_t cpu_hotplug_rd(void *opaque, hwaddr addr, unsigned size)
>       cdev = &cpu_st->devs[cpu_st->selector];
>       switch (addr) {
>       case ACPI_CPU_FLAGS_OFFSET_RW: /* pack and return is_* fields */
> -        val |= cdev->cpu ? 1 : 0;
> +        val |= cdev->is_enabled ? 1 : 0;
>           val |= cdev->is_inserting ? 2 : 0;
>           val |= cdev->is_removing  ? 4 : 0;
>           val |= cdev->fw_remove  ? 16 : 0;
> +        val |= cdev->is_present ? 32 : 0;
>           trace_cpuhp_acpi_read_flags(cpu_st->selector, val);
>           break;
>       case ACPI_CPU_CMD_DATA_OFFSET_RW:
> @@ -376,6 +377,7 @@ const VMStateDescription vmstate_cpu_hotplug = {
>   #define CPU_REMOVE_EVENT  "CRMV"
>   #define CPU_EJECT_EVENT   "CEJ0"
>   #define CPU_FW_EJECT_EVENT "CEJF"
> +#define CPU_PRESENT       "CPRS"
>   
>   void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>                       build_madt_cpu_fn build_madt_cpu, hwaddr base_addr,
> @@ -436,7 +438,9 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>           aml_append(field, aml_named_field(CPU_EJECT_EVENT, 1));
>           /* tell firmware to do device eject, write only */
>           aml_append(field, aml_named_field(CPU_FW_EJECT_EVENT, 1));
> -        aml_append(field, aml_reserved_field(3));
> +        /* 1 if present, read only */
> +        aml_append(field, aml_named_field(CPU_PRESENT, 1));
> +        aml_append(field, aml_reserved_field(2));
>           aml_append(field, aml_named_field(CPU_COMMAND, 8));
>           aml_append(cpu_ctrl_dev, field);
>   
> @@ -466,6 +470,7 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>           Aml *ctrl_lock = aml_name("%s.%s", cphp_res_path, CPU_LOCK);
>           Aml *cpu_selector = aml_name("%s.%s", cphp_res_path, CPU_SELECTOR);
>           Aml *is_enabled = aml_name("%s.%s", cphp_res_path, CPU_ENABLED);
> +        Aml *is_present = aml_name("%s.%s", cphp_res_path, CPU_PRESENT);
>           Aml *cpu_cmd = aml_name("%s.%s", cphp_res_path, CPU_COMMAND);
>           Aml *cpu_data = aml_name("%s.%s", cphp_res_path, CPU_DATA);
>           Aml *ins_evt = aml_name("%s.%s", cphp_res_path, CPU_INSERT_EVENT);
> @@ -494,13 +499,26 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>           {
>               Aml *idx = aml_arg(0);
>               Aml *sta = aml_local(0);
> +            Aml *ifctx2;
> +            Aml *else_ctx;
>   
>               aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
>               aml_append(method, aml_store(idx, cpu_selector));
>               aml_append(method, aml_store(zero, sta));
> -            ifctx = aml_if(aml_equal(is_enabled, one));
> +            ifctx = aml_if(aml_equal(is_present, one));
>               {
> -                aml_append(ifctx, aml_store(aml_int(0xF), sta));
> +                ifctx2 = aml_if(aml_equal(is_enabled, one));
> +                {
> +                    /* cpu is present and enabled */
> +                    aml_append(ifctx2, aml_store(aml_int(0xF), sta));
> +                }
> +                aml_append(ifctx, ifctx2);
> +                else_ctx = aml_else();
> +                {
> +                    /* cpu is present but disabled */
> +                    aml_append(else_ctx, aml_store(aml_int(0xD), sta));

Here, the return value for _STA method is set to reflect the state of
CPU_PRESENT and CPU_ENABLED fields. I can't see these two fields being
mapped to AcpiCpuStatus.{is_present,is_enabled}. They look to be mapped
to the MMIO region (base_addr), which doesn't mapped to AcpiCpuStatus
afaics. So where CPU_PRESENT and CPU_ENABLED are set and where exactly
they reside?


Cheers,
Gustavo

> +                }
> +                aml_append(ifctx, else_ctx);
>               }
>               aml_append(method, ifctx);
>               aml_append(method, aml_release(ctrl_lock));


