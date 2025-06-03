Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B793DC5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 15:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMTyg-0001Gv-UI; Tue, 03 Jun 2025 11:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uMTyX-0001FW-2m; Tue, 03 Jun 2025 11:54:54 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uMTyO-0002kB-G1; Tue, 03 Jun 2025 11:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748966084; x=1780502084;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ckndGRbBgykx3hvrKZq5ul3jDJmhZp9zGHsBzhZrpL4=;
 b=GW0Xc3yltuQXoGrZHIPOAydIrCy294JUNTbvaNvGPtJiDNgc/UZV3Y3U
 7jIhSjb+CHdyRUKbEde66QK0sZATMDMkqFB+OkqpuukWJQjwcUrmZeoqS
 NjNj/Vp2sIF3dcdMJAtl/1Tfzfhk1nzXVoEGteDBGNOui9D1kU1r4+mIi
 3YOGrKeG0E1Bfr48pTI/SBct8wus3OBzY5izPCMmLQ0Zev3pzuNIcp5pC
 BbG5nxwT2XENHDNyM+ye4PJf+ji45bv6TRveH81dAJivxs4aOTnlwNfVS
 ea2mW/0bulOcP8NmqwkOyAhggH0pDXiRETO071JG01uZ3EaswamwdMIil w==;
X-CSE-ConnectionGUID: NRyWa//KQLuYcZ+NnOQaog==
X-CSE-MsgGUID: bKxMUO+nR3aVO33BjIjxlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="51084709"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="51084709"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 08:54:27 -0700
X-CSE-ConnectionGUID: K5EPnzjpRxW1CxlBmG8ljQ==
X-CSE-MsgGUID: jW/+xI8oS3Wa9JQAt7yULw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="144878872"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 08:54:23 -0700
Message-ID: <973e1fb8-e138-44bd-be73-9d53d9bed75c@intel.com>
Date: Tue, 3 Jun 2025 23:54:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/19] target/i386/cpu: Remove X86CPU::check_cpuid field
To: Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250512083948.39294-1-philmd@linaro.org>
 <20250512083948.39294-5-philmd@linaro.org>
 <ccf78c07-fc08-493f-85d8-5058cccbe82e@intel.com> <aDad5elq0bgZ/tvp@intel.com>
 <20250603170238.75a0f1de@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250603170238.75a0f1de@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 6/3/2025 11:02 PM, Igor Mammedov wrote:
> On Wed, 28 May 2025 13:23:49 +0800
> Zhao Liu <zhao1.liu@intel.com> wrote:
> 
>> On Wed, May 28, 2025 at 10:09:56AM +0800, Xiaoyao Li wrote:
>>> Date: Wed, 28 May 2025 10:09:56 +0800
>>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>>> Subject: Re: [PATCH v4 04/19] target/i386/cpu: Remove X86CPU::check_cpuid
>>>   field
>>>
>>> On 5/12/2025 4:39 PM, Philippe Mathieu-Daudé wrote:
>>>> The X86CPU::check_cpuid boolean was only set in the
>>>> pc_compat_2_4[] array, via the 'check=off' property.
>>>> We removed all machines using that array, lets remove
>>>> that CPU property and simplify x86_cpu_realizefn().
>>>
>>> No.
>>>
>>> We cannot do this. Because it changes the behavior of QEMU.
>>>
>>> 'check_cpuid' is true by default while 'enforce_cpuid' is false. So that
>>> QEMU emits warnings in x86_cpu_filter_features() by default when user
>>> requests unsupported CPU features. If remove "check" property and the
>>> internal 'check_cpuid', QEMU will not do it unless user sets enforce_cpuid
>>> explicitly.
>>
>> One option would be to have x86_cpu_filter_features() unconditionally
>> turn on verbose and print warnings, but some people might want to turn
>> off these warning prints, I don't know if anyone would, but it would be
>> possible.
>>
>> The other option is still to keep the “check” property.
>>
>> IMO, the latter option is the better way to reduce Philippe's burden.
> 
> we essentially loose warnings by default when some features aren't available,
> qemu still continues to run though.
> 
> Given that Daniel acked it from libvirt side, libvirt doesn't care about warnings
> (it does its has its own cpu model calculation). Likely other mgmt do not care
> about it either, and if they do they probably doing something wrong and
> should use QMP to get that data.
> That leaves us with human users, for that case I'd say one should use
> enforce_cpuid if feature availability matters.

But with "check", it allows the VM to continue running with the 
unsupported bits cleared and warnings to inform users. This is really 
friendly.

> so +1 to removal
>   
>>
>> Regards,
>> Zhao
>>
>>
> 


