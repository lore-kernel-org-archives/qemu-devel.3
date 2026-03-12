Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D6F106ACDF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 19:30:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0ljm-0001Ta-7O; Thu, 12 Mar 2026 15:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0ljj-0001S0-6U
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 15:30:23 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0ljf-0006sh-Sx
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 15:30:22 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4852f73d0a3so12961415e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 12:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773343818; x=1773948618; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sCeWBveGp8vAJRpmp2UGiJDCWNV+FgGXnkU4c2dH/Nc=;
 b=XNt2xvOtfUgEpEC9Acg4VWjmWRcPIACVgvAGMLIrfE+Es64AkQTTUq9Ui8DpO40HSV
 2qCBW03YqoQLNy/UTHEkzoXXqWyQiWuOeppMVaRxxxYhtdoFvEDSQ6Zvrdk0ZJTdAU3H
 hEq3NqZ0I4yyFcl8QRKmVkpNptc7b+yZwc4+gvpwwcHxBIObfpmg0+IroaFLg9lLhFxT
 VbIENqg+TEAcikTG6r8A0G6IXcNP885nc+nOD3MBrOJ+JSEkzOdSB++6pDNQHDL7yvYB
 Ca/uK5GZleRWKnAwCAVDqVpi0+VdfhbyVuRVvzMpHBP0AHxap+5riBCT/TxysF9vOHX9
 aRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773343818; x=1773948618;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sCeWBveGp8vAJRpmp2UGiJDCWNV+FgGXnkU4c2dH/Nc=;
 b=lqmrAXoUhb6Q50fxnIQTiqy/5F0jNRgHUWPohCfTtjQJrDUqPGOu3OF1HHMGWUxNKX
 SMa+nLI0xjeOvvXsG8s2w5ZNDQbZAAaQ5GNjJ7MUndff3m1hf3lahSbYmklv+uheS2WN
 AvPqpx2D3k1vG1mzgcS68pxfKburvaUYMmZaZEb4+ushe/Nnro0mjZoHOeMrCXbHLlAX
 e0NG2QFOkx95nPTio4kwN69n/+GjB/TTKTqH6F/LJ8ZcmJDBAxP4QEG11uIanA99Hg1k
 WeW1A6tBLmTfwYRmeQvXa+/qXPiV7sxVvdQDTfMavnHnZH9hXg4s1BQE3WmeRWxfyZRs
 1x2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtaDoD2pNP3GlEq+HdqIdWhHvgv+BkYbjWhpI/oYeu5ufBG4MKvyC0N6U3Q7gj2ztooeLNY/m6sKyX@nongnu.org
X-Gm-Message-State: AOJu0Yyo8/HNRJBLPGQwQ9xxBumDsRXOlOwvvy27Slzg1unCc1Z1FH+U
 KKfntulzjxmYUtOKOVCDPvoCmNPAvCPu8t0nagwJ9JfqSeDYALhQ9Xo9UtWT9+RHRBU=
X-Gm-Gg: ATEYQzxjwNg7SrfVnuHFMPgcYrGj7vhkoJDOe/kKafKtXwOjSnYrFaZlX6RGW0vZCJi
 w1deubt9bKJzYF2klkB6SiW2GvodFm85MglVaABHig7QAwwhEfKHTVADu0qlG3sGO5hmRUkeTOz
 jVO6mhGS48oyDFQJv6BuBxEo2vItN3VwOy0Y70ceSkwR1y3dQ4rXrA9hmDeYAGWxemZ5xliPdGe
 2cTPYPYOuNFpWBQwOp53ZDmQmEQMTqcjpO9oZjJQkIkNBXf7gfjgPs6W09QzIL/Lx9PrtbuU5An
 anzua+q1X9DMVUZveeEGvMCFy7LC6Tf3k6RCDAWIdfIt2mQcZxr+NDCXCNtn1W6HYYrt/Jnge41
 aFAEnQfwpATHpHjRyFQZVvF4dkAvw9HHMUWwRxmgIvo0whGlHAc7F3ubC3//ZxcDEI+iDklMslN
 TymLVycIl8V6rg9SDWzAMwtI1lb2ha3kLck1D8kjTA9PEomqj0iYPrZJTtkz4R+uHpYQ==
X-Received: by 2002:a05:600c:3489:b0:46e:32dd:1b1a with SMTP id
 5b1f17b1804b1-485566ca8bbmr8241825e9.7.1773343818016; 
 Thu, 12 Mar 2026 12:30:18 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854e2537c3sm140355545e9.15.2026.03.12.12.30.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 12:30:17 -0700 (PDT)
Message-ID: <289033b3-99c1-4dc1-b3a8-d2afb97eb301@linaro.org>
Date: Thu, 12 Mar 2026 20:30:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] semihosting/uaccess: Use the cpu_internal_tswap()
 functions
Content-Language: en-US
To: =?UTF-8?Q?Martin_Kr=C3=B6ning?= <martin.kroening@eonerc.rwth-aachen.de>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260311-semihosting-cpu-tswap-v3-0-8e239575ec08@eonerc.rwth-aachen.de>
 <20260311-semihosting-cpu-tswap-v3-3-8e239575ec08@eonerc.rwth-aachen.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260311-semihosting-cpu-tswap-v3-3-8e239575ec08@eonerc.rwth-aachen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 11/3/26 17:27, Martin Kröning wrote:
> The semihosting ABI [1] states:
>> Multi-byte values in memory must be formatted as pure little-endian or pure
>> big-endian to match the endianness mapping configuration of the processor.
> 
> This commits ensures that semihosting data is properly byte-swapped if
> the guest's CPU is currently in a different runtime-configurable
> endianness than the host's CPU.

This patch also remove the target-specificity in semihosting,
which is an excellent news for me \o/

> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3258
> Buglink: https://github.com/taiki-e/semihosting/issues/18
> 
> [1]: https://github.com/ARM-software/abi-aa/blob/2025Q1/semihosting/semihosting.rst#the-semihosting-interface
> 
> Signed-off-by: Martin Kröning <martin.kroening@eonerc.rwth-aachen.de>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/semihosting/uaccess.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/semihosting/uaccess.h b/include/semihosting/uaccess.h
> index 2093a49827..0911e3b31d 100644
> --- a/include/semihosting/uaccess.h
> +++ b/include/semihosting/uaccess.h
> @@ -28,7 +28,7 @@
>       ({ uint64_t val_ = 0;                                               \
>          int ret_ = cpu_memory_rw_debug(env_cpu(env), (addr),             \
>                                         &val_, sizeof(val_), 0);          \
> -       (val) = tswap64(val_); ret_; })
> +       (val) = cpu_internal_tswap64(cs, val_); ret_; })
>   
>   /**
>    * get_user_u32:
> @@ -39,7 +39,7 @@
>       ({ uint32_t val_ = 0;                                               \
>          int ret_ = cpu_memory_rw_debug(env_cpu(env), (addr),             \
>                                         &val_, sizeof(val_), 0);          \
> -       (val) = tswap32(val_); ret_; })
> +       (val) = cpu_internal_tswap32(cs, val_); ret_; })
>   
>   /**
>    * get_user_u8:
> @@ -65,7 +65,7 @@
>    * Returns: 0 on success, -1 on error.
>    */
>   #define put_user_u64(val, addr)                                         \
> -    ({ uint64_t val_ = tswap64(val);                                    \
> +    ({ uint64_t val_ = cpu_internal_tswap64(cs, val);                   \
>          cpu_memory_rw_debug(env_cpu(env), (addr), &val_, sizeof(val_), 1); })
>   
>   /**
> @@ -74,7 +74,7 @@
>    * Returns: 0 on success, -1 on error.
>    */
>   #define put_user_u32(val, addr)                                         \
> -    ({ uint32_t val_ = tswap32(val);                                    \
> +    ({ uint32_t val_ = cpu_internal_tswap32(cs, val);                   \
>          cpu_memory_rw_debug(env_cpu(env), (addr), &val_, sizeof(val_), 1); })
>   
>   /**
> 


