Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D684DC4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 05:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXaxs-0005Fb-FI; Wed, 07 Feb 2024 00:59:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rXaxp-0005FS-3w
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 00:59:18 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rXaxn-00047o-BX
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 00:59:16 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40ff802496cso2168345e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 21:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707285552; x=1707890352; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Sg9hS2RK7Otcfvv/hmrq8inRApQkMSZBojAH7oLYTPo=;
 b=c7jKJiHpVQVHkoywnH1egwBr/WeC5FDiW+l5gOOrTVEyHYjexxASW7GQ4EOUSTeY3G
 jrpNDpgXrjfO/dpwFadM6mcBcPQrGlAuXIhQUJVremq3sV3kMdTwR5EM0VhuhxL4a/tN
 RO7/6O+VBghQKif4DLFNtOokK+dqHlFfTNrMdIiBSgfhzpbg4EJkia6Nk5m8p89/eRE0
 Y/mu4zUs0pgzg8JFMU/IPdV/ALoiviwxf23D9VKV5P84mD5ChGACby0oGqbmjy5lPrNH
 6klRkYrdCcTxnb4P55tlgE7sDp4XUs076r40uGcsq3JY4F5b2Ej6T6aPFhlr/j17d9BX
 ZbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707285552; x=1707890352;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Sg9hS2RK7Otcfvv/hmrq8inRApQkMSZBojAH7oLYTPo=;
 b=rIaZKIi+c3XzmO5q4tSsmYK8lPyFYumAXnlzTCO9rnIXtUWBdZLFbEt8hugfC916GE
 /vAx78IW61kVosq7HuIWVjY7LWnXHXF/0i4mFkkf+eZ59KhknACLG+dwqwxtUSqzPDPQ
 URdPAL2yEmgmZr6u2Ex44Z64sVL5TJ3sv/zZeKPia8S180f1BGThD3bEo8rTcUo6A9QI
 YBj7stbkPCPls9jp/l/rq/+IFzllu/CxR2s+cxuO0xAodZpnAi8xtz8WkxqoSX4Sz+bY
 UtOpBjSLH1yFrKzYXefa63GjX9ZXw7/VWM47r/rioD0eNmFNKsMmlbTSRUM2faFFxj0e
 BZPA==
X-Gm-Message-State: AOJu0YylXjcqpuKPmX5pUeZ2a+rciC8rRequNb/2/nD8BcyCZtnYYjq1
 X0G6wXDVlEDzOCFwWtZWKcEYW7FwfhwllxPHvl/EbzEIFmrTpTA2WrllyLJcWks=
X-Google-Smtp-Source: AGHT+IE8HFWIfTpJfF7lz6twHniMZvqIx7jKkl2UcMaRYbTvlI+TJPQGemdIXxe4EnbRMaCDF+9Wqg==
X-Received: by 2002:a05:600c:4fcf:b0:40e:f111:f259 with SMTP id
 o15-20020a05600c4fcf00b0040ef111f259mr3006924wmq.37.1707285551950; 
 Tue, 06 Feb 2024 21:59:11 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVXASj2FJaSwmd0KPfXVbAlUT3NEuxyfGs9OTPRUknUkZh5v6vRRi++wkFTe+fIWzzKiFBZmenVIR3n3g6a2684FH7/1qRnlzwm3qQVsFn7yB78876t66GsO0M9n5F1URbqjY6LFfWAe5wdcE+tZtHqAyj/5kRc12mBKqAgWvtG3sfmQ+bw9XF838QENOSCmvbiop0k0vugMg1/nCz/Xut+N92CEBzHc/4fkJty6gh1v1yP8dHNUkjLTs3pxtwIwDYr9uFpEi1FcjVkOejRCB9lOsPctFlGAQsSDQD5HbSCN4ND5R0hNZ8e/biP+1cMdX/+D1cRpa2Ic5g4IoJAzEOA
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 a11-20020a05600c348b00b0040e541ddcb1sm838578wmq.33.2024.02.06.21.59.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 21:59:11 -0800 (PST)
Message-ID: <3381ba3a-ae14-4160-b651-d88a7893189b@linaro.org>
Date: Wed, 7 Feb 2024 09:59:05 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/17] plugins: scoreboard API
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss
 <erdnaxe@crans.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
 <20240206092423.3005995-6-pierrick.bouvier@linaro.org>
 <e4db51de-a040-4c9e-93fa-64a378e4e5fa@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <e4db51de-a040-4c9e-93fa-64a378e4e5fa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/7/24 07:21, Richard Henderson wrote:
> On 2/6/24 19:24, Pierrick Bouvier wrote:
>> We introduce a cpu local storage, automatically managed (and extended)
>> by QEMU itself. Plugin allocate a scoreboard, and don't have to deal
>> with how many cpus are launched.
>>
>> This API will be used by new inline functions but callbacks can benefit
>> from this as well. This way, they can operate without a global lock for
>> simple operations.
>>
>> At any point during execution, any scoreboard will be dimensioned with
>> at least qemu_plugin_num_vcpus entries.
>>
>> New functions:
>> - qemu_plugin_scoreboard_find
>> - qemu_plugin_scoreboard_free
>> - qemu_plugin_scoreboard_new
>>
>> In more, we define a qemu_plugin_u64, which is a simple struct holding
>> a pointer to a scoreboard, and a given offset.
>> This allows to have a scoreboard containing structs, without having to
>> bring offset for all operations on a specific field.
>>
>> Since most of the plugins are simply collecting a sum of per-cpu values,
>> qemu_plugin_u64 directly support this operation as well.
>>
>> New functions:
>> - qemu_plugin_u64_add
>> - qemu_plugin_u64_get
>> - qemu_plugin_u64_set
>> - qemu_plugin_u64_sum
>> New macros:
>> - qemu_plugin_scoreboard_u64
>> - qemu_plugin_scoreboard_u64_in_struct
> 
> I think the u64 stuff should be a second patch built upon the basic scoreboard support.
> 

You're right, should be easier to review.

>> +/* A scoreboard is an array of values, indexed by vcpu_index */
>> +struct qemu_plugin_scoreboard {
>> +    GArray *data;
>> +};
> 
> Unnecessary?  Generates an extra pointer dereference for no apparent benefit.
> Alternately, might be useful for other data structure changes...
> 

Thought to change it to a typedef after removing other members. Will do 
if you noticed this too.

>> +/**
>> + * typedef qemu_plugin_u64 - uint64_t member of an entry in a scoreboard
>> + *
>> + * This field allows to access a specific uint64_t member in one given entry,
>> + * located at a specified offset. Inline operations expect this as entry.
>> + */
>> +typedef struct {
>> +    struct qemu_plugin_scoreboard *score;
> 
> Embed the struct instead?
> 

Several qemu_plugin_u64 can point to the same scoreboard, so it has to 
be a pointer. It saves a scoreboard pointer + offset for a given entry.

>> @@ -31,6 +31,9 @@ struct qemu_plugin_state {
>>         * but with the HT we avoid adding a field to CPUState.
>>         */
>>        GHashTable *cpu_ht;
>> +    /* Scoreboards, indexed by their addresses. */
>> +    GHashTable *scoreboards;
> 
> Why a hash table?  All you want is to be able to iterate through all, and add/remove
> easily.  Seems like QLIST from <qemu/queue.h> would be better, and the QLIST_ENTRY member
> would make struct qemu_plugin_scoreboard useful.
> 

Thought that having O(1) removal was a nice property, compared to a 
linked list. I can switch to a QLIST if you still think it's better.

What do you mean by "make struct qemu_plugin_scoreboard useful"?

> 
> r~

