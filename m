Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5ECFC3DA47
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 08:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRp1f-00054r-SI; Thu, 11 Jul 2024 04:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRp1a-0004oe-H0
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 04:19:35 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRp1Y-00087n-E9
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 04:19:34 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a77abe5c709so76068166b.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 01:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720685970; x=1721290770; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ea5Op6ysHo6KPTidjpLEO40hv2IOq8vsoA7M44HqG7U=;
 b=UpIIltXmST+u/3Pu5WRrp0lt59HEyGvr2vjFHVEHhgd+V1oXV5oHbWnsqEz7YVsQ23
 yQyuKY6P5t+11qfZHH5u900BaN2rvmIP2AK6H8bJIncsKZf8fTC46Y8nHwucv4SLkpHM
 8ErB3eUeuNKpErKwyeX1CDsTE2AOvmDDuwXqYsd1Ll3C8PYs2k7ZFEAeVQPAWHGQzfgZ
 0VxBwvhEniJbF2ofjBiJgDO5Ajq5GNOusUJPIc6yFyrZMsno/A1KC8yC1cr8R3uvtbCz
 0LA7LWlNjIOfOte9k74qzt11eAwkwDPAtExGiuYh3JIlBUV7EFWVVoNj17PMC1t8fqWr
 O2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720685970; x=1721290770;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ea5Op6ysHo6KPTidjpLEO40hv2IOq8vsoA7M44HqG7U=;
 b=i06eBinfZsaNI/GXdzfI9wgtDPJoA15RCZjlroMX+xbARhWmP+wHqxgHngEt10hFzl
 /wGgxMrkXr8BmyN1NYKJBmsUefA6yUMTpKNWCFi0JvXk1X5Mb3xLDfY5fi5EWHmw9nP/
 nkF0QswqlV1CctGjY1goICrrGqxzZouSRr4SHtXRx7VN1XIa2TuhXkC3iaC+sb/hv7O/
 6cTi6Ae91/uPMy3n/EbjuNXJeRjpxe/93OQKaaYNqtFtbtMF99EvOyaYVQRCAAo770w2
 rdmra5fv+ziie5+FE2ZU1CprTiXZh3N1b1mHyemk4cXX325g0dfOvzpiLEj1fgLa2ohD
 U5BQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgcOIltq5nn1GJ1VOo+05aSAiqY79n7MhFtCYzc16lxT8ib1hGvSMIn7PVI39ezFIvkS9OxXgPqmDDhZ7t3wyt9Vg7Sl4=
X-Gm-Message-State: AOJu0YwZyRKxJ2sQ2tGro3hUn8k3yBz/SNn36NzVzP8gAYmc0fhwKuBR
 ZqCjQGQRKcths93f1FHQ9kr5jffjG+FSisEBxvdO8R6Vbu+hQva149pFCbNycTQ=
X-Google-Smtp-Source: AGHT+IH7Hg38SpweX70oAp9OYU/WtNdmqrgQUIrNYhUTZH50Kw2QDhlyZadpVo4v5RqvgNHtR8SBww==
X-Received: by 2002:a17:906:c141:b0:a77:c26c:a56f with SMTP id
 a640c23a62f3a-a780b68832fmr634201366b.3.1720685970442; 
 Thu, 11 Jul 2024 01:19:30 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.207.127])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a86f620sm233028166b.209.2024.07.11.01.19.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jul 2024 01:19:29 -0700 (PDT)
Message-ID: <d921c3d3-71a9-49e4-9f28-1ff3f19b9c48@linaro.org>
Date: Thu, 11 Jul 2024 10:19:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smbios: make memory device size configurable per Machine
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, mst@redhat.com, wangyanan55@huawei.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, anisinha@redhat.com,
 qemu-arm@nongnu.org
References: <20240711074822.3384344-1-imammedo@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240711074822.3384344-1-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

Hi Igor,

On 11/7/24 09:48, Igor Mammedov wrote:
> Currently SMBIOS maximum memory device chunk is capped at 16Gb,
> which is fine for the most cases (QEMU uses it to describe initial
> RAM (type 17 SMBIOS table entries)).
> However when starting guest with terabytes of RAM this leads to
> too many memory device structures, which eventually upsets linux
> kernel as it reserves only 64K for these entries and when that
> border is crossed out it runs out of reserved memory.
> 
> Instead of partitioning initial RAM on 16Gb chunks, use maximum
> possible chunk size that SMBIOS spec allows[1]. Which lets
> encode RAM in Mb units in uint32_t-1 field (upto 2047Tb).
> As result initial RAM will generate only one type 17 structure
> until host/guest reach ability to use more RAM in the future.
> 
> Compat changes:
> We can't unconditionally change chunk size as it will break
> QEMU<->guest ABI (and migration). Thus introduce a new machine class
> field that would let older versioned machines to use 16Gb chunks
> while new machine type could use maximum possible chunk size.
> 
> While it might seem to be risky to rise max entry size this much
> (much beyond of what current physical RAM modules support),
> I'd not expect it causing much issues, modulo uncovering bugs
> in software running within guest. And those should be fixed
> on guest side to handle SMBIOS spec properly, especially if
> guest is expected to support so huge RAM configs.
> In worst case, QEMU can reduce chunk size later if we would
> care enough about introducing a workaround for some 'unfixable'
> guest OS, either by fixing up the next machine type or
> giving users a CLI option to customize it.
> 
> 1) SMBIOS 3.1.0 7.18.5 Memory Device — Extended Size
> 
> PS:
> * tested on 8Tb host with RHEL6 guest, which seems to parse
>    type 17 SMBIOS table entries correctly (according to 'dmidecode').
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   include/hw/boards.h |  4 ++++
>   hw/arm/virt.c       |  1 +
>   hw/core/machine.c   |  1 +
>   hw/i386/pc_piix.c   |  1 +
>   hw/i386/pc_q35.c    |  1 +
>   hw/smbios/smbios.c  | 11 ++++++-----
>   6 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index ef6f18f2c1..48ff6d8b93 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -237,6 +237,9 @@ typedef struct {
>    *    purposes only.
>    *    Applies only to default memory backend, i.e., explicit memory backend
>    *    wasn't used.
> + * @smbios_memory_device_size:
> + *    Default size of memory device,
> + *    SMBIOS 3.1.0 "7.18 Memory Device (Type 17)"
>    */
>   struct MachineClass {
>       /*< private >*/
> @@ -304,6 +307,7 @@ struct MachineClass {
>       const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
>       int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
>       ram_addr_t (*fixup_ram_size)(ram_addr_t size);
> +    uint64_t smbios_memory_device_size;

Quick notes since I'm on holidays (not meant to block this patch):

- How will evolve this machine class property in the context of
   a heterogeneous machine (i.e. x86_64 cores and 1 riscv32 one)?

- Should this become a SmbiosProviderInterface later?

>   };
>   
>   /**
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index b0c68d66a3..719e83e6a1 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3308,6 +3308,7 @@ DEFINE_VIRT_MACHINE_AS_LATEST(9, 1)
>   static void virt_machine_9_0_options(MachineClass *mc)
>   {
>       virt_machine_9_1_options(mc);
> +    mc->smbios_memory_device_size = 16 * GiB;
>       compat_props_add(mc->compat_props, hw_compat_9_0, hw_compat_9_0_len);
>   }
>   DEFINE_VIRT_MACHINE(9, 0)

[...]

