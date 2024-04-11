Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A2B7C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 21:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rv2OK-0007hp-FY; Thu, 11 Apr 2024 17:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv2OI-0007ha-Fw
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 17:55:30 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv2O5-00077q-Dt
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 17:55:30 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6ea163eb437so201729a34.2
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 14:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712872516; x=1713477316; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=knH1dI2N1CVFGCvAJigJ0zk1HzCZewFa1Lg+SH9lzK0=;
 b=PWFKX4J7QRpg5m3FYZHXGY+KiWCSDQ/Bsq9mqc0jPoMmLHBaHkd58CljAJNcxWmb/f
 aEMUchEZssnRjHPDU0f1GTKPH7JW3L3ERDseCiPej1/m1MEjfTnihL9MB4yIiL2NUFK3
 nwla9lczAKQqe1ZCHtdQp//Dibp9PrRPnNyEe2AEf5GPDyCapzgzS4ZmC8tFHsHlu08Y
 dOtYL4MGwswN0Q1XSEaj9ZZA9i70d5XdCNGKqU4/NyS5K6Lb3vND3L00xIEdQ0DnychP
 4kMnowI9dGM2hSPK9VERw4bfXkOyAQZqSOFs0dYMk5Lq+v0qf7Nw7qbYHshy2ZuVtung
 sc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712872516; x=1713477316;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=knH1dI2N1CVFGCvAJigJ0zk1HzCZewFa1Lg+SH9lzK0=;
 b=pjS6uHCAB2xffBz1S7oAC7gxmy5UddRWnn4GtH2PMyLAYS6BjaI6TurSpiGBb/21rP
 B6n94bV24UKa84Ixnd3gpmpMyDd31xnRPCcPvgs7uPlH4aAdorhSy4pxLGWGOHero+zc
 twtlV6GK5F0BKzTAFj9BfRYmz/Pza7sK4L6dyZJCWBJw2TkAUndptl74FvrwlsFR0RU2
 gd0NGN778/ku5IOBr047yGMf7DNDHoCyYy8Q9Z9dBOgC4Vr59xv4j9RVRoNIl2AmJsEB
 eqfi9CebsmCRL82zaSc2MrOw18izEyTBNcmF9cScTphn39p0jZlRD/c5txJ8z2cbRc4d
 +xxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9KfrdBIcsHIkmEN073Z1EQSgAMRtDzsD6ryq6tU6lApwD6wUzuz4Yb4OZPLiyCDQGVB3RtvlSAm+LwT0Ys1SoxhCf5uI=
X-Gm-Message-State: AOJu0Ywgb3ijni94tCElwX11mJWQYQBcvTQFvG14vSF39mNUiOVpjI95
 btmLuDV2n+XjC34KfYfwrXo1GwjrY2QKR71XGkEBVSWTVIa8M74KdmgoPx1XQnU=
X-Google-Smtp-Source: AGHT+IFUpSo9yqvrdjcMHtl/xNLqmumexWET8NZwnmVDKoCrflrUK/82faJpyLPkf919ErDf/YB+nA==
X-Received: by 2002:a05:6830:901:b0:6ea:173c:d6ac with SMTP id
 v1-20020a056830090100b006ea173cd6acmr1180166ott.3.1712872516024; 
 Thu, 11 Apr 2024 14:55:16 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 j7-20020a632307000000b005f0a5118863sm1526681pgj.12.2024.04.11.14.55.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 14:55:15 -0700 (PDT)
Message-ID: <dfa87b87-8685-46ea-ae5d-3735124fc76a@linaro.org>
Date: Thu, 11 Apr 2024 14:55:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/sparc: resolve ASI_USERTXT correctly
To: M Bazz <bazz@bazz1.com>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20240411212936.945-1-bazz@bazz1.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240411212936.945-1-bazz@bazz1.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 4/11/24 14:29, M Bazz wrote:
> fixes a longstanding bug which causes a "Nonparity Synchronous Error"
> kernel panic while using a debugger on Solaris / SunOS systems. The panic
> would occur on the first attempt to single-step the process.
> 
> The problem stems from an lda instruction on ASI_USERTXT (8). This asi
> was not being resolved correctly by resolve_asi().
> 
> Further details can be found in #2281
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2281
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2059
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1609
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1166
> 
> Signed-off-by: M Bazz <bazz@bazz1.com>
> ---
>   target/sparc/translate.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index 319934d9bd..1596005e22 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -3,6 +3,7 @@
>   
>      Copyright (C) 2003 Thomas M. Ogrisegg <tom@fnord.at>
>      Copyright (C) 2003-2005 Fabrice Bellard
> +   Copyright (C) 2024 M Bazz <bazz@bazz1.com>
>   
>      This library is free software; you can redistribute it and/or
>      modify it under the terms of the GNU Lesser General Public
> @@ -1159,6 +1160,7 @@ static DisasASI resolve_asi(DisasContext *dc, int asi, MemOp memop)
>                  || (asi == ASI_USERDATA
>                      && (dc->def->features & CPU_FEATURE_CASA))) {
>           switch (asi) {
> +        case ASI_USERTXT:    /* User text access */
>           case ASI_USERDATA:   /* User data access */
>               mem_idx = MMU_USER_IDX;
>               type = GET_ASI_DIRECT;

I don't believe this is correct, because it operates against the page's "read" permissions 
instead of "execute" permissions.


r~

