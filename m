Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3960DC41513
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 21:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUYLh-00039t-UZ; Thu, 18 Jul 2024 17:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sUYLH-000375-AA
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 17:07:13 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sUYLF-0006p5-Lj
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 17:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721336829; x=1752872829;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=6cVAc5ZQ+ZSn/WSm3lNXrMsM9aijcrjimTqBxDauiwg=;
 b=GcxHrB5MWIdS0C9LOdZI5hir+9HQJwXHKxKbsgfhj/GKj3h+vv7ElekO
 MVTQ6v/MB9kTRbtEnAd/FRBXGnevIfYqr9FDABxIoLT8TlkIQ6im0gaPh
 5gpGkXHKhiMuert5UfL9Qb2ItpHn7DCKZtzr/E95yVoYIdgJkV+Zw9qSg
 Oj+XMoT14UmmWftV8w92Jgbx5j4DeH5tipMLHppW9Lqd9sXqrXqlgTBmu
 LUYINRutFXRkNMy0I7r27JcjnjhWh6RVV1bBhGWwQ9ZSr1mWk3olQ/9BB
 nhYjBFoeIzMgs2tTc97mpA+VvTo7DAkEKW7iPsFmGGfTX4RfaDN+I180A Q==;
X-CSE-ConnectionGUID: G6tdLA3aTF+XFneC2m6oDQ==
X-CSE-MsgGUID: bIHkveB7R52z6A95KzObRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="21831327"
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; d="scan'208";a="21831327"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 14:07:04 -0700
X-CSE-ConnectionGUID: ITIjB/xtRYW0Rz8JfsIDzw==
X-CSE-MsgGUID: DuMPHg2MSNuzWZ9IKhMS2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; d="scan'208";a="55178725"
Received: from soc-cp83kr3.jf.intel.com (HELO [10.24.10.107]) ([10.24.10.107])
 by fmviesa005-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 14:07:03 -0700
Message-ID: <5540a8e3-7603-4b14-b7f3-4c0101deb930@intel.com>
Date: Thu, 18 Jul 2024 14:07:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] target/i386/kvm: Remove local MSR_KVM_WALL_CLOCK
 and MSR_KVM_SYSTEM_TIME definitions
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20240716161015.263031-1-zhao1.liu@intel.com>
 <20240716161015.263031-3-zhao1.liu@intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20240716161015.263031-3-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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



On 7/16/2024 9:10 AM, Zhao Liu wrote:
> These 2 MSRs have been already defined in kvm_para.h (standard-headers/
> asm-x86/kvm_para.h).
> 
> Remove QEMU local definitions to avoid duplication.
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>


Reviewed-by: zide.chen@intel.com

> ---
>  target/i386/kvm/kvm.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 86e42beb78bf..6ad5a7dbf1fd 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -81,9 +81,6 @@
>  #define KVM_APIC_BUS_CYCLE_NS       1
>  #define KVM_APIC_BUS_FREQUENCY      (1000000000ULL / KVM_APIC_BUS_CYCLE_NS)
>  
> -#define MSR_KVM_WALL_CLOCK  0x11
> -#define MSR_KVM_SYSTEM_TIME 0x12
> -
>  /* A 4096-byte buffer can hold the 8-byte kvm_msrs header, plus
>   * 255 kvm_msr_entry structs */
>  #define MSR_BUF_SIZE 4096

