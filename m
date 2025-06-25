Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA1FC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 06:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUJki-0006OG-5i; Wed, 25 Jun 2025 02:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uUJkd-0006Nu-6x
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 02:36:55 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uUJkZ-00047z-H1
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 02:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750833411; x=1782369411;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=tsfsv+jiMhLGqSn64s+jgjWYrzJlh12NaRhA9/KoIcI=;
 b=QiYYVB/wlpxg+ZFZo8A4BBfRY/nVuZfWJvohoztUAlLDik1sru+CsWSh
 YK4FSOzcmQ9UwtP+EXl5yyqlCTvdcZfpprVgVrzJCghXQcW6k0+Q1URpZ
 BVDBbjQ9V9VXmrzjK/eUbeEAHjS66H0wNRat8NcB4m/OrZwqbwVC6z5L7
 zHSyYp8X8K3PJYKpYIiMAEJ7FEZ/DqM9PKvKieqMN6naX+dabM2yez7D3
 2934CByvZ8IqhMIOIYBaM03IRtfLOWr4Q4QDH4kZR09vRCSYAqENsUCHn
 RYR31ybellye3s5xEzwx0+Ag2ilj1L0yjClxM51oxSAguuEeqyv87N+Yy A==;
X-CSE-ConnectionGUID: SsIaePjnQdSG/ql14Oncuw==
X-CSE-MsgGUID: mT8DOP25SguhwDWSoKc0LQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="78512578"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; d="scan'208";a="78512578"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2025 23:36:47 -0700
X-CSE-ConnectionGUID: PxTNUTzbQhGHzwbnziEP8w==
X-CSE-MsgGUID: ScoPvsDZSdSl0CBv2hLLPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; d="scan'208";a="157889752"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2025 23:36:44 -0700
Message-ID: <68ca9542-217b-40ae-b2ab-f3f160940aca@intel.com>
Date: Wed, 25 Jun 2025 14:36:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] i386/tdx: Don't build TDX for 32bit target
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20250625034903.2770272-1-xiaoyao.li@intel.com>
 <20250625034903.2770272-3-xiaoyao.li@intel.com>
 <d1f54aa6-7da8-4656-9ba5-e2ecd14c5834@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <d1f54aa6-7da8-4656-9ba5-e2ecd14c5834@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 6/25/2025 1:59 PM, Cédric Le Goater wrote:
> On 6/25/25 05:49, Xiaoyao Li wrote:
>> TDX cannot work on 32-bit host. It's also not worth supported TDX with
>> 32-bit QEMU.
>>
>> Thus, make TDX depends on !I386.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>   hw/i386/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
>> index 6fc353930985..c58802462a45 100644
>> --- a/hw/i386/Kconfig
>> +++ b/hw/i386/Kconfig
>> @@ -13,7 +13,7 @@ config SGX
>>   config TDX
>>       bool
>>       select X86_FW_OVMF
>> -    depends on KVM
>> +    depends on KVM && !I386
>>   config PC
>>       bool
> 
> Both patches look OK.
> 
> Out of curiosity, would the change below work as well (without patch 1) ?
> 
> Thanks,
> 
> C.
> 
> 
> 
> 
> @@ -13,7 +13,7 @@ config SGX
>   config TDX
>       bool
>       select X86_FW_OVMF
> -    depends on KVM
> +    depends on KVM && X86_64
> 
>   config PC
>       bool
> 

It works! (It turns out I'm not clever enough)

Let's leave it to Paolo to pick.

