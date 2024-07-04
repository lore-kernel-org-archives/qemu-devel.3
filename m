Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED0AC3814E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 17:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPQfg-0000ZM-6i; Thu, 04 Jul 2024 13:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sPQfe-0000Vv-KT
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 13:55:02 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sPQfb-0004ir-NJ
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 13:55:02 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2ee7a1ad286so9450231fa.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 10:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720115697; x=1720720497; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Is3ZyLPwvt3nZQiAgUjvFvmblsM3OzpzDvlfgCbYMOA=;
 b=PPyKicaHSnKPYu7h3bG7wbnbtW6iMfY3tAszSVrUb2c0ROeDV1JK2/JOHTapdzE3CY
 XrQYsatmRNWbiygrRCmKabi8oiiJqEkZjJXCoqDAECHRDz2z/LQfbi7o92/tAcdcDNxy
 seojFUE3Nmx5tI8g19TfZdMGcIaI6ttKeLZDDMSrK9MZpiH5WqgEcENWHcSkfOGyzfbA
 GTJpl6dkeAU2g2Vj/fmjiwxC4Olf0KEZ2S3VxNS2dvrqIKMlO5nhVk1ePG2LLqvjar08
 +FNqhLS/y+oky4S2kaaeVlHTH0FcZasdkBVqD6a84ooGUCbR2UNnAy79dke3o1POxqts
 btNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720115697; x=1720720497;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Is3ZyLPwvt3nZQiAgUjvFvmblsM3OzpzDvlfgCbYMOA=;
 b=LrdqgX8kfK84lQ9uzBWWbRl0kvKXlFyCMwL5VEUzLpBYhcQdUd6ImsvWu1pdzf7HCz
 9ij6LzE8H15LEn4r4uGYfRT9CuhY0cfvMsf7Ni9v+5oy4bnktG6eby0ebDka1pUihYt9
 untgUnIWOAMbtpP1Z0J594hKPCtrQvMijjVa2u7bUxkxAk7d13UYzsO0vS7GgVsAMytY
 0/0CwDleonAK2pyWeV6nban1wSO0kTc2g58wx4q6yQST9CUdh3M0dJzosjG7uO2/4z9d
 1Xzu8lmYjgquhGMqkQNlIynIQMgHXcny8lCwS8h+DZoS3O9s652LAf/86jyICzGAt1wu
 98Cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF41tMljc3hOMdBDt7wifHb/RAWVQEnEkJ0DgqLtC7GS4uiXY5SBpHoxBSoAUPpps0A4kiZI2ggMf4Jkx/Hn+PauNSVAw=
X-Gm-Message-State: AOJu0YxM5u+s3USrM7mVV/7tS6QtWpy8FU7KJ8dQU4Tp1ptV0yrGuaHo
 mbrj2SSn9Do/ajwAG4IelX8KbHhhin29P30qFOhugDNqQeHLaYvB1HmLxOL6rEA=
X-Google-Smtp-Source: AGHT+IERerCxokz8+D/FbT/9E30WbZvkfYabKYLyD3SVTlxujbc2Pt+i+/EPSRs2REYhlf7LnQG5bg==
X-Received: by 2002:a05:651c:1a0f:b0:2ee:87ce:c863 with SMTP id
 38308e7fff4ca-2ee8edff05emr20226921fa.32.1720115696036; 
 Thu, 04 Jul 2024 10:54:56 -0700 (PDT)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1d510bsm32914735e9.3.2024.07.04.10.54.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 10:54:55 -0700 (PDT)
Date: Thu, 4 Jul 2024 18:55:08 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v4 01/19] hw/arm/smmu-common: Add missing size check for
 stage-1
Message-ID: <20240704175508.GA1693268@myrica>
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-2-smostafa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240701110241.2005222-2-smostafa@google.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=jean-philippe@linaro.org; helo=mail-lj1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Jul 01, 2024 at 11:02:23AM +0000, Mostafa Saleh wrote:
> According to the SMMU architecture specification (ARM IHI 0070 F.b),
> in “3.4 Address sizes”
>     The address output from the translation causes a stage 1 Address Size
>     fault if it exceeds the range of the effective IPA size for the given CD.
> 
> However, this check was missing.
> 
> There is already a similar check for stage-2 against effective PA.
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  hw/arm/smmu-common.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 1ce706bf94..eb2356bc35 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -381,6 +381,16 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
>              goto error;
>          }
>  
> +        /*
> +         * The address output from the translation causes a stage 1 Address
> +         * Size fault if it exceeds the range of the effective IPA size for
> +         * the given CD.
> +         */
> +        if (gpa >= (1ULL << cfg->oas)) {
> +            info->type = SMMU_PTW_ERR_ADDR_SIZE;
> +            goto error;
> +        }
> +
>          tlbe->entry.translated_addr = gpa;
>          tlbe->entry.iova = iova & ~mask;
>          tlbe->entry.addr_mask = mask;
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 

