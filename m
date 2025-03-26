Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321E1C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 15:31:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txSh2-0000s2-Mg; Wed, 26 Mar 2025 11:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1txSh0-0000qJ-Dv
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 11:29:22 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1txSgy-0005ie-TO
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 11:29:22 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2243803b776so496655ad.0
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 08:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743002959; x=1743607759; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z3ZXlCUm86uymAguQXlmFO6CfoP8zlCCdX2A86h4w+s=;
 b=wVmcS09aoLPXWgtP441K7lzC4Q7OEcjF++Z9rcvXUUx/98GpBujFXd9RQVAijr5A8c
 HGAs+3L8V32Y8xBJizqbub4XSmEK1r5jG4/fIU+dBA4yv6+yT/nJbEh334CvGj3l9EFW
 sp13Nq1BoNwP83KlvrwHWYP5q76eAIWl43WoCag3pqmWYo+S9wiGHXUf5FXc/cB4qBws
 phXuyyqkYgLlGbDTz/FpdaP1ret4tdsW7JNPFJdxH0lJJfW4krZLuqAGiCrRTieBv4uF
 G2v3z05Uq/77tc6khI2nsVCcMt6GtUSXqbB9u7aspyw6vJ0OBvn6KwrV32s/G/NlewWQ
 JFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743002959; x=1743607759;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z3ZXlCUm86uymAguQXlmFO6CfoP8zlCCdX2A86h4w+s=;
 b=ESN9CVBfakwn1xFb5fAO6+IZu5kWFfhjNxjmJUk2zLfpzjawD5AGQ5iVZgxvly7aiN
 qIQ97CDY9n20F9XM5njTypzB5/qQTmH2RJlH6uNFn869GiWs8dhUy/h12op6wf187c+6
 E32t4gkmJgjY55AMrdX/xczswsGT31XVieSXcTRdGLweMcmMAksi91GJBlfE+mgrbP32
 MGqme2VoFfc8QAtB+v0AkVvqx37FM3AqHeh6IrPQGcbt79We+6Ax19AM1bHDao+Hpvjh
 T8z3olrfXMv6HECJPytg1A5n1/AsIhkBQulJ0Qbc0SESfmRq+txXayxbx/sx3+wcHpOj
 YIBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB6KMsF2OyJZfJr8DuFAKp0sCmvNlY3ikG1u4KobQuc/aI0C90ZZyXZBRgyqTDhSpXhK3vWSCv7YLf@nongnu.org
X-Gm-Message-State: AOJu0YzyF2lSKDjseraivpwoUmnyxwyRRhRCXb/MX67slKL3qhG6IpJT
 y5tJeoNcQ+nXNQtBvEY0JXwKuboPZxpHPXeqfzTW9RXDNLMWEs5VZXKvZg0WNws=
X-Gm-Gg: ASbGncutmGqdfZo/fh7SyBuxM5b/OeLv3j0EuM+u9T43f4yIyDpWySReDxxhdolpBbI
 JXTITRvV0mbGf+0Ne09X5hx5jBrt7a10DlesPIQmZQZPJziiTgStkxqpruF1J87s2doEvm5EjSa
 SFw7aErfvkqepHy2HCg+wABE5HhsE9zvxmAvpTkjUSXyKN4gWELladZsTg0+/+5h8bbybBcw0SU
 1pmsYdxcUSX3qPLD781ufaVim0P7cMuuDgqaIgRNYvvmHmhSkLKbb7YLjr9hXwJwKeribAhvSQ7
 I1Ujr8/8xsEUjE7yQuQQEpowQ//H5rFYl/96GLockhnijbabNeBEimePwA==
X-Google-Smtp-Source: AGHT+IFMI+FP0IpnxHH6TkrNBRgTaRaVkIdmm4iFDQZxmWoAQdJOdTN5OA3m87FMEspLgVO12RcrwQ==
X-Received: by 2002:a17:903:228c:b0:223:6180:1bea with SMTP id
 d9443c01a7336-22780e038e2mr320750815ad.37.1743002959153; 
 Wed, 26 Mar 2025 08:29:19 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811bc272sm111122885ad.146.2025.03.26.08.29.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 08:29:18 -0700 (PDT)
Message-ID: <6016c97c-dfc7-427e-8281-0a420b31ceac@linaro.org>
Date: Wed, 26 Mar 2025 08:16:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] target/avr: Increase TARGET_PAGE_BITS to 10
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, philmd@linaro.org
References: <20250325224403.4011975-1-richard.henderson@linaro.org>
 <20250325224403.4011975-12-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250325224403.4011975-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 3/25/25 15:44, Richard Henderson wrote:
> Now that we can handle the MCU allocating only a portion of the
> first page to i/o, increase the page size.  Choose 10 as larger
> than the i/o on every MCU, just so that this path is tested.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/avr/cpu-param.h | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
> index 81f3f49ee1..f5248ce9e7 100644
> --- a/target/avr/cpu-param.h
> +++ b/target/avr/cpu-param.h
> @@ -21,13 +21,7 @@
>   #ifndef AVR_CPU_PARAM_H
>   #define AVR_CPU_PARAM_H
>   
> -/*
> - * TARGET_PAGE_BITS cannot be more than 8 bits because
> - * 1.  all IO registers occupy [0x0000 .. 0x00ff] address range, and they
> - *     should be implemented as a device and not memory
> - * 2.  SRAM starts at the address 0x0100
> - */
> -#define TARGET_PAGE_BITS 8
> +#define TARGET_PAGE_BITS 10
>   #define TARGET_PHYS_ADDR_SPACE_BITS 24
>   #define TARGET_VIRT_ADDR_SPACE_BITS 24
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


