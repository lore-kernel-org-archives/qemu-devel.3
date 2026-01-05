Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700D8C2A096
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 10:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vciG7-0008Fz-Sq; Mon, 05 Jan 2026 05:56:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vciG4-0008Fn-Mp
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 05:56:21 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vciG3-0001bL-2B
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 05:56:20 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47795f6f5c0so75366215e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 02:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767610577; x=1768215377; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EQU3NtzAQfHt07mHjteR8LDqZl5nT0/QCOZQV2HYtNk=;
 b=PgTGo8h795+jFvY9mipHXbuoFREQqewd4e+RUZLzjG+KolQbgITe6j7jIAdYs0wErl
 qoCcug6xDwZGdrAs8tO8rimzbq+0+beX8NtWJ9+jod/1mLQL1I6GvDhNRhfI13t2zU4S
 Nzbw7jDUnPa3WJ/BV/1z4h/XrX1O1jj/Y+e91KmVp+rjVovk9j1BmG92kwriT1XdKu76
 1qyq7KKKi5l2NuCl7y6LimN/53ehbW4aN/EcqDDYh4U8s+bzgyqWk1p6IJr8cCfCuecd
 l55PRfZ66fAtqBUjoNMr3xOPanTuziiYQmJetHxgaYqExy+jD2DpUDD43eywptms0LB0
 cy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767610577; x=1768215377;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EQU3NtzAQfHt07mHjteR8LDqZl5nT0/QCOZQV2HYtNk=;
 b=aO7k2xJrxYYAdAFc/aeOyNG4OaeZKRN27l9NJxn7pH2wXBlHJ9XJKcZxrVbqtiq71k
 TIAXsGPHlRwvj2sjqJdeTid77auS9LhX4W1gI0mLIXzOsZcDU/wwqCTHQqZB7vgD1MXZ
 52DTEVUAjGXIpbQfIz7o10WvUziyEbDey4FXXVDWisfo8ONWiHII1bQ/EHT88m3fcAF5
 SJZTDjR6Tc5Tb9hlNe/nzPt90GbVIDYL8Gh5oR/i+77m4MbK/im0xIHhNtXqFbyKi1hD
 f6PIGUaKwSmROqqGiVhG/O/oGhbC/ROX2h8m2BTATDvi5v5V1ATUVhs6i+5mIxgLV9mm
 58JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRSLI0M3ljm2n1TyrpeYpSKoo3GAwq4MXDMJuu2o7TqgubGdqEQSATvtlmLFGefKxcNPt7o6oYcsW0@nongnu.org
X-Gm-Message-State: AOJu0Yz0u095wGyXorjW8VDUd6NZxh4Ls1BD6Us9t2MEbLhpjIPwTTRr
 axXAdjbV3L8GXGug+qV+J2ZJUTQFLNWoVJUZlmGLDK7uG91mtM01rQoLrYK5uWpTY1E=
X-Gm-Gg: AY/fxX42qeV12zj1C4yhSTDkzES/pNeCKvlxNE8gM1iwjho+is+ag5uE4vkSdVEQR6b
 xy6jo3X3Ef0XD6Wj4aRUV1JPVPoa3IE7weTmt6Bl+qJGdxLwBfjJk7bwyT5vQc96NDNmPiaps7Z
 V3jKcmCv/F+JmFj0SyFqP8fAT2wFVJFT088xViIVC+OqzBHbYgpfNu9PAK9S5ZyrJSGat25jnC8
 vURU3mqgavdECQY7QywpIroZjuFilPK7BBVS2SxyuKgxe3f1scPxQi1guukXWHJTjjOsIuPyq32
 kB8DcDx6px250ekauQw6oBbZUZ3lz1M18RbDZmSxMPn2pp1HdbSP/Eobj+vupAiTBQY9l0EZzDh
 yaaD7R8NONh5yfTbJs8P4zaAGGM80NwR/FAIeIkRudKdNzAZ/X36QqDmTbn3BArFPMiSljLcSOJ
 +iYShkuwWuxdtG7uG8SIo+YzaaqJpKUDY/+qKfFBh6L4piujpUdaZGAQ==
X-Google-Smtp-Source: AGHT+IFSAuFXoU4ItMbav84zJWlev5GJh16gCSi4LBFJnuQmORMDVPOTz5xVEzxz8LLLEH4RKrbkUA==
X-Received: by 2002:a05:600c:35d1:b0:479:2f95:5179 with SMTP id
 5b1f17b1804b1-47d1954a165mr703062495e9.15.1767610576540; 
 Mon, 05 Jan 2026 02:56:16 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d6c0bb0cdsm54450645e9.17.2026.01.05.02.56.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jan 2026 02:56:15 -0800 (PST)
Message-ID: <854a4169-0f9b-4f10-a519-0410b799cb4e@linaro.org>
Date: Mon, 5 Jan 2026 11:56:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] target/sparc: Simplify gdbstub
 sparc_cpu_gdb_write_register()
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Cl=C3=A9ment_Chigot?=
 <chigot@adacore.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Anton Johansson <anjo@rev.ng>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Frederic Konrad <konrad.frederic@yahoo.fr>
References: <20251224162642.90857-1-philmd@linaro.org>
 <20251224162642.90857-9-philmd@linaro.org>
 <a48503cb-0a62-4cc7-83ff-393945dace0d@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <a48503cb-0a62-4cc7-83ff-393945dace0d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 5/1/26 01:37, Richard Henderson wrote:
> On 12/25/25 03:26, Philippe Mathieu-Daudé wrote:
>> Rather than ldtul_p() which uses the underlying 'unsigned
>> long' size, use the ldn() variant, passing the access size
>> as argument (evaluating TARGET_LONG_BITS / 8).
>>
>> No need to use #ifdef'ry to check for TARGET_ABI32, since
>> it is 64-bit:
>>
>>    $ git grep -E '(ABI32|LONG_BITS)' configs/targets/sparc*
>>    configs/targets/sparc-linux-user.mak:5:TARGET_LONG_BITS=32
>>    configs/targets/sparc-softmmu.mak:4:TARGET_LONG_BITS=32
>>    configs/targets/sparc32plus-linux-user.mak:2:TARGET_ABI32=y
>>    configs/targets/sparc32plus-linux-user.mak:8:TARGET_LONG_BITS=64
>>    configs/targets/sparc64-linux-user.mak:8:TARGET_LONG_BITS=64
>>    configs/targets/sparc64-softmmu.mak:6:TARGET_LONG_BITS=64
>>
>> Directly expand to the big-endian variant (with the '_be' suffix)
>> since we only build the SPARC targets as big-endian.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/sparc/gdbstub.c | 12 ++----------
>>   1 file changed, 2 insertions(+), 10 deletions(-)
>>
>> diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
>> index 134617fb232..d265681f6d2 100644
>> --- a/target/sparc/gdbstub.c
>> +++ b/target/sparc/gdbstub.c
>> @@ -112,15 +112,7 @@ int sparc_cpu_gdb_write_register(CPUState *cs, 
>> uint8_t *mem_buf, int n)
>>   {
>>       SPARCCPU *cpu = SPARC_CPU(cs);
>>       CPUSPARCState *env = &cpu->env;
>> -#if defined(TARGET_ABI32)
>> -    uint32_t tmp;
>> -
>> -    tmp = ldl_p(mem_buf);
>> -#else
>> -    target_ulong tmp;
>> -
>> -    tmp = ldtul_p(mem_buf);
>> -#endif
>> +    uint64_t tmp = ldn_be_p(mem_buf, TARGET_LONG_BITS / 8);
> 
> No, this changes the behaviour of sparc32plus.

$ git grep TARGET_ABI32 configs/targets/sparc*
configs/targets/sparc32plus-linux-user.mak:2:TARGET_ABI32=y

$ cat configs/targets/sparc32plus-linux-user.mak
TARGET_ABI32=y
TARGET_BIG_ENDIAN=y
TARGET_LONG_BITS=64

Isn't it the same?

