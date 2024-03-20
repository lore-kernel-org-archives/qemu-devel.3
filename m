Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B39C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 21:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn358-0003M7-DY; Wed, 20 Mar 2024 17:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rn355-0003Lq-1h
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 17:02:39 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rn353-0006l5-DP
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 17:02:38 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6e6ca2ac094so390579b3a.0
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 14:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710968555; x=1711573355; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sfpDhvNVJE/c/xB9tQjWioJlmZkL0NYOq3onpV9mdy8=;
 b=E1YwPbwLNV1G6jkFsGfN4CT0BKocZWyb3vOnOhOnePucNuYeEfE6yzpQZriv51YdbO
 QpFnE7tl/4ZHAsk0v2cimY8SbEHsgHJKq0tt+RSzcWGhkncW3BqEBMurkJRNP0ba8pbb
 Ps3UPcrWJkmeWpZknPW/L+G/CZlmPMEX0V2f72DzJxOCPNHtNRYVKvNE6Pa6Bd5VixNI
 9ugbhMv49oUAVV6nXsuKtohPzUtoKfFVlACsli4RxmGk5GX9VSrj+GxsLfkTk8ZbUr+Z
 T+Wf3A6qMdpih+uFjsIU9Ha4UheeyEu39cZjOMEbCty87oZhrGxpTUd15y5XtX8kQ8/J
 vwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710968555; x=1711573355;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sfpDhvNVJE/c/xB9tQjWioJlmZkL0NYOq3onpV9mdy8=;
 b=t2BSDfv0Moq+rIWaJAQx6XsnreHdYGRX6gvox9angPXFhJqbba2DTbvum+V5ExjF0I
 ajFuWsBndLJpYCWQftFKs8Uap/6JZRkqAnIiJWQ76K2L6we9hEo3uF23OpgaySBrZXbl
 1IMn7I+OG66R4vQ4bIyN1v2r8us0l8A4gN40XYyCI0ejmNTyeyf+egZYkfve19VP/KlS
 85En2fL1FNPl8Bqk0otBmnA6yinn+/w+dSd+P+P03n9SbbfzusynXELIYtcAI+ck8yR1
 XP6/kSkOsrHEfw4G6gLzt1vTJWaW/6zXVdYnxqriYoIooQybrl9FpqLpAqyByHo39SbP
 9s6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaCQmNypb+Nm536zoNbub30TNLLG9+kjtAAbjsagPK2YrYoYXVxcEWCXweSb5IwIB/6/XTueSH5Rk+tyCcrfyJD5laaVc=
X-Gm-Message-State: AOJu0YwzPAsFAiMU9u9LtZ23P++VbaoK2rGpsDR432T4coyq9Eaj1sHz
 rU7IUWF2FnasIxirwWs20VA4T4DxiNLfISPg4+lOVGnlaG8pcnyFomCG2Gvgyao=
X-Google-Smtp-Source: AGHT+IGIxG+2eywNbVbxgBBt8kuReFtWm37Y886JQrC54BOg7wa5pL36rKx73eW8wp2FrfHo+kzxDg==
X-Received: by 2002:a05:6a00:2d86:b0:6e8:414:94b1 with SMTP id
 fb6-20020a056a002d8600b006e8041494b1mr3462313pfb.3.1710968554615; 
 Wed, 20 Mar 2024 14:02:34 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 c19-20020aa78813000000b006e6a6866f02sm12037209pfo.40.2024.03.20.14.02.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 14:02:34 -0700 (PDT)
Message-ID: <a116ce8f-1ee0-4bad-8d05-88cac66b8a7e@ventanamicro.com>
Date: Wed, 20 Mar 2024 18:02:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] target/riscv/csr.c: Add functional of hvictl CSR
Content-Language: en-US
To: Irina Ryapolova <irina.ryapolova@syntacore.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
References: <20240320164259.19205-1-irina.ryapolova@syntacore.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240320164259.19205-1-irina.ryapolova@syntacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi,

This patch doesn't apply in master or alistair/riscv-to-apply.next. Can you
please re-send?


Thanks,


Daniel


On 3/20/24 13:42, Irina Ryapolova wrote:
> CSR hvictl (Hypervisor Virtual Interrupt Control) provides further flexibility
> for injecting interrupts into VS level in situations not fully supported by the
> facilities described thus far, but only with more active involvement of the hypervisor.
> 
> A hypervisor must use hvictl for any of the following:
> • asserting for VS level a major interrupt not supported by hvien and hvip;
> • implementing configurability of priorities at VS level for major interrupts beyond those sup-
> ported by hviprio1 and hviprio2; or
> • emulating an external interrupt controller for a virtual hart without the use of an IMSIC’s
> guest interrupt file, while also supporting configurable priorities both for external interrupts
> and for major interrupts to the virtual hart.
> 
> All hvictl fields together can affect the value of CSR vstopi (Virtual Supervisor Top Interrupt)
> and therefore the interrupt identity reported in vscause when an interrupt traps to VS-mode.
> When hvictl.VTI = 1, the absence of an interrupt for VS level can be indicated only by setting
> hvictl.IID = 9. Software might want to use the pair IID = 9, IPRIO = 0 generally to represent
> no interrupt in hvictl.
> 
> (See riscv-interrupts-1.0: Interrupts at VS level)
> 
> Signed-off-by: Irina Ryapolova <irina.ryapolova@syntacore.com>
> ---
> Changes for v2:
>    -added more information in commit message
> ---
>   target/riscv/csr.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 674ea075a4..0c21145eaf 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -3585,6 +3585,21 @@ static int read_hvictl(CPURISCVState *env, int csrno, target_ulong *val)
>   static int write_hvictl(CPURISCVState *env, int csrno, target_ulong val)
>   {
>       env->hvictl = val & HVICTL_VALID_MASK;
> +    if (env->hvictl & HVICTL_VTI)
> +    {
> +        uint32_t hviid = get_field(env->hvictl, HVICTL_IID);
> +        uint32_t hviprio = get_field(env->hvictl, HVICTL_IPRIO);
> +        /* the pair IID = 9, IPRIO = 0 generally to represent no interrupt in hvictl. */
> +        if (!(hviid == IRQ_S_EXT && hviprio == 0)) {
> +            uint64_t new_val = BIT(hviid) ;
> +             if (new_val & S_MODE_INTERRUPTS) {
> +                rmw_hvip64(env, csrno, NULL, new_val << 1, new_val << 1);
> +            } else if (new_val & LOCAL_INTERRUPTS) {
> +                rmw_hvip64(env, csrno, NULL, new_val, new_val);
> +            }
> +        }
> +    }
> +
>       return RISCV_EXCP_NONE;
>   }
>   

