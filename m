Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B6CE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 03:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLaLl-0003cb-U2; Wed, 11 Dec 2024 22:58:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tLaLj-0003cP-Mb
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 22:58:51 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tLaLg-0002qc-Rh
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 22:58:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733975929; x=1765511929;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=KuBxYiWjPrSVCA/5xZDwFUtlhAPlHGsdlEQRvLdDuJ0=;
 b=gDdC7+qw11unc7h2x88C0hjbSN+CVJ0umzEtNfax2UaNpqyAg0d7PxHn
 qrTrhSJNZcFXOdmGLN2yz252MpvQmoSE+mVoyVi2l8Oz7oQm0F8RjaiwL
 492JUEfbiZwvspf7/n561KsmQ7M0guSa7IiAPHq6S4KNMR4z8/r40z3Y8
 k7wW1i1lJ+flrnMmB+T5EglPjJaeHd0gC4q3+TAgbZSHsYGRHkh9NkLTV
 oIK1UFti+KwCpJz99/1uPkpfQWUAx9wjxq6NIF1PbJvCKkiwMTw7wamEb
 D2QW6WmJ9/Zc54hfE76em+8QVx+LARjJmNECEM/UHs65k1a15/oulqZHN A==;
X-CSE-ConnectionGUID: vmyd6wOVTrWrBGV3b4pmZg==
X-CSE-MsgGUID: 503ysZxnSlmvb45aw6nyBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34299862"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; d="scan'208";a="34299862"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2024 19:58:47 -0800
X-CSE-ConnectionGUID: fILQ16xOQIuZEXz6nX6uhg==
X-CSE-MsgGUID: uhCcXsOdQOmLAE4xH4f9aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="101165835"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2024 19:58:43 -0800
Message-ID: <e34bf684-2269-4dd8-b215-c63e27d7ae1c@intel.com>
Date: Thu, 12 Dec 2024 11:58:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] i386/topology: Update the comment of
 x86_apicid_from_topo_ids()
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org
References: <20241205145716.472456-1-xiaoyao.li@intel.com>
 <20241205145716.472456-2-xiaoyao.li@intel.com> <Z1j+zDk0w66tReuf@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <Z1j+zDk0w66tReuf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3,
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

On 12/11/2024 10:54 AM, Zhao Liu wrote:
> On Thu, Dec 05, 2024 at 09:57:13AM -0500, Xiaoyao Li wrote:
>> Date: Thu, 5 Dec 2024 09:57:13 -0500
>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>> Subject: [RFC PATCH 1/4] i386/topology: Update the comment of
>>   x86_apicid_from_topo_ids()
>> X-Mailer: git-send-email 2.34.1
>>
>> Update the comment of x86_apicid_from_topo_ids() to match the current
>> implementation,
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>   include/hw/i386/topology.h | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
>> index b2c8bf2de158..21b65219a5ca 100644
>> --- a/include/hw/i386/topology.h
>> +++ b/include/hw/i386/topology.h
>> @@ -121,9 +121,10 @@ static inline unsigned apicid_pkg_offset(X86CPUTopoInfo *topo_info)
>>   }
>>   
>>   /*
>> - * Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
>> + * Make APIC ID for the CPU based on topology and IDs of each topology level.
> 
> Maybe "based on sub-topology ID"?

I interpret "sub-topology ID" the same as "IDs of each topology level". 
But only with the information of IDs cannot produce a APIC ID, we need 
the width of each level as well. I think the "topology" expresses the 
width information, so I used the statement as "topology and IDs of each 
topology level"

> Otherwise,
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> 


