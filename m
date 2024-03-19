Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 945A8C54E68
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 21:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmh2U-0001II-Aq; Tue, 19 Mar 2024 17:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmh2P-0001Hr-AP
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 17:30:26 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmh2N-0002Jq-Pu
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 17:30:25 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1e00896dfdcso19257075ad.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 14:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710883822; x=1711488622; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lW4bbb2JYms/vXLSdYHZmwdCk5uIix2ek6uHW6mkSFk=;
 b=kopHQ7jnrWgN5+2kdJqTbLjfYhYmnnf3MOjt3cb3jdt2WYmOsMvEzMCIXTOF9Zgr7h
 6PAWTa4PydHZOHvs2NY4S1Wv+Jt9VrLtLR7Sm+NDbkFjzffczDBFB0Zg2IadZUWANXuW
 Ut7SwKghqbJ3Ia3r1G9dbFFsKRXE9Pv1HN83ujxfiltVsEiaF+IUQrZ8/V8OmBG8/2S+
 9qXHERjyM3W50snMk41aYraBTmQiF1Rxm7qoNTDA30u/P4jDTJWLplSc3cikvfquM/Zd
 8hpuIFmt9t15aHSyMiXhw7xD5be5oq3e31KsqfIk5AD1KOu10AvWf3RL0vccCXDQXqNg
 +UyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710883822; x=1711488622;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lW4bbb2JYms/vXLSdYHZmwdCk5uIix2ek6uHW6mkSFk=;
 b=lZ+Qct3kcvTFOOjAUp0B+0SRlQy/9ZiwfWDQOo7mQ1j3F7JhSkqviQqFCIwUlkEosr
 dZJ6A04wETILjCR8qmzCN8QHiIoLlHAnpY24h3UZmw46F52tE8PrEw0UbiJzDlu/VOtK
 QC0SIBpAX1u4YWhdl8+82HmVBGwPPqZtEqfsza4PKLrVPNZm5d4SyeM/uGjuAqqTLOEp
 1HgiVinJuHX5eQYbGBXAgxbU7MNOdzdHN0KI9v0035R46MUs1eIB9S+fvjCOZOFf5BTB
 0rvOjidOS+I4wlsw54eVLFyoNgQ0Dbi4e8o0Lk55YmzB4if1zGPFAQ/j1qcxblhBNAEp
 mBFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgQFx6en8aE2DMEewxbOmWnJPQaqxzjnrAqF0CRLF8CxVZ8i27YkB19O+WstyLHwyKDnwVuJyUFeXA+HPL/EqWu85T3Eo=
X-Gm-Message-State: AOJu0YyiDXP0AVO1cqynGzda1Zozlzz3SUjeX4qjYdHyQ7CyHgYpItqT
 PNYkj4KNtOaKyLgUOTHfdtCCaWzrBDVSxI24eRiW8qFLJnESO7frTzxvxLyk3yk=
X-Google-Smtp-Source: AGHT+IHe2WFWN0apW68/LqT6hLfWvVKJaTbnTAeLCZIWVJIdZNCgNZAfe2PvtAQswDCEbGBMdCrbTg==
X-Received: by 2002:a17:903:2b03:b0:1df:dc5:cd7b with SMTP id
 mc3-20020a1709032b0300b001df0dc5cd7bmr5059647plb.19.1710883822037; 
 Tue, 19 Mar 2024 14:30:22 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 l4-20020a170902d34400b001dd63a468c7sm11944774plk.292.2024.03.19.14.30.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 14:30:21 -0700 (PDT)
Message-ID: <49273724-0c8c-49e0-b626-bd0bb10a2b47@linaro.org>
Date: Tue, 19 Mar 2024 11:30:18 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/22] plugins: Move function pointer in qemu_plugin_dyn_cb
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
 <20240316015720.3661236-6-richard.henderson@linaro.org>
 <aeeb7f81-1e43-4a89-bec3-faf047e4d53a@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <aeeb7f81-1e43-4a89-bec3-faf047e4d53a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 3/19/24 03:18, Pierrick Bouvier wrote:
> On 3/16/24 05:57, Richard Henderson wrote:
>> The out-of-line function pointer is mutually exclusive
>> with inline expansion, so move it into the union.
>> Wrap the pointer in a structure named 'regular' to match
>> PLUGIN_CB_REGULAR.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/qemu/plugin.h  | 4 +++-
>>   accel/tcg/plugin-gen.c | 4 ++--
>>   plugins/core.c         | 8 ++++----
>>   3 files changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
>> index 12a96cea2a..143262dca8 100644
>> --- a/include/qemu/plugin.h
>> +++ b/include/qemu/plugin.h
>> @@ -84,13 +84,15 @@ enum plugin_dyn_cb_subtype {
>>    * instance of a callback to be called upon the execution of a particular TB.
>>    */
>>   struct qemu_plugin_dyn_cb {
>> -    union qemu_plugin_cb_sig f;
>>       void *userp;
>>       enum plugin_dyn_cb_subtype type;
>>       /* @rw applies to mem callbacks only (both regular and inline) */
>>       enum qemu_plugin_mem_rw rw;
>>       /* fields specific to each dyn_cb type go here */
>>       union {
>> +        struct {
>> +            union qemu_plugin_cb_sig f;
>> +        } regular;
>>           struct {
>>               qemu_plugin_u64 entry;
>>               enum qemu_plugin_op op;
> 
> While we are cleaning this, maybe this could be only a union (moving rw and userp to 
> fields), and only type + union would be used.
> Even if we duplicate userp in regular, and mem_cb, it would be much more readable.
> For instance, userp is never used by inline operations.

I was wondering about this.  But I was also thinking about your follow-on patch set to add 
conditional calls: do we want a multiplicity of union members, or will we want separate 
bits and pieces that can be strung together?

E.g.

     TCGCond cond;  /* ALWAYS, or compare entry vs imm. */

     /* PLUGIN_CB_REGULAR_COND or PLUGIN_CB_INLINE_* */
     qemu_plugin_u64 entry;
     uint64_t imm;

     /* PLUGIN_CB_REGULAR_* */
     union qemu_plugin_cb_sig f;
     void *userp;


r~

