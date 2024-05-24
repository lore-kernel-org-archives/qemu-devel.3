Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E3E9C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 16:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAYDj-0002mA-9x; Fri, 24 May 2024 12:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAYDi-0002k9-13
 for qemu-devel@nongnu.org; Fri, 24 May 2024 12:56:42 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAYDg-00054G-FN
 for qemu-devel@nongnu.org; Fri, 24 May 2024 12:56:41 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2be00b445c2so1125200a91.2
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 09:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716569799; x=1717174599; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KLGP1vvO3guVJPw+pH/oQ5QyLsaDY5tEaY47BQ/v4RE=;
 b=Me+0RFpUM1rbpmZaW+TesbIe4urECOQVJL5S6Eony3zWMrYza+Cd0SxfP44408XztQ
 x9en9ibwnesRfJaGqoEyqvWd+doaZDtQCrJptRcelT+9blkiYQq9MflzVqYcPCIEOCK+
 jCa9dqb6BMHPHphJ4fGdEyg22hPDGBYz6kGiAaU6j4a5SP07uK+VuR5GcxEszUZkP+5l
 htCHubgM5wTz7Hgwxu5oCHL+jXo0BnJ2Lwaf+81uvbNoPThZBkGlXY51iYHnWna/+8rp
 77nMrZga19o3mVyvs8uJ2CZagUPnkFSNSd3F+DM4C1Vs6GOx5g8SQkkFTuzpsODNO2M5
 /VMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716569799; x=1717174599;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KLGP1vvO3guVJPw+pH/oQ5QyLsaDY5tEaY47BQ/v4RE=;
 b=vT9avK6KOFj1rqCVQci15Jpidwqge/a8o1e83eFHqviOg7Hc8bbrO4i4ikOhh8nuff
 xEwablGPdPIXxPEMH9pi0z7X0ngchFV5DJzxzjEVExwT48iMn/MtDXZ87IEKPiCHEAF6
 3ZbyhA/DPiP5c1C8FmiGVL2Sdvg/T27n3ZkDECe4wYVryYsgsTrPZVOgHup6w+iaUL5J
 R08KOhUmg7ajEgDwz55r4esAd6HVpTJuY5u9mRr4mnhKLPpIl6TIpw/CvzAChYL4CNbS
 bwNayDS30C7R4D3late3AqzXwsyo3F25UWuN9qSSlfUJJNHoifgn5ErmIWseRIU3Hofq
 aAiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmCvS8SuiDYU+o4BGSbtfzokcaOX4OmavJDDUMEqryjdjuFB92zWFk/u+GX7jCqpk/FfXU5AHRsSRA3DRqCfthA3RkZs4=
X-Gm-Message-State: AOJu0YzfN0lAcG04fVva49l9sNuyYHAMj/EyDsuERTj6BWVHUallcgBJ
 Sesq5yayEi0PjvYYUKtorH+a6ABxw9yJgpqvYudTBwXE/jtHihqT1uIhxD/6HUo=
X-Google-Smtp-Source: AGHT+IG5y/cyotU/05maYS4HaEJiyRUapn/gz8xWkEG5Fyh7+g8aLpasww9X3JSbLWzEurmB6Ib4nQ==
X-Received: by 2002:a17:90b:304:b0:2b4:36d7:b6b5 with SMTP id
 98e67ed59e1d1-2bf5f74df89mr3214146a91.34.1716569798716; 
 Fri, 24 May 2024 09:56:38 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bdd9edea84sm3551030a91.5.2024.05.24.09.56.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 09:56:37 -0700 (PDT)
Message-ID: <05d71dae-df6b-4b61-8fd9-912c838ae460@linaro.org>
Date: Fri, 24 May 2024 09:56:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: disable jmp_opt if EFLAGS.RF is 1
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20240524153323.1267511-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240524153323.1267511-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 5/24/24 08:33, Paolo Bonzini wrote:
> If EFLAGS.RF is 1, special processing in gen_eob_worker() is needed and
> therefore goto_tb cannot be used.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index 76be7425800..ebcff8766cf 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -4660,7 +4660,7 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
>       dc->cpuid_7_1_eax_features = env->features[FEAT_7_1_EAX];
>       dc->cpuid_xsave_features = env->features[FEAT_XSAVE];
>       dc->jmp_opt = !((cflags & CF_NO_GOTO_TB) ||
> -                    (flags & (HF_TF_MASK | HF_INHIBIT_IRQ_MASK)));
> +                    (flags & (HF_RF_MASK | HF_TF_MASK | HF_INHIBIT_IRQ_MASK)));
>       /*
>        * If jmp_opt, we want to handle each string instruction individually.
>        * For icount also disable repz optimization so that each iteration

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

