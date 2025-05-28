Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A811C5AE59
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 03:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK7mX-0007VK-3r; Tue, 27 May 2025 23:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uK7mV-0007Uv-1M
 for qemu-devel@nongnu.org; Tue, 27 May 2025 23:48:43 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uK7mS-0008Fj-AD
 for qemu-devel@nongnu.org; Tue, 27 May 2025 23:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748404120; x=1779940120;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=wLUR0MAU87+mBNmBdyLsGbp7sNCOINsRfMaCLRhmnHU=;
 b=RaY/uBFS+6hgcTsPvuFuiEXxbEY/XQKGfS3S0cZWmXA3c2O4UqM8YdcE
 YpFFFgBUlvIvCu6zNeDjINgbWz0pNhEQOaH2UXbld2r9igWZ88mp5FHak
 +6DRXR8QRVmk6S2+vqbhLjGLkhTDaNeniMrs3EsmO4fne5QipzWx+rFxr
 QBISGFndKIOZ5wATn55kADnArpPLgbpjJrn/jPqjiKiZWHU7QVRWb5H9b
 RHzx10t9Hv6ljWDnZd4hEsci1Ef6I2SLXuFvwFt3YGd9MDfKS6iGG51CG
 QDYXypBL4JxEAJmKOkbbz54XcKhjCKKep3Zwr93dY3V4vsN4q8KAjUATW w==;
X-CSE-ConnectionGUID: BoKkSifnTAqfss9lyicasA==
X-CSE-MsgGUID: wKtQFe5xQyeFGDzzrqqp8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="38036228"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="38036228"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 20:48:37 -0700
X-CSE-ConnectionGUID: OyQ+JgPGRsOHW2GF8BaR0Q==
X-CSE-MsgGUID: 3KvOb002Tp+NIp1/wb2pMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="148227378"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 20:48:34 -0700
Message-ID: <de6fe8ec-1426-4fba-82f2-431d795b7c77@intel.com>
Date: Wed, 28 May 2025 11:48:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "i386/cpu: Set up CPUID_HT in
 x86_cpu_expand_features() instead of cpu_x86_cpuid()"
To: Zhao Liu <zhao1.liu@intel.com>
Cc: elisey.konstantinov@icloud.com, qemu-devel@nongnu.org, pbonzini@redhat.com
References: <0C532D10-33ED-41F5-BBA7-13C64AA0633D@icloud.com>
 <aDaCJTkoDYsdJFmJ@intel.com> <bbeba807-ef49-4bd1-abfe-dce8b2a5f9a3@intel.com>
 <aDaHqhiuowgjMtXK@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aDaHqhiuowgjMtXK@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
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

On 5/28/2025 11:48 AM, Zhao Liu wrote:
> On Wed, May 28, 2025 at 11:22:57AM +0800, Xiaoyao Li wrote:
>> Date: Wed, 28 May 2025 11:22:57 +0800
>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>> Subject: Re: [PATCH] Revert "i386/cpu: Set up CPUID_HT in
>>   x86_cpu_expand_features() instead of cpu_x86_cpuid()"
>>
>> On 5/28/2025 11:25 AM, Zhao Liu wrote:
>>> Hi Elisey,
>>>
>>> Thank you for your patch! I'm sorry I previously noticed #2894 [*] but
>>> missed your report.
>>>
>>> Recently there's a fix (commit 5979f50fa9fd ("i386/tcg: Make CPUID_HT
>>> and CPUID_EXT3_CMP_LEG supported")). Does that fix address this bug?
>>>
>>> [*]: https://lore.kernel.org/qemu-devel/aCWdhIqZiu4q+UJi@intel.com/
>>
>> It should be the next one for hvf accelerator in this series that helps.
>> Because the regression reported is on macOS.
> 
>  From Elisey's cli example, this case is using TCG ("-accel tcg").

you are right. My intuition is not reliable.

