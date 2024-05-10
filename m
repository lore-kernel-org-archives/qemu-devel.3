Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF776C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 17:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5U2a-0004Xr-Ru; Fri, 10 May 2024 13:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5U2Z-0004Xf-Ga
 for qemu-devel@nongnu.org; Fri, 10 May 2024 13:28:15 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5U2X-0004Ez-UY
 for qemu-devel@nongnu.org; Fri, 10 May 2024 13:28:15 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-51aa6a8e49aso2890863e87.3
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 10:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715362092; x=1715966892; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vR9nXVWLEOzjPn5kDxpTCuv4QCdc05kNgOMi32amDhc=;
 b=OVEbE5C3fLMzDfPgegbgpY3HRUpl9X+oLm+P54+Y8FWPOzxx5kPLkW14O6Sr2HVIAH
 f0Et367zdyGtQVZr4uLS96cJM96VOjXSUPiBntfqU5nq2x1E0HpbOlk5wn0F3k0pJkMb
 u7X70DZ7Ok9YEu45xJYU3yxA6ZDqEHdOewlheN9WYnqde/Ya4bWJ1wWUyor77FLNPIh1
 QKLh9S+DmiqzdO6b2JbReZ0spzo1eL+VFCu83CYCbmx+vMzUrAI/6p3dlw5d0BBtoAJc
 4NiGaWZ/ve63iOiGakQ/HryuEi2dVS4hXplNjfhvMS1pbpVd9UQ+X4kpPkNH0bG+1vUr
 R+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715362092; x=1715966892;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vR9nXVWLEOzjPn5kDxpTCuv4QCdc05kNgOMi32amDhc=;
 b=MvvVYBc4jRPwKJFCtSezB3I5sxJjP0Eiw7Pd39g+WknK1mXL8UPY2kWPSSwkvHgmb1
 L+RH8GQNRZ5MspTr8hMjw62clQLo13V63g3NsF4O7GwNiAX8gbJzXVGQ580rwABf0nlk
 /pVIXxWQQxhRVck2HSBzFFLyHFd/orymn8k2O7UxLQ1Mgs4tlVqeinaIarmuy9ZE2ty3
 jhXT3ytfU/zOuddqzvwjAXvnRY18OuomiYeuWziAKu8kQbIRRHhKC7Wjwm7Lp1RV/q0O
 9UprlEbx+5j7oLs3z6s88+dxf+ptjXeALJwrIWz6HZPjc7HLDbbH2wKsZWCFEydOWQvN
 aRBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDILRQDWqKbEnrWjnK9aGmJhLYJYwADDicl7T3AwKRUDf4l1UyWSXNvlGyoOe8nubwrEiMPO42e6viFxvEJLU7eufSJ04=
X-Gm-Message-State: AOJu0YxRu8KRx89c/iaqC26j5by+cW7GwFLOU/UMiYCcnqWCG+WbhBLS
 4qLuX6zhxBsAMw/n9Gp4JcduHLN8dpGLhfN57nCXzePKKl+fPNIiyryjuydPjA69MyaXznTiu4r
 B
X-Google-Smtp-Source: AGHT+IGgNbJUTTy0vnJStDSVDq8ZVfxWYYez/Se8J46flL7ooueuuyabT9PLWIYyyUPGaYCM59rhOw==
X-Received: by 2002:a05:6512:33ce:b0:513:edf4:6f20 with SMTP id
 2adb3069b0e04-5220fe79457mr2339675e87.54.1715362091990; 
 Fri, 10 May 2024 10:28:11 -0700 (PDT)
Received: from [192.168.69.100] (sev93-h02-176-184-17-152.dsl.sta.abo.bbox.fr.
 [176.184.17.152]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-521f35ba3e1sm755252e87.66.2024.05.10.10.28.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 10:28:11 -0700 (PDT)
Message-ID: <f44a4dd3-6cbc-4115-a0da-9b4334bca7ae@linaro.org>
Date: Fri, 10 May 2024 19:28:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/41] target/sparc: Implement PDISTN
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com
References: <20240302051601.53649-1-richard.henderson@linaro.org>
 <20240302051601.53649-29-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240302051601.53649-29-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
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

On 2/3/24 06:15, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/translate.c  | 11 +++++++++++
>   target/sparc/insns.decode |  1 +
>   2 files changed, 12 insertions(+)


> +static void gen_op_pdistn(TCGv dst, TCGv_i64 src1, TCGv_i64 src2)
> +{
> +#ifdef TARGET_SPARC64
> +    gen_helper_pdist(dst, tcg_constant_i64(0), src1, src2);

I node pdist[n] could benefit from gvec.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


