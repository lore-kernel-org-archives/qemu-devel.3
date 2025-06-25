Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9E9C7115C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 08:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uULxG-0003JS-E4; Wed, 25 Jun 2025 04:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uULxE-0003JH-Qo
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 04:58:04 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uULx8-0007au-5O
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 04:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750841878; x=1782377878;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=cNUWp/su5E8gasVSvmBLENE8Yn54Ci8OpCjOk0fFPfg=;
 b=TqCBGE/DAlCE+ntA5EZXeEn/M4K8xWlTawUOfR/8Eb/of+Aya4SZyZZe
 bZdnYwsWro6q70hufzWqZ2nIZ8BmiPSDCfUlZLRgNc8QkdJ/zboFIXwEI
 //Zy6HaUtrkgPvkLfGsNDU6jbPlimuU+Y+PxibUSqo6WFXdS0Z1buc3/L
 TZRS35PZvqXy+VQlys95duujiFtKpXzqFCnCPamYgp45IjROhUL6xmPzY
 V6Xp99igFqin8yonoZ30LjAmOf+EpDeapjOxbADzYVFNLNvKgsc3TzomD
 vKhz+nSrIHT4dj+4LOkn/ISfVSPF/TfdqGyttWtYlPNisiPzhxe2R0Rhb w==;
X-CSE-ConnectionGUID: 1rm9Z5l9S9mqCahXgI5riA==
X-CSE-MsgGUID: E17yHEqQTzaJOnj7l7ExfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="53035123"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; d="scan'208";a="53035123"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2025 01:57:52 -0700
X-CSE-ConnectionGUID: 3U+gfcE6QfKN+X/jTsoDLg==
X-CSE-MsgGUID: JnAz04dgSwStc0XJF9MjTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; d="scan'208";a="151771934"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 25 Jun 2025 01:57:50 -0700
Date: Wed, 25 Jun 2025 17:19:12 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ewan Hai <ewanhai-oc@zhaoxin.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Babu Moger <babu.moger@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Tejus GK <tejus.gk@nutanix.com>, Jason Zeng <jason.zeng@intel.com>,
 Manish Mishra <manish.mishra@nutanix.com>,
 Tao Su <tao1.su@intel.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC 01/10] i386/cpu: Mark CPUID[0x80000005] as reserved for Intel
Message-ID: <aFu/EED7BNJgIXqH@intel.com>
References: <20250423114702.1529340-1-zhao1.liu@intel.com>
 <20250423114702.1529340-2-zhao1.liu@intel.com>
 <fa16f7a8-4917-4731-9d9f-7d4c10977168@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa16f7a8-4917-4731-9d9f-7d4c10977168@zhaoxin.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Just want to confirm with the "lines_per_tag" field, which is related
about how to handle current "assert(lines_per_tag > 0)":

> --- patch prototype start ---
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 7b223642ba..8a17e5ffe9 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2726,6 +2726,66 @@ static const CPUCaches xeon_srf_cache_info = {
>      },
>  };
> 
> +static const CPUCaches yongfeng_cache_info = {
> +    .l1d_cache = &(CPUCacheInfo) {
> +        .type = DATA_CACHE,
> +        .level = 1,
> +        .size = 32 * KiB,
> +        .line_size = 64,
> +        .associativity = 8,
> +        .partitions = 1,
> +        .sets = 64,
> +        .lines_per_tag = 1,

This fits AMD APM, and is fine.

> +        .inclusive = false,
> +        .self_init = true,
> +        .no_invd_sharing = false,
> +        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
> +    },
> +    .l1i_cache = &(CPUCacheInfo) {
> +        .type = INSTRUCTION_CACHE,
> +        .level = 1,
> +        .size = 64 * KiB,
> +        .line_size = 64,
> +        .associativity = 16,
> +        .partitions = 1,
> +        .sets = 64,
> +        .lines_per_tag = 1,

Fine, too.

> +        .inclusive = false,
> +        .self_init = true,
> +        .no_invd_sharing = false,
> +        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
> +    },
> +    .l2_cache = &(CPUCacheInfo) {
> +        .type = UNIFIED_CACHE,
> +        .level = 2,
> +        .size = 256 * KiB,
> +        .line_size = 64,
> +        .associativity = 8,
> +        .partitions = 1,
> +        .sets = 512,
> +        .lines_per_tag = 1,

SDM reserves this field:

For 0x80000006 ECX:

Bits 11-08: Reserved.

So I think this field should be 0, to align with "Reserved".

In this patch:

https://lore.kernel.org/qemu-devel/20250620092734.1576677-9-zhao1.liu@intel.com/

I add an argument (lines_per_tag_supported) in encode_cache_cpuid80000006(),
and for the case that lines_per_tag_supported=false, I assert
"lines_per_tag == 0" to align with "Reserved".

> +        .inclusive = true,
> +        .self_init = true,
> +        .no_invd_sharing = false,
> +        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
> +    },
> +    .l3_cache = &(CPUCacheInfo) {
> +        .type = UNIFIED_CACHE,
> +        .level = 3,
> +        .size = 8 * MiB,
> +        .line_size = 64,
> +        .associativity = 16,
> +        .partitions = 1,
> +        .sets = 8192,
> +        .lines_per_tag = 1,

The 0x80000006 EDX is also reserved in SDM. So I think this field should
be 0, too.

Do you agree?

> +        .self_init = true,
> +        .inclusive = true,
> +        .no_invd_sharing = true,
> +        .complex_indexing = false,
> +        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
> +    },
> +};
> +

