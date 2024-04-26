Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE89C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 23:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0Udf-00081L-KO; Fri, 26 Apr 2024 19:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1s0Ude-000814-92
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 19:05:54 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1s0Udc-0004vK-D8
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 19:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714172753; x=1745708753;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=XMOJK8JNiyETiFujG5JElHagjyI+SL9Uc8ODF4UE0QQ=;
 b=YA3fy0h0FO4yUIVG2lkSE8RnX7UmKOySafyGH03AlbiB5/aXY0NiDgeo
 hnHRgiHC6fZAnorf2MpS+EK9fImh1U7s+tLoF+63Wh5kh+y94ibLZAvQh
 s2RsXamWy/xBwX5QZo6xPhDI8wjnCsPJ2FmAu6aYsu0mDNJfaoNl5Z4eE
 BtnonPuk8a38n5vgMbF5mValAmkwZzGYBQkUUUgiW8Xrb+O+LkmwV3MbF
 M3xz0+2b9d5J0SHxOGGqzf8FF0U+RMLvGfRTpYto+E2XWKI/hcqodcXbY
 R4vouo90IC2woFIIrR32NIysFJEm307ny/OXmDKweszdaj6Eei3fU9TZC w==;
X-CSE-ConnectionGUID: dOmz4PpuRrqDpGRjRh9VGg==
X-CSE-MsgGUID: vCYe6ljeS/uxeQ+XOtsPCQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="9850165"
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="9850165"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2024 16:05:49 -0700
X-CSE-ConnectionGUID: hCmGHMO6Sk+2GC46ZqVfJA==
X-CSE-MsgGUID: 4gceDbsYRiaQ7n2YcGFRxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; d="scan'208";a="25531317"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.242.48])
 ([10.124.242.48])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2024 16:05:46 -0700
Message-ID: <c75723d7-353e-4208-96bc-865a227f1bac@intel.com>
Date: Sat, 27 Apr 2024 07:05:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] target/i386/confidential-guest: Fix comment of
 x86_confidential_guest_kvm_type()
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20240426100716.2111688-1-zhao1.liu@intel.com>
 <20240426100716.2111688-8-zhao1.liu@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240426100716.2111688-8-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 4/26/2024 6:07 PM, Zhao Liu wrote:
> Update the comment to match the X86ConfidentialGuestClass
> implementation.
> 
> Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>

I think it should be "Reported-by"

> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   target/i386/confidential-guest.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/confidential-guest.h b/target/i386/confidential-guest.h
> index 532e172a60b6..06d54a120227 100644
> --- a/target/i386/confidential-guest.h
> +++ b/target/i386/confidential-guest.h
> @@ -44,7 +44,7 @@ struct X86ConfidentialGuestClass {
>   /**
>    * x86_confidential_guest_kvm_type:
>    *
> - * Calls #X86ConfidentialGuestClass.unplug callback of @plug_handler.
> + * Calls #X86ConfidentialGuestClass.kvm_type() callback.
>    */
>   static inline int x86_confidential_guest_kvm_type(X86ConfidentialGuest *cg)
>   {


