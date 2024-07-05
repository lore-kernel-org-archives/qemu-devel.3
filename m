Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F91C30653
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 00:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPWtI-0001rZ-3e; Thu, 04 Jul 2024 20:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sPWtG-0001r7-IJ
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 20:33:30 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sPWtE-0008MY-Gx
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 20:33:30 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70af81e8439so889979b3a.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 17:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720139603; x=1720744403; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BORRlieUou2cb86baxlfY/Ctl0TtXeE4XD7UnWB5qX8=;
 b=ieIfiRxZd64DNA7PddgO6C9rriQJT6eKU/e7w4kOiN31wRJiKAwn6JUmPoGlM+xy6e
 auAhXYhYG6jtE6J1GVHDiw13Vhb9UKlE4VpFziAp9jkiOgo1x2hdYLMf6bKIOzKklNnj
 WZwSELYyUkcA+QIvi2F5JbsQX0D8F7T2bndf5ws0aAwEEs5Bn6/rxGUtvQpeCALRT1Tc
 3cxn3I0bb5yJi46Za9YCur1EES1R/0LcQbxBcQmivMP/stOGj1hLkeYJ0tAXcJnTbBCW
 f/5BsiRwFbASK2FT6YQeZyrKWeQiwp6YY0pQoWdsG4CVZXIuTLTRv2lFbJ7uvFYCCr6G
 kXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720139603; x=1720744403;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BORRlieUou2cb86baxlfY/Ctl0TtXeE4XD7UnWB5qX8=;
 b=BHonBL3c3i2APdv4sbv1hyqZWJtvww/c16dJrOZid3Di18iRYCv+HLYxYPYKCzgokz
 QnH6OM6QL9yP+I6FJqKnDCU7Ccu8YuIZjwpjRl8O+t57RqVWenbqsKqTnvMtUelDNXdo
 wINIhV+p7MylFFBDfBtAMmO7bwZeRw2hZaTvNRIjdOkL/9TLxtxW4g3HrGAnTkM5K0QE
 qp7/DPX0orUCASuXNUgi42ZB3k47pwvDAOv/QH3Ic7a83hmD51mygAW/x04KDCxwSpDg
 4JSGSeLspMIx3ZMiBFsDDjXN/QM58IFV+4fTQNHry2oM27Asu/EZJKwmrjyPBeaLkHds
 UVmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULhgfbgFRhd8WqdB16CQQOHUQmry3+IW6199AZcFdOK+Xk9zKZTKq3jlQrlFSprlX2WcpKSMJRdDFJCwJa3AdU3QPXoEM=
X-Gm-Message-State: AOJu0YxfhZ5EFtKnTStJfdlaOFXeB7CsKJFR8IATINaLTKwxWj7q7+Tn
 qP7WwEHXysrUkvmdVDy3uZJeTEbukPRE5YX6VaEJFWK+B2YyIt2mWi8Ww6RtxuM=
X-Google-Smtp-Source: AGHT+IGZaKOdTl8EFLs/xt7c1LX1RYnxRHw/UDSBW2bcETAZFAifWJKcqDu2epyujIVJCKv3XHydjg==
X-Received: by 2002:a05:6a00:1909:b0:705:9748:7bb8 with SMTP id
 d2e1a72fcca58-70b00ac9852mr2891988b3a.29.1720139602990; 
 Thu, 04 Jul 2024 17:33:22 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::2193? ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70801e63218sm13259468b3a.11.2024.07.04.17.33.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 17:33:22 -0700 (PDT)
Message-ID: <d754f850-dbdd-4af1-b2cf-0129180d23c0@linaro.org>
Date: Thu, 4 Jul 2024 17:33:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] plugins: save value during memory accesses
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240702184448.551705-1-pierrick.bouvier@linaro.org>
 <20240702184448.551705-3-pierrick.bouvier@linaro.org>
 <1118b3e7-31c7-4918-a63a-e9b9279941c4@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <1118b3e7-31c7-4918-a63a-e9b9279941c4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

On 7/3/24 11:58, Richard Henderson wrote:
> On 7/2/24 11:44, Pierrick Bouvier wrote:
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
>> For now, we can have access only up to 128 bits, thus split this in two
>> 64 bits words. When QEMU will support wider operations, we'll be able to
>> reconsider this.
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
> 
> It looks correct so,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Possibilities for follow-up improvement:
> 
> 
>> --- a/tcg/tcg-op-ldst.c
>> +++ b/tcg/tcg-op-ldst.c
>> @@ -148,14 +148,24 @@ static TCGv_i64 plugin_maybe_preserve_addr(TCGTemp *addr)
>>        return NULL;
>>    }
>>    
>> +#ifdef CONFIG_PLUGIN
>>    static void
>> -plugin_gen_mem_callbacks(TCGv_i64 copy_addr, TCGTemp *orig_addr, MemOpIdx oi,
>> +plugin_gen_mem_callbacks(TCGv_i64 value_low, TCGv_i64 value_high,
>> +                         TCGv_i64 copy_addr, TCGTemp *orig_addr, MemOpIdx oi,
>>                             enum qemu_plugin_mem_rw rw)
>>    {
>> -#ifdef CONFIG_PLUGIN
>>        if (tcg_ctx->plugin_insn != NULL) {
>>            qemu_plugin_meminfo_t info = make_plugin_meminfo(oi, rw);
>>    
>> +        TCGv_ptr plugin_state = tcg_temp_ebb_new_ptr();
>> +        tcg_gen_ld_ptr(plugin_state, tcg_env,
>> +                       offsetof(CPUState, plugin_state) - sizeof(CPUState));
>> +        tcg_gen_st_i64(value_low, plugin_state,
>> +                       offsetof(CPUPluginState, mem_value_low));
>> +        tcg_gen_st_i64(value_high, plugin_state,
>> +                       offsetof(CPUPluginState, mem_value_high));
> 
> Maybe better to place this data at the beginning of CPUNegativeOffsetState?
> This would eliminate a load dependency and most hosts would be able to use (relatively)
> small negative offset efficiently.
> 

That's a good suggestion. Moved it here for v5.

>> +static void
>> +plugin_gen_mem_callbacks_i32(TCGv_i32 val,
>> +                             TCGv_i64 copy_addr, TCGTemp *orig_addr,
>> +                             MemOpIdx oi, enum qemu_plugin_mem_rw rw)
>> +{
>> +#ifdef CONFIG_PLUGIN
>> +    if (tcg_ctx->plugin_insn != NULL) {
>> +        TCGv_i64 ext_val = tcg_temp_ebb_new_i64();
>> +        tcg_gen_extu_i32_i64(ext_val, val);
>> +        plugin_gen_mem_callbacks(ext_val, tcg_constant_i64(0),
> 
> This zero extension got me to thinking:
> (1) why zero extension and not sign-extension based on MO_SIGN from oi?

This was to truncate upper value, but as you mentioned, I simply clip it 
later, so it's not important.

> (2) given that the callback will have oi, do we really need any extension
>       at all here?  We could allow the bits outside oi be garbage.
>       This would eliminate the store to value_high entirely for most ops,
>       and would allow this i32 op to avoid the extension -- simply perform
>       a 32-bit store into the low half of value_low.
> 

I implemented selective store for plugin_gen_mem_callbacks function for 
next version.

However, for helpers based memory accesses, I prefer to keep existing 
version. It would require to create several small functions 
(atomic_trace_rmw_post, plugin_load/store_cb and qemu_plugin_vcpu_mem_cb 
for every size). It's something that could be desirable later when we'll 
introduce bigger tcg word size though.

> That appears to be what you're doing anyway with qemu_plugin_mem_value in the next patch.
> 
> 
> r~

