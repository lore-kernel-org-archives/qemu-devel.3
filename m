Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75B8C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 20:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMvs2-0002yI-OG; Thu, 27 Jun 2024 16:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMvrz-0002xd-My
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 16:37:27 -0400
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMvrx-0007ss-LT
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 16:37:27 -0400
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-79c0abd3ea5so134660885a.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 13:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719520644; x=1720125444; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9oK7MNDvRq6o2j7zyIf6Hgp9MpZtcoAEUoHXeXqCfUA=;
 b=KPOFKgRwg9gS5BPtAbxu+0fFJVjOZ4ne2dDs9UxI69kYfKb7m/QlC188NsetybsKaa
 MZ6CODRD3VKUG60BUbu7tneK60qOOB/yZ4ClxM7p6IXzslCpIO12ShkuMr1UxvDJM9Hm
 G/u4X7h5PpYbTqpHi1b3mpfNZe9SsKdJW9R4NyJh6+MMlv0oBIeXPHtWAslfIMVqkoSb
 girAcs25/ZsmBwA53P6Xb5xaHsY+3nmGdJPPDOr6OQwPBZxXElAhzBEkNX9pID75ntI7
 m/Wy8aCvfXNEMJEtrn8TLG9EoeP0HCrmYZ6KQXLTQEEs5GQlLpBzhe4BmI+CD1MOLn6G
 qMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719520644; x=1720125444;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9oK7MNDvRq6o2j7zyIf6Hgp9MpZtcoAEUoHXeXqCfUA=;
 b=jmOn3FJEv70j8zVP+yKaV01ZELJFKUna+WfCmPtxPpmrV1G5rkHkxh69/KHg66rEDl
 6u8IFNXE85Y5ip1+uHL3YHN4dJ5BrVdySX/isdKUH/aMpNs3xZoNPSS3ouHd3NPTZnkD
 Fflg7c8xIN7Gi0eBnG3tzMkfU2eg5LTB5rE5sxke8cAWlNebtBKVbw7YPoRtfMTUElZS
 XfMdzFdvlMZ4ayS61IjOOXA3dzXGZ0phIPsLkadliWKnLJzf4R2VxtTO7N4/jLfea3S6
 PeKn/pQZqDIlFNVcTnxEgjNBzc226Ya3wSmFoEbjgE9FxRqZCHtwfu0QxNEQRbJ2Ongv
 11Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVintyLSNJcFGiFcLMetodsysNF9isB66s7Znl59gf9POMEIST1cqRWCFtOAFCnr9mbEdEFS6JevdOP77ZeNGW9GcWoM7g=
X-Gm-Message-State: AOJu0YwBiB0QpnwSi9+v0PshNwiiySjtxKjd8OP8ndjhZIJnu8NyN+Tn
 40lwTjWFhRYOx9wCF7khChHf+SUMkkkXoylk9iTvT5X32amouK6WCYpQskA27kSCOjNRqELHRms
 j
X-Google-Smtp-Source: AGHT+IFhO5ImGsaTid5b/E2Cuq35s/g8vre+u/myrqRRYmEfG/a/1E2pTHkk6pn+MPOFoADIaMlXVQ==
X-Received: by 2002:a05:6a00:3997:b0:706:251d:d98 with SMTP id
 d2e1a72fcca58-706745933a4mr18898673b3a.4.1719518616241; 
 Thu, 27 Jun 2024 13:03:36 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-72c6d102b81sm101802a12.81.2024.06.27.13.03.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 13:03:35 -0700 (PDT)
Message-ID: <9e6c8f1c-6ba7-4cd7-a5d4-e74930b1c906@linaro.org>
Date: Thu, 27 Jun 2024 13:03:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] plugins: save value during memory accesses
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20240626233757.375083-1-pierrick.bouvier@linaro.org>
 <20240626233757.375083-3-pierrick.bouvier@linaro.org>
 <1fecfba7-6a42-405c-a32a-e82164539650@linaro.org>
 <52d4e59d-acd4-465f-8fdf-7e0cf6dc4d98@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <52d4e59d-acd4-465f-8fdf-7e0cf6dc4d98@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/27/24 12:25, Pierrick Bouvier wrote:
> On 6/27/24 12:10, Richard Henderson wrote:
>> On 6/26/24 16:37, Pierrick Bouvier wrote:
>>> Different code paths handle memory accesses:
>>> - tcg generated code
>>> - load/store helpers
>>> - atomic helpers
>>>
>>> This value is saved in cpu->plugin_state.
>>>
>>> Atomic operations are doing read/write at the same time, so we generate
>>> two memory callbacks instead of one, to allow plugins to access distinct
>>> values.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    accel/tcg/atomic_template.h   | 66 ++++++++++++++++++++++++++++----
>>>    include/qemu/plugin.h         |  8 ++++
>>>    plugins/core.c                |  7 ++++
>>>    tcg/tcg-op-ldst.c             | 72 +++++++++++++++++++++++++++++++----
>>>    accel/tcg/atomic_common.c.inc | 13 ++++++-
>>>    accel/tcg/ldst_common.c.inc   | 38 +++++++++++-------
>>>    6 files changed, 173 insertions(+), 31 deletions(-)
>>>
>>> diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
>>> index 1dc2151dafd..830e4f16069 100644
>>> --- a/accel/tcg/atomic_template.h
>>> +++ b/accel/tcg/atomic_template.h
>>> @@ -53,6 +53,14 @@
>>>    # error unsupported data size
>>>    #endif
>>> +#if DATA_SIZE == 16
>>> +# define UPPER_MEMORY_VALUE(val) int128_gethi(val)
>>> +# define LOWER_MEMORY_VALUE(val) int128_getlo(val)
>>> +#else
>>> +# define UPPER_MEMORY_VALUE(val) 0
>>> +# define LOWER_MEMORY_VALUE(val) val
>>> +#endif
>>> +
>>>    #if DATA_SIZE >= 4
>>>    # define ABI_TYPE  DATA_TYPE
>>>    #else
>>> @@ -83,7 +91,12 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, abi_ptr addr,
>>>        ret = qatomic_cmpxchg__nocheck(haddr, cmpv, newv);
>>>    #endif
>>>        ATOMIC_MMU_CLEANUP;
>>> -    atomic_trace_rmw_post(env, addr, oi);
>>> +    atomic_trace_rmw_post(env, addr,
>>> +                          UPPER_MEMORY_VALUE(ret),
>>> +                          LOWER_MEMORY_VALUE(ret),
>>> +                          UPPER_MEMORY_VALUE(newv),
>>> +                          LOWER_MEMORY_VALUE(newv),
>>> +                          oi);
>>
>> Just a nit, but tcg is consistent in using little-endian argument ordering for values
>> passed by parts.  I would prefer we continue with that.
>>
> 
> Didn't notice that, but I'll stick to this. Any preference on the naming as well while I'm 
> at it? (low/hi vs upper/lower)?

I guess we mostly use high/low, hi/lo, and variations thereof elsewhere as well.  I don't 
see any uses of upper/lower.

>> At some point we may well support 32 byte acceses, for better guest vector support.  Do we
>> have a plan for this beyond "add more fields here"?
>>
> 
> For now, I sticked to native tcg ops (up to 128 bits), with this simple solution. Do you 
> think tcg core will be extended to support more, or will helper simply load/store four 
> 128bits words, emitting four callbacks as well?

I assume we'll support a 256-bit (non-atomic) memory operation.
That avoids some of the "probe for write, perform stores after we know it's safe" sort of 
affair.

I don't think I'll do it while i686 is still a supported host though.

> If you have a better idea, I'm open to implement an alternative, but didn't want to think 
> too much ahead.

Fair.


r~


