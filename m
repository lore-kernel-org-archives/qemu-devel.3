Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492C3C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 02:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u739l-0000An-8b; Mon, 21 Apr 2025 22:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u739i-0000AI-Fw
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 22:14:39 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u739f-0005Q6-AM
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 22:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745288075; x=1776824075;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=OENeusjX9PCMyA9ISdEmCKR3fGjJO65lRzv8ezgJxlY=;
 b=Fv+M2HcjzgCjzK/A8wMcCwjon3Rcj/Z9qe/m/hHZgAYhTWj0q1Sduzrk
 Mn+STWmMmqE0pa2H+5qDaEi86DT229RnC/GfPcQqpwcLODgqIblf5FeXd
 cC6yqwYOchweJWsuqSnh3m4/5TYLazYF297y4pce6VRwywHX2XIuhVz1m
 99qX66earvnCUoHTJPbMF/C6MiLgIpG+sfmAZUIgP2HxV0KOdbPtTwXv/
 tWeSa6dTZZ8XoQ+8lsRIiO5Iqi3WMOjLOPSzcN8rTCjO88xocYFFDLtnE
 G5OpvHKhKiH5YIY7dqvT/2sAdDAUpUbZr/nJmPSniBe+yjet63PiIRZ72 A==;
X-CSE-ConnectionGUID: j3nLwYJDTnaBImygbx0VrA==
X-CSE-MsgGUID: aE4h+21uQO2HoM3a0WndEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="57480437"
X-IronPort-AV: E=Sophos;i="6.15,229,1739865600"; d="scan'208";a="57480437"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2025 19:14:32 -0700
X-CSE-ConnectionGUID: J8sozSe8TX+P53OI/sKtUw==
X-CSE-MsgGUID: ManvR8omRxCcHEpVM56PIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,229,1739865600"; d="scan'208";a="135959043"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2025 19:14:28 -0700
Message-ID: <ea20e8d1-59cf-4fe5-8251-9a033ccd7ec3@intel.com>
Date: Tue, 22 Apr 2025 10:14:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/55] i386: Introduce tdx-guest object
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-3-xiaoyao.li@intel.com> <aAIYjpetyP9LKW6L@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aAIYjpetyP9LKW6L@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.692,
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

On 4/18/2025 5:17 PM, Zhao Liu wrote:
>>   configs/devices/i386-softmmu/default.mak |  1 +
>>   hw/i386/Kconfig                          |  5 +++
>>   qapi/qom.json                            | 15 +++++++++
>>   target/i386/kvm/meson.build              |  2 ++
>>   target/i386/kvm/tdx.c                    | 43 ++++++++++++++++++++++++
>>   target/i386/kvm/tdx.h                    | 21 ++++++++++++
> 
> SEV.* and confidential-guest.* are all placed in target/i386/.
> It's best if all of these can be in the same place.

I think it's more reasonable to put TDX code under KVM directory since 
TDX depends on KVM.

Regarding SEV, I think the same applies. But it was merged as is and I 
don't see it strongly that it has to move.

>>   6 files changed, 87 insertions(+)
>>   create mode 100644 target/i386/kvm/tdx.c
>>   create mode 100644 target/i386/kvm/tdx.h
> 
> ...
> 
>> diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
>> new file mode 100644
>> index 000000000000..f3b725336161
>> --- /dev/null
>> +++ b/target/i386/kvm/tdx.h
>> @@ -0,0 +1,21 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +
>> +#ifndef QEMU_I386_TDX_H
>> +#define QEMU_I386_TDX_H
> 
> I386_TDX_H is enough... the QEMU prefix is rarely seen in the whole
> project.

# git grep -r "#ifndef QEMU_" ./ | wc -l
# 329

I'm not sure if 329 means rarely?

I will just keep it unchanged unless someone objects it strongly.

> Others look good,
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Thanks!


