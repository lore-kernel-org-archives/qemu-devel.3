Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FAAFC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 01:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX8MF-0005MW-W2; Wed, 02 Jul 2025 21:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uX8MD-0005MD-ER
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 21:03:21 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uX8MB-0002FC-5C
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 21:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751504599; x=1783040599;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=BurwMDicF6pjfzVWChJ9QztjU6CyVHuC0U5sMXGfV0Y=;
 b=W51+imIMRUmDDcatVdW8R3jd2pV7QCfBZMF0G3U8U90PAj6fzCbmY60I
 1bC6Dgq5kCnabSHfw+GF2C5y4r3jwkZCQwjhDHm7bt0jp8ZQVvfs0IzQZ
 7YEn7j7XQLZC58Bq18QCqZ6YeyVlPzLQtQCEoLUBagaZuKZHvGYdHTJZF
 1ze5Wgmq04fKfmlW+6NVE8fLEJ7oow4o2AKXkoIn0REa/VC+BIF6KZY2C
 PN1jVpbHK7qDx3SXllwwiZEQCEA2sHp1jU+kOFaeUlvTr15IehKvkRkjQ
 OZTB/S+L4Gg7HHd9+9QQBZYCnWrORdAKFIEjF86ndlXCo0c3+DMohPjnu w==;
X-CSE-ConnectionGUID: x65FnohGRzCnjTnBSDy3AA==
X-CSE-MsgGUID: l/f5MokLR3GrRKqytkNkxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53784395"
X-IronPort-AV: E=Sophos;i="6.16,282,1744095600"; d="scan'208";a="53784395"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 18:03:15 -0700
X-CSE-ConnectionGUID: 2epG7wetR+SDC0qBStUYag==
X-CSE-MsgGUID: MQoG5J6NRribqB+JFrFu7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,282,1744095600"; d="scan'208";a="191395618"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 18:03:13 -0700
Message-ID: <a7d2691b-ce43-454e-aec9-3589787dea5c@intel.com>
Date: Thu, 3 Jul 2025 09:03:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression] Re: [PULL 35/35] qom: reverse order of
 instance_post_init calls
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Dongli Zhang <dongli.zhang@oracle.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Like Xu <like.xu.linux@gmail.com>, Igor Mammedov <imammedo@redhat.com>
References: <20250520110530.366202-1-pbonzini@redhat.com>
 <20250520110530.366202-36-pbonzini@redhat.com>
 <d429b6f5-b59c-4884-b18f-8db71cb8dc7b@oracle.com>
 <aFpocfTpBLB34N3l@intel.com> <aGKryLSGlFTMSKHv@intel.com>
 <690b5bca-4345-4ee9-a332-4c2e38532309@intel.com>
 <31387ca1-4fa0-482e-8e11-e8857c10cb6c@linaro.org>
 <aGTmFGC9vZB2yEwv@intel.com> <76f8e877-e203-421f-b301-4b321534bd8b@intel.com>
 <CABgObfY-sDqw3kPSgr8b3OycA2wZVYQLcxcavierdbr-U0S_Dw@mail.gmail.com>
 <f7545434-f51f-4cb5-b1b9-afbaa26d11e8@intel.com>
 <CABgObfax21xZDKGN9b8tH-HBVeEgTjWD-xLO6DRkr3uCvkyHQQ@mail.gmail.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <CABgObfax21xZDKGN9b8tH-HBVeEgTjWD-xLO6DRkr3uCvkyHQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/3/2025 2:54 AM, Paolo Bonzini wrote:
> Il mer 2 lug 2025, 09:25 Xiaoyao Li <xiaoyao.li@intel.com> ha scritto:
> 
>> IIRC that's on rhel QEMU which ports the TDX code before it's merged
>> upstream. Now TDX is upstreamed, it works with upstream compat property
>> and I think future new compat property won't affect TDX or anything,
>> since it's compat property and it's to guarantee the existing behavior
>> when introducing new behavior?
>>
> 
> It's a compat property that is only added by RHEL-specific machine types.
> But the bug is not specific to RHEL, it just happens that no upstream
> machine type has compat properties that overlap with TDX adjustments of
> CPUID.
> 
>> In general I don't see how the reverse order makes sense: the subclass
>>> knows what the superclass does, so it can do the right thing if it runs
>>> last; but the superclass cannot know what all of its subclasses do in
>>> post_init, so it makes less sense to run it last.
>>
>> I agree in general the parent to child order makes more sense,
>> especially when we treat .instance_init() as the phase 1 init and
>> .post_instance_init() as the phase 2 init.
>>
>> But the original purpose of introducing .post_instance_init() was to
>> ensure qdev_prop_set_globals() is called at last for Device. Reverse the
>> order breaks this purpose.
>>
> 
> Not "last", but "after instance_init". Anything that happens in the child
> class's instance_post_init can be moved at the end of instance_init, just
> like the refactoring that I did for risc-v.

Move into the end of instance_init() can surely work. But it requires to 
split the code in instance_post_init() to different child's 
instance_init() or making sure the code in instance_post_init() is 
called at the end of each lowest child class.

Besides, it also leads to a rule that child of Device's 
.post_instance_init() needs to be careful about changing the property or 
anything that might affect the property, because it might break the 
usage of global properties.

This can surely work. But to me, it seems to make code worse not better.



