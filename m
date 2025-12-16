Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E484DD5B161
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 06:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVOzT-0008K7-42; Tue, 16 Dec 2025 01:57:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vVOzQ-0008HP-4O
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 01:56:56 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vVOzN-0006xn-Ec
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 01:56:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765868213; x=1797404213;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=j8yryQB033txxGeyLLk9monlZh+L7jep3gLhnqT1j7c=;
 b=jV2Gldp33Er7CwTQIOpGEt3j8Sk7bQlkKu61m6VSLHfZ22uS1QH8aLet
 popjxh/Ph+XE/vcGt53QQzQhPb93UViwrlQfuHrO685McbkkcBb0E4AvO
 glqGfg1TyFeUnoDq3C4aGxtOurRVHdTAOSRgmF+fjJoO5gF/zVQVAZkaD
 Rzkx4JaAC4LQPKlC1pG02C+2q87hgrhukDQEgDFbb+4Oq63f2ImKIOhuA
 WcIHEINr3NvVDf9ftZvC7PV2cBFKanxv5CKYxGxKjIQ9qv71zvAiT68Fk
 zYZ0G5NxoE7fHJeqI7jXS9X3kw9CgV6aWC/gv27CseuH8hLtQyIGHWMfU w==;
X-CSE-ConnectionGUID: bzdeYpn6RNiOpAuULFuPSw==
X-CSE-MsgGUID: rpXZkq65TQ2hyqfDYPMeFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="71634598"
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; d="scan'208";a="71634598"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 22:56:51 -0800
X-CSE-ConnectionGUID: ygaX8e+8SL2sEOucjNGVLA==
X-CSE-MsgGUID: ibCyki0cTvWyojad/OoV4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; d="scan'208";a="228610400"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.173])
 ([10.124.240.173])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 22:56:48 -0800
Message-ID: <faa8ead4-1d74-4765-89dd-46ec62f9c65d@intel.com>
Date: Tue, 16 Dec 2025 14:56:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/12] memory: Rename
 memory_region_init_ram_guest_memfd() to *_private()
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, David Hildenbrand <david@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Fabiano Rosas <farosas@suse.de>, Alexey Kardashevskiy <aik@amd.com>
References: <20251215205203.1185099-1-peterx@redhat.com>
 <20251215205203.1185099-11-peterx@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20251215205203.1185099-11-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

On 12/16/2025 4:52 AM, Peter Xu wrote:
> Differenciate it from fully shared guest-memfd use cases.
> 
> Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   include/system/memory.h | 10 +++++-----
>   backends/igvm.c         |  4 ++--
>   hw/i386/pc.c            |  4 ++--
>   hw/i386/pc_sysfw.c      |  4 ++--
>   hw/i386/x86-common.c    |  4 ++--
>   system/memory.c         | 10 +++++-----
>   6 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/include/system/memory.h b/include/system/memory.h
> index 9b58303bb8..b3d000a563 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -1693,11 +1693,11 @@ bool memory_region_init_ram(MemoryRegion *mr,
>                               uint64_t size,
>                               Error **errp);
>   
> -bool memory_region_init_ram_guest_memfd(MemoryRegion *mr,
> -                                        Object *owner,
> -                                        const char *name,
> -                                        uint64_t size,
> -                                        Error **errp);
> +bool memory_region_init_ram_guest_memfd_private(MemoryRegion *mr,
> +                                                Object *owner,
> +                                                const char *name,
> +                                                uint64_t size,
> +                                                Error **errp);
>   
>   /**
>    * memory_region_init_rom: Initialize a ROM memory region.
> diff --git a/backends/igvm.c b/backends/igvm.c
> index 905bd8d989..91631829e5 100644
> --- a/backends/igvm.c
> +++ b/backends/igvm.c
> @@ -221,8 +221,8 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
>               g_strdup_printf("igvm.%X", region_identifier);
>           igvm_pages = g_new0(MemoryRegion, 1);
>           if (ctx->cgs && ctx->cgs->require_guest_memfd) {
> -            if (!memory_region_init_ram_guest_memfd(igvm_pages, NULL,
> -                                                    region_name, size, errp)) {
> +            if (!memory_region_init_ram_guest_memfd_private(
> +                    igvm_pages, NULL, region_name, size, errp)) {
>                   return NULL;
>               }
>           } else {
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index b2d55ceb5e..41dfbbdcf0 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -963,8 +963,8 @@ void pc_memory_init(PCMachineState *pcms,
>       if (!is_tdx_vm()) {
>           option_rom_mr = g_malloc(sizeof(*option_rom_mr));
>           if (machine_require_guest_memfd_private(machine)) {
> -            memory_region_init_ram_guest_memfd(option_rom_mr, NULL, "pc.rom",
> -                                            PC_ROM_SIZE, &error_fatal);
> +            memory_region_init_ram_guest_memfd_private(
> +                option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE, &error_fatal);
>           } else {
>               memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
>                                   &error_fatal);
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index 1c37258654..ad55d4eba6 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -53,8 +53,8 @@ static void pc_isa_bios_init(PCMachineState *pcms, MemoryRegion *isa_bios,
>       /* map the last 128KB of the BIOS in ISA space */
>       isa_bios_size = MIN(flash_size, 128 * KiB);
>       if (machine_require_guest_memfd_private(MACHINE(pcms))) {
> -        memory_region_init_ram_guest_memfd(isa_bios, NULL, "isa-bios",
> -                                           isa_bios_size, &error_fatal);
> +        memory_region_init_ram_guest_memfd_private(
> +            isa_bios, NULL, "isa-bios", isa_bios_size, &error_fatal);
>       } else {
>           memory_region_init_ram(isa_bios, NULL, "isa-bios", isa_bios_size,
>                                  &error_fatal);
> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> index 33ac7fb6e9..27854a9164 100644
> --- a/hw/i386/x86-common.c
> +++ b/hw/i386/x86-common.c
> @@ -1045,8 +1045,8 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
>           goto bios_error;
>       }
>       if (machine_require_guest_memfd_private(MACHINE(x86ms))) {
> -        memory_region_init_ram_guest_memfd(&x86ms->bios, NULL, "pc.bios",
> -                                           bios_size, &error_fatal);
> +        memory_region_init_ram_guest_memfd_private(
> +            &x86ms->bios, NULL, "pc.bios", bios_size, &error_fatal);
>           if (is_tdx_vm()) {
>               tdx_set_tdvf_region(&x86ms->bios);
>           }
> diff --git a/system/memory.c b/system/memory.c
> index d70968c966..28810dcb29 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -3746,11 +3746,11 @@ bool memory_region_init_ram(MemoryRegion *mr,
>       return true;
>   }
>   
> -bool memory_region_init_ram_guest_memfd(MemoryRegion *mr,
> -                                        Object *owner,
> -                                        const char *name,
> -                                        uint64_t size,
> -                                        Error **errp)
> +bool memory_region_init_ram_guest_memfd_private(MemoryRegion *mr,
> +                                                Object *owner,
> +                                                const char *name,
> +                                                uint64_t size,
> +                                                Error **errp)
>   {
>       DeviceState *owner_dev;
>   


