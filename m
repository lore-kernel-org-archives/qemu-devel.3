Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C3CD3E79C
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 07:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTavF-0007lv-PY; Thu, 11 Dec 2025 02:17:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vTav7-0007ie-Ac
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 02:17:04 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vTav5-0005aD-Mo
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 02:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765437419; x=1796973419;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=FU8vQFRtOB32I121ma5YgpTLzF6J8irVB7WpauculiI=;
 b=AlO7bVewG9v1yZUugrxyfkG5dCpdM0hFzZkhgNDW8l6mgfo4IpXw8oj4
 T2S8re66LmQ7hyp4vWL7N+sPNebi46IF4HHsw52R9FHliS/6bzV8I0QGm
 cmINBvaMfn1bW59JwS6wlmaUva93ZOXY9e0bSdEqw/AzP8smkCDp4cVEJ
 QKW1Lw3FV6KyBCVoq2wsAFR+b10hAgoFVclSS08q6dgwgweChv7TaMekc
 3RBeCBdQi0tP+G6iRavX5Sa6jpCDeAAVjij911IGP33D6STzz8BJMJYBz
 wh9KpFEKCFQFb1NVWXWiqhbxOod3o/aUWbeb8itZ9VcZ1JlLywNYVLbna Q==;
X-CSE-ConnectionGUID: AFfo1XCYT8yJFFZnWykeZw==
X-CSE-MsgGUID: H05Eu9uQQ66ZfNNOWPn80A==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="84823014"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="84823014"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 23:16:56 -0800
X-CSE-ConnectionGUID: UVN3wqDeT5aT1xRuLHtatg==
X-CSE-MsgGUID: V5dBTwp5Q/aGcETBrPs8Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="197213806"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.173])
 ([10.124.240.173])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 23:16:54 -0800
Message-ID: <4305e09e-60e1-4ba1-b8ac-d4e562cc5455@intel.com>
Date: Thu, 11 Dec 2025 15:16:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] hostmem: Rename guest_memfd to guest_memfd_private
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand
 <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20251119172913.577392-1-peterx@redhat.com>
 <20251119172913.577392-7-peterx@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20251119172913.577392-7-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=xiaoyao.li@intel.com;
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

On 11/20/2025 1:29 AM, Peter Xu wrote:
> Rename the HostMemoryBackend.guest_memfd field to reflect what it really
> means, on whether it needs guest_memfd to back its private portion of
> mapping.  This will help on clearance when we introduce in-place
> guest_memfd for hostmem.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

<...>

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

btw, how about a separate patch to rename

machine_require_guest_memfd() to machine_require_guest_memfd_private()?

and another patch to rename memory_region_init_ram_guest_memfd()?

>       backend->reserve = true;
>       backend->prealloc_threads = machine->smp.cpus;
>   }


