Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66B7C83030
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 01:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWPMj-0000tB-Md; Mon, 30 Jun 2025 21:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uWPMX-0000s4-CV
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 21:00:44 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uWPMP-0006k2-Ht
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 21:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751331634; x=1782867634;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=nRrJl2potVg+qhPL1mtOVfHCyd3J2HJ3p+bLqtSHRVw=;
 b=L4O3o/5Zam3/XA0n38FxofNAZzY+aaMoY+I22c7sX2XIQKrcWx96a0Lu
 N/2YVFL+hNWAr7zCcF0jKK7vYTAG4trn9Zz6jx3s5cKMxBZsBIXVWTwAo
 xw47i58B7yIjyCd7W642NAauwEF7lI3LxJbxza2wAt2J6sLN/8Uy8AfC5
 jBY/erRRIybObwV59IzqNLjEA9sSW+iO0NBepFAUI/TQ0KsbKnXNhCAGK
 D4kDqDmPPGpzDKlzesHk4jgQbAhNMoqC0kSd63QOZV70An76eIfZUjKCl
 fQo78MIK+f5sg5xVuav0hdKklfEiqUze357hnrp8t9TguKlBtII+FlbcN Q==;
X-CSE-ConnectionGUID: HgIrv4wLSxGDFZwXmsyAwA==
X-CSE-MsgGUID: ciy1dD3WQ6mtCkduA4UnVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="64929296"
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; d="scan'208";a="64929296"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2025 18:00:28 -0700
X-CSE-ConnectionGUID: TpwyJJxtQaC5gRSP6rlurw==
X-CSE-MsgGUID: BOxUDfCqQyathghqxV4E3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; d="scan'208";a="184645217"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2025 18:00:26 -0700
Message-ID: <93cac118-87d7-4742-99b5-057609108abb@intel.com>
Date: Tue, 1 Jul 2025 09:00:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] i386/cpu: Mark ECX/EDX in CPUID 0x80000008 leaf as
 reserved for Intel
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Tao Su <tao1.su@intel.com>, Yi Lai <yi1.lai@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, qemu-devel@nongnu.org
References: <20250627035129.2755537-1-zhao1.liu@intel.com>
 <20250627035129.2755537-4-zhao1.liu@intel.com>
 <dedb9a90-a516-430e-8748-f776392f508d@intel.com> <aGIeuV5QKTIbtkeu@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aGIeuV5QKTIbtkeu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 6/30/2025 1:20 PM, Zhao Liu wrote:
>>> +        if (cpu->vendor_cpuid_only_v2 && IS_INTEL_CPU(env)) {
>>> +            *ecx = *edx = 0;
>>> +            break;
>>> +        }
>>
>> current code guarantees ecx and edx to be 0 for !IS_AMD_CPU(). I think the
>> patch is unnecessary.
> 
> Hi, could you please tell me why?

Sorry that I was looking at the wrong branch, which has my previous 
patch of 
https://lore.kernel.org/qemu-devel/20240814075431.339209-7-xiaoyao.li@intel.com/

My patch isn't merged and you patch is not unnecessary.

Sorry again.

> Thanks,
> Zhao
> 
>>>            if (threads_per_pkg > 1) {
>>>                /*
>>>                 * Bits 15:12 is "The number of bits in the initial
>>


