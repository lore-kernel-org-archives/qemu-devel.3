Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515F1C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 05:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN2uZ-00058T-Vr; Thu, 05 Jun 2025 01:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uN2uY-00058C-M4
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 01:13:06 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uN2uW-0002Wg-L3
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 01:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749100384; x=1780636384;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=xjL1VkpiH64v84dOuynYANN0uWV5PCk6ijFnOq/cFZA=;
 b=ZQKc1yGKAchzt4sD7iJ++JyNBjy65QiMmBHXLi78SCduMf6sUFP31A1p
 7BgV6A+mDy/MiIuxXMYUXTlX6v2CZTcmnOGIc/TIeZ6zZ42UFodgXog9u
 +hrBLCMWroOCrArtsqI2TsUPEOkmtQf0JNKYwmOiBNid0Rgg1cmS0eJaz
 mtK7enR02IVadi+xZMtXZepPm+4tqxVf986chp6qI34gB+qhXKLWS43K7
 U5xfTzpYT02F1CZvl+Vtmjhabf8+gc0QlsHO/li/3G8c+Qn6xZ0p3L35E
 LMPcN7zsTGgS/AX5HrQ9vydthUk62QwD23wmVpM/rJdjU+e44J0GJc3ro Q==;
X-CSE-ConnectionGUID: mpSAOrYtSPSwjYKfh7xvgQ==
X-CSE-MsgGUID: /p7WvaduTCWbtUigefzrlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="61872138"
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; d="scan'208";a="61872138"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 22:13:00 -0700
X-CSE-ConnectionGUID: 6V1MCzKLSD2Ge2tCaq50Lw==
X-CSE-MsgGUID: AHkDeYZdRbq5LycSPMtuAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; d="scan'208";a="168566329"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 22:12:56 -0700
Message-ID: <71a11a41-b323-4db5-b769-9a385650d64c@intel.com>
Date: Thu, 5 Jun 2025 13:12:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] hw/i386/pc: Remove deprecated 2.10, 2.11 and 2.12 PC
 machines
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250501223522.99772-1-philmd@linaro.org>
 <4ac8c8b0-700b-4fac-ae4c-6531fc6b682e@intel.com>
 <0c0545dc-6ce1-4580-9d21-6f31d39e0125@linaro.org>
 <6a1d2339-5656-4b65-aae3-6db2cab29e79@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <6a1d2339-5656-4b65-aae3-6db2cab29e79@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

On 6/4/2025 3:14 PM, Philippe Mathieu-Daudé wrote:
> On 4/6/25 09:07, Philippe Mathieu-Daudé wrote:
>> On 4/6/25 03:30, Xiaoyao Li wrote:
>>> On 5/2/2025 6:35 AM, Philippe Mathieu-Daudé wrote:
>>>> The versioned 'pc' and 'q35' machines up to 2.12 been marked
>>>> as deprecated two releases ago, and are older than 6 years,
>>>> so according to our support policy we can remove them.
>>>>
>>>> This series includes the 2.10 to 2.12 machines removal.
>>>
>>> For this series,
>>>
>>> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>
>> Thanks!
>>
>>> Besides, please add more patches to remove hw_compat_2_{10,11,12}
>>
>> Are you asking for this series which was posted more than one month ago?
>> https://lore.kernel.org/qemu-devel/20250501230129.2596-1- 
>> philmd@linaro.org/

Sorry that I didn't notice this series. (It would be helpful if call out 
the removal of hw_compat_2_* will be in a separate series in the cover 
letter.)

> Actually looking for it (sorry, this was quite some time now) I realized
> I did the work up to removing 4.0:
> 
> $ git log x86_deprec
> commit acc32b99be93105267805d08b6803ce85d4fb997
> Author: Philippe Mathieu-Daudé <philmd@linaro.org>
> Date:   Tue Apr 29 17:52:38 2025 +0200
> 
>      hw/i386/pc: Remove pc_compat_4_0[] array
> 
>      The pc_compat_4_0[] array was only used by the pc-q35-4.0,
>      pc-q35-4.0.1 and pc-i440fx-4.0 machines, which got removed.
>      Remove it.
> 
>      Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> commit 659443241b5bf8266af8a2a3f2bde249564498af
> Author: Philippe Mathieu-Daudé <philmd@linaro.org>
> Date:   Tue Apr 29 17:51:09 2025 +0200
> 
>      hw/i386/pc: Remove deprecated pc-q35-4.0[.1] and pc-i440fx-4.0 
> machines
> 
>      These machines has been supported for a period of more than 6 years.
>      According to our versioned machine support policy (see commit
>      ce80c4fa6ff "docs: document special exception for machine type
>      deprecation & removal") they can now be removed.
> 
>      Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> commit d21784220e5d251bc2cfe588a04e3842cde3d8f9
> Author: Philippe Mathieu-Daudé <philmd@linaro.org>
> Date:   Tue Apr 29 16:55:39 2025 +0200
> 
>      hw/i386/pc: Remove pc_compat_3_1[] array
> 
>      The pc_compat_3_1[] array was only used by the pc-q35-3.1
>      and pc-i440fx-3.1 machines, which got removed. Remove it.
> 
>      Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> ...
> 
> At some point I had too many series waiting for review so I stopped 
> posting (otherwise having to constantly rebase / repost drains too
> much energy on both author and reviewers). I might post them once
> the prerequisites are all merged.

Good news is that the removal of PC machine 2.4 and 2.5 is merged. Hope 
the remaining can be merged soon.

> Regards,
> 
> Phil.
> 


