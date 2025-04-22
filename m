Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A152EC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 15:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7FJq-0006sU-2h; Tue, 22 Apr 2025 11:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u7FJn-0006qy-4f
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 11:13:51 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u7FJk-0007cE-Lz
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 11:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745334829; x=1776870829;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Bgxcd9XjtbXvUZflcGiWsN+uo8SsHwB9ZsxjWrHF0fU=;
 b=nEXrbhc0NtjvXo6WHSkhIiQPLMIVLDXprvyO24B/7cVS/u5MN/YcZigE
 WPmoSyfjQRxXttaTmexY0CiKFcYx587hZYWSjjrqN8FdSe24DawrQBbig
 wrjzyXS+tO1O5bykCSmuBis0tXIr4J2CnN4osRy5JxZweBSaKvWle9W1a
 vgrVjbK9Pv/ee71rbhhJ/ZOkfklqPy04YoOuKPrypFYEBVOTL8AaPE09v
 V1GZVI133NVkWNPzCtUrxoOU2T3urjZOOZCtN0nD+1eMHLlxh1Lu4Rvje
 GrKIYbp7AAyOCPRPV5rB37uzPkNRHkdwpZHfKQFBL8cx0I9b9/DTwS8tU A==;
X-CSE-ConnectionGUID: kC+rW72gTd6MRZuvDqW9cA==
X-CSE-MsgGUID: zw8w6qh/Ri2nUuVVWlFyMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="64428907"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; d="scan'208";a="64428907"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2025 08:13:47 -0700
X-CSE-ConnectionGUID: 2ooXW54oR++0YNdnFo0P/w==
X-CSE-MsgGUID: Bm/3eorGQgSC5GPp55O1Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; d="scan'208";a="131987707"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2025 08:13:43 -0700
Message-ID: <36034796-7d26-4ce5-a024-f2436ab84f8b@intel.com>
Date: Tue, 22 Apr 2025 23:13:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest: Pass down do_connect param in
 qtest_init_with_env()
To: Steven Sistare <steven.sistare@oracle.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20250422120420.3068159-1-xiaoyao.li@intel.com>
 <0645c51e-fb07-49ff-8a58-49b29ab59a33@linaro.org>
 <0dd00d13-8286-4915-ba7f-411e353e51c9@oracle.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <0dd00d13-8286-4915-ba7f-411e353e51c9@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=xiaoyao.li@intel.com;
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

On 4/22/2025 10:48 PM, Steven Sistare wrote:
> On 4/22/2025 9:20 AM, Philippe Mathieu-Daudé wrote:
>> On 22/4/25 14:04, Xiaoyao Li wrote:
>>> The @do_connect parameter of qtest_init_with_env() is not used. Fix it
>>> by passing it down to qtest_init_with_env_and_capabilities() instead of
>>> hard coding a true.
>>>
>>> Fixes: 5357ef823a1f ("tests/qtest: defer connection")
>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>> ---
>>>   tests/qtest/libqtest.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
> 
> This is the same bug that Vladimir fixed:
> 
> https://lore.kernel.org/qemu-devel/20250410162250.329941-1- 
> vsementsov@yandex-team.ru/

Thanks for the info!

> - Steve
> 
> 
> 


