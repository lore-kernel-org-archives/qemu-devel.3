Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D37CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 14:37:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNXBs-0000k6-1j; Thu, 14 May 2026 10:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNXBi-0000jB-B1
 for qemu-devel@nongnu.org; Thu, 14 May 2026 10:37:24 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNXBe-0002o7-7C
 for qemu-devel@nongnu.org; Thu, 14 May 2026 10:37:19 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso54736925e9.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 07:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778769419; x=1779374219; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VV174m43BESca0JNxs/4ul3QGuc//qkAACAf3Xk56bM=;
 b=k/PGkA1P6VI1VVNiWyS5X8cFM2FdyxlGCffg7JuUq+S34hz/9htIbtuFXtB4O0BFpf
 9cpZUYH4N9unRvzoBiQ5vDBi7kWkpkqMSxdGMbqCaISWhivP8UBJk5G1KajZSDwUrNsz
 lUK7L/0Ni9jDE3aDd/b2mPM9iclOzYG8CD/g5SPmfB/RnixL2oqTJINzkfySdJqxsbkT
 WaeT04vnw8qCy7NtRceJ/RHXvkAA4yGGDfEcS+0EX+wA8V9eNEOK72Ra8IUamKqJLLt+
 PMSx6R4lCYxTHty4lrHVuK06CuPdmTBizDZh8IfXSMjray7npXxVJsyalcmVF67FtqHw
 TdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778769419; x=1779374219;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VV174m43BESca0JNxs/4ul3QGuc//qkAACAf3Xk56bM=;
 b=hWjIQuiuLKGFU6aps9RZN3rToSdL5bu6gx4yYJmGEzVESJgFe9ubtAjdtEFj5Q8JDs
 vjHzG04bPZdDVvfOuTyZbZw4MUtfKc+1Ijcolyjgwqr3pPN6VEWvJ2BmmKp0aq0al4gQ
 js20ZQdFWLpXVrMitsEh6lRi2COeb9N/17Hlu7BN2L2GXaTryTNbwuBBAQ9a5fNJBzR9
 /LJLbR4jSfaCImpq5JbqMF3XVwSIXdjqjKHD7okQ+HGdyF+SZIqFOZjF3ODTzJ5TCUPg
 Mc+01nWHBGAQ1BmN1TsaD2FCy++9fLvgm+mrQvIfKfHSj34VI5KoljiKRZ8IPYElIpiE
 X7Uw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8kUAzSl0bTo5Cn7fsynHXXvo6JTL0V/cDhI5CH58oSByyPQkhPRR46RaycJ3t4y8gsruO7/q3Yi7ux@nongnu.org
X-Gm-Message-State: AOJu0YzFXz6yRB4B+c9H3BAhex5vR31x5snF4AApTQOYddPTRJ/1UCYJ
 BuJQrEZ4VQ9YPazsMONuKTNOI8k3MwdzvPVF2QYrVHWw07HrvTR4s586mE2oNnmrMuk=
X-Gm-Gg: Acq92OH6BOARoOY94QQdRXzGYxwa0F56guG/2D8RboAwqZ1gkUrGy/oV++P4vmRqrW0
 blEOa6G6xQZGySjFOCwdvam2rO2UrEzCi4WcBdTtObj84eeJA9jOeSaYUVgwapGMOnVxgdwDCAI
 tzRXLRHTRRXmufk7hD82wbtfUd6aQJNCNvi7HvXyjyvx6eKgcjrWXVXfrQeHAvZFnh4an/0g74Y
 Lbhl6bDA1zIyHPJV6k/4rOKTqn9GHaC5efTPewb9sY15LjOgV+6+l593ZmZvL/EZHKDBYpy4lvc
 F7IlGlNlBAg+4bNpFrgajfIOPDEGkUMyH5PGCltzxE5p7O7Z0fm4EVl/sPV5ImdDajCUS1i0owD
 Aa0twWsdsPecxrRlTF0L9LLxLPyQcgTXcyrUBT3hzyMf6RkygOvVki+JGa9BwOPuuczc6Tcp1Rm
 VvDUzpbY91HCbNYqqgQ9bHbGV93EppL3U4+CtnUcB524VoLy3im3Xf9tgoAQiQgeVr0SRt+Qmdq
 pfh
X-Received: by 2002:a05:600c:1d03:b0:48f:e230:80a0 with SMTP id
 5b1f17b1804b1-48fe23080bcmr20601645e9.30.1778769419157; 
 Thu, 14 May 2026 07:36:59 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe46545c0sm2491525e9.4.2026.05.14.07.36.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 07:36:58 -0700 (PDT)
Message-ID: <aaf78d3a-3297-4be6-8793-3297550af922@linaro.org>
Date: Thu, 14 May 2026 16:36:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/35] linux-user/mips, target/mips: honor MIPS_FIXADE
 for unaligned accesses
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
 <20260511-mips-octeon-missing-insns-v2-v6-3-5062889c4d3c@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-3-5062889c4d3c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 11/5/26 20:22, James Hilliard wrote:
> Linux/MIPS enables software fixups for user-mode unaligned scalar
> accesses by default through MIPS_FIXADE/TIF_FIXADE.  QEMU linux-user did
> not model that ABI, so MIPS guests took fatal AdEL/AdES exceptions unless
> translation was forced to use unaligned host accesses.
> 
> Key MIPS translation blocks on the linux-user unaligned policy, implement
> sysmips(MIPS_FIXADE) to toggle that policy, and raise SIGBUS/BUS_ADRALN
> when fixups are disabled.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v5 -> v6:
>    - Rename the TB flag from TB_FLAG_UNALIGN to TB_FLAG_MIPS_FIXADE
>      to match the MIPS_FIXADE ABI policy.
> 
> Changes v2 -> v3:
>    - Split MIPS_FLUSH_CACHE and MIPS_ATOMIC_SET into preparatory sysmips
>      patches.  (suggested by Richard Henderson)
> ---
>   linux-user/mips/cpu_loop.c         | 5 +++++
>   linux-user/mips/target_syscall.h   | 1 +
>   linux-user/mips64/target_syscall.h | 1 +
>   linux-user/syscall.c               | 8 ++++++++
>   target/mips/cpu.c                  | 8 ++++++--
>   target/mips/cpu.h                  | 4 ++++
>   target/mips/tcg/translate.c        | 6 +++++-
>   7 files changed, 30 insertions(+), 3 deletions(-)


> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> index f803d47763..6e827c72de 100644
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -565,11 +565,15 @@ static int mips_cpu_mmu_index(CPUState *cs, bool ifunc)
>   static TCGTBCPUState mips_get_tb_cpu_state(CPUState *cs)
>   {
>       CPUMIPSState *env = cpu_env(cs);
> +    uint32_t flags = env->hflags & MIPS_HFLAG_TB_MASK;
> +
> +#ifdef CONFIG_USER_ONLY
> +    flags |= TB_FLAG_MIPS_FIXADE * !cs->prctl_unalign_sigbus;

I'm not a big fan of this optimized style where you need to think
twice about what is being done. The following uses 3 lines but is
a no-brainer:

   if (!cs->prctl_unalign_sigbus) {
       flags |= TB_FLAG_MIPS_FIXADE
   }

> +#endif
>   
>       return (TCGTBCPUState){
>           .pc = env->active_tc.PC,
> -        .flags = env->hflags & (MIPS_HFLAG_TMASK | MIPS_HFLAG_BMASK |
> -                                MIPS_HFLAG_HWRENA_ULR),
> +        .flags = flags,
>       };
>   }


