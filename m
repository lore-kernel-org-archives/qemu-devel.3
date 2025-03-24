Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76006C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 16:33:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twkjc-0002Mv-2J; Mon, 24 Mar 2025 12:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twkjD-0002A4-4O
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 12:32:43 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twkjB-0007jq-23
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 12:32:42 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so32748595e9.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 09:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742833959; x=1743438759; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c6iACdFOijfRWgZyFj/Q1/sQ3EU+bwCMzTaOGKjqXoI=;
 b=g0K9M4jG/m/8V3UuffG5g9tgxTSMZWALSjvU3MXqq+xKK5OUmviCISLc2drjxSPi15
 7yY6csfjS5LI0XQfO57l4jP0A4mLb1Mnr/ztWmuwQFjBCrzdrU7YXZjirQZ30sCBiW37
 TT9U/tY/3V4b321UvWHl9TirjgLvcv2De20hshP7voTq9Qx4y2tAsey1WXl5R2Jtvedg
 lyG2lznaMKA0CIm9+rHRbQUV/EO6nvYwH7UEfmaY0+puLbSd+KClg3pFH4TVSuTsutSx
 9xxTY+LBmPGJ6L8kleNSbYdRl+btTj9lVgsuAdjsUCEgWZqb4qBpJhEfKEjyucjVB9ki
 0EMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742833959; x=1743438759;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c6iACdFOijfRWgZyFj/Q1/sQ3EU+bwCMzTaOGKjqXoI=;
 b=YGAPotwBI6N/AIYwLbZxGGDRNtitiB9Ic2dKUVBWXUhCYudtMwb/GSpnVZUdO1XMlq
 kqdq3namFa3S21X/GZ1KOod0JrcNHrSyaQj+T3kx1ne35t3bQ/gBdc6sLANXEbjU5bZm
 bquk/67OWjntdCB6P0iLYP6F51q0J2BXBjaoJ7wLc8EATBnl65avWgrl7VcUmSftsHcY
 9DOuiRr6rB/SZuENEXQ+t6l7J/uE2Si5UybvOdvkW8fgaBhPb8JYpImZjk9gl4Q3ZqDo
 BOrmp8mkRbfH82+EW94sz+qFhi0/Lhm/97kq5QuLCi2krWaTOwg3DfieEWt++BhkBas3
 WZWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ0PeGl52+3eMBZOxJ6K+02bsjlQcfpdDSG4RYWEY+9HRxZQc5qYasrkdWj6CM0GzWiDv45SDuBEIq@nongnu.org
X-Gm-Message-State: AOJu0YywrWZgMWiP6VegmIl9Ar3Y9iqv49s6ynqJv4hUnGf2VYaZzOwi
 5AM4S2JuxBn68EPgSZR4ugTdaHiZH45vibEnvuJMe8/MwvU4GNJ6CWYKBU8KF3Y=
X-Gm-Gg: ASbGncsAT0lqoTkv5c9OJOY5/C3nk36Lf6CUrYNieyMqdIQUdH7H+fI5hBvWxQmHb/R
 52ov8M41MxmGdpox03RKKO5Ibpi+3nEmHSQ2VIHozrGw57V4LuR3TQ3O95q38geQeBPFJcTGikl
 ARkjk9CxTYKFgJ4Ao4ldEmZXuY+Uq1I41Oa6NZ5faRNZc3N4BkCb0ov7julepIn4AUovdE9i0Gp
 sfuB/i3+zANV3ugEcWjF56V9NJhSkY+4Ii9zwhMBKWhVoAbKbGauNVoeqoLRDXbOUnGSgtqlczB
 WvQmdCIXFZH9BmaN2s68DWE1n/nguyZYsu3UuqDIVoGAMorhJhuyAS2jdXS4QM6voclm98jdu5Y
 qHRj4nwxDOvSssaQs/g==
X-Google-Smtp-Source: AGHT+IGdW/CEtRWIqmrPQBmVJJdJ7COLaEqF53joNNZVqtVutds9pRuH+g807EynqpeNDJd63m8J9g==
X-Received: by 2002:a05:600c:c07:b0:43b:c95f:fd9 with SMTP id
 5b1f17b1804b1-43d509e191amr134123455e9.5.1742833958838; 
 Mon, 24 Mar 2025 09:32:38 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b260fsm11232965f8f.43.2025.03.24.09.32.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 09:32:38 -0700 (PDT)
Message-ID: <029362ad-1408-4f12-9fa3-e51d9bfaf56a@linaro.org>
Date: Mon, 24 Mar 2025 17:32:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 5/6] target/sparc: Register CPUClass:list_cpus
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-s390x@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20250323224035.34698-1-philmd@linaro.org>
 <20250323224035.34698-6-philmd@linaro.org>
 <8115b7be-03b8-4d08-8f7e-9d316f11e082@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8115b7be-03b8-4d08-8f7e-9d316f11e082@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 24/3/25 10:30, Thomas Huth wrote:
> On 23/03/2025 23.40, Philippe Mathieu-Daudé wrote:
>> Register sparc_cpu_list() as CPUClass:list_cpus callback
>> and remove the cpu_list definition.
> 
> Copy-n-paste error in both, subject and patch description: This should 
> be about s390x, not sparc.

Oh oops.

>> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
>> index 5b7992deda6..1aac967a0ce 100644
>> --- a/target/s390x/cpu.h
>> +++ b/target/s390x/cpu.h
>> @@ -902,7 +902,6 @@ static inline uint8_t s390_cpu_get_state(S390CPU 
>> *cpu)
>>   /* cpu_models.c */
>>   void s390_cpu_list(void);
> 
> Don't you want to remove the prototype here, too? (and make the function 
> static in the .c file)

s390_set_qemu_cpu_model is defined in cpu_models.c,
while CPUClass in cpu.c.

> 
>   Thomas

