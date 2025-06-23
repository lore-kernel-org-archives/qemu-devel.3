Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CD4C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTgKO-0003s1-Og; Mon, 23 Jun 2025 08:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTgKM-0003rO-Jw
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:31:11 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTgKK-0002je-8I
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:31:10 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a528243636so2466386f8f.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 05:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750681865; x=1751286665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e6T+S3DH7mevcc/k2QK2yw+D4ezZENLPQlUBpjJQQz4=;
 b=I6Lpgxq/o3ql7/e4S008Qr0IxvoLOTbKpntEoyRQjYWxCEYd5/Fpev0XOTxNHBk8jz
 TNv9fRpAxukjXf0dA2kFmcdb3XNcZ9eVmqZLc/klfV67XtOjNoF80Opylde4d23d8xz9
 gvoWvnIyz7+2Z5Z8I2I5k0uivrx+A2pmOZQYCvaWZgALcyrW6R2nhlDwfP4c/o6x8bwP
 ZrzPgA1q127EdlNCEJMVeu4Xr1qs9qjemV57HVqBPtYPc2NV62qfY/9JNOnJ3DKFwbzA
 bB/XC6XG/gQtckXTReayX9o3kih5VnuvJmP9yYYdqmgwrG8KsdfwF8fzwRr+pJLoC9+Q
 /N4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750681865; x=1751286665;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e6T+S3DH7mevcc/k2QK2yw+D4ezZENLPQlUBpjJQQz4=;
 b=sTrozG52PDseMFa5tHIZDK174AfI9Ldlrtf0GItDINo3w3X+4R6m9+Je3MfVu18kJp
 0H8EmJ+p1mRs1uNXtfJeLqmRysIVkczMqz+E/kc35H7ZWcc7nAeEkI/p62EV+APLIvcw
 /FLsOEP7kJDZN5XE37y424dIyI8cC/ziPpA5RcqVMIxIodggRHWFBU9JkHp+/t+szbY1
 BRgIUFJgwUNvWEaHSI0QtKv+nZAYZrWzCmRBhTTcRv96cBgTy3M/nEFX4FD4MRyDRETe
 kyd2+8Y+JBxQjRUwfAQHg5jRrw3kAhBRlntq5kSca2HDepF4pRL7gRxdZTwvF3TNS4Jc
 iLfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhPoRRG6M54jbiN6+ku/hl1gVHDkZ/Vjg5jo9FrfqMldopwYZxt8iSvHicjL7LkKqZEZMUYNGyffND@nongnu.org
X-Gm-Message-State: AOJu0YwvzwL/QneOn4mQsR5H+Z/ObdZWwErRL8SkA2AolLORWTXP0DSL
 68ndcbun+aZ415mCguu5Gm9IiNfHR0CcsCOh+5Dx/6DKr2DkwTvUAxJ1OIb3ouv6NBe/qYdt92k
 KAEIz
X-Gm-Gg: ASbGncuwhEhW9s/PKUayRRM+z2575TZqAILlxqiEOSZOZB0L/Op6Q+FTnm3aEJE4/vV
 37gbrT8MOnV0u5bEjATxTokuLo817/rYqIVZW/Ew1nr9JAop1Qswc/F4tsQg8ZvcbYRVRuZReT+
 XpdzhC/MMFAwbIIaYlajMSbJgX9cGgL9MkQtH7lqkUeJBaHO3clOrl9hyw7vfjRn8FifJrQpO9k
 0iyci2CLDdoFUZQ+l1IXluhe3N6Ls/vyA5OxIkkhDANcnYEglPTb8Tg9Yd9GEfkc/zkPWUfmqy/
 WxvlYUshXbq+9Ek338yfnHQ4qHvDDhvg/Blu0CZc3IDuqyREqIlVG+hZg2DkkIvIesejEGe5Gvr
 uGOjrP4nrwJrBkOekAX1SMU7D6TL6bQ==
X-Google-Smtp-Source: AGHT+IGzBqco9DKIYjh4MXJCKrKgpLYdGBh+g+t+Koip/rW1bv5+OuPTxAXCHQG+2QT1+jouI1mMsw==
X-Received: by 2002:a05:6000:2dc2:b0:3a4:dc2a:924e with SMTP id
 ffacd0b85a97d-3a6d1192830mr8428292f8f.6.1750681865471; 
 Mon, 23 Jun 2025 05:31:05 -0700 (PDT)
Received: from [192.168.69.167] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d1187e5fsm9357040f8f.70.2025.06.23.05.31.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 05:31:04 -0700 (PDT)
Message-ID: <76bd9e17-8350-42a0-aefd-ed96137c5955@linaro.org>
Date: Mon, 23 Jun 2025 14:31:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 36/48] accel/whpx: Convert to
 AccelOpsClass::cpu_thread_routine
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250620171342.92678-1-philmd@linaro.org>
 <20250620171342.92678-37-philmd@linaro.org>
 <aea4e119-1ac5-4b03-9639-0dc277375365@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aea4e119-1ac5-4b03-9639-0dc277375365@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 22/6/25 04:10, Richard Henderson wrote:
> On 6/20/25 10:13, Philippe Mathieu-Daudé wrote:
>> By converting to AccelOpsClass::cpu_thread_routine we can
>> let the common accel_create_vcpu_thread() create the thread.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/i386/whpx/whpx-accel-ops.c | 12 +-----------
>>   1 file changed, 1 insertion(+), 11 deletions(-)
>>
>> diff --git a/target/i386/whpx/whpx-accel-ops.c b/target/i386/whpx/ 
>> whpx-accel-ops.c
>> index b8bebe403c9..c1b27d1b89d 100644
>> --- a/target/i386/whpx/whpx-accel-ops.c
>> +++ b/target/i386/whpx/whpx-accel-ops.c
>> @@ -61,16 +61,6 @@ static void *whpx_cpu_thread_fn(void *arg)
>>       return NULL;
>>   }
>> -static void whpx_start_vcpu_thread(CPUState *cpu)
>> -{
>> -    char thread_name[VCPU_THREAD_NAME_SIZE];
>> -
>> -    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/WHPX",
>> -             cpu->cpu_index);
>> -    qemu_thread_create(cpu->thread, thread_name, whpx_cpu_thread_fn,
>> -                       cpu, QEMU_THREAD_JOINABLE);
>> -}
>> -
>>   static void whpx_kick_vcpu_thread(CPUState *cpu)
>>   {
>>       if (!qemu_cpu_is_self(cpu)) {
>> @@ -87,7 +77,7 @@ static void whpx_accel_ops_class_init(ObjectClass 
>> *oc, const void *data)
>>   {
>>       AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
>> -    ops->create_vcpu_thread = whpx_start_vcpu_thread;
>> +    ops->cpu_thread_routine = whpx_cpu_thread_fn;
>>       ops->kick_vcpu_thread = whpx_kick_vcpu_thread;
>>       ops->cpu_thread_is_idle = whpx_vcpu_thread_is_idle;
> 
> After this, create_vcpu_thread is unused, correct?

Only RR left, which is a bit different:

339 void rr_start_vcpu_thread(CPUState *cpu)
340 {
341     char thread_name[VCPU_THREAD_NAME_SIZE];
342     static QemuCond *single_tcg_halt_cond;
343     static QemuThread *single_tcg_cpu_thread;
344
345     tcg_vcpu_thread_precreate(cpu);
346
347     if (!single_tcg_cpu_thread) {
348         single_tcg_halt_cond = cpu->halt_cond;
349         single_tcg_cpu_thread = cpu->thread;
350
351         /* share a single thread for all cpus with TCG */
352         snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "ALL CPUs/TCG");
353         qemu_thread_create(cpu->thread, thread_name,
354                            rr_cpu_thread_fn,
355                            cpu, QEMU_THREAD_JOINABLE);
356     } else {
357         /* we share the thread, dump spare data */
358         g_free(cpu->thread);
359         qemu_cond_destroy(cpu->halt_cond);
360         g_free(cpu->halt_cond);
361         cpu->thread = single_tcg_cpu_thread;
362         cpu->halt_cond = single_tcg_halt_cond;
363
364         /* copy the stuff done at start of rr_cpu_thread_fn */
365         cpu->thread_id = first_cpu->thread_id;
366         cpu->neg.can_do_io = 1;
367         cpu->created = true;
368     }
369 }


