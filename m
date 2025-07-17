Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D638C83F22
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 14:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucPuT-000580-Qe; Thu, 17 Jul 2025 10:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ucOME-0007SX-79; Thu, 17 Jul 2025 09:09:06 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ucOMA-0001sg-Cc; Thu, 17 Jul 2025 09:09:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752757743; x=1784293743;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=T/IVqI+1Ccw5qrGvHqbqRKzY61XINI9554vFTWPatks=;
 b=PI7OEDYvKhyZ1dQAZcS007qrHJhtfqdS0UdOKHknMIOhF1ZmCKMFCCaR
 78OMOFl75rErvjyJGWNeW4kU7LvrW9h09BayFqv6FJP31G5Ji/fReDNnF
 GfpPdOI/VDBCWlrNew9mp2a0zU1FHemn+FcWL2D+bRZDEAIffZKQnoOJe
 9Ob3Uv1qTq3YDd4kcFJbyVcCBwSiLHHpYZ1KZ+yEc8TUsy7vWNKaTqeMt
 XQPJpX9hFxHSber/AS99YKO5D0AIzXpljNpyTVjk/D36T/CGOkCn3bF8l
 X43hK5O4nP94lSVcZob6a6utUr9Ct+cuPdKdBB4DsUZXwSuD4HKBdOuNl g==;
X-CSE-ConnectionGUID: 1TIziBsJT129OlvYnqxTLQ==
X-CSE-MsgGUID: pMsCIXoPTb6Jb+jrR9lJmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="55180524"
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="55180524"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 06:08:58 -0700
X-CSE-ConnectionGUID: IIMwW4kYSt2I146w0cPbFQ==
X-CSE-MsgGUID: BAAFq7s1TFODC8MaVXBS8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="158141936"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 06:08:54 -0700
Message-ID: <1edeecdd-76cf-4baa-97d8-c07df20b4824@intel.com>
Date: Thu, 17 Jul 2025 21:08:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 1/3] accel/hvf: Display executable bit as 'X'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250716172813.73405-1-philmd@linaro.org>
 <20250716172813.73405-2-philmd@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250716172813.73405-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 7/17/2025 1:28 AM, Philippe Mathieu-Daudé wrote:
> Developers are custom to read RWX, not RWE.
> Replace E -> X.
> 
> Reported-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   accel/hvf/hvf-all.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
> index e67a8105a66..0a4b498e836 100644
> --- a/accel/hvf/hvf-all.c
> +++ b/accel/hvf/hvf-all.c
> @@ -84,7 +84,7 @@ static int do_hvf_set_memory(hvf_slot *slot, hv_memory_flags_t flags)
>       trace_hvf_vm_map(slot->start, slot->size, slot->mem, flags,
>                        flags & HV_MEMORY_READ ?  'R' : '-',
>                        flags & HV_MEMORY_WRITE ? 'W' : '-',
> -                     flags & HV_MEMORY_EXEC ?  'E' : '-');
> +                     flags & HV_MEMORY_EXEC ?  'X' : '-');
>       ret = hv_vm_map(slot->mem, slot->start, slot->size, flags);
>       assert_hvf_ok(ret);
>       return 0;


