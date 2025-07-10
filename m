Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBEAC83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 12:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZqbs-0003jV-B4; Thu, 10 Jul 2025 08:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uZqbm-0003cB-0H
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 08:42:38 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uZqbi-00039s-5E
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 08:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752151355; x=1783687355;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=NrUvM/BMWGFY4F4aAjvjRq1seoLo1KM6IwRJmlhht8U=;
 b=m4vAyI17cjM4xzgLWyH/wtvkv8XDpBWMUCdU9St9uX/v2Dwr8+I6cMua
 2uWvtp0LxTRAYHn8qBjZnQU6MEsci25FrC4nKOqt7A34fdIZ53LvwPMlZ
 r27nshA6Fj2+Fm0gHjAqxepVnTOUu978E32zTaL/6zDMl9sPPWU8iBOU6
 3fSdAxcVwEyDmFbIgtD0u9+egbm464P2opscTNtP3c5XhLM4cP9g2uA3r
 XXGBtBHMPB4y7+SYUuRa0nPA3XYbX8n1iiYh6rSrO1ONrceTY41v5kIgt
 cKow9rrUrFR5XneSfiWnoOvUwAOH4m7bCFa2/ORN6w7LknzmYjpCHjtog A==;
X-CSE-ConnectionGUID: vG49t+12QLWRnMyKFOfuHw==
X-CSE-MsgGUID: YnIeTpTqQyeE7WU2nzFHlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54282331"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; d="scan'208";a="54282331"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2025 05:42:30 -0700
X-CSE-ConnectionGUID: QXAzGTCVSqGcKBkdte6APQ==
X-CSE-MsgGUID: U0MX+WpsSxuhuOWkfD4Ajw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; d="scan'208";a="155706642"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2025 05:42:24 -0700
Message-ID: <da06f310-2349-422a-98f8-cf5995539c36@intel.com>
Date: Thu, 10 Jul 2025 20:42:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 59/77] i386/tdx: Add supported CPUID bits relates to XFAM
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250530071250.2050910-1-pbonzini@redhat.com>
 <20250530071250.2050910-60-pbonzini@redhat.com>
 <CAFEAcA9mqK-=+bz+tdWzK5Jyq0v-ng4wQ5ngownLqOcbKQgq+g@mail.gmail.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <CAFEAcA9mqK-=+bz+tdWzK5Jyq0v-ng4wQ5ngownLqOcbKQgq+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=xiaoyao.li@intel.com;
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

On 7/10/2025 8:27 PM, Peter Maydell wrote:
> On Fri, 30 May 2025 at 08:23, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>>
>> Some CPUID bits are controlled by XFAM. They are not covered by
>> tdx_caps.cpuid (which only contians the directly configurable bits), but
>> they are actually supported when the related XFAM bit is supported.
>>
>> Add these XFAM controlled bits to TDX supported CPUID bits based on the
>> supported_xfam.
>>
>> Besides, incorporate the supported_xfam into the supported CPUID leaf of
>> 0xD.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Link: https://lore.kernel.org/r/20250508150002.689633-48-xiaoyao.li@intel.com
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   target/i386/cpu.h     | 16 ++++++++++
>>   target/i386/cpu.c     | 12 -------
>>   target/i386/kvm/tdx.c | 73 +++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 89 insertions(+), 12 deletions(-)
> 
> Hi; Coverity points out a problem with this code (CID 1610545):
> 
>> +    e = find_in_supported_entry(0xd, 0);
>> +    e->eax |= (tdx_caps->supported_xfam & CPUID_XSTATE_XCR0_MASK);
>> +    e->edx |= (tdx_caps->supported_xfam & CPUID_XSTATE_XCR0_MASK) >> 32;
> 
> All the bits in CPUID_XSTATE_XCR0_MASK are in the bottom half
> of the word; this means that (x & CPUID_XSTATE_XCR0_MASK) >> 32
> is always zero and the statement has no effect.
> 
>> +    e->ecx |= (tdx_caps->supported_xfam & CPUID_XSTATE_XSS_MASK);
>> +    e->edx |= (tdx_caps->supported_xfam & CPUID_XSTATE_XSS_MASK) >> 32;
> 
> Similarly here.
> 
> What was the intention here ?

It's future-proven. So that this code will still work correctly even if 
CPUID_XSTATE_XCR0_MASK/CPUID_XSTATE_XSS_MASK has higher bit (above 32) 
set in the future.

> thanks
> -- PMM


