Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455F5C36005
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 03:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txHZ6-0003X3-5Z; Tue, 25 Mar 2025 23:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1txHZ4-0003Wk-Gq
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 23:36:26 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1txHYy-0007sy-Cn
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 23:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742960180; x=1774496180;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=5lbOm40wW6H+uY1VgylzfldJsVnXOZbIS8SjKrOhmx0=;
 b=LfMraw2uITylWI4ZpSb0zdTYOIThh/25hh5MVmFWAm2+0zlRZsJ9odXA
 pLpwXpshIJWqPsJN3BXM1aLcU0g+P4uiMjfqVGD0P1lYc/k9IihgtQ31X
 KfztB41Jf2YiM184w/Ia7eWNADbPpeeRyp+D5LbLag0Vu5W/mMcT36nk4
 1v6GLdU9HIa3GFogVu1QKNJV1AryQ1clUiooR8r332SlnzZFGWmRJ6fFG
 jemwoD2yAtzKj70Ebrpa4nbTfFHt1mP5W8W0BIuDBOsiNNrXspJ0no90O
 hIE2Im/ZW7ABJMyzLOOiK4prEg8LlV9e2FKr73gy+IPd4S5q0RhNkTENT Q==;
X-CSE-ConnectionGUID: eurX2Y7ASWKNFvrHbZkKHA==
X-CSE-MsgGUID: JYj3WJP6RLef2hUmV65ekg==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="31834297"
X-IronPort-AV: E=Sophos;i="6.14,276,1736841600"; d="scan'208";a="31834297"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2025 20:36:15 -0700
X-CSE-ConnectionGUID: cO75iQ3uQiqwaOIRS8hllg==
X-CSE-MsgGUID: yWYrdEgdTSSYrnuCQi16YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,276,1736841600"; d="scan'208";a="129723204"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2025 20:36:12 -0700
Message-ID: <81e9d055-377c-4521-9588-a6bad60b3a6d@intel.com>
Date: Wed, 26 Mar 2025 11:36:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 52/52] docs: Add TDX documentation
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
References: <20250124132048.3229049-1-xiaoyao.li@intel.com>
 <20250124132048.3229049-53-xiaoyao.li@intel.com>
 <Z-L6CSajU284qAJ4@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <Z-L6CSajU284qAJ4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.776, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 3/26/2025 2:46 AM, Daniel P. Berrangé wrote:
> On Fri, Jan 24, 2025 at 08:20:48AM -0500, Xiaoyao Li wrote:
>> Add docs/system/i386/tdx.rst for TDX support, and add tdx in
>> confidential-guest-support.rst
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
> 
>> ---
>>   docs/system/confidential-guest-support.rst |   1 +
>>   docs/system/i386/tdx.rst                   | 156 +++++++++++++++++++++
>>   docs/system/target-i386.rst                |   1 +
>>   3 files changed, 158 insertions(+)
>>   create mode 100644 docs/system/i386/tdx.rst
> 
> 
>> +Launching a TD (TDX VM)
>> +-----------------------
>> +
>> +To launch a TD, the necessary command line options are tdx-guest object and
>> +split kernel-irqchip, as below:
>> +
>> +.. parsed-literal::
>> +
>> +    |qemu_system_x86| \\
>> +        -object tdx-guest,id=tdx0 \\
>> +        -machine ...,kernel-irqchip=split,confidential-guest-support=tdx0 \\
>> +        -bios OVMF.fd \\
>> +
>> +Restrictions
>> +------------
>> +
>> + - kernel-irqchip must be split;
> 
> Is there a reason why we don't make QEMU set kernel-irqchip=split
> automatically when tdx-guest is enabled ?
> 
> It feels silly to default to a configuration that is known to be
> broken with TDX. I thought about making libvirt automatically
> set kernel-irqchip=split, or even above that making virt-install
> automatically set it. Addressing it in QEMU would seem the most
> appropriate place though.

For x86, if not with machine older than machine-4.0, the default 
kernel_irqchip is set to split when users don't set a value explicitly:

  if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
         s->kernel_irqchip_split = mc->default_kernel_irqchip_split ? 
ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
     }


I think QEMU should only set it to split automatically for TDX guest 
when users don't provide a explicit value. And current code just works 
as expected.

Further, I think we can at least add the check in tdx_kvm_init() like this

if (kvm_state->kernel_irqchip_split != ON_OFF_AUTO_ON) {
	error_setg(errp, "TDX VM requires kernel_irqchip to be split");
	return -EINVAL;
}

Are you OK with it?

> 
> With regards,
> Daniel


