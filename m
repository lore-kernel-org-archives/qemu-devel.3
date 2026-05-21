Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DF7CD343F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 06:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPwgU-0001SQ-CX; Thu, 21 May 2026 02:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPwgS-0001R7-Np
 for qemu-devel@nongnu.org; Thu, 21 May 2026 02:15:04 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPwgQ-00016k-Mi
 for qemu-devel@nongnu.org; Thu, 21 May 2026 02:15:04 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4903974854dso1241745e9.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 23:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779344101; x=1779948901; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qF2N4PMBlW9DbwOA+hxmJeiiasxAB6R59LbaJVebFIg=;
 b=WP/r5rrHXnk/wQWd7fWVyQh3Gq3prkTDirLrT7orNmwVryqL4Sqj/DqRTwBg1IUUDd
 WIm/X0s47r80WOpzKFNFudH6RYyDiN50BTC8uC6SbiwThx2TynBEm4FlR3jFO1oe9ViE
 8u/mbi07nqJ0161VbKoaY+4J4uzXRuW/xmWFf3LmSD8HdrwRnhkOjoE6xPnoRKFUrKSU
 +wreQM1U4+/2cufQo9IhwVSfW5l9TqqLGq8zX/NMl0MKIgdPviVtdUAuIxd5sBezOUw4
 quV1wP1dBmJpLPz/6W0nLou2BWN94O0nq/a7Cfja2WUElRxtiRejQ2UXCJdk6lkotpmB
 YHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779344101; x=1779948901;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qF2N4PMBlW9DbwOA+hxmJeiiasxAB6R59LbaJVebFIg=;
 b=qyxch8KxxLREUOXqe+bzhRSnCX51ZaKiMXTQTsX15qNm8WuJFYjo2RFuq+vDNmqD92
 7k6nXiiXKNS0N9jhiTAbEQqh+8F3EOB/j39U9cIhIXBSyUlo3h49eUip+d0gFdkpaCRL
 217vuF+apesTfo7fwaOe+UozfRZ6rd/qhWcpGRsUV/w3X8hgCgIZMRG/vgWYn++4En/q
 GIOutMrEt4MpkHYR30MM/lkI/vm/EfECvVaRlAK+mRW1nOTB9sSTV4YBYpuWxJYc26um
 z9wFbZhp2vJiP2zoRl+lyMiLD4zV8d5NkyA/pdLg5MNZYUZucvw7P7zXaAE4vqzOmKS2
 186Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+KPpF4oYYDD343qtd7aYc2Utp6ntAie+g3xBgtjmAW4uYr8AksoOuPIllLEz1vIMQ5oeucO9rN6T+o@nongnu.org
X-Gm-Message-State: AOJu0YzkR2D2zXTXpsR1A5mMoCTg3ytC6fM8v7xifrLcBpugxnX4xovP
 YlO3CAm0qaKV/FTjRu/c2TxCvnwsXR0sBwfJH+bitPyjgUFxwSvLULIq/ilroKUh00k=
X-Gm-Gg: Acq92OFeRgdB09aipkjRmMksgLA4ZTZP+XAAKDqfbYwIzznXWwnQWApOZ/E7r9LtwiN
 LkbbTrNV6yOsS1uruhQ5/wmzeQRqQP4JTjTp5JXopQCGapj8DXRemnnbO2b9VhBaRwPgOIFuZmF
 R2QTOuMsvDD+r1NJbmu+vqCt0Bw6kCrZs3XRoA/VQA//opZNdSRQfiejmTkNTxDXPYOjev4+7rv
 OUG9J7e/8p1dFXCtuIS44CQAoDNqqOzloo0dF/8xeJV1ZNBegHv65pstNixmp15a5ET7XDTcXQ2
 4+1hzg+ANvM5k5t6OdA983NgwgkkgLklxfOkkvWnubRCjfMNt7UbxYhno+BiwnBFzasiv1CXGlU
 lhikgstepf6S2eSVr0c7b71Q1D+cneH3UvyaHDPrMBDaFsGQYppY+zBH/uId+rQTpcvmqTj14rf
 xIqYrczirIly9/PaYI+JnUTeD6dAGX/V4V82LUN/i2Qt0yxrfbQpkTIN6ZOIreqoWXIg==
X-Received: by 2002:a05:600c:4d82:b0:48f:e230:8caa with SMTP id
 5b1f17b1804b1-490360ceaf7mr10344025e9.30.1779344100643; 
 Wed, 20 May 2026 23:15:00 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49035c219a0sm8788415e9.5.2026.05.20.23.14.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 23:14:59 -0700 (PDT)
Message-ID: <847b18a1-ec09-42cd-b55d-a069b8b66abf@linaro.org>
Date: Thu, 21 May 2026 08:14:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] linux-user/mips64: fix elf_core_copy_regs register
 layout in core files
Content-Language: en-US
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-stable@nongnu.org
References: <20260521055821.1380491-1-mattst88@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260521055821.1380491-1-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Hi Matt,

On 21/5/26 07:58, Matt Turner wrote:
> mips64/elfload.c uses #include "../mips/elfload.c" to share code. When
> the compiler processes mips/elfload.c the quoted #include "target_elf.h"
> resolves relative to the including file's directory, so it picks up
> mips/target_elf.h instead of mips64/target_elf.h.  mips/target_elf.h
> pulls in mips/target_ptrace.h, whose target_pt_regs has a pad0[6] field
> before regs[].  As a result elf_core_copy_regs writes:
> 
>    r->pt.regs[i]   -> reserved[6+i]   (shifted by 6 from the correct index)
>    r->pt.cp0_epc   -> reserved[40]    (correct mips64 N64 index is 34)
> 
> The Linux kernel and glibc both use the mips64 N64 layout (no pad0): EPC
> at reserved[34].  Debuggers and libunwind reading the core with N64
> constants therefore see a completely wrong register set — EPC points to
> GP, RA holds the branch target instead of the link address, etc.
> 
> Fix by:
>   - Guarding the mips32 elf_core_copy_regs in mips/elfload.c with #ifndef
>     TARGET_MIPS64 so it is not compiled for mips64/mipsn32 targets.
>   - Providing a mips64-specific elf_core_copy_regs in mips64/elfload.c
>     that writes directly to r->reserved[i] with the correct N64 indices,
>     bypassing the struct field names that are tainted by the wrong header
>     include.
> 
> The mipsn32 (TARGET_ABI_MIPSN32) and mips64el targets are covered by the
> same mips64/elfload.c and benefit from the same fix.
> 
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> Cc: qemu-stable@nongnu.org
> ---
>   linux-user/mips/elfload.c   |  2 ++
>   linux-user/mips64/elfload.c | 29 +++++++++++++++++++++++++++++
>   2 files changed, 31 insertions(+)
> 
> diff --git ./linux-user/mips/elfload.c ./linux-user/mips/elfload.c
> index cc5bbf05ab..1a46e180cf 100644
> --- ./linux-user/mips/elfload.c
> +++ ./linux-user/mips/elfload.c
> @@ -131,6 +131,7 @@ const char *get_elf_base_platform(CPUState *cs)
>   #undef MATCH_PLATFORM_INSN
>   
>   /* See linux kernel: arch/mips/kernel/process.c:elf_dump_regs.  */
> +#ifndef TARGET_MIPS64
>   void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMIPSState *env)
>   {
>       for (int i = 1; i < ARRAY_SIZE(env->active_tc.gpr); i++) {
> @@ -146,3 +147,4 @@ void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMIPSState *env)
>       r->pt.cp0_status = tswapl(env->CP0_Status);
>       r->pt.cp0_cause = tswapl(env->CP0_Cause);

tswapl now expands to tswap32 and could be inlined for clarity,

>   }
> +#endif
> diff --git ./linux-user/mips64/elfload.c ./linux-user/mips64/elfload.c
> index b719555e65..d19e5f2439 100644
> --- ./linux-user/mips64/elfload.c
> +++ ./linux-user/mips64/elfload.c
> @@ -1 +1,30 @@
>   #include "../mips/elfload.c"
> +
> +/*
> + * mips/elfload.c defines elf_core_copy_regs guarded by #ifndef TARGET_MIPS64.
> + *
> + * We must provide the mips64 version here.  We cannot use r->pt.regs[] because
> + * when mips/elfload.c is #include'd above its "#include "target_elf.h"" resolves
> + * to mips/target_elf.h (compiler searches the including file's directory first),
> + * which pulls in mips/target_ptrace.h.  That struct has pad0[6] before regs[],
> + * so r->pt.regs[i] writes to reserved[6+i] — offset by 6 from what the kernel
> + * and glibc expect for the N64 ABI (EPC at reserved[34], not reserved[40]).
> + *
> + * Write directly to reserved[] using the mips64 N64 index layout:
> + *   R0-R31 at reserved[0..31], LO at [32], HI at [33], EPC at [34].
> + */
> +void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMIPSState *env)
> +{
> +    /* R0 is always 0; r->reserved is zero-initialised by the caller */
> +    for (int i = 1; i < 32; i++) {
> +        r->reserved[i] = tswapl(env->active_tc.gpr[i]);
> +    }
> +    r->reserved[26] = 0;   /* k0 */
> +    r->reserved[27] = 0;   /* k1 */
> +    r->reserved[32] = tswapl(env->active_tc.LO[0]);
> +    r->reserved[33] = tswapl(env->active_tc.HI[0]);
> +    r->reserved[34] = tswapl(env->active_tc.PC);
> +    r->reserved[35] = tswapl(env->CP0_BadVAddr);
> +    r->reserved[36] = tswapl(env->CP0_Status);
> +    r->reserved[37] = tswapl(env->CP0_Cause);

and this expands to tswap64; directly use it.

> +}


