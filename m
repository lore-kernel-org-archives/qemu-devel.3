Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3850C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 20:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMukT-0002Q2-K6; Thu, 27 Jun 2024 15:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sMukQ-0002Ps-N7
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 15:25:34 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sMukE-0005rQ-S2
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 15:25:34 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1fa244db0b2so46328325ad.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 12:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719516302; x=1720121102; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CvgMq3nzVUfyv0GvFsSoIqM13FRoZBViKlGqTdhLTyU=;
 b=TBN4VCLr0AJsHysAhsRQ1KDEroemwwb9h89QgS1vNxAJNRuS2IDOrmB8RPa2CFSwcl
 vX+h/rvmt+fcV/EERMx/B8OV9TR0ELsGthw/oly0crfdWzvce0NQooizb6h3pneP07yw
 mbbAw2NswSQT0qNb6fhYTnUMxH0fGZl15nhS1HXDNmwbpoqx3fXr12jAICPiyPRg1MlD
 FidBD4TSRdba2xuvHUwVvod5YuiQyirsKIyhYLNxLw2gih4O6mUhCBb4P8/VPLV2JzuV
 dxYFgKS4B8YFqR76hO+ts/hKHFg1Ro837p40c4qXyGmWXgU4LrdepE6bG5n4Uh70bsWX
 euTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719516302; x=1720121102;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CvgMq3nzVUfyv0GvFsSoIqM13FRoZBViKlGqTdhLTyU=;
 b=O8JQcHtLAr2VoBCG7uofz2+p8JCCd6Igqht8fDbbsLpLRMqWMrXJJgpc2IfPxGbbYF
 JTr9KCLD0vFarfO3XsMwYsLIf6FZvrnsZ9niR3LiSy3imKLeDnE89bXDY0r63MukDcFG
 91JykdtIP3rb/C4oV5yOv8+TnvRZmbkXWA+iy4zVjnO//fkIb/nqGOIepc4dYiiPgXpy
 9BNwjmEPFQe+25DzfLfflMhJSuM3nGdKTV+g0xqYC+fo4jvkFPDmkIAeKa13f5+BtVav
 UgUE5KGvVnZdqW5X3SE5jNm7ICMCbt7fkhvtZ92nUwSWsAyAVqPeurlZquYyqiFciJyT
 lRyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS1AfLAXkzqKjbrAfwVoyARrq5Z+VAPIDZsvnyyP/WsBX/spn7KeeS8crf1D1BVKhosN+F2F57Wr7V7s0eM1qcuDS+wy8=
X-Gm-Message-State: AOJu0YyefhaT+LnTmQODwQ/Wu0EfPMpwDF+dLq7NEPwC0YnIsCUxK19+
 7ctO7yuL7JtateBB4p4mLtwFoqHg8XhMWEuTIJj59J4/py+eyjKHWSdwEBaYJOKZKTlwkHPVkrF
 XTWs=
X-Google-Smtp-Source: AGHT+IEn9ylJajZV5DCzJuhXqBMEAxjHSYpHZEKZxL07d7sdw6l5Jnxw2a8bBVrb3H66LUHRv9ifgA==
X-Received: by 2002:a17:902:d48a:b0:1f9:cbe1:aee with SMTP id
 d9443c01a7336-1fa158d0d44mr156796475ad.7.1719516302559; 
 Thu, 27 Jun 2024 12:25:02 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::2193? ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac15b890asm1125995ad.301.2024.06.27.12.25.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 12:25:02 -0700 (PDT)
Message-ID: <52d4e59d-acd4-465f-8fdf-7e0cf6dc4d98@linaro.org>
Date: Thu, 27 Jun 2024 12:25:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] plugins: save value during memory accesses
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20240626233757.375083-1-pierrick.bouvier@linaro.org>
 <20240626233757.375083-3-pierrick.bouvier@linaro.org>
 <1fecfba7-6a42-405c-a32a-e82164539650@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <1fecfba7-6a42-405c-a32a-e82164539650@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

On 6/27/24 12:10, Richard Henderson wrote:
> On 6/26/24 16:37, Pierrick Bouvier wrote:
>> Different code paths handle memory accesses:
>> - tcg generated code
>> - load/store helpers
>> - atomic helpers
>>
>> This value is saved in cpu->plugin_state.
>>
>> Atomic operations are doing read/write at the same time, so we generate
>> two memory callbacks instead of one, to allow plugins to access distinct
>> values.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    accel/tcg/atomic_template.h   | 66 ++++++++++++++++++++++++++++----
>>    include/qemu/plugin.h         |  8 ++++
>>    plugins/core.c                |  7 ++++
>>    tcg/tcg-op-ldst.c             | 72 +++++++++++++++++++++++++++++++----
>>    accel/tcg/atomic_common.c.inc | 13 ++++++-
>>    accel/tcg/ldst_common.c.inc   | 38 +++++++++++-------
>>    6 files changed, 173 insertions(+), 31 deletions(-)
>>
>> diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
>> index 1dc2151dafd..830e4f16069 100644
>> --- a/accel/tcg/atomic_template.h
>> +++ b/accel/tcg/atomic_template.h
>> @@ -53,6 +53,14 @@
>>    # error unsupported data size
>>    #endif
>>    
>> +#if DATA_SIZE == 16
>> +# define UPPER_MEMORY_VALUE(val) int128_gethi(val)
>> +# define LOWER_MEMORY_VALUE(val) int128_getlo(val)
>> +#else
>> +# define UPPER_MEMORY_VALUE(val) 0
>> +# define LOWER_MEMORY_VALUE(val) val
>> +#endif
>> +
>>    #if DATA_SIZE >= 4
>>    # define ABI_TYPE  DATA_TYPE
>>    #else
>> @@ -83,7 +91,12 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, abi_ptr addr,
>>        ret = qatomic_cmpxchg__nocheck(haddr, cmpv, newv);
>>    #endif
>>        ATOMIC_MMU_CLEANUP;
>> -    atomic_trace_rmw_post(env, addr, oi);
>> +    atomic_trace_rmw_post(env, addr,
>> +                          UPPER_MEMORY_VALUE(ret),
>> +                          LOWER_MEMORY_VALUE(ret),
>> +                          UPPER_MEMORY_VALUE(newv),
>> +                          LOWER_MEMORY_VALUE(newv),
>> +                          oi);
> 
> Just a nit, but tcg is consistent in using little-endian argument ordering for values
> passed by parts.  I would prefer we continue with that.
> 

Didn't notice that, but I'll stick to this. Any preference on the naming 
as well while I'm at it? (low/hi vs upper/lower)?

> 
>> @@ -142,9 +142,13 @@ struct qemu_plugin_tb {
>>    /**
>>     * struct CPUPluginState - per-CPU state for plugins
>>     * @event_mask: plugin event bitmap. Modified only via async work.
>> + * @mem_value_upper_bits: 64 upper bits of latest accessed mem value.
>> + * @mem_value_lower_bits: 64 lower bits of latest accessed mem value.
>>     */
>>    struct CPUPluginState {
>>        DECLARE_BITMAP(event_mask, QEMU_PLUGIN_EV_MAX);
>> +    uint64_t mem_value_upper_bits;
>> +    uint64_t mem_value_lower_bits;
>>    };
> 
> At some point we may well support 32 byte acceses, for better guest vector support.  Do we
> have a plan for this beyond "add more fields here"?
>

For now, I sticked to native tcg ops (up to 128 bits), with this simple 
solution. Do you think tcg core will be extended to support more, or 
will helper simply load/store four 128bits words, emitting four 
callbacks as well?

If you have a better idea, I'm open to implement an alternative, but 
didn't want to think too much ahead.

> 
> r~

