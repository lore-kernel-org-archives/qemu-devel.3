Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4B3EE20B8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 17:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voPEF-0002xD-0U; Fri, 06 Feb 2026 12:02:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voPDv-0002ko-KG
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:02:28 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voPDs-0003Ne-5f
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:02:27 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48039fdc8aeso15470585e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 09:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770397339; x=1771002139; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qDseEXT7QlvDmNaZpWVYtl4aj4b7ldI7XsAeT6Cducs=;
 b=XfEZsZLnjBBYyEiMKYg/hZNG1aX3G0MQxQ58AeqMJErKALKl1XuxKn38ONa+kV0qbt
 veEN42SYF4kBX5WFgEcG1q0E6oO1Bs9X0BAOeRcYiFOKoMVLYXi5QtSAlycGFLlBGXpR
 WFVoRHc4noan4dx/pBcdRoRCYrkj6gPM4e6n/AEBQ6HN7Ov4OX+/5J+p7UxJAnA4I5GO
 cxP1S7bD8FIQDhSampiPMWl8IOEhkbPsK7+XUX9n17Kox7KiYFOGE5lYTCucgVnnVL9x
 g43/6YX3bjhG0RxXTCddw4FDlet7sDlCd45EocHaJMFosVnvFLaTSr5V6OqxaStn6d+U
 oIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770397339; x=1771002139;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qDseEXT7QlvDmNaZpWVYtl4aj4b7ldI7XsAeT6Cducs=;
 b=qwnhPNjIipWpXqfBaDKq4wAWagbrDxFNNF+GrMw0UOVYQntDZWYptxtrrULn4BTG9O
 TtDrPNBCixCDrA0CP8ScFPup+h/KsezJSVxIkjVcabyUcuLSmB13qDee1aJfF1jlUe+l
 rEkAVUFoqkuz13dbK0m0YZ67vJtIEp2uZKdoe6CjI04xwKusrqYh8p5ewRlQkcTnirvv
 mp2idEdDm3xPQdWhkGWZxAkhO3Ibc+yczBDa8ZSVVihG/3no6MrZ9LIOeNbFLy+l6Wv/
 6Z+0RSSrxOvJsZ+S+QnMkqgT0bDXQ5/BHvKo7o/P6sBYjB8DULkMz1m9oTr+1N5PEkwm
 UbGA==
X-Gm-Message-State: AOJu0YyO9TG63rBDo+VwWR0LEC1Hfw8MmBX3h75XVUw9i6VMQQqxcJQV
 rOsQXLKwuBUqAUcD69KWjKAR4qebyT9EUYorC3awrcy6xPsivnlQr8ng738BYIbhaFU=
X-Gm-Gg: AZuq6aKnanXrSoW86AjAeI65A5w0qIYGc4NRmaTplYyvN2VQLZUiycoHWEY42r/of8g
 TVOv1NpstUcLWWYaYuofRZc/vRTne6DDsWFiikryeM6LM2fztxp4EOAOLhMukf+pVWGDFag0wi0
 5fpsC3xGDalKOC743/KfAoYfQgZn3vKO05nwFz7OyNYBsRlPU8Phwq2bqFXclF9TC5+B9Uq6uQj
 kc8aEDuGVZ0L1Zfm3uejcEQ2sQT6+tHQPl9binpNiaDiHmYerQAIkdOQOUewKPa8TJZOYUM4ygt
 LuqHx7EjCLucscvo4Cov9ttfFAtyIv1ZJTvJooX9UW0UlEw8ooXcU0XhYUe1AzH490mUdLyoEyR
 8225o+aEhlzbfZbGUvluzbCTRjlS1+XzBQZRQPGssb1TCqj+rz/bxyX4Bd/5zsaa5sMwz9xIyyU
 X4OJKmr7yUMXbwoQGAQYnm4ihtFuDDqI81U5RJDr+lpekBREkNulEk5g==
X-Received: by 2002:a05:600c:609a:b0:480:69b6:dfed with SMTP id
 5b1f17b1804b1-4832021debfmr51386885e9.24.1770397339492; 
 Fri, 06 Feb 2026 09:02:19 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483209e740esm22065535e9.19.2026.02.06.09.02.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 09:02:18 -0800 (PST)
Message-ID: <e13ff7a0-2227-4016-ad83-5446e75d15fa@linaro.org>
Date: Fri, 6 Feb 2026 18:02:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] target/arm: Remove dead code
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, devel@lists.libvirt.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260202153618.78675-1-philmd@linaro.org>
 <20260202153618.78675-2-philmd@linaro.org>
 <CAFEAcA8CtzzyWQxeV+zBZMU0JEacctMGvC5dezR+n3J7xKYiNQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8CtzzyWQxeV+zBZMU0JEacctMGvC5dezR+n3J7xKYiNQ@mail.gmail.com>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/2/26 16:28, Peter Maydell wrote:
> On Mon, 2 Feb 2026 at 15:36, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Since commit a0032cc5427 ("target/arm: Make 'any' CPU just
>> an alias for 'max'") the 'any' entry is never used (we use
>> 'max' instead): remove it.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/tcg/cpu32.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
>> index 0b0bc96bac2..2127d456ad6 100644
>> --- a/target/arm/tcg/cpu32.c
>> +++ b/target/arm/tcg/cpu32.c
>> @@ -897,9 +897,6 @@ static const ARMCPUInfo arm_tcg_cpus[] = {
>>   #ifndef TARGET_AARCH64
>>       { .name = "max",         .initfn = arm_max_initfn },
>>   #endif
>> -#ifdef CONFIG_USER_ONLY
>> -    { .name = "any",         .initfn = arm_max_initfn },
>> -#endif
>>   };
> 
> This is not entirely dead, because it's what causes
> "qemu-arm -cpu help" to include "any" in its list.
> But we already don't list "any" for the qemu-aarch64 help
> output, so it's not really a problem to drop it from the
> qemu-arm equivalent list.
> 
> I've applied this patch to target-arm.next with the
> commit message adjusted accordingly:
> 
> ===begin===
> target/arm: Remove entry for "any" from cpu32 arm_tcg_cpus[] list
> 
> Since commit a0032cc5427 ("target/arm: Make 'any' CPU just an alias
> for 'max'") the 'any' CPU QOM type is never used, because we change
> "any" to "max" before creating the object.  The array entry means we
> have an unnecessary type in the system, and the only user-visible
> effect is that "any" is listed in the "-cpu help" output for
> qemu-arm.  (System emulation already doesn't include this array
> entry.)
> 
> Since qemu-aarch64 already doesn't include "any" in its "-cpu help"
> output, we can reasonably drop it for qemu-arm also; remove the
> not-very-useful array entry.
> ===endit===

Thank you!


