Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1777BC3600E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 06:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txKZh-0003Ss-UF; Wed, 26 Mar 2025 02:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1txKZL-0003Mj-RA
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 02:48:56 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1txKZI-00064V-6a
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 02:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742971732; x=1774507732;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=lGHap775uUsDXdJ0pqioIOwfjJYZBUBsKzdh01RnGGQ=;
 b=KG8MKxyfsFU1WqKIWX3ecT3tCKBigBu3hnyjt5sDQRuPiPRhRlwzw1XK
 aHttG2ih0AY7hx5A3asqh5pIRqe/8CWMsz5aEYI3lSTWGnpcJRYq3rv0a
 rKfosQFZ8qDMAVrGAxR6rNO9zMUhIf0N8puV4CECoj6RCIcweQXEFkId7
 3vbboXtxMwxRuzw1o4YfRpwxcAmXvJkbfpcxlNBFh6WJczIwM+k6jOpGY
 y/8iBcfd/JvCLuCrfVOPFrfaLd5/cacKaHTJTrovlKNAksifCbfdlgL3N
 fIN4rxKA9DXaaF+xClfOvIbkug8NoI7tGihGf64FGDtfWf9tVtIWy/xBg w==;
X-CSE-ConnectionGUID: kxwVZTRNQ1iM84F7hM31cA==
X-CSE-MsgGUID: j4zVDmZhTP+SgME5+7PExg==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="44345660"
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; d="scan'208";a="44345660"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2025 23:48:50 -0700
X-CSE-ConnectionGUID: 68MwVopJSLWzAXB4RNLlSw==
X-CSE-MsgGUID: r+iBB8MXQ2eGfmOr8YxMVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; d="scan'208";a="125182656"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2025 23:48:46 -0700
Message-ID: <46f1d5cc-9ef0-4411-93e8-399d2c7e269b@intel.com>
Date: Wed, 26 Mar 2025 14:48:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 52/52] docs: Add TDX documentation
From: Xiaoyao Li <xiaoyao.li@intel.com>
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
 <81e9d055-377c-4521-9588-a6bad60b3a6d@intel.com>
Content-Language: en-US
In-Reply-To: <81e9d055-377c-4521-9588-a6bad60b3a6d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.776, RCVD_IN_DNSWL_MED=-2.3,
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

On 3/26/2025 11:36 AM, Xiaoyao Li wrote:
> On 3/26/2025 2:46 AM, Daniel P. Berrangé wrote:
>> On Fri, Jan 24, 2025 at 08:20:48AM -0500, Xiaoyao Li wrote:
>>> Add docs/system/i386/tdx.rst for TDX support, and add tdx in
>>> confidential-guest-support.rst
>>>
>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>> ---
>>
>>> ---
>>>   docs/system/confidential-guest-support.rst |   1 +
>>>   docs/system/i386/tdx.rst                   | 156 +++++++++++++++++++++
>>>   docs/system/target-i386.rst                |   1 +
>>>   3 files changed, 158 insertions(+)
>>>   create mode 100644 docs/system/i386/tdx.rst
>>
>>
>>> +Launching a TD (TDX VM)
>>> +-----------------------
>>> +
>>> +To launch a TD, the necessary command line options are tdx-guest 
>>> object and
>>> +split kernel-irqchip, as below:
>>> +
>>> +.. parsed-literal::
>>> +
>>> +    |qemu_system_x86| \\
>>> +        -object tdx-guest,id=tdx0 \\
>>> +        -machine ...,kernel-irqchip=split,confidential-guest- 
>>> support=tdx0 \\
>>> +        -bios OVMF.fd \\
>>> +
>>> +Restrictions
>>> +------------
>>> +
>>> + - kernel-irqchip must be split;
>>
>> Is there a reason why we don't make QEMU set kernel-irqchip=split
>> automatically when tdx-guest is enabled ?
>>
>> It feels silly to default to a configuration that is known to be
>> broken with TDX. I thought about making libvirt automatically
>> set kernel-irqchip=split, or even above that making virt-install
>> automatically set it. Addressing it in QEMU would seem the most
>> appropriate place though.
> 
> For x86, if not with machine older than machine-4.0, the default 
> kernel_irqchip is set to split when users don't set a value explicitly:
> 
>   if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
>          s->kernel_irqchip_split = mc->default_kernel_irqchip_split ? 
> ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
>      }

Ah! it happens later than tdx_kvm_init(). So we need something like...

> 
> I think QEMU should only set it to split automatically for TDX guest 
> when users don't provide a explicit value. And current code just works 
> as expected.
> 
> Further, I think we can at least add the check in tdx_kvm_init() like this
> 
> if (kvm_state->kernel_irqchip_split != ON_OFF_AUTO_ON) {
>      error_setg(errp, "TDX VM requires kernel_irqchip to be split");
>      return -EINVAL;
> }

...

@@ -693,6 +694,13 @@ static int tdx_kvm_init(ConfidentialGuestSupport 
*cgs, Error **errp)
          return -EINVAL;
      }

+    if (kvm_state->kernel_irqchip_split == ON_OFF_AUTO_AUTO ) {
+        kvm_state->kernel_irqchip_split = ON_OFF_AUTO_ON;
+    } else if(kvm_state->kernel_irqchip_split != ON_OFF_AUTO_ON) {
+        error_setg(errp, "TDX VM requires kernel_irqchip to be split");
+        return -EINVAL;
+    }


> Are you OK with it?
> 
>>
>> With regards,
>> Daniel
> 
> 


