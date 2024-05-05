Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DEF9C4345F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2024 17:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3flr-0000YQ-Uc; Sun, 05 May 2024 13:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3flk-0000VR-Fk
 for qemu-devel@nongnu.org; Sun, 05 May 2024 13:35:27 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3flf-0007Om-1l
 for qemu-devel@nongnu.org; Sun, 05 May 2024 13:35:24 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2343ae31a9bso830280fac.1
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 10:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714930517; x=1715535317; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B8T6VoYBthPtZSmCdHfaJk9u2APspxXe3l2AUJpAcUU=;
 b=RrBGd7b7FRPcd9omC4Arye1ySBTvgLXpbX5Zt2WtNC2SXXXuQM4w5vVwIqMZQPCViw
 43YACu8yCy5pDEpXSsRbDxJdBBWLBz1ZizVPAnKBL7nkVc8btZWMTJXn+E4NdaEgqclG
 sf5QYgwfp2y3eDOUDRQmmPEqDnKmPSuQSzOV9/U0VnFcVuRk8OjkjCLDc0kc/464H+c/
 43BXRP1sj4Ba7TyGyjONUJIj76EaxB6HMy9BT0lpvMdUi9L+IVFnqaITI0v+kD6w/MAj
 +VLGmlw9qTDSYQcbI7sR3UfCBIVApvtVU5nZZhLbIeRKU7oz/cZhSLaR2qbXGusr6W7a
 hxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714930517; x=1715535317;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B8T6VoYBthPtZSmCdHfaJk9u2APspxXe3l2AUJpAcUU=;
 b=XZ0ImJBS6QjWYT3t6/k8W1XPzDyl+q4ShwEpKY2+RJCy29Y6dMJAT2EfzawHoiabXV
 SCR0hzg2b//i+eYO31YqLrdUVw7vdu8c9/QDBXQUFBhp+HiOkHuCkiGb+mS6amgv6nmH
 oZkCMgJvHvHruFQOL0V9p+pwoyrVnTPwFCzDrR7wbY+oP1jCRj2IaDsFpzN33Bo6NhQq
 a6L/DYiuuo2Xra6Xo6AthT1nDIt8O83WeDEdgqOz7VmUlyUzR9Jq7qWk0MKamwYovwUb
 iXwnKAgF4bH9iR483dmPIQMjGabFq6jhfWwX9zyQNsHjBdUCmLgN2HxYmaR88DztB0u+
 v/Mw==
X-Gm-Message-State: AOJu0Yx82DCBe0Ou750iRXp4sPa834I99MzlTTNS5L4mA1EUElxOoYTT
 NvX4pqFGMRk6+0fr+Vjq2VWiHA9REi85OoXnz4J87scN26w67pdmI3+ORPeLYGk=
X-Google-Smtp-Source: AGHT+IFFo9HheVw5AgpMSDwgUPKN3PYf98XpLUlT0bDtEOk20fQYlpt++K8E47L0KDCF+8Es0ZatYQ==
X-Received: by 2002:a05:6870:ac24:b0:22e:caed:b1f with SMTP id
 kw36-20020a056870ac2400b0022ecaed0b1fmr10264288oab.2.1714930516696; 
 Sun, 05 May 2024 10:35:16 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 h7-20020a056a00230700b006f46bc0999fsm1581199pfh.155.2024.05.05.10.35.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 May 2024 10:35:16 -0700 (PDT)
Message-ID: <0b1375d2-ee39-4225-a3c2-c95abd69968d@linaro.org>
Date: Sun, 5 May 2024 10:35:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] linux-user: i386/signal: Remove unused fp structs
To: "Dr. David Alan Gilbert" <dave@treblig.org>, peter.maydell@linaro.org,
 laurent@vivier.eu
Cc: qemu-devel@nongnu.org
References: <20240505171444.333302-1-dave@treblig.org>
 <20240505171444.333302-3-dave@treblig.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240505171444.333302-3-dave@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
> The structs 'target_fpxreg' and 'target_xmmreg' are unused since
> Paolo's:
> 
> Commit 2796f290b546 ("linux-user: i386/signal: support FXSAVE fpstate on
> 32-bit emulation")
> 
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>   linux-user/i386/signal.c | 10 ----------
>   1 file changed, 10 deletions(-)

I have

https://lore.kernel.org/qemu-devel/20240409050302.1523277-1-richard.henderson@linaro.org/

which cleans this up.  I need to refresh and resubmit.


r~

> 
> diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
> index 990048f42a..9bf602b388 100644
> --- a/linux-user/i386/signal.c
> +++ b/linux-user/i386/signal.c
> @@ -34,16 +34,6 @@ struct target_fpreg {
>       uint16_t exponent;
>   };
>   
> -struct target_fpxreg {
> -    uint16_t significand[4];
> -    uint16_t exponent;
> -    uint16_t padding[3];
> -};
> -
> -struct target_xmmreg {
> -    uint32_t element[4];
> -};
> -
>   struct target_fpx_sw_bytes {
>       uint32_t magic1;
>       uint32_t extended_size;


