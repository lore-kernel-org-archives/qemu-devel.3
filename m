Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A29C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 13:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEUXQ-0005Sb-DC; Tue, 04 Jun 2024 09:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEUXK-0005SA-By
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:49:14 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEUXI-0002ie-Mb
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:49:14 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-dfab2474152so1797095276.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 06:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717508951; x=1718113751; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l6rpV7khsWrHqenumFmX26yARfzHY9Gah6zKCfmeD9w=;
 b=qPNnEk9gkkynIoSYOJ7BIYeM6f+EyfhfCSdz7ZDlEr/ykdBNFsZnPlXPaxOlKjMKBd
 tmq1RRB5VPW8fsOJAAQ9QkAoz+sFp4whBRMYNCBW82Pn9JvGfd/oQILnaeygxrBoK72D
 +N+hWIbcfo1ROcgN9m00QAIsvl1L2ANCbhHawRZSN3yludRPpAoaGJe6l3mjcfMp7VK6
 biKdMWEtN1Ehe6hVFD0r4V3OtpfjIsFi869JqTJG8b/f6g+d5NpGEhI5B3jsZWE+vhME
 1W8CAGrWirBZ2UyGEzc+FbxdnxUb1qY8MuvjwKv1W64hnxjMYHwUg8GfgeNcch1TUavs
 r5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717508951; x=1718113751;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l6rpV7khsWrHqenumFmX26yARfzHY9Gah6zKCfmeD9w=;
 b=SxCrEEo0+eHiamqw6MkiAn8wqR7qfqedlreZRWOSX6zTPJcWcoWuglQcGuBoWg+oYb
 xtYStk97MJnFk0HvBTC1PyTREQqHdDRABufu+Rwa3qDwuZ13SxX3ZyuiOGw2s8HLGw3b
 n/6HJHcskUWkeJXNTwIy3eBPoguJUyI2pRotOMPe7esAwuWwQPgy3g5bawKZ4Z7TsaHj
 VyZcITUpjmP6/m2POy7X89Rhja9gJUOtaTDPZe9Q8Fqkhhcwd2UjJy6DJAIaTbLeux9S
 0fi+5bCbN+gAY7JPEg3KNEFXKwH5W59K8lgeS7TRuE2W5APiYdz/qF+NGYPQfIw9QPJk
 mh4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUA65YEgJh374JxxyiSKRIsAghhJPEkpQ5hKdpnt5bt1woFMncWTHAhi5/2r1WBy63rEUYC85nD/i39i9/D1c0E1+wYtq4=
X-Gm-Message-State: AOJu0YzemfsegN/67dnrnRjNHbX0NCJ8RnkLRMuKM0rT5oRmgJS6vY9P
 +sVZDRxpumlpZ+2nppuq+7ToM6FfN/2fut+nvRkMeaE2AXWKhL/6GLbBH4YH0G0=
X-Google-Smtp-Source: AGHT+IGXWD050wX/tF/5Q2oWzPihZ+yi2pJpd5umU4aIcWsRQBxrotvF5k9t0xtl55pqbbK7TY0bTA==
X-Received: by 2002:a25:c5c9:0:b0:dfa:47d0:63a4 with SMTP id
 3f1490d57ef6-dfa73bd0a55mr12222772276.9.1717508951238; 
 Tue, 04 Jun 2024 06:49:11 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1aca:c697:b7cb:e0ad:8679:2c14?
 ([2607:fb91:1aca:c697:b7cb:e0ad:8679:2c14])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-dfa6f002af8sm2235922276.5.2024.06.04.06.49.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 06:49:10 -0700 (PDT)
Message-ID: <8855bd45-9b9c-485d-b737-2f23f0da6406@linaro.org>
Date: Tue, 4 Jun 2024 08:49:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] target/i386: fix INHIBIT_IRQ/TF/RF handling for
 PAUSE
From: Richard Henderson <richard.henderson@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240604071833.962574-1-pbonzini@redhat.com>
 <20240604071833.962574-9-pbonzini@redhat.com>
 <0dc2521f-7d7c-48c1-943e-b71566284450@linaro.org>
Content-Language: en-US
In-Reply-To: <0dc2521f-7d7c-48c1-943e-b71566284450@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb2c.google.com
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

On 6/4/24 08:44, Richard Henderson wrote:
> On 6/4/24 02:18, Paolo Bonzini wrote:
>> PAUSE uses DISAS_NORETURN because the corresponding helper
>> calls cpu_loop_exit().  However, while HLT clear HF_INHIBIT_IRQ_MASK
>> to correctly handle "STI; HLT", the same is missing from PAUSE.
>> And also gen_eob() clears HF_RF_MASK and synthesizes a #DB exception
>> if single-step is active; none of this is done by HLT and PAUSE.
>> Start fixing PAUSE, HLT will follow.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   target/i386/tcg/misc_helper.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/target/i386/tcg/misc_helper.c b/target/i386/tcg/misc_helper.c
>> index 8316d42ffcd..ed4cda8001e 100644
>> --- a/target/i386/tcg/misc_helper.c
>> +++ b/target/i386/tcg/misc_helper.c
>> @@ -92,6 +92,10 @@ G_NORETURN void helper_pause(CPUX86State *env)
>>   {
>>       CPUState *cs = env_cpu(env);
>> +    /* Do gen_eob() tasks before going back to the main loop.  */
>> +    do_end_instruction(env);
>> +    helper_rechecking_single_step(env);
>> +
>>       /* Just let another CPU run.  */
>>       cs->exception_index = EXCP_INTERRUPT;
>>       cpu_loop_exit(cs);
> 
> Perhaps it would be better to do
> 
> void helper_cpu_exit(CPUX86State *env)
> {
>      cpu_exit(env_cpu(env));
> }
> 
> static void gen_PAUSE(...)
> {
>      helper_cpu_exit(tcg_env);
>      s->base.is_jmp = DISAS_EOB_NEXT;
> }
> 
> to keep from replicating gen_eob?
> 
> Anyway, this is correct, so,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Oh, based on the next patch, it would appear that PAUSE does not single-step properly 
because it sets EXCP_INTERRUPT, and end-of-insn single-step depends on exception_index == 
-1.  I'm thinking of the bottom of cpu_tb_exec().


r~

