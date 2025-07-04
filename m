Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA1CC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 04:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXXpX-0006Hs-9M; Fri, 04 Jul 2025 00:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uXXpP-0006HP-Rl
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 00:15:11 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uXXpN-0002uy-VT
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 00:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751602510; x=1783138510;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=j0T+n+kKsiIh9zeZR3+iPsUcnO8aKeIWUB4OkExJkJ0=;
 b=b1QPmDqoy5IUTVaoPbh8bvSy0yx3/IAqAjAdwD7PQQUQgFE6HZNhSx4t
 jyDClE/seR3NubduVua0dL8/KhFV7/jKPaXftrM06nb2m09jXadcHOaFM
 nLMQZx8U/QPEFMfLP9DuZwSTRD3sjnKK8ylvLj2Pqy/2ZWxMbiJZ1jV1s
 yI392IXz4p5DBJ/oQ5Slnuwf+b+3hS9BVdYQi3x4uyZR4WxRR5rATgPHU
 AnUcm5L8YUGXEUGS8NRIM7zrNWTywouPinVJxsnzgtYtgMtLs+O0nroQt
 LP6my5ugvCOYOGOYscLrBh8dJ8SKb39fl2dRMGw1uDkMp0I+vMng4Gb2D A==;
X-CSE-ConnectionGUID: U564y7gGSV2raoXnjFc9cg==
X-CSE-MsgGUID: A1LNMgDfTkuc9PTq8tGhMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53065833"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="53065833"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 21:15:07 -0700
X-CSE-ConnectionGUID: SEjW+rTUTtOAdAeKZLnBDA==
X-CSE-MsgGUID: RM4jtmsxSIahEuNb+ZFZjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="154191252"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 21:15:05 -0700
Message-ID: <d3b19880-f294-4506-be3d-1543c2cfe0d9@intel.com>
Date: Fri, 4 Jul 2025 12:15:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/39] accel/kvm: Reduce kvm_create_vcpu() declaration
 scope
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, kvm@vger.kernel.org
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-7-philmd@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250703173248.44995-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=xiaoyao.li@intel.com;
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
> kvm_create_vcpu() is only used within the same file unit.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   include/system/kvm.h | 8 --------
>   accel/kvm/kvm-all.c  | 8 +++++++-
>   2 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/include/system/kvm.h b/include/system/kvm.h
> index 7cc60d26f24..e943df2c09d 100644
> --- a/include/system/kvm.h
> +++ b/include/system/kvm.h
> @@ -316,14 +316,6 @@ int kvm_create_device(KVMState *s, uint64_t type, bool test);
>    */
>   bool kvm_device_supported(int vmfd, uint64_t type);
>   
> -/**
> - * kvm_create_vcpu - Gets a parked KVM vCPU or creates a KVM vCPU
> - * @cpu: QOM CPUState object for which KVM vCPU has to be fetched/created.
> - *
> - * @returns: 0 when success, errno (<0) when failed.
> - */
> -int kvm_create_vcpu(CPUState *cpu);
> -
>   /**
>    * kvm_park_vcpu - Park QEMU KVM vCPU context
>    * @cpu: QOM CPUState object for which QEMU KVM vCPU context has to be parked.
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index d095d1b98f8..17235f26464 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -453,7 +453,13 @@ static void kvm_reset_parked_vcpus(KVMState *s)
>       }
>   }
>   
> -int kvm_create_vcpu(CPUState *cpu)
> +/**
> + * kvm_create_vcpu - Gets a parked KVM vCPU or creates a KVM vCPU
> + * @cpu: QOM CPUState object for which KVM vCPU has to be fetched/created.
> + *
> + * @returns: 0 when success, errno (<0) when failed.
> + */
> +static int kvm_create_vcpu(CPUState *cpu)
>   {
>       unsigned long vcpu_id = kvm_arch_vcpu_id(cpu);
>       KVMState *s = kvm_state;


