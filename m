Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6777EC531DA
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 00:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdJEQ-00027V-Dq; Sun, 11 Aug 2024 20:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdJEN-00022P-Sd
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 20:48:15 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdJEL-00023R-Pi
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 20:48:15 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-70d1d6369acso3208602b3a.0
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2024 17:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723423692; x=1724028492; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=waGUgMgB2cg7aAzhbrCKzBjdFEFtxFwTrEItquZ/nXQ=;
 b=X/FvcXt4pKzk7/1TyVgvsg3LtO3KSF9eptWbspGM6+BTKFqtzoUchorKr3u4piIJCB
 CM+MC4DO/iWuphimrdqxUXb4V6Cu9YCRlZqDk9q+f0rxl7kEUGw/bDgPTqH3/3vT1GH4
 Jpsu1Y6eTqAgS3KRvBS+y8ARkeAOI6Z2dj47nzxG7M6q9QMRzvjpNROyfr6d9nzx14Hb
 6y/PoxIp4nb58zpZzPJOr7U4y+BcsDcNZC7//DHDr4W8TF90xh+UdORavlew1eZhjzDh
 pKoqm8MpZJ1kmFP+2exM3oLueQxkLvVNocAGQx/Es2bm47DlQaRZmAwoUM/h/dR6YloY
 8pGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723423692; x=1724028492;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=waGUgMgB2cg7aAzhbrCKzBjdFEFtxFwTrEItquZ/nXQ=;
 b=YUkvxZ7G259RitSsRuENh6PpIVYaQjiGU64rT35O2iC9UWimkPCr4RKzS40TU2vm4G
 A/Q25k3F7r8rLZbZqS4Hl47GAzqrBEi+dISNPXBlBs0jq+ev6Tic9c5qgWHKTOVcXTwp
 g77ufHF6VjzGYheH+SOzBqVf/GIFVjb83Qo6qiqyyLd0f5N+4mc3KKVica09fEq1xuM4
 x2ATP+HiB0Eye0P6XNCBWM8HxtXkTjKxDb4wCafx62giXKTXHLmCp0XsEv/OwxdPcbUq
 pPfI67I6aS/QPRTku4xivFBkzLw56EZ3vzcm2lScrflU32O5zUIudIiX0NpU1YjC6DyD
 6Lsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvDpmwwHZ+QI2gOnMedYXvcfFuBkxnvNFsv5uP/VTCQedfTW39NeykS/qLR/colR5VNXhonGnAaQ7kuu2DkOe86ic9uP8=
X-Gm-Message-State: AOJu0YztrKCnxCjIomLsiylbETt6AJNkticR3iRxY/+LDxgVuaH1vs0P
 4RYkgrdMdjEmx1rMhLaBcOSMhC2qJeO1s/vpiWyFlguMSRZBurcjDMt4SoIRXj0=
X-Google-Smtp-Source: AGHT+IF+hMKnSBTl6E36ZmPhNTsDnPJxDiE+1AFlshUq8Ekib9huNeoS1g/bodZDDeJAjdm3AjtTzg==
X-Received: by 2002:a05:6a21:3102:b0:1c6:b0cc:c510 with SMTP id
 adf61e73a8af0-1c8a1ea81d6mr12216875637.9.1723423691930; 
 Sun, 11 Aug 2024 17:48:11 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e5a437c2sm2892629b3a.112.2024.08.11.17.48.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Aug 2024 17:48:11 -0700 (PDT)
Message-ID: <be719b7b-9096-4d15-9947-8e4003de302d@linaro.org>
Date: Mon, 12 Aug 2024 10:48:03 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1] target/mips: Fix execution mode in
 page_table_walk_refill()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Waldemar Brodkorb <wbx@uclibc-ng.org>
References: <20240811165407.26312-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240811165407.26312-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 8/12/24 02:54, Philippe Mathieu-Daudé wrote:
> When refactoring page_table_walk_refill() in commit 4e999bf419
> we replaced the execution mode and forced it to kernel mode.
> Restore the previous behavior to also get supervisor / user modes.
> 
> Reported-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Reported-by: Waldemar Brodkorb <wbx@uclibc-ng.org>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2470
> Fixes: 4e999bf419 ("target/mips: Pass ptw_mmu_idx down from mips_cpu_tlb_fill")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/sysemu/tlb_helper.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/target/mips/tcg/sysemu/tlb_helper.c b/target/mips/tcg/sysemu/tlb_helper.c
> index 3ba6d369a6..e7ae4f0bef 100644
> --- a/target/mips/tcg/sysemu/tlb_helper.c
> +++ b/target/mips/tcg/sysemu/tlb_helper.c
> @@ -940,8 +940,9 @@ bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>            * Memory reads during hardware page table walking are performed
>            * as if they were kernel-mode load instructions.
>            */
> -        int ptw_mmu_idx = (env->hflags & MIPS_HFLAG_ERL ?
> -                           MMU_ERL_IDX : MMU_KERNEL_IDX);
> +        int ptw_mmu_idx = (env->hflags & MIPS_HFLAG_ERL)
> +                          ? MMU_ERL_IDX
> +                          : (env->hflags & MIPS_HFLAG_KSU);

This contradicts the comment above.
If this code change is correct, then the comment isn't.

But the comment certainly makes sense -- page tables are never accessible to user mode.


r~

