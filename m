Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936FCC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 01:58:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u72tW-0003tL-UO; Mon, 21 Apr 2025 21:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u72tS-0003t2-Sw
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 21:57:51 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u72tP-00043p-Sn
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 21:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745287068; x=1776823068;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=WSg3yAksk3+amaTzHotCZyJnbH7KPtqMD2YpGk1S2/w=;
 b=HJyjFqZnQuxygZmQ80BEiM2rbS5Ai6Pp/b7JbNIzMny8iO49tA5y35IS
 bYk0UO3mZ9EWM/5eMyVpDAeJd11hV1FJhQmTFxkHYcsOQlSc8UcKJ2QEH
 dOvAOfAsXPL09KFe7sTwyaiupHTQamo+CkZpGdenv1wdkO1RntTCiKM5g
 IW7VESnVhEQzxKNYIGbt3r31lThOGJp5rHsHJjTKKRe+cLkVoSPmDZN+y
 DdUxsPz7Y4sHN4gDjj2u53oaFN7lteVD8uhmjlOpmRi5K28gugCcyNF89
 XhomPFo88etXs7q4/maU9/HHWVt2Mewg6e0IxvrIXsAnXoVmYwdC/ZkWN Q==;
X-CSE-ConnectionGUID: VTLI/zRIQjWw2JfdC4hDAw==
X-CSE-MsgGUID: j/JOauJ9QMORTchrFGGmfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="50631963"
X-IronPort-AV: E=Sophos;i="6.15,229,1739865600"; d="scan'208";a="50631963"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2025 18:57:43 -0700
X-CSE-ConnectionGUID: PKaPLvmkSXuN8so6SDWidQ==
X-CSE-MsgGUID: hTyQRzKmTCSy0Z8daxX+FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,229,1739865600"; d="scan'208";a="132182864"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2025 18:57:40 -0700
Message-ID: <6856e8e5-1f29-4b61-99d0-da08aa935605@intel.com>
Date: Tue, 22 Apr 2025 09:57:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/55] *** HACK *** linux-headers: Update headers to
 pull in TDX API changes
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-2-xiaoyao.li@intel.com> <aAIfx8P20K5YsfZd@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aAIfx8P20K5YsfZd@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=xiaoyao.li@intel.com;
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

On 4/18/2025 5:47 PM, Zhao Liu wrote:
>>
>> diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
>> index 86f2c34e7afa..baca2d479365 100644
>> --- a/linux-headers/asm-x86/kvm.h
>> +++ b/linux-headers/asm-x86/kvm.h
>> @@ -925,4 +925,73 @@ struct kvm_hyperv_eventfd {
>>   #define KVM_X86_SNP_VM		4
>>   #define KVM_X86_TDX_VM		5
>>   
>> +/* Trust Domain eXtension sub-ioctl() commands. */
> 
> Typo? s/eXtension/Extension/
> 
>> +enum kvm_tdx_cmd_id {
>> +	KVM_TDX_CAPABILITIES = 0,
>> +	KVM_TDX_INIT_VM,
>> +	KVM_TDX_INIT_VCPU,
>> +	KVM_TDX_INIT_MEM_REGION,
>> +	KVM_TDX_FINALIZE_VM,
>> +	KVM_TDX_GET_CPUID,
>> +
>> +	KVM_TDX_CMD_NR_MAX,
>> +};
>> +
>> +struct kvm_tdx_cmd {
>> +	/* enum kvm_tdx_cmd_id */
>> +	__u32 id;
>> +	/* flags for sub-commend. If sub-command doesn't use this, set zero. */
> 
> Typo?  s/sub-commend/sub-command/, this line have these 2 cases.
>

They (it and above) were synced from Linux headers. It needs to reported 
to KVM and fixed there.

