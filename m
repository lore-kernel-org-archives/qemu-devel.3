Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3388D59D79
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 16:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU6QS-0004jS-3j; Fri, 12 Dec 2025 11:55:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vU6QO-0004i8-22
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 11:55:24 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vU6QM-0003tK-1C
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 11:55:23 -0500
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c95936e43cso534563a34.0
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 08:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765558520; x=1766163320; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hZxutSU2Up7QQImAeXsaV8ws6owqmOST/G5iaOQIm8A=;
 b=R2FYeX8UbTbLZLChUYLJE1clLEQW8bdYWoZh5z0x6wGEwYUkBEcxU/r1JCG9lmQmGi
 aUU4pHXzlnY+IAxwQDoWlAjiM1k40Co8W4EAKt+cIT+pvYf4svvO8royQAMNx5tIQ4ol
 JfpFxDReIN9B9P1lLEqyj6qaaAfuMsPGPZ+ZmrMqL+/ZYaRnz2rAgxu3iyOjf/UIZfb1
 VaOkklRoQdKEA4pomGhHCtRYCxYEd+Gv0ytgHRTQC+WpHZu54861N2Jn6ypXWS0dYEgp
 QrxC2V+Vgz2/tOXPjSCPkQtkWXPGl5LL11AuNWLksDUFj6rFbQXWUeDvhW4iO87CskMj
 3p3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765558520; x=1766163320;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hZxutSU2Up7QQImAeXsaV8ws6owqmOST/G5iaOQIm8A=;
 b=pTXGQCVkj1Ig24fcUQeN+sZNmGDry8jntoe0te519rGT7W/IHC1+c3S2rqRu9VHMu4
 FJQYr48wrMlkTDSjujM53+kusgxDPS+3PFkE5g20l2D2rZx9I8ean/SG8zXM3lULrvY+
 u/SIQ6lzd03C+z1BFy0NGSHid+zlNdWa0dNp4iTQ2kqHsfpI49ASF3e72vWIbs8h0xO0
 Ns8bJkuOdbSs2+wy2YGDF+k/oGWvevZXoW6pbYV8v7e4fpIP/hGjYhhAgHLsRl/ZgKX/
 Ixgx26Fid/YWFqZ0QD9E5euLm+xzyN4HKKqc66A8H0u1Qjp93MnWgEakhg3MyhvBV5t+
 FuBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJDCy+S2qZW9LWONtAt345FDMGCZr75lWtU85WJw7kRUK8T2w3Yb4g4rT0HPKY0edK/wMI3JLRkKr9@nongnu.org
X-Gm-Message-State: AOJu0YxkQmicL+fRUQ0z4e/aWgvuaaM0rJ2Xx/PrKNemGYc2dw0JtBZ0
 Vl6ZZAvD6nX6+EomjH1RUMRdsRhyGmWA15iZKRkceZ/jivsyyy9LVLOXIAe/GHz0gP4=
X-Gm-Gg: AY/fxX7p6SUDJkCsD8fmEN7M6pCf7pT+KxpjItpwJw0qYlew2HUWKJmW6l2zVnsCNF8
 E6rxSbnTu28Y2NMkQ2n2OFjGhmV5rOczCcujR4Vw2E+/X5Ul+sNH+2X0F2ylav9DxVNYttveXd2
 Cwio7Am2KyTju90Z46OaLvWFEc+wuTU3XtM/R9/kdGrQcZ5rm3kRtNSnMSPU5bXpngOIiDBZSOf
 dPKWXrxN7YjKMwQmY2Mzl6spAgmGnh8oSaZdKP6grJVRhiAHnFqkBXtzJhrwxCqxg97wOuhDX3H
 VYUnCwQZTelhNVc5xLIsiXwuzuaSE1gtq/yeCvH1PzUq2jwVj8hHMMHzhJH08VUFpL0Hwsicj7a
 dKie9lo7c1OAkojhRgw9/1mc8CCslDnKvLdQhSq7UMGx+FaO0zg5uIz01VUFEJYVPXE21YJdfVp
 PsVD8sJWRnYNN75R2YZpjezC98B/DQ
X-Google-Smtp-Source: AGHT+IEhP0swnNLAzLggKWz/pBD+8opWz21uFxk17mSwkLriTlHnuPYmw3bSvmFDBp+BbCU7gBGuEw==
X-Received: by 2002:a05:6830:6f08:b0:7ca:c7bb:e0a5 with SMTP id
 46e09a7af769-7cae838fc8cmr1145305a34.35.1765558520354; 
 Fri, 12 Dec 2025 08:55:20 -0800 (PST)
Received: from [10.229.62.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cadb1d1089sm3737305a34.6.2025.12.12.08.55.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Dec 2025 08:55:20 -0800 (PST)
Message-ID: <bb8c987a-d46b-48ff-96fa-df558e63b878@linaro.org>
Date: Fri, 12 Dec 2025 10:55:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 v3 17/22] target/mips: Inline
 cpu_ld/st_mmuidx_ra() calls in memory helpers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>
References: <20251126202200.23100-1-philmd@linaro.org>
 <20251126202200.23100-18-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251126202200.23100-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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

On 11/26/25 14:21, Philippe Mathieu-Daudé wrote:
> In preparation of removing the cpu_ld*_mmuidx_ra() and
> cpu_st*_mmuidx_ra() calls, inline them. Expand MO_TE to
> mo_endian_env(env).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/ldst_helper.c | 49 +++++++++++++++++++----------------
>   1 file changed, 27 insertions(+), 22 deletions(-)
> 
> diff --git a/target/mips/tcg/ldst_helper.c b/target/mips/tcg/ldst_helper.c
> index f3652034afa..716b60e3a39 100644
> --- a/target/mips/tcg/ldst_helper.c
> +++ b/target/mips/tcg/ldst_helper.c
> @@ -237,8 +237,10 @@ void helper_sdr(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
>   static const int multiple_regs[] = { 16, 17, 18, 19, 20, 21, 22, 23, 30 };
>   
>   void helper_lwm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
> -                uint32_t mem_idx)
> +                uint32_t mmu_idx)
>   {
> +    MemOp op = mo_endian_env(env) | MO_UL | MO_UNALN;
> +    MemOpIdx oi = make_memop_idx(op, mmu_idx);
>       target_ulong base_reglist = reglist & 0xf;
>       target_ulong do_r31 = reglist & 0x10;
>   
> @@ -247,20 +249,22 @@ void helper_lwm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
>   
>           for (i = 0; i < base_reglist; i++) {
>               env->active_tc.gpr[multiple_regs[i]] =
> -                (target_long)cpu_ldl_mmuidx_ra(env, addr, mem_idx, GETPC());
> +                (target_long)cpu_ldl_mmu(env, addr, oi, GETPC());

While this is a faithful expansion of cpu_ldl_mmuidx_ra, v5 micromips requires alignment 
and v6 micromips does not.  You may be better served passing the whole MemOpIdx down with 
MO_ALIGN vs MO_UNALN.

Or, indeed, dropping the helper entirely and implementing the function inline -- this 
maxes out at 10 load/stores after all.


r~

