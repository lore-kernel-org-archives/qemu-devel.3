Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8D2D5B87C
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 05:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVO0s-0004uU-LV; Tue, 16 Dec 2025 00:54:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vVO0o-0004uA-Oe
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 00:54:18 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vVO0l-0006JY-73
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 00:54:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765864455; x=1797400455;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=xjBrYnh2u20ZvTq0WpXafZX+PFr9vPKzwr8nnZFrm5Y=;
 b=L9473mQB3ZYqkmFUpAf8vNmNa1g/SOtB2R1NsL69tyPGnlh3Evc9uj+k
 h65pwpi8vls4O+67cNRR2YHVlcYr12ueZJjqj5708NKDTMFo28G4Bss/t
 hXenKxUhaMXl2cQvGGinpreAdbctzSQkJ4v+mXx4p2cfqlOQO1Tqq51vg
 9xsyl6dlvrldxlLb7FU0Pj40w9heXA92/5523STLxjq/yE7EmUfNxo9QS
 zpGOj9gaW9n6p0XYODyzfceQOfNqiGXXp+L5np2ljAYZivScIueIzzXPA
 BpccRmVhL0/0ig0Yq4/NDXTZHxr9XwfAwQcevabK80KC1syK2OC8nwYuw Q==;
X-CSE-ConnectionGUID: N9+2TSbPRw++gc6uCCerww==
X-CSE-MsgGUID: pQhwSZmQSPOZSiWHkPqA+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="78894054"
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; d="scan'208";a="78894054"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 21:54:12 -0800
X-CSE-ConnectionGUID: HRuCZs+0QxacwCVMqlx/wg==
X-CSE-MsgGUID: tYhgy4ABR3KdqV9LG/pgXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; d="scan'208";a="197022513"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.173])
 ([10.124.240.173])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 21:54:10 -0800
Message-ID: <47846187-3ffa-46a2-8b5a-56e0d2308ea9@intel.com>
Date: Tue, 16 Dec 2025 13:54:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/12] hostmem: Rename guest_memfd to
 guest_memfd_private
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, David Hildenbrand <david@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Fabiano Rosas <farosas@suse.de>, Alexey Kardashevskiy <aik@amd.com>
References: <20251215205203.1185099-1-peterx@redhat.com>
 <20251215205203.1185099-8-peterx@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20251215205203.1185099-8-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=xiaoyao.li@intel.com;
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

On 12/16/2025 4:51 AM, Peter Xu wrote:
> Rename the HostMemoryBackend.guest_memfd field to reflect what it really
> means, on whether it needs guest_memfd to back its private portion of
> mapping.  This will help on clearance when we introduce in-place
> guest_memfd for hostmem.

fix the term of "in-place"?

Other than it,

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/system/hostmem.h | 2 +-
>   backends/hostmem-file.c  | 2 +-
>   backends/hostmem-memfd.c | 2 +-
>   backends/hostmem-ram.c   | 2 +-
>   backends/hostmem-shm.c   | 2 +-
>   backends/hostmem.c       | 2 +-
>   6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/system/hostmem.h b/include/system/hostmem.h
> index 88fa791ac7..dcbf81aeae 100644
> --- a/include/system/hostmem.h
> +++ b/include/system/hostmem.h
> @@ -76,7 +76,7 @@ struct HostMemoryBackend {
>       uint64_t size;
>       bool merge, dump, use_canonical_path;
>       bool prealloc, is_mapped, share, reserve;
> -    bool guest_memfd, aligned;
> +    bool guest_memfd_private, aligned;
>       uint32_t prealloc_threads;
>       ThreadContext *prealloc_context;
>       DECLARE_BITMAP(host_nodes, MAX_NODES + 1);
> diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> index 1f20cd8fd6..0e4cfd6dc6 100644
> --- a/backends/hostmem-file.c
> +++ b/backends/hostmem-file.c
> @@ -86,7 +86,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>       ram_flags |= fb->readonly ? RAM_READONLY_FD : 0;
>       ram_flags |= fb->rom == ON_OFF_AUTO_ON ? RAM_READONLY : 0;
>       ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
> -    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD_PRIVATE : 0;
> +    ram_flags |= backend->guest_memfd_private ? RAM_GUEST_MEMFD_PRIVATE : 0;
>       ram_flags |= fb->is_pmem ? RAM_PMEM : 0;
>       ram_flags |= RAM_NAMED_FILE;
>       return memory_region_init_ram_from_file(&backend->mr, OBJECT(backend), name,
> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> index 3f3e485709..ea93f034e4 100644
> --- a/backends/hostmem-memfd.c
> +++ b/backends/hostmem-memfd.c
> @@ -60,7 +60,7 @@ have_fd:
>       backend->aligned = true;
>       ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
>       ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
> -    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD_PRIVATE : 0;
> +    ram_flags |= backend->guest_memfd_private ? RAM_GUEST_MEMFD_PRIVATE : 0;
>       return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend), name,
>                                             backend->size, ram_flags, fd, 0, errp);
>   }
> diff --git a/backends/hostmem-ram.c b/backends/hostmem-ram.c
> index 96ad29112d..6a507fad77 100644
> --- a/backends/hostmem-ram.c
> +++ b/backends/hostmem-ram.c
> @@ -30,7 +30,7 @@ ram_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>       name = host_memory_backend_get_name(backend);
>       ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
>       ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
> -    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD_PRIVATE : 0;
> +    ram_flags |= backend->guest_memfd_private ? RAM_GUEST_MEMFD_PRIVATE : 0;
>       return memory_region_init_ram_flags_nomigrate(&backend->mr, OBJECT(backend),
>                                                     name, backend->size,
>                                                     ram_flags, errp);
> diff --git a/backends/hostmem-shm.c b/backends/hostmem-shm.c
> index e86fb2e0aa..4766db6aad 100644
> --- a/backends/hostmem-shm.c
> +++ b/backends/hostmem-shm.c
> @@ -54,7 +54,7 @@ have_fd:
>       /* Let's do the same as memory-backend-ram,share=on would do. */
>       ram_flags = RAM_SHARED;
>       ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
> -    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD_PRIVATE : 0;
> +    ram_flags |= backend->guest_memfd_private ? RAM_GUEST_MEMFD_PRIVATE : 0;
>   
>       return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend),
>                                                 backend_name, backend->size,
> diff --git a/backends/hostmem.c b/backends/hostmem.c
> index 35734d6f4d..70450733db 100644
> --- a/backends/hostmem.c
> +++ b/backends/hostmem.c
> @@ -288,7 +288,7 @@ static void host_memory_backend_init(Object *obj)
>       /* TODO: convert access to globals to compat properties */
>       backend->merge = machine_mem_merge(machine);
>       backend->dump = machine_dump_guest_core(machine);
> -    backend->guest_memfd = machine_require_guest_memfd(machine);
> +    backend->guest_memfd_private = machine_require_guest_memfd(machine);
>       backend->reserve = true;
>       backend->prealloc_threads = machine->smp.cpus;
>   }


