Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830C5C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 14:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uThyC-0001jv-8f; Mon, 23 Jun 2025 10:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uThy3-0001ji-U1
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 10:16:16 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uThy2-0001Qo-3z
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 10:16:15 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-451d41e1ad1so29508725e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 07:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750688172; x=1751292972; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7saFI8jlPSHIyDsb/7dbddRoXubd8JlxaFMC1QThz/o=;
 b=bGfxz4rLtIZriw0IQ8jg2XDBF+PYO3Qd1/P6sNGQTqp6amtnAI7jszM4Epd/LwCPWI
 z1RzYSXvb7ELFXhWg44ptiDlX6DosYHSDddFUsLX2IspYcUGDJxPeU/2LR9Ik94HZwrq
 11KUMRWY8gGim6LNh4V03zV7uh0Kt9w2Lr5WQWl7V4ThOfgo/AEgN/skz6wOF6C0Wl1J
 4OmZRiqao07YTGPdkrjOmi+8MhXHrHd+Ju+y3ty26l6kxOSYfAbuhFvaCzYWDnOLe4mZ
 Ggru06hM5IYzx6GQAFZO6Ah9JeR0YiUfVdsqni08yWyoCwiz2HDymXCId45V42wa5UO2
 ycCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750688172; x=1751292972;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7saFI8jlPSHIyDsb/7dbddRoXubd8JlxaFMC1QThz/o=;
 b=Z39RA86KeHCdVCVtEuPG5/e/zl+NiPZX2+76e+AFUXkTaVhj5fI3Jlmmafp9w5cq6y
 419Y6DtU6mGY81us68nQ9N3U4YrpgHjhrHSfgXI+t0mzetRbXTTAFCEezD2XwPeKkL0i
 Wd9Ds8UK/nRWonu4JNyKn9sY+/80NJZa6E12RY3Vd9CIJpquKIoXPy7SSrbwOgXvz5JA
 yxfe1Lf/pqu0HkaWn3mobN/3SNrZszVi0XI7ah+qEdqOa4uPCQNxDqPSOBDqfgJ5vsr3
 QCeWuqWtxpvy/itnoaVt9c1lRupCqd+GcE9xR6NtWD/jkDxyJDKj62mfHzHPSKFJu7tT
 TfVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4HHD8NWkCsGJ1zr3WLoZrAD2uyvkPzaRB94cheRXZvj4FODA9pTs1jmBg250A65tc4t+IuS/kOnYD@nongnu.org
X-Gm-Message-State: AOJu0YzrzRv3jk0juRirtLqE4R5kE3ZBnueajjk5z9bICEPsH5u7HUgo
 oGq828PRmdsKBHFA27YBae/dZjEGoU2fBcv48TpxyZzK2zZ5O1GnP/FeqzfLTLTGIzI=
X-Gm-Gg: ASbGncttmN0/ir6R5rcdi8wn59dXUnrDNMkA5nk/nol7sSdVthMJpjkuBD51O08OmU7
 fwK6Vuy6Ys6jI8rJ4AkxyIH9aE4owUOnC0GUzPIHJJzqc5V9BqLYcWt8qVgjBK4H8GhjKERHuVY
 0JE8mYMnyQeapF/+GRefaveV1vxuHRxRPsmK8XqqljUUusCKNtabaxOKX6M4DVf1jioyC6TiY3L
 8SY2iE8jrebbRr0kmkovcdG/PIVgcWfN9edVQloA+Qirn4azuGbegYf6HAdftUm8ZxePzo2b/WZ
 3lqrwJ7F9PwQxm7PYoWWjIaqj82QDQTtzAE6bPtPFAB24txC5xj+sbFeTquUQnhlGYp73ttU6L3
 D5dpF6Pugmi46piohmgGioOyKG24y8A==
X-Google-Smtp-Source: AGHT+IEtlpXiUnkmncNEeDxLGh7RZyRayk2/GxNrhxeFCvxIqPrpNbA2ThqTasPFZKhi+sTVTBq13w==
X-Received: by 2002:a05:600c:840f:b0:453:c39:d0d0 with SMTP id
 5b1f17b1804b1-4536539c48cmr107868125e9.13.1750688172180; 
 Mon, 23 Jun 2025 07:16:12 -0700 (PDT)
Received: from [192.168.69.167] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f19b30sm9787697f8f.37.2025.06.23.07.16.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 07:16:11 -0700 (PDT)
Message-ID: <c131505b-9d06-4df7-b2c0-0555875dd568@linaro.org>
Date: Mon, 23 Jun 2025 16:16:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 40/48] accel: Factor accel_cpu_realize() out
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20250620171342.92678-1-philmd@linaro.org>
 <20250620171342.92678-41-philmd@linaro.org>
 <d0990f19-0adc-4664-9119-2f7d1edf1e5b@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d0990f19-0adc-4664-9119-2f7d1edf1e5b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 22/6/25 04:14, Richard Henderson wrote:
> On 6/20/25 10:13, Philippe Mathieu-Daudé wrote:
>> Factor accel_cpu_realize() out of accel_cpu_common_realize()
>> for re-use.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   accel/accel-internal.h |  2 ++
>>   accel/accel-common.c   | 15 ++++++++++++---
>>   2 files changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/accel/accel-internal.h b/accel/accel-internal.h
>> index d3a4422cbf7..b541377c349 100644
>> --- a/accel/accel-internal.h
>> +++ b/accel/accel-internal.h
>> @@ -14,4 +14,6 @@
>>   void accel_init_ops_interfaces(AccelClass *ac);
>> +bool accel_cpu_realize(AccelState *accel, CPUState *cpu, Error **errp);
>> +
>>   #endif /* ACCEL_SYSTEM_H */
>> diff --git a/accel/accel-common.c b/accel/accel-common.c
>> index 24038acf4aa..0f2aa783ab2 100644
>> --- a/accel/accel-common.c
>> +++ b/accel/accel-common.c
>> @@ -122,10 +122,14 @@ void accel_create_vcpu_thread(AccelState *accel, 
>> CPUState *cpu)
>>       }
>>   }
>> -bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
>> +bool accel_cpu_realize(AccelState *accel, CPUState *cpu, Error **errp)
>>   {
>> -    AccelState *accel = current_accel();
>> -    AccelClass *acc = ACCEL_GET_CLASS(accel);
>> +    AccelClass *acc;
>> +
>> +    if (!accel) {
>> +        accel = current_accel();
>> +    }
>> +    acc = ACCEL_GET_CLASS(accel);
>>       /* target specific realization */
>>       if (cpu->cc->accel_cpu
>> @@ -147,6 +151,11 @@ bool accel_cpu_common_realize(CPUState *cpu, 
>> Error **errp)
>>       return true;
>>   }
>> +bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
>> +{
>> +    return accel_cpu_realize(NULL, cpu, errp);
> 
> Why pass null here, and why check for it in the new function?

Indeed ;)

