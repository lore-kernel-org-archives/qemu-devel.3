Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B87C5B549
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 09:29:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNTNS-0005rq-RB; Fri, 06 Jun 2025 05:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uNTNR-0005rh-Cg
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 05:28:41 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uNTNP-0001Cs-Es
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 05:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749202120; x=1780738120;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=WvgIDpiqKg+CX5vHn+MIwqWix1f776q01E7PRNWKg+w=;
 b=GnoJDoc1+Py1jQ4aly3fC+wRVkhIolD9FgGbGsFteEAsFIaMwGv3dVOS
 +77O+EMMNk1i1AUVdx8VrdsbaWuXuRK4kdQBGpteVMIZTt2EILuN1Jolz
 gzSPnnNqkrExeG6RLLuvIR80FrjP2WghooUzXvrt8Wy9kRVkmSsjRZO2+
 glXWp/a52AkAWJHSqbYvmEd2ZoSfazlVK1BqA06sIg+C7UzhhcOYw3kac
 jnN8eSMcN06iOcXnkNwL5jmlc1MvQib/ZngfbzG6fxOsxzxitUze9HtZB
 fHwKppbNHGFXZc3rCdNmvveGZ5gBNK0PEKVnqe2u3I9k+RUYzWpfgB5zR A==;
X-CSE-ConnectionGUID: QnDj39PpSi+VOJzRU1ZcpQ==
X-CSE-MsgGUID: rq810A2ARAGW8xIO1bumKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="51257110"
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; d="scan'208";a="51257110"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 02:28:36 -0700
X-CSE-ConnectionGUID: 4t7V3qMSTPyoAURKHcPwFg==
X-CSE-MsgGUID: /bILwcUKSI+t5ctKekXGNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; d="scan'208";a="150796250"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 02:28:34 -0700
Message-ID: <fde03bbf-415a-466f-a3cd-fac4f952c531@intel.com>
Date: Fri, 6 Jun 2025 17:28:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] i386/tdx: Fix build on 32-bit host
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Marcelo Tosatti <mtosatti@redhat.com>
References: <20250602173101.1052983-1-clg@redhat.com>
 <20250602173101.1052983-2-clg@redhat.com>
 <b30050b0-68d3-4b42-85f3-9aeca26fb830@intel.com>
 <06903e8d-d729-458d-8157-5a54d324a239@linaro.org>
 <a838e7cc-968e-4ca4-ba60-bbf201d689aa@redhat.com>
 <5fb2a861-26c9-4a48-9de7-6d872ac1e234@intel.com>
 <d22baf31-2722-4b89-ae99-475d6c5e4f33@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <d22baf31-2722-4b89-ae99-475d6c5e4f33@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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

On 6/6/2025 5:19 PM, Philippe Mathieu-Daudé wrote:
> On 6/6/25 10:49, Xiaoyao Li wrote:
>> On 6/3/2025 10:53 PM, Paolo Bonzini wrote:
>>> On 6/3/25 13:26, Philippe Mathieu-Daudé wrote:
>>>> On 3/6/25 05:04, Xiaoyao Li wrote:
>>>>> On 6/3/2025 1:31 AM, Cédric Le Goater wrote:
>>>>>> Use PRI formats where required and fix pointer cast.
>>>>>
>>>>> Maybe we can make 32-bit build exclusive with CONFIG_TDX? since TDX 
>>>>> is not supported on 32-bit host.
>>>>
>>>> Yes please!
>>>
>>> No objections, but I'm still applying these first to fix the build.
>>
>> Can anyone guide how to implement it? Or directly help cook a patch?
>>
>> I'm struggling to learn the 32-bit build stuff and create a 32-bit 
>> environment.
> 
> -- >8 --
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index eb65bda6e07..b5970f9a1f3 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -13,7 +13,7 @@ config SGX
>   config TDX
>       bool
>       select X86_FW_OVMF
> -    depends on KVM
> +    depends on KVM && !I386
> 
> ---

CONFIG_X86_64 selects I386 in target/i386/Kconfig, so above change will 
just leads to CONFIG_TDX always being 0.

config X86_64
     bool
     select I386





