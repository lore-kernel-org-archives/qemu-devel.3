Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC55C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 04:14:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXXoK-0005c2-03; Fri, 04 Jul 2025 00:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uXXoE-0005bg-Ly
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 00:13:59 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uXXoC-0002aT-R5
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 00:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751602437; x=1783138437;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=WW4JhfCET1Sp90wLio3HHFQ+bDrMu9NujLYRN0qFqT0=;
 b=UOrdIUQkQkOy9MXdXojpP8fB2kSRvoXcqqggxaDatCao2pGkzgq2ZXWT
 bsIN6X/wgk2C1u14wWyNdWqLmt7gwLYEZAxZKFkPsz1eztzAc2jItVvlB
 jowtbQiwSR6VxLvqnjFoTKigEdT33L6TPv3KQlum7EZwfRwocPK/DO4AU
 u0R4pCRjadvo0VbqtdLi0aK6wbXJhB+0BiZPiOZw5okbJAE58gyC+HCEu
 M7BXaUMG72+5oOLqSDtEx+xFOhvzPdU9LEDt96nUr3vtJJQOKv0UezzU6
 WaH37zFQDIj600Aiq2TiSwt05aUuzMNGk6yXj7pJRz3IPfuD6q8k6mrkI Q==;
X-CSE-ConnectionGUID: VdHwzv2jR/iFucL/0vof+w==
X-CSE-MsgGUID: +78qwoTgQs2MiyGJb0eV7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="41564558"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="41564558"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 21:13:53 -0700
X-CSE-ConnectionGUID: 9+K3I0TFTUuTrejo80dy3A==
X-CSE-MsgGUID: z8wN8IV5RjGk5fy8aWpdtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="185564976"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 21:13:51 -0700
Message-ID: <9292a723-eb6f-4106-bbf4-e046146686e4@intel.com>
Date: Fri, 4 Jul 2025 12:13:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/39] accel/kvm: Remove kvm_init_cpu_signals() stub
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, kvm@vger.kernel.org
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-6-philmd@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250703173248.44995-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/4/2025 1:32 AM, Philippe Mathieu-Daudé wrote:
> Since commit 57038a92bb0 ("cpus: extract out kvm-specific code
> to accel/kvm") the kvm_init_cpu_signals() stub is not necessary.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

BTW, it seems we can further move kvm_init_cpu_signals() into
kvm-accel-ops.c and make it internal static function?

> ---
>   accel/stubs/kvm-stub.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
> index ecfd7636f5f..b9b4427c919 100644
> --- a/accel/stubs/kvm-stub.c
> +++ b/accel/stubs/kvm-stub.c
> @@ -105,11 +105,6 @@ unsigned int kvm_get_free_memslots(void)
>       return 0;
>   }
>   
> -void kvm_init_cpu_signals(CPUState *cpu)
> -{
> -    abort();
> -}
> -
>   bool kvm_arm_supports_user_irq(void)
>   {
>       return false;


