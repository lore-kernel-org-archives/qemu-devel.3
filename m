Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3780C25B78
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 21:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBL4j-0001hA-UM; Sun, 26 May 2024 17:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sBL4i-0001gn-Ah
 for qemu-devel@nongnu.org; Sun, 26 May 2024 17:06:40 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sBL4g-0007Q6-Nq
 for qemu-devel@nongnu.org; Sun, 26 May 2024 17:06:40 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a62ef52e837so41975666b.3
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 14:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716757596; x=1717362396; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=g2aQCQwfrtawqB9moo8kRrwj5sfAZylhYQmBOCSoINs=;
 b=PA8WsOSNxSg4KbUPA1gawRbC61AEEzzdBokpdtaKDerL6FNH5Ve/wld+vpuorNohUZ
 wNGRf5dn5FXpnxwe0q44JzkD9srT+LnLbvWjekgsjxZGbduSnV2kc8SqmWpgCqMDVJox
 QQ611VSR+N/aat9woMsYE8O/kDbuaJHdEMHA2/KeAScYlqOx2/WR+FKVqGIMXpVmXuWF
 Y6bCn7Nm7pdgxxzUMhkxpASq/SMJKOMURgnl2dlKVydmCcloAojvFhRh3tmhgAjo4tDx
 Xf+Kjqa4BWux887lnFVBnWDmjfNKKJqPRZ4VjxRxj0MYXllBkXqWoy5mE5rSdfTuVFgM
 33HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716757596; x=1717362396;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g2aQCQwfrtawqB9moo8kRrwj5sfAZylhYQmBOCSoINs=;
 b=IlVZMgb3eQf/QRPvkb6YySp1FayTneedgtMmLdz2ii5tTOEzHd+mnh1ztB0McwiPcQ
 71i2P3mewFvX+tDTGg5kLcvVONuwugbIUXinUl9ujGPuI9NFtlLkHH1qw/jD3YBJl431
 KT+4dwEkt+Hh2D+ne+yVw4FEr1dBycGmAbiE784SFc2mt1WrKEPpya8+aLdMTP8F+PV2
 MQAeIyPXojoDgVQ30GZrNe2KmGJZe9ebBXSlh/P1l5JbtrzF4rWM5jdeNBQHlSj6X4XH
 jCiuY9rmqwa28Nu3DyxxhWhbouThpoPMx8+sFPq0QZ8mhQmIC4lty3b8IGJiKldqRHCz
 KOqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ+XALB7RLy/yVVJzPgdlPc9BHDlvR9mOXtb0gCt2x3Uc8lCcL36hMYR7AH7sXbrPgUiLbfPLoyk6RxeDxwwCuurAjIXc=
X-Gm-Message-State: AOJu0YzX4oXJCuDXeArjox33D6p/4USR8zvLVfZVMgNpUEgwb4Ua6CqW
 ZGol2UILayiwfOtGHkC6fLDlVQtiz8DqCsGt2dvBeS0ifcJE+kpr54ZbbsISNvVF1i8552Jl0G8
 /zeY=
X-Google-Smtp-Source: AGHT+IGvvrVzqsX+zcZXJGgF31Ficzyvrh7aPIKonYAgzbFoHP3lNqn1SUP3AZAD7JNK1EMKQj78pQ==
X-Received: by 2002:a17:906:f85b:b0:a62:821d:5df0 with SMTP id
 a640c23a62f3a-a62821d5f60mr460106866b.26.1716757596410; 
 Sun, 26 May 2024 14:06:36 -0700 (PDT)
Received: from [192.168.200.106] (83.11.37.15.ipv4.supernova.orange.pl.
 [83.11.37.15]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a62b5d80ff0sm220452466b.95.2024.05.26.14.06.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 May 2024 14:06:36 -0700 (PDT)
Message-ID: <63ff94b6-98df-4e5e-9c53-7a03c7309cd3@linaro.org>
Date: Sun, 26 May 2024 23:06:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Disable SVE extensions when SVE is disabled
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-stable@nongnu.org
References: <20240526204551.553282-1-richard.henderson@linaro.org>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB, en-HK
Organization: Linaro
In-Reply-To: <20240526204551.553282-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

W dniu 26.05.2024 o 22:45, Richard Henderson pisze:
> From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2304
> Reported-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

> ---
> 
> Marcin added the correct patch to the issue 3 weeks ago, so I'm giving
> him authorship here.  I only updated the comment a bit.

I am not fully sure is it everything needed to be honest.

Value 0x0000 in [3:0] means "The SVE instructions are implemented".

The way why it works is probably because QEMU keeps "there is no SVE" 
information separately and do not emulate them.

> Marcin, if you'd reply to this with your s-o-b, that would be helpful.

done


> r~
> 
> ---
>   target/arm/cpu64.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index c15d086049..862d2b92fa 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -109,7 +109,11 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
>            * No explicit bits enabled, and no implicit bits from sve-max-vq.
>            */
>           if (!cpu_isar_feature(aa64_sve, cpu)) {
> -            /* SVE is disabled and so are all vector lengths.  Good. */
> +            /*
> +             * SVE is disabled and so are all vector lengths.  Good.
> +             * Disable all SVE extensions as well.
> +             */
> +            cpu->isar.id_aa64zfr0 = 0;
>               return;
>           }
>   


