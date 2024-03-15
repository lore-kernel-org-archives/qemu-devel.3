Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D11C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 21:18:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlEwK-00069t-5p; Fri, 15 Mar 2024 17:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlEwI-00068y-JM
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 17:18:06 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlEw2-0003rZ-QF
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 17:18:06 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1df01161b39so3003425ad.3
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 14:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710537469; x=1711142269; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xV3HHMxjQU2Rp76L6hu0/nLW35Ymf+FHob5Xxjod2TI=;
 b=Xk75giYN/h0VB9ZRqrTyi6coYOBmpDUvxT+/sTZc5bVO2ks0a9V6sYNWkQjS0LrJcH
 dBHpV3c9y45cfV7PNzLW3qw8Kq1L9/ukDAUypRHn/uiF3ioaKjm4eAxih+GqssoYUIyI
 5RhzE54+72N3XWVjLxFKHGSUQf2yI79qEZbjOh41O122Z31mOnKQOWRST4n4N1Jaz4Yc
 +aIrVxvdbhXzNJS1SBYpxGx2sxY5+wmSKuKIOi7qiJkYLLZSoXrR4Mtwv8GHv4o4e/LQ
 aUiKMElR0dr/dsQwkhBnSUnl9APGCAjtaa4v4U6PnAtUQVCns9I4OakYTEAliM8lZJ6p
 0ZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710537469; x=1711142269;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xV3HHMxjQU2Rp76L6hu0/nLW35Ymf+FHob5Xxjod2TI=;
 b=amNMXMSqhZtDB+Ol4UslV46Vuefizsf4arcE1W7sJB1B31lFI+UsktGMReEzILv3RY
 5LOoEw61re7xSVufammGyxyuXIkBaCbS3mI3c2uoR/X3ZCjt3qVZ/WeGI/XQjSV8tqEu
 JruXmNIzVnzfMx7jw6yGcOj8VK+J223SWTaXOnLKPQs6UDKC4hnGFEU+zLuRDPiiCll8
 xgRxJBoDs2U9c6PkAwSJKV5mNLFzUx9NouCeHrORAkHRyJR6P5RlvYD+iYKWAnUKm7ej
 YeOdiOb3fLmRV115pSrqP3HaFnYM74bX5xreaVylcpfH2AR8nVpyU0GTxA2ZqetLGmqR
 gkCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWf6/d01MjTL2ZMQuhFh7lxqcSn1RZsiO+i30Dj7nK1r8EoCe4Q4P7xljqx/+h7+JUkB2AyPhQh3Za4Mej6yDOySIOZXGk=
X-Gm-Message-State: AOJu0YwaJOvdb5toWuLN47qNv7SfEoupPow2EQg9P5L4fNgY83G+mTx/
 0CQ6TGjlyh0IhRlUZIjYT0qGyzQQ7k6V8kycDEQKemXq+FB9opZCneJDMg33XAE=
X-Google-Smtp-Source: AGHT+IFr1ecz9fPYB7wAPQJrpzkFXwC3Xw+lkJCaQ/6+lHE+/loV6a/mM0gr+0e93OxUsCAExzFbng==
X-Received: by 2002:a17:902:ce8b:b0:1de:eddc:9f9a with SMTP id
 f11-20020a170902ce8b00b001deeddc9f9amr4270530plg.53.1710537468831; 
 Fri, 15 Mar 2024 14:17:48 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 o19-20020a170902e29300b001dd8d298693sm4365995plc.23.2024.03.15.14.17.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Mar 2024 14:17:48 -0700 (PDT)
Message-ID: <10037d6d-6aee-4d3e-a7f4-810aac401dfc@linaro.org>
Date: Fri, 15 Mar 2024 11:17:44 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 06/12] tcg/sparc64: Check for USER_ONLY definition
 instead of SOFTMMU one
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org
References: <20240313213339.82071-1-philmd@linaro.org>
 <20240313213339.82071-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240313213339.82071-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/13/24 11:33, Philippe Mathieu-Daudé wrote:
> Since we *might* have user emulation with softmmu,
> replace the system emulation check by !user emulation one.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tcg/sparc64/tcg-target.c.inc | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

This is all really softmmu.

If we ever grow user-only softmmu support, these will have to be runtime tests.  But until 
then the ifdefs are really pointing out softmmu uses.


r~

> 
> diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
> index 176c98740b..56915a913b 100644
> --- a/tcg/sparc64/tcg-target.c.inc
> +++ b/tcg/sparc64/tcg-target.c.inc
> @@ -78,7 +78,7 @@ static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
>   #define TCG_REG_T2  TCG_REG_G2
>   #define TCG_REG_T3  TCG_REG_O7
>   
> -#ifndef CONFIG_SOFTMMU
> +#ifdef CONFIG_USER_ONLY
>   # define TCG_GUEST_BASE_REG TCG_REG_I5
>   #endif
>   
> @@ -961,7 +961,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
>       tcg_out32(s, SAVE | INSN_RD(TCG_REG_O6) | INSN_RS1(TCG_REG_O6) |
>                 INSN_IMM13(-frame_size));
>   
> -#ifndef CONFIG_SOFTMMU
> +#ifdef CONFIG_USER_ONLY
>       if (guest_base != 0) {
>           tcg_out_movi_int(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG,
>                            guest_base, true, TCG_REG_T1);
> @@ -1075,7 +1075,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
>       h->aa.align = MAX(h->aa.align, s_bits);
>       a_mask = (1u << h->aa.align) - 1;
>   
> -#ifdef CONFIG_SOFTMMU
> +#ifndef CONFIG_USER_ONLY
>       int mem_index = get_mmuidx(oi);
>       int fast_off = tlb_mask_table_ofs(s, mem_index);
>       int mask_off = fast_off + offsetof(CPUTLBDescFast, mask);
> @@ -1147,7 +1147,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
>           tcg_out_bpcc0(s, COND_NE, BPCC_PN | BPCC_ICC, 0);
>       }
>       h->base = guest_base ? TCG_GUEST_BASE_REG : TCG_REG_G0;
> -#endif
> +#endif /* CONFIG_USER_ONLY */
>   
>       /* If the guest address must be zero-extended, do in the delay slot.  */
>       if (addr_type == TCG_TYPE_I32) {


