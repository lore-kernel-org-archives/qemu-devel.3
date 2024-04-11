Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A546C001CC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 21:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rv1Zm-0002tf-Ui; Thu, 11 Apr 2024 17:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv1Zf-0002sC-53
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 17:03:14 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv1Zd-0007I1-18
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 17:03:10 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6ed5109d924so291737b3a.0
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 14:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712869387; x=1713474187; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UFg8LpGbWjJdewisFMaAdYQRct2RbE/pxC2/MCy7zjk=;
 b=F22gb/MclihkerF5cJbCTmgPtyFiTE6LQQGlXAdUKGCGiSJ+xNWtWhMrsIf9cHTlqY
 /MektXC4pPOT23uMEtqDf9//v9J6ICUSVSJUpAj7xqi5pAtspzLDkwISQRv3vG4b/aH1
 jt7bZD2P7TJz2MpAF+AtCEjyvHUA+1xAvdpHc9EHsTAcnNezzUb39Gtp71orMgbkQRES
 kCRLVpNwTXsO/zaJVKTim5WnUMlKsgR4Vt76B1LfHTVHH8t4RilZFj/m+HqAeJ/JH0ol
 L3o3jmsxy9IG3bCVOuYaeU1O49BhZYJugIXVSLq1Rly20fvO4ploUNA2nuCclTz1x4yc
 7peA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712869387; x=1713474187;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UFg8LpGbWjJdewisFMaAdYQRct2RbE/pxC2/MCy7zjk=;
 b=PkEfAjerBIK3q2VxGzmQtPZCqvsOQwWeF6GkVp/hcoF29RzHo4xI4eIJWauCO75Y94
 USY6lg7mzflACD8B1153V8NHqOnWz79MobNcT8MzKQdmvV4PHP2JyWqYrybtSpj1jjGy
 bbolnKzRVmTmWLDpfvfM7EgfaJI5hnHWmoAHuSz0QK5yfEPVy6ceSPbDcHILLZ5wMHUX
 wwvlksZ7vwaw6ozwHQT9F2YDGeATBezuvZIr/2SjdoDv3Z1d3ReUVTaCaZqfKTvyJvzI
 RblsIMai/D4UbzDWRCOsGpFAvWjFms5w8jtW0xp6yjdClOKbqdPOU9tR0h9G85Jv/eJq
 Xv4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw/nOUTcGPJph/caGsaaKMbLG41ZhgHWqLq5BuXJPiytyDdAMRDs9OLo7E8xgSEpNLbFAsUc3cYWHh/DHfM6GWYRw3U5s=
X-Gm-Message-State: AOJu0YyF772mKeF7kSnRJfoI99W2V6493yk1lXhT4xBQ91V7LE2WJFsO
 AeMbYm/ACdc8MSZrysGUxplJwvIvEUEOVZM4u2A2mJWcrZtzRacixgy/w6GzY0A=
X-Google-Smtp-Source: AGHT+IEiVRxhH4erhfVUQmjE6SyQvZPPKDZt98EyPd8oMeDne8K4foEeKsneqOjASw7tGYF9SxbgrQ==
X-Received: by 2002:a05:6a00:1302:b0:6ed:63e:3525 with SMTP id
 j2-20020a056a00130200b006ed063e3525mr833129pfu.31.1712869387393; 
 Thu, 11 Apr 2024 14:03:07 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 gx15-20020a056a001e0f00b006e71aec34a8sm1599275pfb.167.2024.04.11.14.03.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 14:03:06 -0700 (PDT)
Message-ID: <b75c03fa-2db3-4dc4-bb52-a8b6f97fc0b6@linaro.org>
Date: Thu, 11 Apr 2024 14:03:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] disas/microblaze: Replace sprintf() by snprintf()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20240411104340.6617-1-philmd@linaro.org>
 <20240411104340.6617-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240411104340.6617-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 4/11/24 03:43, Philippe Mathieu-Daudé wrote:
> sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
> resulting in painful developper experience. Use snprintf() instead.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   disas/microblaze.c | 25 ++++++++++++++++---------
>   1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/disas/microblaze.c b/disas/microblaze.c
> index 0b89b9c4fa..49a4c0fd40 100644
> --- a/disas/microblaze.c
> +++ b/disas/microblaze.c
> @@ -600,7 +600,8 @@ static char *
>   get_field (long instr, long mask, unsigned short low)
>   {
>     char tmpstr[25];
> -  sprintf(tmpstr, "%s%d", register_prefix, (int)((instr & mask) >> low));
> +  snprintf(tmpstr, sizeof(tmpstr), "%s%d", register_prefix,
> +           (int)((instr & mask) >> low));
>     return(strdup(tmpstr));

Any s*printf followed by allocation should use g_strdup_printf to do it in one step.


r~

