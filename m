Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B73C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 03:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1zQS-0003B0-AL; Mon, 07 Apr 2025 23:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u1zQO-0003AF-Ms
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 23:14:56 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u1zQN-0006Si-3f
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 23:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744082095; x=1775618095;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=5EP/qO3EmNkIvEOxhPkRCk9MXlDAXvGGbL684lxx0D8=;
 b=QfWvDUXgqW3Wtu4LfTf/ZLXMzZceHQ9XDWPClRjn2BzScbjjb7WLg5l5
 hKiUS6QM01MX4swuaLWRxvBbgpg9F0Ge/8yvNKXn5d/dAx3ZI2LAEyelQ
 7zx0i4LnQoTsf67SOGLLGY8MpS/vHp2s3Z+8iqI5mAUl9+g434sZsJiDo
 axRHXodXX1Og3n5tl7L8cfEp11ddakeLVMvZYEWVVFpXXerQu0ZIsm7/g
 wd7J0kS/DjHhuj0KZwKoWAHCnb/KuteleacmoBUw9g/ssNcIc5FKlhREE
 OTJlcB5BSOo/ikFhlQyszlbR7srWtS5cVAOde8a5cMFQBKLlFC6sydC9M A==;
X-CSE-ConnectionGUID: FLin0MoxSPCcXFMNPelBrA==
X-CSE-MsgGUID: kNYwfH1NSgOjj5L41j5Yzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45381810"
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; d="scan'208";a="45381810"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 20:14:53 -0700
X-CSE-ConnectionGUID: xB4FazDmSBWaotorh2cXKQ==
X-CSE-MsgGUID: adD/28vjQ369rhpTddIPFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; d="scan'208";a="128114611"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 20:14:50 -0700
Message-ID: <4b9ede44-ef9d-45dc-903a-14f860b55f4d@intel.com>
Date: Tue, 8 Apr 2025 11:14:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 14/55] i386/tdx: Set APIC bus rate to match with what
 TDX module enforces
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-15-xiaoyao.li@intel.com>
 <Z-0l9oE7S1sO8E0j@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <Z-0l9oE7S1sO8E0j@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
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

On 4/2/2025 7:56 PM, Daniel P. Berrangé wrote:
> On Tue, Apr 01, 2025 at 09:01:24AM -0400, Xiaoyao Li wrote:
>> TDX advertises core crystal clock with cpuid[0x15] as 25MHz for TD
>> guests and it's unchangeable from VMM. As a result, TDX guest reads
>> the APIC timer as the same frequency, 25MHz.
> 
> Did you mean    s/as/at/  ?

yes, thanks for catching it!

>> While KVM's default emulated frequency for APIC bus is 1GHz, set the
>> APIC bus rate to match with TDX explicitly to ensure KVM provide correct
>> emulated APIC timer for TD guest.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>> Changes in v6:
>>   - new patch;
>> ---
>>   target/i386/kvm/tdx.c | 13 +++++++++++++
>>   target/i386/kvm/tdx.h |  3 +++
>>   2 files changed, 16 insertions(+)
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> 
> With regards,
> Daniel


