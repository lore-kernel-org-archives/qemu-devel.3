Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB01C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 13:19:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEU3u-0000JZ-Uo; Tue, 04 Jun 2024 09:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEU3t-0000Hx-2n
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:18:49 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEU3r-0007q0-BG
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:18:48 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2eaafda3b90so27960391fa.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 06:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717507125; x=1718111925; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f7XNRVpz+XO8/tx1n8vKj5ZJUmVByzRz4PsHJTLzyPE=;
 b=lMMBp1SM8zIkbETHBLNmddQcMUih7//n9iut8CnGBgm/Yy7h9sQGEsvOO5BTwMSlAx
 ag4BtiVfEWQXWdRRw73EGmcAq4K4Ictt5oyLQDCrCVtM0kN4k4UPltsHgXmqR4+Q6jBl
 aCljTR0hrx7eypyG8I/VlFPv0KY3dw5Hu5NlIjU9CJ2PmW+NmhNnHXVDFnSoI2/bzjKj
 cYFGhcdvOWsR9CiJY0BLtnhqp5RILZ/sTju2u0AU1VNdGOA3mbg7F8qF/LwaOBy5ujZQ
 uXrgnN+f2/VggoTuQylTZ4QiY9xz6rnPybBSXgSo9XUmBXTsSqN8HJQlrgU8UTkGyykp
 a9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717507125; x=1718111925;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f7XNRVpz+XO8/tx1n8vKj5ZJUmVByzRz4PsHJTLzyPE=;
 b=Ihl714ex7L6pXLWosg+FOy11PjeBcnKIZDGqBzcWsLr7c6Mh+wKxAhfgyCbLyXQA4Y
 GYP3yfYYBP38NWIsh8k9G2ZtAUgvKNeLeRNU7m7siIAZwjaeiUle+ad21xyWspiP5Mo3
 ZvArBBPaGabBsluH6C4TKItpu0lrqRn1J0/OSCJtefG89D4azMoPUx38eIDLOKhZjasG
 SSba3PTweUJB3AXNUM9I5E2B+aPOfflRPKIHN/FIQbBoNQ9GBPIyWtIRQWwmypsT2egd
 1wJS9bnMrV7d1M0YvA1u73bwk8Wr44F3tN5HQ0QT55wn6txQ6p/UU4l9my0EyNauU/Ok
 kz7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOYA97e/H8wyoMCoBpOj+MJNsu4p+9/iKJLA0aocLVL5xksIHqPK+SpINLRC6PLUFPpgXrXxCOWyAmL7uIcLbkRqwnxEw=
X-Gm-Message-State: AOJu0YxfJDBS89Cm1s5tg4YakbXH8698EnAH2LZcg8vYxr85LOgQ8I+h
 QeSW3HR9Vu/BYrSIuguWJMGWuAv2wC7lg0ownrjhGFx9pgu5PQhyt4AYLjpTa5k=
X-Google-Smtp-Source: AGHT+IHHYITrRfPAyujItzKT2mW/08hDsP5e1gU4jDhExr22BxvFLIl1kb1z2TwvV7KTt+VP3AOzHw==
X-Received: by 2002:a2e:2a83:0:b0:2ea:7d8f:b0a with SMTP id
 38308e7fff4ca-2ea94f5b056mr80858371fa.0.1717507125167; 
 Tue, 04 Jun 2024 06:18:45 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4213c264714sm79652585e9.12.2024.06.04.06.18.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 06:18:44 -0700 (PDT)
Message-ID: <079d6c4f-d02a-4f86-a4bd-96c09bfd8e11@linaro.org>
Date: Tue, 4 Jun 2024 15:18:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/37] target/sparc: Use gvec for VIS1 parallel add/sub
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20240526194254.459395-1-richard.henderson@linaro.org>
 <20240526194254.459395-9-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240526194254.459395-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
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

On 26/5/24 21:42, Richard Henderson wrote:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/translate.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index 362e88de18..8731e4f8bb 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -4664,6 +4664,20 @@ static bool do_dfd(DisasContext *dc, arg_r_r_r *a,
>   
>   TRANS(FMUL8x16, VIS1, do_dfd, a, gen_helper_fmul8x16)
>   
> +static bool do_gvec_ddd(DisasContext *dc, arg_r_r_r *a, MemOp vece,
> +                        void (*func)(unsigned, uint32_t, uint32_t,
> +                                     uint32_t, uint32_t, uint32_t))
> +{

I missed the FPU check I guess:

     if (gen_trap_ifnofpu(dc)) {
         return true;
     }

> +    func(vece, gen_offset_fpr_D(a->rd), gen_offset_fpr_D(a->rs1),
> +         gen_offset_fpr_D(a->rs2), 8, 8);
> +    return advance_pc(dc);
> +}


