Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB49FC4345F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2024 17:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3fjj-0007qM-Lp; Sun, 05 May 2024 13:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3fjf-0007jL-Be
 for qemu-devel@nongnu.org; Sun, 05 May 2024 13:33:15 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3fjc-0005TF-OH
 for qemu-devel@nongnu.org; Sun, 05 May 2024 13:33:14 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-620e30d8f37so1114570a12.2
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 10:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714930391; x=1715535191; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g3PYWvopIZrfVQ7tXwQRaNjruqa2ouFMMp6X6cMzKoU=;
 b=Dsb0wFfkreUFbCVUfxayKtfRr4Z1fRRdvdDWo+O25nSzHFa+hT8mZ+MjMnIX1BOQK8
 MG422oJCGIB/vTy5nJD/IsY77QpUxitpRqkANuWOmV3B03S6lPteXEj1HILB6cyzWXdY
 6aYDGZ3JFwAIUpG5iTmPB6A3PlqRAe0YDq02yx9hqAK0/cgz6vMPiCLxMmJUNglPVyR3
 GGBCEteZNdchxUz7IXyxFMtE4AvX+eOoVGaxaA/jaGWlHPSHKDBS3lAxSZ2+iwbcIbtT
 5P9cnKzSaGaIjoWdZVQQV1BT7F81vGJcNWY1MIpOGcyaApTnL0dUl1kt132mBQpN30oi
 /FUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714930391; x=1715535191;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g3PYWvopIZrfVQ7tXwQRaNjruqa2ouFMMp6X6cMzKoU=;
 b=bDuUwrd1aFv3J2u4KQ5QaM1YGpyZrtIucPdiIr6GrhPRaGmXW80BKDd5gb6X3r60f3
 4mD0GVI1o1t0nMpInBZLF4ZLAs9TBav4+xwKtkJKK9c4nv+zoilwFVfJRFUTgoGsgHiM
 jiuY9vbJDL2GaLNNW44f5ZqddbEZDUlbuZQ85qt0pdTle4OQrMMitYaKNMX1+JsIXwSo
 8D+iK9tJ3Qq9AASH/y8b0vNpoENXeGGnTlh9En0xPOhajX2BVuElgS8j0oLeGnSgzya4
 7oXW1bDaL6UNwTBCc1oT7PRXQOkQfbGUqUfoQX+SAqYmmxRXRJf9dJGA3D6rmFiGj4Xe
 RerA==
X-Gm-Message-State: AOJu0Yy8ovxgP/RljQN6kr3NZND1mRcmkCOiJWPAIkCEpLT5ejSyyjGR
 mh3LH1zUobqlZf0XErbdLP8xj3Q6hsOyr/jBVOzh6ikiBfZcU+muMNFXXJ/v32U=
X-Google-Smtp-Source: AGHT+IHOrP1UnYIuxu0/zZ0nkSDpZvGqQfON029LWWEHo0uEYrxFxUIAOigMu0Tk5/drVEsGgfSxng==
X-Received: by 2002:a05:6a21:3a45:b0:1af:9edd:9cb3 with SMTP id
 zu5-20020a056a213a4500b001af9edd9cb3mr5055071pzb.17.1714930390677; 
 Sun, 05 May 2024 10:33:10 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a056a0021d400b006eb3c3db4afsm6257674pfj.186.2024.05.05.10.33.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 May 2024 10:33:10 -0700 (PDT)
Message-ID: <4aad76e9-9576-46ca-890d-ea8e503e1f29@linaro.org>
Date: Sun, 5 May 2024 10:33:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] linux-user: cris: Remove unused struct
 'rt_signal_frame'
To: "Dr. David Alan Gilbert" <dave@treblig.org>, peter.maydell@linaro.org,
 laurent@vivier.eu
Cc: qemu-devel@nongnu.org
References: <20240505171444.333302-1-dave@treblig.org>
 <20240505171444.333302-2-dave@treblig.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240505171444.333302-2-dave@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

On 5/5/24 10:14, Dr. David Alan Gilbert wrote:
> Since 'setup_rt_frame' has never been implemented, this struct
> is unused.
> 
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>   linux-user/cris/signal.c | 8 --------
>   1 file changed, 8 deletions(-)

Cris is scheduled for removal in 9.2.
We could ignore this until then.

But either way,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/linux-user/cris/signal.c b/linux-user/cris/signal.c
> index 4f532b2903..10948bcf30 100644
> --- a/linux-user/cris/signal.c
> +++ b/linux-user/cris/signal.c
> @@ -35,14 +35,6 @@ struct target_signal_frame {
>       uint16_t retcode[4];      /* Trampoline code. */
>   };
>   
> -struct rt_signal_frame {
> -    siginfo_t *pinfo;
> -    void *puc;
> -    siginfo_t info;
> -    ucontext_t uc;
> -    uint16_t retcode[4];      /* Trampoline code. */
> -};
> -
>   static void setup_sigcontext(struct target_sigcontext *sc, CPUCRISState *env)
>   {
>       __put_user(env->regs[0], &sc->regs.r0);


