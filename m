Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F87C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 08:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7VCn-0003Re-CN; Wed, 23 Apr 2025 04:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u7VCk-0003R7-U6
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 04:11:38 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u7VCg-00076W-HV
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 04:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745395894; x=1776931894;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=chEnwpQ8zN7dF3pOvst/t9yMWUDQ7zc3w9sBS+AIuN8=;
 b=JBXAYA2T3zLSFV6jgpGQfs1vdFcqAxN+Io50oP1DFIYTokvL7D5Urp7e
 lF2BN8fdODwGCXYUBtWwj7wKCUgauLy3hbrjFmMXAJa5K8ESGD4fpGx2Y
 dka7mPuT8+pn2ibxBjCsbz5s8uY7c695otdp8idMi20BEvmX79Q2ccTPw
 pWFBGWN+w6y6YtY+OgHZU3FvPGnGK7YSS3TT8Ew2sWn32dkHIeOqNc1Rt
 Ga+8MApEbeKdE3parrXVtOUeu3FxmaEaBAmr0v19UXmgLfxTfLoX2xoKm
 FrGNqFYHVd+RnQBgRfS7KLY/PmAojDUCkE4zFFlMvrFDIrSzaTr6nd3ZU g==;
X-CSE-ConnectionGUID: b5mctRhoRoGi70dPRaqY5A==
X-CSE-MsgGUID: Kgt6WCmSQai1eJEAGlXASA==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="49642563"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="49642563"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 01:11:32 -0700
X-CSE-ConnectionGUID: 3f+OziVsRR6fQ3Z7Izuijg==
X-CSE-MsgGUID: L5R0oXV5Tpuz634yYsxIrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="137321538"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 01:11:29 -0700
Message-ID: <e67699a5-8b62-45a0-8cf1-586440ec85ee@intel.com>
Date: Wed, 23 Apr 2025 16:11:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 13/55] i386/tdx: Support user configurable
 mrconfigid/mrowner/mrownerconfig
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-14-xiaoyao.li@intel.com> <aAe49odpsz108aZb@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aAe49odpsz108aZb@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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

On 4/22/2025 11:42 PM, Zhao Liu wrote:
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index f229bb07aaec..a8379bac1719 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -1060,11 +1060,25 @@
>>   #     pages.  Some guest OS (e.g., Linux TD guest) may require this to
>>   #     be set, otherwise they refuse to boot.
>>   #
>> +# @mrconfigid: ID for non-owner-defined configuration of the guest TD,
>> +#     e.g., run-time or OS configuration (base64 encoded SHA384 digest).
>> +#     Defaults to all zeros.
> 
> Maybe a typo? s/Defaults/Default/

(It) defaults to all zeros.

If you grep the "defaults to", you can get a lot of it.

>> +#
>> +# @mrowner: ID for the guest TD’s owner (base64 encoded SHA384 digest).
>> +#     Defaults to all zeros.
> 
> Ditto.
> 
>> +#
>> +# @mrownerconfig: ID for owner-defined configuration of the guest TD,
>> +#     e.g., specific to the workload rather than the run-time or OS
>> +#     (base64 encoded SHA384 digest).  Defaults to all zeros.
>> +#
>>   # Since: 10.1
>>   ##
>>   { 'struct': 'TdxGuestProperties',
>>     'data': { '*attributes': 'uint64',
>> -            '*sept-ve-disable': 'bool' } }
>> +            '*sept-ve-disable': 'bool',
>> +            '*mrconfigid': 'str',
>> +            '*mrowner': 'str',
>> +            '*mrownerconfig': 'str' } }
>>   
> 
> Overall LGTM, (with Daniel's comment fixed,)
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> 
> 


