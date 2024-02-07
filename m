Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6D9C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 06:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXb0e-00074N-5v; Wed, 07 Feb 2024 01:02:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rXb0Z-00073i-0u
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 01:02:07 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rXb0X-0004sD-Bb
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 01:02:06 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3394b892691so120751f8f.1
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 22:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707285724; x=1707890524; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ahIZJWO8IcjO8VXUvycQSMt1kOmWp3h3kyW0MQNuLfA=;
 b=NTYp8vnDzkdL1ApEn50b7pPiV/f6fJvxKrdBCRiGr8/uqaT//PnuBXrPYsiWIrmLAG
 2PIWsn7wr7MLic/a03uHGSNZzXpMU0+gHmv+GT9U9F+S7yyEzWVg5JMXxiVnYpzcCJY1
 QgKkBOmOObphodGsmUwdvFw+JHgRGpzvgz6+HanuO5pgZYa0P3lrKPU/U+MyBEb8NSCO
 8an/7N2P4LFLApYnmmdhnR47W+ZsiUe4vXlLKJy1H90XVbd1W9HIkk6M0ryrkSECbjdr
 yTkgJN5JzQRow9X5lYfLAtEClg/KhyxNERquvJpe7LVir2dfL6w0y5xf7al7Oy73KfrG
 MCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707285724; x=1707890524;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ahIZJWO8IcjO8VXUvycQSMt1kOmWp3h3kyW0MQNuLfA=;
 b=SD56F1acYtK1n3GgOdscjglU9AoGjJMFVXhaIS0sKD9rFIkLwU0EsT0X7og4BI3nVZ
 KDF8OysV0+MLwz7A7qEVB0ukZ7vcia5J6VJx/j9I0ldJ4yNrePTyoN2FGzXGnGxxn6Vv
 VSZg7a8rfh28vGw9citPgk7qX2fQQmacTK80wnwI5Dt+BZkzW6qTr0Eb5CcoFaYgSBf2
 3ZCtOHYJ77ccAyNNbWNynwgWwFo0vd3DxAOM5GgnGLlci4WYVvXfr9ffYnoaD3S2IGS7
 wsr3wCGhEh/LyP0+vzNlro3z9TQgeRmwdiFYNRWQivdxPIFz4jMcFlZY87FipT/R4cqg
 oJHw==
X-Gm-Message-State: AOJu0YyOvTH19QsX+0jYZl3fPJ6U46Q6gyZc61iSqGQsZ08IInWy6n0u
 GZ8MRdbtdIiQ+lt/tI9eMFbkgFTnZsgtgCu5fRQ4u1VCil9hSQgY29F28ARssqI=
X-Google-Smtp-Source: AGHT+IFObtntpFyiIrqFEsJ5V8Okn4IlRmKNvz84tl2O7nh5MY2NEJ+vwAdE9LSM2R2YkS43b81M4g==
X-Received: by 2002:a5d:55cd:0:b0:33a:ec4d:76a5 with SMTP id
 i13-20020a5d55cd000000b0033aec4d76a5mr2642769wrw.29.1707285723755; 
 Tue, 06 Feb 2024 22:02:03 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUdgi0TX1/r5wxoX4qdWeIo6yZX5c+pcFggGAvq0hhYm25Q/8cI8HIBe4Z27kvLdYbFuRFxiZTVMwI4H4k5Y+Zmxxo45nw06Ho5xKQUI6xOqM7BKUpKYdZyQ5eg80DanGX9RkO4f32ciCFNBg/q4F7+3Im5/lw6ZgzLDK9q+mhiuYYAjFyYHtCh9zbTwLiXKPVJGBHu6AUiPTjwaP9eW98mBPSK+yeTg0NOldgQ6AWQ9aUhuxeuJhoHlFgbVPbX7D2whfVHbn2KC8cBk4FnOq47zcgqfQIJEpu2LBDayngr4KFYuGCndfLfbPlnEctkZtWhVnKlxt7j+xd9s+3HqpvZ
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a5d59a3000000b0033b3d2d4979sm591373wrr.23.2024.02.06.22.02.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 22:02:03 -0800 (PST)
Message-ID: <1f483920-b99d-4d5c-9f9a-423f79986c23@linaro.org>
Date: Wed, 7 Feb 2024 10:01:58 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/17] plugins: implement inline operation relative to
 cpu_index
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss
 <erdnaxe@crans.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
 <20240206092423.3005995-8-pierrick.bouvier@linaro.org>
 <1838c7f7-db41-4328-b75b-6b392f600bd2@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <1838c7f7-db41-4328-b75b-6b392f600bd2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x42c.google.com
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

On 2/7/24 07:42, Richard Henderson wrote:
> On 2/6/24 19:24, Pierrick Bouvier wrote:
>> Instead of working on a fixed memory location, allow to address it based
>> on cpu_index, an element size and a given offset.
>> Result address: ptr + offset + cpu_index * element_size.
>>
>> With this, we can target a member in a struct array from a base pointer.
>>
>> Current semantic is not modified, thus inline operation still targets
>> always the same memory location.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    plugins/plugin.h       |  2 +-
>>    accel/tcg/plugin-gen.c | 65 +++++++++++++++++++++++++++++++++++-------
>>    plugins/api.c          |  3 +-
>>    plugins/core.c         | 12 +++++---
>>    4 files changed, 65 insertions(+), 17 deletions(-)
>>
>> diff --git a/plugins/plugin.h b/plugins/plugin.h
>> index fd93a372803..77ed10689ca 100644
>> --- a/plugins/plugin.h
>> +++ b/plugins/plugin.h
>> @@ -100,7 +100,7 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
>>                                     enum qemu_plugin_mem_rw rw,
>>                                     void *udata);
>>    
>> -void exec_inline_op(struct qemu_plugin_dyn_cb *cb);
>> +void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index);
>>    
>>    int plugin_num_vcpus(void);
>>    
>> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
>> index b37ce7683e6..68dee4c68d3 100644
>> --- a/accel/tcg/plugin-gen.c
>> +++ b/accel/tcg/plugin-gen.c
>> @@ -132,16 +132,28 @@ static void gen_empty_udata_cb_no_rwg(void)
>>     */
>>    static void gen_empty_inline_cb(void)
>>    {
>> +    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
>> +    TCGv_ptr cpu_index_as_ptr = tcg_temp_ebb_new_ptr();
>>        TCGv_i64 val = tcg_temp_ebb_new_i64();
>>        TCGv_ptr ptr = tcg_temp_ebb_new_ptr();
>>    
>> +    tcg_gen_ld_i32(cpu_index, tcg_env,
>> +                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
>> +    /* pass an immediate != 0 so that it doesn't get optimized away */
>> +    tcg_gen_muli_i32(cpu_index, cpu_index, 0xdeadbeef);
> 
> You don't need a random immediate here.
> You can just as easily use
> 
>       tcg_gen_mul_i32(cpu_index, cpu_index, cpu_index);
> 
> with a similar comment about the true size being inserted later.
> 

Followed the tcg_gen_addi_i64 that was using this pattern in the same 
file. I'll change this to what you recommend.

> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~

