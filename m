Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F88BC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 13:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0gmC-0003Ri-JU; Fri, 04 Apr 2025 09:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0gmB-0003RO-AL
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 09:08:03 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0gm9-0003yC-8A
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 09:08:03 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso19137975e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 06:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743772078; x=1744376878; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sWNPYwcQS2v4r0YL3JKZUq35y/xI66WU8qs2yBV59n8=;
 b=nivK9v/obHnFs7hfTSGNkN7rCbrQl/dJY/Id8b1lL9BleVu0MQiDcuQcrS7X5QC3rQ
 4ICm+KseQ/Rwk0Q++KBReW6v2MxDjKWJ+NyWIZvOIfjDqdBzmG+fg6qSDTYFdaMrSSbA
 kpNvaEy1pcaqJvQTe9IzYAWbOq17yj+I10cUZOGIGQ5b1gujK6/8ch2qhpYA5xzgadDN
 NPi6HdUseSCmomF/8MbuGmSWPOODl6mu/ddO/D5r5tae00G96SpnP/8TUj3xGkGB+er/
 mjWakgHLvRv41P1K2IbmF0z8MZnxg3oG1Yn/qVAMPqOlDBIGPrEeTRPyD8XlTy+8Y6zb
 LzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743772078; x=1744376878;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sWNPYwcQS2v4r0YL3JKZUq35y/xI66WU8qs2yBV59n8=;
 b=r6Zz7ZTKvZRdKWEeQ2kJKSRdyrb5QP6H1S9NSVT6HngbAsKZKNQGF8pVmiwdlvsY5J
 SavEVxj5FBIGPwHV8jECl2UC3HxNU9yscERxjiC7gkquJhp0IzY+brPyipulC2ncS4RH
 6xNECUmoZGxq6KHuwBNbOMaqu9dguc9rBW7BWzlhA9cUTuoA03Hx7xU0MSHt+k4jhEmW
 zU/ESdj4mjjlqlfHwbIpkbDQzW8oa1/KRkmNqpauT7HXdBYSuJZ/OjixfC96bV23P3cM
 g2EFsFRVlsVNwd1FhZV0V08a8AYMvmcskvs4IXvis1MJ5a0GOnVqCQfy6l+oi2qaHSVX
 Ds8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVV11Kylytrx0fzKgMRtq7CO1e1XC1qv3bKEOz2lYkxcNSNc0rUxsxUNMNSpTi8fuaTZl5Ffnh2qKxo@nongnu.org
X-Gm-Message-State: AOJu0YwV/7cVblTwTOGuD9QfVG1kz2Hca7na4lrFnNCAW6JVi31LM3RF
 YTL8hc41PkQqsKJwqiBbQnpWGye4nky4yPQNVe2PjOA3cAhJtRfFvOn7YSGyBPI=
X-Gm-Gg: ASbGncsse8a0Xd8EqbX6RW+KqFtAn9vsOVakfYk+m0PkP0LLtVEQd8+B0TuyFJuBp3D
 rmunCJPoY2Wv4ZLf/LFvmZUSAgaXeoFhoy0sVsiTVa6xalnA002jgSNlHwkDkrz5qn5eTkMqpqB
 TcSsQePyVjCdX9tSsfp3f5nzLTtfU2mqF46QDNgVQz4I00vBDoR68xF/t/qBGFXAO2M6kN8/V9j
 SBy7FhIyF7arrFCGp597NVHrM1Rwftb/qyPspybbiiQ4/9K5y5bjkLEO1UjFz50yFZN55jB1EE6
 8AcBUUeXKDYAYb3XGg0ac3/okhUKp3vwHzhWsAw6DIArD01WKrui17ncn8NN3JmMEYlznGg4d/Q
 7CB6NK8tV59gkHKCOgw==
X-Google-Smtp-Source: AGHT+IFSGclpSDGbL/5j2UJtn7TyU8HoUvzJntwZNdwlM3/Z2JW1Rimwy2PuBbwzX6+u4E67spTEVw==
X-Received: by 2002:a05:600c:8119:b0:43d:762:e0c4 with SMTP id
 5b1f17b1804b1-43ecfa19076mr24723495e9.27.1743772077125; 
 Fri, 04 Apr 2025 06:07:57 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec3669002sm46141555e9.33.2025.04.04.06.07.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 06:07:56 -0700 (PDT)
Message-ID: <cfcf9a32-1745-4d46-a2a2-977a0d0af195@linaro.org>
Date: Fri, 4 Apr 2025 15:07:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0] docs: deprecate RISC-V default machine option
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20250404122858.241598-1-dbarboza@ventanamicro.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250404122858.241598-1-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 4/4/25 14:28, Daniel Henrique Barboza wrote:
> Commit 5b4beba124 ("RISC-V Spike Machines") added the Spike machine and
> made it default for qemu-system-riscv32/64. It was the first RISC-V
> machine added in QEMU so setting it as default was sensible.
> 
> Today we have 7 riscv64 and 6 riscv32 machines and having 'spike' as
> default machine is not intuitive. For example, [1] is a bug that was
> opened with the 'virt' board in mind, but given that the user didn't
> pass a '-machine' option, the user was using 'spike' without knowing.
> 
> Being explicit in the command line is desirable when we have a handful
> of boards available, so deprecate the default machine setting from
> RISC-V.
> 
> [1] https://gitlab.com/qemu-project/qemu/-/issues/2467
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   docs/about/deprecated.rst | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 76291fdfd6..0f41a99c67 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -304,6 +304,23 @@ online to check that this board did not completely bitrot yet). It is
>   recommended to use another MIPS machine for future MIPS code development
>   instead.
>   
> +RISC-V default machine option (since 10.0)
> +''''''''''''''''''''''''''''''''''''''''''
> +
> +RISC-V defines ``spike`` as the default machine if no machine option is
> +given in the command line.  This happens because ``spike`` is the first
> +RISC-V machine implemented in QEMU and setting it as default was
> +convenient at that time.  Now we have 7 riscv64 and 6 riscv32 machines
> +and having ``spike`` as a default is no longer justified.  This default
> +will also promote situations where users think they're running ``virt``
> +(the most used RISC-V machine type in 10.0) when in fact they're
> +running ``spike``.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Having users specify "-M virt" doesn't seem much of a hassle IMHO,
so I'd not use 'virt' as the /new/ default in 10.2 (but we aren't
there yet).

> +
> +Removing the default machine option forces users to always set the machine
> +they want to use and avoids confusion.  Existing users of the ``spike``
> +machine must ensure that they're setting the ``spike`` machine in the
> +command line (``-M spike``).
> +

