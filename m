Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741A8E7717D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 03:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKqpo-0000Gx-59; Mon, 09 Dec 2024 22:22:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tKqpm-0000GG-IS
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 22:22:50 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tKqpj-0004qd-U3
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 22:22:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733800968; x=1765336968;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=1zJ2q09lrsn1GGJjRKPAI0mV8Ctn3tNfX5jW4g2WZr4=;
 b=PRKMicJQdX3QqjeSofkXDZ2J9HclPRBB+/kUsjIvSzFYXLN0z/vrSKCc
 sywkryxwLhCUNFpgxsSEK3zGw4QFzhqg2hFV/vsmTbGtGR/ytICxv5YHz
 qjyhHVy8lFztJIfjbVINpxsbR7GZi9+HbjHGKQHZDizeuhDh4bpZx0Js7
 i6LhHkQakncgiuQoNXM2DBZ+S95ZFf2nRkxxetXfR85zPHu2hSemJlkiv
 iqTzYmwC0zPPHbLWYeaJSOjN3xraiRSCFDBNr+42uJeeQZJv+8B+uo/Vm
 RYGSG5r9C32KocsSW0kCzqgcYMD/txVkOj6IRgr7sYfpatS6XmMq7di3c w==;
X-CSE-ConnectionGUID: 8Xrs8ro1SQGHWCRFE76xfQ==
X-CSE-MsgGUID: E1DfzUqwRx2dVaWSiFi8Pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="34035380"
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; d="scan'208";a="34035380"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2024 19:22:45 -0800
X-CSE-ConnectionGUID: filPZePvSaKrUQyK9UGIbw==
X-CSE-MsgGUID: tqfch3mhSLaZL3j2Nfma/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; d="scan'208";a="99333945"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2024 19:22:42 -0800
Message-ID: <e7ca010e-fe97-46d0-aaae-316eef0cc2fd@intel.com>
Date: Tue, 10 Dec 2024 11:22:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (Proposal) New TDX Global Metadata To Report FIXED0 and FIXED1
 CPUID Bits
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "seanjc@google.com" <seanjc@google.com>
Cc: "Huang, Kai" <kai.huang@intel.com>,
 "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
 "Chatre, Reinette" <reinette.chatre@intel.com>,
 "Zhao, Yan Y" <yan.y.zhao@intel.com>,
 "tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Hunter, Adrian" <adrian.hunter@intel.com>,
 "Yamahata, Isaku" <isaku.yamahata@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <43b26df1-4c27-41ff-a482-e258f872cc31@intel.com>
 <d63e1f3f0ad8ead9d221cff5b1746dc7a7fa065c.camel@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <d63e1f3f0ad8ead9d221cff5b1746dc7a7fa065c.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
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

On 12/7/2024 2:41 AM, Edgecombe, Rick P wrote:
> On Fri, 2024-12-06 at 10:42 +0800, Xiaoyao Li wrote:
>> # Interaction with TDX_FEATURES0.VE_REDUCTION
>>
>> TDX introduces a new feature VE_REDUCTION[2]. From the perspective of
>> host VMM, VE_REDUCTION turns several CPUID bits from fixed1 to
>> configurable, e.g., MTRR, MCA, MCE, etc. However, from the perspective
>> of TD guest, it’s an opt-in feature. The actual value seen by TD guest
>> depends on multiple factors: 1). If TD guest enables REDUCE_VE in
>> TDCS.TD_CTLS, 2) TDCS.FEATURE_PARAVIRT_CTRL, 3) CPUID value configured
>> by host VMM via TD_PARAMS.CPUID_CONFIG[]. (Please refer to latest TDX
>> 1.5 spec for more details.)
>>
>> Since host VMM has no idea on the setting of 1) and 2) when creating the
>> TD. We make the design to treat them as configurable bits and the global
>> metadata interface doesn’t report them as fixed1 bits for simplicity.
>>
>> Host VMM must be aware itself that the value of these VE_REDUCTION
>> related CPUID bits might not be what it configures. The actual value
>> seen by TD guest also depends on the guest enabling and configuration of
>> VE_REDUCTION.
> 
> As we've been working on this, I've started to wonder whether this is a halfway
> solution that is not worth it. Today there are directly configurable bits,
> XFAM/attribute controlled bits, other opt-ins (like #VE reduction). And this has
> only gotten more complicated as time has gone on.
> 
> If we really want to fully solve the problem of userspace understanding which
> configurations are possible, the TDX module would almost need to expose some
> sort of CPUID logic DSL that could be used to evaluate user configuration.
> 
> On the other extreme we could just say, this kind of logic is just going to need
> to be hand coded somewhere, like is currently done in the QEMU patches.

I think hand coded some specific handling for special case is acceptable 
when it's unavoidable. However, an auto-adaptive interface for general 
cases is always better than hand code/hard code something. E.g., current 
QEMU implementation hardcodes the fixed0 and fixed1 information based on 
TDX 1.5.06 spec. When different versions of TDX module have different 
fixed0 and fixed1 information, QEMU will needs interface to get the 
version of TDX module and maintain different information for each 
version of TDX module. It's a disaster IMHO.

> The solution in this proposal decreases the work the VMM has to do, but in the
> long term won't remove hand coding completely. As long as we are designing
> something, what kind of bar should we target?

For this specific #VE reduction case, I think userspace doesn't need to 
do any hand coding. Userspace just treats the bits related to #VE 
reduction as configurable as reported by TDX module/KVM. And userspace 
doesn't care if the value seen by TD guest is matched with what gets 
configured by it because they are out of control of userspace.

