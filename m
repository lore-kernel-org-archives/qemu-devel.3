Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B5ECD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 08:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPFZH-0002vP-Cm; Tue, 19 May 2026 04:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPFZF-0002uw-2D
 for qemu-devel@nongnu.org; Tue, 19 May 2026 04:12:45 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPFZD-0002IQ-DQ
 for qemu-devel@nongnu.org; Tue, 19 May 2026 04:12:44 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so38305595e9.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 01:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779178362; x=1779783162; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RBZbHfGorLdugkvurGeTvFtmPaJDC/xXvNw+s8MJXNk=;
 b=z7tLdamTLlMkFiFcQGl+m1is9xQk0L3cdnXFnDVyF15+hO+Vxyw+sft/KPVvZGKCuy
 kupmUT51c8w/t75aE6G9nmsFb1cNN319zkz2CYV1KK0NspM2fSLUNND0VZMalqcnMrA6
 KzuzUXqG7HxXC1GVXCCpk1IOQ63C59xHAqa9R9VQPQFNWktFuZyUIPlD5QFLng+sAZEz
 rWmo7lOUkWW+h8vO1a/UqxxwpilMU4jcciQ09DhUviQpmCR8mx+HT73B5x0Z4PKMYyR9
 qtRnQs/mlmXV/e0i2IFolPR2m5ESC2/ruDwz8SO2A6Gyvaln+U+bNunrb1aB3BpiHewS
 61gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779178362; x=1779783162;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RBZbHfGorLdugkvurGeTvFtmPaJDC/xXvNw+s8MJXNk=;
 b=c7cvIU/p5i/igRmQlokY8jABH127338C2e6QYiUD58Bbi8qpYhLn06fST19RNj0888
 mPuVRxftbQOKsds/dOUw91BbIvz/iC9/TJwQ6IFQt3l5pXln2SJmqZ5YSIPOTa8aIXbN
 jR1cd7t3jFduJbqkZj3s1iXQq7RnvJFjXIyADcSjAHSy9n9iVwPIMM90M7rNzUUFx9ZW
 Ds5m5WIrRSSNK3P2uaLRyWOmI/qcl1bRe1L4ib7LimfR6B/LoPJg7W9fFaNx4Tl0q2sp
 2B8efWfsDH7citBVfCzXKZvTEoWlBjPsitQIjuFQB5EgVvVkLILjIHPJafDYGgHVFX5n
 Qzmg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/8m3jcpvy8JeDqVtd4FTxI3fg5uJWI6XMomwPBHH0oMF+tStGBQqYQWvYOXhsT5eHMrLE0J8BgLzWO@nongnu.org
X-Gm-Message-State: AOJu0YyIh/9dy1ee77vdSxBvjD/Oy4p88n5laLtk9mjNfX9wrutcvZRt
 TQ8MIBEeB0ohn/9J7dTRshN0cAzM+DdpPLoMiPv7UWBnaf5cMJ+Qw9++YOxKCEqs6Oo=
X-Gm-Gg: Acq92OGKu6ls6CII/KZ38WkgLLIYndbuxVxOreyJosKMoRFn+2q/mmxuSTKJqCO5Ygs
 bsJvuIqqu4aPtEffoSgNS3F/6LKONhhbkbovjZ4o0GwhyZrtBquLn6LSjEPYNr3pU82kfpUVrHF
 srSg07278u+8L+6RDYoFOsP8luIAyrgT1Ikh31lNDzBNzC69Hxc+TlnQrA1VQi5pqYr9L/vjVa0
 oAL/h1G0i9Ms9mOgSpXODGGnSpw2HSusHhXOZhTQZnnh1paEaXIs3sG2KPL8ytDr2SWSX+KB91P
 igK3m+Ene922IWH+9p+r7975Acjlwt/Xt+OmbgXnCvVwS9iIAyLp2XP8JDi8VjF9PuQ1iacGzou
 76X1SnRQkQmJ/1dHdNDbcx9D42HKwcLIgb/j0XqvQxJddE6yESt3ytv2KP9QnfHQBKfdTCkl7PP
 FuK2zRDL3O7Dz+siKYyTsaZhVRnOYGAMslEIheEcD8zmfnEzV48GKnOtnT/ak=
X-Received: by 2002:a05:600c:8905:b0:48e:5d91:cffb with SMTP id
 5b1f17b1804b1-48fe60e7d6emr235423125e9.10.1779178361404; 
 Tue, 19 May 2026 01:12:41 -0700 (PDT)
Received: from [10.139.182.66] (101.170.88.92.rev.sfr.net. [92.88.170.101])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ed2f738sm42733759f8f.16.2026.05.19.01.12.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 01:12:40 -0700 (PDT)
Message-ID: <bba67cc3-132e-4d3e-aa49-8034c52e8ae1@linaro.org>
Date: Tue, 19 May 2026 10:12:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv/csr.c: fix read of pmpaddr(0-63) CSRs
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
References: <20260514123342.2139464-1-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260514123342.2139464-1-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 14/5/26 14:33, Daniel Henrique Barboza wrote:
> The priv spec defines, for RV64, that the upper 10 bits of
> pmpaddr0-pmpaddr63 are WARL and are supposed to be cleared.
> 
> After this patch, using the bug reproducer in [1], writing
> ffffffffffffffff in pmpaddr0 and reading it back now results in
> 003fffffffffffff.  Here's the 'diff -cp' dump before and after
> this change:
> 
> *************** IN:
> *** 5272,5278 ****
>     pmpcfg10 0000000000000000
>     pmpcfg12 0000000000000000
>     pmpcfg14 0000000000000000
> !  pmpaddr0 ffffffffffffffff
>     pmpaddr1 0000000000000000
>     pmpaddr2 0000000000000000
>     pmpaddr3 0000000000000000
> --- 5545,5551 ----
>     pmpcfg10 0000000000000000
>     pmpcfg12 0000000000000000
>     pmpcfg14 0000000000000000
> !  pmpaddr0 003fffffffffffff
>     pmpaddr1 0000000000000000
>     pmpaddr2 0000000000000000
>     pmpaddr3 0000000000000000
> 
> [1] https://gitlab.com/qemu-project/qemu/-/work_items/3362
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3362
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   target/riscv/csr.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index e1cd4a299c..476a620035 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -5362,6 +5362,23 @@ static RISCVException read_pmpaddr(CPURISCVState *env, int csrno,
>                                      target_ulong *val)
>   {
>       *val = pmpaddr_csr_read(env, csrno - CSR_PMPADDR0);
> +
> +    /*
> +     * For RV64, bits 54-63 of the address registers
> +     * PMPAADDR(0-63) is a WARL zero field (priv spec,
> +     * section "Physical Memory Protection CSRs").
> +     *
> +     * We'll have to add an annoying TARGET_RISCV64 gate
> +     * here to avoid complaints about masking bits 0-53
> +     * of a potential 32 bit target_ulong '*var'.

deposit64() shouldn't generate complains.

       *val = deposit64(*val, 54, 10, 0x000);

Anyhow,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +     */
> +#ifdef TARGET_RISCV64
> +    if (env->misa_mxl == MXL_RV64
> +        && csrno >= CSR_PMPADDR0 && csrno <= CSR_PMPADDR63) {
> +        target_ulong read_mask = MAKE_64BIT_MASK(0, 54);
> +        *val &= read_mask;
> +    }
> +#endif
>       return RISCV_EXCP_NONE;
>   }
>   


