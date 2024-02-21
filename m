Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB95C5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 20:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctRI-0003Dm-0A; Wed, 21 Feb 2024 15:43:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rctRG-0003DM-R8
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 15:43:34 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rctRF-0002ss-8d
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 15:43:34 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5cddc5455aeso4903988a12.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 12:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708548212; x=1709153012; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1DStudNZILqEtkTGHTMzruY6GzOIq0x11JoStnSBDl8=;
 b=L8Qfuj0WzSZU3YuEfkxyyDGFFhf49C0FDKHIqJJWurcJxYa/5gsKManUIyH539+KiC
 NYh2rlY5uPK5Vja4ZXQdp77ywWWNjAjwMnUJ+R4ZfuFRSmSDHUfNkPL/bBZr2ZQMRFLk
 pS4s+fSNVjFle1417ZFNQ7gm3hIYSp4+S0ypbuswt5pDPWh3KC/84nyaw9aY2wSEu+sx
 SsSjhxNOh94RsW5YFE1G0zKcv+CeWggQQiZsVHyySeDgHSOvykAms9n64vPKhUmWY+hx
 rFG5UfD0pIM2OXmYy5aEvV/HoIKY9Xuekgro0MPp3ICRvt1dI7QC95gPBPh5r93MszTL
 /y3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708548212; x=1709153012;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1DStudNZILqEtkTGHTMzruY6GzOIq0x11JoStnSBDl8=;
 b=xQVQf6EsomX5XYbSi0bz58tnblJC5rdGNRllLjI9xfZ/XtAfVwZLOv3YwUUC96/Qe8
 9R7jdxJ7hgP9szI/1DpyWleY2ZAqTWzEtlqEJoIDXKM35+o6IplOGagFCBndlDpNXISL
 tbVY/9FfAFUUxvdby7wM2sKmZRBtSYTp1fMiPdXHPTSrhaCTik6S5ItRUr0qJqGko9z0
 yYTEBGF35/8J7oXAjAE1cvqsO9yfDDzpMVeIRaMu9Kan45WNZaZyfC/z9M/hHDyxa768
 EgHGNqk6M1VorXUII/i36y/nkUCVY4UXws+sDbnb6IbqKQsj3/5mYcT/N40uMh/JSTyY
 92qQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXe4JzKTBp3pm8/OZb+V6nmWGelz6tA1njto17rrSP9yUrVmYewoEJIXKWl26hem03VT43sIR/Y2KFz0qtf25TfLB0QRBQ=
X-Gm-Message-State: AOJu0YyLA9sHcl54mEyU1dhSQqar/RItw4LllXhxu+FlSFY1EF/6+gEJ
 JuwsFxtLgLhdsYZpbAWUJlQ2CMwFd6W9mRtLa7WLabRG9dmQGoB4waN8tFUI6I8=
X-Google-Smtp-Source: AGHT+IHX55aJ5IlpmQMLZwWoHnka4R83Nd8dGO7punxTLXWh0b+WsfWBYwIzUnV7Wm/dmqSFimSvJQ==
X-Received: by 2002:a05:6a21:8ccc:b0:19c:881d:78e6 with SMTP id
 ta12-20020a056a218ccc00b0019c881d78e6mr19824849pzb.42.1708548211644; 
 Wed, 21 Feb 2024 12:43:31 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 e14-20020a630f0e000000b005cfb6e7b0c7sm8015808pgl.39.2024.02.21.12.43.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 12:43:31 -0800 (PST)
Message-ID: <d7b1af7a-e03e-4ed5-b66e-e08ef56209c2@linaro.org>
Date: Wed, 21 Feb 2024 10:43:27 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 11/22] target/arm: Set pstate.ALLINT in
 arm_cpu_reset_hold
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240221130823.677762-1-ruanjinjie@huawei.com>
 <20240221130823.677762-12-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240221130823.677762-12-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 2/21/24 03:08, Jinjie Ruan via wrote:
> Set pstate.ALLINT in arm_cpu_reset_hold as daif do it.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   target/arm/cpu.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 055670343e..e850763158 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -357,6 +357,10 @@ static void arm_cpu_reset_hold(Object *obj)
>       }
>       env->daif = PSTATE_D | PSTATE_A | PSTATE_I | PSTATE_F;
>   
> +    if (cpu_isar_feature(aa64_nmi, cpu)) {
> +        env->allint = PSTATE_ALLINT;
> +    }
> +

Reset value of ALLINT is UNKNOWN.
I think you should drop this patch.


r~


