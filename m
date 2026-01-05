Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE842C2A062
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 00:37:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcYbF-0007Qc-Ku; Sun, 04 Jan 2026 19:37:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYbE-0007QM-50
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:37:32 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYbC-0000r5-LE
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:37:31 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-29f102b013fso168953275ad.2
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 16:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767573449; x=1768178249; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3i4v5gECwExzhredOzOZmpQvz+e4RZmNqxgF47q9l50=;
 b=WXuUcnC6Rb1ku51UOJTuxM65r0N0OOAUWCGNQtTY2BjE+PusnUeH74FFLe6Yf1KVrf
 CWQ2zfnqpFPZ0q25JBFgEkFUctAH2JZj51wLddbDvtFa91g9psqBLMM/Em0mCtCkEMbU
 uC+LgPeDHT8hbzlh4FFF04vtIqYYvMtFQbc8EXuVNMB4aS6mxop8Ci93sGUb1Voau0uN
 sTuHMxAjAtEk2roTKhHfX30Z+6yZePhMobszKggCmx9IjoGvR25Eh2mNqTNVjL63Roo3
 ooNv4gFGnUiq5P3GdyJAG0R63JSDQTKyqknkR7j5ZDFoUzycSBnfWrRShnGUsNJW6CXr
 QR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767573449; x=1768178249;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3i4v5gECwExzhredOzOZmpQvz+e4RZmNqxgF47q9l50=;
 b=LKj5Eu6zIjuEabxmMvrxM0jTvv7LPOCEw8ixBGfN956eqyF4Wzz8iA7+TvxnSb+ui+
 tz96h4Lxe+5yr+SgsBKfBuCaiN5Qup7IV4ZWeVLI4Z3SOvnh0F26qYmsjXtSzdiCUzdM
 o+rllnYiJbKt06nLDs8x1wLqt1OgXVrGFtg/YdnuKCuMDFIgLgccwnbycvwHyeKA71on
 ENNUBc7QRYUrf41yeHQpzBlgZFgnnGa3BBp2eZW/7y44JGnppXRkcUZGIHpqovoM56iJ
 28bc825290k6Ft4r+jfnXTBtJqHjhjqWHw0CCNjhMUKMoqE0tHKQYYY2SaY95qahUryC
 B/Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKy3w758WXGTkMVrBJPzvWLVQThOYaY3hTIqQzBf1s7LLJLoFL91mhjy82ln73M7c/UTfLxUVyikET@nongnu.org
X-Gm-Message-State: AOJu0Yx5Q0TeIqYDDgDWhR4PU5Ol8ETVX28ZtOt81L78dtX8U46zZ2t3
 EjcL4CGgP9GxgF872K6wMuMK1VDIAFuqGYd5UGWFI5RDi96GNCZirs+PrArvv7r6AaQ=
X-Gm-Gg: AY/fxX4EJzrZKsP9WzIfjU4ajUriNjL89zkFG9d0W+MYT3/FZWtgS9hFzufAhXRszy4
 G0HVVv5ygm4ocUdXm0py6uwKsY0hM3eJkM7xWofZuulQLPQ4zHVamn/0jQLdNr7UtPZlmhv4uOC
 tGs3VgOkdfAv8GTrAEDkk95DTE3AwF5CBYWPkX5p4TvtB9awMXJb5zfnYayTbt8IuLGWIpSspS3
 Tmip63VfwgVVtoOpDEfIau1KSq3LqOqQUstJTg4oPan3sC2Bh7ujpiOWx//5k4P5ZH/T86zN/8z
 1cWehuJlH7vE1EV7G8fiIUcrskUzbsYW7Bz6V56kQtNUjhKMOIQ1GCF6EqvJWvTg7UeKGnkh55I
 BachMAR1iTN1uN8o7b1kA01XOBwZh43i+91WqwnWkRo5fpqEue4WPbGGIvT4ctA6MJRlf7KOLQ2
 1udcltnKmAQvyvPTFwAK3xPFWSzgNgnw==
X-Google-Smtp-Source: AGHT+IHcJxrjYq2wtX0FJvSqAjc4Z1xMBrQrPG4d34tDTaqVMcTS7icKE4483flkuBzI6ZmnVe27Cg==
X-Received: by 2002:a17:903:b90:b0:29f:301a:f6da with SMTP id
 d9443c01a7336-2a2f2a34f54mr474567445ad.43.1767573449089; 
 Sun, 04 Jan 2026 16:37:29 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d5d3e1sm426611455ad.76.2026.01.04.16.37.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 16:37:28 -0800 (PST)
Message-ID: <a48503cb-0a62-4cc7-83ff-393945dace0d@linaro.org>
Date: Mon, 5 Jan 2026 11:37:21 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] target/sparc: Simplify gdbstub
 sparc_cpu_gdb_write_register()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
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
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224162642.90857-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 12/25/25 03:26, Philippe Mathieu-Daudé wrote:
> Rather than ldtul_p() which uses the underlying 'unsigned
> long' size, use the ldn() variant, passing the access size
> as argument (evaluating TARGET_LONG_BITS / 8).
> 
> No need to use #ifdef'ry to check for TARGET_ABI32, since
> it is 64-bit:
> 
>    $ git grep -E '(ABI32|LONG_BITS)' configs/targets/sparc*
>    configs/targets/sparc-linux-user.mak:5:TARGET_LONG_BITS=32
>    configs/targets/sparc-softmmu.mak:4:TARGET_LONG_BITS=32
>    configs/targets/sparc32plus-linux-user.mak:2:TARGET_ABI32=y
>    configs/targets/sparc32plus-linux-user.mak:8:TARGET_LONG_BITS=64
>    configs/targets/sparc64-linux-user.mak:8:TARGET_LONG_BITS=64
>    configs/targets/sparc64-softmmu.mak:6:TARGET_LONG_BITS=64
> 
> Directly expand to the big-endian variant (with the '_be' suffix)
> since we only build the SPARC targets as big-endian.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/sparc/gdbstub.c | 12 ++----------
>   1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
> index 134617fb232..d265681f6d2 100644
> --- a/target/sparc/gdbstub.c
> +++ b/target/sparc/gdbstub.c
> @@ -112,15 +112,7 @@ int sparc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>   {
>       SPARCCPU *cpu = SPARC_CPU(cs);
>       CPUSPARCState *env = &cpu->env;
> -#if defined(TARGET_ABI32)
> -    uint32_t tmp;
> -
> -    tmp = ldl_p(mem_buf);
> -#else
> -    target_ulong tmp;
> -
> -    tmp = ldtul_p(mem_buf);
> -#endif
> +    uint64_t tmp = ldn_be_p(mem_buf, TARGET_LONG_BITS / 8);

No, this changes the behaviour of sparc32plus.


r~

