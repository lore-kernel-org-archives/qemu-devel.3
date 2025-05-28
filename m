Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6032BC54ED1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 01:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK64P-0001ak-33; Tue, 27 May 2025 21:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uK64M-0001Zr-QY; Tue, 27 May 2025 21:59:02 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uK64L-0003OA-2i; Tue, 27 May 2025 21:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748397541; x=1779933541;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=1StEo5nRA8GudZGw+dnXrMLvUWF7ItYI6wYOliwE1PA=;
 b=WOcYX7M6Gq0uy6F6RBp4FSz8ccC3WB8mgPt1hF2VXbFL5dSI3VRe/5vJ
 C6Q1lNAo3KVEdZbGkS8NzbWhjt6AOO2DFkKkBPZS0lVrNzLF+mdeOlslv
 JJhZBzjxu/3/HxtLbuwQAlc23Az+mnjoFd/yZsyhyQ8AOUFOfT3xVR8B+
 9bAyjbzKV7j/Tk4bpDrXiT9St/zoOAMtA2NNyhcJHKYo83PutJzcEQZtF
 hLBypTuRjenGKSvQu5ds62XJ7fygplf8pA+qrKZbGlGtnfITuNq0i7WO9
 GVKtQDcukiKTd3dUOC/vhJ1xtebXl5ZbOoTb/yZP/c2eRhvST/Iuuy+Ol g==;
X-CSE-ConnectionGUID: 7sMn37+KQwyf1M4J+f4hdw==
X-CSE-MsgGUID: TAWE+1PzQ2KkJkX93nghCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50563667"
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; d="scan'208";a="50563667"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 18:58:59 -0700
X-CSE-ConnectionGUID: 2jqltp5rQrmEgMzQFS7rCg==
X-CSE-MsgGUID: 6FPpUK/kScWBz5TqruZd4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; d="scan'208";a="143404351"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 18:58:54 -0700
Message-ID: <cb34e13d-2920-461d-8509-8b529d69d599@intel.com>
Date: Wed, 28 May 2025 09:58:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/19] hw/i386/pc: Remove
 PCMachineClass::broken_reserved_end field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20250512083948.39294-1-philmd@linaro.org>
 <20250512083948.39294-3-philmd@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250512083948.39294-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/12/2025 4:39 PM, Philippe Mathieu-Daudé wrote:
> The PCMachineClass::broken_reserved_end field was only used
> by the pc-q35-2.4 and pc-i440fx-2.4 machines, which got removed.
> Remove it and simplify pc_memory_init().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   include/hw/i386/pc.h |  1 -
>   hw/i386/pc.c         | 13 +++++--------
>   2 files changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 9563674e2da..f4a874b17fc 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -107,7 +107,6 @@ struct PCMachineClass {
>       /* RAM / address space compat: */
>       bool gigabyte_align;
>       bool has_reserved_memory;
> -    bool broken_reserved_end;
>       bool enforce_amd_1tb_hole;
>       bool isa_bios_alias;
>   
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 70656157ca0..c8bb4a3ee47 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -999,14 +999,13 @@ void pc_memory_init(PCMachineState *pcms,
>   
>       if (machine->device_memory) {
>           uint64_t *val = g_malloc(sizeof(*val));
> -        uint64_t res_mem_end = machine->device_memory->base;
> -
> -        if (!pcmc->broken_reserved_end) {
> -            res_mem_end += memory_region_size(&machine->device_memory->mr);
> -        }
> +        uint64_t res_mem_end;
>   
>           if (pcms->cxl_devices_state.is_enabled) {
>               res_mem_end = cxl_resv_end;
> +        } else {
> +            res_mem_end = machine->device_memory->base
> +                          + memory_region_size(&machine->device_memory->mr);
>           }
>           *val = cpu_to_le64(ROUND_UP(res_mem_end, 1 * GiB));
>           fw_cfg_add_file(fw_cfg, "etc/reserved-memory-end", val, sizeof(*val));
> @@ -1044,9 +1043,7 @@ uint64_t pc_pci_hole64_start(void)
>           hole64_start = pc_get_cxl_range_end(pcms);
>       } else if (pcmc->has_reserved_memory && (ms->ram_size < ms->maxram_size)) {
>           pc_get_device_memory_range(pcms, &hole64_start, &size);
> -        if (!pcmc->broken_reserved_end) {
> -            hole64_start += size;
> -        }
> +        hole64_start += size;
>       } else {
>           hole64_start = pc_above_4g_end(pcms);
>       }


