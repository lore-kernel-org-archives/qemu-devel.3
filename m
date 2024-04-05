Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEACC67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 17:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsngA-0002Uj-4A; Fri, 05 Apr 2024 13:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsng2-0002UA-Kz
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 13:48:36 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsng1-0007En-5N
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 13:48:34 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1e0bec01232so21435925ad.3
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 10:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712339311; x=1712944111; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IFdiynlVciqKce82I9/JolCgwwU4DOK2S2QSbBkyZHU=;
 b=LRKUYtQYGEq/xWffB71sRc5B6EQSNPWZiWTQz3mNaKKDzMMXbFQmG//QExsEDH0Jp4
 IID1BPpxEBw2nr6BIxESQHkrtHcnvgEBNXBV6FEdcpDKZn60jnWUe78PUWlV0CsQjaV0
 5K5NN0mGf9dCF/5oDF7fjPA0tTtHzg3TTTrsFwqK2Nn48KbnzB7MLDkICo6ieRivJ7IK
 GL89xLN/I3Xe7PegWd1dbuRPpMausqRxKEMtvraLapHN4yyYRe1hlPjqqZptb6XRZhB/
 sVBU8w11qSz/RPC/gAhKaXS0BTdmEI+uVtglXmUsYMuz3Y6aCR3uwux5OvbjPhx7bwqQ
 OoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712339311; x=1712944111;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IFdiynlVciqKce82I9/JolCgwwU4DOK2S2QSbBkyZHU=;
 b=JJCztMvN+tFZtUTpq6+u1NJr9/oRTDnJIUoChznaQeVWXyx3B+0yC+SOV9iWhE1ug/
 h74Mfx83RHbPqQV/paoo9H8klr2gcRkIzbO3mdzOW3eaQC4Q7WNdn8I9eO5IpUXgnzNB
 Bis8rckkCDYzcWtpbzhfaY8+iaPrlItRfyW683l+4w7v+Iu75z5I2lnNZIn0v+uzXVPM
 QrEQwmlTUJDL3T6rd1Zwe4P4j9rW3U9nCC5r+upzHGYrTX6hUR1fytwNk+K21yby0eg+
 43pbSqLOUpdID3ZXVmeycEdll/oxDiz7sp5NC/rtVyvD8UFmuawS6ERqTvd0r1d5hUg0
 hsLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg7ROmSSt10jMHd3Rhox98T38w7kFu/COTGs1GBrcH4iwUu226RoLxqmJrw3mdbD5BfSh6+xsgNCXrOLc9F3rlR8UPcvk=
X-Gm-Message-State: AOJu0YzXfZt8UlT7FGDRR+1ihqJ2UKAYI2kirhA+TC0Sp5WqTM/fEh9f
 rh2/FyzP1EqjS97crkvLQvN/sImzjo4ndGVaKZGR9ifTd8cxevY4/n3Y7sZdUoI=
X-Google-Smtp-Source: AGHT+IEaaE5vcAqbDMHS74zA+eJ+aFw6tXseGVCr/geKqxG6+Kby9NgkHXaZtlhVmI16gek303N95A==
X-Received: by 2002:a17:902:6f08:b0:1e2:7c72:767 with SMTP id
 w8-20020a1709026f0800b001e27c720767mr1989412plk.30.1712339311606; 
 Fri, 05 Apr 2024 10:48:31 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 kz13-20020a170902f9cd00b001e275521788sm1853030plb.184.2024.04.05.10.48.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Apr 2024 10:48:31 -0700 (PDT)
Message-ID: <552eb484-c851-4a73-99e8-38a7011e6d2c@linaro.org>
Date: Fri, 5 Apr 2024 07:48:28 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/32] accel/tcg: Remove cpu_ldsb_code / cpu_ldsw_code
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
 <20240405131532.40913-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240405131532.40913-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 4/5/24 03:15, Philippe Mathieu-Daudé wrote:
> Previous commits replaced them by translator_ld* calls.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/cpu_ldst.h | 10 ----------
>   1 file changed, 10 deletions(-)

Thanks, queued.


r~

> 
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index eb8f3f0595..85ca104dc9 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -438,16 +438,6 @@ uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr);
>   uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr);
>   uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr);
>   
> -static inline int cpu_ldsb_code(CPUArchState *env, abi_ptr addr)
> -{
> -    return (int8_t)cpu_ldub_code(env, addr);
> -}
> -
> -static inline int cpu_ldsw_code(CPUArchState *env, abi_ptr addr)
> -{
> -    return (int16_t)cpu_lduw_code(env, addr);
> -}
> -
>   /**
>    * tlb_vaddr_to_host:
>    * @env: CPUArchState


