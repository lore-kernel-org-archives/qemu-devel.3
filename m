Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA62C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 18:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfksB-0006pa-00; Thu, 29 Feb 2024 13:11:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfks9-0006ov-Un
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 13:11:09 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfks8-0001Xy-DZ
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 13:11:09 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-29a61872f4eso883384a91.2
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 10:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709230266; x=1709835066; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UelL58jthzWgr2ZVzsw8napWUszC3JHoy2BxbwYp6Qg=;
 b=AgJcVwv87S/4kv+32dYTXm/zM265SBJ6izT00XrtrGACPnBKyiY3H7cfhH355XE5P9
 rW/TF3iPqTa1h1DZJ+v7USgSZc8YAXIwKtYzUUQ47E1Sf0UZer7L0AnW202YUL6Oup7o
 SVOsuHGf3BXTQDsVjPcy1qRooqlttsbRnaTnx/6LOEbWEvYqD2fPVK4I+/KoOCuFrAOm
 brNI2uBdbm62iYnWw1o1anEAZswBGpPRQ5myrFXixRXp/PTGpSKgSpiMGoHEdrgAYJV9
 riMv2UCd+dhyJCLWg4LitEJqBKuvFL8bpTSyHQczWt+X6KduWilkHMtbVQFjui9N6rNE
 pGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709230266; x=1709835066;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UelL58jthzWgr2ZVzsw8napWUszC3JHoy2BxbwYp6Qg=;
 b=pr3vvz6WcYDtbAtfuW5qc6SXJ2Mp97OUiQUxOoMTpm3GRQ0/Jdn1i+1slUQ9pip6Nh
 msIkVsiNY1SveNtaD9KIQJ4SKsRWXXue46nz0i5zbHjcO/GTouafw4g2Zw6x0GgK0Y52
 RlZIPK1gXE2ML9aTIxL3rdS1pI/6vL9tVLVldLw71uqqPjdWihNmJlPdJGhcWZemYG+A
 bYVF7li3cjx/uHNcST3qB+wxupneO9QkV1vgfASduA8nSDa2nff4S62UHm6UI5u84rjE
 a6bBgf2ZjGNqZea+LYLibXfj85/NHjB9GlmZynjsR7mT2oWg4F/rw6hbfh7xBnrVhSm2
 frnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJlf5pADnXBmpJaX/X7hFzsGloLTN6Ot1032uo219Wv8eOG+ywQ0tK9yFn5C8fbYANVxl1+ol+rkIIdswnw/w2JcUJEiQ=
X-Gm-Message-State: AOJu0YwAVDY7eBfdRkn4fL0NtrmX2Mxo2DtXJZjzDEexxCCDFIZnzL5o
 eaXd8m2IsmZr0xyFKtJCwvW7+RrLoBuUDsYwcXSbwri9UPRRMH8O/5ZlqRBnnY8=
X-Google-Smtp-Source: AGHT+IFx6SjZHuvQ9g8+x6HlWwGZfO5VKoP4ipGkepMsRvzyDGRcwu2mDHI5EGbA059+6B3rVBV9uQ==
X-Received: by 2002:a17:90a:aa88:b0:299:7824:6a06 with SMTP id
 l8-20020a17090aaa8800b0029978246a06mr3075879pjq.8.1709230266630; 
 Thu, 29 Feb 2024 10:11:06 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 gf18-20020a17090ac7d200b0029a45b28d43sm1799647pjb.14.2024.02.29.10.11.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 10:11:06 -0800 (PST)
Message-ID: <fdde1d3b-6578-4ba8-9567-f2a79ae2ec3b@linaro.org>
Date: Thu, 29 Feb 2024 08:11:02 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] disas/hppa: drop raw opcode dump
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240229140557.1749767-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240229140557.1749767-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 2/29/24 04:05, Alex Bennée wrote:
> The hppa disassembly is different from the others due to leading with
> the raw opcode data. This confuses plugins looking for instruction
> prefixes to match instructions. For plugins like execlog there is
> another mechanism for getting the instruction byte data.
> 
> For the sake of consistently just present the instruction assembly
> code.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   disas/hppa.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/disas/hppa.c b/disas/hppa.c
> index 22dce9b41bb..dd34cce211b 100644
> --- a/disas/hppa.c
> +++ b/disas/hppa.c
> @@ -1972,10 +1972,6 @@ print_insn_hppa (bfd_vma memaddr, disassemble_info *info)
>   
>     insn = bfd_getb32 (buffer);
>   
> -  info->fprintf_func(info->stream, " %02x %02x %02x %02x   ",
> -                (insn >> 24) & 0xff, (insn >> 16) & 0xff,
> -                (insn >>  8) & 0xff, insn & 0xff);
> -

It's hardly the only one doing this.  Our capstone dumper does this, and glancing at some 
others riscv.c does as well.

When you say "the others", I think you mean "everything using capstone", which has uses a 
different print function entirely for plugins just to avoid the dump.


r~

