Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A098C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubc4L-0006uc-U5; Tue, 15 Jul 2025 05:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubc3x-0005rQ-O2
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:35:03 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubc3v-0006B6-GH
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752572099; x=1784108099;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=gVsr+8cCixkAIs1k5OIyl7/e+cq+6fDNvyB/Ack6b6E=;
 b=cHgZXfEWOE9iRB9/w1/2VrfHWeyrSK8OPYM1895Ro8scF1njnhSXsm4z
 CwnB2eCMLqAHgXt38yTkB9Mil/in8c8QlATXz0PrDofruVdmRGIwtpklh
 9YWEan2Hj2El07cx+/Jk1svNIWp5BBepZNm1ux4ax8CNiIScrlyNn+X7K
 adyVXPz4ox83IkzpSYPKaiyTIStlRuJYIfGKiSad0wVpKtnVn/OBXgep/
 qWz4/AxL1h/pdyX2ktZR6hs9wR7k/ypSY1UVJO4DdBKHeNMjA2e0katM8
 OBhl8ovlIVb5E8Gfv5O+O07+FhQ/VMzGomFKzNRl/rcCJSo8C8HHJdI+j w==;
X-CSE-ConnectionGUID: baGNWh8sQIW9BUqx+ITfYg==
X-CSE-MsgGUID: Bo6OqYUxTma+XYea9FEc0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="58592256"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; d="scan'208";a="58592256"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 02:34:57 -0700
X-CSE-ConnectionGUID: A5d4uC20QpasBN1iHQVOWA==
X-CSE-MsgGUID: IY4Bzi2CTbaHVk6Q+CH0MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; d="scan'208";a="157686788"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 02:34:54 -0700
Message-ID: <50e5017b-6c1f-4d25-b5a4-247e9eacaa5d@intel.com>
Date: Tue, 15 Jul 2025 17:34:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/39] system/runstate: Document
 qemu_add_vm_change_state_handler()
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-4-philmd@linaro.org>
 <9a4fb69b-540e-4758-9168-60994f58f95c@intel.com>
 <87bjpl25e6.fsf@draig.linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <87bjpl25e6.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 7/15/2025 5:02 PM, Alex Bennée wrote:
> Xiaoyao Li <xiaoyao.li@intel.com> writes:
> 
>> On 7/4/2025 1:32 AM, Philippe Mathieu-Daudé wrote:
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>>    include/system/runstate.h | 10 ++++++++++
>>>    1 file changed, 10 insertions(+)
>>> diff --git a/include/system/runstate.h b/include/system/runstate.h
>>> index fdd5c4a5172..b6e8d6beab7 100644
>>> --- a/include/system/runstate.h
>>> +++ b/include/system/runstate.h
>>> @@ -14,6 +14,16 @@ void runstate_replay_enable(void);
>>>    typedef void VMChangeStateHandler(void *opaque, bool running, RunState state);
>>>    typedef int VMChangeStateHandlerWithRet(void *opaque, bool running, RunState state);
>>>    +/**
>>> + * qemu_add_vm_change_state_handler:
>>> + * @cb: the callback to invoke
>>> + * @opaque: user data passed to the callback
>>> + *
>>> + * Register a callback function that is invoked when the vm starts or stops
>>> + * running.
>>> + *
>>> + * Returns: an entry to be freed using qemu_del_vm_change_state_handler()
>>> + */
>>
>> qemu_add_vm_change_state_handler_prio() and
>> qemu_add_vm_change_state_handler_prio_full() put the document in the
>> implementation in system/runstate.c.
> 
> Generally APIs to the rest of QEMU should be documented in the headers.
> Comments on individual functions or internal details are fine to live in
> the C files.

I totally understand it.

I was not asking to put the document into C files, but to ...

>>
>> Please make them consistent.

... make them consistent. IOW, I would expect an additional patch to 
move the document of qemu_add_vm_change_state_handler_prio() and 
qemu_add_vm_change_state_handler_prio_full() from C files to this header 
file.

>>>    VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
>>>                                                         void *opaque);
>>>    VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
> 


