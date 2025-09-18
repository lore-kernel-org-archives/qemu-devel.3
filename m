Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9826ACAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 12:39:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzDua-0000xp-10; Thu, 18 Sep 2025 08:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uzDuX-0000xM-L9
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 08:38:53 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uzDuU-0001xj-Va
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 08:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758199131; x=1789735131;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=tDpkc2bxTs8xqitKzhUDhHJbLmF3Bbme+/9qGAVzq/g=;
 b=fOtm64WvClSmjHNbbQFqY0yZtrW7tYDYpHYpirCHtYIgoytSQIWBP2x5
 GL2TXH40SqMepGb0el6Lg7zkoGSqASmiKQUoNFWdiWU5JOOGHKAZkbWsM
 pvHSh6+o4BnZDntaJ7YcvF0O3/2DenHl7pWf2TTBipMecmTgfJRao6yaH
 NJIvgaa3tgYPv/uV+FgT4wVBNhshsTSqcTXw+GHPZFLzkhBhQSuiab6Fi
 ZKOmfpPkjKJFSsoKPvABnJd5TIwDh5WoOrSEzaQ6GdjxfxzkT5/xh8Wn3
 CbVXdeHPTkAYaDXd9udV55bY1u/lHwzJAIjOA8TC6l4t57D6CKTDsd073 w==;
X-CSE-ConnectionGUID: Wa1KSb5VTQWhPPBnz2GpCA==
X-CSE-MsgGUID: CObomCGpR22d9xpOg1/GDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60580261"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="60580261"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 05:38:46 -0700
X-CSE-ConnectionGUID: K4f+DtSHRkmoHhlpe0LGKA==
X-CSE-MsgGUID: TFLVxCIBQAarDQcd4KWzQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; d="scan'208";a="175454457"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 05:38:44 -0700
Message-ID: <234847c9-d099-4779-abd1-3a3e8e942890@intel.com>
Date: Thu, 18 Sep 2025 20:38:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/61] CPU, Rust, x86 changes for 2025-09-13
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20250913080943.11710-1-pbonzini@redhat.com>
 <15b36cb6-69a2-44bf-80f9-46704d8d9e65@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <15b36cb6-69a2-44bf-80f9-46704d8d9e65@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
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

On 9/18/2025 12:33 AM, Richard Henderson wrote:
> On 9/13/25 01:08, Paolo Bonzini wrote:
>> The following changes since commit 
>> 190d5d7fd725ff754f94e8e0cbfb69f279c82b5d:
>>
>>    Merge tag 'pull-request-2025-09-09' ofhttps://gitlab.com/thuth/qemu 
>> into staging (2025-09-11 12:41:01 +0100)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
>>
>> for you to fetch changes up to 8733ddc08165d901eb2c87f364f814f58ab9fd19:
>>
>>    accel/kvm: Set guest_memfd_offset to non-zero value only when 
>> guest_memfd is valid (2025-09-13 07:52:55 +0200)
>>
>> ----------------------------------------------------------------
>> * cpu-exec: more cleanups to CPU loop exits
>> * python: bump bundled Meson to 1.9.0
>> * rust: require Rust 1.83.0
>> * rust: temporarily remove from Ubuntu CI
>> * rust: vmstate: convert to use builder pattern
>> * rust: split "qemu-api" crate
>> * rust: rename qemu_api_macros -> qemu_macros
>> * rust: re-export qemu macros from other crates
>> * x86: fix functional test failure for Xen emulation
>> * x86: cleanups
> 
> Fails crash-test-debian:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/11390438959
> 
> qemu.machine.machine.VMLaunchFailure: ConnectError: Failed to establish 
> session: EOFError
>      Exit code: -6
>      Command: ./qemu-system-i386 -display none -vga none -chardev 
> socket,id=mon,fd=3 -mon chardev=mon,mode=control -S -machine 
> none,accel=kvm:tcg
>      Output: ../include/hw/i386/x86.h:109:X86_MACHINE: Object 
> 0x556fd9ddf400 is not an instance of type x86-machine
> 

It's due to patch 58 in this pull request.

It's my patch. I missed the case of "none" machine. Sorry for it.

I see Paolo already removed the problematic one in his v2 pull request.

> 
> r~
> 


