Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CF1CD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 17:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLOlh-0003lD-6x; Fri, 08 May 2026 13:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLOld-0003kJ-65
 for qemu-devel@nongnu.org; Fri, 08 May 2026 13:13:38 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLOlb-0008Ld-Hq
 for qemu-devel@nongnu.org; Fri, 08 May 2026 13:13:36 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6969c864c89so1333148eaf.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 10:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778260414; x=1778865214; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n8tmtDohUfpCkCVj+VBAiMIsanhmZ1pbwWJCkcn/qBA=;
 b=vPffvDvp5d+04IgH+4Dc1w85Er25LZeGUNeg3Ao+ZKjrces0G1c5gYYrZbI2bl64x1
 yRyhhKhTqnFttsqnhW47dbqa1idBRWZMTBnfCZk2C3jJKx6hkuBlwIJovPJqtWcNBwxv
 5K5ps1jfT1UVw95nS2MdqIoi+X29ICX8chbs6Q7v9GBXVobOCldte9EIn/QhsGfJwlnW
 gfglS2kCl1SW5MZ4RlRLLXbH8UtNvRadIhWaaZntehHB0e/4QqV761EHsYrzSZydb7jv
 sfM90k93DuqrXw4Qad4VuTrUIVdoZPJ2WjokW19y3pJfBWioZSl42GDlrysLCuiCAvwN
 UYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778260414; x=1778865214;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n8tmtDohUfpCkCVj+VBAiMIsanhmZ1pbwWJCkcn/qBA=;
 b=bEQWFS3P/MKNw8agM0O9/Hcb+Ocxnr/lcSxDm+lQnAfmTL/PMmSCDYsi3udT87sjCm
 x7AdF8GtDZb/Yom5b158km/ULhkpBas5f9cSeLIoTkKzZZgMUuG4RmY/+NJ51UjXZuUl
 uI1lHk/CrmisOfYqasosLlIV4HQ3rdFuawoKgJzYsk7BYxg4PQJQztgjWc4hVDqrKmy1
 7pvpWD3AnVD03Q/Zs3Q2qvIloSbOmt3N2ZpXwaqkjgauyrV63RnY7DMmF2JOEtzdgdLp
 3D2a1NRuK1Mmfh1F40k94VGigWs223J8ngNlxHHbnp4LWfM0NkxxHyoxML8HzoyEj6J6
 weZw==
X-Gm-Message-State: AOJu0YwJkDFsNOhlBSAd9Am5EkYypz5jDc5fb9rP3zishr+9e+TlW8jK
 Ne9rL4Jks9w/TqzO4lhpuFRxN5rP8qqZhCtpdNutDjMP2YetqGKvldR8rijFYedhPEsIAlx7Jjn
 5X0wy
X-Gm-Gg: AeBDievu8R/eF+kSdXOO3p4SoBqtllfEUyqVNQTtmXz47gvRfNwc3hvKiR4Rby8Rflx
 RZRrcca2No8/cudcHnDE5cyATgaMmaX4LZjJH9fuUjY3OFnhGUmKVJZo39X+evkFnokHhDldirr
 FmH7nGPH6xsTPpRMWn8q3fQJ6pQYGkiRNps1swCrLL1dz4iuEMF7lqCX+QcuDSxSof68wKtc7iK
 QX7rzuFWJ6k0oO2SI6cMgEy87jO7Fvj1Sm9XAwKfv6tz5iCC7uuO53tYmuIXznZlpjt/UaCfrRe
 xPH3/mVS47g/pNsea3PUdm8NhaAjbuXfNcUYs9X6lbFf3fMBwWXo50gf4MkI83vnRoBsYnEweJi
 P4bYBgh+euOer3Z5BPKHCQ/WBnMO4VTjNCtkwWzEZDmoO2c8AMsWaYkFn0G7NgxK5Y0A0ChxI9C
 67O6+F057Dy05laGFc9iRHg2R02gC3IdCDpKf8h7gwNJ03ItBkqEJAdFNck83ULi9m0xg1RUhdJ
 AkvqrrnYLpcIoIXQZ60GjvZFVUiTzw=
X-Received: by 2002:a05:6820:1521:b0:696:1dbd:9827 with SMTP id
 006d021491bc7-69998cbaf94mr7708725eaf.12.1778260413914; 
 Fri, 08 May 2026 10:13:33 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:4b0a:aabe:cbe1:bd0c?
 ([2600:381:c938:6375:4b0a:aabe:cbe1:bd0c])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25c1a58asm1435135eaf.1.2026.05.08.10.13.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 10:13:33 -0700 (PDT)
Message-ID: <6015230a-7cae-49ad-a099-ce79ccf477cd@linaro.org>
Date: Fri, 8 May 2026 12:13:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/32] linux-user/mips: implement
 sysmips(MIPS_ATOMIC_SET)
To: qemu-devel@nongnu.org
References: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
 <20260508-mips-octeon-missing-insns-v2-v3-2-bcbec96357d9@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260508-mips-octeon-missing-insns-v2-v3-2-bcbec96357d9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc35.google.com
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

On 5/8/26 10:12, James Hilliard wrote:
> Implement the MIPS_ATOMIC_SET sysmips command as an aligned 32-bit atomic
> exchange in target memory.
> 
> MIPS reports syscall errors through a separate register, so successful old
> values can overlap the errno range.  Write the return value and error flag
> directly and return -QEMU_ESIGRETURN so the common syscall path leaves the
> registers unchanged.
> 
> Signed-off-by: James Hilliard<james.hilliard1@gmail.com>
> ---
> Changes v2 -> v3:
>    - Split MIPS_ATOMIC_SET out of the combined sysmips/MIPS_FIXADE patch.
>      (suggested by Richard Henderson)
>    - Always use the explicit MIPS return-register path for successful
>      atomic_set results.  (suggested by Richard Henderson)
> ---
>   linux-user/mips/target_syscall.h   |  1 +
>   linux-user/mips64/target_syscall.h |  1 +
>   linux-user/syscall.c               | 31 +++++++++++++++++++++++++++++++
>   3 files changed, 33 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

