Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE24C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 01:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfShA-0000nx-A8; Thu, 02 Jul 2026 21:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1wfSh8-0000nM-9o; Thu, 02 Jul 2026 21:27:54 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1wfSh6-00047k-5Z; Thu, 02 Jul 2026 21:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783042072; x=1814578072;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=KslLZ8djvA/6/vucsOaqOIltJJKw39jwsjS3R2y+cSs=;
 b=AM3dneGH/inZcs5h32TFj1raQJdqXwXN6uFMtwjMlmSInwDXfUOA4Y2q
 svsAyycaThkBX/IbH672A+zcCIu75R9U/m00gNL/qlSJTbV1ktY0o46EU
 E/OAlrLvsm+f4mLBonn/HeS6J8oA77o/gCrdLH4o1489ZoIpO/JTf+aYW
 FGIjm6+7afcA9WApyq3KiWGyUhR0QcqaEkBFcksqvFXLAxJsoVdbDVMJv
 vxNAXfQODwwGPxiLnNgxhU6AurQatNYRnUR93lSDvVPK85bxfscWZ5VWs
 5/4u/OPe8Rf/NZawhTdncHieB6V1PQGedf+rKX5XWgMm326KbfFiFfGvv Q==;
X-CSE-ConnectionGUID: wkN6goFyTQe3P76VqQ6EBA==
X-CSE-MsgGUID: 6sdW6wGpR5ytNfwkO8MT1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="95299747"
X-IronPort-AV: E=Sophos;i="6.25,144,1779174000"; d="scan'208";a="95299747"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2026 18:27:46 -0700
X-CSE-ConnectionGUID: 3JPMeS1ETTqc4MnnXAe1rA==
X-CSE-MsgGUID: bpiGjlnITfqM/L/NKS0DfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,144,1779174000"; d="scan'208";a="250335536"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.18])
 ([10.124.240.18])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2026 18:27:43 -0700
Message-ID: <7a32f990-4789-492a-b851-03658989fa70@intel.com>
Date: Fri, 3 Jul 2026 09:27:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/33] cpu: Rename CPUState @singlestep_enabled ->
 @singlestep_flags
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-33-philmd@oss.qualcomm.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260630220100.1289-33-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/1/2026 6:00 AM, Philippe Mathieu-Daudé wrote:
> CPUState::singlestep_enabled contains multiple flags since
> commit 60897d369f1 ("Debugger single step without interrupts").
> Rename to avoid mistakes.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   include/hw/core/cpu.h        |  8 ++++----
>   accel/kvm/kvm-all.c          |  2 +-
>   accel/tcg/cpu-exec.c         |  2 +-
>   accel/tcg/tcg-accel-ops-rr.c |  2 +-
>   cpu-target.c                 |  8 ++++----
>   target/arm/hvf/hvf.c         |  2 +-
>   target/ppc/translate.c       | 16 ++++++++--------
>   7 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 37ac218bda3..27ee0e54327 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -440,7 +440,7 @@ struct qemu_work_item;
>    * @stopped: Indicates the CPU has been artificially stopped.
>    * @unplug: Indicates a pending CPU unplug request.
>    * @crash_occurred: Indicates the OS reported a crash (panic) for this CPU
> - * @singlestep_enabled: Flags for single-stepping.
> + * @singlestep_flags: Flags for single-stepping.
>    * @icount_extra: Instructions until next timer event.
>    * @cpu_ases: Pointer to array of CPUAddressSpaces (which define the
>    *            AddressSpaces this CPU has)
> @@ -505,7 +505,7 @@ struct CPUState {
>       int exclusive_context_count;
>       uint32_t cflags_next_tb;
>       uint32_t interrupt_request;
> -    int singlestep_enabled;
> +    int singlestep_flags;

can we also change the type to uint32_t?


